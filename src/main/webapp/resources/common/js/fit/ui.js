var uijs = uijs || new Object();

uijs = {
	init : function(_target){	// 기본 팝업 구성 초기화
		//팝업에 부여할 랜덤 ID 생성
		var tmp_id = 'pop_';
		
		//랜덤함수 생성
		var random_ele = 'abcdefghijklmnopqrstuvwxyz0123456789';
		for(var tmpi=0; tmpi<10; tmpi++){
			tmp_id = tmp_id + random_ele.charAt(Math.floor(Math.random()*36));
		}
		
		
		$('<div class="pop_black_wall" att-id="' + tmp_id + '"></div>')
					.on('click', uijs.hide)
					.appendTo('body');
		
		var base_pop_body = $('<div class="pop_body"></div>')
					.append('<div class="pop_head"></div>')
					.append('<div class="pop_cont"></div>');
		
		$('<div class="popup" pop-id="' + tmp_id + '"></div>')
					.append(base_pop_body)
					.appendTo('body');
		
		return tmp_id;
	},
	
	setPosition : function(_obj){	//팝업 위치 지정
		/** 위치 잡아주기 top left */	
		var scrollTop = window.scrollY;	// 현재 스크롤 위치
		var scrollLeft = window.scrollX;	// 현재 스크롤 위치
		
		var popHeight = _obj.outerHeight(); //팝업창 높이
		var popWidth = _obj.outerWidth();	//팝업창 너비
		
		var screenHeight = window.innerHeight; // 창 높이
		var screenWidth = window.innerWidth; // 창 너비
		
		// 익스플로러의 경우 window.scrollY 명령어를 못씀
		if(document.all){
			scrollTop = document.documentElement.scrollTop;	// 현재 스크롤 위치
			scrollLeft = document.documentElement.scrollLeft;
		}
		
		// 테스트 - 임시
		scrollTop = 0;	// 현재 스크롤 위치
		scrollLeft = 0;	// 현재 스크롤 위치
		
		//창크기보다 팝업창의 크기가 클경우 팝업 크기 조절
		if(screenHeight < popHeight + 50) {
			_obj.find('.pop_cont').height(screenHeight-100);
			_obj.height(screenHeight-50);
			popHeight = screenHeight-50;
			popWidth = popWidth + 17;
			_obj.width(popWidth);
		}
		if(screenWidth < popWidth) {
			_obj.width(screenWidth);
			popWidth = screenWidth;
		}
		
		_obj.css({
			top: scrollTop + (screenHeight-popHeight)/2,
			left: scrollLeft + (screenWidth-popWidth)/2,
			position : 'fixed'
		}); 
		
		var tmp_id = _obj.attr('pop-id');
		
		$('.pop_black_wall[att-id="' + tmp_id + '"]').css({
			top: scrollTop,
			left: scrollLeft,
			position : 'fixed'
		});
	},

	show : function(_popid, _noDelay) {	//팝업 열기
		
		$('html').css({
			'overflow' : 'hidden',
			'padding-right' : '17px'
		});
		
		if(_noDelay){
			$('div[pop-id="' + _popid + '"]').show();
		} else {
			var opcNum = 0.1;
			
			var viewPop = $('div[pop-id="' + _popid + '"]');
			viewPop.css('opacity', opcNum)
				.show();
			
			var showPopup = 0;
			
			showPopup = setInterval(function() {
				opcNum += 0.1;
				if(opcNum > 1){
					clearInterval(showPopup);
				} else {
					viewPop.css('opacity', opcNum);
				}
			}, 5);
		}
	},

	hide : function(_popid) {	// 팝업 닫기 (삭제)
		if(typeof(_popid) != 'string'){
			_popid = $(this).attr('att-id');
		}
		
		var opcNum = 1;
		
		var viewPop = $('div[pop-id="' + _popid + '"]');
		viewPop.css('opacity', opcNum)
			.show();
		
		var hidePopup = 0;
		
		hidePopup = setInterval(function() {
			opcNum -= 0.1;
			if(opcNum < 0.1){
				viewPop.remove();
				$('.pop_black_wall[att-id="' + _popid + '"]').remove();
				clearInterval(hidePopup);
			}
			viewPop.css('opacity', opcNum);
		}, 5);
		
		$('html').css({
			'overflow' : 'auto',
			'padding-right' : '0px'
		});
	}
};

