<html><head></head><body>
	
	
<style type="text/css">
span.schoolname
{
	font:bold 18px arial,sans-serif;
}
span.address
{
	font:16px arial,sans-serif;
}	
</style>
	
	<?php
set_time_limit(120);

require('functions.php');
$debug=true;

$sql="SELECT * FROM schools where id=".($_REQUEST['id']+0);
$rows=getRows($sql);

foreach($rows as $value) {
	#echo "\n<br>";
	extract($value);
	$schoolname=str_replace('"','',$schoolname);
	$address1=str_replace('"','',$address1);
	$city=str_replace('"','',$city);
	$web=str_replace('http://','',$web);
	$stateprovince=str_replace('"','',$stateprovince);
	$addstr="";
	if ($address1) {$addstr.=$address1."\n<br/>";}
	if ($address2) {$addstr.=$address1."\n<br/>";}
	if ($city) {$addstr.=$city;}
	if ($stateprovince) {$addstr.=", ".$stateprovince;}
	if ($zippostal) {$addstr.=" ".$zippostal;}
	$addstr.="\n<br>";
	
	if ($country) {$addstr.=$country."\n<br/>";}
	
?>
      <span class="schoolname"><?= stripslashes($schoolname) ?><br/>(id <?= $id ?>)
</span><br/>
      <span class="address"><?= addslashes($addstr) ?></span><br/>
      <?php 
      
      if ($contactname) { ?>
			
      	<span class="contact">For more information, contact <?=$contactname ?> </span><br/>
			<?php 
			}
      
      if ($infoemail) { ?>
			
      	<span class="infoemail"><a href="mailto:<?=$infoemail ?>"><?=$infoemail ?></a></span><br/>
			<?php 
			}
      for ($phonei=1;$phonei<4;++$phonei) {
      	if ($value['phone'.$phonei.'label']) {
      		$value['phone'.$phonei.'label']=str_replace(":","",$value['phone'.$phonei.'label']);
      		echo $value['phone'.$phonei.'label'].": ".$value['phone'.$phonei.'number']."<br/>\n";
      	}
      }
      if ($headofschoolname) { ?>
			
      	<span class="contact">Head of school: <?=$headofschoolname ?></span><br/>
			<?php 
			}
      
      if ($web) { ?>
			
      	<span class="web"><a href="http://<?=$web?>"><?=$web ?></a></span><br/>
			<?php 
			}
	$ages=array();
	$ages['infants']="Infants (less than 18 months)";
	$ages['toddlers']="Toddlers (18 months to 2.5 years)";
	$ages['primary']="Primary (3-6 years, sometimes called 'Casa')";
	$ages['lowerel']="Lower Elementary (6 to 9 years)";
	$ages['upperel']="Upper Elementary (9 to 12 years)";
	$ages['middle']="Middle School";
	$ages['highschool']="Highschool";
	
	$specials=array();		
	$specials['bilingual']="Bilingual immersion program";
	$specials['horse']="Horseback riding Lessons";
	$specials['swimming']="Swimming program";
	$specials['summerprogram']="Summer program";
	$specials['foreignlang']="One or more foreign languages offered";
	$specials['art']="Art program";
	$specials['dance']="Dance program";
	$specials['drama']="Drama program";
	$specials['library']="Library";
	$specials['lunch']="Lunch provided";
	$specials['music']="Music program";
	$specials['montallday']="Montessori all day program";
	$specials['transportation']="Transportation to and from school available";
	$specials['outdoored']="Outdoor education";
	$specialsfound=false;
	foreach ($specials as $k => $v) {
		if ($value[$k]) {
			if (! $specialsfound) {
				$specialsfound=true;
				echo "<br/><span class=\"specials\">Specials<br/>\n";
			}
			echo $v."\n<br>";
		}
	}
	if ($numberofstudents>0) {
		echo "<span>Number of students: ".$numberofstudents."</span><br/>\n";
	}
	if ($yearfounded>0) {
		echo "<span>School founded: ".$yearfounded."</span><br/>\n";
	}
	if ($affiliations) {
		echo "<span>School affiliations: ".$affiliations."</span><br/>\n";
	}
	if ($accreditations>0) {
		echo "<span>School accreditations: ".$accreditations."</span><br/>\n";
	}
	$agesfound=false;
	foreach ($ages as $k => $v) {
		if ($value[$k]) {
			if (! $agesfound) {
				$agesfound=true;
				echo "<span>Ages served<br/>\n";
			}
			if ($value[$k] >1) {$v.= ": ".$value[$k]." students";}
			echo $v."\n<br>";
		}
	}
     ?>
   
<?php 
} 
?>
</body></html>