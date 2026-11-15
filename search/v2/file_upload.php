<?php

$file_name = $_FILES['video']['name'];
$file_temp = $_FILES['video']['tmp_name'];
$file_type = $_FILES['video']['type'];
$file_size = $_FILES['video']['size'];
$file_emsg = $_FILES['video']['error'];

$file_path = "uploads/" . $file_name;

if(!$file_temp) {
	echo "ERROR: Please select a file for upload.";
	exit();
}

if(move_uploaded_file($file_temp, $file_path) {
	echo $file_name . " upload is complete.";
} else {
	echo "There was an error uploading your file. Please try again. If the error persists reach out to <a href='mailto:support@guidedstudies.com'>Support</a>";
}

?>