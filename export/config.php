<?php

return [
    'app_title' => getenv('APP_TITLE') ?: 'School Map Export',
    'debug' => filter_var(getenv('APP_DEBUG') ?: '0', FILTER_VALIDATE_BOOLEAN),
    'error_log_file' => getenv('APP_ERROR_LOG') ?: __DIR__ . '/logs/app.log',
    'db' => [
        'host' => getenv('DB_HOST') ?: '127.0.0.1',
        'port' => getenv('DB_PORT') ?: '3306',
        'name' => getenv('DB_NAME') ?: 'schools',
        'user' => getenv('DB_USER') ?: 'schoolsdbuser',
        'pass' => getenv('DB_PASS') ?: '3h*d9GG',
        'charset' => getenv('DB_CHARSET') ?: 'utf8mb4',
    ],
    'schools_table' => getenv('SCHOOLS_TABLE') ?: 'schools',
    'schools_extra_where' => getenv('SCHOOLS_EXTRA_WHERE') ?: 'deleted = 0',
];
