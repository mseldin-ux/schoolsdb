<?php

declare(strict_types=1);

function load_config(): array
{
    $configPath = dirname(__DIR__) . '/config.php';

    if (!file_exists($configPath)) {
        throw new RuntimeException('Missing config.php file.');
    }

    $config = require $configPath;

    if (!is_array($config)) {
        throw new RuntimeException('config.php must return an array.');
    }

    return $config;
}

function bootstrap_app(array $config): void
{
    $debugEnabled = !empty($config['debug']);
    $errorLogFile = isset($config['error_log_file']) ? (string) $config['error_log_file'] : '';

    ini_set('display_errors', $debugEnabled ? '1' : '0');
    ini_set('log_errors', '1');

    if ($errorLogFile !== '') {
        $logDirectory = dirname($errorLogFile);

        if (!is_dir($logDirectory)) {
            @mkdir($logDirectory, 0775, true);
        }

        if (is_dir($logDirectory) && is_writable($logDirectory)) {
            ini_set('error_log', $errorLogFile);
        }
    }
}

function get_pdo(array $config): PDO
{
    $db = $config['db'] ?? [];

    $dsn = sprintf(
        'mysql:host=%s;port=%s;dbname=%s;charset=%s',
        $db['host'] ?? '127.0.0.1',
        $db['port'] ?? '3306',
        $db['name'] ?? '',
        $db['charset'] ?? 'utf8mb4'
    );

    return new PDO(
        $dsn,
        $db['user'] ?? '',
        $db['pass'] ?? '',
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        ]
    );
}

function quote_identifier(string $identifier): string
{
    if (!preg_match('/^[A-Za-z0-9_]+$/', $identifier)) {
        throw new InvalidArgumentException('Invalid SQL identifier.');
    }

    return '`' . $identifier . '`';
}

function get_school_columns(PDO $pdo, string $table): array
{
    $sql = 'SHOW COLUMNS FROM ' . quote_identifier($table);
    $rows = $pdo->query($sql)->fetchAll();

    return array_map('extract_field_name', $rows);
}

function extract_field_name(array $row): string
{
    return $row['Field'];
}

function get_program_field_labels(): array
{
    return [
        'infants' => 'Infants',
        'toddlers' => 'Toddlers',
        'primary' => 'Primary',
        'lowerel' => 'Lower Elementary',
        'upperel' => 'Upper Elementary',
        'middle' => 'Middle School',
        'highschool' => 'High School',
    ];
}

function get_supported_program_filters(array $availableColumns): array
{
    $supported = [];
    $labels = get_program_field_labels();

    foreach ($labels as $column => $label) {
        if (in_array($column, $availableColumns, true)) {
            $supported[$column] = $label;
        }
    }

    return $supported;
}

function fetch_school_types(PDO $pdo, array $config, array $availableColumns): array
{
    if (!in_array('schooltype', $availableColumns, true)) {
        return [];
    }

    $quotedTable = quote_identifier((string) ($config['schools_table'] ?? 'schools'));
    $filters = [
        '`schooltype` IS NOT NULL',
        "TRIM(`schooltype`) <> ''",
    ];

    $trimmedExtraWhere = trim((string) ($config['schools_extra_where'] ?? ''));
    if ($trimmedExtraWhere !== '') {
        $filters[] = '(' . $trimmedExtraWhere . ')';
    }

    $sql = 'SELECT DISTINCT `schooltype` FROM ' . $quotedTable
        . ' WHERE ' . implode(' AND ', $filters)
        . ' ORDER BY `schooltype` ASC';

    $rows = $pdo->query($sql)->fetchAll();
    $types = [];

    foreach ($rows as $row) {
        $type = trim((string) $row['schooltype']);
        if ($type !== '') {
            $types[] = $type;
        }
    }

    return $types;
}

function normalize_list_input($value): array
{
    if (is_array($value)) {
        $items = [];
        foreach ($value as $item) {
            if (is_scalar($item)) {
                $items[] = (string) $item;
            }
        }

        return $items;
    }

    if (is_scalar($value) && (string) $value !== '') {
        return [(string) $value];
    }

    return [];
}

