<?php
set_time_limit(120);

require('functions.php');
$debug=true;
function getDeals() {
	if ($_REQUEST['zip']) {
		$zip=$_REQUEST['zip'];
		$zip=cleanUp($zip);
		if (strlen($zip)>6) {
			$zip=substr($zip,0,5);
		}
		if (strlen($zip)==6) {
			$zip=substr($zip,0,3);
		}
		$strsql="select lat,lng from postalcodes where code='$zip'";
		#echo "zip $zip was ".$_REQUEST['zip'];
		$rows=getRows($strsql);
		$row=$rows[0];
		#print_r($rows);
		$diff=.3;
		$diff2=.07;
		$swlat=$row['lat']-$diff;
		$nelat=$row['lat']+$digg;
		$swlng=$row['lng']-$diff;
		$nelng=$row['lng']+$diff;
		$lookcount=0;
		$looking=true;
		while ($looking) {
			$sql="SELECT * FROM schools where (zippostal='".addslashes($_REQUEST['zip'])."') or ((lat+90)>=".($swlat+90)." and (lat+90)<=".($nelat+90)." and (lng+180)>=".($swlng+180)." and (lng+180)<=".($nelng+180).")";
			#echo $sql."\n<br>";
			$rows=getRows($sql);
			if (count($rows)==0) {//try again with wider window
				$swlat-=$diff2;
				$nelat+=$diff2;
				$swlng-=$diff2;
				$nelng+=$diff2; 
			}
			else {$looking=false;}
			
			if ($lookcount++>15) {$looking=false;}
		}
		//echo "zup is $strsql $swlat,$swlng  $nelat,$nelng\n<br>";
	}
	else {
		$swlat=$_REQUEST['swlat'];
		$swlng=$_REQUEST['swlng'];
		$nelat=$_REQUEST['nelat'];
		$nelng=$_REQUEST['nelng'];
	}
	
	$swlat+=90;
	$swlng+=180;
	$nelat+=90;
	$nelng+=180;
	$sql="SELECT * FROM schools where ((lat+90)>=".$swlat." and (lat+90)<=".$nelat." and (lng+180)>=".$swlng." and (lng+180)<=".$nelng.") ";
	if ($_REQUEST['zip']) {
		$sql.="or (zippostal='".addslashes($_REQUEST['zip'])."') ";
	}
	
	if ($_REQUEST['country']) {
		$sql.=" and country = '".addslashes($_REQUEST['country'])."'";
	}
	if ($_REQUEST['city']) {
		$sql.=" and city = '".addslashes($_REQUEST['city'])."'";
	}
	
	if ($_REQUEST['keywords']) {
		$dofullsearch=true;
		$keywords=$_REQUEST['keywords'];
		if (strlen($keywords)==2) {
			$keywords=strtoupper($keywords);
			$states=getStateAliases();
			if ($states[$keywords]) {
				$sql.=" and stateprovince='".$states[$keywords]."'";
				$dofullsearch=false;
			}
		}
		if ($dofullsearch && strlen($keywords)==4) {
			$k=str_replace(".","",$keywords);
			$k=strtoupper($k);
			if (strlen($k)==2) {
				$states=getStateAliases();
				if ($states[$k]) {
					$sql.=" and stateprovince='".$states[$k]."'";
					$dofullsearch=false;
				}
			}
		}
		if ($dofullsearch) {
			$fields =array('schoolname','recemail','address1','city','country','stateprovince');
			$words=explode(" ",addslashes($_REQUEST['keywords']));
				$where="(";
				for ($i=0;$i<count($words);++$i) {
					if ($i>0) {$where.=" and ";}
					$where.=" ( ";
					for ($j=0;$j<count($fields);++$j) {
						if ($j>0) {$where.=" or ";}
						$where.=$fields[$j]." like '%".$words[$i]."%'";
					}
					$where.=")";
				}
				$where.=")";
				$sql.=" and ".$where;
			}
		}
		
//	if ($_REQUEST['trans']==1) {
//		$sql="SELECT * FROM diningdeals where latitude>=".$swlat." and latitude<=".$nelat." and ";
//		$sql.="( longitude<=".$swlng." or longitude>=".$nelng.")";
//	}
	#echo $sql."\n<br>";
	$sql.=" order by schoolname";
	//echo $sql;
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
	$schoolname=cleanUp($schoolname);
	$address=cleanUp($address1);
	if ($address2) {
		$address.="<br/>".cleanUp($address2);
	}
	$phone="";
	if ($phone1label) {
		$phone=cleanUpLabel($phone1label).": ".cleanUp($phone1number);
	}
	if ($phone2label) {
		$phone.="<br>".cleanUpLabel($phone2label).": ".cleanUp($phone2number);
	}
	if ($phone3label) {
		$phone.="<br>".cleanUpLabel($phone3label).": ".cleanUp($phone3number);
	}
	$ages="";
	if ($infants) {
		$ages.="Infants|";
	}
	if ($toddlers) {
		$ages.="Toddlers|";
	}
	if ($primary) {
		$ages.="Age 3-6|";
	}
	if ($lowerel) {
		$ages.="Grades 1-3|";
	}
	if ($upperel) {
		$ages.="Grades 3-6|";
	}
	if ($middle) {
		$ages.="Grades 7-8|";
	}
	if ($highschool) {
		$ages.="High School|";
	}
	$specials="";
	if ($bilingual) {$specials.="Bilingual program|";}
	if ($horse) {$specials.="Horseback riding lessons|";}
	if ($swimming) {$specials.="Swimming lessons|";}
	if ($summerprogram) {$specials.="Summer program|";}
	if ($foreignlang) {$specials.="One or more foreign languages|";}
	if ($art) {$specials.="Art instruction|";}
	if ($dance) {$specials.="Dance instruction|";}
	if ($drama) {$specials.="Drama instruction|";}
	if ($library) {$specials.="Library available|";}
	if ($lunch) {$specials.="Lunch provided|";}
	if ($music) {$specials.="Music program|";}
	if ($montallday) {$specials.="All day montessori program|";}
	if ($transportation) {$specials.="Transportation available|";}
	if ($outdoored) {$specials.="Outdoor education|";}

	$lastmodified=cleanUpTime($lastmodified);
	$city=cleanUp($city);
	$year=cleanUp($yearfounded);
	$numberstudents=cleanUp($numberstudents);
	$stateprovince=cleanUp($stateprovince);
	$accreditations=cleanUp($accreditations);
	$affiliations=cleanUp($affiliations);
	$web=cleanUp($web);
	$web=str_replace("http://","",$web);
	if ($infoemail) {$email=$infoemail;}
	else {$email=$recemail;}
	if ($contactname) {$contact=$contactname;}
	else {$contact=$headofschoolname;}
	$email=cleanUp($email);
	$contact=cleanUp($contact);
?>
	<?= $joiner ?>
   {
      'latitude': <?= $lat ?>,
      'longitude': <?= $lng ?>,
      'id': <?= $id ?>,
      'name': '<?= addslashes($schoolname) ?>',
      'address': '<?= addslashes($address) ?>',
      'city': '<?= addslashes($city) ?>',
      'country': '<?= addslashes($country) ?>',
      'stateprovince': '<?= addslashes($stateprovince) ?>',
      'phone': '<?= addslashes($phone) ?>',
      'year': '<?= addslashes($year) ?>',
      'numberstudents': '<?= addslashes($numberstudents) ?>',
      'email': '<?= addslashes($email) ?>',
      'contact': '<?= addslashes($contact) ?>',
      'accreditations': '<?= addslashes($accreditations) ?>',
      'affiliations': '<?= addslashes($affiliations) ?>',
      'ages' : '<?= $ages ?>',
      'specials' : '<?= $specials ?>',
      'lastmodified' : '<?= $lastmodified ?>',
      'web': '<?= addslashes($web) ?>'
   }
	<?php 
		$joiner = ',';
		$count++;
	?>
<?php } ?>
]
}
<?php } 

