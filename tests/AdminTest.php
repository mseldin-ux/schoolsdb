<?php

declare(strict_types=1);

use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\TestCase;

require_once __DIR__ . '/admin_fixture.php';
require_once dirname(__DIR__) . '/includes/NominatimGeocoder.php';

final class AdminTest extends TestCase
{
    private mysqli $db;
    private string $cookie = '';
    private string $csrf = '';

    protected function setUp(): void
    {
        if (!getenv('ADMIN_TEST_URL')) {
            self::fail('Run python3 -B tests/run_admin_tests.py to start isolated test servers.');
        }
        $this->db = adminTestDb();
        adminTestSeed($this->db);
    }

    protected function tearDown(): void
    {
        $this->db->close();
    }

    private function request(array $data = [], string $method = 'GET', string $path = '/controller.php'): array
    {
        $url = getenv('ADMIN_TEST_URL') . $path;
        $headers = ['Cookie: ' . $this->cookie];
        $options = ['method' => $method, 'ignore_errors' => true, 'follow_location' => 0];
        if ($method === 'POST') {
            $headers[] = 'Content-Type: application/x-www-form-urlencoded';
            $options['content'] = http_build_query($data);
        } elseif ($data !== []) {
            $url .= '?' . http_build_query($data);
        }
        $options['header'] = implode("\r\n", $headers);
        $body = file_get_contents($url, false, stream_context_create(['http' => $options]));
        $responseHeaders = http_get_last_response_headers();
        preg_match('/\s(\d{3})\s/', $responseHeaders[0], $match);
        foreach ($responseHeaders as $header) {
            if (preg_match('/^Set-Cookie: (PHPSESSID=[^;]*)/i', $header, $cookie)) {
                $this->cookie = $cookie[1];
            }
        }
        self::assertIsString($body);
        self::assertDoesNotMatchRegularExpression('/(?:Fatal error:|<b>Warning|Deprecated:|Parse error:)/', $body);
        return [(int) $match[1], $body, implode("\n", $responseHeaders)];
    }

    private function token(string $body, string $name = 'csrf'): string
    {
        self::assertSame(1, preg_match('/name="' . $name . '" value="([^"]+)"/', $body, $match));
        return $match[1];
    }

    private function login(string $username): void
    {
        [, $body] = $this->request();
        $this->csrf = $this->token($body);
        $before = $this->cookie;
        [$status] = $this->request(['action' => 'login', 'username' => $username, 'password' => 'test-password',
            'csrf' => $this->csrf], 'POST');
        self::assertSame(303, $status);
        self::assertNotSame($before, $this->cookie, 'Login must rotate the session id.');
        [, $body] = $this->request();
        $this->csrf = $this->token($body);
    }

    private function post(string $action, array $values = []): array
    {
        return $this->request(array_merge(['action' => $action, 'csrf' => $this->csrf], $values), 'POST');
    }

    private function row(int $id = 1): array
    {
        return $this->db->query('SELECT * FROM schools WHERE id = ' . $id)->fetch_assoc();
    }

    public static function permissions(): iterable
    {
        $routes = [
            'adminlist' => 5, 'create' => 9, 'delete' => 9, 'restore' => 9,
            'addreview' => 5, 'updatereview' => 5, 'export' => 10, 'geocode' => 10,
        ];
        foreach (['owner' => 1, 'reviewer' => 5, 'manager' => 9, 'admin' => 10] as $user => $role) {
            foreach ($routes as $action => $minimum) {
                yield "$user $action" => [$user, $action, $role >= $minimum];
            }
        }
    }

    #[DataProvider('permissions')]
    public function testPermissionMatrix(string $user, string $action, bool $allowed): void
    {
        $this->login($user);
        $values = ['id' => '1', 'schoolid' => '1', 'reviewid' => '999', 'reviewstatus' => 'Reviewed - OK'];
        [$status] = in_array($action, ['adminlist', 'create', 'export'], true)
            ? $this->request(['action' => $action] + $values) : $this->post($action, $values);
        self::assertSame($allowed ? ($action === 'updatereview' ? 404 : 200) : 403, $status);
    }

