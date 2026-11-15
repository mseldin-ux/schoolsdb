<?php

declare(strict_types=1);

final class NominatimGeocoder
{
    private const ENDPOINT = 'https://nominatim.openstreetmap.org/search';

    public static function normalizeProvince(string $value): string
    {
        $value = trim($value);
        return in_array($value, [
            'Quebec', "Qu\u{00e9}bec", "Que\u{0301}bec", "Qu\u{fffd}bec",
            "Qu\u{00c3}\u{00a9}bec", "Qu\u{00ef}\u{00bf}\u{00bd}bec",
        ], true) ? 'Quebec' : $value;
    }

    /**
     * @param array<string, string|null> $addressParts
     * @return array{lat: float, lng: float, precision: string}|null
     */
    public function geocode(array $addressParts): ?array
    {
        $parts = [];
        foreach ($addressParts as $key => $value) {
            if ($value === null) {
                continue;
            }

            $value = trim(str_replace('XXX', '', $value));
            if ($key === 'stateprovince') {
                $value = self::normalizeProvince($value);
            }
            if ($value !== '' && strcasecmp($value, 'unknown') !== 0) {
                $parts[$key] = $value;
            }
        }

        if (array_diff_key($parts, ['country' => true]) === []) {
            return null;
        }

        $queries = [['parameters' => [
            'q' => implode(', ', $parts),
            'limit' => 1,
        ], 'precision' => isset($parts['address1']) || isset($parts['address2']) || isset($parts['zippostal'])
            ? 'address' : (isset($parts['city']) ? 'city' : 'state/province')]];
        $street = $parts['address1'] ?? '';
        $postalCode = $parts['zippostal'] ?? '';
        $city = $parts['city'] ?? '';
        $state = $parts['stateprovince'] ?? '';
        $country = $parts['country'] ?? '';
        // Keep the postal-city mismatch fallback ahead of broader locations.
        if ($street !== '' && $postalCode !== '' && $country !== '') {
            $queries[] = ['parameters' => array_filter([
                'street' => $street, 'postalcode' => $postalCode,
                'state' => $state, 'country' => $country,
            ], static fn (string $value): bool => $value !== '') + ['limit' => 1], 'precision' => 'address'];
        }
        // Never broaden to an unqualified city/street or a whole-country centroid.
        if ($country !== '') {
            $location = array_filter(['city' => $city, 'state' => $state, 'country' => $country],
                static fn (string $value): bool => $value !== '');
            $streetWithoutNumber = preg_replace('/^\d+[a-z]?(?:\s*[-\/]\s*\d+[a-z]?)?\s+/i', '', $street);
            if ($streetWithoutNumber !== '' && $streetWithoutNumber !== $street && ($city !== '' || $state !== '')) {
                $queries[] = ['parameters' => ['street' => $streetWithoutNumber] + $location + ['limit' => 1],
                    'precision' => 'street'];
            }
            if ($city !== '') {
                $queries[] = ['parameters' => $location + ['limit' => 1], 'precision' => 'city'];
            }
            if ($state !== '') {
                $queries[] = ['parameters' => ['state' => $state, 'country' => $country, 'limit' => 1],
                    'precision' => 'state/province'];
            }
        }

        foreach ($queries as $query) {
            $results = $this->search($query['parameters']);
            if ($results === []) {
                continue;
            }
            $lat = $results[0]['lat'] ?? null;
            $lng = $results[0]['lon'] ?? null;
            if (!is_numeric($lat) || !is_numeric($lng)
                || !is_finite((float) $lat) || !is_finite((float) $lng)
                || abs((float) $lat) > 90 || abs((float) $lng) > 180) {
                throw new RuntimeException('Nominatim result did not include valid coordinates.');
            }
            return ['lat' => (float) $lat, 'lng' => (float) $lng, 'precision' => $query['precision']];
        }

        return null;
    }

