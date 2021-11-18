//call ajax - 공통 로딩이미지 추가
function gfn_callAjaxs (_url, _data, _fn_scs, noload, _fn_cpl) {

	var success = false;
	// console.log(">>>>>>>>>>>>>>>> noload : " + noload);
	if(!noload){	//
		gfn_loading_bar_draws('show');
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
        	gfn_loading_bar_draws('hide');
        	if(_fn_scs != null && _fn_scs != undefined){
        		if(typeof(_fn_scs) == 'function'){
        			_fn_scs();
        		} else if(_fn_scs == 'return'){
        			return data;
        		} else {
        			try {
            			eval(_fn_scs)(data);
    				} catch (e) {}
        		}
        	}
        },
        error : function(request,status){
        	gfn_loading_bar_draws('hide');
        	console.log('request : ' + request);
			console.log('success : ' + success);
        	console.log('status : ' + status);
        },
        complete : function(){
        	if(success && _fn_cpl != null && _fn_cpl != undefined){
        		_fn_cpl();
        	}
        	//gfn_loading_bar_draw('hide');
        }
    });
}

// /common/js/common_yym.js 를 옮겨옴. 
var carSize = {
	'1' : '경차(mini)',
	'2' : '소형차(subcompact)',
	'3' : '소형차(economy)',
	'4' : '준중형차(compact)',
	'5' : '중형차(midsize)',
	'6' : '중형차(intermediate)',
	'7' : '중형차(standard)',
	'8' : '준대형차(fullsize)',
	'9' : '고급차(luxury)',
	'10' : '대형차(premium)',
	'23' : '특수차(special)',
	'32' : '특수차(special)',
	'33' : '경차(minielite)',
	'34' : '소형차(economy elite)',
	'35' : '준중형차(compact elite)',
	'36' : '중형차(intermediate elite)',
	'37' : '중형차(standard elite)',
	'38' : '준대형차(fullsize elite)',
	'39' : '대형차(premium elite)',
	'40' : '고급차(luxury elite)',
	'41' : 'oversize'
}

var fuelType = {
	'Unspecified' 			: '미정',
	'Diesel' 				: '디젤',
	'Hybrid' 				: '하이브리드',
	'Electric' 				: '전기',
	'LPG Compressed Gas'	: 'LPG',
	'Hydrogen' 				: '수소',
	'MultiFuel' 			: '다종연료',
	'Petrol' 				: '휘발유',
	'Ethanol' 				: '에탄올'
}

var corverageType = {
	'7'		: 'CDW (차량손실 면책프로그램=자차보험)',
	'24'	: 'LDW (차량손실 면책프로그램=자차보험)',
	'27'	: 'LIS (대인/대물 책임보험)',
	'32'	: 'PAI (임차인 상해 보험)',
	'36'	: 'PEC (휴대품 분실 보험)',
	//'38'	: 'Personal property insurance',
	'38'	: 'PPI (개인손해 보험)',
	'40'	: 'SCDW (차량손실 책임경감 프로그램=자차보험)',
	'48'	: 'TP (차량 도난보험)',
	'56'	: 'Max Cover (완전면책 프로그램)',
	'57'	: 'AER PLUS (본인 책임액 경감프로그램 PLUS)',
	'58'	: 'AER (본인 책임액 경감프로그램)',
	'59'	: 'SC (차량손실 책임경감 프로그램=자차보험)',
}

var common_form_data = {};

//날짜형식 변경
function gfn_setDateFormat(_data, _dmt) {
	try {
		if(_data.length == 8){
			return _data.substring(0,4) + _dmt + _data.substring(4,6) + _dmt + _data.substring(6,8);
		} else if (_data.length == 6) {
			return _data.substring(0,2) + _dmt + _data.substring(2,4) + _dmt + _data.substring(4,6);
		} else {
			return 0;
		}
	} catch (e) {
		return 0;
	}
} 

