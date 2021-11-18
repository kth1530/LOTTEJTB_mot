
//var g_hotel_all_data = [];		//전체 리스트
//var g_hotel_sort_data = [];		//정렬 후 리스트
var g_hotel_fix_data = [];		//필터링 후 리스트
var g_hotel_data = [];
var g_hotel_room_data = [];   //호텔 룸정보
var g_hotel_info_data = [];   //호텔 info정보
var g_hotel_basket_data = [];  //호텔 장바구니
var g_hotel_promo = [];
var g_hotel_map_data = [];

var g_filter_var = {			//필터링 항목
	"maxRate" 		: 0
	, "minRate" 	: 0
	, "convenience"	: []	
};
var g_filter_info = {		//현재 적용 중인 필터링 정보
	"fil_via_type" : []
	, "fil_class_type" : []
	, "fil_hotel_line" : []
	, "fil_dep_tm" : []
	, "fil_fare_type" : []
};
var g_hotel_all_data;
var hotel_sort_data;
var hotel_fix_data;
var hotel_rc_data;

var pageSize = 10;  //페이지 갯수
var hotelListCnt = 0; //호텔 list갯수
var e_cnt = 10;	//출력개수

$(document).ready(function(){
	set_init();
});

function set_init() {	
}


//도시검색 입력 시 
function fn_htl_search(domesticYn){
	var _val = $('#cityPopInput').val();
	var _obj = $('#cityPopInput');
	
	if(_val == null) _val = "";
	var ek = event.keyCode;
	
	if(_val != '') {	//공란의 경우 return
		var lastword = _val.substring(_val.length-1).replace(/%/gi,"\\");	//유니코드로 변환
		if('\u3130' < lastword && lastword < '\u3164'){	//마지막 값이 자음이나 모음일 경우 return
			return;
		} else {
			setTimeout(function(){
				fn_htl_searchCity(_val, _obj, domesticYn);
			}, 500);		
		}
	} else {
		setTimeout(function(){
			if($(_obj).val() == ''){	//입력값 삭제 후 .5초 유지되면 검색 리스트 감춤
				$('div[ft-att="resultSearch"]').children('ul').remove();
			}
		}, 500);
	}
}

function fn_htl_searchCity(_val, _obj, domesticYn){
	var nowVal = $("#cityPopInput").val();
	if(nowVal == null) nowVal = "";
	
	if(nowVal == _val){	// 입력 .5초후 값과 비교
		gfn_callAjax ('/fit/htl/hotelCityL.do', {'searchVal' : nowVal.toUpperCase(), 'domesticYn' : domesticYn}, 'fn_search_htl_city', true);
	} else {
		clearTimeout();
	}
}

function fn_search_htl_city(_data){
	var boxDiv = $('div[ft-att="resultSearch"]');
	var intext = $("#cityPopInput").val().toUpperCase();
	
	
	
	if(_data.cityList.length > 0){
		var boxUl = $('<ul></ul>');
		var reData = _data.cityList;
		
		$(".fs_search .search_nowkey").show();
		
		for(var r_idx=0; r_idx<reData.length; r_idx++) {
			
			var region = reData[r_idx].regionNmEn;
			var countryNm = reData[r_idx].countryNm;
			
			if(nullToBlank(region) == '')  region ='';
			else region = ' - ' + reData[r_idx].regionNmEn;
			
			if(nullToBlank(countryNm) == '')  countryNm ='';
			else countryNm = ' - ' + reData[r_idx].countryNm;
			
			var viewNm = reData[r_idx].cityNmKr + region + countryNm; 
			//var funcNm = "javascript:selectCityList('" +reData[r_idx].cityId+ "','" + reData[r_idx].cityNmKr +"("+ reData[r_idx].countryNm +")" + "', '"+ reData[r_idx].countryCd +"')";
			var funcNm = "javascript:selectCityList('" +reData[r_idx].cityId+ "','"+ reData[r_idx].cityNmEn + "','" + reData[r_idx].cityNmKr + "', '"+ reData[r_idx].countryCd +"')";
			
			var searchLi = $("<li onclick=\""+ funcNm +"\" ft-data='" + reData[r_idx].city + "'>" + viewNm.replace(intext, "<span class='f_red'>"+intext+"</span>") + "</li>");
			boxUl.append(searchLi);
		}

		boxDiv.html(boxUl);

		$(".fs_search").trigger("create").refresh();

		jQuery(".fs_search .search_nowkey").show();
	} else {

		// boxDiv.html('<ul><li>검색 결과가 없습니다.</li></ul><p class="snkclose">닫기</p>').trigger("create");
		boxDiv.html('<ul><li>검색 결과가 없습니다.</li></ul>').trigger("create");
		$(".fs_search").trigger("create").refresh();		
		jQuery(".fs_search .search_nowkey").show();
	}
}

// 달력 선택 이벤트	
function fn_setHotelDate(_obj) {
	var thisNm = $(_obj).attr('name');
	
	var checkInDate = $('.calendar[name="checkIn"]').val();
	var checkIOutDate = $('.calendar[name="checkOut"]').val();
	
	if(checkInDate != '' && checkIOutDate != '') {
		var ddInterval = calcInterval(checkInDate.replace(/-/g, ''), '0000', checkIOutDate.replace(/-/g, ''), '0000').split(',')[0];

		fn_setDateCntSet(ddInterval);	
	}		
	
	if(thisNm == 'checkIn') {
		// 체크인 변경 시
		var setDate = gfn_addDay(checkInDate, 1);
		
		$('.calendar[name="checkOut"]').datepicker('option', 'minDate', setDate);
		
		setTimeout(function(){
			if($('.calendar[name="checkOut"]').val() == '') {
				$('.calendar[name="checkOut"]').trigger('focus');
			}
		}, 0);
	}
}

// 박수 조절
function fn_setDateCntSet(_interval) {
	_interval = _interval-0;
	if(_interval < 0) {
		$('.calendar[name="checkOut"]').val('');
	} else {
		if(_interval > 30) {
			$('select[name="dateCnt"] option').eq(30).prop('selected', true).val(_interval);
		} else {
			$('select[name="dateCnt"] option[value="' + _interval + '"]').prop('selected', true);
		}
	}
}

//필러팅 checkbox 클릭 동작 설정
function fn_act_filter() {
	//전체 체크 처리(전체 클릭 시 하위 체크해제 | 하위 체크 시 전체 체크해제)
	if(this.value == 'ALL'){
		if(this.checked) {
			$('input:checkbox[ar_att="filter_chk"][name="' + this.name + '"]').prop('checked', false);
			$(this).prop('checked', true);
		} else{
			//전체 체크 해제 시 동작 취소
			return false;
		}
	} else {
		if(this.checked) {
			$('input:checkbox[ar_att="filter_chk"][name="' + this.name + '"][value="ALL"]').prop('checked', false);
		} else{
			var checkarr = $('input:checkbox[ar_att="filter_chk"][name="' + this.name + '"]');
			var checkedYn = false;
			 
			for(var ch_idx=0; ch_idx<checkarr.length; ch_idx++) {
				if(checkarr[ch_idx].checked) {
					checkedYn = true;
					break;
				}
			}
			
			if(!checkedYn) {
				$('input:checkbox[ar_att="filter_chk"][name="' + this.name + '"][value="ALL"]').prop('checked', true);
			}
		}
	}
	filterHotelList();
}

//도시검색 팝업 선택 
function selHotelCity() {
	var setDiv = $('div#hotel_search_div div.input_search');
	
	//도시이름
	var setNm = $(this).text().split(' (')[0];	// 도시 이름만 짤라서 입력  ex)인천(ICN) - 대한민국 
	setDiv.find('input[name="searchCtDis"]').val(setNm);
	
	//국가코드
	setDiv.find('input[name="searchCountry"]').val($(this).attr('country-data'));
	
	//도시코드
	setDiv.find('input[name="searchCity"]').val($(this).attr('city-data'));
	
	//도시명 - 코드로 사용 되는 듯 하다
	setDiv.find('input[name="searchCityNm"]').val($(this).attr('city-name'));
	
	
	uijs.hide($(this).parents('[ft-att="sel_city_pop"]').attr('pop-id'));
}

