<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<head>
<script type="text/javascript">
	var ctg = '${ctg}';
	var subCtg = '${subCtg}';
	
	var ctgLink = {
		'6296' : '/cruise/cruise_view.do',
		'5774' : '/free/main.do',
		'6049' : 'https://m.air.lottejtb.com/air/b2c/AIR/MBL/AIRMBLTRP0100100010.k1?KSESID=air:b2c:SELK138AX:SELK138AX::00',
		'6050' : 'https://m.air.lottejtb.com/air/b2c/AIR/MBL/AIRMBLTRP0100100010.k1?domintgubun=D&KSESID=air:b2c:SELK138AX:SELK138AX::00#',
		'6339' : 'https://mhotel2.lottejtb.com:44011/search.asp?hoteltype=0', 
	    //'6339' : '/free/main.do?tabType=hotel&domesticYn=N',
		//'6338' : '/free/main.do?tabType=hotel&domesticYn=Y',
		//'6339' : '/domestic/dmt_detail_domestic.do?url=http://m.cp.hotelpass.net/search.asp?cp_agent=jtbmo&ctgname=호텔',
		'6338' : '/free/mainDome.do?tabType=hotel&domesticYn=Y',
		/* '6338' : '/domestic/dmt_detail_domestic.do?url=http://dht.lottejtb.com/alliance/mobile/main.php?AID=LTJTB&ctgname=국내호텔', */
		'6340' : '/fit/htl/lottehotel.do',
		'6401' : 'http://m.dht3.lottejtb.com/spprice/special_price.html?agt=JTB',
		'6402' : 'http://m.dht3.lottejtb.com/item/air.html?agt=JTB',
		'6403' : 'http://m.dht3.lottejtb.com/item/ld_main.html?agt=JTB',
		'6404' : 'http://m.dht3.lottejtb.com/item/ren_main.html?agt=JTB',
		'6405' : 'http://m.dht3.lottejtb.com/item/ss_main.html?agt=JTB',
		'6406' : 'http://m.dht3.lottejtb.com/item/pac_main_list.html?pacitem=03&agt=JTB'
	}
	
	// 초기화
	var fn_init = function() {
	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	var subCategoryList = function() {
		
		var formData = new FormData();		
		formData.append('ctgCode', ctg);
		
		console.log("11111111111111111");
		console.log("ctg------>"+ctg);
		console.log("11111111111111111");
		
		cfn_ajax({
			url: "/goods/categoryOtherListAjax.do",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:true,
			success: function(res) {
				var list = res.list;
				var vHTML = "";
				
				for(var i = 0; i < list.length; i++) {
					console.log("11111111111111111");
					console.log("AAAAAAAAAAAAAAA"+list[i].ctgSeq);
					console.log("11111111111111111");
					vHTML += '<li id="div_ctg_'+ list[i].ctgSeq +'">';
					
					//차량서비스 메뉴는 _blank옵션으로 windown.open해준다.
					if(list[i].ctgSeq == 6649){
						vHTML += '	<a href="https://lottejtb.movv.co/" data-role="none" target="_blank" data-role="none">';
					}else{
						vHTML += '	<a href="#" data-role="none" onclick="subCategoryList2('+ list[i].ctgSeq +', this)">';
					}
					vHTML += '		<p>';
					vHTML += '			<em class="ico_'+ list[i].ctgSeq +'"></em>';
					vHTML += '			<span>'+ list[i].ctgNm +'</span>';
					vHTML += '		</p>';
					vHTML += '	</a>';
					if(list[i].ctgCnt > 0){
						vHTML += '	<ul id="ctg_'+ list[i].ctgSeq +'">';
						vHTML += '	</ul>';	
					}
					vHTML += '</li>';
					/*
					vHTML += '<div data-role="collapsible" data-iconpos="right" id="div_ctg_'+ list[i].ctgSeq +'">';
					vHTML += '	<h1 class="ui-nodisc-icon ui-alt-icon" data-index="1" onclick="subCategoryList2('+ list[i].ctgSeq +', this)">'+ list[i].ctgNm +'</h1>';
					vHTML += '	<ul id="ctg_'+ list[i].ctgSeq +'">';
					vHTML += '	</ul>';
					vHTML += '</div>';
					*/
				}
				
				$("#tab1").html(vHTML);
			},
			error:function(err){
			},
			complete:function(){
				// 강제로 실행하자 마자 클릭 이벤트 준다. 
				if(nullToBlank(subCtg) != ""){
					setTimeout(function(){
						var selectedTag = "#div_ctg_" + subCtg;
						//$(selectedTag).collapsible( "option", "collapsed", false );
						$(selectedTag).find('a').click();
						if(subCtg != null && subCtg != '' && subCtg != 'undefined') {
							scrollLink(selectedTag);
						}
					}, 100);
				}
				
				fn_categoryCss();
			}
		});
	};

	var subCategoryList2 = function(ctg, thisT) {
		/* if(ctg == "6339"){
			alert('서비스 준비중입니다.');
			return;
		} */
		
		console.log("2222222222222222222");
		console.log("ctg------>"+ctg);
		console.log("thisT------>"+thisT);
		console.log("2222222222222222222");
		
		if(nullToBlank($("#ctg_"+ctg).html()).trim() == ""){
			var formData = new FormData();
			formData.append('ctgCode', ctg);
			
			cfn_ajax({
				url: "/goods/categoryOtherListAjax.do",
				type: "POST",
				data: formData,
				async: false,
				cache: false,
				dataType: "json",
				noloading:true,
				success: function(res) {
					var list = res.list;
					if(list.length == 0){
						$(thisT).children('a').css('color', '#7b4eb9');
						moveCategoryMenu(ctg);
					}else{
						vHTML = "";	
						if($(thisT).data('index') > 1){
							$("#ctg_"+ctg).parent().parent().children('li').removeClass('on');
							$("#ctg_"+ctg).parent().parent().children('li').removeClass('clear');
							
							var nextIndex = $("#ctg_"+ctg).parent().index() + 2;
							if(nextIndex % 2 == 0){
								$("#ctg_"+ctg).parent().parent().children('li').eq(nextIndex).addClass('clear');
							}
							
							$(thisT).addClass('on');
							
							for(var i = 0; i < list.length; i++){
								vHTML += "<li onclick='moveCategoryMenu("+ list[i]['ctgSeq'] +", 2)'><a href='#'><span>"+ list[i]['ctgNm'] +"</span></a></li>";
							}
						}else{
							$(thisT).addClass('on');
							
							
							for(var i = 0; i < list.length; i++){
							console.log("2222222222222222222");
							console.log("listctgseq------------->"+list[i].ctgSeq);
							console.log("2222222222222222222");
							
							if(list[i].ctgSeq == "6647"){
								vHTML += '<li data-index="2" onclick="subCategoryList2('+ list[i].ctgSeq +', this)"><a href="https://fit.lottejtb.com/page/lotterentcar/main.do" data-theme="a" data-ajax="false"><span>'+ list[i]['ctgNm'] +'</span></a>';
							}else{
								vHTML += '<li data-index="2" onclick="subCategoryList2('+ list[i].ctgSeq +', this)"><a href="#" data-theme="a" data-ajax="false"><span>'+ list[i]['ctgNm'] +'</span></a>';
							}
							
								//vHTML += '<li data-index="2" onclick="subCategoryList2('+ list[i].ctgSeq +', this)"><a href="#" data-theme="a" data-ajax="false"><span>'+ list[i]['ctgNm'] +'</span></a>';
								vHTML += '	<ul id="ctg_'+ list[i].ctgSeq +'">';
								vHTML += '	</ul>';
								vHTML += '</li>';
							}
						}
						
						$("#ctg_"+ctg).html(vHTML);
					}
				},
				error:function(err){
				},
				complete:function(){
				}
			});
		}else{
			$("#ctg_"+ctg).parent().parent().children('li').removeClass('on');
			$("#ctg_"+ctg).parent().parent().children('li').removeClass('clear');
			
			var nextIndex = $("#ctg_"+ctg).parent().index() + 2;
			if(nextIndex % 2 == 0){
				$("#ctg_"+ctg).parent().parent().children('li').eq(nextIndex).addClass('clear');
			}
			
			$(thisT).addClass('on');
		}
	};
	
	var moveCategoryMenu = function(val){
		if(nullToBlank(ctgLink[val]) != ""){
			if(val == '6401' || val == '6402' || val == '6403' || val == '6404' || val == '6405' || val == '6406'){
				moveLink(ctgLink[val], '_system');
				return false;
				//document.write('<' + 'script src="http://m.dht3.lottejtb.com/?jtb_script=JTB"' + ' type="text/javascript"><' + '/script>');
				//document.write('<' + 'script src="http://m.dht3.lottejtb.com/?jtb_script=JEJU"' + ' type="text/javascript"><' + '/script>');
			}else if(val == '6049' || val == '6050'){
				/**
				if(accessType == "app"){
					location.href = "topasApp://";
					return false;
				}*/
				moveLink(ctgLink[val], '_system');
				return false;
			} 
			document.location.href = ctgLink[val];
		}else{
			if(val == '6407') //버스여행 테마캠프
				//document.location.href = "/domestic/dmt_detail_domestic.do?url=http://mlottejtb.themecamp.co.kr&ctgname=버스여행";
				moveLink('http://mlottejtb.themecamp.co.kr', '_blank');
			else
				document.location.href = "/goods/list.do?ctg=" + val + "&orderby=01";	
		}
	};

	// 검색하기 
	var fn_GoSearch = function() {
		/*
		var frmSearch = document.frmSearch;
		frmSearch.action = "/search/search.do";
		frmSearch.orderby.value = "01";
		frmSearch.ctg.value = ctg;
		searchKeyword = document.all.searchKeyword.value;
		*/
		if(check_param()) {
			document.location.href="/search/search.do?ctg=" + ctg + "&orderby=01&searchKeyword="+$("#searchKeyword").val();
		}
	};
	
	function check_param() {
		//var frmSearch = document.frmSearch;
		var flag = false;
	
		if(nullToBlank($("#searchKeyword").val()) == "") {
			$("#searchKeyword").focus();
			setAlert("검색어를 입력해 주세요.");
			flag = false;
		} else {
			flag = true;
		}
		
		return flag;
	}
	
	var fn_categoryCss = function(){
		jQuery(".ctgr_list > li").each(function(){
			if(!jQuery(this).find("ul").text()) jQuery(this).addClass("none_active");
		})
		jQuery(".ctgr_list > li > ul > li > ul").each(function(){
			var deps_index = jQuery(this).find("li").size();
			if (deps_index % 2 == 0){}else{jQuery(this).append("<li></li>");};
		})
		jQuery(".ctgr_list > li > a").on("click",function(){
			if(jQuery(this).parent().hasClass("active")==true){
				jQuery(this).parent().toggleClass("active");
				jQuery(".ctgr_list > li > a p").removeClass("addon");
			}else{
				jQuery(".ctgr_list > li").removeClass("active");
				jQuery(".ctgr_list > li > a p").removeClass("addon");
				jQuery(this).parent().addClass("active");
				jQuery(this).find("p").addClass("addon");
			}
		});
		jQuery(".ctgr_list > li > ul > li > a").on("click",function(){
			if(jQuery(this).parent().hasClass("on")==true){
				jQuery(this).parent().toggleClass("on");
				jQuery(".ctgr_list > li > ul > li").removeClass("clear");
				
			}else{
				jQuery(".ctgr_list > li > ul > li").removeClass("on");
				jQuery(this).parent().addClass("on");
			}
		});
	}
	
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();
		// 상품 전시 페이지 CSS 스타일을 맞춰줌 
		$(".bodyWrap").addClass("goods");
		
		if(ctg == "5746"){
			$("#titleText").text("허니문");
		}else if(ctg == "5747"){
			$("#titleText").text("골프");
		}else if(ctg == "5748"){
			$("#titleText").text("샤롯데로얄");
		}else if(ctg == "5759"){
			$("#titleText").text("지방출발");
		}else if(ctg == "5766"){
			$("#titleText").text("크루즈");
		}else if(ctg == "5744"){
			$("#titleText").text("항공");
		}else if(ctg == "5745"){
			$("#titleText").text("호텔");
		}else if(ctg == "5743"){
			$("#titleText").text("자유여행");
		}else if(ctg == "5740"){
			$("#titleText").text("국내");
		}else if(ctg == "5741"){
			$("#titleText").text("패키지");
		}else if(ctg == "6592"){
			$("#titleText").text("핏팩");
		}else if(ctg == "6615"){
			$("#titleText").text("비즈니스석");
		}

		// 카테고리 정보 조회 
		subCategoryList();

		// >>>>>>>>>>>>>>>>>>>>>> 자바스크립트 동적 로딩 >> 서브 카테고리 표시가 안되는 부분 때문에 추후 로딩하도록 바꿈 >>>>>>>>>>>>>>>>>>>>>>>>>>>	
		var s = document.createElement('script');
		s.setAttribute('src', '/resources/common/js/common.js');
		s.setAttribute('type', 'text/javascript');
		document.getElementsByTagName('head')[0].appendChild(s);
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		
		$(".mg0").trigger("create");
		$(".ctgMenu").trigger("create");
	});
	
	// 해당 위치로 이동함. 
	function scrollLink(obj){
		var position = $(obj).offset();
		
		if(nullToBlank(position) != ""){
			setTimeout(function(){
				$('html, body').animate({scrollTop : (position.top  - 95)}, 100);
			}, 100);
		}
	}
