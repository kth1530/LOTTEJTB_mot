
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_select_rentcar.jsp
	// 설명 : 선택확인 렌트카
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
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain pop_secokbox">
				<p class="pop_lcvtitle">선택 렌터카 정보</p>
				<dl class="pop_info_list">
					<dt>
						렌터카1
						<button type="button">삭제</button>
					</dt>
					<dd>
						<ul class="lc_acodion_info">
							<li class="on"><div>
									<span>A chevrolet spark</span><span>or similar</span>
								</div>
								<p>소형차(Economy)</p></li>
							<li>
								<ul>
									<li>승객수 : 4명</li>
									<li>수화물 개수 : 2개</li>
									<li>에어컨 : 있음</li>
									<li>변속기 : 자동</li>
									<li>연료 : 휘발유</li>
									<li>연비 : 15km/리터</li>
									<li>에어백 : 듀얼</li>
									<li>주행거리제한 : 무제한</li>
								</ul>
							</li>
						</ul>
						<table class="pop_table3 pop_table3_left">
							<tr>
								<th>차량 인수일</th>
								<td>2016.11.07(월) 13:00</td>
							</tr>
							<tr>
								<th>차량 반납일</th>
								<td>2016.11.10(목) 13:00</td>
							</tr>
							<tr>
								<th>인수 장소</th>
								<td>방콕 공항</td>
							</tr>
							<tr>
								<th>반납 장소</th>
								<td>방콕 샹그릴라 호텔</td>
							</tr>
							<tr>
								<th>추가 선택 사항</th>
								<td>
									<ul>
										<li>승객수 : 4명</li>
										<li>수화물 개수 : 2개</li>
										<li>에어컨 : 있음</li>
										<li>변속기 : 자동</li>
										<li>연료 : 휘발유</li>
										<li>연비 : 15km/리터</li>
										<li>에어백 : 듀얼</li>
										<li>주행거리제한 : 무제한</li>
									</ul>
								</td>
							</tr>
							<tr>
								<th>렌터카 총 운임</th>
								<td class="tr"><span class="f_purple">764,400</span> 원</td>
							</tr>
						</table>
					</dd>
				</dl>
				<dl class="pop_info_list pop_selinfobox">
					<dt>
						렌터카2
						<button type="button">삭제</button>
					</dt>
					<dd>
						<ul class="lc_acodion_info">
							<li><div>
									<span>A chevrolet spark</span><span>or similar</span>
								</div>
								<p>소형차(Economy)</p></li>
							<li>
								<ul>
									<li>승객수 : 4명</li>
									<li>수화물 개수 : 2개</li>
									<li>에어컨 : 있음</li>
									<li>변속기 : 자동</li>
									<li>연료 : 휘발유</li>
									<li>연비 : 15km/리터</li>
									<li>에어백 : 듀얼</li>
									<li>주행거리제한 : 무제한</li>
								</ul>
							</li>
						</ul>
						<table class="pop_table3 pop_table3_left">
							<tr>
								<th>차량 인수일</th>
								<td>2016.11.07(월) 13:00</td>
							</tr>
							<tr>
								<th>차량 반납일</th>
								<td>2016.11.10(목) 13:00</td>
							</tr>
							<tr>
								<th>인수 장소</th>
								<td>방콕 공항</td>
							</tr>
							<tr>
								<th>반납 장소</th>
								<td>방콕 샹그릴라 호텔</td>
							</tr>
							<tr>
								<th>추가 선택 사항</th>
								<td>
									<ul>
										<li>승객수 : 4명</li>
										<li>수화물 개수 : 2개</li>
										<li>에어컨 : 있음</li>
										<li>변속기 : 자동</li>
										<li>연료 : 휘발유</li>
										<li>연비 : 15km/리터</li>
										<li>에어백 : 듀얼</li>
										<li>주행거리제한 : 무제한</li>
									</ul>
								</td>
							</tr>
							<tr>
								<th>렌터카 총 운임</th>
								<td class="tr"><span class="f_purple">764,400</span> 원</td>
							</tr>
						</table>
					</dd>
				</dl>
			</div>
		</div>
		<!-- 내용끝 -->
		<div class="popFoot pf2">
			<div class="layerBtns">
				<button type="button" class="layerClose1">렌터카 추가</button>
			</div>
			<div class="layerBtns">
				<button type="button" class="layerClose2">다음</button>
			</div>
		</div>
	</div>
</div>
