<?php 
$mapJS=1;
$centerLatitude = 40.8157; //ronkonkoma
$centerLongitude = -73.1187; //ronkonkoma
$startZoom = 9;
$mapScript = '<script src="js2/Clusterer2.js" type="text/javascript"></script><script src="js2/map_deals.js" type="text/javascript"></script>
';
#<script src="js2/data_deals.php" type="text/javascript"></script>


include('begin.php'); ?>


 <!-- END subheader -->
<div id="front-container" class="clearfix" style="background-color: #fff;">
<div id="left">
</div>
<div id="center">
<div align="left">
      <p><span class="style2">Dining Deals <strong>|</strong></span> <span class="style6 style2"> <span class="style3"><span class="style9">Restaurant Specials</span></span></span><br></p>
</div>
Count: <div id="curcount"></div>
<p>Select map icons for restaurant name and a link to buy a discount coupon.</p><br /><br />
<div id="map" style="width: 750px; height: 400px; border: 4px solid #ccc; background-color: #eee;"><p style="padding: 50px;">Please wait ... Loading list of specials ...</p></div>
  
</div>