// 도시검색 입력 시 
function fn_hotel_search_input(){
	var _val = $(this).val();
	var _obj = this;
	var ek = event.keyCode;
	if((ek > 64 && ek < 91) || ek == 8) {	//글자나 백스페이스일 경우
		if(_val != '') {	//공란이 아닌 경우
			var lastword = _val.substring(_val.length-1).replace(/%/gi,"\\");	//유니코드로 변환
			if('\u3130' < lastword && lastword < '\u3164'){	//마지막 값이 자음이나 모음일 경우 return
				return;
			} else {
				setTimeout(function(){
					fn_searchHotelCity(_val, _obj);
				}, 500);		
			}
		} else {
			setTimeout(function(){
				if($(_obj).val() == ''){	//입력값 삭제 후 0.5초 유지되면 검색 리스트 감춤
					$('div[ft-att="resultSearch"]').children('ul').remove();
				}
			}, 500);
		}
	} else if (ek == 40) {	// ↓방향키 클릭 시 리스트로 focus 이동
		var boxDivUl = $('div[ft-att="resultSearch"]').children('ul');
		if(boxDivUl.find('a').length > 0 ) {
			boxDivUl.find('a').eq(0).trigger('focus');
		}
	}
}

// 도시검색 DB 조회
function fn_searchHotelCity(_val, _obj){
	var nowVal = $(_obj).val();
	
	if(nowVal == _val){	// 입력 .5초후 값과 비교
		gfn_callAjax ('/fit/htl/hotelCityL.do', {'searchVal' : nowVal.toUpperCase()}, 'fn_search_hotel_city', true);
	} else {
		clearTimeout();
	}
}

//도시검색 결과리스트 생성
function fn_search_hotel_city(_data) {
	
	var boxDiv = $('div[ft-att="resultSearch"]');
	if(_data.cityList.length > 0){
		var boxUl = $('<ul></ul>');
		var reData = _data.cityList;
		for(var r_idx=0; r_idx<reData.length; r_idx++) {
			var viewNm = reData[r_idx].cityNm + ' - ' + reData[r_idx].countryNm; 
			var searchLi = $('<li><a href="javascript:void(0);" city-name="' + reData[r_idx].cityNm + '" city-data="' + reData[r_idx].cityCd + '" country-data="' + reData[r_idx].countryCd + '">' + viewNm + '</a></li>');
			boxUl.append(searchLi);
		}
		boxDiv.html(boxUl);
		
		boxDiv.find('a').on('click', selHotelCity)
						.css('cursor', 'pointer')
						.on('keydown', mvHotelCityList);
		
		boxDiv.show();
	} else {
		boxDiv.html('<ul><li>검색 결과가 없습니다.</li></ul>');
		boxDiv.show();
	}
}

// 도시검색 키보드 컨트롤 - 미완성	 포커스 스타일 줄것
function mvHotelCityList(){
	var ek = event.keyCode;
	
	var parentLi = $(this).parent();
	if (ek == 40) {
		if (parentLi.next().children('a').length > 0) {
			parentLi.next().children('a').trigger('focus');
		}
		return false;
	}

	if (ek == 38) {
		if (parentLi.prev().children('a').length > 0) {
			parentLi.prev().children('a').trigger('focus');
		} else {
			$('#cityPopInput').trigger('focus');
		}
		return false;
	}
	
	if (ek == 27) {
		$('#cityPopInput').trigger('focus');
		$('div[ft-att="resultSearch"]').children('ul').remove();
	}
}

//객실 타입,인원 입력칸 조절
function fn_setRoomInput(_cnt) {
	var inputList = $('div[ft-att="roomInputDiv"]').find('dl[ft-att="roomInput"]');
	
	var nowInputCnt = inputList.length;
	var calGap = _cnt - nowInputCnt;
	
	if(calGap > 0) {
		//그려줌
		for(var aval=nowInputCnt;aval < _cnt; aval++ ) {
			var input_box = $('[ft-att="roomInput_tmp"]:first').clone().show().attr('ft-att', 'roomInput');
			input_box.children('dt').text('객실' + (aval+1));
			
			$('div[ft-att="roomInputDiv"]').append(input_box);
			
		}
	} else if (calGap < 0) {
		//지워줌
		for(var dval=nowInputCnt;dval > _cnt; dval-- ) {
			inputList.eq(dval-1).remove();	
		}
	}
}

//아동 나이 입력란 개수 조절
function fn_setChdAge(_obj) {
	var parentDl = $(_obj).parents('dl[ft-att="roomInput"]');
	
	var setCnt = $(_obj).val();
	
	var ageSelBox = parentDl.find('dd[ft-att="chdAgeDiv"]');
	var nowCnt = ageSelBox.length;
	
	var calGap = setCnt - nowCnt;
	
	if(calGap > 0) {
		//그려줌
		for(var aval=nowCnt;aval < setCnt; aval++ ) {
			var input_box = parentDl.find('dd[ft-att="chdAgeDiv_tmp"]:first').clone().show().attr('ft-att', 'chdAgeDiv');
			input_box.children('select[name="chdAge_tmp"]').attr('name', 'chdAge');
			parentDl.append(input_box);
			
		}
	} else if (calGap < 0) {
		//지워줌
		for(var dval=nowCnt;dval > setCnt; dval-- ) {
			ageSelBox.eq(dval-1).remove();	
		}
	}
}

//리스트 재검색
//function search_hotel_line() {
//	
//	if(fn_set_hotel_search_value()){
//		//필터링 항목 초기화	-	미완성 (정의되지 않음)
//		filter_var = {			//필터링 항목
//			"drtCnt" : 0
//			, "via1Cnt" : 0
//			, "via2Cnt" : 0
//			, "hotellineData" : []
//			, "cabinClasData" : []	
//		};
//		filter_info = {		//현재 적용 중인 필터링 정보
//			"fil_via_type" : []
//			, "fil_class_type" : []
//			, "fil_hotel_line" : []
//			, "fil_dep_tm" : []
//			, "fil_fare_type" : []
//		};
//		
//	   // $('p[ft-att="searchCnt"]').html('선택하신 호텔 검색결과 총 <b id="totCnt"></b>건이 검색 되었습니다.');
//	    
//		//임시
//		gfn_callAjax ('/fit/htl/listSearchAjax.do', JSON.parse(sessionStorage.hotelSearchVal).bodyDto, 'successPro');
//	}
//}

function fn_reSrchData() {
	if(sessionStorage.hotelViewData != undefined
			&& JSON.parse(sessionStorage.hotelViewData) != undefined) {
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
	}
	
}

//호텔 재검색
function fn_HotelResearch() {
	
	fn_confixChkDate();
	
	if(fn_set_hotel_search_value()) {
		fn_hotel_research(JSON.parse(sessionStorage.hotelSearchVal));
		$('.re_search_close').click();
	}
	fn_reSrchData();
	
}

//항공 호텔 조합인경우 유효성 체크
function fn_confixChkDate() {
	
	var hotel_div = $('#hotel_search_div');
	//항공 호텔 조합시 날짜 자동 변경 유효성 체크
	
	if(nullToBlank(sessionStorage.airSelData) != '' && sessionStorage.airSelData != '[]') { 
		
		var l_airSelData = JSON.parse(sessionStorage.airSelData);
		
		var checkIn = hotel_div.find('#dep_dt').text();
		var checkOut = hotel_div.find('#arr_dt').text();
		
		if(nullToBlank(l_airSelData[0]) != '') {
			if(l_airSelData[0].hasOwnProperty('gdsCd')){	//항공 선택이 되어있을 경우
				
				var air_sdate = l_airSelData[0].fltData[0].arrDt;
				
				var e_ahInterval = calcInterval2(air_sdate, '0000', checkIn, '0000').split(',');
				if((e_ahInterval[0]-0) < 0){
					alert('체크인 날짜가 항공 도착일보다 빠릅니다.\n체크인 날짜를 ' + air_sdate + '로 변경하여 검색합니다.');
					air_sdate = air_sdate.substring(0,4) + "." + air_sdate.substring(4,6) + "." + air_sdate.substring(6);
					hotel_div.find('#dep_dt').text(air_sdate);
				}	
			
				if(l_airSelData[0].availTy == 'RT'){
					var air_edate = l_airSelData[0].fltData[1].depDt;
					var e_eInterval = calcInterval2(checkOut, '0000', air_edate, '0000').split(',');
					
					if((e_eInterval[0]-0) < 0){
						alert('체크아웃 날짜가 항공 귀국일보다 늦습니다.\n체크아웃 날짜를 ' + air_edate + '로 변경하여 검색합니다.');
						air_edate = air_edate.substring(0,4) + "." + air_edate.substring(4,6) + "." + air_edate.substring(6);
						hotel_div.find('#arr_dt').text(air_edate); 
					}
				}						
			}
		}
	}
}