function cleanUp($val) {
	$newval=str_replace('"','',$val);
	$newval=str_replace("'","&#39;",$newval);
	return $newval;
}
function cleanUpLabel($val) {
	$newval=str_replace('"','',$val);
	$newval=str_replace("'","&#39;",$newval);
	$newval=str_replace(":","",$newval);
	return $newval;
}
function cleanUpTime($t) {
	$formattedDate = date("l, jS F Y", strtotime($t));
	return $formattedDate;
}

function getStateAliases() {
	$states=array();
	$states['AL']="Alabama";
	$states['AK']="Alaska";
	$states['AZ']="Arizona";
	$states['AR']="Arkansas";
	$states['AS']="American Samoa";
	$states['CA']="California";
	$states['CO']="Colorado";
	$states['CT']="Connecticut";
	$states['DE']="Delaware";
	$states['DC']="District of Columbia";
	$states['FM']="Fed. States of Micronesia";
	$states['FL']="Florida";
	$states['GA']="Georgia";
	$states['GU']="Guam";
	$states['HI']="Hawaii";
	$states['ID']="Idaho";
	$states['IL']="Illinois";
	$states['IN']="Indiana";
	$states['IA']="Iowa";
	$states['KS']="Kansas";
	$states['KY']="Kentucky";
	$states['LA']="Louisiana";
	$states['ME']="Maine";
	$states['MD']="Maryland";
	$states['MH']="Marshall Islands";
	$states['MA']="Massachusetts";
	$states['MI']="Michigan";
	$states['MN']="Minnesota";
	$states['MS']="Mississippi";
	$states['MO']="Missouri";
	$states['MT']="Montana";
	$states['NE']="Nebraska";
	$states['NV']="Nevada";
	$states['NH']="New Hampshire";
	$states['NJ']="New Jersey";
	$states['NM']="New Mexico";
	$states['NY']="New York";
	$states['NC']="North Carolina";
	$states['ND']="North Dakota";
	$states['MP']="Northern Marianas";
	$states['OH']="Ohio";
	$states['OK']="Oklahoma";
	$states['OR']="Oregon";
	$states['PA']="Pennsylvania";
	$states['PR']="Puerto Rico";
	$states['RI']="Rhode Island";
	$states['SC']="South Carolina";
	$states['SD']="South Dakota";
	$states['TN']="Tennessee";
	$states['TX']="Texas";
	$states['UT']="Utah";
	$states['VT']="Vermont";
	$states['VA']="Virginia";
	$states['VI']="(U.S.) Virgin Islands";
	$states['WA']="Washington";
	$states['WV']="West Virginia";
	$states['WI']="Wisconsin";
	$states['WY']="Wyoming";
	$states['AA']="Armed Forces, the Americas";
	$states['AE']="Armed Forces, Europe";
	$states['AP']="Armed Forces, Pacific";
	$states['AB']="Alberta";
	$states['BC']="British Columbia";
	$states['MB']="Manitoba";
	$states['NB']="New Brunswick";
	$states['NL']="Newfoundland and Labrador";
	$states['NT']="Northwest Territories";
	$states['NS']="Nova Scotia";
	$states['NU']="Nunavut";
	$states['ON']="Ontario";
	$states['PE']="Prince Edward Island";
	$states['QC']="Québec";
	$states['SK']="Saskatchewan";
	$states['YT']="Yukon Territory";
	return $states;
	
}
?>