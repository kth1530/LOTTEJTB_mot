<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.text.*"%> 
<%
	// 회원 등급 임직원 여부 가져옴 (그룹직원)
// 	String grade = (String) request.getAttribute("grade");
	String grade = "";
	if(request.getAttribute("grade") != null){
		grade = (String) request.getAttribute("grade");
	}
//	grade = "그룹직원";
// 	if(null != (String) request.getAttribute("grade")){
// 		grade = (String) request.getAttribute("grade");
// 	}
	// 서버 날짜 받아오기 
	Date systemDate = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
	String startDay = sdf.format(systemDate);
	
	// 서버 날짜 + 10
 	// Calendar cal = new GregorianCalendar(Locale.KOREA);
    // cal.setTime(new Date());
    // cal.add(Calendar.DAY_OF_YEAR, 10); // 하루를 더한다. 
	// SimpleDateFormat fm = new SimpleDateFormat("yyyyMMdd");
    // String startDay = fm.format(cal.getTime());
%>	
<head>
	
	<!-- 달력 소스  -->
	<script src="/resources/common/js/calendar.js"></script>
	<!-- 스와이프 -->
	<script src="/resources/common/js/swiper.js"></script>
	<script type="text/javascript">	
	<!--
        // require(["jquery","jquery.blockUI","jquery.mobile"], function($){
        // require(["jquery","jquery.blockUI"], function($){
		
		// 상품 카테고리 검색 시 사용 
		var ctg = '${ctg}';		
		// 행사 상품 정보 검색 시 사용 
		var goodsCd = '${goodsCd}';
		var eventCd = "";
		var flag = false;
		var listSize = '${listSize}';	
		var totalSize = 0;
		var curRow = 0;
		var pageSize = "${pageSize}";	
		var list = null;
		var goodsDTO = null; // 상품 마스터 정보 
		var flag = false;
		var type = "new";
		var flagReserve = "";
		var tag_air_remark = "";
		var titleHtml	=	"";
		var price	=	"${price}";

		var cust_cd = "${cust_cd}";
		var grade = "<%=grade%>";
		
		// 초기화
		var fn_init = function() {
			// 상품 카테고리 정보 
			fn_goodsCtg2();
			fn_SiteGoodsInfo(); // 상품 정보 
//			fn_SiteGoodsEvntScheduleAjax(); // 행사 달력 표시 
			change_view("01");
			// console.log("start_day >>>>>>>>>> " + '<%=startDay%>');

		};
		
		var fn_search = function(){
			
		};
		
				
		// 버튼 초기화
		var fn_initButton = function() {

		};

		// 상품 리스트 화면으로 이동 
		function fn_goList() {
			console.log(">>>>>>>>>>>>>>>>>> go list >>>>>>>>>>>>>>>>>>>>>>>>>>");

			document.location.href = "/goods/list.do?ctg=" + ctg+ "&orderby=01";
		}


		// 상품 상세 화면으로 이동 
		function goGoodsDetail(eventCd) {
			//[JEH] https 안나오는 현상으로 임시로 http 고정함 - 20190625		
			document.location.href="http://m.lottejtb.com/goods/detail_goods.do?ctg="+ctg+"&eventCd=" + eventCd;
// 			document.location.href="/goods/detail_goods.do?ctg="+ctg+"&eventCd=" + eventCd;

		}		
		
		/* *************************************************************************** */	
		// Swipper 초기화 
		var fn_InitSwipper = function() {

			var weekDay = new Swiper('.weekDay', {
				spaceBetween: 0,
				slidesPerView:8,
				touchRatio: 0.4,			
				paginationClickable: true,
				slideToClickedSlide: true,
				loop:false
			});

		}

		// [Ajax] 데이터 통신 부분 
		// 상품 마스터 정보 조회  
		var fn_SiteGoodsInfo = function () {
			// var ctg = document.frmGoodsCtg2.ctg2.value;
			//alert(ctg);
			
			var formData = new FormData();
			formData.append('ctg', ctg);
			formData.append('goodsCd', goodsCd);
			
//			console.log('start fn_SiteGoodsInfo')
			cfn_ajax({
				type: "POST",
				async: false,
				url: "<c:url value='/goods/srchSiteGoodsInfoAjax.do' />",
				data: formData,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
//					console.log('success fn_SiteGoodsInfo')
					goodsDTO = res["master"];
					console.log(goodsDTO)
					if(goodsDTO != null) {
						// 이미지 형태 상품 리스트 
						var html = "";

//						<!-- 상품타이틀 -->
						html = html + "				<div class='sd_titlebox'>	";
						html = html + "					<div class='posfixed1'>	";
						html = html + "						<p><span class='ellipsis ellipsis2'>"+goodsDTO["goods_nm"]+"</span></p>	";
						html = html + "					</div>	";
						html = html + "				</div>	";
//						<!-- 정보 -->
						html = html + "				<dl class='sd_streetday'>	";
						html = html + "					<dt>상품금액</dt>	";
						//[JEH] 임직원 할인 추가 - 20190604
						if(grade == "그룹직원" && parseInt(goodsDTO["emp_rate"]) > 0){	
							html = html + "					<dd style='letter-spacing: -0.5px;'><em class='f_purple'>" + comma(goodsDTO["str_et_price1"]) + "</em>원 ~ <em class='f_purple'>" + comma(goodsDTO["str_et_price2"]) + "</em>원";
							html = html + "						<span class='discount'>임직원 " + goodsDTO["emp_rate"] + "% 할인</span>	";
						}else{
							html = html + "					<dd><em class='f_purple'>" + comma(goodsDTO["str_et_price1"]) + "</em>원 ~ <em class='f_purple'>" + comma(goodsDTO["str_et_price2"]) + "</em>원";
						}
						html = html + "					</dd>	";
						html = html + "					<dt>상품코드</dt><dd>" + goodsDTO["goods_cd"] + "</dd>	";
						html = html + "					<dt>여행기간</dt><dd>" + goodsDTO["bus_time"] + "일</dd>	";			
						html = html + "					<dt>출발요일</dt><dd>" + goodsDTO["et_days"].replace(/\|/g, ',') + "</dd>";
						if(goodsDTO["air_remark"] != '') {
							html = html + "					<dt><span id='div_air_remark_title' name='div_air_remark_title'>이용항공</span></dt><dd><span id='div_air_remark' name='div_air_remark'>" + goodsDTO["air_remark"] + "</span></dd>";	
						}
						html = html + "				</dl>	";
						if(goodsDTO["short_goods_nm"] == null) {
						// 	html = html + "				<dl class='sd_streetday sd_last'><dt>상품특전</dt><dd></dd></dl>	";
						} else {
							html = html + "				<dl class='sd_streetday sd_last'><dt>상품특전</dt><dd>"+ goodsDTO["short_goods_nm"] + "</dd></dl>	";
						
						}
						
						//[JEH] 일정표 영상으로 보기 추가 - 20190521
						if(goodsDTO["goods_cd"] == 'JBW3001'){
							html = html + "<div><a href='javascript:go_youtube();'><img src='/resources/images/btn/bn_master_MTV.jpg' /></a></div>";
						}
						
						// 상품 마스터 정보 표시 
//						$("#gdDetail").html(html);
						$("#calendarEvnt").html(html);
						titleHtml	=	html;
//						console.log("calendarEvnt:" + $("#calendarEvnt").html())
						fn_SiteGoodsEvntScheduleAjax();
						
						// console.log(html);
					}

				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
					$(".list").trigger('create');
					
				}
			});
		};		

		// 행사 상품 스케쥴 조회 
		var fn_SiteGoodsEvntScheduleAjax = function () {
			// var ctg = document.frmGoodsCtg2.ctg2.value;
			//alert(ctg);
			var formData = new FormData();
			formData.append('ctg', ctg);
			formData.append('goodsCd', goodsCd);

			cfn_ajax({
				type: "POST",
				async: false,
				url: "<c:url value='/goods/srchSiteGoodsEvntScheduleAjax.do' />",
				data: formData,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					var eventDTO = res["eventDTO"];
					
					// 이벤트 행사 스케쥴 조회  
					if(eventDTO != null) {
						var event_desc = eventDTO["event_desc"];
						var et_days = "|";
						
						if(goodsDTO != null && goodsDTO["et_days"] != null) {
							et_days = goodsDTO["et_days"];
						}

						if(event_desc.indexOf('|') != 0) {
							event_desc = event_desc + "|";
						}

						console.log("et_days : " + et_days);
						console.log("event_desc : " + event_desc);


						var serverDate = '<%=startDay%>';					
						console.log("serverDate : " + serverDate);
						console.log(event_desc);
						
						// 행사 스케쥴 표시 달력 
						goodsEventCalendar(serverDate, event_desc, et_days);
					}
					

				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
					$(".calendarEvnt > calendar").trigger('create');
					// 스와이프 초기화 
					fn_InitSwipper();
				}
			});
		};	

		// 행사 상품 리스트 조회 (이벤트 날짜, 행사 일자 검색)
		function fn_SiteGoodsEvntList(eventCd, startDay) {
			list = null;

			eventCd = eventCd;
			startDay = startDay;

			console.log("eventCd : " + eventCd);
			console.log("startDay : " + startDay);
			console.log("flagReserve : " + flagReserve);
			
			// 페이지 계산
			if(type == "new"){
				// $(".goodsList").empty();
				
				startRow = 1;
				endRow = pageSize;	
								
			}else{
			
			
				startRow = curRow + 1;
				endRow = curRow + Number(pageSize);
			
			}
			
			if(type != "new"){
				if(startRow > totalSize) {
					// alert("더이상 등록된 상품이 없습니다");
					return;
				}
			}


			var formData = new FormData();
			formData.append('ctg', ctg);
			formData.append('goodsCd', goodsCd);
			formData.append("eventCd", eventCd);
			formData.append("startDay", startDay);
			formData.append("flagReserve", flagReserve);
			formData.append("startRow", startRow);
			formData.append("endRow", endRow);
			formData.append('price', price);
			
			cfn_ajax({
				type: "POST",
				async: false,
				url: "<c:url value='/goods/srchSiteGoodsEvntListAjax.do' />",
				data: formData,
				dataType: "json",
				cache: false,
				noloading: false,
				timeOut: (5*60*1000),
				success: function(res) {
					list = res.list;
					curRow = res.list.length;
					opCd = res.opCd;
					// 기존 조회 조건 검색 후 저장해 둠 
					document.all.frmGoods.ctg.value = res.ctg;
					document.all.frmGoods.goodsCd.value = res.goodsCd;
					document.all.frmGoods.startDay.value = res.startDay;
					
					if(list != null) {
						var html = "";
						var html2 = "";

						for(var i=0; i < list.length; i++) {
										
							/**
							 * [AS_IS] 예약 마감 및 출발 가능/예약 가능 로직을 위한 파라미터 정보 
							**/									
							var rvCnt = list[i]["rv_cnt"];
							var evInwon = list[i]["ev_inwon"];
							var lockUnit = list[i]["lock_unit"];
							var procCd = list[i]["proc_cd"];
					      	var rvStatus = "O";
							
							if(flagReserve ==  '') {

								var nowDate = new Date('<%=startDay%>'.substring(0,4), '<%=startDay%>'.substring(4,6), '<%=startDay%>'.substring(6, 8));

								// 해외 일 경우 4일 체크 
								var otGoodsDate = new Date(list[i]["start_day"].substring(0, 4), parseInt(list[i]["start_day"].substring(4, 6)), parseInt(list[i]["start_day"].substring(6, 8)));
								otGoodsDate.setDate(otGoodsDate.getDate() - 4);
								// 국내 일 경우 2일 체크 
								var doGoodsDate = new Date(list[i]["start_day"].substring(0, 4), parseInt(list[i]["start_day"].substring(4, 6)), parseInt(list[i]["start_day"].substring(6, 8)));
								doGoodsDate.setDate(doGoodsDate.getDate() - 2);

								if(opCd == 'OT' && nowDate.getTime() > otGoodsDate.getTime()) {
									rvStatus = "X";
								} else if(opCd != 'OT' && nowDate.getTime() > doGoodsDate.getTime()) {
									rvStatus = "X";
								} else if (rvCnt >= evInwon) {
									rvStatus = "X";
								} else {
									if (evInwon == 0) {
										rvStatus = "X";
									} else {
										if (procCd == "RE") {
											rvStatus = "X";
										} else {
											if (lockUnit == "Y") {
												rvStatus = "X";
											} else {							
												if (procCd == "SE") {
													rvStatus = "O";

												} else {
													rvStatus = "O";

												}
											}
										}
									}
								}
								console.log("전체 가능 상품 리스트 >>>>>>>>>>>>>>>>> flagReserve >>>>>>>>>>>>>>>> " + flagReserve);

							    //[JEH] 롯데면세점 프로모션일경우 결제페이지로 바로 이동 - 20190510
								if(res.goodsCd == 'PGI1011'){
									if(rvStatus == "O"){
										html = html + '					<li onClick="fn_goReserve(\'' + ctg + '\', \'' + res.goodsCd + '\', \'' + list[i]["event_cd"] + '\')"> ';
									}else{
										html = html + '					<li> ';
									}
								
								}else{
									html = html + '					<li onClick="goGoodsDetail(\'' + list[i]["event_cd"] + '\')"> ';
								}
//								html = html + "						<a href=\"javascript:goGoodsDetail('" + list[i]["event_cd"] + "')\" class='ui-link' data-role='none'>";
								html = html + "							<p class='sm_sub_textbox1'> ";
								if(list[i]["start_day"] != null) {
									html = html + "							<span class='startday'>출발일 "+list[i]["start_day"].substring(4, 6)+"."+list[i]["start_day"].substring(6, 8);
								}
								if(list[i]["start_wday"] != null) {	
									html = html  +"("+list[i]["start_wday"]+") ";
								}
								if(list[i]["start_time"] != null) { 	
									html = html + list[i]["start_time"].substring(0, 2)+":"+list[i]["start_time"].substring(2, 4);
								}
								html = html + "</span>";
								if(list[i]["end_day"] != null) {
									html = html + "							<span class='endday'>도착일 "+list[i]["end_day"].substring(4, 6)+"."+list[i]["end_day"].substring(6, 8);
								}	
								if(list[i]["end_wday"] != null) {
									html = html +"("+list[i]["end_wday"]+") ";
								}
								if(list[i]["end_time"] != null) {
									html = html + list[i]["end_time"].substring(0, 2)+":"+list[i]["end_time"].substring(2, 4);				
								}
								html = html + "</span>";
								html = html + "								<em class='conday'>"+list[i]["ev_night_cnt"]+"박 "+list[i]["ev_day_cnt"]+"일</em>";				
								html = html + "							</p> ";

								/**
								 * [AS_IS] 예약 마감 및 출발 가능/예약 가능 로직입니다. 
								 * OP_CD : OT 해외 일 경우 <출발일 기준 : 2일전>
								 * 출발일 국내 2일, 해외 4일 체크 
									출발가능 cld_purple
									예약가능 cld_blue
									예약마감 cld_black
									긴급모색 cld_red
								**/		
								var nowDate = new Date('<%=startDay%>'.substring(0,4), '<%=startDay%>'.substring(4,6), '<%=startDay%>'.substring(6, 8));

								// 해외 일 경우 4일 체크 
								var otGoodsDate = new Date(list[i]["start_day"].substring(0, 4), parseInt(list[i]["start_day"].substring(4, 6)), parseInt(list[i]["start_day"].substring(6, 8)));
								otGoodsDate.setDate(otGoodsDate.getDate() - 4);
								// 국내 일 경우 2일 체크 
								var doGoodsDate = new Date(list[i]["start_day"].substring(0, 4), parseInt(list[i]["start_day"].substring(4, 6)), parseInt(list[i]["start_day"].substring(6, 8)));
								doGoodsDate.setDate(doGoodsDate.getDate() - 2);

								console.log(" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");
								console.log(" >> opCd :  " + opCd);
								console.log(" >> nowDate.getTime() :  " + nowDate.getTime());
								console.log(" >> otGoodsDate.getTime() :  " + otGoodsDate.getTime());
								console.log(" >> doGoodsDate.getTime() :  " + doGoodsDate.getTime());
								console.log(" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");

								if(opCd == 'OT' && nowDate.getTime() > otGoodsDate.getTime()) {
									html = html + "								<p class='sm_sub_textbox2 cld_black'>예약마감</p><input type='hidden' name='status' value='예약마감'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
									rvStatus = "X";
								} else if(opCd != 'OT' && nowDate.getTime() > doGoodsDate.getTime()) {
									html = html + "								<p class='sm_sub_textbox2 cld_black'>예약마감</p><input type='hidden' name='status' value='예약마감'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
									rvStatus = "X";
								} else if (rvCnt >= evInwon) {
									html = html + "								<p class='sm_sub_textbox2 cld_black'>예약마감</p><input type='hidden' name='status' value='예약마감'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
									rvStatus = "X";
								} else {
									if (evInwon == 0) {
										html = html + "								<p class='sm_sub_textbox2 cld_black'>예약마감</p><input type='hidden' name='status' value='예약마감'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
										rvStatus = "X";
									} else {
										if (procCd == "RE") {
											html = html + "								<p class='sm_sub_textbox2 cld_black'>예약마감</p><input type='hidden' name='status' value='예약마감'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
											rvStatus = "X";
										} else {
											if (lockUnit == "Y") {
												html = html + "								<p class='sm_sub_textbox2 cld_black'>예약마감</p><input type='hidden' name='status' value='예약마감'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
												rvStatus = "X";
											} else {							
												if (procCd == "SE") {
													html = html + "					<p class='sm_sub_textbox2 cld_purple'>출발가능</p><input type='hidden' name='status' value='출발가능'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
													rvStatus = "O";
													// ---------------------------------------------------------------------------------
													// 출발 가능 일자 달력에 표시하는 부분 
													// ---------------------------------------------------------------------------------
													var tagCanStartDay = "";
													if(list[i]["start_day"] != null) {
														tagCanStartDay = "#div_" + list[i]["start_day"].substring(0, 8);
													}
													console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>> tagCanStartDay : " + tagCanStartDay);
													
													$(tagCanStartDay).removeClass("cld_blue");
													$(tagCanStartDay).removeClass("cld_black");
													$(tagCanStartDay).removeClass("cld_red");
													$(tagCanStartDay).addClass("cld_purple");
													
												} else if (procCd == "09") {
													html = html + "					<p class='sm_sub_textbox2 cld_red'>긴급모객</p><input type='hidden' name='status' value='긴급모객'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
													// ---------------------------------------------------------------------------------
													// 출발 가능 일자 달력에 표시하는 부분 
													// ---------------------------------------------------------------------------------
													var tagCanStartDay = "";
													if(list[i]["start_day"] != null) {
														tagCanStartDay = "#div_" + list[i]["start_day"].substring(0, 8);
													}
													console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>> tagCanStartDay : " + tagCanStartDay);
													
													$(tagCanStartDay).removeClass("cld_blue");
													$(tagCanStartDay).removeClass("cld_black");
													$(tagCanStartDay).removeClass("cld_purple");
													$(tagCanStartDay).addClass("cld_red");

												} else {
													html = html + "					<p class='sm_sub_textbox2 cld_blue'>예약가능</p><input type='hidden' name='status' value='예약가능'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
													rvStatus = "O";

													// ---------------------------------------------------------------------------------
													// 예약 가능 일자 달력에 표시하는 부분 
													// ---------------------------------------------------------------------------------
													var tagCanReserveDay = "";
													if(list[i]["start_day"] != null) {
														tagCanReserveDay = "#div_" + list[i]["start_day"].substring(0, 8);
													}
													console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>> tagCanReserveDay : " + tagCanReserveDay);

													$(tagCanReserveDay).removeClass("cld_red");
													$(tagCanReserveDay).removeClass("cld_black");
													$(tagCanReserveDay).removeClass("cld_purple");
													$(tagCanReserveDay).addClass("cld_blue");

												}
											}
										}
									}
								}

								html = html + "							<p class='sm_sub_title'> ";
								html = html + list[i]["disp_nm"];
								html = html + "							</p> ";
								html = html + "							<div class='sm_sub_text1'>";
								html = html + "							<p class='sm_sub_airbox'> ";
								
								var tag_air_remark = "";
								var air_remark = "";
								// 교통수단별 이미지 표시 
								if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'AIR') {
									html = html + "		<img src='/resources/images/air/" + list[i]["trff_cd_short"] + ".png' class='img mgL5'> " + list[i]["cd_nm"];
									air_remark = "<img src='/resources/images/air/" + list[i]["trff_cd_short"] + ".png' class='img'> " + list[i]["cd_nm"];
									tag_air_remark = fn_air_remark(i, list[i]["cd_nm"], air_remark);
									$("#div_air_remark_title").html("이용항공");
								} else if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'CAR') {
									html = html + "		<img src='/resources/images/ico/CAR.png' class='img mgL5'> " + list[i]["start_pyun"];
									air_remark = "<img src='/resources/images/ico/CAR.png' class='img'> " + list[i]["start_pyun"];
									tag_air_remark = fn_air_remark(i, list[i]["start_pyun"], air_remark);
									$("#div_air_remark_title").html("이용교통");
								} else if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'BUS') {
									html = html + "		<img src='/resources/images/ico/BUS.png' class='img mgL5'> " + list[i]["start_pyun"];
									air_remark = "<img src='/resources/images/ico/BUS.png' class='img'> " + list[i]["start_pyun"];
									tag_air_remark = fn_air_remark(i, list[i]["start_pyun"], air_remark);
									$("#div_air_remark_title").html("이용교통");
								} else if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'SHP') {
									html = html + "		<img src='/resources/images/ico/SHP.png' class='img mgL5'> " + list[i]["start_pyun"];
									air_remark = "<img src='/resources/images/ico/SHP.png' class='img'> " + list[i]["start_pyun"];
									tag_air_remark = fn_air_remark(i, list[i]["start_pyun"], air_remark);
									$("#div_air_remark_title").html("이용교통");
								} else if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'TRA') {
									html = html + "		<img src='/resources/images/ico/TRA.png' class='img mgL5'> " + list[i]["start_pyun"];
									air_remark = "<img src='/resources/images/ico/TRA.png' class='img'> " + list[i]["start_pyun"];
									tag_air_remark = fn_air_remark(i, list[i]["start_pyun"],  air_remark);
									$("#div_air_remark_title").html("이용교통");
								} 
								$("#div_air_remark").html(tag_air_remark);

								html = html + "							</p> ";
								// 임직원 일때만 표시함
// 								if(grade == "그룹직원" && parseInt(list[i]["emp_rate"]) > 0){	
// 										html = html + "							<p class='sm_sub_pirce_im'><em>(임직원 "+list[i]["emp_rate"]+"% 할인)</em></p>";
// 								}
								html = html + "							</div>";
								html = html + "							<div class='sm_sub_text1'> ";
								html = html + "								남은 좌석 : <em>"+( parseInt(list[i]["ev_inwon"]) - parseInt(list[i]["rv_cnt"]) )+"석</em>, 최소출발 : <em>"+list[i]["min_inwon"]+"명</em> ";

								/*** 임직원 할인가 표시 ***/
								if(grade == "그룹직원" && parseInt(list[i]["emp_rate"]) > 0){	
									//[JEH] 임직원 할인가 계산 - 20190603
									var str_adult_price = list[i]["adult_price"];
									var emp_rate = parseInt(list[i]["emp_rate"]);
									var emp_amt = (parseInt(str_adult_price) * ((100 - emp_rate) * 0.01)) + parseInt(list[i]["etc_price1"]);
									
									html = html + "								<p class='sm_sub_pirce line-through' style='top: -20px;font-size: 12px;'><em style='font-size: 13px;'>"+ list[i]["str_tot_amt1"]+"</em>원</p> ";
									html = html + "								<p class='sm_sub_pirce' style='color:#cd1d1f;top:-5px;'><em style='color:#cd1d1f;'>"+ addComma(Math.round(emp_amt))+"</em>원</p> ";
								}else{
									html = html + "								<p class='sm_sub_pirce'><em>"+ list[i]["str_tot_amt1"]+"</em>원</p> ";
								}
								
								html = html + "							</div> ";
//								html = html + "						</a>";
								html = html + "					</li> ";
								
							} else { // 예약 가능 상품 인 경우만 
								console.log(" 예약 가능 상품 리스트 >>>>>>>>>>>>>>>>>  flagReserve >>>>>>>>>>>>>>>> " + flagReserve);

								/**
								 * [AS_IS] 예약 마감 및 출발 가능/예약 가능 로직입니다. 
								**/	
								var nowDate = new Date('<%=startDay%>'.substring(0,4), '<%=startDay%>'.substring(4,6), '<%=startDay%>'.substring(6, 8));

								// 해외 일 경우 4일 체크 
								var otGoodsDate = new Date(list[i]["start_day"].substring(0, 4), parseInt(list[i]["start_day"].substring(4, 6)), parseInt(list[i]["start_day"].substring(6, 8)));
								otGoodsDate.setDate(otGoodsDate.getDate() - 4);
								// 국내 일 경우 2일 체크 
								var doGoodsDate = new Date(list[i]["start_day"].substring(0, 4), parseInt(list[i]["start_day"].substring(4, 6)), parseInt(list[i]["start_day"].substring(6, 8)));
								doGoodsDate.setDate(doGoodsDate.getDate() - 2);
																
								if(opCd == 'OT' && nowDate.getTime() > otGoodsDate.getTime()) {
									console.log(" 예약 가능 상품 리스트 OT >");
									rvStatus = "X";
									// html = html + "								<p class='appguide append'>예약마감</p>";
								} else if(opCd != 'OT' && nowDate.getTime() > doGoodsDate.getTime()) {
									console.log(" 예약 가능 상품 리스트! OT >");
									rvStatus = "X";
									// html = html + "								<p class='appguide append'>예약마감</p>";	
								} else if (rvCnt >= evInwon) {
									console.log(" 예약 가능 상품 리스트  >");
									rvStatus = "X";
									// html = html + "								<span>예약마감</span>";
								} else {
									if (evInwon == 0) {
										console.log(" 예약 가능 상품 리스트 == 0");
										rvStatus = "X";
										// html = html + "								<span>예약마감</span>";
									} else {
										if (procCd == "RE") {
											console.log(" 예약 가능 상품 리스트 re ");
											rvStatus = "X";
											// html = html + "								<span>예약마감</span>";
										} else {
											if (lockUnit == "Y") {
												// html = html + "								<span>예약마감</span>";
												console.log(" 예약 가능 상품 리스트Y");
												rvStatus = "X";
											} else {							
												if (procCd == "SE") {
													console.log(" 예약 가능 상품 리스트 SE");
													rvStatus = "O";
													tag = "					<p class='sm_sub_textbox2 cld_purple'>출발가능</p><input type='hidden' name='status' value='출발가능'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
													// ---------------------------------------------------------------------------------
													// 출발 가능 일자 달력에 표시하는 부분 
													// ---------------------------------------------------------------------------------
													var tagCanStartDay = "";
													if(list[i]["start_day"] != null) {
														tagCanStartDay = "#div_" + list[i]["start_day"].substring(0, 8);
													}
													console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>> tagCanStartDay : " + tagCanStartDay);
													
													$(tagCanStartDay).removeClass("cld_blue");
													$(tagCanStartDay).removeClass("cld_black");
													$(tagCanStartDay).removeClass("cld_red");
													$(tagCanStartDay).addClass("cld_purple");

												} else if (procCd == "09") {
													console.log(" 예약 가능 상품 리스트 09");
													tag = "					<p class='sm_sub_textbox2 cld_red'>긴급모객</p><input type='hidden' name='status' value='긴급모객'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
													// ---------------------------------------------------------------------------------
													// 긴급모객 가능 일자 달력에 표시하는 부분 
													// ---------------------------------------------------------------------------------
													var tagCanStartDay = "";
													if(list[i]["start_day"] != null) {
														tagCanStartDay = "#div_" + list[i]["start_day"].substring(0, 8);
													}
													console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>> tagCanStartDay : " + tagCanStartDay);
													
													$(tagCanStartDay).removeClass("cld_blue");
													$(tagCanStartDay).removeClass("cld_black");
													$(tagCanStartDay).removeClass("cld_purple");
													$(tagCanStartDay).addClass("cld_red");

												} else {
													rvStatus = "O";
												
													console.log(" 예약 가능 상품 리스트 else");

													tag = "					<p class='sm_sub_textbox2 cld_blue'>예약가능</p><input type='hidden' name='status' value='예약가능'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
													// ---------------------------------------------------------------------------------
													// 예약 가능 일자 달력에 표시하는 부분 
													// ---------------------------------------------------------------------------------
													var tagCanReserveDay = "";
													if(list[i]["start_day"] != null) {
														tagCanReserveDay = "#div_" + list[i]["start_day"].substring(0, 8);
													}
													console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>> tagCanReserveDay : " + tagCanReserveDay);
													
													$(tagCanReserveDay).removeClass("cld_purple");
													$(tagCanReserveDay).removeClass("cld_black");
													$(tagCanReserveDay).removeClass("cld_red");
													$(tagCanReserveDay).addClass("cld_blue");

												}

											    //[JEH] 롯데면세점 프로모션일경우 결제페이지로 바로 이동 - 20190510
												if(res.goodsCd == 'PGI1011'){
													if(rvStatus == "O"){
														html = html + '					<li onClick="fn_goReserve(\'' + ctg + '\', \'' + res.goodsCd + '\', \'' + list[i]["event_cd"] + '\')"> ';
													}else{
														html = html + '					<li> ';
													}
												
												}else{
													html = html + '					<li onClick="goGoodsDetail(\'' + list[i]["event_cd"] + '\')"> ';
												}
											    
//												html = html + "						<a href=\"javascript:goGoodsDetail('" + list[i]["event_cd"] + "')\" class='ui-link' data-role='none'>";
												html = html + "							<p class='sm_sub_textbox1'> ";
												if(list[i]["start_day"] != null) {
													html = html + "							<span class='startday'>출발일 "+list[i]["start_day"].substring(4, 6)+"."+list[i]["start_day"].substring(6, 8);
												}
												if(list[i]["start_wday"] != null) {	
													html = html  +"("+list[i]["start_wday"]+") ";
												}
												if(list[i]["start_time"] != null) { 	
													html = html + list[i]["start_time"].substring(0, 2)+":"+list[i]["start_time"].substring(2, 4);
												}
												html = html + "</span>";
												if(list[i]["end_day"] != null) {
													html = html + "							<span class='endday'>도착일 "+list[i]["end_day"].substring(4, 6)+"."+list[i]["end_day"].substring(6, 8);
												}	
												if(list[i]["end_wday"] != null) {
													html = html +"("+list[i]["end_wday"]+") ";
												}
												if(list[i]["end_time"] != null) {
													html = html + list[i]["end_time"].substring(0, 2)+":"+list[i]["end_time"].substring(2, 4);				
												}
												html = html + "</span>";
												html = html + "								<em class='conday'>"+list[i]["ev_night_cnt"]+"박 "+list[i]["ev_day_cnt"]+"일</em>";				
												html = html + "							</p> ";

												/**
												 * [AS_IS] 예약 마감 및 출발 가능/예약 가능 로직입니다. 
												 * OP_CD : OT 해외 일 경우 <출발일 기준 : 2일전>
												 * 출발일 국내 2일, 해외 4일 체크 
												**/		
												html = html + tag;
												html = html + "							<p class='sm_sub_title'> ";
												html = html + list[i]["disp_nm"];
												html = html + "							</p> ";
												html = html + "							<div class='sm_sub_text1'>";
												html = html + "							<p class='sm_sub_airbox'> ";
												
												var tag_air_remark = "";
												var air_remark = "";
												// 교통수단별 이미지 표시 
												if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'AIR') {
													html = html + "		<img src='/resources/images/air/" + list[i]["trff_cd_short"] + ".png' class='img mgL5'> " + list[i]["cd_nm"];
													air_remark = "<img src='/resources/images/air/" + list[i]["trff_cd_short"] + ".png' class='img'> " + list[i]["cd_nm"];
													tag_air_remark = fn_air_remark(i, list[i]["cd_nm"], air_remark);
													$("#div_air_remark_title").html("이용항공");
												} else if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'CAR') {
													html = html + "		<img src='/resources/images/ico/CAR.png' class='img mgL5'> " + list[i]["start_pyun"];
													air_remark = "<img src='/resources/images/ico/CAR.png' class='img'> " + list[i]["start_pyun"];
													tag_air_remark = fn_air_remark(i, list[i]["start_pyun"], air_remark);
													$("#div_air_remark_title").html("이용교통");
												} else if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'BUS') {
													html = html + "		<img src='/resources/images/ico/BUS.png' class='img mgL5'> " + list[i]["start_pyun"];
													air_remark = "<img src='/resources/images/ico/BUS.png' class='img'> " + list[i]["start_pyun"];
													tag_air_remark = fn_air_remark(i, list[i]["start_pyun"], air_remark);
													$("#div_air_remark_title").html("이용교통");
												} else if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'SHP') {
													html = html + "		<img src='/resources/images/ico/SHP.png' class='img mgL5'> " + list[i]["start_pyun"];
													air_remark = "<img src='/resources/images/ico/SHP.png' class='img'> " + list[i]["start_pyun"];
													tag_air_remark = fn_air_remark(i, list[i]["start_pyun"], air_remark);
													$("#div_air_remark_title").html("이용교통");
												} else if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'TRA') {
													html = html + "		<img src='/resources/images/ico/TRA.png' class='img mgL5'> " + list[i]["start_pyun"];
													air_remark = "<img src='/resources/images/ico/TRA.png' class='img'> " + list[i]["start_pyun"];
													tag_air_remark = fn_air_remark(i, list[i]["start_pyun"],  air_remark);
													$("#div_air_remark_title").html("이용교통");
												} 
												
												$("#div_air_remark").html(tag_air_remark);

												html = html + "							</p> ";
								
												html = html + "							</div>";

												html = html + "							<div class='sm_sub_text1'> ";
												html = html + "								남은 좌석 : <em>"+( parseInt(list[i]["ev_inwon"]) - parseInt(list[i]["rv_cnt"]) )+"석</em>, 최소출발 : <em>"+list[i]["min_inwon"]+"명</em> ";

												/*** 임직원 할인가 표시 ***/
												if(grade == "그룹직원" && parseInt(list[i]["emp_rate"]) > 0){	
													//[JEH] 임직원 할인가 계산 - 20190603
													var str_adult_price = list[i]["adult_price"];
													var emp_rate = parseInt(list[i]["emp_rate"]);
													var emp_amt = (parseInt(str_adult_price) * ((100 - emp_rate) * 0.01)) + parseInt(list[i]["etc_price1"]);
													
													html = html + "								<p class='sm_sub_pirce line-through' style='top: -20px;font-size: 12px;'><em style='font-size: 13px;'>"+ list[i]["str_tot_amt1"]+"</em>원</p> ";
													html = html + "								<p class='sm_sub_pirce' style='color:#cd1d1f;top:-5px;'><em style='color:#cd1d1f;'>"+ addComma(Math.round(emp_amt))+"</em>원</p> ";
												}else{
													html = html + "								<p class='sm_sub_pirce'><em>"+ list[i]["str_tot_amt1"]+"</em>원</p> ";
												}
												
												html = html + "							</div> ";
//												html = html + "						</a>";
												html = html + "					</li> ";
											}
										}
									}
								}
								
							}
						}
					}
					
					// 리스트 형태 상품 리스트 
					$("#eventList").html(html);
					// 이미지 형태 상품 리스트 
					$("#canReserveEventList").html(html);

				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
					$(".mgt10").trigger('create');
					$(".mstList").trigger('create');
					// --------------------------------------------
					// 총 카운터 갯수 조회 	
					// --------------------------------------------
					
					$(".mstaLink").parent().removeClass("ui-state-hover ui-tabs-active ui-state-active");
					$(".mstaLink").removeClass("ui-btn-active");
					
					if(flagReserve == '') {
						setTimeout(function(){
							// $(".listtab1").addClass("ui-btn-active");
							//$("#listtab1").click();
							$("#listtab1").parent().addClass("ui-state-hover ui-tabs-active ui-state-active");
							$("#listtab1").addClass("ui-btn-active");
							$("#tab1").show();
							$("#tab2").hide();
						}, 70);
						fn_SiteGoodsEvntListCount (eventCd, startDay);					
					} else {
						setTimeout(function(){
							// $(".listtab2").addClass("ui-btn-active");
							//$("#listtab2").click();
							$("#listtab2").parent().addClass("ui-state-hover ui-tabs-active ui-state-active");
							$("#listtab2").addClass("ui-btn-active");
							$("#tab1").hide();
							$("#tab2").show();
						}, 70);						
						fn_SiteGoodsEvntListCountCanReserve (eventCd, startDay);			
					}
					
				}
			});
		};	

		// --------------------------------------------------------------------------------------------------
		// 이용 항공 표시 관련 처리 수정함. 
		// -------------------------------------------------------------------------------------------------
		function fn_air_remark(idx, air, remark) {
			
			// console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> fn_air_remark() >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			
			// console.log(" idx : " + idx);
			// console.log(" air : " + air);
			// console.log(" remark : " + remark);
			// console.log(" tag_air_remark : " + tag_air_remark);
			// console.log(" tag_air_remark.indexOf(air) : " + tag_air_remark.indexOf(air));
			// console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

			if(tag_air_remark.indexOf(air) == -1){
				if(idx == 0){
					tag_air_remark = remark;
				}else{
					tag_air_remark += "," + remark;
				}
			}

			return tag_air_remark;

		}
		// 더보기 버튼 노출 관련 
		function fn_displayMoreBtn() {
			console.log("================ 목록 수 체크 ===================");
			console.log("totalSize : " +  totalSize);
			console.log("curRow : " +  curRow);
			console.log("================ 목록 수 체크 ===================");


			// 상품 목록 더보기 
			if(curRow < totalSize) {
					document.all.btn_more.style.display="";
			}	else {
					document.all.btn_more.style.display="none";
			}				
		}


		// 행사 상품 리스트 카운트 조회 (이벤트 날짜, 행사 일자 검색)
		function fn_SiteGoodsEvntListCount(eventCd, startDay){
			eventCd = eventCd;
			startDay = startDay;
			
			// var ctg = document.frmGoodsCtg.ctg.value;
			// alert(ctg);


			var formData = new FormData();
			formData.append('ctg', ctg);
			formData.append('goodsCd', goodsCd);
			formData.append("eventCd", eventCd);
			formData.append("startDay", startDay);
			formData.append("flagReserve", flagReserve);
			formData.append('price', price);

			cfn_ajax({
				url: "<c:url value='/goods/srchSiteGoodsEvntListCountAjax.do' />",
				type: "POST",
				data: formData,
				async: false,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
					totalSize = res.totalSize;
					
				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
					fn_displayMoreBtn();
				}
			});
		};

		// (더보기) 행사 상품 리스트 조회 (이벤트 날짜, 행사 일자 검색)
		function fn_MoreSiteGoodsEvntList() {
			type = "";
			// 페이지 계산
			if(type == "new"){
				// $(".eventList").empty();
				
				startRow = 1;
				endRow = pageSize;	
								
			}else{
			
				startRow = curRow + 1;
				endRow = curRow + Number(pageSize);

			
			}
			
			console.log("curRow : " + curRow);
			console.log("startRow : " + startRow);
			console.log("endRow : " + endRow);

			if(type != "new"){
				if(startRow > totalSize) {
					alert("더이상 등록된 상품이 없습니다");
					return;
				}
			}


			var formData = new FormData();
			startDay = document.all.frmGoods.startDay.value;
			
			formData.append('ctg', ctg);
			formData.append('goodsCd', goodsCd);
			formData.append("eventCd", eventCd);
			formData.append("startDay", startDay);
			formData.append("startRow", startRow);
			formData.append("endRow", endRow);
			formData.append("flagReserve", flagReserve);
			formData.append('price', price);

			cfn_ajax({
				type: "POST",
				async: false,
				url: "<c:url value='/goods/srchSiteGoodsEvntListAjax.do' />",
				data: formData,
				dataType: "json",
				cache: false,
				noloading: false,
				timeOut: (5*60*1000),
				success: function(res) {
					list = res.list;

					curRow = curRow + list.length;
					// 기존 조회 조건 검색 후 저장해 둠 
					document.all.frmGoods.ctg.value = res.ctg;
					document.all.frmGoods.goodsCd.value = res.goodsCd;
					document.all.frmGoods.startDay.value = res.startDay;
					
					console.log("******************************************************************" + res.startDay);
					
					if(list != null) {
						var html = "";
						var html2 = "";

						for(var i=0; i < list.length; i++) {
										
							/**
							 * [AS_IS] 예약 마감 및 출발 가능/예약 가능 로직을 위한 파라미터 정보 
							**/									
							var rvCnt = list[i]["rv_cnt"];
							var evInwon = list[i]["ev_inwon"];
							var lockUnit = list[i]["lock_unit"];
							var procCd = list[i]["proc_cd"];
					      	var rvStatus = "O";

							if(flagReserve ==  '') {

								var nowDate = new Date('<%=startDay%>'.substring(0,4), '<%=startDay%>'.substring(4,6), '<%=startDay%>'.substring(6, 8));

								// 해외 일 경우 4일 체크 
								var otGoodsDate = new Date(list[i]["start_day"].substring(0, 4), parseInt(list[i]["start_day"].substring(4, 6)), parseInt(list[i]["start_day"].substring(6, 8)));
								otGoodsDate.setDate(otGoodsDate.getDate() - 4);
								// 국내 일 경우 2일 체크 
								var doGoodsDate = new Date(list[i]["start_day"].substring(0, 4), parseInt(list[i]["start_day"].substring(4, 6)), parseInt(list[i]["start_day"].substring(6, 8)));
								doGoodsDate.setDate(doGoodsDate.getDate() - 2);

								if(opCd == 'OT' && nowDate.getTime() > otGoodsDate.getTime()) {
									rvStatus = "X";
								} else if(opCd != 'OT' && nowDate.getTime() > doGoodsDate.getTime()) {
									rvStatus = "X";
								} else if (rvCnt >= evInwon) {
									rvStatus = "X";
								} else {
									if (evInwon == 0) {
										rvStatus = "X";
									} else {
										if (procCd == "RE") {
											rvStatus = "X";
										} else {
											if (lockUnit == "Y") {
												rvStatus = "X";
											} else {							
												if (procCd == "SE") {
													rvStatus = "O";
												} else {
													rvStatus = "O";
												}
											}
										}
									}
								}
								
								console.log("전체 가능 상품 리스트 >>>>>>>>>>>>>>>>> flagReserve >>>>>>>>>>>>>>>> " + flagReserve);

							    //[JEH] 롯데면세점 프로모션일경우 결제페이지로 바로 이동 - 20190510
								if(res.goodsCd == 'PGI1011'){
									if(rvStatus == "O"){
										html = html + '					<li onClick="fn_goReserve(\'' + ctg + '\', \'' + res.goodsCd + '\', \'' + list[i]["event_cd"] + '\')"> ';
									}else{
										html = html + '					<li> ';
									}
								
								}else{
									html = html + '					<li onClick="goGoodsDetail(\'' + list[i]["event_cd"] + '\')"> ';
								}
							    
//								html = html + "						<a href=\"javascript:goGoodsDetail('" + list[i]["event_cd"] + "')\" class='ui-link' data-role='none'>";
								html = html + "							<p class='sm_sub_textbox1'> ";
								if(list[i]["start_day"] != null) {
									html = html + "							<span class='startday'>출발일 "+list[i]["start_day"].substring(4, 6)+"."+list[i]["start_day"].substring(6, 8);
								}
								if(list[i]["start_wday"] != null) {	
									html = html  +"("+list[i]["start_wday"]+") ";
								}
								if(list[i]["start_time"] != null) { 	
									html = html + list[i]["start_time"].substring(0, 2)+":"+list[i]["start_time"].substring(2, 4);
								}
								html = html + "</span>";
								if(list[i]["end_day"] != null) {
									html = html + "							<span class='endday'>도착일 "+list[i]["end_day"].substring(4, 6)+"."+list[i]["end_day"].substring(6, 8);
								}	
								if(list[i]["end_wday"] != null) {
									html = html +"("+list[i]["end_wday"]+") ";
								}
								if(list[i]["end_time"] != null) {
									html = html + list[i]["end_time"].substring(0, 2)+":"+list[i]["end_time"].substring(2, 4);				
								}
								html = html + "</span>";
								html = html + "								<em class='conday'>"+list[i]["ev_night_cnt"]+"박 "+list[i]["ev_day_cnt"]+"일</em>";				
								html = html + "							</p> ";

								/**
								 * [AS_IS] 예약 마감 및 출발 가능/예약 가능 로직입니다. 
								 * OP_CD : OT 해외 일 경우 <출발일 기준 : 2일전>
								 * 출발일 국내 2일, 해외 4일 체크 
									출발가능 cld_purple
									예약가능 cld_blue
									예약마감 cld_black
									긴급모색 cld_red
								**/		
								var nowDate = new Date('<%=startDay%>'.substring(0,4), '<%=startDay%>'.substring(4,6), '<%=startDay%>'.substring(6, 8));

								// 해외 일 경우 4일 체크 
								var otGoodsDate = new Date(list[i]["start_day"].substring(0, 4), parseInt(list[i]["start_day"].substring(4, 6)), parseInt(list[i]["start_day"].substring(6, 8)));
								otGoodsDate.setDate(otGoodsDate.getDate() - 4);
								// 국내 일 경우 2일 체크 
								var doGoodsDate = new Date(list[i]["start_day"].substring(0, 4), parseInt(list[i]["start_day"].substring(4, 6)), parseInt(list[i]["start_day"].substring(6, 8)));
								doGoodsDate.setDate(doGoodsDate.getDate() - 2);

								console.log(" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");
								console.log(" >> opCd :  " + opCd);
								console.log(" >> nowDate.getTime() :  " + nowDate.getTime());
								console.log(" >> otGoodsDate.getTime() :  " + otGoodsDate.getTime());
								console.log(" >> doGoodsDate.getTime() :  " + doGoodsDate.getTime());
								console.log(" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");

								if(opCd == 'OT' && nowDate.getTime() > otGoodsDate.getTime()) {
									html = html + "								<p class='sm_sub_textbox2 cld_black'>예약마감</p><input type='hidden' name='status' value='예약마감'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
								} else if(opCd != 'OT' && nowDate.getTime() > doGoodsDate.getTime()) {
									html = html + "								<p class='sm_sub_textbox2 cld_black'>예약마감</p><input type='hidden' name='status' value='예약마감'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
								} else if (rvCnt >= evInwon) {
									html = html + "								<p class='sm_sub_textbox2 cld_black'>예약마감</p><input type='hidden' name='status' value='예약마감'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
								} else {
									if (evInwon == 0) {
										html = html + "								<p class='sm_sub_textbox2 cld_black'>예약마감</p><input type='hidden' name='status' value='예약마감'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
									} else {
										if (procCd == "RE") {
											html = html + "								<p class='sm_sub_textbox2 cld_black'>예약마감</p><input type='hidden' name='status' value='예약마감'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
										} else {
											if (lockUnit == "Y") {
												html = html + "								<p class='sm_sub_textbox2 cld_black'>예약마감</p><input type='hidden' name='status' value='예약마감'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
											} else {							
												if (procCd == "SE") {
													html = html + "					<p class='sm_sub_textbox2 cld_purple'>출발가능</p><input type='hidden' name='status' value='출발가능'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
													// ---------------------------------------------------------------------------------
													// 출발 가능 일자 달력에 표시하는 부분 
													// ---------------------------------------------------------------------------------
													var tagCanStartDay = "";
													if(list[i]["start_day"] != null) {
														tagCanStartDay = "#div_" + list[i]["start_day"].substring(0, 8);
													}
													console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>> tagCanStartDay : " + tagCanStartDay);
													
													$(tagCanStartDay).removeClass("cld_blue");
													$(tagCanStartDay).removeClass("cld_black");
													$(tagCanStartDay).removeClass("cld_red");
													$(tagCanStartDay).addClass("cld_purple");
													
												} else if (procCd == "09") {
													html = html + "					<p class='sm_sub_textbox2 cld_red'>긴급모객</p><input type='hidden' name='status' value='긴급모객'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
													// ---------------------------------------------------------------------------------
													// 출발 가능 일자 달력에 표시하는 부분 
													// ---------------------------------------------------------------------------------
													var tagCanStartDay = "";
													if(list[i]["start_day"] != null) {
														tagCanStartDay = "#div_" + list[i]["start_day"].substring(0, 8);
													}
													console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>> tagCanStartDay : " + tagCanStartDay);
													
													$(tagCanStartDay).removeClass("cld_blue");
													$(tagCanStartDay).removeClass("cld_black");
													$(tagCanStartDay).removeClass("cld_purple");
													$(tagCanStartDay).addClass("cld_red");

												} else {
													html = html + "					<p class='sm_sub_textbox2 cld_blue'>예약가능</p><input type='hidden' name='status' value='예약가능'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";

													// ---------------------------------------------------------------------------------
													// 예약 가능 일자 달력에 표시하는 부분 
													// ---------------------------------------------------------------------------------
													var tagCanReserveDay = "";
													if(list[i]["start_day"] != null) {
														tagCanReserveDay = "#div_" + list[i]["start_day"].substring(0, 8);
													}
													console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>> tagCanReserveDay : " + tagCanReserveDay);

													$(tagCanReserveDay).removeClass("cld_red");
													$(tagCanReserveDay).removeClass("cld_black");
													$(tagCanReserveDay).removeClass("cld_purple");
													$(tagCanReserveDay).addClass("cld_blue");

												}
											}
										}
									}
								}

								html = html + "							<p class='sm_sub_title'> ";
								html = html + list[i]["disp_nm"];
								html = html + "							</p> ";
								html = html + "							<div class='sm_sub_text1'>";
								html = html + "							<p class='sm_sub_airbox'> ";
								
								var tag_air_remark = "";
								var air_remark = "";
								// 교통수단별 이미지 표시 
								if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'AIR') {
									html = html + "		<img src='/resources/images/air/" + list[i]["trff_cd_short"] + ".png' class='img mgL5'> " + list[i]["cd_nm"];
									air_remark = "<img src='/resources/images/air/" + list[i]["trff_cd_short"] + ".png' class='img'> " + list[i]["cd_nm"];
									tag_air_remark = fn_air_remark(i, list[i]["cd_nm"], air_remark);
									$("#div_air_remark_title").html("이용항공");
								} else if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'CAR') {
									html = html + "		<img src='/resources/images/ico/CAR.png' class='img mgL5'> " + list[i]["start_pyun"];
									air_remark = "<img src='/resources/images/ico/CAR.png' class='img'> " + list[i]["start_pyun"];
									tag_air_remark = fn_air_remark(i, list[i]["start_pyun"], air_remark);
									$("#div_air_remark_title").html("이용교통");
								} else if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'BUS') {
									html = html + "		<img src='/resources/images/ico/BUS.png' class='img mgL5'> " + list[i]["start_pyun"];
									air_remark = "<img src='/resources/images/ico/BUS.png' class='img'> " + list[i]["start_pyun"];
									tag_air_remark = fn_air_remark(i, list[i]["start_pyun"], air_remark);
									$("#div_air_remark_title").html("이용교통");
								} else if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'SHP') {
									html = html + "		<img src='/resources/images/ico/SHP.png' class='img mgL5'> " + list[i]["start_pyun"];
									air_remark = "<img src='/resources/images/ico/SHP.png' class='img'> " + list[i]["start_pyun"];
									tag_air_remark = fn_air_remark(i, list[i]["start_pyun"], air_remark);
									$("#div_air_remark_title").html("이용교통");
								} else if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'TRA') {
									html = html + "		<img src='/resources/images/ico/TRA.png' class='img mgL5'> " + list[i]["start_pyun"];
									air_remark = "<img src='/resources/images/ico/TRA.png' class='img'> " + list[i]["start_pyun"];
									tag_air_remark = fn_air_remark(i, list[i]["start_pyun"],  air_remark);
									$("#div_air_remark_title").html("이용교통");
								} 
								
								$("#div_air_remark").html(tag_air_remark);

								html = html + "							</p> ";
								html = html + "							</div>";
								html = html + "							<div class='sm_sub_text1'> ";
								html = html + "								남은 좌석 : <em>"+( parseInt(list[i]["ev_inwon"]) - parseInt(list[i]["rv_cnt"]) )+"석</em>, 최소출발 : <em>"+list[i]["min_inwon"]+"명</em> ";
								

								/*** 임직원 할인가 표시 ***/
								if(grade == "그룹직원" && parseInt(list[i]["emp_rate"]) > 0){	
									//[JEH] 임직원 할인가 계산 - 20190603
									var str_adult_price = list[i]["adult_price"];
									var emp_rate = parseInt(list[i]["emp_rate"]);
									var emp_amt = (parseInt(str_adult_price) * ((100 - emp_rate) * 0.01)) + parseInt(list[i]["etc_price1"]);
									
									html = html + "								<p class='sm_sub_pirce line-through' style='top: -20px;font-size: 12px;'><em style='font-size: 13px;'>"+ list[i]["str_tot_amt1"]+"</em>원</p> ";
									html = html + "								<p class='sm_sub_pirce' style='color:#cd1d1f;top:-5px;'><em style='color:#cd1d1f;'>"+ addComma(Math.round(emp_amt))+"</em>원</p> ";
								}else{
									html = html + "								<p class='sm_sub_pirce'><em>"+ list[i]["str_tot_amt1"]+"</em>원</p> ";
								}
								
								html = html + "							</div> ";
//								html = html + "						</a>";
								html = html + "					</li> ";
								
							} else { // 예약 가능 상품 인 경우만 
								
								console.log(" 예약 가능 상품 리스트 >>>>>>>>>>>>>>>>>  flagReserve >>>>>>>>>>>>>>>> " + flagReserve);

								/**
								 * [AS_IS] 예약 마감 및 출발 가능/예약 가능 로직입니다. 
								**/	
								var nowDate = new Date('<%=startDay%>'.substring(0,4), '<%=startDay%>'.substring(4,6), '<%=startDay%>'.substring(6, 8));

								// 해외 일 경우 4일 체크 
								var otGoodsDate = new Date(list[i]["start_day"].substring(0, 4), parseInt(list[i]["start_day"].substring(4, 6)), parseInt(list[i]["start_day"].substring(6, 8)));
								otGoodsDate.setDate(otGoodsDate.getDate() - 4);
								// 국내 일 경우 2일 체크 
								var doGoodsDate = new Date(list[i]["start_day"].substring(0, 4), parseInt(list[i]["start_day"].substring(4, 6)), parseInt(list[i]["start_day"].substring(6, 8)));
								doGoodsDate.setDate(doGoodsDate.getDate() - 2);
																
								if(opCd == 'OT' && nowDate.getTime() > otGoodsDate.getTime()) {
									rvStatus = "X";								
									// html = html + "								<p class='appguide append'>예약마감</p>";
								} else if(opCd != 'OT' && nowDate.getTime() > doGoodsDate.getTime()) {
									// html = html + "								<p class='appguide append'>예약마감</p>";	
									rvStatus = "X";
								} else if (rvCnt >= evInwon) {
									// html = html + "								<span>예약마감</span>";
									rvStatus = "X";
								} else {
									if (evInwon == 0) {
										// html = html + "								<span>예약마감</span>";
										rvStatus = "X";
									} else {
										if (procCd == "RE") {
											// html = html + "								<span>예약마감</span>";
											rvStatus = "X";
										} else {
											if (lockUnit == "Y") {
												// html = html + "								<span>예약마감</span>";
												rvStatus = "X";
											} else {							
												if (procCd == "SE") {
													
													tag = "					<p class='sm_sub_textbox2 cld_purple'>출발가능</p><input type='hidden' name='status' value='출발가능'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
													rvStatus = "O";
													// ---------------------------------------------------------------------------------
													// 출발 가능 일자 달력에 표시하는 부분 
													// ---------------------------------------------------------------------------------
													var tagCanStartDay = "";
													if(list[i]["start_day"] != null) {
														tagCanStartDay = "#div_" + list[i]["start_day"].substring(0, 8);
													}
													console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>> tagCanStartDay : " + tagCanStartDay);
													
													$(tagCanStartDay).removeClass("cld_blue");
													$(tagCanStartDay).removeClass("cld_black");
													$(tagCanStartDay).removeClass("cld_red");
													$(tagCanStartDay).addClass("cld_purple");

												} else if (procCd == "09") {
													tag = "					<p class='sm_sub_textbox2 cld_red'>긴급모객</p><input type='hidden' name='status' value='긴급모객'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
													// ---------------------------------------------------------------------------------
													// 긴급모객 가능 일자 달력에 표시하는 부분 
													// ---------------------------------------------------------------------------------
													var tagCanStartDay = "";
													if(list[i]["start_day"] != null) {
														tagCanStartDay = "#div_" + list[i]["start_day"].substring(0, 8);
													}
													console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>> tagCanStartDay : " + tagCanStartDay);
													
													$(tagCanStartDay).removeClass("cld_blue");
													$(tagCanStartDay).removeClass("cld_black");
													$(tagCanStartDay).removeClass("cld_purple");
													$(tagCanStartDay).addClass("cld_red");

												} else {

													tag = "					<p class='sm_sub_textbox2 cld_blue'>예약가능</p><input type='hidden' name='status' value='예약가능'><input type='hidden' name='date' value='"+list[i]["start_day"].substring(6, 8)+"'>";
													rvStatus = "O";
													// ---------------------------------------------------------------------------------
													// 예약 가능 일자 달력에 표시하는 부분 
													// ---------------------------------------------------------------------------------
													var tagCanReserveDay = "";
													if(list[i]["start_day"] != null) {
														tagCanReserveDay = "#div_" + list[i]["start_day"].substring(0, 8);
													}
													console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>> tagCanReserveDay : " + tagCanReserveDay);
													
													$(tagCanReserveDay).removeClass("cld_purple");
													$(tagCanReserveDay).removeClass("cld_black");
													$(tagCanReserveDay).removeClass("cld_red");
													$(tagCanReserveDay).addClass("cld_blue");

												}

											    //[JEH] 롯데면세점 프로모션일경우 결제페이지로 바로 이동 - 20190510
												if(res.goodsCd == 'PGI1011'){
													if(rvStatus == "O"){
														html = html + '					<li onClick="fn_goReserve(\'' + ctg + '\', \'' + res.goodsCd + '\', \'' + list[i]["event_cd"] + '\')"> ';
													}else{
														html = html + '					<li> ';
													}
												
												}else{
													html = html + '					<li onClick="goGoodsDetail(\'' + list[i]["event_cd"] + '\')"> ';
												}
											    
//												html = html + "						<a href=\"javascript:goGoodsDetail('" + list[i]["event_cd"] + "')\" class='ui-link' data-role='none'>";
												html = html + "							<p class='sm_sub_textbox1'> ";
												if(list[i]["start_day"] != null) {
													html = html + "							<span class='startday'>출발일 "+list[i]["start_day"].substring(4, 6)+"."+list[i]["start_day"].substring(6, 8);
												}
												if(list[i]["start_wday"] != null) {	
													html = html  +"("+list[i]["start_wday"]+") ";
												}
												if(list[i]["start_time"] != null) { 	
													html = html + list[i]["start_time"].substring(0, 2)+":"+list[i]["start_time"].substring(2, 4);
												}
												html = html + "</span>";
												if(list[i]["end_day"] != null) {
													html = html + "							<span class='endday'>도착일 "+list[i]["end_day"].substring(4, 6)+"."+list[i]["end_day"].substring(6, 8);
												}	
												if(list[i]["end_wday"] != null) {
													html = html +"("+list[i]["end_wday"]+") ";
												}
												if(list[i]["end_time"] != null) {
													html = html + list[i]["end_time"].substring(0, 2)+":"+list[i]["end_time"].substring(2, 4);				
												}
												html = html + "</span>";
												html = html + "								<em class='conday'>"+list[i]["ev_night_cnt"]+"박 "+list[i]["ev_day_cnt"]+"일</em>";				
												html = html + "							</p> ";

												/**
												 * [AS_IS] 예약 마감 및 출발 가능/예약 가능 로직입니다. 
												 * OP_CD : OT 해외 일 경우 <출발일 기준 : 2일전>
												 * 출발일 국내 2일, 해외 4일 체크 
												**/		
												html = html + "							<p class='sm_sub_title'> ";
												html = html + list[i]["disp_nm"];
												html = html + "							</p> ";
												
												html = html + "							<div class='sm_sub_text1'>";
												html = html + "							<p class='sm_sub_airbox'> ";
												
												var tag_air_remark = "";
												var air_remark = "";
												// 교통수단별 이미지 표시 
												if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'AIR') {
													html = html + "		<img src='/resources/images/air/" + list[i]["trff_cd_short"] + ".png' class='img mgL5'> " + list[i]["cd_nm"];
													air_remark = "<img src='/resources/images/air/" + list[i]["trff_cd_short"] + ".png' class='img'> " + list[i]["cd_nm"];
													tag_air_remark = fn_air_remark(i, list[i]["cd_nm"], air_remark);
													$("#div_air_remark_title").html("이용항공");
												} else if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'CAR') {
													html = html + "		<img src='/resources/images/ico/CAR.png' class='img mgL5'> " + list[i]["start_pyun"];
													air_remark = "<img src='/resources/images/ico/CAR.png' class='img'> " + list[i]["start_pyun"];
													tag_air_remark = fn_air_remark(i, list[i]["start_pyun"], air_remark);
													$("#div_air_remark_title").html("이용교통");
												} else if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'BUS') {
													html = html + "		<img src='/resources/images/ico/BUS.png' class='img mgL5'> " + list[i]["start_pyun"];
													air_remark = "<img src='/resources/images/ico/BUS.png' class='img'> " + list[i]["start_pyun"];
													tag_air_remark = fn_air_remark(i, list[i]["start_pyun"], air_remark);
													$("#div_air_remark_title").html("이용교통");
												} else if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'SHP') {
													html = html + "		<img src='/resources/images/ico/SHP.png' class='img mgL5'> " + list[i]["start_pyun"];
													air_remark = "<img src='/resources/images/ico/SHP.png' class='img'> " + list[i]["start_pyun"];
													tag_air_remark = fn_air_remark(i, list[i]["start_pyun"], air_remark);
													$("#div_air_remark_title").html("이용교통");
												} else if(list[i]["trff_cd"] != null && list[i]["trff_cd"].toUpperCase() == 'TRA') {
													html = html + "		<img src='/resources/images/ico/TRA.png' class='img mgL5'> " + list[i]["start_pyun"];
													air_remark = "<img src='/resources/images/ico/TRA.png' class='img'> " + list[i]["start_pyun"];
													tag_air_remark = fn_air_remark(i, list[i]["start_pyun"],  air_remark);
													$("#div_air_remark_title").html("이용교통");
												} 

												$("#div_air_remark").html(tag_air_remark);

												html = html + "							</p> ";
												html = html + "							</div>";

												html = html + "							<div class='sm_sub_text1'> ";
												html = html + "								남은 좌석 : <em>"+( parseInt(list[i]["ev_inwon"]) - parseInt(list[i]["rv_cnt"]) )+"석</em>, 최소출발 : <em>"+list[i]["min_inwon"]+"명</em> ";

												/*** 임직원 할인가 표시 ***/
												if(grade == "그룹직원" && parseInt(list[i]["emp_rate"]) > 0){	
													//[JEH] 임직원 할인가 계산 - 20190603
													var str_adult_price = list[i]["adult_price"];
													var emp_rate = parseInt(list[i]["emp_rate"]);
													var emp_amt = (parseInt(str_adult_price) * ((100 - emp_rate) * 0.01)) + parseInt(list[i]["etc_price1"]);
													
													html = html + "								<p class='sm_sub_pirce line-through' style='top: -20px;font-size: 12px;'><em style='font-size: 13px;'>"+ list[i]["str_tot_amt1"]+"</em>원</p> ";
													html = html + "								<p class='sm_sub_pirce' style='color:#cd1d1f;top:-5px;'><em style='color:#cd1d1f;'>"+ addComma(Math.round(emp_amt))+"</em>원</p> ";
												}else{
													html = html + "								<p class='sm_sub_pirce'><em>"+ list[i]["str_tot_amt1"]+"</em>원</p> ";
												}
												
												html = html + "							</div> ";
//												html = html + "						</a>";
												html = html + "					</li> ";
											}
										}
									}
								}
							}
						}
					}
				
					// console.log(html);
					// 리스트 형태 상품 리스트 
					$("#eventList").append(html);
					// 이미지 형태 상품 리스트 
					$("#canReserveEventList").append(html);

				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
					$(".mgt10").trigger('create');
					$(".mstList").trigger('create');

					// --------------------------------------------
					// 총 카운터 갯수 조회 	
					// --------------------------------------------
					
					$(".mstaLink").parent().removeClass("ui-state-hover ui-tabs-active ui-state-active");
					$(".mstaLink").removeClass("ui-btn-active");
					
					if(flagReserve == '') {
						setTimeout(function(){
							// $(".listtab1").addClass("ui-btn-active");
							//$("#listtab1").click();
							$("#listtab1").parent().addClass("ui-state-hover ui-tabs-active ui-state-active");
							$("#listtab1").addClass("ui-btn-active");
							$("#tab1").show();
							$("#tab2").hide();
						}, 70);
						fn_SiteGoodsEvntListCount (eventCd, startDay, flagReserve);					
					} else {
						setTimeout(function(){
							// $(".listtab2").addClass("ui-btn-active");
							//$("#listtab2").click();
							$("#listtab2").parent().addClass("ui-state-hover ui-tabs-active ui-state-active");
							$("#listtab2").addClass("ui-btn-active");
							$("#tab1").hide();
							$("#tab2").show();
						}, 70);						
						fn_SiteGoodsEvntListCountCanReserve (eventCd, startDay, flagReserve);			
					}
				}
			});
		};	

		// 예약 가능 행사 상품 리스트 카운트 조회 (이벤트 날짜, 행사 일자 검색)
		function fn_SiteGoodsEvntListCountCanReserve(eventCd, startDay){
			eventCd = eventCd;
			startDay = startDay;
			
			// var ctg = document.frmGoodsCtg.ctg.value;
			// alert(ctg);


			var formData = new FormData();
			formData.append('ctg', ctg);
			formData.append('goodsCd', goodsCd);
			formData.append("eventCd", eventCd);
			formData.append("startDay", startDay);
			formData.append("flagReserve", flagReserve);
			formData.append('price', price);

			cfn_ajax({
				url: "<c:url value='/goods/srchSiteGoodsEvntListCountCanReserveAjax.do' />",
				type: "POST",
				data: formData,
				async: false,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
					totalSize = res.totalSize;
					
				},
				error:function(err){
					console.log(err);
				},
				complete:function(){

					fn_displayMoreBtn();
				}
			});
		};

		// 전체 상품 리스트 / 예약 가능 상품 리스트 보기 
		function change_view(viewType) {
			console.log(" >>>>>>>>>>>>>>>>>> change_view() : " + viewType + ">>>>>>>>>>>>>>>>>>>>>>>>");
			type = "new";
			if(viewType == '01') {
					console.log(" >>>>>>>>>>>>>>>>>> 전체 상품 리스트 >>>>>>>>>>>>>>>>>>>>>>>>");
					flagReserve = "";
					
					startDay = document.all.frmGoods.startDay.value;
					console.log("eventCd >>>>> " + eventCd);
					console.log("startDay >>>>> " + startDay);
					fn_SiteGoodsEvntList(eventCd, startDay);
					fn_SiteGoodsEvntListCount(eventCd, startDay);
					// $("#eventList").show();
					// $("#canReserveEventList").hide();

			} else { 
					console.log(" >>>>>>>>>>>>>>>>>> 예약 가능 상품 리스트 >>>>>>>>>>>>>>>>>>>>>>>>");
					flagReserve = "Y";
					
					startDay = document.all.frmGoods.startDay.value;
					console.log("eventCd >>>>> " + eventCd);
					console.log("startDay >>>>> " + startDay);
					fn_SiteGoodsEvntList(eventCd, startDay);	
					fn_SiteGoodsEvntListCount(eventCd, startDay);
					// $("#eventList").hide();
					// $("#canReserveEventList").show();

			}
		}

		// [COMMON] 공통사항 
		$(document).ready(function(){
			master_init();
			fn_init();
			// fn_initButton();	
  			// 상품 전시 페이지 CSS 스타일을 맞춰줌 
			$(".bodyWrap").addClass("goods");
          	$(".mstdetailtitl").trigger('create');
          	
          	if(ctg == '5811'){
				$("#ctg_depth2_p").hide();
				$("#ctg_depth3_p").hide();
			}
			/*document.addEventListener("deviceready", function(){
                fn_init();
                fn_initButton();	
                master_init();
				
			}, false);*/
		});
		
		jQuery(function(){
			/*****행사리스트 (마스터) 달력*****/
			var swiper = new Swiper('.sd_cld_list', {
		        pagination: '.swiper-pagination',
		        paginationClickable: true,
		        slidesPerView: 7
		    });
		});

	     function fn_goReserve(ctg,goodsCd,eventCd) {
	    	 
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
		         if (cust_cd == null || cust_cd == ""){
		 			var param = "/reserve/reserve_clause.do?ctg=" + ctg + "&eventCd=" + eventCd;
		 			setCookieValue('nowUrl', param);

		            document.location.replace("/sso/nologinPage.do?ctg=" + ctg + "&goodsCd=" + goodsCd + "&eventCd=" + eventCd);
		         }else{
		        	 //로그인상태
		             document.location.replace("/reserve/reserve_clause.do?ctg=" + ctg + "&goodsCd=" + goodsCd + "&eventCd=" + eventCd);
		         }
			}else{
				alert('예약 마감되었습니다.');
				window.location.reload();
				return;
			}
	     }

			function go_youtube(){
				window.open("https://youtu.be/8CoCwCjj0p0", "_blank");
			}

	//-->        