function validate_coordinates(float $lat, float $lng): void
{
    if ($lat < -90.0 || $lat > 90.0) {
        throw new InvalidArgumentException('Latitude must be between -90 and 90.');
    }

    if ($lng < -180.0 || $lng > 180.0) {
        throw new InvalidArgumentException('Longitude must be between -180 and 180.');
    }
}

function parse_selection_request(array $source): array
{
    $mode = isset($source['mode']) ? (string) $source['mode'] : '';

    if ($mode === 'circle') {
        if (!isset($source['center_lat'], $source['center_lng'], $source['radius_miles'])) {
            throw new InvalidArgumentException('Circle exports require a valid center point and radius.');
        }

        if (!is_numeric($source['center_lat']) || !is_numeric($source['center_lng']) || !is_numeric($source['radius_miles'])) {
            throw new InvalidArgumentException('Circle exports require numeric coordinates and radius.');
        }

        $centerLat = (float) $source['center_lat'];
        $centerLng = (float) $source['center_lng'];
        $radiusMiles = (float) $source['radius_miles'];

        validate_coordinates($centerLat, $centerLng);

        if ($radiusMiles <= 0) {
            throw new InvalidArgumentException('Radius must be greater than zero.');
        }

        return [
            'mode' => 'circle',
            'center_lat' => $centerLat,
            'center_lng' => $centerLng,
            'radius_miles' => $radiusMiles,
            'bbox' => build_circle_bbox($centerLat, $centerLng, $radiusMiles),
        ];
    }

    if ($mode === 'polygon') {
        $polygonJson = isset($source['polygon']) ? (string) $source['polygon'] : '';
        $polygonData = json_decode($polygonJson, true);

        if (!is_array($polygonData) || count($polygonData) < 3) {
            throw new InvalidArgumentException('Polygon exports require at least three points.');
        }

        $polygon = [];
        foreach ($polygonData as $point) {
            if (!is_array($point) || !isset($point['lat'], $point['lng'])) {
                throw new InvalidArgumentException('Polygon payload is invalid.');
            }

            if (!is_numeric($point['lat']) || !is_numeric($point['lng'])) {
                throw new InvalidArgumentException('Polygon points must be numeric.');
            }

            $lat = (float) $point['lat'];
            $lng = (float) $point['lng'];
            validate_coordinates($lat, $lng);

            $polygon[] = [
                'lat' => $lat,
                'lng' => $lng,
            ];
        }

        return [
            'mode' => 'polygon',
            'polygon' => $polygon,
            'bbox' => build_polygon_bbox($polygon),
        ];
    }

    throw new InvalidArgumentException('Unsupported selection mode.');
}

function normalize_filters(array $source, array $availableColumns): array
{
    $filters = [
        'approved' => null,
        'schooltype' => '',
        'program_types' => [],
        'program_match' => 'any',
    ];

    if (isset($source['approved']) && in_array('approved', $availableColumns, true)) {
        $approved = (string) $source['approved'];
        if ($approved === '0' || $approved === '1') {
            $filters['approved'] = (int) $approved;
        }
    }

    if (isset($source['schooltype']) && in_array('schooltype', $availableColumns, true)) {
        $filters['schooltype'] = trim((string) $source['schooltype']);
    }

    $supportedPrograms = get_supported_program_filters($availableColumns);
    $requestedPrograms = normalize_list_input(isset($source['program_types']) ? $source['program_types'] : []);

    foreach ($requestedPrograms as $program) {
        if (isset($supportedPrograms[$program])) {
            $filters['program_types'][] = $program;
        }
    }

    $filters['program_types'] = array_values(array_unique($filters['program_types']));

    if (isset($source['program_match']) && (string) $source['program_match'] === 'all') {
        $filters['program_match'] = 'all';
    }

    return $filters;
}

function normalize_selected_columns(array $source, array $availableColumns): array
{
    $requestedColumns = normalize_list_input(isset($source['columns']) ? $source['columns'] : []);

    if ($requestedColumns === []) {
        return $availableColumns;
    }

    $selected = [];
    foreach ($requestedColumns as $column) {
        if (in_array($column, $availableColumns, true)) {
            $selected[] = $column;
        }
    }

    $selected = array_values(array_unique($selected));

    if ($selected === []) {
        throw new InvalidArgumentException('At least one valid export column must be selected.');
    }

    return $selected;
}

