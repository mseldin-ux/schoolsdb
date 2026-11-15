<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAUTo80Pfn-BB5jib3iN1S3xS3E5754d2tO0aMLZ6NsdY3rSqqFRScnTPfV8LfkVMjbBfivFXDq4HJSA"
      type="text/javascript"></script>
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