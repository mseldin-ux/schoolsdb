<?php

declare(strict_types=1);

require_once dirname(__DIR__) . '/CGMSDBObj.php';
require_once dirname(__DIR__) . '/CGMSDBForm.php';
require_once __DIR__ . '/NominatimGeocoder.php';

final class AdminHttpException extends RuntimeException
{
    public function __construct(public readonly int $status, string $message)
    {
        parent::__construct($message);
    }
}

function adminEscape(mixed $value): string
{
    return htmlspecialchars((string) $value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}

function adminInput(string $name, string $default = ''): string
{
    $value = $_REQUEST[$name] ?? $default;
    if (!is_string($value)) {
        throw new AdminHttpException(400, "Invalid input: $name");
    }
    return $value;
}

function adminId(string $name = 'id'): int
{
    $value = filter_var(adminInput($name), FILTER_VALIDATE_INT, ['options' => ['min_range' => 1]]);
    if ($value === false) {
        throw new AdminHttpException(400, "A positive integer is required for $name.");
    }
    return $value;
}

function adminCsrf(): string
{
    return $_SESSION['csrf'] ??= bin2hex(random_bytes(32));
}

function adminCsrfField(): string
{
    return '<input type="hidden" name="csrf" value="' . adminCsrf() . '">';
}

function adminRequirePost(): void
{
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        header('Allow: POST');
        throw new AdminHttpException(405, 'This action requires POST.');
    }
    if (!hash_equals(adminCsrf(), adminInput('csrf'))) {
        throw new AdminHttpException(403, 'Invalid or expired form token. Reload the form and try again.');
    }
}

function adminRole(): int
{
    return (int) ($_SESSION['role'] ?? 0);
}

function adminLoadSchool(int $id): CGMSDBObj
{
    $school = new CGMSDBObj('schools');
    $school->setUpTable();
    if (!$school->getRow($id)) {
        throw new AdminHttpException(404, 'School not found.');
    }
    return $school;
}

function adminAuthorize(string $action): void
{
    $role = adminRole();
    $minimum = [
        'adminlist' => 5, 'addreview' => 5, 'updatereview' => 5,
        'create' => 9, 'add' => 9, 'delete' => 9, 'restore' => 9,
        'export' => 10, 'geocode' => 10,
    ];
    if (isset($minimum[$action]) && $role < $minimum[$action]) {
        throw new AdminHttpException(403, 'You do not have permission for this action.');
    }
    if (in_array($action, ['edit', 'update'], true)) {
        $id = adminId();
        if ($role < 9 && !($role === 1 && $id === (int) $_SESSION['schoolid'])) {
            throw new AdminHttpException(403, 'You may only edit your own school.');
        }
    }
}

function adminLog(string $action): void
{
    $details = [];
    foreach ($_REQUEST as $key => $value) {
        $details[$key] = preg_match('/pass|secret|csrf|token/i', (string) $key) ? '[REDACTED]' : $value;
    }
    $log = new CGMSDBObj('actionslog');
    $log->setUpTable();
    $log->setValue('userid', $_SESSION['userid'] ?? 0);
    $log->setValue('action', $action);
    $log->setValue('details', json_encode($details, JSON_THROW_ON_ERROR | JSON_INVALID_UTF8_SUBSTITUTE));
    $error = $log->insert();
    if ($error) {
        throw new RuntimeException('Could not write the action log.');
    }
}

function adminAddress(CGMSDBObj $school): array
{
    $address = [];
    foreach (['address1', 'address2', 'city', 'stateprovince', 'zippostal', 'country'] as $field) {
        $address[$field] = (string) $school->getValue($field);
    }
    return $address;
}

