f<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">
	
		var flag = false;
		var list = null;
		var listSize = '${listSize}';		
		var pageSize = "${pageSize}";	
		var faqType = "${faqType}";	
		var jsonListSize;
		var searchTxt = "${searchTxt}";	

		// 초기화
		var fn_init = function() {
			$(".swiper-wrapper").find("div").removeClass("swiper-slide-active");
			$("#type" + faqType).addClass("swiper-slide-active");
		
			fn_faqListAllCount();
		};
		
		var fn_chkType = function(type){
			var returnVal = "";
			switch(String(type)){
				case "10":
					returnVal = "여행상품";
				break;
				case "20":
					returnVal = "항공";
				break;
				case "30":
					returnVal = "호텔";
				break;
				case "40":
					returnVal = "예약/결제";
				break;
				case "50":
					returnVal = "사이트";
				break;
				case "60":
					returnVal = "회원제";
				break;
				default:
					returnVal = "전체";
			}
			
			return returnVal;
		};
				
		// 버튼 초기화
		var fn_initButton = function() {
			
			//더보기버튼
			$(document).on("click", ".more", function(){
				fn_morefaqList();
			});
			
			//검색버튼
			$(document).on("click", ".btn_search", function(){			
				fn_faqListAllCount();
				
			});
		};
		
		
		//swiper 초기화
		var fn_initSwiper = function(){
		
			var faqThumbs = new Swiper('.faq-thumbs', {
				spaceBetween: 0,
				slidesPerView:4,
				touchRatio: 0.1,
		 		loop:true,
	  	 		loopedSlides: 7,
	  	 		paginationClickable: true,
				slideToClickedSlide: true
			});

			var faqContent = new Swiper('.faq-content', {
				spaceBetween: 0,
				paginationClickable: true,
				loop:true,
	    		loopedSlides: 7,			
				slideToClickedSlide: true,
				calculateHeight:true,
				onSlideChangeEnd: function(swiper) {
				
					var thisRow = $(".faq-content").find(".swiper-slide-active").find("li").size();
					
					$(".faq-content").trigger('create');
					
					//확장한 내용 모두닫기
					cfn_collapsibleAll();
					
					//다른항목으로 Swipe했을 때 데이터Row수 재정의 10row 이상 모두 삭제 (UI문제)
					$(".faq-content").find("ul").each(function(){
						$(this).find("li:gt(9)").remove();
					});
					
					$('body,html').animate({
      					scrollTop: 0
    				}, 100);
				}
				
				
			});
	
			faqContent.params.control = faqThumbs;
			faqThumbs.params.control = faqContent;
			
		}
		
		
		/* *************************************************************************** */
		// [COMMON] 공통사항 
		// 공지사항 목록 보기 
		function fn_goNoticeList() {
			document.location.href = "/customer/noticeList.do";
		}
		
		// 자주찾는 질문 목록 보기 
		function fn_goFaqList() {
			document.location.href = "/customer/faq.do";
		}

		//묻고 답하기 목록 보기 
		function fn_goQnaList() {
			document.location.href = "/customer/qnaList.do";
		}

		// 이벤트쿠폰
		function fn_goCouponList() {
			document.location.href = "/customer/coupon.do";
		}
		
		// 자주찾는 질문 목록조회
		var fn_faqFirstList = function(){
			
			var schTxt = "";			
			if(searchTxt == ""){
				schTxt = $("#searchTxt").val();
			}		
			
			var formData = new FormData();
			formData.append('searchKeyword', schTxt);
			
			cfn_ajax({
				url: "<c:url value='/customer/faqFirstListAjax.do' />",
				type: "POST",
				data: formData,
				async: false,
				cache: false,
				dataType: "json",
				noloading:"no",
				success: function(res) {
					list = res.list
					
					var tag = "";
					
					//데이터초기화
					$(".faq-content > .swiper-wrapper").empty();
					
					for(var i = 0; i < 7; i++){
					
						var IndexNo = i*10;
						
						tag += "<div class='swiper-slide' >";
						tag += "	<ul data-role='listView' class='ul_thumb_"+IndexNo+"'>";
						
						var subList = cfn_getData(list, 'beginNo', i); 
						
						if(subList.length > 0){
							for (j = 0; j < subList.length; j++) {
								tag += "<li><div data-role='collapsible' data-collapsed-icon='carat-d' data-expanded-icon='carat-u' data-iconpos='right'>";
								tag += "	<h1 class='ui-nodisc-icon ui-alt-icon'><span>"+fn_chkType(subList[j]["clsCd"])+"</span>"+subList[j]["title"]+"</h1>";
								tag += "		<p><em>Q</em>"+ subList[j]["title"] +"</p>";
								tag += "		<p><em>A</em>";
								if(nullToBlank(subList[j]["bbsCnts"]) != ""){
									tag += "		"+cfn_RemoveHtml(subList[j]["bbsCnts"]).replace(/다\./ig,'다.<br/>');
								}else{
									tag += "		해당되는 내용이 없습니다.";
								}
								tag += "		</p>";
								tag += "	</div>";
								tag += "</li>";
							}
						}else{
								tag += "<li><div data-role='collapsible' data-collapsed-icon='carat-dx' data-expanded-icon='carat-ux' data-iconpos='right'>";
								tag += "	<h1 class='ui-nodisc-icon ui-alt-icon'><span>"+fn_chkType(IndexNo)+"</span>등록된 글이 없습니다.</h1>";
								tag += "	</div>";
								tag += "</li>";
						}
						
						delete subList;
						
						tag += "	</ul>";
						tag += "</div>";
					}
					
					$(".faq-content > .swiper-wrapper").append(tag);
					
					
				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
				
					fn_initSwiper();
					
					$(".faq-content > .swiper-wrapper").trigger('create');
					
				}
			});
		};
		
		//각항목 전체카운트 설정
		var fn_faqListAllCount = function(){
		
			var schTxt = "";			
			if(searchTxt == ""){
				schTxt = $("#searchTxt").val();
			}			
		
			var formData = new FormData();
			formData.append('searchKeyword', schTxt);
			
			cfn_ajax({
				url: "<c:url value='/customer/faqListAllCountAjax.do' />",
				type: "POST",
				data: formData,
				async: false,
				cache: false,
				dataType: "json",
				noloading:"no",
				success: function(res) {
					list = res.list
					jsonListSize = list;
					//jsonListSize = JSON.parse(decodeURIComponent(listSize));
				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
					fn_faqFirstList();
				}
			});
		};
	
		// 자주찾는 질문 목록조회 더보기
		var fn_morefaqList = function(type){
		
			var curRow = Number($(".faq-content").find(".swiper-slide-active").find("li").size());
			var indexNo = $(".faq-thumbs").find(".swiper-slide-active").attr("id").replace("type","")
			var thisSize = jsonListSize["type" + indexNo];
			
			var startRow = curRow + 1;
			var endRow = curRow + Number(pageSize);
			
			
			if(startRow > thisSize) {
				alert("더이상 등록된 글이 없습니다");
				return;
			}
			
			var formData = new FormData();
			formData.append('clsCd', indexNo);
			formData.append('startRow', startRow);
			formData.append('endRow', endRow);
			formData.append('searchKeyword', searchTxt);
			
			cfn_ajax({
				type: "POST",
				async: false,
				url: "<c:url value='/customer/moreFaqListAjax.do' />",
				data: formData,
				dataType: "json",
				cache: false,
				noloading:"no",
				success: function(res) {
					list = res.list
						
					var i;
					for (i = 0; i < list.length; i++) {
						var tag = "";
						tag += "<li><div data-role='collapsible' data-collapsed-icon='carat-d' data-expanded-icon='carat-u' data-iconpos='right'>";
						tag += "	<h1 class='ui-nodisc-icon ui-alt-icon'><span>"+fn_chkType(list[i]["clsCd"])+"</span>"+list[i]["title"]+"</h1>";
						tag += "		<p><em>Q</em>"+ list[i]["title"] +"</p>";
						tag += "		<p><em>A</em>";
						if(nullToBlank(list[i]["bbsCnts"]) != ""){
							tag += "		"+cfn_RemoveHtml(list[i]["bbsCnts"]).replace(/다\./ig,'다.<br/>');
						}else{
							tag += "		해당되는 내용이 없습니다.";
						}
						tag += "		</p>";
						tag += "	</div>";
						tag += "</li>";
						$(".ul_thumb_"+indexNo).append(tag);
					}
					
				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
				
					$(".faq-content").trigger('create');
				}
			});
		};
		
		
		$(document).ready(function(){
		
			fn_init();
			fn_initButton();
			
			/*document.addEventListener("deviceready", function(){
				fn_init();
			}, false);*/
		});
	
