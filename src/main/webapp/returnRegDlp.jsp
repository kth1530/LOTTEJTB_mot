<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%


		
		String a ="";
		String b ="";
		String c ="";
		String setkey ="";
		setkey = request.getParameter("setkey");
		a = request.getParameter("a");
		b = request.getParameter("b");
		c = request.getParameter("c");
%>    
<!-- script type="text/javascript" src="/js/js2015/jquery-1.11.0.min.js"></script -->






<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.net.URLDecoder"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<iframe width="800" height="500" name="lpayFrame" frameborder="1"></iframe>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>LPAY거래인증DLP</title>
</head>
<body style="height: 208px; width: 1227px">

</body>
</html>
<form id="returdlp" name="returdlp"  method="post" target="_self" >
<input type="hidden" id="data" name="data" value=''/>
</form>

<!--  Lpay 개발
 <script type="text/javascript" src="https://dev-www.lpay.com:4432/dlp/wr/auth/js/jquery.min.js"></script> 	
 <script type="text/javascript" src="https://dev-www.lpay.com:4432/dlp/wr/auth/js/authDlpClass.js"></script> 
  -->  
<!--  Lpay 검증계  -->
 <script type="text/javascript" src="https://dev-www.lpay.com:4431/dlp/wr/auth/js/jquery.min.js"></script> 	
 <script type="text/javascript" src="https://dev-www.lpay.com:4431/dlp/wr/auth/js/authDlpClass.js"></script> 











<script type="text/javascript">
function callbackFunction ( result ){

	parent.returnRegDlp(result.RESULT_VAL);
}

// 실행함수 설정 예시
function  callLpayAuthCall() { 

    lpayment.iframeName  = "lpayFrame"; 		         // DLP창 Name
    paymentMethodCallBackFunctionName = "callbackFunction"; // DLP 콜백 호출 함수
    
    lpayment.putMsg('a', '<%=a%>'); 	        // 요청구분코드
    lpayment.putMsg('b', '<%=b%>'); 	        //  인증요청타입코드
    lpayment.putMsg('c', '<%=c%>');		        //  가맹점ID(암호화X)
    lpayment.setKey('<%=setkey%>');	         // AES로 암호화한 SEED Key
    
    lpayment.callpaymentReqdlp();
    
 } 




window.addEventListener("load", function(){callLpayAuthCall(); }); 


</script>

