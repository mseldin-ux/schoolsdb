<?php

if (!defined('SCHOOLS_ADMIN_REQUEST')) {
    http_response_code(403);
    exit('Use controller.php.');
}
$_SESSION = [];
$params = session_get_cookie_params();
setcookie(session_name(), '', [
    'expires' => time() - 3600, 'path' => $params['path'], 'domain' => $params['domain'],
    'secure' => $params['secure'], 'httponly' => $params['httponly'], 'samesite' => 'Lax',
]);
session_destroy();
echo '<h1>Logged Out</h1><a href="controller.php">Log back in.</a>';
