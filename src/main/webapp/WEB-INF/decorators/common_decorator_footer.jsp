<%@page import="com.lottejtb.comm.util.*"%>
<%@page import="java.util.HashMap" %>
<%@page import="com.lottejtb.main.service.MainService" %>
<%@page import="javax.annotation.Resource" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/commTagLib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko" ng-app="commApp">
<head>

	<title><decorator:title default="감동의 곁에, 언제나 롯데제이티비" /></title>
	
	<meta name="viewport" content="width=device-width, initial-scale=1,  user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
	<meta name="format-detection" content="telephone=no" />
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />

	<!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<script src="<c:url value='http://mdev.lottejtb.com:8085/resources/common/js/UserAgent.js' />"></script>    
	<link rel="stylesheet" type="text/css" href="http://mdev.lottejtb.com:8085/resources/common/css/jquery.mobile-1.4.5.min.css" />
	<link rel="stylesheet" type="text/css" href="http://mdev.lottejtb.com:8085/resources/common/css/swiper.min.css" />
	<link rel="stylesheet" type="text/css" href="http://mdev.lottejtb.com:8085/resources/common/css/common.css" />
	<link rel="stylesheet" type="text/css" href="http://mdev.lottejtb.com:8085/resources/common/css/common2.css" />

	<link rel="shortcut icon" type="image/x-icon" href="http://mdev.lottejtb.com:8085/resources/common/css/lottejtb.ico">
	
	<%
	String accessCheck = request.getHeader("X-Requested-With");
	%>
	<script>
	var accessType = "browser";
	var deviceInfo;
	var accessCheck = "<%=CommUtil.filterXSS(accessCheck)%>";
	var mstCustCd;
	
	var userAgent = window.navigator.userAgent.toLowerCase();
    var safari = /safari/.test(userAgent);
    var ios = /iphone|ipod|ipad/.test(userAgent);
    var android = /android/.test(userAgent);
    
	if(ios) {
    	if(!safari) {
    		accessType = "app";
    		document.write('<' + 'script src="http://mdev.lottejtb.com:8085/resources/cordova/ios/cordova.js"' + ' type="text/javascript"><' + '/script>');
    		document.write('<' + 'script src="http://mdev.lottejtb.com:8085/resources/common/js/native.js"' + ' type="text/javascript"><' + '/script>');
    	}
	}else if(android){
		if(accessCheck == 'com.lottejtb.mobile'){
			accessType = "app";
			document.write('<' + 'script src="http://mdev.lottejtb.com:8085/resources/cordova/android/cordova.js"' + ' type="text/javascript"><' + '/script>');
    		document.write('<' + 'script src="http://mdev.lottejtb.com:8085/resources/common/js/native.js"' + ' type="text/javascript"><' + '/script>');
		}
    };
	</script>
	
	<!-- 이렇게 함으로써 외부의 CDN 서버에서 가장 최신의 jQuery 배포판을 불러 올 수 있습니다. //-->
	<!-- <script src="http://code.jquery.com/jquery-latest.min.js"></script> --> 
	<script src="<c:url value='http://mdev.lottejtb.com:8085/resources/common/js/jquery-latest.min.js' />"></script> 
	<script src="<c:url value='http://mdev.lottejtb.com:8085/resources/common/js/jquery.mobile-1.4.5.min.js' />"></script>
	<script src="<c:url value='http://mdev.lottejtb.com:8085/resources/common/js/sqliteplugin.js' />"></script>
	<script src="<c:url value='http://mdev.lottejtb.com:8085/resources/common/js/common.js' />"></script>
	<script src="<c:url value='http://mdev.lottejtb.com:8085/resources/common/js/common2.js' />"></script>
	<script src="<c:url value='http://mdev.lottejtb.com:8085/resources/common/js/utils.js' />"></script>
	<script src="<c:url value='http://mdev.lottejtb.com:8085/resources/common/js/library/jquery.anchor.js' />"></script>
	<script src="<c:url value='http://mdev.lottejtb.com:8085/resources/common/js/swiper.js' />"></script>
	<script src="<c:url value='http://mdev.lottejtb.com:8085/resources/common/js/jquery.blockUI.js' />"></script>
	<script src="<c:url value='http://mdev.lottejtb.com:8085/resources/common/js/database.js' />"></script>
	<!--<script src="<c:url value='http://mdev.lottejtb.com:8085/resources/common/js/jquery-3.1.1.min.js' />"></script> -->
	
	<script>
	var topCtg;
	var mstCustCd;
	
	var httpPage = ['/event/', '/planning/', '/domestic/'];
	var httpsFlages = false;
	
	for(var x = 0; x < httpPage.length; x++){
		if(location.pathname.indexOf(httpPage[x]) > -1){
			httpsFlages = true;
			break;
		}
	}
	
	if(httpsFlages) {
		if(location.protocol == 'https:') {
			location.replace(location.href.replace('https://', 'http://'));
		}
	}
	/*
	var httpsPage = ['/sso/', '/mytour/', '/reserve/', '/account/', '/rsv/', '/free_reserve/', '/free/'];
	var httpFlages = false;
	
	for(var x = 0; x < httpsPage.length; x++){
		if(location.pathname.indexOf(httpsPage[x]) > -1){
			httpFlages = true;
			break;
		}
	}
	
	if(!httpFlages) {
		if(location.protocol == 'https:') {
			location.replace(location.href.replace('https://', 'http://'));
		}
	}
	*/
	
	$(document).ready(function(){
		/*
		if(accessType == "app"){
			$("#lnb_setting").show();
			
			if(ios){
				$("#foot").show();
				$("div[data-role=page]").css("padding-bottom", "52px");
				$(".go-top").addClass("go60");
			}else{
				$("#foot").hide();
			}
		}else{
			$("#foot").hide();
			$("#lnb_setting").hide();
			
			var appDownYN = getCookieValue('appDownYN');
			/*
			if(appDownYN != "Y"){
				$("body").addClass('appt_add');
			}
			
			$(".appt_downbox .appt_exit").off("click");
			$(".appt_downbox .appt_exit").on("click", function(){
				$(".appt_downbox").remove();
				$("body").removeClass("appt_add");
				setCookieValue('appDownYN', 'Y');
			});
			*/
		/*
		}
		*/

		//[JEH] 임시 -  자동로그인시 데이터 깨지는 현상으로 로그아웃 처리 - 20190723
		var autoLogin = window.localStorage.getItem("autoLogin");
		/*
		if(autoLogin == 'Y'){
			location.href = "/jsp/sso/loginOut.do";
		}
		*/
		
		if(location.pathname == "/jsp/sso/loginSuccess.do"){
		}else if(nullToBlank(mstCustCd) == ""){
			var autoLogin = window.localStorage.getItem("autoLogin");
			
			if(autoLogin == 'Y'){
				var lmInfo = JSON.parse(window.localStorage.getItem("lmInfo"));
				var ljInfo = JSON.parse(window.localStorage.getItem("ljInfo"));
				
				if(nullToBlank(lmInfo) != "" && nullToBlank(ljInfo) != ""){
					for(var mKey in lmInfo){
						if (lmInfo.hasOwnProperty(mKey)) {
							setCookieValue(mKey, lmInfo[mKey], ".lottejtb.com");
						}
					}
					
					for(var jKey in ljInfo){
						if (ljInfo.hasOwnProperty(jKey)) {
							setCookieValue(jKey, ljInfo[jKey]);
						}
					}
					
					var deviceUUID = "";
					
					if(nullToBlank(deviceInfo) != ""){
						deviceUUID = deviceInfo.uuid;
					}
					
					if(nullToBlank(lmInfo['personal_no']) != ""){
						
					}
					
					var formData = new FormData();
					formData.append('cust_id', lmInfo['onl_cno']);
					formData.append('knm', lmInfo['cst_nm']);
					formData.append('id', lmInfo['onl_id']);
					formData.append('email', lmInfo['elc_add']);
					formData.append('personalNo', lmInfo['personal_no']);
					formData.append('mblNo', lmInfo['mbl_no']);
					formData.append('mbrCustno', lmInfo['mbr_cust_no']);
					formData.append('custGradeCd', lmInfo['cust_type']);
					formData.append('cno', lmInfo['cno']);
					formData.append('deviceId', deviceUUID);
					
					cfn_ajax({
						type : "POST",
						async : false,
						url: "/sso/saveSessionLoginInfo.do",
						data: formData,
						dataType: "json",
						cache : false,
						noloading : "yes",
						timeOut : 5 * 60 * 1000,
						success: function(data) {
							var getCustCd = data.custCd;
							mstCustCd = getCustCd;
							
							$("#lnbLoginArea").html('<a onclick="fn_socialLogout();"><span></span><em>로그아웃</em></a>');
						},
						error : function(err) {
						}
					});
				}
			}
		}
	});
	</script>	
	<!--  Coredova 플러그인 관련 설정 수정처리함  -->