//call ajax - 공통
function gfn_callAjax (_url, _data, _fn_scs, noload, _fn_cpl) {

	var success = false;
	// console.log(">>>>>>>>>>>>>>>> noload : " + noload);
	if(!noload){	//
		gfn_loading_bar_draw('show');
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
        	gfn_loading_bar_draw('hide');
        	if(_fn_scs != null && _fn_scs != undefined){
        		if(typeof(_fn_scs) == 'function'){
        			_fn_scs();
        		} else if(_fn_scs == 'return'){
        			return data;
        		} else {
        			try {
            			eval(_fn_scs)(data);
    				} catch (e) {}
        		}
        	}
        },
        error : function(request,status){
        	gfn_loading_bar_draw('hide');
        	console.log('request : ' + request);
			console.log('success : ' + success);
        	console.log('status : ' + status);
        },
        complete : function(){
        	if(success && _fn_cpl != null && _fn_cpl != undefined){
        		_fn_cpl();
        	}
        	//gfn_loading_bar_draw('hide');
        }
    });
}

//call ajax - 공통
function gfn_callAjax3 (_url, _data, _fn_scs, noload, _fn_cpl) {

	var success = false;
	// console.log(">>>>>>>>>>>>>>>> noload : " + noload);
	if(!noload){	//
		gfn_loading_bar_draw3('show');
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
            			eval(_fn_scs)(data);
    				} catch (e) {}
        		}
        	}
        },
        error : function(request,status){
        	console.log('request : ' + request);
			console.log('success : ' + success);
        	console.log('status : ' + status);
        },
        complete : function(){
        	if(success && _fn_cpl != null && _fn_cpl != undefined){
        		_fn_cpl();
        	}
        	gfn_loading_bar_draw3('hide');
        }
    });
}

//천단위 콤마 넣기 - 공통
function setPriceInput(str) {
	str = str + '';
	str = str.replace(/,/g,'');
	
	strArr = str.split(".");
	
	var retValue = "";
   	for(var i=1; i<=strArr[0].length; i++) {
		if(i > 1 && (i%3)==1) {
			retValue = strArr[0].charAt(strArr[0].length - i) + "," + retValue;
		} else {
			retValue = strArr[0].charAt(strArr[0].length - i) + retValue;
		}	    
	}
   	
   	if(strArr.length == 2){
   		retValue = retValue + "." + strArr[1];
   	}
   	
   	return retValue;
}

//시간 차이 계산 - 공통
function calcInterval(pDt, pTm, nDt, nTm) {
	
    var day1= new Date(pDt.substring(0, 4), pDt.substring(4, 6), pDt.substring(6, 8) ,pTm.substring(0, 2) ,pTm.substring(2, 4));
	var day2= new Date(nDt.substring(0, 4), nDt.substring(4, 6), nDt.substring(6, 8) ,nTm.substring(0, 2) ,nTm.substring(2, 4));
    
    var ms1 = Date.parse(day1);	// 첫번째 날짜를 1/1000 값으로 환산
    var ms2 = Date.parse(day2);	// 두번째 날짜를 1/1000 값으로 환산
    var sep = (ms2-ms1)/1000; // 두 날짜간의 시간차 (1/1000 초 이므로 초로 환산)

    var min = 60;
    var hour= min * 60;
    var day = hour * 24;

    var sd  = parseInt(sep/day);
    var sh  = parseInt((sep%day)/hour);
    var sm  = parseInt((sep%hour)/min);
    var ss  = sep%min;

	// console.log("calcInterval() 시간 차이 함수 > " +sd+'일 '+sh+'시간 '+sm+'분 '+ss+'초 차이가 있습니다.');

    return sd+','+sh+','+sm+','+ss;
}