    public function testOwnerBoundariesAndSafeFieldHandling(): void
    {
        $this->login('owner');
        [$status, $form] = $this->request(['action' => 'edit', 'id' => '1']);
        self::assertSame(200, $status);
        foreach (['recpass', 'recuser', 'recsecreta', 'approved', 'schooltype'] as $name) {
            self::assertStringNotContainsString('name="' . $name . '"', $form);
        }
        self::assertSame(403, $this->request(['action' => 'edit', 'id' => '2'])[0]);
        self::assertSame(403, $this->post('update', ['id' => '2', 'schoolname' => 'forged'])[0]);
        $name = "O'Reilly \"School\" \\ " . "\u{00e9}" . ' <img src=x onerror=alert(1)>';
        self::assertSame(200, $this->post('update', [
            'id' => '1', 'schoolname' => $name, 'approved' => '0', 'schooltype' => 'Public',
            'recpass' => 'stolen', 'deleted' => '1', 'lastmodifiedby' => 'forged', 'bilingual' => 'on',
        ])[0]);
        $row = $this->row();
        self::assertSame($name, $row['schoolname']);
        self::assertSame('Private', $row['schooltype']);
        self::assertSame('private-record-password', $row['recpass']);
        self::assertSame(1, (int) $row['approved']);
        self::assertSame(0, (int) $row['deleted']);
        self::assertSame(12, (int) $row['infants'], 'Unsent numeric fields must be preserved.');
        self::assertSame(1, (int) $row['bilingual']);
        self::assertSame('owner', $row['lastmodifiedby']);
        self::assertSame(200, $this->post('update', ['id' => '1', 'schoolname' => $name])[0]);
        self::assertSame(0, (int) $this->row()['bilingual'], 'Unsent checkboxes must clear.');
        [, $form] = $this->request(['action' => 'edit', 'id' => '1']);
        self::assertStringContainsString('&quot;School&quot;', $form);
        self::assertStringNotContainsString('<img src=x', $form);
        self::assertSame(2, (int) $this->db->query('SELECT COUNT(*) FROM schools_backup')->fetch_row()[0]);
        $backup = $this->db->query('SELECT * FROM schools_backup ORDER BY id LIMIT 1')->fetch_assoc();
        self::assertSame('Owner School', $backup['schoolname']);
        self::assertSame(1, (int) $backup['origid']);
    }

    public function testRequiredFieldsAndInvalidIdsAreRejected(): void
    {
        $this->login('manager');
        self::assertSame(422, $this->post('update', ['id' => '1', 'schoolname' => ' '])[0]);
        self::assertSame('Owner School', $this->row()['schoolname']);
        self::assertSame(400, $this->request(['action' => 'edit', 'id' => '1 OR 1=1'])[0]);
        self::assertSame(404, $this->request(['action' => 'edit', 'id' => '9999'])[0]);
        self::assertSame(422, $this->post('update', ['id' => '1', 'infants' => 'oops'])[0]);
        self::assertSame(400, $this->request(['action' => 'edit', 'id' => ['1']])[0]);
    }

    public function testCsrfMethodsAndDirectActionGuards(): void
    {
        $this->login('admin');
        foreach (['add', 'update', 'delete', 'restore', 'addreview', 'updatereview', 'geocode', 'logout'] as $action) {
            self::assertSame(405, $this->request(['action' => $action, 'id' => '1'])[0], $action);
            self::assertSame(403, $this->request(['action' => $action, 'id' => '1'], 'POST')[0], $action);
            self::assertSame(403, $this->post($action, ['id' => '1', 'csrf' => 'wrong'])[0], $action);
        }
        foreach (['add.php', 'update.php', 'delete.php', 'export.php', 'geocode.php', 'import.php', 'restore.php'] as $path) {
            self::assertSame(403, $this->request([], 'GET', '/' . $path)[0], $path);
        }
        self::assertSame(404, $this->request(['action' => '../import'])[0]);
        self::assertSame(404, $this->request(['action' => 'import'])[0]);
        self::assertSame(400, $this->request(['action' => ['edit']])[0]);
    }

