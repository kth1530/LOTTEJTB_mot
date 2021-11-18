<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="com.lottejtb.util.*"%>
<%@ page import="com.lottejtb.goods.service.*"%>
<%@ page import="com.lottejtb.comm.util.CommInfo"%>
<%

	String goodsCd = (String) request.getAttribute("goodsCd");
	String ctg = (String) request.getAttribute("ctg");
	String eventCd = (String) request.getAttribute("eventCd");

	List eventMstList = (List) request.getAttribute("eventMstList"); // 행사 이벤트 
	List goodsImgList = (List) request.getAttribute("goodsImgList"); // 행사 이미지 배너 
	List eventAllSchdList = (List) request.getAttribute("eventAllSchdList"); // 행사 스케쥴 리스트 (일정표)
	List goodsReviewList = (List) request.getAttribute("goodsReviewList"); // 상품평 리스트 
	List eventCommSchdList = (List) request.getAttribute("eventCommSchdList"); // 행사 상세 일반 
	Integer reviewTotalSize = (Integer) request.getAttribute("reviewTotalSize"); // 상품평 총 갯수 
	Integer totalSize = (Integer) request.getAttribute("totalSize"); // 행사 리스트 총갯수 
	EventGroupAllSchdDTO eventGroupAllSchdDTO = (EventGroupAllSchdDTO) request.getAttribute("eventGroupAllSchdDTO"); // 행사 상세 일정표 

	EventMstListVO eventMstDTO = null;



	if(totalSize.intValue() > 0) {
		// 행사 상품에 해당하는 품목을 조회한다. 
		// event_cd 가 동일할 경우 빠져 나오도록 한다. 
		for(int idx = 0; idx < eventMstList.size(); idx++) {
			eventMstDTO = (EventMstListVO) eventMstList.get(idx);

			if(eventCd.equals(eventMstDTO.getEvent_cd())) {
				break;
			}
		}
	}

	String reservTag = "";

	int rvCnt = eventMstDTO.getRv_cnt();
	int evInwon = eventMstDTO.getEv_inwon();
	String lockUnit = eventMstDTO.getLock_unit();
	String procCd = eventMstDTO.getProc_cd();

	if (rvCnt >= evInwon) {
		reservTag =  "예약마감";
	} else {
		if (evInwon == 0) {
			reservTag = "예약마감";
		} else {
			if (procCd != null && procCd.equals("RE")) {
				reservTag = "예약마감";
			} else {
				if (lockUnit != null && lockUnit.equals("Y")) {
					reservTag = "예약마감";
				} else {							
					if (procCd != null && procCd.equals("SE")) {
						reservTag = "출발가능";
					} else {
						reservTag = "예약";
					}
				}
			}
		}
	}
%>

<head>
	<!-- 스와이프 -->
	<script src="/resources/common/js/swiper.js"></script>	
	<script type="text/javascript">
	<!--
        // require(["jquery","jquery.blockUI","jquery.mobile"], function($){
        // require(["jquery","jquery.blockUI"], function($){
		var knm = "${knm}";
		var cust_cd = "${cust_cd}";
		var email = "${email}";

		var flag = false;
		var list;
		var listSize 	= '${listSize}';	
		var reviewTotalCount = 0; // 상품평 리스트 총 갯수 
		var eventMstList =  null; // 여행 상품 정보 
		var goodsReviewList = null; // 상품평 리스트 
		var eventCommSchdList = null; // 행사 정보 및 일정표 
		var eventGroupAllSchdList = null; // 전체 행사 상품 리스트 
		var eventMstDTO = null; // 행사 상품 마스터 
		var division = "E";  // 전시항목 
		var pageSize 	= 2;
		var ctg 		= '${ctg}';
		var eventCd 	= '${eventCd}';
		var goodsCd 	= '${goodsCd}';
		var curRow 		= 2;
		var start_day = "<%=eventMstDTO.getStart_day()%>";
		var dispNm = "<%=eventMstDTO.getDisp_nm()%>";

		// 초기화
		var fn_init = function() {
			// 상품 카테고리 정보 
			fn_goodsCtg2();
            // 찜하기 셋팅
            <%
                GoodsImgVO goodsImgVO_cookie = (GoodsImgVO) goodsImgList.get(0);                                    
            %>
            
            //var imagePath = "http://www.lottejtb.com/upload/common/goods/" + "<!%=goodsCd.substring(0, 2)%>" + "/" + "<!%=goodsCd%>" + "/" + "<!%=goodsImgVO_cookie.getSave_file_nm()%>";
            var imagePath = "/m_file/upload/common/goods/" + "<%=goodsCd.substring(0, 2)%>" + "/" + "<%=goodsCd%>" + "/" + "<%=goodsImgVO_cookie.getSave_file_nm()%>";
            setTodayEvents(eventCd, ctg, imagePath, "<%=eventMstDTO.getDisp_nm()%>", "<%=eventMstDTO.getEv_day_cnt()%>", "<%=eventMstDTO.getEv_night_cnt()%>", "<%=eventMstDTO.getAdult_price()%>", "<%=eventMstDTO.getCd_nm()%>");
			
			// 상품평 리스트 조회 
			// fn_ReviewList();

		
		};
		
		function sessionCheck() {
			if(fn_chkLogin() == 1) {
			} else {
				fn_goLogin();
			}
		}


		var fn_search = function(){
			
		};
		
				
		// 버튼 초기화
		var fn_initButton = function() {
		
		};
				
		// 스와이프 초기화 
		var fn_InitSwipper = function() {

		   	 var gallery = new Swiper('.imgGallery', {
			 
			 //  pagination: '.swiper-pagination1',
				 pagination: '.swiper-pagination',
				 spaceBetween: 0,
				 paginationClickable: true,
				 loop:true,
			  	 loopedSlides: 2, //looped slides should be the same  			
			});					
		}

		// 상품 리스트 화면으로 이동 
		function fn_goList() {
			//console.log(">>>>>>>>>>>>>>>>>> go list >>>>>>>>>>>>>>>>>>>>>>>>>>");
			
			document.location.href = "/goods/list.do?ctg=" + ctg + "&orderby=01";
		}

		// 마이투어 > 찜한 내역 화면 
		function fn_goMyTour() {

			//console.log(">>>>>>>>>>>>>>>>>> 마이투어 > 찜한 내역  >>>>>>>>>>>>>>>>>>>>>>>>>>");
			
			location.hash = "";
			
			document.location.href="/mytour/mytour.do#tab2";
		}

		// 다른 출발일 보기 
		function fn_goMaster() {
			document.location.href="/goods/master.do?ctg="+ctg+"&goodsCd="+goodsCd+"&eventCd="+eventCd;
		}

		function fn_goReserve() {
			//비로그인 상태
			if(cust_cd == null || cust_cd == "")
				document.location.replace("/sso/nologinPage.do?ctg="+ctg+"&goodsCd="+goodsCd+"&eventCd="+eventCd);
			 else  //로그인상태
				document.location.replace("/reserve/reserve_clause.do?ctg="+ctg+"&goodsCd="+goodsCd+"&eventCd="+eventCd);
		}

		// 상품평 작성 
		function fn_goReview() {
			document.location.href="/goods/pop_review.do?ctg="+ctg+"&goodsCd="+goodsCd+"&eventCd="+eventCd+"&goodsNm=<%=eventMstDTO.getDisp_nm()%>";
			/**
			if(fn_chkLogin() == 1) {
			} else {
				fn_goLogin();
			}
			**/
		}
		

		/* *************************************************************************** */
		// [AJAX] 데이타 통신 부분 
		
		// 상품 찜하기 
		var fn_saveCart = function() {
			// 미 로그인 시 

			if(fn_chkLogin() == 1) {
				var frmGoodsDetail = document.frmGoodsDetail;
				
				var start_day = "<%=eventMstDTO.getStart_day()%>";
				var formData = new FormData();
				formData.append("goods_cd", goodsCd);
				formData.append("event_cd", eventCd);
				formData.append("cust_cd", cust_cd);
				formData.append("start_day", start_day);
				formData.append("ctg_seq", ctg);
				
				cfn_ajax({
					url: "<c:url value='/goods/saveGoodsCart.do'  />",
					type: "POST",
					data: formData,
					async: false,
					dataType: "json",
					cache: false,
					noloading:"no",
					timeOut: (5*60*1000),
					success: function(res) {					
						var saveCnt = res["saveCnt"];

						if(saveCnt > 0) {
							// alert("등록되었습니다.");
						}
					},
					error:function(err){
						//console.log(err);
					},
					complete:function(){
					}
				});
			
			} else {
				fn_goLogin();
			}
			
		};

		// 상품평 리스트 더보기 버튼 노출 유무 
		var fn_SetDisplayBtnMoreReview = function() {
			//console.log("================ 목록 수 체크 ===================");
			//console.log("reviewTotalSize : ", reviewTotalSize);
			//console.log("curRow : ", curRow);
			//console.log("================ 목록 수 체크 ===================");


			// 상품평 목록 더보기 
			
			if(curRow < reviewTotalSize) {
				document.all.btn_more.style.display="";
			}	else {
				document.all.btn_more.style.display="none";
			}	
			
		}

		// 상품평 리스트 조회 
		var fn_ReviewList = function () {

	
			startRow = 1;
			endRow = pageSize;	
			
			//console.log("goodsCd  >>> " + goodsCd);
			//console.log("startRow  >>> " + startRow);
			//console.log("endRow  >>> " + endRow);
			
			var formData = new FormData();
			formData.append('goodsCd', goodsCd);
			formData.append('startRow', startRow);
			formData.append('endRow', endRow);
			
			cfn_ajax({
				type: "POST",
				async: false,
				url: "<c:url value='/goods/srchReviewListAjax.do'  />",
				data: formData,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					goodsReviewList = res.goodsReviewList;
					curRow = goodsReviewList.length;

					var html = "";
					if(goodsReviewList != null) {
						for(var i = 0; i < goodsReviewList.length; i++) {

							html = html + "				<li class='list'>";
							html = html + "					<span class='comment'>"+goodsReviewList[i]["eval_cnts"]+"</span><b>"+goodsReviewList[i]["cust_nm"]+"("+goodsReviewList[i]["lotte_id"]+")</b>";
							html = html + "					<span class='rating'>";
							var avg = goodsReviewList[i]["eval_avg"];
							var cnt = avg/20;
							var idx2=0;
							for(idx2 = 0; idx2 < cnt; idx2++) {
								html = html + "					<em>★</em>";
							}
							html = html + "					</span>";
							html = html + "				</li>";
						}
					}

					//console.log("reviewList >>>> " + reviewList);

					$("#reviewList").html(html).trigger('create');
					
				},
				error:function(err){
					//console.log(err);
				},
				complete:function(){
					// 상품평 목록 카운터 조회 
					fn_ReviewListCount();
					
					
					$(".mgT10").trigger("create");
					$(".mgT12").trigger("create");
					
				}
			});
		};	

		// 상품평 리스트 (카운트)
		var fn_ReviewListCount = function(type){
			
			// var ctg = document.frmGoodsCtg.ctg.value;
			// alert(ctg);
			var formData = new FormData();
			formData.append('goodsCd', goodsCd);

			cfn_ajax({
				url: "<c:url value='/goods/srchReviewListCountAjax.do'  />",
				type: "POST",
				data: formData,
				async: false,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
					reviewTotalSize = res.reviewTotalSize;
					
					fn_initButton();
					
				},
				error:function(err){
					//console.log(err);
				},
				complete:function(){
				}
			});
		};

		// (더보기) 상품평 리스트 조회 
		var fn_MoreReviewList = function () {		
			startRow = curRow + 1;
			endRow = curRow + Number(pageSize);
			
			//console.log("goodsCd  >>> " + goodsCd);
			//console.log("startRow  >>> " + startRow);
			//console.log("endRow  >>> " + endRow);
			
			var formData = new FormData();
			formData.append('goodsCd', goodsCd);
			formData.append('startRow', startRow);
			formData.append('endRow', endRow);
			
			cfn_ajax({
				type: "POST",
				async: false,
				url: "/goods/srchMoreReviewListAjax.do",
				data: formData,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					goodsReviewList = res.goodsReviewList;
					curRow =  curRow + goodsReviewList.length;

					var html = "";
					if(goodsReviewList != null) {
						for(var i = 0; i < goodsReviewList.length; i++) {

							html = html + "				<li class='list'>";
							html = html + "					<span class='comment'>"+goodsReviewList[i]["eval_cnts"]+"</span><b>"+goodsReviewList[i]["cust_nm"]+"("+goodsReviewList[i]["lotte_id"]+")</b>";
							html = html + "					<span class='rating'>";
							var avg = goodsReviewList[i]["eval_avg"];
							var cnt = avg/20;
							var idx2=0;
							for(idx2 = 0; idx2 < cnt; idx2++) {
								html = html + "					<em>★</em>";
							}
							html = html + "					</span>";
							html = html + "				</li>";
						}
					}

					$("#reviewList").append(html).trigger('create');
					
				},
				error:function(err){
					//console.log(err);
				},
				complete:function(){
					// 상품평 목록 카운터 조회 
					fn_ReviewListCount();
					
					// 상품평 목록 더보기 버튼 노출 유무 판단 
					fn_SetDisplayBtnMoreReview();
					$(".mgT10").trigger("create");
					$(".mgT12").trigger("create");
					
				}
			});
		};	

		// [COMMON] 공통사항 
		$(document).ready(function(){
 			detail_init();			
			fn_init();
			fn_initButton();
			fn_InitSwipper();	
			 
  			// 상품 전시 페이지 CSS 스타일을 맞춰줌 
			$(".bodyWrap").addClass("goods");
			$(".product_detail").trigger("create");
			$(".imgGallery").trigger("create");

			$(".mgT10").trigger("create");
			$(".mgT12").trigger("create");
			$(".collapsDiv").trigger("create");
			$(".collapsContent").trigger("create");
			$(".schedule_day").trigger("create");
			$(".detail_schedule").trigger("create");
			
			if(ctg == '5811'){
				$("#ctg_depth2_ul").hide();
				$("#ctg_depth3_ul").hide();
			}
			
			chgReserve('<%=reservTag%>');

			/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();					
			}, false);*/
		});

		function chgReserve(type) {
			if(type == '예약' || type == '출발가능') {
				$('#span_reserve01').show();
				$('#span_reserve02').hide();
				$('#reserveLI').css("background","#353163");		
			} else {
				$('#span_reserve02').show();
				$('#span_reserve01').hide();				
				$('#reserveLI').css("background","#666666");
			}
		}
	-->
	</script>
