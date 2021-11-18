var data = "";

var homeUrl = "https://m.lottejtb.com";

data +='	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />';
data +='	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">';
data +='	<meta http-equiv="cache-control" content="no-cache" />';
data +='	<meta http-equiv="pragma" content="no-cache" />';
data +=' 	<meta http-equiv="expires" content="-1" />';
data +='	<meta name="robots" content="all" />';
data +='	<meta name="keywords" content="" />';
data +='	<link rel="shortcut icon" type="image/x-icon" href="' + homeUrl + '/resources/common/images_ju/lottejtb.ico">';
data +=' 	<link rel="stylesheet" href="' + homeUrl + '/resources/common/css_ju/reset.css">';
data +=' 	<link rel="stylesheet" href="' + homeUrl + '/resources/common/css_ju/swiper.css">';
data +=' 	<link rel="stylesheet" href="' + homeUrl + '/resources/common/css_ju/style.css">';
data +='  	<script src="' + homeUrl + '/resources/common/js/menuList.js" charset="utf-8"></script>';

data +='	<link rel="stylesheet" type="text/css" href="https://m.lottejtb.com/resources/common/css/jquery.mobile-1.4.5.min.css" />';
data +='	<link rel="stylesheet" type="text/css" href="https://m.lottejtb.com/resources/common/css/swiper.min.css" />';
data +='	<link rel="stylesheet" type="text/css" href="https://m.lottejtb.com/resources/common/css/common.css" />';
data +='	<link rel="stylesheet" type="text/css" href="https://m.lottejtb.com/resources/common/css/common2.css" />';

//data +='	<script src="http://m.lottejtb.com/resources/common/js/jquery-latest.min.js"></script> ';
//data +='	<script src="http://m.lottejtb.com/resources/common/js/jquery.mobile-1.4.5.min.js"></script>';
//data +='	<script src="http://m.lottejtb.com/resources/common/js/sqliteplugin.js"></script>';
data +='	<script src="https://m.lottejtb.com/resources/common/js/common.js"></script>';
data +='	<script src="https://m.lottejtb.com/resources/common/js/common2.js"></script>';
data +='	<script src="https://m.lottejtb.com/resources/common/js/utils_air.js"></script>';
//data +='	<script src="http://m.lottejtb.com/resources/common/js/library/jquery.anchor.js"></script>';
data +='	<script src="https://m.lottejtb.com/resources/common/js/swiper.js"></script>';
data +='	<script src="https://m.lottejtb.com/resources/common/js/jquery.blockUI.js"></script>';
data +='	<script src="https://m.lottejtb.com/resources/common/js/database.js"></script>';


