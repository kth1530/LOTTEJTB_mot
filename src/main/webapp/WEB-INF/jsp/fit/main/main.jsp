<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../common/commTagLib.jsp"%>
<head>
<script type="text/javascript" src="https://maps.google.com/maps/api/js?v=3.exp&region=KR&key=AIzaSyD7Ofh1fQwL-osDzzlbdvRjvlG2Y8-nEyU"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	//항공편 타입 노출 여부 변경
	$('[ft-att="selFlow"]').on('click', fnChTripType);	
	
	//클래스 리스트 가져오기
	var formData = new FormData();
	formData.append('grpCd', 'SEATCLASS');
	commonCdList(formData);
});

function fnChTripType () {
	if ($('#useHotel').is(':checked') 
	|| $('#useRentalcar').is(':checked')) {
		$('[ft-att="onlyAir"]').hide();
	} else {
		$('[ft-att="onlyAir"]').show();
	}
}

//공통코드 조회 - 공통 js로 옮길것
function commonCdList (_data) {
	$.ajax({
        url: "<c:url value='/com/cd/listComCdAjax.do' />",
        type: 'POST',
        data: _data,
        async: false,
        cache: false,
        dataType : "json",
        contentType: false,
        processData: false,
        success: function (data,status) {
			console.log('data : ' + data);
        },
        error : function(request,status){
        	console.log('request : ' + request);
        	console.log('status : ' + status);
        }
    });
}

function fn_goSelPage () {
	location.href = '/fit/air/searchMain.do';
}

</script>
</head>
<body>
<div id="srchAir" style="border: 1px solid; float: left;">
	<input type="checkbox" id="useAir" ft-att="selFlow" /> &nbsp;
	<b>항공</b><br/>
	<input type="radio" name="airType" value="RT" />왕복
	<input type="radio" name="airType" value="OW" />편도
	<input type="radio" name="airType" ft-att="onlyAir" value="MD" />다구간
	<input type="radio" name="airType" ft-att="onlyAir" value="OV" />해외출발
	<br/><br/>
	<span>출발도시</span>
	<select id="sel_def_ct">
		<option value="SEL">서울(인천/김포)</option>
	</select>
	<br/><br/>
	<span>도착도시</span>
	<input type="text" id="arr_ct">
	<br/><br/>
	<span>출발일</span>
	<input type="text" id="def_dt">
	<br/><br/>
	<span>귀국일</span>
	<input type="text" id="arr_dt">
	<br/><br/>
	<span>인원</span>
	<select>
		<option value="1">1명</option>
		<option value="2">2명</option>
		<option value="3">3명</option>
		<option value="4">4명</option>
		<option value="5">5명</option>
		<option value="6">6명</option>
		<option value="7">7명</option>
		<option value="8">8명</option>
		<option value="9">9명</option>
	</select>
	<br/>
	<select>
		<option value="1">1명</option>
		<option value="2">2명</option>
		<option value="3">3명</option>
		<option value="4">4명</option>
		<option value="5">5명</option>
		<option value="6">6명</option>
		<option value="7">7명</option>
		<option value="8">8명</option>
		<option value="9">9명</option>
	</select>
	<br/>
	<select>
		<option value="1">1명</option>
		<option value="2">2명</option>
		<option value="3">3명</option>
		<option value="4">4명</option>
		<option value="5">5명</option>
		<option value="6">6명</option>
		<option value="7">7명</option>
		<option value="8">8명</option>
		<option value="9">9명</option>
	</select>
	<br/><br/>
	<span>선호항공</span>
	<select id="f_air">
		<option value="A">전체</option>
		<option value="OZ">아시아나</option>
		<option value="KE">대한항공</option>
	</select>
	<br/><br/>
	<span>좌석 등급</span>
	<select id="class">
		<option value="A">전체</option>
		<option value="OZ">아시아나</option>
		<option value="KE">대한항공</option>
	</select>
</div>


<div id="srchHotel" style="border: 1px solid; float: left;">
	<input type="checkbox" id="useHotel" ft-att="selFlow" /> &nbsp;
	<b>호텔</b><br/>
	<span>여행지</span>
	<input type="text" id="arr_ct">
	<br/><br/>
	<span>체크인</span>
	<input type="text" id="def_dt">
	<br/><br/>
	<span>체크아웃</span>
	<input type="text" id="arr_dt">
	<br/><br/>
	<span>객실 수</span>
	<select>
		<option value="1">1</option>
		<option value="2">2</option>
		<option value="3">3</option>
		<option value="4">4</option>
		<option value="5">5</option>
		<option value="6">6</option>
		<option value="7">7</option>
		<option value="8">8</option>
		<option value="9">9</option>
	</select>
	
	<br/><br/>
	<div ft-att="roomInfo">
		<span ft-att="roomType">객실1</span>
		<select>
			<option value="1">2인실(트윈)</option>
			<option value="2">2인실(더블)</option>
		</select>
		<span>아동</span>
		<select>
			<option value="1">1</option>
			<option value="2">2</option>
		</select>	
		<span>아동나이</span>
		<select>
			<option value="1">만1세</option>
			<option value="2">만2세</option>
		</select>		
	</div>
</div>


<div id="srchRentalcar" style="border: 1px solid;">
	<input type="checkbox" id="useRentalcar" ft-att="selFlow" /> &nbsp;
	<b>렌트카</b><br/>
	<span>인수장소</span>
	<input type="text" value="" />
	<br/>
	<input type="checkbox" value="1" />인수장소와 동일
	<br/>
	<span>반납위치</span>
	<input type="text" />
	<br/><br/>
	<span>차량 인수일</span>
	<input type="text" />
	<span>인수 시간</span>
	<select>
		<option value="1">1시</option>
		<option value="2">2시</option>
		<option value="3">3시</option>
		<option value="4">4시</option>
	</select>
	<br/><br/>
	<span>차량 반납일</span>
	<input type="text" />
	<span>반납 시간</span>
	<select>
		<option value="1">1시</option>
		<option value="2">2시</option>
		<option value="3">3시</option>
		<option value="4">4시</option>
	</select>
	<br/><br/>
	<span>운전자</span>
	<select>
		<option value="20">20세</option>
		<option value="21">21세</option>
		<option value="22">22세</option>
	</select>
</div>
<a onclick="fn_goSelPage();" style="width: 100%; cursor: pointer;">검색하기</a>
</body>