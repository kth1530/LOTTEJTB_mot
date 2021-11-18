<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>

<head>

<%
	// 서버 날짜 받아오기 
	Date systemDate1 = new Date();
	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
	String serverDay1 = sdf1.format(systemDate1);
	
	String selAir = (String) request.getAttribute("selAir");
	String selHotel = (String) request.getAttribute("selHotel");
	String selRentcar = (String) request.getAttribute("selRentcar");		
%>

<script src="/resources/common/js/fit/hotel_search.js"></script>
<script src="/resources/common/js/fit/paging.js"></script>
<script src="/resources/common/js/fit/common.js"></script>	
<script type="text/javascript">
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){
	if(nullToBlank(getCookieValue('hotelViewData')) != ""){
		sessionStorage.hotelViewData = getCookieValue('hotelViewData');
		setCookieValue('hotelViewData', "");
	}
	
	if(nullToBlank(getCookieValue('hotelSearchVal')) != ""){
		sessionStorage.hotelSearchVal = getCookieValue('hotelSearchVal');
		setCookieValue('hotelSearchVal', "");
	}

	// 초기화
	var fn_init = function() {
		
		var hotelSelYn = '${selHotel}';
		var type = '${type}';
		
		console.log(">>>type=" + type);
		
		if(hotelSelYn != 'Y') {
			sessionStorage.hotelViewData = JSON.stringify([]);
			sessionStorage.hotelSearchVal = JSON.stringify([]);
		}
		
		$('#f_frm').children('input[name="selHotel"]').val('Y');
		
		//console.log("sessionStorage.hotelViewData~~~~");
		//if(sessionStorage.hotelViewData != undefined
		//	&& JSON.parse(sessionStorage.hotelViewData) != undefined) {
		if(nullToBlank(sessionStorage.hotelViewData) != '' && sessionStorage.hotelViewData != '[]')	{
			
		 	$('#hotel_result_nodata_div').hide();
			$('#hotel_result_list_div').show();
			
			//셋팅된 검색값 성인 수
			//성인수
			var adultNumber = 0;
			//아동수 
			var childNumber = 0;
			
			//화면에 보여줄 검색값 셋팅
			var search_div = $('#search_data');
			
			var view_data = JSON.parse(sessionStorage.hotelViewData);
			
			//console.log("view_data.countryNm=" + view_data.countryNm);
			
			//국가표시
			search_div.find('[name="cityName"]').text(view_data.countryNm);
			//search_div.find('[name="cityCode"]').text("(" + view_data.cityCode + ")");
			
			var countryNmEn = view_data.countryNmEn;
			
			if(nullToBlank(countryNmEn) == '') countryNmEn = '';
			else countryNmEn = "(" + view_data.countryNmEn + ")"; 
			
			search_div.find('[name="cityNmEn"]').text(countryNmEn);
			
			if(nullToBlank(view_data.countryNmEn) == "") countryNmEn = '';
			else countryNmEn = "(" + view_data.countryNmEn + ")";
						
			$('#hotel_search_div').find('[name="searchCityNmEn"]').val(countryNmEn);
			
			
						
			//유효성 로직 추가
			if(nullToBlank(sessionStorage.airSelData) != '' && sessionStorage.airSelData != '[]') { 
				
				var l_airSelData = JSON.parse(sessionStorage.airSelData);
				var searchVal = JSON.parse(sessionStorage.hotelSearchVal);
				
				if(nullToBlank(l_airSelData[0]) != '') {
					if(l_airSelData[0].hasOwnProperty('gdsCd')){	//항공 선택이 되어있을 경우
						
						var hotel_div = $('#hotel_search_div');
					
						var air_sdate = l_airSelData[0].fltData[0].arrDt;
					
					 	var e_ahInterval = calcInterval2(air_sdate, '0000', view_data.checkInDate, '0000').split(',');
						if((e_ahInterval[0]-0) < 0){
							alert('체크인 날짜가 항공 도착일보다 빠릅니다.\n체크인 날짜를 ' + air_sdate + '로 변경하여 검색합니다.');
							air_sdate = air_sdate.substring(0,4) + "-" + air_sdate.substring(4,6) + "-" + air_sdate.substring(6);
							view_data.checkInDate = air_sdate;
							hotel_div.find('#dep_dt').text(air_sdate.substring(0,4) + "." + air_sdate.substring(4,6) + "." + air_sdate.substring(6));
							searchVal.checkInDt = view_data.checkInDate;
						}	
					
						if(l_airSelData[0].availTy == 'RT'){
							var air_edate = l_airSelData[0].fltData[1].depDt;
							var e_eInterval = calcInterval2(view_data.checkOutDate, '0000', air_edate, '0000').split(',');
														
							if((e_eInterval[0]-0) < 0){
									alert('체크아웃 날짜가 항공 귀국일보다 늦습니다.\n체크아웃 날짜를 ' + air_edate + '로 변경하여 검색합니다.');
									air_edate = air_edate.substring(0,4) + "-" + air_edate.substring(4,6) + "-" + air_edate.substring(6);
									view_data.checkOutDate = air_edate;
									hotel_div.find('#arr_dt').text(air_edate.substring(0,4) + "." + air_edate.substring(4,6) + "." + air_edate.substring(6));
									searchVal.checkOutDt = view_data.checkOutDate;
							}
						}
						sessionStorage.hotelSearchVal = JSON.stringify(searchVal);
					}
				}
			}
					
			//날짜 셋팅
			var checkinDate = view_data.checkInDate.split("-");
			checkinDate = checkinDate[0] + "." + checkinDate[1] + "." + checkinDate[2];
			var checkoutDate = view_data.checkOutDate.split("-");
			checkoutDate = checkoutDate[0] + "." + checkoutDate[1] + "." + checkoutDate[2];
			search_div.find('[name="dateSetting"]').text(checkinDate+ " ~ " + checkoutDate);
			
			for(var i=0; i < view_data.roomCont.length; i++) {
				adultNumber += parseInt(view_data.roomCont[i].numOfAdt);
				childNumber += parseInt(view_data.roomCont[i].numOfChd);
			}
	
			search_div.find('[name="dateSetting"]').append("<p>객실" + view_data.roomCnt + " 성인" + adultNumber + " 아동"  +  childNumber + "</p>");
			
			//장바구니 담기에서 호텔 추가하기,호텔 예약하기 누를시 재검색 화면 활성화 시키자.
			if(type == 'hotel') {
				$('.re_search').click();
				type = '';
			}
 			
						
			//호텔리스트
			fn_hotel_list(JSON.parse(sessionStorage.hotelSearchVal));
		}
		
		//하단 장바구니 안보이게 처리
	    $('#bottom_basket_rect').hide();
	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();
		$(".bodyWrap").addClass("foot2pd");
		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});

	// });