</head>

<!--content--> 
<div role="main" class="ui-content contentWrap gsdetail" id="top">
	<!-- 상품 카테고리 정보 -->
	<div  class="detail" id="content">
		<div data-role="navbar" data-iconpos="right" class="nav">
			<ul id="ctg_depth2_ul">
				<li><a href="#popupGoodsCtg"  data-rel="popup" data-icon="carat-d" onClick="popGoodsCategory1()" class="ui-btn-active ui-nodisc-icon ui-alt-icon"><span id="ctg_depth2" name="ctg_depth2">선택</span></a></li>
			</ul>  
		</div>
	<div data-role="navbar" data-iconpos="right" class="tabsnav">
		<ul class='scrpos1' id="ctg_depth3_ul">
			<li><a href="#popupGoodsCtg2"  data-rel="popup" data-icon="carat-d" onClick="popGoodsCategory2()" class="ui-btn-active ui-nodisc-icon ui-alt-icon btnBG2" style="background:#7b4eb9;color:#fff"><span id="ctg_depth3" name="ctg_depth3">선택</span></a></li>
		</ul>  
	</div>
	<!-- 상품 카테고리 정보 -->
	<!-- 행사 상품 정보  -->
	<div id="gdDetail" name="gdDetail">
<%
	if(eventMstDTO != null) {

		// 방문 도시 표시 
	
		String countryFullKr = "";
		String countryFullPathKr = "";
		EventGroupAllSchdVO eventGroupAllSchd = null;
		if(eventAllSchdList != null) {
			for(int idx = 0; idx < eventAllSchdList.size(); idx++) {
				eventGroupAllSchd = (EventGroupAllSchdVO) eventAllSchdList.get(idx);

				if(!eventGroupAllSchd.getGroup_id().equals("group91") && !eventGroupAllSchd.getGroup_id().equals("group96")) {

					if(eventGroupAllSchd.getCountry_knm() != null) {
						// 동일한 방문 도시 중복을 회피하기 위해 
						if(!eventGroupAllSchd.getCountry_knm().equals(countryFullKr)) {
							if(idx > 0) {
								countryFullPathKr = countryFullPathKr + ">" + eventGroupAllSchd.getCountry_knm(); 
							} else {
								countryFullPathKr = eventGroupAllSchd.getCountry_knm();
							}
							countryFullKr = eventGroupAllSchd.getCountry_knm();
						}
					} 
				}
			}					
		}


%>
		
		<div class='product_detail'>
			<div class='tabsnav code'>상품코드  <%=eventCd%></div>
			<div  class='tabsnav tit scTab scrpos2'>
				<p  class='btnStit'><%=eventMstDTO.getDisp_nm()%></p>
			</div>
			<div class='swiper-container imgGallery'>
				<div class='swiper-wrapper'>
<%
				for(int i = 0; i < goodsImgList.size(); i++) {
					GoodsImgVO goodsImgVO = (GoodsImgVO) goodsImgList.get(i);									
%>
					<!-- div class='swiper-slide' ><img src="http://www.lottejtb.com/upload/common/goods/<!%=goodsCd.substring(0, 2)%>/<!%=goodsCd%>/<!%=goodsImgVO.fn_chgImage(goodsImgVO.getSave_file_nm(), "D")%>"/></div -->
					<div class='swiper-slide' ><img src="/m_file/upload/common/goods/<%=goodsCd.substring(0, 2)%>/<%=goodsCd%>/<%=goodsImgVO.fn_chgImage(goodsImgVO.getSave_file_nm(), "D")%>"/></div>

<%
				}
%>


				</div>
				<div class='swiper-pagination'></div>
			</div>
			<div class='date'>
				<%if(eventMstDTO.getStart_pyun() != null && !eventMstDTO.getStart_pyun().equals("")) {%>
				<span class='stdate'>출발일 <i><%=eventMstDTO.getStart_day().substring(0, 4)%>년 <%=eventMstDTO.getStart_day().substring(4, 6)%>월 <%=eventMstDTO.getStart_day().substring(6, 8)%>일 (<%=eventMstDTO.getStart_wday()%>) <% if(eventMstDTO.getStart_time() != null){ %><%=eventMstDTO.getStart_time().substring(0, 2)%>:<%=eventMstDTO.getStart_time().substring(2, 4)%><% } %> - <%=eventMstDTO.getStart_pyun()%></i></span>
				<%} else {%>
				<span class='stdate'>출발일 <i><%=eventMstDTO.getStart_day().substring(0, 4)%>년 <%=eventMstDTO.getStart_day().substring(4, 6)%>월 <%=eventMstDTO.getStart_day().substring(6, 8)%>일 (<%=eventMstDTO.getStart_wday()%>) <% if(eventMstDTO.getStart_time() != null) {%><%=eventMstDTO.getStart_time().substring(0, 2)%>:<%=eventMstDTO.getStart_time().substring(2, 4)%><%}%></i></span>
				<%}%>				
				<%if(eventMstDTO.getEnd_pyun() != null && !eventMstDTO.getEnd_pyun().equals("")) {%>
				<span class='eddate'>도착일 <i><%=eventMstDTO.getEnd_day().substring(0, 4)%>년 <%=eventMstDTO.getEnd_day().substring(4, 6)%>월 <%=eventMstDTO.getEnd_day().substring(6, 8)%>일 (<%=eventMstDTO.getEnd_wday()%>) <%if(eventMstDTO.getEnd_time() != null) {%><%=eventMstDTO.getEnd_time().substring(0, 2)%>:<%=eventMstDTO.getEnd_time().substring(2, 4)%><%}%> - <%=eventMstDTO.getEnd_pyun()%></i></span>
				<%} else {%>
				<span class='eddate'>도착일 <i><%=eventMstDTO.getEnd_day().substring(0, 4)%>년 <%=eventMstDTO.getEnd_day().substring(4, 6)%>월 <%=eventMstDTO.getEnd_day().substring(6, 8)%>일 (<%=eventMstDTO.getEnd_wday()%>) <%if(eventMstDTO.getEnd_time() != null) {%><%=eventMstDTO.getEnd_time().substring(0, 2)%>:<%=eventMstDTO.getEnd_time().substring(2, 4)%><%}%></i></span>
				<%}%>
				<div class='more '><a href='javascript:fn_goMaster();' data-ajax='false'><i class="fa fa-calendar mgr5 list"></i>다른출발일 보기</a></div>
<%
				// 2차 과업 내용
%>
				<!-- div class='more btnBG2'><a href="javascript:alert('서비스 준비중입니다.')" data-rel='popup'><i class='plane mgr5'></i>다른이용항공보기</a></div -->
			</div>
		</div>
		<div class='collapsDiv mgT10'>						
			<h1 class='collapsHeading'><em class='one'></em>예약항공</h1>
			<div class='collapsContent'>
<%
		// 항공사 별 이미지 표시 
		if(eventMstDTO.getCd_nm() != null && eventMstDTO.getCd_nm().equals("아시아나항공")) {
%>
			<img src='/resources/images/ico/air_OZ.png' class='img'> <%=eventMstDTO.getCd_nm()%>
<%			
		} else if(eventMstDTO.getCd_nm() != null &&  eventMstDTO.getCd_nm().equals("진에어")) {
%>
			<img src='/resources/images/ico/air_LJ.png' class='img mgL5'> <%=eventMstDTO.getCd_nm()%>
<%			
		} else if(eventMstDTO.getCd_nm() != null &&  eventMstDTO.getCd_nm().equals("대한항공")) {
%>
			<img src='/resources/images/ico/air_KE.png' class='img mgL5'> <%=eventMstDTO.getCd_nm()%>
<%
		} else if(eventMstDTO.getCd_nm() != null &&  eventMstDTO.getCd_nm().equals("티웨이")) {
%>
			<img src='/resources/images/ico/air_TW.png' class='img mgL5'> <%=eventMstDTO.getCd_nm()%>
<%
		} else if(eventMstDTO.getCd_nm() != null) {
%>
			<%=eventMstDTO.getCd_nm()%>
<%
		}
%>
			</div>						
		</div>
		<div class='collapsDiv mgT10'>
			<h1 class='collapsHeading'><em class='two'></em>예약</h1>
			<div class='collapsContent'><p><%=reservTag%> <%=rvCnt%>명 | 배정석 <%=evInwon%>석(최소출발 <%=eventMstDTO.getMin_inwon()%>명)</p></div>
				<h1 class='collapsHeading'><em class='thr'></em>방문도시</h1>
				<%
				// 방문 도시 표시 부분은 추후 처리함. 현재 GroupAll로 정보를 표시하고 있음. 
				%>
				<div class='collapsContent'><p><%=countryFullPathKr%></p></div>
			</div>
			<div class='collapsDiv'>
				<h1 class='collapsHeading'><em class='for'></em>상품가격<a href='#' class='btn btnbox allopenbtn2'>모두펼침</a></h1>
				<div class='collapsContent center' style='padding: 0;width:100%'>
					<div data-role='collapsible' data-iconpos='right'>	
						<h1 class='ui-nodisc-icon ui-alt-icon' style=';text-align: center'>성인(만 12세 이상)</h1>	
						<p><span>총 상품가격<b class='mgL5 purple'> <%=eventMstDTO.getStr_tot_amt1()%></b>원</span>
						   <span>기본상품가격 <%=eventMstDTO.getStr_adult_price()%>원 + 유류할증료 <%=eventMstDTO.getStr_etc_price1()%>원</span></p>
					</div>
					<div data-role='collapsible' data-iconpos='right'>	
						<h1 class='ui-nodisc-icon ui-alt-icon'>아동(만 12세 미만)</h1>	
						<p><span>총 상품가격<b class='mgL5 purple'> <%=eventMstDTO.getStr_tot_amt2()%></b>원</span>
						    <span>기본상품가격 <%=eventMstDTO.getStr_child_price()%>원 + 유류할증료 <%=eventMstDTO.getStr_etc_price2()%>원</span></p>
					</div>
					<div data-role='collapsible' data-iconpos='right'>	
						<h1 class='ui-nodisc-icon ui-alt-icon' >유아(만 2세 미만)</h1>	
						<p><span>총 상품가격<b class='mgL5 purple'> <%=eventMstDTO.getStr_tot_amt3()%></b>원</span>
							<span>기본상품가격 <%=eventMstDTO.getStr_baby_price()%>원 + 유류할증료 <%=eventMstDTO.getStr_etc_price3()%>원</span></p>
					</div>
					<div class='last'>유류할증료는 유가와 환율에 따라 변동될 수 있습니다.</div>	
			</div>			
	</div>
	<!-- 행사 상품 정보  -->
<%
	}

	String disp_nm = "";

	try {
		disp_nm = URLEncoder.encode(eventMstDTO.getDisp_nm(), "UTF-8");

	} catch (Exception e) {}
