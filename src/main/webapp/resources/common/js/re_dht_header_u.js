var data = "";

var homeUrl = "http://m.lottejtb.com";

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
data +='    <script src="' + homeUrl + '/resources/common/js/utils.js" charset="utf-8"></script>';
data +='	<script src="' + homeUrl + '/resources/common/css_ju/jquery-latest.min.js"></script>';
data +='	<script src="' + homeUrl + '/resources/common/css_ju/swiper.js"></script>';
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
		/* 자동완성 */
		jQuery(".tt_searchbtn").on("click", function(){
			jQuery(".total_searchbox").toggleClass("on");
		});
		jQuery(".total_searchbox .ts_close").on("click", function(){
			jQuery(".total_searchbox").removeClass("on");
		});
		autokey();
	});
	/* 자동완성 */

	
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
		if(devType == 0){
			document.logoutFrm.action = "https://testmember.lpoint.com/door/sso/mblLogout.jsp?sid=LOTTEJTB&sch=&returnurl=&opentype="; 
		}else{
			document.logoutFrm.action = "https://member.lpoint.com/door/sso/mblLogout.jsp?sid=LOTTEJTB&sch=&returnurl=&opentype=";
		}
		document.logoutFrm.submit();
	};

	
data +='</script>';
data += '<form name="logoutFrm" method="post" style="display:none;"></form>';
data +='	<div class="bodyWrap">';
data +='	<!-- /header -->';
data +=' 	<div id="header">';
data +=' 		<h1><a href="#" onclick="moveMenu(\'/main.do\', 0)">롯데홀리데이</a></h1>';
data +='		<a href="#nav-panel" class="toplnbbtn"><img src="' + homeUrl + '/resources/common/images_ju/btn/Header_Leftmenu.png" alt="" class="lfmenu" /></a>';
data +='       	<a href="#" class="toplogin"><img src="' + homeUrl + '/resources/common/images_ju/btn/Header_Login.png" onclick="javascript:fn_moveMytour();" alt=""/></a>';
data +='		<a href="#" class="tt_searchbtn"><img src="' + homeUrl + '/resources/common/images_ju/btn/Header_Search.png" alt=""/></a>';
data +='		<div class="goods_fixedbox"></div>';
data +=' 	</div>';
data +='	<div class="swiper-container category-thumbs topgnb">';
data +='		<ul class="swiper-wrapper">';
data +='			<li class="swiper-slide"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741\', 0)">패키지</a></li>';
data +='			<li class="swiper-slide"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5743\')">자유여행</a></li>';
data +='			<li class="swiper-slide"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5744\', 0)">항공</a></li>';
data +='			<li class="swiper-slide"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5745\',0)">호텔</a></li>';
data +='			<li class="swiper-slide"><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5740\',0)">국내</a></li>';
data +='		</ul>';
data +='	</div>';
data +='	<!-- 통합검색폼 -->';
data +='	<div class="total_searchbox">';
data +='		<div class="fs_search">';
data +='		<div class="csbox">';
data +='		<form action = "#" name = "" method = "#">';
data +='		<fieldset>';
data +='		<legend>검색폼</legend>';
data +='		<input type="text" data-role="none" placeholder="도시, 호텔, 인근도시, 공항 등" />';
data +='		<button class="ts_search" type="button" data-role="none">검색</button>';
data +='		<button class="ts_close" type="button" data-role="none">닫기</button>';
data +='		</fieldset>';
data +='		</form>';
data +='	</div>';
data +='	<div class="search_nowkey">';
data +='		<ul>';
data +='			<li>가나다마바사 - 영국</li>';
data +='			<li>가나다마바 - 영국</li>';
data +='			<li>가나다마 - 영국</li>';
data +='			<li>가나다 - 영국</li>';
data +='			<li>가나 - 영국</li>';
data +='			<li>가나다마바사 - 영국</li>';
data +='			<li>가나다마바 - 영국</li>';
data +='			<li>가나다마 - 영국</li>';
data +='			<li>가나다 - 영국</li>';
data +='			<li>가나 - 영국</li>';
data +='			<li>가나다마바사 - 영국</li>';
data +='			<li>가나다마바 - 영국</li>';
data +='			<li>가나다마 - 영국</li>';
data +='			<li>가나다 - 영국</li>';
data +='			<li>가나 - 영국</li>';
data +='		</ul>';
data +='		<p class="snkclose">닫기</p>';
data +='	</div>';
data +='   </div>';
data +=' </div>';


