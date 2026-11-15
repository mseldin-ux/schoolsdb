<?php 

//include('begin.php'); ?>
<html><head>
<?php require_once dirname(__DIR__) . '/includes/google-maps-loader.php'; ?><title>Montessori Schools Map</title>




<script type="text/javascript"> 
	var centerLatitude = 40.8157;
	var centerLongitude = -73.1187 ;
	var startZoom = 9;
</script>
<script>
var timeoutvar;
var moveinterval=300;
var timer_running;
function moveUp()
{
	var listobj=document.getElementById('schoollist');
	var top=parseInt(listobj.style.top.replace("px",""));
	var lastobj=document.getElementById('lastitemspan');
	var bottom=lastobj.offsetTop;
	
	var upamt=-200;
	if (bottom+top < 200) {return;}
	if (bottom+top < 300) {
		upamt=-(bottom+top)+100;
	}
  
  new Effect.Move('schoollist', { x: 0, y: upamt, transition: Effect.Transitions.linear });
	
	var extraobj=document.getElementById('extradiv');
	extraobj.innerHTML="TOP:"+top+" move: "+upamt;
	extraobj.innerHTML+=", BOTTOM: "+bottom+", bot+top:"+(bottom+top);
	//for (var st in listobj.style) {
	//	if (listobj.style[st]) {
	//		extraobj.innerHTML+=st+" = "+listobj.style[st]+"\n<br>";
	//	}
	//}
	if (timer_running) {timeoutvar=setTimeout("moveUp()",moveinterval);}
}
 
function stopMovement() {
	timer_running=false;
	clearTimeout(timeoutvar);
}

function moveDown()
{
	var listobj=document.getElementById('schoollist');
	var top=parseInt(listobj.style.top.replace("px",""));
	var lastobj=document.getElementById('lastitemspan');
	var bottom=lastobj.offsetTop;
	if (top>-200) {return;}
	var downamt=200;
	if (top>-300) {downamt+=(300+top);}
	
  new Effect.Move('schoollist', { x: 0, y: +200, transition: Effect.Transitions.linear });
	var extraobj=document.getElementById('extradiv');
	var extraobj=document.getElementById('extradiv');
	extraobj.innerHTML="TOP:"+top+" move: "+downamt;
	extraobj.innerHTML+=", BOTTOM: "+bottom+", bot+top:"+(bottom+top);
	if (timer_running) {timeoutvar=setTimeout("moveDown()",moveinterval);}
}


</script>


<script src="/search/js2/markerclusterer.js" defer></script>
<script src="/assets/school-map.js" data-endpoint="/mappingnew/js2/data_deals.php" defer></script>
<script src="/scriptaculous-js-1.8.3/lib/prototype.js" type="text/javascript"></script>
<script src="/scriptaculous-js-1.8.3/src/scriptaculous.js" type="text/javascript"></script>
<script src="/scriptaculous-js-1.8.3/src/slider.js" type="text/javascript"></script>

</head>
<body>
 <!-- END subheader -->
<div id="front-container" class="clearfix" style="background-color: #fff;">
<div id="left">
</div>
<div id="center">
<h1>Montessori Schools Map View</h1>

Count: <div id="curcount"></div>
<p>Select map icons for restaurant name and a link to buy a discount coupon.</p><br /><br />

<style type="text/css">
#schoollistcontainer
{
	margin: auto;
  width: 360px;
  border: 1px #000 solid;
  overflow: hidden;
}	
</style>
<table><tr><td align="center">
<div id="topcontrols">
	<a style="border: none;" href="javascript:void(0);" onMouseup="stopMovement();" onmousedown="timer_running=true;moveDown(); return true;" border="0"><img style="border: none;" src="/images/up.png"></a>
</div>
<div id="schoollistcontainer"  style="width: 250px; height: 250px;" align="left">
<div id="schoollist"  style="width: 250px; height: 10000px;">
	Please wait for the system to load.<br>
</div>
</div>
 <div id="bottomcontrols">
      <a style="border: none;" href="javascript:void(0);" onMouseup="stopMovement();" onmousedown="timer_running=true;moveUp(); return true;" border="0"><img style="border: none;" src="/images/down.png"></a>
 </div>
</td>
<style type="text/css" >
		
		#trackdiv {
			background: url(/images/scrollbg.png); width: 30px; height: 300px; position: relative;
		}

		#sliderdiv {
			cursor: move; width:10px; height:15px; position: relative; left: 2 ; z-index: 1;
		}
</style>

<td width="30" align="center"><div id="trackdiv">
<!--

<img src="/images/scrollbg.png" height="300" width="34">


-->
<div id="sliderdiv"><img src="/images/handle.png"></span><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></span></td>
<script>
	var schoolsslider = new Control.Slider($('sliderdiv'), $('trackdiv'), {
  axis:'vertical',
	range: $R(0, 300),
	maximum: 300,
	mininum: 0
});

</script>
<td>
<div id="map" style="width: 400px; height: 400px; border: 4px solid #ccc; background-color: #eee;"><p style="padding: 50px;">Please wait ... Loading list of specials ...</p></div> 

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
<span id='expandmapid'>
<a href="javascript:void(0);" onclick="changeMapSize(); return true;">Expand Map</a>
</span>
<span id='shrinkmapid' style='visibility: hidden;'>
<a href="javascript:void(0);" onclick="changeMapSize(); return true;">Shrink Map</a>
</span>
</td></tr>
</table>
<div id="extradiv"></div>
</body>

</html>