function adminGeocode(CGMSDBObj $school): string
{
    try {
        $coordinates = (new NominatimGeocoder())->geocode(adminAddress($school));
    } catch (RuntimeException $error) {
        error_log('School geocoding failed: ' . $error->getMessage());
        $coordinates = null;
    }
    $school->setValue('lat', $coordinates['lat'] ?? null);
    $school->setValue('lng', $coordinates['lng'] ?? null);
    if ($coordinates === null) {
        return 'Warning: address lookup failed; the school was saved without coordinates.';
    }
    return $coordinates['precision'] === 'address' ? ''
        : 'Warning: approximate location saved (' . $coordinates['precision']
            . " level); this is not the school's exact address.";
}

function adminMissingCoordinatesSql(): string
{
    return '(lat IS NULL OR lng IS NULL OR lat NOT BETWEEN -90 AND 90'
        . ' OR lng NOT BETWEEN -180 AND 180 OR (lat = 0 AND lng = 0))';
}

function adminRetryGeocode(int $id): ?string
{
    $school = adminLoadSchool($id);
    $school->mysqli->begin_transaction();
    try {
        if (!$school->selectSQL('id = ? AND COALESCE(deleted, 0) = 0 AND '
            . adminMissingCoordinatesSql() . ' FOR UPDATE', 0, 0, [$id])) {
            $school->mysqli->rollback();
            return null;
        }
        adminBackup($school);
        $warning = adminGeocode($school);
        $school->setValue('lastmodified', date('Y-m-d H:i:s'));
        $school->setValue('lastmodifiedby', $_SESSION['username'] ?? 'CLI');
        if ($school->update()) {
            throw new RuntimeException('Geocoding update failed.');
        }
        $school->mysqli->commit();
        return $warning;
    } catch (Throwable $error) {
        $school->mysqli->rollback();
        throw $error;
    }
}

function adminForm(): CGMSDBForm
{
    return new CGMSDBForm(dirname(__DIR__) . '/templates/schooltemplates.txt');
}

function adminSchoolForm(bool $new): void
{
    $school = $new ? new CGMSDBObj('schools') : adminLoadSchool(adminId());
    if (!$new) {
        $school->setValue('stateprovince', NominatimGeocoder::normalizeProvince((string) $school->getValue('stateprovince')));
    }
    if ($new) {
        $school->setUpTable();
        $school->setValue('country', 'United States');
        $school->setValue('schooltype', 'Unknown');
    }
    $form = adminForm();
    if (adminRole() === 1) {
        $form->templates['editandnew'] = preg_replace(
            '/<tr><td>schooltype<\/td><td><select name="schooltype">.*?<\/select> <\/td><\/tr>/s',
            '', $form->templates['editandnew']
        );
    }
    $adminOptions = '';
    if (adminRole() >= 9) {
        $adminOptions = '<a href="?action=adminlist">Admin list</a>';
        if (!$new) {
            $restore = (bool) $school->getValue('deleted');
            $adminOptions .= ' <button type="submit" form="school-delete">'
                . ($restore ? 'Restore School' : 'Delete School') . '</button>';
            echo '<form id="school-delete" method="post" action="controller.php">'
                . adminCsrfField() . '<input type="hidden" name="action" value="' . ($restore ? 'restore' : 'delete')
                . '"><input type="hidden" name="id" value="' . (int) $school->getValue('id') . '"></form>';
        }
    }
    echo '<h1>' . ($new ? 'Create' : 'Edit') . ' School</h1>';
    echo '<form action="controller.php" method="post" id="editandnewform">' . adminCsrfField()
        . '<input type="hidden" name="action" value="' . ($new ? 'add' : 'update') . '">';
    if ($new) {
        $token = bin2hex(random_bytes(24));
        $_SESSION['create_tokens'][$token] = time();
        $_SESSION['create_tokens'] = array_filter(
            $_SESSION['create_tokens'], static fn (int $created): bool => $created > time() - 3600
        );
        echo '<input type="hidden" name="create_token" value="' . $token . '">';
    }
    $form->setOneTimeValue('recuserinfoplaceholder', adminRole() >= 9
        ? $form->getTemplateAsString('recuserinfo', $school) : '');
    $form->setOneTimeValue('adminoptions', $adminOptions);
    $form->setOneTimeValue('modifiedbyname', adminEscape($school->getValue('lastmodifiedby')));
    $form->renderTemplate('editandnew', $school);
    echo '<button type="submit">Save School</button></form>';
}

