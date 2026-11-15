<?php

declare(strict_types=1);

header('Content-Type: application/json; charset=utf-8');

$bounds = [];
foreach (['swlat', 'nelat', 'swlng', 'nelng'] as $name) {
    $value = filter_input(INPUT_GET, $name, FILTER_VALIDATE_FLOAT);
    if ($value === false || $value === null) {
        http_response_code(400);
        echo json_encode(['error' => "Invalid map bound: {$name}"]);
        exit;
    }
    $bounds[$name] = (float) $value;
}

if (
    $bounds['swlat'] < -90 || $bounds['nelat'] > 90
    || $bounds['swlng'] < -180 || $bounds['swlng'] > 180
    || $bounds['nelng'] < -180 || $bounds['nelng'] > 180
    || $bounds['swlat'] > $bounds['nelat']
) {
    http_response_code(400);
    echo json_encode(['error' => 'Map bounds are outside valid coordinate ranges.']);
    exit;
}

require __DIR__ . '/dbinfo.inc.php';
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

try {
    $database = new mysqli($dbhost, $username, $password, $dbname);
    $database->set_charset('utf8mb4');
    $longitudeCondition = $bounds['swlng'] <= $bounds['nelng']
        ? 'lng BETWEEN ? AND ?'
        : '(lng >= ? OR lng <= ?)';
    $statement = $database->prepare(
        'SELECT id, schoolname AS name, address1 AS address, city, stateprovince, lat AS latitude, lng AS longitude '
        . 'FROM schools WHERE lat BETWEEN ? AND ? AND ' . $longitudeCondition . ' ORDER BY schoolname'
    );
    $statement->bind_param(
        'dddd',
        $bounds['swlat'],
        $bounds['nelat'],
        $bounds['swlng'],
        $bounds['nelng']
    );
    $statement->execute();
    $schools = $statement->get_result()->fetch_all(MYSQLI_ASSOC);
    echo json_encode(
        ['datarray' => $schools],
        JSON_INVALID_UTF8_SUBSTITUTE | JSON_THROW_ON_ERROR
    );
} catch (mysqli_sql_exception | JsonException $exception) {
    error_log('School map data request failed: ' . $exception->getMessage());
    http_response_code(500);
    echo json_encode(['error' => 'School map data is unavailable.']);
}
