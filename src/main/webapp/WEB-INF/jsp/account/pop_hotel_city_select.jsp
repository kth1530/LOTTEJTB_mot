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
	
	///if(_type == 'hotel') {
	if(domesticYn == 'Y'){
		baseCityList = [
						{ naNm: '주요도시', 	cityList: [{htlCd:'Seoul', naCd:'KR', ctNm:'서울'},			{htlCd:'Busan (Pusan)', naCd:'KR', ctNm:'부산'},	{htlCd:'Incheon', naCd:'KR', ctNm:'인천'},		{htlCd:'Gyeongju', naCd:'KR', ctNm:'경주'},	{htlCd:'Daegu', naCd:'KR', ctNm:'대구'},	{htlCd:'Gwangju', naCd:'KR', ctNm:'광주'},	{htlCd:'Ulsan', naCd:'KR', ctNm:'울산'}]}
					  , { naNm: '서울', 		cityList: [{htlCd:'', naCd:'KR', ctNm:'강남구'},				{htlCd:'', naCd:'KR', ctNm:'서초구'},				{htlCd:'', naCd:'KR', ctNm:'송파구'}, 			{htlCd:'', naCd:'KR', ctNm:'종로구'}, {htlCd:'', naCd:'KR', ctNm:'중구'}, {htlCd:'', naCd:'KR', ctNm:'마포구'}, {htlCd:'', naCd:'KR', ctNm:'영등포구'}, {htlCd:'', naCd:'KR', ctNm:'서대문구'}, {htlCd:'', naCd:'KR', ctNm:'동대문구'}, {htlCd:'', naCd:'KR', ctNm:'용산구'}, {htlCd:'', naCd:'KR', ctNm:'금천구'}, {htlCd:'', naCd:'KR', ctNm:'강서구'}, {htlCd:'', naCd:'KR', ctNm:'성동구'}, {htlCd:'', naCd:'KR', ctNm:'광진구'}, {htlCd:'', naCd:'KR', ctNm:'동작구'}, {htlCd:'', naCd:'KR', ctNm:'구로구'}, {htlCd:'', naCd:'KR', ctNm:'은평구'}, {htlCd:'', naCd:'KR', ctNm:'강복구'}, {htlCd:'', naCd:'KR', ctNm:'노원구'}, {htlCd:'', naCd:'KR', ctNm:'성북구'}]}
					  , { naNm: '제주', 		cityList: [{htlCd:'Seogwipo', naCd:'KR', ctNm:'서귀포시'}, 	{htlCd:'Jeju', naCd:'KR', ctNm:'제주시'}]}
					  , { naNm: '강원', 		cityList: [{htlCd:'Gangneung', naCd:'KR', ctNm:'강릉'}, 		{htlCd:'Sokcho', naCd:'KR', ctNm:'속초'}, 		{htlCd:'Yangyang', naCd:'KR', ctNm:'양양'}, 	{htlCd:'Jeongseon', naCd:'KR', ctNm:'정선'}, 	{htlCd:'Chuncheon', naCd:'KR', ctNm:'춘천'}, 		{htlCd:'Goseong', naCd:'KR', ctNm:'고성'}, 	{htlCd:'Pyeongchang', naCd:'KR', ctNm:'평창'}, 	{htlCd:'Hoengseong', naCd:'KR', ctNm:'횡성'}, 	{htlCd:'Wonju', naCd:'KR', ctNm:'원주'}]}
					  , { naNm: '경상', 		cityList: [{htlCd:'Gyeongju', naCd:'KR', ctNm:'경주'}, 		{htlCd:'Pohang', naCd:'KR', ctNm:'포항'}, 		{htlCd:'Koje', naCd:'KR', ctNm:'거제'}, 		{htlCd:'Tongyeong', naCd:'KR', ctNm:'통영'}, 	{htlCd:'Namhae', naCd:'KR', ctNm:'남해'}, 			{htlCd:'Masan', naCd:'KR', ctNm:'마산'}, 		{htlCd:'Changwon', naCd:'KR', ctNm:'창원'}, 		{htlCd:'Gumi', naCd:'KR', ctNm:'구미'}]}
					  , { naNm: '전라', 		cityList: [{htlCd:'Gwangju', naCd:'KR', ctNm:'광주'}, 		{htlCd:'Yeosu', naCd:'KR', ctNm:'여수'}, 			{htlCd:'Suncheon', naCd:'KR', ctNm:'순천'}, 	{htlCd:'Mokpo Apt', naCd:'KR', ctNm:'목포'}, 	{htlCd:'Buan(Byeonsan)', naCd:'KR', ctNm:'부안'}, 	{htlCd:'Gunsan', naCd:'KR', ctNm:'군산'}, 		{htlCd:'Jeonju', naCd:'KR', ctNm:'전주'}, 			{htlCd:'Namwon', naCd:'KR', ctNm:'남원'}, 		{htlCd:'Gurye', naCd:'KR', ctNm:'구례'}]}
					  , { naNm: '경기', 		cityList: [{htlCd:'Suwon', naCd:'KR', ctNm:'수원'}, 			{htlCd:'Hwaseong', naCd:'KR', ctNm:'화성'}, 		{htlCd:'Goyang', naCd:'KR', ctNm:'고양'}, 		{htlCd:'Yeoju', naCd:'KR', ctNm:'여주'},		{htlCd:'Seongnam', naCd:'KR', ctNm:'성남'}, 		{htlCd:'Yangpyeong', naCd:'KR', ctNm:'양평'}, 	{htlCd:'Gapyeong', naCd:'KR', ctNm:'가평'}, 		{htlCd:'Icheon', naCd:'KR', ctNm:'이천'}, 		{htlCd:'Pocheon', naCd:'KR', ctNm:'포천'}]}
					  , { naNm: '충청', 		cityList: [{htlCd:'Daejeon', naCd:'KR', ctNm:'대전'}, 		{htlCd:'Chungju', naCd:'KR', ctNm:'충주'}, 		{htlCd:'Asan', naCd:'KR', ctNm:'아산'}, 		{htlCd:'Cheonan', naCd:'KR', ctNm:'천안'}, 	{htlCd:'Jecheon', naCd:'KR', ctNm:'제천'}, 		{htlCd:'Boryeong', naCd:'KR', ctNm:'보령'}, 	{htlCd:'Cheongju', naCd:'KR', ctNm:'청주'}, 		{htlCd:'Danyang', naCd:'KR', ctNm:'단양'}, 	{htlCd:'Buyeo', naCd:'KR', ctNm:'부여'}]
		}];
	}else{
		baseCityList = [{
		    naNm: '일본', cityList: [{
				airCd: 'TYO', htlCd: 'Tokyo', rntCd: 'NARITA', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '도쿄'
		    }, {
				airCd: 'OSA', htlCd: 'Osaka', rntCd: 'OSAKA', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '오사카'
		    }, {
				airCd: 'FUK', htlCd: 'Fukuoka', rntCd: 'FUKUOKA', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '후쿠오카'
		    }, {
				airCd: 'SPK', htlCd: 'Sapporo', rntCd: 'CHITOSE', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '삿포로'
		    }, {
				airCd: 'UKY', htlCd: 'Kyoto', rntCd: 'KYOTO', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '교토'
		    }, {
				airCd: 'OKA', htlCd: 'Okinawa City', rntCd: 'OKINAWA', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '오키나와'
		    }, {
				airCd: 'AQ4', htlCd: 'Yufu', rntCd: 'YUFU', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '유후인'
		    }, {
				airCd: 'HAKO', htlCd: 'Hakone', rntCd: 'Hakone', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '하코네'
		    }, {
				airCd: '993', htlCd: 'Noboribetsu', rntCd: 'Noboribetsu', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '노보리베츠'
		    }, {
				airCd: 'NGO', htlCd: 'Nagoya', rntCd: 'Nagoya', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '나고야'
		    }, {
				airCd: 'OKJ', htlCd: 'Okayama', rntCd: 'OKAYAMA', naNm: '일본', naCd: 'JP', stCd: '', ctNm: '오카야마'
		    }]
		}, {
		    naNm: '중국', cityList: [{
		        airCd: 'HKG', htlCd: 'Hong Kong', rntCd: 'HONG KONG', naNm: '홍콩', naCd: 'HK', stCd: '', ctNm: '홍콩'
		    }, {
		        airCd: 'MFM', htlCd: 'Macau', rntCd: 'Macau', naNm: '마카오', naCd: 'MO', stCd: '', ctNm: '마카오'		// 렌터카 검색 안됨
		    }, {
				airCd: 'BJS', htlCd: 'Beijing', rntCd: 'Beijing', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '북경'
		    }, {
		        airCd: 'SHA', htlCd: 'Shanghai', rntCd: 'SHA', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '상해'
		    }, {
		        airCd: 'TAO', htlCd: 'Qingdao', rntCd: 'QINGDAO', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '청도'
		    }, {
		        airCd: 'YNT', htlCd: 'Yantai', rntCd: 'Yantai', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '연태'		// 렌터카 검색 안됨
		    }, {
		        airCd: 'DLC', htlCd: 'Dalian', rntCd: 'DALIAN', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '대련'
		    }, {
		        airCd: 'HGH', htlCd: 'Hangzhou', rntCd: 'HANGZHOU', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '항주'		//COM_AIRPORTCD테이블에서 사용안함으로 되어있음, 한글명 없음
		    }, {
		        airCd: 'CAN', htlCd: 'Guangzhou', rntCd: 'GUANGZHOU', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '광주'
		    }, {
		        airCd: 'SZX', htlCd: 'Shenzhen', rntCd: 'Shenzhen', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '심천'
		    }, {
		        airCd: 'WEH', htlCd: 'Weihai', rntCd: 'Weihai', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '위해'
		    }, {
		        airCd: 'SYX', htlCd: 'Sanya', rntCd: 'Sanya', naNm: '중국', naCd: 'CN', stCd: '', ctNm: '하이난'
		    }, {
		        airCd: 'ULN', htlCd: 'Ulaanbaatar', rntCd: 'Ulaanbaatar', naNm: '몽고', naCd: 'MN', stCd: '', ctNm: '울란바토르'
		    }]
		}, {	
		    naNm: '동남아', cityList: [{
		        airCd: 'SIN', htlCd: 'Singapore', rntCd: 'SINGAPORE', naNm: '싱가포르', naCd: 'SG', stCd: '', ctNm: '싱가폴'
		    }, {
		        airCd: 'BKK', htlCd: 'Bangkok', rntCd: 'BANGKOK', naNm: '태국', naCd: 'TH', stCd: '', ctNm: '방콕'
		    }, {
		        airCd: 'MNL', htlCd: 'Manila', rntCd: 'MANILA', naNm: '필리핀', naCd: 'PH', stCd: '', ctNm: '마닐라'
		    }, {
		        airCd: 'TPE', htlCd: 'Taipei', rntCd: 'Taipei', naNm: 'TW', naCd: '대만', stCd: '', ctNm: '타이베이'		// 렌터카 검색 안됨
		    }, {
		        airCd: 'KUL', htlCd: 'Kuala Lumpur', rntCd: 'Kuala Lumpur', naNm: '말레이시아', naCd: 'MY', stCd: '', ctNm: '쿠알라룸푸르'
		    }, {
		        airCd: 'JKT', htlCd: 'Jakarta', rntCd: 'Jakarta', naNm: '인도네시아', naCd: 'ID', stCd: '', ctNm: '자카르타'	//렌터카 검색안됨
		    }, {
		        airCd: 'SGN', htlCd: 'Ho Chi Minh City', rntCd: 'SGN', naNm: '베트남', naCd: 'VN', stCd: '', ctNm: '호치민'		// 렌터카 검색 안됨 - 베트남 자체가 없음
		    }, {
		        airCd: 'HAN', htlCd: 'Hanoi', rntCd: 'Hanoi', naNm: '베트남', naCd: 'VN', stCd: '', ctNm: '하노이'		// 렌터카 검색 안됨 - 베트남 자체가 없음
		    }, {
		        airCd: 'REP', htlCd: 'Siem Reap', rntCd: 'Siem Reap', naNm: '캄보디아', naCd: 'KH', stCd: '', ctNm: '씨앰립'	//렌터카 검색안됨
		    }, {
		        airCd: 'BOM', htlCd: 'Mumbai', rntCd: 'Mumbai', naNm: '인도', naCd: 'IN', stCd: '', ctNm: '뭄바이'	//렌터카 검색안됨
		    }, {
		        airCd: 'HKT', htlCd: 'Phuket', rntCd: 'PHUKET', naNm: '태국', naCd: 'TH', stCd: '', ctNm: '푸켓'
		    }, {
		        airCd: 'PYX', htlCd: 'Pattaya', rntCd: 'Pattaya', naNm: '태국', naCd: 'TH', stCd: '', ctNm: '파타야'
		    }, {
		        airCd: 'USM', htlCd: 'Koh Samui', rntCd: 'Koh Samui', naNm: '태국', naCd: 'TH', stCd: '', ctNm: '코사무이'
		    }, {
		        airCd: 'HHQ', htlCd: 'Hua Hin', rntCd: 'Hua Hin', naNm: '태국', naCd: 'TH', stCd: '', ctNm: '후아힌'
		    }, {
		        airCd: 'CNX', htlCd: 'Chiang Mai', rntCd: 'Chiang Mai', naNm: '태국', naCd: 'TH', stCd: '', ctNm: '치앙마이'
		    }, {
		        airCd: 'KBV', htlCd: 'Krabi', rntCd: 'Krabi', naNm: '태국', naCd: 'TH', stCd: '', ctNm: '크라비'
		    }, {
		        airCd: 'DPS', htlCd: 'Bali', rntCd: 'Bali', naNm: '인도네시아', naCd: 'ID', stCd: '', ctNm: '발리'
		    }, {
		        airCd: 'BIF', htlCd: 'Bintan', rntCd: 'Bintan', naNm: '인도네시아', naCd: 'ID', stCd: '', ctNm: '빈탄'
		    }, {
		        airCd: 'CEB', htlCd: 'Cebu', rntCd: 'CEBU', naNm: '필리핀', naCd: 'PH', stCd: '', ctNm: '세부'
		    }, {
		        airCd: 'KLO', htlCd: 'Boracay Island', rntCd: 'Boracay Island', naNm: '필리핀', naCd: 'PH', stCd: '', ctNm: '보라카이(칼리보)'	//렌터카 검색안됨
		    }, {
		        airCd: 'BKI', htlCd: 'Kota Kinabalu', rntCd: 'Kota Kinabalu', naNm: '말레이시아', naCd: 'MY', stCd: '', ctNm: '코타키나발루'
		    }, {
		        airCd: 'MLE', htlCd: 'Maldives', rntCd: 'Maldives', naNm: '몰디브', naCd: 'MV', stCd: '', ctNm: '몰디브'
		    }, {
		        airCd: 'DAD', htlCd: 'Da Nang', rntCd: 'Da Nang', naNm: '베트남', naCd: 'VN', stCd: '', ctNm: '다낭'
		    }]
		}, {
		    naNm: '중동', cityList: [{
		        airCd: 'DXB', htlCd: 'Dubai', rntCd: 'DXB', naNm: '아랍에미리트', naCd: 'AE', stCd: '', ctNm: '두바이'
		    }, {
		        airCd: 'CAI', htlCd: 'Cairo', rntCd: 'Cairo', naNm: '이집트', naCd: 'EG', stCd: '', ctNm: '카이로'		//렌터카 검색안됨
		    }, {
		        airCd: 'DOH', htlCd: 'Doha', rntCd: 'DOH', naNm: '카타르', naCd: 'QA', stCd: '', ctNm: '도하'
		    }]
		}, {
		    naNm: '미국', cityList: [{
		        airCd: 'NYC', htlCd: 'New York', rntCd: 'NEW YORK', naNm: '미국', naCd: 'US', stCd: 'NY', ctNm: '뉴욕'
		    }, {
		        airCd: 'LAX', htlCd: 'Los Angeles', rntCd: 'LOS ANGELES', naNm: '미국', naCd: 'US', stCd: 'CA', ctNm: 'LA'
		    }, {
		        airCd: 'LAS', htlCd: 'Las Vegas', rntCd: 'Las Vegas', naNm: '미국', naCd: 'US', stCd: 'NV', ctNm: '라스베가스'
		    }, {
		        airCd: 'SFO', htlCd: 'San Francisco', rntCd: 'SAN FRANCISCO', naNm: '미국', naCd: 'US', stCd: 'CA', ctNm: '샌프란시스코'
		    }, {
		        airCd: 'WAS', htlCd: 'Washington', rntCd: 'WAS', naNm: '미국', naCd: 'US', stCd: 'DC', ctNm: '워싱턴'
		    }, {
		        airCd: 'CHI', htlCd: 'Chicago', rntCd: 'CHICAGO', naNm: '미국', naCd: 'US', stCd: 'IL', ctNm: '시카고'
		    }, {
		        airCd: 'BOS', htlCd: 'Boston', rntCd: 'BOSTON', naNm: '미국', naCd: 'US', stCd: 'MA', ctNm: '보스톤'
		    }, {
		        airCd: 'ORL', htlCd: 'Orlando', rntCd: 'Orlando', naNm: '미국', naCd: 'US', stCd: 'FL', ctNm: '올랜도'
		    }, {
		        airCd: 'MIA', htlCd: 'Miami', rntCd: 'Miami', naNm: '미국', naCd: 'US', stCd: 'FL', ctNm: '마이애미'
		    }, {
		        airCd: 'HNL', htlCd: 'Honolulu', rntCd: 'HONOLULU', naNm: '미국', naCd: 'US', stCd: 'HI', ctNm: '호놀룰루'
		    }, {
		        airCd: 'OGG', htlCd: 'Maui', rntCd: 'Maui', naNm: '미국', naCd: 'US', stCd: 'HI', ctNm: '마우이'
		    }, {
		        airCd: 'YVR', htlCd: 'Vancouver', rntCd: 'Vancouver', naNm: '미국', naCd: 'US', stCd: 'BC', ctNm: '밴쿠버'
		    }, {
		        airCd: 'YTO', htlCd: 'Toronto', rntCd: 'Toronto', naNm: '캐나다', naCd: 'CA', stCd: 'ON', ctNm: '토론토'
		    }]
		}, {
		    naNm: '유럽', cityList: [{
		        airCd: 'LON', htlCd: 'London', rntCd: 'LONDON', naNm: '영국', naCd: 'GB', stCd: '', ctNm: '런던'
		    }, {
		        airCd: 'PAR', htlCd: 'Paris', rntCd: 'PARIS', naNm: '프랑스', naCd: 'FR', stCd: '', ctNm: '파리'
		    }, {
		        airCd: 'ROM', htlCd: 'Rome', rntCd: 'ROME', naNm: '이탈리아', naCd: 'IT', stCd: '', ctNm: '로마'
		    }, {
		        airCd: 'MIL', htlCd: 'Milan', rntCd: 'Milan', naNm: '이탈리아', naCd: 'IT', stCd: '', ctNm: '밀라노'
		    }, {
		        airCd: 'VCE', htlCd: 'Venice', rntCd: 'VENICE', naNm: '이탈리아', naCd: 'IT', stCd: '', ctNm: '베니스'
		    }, {
		        airCd: 'AMS', htlCd: 'Amsterdam', rntCd: 'Amsterdam', naNm: '네델란드', naCd: 'NL', stCd: '', ctNm: '암스테르담'
		    }, {
		        airCd: 'ZRH', htlCd: 'Zurich', rntCd: 'ZURICH', naNm: '스위스', naCd: 'CH', stCd: '', ctNm: '취리히'
		    }, {
		        airCd: 'FRA', htlCd: 'Frankfurt', rntCd: 'FRANKFURT', naNm: '독일', naCd: 'DE', stCd: '', ctNm: '프랑크푸르트'
		    }, {
		        airCd: 'MUC', htlCd: 'Munich', rntCd: 'MUNICH', naNm: '독일', naCd: 'DE', stCd: '', ctNm: '뭔헨'
		    }, {
		        airCd: 'VIE', htlCd: 'Vienna', rntCd: 'VIENNA', naNm: '오스트리아', naCd: 'AT', stCd: '', ctNm: '비엔나'
		    }, {
		        airCd: 'BCN', htlCd: 'Barcelona', rntCd: 'BARCELONA', naNm: '스페인', naCd: 'ES', stCd: '', ctNm: '바르셀로나'
		    }, {
		        airCd: 'PRG', htlCd: 'Prague', rntCd: 'PRAGUE', naNm: '체코', naCd: 'CZ', stCd: '', ctNm: '프라하'
		    }, {
		        airCd: 'IST', htlCd: 'Istanbul', rntCd: 'ISTANBUL', naNm: '터키', naCd: 'TR', stCd: '', ctNm: '이스탄불'
		    }, {
		        airCd: 'MAD', htlCd: 'Madrid', rntCd: 'MADRID', naNm: '스페인', naCd: 'ES', stCd: '', ctNm: '마드리드'
		    }, {
		        airCd: 'SVO', htlCd: 'Moscow', rntCd: 'MOSCOW', naNm: '러시아', naCd: 'RU', stCd: '', ctNm: '모스크바'
		    }, {
		        airCd: 'BER', htlCd: 'Berlin', rntCd: 'BERLIN', naNm: '독일', naCd: 'DE', stCd: '', ctNm: '베를린'
		    }]
		}, {
		    naNm: '대양주', cityList: [{
		        airCd: 'SYD', htlCd: 'Sydney', rntCd: 'SYD', naNm: '호주', naCd: 'AU', stCd: 'NS', ctNm: '시드니'
		    }, {
		        airCd: 'MEL', htlCd: 'Melbourne', rntCd: 'MEL', naNm: '호주', naCd: 'AU', stCd: 'VI', ctNm: '멜버른'
		    }, {
		        airCd: 'BNE', htlCd: 'Brisbane', rntCd: 'BNE', naNm: '호주', naCd: 'AU', stCd: 'QL', ctNm: '브리즈번'
		    }, {
		        airCd: 'OOL', htlCd: 'Gold Coast', rntCd: 'GOLD COAST', naNm: '호주', naCd: 'AU', stCd: 'QL', ctNm: '골드코스트'
		    }, {
		        airCd: 'CNS', htlCd: 'Cairns', rntCd: 'CAIRNS', naNm: '호주', naCd: 'AU', stCd: 'QL', ctNm: '케언즈'
		    }, {
		        airCd: 'AKL', htlCd: 'Auckland', rntCd: 'AUCKLAND', naNm: '뉴질랜드', naCd: 'NZ', stCd: '', ctNm: '오클랜드'
		    }, {
		        airCd: 'GUM', htlCd: 'Guam', rntCd: 'GUM', naNm: '괌', naCd: 'GU', stCd: 'GU', ctNm: '괌'
		    }, {
		        airCd: 'SPN', htlCd: 'Saipan', rntCd: 'SPN', naNm: '사이판', naCd: 'MP', stCd: '', ctNm: '사이판'
		    }, {
		        airCd: 'NAN', htlCd: 'Fiji', rntCd: 'Fiji', naNm: '피지', naCd: 'FJ', stCd: '', ctNm: '피지'
		    }, {
		        airCd: 'NOU', htlCd: 'New Caledonia', rntCd: 'New Caledonia', naNm: '뉴칼레도니아', naCd: 'NC', stCd: '', ctNm: '뉴칼레도니아'
		    }, {
		        airCd: 'ROR', htlCd: 'Koror', rntCd: 'ROR', naNm: '팔라우', naCd: 'PW', stCd: '', ctNm: '팔라우'
		    }, {
		        airCd: 'CHC', htlCd: 'Christchurch', rntCd: 'CHC', naNm: '뉴질랜드', naCd: 'NZ', stCd: '', ctNm: '크라이스트처치'
		    }]
		}, {
		    naNm: '중남미', cityList: [{
		        airCd: 'MEX', htlCd: 'Mexico City', rntCd: 'MEXICO CITY', naNm: '멕시코', naCd: 'MX', stCd: '', ctNm: '멕시코시티'
		    }, {
		        airCd: 'SAO', htlCd: 'Sao Paulo', rntCd: 'SAO PAULO', naNm: '브라질', naCd: 'BR', stCd: 'SP', ctNm: '상파울루'
		    }, {
		        airCd: 'LIM', htlCd: 'Lima', rntCd: 'LIM', naNm: '페루', naCd: 'PE', stCd: '', ctNm: '리마'
		    }, {
		        airCd: 'CUN', htlCd: 'Cancun', rntCd: 'CUN', naNm: '멕시코', naCd: 'MX', stCd: '', ctNm: '칸쿤'
		    }]
		}, {
		    naNm: '아프리카', cityList: [{
		        airCd: 'JNB', htlCd: 'Johannesburg', rntCd: 'JNB', naNm: '남아프리카', naCd: 'ZA', stCd: '', ctNm: '요하네스버그'
		    }, {
		        airCd: 'CPT', htlCd: 'Cape Town', rntCd: 'CPT', naNm: '남아프리카', naCd: 'ZA', stCd: '', ctNm: '케이프타운'
		    }, {
		        airCd: 'NBO', htlCd: 'Nairobi', rntCd: 'Nairobi', naNm: '케냐', naCd: 'KE', stCd: '', ctNm: '나이로비'	// 렌터카 검색안됨
		    }, {
		        airCd: 'MLA', htlCd: 'Valletta', rntCd: 'Valletta', naNm: '몰타', naCd: 'MT', stCd: '', ctNm: '발레타'	// 렌터카 검색안됨
		    }, {
		        airCd: 'MRU', htlCd: 'Mauritius', rntCd: 'Mauritius', naNm: '모리셔스', naCd: 'MU', stCd: '', ctNm: '포트루이스(모리셔스)'	// 렌터카 검색안됨
		    }, {
		        airCd: 'DUR', htlCd: 'Durban', rntCd: 'Durban', naNm: '남아프리카', naCd: 'ZA', stCd: '', ctNm: '더반'	// 렌터카 검색안됨
		    }, {
		        airCd: 'ACC', htlCd: 'Accra', rntCd: 'ACCRA', naNm: '가나', naCd: 'GH', stCd: '', ctNm: '아크라'	// 렌터카 검색안됨
		    }, {
		        airCd: 'MLA', htlCd: ' Molta', rntCd: 'MLA', naNm: '몰타', naCd: 'MT', stCd: '', ctNm: '몰타'
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
		html = html + "					<div class='csbox'>";
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

				for (var l_idx = 0; l_idx < cityGroup.cityList.length; l_idx++) {
					var city_list = cityGroup.cityList[l_idx];
					var funcNm = "\selectCityList('" + city_list.htlCd + "','" + city_list.ctNm + "','" + city_list.naCd + "','" + city_list.rntCd + "'\)";
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

	};


	// 도시검색 팝업 선택 
	function selectCityList(cityCd, cityNm, countryCd, countryNm){
		// var availTy = "${availTy}"; // 선택 항목  [RT : 왕복, OW : 편도, MT : 다구간, OO : 해외출발]
		// var travelMtCnt = "${travelMtCnt}"; // 다구간 선택일 때만 [RT : 왕복, OW : 편도, MT : 다구간, OO : 해외출발] 몇번째 여정인지 
		// var type = "${type}"; // 출발 : D, 도착 : A
		var paxNo = '${paxNo}';
		console.log("cityCd : " + cityCd + " cityNm : " + cityNm + " countryCd : " + countryCd + " countryNm : " + countryNm);

		var tag_ctCd = "#ctCdNm"+paxNo;
		var tag_ctNm = "#ctNm"+paxNo;
		var tag_ntNm = "#ntNm"+paxNo;
		var tag_ntCd = "#ntCd"+paxNo;

		console.log("tag_ctCd : " + tag_ctCd + " tag_ctNm : " + tag_ctNm + " tag_ntNm : " + tag_ntNm + " tag_ntCd : " + tag_ntCd);


		$(tag_ctCd).text(cityCd);    //도시코드
		$(tag_ctNm).val(cityCd); 	  //도시명
		$(tag_ntNm).text(countryNm); //국가코드 
		$(tag_ntCd).val(countryCd); //국가명

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