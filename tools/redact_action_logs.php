<?php

declare(strict_types=1);

if (PHP_SAPI !== 'cli') {
    http_response_code(403);
    exit('Run this maintenance tool from the command line.');
}
require_once dirname(__DIR__) . '/includes/config.php';

$db = schoolsDbConnect();
// Legacy request values may span lines; replacing the whole detail is safer than
// trying to infer the end of a password. User/action/timestamp metadata remains.
$stmt = $db->prepare(
    "UPDATE actionslog SET added = added, details = '[REDACTED: legacy request contained credential fields]'
     WHERE details REGEXP '(^|[\\r\\n])[[:space:]]*(password|recpass|recsecretq|recsecreta|secretq|secreta)[[:space:]]*='"
);
$stmt->execute();
echo 'Redacted ' . $stmt->affected_rows . " legacy action-log details.\n";
