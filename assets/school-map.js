let map;
let markerCluster;
let activeRequest;
const schoolMarkers = [];
const mapScript = document.currentScript;

async function initializeSchoolMap() {
    const { Map } = await google.maps.importLibrary('maps');
    map = new Map(document.getElementById('map'), {
        center: {
            lat: Number(window.centerLatitude) || 40.8157,
            lng: Number(window.centerLongitude) || -73.1187
        },
        zoom: Number(window.startZoom) || 9,
        mapTypeControl: true,
        scaleControl: true
    });
    markerCluster = new MarkerClusterer(map, []);
    map.addListener('idle', loadVisibleSchools);
}

async function loadVisibleSchools() {
    if (!map || !markerCluster) {
        return;
    }

    const bounds = map.getBounds();
    if (!bounds) {
        return;
    }

    activeRequest?.abort();
    activeRequest = new AbortController();
    const southWest = bounds.getSouthWest();
    const northEast = bounds.getNorthEast();
    const requestUrl = new URL(mapScript.dataset.endpoint, window.location.href);
    requestUrl.search = new URLSearchParams({
        swlat: String(southWest.lat()),
        nelat: String(northEast.lat()),
        swlng: String(southWest.lng()),
        nelng: String(northEast.lng())
    });

    setMapStatus('Loading schools…');
    try {
        const response = await fetch(requestUrl, { signal: activeRequest.signal });
        if (!response.ok) {
            throw new Error(`School lookup failed with HTTP ${response.status}.`);
        }
        const result = await response.json();
        if (!Array.isArray(result.datarray)) {
            throw new Error('School lookup returned an invalid response.');
        }
        showSchools(result.datarray);
    } catch (error) {
        if (error.name === 'AbortError') {
            return;
        }
        console.error(error);
        setMapStatus('Schools could not be loaded.');
    }
}

function showSchools(schools) {
    markerCluster.clearMarkers();
    for (const marker of schoolMarkers) {
        marker.setMap(null);
    }
    schoolMarkers.length = 0;

    const infoWindow = new google.maps.InfoWindow();
    for (const school of schools) {
        const position = {
            lat: Number(school.latitude),
            lng: Number(school.longitude)
        };
        if (!Number.isFinite(position.lat) || !Number.isFinite(position.lng)) {
            continue;
        }

        const marker = new google.maps.Marker({
            position,
            title: String(school.name ?? '')
        });
        marker.addListener('click', () => {
            const content = document.createElement('div');
            const name = document.createElement('strong');
            name.textContent = String(school.name ?? '');
            content.append(name);
            const address = [school.address, school.city, school.stateprovince]
                .filter(Boolean)
                .map(String)
                .join(', ');
            if (address) {
                const addressLine = document.createElement('div');
                addressLine.textContent = address;
                content.append(addressLine);
            }
            infoWindow.setContent(content);
            infoWindow.open({ map, anchor: marker });
        });
        schoolMarkers.push(marker);
    }

    markerCluster.addMarkers(schoolMarkers);
    renderSchoolList(schools);
    setMapStatus(`${schools.length} schools found.`);
}

function renderSchoolList(schools) {
    const list = document.getElementById('schoollist');
    if (!list) {
        return;
    }
    list.replaceChildren();
    for (const school of schools) {
        const button = document.createElement('button');
        button.type = 'button';
        button.textContent = String(school.name ?? 'School');
        button.addEventListener('click', () => {
            map.panTo({
                lat: Number(school.latitude),
                lng: Number(school.longitude)
            });
            map.setZoom(Math.max(map.getZoom(), 12));
        });
        list.append(button, document.createElement('br'));
    }
}

function setMapStatus(message) {
    const status = document.getElementById('curcount');
    if (status) {
        status.textContent = message;
    }
}

window.addEventListener('load', () => {
    initializeSchoolMap().catch((error) => {
        console.error(error);
        setMapStatus('The map could not be loaded.');
    });
});