<% 	/**
	<c:choose> 
        <c:when test="${fn:contains(header['User-Agent'],'Android')}">
        	<script src="<c:url value='/resources/cordova/android/cordova.js' />"></script>
        	<script src="<c:url value='/resources/common/js/native.js' />"></script>
        </c:when>
        <c:when test="${fn:contains(header['User-Agent'],'iPhone')}">
        	<script src="<c:url value='/resources/cordova/android/cordova.js' />"></script>
        	<script src="<c:url value='/resources/common/js/native.js' />"></script>  
        </c:when>
        <c:when test="${fn:contains(header['User-Agent'],'iPod')}"> 
        	<script src="<c:url value='/resources/cordova/android/cordova.js' />"></script>
        	<script src="<c:url value='/resources/common/js/native.js' />"></script>
        </c:when>
        <c:when test="${fn:contains(header['User-Agent'],'iPad')}"> 
        	<script src="<c:url value='/resources/cordova/android/cordova.js' />"></script>
        	<script src="<c:url value='/resources/common/js/native.js' />"></script>
        </c:when>
    </c:choose>
    **/
%>    
	<decorator:head />

<script>
	//var custCd = "${custCd}";
</script>
</head>
<body>

<div data-role="page" class="bodyWrap">

	<!-- /header -->
	<decorator:body/>
	<!-- Initialize Swiper -->
	
    <!-- footer /common/js/footer.js 파일 가져옴 -->
 </div>