data +='    <script>';

	jQuery(function() {
		/*****메인 탑메뉴******	*/		
		var swiper = new Swiper('.category-thumbs', {
			slidesPerView: 'auto',
			simulateTouch: false,
			spaceBetween: 0,
			freeMode: true,
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
			var idx = jQuery(this).parent().index();
			jQuery('.category-thumbs').changeAct(idx);
		});

		var idx = jQuery(".category-thumbs > ul > li.on").index();
		
		//활성화 변경 jQuery 확장
		if (jQuery.fn.changeAct === undefined) {
			jQuery.fn.changeAct = function (idx) {
				if (this.is('.category-thumbs')) {
					this.find('> ul > li').removeClass('on').eq(idx).addClass('on');
					if (this.hasClass('swiper-container')) {
						var swiper = this[0].swiper;
						swiper.slideTo(Math.max(idx - 1, 0));
					}
				}
			};
		};
		/* Left Menu */
		jQuery("div[style='height:39px'],iv[style='height:40px']").css({"height":"47px"})
		jQuery(".lnb_tab").each(function(){
			jQuery(this).find("li a").on("click", function(){
				var ltClass = jQuery(this).parent().parent().attr("class");
				var ltlink_index = (jQuery(this).parent().index())+1;
				var number_ltClass = (ltClass.match(/[0-9]/gi))-1;
				var li_check = 3*number_ltClass+ltlink_index;
				jQuery(".lnb_tab,.lnb_tab > li").removeClass("on");
				if(jQuery(".lnb_tab_c").hasClass("lnb_tab_c"+li_check)==true){
					jQuery(this).parent().addClass("on");
					jQuery(this).parent().parent().addClass("on");
				}
				jQuery(".lnb_tab_c").hide();
				jQuery(".lnb_tab_c"+li_check).show();
				jQuery(".lnb_tab_c"+li_check).css({"border-bottom": "1px solid #d1d1d6"});
			});
		});
		//LNB메뉴
		jQuery("#header .toplnbbtn").on("click",function(){
			jQuery("#nav_box").animate({"margin-left":"0"},100);
		});
		jQuery("#nav_box .nav_box_close").on("click",function(){
			jQuery("#nav_box").animate({"margin-left":"-100%"},100);
		});
		/* 자동완성 
		jQuery(".tt_searchbtn").on("click", function(){
			jQuery(".total_searchbox").toggleClass("on");
		});
		jQuery(".total_searchbox .ts_close").on("click", function(){
			jQuery(".total_searchbox").removeClass("on");
		});*/
		
		jQuery(".Mentoring_box_list li").on("click", function(){
			var maxCnt = 3;
			if (jQuery(this).hasClass('on') || jQuery('.Mentoring_box_list li.on').size() < maxCnt) {
				jQuery(this).toggleClass('on');
			}
			else {
				alert('선택은 최대 '+maxCnt+'개까지 가능합니다.');
			}
		});
		jQuery(".tt_searchbtn").on("click", function(){
			jQuery(".total_searchbox").show();
		});
		jQuery(".ts_close").on("click", function(){
			jQuery(".total_searchbox").hide();
		});
		autokey();
	});
	/* 자동완성 */
	
	
	function setLoginPageUrl() {

	    var nowAddress = location.href;

	    var tempAddress = nowAddress.slice(nowAddress.indexOf('/') + 2, nowAddress.length);

	    var editAddress = tempAddress.slice(tempAddress.indexOf('/'), tempAddress.length);



	  if(editAddress.indexOf("&")!=-1){

	      var editAddr_arr = editAddress.split("&");

	      editAddress="";

	        for(i=0;i<editAddr_arr.length;i++){

	          editAddress = editAddress + editAddr_arr[i]+"%26";

	        }

	    }     

	    

	    

	    if(tempAddress.indexOf("&")!=-1){

	      var tempAddr_arr = tempAddress.split("&");

	      tempAddress="";

	        for(i=0;i<tempAddr_arr.length;i++){

	          tempAddress =tempAddress+ tempAddr_arr[i]+"%26";

	        }

	    }     




	    if(nowAddress.indexOf("&")!=-1){

	      var nowAddr_arr = nowAddress.split("&");

	      nowAddress="";

	        for(i=0;i<nowAddr_arr.length;i++){

	          nowAddress =nowAddress+ nowAddr_arr[i]+"%26";

	        }

	    }    
	    
	    
	    document.location.href = homeUrl +'/sso/loginChk.do?returnurl='+ nowAddress;

	}

	
	var autokey = function(){
		jQuery(".fs_search .csbox input").bind("change keyup", function(){
			jQuery(".fs_search .search_nowkey").show();
			var intext = jQuery(this).val();
			jQuery(".fs_search .search_nowkey li").each(function(){
				var text = jQuery(this).text();
				jQuery(this).attr("data-text",text);
				jQuery(this).html(text.replace(intext, "<span class='f_red'>"+intext+"</span>")); 
			});
		});
		jQuery(".fs_search .search_nowkey li").on("click", function(){
			var text2 = jQuery(this).attr("data-text");
			jQuery(".fs_search .csbox input").val(text2);
		});	
		jQuery(".fs_search .search_nowkey p.snkclose").on("click", function(){
			jQuery(".fs_search .search_nowkey").hide();
		});
	}

	var fn_socialLogout = function() {
        var KSESID = jQuery("#KSESID").val();
        var link = document.location.href;
        
		if(devType == 0){
			//document.location.href = "https://testmember.lpoint.com/door/sso/mblLogout.jsp?sid=LOTTEJTB&sch=&returnurl=http://m.lottejtb.com&KSESID=" + KSESID + "&opentype=";
			document.location.href = "https://www.lottejtb.com/jsp/sso/logout_middle_page_mobile.jsp?returnURL="+link;
		}else{
//			document.location.href = "https://member.lpoint.com/door/sso/mblLogout.jsp?sid=LOTTEJTB&sch=&returnurl=http://m.lottejtb.com&KSESID=" + KSESID + "&opentype=";
			//document.location.href = "https://www.lottejtb.com/jsp/sso/logout_middle_page.jsp?KSESID=" + KSESID + "&returnurl=http://m.lottejtb.com";
			document.location.href = "https://www.lottejtb.com/jsp/sso/logout_middle_page_mobile.jsp?returnURL="+link;
			
		}
	};

	
