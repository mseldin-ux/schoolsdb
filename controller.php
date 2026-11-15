<?php

declare(strict_types=1);

require_once __DIR__ . '/includes/admin.php';

if (PHP_SAPI === 'cli') {
    if (($argv[1] ?? '') !== 'fixgeocode') {
        fwrite(STDERR, "Usage: php controller.php fixgeocode\n");
        exit(1);
    }
    $schools = new CGMSDBObj('schools');
    $schools->setUpTable();
    $found = $schools->selectSQL(adminMissingCoordinatesSql() . ' AND COALESCE(deleted, 0) = 0');
    if ($found) {
        do {
            $id = (int) $schools->getValue('id');
            $warning = adminRetryGeocode($id);
            if ($warning === null) {
                continue;
            }
            echo 'School ' . $id . ': ' . ($warning ?: 'Geocoded') . "\n";
        } while ($schools->nextRecordInSet());
    }
    exit;
}

define('SCHOOLS_ADMIN_REQUEST', true);
session_start([
    'use_strict_mode' => true,
    'cookie_httponly' => true,
    'cookie_samesite' => 'Lax',
    'cookie_secure' => !empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off',
]);
header('Cache-Control: no-store');
header('X-Content-Type-Options: nosniff');
$_REQUEST = $_SERVER['REQUEST_METHOD'] === 'POST' ? $_POST : $_GET;
$action = 'login';
$reviewResponse = false;

try {
    $action = adminInput('action', 'default');
    $actions = ['login', 'logout', 'default', 'adminlist', 'edit', 'update', 'create', 'add',
        'delete', 'restore', 'addreview', 'updatereview', 'export', 'geocode'];
    if (!in_array($action, $actions, true)) {
        throw new AdminHttpException(404, 'Unknown admin action.');
    }
    $reviewResponse = in_array($action, ['addreview', 'updatereview'], true);
    require __DIR__ . '/authenticate.php';
    if ($action === 'login' && $_SERVER['REQUEST_METHOD'] === 'POST') {
        adminRequirePost();
        $username = adminInput('username');
        $password = adminInput('password');
        $users->findRow(['username' => $username, 'password' => $password], []);
        $role = (int) $users->getValue('privlevel');
        if (!$users->getValue('userid') || !in_array($role, [1, 5, 9, 10], true)) {
            adminLog('login-failed');
            throw new AdminHttpException(401, 'Invalid username or password.');
        }
        session_regenerate_id(true);
        $_SESSION = [
            'userid' => (int) $users->getValue('userid'),
            'schoolid' => (int) $users->getValue('schoolid'),
            'username' => (string) $users->getValue('username'),
            'role' => $role,
        ];
        adminCsrf();
        adminLog('login');
        header('Location: controller.php?action=default', true, 303);
        exit;
    }
    if (empty($_SESSION['userid'])) {
        if (!in_array($action, ['login', 'default'], true)) {
            throw new AdminHttpException(401, 'Please log in.');
        }
        require __DIR__ . '/login.php';
        exit;
    }
    if ($action === 'logout') {
        adminRequirePost();
        adminLog('logout');
        require __DIR__ . '/logout.php';
        exit;
    }
    if (in_array($action, ['login', 'default'], true)) {
        $action = adminRole() === 1 ? 'edit' : 'adminlist';
        if ($action === 'edit') {
            $_REQUEST['id'] = (string) $_SESSION['schoolid'];
        }
    }
    adminAuthorize($action);
    if (in_array($action, ['add', 'update', 'delete', 'restore', 'addreview', 'updatereview', 'geocode'], true)) {
        adminRequirePost();
    }
    adminLog($action);
    if (!$reviewResponse && $action !== 'export') {
        echo '<!doctype html><html lang="en"><meta charset="utf-8"><title>School administration</title><body>';
        echo '<p>Logged in as ' . adminEscape($_SESSION['username']) . '</p>'
            . '<form method="post" action="controller.php">' . adminCsrfField()
            . '<input type="hidden" name="action" value="logout"><button>Log Out</button></form>';
    }
    require __DIR__ . '/' . $action . '.php';
    if (!$reviewResponse && $action !== 'export') {
        echo '</body></html>';
    }
} catch (AdminHttpException $error) {
    http_response_code($error->status);
    if ($reviewResponse) {
        adminReviewXml($error->getMessage(), 1);
    } else {
        echo '<h1>Request could not be completed</h1><p role="alert">' . adminEscape($error->getMessage()) . '</p>';
    }
} catch (Throwable $error) {
    error_log('Admin request failed: ' . $error);
    http_response_code(500);
    if ($reviewResponse) {
        adminReviewXml('The request failed. Please contact the administrator.', 1);
    } else {
        echo '<h1>Server error</h1><p role="alert">The request failed. Please contact the administrator.</p>';
    }
}
