<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>

<p class="obj_title2 obj_bg_wht mt7"><span class="ico_exclamat">목적지/거주지 정보 등록 (선택) </span><span>(미국 내 첫번째 주소)</span></p>
<ul class="txbox2">
	<li>미주 지역으로 예약하신 경우 목적지/거주지 정보를 등록해 주셔야 합니다.(단 미국 시민권자, 영주권자, 외국인 등록증 소지자는 제외)</li>
	<li>세부 주소 입력 시, 특수 문자(#,/,*)를 제외한 문자와 숫자로 기재하셔야 정상 반영됩니다.</li>
</ul>
<div class="obj_bg_wht area_sel_box">
	<p class="chkbox">
		<span><input id="chk_ck1" type="checkbox" data-role="none"></span>
		<label for="chk_ck1">1번째 탑승객의 목적지/거주지 정보로 일괄 등록</label>
	</p>
</div>
<!-- 탑승자별 목적지 리스트 -->
<div class='white2' id='div_airPaxArrList' name='div_airPaxArrList'>
</div>
<!-- 탑승자별 목적지 리스트 -->