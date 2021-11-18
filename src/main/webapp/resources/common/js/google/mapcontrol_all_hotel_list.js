var ggle_map = null;
var ggle_search = null;
var ggle_geocoder = null;
var ggle_responseSearchFuncName="";
function ggle_mapload(mapname, lat, lng, zoomlevel, bsearchcontrol, blargemapcontrol) {
	$("#mapcontainer").show();
	ggle_maploadCore(mapname, lat, lng, zoomlevel, bsearchcontrol, blargemapcontrol, true);
}
function ggle_maploadCore(mapname, lat, lng, zoomlevel, bsearchcontrol, blargemapcontrol, bshowcontrol) {
	try{
  if (GBrowserIsCompatible()) {
	
	var tw = 870;
	var th = 550;
	try{	

	var msw = document.getElementById(mapname).style.width;
	var msh = document.getElementById(mapname).style.height;
	if(msw!="" && msh!="")
	{
		msw=msw.replace("px", "");
		msh=msh.replace("px", "");
		tw=parseInt(msw, 10);
		th=parseInt(msh, 10);
	}
	}
	catch(e)
	{
	}
	 geocoder =  new google.maps.Geocoder();

  	ggle_map = new GMap2(document.getElementById(mapname),
  		    { size: new GSize(tw,th) } );

	
	//var  image = "/images/ggle_icons/hotel00_C.png";
		GEvent.addListener(ggle_map, "dragstart", 
	function() {
			document.getElementById("IsMarkerClick").value=""
			$("#SearchTargetPoint").show();
			 
		}
	 );




	GEvent.addListener(ggle_map, "zoomend", function(oldzoomlevel, newzoomlevel) {
	  //alert(oldzoomlevel +" " + newzoomlevel);
	  document.getElementById("IsMarkerClick").value=""
	    if(oldzoomlevel== newzoomlevel){
			$("#SearchTargetPoint").hide();
			}
		else{
			$("#SearchTargetPoint").show();
			}	
	});
	
	
	
	GEvent.addListener(ggle_map, "moveend", 
	function() {    

		
	 if (document.getElementById("IsMarkerClick").value=="Y")
	 {
		
		 return false
	 }

	
						$("#SearchTargetPoint").hide();
					
		var center = ggle_map.getCenter();
        var maplevel = ggle_map.getZoom();
		var Location0
		var Location1
			//document.getElementById("StrLocation").innerHTML = center.toString();
			geocoder.geocode({'latLng' : center}, 
				  function(results, status) 
				  {
						  if (status == google.maps.GeocoderStatus.OK)  
						  {
							   if (results[0])
							   {
									
									
								document.getElementById("StrLocation").innerHTML=""
								document.getElementById("NNation").value=""
								if(maplevel < 4)
									{ //국가아이콘보임
									 $("#MOtSearchTap").hide();
									document.getElementById("DivLeftMenuSub_a1").style.height="566px"
									document.getElementById("DivLeftMenuSub_a2").style.height="544px"
									document.getElementById("DivLeftMenuSub_b1").style.height="566px"
									document.getElementById("DivLeftMenuSub_b2").style.height="544px"
									$("#DivLeftMenuSub_b1_Tab").hide();
									 Location1=""								
										   for(i=0;i< (results[0].address_components).length;i++)
											{
											
											    if(results[0].address_components[i].types=="country,political")
												{
													Location1=results[0].address_components[i].long_name 
												}										
													
											}
									
										document.getElementById("StrLocation").innerHTML="전체지도";
										$("#CCLocationTap").html("<div style='margin-top:3px;' id='CCLocationTap'><span style='font-weight:bold;' class='fontLarge2'>전체지도</span></div>")
										
										var ajaxurl = "IF_SearchListMapContinent.asp"		
										 $.post(ajaxurl, function(data) {
											if (data != "") {											
												$("#DivGetSearchMapContinent").html(data);
												 ggle_map.clearOverlays()
												initContinentMark()		
													
											}
										  })	
										  var ajaxurl = "IF_SearchListMapLeftInfo.asp";																						
											//window.open(ajaxurl )
											 $.post(ajaxurl, function(data) {
												if (data != "") {	
												    $("#DivGetSearchMapLandmark").html(data);
													$("#DivGetSearchMapHotelList").html(data);															
												}
											 })	
										
									}
									else if(maplevel > 3 && maplevel < 5)
									{ //국가아이콘보임
									  $("#MOtSearchTap").hide();
									document.getElementById("DivLeftMenuSub_a1").style.height="566px"
									document.getElementById("DivLeftMenuSub_a2").style.height="544px"
									document.getElementById("DivLeftMenuSub_b1").style.height="566px"
									document.getElementById("DivLeftMenuSub_b2").style.height="544px"
									$("#DivLeftMenuSub_b1_Tab").hide();
									 Location1=""								
										   for(i=0;i< (results[0].address_components).length;i++)
											{
											
											    if(results[0].address_components[i].types=="country,political")
												{
													Location1=results[0].address_components[i].long_name 
												}										
													
											}
										if(maplevel > 3 && maplevel < 5)
										{
										    document.getElementById("StrLocation").innerHTML=Location1;
											document.getElementById("NNation").value=Location1
											$("#CCLocationTap").html("<div style='margin-top:3px;' id='CCLocationTap'><span style='font-weight:bold;' class='fontLarge2'>"+Location1+"</span></div>")
										}
										else
										{
											document.getElementById("StrLocation").innerHTML="전체지도";
											$("#CCLocationTap").html("<div style='margin-top:3px;' id='CCLocationTap'><span style='font-weight:bold;' class='fontLarge2'>전체지도</span></div>")
										}
										
										
										var NNation=document.getElementById("NNation").value 	
										
										
										var ajaxurl = "IF_SearchListMapNation.asp?NNation="+escape(NNation);	
										
										 $.post(ajaxurl, function(data) {
											if (data != "") {											
												$("#DivGetSearchMapNation").html(data);
												 ggle_map.clearOverlays()
												initNationMark()													
											}
										  })
										 
										 
										 var ajaxurl = "IF_SearchListMapLeftInfo.asp";																						
											//window.open(ajaxurl )
											 $.post(ajaxurl, function(data) {
												if (data != "") {	
												    $("#DivGetSearchMapLandmark").html(data);
													$("#DivGetSearchMapHotelList").html(data);															
												}
											 })	
										
									}
									else if(maplevel > 4 && maplevel <= 12 )
									{
									  $("#MOtSearchTap").hide();
									
									
									document.getElementById("DivLeftMenuSub_a1").style.height="566px"
									document.getElementById("DivLeftMenuSub_a2").style.height="544px"
									document.getElementById("DivLeftMenuSub_b1").style.height="566px"
									document.getElementById("DivLeftMenuSub_b2").style.height="544px"
									$("#DivLeftMenuSub_b1_Tab").show();
								      Location0=""
									  Location1=""
										for(i=0;i< (results[0].address_components).length;i++)
											{
												
													if(results[0].address_components[i].types=="locality,political")
												{  
													Location0=results[0].address_components[i].long_name 
												}
											
												if(Location0) 
												{}else{
													if(results[0].address_components[i].types=="administrative_area_level_2,political")
												{  
													Location0=results[0].address_components[i].long_name 
												}
												}
													if(Location0) 
												{}else{
													if(results[0].address_components[i].types=="administrative_area_level_1,political")
												{  
													Location0=results[0].address_components[i].long_name 
												}
												}
												
											    if(results[0].address_components[i].types=="country,political")
												{
													Location1=results[0].address_components[i].long_name 
												}
																							
											}
									 	  if(Location0.trim()=="undefined" ||  Location0=="")
									      {
											  document.getElementById("StrLocation").innerHTML=Location1;
											  document.getElementById("NNation").value=Location1
											  $("#CCLocationTap").html("<div style='margin-top:3px;' id='CCLocationTap'><span style='font-weight:bold;' class='fontLarge2'>"+Location1+"</span></div>")
											  
											  
										  }else
										  {	 
										  
										  
										     var ArrLocation0=Location0.split(' ')
											
											 if(ArrLocation0.length > 1){
												Location0=ArrLocation0[0] 
												 }										 
									 		 document.getElementById("StrLocation").innerHTML=Location1+" > "+Location0;
											 document.getElementById("NNation").value=Location1
											
											 document.getElementById("NCity").value=Location0
											$("#CCLocationTap").html("<div style='margin-top:3px;' id='CCLocationTap'><span style='font-weight:bold;' class='fontLarge2'>"+Location1+"</span><span style='margin-left:5px; margin-right:5px;' class='fontLarge fontcolorYellow'>&gt;</span><span style='font-weight:bold;' class='fontLarge2'>"+Location0+"</span></div>")
										  }
										  
										  
										  	var NNation=document.getElementById("NNation").value 
											var ajaxurl = "IF_SearchListMapCity.asp?NNation="+escape(NNation);	
											//alert(ajaxurl)
											// window.open(ajaxurl )
											 $.post(ajaxurl, function(data) {
												if (data != "") {											
													$("#DivGetSearchMapCity").html(data);
													
													 ggle_map.clearOverlays()
													initCityMark()													
												}
											  })	
											 
											var NCity=document.getElementById("NCity").value 
											$("#DivGetSearchMapLandmark").html("");
											
											
											$("#DivGetSearchMapHotelList").html("");	
											var ajaxurl = "IF_SearchListMapHotelList.asp?NNation="+escape(NNation)+"&NCity="+escape(NCity)+"&MapLevel="+maplevel;	
																					
											//window.open(ajaxurl )
											 $.post(ajaxurl, function(data) {
												if (data != "") {	
													$("#DivGetSearchMapHotelList").html(data);															
												}
											 })	
											  var ajaxurl = "IF_SearchListMapLeftInfo.asp";																						
											//window.open(ajaxurl )
											 $.post(ajaxurl, function(data) {
												if (data != "") {	
												    $("#DivGetSearchMapLandmark").html(data);
																										
												}
											 })	
										
										
										 
									}
									else if(maplevel > 12 )
									{ 
									
									$("#MOtSearchTap").show();
									document.getElementById("DivLeftMenuSub_a1").style.height="615px"
									document.getElementById("DivLeftMenuSub_a2").style.height="593px"
									document.getElementById("DivLeftMenuSub_b1").style.height="615px"
									document.getElementById("DivLeftMenuSub_b2").style.height="488px"
									$("#DivLeftMenuSub_b1_Tab").show();
									
									
									  Location0=""
									  Location1=""
										for(i=0;i< (results[0].address_components).length;i++)
											{
												
													if(results[0].address_components[i].types=="locality,political")
													{  
														Location0=results[0].address_components[i].long_name 
													}
												
													if(Location0) 
													{}else{
														if(results[0].address_components[i].types=="administrative_area_level_2,political")
													{  
														Location0=results[0].address_components[i].long_name 
													}
													}
													
												
													if(results[0].address_components[i].types=="administrative_area_level_1,political")
													{  
														Location0_1=results[0].address_components[i].long_name 
														
														if(Location0_1=="도쿄" ){
															Location0=Location0_1															
															}else{
																
															  	if(Location0) 
																{}else{
																	if(results[0].address_components[i].types=="administrative_area_level_2,political")
																	{  
																		Location0=results[0].address_components[i].long_name 
																	}
												    			}
															
															}
													}
													
												
													
												
												
												
												
											    if(results[0].address_components[i].types=="country,political")
												{
													Location1=results[0].address_components[i].long_name 
												}
																							
											}
									 										 
									 	
										 document.getElementById("StrLocation").innerHTML=results[0].formatted_address; 
										// document.getElementById("StrLocation").innerHTML=results[0].formatted_address+" "+center.toString()+"";
										
										
									     document.getElementById("NNation").value=Location1	
										  
							  
										
									
										var ArrLocation0=Location0.split(' ')
											
										 if(ArrLocation0.length > 1){
											Location0=ArrLocation0[0] 
											 }
										
										 document.getElementById("NCity").value=Location0
										$("#CCLocationTap").html("<div style='margin-top:3px;' id='CCLocationTap'><span style='font-weight:bold;' class='fontLarge2'>"+Location1+"</span><span style='margin-left:5px; margin-right:5px;' class='fontLarge fontcolorYellow'>&gt;</span><span style='font-weight:bold;' class='fontLarge2'>"+Location0+"</span></div>")
										$("#CClocationTapbottom").html(center.toString())
										 
										 var Ncenter=center.toString()
										   Ncenter=Ncenter.replace('(','')
										   Ncenter=Ncenter.replace(')','')		
										   Ncenter=Ncenter.replace(' ','')	
										 
										var LatLongitudes=Ncenter.split(",")
										var NLatitude=LatLongitudes[0]									
										var NLongitude=LatLongitudes[1]
										 
										 
										 
										 
										    var ajaxurl = "IF_SearchListMapHotel.asp?Latitude="+NLatitude+"&Longitude="+NLongitude+"&MapLevel="+maplevel;											
										 	//window.open(ajaxurl )
											 $.post(ajaxurl, function(data) {
												if (data != "") {	
												   
													$("#DivGetSearchMapHotel").html(data);
													
													 ggle_map.clearOverlays()
													initHotelMark()													
												}
											  })
											 
											 
										 var NNation=document.getElementById("NNation").value 
										 var NCity=document.getElementById("NCity").value	
										 
										
										
											
										 var ajaxurl = "IF_SearchListMapLandmark.asp?NNation="+escape(NNation)+"&NCity="+escape(NCity)+"&MapLevel="+maplevel;	
																				
										 	//window.open(ajaxurl )
											 $.post(ajaxurl, function(data) {
												if (data != "") {	
												   
												   
													$("#DivGetSearchMapLandmark").html(data);
													
													 //ggle_map.clearOverlays()
													initLandMark()													
												}
											  })
											 
										$("#DivGetSearchMapHotelList").html("");	
											var ajaxurl = "IF_SearchListMapHotelList.asp?NNation="+escape(NNation)+"&NCity="+escape(NCity)+"&MapLevel="+maplevel;	
																					
											//window.open(ajaxurl )
											 $.post(ajaxurl, function(data) {
												if (data != "") {	
													$("#DivGetSearchMapHotelList").html(data);															
												}
											 })	 	
										 
						
									}
									
						
						     }
							 else
							 {
							  
							  document.getElementById("StrLocation").innerHTML=""
							  document.getElementById("NNation").value="" 
							  document.getElementById("NCity").value=""
							  $("#TNNation").html("")
							  $("#TNCity").html("")
							 }
				          }
						  else
						  {
							 if(maplevel < 4)
							 {
								
							    document.getElementById("StrLocation").innerHTML="전체지도"
								document.getElementById("NNation").value=""
								 document.getElementById("NCity").value=""
							  $("#CCLocationTap").html("<div style='margin-top:3px;' id='CCLocationTap'><span style='font-weight:bold;' class='fontLarge2'>전체지도</span></div>")
							   var ajaxurl = "IF_SearchListMapLeftInfo.asp";																						
											//window.open(ajaxurl )
											 $.post(ajaxurl, function(data) {
												if (data != "") {	
												    $("#DivGetSearchMapLandmark").html(data);
													$("#DivGetSearchMapHotelList").html(data);															
												}
											 })	
							 }
							 else
							 {
								
								document.getElementById("StrLocation").innerHTML="" 
								document.getElementById("NNation").value=""
								 document.getElementById("NCity").value=""
							  $("#CCLocationTap").html("<div style='margin-top:3px;' id='CCLocationTap'></div>")
							   var ajaxurl = "IF_SearchListMapLeftInfo.asp";																						
											//window.open(ajaxurl )
											 $.post(ajaxurl, function(data) {
												if (data != "") {	
												    $("#DivGetSearchMapLandmark").html(data);
													$("#DivGetSearchMapHotelList").html(data);															
												}
											 })	
							 }
						  }
			      });
			
	
			
	}
	);
  
	
	
	ggle_map.setCenter(new GLatLng(lat, lng), parseInt(zoomlevel,10));

	
	
	
      // bind a search control to the map, suppress result list
   
 	
  }
	}catch(e)
	{
		ggle_map=null;
	}
	
}
//GSearch.setOnLoadCallback(ggle_mapload);
function ggle_displayMap(lat,lng) {
/*  if(Hotel[index].geoCode1 == 0 && Hotel[index].geoCode2 == 0) {
    alert("죄송합니다. 해당 호텔의 정확한 위치 정보가 존재하지 않습니다.");
    return;
  }*/
   if(ggle_map==null)
   	return;
   if(lat!=null && lng!=null && lat!="" && lng!="")
   {
	var image= "/images/ggle_icons/hotel00_C.png"
    var tIcon = new GIcon();	
    tIcon.image = image;    
    var markerOptions = { icon:tIcon };   
	    
	  var ggle_point = new GLatLng(lat, lng);
	  ggle_map.setCenter(ggle_point, ggle_map.getZoom());
	  ggle_map.addOverlay(new GMarker(ggle_map.getCenter(),markerOptions));
   }
   
   
 
//     map.setCenter(new GLatLng(Hotel[index].geoCode1, Hotel[index].geoCode2), 15);
//    markers[index].openInfoWindowHtml(getMarkerHtml(Hotel[index]));
  //window.setTimeout(showCircle, 3000);
}