    public function testUnauthenticatedRequestsAndLoginFailures(): void
    {
        self::assertSame(401, $this->request(['action' => 'adminlist'])[0]);
        [, $body] = $this->request();
        $token = $this->token($body);
        self::assertSame(403, $this->request(['action' => 'login', 'username' => 'admin',
            'password' => 'test-password'], 'POST')[0]);
        foreach (['retired', "' OR 1=1 -- "] as $username) {
            self::assertSame(401, $this->request(['action' => 'login', 'username' => $username,
                'password' => 'test-password', 'csrf' => $token], 'POST')[0]);
        }
        $this->login('owner');
        self::assertSame(200, $this->post('logout')[0]);
        self::assertSame(401, $this->request(['action' => 'edit', 'id' => '1'])[0]);
    }

    public function testCreateGuardAndGeocodingOutcomes(): void
    {
        $this->login('manager');
        foreach (['1 Test Road' => false, 'NORESULT' => true, 'HTTPFAIL' => true, 'BADJSON' => true] as $address => $warning) {
            [, $form] = $this->request(['action' => 'create']);
            $values = ['create_token' => $this->token($form, 'create_token'),
                'schoolname' => 'Created school', 'address1' => $address,
                'city' => 'Testville', 'infoemail' => 'UNKNOWN', 'web' => 'UNKNOWN'];
            [$status, $body] = $this->post('add', $values);
            self::assertSame(200, $status, $body);
            self::assertSame($warning, str_contains($body, 'Warning: address lookup failed'));
            $row = $this->db->query('SELECT * FROM schools ORDER BY id DESC LIMIT 1')->fetch_assoc();
            self::assertSame($warning ? null : 44.5, $row['lat'] === null ? null : (float) $row['lat']);
            self::assertSame(409, $this->post('add', $values)[0], 'Duplicate create must not insert twice.');
        }
        self::assertSame(7, (int) $this->db->query('SELECT COUNT(*) FROM schools')->fetch_row()[0]);
    }

    public function testChangedAddressClearsFailedCoordinatesAndUnchangedAddressDoesNotLookup(): void
    {
        $this->login('owner');
        [, $body] = $this->post('update', ['id' => '1', 'schoolname' => 'Renamed']);
        self::assertStringNotContainsString('Warning: address lookup failed', $body);
        self::assertEqualsWithDelta(44.1, $this->row()['lat'], 0.0001);
        [, $body] = $this->post('update', ['id' => '1', 'address1' => 'NORESULT']);
        self::assertStringContainsString('Warning: address lookup failed', $body);
        self::assertNull($this->row()['lat']);
        self::assertNull($this->row()['lng']);
    }

    public function testPostalCityMismatchUsesStreetAndPostalCodeFallback(): void
    {
        $this->login('owner');
        [$status, $body] = $this->post('update', [
            'id' => '1', 'address1' => '13500 CITYMISMATCH Road', 'city' => 'Silver Spring',
            'stateprovince' => 'Maryland', 'zippostal' => '20906', 'country' => 'United States',
        ]);
        self::assertSame(200, $status);
        self::assertStringNotContainsString('Warning: address lookup failed', $body);
        self::assertEqualsWithDelta(39.0796949, $this->row()['lat'], 0.00001);
        self::assertSame('Silver Spring', $this->row()['city'], 'Lookup must not rewrite the postal address.');
        [$status, $body] = $this->post('update', ['id' => '1', 'zippostal' => '']);
        self::assertSame(200, $status);
        self::assertStringContainsString('Warning: address lookup failed', $body);
        self::assertNull($this->row()['lat'], 'All broader queries also returned no match.');
        $this->db->query("UPDATE schools SET zippostal='20906' WHERE id=1");
        [$status, $body] = $this->post('update', ['id' => '1']);
        self::assertSame(200, $status);
        self::assertStringNotContainsString('Warning: address lookup failed', $body);
        self::assertEqualsWithDelta(39.0796949, $this->row()['lat'], 0.00001,
            'Missing coordinates must be retried even when the address is unchanged.');
    }

