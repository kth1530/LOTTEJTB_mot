<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
	// 파일명 : pop_city_select2.jsp
	// 설명 : 주요도시 선택 (결과)

	String type = (String) request.getAttribute("type");
%>
<script type="text/javascript">
	var setTitle = '';
	var baseCityList = []; //도시리스트
	var _type="<%=type%>";
	var nowScrollY = window.scrollY;
	var rntCheckbox = $("#carcheck").is(":checked");

	setTitle = '주요도시 선택';
	
	domesticYn = sessionStorage.domesticYn;
	
	if(domesticYn == 'Y'){
		baseCityList = [{
		    naNm: '주요도시',
		    cityList: [
						{ 	 airCd: 'SEL', htlCd: 'JC0064159', ctNmEn: 'Seoul', ctNm: '서울', naNm: '대한민국', naCd: 'KR'
						}, { airCd: 'ICN', htlCd: 'JC0064042', ctNmEn: 'Incheon', ctNm: '인천', naNm: '대한민국', naCd: 'KR'
						}, { airCd: 'GMP', htlCd: 'JC0063970', ctNmEn: 'Gimpo', ctNm: '김포', naNm: '대한민국', naCd: 'KR'
						}, { airCd: 'PUS', htlCd: 'JC0063895', ctNmEn: 'Busan', ctNm: '부산', naNm: '대한민국', naCd: 'KR'
						}, { airCd: 'CJJ', htlCd: 'JC0063909', ctNmEn: 'Cheongju', ctNm: '청주', naNm: '대한민국', naCd: 'KR'
						}, { airCd: 'MWX', htlCd: 'JC0063998', ctNmEn: 'Muan', ctNm: '무안', naNm: '대한민국', naCd: 'KR'
						}, { airCd: 'KWJ', htlCd: 'JC0063998', ctNmEn: 'Gwangju', ctNm: '광주', naNm: '대한민국', naCd: 'KR'
						}, { airCd: 'SHO', htlCd: 'JC0064168', ctNmEn: 'Sokcho', ctNm: '속초', naNm: '대한민국', naCd: 'KR'
						}, { airCd: 'KUV', htlCd: 'JC0064081', ctNmEn: 'Kunsan', ctNm: '군산', naNm: '대한민국', naCd: 'KR'
						}, { airCd: 'WJU', htlCd: 'JC0064199', ctNmEn: 'Wonju', ctNm: '원주', naNm: '대한민국', naCd: 'KR'
						}, { airCd: 'KAG', htlCd: 'JC0063956', ctNmEn: 'Kangnung', ctNm: '강릉', naNm: '대한민국', naCd: 'KR'
						}, { airCd: 'CJU', htlCd: 'JC0064055', ctNmEn: 'Jeju', ctNm: '제주', naNm: '대한민국', naCd: 'KR'
						}, { airCd: 'TAE', htlCd: 'JC0063928', ctNmEn: 'Daegu', ctNm: '대구', naNm: '대한민국', naCd: 'KR'
						}, { airCd: 'RSU', htlCd: 'JC0064226', ctNmEn: 'Yeosu', ctNm: '여수', naNm: '대한민국', naCd: 'KR'
						}, { airCd: 'HIN', htlCd: 'JC0064073', ctNmEn: 'Jinju', ctNm: '진주', naNm: '대한민국', naCd: 'KR'
						}, { airCd: 'MPK', htlCd: 'JC0064089', ctNmEn: 'Mokpo', ctNm: '목포', naNm: '대한민국', naCd: 'KR'
						}, { airCd: 'USN', htlCd: 'JC0064195', ctNmEn: 'Ulsan', ctNm: '울산', naNm: '대한민국', naCd: 'KR'
						}, { airCd: 'KPO', htlCd: 'JC0064126', ctNmEn: 'Pohang', ctNm: '포항', naNm: '대한민국', naCd: 'KR'
						}
					]
			
		}];
		
	}else{
			
		baseCityList = [{
		    naNm: '일본', cityList: [{
				airCd: 'TYO', htlCd: 'JC0063434', ctNmEn: 'Tokyo', rntCd: 'NARITA', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '도쿄'
		    }, {
				airCd: 'OSA', htlCd: 'JC0063062', ctNmEn: 'Osaka', rntCd: 'OSAKA', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '오사카'
		    }, {
				airCd: 'FUK', htlCd: 'JC0062152', ctNmEn: 'Fukuoka', rntCd: 'FUKUOKA', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '후쿠오카'
		    }, {
				airCd: 'SPK', htlCd: 'JC0063160', ctNmEn: 'Sapporo', rntCd: 'CHITOSE', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '삿포로'
		    }, {
				airCd: 'UKY', htlCd: 'JC0062673', ctNmEn: 'Kyoto', rntCd: 'KYOTO', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '교토'
		    }, {
				airCd: 'OKA', htlCd: 'JC0063028', ctNmEn: 'Okinawa City', rntCd: 'OKINAWA', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '오키나와'
		    }, {
				airCd: 'AQ4', htlCd: 'JC0063626', ctNmEn: 'Yufu', rntCd: 'YUFU', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '유후인'
		    }, {
				airCd: 'HAKO', htlCd: 'JC0062200', ctNmEn: 'Hakone', rntCd: 'Hakone', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '하코네'
		    }, {
				airCd: '993', htlCd: 'JC0062965', ctNmEn: 'Noboribetsu', rntCd: 'Noboribetsu', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '노보리베츠'
		    }, {
				airCd: 'NGO', htlCd: 'JC0062864', ctNmEn: 'Nagoya', rntCd: 'Nagoya', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '나고야'
		    }, {
				airCd: 'OKJ', htlCd: 'JC0063023', ctNmEn: 'Okayama', rntCd: 'OKAYAMA', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '오카야마'
		    }]
		}, {
		    naNm: '중국', cityList: [{
		        airCd: 'HKG', htlCd: 'JC0049435', ctNmEn: 'Hong Kong', rntCd: 'HONG KONG', naNm: '홍콩', naCd: 'HK', stCd: '', ctNm: '홍콩'
		    }, {
		        airCd: 'MFM', htlCd: 'JC0065554', ctNmEn: 'Macau', rntCd: 'Macau', naNm: '마카오', naCd: 'MO', stCd: '', ctNm: '마카오'		// 렌터카 검색 안됨
		    }, {
				airCd: 'BJS', htlCd: 'JC0015266', ctNmEn: 'Beijing', rntCd: 'Beijing', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '북경'
		    }, {
		        airCd: 'SHA', htlCd: 'JC0015880', ctNmEn: 'Shanghai', rntCd: 'SHA', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '상해'
		    }, {
		        airCd: 'TAO', htlCd: 'JC0015822', ctNmEn: 'Qingdao', rntCd: 'QINGDAO', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '청도'
		    }, {
		        airCd: 'YNT', htlCd: 'JC0016124', ctNmEn: 'Yantai', rntCd: 'Yantai', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '연태'		// 렌터카 검색 안됨
		    }, {
		        airCd: 'DLC', htlCd: 'JC0015350', ctNmEn: 'Dalian', rntCd: 'DALIAN', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '대련'
		    }, {
		        airCd: 'HGH', htlCd: 'JC0015486', ctNmEn: 'Hangzhou', rntCd: 'HANGZHOU', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '항주'
			}, {
		        airCd: 'CAN', htlCd: 'JC0015446', ctNmEn: 'Guangzhou', rntCd: 'GUANGZHOU', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '광주'
		    }, {
		        airCd: 'SZX', htlCd: 'JC0015914', ctNmEn: 'Shenzhen', rntCd: 'Shenzhen', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '심천'
		    }, {
		        airCd: 'WEH', htlCd: 'JC0016017', ctNmEn: 'Weihai', rntCd: 'Weihai', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '위해'
		    }, {
		        airCd: 'SYX', htlCd: 'JC0015476', ctNmEn: 'Sanya', rntCd: 'Sanya', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '하이난'
		    }, {
		        airCd: 'ULN', htlCd: 'JC0065548', ctNmEn: 'Ulaanbaatar', rntCd: 'Ulaanbaatar', naNm: '몽고', naCd: 'MN', stCd: '', ctNm: '울란바토르'
		    }]
		}, {	
		    naNm: '동남아', cityList: [{
		        airCd: 'SIN', htlCd: 'JC0077394', ctNmEn: 'Singapore', rntCd: 'SINGAPORE', naNm: '싱가포르', naCd: 'SG', stCd: '', ctNm: '싱가포르'
		    }, {
		        airCd: 'BKK', htlCd: 'JC0078154', ctNmEn: 'Bangkok', rntCd: 'BANGKOK', naNm: '태국', naCd: 'TH', stCd: '', ctNm: '방콕'
		    }, {
		        airCd: 'MNL', htlCd: 'JC0071598', ctNmEn: 'Manila', rntCd: 'MANILA', naNm: '필리핀', naCd: 'PH', stCd: '', ctNm: '마닐라'
		    }, {
		        airCd: 'TPE', htlCd: 'JC0080233', ctNmEn: 'Taipei', rntCd: 'Taipei', naNm: 'TW', naCd: '대만', stCd: '', ctNm: '타이베이'		// 렌터카 검색 안됨
		    }, {
		        airCd: 'KUL', htlCd: 'JC0067272', ctNmEn: 'Kuala Lumpur', rntCd: 'Kuala Lumpur', naNm: '말레이시아', naCd: 'MY', stCd: '', ctNm: '쿠알라룸푸르'
		    }, {
		        airCd: 'JKT', htlCd: 'JC0051020', ctNmEn: 'Jakarta', rntCd: 'Jakarta', naNm: '인도네시아', naCd: 'ID', stCd: '', ctNm: '자카르타'	//렌터카 검색안됨
		    }, {
		        airCd: 'SGN', htlCd: 'JC0097234', ctNmEn: 'Ho Chi Minh City', rntCd: 'SGN', naNm: '베트남', naCd: 'VN', stCd: '', ctNm: '호치민'		// 렌터카 검색 안됨 - 베트남 자체가 없음
		    }, {
		        airCd: 'HAN', htlCd: 'JC0097231', ctNmEn: 'Hanoi', rntCd: 'Hanoi', naNm: '베트남', naCd: 'VN', stCd: '', ctNm: '하노이'		// 렌터카 검색 안됨 - 베트남 자체가 없음
		    }, {
		        airCd: 'REP', htlCd: 'JC0063818', ctNmEn: 'Siem Reap', rntCd: 'Siem Reap', naNm: '캄보디아', naCd: 'KH', stCd: '', ctNm: '씨엠립'	//렌터카 검색안됨
		    }, {
		        airCd: 'BOM', htlCd: 'JC0053753', ctNmEn: 'Mumbai', rntCd: 'Mumbai', naNm: '인도', naCd: 'IN', stCd: '', ctNm: '뭄바이'	//렌터카 검색안됨
		    }, {
		        airCd: 'HKT', htlCd: 'JC0078716', ctNmEn: 'Phuket', rntCd: 'PHUKET', naNm: '태국', naCd: 'TH', stCd: '', ctNm: '푸켓'
		    }, {
		        airCd: 'PYX', htlCd: 'JC0078662', ctNmEn: 'Pattaya', rntCd: 'Pattaya', naNm: '태국', naCd: 'TH', stCd: '', ctNm: '파타야'
		    }, {
		        airCd: 'USM', htlCd: 'JC0078446', ctNmEn: 'Koh Samui', rntCd: 'Koh Samui', naNm: '태국', naCd: 'TH', stCd: '', ctNm: '코사무이'
		    }, {
		        airCd: 'HHQ', htlCd: 'JC0078268', ctNmEn: 'Hua Hin', rntCd: 'Hua Hin', naNm: '태국', naCd: 'TH', stCd: '', ctNm: '후아힌'
		    }, {
		        airCd: 'CNX', htlCd: 'JC0078210', ctNmEn: 'Chiang Mai', rntCd: 'Chiang Mai', naNm: '태국', naCd: 'TH', stCd: '', ctNm: '치앙마이'
		    }, {
		        airCd: 'KBV', htlCd: 'JC0078454', ctNmEn: 'Krabi', rntCd: 'Krabi', naNm: '태국', naCd: 'TH', stCd: '', ctNm: '크라비'
		    }, {
		        airCd: 'DPS', htlCd: 'JC0050833', ctNmEn: 'Bali', rntCd: 'Bali', naNm: '인도네시아', naCd: 'ID', stCd: '', ctNm: '발리'
		    }, {
		        airCd: 'BIF', htlCd: 'JC0050891', ctNmEn: 'Bintan', rntCd: 'Bintan', naNm: '인도네시아', naCd: 'ID', stCd: '', ctNm: '빈탄'
		    }, {
		        airCd: 'CEB', htlCd: 'JC0071461', ctNmEn: 'Cebu', rntCd: 'CEBU', naNm: '필리핀', naCd: 'PH', stCd: '', ctNm: '세부'
		    }, {
		        airCd: 'KLO', htlCd: 'JC0071416', ctNmEn: 'Boracay Island', rntCd: 'Boracay Island', naNm: '필리핀', naCd: 'PH', stCd: '', ctNm: '보라카이'
		    }, {
		        airCd: 'BKI', htlCd: 'JC0067260', ctNmEn: 'Kota Kinabalu', rntCd: 'Kota Kinabalu', naNm: '말레이시아', naCd: 'MY', stCd: '', ctNm: '코타키나발루'
		    }, {
		        airCd: 'MLE', htlCd: 'JC0065901', ctNmEn: 'Maldives', rntCd: 'Maldives', naNm: '몰디브', naCd: 'MV', stCd: '', ctNm: '몰디브'
		    }, {
		        airCd: 'DAD', htlCd: 'JC0097188', ctNmEn: 'Da Nang', rntCd: 'Da Nang', naNm: '베트남', naCd: 'VN', stCd: '', ctNm: '다낭'
		    }]
		}, {
		    naNm: '중동', cityList: [{
		        airCd: 'DXB', htlCd: 'JC0000074', ctNmEn: 'Dubai', rntCd: 'DXB', naNm: '아랍에미리트', naCd: 'AE', stCd: '', ctNm: '두바이'
		    }, {
		        airCd: 'CAI', htlCd: 'JC0024631', ctNmEn: 'Cairo', rntCd: 'Cairo', naNm: '이집트', naCd: 'EG', stCd: '', ctNm: '카이로'		//렌터카 검색안됨
		    }, {
		        airCd: 'DOH', htlCd: 'JC0074006', ctNmEn: 'Doha', rntCd: 'DOH', naNm: '카타르', naCd: 'QA', stCd: '', ctNm: '도하'
		    }]
		}, {
		    naNm: '미국', cityList: [{
		        airCd: 'NYC', htlCd: 'JC0090685', ctNmEn: 'New York', rntCd: 'NEW YORK', naNm: '미국', naCd: 'US', stCd: 'NY', ctNm: '뉴욕'
		    }, {
		        airCd: 'LAX', htlCd: 'JC0088982', ctNmEn: 'Los Angeles', rntCd: 'LOS ANGELES', naNm: '미국', naCd: 'US', stCd: 'CA', ctNm: 'LA'
		    }, {
		        airCd: 'LAS', htlCd: 'JC0088488', ctNmEn: 'Las Vegas', rntCd: 'Las Vegas', naNm: '미국', naCd: 'US', stCd: 'NV', ctNm: '라스베가스'
		    }, {
		        airCd: 'SFO', htlCd: 'JC0093274', ctNmEn: 'San Francisco', rntCd: 'SAN FRANCISCO', naNm: '미국', naCd: 'US', stCd: 'CA', ctNm: '샌프란시스코'
		    }, {
		        airCd: 'WAS', htlCd: 'JC0095775', ctNmEn: 'Washington', rntCd: 'WAS', naNm: '미국', naCd: 'US', stCd: 'DC', ctNm: '워싱턴'
		    }, {
		        airCd: 'CHI', htlCd: 'JC0083200', ctNmEn: 'Chicago', rntCd: 'CHICAGO', naNm: '미국', naCd: 'US', stCd: 'IL', ctNm: '시카고'
		    }, {
		        airCd: 'BOS', htlCd: 'JC0082032', ctNmEn: 'Boston', rntCd: 'BOSTON', naNm: '미국', naCd: 'US', stCd: 'MA', ctNm: '보스톤'
		    }, {
		        airCd: 'ORL', htlCd: 'JC0091408', ctNmEn: 'Orlando', rntCd: 'Orlando', naNm: '미국', naCd: 'US', stCd: 'FL', ctNm: '올랜도'
		    }, {
		        airCd: 'MIA', htlCd: 'JC0089767', ctNmEn: 'Miami', rntCd: 'Miami', naNm: '미국', naCd: 'US', stCd: 'FL', ctNm: '마이애미'
		    }, {
		        airCd: 'HNL', htlCd: 'JC0087189', ctNmEn: 'Honolulu', rntCd: 'HONOLULU', naNm: '미국', naCd: 'US', stCd: 'HI', ctNm: '호놀룰루'
		    }, {
		        airCd: 'OGG', htlCd: 'JC0086757', ctNmEn: 'Maui', rntCd: 'Maui', naNm: '미국', naCd: 'US', stCd: 'HI', ctNm: '마우이'
		    }, {
		        airCd: 'YVR', htlCd: 'JC0013226', ctNmEn: 'Vancouver', rntCd: 'Vancouver', naNm: '캐나다', naCd: 'CA', stCd: 'BC', ctNm: '밴쿠버'
		    }, {
		        airCd: 'YTO', htlCd: 'JC0013156', ctNmEn: 'Toronto', rntCd: 'Toronto', naNm: '캐나다', naCd: 'CA', stCd: 'ON', ctNm: '토론토'
		    }]
		}, {
		    naNm: '유럽', cityList: [{
		        airCd: 'LON', htlCd: 'JC0045360', ctNmEn: 'London', rntCd: 'LONDON', naNm: '영국', naCd: 'GB', stCd: '', ctNm: '런던'
		    }, {
		        airCd: 'PAR', htlCd: 'JC0039217', ctNmEn: 'Paris', rntCd: 'PARIS', naNm: '프랑스', naCd: 'FR', stCd: '', ctNm: '파리'
		    }, {
		        airCd: 'ROM', htlCd: 'JC0059909', ctNmEn: 'Rome', rntCd: 'ROME', naNm: '이탈리아', naCd: 'IT', stCd: '', ctNm: '로마'
		    }, {
		        airCd: 'MIL', htlCd: 'JC0058255', ctNmEn: 'Milan', rntCd: 'Milan', naNm: '이탈리아', naCd: 'IT', stCd: '', ctNm: '밀라노'
		    }, {
		        airCd: 'VCE', htlCd: 'JC0061530', ctNmEn: 'Venice', rntCd: 'VENICE', naNm: '이탈리아', naCd: 'IT', stCd: '', ctNm: '베니스'
		    }, {
		        airCd: 'AMS', htlCd: 'JC0068095', ctNmEn: 'Amsterdam', rntCd: 'Amsterdam', naNm: '네델란드', naCd: 'NL', stCd: '', ctNm: '암스테르담'
		    }, {
		        airCd: 'ZRH', htlCd: 'JC0014839', ctNmEn: 'Zurich', rntCd: 'ZURICH', naNm: '스위스', naCd: 'CH', stCd: '', ctNm: '취리히'
		    }, {
		        airCd: 'FRA', htlCd: 'JC0019450', ctNmEn: 'Frankfurt', rntCd: 'FRANKFURT', naNm: '독일', naCd: 'DE', stCd: '', ctNm: '프랑크푸르트'
		    }, {
		        airCd: 'MUC', htlCd: 'JC0021236', ctNmEn: 'Munich', rntCd: 'MUNICH', naNm: '독일', naCd: 'DE', stCd: '', ctNm: '뮌헨'
		    }, {
		        airCd: 'VIE', htlCd: 'JC0002463', ctNmEn: 'Vienna', rntCd: 'VIENNA', naNm: '오스트리아', naCd: 'AT', stCd: '', ctNm: '비엔나'
		    }, {
		        airCd: 'BCN', htlCd: 'JC0025516', ctNmEn: 'Barcelona', rntCd: 'BARCELONA', naNm: '스페인', naCd: 'ES', stCd: '', ctNm: '바르셀로나'
		    }, {
		        airCd: 'PRG', htlCd: 'JC0017874', ctNmEn: 'Prague', rntCd: 'PRAGUE', naNm: '체코', naCd: 'CZ', stCd: '', ctNm: '프라하'
		    }, {
		        airCd: 'IST', htlCd: 'JC0079503', ctNmEn: 'Istanbul', rntCd: 'ISTANBUL', naNm: '터키', naCd: 'TR', stCd: '', ctNm: '이스탄불'
		    }, {
		        airCd: 'MAD', htlCd: 'JC0028725', ctNmEn: 'Madrid', rntCd: 'MADRID', naNm: '스페인', naCd: 'ES', stCd: '', ctNm: '마드리드'
		    }, {
		        airCd: 'SVO', htlCd: 'JC0075234', ctNmEn: 'Moscow', rntCd: 'MOSCOW', naNm: '러시아', naCd: 'RU', stCd: '', ctNm: '모스크바'
		    }, {
		        airCd: 'BER', htlCd: 'JC0018586', ctNmEn: 'Berlin', rntCd: 'BERLIN', naNm: '독일', naCd: 'DE', stCd: '', ctNm: '베를린'
		    }]
		}, {
		    naNm: '대양주', cityList: [{
		        airCd: 'SYD', htlCd: 'JC0005878', ctNmEn: 'Sydney', rntCd: 'SYD', naNm: '호주', naCd: 'AU', stCd: 'NS', ctNm: '시드니'
		    }, {
		        airCd: 'MEL', htlCd: 'JC0004735', ctNmEn: 'Melbourne', rntCd: 'MEL', naNm: '호주', naCd: 'AU', stCd: 'VI', ctNm: '멜버른'
		    }, {
		        airCd: 'BNE', htlCd: 'JC0003061', ctNmEn: 'Brisbane', rntCd: 'BNE', naNm: '호주', naCd: 'AU', stCd: 'QL', ctNm: '브리즈번'
		    }, {
		        airCd: 'OOL', htlCd: 'JC0003970', ctNmEn: 'Gold Coast', rntCd: 'GOLD COAST', naNm: '호주', naCd: 'AU', stCd: 'QL', ctNm: '골드코스트'
		    }, {
		        airCd: 'CNS', htlCd: 'JC0003171', ctNmEn: 'Cairns', rntCd: 'CAIRNS', naNm: '호주', naCd: 'AU', stCd: 'QL', ctNm: '케언즈'
		    }, {
		        airCd: 'AKL', htlCd: 'JC0069812', ctNmEn: 'Auckland', rntCd: 'AUCKLAND', naNm: '뉴질랜드', naCd: 'NZ', stCd: '', ctNm: '오클랜드'
		    }, {
		        airCd: 'GUM', htlCd: 'JC0049390', ctNmEn: 'Guam', rntCd: 'GUM', naNm: '괌', naCd: 'GU', stCd: 'GU', ctNm: '괌'
		    }, {
		        airCd: 'SPN', htlCd: 'JC0065562', ctNmEn: 'Saipan', rntCd: 'SPN', naNm: '사이판', naCd: 'MP', stCd: '', ctNm: '사이판'
		    }, {
		        airCd: 'NAN', htlCd: 'JC0032862', ctNmEn: 'Fiji', rntCd: 'Fiji', naNm: '피지', naCd: 'FJ', stCd: '', ctNm: '피지'
		    }, {
		        airCd: 'NOU', htlCd: 'JC0067712', ctNmEn: 'New Caledonia', rntCd: 'New Caledonia', naNm: '뉴칼레도니아', naCd: 'NC', stCd: '', ctNm: '뉴칼레도니아'
		    }, {
		        airCd: 'ROR', htlCd: 'JC0073938', ctNmEn: 'Koror', rntCd: 'ROR', naNm: '팔라우', naCd: 'PW', stCd: '', ctNm: '팔라우'
		    }, {
		        airCd: 'CHC', htlCd: 'JC0069872', ctNmEn: 'Christchurch', rntCd: 'CHC', naNm: '뉴질랜드', naCd: 'NZ', stCd: '', ctNm: '크라이스트처치'
		    }]
		}, {
		    naNm: '중남미', cityList: [{
		        airCd: 'MEX', htlCd: 'JC0066578', ctNmEn: 'Mexico City', rntCd: 'MEXICO CITY', naNm: '멕시코', naCd: 'MX', stCd: '', ctNm: '멕시코시티'
		    }, {
		        airCd: 'SAO', htlCd: 'JC0009808', ctNmEn: 'Sao Paulo', rntCd: 'SAO PAULO', naNm: '브라질', naCd: 'BR', stCd: 'SP', ctNm: '상파울로'
		    }, {
		        airCd: 'LIM', htlCd: 'JC0070889', ctNmEn: 'Lima', rntCd: 'LIM', naNm: '페루', naCd: 'PE', stCd: '', ctNm: '리마'
		    }, {
		        airCd: 'CUN', htlCd: 'JC0066128', ctNmEn: 'Cancun', rntCd: 'CUN', naNm: '멕시코', naCd: 'MX', stCd: '', ctNm: '칸쿤'
		    }]
		}, {
		    naNm: '아프리카', cityList: [{
		        airCd: 'JNB', htlCd: 'JC0097774', ctNmEn: 'Johannesburg', rntCd: 'JNB', naNm: '남아프리카', naCd: 'ZA', stCd: '', ctNm: '요하네스버그'
		    }, {
		        airCd: 'CPT', htlCd: 'JC0097604', ctNmEn: 'Cape Town', rntCd: 'CPT', naNm: '남아프리카', naCd: 'ZA', stCd: '', ctNm: '케이프타운'
		    }, {
		        airCd: 'NBO', htlCd: 'JC0063726', ctNmEn: 'Nairobi', rntCd: 'Nairobi', naNm: '케냐', naCd: 'KE', stCd: '', ctNm: '나이로비'	
		    }, {
		        airCd: 'MLA', htlCd: 'JC0065687', ctNmEn: 'Valletta', rntCd: 'Valletta', naNm: '발레타', naCd: 'MT', stCd: '', ctNm: '발레타'	
		    }, {
		        airCd: 'MRU', htlCd: 'JC0065746', ctNmEn: 'Mauritius', rntCd: 'Mauritius', naNm: '모리셔스', naCd: 'MU', stCd: '', ctNm: '포트루이스'	
		    }, {
		        airCd: 'DUR', htlCd: 'JC0097656', ctNmEn: 'Durban', rntCd: 'Durban', naNm: '남아프리카', naCd: 'ZA', stCd: '', ctNm: '더반'	
		    }, {
		        airCd: 'ACC', htlCd: 'JC0047420', ctNmEn: 'Accra', rntCd: 'ACCRA', naNm: '가나', naCd: 'GH', stCd: '', ctNm: '아크라'	
		    }, {
		        airCd: 'MLA', htlCd: 'JC0065631', ctNmEn: 'Molta', rntCd: 'MLA', naNm: '몰타', naCd: 'MT', stCd: '', ctNm: '몰타'
		    }]
		}];
	}

	// 초기화
	var fn_init = function() {

		console.log("pop_hotel_city_select---fn_init~~~~~~~~~~~~~~~~");
		
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
		html = html + "					<div class='csbox'  id = 'citySrch' style='display:none'>";
		html = html + "							<fieldset>";
		html = html + "								<legend>검색폼</legend>";
		html = html
				+ "								<input type='text' data-role='none' placeholder='도시, 호텔, 인근도시, 공항 등' id='cityPopInput' title='검색어를 입력하세요.' onkeyup='fn_htl_search(\""+ domesticYn +"\")'/>";
		html = html
				+ "								<button type='button' data-role='none' onclick='fn_htl_search(\""+ domesticYn +"\")'>검색</button>";
		html = html + "							</fieldset>";
		html = html + "					</div>";
		// <!-- 검색 결과 --> //
		html = html + "					<div class='search_nowkey' ft-att='resultSearch' id='resultSearch' name='resultSearch'>";
		html = html + "					</div>";
		html = html + "				</div>";
		/*
		if(location.pathname == "/free/main.do"){
			if(rntCheckbox){
				html = html + "				<div class='selectchk chkv_show'>";
				html = html + "					<p class='chkbox hc_show'>";
				html = html + "						<span><input id='chk_cusm2' type='checkbox' data-role='none' onclick='fn_selChkEqual();'/></span>";
				html = html + "						<label for='chk_cusm2'>선택 지역 렌터카 동일 적용</label>";
				html = html + "					</p>";
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

			//호텔 도시 검색
			for (var l_idx = 0; l_idx < cityGroup.cityList.length; l_idx++) {
					var city_list = cityGroup.cityList[l_idx];
					var funcNm = "\selectCityList('" + city_list.htlCd + "','" + city_list.ctNmEn + "','" + city_list.ctNm + "','" + city_list.naCd + "','" + city_list.rntCd + "'\)";
					html = html + '				<td city-data="'+ city_list.htlCd + '" country-data="' + city_list.naCd + '" onClick="' + funcNm + '">' + city_list.ctNm + '</td>';

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
		
		setTimeout(function(){
			$("#cityPopInput").focus();
		}, 50);
		
		//국내호텔인 경우
		if(domesticYn == 'Y') {
			$('#citySrch').hide();
			gfn_callAjax("/fit/htl//domeCityCd.do",'', 'fn_selHotel', false);
			
		} else {
			$('#citySrch').show();
		}

	};
	
	// 도시검색 팝업 선택 
	function selectCityList(cityCd, ctNmEn, cityNm, countryCd, rntCd){
		var availTy = "${availTy}"; // 선택 항목  [RT : 왕복, OW : 편도, MT : 다구간, OO : 해외출발]
		var travelMtCnt = "${travelMtCnt}"; // 다구간 선택일 때만 [RT : 왕복, OW : 편도, MT : 다구간, OO : 해외출발] 몇번째 여정인지 
		var type = "${type}"; // 출발 : D, 도착 : A
		var availGroup = $('div[ft-att="' + availTy + 'Group"]');
		console.log("availTy : " + availTy);

		// console.log("availGroup=" + availGroup);
		/* if(availTy == 'MT') {
			if(type == 'A') { // 도착 : A 도착지 선택 
				if(travelMtCnt != '1') {
					var tag1 = '#srch_arr_ct'+travelMtCnt;
					var tag2 = '#srch_arr_ct_dis'+travelMtCnt;
					availGroup.find(tag1).html(cityCd);
					availGroup.find(tag2).html(cityNm);	
				} else { 
					availGroup.find('#srch_arr_ct').html(cityCd);
					availGroup.find('#srch_arr_ct_dis').html(cityNm);					
				}
			} else { // 출발 : D 출발지 선택 
				if(travelMtCnt != '1') {
					var tag1 = '#srch_dep_ct'+travelMtCnt;
					var tag2 = '#srch_dep_ct_dis'+travelMtCnt;
					availGroup.find(tag1).html(cityCd);				
					availGroup.find(tag2).html(cityNm);	
				} else { 
					availGroup.find('#srch_dep_ct').html(cityCd);
					availGroup.find('#srch_dep_ct_dis').html(cityNm);					
				}
			}
		} else { */
		
			availGroup.find('#searchCity').val(cityCd);    //도시코드
			availGroup.find('#searchCountry').val(countryCd); //국가코드
			availGroup.find('#srch_arr_ct_dis').val(cityNm); //국가이름
			availGroup.find('#searchCityNmEn').val(ctNmEn);
			availGroup.find('#searchCityNm').val(cityNm);
			availGroup.find('#searchRntCity').val(rntCd);
		//}
			/*
			if(location.pathname == "/free/main.do"){				
				if($("#chk_cusm2").is(":checked")){
					$("div[ft-att='RCGroup']").find("#dep_place").val(cityNm);
					$("div[ft-att='RCGroup']").find("#take_place_cd").val(rntCd);
					$("div[ft-att='RCGroup']").find("#take_place_oagCd").val(cityNm);
					$("div[ft-att='RCGroup']").find("#take_place_countryCd").val(countryCd);
					
					$("div[ft-att='RCGroup']").find("#arr_place").val(cityNm);
					$("div[ft-att='RCGroup']").find("#return_place_cd").val(rntCd);
					$("div[ft-att='RCGroup']").find("#return_place_oagCd").val(cityNm);
					$("div[ft-att='RCGroup']").find("#return_place_countryCd").val(countryCd);
					
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
				*/
			//}
		closePopup();

	}
	
	function fn_selChkEqual(){
		if($("#chk_cusm2").is(":checked")){
			$("#cityPopInput").attr("disabled", "disabled");
		}else{
			$("#cityPopInput").removeAttr("disabled");
		}
	}

	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		
		jQuery(document).scrollTop(nowScrollY);
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
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