%>	
</div>
<!-- 상품 정보 -->

<div data-role="navbar" class="nav mgL5 mgT10 mgb10">
	<ul class="pd">
		<li>
			<a href="#" class="btnbox layerOpener" data-url="/goodsSaveCartPop.do" data-width="300" data-height="200" data-ok="yes"><i class="fa fa-heart-o mgr5 mtm8"></i>찜하기</a>
			<!-- <a href="#favoPop"  data-rel="popup" onClick="fn_saveCart()"><i class="fa fa-heart-o mgr5 mtm8"></i>찜하기</a> -->
		</li>
		<li><a href="#" class="layerOpener" data-url="/goods/pop_mail.do" data-ok="yes"><i class="fa fa-envelope-o mgr5 mtm8"></i>일정표메일발송</a></li>
	</ul>
	<ul class="pd">
		<li><a href="#" class="layerOpener btnBG2 lh22"  data-url="/goods/pop_tel.do?ctg=<%=ctg%>&goodsCd=<%=goodsCd%>&eventCd=<%=eventCd%>" data-ok="yes" data-role='none'><i class="tel mgr6 mtm8"></i><span>전화상담 신청</span></a></li>
	</ul>
</div>

<!--상품상세 탭영역-->
<div data-role="tabs" class="mgT12">
	<div data-role="navbar" class="tab_navbar scTab scrpos3">
		<ul>
			<li><a href="#tab1" data-theme="a" data-ajax="false" class="ui-btn-active">상세정보</a></li>
			<li><a href="#tab2" data-theme="a" data-ajax="false">일정표</a></li>
			<li><a href="#tab3" data-theme="a" data-ajax="false">체크사항</a></li>
			<li><a href="#tab4" data-theme="a" data-ajax="false" class=" lh15">중요정보<br/>일괄표시</a></li>
		</ul>
	</div>
	<!-- 상세 정보 탭 01 -->
