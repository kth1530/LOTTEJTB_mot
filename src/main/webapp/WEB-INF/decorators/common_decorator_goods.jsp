<%@page import="com.lottejtb.comm.util.*"%>
<%@page import="java.util.HashMap" %>
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

	<meta property="og:title" content="롯데제이티비 | 감동의 곁에, 언제나" />
	<meta property="og:image" content="http://m.lottejtb.com/resources/images/bg/bg_share_main.jpg" />
	
	<meta name="keywords" content="롯데제이티비, 롯데여행사, 여행사, 종합여행사, 추천여행사, 롯데JTB, 롯데제이티비여행사, 롯데JTB여행사, 롯데그룹여행사, 
	롯데여행, LOTTEJTB, 해외여행, 패키지여행, 국내여행, 자유여행, 제주여행, 에어텔, 출장여행,
	항공권, 해외항공, 국내항공, 해외항공권, 국내항공권, 최저가항공권, 
	해외호텔, 국내숙박, 국내호텔, 호텔, 숙박, 호캉스, 제주숙박, 제주호텔,
	허니문, 크루즈, 골프, 비즈니스석, 핏팩, 단체여행, 비즈니스여행,
	테마여행, 렌터카, 티켓, 패스, 철도여행, 골프여행, 크루즈여행, 상용여행
	FITPACK, 교통패스, 해외여행정보, 여권비자, 여행정보, 여행상품권" />
	
	<!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<script src="<c:url value='/resources/common/js/UserAgent.js' />"></script>    
	<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.mobile-1.4.5.min.css" />
	<link rel="stylesheet" type="text/css" href="/resources/common/css/swiper.min.css" />
	<link rel="stylesheet" type="text/css" href="/resources/common/css/common.css" />
	<link rel="stylesheet" type="text/css" href="/resources/common/css/common2.css" />

	<link rel="shortcut icon" type="image/x-icon" href="/resources/common/css/lottejtb.ico">
	
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
	<script src="<c:url value='/resources/common/js/jquery-latest.min.js' />"></script> 
	<script src="<c:url value='/resources/common/js/jquery.mobile-1.4.5.min.js' />"></script>
	<script src="<c:url value='/resources/common/js/sqliteplugin.js' />"></script>
	<script src="<c:url value='/resources/common/js/common.js' />"></script>
	<script src="<c:url value='/resources/common/js/common2.js' />"></script>
	<script src="<c:url value='/resources/common/js/utils.js' />"></script>
	<script src="<c:url value='/resources/common/js/library/jquery.anchor.js' />"></script>
	<script src="<c:url value='/resources/common/js/swiper.js' />"></script>
	<script src="<c:url value='/resources/common/js/jquery.blockUI.js' />"></script>
	<script src="<c:url value='/resources/common/js/database.js' />"></script>
	
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
	
	if(!httpFlages){
		if(location.protocol == 'https:'){
			location.replace(location.href.replace('https://', 'http://'));
		}
	}
	*/
	
	$(document).ready(function(){
		/*
		if(accessType == "app"){
			$("#lnb_setting").show();
		}else{
			$("#lnb_setting").hide();
			
			var appDownYN = getCookieValue('appDownYN');
			
			/*
			if(appDownYN != "Y"){
				$("body").addClass('appt_add');
			}
			*/
			/*
			$(".appt_downbox .appt_exit").off("click");
			$(".appt_downbox .appt_exit").on("click", function(){
				$(".appt_downbox").remove();
				$("body").removeClass("appt_add");
				setCookieValue('appDownYN', 'Y');
			});
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
	<decorator:head />
	
<%
	HttpSession sessionInfo = request.getSession(true);
	HashMap<String, Object> sessionParam = (HashMap<String, Object>)sessionInfo.getAttribute(CommInfo.SESSION_ATTR_NAME);
	
	String custCd = null;
	if(sessionParam != null){
		custCd = sessionParam.get("cust_cd").toString();
	}
	if(custCd != null)
		System.out.println("##custCd##=" + custCd);
%> 	
<script>
	if(nullToBlank('<%=custCd%>') != ""){
		mstCustCd = <%=custCd%>;
	}
</script>
</head>
<body>
<!-- 
<div data-role="none" class="appt_downbox">
	<ul>
		<li><button data-role="none" type="button" class="appt_exit">닫기</button></li>
		<li><p>롯데제이티비</p><p>롯데제이티비 APP</p></li>
		<li><button data-role="none" type="button" class="appt_down"><span>앱다운</span></button></li>
	</ul>
</div>
 -->
<div data-role="page" class="bodyWrap goodsbt gs_detail">
	<!-- header /common/js/header.js 파일에서 가져옴 -->
	<div data-role="header" data-position="fixed"  data-tap-toggle="false">
		<h1><a href="#" onclick='moveMenu("/main.do", 0)'>감동의 곁에, 언제나 롯데제이티비</a></h1>
		<a href="#nav-panel" data-role="none"><img src="/resources/images/btn/Header_Leftmenu.png" alt="" /></a>
		<a href="#" onclick="javascript:fn_moveMytour();" data-role="none"><img src="/resources/images/btn/Header_Login.png" alt=""/></a>
		<a href="#" data-role="none" class="tt_searchbtn"><img src="/resources/images/btn/Header_Search.png" alt=""/></a>
		<div class="goods_fixedbox"></div>
	</div>
	<div class="swiper-container category-thumbs topgnb" data-position="fixed" data-tap-toggle="false">
		<ul class="swiper-wrapper">
			<li class="swiper-slide" id="gnb_5741"><a onclick="moveMenu('/goods/categoryOther.do?ctg=5741', 0)">패키지</a></li>
<!-- 			<li class="swiper-slide" id="gnb_5743"><a onclick="moveMenu('/goods/categoryOther.do?ctg=5743')">자유여행</a></li> -->
			<li class="swiper-slide" id="gnb_5744" style="width: 18%;"><a onclick="moveMenu('/goods/categoryOther.do?ctg=5744', 0);">항공</a></li>
			<li class="swiper-slide" id="gnb_5745" style="width: 18%;"><a onclick="moveMenu('/goods/categoryOther.do?ctg=5745',0)">호텔</a></li>
			<li class="swiper-slide" id="gnb_5743" style="width: 23%;"><a onclick="moveMenu('/goods/categoryOther.do?ctg=5743&subCtg=6323')">자유여행</a></li>
			<li class="swiper-slide" id="gnb_5740"><a onclick="moveMenu('/goods/categoryOther.do?ctg=5740',0)">국내</a></li>
			<!-- 
			<li class="swiper-slide" id="gnb_5741"><a onclick="moveMenu('/goods/category.do?ctg=5741', 1)">해외</a></li>
			<li class="swiper-slide" id="gnb_free"><a onclick="fn_moveFreePage()">자유여행</a></li>
			<li class="swiper-slide" id="gnb_5809"><a onclick="javascript:fn_airAppLink();">항공권</a></li>
			<li class="swiper-slide" id="gnb_5745"><a onclick="moveMenu('/domestic/dmt_detail_domestic.do?url=http://m.cp.hotelpass.net/search.asp?cp_agent=jtbmo&ctgname=호텔',1)">호텔</a></li>
			<li class="swiper-slide" id="gnb_rentalCar"><a onclick="fn_moveFreePage('rent')">렌트카</a></li>
			<li class="swiper-slide" id="gnb_5746"><a onclick="moveMenu('/goods/categoryOther.do?ctg=5746', 1)">허니문</a></li>
			<li class="swiper-slide" id="gnb_5747"><a onclick="moveMenu('/goods/categoryOther.do?ctg=5747', 1)">골프</a></li>
			<li class="swiper-slide" id="gnb_5740"><a onclick="moveMenu('/domestic/dmt_category_domestic.do?ctg=5740',1)">국내</a></li>
			 -->
			<!-- li class="swiper-slide" id="gnb_5742"><a onclick="moveMenu('/goods/theme.do?ctg=5742', 1)">테마</a></li  -->
		</ul>
	</div>
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
	<!-- /header -->
	<decorator:body/>

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
					url: "<c:url value='/menuMapList.do' />",
					type: "POST",
					data: formData,
					async: false,
					cache: false,
					dataType: "json",
					noloading:"no",
					success: function(res) {
						list = res.list;
						if(list.length > 0){
							var topCtg = list[0]['ctgSeqMap'].split(">")[0];
							
							$("#gnb_"+ topCtg).addClass("on");
						};
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
			if(devType == 0)
				document.location.href = "https://testmember.lpoint.com/door/sso/mblLogout.jsp?sid=LOTTEJTB&sch=&returnurl=http://m.lottejtb.com&opentype="; 
			else
				document.location.href = "https://member.lpoint.com/door/sso/mblLogout.jsp?sid=LOTTEJTB&sch=&returnurl=http://m.lottejtb.com&opentype=";
			
		};
	</script>
    <!-- footer /common/js/footer.js 파일 가져옴 -->
	<div data-role="footer" data-position="fixed" data-tap-toggle="false" id="foot" >
		<ul>
			<li><a href="#" onclick='moveMenu("/main.do", 0)'><img src="/resources/images/btn/Footer_home.png" alt=""/></a></li>
			<li><a href="#" data-rel="back"><img src="/resources/images/btn/Footer_pre.png" alt=""/></a></li>
			<li><a href="#" data-rel="forward" onclick='pageForward()'><img src="/resources/images/btn/Footer_next.png" alt=""/></a></li>
			<li><a href="#" onclick="javascript:fn_moveMytour()"><img src="/resources/images/btn/Footer_human.png" alt=""/></a></li>
			<li class="sns">
				<nav class="containerT">
					<a href="https://www.instagram.com/lotteholidays/" class="buttons"></a>
					<a href="https://m.facebook.com/lotteholiday/" class="buttons"></a>
					<a href="https://story.kakao.com/ch/lottejtb/" class="buttons"></a>
					<a href="http://blog.naver.com/lottejtbblog/" class="buttons"></a>
					<a href="#" class="buttons"></a>
				</nav>
				<a href="#" class="snsLink"><img src="/resources/images/btn/Footer_share.png" alt=""/></a>
				<div class="blinds"></div>
			</li>
		</ul>
	</div>
	
    <!-- footer /common/js/footer2.js 파일 가져옴 -->   
	<a href="#"  class="go-top go95"><i class="fa fa-angle-up"></i></a>
	<div  class="gfoot"  data-position="fixed" data-tap-toggle="false" data-role="footer" >
	<ul>
	    <li style="background:#f7415b"><a href="javascript:fn_goMaster()"><img src="/resources/images/btn/Footer_goods_calendar.png" alt=""/></a></li>
		<li style="width:80%;background:#353163" id="reserveLI"><a href="javascript:fn_goReserve()" class="img" id="span_reserve01" name="span_reserve01"><img src="/resources/images/btn/Footer_goods_reserve.png" alt=""/>예약하기</a><a href="#" class="img" id="span_reserve02" name="span_reserve02"><img src="/resources/images/btn/Footer_goods_reserve.png" alt=""/>예약마감</a></li>
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
		  	<li style="width:28%;" id="lnbLoginArea"><a onclick="fn_socialLogout();"><span></span><em>로그아웃</em></a></li>
		  <%
		  	 } else {  //로그아웃
		  %>
			<li style="width:25%;" id="lnbLoginArea"><a href="#" onclick="moveMenu('/sso/loginChk.do', 0)"><span></span><em>로그인</em></a></li>
		  <%
		  	 }
		  %>
			<li style="width:27%;"><a href="#" onclick="moveMenu('/customer/noticeList.do', 0)"><span></span><em>고객센터</em></a></li>
			<li style="width:27%;"><a href="#" onclick="moveMenu('/corperate/corperate.do', 0)"><span></span><em>회사소개</em></a></li>
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
<!-- 			<li><a href="#" onclick="fn_menuClick('6615')"><span></span><em>비즈니스석</em></a></li> -->
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
			<li><a href="#" onclick="moveMenu('/event/event_list.do', 0)"><span></span><em>이벤트</em></a></li>
			<li><a href="#" onclick="moveMenu('/planning/planning.do', 0)"><span></span><em>기획전</em></a></li>
			<li><a href="#" onclick="moveMenu('/customer/coupon.do#tab2', 0)"><span></span><em>제휴서비스</em></a></li>
		</ul>
		<!-- 
		<ul class="lnb_tab_c lnb_tab_c12">
			<li><a href='#' onclick="moveMenu('/corperate/corperate.do', 0)">회사소개</a></li>
			<li><a href='#' onclick="moveMenu('/corperate/corperate_info.do', 0)">법인상용</a></li> -->
<!-- 			<li><a href='#' onclick="moveMenu('/corperate/corperate_lpoint.do', 0)">L.POINT 회원안내</a></li> -->
<!-- 			<li><a href='#' onclick="moveMenu('/shop/shopList.do', 0)">매장안내</a></li>
		</ul> -->
		<ul class="lf_sns">
			<li><a href="#" onclick="moveLink('http://blog.naver.com/lottejtbblog', '_blank')"><span></span><span>롯데제이티비 BLOG</span></a></li>
			<li><a href="#" onclick="moveLink('https://story.kakao.com/ch/lottejtb/', '_blank')"><span></span><span>롯데제이티비 KAKAO STORY</span></a></li>
			<li><a href="#" onclick="moveLink('https://m.facebook.com/lotteholiday/', '_blank')"><span></span><span>롯데제이티비 FACEBOOK</span></a></li>
			<li><a href="#" onclick="moveLink('https://www.instagram.com/lottejtb_official/', '_blank')"><span></span><span>롯데제이티비 INSTAGRAM</span></a></li>
		</ul>
		<ul class="lf_golink">
			<li><a href="#" onclick="moveMenu('/customer/travel_clause.do', 0);">여행약관</a></li>
			<li><a href="#" onclick="moveMenu('/customer/clause.do', 0);">이용약관</a></li>
			<li><a href="#" onclick="fn_travelCaluse();">해외여행자 보험약관</a></li>
			<li><a href="#" onclick="moveMenu('/customer/policy.do', 0);">개인정보 처리방침</a></li>
			<li><a href="#" onclick="moveMenu('/corperate/corperate.do?tab=3',0)">찾아오시는 길</a></li>
			<li><a href="#" onclick="moveMenu('/shop/shopList.do', 0)">매장안내</a></li>
		</ul>
		<a href="#" onclick="moveMenu('/setting/setting.do', 0)" class="setting_btn" id="lnb_setting" style="display:none;"><span></span><em>설정</em></a>
	</div>
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
			<p>롯데제이티비에서 해당 기기로 영리목적 광고성 정보를 전송하려고 합니다.<br/></p>
			<span>해당 설정은 롯데제이티비 APP > 좌측메뉴 하단 > 설정에서 변경 가능합니다.</span>
		</div>
		<div data-role="footer" ><a href="#" data-rel="back" class="ui-btn align-c" onclick="agreePopup('N')">동의안함</a><a href="#" data-rel="back" class="ui-btn align-c point" onclick="agreePopup('Y')">동의</a></div>
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
	<!--- 롯데 JTB알림 Y-->
	<div data-role="popup" id="alramPop_jtbN" data-overlay-theme="b" data-position-to="window" data-dismissible="false">
	   <div data-role="header" >광고성정보 수신동의</div>
		<div data-role="content" >	        
			<p>고객님의 광고성정보 수신동의가 "수신안함"처리<br/>
			되었습니다. <span id="alramPop_jtbN_date"></span></p>
		</div>
		<div data-role="footer" ><a href="#" data-rel="back" class="ui-btn align-c">확인</a></div>
	</div>
	<!--- 롯데 JTB알림 N-->
	<div data-role="popup" id="alramPop_jtbY" data-overlay-theme="b" data-position-to="window" data-dismissible="false">
	   <div data-role="header" >광고성정보 수신동의</div>
		<div data-role="content" >	        
			<p>고객님의 광고성정보 수신동의가 "수신함"처리<br/>
			되었습니다. <span id="alramPop_jtbY_date"></span></p>
		</div>
		<div data-role="footer" ><a href="#" data-rel="back" class="ui-btn align-c">확인</a></div>
	</div>   	
	<!--- 고객센타 카테고리 팝업-->
	<div data-role="popup" id="navPop" class="ui-content" data-overlay-theme="b" data-position-to="window" data-dismissible="false">
		<fieldset data-role="controlgroup">
			<legend>고객센터</legend>
			<input type="radio" name="radio-choice-1" id="radio-choice-1" value="choice-1" checked="checked" onclick='moveMenu("/customer/noticeList.do", 0)'>
			<label for="radio-choice-1">공지사항</label>
			<input type="radio" name="radio-choice-2" id="radio-choice-2" value="choice-2" onclick='moveMenu("/customer/faq.do", 0)'>
			<label for="radio-choice-2">자주찾는질문</label>
			<input type="radio" name="radio-choice-3" id="radio-choice-3" value="choice-3" onclick='moveMenu("/customer/qnaList.do", 0)'>
			<label for="radio-choice-3">묻고답하기</label>
			<input type="radio" name="radio-choice-4" id="radio-choice-4" value="choice-4" onclick='moveMenu("/customer/coupon.do", 0)'>
			<label for="radio-choice-4">상품권/쿠폰</label>
		</fieldset>
		<div data-role="footer" ><a href="#" data-rel="back" class="ui-btn align-c">Close</a></div>
	 </div>
	 
	 <!--- 회사소개 카테고리 팝업-->
	 <div data-role="popup" id="corperatePop" class="ui-content" data-overlay-theme="b" data-position-to="window" data-dismissible="false">
		<fieldset data-role="controlgroup">
				<legend>회사소개</legend>
				<input type="radio" name="corperate-choice-1" id="corperate-choice-1" value="choice-1" checked="checked" onclick='moveMenu("/corperate/corperate.do", 0)'>
				<label for="corperate-choice-1">회사소개</label>
				<input type="radio" name="corperate-choice-1" id="corperate-choice-2" value="choice-2" onclick='moveMenu("/corperate/corperate_info.do", 0)'>
				<label for="corperate-choice-2">법인상용</label>
				<input type="radio" name="corperate-choice-1" id="corperate-choice-3" value="choice-3" onclick='moveMenu("/corperate/corperate_lpoint.do", 0)'>
				<label for="corperate-choice-3">L.Point 회사소개</label>	
				<input type="radio" name="corperate-choice-1" id="corperate-choice-4" value="choice-4" onclick='moveMenu("/shop/shopList.do", 0)'>
				<label for="corperate-choice-4">매장안내</label>        
		</fieldset>
		<div data-role="footer" > <a href="#" data-rel="back" class="ui-btn align-c">Close</a></div>
	</div>
</div>

<script src="<c:url value='/resources/common/js/menuList.js' />"></script>
<script>
	/*
	var thisUrl = location.pathname + location.search;
	var preUrl = window.localStorage.getItem('nowUrl');
	if(nullToBlank(preUrl) != "") {
		if((preUrl == '/jsp/sso/loginSuccess.do') || (preUrl == '/sso/loginChk.do') || (preUrl == '/sso/nologinPage.do')) {
			console.log("preUrl2&&&=" + preUrl)
		} else {		
			window.localStorage.setItem('preUrl', preUrl);
		}
	}
	window.localStorage.setItem('nowUrl', thisUrl);
	*/
	
	var thisUrl = location.pathname + location.search;
	var preUrl = getCookieValue('nowUrl');
	
	if(nullToBlank(preUrl) != ""){
		if((preUrl == '/jsp/sso/loginSuccess.do') || (preUrl == '/sso/loginChk.do') || (preUrl == '/sso/nologinPage.do')) {
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