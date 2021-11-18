<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/commTagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:og="http://ogp.me/ns#" xml:lang="ko" lang="ko">
<title>	호텔예약 호텔자바! 세상의 모든 호텔을 잡아라</title>

<link rel="stylesheet" href="http://fonts.googleapis.com/earlyaccess/nanumgothic.css" />
<link rel="shortcut icon" href="http://www.hoteljava.co.kr/favicon.ico" />
<link rel="apple-touch-icon-precomposed" href="/icon.png" /><!-- 아이폰 바로가기 아이콘-->
<link href="http://www.hoteljava.co.kr/Css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://www.hoteljava.co.kr/common/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="/common/js/google/searchListMap.js"></script>


<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta name="keywords" content="해외호텔예약가격비교, 해외호텔가격비교, 호텔자바, 일본호텔예약, 오사카호텔예약, 도쿄호텔예약, 후쿠오카호텔예약, 파리호텔예약, 로마호텔예약, 인터라켄호텔예약, 하와이호텔예약, 홍콩호텔예약, 마카오호텔예약, 태국호텔예약, 방콕호텔예약, 파타야호텔예약" />

	<!--META HTTP-EQUIV="Page-exit" CONTENT="BlendTrans(Duration=0.1)">
    <!--META HTTP-EQUIV="Page-Enter" CONTENT="BlendTrans(Duration=0.1)"-->
 
	<script type="text/javascript" language="javascript" src="http://www.hoteljava.co.kr/Common/js/Select.js"></script>
	<script type="text/javascript" language="javascript" src="http://www.hoteljava.co.kr/Common/js/Public.js"></script>
	<script type="text/javascript" language="javascript" src="http://www.hoteljava.co.kr/common/js/CoUtil.js"></script>
	<script type="text/javascript" language="javascript" src="http://www.hoteljava.co.kr/common/js/nineCommon.js"></script>
	<script type="text/javascript" language="javascript" src="http://www.hoteljava.co.kr/common/js/nineFloatLayerControl.js"></script>
	<script type="text/javascript" language="javascript" src="http://www.hoteljava.co.kr/common/js/nineAjax.js"></script>
	<script type="text/javascript" language="javascript" src="http://www.hoteljava.co.kr/common/js/GlobalMenu.asp"></script>

	<script type="text/javascript" language="javascript" src="http://www.hoteljava.co.kr/common/js/nineHJ_SearchCore.asp"></script>
	
	<script>
	    var ajaxCore_tool = new nineAJAX("ajaxCore_tool");
	    function SaveMyHotel(pVal) {
	        ajaxCore_tool.ModuleReset();
	        var turl = "http://www.hoteljava.co.kr/common/AJAXLib/AJAX_Client_SetMyHotel.asp?UI=Y&HIndex=" + pVal;

	        var retval = ajaxCore_tool.SendXmlhttp(turl, 1, "SaveMyHotelComplete", null);
	        //AjaxCore.SendXmlhttp(turl, 1, "", null);
	    }

	    function SaveMyHotelComplete(tsuccess, retval, terrorcode, tcustparam) {
	        try {
	            document.getElementById("ltc02").innerHTML = retval;
	        } catch (e) {
	        }
	        alert("관심호텔로 저장되었습니다.");
	    }
	</script>
	
	<div id="Curtain" style="position: absolute;display: none; z-index: 2000; top: 0; left: 0; width: 100%;min-width:1130px; height: 100%; background-color: #000000;filter: alpha(opacity=70); -khtml-opacity: 0.7; -moz-opacity:0.7; opacity: 0.7;">	</div>
	<!-- 팝업레이어 띄우는곳-->
    <script>
    function GoTabLayer(value){
	
	document.IFPOPUPLAYER.GoDetail(value);

	
	}
    
    </script>
	
	<div id="POPUPLAYER"  name="POPUPLAYER" style="position: absolute; display: none; z-index:10000; overflow:hidden"  >	
				<div style=" position:relative; height:50px;">	
				
					
				 	<div style="position:absolute; width:100%; " id="POPUPTAPBUMO">
					<div id="POPUPTAP">
						<div id="DivGoTabLayer0" style=" float:left;"  class="BookingBoxtabmenuOff" onClick="javascript:GoTabLayer(0);">호텔정보</div>
						<div id="DivGoTabLayer3" style=" float:left;"  class="BookingBoxtabmenuOff" onClick="javascript:GoTabLayer(3);">호텔사진더보기</div>
						<div id="DivGoTabLayer4" style=" float:left;"  class="BookingBoxtabmenuOff" onClick="javascript:GoTabLayer(4);">위치&amp;지도</div>
						<div id="DivGoTabLayer6" style=" float:left;"  class="BookingBoxtabmenuOff" onClick="javascript:GoTabLayer(6);">한줄평가</div>
						<div id="DivGoTabLayer5" style=" float:left;"  class="BookingBoxtabmenuOff" onClick="javascript:GoTabLayer(5);">고객리뷰</div>
                      </div>  
                        
                        
						<div  id="POPUPCLOSE"  name="POPUPCLOSE"   style=" float:right;padding-right:2px;">				
						<div style="  width:20px; padding-left:5px;  height:30px; line-height:30px; z-index:10001;  background-color:#448cca; color:#FFFFFF; font-size:22px; cursor:pointer;" onClick="javascript:ClosePopUpLayer();return false;">X</div>		
					</div>	
			    	</div>
					
				</div>
		
		
		
			<div id="POPUPCURTAIN"    name="POPUPCURTAIN"  style="position:absolute;width:100%;height:100%; ">					
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr><td align="center" valign="middle"   style="padding-bottom:150px">  
				<div style=" width:200px;">
					<div><img src="http://www.hoteljava.co.kr/images/contents/java_ci.png" width="129" height="101" /></div>
					<div style=" margin-top:10px;"><img src="http://www.hoteljava.co.kr/images/contents/ico_loading.gif" width="131" height="11" /></div>
		        </div>	</td></tr>
			</table>	
			</div>	
			<div id="POPUPLAYERCONTENTS" >		    
			<div id="IFPOPUPLAYERBOX"  style="width:1120px; float:left;" class="BookingBox" ><iframe src="" id="IFPOPUPLAYER"  name="IFPOPUPLAYER" style=" width:0px;height:0px;" frameborder="0" allowTransparency="true" ></iframe></div>
			</div>
	
	
	</div>
	
	
	
	
	
	
	
	
	<div id="LOADINGLAYER"  name="POPUPLAYER" style="position: absolute; display: none; z-index:10000; overflow:hidden"  >	
		
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr><td align="center"><img src="http://www.hoteljava.co.kr/images/contents/ico_send_data.gif"  /></td></tr>
			<tr><td style="padding: 5px; text-align: center; font-weight:bold;  line-height: 1.5em" id="LOADINGLAYERTEXT"></td></tr>			
		    </table>
		
	
	</div>

<div id="BIGLOADINGLAYER"  name="POPUPLAYER"  style="width:100%;min-width:1130px;height:280px;position: absolute; display: none; z-index:10000; text-align:center">
	<div style=" border:solid 10px #448cca ; background-color:#FFFFFF;width:850px; height:280px;-webkit-border-radius: 140px;   -moz-border-radius: 140px; margin:auto;  border-radius: 140px; overflow:hidden;"   >		
	
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td  align="center" valign="middle" >
				<div style="float:left; width:200px; padding-left:100px; padding-top:80px;">
			<div><img src="http://www.hoteljava.co.kr/images/contents/java_ci.png" width="129" height="101" /></div>
			<div style=" margin-top:10px;"><img src="http://www.hoteljava.co.kr/images/contents/ico_loading.gif" width="131" height="11" /></div>
		</div>
		<div style="float:left; width:450px; margin-top:40px;" class="fontLarge">
			  <div id="DivOpenBigLoadingText"><div  style="height:40px"></div></div>
			<div style="margin-top:20px; font-weight:bold;">호텔자바에서 가장 저렴한 가격을 비교 검색중입니다. <br />지역에 따라 최대 2~3분 정도 소요될 수 있으니 잠시만 기다려 주세요.</div>
			<div style=" margin-top:30px; font-size:11px; color:#b9b9b9;">Shin JaeYeol, Kim TaeWoong, Kim YongEock, Lee HyeJin, Yoo HyeJin <br />Thanks To. Ryu YangHyun, Kim HyeongRyeol, Ham JuRyung, Heo JiYoon</div>
		</div>
		<div style=" clear: both;"></div>
				
				</td>
			</tr>
        </table>
		
	</div>
</div>	
	
	<div id="ANILAYER" style="position: absolute; display: none; z-index: 2200; top: 0;	left: 0; width: 10; height: 10; background-color:#F5F5F5;border-style:solid;border-color:#54cedb;border-width:5px;">
		검색중입니다.
	</div>
	<div id="INDICATOR" style="position: absolute; display: none; z-index: 2300; width: 267px;
		height: 170px; border: 2px solid #55cedc; background-image: url(http://www.hoteljava.co.kr/images/loading_back.gif);
		text-align: center; padding-top: 35px">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr><td align="center">검색중입니다.</td></tr>
			<tr><td style="padding: 5px; text-align: center; line-height: 1.5em" id="Td1"><font style="color:#126e5b;font-weight:bold;">**처리 진행 중 입니다.**</font><br/>
<br/><font style="color:#126e5b;">결과가 나올 때까지 브라우저를 닫지 마시고 기다려주세요!</font></td></tr>
		</table>
	</div>
	
</head>

<style type="text/css">
      @import url("http://www.google.com/uds/css/gsearch.css");
      @import url("http://www.google.com/uds/solutions/localsearch/gmlocalsearch.css");
      }
</style>

<!--script type="text/javascript" src="http://www.google.com/jsapi?key=ABQIAAAAO7-pwShxfZRrz9Pndq3-VhT0uXCJcD3jiM4q6FHIh1MhbyurIxQJFLHVy_s8GzDMDSs2ErYYm73gRA"></script-->

<script src="/common/js/google/gglemod_stat_temp.js" type="text/javascript"></script>
<script src="http://maps.google.com/maps?file=api&v=3&key=ABQIAAAAO7-pwShxfZRrz9Pndq3-VhT0uXCJcD3jiM4q6FHIh1MhbyurIxQJFLHVy_s8GzDMDSs2ErYYm73gRA&hl=ko" type="text/javascript"></script>

<script src="/common/js/google/extlargemapcontrol.js" type="text/javascript"></script>

<script type="text/javascript" src="/common/js/google/mapcontrol_all_hotel_list.js"></script>


<!-- 탑 부분 S -->

 <script type="text/javascript">

  var isMobile = {
    Android: function() {
      return navigator.userAgent.match(/Android/i);
    },
    BlackBerry: function() {
      return navigator.userAgent.match(/BlackBerry/i);
    },
    iOS: function() {
      return navigator.userAgent.match(/iPhone|iPod/i);
    },
    Opera: function() {
      return navigator.userAgent.match(/Opera Mini/i);
    },
    Windows: function() {
      return navigator.userAgent.match(/IEMobile/i);
    },
    any: function() {
      return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
    }
  };


function goMobileOrder(){
	 if( isMobile.any() )
	 {	
		 document.location.href='http://m.hoteljava.co.kr/search/HotelListMap.asp'		
	 }				  
 }
				
				  </script>

<script>
goMobileOrder();
</script>

<div style="clear:both;"></div>
<div>
    <div class="Inner">
		
		
		<div style=" float:left; margin-top:13px; margin-left:5px; text-align:center; cursor: pointer;" onClick="javascript:location.href='/'">
			<img src="http://www.hoteljava.co.kr/images/contents/hoteljava_ci.png" height="32" />
		</div>
        

	    <div style=" float:right;">
		
			<div style="float:right;">
            	<button type="button"  class="buttonGlobalmenu"  style="height:34px; font-weight:600;" onClick="javascript:location.href='http://www.hoteljava.co.kr/introduction/why.asp';return false;"><span class="fontcolorRed">왜!</span>호텔자바인가</button>
                <span style="color:#e6e6e6; margin-left:10px; margin-right:10px;"> | </span>
			   	<button type="button"  class="buttonGlobalmenu"  style="height:34px;" onClick="javascript:location.href='http://www.hoteljava.co.kr/Member/LoginForm_member.asp';return false;">회원로그인</button>
                <button type="button"  class="buttonGlobalmenu"  style="height:34px;" onClick="javascript:location.href='http://www.hoteljava.co.kr/member/LoginForm_Guest.asp';return false;">비회원로그인</button>
				<button type="button" class="buttonGlobalmenu" style="height:34px;" onClick="javascript:gotoMenu('000002');return false;">회원가입</button>
				<button type="button" class="buttonGlobalmenu" style="height:34px;" onClick="javascript:gotoMenu('MYPG02');return false;"><span style="font-weight:bold;">마이페이지</span>/예약확인</button>
			</div>
			
			
			 <div style="clear:both;"></div>
			 <script>
			 function OpenCloseGongiSub(type){
			
				var ckDivGongiSubAll_seqarr = $('div[id="DivGongiSub"]'); //input name cksub   
					$(ckDivGongiSubAll_seqarr).each(function(i){			
								if(type=="1")
								{
								$(ckDivGongiSubAll_seqarr[i]).attr({ style:"display:" })
								}else{
								$(ckDivGongiSubAll_seqarr[i]).attr({ style:"display:none" })
								}						
						  });
				
				}
				function GoRead1(NoticeNo)
				{
			
					var f = document.frm;
					if(NoticeNo != ""){
					f.NoticeNo.value=NoticeNo;
					f.action = "http://www.hoteljava.co.kr/Javacafe/NoticeView.asp";
					}
					f.submit();
				}
				function GoRead2(PressNo)
				{
					var f = document.frm;   
					if(PressNo != ""){
					f.PressNo.value=PressNo;
					f.action = "http://www.hoteljava.co.kr/Javacafe/PressView.asp";
					}
					f.submit();
				}
				function GoRead3(InfoNo)
				{
					var f = document.frm;   
					if(InfoNo != ""){
					f.InfoNo.value=InfoNo;
					f.action = "http://www.hoteljava.co.kr/Javacafe/InfoView.asp";
					}
					f.submit();
				}
				function GoRead4(NewsNo)
				{
					var f = document.frm;   
					if(NewsNo != ""){
					f.NewsNo.value=NewsNo;
					f.action = "http://www.hoteljava.co.kr/Javacafe/NewsView.asp";
					}
					f.submit();
					
					
																					
				}
			 </script>
			 <div style=" float:right;">
			 
			<div style=" margin-bottom:10px; margin-right:10px;">
			 	<a href="http://www.hoteljava.co.kr/member/regi_step01.asp" target="_top">호텔자바 회원 가입시 혜택추가!</a>
			</div>
			 
			</div>
			
		</div>
		

    </div>
