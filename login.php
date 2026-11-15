<?php

if (!defined('SCHOOLS_ADMIN_REQUEST')) {
    http_response_code(403);
    exit('Use controller.php.');
}
echo '<!doctype html><html lang="en"><meta charset="utf-8"><title>Admin login</title><body>';
echo '<h1>School administration</h1><form method="post" action="controller.php">' . adminCsrfField()
    . '<input type="hidden" name="action" value="login">'
    . '<label>User name: <input name="username" autocomplete="username" required></label><br>'
    . '<label>Password: <input type="password" name="password" autocomplete="current-password" required></label>'
    . '<button type="submit">Log In</button></form></body></html>';