data +='</script>';
data += '<form name="logoutFrm" method="post" style="display:none;"></form>';
data +='	<div data-role="page"  class="bodyWrap">';
data +='	<!-- /header -->';
data +=' 	<div id="header">';
data +=' 		<h1><a href="#" onclick="moveMenu(\'https://m.lottejtb.com/main.do\', 0)">감동의 곁에, 언제나 롯데제이티비</a></h1>';
data +='		<a href="#nav-panel" class="toplnbbtn"><img src="' + homeUrl + '/resources/common/images_ju/btn/Header_Leftmenu.png" alt="" class="lfmenu" /></a>';
data +='       	<a href="#" class="toplogin"><img src="' + homeUrl + '/resources/common/images_ju/btn/Header_Login.png" onclick="javascript:fn_moveMytour();" alt=""/></a>';
data +='		<a href="#" class="tt_searchbtn"><img src="' + homeUrl + '/resources/common/images_ju/btn/Header_Search.png" alt=""/></a>';
data +='		<div class="goods_fixedbox"></div>';

data +='	<div class="swiper-container category-thumbs topgnb" style="position: static; border-top: 1px solid #eee;">';
data +='		<ul class="swiper-wrapper">';
data +='			<li class="swiper-slide"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741\', 0)">패키지</a></li>';
data +='			<li class="swiper-slide"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5743\')">자유여행</a></li>';
data +='			<li class="swiper-slide on swiper-slide-active"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5744\', 0)">항공</a></li>';
data +='			<li class="swiper-slide"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5745\',0)">호텔</a></li>';
data +='			<li class="swiper-slide"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5740\',0)">국내</a></li>';
data +='		</ul>';
data +='	</div>';

data +=' 	</div>';
data +='	<!-- 통합검색폼 -->';
data +='	<div class="main">';
data +='		<div class="total_searchbox">';
data +='			<div class="fs_search">';
data +='				<div class="csbox">';
data +='					<input type="text" data-role="none" id="autoComplete" placeholder="누구와 함께 떠나세요?" onkeyup=\'fn_autoComplete();\'/>';
data +='					<button class="ts_search" type="button" data-role="none" onclick="fn_keywordSearch()">검색</button>';
data +='					<button class="ts_close" type="button" data-role="none">닫기</button>';
data +='					<div class="Mentoring_box" style="display: block;">';
data +='						<h2>여행의 가치를 높인 투어 멘토링시스템</h2>';
data +='						<ul class="Mentoring_box_list">';
data +='							<li attr-val="6571"><a href="#none">부모님</a></li>';
data +='							<li attr-val="6580"><a href="#none">엄마</a></li>';
data +='							<li attr-val="6572"><a href="#none">자녀</a></li>';
data +='							<li attr-val="6573"><a href="#none">연인</a></li>';
data +='							<li attr-val="6574"><a href="#none">부부</a></li>';
data +='							<li attr-val="6576"><a href="#none">친구</a></li>';
data +='							<li attr-val="6581"><a href="#none">형제</a></li>';
data +='							<li attr-val="6593"><a href="#none">가족</a></li>';
data +='							<li attr-val="6582"><a href="#none">친목회</a></li>';
data +='						</ul>';
data +='					</div>';
data +='				</div>';
data +='				<div class="search_nowkey">';
data +='					<ul id="autoWords">';
data +='					</ul>';
data +='					<p class="snkclose">닫기</p>';
data +='				</div>';
data +='			</div>';
data +='		</div>';
data +='	</div>';


data +='	<!-- 돌출메뉴 -->';
data +='	<div id="nav_box">';
data +='		<div id="nav-panel">';
data +='			<ul class="lnb_top">';

var cookie = document.cookie;
var info=document.cookie.split("; ");

var onl_cno = '';
for (var i=0; i<info.length; i++) {
    	 var keyValues = info[i].split("=");
    	 
         if (info[i].replace("/(^\s*)|(\s*$)|($\s*)/g", "").indexOf("onl_cno")==0) {
             onl_cno=info[i].substring(info[i].indexOf("=")+1,info[i].length);
         }
}

