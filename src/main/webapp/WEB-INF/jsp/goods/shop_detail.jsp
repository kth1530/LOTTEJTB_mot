<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.net.*"%>
<%@ page import="com.lottejtb.util.*"%>
<%@ page import="com.lottejtb.goods.rn.service.*"%>
<%@ page import="com.lottejtb.comm.util.*"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>

<%

	String ctg = (String) request.getAttribute("ctg");
	String goodsCd = (String) request.getAttribute("goodsCd");
	String eventCd = (String) request.getAttribute("eventCd");
	String schd = (String) request.getAttribute("schd");
	String flag = (String) request.getAttribute("flag"); // 담당자 조회가 필요한 경우는 flag=BO 파라미터 출발일 체크 항목을 피함
	// 회원 등급 (임직원 : 그룹직원)
	//String grade = (String) request.getAttribute("grade");
	String grade = "";
	//일정표 
	String schdgb = (String) request.getParameter("schd");


	if(request.getAttribute("grade") != null){
		grade = (String) request.getAttribute("grade");
	}
	//grade = "그룹직원";
	String msg = "";

	RNETMstVO rnEtMst = (RNETMstVO) request.getAttribute("rnEtMst");
	RNGDMstVO rnGDMst = (RNGDMstVO) request.getAttribute("rnGDMst");
	RNGDTagsVO rnGDTags = (RNGDTagsVO) request.getAttribute("rnGDTags");
	List rnGDImgList = (List) request.getAttribute("rnGDImgList");
	List rnGDCommSchdList = (List) request.getAttribute("rnGDCommSchdList");
	List rnGDSchdList = (List) request.getAttribute("rnGDSchdList");
	List weatherList = (List) request.getAttribute("weatherList");
	List timeDifferCurrencyList = (List) request.getAttribute("timeDifferCurrencyList");
	// 서버 날짜 받아오기 
	Date nowSystemDate = new Date();
	SimpleDateFormat nowSdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
	String nowServerDay = nowSdf.format(nowSystemDate);
	
	// 출발일이 지난 상품인지 체크함.
	//[JEH] 도착일로 기준 변경 - 20190409
	if(flag == null || !flag.equals("BO")) {
		String end_day = rnEtMst.getEnd_day();
		if(end_day == null || end_day.equals("")) end_day = "0";
		int nEndDay = Integer.parseInt(end_day);

		int nServerDay = Integer.parseInt(nowServerDay);

		if(nServerDay > nEndDay) {
			//RequestDispatcher dispatcher = request.getSession().getServletContext().getRequestDispatcher("http://m.lottejtb.com");
			//dispatcher.forward(request,response);
			//response.sendRedirect("http://m.lottejtb.com");
			msg = "여행이 종료된 일정입니다. 메인으로 이동합니다.";
		}
	}

	if(rnEtMst == null) {
			RequestDispatcher dispatcher = request.getSession().getServletContext().getRequestDispatcher("http://m.lottejtb.com");
			dispatcher.forward(request,response);
			//response.sendRedirect("http://m.lottejtb.com");		
	}

	/**
	* 임직원 할인가격 적용 
	**/	
	double empAdultPrice = 0;
	double empChildPrice = 0;
	double empBabyPrice = 0;

	if(grade.equals("그룹직원")) {

		if(rnEtMst.getEmp_rate() > 0) {
			empAdultPrice =  (1 - (Double.valueOf(String.valueOf(rnEtMst.getEmp_rate())) / 100))  * Double.valueOf(String.valueOf(rnEtMst.getAdult_price())) + Double.valueOf(String.valueOf(rnEtMst.getEtc_price1()));
			empChildPrice =  (1 - (Double.valueOf(String.valueOf(rnEtMst.getEmp_rate())) / 100))  * Double.valueOf(String.valueOf(rnEtMst.getChild_price())) + Double.valueOf(String.valueOf(rnEtMst.getEtc_price2()));
			empBabyPrice  =  (1 - (Double.valueOf(String.valueOf(rnEtMst.getEmp_rate())) / 100))  * Double.valueOf(String.valueOf(rnEtMst.getBaby_price())) + Double.valueOf(String.valueOf(rnEtMst.getEtc_price3()));
								
		}

	}

