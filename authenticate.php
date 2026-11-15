<?php

if (!defined('SCHOOLS_ADMIN_REQUEST')) {
    http_response_code(403);
    exit('Use controller.php.');
}

$users = new CGMSDBObj('users');
$users->setUpTable();
if (!empty($_SESSION['userid'])) {
    $found = $users->getRow($_SESSION['userid']);
    $role = (int) $users->getValue('privlevel');
    if (!$found || !in_array($role, [1, 5, 9, 10], true)) {
        $_SESSION = [];
        session_regenerate_id(true);
    } else {
        $_SESSION['role'] = $role;
        $_SESSION['schoolid'] = (int) $users->getValue('schoolid');
        $_SESSION['username'] = (string) $users->getValue('username');
    }
}
