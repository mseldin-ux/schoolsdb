<?php

declare(strict_types=1);

require __DIR__ . '/lib/app.php';

try {
    $config = load_config();
    bootstrap_app($config);

    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        respond_with_error('This endpoint only accepts POST requests.', 405);
    }

    $pdo = get_pdo($config);
    $table = (string) ($config['schools_table'] ?? 'schools');
    $availableColumns = get_school_columns($pdo, $table);
    $selection = parse_selection_request($_POST);
    $filters = normalize_filters($_POST, $availableColumns);
    $selectedColumns = normalize_selected_columns($_POST, $availableColumns);

    debug_log('Export request received', [
        'mode' => $selection['mode'],
        'selected_column_count' => count($selectedColumns),
        'filters' => $filters,
    ]);

    $candidates = fetch_school_candidates($pdo, $config, $selection['bbox'], $filters, $availableColumns);
    $rows = filter_rows_by_selection($candidates, $selection);
    $filename = build_export_filename($selection);

    debug_log('Export request completed', [
        'candidate_count' => count($candidates),
        'row_count' => count($rows),
        'filename' => $filename,
    ]);

    send_csv($rows, $selectedColumns, $filename);
} catch (Throwable $exception) {
    $config = isset($config) && is_array($config) ? $config : [];
    $debugEnabled = !empty($config['debug']);

    debug_log('Export request failed', [
        'error' => $exception->getMessage(),
        'file' => $exception->getFile(),
        'line' => $exception->getLine(),
    ]);

    $message = 'Export failed.';
    if ($debugEnabled) {
        $message = sprintf(
            'Export failed: %s in %s on line %d',
            $exception->getMessage(),
            basename($exception->getFile()),
            $exception->getLine()
        );
    }

    respond_with_error($message, 500);
}