/**
* [AS_IS] 예약 마감 및 출발 가능/예약 가능 로직입니다. 
* OP_CD : OT 해외 일 경우 <출발일 기준 : 2일전>
* 출발일 국내 2일, 해외 4일 체크 
**/		

	Date startDate = nowSdf.parse(rnEtMst.getStart_day());
	String strStartDate = rnEtMst.getStart_day();

	Calendar otGoodsDate = Calendar.getInstance();
  	otGoodsDate.setTime(startDate);
	otGoodsDate.add(Calendar.DATE, -4);
	String strOtGoodsDate = nowSdf.format(otGoodsDate.getTime());

	Calendar doGoodsDate = Calendar.getInstance();
  	doGoodsDate.setTime(startDate);
	doGoodsDate.add(Calendar.DATE, -2);
	String strDoGoodsDate = nowSdf.format(doGoodsDate.getTime());

	String reservTag = "";

	int rvCnt = rnEtMst.getRv_cnt();
	int evInwon = rnEtMst.getEv_inwon();
	String lockUnit = rnEtMst.getLock_unit();
	String procCd = rnEtMst.getProc_cd();

	if(rnGDMst.getOp_cd().equals("OT") && Integer.parseInt(nowServerDay) > Integer.parseInt(strOtGoodsDate)) { // 해외 여행 
		reservTag = "예약마감"; 
	} else if(!rnGDMst.getOp_cd().equals("OT") && Integer.parseInt(nowServerDay) > Integer.parseInt(strDoGoodsDate)) { // 국내 여행
		reservTag = "예약마감";
	} else if (rvCnt >= evInwon) {
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
<script src="/resources/common/js/utils.js"></script>
<script src="/resources/common/js/swiper.js"></script>	
<script type="text/javascript">

<!--

	console.log(" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");
	console.log(" >> opCd :  " + '<%=rnGDMst.getOp_cd()%>');
	console.log(" >> serverDay :  " + '<%=nowServerDay%>');
	console.log(" >> otGoodsDate  :  " + '<%=strOtGoodsDate%>');
	console.log(" >> doGoodsDate  :  " + '<%=strDoGoodsDate%>');
	console.log(" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");	

	var msg = "<%=msg%>";
	if(msg){
		alert(msg);
		location.href = "/main.do";
	}
	
   var knm = "${knm}";
   var cust_cd = "${cust_cd}";
   var email = "${email}";

   var flag = false;
   var list;
   var listSize = '${listSize}';
   var reviewTotalCount = 0; // 상품평 리스트 총 갯수 
   var eventMstList = null; // 여행 상품 정보 
   var goodsReviewList = null; // 상품평 리스트 
   var eventCommSchdList = null; // 행사 정보 및 일정표 
   var eventGroupAllSchdList = null; // 전체 행사 상품 리스트 
   var eventMstDTO = null; // 행사 상품 마스터 
   var division = "E"; // 전시항목 
   var pageSize = 2;
   var ctg = '${ctg}';
   var eventCd = '${eventCd}';
   var goodsCd = '${goodsCd}';
   var curRow = 2;
   var start_day = "<%=rnEtMst.getStart_day()%>";
   var dispNm = "<%=rnEtMst.getDisp_nm()%>";
   
   var schdGubun = "<%=schdgb%>";
   
   var schd = '${schd}';

   // 초기화
   var fn_init = function() {
       // 상품 카테고리 정보 
	   <%
	   		if(ctg != null && !ctg.equals("0")) {
	   %>
			$("#ctg1").show();
			$("#ctg2").show();
			fn_goodsCtg2();
       // 찜하기 셋팅
       <%
   			} else {
		%>
			$("#ctg1").hide();
			$("#ctg2").hide();
			
		<%
			}
			RNGDImgVO goodsImgVO_cookie = null;
			if(rnGDImgList != null && rnGDImgList.size() > 0) {
	          		goodsImgVO_cookie = (RNGDImgVO) rnGDImgList.get(0);                                    
			} else {
				goodsImgVO_cookie = new RNGDImgVO();
			}
		%>

         //var imagePath = "http://www.lottejtb.com/upload/common/goods/" + "<!%=goodsCd.substring(0, 2)%>" + "/" + "<!%=goodsCd%>" + "/" + "<!%=goodsImgVO_cookie.getSave_file_nm()%>";
         var imagePath = "/m_file/upload/common/goods/" + "<%=goodsCd.substring(0, 2)%>" + "/" + "<%=goodsCd%>" + "/" + "<%=goodsImgVO_cookie.getSave_file_nm()%>";
         setTodayEvents(eventCd, ctg, imagePath, "<%=rnEtMst.getDisp_nm()%>", "<%=rnEtMst.getEv_day_cnt()%>", "<%=rnEtMst.getEv_night_cnt()%>", "<%=rnEtMst.getAdult_price()%>", "<%=rnEtMst.getCd_nm()%>");


     };

     //[JEH] 메타태그 변경 - 20180725
     fn_chgMetaTag();
     function fn_chgMetaTag(){
  	  $("#meta_title").attr("content","<%=rnEtMst.getDisp_nm()%>"); 
  	  $("#meta_img").attr("content","http://m.lottejtb.com/m_file/upload/common/goods/" + "<%=goodsCd.substring(0, 2)%>" + "/" + "<%=goodsCd%>" + "/" + "<%=goodsImgVO_cookie.getSave_file_nm()%>"); 
     };

     function sessionCheck() {
         if (fn_chkLogin() == 1) {} else {
             fn_goLogin();
         }
     }


     var fn_search = function() {

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
             loop: true,
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

         document.location.href = "/mytour/mytour.do#tab2";
     }

     // 다른 출발일 보기 
     function fn_goMaster(gubun) {
    	 if(gubun == "Y"){
	         document.location.href = "/goods/master.do?ctg=" + ctg + "&goodsCd=" + goodsCd + "&eventCd=" + eventCd + "&price=" + <%=(rnEtMst.getAdult_price()+rnEtMst.getEtc_price1()) %>;
    	 }else{
	         document.location.href = "/goods/master.do?ctg=" + ctg + "&goodsCd=" + goodsCd + "&eventCd=" + eventCd;
    	 }
     }

	 // 다른 이용항공 상품으로 이동하기 
	 function fn_goOtherAirLine(eventCd) {
		 document.location.href = "/goods/detail_goods.do?ctg=<%=ctg%>&eventCd=" + eventCd;
	 }

     function fn_goReserve() {
    	 
    	 //[JEH] 예약 가능 여부 체크 - 20180119
		var isApply = 'N';
		var chkInwon = fn_chkInwon(ctg,goodsCd,eventCd);
		
		if(chkInwon){
			isApply = 'Y';
		}else{
			isApply = 'N';
		}

		isApply = 'Y';
		if(isApply == 'Y'){
	         //비로그인 상태
	         if (cust_cd == null || cust_cd == "")
	             document.location.replace("/sso/nologinPage.do?ctg=" + ctg + "&goodsCd=" + goodsCd + "&eventCd=" + eventCd);
	         else //로그인상태
	             document.location.replace("/reserve/reserve_clause.do?ctg=" + ctg + "&goodsCd=" + goodsCd + "&eventCd=" + eventCd);
		}else{
			alert('예약 마감되었습니다.');
			window.location.reload();
			return;
		}
     }

     // 상품평 작성 
     function fn_goReview() {
         document.location.href = "/goods/pop_review.do?ctg=" + ctg + "&goodsCd=" + goodsCd + "&eventCd=" + eventCd + "&goodsNm=<%=rnEtMst.getDisp_nm()%>";
         /**
         if(fn_chkLogin() == 1) {
         } else {
         	fn_goLogin();
         }
         **/
     }

	 // 다른 이용항공사 보기 
	 function fn_goOtherAirLines() {
		 alert("다른 이용항공사가 없습니다.");
	 }

     /* *************************************************************************** */
     // [AJAX] 데이타 통신 부분 

     // 상품 찜하기 
     function fn_saveCart() {
         // 미 로그인 시 

         if (fn_chkLogin() == 1) {

         } else {
             fn_goLogin();
         }

     };

     // 상품평 리스트 더보기 버튼 노출 유무 
     var fn_SetDisplayBtnMoreReview = function() {
         console.log("================ 목록 수 체크 ===================");
         console.log("reviewTotalSize : ", reviewTotalSize);
         console.log("curRow : ", curRow);
         console.log("================ 목록 수 체크 ===================");


         // 상품평 목록 더보기 

         if (curRow < reviewTotalSize) {
             document.all.btn_more.style.display = "";
         } else {
             document.all.btn_more.style.display = "none";
         }

     }

     // 상품평 리스트 조회 
     var fn_ReviewList = function() {


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
             noloading: "no",
             timeOut: (5 * 60 * 1000),
             success: function(res) {
                 goodsReviewList = res.goodsReviewList;
                 curRow = goodsReviewList.length;

                 var html = "";
                 
                 if (goodsReviewList == null || goodsReviewList.length == 0) {
                     html = html + "                 	<table>";
                     html = html + "            			<tr>";
                     html = html + "            				<td class='comment'><center>등록된 상품평이 없습니다.</center></td>";
                     html = html + "            			</tr>";
                     html = html + "            		</table>";                 	 
             	 } else {
                     for (var i = 0; i < goodsReviewList.length; i++) {
                         html = html + "                 	<table>";
                         html = html + "            			<tr>";
                         html = html + "            				<td>" + goodsReviewList[i]["eval_cnts"] + "</td>";
                         html = html + "            			</tr>";
                         html = html + "            			<tr>";
                         html = html + "            				<td><span>" + goodsReviewList[i]["cust_nm"] + "(" + goodsReviewList[i]["lotte_id"] + ")</span>"; 

                    	 

                         var avg = goodsReviewList[i]["eval_avg"];
                         var cnt = avg / 20;
                         var idx2 = 0;
                         for (idx2 = 0; idx2 < 5; idx2++) {
                        	 
                         	 if(idx2 < cnt) {
                             	html = html + "					<em class='on'>★</em>";
                         	 } else {
                         		html = html + "					<em>★</em>";
                         	 }
                         }
                         html = html + "            				</td>"; 
                         html = html + "            			</tr>"; 
                         html = html + "            		</table>"; 
                     }   
                 } 

                 //console.log("reviewList >>>> " + reviewList);

                 $("#reviewList").html(html).trigger('create');

             },
             error: function(err) {
                 //console.log(err);
             },
             complete: function() {
                 // 상품평 목록 카운터 조회 
                 fn_ReviewListCount();

             }
         });
     };

     // 상품평 리스트 (카운트)
     var fn_ReviewListCount = function(type) {

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
             noloading: "no",
             timeOut: (5 * 60 * 1000),
             success: function(res) {

                 reviewTotalSize = res.reviewTotalSize;

 
             },
             error: function(err) {
                 //console.log(err);
             },
             complete: function() {
                 // 상품평 목록 더보기 버튼 노출 유무 판단 
                 fn_SetDisplayBtnMoreReview();            	 
             }
         });
     };

     // (더보기) 상품평 리스트 조회 
     var fn_MoreReviewList = function() {
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
             noloading: "no",
             timeOut: (5 * 60 * 1000),
             success: function(res) {
                 goodsReviewList = res.goodsReviewList;
                 curRow = curRow + goodsReviewList.length;

                 var html = "";
                 if (goodsReviewList != null) {
                     for (var i = 0; i < goodsReviewList.length; i++) {

                         html = html + "                 	<table>";
                         html = html + "            			<tr>";
                         html = html + "            				<td>" + goodsReviewList[i]["eval_cnts"] + "</td>";
                         html = html + "            			</tr>";
                         html = html + "            			<tr>";
                         html = html + "            				<td><span>" + goodsReviewList[i]["cust_nm"] + "(" + goodsReviewList[i]["lotte_id"] + ")</span>"; 

                    	 

                         var avg = goodsReviewList[i]["eval_avg"];
                         var cnt = avg / 20;
                         var idx2 = 0;
                         for (idx2 = 0; idx2 < 5; idx2++) {
                        	 
                         	 if(idx2 < cnt) {
                             	html = html + "					<em class='on'>★</em>";
                         	 } else {
                         		html = html + "					<em>★</em>";
                         	 }
                         }
                         html = html + "            				</td>"; 
                         html = html + "            			</tr>"; 
                         html = html + "            		</table>"; 
                     }
                 }

                 $("#reviewList").append(html).trigger('create');

             },
             error: function(err) {
                 //console.log(err);
             },
             complete: function() {
                 // 상품평 목록 카운터 조회 
                 fn_ReviewListCount();
             }
         });
     };

	// 스와이프 초기화 
	var fn_InitSwipper = function() {

			var gallery = new Swiper('.imgGallery2', {
			
			//  pagination: '.swiper-pagination1',
				pagination: '.swiper-pagination',
				spaceBetween: 0,
				paginationClickable: true,
				loop:true,
				loopedSlides: 2, //looped slides should be the same  			
		});					
	}

     // [COMMON] 공통사항 
     $(document).ready(function() {
    	 

         fn_init();
         fn_initButton();
         chgReserve('<%=reservTag%>');
         fn_InitSwipper();
		 fn_ReviewList();
		 
		 if(ctg == '5811'){
			$("#ctg1").hide();
			$("#ctg2").hide();
		}
		 
		 //TOS에서 발송된 일정표SMS일경우에만 일정표TAB이 먼저 활성화된다.
		 if(schdGubun=='Y'){
			 $("#schedule").trigger("click");
     	}
		 
	});

	function chgReserve(type) {
		if (type == '예약' || type == '출발가능') {
			$('#span_reserve01').show();
			$('#span_reserve02').hide();
			$('#reserveLI').css("background", "#353163");
		} else {
			$('#span_reserve02').show();	
			$('#span_reserve01').hide();
			$('#reserveLI').css("background", "#666666");
		}
	}

	// });
