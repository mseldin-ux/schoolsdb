<?php
set_time_limit(120);

require('functions.php');
$debug=true;
function getDeals() {
	$swlat=$_REQUEST['swlat']+90;
	$swlng=$_REQUEST['swlng']+180;
	$nelat=$_REQUEST['nelat']+90;
	$nelng=$_REQUEST['nelng']+180;
	$sql="SELECT * FROM schools where (lat+90)>=".$swlat." and (lat+90)<=".$nelat." and (lng+180)>=".$swlng." and (lng+180)<=".$nelng;
//	if ($_REQUEST['trans']==1) {
//		$sql="SELECT * FROM diningdeals where latitude>=".$swlat." and latitude<=".$nelat." and ";
//		$sql.="( longitude<=".$swlng." or longitude>=".$nelng.")";
//	}
	#echo $sql."\n<br>";
	$sql.=" order by schoolname";
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
	#echo "\n<br>";
	extract($value);
	$schoolname=str_replace('"','',$schoolname);
	$address1=str_replace('"','',$address1);
	$city=str_replace('"','',$city);
	$stateprovince=str_replace('"','',$stateprovince);
?>
	<?= $joiner ?>
   {
      'latitude': <?= $lat ?>,
      'longitude': <?= $lng ?>,
      'id': <?= $id ?>,
      'name': '<?= addslashes($schoolname) ?>',
      'address': '<?= addslashes($address1) ?>',
      'city': '<?= addslashes($city) ?>',
      'stateprovince': '<?= addslashes($stateprovince) ?>',
      'web': '<?= addslashes($web) ?>'
   }
	<?php 
		$joiner = ',';
		$count++;
	?>
<?php } ?>
]
}
<?php } ?>