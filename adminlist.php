<?php
if (!defined('SCHOOLS_ADMIN_REQUEST')) {
    http_response_code(403);
    exit('Use controller.php.');
}

$db = new CGMSDBObj('schools');
$db->setUpTable();
$sort = adminInput('sort', 'schoolname');
$keywords = trim(adminInput('keywords'));
$idtarget = trim(adminInput('idtarget'));
$start = max(0, (int) adminInput('start', '0'));
$max = min(100, max(1, (int) adminInput('max', '40')));
$deleted = adminInput('deleted', '0') === '1';
$missingLocation = adminInput('missinglocation', '0') === '1';
if ($deleted && adminRole() < 9) {
    throw new AdminHttpException(403, 'Only managers and admins may view deleted schools.');
}
$conditions = ['COALESCE(deleted, 0) = ?'];
$params = [$deleted ? 1 : 0];
if ($missingLocation) {
    $conditions[] = adminMissingCoordinatesSql();
}
$order = match ($sort) {
    'id' => 'id ASC', 'recent' => 'lastmodified DESC, id ASC',
    'oldest' => 'lastmodified ASC, id ASC',
    'schoolname', 'name', 'search', 'mine', 'unreviewed' => 'schoolname ASC, id ASC',
    default => throw new AdminHttpException(400, 'Invalid sort.'),
};
$subsort = adminInput('subsort');
if ($subsort !== '') {
    if (!in_array($subsort, ['id', 'schoolname', 'web', 'stateprovince', 'country'], true)) {
        throw new AdminHttpException(400, 'Invalid secondary sort.');
    }
    $order = "`$subsort` ASC, id ASC";
}
if ($sort === 'mine') {
    $conditions[] = '(lastmodifiedby = ? OR EXISTS (SELECT 1 FROM schoolreviews r WHERE r.schoolid = schools.id AND r.userid = ?))';
    array_push($params, $_SESSION['username'], $_SESSION['userid']);
}
if ($sort === 'unreviewed') {
    $conditions[] = "(NOT EXISTS (SELECT 1 FROM schoolreviews r WHERE r.schoolid = schools.id) OR EXISTS
        (SELECT 1 FROM schoolreviews r WHERE r.schoolid = schools.id AND r.reviewstatus = 'Unreviewed'))";
}
if ($keywords !== '') {
    foreach (preg_split('/\s+/', $keywords) as $word) {
        $matches = [];
        foreach (['schoolname', 'recemail', 'address1', 'city', 'country', 'stateprovince', 'schooltype', 'web'] as $field) {
            $matches[] = "`$field` LIKE ?";
            $params[] = '%' . $word . '%';
        }
        $conditions[] = '(' . implode(' OR ', $matches) . ')';
    }
}
if ($idtarget !== '') {
    if (preg_match('/^\d+(?:\s+\d+)*$/D', $idtarget)) {
        $ids = preg_split('/\s+/', $idtarget);
        $conditions[] = 'id IN (' . implode(', ', array_fill(0, count($ids), '?')) . ')';
        array_push($params, ...$ids);
    } else {
        preg_match_all('/(>=|<=|>|<|=)\s*(\d+)/', $idtarget, $matches, PREG_SET_ORDER);
        if ($matches === [] || trim(preg_replace('/(>=|<=|>|<|=)\s*\d+/', '', $idtarget)) !== '') {
            throw new AdminHttpException(400, 'ID search accepts space-separated IDs or comparisons such as >100 <200.');
        }
        foreach ($matches as $match) {
            $conditions[] = 'id ' . $match[1] . ' ?';
            $params[] = $match[2];
        }
    }
}
$where = implode(' AND ', $conditions);
$count = $db->countRows($where, $params);
$found = $db->selectSQL($where . ' ORDER BY ' . $order, $start, $max, $params);
$query = ['action' => 'adminlist', 'sort' => $sort, 'keywords' => $keywords,
    'idtarget' => $idtarget, 'max' => $max, 'deleted' => $deleted ? '1' : '0', 'subsort' => $subsort,
    'missinglocation' => $missingLocation ? '1' : '0'];
?>
<h1><?= $deleted ? 'Deleted Schools' : 'Admin List' ?></h1>
<nav>
<?php foreach (['id' => 'ID', 'schoolname' => 'Name', 'unreviewed' => 'Unreviewed',
    'recent' => 'Most recent', 'oldest' => 'Oldest', 'mine' => 'Show Mine Only'] as $value => $label): ?>
