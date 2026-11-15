<?php
header('Content-Type: application/javascript; charset=utf-8');
error_reporting  (E_ALL ^ E_NOTICE ^ E_WARNING);
$requestedZoom = $_REQUEST['startzoom'] ?? '9';
$requestedZoom = is_scalar($requestedZoom) ? filter_var($requestedZoom, FILTER_VALIDATE_INT) : false;
$startZoom = $requestedZoom !== false && ($requestedZoom === -1 || ($requestedZoom >= 1 && $requestedZoom <= 20)) ? $requestedZoom : 9;
?>
var lastrequesttime=0;

var startZoom = <?=$startZoom ?>;
var map;
var markerCluster;
var skoolswitch;
var lastsearch="";

var bounds = null;
bounds = null;
var clusterer;
var currentmarkers=[];
var currentmarkerscount=0;
var maxbuffersize=20;
var busy=false;

function setFocusSchool(id,lat,lng,z) {
	var curzoom=map.getZoom();
	if (z==-1) {
		z=curzoom;
	}
	if (z==100) {
		z=curzoom+2;
		if (z>12) {z=curzoom;}
	}
	if (lat>-180) {
		map.setCenter(new google.maps.LatLng(lat,lng));
		map.setZoom(z);
	}
	//var iframeelem=document.getElementById('detailframe');
	//iframeelem.src="/search/js2/schoolsdetail.php?id="+id;
	//window.open("/search/js2/schoolsdetail.php?id="+id);
}
		

function addMarker(latitude, longitude, description,map) {
		var latlng = new google.maps.LatLng(latitude, longitude);
    var marker = new google.maps.Marker ({'position': latlng});
    
		marker.infowindow = new google.maps.InfoWindow({
		    content: description
		});

    //marker.getIcon().infoShadowAnchor  = new google.maps.Point (0,0);
    google.maps.event.addListener(marker, 'click',
        function() {
        	marker.infowindow.open({map, anchor: marker});
          //  marker.openInfoWindowHtml(description);
        }
    );
    /*
    google.maps.event.addListener(marker, 'mouseout',
        function() {
        	marker.infowindow.close();
        }
    );
    */
    
		return marker;
}

function changed() {
	alert('changed!');
}
async function init() {
	const { Map } = await google.maps.importLibrary("maps");
	bounds = new google.maps.LatLngBounds();
//if (GBrowserIsCompatible()) {	
	    var myOptions = {
		    zoom: startZoom,
		    center: new google.maps.LatLng(centerLatitude, centerLongitude),
		    navigationControl: true,
	    // Add controls
	    mapTypeControl: true,
	    scaleControl: true,
	    overviewMapControl: true,
	    overviewMapControlOptions: {
	      opened: true
    	}
		};

        map = new Map(document.getElementById("map"),myOptions);
        //map.setZoom(startZoom);
        //map.addControl(new GSmallMapControl());
    //map.addControl(new GLargeMapControl());
//    map.addControl(new GMapTypeControl());
			//	map.enableContinuousZoom();
				

				//map.fitBounds(bnds);
		google.maps.event.addListenerOnce(map, 'idle', function(){
		    init2(map);
		});
	
}

