<?php
// Database settings come from the external config file (see includes/config.php).
require_once dirname(__DIR__, 2) . '/includes/config.php';
$dbsettings = schoolsConfig()['db'];
$dbhost = $dbsettings['host'];
$dbname = $dbsettings['name'];
$username = $dbsettings['user'];
$password = $dbsettings['password'];
