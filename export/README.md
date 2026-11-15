# School Map Export

This is a lightweight LAMP-friendly PHP app for exporting school records from MySQL by drawing an area on a map.

## Features

- Map opens centered on the United States.
- `Point + Radius` mode lets you click a center point and enter a radius in miles.
- `Polygon` mode lets you draw a closed polygon with as many points as needed.
- Live match counts show how many schools currently meet the map selection and active filters.
- Filters include `approved`, `schooltype`, and program-type checkboxes such as `infants`, `toddlers`, `lowerel`, `upperel`, `middle`, and `highschool` when those columns exist.
- Export column selection lets you choose exactly which fields appear in the CSV.
- Completed selections can be exported to CSV.
- Backend uses PDO and works directly against your existing `schools` table.

## Files

- `index.php`: frontend map UI
- `export.php`: CSV export endpoint
- `selection_api.php`: metadata and live count endpoint
- `lib/app.php`: shared database and geometry helpers
- `config.php`: database and app configuration

## Setup

1. Put this folder on your Apache/PHP host.
2. Edit `config.php` with your MySQL connection details.
3. Make sure PHP has the `pdo_mysql` extension enabled.
4. Visit `index.php` in your browser.

## Configuration

`config.php` supports either direct edits or environment variables:

- `APP_DEBUG`
- `APP_ERROR_LOG`
- `DB_HOST`
- `DB_PORT`
- `DB_NAME`
- `DB_USER`
- `DB_PASS`
- `DB_CHARSET`
- `SCHOOLS_TABLE`
- `SCHOOLS_EXTRA_WHERE`

By default, the app uses:

- table: `schools`
- extra filter: `deleted = 0`

If you want to export all rows regardless of soft delete status, set:

```php
'schools_extra_where' => '',
```

To surface the real PHP exception in the browser while debugging, turn this on temporarily:

```php
'debug' => true,
```

The app also writes PHP errors to the configured log file. By default that is:

```text
logs/app.log
```

Make sure your web server user can write to the `logs/` directory.

## Notes

- The map uses Leaflet, Leaflet.draw, and OpenStreetMap tiles loaded from public CDNs.
- Polygon filtering is done in PHP after a bounding-box query narrows the candidate rows.
- Radius filtering uses a bounding-box prefilter plus Haversine distance checks in miles.
- Program-type filters treat a program column as present when its value is greater than `0`.
- If multiple program types are checked, you can choose `match any` or `match all`.
- By default, the CSV includes all columns returned by `SHOW COLUMNS FROM schools`, but the UI now lets you export a smaller selected subset.
- If exports fail with a blank or generic message, enable `debug`, retry once, and then check `logs/app.log` for the exact server-side exception.
