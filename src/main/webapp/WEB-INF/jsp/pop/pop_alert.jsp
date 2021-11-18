<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_alert.jsp
	// 설명 : 알림창
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
					<strong class="popTitle">알림</strong>
					<button type="button" class="layerClose">
						<img src="../../images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain cldarpart pop_alert">항공권을 선택해주세요</div>
		</div>
		<!-- 내용끝 -->
		<div class="popFoot">
			<div class="layerBtns">
				<button type="button" class="layerClose1">확인</button>
			</div>
		</div>
	</div>
</div>