</script>
</head>
<body>
	<form name="f_frm" id="f_frm" method="post">
		<input type="hidden" name="selAir" id="selAir" value="${selAir}" />
		<input type="hidden" name="selHotel" id="selHotel" value="${selHotel}" />
		<input type="hidden" name="selRentcar" id="selRentcar" value="${selRentcar}" />
	</form>


	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="collapse freetop">
			<!-- 중복텝 -->
			<%
				// 항공 || 호텔 || 렌트카
				if(selAir.equals("Y") && selHotel.equals("Y") && selRentcar.equals("Y")) {
			%>
			<div class="free_box">
				<ul class="free_toprst frrst3">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="hotelcheck">호텔</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
				// 항공 || 호텔
				if(selAir.equals("Y") && selHotel.equals("Y") && !selRentcar.equals("Y")) {
			%> 
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="hotelcheck">호텔</label></li>
				</ul>
			</div>
			<%
				}
				// 항공 || 렌트카 
				if(selAir.equals("Y") && !selHotel.equals("Y") && selRentcar.equals("Y")) {
			%>
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
				// 호텔 || 렌트카 
				if(!selAir.equals("Y") && selHotel.equals("Y") && selRentcar.equals("Y")) {			
			%>
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" disabled="true" /><label for="hotelcheck">호텔</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
				// 항공
				if(selAir.equals("Y") && !selHotel.equals("Y") && !selRentcar.equals("Y")) {			
			%>			
			<div class="free_box">
				<ul class="free_toprst frrst1">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="aircheck">항공</label></li>
				</ul>
			</div>
			<%
				}
				// 호텔
				if(!selAir.equals("Y") && selHotel.equals("Y") && !selRentcar.equals("Y")) {			
			%>			
			<div class="free_box">
				<ul class="free_toprst frrst1">
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="hotelcheck">호텔</label></li>
				</ul>
			</div>
			<%
				}
				// 렌터카
				if(!selAir.equals("Y") && !selHotel.equals("Y") && selRentcar.equals("Y")) {			
			%>			
			<div class="free_box">
				<ul class="free_toprst frrst1">
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
			%>
			
			<!-- 갯수별 
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" disabled="true" /><label for="hotelcheck">호텔</label></li>
				</ul>
			</div>
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="hotelcheck">호텔</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<div class="free_box">
				<ul class="free_toprst frrst1">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="aircheck">항공</label></li>
				</ul>
			</div>
			-->
			<!-- 간략안내 -->
			<div class="re_sarchbox" id="search_data">
				<div class="stable_guide2">
					<p class="st2_text3" name="cityName" id="cityName"></p>
					<p class="st2_stext3 ellipsis" name="cityCode" id="cityCode"></p>
					<p class="st2_stext3 ellipsis" name="cityNmEn" id="cityNmEn"></p>
				</div>
				<div class="txbox1" name="dateSetting" id="dateSetting">
					<!--  -<p name="dataSetCont" id="dataSetCont"></p>-->
				</div>
				<!-- 검색버튼 -->
				<button type="button" data-role="none" class="re_search">재검색</button>
				<!-- 정렬박스 -->
				<ul class="fr_sortbox">
					<li>총 상품 <span ft-arr="totCnt" id="totCnt" name="totCnt">0</span>개</li>
					<li><button type="button" class="layerOpener" data-url="/pop/pop_hotel_sorting.do"  data-width="300" data-height="400" data-ok="yes" data-ctn="full" data-role="none" style="cursor='hand';"><span id="hotel_sort" name='hotel_sort' data-hotelsort='R'>추천순</span></button></li>
					<li><button type="button" class="layerOpener" data-url="/pop/pop_hotel_ifdetail.do" data-ok="yes" data-ctn="full" data-role="none" style="cursor='hand';"></button></li>
				</ul>
				<!-- 호텔정보 -->
				<div id="hotel_result_list_div">
					<!-- 
					<ul class="frht_listbox" >
					
					 	<li>
							<div class="frht_list">
								이미지 사이즈 100*100
								<p class="frht_img">
									<a href="#"><img src="/resources/images/img/fr_ht_img1.jpg"
										alt="" /></a>
								</p>
								<div class="frht_info">
									<p class="frht_stxt">SHANGRHLA HOTEL BANGKOK</p>
									<p class="frht_htxt">
										<a href="#"><span class="ellipsis">샹그릴라 호텔 방콕 호텔 방콕
												호텔 방콕</span></a>
										<button type="button" data-role="none"></button>
									</p>
									<p class="frht_stxt2 ellipsis">수영장, 에이콘, 초고속인터넷, 롬서비스, 무료주차</p>
									<p class="frht_rebox">
										<span><em>1</em><em>2</em><em>3</em><em>4</em><em>5</em></span>
										<span>0.0/5.0</span>
									</p>
								</div>
							</div>
						</li>
						<li><span>1박 요금 최저가</span>
							<p>
								<strike>9,30,000원</strike><em>9,30,000</em>원
							</p>
						</li>
					</ul>
					-->
				</div>
				<!-- 빈데이터 -->
				<div id='hotel_result_nodata_div' name="hotel_result_nodata_div">
					<div class="fr_nodata">
						<p>
							검색하신 조건으로<br>검색된 호텔이 없습니다.
						</p>
					</div>		
				</div>		
				
				<!-- 버튼 -->
				<div class="btn_one air_tbtn">
					<button class="white2 moreico" id="morebtn" data-role="none" onclick="fn_call_more_list();">더보기</button>
				</div>

				<!-- *********************** 재검색 레이어 ******************* -->
				<div class="re_schview">

					<!-- 호텔파트 -->
					<%@include file="/WEB-INF/jsp/free/inc_hotel_search_result.jsp"%>
					<!-- 닫기튼 -->
					<button type="button" data-role="none" class="re_search_close">닫기</button>
				</div>
			</div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//content-->