function ggle_CreateGSize(width, height)
{
	if(ggle_map==null)
   		return;
	return new GSize(width, height);
}
function ggle_CreateGPoint(x, y)
{
	if(ggle_map==null)
   		return;
	return new GPoint(x, y);
}
function ggle_CreateGLatLng(Lat, Lng)
{

	if(ggle_map==null)
   		return;
	return new GLatLng(Lat,	Lng);
}
function ggle_CreateGLatLng2(Lat, Lng)
{


	if(ggle_map==null)
   		return;
		
	return new GLatLng(Lat,	Lng);
}

function ggle_UpdateMarker(xtitle, nMarker, latlng, image, imgsize, infoHTML)
{
	if(ggle_map==null)
   		return null;
	if(xtitle!=null)
		nMarker.$.title=xtitle;
	if(latlng!=null)
		nMarker.setLatLng(latlng);
	if(image!="")
		nMarker.setImage(image);
    if(infoHTML!="")
    {
		GEvent.clearListeners(nMarker, "click");
		GEvent.addListener(nMarker, "click", 
		function() {   
		ggle_map.setCenter(latlng);
		nMarker.openInfoWindowHtml(infoHTML);  
		}
		);
    }
    return nMarker;
}
var ggle_box=null;
function ggle_makeBox(tLat, tLng, tLevel, bMoveCenter)
{
	if(ggle_map==null)
   		return;
	//var polyOptions = {geodesic:true};
	tLat=parseFloat(tLat);
	tLng=parseFloat(tLng);
	if(ggle_box!=null)
	{
		ggle_map.removeOverlay(ggle_box);
		ggle_box=null;
	}
	var latOffset = 0;
    var lonOffset = 0;
	switch(parseInt(tLevel))
	{
	case 1:
		latOffset=0.020;//0.035;
		lonOffset=0.030;//0.05
		
		break;
	}
	if(latOffset!=0 && lonOffset!=0)
	{
		var polygon = new GPolygon([
            new GLatLng(tLat-latOffset, tLng-lonOffset),  
			new GLatLng(tLat+latOffset, tLng-lonOffset),
			new GLatLng(tLat+latOffset, tLng+lonOffset),
			new GLatLng(tLat-latOffset, tLng+lonOffset),
			new GLatLng(tLat-latOffset, tLng-lonOffset)
		  ], "#777777", 1, 0.9, "#000000", 0.1);
		ggle_box=polygon;
		ggle_map.addOverlay(ggle_box);
	}
	
	if(bMoveCenter)
		 ggle_map.setCenter(new GLatLng(tLat, tLng), ggle_map.getZoom());
	
}
function ggle_removeBox()
{
	if(ggle_map==null)
   		return;
	if(ggle_box!=null)
	{
		ggle_map.removeOverlay(ggle_box);
		ggle_box=null;
	}
}
function ggle_removeHoteLHList()
{
	//ggle_map.clearOverlays();//전체다 지우기
	ggle_map.closeInfoWindow() //인포창지우기
	//alert(HoteListCnt)
	for(var i=1;i<HoteListCnt;i++)
		{		
			if(i<10){i="0"+i}
			
		  ggle_map.removeOverlay(HotelMarkList[i].marker)   //마크업지우기	
		
		}
	
	
	}
