<?php
if (!defined('SCHOOLS_ADMIN_REQUEST')) {
    http_response_code(403);
    exit('Use controller.php.');
}
header('Content-Type: text/tab-separated-values; charset=UTF-8');
header('Content-Disposition: attachment; filename="schools.tsv"');
$schools = new CGMSDBObj('schools');
$schools->setUpTable();
$fields = $schools->getFieldNames();
// Recovery credentials are not part of a school-directory export.
$fields = array_values(array_diff($fields, ['recpass', 'recsecretq', 'recsecreta']));
echo implode("\t", $fields) . "\n";
if ($schools->selectSQL('COALESCE(deleted, 0) = 0')) {
    do {
        $row = [];
        foreach ($fields as $field) {
            $value = str_replace(["\t", "\r", "\n"], [' ', '', ', '], (string) $schools->getValue($field));
            if (!is_numeric($value) && preg_match('/^[=+@\x00-\x20-]/', $value)) {
                $value = "'" . $value;
            }
            $row[] = $value;
        }
        echo implode("\t", $row) . "\n";
    } while ($schools->nextRecordInSet());
}