</script>
<style>
	.swiper-container.weekDay .swiper-slide{width:15%;background: #a0adbe;}
</style>
</head>

	<!-- 상품 마스터 검색을 위한 정보 -->
	<form name="frmGoods">
		<input type="hidden" name="ctg" value="">
		<input type="hidden" name="goodsCd" value="">
		<input type="hidden" name="eventCd" value="">
		<input type="hidden" name="startDay" value="">
		<input type="hidden" name="flagReserve" value="">
				
	</form>	

	<!--content-->
	<div role="main" class="ui-content contentWrap shopmasterbox" id="top">
		<div class="collapse shoptop" id="listTable">
			<!-- 카테고리 -->
			<p class="sd_category1" id="ctg_depth2_p"><button type="button" data-role="none" onClick="popGoodsCategory1()"><span id="ctg_depth2" name="ctg_depth2">유럽/아프리카/인도</span></button></p>
			<p class="sd_category2" id="ctg_depth3_p"><button type="button" data-role="none" onClick="popGoodsCategory2()"><span id="ctg_depth3" name="ctg_depth3">유럽</span></button></p>
			
			<div class="sd_areabox1" id="calendarEvnt">
			</div>

			<ul class="tablist_com sm_mst_tab mt7" data-ctn="sm_mst_box">
				<li class="active"><button type="button" data-role="none" onclick="change_view('01')"><span>전체 상품보기</span></button></li>
				<li><button type="button" data-role="none" onclick="change_view('02')"><span>예약가능 상품보기</span></button></li>
			</ul>
			<div class="tabctn_com sm_mst_box sm_mst_box1 ps_view">
 				<ul class="sm_sub_listbox" id="eventList">	
				</ul>
			</div>
			<div class="tabctn_com sm_mst_box sm_mst_box2">
 				<ul class="sm_sub_listbox" id="canReserveEventList">	
				</ul>
			</div>

			<!-- 버튼 -->
			<p class="sd_guide_ico1">유류할증료는 유가와 환율에 따라 변동될 수 있습니다.</p>
			<!-- 버튼 -->
			<div class="btn_one sd_info1_tbtn1"><button class="white2 moreico" data-role="none" id="btn_more" onClick="javascript:fn_MoreSiteGoodsEvntList()">더보기</button></div>

			<!--bottom-->
			<script src="/resources/common/bottom.js"></script>
			<!--bottom-->
			
		</div>
		
		<!-- 상품 카테고리 DEPTH2 레이어 영역 -->
		<%@ include file="/WEB-INF/jsp/goods/inc_layer_goods_ctg.jsp"%>

	</div>
