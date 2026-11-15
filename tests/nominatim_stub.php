<?php

header('Content-Type: application/json');
$query = $_GET['q'] ?? '';
$street = $_GET['street'] ?? '';
if (str_contains($query, 'FIRSTMATCH')) {
    echo '[{"lat":"44.5","lon":"-72.5"}]';
} elseif (str_contains($query, 'CITYMISMATCH')) {
    echo '[]';
} elseif (str_contains($street, 'CITYMISMATCH')) {
    echo !isset($_GET['city']) && ($_GET['postalcode'] ?? '') === '20906'
        && ($_GET['state'] ?? '') === 'Maryland' && ($_GET['country'] ?? '') === 'United States'
        ? '[{"lat":"39.0796949","lon":"-77.0466078"}]' : '[]';
} elseif (str_contains($query, 'HTTPFAIL')) {
    http_response_code(503);
    echo '{"error":"stub unavailable"}';
} elseif (str_contains($query, 'BADJSON')) {
    echo 'not-json';
} elseif (str_contains($query, 'NORESULT') || str_contains($street, 'NORESULT')) {
    echo '[]';
} elseif (str_contains($query, 'QUEBECTEST')) {
    echo str_contains($query, 'Quebec') ? '[{"lat":"46.8","lon":"-71.2"}]' : '[]';
} elseif (str_contains($query, 'OUTOFRANGE')) {
    echo '[{"lat":"91","lon":"-72.5"}]';
} elseif (str_contains($query, 'STREETONLY') || str_contains($query, 'CITYONLY') || str_contains($query, 'STATEONLY')) {
    echo '[]';
} elseif ($street === 'STREETONLY Road' && ($_GET['city'] ?? '') === 'Fallback City'
    && ($_GET['state'] ?? '') === 'Fallback State' && ($_GET['country'] ?? '') === 'Canada'
    && !isset($_GET['postalcode'])) {
    echo '[{"lat":"45","lon":"-73"}]';
} elseif (($_GET['city'] ?? '') === 'CITYONLY' && ($_GET['state'] ?? '') === 'Fallback State'
    && ($_GET['country'] ?? '') === 'Canada' && !isset($_GET['street']) && !isset($_GET['postalcode'])) {
    echo '[{"lat":"46","lon":"-74"}]';
} elseif (($_GET['state'] ?? '') === 'STATEONLY' && ($_GET['country'] ?? '') === 'Canada'
    && !isset($_GET['city']) && !isset($_GET['street']) && !isset($_GET['postalcode'])) {
    echo '[{"lat":"47","lon":"-75"}]';
} elseif ($query === '') {
    echo '[]';
} else {
    echo '[{"lat":"44.5","lon":"-72.5"}]';
}