function adminApplySchoolInput(CGMSDBObj $school, bool $new): void
{
    $form = adminForm();
    preg_match_all('/name="([a-z0-9_]+)"/i', $form->templates['editandnew'], $matches);
    $allowed = array_unique(array_merge($matches[1], array_keys($form->checklists)));
    $blocked = ['id', 'deleted', 'deleteddate', 'lastmodified', 'lastmodifiedby', 'lat', 'lng'];
    if (adminRole() === 1) {
        $blocked = array_merge($blocked, ['approved', 'schooltype', 'recuser', 'recpass', 'recsecretq', 'recsecreta']);
    } else {
        $allowed = array_merge($allowed, ['recuser', 'recpass', 'recemail', 'recsecretq', 'recsecreta']);
    }
    foreach (array_diff($allowed, $blocked) as $field) {
        if (!array_key_exists($field, $school->fieldtypes)) {
            continue;
        }
        if (array_key_exists($field, $_POST)) {
            $value = adminInput($field);
            if ($field === 'stateprovince' && $value === 'Outside US and Canada') {
                $value = adminInput('altstateprovince');
            }
            if ($field === 'stateprovince') {
                $value = NominatimGeocoder::normalizeProvince($value);
            }
            if ($field === 'web') {
                $value = preg_replace('~^https?://~i', '', trim($value));
            }
            if ($school->fieldtypes[$field] !== 's' && !isset($form->checklists[$field])
                && $value !== '' && !is_numeric($value)) {
                throw new AdminHttpException(422, "Invalid numeric value for $field.");
            }
            $school->setValue($field, $value);
        } elseif (isset($form->checklists[$field])) {
            $school->setValue($field, 0);
        }
    }
    foreach (['schoolname', 'address1', 'city', 'infoemail', 'web'] as $field) {
        if (trim((string) $school->getValue($field)) === '') {
            throw new AdminHttpException(422, "Required field is missing: $field. UNKNOWN is allowed.");
        }
    }
    if ($new) {
        $school->setValue('schooltype', $school->getValue('schooltype') ?: 'Unknown');
        $school->setValue('country', $school->getValue('country') ?: 'United States');
        $school->setValue('deleted', 0);
    }
    $school->setValue('lastmodifiedby', $_SESSION['username']);
    $school->setValue('lastmodified', date('Y-m-d H:i:s'));
}

function adminBackup(CGMSDBObj $school): void
{
    $backup = new CGMSDBObj('schools_backup', $school->mysqli);
    $backup->setUpTable();
    foreach ($school->getFieldNames() as $field) {
        $target = $field === 'id' ? 'origid' : $field;
        if (array_key_exists($target, $backup->fieldtypes)) {
            $backup->setValue($target, $school->getValue($field));
        }
    }
    if ($backup->insert()) {
        throw new RuntimeException('School backup failed.');
    }
}

