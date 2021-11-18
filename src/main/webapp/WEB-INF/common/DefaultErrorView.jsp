<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./commTagLib.jsp"%>
<%
/* 
String ServerName = request.getServerName();
String domain_header = ServerName.substring(0,3);
if ( "192".equals(domain_header) ||
	 "loc".equals(domain_header) || 
	 "www".equals(domain_header) || 
	 "bit".equals(domain_header) ){
	RequestDispatcher dispatcher = request.getSession().getServletContext().getRequestDispatcher("/common/error.jsp");
	dispatcher.forward(request,response);
	//response.sendRedirect("/common/error.jsp");
}
response.setStatus(200);
 */
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!--[if ie]> 
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<![endif]-->
	<meta name="Description" content="">
	<meta name="keywords" content="">
	<meta name="Author" content="yul">
	<meta name="generator" content="2013-02-04">
	<link rel="stylesheet" href="<c:url value='/common/css/error.css' />" />
	<title>Error Messege</title>
	<link rel="stylesheet" type="text/css" href="https://www.lottejtb.com/css/css2015/import.css" media="all" />
	<link rel="stylesheet" type="text/css" href="https://www.lottejtb.com/css/css2015/style.css" media="all" />
	<script type="text/javascript" src="https://www.lottejtb.com/js/js2015/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="https://www.lottejtb.com/js/js2015jquery.bxslider.min.js"></script>
	<script type="text/javascript" src="https://www.lottejtb.com/js/js2015/common.js"></script>
	<!-- 모달팝업 사용하는 페이지에만 넣어주세요 -->
	<script type='text/javascript' src="https://www.lottejtb.com/js/jquery.modal.js"></script>
	<style>
	.pop_text02 {
	    font-size: 1.5em;
	}
	</style>
</head>

<body>
	<!-- 모바일페이지 에러 -->
		<div style="width:100%; margin:auto; padding-top:100px;" align="center">
			<img src="http://www.lottejtb.com/images/mobile/1911_mobileerror/191122_img_01.jpg" width="100%" alt="롯데제이티비 고객님, 이용에 불편을 드려서 죄송합니다." />
			
			
			<p class="pop_text02">
				현재 어플리케이션에 일시적으로 문제가 발생하였습니다.<br /> 
				지속적으로 문제 발생 시 문의 부탁 드립니다.<br />
				<a href="mailto:webmaster@lottejtb.com">[webmaster@lottejtb.com]</a><br />
				보다 나은 서비스를 위해 노력하겠습니다.<br />
				
			</p>
             
		    
</div>

</body>
</html>