//규정보기 팝업
function fn_showCertiPop (_data) {
	//규정보기 popup 존재 시 삭제
	if($('div[ft-att="air_certi_pop"]').length < 1) {
		$('div[ft-att="air_certi_pop"]').remove();
	}

	//기본 popup골격 생성
	var tmp_id = uijs.init();
	
	var base_pop = $('div[pop-id="' + tmp_id + '"]');
	
	//pop속성 추가
	base_pop.addClass('rate_price')
			.attr('ft-att', 'air_certi_pop');
	
	var certi_pop = $('div[ft-att="air_certi_pop"]'); 
	
	//제목
	var close_btn = $('<a href="javascript:void(0);" att-id="' + tmp_id + '" class="btn floatR">닫기</a>')
			.on('click', uijs.hide);
	certi_pop.find('.pop_head').html('요금규정')
								.append(close_btn);
	

	var pax_info = JSON.parse(sessionStorage.airSearchVal).bodyDto;
	
	//내용
	var cont_html = '<div class="priceWrap">                          	'
				+	'	<div class="title">                          	'
				+	'		<dl>                                     	'
				+	'			<dt>성인</dt>                         	'
				+	'			<dd><b ar_att="certi_adt">' + pax_info.adtCnt + '</b>명</dd>	'
				+	'		</dl>                                    	'
				+	'		<dl>                                     	'
				+	'			<dt>아동</dt>                         	'
				+	'			<dd><b ar_att="certi_chd">' + pax_info.chdCnt + '</b>명</dd>	'
				+	'		</dl>                                     	'
				+	'		<dl>                                      	'
				+	'			<dt>유아</dt>                          	'
				+	'			<dd><b ar_att="certi_inf">' + pax_info.infCnt + '</b>명</dd>	'
				+	'		</dl>                                     	'
				+	'	</div>                                        	'
				+	'	<div class="notibox">							'
				+	'	</div>                                          '
				+	'	<div class="noti">												'
				+	'		<h3>요금규정</h3>                                                     '
				+	'		<span class="select floatR">                                '
				+	'			<label for="certiSelect" class="none">요금규정종류선택</label>     '
				+	'			<select id="certiSelect" style="width:100px; display:none;">              '
				+	'			</select>             					'
				+	'		</span>										'
				+	'	</div>                                       	'
				+	'	<div class="txtbox" ft-att="certi_table_list">	'
				+	'	</div>                                        	'
				+	'</div>';
	certi_pop.find('.pop_cont').html(cont_html);
	
	var certi_div = certi_pop.find('div[ft-att="certi_table_list"]');
	var certi_data = _data.fareCerti.data;
	
	// 규정이 2개 이상 존재하면 안내문구 노출
	if(certi_data.length > 1){
		var caption = certi_pop.find('.notibox');
		caption.append('<p>전체 여정에 <span class="point">상이한 운임과 규정</span>이 적용되었습니다. 각 운임 규정 중 가장 제한적인 규정이 적용됩니다. 상세 운임규정은 여행사 <span class="point">예약 담당자를 통해서 재확인</span>하시기 바랍니다.</p>')
			.append('<p>예)다음 규정의 경우 더 제한적인 규정인 “10만원 징수 후 환불’이 적용됩니다.  첫번째 환불 규정: 5만원 징수 후 가능 두번째 환불 규정 : 10만원 징수 후 가능</p>')
			.show();
	}
	
	var certiSel = certi_pop.find('.noti').find('select#certiSelect');
	
	if(certi_data.length > 1) {
		certiSel.show();
	}
	
	// 규정 수만큼  for
	for(var c_idx=0; c_idx<certi_data.length; c_idx++) {
		certiSel.append('<option value="'+ c_idx +'">요금규정' + (c_idx+1) + '</option>');
		
		var tmp_table = '<table class="certi_table" certi-data="' + c_idx + '">                           				'
					+	'	<caption>' + c_idx + '번째 요금 규정</caption>	'
					+	'	<colgroup>                     				'
					+	'		<col style="width:110px;"> 				'
					+	'		<col style="*">            				'
					+	'	</colgroup>                    				'
					+	'	<tbody ft-att="certi_list_div">				'
					+	'	</tbody>			           				'
					+	'</table>';                         
		
		certi_div.append(tmp_table);
		
		var certi_list_div = certi_div.find('tbody[ft-att="certi_list_div"]').eq(c_idx);
		var fare_rule_info = certi_data[c_idx].fareRuleInfoDataBean;
		
		for(var f_idx=0; f_idx<fare_rule_info.length; f_idx++) {
			var certi_html = $('<tr></tr>');
			certi_html.append('<th scope="row" class="certi">' + fare_rule_info[f_idx].itemNm + '</th>');
			certi_html.append('<td class="last"></td>');
			
			//규정 내용 입력	내용 속성 미적용 - 미완료
			var cont_val = '';
			if(fare_rule_info[f_idx].itemAttr == 'C'){
				cont_val = fare_rule_info[f_idx].itemTxt;
			} else if (fare_rule_info[f_idx].itemAttr == 'B') {
				cont_val = fare_rule_info[f_idx].itemTxt;
				console.log('볼드맨');
			}			
			certi_html.find('td.last').html(cont_val);		
			
			//리스트에 추가
			certi_list_div.append(certi_html);	
		}
	}
	
	$('table.certi_table').eq(0).show();	//첫번째 요금 규정 노출
	
	//셀렉트 변경
	certiSel.on('change',function(){
		var sel_certi = $(this).val();
		$('table.certi_table').hide();
		$('table.certi_table').eq(sel_certi).show();
	});
	
	//팝업 위치지정
	uijs.setPosition(certi_pop);
	
	//표시
	uijs.show(tmp_id);
}