</div>

<form name="frm" id="frm" method="get" action="">
			<input type="hidden" name="NoticeNo" id="NoticeNo" />
			<input type="hidden" name="PressNo" id="PressNo" />
			<input type="hidden" name="InfoNo" id="InfoNo" />
			<input type="hidden" name="NewsNo" id="NewsNo" />
</form>	
<!-- 탑 부분 E -->
<!-- 탑메뉴 S -->
<script type="text/javascript">
function SearchHotelInTop()
{
    var f = document.TopHotelSearchForm;
    
    if(f.TopSWord.value.trim()=="" || f.TopSWord.value.trim()=="호텔명으로 검색하기")
    {
        alert("검색어를 입력하세요.");
        f.TopSWord.focus();
        return;
    }
    f.action = "/Search/ThemeHotelList.asp";
    f.method="get";
    f.submit();
}
function onFocusTopSearch(obj, isblur)
{
	if(!isblur)
	{
		if(obj.value.trim()=="호텔명으로 검색하기")
		{
			obj.value="";
		}
	}
	else
	{
		if(obj.value.trim()=="")
		{
			obj.value="호텔명으로 검색하기";
		}
	}
}


function disableEnterKeyTop(e)
{
var key;

if(window.event)
key = window.event.keyCode; //IE
else
key = e.which; //firefox
//alert(key)
if(key == 13)
{
	//alert(key)
SearchHotelInTop();

}
else
return true;
}


var k_pos = -1;

function KeywordMapping(value){

   if(window.event.keyCode == 40){ //down 일때
   
	   if(document.getElementById("dk").children.length < (k_pos+2)) return;
	   k_pos++;
	   choiceOk();
  }else if(window.event.keyCode == 38){ //up 일때
	   if((k_pos-1) < 0) return;
	   k_pos--;
	   choiceOk();
  }else{



	var ajaxurl = "http://www.hoteljava.co.kr/common/AJAXLib/AJAX_KeyWordMapping.asp?SWord="+value;	
	//alert(ajaxurl)
	//location.href=ajaxurl
		$.post(ajaxurl, function(data) {
			if (data != "") {
		
			$("#div_KeywordMapping").html(data);		
			k_pos = -1;			
			}	
		});
		
   }

}
function choiceOk(){
	   var item = document.getElementById("dk");

	   for(var idx = 0; idx < item.children.length; idx++){
		   
	   	   if(idx == k_pos && !undefined){
	   	   	   item.children[idx].style.backgroundColor='#F5F5F5';
	   	   	  document.getElementById("TopSWord").value = item.children[idx].innerText;
	   	   }else{
	   	   	   item.children[idx].style.backgroundColor='#FFFFFF';
	   	   }
	   }
	   
}
</script> 
<div style="clear:both;"></div>
<div id="topmenuLine">
    <div class="Inner">
       <div>
	   		<div style="float:left; cursor: pointer;" class="buttonTopmenu" onClick="javascript:location.href='http://www.hoteljava.co.kr/'"><img src="http://www.hoteljava.co.kr/images/contents/ico_home.png" height="20" align="absmiddle" /> 홈/호텔검색</div>
			<div style="float:left; cursor: pointer;" class="buttonTopmenu" onClick="javascript:location.href='http://www.hoteljava.co.kr/search/HotelListMap.asp'"><img src="http://www.hoteljava.co.kr/images/contents/ico_map.png" height="22" align="absmiddle" /> 지도로 호텔찾기</div>
			<div style="float:left; cursor: pointer;" class="buttonTopmenu" onClick="javascript:location.href='http://www.hoteljava.co.kr/search/ThemeHotel.asp?PageType=0'"><img src="http://www.hoteljava.co.kr/images/contents/ico_searchmenu.png" height="22" align="absmiddle" /> 호텔명으로 검색</div>
            <div style="float:left; cursor: pointer;" class="buttonTopmenu" onClick="javascript:location.href='http://www.hoteljava.co.kr/RentCar/JP/'"><img src="http://www.hoteljava.co.kr/images/contents/ico_rentacar.png" height="17" align="absmiddle" /> 일본렌트카</div>
			<div style="float:left; cursor: pointer;" class="buttonTopmenu" onClick="javascript:location.href='http://www.hoteljava.co.kr/Coordinator/CoordiReview/CoordiReviewList.asp'"><img src="http://www.hoteljava.co.kr/images/contents/ico_camera.png" height="18" align="absmiddle" /> 고객리뷰</div>
			<div style="float:left; cursor: pointer;" class="buttonTopmenu" onClick="javascript:location.href='http://www.hoteljava.co.kr/Center/FAQ/FAQList.asp'"><img src="http://www.hoteljava.co.kr/images/contents/ico_cscenter.png" height="22" align="absmiddle" /> 고객센터</div>
			<!--div style="float:left; cursor: pointer;" class="buttonTopmenu" onClick="javascript:location.href='/event/EventQNA/EventQNAList.asp'">이벤트참여</div-->
	   </div>
	  <div style=" float:right; margin-top:16px;     z-index:1001" >
					    
				
						<div style=" float:right; text-align:right;  background-color:#3f82bc; padding:7px; border-radius:2px;  color:#e6e6e6; cursor:pointer;" onClick="GoRead1('274614714063');return false;"  >						
						<img src="http://www.hoteljava.co.kr/images/contents/ico_megapo.png" height="13" align="absmiddle" /> 추석연휴 상담 및 예약 안내..							
						</div>
						
					  	
					
					</div>
    </div>
</div>
<!-- 제휴할인 S -->
  	
<!-- 제휴할인 e -->
<!-- 탑메뉴 e -->


<script>

var AjaxCore=new nineAJAX("AjaxCore");
function OnConfirmReservation2(rindex, hindex, hstatus, bconfirm)
{
	
	LoginCheckAndShowForLayer(rindex, hindex, (bconfirm?goReservation:goReservationCP));
	
}
function goReservation(rindex, hindex)
{
	//OpenLoading("로딩중입니다.");
	/*if(hstatus=="98")
	{
		//alert("P");
		var turl="/HJCoreService/GetHotelDetail.aspx?HotelIndex="+hindex;
		ajaxCore2.ModuleReset();
		var retval=ajaxCore2.SendXmlhttp(turl, 1, "", null);
		//alert(retval);
		
	}*/
	//CheckAvailCore(rindex, hindex);
	CommonReserveCtrl_ShowCtrl3(hindex, rindex, "", true);
	
	
}
function goReservationCP(rindex, hindex)
{
	//OpenLoading("로딩중입니다.");
	/*if(hstatus=="98")
	{
		//alert("P");
		var turl="/HJCoreService/GetHotelDetail.aspx?HotelIndex="+hindex;
		ajaxCore2.ModuleReset();
		var retval=ajaxCore2.SendXmlhttp(turl, 1, "", null);
		//alert(retval);
		
	}*/
	//CheckAvailCore(rindex, hindex);
	CommonReserveCtrl_ShowCtrl3(hindex, rindex, "", false);
	
	
}
function ShowHotelDetail3(hindex, hbindex, srindex, pDetail, actionType)
{

//window.open("/Search/IF_HotelDetailMainNew_n4.asp?SRIndex="+srindex+"&HIndex=" + hindex+"&HBIndex="+hbindex+"&SIndex=&DetailIndex=" + pDetail+"&ActionType="+actionType,"")

	OpenPopUpLayer("HOTELDETAIL","http://www.hoteljava.co.kr/Search/IF_HotelDetailMainNew_n4.asp?SRIndex="+srindex+"&HIndex=" + hindex+"&HBIndex="+hbindex+"&SIndex=&DetailIndex=" + pDetail+"&ActionType="+actionType,"");   

	
}
function GetHotelList(hbindex,cityindex)
{


$("#LISTLAYER").html("<div style=' width:870px;margin-top:150px;text-align:center'><img src=/images/ajax_loading.gif></div>");

    var turl=encodeURI("http://www.hoteljava.co.kr/common/AJAXLib/AJAX_GetSearchHotelListMap.asp?HotelIndex="+hbindex);
 // window.open(turl);
    //return;
    AjaxCore.ModuleReset();
	NParameter=hbindex+"/"+cityindex
    var retval=AjaxCore.SendXmlhttp(turl, 1, "SetHotelList", NParameter);

    //document.getElementById("LISTLAYER").innerHTML=retval;
    
    //document.location.href="#";
    //document.MainMapSearchForm.Page.value=pPage;
}
function SetHotelList(tsuccess, retval, terrorcode, tcustparam)
{

	tcustparames=tcustparam.split("/")
	BHotelBaseIndex=tcustparames[0]
	CityIndex=tcustparames[1]
	$("#LISTLAYER").html(retval);
	
	GetOpenPirceList(BHotelBaseIndex,CityIndex);
	scrollToAnchor('GoListAnchor_'+BHotelBaseIndex);
	
}	

function getAlertPackReserve(r_index,s_index,rindex, hindex, hstatus, bconfirm){


		var turl="http://www.hoteljava.co.kr/HJCoreService/CheckHotel.aspx?SearchIndex="+r_index+"&ResultIndex="+s_index+"&Supplier=HNT"
	
	     ajaxCore.ModuleReset();
		
		  var retval=ajaxCore.SendXmlhttp(turl, 1, "", null);
		  
		  
		    retval=retval.replace(/&amp;/g, "&");
			retval=retval.replace(/&/g, "&amp;");
			
			var oXmlDoc = ajaxCore.GetDOMFromXMLText(retval);
			if(oXmlDoc!=null)
			{
				//var otest			=	null;
				var olist=oXmlDoc.getElementsByTagName("INFORM_REMARK");
				var olist2=oXmlDoc.getElementsByTagName("PRICE");
				
				if(olist.length>0)
				{
				
			
				  if(olist2.item(0).getAttribute("STATUS")=="NA"){
				  
				  alert("죄송합니다. 해당 조건으로는 예약진행이 불가합니다.\n\n"+ajaxCore.GetNodeText(olist.item(0)))
				  return false;
				  }else{
				  
				    OnConfirmReservation2(rindex, hindex, hstatus, bconfirm)
				  }
			
					
				}
			}
			else{
					 OnConfirmReservation2(rindex, hindex, hstatus, bconfirm)
				
				}
		
		
	
}
function getAlertPro(r_index,s_index){
	 $("#divPackageSimpleProBox_"+s_index).show();	
	 $("#divPackageSimplePro_"+s_index).html("<img src='/images/ajax_loading.gif' style='width:20px'>");

		var turl="http://www.hoteljava.co.kr/HJCoreService/CheckHotel.aspx?SearchIndex="+r_index+"&ResultIndex="+s_index+"&Supplier=HNT"
	
	     ajaxCore.ModuleReset();
		
		   var retval=ajaxCore.SendXmlhttp(turl, 1, "OnCheckHotelPro", s_index);
		
	
}
function OnCheckHotelPro(tsuccess, retval, terrorcode, tcustparam)
{


	
	var oXmlDoc = ajaxCore.GetDOMFromXMLText(retval);
	if(oXmlDoc!=null)
	{
		//var otest			=	null;
		var olist=oXmlDoc.getElementsByTagName("EVENT_REMARK");
		
		
		if(olist.length>0)
		{
	
		    $("#divPackageSimpleProBox_"+tcustparam).show();
			 Content=ajaxCore.GetNodeText(olist.item(0))
			
			 Contents = Content.replace(/&lt;/g,'<').replace(/&gt;/g,'>').replace(/&amp;/g,'&');
 	      
			$("#divPackageSimplePro_"+tcustparam).html(Contents)	
			
		}
	}
	else{
			alert("알림 오류입니다. 자세한 확인은 상담센터로 문의드립니다.");
		
		}
	

}
function getCancelRule(r_index,s_index,supplier){

     $("#divCancelRuleProBox_"+s_index).show();	
	 $("#divCancelRulePro_"+s_index).html("<img src='/images/ajax_loading.gif' style='width:20px'>");
		var turl="http://www.hoteljava.co.kr/HJCoreService/CheckHotel.aspx?SearchIndex="+r_index+"&ResultIndex="+s_index+"&Supplier="+supplier
	//window.open(turl)
	     ajaxCore.ModuleReset();
		
		   var retval=ajaxCore.SendXmlhttp(turl, 1, "OnCancelPro", s_index);
		
	
}
function date_add(sDate, nDays) {
    var yy = parseInt(sDate.substr(0, 4), 10);
    var mm = parseInt(sDate.substr(5, 2), 10);
    var dd = parseInt(sDate.substr(8), 10);
 
    d = new Date(yy, mm - 1, dd + nDays);
 
    yy = d.getFullYear();
    mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
    dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
 
    return '' + yy + '-' +  mm  + '-' + dd;
}