<script src="<c:url value='http://mdev.lottejtb.com:8085/resources/common/js/menuList.js' />"></script>
<script>
	/*
	var thisUrl = location.pathname + location.search;
	var preUrl = window.localStorage.getItem('nowUrl');

	if(nullToBlank(preUrl) != "") { 
		if((preUrl == '/jsp/sso/loginSuccess.do') || (preUrl == '/sso/loginChk.do') || (preUrl == '/sso/nologinPage.do')) {
		} else {		
			window.localStorage.setItem('preUrl', preUrl);
		}
	}
	window.localStorage.setItem('nowUrl', thisUrl);
	*/
	
	var thisUrl = location.pathname + location.search;
	var preUrl = getCookieValue('nowUrl');
	
	if(nullToBlank(preUrl) != ""){
		if((preUrl.indexOf('/jsp/sso/loginSuccess.do') != -1) || (preUrl.indexOf('/sso/loginChk.do') != -1) || (preUrl.indexOf('/sso/nologinPage.do') != -1)) {
		} else {
			setCookieValue('preUrl', preUrl);
			window.localStorage.setItem('preUrl', preUrl);
		}
	}
	
	setCookieValue('nowUrl', thisUrl);
	
	$(function(){
		var mainAgreeYn = window.localStorage.getItem('adAgreement');
		
		if(nullToBlank(mainAgreeYn) == ""){
			setTimeout(function(){
				//$("#alramPop_adver").popup("open");
			}, 1000);
		}
	});
	
	window.onload = function(){
		hideLoading();
	};
