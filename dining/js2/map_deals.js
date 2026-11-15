var map;
var bounds = null;
bounds = new GLatLngBounds();
var clusterer;
var currentmarkers=Array();
var currentmarkerscount=0;
var maxbuffersize=20;
var busy=false;

function addMarker(latitude, longitude, description) {
    var marker = new GMarker(new GLatLng(latitude, longitude));
    GEvent.addListener(marker, 'mouseover',
        function() {
            marker.openInfoWindowHtml(description);
        }
    );
		clusterer.AddMarker(marker,description);
    //map.addOverlay(marker);
    return marker;
}

function changed() {
	alert('changed!');
}

function init() {
    if (GBrowserIsCompatible()) {	
        map = new GMap2(document.getElementById("map"));
        map.addControl(new GSmallMapControl());
        map.setCenter(new GLatLng(centerLatitude, centerLongitude), startZoom);
				clusterer =	setUpClusterer(clusterer);
				
		GEvent.addListener(map,'moveend',
			function() {
				if (!busy) {
					busy=true;
					var bnds=map.getBounds();
					var sw=bnds.getSouthWest();
					var ne=bnds.getNorthEast();
					getMarkers(sw.lat(),ne.lat(),sw.lng(),ne.lng());
	  			//alert("You moved the map to "+sw.lat()+","+sw.lng()+" to "+ne.lat()+","+ne.lng());
					}
				}
			);
			getMarkers(map.getBounds().getSouthWest().lat(),map.getBounds().getNorthEast().lat(),
			map.getBounds().getSouthWest().lng(),map.getBounds().getNorthEast().lng());
    }
}

function setUpClusterer() {
	var numicons=5;
	clusterer=new Clusterer(map,numicons);
	clusterer.SetMaxVisibleMarkers(20);
	clusterer.SetMinMarkersPerCluster(2);
	clusterer.SetMaxLinesPerInfoBox(5);
	
	for (var i=1;i<=numicons;++i) {
		var icon = new GIcon();
		icon.image = '/dining/js2/cluster'+i+'.gif';
		//icon.shadow = 'http://www.acme.com/resources/images/markers/shadow_large.PNG';
		icon.iconSize = new GSize( 30, 51 );
		//icon.shadowSize = new GSize( 56, 51 );
		icon.iconAnchor = new GPoint( 13, 34 );
		icon.infoWindowAnchor = new GPoint( 13, 3 );
		icon.infoShadowAnchor = new GPoint( 27, 37 );
		clusterer.SetNumberedIcon(i,icon);
	}
	var icon = new GIcon();
	icon.image = '/dining/js2/cluster5plus.gif';
	//icon.shadow = 'http://www.acme.com/resources/images/markers/shadow_large.PNG';
	icon.iconSize = new GSize( 30, 51 );
	//icon.shadowSize = new GSize( 56, 51 );
	icon.iconAnchor = new GPoint( 13, 34 );
	icon.infoWindowAnchor = new GPoint( 13, 3 );
	icon.infoShadowAnchor = new GPoint( 27, 37 );
	clusterer.SetMaxNumberedIcon(icon);
	return clusterer;
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

function getMarkers(swlat,nelat,swlng,nelng) {
	if (getPointsReq.readyState == 4 || getPointsReq.readyState == 0) {
		var sw=swlng;
		var ne=nelng;
		//var trans=0;
		//if (swlng>nelng) { //looking at a part of the world that crosses the longitude transition from - to +
		//	trans=1;
		//}
		
		var urlstr='http://schools.guidedstudies.com/dining/js2/data_deals.php?swlat='+swlat+'&nelat='+nelat+'&swlng='+sw+'&nelng='+ne;//+'&trans='+trans;
		//alert('calling: '+urlstr);
		getPointsReq.open('GET',urlstr,true);
		getPointsReq.onreadystatechange =addNewMarkers;
		getPointsReq.send(null);
	}
}
function addNewMarkers() {
	//alert("zere we are!"+getPointsReq.readyState);
	if (getPointsReq.readyState!=4) {return;}
	var markstr="("+getPointsReq.responseText+")";
	try {
		markers=eval(markstr).datarray;
	}
	catch (errobj) {
		return;
	}
				
	for(id in markers) {
		if (!currentmarkers[id]) { //if not already on map
			++currentmarkerscount;
			html= "<div><a href=\"http://longisland.newsday.com/diningdeals/index.php?controller=product&product_id=" + markers[id].id + "\">" + markers[id].name + "</a><br>" + markers[id].address + ", " + markers[id].city + "</div>";
	    currentmarkers[id]=addMarker(markers[id].latitude, markers[id].longitude, html);
			var point = new GLatLng(markers[id].latitude, markers[id].longitude);
			bounds.extend(point); 
		}
	}
	//map.setCenter(bounds.getCenter(), map.getBoundsZoomLevel(bounds)); 
	if (currentmarkerscount>maxbuffersize) { //if too many, garbage collect ones that are not visible.
		removeOldMarkers();
	}
	
	var divcount=document.getElementById('curcount');
	divcount.innerHTML="got "+markers.length+" ("+currentmarkerscount+")";
	busy=false;
}
	
function removeOldMarkers() {
	var bnds=map.getBounds();
	var sw=bnds.getSouthWest();
	var ne=bnds.getNorthEast();
	var swlng=sw.lng()+180;
	var nelng=ne.lng()+180;
	var swlat=sw.lat()+90;
	var nelat=ne.lat()+90;
	
	for(id in currentmarkers) {
		var marker=currentmarkers[id];
		
		marker.setMap(null);
		
		var lat=marker.getLatLng().lat()+90;
		var lng=marker.getLatLng().lng()+180;
		if (lat<swlat || lat>nelat || lng<swlng || lng>nelng) {
			delete currentmarkers[id];
			--currentmarkerscount;
			clusterer.RemoveMarker(marker);
		}
	}
}
window.onload = init;
window.onunload = GUnload;
