<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.lottejtb.front.air.service.*" %>
<%@ page import="com.lottejtb.comm.util.*" %>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<%
	String cust_cd = (String) request.getAttribute("cust_cd");
	String knm = (String) request.getAttribute("knm");
	String email = (String) request.getAttribute("email");
	String age = (String) request.getAttribute("age");
	String sex = (String) request.getAttribute("sex");
	//RsvAirVO rsvAir = (RsvAirVO) request.getAttribute("rsvAirResult");
	String freeRsvNo = request.getParameter("rsvSeqno");

%>
<head>
<script src="/resources/common/js/fit/pay.js"></script>
<script type="text/javascript">
	var fitRsvNo = "${fitRsvNo}";
	var limitDate = "${limitDate}";

	// 초기화
	var fn_init = function() {
		if('${selAir}' == 'Y'){
			$("#reserveComment").show();
		}else{
			$("#reserveComment").hide();
		}
	 	/* if('${selAir}' == 'N' && '${selHotel}' == 'N' && '${selRentcar}' == 'Y'){
			$("#goPayPage").hide();
			$("#goMytourPage").show();
		}else{
			$("#goPayPage").show();
			$("#goMytourPage").hide();
		}  */
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

		$("#fitRsvNoId").text("예약번호 : "+ fitRsvNo);
		
		if(nullToBlank(limitDate) != ""){
			$("#pay_limit").text("결제 마감시한 : "+ limitDate);	
		}
	});


</script>
</head>
<body>
	<form name="f_frm" id="f_frm" method="post">
		<input type="hidden" name="selAir" id="selAir"  value="${selAir}" />
		<input type="hidden" name="selHotel" id="selHotel" value="${selHotel}" />
		<input type="hidden" name="selRentcar" id="selRentcar" value="${selRentcar}" />
	</form>	
	
	<!--content-->    
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="navstitle freeback">예약완료</div>
		<div class="free_reserve collapse fr_step5">
			<div class="ft_whbox mt7 tc">
				<p class="f5_text1">고객님의 예약이 정상적으로 완료되었습니다.</p>
				<p class="f5_number" id="fitRsvNoId"></p>
				<p class="f5_text2 f_purple" id="pay_limit"></p>
			</div>
			<div class="ft_whbox mt7" id="reserveComment">
				<ul class="dotlist3">
					<li>결제시한까지  요금 및 좌석이 확정되지 않으면 예약이 자동취소 됩니다.</li>
					<li>요금 및 좌석이 확정되면 등록하신 예약자 정보를 통해 안내가 이루어집니다. </li>
					<li>요금 및 좌석 확정 이후 결제 시한 내 여권 정보입력 및 결제를 진행 해 주시기 바랍니다.</li>
					<li>항공사 간의 공동운항으로 인해 예약하신 항공사와 실제 탑승 항공사가 다를 수 있습니다.</li>
				</ul>
			</div>
			<!-- 버튼 -->
			<!--<div class="btn_one air_tbtn addbtn2" id="goPayPage"><button class="purple2" data-role="none" onClick="fn_goPay('<%=freeRsvNo%>','${selAir}','${selHotel}','${selRentcar}')">결재하기</button></div>-->
			<div class="btn_one air_tbtn addbtn2" id="goMytourPage"><button class="purple2" data-role="none" onClick="fn_moveMytour();">마이투어 예약확인</button></div>
			<div class="btn_one air_tbtn"><button class="layerOpener white2" data-url="/pop/pop_email.do?rsvSeqno=${freeRsvNo}"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'>메일보내기</button></div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//content-->