//-->
</script>
</head>

<body>

	<!--content-->
	<div role="main" class="ui-content contentWrap shopdetailbox">
		<div class="collapse shoptop">
			<!-- 카테고리 01 -->
			<p class="sd_category1" id="ctg1" name="ctg1">
				<button type="button" onClick="popGoodsCategory1()" data-role="none">
					<span id="ctg_depth2" name="ctg_depth2">선택</span>
				</button>
			</p>
			<!-- 카테고리 02 -->

			<p class="sd_category2" id="ctg2" name="ctg2">
				<button type="button" onClick="popGoodsCategory2()" data-role="none">
					<span id="ctg_depth3" name="ctg_depth3">선택</span>
				</button>
			</p>

			<div class="sd_areabox1">
				<!-- 상품타이틀 -->
				<div class="sd_titlebox">
					<p>
						상품코드
						<%=rnEtMst.getEvent_cd()%>
					</p>
					<div class="posfixed1">
						<p>
							<span class="ellipsis ellipsis2" id="disp_nm" name="disp_nm"><%=rnEtMst.getDisp_nm()%></span>
						</p>
					</div>
				</div>
				<!-- 상품이미지 swipe -->
				<div class="swiper-container imgGallery2">
					<div class="swiper-wrapper">
						
						<%
							
							for (int i = 0; i < rnGDImgList.size(); i++) {
								if(i < 6) {
									RNGDImgVO rnGDImgVO = (RNGDImgVO) rnGDImgList.get(i);
						%>
						<div class="swiper-slide">	
							<!-- img src="http://www.lottejtb.com/upload/common/goods/<!%=goodsCd.substring(0, 2)%>/<!%=goodsCd%>/<!%=rnGDImgVO.chgImage(rnGDImgVO.getSave_file_nm(),"D")%>" -->
							<img src="/m_file/upload/common/goods/<%=goodsCd.substring(0, 2)%>/<%=goodsCd%>/<%=rnGDImgVO.chgImage(rnGDImgVO.getSave_file_nm(),"D")%>">
						</div>

						<%
								}
							}
						%>
					</div>
					<div class="swiper-pagination"></div>
				</div>
				<!-- 출발일 / 도착일 -->
				<dl class="sd_streetday">
					<%
						if (rnEtMst.getStart_pyun() != null && !rnEtMst.getStart_pyun().equals("")) {
					%>
					<dt>출발일</dt>
					<dd><%=rnEtMst.getStart_day().substring(0, 4)%>년 <%=rnEtMst.getStart_day().substring(4, 6)%>월 <%=rnEtMst.getStart_day().substring(6, 8)%>일 (<%=rnEtMst.getStart_wday()%>)
						<%
							if (rnEtMst.getStart_time() != null) {
						%>
						<%=rnEtMst.getStart_time().substring(0, 2)%>:<%=rnEtMst.getStart_time().substring(2, 4)%>
						<%
							}
						%>
						- <%=rnEtMst.getStart_pyun()%>
					</dd>
					<%
						} else {
					%>
					<dt>출발일</dt>
					<dd>
						<%=rnEtMst.getStart_day().substring(0, 4)%>년 <%=rnEtMst.getStart_day().substring(4, 6)%>월 <%=rnEtMst.getStart_day().substring(6, 8)%>일 (<%=rnEtMst.getStart_wday()%>)
						<%
							if (rnEtMst.getStart_time() != null) {
						%>
						<%=rnEtMst.getStart_time().substring(0, 2)%>:<%=rnEtMst.getStart_time().substring(2, 4)%>
						<%
							}
						%>
					</dd>
					<%
						}
					%>
					<%
						if (rnEtMst.getEnd_pyun() != null && !rnEtMst.getEnd_pyun().equals("")) {
					%>
					<dt>도착일</dt>
					<dd>
						<%=rnEtMst.getEnd_day().substring(0, 4)%>년 <%=rnEtMst.getEnd_day().substring(4, 6)%>월 <%=rnEtMst.getEnd_day().substring(6, 8)%>일 (<%=rnEtMst.getEnd_wday()%>)
						<%
							if (rnEtMst.getEnd_time() != null) {
						%>
						<%=rnEtMst.getEnd_time().substring(0, 2)%>:<%=rnEtMst.getEnd_time().substring(2, 4)%>
						<%
							}
						%>
						- <%=rnEtMst.getEnd_pyun()%>
					</dd>
					<%
						} else {
					%>
					<dt>도착일</dt>
					<dd>
						<%=rnEtMst.getEnd_day().substring(0, 4)%>년 <%=rnEtMst.getEnd_day().substring(4, 6)%>월 <%=rnEtMst.getEnd_day().substring(6, 8)%>일 (<%=rnEtMst.getEnd_wday()%>)
						<%
							if (rnEtMst.getEnd_time() != null) {
						%>
						<%=rnEtMst.getEnd_time().substring(0, 2)%>:<%=rnEtMst.getEnd_time().substring(2, 4)%>
						<%
							}
						%>
					</dd>
					<%
						}
					%>
				</dl>
				<div class="btn_one sd_otherstart mb10">
					<button class="white2" data-role="none">
						<c:if test="${rnEtMst.min_yn == 'Y'}">
							<span><a href='javascript:fn_goMaster("Y");' data-ajax='false' data-role='none'> 동일상품 낮은가격, 다른 출발일 보기</a></span>
						</c:if>
						<c:if test="${rnEtMst.min_yn == 'N'}">
							<span><a href='javascript:fn_goMaster("N");' data-ajax='false' data-role='none'>다른 출발일 보기</a></span>
						</c:if>
					</button>
				</div>
				<% if(rnEtMst.getTrff_cd() != null && rnEtMst.getTrff_cd().toUpperCase().startsWith("AIR") && rnEtMst.getStart_pyun() != null &&  !rnEtMst.getStart_pyun().equals("")  && !rnEtMst.getStart_pyun().toLowerCase().equals("bus") && !rnEtMst.getStart_pyun().toLowerCase().equals("ship")) { %>
				<div class="btn_one sd_otherair">
					<button class="purple2 layerOpener" data-role="none" data-url="/goods/pop_other_airlines.do?eventCd=${eventCd}&startDay=<%=rnEtMst.getStart_day()%>" data-ok="yes">
						<span>다른 이용항공 보기</span>
					</button>
				</div>
				<% } %>
			</div>

			<!-- 예약상세정보 -->
			<div class="sd_areabox1">

				<%
				if(rnEtMst.getTrff_cd() != null && rnEtMst.getTrff_cd().toUpperCase().startsWith("AIR")) {
				%>
				<p class="sd_info_title sd_info_ico1">
					<em></em>예약항공
				</p>
				<div class="sd_info_ctn">
					<p class="sd_airicon">
						<span><img src="/resources/images/air/<%=rnEtMst.getTrff_cd_short()%>.png"></span> <span><%=rnEtMst.getCd_nm()%></span>
					</p>
				</div>
				<%
				} else if(rnEtMst.getTrff_cd() != null && rnEtMst.getTrff_cd().toUpperCase().startsWith("BUS")) {
				%>
				<p class="sd_info_title sd_info_ico1">
					<em></em>이용교통
				</p>
				<div class="sd_info_ctn">
					<p class="sd_airicon">
						<span><img src="/resources/images/ico/BUS.png"></span> <span><%=rnEtMst.getStart_pyun()%></span>
					</p>
				</div>
				<%
				} else if(rnEtMst.getTrff_cd() != null && rnEtMst.getTrff_cd().toUpperCase().startsWith("CAR")) {
				%>
				<p class="sd_info_title sd_info_ico1">
					<em></em>이용교통
				</p>
				<div class="sd_info_ctn">
					<p class="sd_airicon">
						<span><img src="/resources/images/ico/CAR.png"></span> <span><%=rnEtMst.getStart_pyun()%></span>
					</p>
				</div>				
				<%
				} else if(rnEtMst.getTrff_cd() != null && rnEtMst.getTrff_cd().toUpperCase().startsWith("SHP")) {
				%>
				<p class="sd_info_title sd_info_ico1">
					<em></em>이용교통
				</p>
				<div class="sd_info_ctn">
					<p class="sd_airicon">
						<span><img src="/resources/images/ico/SHP.png"></span> <span><%=rnEtMst.getStart_pyun()%></span>
					</p>
				</div>				
				<%
				} else if(rnEtMst.getTrff_cd() != null && rnEtMst.getTrff_cd().toUpperCase().startsWith("TRA")) {
				%>
				<p class="sd_info_title sd_info_ico1">
					<em></em>이용교통
				</p>
				<div class="sd_info_ctn">
					<p class="sd_airicon">
						<span><img src="/resources/images/ico/TRA.png"></span> <span><%=rnEtMst.getStart_pyun()%></span>
					</p>
				</div>				
				<%
				}
				%>			
				<p class="sd_info_title sd_info_ico2">
					<em></em>예약
				</p>
				<div class="sd_info_ctn"><%=reservTag%> <%=rvCnt%>명 | 배정석 <%=evInwon%>석(최소출발 <%=rnEtMst.getMin_inwon()%>명)</div>

				<p class="sd_info_title sd_info_ico3">
					<em></em>방문도시
				</p>