<%
// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_CD
// ADV : 상품 특전 
// INC : 포함 사항 
// NNC : 불포함 사항 
// SPE : 기타경비안내 
// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_TYPE
// advImg : 이미지, advText : 텍스트 
%>
	<!-- 상세 정보 탭 01 -->
	<section id="tab1" class="tabContent">
		<div id="eventDetailTab" name="eventDetailTab">
			<h1 class='btnAll'><a href='#' class='btn btnbox allopenbtn2'>모두펼침</a></h1>
<%	
	////////////////////////////////////////////////////////////////////// 상품 상세 ////////////////////////////////////////////////////////////////////// 		
	if(eventCommSchdList != null) {
		for(int i = 0; i < eventCommSchdList.size(); i++) {
			EventCommSchdVO eventCommSchd = (EventCommSchdVO) eventCommSchdList.get(i);

			String tag = "";
			
			// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_CD
			// ADV : 상품 특전 
			if(eventCommSchd.getComm_cd().equals("ADV")) { // 상품특전 
				tag = "상품특전";
%>
			<div data-role='collapsible' data-iconpos='right'>
			<h1 class='ui-nodisc-icon ui-alt-icon'><%=tag%></h1>
			<p>	
				<%	
				// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_TYPE
				// advImg : 이미지, advText : 텍스트 
				if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advImg")) {	// advImg : 이미지
					
					if(eventCommSchd.getComm_desc_det() != null && !eventCommSchd.getComm_desc_det().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc_det()%>
				<%		
					}
				} else if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advText")) { // advText : 텍스트 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc().replaceAll("\\","&#8361")%>
				<%
					}
				} else  { // 그외 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>
						<%=eventCommSchd.getComm_desc().replaceAll("\\","&#8361")%>
				<%					
					}

				} 
			
				%>

			</p>
		</div>
<%
			}
		} 

		
	}	
	if(eventCommSchdList != null) {
		for(int i = 0; i < eventCommSchdList.size(); i++) {
			EventCommSchdVO eventCommSchd = (EventCommSchdVO) eventCommSchdList.get(i);

			String tag = "";
			
			// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_CD
			// INC : 포함 사항 
			if(eventCommSchd.getComm_cd().equals("INC")) { // 포함 사항 
				tag = "포함 사항";
%>
			<div data-role='collapsible' data-iconpos='right'>
			<h1 class='ui-nodisc-icon ui-alt-icon'><%=tag%></h1>
			<p>	
				<%	
				// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_TYPE
				// advImg : 이미지, advText : 텍스트 
				if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advImg")) {	// advImg : 이미지
					
					if(eventCommSchd.getComm_desc_det() != null && !eventCommSchd.getComm_desc_det().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc_det()%>
				<%		
					}
				} else if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advText")) { // advText : 텍스트 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc()%>
				<%
					}
				} else  { // 그외 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>
						<%=eventCommSchd.getComm_desc()%>
				<%					
					}

				} 
			
				%>

			</p>
		</div>
<%
			}
		} 

		
	}	
	if(eventCommSchdList != null) {
		for(int i = 0; i < eventCommSchdList.size(); i++) {
			EventCommSchdVO eventCommSchd = (EventCommSchdVO) eventCommSchdList.get(i);

			String tag = "";
			
			// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_CD
			// NNC : 불포함 사항 
			if(eventCommSchd.getComm_cd().equals("NNC")) { // 불포함 사항  
				tag = "불포함 사항";
%>
			<div data-role='collapsible' data-iconpos='right'>
			<h1 class='ui-nodisc-icon ui-alt-icon'><%=tag%></h1>
			<p>	
				<%	
				// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_TYPE
				// advImg : 이미지, advText : 텍스트 
				if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advImg")) {	// advImg : 이미지
					
					if(eventCommSchd.getComm_desc_det() != null && !eventCommSchd.getComm_desc_det().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc_det()%>
				<%		
					}
				} else if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advText")) { // advText : 텍스트 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc()%>
				<%
					}
				} else  { // 그외 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>
						<%=eventCommSchd.getComm_desc()%>
				<%					
					}

				} 
			
				%>

			</p>
		</div>
<%
			}
		} 

		
	}	
	if(eventCommSchdList != null) {
		for(int i = 0; i < eventCommSchdList.size(); i++) {
			EventCommSchdVO eventCommSchd = (EventCommSchdVO) eventCommSchdList.get(i);

			String tag = "";
			
			// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_CD
			// SPE : 기타경비안내 
			if(eventCommSchd.getComm_cd().equals("SPE")) { // 기타경비안내 
				tag = "기타경비안내";
%>
			<div data-role='collapsible' data-iconpos='right'>
			<h1 class='ui-nodisc-icon ui-alt-icon'><%=tag%></h1>
			<p>	
				<%	
				// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_TYPE
				// advImg : 이미지, advText : 텍스트 
				if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advImg")) {	// advImg : 이미지
					
					if(eventCommSchd.getComm_desc_det() != null && !eventCommSchd.getComm_desc_det().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc_det()%>
				<%		
					}
				} else if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advText")) { // advText : 텍스트 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc()%>
				<%
					}
				} else  { // 그외 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>
						<%=eventCommSchd.getComm_desc()%>
				<%					
					}

				} 

				%>

			</p>
		</div>
<%
			}
		} 

		
	}	

	// 고객 상품평 리스트 	
%>	

	<div data-role='collapsible' data-iconpos='right' class='review mgT10' data-collapsed='false'>
		<h1 class='ui-nodisc-icon ui-alt-icon'>고객상품평</h1>
		<ul data-role='listView' id="reviewList" name="reviewList">
<%				
		if(goodsReviewList != null && goodsReviewList.size() > 0) {
			for(int i = 0; i < goodsReviewList.size(); i++) {
				GoodsEvalVO reviewVO = (GoodsEvalVO) goodsReviewList.get(i);
%>

			<li class='<%=(i > 0)?"list":""%>'> 
				<span class='comment'><%=reviewVO.getEval_cnts()%></span><b><%=reviewVO.getCust_nm()%><% if(reviewVO.getLotte_id() != null) {%>(<%=reviewVO.getLotte_id()%>) <% } %></b>
				<span class='rating'>
			<%		
				int avg = reviewVO.getEval_avg();
				int cnt = avg/20;
				int idx2=0;
				for(idx2 = 0; idx2 < cnt; idx2++) {
			%>
						<em>★</em>
			<%
				}
			%>
				</span>
			</li>
		<%
			}
		} else {
		%>
			<li>
				<span class='comment'><center>등록된 상품평이 없습니다.</center></span>								
			</li>
		<%
		}
		%>
		</ul>
	</div>

	<%
	String displayTag = "";
	
	if(goodsReviewList != null && goodsReviewList.size() == reviewTotalSize.intValue()) displayTag = "display:none";
	%>
	
	<div class='more' id='btn_more' style="<%=displayTag%>"><a href='#' onClick="fn_MoreReviewList()">더보기</a></div>

	<div class='more btnBG2'><a href='#' class="layerOpener" data-url="/goods/pop_review.do?ctg=<%=ctg%>&goodsCd=<%=goodsCd%>&eventCd=<%=eventCd%>&goodsNm=<%=disp_nm%>" onClick="sessionCheck()" data-ok="yes">상품평작성</a></div>
	</div>
	</section>
	<!-- 일정표 02 -->
    <section id="tab2" class="tabContent">
		<div id="eventDetailTab02" name="eventDetailTab02">
<%
	////////////////////////////////////////////////////////////////////// 일정표 ////////////////////////////////////////////////////////////////////// 		
	/**
	// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_CD
	// GPL : 미팅 장소  
	**/
	if(eventCommSchdList != null) {
		for(int i = 0; i < eventCommSchdList.size(); i++) {	
			EventCommSchdVO eventCommSchd = (EventCommSchdVO) eventCommSchdList.get(i);
			if(eventCommSchd.getComm_cd() != null && eventCommSchd.getComm_cd().equals("GPL")) { // 미팅 장소 
							
%>
			<div class='collapsDiv'>
				<h1 class='collapsHeading'>
<%
				/**
				// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_TYPE
				// advImg : 이미지, advText : 텍스트 
				**/

				if(eventCommSchd.getComm_desc_det() != null) {
%>
					<span><%=eventCommSchd.getComm_desc_det()%></span>
<%
				}
%>
				</h1>							
				<div class='collapsContent'>
					<p><img src='<%=eventCommSchd.getImg_path()%>'/></p>						
				</div>
				<h1 class='btnAll'><a href='#' class='btn btnbox allopenbtn3'>모두닫힘</a></h1>
			</div>
<%	
			}					
		} 
	}
	////////////////////////////////////////////// 일정표 프로그래밍이 필요 시작 ////////////////////////////////////////////// 
