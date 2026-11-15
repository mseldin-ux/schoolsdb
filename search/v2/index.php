<!DOCTYPE html>
<html>
<head>
	<title>Video Uploader Test</title>
</head>
<body>

<form id="upload-control" enctype="multipart/form-data" method="POST" >
	<input type="file" name="video" id="video" />
	<input type="button" value="Upload" onclick="uploadFile()" />
	<progress id="uploadprogress" value="0" max="100" class='hidel' style="width:300px"></progress>
	<h3 id="uploadstatus"></h3>
	<p id="uploadrate"></p>
</form>

<style>
	.hidel { display: none; !important }
</style> 

<script>

	function _(el) {
		return document.getElementById(el);
	}

	function uploadFile() {
		var file = _("video").files[0];
		_("uploadprogress").classList.remove("hidel");
		
		var formdata = new FormData();
		formdata.append("video", file);

		var ajax = new XMLHttpRequest();
		ajax.upload.addEventListener("progress", progressHandler, false);
		ajax.addEventListener("load", completeHandler, false);
		ajax.addEventListener("error", errorHandler, false);
		ajax.addEventListener("abort", abortHandler, false);
		ajax.open("POST", "file_upload.php");
		ajax.send(formdata);
	}

	function progressHandler(event) {
		_("uploadrate").innerHTML = "Uploaded " + event.loaded + " bytes of " + event.total;
		var percent = (event.loaded / event.total) * 100;
		_("uploadprogress").value = Math.round(percent);
		_("uploadstatus").innerHTML = Math.round(percent) + "% uploaded...please wait";
	}

	function completeHandler(event) {
		_("uploadstatus").innerHTML = event.target.responseText;
		_("uploadprogress").value = 0;
		_("uploadprogress").classList.add('hidel');
	}

	function errorHandler(event) {
		_("status").innerHTML = "Upload Failed";
	}

	function abortHandler(event) {
		_("status").innerHTML = "Upload Aborted"
	}

</script>


</body>
</html>