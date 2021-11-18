<%@page import="com.lottejtb.comm.util.*"%>
<%@page import="java.util.HashMap" %>
<%@page import="com.lottejtb.main.service.MainService" %>
<%@page import="javax.annotation.Resource" %>
<%@page import="com.lottejtb.util.AutoComplete" %>
<%@page import="com.lotte.member.bean.ctm.secure.*" %>
<%@page import="sun.misc.BASE64Decoder" %>
<%@page import="java.util.Properties" %>
<%@page import="java.io.FileInputStream" %>
<%@page import="com.lottejtb.sso.service.CookieInfoVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko" ng-app="commApp">
<head>

	<meta name="viewport" content="width=device-width, initial-scale=1,  user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<!-- 	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=yes,target-densitydpi=medium-dpi">  -->
	<meta name="format-detection" content="telephone=no" />
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
	
	<meta property="og:title" content="롯데제이티비 | 감동의 곁에, 언제나" />
	<meta property="og:image" content="http://m.lottejtb.com/resources/images/bg/bg_share_main.jpg" />

	<!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<script src="<c:url value='http://m.lottejtb.com/resources/common/js/UserAgent.js' />"></script>
	<script src="<c:url value='http://m.lottejtb.com/resources/common/js/facebook.js' />"></script>
	<script src="<c:url value='http://m.lottejtb.com/resources/common/js/naver.js' />"></script>   
	 
	<link rel="stylesheet" type="text/css" href="http://m.lottejtb.com/resources/common/css/jquery.mobile-1.4.5.min.css" />
	<link rel="stylesheet" type="text/css" href="http://m.lottejtb.com/resources/common/css/swiper.min.css" />
	<link rel="stylesheet" type="text/css" href="http://m.lottejtb.com/resources/common/css/common.css" />
	<link rel="stylesheet" type="text/css" href="http://m.lottejtb.com/resources/common/css/common2.css" />

	<link rel="shortcut icon" type="image/x-icon" href="http://m.lottejtb.com/resources/common/css/lottejtb.ico">
	
	<%
	String accessCheck = request.getHeader("X-Requested-With"); 
	%>
	<script>
	var accessType = "browser";
	var deviceInfo;
	var accessCheck = "<%=CommUtil.filterXSS(accessCheck)%>";
	
	var userAgent = window.navigator.userAgent.toLowerCase();
    var safari = /safari/.test(userAgent);
    var ios = /iphone|ipod|ipad/.test(userAgent);
    var android = /android/.test(userAgent);
    
	if(ios) {
    	if(!safari) {
    		accessType = "app";
    		document.write('<' + 'script src="/resources/cordova/ios/cordova.js"' + ' type="text/javascript"><' + '/script>');
    		document.write('<' + 'script src="/resources/common/js/native.js"' + ' type="text/javascript"><' + '/script>');
    	}
	}else if(android){
		if(accessCheck == 'com.lottejtb.mobile'){
			accessType = "app";
			document.write('<' + 'script src="/resources/cordova/android/cordova.js"' + ' type="text/javascript"><' + '/script>');
    		document.write('<' + 'script src="/resources/common/js/native.js"' + ' type="text/javascript"><' + '/script>');
		}
    };
	</script>
	
	<!-- 이렇게 함으로써 외부의 CDN 서버에서 가장 최신의 jQuery 배포판을 불러 올 수 있습니다. //-->
	<!-- <script src="http://code.jquery.com/jquery-latest.min.js"></script> --> 
	<script src="<c:url value='http://m.lottejtb.com/resources/common/js/jquery-latest.min.js' />"></script> 
	<script src="<c:url value='http://m.lottejtb.com/resources/common/js/jquery.mobile-1.4.5.min.js' />"></script>
	<script src="<c:url value='http://m.lottejtb.com/resources/common/js/sqliteplugin.js' />"></script>
	<script src="<c:url value='http://m.lottejtb.com/resources/common/js/common.js' />"></script>
	<script src="<c:url value='http://m.lottejtb.com/resources/common/js/common2.js' />"></script>
	<script src="<c:url value='http://m.lottejtb.com/resources/common/js/utils.js' />"></script>
	<script src="<c:url value='http://m.lottejtb.com/resources/common/js/library/jquery.anchor.js' />"></script>
	<script src="<c:url value='http://m.lottejtb.com/resources/common/js/swiper.js' />"></script>
	<script src="<c:url value='http://m.lottejtb.com/resources/common/js/jquery.blockUI.js' />"></script>
	<script src="<c:url value='http://m.lottejtb.com/resources/common/js/database.js' />"></script>
	<!--<script src="<c:url value='/resources/common/js/jquery-3.1.1.min.js' />"></script> -->
	
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
			
			if(appDownYN != "Y"){
				$("body").addClass('appt_add');
			}
			
			$(".appt_downbox .appt_exit").off("click");
			$(".appt_downbox .appt_exit").on("click", function(){
				$(".appt_downbox").remove();
				$("body").removeClass("appt_add");
				setCookieValue('appDownYN', 'Y');
			});
		}
		var autoLogin = window.localStorage.getItem("autoLogin");
		if(location.pathname == "http://m.lottejtb.com/jsp/sso/loginSuccess.do"){
		}else if(nullToBlank(mstCustCd) == ""){
			
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
						url: "http://m.lottejtb.com/sso/saveSessionLoginInfo.do",
						data: formData,
						dataType: "json",
						cache : false,
						noloading : "yes",
						timeOut : 5 * 60 * 1000,
						success: function(data) {
							console.log('succ');
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

		function getCookieTop(uName) {
			var flag = document.cookie.indexOf(uName+'=');
			if (flag != -1) {
				flag += uName.length + 1
				end = document.cookie.indexOf(';', flag)
			if (end == -1) end = document.cookie.length
				return unescape(document.cookie.substring(flag, end))
			}else {
				return '';
			}
		}

		if(nullToBlank(mstCustCd) != ""){		//[JEH]  login log - 20180308

			if(autoLogin == 'Y'){
				
				var lmInfo = JSON.parse(window.localStorage.getItem("lmInfo"));
				fnLoginLog(lmInfo['onl_cno']);
			}else{
				var cno = getCookieTop("onl_cno");
				fnLoginLog(cno);
			}
		}
		//if(nullToBlank(getCookieValue("onCallYn")) == ""){
		/* 	if(accessType == "app" && nullToBlank(deviceInfo) != ""){
				if(nullToBlank(deviceInfo.uuid) != ""){
					var deviceModel = deviceInfo.model;
					var deviceUUID = deviceInfo.uuid;
					var deviceVersion = deviceInfo.version;
					var deviceToken = window.localStorage.getItem('tokenId');
					var deviceOsType = "";
					
					if(deviceInfo.platform.toUpperCase() == "ANDROID"){
						deviceOsType = "AND";
					}else if(deviceInfo.platform.toUpperCase() == "IOS"){
						deviceOsType = "IOS"
					}
					
					var formData = new FormData();
					formData.append('deviceId', deviceUUID);
					formData.append('deviceModel', deviceModel);
					formData.append('osVersion', deviceVersion);
					formData.append('deviceToken', deviceToken);
					formData.append('osType', deviceOsType);
					
					$.ajax({
						url: "/insertDeviceInfo.do", 
						type: "POST",
						data: formData,
						async: false,
						cache: false,
						dataType: "json",
						contentType: false,
					    processData: false,
						success : function(data, status) {
						},
						complete : function(data, status) {
						},
						error : function(jqXHR, textStatus, errorThrown) {
						}
					});
				}
			}else{
			} */
			
		//	setCookieValue("onCallYn", "Y");
		//}

		//[JEH] login log - 20180308
		function fnLoginLog(cust_id){
			console.log("+++++++++++ common decorator ++++++++++++++");

			var url = '';
			if(devType == 0){
				url = "http://m.lottejtb.com/sso/loginLogInsertAjax.do";
			}else{
				url = "https://m.lottejtb.com/sso/loginLogInsertAjax.do";
			}

			var formData = new FormData();
			formData.append('cust_id',cust_id);
			cfn_ajax({
				type : "POST",
				async : true,
				url: url,
				data: formData,
				dataType: "json",
				cache : false,
				noloading : "yes",
				success: function(data) {
					console.log('succ');					
				},
				error : function(request,status,error) {
					console.log('code : ');		
					console.log(request.status);				
					console.log('message : ');		
					console.log(request.responseText);				
					console.log('error : ');		
					console.log(error);				
				}
			});
		}

	});

	
	
