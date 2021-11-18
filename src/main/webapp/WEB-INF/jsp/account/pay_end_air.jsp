<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>

<%
	String Nm_inputbank = (String) request.getAttribute("Nm_inputbank");
%>

<head>
<script type="text/javascript">
	// 초기화
	var fn_init = function() {
	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};
	
	var fn_moveFreeInfo = function(){
		location.href = "/free/account/free_info_detail.do?seqNo=" + "${rsvSeqNo}";
	}

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		if('${paymentReturnVo.getVacctVo()}' == 'null'){
			fn_AirPaxList();
			$("#vacctDiv").hide();
		}else{
			$("#vacctDiv").show();
		}

		fn_init();
		fn_initButton();

		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});
</script>
</head>
<body>

	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="navstitle freeback">
			결제하기
		</div>
		<div class="free_reserve collapse fr_step5">
			<div class="ft_whbox mt7 tc">
				<p class="f5_text1">고객님의 결제 정상적으로 완료되었습니다.</p>
				<p class="f5_number">예약번호 : ${rsvSeqNo} </p>
			</div>
<%
	if(Nm_inputbank != null && !"".equals(Nm_inputbank)){
%>			
			<div class="ft_whbox mt7" id="vacctDiv">
				<ul class="dotlist3">
					<li>은행명 : ${Nm_inputbank}</li>
					<li>계좌번호 : ${No_vacct}</li>
					<li>예금주 : ${Nm_input}</li>
					<li class="f_red">가상계좌는 7일 이후 삭제됩니다.</li>
				</ul>
			</div>
			<!-- 버튼 -->
			<div class="btn_one air_tbtn addbtn2">
				<button class="purple2" data-role="none" onclick="fn_moveFreeInfo()">확인</button>
			</div>
<%
	}
%>			
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//content-->