data +='	<!-- 돌출메뉴 -->';
data +='	<div id="nav_box">';
data +='		<div id="nav-panel">';
data +='			<ul class="lnb_top">';

data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/sso/loginChk.do\', 0)"><span></span><em>로그인</em></a></li>';
/*data +='				<li><a href="#" onclick="fn_socialLogout();"><span></span><em>로그아웃</em></a></li>';*/
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/customer/noticeList.do\', 0)"><span></span><em>고객센터</em></a></li>';
data +='				<li><a href="#" class="nav_box_close"></a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab lnb_tab1">';
data +='				<li><a href="#" onclick="fn_menuClick(\'5741\')"><span></span><em>패키지</em></a></li>';
data +='				<li><a href="#" onclick="fn_menuClick(\'5766\')"><span></span><em>크루즈</em></a></li>';
data +='				<li><a href="#" onclick="fn_menuClick(\'5746\')"><span></span><em>허니문</em></a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c1">';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&subCtg=5749\', 0)">유럽/아프리카/인도</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&subCtg=5750\', 0)">동남아</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&subCtg=5751\', 0)">중국</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&subCtg=5752\', 0)">홍콩/대만</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&subCtg=5753\', 0)">일본</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&subCtg=5754\', 0)">괌/사이판/팔라우</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&subCtg=5755\', 0)">호주/뉴질랜드/피지</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&subCtg=5756\', 0)">미주/하와이/중남미</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&subCtg=5923\', 0)">부산출발</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&subCtg=5924\', 0)">광주(무안) 출발</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&subCtg=5925\', 0)">대전(청주) 출발</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5741&subCtg=5926\', 0)">대구출발</a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c2">';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/list.do?ctg=5990&orderby=01\', 0)">유럽</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/list.do?ctg=5766&orderby=01\', 0)">미주/중남미</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/list.do?ctg=5992&orderby=01\', 0)">아시아/한중일</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/list.do?ctg=6306&orderby=01\', 0)">특별기획 크루즈</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/cruise/cruise_view.do\', 0)">적립식 크루즈</a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c3">';
data +='				<li><a href="#"  onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5746&subCtg=5789\', 0)">동남아</a></li>';
data +='				<li><a href="#"  onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5746&subCtg=5790\', 0)">남태평양</a></li>';
data +='				<li><a href="#"  onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5746&subCtg=5791\', 0)">유럽</a></li>';
data +='				<li><a href="#"  onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5746&subCtg=5792\', 0)">미주(하와이)</a></li>';
data +='				<li><a href="#"  onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5746&subCtg=5793\', 0)">칸쿤/로스카보스</a></li>';
data +='				<li><a href="#"  onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5746&subCtg=5794\', 0)">몰디브</a></li>';
data +='				<li><a href="#"  onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5746&subCtg=5795\', 0)">부산출발</a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab lnb_tab2">';
data +='				<li><a href="#" onclick="fn_menuClick(\'5747\')"><span></span><em>골프</em></a></li>';
data +='				<li><a href="#" onclick="fn_menuClick(\'5744\')"><span></span><em>항공</em></a></li>';
data +='				<li><a href="#" onclick="fn_menuClick(\'5745\')"><span></span><em>호텔</em></a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c4">';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5747&subCtg=5799\', 0)">동남아</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5747&subCtg=5800\', 0)">중국</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5747&subCtg=5801\', 0)">일본</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/list.do?ctg=5802&orderby=01\', 0)">괌/사이판</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/list.do?ctg=5803&orderby=01\', 0)">미주(하와이)</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/list.do?ctg=5804&orderby=01\', 0)">특가/연휴</a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c5">';
data +='				<li><a href="#" onclick="moveMenu(\'https://m.air.lottejtb.com/air/b2c/AIR/MBL/AIRMBLTRP0100100010.k1?KSESID=air:b2c:SELK138AX:SELK138AX::00\', 0)">해외 항공</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'https://m.air.lottejtb.com/air/b2c/AIR/MBL/AIRMBLTRP0100100010.k1?domintgubun=D&KSESID=air:b2c:SELK138AX:SELK138AX::00\', 0)">국내 항공</a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c6">';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/domestic/dmt_detail_domestic.do?url=http://m.cp.hotelpass.net/search.asp?cp_agent=jtbmo&ctgname=호텔\', 0)">해외 호텔</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/domestic/dmt_detail_domestic.do?url=http://dht.lottejtb.com/alliance/mobile/main.php?AID=LTJTB&ctgname=국내호텔\', 0)">국내 호텔</a></li>';
/*data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5745&subCtg=6340\', 0)">롯데호텔 &amp; 부여리조트</a></li>';*/
data +='			</ul>';
data +='			<ul class="lnb_tab lnb_tab3">';
data +='				<li><a href="#" onclick="fn_menuClick(\'5743\')"><span></span><em>자유여행</em></a></li>';
data +='				<li><a href="#" onclick="fn_menuClick(\'5740\')"><span></span><em>국내</em></a></li>';
data +='				<li><a href="#" onclick="fn_menuClick(\'5748\')"><span></span><em>샤롯데로얄</em></a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c7">';
data +='				<li><a href="#" onclick="setAlert(\'서비스 점검중입니다.\'); return false;">자유여행만들기</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5743&subCtg=5775\', 0)">패스</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5743&subCtg=5776\', 0)">현지투어/입장권</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5743&subCtg=63239\', 0)">에어텔</a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c8">';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5740&subCtg=5807\', 0)">제주도</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5740&subCtg=5808\', 0)">내륙/섬</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/list.do?ctg=5811&orderby=01\', 0)">아! 대한민국</a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c9">';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5748&subCtg=6269\', 0)">로얄 패키지</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/goods/categoryOther.do?ctg=5748&subCtg=6278\', 0)">로얄 스테이</a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab lnb_tab4">';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/event/event_list.do\', 0)"><span></span><em>이벤트</em></a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/planning/planning.do\', 0)"><span></span><em>기획전</em></a></li>';
data +='				<li><a href="#"><span></span><em>회사소개</em></a></li>';
data +='			</ul>';
data +='			<ul class="lnb_tab_c lnb_tab_c12">';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/corperate/corperate.do\', 0)">회사소개</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/corperate/corperate_info.do\', 0)">법인상용</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/corperate/corperate_lpoint.do\', 0)">L.POINT회사소개</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/shop/shopList.do\', 0)">매장안내</a></li>';
data +='			</ul>';
data +='			<a href="#" onclick="moveMenu(\'' + homeUrl +'/setting/setting.do\', 0)" class="setting_btn ui-link"><span></span><em>설정</em></a>';
data +='			<ul class="lf_sns">';
data +='				<li><a href="http://blog.naver.com/lottejtbblog"><span></span><span>Lotte Holidays 블로그</span></a></li>';
data +='				<li><a href="https://story.kakao.com/ch/lottejtb/"><span></span><span>Lotte Holidays 카카오스토리</span></a></li>';
data +='				<li><a href="https://m.facebook.com/lotteholiday/"><span></span><span>Lotte Holidays 페이스북</span></a></li>';
data +='				<li><a href="https://www.instagram.com/lotteholidays/"><span></span><span>Lotte Holidays 인스타램</span></a></li>';
data +='			</ul>';
data +='			<ul class="lf_golink">';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/customer/travel_clause.do\', 0);">여행약관</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/customer/clause.do\', 0);">이용약관</a></li>';
data +='				<li><a href="#" onclick="fn_travelCaluse();">해외여행자 보험약관</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/customer/policy.do\', 0);">개인정보 처리방침</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/corperate/corperate.do?tab=3\',0)">찾아오시는 길</a></li>';
data +='				<li><a href="#" onclick="moveMenu(\'' + homeUrl +'/shop/shopList.do\', 0)">매장안내</a></li>';
data +='			</ul>';
data +='		</div>';
data +='	</div>';
data +='	<!-- /header -->';
data +='	<!--content-->';
data +='	<div role="main" class="ui-content contentWrap freesearch">';
data +='  </div>';


document.write(data);
