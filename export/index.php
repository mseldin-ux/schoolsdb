<?php

declare(strict_types=1);

$config = require __DIR__ . '/config.php';
$appTitle = $config['app_title'] ?? 'School Map Export';
$debugEnabled = !empty($config['debug']);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= htmlspecialchars((string) $appTitle, ENT_QUOTES, 'UTF-8') ?></title>
    <link rel="preconnect" href="https://unpkg.com">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet-draw@1.0.4/dist/leaflet.draw.css">
    <style>
        :root {
            --bg: #f3f0e8;
            --panel: rgba(255, 252, 245, 0.95);
            --text: #1c2a39;
            --muted: #576577;
            --accent: #146c78;
            --accent-strong: #0f5360;
            --outline: rgba(18, 56, 73, 0.15);
            --soft-outline: rgba(18, 56, 73, 0.08);
            --selection-fill: rgba(20, 108, 120, 0.22);
            --selection-stroke: #146c78;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: "Trebuchet MS", "Segoe UI", sans-serif;
            color: var(--text);
            background:
                radial-gradient(circle at top left, rgba(226, 198, 141, 0.35), transparent 34%),
                radial-gradient(circle at bottom right, rgba(20, 108, 120, 0.18), transparent 28%),
                var(--bg);
        }

        .app-shell {
            min-height: 100vh;
            display: grid;
            grid-template-columns: minmax(320px, 420px) 1fr;
            gap: 16px;
            padding: 16px;
        }

        .panel,
        .map-panel {
            border: 1px solid var(--outline);
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 18px 50px rgba(28, 42, 57, 0.12);
            backdrop-filter: blur(8px);
        }

        .panel {
            background: var(--panel);
            padding: 22px 20px;
            overflow-y: auto;
            max-height: calc(100vh - 32px);
        }

        .map-panel {
            position: relative;
            min-height: 680px;
            background: #d8e7ec;
        }

        #map {
            width: 100%;
            height: 100%;
            min-height: 680px;
        }

        h1 {
            margin: 0 0 10px;
            font-size: 1.85rem;
            line-height: 1.1;
        }

        h2 {
            margin: 0 0 12px;
            font-size: 1rem;
        }

        .lede {
            margin: 0 0 22px;
            color: var(--muted);
            line-height: 1.5;
        }

        .section {
            margin-bottom: 18px;
            padding: 16px;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.62);
            border: 1px solid var(--soft-outline);
        }

        .label {
            display: block;
            margin-bottom: 8px;
            font-size: 0.95rem;
            font-weight: 700;
            letter-spacing: 0.02em;
        }

        .tool-grid,
        .button-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }

        button,
        input,
        select {
            font: inherit;
        }

        .tool-button,
        .primary-button,
        .secondary-button,
        .ghost-button {
            width: 100%;
            border-radius: 12px;
            border: 1px solid transparent;
            padding: 12px 14px;
            cursor: pointer;
            transition: transform 0.16s ease, box-shadow 0.16s ease, background 0.16s ease;
        }

        .tool-button,
        .secondary-button,
        .ghost-button {
            background: #ffffff;
            color: var(--text);
            border-color: rgba(20, 108, 120, 0.16);
        }

        .tool-button.active {
            background: var(--accent);
            color: #ffffff;
            box-shadow: 0 10px 24px rgba(20, 108, 120, 0.2);
        }

        .primary-button {
            background: var(--accent);
            color: #ffffff;
        }

        .primary-button:disabled,
        .secondary-button:disabled,
        .ghost-button:disabled {
            background: #cbd5d9;
            color: #6a7782;
            cursor: not-allowed;
            box-shadow: none;
            border-color: transparent;
        }

        .tool-button:hover,
        .primary-button:hover:not(:disabled),
        .secondary-button:hover:not(:disabled),
        .ghost-button:hover:not(:disabled) {
            transform: translateY(-1px);
        }

        .field-group {
            margin-bottom: 14px;
        }

        .field-group:last-child {
            margin-bottom: 0;
        }

        .field-group input,
        .field-group select {
            width: 100%;
            border: 1px solid rgba(18, 56, 73, 0.16);
            border-radius: 12px;
            padding: 12px 14px;
            background: rgba(255, 255, 255, 0.92);
        }

        .helper,
        .selection-summary,
        .count-panel,
        .column-summary {
            color: var(--muted);
            font-size: 0.94rem;
            line-height: 1.45;
        }

        .selection-summary,
        .count-panel,
        .debug-panel {
            min-height: 68px;
            padding: 14px;
            border-radius: 14px;
            background: rgba(255, 255, 255, 0.78);
            border: 1px solid var(--soft-outline);
        }

        .count-panel {
            margin-top: 12px;
        }

        .chip-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
        }

        .checkbox-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px 12px;
        }

        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 8px;
            min-width: 0;
            color: var(--text);
        }

        .checkbox-item input {
            width: auto;
            margin: 0;
        }

        .checkbox-item span {
            line-height: 1.3;
        }

        details {
            border-radius: 14px;
            border: 1px solid var(--soft-outline);
            background: rgba(255, 255, 255, 0.7);
            padding: 12px 14px;
        }

        details summary {
            cursor: pointer;
            font-weight: 700;
            color: var(--text);
        }

        .column-list {
            max-height: 230px;
            overflow-y: auto;
            margin-top: 12px;
            padding-right: 4px;
        }

        .column-summary {
            margin-top: 8px;
        }

        .actions {
            display: grid;
            gap: 10px;
        }

        .status-banner {
            position: absolute;
            right: 18px;
            bottom: 18px;
            z-index: 500;
            max-width: 360px;
            padding: 12px 14px;
            border-radius: 14px;
            background: rgba(255, 252, 245, 0.94);
            border: 1px solid rgba(18, 56, 73, 0.12);
            color: var(--text);
            box-shadow: 0 16px 30px rgba(28, 42, 57, 0.12);
        }

        .hidden {
            display: none;
        }

        @media (max-width: 1120px) {
            .app-shell {
                grid-template-columns: 1fr;
            }

            .panel {
                max-height: none;
            }

            .map-panel,
            #map {
                min-height: 60vh;
            }
        }

        @media (max-width: 640px) {
            .tool-grid,
            .button-row,
            .checkbox-grid,
            .chip-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="app-shell">
        <aside class="panel">
            <h1><?= htmlspecialchars((string) $appTitle, ENT_QUOTES, 'UTF-8') ?></h1>
            <p class="lede">Draw an area on the map, filter the matching schools, preview how many records qualify, and download exactly the columns you want.</p>

            <section class="section">
                <h2>Selection Tool</h2>
                <div class="tool-grid">
                    <button id="circleToolButton" class="tool-button active" type="button">Point + Radius</button>
                    <button id="polygonToolButton" class="tool-button" type="button">Polygon</button>
                </div>

                <div id="circleControls" class="field-group">
                    <label class="label" for="radiusMiles">Radius in miles</label>
                    <input id="radiusMiles" name="radiusMiles" type="number" min="0.1" step="0.1" value="25">
                    <p class="helper">With Point + Radius selected, click the map to place the center point.</p>
                </div>

                <div id="polygonControls" class="field-group hidden">
                    <label class="label">Polygon Instructions</label>
                    <p class="helper">Click the map to place polygon corners. Close the shape by clicking the starting point. You can adjust the finished polygon with the map edit toolbar.</p>
                </div>
            </section>

            <section class="section">
                <h2>Filters</h2>
                <div class="field-group">
                    <label class="label" for="approvedFilter">Approval status</label>
                    <select id="approvedFilter" name="approved">
                        <option value="">Any approval status</option>
                        <option value="1">Approved only</option>
                        <option value="0">Not approved only</option>
                    </select>
                </div>

                <div class="field-group">
                    <label class="label" for="schooltypeFilter">School type</label>
                    <select id="schooltypeFilter" name="schooltype">
                        <option value="">Any school type</option>
                    </select>
                </div>

                <div class="field-group">
                    <label class="label" for="programMatch">Program type matching</label>
                    <select id="programMatch" name="program_match">
                        <option value="any">Match any checked program type</option>
                        <option value="all">Match all checked program types</option>
                    </select>
                </div>

                <div class="field-group">
                    <label class="label">Program types</label>
                    <div id="programTypeList" class="checkbox-grid">
                        <p class="helper">Loading available program fields...</p>
                    </div>
                </div>
            </section>

            <section class="section">
                <h2>Export Columns</h2>
                <div class="button-row">
                    <button id="selectAllColumnsButton" class="ghost-button" type="button">Select All</button>
                    <button id="clearColumnsButton" class="ghost-button" type="button">Clear All</button>
                </div>
                <details open>
                    <summary id="columnSummary">All columns selected</summary>
                    <div id="columnList" class="column-list">
                        <p class="helper">Loading columns...</p>
                    </div>
                </details>
                <p id="columnSelectionHint" class="column-summary">Choose which table fields should appear in the CSV.</p>
            </section>

            <section class="section">
                <h2>Selection Preview</h2>
                <div id="selectionSummary" class="selection-summary">
                    The map starts centered on the United States. No export area has been selected yet.
                </div>
                <div id="countPanel" class="count-panel">
                    Matching schools will appear here after you draw a selection.
                </div>
            </section>

            <div id="debugPanel" class="debug-panel hidden"></div>

            <div class="actions">
                <button id="refreshCountButton" class="secondary-button" type="button" disabled>Refresh Match Count</button>
                <button id="downloadButton" class="primary-button" type="button" disabled>Download CSV</button>
                <button id="clearButton" class="secondary-button" type="button">Clear Selection</button>
            </div>
        </aside>

        <section class="map-panel">
            <div id="map" aria-label="School export map"></div>
            <div id="statusBanner" class="status-banner">Click on the map to place the center of your radius selection.</div>
        </section>
    </div>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script src="https://unpkg.com/leaflet-draw@1.0.4/dist/leaflet.draw.js"></script>
    <script>
        const appDebugEnabled = <?= $debugEnabled ? 'true' : 'false' ?>;

        const map = L.map('map', {
            zoomControl: true,
            minZoom: 3
        }).setView([39.8283, -98.5795], 4);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; OpenStreetMap contributors'
        }).addTo(map);

        const selectionStyle = {
            color: '#146c78',
            weight: 2,
            fillColor: '#146c78',
            fillOpacity: 0.22
        };

        const editableLayers = new L.FeatureGroup();
        map.addLayer(editableLayers);

        const editControl = new L.Control.Draw({
            draw: false,
            edit: {
                featureGroup: editableLayers,
                edit: true,
                remove: true
            }
        });
        map.addControl(editControl);

        const state = {
            mode: 'circle',
            center: null,
            radiusMiles: 25,
            polygonPoints: [],
            circleLayer: null,
            centerMarker: null,
            polygonLayer: null,
            polygonDrawHandler: null,
            availableColumns: [],
            selectedColumns: [],
            schoolTypes: [],
            programFields: {},
            matchCount: null,
            countPending: false,
            countTimer: null,
            countRequestToken: 0
        };

        const circleToolButton = document.getElementById('circleToolButton');
        const polygonToolButton = document.getElementById('polygonToolButton');
        const circleControls = document.getElementById('circleControls');
        const polygonControls = document.getElementById('polygonControls');
        const radiusMilesInput = document.getElementById('radiusMiles');
        const approvedFilter = document.getElementById('approvedFilter');
        const schooltypeFilter = document.getElementById('schooltypeFilter');
        const programMatch = document.getElementById('programMatch');
        const programTypeList = document.getElementById('programTypeList');
        const columnList = document.getElementById('columnList');
        const columnSummary = document.getElementById('columnSummary');
        const columnSelectionHint = document.getElementById('columnSelectionHint');
        const selectAllColumnsButton = document.getElementById('selectAllColumnsButton');
        const clearColumnsButton = document.getElementById('clearColumnsButton');
        const refreshCountButton = document.getElementById('refreshCountButton');
        const downloadButton = document.getElementById('downloadButton');
        const clearButton = document.getElementById('clearButton');
        const selectionSummary = document.getElementById('selectionSummary');
        const countPanel = document.getElementById('countPanel');
        const statusBanner = document.getElementById('statusBanner');
        const debugPanel = document.getElementById('debugPanel');

        function setStatus(message) {
            statusBanner.textContent = message;
        }

        function setSummary(message) {
            selectionSummary.textContent = message;
        }

        function setCountMessage(message) {
            countPanel.textContent = message;
        }

        function setDebug(message) {
            if (!appDebugEnabled || !message) {
                debugPanel.classList.add('hidden');
                debugPanel.textContent = '';
                return;
            }

            debugPanel.classList.remove('hidden');
            debugPanel.textContent = message;
        }

        function formatColumnLabel(column) {
            const labels = {
                schoolname: 'School Name',
                contactname: 'Contact Name',
                infoemail: 'Info Email',
                headofschoolname: 'Head of School',
                address1: 'Address 1',
                address2: 'Address 2',
                city: 'City',
                stateprovince: 'State/Province',
                zippostal: 'Zip/Postal',
                phone1label: 'Phone 1 Label',
                phone1number: 'Phone 1 Number',
                phone2label: 'Phone 2 Label',
                phone2number: 'Phone 2 Number',
                phone3label: 'Phone 3 Label',
                phone3number: 'Phone 3 Number',
                foreignlang: 'Foreign Language',
                summerprogram: 'Summer Program',
                lowerel: 'Lower Elementary',
                upperel: 'Upper Elementary',
                highschool: 'High School',
                numberstudents: 'Number of Students',
                yearfounded: 'Year Founded',
                trainingcenter: 'Training Center',
                stateprovince: 'State / Province'
            };

            if (labels[column]) {
                return labels[column];
            }

            return column
                .replace(/_/g, ' ')
                .replace(/([a-z])([A-Z])/g, '$1 $2')
                .replace(/\b\w/g, function(character) {
                    return character.toUpperCase();
                });
        }

        function getSelectedProgramTypes() {
            const checked = programTypeList.querySelectorAll('input[type="checkbox"]:checked');
            const values = [];

            checked.forEach(function(input) {
                values.push(input.value);
            });

            return values;
        }

        function hasValidSelection() {
            if (state.mode === 'circle') {
                return !!state.center && state.radiusMiles > 0;
            }

            return state.polygonPoints.length >= 3;
        }

        function clearMapSelection() {
            if (state.circleLayer) {
                map.removeLayer(state.circleLayer);
                state.circleLayer = null;
            }

            if (state.centerMarker) {
                map.removeLayer(state.centerMarker);
                state.centerMarker = null;
            }

            editableLayers.clearLayers();
            state.center = null;
            state.polygonPoints = [];
            state.polygonLayer = null;
            state.matchCount = null;
            state.countPending = false;
            refreshCountButton.disabled = true;
            downloadButton.disabled = true;
            setDebug('');
        }

        function disablePolygonDrawing() {
            if (state.polygonDrawHandler) {
                state.polygonDrawHandler.disable();
            }
        }

        function startPolygonDrawing() {
            disablePolygonDrawing();

            state.polygonDrawHandler = new L.Draw.Polygon(map, {
                showArea: true,
                allowIntersection: false,
                shapeOptions: selectionStyle
            });
            state.polygonDrawHandler.enable();
            setStatus('Click to add polygon points. Click the first point again to close the shape.');
        }

        function updateColumnSelectionSummary() {
            const total = state.availableColumns.length;
            const selected = state.selectedColumns.length;

            if (!total) {
                columnSummary.textContent = 'Loading columns...';
                columnSelectionHint.textContent = 'Choose which table fields should appear in the CSV.';
                return;
            }

            if (selected === total) {
                columnSummary.textContent = 'All columns selected';
                columnSelectionHint.textContent = 'The CSV will include every column from the schools table.';
                return;
            }

            if (selected === 0) {
                columnSummary.textContent = 'No columns selected';
                columnSelectionHint.textContent = 'Select at least one column before downloading.';
                return;
            }

            columnSummary.textContent = selected + ' of ' + total + ' columns selected';
            columnSelectionHint.textContent = 'Only the checked columns will appear in the CSV.';
        }

        function renderColumnOptions() {
            columnList.innerHTML = '';

            if (!state.availableColumns.length) {
                const helper = document.createElement('p');
                helper.className = 'helper';
                helper.textContent = 'No columns were returned from the server.';
                columnList.appendChild(helper);
                updateColumnSelectionSummary();
                return;
            }

            state.availableColumns.forEach(function(column) {
                const label = document.createElement('label');
                label.className = 'checkbox-item';

                const checkbox = document.createElement('input');
                checkbox.type = 'checkbox';
                checkbox.value = column;
                checkbox.checked = state.selectedColumns.indexOf(column) !== -1;
                checkbox.addEventListener('change', function() {
                    if (checkbox.checked) {
                        if (state.selectedColumns.indexOf(column) === -1) {
                            state.selectedColumns.push(column);
                        }
                    } else {
                        state.selectedColumns = state.selectedColumns.filter(function(selectedColumn) {
                            return selectedColumn !== column;
                        });
                    }

                    updateColumnSelectionSummary();
                    updateActionState();
                });

                const text = document.createElement('span');
                text.textContent = formatColumnLabel(column) + ' (' + column + ')';

                label.appendChild(checkbox);
                label.appendChild(text);
                columnList.appendChild(label);
            });

            updateColumnSelectionSummary();
        }

        function renderProgramOptions() {
            programTypeList.innerHTML = '';

            const keys = Object.keys(state.programFields);
            if (!keys.length) {
                const helper = document.createElement('p');
                helper.className = 'helper';
                helper.textContent = 'No program type columns were detected in the table.';
                programTypeList.appendChild(helper);
                return;
            }

            keys.forEach(function(programField) {
                const label = document.createElement('label');
                label.className = 'checkbox-item';

                const checkbox = document.createElement('input');
                checkbox.type = 'checkbox';
                checkbox.value = programField;
                checkbox.addEventListener('change', function() {
                    scheduleCountRefresh();
                });

                const text = document.createElement('span');
                text.textContent = state.programFields[programField];

                label.appendChild(checkbox);
                label.appendChild(text);
                programTypeList.appendChild(label);
            });
        }

        function renderSchooltypeOptions() {
            schooltypeFilter.innerHTML = '';

            const allOption = document.createElement('option');
            allOption.value = '';
            allOption.textContent = 'Any school type';
            schooltypeFilter.appendChild(allOption);

            state.schoolTypes.forEach(function(type) {
                const option = document.createElement('option');
                option.value = type;
                option.textContent = type;
                schooltypeFilter.appendChild(option);
            });
        }

        function updateActionState() {
            const hasColumns = state.selectedColumns.length > 0;
            const hasSelection = hasValidSelection();
            refreshCountButton.disabled = !hasSelection;
            downloadButton.disabled = !hasSelection || !hasColumns;
        }

        function updateSummary() {
            if (!hasValidSelection()) {
                if (state.mode === 'circle') {
                    setSummary('Click the map to place the center point, then set a radius in miles.');
                } else {
                    setSummary('Click the map to place polygon corners. Close the polygon by clicking the starting point.');
                }

                setCountMessage('Matching schools will appear here after you draw a selection.');
                updateActionState();
                return;
            }

            if (state.mode === 'circle') {
                const centerText = state.center.lat.toFixed(5) + ', ' + state.center.lng.toFixed(5);
                setSummary('Radius selection ready. Center: ' + centerText + '. Radius: ' + state.radiusMiles.toFixed(1) + ' miles.');
            } else {
                setSummary('Polygon selection ready with ' + state.polygonPoints.length + ' points. You can export now or adjust it with the map edit toolbar.');
            }

            if (state.countPending) {
                setCountMessage('Calculating how many schools match the current selection and filters...');
            } else if (typeof state.matchCount === 'number') {
                if (state.matchCount === 1) {
                    setCountMessage('1 school currently matches your selection and filters.');
                } else {
                    setCountMessage(state.matchCount + ' schools currently match your selection and filters.');
                }
            } else {
                setCountMessage('Click Refresh Match Count or adjust the selection to calculate how many schools match.');
            }

            updateActionState();
        }

        function setMode(mode) {
            state.mode = mode;
            clearMapSelection();
            disablePolygonDrawing();

            circleToolButton.classList.toggle('active', mode === 'circle');
            polygonToolButton.classList.toggle('active', mode === 'polygon');
            circleControls.classList.toggle('hidden', mode !== 'circle');
            polygonControls.classList.toggle('hidden', mode !== 'polygon');

            if (mode === 'circle') {
                setStatus('Click on the map to place the center of your radius selection.');
            } else {
                startPolygonDrawing();
            }

            updateSummary();
        }

        function parsePolygonPoints(layer) {
            const latLngs = layer.getLatLngs();
            const ring = Array.isArray(latLngs[0]) ? latLngs[0] : latLngs;

            return ring.map(function(latLng) {
                return { lat: latLng.lat, lng: latLng.lng };
            });
        }

        function buildSelectionFormData(includeColumns) {
            const formData = new FormData();
            formData.append('mode', state.mode);

            if (state.mode === 'circle') {
                formData.append('center_lat', String(state.center.lat));
                formData.append('center_lng', String(state.center.lng));
                formData.append('radius_miles', String(state.radiusMiles));
            } else {
                formData.append('polygon', JSON.stringify(state.polygonPoints));
            }

            formData.append('approved', approvedFilter.value);
            formData.append('schooltype', schooltypeFilter.value);
            formData.append('program_match', programMatch.value);

            getSelectedProgramTypes().forEach(function(programType) {
                formData.append('program_types[]', programType);
            });

            if (includeColumns) {
                state.selectedColumns.forEach(function(column) {
                    formData.append('columns[]', column);
                });
            }

            return formData;
        }

        async function refreshCount() {
            if (!hasValidSelection()) {
                state.matchCount = null;
                state.countPending = false;
                updateSummary();
                return;
            }

            const requestToken = ++state.countRequestToken;
            state.countPending = true;
            updateSummary();
            setStatus('Calculating match count...');

            try {
                const response = await fetch('selection_api.php?action=count', {
                    method: 'POST',
                    body: buildSelectionFormData(false),
                    credentials: 'same-origin'
                });

                if (!response.ok) {
                    const message = await response.text();
                    throw new Error(message.trim() || ('Count request failed with HTTP ' + response.status + '.'));
                }

                const payload = await response.json();
                if (requestToken !== state.countRequestToken) {
                    return;
                }

                state.matchCount = typeof payload.count === 'number' ? payload.count : null;
                setStatus('Match count updated.');
                setDebug('');
            } catch (error) {
                if (requestToken !== state.countRequestToken) {
                    return;
                }

                const message = error && error.message ? error.message : 'Unable to refresh match count.';
                state.matchCount = null;
                setStatus(message);
                setDebug('Match count request failed. Detail: ' + message);
            } finally {
                if (requestToken === state.countRequestToken) {
                    state.countPending = false;
                    updateSummary();
                }
            }
        }

        function scheduleCountRefresh() {
            state.matchCount = null;

            if (state.countTimer) {
                window.clearTimeout(state.countTimer);
            }

            if (!hasValidSelection()) {
                state.countPending = false;
                updateSummary();
                return;
            }

            state.countPending = true;
            updateSummary();
            state.countTimer = window.setTimeout(function() {
                refreshCount();
            }, 250);
        }

        async function loadMetadata() {
            try {
                const response = await fetch('selection_api.php?action=metadata', {
                    credentials: 'same-origin'
                });

                if (!response.ok) {
                    const message = await response.text();
                    throw new Error(message.trim() || ('Metadata request failed with HTTP ' + response.status + '.'));
                }

                const payload = await response.json();
                state.availableColumns = Array.isArray(payload.columns) ? payload.columns : [];
                state.selectedColumns = state.availableColumns.slice();
                state.schoolTypes = Array.isArray(payload.schooltypes) ? payload.schooltypes : [];
                state.programFields = payload.program_fields && typeof payload.program_fields === 'object' ? payload.program_fields : {};

                renderSchooltypeOptions();
                renderProgramOptions();
                renderColumnOptions();
                updateSummary();
                setStatus('Map ready. Draw a selection to preview matching schools.');
            } catch (error) {
                const message = error && error.message ? error.message : 'Unable to load filter metadata.';
                setStatus(message);
                setDebug('Metadata request failed. Detail: ' + message);
                updateSummary();
            }
        }

        map.on('click', function(event) {
            if (state.mode !== 'circle') {
                return;
            }

            state.center = {
                lat: event.latlng.lat,
                lng: event.latlng.lng
            };

            if (state.circleLayer) {
                map.removeLayer(state.circleLayer);
            }

            if (state.centerMarker) {
                map.removeLayer(state.centerMarker);
            }

            state.centerMarker = L.marker([state.center.lat, state.center.lng]).addTo(map);
            state.circleLayer = L.circle([state.center.lat, state.center.lng], {
                color: selectionStyle.color,
                weight: selectionStyle.weight,
                fillColor: selectionStyle.fillColor,
                fillOpacity: selectionStyle.fillOpacity,
                radius: state.radiusMiles * 1609.344
            }).addTo(map);

            map.fitBounds(state.circleLayer.getBounds(), { padding: [20, 20] });
            setStatus('Radius selection created. You can click a new center point or change the radius.');
            scheduleCountRefresh();
        });

        radiusMilesInput.addEventListener('input', function() {
            const nextRadius = parseFloat(radiusMilesInput.value);
            state.radiusMiles = Number.isFinite(nextRadius) ? nextRadius : 0;

            if (state.mode === 'circle' && state.center) {
                if (state.circleLayer) {
                    state.circleLayer.setRadius(state.radiusMiles * 1609.344);
                    map.fitBounds(state.circleLayer.getBounds(), { padding: [20, 20] });
                }
                scheduleCountRefresh();
                return;
            }

            updateSummary();
        });

        map.on(L.Draw.Event.CREATED, function(event) {
            if (state.mode !== 'polygon') {
                return;
            }

            editableLayers.clearLayers();
            state.polygonLayer = event.layer;
            editableLayers.addLayer(state.polygonLayer);
            state.polygonPoints = parsePolygonPoints(state.polygonLayer);

            map.fitBounds(state.polygonLayer.getBounds(), { padding: [20, 20] });
            setStatus('Polygon selection created. Use the edit toolbar on the map if you want to adjust it.');
            scheduleCountRefresh();
        });

        map.on(L.Draw.Event.EDITED, function() {
            if (!state.polygonLayer) {
                return;
            }

            state.polygonPoints = parsePolygonPoints(state.polygonLayer);
            setStatus('Polygon updated.');
            scheduleCountRefresh();
        });

        map.on(L.Draw.Event.DELETED, function() {
            state.polygonLayer = null;
            state.polygonPoints = [];
            state.matchCount = null;
            state.countPending = false;
            setStatus('Polygon removed. Start a new polygon to continue.');
            if (state.mode === 'polygon') {
                startPolygonDrawing();
            }
            updateSummary();
        });

        circleToolButton.addEventListener('click', function() {
            setMode('circle');
        });

        polygonToolButton.addEventListener('click', function() {
            setMode('polygon');
        });

        approvedFilter.addEventListener('change', scheduleCountRefresh);
        schooltypeFilter.addEventListener('change', scheduleCountRefresh);
        programMatch.addEventListener('change', scheduleCountRefresh);

        selectAllColumnsButton.addEventListener('click', function() {
            state.selectedColumns = state.availableColumns.slice();
            renderColumnOptions();
            updateActionState();
        });

        clearColumnsButton.addEventListener('click', function() {
            state.selectedColumns = [];
            renderColumnOptions();
            updateActionState();
        });

        refreshCountButton.addEventListener('click', function() {
            refreshCount();
        });

        clearButton.addEventListener('click', function() {
            clearMapSelection();

            if (state.mode === 'polygon') {
                startPolygonDrawing();
                setStatus('Selection cleared. Draw a new polygon to continue.');
            } else {
                setStatus('Selection cleared. Click the map to place a new center point.');
            }

            updateSummary();
        });

        downloadButton.addEventListener('click', async function() {
            if (!hasValidSelection()) {
                setStatus('Create a valid selection before downloading.');
                return;
            }

            if (!state.selectedColumns.length) {
                setStatus('Select at least one export column before downloading.');
                return;
            }

            downloadButton.disabled = true;
            downloadButton.textContent = 'Preparing CSV...';
            setStatus('Generating CSV export...');

            try {
                const response = await fetch('export.php', {
                    method: 'POST',
                    body: buildSelectionFormData(true),
                    credentials: 'same-origin'
                });

                if (!response.ok) {
                    const message = await response.text();
                    throw new Error(message.trim() || ('Export failed with HTTP ' + response.status + '.'));
                }

                const blob = await response.blob();
                const header = response.headers.get('Content-Disposition') || '';
                const fileMatch = header.match(/filename="([^"]+)"/i);
                const filename = fileMatch ? fileMatch[1] : 'schools_export.csv';
                const url = window.URL.createObjectURL(blob);
                const link = document.createElement('a');

                link.href = url;
                link.download = filename;
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
                window.URL.revokeObjectURL(url);
                setStatus('CSV download started.');
                setDebug('');
            } catch (error) {
                const message = error && error.message ? error.message : 'Export failed.';
                setStatus(message);
                setDebug('CSV export failed. Detail: ' + message);
            } finally {
                downloadButton.textContent = 'Download CSV';
                updateActionState();
            }
        });

        updateSummary();
        setDebug('');
        loadMetadata();
    </script>
</body>
</html>