</script>
</head>
<body>
	<!--content-->    
	<div role="main" class="ui-content contentWrap">
	   <div data-role="navbar" data-iconpos="right" class="nav">
			<ul>
				<!-- <li><a href="#navPop"  data-rel="popup" data-icon="carat-d" class="ui-nodisc-icon ui-alt-icon">고객센터</a></li> -->
				<li><a href="#" class="layerOpener ui-btn-active ui-nodisc-icon ui-alt-icon" data-icon="carat-d" data-url="/customerPop.do" data-width="300" data-height="400" data-ok="yes" data-ctn="full">고객센터</a></li>
			</ul>  
	   </div>
	   <div class="customer collapse">
		<div data-role="navbar" class="tabsnav mgT10">
			<ul>
				<li><a href="javascript:fn_goNoticeList()" data-transition="fade" data-theme="a" data-ajax="false">공지사항</a></li>
				<li><a href="javascript:fn_goFaqList()" data-transition="fade" data-theme="a" data-ajax="false" class="ui-btn-active letterS">자주찾는질문</a></li>
				<li><a href="javascript:fn_goQnaList()"  data-transition="fade" data-theme="a" data-ajax="false">묻고답하기</a></li>
				<li><a href="javascript:fn_goCouponList()"  data-transition="fade" data-theme="a" data-ajax="false">상품권/쿠폰</a></li>
			</ul>
			<div class="search">
				<fieldset>
					<legend>검색</legend>
					<label for="input_search">검색어 입력</label>
					<input id="searchTxt" type="text" title="검색어를 입력하세요." class="input_m"  placeholder="검색어를 입력하세요.">
					<input type="image" class="btn_search" src="/resources/images/btn/btn_search.gif" alt="검색" title="검색" >
				</fieldset>
			</div>
		</div>
		<div class="swiper-container faq-thumbs"><!--제목 스와이프-->
			<div class="swiper-wrapper">
				<div id="type0" class='swiper-slide swiper-slide-active'>전체</div>
				<div id="type10" class='swiper-slide'>여행상품</div>
				<div id="type20" class='swiper-slide'>항공</div>
				<div id="type30" class='swiper-slide'>호텔</div>
				<div id="type40" class='swiper-slide'>예약/결제</div>
				<div id="type50" class='swiper-slide'>사이트이용</div>
				<div id="type60" class='swiper-slide'>회원제</div>
			</div><!--//swiper Wrapper-->
		</div><!--//swiper container-->
		
		<div class="swiper-container faq-content"><!--컨텐츠 스와이프-->
			<div class="swiper-wrapper">
			</div><!--//swiper Wrapper-->
		</div><!--//swiper container-->

		<div class="more"><a href="#"><i class="fa fa-angle-down fa-2x"></i>더보기</a></div>
		<div class="clauseTel mgT10">
			<h1>부서별 전화문의</h1>
			<p><i>상담시간 </i><span style="margin-top:10px">평일: 08:00~17:00</span></p>
		</div>
			<div class="clauseTelBox2" >
				<ul>
					<li><p>국내/해외여행문의</p><span>1577-6511</span></li>
					<li><p>항공권상담</p><span>1899-9633</span></li>
					<li><p>기업체여행</p><span>02-6313-8248</span></li>
					<li><p>국내/해외호텔문의</p><span>02-6313-8000</span></li>
				</ul>
			</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div><!--customer collapse End-->
  </div><!--//contentWrap End-->
  <!--//content-->
</body>