if(onl_cno==''||onl_cno==null||onl_cno=='null'){
	//data +='				<li style="width:28%;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/sso/loginChk.do?returnurl='+ location.href +'\', 0)"><span></span><em>로그인</em></a></li>';
	data +='				<li style="width:28%;"><a href="#" onclick="javascript:setLoginPageUrl();"><span></span><em>로그인</em></a></li>';
}else{
	data +='				<li style="width:25%;"><a href="#" onclick="fn_socialLogout();"><span></span><em>로그아웃</em></a></li>';
}
data +='				<li style="width:27%;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/customer/noticeList.do\', 0)"><span></span><em>고객센터</em></a></li>';
data +='				<li style="width:27%;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/corperate/corperate.do\', 0)"><span></span><em>회사소개</em></a></li>';
data +='				<li><a href="#" class="nav_box_close"></a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab lnb_tab1">';
data +='				<li><a href="#" onclick="fn_menuClick(\'5741\')"><span></span><em>패키지</em></a></li>';
data +='				<li><a href="#" onclick="fn_menuClick(\'6592\')"><span></span><em>핏팩</em></a></li>';
data +='				<li><a href="#" onclick="fn_menuClick(\'5743\')"><span></span><em>자유여행</em></a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c1">';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&amp;subCtg=5749\', 2)">유럽/아프리카</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&amp;subCtg=5750\', 2)">동남아</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&amp;subCtg=5751\', 2)">중국</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&amp;subCtg=5752\', 2)">홍콩/대만</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&amp;subCtg=5753\', 2)">일본</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&amp;subCtg=5754\', 2)">괌/사이판/팔라우</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&amp;subCtg=5755\', 2)">호주/뉴질랜드/피지</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&amp;subCtg=5756\', 2)">미주/하와이/중남미</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&amp;subCtg=5923\', 2)">부산출발</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&amp;subCtg=5924\', 2)">광주(무안)출발</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&amp;subCtg=5925\', 2)">대전(청주)출발</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&amp;subCtg=5926\', 2)">대구출발</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&amp;subCtg=6414\', 2)">모바일전용 특가상품</a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c2">';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=6592&amp;subCtg=6594\', 2)">일본</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=6592&amp;subCtg=6600\', 2)">동남아</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=6592&amp;subCtg=6601\', 2)">미주</a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c3">';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/free/main.do\', 2)">자유여행만들기</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5743&amp;subCtg=5775\', 2)">교통패스</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5743&amp;subCtg=5776\', 2)">현지투어/입장권</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5743&amp;subCtg=6323\', 2)">해외에어텔</a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab lnb_tab2">';
data +='				<li><a href="#" onclick="fn_menuClick(\'5744\')"><span></span><em>항공</em></a></li>';
data +='				<li><a href="#" onclick="fn_menuClick(\'5745\')"><span></span><em>호텔</em></a></li>';
data +='				<li><a href="#" onclick="fn_menuClick(\'5740\')"><span></span><em>국내</em></a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c4">';
data +='			   <li style="font-size: 17px;"><a href="https://m.air.lottejtb.com/air/b2c/AIR/MBL/AIRMBLTRP0100100010.k1?KSESID=air:b2c:SELK138AX:SELK138AX::00">해외항공</a></li>';
data +='			   <li style="font-size: 17px;"><a href="https://m.air.lottejtb.com/air/b2c/AIR/MBL/AIRMBLTRP0100100010.k1?domintgubun=D&amp;KSESID=air:b2c:SELK138AX:SELK138AX::00">국내항공</a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c5">';

data +='				<li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/domestic/dmt_detail_domestic.do?url=https://dht.lottejtb.com/alliance/mobile/main.php?AID=LTJTB&amp;ctgname=국내호텔\', 2)">국내호텔</a></li>';
data +='				<li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/free/main.do?tabType=hotel&amp;domesticYn=N\', 2)">해외호텔</a></li>';
data +='				<li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'undefined\', 2)">온라인전용 호텔특가</a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c6">';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5740&amp;subCtg=5807\', 2)">제주도</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5740&amp;subCtg=5808\', 2)">내륙/섬</a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab lnb_tab3">';
data +='				<li><a href="#" onclick="fn_menuClick(\'5746\')"><span></span><em>허니문</em></a></li>';
data +='				<li><a href="#" onclick="fn_menuClick(\'5766\')"><span></span><em>크루즈</em></a></li>';
data +='				<li><a href="#" onclick="fn_menuClick(\'5747\')"><span></span><em>골프</em></a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c7">';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5746&amp;subCtg=5789\', 2)">동남아</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5746&amp;subCtg=5790\', 2)">남태평양</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5746&amp;subCtg=5791\', 2)">유럽</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5746&amp;subCtg=5792\', 2)">미주(하와이)</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5746&amp;subCtg=5793\', 2)">칸쿤/로스카보스</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5746&amp;subCtg=5794\', 2)">몰디브</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5746&amp;subCtg=6334\', 2)">모리셔스</a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c8">';
data +='				 <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/list.do?ctg=5990&amp;orderby=01\', 2)">유럽</a></li>';
data +='				 <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/list.do?ctg=5991&amp;orderby=01\', 2)">미주/중남미</a></li>';
data +='				 <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/list.do?ctg=5992&amp;orderby=01\', 2)">아시아/한중일</a></li>';
data +='				 <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/cruise/cruise_view.do\', 2)">적립식 크루즈</a></li>';
data +='				 <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/list.do?ctg=6306&amp;orderby=01\', 2)">특별기획크루즈</a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c9">';

