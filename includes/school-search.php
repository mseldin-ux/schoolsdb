<?php

declare(strict_types=1);

require_once __DIR__ . '/NominatimGeocoder.php';

/**
 * @return array<string, string> Two-letter US state / Canadian province code => name stored in schools.stateprovince
 */
function schoolStateAliases(): array
{
    return [
        'AL' => 'Alabama', 'AK' => 'Alaska', 'AZ' => 'Arizona', 'AR' => 'Arkansas',
        'AS' => 'American Samoa', 'CA' => 'California', 'CO' => 'Colorado', 'CT' => 'Connecticut',
        'DE' => 'Delaware', 'DC' => 'District of Columbia', 'FM' => 'Fed. States of Micronesia',
        'FL' => 'Florida', 'GA' => 'Georgia', 'GU' => 'Guam', 'HI' => 'Hawaii', 'ID' => 'Idaho',
        'IL' => 'Illinois', 'IN' => 'Indiana', 'IA' => 'Iowa', 'KS' => 'Kansas', 'KY' => 'Kentucky',
        'LA' => 'Louisiana', 'ME' => 'Maine', 'MD' => 'Maryland', 'MH' => 'Marshall Islands',
        'MA' => 'Massachusetts', 'MI' => 'Michigan', 'MN' => 'Minnesota', 'MS' => 'Mississippi',
        'MO' => 'Missouri', 'MT' => 'Montana', 'NE' => 'Nebraska', 'NV' => 'Nevada',
        'NH' => 'New Hampshire', 'NJ' => 'New Jersey', 'NM' => 'New Mexico', 'NY' => 'New York',
        'NC' => 'North Carolina', 'ND' => 'North Dakota', 'MP' => 'Northern Marianas', 'OH' => 'Ohio',
        'OK' => 'Oklahoma', 'OR' => 'Oregon', 'PA' => 'Pennsylvania', 'PR' => 'Puerto Rico',
        'RI' => 'Rhode Island', 'SC' => 'South Carolina', 'SD' => 'South Dakota', 'TN' => 'Tennessee',
        'TX' => 'Texas', 'UT' => 'Utah', 'VT' => 'Vermont', 'VA' => 'Virginia',
        'VI' => '(U.S.) Virgin Islands', 'WA' => 'Washington', 'WV' => 'West Virginia',
        'WI' => 'Wisconsin', 'WY' => 'Wyoming', 'AA' => 'Armed Forces, the Americas',
        'AE' => 'Armed Forces, Europe', 'AP' => 'Armed Forces, Pacific', 'AB' => 'Alberta',
        'BC' => 'British Columbia', 'MB' => 'Manitoba', 'NB' => 'New Brunswick',
        'NL' => 'Newfoundland and Labrador', 'NT' => 'Northwest Territories', 'NS' => 'Nova Scotia',
        'NU' => 'Nunavut', 'ON' => 'Ontario', 'PE' => 'Prince Edward Island', 'QC' => 'Quebec',
        'SK' => 'Saskatchewan', 'YT' => 'Yukon Territory',
    ];
}

/**
 * Returns the state/province name if the keywords are exactly a state code ("VT", "V.T.") or name ("Vermont").
 */
function schoolStateFromKeywords(string $keywords): ?string
{
    $keywords = trim($keywords);
    $aliases = schoolStateAliases();
    $code = strtoupper(str_replace('.', '', $keywords));
    if (strlen($code) === 2 && isset($aliases[$code])) {
        return $aliases[$code];
    }
    foreach ($aliases as $name) {
        if (strcasecmp($name, $keywords) === 0) {
            return $name;
        }
    }

    return null;
}

/**
 * Finds the geographic place a city/state/country search refers to, so the map can zoom to it.
 * Returns null if the search does not name a recognisable place or the lookup fails.
 *
 * @param array{keywords?: string, city?: string, country?: string, zip?: string} $search
 * @return array{name: string, lat: float, lng: float, south: float, north: float, west: float, east: float}|null
 */
function schoolSearchPlace(array $search): ?array
{
    $keywords = trim($search['keywords'] ?? '');
    $city = trim($search['city'] ?? '');
    $country = trim($search['country'] ?? '');
    if (trim($search['zip'] ?? '') !== '') {
        return null;
    }

    $state = $keywords !== '' ? schoolStateFromKeywords($keywords) : null;
    if ($city !== '') {
        $mustMatch = $city;
        $query = implode(', ', array_filter([$city, $state ?? $keywords, $country]));
        $featureType = 'settlement';
    } elseif ($state !== null) {
        $mustMatch = $state;
        $query = implode(', ', array_filter([$state, $country]));
        $featureType = 'state';
    } elseif ($keywords !== '') {
        $mustMatch = $keywords;
        $query = implode(', ', array_filter([$keywords, $country]));
        $featureType = 'settlement';
    } elseif ($country !== '') {
        $mustMatch = null;
        $query = $country;
        $featureType = 'country';
    } else {
        return null;
    }

    $cacheFile = sys_get_temp_dir() . '/schools-place-cache-' . sha1($featureType . '|' . strtolower($query)) . '.json';
    $cacheHit = false;
    $place = null;
    if (is_file($cacheFile) && filemtime($cacheFile) > time() - 30 * 86400) {
        $cached = json_decode((string) file_get_contents($cacheFile), true);
        if (is_array($cached) && array_key_exists('place', $cached)) {
            $place = $cached['place'];
            $cacheHit = true;
        }
    }

    if (!$cacheHit) {
        try {
            $place = (new NominatimGeocoder())->findPlace($query, $featureType);
        } catch (RuntimeException $exception) {
            error_log('Place lookup failed for "' . $query . '": ' . $exception->getMessage());
            return null;
        }
        file_put_contents($cacheFile, json_encode(['place' => $place]), LOCK_EX);
    }

    if (!is_array($place)) {
        return null;
    }

    // Avoid zooming to a place that merely resembles free-text keywords (e.g. a school name).
    if ($mustMatch !== null) {
        $name = schoolNormalizePlaceName($place['name']);
        $wanted = schoolNormalizePlaceName($mustMatch);
        if ($name === '' || ($wanted !== $name && !str_starts_with($wanted, $name . ' '))) {
            return null;
        }
    }

    return $place;
}

function schoolNormalizePlaceName(string $name): string
{
    $ascii = iconv('UTF-8', 'ASCII//TRANSLIT//IGNORE', $name);
    $name = strtolower($ascii === false ? $name : $ascii);
    $name = preg_replace('/[^a-z0-9]+/', ' ', $name) ?? $name;
    $name = preg_replace('/^(city|town|village|state|province) of /', '', trim($name)) ?? $name;

    return trim($name);
}
