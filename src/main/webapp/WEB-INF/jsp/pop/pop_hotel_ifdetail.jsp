<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_hotel_ifdetail.jsp
	// 설명 : 호텔결과 상세조건
%>

<head>
<style>
#autocomplete {
	width:100%;
	height:100px;
	background-color: white;
	z-index: 3;
	position: relative;
	left:10px;
	right: 20px;
	cursor: pointer;
	font-weight : normal;
} 

.auto_sck_box {
    float: none;
    position: absolute;
    max-height: 200px;
    margin: 10;
    border: 1px solid #cacacc;
    overflow: hidden;
    overflow-y: auto;
    z-index: 200000000000000000;
    background: #fff;
    padding-left: 5px; 
    
</style>

</head>
<link rel="stylesheet" href="/resources/common/css/normalize.css" />
<link rel="stylesheet" href="/resources/common/css/ion.rangeSlider.css" />
<link rel="stylesheet" href="/resources/common/css/ion.rangeSlider.skinFlat.css" />
<script src="/resources/common/js/fit/hotel_search.js"></script>
<script src="/resources/common/js/ion.rangeSlider.js"></script>
<script type="text/javascript">

	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){

	// 초기화
	var fn_init = function() {
	
		/*
		if(nullToBlank(sessionStorage.filterViewData) != '' && sessionStorage.filterViewData != '[]') {
			
			 var filterView = JSON.parse(sessionStorage.filterViewData);
			
			//호텔
			$('#hotel_srch').val(filterView.hotelNm);
			//등급
			for(var i=1; i <= filterView.grade.length; i++) {
				//var tag = "#chk_if2_" + i;
				if($(tag).val() ==  filterView.grade[i]) {
					
				}
				$('#chk_if2_0').prop("checked", false);
				$(tag).prop("checked", true);
			}
			
			//가격
			filter.minRate = filterView.price.from;
			filter.maxRate = filterView.price.to;
			
			//편의시설
			for(var i=1; i < filterView.convenience.length; i++) {
				var tag = "#chk_if5_" + i;
				$('#chk_if5_0').prop("checked", false);
				$(tag).prop("checked", true);
			}
				
		} else {
			console.log("init~~~~~~~~~~~~~~~");
			$('#hotel_srch').val("");
			$('#chk_if2_0').prop("checked", true);
			$('#chk_if5_0').prop("checked", true);
		} */
				
		fn_DetailCondition();
	};

	var fn_search = function() {
	};

	// 버튼 초기화
	var fn_initButton = function() {
	};
	
	
	/* //검색결과
	var fn_srhResult = function(_data) {
		
		_data.length  = 4;
		
		if(_data != null && _data.length > 0) {
			for(var i=0; i < _data.length; i++) {		
				vHtml= '';
			
				vHtml += "	<dd>					"
				vHtml += " 		<p class='chkbox'>	"
				vHtml += "			<span><input id='chk_if_" + i + "' type='checkbox' data-role='none' /></span>"
				vhtml += "   		<label for='chk_if_" + i + "'> " + "브루클린 브리지" + "</label>"
				vHtml += "		</p>				"
				vHtml += "  </dd>					" 
			
				$('#search_result').html(vHtml);
		 	}
			
		}
		
	}; */
	
	var uniqueNames = [];  //편의시설 정렬데이터
	
	var filter = { //필터 항목
			'minRate' : 0,
			'maxRate' : 0,		
		}
	
		
	//편의시설 그리기
	var fn_DetailCondition = function() {
		
		var valNm = []; //편의시설 리스트 
		
		var hotel_list = g_hotel_all_data;
		
		var night = 1;
		
		if(nullToBlank(sessionStorage.hotelViewData) != '' && sessionStorage.hotelViewData != '[]') {
			var viewData = JSON.parse(sessionStorage.hotelViewData);
			var dayArr = viewData.day.split("박");
			night = dayArr[0];
		}
			 	
		
		if(nullToBlank(hotel_list) != '' && hotel_list.length > 0) {
			for(var i=0; i < hotel_list.length; i++) { 
				var data = hotel_list[i];
				
				var hotelData = data.roomDetls[0];
				//익스피디어의 경우 프로트에서  일박요금 * 환율
				//var lowRate = (Math.ceil(parseFloat(hotelData.exchangeRate) * parseFloat(hotelData.jtbTotal)) * parseInt(night))  - 0; //가격
				var lowRate = Math.ceil(parseFloat(hotelData.jtbTotal))  - 0; //가격
				
				g_hotel_all_data[i].lowRate = lowRate;
				
				//필더리에 적용시킬 최대값 설정
				if(filter.maxRate < lowRate) {
					filter.maxRate = lowRate;
				}
				//필터링에 적용시킬 최소값 설정
				if(filter.minRate == 0 || filter.minRate > lowRate) {
					filter.minRate = lowRate;
				}
									
				var convenience = '';	
				var valueTitle = '';
				for(var m= 0; m < data.roomDetls[0].valAdds.length; m++) {
						
					if(('NO MEAL'.indexOf(data.roomDetls[0].valAdds[m].valueNm) > -1)
							|| ('NOMEAL'.indexOf(data.roomDetls[0].valAdds[m].valueNm) > -1)){
						data.roomDetls[0].valAdds[m].valueNm = '';
					}
					
					if('BF INC'.indexOf(data.roomDetls[0].valAdds[m].valueNm) > -1){
						data.roomDetls[0].valAdds[m].valueNm = '조식포함';
						//data.roomDetls[0].valAdds[m].valueId = '조식포함';
					}
					
					convenience = data.roomDetls[0].valAdds[m].valueNm;
					//console.log(">>>>>>>>>convenience" + convenience);
						
					if(convenience.indexOf("인터넷")>-1){
						valueTitle = "인터넷";
					}else if(convenience.indexOf("와이파이")>-1){
						valueTitle = "인터넷";
					}else if(convenience.indexOf("아침")>-1){
						valueTitle = "조식포함";
					}else if(convenience.indexOf("조식")>-1){
						valueTitle = "조식포함";
					}else if(convenience.indexOf("욕실")>-1){
						valueTitle = "욕실";
					}else if(convenience.indexOf("헤어드라이기")>-1){
						valueTitle = "객실 편의시설";
					}else if(convenience.indexOf("취사 도구 완비 주방")>-1){
						valueTitle = "객실 편의시설";
					}else if(convenience.indexOf("TV/케이블TV/영화")>-1){
						valueTitle = "객실 편의시설";
					}else if(convenience.indexOf("에어컨")>-1){
						valueTitle = "객실 편의시설";
					}else if(convenience.indexOf("전화기")>-1){
						valueTitle = "객실 편의시설";
					}else if(convenience.indexOf("미니바")>-1){
						valueTitle = "객실 편의시설";
					}else if(convenience.indexOf("소형냉장고")>-1){
						valueTitle = "객실 편의시설";
					}else if(convenience.indexOf("다리미")>-1){
						valueTitle = "객실 편의시설";
					}else if(convenience.indexOf("발코니")>-1){
						valueTitle = "객실 편의시설";
					}else if(convenience.indexOf("테라스")>-1){
						valueTitle = "객실 편의시설";
					}else if(convenience.indexOf("금고")>-1){
						valueTitle = "객실 편의시설";
					}else if(convenience.indexOf("커피")>-1){
						valueTitle = "객실 편의시설";
					}else if(convenience.indexOf("차")>-1){
						valueTitle = "객실 편의시설";
					}else if(convenience.indexOf("드링크")>-1){
						valueTitle = "객실 편의시설";
					}else if(convenience.indexOf("주차")>-1){
						valueTitle = "주차";
					}else if(convenience.indexOf("스파")>-1){
						valueTitle = "스파";
					}else if(convenience.indexOf("셔틀")>-1){
						valueTitle = "셔틀";
					}else if(convenience.indexOf("휠체어")>-1){
						valueTitle = "휠체어";
					}else if(convenience.indexOf("아기침대")>-1){
						valueTitle = "아기침대";
					}else if(convenience.indexOf("키친")>-1){
						valueTitle = "객실 편의시설";
					}else {
						valueTitle = convenience;
					} 
					valNm.push(valueTitle);
				}
			}
			//sorting
			valNm.sort();
			
			//중복 문자열 제거
			for(var k= 0; k < valNm.length; k++) {
				$.each(valNm, function(k, el){
					if($.inArray(el, uniqueNames) === -1) uniqueNames.push(el);
				});
			}
			//console.log(">>>>>>>>>uniqueNames=" + uniqueNames);	
		
			
			////편의시설 항목들 그리기 ///////
			 var vHtml = '';
			
			 vHtml +=" <dd id>"
			 vHtml +=" 	 <p class='chkbox'>"
			 vHtml +=" 		<span><input id='chk_if5_0' type='checkbox'	data-role='none' checked ='checked'  name='convenience' value='전체'/>"
			 vHtml +="   	</span> <label for='chk_if5_0'>전체</label>"
			 vHtml +="	 </p>"
			 vHtml +=" </dd>"
			 for(var j=0; j < uniqueNames.length; j++) {
				vHtml += " 	<dd> "
				vHtml += " 		<p class='chkbox'>"
				vHtml += "			<span><input id='chk_if5_" + (j+1) + "' type='checkbox'	data-role='none' name='convenience' value='" + uniqueNames[j] + "'/></span>"	
				vHtml += "			<label for='chk_if5_" + (j+1) + "'>" + uniqueNames[j] + "</label>"
				vHtml += "		</p>"
				vHtml += " 	</dd>"
				
				//console.log(">>>>>>>>>uniqueNames[" + j + "]=" + uniqueNames[j]);
			 	$('#convenience').html(vHtml);
			 } 
		}
		
		
		
		//편의시설 key 이벤트==============================================//
		//console.log("uniqueNames.length=" + uniqueNames.length);
		for(var m = 1; m <= uniqueNames.length;  m++) {
			var tag = "#chk_if5_" + m; 
			$(tag).on("click" , function() {
				//console.log("uniqueNames.length>>>>>>>>>>>>>>>>>>>");
			
				$("#chk_if5_0").prop("checked", false);
			});
		}
		
		$("#chk_if5_0").on("click" , function() {
			for(var n=1; n <= uniqueNames.length; n++) {
				var tag = "#chk_if5_" + n;
				$(tag).prop("checked", false);
			}
		});
		//============================================================//
	};
	
	
	//등급=====================================//
	for(var i = 1; i < 6;  i++) {
		var tag = "#chk_if2_" + i; 
		$(tag).on("click" , function() {
			$("#chk_if2_0").prop("checked", false);
		});
	}
	
	$("#chk_if2_0").on("click" , function() {
		for(var j=1; j < 6; j++) {
			var tag = "#chk_if2_" + j;
			$(tag).prop("checked", false);
		}
	});
	//======================================//
	
	//초기화
	var fn_initialize = function() {
		$('#hotel_srch').val("");
		$('#chk_if2_0').prop("checked", true);
		$('#chk_if5_0').prop("checked", true);
		
		for(var i=1; i < 6; i++) {
			var tag = "#chk_if2_" + i; 
			$(tag).removeAttr("checked");
		}
		for(var i = 1; i <= uniqueNames.length;  i++) {
			var tag = "#chk_if5_" + i; 
			$(tag).removeAttr("checked");
		}
	}
	
	
	//검색 결과 
	var fn_filterList = function() {
		
		var hotel_list = g_hotel_all_data;
		
		var l_gradeArr = [];
		var l_convenienceArr = [];
		var fix_data = [];
		var filterCnt = 0;
		var hotelName = $('#hotel_srch').val();
		
		var gradeGroup = $('input[name="grade"]');
		var convenienceGroup = $('input[name="convenience"]');
		var gradeAllChk = gradeGroup.eq(0).is(':checked');
		var convenienceAllChk = convenienceGroup.eq(0).is(':checked');  
		
		
		//등급 체크 정보
		if(!gradeAllChk){	//전체 체크일 경우 넘어간다.
			for(var idx=0; idx<gradeGroup.length; idx++) {
				if(gradeGroup.eq(idx).is(':checked')) {
					l_gradeArr.push(gradeGroup.eq(idx).val());	
				}		
			}
		}
		
		//편의시설
	 	if(!convenienceAllChk) {
			for(var idx=0; idx < convenienceGroup.length; idx++){
				if(convenienceGroup.eq(idx).is(':checked')) {
					l_convenienceArr.push(convenienceGroup.eq(idx).val());
				}
			}
		}  
		
		for(var i=0; i < hotel_list.length; i++) {
			
			var findSrch = true;	//검색
		
			var data = hotel_list[i];		
			
			//console.log(data.hotelNmKr);
		
			//호텔별 검색========================================================================//
			if(nullToBlank(hotelName) != '') {	
				if(!(data.hotelNmKr != null && data.hotelNmKr.indexOf(hotelName) > -1)
						&& !(data.hotelNmEn != null && data.hotelNmEn.toUpperCase().indexOf(hotelName.toUpperCase()) > -1)) {
					continue;
				} 
			}
			//================================================================================//
			
			
	 		//상세 별점 조회========================================================================//
	 		if(!gradeAllChk) {
				findSrch = false;
				var i_grade = Math.trunc(data.hotelRating) + '';
				
				for(var fi_idx=0; fi_idx<l_gradeArr.length; fi_idx++){
					
					if(l_gradeArr[fi_idx]==i_grade){
						findSrch = true;
						continue;
					}
				}
				if(!findSrch) {
					continue;
				}
			}
			//=================================================================================//
			
			
			//가격 점위에 따라 =========================================================================//
			var lowRate = g_hotel_all_data[i].lowRate;
			
			if(lowRate < filter.minRate || lowRate > filter.maxRate) {
				continue;
			}
			//===================================================================================//
			

			//편의 시설 검색===========================================================================//
			if(!convenienceAllChk) {  //전체가 아닌경우
				var convenienceVal = data.roomDetls[0].valAdds;
				
				findSrch = false;
				for(var k=0; k < l_convenienceArr.length; k++) {
					for(var idx= 0; idx < convenienceVal.length; idx++) {
						
						//console.log("convenienceVal[" + idx + "].valueNm = " + convenienceVal[idx].valueNm);
						 if(l_convenienceArr[k].indexOf("객실 편의시설") > -1 ) {
								if((convenienceVal[idx].valueNm.indexOf("헤어드라이기") > -1)
									|| (convenienceVal[idx].valueNm.indexOf("취사 도구 완비 주방") > -1)
									|| (convenienceVal[idx].valueNm.indexOf("TV/케이블TV/영화") > -1)
									|| (convenienceVal[idx].valueNm.indexOf("에어컨") > -1)
									|| (convenienceVal[idx].valueNm.indexOf("전화기") > -1)
									|| (convenienceVal[idx].valueNm.indexOf("미니바") > -1)
									|| (convenienceVal[idx].valueNm.indexOf("소형냉장고") > -1)
									|| (convenienceVal[idx].valueNm.indexOf("다리미") > -1)
									|| (convenienceVal[idx].valueNm.indexOf("발코니") > -1)
									|| (convenienceVal[idx].valueNm.indexOf("테라스") > -1)
									|| (convenienceVal[idx].valueNm.indexOf("금고") > -1)
									|| (convenienceVal[idx].valueNm.indexOf("커피") > -1)
									|| (convenienceVal[idx].valueNm.indexOf("차") > -1)
									|| (convenienceVal[idx].valueNm.indexOf("드링크") > -1)
									|| (convenienceVal[idx].valueNm.indexOf("키친") > -1)
									) {
																
									findSrch = true;
									continue;
								}
						} else { 
												
							if(convenienceVal[idx].valueNm.indexOf(l_convenienceArr[k]) > -1) {
								findSrch = true;
								continue;
							}
						}
					}
				}
				if(!findSrch) {
					continue;
				} 
			} 
		
			//====================================================================================//
		
			//filter된  데이터 담기
			fix_data.push(data);
			//console.log(fix_data);
			
		}
		//==========================================================================================
 
		if(fix_data.length > 0) {
			for(var j=0; j < fix_data.length; j++) {
				//filter data
				g_hotel_fix_data.push(fix_data[j]);
			} 
		} 
		

		//필터링된 데이터 그리기 
		fn_detailSrch();
		
		var filterData = {
			'hotelNm' : hotelName,
			'grade' : l_gradeArr,
			'price' : {
				'from' : filter.minRate,
				'to'   : filter.maxRate 
			},
			'convenience' : l_convenienceArr
		};
		
		//설정저장
		sessionStorage.filterViewData = JSON.stringify(filterData);
		
		fix_data = [];
		g_hotel_fix_data = [];
	}; 
	
	
	//적용
	var fn_Apply = function() {
		fn_filterList();
		closePopup();
	}
	
	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};             
	}
	
	
	var fn_ready = function() {
		alert("서비스 준비중입니다.");
		return false;
	}

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();
		
		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
		
		$('#hotel_srch').on('keydown', function(e) {
			
			console.log(e.keyCode);
			if(e.keyCode == 13) { //엔터키
				return false;
			}
		
		});	
		
		//자옫완성
		$('#hotel_srch').on('keyup' , function(e) {
			var search = $('#hotel_srch').val();
			var autocomplete = $('#autocomplete');
			//console.log(search);
			
			if(search == '') {
				autocomplete.val('');
				autocomplete.hide();
			} else {
				autocomplete.show();
				fn_HotelSrchResult(autocomplete, search);	
			}
			
		});
		
   });
	
	
   function fn_HotelSrchResult(autocomplete, word) {
	   
	  autocomplete.innerHtml = '';
	   
	  console.log("g_hotel_all_data.length=" + g_hotel_all_data.length);
	   
	  var vHtml = '';
	  for(var i=0; i < g_hotel_all_data.length; i++) {
		 
			if(!(g_hotel_all_data[i].hotelNmKr.indexOf(word) > -1) 
					&& !(g_hotel_all_data[i].hotelNmEn.toUpperCase().indexOf(word.toUpperCase()) > -1)) 	{
		   		continue;
			}
			
			vHtml += "<div onclick='selectData(this)'>" + g_hotel_all_data[i].hotelNmKr + "</div>";
	   }
	   autocomplete.html(vHtml);
   }
	
   function selectData(that) {
	    var search = $('#hotel_srch');
		var autocomplete = $('#autocomplete');
		
		search.value = that.innerText;
		$('#hotel_srch').val(that.innerText);
		autocomplete.val('');
		autocomplete.hide();
   }
   
   
	var saveResult = function(data){
		//console.log(">>>>>>minRate",data.from);
		//console.log(">>>>>>maxRate",data.to);
		filter.minRate = data.from;
		filter.maxRate = data.to;
	}
	
	var l_step = Math.ceil((filter.maxRate - filter.minRate) / 9);
	jQuery(function() {
	 	 jQuery("#range").ionRangeSlider({
			type : "double",
			min : filter.minRate,
			max : filter.maxRate,
			from : filter.minRate,
			to : filter.maxRate,
			step : l_step,
			hide_min_max : true,
			hide_from_to : false,
			grid : false,
			onLoad : function(data) {
				saveResult(data); 
			},
	 	 	onChange : saveResult,
	 	 	onFinish : saveResult
			
		}); 
		jQuery("#range2").ionRangeSlider({
			type : "double",
			min : 1000,
			max : 9000000,
			from : 1000000,
			to : 8000000,
			step : 10000,
			hide_min_max : true,
			hide_from_to : false,
			grid : false
		});
		
		
		
	});

