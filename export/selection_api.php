<?php

declare(strict_types=1);

require __DIR__ . '/lib/app.php';

try {
    $config = load_config();
    bootstrap_app($config);
    $pdo = get_pdo($config);
    $table = (string) ($config['schools_table'] ?? 'schools');
    $availableColumns = get_school_columns($pdo, $table);
    $action = isset($_REQUEST['action']) ? (string) $_REQUEST['action'] : '';

    if ($action === 'metadata') {
        send_json([
            'columns' => $availableColumns,
            'schooltypes' => fetch_school_types($pdo, $config, $availableColumns),
            'program_fields' => get_supported_program_filters($availableColumns),
        ]);
    }

    if ($action === 'count') {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            respond_with_error('Count requests must use POST.', 405);
        }

        $selection = parse_selection_request($_POST);
        $filters = normalize_filters($_POST, $availableColumns);
        $candidates = fetch_school_candidates($pdo, $config, $selection['bbox'], $filters, $availableColumns);
        $rows = filter_rows_by_selection($candidates, $selection);

        debug_log('Count request completed', [
            'mode' => $selection['mode'],
            'candidate_count' => count($candidates),
            'row_count' => count($rows),
            'filters' => $filters,
        ]);

        send_json([
            'count' => count($rows),
        ]);
    }

    respond_with_error('Unsupported API action.', 400);
} catch (Throwable $exception) {
    $config = isset($config) && is_array($config) ? $config : [];
    $debugEnabled = !empty($config['debug']);

    debug_log('Selection API request failed', [
        'action' => isset($action) ? $action : '',
        'error' => $exception->getMessage(),
        'file' => $exception->getFile(),
        'line' => $exception->getLine(),
    ]);

    $message = 'Request failed.';
    if ($debugEnabled) {
        $message = sprintf(
            'Request failed: %s in %s on line %d',
            $exception->getMessage(),
            basename($exception->getFile()),
            $exception->getLine()
        );
    }

    respond_with_error($message, 500);
}
