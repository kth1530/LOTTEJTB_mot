<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.lottejtb.front.air.service.*" %>
<%@ page import="com.lottejtb.comm.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<head>
<script src="/resources/common/js/fit/pay.js"></script>
<script src="/resources/common/js/fit/common.js"></script>
<script type="text/javascript" src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
<script type="text/javascript">
$(document).ready(function(){
	var submitform3 = $('form[ft-att="form3"]');
	var merchantDataVal	=	"";
	
	merchantDataVal	=	$('input[name="fitRsvNo"]').val();									//	호텔패스 예약번호
  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="hotelpassData"]').val();		//	호텔패스 Data
  				
  	submitform3.find("#P_NOTI").val(encodeURIComponent(merchantDataVal));
	
	document.getElementById("form3").submit();

});
</script>
</head>
<body>

	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
			<!-- 버튼 -->
			<div class="btn_one air_tbtn addbtn2">
				<button class="purple2" data-role="none" id="btnPayment">결제하기</button>
			</div>
			<div class="btn_one air_tbtn">
				<button class="white2" data-role="none" onclick="pageBack();">취소하기</button>
			</div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	<!--//content-->

<meta http-equiv="Content-Type" content="text/html;charset=euc-kr"/>
<!-- 2트렌 신용카드-->
<form id="form3" name="form3" method="post" accept-charset="euc-kr" action="https://mobile.inicis.com/smart/wcard/" ft-att="form3">
<input type="hidden" name="P_MID" id="P_MID" value="${mId }" />
<input type="hidden" name="P_OID" id="P_OID" value="${oId }" />
<input type="hidden" name="P_AMT" id="P_AMT" value="${price }" />
<input type="hidden" name="P_UNAME" id="P_UNAME" value="${buyerName }" />
<input type="hidden" name="P_GOODS" id="P_GOODS" value="롯데제이티비 호텔예약" />
<input type="hidden" name="P_NEXT_URL" id="P_NEXT_URL" value="https://m.lottejtb.com/free/account/paymentReturns.do" />
<input type="hidden" name="P_NOTI_URL" id="P_NOTI_URL" value="https://fit.lottejtb.com/payment/vacct/depoNoti.do" />
<input type="hidden" name="P_RETURN_URL" id="P_RETURN_URL" value="https://m.lottejtb.com/free/account/paymentReturns.do" />
<input type="hidden" name="P_TAX" id="P_TAX" value="0" />
<input type="hidden" name="P_RESERVED" id="P_RESERVED" value="twotrs_isp=Y&block_isp=Y&twotrs_isp_noti=N&apprun_check=N&auth_charset=utf8" />
<input type="hidden" name="P_QUOTABASE" id="P_QUOTABASE" value="01:02:03:04:05:06:07:08:09:10:11:12:13:14:15:16:17:18:19:20:21:22:23:24:25:26:27:28:29:30:31:32:33:34:35:36" />
<input type="hidden" name="P_NOTI" id="P_NOTI" value="" />
<input type="hidden" name="P_MOBILE" id="P_MOBILE" value="${buyerTel }" />
<input type="hidden" name="P_EMAIL" id="P_EMAIL" value="${buyerEmail }" />
<input type="hidden" name="fitRsvNo" id="fitRsvNo" value="${fitRsvNo }" />
<input type="hidden" name="hotelpassData" id="hotelpassData" value="${hotelpassData }" />

<input type="button" onclick="formSubmit();" />
</form>