<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
	// 파일명 : pop_city_select2.jsp
	// 설명 : 주요도시 선택 (결과)

	String type = (String) request.getAttribute("type");
%>
<script type="text/javascript">

	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){
	
	
	var setTitle = '';
	var baseCityList = []; //도시리스트
	var _type="<%=type%>";
	var nowScrollY = window.scrollY;
	var htlCheckbox = $("#hotelcheck").is(":checked");
	var rntCheckbox = $("#carcheck").is(":checked");

	setTitle = '주요도시 선택';
	
	baseCityList = [{
	    naNm: '일본', cityList: [{
			airCd: 'NRT', htlCd: 'JC0063434', ctNmEn: 'Tokyo', rntCd: 'NARITA', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '도쿄(나리타)', ctNmEn: 'Tokyo'
	    }, {
			airCd: 'HND', htlCd: 'JC0063434', ctNmEn: 'Tokyo', rntCd: 'HANEDA', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '도쿄(하네다)', ctNmEn: 'Tokyo'
	    }, {
			airCd: 'KIX', htlCd: 'JC0063062', ctNmEn: 'Osaka', rntCd: 'OSAKA', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '오사카', ctNmEn: 'Osaka'
	    }, {
			airCd: 'FUK', htlCd: 'JC0062152', ctNmEn: 'Fukuoka', rntCd: 'FUKUOKA', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '후쿠오카', ctNmEn: 'Fukuoka'
	    }, {
			airCd: 'NGO', htlCd: 'JC0062864', ctNmEn: 'Nagoya', rntCd: 'NGO', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '나고야', ctNmEn: 'Nagoya'
	    }, {
			airCd: 'CTS', htlCd: 'JC0063160', ctNmEn: 'Sapporo', rntCd: 'CHITOSE', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '삿포로', ctNmEn: 'Sapporo'
	    }, {
			airCd: 'OKA', htlCd: 'JC0063028', ctNmEn: 'Okinawa City', rntCd: 'OKINAWA', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '오키나와', ctNmEn: 'Okinawa'
	    }, {
			airCd: 'OKJ', htlCd: 'JC0063023', ctNmEn: 'Okayama', rntCd: 'OKAYAMA', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '오카야마', ctNmEn: 'Okayama'
	    }, {
	    	airCd: 'TAK', htlCd: 'JC0063354', ctNmEn: 'Takamatsu', rntCd: 'TAKAMATSU', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '다카마쓰', ctNmEn: 'Takamatsu'
	    }]
	}, {
	    naNm: '중국', cityList: [{
			airCd: 'PEK', htlCd: 'JC0015266', ctNmEn: 'Beijing', rntCd: 'Beijing', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '북경', ctNmEn: 'Beijing'
	    }, {
	        airCd: 'CAN', htlCd: 'JC0015446', ctNmEn: 'Guangzhou', rntCd: 'GUANGZHOU', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '광주', ctNmEn: 'Guangzhou'
	    }, {
	        airCd: 'SHA', htlCd: 'JC0015880', ctNmEn: 'Shanghai', rntCd: 'SHA', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '상해(홍차오)', ctNmEn: 'Shanghai'
	    }, {
	        airCd: 'PVG', htlCd: 'JC0015880', ctNmEn: 'Shanghai', rntCd: 'PVG', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '상해(푸동)', ctNmEn: 'Shanghai'	// 호텔코드 너무 광범위함 푸동으로 검색 안됨
	    }, {
	        airCd: 'YNT', htlCd: 'JC0016124', ctNmEn: 'Yantai', rntCd: 'Yantai', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '연태', ctNmEn: 'Yantai'		// 렌터카 검색 안됨
	    }, {
	        airCd: 'DLC', htlCd: 'JC0015350', ctNmEn: 'Dalian', rntCd: 'DALIAN', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '대련', ctNmEn: 'Dalian'
	    }, {
	        airCd: 'TAO', htlCd: 'JC0015822', ctNmEn: 'Qingdao', rntCd: 'QINGDAO', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '청도(칭다오)', ctNmEn: 'Qingdao'
	    }, {
	        airCd: 'HGH', htlCd: 'JC0015486', ctNmEn: 'Hangzhou', rntCd: 'HANGZHOU', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '항주(항저우)', ctNmEn: 'Hangzhou'		//COM_AIRPORTCD테이블에서 사용안함으로 되어있음, 한글명 없음
	    }]
	}, {	
	    naNm: '동남아', cityList: [{
	        airCd: 'KLO', htlCd: 'JC0071416', ctNmEn: 'Boracay Island', rntCd: 'Boracay Island', naNm: '필리핀', naCd: 'PH', stCd: '', ctNm: '보라카이(칼리보)', ctNmEn: 'Boracay'	
	    }, {
	        airCd: 'HKG', htlCd: 'JC0049435', ctNmEn: 'Hong Kong', rntCd: 'HONG KONG', naNm: '홍콩', naCd: 'HK', stCd: '', ctNm: '홍콩', ctNmEn: 'Hong Kong'
	    }, {
	        airCd: 'BKK', htlCd: 'JC0078154', ctNmEn: 'Bangkok', rntCd: 'BANGKOK', naNm: '태국', naCd: 'TH', stCd: '', ctNm: '방콕', ctNmEn: 'Bangkok'
	    }, {
	        airCd: 'MNL', htlCd: 'JC0071598', ctNmEn: 'Manila', rntCd: 'MANILA', naNm: '필리핀', naCd: 'PH', stCd: '', ctNm: '마닐라', ctNmEn: 'Manila'
	    }, {
	        airCd: 'SIN', htlCd: 'JC0077394', ctNmEn: 'Singapore', rntCd: 'SINGAPORE', naNm: '싱가포르', naCd: 'SG', stCd: '', ctNm: '싱가폴', ctNmEn: 'Singapore'
	    }, {
	        airCd: 'SGN', htlCd: 'JC0097234', ctNmEn: 'Ho Chi Minh City', rntCd: 'SGN', naNm: '베트남', naCd: 'VN', stCd: '', ctNm: '호치민', ctNmEn: 'Ho Chi Minh'		// 렌터카 검색 안됨 - 베트남 자체가 없음
	    }, {
	        airCd: 'HKT', htlCd: 'JC0078716', ctNmEn: 'Phuket', rntCd: 'PHUKET', naNm: '태국', naCd: 'TH', stCd: '', ctNm: '푸켓', ctNmEn: 'Phuket'
	    }, {
	        airCd: 'KUL', htlCd: 'JC0067272', ctNmEn: 'Kuala Lumpur', rntCd: 'Kuala Lumpur', naNm: '말레이시아', naCd: 'MY', stCd: '', ctNm: '쿠알라룸푸르', ctNmEn: 'Kuala Lumpur'
	    }, {
	        airCd: 'HAN', htlCd: 'JC0097231', ctNmEn: 'Hanoi', rntCd: 'Hanoi', naNm: '베트남', naCd: 'VN', stCd: '', ctNm: '하노이', ctNmEn: 'Hanoi'		// 렌터카 검색 안됨 - 베트남 자체가 없음
	    }, {
	        airCd: 'MFM', htlCd: 'JC0065554', ctNmEn: 'Macau', rntCd: 'Macau', naNm: '마카오', naCd: 'MO', stCd: '', ctNm: '마카오', ctNmEn: 'Macau'		// 렌터카 검색 안됨
	    }, {
	        airCd: 'CEB', htlCd: 'JC0071461', ctNmEn: 'Cebu', rntCd: 'CEBU', naNm: '필리핀', naCd: 'PH', stCd: '', ctNm: '세부', ctNmEn: 'Cebu'
	    }, {
	        airCd: 'TPE', htlCd: 'JC0080233', ctNmEn: 'Taipei', rntCd: 'Taipei', naNm: 'TW', naCd: '대만', stCd: '', ctNm: '타이베이', ctNmEn: 'Taipei'		// 렌터카 검색 안됨
	    }]
	}, {
	    naNm: '미국', cityList: [{
	        airCd: 'JFK', htlCd: 'JC0090685', ctNmEn: 'New York', rntCd: 'NEW YORK', naNm: '미국', naCd: 'US', stCd: 'NY', ctNm: '뉴욕(JFK)', ctNmEn: 'New York'
	    }, {
	        airCd: 'SFO', htlCd: 'JC0093274', ctNmEn: 'San Francisco', rntCd: 'SAN FRANCISCO', naNm: '미국', naCd: 'US', stCd: 'CA', ctNm: '샌프란시스코', ctNmEn: 'San Francisco'
	    }, {
	        airCd: 'HNL', htlCd: 'JC0087189', ctNmEn: 'Honolulu', rntCd: 'HONOLULU', naNm: '미국', naCd: 'US', stCd: 'HI', ctNm: '호놀룰루', ctNmEn: 'Honolulu'
	    }, {
	        airCd: 'SEA', htlCd: 'JC0093547', ctNmEn: 'Seattle', rntCd: 'SEATTLE', naNm: '미국', naCd: 'US', stCd: 'WA', ctNm: '시애틀', ctNmEn: 'Seattle'
	    }, {
	        airCd: 'ORD', htlCd: 'JC0083200', ctNmEn: 'Chicago', rntCd: 'CHICAGO', naNm: '미국', naCd: 'US', stCd: 'IL', ctNm: '시카고', ctNmEn: 'Chicago'
	    }, {
	        airCd: 'IAD', htlCd: 'JC0095775', ctNmEn: 'Washington', rntCd: 'WAS', naNm: '미국', naCd: 'US', stCd: 'DC', ctNm: '워싱턴', ctNmEn: 'Washington'
	    }, {
	        airCd: 'LAX', htlCd: 'JC0088982', ctNmEn: 'Los Angeles', rntCd: 'LOS ANGELES', naNm: '미국', naCd: 'US', stCd: 'CA', ctNm: '로스엔젤레스', ctNmEn: 'Los Angeles'
	    }, {
	        airCd: 'BOS', htlCd: 'JC0082032', ctNmEn: 'Boston', rntCd: 'BOSTON', naNm: '미국', naCd: 'US', stCd: 'MA', ctNm: '보스톤', ctNmEn: 'Boston'
	    }]
	}, {
	    naNm: '유럽', cityList: [{
	        airCd: 'LON', htlCd: 'JC0045360', ctNmEn: 'London', rntCd: 'LONDON', naNm: '영국', naCd: 'GB', stCd: '', ctNm: '런던', ctNmEn: 'London'
	    }, {
	        airCd: 'CDG', htlCd: 'JC0039217', ctNmEn: 'Paris', rntCd: 'PARIS', naNm: '프랑스', naCd: 'FR', stCd: '', ctNm: '파리', ctNmEn: 'Paris'
	    }, {
	        airCd: 'FRA', htlCd: 'JC0019450', ctNmEn: 'Frankfurt', rntCd: 'FRANKFURT', naNm: '독일', naCd: 'DE', stCd: '', ctNm: '프랑크푸르트', ctNmEn: 'Frankfurt'
	    }, {
	        airCd: 'FCO', htlCd: 'JC0059909', ctNmEn: 'Rome', rntCd: 'ROME', naNm: '이탈리아', naCd: 'IT', stCd: '', ctNm: '로마', ctNmEn: 'Rome'
	    }, {
	        airCd: 'IST', htlCd: 'JC0079503', ctNmEn: 'Istanbul', rntCd: 'ISTANBUL', naNm: '터키', naCd: 'TR', stCd: '', ctNm: '이스탄불', ctNmEn: 'Istanbul'
	    }, {
	        airCd: 'MAD', htlCd: 'JC0028725', ctNmEn: 'Madrid', rntCd: 'MADRID', naNm: '스페인', naCd: 'ES', stCd: '', ctNm: '마드리드', ctNmEn: 'Madrid'
	    }, {
	        airCd: 'PRG', htlCd: 'JC0017874', ctNmEn: 'Prague', rntCd: 'PRAGUE', naNm: '체코', naCd: 'CZ', stCd: '', ctNm: '프라하', ctNmEn: 'Prague'
	    }, {
	        airCd: 'ZRH', htlCd: 'JC0014839', ctNmEn: 'Zurich', rntCd: 'ZURICH', naNm: '스위스', naCd: 'CH', stCd: '', ctNm: '취리히', ctNmEn: 'Zurich'
	    }, {
	        airCd: 'AMS', htlCd: 'JC0068095', ctNmEn: 'Amsterdam', rntCd: 'AMSTERDAM', naNm: '네덜란드', naCd: 'NL', stCd: '', ctNm: '암스테르담', ctNmEn: 'Amsterdam'
	    }, {
	        airCd: 'SVO', htlCd: 'JC0075234', ctNmEn: 'Moscow', rntCd: 'MOSCOW', naNm: '러시아', naCd: 'RU', stCd: '', ctNm: '모스크바', ctNmEn: 'Moscow'
	    }, {
	        airCd: 'BCN', htlCd: 'JC0025516', ctNmEn: 'Barcelona', rntCd: 'BARCELONA', naNm: '스페인', naCd: 'ES', stCd: '', ctNm: '바르셀로나', ctNmEn: 'Barcelona'
	    }, {
	        airCd: 'BER', htlCd: 'JC0018586', ctNmEn: 'Berlin', rntCd: 'BERLIN', naNm: '독일', naCd: 'DE', stCd: '', ctNm: '베를린', ctNmEn: 'Berlin'
	    }]
	}, {
	    naNm: '대양주', cityList: [{
	        airCd: 'SYD', htlCd: 'JC0005878', ctNmEn: 'Sydney', rntCd: 'SYD', naNm: '호주', naCd: 'AU', stCd: 'NS', ctNm: '시드니', ctNmEn: 'Sydney'
	    }, {
	        airCd: 'AKL', htlCd: 'JC0069812', ctNmEn: 'Auckland', rntCd: 'AUCKLAND', naNm: '뉴질랜드', naCd: 'NZ', stCd: '', ctNm: '오클랜드', ctNmEn: 'Auckland'
	    }, {
	        airCd: 'BNE', htlCd: 'JC0003061', ctNmEn: 'Brisbane', rntCd: 'BNE', naNm: '호주', naCd: 'AU', stCd: 'QL', ctNm: '브리즈번', ctNmEn: 'Brisbane'
	    }, {
	        airCd: 'MEL', htlCd: 'JC0004735', ctNmEn: 'Melbourne', rntCd: 'MEL', naNm: '호주', naCd: 'AU', stCd: 'VI', ctNm: '멜버른', ctNmEn: 'Melbourne'
	    }, {
	        airCd: 'SPN', htlCd: 'JC0065562', ctNmEn: 'Saipan', rntCd: 'SPN', naNm: '사이판', naCd: 'MP', stCd: '', ctNm: '사이판', ctNmEn: 'Saipan'
	    }, {
	        airCd: 'GUM', htlCd: 'JC0049390', ctNmEn: 'Guam', rntCd: 'GUM', naNm: '괌', naCd: 'GU', stCd: 'GU', ctNm: '괌', ctNmEn: 'Guam'
	    }, {
	        airCd: 'ROR', htlCd: 'JC0073938', ctNmEn: 'Koror', rntCd: 'ROR', naNm: '팔라우', naCd: 'PW', stCd: '', ctNm: '팔라우', ctNmEn: 'Koror'
	    }, {
	        airCd: 'CHC', htlCd: 'JC0069872', ctNmEn: 'Christchurch', rntCd: 'CHC', naNm: '뉴질랜드', naCd: 'NZ', stCd: '', ctNm: '크라이스트처치', ctNmEn: 'Christchurch'
	    }]
	}, {
	    naNm: '중남미', cityList: [{
	        airCd: 'MEX', htlCd: 'JC0066578', ctNmEn: 'Mexico City', rntCd: 'MEXICO CITY', naNm: '멕시코', naCd: 'MX', stCd: '', ctNm: '멕시코시티', ctNmEn: 'Mexico City'
	    }, {
	        airCd: 'SAO', htlCd: 'JC0009808', ctNmEn: 'Sao Paulo', rntCd: 'SAO PAULO', naNm: '브라질', naCd: 'BR', stCd: 'SP', ctNm: '상파울루', ctNmEn: 'Sao Paulo'
	    }, {
	        airCd: 'LIM', htlCd: 'JC0070889', ctNmEn: 'Lima', rntCd: 'LIM', naNm: '페루', naCd: 'PE', stCd: '', ctNm: '리마', ctNmEn: 'Lima'
	    }, {
	        airCd: 'CUN', htlCd: 'JC0066128', ctNmEn: 'Cancun', rntCd: 'CUN', naNm: '멕시코', naCd: 'MX', stCd: '', ctNm: '칸쿤', ctNmEn: 'Cancun'
	    }]
	}, {
	    naNm: '중동', cityList: [{
	        airCd: 'DXB', htlCd: 'JC0000074', ctNmEn: 'Dubai', rntCd: 'DXB', naNm: '아랍에미리트', naCd: 'AE', stCd: '', ctNm: '두바이', ctNmEn: 'Dubai'
	    }, {
	        airCd: 'CAI', htlCd: 'JC0024631', ctNmEn: 'Cairo', rntCd: 'Cairo', naNm: '이집트', naCd: 'EG', stCd: '', ctNm: '카이로', ctNmEn: 'Cairo'		
	    }, {
	        airCd: 'THR', htlCd: 'JC0054551', ctNmEn: 'Teheran', rntCd: 'THR', naNm: '이란', naCd: 'IR', stCd: '', ctNm: '테헤란', ctNmEn: 'Teheran'		
	    }, {
	        airCd: 'DOH', htlCd: 'JC0074006', ctNmEn: 'Doha', rntCd: 'DOH', naNm: '카타르', naCd: 'QA', stCd: '', ctNm: '도하', ctNmEn: 'Doha'
	    }]
	}, {
	    naNm: '아프리카', cityList: [{
	        airCd: 'JNB', htlCd: 'JC0097774', ctNmEn: 'Johannesburg', rntCd: 'JNB', naNm: '남아프리카', naCd: 'ZA', stCd: '', ctNm: '요하네스버그', ctNmEn: 'Johannesburg'
	    }, {
	        airCd: 'CPT', htlCd: 'JC0097604', ctNmEn: 'Cape Town', rntCd: 'CPT', naNm: '남아프리카', naCd: 'ZA', stCd: '', ctNm: '케이프타운', ctNmEn: 'Cape Town'
	    }, {
	        airCd: 'NBO', htlCd: 'JC0063726', ctNmEn: 'Nairobi', rntCd: 'Nairobi', naNm: '케냐', naCd: 'KE', stCd: '', ctNm: '나이로비', ctNmEn: 'Nairobi'	
	    }, {
	        airCd: 'MLA', htlCd: 'JC0065631', ctNmEn: 'Molta', rntCd: 'MLA', naNm: '몰타', naCd: 'MT', stCd: '', ctNm: '몰타', ctNmEn: 'Valletta'
	    }]
	}];
	
	// 초기화
	var fn_init = function() {
		var html = "";
		html = html + "<div class='layerPopup'>";
		html = html + "	<div class='layerPop bgwhite'>";
		html = html + "		<div class='popCon'>";
		html = html + "			<div class='popHead'>";
		html = html + "				<div class='popTpart'>";
		html = html + "					<strong class='popTitle'>" + setTitle + "</strong>";
		html = html + "					<button type='button' class='layerClose' onclick='closePopup();'>";
		html = html
				+ "						<img src='/resources/images/btn/btn_exit.png' alt='레이어 닫기'>";
		html = html + "					</button>";
		html = html + "				</div>";
		html = html + "			</div>";
		html = html + "			<div class='cntain'>";
		// <!-- 검색 폼 --> //	
		html = html + "				<div class='fs_search'>";
		html = html + "					<div class='csbox'>";
		html = html + "							<fieldset>";
		html = html + "								<legend>검색폼</legend>";
		html = html
				+ "								<input type='text' data-role='none' placeholder='도시, 호텔, 인근도시, 공항 등' id='cityPopInput' title='검색어를 입력하세요.' onkeyup='fn_search_input()'/>";
		html = html
				+ "								<button type='button' data-role='none' onclick='fn_search_input()'>검색</button>";
		html = html + "							</fieldset>";
		html = html + "					</div>";
		// <!-- 검색 결과 --> //
		html = html + "					<div class='search_nowkey' ft-att='resultSearch' id='resultSearch' name='resultSearch'>";
		html = html + "					</div>";
		html = html + "				</div>";
		// <!-- 동일 적용 --> //
		/*
		if(location.pathname == "/free/main.do"){
			if(htlCheckbox || rntCheckbox){
				html = html + "				<div class='selectchk chkv_show'>";
				if(htlCheckbox){
					html = html + "					<p class='chkbox ah_show'>";
					html = html + "						<span><input id='chk_cusm1' type='checkbox' data-role='none' onclick='fn_selChkEqual();'/></span>";
					html = html + "						<label for='chk_cusm1'>선택 지역 호텔 동일 적용</label>";
					html = html + "					</p>";
				}
				if(rntCheckbox){
					html = html + "					<p class='chkbox hc_show'>";
					html = html + "						<span><input id='chk_cusm2' type='checkbox' data-role='none' onclick='fn_selChkEqual();'/></span>";
					html = html + "						<label for='chk_cusm2'>선택 지역 렌터카 동일 적용</label>";
					html = html + "					</p>";
				}
				html = html + "				</div>";
			}
		}
		*/
		// <!-- 기본 도시  --> //
		html = html + "				<table class='pop_table2 mt10'>";
		html = html + "					<colgroup>";
		html = html + "						<col style='width: 12%' />";
		html = html + "						<col span='4' style='width: 22%' />";
		html = html + "					</colgroup>";
		html = html + "					<tbody ft-att='city_list_div'>";

		// var city_div = html.find('tbody[ft-att="city_list_div"]');	

		for (var c_idx = 0; c_idx < baseCityList.length; c_idx++) {
			var cityGroup = baseCityList[c_idx];
			var row_cnt = parseInt(cityGroup.cityList.length / 3);
			if (cityGroup.cityList.length % 3 > 0) {
				row_cnt++;
			}
			html = html + "					<tr>";
			html = html + "						<th scope='row' rowspan='" + row_cnt + "'>"
					+ cityGroup.naNm + "</th>";

			if (_type == 'hotel') {
				//호텔 도시 검색
				for (var l_idx = 0; l_idx < cityGroup.cityList.length; l_idx++) {
					var city_list = cityGroup.cityList[l_idx];
					var funcNm = "selectCityList('" + city_list.airCd + "','" + city_list.ctNm + "','"+ city_list.naCd +"','"+ city_list.htlCd +"','"+ city_list.ctNmEn +"','"+ city_list.rntCd +"')";
					html = html + '				<td city-data="'+ city_list.airCd + '" country-data="' + city_list.naCd + '" onClick="' + funcNm + '">' + city_list.ctNm + '</td>';

					if (cityGroup.cityList.length == (l_idx + 1)) {
						var vNo = cityGroup.cityList.length % 3;
						if (vNo > 0) {
							for (var v_idx = vNo; v_idx < 3; v_idx++) {
								html = html + "	<td></td>";
							}
						}
					}
					if ((l_idx + 1) > 2 && ((l_idx + 1) % 3 == 0)) {
						html = html + "</tr><tr>";
					}
				}
			} else {
				//항공 도시 검색
				for (var l_idx = 0; l_idx < cityGroup.cityList.length; l_idx++) {
					var city_list = cityGroup.cityList[l_idx];
					var funcNm = "selectCityList('" + city_list.airCd + "','" + city_list.ctNm + "','" + city_list.naCd + "','"+ city_list.htlCd +"','" + city_list.ctNmEn +"','" +  city_list.rntCd +"')";
					html = html + '				<td city-data="' + city_list.airCd + '" onClick="' + funcNm + '">' + city_list.ctNm + '</td>';

					if (cityGroup.cityList.length == (l_idx + 1)) {
						var vNo = cityGroup.cityList.length % 3;
						if (vNo > 0) {
							for (var v_idx = vNo; v_idx < 3; v_idx++) {
								html = html + "	<td></td>";
							}
						}

					}
					if ((l_idx + 1) > 2 && ((l_idx + 1) % 3 == 0)) {
						html = html + "</tr><tr>";
					}

				}
			}
			html = html + "</tr>";
		}

		html = html + "					</tbody>";
		html = html + "				</table>";
		// <!-- 기본 도시  --> //
		html = html + "			</div>";
		html = html + "		</div>";
		html = html + "		<div class='popFoot'>";
		html = html + "			<div class='layerBtns'>";
		html = html
				+ "				<button type='button' class='layerClose1'>확인</button>";
		html = html + "			</div>";
		html = html + "		</div>";
		html = html + "	</div>";
		html = html + "</div>";

		$("#popupDepartCityCd").html(html);

	};


	// 도시검색 팝업 선택 
	function selectCityList(cityCd, cityNm, nationCd, htlCd, ctNmEn, rntCd){
		var availTy = "${availTy}"; // 선택 항목  [RT : 왕복, OW : 편도, MT : 다구간, OO : 해외출발]
		var travelMtCnt = '${travelMtCnt}'; // 다구간 선택일 때만 [RT : 왕복, OW : 편도, MT : 다구간, OO : 해외출발] 몇번째 여정인지 
		var type = "${type}"; // 출발 : D, 도착 : A
		var availGroup = $('div[ft-att="' + availTy + 'Group"]');

		console.log(" >>>>>>>>>>>>>>>> availTy=" + availTy);
		console.log(" >>>>>>>>>>>>>>>> travelMtCnt=" + travelMtCnt);
		console.log(" >>>>>>>>>>>>>>>> type=" + type);
		
		if(availTy == 'MT') {
			if(type == 'A') { // 도착 : A 도착지 선택 
				if(parseInt(travelMtCnt) > 1) {
					
					var tag1 = '#srch_arr_ct'+parseInt(travelMtCnt);
					var tag2 = '#srch_arr_ct_dis'+parseInt(travelMtCnt);
					var tag3 = '#srch_arr_naCd'+parseInt(travelMtCnt);
					console.log(" >>>>>>>>>>>>>>>> tag1=" + tag1);
					console.log(" >>>>>>>>>>>>>>>> tag2=" + tag2);
					console.log(" >>>>>>>>>>>>>>>> tag3=" + tag3);


					availGroup.find(tag1).html(cityCd);
					availGroup.find(tag2).html(cityNm);
					availGroup.find(tag3).val(nationCd);

					var arr_tag1 = '#srch_dep_ct'+(parseInt(travelMtCnt)+1);
					var arr_tag2 = '#srch_dep_ct_dis'+(parseInt(travelMtCnt)+1);
					var arr_tag3 = '#srch_dep_naCd'+(parseInt(travelMtCnt)+1);

					console.log(" >>>>>>>>>>>>>>>> arr_tag1=" + arr_tag1);
					console.log(" >>>>>>>>>>>>>>>> arr_tag2=" + arr_tag2);
					console.log(" >>>>>>>>>>>>>>>> arr_tag3=" + arr_tag3);
					
					availGroup.find(arr_tag1).html(cityCd);
					availGroup.find(arr_tag2).html(cityNm);
					availGroup.find(arr_tag3).val(nationCd);


				} else { 
					availGroup.find('#srch_arr_ct').html(cityCd);
					availGroup.find('#srch_arr_ct_dis').html(cityNm);
					availGroup.find('#srch_arr_naCd').val(nationCd);

					var arr_tag1 = '#srch_dep_ct'+(parseInt(travelMtCnt)+1);
					var arr_tag2 = '#srch_dep_ct_dis'+(parseInt(travelMtCnt)+1);
					var arr_tag3 = '#srch_dep_naCd'+(parseInt(travelMtCnt)+1);

					console.log(" >>>>>>>>>>>>>>>> arr_tag1=" + arr_tag1);
					console.log(" >>>>>>>>>>>>>>>> arr_tag2=" + arr_tag2);
					console.log(" >>>>>>>>>>>>>>>> arr_tag3=" + arr_tag3);
					
					availGroup.find(arr_tag1).html(cityCd);
					availGroup.find(arr_tag2).html(cityNm);
					availGroup.find(arr_tag3).val(nationCd);
				
				}
			} else { // 출발 : D 출발지 선택 
				if(parseInt(travelMtCnt) > 0) {
					var tag1 = '#srch_dep_ct'+travelMtCnt;
					var tag2 = '#srch_dep_ct_dis'+travelMtCnt;
					var tag3 = '#srch_dep_naCd'+travelMtCnt;
					availGroup.find(tag1).html(cityCd);				
					availGroup.find(tag2).html(cityNm);
					availGroup.find(tag3).val(nationCd);
				} else { 
					availGroup.find('#srch_dep_ct').html(cityCd);
					availGroup.find('#srch_dep_ct_dis').html(cityNm);
					availGroup.find('#srch_dep_naCd').val(nationCd);
				}
			}
			availGroup.find('#searchCityNmEn').val(ctNmEn);
		}else if(availTy == 'OO'){
			if(type == 'A'){
				availGroup.find('#srch_arr_ct').html(cityCd);
				availGroup.find('#srch_arr_ct_dis').html(cityNm);
				availGroup.find('#srch_arr_naCd').val(nationCd);
			}else{
				availGroup.find('#srch_dep_ct').html(cityCd);
				availGroup.find('#srch_dep_ct_dis').html(cityNm);
				availGroup.find('#srch_dep_naCd').val(nationCd);	
			}
		}else{
			availGroup.find('#srch_arr_ct').html(cityCd);
			availGroup.find('#srch_arr_ct_dis').html(cityNm);
			availGroup.find('#searchCityNmEn').val(ctNmEn);
			availGroup.find('#srch_arr_naCd').val(nationCd);
			availGroup.find('#srch_arr_htlCt').val(htlCd);
			availGroup.find('#srch_arr_rntCt').val(rntCd);
		}
		
		/*
		if(location.pathname == "/free/main.do"){
			if($("#chk_cusm1").is(":checked")){
				$("div[ft-att='HTGroup']").find("#srch_arr_ct_dis").val(cityNm);
				$("div[ft-att='HTGroup']").find("#searchCity").val(htlCd);
				$("div[ft-att='HTGroup']").find("#searchCityNm").val(cityNm);
				$("div[ft-att='HTGroup']").find("#searchCountry").val(nationCd);
				
				if(nullToBlank(availGroup.find("#dep_dt").text()) != "" && availGroup.find("#dep_dt").text() != "미지정"){
					var selDepDt = availGroup.find("#dep_dt").text();
					
					$("div[ft-att='HTGroup']").find("#dep_dt").text(selDepDt);
					$("div[ft-att='HTGroup']").find("#dep_dt").removeClass("noSelect");
				}
				
				if(nullToBlank(availGroup.find("#arr_dt").text()) != "" && availGroup.find("#arr_dt").text() != "미지정"){
					var selArrDt = availGroup.find("#arr_dt").text();
					
					var equalDepDtArr = availGroup.find('#dep_dt').text().split(".");
					var equalArrDtArr = availGroup.find('#arr_dt').text().split(".");
					
					var equalDepDate = new Date(equalDepDtArr[0], parseInt(equalDepDtArr[1]) - 1, equalDepDtArr[2]);
					var equalArrDate = new Date(equalArrDtArr[0], parseInt(equalArrDtArr[1]) - 1, equalArrDtArr[2]);
					
					var timeDiff = Math.abs(equalArrDate.getTime() - equalDepDate.getTime());
					var dayDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));
					
					$("div[ft-att='HTGroup']").find("#arr_dt").text(selDepDt);
					$("div[ft-att='HTGroup']").find("#arr_dt").removeClass("noSelect");
					$("div[ft-att='HTGroup']").find('#srch_night_days').text(dayDiff + '박');
				}
				
				htlSameChk = true;
			}else{
				htlSameChk = false;
			}
			
			if($("#chk_cusm2").is(":checked")){
				$("div[ft-att='RCGroup']").find("#dep_place").val(cityNm);
				$("div[ft-att='RCGroup']").find("#take_place_cd").val(rntCd);
				$("div[ft-att='RCGroup']").find("#take_place_oagCd").val(cityNm);
				$("div[ft-att='RCGroup']").find("#take_place_countryCd").val(nationCd);
				
				$("div[ft-att='RCGroup']").find("#arr_place").val(cityNm);
				$("div[ft-att='RCGroup']").find("#return_place_cd").val(rntCd);
				$("div[ft-att='RCGroup']").find("#return_place_oagCd").val(cityNm);
				$("div[ft-att='RCGroup']").find("#return_place_countryCd").val(nationCd);
				
				if(nullToBlank(availGroup.find("#dep_dt").text()) != "" && availGroup.find("#dep_dt").text() != "미지정"){
					var selDepDt = availGroup.find("#dep_dt").text();
					var selDepDtArr = selDepDt.split(".");
					
					$("div[ft-att='RCGroup']").find("#dep_dt").text(selDepDt);
					$("div[ft-att='RCGroup']").find("#dep_dt").removeClass("noSelect");
					$("div[ft-att='RCGroup']").find("#take_date").val(selDepDtArr[0] + "" + selDepDtArr[1] + "" + selDepDtArr[2]);
				}
				
				if(nullToBlank(availGroup.find("#arr_dt").text()) != "" && availGroup.find("#arr_dt").text() != "미지정"){
					var selArrDt = availGroup.find("#arr_dt").text();
					var selArrDtArr = selArrDt.split(".");
					
					$("div[ft-att='RCGroup']").find("#arr_dt").text(selDepDt);
					$("div[ft-att='RCGroup']").find("#arr_dt").removeClass("noSelect");
					$("div[ft-att='RCGroup']").find("#return_date").val(selArrDtArr[0] + "" + selArrDtArr[1] + "" + selArrDtArr[2]);
				}
				
				rntSameChk = true;
			}else{
				rntSameChk = false;
			}
		}
		*/
		
		closePopup();
	}

	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		
		jQuery(document).scrollTop(nowScrollY);
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}
	
	function fn_selChkEqual(){
		if($("#chk_cusm1").is(":checked") || $("#chk_cusm2").is(":checked")){
			$("#cityPopInput").attr("disabled", "disabled");
		}else{
			$("#cityPopInput").removeAttr("disabled");
		}
	}


	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();

		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});
</script>

<!-- 도시 선택 레이어 영역 -->
<div id="popupDepartCityCd"></div>