    public function testAtomicBackupRollback(): void
    {
        $this->login('manager');
        self::assertSame(500, $this->post('update', ['id' => '1', 'schoolname' => str_repeat('x', 200)])[0]);
        self::assertSame('Owner School', $this->row()['schoolname']);
        self::assertSame(0, (int) $this->db->query('SELECT COUNT(*) FROM schools_backup')->fetch_row()[0]);
    }

    public static function fallbackAddresses(): iterable
    {
        yield 'street without number' => [
            ['address1' => '123 STREETONLY Road', 'city' => 'Fallback City', 'stateprovince' => 'Fallback State',
                'zippostal' => 'H1H1H1', 'country' => 'Canada'], 'street', 45.0, -73.0,
        ];
        yield 'house number range' => [
            ['address1' => '123-125 STREETONLY Road', 'city' => 'Fallback City', 'stateprovince' => 'Fallback State',
                'country' => 'Canada'], 'street', 45.0, -73.0,
        ];
        yield 'city without street or postal code' => [
            ['address1' => '123 CITYONLY Road', 'city' => 'CITYONLY', 'stateprovince' => 'Fallback State',
                'zippostal' => 'H1H1H1', 'country' => 'Canada'], 'city', 46.0, -74.0,
        ];
        yield 'province without city or postal code' => [
            ['address1' => '123 NORESULT Road', 'city' => 'NORESULT', 'stateprovince' => 'STATEONLY',
                'zippostal' => 'H1H1H1', 'country' => 'Canada'], 'state/province', 47.0, -75.0,
        ];
        yield 'exact address wins' => [
            ['address1' => '1 Test Lane', 'city' => 'CITYONLY', 'stateprovince' => 'Fallback State',
                'country' => 'Canada', 'address2' => 'FIRSTMATCH'], 'address', 44.5, -72.5,
        ];
        yield 'precise match' => [
            ['address1' => '1 Test Lane', 'city' => 'Testville', 'stateprovince' => 'Vermont',
                'country' => 'United States'], 'address', 44.5, -72.5,
        ];
    }

    #[DataProvider('fallbackAddresses')]
    public function testProgressiveGeolocationFallbacks(array $address, string $precision, float $lat, float $lng): void
    {
        $result = (new NominatimGeocoder())->geocode($address);
        self::assertNotNull($result);
        self::assertSame($precision, $result['precision']);
        self::assertSame($lat, $result['lat']);
        self::assertSame($lng, $result['lng']);
    }

    public function testGeolocationSafetyAndQuebecNormalization(): void
    {
        $geocoder = new NominatimGeocoder();
        self::assertNull($geocoder->geocode(['country' => 'Canada']));
        self::assertNull($geocoder->geocode(['address1' => 'NORESULT', 'city' => 'CITYONLY',
            'stateprovince' => 'Fallback State', 'country' => 'UNKNOWN']));
        foreach (["Qu\u{fffd}bec", "Qu\u{00e9}bec", "Qu\u{00c3}\u{00a9}bec", "Que\u{0301}bec"] as $province) {
            $result = $geocoder->geocode(['address1' => 'QUEBECTEST Road', 'stateprovince' => $province, 'country' => 'Canada']);
            self::assertSame(46.8, $result['lat']);
        }
        foreach (['HTTPFAIL', 'BADJSON', 'OUTOFRANGE'] as $street) {
            try {
                $geocoder->geocode(['address1' => $street, 'city' => 'CITYONLY',
                    'stateprovince' => 'Fallback State', 'country' => 'Canada']);
                self::fail('An invalid response must not be hidden by a broader fallback.');
            } catch (RuntimeException $error) {
                self::assertNotSame('', $error->getMessage());
            }
        }
        $this->login('manager');
        $stmt = $this->db->prepare('UPDATE schools SET stateprovince = ? WHERE id = 1');
        $province = "Qu\u{fffd}bec";
        $stmt->bind_param('s', $province);
        $stmt->execute();
        [, $form] = $this->request(['action' => 'edit', 'id' => '1']);
        self::assertStringContainsString('<option selected>Quebec</option>', $form);
        self::assertSame(200, $this->post('update', ['id' => '1', 'stateprovince' => "Qu\u{00e9}bec"])[0]);
        self::assertSame('Quebec', $this->row()['stateprovince']);
    }