</script>
<div class="layerPopup">
	<div class="layerPop bgwhite">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">상세조건</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain pop_ht_box">
				<ul class="tablist_com pop_ht_dttab" data-ctn="ht_dt_pop">
					<dl class="pop_chk_list pcltop1">
						<dt>호텔명</dt>
					</dl>
					<!-- <li class="active"><button type="button" data-role="none">호텔명</button></li> -->
					<!-- <li><button type="button" data-role="none" onclick="fn_ready();">랜드마크</button></li> -->
				</ul>
				<div class="tabctn_com ht_dt_pop ht_dt_pop1 ps_view">
					 
					<div class="fs_search">
						<div class="csbox">
							<form name="" method="#">
								<fieldset>
									<legend>검색폼</legend>
									<input type="text" data-role="none" placeholder="호텔명 검색"  id="hotel_srch" onclick="fn_filterList()">
									<button type="button"  data-role="none"onclick="fn_filterList()">검색</button>
								</fieldset>
							</form>
						</div>
						<div class='auto_sck_box' ft-att='autocomplete' id='autocomplete' name='autocomplete' style="display:none">
					
						</div>
					</div>
			 
							<!-- 검색결과 -->
					<!-- <dl class="pop_chk_list pclend1" id="search_result">
						<dt>검색결과</dt>
						 
						<dd>
							<p class="chkbox">
								<span><input id="chk_if1_1" type="checkbox"
									data-role="none" /></span> <label for="chk_if1_1">브루클린 브리지</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if1_2" type="checkbox"
									data-role="none" /></span> <label for="chk_if1_2">블루밍데일스</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if1_3" type="checkbox"
									data-role="none" /></span> <label for="chk_if1_3">프레임즈 볼링 라운지
									라운지</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if1_4" type="checkbox"
									data-role="none" /></span> <label for="chk_if1_4">게스트하우스(10)</label>
							</p>
						</dd> 
					</dl> -->
					<!-- 숙박시설등급 -->
					<dl class="pop_chk_list pcltop1">
						<dt>숙박시설등급</dt>
						
						<dd>
							<p class="chkbox">
								<span><input id="chk_if2_0" type="checkbox" value='6'
									data-role="none"  name="grade" checked='checked'/></span> <label for="chk_if2_0">
									<span style="width:100%;line-height:22px;">전체</span> 
								</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if2_1" type="checkbox" value='5'
									data-role="none" name="grade"/></span> <label for="chk_if2_1"> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span>
								</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if2_2" type="checkbox" value='4'
									data-role="none" name="grade" /></span> <label for="chk_if2_2"> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
								</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if2_3" type="checkbox" value='3'
									data-role="none" name="grade" /></span> <label for="chk_if2_3"> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
									<span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
								</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if2_4" type="checkbox" value='2'
									data-role="none"  name="grade" /></span> <label for="chk_if2_4"> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
									<span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
									<span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
								</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if2_5" type="checkbox" value='1'
									data-role="none"  name="grade"/></span> <label for="chk_if2_5"> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
									<span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
									<span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
									<span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
								</label>
							</p>
						</dd>
					</dl>
					<!-- 가격 -->
					<dl class="pop_chk_list pop_chk_list2">
						<dt>가격</dt>
						<dd>
							<div class="pop_range">
							<input type="text" id="range" value="" name="range" />
							</div>
						</dd>
					</dl>
					<!-- 숙박시설유형 -->
					<!-- <dl class="pop_chk_list">
						<dt>숙박시설유형</dt>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if3_1" type="checkbox"
									data-role="none" /></span> <label for="chk_if3_1">호텔(1234)</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if3_2" type="checkbox"
									data-role="none" /></span> <label for="chk_if3_2">호텔/백패커(200)</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if3_3" type="checkbox"
									data-role="none" /></span> <label for="chk_if3_3">아파트식
									호텔(144)</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if3_4" type="checkbox"
									data-role="none" /></span> <label for="chk_if3_4">게스트하우스(10)</label>
							</p>
						</dd>

						<dd>
							<p class="chkbox">
								<span><input id="chk_if3_5" type="checkbox"
									data-role="none" /></span> <label for="chk_if3_5">호텔 리조트(10)</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if3_6" type="checkbox"
									data-role="none" /></span> <label for="chk_if3_6">B&B(9)</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if3_7" type="checkbox"
									data-role="none" /></span> <label for="chk_if3_7">여관/인(5)</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if3_8" type="checkbox"
									data-role="none" /></span> <label for="chk_if3_8">모텔(50)</label>
							</p>
						</dd>
					</dl> -->
					<!-- 주요지역/전시장 -->
					<!-- <dl class="pop_chk_list pop_chk_list2">
						<dt>주요지역/전시장</dt>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if4_1" type="checkbox"
									data-role="none" /></span> <label for="chk_if4_1">방콕 수완나폼 공항</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if4_2" type="checkbox"
									data-role="none" /></span> <label for="chk_if4_2">방콕 수쿱빗</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if4_3" type="checkbox"
									data-role="none" /></span> <label for="chk_if4_3">방콕 씨암</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if4_4" type="checkbox"
									data-role="none" /></span> <label for="chk_if4_4">방콕 한국대사관</label>
							</p>
						</dd>

						<dd>
							<p class="chkbox">
								<span><input id="chk_if4_5" type="checkbox"
									data-role="none" /></span> <label for="chk_if4_5">방콕 국제무역
									전시센터</label>
							</p>
						</dd>
					</dl> -->
					<!-- 편의시설 -->
					<dl class="pop_chk_list">
						<dt>편의시설</dt>
						<div id = "convenience">
							<!-- 
							<dd>
								<p class="chkbox">
									<span><input id="chk_if5_0" type="checkbox"
										data-role="none" checked ="checked" value="전체"/></span> <label for="chk_if5_0">전체</label>
								</p>
							</dd>
							 <dd>
								<p class="chkbox">
									<span><input id="chk_if5_1" type="checkbox"
										data-role="none" value="무료 주차"/></span> <label for="chk_if5_1">무료 주차</label>
								</p>
							</dd>
							<dd>
								<p class="chkbox">
									<span><input id="chk_if5_2" type="checkbox"
										data-role="none" value="무료 무선 인터넷"/></span> <label for="chk_if5_2">무료 무선 인터넷</label>
								</p>
							</dd>
							<dd>
								<p class="chkbox">
									<span><input id="chk_if5_3" type="checkbox"
										data-role="none" value="뷔페 아침 식사"/></span> <label for="chk_if5_3">뷔페 아침 식사</label>
								</p>
							</dd>
							<dd>
								<p class="chkbox">
									<span><input id="chk_if5_4" type="checkbox"
										data-role="none" value="무료 초고속 인터넷"/></span> <label for="chk_if5_4">무료 초고속 인터넷</label>
								</p>
							</dd> -->
						</div>
					</dl>
				</div>
				<div class="tabctn_com ht_dt_pop ht_dt_pop2">
					<div class="fs_search">
						<div class="csbox">
							<form name="" method="#">
								<fieldset>
									<legend>검색폼</legend>
									<input type="text" data-role="none" placeholder="랜드마크 검색">
									<button type="button" data-role="none">검색</button>
								</fieldset>
							</form>
						</div>
					</div>
					<!-- 검색결과 -->
					<!-- <dl class="pop_chk_list pclend1">
						<dt>검색결과</dt>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if6_1" type="checkbox"
									data-role="none" /></span> <label for="chk_if6_1">브루클린 브리지</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if6_2" type="checkbox"
									data-role="none" /></span> <label for="chk_if6_2">블루밍데일스</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if6_3" type="checkbox"
									data-role="none" /></span> <label for="chk_if6_3">프레임즈 볼링 라운지</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if6_4" type="checkbox"
									data-role="none" /></span> <label for="chk_if6_4">게스트하우스(10)</label>
							</p>
						</dd>
					</dl> -->
					<!-- 숙박시설등급 -->
					<dl class="pop_chk_list pcltop1">
						<dt>숙박시설등급</dt>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if7_1" type="checkbox"
									data-role="none" /></span> <label for="chk_if7_1"> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span>
								</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if7_2" type="checkbox"
									data-role="none" /></span> <label for="chk_if7_2"> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
								</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if7_3" type="checkbox"
									data-role="none" /></span> <label for="chk_if7_3"> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
									<span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
								</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if7_4" type="checkbox"
									data-role="none" /></span> <label for="chk_if7_4"> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
									<span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
									<span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
								</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if7_5" type="checkbox"
									data-role="none" /></span> <label for="chk_if7_5"> <span><img
										src="/resources/images/ico/ico_yellow_star.png" alt="" /></span> <span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
									<span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
									<span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
									<span><img
										src="/resources/images/ico/ico_yellow_staroff.png" alt="" /></span>
								</label>
							</p>
						</dd>
					</dl>
					<!-- 가격 -->
					<dl class="pop_chk_list pop_chk_list2">
						<dt>가격</dt>
						<dd>
							<div class="pop_range">
								<input type="text" id="range2" value="" name="range" />
							</div>
						</dd>
					</dl>
					<!-- 숙박시설유형 -->
					<!-- <dl class="pop_chk_list">
						<dt>숙박시설유형</dt>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if8_1" type="checkbox"
									data-role="none" /></span> <label for="chk_if8_1">호텔(1234)</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if8_2" type="checkbox"
									data-role="none" /></span> <label for="chk_if8_2">호텔/백패커(200)</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if8_3" type="checkbox"
									data-role="none" /></span> <label for="chk_if8_3">아파트식
									호텔(144)</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if8_4" type="checkbox"
									data-role="none" /></span> <label for="chk_if8_4">게스트하우스(10)</label>
							</p>
						</dd>

						<dd>
							<p class="chkbox">
								<span><input id="chk_if8_5" type="checkbox"
									data-role="none" /></span> <label for="chk_if8_5">호텔 리조트(10)</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if8_6" type="checkbox"
									data-role="none" /></span> <label for="chk_if8_6">B&B(9)</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if8_7" type="checkbox"
									data-role="none" /></span> <label for="chk_if8_7">여관/인(5)</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if8_8" type="checkbox"
									data-role="none" /></span> <label for="chk_if8_8">모텔(50)</label>
							</p>
						</dd>
					</dl> -->
					<!-- 주요지역/전시장 -->
					<!-- <dl class="pop_chk_list pop_chk_list2">
						<dt>주요지역/전시장</dt>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if9_1" type="checkbox"
									data-role="none" /></span> <label for="chk_if9_1">방콕 수완나폼 공항</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if9_2" type="checkbox"
									data-role="none" /></span> <label for="chk_if9_2">방콕 수쿱빗</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if9_3" type="checkbox"
									data-role="none" /></span> <label for="chk_if9_3">방콕 씨암</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if10_4" type="checkbox"
									data-role="none" /></span> <label for="chk_if10_4">방콕 한국대사관</label>
							</p>
						</dd>

						<dd>
							<p class="chkbox">
								<span><input id="chk_if10_5" type="checkbox"
									data-role="none" /></span> <label for="chk_if10_5">방콕 국제무역
									전시센터</label>
							</p>
						</dd>
					</dl> -->
					<!-- 편의시설 -->
					<dl class="pop_chk_list">
						<dt>편의시설</dt>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if11_0" type="checkbox"
									data-role="none" /></span> <label for="chk_if11_0">전체</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if11_1" type="checkbox"
									data-role="none" /></span> <label for="chk_if11_1">무료 주차</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if11_2" type="checkbox"
									data-role="none" /></span> <label for="chk_if11_2">무료 무선 인터넷</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if11_3" type="checkbox"
									data-role="none" /></span> <label for="chk_if11_3">뷔페 아침 식사</label>
							</p>
						</dd>
						<dd>
							<p class="chkbox">
								<span><input id="chk_if11_4" type="checkbox"
									data-role="none" /></span> <label for="chk_if11_4">무료 초고속 인터넷</label>
							</p>
						</dd>
					</dl>
				</div>
			</div>
		</div>
		<!-- 내용끝 -->
		<div class="popFoot pf2">
			<div class="layerBtns">
				<button type="button" class="layerClose1" onclick="fn_initialize();">초기화</button>
			</div>
			<div class="layerBtns">
				<button type="button" class="layerClose2" onclick="fn_Apply();">적용</button>
			</div>
		</div>
	</div>
</div>