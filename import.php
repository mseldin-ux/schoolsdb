<?php

declare(strict_types=1);

if (PHP_SAPI !== 'cli') {
    http_response_code(403);
    exit('This import tool must be run from the command line.');
}
require_once __DIR__ . '/includes/admin.php';

$filename = $argv[1] ?? schoolsConfig()['import_file'] ?? '';
if ($filename === '' || !is_file($filename) || !is_readable($filename)) {
    fwrite(STDERR, "Usage: php import.php /path/to/schools.tsv (or configure import_file)\n");
    exit(1);
}
$handle = fopen($filename, 'r');
if ($handle === false) {
    throw new RuntimeException('Could not open the import file.');
}
try {
    $columns = fgetcsv($handle, 0, "\t", '"', '');
    if ($columns === false || !in_array('schoolname', $columns, true) || !in_array('address1', $columns, true)) {
        throw new RuntimeException('The import header must include schoolname and address1.');
    }
    $line = 1;
    while (($values = fgetcsv($handle, 0, "\t", '"', '')) !== false) {
        ++$line;
        if ($values === [null]) {
            continue;
        }
        if (count($values) !== count($columns)) {
            throw new RuntimeException("Incorrect column count on line $line.");
        }
        $row = array_combine($columns, $values);
        if (trim($row['schoolname']) === '' || trim($row['address1']) === '') {
            throw new RuntimeException("Missing school name or address on line $line.");
        }
        $school = new CGMSDBObj('schools');
        $school->setUpTable();
        $school->setValue('schooltype', 'Unknown');
        foreach ($school->getFieldNames() as $field) {
            if ($field !== 'id' && isset($row[$field]) && $row[$field] !== '') {
                $school->setValue($field, $row[$field]);
            }
        }
        $warning = adminGeocode($school);
        $school->mysqli->begin_transaction();
        try {
            if ($school->insert()) {
                throw new RuntimeException("School insert failed on line $line.");
            }
            if (!empty($row['username'])) {
                $user = new CGMSDBObj('users', $school->mysqli);
                $user->setUpTable();
                foreach (['username', 'password', 'firstname', 'lastname', 'email', 'secretq', 'secreta'] as $field) {
                    $user->setValue($field, $row[$field] ?? '');
                }
                $user->setValue('schoolid', $school->getValue('id'));
                $user->setValue('privlevel', 1);
                $user->setValue('added', date('Y-m-d H:i:s'));
                $user->setValue('lastupdated', date('Y-m-d H:i:s'));
                if ($user->insert()) {
                    throw new RuntimeException("User insert failed on line $line.");
                }
            }
            $school->mysqli->commit();
        } catch (Throwable $error) {
            $school->mysqli->rollback();
            throw $error;
        }
        echo 'Imported school ' . $school->getValue('id') . ($warning ? ": $warning" : '') . "\n";
    }
} finally {
    fclose($handle);
}