    public function testApproximateLocationWarnsAndPreservesAddress(): void
    {
        $this->login('manager');
        [$status, $body] = $this->post('update', ['id' => '1', 'address1' => '123 NORESULT Road',
            'city' => 'NORESULT', 'stateprovince' => 'STATEONLY', 'country' => 'Canada']);
        self::assertSame(200, $status);
        self::assertStringContainsString('Warning: approximate location saved (state/province level)', $body);
        self::assertEqualsWithDelta(47, $this->row()['lat'], 0.00001);
        self::assertSame('123 NORESULT Road', $this->row()['address1']);
        self::assertSame('NORESULT', $this->row()['city']);
    }

    public function testMissingGeolocationSearchAndIndividualRetry(): void
    {
        $this->db->query('UPDATE schools SET lat = NULL WHERE id = 1');
        $this->db->query('UPDATE schools SET lng = NULL WHERE id = 2');
        $this->login('admin');
        [, $list] = $this->request(['action' => 'adminlist', 'missinglocation' => '1', 'max' => '1']);
        self::assertStringContainsString('of 2 records', $list);
        self::assertStringContainsString('missinglocation=1', $list);
        self::assertStringContainsString('Retry geolocation', $list);
        [, $list] = $this->request(['action' => 'adminlist', 'missinglocation' => '1', 'keywords' => 'Other']);
        self::assertStringNotContainsString('Owner School', $list);
        self::assertStringContainsString('Other School', $list);
        self::assertSame(400, $this->post('geocode', ['id' => '1 OR 1=1'])[0]);
        [$status, $body] = $this->post('geocode', ['id' => '1']);
        self::assertSame(200, $status);
        self::assertStringContainsString('Processed 1 listings', $body);
        self::assertEqualsWithDelta(44.5, $this->row()['lat'], 0.00001);
        self::assertNull($this->row(2)['lng'], 'An individual retry must not process other schools.');
        self::assertNull($this->row(3)['lat'], 'Deleted schools must not be processed.');
        self::assertSame(1, (int) $this->db->query('SELECT COUNT(*) FROM schools_backup WHERE origid=1')->fetch_row()[0]);
        [, $body] = $this->post('geocode', ['id' => '1']);
        self::assertStringContainsString('Processed 0 listings', $body);
        [, $body] = $this->post('geocode', ['id' => '3']);
        self::assertStringContainsString('Processed 0 listings', $body);
        $this->db->query('UPDATE schools SET lat=0, lng=0 WHERE id=1');
        $this->db->query('UPDATE schools SET lat=91, lng=-72 WHERE id=2');
        [, $list] = $this->request(['action' => 'adminlist', 'missinglocation' => '1']);
        self::assertStringContainsString('of 2 records', $list);
        $this->login('manager');
        [, $list] = $this->request(['action' => 'adminlist', 'missinglocation' => '1']);
        self::assertStringNotContainsString('Retry geolocation', $list);
        self::assertSame(403, $this->post('geocode', ['id' => '1'])[0]);
    }