function init2(map) {
		google.maps.event.addListener(map,'idle',
			function() {
					if (!busy) {
						var z=(0+map.getZoom());
						if (z>6) {
							var bnds=map.getBounds();
							var sw=bnds.getSouthWest();
							var ne=bnds.getNorthEast();
							//setStatus("Looking for schools between "+sw.lat()+"," +sw.lng() + " and "+ne.lat()+", "+ne.lng());
		  				
							getMarkers(sw.lat(),ne.lat(),sw.lng(),ne.lng());
							busy=true;
						}
		  			else {
		  				setStatus("<b>You are zoomed out too much to display school icons.</b>");
		  				busy=false;
		  			}
					} //end if not busy
				}//end function
			); //end addlistener
			var bounds=map.getBounds();
			if (!bounds) {alert("bounds is not set");}
			else {
				//alert("bounds *is* set")
				getMarkers(map.getBounds().getSouthWest().lat(),map.getBounds().getNorthEast().lat(),
				map.getBounds().getSouthWest().lng(),map.getBounds().getNorthEast().lng());
				currentmarkers.push(addMarker(0,0,'No schools found',map));
				var mstyleopts= new Object();
				mstyleopts.gridSize=30;
				mstyleopts.imagePath='../assets/markerclusterer/m';
				//mstyleopts.maxZoom=10;
				markerCluster = new MarkerClusterer(map, currentmarkers,mstyleopts);
				markerCluster.clearMarkers();
			}
    //}
    
		if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)){ //test for Internet Explorer
	 		var iev=new Number(RegExp.$1)
	 	
			if (iev<=7) {
				
				var mapel=document.getElementById('map');
				mapel.style.height=0;
				var nomap=document.getElementById('nomap');
				nomap.innerHTML="<p style=\"padding: 50px;\">If you are seeing this message then we are afraid that your web browser is not compatible with this site. We recommend you upgrade to <a href=\"http://www.mozilla.com/en-US/firefox/ie.html\">one</a> of the <a href=\"http://www.microsoft.com/windows/internet-explorer/default.aspx\">modern</a> <a href=\"http://www.google.com/chrome\">browers</a>.</p>";
				alert("You are using Internet Explorer version "+iev+", which is not compatible with this site. Please upgrade or use a different browser such as Firefox or Cchrome.");
			}
		}
}

function setUpClusterer() {
}

//Gets the browser specific XmlHttpRequest Object
function getXmlHttpRequestObject() {
	if (window.XMLHttpRequest) {
		return new XMLHttpRequest();
	} else if(window.ActiveXObject) {
			return new ActiveXObject("Microsoft.XMLHTTP");
	} else {
		document.getElementById('p_status').innerHTML = 		'Status: Cound not create XmlHttpRequest Object.' +		'Consider upgrading your browser.';
	}
}
var getPointsReq = getXmlHttpRequestObject();
var lastdate="";