int nMaxDayCnt = eventGroupAllSchdDTO.getMaxDayCnt();
int dayCnt = 0; // 해당 일수 
int beforeDayCnt = 0; // 해당일자만 비교 
String ole = "";
String city_knm = "";
String hour = "";
String minute = "";
String city_cd = "";
String beforeCityCd = ""; // 중복 도시 회피	
if(eventAllSchdList != null) {
	for (int idx = 0; idx < eventAllSchdList.size(); idx++) {
		
		EventGroupAllSchdVO eventGroupAllSchd = (EventGroupAllSchdVO) eventAllSchdList.get(idx);

		// if(eventGroupAllSchd.getEvent_cd() == null || eventGroupAllSchd.getEvent_cd().equals(eventCd)) {
			dayCnt = eventGroupAllSchd.getDay_cnt();
%>

<%			
			boolean tagScheduleDay  = false;
			String group_id =  eventGroupAllSchd.getGroup_id().trim();
%>
			<script> // //console.log("그룹 아이디 : " + "<%=group_id%>" );</script>


			
<%
				if(group_id.equals("group95")) {
%>
					<div class='detail_dinner'>
						<dl>
							<dt>식사</dt>
							<dd>
								<em>조식</em><%=(eventGroupAllSchd.getImg_path_local1() != null && !eventGroupAllSchd.getImg_path_local1().equals("선택안함"))?eventGroupAllSchd.getImg_path_local1():""%> <%=(eventGroupAllSchd.getImg_path_server1() != null)?eventGroupAllSchd.getImg_path_server1():""%><em class='mgr5'>중식</em><%=(eventGroupAllSchd.getImg_path_local2() != null && !eventGroupAllSchd.getImg_path_local2().equals("선택안함"))?eventGroupAllSchd.getImg_path_local2():""%> <%=(eventGroupAllSchd.getImg_path_server2() != null)?eventGroupAllSchd.getImg_path_server2():""%><em class='mgr5'>석식</em><%=(eventGroupAllSchd.getImg_path_local3() != null && !eventGroupAllSchd.getImg_path_local3().equals("선택안함"))?eventGroupAllSchd.getImg_path_local3():""%> <%=(eventGroupAllSchd.getImg_path_server3() != null)?eventGroupAllSchd.getImg_path_server3():""%>	
							</dd>
						</dl>
					</div>
				</div>
<%
				} //end if group95 
%>
<%
			// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 시간 / 일정 /관광지 정보 
			if(group_id.equals("group11") || group_id.equals("group21") || group_id.equals("group31") || group_id.equals("group32") || group_id.equals("group33") || group_id.equals("group34") || group_id.equals("group35") || group_id.equals("group36") || group_id.equals("group91")) {
%>

<%
				if(beforeDayCnt < dayCnt) {
					beforeCityCd = city_cd;
%>	
			<script>//console.log(">>>>>>>> dayCnt : <%=dayCnt%> beforeDayCnt : <%=beforeDayCnt%> index : <%=idx%>");</script>
			<script>//console.log(">>>>>>>> <%=dayCnt%> day start !!!!!!");</script>
			<script>//console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");</script>
			<div data-role='collapsible' data-iconpos='right' class='schedule_day'  data-collapsed='false'><!--<%=dayCnt%> day-->
				<h1 class='ui-nodisc-icon ui-alt-icon'><%=dayCnt%> DAY</h1>
				<div class='detail_schedule'>
			<script>//console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");</script>		
<%
				}
%>

<%
				beforeDayCnt = dayCnt;
				if(group_id.equals("group11") || group_id.equals("group21")) { // 시간 일정 					
					if(group_id.equals("group11")) {
						
						city_cd = eventGroupAllSchd.getCity_cd();
						if(city_cd != null && !city_cd.equals("")) {
							
							if(eventGroupAllSchd.getCity_knm() != null && !eventGroupAllSchd.getCity_knm().equals("")) {
								city_knm = eventGroupAllSchd.getCity_knm();
							}
							// ole = "";
						} // end if 도시명 						
					} // end if 시간 일자 

					if(group_id.equals("group21")) { // 상세일정
						if(eventGroupAllSchd.getOle() != null && !eventGroupAllSchd.getOle().equals("")) {
							
							if(city_cd.equals(beforeCityCd)) {
								ole = ole + eventGroupAllSchd.getOle();
							} else {
								ole = eventGroupAllSchd.getOle();
								
							}
						}
					} // end if 상세 일정 

					if(beforeDayCnt == dayCnt) {
						if(!ole.equals("") && !city_knm.equals("")) {
							ole = ole.replaceAll("<[^>]*>", " ");
							ole = ole.replace(".",".<br>");
							ole = ole.replace(".◈",".<br>◈");
							ole = ole.replace("①", "<br>①");
							ole = ole.replace("■", "<br>■");
							ole = ole.replace("※", "<br>※");
							ole = ole.replace("★", "<br>★");
							
%>					
					<dl>
<%
							if(city_knm != null && !city_knm.equals("")) {
%>							
							<dt class='space'><%=city_knm%></dt>
<%
							}
							if(ole != null && !ole.equals("")) {
%>						
							<dd><%=ole%></dd>
					</dl>
<%
							}
						
								ole = "";
						} // end if 시간/일정 내역 
					} // end if 해당 일자만 
				} // end if 시간/일정 - 세부 상세 
			
				String img_path_server1 = "";
				String img_alt1 = "";
				String img_title1 = "";
				String detail_cnts1 = "";

				if(group_id.equals("group31") || group_id.equals("group32") || group_id.equals("group33") || group_id.equals("group34") || group_id.equals("group35") || group_id.equals("group36")) { // 이미지 1
					img_path_server1 = eventGroupAllSchd.getImg_path_server1();
					img_alt1 = eventGroupAllSchd.getImg_alt1();
					img_title1 = eventGroupAllSchd.getImg_title1();
					if(eventGroupAllSchd.getDetail_cnts1() != null) {
						detail_cnts1 = eventGroupAllSchd.getDetail_cnts1();	
					}
					if(beforeDayCnt == dayCnt) {
%>
					<div class='cntdetail_info'>
						<p><%=img_title1%></p>
						<em><img src='<%=img_path_server1%>' border="0" alt="<%=img_alt1%>"/></em>
						<span><%=detail_cnts1%></span>
					</div>	
<%	
					} // end if 해당일자만 					
				} // end if 이미지 일때만 
			
%>				
<%
				String img_link_url1 = "";
				String target_type1 = "";
				String img_title2 = "";
				String img_path_server2 = "";
				String img_link_url2 = "";
				String target_type2 = "";
				String img_title3 = "";
				String img_local_path3 = "";
				String img_path_server3 = "";
				String img_path = "";
				String img_link_url3 = "";

				if(group_id.equals("group91")) { // 선택 관광지
					img_link_url1 = eventGroupAllSchd.getImg_link_url1();
					target_type1 = eventGroupAllSchd.getTarget_type1();
					img_title2 = eventGroupAllSchd.getImg_title2();
					img_path_server2 = eventGroupAllSchd.getImg_path_server2();
					img_link_url2 = eventGroupAllSchd.getImg_link_url2();
					img_link_url3 = eventGroupAllSchd.getImg_link_url3();
					target_type2 = eventGroupAllSchd.getTarget_type2();
					img_title3 = eventGroupAllSchd.getImg_title3();
					img_local_path3 = eventGroupAllSchd.getImg_path_local3();
					img_path_server3 = eventGroupAllSchd.getImg_path_server3();
					img_path = eventGroupAllSchd.getImg_path();
					
					if(beforeDayCnt == dayCnt) {				
%>	
					<dl>
						<dt class="chck">선택관광</dt>					
					</dl>
					<div class="cntdetail_info">
						<p><%=img_title2%></p>
						<em><img src="<%=img_path%>"/></em>
						<span><%=(img_link_url3 != null)?img_link_url3:""%></span>
						<span><i class="pink">소요시간 : <%=(img_path_server2 != null)?img_path_server2:""%> 1인요금 : <%=(img_title3 != null)?img_title3:""%></i><br><i class="purple">대체일정: <%=(img_link_url2 != null)?img_link_url2:""%></i></span>		
					</div>						
<%	
					} // end if 해당일자만 					
				} // end if 이미지 일때만 
			} // end if 그룹별 
%>

<%		
			if(group_id.equals("group94")) {
%>
			</div>  <!-- </div> detail_schedule -->
<%					
				String hotel_reserve_type = eventGroupAllSchd.getHotel_reserve_type();
				// 미정 : P pendency, 예정 : S schedule 확정 : C confirm
				if(eventGroupAllSchd.getNotify_type_pendency_name() == null || eventGroupAllSchd.getNotify_type_pendency_name().equals("")) {
					eventGroupAllSchd.setNotify_type_pendency_name("홈페이지");
				}
				if(hotel_reserve_type.equals("P")) { // 미정

%>			
					<div class='detail_hotel'>
						<dl>
							<dt>호텔</dt>
							<dd>본 여행상품의 숙박시설은 현재 <em>미정</em>입니다. 출발 <em><%=eventGroupAllSchd.getBefore_day_pendency_name()%></em>전까지<em><br><%=eventGroupAllSchd.getNotify_type_pendency_name()%></em>를 통해서 알려드리겠습니다.</dd>
						</dl>
					</div>
<%
				} else if(hotel_reserve_type.equals("S")) { // 예정
%>
					<div class='detail_hotel'>
						<dl>
							<dt>호텔</dt>
							<dd>
								본 여행상품의 숙박시설은 <em>예정</em>입니다.<br>
								<%if(eventGroupAllSchd.getHotel1_knm() != null) {%>
								<a href="<%=eventGroupAllSchd.getHotel1_homepage_url()%>" target="_blank"><%=eventGroupAllSchd.getHotel1_knm()%>(<%=eventGroupAllSchd.getHotel1_enm()%>) <%=eventGroupAllSchd.getHotel1_grade()%></a><br>
								<%}%>
								<%if(eventGroupAllSchd.getHotel2_knm() != null) {%>
								<a href="<%=eventGroupAllSchd.getHotel2_homepage_url()%>" target="_blank"><%=eventGroupAllSchd.getHotel2_knm()%>(<%=eventGroupAllSchd.getHotel2_enm()%>) <%=eventGroupAllSchd.getHotel2_grade()%></a><br>
								<%}%>
								<%if(eventGroupAllSchd.getHotel3_knm() != null) {%>
								<a href="<%=eventGroupAllSchd.getHotel3_homepage_url()%>" target="_blank"><%=eventGroupAllSchd.getHotel3_knm()%>(<%=eventGroupAllSchd.getHotel3_enm()%>) <%=eventGroupAllSchd.getHotel3_grade()%></a><br>
								<%}%>
								<%if(eventGroupAllSchd.getHotel4_knm() != null) {%>
								<a href="<%=eventGroupAllSchd.getHotel4_homepage_url()%>" target="_blank"><%=eventGroupAllSchd.getHotel4_knm()%>(<%=eventGroupAllSchd.getHotel4_enm()%>) <%=eventGroupAllSchd.getHotel4_grade()%></a><br>
								<%}%>
								<%if(eventGroupAllSchd.getHotel5_knm() != null) {%>
								<a href="<%=eventGroupAllSchd.getHotel5_homepage_url()%>" target="_blank"><%=eventGroupAllSchd.getHotel5_knm()%>(<%=eventGroupAllSchd.getHotel5_enm()%>) <%=eventGroupAllSchd.getHotel5_grade()%></a><br>
								<%}%>								
								출발 <em><%=eventGroupAllSchd.getBefore_day_schedule_name()%></em>전까지 <em><%=eventGroupAllSchd.getNotify_type_schedule_name()%></em>를 통해서 알려드리겠습니다.  
							</dd>
						</dl>
					</div>					

<%
				} else if(hotel_reserve_type.equals("C")) { // 확정
%>

					<div class='detail_hotel'>
						<dl>
							<dt>호텔</dt>
							<dd>본 여행상품의 숙박시설은 <a href="<%=eventGroupAllSchd.getHomepage_url_confirm()%>" target="_blank"><%=eventGroupAllSchd.getHotel_knm_confirm()%>(<%=eventGroupAllSchd.getHotel_enm_confirm()%>) <%=eventGroupAllSchd.getHotel_grade_confirm()%></a> <em>확정</em>입니다.<br></dd>
						</dl>
					</div>
<!-- 
				} 

			} // end if group94

%>
 -->
<%
				if((idx+1) < eventAllSchdList.size()) {
					EventGroupAllSchdVO nextEventGroupAllSchd = (EventGroupAllSchdVO) eventAllSchdList.get(idx+1);
					int nextDayCnt = nextEventGroupAllSchd.getDay_cnt();
					String group_id2 = nextEventGroupAllSchd.getGroup_id();
					if(group_id2.equals("group95")) {
%>
	
<%							
					}
				}

			} // end if 해당 일자만 
		// } // end if 이벤트 행사 관련만 

	 } // end for eventAllSchdList
  } // end if eventAllSchdList 
}
%>			
	</section>


