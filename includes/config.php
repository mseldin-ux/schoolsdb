<?php

declare(strict_types=1);

/**
 * Loads site configuration from a file kept outside the web root.
 * The path defaults to ../schools-config/config.php and can be overridden with SCHOOLS_CONFIG.
 *
 * @return array{db: array{host: string, user: string, password: string, name: string}, import_file?: string}
 */
function schoolsConfig(): array
{
    static $config = null;
    if ($config !== null) {
        return $config;
    }

    $path = getenv('SCHOOLS_CONFIG') ?: dirname(__DIR__, 2) . '/schools-config/config.php';
    if (!is_file($path)) {
        throw new RuntimeException('Configuration file not found. Copy config.sample.php to ' . $path . ' or set SCHOOLS_CONFIG.');
    }

    $loaded = require $path;
    if (!is_array($loaded) || !is_array($loaded['db'] ?? null)) {
        throw new RuntimeException('Configuration file ' . $path . ' must return an array with a "db" section.');
    }
    foreach (['host', 'user', 'password', 'name'] as $key) {
        if (!is_string($loaded['db'][$key] ?? null)) {
            throw new RuntimeException('Configuration is missing db.' . $key . '.');
        }
    }

    return $config = $loaded;
}

function schoolsDbConnect(): mysqli
{
    $db = schoolsConfig()['db'];
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
    $mysqli = new mysqli($db['host'], $db['user'], $db['password'], $db['name']);
    $mysqli->set_charset('utf8mb4');

    return $mysqli;
}
