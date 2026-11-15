# Admin (school CRUD) test plan

## Implemented regression suite (2026-10-24)

The implementation below supersedes the historical pre-condition findings.
The agreed role matrix in section 4 is enforced centrally:
owners (1) edit their own school; reviewers (5) list schools and write reviews;
managers (9) also create/edit/delete/restore schools; admins (10) additionally
export and bulk-geocode. Level 7 no longer authenticates. Reviewers and higher
may update any review; its author/date are set to the user making that update.

### Setup and execution

Requirements: PHP 8.4+ (including mysqli and PHPUnit's XML/mbstring extensions),
MySQL, Composer, npm, and Python 3. PHP 8.5 is the deployment target.

```sh
composer install
npm ci
npx playwright install chromium
python3 -B tests/run_admin_tests.py
```

Alternatively use VS Code's **Run admin regression tests** task. The runner:

- Reads the normal external configuration, creates schema-only copies of the
  five admin tables in **schools_test**, and resets only that test database to
  synthetic fixtures. Never point it at a production server.
- Requires the configured DB account to have privileges on `schools_test`
  (including CREATE/ALTER), plus read/schema access to the source tables.
  A local DBA can run `CREATE DATABASE schools_test CHARACTER SET utf8mb4;`
  and `GRANT ALL PRIVILEGES ON schools_test.* TO 'schoolsdbuser'@'%';`,
  adapting the account/host to the installation.
- Writes a mode-0600 test configuration to a temporary directory outside the
  web root. Starts two loopback servers on available ports: PHP and a Nominatim
  stub. No Google key, live geocoder or real school data is needed.
- Executes PHPUnit integration tests and Playwright browser workflows, checks
  server diagnostics, and stops both servers and removes temporary config/logs
  on completion. Synthetic test rows remain in `schools_test` for inspection.
- Destructively reseeds `schools_test` on each run; do not run two copies at once.

The data-layer check remains available as `php tests/cgms_db_test.php`; it only
uses a connection-local temporary table. The public mapping regression is
`python3 -B tests/runtime_smoke.py` with the normal server running on port 8765.

### Runtime behavior and deliberate changes

- Configuration: copy `config.sample.php` to the sibling
  `../schools-config/config.php` outside the web root and restrict its permissions,
  or set `SCHOOLS_CONFIG` to another external PHP config file.
- Only the explicit controller action list is routable. Action files reject
  direct HTTP calls; imports and the one-off geocoder are CLI-only.
- Login, logout and all mutations require POST and a session CSRF token.
  Sessions rotate on login, do not store passwords, and recheck the database
  role/school assignment on every request. Password hashing remains deferred.
- The list counts distinct schools directly rather than paginating joined review
  rows. Searches use bound parameters; ID comparisons support `>100 <200`.
  Deleted schools have a manager/admin-only list and restore buttons.
- Listing rows retain the original light-gray (`#eeeeee`) background. Their
  dated review forms appear in a white, nested table in the row immediately
  underneath, spanning the remaining listing columns rather than crowding
  the actions column. Only the two newest reviews are expanded; additional
  reviews appear in a closed-by-default "See older reviews" disclosure.
  The new-review form starts hidden and is revealed by the listing's
  "Add New Review" button, independently of the older-review disclosure.
  Listing actions are buttons ordered Edit, Add New Review, Delete on one line;
  the address column wraps to leave room. Canceling the delete confirmation
  leaves the school unchanged; accepting it performs the existing soft delete.
  Edit opens a separate tab and leaves the listing (including search and review
  state) intact. The province option is ASCII `Quebec`; known accented/garbled
  variants are normalized for editing, submitted values, and geocoder requests.
  Existing stored province values change only when the school is saved.
- The edit form preserves quotes and escapes database text. Owners do not see
  school-type or record-administration controls, and forged protected fields
  are ignored. Unsent numeric fields remain unchanged; unsent editable
  checkboxes clear. Required school fields accept `UNKNOWN`.
- Saves, delete and restore keep backups in the same InnoDB transaction.
  Updates lock the current record before applying submitted values: last save
  wins, with omitted fields preserved. Database failures roll back the backup.
- New/changed addresses and schools with missing coordinates are geocoded on saves. Lookup failure saves
  NULL coordinates and displays a warning instead of losing the school edit.
  Bulk geocoding processes active schools with missing coordinates.
  If a full-address lookup has no match, a structured street/state/postal-code/
  country query omits the postal city (which can differ from OSM's locality).
  This fallback requires a street, postal code and country. If it also fails,
  queries drop the leading street number, then the entire street/postal code,
  then the city to try the state/province. These broader queries require a
  country; there is no country-only fallback. The first match is saved without
  changing the stored address. Street-, city-, and province-level matches show
  an explicit approximation warning in the save/retry result (precision is not
  stored as a separate database field). Service errors stop the fallback chain.
- "Schools without geolocations" and the "Missing geolocation only" checkbox
  filter active listings whose latitude/longitude is missing, out of range, or
  the placeholder pair `(0, 0)`. The filter combines with keyword/ID searches
  and pagination; deleted schools are excluded unless explicitly requested.
  Level-10 admins may retry individual schools from this list, or use the
  existing bulk button. Both web and CLI retries recheck missing coordinates
  under a row lock, back up the record, and skip already-located/deleted schools.
  Other roles retain their existing permissions. Individual retries avoid a
  potentially long bulk request against the rate-limited geocoder.
- Successful saves show an explicit result and return link rather than closing
  the window automatically (so warnings remain visible). Invalid requests show
  their error; unexpected failures log server-side details and show a generic
  error without exposing credentials or SQL.
- Create forms carry a one-use, one-hour token to prevent repeat submissions.
  Review saves use async requests and display errors without injecting HTML.
- Exports are downloadable UTF-8 TSV, contain active schools only, omit record
  passwords/recovery secrets, and contain no HTML footer. Spreadsheet-like
  formulas in textual cells are prefixed with an apostrophe; numeric coordinates
  remain numeric.
- `php import.php /path/to/schools.tsv` reads the TSV header and imports each
  school and optional owner in one transaction. The config's `import_file` is
  used if no argument is supplied. A malformed row stops with an explicit error;
  earlier successful rows remain committed. The import is intentionally not
  deduplicated; inspect the source before running it twice.
- Action logs redact password/secret/token fields. Run
  `php tools/redact_action_logs.php` once after upgrading an existing database:
  it replaces entire legacy details containing credential fields (including
  multiline values), retaining the other log columns. It is safe to rerun.
  This has already been applied to the local database copy.
- `NOMINATIM_ENDPOINT` can point to a test endpoint. Only a loopback endpoint
  bypasses the public geocoder's one-request-per-second limiter.
- `Encoding.php` remains as an unused legacy file, but is no longer loaded.
  Advanced markers and data-encoding repairs remain outside this change.

### Coverage

Automated checks exercise role/action combinations, owner boundaries, forged
fields, revoked roles, unauthenticated requests, session rotation/logout, CSRF,
HTTP methods, direct action access, required fields, numeric input, NULL/Unicode/
quotes, create replay, backups/rollback, delete/restore, query injection attempts,
counts/pagination, reviews/XML and rendered escaping, export headers/body,
successful/empty/unavailable/malformed geocoder responses, bulk geocoding,
CLI import, and idempotent historical-log redaction. Browser tests exercise
owner editing and the manager create/review/delete/restore workflow.

---

## 1. Scope

The admin side is a single front controller, `controller.php`, that authenticates
the session and then runs `require_once $action . ".php"`. Every admin feature is
an `action`:

| Action | File | Purpose | Intended role |
|---|---|---|---|
| `login` / `logout` / `default` | `authenticate.php`, `login.php`, `logout.php` | Session login, logout, landing page | all |
| `adminlist` | `adminlist.php` | List, sort, search and paginate schools with their reviews | reviewer+ |
| `create` → `add` | `create.php`, `add.php` | New-school form, then insert and geocode | reviewer+ |
| `edit` → `update` | `edit.php`, `update.php` | Edit form, then back up the old row, update and re-geocode | school owner (own school only), reviewer+ |
| `delete` | `delete.php` | Soft delete (`deleted=1`, `deleteddate`) | admin (privlevel > 9) |
| `addreview` / `updatereview` | `addreview.php`, `updatereview.php` | XHR review entries (XML response) | reviewer+ |
| `export` | `export.php` | Tab-separated dump of active schools | admin |
| `geocode` | `geocode.php` | Bulk geocode of rows with `lat IS NULL` | admin |
| CLI `fixgeocode` | `controller.php` | Command-line bulk geocode | operator |
| `import` | `import.php` | Bulk import from a hard-coded Windows path | operator |

Supporting code: `CGMSDBObj.php` (data layer), `CGMSDBForm.php` plus
`templates/schooltemplates.txt` (form rendering), and the tables `schools`,
`schools_backup`, `schoolreviews`, `users`, `actionslog` and the
`school_reviews_view` view.

Out of scope: `cgmsdbadmin/` is a bundled phpMyAdmin 4.2.5, not application
code. It should be removed or replaced rather than tested. `CGMSDBObjTemp.php`
has been removed; the legacy `geocode2.php` maintenance script now uses
`CGMSDBObj` and only runs from the command line.

### Data-layer regression check

Run `php tests/cgms_db_test.php` using the external database configuration.
It uses a connection-local temporary table, not school records, to check prepared
bindings, insert/update/delete, NULL and zero values, text round trips, reserved
column names, first-row/cursor behavior, counts and pagination. Raw WHERE
clauses passed to `selectSQL` or `countRows` must use `?` placeholders and the
optional parameter array for untrusted values; accepting a raw clause does not
make that clause safe automatically.

## 2. Pre-conditions found during analysis

These must be resolved before any functional test can pass on PHP 8.x. They are
the first tests to run, and are expected to **fail today**:

1. **Fatal parse error.** `controller.php` includes `Encoding.php`, which uses
   `$text{$i}` string offsets. That syntax was removed in PHP 8, so every admin
   URL returns a parse error. The class is never used, so the include can simply
   be dropped. **Resolved:** the unused include and namespace import were removed;
   the legacy helper remains on disk but is not loaded.
2. **Short open tags.** 13 admin files (including `authenticate.php` and
   `CGMSDBForm.php`) start with `<?`. With `short_open_tag=Off` (the default,
   and the setting here) their source is printed instead of executed.
3. **Hard-coded database credentials** in `CGMSDBObj.php`. Tests need to point
   at a test database, so these must come from configuration or the environment.
4. **`eval()`-built parameter binding** in `CGMSDBObj`. It works, but it is a
   PHP 8.5 and maintainability risk. The data-layer tests below are designed to
   survive replacing it.

## 3. Test environment

- **Database:** a disposable `schools_test` database. It is created from the
  schema plus a small seed fixture, and reset before each test run (or each
  destructive test). Never run tests against the restored production copy.
- **Seed fixture:**
  - Users at privlevel 1 (owner of school A), 5 (reviewer), 7 (editor),
    9 (exists in the data but has no constant) and 10 (admin).
  - Schools:
    - A — owned, US.
    - B — not owned, Canada.
    - C — already soft-deleted.
    - D — UTF-8 name and address, e.g. `Escola Pró-Saber`, `Řičany`.
    - E — quotes and apostrophes in the name.
    - F — `lat`/`lng` NULL.
  - One existing review on school A.
- **Geocoder:** stub Nominatim. Make the endpoint configurable, e.g. a
  `NOMINATIM_ENDPOINT` environment variable, and serve fixed responses from a
  local stub. Tests must not depend on the network or on the 1 request/second
  rate limit, and must be able to simulate "no result" and HTTP errors.
- **Server:** the existing local `php -S` task, run with `error_reporting=E_ALL`
  and `display_errors=0`. Every test also asserts that the PHP error log gained
  no new warnings or deprecations.
- **Tooling:**
  - **PHPUnit** for data-layer and request-handler integration tests.
  - **Playwright** for end-to-end browser flows. The UI relies on
    `window.close()`, `confirm()` dialogs, XHR review calls and JavaScript form
    validation, so these need a real browser.
  - The existing `tests/runtime_smoke.py` stays as a quick read-only check.

## 4. Authorization matrix (highest priority)

Authorization today is only enforced at login (landing page choice) and in
`delete.php`. Every other action trusts any logged-in user. Each cell below is a
test that requests the action directly, without going through the UI.

Roles (decided 2026-10-23). The editor level (7) is dropped; no users have it.

| Level | Role | Users today | Can do |
|---|---|---|---|
| 1 | School owner | 3,342 | Edit their own school's information |
| 5 | Reviewer | 0 (kept for future use) | View the admin list; add and update reviews |
| 9 | School manager | 4 | Reviewer rights, plus create, edit any school, delete, and restore |
| 10 | Admin | 7 | Everything, plus export and bulk geocode |

| Action | Anonymous | Owner (1) – own school | Owner (1) – other school | Reviewer (5) | Manager (9) | Admin (10) |
|---|---|---|---|---|---|---|
| `adminlist` | login page | deny | deny | allow | allow | allow |
| `edit` / `update` | login page | allow (school-info fields only) | **deny** | deny | allow | allow |
| `create` / `add` | login page | deny | deny | deny | allow | allow |
| `delete` / `restore` | login page | deny | deny | deny | allow | allow |
| `addreview` / `updatereview` | login page | deny | deny | allow | allow | allow |
| `export` / `geocode` | login page | deny | deny | deny | deny | allow |
| `import`, unknown action, `../anything` | login page | deny | deny | deny | deny | deny |

"Deny" must also mean that no database change happened. Verify this by checking
the row before and after.

Owner field restrictions: an owner may change contact details, address, web,
phone numbers, ages taught, and programs/services. Owners may not change
`deleted`, `deleteddate`, `approved`, record-user and recovery fields
(`recuser`, `recpass`, `recsecretq`, `recsecreta`), `lastmodified` or
`lastmodifiedby`. Posting those fields directly must be ignored (**OWN-01**),
and owners never see the admin-only blocks (**OWN-02**).

## 5. Functional test cases

### 5.1 Authentication and session
- **AUTH-01:** A valid login for each role lands on the right page. An owner
  goes to their school's edit form; a reviewer or above goes to `adminlist`.
- **AUTH-02:** A wrong password, an unknown user, or an empty
  username/password is rejected with no session created.
- **AUTH-03:** A user whose `schoolid` is 0 or points to a missing school is
  handled sensibly. 27 such users exist in the data.
- **AUTH-04:** Logout clears the session. The back button or a replayed cookie
  must not give access.
- **AUTH-05:** Changing a user's password in the database invalidates their
  existing sessions (current behaviour; keep it).
- **AUTH-06:** The session ID changes at login (session-fixation protection).
- **AUTH-07:** Login credentials are **not** written to `actionslog` (see §6).

### 5.2 List, search and paginate (`adminlist`)
- **LIST-01:** The default list shows 40 rows, the correct total, and
  Previous/Next/first/last links that land on the right offsets, including the
  last page and an exact multiple of 40.
- **LIST-02:** Each sort option (`id`, `name`, `recent`, `oldest`,
  `unreviewed`, `mine`) orders correctly. `mine` shows only rows modified or
  reviewed by the current user.
- **LIST-03:** Keyword search:
  - single word, multi-word (AND), across the indexed fields;
  - a word containing an apostrophe (`Children's`);
  - UTF-8 input (`Pró`);
  - a one-character keyword falls back to the full list.
- **LIST-04:** ID search: a single ID, a space-separated list, ranges (`>100`,
  `<200`, `>100 <200`), and invalid input shows the "not found" message.
- **LIST-05:** Column sub-sort only accepts real column names.
- **LIST-06:** Soft-deleted schools do not appear (the view filters
  `deleted = 0`).
- **LIST-07:** Each row shows its review history and "last modified by" name,
  and "No reviews yet" when there are none.
- **LIST-08:** Search and paging state is preserved through
  Create/Edit → save → return.

### 5.3 Create (`create` → `add`)
- **CRT-01:** The form renders every field, checkbox and dropdown (state,
  country, school type).
- **CRT-02:** Client-side validation blocks submission when a required field is
  missing (`schoolname`, `address1`, `city`, `infoemail`, `web`).
- **CRT-03:** Server-side validation. Posting directly without the JavaScript
  must still reject missing or over-length fields. Today there is none; this is
  expected to fail.
- **CRT-04:** A successful insert sets:
  - every submitted field;
  - `lastmodifiedby`;
  - `deleted=0`;
  - geocoded `lat`/`lng` (from the stub).
- **CRT-05:** When the geocoder returns no result or an error, the school is
  still saved and flagged, with `lat` NULL so bulk geocode picks it up. It must
  not produce a 500 error.
- **CRT-06:** "Outside US and Canada" stores `altstateprovince`. `http://` and
  `https://` are stripped from `web`. A `montallday` checkbox sent as `on`
  is stored as 1.
- **CRT-07:** UTF-8, quotes, `<`, `&` and emoji round-trip exactly into the
  database and back into the edit form.
- **CRT-08:** A duplicate submission (double click or refresh) does not create
  two schools.
- **CRT-09:** The new school appears in the public map feed
  (`search/js2/getschools.php`) at the geocoded position.

### 5.4 Read and edit (`edit`)
- **EDT-01:** The form is pre-filled with the current values, checkboxes and
  selected dropdown options.
- **EDT-02:** Values containing `"` display correctly. Today `edit.php`
  silently strips double quotes from every field, so saving loses data. Record
  this as a known defect.
- **EDT-03:** A missing, non-numeric or non-existent `id` shows a clean error,
  with no SQL error and no blank form that could be saved over another school.
- **EDT-04:** The admin-only blocks (delete link, record-user info) show only
  for privlevel > 9.

### 5.5 Update (`update`)
- **UPD-01:** Changed fields are saved. `lastmodified` and `lastmodifiedby` are
  updated.
- **UPD-02:** A full copy of the previous row is written to `schools_backup`,
  with `origid` set to the school's ID, before the update.
- **UPD-03:** Checkbox semantics: an unchecked box sets the integer field to 0,
  and a checked box sets it to 1. Integer fields that are not on the form must
  not be zeroed. Today `deleted`, `approved` and `numberstudents` are reset to
  0 when absent; confirm whether that is intended.
- **UPD-04:** An empty `address1` with `address2` filled promotes `address2`
  into `address1`.
- **UPD-05:** Changing the address re-geocodes and moves the marker on the
  public map. An unchanged address should not require a geocoder call.
- **UPD-06:** An update with no changes is a no-op and shows no error.
- **UPD-07:** Two editors saving the same school: decide the expected behaviour
  (last write wins vs. a conflict warning) and test it.
- **UPD-08:** A database error shows a friendly message, and the backup row is
  not orphaned (use a transaction).

### 5.6 Delete (`delete`)
- **DEL-01:** An admin delete sets `deleted=1` and `deleteddate=today`. The row
  is not physically removed, and its reviews remain.
- **DEL-02:** The confirm dialog: Cancel leaves the row unchanged.
- **DEL-03:** A deleted school disappears from `adminlist`, from the public map,
  and from `export`. It appears in the public map only with `deleted=true`.
- **DEL-04:** Deleting an already-deleted or non-existent ID is handled cleanly.
- **DEL-05:** Delete requires POST plus a CSRF token. Today it is a GET link, so
  this is expected to fail.
- **DEL-06 (new feature?):** Restore a deleted school. There is currently no UI
  for it; confirm whether one is wanted.

### 5.7 Reviews (`addreview`, `updatereview`)
- **REV-01:** Adding a review returns XML with `ResultCode` 0 and the new
  `ResultID`, and the row appears in the list without a page reload.
- **REV-02:** A second Add on the same inline form updates that review instead of
  inserting a duplicate.
- **REV-03:** Updating a review changes the status, comments, date and user.
- **REV-04:** Each status value from `list-reviewstatus` is accepted. Arbitrary
  values are rejected.
- **REV-05:** Comments containing `<`, `&`, quotes, newlines and UTF-8
  characters produce well-formed XML and display correctly. Today the result
  message is not escaped, so this is expected to fail.
- **REV-06:** A review for a non-existent school, or an update to someone else's
  review, is rejected according to the rules in §10.
- **REV-07:** The `unreviewed` sort reflects new reviews.

### 5.8 Export, bulk geocode and import
- **EXP-01:** The export header row matches the columns, with one line per
  active school. Tabs and newlines inside values are flattened.
  - The response should be a downloadable TSV (`Content-Type`, filename).
  - Today an HTML footer is appended to the data.
  - Exported UTF-8 must be valid.
- **GEO-01:** Bulk geocode fills `lat`/`lng` for schools with `lat IS NULL`
  only, reports the count, and leaves no-result rows NULL. It must respect the
  rate limit and not time out on large batches.
- **GEO-02:** CLI `php controller.php fixgeocode` behaves the same way. It must
  terminate when every address part fails; today the address-shrinking loop can
  run past an empty address.
- **IMP-01:** `import` is not reachable over HTTP. If it is kept as a CLI tool:
  - the path is configurable;
  - a fixture TSV imports the expected schools and owner users;
  - rows without a name or address are skipped;
  - a failure stops without partial users.

### 5.9 Audit trail
- **LOG-01:** Every action writes one `actionslog` row with the user, the action
  and the request details.
- **LOG-02:** Passwords and other secrets are never logged. The current
  database already holds about 17,900 log rows containing a submitted password.
  Consider purging or redacting these in production.
- **LOG-03:** A failed authorization attempt is logged.

## 6. Security tests

Run them as automated negative tests. Each should fail today and pass after the
fix.

| ID | Area | Test |
|---|---|---|
| SEC-01 | File inclusion | `action=import`, `action=../search/index`, `action=CGMSDBObj`, `action=nonexistent` must all be rejected by an allow-list. |
| SEC-02 | SQL injection | `id` in `edit`, `update` and `delete` (built by string concatenation in `getRow`, `update` and `delete`). |
| SEC-03 | SQL injection | `adminlist` `idtarget` (`>0) OR (1=1`), `keywords` (backslash and quote combinations), and the `sort=mine` username. |
| SEC-04 | XSS | Stored: a school name, address or review comment containing `<script>`, rendered in the list, the edit form and the review XML. Reflected: `status`, `keywords`, `idtarget`, `start`, `sort` in hidden inputs. |
| SEC-05 | CSRF | Cross-site POST/GET to `update`, `add`, `delete`, `addreview` must be refused (token plus SameSite cookie). |
| SEC-06 | Passwords | Stored hashed (`password_hash`), never in the session, never logged. Today all are plaintext. Includes a migration test that existing users can still log in after rehashing. |
| SEC-07 | Session | Regenerated at login, destroyed at logout, cookie flags `HttpOnly`/`Secure`/`SameSite`. |
| SEC-08 | Privilege | Every cell of the §4 matrix, including direct POSTs that skip the UI. |
| SEC-09 | Error leakage | SQL errors and stack traces are never shown to the browser. |

## 7. Data integrity and PHP 8.5 checks

- **INT-01:** A field at its maximum column length saves and displays intact.
  One character over is rejected or warned, never silently truncated.
- **INT-02:** Numeric fields (`yearfounded`, `numberstudents`, `lat`/`lng`)
  reject non-numbers. Today `CGMSDBObj::setValue` converts any non-numeric
  value to 0.
- **INT-03:** Editing one of the rows listed in `reports/garbled-entries.csv`
  does not make its encoding worse. The value is saved byte-for-byte as
  submitted.
- **INT-04:** Run the whole suite on PHP 8.4 and on PHP 8.5 with `E_ALL`. Zero
  deprecations, warnings or notices are allowed.
- **INT-05:** Public-site consistency. After every create, update and delete,
  `getschools.php` reflects the change (school added, moved or removed).

## 8. Approach and order of work

1. **Make it run.** Fix §2 items 1–3 behind a smoke test that logs in as each
   role and opens each page with no PHP errors.
2. **Characterize.** Write the §5 tests against current behaviour. Mark the
   known defects as expected failures so the suite is green and protects
   against regressions.
3. **Lock it down.** Implement the §4 matrix and the §6 fixes, turning expected
   failures into passes one at a time.
4. **Refactor.** Replace `CGMSDBObj`'s `eval` and string SQL with prepared
   statements, with the §5 tests as the safety net.
5. **Run continuously.** Add a VS Code task and a CI job (reset the test
   database, start the server, run PHPUnit and Playwright).

## 9. Exit criteria

- Every §4 matrix cell passes.
- Every §5 test passes or is a documented, accepted known defect.
- Every §6 test passes.
- No new PHP log entries on 8.4 or 8.5.
- The public map regression tests still pass.

## 10. Decisions (2026-10-23)

- **Roles:** as in §4.
- **Concurrent edits:** last save wins. UPD-07 tests exactly that.
- **Geocoding failure:** the school is saved with `lat`/`lng` empty and a
  warning is shown (CRT-05, UPD-05).
- **Number fields not on the form** are left unchanged on update (UPD-03).
- **Double quotes:** the edit form no longer strips them (EDT-02).
- **Server-side required fields:** `schoolname`, `address1`, `city`,
  `infoemail`, `web`. `UNKNOWN` is allowed.
- **Delete and all saves** use POST with a CSRF token (DEL-05, SEC-05). A
  restore action is added for managers and admins (DEL-06).
- **Database credentials** come from a git-ignored config file outside the web
  root.
- **`import.php`** stays as a command-line tool with a configurable path. It is
  unreachable through `controller.php` (IMP-01, SEC-01).
- **`actionslog`:**
  - Passwords are no longer logged.
  - Existing rows in the local copy are redacted.
  - Production cleanup is a separate manual step.
- **Passwords** stay in plain text for now. SEC-06 is deferred.
- **`cgmsdbadmin/`** (phpMyAdmin) is deleted from the project.
- **`<?` tags** are converted to `<?php`, even though `short_open_tag` is now
  on locally.
- **Tests** run against a `schools_test` database, using PHPUnit (Composer) and
  Playwright (npm).
- **First round:** make it run, then permissions, security fixes, and tests.
