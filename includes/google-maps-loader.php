<?php

require_once __DIR__ . '/config.php';

$googleMapsApiKey = getenv('GOOGLE_MAPS_API_KEY') ?: (schoolsConfig()['google_maps_api_key'] ?? '');
if (!is_string($googleMapsApiKey) || trim($googleMapsApiKey) === '') {
    throw new RuntimeException('Google Maps API key missing: set google_maps_api_key in the config file or the GOOGLE_MAPS_API_KEY environment variable.');
}
?>
<script>
((g) => {
    const h = window;
    const n = document;
    const a = h.google || (h.google = {});
    const b = a.maps || (a.maps = {});
    const r = new Set();
    const e = new URLSearchParams();
    let pending;
    const load = () => pending || (pending = new Promise((resolve, reject) => {
        const script = n.createElement('script');
        e.set('libraries', [...r].join(','));
        for (const key in g) {
            e.set(key.replace(/[A-Z]/g, (letter) => '_' + letter.toLowerCase()), g[key]);
        }
        e.set('callback', 'google.maps.__init');
        b.__init = resolve;
        script.src = 'https://maps.googleapis.com/maps/api/js?' + e;
        script.onerror = () => reject(new Error('Google Maps JavaScript API could not be loaded.'));
        script.async = true;
        n.head.append(script);
    }));
    if (b.importLibrary) {
        console.warn('Google Maps JavaScript API has already been loaded.');
        return;
    }
    b.importLibrary = (library, ...args) => {
        r.add(library);
        return load().then(() => b.importLibrary(library, ...args));
    };
})({key: <?= json_encode($googleMapsApiKey, JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT) ?>, v: 'weekly'});
</script>