function ggle_CreateMarker_Landmark(xtitle, latlng, image, shadow, imgsize, shadowsize, anchoroffset, infoanchoroffset, funconclick, infoHTML)
{

	if(ggle_map==null)
   		return null;
	var tIcon = new GIcon();
	
    tIcon.image = image;
    tIcon.shadow = shadow;
    tIcon.iconSize = imgsize;
    tIcon.shadowSize = shadowsize;
    tIcon.iconAnchor = anchoroffset;
    tIcon.infoWindowAnchor = infoanchoroffset;
    
    var markerOptions = { icon:tIcon , title:xtitle};
    // Set up our GMarkerOptions object
    var nMarker=new GMarker(latlng, markerOptions);
    if(funconclick!="")
    {
		GEvent.addListener(nMarker, "dblclick", 
		function() {    
		//eval(funconclick);
		}
		);
    }
    if(infoHTML!="")
    {
		GEvent.addListener(nMarker, "click", 
		function() {    

			nMarker.openInfoWindowHtml(infoHTML);
			eval(funconclick);
		}
		);
    }
    else
    {
		GEvent.addListener(nMarker, "click", 
		function() {    
			eval(funconclick);
		}
		);
    }
    return nMarker;
}	

function ggle_CreateMarker_Continent(xtitle, latlng, image, shadow, imgsize, shadowsize, anchoroffset, infoanchoroffset, funconclick, infoHTML)
{


	if(ggle_map==null)
   		return null;
	var tIcon = new GIcon();
	
    tIcon.image = image;
    tIcon.shadow = shadow;
    tIcon.iconSize = imgsize;
    tIcon.shadowSize = shadowsize;
    tIcon.iconAnchor = anchoroffset;
    tIcon.infoWindowAnchor = infoanchoroffset;
    
    var markerOptions = { icon:tIcon , title:xtitle};
    // Set up our GMarkerOptions object
    var nMarker=new GMarker(latlng, markerOptions);
    if(funconclick!="")
    {
		GEvent.addListener(nMarker, "dblclick", 
		function() {    
		//eval(funconclick);
		}
		);
    }
    if(infoHTML!="")
    {
		GEvent.addListener(nMarker, "click", 
		function() {    
			nMarker.openInfoWindowHtml(infoHTML);
			eval(funconclick);
		}
		);
    }
    else
    {
		GEvent.addListener(nMarker, "click", 
		function() {    
			eval(funconclick);
		}
		);
    }
	

	
    return nMarker;
}	
function ggle_CreateMarker_Nation(xtitle, latlng, image, shadow, imgsize, shadowsize, anchoroffset, infoanchoroffset, funconclick, infoHTML)
{

	if(ggle_map==null)
   		return null;
	var tIcon = new GIcon();
	
    tIcon.image = image;
    tIcon.shadow = shadow;
    tIcon.iconSize = imgsize;
    tIcon.shadowSize = shadowsize;
    tIcon.iconAnchor = anchoroffset;
    tIcon.infoWindowAnchor = infoanchoroffset;
    
    var markerOptions = { icon:tIcon , title:xtitle};
    // Set up our GMarkerOptions object
    var nMarker=new GMarker(latlng, markerOptions);
    if(funconclick!="")
    {
		GEvent.addListener(nMarker, "dblclick", 
		function() {    
		//eval(funconclick);
		}
		);
    }
    if(infoHTML!="")
    {
		GEvent.addListener(nMarker, "click", 
		function() {    
			nMarker.openInfoWindowHtml(infoHTML);
			eval(funconclick);
		}
		);
    }
    else
    {
		GEvent.addListener(nMarker, "click", 
		function() {    
			eval(funconclick);
		}
		);
    }
	

	
    return nMarker;
}
function ggle_CreateMarker_City(xtitle, latlng, image, shadow, imgsize, shadowsize, anchoroffset, infoanchoroffset, funconclick, infoHTML)
{

	if(ggle_map==null)
   		return null;
	var tIcon = new GIcon();
	
    tIcon.image = image;
    tIcon.shadow = shadow;
    tIcon.iconSize = imgsize;
    tIcon.shadowSize = shadowsize;
    tIcon.iconAnchor = anchoroffset;
    tIcon.infoWindowAnchor = infoanchoroffset;
    
    var markerOptions = { icon:tIcon , title:xtitle};
    // Set up our GMarkerOptions object
    var nMarker=new GMarker(latlng, markerOptions);
    if(funconclick!="")
    {
		GEvent.addListener(nMarker, "dblclick", 
		function() {    
		//eval(funconclick);
		}
		);
    }
    if(infoHTML!="")
    {
		GEvent.addListener(nMarker, "click", 
		function() {    
			nMarker.openInfoWindowHtml(infoHTML);
			eval(funconclick);
		}
		);
    }
    else
    {
		GEvent.addListener(nMarker, "click", 
		function() {    
			eval(funconclick);
		}
		);
    }
	

	
    return nMarker;
}