<% 

String countryFullKr = "";
String countryFullPathKr = "";

if(rnGDSchdList != null) {
	for(int i = 0; i < rnGDSchdList.size(); i++) {
		RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDSchdList.get(i);
		if(eventCommSchd.getDay_cnt() > 0 && eventCommSchd.getSchd_det_cd().equals("1001")) { // 도시 
			
			if(eventCommSchd.getSchd_det_cntn() != null) {
				// 동일한 방문 도시 중복을 회피하기 위해 
				
				
				if(!eventCommSchd.getSchd_det_cntn().trim().equals(countryFullKr) && !eventCommSchd.getSchd_det_cntn().trim().endsWith("공항")) {
					if(!countryFullPathKr.equals("")) {
						countryFullPathKr = countryFullPathKr + " > " + eventCommSchd.getSchd_det_cntn().trim(); 
					} else {
						countryFullPathKr = eventCommSchd.getSchd_det_cntn().trim();
					}
					countryFullKr = eventCommSchd.getSchd_det_cntn().trim();
				}
			} 
		}
	}
}
%>				
				<div class="sd_info_ctn"><%=countryFullPathKr%></div>

				<p class="sd_info_title sd_info_ico4">
					<em></em>상품가격
					<button class="sd_all_btn" data-role="none">모두펼침</button>
				</p>
				<!-- 상품가격텝메뉴 -->
				<dl class="sd_tahaco sd_price_info">
					<dt class="on">
						<span>성인 (만 12세이상)</span>
					</dt>
					<dd>
						총 상품가격<span class="f_purple"> <%=CommUtil.decimalFormat(rnEtMst.getAdult_price()+rnEtMst.getEtc_price1()) %></span>원<br> 
						기본상품가격 <%=CommUtil.decimalFormat(rnEtMst.getAdult_price())%>원 + 유류할증료 <%=CommUtil.decimalFormat(rnEtMst.getEtc_price1())%>원 
						<%if(grade.equals("그룹직원") && empAdultPrice > 0) {%>
						<br> <span class="f_red2 f_bold">임직원 할인가 <%=CommUtil.decimalFormat(empAdultPrice) %>원</span>
						<%}%>
					</dd>
					<dt>
						<span>아동 (만 12세미만)</span>
					</dt>
					<dd>
						총 상품가격<span class="f_purple"> <%=CommUtil.decimalFormat(rnEtMst.getChild_price()+rnEtMst.getEtc_price2()) %></span>원<br> 
						기본상품가격 <%=CommUtil.decimalFormat(rnEtMst.getChild_price())%>원 + 유류할증료 <%=CommUtil.decimalFormat(rnEtMst.getEtc_price2())%>원
						<%if(grade.equals("그룹직원") && empChildPrice > 0) {%>
						<br> <span class="f_red2 f_bold">임직원 할인가 <%=CommUtil.decimalFormat(empChildPrice) %>원</span>
						<%}%>
					</dd>
					<dt>
						<span>유아 (만 2세미만)</span>
					</dt>
					<dd>
						총 상품가격<span class="f_purple"> <%=CommUtil.decimalFormat(rnEtMst.getBaby_price()+rnEtMst.getEtc_price3()) %></span>원<br> 
						기본상품가격 <%=CommUtil.decimalFormat(rnEtMst.getBaby_price())%>원 + 유류할증료 <%=CommUtil.decimalFormat(rnEtMst.getEtc_price3())%>원
						<%if(grade.equals("그룹직원") && empBabyPrice > 0) {%>
						<br> <span class="f_red2 f_bold">임직원 할인가 <%=CommUtil.decimalFormat(empBabyPrice) %>원</span>
						<%}%>
					</dd>
				</dl>
				<ul class="sd_list_box2">
					<% if(rnEtMst.getPoint_yn().equals("Y")) {%>
					<li>L.POINT <%=rnEtMst.getPoint_rate()%>%적립(최대 <%=CommUtil.decimalFormat(rnEtMst.getPoint_amt())%>원)</li>
					<% } else { %>
					<li>L.POINT 미적립</li>
					<% } %>
					<li>유류할증료는 유가와 환율에 따라 변동될 수 있습니다.</li>
				</ul>
			</div>
