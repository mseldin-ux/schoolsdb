<?php
$clat=40.8157;
$clong=-73.1187 ;
if (isset($_REQUEST['centerlat'], $_REQUEST['centerlong'])) {
	if (is_scalar($_REQUEST['centerlat']) && is_scalar($_REQUEST['centerlong'])) {
		$requestedLatitude = filter_var($_REQUEST['centerlat'], FILTER_VALIDATE_FLOAT);
		$requestedLongitude = filter_var($_REQUEST['centerlong'], FILTER_VALIDATE_FLOAT);
		if (
			$requestedLatitude !== false && $requestedLongitude !== false
			&& $requestedLatitude >= -90 && $requestedLatitude <= 90
			&& $requestedLongitude >= -180 && $requestedLongitude <= 180
		) {
			$clat=$requestedLatitude;
			$clong=$requestedLongitude;
		}
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
</script>

<script type="text/javascript">
      document.write('<script type="text/javascript" src="js2/markerclusterer.js"><' + '/script>');
</script>
<?php
$requestedZoom = $_REQUEST['startzoom'] ?? '9';
$requestedZoom = is_scalar($requestedZoom) ? filter_var($requestedZoom, FILTER_VALIDATE_INT) : false;
$mapParameters = ['startzoom' => (string) ($requestedZoom !== false && ($requestedZoom === -1 || ($requestedZoom >= 1 && $requestedZoom <= 20)) ? $requestedZoom : 9)];
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
$mappingurl = 'js2/cgms_mapping_lib3.php?' . http_build_query($mapParameters);
$searchtermtext = implode(' ', $searchterms);
$res = '';
?>
<script type="text/javascript">
var searchtermtext=<?= json_encode($searchtermtext, JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT) ?>;

</script>
<script id="mapscript" src="<?=$mappingurl ?>" type="text/javascript"></script>
<script>window.addEventListener('load', init);</script>

<style type="text/css" media="all">
@import "styles.css";
</style>


</head>
<body>
 <!-- END subheader -->
<div id="front-container" class="clearfix">

<div id="center">
<table><tr><td width="600">
<h1>Montessori Schools Map View</h1>
This database is provided as a service to the global Montessori community by <a href="http://www.montessori.org">The Mountessori Foundation</a> and <a href="http://www.guidedstudies.com">The Center for Guided Montessori Studies</a>. 

	If you are interested in finding out more about this project, or in volunteering to help increase the accuracy of the listings, please contact us.
<dl><dd>
<font size="2">
	 <a href="info.html">More information</a> about this project.
</font>
</dd></dl>
</td>
<td>
	<img src="../images/cgms_logo.jpg" width="268" height="97" alt="CGMS Logo"/>
	<img src="../images/foundation_logo.jpg" width="87" height="97" alt="Montessori Foundation Logo"/>
		
</td>
</tr></table>
<div id="searchform">
<h2>Explore using the map, or you may search by zip, city, keyword or country:</h2>
<form action="" method="post">
	<input type="hidden" name="action" value="search" />
	<input type="hidden" name="startzoom" value="-1" />

	Postal Code/Zip <input type="text" name="zip" value="<?= htmlspecialchars($searchValues['zip'], ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8') ?>" size="6"/> &nbsp;&nbsp; 
	City <input type="text" name="city" value="<?= htmlspecialchars($searchValues['city'], ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8') ?>" size="14"/> &nbsp;&nbsp; 
	Keywords/State <input type="text" name="keywords" value="<?= htmlspecialchars($searchValues['keywords'], ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8') ?>" size="20" /> &nbsp;&nbsp; 
	Country <select name="country" style="width: 180px;">
<?=file_get_contents('countrieslist.txt'); ?>
</select>		
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
<span id="curcount"></span> <span id="islooking"></span>
<h4><?=$res ?></h4>
<iframe id="schoollist" src="pleasewait.html" style="overflow-x: hidden; width: 385px; height: 480px;" scrolling="auto" frameborder="0">
</iframe>
</div>

<!--

<iframe id="detailframe"  src="blank.html" style="overflow-x: hidden; width: 225px; height: 500px; float: left;" scrolling="auto" frameborder="0"></iframe>
-->


<div id="map" style="width: 550px; height: 500px; border: 2px solid #ccc; background-color: #eee; float: right;"><p style="padding: 50px;">Please wait ... Loading list of specials ...</p></div> 

</div>
<script>
	function changeMapSize() {
		var map=document.getElementById('map');
		var shrinker=document.getElementById('shrinkmapid');
		var expander=document.getElementById('expandmapid');
		var map=document.getElementById('map');
		//alert(map.style.width);
		if (map.style.width == '700px') {
			map.style.width='400px';
			shrinker.style.visibility='hidden';
			expander.style.visibility='visible';
		}
		else {
			map.style.width='700px';
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

</html>