function OnCancelPro(tsuccess, retval, terrorcode, tcustparam)
{


var Content="";
var Content0="";
var Content1="";
var Content2="";
var Content3="";
 
var now = new Date();  
	year = now.getFullYear();   
	month = now.getMonth()+1;   
	if((month+"").length < 2){
		month="0"+month;  
	 }
	date = now.getDate();    
	if((date+"").length < 2){
		date="0"+date;      
	}

var today = year+""+month+""+date
			   
			   	
	
	var oXmlDoc = ajaxCore.GetDOMFromXMLText(retval);
	
	if(oXmlDoc!=null)
	{
		//var otest			=	null;
		var flist=oXmlDoc.getElementsByTagName("HJ_RESULT");		
		var suppler=flist.item(0).getAttribute("SUPPLIERCODE")
	
	
		if(suppler=="HNT"){
			var olist=oXmlDoc.getElementsByTagName("CANCEL_END_DATE");
		}else if(suppler=="HKR"){
	
			var olist=oXmlDoc.getElementsByTagName("CancelRule")					
		}else if(suppler=="HKW"){
	
			var olist=oXmlDoc.getElementsByTagName("Cancel")		
		}else if(suppler=="TVN"){
	
			var olist=oXmlDoc.getElementsByTagName("Cancellation")					
				
		}else if(suppler=="BCI"){
	
			var olist=oXmlDoc.getElementsByTagName("DeadLine")					
				
		}else if(suppler=="BCO"){
	
			var olist=oXmlDoc.getElementsByTagName("DeadLine")					
				
		}else if(suppler=="GTA"){
	
			var olist=oXmlDoc.getElementsByTagName("ChargeCondition")					
				
		}else if(suppler=="HBD"){
	
			var olist=oXmlDoc.getElementsByTagName("CancellationPolicy")					
				
		}else if(suppler=="TRO"){
	
			var olist=oXmlDoc.getElementsByTagName("Deadline")	
		}else if(suppler=="RTS"){
	
			var olist=oXmlDoc.getElementsByTagName("CancelDeadlineDate")					
								
				
		}else{
		
		}


		if(olist.length>0 )
		{
	     
		    $("#divCancelRuleProBox_"+tcustparam).show();		
			
			if(suppler=="HNT"){
			  Content=ajaxCore.GetNodeText(olist.item(0))			
			  Content = Content.substring(0,4)+"-"+Content.substring(4,6)+"-"+Content.substring(6)
			  Content=date_add( Content.substring(0,10), -5)
			 }else if(suppler=="HKR"){	
	 	      Content=ajaxCore.GetNodeText(olist.item(0))
			  Content=date_add( Content.substring(0,10), -5)		
			 }else if(suppler=="HKW"){	
				var Solist=oXmlDoc.getElementsByTagName("HJ_RESULT");		
		        var DateCheckInDate=Solist.item(0).getAttribute("CHECKINDATE")		
			 
			 
						  for(var i=0; i < (olist.length); i++)
						   {
						   			if(olist.item(i).getAttribute("Charge")=="true")
									{
											
							             if(!olist.item(i).getAttribute("FromDay") || olist.item(i).getAttribute("FromDay")==0)
										 {
																				 
										    Content=today
										    Content = Content.substring(0,4)+"-"+Content.substring(4,6)+"-"+Content.substring(6)
										 
										 }
										 else
										 {
											
											var IntToDay=(olist.item(i).getAttribute("FromDay"))
											Content=date_add( DateCheckInDate, -IntToDay)	
										 }										
							  
									 }
													
							}						   
					
			 
			  Content=date_add( Content.substring(0,10), -5)		
			 	  
			
			 }else if(suppler=="TVN"){
			  Content=olist.item(0).getAttribute("CancelDeadline")			 
			  Content=date_add( Content.substring(0,10), -4)
			 }else if(suppler=="BCI"){
			  Content=olist.item(0).getAttribute("FromDate")
			  Content=date_add( Content.substring(0,10), -5)				  
			 }else if(suppler=="BCO"){
			  var Solist=oXmlDoc.getElementsByTagName("HJ_RESULT");		
		      var DateCheckInDate=Solist.item(0).getAttribute("CHECKINDATE")	
			  for(var i=0; i < (olist.length); i++)
				{				
			       var IntToDayt=olist.item(i).getAttribute("ToDay")
				}
		      var intToday=parseInt(IntToDayt)+6		
			  Content=date_add( DateCheckInDate, -intToday)	 			 				  
			 }else if(suppler=="GTA"){			 
			 	var Solist=oXmlDoc.getElementsByTagName("HJ_RESULT");		
		        var DateCheckInDate=Solist.item(0).getAttribute("CHECKINDATE")	
				
				for(var i=0; i < (olist.length); i++)
				{
					  if(olist.item(i).getAttribute("Type")=="cancellation")
					  {
						   olist2=olist.item(i).getElementsByTagName("Condition")
						  
						   for(var i=0; i < (olist2.length); i++)
						   {
						   			if(olist2.item(i).getAttribute("Charge")=="true")
									{
							             if(!olist2.item(i).getAttribute("ToDay"))
										 {										 
										   Content=today
										   Content = Content.substring(0,4)+"-"+Content.substring(4,6)+"-"+Content.substring(6)
										// alert(Content)
										 }
										 else
										 {
										  var IntToDay=(olist2.item(i).getAttribute("ToDay"))
										  Content=date_add( DateCheckInDate, -IntToDay)	
										 }										
							  
									 }
													
							}
					   
					   }
				  
				}			
			 
			  Content=date_add( Content.substring(0,10), -5)				  
			
			 }else if(suppler=="HBD"){
			  olist2=olist.item(i).getElementsByTagName("DateTimeFrom")
			  for(var i=0; i < (olist2.length); i++)
			  {
			    Content=olist2.item(i).getAttribute("date")		
			  }
		
					 
			  Content = Content.substring(0,4)+"-"+Content.substring(4,6)+"-"+Content.substring(6)
			  Content=date_add( Content.substring(0,10), -5)	
			  			  
			 }else if(suppler=="TRO"){
			  
			    var Solist=oXmlDoc.getElementsByTagName("HJ_RESULT");		
		        var DateCheckInDate=Solist.item(0).getAttribute("CHECKINDATE")	
			  
				  var OffsetTimeUnit=olist.item(i).getAttribute("OffsetTimeUnit")
				  if (OffsetTimeUnit=="Hour")
				  {
					if(olist.item(i).getAttribute("OffsetUnitMultiplier")==0)
					   {
						  Content=today
						  Content = Content.substring(0,4)+"-"+Content.substring(4,6)+"-"+Content.substring(6)
					   }else{
						  var IntToDay=(parseInt(olist.item(i).getAttribute("OffsetUnitMultiplier"))+24)/24  
						  Content=date_add( DateCheckInDate, -IntToDay)			 
											 
						}
									 
				  }else if(OffsetTimeUnit=="Day")
				  {
					  if(olist.item(i).getAttribute("OffsetUnitMultiplier")==0)
					   {
						  Content=today
						  Content = Content.substring(0,4)+"-"+Content.substring(4,6)+"-"+Content.substring(6)
					   }else{
						  var IntToDay=parseInt(olist.item(i).getAttribute("OffsetUnitMultiplier"))
						  Content=date_add( DateCheckInDate, -IntToDay)			 
											 
						}
					
					 
				  }else{
						  Content=today
						  Content = Content.substring(0,4)+"-"+Content.substring(4,6)+"-"+Content.substring(6)
				  }
				
		      		 
			  Content=date_add( Content.substring(0,10), -5)
			 }else if(suppler=="RTS"){
				
			  Content=ajaxCore.GetNodeText(olist.item(0))
			  Content=date_add( Content.substring(0,10), -5)	
		
			 				  
			 
			 }else{
			  Content=ajaxCore.GetNodeText(olist.item(0))
			  Content=date_add( Content.substring(0,10), -5)
			  
			}
			
			

			 Contents0 = Content.replace(/&lt;/g,'<').replace(/&gt;/g,'>').replace(/&amp;/g,'&');
			 Contents1= Contents0.substring(0,10)		
			 Contents2= Contents1.replace("-","");	
			 Contents3= Contents2.replace("-","");
		
	
				
			   
		
		
 	         var NContents= Contents3.substring(0,4)+"-"+Contents3.substring(4,6)+"-"+Contents3.substring(6)
		
			if(parseInt(Contents3) < parseInt(today))
			{
				$("#divCancelRulePro_"+tcustparam).html("취소마감일 :  취소/변경 불가<br> 이 요금은 취소/변경/환불이 불가능한 조건입니다.");
				
			}else{
			
			    $("#divCancelRulePro_"+tcustparam).html("취소마감일 : "+NContents);
			}
			
		 oXmlDoc="";
		}
	}
	else{
			alert("알림 오류입니다. 자세한 확인은 상담센터로 문의드립니다.");
		
		}
	

}

function getAlertPack(r_index,s_index){

	 $("#divPackageSimplePackBox_"+s_index).show();	
	 $("#divPackageSimplePack_"+s_index).html("<img src='/images/ajax_loading.gif' style='width:20px'>");
		var turl="http://www.hoteljava.co.kr/HJCoreService/CheckHotel.aspx?SearchIndex="+r_index+"&ResultIndex="+s_index+"&Supplier=HNT"
	
	     ajaxCore.ModuleReset();
		
		   var retval=ajaxCore.SendXmlhttp(turl, 1, "OnCheckHotelPack", s_index);
		
	
}
function OnCheckHotelPack(tsuccess, retval, terrorcode, tcustparam)
{

	
	
	var oXmlDoc = ajaxCore.GetDOMFromXMLText(retval);
	if(oXmlDoc!=null)
	{
		//var otest			=	null;
		var olist=oXmlDoc.getElementsByTagName("INFORM_REMARK");
		var olist2=oXmlDoc.getElementsByTagName("PRICE");
		
		if(olist.length>0)
		{
	
		    $("#divPackageSimplePackBox_"+tcustparam).show();
			 Content=ajaxCore.GetNodeText(olist.item(0))
			
			 Contents = Content.replace(/&lt;/g,'<').replace(/&gt;/g,'>').replace(/&amp;/g,'&');
 	      
			$("#divPackageSimplePack_"+tcustparam).html(Contents)	
			
		}
	}
	else{
			alert("알림 오류입니다. 자세한 확인은 상담센터로 문의드립니다.");
		
		}
	

}
</script>
 <!-- 팝업마스크-->
<div id="Curtain" style="position: absolute;display: none; z-index: 2000; top: 0; left: 0; width: 100%; height: 100%; background-color: #000000;filter: alpha(opacity=70); -khtml-opacity: 0.7; -moz-opacity:0.7; opacity: 0.7;">	</div>
	
	
	<!-- 팝업레이어 띄우는곳-->
    <script>
    function GoTabLayer(value){
		var obj = document.getElementById("IFPOPUPLAYER");		
		var objDoc = obj .contentWindow || obj .contentDocument;
		objDoc.GoDetail(value);
	}
    
    </script>
	
	<div id="POPUPLAYER"  name="POPUPLAYER" style="position: absolute; display: none; z-index:10000; overflow:hidden"  >	
				<div style=" position:relative; height:50px;">	
				
					
				 	<div style="position:absolute; width:100%; " id="POPUPTAPBUMO">
					<div id="POPUPTAP">
						<div id="DivGoTabLayer0" style=" float:left;"  class="BookingBoxtabmenuOff" onClick="javascript:GoTabLayer(0);">호텔정보</div>
						<div id="DivGoTabLayer3" style=" float:left;"  class="BookingBoxtabmenuOff" onClick="javascript:GoTabLayer(3);">호텔사진더보기</div>
						<div id="DivGoTabLayer4" style=" float:left;"  class="BookingBoxtabmenuOff" onClick="javascript:GoTabLayer(4);">위치&amp;지도</div>
						<div id="DivGoTabLayer6" style=" float:left;"  class="BookingBoxtabmenuOff" onClick="javascript:GoTabLayer(6);">한줄평가</div>
						<div id="DivGoTabLayer5" style=" float:left;"  class="BookingBoxtabmenuOff" onClick="javascript:GoTabLayer(5);">고객리뷰</div>
                      </div>  
                        
                        
						<div  id="POPUPCLOSE"  name="POPUPCLOSE"   style=" float:right;padding-right:2px;">				
						<div style="  width:20px; padding-left:5px;  height:30px; line-height:30px; z-index:10001;  background-color:#448cca; color:#FFFFFF; font-size:22px; cursor:pointer;" onClick="javascript:ClosePopUpLayer();return false;">X</div>		
					</div>	
			    	</div>
					
				</div>
		
		
		
			<div id="POPUPCURTAIN"    name="POPUPCURTAIN"  style="position:absolute;width:100%;height:100%; ">					
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr><td align="center" valign="middle"   style="padding-bottom:150px">  
				<div style=" width:200px;">
					<div><img src="http://www.hoteljava.co.kr/images/contents/java_ci.png" width="129" height="101" /></div>
					<div style=" margin-top:10px;"><img src="http://www.hoteljava.co.kr/images/contents/ico_loading.gif" width="131" height="11" /></div>
		        </div>	</td></tr>
			</table>	
			</div>	
			<div id="POPUPLAYERCONTENTS" >		    
			<div id="IFPOPUPLAYERBOX"  style="width:1120px; float:left;" class="BookingBox" ><iframe src="" id="IFPOPUPLAYER"  name="IFPOPUPLAYER" style=" width:0px;height:0px;" frameborder="0" allowTransparency="true" ></iframe></div>
			</div>
	
	
	</div>
	
	
	
	
	
	
	
	
	<div id="LOADINGLAYER"  name="POPUPLAYER" style="position: absolute; display: none; z-index:10000; overflow:hidden"  >	
		
		<table width="200px" border="0" cellspacing="0" cellpadding="0">
		    <tr><td align="center"><img src="http://www.hoteljava.co.kr/images/contents/java_ci.png" width="129" height="101" /></td></tr>
			<tr><td align="center"><img src="http://www.hoteljava.co.kr/images/contents/ico_loading.gif" width="131" height="11" /></td></tr>
			<tr><td align="center" style="padding-top:10px">검색중입니다.</td></tr>
			<tr><td style="padding: 5px; text-align: center; line-height: 1.5em" id="LOADINGLAYERTEXT">
			
			
			</td></tr>
		</table>
	
	</div>

	<div id="BIGLOADINGLAYER"  name="POPUPLAYER"  style="width:100%; height:280px;position: absolute; display: none; z-index:10000;">
<div style=" border:solid 10px #448cca ; background-color:#FFFFFF;width:850px; height:280px;-webkit-border-radius: 140px;   -moz-border-radius: 140px; margin:auto;  border-radius: 140px; overflow:hidden"   >		
	
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td  align="center" valign="middle" >
				<div style="float:left; width:200px; padding-left:100px; padding-top:80px;">
			<div><img src="http://www.hoteljava.co.kr/images/contents/java_ci.png" width="129" height="101" /></div>
			<div style=" margin-top:10px;"><img src="http://www.hoteljava.co.kr/images/contents/ico_loading.gif" width="131" height="11" /></div>
		</div>
		<div style="float:left; width:450px; margin-top:40px;" class="fontLarge">
			  <div id="DivOpenBigLoadingText"><div  style="height:40px"></div></div>
			<div style="margin-top:20px; font-weight:600;">호텔자바에서 가장 저렴한 가격을 비교 검색중입니다. <br />지역에 따라 최대 2~3분 정도 소요될 수 있으니 잠시만 기다려 주세요.</div>
			<div style=" margin-top:30px; font-size:11px; color:#b9b9b9;">Shin JaeYeol, Kim TaeWoong, Kim YongEock, Lee WooBin, Lee HyeJin, Yoo HyeJin <br />Thanks To. Ryu YangHyun, Kim HyeongRyeol, Ham JuRyung, Heo JiYoon</div>
		</div>
		<div style=" clear: both;"></div>
				
				</td>
			</tr>
        </table>
		
	</div>
