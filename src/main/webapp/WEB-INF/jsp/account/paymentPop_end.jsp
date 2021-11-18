<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<head>
<script src="/resources/common/js/fit/air_search.js"></script>
<script src="/resources/common/js/fit/paging.js"></script>
<script src="/resources/common/js/fit/common.js"></script>
<script src="/resources/common/js/database.js"></script>
<script src="/resources/common/js/fit/reserve.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
	
	var resultPopPayment = $('#resultPopPayment');
	var resultChk = resultPopPayment.find('[name="resultCode"]').val();
	
	if(resultChk != undefined) {
		
		resultPopPayment.attr('method','post');
		resultPopPayment.attr('action', 'https://mhotel2.lottejtb.com:44011/reserve/reserve_paymentlottejtb.asp');
    	resultPopPayment.submit();
    	
    }
	});
</script>
</head>
<body>

<!-- 결제완료 시작 -->
<c:if test="${!empty paymentReturnVo}">
 	<form id="resultPopPayment">
 		<input type="hidden" name="resultKind" value="SR" />
		<input type="hidden" name="resultCode" value="${resultCode }" />
		<input type="hidden" name="tId" value="${resultTid }" />
		<input type="hidden" name="cardCode" value="${cardCode }" />
		<input type="hidden" name="price" value="${price }" />
		<input type="hidden" name="fitRsvNo" value="${rsvSeqNo }" />
		<input type="hidden" name="hotelpassData" value="${hotelpassData }" />
 	</form>
</c:if>
<!-- 결제완료 끝 -->