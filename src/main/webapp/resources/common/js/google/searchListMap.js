function OnLoadDocument()
{

    
    //onMapLoad();
  // GoHotel();
}


function onMapLoad()
{

	ggle_mapload("locationmap", "23.563987128451163", "25.400390625", 2,	false, true);

	

initContinentMark();
	
}
	
var ContinentMarkList = null;
var LListInfo = null;
var PListInfo = null;
function initContinentMark()
{

	if(ContinentMarkList!=null)
		return;
	ContinentMarkList=new Array();	

	
	var txindex;
	


var tindex=SetContinentMark("1", "대한민국",  "35.9078", "127.767");



var tindex=SetContinentMark("2", "일본",  "36.2048", "138.253");



var tindex=SetContinentMark("3", "중국과 이웃",  "35.8617", "104.195");



var tindex=SetContinentMark("4", "동남아",  "7.01367", "117.07");



var tindex=SetContinentMark("5", "인도와 이웃",  "27.0591", "75.2344");



var tindex=SetContinentMark("6", "유럽",  "53.3200862051948", "13.20555");



var tindex=SetContinentMark("7", "러시아와 이웃",  "61.2702", "75.9375");



var tindex=SetContinentMark("8", "중동",  "27.9944", "43.2422");



var tindex=SetContinentMark("9", "북아메리카",  "45.4865", "-93.4497");



var tindex=SetContinentMark("10", "오세아니아",  "-26.7456", "148.359");



var tindex=SetContinentMark("11", "라틴아메리카",  "-4.21494", "-65.3906");



var tindex=SetContinentMark("12", "아프리카",  "0.213671", "16.9849");



var tindex=SetContinentMark("13", "남극대륙",  "-75.251", "-0.071389");

                                            


	binitLM=true;

}

function SetContinentMark(Idx, NameKR,  tLat, tLng)
{

	var addindex=0;
	try{
			var LatLng=ggle_CreateGLatLng(tLat, tLng);
			var imgSize=ggle_CreateGSize(19, 21);
			var shadowSize=ggle_CreateGSize(32, 24);
			var anpnt=ggle_CreateGPoint(10, 24);
			var infoanpnt=ggle_CreateGPoint(14, 10);
			var img="/images/ggle_icons/Icon_group.png";
		
		
			addindex=ContinentMarkList.length;
			var inHTML="<b>"+NameKR+"</b>";
		
		
			img="http://www.hoteljava.co.kr"+img;

			var tmarker=ggle_CreateMarker_Continent(NameKR,
				LatLng
				,img
				,"http://www.hoteljava.co.kr/images/ggle_icons/Icon_shadow.png"
				,imgSize
				,shadowSize
				,anpnt
				,infoanpnt
				,"onclickContinentMark("+addindex+");"
				,""
			);
			
			var tobj=new Object();
			
			tobj.Lldx=Idx
			tobj.Lat=tLat;
			tobj.Lng=tLng;
			tobj.marker=tmarker;
			tobj.isSelected=false;
			tobj.inHTMLHeader=inHTML;
			tobj.inHTMLTail="";
			
			ContinentMarkList[addindex]=tobj;
		
				try{	
					ggle_map.addOverlay(tmarker);
					tmarker.setLatLng(LatLng);
				}catch(e)
				{
				}
				
			
	}
	catch(e)
	{
	}
	return addindex;
	
}



// 랜드 마크 클릭 시 처리
function onclickContinentMark(idx)
{


	var ajaxurl = "IF_SearchListMapNation.asp?ContinentMarkIndex="+ContinentMarkList[idx].Lldx+"&Latitude="+ContinentMarkList[idx].Lat+"&Longitude="+ContinentMarkList[idx].Lng;
	
		//alert(ajaxurl)
		//location.href=ajaxurl;
		$.post(ajaxurl, function(data) {
			if (data != "") {
			//alert(data)
			  ggle_map.clearOverlays()
			   ggle_map.panTo(new GLatLng(ContinentMarkList[idx].Lat, ContinentMarkList[idx].Lng))		
			   ggle_map.setCenter(new GLatLng(ContinentMarkList[idx].Lat, ContinentMarkList[idx].Lng))
			  
			 // alert(ggle_map.getZoom())
			 
			   setTimeout(function() { ggle_map.setZoom(4) }, 1000);
			   ggle_map.setZoom(4)
			  // for(i=ggle_map.getZoom();i< 5;i++)
			  // {
			   // setTimeout(function() { ggle_map.setZoom(i) }, 500);
			 //  }
			   
			  $("#DivGetSearchMapNation").html(data);
			   initNationMark()
			 
			   
				//$("#DivGetCategoryInfoSub").html(data);		
				
			}
		});
		
}