</div>	
	
	<div id="ANILAYER" style="position: absolute; display: none;">
		<!--검색중입니다. -->
	</div>
	<div id="INDICATOR" style="position: absolute; display: none; ">
		<!--<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr><td align="center">검색중입니다.</td></tr>
			<tr><td style="padding: 5px; text-align: center; line-height: 1.5em" id="Td1"><font style="color:#126e5b;font-weight:600;">**처리 진행 중 입니다.**</font><br/>
<br/><font style="color:#126e5b;">결과가 나올 때까지 브라우저를 닫지 마시고 기다려주세요!</font></td></tr>
		</table> -->
	</div>
<!-- 검색 상태라인 S -->
<script type="text/javascript" src="http://www.hoteljava.co.kr/common/calendar/Calendar.js"></script>
<script type="text/javascript" src="http://www.hoteljava.co.kr/common/js/cals.js"></script>

<div style="clear:both;"></div>
 <div style="height:0px"><a  id="GoListAnchor_ListTap" >&nbsp;</a></div>
<div style="background-color:#363636; background-image:url(http://www.hoteljava.co.kr/images/contents/top_pattern.gif); color:#FFFFFF; padding-top:15px; padding-bottom:15px;min-width:1130px;">
    <div class="Inner">
		<div style="float:left; margin-left:15px;">
			<div style="margin-top:3px;" id="CCLocationTap"><span style="font-weight:600;" class="fontLarge2">전체지도</span></div>
			<div style="height:9px"><span  style="font-size:9px; color:#363636" id="CClocationTapbottom"></span></div>
			<input type="hidden" id="NNation" name="NNation"  />
			<input type="hidden" id="NCity" name="NCity"  />
		</div>
		<form id="MainMapSearchForm" name="MainMapSearchForm" action="GotoMapForCity();">
		<div style="float:right;">
			<div style="float:right; margin-right:5px; font-weight:600; color:#C6C6C6;" class="fontLarge"><button class="buttonNormal" style="height:34px;" type="button"  onclick="GotoMapForCity();return false;">선택한 도시로 지도이동</button></div>
			<div style="float:right; margin-right:5px;">
				<select name="CityIndex" id="CityIndex" style="width:240px;">
                    <option value="">도시를 선택하세요</option>
                 </select>
			</div>
			<div style="float:right; margin-right:5px;">
				<select name="CountryIndex" id="CountryIndex" style="width:240px;">
                     <option value="">국가를 선택하세요</option>
              </select>
			</div>
		</div>
		</form>
	<script type="text/javascript" language="javascript" src="http://www.hoteljava.co.kr/common/js/CoUtil.js"></script>                                                            
<script type="text/javascript">
var AjaxCore=new nineAJAX("AjaxCore");

function GetCityList(tobj,pCityIndex)
{
    var turl="http://www.hoteljava.co.kr/common/AJAXLib/AJAX_Client_GetSubBaseItemList.asp?type=7&reqmode=SELECTOPTION&baseindex=" + tobj.value + "&selindex=" + pCityIndex ;
    var retval="<SELECT NAME=\"CityIndex\" ID=\"CityIndex\" style=\"width:240px\"><OPTION VALUE=\"\">도시를 선택하세요</OPTION>";
    //retval+=AjaxCore.SendXmlhttp(turl, 1, "", null);
    retval+="<option value=\"4327\" style=\"background:#FBFDD6;color:black\" >서울(Seoul)</option>";
    retval+="</SELECT>";
    document.MainMapSearchForm.CityIndex.parentNode.innerHTML=retval;
}

function GetCountryList(tobj)
{
    var turl="http://www.hoteljava.co.kr/common/AJAXLib/AJAX_Client_GetSubBaseItemList.asp?type=4&reqmode=SELECTOPTION&baseindex="+tobj.value ;

    var retval="<SELECT NAME=\"CountryIndex\" ID=\"CountryIndex\" style=\"width:240px\" onchange=\"GetCityList(this)\"><OPTION VALUE=\"\">국가를 선택하세요</OPTION>";
    //retval+=AjaxCore.SendXmlhttp(turl, 1, "", null);
    retval+="<option value=\"117\" style=\"background:#FBFDD6;color:black\" >대한민국</option>";
    retval+="</SELECT>";
    document.MainMapSearchForm.CountryIndex.parentNode.innerHTML=retval;
    
    GetCityList(tobj,"");
        
}

function GotoMapForCity()
{
    var f = document.MainMapSearchForm;
	

    if(f.CountryIndex.value=="")
    {
        alert("국가를 선택하세요.");
        f.CountryIndex.focus();
        return;
    }
    if(f.CityIndex.value=="")
    {
        alert("도시를 선택하세요.");
        f.CityIndex.focus();
        return;
    }
    
    Lat=37.5628;
	Lng=126.9796;
	   ggle_map.clearOverlays()
	   ggle_map.panTo(new GLatLng(Lat, Lng))		
	   ggle_map.setCenter(new GLatLng(Lat, Lng))
	  
	
	 
	   setTimeout(function() { ggle_map.setZoom(14) }, 1000);
	   ggle_map.setZoom(14)
    
    /*
	var ajaxurl = "http://www.hoteljava.co.kr/search/IF_SearchFindLocation.asp?CountryIndex="+escape(f.CountryIndex.value)+"&CityIndex="+escape(f.CityIndex.value);

		//alert(ajaxurl)
		//location.href=ajaxurl;
		$.post(ajaxurl, function(data) {
			if (data != "") {
			dataes=data.split("/");
			Lat=dataes[0];
			Lng=dataes[1];
			   ggle_map.clearOverlays()
			   ggle_map.panTo(new GLatLng(Lat, Lng))		
			   ggle_map.setCenter(new GLatLng(Lat, Lng))
			  
			
			 
			   setTimeout(function() { ggle_map.setZoom(14) }, 1000);
			   ggle_map.setZoom(14)
							
			}
		});
	*/
	

}


function SelectCity(pCountryIndex, pCityIndex)
{
    var tObj = document.MainMapSearchForm.CountryIndex;
    
    for(var i=1;i<tObj.length;i++)
    {
        if(pCountryIndex==tObj[i].value)
        {
            tObj[i].selected=true;
            break;
        }
    }
    GetCityList(tObj,pCityIndex);
}

GetCountryList(document.MainMapSearchForm.CountryIndex);
</script> 	
		<div style="clear:both;"></div>
    </div>
</div>
<!-- 검색 상태라인 E -->

<script>
function OpenLeftMenu(Menu)
{
	var NNation=document.getElementById("NNation").value 
	var NCity=document.getElementById("NCity").value	
	var maplevel = ggle_map.getZoom();
	
	if(Menu=="L")
	{
		$("#ListLeftMenuHotel").hide();
		$("#ListLeftMenuLandMark").show();
		
	
		
		
	}
	else
	{	
		$("#ListLeftMenuLandMark").hide();
		$("#ListLeftMenuHotel").show();
		
		var ajaxurl = "http://www.hoteljava.co.kr/search/IF_SearchListMapHotelList.asp?NNation="+escape(NNation)+"&NCity="+escape(NCity)+"&MapLevel="+maplevel;	
																				
		//window.open(ajaxurl )
		 $.post(ajaxurl, function(data) {
			if (data != "") {	
				$("#DivGetSearchMapHotelList").html(data);															
			}
		 })
	
		
	}

}
</script>
<!-- 컨텐츠  S -->

<div style="clear:both; padding-top:50px;"></div>
<div>
    <div class="Inner">
	
		<!-- 좌측메뉴  S -->
		<div style=" float:left; width:230px;" >
		
		
			
			<!-- 랜드마크  S -->
			<div id="ListLeftMenuLandMark"> 
			<div style="height:40px;">
				<div style=" float:left; font-weight:600; width:115px; height:40px; line-height:40px; text-align:center; border-top:solid 1px #adc0cd; border-left:solid 1px #adc0cd; border-right:solid 1px #adc0cd;
   vertical-align: middle; color:#448cca; background-color:#FFFFFF"class="SubTitle" onclick="OpenLeftMenu('L')">랜드마크</div>
				<div style=" float:right; width:110px; margin-top:2px;" class="tabmenuOff" onclick="OpenLeftMenu('H')">호텔목록</div>
				<div style="clear:both"></div>
			</div>
			
			<div id="DivLeftMenuSub_a1" style="width:228px; height:566px; border:solid 1px #adc0cd;">
				 
				 <div v id="DivLeftMenuSub_a2" style="width:208px; height:544px; margin-left:5px; margin-top:10px;  padding-left:10px; padding-right:5px; border-image-source: initial; border-image-slice: initial; border-image-width: initial; border-image-outset: initial; border-image-repeat: initial; overflow-y: auto; overflow-x: hidden;">
				 
					 <div id="DivGetSearchMapLandmark">
					 </div>
						
					
					
				</div>
				 
			
				 
			</div>
			</div>
			<!-- 랜드마크  E -->
			
			
			<!-- 호텔리스트 S  -->
			<div id="ListLeftMenuHotel" style="display:none"> 
			<div style="width:230px;height:40px;">
				<div style=" float:left; width:110px; margin-top:2px;" class="tabmenuOff" onclick="OpenLeftMenu('L')">랜드마크</div>
				<div style=" float:right; font-weight:600; width:115px; height:40px; line-height:40px; text-align:center; border-top:solid 1px #adc0cd; border-left:solid 1px #adc0cd; border-right:solid 1px #adc0cd;
   vertical-align: middle; color:#448cca; background-color:#FFFFFF"class="SubTitle" onclick="OpenLeftMenu('H')">호텔목록</div>
				
				<div style="clear:both"></div>
			</div>
			<script>
			function GetSearchLeftMenuHotelList(){
			
			    var datas = decodeURIComponent($("#SearchLeftMenuSub_Tab").serialize()).replace(/\n/g,"<br>");	

	      		  $('#DivGetSearchMapHotelList').html("<img src='http://www.hoteljava.co.kr/images/icon/loading.gif'>");
			
				                  var NNation=document.getElementById("NNation").value 
								  var NCity=document.getElementById("NCity").value	
								  $("#DivGetSearchMapHotelList").html("");	
											var ajaxurl = "http://www.hoteljava.co.kr/search/IF_SearchListMapHotelList.asp?NNation="+escape(NNation)+"&NCity="+escape(NCity)+"&"+datas;	
																					
											//window.open(ajaxurl )
											 $.post(ajaxurl, function(data) {
												if (data != "") {	
													$("#DivGetSearchMapHotelList").html(data);															
												}
											 })	 	
										 
			}
			</script>
			<div  id="DivLeftMenuSub_b1" style="width:228px;  height:566px; border:solid 1px #adc0cd;">
			
			
				<div style=" padding:5px; display:none" id="DivLeftMenuSub_b1_Tab">
				<form id="SearchLeftMenuSub_Tab" name="SearchLeftMenuSub_Tab" action="javascript:GetSearchLeftMenuHotelList();" >
					 <ul style=" background-color:#666666; border-bottom:solid 1px #565656; padding:10px;" class="fontcolorGray fontSmall">
						<li><span class="fontcolorYellow">아래 목록에서 호텔명 검색</span> <span style="color:#CCCCCC">(지도에 보이는 도시에 있는 호텔 전체 목록입니다)</span></li>
						<li style="margin-top:5px;">
							<div style="float:left"><input type="text" id="SearchTextLeftMenuSub_Tab" name="SearchTextLeftMenuSub_Tab"  style="width:130px;" value="호텔명을 입력해 주세요" onclick="this.value=''"/>
							</div>
							<div style="float:right"><button class="buttonGrayBackOff" style="width:50px; height:34px;"  type="button" onclick="GetSearchLeftMenuHotelList();return false;">검색</button></div>
							<div style=" clear:both"></div>
						</li>
					 </ul>	
					 </form>			 
			  </div>
				 
				 
				 <div  id="DivLeftMenuSub_b2" style="width:208px; height:544px; margin-left:5px; margin-top:10px;  padding-left:10px; padding-right:5px; border-image-source: initial; border-image-slice: initial; border-image-width: initial; border-image-outset: initial; border-image-repeat: initial; overflow-y: auto; overflow-x: hidden;">
				   <div id="DivGetSearchMapHotelList"></div>
					 
				 </div>
				 
			</div>
			</div>
			<!-- 호텔리스트  E -->
			
			
			
		</div>
		<!-- 좌측메뉴  E -->
		<input type="hidden" id="IsMarkerClick"  name="IsMarkerClick"/>

	<div id="DivGetSearchMapContinent"></div>
	<div id="DivGetSearchMapNation"></div>
	<div id="DivGetSearchMapCity"></div>
	<div id="DivGetSearchMapHotel"></div>
		
		<!-- 설명  S -->
	<!-- 필터링  S -->
		<div style=" float:right; width:870px;">
			<div style="border:solid 1px #d7d7d7;">
				<div style="padding:15px;">
					<span style=" float:left; "><img src="http://www.hoteljava.co.kr/images/ggle_icons/icon_target_s.png" align="absmiddle" /></span><span style=" float:left; font-weight:600; padding-left:7px;">현재위치 :</span>					
					<span style="float:left; padding-left:10px; padding-right:10px;" id="StrLocation"></span>
					<span style="float:right; padding-left:10px; padding-right:10px;">
						<img src="http://www.hoteljava.co.kr/images/ggle_icons/Icon_group.png" width="19" height="21" align="absmiddle" /> 그룹 
						<span style="padding-left:5px; padding-right:5px;" class="fontcolorLightGray">&gt;</span>
						<img src="http://www.hoteljava.co.kr/images/ggle_icons/Icon_nation.png" align="absmiddle" /> 국가
						<span style="padding-left:5px; padding-right:5px;" class="fontcolorLightGray">&gt;</span>
						<img src="http://www.hoteljava.co.kr/images/ggle_icons/Icon_town.png" width="19" height="21" align="absmiddle" /> 도시
						<span style="padding-left:5px; padding-right:5px;" class="fontcolorLightGray">&gt;</span>
						<img src="http://www.hoteljava.co.kr/images/ggle_icons/hotel00_C.png" width="19" height="21" align="absmiddle" /> 호텔					</span>
					<div style="clear:both"></div>
			  </div>
				<script>
				 function onOptSearch() {					
					var center = ggle_map.getCenter();
       				var maplevel = ggle_map.getZoom();
					var Ncenter=center.toString()
					 Ncenter=Ncenter.replace('(','')
					 Ncenter=Ncenter.replace(')','')		
					 Ncenter=Ncenter.replace(' ','')	
										 
					var LatLongitudes=Ncenter.split(",")
					var NLatitude=LatLongitudes[0]									
					var NLongitude=LatLongitudes[1]

               		var datas_List = $("#srchOPForm").serialize().replace(/=(.[^&]*)/g, function($0,$1) {
	       					return "="+escape(decodeURIComponent($1).replace(/\n/g,"\r\n"))	});
					  
					  var ajaxurl = "http://www.hoteljava.co.kr/search/IF_SearchListMapHotel.asp?Latitude="+NLatitude+"&Longitude="+NLongitude+"&MapLevel="+maplevel+"&"+datas_List;											
						//window.open(ajaxurl )
						 $.post(ajaxurl, function(data) {
							if (data != "") {	
												   
								$("#DivGetSearchMapHotel").html(data);
													
								 ggle_map.clearOverlays()
									initHotelMark()													
								}
						  })
							
																					
				  }
			
				</script>
				<form id="srchOPForm" name="srchOPForm" >
				
				<div style="padding:15px; background-color:#f6f6f6; border-top:dotted 1px #c6c6c6; display:none" id="MOtSearchTap">
					<span class="MainColor" style="font-weight:600;">등급</span>
					<span style="padding-left:7px; cursor: pointer;"><input type="checkbox" name="opsl" value="0" checked  onclick="onOptSearch();"> 호텔외</span>
					<span style="padding-left:7px; cursor: pointer;" class="fontcolorYellow"><input type="checkbox" name="opsl" value="1" checked  onclick="onOptSearch();"> ★</span>
					<span style="padding-left:7px; cursor: pointer;" class="fontcolorYellow"><input type="checkbox" name="opsl" value="2" checked  onclick="onOptSearch();"> ★★</span>
					<span style="padding-left:7px; cursor: pointer;" class="fontcolorYellow"><input type="checkbox" name="opsl" value="3" checked  onclick="onOptSearch();"> ★★★</span>
					<span style="padding-left:7px; cursor: pointer;" class="fontcolorYellow"><input type="checkbox" name="opsl" value="4"  checked onclick="onOptSearch();"> ★★★★</span>
					<span style="padding-left:7px; cursor: pointer;" class="fontcolorYellow"><input type="checkbox" name="opsl" value="5" checked  onclick="onOptSearch();"> ★★★★★</span>
					
					<span class="MainColor" style="padding-left:25px; font-weight:600;">테마</span>
					<span style="padding-left:7px; cursor: pointer;"><input type="checkbox" name="opht" value="RC" onclick="onOptSearch();"> 추천호텔</span>
					<span style="padding-left:7px; cursor: pointer;"><input type="checkbox" name="opht" value="PK" onclick="onOptSearch();"> 배낭여행</span>
					<span style="padding-left:7px; cursor: pointer;"><input type="checkbox" name="opht" value="RD" onclick="onOptSearch();"> 레지던스</span>
					<span style="padding-left:7px; cursor: pointer;"><input type="checkbox" name="opht" value="BQ" onclick="onOptSearch();"> 부띠끄</span>
				</div>
				</form>
			</div>
		</div>
		
		<!-- 필터링  E -->
            
		 <div style=" float:right; width:870px; margin-top:5px;" >
		 
			   <div class="landmarks" id="mapcontainer"  style="margin-bottom:30px; display:none">	
			   	    <div style="position:relative">
						<div id="locationmap"  class="imgborder">  </div>
						<div style="  color:#FF0000; font-weight:600; position:absolute; left:394px; top:228px; "><img id="SearchTargetPoint" src="http://www.hoteljava.co.kr/images/ggle_icons/icon_target.png"   style=" width:80px; height:80px; display:none " /></div>
					</div>
				
			   </div>
			   
		 </div>  
           
	
		<!-- 탭메뉴  S -->
		<script>		
		function StartMapPro()
		{
			onMapLoad();
			/*
			   var ajaxurl = "http://www.hoteljava.co.kr/search/IF_SearchListMapContinent.asp"
		 	  //window.open(ajaxurl)
				$.post(ajaxurl, function(data) {
					if (data != "") {
		
					  $("#DivGetSearchMapContinent").html(data);
					   onMapLoad();
						
					}
				});
		   */
		}
		StartMapPro(); //searchListMap.js 로 빼놨음.
		 </script>

		<!-- 호텔하나  S -->
		<div style=" float:right; width:870px;">
				<div name="LISTLAYER" id="LISTLAYER">  
			
			   </div> 
		 </div>
		<!-- 호텔하나  E -->
		

    </div>
