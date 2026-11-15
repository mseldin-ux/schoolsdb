<?php

if (PHP_SAPI !== 'cli') {
    http_response_code(403);
    exit('This maintenance script must be run from the command line.');
}

require_once __DIR__ . '/includes/NominatimGeocoder.php';

spl_autoload_register(static function (string $className): void {
    require_once __DIR__ . '/' . $className . '.php';
});
$c = new CGMSDBObj('schools');
$c->setUpTable();

$d = new CGMSDBObj('schools');
$d->setUpTable();



function geocodeFromAddress($dbobj, $addressparts = ['address1', 'address2', 'city', 'stateprovince', 'zippostal', 'country']) {
    $address = [];
    foreach ($addressparts as $part) {
        $address[$part] = (string) $dbobj->getValue($part);
    }

    $coordinates = (new NominatimGeocoder())->geocode($address);
    if ($coordinates === null) {
        return 0;
    }

    $dbobj->setValue('lat', $coordinates['lat']);
    $dbobj->setValue('lng', $coordinates['lng']);
    if ($coordinates['precision'] !== 'address') {
        fwrite(STDERR, 'Warning: approximate location saved (' . $coordinates['precision'] . " level).\n");
    }
    return 1;
}

$addressobj=array ('address1' => '6821 cool pond road', 'address2' => '', 'city' => 'raleigh', 'stateprovince' => 'nc', 'country' => 'USA', 'zippostal' => '27613');

//$c->selectSQL("lat is null or lng is null",0,0);
$found = $c->selectSQL("id = ?", 0, 0, [19471]);
if (!$found) {
    fwrite(STDERR, "School 19471 was not found.\n");
    exit(1);
}
do {
    print "record name is " . $c->getValue("schoolname") . "\n";
    if (!$d->getRow($c->getValue('id'))) {
        throw new RuntimeException('School no longer exists.');
    }
    if (!geocodeFromAddress($d)) {
        fwrite(STDERR, "No geocoding result; coordinates were left unchanged.\n");
        exit(1);
    }
    $error = $d->update();
    if ($error) {
        throw new RuntimeException('Database update failed: ' . $error);
    }
} while ($c->nextRecordInSet());
exit(0);
//geocodeFromAddress($addressobj);


?>