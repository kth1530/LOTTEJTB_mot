<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_select_hotel.jsp
	// 설명 : 선택확인 호텔
%>

<script type="text/javascript">
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){

	// 초기화
	var fn_init = function() {
	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();

		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});
</script>

<div class="layerPopup">
	<div class="layerPop">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">선택확인</strong>
					<button type="button" class="layerClose">
						<img src="../../images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain pop_secokbox">
				<p class="pop_htvtitle">선택 호텔 정보</p>
				<dl class="pop_info_list">
					<dt>
						호텔1
						<button type="button">삭제</button>
					</dt>
					<dd>
						<table class="pop_table1 pop_table2_left">
							<thead>
								<tr>
									<th colspan="2">방콕 샹그릴라 호텔</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th>투숙기간</th>
									<td>2016.11.07(월) ~ 2016.11.09(수) 2박</td>
								</tr>
								<tr>
									<th>객실</th>
									<td>
										<p class="purple2">바로확정</p>
										<p>Deluxe Room 조식포함</p>
										<p>객실 2 / 성인 3명, 아동 2명, 유아 0명</p>
									</td>
								</tr>
								<tr>
									<th>합계</th>
									<td class="f_purple">2016.11.01 16:00까지 무료</td>
								</tr>
								<tr>
									<th>총 운임</th>
									<td class="tr"><span class="f_purple">764,400</span> 원</td>
								</tr>
							</tbody>
						</table>
					</dd>
				</dl>
				<dl class="pop_info_list pop_selinfobox">
					<dt>
						호텔1
						<button type="button">삭제</button>
					</dt>
					<dd>
						<table class="pop_table1 pop_table2_left">
							<thead>
								<tr>
									<th colspan="2">방콕 샹그릴라 호텔</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th>투숙기간</th>
									<td>2016.11.07(월) ~ 2016.11.09(수) 2박</td>
								</tr>
								<tr>
									<th>객실</th>
									<td>
										<p class="purple2">바로확정</p>
										<p>Deluxe Room 조식포함</p>
										<p>객실 2 / 성인 3명, 아동 2명, 유아 0명</p>
									</td>
								</tr>
								<tr>
									<th>합계</th>
									<td class="f_purple">2016.11.01 16:00까지 무료</td>
								</tr>
								<tr>
									<th>총 운임</th>
									<td class="tr"><span class="f_purple">764,400</span> 원</td>
								</tr>
							</tbody>
						</table>
					</dd>
				</dl>
			</div>
		</div>
		<!-- 내용끝 -->
		<div class="popFoot pf2">
			<div class="layerBtns">
				<button type="button" class="layerClose1">객실추가</button>
			</div>
			<div class="layerBtns">
				<button type="button" class="layerClose2">다음</button>
			</div>
		</div>
	</div>
</div>
