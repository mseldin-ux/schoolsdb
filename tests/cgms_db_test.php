<?php

declare(strict_types=1);

require_once dirname(__DIR__) . '/CGMSDBObj.php';

function check(bool $condition, string $message): void
{
    if (!$condition) {
        throw new RuntimeException($message);
    }
}

// Temporary tables are connection-local and disappear even if a test fails.
$db = new CGMSDBObj('schools_binding_test');
$db->mysqli->query(
    'CREATE TEMPORARY TABLE schools_binding_test (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(255),
        `library` INT,
        latitude FLOAT NULL
    ) CHARACTER SET utf8mb4'
);
$db->setUpTable();
$name = "O'Reilly \"School\" \\ campus " . "\u{00e9}";
$db->setValue('name', $name);
$db->setValue('library', 0);
$db->setValue('latitude', 12.5);
check($db->insert() === '', 'Insert failed.');
$first = (int) $db->getValue('id');
check($first > 0, 'Insert must expose its id.');
check($db->getRow($first), 'Inserted row not found.');
check($db->getValue('name') === $name, 'Quotes, backslashes or Unicode changed.');
check((int) $db->getValue('library') === 0, 'Explicit zero was lost.');
check(abs((float) $db->getValue('latitude') - 12.5) < 0.0001, 'Float changed.');
check($db->countRows(['name' => $name]) === 1, 'Bound count failed.');
check($db->countRows(['name' => "' OR 1=1 -- "]) === 0, 'Search treated a value as SQL.');
check(!$db->findRow(['name' => "' OR 1=1 -- "], []), 'Find treated a value as SQL.');
check($db->getValue('id') === null, 'Failed search retained stale row values.');

check($db->getRow($first), 'Could not reload row.');
$db->setValue('name', 'Updated school');
$db->setValue('library', 'on');
$db->setValue('latitude', null);
check($db->update() === '', 'Update failed.');
check($db->update() === '', 'No-op update failed.');
check($db->getRow($first), 'Updated row not found.');
check($db->getValue('latitude') === null, 'NULL was coerced to zero.');
check((int) $db->getValue('library') === 1, 'Checkbox conversion changed.');

$db->reset();
$db->setValue('name', 'Second school');
$db->setValue('library', 0);
check($db->insert() === '', 'Insert after reset failed.');
$second = (int) $db->getValue('id');
check($db->findRow([], ['id' => 'ASC']), 'Empty-condition select failed.');
check((int) $db->getValue('id') === $first, 'Find must load the first row.');
check($db->countRows([]) === 2, 'Count while iterating failed.');
check($db->nextRecordInSet(), 'Next row missing.');
check((int) $db->getValue('id') === $second, 'Cursor skipped or repeated a row.');
check(!$db->nextRecordInSet(), 'Cursor should be exhausted.');
check($db->findRow([], ['id' => 'ASC'], 1, 1), 'Pagination failed.');
check((int) $db->getValue('id') === $second, 'Offset/limit returned the wrong row.');
check(!$db->nextRecordInSet(), 'Limit was ignored.');
check($db->selectSQL('name = ?', 0, 0, ['Updated school']), 'Bound select failed.');
check((int) $db->getValue('id') === $first, 'Bound select returned the wrong row.');
check($db->countRows('name = ?', ['Updated school']) === 1, 'Raw bound count failed.');
check($db->selectSQL('', 1), 'Offset without limit failed.');
check((int) $db->getValue('id') === $second, 'Offset without limit returned the wrong row.');

foreach ([
    static fn () => $db->findRow([], ['id' => 'DESC; DROP TABLE schools']),
    static fn () => $db->findRow(['missing' => 'value'], []),
    static fn () => new CGMSDBObj('schools; DROP TABLE schools'),
] as $invalidQuery) {
    try {
        $invalidQuery();
        throw new RuntimeException('Invalid SQL identifier or direction was accepted.');
    } catch (InvalidArgumentException $expected) {
        // Expected: identifiers and directions cannot be bound as SQL values.
    }
}

check($db->getRow($first), 'Could not load row for delete.');
check($db->delete() === '', 'Delete failed.');
check(!$db->getRow($first), 'Deleted row still exists.');
check($db->countRows([]) === 1, 'Delete affected an unrelated row.');
$db->mysqli->close();
echo "PASS: prepared bindings, CRUD, NULL, Unicode, cursor and pagination\n";
