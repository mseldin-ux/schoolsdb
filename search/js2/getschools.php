<?php

declare(strict_types=1);

require_once __DIR__ . '/functions.php';
require_once dirname(__DIR__, 2) . '/includes/school-search.php';

header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');
set_time_limit(120);

const SCHOOL_COLUMNS = '`id`, `schoolname`, `address1`, `address2`, `city`, `stateprovince`, `zippostal`, `country`, `phone1label`, `phone1number`, `phone2label`, `phone2number`, `phone3label`, `phone3number`, `web`, `bilingual`, `horse`, `swimming`, `summerprogram`, `foreignlang`, `art`, `dance`, `drama`, `library`, `lunch`, `music`, `infants`, `toddlers`, `primary`, `lowerel`, `upperel`, `middle`, `highschool`, `affiliations`, `accreditations`, `lastmodified`, `lat`, `lng`, `recemail`, `infoemail`, `contactname`, `headofschoolname`, `montallday`, `numberstudents`, `transportation`, `outdoored`, `yearfounded`';

function requestText(string $name): string
{
    $value = $_REQUEST[$name] ?? '';
    return is_scalar($value) ? trim((string) $value) : '';
}

function requestCoordinate(string $name, float $limit): ?float
{
    $value = filter_var($_REQUEST[$name] ?? null, FILTER_VALIDATE_FLOAT);
    return $value === false || $value === null || abs($value) > $limit ? null : $value;
}

function respond(int $status, array $payload): never
{
    http_response_code($status);
    echo json_encode($payload, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE | JSON_INVALID_UTF8_SUBSTITUTE);
    exit;
}

/**
 * @return list<array<string, mixed>>
 */
function fetchRows(mysqli $db, string $sql, array $params): array
{
    $statement = $db->prepare($sql);
    if ($params !== []) {
        $statement->bind_param(str_repeat('s', count($params)), ...$params);
    }
    $statement->execute();
    return $statement->get_result()->fetch_all(MYSQLI_ASSOC);
}

function findSchools(mysqli $db): array
{
    $deleted = requestText('deleted') !== '' && requestText('deleted') !== 'false' ? '1' : '0';
    $zip = requestText('zip');
    $where = ['deleted = ?'];
    $params = [$deleted];

    if ($zip !== '') {
        $code = str_replace(['"', "'"], '', $zip);
        if (strlen($code) > 6) {
            $code = substr($code, 0, 5);
        }
        if (strlen($code) === 6) {
            $code = substr($code, 0, 3);
        }
        $postal = fetchRows($db, 'SELECT lat, lng FROM postalcodes WHERE code = ? LIMIT 1', [$code])[0] ?? null;
        $zipPrefix = addcslashes($zip, '%_\\') . '%';
        $lat = (float) ($postal['lat'] ?? 0);
        $lng = (float) ($postal['lng'] ?? 0);
        $swlat = $lat - 0.3;
        $nelat = $lat + 0.3;
        $swlng = $lng - 0.3;
        $nelng = $lng + 0.3;
        // Widen the box around the postal code until at least one school is found.
        for ($attempt = 0; $postal !== null && $attempt < 16; ++$attempt) {
            $count = fetchRows(
                $db,
                'SELECT COUNT(*) AS n FROM schools WHERE deleted = ? AND (zippostal LIKE ? OR (lat BETWEEN ? AND ? AND lng BETWEEN ? AND ?))',
                [$deleted, $zipPrefix, (string) $swlat, (string) $nelat, (string) $swlng, (string) $nelng]
            )[0]['n'];
            if ((int) $count > 0) {
                break;
            }
            $swlat -= 0.07;
            $nelat += 0.07;
            $swlng -= 0.07;
            $nelng += 0.07;
        }
        $where[] = '((lat BETWEEN ? AND ? AND lng BETWEEN ? AND ?) OR zippostal LIKE ?)';
        array_push($params, (string) $swlat, (string) $nelat, (string) $swlng, (string) $nelng, $zipPrefix);
    } else {
        $swlat = requestCoordinate('swlat', 90);
        $nelat = requestCoordinate('nelat', 90);
        $swlng = requestCoordinate('swlng', 180);
        $nelng = requestCoordinate('nelng', 180);
        if ($swlat === null || $nelat === null || $swlng === null || $nelng === null) {
            respond(400, ['error' => 'swlat, nelat, swlng and nelng must be valid coordinates.']);
        }
        $where[] = 'lat BETWEEN ? AND ?';
        array_push($params, (string) $swlat, (string) $nelat);
        if ($swlng <= $nelng) {
            $where[] = 'lng BETWEEN ? AND ?';
            array_push($params, (string) $swlng, (string) $nelng);
        } else {
            // The view crosses the antimeridian.
            $where[] = '(lng >= ? OR lng <= ?)';
            array_push($params, (string) $swlng, (string) $nelng);
        }
    }

    foreach (['country', 'city'] as $field) {
        $value = requestText($field);
        if ($value !== '') {
            $where[] = "$field = ?";
            $params[] = $value;
        }
    }

    $keywords = requestText('keywords');
    if ($keywords !== '') {
        $state = schoolStateFromKeywords($keywords);
        $words = $state === null ? $keywords : '';
        // "Burlington, VT" / "Burlington, Vermont": a trailing state after a comma filters by state.
        if ($state === null && preg_match('/^(.+),\s*([^,]+)$/', $keywords, $match)) {
            $state = schoolStateFromKeywords($match[2]);
            if ($state !== null) {
                $words = $match[1];
            }
        }
        if ($state !== null) {
            $where[] = 'stateprovince = ?';
            $params[] = $state;
        }
        $fields = ['schoolname', 'recemail', 'address1', 'city', 'country', 'stateprovince'];
        foreach (preg_split('/[\s,]+/', $words, -1, PREG_SPLIT_NO_EMPTY) as $word) {
            $like = '%' . addcslashes($word, '%_\\') . '%';
            $where[] = '(' . implode(' OR ', array_map(static fn (string $f): string => "$f LIKE ?", $fields)) . ')';
            array_push($params, ...array_fill(0, count($fields), $like));
        }
    }

    return fetchRows($db, 'SELECT ' . SCHOOL_COLUMNS . ' FROM schools WHERE ' . implode(' AND ', $where) . ' ORDER BY schoolname', $params);
}

