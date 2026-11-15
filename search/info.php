	<?php
#echo "RES is ".$res;
#exit;
//include('begin.php'); ?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd"><head><title>CGMS Montessori School Search</title>

<style type="text/css" media="all">
@import "styles2.css";
</style>


</head>
<body>
 <!-- END subheader -->
<div id="front-container" class="clearfix">

<div id="center">
<table><tr><td width="600">
<h1>CGMS Montessori School Search</h1>
This database is provided as a service to the global Montessori community by <a href="http://www.montessori.org">The Montessori Foundation</a> and <a href="http://www.guidedstudies.com">The Center for Guided Montessori Studies</a> (CGMS). 

</td>
<td>
<a href="http://www.guidedstudies.com"><img src="../images/cgms_logo.jpg" width="268" height="97" alt="CGMS Logo"/></a>
<a href="http://www.montessori.org"><img src="../images/foundation_logo.jpg" width="87" height="97" alt="Montessori Foundation Logo"/></a>
		
</td>
</tr></table>
<div id="searchform">
<a href="./" class="small_link">Go back to map view</a><br/>
<h2>Search by zip, city, keyword or country:</h2>
<form action="index.php" method="post">
	<input type="hidden" name="action" value="search" />
	<input type="hidden" name="startzoom" value="-1" />

	Postal Code/Zip <input type="text" name="zip" value="<?=$_REQUEST['zip'] ?>" size="6"/> &nbsp;&nbsp; 
	City <input type="text" name="city" value="<?=$_REQUEST['city'] ?>" size="14"/> &nbsp;&nbsp; 
	Keywords/State <input type="text" name="keywords" value="<?=$_REQUEST['keywords'] ?>" size="20" /> &nbsp;&nbsp; 
	Country <select name="country" style="width: 180px;">
<?=file_get_contents('countrieslist.txt'); ?>
</select>		
	<input type="submit" name="sub" value="search" />
</form>
</div>
<p class="infotext">
No one owns the term Montessori, which means that anyone can call themselves a Montessori school. For this database we are taking schools at their word; if they call themselves a Montessori school, we are including them. Please understand that schools vary in terms of their authenticity and commitment to Montessori principles. 
</p>
<p>
For the same reason, it is not possible for any database of this sort to be complete. The Center for Guided Montessori Studies employs many people to try and maintain this database, but our methods of finding them are not too dissimilar to yours. Except where we already know a school to exist ourselves, we rely on web searches and existing lists to both discover a school and to verify it exists. If a school does not have a website, then we may choose to include it in our list, or not, at our discretion, with the warning that the listing is unverified. Our database is certain to include schools that no longer exist, to miss schools that do exist and to also include some listings that are not <a href="http://issuu.com/timseldin/docs/finding_the_right_school">authentic Montessori schools</a>.
</p>
<p>
	If you are interested in finding out more about this project, or in volunteering to help increase the accuracy of the listings, please <a href="http://www.guidedstudies.com/cgms/about/contact.shtml">contact CGMS</a>.
<p>
<p>
If you are with a legitimate montessori organization, we may at our discretion choose to share our current list with your group for the purposes of extending the reach of authentic Montessori. If so, we will require you to be compliant with the <a href="http://www.ftc.gov/bcp/edu/pubs/business/ecommerce/bus61.shtm">CAN-SPAM Act</a>, regardless of whether you are a U.S. organization or not.
</p>
<br/>
<p><h1>Resources</h1>
	The Montessori Foundation has created many resources which may be useful to parents who are looking at Montessori schools.
	<ul>
	<li><a href="http://issuu.com/timseldin/docs/montessori_101">Montessori 101</a>
		<br/>What is Montessori? Why is it the most popular alternative method of education in the world today?</li>
	<li><a href="http://issuu.com/timseldin/docs/finding_the_right_school">Finding the Right School For Your Child</a><br/>Tips on picking the school which will suit your child best, including the key elements to look for in a good Montessori classroom.</li>
	<li><a href="http://issuu.com/timseldin/docs/3mont_historical_perspective">Dr. Maria Montessori</a><br/>Understand the life, significance and scientic theories of the founder of our favorite teaching method.</li>
	<li><a href="http://www.youtube.com/watch?v=Obo95qqoj1U&feature=channel">Montessori: Planting the Seeds of Learning</a><br/>A 12 minute introduction to Montessori education from the Montessori Foundation. The video was prepared by Artrix Video in Sarasota, Florida. Copyright is held by the Montessori Foundation. The video is available on DVD from the Montessori Foundation's publication center: www.montessori-foundation-books.org</li>
	<li><a href="http://www.youtube.com/watch?v=hW7JgQHHVJc&feature=channel">What children really get out of a Montessori education</a><br/>Tens of thousands of Montessori schools around the world are celebrating this vibrant educational reform movement's first 100 years. This is a recording of a talk given by Montessori Foundation President, Tim Seldin, to Montessori educators on the outcomes of a Montessori education that we typically see in children by age twelve.</li>
	<li><a href="http://www.youtube.com/watch?v=gcOk-MvVn_o&feature=channel">Joyful Schools - Montessori for the Elementary Years</a><br/>This is a video from the Montessori Foundation. It is used in hundreds of Montessori schools to introduce parents of children who have spent two or three years in the early childhood program to the elementary level of Montessori education. It offers a brief overview of what makes elementary Montessori different and special. The video is available on DVD through the Montessori Foundation book service: www.montessori-foundation-books.org</li>
	
</ul>




<div id="extradiv"></div>
</body>

</html>