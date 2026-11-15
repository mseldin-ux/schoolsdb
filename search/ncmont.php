<?php
$clat=40.8157;
$clong=-73.1187 ;
$requestedLatitude = $_REQUEST['centerlat'] ?? null;
$requestedLongitude = $_REQUEST['centerlong'] ?? null;
if (is_scalar($requestedLatitude) && is_scalar($requestedLongitude)) {
	$requestedLatitude = filter_var($requestedLatitude, FILTER_VALIDATE_FLOAT);
	$requestedLongitude = filter_var($requestedLongitude, FILTER_VALIDATE_FLOAT);
	if ($requestedLatitude !== false && $requestedLongitude !== false && $requestedLatitude >= -90 && $requestedLatitude <= 90 && $requestedLongitude >= -180 && $requestedLongitude <= 180) {
		$clat = $requestedLatitude;
		$clong = $requestedLongitude;
	}
}
#echo "RES is ".$res;
#exit;
//include('begin.php'); ?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd"><head>
<?php require_once dirname(__DIR__) . '/includes/google-maps-loader.php'; ?><title>Montessori Schools Map</title>



<script type="text/javascript" src="js2/switchcontent2.js" ></script>
<script type="text/javascript"> 
	var centerLatitude = <?=$clat ?>;
	var centerLongitude = <?=$clong ?> ;
	var iev=1000;
	var map;
</script>

<script type="text/javascript">
      document.write('<script type="text/javascript" src="js2/markerclusterer.js"><' + '/script>');
</script>
<?php
$requestedZoom = $_REQUEST['startzoom'] ?? '9';
$requestedZoom = is_scalar($requestedZoom) ? filter_var($requestedZoom, FILTER_VALIDATE_INT) : false;
$mapParameters = ['startzoom' => $requestedZoom !== false && ($requestedZoom === -1 || ($requestedZoom >= 1 && $requestedZoom <= 20)) ? $requestedZoom : 9];
$searchterms=array();
	$searchValues = array_fill_keys(['keywords', 'city', 'country', 'zip'], '');
foreach (['keywords', 'city', 'country', 'zip'] as $parameter) {
	$value = $_REQUEST[$parameter] ?? '';
	if (is_scalar($value) && trim((string) $value) !== '') {
		$value = trim((string) $value);
		$searchValues[$parameter] = $value;
		$mapParameters[$parameter] = $value;
		if ($parameter === 'keywords') {
			$searchterms = array_merge($searchterms, explode(' ', $value));
		} else {
			$searchterms[] = $value;
		}
	}
}
$mappingurl = 'js2/cgms_mapping_lib3-nc.php?' . http_build_query($mapParameters);
$searchtermtext = implode(' ', $searchterms);
$deletedFilter = $_REQUEST['deleted'] ?? '';
$showDeletedFilter = is_scalar($deletedFilter) && (string) $deletedFilter !== '';
$res = '';
?>
<script type="text/javascript">
var searchtermtext=<?= json_encode($searchtermtext, JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT) ?>;

</script>
<script id="mapscript" src="<?=$mappingurl ?>" type="text/javascript"></script>

<style type="text/css" media="all">
@import "styles-nc.css";
</style>


</head>
<body>
 <!-- END subheader -->
<div id="front-container" class="clearfix">

<div id="center">

<div id="searchform">
<h2>Explore using the map, or you may search by keyword:</h2>
<form action="" method="post">
	<input type="hidden" name="action" value="search" />
	<input type="hidden" name="startzoom" value="-1" />

	<input type="hidden" name="zip" value="<?= htmlspecialchars($searchValues['zip'], ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8') ?>" size="6"/> &nbsp;&nbsp; 
	<input type="hidden" name="city" value="<?= htmlspecialchars($searchValues['city'], ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8') ?>" size="14"/> &nbsp;&nbsp; 
	Keywords <input type="text" name="keywords" value="<?= htmlspecialchars($searchValues['keywords'], ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8') ?>" size="20" /> &nbsp;&nbsp; 
	<input type="hidden" name="country" />
<?php
	if ($showDeletedFilter) {
		echo "deleted: <input id='deletedbox' name='deleted' type='checkbox' ";
		if ($deletedFilter === "on") {echo "checked";}
		echo "/>\r\n";
	}
?>
	<input type="submit" name="sub" value="search" />
</form>
</div>




<div id="schoollistcontainer">
<?php
if (count($searchterms)>0) {
	?>
	<input type="button" value="&nbsp; Reset search (show all schools) &nbsp;" onClick='resetMap();' /><br/>
	<?php
}
?>
<table width="385"><tr><td align="left" width="285"><span id="curcount"></span></td><td align="right" width="100"><span id="islooking"></span></td></tr></table>
<h4><?=$res ?></h4>
<iframe id="schoollist" src="pleasewait.html" style="overflow-x: hidden; width: 300px; height: 480px;" scrolling="auto" frameborder="0">
</iframe>
</div>

<!--

<iframe id="detailframe"  src="blank.html" style="overflow-x: hidden; width: 225px; height: 500px; float: left;" scrolling="auto" frameborder="0"></iframe>
-->


<span id="nomap"></span>
<div id="map" style="width: 500px; height: 500px; border: 2px solid #ccc; background-color: #eee; float: left;">If you are seeing this message then we are afraid that your web browser is not compatible with this site. We recommend you upgrade to <a href="http://www.mozilla.com/en-US/firefox/ie.html">one</a> of the <a href="http://www.microsoft.com/windows/internet-explorer/default.aspx">modern</a> <a href="http://www.google.com/chrome">browers</a>.</div> 

</div>
<script>
	function changeMapSize() {
		var mapel=document.getElementById('map');
		var shrinker=document.getElementById('shrinkmapid');
		var expander=document.getElementById('expandmapid');
		//alert(map.style.width);
		if (mapel.style.width == '700px') {
			mapel.style.width='400px';
			shrinker.style.visibility='hidden';
			expander.style.visibility='visible';
		}
		else {
			mapel.style.width='700px';
			shrinker.style.visibility='visible';
			expander.style.visibility='hidden';
		}
	}
</script>
<!--

<span id='expandmapid'>
<a href="javascript:void(0);" onclick="changeMapSize(); return true;">Expand Map</a>
</span>
<span id='shrinkmapid' style='visibility: hidden;'>
<a href="javascript:void(0);" onclick="changeMapSize(); return true;">Shrink Map</a>
</span>
-->





<div id="extradiv"></div>
</body>
<script>

window.onload = init;



</script>
</html>