function html(mixed $value): string
{
    return htmlspecialchars(trim((string) ($value ?? '')), ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8', false);
}

function formatSchool(array $row): array
{
    $address = html($row['address1']);
    if (trim((string) $row['address2']) !== '') {
        $address .= '<br/>' . html($row['address2']);
    }

    $phones = [];
    foreach ([1, 2, 3] as $n) {
        if (trim((string) $row["phone{$n}label"]) !== '') {
            $phones[] = html(str_replace(':', '', (string) $row["phone{$n}label"])) . ': ' . html($row["phone{$n}number"]);
        }
    }

    $flags = static function (array $labels) use ($row): string {
        $text = '';
        foreach ($labels as $column => $label) {
            if (!empty($row[$column])) {
                $text .= $label . '|';
            }
        }
        return $text;
    };

    $lastModified = strtotime((string) $row['lastmodified']);

    return [
        'latitude' => (float) $row['lat'],
        'longitude' => (float) $row['lng'],
        'id' => (int) $row['id'],
        'name' => html($row['schoolname']),
        'address' => $address,
        'city' => html($row['city']),
        'country' => html($row['country']),
        'stateprovince' => html($row['stateprovince']),
        'zippostal' => html($row['zippostal']),
        'phone' => implode('<br>', $phones),
        'year' => html($row['yearfounded']),
        'numberstudents' => html($row['numberstudents']),
        'email' => html($row['infoemail'] ?: $row['recemail']),
        'contact' => html($row['contactname'] ?: $row['headofschoolname']),
        'accreditations' => html($row['accreditations']),
        'affiliations' => html($row['affiliations']),
        'ages' => $flags([
            'infants' => 'Infants', 'toddlers' => 'Toddlers', 'primary' => 'Age 3-6', 'lowerel' => 'Grades 1-3',
            'upperel' => 'Grades 3-6', 'middle' => 'Grades 7-8', 'highschool' => 'High School',
        ]),
        'specials' => $flags([
            'bilingual' => 'Bilingual program', 'horse' => 'Horseback riding lessons', 'swimming' => 'Swimming lessons',
            'summerprogram' => 'Summer program', 'foreignlang' => 'One or more foreign languages',
            'art' => 'Art instruction', 'dance' => 'Dance instruction', 'drama' => 'Drama instruction',
            'library' => 'Library available', 'lunch' => 'Lunch provided', 'music' => 'Music program',
            'montallday' => 'All day montessori program', 'transportation' => 'Transportation available',
            'outdoored' => 'Outdoor education',
        ]),
        'lastmodified' => $lastModified === false ? '' : date('l, jS F Y', $lastModified),
        'web' => html(preg_replace('#^https?://#i', '', trim((string) $row['web']))),
    ];
}

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
try {
    $schools = array_map('formatSchool', findSchools(connect()));
} catch (mysqli_sql_exception $exception) {
    error_log('getschools.php query failed: ' . $exception->getMessage());
    respond(500, ['error' => 'School lookup failed.']);
}

respond(200, ['datarray' => $schools]);