</div>
<!-- 컨텐츠 E -->


<!--  S -->
<div style="clear:both;"></div>
<div>
    <div class="Inner">

    </div>
</div>
<!--  E -->


<!-- 풋터 S -->

<!-- 네이버 공통 적용 스크립트 , 모든 페이지에 노출되도록 설치. 단 전환페이지 설정값보다 항상 하단에 위치해야함 --> 
<script type="text/javascript" src="http://wcs.naver.net/wcslog.js"> </script> 
<script type="text/javascript"> 
if (!wcs_add) var wcs_add={};
wcs_add["wa"] = "s_5942bc58553";
if (!_nasa) var _nasa={};
wcs.inflow();
wcs_do(_nasa);
</script>

<!-- Google Tag Manager / HOTELJAVA-GTM 용 -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-PPDH92"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-PPDH92');</script>
<!-- End Google Tag Manager -->


<!-- Facebook Pixel Code / 페이스북 로그분석 -->
<script>
!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
document,'script','https://connect.facebook.net/en_US/fbevents.js');

fbq('init', '1740086959593283');
fbq('track', "PageView");</script>
<noscript><img height="1" width="1" style="display:none"
src="https://www.facebook.com/tr?id=1740086959593283&ev=PageView&noscript=1"
/></noscript>
<!-- End Facebook Pixel Code -->


<div style="clear:both;"></div>
<div id="FooterLine" style=" margin-top:50px;">
    <div class="Inner">
       <div class="buttonFootermenu" style=" float:left;" onClick="javascript:location.href='/introduction/intro.asp'">회사소개</div>
	   <div class="buttonFootermenu" style=" float:left;" onClick="javascript:location.href='/javacafe/PressList.asp'">언론보도</div>
	   <div class="buttonFootermenu" style=" float:left;" onClick="javascript:location.href='/center/CenterRegi3.asp'"><span style=" font-weight:bold;">개인정보취급방침</span></div>
	   <div class="buttonFootermenu" style=" float:left;" onClick="javascript:location.href='/center/CenterRegi.asp'">이용약관</div>
	   <div class="buttonFootermenu" style=" float:left;" onClick="javascript:location.href='/center/CenterRegi2.asp'">해외여행표준약관</div>
	    <div class="buttonFootermenu" style=" float:left;" onClick="window.open('http://old.hoteljava.co.kr')">구)홈페이지</div>
		<div class="buttonFootermenu" style=" float:left;" onClick="javascript:location.href='/common/Inc/GoJavaMobile.asp'">모바일버젼</div>
		<div class="buttonFootermenu" style=" float:left; "onClick="window.open('http://www.hertz.com/rentacar/HertzlinkHandler?id=43548&LinkType=HZHK&POS=KR&lang=ko')">
			<div style=" float:left; height:60px; line-height:60px;">전세계 렌트카예약</div><div style="float:left; padding-top:16px; margin-left:5px;"><img src="http://www.hoteljava.co.kr/images/contents/banner_hertz.png" height="20"  style=" margin-top:4px;"/></div>
			<div style="clear:both;"></div>
		</div>
	   <div class="fontcolorLightGray fontSmall" style=" float:right; cursor:pointer; padding-top:20px;" onclick="window.scrollTo(0,0);">맨위로 ∧</div>
	   
    </div>
</div>

<div id="FooterContents">
    <div class="Inner" style="text-align:left;">
    	<div style="float:left; color:#777777;">
             <ul>고객센터 1544-8608 / 일반전화(서울) 02-723-6431 / 팩스(서울) 02-6455-2007 / 상담시간 평일: 09:00~18:00 / 토요일, 일요일, 공휴일 휴무 (예약가능,상담불가)</ul>
             <ul style="margin-top:10px;">트래블베이(주) / 도로명: 서울. 종로구 율곡로 84, 1703(운니동,가든타워) / 지번: 서울. 종로구 운니동 98-78 가든타워빌딩 1703호</ul> 
             <ul>
               사업자등록번호: 101-86-22524 / 관광사업자등록번호: 2014-000029 / 통신판매업신고: 서울종로-0543 / 대표이사: 신재열 / 개인정보보호책임자: 김용옥
             </ul>
             <ul style="margin-top:10px;">TravelBay Co.,Ltd. / #1703 (Unni-dong, Garden Tower), 84, Yulgok-ro, Jongno-gu, Seoul, Korea [110-795]</ul>
             <ul>Copyright (C) TravelBay. All Rights Reserved.</ul>
         </div>
         <div style="float:right; margin-top:20px;">
			<a href="/center/CenterGuide.asp"><img src="http://www.hoteljava.co.kr/images/contents/ico_kakaotalk.png" height="30"/ border="0"></a>
         </div>
         <div style="float:right; margin-top:20px; margin-right:10px;">
			<a href="https://www.instagram.com/hotel_java/" target="_blank"><img src="http://www.hoteljava.co.kr/images/contents/ico_insta.png" height="30"/ border="0"></a>
         </div>
         <div style="float:right; margin-top:20px; margin-right:10px;">
			<a href="https://www.facebook.com/HotelJava.co.kr" target="_blank"><img src="http://www.hoteljava.co.kr/images/contents/ico_fb.png" height="30"/ border="0"></a>
         </div>
         <div style="float:right; margin-top:20px; margin-right:10px;">
			<a href="http://blog.naver.com/hoteljavaman" target="_blank"><img src="http://www.hoteljava.co.kr/images/contents/ico_blog.png" height="30"/ border="0"></a>
         </div>
         <div style="clear:both;"></div>
    </div>
</div>

<!-- 풋터 E -->
	

<script type="text/javascript" language="javascript">

 var tempLoginCtrl_ajaxCore=new nineAJAX("tempLoginCtrl_ajaxCore");
 var tempLoginCtrl_MsgLayer=null;
var LoginAfterParam1=null;
var LoginAfterParam2=null;
var LoginAfterCallBack=null;
function LoginCheckAndShowForLayer(param1, param2, exfunction)
{


	LoginAfterParam1=null;
	LoginAfterParam2=null;
	LoginAfterCallBack=null;
	var turl="http://www.hoteljava.co.kr/common/AJAXLib/AJAX_LoginCheck.asp";

	tempLoginCtrl_ajaxCore.ModuleReset();
	var retval=tempLoginCtrl_ajaxCore.SendXmlhttp(turl, 1, "", null);
	

	if(retval=="LOGIN")
	{
	
		exfunction(param1, param2);
	}
	else
	{
		
		LoginAfterParam1=param1;
		LoginAfterParam2=param2;
		LoginAfterCallBack=exfunction;
		tempLoginCtrl_ShowCtrl();
	}
	
}

function LoginCheckAndShowForLayer2(param1, param2, param3, exfunction)
{


	LoginAfterParam1=null;
	LoginAfterParam2=null;
	LoginAfterParam3=null;
	LoginAfterCallBack=null;
	var turl="http://www.hoteljava.co.kr/common/AJAXLib/AJAX_LoginCheck.asp";

	tempLoginCtrl_ajaxCore.ModuleReset();
	var retval=tempLoginCtrl_ajaxCore.SendXmlhttp(turl, 1, "", null);
	

	if(retval=="LOGIN")
	{
	
		exfunction(param1, param2, param3);
	}
	else
	{
		
		LoginAfterParam1=param1;
		LoginAfterParam2=param2;
		LoginAfterParam2=param3;
		LoginAfterCallBack=exfunction;
		tempLoginCtrl_ShowCtrl();
	}
	
}

