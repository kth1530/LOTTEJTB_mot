
var air_all_data = [];		//전체 리스트
var air_sort_data = [];		//정렬 후 리스트
var air_fix_data = [];		//필터링 후 리스트
var air_direct_data = [];	//직항 리스트
var air_via_data = [];		//경유 리스트
var air_data;
var sel_page = 0; 			// 현재 페이지 번호 
var filter_var = {			//필터링 항목
	"drtCnt" : 0
	, "via1Cnt" : 0
	, "via2Cnt" : 0
	, "airlineData" : []
	, "cabinClasData" : []	
};
var filter_info = {		//현재 적용 중인 필터링 정보
	"fil_via_type" : []
	, "fil_class_type" : []
	, "fil_air_line" : []
	, "fil_dep_tm" : []
	, "fil_fare_type" : []
};

$(document).ready(function(){
	set_init();
});

function set_init() {	
}

// 달력 선택 이벤트
function fn_setAirDate(_obj) {
	var availGroup = $(_obj).parents('[ar-att="availgroup"]').find('.calendar');
	var thisIdx = 0;
	for(var idx=0; idx<availGroup.length; idx++){
		if($(_obj).attr('id') == availGroup.eq(idx).attr('id')) {
			thisIdx = idx;
			break;
		}
	}
	
	var thisDate = $(_obj).val();
	if(thisIdx != 0){
		//availGroup.eq(thisIdx-1).datepicker('option', 'maxDate', thisDate); //이전 날짜 최대값 설정	
	}
	
	if((thisIdx+1) < availGroup.length) {
		var preDate = thisDate.replace(/-/g, '');
		for(var idx=(thisIdx+1); idx<availGroup.length; idx++){
			var set_avail_div = availGroup.eq(idx);
			var nextDate = set_avail_div.val().replace(/-/g, '');
			if(nextDate != ''){
				var ddInterval = calcInterval(preDate, '0000', nextDate, '0000').split(',')[0];
				if(ddInterval-0 < 0) {
					set_avail_div.val('');
				}
			}
			set_avail_div.datepicker('option', 'minDate', thisDate);
		}	
		setTimeout(function(){
			if(availGroup.eq(thisIdx+1).val() == '') {
				availGroup.eq(thisIdx+1).trigger('focus');	//다음 달력 열기 	
			}
		}, 0);
	}
}

//필러팅 checkbox 클릭 동작 설정
function fn_act_filter_pop() {
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
	
	filterAirList();
	// closePopup();
}

function closePopup() {
	jQuery('html, body').css({'overflow':'auto'});
	if(jQuery('.layerPopup').size()){
		jQuery('.layerPopup').remove();                 
	};              
	// opener.focus();		
}


//도시검색 팝업 선택 
function selCity() {
	var chkAvailTy = $('input:radio[name="availTy"]:checked').val();
	var setDiv = $('div[ft-att="' + chkAvailTy + 'Group"]');
	
	//도시이름
	var target_id = $(this).parents('[ft-att="sel_city_pop"]').attr('target-id');
	var setNm = $(this).text().split(' (')[0];	// 도시 이름만 짤라서 입력  ex)인천(ICN) - 대한민국 
	setDiv.find('#' + target_id).val(setNm);
	
	//도시코드
	setDiv.find('#' + $('#' + target_id).attr('target-id')).val($(this).attr('ft-data'));
	
	if(chkAvailTy == 'MT') {	// 다구간일 경우 다음 구간 자동 입력 함수 호출
		fn_setNextDep(setDiv.find('#' + target_id));
	}
	
	//미완료 - 호텔, 렌터카 동일지역 선택 이벤트 추가
	
	
	uijs.hide($(this).parents('[ft-att="sel_city_pop"]').attr('pop-id'));
}

// 도시검색 입력 시 
function fn_search_input(){
	var _val = $("#cityPopInput").val();
	var _obj = $("#cityPopInput");

	if(_val == null) _val = "";
	var ek = event.keyCode;

	if(_val != '') {	//공란의 경우 return
		var lastword = _val.substring(_val.length-1).replace(/%/gi,"\\");	//유니코드로 변환
		if('\u3130' < lastword && lastword < '\u3164'){	//마지막 값이 자음이나 모음일 경우 return
			return;
		} else {
			setTimeout(function(){
				fn_searchCity(_val, _obj);
			}, 300);		
		}
	} else {
		setTimeout(function(){
			if($(_obj).val() == ''){	//입력값 삭제 후 .5초 유지되면 검색 리스트 감춤
				$('div[ft-att="resultSearch"]').children('ul').remove();
			}
		}, 300);
	}
}

// 도시검색 DB 조회
function fn_searchCity(_val, _obj){
	var nowVal = $("#cityPopInput").val();
	if(nowVal == null) nowVal = "";
	
	if(nowVal == _val){	// 입력 .5초후 값과 비교
		gfn_callAjax2('/fit/air/listCityL.do', {'searchVal' : nowVal.toUpperCase()}, 'fn_search_air_city', true);
	} else {
		clearTimeout();
	}
}