function build_candidate_query(string $table, string $extraWhere, array $bbox, array $filters, array $availableColumns): array
{
    $quotedTable = quote_identifier($table);
    $whereClauses = [
        '`lat` IS NOT NULL',
        '`lng` IS NOT NULL',
        '`lat` BETWEEN :min_lat AND :max_lat',
        '`lng` BETWEEN :min_lng AND :max_lng',
    ];
    $params = [
        ':min_lat' => $bbox['min_lat'],
        ':max_lat' => $bbox['max_lat'],
        ':min_lng' => $bbox['min_lng'],
        ':max_lng' => $bbox['max_lng'],
    ];

    $trimmedExtraWhere = trim($extraWhere);
    if ($trimmedExtraWhere !== '') {
        $whereClauses[] = '(' . $trimmedExtraWhere . ')';
    }

    if ($filters['approved'] !== null && in_array('approved', $availableColumns, true)) {
        $whereClauses[] = '`approved` = :approved';
        $params[':approved'] = $filters['approved'];
    }

    if ($filters['schooltype'] !== '' && in_array('schooltype', $availableColumns, true)) {
        $whereClauses[] = '`schooltype` = :schooltype';
        $params[':schooltype'] = $filters['schooltype'];
    }

    if (!empty($filters['program_types'])) {
        $programChecks = [];
        foreach ($filters['program_types'] as $index => $column) {
            if (!in_array($column, $availableColumns, true)) {
                continue;
            }

            $placeholder = ':program_threshold_' . $index;
            $programChecks[] = 'COALESCE(' . quote_identifier($column) . ', 0) > ' . $placeholder;
            $params[$placeholder] = 0;
        }

        if ($programChecks !== []) {
            $joiner = $filters['program_match'] === 'all' ? ' AND ' : ' OR ';
            $whereClauses[] = '(' . implode($joiner, $programChecks) . ')';
        }
    }

    $sql = 'SELECT * FROM ' . $quotedTable . ' WHERE ' . implode(' AND ', $whereClauses);

    return [
        'sql' => $sql,
        'params' => $params,
    ];
}

function fetch_school_candidates(PDO $pdo, array $config, array $bbox, array $filters, array $availableColumns): array
{
    $query = build_candidate_query(
        (string) ($config['schools_table'] ?? 'schools'),
        (string) ($config['schools_extra_where'] ?? ''),
        $bbox,
        $filters,
        $availableColumns
    );

    $stmt = $pdo->prepare($query['sql']);
    $stmt->execute($query['params']);

    return $stmt->fetchAll();
}

function build_circle_bbox(float $centerLat, float $centerLng, float $radiusMiles): array
{
    $latDelta = $radiusMiles / 69.0;
    $cosLat = cos(deg2rad($centerLat));
    $lngDelta = $radiusMiles / max(abs($cosLat) * 69.172, 0.01);

    return [
        'min_lat' => max(-90.0, $centerLat - $latDelta),
        'max_lat' => min(90.0, $centerLat + $latDelta),
        'min_lng' => max(-180.0, $centerLng - $lngDelta),
        'max_lng' => min(180.0, $centerLng + $lngDelta),
    ];
}

function build_polygon_bbox(array $polygon): array
{
    $lats = array_column($polygon, 'lat');
    $lngs = array_column($polygon, 'lng');

    return [
        'min_lat' => (float) min($lats),
        'max_lat' => (float) max($lats),
        'min_lng' => (float) min($lngs),
        'max_lng' => (float) max($lngs),
    ];
}