data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5747&amp;subCtg=5799\', 2)">동남아</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5747&amp;subCtg=5800\', 2)">중국</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5747&amp;subCtg=5801\', 2)">일본</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/list.do?ctg=5802&amp;orderby=01\', 2)">괌/사이판</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/list.do?ctg=6455&amp;orderby=01\', 2)">지방출발</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/list.do?ctg=6547&amp;orderby=01\', 2)">프리미엄</a></li>';
data +='			   <li style="font-size: 17px;"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/list.do?ctg=6548&amp;orderby=01\', 2)">국내</a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab lnb_tab4">';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/event/event_list.do\', 0)"><span></span><em>이벤트</em></a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/planning/planning.do\', 0)"><span></span><em>기획전</em></a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/customer/coupon.do#tab2\', 0)"><span></span><em>제휴서비스</em></a></li>';
data +='			</ul>';
//data +='			<ul class="lnb_tab_c lnb_tab_c12">';
//data +='			   <li><a href="#" onclick="moveMenu(\'' + homeUrl +'/corperate/corperate.do\', 0)" class="ui-link">회사소개</a></li>';
//data +='			   <li><a href="#" onclick="moveMenu(\'' + homeUrl +'/corperate/corperate_info.do\', 0)" class="ui-link">법인상용</a></li>';
//data +='			   <li><a href="#" onclick="moveMenu(\'' + homeUrl +'/corperate/corperate_lpoint.do\', 0)" class="ui-link">L.POINT 회원안내</a></li>';
//data +='			   <li><a href="#" onclick="moveMenu(\'' + homeUrl +'/shop/shopList.do\', 0)" class="ui-link">매장안내</a></li>';
//data +='			</ul>';
data +='			<ul class="lf_sns">';
data +='				<li><a href="#" onclick="moveLink(\"https://blog.naver.com/lottejtbblog\", \"_blank\")"><span></span><span>롯데제이티비 BLOG</span></a></li>';
data +='				<li><a href="#" onclick="moveLink(\"https://story.kakao.com/ch/lottejtb/\", \"_blank\")"><span></span><span>롯데제이티비 KAKAO STORY</span></a></li>';
data +='				<li><a href="#" onclick="moveLink(\"https://m.facebook.com/lottejtbofficial/\", \"_blank\")"><span></span><span>롯데제이티비 FACEBOOK</span></a></li>';
data +='				<li><a href="#" onclick="moveLink(\"https://www.instagram.com/lottejtb_official/\", \"_blank\")"><span></span><span>롯데제이티비 INSTAGRAM</span></a></li>';
data +='			</ul>';
data +='			<ul class="lf_golink">';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/customer/travel_clause.do\', 0);">여행약관</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/customer/clause.do\', 0);">이용약관</a></li>';
data +='				<li><a href="#" onclick="fn_travelCaluse();">해외여행자 보험약관</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/customer/policy.do\', 0);">개인정보 처리방침</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/corperate/corperate.do?tab=3\',0)">찾아오시는 길</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/shop/shopList.do\', 0)">매장안내</a></li>';
data +='			</ul>';
data +='			<a href="#" onclick="moveMenu(\'' + homeUrl +'/setting/setting.do\', 0)" class="setting_btn ui-link"><span></span><em>설정</em></a>';
data +='		</div>';
data +='	</div>';
data +='	<!-- /header -->';
data +='	<!--content-->';
data +='	<div role="main" class="ui-content contentWrap freesearch">';
data +='  </div>';


document.write(data);
window['_LA']=window['_LA']||function(){
   (window['_LA'].q=window['_LA'].q||[]).push(arguments)
}


