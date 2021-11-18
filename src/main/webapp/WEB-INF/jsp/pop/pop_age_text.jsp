<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_age_text.jsp
	// 설명 : 연령 선택이 필요한 이유
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
					<strong class="popTitle">연령 입력이 필요한 이유</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain cldarpart">
				입력하신 연령에 따라 임차할 수 있는 차량과 요금을 안내해 드립니다. 대부분의 국가에서 임차 가능 연령은 만 25세
				이상이며 만 25세 미만의 운정자의 경우에는 연소운전자 추가요금이 적용됩니다. 최소 임차가능 연령 규정은 영업소 및 차량에
				따라 다르게 적용될 수 있습니다. <br> <br> 유의사항 : 차량 선택 시 Prestige,
				Dream, Supercar 또는 Adrenaline Collection 차량이 안내될 수 있습니다. 임차영업소에 따라
				해당 Collection 차량은 만 27세~30세 이상의 운전자만 임차 가능합니다. 해당 차량에 대한 임차 가능 여부를
				“임차 자격 및 요건”에서 확인 바랍니다. <br> <br> 할인행사를 통해 예약 시 운전가능 연령에
				대한 규정이 별도로 적용됨을 숙지바랍니다. 연소 운전자 추가요금은 예약 시 안내되는 예상 임차요금에는 포함되지 않을 수
				있습니다. 만 25세 미만의 운전자의 경우, 연소 운전자 추가요금에 대한 규정을 별도 확인해 주십시오.
			</div>
		</div>
		<!-- 내용끝 -->
		<div class="popFoot">
			<div class="layerBtns">
				<button type="button" class="layerClose2">확인</button>
			</div>
		</div>
	</div>
</div>