    public function testDeleteRestoreAndDeletedList(): void
    {
        $this->login('manager');
        self::assertSame(200, $this->post('delete', ['id' => '1'])[0]);
        self::assertSame(1, (int) $this->row()['deleted']);
        self::assertNotNull($this->row()['deleteddate']);
        [, $body] = $this->request(['action' => 'adminlist']);
        self::assertStringNotContainsString('Owner School', $body);
        [, $body] = $this->request(['action' => 'adminlist', 'deleted' => '1']);
        self::assertStringContainsString('Owner School', $body);
        self::assertSame(200, $this->post('restore', ['id' => '1'])[0]);
        self::assertSame(0, (int) $this->row()['deleted']);
        self::assertNull($this->row()['deleteddate']);
    }

    public function testSearchPaginationAndNoReviewJoinDuplicates(): void
    {
        $this->login('reviewer');
        foreach (['first', 'second'] as $comment) {
            self::assertSame(200, $this->post('addreview', [
                'schoolid' => '1', 'reviewstatus' => 'Reviewed - OK', 'comments' => $comment,
            ])[0]);
        }
        [, $body] = $this->request(['action' => 'adminlist']);
        self::assertStringContainsString('of 2 records', $body);
        self::assertSame(1, substr_count($body, '<td>Owner School</td>'));
        [, $body] = $this->request(['action' => 'adminlist', 'sort' => 'id', 'max' => '1', 'start' => '1']);
        self::assertStringContainsString('Other School', $body);
        self::assertStringNotContainsString('Owner School', $body);
        [, $body] = $this->request(['action' => 'adminlist', 'sort' => 'search', 'keywords' => "' OR 1=1 -- "]);
        self::assertStringContainsString('No matches found', $body);
        self::assertSame(400, $this->request(['action' => 'adminlist', 'idtarget' => '>0 OR 1=1'])[0]);
        [, $body] = $this->request(['action' => 'adminlist', 'idtarget' => '>1 <3']);
        self::assertStringContainsString('Other School', $body);
        self::assertStringNotContainsString('Owner School', $body);
        self::assertSame(403, $this->request(['action' => 'adminlist', 'deleted' => '1'])[0]);
    }

    public function testReviewsXmlEscapingAndParentChecks(): void
    {
        $this->login('reviewer');
        $comment = '<script>alert("x")</script> & ' . "\u{00e9}";
        [$status, $body, $headers] = $this->post('addreview', [
            'schoolid' => '1', 'reviewstatus' => 'Reviewed - OK', 'comments' => $comment,
        ]);
        self::assertSame(200, $status);
        self::assertStringContainsString('application/xml', $headers);
        $xml = simplexml_load_string($body);
        self::assertSame('0', (string) $xml->ResultCode);
        $reviewId = (string) $xml->ResultID;
        self::assertSame(200, $this->post('updatereview', [
            'reviewid' => $reviewId, 'reviewstatus' => 'Reviewed - Updated', 'comments' => $comment,
        ])[0]);
        [, $list] = $this->request(['action' => 'adminlist']);
        self::assertStringContainsString('&lt;script&gt;', $list);
        self::assertStringNotContainsString($comment, $list);
        self::assertSame(404, $this->post('addreview', ['schoolid' => '9999'])[0]);
        self::assertSame(409, $this->post('addreview', ['schoolid' => '3'])[0]);
        [$status, $error] = $this->post('addreview', ['schoolid' => '1', 'reviewstatus' => '<invalid>']);
        self::assertSame(422, $status);
        self::assertNotFalse(simplexml_load_string($error));
    }

