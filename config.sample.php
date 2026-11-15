<?php

// Copy this file to ../schools-config/config.php (outside the web root), or point
// the SCHOOLS_CONFIG environment variable at your copy, and fill in real values.
return [
    'db' => [
        'host' => '127.0.0.1',
        'user' => 'schoolsdbuser',
        'password' => 'change-me',
        'name' => 'schools',
    ],
    // Browser key for the Google Maps JavaScript API (restrict it to the site's referrers).
    // The GOOGLE_MAPS_API_KEY environment variable, if set, takes precedence.
    'google_maps_api_key' => '',
    // Tab-separated file read by: php import.php [path]
    'import_file' => '',
];
