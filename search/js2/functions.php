<?php

error_reporting  (E_ALL ^ E_NOTICE ^ E_WARNING);
 function connect() {
  //Connect to a mysql database
    require ('dbinfo.inc.php');
    $dbc=mysqli_connect($dbhost,$username,$password);
  	if (!$dbc) {
  		echo 'Could not connect: ' . $dbc->error;
  		exit;
  	}
  	
    mysqli_select_db ($dbc,$dbname) or die ("Unable to select database");
	return $dbc;
 }

function getValue($sql) { // return single value
   $dbc=connect();  //Need connection
   if($debug) {echo $sql."<br>";}
   $r = $dbc->query($sql);
   $num = $r->num_rows;
   if ($num==0) {
			$value=NULL; // no match, return null
		} else {
			$row = $r->fetch_row();
			$value=$row[0];
		}
		$r->close();
		return $value;
}
	
function getRow ($sql){ // return single row
	$dbc=connect();  //Need connection
	if($debug) {echo $sql."<br>";}
	$r = $dbc->query($sql);
  $num = $r->num_rows;
  if ($num==0) {
		$row=NULL; // no match
	} else {
		$row=mysqli_fetch_assoc($r); 
		$r->close();
		return $row;
	}
	$r->close();
}

function getRows ($sql) { //return rows
	$dbc=connect();  //Need connection
	if($debug) {echo $sql."<br>";}
	$r = $dbc->query($sql);
  $num = $r->num_rows;
  #echo $sql."\n";
  #echo "found $num \n";
  if ($num==0) {
		$rows=NULL;  // no match
	} else {
		$i=0;
		while ($i < $num) {
			$row=mysqli_fetch_assoc($r); 
			#$newrow=array();
			#foreach ($row as $k=>$v) {$newrow[$k]=$v;}
			$rows["$i"] = $row;
			$i++;
		}
	}
	$r->close();
	return $rows;
}

function insertRecords ($sql) {
  $dbc=connect();  //Need connection
	$r = $dbc->query($sql);
  printf ("Inserted records: %d\n", mysqli_affected_rows($dbc));
  $r->close();
}

function updateRecords ($sql) {
  $dbc=connect();  //Need connection
	$r = $dbc->query($sql);
  printf ("Updated records: %d\n", mysqli_affected_rows($dbc));
  $r->close();
}
	
function deleteRecords ($sql) {
	$dbc=connect();  //Need connection
	$r = $dbc->query($sql);
  printf ("Deleted records: %d\n", mysqli_affected_rows($dbc));
  $r->close();
}

function escape_data ($data) {
	$dbc=connect();  //Need connection
	if(ini_get('magic_quotes_gpc')) {
		$data = stripslashes($data);
	}
	return $dbc->real_escape_string(trim($data));
}

function buildSelect($array, $id, $value, $selected){
	foreach ($array as $key){
		if($selected == $key[$id]){
			echo "<option value=\"".$key[$id]."\" selected >".$key[$value]."</option>\n";
		} else {
			echo "<option value=\"".$key[$id]."\">".$key[$value]."</option>\n";
		}
	}
}

function currency ($value,$z) {
		if($z && $value==0) {
			$m="--";
		} else if ($z==2) {
			$m='$'.number_format($value,2);
		} else { 	
 			$m='$'.number_format($value,",");
		}
		return $m; 
	}
	
	function comma ($value,$z) {
		if ($z && $value==0) {
			$m="--";
		} else {
			$m = number_format($value,",");
		}
		return $m;	
	}
	
	function percent ($value,$z) {
		if ($z && $value==0) {
			$m="--";
		} else {
			$m = number_format($value*100) . "%";
		}
		return $m;
	}
	
	function decimal ($value,$z) {
		if ($z && $value==0) {
			$m="--";
		} else {
			$m = number_format($value,2);
		}
		return $m;
	
	
	}
	
	?>