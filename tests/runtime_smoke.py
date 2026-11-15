#!/usr/bin/env python3
"""Read-only HTTP smoke tests for the local PHP school-map application."""

import json
import sys
from urllib.error import HTTPError, URLError
from urllib.parse import urlencode
from urllib.request import urlopen


BASE_URL = "http://127.0.0.1:8765"
TIMEOUT_SECONDS = 10


def get(path):
    with urlopen(BASE_URL + path, timeout=TIMEOUT_SECONDS) as response:
        return response.status, response.headers, response.read()


def expect_page(path, text):
    status, headers, body = get(path)
    rendered = body.decode("utf-8")
    assert status == 200, f"{path}: expected HTTP 200, received {status}"
    assert headers.get_content_type() == "text/html", (
        f"{path}: expected HTML, received {headers.get_content_type()}"
    )
    assert text in rendered, f"{path}: missing rendered page text {text!r}"
    assert "Fatal error" not in rendered and "Warning:" not in rendered, (
        f"{path}: PHP error appeared in the rendered response"
    )


def expect_map_data(path):
    query = urlencode(
        {"swlat": -90, "nelat": 90, "swlng": -180, "nelng": 180}
    )
    status, headers, body = get(f"{path}?{query}")
    assert status == 200, f"{path}: expected HTTP 200, received {status}"
    assert headers.get_content_type() == "application/json", (
        f"{path}: expected JSON, received {headers.get_content_type()}"
    )
    payload = json.loads(body)
    assert isinstance(payload.get("datarray"), list), (
        f"{path}: response must contain a datarray list"
    )
    assert payload["datarray"], (
        f"{path}: no schools returned; confirm the local MySQL database is available"
    )
    first_school = payload["datarray"][0]
    required_fields = {
        "id",
        "name",
        "address",
        "city",
        "stateprovince",
        "latitude",
        "longitude",
    }
    assert required_fields <= first_school.keys(), (
        f"{path}: school record is missing expected fields"
    )
    return len(payload["datarray"])


def expect_invalid_bounds(path):
    query = urlencode(
        {"swlat": 91, "nelat": 90, "swlng": -180, "nelng": 180}
    )
    try:
        get(f"{path}?{query}")
    except HTTPError as error:
        assert error.code == 400, (
            f"{path}: invalid bounds returned HTTP {error.code}, expected 400"
        )
        payload = json.loads(error.read())
        assert "error" in payload, f"{path}: error response must be JSON"
    else:
        raise AssertionError(f"{path}: invalid bounds should return HTTP 400")


def expect_state_search():
    # A state name must filter by state, not substring-match (e.g. "Rivermont" for "Vermont").
    query = urlencode(
        {"swlat": -90, "nelat": 90, "swlng": -180, "nelng": 180, "keywords": "Vermont"}
    )
    _, _, body = get(f"/search/js2/getschools.php?{query}")
    schools = json.loads(body)["datarray"]
    assert schools, "Vermont search returned no schools"
    assert {school["stateprovince"] for school in schools} == {"Vermont"}, (
        "Vermont search returned schools outside Vermont"
    )


def main():
    try:
        expect_page("/search/index.php", "Montessori Schools Map View")
        # Loading the map at /search (no trailing slash) must not break relative asset URLs.
        for required in (
            'src="/search/pleasewait.html"',
            'src="/search/js2/cgms_mapping_lib3.php?',
            "window.addEventListener('load', init)",
        ):
            expect_page("/search", required)
        expect_page("/layers/index.php", "Montessori Schools Map View")
        expect_page("/mapping/index.php", "Restaurant Specials")
        expect_page("/mappingnew/index.php", "Montessori Schools Map View")

        expect_state_search()
        # The whole data set must be valid JSON; a parse failure used to cause endless re-requests.
        counts = {
            path: expect_map_data(path)
            for path in (
                "/search/js2/getschools.php",
                "/mapping/js2/data_deals.php",
                "/mappingnew/js2/data_deals.php",
            )
        }
        for path in counts:
            expect_invalid_bounds(path)

        print("Runtime smoke test passed.")
        for path, count in counts.items():
            print(f"  {path}: {count} school records returned")
        return 0
    except (AssertionError, HTTPError, URLError, TimeoutError, json.JSONDecodeError) as error:
        print(f"Runtime smoke test failed: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
