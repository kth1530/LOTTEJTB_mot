<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>

<head>
<script type="text/javascript">
<!--
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

	// });
//-->
</script>
</head>
<body>

	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="navstitle freeback">
			결제하기<a href="/free/main.do">뒤로</a>
		</div>
		<div class="free_reserve collapse fr_step5">
			<div class="ft_whbox mt7 tc">
				<p class="f5_text1">고객님의 결제 정상적으로 완료되었습니다.</p>
				<p class="f5_number">예약번호 : ${rsvSeqNo} </p>
			</div>
			<!-- 버튼 -->
			<div class="btn_one air_tbtn addbtn2">
				<button class="purple2" data-role="none"><a href="/free/main.do">확인</a></button>
			</div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//content-->