//도시검색 팝업
function fn_showCityPop(_obj, _type) {
	//규정보기 popup 존재 시 삭제
	if($('div[ft-att="sel_city_pop"]').length < 1) {
		$('div[ft-att="sel_city_pop"]').remove();
	}

	//기본 popup골격 생성
	var tmp_id = uijs.init();	
	
	var base_pop = $('div[pop-id="' + tmp_id + '"]');
	
	//pop속성 추가
	base_pop.addClass('selectCity')
			.attr('ft-att', 'sel_city_pop');

	//대상이 되는 inputbox 지정
	var city_pop = $('div[ft-att="sel_city_pop"]')
			.attr('target-id', $(_obj).attr('id')); 
			
	//내용
	var cont_html = '<table class="" summary="주요도시선택팝업">                                                                       '
			+		'<caption>도시명검색을 위한 표</caption>                                                                            '
			+		'<colgroup>                                                                                                '
			+		'	<col width="12%" />                                                                                    '
			+		'	<col width="22%" />                                                                                    '
			+		'	<col width="22%" />                                                                                    '
			+		'	<col width="22%" />                                                                                    '
			+		'	<col width="22%" />                                                                                    '
			+		'</colgroup>                                                                                               '
			+		'<tbody ft-att="city_list_div">                                                                                                   '
			+		'</tbody>                                                                                                  '
			+		'</table>';
	
	//출발지, 도착지에 따라 다르게 표시
	var availGbn = $(_obj).attr('ar-att');	//출발,도착도시 구분
	var setTitle = '';
	var baseCityList = []; //도시리스트
	if(availGbn != 'departure'){	//해외
		//검색창 추가
		cont_html = '<div class="searchWrap">				                                                                   '
			+		'	<div class="search">					                                                               '
			+		'		<fieldset>                                                                                         '
			+		'			<legend>검색</legend>                                                                            '
			+		'			<label>도시명</label>                                                                             '
			+		'			<input type="text" id="cityPopInput" title="검색어를 입력하세요." class="input_m" placeholder="검색어를 입력해주세요." />           '
			+		'			<input type="image" class="btn_search" src="/common/images/new/btn_search.gif" alt="검색" />     '
			+		'		</fieldset>                                                                                        '
			+		'		<div class="search_box" ft-att="resultSearch">				                                                           '
			+		'		</div>							                                                                   '
			+		'	</div>                                                                                                 '
			+		'</div>                                                                                                    '
			+		cont_html;
		
		setTitle = '주요도시선택';
		
		if(_type == 'hotel') {
			baseCityList = [
		                	{ naNm: '일본', cityList: [{ ctCd: 'tokyo', naCd: 'JP', ctNm: '도쿄' }, { ctCd: 'OSA', naCd: 'JP', ctNm: '오사카' }, { ctCd: 'FUK', naCd: 'JP', ctNm: '후쿠오카' }, { ctCd: 'NGO', naCd: 'JP', ctNm: '나고야' }]}
		                	, { naNm: '중국/홍콩', cityList: [{ ctCd: 'HKG', naCd: 'HK', ctNm: '홍콩' }, { ctCd: 'SHA', naCd: 'CN', ctNm: '상하이' }, { ctCd: 'BJS', naCd: 'CN', ctNm: '베이징' }, { ctCd: 'MAU', naCd: 'CN', ctNm: '마카오' }]}
		                	, { naNm: '아시아', cityList: [{ ctCd: 'SIN', naCd: 'SG', ctNm: '싱가폴' }, { ctCd: 'BKK', naCd: 'TH', ctNm: '방콕' }, { ctCd: 'TPE', naCd: 'TW', ctNm: '타이페이' }, { ctCd: 'MNL', naCd: 'PH', ctNm: '마닐라' }, { ctCd: 'KUL', naCd: 'MY', ctNm: '쿠알라룸푸르' }]}
		                	, { naNm: '미주', cityList: [{ ctCd: 'NYC', naCd: 'US', ctNm: '뉴욕' }, { ctCd: 'LAX', naCd: 'US', ctNm: 'L.A' }, { ctCd: 'SFO', naCd: 'US', ctNm: '샌프란시스코' }, { ctCd: 'LAS', naCd: 'US', ctNm: '라스베이거스' }, { ctCd: 'CHA', naCd: 'US', ctNm: '시카고' }]}
		                	, { naNm: '유럽', cityList: [{ ctCd: 'PAR', naCd: 'FR', ctNm: '파리' }, { ctCd: 'LON', naCd: 'GB', ctNm: '런던' }, { ctCd: 'ROM', naCd: 'IT', ctNm: '로마' }, { ctCd: 'FRA', naCd: 'DE', ctNm: '프랑크푸르트' }]}
		                	, { naNm: '휴양지', cityList: [{ ctCd: 'HNL', naCd: 'US', ctNm: '하와이' }, { ctCd: 'HKT', naCd: 'TH', ctNm: '푸껫' }, { ctCd: 'DPS', naCd: 'ID', ctNm: '발리' }, { ctCd: 'CEB', naCd: 'PH', ctNm: '세부' }, { ctCd: 'GUM', naCd: 'GU', ctNm: '괌' }]
			}];
		} else {
			baseCityList = [
		                	{naNm : '일본', cityList : [{ctCd : 'NRT',ctNm : '도쿄(나리타)'},{ctCd : 'HND',ctNm : '도쿄(하네다)'},{ctCd : 'KIX',ctNm : '오사카'},{ctCd : 'FUK',ctNm : '후쿠오카'},{ctCd : 'NGO',ctNm : '나고야'},{ctCd : 'CTS',ctNm : '삿포로'},{ctCd : 'OKA',ctNm : '오키나와'},{ctCd : 'OKJ',ctNm : '오카야마'}]}
							,{naNm : '중국',cityList : [{ctCd : 'PEK',ctNm : '북경'},{ctCd : 'PVG',ctNm : '상해(푸동)'},{ctCd : 'TAO',ctNm : '청도'},{ctCd : 'CAN',ctNm : '광주'},{ctCd : 'SHA',ctNm : '상해(홍차오)'},{ctCd : 'SHE',ctNm : '심양'},{ctCd : 'YNT',ctNm : '연태'},{ctCd : 'DLC',ctNm : '대련'}]}
							,{naNm : '동남아',cityList : [{ctCd : 'KLO',ctNm : '보라카이(칼리보)'},{ctCd : 'HKG',ctNm : '홍콩'},{ctCd : 'BKK',ctNm : '방콩'},{ctCd : 'MNL',ctNm : '마닐라'},{ctCd : 'SIN',ctNm : '싱가폴'},{ctCd : 'SGN',ctNm : '호치민'},{ctCd : 'TPE',ctNm : '타이페이'},{ctCd : 'HKT',ctNm : '푸켓'},{ctCd : 'KUL',ctNm : '쿠알라룸푸르'},{ctCd : 'HAN',ctNm : '하노이'}]}
							,{naNm : '미국',cityList : [{ctCd : 'LAX',ctNm : '로스앤젤레스'},{ctCd : 'JFK',ctNm : '뉴욕(JFK)'},{ctCd : 'LGA',ctNm : '뉴욕(라과디아,LGA)'},{ctCd : 'EWR',ctNm : '뉴욕(뉴왁,EWR)'},{ctCd : 'SFO',ctNm : '샌프란시스코'},{ctCd : 'HNL',ctNm : '호놀룰루'},{ctCd : 'SEA',ctNm : '시애틀'},{ctCd : 'ORD',ctNm : '시카고'},{ctCd : 'IAD',ctNm : '워싱턴'},{ctCd : 'DFW',ctNm : '달라스'}]}
							,{naNm : '유럽',cityList : [{ctCd : 'LHR',ctNm : '런던(히드로)'},{ctCd : 'LON',ctNm : '런던(게트윅)'},{ctCd : 'CDG',ctNm : '파리(샤를드골)'},{ctCd : 'FRA',ctNm : '프랑크푸르트'},{ctCd : 'FCO',ctNm : '로마'},{ctCd : 'IST',ctNm : '이스탄불'},{ctCd : 'MAD',ctNm : '마드리드'},{ctCd : 'PRG',ctNm : '프라하'},{ctCd : 'ZRH',ctNm : '취리히'},{ctCd : 'AMS',ctNm : '암스테르담'},{ctCd : 'SVO',ctNm : '모스크바'}]}
							,{naNm : '대양주',cityList : [{ctCd : 'SYD',ctNm : '시드니'},{ctCd : 'AKL',ctNm : '오클랜드'},{ctCd : 'BNE',ctNm : '브리즈번'},{ctCd : 'MEL',ctNm : '멜버른'},{ctCd : 'GUM',ctNm : '괌'},{ctCd : 'SPN',ctNm : '사이판'}]}
							,{naNm : '중남미',cityList : [{ctCd : 'MEX',ctNm : '멕시코시티'},{ctCd : 'SAO',ctNm : '상파울루'},{ctCd : 'LIM',ctNm : '리마'},{ctCd : 'CUN',ctNm : '칸쿤'}]}
							,{naNm : '중동',cityList : [{ctCd : 'DXB',ctNm : '두바이'},{ctCd : 'CAI',ctNm : '카이로'},{ctCd : 'AUH',ctNm : '아부다비'}]}
							,{naNm : '아프리카',cityList : [{ctCd : 'JNB',ctNm : '요하네스버그'},{ctCd : 'CPT',ctNm : '케이프타운'},{ctCd : 'NBO',ctNm : '나이로비'}]}                   
		                ];
		}
		
	} else {		//국내
		//해외출발 선택 시 검색창 추가
		/*if() {
			
		}*/
		
		setTitle = '출발도시선택';
		
		baseCityList = [
	                	{naNm : '출발지', cityList : [{ctCd : 'SEL',ctNm : '인천/김포'},{ctCd : 'ICN',ctNm : '인천'},{ctCd : 'GMP',ctNm : '김포'},{ctCd : 'PUS',ctNm : '부산'},{ctCd : 'CJJ',ctNm : '청주'},{ctCd : 'MWX',ctNm : '무안(광주)'},{ctCd : 'KWJ',ctNm : '광주'},{ctCd : 'SHO',ctNm : '속초'},{ctCd : 'KUV',ctNm : '군산'},{ctCd : 'WJU',ctNm : '원주'},{ctCd : 'KAG',ctNm : '강릉'},{ctCd : 'CJU',ctNm : '제주'},{ctCd : 'TAE',ctNm : '대구'},{ctCd : 'RSU',ctNm : '여수'},{ctCd : 'HIN',ctNm : '진주'},{ctCd : 'MPK',ctNm : '목포'},{ctCd : 'USN',ctNm : '울산'},{ctCd : 'KPO',ctNm : '포항'}]}
					];

	}
	city_pop.find('.pop_cont').html(cont_html);
	
	if(_type == 'hotel') {
		city_pop.find('#cityPopInput').on('keyup', fn_hotel_search_input);
	} else {
		city_pop.find('#cityPopInput').on('keyup', fn_search_input);
	}
	
	//닫기버튼 설정
	var close_btn = $('<a href="javascript:void(0);" att-id="' + tmp_id + '" class="btn floatR">닫기</a>')
			.on('click', uijs.hide);
	city_pop.find('.pop_head').html(setTitle).append(close_btn); //제목추가
	
	var city_div = city_pop.find('tbody[ft-att="city_list_div"]');	
	
	if(_type != 'hotel' && availGbn != 'departure') {
		//검색값 입력시 액션		-- 호텔, 렌터카의 지역정보 정의가 내려지지 않음 20170113
		/*if($('#f_frm').children('[name="selHotel"]').val() == 'Y' ){
			var htl_app_btn = $('<tr class="bdt"></tr>');
			var htl_app = $('<td colspan="5"></td>')
					.append('<input type="checkbox" id="app_hotel" />')
					.append('<label for="app_hotel" class="on_lab">선택 지역 호텔 동일 적용</label>');
			
			htl_app_btn.append(htl_app)
						.appendTo(city_div);
		}
		
		if($('#f_frm').children('[name="selRentcar"]').val() == 'Y' ){
			var rnt_app_btn = $('<tr class="bdt"></tr>');
			var rnt_app = $('<td colspan="5"></td>')
					.append('<input type="checkbox" id="app_car" />')
					.append('<label for="app_car" class="on_lab">선택 지역 렌터카 동일 적용</label>');
			
			rnt_app_btn.append(rnt_app)
						.appendTo(city_div);
		}*/
	}	
	
	// 기본 도시 세팅
	for(var c_idx=0; c_idx<baseCityList.length; c_idx++) {
		var cityGroup = baseCityList[c_idx];
		var row_cnt = cityGroup.cityList.length / 4;
		if(cityGroup.cityList.length % 4 > 0) {
			row_cnt++;
		}
		
		var drawStr = $('<tr></tr>')
				.append('<th scope="row" rowspan="' + row_cnt + '">' + cityGroup.naNm + '</th>');
		
		if(_type == 'hotel') {
			//호텔 도시 검색
			for(var l_idx=0;l_idx<cityGroup.cityList.length; l_idx++) {
				var city_list = cityGroup.cityList[l_idx];
				var city_col = $('<td city-data="' + city_list.ctCd + '" country-data="' + city_list.naCd + '">' + city_list.ctNm + '</td>')
							.on('click', selHotelCity)
							.css('cursor' , 'pointer');
				drawStr.append(city_col);
				
				if(cityGroup.cityList.length == (l_idx+1) ) {
					var vNo = cityGroup.cityList.length % 4;
					if(vNo > 0) {
						for(var v_idx=vNo; v_idx<4; v_idx++) {
							drawStr.append('<td></td>');
						}
					}				
					drawStr.appendTo(city_div);
				} else if(l_idx%4 == 3) {
					drawStr.appendTo(city_div);
					drawStr = $('<tr></tr>');
				}
			}
		} else {
			//항공 도시 검색
			for(var l_idx=0;l_idx<cityGroup.cityList.length; l_idx++) {
				var city_list = cityGroup.cityList[l_idx];
				var city_col = $('<td ft-data="' + city_list.ctCd + '">' + city_list.ctNm + '</td>')
							.on('click', selCity)
							.css('cursor' , 'pointer');
				drawStr.append(city_col);
				
				if(cityGroup.cityList.length == (l_idx+1) ) {
					var vNo = cityGroup.cityList.length % 4;
					if(vNo > 0) {
						for(var v_idx=vNo; v_idx<4; v_idx++) {
							drawStr.append('<td></td>');
						}
					}				
					drawStr.appendTo(city_div);
				} else if(l_idx%4 == 3) {
					drawStr.appendTo(city_div);
					drawStr = $('<tr></tr>');
				}
			}
		}
	}
	
	setTimeout(function(){
		//팝업 위치지정
		uijs.setPosition(city_pop);
		
		//표시
		uijs.show(tmp_id);
	}, 0);
}