<a href="?action=adminlist&amp;sort=<?= $value ?>"><?= $label ?></a>
<?php endforeach; ?>
<?php if (adminRole() >= 9): ?>
<a href="?action=create">Create School</a>
<a href="?action=adminlist&amp;deleted=1">Deleted Schools</a>
<?php endif; ?>
<?php if (adminRole() === 10): ?>
<a href="?action=export">Export schools</a>
<form method="post" action="controller.php">
<?= adminCsrfField() ?><input type="hidden" name="action" value="geocode">
<button>Geocode schools with missing coordinates</button></form>
<?php endif; ?>
</nav>
<p><a href="?action=adminlist&amp;missinglocation=1">Schools without geolocations</a></p>
<form method="get" action="controller.php">
<input type="hidden" name="action" value="adminlist"><input type="hidden" name="sort" value="search">
<input type="hidden" name="deleted" value="<?= $deleted ? '1' : '0' ?>">
<label>Keywords <input name="keywords" value="<?= adminEscape($keywords) ?>"></label>
<label>ID search <input name="idtarget" value="<?= adminEscape($idtarget) ?>"></label>
<label>Page size <input name="max" type="number" min="1" max="100" value="<?= $max ?>"></label>
<label><input type="checkbox" name="missinglocation" value="1"<?= $missingLocation ? ' checked' : '' ?>> Missing geolocation only</label>
<button>Search</button></form>
<p>Showing <?= $count ? $start + 1 : 0 ?> to <?= min($start + $max, $count) ?> of <?= $count ?> records.</p>
<?php if ($start > 0): ?>
<a href="?<?= adminEscape(http_build_query(array_merge($query, ['start' => max(0, $start - $max)]))) ?>">Previous</a>
<?php endif; ?>
<?php if ($start + $max < $count): ?>
<a href="?<?= adminEscape(http_build_query(array_merge($query, ['start' => $start + $max]))) ?>">Next</a>
<?php endif; ?>
<?php if (!$found): ?>
<h2>No matches found.</h2>
<?php else: ?>
<style>
.school-list { width: 100%; border-spacing: 0 4px; }
.school-listing { background-color: #eeeeee; }
.school-listing > td { padding: 6px; vertical-align: top; }
.school-address { width: 22%; overflow-wrap: anywhere; }
.school-actions { width: 1%; white-space: nowrap; }
.school-action-controls { display: flex; gap: 6px; align-items: flex-start; }
.school-action-controls form { margin: 0; }
.school-reviews, .school-review-table { background-color: #ffffff; }
.school-reviews > td { padding: 0 6px 12px; }
.school-review-table td { padding: 4px; vertical-align: top; }
.school-review-table form { margin: 0; }
</style>
<table class="school-list"><thead><tr><th>ID</th><th>School</th><th>Website</th><th>Address</th><th>Last modified</th><th>Actions</th></tr></thead><tbody>
<?php
$reviews = new CGMSDBObj('schoolreviews');
$reviews->setUpTable();
do {
    $id = (int) $db->getValue('id');
    $website = preg_replace('~^https?://~i', '', (string) $db->getValue('web'));
    echo '<tr class="school-listing" data-school-id="' . $id . '"><td>' . $id . '</td><td>' . adminEscape($db->getValue('schoolname')) . '</td>'
        . '<td><a href="https://' . adminEscape($website) . '" target="_blank" rel="noopener noreferrer">'
        . adminEscape($website) . '</a></td><td class="school-address">' . adminEscape(implode(', ', array_filter(adminAddress($db)))) . '</td>'
        . '<td>' . adminEscape($db->getValue('lastmodified')) . ' by ' . adminEscape($db->getValue('lastmodifiedby')) . '</td><td class="school-actions"><div class="school-action-controls">';
    if (adminRole() >= 9) {
        echo '<form method="get" action="controller.php" target="_blank" rel="noopener"><input type="hidden" name="action" value="edit">'
            . '<input type="hidden" name="id" value="' . $id . '"><button type="submit">Edit</button></form>';
    }
    if (!$deleted) {
        echo '<button type="button" data-add-review aria-expanded="false" aria-controls="new-review-'
            . $id . '">Add New Review</button>';
    }
    if ($missingLocation && !$deleted && adminRole() === 10) {
        echo '<form method="post" action="controller.php">' . adminCsrfField()
            . '<input type="hidden" name="action" value="geocode"><input type="hidden" name="id" value="' . $id . '">'
            . '<button type="submit">Retry geolocation</button></form>';
    }
    if (adminRole() >= 9) {
        echo '<form method="post" action="controller.php"' . ($deleted ? '' : ' data-delete-school') . '>' . adminCsrfField()
            . '<input type="hidden" name="action" value="' . ($deleted ? 'restore' : 'delete') . '">'
            . '<input type="hidden" name="id" value="' . $id . '"><button type="submit">'
            . ($deleted ? 'Restore' : 'Delete') . '</button></form>';
    }
    echo '</div></td></tr>';
    if (!$deleted) {
        echo '<tr class="school-reviews" data-school-id="' . $id . '"><td></td><td colspan="5">'
            . '<table class="school-review-table" aria-label="Reviews for '
            . adminEscape($db->getValue('schoolname')) . '"><tbody>';
        $reviewCount = 0;
        if ($reviews->findRow(['schoolid' => $id], ['reviewdate' => 'DESC', 'reviewid' => 'DESC'])) {
            do {
                if ($reviewCount === 2) {
                    echo '<tr><td colspan="2"><details class="older-reviews"><summary>See older reviews</summary>'
                        . '<table class="school-review-table" aria-label="Older reviews"><tbody>';
                }
                echo adminReviewForm($id, $reviews);
                ++$reviewCount;
            } while ($reviews->nextRecordInSet());
        }
        if ($reviewCount > 2) {
            echo '</tbody></table></details></td></tr>';
        }
        echo adminReviewForm($id);
        echo '</tbody></table></td></tr>';
    }
} while ($db->nextRecordInSet());
?>
</tbody></table>
<?php endif; ?>
<script>
document.querySelectorAll('form[data-delete-school]').forEach(form => {
    form.addEventListener('submit', event => {
        if (!window.confirm('Delete this school? It can be restored from Deleted Schools.')) {
            event.preventDefault();
        }
    });
});
document.querySelectorAll('button[data-add-review]').forEach(button => {
    button.addEventListener('click', () => {
        const row = document.getElementById(button.getAttribute('aria-controls'));
        row.hidden = false;
        button.setAttribute('aria-expanded', 'true');
        row.querySelector('[name=comments]').focus();
    });
});
document.querySelectorAll('form[data-review]').forEach(form => {
    form.addEventListener('submit', async event => {
        event.preventDefault();
        const result = form.querySelector('[role=status]');
        const button = form.querySelector('button');
        button.disabled = true;
        try {
            const response = await fetch('controller.php', {method: 'POST', body: new FormData(form)});
            const xml = new DOMParser().parseFromString(await response.text(), 'application/xml');
            const message = xml.querySelector('ResultMsg')?.textContent;
            if (!response.ok || xml.querySelector('ResultCode')?.textContent !== '0') {
                throw new Error(message || 'Review could not be saved.');
            }
            form.elements.action.value = 'updatereview';
            form.elements.reviewid.value = xml.querySelector('ResultID').textContent;
            button.textContent = 'Update review';
            result.textContent = message + ' ' + xml.querySelector('ResultDate').textContent;
        } catch (error) {
            result.textContent = error.message;
        } finally {
            button.disabled = false;
        }
    });
});
</script>
<?php
function adminReviewForm(int $schoolId, ?CGMSDBObj $review = null): string
{
    $html = '<tr' . ($review ? '' : ' id="new-review-' . $schoolId . '" hidden') . '><td><small>'
        . adminEscape($review?->getValue('reviewdate') ?? 'New review')
        . '</small></td><td><form method="post" action="controller.php" data-review>' . adminCsrfField()
        . '<input type="hidden" name="action" value="' . ($review ? 'updatereview' : 'addreview') . '">'
        . '<input type="hidden" name="schoolid" value="' . $schoolId . '">'
        . '<input type="hidden" name="reviewid" value="' . (int) ($review?->getValue('reviewid') ?? 0) . '">'
        . '<label>Review status <select name="reviewstatus">';
    foreach (adminForm()->templates['list-reviewstatus'] as $status) {
        $html .= '<option' . ($review?->getValue('reviewstatus') === $status ? ' selected' : '')
            . '>' . adminEscape($status) . '</option>';
    }
    return $html . '</select></label><label>Comments <input name="comments" value="'
        . adminEscape($review?->getValue('comments') ?? '') . '" size="40"></label><button>'
        . ($review ? 'Update review' : 'Add review') . '</button><span role="status"></span></form></td></tr>';
}