function tempLoginCtrl_OnAnonymousLogIn()
{
	
	if (document.getElementById("c1").checked==false){
		alert('이용약관에 동의해주세요.')
		document.getElementById("c1").c1.focus();
		return;
	}
	
    var MobileNo = "--";
    var Email = "";
	
    if(document.getElementById("tempLoginCtrl_UserName").value == "" ||  document.getElementById("tempLoginCtrl_UserName").value =="한글성명")
    {
        alert("성명을 입력해주세요.");
        document.getElementById("tempLoginCtrl_UserName").focus();
        return false;        
    }

    if(document.getElementById("tempLoginCtrl_LogInType").value == "NEW")
    {       
        if(document.getElementById("tempLoginCtrl_SecondMobileNo").value == "")
        {
            alert("휴대전화 번호를 입력해주세요.");
            document.getElementById("tempLoginCtrl_SecondMobileNo").focus();
            return false;        
        }
        if(document.getElementById("tempLoginCtrl_ThirdMobileNo").value == "")
        {
            alert("휴대전화 번호를 입력해주세요.");
            document.getElementById("tempLoginCtrl_ThirdMobileNo").focus();
            return false;        
        }
        if(document.getElementById("tempLoginCtrl_FirstEmail").value == "")
        {
            alert("이메일을 입력해주세요.");
            document.getElementById("tempLoginCtrl_FirstEmail").focus();
            return false;        
        }
        if(document.getElementById("tempLoginCtrl_LastEmail").value == "")
        {
            alert("이메일을 입력해주세요.");
            document.getElementById("tempLoginCtrl_LastEmail").focus();
            return false;        
        }

        MobileNo = document.getElementById("tempLoginCtrl_FirstMobileNo").value + "-" + document.getElementById("tempLoginCtrl_SecondMobileNo").value + "-" + document.getElementById("tempLoginCtrl_ThirdMobileNo").value;
        Email = document.getElementById("tempLoginCtrl_FirstEmail").value + "@" + document.getElementById("tempLoginCtrl_LastEmail").value;
    }

    var turl="/common/AJAXLib/AJAX_AnonLoginProc.asp?";
    turl+=("RRGNo1="+document.getElementById("tempLoginCtrl_RRGNo1").value);
    turl+=("&RRGNo2="+document.getElementById("tempLoginCtrl_RRGNo2").value);
    turl+=("&UserName="+escape(document.getElementById("tempLoginCtrl_UserName").value));
    turl+=("&MobileNo="+escape(MobileNo));
    turl+=("&Email="+escape(Email));
    turl+=("&LogInType="+document.getElementById("tempLoginCtrl_LogInType").value);

	tempLoginCtrl_ajaxCore.ModuleReset();
	var retval=tempLoginCtrl_ajaxCore.SendXmlhttp(turl, 1, "", null);
	if(retval.indexOf("OK")!=-1)
	{
		tempLoginCtrl_HideCtrl("OK");
	}
	else
	{   
        alert(retval);
        /*
	    document.getElementById("tempLoginCtrl_UserName").readOnly = true;
	    document.getElementById("tempLoginCtrl_RRGNo1").readOnly = true;
	    document.getElementById("tempLoginCtrl_RRGNo2").readOnly = true;
	    
	    document.getElementById("UserName").value = document.getElementById("tempLoginCtrl_UserName").value;
	    document.getElementById("RRGNo1").value = document.getElementById("tempLoginCtrl_RRGNo1").value;
	    document.getElementById("RRGNo2").value = document.getElementById("tempLoginCtrl_RRGNo2").value;
	    
		document.IfTopLoginProcPage.location.href="/Member/IF_CheckRNForm.asp?RetFunction=OnEndCheckRN";
        */
	}
    
}
function tempLoginCtrl_OnLogIn()
{
	if(document.getElementById("tempLoginCtrl_userid").value == "")
    {
        alert("아이디를 입력해주세요.");
        document.getElementById("tempLoginCtrl_userid").focus();
        return false;        
    }
    
    if(document.getElementById("tempLoginCtrl_userpw").value == "")
    {
        alert("비밀번호를 입력해주세요.");
        document.getElementById("tempLoginCtrl_userpw").focus();
        return false;   
    }
	var turl="http://www.hoteljava.co.kr/common/AJAXLib/AJAX_LoginProc.asp?UserID="+document.getElementById("tempLoginCtrl_userid").value+"&UserPW="+document.getElementById("tempLoginCtrl_userpw").value;
	//window.open(turl);
	tempLoginCtrl_ajaxCore.ModuleReset();
	var retval=tempLoginCtrl_ajaxCore.SendXmlhttp(turl, 1, "", null);
	if(retval.indexOf("OK")!=-1)
	{
		tempLoginCtrl_HideCtrl("OK");
		
	} else if(retval.indexOf("MERGE")!=-1) {
	   // if(confirm("회원님의 이름으로 비회원 예약 기록이 있습니다.\n통합하시겠습니까?")) 
       // {
          //  turl = "";
           // retval = "";
           // turl="/common/AJAXLib/AJAX_UserMergeProc.asp";
           // tempLoginCtrl_ajaxCore.ModuleReset();
            //retval=tempLoginCtrl_ajaxCore.SendXmlhttp(turl, 1, "", null);
        	
            //if(retval=="OK")
           // {
               // alert("통합이 완료되었습니다.");
           // } else {
                //alert("통합 도중 오류가 발생했습니다.");
            //}
       // }
        tempLoginCtrl_HideCtrl("OK");
	} else {
		alert("로그인이 실패하였습니다.\n입력하신 정보가 정확한지 확인 후 다시 입력바랍니다.");
	}
	
	
}
function tempLoginCtrl_CheckNumNEngKeys(onlynum) //숫자, 영문만 입력가능, 아이디체크에 사용
{    
    if(event.keyCode==9 || event.keyCode==8)
	{
		return;
	}
	if(!onlynum)
	{
		if(!(event.keyCode >= 97 && event.keyCode <= 122) && !(event.keyCode >=65 && event.keyCode <=90) && !(event.keyCode >= 48 && event.keyCode <= 57))
		{ 
			event.keyCode=0; 
		}
    }
    else
    {
		if(!(event.keyCode >= 48 && event.keyCode <= 57))
		{ 
			event.keyCode=0; 
		}
    }
}
function tempLoginCtrl_entercheck_form(ftype) {
	if(event.keyCode ==13) 
	{
		if(ftype==1)
	   { 
		  tempLoginCtrl_OnLogIn();
	     
	   } 
	   else
	   {
			tempLoginCtrl_OnAnonymousLogIn();
	   }
   }
}
function tempLoginCtrl_ShowCtrl()
{
	var ctrl=document.getElementById("tempLoginCtrl_t");
	document.getElementById("tempLoginCtrl_UserName").value = "";
	document.getElementById("tempLoginCtrl_RRGNo1").value = "";
	document.getElementById("tempLoginCtrl_RRGNo2").value = "";
	document.getElementById("tempLoginCtrl_userid").value = "";
	document.getElementById("tempLoginCtrl_userpw").value = "";
	OpenCurtain();
	var  pWidth = 930;
	var  pHeight = $(window).height() * 0.9;
	
	if(document.body.scrollTop==0){	scrollTop=document.documentElement.scrollTop	}else{	scrollTop=document.body.scrollTop	}

	divPopUpstyletop=scrollTop+30+ ($(window).height() - pHeight)/2


	tempLoginCtrl_ttop=scrollTop+30+ ($(window).height() - pHeight)/2
	tempLoginCtrl_t.style.top = tempLoginCtrl_ttop+"px";
	
	tempLoginCtrl_tleft = document.body.clientWidth/2-pWidth/2;
	tempLoginCtrl_t.style.left = tempLoginCtrl_tleft+"px";

	tempLoginCtrl_t.style.zIndex=10000;
	tempLoginCtrl_t.style.display = "";
	
	//alert(tempLoginCtrl_t.style.top);
}
function LogInAPICallBackDone()
{


	var turl="http://www.hoteljava.co.kr/common/AJAXLib/AJAX_LoginCheck.asp";

	tempLoginCtrl_ajaxCore.ModuleReset();
	var retval=tempLoginCtrl_ajaxCore.SendXmlhttp(turl, 1, "", null);
	

	if(retval=="LOGIN")
	{
	
		alert("로그인이 정상처리되었습니다.\n해당 예약버튼을 다시한번 눌러주세요.")
	}
	else
	{
		alert("로그인이 실패되었습니다.\n다시시도해주세요.")
	}
		
   
   

	tempLoginCtrl_t.style.display = "none";

	CloseCurtain();
}
function tempLoginCtrl_HideCtrl(retval)
{
	//tempLoginCtrl_MsgLayer.ShowLayer(false);
	//tempLoginCtrl.style.display="none";

	//var turl="/common/AJAXLib/AJAX_GetLoginStatus.asp";
	//tempLoginCtrl_ajaxCore.ModuleReset();
	//var xretval=tempLoginCtrl_ajaxCore.SendXmlhttp(turl, 1, "", null);
	//try{	
		//if(top.location==location)
		//{

			//INCTOP_ChangeLogInStatus(xretval);
		//}
		//else
		//{

			//parent.INCTOP_ChangeLogInStatus(xretval);
		//}
	//}catch(e)
	//{
	//}

	//EndLoginProc(retval);

	LoginAfterParam1=null;
	LoginAfterParam2=null;
	LoginAfterCallBack=null;
	if(retval=="OK"){
	alert("로그인이 정상처리되었습니다.\n해당 예약버튼을 다시한번 눌러주세요.")

	}
	tempLoginCtrl_t.style.display = "none";

	CloseCurtain();

}
function EndLoginProc(retval)
{


	if(retval=="OK")
	{

		var param1=LoginAfterParam1;	
		var param2=LoginAfterParam2;

		LoginAfterParam1=null;
		LoginAfterParam2=null;
	
		var xfunc=LoginAfterCallBack;

		LoginAfterCallBack=null;

		if(xfunc!=null)
		{
			xfunc(param1, param2);

		}
	}

}
function ResetLogInForm(pKind)
{
    switch(pKind)
    {
        case "MEMBER" :
        {
            document.getElementById("tempLoginCtrl_userid").value = "";
            document.getElementById("tempLoginCtrl_userpw").value = "";
            break;
        }
        case "GROCKLE" :
        {
            document.getElementById("tempLoginCtrl_UserName").value = "";
            document.getElementById("tempLoginCtrl_RRGNo1").value = "";
            document.getElementById("tempLoginCtrl_RRGNo2").value = "";
            break;
        }
    }
}

function CheckLength()
{
    var pRRGNo = document.getElementById("tempLoginCtrl_RRGNo1").value;
    
    if(pRRGNo.length==6)
    {
        document.getElementById("tempLoginCtrl_RRGNo2").focus();
    }
}

function OnEndCheckRN(pVal)
{    
    if(pVal=="1")
    {
        tempLoginCtrl_OnAnonymousLogIn();
    } else {     
        document.getElementById("tempLoginCtrl_UserName").readOnly = false;
	    document.getElementById("tempLoginCtrl_RRGNo1").readOnly = false;
	    document.getElementById("tempLoginCtrl_RRGNo2").readOnly = false;
    }
}

function oldLogIn()
{
    document.getElementById("RRGNoField").style.display="inline";
    document.getElementById("MobileNoField").style.display="none";
    document.getElementById("EmailField").style.display="none";
    document.getElementById("OldLogInButton").style.display="none";

    document.getElementById("tempLoginCtrl_LogInType").value = "OLD";
}
</script>