<%


	String disp_nm = "";

	try {
		disp_nm = URLEncoder.encode(rnEtMst.getDisp_nm(), "UTF-8");

	} catch (Exception e) {}
%>				
			<div class="btn_two sd_btnbox1">
				<div>
					<button class="white2 layerOpener" data-url="/goodsSaveCartPop.do" data-width="300" data-height="200" data-ok="yes" data-role='none'>
						<span>찜하기</span>
					</button>
					<button class="white2 layerOpener" data-url="/goods/pop_mail.do?ctg=<%=ctg%>&eventCd=<%=eventCd%>" data-ok="yes" data-role='none'>
						<span>일정표메일발송</span>
					</button>
				</div>
			</div>

			<div class="btn_one sd_btn_cell">
				<button class="purple2 layerOpener" data-url="/goods/pop_tel.do?ctg=<%=ctg%>&goodsCd=<%=goodsCd%>&eventCd=<%=eventCd%>" data-ok="yes" data-role='none'>
					<span>전화상담 신청</span>
				</button>
			</div>

			<div class="posfixed2">
				<ul class="tablist_com sd_info_tab mt10" data-ctn="sd_info_box">
					<li class="active" ><button type="button" data-role="none" id="info">상세정보</button></li>
					<li class="schd"><button type="button" data-role="none" id="schedule">일정표</button></li>
					<li><button type="button" data-role="none" id="check">체크사항</button></li>
					<li><button type="button" data-role="none" id="important">중요정보<br>일괄표시</button></li>			
				</ul>
			</div>
			<!-- 상세정보 -->
			<%@ include file="/WEB-INF/jsp/goods/inc_shop_detail_infos.jsp"%>
			<!-- 상세정보 -->
			<!-- 일정표 -->
			<%@ include file="/WEB-INF/jsp/goods/inc_shop_detail_schd.jsp"%>
			<!-- 일정표 -->
			<!-- 체크사항 -->
			<%@ include file="/WEB-INF/jsp/goods/inc_shop_detail_checks.jsp"%>
			<!-- 체크사항 -->
			<!-- 중요정보 일괄표시 -->
			<%@ include file="/WEB-INF/jsp/goods/inc_shop_detail_summary.jsp"%>
			<!-- 중요정보 일괄표시 -->
			
			<!-- 상품 카테고리 DEPTH2 레이어 영역 -->
			<%@ include file="/WEB-INF/jsp/goods/inc_layer_goods_ctg.jsp"%>
			<!-- 찜하기 팝업   -->
			<%@ include file="/WEB-INF/jsp/goods/pop_cart.jsp"%>

		</div>
		<dl class="sd_tahaco sd_trv_price mt7">
			<dt class="on">
				<span>예약 및 상담문의</span>
			</dt>
			<dd>
				<p class="f_purple mb10">해외/국내 1577-6511</p>
				<div>
					여행 전문가의 친절한 상담을 받으실 수 있습니다.<br> 상담시간 : 평일 : 08:00 ~ 17:00
				</div>
			</dd>
			<dt>
				<span>유류 할증료</span>
			</dt>
			<dd>
				국토교통부의 ‘국제선 항공요금과 유류할증료 확대방안’ 또는 'IATA의 ROE 인상 발표'에 
				따라 국외 여행 표준약관에 준하여 여행 비용이 예고 없이 인상되거나, 또는 인하된 
				금액으로 반영 될 수 있습니다.
			<dt>
	<%
			// 표준 약관 / 국내약관 / 특별 약관 적용 부분 
			if(rnEtMst.getOpt_desc() == null || rnEtMst.getOpt_desc().equals("") || rnEtMst.getOpt_desc().equals("B")) {
	%>	
				<span>표준약관</span>
	<%
			} else if(rnEtMst.getOpt_desc().equals("S")) {
	%>
				<span>특별약관</span>
	<%
			} else if(rnEtMst.getOpt_desc().equals("D")) {
	%>
				<span>국내약관</span>
	<%		
			}
	%>
			</dt>
			<dd>
	<%
			// 표준 약관 / 국내약관 / 특별 약관 적용 부분 
			if(rnEtMst.getOpt_desc() == null || rnEtMst.getOpt_desc().equals("") || rnEtMst.getOpt_desc().equals("B")) {
	%>	
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
	<%
			} else if(rnEtMst.getOpt_desc().equals("S")) {
	%>
				<%=rnEtMst.getPro_desc()%>
				<%=rnEtMst.getPro_desc2()%>
				
	<%
			} else if(rnEtMst.getOpt_desc().equals("D")) {
	%>
							<h3>표준약관 규정안내</h3>
							<h3>[취소료 규정]</h3>
							<h5 class="info_title">여행 취소시 국내여행표준약관 제 13조 소비자분쟁해결규정에 따라 아래의 비율로 취소료가 부과됩니다.<br />(단, 당사의 귀책사유로 여행출발 취소 경우에도 동일한 규정이 적용됩니다.)</h5>
							
							<ul class="info_list">
								<li>- 여행개시 5일전까지 통보시 : 계약금 환급</li>
								<li>- 여행개시 2일전까지 통보시: 상품가격의 10% 배상</li>
								<li>- 여행개시 1일전까지 통보시: 상품가격의 20% 배상</li>
								<li>- 여행당일 통보시: 상품가격의 30% 배상</li>
							</ul>
	<%		
			}
	%>
			</dd>
		</dl>		
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//content-->
	<!-- 상품 카테고리 DEPTH2 레이어 영역 -->
	<%@ include file="/WEB-INF/jsp/goods/inc_layer_goods_ctg.jsp"%>