//검색값 세팅
function fn_set_hotel_search_value() {
	
	
	//console.log("fn_set_hotel_search_value~~~~~~~~~~");
	
	var hotel_div = $('#hotel_search_div');
	var cityDisplay = hotel_div.find('#srch_arr_ct_dis');
	var cityCode = hotel_div.find('#searchCity');
	var city = hotel_div.find('#srch_arr_ct_dis');
	var countryCode = hotel_div.find('#searchCountry');
	var checkInDate = hotel_div.find('#dep_dt');
	var checkOutDate = hotel_div.find('#arr_dt');
	var srch_night_days = hotel_div.find('#srch_night_days');
	var countryNm = hotel_div.find('#searchCityNm');
	var countryNmEn = hotel_div.find('#searchCityNmEn');
	
	
	try {
		var countryNmEnArr = countryNmEn.val().split('(');
		if(countryNmEnArr.length == 1) countryNmEnVal = countryNmEnArr[0];
		else {
			var countryNmEnArr1 = countryNmEnArr[1].split(')');
			console.log(countryNmEnArr1[0]);
			var countryNmEnVal = countryNmEnArr1[0];
		}
	
		//console.log(countryNmVal);
				
	} catch(e) {
		console.log(e);
	}
	
		
	if(city.val()== '') {
		alert('도시를 선택해주세요.');
		city.focus();
		return false;
	}

	if(checkInDate.text() == '') {
		alert('체크인 날짜를 선택해주세요.');
		checkInDate.focus();
		return false;
	}

	if(checkOutDate.text() == '' || checkOutDate.text() == '미지정' ) {
		alert('체크아웃 날짜를 선택해주세요.');
		checkOutDate.focus();
		return false;
	}
	
	
	var numberOfAdultsVal = "";
	var numberOfChildrenVal ="";
	var childAgeVal         = "";
	var childAgeValGubun    = "";
	var selSeatVal          ="1인실";
	
	var numberOfAdultsVal ="";
	var numberOfChidernVal = "";
	
	var roomCnt =1;
	
	var roomShowCnt = 1;
	var roomCont = [];
	
	//객실 갯수
	for(var j=1; j < 10; j++) {
		var tag = ".hotal_clone" + j;
		if(jQuery(hotel_div.find(tag)).css("display") == 'block') {
			roomShowCnt++;
			//console.log("roomShowCnt=" + roomShowCnt);
		}
	}
		
	
	//console.log(">>>roomShowCnt=<<<" + roomShowCnt);
	for(var i=0; i < roomShowCnt-1; i++) {
		var tag = ".hotal_clone" + (i+1);
		var selSeat = "seat_" + (i+1);   //좌석 value 
		var adultCnt = '';
		var childCnt = '';
		//console.log("tag=" + tag);
		childAgeVal = '';
		
		if(jQuery(hotel_div.find(tag)).css("display") == 'block'){	
			
			adultCnt = "#ps_ad_cunt_" + (i+1);
			numberOfAdultsVal = hotel_div.find(adultCnt).text();
		
			childCnt = "#ps_ch_cunt_" + (i+1);
			numberOfChidernVal = hotel_div.find(childCnt).text();
			
			if(numberOfAdultsVal == '0') {
				alert('성인수를 지정해주세요');
				hotel_div.find(adultCnt).focus();
				return false;
			}
			// 객실 타입별 인원수 제한 
			if(hotel_div.find("select[name=" + selSeat + "] option:selected").val() == '01'
				&& parseInt(numberOfAdultsVal) > 1) {
				alert('1인(싱글)실에는 성인 1명만 이용하실 수 있습니다.');
				hotel_div.find(adultCnt).focus();
				return false;
			} else if(hotel_div.find("select[name=" + selSeat + "] option:selected").val() == '02'
				&& (parseInt(numberOfAdultsVal)+parseInt(numberOfChidernVal)) > 2) {
				alert('2인(더블, 트윈)실에는 2명까지만 이용하실 수 있습니다.');
				hotel_div.find(adultCnt).focus();
				return false;
			} else if(hotel_div.find("select[name=" + selSeat + "] option:selected").val() == '03'
				&& (parseInt(numberOfAdultsVal)+parseInt(numberOfChidernVal)) > 2) {
				alert('2인(더블, 트윈)실에는 2명까지만 이용하실 수 있습니다.');
				hotel_div.find(adultCnt).focus();
				return false;
			} else if(hotel_div.find("select[name=" + selSeat + "] option:selected").val() == '04'
				&& (parseInt(numberOfAdultsVal)+parseInt(numberOfChidernVal)) > 3) {
				alert('3인(트리플)실에는 3명까지만 이용하실 수 있습니다.');
				hotel_div.find(adultCnt).focus();
				return false;
			}
			
			//아동인원
			if(numberOfChidernVal != '') {
							
				//아동나이
				for(var intSubLoop=0; intSubLoop < numberOfChidernVal; intSubLoop++) {
					var chdAge = "ht" + (i+1) + "_chage" + parseInt(intSubLoop+1);
					if(hotel_div.find("select[name= "+ chdAge + "] option:selected").val() == '') {
						alert('아동의 나이를 선택하여 주세요');
						return false;
					}
					
					if(intSubLoop == 0) {
						childAgeVal = childAgeVal + hotel_div.find("select[name= "+ chdAge + "] option:selected").val();
					} else {
						childAgeVal = childAgeVal + ',' + hotel_div.find("select[name= "+ chdAge + "] option:selected").val();
						//console.log("childAgeVal=" + childAgeVal);
					}
				}
				
			}
			
			selSeatVal = hotel_div.find("select[name=" + selSeat + "] option:selected").val();
		}
		
		var roomInfo = {
				'roomTy' : selSeatVal,
				'numOfAdt': numberOfAdultsVal,
				'numOfChd' : numberOfChidernVal,
				'ageOfChd' : childAgeVal
				
		};
		
		roomCont.push(roomInfo);
		
	};
	

 	//객실수
	roomCnt = ((roomShowCnt-1) == 0) ? 1: (roomShowCnt-1);
	
	var fitMix =   ($("#selAir").val() == 'Y' ? 'A' : 'X')
				+ ($("#selHotel").val() == 'Y' ? 'H' : 'X')
				+ ($("#selRentcar").val() == 'Y' ? 'C' : 'X');
	
	//console.log("fitMix=" + fitMix);
	
	if(sessionStorage.domesticYn == 'N') sessionStorage.domesticYn = ''; 
	
	var hotelViewData = {
			'countryCode'	: countryCode.val(),
			'countryNm'		: cityDisplay.val(),
			'countryNmEn'   : countryNmEnVal,
			'cityCode'		: cityCode.val(),
			'city'			: city.val(),
			'checkInDate'	: fn_dateParsing(checkInDate.text()),
			'checkOutDate'	: fn_dateParsing(checkOutDate.text()),
			'day'			: srch_night_days.text(),
			'roomCnt'		: roomCnt,
			'searchType'    : 'C',               //도시:C 호텔:H 랜드마크:
			'roomCont'		: roomCont,
			'fitMix'		: fitMix,
			'isDomestic'	: sessionStorage.domesticYn,
			
		};
	
	var night = srch_night_days.text().split("박");
		
	var hotelSearchData = {
			'countryCd'		: countryCode.val(),
			'countryNm'		: cityDisplay.val(),//countryNm.val(),
			'nightDay'		: night[0],
			'stateProvCd'   : '',//cityCode.val(),
 			'findLocNm'		: cityCode.val(),
			'checkInDt'		: fn_dateParsing(checkInDate.text()),
			'checkOutDt'	: fn_dateParsing(checkOutDate.text()),
			'roomCnt'		: roomCnt,
			'searchType'    : 'C',               //도시:C 호텔:H 랜드마크:
			'roomCont'		: roomCont,
			'fitMix'		: fitMix,
			'isDomestic'	: sessionStorage.domesticYn
			
	};

	//console.log("cityCode.val=" + cityCode.val());
	//console.log("city.val=" + city.val());
	//console.log("cityCode.val=" + countryCode.val());
	//console.log("cityDisplay.val()=" + cityDisplay.val());
	
	sessionStorage.hotelViewData = JSON.stringify(hotelViewData);
	sessionStorage.hotelSearchVal = JSON.stringify(hotelSearchData);
		
	return true;
}