    /**
     * Finds a named place (country, state, city, town, ...) and its viewport.
     *
     * @return array{name: string, lat: float, lng: float, south: float, north: float, west: float, east: float}|null
     */
    public function findPlace(string $query, string $featureType): ?array
    {
        $query = trim($query);
        if ($query === '') {
            return null;
        }

        $results = $this->search([
            'q' => $query,
            'featureType' => $featureType,
            'limit' => 1,
        ]);
        $result = $results[0] ?? null;
        if (!is_array($result)) {
            return null;
        }

        $box = $result['boundingbox'] ?? null;
        if (!is_array($box) || count($box) !== 4 || array_filter($box, 'is_numeric') !== $box
            || !is_numeric($result['lat'] ?? null) || !is_numeric($result['lon'] ?? null)) {
            throw new RuntimeException('Nominatim place result did not include valid coordinates.');
        }

        return [
            'name' => (string) ($result['name'] ?? ''),
            'lat' => (float) $result['lat'],
            'lng' => (float) $result['lon'],
            'south' => (float) $box[0],
            'north' => (float) $box[1],
            'west' => (float) $box[2],
            'east' => (float) $box[3],
        ];
    }

    /**
     * @param array<string, string|int> $parameters
     * @return list<array<string, mixed>>
     */
    private function search(array $parameters): array
    {
        $this->waitForRateLimit();

        $email = getenv('NOMINATIM_CONTACT_EMAIL') ?: 'info@cgms.edu';
        $endpoint = getenv('NOMINATIM_ENDPOINT') ?: self::ENDPOINT;
        $url = $endpoint . '?' . http_build_query($parameters + [
            'format' => 'jsonv2',
            'email' => $email,
        ]);
        $context = stream_context_create([
            'http' => [
                'method' => 'GET',
                'timeout' => 10,
                'ignore_errors' => true,
                'header' => [
                    'Accept: application/json',
                    'User-Agent: MontessoriSchoolDirectory/1.0 (contact: ' . $email . ')',
                ],
            ],
        ]);

        set_error_handler(static function (int $severity, string $message): never {
            throw new RuntimeException($message);
        });
        try {
            $response = file_get_contents($url, false, $context);
        } finally {
            restore_error_handler();
        }

        if ($response === false) {
            throw new RuntimeException('Nominatim returned an empty response.');
        }

        $statusLine = (http_get_last_response_headers() ?: [])[0] ?? '';
        if (!preg_match('/\s2\d\d\s/', $statusLine)) {
            throw new RuntimeException('Nominatim request failed with HTTP status: ' . $statusLine);
        }

        try {
            $results = json_decode($response, true, 512, JSON_THROW_ON_ERROR);
        } catch (JsonException $exception) {
            throw new RuntimeException('Nominatim returned invalid JSON.', 0, $exception);
        }

        if (!is_array($results) || !array_is_list($results)) {
            throw new RuntimeException('Nominatim returned an unexpected response.');
        }

        return $results;
    }

    private function waitForRateLimit(): void
    {
        // Only a loopback test stub may bypass the public service's rate limit.
        $endpoint = getenv('NOMINATIM_ENDPOINT');
        if ($endpoint && in_array(parse_url($endpoint, PHP_URL_HOST), ['127.0.0.1', 'localhost', '[::1]'], true)) {
            return;
        }
        $handle = fopen(sys_get_temp_dir() . '/schools-nominatim-rate-limit.lock', 'c+');
        if ($handle === false) {
            throw new RuntimeException('Unable to create the Nominatim rate-limit lock.');
        }

        $locked = false;
        try {
            if (!flock($handle, LOCK_EX)) {
                throw new RuntimeException('Unable to acquire the Nominatim rate-limit lock.');
            }
            $locked = true;

            rewind($handle);
            $lastRequestAt = (float) stream_get_contents($handle);
            $waitMicroseconds = 1_000_000 - (int) ((microtime(true) - $lastRequestAt) * 1_000_000);
            if ($lastRequestAt > 0 && $waitMicroseconds > 0) {
                usleep($waitMicroseconds);
            }

            rewind($handle);
            if (!ftruncate($handle, 0) || fwrite($handle, (string) microtime(true)) === false || !fflush($handle)) {
                throw new RuntimeException('Unable to update the Nominatim rate-limit lock.');
            }
        } finally {
            if ($locked) {
                flock($handle, LOCK_UN);
            }
            fclose($handle);
        }
    }
}
