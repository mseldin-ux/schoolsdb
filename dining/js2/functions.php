<?php
 function connect() {
  //Connect to a mysql database
    require ('dbinfo.inc.php');
    $dbc=mysql_connect('127.0.0.1',$username,$password) or die ("Unable to connect to server");
    mysql_select_db ("schools") or die ("Unable to select database");
	return $dbc;
 }

function getValue($sql) { // return single value
   $dbc=connect();  //Need connection
   if($debug) {echo $sql."<br>";}
   $r = mysql_query($sql,$dbc);
   $num = mysql_numrows($r);
   if ($num==0) {
			$value=NULL; // no match, return null
		} else {
			$value=mysql_result($r,0,0);
		}
		return $value;
		mysql_free_result($r);
}
	
function getRow ($sql){ // return single row
	$dbc=connect();  //Need connection
	if($debug) {echo $sql."<br>";}
	$r = mysql_query($sql,$dbc);
	$num = mysql_numrows($r);
	if ($num==0) {
		$row=NULL; // no match
	} else {
		$row=mysql_fetch_assoc($r); 
		return $row;
	}
	mysql_free_result($r);
}

function getRows ($sql) { //return rows
	$dbc=connect();  //Need connection
	if($debug) {echo $sql."<br>";}
	$r = mysql_query($sql,$dbc);
	$num = mysql_numrows($r);
	if ($num==0) {
		$rows=NULL;  // no match
	} else {
		$i=0;
		while ($i < $num) {
			$row=mysql_fetch_assoc($r);
			$rows["$i"] = $row;
			$i++;
		}
	}
	mysql_free_result($r);
	return $rows;
}

function insertRecords ($sql) {
    $dbc=connect();  //Need connection
	$r = mysql_query($sql,$dbc);
	printf ("Inserted records: %d\n", mysql_affected_rows());
}

function updateRecords ($sql) {
   $dbc=connect();  //Need connection
	$r = mysql_query($sql,$dbc);
	printf ("Updated records: %d\n", mysql_affected_rows());
}
	
function deleteRecords ($sql) {
   $dbc=connect();  //Need connection
	$r = mysql_query($sql,$dbc);
	printf ("Deleted records: %d\n", mysql_affected_rows());
}

function escape_data ($data) {
	$dbc=connect();  //Need connection
	if(ini_get('magic_quotes_gpc')) {
		$data = stripslashes($data);
	}
	return mysql_real_escape_string
		(trim($data), $dbc);
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