//날짜 파싱
function fn_dateParsing(date) {
	var dateTemp;
	
	dateTemp = date.split('.');
	
	if(dateTemp != null && dateTemp.length < 4) {
		for(var i in dateTemp) {
			//console.log("dateTemp[" + i + "]=" + dateTemp[i]);
		}
		
		date = dateTemp[0] + '-' + dateTemp[1] + '-' + dateTemp[2];
	}
	//console.log("<<<date=" + date);
	return date;
}


function successPro(_data) {
	//데이터 글로벌 저장
	g_hotel_all_data = _data.hotelList;

	sessionStorage.hotelInfoMapData = JSON.stringify(g_hotel_all_data);
		
	sortHotelList();
}


//호텔 리스트 호출
function fn_hotel_list(_data) {
	gfn_callAjax('/fit/htl/hotelListAjax.do?reSrch=false',_data,'successPro',false);
}


//호텔 리스트 호출
function fn_hotel_research(_data) {
	gfn_callAjax('/fit/htl/hotelListAjax.do?reSrch=true',_data,'successPro',false);
}


// 주요지역 필터링 세팅
function fn_setPlaceFilter(p_data){
	var local_latlng = p_data.cityLatlng.results[0].geometry.location;
	
	var reqData = {
		latitude	: local_latlng.lat,
		longitude	: local_latlng.lng,
		types		: ''
	};
	
	//console.log(p_data);
	
	gfn_callAjax ('/fit/htl/radarsearchAjax.do', reqData, 'console.log', true);
}


//선택하기  - 미완료 (상세조회 후 처리 되어야 함)
function fn_hotelSelect(_obj) {
	//임시
	//li ft-att="fare_list" ar-cnt="0"
//	var selCnt = $(_obj).parents('li[ft-att="fare_list"]').attr('ar-cnt');
//	var selHotel = [];
//	selHotel[0] = hotel_fix_data[selCnt];
//	sessionStorage.hotelSelData = JSON.stringify(selHotel); 
//	gfn_showSelectDetailPop();
}

//리스트 정렬
function sortHotelList() {
	//console.log("<<<<<sortHotelList === start");
	
	var e_cnt = 10;
	
	var sortFlag = $('#hotel_sort').text();
	hotel_sort_data = [];
	
	//hotel_sort_data = g_hotel_all_data;
	
	//if(sortFlag == '추천순') {
	for(var j=0; j < g_hotel_all_data.length; j++) {
		hotel_sort_data.push(g_hotel_all_data[j]);
			
	}
	//console.log(hotel_sort_data);
				
	if(sortFlag == '가격순') {
		//가격정렬
		for(var i=0; i < hotel_sort_data.length; i++) {
			var data = hotel_sort_data[i].roomDetls[0];
			var jtbTotal = data.jtbTotal;
			hotel_sort_data[i].jtbTotal = jtbTotal;
		}
		hotel_sort_data.sort(sort_by('jtbTotal', false, parseInt));
		//console.log(hotel_sort_data);
	} else if (sortFlag == '등급순') {
		hotel_sort_data.sort(sort_by('hotelRating', true, parseFloat));
		console.log("<<<<<sorting=" + sortFlag);
	} else if (sortFlag == '평점순') {
		hotel_sort_data.sort(sort_by('tripAdvRating', true, parseFloat));
		console.log("<<<<<sorting=" + sortFlag);
	} else if (sortFlag == '추천순') {
		//hotel_sort_data.sort(sort_by('tripAdvRating', true, parseFloat));
		//hotel_sort_data = fn_sortByRecomm(hotel_sort_data);
		console.log("<<<<<sorting=" + sortFlag);
	}else{
		console.log('기타');
	}
	hotel_fix_data = hotel_sort_data;
	
	//console.log("<<<<<[sortHotelList]hotel_sort_data=" + hotel_sort_data);
	//console.log("<<<<<[sortHotelList]hotel_fix_data=" + hotel_fix_data);
	
	if(hotel_fix_data.length < e_cnt){
		e_cnt = hotel_fix_data.length; 
	}
	
	//페이징 처리
	var pagingInfo = pagingjs.init($('div.pagination'), hotel_fix_data.length, 'fn_hotel_paging', e_cnt);
	viewHotelList(pagingInfo.start, pagingInfo.end);
	//filterHotelList();
	console.log("<<<<<sortHotelList === end");
}
var cnt = 0;
//추천순 필터
function fn_sortByRecomm(datas){
	var restults = [];
	for(var i=0;i<datas.length;i++){
		
		if(datas[i].isRecomm == 'Y'){
			restults.unshift(datas[i]);
			continue;
		}
		restults.push(datas[i]);
	}
	
	return restults;
}

//상세조건 데이터
function fn_detailSrch() {
	//console.log("<<<<<fn_detailSrch === start");
	
	var e_cnt = 10;
	
	//console.log("<<<<<" + g_hotel_all_data + ">>>>>>>>");
	
	hotel_sort_data = g_hotel_fix_data;
	
	if(hotel_sort_data != null && hotel_sort_data.length == 0) {
		$('#hotel_result_list_div').hide();
		$('#totCnt').text("0");
		$('#hotel_result_nodata_div').show();
		$('#morebtn').hide();
		gfn_loading_bar_draw('hide');
	} else {
		$('#hotel_result_list_div').show();
		$('#hotel_result_nodata_div').hide();
		
		//hotel_sort_data.sort(sort_by('hotelRating', true, parseFloat));
		
		hotel_fix_data = hotel_sort_data;
			
		if(hotel_fix_data.length < e_cnt){
			e_cnt = hotel_fix_data.length;
		}
		
		//페이징 처리
		var pagingInfo = pagingjs.init($('div.pagination'), hotel_fix_data.length, 'fn_hotel_paging', e_cnt);
		viewHotelList(pagingInfo.start, pagingInfo.end);
		//filterHotelList();
		//console.log("<<<<<sortHotelList === end");
	}
}



//정렬 함수
var sort_by = function(field, reverse, primer){
    reverse = (reverse) ? -1 : 1;
    return function(a,b){
        a = a[field];
        b = b[field];
       // console.log(">>>a=" + a + "b=" + b);
        if (typeof(primer) != 'undefined'){
            a = primer(a);
            b = primer(b);
        }
        if (a<b) return reverse * -1;
        if (a>b) return reverse * 1;
        return 0;
    };
};