// 	키워드분석광고 스크립트
	window['_LA']=window['_LA']||function(){
	   (window['_LA'].q=window['_LA'].q||[]).push(arguments)
	}

	document.writeln("<scr"+"ipt language='javascript' src='https://www.googletagmanager.com/gtag/js?id=UA-123010184-1'></scr"+"ipt>");
	window.dataLayer = window.dataLayer || [];
	function gtag(){dataLayer.push(arguments);}
	gtag('js', new Date());
	gtag('config', 'UA-123010184-1');
		
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
	<script>
	<%
		HttpSession sessionInfo = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)sessionInfo.getAttribute(CommInfo.SESSION_ATTR_NAME);

		String custCd = null;
		if(sessionParam != null){
			custCd = sessionParam.get("cust_cd").toString();
		}else{

		}
	%>
	if(nullToBlank('<%=custCd%>') != ""){
		mstCustCd = <%=custCd%>;
	}
	//var custCd = "${custCd}";
	</script>
</head>
<body>

<div data-role="none" class="appt_downbox">
	<ul>
		<li><button data-role="none" type="button" class="appt_exit">닫기</button></li>
		<li><p>롯데제이티비</p><p>롯데제이티비 APP</p></li>
		<li><button data-role="none" type="button" class="appt_down" onclick="appDownLink();"><span>앱다운</span></button></li>
	</ul>
