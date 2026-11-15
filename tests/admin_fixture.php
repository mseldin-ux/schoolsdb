<?php

declare(strict_types=1);

require_once dirname(__DIR__) . '/includes/config.php';

function adminTestDb(): mysqli
{
    if (schoolsConfig()['db']['name'] !== 'schools_test') {
        throw new RuntimeException('Refusing to reset fixtures outside schools_test.');
    }
    return schoolsDbConnect();
}

function adminTestSeed(mysqli $db): void
{
    if ($db->query('SELECT DATABASE()')->fetch_row()[0] !== 'schools_test') {
        throw new RuntimeException('Refusing to seed a non-test database.');
    }
    foreach (['schoolreviews', 'schools_backup', 'actionslog', 'users', 'schools'] as $table) {
        $db->query("DELETE FROM `$table`");
        $db->query("ALTER TABLE `$table` AUTO_INCREMENT = 1");
    }
    $stmt = $db->prepare(
        'INSERT INTO schools (id, schoolname, address1, city, stateprovince, country, infoemail, web,
         schooltype, infants, approved, deleted, lat, lng, lastmodifiedby, recpass)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
    );
    foreach ([
        [1, 'Owner School', '1 Test Lane', 'Testville', 'Vermont', 'United States', 'owner@example.test', 'example.test', 'Private', 12, 1, 0, 44.1, -72.1, 'manager', 'private-record-password'],
        [2, 'Other School', '2 Test Lane', 'Testville', 'Vermont', 'United States', 'other@example.test', 'example.test', 'Private', 8, 1, 0, 44.2, -72.2, 'admin', ''],
        [3, 'Deleted School', '3 Test Lane', 'Testville', 'Vermont', 'United States', 'old@example.test', 'example.test', 'Private', 0, 1, 1, null, null, 'manager', ''],
    ] as $row) {
        $stmt->bind_param(str_repeat('s', count($row)), ...$row);
        $stmt->execute();
    }
    $stmt = $db->prepare(
        'INSERT INTO users (userid, schoolid, username, password, privlevel, added) VALUES (?, ?, ?, ?, ?, NOW())'
    );
    foreach ([[1, 1, 'owner', 'test-password', 1], [2, 0, 'reviewer', 'test-password', 5],
        [3, 0, 'manager', 'test-password', 9], [4, 0, 'admin', 'test-password', 10],
        [5, 1, 'retired', 'test-password', 7]] as $row) {
        $stmt->bind_param('iissi', ...$row);
        $stmt->execute();
    }
}

if (PHP_SAPI === 'cli' && realpath($_SERVER['SCRIPT_FILENAME']) === __FILE__) {
    if (($argv[1] ?? '') === '--reset') {
        adminTestSeed(adminTestDb());
        echo "Reset schools_test fixtures.\n";
        exit;
    }
    $destination = $argv[1] ?? '';
    if ($destination === '') {
        throw new RuntimeException('Supply the external test config destination.');
    }
    $config = schoolsConfig();
    $source = $config['db']['name'];
    if ($source === 'schools_test' || !preg_match('/^[a-zA-Z0-9_]+$/D', $source)) {
        throw new RuntimeException('Fixture setup needs a non-test source database with a simple name.');
    }
    $db = schoolsDbConnect();
    $db->query('CREATE DATABASE IF NOT EXISTS schools_test CHARACTER SET utf8mb4');
    foreach (['schools', 'schools_backup', 'schoolreviews', 'users', 'actionslog'] as $table) {
        $db->query("CREATE TABLE IF NOT EXISTS schools_test.`$table` LIKE `$source`.`$table`");
    }
    $db->select_db('schools_test');
    adminTestSeed($db);
    $config['db']['name'] = 'schools_test';
    $config['import_file'] = '';
    if (file_put_contents($destination, '<?php return ' . var_export($config, true) . ";\n") === false) {
        throw new RuntimeException('Could not write test configuration.');
    }
    chmod($destination, 0600);
    echo "Prepared schools_test (synthetic data only).\n";
}