function haversine_distance_miles(float $lat1, float $lng1, float $lat2, float $lng2): float
{
    $earthRadiusMiles = 3958.7613;
    $latDelta = deg2rad($lat2 - $lat1);
    $lngDelta = deg2rad($lng2 - $lng1);
    $lat1Rad = deg2rad($lat1);
    $lat2Rad = deg2rad($lat2);

    $a = sin($latDelta / 2) ** 2
        + cos($lat1Rad) * cos($lat2Rad) * sin($lngDelta / 2) ** 2;
    $c = 2 * atan2(sqrt($a), sqrt(1 - $a));

    return $earthRadiusMiles * $c;
}

function point_on_segment(float $x, float $y, array $start, array $end): bool
{
    $epsilon = 1.0e-10;
    $crossProduct = ($y - $start['lat']) * ($end['lng'] - $start['lng'])
        - ($x - $start['lng']) * ($end['lat'] - $start['lat']);

    if (abs($crossProduct) > $epsilon) {
        return false;
    }

    $dotProduct = ($x - $start['lng']) * ($end['lng'] - $start['lng'])
        + ($y - $start['lat']) * ($end['lat'] - $start['lat']);

    if ($dotProduct < -$epsilon) {
        return false;
    }

    $squaredLength = ($end['lng'] - $start['lng']) ** 2 + ($end['lat'] - $start['lat']) ** 2;

    return $dotProduct <= $squaredLength + $epsilon;
}

function point_in_polygon(float $lat, float $lng, array $polygon): bool
{
    $inside = false;
    $pointCount = count($polygon);

    if ($pointCount < 3) {
        return false;
    }

    for ($i = 0, $j = $pointCount - 1; $i < $pointCount; $j = $i++) {
        $current = $polygon[$i];
        $previous = $polygon[$j];

        if (point_on_segment($lng, $lat, $previous, $current)) {
            return true;
        }

        $intersects = (($current['lat'] > $lat) !== ($previous['lat'] > $lat))
            && ($lng < (($previous['lng'] - $current['lng']) * ($lat - $current['lat'])
            / (($previous['lat'] - $current['lat']) ?: 1.0e-10)) + $current['lng']);

        if ($intersects) {
            $inside = !$inside;
        }
    }

    return $inside;
}

function filter_rows_by_selection(array $candidates, array $selection): array
{
    $rows = [];

    foreach ($candidates as $candidate) {
        if (!isset($candidate['lat'], $candidate['lng'])) {
            continue;
        }

        $candidateLat = (float) $candidate['lat'];
        $candidateLng = (float) $candidate['lng'];

        if ($selection['mode'] === 'circle') {
            $distance = haversine_distance_miles(
                (float) $selection['center_lat'],
                (float) $selection['center_lng'],
                $candidateLat,
                $candidateLng
            );

            if ($distance <= (float) $selection['radius_miles']) {
                $rows[] = $candidate;
            }
            continue;
        }

        if (point_in_polygon($candidateLat, $candidateLng, $selection['polygon'])) {
            $rows[] = $candidate;
        }
    }

    return $rows;
}

function build_export_filename(array $selection): string
{
    $prefix = $selection['mode'] === 'circle' ? 'schools_radius' : 'schools_polygon';

    return sprintf('%s_%s.csv', $prefix, date('Ymd_His'));
}

function send_csv(array $rows, array $columns, string $filename): void
{
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="' . $filename . '"');
    header('Cache-Control: no-store, no-cache, must-revalidate, max-age=0');
    header('Pragma: no-cache');

    $output = fopen('php://output', 'wb');

    if ($output === false) {
        throw new RuntimeException('Unable to open CSV output stream.');
    }

    fputcsv($output, $columns);

    foreach ($rows as $row) {
        $ordered = [];
        foreach ($columns as $column) {
            $ordered[] = $row[$column] ?? null;
        }
        fputcsv($output, $ordered);
    }

    fclose($output);
}

function send_json(array $payload, int $statusCode = 200): void
{
    http_response_code($statusCode);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($payload);
    exit;
}

function respond_with_error(string $message, int $statusCode = 400): void
{
    http_response_code($statusCode);
    header('Content-Type: text/plain; charset=utf-8');
    echo $message;
    exit;
}

function debug_log(string $message, array $context = []): void
{
    if ($context !== []) {
        $message .= ' | ' . json_encode($context);
    }

    error_log('[school-map-export] ' . $message);
}