</div>

<div data-role="page" class="bodyWrap">
	<!-- header /common/js/header.js 파일에서 가져옴 -->
	<div data-role="header" data-position="fixed"  data-tap-toggle="false">
		<h1><a href="#" onclick='moveMenu("http://m.lottejtb.com/main.do", 0)'>감동의 곁에, 언제나 롯데제이티비</a></h1>
		<a href="#nav-panel" data-role="none"><img src="http://m.lottejtb.com/resources/images/btn/Header_Leftmenu.png" alt="" /></a>
		<a href="#" onclick="javascript:fn_moveMytour();" data-role="none"><img src="http://m.lottejtb.com/resources/images/btn/Header_Login.png" alt=""/></a>
		<a href="#" data-role="none" class="tt_searchbtn"><img src="http://m.lottejtb.com/resources/images/btn/Header_Search.png" alt=""/></a>
		<div class="goods_fixedbox"></div>
	</div>
	<div class="main">
		<div class="total_searchbox">
			<div class="fs_search">
				<div class="csbox">
					<input type="text" data-role="none" id="autoComplete" placeholder="누구와 함께 떠나세요?" onkeyup='fn_autoComplete();'/>
					<button class="ts_search" type="button" data-role="none" onclick="fn_keywordSearch()">검색</button>
					<button class="ts_close" type="button" data-role="none">닫기</button>
					<!-- 2018-12-04 추가 -->
					<div class="Mentoring_box" style="display: block;">
						<h2>여행의 가치를 높인 투어 멘토링시스템</h2>
						<ul class="Mentoring_box_list">
							<li attr-val="6571"><a href="#none">부모님</a></li>
							<li attr-val="6580"><a href="#none">엄마</a></li>
							<li attr-val="6572"><a href="#none">자녀</a></li>
							<li attr-val="6573"><a href="#none">연인</a></li>
							<li attr-val="6574"><a href="#none">부부</a></li>
							<li attr-val="6576"><a href="#none">친구</a></li>
							<li attr-val="6581"><a href="#none">형제</a></li>
							<li attr-val="6593"><a href="#none">가족</a></li>
							<li attr-val="6582"><a href="#none">친목회</a></li>
						</ul>
					</div>
					<script type="text/javascript">
						$(".Mentoring_box_list li").click(function(){
							var maxCnt = 3;
							if ($(this).hasClass('on') || $('.Mentoring_box_list li.on').size() < maxCnt) {
								$(this).toggleClass('on');
							}
							else {
								alert('선택은 최대 '+maxCnt+'개까지 가능합니다.');
							}
						})
						$(".tt_searchbtn").click(function(){
							$(".total_searchbox").show();
						})
						$(".ts_close").click(function(){
							$(".total_searchbox").hide();
						})
					</script>	
					<!-- -->
				</div>
				<div class="search_nowkey">
					<ul id="autoWords">
						
					</ul>
					<p class="snkclose">닫기</p>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 
	<div class="main">
		<div class="total_searchbox">
			<div class="fs_search">
				<div class="csbox">
					<input type="text" data-role="none" id="autoComplete" placeholder="도시, 호텔, 인근도시, 공항 등" onkeyup='fn_autoComplete();'/>
					<button class="ts_search" type="button" data-role="none" onclick="fn_keywordSearch()">검색</button>
					<button class="ts_close" type="button" data-role="none">닫기</button>
				</div>
				<div class="search_nowkey">
					<ul id="autoWords">
						
					</ul>
					<p class="snkclose">닫기</p>
				</div>
			</div>
		</div>
	</div>
	 -->
	
	
	
	<!-- /header -->
	<!-- Initialize Swiper -->
	<script>		
		var fn_swiperFunc = function(){
			var swiper = new Swiper('.category-thumbs', {
				slidesPerView: 'auto',
				simulateTouch: false,
				spaceBetween: 0,
				freeMode: true,
				/*resistanceRatio: 0,*/
				wrapperClass: 'swiper-wrapper',
				slideClass: 'swiper-slide',
				onInit: function () {
					jQuery('.category-thumbs').addClass('nextShadow');
				},
				onProgress: function (data, progress) {
					if (progress <= 0) {
						jQuery('.category-thumbs').removeClass('prevShadow').addClass('nextShadow');
					} else if (progress >= 1) {
						jQuery('.category-thumbs').removeClass('nextShadow').addClass('prevShadow');
					} else {
						jQuery('.category-thumbs').addClass('nextShadow prevShadow');
					}
				}
			});
			
			jQuery('.category-thumbs').on('click', '> ul > li > a', function (e) {
				var target = $(e.currentTarget);
				var idx = target.parent().index();
				jQuery('.category-thumbs').changeAct(idx);
			});
			jQuery(function(){
				var idx = jQuery(".category-thumbs > ul > li.on").index();
				jQuery('.category-thumbs').changeAct(idx);
			});
			//활성화 변경 jQuery 확장
			if (jQuery.fn.changeAct === undefined) {
				jQuery.fn.changeAct = function (idx) {
					if(idx != -1){
						if (this.is('.category-thumbs')) {
							this.find('> ul > li').removeClass('on').eq(idx).addClass('on');
							if (this.hasClass('swiper-container')) {
								var swiper = this[0].swiper;
								swiper.slideTo(Math.max(idx - 1, 0));
							}
						}
					}
				};
			};
			
			$(".category-thumbs").find('on').focus();
		}
		
		$(function(){
			var ctgSeq = "${ctg}"
			
			if(nullToBlank(ctgSeq) != ""){
				var formData = new FormData();
				formData.append('ctgSeq', ctgSeq);
	
				cfn_ajax({
					url: "<c:url value='http://m.lottejtb.com/menuMapList.do' />",
					type: "POST",
					data: formData,
					async: false,
					cache: false,
					dataType: "json",
					noloading:"no",
					success: function(res) {
						list = res.list;
						if(list.length > 0){
							topCtg = list[0]['ctgSeqMap'].split(">")[0];
							
							$("#gnb_"+ topCtg).addClass("on");
						}
					},
					error:function(err){
					},
					complete:function(){
						fn_swiperFunc();
					}
				});
			}else{
				fn_swiperFunc();
			}
		});
		
		var fn_socialLogout = function() {
			if(devType == 0){
				document.logoutFrm.action = "https://testmember.lpoint.com/door/sso/mblLogout.jsp?sid=MLOTTEJTB&sch=&returnurl=&opentype=";
				//document.location.href = "https://testmember.lpoint.com/door/sso/mblLogout.jsp?sid=MLOTTEJTB&sch=&returnurl=&opentype=";
			}else{
				document.logoutFrm.action = "https://member.lpoint.com/door/sso/mblLogout.jsp?sid=MLOTTEJTB&sch=&returnurl=&opentype=";
				//document.location.href = "https://member.lpoint.com/door/sso/mblLogout.jsp?sid=MLOTTEJTB&sch=&returnurl=&opentype=";
			}
			document.logoutFrm.submit();
		};
		
	</script>
    <!-- footer /common/js/footer.js 파일 가져옴 -->
    <form name="logoutFrm" method="post" style="display:none;"></form>
	<a href="#"  class="go-top"><i class="fa fa-angle-up"></i></a>
	<div data-role="footer" data-position="fixed" data-tap-toggle="false" id="foot" >
		<ul>
			<li><a href="#" onclick='moveMenu("http://m.lottejtb.com/main.do", 0)'><img src="http://m.lottejtb.com/resources/images/btn/Footer_home.png" alt=""/></a></li>
			<li><a href="#" onclick="javascript:fn_goToList();" data-rel="back"><img src="http://m.lottejtb.com/resources/images/btn/Footer_pre.png" alt=""/></a></li>
			<li><a href="#" data-rel="forward" onclick='pageForward()'><img src="http://m.lottejtb.com/resources/images/btn/Footer_next.png" alt=""/></a></li>
			<li><a href="#" onclick="javascript:fn_moveMytour()"><img src="http://m.lottejtb.com/resources/images/btn/Footer_human.png" alt=""/></a></li>
			<li class="sns">
				<nav class="containerT">
					<a href="https://www.instagram.com/lotteholidays/" class="buttons"></a>
					<a href="https://www.facebook.com/lottejtbofficial/" class="buttons"></a>
					<a href="https://story.kakao.com/ch/lottejtb/" class="buttons"></a>
					<a href="http://blog.naver.com/lottejtbblog/" class="buttons"></a>
					<a href="#" class="buttons"></a>
				</nav>
				<a href="#" class="snsLink"><img src="http://m.lottejtb.com/resources/images/btn/Footer_share.png" alt=""/></a>
				<div class="blinds"></div>
			</li>
		</ul>
	</div>
	<!--panel /common/js/pannel.js 파일 가져옴-->
	<!--  //menupanel -->
	<div data-role="panel" data-position-fixed="true" data-display="overlay" data-theme="a" data-overlay-theme="a" id="nav-panel">
		<ul class="lnb_top">
		  <%
		  	 if(custCd !="" && custCd != null) { //로그인 성공
		  		 
		  %>
		  	<!-- 개발인경우 -->
		 	<!--<li><a href="https://testmember.lpoint.com/door/sso/mblLogout.jsp?sid=MLOTTEJTB&sch=&returnurl=&opentype=" ><span></span><em>로그아웃</em></a></li>-->
		  	<!-- 운영인경우 -->
		  	<li style="width:33.3333%;" id="lnbLoginArea"><a onclick="fn_socialLogout();"><span></span><em>로그아웃</em></a></li>
		  <%
		  	 } else {  //로그아웃
		  %>
			<li style="width:33.3333%;" id="lnbLoginArea"><a href="#" onclick="moveMenu('http://m.lottejtb.com/sso/loginChk.do', 0)"><span></span><em>로그인</em></a></li>
		  <%
		  	 }
		  %>
			<li style="width:33.3333%;"><a href="#" onclick="moveMenu('http://m.lottejtb.com/customer/noticeList.do', 0)"><span></span><em>고객센터</em></a></li>
			<li><a href="#" data-rel="close"></a></li>
		</ul>
		<ul class="lnb_tab lnb_tab1">
			<li><a href="#" onclick="fn_menuClick('5741')"><span></span><em>패키지</em></a></li>
			<li><a href="#" onclick="fn_menuClick('6592')"><span></span><em>핏팩</em></a></li>
			<li><a href="#" onclick="fn_menuClick('5743')"><span></span><em>자유여행</em></a></li>
		</ul>
		<ul class="lnb_tab_c lnb_tab_c1" id="ctg_lnb_5741">
		</ul>
		<ul class="lnb_tab_c lnb_tab_c2" id="ctg_lnb_6592">
		</ul>
		<ul class="lnb_tab_c lnb_tab_c3" id="ctg_lnb_5743">
		</ul>
		<ul class="lnb_tab lnb_tab2">
			<li><a href="#" onclick="fn_menuClick('5744')"><span></span><em>항공</em></a></li>
			<li><a href="#" onclick="fn_menuClick('5745')"><span></span><em>호텔</em></a></li>
			<li><a href="#" onclick="fn_menuClick('5740')"><span></span><em>국내</em></a></li>
		</ul>
		<ul class="lnb_tab_c lnb_tab_c4" id="ctg_lnb_5744">
		</ul>
		<ul class="lnb_tab_c lnb_tab_c5" id="ctg_lnb_5745">
		</ul>
		<ul class="lnb_tab_c lnb_tab_c6" id="ctg_lnb_5740">
		</ul>
		<ul class="lnb_tab lnb_tab3">
			<li><a href="#" onclick="fn_menuClick('5746')"><span></span><em>허니문</em></a></li>
			<li><a href="#" onclick="fn_menuClick('5766')"><span></span><em>크루즈</em></a></li>