//시간 차이 계산 - 공통
var calcInterval2 = function(pDt, pTm, nDt, nTm) {
	
	/** 날짜형식 가공 - yyyymmdd, hh24mi */
	pDt = pDt+'';
	nDt = nDt+'';
	if(pDt.length != 8){
		if(pDt.length == 10){
			pDt = pDt.substring(0, 4) + pDt.substring(5, 7) + pDt.substring(8, 10);
		} else if (pDt.length == 6){
			
			pDt = '20' + pDt;	//날짜 비교를 하는것이기 때문에 크게 신경안씀..
		} else if (pDt.length != 0){
			//alert('날짜 형식을 yyyymmdd 로 입력해주세요.');
			return '0';
		}
	}
	if(nDt.length != 8){
		if(nDt.length == 10){
			nDt = nDt.substring(0, 4) + nDt.substring(5, 7) + nDt.substring(8, 10);
		} else if (nDt.length == 6){
			
			nDt = '20' + nDt;	//날짜 비교를 하는것이기 때문에 크게 신경안씀..
		} else if (nDt.lenght != 0){
			//alert('날짜 형식을 yyyymmdd 로 입력해주세요.');
			return '0';
		}
	}
	/** 시간형식 가공 */
	pTm = pTm+'';
	nTm = nTm+'';
	if(pTm.length != 4){
		if(pTm.length == 5){
			pTm = pTm.substring(0, 2) + pTm.substring(3, 5);
		} else if (pTm.length > 5){
			pTm = pTm.substring(0, 2) + pTm.substring(3, 5);
		} else {
			//alert('시간 형식을 0000 으로 입력해주세요.');
			return '0';
		}
	}
	if(nTm.length != 4){
		if(nTm.length == 5){
			nTm = nTm.substring(0, 2) + nTm.substring(3, 5);
		} else if (nTm.length > 5){
			nTm = nTm.substring(0, 2) + nTm.substring(3, 5);
		} else {
			//alert('시간 형식을 0000 으로 입력해주세요.');
			return '0';
		}
	}
	
    var day1= new Date(pDt.substring(0, 4), pDt.substring(4, 6)-0-1, pDt.substring(6, 8) ,pTm.substring(0, 2) ,pTm.substring(2, 4));
	var day2= new Date(nDt.substring(0, 4), nDt.substring(4, 6)-0-1, nDt.substring(6, 8) ,nTm.substring(0, 2) ,nTm.substring(2, 4));
    
    var ms1 = Date.parse(day1);	// 첫번째 날짜를 1/1000 값으로 환산
    var ms2 = Date.parse(day2);	// 두번째 날짜를 1/1000 값으로 환산
    var sep = (ms2-ms1)/1000; // 두 날짜간의 시간차 (1/1000 초 이므로 초로 환산)

    var min = 60;
    var hour= min * 60;
    var day = hour * 24;

    var sd  = parseInt(sep/day);
    var sh  = parseInt((sep%day)/hour);
    var sm  = parseInt((sep%hour)/min);
    var ss  = sep%min;

    //document.getElementById('sep').innerHTML = sd+'일 '+sh+'시간 '+sm+'분 '+ss+'초 차이가 있습니다.';
    return sd+','+sh+','+sm+','+ss;
};