//리스트 필터링
function filterHotelList() {
	
	gfn_loading_bar_draw('show');
	/** 필터링 변경 여부 체크 */
//	var filter_chn_yn = false;
//	
//	var nfil_via_type = [];
//	var nfil_class_type = [];
//	var nfil_hotel_line = [];
//	var nfil_dep_tm = [];
//	var nfil_fare_type = [];
//	
//	//항목별 체크박스 그룹
//	var via_chk_group = $('input:checkbox[ar_att="filter_chk"][name="fil_via_type"]');
//	var class_chk_group = $('input:checkbox[ar_att="filter_chk"][name="fil_class_type"]');
//	var line_chk_group = $('input:checkbox[ar_att="filter_chk"][name="fil_hotel_line"]');
//	var dep_chk_group = $('input:checkbox[ar_att="filter_chk"][name="fil_dep_tm"]');
//	var fare_chk_group = $('input:checkbox[ar_att="filter_chk"][name="fil_fare_type"]');
//		
//	//전체 체크 여부
//	var viaAllChk = via_chk_group.eq(0).is(':checked');
//	var classAllChk = class_chk_group.eq(0).is(':checked');
//	var lineAllChk = line_chk_group.eq(0).is(':checked');
//	var depAllChk = dep_chk_group.eq(0).is(':checked');
//	var fareAllChk = fare_chk_group.eq(0).is(':checked');
//	
//	//경유 체크 정보
//	for(var idx=0; idx<via_chk_group.length; idx++) {
//		if(via_chk_group.eq(idx).is(':checked')) {
//			nfil_via_type[nfil_via_type.length] = via_chk_group.eq(idx).val();	
//		}		
//	}
//	
//	//좌석등급 체크 정보
//	for(var idx=0; idx<class_chk_group.length; idx++) {
//		if(class_chk_group.eq(idx).is(':checked')) {
//			nfil_class_type[nfil_class_type.length] = class_chk_group.eq(idx).val();
//		}
//		
//	}
//
//	//항공사 체크 정보
//	for(var idx=0; idx<line_chk_group.length; idx++) {
//		if(line_chk_group.eq(idx).is(':checked')) {
//			nfil_hotel_line[nfil_hotel_line.length] = line_chk_group.eq(idx).val();	
//		}		
//	}
//
//	//출발시간 체크 정보
//	for(var idx=0; idx<dep_chk_group.length; idx++) {
//		if(dep_chk_group.eq(idx).is(':checked')) {
//			nfil_dep_tm[nfil_dep_tm.length] = dep_chk_group.eq(idx).val();	
//		}
//		
//	}
//
//	//요금구분 체크 정보
//	for(var idx=0; idx<fare_chk_group.length; idx++) {
//		if(fare_chk_group.eq(idx).is(':checked')) {
//			nfil_fare_type[nfil_fare_type.length] = fare_chk_group.eq(idx).val();	
//		}		
//	}
//	
//	// 변동 사항 체크
//	if(filter_info.fil_via_type.length != nfil_via_type.length) {
//		filter_info.fil_via_type = nfil_via_type;
//		filter_chn_yn = true;
//	} else  {
//		for(var chk_i=0; chk_i<filter_info.fil_via_type.length ; chk_i++) {
//			if(filter_info.fil_via_type[chk_i] != nfil_via_type[chk_i]) {
//				filter_info.fil_via_type = nfil_via_type;
//				filter_chn_yn = true;
//				break;
//			}
//		}
//	}
//	
//	if(filter_chn_yn) {
//		filter_info.fil_class_type = nfil_class_type;
//	} else {
//		if(filter_info.fil_class_type.length != nfil_class_type.length) {
//			filter_chn_yn = true;
//			filter_info.fil_class_type = nfil_class_type;
//		} else {
//			for(var chk_i=0; chk_i<filter_info.fil_class_type.length ; chk_i++) {
//				if(filter_info.fil_class_type[chk_i] != nfil_class_type[chk_i]) {
//					filter_chn_yn = true;
//					filter_info.fil_class_type = nfil_class_type;
//					break;
//				}
//			}
//		}	
//	}
//		
//	if(filter_chn_yn) {
//		filter_info.fil_hotel_line = nfil_hotel_line;		
//	} else {
//		if(filter_info.fil_hotel_line != nfil_hotel_line) {
//			filter_chn_yn = true;
//			filter_info.fil_hotel_line = nfil_hotel_line;
//		} else  {
//			for(var chk_i=0; chk_i<filter_info.fil_hotel_line.length ; chk_i++) {
//				if(filter_info.fil_hotel_line[chk_i] != nfil_hotel_line[chk_i]) {
//					filter_chn_yn = true;
//					filter_info.fil_hotel_line = nfil_hotel_line;
//					break;
//				}
//			}
//		}		
//	}
//	
//	if(filter_chn_yn) {
//		filter_info.fil_dep_tm = nfil_dep_tm;
//	} else {
//		if(filter_info.fil_dep_tm != nfil_dep_tm) {
//			filter_chn_yn = true;
//			filter_info.fil_dep_tm = nfil_dep_tm;
//		} else  {
//			for(var chk_i=0; chk_i<filter_info.fil_dep_tm.length ; chk_i++) {
//				if(filter_info.fil_dep_tm[chk_i] != nfil_dep_tm[chk_i]) {
//					filter_chn_yn = true;
//					break;
//					filter_info.fil_class_type = nfil_class_type;
//				}
//			}
//		}
//	}
//	
//	if(filter_chn_yn) {
//		filter_info.fil_fare_type = nfil_fare_type;
//	} else {
//		if(filter_info.fil_fare_type != nfil_fare_type) {
//			filter_info.fil_fare_type = nfil_fare_type;
//			filter_chn_yn = true;
//		} else  {
//			for(var chk_i=0; chk_i<filter_info.fil_fare_type.length ; chk_i++) {
//				if(filter_info.fil_fare_type[chk_i] != nfil_fare_type[chk_i]) {
//					filter_info.fil_fare_type = nfil_fare_type;
//					filter_chn_yn = true;
//					break;
//				}
//			}
//		}
//	}
//	
//	
//	//변경 사항 있을시 동작
//	if(filter_chn_yn) {
//		$('[ft-att="fare_div"]').html('');
//				
//		// 리스트 초기화
//		hotel_fix_data = []; 
//		
//		for(var setIdx=0; setIdx<hotel_sort_data.length; setIdx++ ) {
//			var view_yn = false;
//			if(!viaAllChk) {
//				for(var vidx=0; vidx<filter_info.fil_via_type.length; vidx++) {
//					if(filter_info.fil_via_type[vidx] == hotel_sort_data[setIdx].viaTy) {
//						view_yn = true;
//						break;
//					}
//				}
//				
//				if(!view_yn) {
//					continue;
//				}
//				
//				view_yn = false;
//			}
//			
//			if(!classAllChk) {
//				/* 뭐랑 비교해야할지 모르겠음
//				hotel_sort_data[setIdx].segmentGroup[0].cabinClass
//				
//				for(var vidx=0; vidx<filter_info.fil_class_type.length; vidx++) {
//					if(filter_info.fil_class_type[vidx] == hotel_sort_data[setIdx].viaTy) {
//						view_yn = true;
//						break;
//					}
//				}
//				
//				if(!view_yn) {
//					continue;
//				}
//				
//				view_yn = false;
//				*/
//			}
//			
//			if(!lineAllChk) {
//				for(var vidx=0; vidx<filter_info.fil_hotel_line.length; vidx++) {
//					if(filter_info.fil_hotel_line[vidx] == hotel_sort_data[setIdx].carrierCd) {
//						view_yn = true;
//						break;
//					}
//				}
//				
//				if(!view_yn) {
//					continue;
//				}
//				
//				view_yn = false;
//			}
//			
//			if(!depAllChk) {
//				// 3:00 ~ 11:59, 12:00 ~ 16:59, 17:00 ~ 2:59
//				// 이름을 0312 1217 1703 으로 변경
//				
//				for(var vidx=0; vidx<filter_info.fil_dep_tm.length; vidx++) {
//					var sttTm = filter_info.fil_dep_tm[vidx].substring(0, 2) + '00';
//					var endTm = filter_info.fil_dep_tm[vidx].substring(2, 4) + '00';
//					
//					var tdepTm = hotel_sort_data[setIdx].fltData[0].depTm; 
//					if(sttTm < endTm) {
//						if(sttTm <= tdepTm && tdepTm < endTm) {
//							view_yn = true;
//							break;
//						}							
//					} else {
//						if(sttTm <= tdepTm || tdepTm < endTm) {
//							view_yn = true;
//							break;
//						}
//					}
//				}
//				
//				if(!view_yn) {
//					continue;
//				}
//				
//				view_yn = false;
//			}
//			
//			if(!fareAllChk) {
//				/* hotel_sort_data[setIdx].paxDataBean[0].fareDataBean[0].fareTy;
//		 		for(var vidx=0; vidx<filter_info.fil_fare_type.length; vidx++) {
//					if(filter_info.fil_fare_type[vidx] == hotel_sort_data[setIdx].carrierCd) {
//						view_yn = true;
//						break;
//					}
//				}
//				*/
//			}
//			
//			hotel_fix_data[hotel_fix_data.length] = hotel_sort_data[setIdx];
//		} // for end
//		
//		//페이징 처리
//		$('[ft-att="fare_div"]').html('');
		var pagingInfo = pagingjs.init($('div.pagination'), hotel_fix_data.length, 'fn_hotel_paging', e_cnt);
		viewHotelList(pagingInfo.start, pagingInfo.end);	
//	}	
}