function resetMap() {
	window.location="index.php?centerlat="+map.getCenter().lat()+"&centerlong="+map.getCenter().lng()+"&startzoom="+map.getZoom();
//	searchtermtext="";
//	getMarkers(map.getBounds().getSouthWest().lat(),map.getBounds().getNorthEast().lat(),map.getBounds().getSouthWest().lng(),map.getBounds().getNorthEast().lng(),true);
}
function getMarkers(swlat,nelat,swlng,nelng,ignoresearch) {
	var newrequesttime=getUTCTime();
	var i=0;
	if (newrequesttime-lastrequesttime<500) {
		var foo="";
		for (i=0;i<1000;++i) {
			foo+="i "+i; //eat up time
		}
	}
	lastrequesttime=newrequesttime;
	i=0;
	var checking=true;
	while (checking) {
		if (getPointsReq.readyState == 4 || getPointsReq.readyState == 0) {
			checking=false;
		}
		++i;
		if (i>1000) {checking=false;}
	}
	
		var sw=swlng;
		var ne=nelng;
		//var trans=0;
		//if (swlng>nelng) { //looking at a part of the world that crosses the longitude transition from - to +
		//	trans=1;
		//}
		
		var urlstr='js2/getschools.php?swlat='+swlat+'&nelat='+nelat+'&swlng='+sw+'&nelng='+ne;//+'&trans='+trans;
		
		var deletedbox=document.getElementById('deletedbox');
		if (deletedbox && deletedbox.checked) {
				urlstr += '&deleted=true';
		}
		
		
		if (! ignoresearch) {
		<?php
		foreach (['keywords', 'country', 'city', 'zip'] as $parameter) {
			$value = $_REQUEST[$parameter] ?? '';
			if (is_scalar($value) && trim((string) $value) !== '') {
				echo "urlstr += '&{$parameter}=" . rawurlencode(trim((string) $value)) . "';\n";
			}
		}
		
		?>
		}
		//alert('calling: '+urlstr);
		dorequest(urlstr);

}
function dorequest(requrl) {
	setIsLooking("<blink><font size=\"2\">searching...</font></blink>");
	lastsearch=requrl;
	//alert(requrl);
	getPointsReq.open('GET',requrl,true);
	lastdate = new Date().getTime();
	getPointsReq.onreadystatechange = function () {
		if (getPointsReq.readyState==4) {
			addNewMarkers(lastdate);
		}
	};

	getPointsReq.send(null);
}
function addNewMarkers(reqdate) {
	if (reqdate!=lastdate) {return;}
	//alert("zere we are!"+getPointsReq.readyState);
	if (getPointsReq.readyState!=4) {return;}
	var markers;
	try {
		if (getPointsReq.status!=200) {
			throw new Error("HTTP "+getPointsReq.status);
		}
		markers=JSON.parse(getPointsReq.responseText).datarray;
		if (!Array.isArray(markers)) {
			throw new Error("missing datarray");
		}
	}
	catch (errobj) {
		// Never retry automatically: a bad response would otherwise be requested again forever.
		busy=false;
		setIsLooking("");
		setStatus("<b>Sorry, the school list could not be loaded.</b> Move the map to try again.");
		if (window.console) {console.error("School data request failed", errobj);}
		return;
	}
	if (markers.length==0) {
		busy=false;
		setIsLooking("");
		var statusmsg="NO RESULTS FOUND FOR SEARCH";
		if (searchtermtext.length>0) {
			statusmsg+=" '"+searchtermtext+"'";
		}
		statusmsg+=".";
		setStatus(statusmsg);
		return;
	}
	setIsLooking("");
	//alert("Processed.");
	var first=true;
	currentmarkers=[];
	currentmarkerscount=0;
	var cnt=0;
	var liststr="";
	for (var i=0;i<markers.length;++i) {
//		extraobj.innerHTML+="<br>\n"+id;
		++cnt;
		var mapmovestr="parent.setFocusSchool("+markers[i].id+","+markers[i].latitude+","+markers[i].longitude+",-1);";
		var zoommapmovestr="parent.setFocusSchool("+markers[i].id+","+markers[i].latitude+","+markers[i].longitude+",100);";
		var nomapmovestr="parent.setFocusSchool("+markers[i].id+",-10000,-10000,-1);";
		var expandcontent="detailfocus('schoolcontent"+cnt+"-title','schoolcontent"+cnt+"');";
		liststr+="<a class=\"centermap\" href=\"javascript:void(0);\" onClick=\""+zoommapmovestr+"\">Center Map<br>On School</a>";
		liststr+="<div class=\"schoolink\"><a name=\"schoolcontent"+cnt+"-title\"><span id=\"schoolcontent"+cnt+"-title\" class=\"schoolname\">\n";
		liststr+=markers[i].name+"</span></a><br/><font color=\"#000000\">\n";
	//	liststr+="<!--<a href=\"javascript:void(0);\" onClick=\""+zoommapmovestr+"\"><img src=\"/images/zoom.png\" border=\"0\"></a>-->";
	liststr+=markers[i].address+"</font>\n";
		liststr+="<div id=\"schoolcontent"+cnt;
		liststr+="\" class=\"switchgroup1\"><font color=\"#000000\">";
		var strcountry=markers[i].country;
		if (strcountry == "United States") {strcountry="U.S.";}
		liststr+=markers[i].city+", "+markers[i].stateprovince+"  "+strcountry+" &nbsp; &nbsp; ";
		
		var directionsurl=encodeURIComponent(markers[i].address+", "+markers[i].city+", "+markers[i].stateprovince+" "+markers[i].country);
		liststr+="<span class=\"directions\"><a href=\"https://www.google.com/maps/dir/?api=1&destination="+directionsurl+"\">[ directions ]</a></span><br>\n";
		if (markers[i].web && (markers[i].web.toUpperCase() != "UNKNOWN")) {
			liststr+="<div class=\"hassite\"><a href='http://"+markers[i].web+"' target=\"_new\">"+markers[i].web+"</a></div/>";
		}
		else {
			liststr+="<div class=\"nosite\">No Web Site Known - unverified listing<br/>If you discover that this school does or does not exist, please <a href=\"mailto:schoolsdb@guidedstudies.com?subject=status of school "+markers[i].id+"&body=Here is what I know about "+markers[i].name+"\">let us know</a>.</div>\n";
		}
		liststr+=markers[i].phone+"<br/>";
		if (markers[i].affiliations) {
			liststr+="<div class=\"cat\">Affiliations: "+markers[i].affiliations+"\n</div>";
		}
		if (markers[i].accreditations) {
			liststr+="<div class=\"cat\">Accreditations: "+markers[i].accreditations+"\n</div>";
		}
		if (markers[i].contact) {
			liststr+="<div class=\"cat\">Contact: "+markers[i].contact+"\n</div>";
		}
		if (markers[i].email) {
			liststr+="<div class=\"cat\">Email: "+markers[i].email+"\n</div>";
		}
		if (markers[i].numberstudents && markers[i].numberstudents>0) {
			liststr+="<div class=\"cat\">Number of students: "+markers[i].numberstudents+"\n</div>";
		}
		if (markers[i].ages) {
			var ages=markers[i].ages.split("|");
			liststr+="<div class=\"cat\">Ages taught:<br/>";
			for (var a=0;a<ages.length;++a) {
				liststr+=" &nbsp; &nbsp; "+ages[a]+"\n<br/>";
			}
			liststr+="\n</div>";
		}
		if (markers[i].specials) {
			var specials=markers[i].specials.split("|");
			liststr+="<div class=\"cat\">Specials taught:";
			for (var s=0;s<specials.length;++s) {
				liststr+="<br> &nbsp; &nbsp; "+specials[s]+"\n";
			}
			liststr+="</div>";
		}
		if (markers[i].year && markers[i].year>0) {
			liststr+="Year founded: "+markers[i].year+"\n<br/>";
		}
		if (markers[i].lastmodified) {
			liststr+="<div class=\"lastmod\">RECORD LAST MODIFIED: "+markers[i].lastmodified+"\n</div>";
		}
		if (markers[i].id) {
			liststr+="<div class=\"markerid\">school id "+markers[i].id+"</div>\n";
		}
		
		liststr+="</font>\n";

		liststr+="</div></div>";
		var uid=markers[i].id;
		++currentmarkerscount;
		
		html= "<div><p align=\"center\"><a href=\"javascript:void(0);\" onClick=\""+expandcontent+"\">" + markers[i].name + "</a><br/><span class=\"clickdetail\">(click on name to get school detail)</span></p>\n" + markers[i].address + ", " + markers[i].city + "</div>";
	  currentmarkers.push(addMarker(markers[i].latitude, markers[i].longitude, html,map));
		var point = new google.maps.LatLng(markers[i].latitude, markers[i].longitude);
		bounds.extend(point);
	}
	liststr+="<span id=\"lastitemspan\" style=\"visibility: visible\"> </span>\n";
	
	setList(liststr);
	//map.setCenter(bounds.getCenter());
	if (startZoom==-1) {
		map.setCenter(bounds.getCenter());
		map.fitBounds(bounds);
		startZoom=map.getZoom();
		//startZoom=map.getBoundsZoomLevel(bounds);
		map.setZoom(startZoom);
	}
	//map.setCenter(bounds.getCenter(), map.getBoundsZoomLevel(bounds)); 
	//if (currentmarkerscount>maxbuffersize) { //if too many, garbage collect ones that are not visible.
	//	removeOldMarkers();
	//}
	var statmsg="Found "+markers.length+" schools ";
	if (searchtermtext.length>0) {
		statmsg+="for term(s) '"+searchtermtext+"'";
	}
	setStatus(statmsg);
	markerCluster.clearMarkers();
	markerCluster.addMarkers(currentmarkers);
	markerCluster.resetViewport();
	currentmarkerscount=currentmarkers.length;
	busy=false;
}