// 로딩바 호출/제거
function gfn_loading_bar_draw(_flag) {
	if($('#test_loading_bar').length < 1){
		$('body').append('<div id="test_loading_bar"></div>');

	}
	
	if($('#test_loading_bar_img').length < 1){
		$('#test_loading_bar').append('<img id="test_loading_bar_img11" src="/resources/images/img/loading.gif" style="width:296px;"></img>');
	}
	
	$('#test_loading_bar').css({
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

	var set_bottom = ($('#test_loading_bar').innerHeight() - 168)/2;
	var set_right = ($('#test_loading_bar').innerWidth() - 296)/2;
	$('#test_loading_bar > img').css({
		'position' : 'fixed',
		'right' : set_right,
		'bottom' : set_bottom
	});
	
	//	gfn_setPosition($('#test_loading_bar'), 0);
	testLoading(_flag);
}

//로딩바 호출/제거
function gfn_loading_bar_draws(_flag) {
	if($('#test_loading_bar').length < 1){
		$('body').append('<div id="test_loading_bar"></div>');

	}
	
	if($('#test_loading_bar_img').length < 1){
		$('#test_loading_bar').append('<img id="test_loading_bar_img" src="/resources/images/img/loading_payment.gif" style="width:296px;"></img>');
	}
	
	$('#test_loading_bar').css({
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

	var set_bottom = ($('#test_loading_bar').innerHeight() - 168)/2;
	var set_right = ($('#test_loading_bar').innerWidth() - 296)/2;
	$('#test_loading_bar > img').css({
		'position' : 'fixed',
		'right' : set_right,
		'bottom' : set_bottom
	});
	
	//	gfn_setPosition($('#test_loading_bar'), 0);
	testLoading(_flag);
}


function testLoading(_flag) {
	if(_flag == ''){
		_flag = $('#test_loading_bar').attr('ar-data');
	}
 
	if(_flag == 'show') {
		$('#test_loading_bar').show();
		$('#test_loading_bar').attr('ar-data', 'hide');
	//	$('html').css('overflow', 'hidden');
	} else {
		$('#test_loading_bar').hide();
		$('#test_loading_bar').attr('ar-data', 'show');
	//	$('html').css('overflow', 'auto');
	}
}

// 로딩바 호출/제거
function gfn_loading_bar_draw3(_flag) {
	if($('#test_loading_bar3').length < 1){
		$('body').append('<div id="test_loading_bar3"></div>');

	}
	
	if($('#test_loading_bar_img3').length < 1){
		$('#test_loading_bar3').append('<img id="test_loading_bar_img3" src="/resources/images/img/loading.gif" style="width:296px;"></img>');
	}
	
	$('#test_loading_bar3').css({
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

	var set_bottom = ($('#test_loading_bar3').innerHeight() - 168)/2;
	var set_right = ($('#test_loading_bar3').innerWidth() - 296)/2;
	$('#test_loading_bar3 > img').css({
		'position' : 'fixed',
		'right' : set_right,
		'bottom' : set_bottom
	});
	
	//	gfn_setPosition($('#test_loading_bar'), 0);
	testLoading3(_flag);
}

function testLoading3(_flag) {
	if(_flag == ''){
		_flag = $('#test_loading_bar3').attr('ar-data');
	}
 
	if(_flag == 'show') {
		$('#test_loading_bar3').show();
		$('#test_loading_bar3').attr('ar-data', 'hide');
	//	$('html').css('overflow', 'hidden');
	} else {
		$('#test_loading_bar3').hide();
		$('#test_loading_bar3').attr('ar-data', 'show');
	//	$('html').css('overflow', 'auto');
	}
}

function load_on (_func, _data) {
	try {
		gfn_loading_bar_draw('show');
		eval(_func)(_data);
	} catch (e) {
		console.log('함수 호출 오류');
		gfn_loading_bar_draw('hide');
	}
}

//위치조정 함수
function gfn_setPosition(_obj, _mar) {
	/** 위치 잡아주기 top left */
	var scrollTop = window.scrollY;	// 현재 스크롤 위치
	var scrollLeft = window.scrollX;	// 현재 스크롤 위치
	
	var popHeight = _obj.outerHeight(); //팝업창 높이
	var popWidth = _obj.outerWidth();	//팝업창 너비
	
	var screenHeight = window.innerHeight; // 창 높이
	var screenWidth = window.innerWidth; // 창 너비
	
	//창크기보다 팝업창의 크기가 클경우 팝업 크기 조절
	if(screenHeight < popHeight + _mar) {
		_obj.find('.pop_cont').height(screenHeight-(_mar*2));
		_obj.height(screenHeight-_mar);
		popHeight = screenHeight-_mar;
		popWidth = popWidth + 20;
		_obj.width(popWidth);
	}
	
	/*if(screenWidth < popWidth) {
		_obj.width(screenWidth);
		popWidth = screenWidth;
	}*/
	
	_obj.css({
		top: scrollTop + (screenHeight-popHeight)/2,
		left: scrollLeft + (screenWidth-popWidth)/2
	});
}

//달력 선택 이벤트
function gfn_dateChnEvent(){
	var nowDivId = $(this).parents('div[ft-att="srchKind"]').attr('id');
	if(nowDivId == 'air_search_div'){
		fn_setAirDate(this);
	} else if (nowDivId == 'hotel_search_div'){
		fn_setHotelDate(this);
	} else if (nowDivId == 'rentca_search_div'){
		
	}
}

//날짜형식 변경
function gfn_setDateFormat(_data, _dmt) {
	try {
		if(_data.length == 8){
			return _data.substring(0,4) + _dmt + _data.substring(4,6) + _dmt + _data.substring(6,8);
		} else if (_data.length == 6) {
			return _data.substring(0,2) + _dmt + _data.substring(2,4) + _dmt + _data.substring(4,6);
		} else {
			return 0;
		}
	} catch (e) {
		return 0;
	}
} 

// 요일 가져오기
function gfn_getDay(_day, _format) {
	var week = [];	
	if(_format == undefined || _format == null){
		week = ['일', '월', '화', '수', '목', '금', '토'];
	} else {
		week = _format;
	}
	
	var dayArry = _day.split(".");
	
	try {
		var dayOfWeek = week[new Date(dayArry[0], parseInt(dayArry[1]) - 1, dayArry[2]).getDay()];
		return dayOfWeek;
	} catch (e) {
		return '';
	}
}

function free_prevStep(){
	history.back();
}

function free_nextStep(){
	var thisStepUrl = location.pathname;
	var thisStepParam = "";
	try{
		thisStepParam = '?selAir='+ $("#selAir").val() +'&selHotel='+ $("#selHotel").val() +'&selRentcar='+ $("#selRentcar").val();
	}catch(e){}
	
	if(thisStepUrl == "/free/search_result_air.do"){
		if($(".air_radio_btn:checked").length == 0){
			setAlert("상품을 선택해 주세요.");
			
			return false;
		}else{
			if($("#selHotel").val() == 'Y'){
				movePage('/free/search_result_hotel.do'+ thisStepParam);
			}else if($("#selRentcar").val() == 'Y'){
				movePage('/free/search_result_rentcar_office.do'+ thisStepParam);
			}else{
				free_selectComplete();
			}
		}
	}else if(thisStepUrl == "/free/hotel_detail_hotel.do"){
		if($(".hotel_radio_btn:checked").length == 0){
			setAlert("상품을 선택해 주세요.");
			
			return false;
		}else{
			if($("#selRentcar").val() == 'Y'){
				movePage('/free/search_result_rentcar_office.do'+ thisStepParam);
			}else{
				free_selectComplete();
			}
		}
	}else if(thisStepUrl == "/free/search_result_rentcar.do"){
		if($(".carRadio:checked").length == 0){
			setAlert("상품을 선택해 주세요.");
			
			return false;
		}else{
			var selCarList = [];
			var dataIndex = $(".carRadio:checked").data("num");
			
			if(nullToBlank(sessionStorage.rentcarSelData) != ""){
				var rentcalSelList = JSON.parse(sessionStorage.rentcarSelData); 
				for(var i = 0; i < rentcalSelList.length; i++){
					selCarList.push(rentcalSelList[i]);
				}
			}
			
			rentalCarList[dataIndex].exchangeVal = exchangeVal;
			rentalCarList[dataIndex].searchTakeDate = searchData.rentTakeDate;
			rentalCarList[dataIndex].searchTakeTime = searchData.rentTakeTime;
			rentalCarList[dataIndex].searchReturnDate = searchData.rentReturnDate;
			rentalCarList[dataIndex].searchReturnTime = searchData.rentReturnTime;
			rentalCarList[dataIndex].searchTakePlace = searchData.rentTakePlaceNm;
			rentalCarList[dataIndex].searchReturnPlace = searchData.rentReturnPlaceNm;
			
			selCarList.push(rentalCarList[dataIndex]);
			sessionStorage.rentcarSelData = JSON.stringify(selCarList);
			
			free_selectComplete();
		}
	}
}

function free_selectComplete(){
	var selectGoodsYn = false;
	
	if(nullToBlank(sessionStorage.airSelData) != "" && sessionStorage.airSelData != '[]'){
		selectGoodsYn = true;
	}
	
	if(nullToBlank(sessionStorage.hotelSelData) != "" && sessionStorage.hotelSelData != '[]'){
		selectGoodsYn = true;
	}
	
	if(nullToBlank(sessionStorage.rentcarSelData) != "" && sessionStorage.rentcarSelData != '[]'){
		selectGoodsYn = true;
	}
	
	var thisStepParam = "";
	try{
		thisStepParam = '?selAir='+ $("#selHotel").val() +'&selHotel='+ $("#selRentcar").val() +'&selRentcar='+ $("#selRentcar").val();
	}catch(e){}
	
	if(selectGoodsYn){
		setConfirm("선택하신 스케쥴로 예약 하시겠습니까?", function(){
			movePage('/free_reserve/reserve_info_step1.do'+ thisStepParam);
		}, function(){
		}, "선택완료", "확인", "취소")	
	}else{
		setAlert("상품을 선택해 주세요.", "선택확인");
	}
}


//요일 가져오기
function gfn_getDay(_day, _format) {
	var week = [];
	if(_format == undefined || _format == null){
		week = ['일', '월', '화', '수', '목', '금', '토'];
	} else {
		week = _format;
	}
	
	try {
		var dayOfWeek = week[new Date(gfn_setDateFormat(_day, '-')).getDay()];
		return dayOfWeek;
	} catch (e) {
		return '';
	}
}

//요일 가져오기
function gfn_getDay_jum(_day, _format) {
	var week = [];
	if(_format == undefined || _format == null){
		week = ['일', '월', '화', '수', '목', '금', '토'];
	} else {
		week = _format;
	}
	
	var _dayArr = _day.split(".");
	
	try {
		var dayOfWeek = week[new Date(_dayArr[0], parseInt(_dayArr[1]) - 1, _dayArr[2]).getDay()];
		return dayOfWeek;
	} catch (e) {
		return '';
	}
}

//날짜 더하기
function gfn_addDay(ymd, v_day){
	var yyyy = ymd.substr(0,4);
	var mm = eval(ymd.substr(5,2) + "- 1") ;
	var dd = ymd.substr(8,2);
	var dt3 = new Date(yyyy, mm, eval(dd + '+' + v_day));
	
	yyyy = dt3.getFullYear();
	mm = (dt3.getMonth()+1)<10? "0" + (dt3.getMonth()+1) : (dt3.getMonth()+1) ;
	dd = dt3.getDate()<10 ? "0" + dt3.getDate() : dt3.getDate();
	
	return  "" + yyyy + "-" + mm + "-" + dd ;
}

//날짜형식 변경
function gfn_setDateFormat(_data, _dmt) {
	try {
		if(_data.length == 8){
			return _data.substring(0,4) + _dmt + _data.substring(4,6) + _dmt + _data.substring(6,8);
		} else if (_data.length == 6) {
			return _data.substring(0,2) + _dmt + _data.substring(2,4) + _dmt + _data.substring(4,6);
		} else if (_data.length == 10) {
			return _data.substring(0,4) + _dmt + _data.substring(5,7) + _dmt + _data.substring(8,10);
		} else {
			return 0;
		}
	} catch (e) {
		return 0;
	}
} 

