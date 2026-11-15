<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<?php require_once dirname(__DIR__) . '/includes/google-maps-loader.php'; ?>
<title>Newsday.com Dining Deals</title>
<meta name="Description" content="">
<meta name="Keywords" content="">
<link rel="stylesheet" href="http://www.newsday.com/common/stylesheets/global.css" type="text/css">
<link rel="stylesheet" href="http://www.newsday.com/stylesheets/layout.css" type="text/css">

 <!-- NOTE: The following stylesheet targets all IE browsers. -->
 <!--[if IE]><link rel="stylesheet" type="text/css" href="http://www.newsday.com/common/stylesheets/ie.css"><![endif]-->
 <!-- NOTE: The following stylesheet targets IE6 and earlier versions. -->
 <!--[if lte IE 6]><link rel="stylesheet" type="text/css" href="http://www.newsday.com/common/stylesheets/ie-lte6.css"><![endif]-->
 <!-- NOTE: The following stylesheet targets IE browsers earlier than version 6. -->
 <!--[if lt IE 6]><link rel="stylesheet" type="text/css" href="http://www.newsday.com/common/stylesheets/ie-lt6.css"><![endif]-->
<?php
if($mapJS) {
?>

<script type="text/javascript"> 
	var centerLatitude = <?=$centerLatitude?> 
	var centerLongitude = <?=$centerLongitude?> 
	var startZoom = <?=$startZoom?> 
</script>
<?php
}
if ($mapScript) { echo $mapScript."\n"; }
?>
</head>
<body>