function setStatus(msg) {
	var divcount=document.getElementById('curcount');
	divcount.innerHTML=msg;
	
}
function setIsLooking(msg) {
	var divcount=document.getElementById('islooking');
	divcount.innerHTML=msg;
}


function detailfocus(titleel,contentel) {
	var iframeelem=document.getElementById('schoollist');
	var newdoc=iframeelem.contentDocument;
	if (!newdoc) {
		newdoc=iframeelem.contentWindow.document;
	}
	//iframeelem.contentWindow.hash=titleel;
	var innerel=newdoc.getElementById(titleel);
	var objpos=getObjPos(innerel);
	 try{
	        iframeelem.contentWindow.scroll(0,objpos[1]);
	    }catch(e){}
	    try{
	        iframeelem.contentWindow.scrollTo(0,objpos[1]);
	    }catch(e){}
	    skoolswitch.expandcontent(innerel);
	    //innerel.style.color='#ff0000';
	    //alert(innerel.innerHTML+": "+innerel.id+" = "+innerel.style.color+", "+innerel.className);
//	alert("afocusing on "+titleel+", "+objpos[1]);
//	innerel.focus();
}

function getObjPos(obj) {
	    var curleft = 0;
	      var curtop = 0;
	      if (obj.offsetParent) {
	            do {
	                  curleft += obj.offsetLeft;
	                  curtop += obj.offsetTop;
	            } while (obj = obj.offsetParent);
	      }
	      return [curleft,curtop];
}
function setList(msg) {
	var iframeelem=document.getElementById('schoollist');
	var newdoc=iframeelem.contentDocument;
	if (!newdoc) {
		newdoc=iframeelem.contentWindow.document;
	}
	var innerel=newdoc.getElementById('listinnerel');
	innerel.innerHTML=msg;
	
	skoolswitch=new switchcontent("switchgroup1", "div", newdoc) //Limit scanning of switch contents to just "div" elements
	skoolswitch.setStatus('<span class=\"toggle\"><img src=\"tridown.gif\" border=\"0\" width=\"16\" height=\"16\"></span>', '<span class=\"toggle\"><img src=\"triright.gif\" border=\"0\" width=\"16\" height=\"16\"></span>')
	skoolswitch.setColor('darkred', '')
	skoolswitch.setPersist(false)
	skoolswitch.collapsePrevious(true) //Only one content open at any given time
	skoolswitch.init();
}


function removeOldMarkers() {
	var bnds=map.getBounds();
	var sw=bnds.getSouthWest();
	var ne=bnds.getNorthEast();
	var swlng=sw.lng()+180;
	var nelng=ne.lng()+180;
	var swlat=sw.lat()+90;
	var nelat=ne.lat()+90;
	var newarray=[];
	
	for(i=0;i<currentmarkers.length;++i) {
		marker=currentmarkers[i];
		var lat=marker.getLatLng().lat()+90;
		var lng=marker.getLatLng().lng()+180;
		if (lat<swlat || lat>nelat || lng<swlng || lng>nelng) {
			--currentmarkerscount;
			//markerCluster.removeMarker(marker);
		}
		else {
			newarray.push(marker);
		}
	}
	currentmarkers=newarray;
}

function getUTCTime() {
	var d = new Date();
	return d.getTime();
}