<%
	////////////////////////////////////////////// 일정표 프로그래밍이 필요 시작 ////////////////////////////////////////////// 
%>		



	<!-- 체크 사항 03 -->
    <section id="tab3" class="tabContent">
		<div id="eventDetailTab03" name="eventDetailTab03">
			<h1 class='btnAll'><a href='#' class='btn btnbox allopenbtn2'>모두펼침</a></h1>
<%
	////////////////////////////////////////////////////////////////////// 체크 사항 ////////////////////////////////////////////////////////////////////// 		
	// ATT : 예약시 유의사항 
	// ETC : 기타 사항 
	// PVI : 여권/비자
	// REC : 입금계좌번호
	// REQ : 필수사항 
	// SHO : 쇼핑정보  

	if(eventCommSchdList != null) {
		for(int i = 0; i < eventCommSchdList.size(); i++) {
			EventCommSchdVO eventCommSchd = (EventCommSchdVO) eventCommSchdList.get(i);

			String tag = "";
			
			// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_CD
			// ATT : 예약시 유의사항 
			if(eventCommSchd.getComm_cd().equals("ATT")) { // 예약시 유의사항 
				tag = "예약시 유의사항";
%>
			<div data-role='collapsible' data-iconpos='right'>
			<h1 class='ui-nodisc-icon ui-alt-icon'><%=tag%></h1>
			<p>	
				<%	
				// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_TYPE
				// advImg : 이미지, advText : 텍스트 
				if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advImg")) {	// advImg : 이미지
					
					if(eventCommSchd.getComm_desc_det() != null && !eventCommSchd.getComm_desc_det().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc_det()%>
				<%		
					}
				} else if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advText")) { // advText : 텍스트 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc()%>
				<%
					}
				} else  { // 그외 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>
						<%=eventCommSchd.getComm_desc()%>
				<%					
					}

				} 
			
				%>

			</p>
		</div>
<%
			}
		} 

	}		

%>

<%			
	if(eventCommSchdList != null) {
		for(int i = 0; i < eventCommSchdList.size(); i++) {
			EventCommSchdVO eventCommSchd = (EventCommSchdVO) eventCommSchdList.get(i);

			String tag = "";
			
			// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_CD
			// ETC : 기타 사항
			if(eventCommSchd.getComm_cd().equals("ETC")) { // 기타 사항
				tag = "기타 사항";
%>
			<div data-role='collapsible' data-iconpos='right'>
			<h1 class='ui-nodisc-icon ui-alt-icon'><%=tag%></h1>
			<p>	
				<%	
				// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_TYPE
				// advImg : 이미지, advText : 텍스트 
				if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advImg")) {	// advImg : 이미지
					
					if(eventCommSchd.getComm_desc_det() != null && !eventCommSchd.getComm_desc_det().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc_det()%>
				<%		
					}
				} else if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advText")) { // advText : 텍스트 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc()%>
				<%
					}
				} else  { // 그외 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>
						<%=eventCommSchd.getComm_desc()%>
				<%					
					}

				} 
			
				%>

			</p>
		</div>
<%
			}
		} 

		
	}	
%>

<%			
	if(eventCommSchdList != null) {
		for(int i = 0; i < eventCommSchdList.size(); i++) {
			EventCommSchdVO eventCommSchd = (EventCommSchdVO) eventCommSchdList.get(i);

			String tag = "";
			
			// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_CD
			// PVI : 여권/비자
			if(eventCommSchd.getComm_cd().equals("PVI")) { // 여권/비자
				tag = "여권/비자";
%>
			<div data-role='collapsible' data-iconpos='right'>
			<h1 class='ui-nodisc-icon ui-alt-icon'><%=tag%></h1>
			<p>	
				<%	
				// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_TYPE
				// advImg : 이미지, advText : 텍스트 
				if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advImg")) {	// advImg : 이미지
					
					if(eventCommSchd.getComm_desc_det() != null && !eventCommSchd.getComm_desc_det().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc_det()%>
				<%		
					}
				} else if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advText")) { // advText : 텍스트 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc()%>
				<%
					}
				} else  { // 그외 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>
						<%=eventCommSchd.getComm_desc()%>
				<%					
					}

				} 
			
				%>

			</p>
		</div>
<%
			}
		} 

		
	}	
%>

<%			
	if(eventCommSchdList != null) {
		for(int i = 0; i < eventCommSchdList.size(); i++) {
			EventCommSchdVO eventCommSchd = (EventCommSchdVO) eventCommSchdList.get(i);

			String tag = "";
			
			// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_CD
			// REC : 입금계좌번호
			if(eventCommSchd.getComm_cd().equals("REC")) { // 입금계좌번호
				tag = "입금계좌번호";
%>
			<div data-role='collapsible' data-iconpos='right'>
			<h1 class='ui-nodisc-icon ui-alt-icon'><%=tag%></h1>
			<p>	
				<%	
				// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_TYPE
				// advImg : 이미지, advText : 텍스트 
				if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advImg")) {	// advImg : 이미지
					
					if(eventCommSchd.getComm_desc_det() != null && !eventCommSchd.getComm_desc_det().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc_det()%>
				<%		
					}
				} else if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advText")) { // advText : 텍스트 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc()%>
				<%
					}
				} else  { // 그외 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>
						<%=eventCommSchd.getComm_desc()%>
				<%					
					}

				} 
			
				%>

			</p>
		</div>
<%
			}
		} 

		
	}	
%>

