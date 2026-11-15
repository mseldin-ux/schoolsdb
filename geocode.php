<?php
if (!defined('SCHOOLS_ADMIN_REQUEST')) {
    http_response_code(403);
    exit('Use controller.php.');
}
$schools = new CGMSDBObj('schools');
$schools->setUpTable();
$count = 0;
$where = adminMissingCoordinatesSql() . ' AND COALESCE(deleted, 0) = 0';
$params = [];
if (adminInput('id') !== '') {
    $where .= ' AND id = ?';
    $params[] = adminId();
}
if ($schools->selectSQL($where, 0, 0, $params)) {
    do {
        $id = (int) $schools->getValue('id');
        $warning = adminRetryGeocode($id);
        if ($warning === null) {
            echo '<p>School ' . $id . ': skipped; coordinates were already filled or the school was deleted.</p>';
            continue;
        }
        echo '<p' . ($warning !== '' ? ' role="alert"' : '') . '>School ' . $id . ': ' . adminEscape($warning ?: 'Geocoded') . '</p>';
        ++$count;
    } while ($schools->nextRecordInSet());
}
echo '<h2>Processed ' . $count . ' listings</h2>';
echo '<a href="?action=adminlist&amp;missinglocation=1">Return to schools without geolocations</a>';