//페이지 이동 함수
function fn_hotel_paging(){
	var sel_page = 0;
	if($(this).attr('ft-att') == 'vec'){
		var vec = $(this).attr('ft-data');
		if(vec == 'prev'){
			sel_page = $('div.pagination').find('div.numbers').find('.current').attr('value')-0-1;
		} else if (vec == 'next') {
			sel_page = $('div.pagination').find('div.numbers').find('.current').attr('value')-0+1;
		} else {
			sel_page = vec-0;
		}
	} else {
		sel_page = $(this).attr('value') - 0;
	}
	
	var pagingInfo = pagingjs.mvpage(sel_page);
	if(pagingInfo.start > 0 && pagingInfo.end > 0) {
		$('[ft-att="fare_div"]').html('');
		viewHotelList(pagingInfo.start, pagingInfo.end);
	}	
}
//var avgRate = '';

//호텔리스트 출력 ---- old
function viewHotelList(_s_cnt, _e_cnt) {
	//데이터
	var hotel_data = hotel_sort_data;//g_hotel_all_data;
	
	//console.log("hotel_sort_data.data=" + hotel_sort_data);
	//console.log("hotel_sort_data.length=" + hotel_sort_data.length);
	
	//console.log("[viewHotelList] hotel_data>>>>>>>>>>>>>>>_s_cnt=" + _s_cnt + ",_e_cnt=" + _e_cnt);
	
	//console.log(hotel_data);
	
	var nightDay = 1; //숙박일수
	if(nullToBlank(sessionStorage.hotelSearchVal) != '' && sessionStorage.hotelSearchVal != '[]') {
		var srchValData = JSON.parse(sessionStorage.hotelSearchVal);	
		var nightCnt = srchValData.nightDay.split("박");
		nightDay = parseInt(nightCnt);
	}
	
	//데이터가 없는 경우
	if(hotel_sort_data.length == 0) {
		$('#hotel_result_list_div').hide();
		$('#totCnt').text("0");
		$('#hotel_result_nodata_div').show();
		$('#morebtn').hide();
		gfn_loading_bar_draw('hide');
	}
	
	//for(var i=_s_cnt-1; i < _e_cnt; i++) {
		
		var vHtml ='';
		
		if(nullToBlank(hotel_data) != '') {

			//console.log("htl_data.length=" + hotel_data.length);
			g_hotel_promo = []; //프로모션
			
			for(var j = 0; j < _e_cnt; j++) {
				
				var rate ='';
				var data = hotel_data[j];
				var avgBaseRatePrice;
				
				
				var exchangeRate = parseFloat(data.roomDetls[0].exchangeRate);
				var avgBaseRate = 0;  // 0416  이제 안쓴다.
				var avgRate = 0;     //0416 이제 안쓴다.
				var jtbBaseTotal = 0;   // 0416 쓴다.
				var jtbTotal = 0;     // 0416  쓴다.
				//var aplPromTotal = 0;// 프로모션 적용된 금액
				//var promTxt = '';
				
				//프로모션 
				//var promInfo = data.roomDetls[0].promInfo;
				
				//g_hotel_promo.push(promInfo);
				
				//promTxt = promInfo.promTxt;
				
				//if(data.suplrCd == 'EAN') {
					if(data.roomDetls[0].jtbBaseToatl != '')
						jtbBaseTotal = Math.ceil(parseFloat(data.roomDetls[0].jtbBaseTotal));
				
					
					jtbTotal = Math.ceil(parseFloat(data.roomDetls[0].jtbTotal));  //jtbtotal
					
				//} 
//				else {
//					if(data.roomDetls[0].jtbBaseTotal != '')
//						jtbBaseTotal = Math.ceil(exchangeRate * parseFloat(data.roomDetls[0].jtbBaseTotal)); //HP GTA는 통합
//					if(data.roomDetls[0].aplPromTotal != '') {
//						//jtbTotal = Math.ceil(exchangeRate * parseFloat(data.roomDetls[0].jtbTotal));
//						if(nullToBlank(promInfo.aplPromTotal) != '') {
//							aplPromTotal = Math.ceil(exchangeRate * parseFloat(promInfo.aplPromTotal));
//						} else
//							aplPromTotal = Math.ceil(exchangeRate * parseFloat(data.roomDetls[0].aplPromTotal));	
//					}
//				}
					
			   	if(jtbBaseTotal > 0) {
					
					if(jtbBaseTotal == jtbTotal) avgBaseRatePrice = "";
					else
						avgBaseRatePrice = setPriceInput(jtbBaseTotal) + "원";

				} else avgBaseRatePrice = "";
				
				if(nullToBlank(data) != '') {
					
					var cntF = parseFloat(data.hotelRating);
					var cnt = parseInt(data.hotelRating);
					if(cnt > 0) {
						
						var div = (cntF % cnt);
												
						for(var k=1; k <= cnt; k++)
						{
							rate += "<em>" + k + "</em>";
						}
						
						if(div > 0) {
							rate += "<em class='half'>" + (cnt+1) + "</em>"
						}
					} else	rate = "<br>";
					
					
					if(data.lat == null || data.lat == "") data.lat = '0.0';
					if(data.lon == null || data.lon == "") data.lon = '0.0';
					
					
					var locShortDesc = data.locShortDesc;
					//호텔 패스 내용중 중간에 ' 들어가있는 경우 있다.
					if(nullToBlank(locShortDesc) != '')
						var locShortDescArr = data.locShortDesc.split("'");
					
					if(nullToBlank(locShortDescArr) != '' && locShortDescArr.length > 0) {
						var cntText = '';
						for(var k=0; k < locShortDescArr.length; k++) {
							cntText += locShortDescArr[k]; 
							
						}
						locShortDesc = cntText;
					}
					
					
					vHtml = vHtml + "<ul class='frht_listbox' id='frht_listbox'>  															  " 
					vHtml = vHtml + " <li>		  "
					vHtml = vHtml + "   <div class='frht_list'>                                                                               "
					vHtml = vHtml + "        <p class='frht_img'><a href='#' onclick='fn_htlDetailoPage(" + j +")'><img src='" + data.thumbNailUrl + "' alt='' /></a></p>                "
					vHtml = vHtml + "        <div class='frht_info'>                                                                          "
					vHtml = vHtml + "              <p class='frht_stxt' onclick='fn_htlDetailoPage(" + j + ")' >" + data.hotelNmEn + "</p>                                          "
					vHtml = vHtml + "              <p class='frht_htxt'><a href='#' onclick='fn_htlDetailoPage(" + j + ")'><span class='ellipsis'>" + data.hotelNmKr + "</span></a> "
					vHtml = vHtml + "              <button type='button' id='mapView' data-role='none' class='layerOpener' data-url='/pop/pop_mappos.do?lat=" + data.lat + "&longi=" + data.lon + "&hname=" + data.hotelNmKr +"' data-ctn='full' data-role='none' style='cursor='hand';' data-ok='yes'></button></p>"
					vHtml = vHtml + "              <p class='frht_stxt2 ellipsis'><div onclick='fn_htlDetailoPage(" + j + ")' style='font-size:12px'>" + data.locShortDesc + "</div></p>                    				  "
					vHtml = vHtml + "			   <p class='frht_stxt2 ellipsis'>"
					var convenience = '';
					for(var m= 0; m < data.roomDetls[0].valAdds.length; m++) {
						
						convenience = data.roomDetls[0].valAdds[m].valueNm;
						var src= "";
						
						if(convenience.indexOf("무료 공항") > -1) {
							src = "/resources/images/ico/ht_rut_bus.png";
						} else if(convenience.indexOf("드링크") > -1 || convenience.indexOf("차/커피") > -1 ) {
							src = "/resources/images/ico/ht_rut_drink.png";
						} else if(convenience.indexOf("드라이") > -1) {
							src = "/resources/images/ico/ht_rut_dry.png";
						} else if(convenience.indexOf("아침") > -1 || convenience.indexOf("조식") > -1) {
							src = "/resources/images/ico/ht_rut_food.png";
						} else if(convenience.indexOf("피트니스") > -1) {
							src = "/resources/images/ico/ht_rut_health.png";
						} else if(convenience.indexOf("난방") > -1) {
							src = "/resources/images/ico/ht_rut_heat.png";
						} else if(convenience.indexOf("다리미") > -1) {
							src = "/resources/images/ico/ht_rut_iron.png";
						} else if(convenience.indexOf("주차") > -1) {
							src = "/resources/images/ico/ht_rut_parking.png";
						} else if(convenience.indexOf("비지니스") > -1) {
							src = "/resources/images/ico/ht_rut_pool.business.png";
						} else if(convenience.indexOf("수영장") > -1) {
							src = "/resources/images/ico/ht_rut_pool.png";
						} else if(convenience.indexOf("흡연") > -1) {
							src = "/resources/images/ico/ht_rut_smoking.png";
						} else if(convenience.indexOf("스파") > -1) {
							src = "/resources/images/ico/ht_rut_spa.png";
						} else if(convenience.indexOf("TV") > -1) {
							src = "/resources/images/ico/ht_rut_tv.png";
						} else if(convenience.indexOf("무선 인터넷") > -1 || convenience.indexOf("와이파이") > -1 || convenience.indexOf("WiFi") > -1) {
							src = "/resources/images/ico/ht_rut_wifi.png";
						} else if(convenience.indexOf("에어컨") > -1) {
							src = "/resources/images/ico/ht_rut_aircon.png";
						} else if(convenience.indexOf("전용해변") > -1) {
							src = "/resources/images/ico/ht_rut_beach.png";
						}
						
						if(src != "")
							vHtml = vHtml + "            <img src='" + src + "' alt='' />"
					}
					vHtml = vHtml + "              </p>"
									
					vHtml = vHtml + "  		       <p class='frht_rebox'>                                                                     "
					vHtml = vHtml + "                	<span>" + rate + "</span>                       "
					if(nullToBlank(data.tripAdvRating) == '')
						vHtml = vHtml + "                   <span style='display:none'>" + data.tripAdvRating + "/5.0</span>   											  "
					else
						vHtml = vHtml + "                   <span style='display:block'>" + data.tripAdvRating + "/5.0</span>   											  "
					
					vHtml = vHtml + "              </p>																						  "
					vHtml = vHtml + "         </div>																						  "
					vHtml = vHtml + "    </div>																								  "
					vHtml = vHtml + "  </li>																								  "
					vHtml = vHtml + "  <li onclick='fn_htlDetailoPage(" + j + ")'>																									  "
					vHtml = vHtml + "  	<span>" + nightDay + "박 요금</span> 																				  "
					vHtml = vHtml + "   <p><strike>"+ avgBaseRatePrice + "</strike><em>" + setPriceInput(jtbTotal) + "</em>원</p>		  "
					vHtml = vHtml + "  </li>																								  "
					
					//임시로 막자.
					/*if(nullToBlank(promTxt) != '') {	
						vHtml = vHtml + "  <li "
						vHtml = vHtml + "   	<em style='color:red; text-align:right; padding-right:10px; font-size: 0.8em'>" + promTxt + "</em></p>		  "
						vHtml = vHtml + "  </li>																								  "
					}
					*/
					vHtml = vHtml + "</ul>																									  "
					
					$('#hotel_result_list_div').html(vHtml);
					
				 }
			}
			$('#morebtn').show();
			
			//console.log(g_hotel_promo);
		} else {
			$('#totCnt').text("0");
			$('#hotel_result_list_div').hide();
			$('#hotel_result_nodata_div').show();
			$('#morebtn').hide();
			gfn_loading_bar_draw('hide');
			
		}
		
		//총갯수
		hotelListCnt = hotel_data.length;
		$('#totCnt').text(hotelListCnt);
	
}

