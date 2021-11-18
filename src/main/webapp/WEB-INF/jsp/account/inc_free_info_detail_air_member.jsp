<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	<p class="pop_avtitle4 mt7">예약자 정보</p>
	
	<!-- 대표 예약자 정보 -->
	<table class="ft_table2 ft_wht">
		<colgroup>
			<col style="width: 28%">
			<col style="width: 72%">
		</colgroup>
		<tbody id='dp_inwon' name='dp_inwon'>
			<tr>
				<th>예약자 이름</th>
				<td>홍길동</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>lotte@lottejtb.com</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>010-1234-5678</td>
			</tr>
		</tbody>
	</table>
	<!-- 대표 예약자 정보 -->

	<!-- 여행자 정보 -->
	<p class="pop_avtitle4 mt7">여행자 정보</p>
	<p class="obj_title2">
		<span class="ico_mem">탑승객 정보</span>
	</p>
	<table class="ft_table2 ft_tb_tl step4app">
		<colgroup>
			<col style="width: 28%">
			<col style="width: 72%">
		</colgroup>
		<tbody>
			<tr>
				<th>항공명</th>
				<td class="f_purple"><span id="flightNo">진에어 U0211</span></td>
			</tr>
			<tr>
				<th>탑승인원</th>
				<td class="f_purple">성인 <span id='air_adt_cnt3' name='air_adt_cnt3'>0</span>명 / 아동 <span id='air_chd_cnt3' name='air_chd_cnt3'>0</span>명 / 유아 <span id='air_inf_cnt3' name='air_inf_cnt3'>0</span>명</td>
			</tr>
		</tbody>
	</table>
	<div id='air_inwon_list' name='air_inwon_list'>
		<table class='ft_table2 ft_tb_tl step4app mt7'>
			<colgroup>
				<col style='width: 28%'>
				<col style='width: 72%'>
			</colgroup>
			<tbody>
				<tr>
					<th>한글명</th>
					<td>홍길동<em>성인1</em></td>
				</tr>
				<tr>
					<th>영문 성/이름</th>
					<td>HONG / GILDONG</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>19800701</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>01012345678</td>
				</tr>
				<tr>
					<th>성별</th>
					<td>남</td>
				</tr>
			</tbody>
		</table>
	</div>