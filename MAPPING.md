# Mapping configuration

The school-directory map pages use the current Google Maps JavaScript API. The
API key is read from the `GOOGLE_MAPS_API_KEY` environment variable, or else from
`google_maps_api_key` in the external config file (see `config.sample.php`), and
is not stored in the source tree. If neither is set, the map pages fail and the
reason is written to the PHP error log. Restrict the browser key to the Maps
JavaScript API and the site's HTTP referrers.

Address lookup uses the Nominatim Search API. Set `NOMINATIM_CONTACT_EMAIL` to
an address monitored by the directory operator. Requests identify the
application with that contact address and are rate-limited to one request per
second across PHP workers on the same host.

School address lookups try the full address first, followed by street/postal
code without the postal city. On no match, they try the street without its
leading number, then city/state/country without street or postal code, then
state/country without city. Broader queries require a country and never fall
back to the whole country. Approximate street/city/state results are saved but
explicitly flagged in the admin save/retry response; the stored address is not
changed. Precision is not persisted separately. Errors from the service are
reported rather than treated as address misses. The Quebec province name is
normalized to ASCII `Quebec`, including known legacy encoding variants.

In the admin list, use **Schools without geolocations** (or the matching
checkbox) to find missing, invalid, or placeholder `(0, 0)` coordinates.
Level-10 admins can retry one listing at a time; the existing bulk operation
and `php controller.php fixgeocode` process active schools still missing a
valid location. Retries back up records and do not overwrite existing valid
coordinates. Broad fallback locations will no longer appear in this list.

Searches on the `search/` map that name a city, state/province (name or
two-letter code, optionally as `City, ST`), or country are also looked up in
Nominatim (`includes/school-search.php`), and the map zooms to that place.
Searches that are not recognisable places (for example a school name) zoom to
fit the matching schools instead. Place lookups, including misses, are cached
for 30 days in the system temp directory as `schools-place-cache-*.json`.

`search/js2/getschools.php` returns JSON (`{"datarray": [...]}`) for the
visible map bounds plus any search filters; text values are HTML-escaped for
display. A state name or code filters on the school's state rather than
matching it as a substring.

The map data endpoints in `mapping/js2/data_deals.php` and
`mappingnew/js2/data_deals.php` return JSON for the visible map bounds. The
`mapping/` and `mappingnew/` map pages load the shared map implementation from
`assets/school-map.js`; the `layers/` directory reuses the canonical
`search/` school-map pages.

## Local runtime checks

In VS Code, run **Start local PHP webserver** to serve the project at
`http://127.0.0.1:8765`. The server binds to localhost only and securely
prompts for the Maps key each time; the key is not saved in the task file.
Restrict the key to the Maps JavaScript API and the local HTTP referrer.

Run **Run local runtime smoke test** to check that the map pages render and
that both database-backed map endpoints return the expected JSON shape and
reject invalid bounds. It automatically starts the local server if needed.
The checks are read-only and require the local MySQL `schools` database to be
available to the existing map endpoint configurations. The smoke test uses
Python 3's standard library and does not require installed packages.