//도시검색 결과리스트 생성
function fn_search_air_city(_data) {
	
	var boxDiv = $('div[ft-att="resultSearch"]');
	
	if(_data.cityList.length > 0){
		var boxUl = $('<ul></ul>');
		var reData = _data.cityList;
		
		$(".fs_search .search_nowkey").show();
		
		for(var r_idx=0; r_idx<reData.length; r_idx++) {
			var viewNm = reData[r_idx].airportKrNm + ' (' + reData[r_idx].airportCd + ')' + ' - ' + reData[r_idx].nationKrNm; 
			var funcNm = "javascript:selectCityList('" +reData[r_idx].airportCd+ "','" + reData[r_idx].airportKrNm + "','"+ reData[r_idx].nationCd +"')";
			var searchLi = $("<li onclick=\""+ funcNm + "\" ft-data=\"" + reData[r_idx].airportCd + "\">" + viewNm + "<li>");
			boxUl.append(searchLi);
		}
		// boxUl.append("<p class='snkclose'>닫기</p>");

		boxDiv.html(boxUl);
		jQuery(".fs_search .csbox input").bind("change keyup", function(){
			var intext = $("#cityPopInput").val();
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

		/** 
		boxDiv.find('a').on('click', selCity)
						.css('cursor', 'pointer')
						.on('keydown', mvCityList);
		**/
		$(".fs_search").trigger("create").refresh();

		jQuery(".fs_search .search_nowkey").show();
	} else {

		// boxDiv.html('<ul><li>검색 결과가 없습니다.</li></ul><p class="snkclose">닫기</p>').trigger("create");
		boxDiv.html('<ul><li>검색 결과가 없습니다.</li></ul>').trigger("create");
		$(".fs_search").trigger("create").refresh();		
		jQuery(".fs_search .search_nowkey").show();
	}
}


// 도시검색 키보드 컨트롤 - 미완성	 포커스 스타일 줄것
function mvCityList(cityCd, cityNm){

	$('#srch_arr_ct').html(cityCd);
	$('#srch_arr_ct_dis').html(cityNm);	

}

//call ajax - 공통
function gfn_callAjax2 (_url, _data, _fn_scs, noload, _fn_cpl) {

	var success = false;
	// console.log(">>>>>>>>>>>>>>>> noload : " + noload);
	if(!noload){	//
		gfn_loading_bar_draw2('show');
	}
	
	if (typeof _data == "object") {
		_data = JSON.stringify(_data);
	}
	
	$.ajax({
        url: _url,
        type: 'POST',
        data: _data,
        cache: false,
        dataType : "json",
        contentType : "application/json;charset=UTF-8",
        processData: false,
        success: function (data,status) {
        	success = true;
        	if(_fn_scs != null && _fn_scs != undefined){
        		if(typeof(_fn_scs) == 'function'){
        			_fn_scs();
        		} else if(_fn_scs == 'return'){
        			return data;
        		} else {
        			try {
						air_data = data;
            			eval(_fn_scs)(data);
    				} catch (e) {}
        		}
        	}
        },
        error : function(request,status){
        	console.log('request : ' + request);
			console.log('success : ' + success);
        	console.log('status : ' + status);

			$('#air_result_nodata_div').show();
			$('#air_result_list_div').hide();			
        },
        complete : function(){
        	if(success && _fn_cpl != null && _fn_cpl != undefined){
        		_fn_cpl();
        	}
        	gfn_loading_bar_draw2('hide');
        }
    });
}

// 로딩바 호출/제거
function gfn_loading_bar_draw2(_flag) {
	if($('#test_loading_bar2').length < 1){
		$('body').append('<div id="test_loading_bar2"></div>');

	}
	
	if($('#test_loading_bar_img2').length < 1){
		$('#test_loading_bar2').append('<img id="test_loading_bar_img2" src="/resources/images/img/loading.gif" style="width:296px;"></img>');
	}
	
	$('#test_loading_bar2').css({
		'position': 'fixed', 
		'top': '0px',
		'left': '0px',
		'width': '100%', 
		'height': '100%', 
		'display': 'block', 
		'background-color': '#fff',
		'opacity': 0.9,
		'z-index': 99999,
		'text-align' : 'center'
	}).attr('ar-data', 'show');

	var set_bottom = ($('#test_loading_bar2').innerHeight() - 168)/2;
	var set_right = ($('#test_loading_bar2').innerWidth() - 296)/2;
	$('#test_loading_bar2 > img').css({
		'position' : 'fixed',
		'right' : set_right,
		'bottom' : set_bottom
	});
	
	//	gfn_setPosition($('#test_loading_bar'), 0);
	testLoading2(_flag);
}

function testLoading2(_flag) {
	if(_flag == ''){
		_flag = $('#test_loading_bar2').attr('ar-data');
	}
 
	if(_flag == 'show') {
		$('#test_loading_bar2').show();
		$('#test_loading_bar2').attr('ar-data', 'hide');
	//	$('html').css('overflow', 'hidden');
	} else {
		$('#test_loading_bar2').hide();
		$('#test_loading_bar2').attr('ar-data', 'show');
	//	$('html').css('overflow', 'auto');
	}
}

//리스트 재검색
function search_air_line() {
	
	if(fn_set_air_search_value()){
		//필터링 항목 초기화
		filter_var = {			//필터링 항목
			"drtCnt" : 0
			, "via1Cnt" : 0
			, "via2Cnt" : 0
			, "airlineData" : []
			, "cabinClasData" : []	
		};
		filter_info = {		//현재 적용 중인 필터링 정보
			"fil_via_type" : []
			, "fil_class_type" : []
			, "fil_air_line" : []
			, "fil_dep_tm" : []
			, "fil_fare_type" : []
		};
		
		var airParam = JSON.parse(sessionStorage.airSearchVal).bodyDto;
		var concMixVal = "";
		
		if($("#selAir").val() == 'Y'){
			concMixVal = concMixVal + "A";
		}else{
			concMixVal = concMixVal + "X";
		}
		
		if($("#selHotel").val() == "Y"){
			concMixVal = concMixVal + "H";
		}else{
			concMixVal = concMixVal + "X";
		}
		
		if($("#selRentcar").val() == "Y"){
			concMixVal = concMixVal + "C";
		}else{
			concMixVal = concMixVal + "X";
		}
		
		airParam.concMix = concMixVal;
		
	    // $('p[ft-arr="searchCnt"]').html('선택하신 항공권 검색결과 총 <b id="totCnt"></b>건이 검색 되었습니다.');
	    
		//임시
		//gfn_callAjax2 ('/fit/air/testSearchAjax2.do', JSON.parse(window.localStorage['airSearchData']).bodyDto, 'successPro');
		gfn_callAjax2 ('/fit/air/listSearchAjax.do', airParam, 'successPro');

		return true;
	} else {
		return false;
	}

	return true;
}

//검색값 세팅
function fn_set_air_search_value() {
	
	var air_div = $('#air_search_div');
	
	// var availTy = air_div.find('input:radio[name="availTy"]:checked').val();        //여정 타입
	var availTy = air_div.find('.tablist_com').find('.active').find('button').attr('value');        //여정 타입
	console.log("availTy : " + availTy);
	// 여정별 일정 유효성 검사
	var availViewData = [];
	var availData = [];
	
	var availGroup = $('div[ft-att="' + availTy + 'Group"]');

	var depCd = availGroup.find('#srch_dep_ct');						//출발도시
	var arrCd = availGroup.find('#srch_arr_ct');                      	//도착도시
	var depNm = availGroup.find('#srch_dep_ct_dis');     				//출발도시명
	var arrNm = availGroup.find('#srch_arr_ct_dis');					//도착도시명
	var depDt = availGroup.find('#dep_dt');                          	//출발일
	var arrDt = availGroup.find('#arr_dt');                          	//귀국일
	/**	
	console.log("depCd : " + depCd);
	console.log("arrCd : " + arrCd);
	console.log("depNm : " + depNm);
	console.log("arrNm : " + arrNm);
	console.log("depDt : " + depDt);
	console.log("arrDt : " + arrDt);
	**/

	if(availTy == 'RT' || availTy == 'OW' || availTy == 'OO') {	//왕복,편도 유효성 검사
		depCd = depCd.text();
		arrCd = arrCd.text();
		depNm = depNm.text();
		arrNm = arrNm.text();
		depDt = depDt.text(); 
		// arrDt = arrDt.text();

		console.log("depCd : " + depCd);
		console.log("arrCd : " + arrCd);
		console.log("depNm : " + depNm);
		console.log("arrNm : " + arrNm);
		
		console.log("depDt : " + depDt);


		if(arrCd == '' || arrCd == '도착') {
			alert('도착 도시를 입력해 주세요.');
			return false;
		}
		
		if(depDt == '') {
			alert('출국 일자를 선택해 주세요.');
			return false;
		}

		
		depDt = depDt.replace(/\./g, '');
		console.log("depDt : " + depDt);

		if(availTy == 'RT' || availTy == 'OO') {
			arrDt = arrDt.text(); 
		
			if(arrDt == '' || arrDt == '미지정') {
				alert('귀국 일자를 선택해 주세요.');
				return false;
			}
			
			arrDt = arrDt.replace(/\./g, '');
			
			var chk_date_valid = calcInterval(depDt, '0000', arrDt, '0000').split(',');
			
			if(chk_date_valid[0] < 0){
				alert('올바른 일자를 선택해 주세요');
				return false;
			}
		} else {
			arrDt = ''; 
		}

		console.log(">>>>>>>>>>> depDt : " + depDt);
		console.log(">>>>>>>>>>> arrDt : " + arrDt);

		availViewData[0] =  
			{
				"availNo": 1,
				"depCd": depCd,
				"arrCd": arrCd,
				"depNm": depNm,
				"arrNm": arrNm,
				"depDt": depDt,
				"arrDt": arrDt
			};
		
		availData[0] = 
			{
				"availNo": 1,
				"depCd": depCd,
				"arrCd": arrCd,
				"depDt": depDt,
				"arrDt": arrDt
			};

	} else if (availTy == 'MT') {
		var availCnt = availGroup.find('input[name="mtcnt"]').length;
		console.log(">>>>>>>>> MT >>>>>>>>>> availTy  : " + availTy + " availCnt : " + availCnt);
		
	/*	var depCd = availGroup.find('input[name="depCd"]').val();						//출발도시
		var arrCd = availGroup.find('input[name="arrCd"]').val();                      //도착도시
		var depNm = availGroup.find('input[name="depNm"]').val();     					//출발도시명
		var arrNm = availGroup.find('input[name="arrNm"]').val();						//도착도시명
		var depDt = availGroup.find('input[name="depDt"]').val();                          //출발일
		var arrDt = availGroup.find('input[name="retDt"]').val();                          //귀국일
		*/
		for(var mt_idx=0; mt_idx < availCnt; mt_idx++){
			
			var depCdVal;
			var arrCdVal;
			var depNmVal;
			var arrNmVal;
			var depDtVal;
			
			if(mt_idx < 1) {
				depCdVal = availGroup.find('#srch_dep_ct').text();
				depNmVal = availGroup.find('#srch_dep_ct_dis').text();
				arrCdVal = availGroup.find('#srch_arr_ct').text();			
				arrNmVal = availGroup.find('#srch_arr_ct_dis').text();
				depDtVal = availGroup.find('#dep_dt').text().replace(/\./g, '');
			} else {
				var tag1 = "#srch_dep_ct" + (mt_idx+1);
				var tag2 = "#srch_dep_ct_dis" + (mt_idx+1);
				var tag3 = "#srch_arr_ct" + (mt_idx+1);
				var tag4 = "#srch_arr_ct_dis" + (mt_idx+1);
				var tag5 = "#dep_dt" + (mt_idx+1);

				depCdVal = availGroup.find(tag1).text();
				depNmVal = availGroup.find(tag2).text();
				arrCdVal = availGroup.find(tag3).text();			
				arrNmVal = availGroup.find(tag4).text();
				depDtVal = availGroup.find(tag5).text().replace(/\./g, '');
			}
			/** 
			console.log(">>>>>>>> " + mt_idx+ " depCdVal : " + depCdVal);
			console.log(">>>>>>>> " + mt_idx+ " arrCdVal : " + arrCdVal);
			console.log(">>>>>>>> " + mt_idx+ " depNmVal : " + depNmVal);
			console.log(">>>>>>>> " + mt_idx+ " arrNmVal : " + arrNmVal);
			console.log(">>>>>>>> " + mt_idx+ " depDtVal : " + depDtVal);
			**/

			if(depCdVal == '') {
				alert((mt_idx+1) + '번째 출발 도시를 입력해 주세요.');
				return false;
			}
			
			if(arrCdVal == '') {
				alert((mt_idx+1) + '번째 도착 도시를 입력해 주세요.');
				return false;
			}
			
			if(depDtVal == '') {
				alert((mt_idx+1) + '번째 출발 일자를 선택해 주세요.');
				return false;
			}
			
			availViewData[mt_idx] =  
			{
				"availNo": mt_idx+1,
				"depCd": depCdVal,
				"arrCd": arrCdVal,
				"depNm": depNmVal,
				"arrNm": arrNmVal,
				"depDt": depDtVal,
				"arrDt": ''
			};

			// console.log(availViewData[mt_idx]);


			availData[mt_idx] = 
			{
				"availNo": mt_idx+1,
				"depCd": depCdVal,
				"arrCd": arrCdVal,
				"depDt": depDtVal,
				"arrDt": ''
			};

			// console.log(availData[mt_idx]);
		}
		
	} else {
		alert('여정 타입을 선택해 주세요.');
		return false;
	}

	//공통 사항 유효성 검사 (인원, 좌석클래스)
	var cabinClas = availGroup.find('select#cabinClas option:selected').val();			//좌석 클래스
	var cabinClasNm = availGroup.find('select#cabinClas option:selected').text();		//좌석 클래스명
	var adtCnt = availGroup.find('#adtCnt').text();		//성인 탑승객 수
	var chdCnt = availGroup.find('#chdCnt').text();		//아동 탑승객 수
	var infCnt = availGroup.find('#infCnt').text();		//유아 탑승객 수
	/**	
	console.log("cabinClas : " + cabinClas);
	console.log("cabinClasNm : " + cabinClasNm);
	console.log("adtCnt : " + adtCnt);
	console.log("chdCnt : " + chdCnt);
	console.log("infCnt : " + infCnt);
	**/
	var carrierCd = ''; //선호 항공사 - 없음
	
	if(parseInt(adtCnt) == 0) {
		alert('탑승객 수를 선택해 주세요.');
		return false;
	}
			
	// 유아는 어른 수를 초과 할 수 없다
	if(parseInt(infCnt) > parseInt(adtCnt)) {
		alert('성인 1명에 유아 1명만을 예약하실수 있으며, \n나머지 유아는 어린이로 예약하셔야 합니다.');
		// $('select[name="infCnt"] option[value="0"]').prop(':selected');
		return false;
	}
	
	// 전체 합이 9명을 초과할 수 없다
	if((parseInt(adtCnt) + parseInt(chdCnt) + parseInt(infCnt)) > 9) {
		alert('총인원이 9명을 넘을 수 없습니다.');
		// $('select[name="adtCnt"] option[value="0"]').prop(':selected');
		// $('select[name="chdCnt"] option[value="0"]').prop(':selected');
		// $('select[name="infCnt"] option[value="0"]').prop(':selected');
		return false;
	}
	
	// 항공사 전체 조회 처리
	if(carrierCd == undefined || carrierCd == 'A'){
		carrierCd = '';
	}
	
	// console.log("carrierCd : " + carrierCd);
	
	var f_form = $('#f_frm');
	var concMix = (f_form.find('input[name="selAir"]').val()=='Y'?'A':'X')
					+	(f_form.find('input[name="selHotel"]').val()=='Y'?'H':'X')	//렌터카는 조합에서 제외 
					+	(f_form.find('input[name="selRentcar"]').val()=='Y'?'C':'X');

	console.log("concMix : " + concMix);
		
	// 해외 출발일 경우 왕복 으로 처리함
	sessionStorage.availTy = availTy;
	if(availTy == 'OO') availTy = 'RT';

	var airViewData = {
		"bodyDto": 
		{
			"cabinClas"		: cabinClas,
			"cabinClasNm"	: cabinClasNm,
			"availTy"		: availTy,
			"adtCnt"		: adtCnt,
			"chdCnt"		: chdCnt,
			"infCnt"		: infCnt,
			"carrierCd"		: carrierCd,
			"availGroup"	: availViewData
		}
	};
	
	var airSearchData = {
			"bodyDto": 
			{
				"cabinClas"	: cabinClas,
				"availTy"	: availTy,
				"adtCnt"	: adtCnt,
				"chdCnt"	: chdCnt,
				"infCnt"	: infCnt,
				"carrierCd"	: carrierCd,
				"availGroup": availData,
				"routeTy"	: "I",
				'concMix'	: concMix
			}
		};	
	//window.localStorage['airViewData'] = JSON.stringify(airViewData);
	sessionStorage.airViewData = JSON.stringify(airViewData);
	setCookieValue('airViewData', JSON.stringify(airViewData));
	//window.localStorage['airSearchData'] = JSON.stringify(airSearchData);
	sessionStorage.airSearchVal = JSON.stringify(airSearchData);
	setCookieValue('airSearchVal', JSON.stringify(airSearchData));
	
	return true;
}

//재검색값 세팅
function fn_set_air_research_value() {
	
	var air_div = $('#air_research_div');
	
	// var availTy = air_div.find('input:radio[name="availTy"]:checked').val();        //여정 타입
	var availTy = air_div.find('.tablist_com').find('.active').find('button').attr('value');        //여정 타입
	console.log("availTy : " + availTy);
	// 여정별 일정 유효성 검사
	var availViewData = [];
	var availData = [];
	
	var availGroup = $('div[ft-att="' + availTy + 'Group"]');

	var depCd = availGroup.find('#srch_dep_ct');						//출발도시
	var arrCd = availGroup.find('#srch_arr_ct');                      	//도착도시
	var depNm = availGroup.find('#srch_dep_ct_dis');     				//출발도시명
	var arrNm = availGroup.find('#srch_arr_ct_dis');					//도착도시명
	var depDt = availGroup.find('#dep_dt');                          	//출발일
	var arrDt = availGroup.find('#arr_dt');                          	//귀국일
	/**	
	console.log("depCd : " + depCd);
	console.log("arrCd : " + arrCd);
	console.log("depNm : " + depNm);
	console.log("arrNm : " + arrNm);
	console.log("depDt : " + depDt);
	console.log("arrDt : " + arrDt);
	**/

	if(availTy == 'RT' || availTy == 'OW' || availTy == 'OO') {	//왕복,편도 유효성 검사
		depCd = depCd.text();
		arrCd = arrCd.text();
		depNm = depNm.text();
		arrNm = arrNm.text();
		depDt = depDt.text(); 
		// arrDt = arrDt.text();

		console.log("depCd : " + depCd);
		console.log("arrCd : " + arrCd);
		console.log("depNm : " + depNm);
		console.log("arrNm : " + arrNm);
		
		console.log("depDt : " + depDt);


		if(arrCd == '' || arrCd == '도착') {
			alert('도착 도시를 입력해 주세요.');
			return false;
		}
		
		if(depDt == '') {
			alert('출국 일자를 선택해 주세요.');
			return false;
		}

		
		depDt = depDt.replace(/\./g, '');
		console.log("depDt : " + depDt);

		if(availTy == 'RT' || availTy == 'OO') {
			arrDt = arrDt.text(); 
		
			if(arrDt == '' || arrDt == '미지정') {
				alert('귀국 일자를 선택해 주세요.');
				return false;
			}
			
			arrDt = arrDt.replace(/\./g, '');
			
			var chk_date_valid = calcInterval(depDt, '0000', arrDt, '0000').split(',');
			
			if(chk_date_valid[0] < 0){
				alert('올바른 일자를 선택해 주세요');
				return false;
			}
		} else {
			arrDt = ''; 
		}

		console.log(">>>>>>>>>>> depDt : " + depDt);
		console.log(">>>>>>>>>>> arrDt : " + arrDt);

		availViewData[0] =  
			{
				"availNo": 1,
				"depCd": depCd,
				"arrCd": arrCd,
				"depNm": depNm,
				"arrNm": arrNm,
				"depDt": depDt,
				"arrDt": arrDt
			};
		
		availData[0] = 
			{
				"availNo": 1,
				"depCd": depCd,
				"arrCd": arrCd,
				"depDt": depDt,
				"arrDt": arrDt
			};

	} else if (availTy == 'MT') {
		var availCnt = availGroup.find('input[name="mtcnt"]').length;
		console.log(">>>>>>>>> MT >>>>>>>>>> availTy  : " + availTy + " availCnt : " + availCnt);
		
	/*	var depCd = availGroup.find('input[name="depCd"]').val();						//출발도시
		var arrCd = availGroup.find('input[name="arrCd"]').val();                      //도착도시
		var depNm = availGroup.find('input[name="depNm"]').val();     					//출발도시명
		var arrNm = availGroup.find('input[name="arrNm"]').val();						//도착도시명
		var depDt = availGroup.find('input[name="depDt"]').val();                          //출발일
		var arrDt = availGroup.find('input[name="retDt"]').val();                          //귀국일
		*/
		for(var mt_idx=0; mt_idx < availCnt; mt_idx++){
			
			var depCdVal;
			var arrCdVal;
			var depNmVal;
			var arrNmVal;
			var depDtVal;
			
			if(mt_idx < 1) {
				depCdVal = availGroup.find('#srch_dep_ct').text();
				depNmVal = availGroup.find('#srch_dep_ct_dis').text();
				arrCdVal = availGroup.find('#srch_arr_ct').text();			
				arrNmVal = availGroup.find('#srch_arr_ct_dis').text();
				depDtVal = availGroup.find('#dep_dt').text().replace(/\./g, '');
			} else {
				var tag1 = "#srch_dep_ct" + (mt_idx+1);
				var tag2 = "#srch_dep_ct_dis" + (mt_idx+1);
				var tag3 = "#srch_arr_ct" + (mt_idx+1);
				var tag4 = "#srch_arr_ct_dis" + (mt_idx+1);
				var tag5 = "#dep_dt" + (mt_idx+1);

				depCdVal = availGroup.find(tag1).text();
				depNmVal = availGroup.find(tag2).text();
				arrCdVal = availGroup.find(tag3).text();			
				arrNmVal = availGroup.find(tag4).text();
				depDtVal = availGroup.find(tag5).text().replace(/\./g, '');
			}
			
			console.log(">>>>>>>> " + mt_idx+ " depCdVal : " + depCdVal);
			console.log(">>>>>>>> " + mt_idx+ " arrCdVal : " + arrCdVal);
			console.log(">>>>>>>> " + mt_idx+ " depNmVal : " + depNmVal);
			console.log(">>>>>>>> " + mt_idx+ " arrNmVal : " + arrNmVal);
			console.log(">>>>>>>> " + mt_idx+ " depDtVal : " + depDtVal);
			

			if(depCdVal == '') {
				alert((mt_idx+1) + '번째 출발 도시를 입력해 주세요.');
				return false;
			}
			
			if(arrCdVal == '') {
				alert((mt_idx+1) + '번째 도착 도시를 입력해 주세요.');
				return false;
			}
			
			if(depDtVal == '') {
				alert((mt_idx+1) + '번째 출발 일자를 선택해 주세요.');
				return false;
			}
			
			availViewData[mt_idx] =  
			{
				"availNo": mt_idx+1,
				"depCd": depCdVal,
				"arrCd": arrCdVal,
				"depNm": depNmVal,
				"arrNm": arrNmVal,
				"depDt": depDtVal,
				"arrDt": ''
			};

			// console.log(availViewData[mt_idx]);


			availData[mt_idx] = 
			{
				"availNo": mt_idx+1,
				"depCd": depCdVal,
				"arrCd": arrCdVal,
				"depDt": depDtVal,
				"arrDt": ''
			};

			// console.log(availData[mt_idx]);
		}
		
	} else {
		alert('여정 타입을 선택해 주세요.');
		return false;
	}

	//공통 사항 유효성 검사 (인원, 좌석클래스)
	var cabinClas = availGroup.find('select#cabinClas option:selected').val();			//좌석 클래스
	var cabinClasNm = availGroup.find('select#cabinClas option:selected').text();		//좌석 클래스명
	var adtCnt = availGroup.find('#adtCnt').text();		//성인 탑승객 수
	var chdCnt = availGroup.find('#chdCnt').text();		//아동 탑승객 수
	var infCnt = availGroup.find('#infCnt').text();		//유아 탑승객 수
		
	console.log("cabinClas : " + cabinClas);
	console.log("cabinClasNm : " + cabinClasNm);
	console.log("adtCnt : " + adtCnt);
	console.log("chdCnt : " + chdCnt);
	console.log("infCnt : " + infCnt);

	var carrierCd = ''; //선호 항공사 - 없음
	
	if(parseInt(adtCnt) == 0) {
		alert('탑승객 수를 선택해 주세요.');
		return false;
	}
			
	// 유아는 어른 수를 초과 할 수 없다
	if(parseInt(infCnt) > parseInt(adtCnt)) {
		alert('성인 1명에 유아 1명만을 예약하실수 있으며, \n나머지 유아는 어린이로 예약하셔야 합니다.');
		// $('select[name="infCnt"] option[value="0"]').prop(':selected');
		return false;
	}
	
	// 전체 합이 9명을 초과할 수 없다
	if((parseInt(adtCnt) + parseInt(chdCnt) + parseInt(infCnt)) > 9) {
		alert('총인원이 9명을 넘을 수 없습니다.');
		// $('select[name="adtCnt"] option[value="0"]').prop(':selected');
		// $('select[name="chdCnt"] option[value="0"]').prop(':selected');
		// $('select[name="infCnt"] option[value="0"]').prop(':selected');
		return false;
	}
	
	// 항공사 전체 조회 처리
	if(carrierCd == undefined || carrierCd == 'A'){
		carrierCd = '';
	}
	
	console.log("carrierCd : " + carrierCd);
	// 해외 출발일 경우 왕복 으로 처리함
	// 해외 출발일 경우 왕복 으로 처리함
	sessionStorage.availTy = availTy;
	if(availTy == 'OO') availTy = 'RT';

	var airViewData = {
		"bodyDto": 
		{
			"cabinClas"		: cabinClas,
			"cabinClasNm"	: cabinClasNm,
			"availTy"		: availTy,
			"adtCnt"		: adtCnt,
			"chdCnt"		: chdCnt,
			"infCnt"		: infCnt,
			"carrierCd"		: carrierCd,
			"availGroup"	: availViewData
		}
	};
	
	var airSearchData = {
			"bodyDto": 
			{
				"cabinClas"	: cabinClas,
				"availTy"	: availTy,
				"adtCnt"	: adtCnt,
				"chdCnt"	: chdCnt,
				"infCnt"	: infCnt,
				"carrierCd"	: carrierCd,
				"availGroup": availData,
				"routeTy"	: "I"
			}
		};	
	//window.localStorage['airViewData'] = JSON.stringify(airViewData);
	sessionStorage.airViewData = JSON.stringify(airViewData);
	setCookieValue('airViewData', JSON.stringify(airViewData));
	//window.localStorage['airSearchData'] = JSON.stringify(airSearchData);
	sessionStorage.airSearchVal = JSON.stringify(airSearchData);
	setCookieValue('airSearchVal', JSON.stringify(airSearchData));
	
	return true;
}

//항공권 리스트 호출 
function fn_air_list(_data) {
	var concMixVal = "";
	
	if($("#selAir").val() == 'Y'){
		concMixVal = concMixVal + "A";
	}else{
		concMixVal = concMixVal + "X";
	}
	
	if($("#selHotel").val() == "Y"){
		concMixVal = concMixVal + "H";
	}else{
		concMixVal = concMixVal + "X";
	}
	
	if($("#selRentcar").val() == "Y"){
		concMixVal = concMixVal + "C";
	}else{
		concMixVal = concMixVal + "X";
	}
	
	_data.concMix = concMixVal;
	
	gfn_callAjax2 ('/fit/air/listSearchAjax.do', _data, 'successPro');
}

// 팝업 항공권 리스트 호출 
function fn_air_list_pop(_data) {	
	// gfn_callAjax2 ('/fit/air/listSearchAjax.do', _data, 'successPro_pop');
	successPro_pop(air_data);
}

//상세보기 결과값을 담을 임시 전역변수
var tmp_detailData = {};

// 요금규정, 상세보기 팝업 호출시 넘겨줄 데이터 세팅
function fn_setAvailData(_obj) {
	
	var ar_cnt = $(_obj).parents('[ft-att="fare_list"]').attr('ar-cnt');
	var avail_info = air_fix_data[ar_cnt];
	
	var pax_info = JSON.parse(sessionStorage.airSearchVal).bodyDto;	
	
	cdata= {
		"gdsCd"		: avail_info.gdsCd,		
		"availTy"	: pax_info.availTy,	
		"adtCnt"	: pax_info.adtCnt,		
		"chdCnt"	: pax_info.chdCnt,		
		"infCnt"	: pax_info.infCnt
	};
	
	cdata.segmentGroup = [];
	
	for(var seg_idx=0; seg_idx<avail_info.segmentGroup.length; seg_idx++) {
		var availData = avail_info.segmentGroup[seg_idx];
		cdata.segmentGroup[seg_idx] = {
			"availNo"	: availData.availNo,
			"segNo"		: availData.segNo,
			"depCd"		: availData.depCd,
			"fltEquip"	: availData.fltEquip,
			"arrCd"		: availData.arrCd,
			"arrTm"		: availData.arrTm,
			"arrDt"		: availData.arrDt,
			"fltNo"		: availData.fltNo,
			"bookingClas": availData.bookingClas,
			"depDt"		: availData.depDt,
			"carrierCd"	: availData.carrierCd,
			"depTm"		: availData.depTm
		};		
	}
	
	return cdata;
}


//리스트 호출 성공 시 실행 함수
function successPro(_data){
	var data = _data.result.data;
	
	air_direct_data = [];
	air_via_data = [];
		
	if (data.length > 0) {

		//글로벌 변수에 검색결과 넣기
		air_all_data = data;
		
		//항공사 필터링 변수
		var airlineDataArr = filter_var.airlineData;
		
		//좌석 클래스 필터링 변수
		var cabinClasArr = filter_var.cabinClasData;
		
		var inputBody = JSON.parse(sessionStorage.airViewData).bodyDto;
		var setAvailTy = inputBody.availTy;
		var setAdtCnt = inputBody.adtCnt;
		var setChdCnt = inputBody.chdCnt;
		var setInfCnt = inputBody.infCnt;
		var setCabinClas = inputBody.cabinClas;
		var setCabinClasNm = inputBody.cabinClasNm;
		
		for(var i=0; i<data.length; i++){
			var f_date = data[i];
			// 여정 타입 넣어주기
			f_date.availTy = setAvailTy;
			f_date.adtCnt = setAdtCnt;
			f_date.chdCnt = setChdCnt;
			f_date.infCnt = setInfCnt;
			f_date.cabinClas = setCabinClas;
			f_date.cabinClasNm = setCabinClasNm;

			// 성인 요금 합계(항공운임, 세금) -  tasfCharge = 제세공과금, 유류, TASF
			var adtChargeInfo = f_date.paxDataBean[0];
			var totCharge = adtChargeInfo.fareCharge + adtChargeInfo.taxCharge;
			
			/*if(adtChargeInfo.discntCharge != 0){
				totCharge = totCharge - adtChargeInfo.discntCharge;
			}
			
			if(adtChargeInfo.upCharge != 0){
				totCharge = totCharge + adtChargeInfo.upCharge;
			}*/

			/* 프로모션 적용 - 20170420 추가 */
			if (adtChargeInfo.promInfo != undefined && adtChargeInfo.promInfo.promId != undefined && adtChargeInfo.promInfo.promId != '') {
				var promData = adtChargeInfo.promInfo;
				//totCharge = promData.aplPromTotal;
				
				if(promData.tyGb == "D"){
					if(promData.diviGb == "R"){
						var discountRate = (100 - parseFloat(promData.amt)) / 100;
						totCharge = totCharge * discountRate;
					}else{
						totCharge = totCharge - parseFloat(promData.amt);
					}
				}else{
					if(promData.diviGb == "R"){
						var promRate = parseFloat(promData.amt) / 100
						totCharge = totCharge + (totCharge * promRate);
					}else{
						totCharge = totCharge + parseFloat(promData.amt)
					}
				}
				
				air_all_data[i].promData = promData;
			}
			air_all_data[i].totCharge = totCharge;

			// TASF 추가 20170324 327 엔진에서 받아옴
			/*
			 * if(tasfObj.length > 0){ for(var fi=0; fi<tasfObj.length; fi++){
			 * var tasfData = tasfObj[fi]; var f_carrierCd = tasfData.carrierCd;
			 * 
			 * if(f_carrierCd == null || f_carrierCd == '' || f_carrierCd ==
			 * f_date.carrierCd){ if(air_all_data[i].adtTasf == undefined){
			 * air_all_data[i].adtTasf = tasfData.adtTasf;
			 * air_all_data[i].chdTasf = tasfData.chdTasf;
			 * air_all_data[i].infTasf = tasfData.infTasf; } else {
			 * air_all_data[i].adtTasf = air_all_data[i].adtTasf >
			 * tasfData.adtTasf ? air_all_data[i].adtTasf : tasfData.adtTasf;
			 * air_all_data[i].chdTasf = air_all_data[i].chdTasf >
			 * tasfData.chdTasf ? air_all_data[i].chdTasf : tasfData.chdTasf;
			 * air_all_data[i].infTasf = air_all_data[i].infTasf >
			 * tasfData.infTasf ? air_all_data[i].infTasf : tasfData.infTasf; } } } }
			 */
			
			// 여정 정보
			var avail_data_bean = data[i].segmentGroup;
			
			var chkStr = '';
			var tmpAvailData = [];
			air_all_data[i].fltData = [];
			
			//기본 리스트에 표시 할 내용 정리
			for(var avail_idx=0;avail_idx<avail_data_bean.length;avail_idx++) {
				
				var avail_data = avail_data_bean[avail_idx];
				
				if(chkStr == '' || chkStr.indexOf(avail_data.availNo) < 0) {
					chkStr = chkStr + avail_data.availNo; // 경유 여부 체크를 위해 여정번호
															// 저장
					tmpAvailData[avail_data.availNo - 1] = {};
					tmpAvailData[avail_data.availNo - 1].depDt = avail_data.depDt;
					tmpAvailData[avail_data.availNo - 1].depTm = avail_data.depTm;
					tmpAvailData[avail_data.availNo - 1].arrDt = avail_data.arrDt;
					tmpAvailData[avail_data.availNo - 1].arrTm = avail_data.arrTm;

					tmpAvailData[avail_data.availNo - 1].arrCd = avail_data.arrCd;
					tmpAvailData[avail_data.availNo - 1].depCd = avail_data.depCd;
					tmpAvailData[avail_data.availNo - 1].arrNm = avail_data.arrNm;
					tmpAvailData[avail_data.availNo - 1].depNm = avail_data.depNm;
					tmpAvailData[avail_data.availNo - 1].segArr = [];
					tmpAvailData[avail_data.availNo - 1].segArr
							.push(avail_data.segNo);

					air_all_data[i].fltData[avail_data.availNo - 1] = {};
					air_all_data[i].fltData[avail_data.availNo - 1].stopYn = '직항';
					air_all_data[i].fltData[avail_data.availNo - 1].segCnt = 1;
				} else {
					var segComp = '';
					var segArr = tmpAvailData[avail_data.availNo - 1].segArr;

					for ( var seg_idx = 0; seg_idx < segArr.length; seg_idx++) {
						if (avail_data.segNo > segArr[seg_idx]) {
							if (segComp == 'D') {
								segComp = 'UD';
								break;
							} else {
								segComp = 'U';
							}
						} else {
							if (segComp == 'U') {
								segComp = 'UD';
								break;
							} else {
								segComp = 'D';
							}
						}
					}

					if (segComp == 'U') {
						tmpAvailData[avail_data.availNo - 1].arrDt = avail_data.arrDt;
						tmpAvailData[avail_data.availNo - 1].arrTm = avail_data.arrTm;

						tmpAvailData[avail_data.availNo - 1].arrCd = avail_data.arrCd;
						tmpAvailData[avail_data.availNo - 1].arrNm = avail_data.arrNm;
					} else if (segComp == 'D') {
						tmpAvailData[avail_data.availNo - 1].depDt = avail_data.depDt;
						tmpAvailData[avail_data.availNo - 1].depTm = avail_data.depTm;

						tmpAvailData[avail_data.availNo - 1].depCd = avail_data.depCd;
						tmpAvailData[avail_data.availNo - 1].depNm = avail_data.depNm;
					}

					tmpAvailData[avail_data.availNo - 1].segArr
							.push(avail_data.segNo);
					air_all_data[i].fltData[avail_data.availNo - 1].stopYn = '경유'; // 여정번호
																					// 중복 시
					air_all_data[i].fltData[avail_data.availNo - 1].segCnt++;
				}
				
				// avail_data.interval = setIntervalText(avail_data.depDt,
				// avail_data.depTm, avail_data.arrDt, avail_data.arrTm);

				avail_data.interval = '';

				var t_eft = avail_data.availEFT;

				tmpAvailData[avail_data.availNo - 1].interval = t_eft
						.substring(0, 2)
						+ '시간 ' + t_eft.substring(2, 4) + '분';
			}
			
			// 각 리스트에 여정 요약 정보 추가
			for ( var tmpi = 0; tmpi < tmpAvailData.length; tmpi++) {
				// air_all_data[i].fltData[tmpi].interval =
				// setIntervalText(tmpAvailData[tmpi].depDt,
				// tmpAvailData[tmpi].depTm, tmpAvailData[tmpi].arrDt,
				// tmpAvailData[tmpi].arrTm);
				air_all_data[i].fltData[tmpi].interval = tmpAvailData[tmpi].interval; // 시간
																						// 계산식
																						// 삭제
				air_all_data[i].fltData[tmpi].arrCd = tmpAvailData[tmpi].arrCd;
				air_all_data[i].fltData[tmpi].depCd = tmpAvailData[tmpi].depCd;
				air_all_data[i].fltData[tmpi].depTm = tmpAvailData[tmpi].depTm;
				air_all_data[i].fltData[tmpi].arrTm = tmpAvailData[tmpi].arrTm;
				air_all_data[i].fltData[tmpi].depDt = tmpAvailData[tmpi].depDt;
				air_all_data[i].fltData[tmpi].arrDt = tmpAvailData[tmpi].arrDt;
				air_all_data[i].fltData[tmpi].depNm = tmpAvailData[tmpi].depNm;
				air_all_data[i].fltData[tmpi].arrNm = tmpAvailData[tmpi].arrNm;
			}

			if (f_date.stopYn == 'N') {
				air_all_data[i].viaTy = 'N';
				filter_var.drtCnt++;
				air_direct_data[air_direct_data.length] = f_date;
			} else {
				if (f_date.numOfStops == 1) {
					air_all_data[i].viaTy = 'Y1';
					filter_var.via1Cnt++;
				} else {
					air_all_data[i].viaTy = 'Y2';
					filter_var.via2Cnt++;
				}
				air_via_data[air_via_data.length] = f_date;
			}

			// 항공사 필터링 값 생성
			if (airlineDataArr != null) {
				var duplFlag = false;

				// filter_var 에 항공코드가 있는경우 cnt++
				for ( var filter_idx = 0; filter_idx < airlineDataArr.length; filter_idx++) {
					if (airlineDataArr[filter_idx].carrierCd == f_date.carrierCd) {
						duplFlag = true;
					}

					if (duplFlag) {
						airlineDataArr[filter_idx].carrierCnt++;
						break;
					}
				}

				// filter_var 에 항공코드가 없는경우
				if (!duplFlag) {
					airlineDataArr[airlineDataArr.length] = {};
					airlineDataArr[airlineDataArr.length - 1].carrierCd = f_date.carrierCd;
					airlineDataArr[airlineDataArr.length - 1].carrierNm = f_date.carrierNm;
					airlineDataArr[airlineDataArr.length - 1].carrierCnt = 1;
				}
			}

			// 좌석등급 필터링 값 생성
			if (cabinClasArr != null) {
				var duplFlag = false;

				// filter_var 에 항공코드가 있는경우 cnt++
				for ( var filter_idx = 0; filter_idx < cabinClasArr.length; filter_idx++) {
					if (cabinClasArr[filter_idx].cabinClas == f_date.cabinClas) {
						duplFlag = true;
					}

					if (duplFlag) {
						cabinClasArr[filter_idx].cabinClasCnt++;
						break;
					}
				}

				// filter_var 에 항공코드가 없는경우
				if (!duplFlag) {
					cabinClasArr[cabinClasArr.length] = {};
					cabinClasArr[cabinClasArr.length - 1].cabinClas = f_date.cabinClas;
					cabinClasArr[cabinClasArr.length - 1].cabinClasNm = f_date.cabinClasNm;
					cabinClasArr[cabinClasArr.length - 1].cabinClasCnt = 1;
				}
			}
		} // end for
		
		// filtering 작성
		// $('[via_type="direct"]').text(filter_var.drtCnt);	// 직항 수
		// $('[via_type="via1"]').text(filter_var.via1Cnt);	// 1번 경유 수
		// $('[via_type="via2"]').text(filter_var.via2Cnt);	// 2번 경유 수
		
		for(var air_fil_idx=0; air_fil_idx<airlineDataArr.length; air_fil_idx++){
			var alData = airlineDataArr[air_fil_idx];

			
		}

		$('#totCnt').html(data.length);	//전체 카운팅

	} else { // 검색된 결과가 없는 경우 
	    	
		$('#totCnt').html('0');
		$('#air_result_nodata_div').show();
		$('#air_result_list_div').hide();
		gfn_loading_bar_draw('hide');

	} // end if

	air_direct_data.sort(sort_by('totCharge', false, parseInt));
	air_via_data.sort(sort_by('totCharge', false, parseInt));
	
	sortAirList();
}

//리스트 호출 성공 시 실행 함수 (팝업)
function successPro_pop(_data){
	var data = _data.result.data;
	
	air_direct_data = [];
	air_via_data = [];

	if (data.length > 0) {

		// 글로벌 변수에 검색결과 넣기
		air_all_data = data;

		// 항공사 필터링 변수
		var airlineDataArr = filter_var.airlineData;

		// 좌석 클래스 필터링 변수
		var cabinClasArr = filter_var.cabinClasData;

		var inputBody = JSON.parse(sessionStorage.airViewData).bodyDto;
		var setAvailTy = inputBody.availTy;
		var setAdtCnt = inputBody.adtCnt;
		var setChdCnt = inputBody.chdCnt;
		var setInfCnt = inputBody.infCnt;
		var setCabinClas = inputBody.cabinClas;
		var setCabinClasNm = inputBody.cabinClasNm;

		// TASF 추가 20170324
		// var tasfObj = JSON.parse(sessionStorage.airTasf);

		for ( var i = 0; i < data.length; i++) {
			var f_date = data[i];

			// 여정 타입 넣어주기
			f_date.availTy = setAvailTy;
			f_date.adtCnt = setAdtCnt;
			f_date.chdCnt = setChdCnt;
			f_date.infCnt = setInfCnt;
			f_date.cabinClas = setCabinClas;
			f_date.cabinClasNm = setCabinClasNm;

			// 성인 요금 합계(항공운임, 세금) -  tasfCharge = 제세공과금, 유류, TASF
			var adtChargeInfo = f_date.paxDataBean[0];
			var totCharge = adtChargeInfo.fareCharge + adtChargeInfo.taxCharge;

			/* 프로모션 적용 - 20170420 추가 */
			if (adtChargeInfo.promInfo != undefined && adtChargeInfo.promInfo.promId != undefined && adtChargeInfo.promInfo.promId != '') {
				var promData = adtChargeInfo.promInfo;
				totCharge = promData.aplPromTotal;
				air_all_data[i].promData = promData;
			}
			air_all_data[i].totCharge = totCharge;

			// TASF 추가 20170324 327 엔진에서 받아옴
			/*
			 * if(tasfObj.length > 0){ for(var fi=0; fi<tasfObj.length; fi++){
			 * var tasfData = tasfObj[fi]; var f_carrierCd = tasfData.carrierCd;
			 * 
			 * if(f_carrierCd == null || f_carrierCd == '' || f_carrierCd ==
			 * f_date.carrierCd){ if(air_all_data[i].adtTasf == undefined){
			 * air_all_data[i].adtTasf = tasfData.adtTasf;
			 * air_all_data[i].chdTasf = tasfData.chdTasf;
			 * air_all_data[i].infTasf = tasfData.infTasf; } else {
			 * air_all_data[i].adtTasf = air_all_data[i].adtTasf >
			 * tasfData.adtTasf ? air_all_data[i].adtTasf : tasfData.adtTasf;
			 * air_all_data[i].chdTasf = air_all_data[i].chdTasf >
			 * tasfData.chdTasf ? air_all_data[i].chdTasf : tasfData.chdTasf;
			 * air_all_data[i].infTasf = air_all_data[i].infTasf >
			 * tasfData.infTasf ? air_all_data[i].infTasf : tasfData.infTasf; } } } }
			 */

			// 여정 정보
			var avail_data_bean = f_date.segmentGroup;

			var chkStr = '';
			var tmpAvailData = [];
			air_all_data[i].fltData = [];

			// 기본 리스트에 표시 할 내용 정리
			for ( var avail_idx = 0; avail_idx < avail_data_bean.length; avail_idx++) {

				var avail_data = avail_data_bean[avail_idx];

				if (chkStr == '' || chkStr.indexOf(avail_data.availNo) < 0) {
					chkStr = chkStr + avail_data.availNo; // 경유 여부 체크를 위해 여정번호
															// 저장
					tmpAvailData[avail_data.availNo - 1] = {};
					tmpAvailData[avail_data.availNo - 1].depDt = avail_data.depDt;
					tmpAvailData[avail_data.availNo - 1].depTm = avail_data.depTm;
					tmpAvailData[avail_data.availNo - 1].arrDt = avail_data.arrDt;
					tmpAvailData[avail_data.availNo - 1].arrTm = avail_data.arrTm;

					tmpAvailData[avail_data.availNo - 1].arrCd = avail_data.arrCd;
					tmpAvailData[avail_data.availNo - 1].depCd = avail_data.depCd;
					tmpAvailData[avail_data.availNo - 1].arrNm = avail_data.arrNm;
					tmpAvailData[avail_data.availNo - 1].depNm = avail_data.depNm;
					tmpAvailData[avail_data.availNo - 1].segArr = [];
					tmpAvailData[avail_data.availNo - 1].segArr
							.push(avail_data.segNo);

					air_all_data[i].fltData[avail_data.availNo - 1] = {};
					air_all_data[i].fltData[avail_data.availNo - 1].stopYn = '직항';
					air_all_data[i].fltData[avail_data.availNo - 1].segCnt = 1;
				} else {
					var segComp = '';
					var segArr = tmpAvailData[avail_data.availNo - 1].segArr;

					for ( var seg_idx = 0; seg_idx < segArr.length; seg_idx++) {
						if (avail_data.segNo > segArr[seg_idx]) {
							if (segComp == 'D') {
								segComp = 'UD';
								break;
							} else {
								segComp = 'U';
							}
						} else {
							if (segComp == 'U') {
								segComp = 'UD';
								break;
							} else {
								segComp = 'D';
							}
						}
					}

					if (segComp == 'U') {
						tmpAvailData[avail_data.availNo - 1].arrDt = avail_data.arrDt;
						tmpAvailData[avail_data.availNo - 1].arrTm = avail_data.arrTm;

						tmpAvailData[avail_data.availNo - 1].arrCd = avail_data.arrCd;
						tmpAvailData[avail_data.availNo - 1].arrNm = avail_data.arrNm;
					} else if (segComp == 'D') {
						tmpAvailData[avail_data.availNo - 1].depDt = avail_data.depDt;
						tmpAvailData[avail_data.availNo - 1].depTm = avail_data.depTm;

						tmpAvailData[avail_data.availNo - 1].depCd = avail_data.depCd;
						tmpAvailData[avail_data.availNo - 1].depNm = avail_data.depNm;
					}

					tmpAvailData[avail_data.availNo - 1].segArr
							.push(avail_data.segNo);
					air_all_data[i].fltData[avail_data.availNo - 1].stopYn = '경유'; // 여정번호
																					// 중복 시
					air_all_data[i].fltData[avail_data.availNo - 1].segCnt++;
				}

				// avail_data.interval = setIntervalText(avail_data.depDt,
				// avail_data.depTm, avail_data.arrDt, avail_data.arrTm);

				avail_data.interval = '';

				var t_eft = avail_data.availEFT;

				tmpAvailData[avail_data.availNo - 1].interval = t_eft
						.substring(0, 2)
						+ '시간 ' + t_eft.substring(2, 4) + '분';
			}

			// 각 리스트에 여정 요약 정보 추가
			for ( var tmpi = 0; tmpi < tmpAvailData.length; tmpi++) {
				// air_all_data[i].fltData[tmpi].interval =
				// setIntervalText(tmpAvailData[tmpi].depDt,
				// tmpAvailData[tmpi].depTm, tmpAvailData[tmpi].arrDt,
				// tmpAvailData[tmpi].arrTm);
				air_all_data[i].fltData[tmpi].interval = tmpAvailData[tmpi].interval; // 시간
																						// 계산식
																						// 삭제
				air_all_data[i].fltData[tmpi].arrCd = tmpAvailData[tmpi].arrCd;
				air_all_data[i].fltData[tmpi].depCd = tmpAvailData[tmpi].depCd;
				air_all_data[i].fltData[tmpi].depTm = tmpAvailData[tmpi].depTm;
				air_all_data[i].fltData[tmpi].arrTm = tmpAvailData[tmpi].arrTm;
				air_all_data[i].fltData[tmpi].depDt = tmpAvailData[tmpi].depDt;
				air_all_data[i].fltData[tmpi].arrDt = tmpAvailData[tmpi].arrDt;
				air_all_data[i].fltData[tmpi].depNm = tmpAvailData[tmpi].depNm;
				air_all_data[i].fltData[tmpi].arrNm = tmpAvailData[tmpi].arrNm;
			}

			if (f_date.stopYn == 'N') {
				air_all_data[i].viaTy = 'N';
				filter_var.drtCnt++;
				air_direct_data[air_direct_data.length] = f_date;
			} else {
				if (f_date.numOfStops == 1) {
					air_all_data[i].viaTy = 'Y1';
					filter_var.via1Cnt++;
				} else {
					air_all_data[i].viaTy = 'Y2';
					filter_var.via2Cnt++;
				}
				air_via_data[air_via_data.length] = f_date;
			}

			// 항공사 필터링 값 생성
			if (airlineDataArr != null) {
				var duplFlag = false;

				// filter_var 에 항공코드가 있는경우 cnt++
				for ( var filter_idx = 0; filter_idx < airlineDataArr.length; filter_idx++) {
					if (airlineDataArr[filter_idx].carrierCd == f_date.carrierCd) {
						duplFlag = true;
					}

					if (duplFlag) {
						airlineDataArr[filter_idx].carrierCnt++;
						break;
					}
				}

				// filter_var 에 항공코드가 없는경우
				if (!duplFlag) {
					airlineDataArr[airlineDataArr.length] = {};
					airlineDataArr[airlineDataArr.length - 1].carrierCd = f_date.carrierCd;
					airlineDataArr[airlineDataArr.length - 1].carrierNm = f_date.carrierNm;
					airlineDataArr[airlineDataArr.length - 1].carrierCnt = 1;
				}
			}

			// 좌석등급 필터링 값 생성
			if (cabinClasArr != null) {
				var duplFlag = false;

				// filter_var 에 항공코드가 있는경우 cnt++
				for ( var filter_idx = 0; filter_idx < cabinClasArr.length; filter_idx++) {
					if (cabinClasArr[filter_idx].cabinClas == f_date.cabinClas) {
						duplFlag = true;
					}

					if (duplFlag) {
						cabinClasArr[filter_idx].cabinClasCnt++;
						break;
					}
				}

				// filter_var 에 항공코드가 없는경우
				if (!duplFlag) {
					cabinClasArr[cabinClasArr.length] = {};
					cabinClasArr[cabinClasArr.length - 1].cabinClas = f_date.cabinClas;
					cabinClasArr[cabinClasArr.length - 1].cabinClasNm = f_date.cabinClasNm;
					cabinClasArr[cabinClasArr.length - 1].cabinClasCnt = 1;
				}
			}
		} // end for
		
		// filtering 작성
		$('[via_type="direct"]').text("직항(" + filter_var.drtCnt + ")");	// 직항 수
		$('[via_type="via1"]').text("1경유(" + filter_var.via1Cnt + ")");	// 1번 경유 수
		$('[via_type="via2"]').text("2경유(" + filter_var.via2Cnt + ")");	// 2번 경유 수
		
		//항공사 filtering 작성
		var fil_airline_str = '<dt>항공사</dt>';
		fil_airline_str += '<dd>';
		fil_airline_str += '	<p class="chkbox">';
		fil_airline_str += '		<span><input type="checkbox" title="전체" class="checks" ar_att="filter_chk" name="fil_air_line" value="ALL" checked="checked" /></span>';
		fil_airline_str += '		<label for="check01">전체</label>';       
		fil_airline_str += '	</p>';                                   
		fil_airline_str += '</dd>';                                         
		for(var air_fil_idx=0; air_fil_idx<airlineDataArr.length; air_fil_idx++){
			var alData = airlineDataArr[air_fil_idx];
			fil_airline_str += '<dd>';
			fil_airline_str += '	<p class="chkbox">';
			fil_airline_str += '		<span><input type="checkbox" title="' + alData.carrierNm + '" class="checks" ar_att="filter_chk" name="fil_air_line" value="' + alData.carrierCd + '" /></span>';
			fil_airline_str += '		<label for="check01">' + alData.carrierNm + '(' + alData.carrierCnt + ')</label>';
			fil_airline_str += '	</p>';
			fil_airline_str += '</dd>';
		}
		
		$('dl[ft-att="fil_airline_div"]').html(fil_airline_str);
		
		//좌석등급 필터링 작성 
		var fil_cabinClas_str = '<dt>좌석</dt>';
		fil_cabinClas_str += '<dd>';
		fil_cabinClas_str += '	<p class="chkbox">';
		fil_cabinClas_str += '		<span><input type="checkbox" title="전체" class="checks" ar_att="filter_chk" name="fil_class_type" value="ALL" checked="checked" /></span>';
		fil_cabinClas_str += '		<label for="check01">전체</label>';
		fil_cabinClas_str += '	</p>';
		fil_cabinClas_str += '</dd>';
		for(var cls_fil_idx=0; cls_fil_idx<cabinClasArr.length; cls_fil_idx++){
			var clsData = cabinClasArr[cls_fil_idx];
			fil_cabinClas_str += '<dd>';
			fil_cabinClas_str += '	<p class="chkbox">';
			fil_cabinClas_str += '		<span><input type="checkbox" title="' + clsData.cabinClasNm + '" class="checks" ar_att="filter_chk" name="fil_class_type" value="' + clsData.cabinClas + '" /></span>';
			fil_cabinClas_str += '		<label for="check01">' + clsData.cabinClasNm + '(' + clsData.cabinClasCnt + ')</label>';
			fil_cabinClas_str += '	</p>';
			fil_cabinClas_str += '</dd>';
		}
		
		$('dl[ft-att="fil_cabinClas_div"]').html(fil_cabinClas_str);
		
		$('#totCnt').html(data.length);	//전체 카운팅
		
		//체크박스 checkbox 처리
		$('input:checkbox[ar_att="filter_chk"]').on('click', fn_act_filter_pop);
		
	} else {
		//검색결과가 없습니다.
	} // end if

	air_direct_data.sort(sort_by('totCharge', false, parseInt));
	air_via_data.sort(sort_by('totCharge', false, parseInt));
	
	sortAirList();
}


//리스트 정렬
function sortAirList(){
	var sortFlag = $('#air_sort').data('airsort');
	sel_page = 0;
	console.log(">>>>>>>>>>>>>>>>>>> sortAirList() :: " + sortFlag);
	
	if(sortFlag == 'B') {
		console.log(">>>>>>>>>>>>>>>>>>> sortAirList() >>  최저 요금 순");		

		air_sort_data = air_all_data;
		air_sort_data.sort(sort_by('totCharge', false, parseInt));
		
		$("#air_sort").html("최저 요금 순");


	} else if(sortFlag == 'C') {
		console.log(">>>>>>>>>>>>>>>>>>> sortAirList() >> 직항+최저 요금 순");
		air_sort_data = air_direct_data.concat(air_via_data);
		$("#air_sort").html("직항+최저 요금 순");

	} else {
		console.log('정렬실패');
	}

	air_fix_data = air_sort_data;

	console.log(">>>>>>>>>>>>>>>>>>> air_fix_data.length : " + air_fix_data.length);
	
	// console.log("air_fix_data.length : " + air_fix_data.length);
	// $('[ft-att="fare_div"]').html('');
	$("#air_result_list_div").html('');
	$('[ft-att="fare_div"]').html('');
	
	filterAirList();
}

//정렬 함수
var sort_by = function(field, reverse, primer){
    reverse = (reverse) ? -1 : 1;
    return function(a,b){
        a = a[field];
        b = b[field];
        if (typeof(primer) != 'undefined'){
            a = primer(a);
            b = primer(b);
        }
        if (a<b) return reverse * -1;
        if (a>b) return reverse * 1;
        return 0;
    };
};

// 항공 검색 결과 화면에서 선택담기 라디오 버튼을 선택했을 경우 
function fn_airSelectCnt(arCnt) {
	console.log("arCnt : " + arCnt);
	
	var selAir = [];
	selAir[0] = air_fix_data[arCnt];
	sessionStorage.airSelGdsCd = selAir[0].gdsCd;
	sessionStorage.airSelData = JSON.stringify(selAir); 
	// console.log(">>>>>>>>>>>>>>>>>>> fn_airSelectCnt() ");
	// console.log(sessionStorage.airSelData);
	// console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

}

//리스트 필터링
function filterAirList() {
	console.log(">>>>>>>>>>>>>>>>>>> filterAirList() ");


	
	
	filter_info.fil_via_type 	= [];
	filter_info.fil_class_type	= [];
	filter_info.fil_air_line 	= [];
	filter_info.fil_dep_tm 		= [];
	filter_info.fil_fare_type	= [];

	var nfil_via_type	= filter_info.fil_via_type;   
	var nfil_class_type	= filter_info.fil_class_type; 
	var nfil_air_line	= filter_info.fil_air_line;	
	var nfil_dep_tm		= filter_info.fil_dep_tm;     
	var nfil_fare_type	= filter_info.fil_fare_type;  
	
	//항목별 체크박스 그룹
	 
	var via_chk_group 	= $('[ar_att="filter_chk"][name="fil_via_type"]');
	var class_chk_group	= $('[ar_att="filter_chk"][name="fil_class_type"]');
	var line_chk_group 	= $('[ar_att="filter_chk"][name="fil_air_line"]');
	var dep_chk_group 	= $('[ar_att="filter_chk"][name="fil_dep_tm"]');
	var fare_chk_group 	= $('[ar_att="filter_chk"][name="fil_fare_type"]');


	/**
	console.log("filterAirList() >>>> via_chk_group : " + via_chk_group);
	console.log("filterAirList() >>>> class_chk_group : " + class_chk_group);
	console.log("filterAirList() >>>> line_chk_group : " + line_chk_group);
	console.log("filterAirList() >>>> dep_chk_group : " + dep_chk_group);
	console.log("filterAirList() >>>> fare_chk_group : " + fare_chk_group);
	**/
	//전체 체크 여부
	 
	var viaAllChk 	= via_chk_group.eq(0).is(':checked');
	var classAllChk	= class_chk_group.eq(0).is(':checked');
	var lineAllChk 	= line_chk_group.eq(0).is(':checked');
	var depAllChk 	= dep_chk_group.eq(0).is(':checked');
	var fareAllChk 	= fare_chk_group.eq(0).is(':checked');
	/**
	console.log("filterAirList() >>>> viaAllChk : " + viaAllChk);
	console.log("filterAirList() >>>> classAllChk : " + classAllChk);
	console.log("filterAirList() >>>> lineAllChk : " + lineAllChk);
	console.log("filterAirList() >>>> depAllChk : " + depAllChk);
	console.log("filterAirList() >>>> fareAllChk : " + fareAllChk);
	**/
	var air_via_chk_group 	= $('[ar_att="filter_chk"][name="air_fil_via_type"]').val();
	var air_class_chk_group	= $('[ar_att="filter_chk"][name="air_fil_class_type"]').val();
	var air_line_chk_group 	= $('[ar_att="filter_chk"][name="air_fil_air_line"]').val();
	var air_dep_chk_group 	= $('[ar_att="filter_chk"][name="air_fil_dep_tm"]').val();
	var air_fare_chk_group 	= $('[ar_att="filter_chk"][name="air_fil_fare_type"]').val();
	/**
	console.log("filterAirList() >>>> air_via_chk_group : " + air_via_chk_group);
	console.log("filterAirList() >>>> air_class_chk_group : " + air_class_chk_group);
	console.log("filterAirList() >>>> air_line_chk_group : " + air_line_chk_group);
	console.log("filterAirList() >>>> air_dep_chk_group : " + air_dep_chk_group);
	console.log("filterAirList() >>>> air_fare_chk_group : " + air_fare_chk_group);
	console.log(">>>>>>>>>>>>> " + air_via_chk_group.indexOf('ALL'));
	**/
	if(air_via_chk_group.indexOf('ALL') != -1) {
		viaAllChk = true;
	}

	if(air_class_chk_group.indexOf('ALL') != -1) {
		classAllChk = true;
	}
	if(air_line_chk_group.indexOf('ALL') != -1) {
		lineAllChk = true;
	}
	if(air_dep_chk_group.indexOf('ALL') != -1) {
		depAllChk = true;
	}
	if(air_fare_chk_group.indexOf('ALL') != -1) {
		fareAllChk = true;
	}
	/**
	console.log("filterAirList() >>>> viaAllChk : " + viaAllChk);
	console.log("filterAirList() >>>> classAllChk : " + classAllChk);
	console.log("filterAirList() >>>> lineAllChk : " + lineAllChk);
	console.log("filterAirList() >>>> depAllChk : " + depAllChk);
	console.log("filterAirList() >>>> fareAllChk : " + fareAllChk);
	**/

	//경유 체크 정보
	if(via_chk_group != null) {
		for(var idx=0; idx<via_chk_group.length; idx++) {
			if(via_chk_group.eq(idx).is(':checked')) {
				nfil_via_type[nfil_via_type.length] = via_chk_group.eq(idx).val();	
			}		
		}
	}
	//좌석등급 체크 정보
	if(class_chk_group != null) { 
		for(var idx=0; idx<class_chk_group.length; idx++) {
			if(class_chk_group.eq(idx).is(':checked')) {
				nfil_class_type[nfil_class_type.length] = class_chk_group.eq(idx).val();
			}
		}
	}
	//항공사 체크 정보

	if(line_chk_group != null) {	
		for(var idx=0; idx<line_chk_group.length; idx++) {
			if(line_chk_group.eq(idx).is(':checked')) {
				nfil_air_line[nfil_air_line.length] = line_chk_group.eq(idx).val();	
			}		
		}
	}
	//출발시간 체크 정보
	if(dep_chk_group != null) {	
		for(var idx=0; idx<dep_chk_group.length; idx++) {
			if(dep_chk_group.eq(idx).is(':checked')) {
				nfil_dep_tm[nfil_dep_tm.length] = dep_chk_group.eq(idx).val();	
			}
			
		}
	}

	//요금구분 체크 정보
	if(fare_chk_group != null) {
		for(var idx=0; idx<fare_chk_group.length; idx++) {
			if(fare_chk_group.eq(idx).is(':checked')) {
				nfil_fare_type[nfil_fare_type.length] = fare_chk_group.eq(idx).val();	
			}		
		}
	}
	
	$('[ft-att="fare_div"]').html('');	
	// 리스트 초기화
	air_fix_data = [];
	
	for(var setIdx=0; setIdx<air_sort_data.length; setIdx++ ) {
		var view_yn = false;
		
		if(!viaAllChk) {
			for(var vidx=0; vidx<filter_info.fil_via_type.length; vidx++) {
				if(filter_info.fil_via_type[vidx] == air_sort_data[setIdx].viaTy) {
					view_yn = true;
					break;
				}
			}
			
			if(!view_yn) {
				continue;
			}
			
			view_yn = false;
		}
		
		if(!classAllChk) {
			/* 뭐랑 비교해야할지 모르겠음
			air_sort_data[setIdx].segmentGroup[0].cabinClass
			
			for(var vidx=0; vidx<filter_info.fil_class_type.length; vidx++) {
				if(filter_info.fil_class_type[vidx] == air_sort_data[setIdx].viaTy) {
					view_yn = true;
					break;
				}
			}
			
			if(!view_yn) {
				continue;
			}
			
			view_yn = false;
			*/
		}
		
		if(filter_info.fil_air_line != null) {
			if(!lineAllChk) {
				for(var vidx=0; vidx<filter_info.fil_air_line.length; vidx++) {
					if(filter_info.fil_air_line[vidx] == air_sort_data[setIdx].carrierCd) {
						view_yn = true;
						break;
					}
				}
				
				if(!view_yn) {
					continue;
				}
				
				view_yn = false;
			}
		}

		if(filter_info.fil_dep_tm != null) {
			if(!depAllChk) {
				// 3:00 ~ 11:59, 12:00 ~ 16:59, 17:00 ~ 2:59
				
				for(var vidx=0; vidx<filter_info.fil_dep_tm.length; vidx++) {
					var sttTm = filter_info.fil_dep_tm[vidx].substring(0, 2) + '00';
					var endTm = filter_info.fil_dep_tm[vidx].substring(2, 4) + '00';
					
					var tdepTm = air_sort_data[setIdx].fltData[0].depTm; 
					if(sttTm < endTm) {
						if(sttTm <= tdepTm && tdepTm < endTm) {
							view_yn = true;
							break;
						}							
					} else {
						if(sttTm <= tdepTm || tdepTm < endTm) {
							view_yn = true;
							break;
						}
					}
				}
				
				if(!view_yn) {
					continue;
				}
				
				view_yn = false;
			}
		}
		if(!fareAllChk) {	// 요금 유형에 대한 정보 없음
			/* air_sort_data[setIdx].paxDataBean[0].fareDataBean[0].fareTy;
	 		for(var vidx=0; vidx<filter_info.fil_fare_type.length; vidx++) {
				if(filter_info.fil_fare_type[vidx] == air_sort_data[setIdx].carrierCd) {
					view_yn = true;
					break;
				}
			}
			*/
		}
		
		air_fix_data[air_fix_data.length] = air_sort_data[setIdx];
		
	} // for end

	var tot_data_cnt = e_cnt; 
	if(air_fix_data.length < e_cnt){
		tot_data_cnt = air_fix_data.length; 

		
	} 
	

	//페이징 처리
	$('[ft-att="fare_div"]').html('');
	//페이징 영역, 전체데이터수, 페이지 이동 함수, 페이지 당 표시 개수
	// var pagingInfo = pagingjs.init($('div.pagination'), air_fix_data.length, 'fn_air_paging', tot_data_cnt);
	var pagingend = air_fix_data.length/10; 
	
	var s_cnt = sel_page * 10 + 1;
	var e_cnt = (sel_page + 1) * 10;

	// viewAirList(pagingInfo.start, pagingInfo.end);
	viewAirList(s_cnt, e_cnt);
}


//페이지 이동 함수
function fn_air_paging(){
	console.log("fn_air_paging() >>>>>>>>>>>>>>>> ");
	var pagingend = air_fix_data.length/10; 
	if(sel_page < pagingend) {
		sel_page = sel_page + 1;
	} else {
		sel_page = pagingend;
	}

	var s_cnt = sel_page * 10 + 1;
	var e_cnt = (sel_page + 1) * 10;
	/** 
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
	
	**/
	// var pagingInfo = pagingjs.mvpage(sel_page);
	
	// if(pagingInfo.start > 0 && pagingInfo.end > 0) {
	// 	$('[ft-att="fare_div"]').html('');
	
		viewAirList(s_cnt, e_cnt);
	// }	
}



//리스트 출력
function viewAirList(_s_cnt, _e_cnt) {
	gfn_loading_bar_draw('show');
	// console.log("viewAirList() >>>>>>>>>>>>>>>> _s_cnt : " + _s_cnt + " _e_cnt : " + _e_cnt);
 	// console.log(">>>>>>>>>>>>>>>>>>> viewAirList() _s_cnt : " + _s_cnt + " _e_cnt : " + _e_cnt);

	for(var i=_s_cnt-1; i<_e_cnt; i++){
		// var fare_div = $('[ft-att="fare_div_temp"]:first').clone().show();
		var fare_data = air_fix_data[i];
		var paxCntInfo = fare_data.paxDataBean[0];
		var paxCnt = paxCntInfo.paxCnt;
		//alert(fare_data.totSaleCharge-0 + " // " + ((fare_data.totTasfCharge-0) * paxCnt));
		
		// console.log(fare_data);
		
		// console.log(">>>>>>>>>>>>>>>>>>> 1 ");
		// console.log(">>>>>>>>>>>>>>>>>>> fare_data : " + fare_data);
		if(fare_data != null) {
			var shareNmVal = "";
			var html = "";
			html = html + "			<ul class='fr_porlist' ft-att='fare_div'>";
			html = html + "				<li ft-att='fare_list' ar-cnt='"+i+"' onClick='fn_airSelectCnt(" + i + ")'>";
			html = html + "					<span class='radioboxs'><input type='radio' name='air_seq' id='air_seq_ "+ i + "' class='air_radio_btn' data-role='none'></span>";
			html = html + "					<label for='air_seq_ "+ i + "'><img src='/resources/images/air/" + fare_data.carrierCd + ".png' alt='' />"+fare_data.carrierNm+"</label>";
			html = html + "					<div class='fr_probtn'>";
			html = html + "						<button type='button' class='layerOpener' data-url='/pop/pop_air_viewdetail.do?ar_cnt=" +i+ "' data-role='none' data-ok='yes' data-ctn='full'>상세보기</button>";
			html = html + "						<button type='button' class='layerOpener' data-url='/pop/pop_pay_guide.do?ar_cnt=" + i + "' data-role='none' data-ok='yes' data-ctn='full'>요금규정</button>";
			html = html + "					</div>";
			html = html + "				</li>";
			
			for(var segIdx = 0; segIdx < fare_data.segmentGroup.length; segIdx++){
				var segGroup = fare_data.segmentGroup[segIdx];
				
				if(nullToBlank(segGroup.codeShareNm) != ""){
					if(shareNmVal == ""){
						shareNmVal = segGroup.codeShareNm;
					}else{
						shareNmVal += ", "+ segGroup.codeShareNm;
					}
				}
			}
			
			// console.log(">>>>>>>>>>>>>>>>>>> 1 - 1 ");
			//출발 도착 정보
			var flt_data_arr = fare_data.fltData;
			html = html + "				<li>";
			
			if(shareNmVal != ""){
				html = html + "<span class='comair_01'>공동운항정보 : "+ shareNmVal +"</span>";
			}
			
			if(flt_data_arr != null) {
				for(var flt_idx=0;flt_idx<flt_data_arr.length;flt_idx++) {
					var arr_data = flt_data_arr[flt_idx];
					
					// console.log(">>>>>>>>>>>>>>>>>>> 1 - 2 ");
					// console.log(">>>>>>>>>>>>>>>>>>> arr_data.depCd : " + arr_data.depCd);
					// console.log(">>>>>>>>>>>>>>>>>>> arr_data.depTm : " + arr_data.depTm);
					// console.log(">>>>>>>>>>>>>>>>>>> arr_data.arrCd : " + arr_data.arrCd);
					// console.log(">>>>>>>>>>>>>>>>>>> arr_data.arrTm : " + arr_data.arrTm);
					// console.log(">>>>>>>>>>>>>>>>>>> arr_data.interval : " + arr_data.interval);
					// console.log(">>>>>>>>>>>>>>>>>>> arr_data.stopYn : " + arr_data.stopYn);
					
					
					html = html + "					<ul>";
					html = html + "						<li>"+arr_data.depCd+"</li>";
					html = html + "						<li>"+arr_data.depTm.substring(0, 2) + ':' + arr_data.depTm.substring(2, 4)+"</li>";
					html = html + "						<li></li>";
					html = html + "						<li>"+ arr_data.arrCd+"</li>";
					html = html + "						<li>"+ arr_data.arrTm.substring(0, 2) + ':' + arr_data.arrTm.substring(2, 4)+"</li>";
					html = html + "						<li></li>";
					html = html + "						<li>"+ arr_data.interval + ' ' + arr_data.stopYn + "</li>";
					html = html + "					</ul>";

				
				}
			}
			html = html + "				</li>";

			// console.log(">>>>>>>>>>>>>>>>>>> 1 - 3 ");
			var airTotalAmt = (fare_data.totSaleCharge-0) + ((fare_data.totTasfCharge-0) * paxCnt);
			var promType = "";
			var fareProm;
			/** 
			console.log("fare_data.totSaleCharge : " + fare_data.totSaleCharge);
			console.log("fare_data.totTasfCharge : " + fare_data.totTasfCharge);
			console.log("fare_data.totDiscntCharge : " + fare_data.totDiscntCharge);
			console.log("fare_data.totUpCharge : " + fare_data.totUpCharge);
			**/

			if(nullToBlank(fare_data.totDiscntCharge) != "" && fare_data.totDiscntCharge != 0){
				airTotalAmt = airTotalAmt - fare_data.totDiscntCharge;
			}else if(nullToBlank(fare_data.totUpCharge) != "" && fare_data.totUpCharge != 0){
				airTotalAmt = airTotalAmt + fare_data.totUpCharge;
			}
			
			// console.log(fare_data.promData);
			
			if(nullToBlank(fare_data.promData) != ""){
				fareProm = fare_data.promData;
				
				if(fareProm.tyGb == "D"){
					promType = "DW";
					
					if(fareProm.diviGb == "R"){
						var promRate = (100 - parseFloat(fareProm.amt)) / 100
						airTotalAmt = airTotalAmt * promRate;
					}else{
						airTotalAmt = airTotalAmt - parseFloat(fareProm.amt)
					}
				}else{
					promType = "UP";
					if(fareProm.diviGb == "R"){
						var promRate = parseFloat(fareProm.amt) / 100
						airTotalAmt = airTotalAmt + (airTotalAmt * promRate);
					}else{
						airTotalAmt = airTotalAmt + parseFloat(fareProm.amt)
					}
				}				
			}
			
			
			html = html + "				<li>성인기본";
			html = html + "					<p>";
			html = html + "						<em>"+setPriceInput(airTotalAmt)+"</em>원";
			html = html + "					</p>";
			html = html + "				</li>";
			if(promType == "DW"){
				html = html + "				<li style='font-size:.8em;padding:5px 0 5px 10px;'>"+ fareProm.promNm;
				html = html + "					<p style='position:absolute;right:10px;top:2px;'>";
				if(fareProm.diviGb == "R"){
					html = html + "						<em style='color:#ff0000;font-weight:bold;font-size:1.2em;margin-bottom:-2px;display:inline-block;'>"+ fareProm.amt +"</em>% 할인";
				}else{
					html = html + "						<em style='color:#ff0000;font-weight:bold;font-size:1.2em;margin-bottom:-2px;display:inline-block;'>"+ setPriceInput(parseInt(fareProm.amt)) +"</em>원 할인";
				}
				html = html + "					</p>";
				html = html + "				</li>";
			}
			html = html + "			</ul>";		
			
			// fare_div.attr('ar-cnt', i);
			// fare_div.attr('ft-att', 'fare_list');
			// $('[ft-att="fare_div"]').append(fare_div);

			// console.log(html);

			$('#air_result_list_div').append(html);
		}

		$('#air_result_list_div').show();
		$('#air_result_nodata_div').hide();
		
		console.log(">>>>>>>>>>>>>>>>>>> 2 ");
	}

	// console.log("air_fix_data.length : " + air_fix_data.length);

	// $('#totCnt').html(air_fix_data.length);	//전체 카운팅
	
	// 더보기 버튼 처리 

	// if(e_cnt < air_fix_data.length) {
	//	$("#air_paging_div").show();		
	//} else {
	//	$("#air_paging_div").hide();	
	// }
	
	//임시 - 미완료
	//var tmpData = JSON.parse(window.localStorage['airViewData']).bodyDto.availGroup[0];
	var tmpData = JSON.parse(sessionStorage.airViewData).bodyDto.availGroup[0];
	$('[ft-att="dep_notice"]').text(tmpData.arrNm + ' 행');//목적지
	
	var v_dep_dt = gfn_setDateFormat(tmpData.depDt, '.');
	
	$('[ft-att="dep_dt_notice"]').text(v_dep_dt + '(' + fn_getDay(v_dep_dt) + ')');//출발일
	
	//$('[ft-att="moreBtn"]').attr('ar-data', _e_cnt); //리스트 노출 카운팅 (더보기)
	
	gfn_loading_bar_draw('hide');
}

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
	var s_cnt = $('[ft-att="moreBtn"]').attr('ar-data');
	var e_cnt = s_cnt - 0 + 20;	//20개씩 추가
	
	if(e_cnt > air_fix_data.length){
		e_cnt = air_fix_data.length;
	}
	
	viewAirList(s_cnt, e_cnt);
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

// 장바구니 화면에서 항공 스케쥴 삭제 
function fn_reSelect() {
	if(confirm('선택을 취소한 뒤 리스트 페이지로 돌아가겠습니까?')) {
		sessionStorage.airSelData = JSON.stringify([]);
		closePopup();
		$(".radioboxs").removeClass('on');
	}	
}

// 장바구니 화면에서 예약하기 화면으로 이동 
function fn_goReserve() {
	if(confirm('선택하신 스케쥴로 예약하시겠습니까?')) {
		var selAir =  $("#selAir").val();
		var selHotel = $("#selHotel").val();
		var selRentcar = $("#selRentcar").val();
		
		document.location.href='/free_reserve/reserve_info_step1.do?selAir='+selAir+"&selHotel="+selHotel + "&selRentcar="+selRentcar;
	}	
}

function fn_goNext() {
	
	var f_frm = $('#f_frm'); 
	
	var selHotelYn = f_frm.children('input[name="selHotel"]').val() == 'Y';
	var selRentcarYn = f_frm.children('input[name="selRentcar"]').val() == 'Y';
	
	if(selHotelYn) {
		f_frm.attr('action', '/free/search_result_air.do');
	} else if (selRentcarYn) {
		f_frm.attr('action', '/free/search_result_rentcar.do');
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