//상세보기 팝업 - 임시 미완료
function fn_showDetailPop (_obj, _data) {
	//상세보기 popup 존재 시 삭제
	if($('div[ft-att="air_detail_pop"]').length < 1) {
		$('div[ft-att="air_detail_pop"]').remove();
	}

	//기본 popup골격 생성
	var tmp_id = uijs.init();	
	
	var base_pop = $('div[pop-id="' + tmp_id + '"]');
	
	//pop속성 추가
	base_pop.addClass('air')
			.attr('ft-att', 'air_detail_pop');

	//대상이 되는 inputbox 지정
	var detail_pop = $('div[ft-att="air_detail_pop"]')
			.attr('target-id', $(_obj).attr('id')); 
		
	//제목
	var close_btn = $('<a href="javascript:void(0);" att-id="' + tmp_id + '" class="btn floatR">닫기</a>')
			.on('click', uijs.hide);
	detail_pop.find('.pop_head').html('항공상세보기')
								.append(close_btn);
	
	//내용
	var cont_html = '<table class="air">                                                                                     '
				+	'</table>                                                                                                '
				+	'<div class="contsum">                                                                                   '
				+	'	<dl ft-att="gbn">                                                                                                 '
				+	'	    <dt>구분</dt>                                                                                      '
				+	'	</dl>                                                                                                '
				+	'	<dl ft-att="fare">                                                                                                 '
				+	'	    <dt>기본운임</dt>                                                                                    '
				+	'	</dl>                                                                                                '
				+	'	<dl ft-att="fuel">                                                                                                 '
				+	'	    <dt>유류할증료</dt>                                                                                   '
				+	'	</dl>                                                                                                '
				+	'	<dl ft-att="tax">                                                                                                 '
				+	'	    <dt>제세공과금</dt>                                                                                   '
				+	'	</dl>                                                                                                '
				+	'	<dl class="price">                                                                                   '
				+	'	    <dt>총운임</dt>                                                                                     '
				+	'	</dl>                                                                                                '
				+	'</div>                                                                                                  '
				+	'<dl class="allsum">                                                                                     '
				+	'	<dt>총 운임</dt>                                                                                        '
				+	'	<dd>0원</dd>                                                                                  '
				+	'</dl>';
	detail_pop.find('.pop_cont').html(cont_html)
							.addClass('contBox');
	
	//seg 가져오기
	var arCnt = $(_obj).parents('li[ft-att="fare_list"]').attr('ar-cnt');
	var air_fix_data_info = air_fix_data[arCnt];
	var arDetailList = air_fix_data_info.segmentGroup;
	var avail_cnt = air_fix_data_info.fltData.length;

	
	var avail_div = detail_pop.find('.pop_cont').find('table.air');
	for(var d_idx=0; d_idx < arDetailList.length; d_idx++) {
		var arDetailInfo = arDetailList[d_idx];
		var arFixData = air_fix_data_info.fltData[(arDetailInfo.availNo - 1)];
		
		var tmpDetailDiv = $('<tr></tr>');
		if(arDetailInfo.segNo == 1) {
			var tmpTitle = '';
			var segCnt = arFixData.segCnt;
			if(arDetailInfo.availNo == 1) {
				tmpTitle = '<th rowspan="' + segCnt + '"><em></em>출발<br/>여정</th>';
			} else if(arDetailInfo.availNo == avail_cnt) {
				tmpTitle = '<th rowspan="' + segCnt + '"><em class="back"></em>도착<br/>여정</th>';
			} else {
				tmpTitle = '<th rowspan="' + segCnt + '"><em></em>다구간<br/>여정</th>';
			}
			tmpDetailDiv.append(tmpTitle);
		}
		
		var bookingClas = arDetailInfo.cabinClas;
		if(bookingClas == 'W') {
			bookingClas = '프리미엄일반석';
		} else if(bookingClas == 'F') {
			bookingClas = '일등석';
		} else if(bookingClas == 'C') {
			bookingClas = '비지니스석';
		} else{
			bookingClas = '일반석';
		}
		
		var viaNm = arFixData.stopYn;
		
		var dep_tm = arDetailInfo.depTm.substring(0,2) + ':' + arDetailInfo.depTm.substring(2,4);
		var dep_dt = arDetailInfo.depDt.substring(0,4) + '.' + arDetailInfo.depDt.substring(4,6) + '.' + arDetailInfo.depDt.substring(6,8);
		dep_dt = dep_dt + '(' + gfn_getDay(dep_dt) + ')'; 
		
		var arr_tm = arDetailInfo.arrTm.substring(0,2) + ':' + arDetailInfo.arrTm.substring(2,4);
		var arr_dt = arDetailInfo.arrDt.substring(0,4) + '.' + arDetailInfo.arrDt.substring(4,6) + '.' + arDetailInfo.arrDt.substring(6,8);
		arr_dt = arr_dt + '(' + gfn_getDay(arr_dt) + ')';
		
		//공동운항
		var codeShareYn = '';
		if(arDetailInfo.codeShare != ''){
			codeShareYn = arDetailInfo.codeShareNm + ' 공동운항'; 
		}
		
		var availInfo = '<td>                                                                                             '
				    +	'    <dl>                                                                                         '
					+	'        <dt class="first"><img src="/common/images/air/' + arDetailInfo.carrierCd + '.png" alt="항공아이콘"/>'
								+ arDetailInfo.carrierNm + '-편명 '
								+ arDetailInfo.fltNo + '(' + bookingClas + ')' + viaNm + '<b>' + codeShareYn + '</b></dt>	'
					+	'        <dd class="stime"><span>' + dep_tm + '</span></dd>                         '
					+	'        <dd class="sdate">' + dep_dt + '</dd>                                                     '
					+	'        <dd class="sarea">' + arDetailInfo.depNm + '(' + arDetailInfo.depCd + ')' + '</dd>                                                           '
					+	'        <dd class="etime"><span>' + arr_tm + '</span></dd>                                                '
					+	'        <dd class="edate">' + arr_dt + '</dd>                                                     '
					+	'        <dd class="earea">' + arDetailInfo.arrNm + '(' + arDetailInfo.arrCd + ')' + '</dd>    '
					+	'        <dd class="htime"><span>' + arDetailInfo.interval + '</span></dd>                                               '
					+	'    </dl>                                                                                        '
					+	'</td>';    
		
		tmpDetailDiv.append(availInfo);
		
		avail_div.append(tmpDetailDiv);
	}
	
	//요금 계산
	//검색값 가져오기
	var inputvalue = JSON.parse(sessionStorage.airSearchVal).bodyDto;
	var iPasCnt = []; 
		
	iPasCnt[0] = inputvalue.adtCnt; 
	iPasCnt[1] = inputvalue.chdCnt;
	iPasCnt[2] = inputvalue.infCnt;
	
	var fareDiv = detail_pop.find('.pop_cont').find('div.contsum');
	var totFare = 0;
	for(var f_idx=0; f_idx<iPasCnt.length; f_idx++) {
		var i_pas_cnt = iPasCnt[f_idx];
		if(i_pas_cnt > 0){
			//인원수
			var pasNm = '';
			if(f_idx == 0){
				pasNm = '성인' + i_pas_cnt + '명';
			} else if (f_idx == 1) {
				pasNm = '아동' + i_pas_cnt + '명';
			} else if (f_idx == 2) {
				pasNm = '유아' + i_pas_cnt + '명';
			}
			fareDiv.find('dl[ft-att="gbn"]').append('<dd>' + pasNm + '</dd>');
			
			var paxData = air_fix_data_info.paxDataBean[f_idx];
			//기본운임
			var faresum = paxData.fareCharge * i_pas_cnt;
			fareDiv.find('dl[ft-att="fare"]').append('<dd>' + setPriceInput(faresum) + '원</dd>');
			
			//유류할증료
			var fuelsum = 0;//미완료
			fareDiv.find('dl[ft-att="fuel"]').append('<dd>' + setPriceInput(fuelsum) + '원</dd>');
			
			//제세공과금
			var taxsum = paxData.taxCharge * i_pas_cnt;
			fareDiv.find('dl[ft-att="tax"]').append('<dd>' + setPriceInput(taxsum) + '원</dd>');
			
			//총운임
			fareDiv.find('dl.price').append('<dd>' + setPriceInput((faresum + fuelsum + taxsum)+'') + '원</dd>');
			
			//전체운임 계산
			totFare += faresum + fuelsum + taxsum;
		}
	}

	//전체운임 계산
	detail_pop.find('.pop_cont').find('dl.allsum > dd').text(setPriceInput(totFare+'') + '원');
		
	//팝업 위치지정
	uijs.setPosition(detail_pop);
	
	//표시
	uijs.show(tmp_id);
}



