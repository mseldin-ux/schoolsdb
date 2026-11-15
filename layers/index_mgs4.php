<?php

// This page is the same map as search/; send visitors there, keeping any search
// terms (307 also preserves POSTed search forms).
$query = $_SERVER['QUERY_STRING'] ?? '';
header('Location: ../search/' . ($query !== '' ? '?' . $query : ''), true, 307);
exit;