<%
/**
<!-- *) 제품상세페이지 분석코드 -->
<!-- AceCounter Mobile eCommerce (Product_Detail) v7.5 Start -->
**/
%>
<script language='javascript'>
var m_pd ="<%=rnEtMst.getDisp_nm()%>";
var m_ct ="<%=ctg%>";
var m_amt="<%=rnEtMst.getAdult_price()+rnEtMst.getEtc_price1()%>";
</script>
<%
/**
1. 장바구니 및 바로구매 Action처리
	 AM_PRODUCT(수량);
	예) onMouseDown="AM_PRODUCT(document.shop.cnt.value);"  
	-> 마우스 버튼 다운이 있을때 상품 cnt 갯수만큼 담게 됩니다.
**/
%>
<!-- AceCounter Mobile WebSite Gathering Script V.7.5.20170208 -->
<script language='javascript'>
	var _AceGID=(function(){var Inf=['lottejtb.com','m.lottejtb.com','AZ3A69303','AM','0','NaPm,Ncisy','ALL','0']; var _CI=(!_AceGID)?[]:_AceGID.val;var _N=0;if(_CI.join('.').indexOf(Inf[3])<0){ _CI.push(Inf);  _N=_CI.length; } return {o: _N,val:_CI}; })();
	var _AceCounter=(function(){var G=_AceGID;var _sc=document.createElement('script');var _sm=document.getElementsByTagName('script')[0];if(G.o!=0){var _A=G.val[G.o-1];var _G=(_A[0]).substr(0,_A[0].indexOf('.'));var _C=(_A[7]!='0')?(_A[2]):_A[3];var _U=(_A[5]).replace(/\,/g,'_');_sc.src=(location.protocol.indexOf('http')==0?location.protocol:'http:')+'//cr.acecounter.com/Mobile/AceCounter_'+_C+'.js?gc='+_A[2]+'&py='+_A[1]+'&up='+_U+'&rd='+(new Date().getTime());_sm.parentNode.insertBefore(_sc,_sm);return _sc.src;}})();