//선택상세보기 팝업 - 임시 미완료
function gfn_showSelectDetailPop(p_target) {

	$('html').css('overflow-y', 'hidden');
	
	//상세보기 popup 존재 시 삭제
	if($('div[ft-att="select_detail_pop"]').length < 1) {
		$('div[ft-att="select_detail_pop"]').remove();
	}

	//기본 popup골격 생성
	var tmp_id = uijs.init();	
	
	var base_pop = $('div[pop-id="' + tmp_id + '"]');
	
	//pop속성 추가
	base_pop.addClass('select_goods')
			.attr('ft-att', 'select_detail_pop');
		
	var select_pop = $('div[ft-att="select_detail_pop"]');
	
	//제목
	var close_btn = $('<a href="javascript:void(0);" att-id="' + tmp_id + '" class="btn floatR">닫기</a>')
			.on('click', uijs.hide);
	select_pop.find('.pop_head').html('선택상세보기')
								.append(close_btn);
	
	//선택항목이 들어갈 틀
	var goods_html = '<div class="choiceBox floatBox">										'						
				+	'    <ul class="one" ft-att="select_info">                              '
				+	'    </ul>                                                              '
				+	'    <div class="btnWrap">                                              '
				+	'		<a href="javascript:fn_reSelect(\'' + tmp_id + '\');" class="btn btnM gray">다시선택</a>	'
				+	'		<a href="javascript:fn_goNext();" class="btn btnM purple">다음</a>	'
				+	'    </div>																'
				+	'</div>';
	select_pop.find('.pop_cont').html(goods_html)
							.addClass('contBox');
		
	if(sessionStorage.airSelData == undefined) {
		sessionStorage.airSelData = JSON.stringify([]); 
	}
	if(sessionStorage.hotelSelData == undefined) {
		sessionStorage.hotelSelData = JSON.stringify([]);
	}
	if(sessionStorage.rentcarSelData == undefined) {
		sessionStorage.rentcarSelData = JSON.stringify([]);
	}
	
	var selGroup = {
		'selAir' : $('#f_frm').children('input[name="selAir"]').val() == 'Y',
		'selHotel' : $('#f_frm').children('input[name="selHotel"]').val() == 'Y',
		'selRent' : $('#f_frm').children('input[name="selRentcar"]').val() == 'Y'
	};
	
	/** 항공 선택항목 채우기 */
	var goodsListDiv = select_pop.find('ul[ft-att="select_info"]');
	if(selGroup.selAir) {
		var airGoods = JSON.parse(sessionStorage.airSelData);
		if(!!airGoods) {
			var title_info = '대한항공' + '<span>(' + '왕복' + ' ' + '1회경유' + ')</span>';
			var cont_html = '<li pop-att="air">													'
						+	'	<div class="menu">                                 	'
						+	'		<h5>항공 : ' + title_info + '<b>상세닫기</b></h5>	'
						+	'	</div>                                             	'
						+	'	<ul class="two">                                   	'
						+	'		<li>                                           	'
						+	'			<div class="layout detail contBox">        	'
						+	'	                                                   	'
						+	'				<table class="air">                    	'
						+	'				</table>                               	'
						+	'				<div class="contsum">                  	'
						+	'					<dl ft-att="gbn">                  	'
						+	'					    <dt>구분</dt>                  	'
						+	'					</dl>                              	'
						+	'					<dl ft-att="fare">                 	'
						+	'					    <dt>기본운임</dt>                	'
						+	'					</dl>                              	'
						+	'					<dl ft-att="fuel">                  '
						+	'					    <dt>유류할증료</dt>              	'  
						+	'					</dl>                              	'
						+	'					<dl ft-att="tax">                  	'
						+	'					    <dt>제세공과금</dt>             	'
						+	'					</dl>                              	'
						+	'					<dl class="price">                 	'
						+	'					    <dt>총운임</dt>                 	'
						+	'					</dl>                              	'
						+	'				</div>                                 	'
						+	'				<dl class="allsum">                    	'
						+	'					<dt>총 운임</dt>                    	' 
						+	'					<dd>0원</dd>                       	'
						+	'				</dl>                                  	'
						+	'			</div>                                     	'
						+	'		</li>                                          	'
						+	'	</ul>                                              	'
						+	'</li>';
			goodsListDiv.html(cont_html);
			
			//seg 가져오기
			var arDetailList = airGoods.segmentGroup;
			var avail_cnt = airGoods.fltData.length;

			var avail_div = goodsListDiv.find('table.air');
			for(var d_idx=0; d_idx < arDetailList.length; d_idx++) {
				var arDetailInfo = arDetailList[d_idx];
				var arFixData = airGoods.fltData[(arDetailInfo.availNo - 1)];
				
				var tmpDetailDiv = $('<tr></tr>');
				if(arDetailInfo.segNo == 1) {
					var tmpTitle = '';
					var segCnt = arFixData.segCnt;
					if(arDetailInfo.availNo == 1) {
						tmpTitle = '<th rowspan="' + segCnt + '"><em></em>출발<br/>여정</th>';
					} else if(arDetailInfo.availNo == avail_cnt) {
						tmpTitle = '<th rowspan="' + segCnt + '"><em class="back"></em>도착<br/>여정</th>';
					} else {
						tmpTitle = '<th rowspan="' + segCnt + '"><em></em>다구간<br/>여정</th>';
					}
					tmpDetailDiv.append(tmpTitle);
				}
				
				var bookingClas = arDetailInfo.cabinClas;
				if(bookingClas == 'W') {
					bookingClas = '프리미엄일반석';
				} else if(bookingClas == 'F') {
					bookingClas = '일등석';
				} else if(bookingClas == 'C') {
					bookingClas = '비지니스석';
				} else{
					bookingClas = '일반석';
				}
				
				var viaNm = arFixData.stopYn;
				
				var dep_tm = arDetailInfo.depTm.substring(0,2) + ':' + arDetailInfo.depTm.substring(2,4);
				var dep_dt = arDetailInfo.depDt.substring(0,4) + '.' + arDetailInfo.depDt.substring(4,6) + '.' + arDetailInfo.depDt.substring(6,8);
				dep_dt = dep_dt + '(' + gfn_getDay(dep_dt) + ')'; 
				
				var arr_tm = arDetailInfo.arrTm.substring(0,2) + ':' + arDetailInfo.arrTm.substring(2,4);
				var arr_dt = arDetailInfo.arrDt.substring(0,4) + '.' + arDetailInfo.arrDt.substring(4,6) + '.' + arDetailInfo.arrDt.substring(6,8);
				arr_dt = arr_dt + '(' + gfn_getDay(arr_dt) + ')';
				
				//공동운항
				var codeShareYn = '';
				if(arDetailInfo.codeShare != ''){
					codeShareYn = arDetailInfo.codeShareNm + ' 공동운항'; 
				}
				
				var availInfo = '<td>                                                                                             '
						    +	'    <dl>                                                                                         '
							+	'        <dt class="first"><img src="/common/images/air/' + arDetailInfo.carrierCd + '.png" alt="항공아이콘"/>'
										+ arDetailInfo.carrierNm + '-편명 '
										+ arDetailInfo.fltNo + '(' + bookingClas + ')' + viaNm + '<b>' + codeShareYn + '</b></dt>	'
							+	'        <dd class="stime"><span>' + dep_tm + '</span></dd>                         '
							+	'        <dd class="sdate">' + dep_dt + '</dd>                                                     '
							+	'        <dd class="sarea">' + arDetailInfo.depNm + '(' + arDetailInfo.depCd + ')' + '</dd>                                                           '
							+	'        <dd class="etime"><span>' + arr_tm + '</span></dd>                                                '
							+	'        <dd class="edate">' + arr_dt + '</dd>                                                     '
							+	'        <dd class="earea">' + arDetailInfo.arrNm + '(' + arDetailInfo.arrCd + ')' + '</dd>    '
							+	'        <dd class="htime"><span>' + arDetailInfo.interval + '</span></dd>                                               '
							+	'    </dl>                                                                                        '
							+	'</td>';    
				
				tmpDetailDiv.append(availInfo);
				
				avail_div.append(tmpDetailDiv);
			}
			
			//요금 계산
			//검색값 가져오기
			var inputvalue = JSON.parse(sessionStorage.airSearchVal).bodyDto;
			var iPasCnt = []; 
				
			iPasCnt[0] = inputvalue.adtCnt; 
			iPasCnt[1] = inputvalue.chdCnt;
			iPasCnt[2] = inputvalue.infCnt;
			
			var fareDiv = goodsListDiv.find('div.contsum');
			for(var f_idx=0; f_idx<iPasCnt.length; f_idx++) {
				var i_pas_cnt = iPasCnt[f_idx];
				if(i_pas_cnt > 0){
					//인원수
					var pasNm = '';
					if(f_idx == 0){
						pasNm = '성인' + i_pas_cnt + '명';
					} else if (f_idx == 1) {
						pasNm = '아동' + i_pas_cnt + '명';
					} else if (f_idx == 2) {
						pasNm = '유아' + i_pas_cnt + '명';
					}
					fareDiv.find('dl[ft-att="gbn"]').append('<dd>' + pasNm + '</dd>');
					
					var paxData = airGoods.paxDataBean[f_idx];	
					//기본운임
					var faresum = paxData.fareCharge * i_pas_cnt;
					fareDiv.find('dl[ft-att="fare"]').append('<dd>' + setPriceInput(faresum+'') + '원</dd>');
					
					//유류할증료
					var fuelsum = 0;//미완료
					fareDiv.find('dl[ft-att="fuel"]').append('<dd>' + setPriceInput(fuelsum+'') + '원</dd>');
					
					//제세공과금
					var taxsum = paxData.taxCharge * i_pas_cnt;
					fareDiv.find('dl[ft-att="tax"]').append('<dd>' + setPriceInput(taxsum+'') + '원</dd>');
					
					//총운임
					fareDiv.find('dl.price').append('<dd>' + setPriceInput((faresum + fuelsum + taxsum)+'') + '원</dd>');
					
					//전체운임 계산
					//totFare += faresum + fuelsum + taxsum;
				}
			}

			//전체운임 계산
			goodsListDiv.find('dl.allsum > dd').text(setPriceInput(airGoods.totSaleCharge+'') + '원');
			
			
			//이전 동작이 항공 선택일 경우 항공 선택 정보 오픈
			if(p_target == 'air'){
				var air_float_div = select_pop.find(".floatBox ul.one > li[pop-att=\"air\"]");
				air_float_div.addClass("open"); //첫메뉴 오픈
				air_float_div.children("ul.two").css("display","block"); //첫메뉴 오픈
			}
			
		} else {
			// 선택 항목 없을 때 
		}
	} 
	
	/** 호텔 입력 */
	if(selGroup.selHotel) {
		var hotelGoodsList = JSON.parse(sessionStorage.hotelSelViewData);
		if(hotelGoodsList.length > 0) {
			
			var title_info = '';
			
			var cont_html = '<li pop-att="hotel">						'
						+	'	<div class="menu">                                 	'
						+	'		<h5 ft-att="selHotelNmList"></h5>	'
						+	'	</div>                                             	'
						+	'	<ul class="two">                                   	'
						+	'		<li>                                           	'
						+	'			<div class="layout detail contBox hotel">';
			
				for(var h_idx=0; h_idx<hotelGoodsList.length; h_idx++){
					
					var f_hotelData = hotelGoodsList[h_idx]; 
					
					var jf_countryNm 	= f_hotelData.countryCode;	//미완성 - 나라 한글명 구하기
					var jf_cityNm 		= f_hotelData.cityCode;		//미완성 - 도시 한글명 구하기
					var jf_hotelNm 		= f_hotelData.hotelName;	//호텔명
					var jf_checkIn 		= f_hotelData.checkInDate;	//체크인 날짜
					var jf_checkOut 	= f_hotelData.checkOutDate;	//체크아웃 날짜
					var jf_roomTy 		= f_hotelData.roomName;		//룸타입
					var jf_adtCntArr 	= f_hotelData.numberOfAdults.split('');	//어른 수
					var jf_chdCntArr 	= f_hotelData.numberOfChildren.split('');	//아동 수	
					
					title_info += ', ' + '태국' + '/' + '방콕';
					
					var rsvStat = '';
					if(f_hotelData.rsvAble == 'Y'){	//즉시 확정 여부 : 임시 - 미완료
						rsvStat = '즉시확정';
					} else {
						rsvStat = '예약대기';
					}
					
					var subBreakfast = '';
					if(f_hotelData.breakfast == 'Y'){	//조식 제공 여부 : 임시 - 미완료
						subBreakfast = '조식포함';
					} else {
						subBreakfast = '조식불포함';
					}
					
					var jf_adtCnt = 0;
					for(var jf_idx=0; jf_idx<jf_adtCntArr.length; jf_idx++){
						jf_adtCnt += jf_adtCntArr[jf_idx]-0;
					}
					
					var guestInfo = '객실 ' + f_hotelData.roomCntRq + ', 성인 ' + jf_adtCnt;
	                
					var jf_chdCnt = 0;
					for(var jf_idx=0; jf_idx<jf_chdCntArr.length; jf_idx++){
						jf_chdCnt += jf_chdCntArr[jf_idx]-0;
					}
					
					if(jf_chdCnt > 0){
						guestInfo += ', 아동 ' + jf_chdCnt;
					}
					
					var f_checkDate = jf_checkIn + '(' + gfn_getDay(jf_checkIn) + ')'
					+	' ~ ' + jf_checkOut + '(' + gfn_getDay(jf_checkOut) + ')';

					var f_dayNight = calcInterval(jf_checkIn, '0000', jf_checkOut, '0000');
					if(f_dayNight != ''){
						f_dayNight = f_dayNight.split(',')[0] + '박';	
					}
					
					cont_html +='	<div class="contsum">                                  	'
							+	'		<dl class="tit">                                 '
							+	'			<dt>호텔 ' + (h_idx+1) + ' </dt>	                     '
							+	'			<dd>' + jf_hotelNm + '(' + jf_countryNm + '/' + jf_cityNm + ')</dd>	'
							+	'		</dl>                                            '
							+	'		<dl>                                             '
							+	'			<dt>투숙기간</dt>                             '  
							+	'			<dd>' + f_checkDate + ' ' + f_dayNight + '</dd>'  
							+	'		</dl>                                            '
							+	'		<dl>                                             '
							+	'			<dt>객실</dt>                                  '
							+	'			<dd><b class="b1">' + rsvStat + '</b> ' + subBreakfast + '(' + jf_roomTy + ' / ' + guestInfo + ')</dd>'
							+	'		</dl>                                                                  	'
							+	'		<dl>                                                                   	'
							+	'			<dt>취소규정</dt>                                                '
							+	'			<dd><i>' + f_hotelData.cancelDate + ' 까지 무료 취소</i></dd>      	'
							+	'		</dl>											                      	'
							+	'		<dl class="allsum">                                                   	'
							+	'			<dt>총운임</dt>                                                   	'
							+	'			<dd>' + setPriceInput(f_hotelData.total) + '원</dd>                            	'
							+	'		</dl>				                                                  	'
							+	'	</div>';
				}
							
				cont_html +=	'			</div>    	'
							+	'		</li>         	'
							+	'	</ul>             	'
							+	'</li>';
									
				goodsListDiv.append(cont_html);
	
				//이전 동작이 호텔 선택일 경우 호텔 선택 정보 오픈
				if(p_target == 'hotel'){
					var air_float_div = select_pop.find(".floatBox ul.one > li[pop-att=\"hotel\"]");
					air_float_div.addClass("open"); //첫메뉴 오픈
					air_float_div.children("ul.two").css("display","block"); //첫메뉴 오픈
				}
			
				$('[ft-att="selHotelNmList"]').html('호텔 : ' + title_info + '<b>상세닫기</b>');
		} else {
			// 선택 항목 없을 때 
		}
	} 
	
	// 온클릭 이벤트 부여
	set_float_act();	
	
	//팝업 위치지정
	uijs.setPosition(select_pop);
	
	//표시
	uijs.show(tmp_id);
}