<div id="tempLoginCtrl_t"  name="tempLoginCtrl_t" style=" display:none;position: absolute; height:670px; z-index:10000; overflow:hidden"  >	
	            <div style=" position:relative; width:930px;height:50px;">					
					
				 				
						<div   style=" float:right; width:20px;height:30px;">				
						<div style=" position:absolute; top:50px;  width:20px; padding-left:5px; height:30px; line-height:30px; z-index:10001;  background-color:#448cca; color:#FFFFFF; font-size:22px; cursor:pointer;" onClick="javascript:tempLoginCtrl_HideCtrl('CANCEL')">X</div>	
                        </div>	
							   
					
				</div>
		
    <div  style="width:930px; height:790;float:left;" class="BookingBox" >
	    <div style=" float:right; width:870px; margin-top:30px; margin-bottom:30px; margin-right:25px">
		
			<!-- 로그인  S -->
			<div style=" float:right; width:400px; padding:20px;">
			
				<!-- 회원로그인  S -->
	
				<div>
					<div style="border-bottom:solid 1px #969696; margin-top:-20px; padding-left:15px; padding-bottom:15px;">
                    	<div style="float:left; font-size:14px; font-weight:600;">회원로그인</div>
                    	<div style=" float:right; padding-left:20px;">
							<span style="cursor:pointer; margin-top:10px;" onClick="javascript:gotoMenu('000002');">회원가입하기</span>
							<span style="cursor:pointer; margin-top:10px; margin-left:20px;" onClick="javascript:gotoMenu('000003');">아이디/비밀번호찾기</span>									
                        </div>
                        <div style="clear:both;"></div>
                    </div>
					<div style=" margin-top:10px;">
						<div style=" float:left; width:80px; padding-left:20px; height:34px; line-height:34px;" class="ContentsTitle">아이디</div><div style=" float:left;">
						<input name="tempLoginCtrl_userid" id="tempLoginCtrl_userid" type="text" class="input" style="width: 200px; ime-mode: disabled;" onkeypress="javascript:tempLoginCtrl_CheckNumNEngKeys(false);"  maxlength="20"></div>
						<div style="clear:both;"></div>
                        <div style="margin-top:10px; padding-top:10px; border-top:dotted 1px #cccccc;"></div>
						<div style=" float:left; width:80px; padding-left:20px; height:34px; line-height:34px;" class="ContentsTitle">비밀번호</div><div style=" float:left;">
						<input name="tempLoginCtrl_userpw" id="tempLoginCtrl_userpw" type="password" class="input" style="width: 200px; ime-mode: disabled;" maxlength="12" onkeydown="tempLoginCtrl_entercheck_form(1);">
						</div>
						<div style="clear:both;"></div>
                        <div style="margin-top:10px; padding-top:10px; border-top:dotted 1px #cccccc;"></div>
                        
						<div style=" margin-left:100px;"><button type="button" class="buttonNormal" style="width:200px; height:34px;" onClick="javascript:tempLoginCtrl_OnLogIn();return false;">로그인</button></div>
                        <div style="clear:both;"></div>
                       
					</div>
					<div style="clear:both;"></div>
				</div>
		
				<!-- 회원로그인  E -->
				
				<!-- 비회원로그인  S -->
			
				<div style="margin-top:30px;">
				    <input type="hidden" name="tempLoginCtrl_LogInType" id="tempLoginCtrl_LogInType" value="NEW" />
					<div style="border-bottom:solid 1px #969696; padding-left:15px; padding-bottom:15px; font-size:14px; font-weight:600;">비회원예약 및 예약확인</div>
					<div style=" margin-top:10px;">					
						  <div style="margin-top:10px;" id="MobileNoField">
							<div style=" float:left; padding-left:20px; width:80px; height:34px; line-height:34px;" class="ContentsTitle">성명(실명)</div>
							<div style=" float:left;" >
								<input name="tempLoginCtrl_UserName" id="tempLoginCtrl_UserName" type="text" class="input" style="width: 200px; ">
							</div>
						</div>	
                        
						<div style="clear:both;"></div>
                        <div style="margin-top:10px; padding-top:10px; border-top:dotted 1px #cccccc;"></div>
                        
						<div style="display:none">
						<input name="tempLoginCtrl_RRGNo1" id="tempLoginCtrl_RRGNo1" type="text" class="input" style="width: 48%;ime-mode:disabled;" size="4" maxlength="6" onkeypress="javascript:KeyPress_Filter('[0-9]');"  onkeyup="javascript:CheckLength();" style="ime-mode:disabled;" />-<input name="tempLoginCtrl_RRGNo2" id="tempLoginCtrl_RRGNo2" type="password" class="input" style="width: 48%;" size="4" maxlength="7" onkeypress="javascript:KeyPress_Filter('[0-9]');" />
						</div><div style="clear:both;"></div>
						<div id="MobileNoField">
							<div style=" float:left; padding-left:20px; width:80px; height:34px; line-height:34px;" class="ContentsTitle">휴대폰</div>
							<div style=" float:left;" >																				
								<span>		  <select name="tempLoginCtrl_FirstMobileNo" id="tempLoginCtrl_FirstMobileNo" style=" width:70px">
                                                                                <option value="010" selected>010</option>
                                                                                <option value="011">011</option>
                                                                                <option value="016">016</option>
                                                                                <option value="017">017</option>
                                                                                <option value="018">018</option>
                                                                                <option value="019">019</option>
                                                                            </select></span>
								<span>-</span>
								<span><input id="tempLoginCtrl_SecondMobileNo" name="tempLoginCtrl_SecondMobileNo" type="text" class="input" style="width: 70px; ime-mode: disabled" maxlength="4" onkeypress="javascript:KeyPress_Filter('[0-9]');"> 
								</span>
								<span>-</span>
								<span><input id="tempLoginCtrl_ThirdMobileNo" name="tempLoginCtrl_ThirdMobileNo" type="text" class="input" style="width: 70px; ime-mode: disabled"
                                                                                maxlength="4" onkeypress="javascript:KeyPress_Filter('[0-9]');"></span>
							</div>
						</div>
                        
                        <div style="clear:both;"></div>
                        <div style="margin-top:10px; padding-top:10px; border-top:dotted 1px #cccccc;"></div>
                        			
						<div id="EmailField">
							<div style=" float:left; padding-left:20px; width:80px; height:34px; line-height:34px;" class="ContentsTitle">이메일</div>
							<div style=" float:left;">
								<span> <input name="tempLoginCtrl_FirstEmail" id="tempLoginCtrl_FirstEmail" type="text" class="input" style="width: 100px; ime-mode: disabled" onKeyUp="this.value=this.value.toLowerCase();"/></span>
								<span>@</span>
								<span><input name="tempLoginCtrl_LastEmail" id="tempLoginCtrl_LastEmail" type="text" class="input" style="width: 140px; ime-mode: disabled" onKeyUp="this.value=this.value.toLowerCase();"/></span>
							</div>
							<div style="clear:both;"></div>
						</div>

						<div style="clear:both;"></div>
                        <div style="margin-top:10px; padding-top:10px; border-top:dotted 1px #cccccc;"></div>
						<div style=" margin-left:100px;"><button type="button" class="buttonNormal" style="width:200px; height:34px;" onClick="tempLoginCtrl_OnAnonymousLogIn();return false;">비회원 로그인 / 예약확인</button></div>

					</div>
				</div>
			
				<!-- 비회원로그인  E -->
                
                <!-- 비회원로그인  E -->
                
                
                    <!-- 외부 로그인  S -->
                    <div style=" margin-top:30px;">
                    	
                        <div style=" float:left; border:solid 1px #969696; border-radius: 3px; width:105px; padding:10px;">
                        	<div style="float:left; width:25px;"> <a href="http://www.hoteljava.co.kr/member/LoginOtherAPI.asp?APIType=N&LType=P"  onClick="window.open('/member/LoginOtherAPI.asp?APIType=N&LType=P', 'naverloginpop', 'titlebar=1, resizable=1, scrollbars=yes, width=450, height=530'); return false" target="_blank"><img src="http://www.hoteljava.co.kr/images/contents/icon_naver.png" width="20" height="20" /></a></div>
                            <div style="float:left;"> <a href="http://www.hoteljava.co.kr/member/LoginOtherAPI.asp?APIType=N&LType=P"  onClick="window.open('http://www.hoteljava.co.kr/member/LoginOtherAPI.asp?APIType=N&LType=P', 'naverloginpop', 'titlebar=1, resizable=1, scrollbars=yes, width=450, height=530'); return false" target="_blank">네이버 로그인</a></div>
                            <div style="clear:both;"></div>
                        </div>
                        
                        <div style=" float:left;  margin-left:5px; border:solid 1px #969696; border-radius: 3px; width:105px; padding:10px;">
                        	<div style="float:left; width:25px;"><a href="http://www.hoteljava.co.kr/member/LoginOtherAPI.asp?APIType=G&LType=P"   onClick="window.open('/member/LoginOtherAPI.asp?APIType=G&LType=P', 'naverloginpop', 'titlebar=1, resizable=1, scrollbars=yes, width=450, height=530'); return false"  target="_blank"><img src="http://www.hoteljava.co.kr/images/contents/icon_google.png" width="20" height="20" /></a></div>
                            <div style="float:left;"><a href="http://www.hoteljava.co.kr/member/LoginOtherAPI.asp?APIType=G&LType=P"   onClick="window.open('http://www.hoteljava.co.kr/member/LoginOtherAPI.asp?APIType=G&LType=P', 'naverloginpop', 'titlebar=1, resizable=1, scrollbars=yes, width=450, height=530'); return false"  target="_blank">구글 로그인</a></div>
                            <div style="clear:both;"></div>
                        </div>
                        
                        <div style=" float:left;  margin-left:5px; border:solid 1px #969696; border-radius: 3px; width:105px; padding:10px;">
                        	<div style="float:left; width:25px;"><a href="http://www.hoteljava.co.kr/member/LoginOtherAPI.asp?APIType=F&LType=P"   onClick="window.open('/member/LoginOtherAPI.asp?APIType=F&LType=P', 'naverloginpop', 'titlebar=1, resizable=1, scrollbars=yes, width=450, height=530'); return false"  target="_blank"><img src="http://www.hoteljava.co.kr/images/contents/icon_facebook2.png" width="20" height="20" /></a></div>
                            <div style="float:left;"><a href="http://www.hoteljava.co.kr/member/LoginOtherAPI.asp?APIType=F&LType=P"   onClick="window.open('http://www.hoteljava.co.kr/member/LoginOtherAPI.asp?APIType=F&LType=P', 'naverloginpop', 'titlebar=1, resizable=1, scrollbars=yes, width=450, height=530'); return false"  target="_blank">페이스북로그인</a></div>
                            <div style="clear:both;"></div>
                        </div>
                        
                        
                        <div style="clear:both;"></div>

					</div>
                    <!-- 외부 로그인  E -->
				
			</div>
			<!-- 로그인  E -->
			
			<!-- 홍보 회원특전  S -->
			<div style=" float:left; width:400px;">
				<div style="padding:15px; border:dotted 1px #CCC; ">
                	<div style=" float:left; color:#333; font-weight:600; font-size:18px;"><img src="http://www.hoteljava.co.kr/images/contents/ico_noti.png" height="30" align="absmiddle" />&nbsp;&nbsp;호텔자바 회원특전!!</div>
                    <div style=" float:right; margin-top:5px;">
                    	<span style=" cursor:pointer; font-weight:600;" class="buttonGreen" onClick="javascript:gotoMenu('000002');">회원가입하기</span>
                    </div>
                    <div style="clear:both;"></div>
                </div>
                
                <div style="margin:10px;">
                
                  <div style="font-size:16px; margin-top:20px;"><span class="fontcolorBlue">혜택1.</span> 회원가입시 <span style="color:#db2027;">3,000포인트</span> 지급</div>
                  <div class="fontcolorGray">회원가입시 현금처럼 바로사용 가능한 3,000포인트를 드립니다.</div>
                  <div style="font-size:16px; margin-top:20px;"><span class="fontcolorBlue">혜택2.</span> 리뷰쓰기 선약속시<span style="color:#db2027;"> 1% 할인</span></div>
                    <div class="fontcolorGray">회원가입 후 예약시 리뷰쓰기 약속만 하셔도 1%를 바로 할인해 드립니다.</div>
                    
                    <div style="font-size:16px; margin-top:20px;"><span class="fontcolorBlue">혜택3.</span> 예약금액의 <span style="color:#db2027;">1%를  포인트</span>로 적립</div>
                    <div class="fontcolorGray">회원가입 후 예약을 하시면 결제금액의 1%가 포인트로 적립 됩니다. </div>
                    
                    <div style="font-size:16px; margin-top:20px;"><span class="fontcolorBlue">혜택4.</span> 누적 실적에 따른 <span style="color:#db2027;">회원 등급제</span></div>
                    <div class="fontcolorGray">누적 이용 금액(횟수)에 따라  최고 2% 추가 할인 적용이 가능합니다.</div>
                    <div style="font-size:16px; margin-top:20px;"><span class="fontcolorBlue">혜택5.</span> 계좌이체 결제시 <span style="color:#db2027;">추가 1% 할인</span></div>
                    <div class="fontcolorGray">계좌이체 결제시 1%를 또 할인해 드립니다.(비회원도 혜택가능)</div>
                </div>
				
                <div style=" background-image:url(/images/contents/bg_gray_line.gif); padding:15px;  margin-top:20px;">
                	<li style="font-weight:600; color:#333; line-height:1.5;">호텔자바는 2006년 사업자(법인명:트래블베이(주))와 여행업을 등록하고 보증보험에 정식 가입한 대한민국의 법인등록기업 입니다.</li>

					<li style="line-height:1.5; margin-top:10px;" class="fontcolorGray">여러분이 많이 알고 있는 대부분의 호텔예약사이트가 한국에는 사업자등록증도 내지 않고 고객센터 또한 준비 되지 않은 채 홍보에만 투자를 하여 예약만 늘려가는 외국계 업체들 입니다. 한국에서는 세금 조차 제대로 내지 않으며 고객의 불만에 대해 나몰라라 하여 소비자에게 많은 원성을 사고 있습니다. 한번 만 더 생각하시면 호텔자바가 길입니다. <a href="/introduction/why.asp" style="font-weight:600;" target="_blank">더보기&gt;&gt;</a>
                    </li>
				</div>
				
			</div>
			<!-- 홍보 회원특전  E -->

			
		</div>

                                          
	</div>  
</div>    

<form>
    <input type="hidden" name="UserName" id="UserName" value=""/>
    <input type="hidden" name="RRGNo1" id="RRGNo1" value=""/>
    <input type="hidden" name="RRGNo2" id="RRGNo2" value=""/>
</form>
<script type="text/javascript" src="http://www.hoteljava.co.kr/common/js/nineMessageLayer.js"></script>
<script type="text/javascript" language="javascript">
 //var CommonReserveCtrl_ajaxCore=new nineAJAX("CommonReserveCtrl_ajaxCore");
 var CommonReserveCtrl_MsgLayer=new nineMessageLayer("CommonReserveCtrl_MsgLayer", "");
 
CommonReserveCtrl_MsgLayer.bgColor="#000000";
CommonReserveCtrl_MsgLayer.notOnLoad=true;
CommonReserveCtrl_MsgLayer.Render("");
CommonReserveCtrl_MsgLayer.OnContentLoad=function (objID)
{
	try{
	var tSize=eval(objID+"_frame.GetDocumentSize()");
	document.getElementById(objID+"_frame").style.width=tSize.width;
	document.getElementById(objID+"_frame").style.height=tSize.height;
	eval(objID+".UpdateSize();");
	}catch(e)
	{
	}
	
}
function CommonReserveCtrl_ShowPaymentResult(payindex)
{
	//window.open("/payment/PaymentResult.asp?payindex="+payindex);
	
	CommonReserveCtrl_MsgLayer.ShowFrameLayerForIFRM("/payment/PaymentResult.asp?payindex="+payindex, 776, null, document.body);
	document.getElementById("CommonReserveCtrl_MsgLayer").style.zIndex="1100";
	document.getElementById("CommonReserveCtrl_MsgLayer_main").style.zIndex="1101";
}
function CommonReserveCtrl_ShowInvoice(rindex)
{
	window.open("/common/core/PrintContainer.asp?title=Invoice&maincontent="+escape("/reservation/reservation_Invoice.asp?rindex="+rindex),"invoice"+rindex,"width=673,height=670, scrollbars=no,resizable=yes");
}
function CommonReserveCtrl_ShowVoucher(rindex)
{
	
	//window.open("/reservation/reservation_Invoice.asp?rindex="+rindex);
	window.open("/common/core/PrintContainer.asp?title=voucher&maincontent="+escape("/reservation/reservation_voucher.asp?rindex="+rindex),"invoice"+rindex,"width=673,height=670, scrollbars=no,resizable=yes");
}
function CommonReserveCtrl_ShowPayment(rindex, paymethod)
{
	//window.open("/payment/PaymentStep01.asp?rindex="+rindex);
	/*
	var turl="/payment/PaymentStep01.asp?rindex="+rindex;
	if(paymethod!="")
	{
		turl+="&paymethod="+paymethod;
	}
	CommonReserveCtrl_MsgLayer.ShowFrameLayerForIFRM(turl, 776, null, document.body);
	document.getElementById("CommonReserveCtrl_MsgLayer").style.zIndex="1100";
	document.getElementById("CommonReserveCtrl_MsgLayer_main").style.zIndex="1101";
	*/
	CommonReserveCtrl_ShowReservation(0, rindex);
}
function CommonReserveCtrl_ShowReservation(hindex, rindex)
{
	//window.open("/myinfo/my_reservationdetail.asp?hindex="+hindex+"&rindex="+rindex);
	//OpenLoading("로딩중입니다.");
	OpenPopUpLayer2("RESERVATION", "/myinfo/my_reservationdetail.asp?hindex="+hindex+"&rindex="+rindex,"");
	//CommonReserveCtrl_MsgLayer.ShowFrameLayerForIFRM("/myinfo/my_reservationdetail.asp?hindex="+hindex+"&rindex="+rindex, 776, null, document.body);

	//document.getElementById("CommonReserveCtrl_MsgLayer").style.zIndex="1100";
	//document.getElementById("CommonReserveCtrl_MsgLayer_main").style.zIndex="1101";
}
function CommonReserveCtrl_ShowReservation_ForStep02(hindex, rindex)
{
	alert("ForStep02")
	//window.open("/myinfo/my_reservationdetail.asp?hindex="+hindex+"&rindex="+rindex);
	//OpenLoading("로딩중입니다.");
	OpenPopUpLayer("RESERVATION", "/myinfo/my_reservationdetail.asp?rt=im&hindex="+hindex+"&rindex="+rindex,"");
	
	//CommonReserveCtrl_MsgLayer.ShowFrameLayerForIFRM("/myinfo/my_reservationdetail.asp?hindex="+hindex+"&rindex="+rindex, 776, null, document.body);

	//document.getElementById("CommonReserveCtrl_MsgLayer").style.zIndex="1100";
	//document.getElementById("CommonReserveCtrl_MsgLayer_main").style.zIndex="1101";
}
function CommonReserveCtrl_ShowCtrl(hindex, rindex)
{
	//window.open("/reservation/reservation_step01.asp?hindex="+hindex+"&rindex="+rindex);
	//OpenLoading("로딩중입니다.");
	//window.open("/reservation/reservation_step00.asp?hindex="+hindex+"&rindex="+rindex);
	OpenPopUpLayer("RESERVATION", "/reservation/reservation_step00.asp?hindex="+hindex+"&rindex="+rindex,"");
	return;
	CommonReserveCtrl_MsgLayer.ShowFrameLayerForIFRM("/reservation/reservation_step01.asp?hindex="+hindex+"&rindex="+rindex, 776, null, document.body);
	document.getElementById("CommonReserveCtrl_MsgLayer").style.zIndex="1100";
	document.getElementById("CommonReserveCtrl_MsgLayer_main").style.zIndex="1101";
}
function CommonReserveCtrl_ShowCtrl2(hindex, rindex, xurl)
{
	CommonReserveCtrl_ShowCtrl3(hindex, rindex, xurl, true);
}
function CommonReserveCtrl_ShowCtrl3(hindex, rindex, xurl, bconfirm)
{

	//alert(rindex+"/"+hindex+"/"+xurl+"/"+bconfirm)
	
	
	if(!bconfirm)
	{
		//alert("이 객실은 12시간내회신으로 호텔에서 객실 가능 여부를 회신줄 때까지 기다리셔야 합니다!\n\n특히 금 오후5시 ~ 일요일의 12시간내회신은 월요일 이후에 결과를 받게 됩니다.(주로 아시아 외 호텔들).\n\n오렌지색 '확정' 예약을 선택하여 대기 시간을 없애시기 바랍니다!");
		//alert("본 예약은 12시간내회신입니다. 성수기에는 예약 확정이 안 될 수 있습니다.\n\n12시간내회신은 호텔에서 객실가능여부를 회신줄 때까지 기다려야 합니다.\n특히 금요일 오후 5시 ~ 일요일의 12시간내회신은 월요일 이후 결과를 받게됩니다.\n\n오렌지색 \"확정\" 예약을 선택하시면, 대기 없이 즉시 예약이 확정됩니다.");
		if(!confirm("본 예약은 12시간내회신입니다.\n접수 이후 룸이 가능할 경우 확정예약으로 전환되며 확정전까지는 객실이 확보된것이 아닙니다. \n\n평일 업무일, 업무시간 내 기준 평균 12시간내 가능여부 회신(문자,이메일)을 드리며 휴일의 경우 돌아오는 업무일에 체크됩니다. \n\n12시간내회신을 진행하시려면 아래 \"확인\" 버튼을 클릭해주세요."))
		{
			return;
		}
	}
	//window.open("/reservation/reservation_step01.asp?hindex="+hindex+"&rindex="+rindex);
	//OpenLoading("로딩중입니다.");
	//window.open("/reservation/reservation_step00.asp?hindex="+hindex+"&rindex="+rindex+"&queryinfo="+escape(xurl));
	// 
	//location.href="/reservation/reservation_step00.asp?hindex="+hindex+"&rindex="+rindex+"&queryinfo="+escape(xurl)
	//OpenPopUpLayer2("RESERVATION", "/reservation/reservation_step00.asp?hindex="+hindex+"&rindex="+rindex+"&queryinfo="+escape(xurl),"");
	    document.getElementById("Nrindex").value=rindex;
		document.getElementById("Nhindex").value=hindex;
		//document.FReStep0.target="IfFReStep0"
		document.FReStep0.action="/reservation/reservation_step00.asp"
	  	document.FReStep0.submit();
		
		

	
}
function CommonReserveCtrl_HideCtrl(code)
{
	CommonReserveCtrl_MsgLayer.FrameLoadCode=code;
	CommonReserveCtrl_MsgLayer.ShowLayer(false);
	
}
function CommonReserveCtrl_Load()
{
	document.getElementById("CommonReserveCtrl_MsgLayer_frame").style.height=10;
	window.setTimeout("CommonReserveCtrl_MsgLayer.OnContentLoad('CommonReserveCtrl_MsgLayer')", 100);
	
	
}
function ShowHotelDetails(pVal)
{
	OpenPopUpLayer("HOTELDETAIL","/Search/IF_HotelDetailMainNew.asp?HBIndex=" + pVal,"");
}
function ShowHotelDetailsAndMove(pVal, pTab)
{
	OpenPopUpLayer("HOTELDETAIL","/Search/IF_HotelDetailMainNew.asp?ActionType=W&HBIndex=" + pVal +"&DetailIndex="+pTab,"");
}