function adminSaveSchool(bool $new): void
{
    $school = $new ? new CGMSDBObj('schools') : adminLoadSchool(adminId());
    if ($new) {
        $school->setUpTable();
        $token = adminInput('create_token');
        if (!isset($_SESSION['create_tokens'][$token])
            || $_SESSION['create_tokens'][$token] < time() - 3600) {
            throw new AdminHttpException(409, 'This create form was already submitted or has expired.');
        }
    }
    $school->mysqli->begin_transaction();
    try {
        if (!$new) {
            if (!$school->selectSQL('id = ? FOR UPDATE', 0, 0, [adminId()])) {
                throw new AdminHttpException(404, 'School no longer exists.');
            }
        }
        $before = $school->fieldvalues;
        $oldAddress = adminAddress($school);
        adminApplySchoolInput($school, $new);
        $needsGeocoding = $new || $oldAddress !== adminAddress($school)
            || $school->getValue('lat') === null || $school->getValue('lng') === null;
        $warning = $needsGeocoding ? adminGeocode($school) : '';
        if (!$new) {
            $snapshot = new CGMSDBObj('schools', $school->mysqli);
            $snapshot->setUpTable();
            $snapshot->fieldvalues = $before;
            adminBackup($snapshot);
        }
        $error = $new ? $school->insert() : $school->update();
        if ($error) {
            throw new RuntimeException('School save failed.');
        }
        $school->mysqli->commit();
    } catch (Throwable $error) {
        $school->mysqli->rollback();
        throw $error;
    }
    if ($new) {
        unset($_SESSION['create_tokens'][$token]);
    }
    echo '<h2>Saved school ' . (int) $school->getValue('id') . '</h2>';
    if ($warning !== '') {
        echo '<p role="alert">' . adminEscape($warning) . '</p>';
    }
    echo '<a href="?action=edit&amp;id=' . (int) $school->getValue('id') . '">Return to school</a>';
}

function adminSetDeleted(bool $deleted): void
{
    $school = adminLoadSchool(adminId());
    $school->mysqli->begin_transaction();
    try {
        if (!$school->selectSQL('id = ? FOR UPDATE', 0, 0, [adminId()])) {
            throw new AdminHttpException(404, 'School no longer exists.');
        }
        adminBackup($school);
        $school->setValue('deleted', $deleted ? 1 : 0);
        $school->setValue('deleteddate', $deleted ? date('Y-m-d H:i:s') : null);
        $school->setValue('lastmodifiedby', $_SESSION['username']);
        $school->setValue('lastmodified', date('Y-m-d H:i:s'));
        if ($school->update()) {
            throw new RuntimeException('School deletion status could not be saved.');
        }
        $school->mysqli->commit();
    } catch (Throwable $error) {
        $school->mysqli->rollback();
        throw $error;
    }
    echo '<h2>' . ($deleted ? 'Deleted' : 'Restored') . ' school</h2><a href="?action=adminlist">Admin list</a>';
}

function adminReview(bool $new): void
{
    $review = new CGMSDBObj('schoolreviews');
    $review->setUpTable();
    if (!$new && !$review->getRow(adminId('reviewid'))) {
        throw new AdminHttpException(404, 'Review not found.');
    }
    $school = adminLoadSchool($new ? adminId('schoolid') : (int) $review->getValue('schoolid'));
    if ($school->getValue('deleted')) {
        throw new AdminHttpException(409, 'Restore this school before reviewing it.');
    }
    $status = adminInput('reviewstatus');
    if (!in_array($status, adminForm()->templates['list-reviewstatus'], true)) {
        throw new AdminHttpException(422, 'Invalid review status.');
    }
    $review->setValue('schoolid', $school->getValue('id'));
    $review->setValue('reviewstatus', $status);
    $review->setValue('comments', adminInput('comments'));
    $review->setValue('reviewdate', date('Y-m-d H:i:s'));
    $review->setValue('userid', $_SESSION['userid']);
    if ($new ? $review->insert() : $review->update()) {
        throw new RuntimeException('Review save failed.');
    }
    adminReviewXml('OK', 0, (int) $review->getValue('reviewid'));
}

function adminReviewXml(string $message, int $code, int $id = 0): void
{
    header('Content-Type: application/xml; charset=UTF-8');
    $escape = static fn (string $value): string => htmlspecialchars($value, ENT_XML1 | ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
    echo '<?xml version="1.0" encoding="UTF-8"?><Result><ResultCode>' . $code
        . '</ResultCode><ResultMsg>' . $escape($message) . '</ResultMsg><ResultDate>'
        . date('Y-m-d H:i:s') . '</ResultDate><ResultID>' . $id . '</ResultID></Result>';
}
