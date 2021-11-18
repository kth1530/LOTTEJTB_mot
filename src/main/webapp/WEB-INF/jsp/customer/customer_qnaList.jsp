<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">
	
		var maxSize = 0;		
		var pageSize = "${pageSize}";	
		var searchTxt = "";	
		var startRow = 0;
		var endRow = 0;
		var scrollTopHeight = 0; //스크롤이동시 수시로변경하는 높이값
		var listTop = 0;         //상세보기 클릭시 현재 스크롤위치 저장 변수
		var param_consultCd = "${param_consultCd}";

		// 초기화
		var fn_init = function() {
			if(nullToBlank(param_consultCd) == ""){
				fn_qnaListCount();
			}else{
				fn_goQnaDetail(param_consultCd);
			}
		};
				
		// 버튼 초기화
		var fn_initButton = function() {
			
			//더보기버튼
			$(document).on("click", "#moreBtn", function(){
				fn_qnaList();
			});
			
			//검색버튼
			$(document).on("click", ".btn_search", function(){			
				fn_qnaListCount();
				
			});
			
			//목록으로
			$(document).on("click", "#goListBtn", function(){
				if(nullToBlank(param_consultCd) == ""){
					$(".search").show();	
					$(".tabsnav").css("height", "100px");	
					$("#qnsList").show();
					$("#moreBtn").show();
					$(".detail").hide();
					$("#goListBtn").hide();
					
					cfn_scrollTop(listTop);
				}else{
					pageBack();
				}
			});
			
		};
		
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
		
		// 묻고답하기 쓰기
		function fn_qnaWrite(){
			document.location.href = "/customer/qnaWrite.do";
		}
		
		// 묻고답하기상세
		function fn_goQnaDetail(seq) {
		
			$(".search").hide();	
			$(".tabsnav").css("height", "");	
			$("#qnsList").hide();
			$("#moreBtn").hide();
			$(".detail").show();
			$("#goListBtn").show();
			    		
			listTop = scrollTopHeight;
    		
    		cfn_scrollTop(0);
			 
			fn_qnaDetail(seq);
			
		}
		
		function fn_scrollTop(){
		}
		
		
		var fn_qnaListCount = function(){
		
			var formData = new FormData();
			formData.append('searchKeyword', $("#searchTxt").val());
			
			cfn_ajax({
				type: "POST",
				async: false,
				url: "<c:url value='/customer/qnaListCountAjax.do' />",
				data: formData,
				dataType: "json",
				cache: false,
				noloading:"no",
				success: function(res) {
					maxSize = res.totalCount;
				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
					fn_qnaList('new');
				}
			});
		};
		
		
		// 묻고답하기 목록조회 더보기
		var fn_qnaList = function(type){
		
			// 페이지 계산
			if(type == "new"){
				$("#qnsList").empty();
				
				startRow = 1;
				endRow = pageSize;	
				
				searchTxt = $("#searchTxt").val();
				
			}else{
			
				var curRow = $("#qnsList").find("li").size();
			
				startRow = curRow + 1;
				endRow = curRow + Number(pageSize);
			
			}
			
			if(type != "new"){
				if(startRow > maxSize) {
					alert("더이상 등록된 글이 없습니다");
					return;
				}
			}
			
			var formData = new FormData();
			formData.append('startRow', startRow);
			formData.append('endRow', endRow);
			formData.append('searchKeyword', searchTxt);
			
			cfn_ajax({
				type: "POST",
				async: false,
				url: "<c:url value='/customer/qnaListAjax.do' />",
				data: formData,
				dataType: "json",
				cache: false,
				//noloading:"no",
				success: function(res) {
					list = res.list
						
					var i;
					for (i = 0; i < list.length; i++) {
						
						var seq = list[i]["consultCd"];
						
						var tag = "";
						tag += "<li onclick='fn_goQnaDetail(\""+list[i]["consultCd"]+"\")'>";
						tag += "<a href='#"+list[i]["consultCd"]+"'>";
						if(nullToBlank(list[i]["consultTypeNm"]) == ""){
							tag += 	"<em class='val'>"+ list[i]["insDt"] +"</em>";
							if(list[i].titleYn == "N"){
								tag += 	"<h3 class='lock'>"+list[i]["consultTitle"]+"</h3>";
							}else{
								tag += 	"<h3>"+list[i]["consultTitle"]+"</h3>";
							}
						}else{
							tag += 	"<em>"+ nullToBlank(list[i]["consultTypeNm"]) +"&nbsp;</em>";
							if(list[i].titleYn == "N"){
								tag += 	"<h3 class='lock'>"+list[i]["consultTitle"]+"</h3>";
							}else{
								tag += 	"<h3>"+list[i]["consultTitle"]+"</h3>";
							}
							tag += 	"<i>"+list[i]["insDt"]+"</i>";
						}
						if(Number(list[i]["ansCnt"]) > 0){
							tag += 	"<span class='fin'>답변완료</span>";
						}else{
							tag += 	"<span class='wait'>답변대기</span>";
						}
						tag += "</a>";
						tag += "</li>";
					
						$("#qnsList").append(tag);
						
					}
					
				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
				
				}
			});
		};
		
		
		var fn_qnaDetail = function(seq){
		
			var formData = new FormData();
			formData.append('consultCd', seq);
			
			$(".detail").empty();
			
			cfn_ajax({
				type: "POST",
				async: false,
				url: "<c:url value='/customer/qnaDetailAjax.do' />",
				data: formData,
				dataType: "json",
				cache: false,
				noloading:"no",
				success: function(res) {
					var detail = res.detail
						
					if(detail){
						
						var tag = "";
						tag += "<li class='header'>";
						tag += "<a href='#'>";
						if(nullToBlank(detail["consultTypeNm"]) == ""){
							tag += 	"<em class='val'>"+ detail["insDt"] +"&nbsp;</em>";
							tag += 	"<h3>"+detail["consultTitle"]+"</h3>";
						}else{
							tag += 	"<em>"+ nullToBlank(detail["consultTypeNm"]) +"&nbsp;</em>";
							tag += 	"<h3>"+detail["consultTitle"]+"</h3>";
							tag += 	"<i>"+detail["insDt"]+"</i>";
						}
						if(Number(detail["ansCnt"]) > 0){
							tag += 	"<span class='fin'>답변완료</span>";
						}else{
							tag += 	"<span class='wait'>답변대기</span>";
						}
						tag += "</a>";
						tag += "</li>";
						
						tag += "<li class='content'>";
						tag += "	<div class='txt'>";
						tag += 		detail["remark"]
						tag += "	</div>";

						tag += "	<div class='txt_answer'>";
						tag += "		<p class='answer'>상담안내</p>";
						tag += "		<p class='answer_txt'>"+detail["consultDesc"]+"</p>";
						tag += "	</div>";
						tag += "</li>";
	
						
						$(".detail").append(tag);
						
					}
					
				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
				
				}
			});
		};
		
		
		$(document).ready(function(){
		
			//목록 이전값 저장위한 scroll event
			$(window).scroll(function(event){
				scrollTopHeight = $(window).scrollTop();
			});
		
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
	   <div class="customer qna">
		 <div data-role="navbar" class="tabsnav mgT10" style="height:100px">
			<ul>
			  <li><a href="javascript:fn_goNoticeList();" data-theme="a" data-ajax="false" >공지사항</a></li>
			  <li><a href="javascript:fn_goFaqList();" data-theme="a" data-ajax="false" class="letterS">자주찾는질문</a></li>
			  <li><a href="javascript:fn_goQnaList();" data-theme="a" data-ajax="false" class="ui-btn-active">묻고답하기</a></li>
			  <li><a href="javascript:fn_goCouponList()" data-theme="a" data-ajax="false" >상품권/쿠폰</a></li>
			</ul>
			<!--nav search-->
			<div class="search">
					<fieldset>
					<legend>검색</legend>
					<label for="input_search">검색어 입력</label>
					<input id="searchTxt" type="text" title="검색어를 입력하세요." class="input_m"  placeholder="검색어를 입력하세요.">
					<input type="image" class="btn_search" src="/resources/images/btn/btn_search.gif" alt="검색" title="검색" >
					</fieldset>
			</div>
		 </div>
		 <div class="tabContent">
		   <ul data-role="listView" class="list" id="qnsList">
				<li>
					<a href="#">
						<em>결제(입금.환불)</em>
						<h3>7월 여행후기 당첨자 발표</h3>
						<i>2016-08-12</i>
						<span class="wait">답변대기</span>
					</a>
				</li>
			</ul>
			
			<ul data-role="listView" class="detail" style="display:none">
			
		    </ul>
		    
		</div>
        <!-- 공지사항 상세 표시 -->
		<!-- 공지사항 목록 더보기 버튼 -->
		<div class="more" id="moreBtn"><a href="#"><i class="fa fa-angle-down fa-2x"></i>더보기</a></div>
		<div class="more btnBG2" onclick="fn_qnaWrite()"><a href="#" class="">작성하기</a></div>
		
		<!-- 공지사항 상세 목록으로 버튼 -->
		<div class="more" id="goListBtn" style="display:none"><a href="#"><i class="fa fa-bars mgr5 list"></i>목록으로</a></div>
		<!-- 공지사항 상세 목록으로 버튼-->
		<!-- 공지사항 목록 더보기 버튼 -->
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
		  </div><!--tabs End-->
	  </div><!--/contentWrap End-->
	<!--/content-->
</body>