//호텔 상세페이지로 이동
function fn_htlDetailoPage(idx) {
	var selAir =  $("#selAir").val();
	var selHotel = $("#selHotel").val();
	var selRentcar = $("#selRentcar").val();
	
		
	//var promotion = [];
	
	var htlDetail = hotel_sort_data[idx];
	
	console.log(htlDetail);
	
	//promotion[0] = g_hotel_promo[idx];
	
		
	var hotelList = {
		'lat' : htlDetail.lat,
		'lon' : htlDetail.lon,
		'h_krName' : htlDetail.hotelNmKr,
		'h_enName' : htlDetail.hotelNmEn,
		'hotelId' : htlDetail.hotelId,
		'suplrCd' : htlDetail.suplrCd,
		'countryCd' : htlDetail.countryCd,
		'cityCd' : htlDetail.cityCd,
		'exchangeRate' : htlDetail.exchangeRate,
		'locShortDesc' : htlDetail.locShortDesc,
		'hotelfee' : htlDetail.roomDetls[0].hotelFee,
		'promInfo' : '' //promotion
	};
	
	sessionStorage.hotelSelList = JSON.stringify(hotelList);
	
	document.location.href="/free/hotel_detail_hotel.do?&selAir=" + selAir + "&selHotel=" + selHotel + "&selRentcar=" + selRentcar;
	
}

//호텔 상세페이지로 이동
/*function fn_htlDetailoPage(lat, longi, hname, hname1, hotelId, suplrCd, countryCd, citycd, exchangeRate,locShortDesc,hotelfee, idx) {
	var selAir =  $("#selAir").val();
	var selHotel = $("#selHotel").val();
	var selRentcar = $("#selRentcar").val();
	
	//console.log("hotelId=" + hotelId);
	
	var promotion = [];
		
	promotion[0] = g_hotel_promo[idx];
		
	var hotelList = {
		'lat' : lat,
		'lon' : longi,
		'h_krName' : hname,
		'h_enName' : hname1,
		'hotelId' : hotelId,
		'suplrCd' : suplrCd,
		'countryCd' : countryCd,
		'cityCd' : citycd,
		'exchangeRate' : exchangeRate,
		'locShortDesc' : locShortDesc,
		'hotelfee' : hotelfee,
		'promInfo' : promotion
	};
	
	sessionStorage.hotelSelList = JSON.stringify(hotelList);
	
	document.location.href="/free/hotel_detail_hotel.do?&selAir=" + selAir + "&selHotel=" + selHotel + "&selRentcar=" + selRentcar;
	
	
	//document.location.href="/free/hotel_detail_hotel.do?lat=" + lat + "&longi=" + longi + "&h_krName=" + hname + "&h_enName=" + hname1 + "&selAir=" + selAir + "&selHotel=" + selHotel + "&selRentcar=" + selRentcar;
}*/

//시간 차이 형태 변경
function setIntervalText(pDt, pTm, nDt, nTm) {
	var fltTm = calcInterval(pDt, pTm, nDt, nTm);
	
	var fltTmH = '';
	
	if(fltTm != null){
		fltTm = fltTm.split(',');	//fltTm = dd,hh,mi,ss
		if(fltTm.length > 2){
			fltTmH = fltTm[1] + '시간 ' + fltTm[2] + '분'; 
		}
	}
	
	return fltTmH;
}