<%			
	if(eventCommSchdList != null) {
		for(int i = 0; i < eventCommSchdList.size(); i++) {
			EventCommSchdVO eventCommSchd = (EventCommSchdVO) eventCommSchdList.get(i);

			String tag = "";
			
			// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_CD
			// REQ : 필수사항
			if(eventCommSchd.getComm_cd().equals("REQ")) { // 필수사항
				tag = "필수사항";
%>
			<div data-role='collapsible' data-iconpos='right'>
			<h1 class='ui-nodisc-icon ui-alt-icon'><%=tag%></h1>
			<p>	
				<%	
				// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_TYPE
				// advImg : 이미지, advText : 텍스트 
				if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advImg")) {	// advImg : 이미지
					
					if(eventCommSchd.getComm_desc_det() != null && !eventCommSchd.getComm_desc_det().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc_det()%>
				<%		
					}
				} else if(eventCommSchd.getComm_type() != null && !eventCommSchd.getComm_type().equals("advText")) { // advText : 텍스트 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>		
						<%=eventCommSchd.getComm_desc()%>
				<%
					}
				} else  { // 그외 
					if(eventCommSchd.getComm_desc() != null && !eventCommSchd.getComm_desc().equals("")) {
				%>
						<%=eventCommSchd.getComm_desc()%>
				<%					
					}

				} 
			
				%>

			</p>
		</div>
<%
			}
		} 

		
	}	