//취소규정보기 - 호텔 팝업
function fn_showCancelPop (_data) {
	//취소규정보기 popup 존재 시 삭제
	if($('div[ft-att="cancel_certi_pop"]').length < 1) {
		$('div[ft-att="cancel_certi_pop"]').remove();
	}

	//기본 popup골격 생성
	var tmp_id = uijs.init();
	
	var base_pop = $('div[pop-id="' + tmp_id + '"]');
	
	//pop속성 추가
	base_pop.addClass('rate_price')	//임시
			.attr('ft-att', 'cancel_certi_pop');
	
	var certi_pop = $('div[ft-att="cancel_certi_pop"]'); 
	
	//제목
	var close_btn = $('<a href="javascript:void(0);" att-id="' + tmp_id + '" class="btn floatR">닫기</a>')
			.on('click', uijs.hide);
	certi_pop.find('.pop_head').html('취소규정')
								.append(close_btn);
	
	//내용
	var cont_html = '<div class="priceWrap"></div>';
	certi_pop.find('.pop_cont').html(cont_html);

	var certi_div = certi_pop.find('.priceWrap');
	certi_div.html('취소 하지마셈');	//	임시 - 미완료
	
	//팝업 위치지정
	uijs.setPosition(certi_pop);
	
	//표시
	uijs.show(tmp_id);
}
