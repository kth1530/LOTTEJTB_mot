<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>

<%
	String Nm_inputbank = (String) request.getAttribute("Nm_inputbank");
%>

<head>
<script src="/resources/common/js/fit/air_search.js"></script>
<script src="/resources/common/js/fit/paging.js"></script>
<script src="/resources/common/js/fit/common.js"></script>
<script src="/resources/common/js/database.js"></script>
<script src="/resources/common/js/fit/reserve.js"></script>

<script type="text/javascript">
	var jSessionID = '<%=request.getSession().getId()%>';
	
	var rsvSeqNo = '${rsvSeqNo}';
	// 초기화
	var fn_init = function() {
		console.log("결제예약화면=" + rsvSeqNo);
		
		if(nullToBlank(rsvSeqNo) == '') {
			$('#fitRsvNoTxt').hide();
			$('#successReserve').hide();
			$('#failReserve').show();
		} else {
		
			$('#failReserve').hide();
			$('#successReserve').show();
			if(nullToBlank(sessionStorage.airSelData) != "" && sessionStorage.airSelData != "[]"){
				fn_saveAirReserveForPay(jSessionID, rsvSeqNo);
				
				$("#reserveComment").show();
	        }else{
	        	fn_goReserveStep5(jSessionID, '', rsvSeqNo);
	        	
	        	$("#reserveComment").hide();
	        }
			$('#fitRsvNoTxt').show();
			$('#fitRsvNoTxt').html(rsvSeqNo);
		}
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
		if('${paymentReturnVo.getVacctVo()}' == 'null'){
			$("#vacctDiv").hide();
		}else{
			$("#vacctDiv").show();
		}

		fn_init();
		fn_initButton();
	});
</script>
</head>
<body>

	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="navstitle freeback">결제하기</div>
		<div class="free_reserve collapse fr_step5">
			<div id="successReserve" style="display:none;">
				<div class="ft_whbox mt7 tc">
					<p class="f5_text1">고객님의 결제 정상적으로 완료되었습니다.</p>
					<p class="f5_number" id="fitRsvNoTxt" style='display:none'></p>
					<!-- 예약번호 : ${rsvSeqNo} --> 
				</div>
				
				<div class="ft_whbox mt7" id="reserveComment">
					<ul class="dotlist3">
						<li>결제시한까지  요금 및 좌석이 확정되지 않으면 예약이 자동취소 됩니다.</li>
						<li>요금 및 좌석이 확정되면 등록하신 예약자 정보를 통해 안내가 이루어집니다. </li>
						<li>요금 및 좌석 확정 이후 결제 시한 내 여권 정보입력 및 결제를 진행 해 주시기 바랍니다.</li>
						<li>귀항공사 간의 공동운항으로 인해 예약하신 항공사와 실제 탑승 항공사가 다를 수 있습니다.</li>
						<li>항공은 추가 결제 진행하셔야 됩니다.</li>
						<li>렌터카는 현지에서 후불 결제 진행하셔야 됩니다.</li>
						
					</ul>
				</div>
				
				<%
					if(Nm_inputbank != null && !"".equals(Nm_inputbank)){
				%>			
				<div class="ft_whbox mt7" id="vacctDiv">
					<ul class="dotlist3">
						<li>은행명 : ${Nm_inputbank}</li>
						<li>계좌번호 : ${No_vacct}</li>
						<li>예금주 : ${Nm_input}</li>
						<li class="f_red">가상계좌는 1일 이후 삭제됩니다.</li>
					</ul>
				</div>
				<%
					}
				%>
				<!-- 버튼 -->
				<div class="btn_one air_tbtn addbtn2" id="goMytourPage"><button class="purple2" data-role="none" onClick="fn_moveMytour();">마이투어 예약확인</button></div>
				<div class="btn_one air_tbtn"><button class="layerOpener white2" id="sendEmailPop" data-url="" data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'>메일보내기</button></div>
			</div>
			<div id="failReserve" style="display:none;">
				<div class="ft_whbox mt7 tc">
					<p class="f5_text1">고객님의 예약이 되지 않았습니다.</p> 
				</div>
			</div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//content-->