</script>
</head>
<body>

	<!--content-->
	<div role="main" class="ui-content contentWrap categoryBox">
		<div class="navstitle" id="titleText">항공</div>
<!-- 		<div class="search">
			<fieldset> -->
				<!-- form name="frmSearch" method="get"  -->
<!-- 				<input type="hidden" name="orderby" value="01"/>
				<input type="hidden" name="ctg" value=""/>
				<legend>검색</legend>
				<label for="input_search">검색어 입력</label>
				<input type="text" title="검색어를 입력하세요." class="input_m"  placeholder="검색어를 입력하세요." id="searchKeyword"  name="searchKeyword" value="" onkeypress="if( event.keyCode==13 ){fn_GoSearch();}">
				<input type="image" class="btn_search" src="/resources/images/btn/btn_search.gif" alt="검색" title="검색" onclick="fn_GoSearch();"> -->
				<!-- /form -->
<!-- 			</fieldset>
		</div>
 -->			
		<div>
			<!-- 
			<div class="tabContent category ctgMenu" id="tab1">
			</div>
			 -->
			<ul class="ctgr_list" id="tab1">
			</ul>
			<!--bottom-->
			<script src="/resources/common/bottom.js"></script>
			<!--bottom-->
		</div><!--category End-->
	</div><!--//contentWrap End-->
	<!--//content-->