<!-- 			<li><a href="#" onclick="fn_menuClick('5748')"><span></span><em>샤롯데로얄</em></a></li>			 -->
			<li><a href="#" onclick="fn_menuClick('5747')"><span></span><em>골프</em></a></li>
		</ul>
		<ul class="lnb_tab_c lnb_tab_c7" id="ctg_lnb_5746">
		</ul>
		<ul class="lnb_tab_c lnb_tab_c8" id="ctg_lnb_5766">
		</ul>
		<ul class="lnb_tab_c lnb_tab_c9" id="ctg_lnb_5747">
		</ul>
		<ul class="lnb_tab lnb_tab4">
			<li><a href="#" onclick="moveMenu('http://m.lottejtb.com/event/event_list.do', 0)"><span></span><em>이벤트</em></a></li>
			<li><a href="#" onclick="moveMenu('http://m.lottejtb.com/planning/planning.do', 0)"><span></span><em>기획전</em></a></li>
			<li><a href="#"><span></span><em>회사소개</em></a></li>
		</ul>
		
		<ul class="lnb_tab_c lnb_tab_c12">
			<li><a href='#' onclick="moveMenu('http://m.lottejtb.com/corperate/corperate.do', 0)">회사소개</a></li>
			<li><a href='#' onclick="moveMenu('http://m.lottejtb.com/corperate/corperate_info.do', 0)">법인상용</a></li>
			<li><a href='#' onclick="moveMenu('http://m.lottejtb.com/corperate/corperate_lpoint.do', 0)">L.POINT 회원안내</a></li>
			<li><a href='#' onclick="moveMenu('http://m.lottejtb.com/shop/shopList.do', 0)">매장안내</a></li>
		</ul>
		<ul class="lf_sns">
			<li><a href="#" onclick="moveLink('http://blog.naver.com/lottejtbblog', '_blank')"><span></span><span>롯데제이티비 BLOG</span></a></li>
			<li><a href="#" onclick="moveLink('https://story.kakao.com/ch/lottejtb/', '_blank')"><span></span><span>롯데제이티비 KAKAO STORY</span></a></li>
			<li><a href="#" onclick="moveLink('https://m.facebook.com/lottejtbofficial/', '_blank')"><span></span><span>롯데제이티비 FACEBOOK</span></a></li>
			<li><a href="#" onclick="moveLink('https://www.instagram.com/lottejtb_official/', '_blank')"><span></span><span>롯데제이티비 INSTAGRAM</span></a></li>
		</ul>
		<ul class="lf_golink">
			<li><a href="#" onclick="moveMenu('http://m.lottejtb.com/customer/travel_clause.do', 0);">여행약관</a></li>
			<li><a href="#" onclick="moveMenu('http://m.lottejtb.com/customer/clause.do', 0);">이용약관</a></li>
			<li><a href="#" onclick="fn_travelCaluse();">해외여행자 보험약관</a></li>
			<li><a href="#" onclick="moveMenu('http://m.lottejtb.com/customer/policy.do', 0);">개인정보 처리방침</a></li>
			<li><a href="#" onclick="moveMenu('http://m.lottejtb.com/corperate/corperate.do?tab=3', 0)">찾아오시는 길</a></li>
			<li><a href="#" onclick="moveMenu('http://m.lottejtb.com/shop/shopList.do', 0)">매장안내</a></li>
		</ul>
		<a href="#" onclick="moveMenu('http://m.lottejtb.com/setting/setting.do', 0)" class="setting_btn" id="lnb_setting" style="display:none;"><span></span><em>설정</em></a>
	</div>
	<!-- <div class="more btnBG2"><a href="#" class="layerOpener" id="travelDown" data-url="/travelDownPop.do" data-width="300" data-height="400" data-ok="yes" style="display:none;">해외여행 약관다운</a></div> -->
	
	<!--  //user panel -->
	<div data-role="panel" data-position="right" data-position-fixed="true" data-display="overlay" data-theme="a" id="add-form">
		<form class="userform">
			<h2>Login</h2>
			<label for="name">Username:</label>
			<input type="text" name="name" id="name" value="" data-clear-btn="true" data-mini="true">
			<label for="password">Password:</label><input type="password" name="password" id="password" value="" data-clear-btn="true" autocomplete="off" data-mini="true">
			<div class="ui-grid-a">
				<div class="ui-block-a">
				<a href="#" data-rel="close" class="ui-btn ui-shadow ui-corner-all ui-btn-b ui-mini">Cancel</a>
				</div>
				<div class="ui-block-b">
				<a href="#" data-rel="close" class="ui-btn ui-shadow ui-corner-all ui-btn-a ui-mini">Save</a>
				</div>
			</div>
		</form>
	</div>
	<!--- 표준약관팝업-->
	 <div data-role="popup" id="policyPop" class="ui-content" data-overlay-theme="b" data-position-to="window">
		<fieldset data-role="controlgroup">
			<legend>표준약관</legend>
			<div class="cateWrap">
				<div class="box_right">
		<h5 class="info_title">해외여행 이용약관(공정거래위원회 고시)</h5>
							<ul class="info_list01 mt20">
								<li>제 15조(여행출발 전 계약해제)
									<li class="mt20">여행사 또는 여행자는 여행출발전 이 여행계약을 해제할 수 있습니다.</li>
									<li>이 경우 발생하는 손해액은 ‘소비자피해보상규정’(공정거래위원회 고시)에 따라 배상합니다.</li>
									<ul class="info_list02 mt20">
										<li>1. 여행자의 여행계약 해제 요청이 있는 경우(여행자의 취소 요청시)
											<ul class="info_list03">
												<li>- 여행 개시 30일전까지(~30) 통보시: 계약금 환급</li>
												<li>- 여행 개시 20일전까지(29~20) 통보시: 여행요금의 10% 배상</li>
												<li>- 여행 개시 10일전까지(19~10) 통보시: 여행요금의 15% 배상</li>
												<li>- 여행 개시 8일전까지(9~8) 통보시: 여행요금의 20% 배상</li>
												<li>- 여행 개시 1일전까지(7~1)통보시: 여행요금의 30% 배상</li>
												<li>- 여행 당일 통보시 - 여행요금의 50% 배상</li>
											</ul>
										</li>
										<li class="mt20">2. 여행사의 귀책사유로 취소 통보하는 경우
											<ul class="info_list03">
												<li>- 여행 개시 30일전까지(~30) 통보시: 계약금 환급</li>
												<li>- 여행 개시 20일전까지(29~20) 통보시: 여행요금의 10% 배상</li>
												<li>- 여행 개시 10일전까지(19~10) 통보시: 여행요금의 15% 배상</li>
												<li>- 여행 개시 8일전까지(9~8) 통보시: 여행요금의 20% 배상</li>
												<li>- 여행 개시 1일전까지(7~1)통보시: 여행요금의 30% 배상</li>
												<li>- 여행 당일 통보시 - 여행요금의 50% 배상</li>
											</ul>
										</li>
									</ul>
									<li class="mt20">단, 최저행사인원이 충족되지 않아 불가피하게 기획여행을 실시할 수 없는 경우에는 표준약관 제 9조(최저행사인원 미 충족시 계약해제) 조항에 의거하여 당사가 여행자에게 배상한다.</li>
									
								</li>
								<li class="mt20">제 9조(최저행사인원 미 충족시 계약해제)
									<ul class="info_list02 mt20">
										<li>1. 여행사는 최저행사인원이 충족되지 아니하여 여행계약을 해제하는 경우 여행출발 7일전까지 여행자에게 통지하여야 합니다.</li>
										<li class="mt20">2. 여행사가 여행참가자 수 미달로 전항의 기일내 통지를 하지 아니하고 계약을 해제하는 경우 이미 지급받은 계약금 환급 외에 다음 각 목의 1의 금액을 여행자에게 배상하여야 합니다.
											<ul class="info_list03">
												<li>- 여행출발 1일전까지 통지시 : 여행요금의 30%</li>
												<li>- 여행출발 당일 통지시 : 여행요금의 50%</li>
											</ul>
										</li>
									</ul>									
								</li>
								<li class="mt20">※주의사항
									<ul class="info_list02">
										<li>- 전세기 및 일부 상품은 공정위에서 지정한 여행업 표준약관 제 5조(특약), 제 20조(기타사항)에 의거하여 별도의 보상규정이 적용되오니 상품 구매 시 유의하시기 바랍니다.</li>
										<li>- 약관의 전체 내용은 롯데제이티비 홈페이지에서 확인 가능합니다.(<a href="http://www.lottejtb.com/xhtml/lottejtb/lottejtb_over_provision.html" target="_blank">http://www.lottejtb.com/xhtml/lottejtb/lottejtb_over_provision.html)</a>
										</li>
									</ul>									
								</li>
							</ul>	
		</div>
			</div>
		</fieldset>
		<div data-role="footer" ><a href="#" data-rel="back" class="ui-btn align-c">닫기</a></div>
	 </div>
	<!--- 팝업-->
	<div data-role="popup" id="popupLogin" data-overlay-theme="b" data-position-to="window" data-dismissible="false">
		<form>
			<div style="padding:10px 20px;">
				<h3>Please sign in</h3>
				<label for="un" class="ui-hidden-accessible">Username:</label>
				<input type="text" name="user" id="un" value="" placeholder="username" data-theme="a">
				<label for="pw" class="ui-hidden-accessible">Password:</label>
				<input type="password" name="pass" id="pw" value="" placeholder="password" data-theme="a">
				<button type="submit" class="ui-btn ui-corner-all ui-shadow ui-btn-b ui-btn-icon-left ui-icon-check">Sign in</button>
			</div>
		</form>
	</div>
	<!--- 광고성정보 수신동의-->
	<div data-role="popup" id="alramPop_adver" class="ui-content" data-overlay-theme="b" data-position-to="window" data-dismissible="false">
		<div data-role="header" >광고성정보 수신동의</div>
		<div data-role="content" >
			<p>롯데JTB에서 해당 기기로 영리목적 광고성 정보를 전송하려고 합니다.<br/></p>
			<span>해당 설정은 롯데 JTB APP > 좌측메뉴 하단 > 설정에서 변경 가능합니다.</span>
		</div>
		<div data-role="footer" >
			<a href="#" data-rel="back" class="ui-btn align-c" onclick="agreePopup('N')">동의안함</a>
			<a href="#" data-rel="back" class="ui-btn align-c point" onclick="agreePopup('Y')">동의</a></div>
	 </div>
	<!--- 앱업데이트알림-->
	<div data-role="popup" id="appalramPop" data-overlay-theme="b" data-position-to="window" data-dismissible="false">
		<div data-role="header" >앱업데이트알림</div>
		<div data-role="content" >
				<p>새로운 버젼이 업데이트 되었습니다.<br/>
				앱스토어에서 다운받으시겠습니까?</p>
				<span>확인 클릭시 앱스토어로 이동합니다.</span>
			</div>
		<div data-role="footer" ><a href="#" data-rel="back" class="ui-btn align-c">취소</a><a href="#" data-rel="back" class="ui-btn align-c">확인</a></div>
	</div>
	<!--- 롯데 JTB알림 N-->
	<div data-role="popup" id="alramPop_jtbN" data-overlay-theme="b" data-position-to="window" data-dismissible="false">
	   <div data-role="header" >롯데 JTB알림</div>
		<div data-role="content" >	        
			<p>고객님의 이벤트/혜택알림 서비스가 "수신안함"처리<br/>
			되었습니다. <span id="alramPop_jtbN_date"></span></p>
		</div>
		<div data-role="footer" ><a href="#" data-rel="back" class="ui-btn align-c">확인</a></div>
	</div>
	<!--- 롯데 JTB알림 Y-->
	<div data-role="popup" id="alramPop_jtbY" data-overlay-theme="b" data-position-to="window" data-dismissible="false">
	   <div data-role="header" >롯데 JTB알림</div>
		<div data-role="content" >	        
			<p>고객님의 이벤트/혜택알림 서비스가 "수신함"처리<br/>
			되었습니다. <span id="alramPop_jtbY_date"></span></p>
		</div>
		<div data-role="footer" ><a href="#" data-rel="back" class="ui-btn align-c">확인</a></div>
	</div>   	
	<!--- 고객센타 카테고리 팝업-->
	<div data-role="popup" id="navPop" class="ui-content" data-overlay-theme="b" data-position-to="window" data-dismissible="false">
		<fieldset data-role="controlgroup">
			<legend>고객센터</legend>
			<input type="radio" name="radio-choice-1" id="radio-choice-1" value="choice-1" checked="checked" onclick='moveMenu("http://m.lottejtb.com/customer/noticeList.do", 0)'>
			<label for="radio-choice-1">공지사항</label>
			<input type="radio" name="radio-choice-2" id="radio-choice-2" value="choice-2" onclick='moveMenu("http://m.lottejtb.com/customer/faq.do", 0)'>
			<label for="radio-choice-2">자주찾는질문</label>
			<input type="radio" name="radio-choice-3" id="radio-choice-3" value="choice-3" onclick='moveMenu("http://m.lottejtb.com/customer/qnaList.do", 0)'>
			<label for="radio-choice-3">묻고답하기</label>
			<input type="radio" name="radio-choice-4" id="radio-choice-4" value="choice-4" onclick='moveMenu("http://m.lottejtb.com/customer/coupon.do", 0)'>
			<label for="radio-choice-4">상품권/쿠폰</label>
		</fieldset>
		<div data-role="footer" ><a href="#" data-rel="back" class="ui-btn align-c">Close</a></div>
	 </div>
	 
	 <!--- 회사소개 카테고리 팝업-->
	 <div data-role="popup" id="corperatePop" class="ui-content" data-overlay-theme="b" data-position-to="window" data-dismissible="false">
		<fieldset data-role="controlgroup">
				<legend>회사소개</legend>
				<input type="radio" name="corperate-choice-1" id="corperate-choice-1" value="choice-1" checked="checked" onclick='moveMenu("http://m.lottejtb.com/corperate/corperate.do", 0)'>
				<label for="corperate-choice-1">회사소개</label>
				<input type="radio" name="corperate-choice-1" id="corperate-choice-2" value="choice-2" onclick='moveMenu("http://m.lottejtb.com/corperate/corperate_info.do", 0)'>
				<label for="corperate-choice-2">법인상용</label>
				<input type="radio" name="corperate-choice-1" id="corperate-choice-3" value="choice-3" onclick='moveMenu("http://m.lottejtb.com/corperate/corperate_lpoint.do", 0)'>
				<label for="corperate-choice-3">L.Point 회사소개</label>	
				<input type="radio" name="corperate-choice-1" id="corperate-choice-4" value="choice-4" onclick='moveMenu("http://m.lottejtb.com/shop/shopList.do", 0)'>
				<label for="corperate-choice-4">매장안내</label>        
		</fieldset>
		<div data-role="footer" > <a href="#" data-rel="back" class="ui-btn align-c">Close</a></div>
	</div>
</div>

<script src="<c:url value='http://m.lottejtb.com/resources/common/js/menuList.js' />"></script>
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
		if((preUrl.indexOf('http://m.lottejtb.com/jsp/sso/loginSuccess.do') != -1) || (preUrl.indexOf('http://m.lottejtb.com/sso/loginChk.do') != -1) || (preUrl.indexOf('http://m.lottejtb.com/sso/nologinPage.do') != -1)) {
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

	function getCookieTop(uName) {
		var flag = document.cookie.indexOf(uName+'=');
		if (flag != -1) {
			flag += uName.length + 1
			end = document.cookie.indexOf(';', flag)
		if (end == -1) end = document.cookie.length
			return unescape(document.cookie.substring(flag, end))
		}else {
			return '';
		}
	}

	//[JEH] 항공과 로그인 호환 문제로 추가 - 20190226
		var onl_cno = getCookieTop("onl_cno");
		if(!onl_cno){
			var nowAdd = unescape(location.href);      
	        var protocol = document.location.protocol;

			document.writeln("<scr"+"ipt language='javascript' src='" + protocol + "//member.lpoint.com/door/sso/LOTTEJTB/checkLogin.jsp?returnurl="+nowAdd+"'></scr"+"ipt>");
		}
	
	
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