function ggle_CreateMarker_Hotel(xtitle, latlng, image, shadow, imgsize, shadowsize, anchoroffset, infoanchoroffset, funconclick, infoHTML)
{

	if(ggle_map==null)
   		return null;
	var tIcon = new GIcon();
	
    tIcon.image = image;
    tIcon.shadow = shadow;
    tIcon.iconSize = imgsize;
    tIcon.shadowSize = shadowsize;
    tIcon.iconAnchor = anchoroffset;
    tIcon.infoWindowAnchor = infoanchoroffset;
    
    var markerOptions = { icon:tIcon , title:xtitle};
    // Set up our GMarkerOptions object
    var nMarker=new GMarker(latlng, markerOptions);
    if(funconclick!="")
    {
		GEvent.addListener(nMarker, "dblclick", 
		function() {    
		//eval(funconclick);
		}
		);
    }
    if(infoHTML!="")
    {
		GEvent.addListener(nMarker, "click", 
		function() { 
		$("#IsMarkerClick").val("Y")
			//nMarker.openInfoWindowHtml(infoHTML);
			eval(funconclick);

		}
		);
    }
    else
    {
		GEvent.addListener(nMarker, "click", 
		function() {    
			eval(funconclick);
		}
		);
    }
	

	
    return nMarker;
}

function ggle_CreateMarkerNormal(latlng)
{
	if(ggle_map==null)
   		return null;
    var nMarker=new GMarker(latlng);
  
    return nMarker;
}