    public function testExportLogRedactionAndBulkGeocoding(): void
    {
        $this->login('admin');
        [$status, $body, $headers] = $this->request(['action' => 'export']);
        self::assertSame(200, $status);
        self::assertStringContainsString('text/tab-separated-values', $headers);
        self::assertStringContainsString('attachment;', $headers);
        self::assertStringNotContainsString('<html', $body);
        self::assertStringNotContainsString('Deleted School', $body);
        self::assertStringNotContainsString('recpass', $body);
        self::assertSame(3, count(explode("\n", trim($body))));
        $this->db->query('UPDATE schools SET lat=NULL, lng=NULL WHERE id IN (1,2)');
        self::assertSame(200, $this->post('geocode')[0]);
        self::assertEqualsWithDelta(44.5, $this->row(1)['lat'], 0.0001);
        self::assertEqualsWithDelta(44.5, $this->row(2)['lat'], 0.0001);
        self::assertNull($this->row(3)['lat']);
        $details = implode('', array_column($this->db->query('SELECT details FROM actionslog')->fetch_all(MYSQLI_ASSOC), 'details'));
        self::assertStringNotContainsString('test-password', $details);
        self::assertStringNotContainsString($this->csrf, $details);
        self::assertStringContainsString('[REDACTED]', $details);
    }

    private function runCli(array $arguments): array
    {
        $process = proc_open(array_merge([PHP_BINARY], $arguments),
            [1 => ['pipe', 'w'], 2 => ['pipe', 'w']], $pipes, dirname(__DIR__));
        self::assertIsResource($process);
        $stdout = stream_get_contents($pipes[1]);
        $stderr = stream_get_contents($pipes[2]);
        fclose($pipes[1]);
        fclose($pipes[2]);
        return [proc_close($process), $stdout, $stderr];
    }

    public function testCliImportAndMalformedFile(): void
    {
        $path = tempnam(sys_get_temp_dir(), 'schools-import-');
        try {
            file_put_contents($path, "schoolname\taddress1\tcity\tinfoemail\tweb\tusername\tpassword\n"
                . "Imported School\t1 Imported Road\tTestville\tUNKNOWN\tUNKNOWN\timport-owner\timport-password\n");
            [$status, $stdout, $stderr] = $this->runCli(['import.php', $path]);
            self::assertSame(0, $status, $stderr);
            self::assertStringContainsString('Imported school', $stdout);
            $row = $this->db->query("SELECT * FROM schools WHERE schoolname = 'Imported School'")->fetch_assoc();
            self::assertNotNull($row);
            self::assertEqualsWithDelta(44.5, $row['lat'], 0.0001);
            $user = $this->db->query("SELECT * FROM users WHERE username = 'import-owner'")->fetch_assoc();
            self::assertSame((int) $row['id'], (int) $user['schoolid']);
            self::assertSame(1, (int) $user['privlevel']);
            self::assertStringNotContainsString('import-password', $stdout);
            file_put_contents($path, "schoolname\taddress1\nInvalid row\n");
            self::assertNotSame(0, $this->runCli(['import.php', $path])[0]);
        } finally {
            unlink($path);
        }
    }

    public function testLegacyLogRedactionIsIdempotent(): void
    {
        $stmt = $this->db->prepare("INSERT INTO actionslog (userid, added, action, details)
            VALUES (1, '2020-01-01 00:00:00', 'login', ?)");
        $details = "username = example\npassword = old-sensitive-value\nsecond line of password";
        $stmt->bind_param('s', $details);
        $stmt->execute();
        self::assertSame(0, $this->runCli(['tools/redact_action_logs.php'])[0]);
        $row = $this->db->query('SELECT * FROM actionslog LIMIT 1')->fetch_assoc();
        self::assertSame('2020-01-01 00:00:00', $row['added']);
        self::assertStringNotContainsString('old-sensitive-value', $row['details']);
        self::assertStringNotContainsString('second line', $row['details']);
        [, $stdout] = $this->runCli(['tools/redact_action_logs.php']);
        self::assertStringContainsString('Redacted 0', $stdout);
    }

    public function testRemovedRolesAndChangedAssignmentsTakeEffectOnNextRequest(): void
    {
        $this->login('manager');
        $this->db->query("UPDATE users SET privlevel = 5 WHERE username = 'manager'");
        self::assertSame(403, $this->request(['action' => 'create'])[0]);
        $this->db->query("UPDATE users SET privlevel = 7 WHERE username = 'manager'");
        self::assertSame(401, $this->request(['action' => 'adminlist'])[0]);
    }
}
