<?php

require('functions.php');
$debug=true;
function getDeals() {
	$swlat=$_REQUEST['swlat']+90;
	$swlng=$_REQUEST['swlng']+180;
	$nelat=$_REQUEST['nelat']+90;
	$nelng=$_REQUEST['nelng']+180;
	$sql="SELECT * FROM diningdeals where (latitude+90)>=".$swlat." and (latitude+90)<=".$nelat." and (longitude+180)>=".$swlng." and (longitude+180)<=".$nelng;
//	if ($_REQUEST['trans']==1) {
//		$sql="SELECT * FROM diningdeals where latitude>=".$swlat." and latitude<=".$nelat." and ";
//		$sql.="( longitude<=".$swlng." or longitude>=".$nelng.")";
//	}
	#echo $sql."\n<br>";
	$rows=getRows($sql);
	return $rows;
}


//retrieve the variables from the GET vars
$data=getDeals();
#echo "found ".count($data)." rows ";
if($data) {
	$joiner = '';
	$count = 0;
?>
{"datarray":
	[
<?php foreach($data as $value) {
	extract($value);
?>
	<?= $joiner ?>
   {
      'latitude': <?= $latitude ?>,
      'longitude': <?= $longitude ?>,
      'id': <?= $id ?>,
      'name': '<?= addslashes($name) ?>',
      'address': '<?= addslashes($address) ?>',
      'city': '<?= addslashes($city) ?>'
   }
	<?php 
		$joiner = ',';
		$count++;
	?>
<?php } ?>
]
}
<?php } ?>