</script>

	<iframe src="http://www.hoteljava.co.kr/blank.html" name="IfFReStep0" id="IfFReStep0" frameborder="0"		style="width:0px; height:0px;" scrolling="no"></iframe>

<form id="FReStep0" name="FReStep0"  method="post" target="_blank">
<input type="hidden" id="Nrindex" name="Nrindex"  />
<input type="hidden" id="Nhindex" name="Nhindex" />
<input type="hidden" id="NsDestination_type" name="NsDestination_type"  />
<input type="hidden" id="NsDestination_value" name="NsDestination_value" />
<input type="hidden" id="NsDestination_loc_value" name="NsDestination_loc_value" />
<input type="hidden" id="NCheckIn" name="NCheckIn" />
<input type="hidden" id="NCheckOut" name="NCheckOut"  />
<input type="hidden" id="NNights" name="NNights" />
<input type="hidden" id="NroomTypeOrg1" name="NroomTypeOrg1" />
<input type="hidden" id="NroomCountOrg1" name="NroomCountOrg1"  />
<input type="hidden" id="NroomTypeOrg2" name="NroomTypeOrg2"  />
<input type="hidden" id="NroomCountOrg2" name="NroomCountOrg2"  />
<input type="hidden" id="NroomTypeOrg3" name="NroomTypeOrg3"  />
<input type="hidden" id="NroomCountOrg3" name="NroomCountOrg3"  />

</form>
</body>
</html>
<script>
function scrollToAnchor(where){

 scrollY=$("#"+where).offset().top;
  $('html, body').animate({ scrollTop: scrollY }, 1000); 

}
</script>
<script>
function getTodayYoil(value){

var year=value.substring(0,4);
var month=value.substring(5,7);

var day=value.substring(8,10);

var newDate=new Date(year,month-1,day)

var Yoil="";
	switch(newDate.getDay()){
		case 0 :
		Yoil="일"
		break
		case 1 :
		Yoil="월"
		break
		case 2 :
		Yoil="화"
		break
		case 3 :
		Yoil="수"
		break
		case 4 :
		Yoil="목"
		break
		case 5 :
		Yoil="금"
		break
		case 6 :
		Yoil="토"
		break
	
	}

return Yoil;


}
function PrepareSearchPopup(SearchResultIndex,HBIndex)
{

	var obj=document.getElementById("F_HotelListPrice_"+HBIndex)
	var roomTypeQuery="";
	var RoomTypeArray=new Array();
	var CountArray=new Array();
	var fidx=-1;
	var MaxCount=9;
	var MaxRoomCount=9;
	ht_miniCurSearchOption="";
	
	if(obj.sDestination_value.value=="")
	{
		alert("목적지를 선택해 주세요.");
		return "";
	}
	
	ht_miniCurSearchOption=obj.ht_CheckIn.value;
	ht_miniCurSearchOption+=" ~ ";
	ht_miniCurSearchOption+=obj.ht_CheckOut.value;
	ht_miniCurSearchOption+=" (";
	ht_miniCurSearchOption+=obj.ht_Nights.options[obj.ht_Nights.selectedIndex].innerHTML;
	ht_miniCurSearchOption+=") | ";
	var troomtypes="";

	for(var i=1;i<=3;i++)
	{


	    if(obj.elements["ht_roomCountOrg"+i].value=="")
	    {
	        obj.elements["ht_roomTypeOrg"+i].selectedIndex = 0;
	    }
	    
		var code=obj.elements["ht_roomTypeOrg"+i].value;
		if(code!="")
		{
			fidx=-1;
			for(var j=0;j<RoomTypeArray.length;j++)
			{
				if(RoomTypeArray[j]==code)
				{
					fidx=j;
					break;
				}
			}
			if(fidx==-1)
			{
				var tidx=RoomTypeArray.length;
				RoomTypeArray[tidx]=code;
				
				CountArray[tidx]=0;
				fidx=tidx;
			
			}
			if(obj.elements["ht_roomCountOrg"+i].value=="")
			{
				alert(obj.elements["ht_roomTypeOrg"+i].options[obj.elements["ht_roomTypeOrg"+i].selectedIndex].innerHTML+"에 객실수를 지정하지 않았습니다.");
				return "";
			}
			CountArray[fidx]+=parseInt(obj.elements["ht_roomCountOrg"+i].value, 10);
			if(troomtypes!="")
				troomtypes+=", ";
			troomtypes+=obj.elements["ht_roomTypeOrg"+i].options[obj.elements["ht_roomTypeOrg"+i].selectedIndex].innerHTML;
			troomtypes+=" ";
			troomtypes+=obj.elements["ht_roomCountOrg"+i].options[obj.elements["ht_roomCountOrg"+i].selectedIndex].innerHTML;
			
			
		}
	}
	ht_miniCurSearchOption+=troomtypes;

	var totalCount=0;
	var totalRoomCount=0;
	sm_roomTypeQuery="<ROOMTYPES>";
	for(i=0;i<RoomTypeArray.length;i++)
	{
		totalCount+=(GetPersonCountByRoomType(RoomTypeArray[i])*CountArray[i]);
		if(totalCount>MaxCount)
		{
			alert("최대 예약 가능 숙박객 수는 "+MaxCount+"입니다.");
			return "";
		}
		totalRoomCount+=CountArray[i];
		if(totalRoomCount>MaxRoomCount)
		{
			alert("최대 예약 가능 객실 수는 "+MaxRoomCount+"입니다.");
			return "";
		}
		sm_roomTypeQuery+="<ROOM CODE=\""+RoomTypeArray[i]+"\" COUNT=\""+CountArray[i]+"\" />"
		
	}
	sm_roomTypeQuery+="</ROOMTYPES>";
	
	var turl="/common/AJAXLib/AJAX_SearchHotelPrepare.asp?UpdateSession=N&QBaseIndex="+obj.sDestination_value.value;
	turl+=("&QCheckInDate="+obj.ht_CheckIn.value);
	turl+=("&QCheckOutDate="+obj.ht_CheckOut.value);
	turl+=("&QRoomTypeQuery="+escape(sm_roomTypeQuery));
	turl+=("&QLocationIndex=");
	turl+="&QHBIndex=0";
	
	

		return turl;
}
function OnSearchHotelPopup(HBIndex)
{
var obj=document.getElementById("F_HotelListPrice_"+HBIndex)


var roomTypeQuery="";
	var RoomTypeArray=new Array();
	var CountArray=new Array();
	var fidx=-1;
	var MaxCount=9;
	var MaxRoomCount=9;


	var turl=PrepareSearchPopup(null,HBIndex);

	if (fGetToday()==obj.ht_CheckIn.value)
	{
		alert("주의!!\n당일 체크인 예약은 변경, 취소, 환불 불가!!!");
	}
	
	
	var dateval=obj.ht_CheckIn.value+" 15:00:00";
	var dateyear = dateval.substring(0, 4);
	var datemonth = dateval.substring(5, 7);
	var dateday = dateval.substring(8, 10);
	var datehour = dateval.substring(11, 13);
	var dateminute = dateval.substring(14, 16);
	var datesecond = dateval.substring(17, 19);
	
	dateval = new Date(dateyear, parseInt(datemonth,10)-1, dateday, datehour, dateminute, datesecond);
	if(dateval<=(new Date()))
	{
		alert("당일예약은 오후 3시 이후 가능하지 않습니다.");
		return;
	}
	
	//alert(turl);
	
	//document.getElementById("minisearchctrl").parentNode.style.display="none";
	for(var i=1;i<=3;i++)
	{
	    if(obj.elements["ht_roomCountOrg"+i].value=="")
	    {
	       obj.elements["ht_roomTypeOrg"+i].selectedIndex = 0;
	    }
	    
		var code=obj.elements["ht_roomTypeOrg"+i].value;
		if(code!="")
		{   
		    
			fidx=-1;
			for(var j=0;j<RoomTypeArray.length;j++)
			{
				if(RoomTypeArray[j]==code)
				{
					fidx=j;
					break;
				}
			}
			if(fidx==-1)
			{
				var tidx=RoomTypeArray.length;
				RoomTypeArray[tidx]=code;
				
				CountArray[tidx]=0;
				fidx=tidx;
			
			}
			if(obj.elements["ht_roomCountOrg"+i].value=="")
			{
				alert(obj.elements["ht_roomTypeOrg"+i].options[obj.elements["ht_roomTypeOrg"+i].selectedIndex].innerHTML+"에 객실수를 지정하지 않았습니다.");
				return "";
			}
			CountArray[fidx]+=parseInt(obj.elements["ht_roomCountOrg"+i].value, 10);
								
		}
	}
	
	/*roomTypeQuerySearch=""
	for(i=0;i<RoomTypeArray.length;i++)
	{
	
		if(i==0){
		roomTypeQuerySearch+=getRoomTypeKE(RoomTypeArray[i])+" "+CountArray[i]+"개" 
		}else{
		roomTypeQuerySearch+="/"+getRoomTypeKE(RoomTypeArray[i])+" "+CountArray[i]+"개" 		
		}
	
	}*/

//alert (document.getElementById("sDestination_selection2").value+","+ document.getElementById("Nights").value+","+ roomTypeQuerySearch+","+  document.getElementById("CheckIn").value+","+  document.getElementById("CheckOut").value)

	retval=ajaxCore.SendXmlhttp(turl, 1, "", null);
	
	var oXmlDoc = ajaxCore.GetDOMFromXMLText(retval);
	
	if(oXmlDoc!=null)
	{
		var olist		=	oXmlDoc.getElementsByTagName("SEARCHPREPARE");
		if(olist.length==1)
		{
			if(olist.item(0).getAttribute("ERRORCODE")=="OK")
			{
				//gMsgLayer.RenderFromResourceToTarget("LOADING", document.body);
				//gMsgLayer.ShowLayer(true);
				
			
	
				
				
				
				
				var skey=olist.item(0).getAttribute("KEY");
				OpenBigLoading("");
			
				turl="/HJCoreService/SearchHotels.aspx?";
				turl+="mode=&SearchKey=";
				turl+=skey;
			
				ajaxCore.ModuleReset();
				retval=ajaxCore.SendXmlhttp(turl, 1, "OnSearchingEnd", skey);
			}
		}
	}
	
		
	inHTMLBT="";	
inHTMLBT+="<div class='MainColor fontLarge2'  style='font-weight:bold'>&nbsp;</div>";
inHTMLBT+="<div class='fontLarge2'  style='font-weight:bold'>"+document.getElementById("ht_Nights").value+"박 <span style='font-size:14px;font-weight:100;'>/</span> "+roomTypeQuerySearch.replace("/",",")+"</div>";
inHTMLBT+="<div class='fontLarge3' style='font-weight:600;'>"+document.getElementById("ht_CheckIn").value+"<span style='font-weight:100; font-size:16px;'>("+getTodayYoil(document.getElementById("ht_CheckIn").value)+")</span>~ "+document.getElementById("ht_CheckOut").value+"<span style='font-weight:100; font-size:16px;'>("+getTodayYoil(document.getElementById("ht_CheckOut").value)+")</span></div>";

		
	$("#DivOpenBigLoadingText").html(inHTMLBT)	
	//ajaxCore
	//HotelSearchForm.submit();


}

function OnSearchingEnd(tsuccess, retval, terrorcode, tcustparam)
{


	location.href="search_page_n4.asp?searchKey="+tcustparam+"&OnlyConfirm=N&searchOnlyConfirm=N";	

}
</script>