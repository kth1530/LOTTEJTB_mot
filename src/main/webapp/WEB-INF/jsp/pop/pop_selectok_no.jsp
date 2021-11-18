<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_selectok_no.jsp
	// 설명 : 빈 선택확인
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
				<dl class="pop_chk_list pop_chk_list2">
					<dt>선택 항공 정보</dt>
					<dd class="tc">
						<p class="nodata">선택된 내용이 없습니다.</p>
						<div class="pop_btn_one">
							<button class="purple2" data-role="none">항공권 검색하기</button>
						</div>
					</dd>
				</dl>
				<dl class="pop_chk_list pop_chk_list2">
					<dt>선택 호텔 정보</dt>
					<dd class="tc">
						<p class="nodata">선택된 내용이 없습니다.</p>
						<div class="pop_btn_one">
							<button class="purple2" data-role="none">호텔 예약하기</button>
						</div>
					</dd>
				</dl>
				<dl class="pop_chk_list pop_chk_list2">
					<dt>선택 렌터카 정보</dt>
					<dd class="tc">
						<p class="nodata">선택된 내용이 없습니다.</p>
						<div class="pop_btn_one">
							<button class="purple2" data-role="none">렌터카 예약하기</button>
						</div>
					</dd>
				</dl>
				<dl class="pop_chk_list pop_chk_list2">
					<dt class="pop_avtitle2">숙박시설유형</dt>
					<dd class="pop_paytext1">
						<p>
							항공 <span>0000원</span>
						</p>
						<p>
							호텔 <span>0000원</span>
						</p>
						<p>
							렌터카(후불) <span>0000원</span>
						</p>
						<p class="ppred">
							프로모션 <span>0000원</span>
						</p>
					</dd>
				</dl>
				<p class="pop_avtitle3">
					총 결제예정금액 <span>00000원</span>
				</p>
				<p class="pop_bt_text1">항공: 유류할증료&제세공과금 포함 / 호텔: TAX, 봉사료 포함 렌터카
					: 추가사항 포함</p>
			</div>
		</div>
		<!-- 내용끝 -->
		<div class="popFoot">
			<div class="layerBtns">
				<button type="button" class="layerClose2">예약확인</button>
			</div>
		</div>
	</div>
</div>