//리스트 더보기
function fn_call_more_list() {
	var s_cnt = $('#hotel_result_list_div').find('ul[id="frht_listbox"]').size() + 1;
	//var e_cnt = s_cnt - 0 + 20;	//20개씩 추가
	var e_cnt = (s_cnt + Number(pageSize))-1;	
	console.log("<<<s_cnt1=" + s_cnt + ",e_cnt=" + e_cnt);
	
	if(s_cnt > hotelListCnt) {
		alert("더이상 등록된 호텔리스트가 없습니다.");
		return false;
	}
	
	/*if(e_cnt > hotel_fix_data.enlgth){
		e_cnt = hotel_fix_data.length;
	}*/
	
	viewHotelList(s_cnt, e_cnt);
	console.log("<<<s_cnt2=" + s_cnt + "e_cnt=" + e_cnt);
}

function fn_searchCityList(_val){
	setTimeOut('', 1000);
}

function fn_actCitySearch() {
	
}



//참고 script
var likeTimer = setTimeout(function(){}, 1);
var fadeOption = {
	fade: 500,
	duration: 1500,
	beforeShow: function(){},
};

function likeTime(options)
{
	var settings = $.extend({}, fadeOption, options);
	var like = $('.like');

	$(like).stop();
	clearTimeout(likeTimer);
	$(like).removeClass('on');

	$(like).fadeIn(settings.fade, function() {
	    $('html').addClass('disable_scroll');
	    likeTimer = setTimeout(function() {
	        $(like).fadeOut(settings.fade);
	        $('html').removeClass('disable_scroll');
	    }, settings.duration);
	});
}

//function fn_reSelect(_popid) {
//	if(confirm('선택을 취소한 뒤 리스트 페이지로 돌아가겠습니까?')) {
//		sessionStorage.hotelSelData = JSON.stringify([]);
//		uijs.hide(_popid);
//	}	
//}

function fn_goNext() {
	
	var f_frm = $('#f_frm'); 
	
	var selRentcarYn = f_frm.children('input[name="selRentcar"]').val() == 'Y';
	
	if (selRentcarYn) {
		f_frm.attr('action', '/fit/rnt/searchMain.do');
	} else {
		f_frm.attr('action', '/fit/rsv/viewRsvInfo.do');	//예약페이지
	}
	
	f_frm.submit();
}


//인원체크 함수
function fn_chk_mem_cnt(_obj) {
	
	var adt_cnt = $('select[name="adtCnt"] option:selected').val() - 0;
	var chd_cnt = $('select[name="chdCnt"] option:selected').val() - 0;
	var inf_cnt = $('select[name="infCnt"] option:selected').val() - 0;
			
	// 유아는 어른 수를 초과 할 수 없다
	if(inf_cnt > adt_cnt) {
		alert('성인 1명에 유아 1명만을 예약하실수 있으며, \n나머지 유아는 어린이로 예약하셔야 합니다.');
		$('select[name="infCnt"] option[value="0"]').prop('selected', 'selected');
		return;
	}
	
	// 전체 합이 9명을 초과할 수 없다
	if((adt_cnt + chd_cnt + inf_cnt) > 9) {
		alert('총인원이 9명을 넘을 수 없습니다.');
		$(_obj).children('[value="0"]').prop('selected', 'selected');
		return;
	}
}

//호텔 roomImage 롤링
function fn_roomImagejs() {
	/*****호텔 결과 상세 롤링이미지*****/
	var gallery = new Swiper('.re_ht_slider', {
		pagination: '.swiper-pagination',
		spaceBetween: 0,
		loop:true,
		autoplay: 2500,
		nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
		followFinger: false,
		paginationType: 'fraction'
	});	
}

/** 환불 가능일 계산 (환불 가능일 -워크데이1 16:00 시 */
var calcCancelDate = function(_date){
	
	var dateGab = -1;
	
	// 토일 계산
	var thisDay = gfn_getDay(_date);
	if(thisDay == '월'){
		dateGab = -3;
	} else if(thisDay == '일'){
		dateGab = -2;
	}
	
	return gfn_addDay(_date, dateGab);
};

var domeCityList = [];
//국내호텔 세부호텔
function fn_selHotel(_data) {
	var cityList = _data.cityList;
	console.log(cityList);
	
	if(domeCityList.length > 0){
		drawDomeCityDetail();
	} else {
		for(var i=0; i< cityList.length; i++){
			var cityData = cityList[i];
			var cityObj = {
				'naNm'	: cityData.cityNmKr,
				'areaCd': cityData.regionNmEn,
				'cityList'		: []
			};
			domeCityList.push(cityObj);
		}
		gfn_callAjax('/fit/htl/domeCityCdDetail.do', '', 'setSelDomeDetailCity', false); 
	}
		
}

function setSelDomeDetailCity(_data) {
	var cityList = _data.cityList;
	
	for(var i=0; i<cityList.length; i++){
		var cityData = cityList[i];
		
		var area_cd = cityData.regionNmEn;
		
		for(var j=0; j<domeCityList.length; j++){
			var domeCityData = domeCityList[j]; 
			
			if(domeCityData.areaCd == area_cd){
				var cityObj = {
				    htlCd: cityData.cityId,
				    ctNmEn: cityData.cityNmEn,
				    naNm: cityData.countryNm,
				    naCd: cityData.cityNmEn,
				    ctNm: cityData.cityNmKr
				};
				
				domeCityList[j].cityList.push(cityObj);
			}
		}
	}
	drawDomeCityDetail();

}
function drawDomeCityDetail(){

	var city_div = $('tbody[ft-att="city_list_div"]');
	
	city_div.append('<tr><td colspan="5" style="border-left: 1px solid #fff;border-right: 1px solid #fff;padding-top: 10px;">세부도시 검색</td></tr>');
	
	for(var c_idx=0; c_idx<domeCityList.length; c_idx++) {
		var cityGroup = domeCityList[c_idx];
		var row_cnt = parseInt(cityGroup.cityList.length / 3);
		if(cityGroup.cityList.length % 3 > 0) {
			row_cnt++;
		}
			
		var drawStr = $('<tr></tr>')
				.append('<th scope="row" rowspan="' + row_cnt + '">' + cityGroup.naNm + '</th>');
		
		//var cl_func = selHotelCity;
		
		for(var l_idx=0;l_idx<cityGroup.cityList.length; l_idx++) {
			var html = '';
			var city_list = cityGroup.cityList[l_idx];
			
			var disTxt = city_list.ctNm;
			
			/*var city_col = $('<td air-cd="' + city_list.airCd + '" htl-cd="' + city_list.htlCd + '" rnt-cd="' + city_list.rntCd + '" ct-nm="' + city_list.ctNm + '" na-cd="' + city_list.naCd + '" na-nm="' + city_list.naNm + '" en-nm="' + city_list.ctNmEn + '" st-cd="' + city_list.stCd + '" >' + disTxt + '</td>')
						.on('click', eval(cl_func))
						.css('cursor' , 'pointer');*/
			
			var funcNm = "\selectCityList('" + city_list.htlCd + "','" + city_list.ctNmEn + "','" + city_list.ctNm + "','" + city_list.naCd + "','" + city_list.rntCd + "'\)";
			html = html + '				<td city-data="'+ city_list.htlCd + '" country-data="' + city_list.naCd + '" onClick="' + funcNm + '">' + city_list.ctNm + '</td>';
			
			drawStr.append(html);
			
			if(cityGroup.cityList.length == (l_idx+1) ) {
				var vNo = parseInt(cityGroup.cityList.length % 3);
				if(vNo > 0) {
					for(var v_idx=vNo; v_idx<3; v_idx++) {
						drawStr.append('<td></td>');
					}
				}				
				drawStr.appendTo(city_div);
			} else if(l_idx%3 == 2) {
				drawStr.appendTo(city_div);
				drawStr = $('<tr></tr>');
			}
		}
	}
}