</script>
<noscript><img src='http://gmb.acecounter.com/mwg/?mid=AZ3A69303&tp=noscript&ce=0&' border='0' width='0' height='0' alt=''></noscript>
<!-- AceCounter Mobile Gathering Script End -->

<!-- criteo script -->
<script type="text/javascript" src="//static.criteo.net/js/ld/ld.js" async="true"></script>
<script type="text/javascript">
<!--
function addZeros(num, digit) { 
	  var zero = '';
	  num = num.toString();
	  if(num.length < digit){
	    for(i = 0; i < digit - num.length; i++){
	      zero += '0';
	    }
	  }

	  return zero + num;
};

var sY = <%=rnEtMst.getStart_day().substring(0, 4)%>;
var sM = <%=rnEtMst.getStart_day().substring(4, 6)%>;
sM = addZeros(sM, 2);
var sD = <%=rnEtMst.getStart_day().substring(6, 8)%>;
sD = addZeros(sD, 2);

var eY = <%=rnEtMst.getEnd_day().substring(0, 4)%>;
var eM = <%=rnEtMst.getEnd_day().substring(4, 6)%>;
eM = addZeros(eM, 2);
var eD = <%=rnEtMst.getEnd_day().substring(6, 8)%>;
eD = addZeros(eD, 2);

var startDay = sY + "-" + sM + "-" + sD;
var endDay = eY + "-" + eM + "-" + eD;

window.criteo_q = window.criteo_q || [];
window.criteo_q.push(
		{ event: "setAccount", account: 7995 },
		{ event: "setCustomerId", id: "${cust_cd}" },
		{ event: "setSiteType", type: "m" },
		{ event: "viewItem", item: "${eventCd}"},
		{ event: "viewSearch", checkin_date:startDay, checkout_date:endDay}
);

//-->
</script>