</script>

<!--AceCounter-Plus Log Gathering for AceTag Manager V.9.2.20170103-->
<script language='javascript'>
	var _AceTM = (function (_j, _s, _b, _o, _y) {
    var _uf='undefined',_pmt='',_lt=location;var _ap = String(typeof(_y.appid) != _uf ? _y.appid():(isNaN(window.name))?0:window.name);var _ai=(_ap.length!=6)?(_j!=0?_j:0):_ap;if(typeof(_y.em)==_uf&&_ai!=0){var _sc=document.createElement('script');var _sm=document.getElementsByTagName('script')[0];
	var _cn={tid:_ai+_s,hsn:_lt.hostname,hrf:(document.referrer.split('/')[2]),dvp:(typeof(window.orientation)!=_uf?(_ap!=0?2:1):0),tgp:'',tn1:_y.uWorth,tn2:0,tn3:0,tw1:'',tw2:'',tw3:'',tw4:'',tw5:'',tw6:'',tw7:_y.pSearch};_cn.hrf=(_cn.hsn!=_cn.hrf)?_cn.hrf:'in';for(var _aix in _y){var _ns=(_y[_aix])||{};
    if(typeof(_ns)!='function'){_cn.tgp=String(_aix).length>=3?_aix:'';_cn.tn2=_ns.pPrice;_cn.tn3=_ns.bTotalPrice;_cn.tw1=_ns.bOrderNo;_cn.tw2=_ns.pCode;_cn.tw3=_ns.pName;_cn.tw4=_ns.pImageURl;_cn.tw5=_ns.pCategory;_cn.tw6=_ns.pLink;break;};};_cn.rnd=(new Date().getTime());for(var _alx in _cn){
    var _ct=String(_cn[_alx]).substring(0,128);_pmt+=(_alx+"="+encodeURIComponent((_ct!=_uf)?_ct:'')+"&");};_y.acid=_ai;_y.atid=_cn.tid;_y.em=_cn.rnd;_sc.src=((_lt.protocol.indexOf('http')==0?_lt.protocol:'http:')+'//'+_b+'/'+_o)+'?'+_pmt+'py=0';_sm.parentNode.insertBefore(_sc,_sm);};return _y;
})(130105,'CS-30-A', 'atm.acecounter.com','ac.js',window._AceTM||{});

</script>
<noscript><img src='http://gmb.acecounter.com/mwg/?mid=AZ3A69303&tp=noscript&ce=0&' border='0' width='0' height='0' alt=''></noscript>
<!-- AceCounter Mobile Gathering Script End -->  

<!-- 키워드광고 분석 스크립트 Start -->
<script>
var _nSA=(function(_g,_c,_s,_p,_d,_i,_h){ 
 if(_i.wgc!=_g){var _ck=(new Image(0,0)).src=_p+'//'+_c+'/?cookie';_i.wgc=_g;_i.wrd=(new Date().getTime());
var _sc=_d.createElement('script');_sc.src=_p+'//sas.nsm-corp.com/'+_s+'gc='+_g+'&rd='+_i.wrd;
var _sm=_d.getElementsByTagName('script')[0];_sm.parentNode.insertBefore(_sc, _sm);_i.wgd=_c;} return _i;
})('TR10078404789','ngc1.nsm-corp.com','sa-w.js?',location.protocol,document,window._nSA||{},location.hostname);
document.writeln("<noscript><img src='//ngc1.nsm-corp.com/?uid=TR10078404789&je=n&' border=0 width=0 height=0></noscript>");
</script>	
<!-- 키워드광고 분석 스크립트 End -->					
<!-- /page -->
</body>
	
</html>