%>
	</section>

	<!-- 중요정보 일괄표시 04 -->
    <section id="tab4" class="tabContent">
		<div id="eventDetailTab04" name="eventDetailTab04">
		<%	
	////////////////////////////////////////////////////////////////////// 중요정보 일괄표시 ////////////////////////////////////////////////////////////////////// 		

			int shopCnt = 0;
			if(eventCommSchdList != null) {
				for(int i = 0; i < eventCommSchdList.size(); i++) {
					EventCommSchdVO eventCommSchd = (EventCommSchdVO) eventCommSchdList.get(i);
					// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_CD
					// SHO : 쇼핑정보					
					if(eventCommSchd.getComm_cd() != null && eventCommSchd.getComm_cd().equals("SHO")) { // 쇼핑정보  

						shopCnt = eventCommSchd.getComm_num();
						break;
					} 							
				} // end for 
			}
		%>
				<div class='collapsDiv'>
					<div class='collapsContent'>
					<table>
						<caption>선택관광명, 1인요금, 소요시간, 내용, 대체일정순으로 나타낸 표</caption>
						<colgroup>
							<col width='35%'>
							<col width='20%'>
							<col width='25%'>
							<col width='20%'>
						</colgroup>
						<tbody>
							<tr>
								<th scope='row'>상품</th>
								<td colspan='3'><%=eventMstDTO.getDisp_nm()%></td>
							</tr>
							<tr>
								<th scope='row'>여행기간</th>
								<td colspan='3'>
									<%if(eventMstDTO.getStart_pyun() != null && !eventMstDTO.getStart_pyun().equals("")) {%>
									<span class='stdate'>출발 : <i><%=eventMstDTO.getStart_day().substring(0, 4)%>년 <%=eventMstDTO.getStart_day().substring(4, 6)%>월 <%=eventMstDTO.getStart_day().substring(6, 8)%>일 (<%=eventMstDTO.getStart_wday()%>) <% if(eventMstDTO.getStart_time() != null){ %><%=eventMstDTO.getStart_time().substring(0, 2)%>:<%=eventMstDTO.getStart_time().substring(2, 4)%><% } %> - <%=eventMstDTO.getStart_pyun()%></i></span><br>
									<%} else {%>
									<span class='stdate'>출발 : <i><%=eventMstDTO.getStart_day().substring(0, 4)%>년 <%=eventMstDTO.getStart_day().substring(4, 6)%>월 <%=eventMstDTO.getStart_day().substring(6, 8)%>일 (<%=eventMstDTO.getStart_wday()%>) <% if(eventMstDTO.getStart_time() != null) {%><%=eventMstDTO.getStart_time().substring(0, 2)%>:<%=eventMstDTO.getStart_time().substring(2, 4)%><%}%></i></span><br>
									<%}%>				
									<%if(eventMstDTO.getEnd_pyun() != null && !eventMstDTO.getEnd_pyun().equals("")) {%>
									<span class='eddate'>도착 : <i><%=eventMstDTO.getEnd_day().substring(0, 4)%>년 <%=eventMstDTO.getEnd_day().substring(4, 6)%>월 <%=eventMstDTO.getEnd_day().substring(6, 8)%>일 (<%=eventMstDTO.getEnd_wday()%>) <%if(eventMstDTO.getEnd_time() != null) {%><%=eventMstDTO.getEnd_time().substring(0, 2)%>:<%=eventMstDTO.getEnd_time().substring(2, 4)%><%}%> - <%=eventMstDTO.getEnd_pyun()%></i></span>
									<%} else {%>
									<span class='eddate'>도착 : <i><%=eventMstDTO.getEnd_day().substring(0, 4)%>년 <%=eventMstDTO.getEnd_day().substring(4, 6)%>월 <%=eventMstDTO.getEnd_day().substring(6, 8)%>일 (<%=eventMstDTO.getEnd_wday()%>) <%if(eventMstDTO.getEnd_time() != null) {%><%=eventMstDTO.getEnd_time().substring(0, 2)%>:<%=eventMstDTO.getEnd_time().substring(2, 4)%><%}%></i></span>
									<%}%>									

								</td>
							</tr>
							<tr>
								<th scope='row'>상품종류</th>
					<%
					if(eventMstDTO != null && eventMstDTO.getGoods_join_cd() == 1) {
					%>
									<td colspan='3'>단독상품</td>
					<%
					} else {
					%>
									<td colspan='3'>연합상품</td>			
					<%
					}
					%>
							</tr>
							<tr>
								<th>영업보증보험</th>
					<%			
					if(eventMstDTO.getBiz_insu_yn() != null && eventMstDTO.getBiz_insu_yn().equals("Y")) {
					%>
								<td>가입</td>
					<%
					} else {
					%>
								<td>미가입</td>			
					<%
					}
					%>
								<th class='left_bor'>기획여행<br/>보증보험</th>
					<%
					if(eventMstDTO.getPkg_insu_yn() != null && eventMstDTO.getPkg_insu_yn().equals("Y")) {
					%>
								<td>가입</td>
					<%
					} else {
					%>
								<td>미가입</td>			
					<%
					}
					%>
							</tr>
						</tbody>
					</table>
				 </div>
			 	<h1 class='btnAll'><a href='#' class="btn btnbox allopenbtn3">모두펼침</a></h1>
			</div>
    		<!--공통영역-->
			<div data-role='collapsible' data-iconpos='right' class='allmoney'>
			<h1 class='ui-nodisc-icon ui-alt-icon'>여행경비 총액</h1>
			<!--성인-->
				<h2 class='title_head'>상품가격</h2>
				<div class='collapsDiv'>
					<h3 class='collapsHeading' >성인</h3>
					<div class='collapsContent'>
						<table class='right'>
							<colgroup>
								<col width='33%'>
								<col width='33%'>
								<col width='33%'>
							</colgroup>
							<tbody>
								<tr>
									<th>기본상품가격</th>
									<th >유류할증료</th>
									<th>제세공과금</th>
								</tr>
								<tr>
									<td><%=eventMstDTO.getStr_adult_price()%>원</td>
									<td><%=eventMstDTO.getStr_etc_price1()%>원</td>
									<td>0원</td>
								</tr>
								<tr class='sum'>
									<th scope='row' colspan='2' >소계</th>
									<td><%=eventMstDTO.getStr_tot_amt1()%>원</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			<!--//성인-->
			<!--아동-->			
				<div class='collapsDiv'>
					<h3 class='collapsHeading' >아동</h3>
					<div class='collapsContent'>
			 			<table class='right'>
							<colgroup>
								<col width='33%'>
								<col width='33%'>
								<col width='33%'>
							</colgroup>
							<tbody>
								<tr>
									<th>기본상품가격</th>
									<th>유류할증료</th>
									<th>제세공과금</th>
								</tr>
								<tr>
									<td><%=eventMstDTO.getStr_child_price()%>원</td>
									<td><%=eventMstDTO.getStr_etc_price2()%>원</td>
									<td>0원</td>
								</tr>
								<tr class='sum'>
									<th scope='row' colspan='2' >소계</th>
									<td><%=eventMstDTO.getStr_tot_amt2()%>원</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			<!--//아동-->
			<!--유아-->
				<div class='collapsDiv'>
					<h3 class='collapsHeading'>유아</h3>
					<div class='collapsContent'>
						<table class='right'>
							<colgroup>
								<col width='33%'>
								<col width='33%'>
								<col width='33%'>
							</colgroup>
							<tbody>
								<tr>
									<th>기본상품가격</th>
									<th>유류할증료</th>
									<th>제세공과금</th>
								</tr>
								<tr>
									<td><%=eventMstDTO.getStr_baby_price()%>원</td>
									<td><%=eventMstDTO.getStr_etc_price3()%>원</td>
									<td>0원</td>
								</tr>
								<tr class='sum'>
									<th scope='row' colspan='2' >소계</th>
									<td><%=eventMstDTO.getStr_tot_amt3()%>원</td>
								</tr>
							</tbody>
						</table>
						<p>- 유류할증료는 유가와 환율에 따라 변동될 수 있습니다.</p>
					</div>					
				</div>
			<!--//유아-->
				<h2 class='title_head'>현지필수경비</h2>
				<div class='collapsDiv'>
					<h1 class='collapsHeading' >가이드 기사경비</h1>
					<div class='collapsContent'>
						<table class='right'>
							<colgroup>
								<col width='40%'>
								<col width='60%'>
							</colgroup>
							<tbody>
							<tr>
								<th scope='row'>성인</th>
								<td><%=(eventMstDTO.getEtc_price_title1() != null)?eventMstDTO.getEtc_price_title1():"0"%>원</td>
							</tr>
							<tr>
								<th scope='row'>아동</th>
								<td><%=(eventMstDTO.getEtc_price_title2() != null)?eventMstDTO.getEtc_price_title2():"0"%>원</td>
							</tr>
							<tr>
								<th scope='row'>유아</th>
								<td><%=(eventMstDTO.getEtc_price_title3() != null)?eventMstDTO.getEtc_price_title3():"0"%>원</td>
							</tr>
							</tbody>
						</table>
					</div>
				</div>
			<!--아동-->
			</div>
			<div data-role='collapsible' data-iconpos='right'>
				<h1 class='ui-nodisc-icon ui-alt-icon'>최소출발인원 및 수수료 정보</h1>
				<table class='right'>
					<colgroup>
						<col width='40%'>
						<col width='60%'>
					</colgroup>
					<tbody>
						<tr>
							<th scope='row'>최소출발인원기준</th>
							<td><%=eventMstDTO.getMin_inwon()%>명</td>
						</tr>
						<tr>
							<th scope='row'>취소수수료 부과 기준</th>
							<td>표준약관 적용</td>
						</tr>
					</tbody>
				</table>
				<span>- 최소출발인원 미충족시 여행약관에 따라 여행출발 7일전까지 여행사는 여행계약을 일방적으로 해제하고 여행자에게 통보할 수 있습니다.</span>
				<span>- 취소수수료는 계약금 입금일 부터 적용됩니다. 취소 수수료 부과 세부 기준을 반드시 확인하세요.</span>
				<span>- 특별약관 적용의 경우, 표준약관보다 높은 취소수수료가 부과될 수 있습니다.</span>
			</div>
			<div data-role='collapsible' data-iconpos='right'>
				<h1 class='ui-nodisc-icon ui-alt-icon'>주요확정/미정정보</h1>
				<table class='center'>
				<colgroup>
					<col width='25%'>
					<col width='25%'>
					<col width='25%'>
					<col width='25%'>
				</colgroup>
				<tbody>
					<tr>
							<th scope='cols'>출발</th>
					<%		
					if(eventMstDTO.getConf_yn() != null && eventMstDTO.getConf_yn().equals("Y")) {
					%>
							<td>확정</td>
					<%
					} else {
					%>
							<td>미정</td>				
					<%
					}
					%>
							<th scope='cols'>여행일정</th>
					<%
					if(eventMstDTO.getConf_land() != null && eventMstDTO.getConf_land().equals("Y")) {
					%>
							<td>확정</td>
					<%
					} else {
					%>
							<td>미정</td>				
					<%
					}
					%>
						</tr>
						<tr>
							<th scope='cols'>상품가격</th>
							<td>확정</td>
							<th scope='cols'>항공</th>
					<%		
					if(eventMstDTO.getConf_air() != null && eventMstDTO.getConf_air().equals("Y")) {
					%>	
							<td>확정</td>
					<%
					} else {
					%>
							<td>미정</td>				
					<%
					}
					%>			
						</tr>
						<tr>
							<th scope='cols'>호텔</th>
					<%
					if(eventMstDTO.getConf_hotel() != null && eventMstDTO.getConf_hotel().equals("Y")) {
					%>
							<td>확정</td>
					<%
					} else {
					%>
							<td>미정</td>				
					<%
					}
					%>
							<th scope='row'>가이드</th>
					<%		
					if(eventMstDTO.getGuide_yn() != null && eventMstDTO.getGuide_yn().equals('Y')) {
					%>
							<td>확정</td>
					<%
					} else {
					%>
							<td>미정</td>				
					<%
					}
					%>			
						</tr>
						<tr>
							<th scope='cols'>인솔자</th>
					<%		
					if(eventMstDTO != null && eventMstDTO.getTc_cnt() > 0) {
					%>
							<td>동반</td>
					<%
					} else {
					%>
							<td>미동반</td>				
					<%
					}
					%>	
							<th scope='cols'></th>
							<td></td>
						</tr>
					</tbody>
				</table>
				<p>- 쇼핑 품목,장소,소요시간,환불여부 등 세부항목은 상세페이지에서 반드시 확인하세요.</p>
			</div>
			<div data-role='collapsible' data-iconpos='right'>
				<h1 class='ui-nodisc-icon ui-alt-icon'>쇼핑정보</h1>
				<table class='right'>
					<colgroup>
						<col width='40%'>
						<col width='60%'>
					</colgroup>
					<tbody>
					<tr>
						<th scope='row'>쇼핑횟수</th>
						<td><%=shopCnt%>회</td>
					</tr>
					</tbody>
						</table>
						<p>- 쇼핑 품목,장소,소요시간,환불여부 등 세부항목은 상세페이지에서 반드시 확인하세요.</p>
					</div>
					<div data-role='collapsible' data-iconpos='right'>
						<h1 class='ui-nodisc-icon ui-alt-icon'>여행지 안전정보</h1>
						


			<%				
			if(eventCommSchdList != null) {
				for(int i = 0; i < eventCommSchdList.size(); i++) {
					EventCommSchdVO eventCommSchd = (EventCommSchdVO) eventCommSchdList.get(i);
					// SAF : 여행지 안전정보				
					if(eventCommSchd.getComm_cd() != null && eventCommSchd.getComm_cd().equals("SAF")) { // 여행지 안전정보 
			%>
						<table>
						    <caption>선택관광명, 1인요금, 소요시간, 내용, 대체일정순으로 나타낸 표</caption>
							<colgroup>
								<col width='40%'>
								<col width='60%'>
							</colgroup>
							<tbody>
							<tr>
			<%
						if(eventCommSchd.getEtc1() != null && eventCommSchd.getEtc1().equals("1")) {
			%>
								<th scope='row'>1단계 여행 유의</th>
			<%					
						} else if(eventCommSchd.getEtc1() != null && eventCommSchd.getEtc1().equals("2")) {
			%>
								<th scope='row'>2단계 여행 자제</th>
			<%					
						} else if(eventCommSchd.getEtc1() != null && eventCommSchd.getEtc1().equals("3")) {
			%>
								<th scope='row'>3단계 철수 권고</th>
			<%					
						} else if(eventCommSchd.getEtc1() != null && eventCommSchd.getEtc1().equals("4")) {
			%>
								<th scope='row'>4단계 여행 금지</th>
			<%					
						}
				
			%>
			<%
						if(eventCommSchd.getEtc2() != null) {
			%>
								<td><%=eventCommSchd.getEtc2()%></td>
			<%
						}else{
			%>
								<td>
									<span style="float:left;background-color:#0717e2;padding:2px 8px;color:#FFFFFF;margin-right:5px;">경보없음</span>
									<p style="line-height:20px;font-weight:bold;">여행 경보가 없는 안전한 여행지역입니다.</p>
								</td>
			<%
						}
			%>
							</tr>
							</tbody>
						</table>	
			<%
					}
				}
			}
			%>
					<h1 class='btnAll'><a href='http://www.0404.go.kr/m/dev/main.do' class='btn btnbox site' target='_blank'>해외안전여행</a></h1>
			</div>
			
		</div>	
	</section>
	
	<div data-role="collapsible" data-iconpos="right" data-collapsed="false" class="mgT10">
		<h1 class="ui-nodisc-icon ui-alt-icon">예약 및 상담문의</h1>
		<p><b class="purple">해외 1577-6511 / 국내 1577-6111</b><span>해외여행 전문가의 친절한 상담을 받으실 수 있습니다.</span>
		<span>상담시간 :평일 09:00 ~ 18:00 / 토요일 09:00 ~ 12:00</span></p>
	</div>
	<div data-role="collapsible" data-iconpos="right" data-collapsed="false">
		<h1 class="ui-nodisc-icon ui-alt-icon">유류할증료</h1>
			<p><span>국토교통부의 '국제선 항공요금과 유류할증료 확대방안' 또는 'IATA의 ROE 인상 발표'에 따라 국외여행 표준약관에 준하여 여행 비용이 예고없이 인상되거나, 또는 인하된 금액으로 반영될 수 있습니다.</span></p>
	</div>
	<div class="collapsDiv link">
		<a href='#' class="layerOpener" data-url="/goods/pop_policy.do" data-ok="yes"><h3 class="collapsHeading">표준약관보기</h3>	</a>	
	</div>

	<!-- 상품 카테고리 DEPTH2 레이어 영역 -->
	<%@ include file="/WEB-INF/jsp/goods/inc_layer_goods_ctg.jsp"%>
	<!-- 찜하기 팝업   -->
	<%@ include file="/WEB-INF/jsp/goods/pop_cart.jsp"%>


</div> 
<script src="/resources/common/bottom.js"></script>
<!--상품상세 탭영역-->	
<!--//contentWrap-->
<!--//content-->