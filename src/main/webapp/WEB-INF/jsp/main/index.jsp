<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="decorator" content="default"/>
<title></title>

<script type = "text/javascript">

	//require(["jquery","jquery.blockUI"], function($){
	//require(["jquery","jquery.blockUI","jquery.mobile"], function($){
     $(function() {
    	$('#loginbtn').on("click touchstart", function() {
 			document.location.href= ctx + "/sso/loginChk.do";	
 		});
    	 
    	$("#plan_btn").on("click touchstart", function () {
			document.location.href= ctx + "/planning/planning.do";	
		});
		
		$('#event').on("click touchstart", function() {
			document.location.href= ctx + "/event/event_list.do";	
		});
		
	});
	
</script>
</head>
<body>
메인 
<input type="button" id="loginbtn" value="로그인"/></br>
<input type="button" id="plan_btn" value="기획전"/></br>
<input type="button" id="event" value="이벤트"/></br>
<div id="title1"></div></br></br>
<div id="title2"></div></br></br>
<div id="title3"></div></br></br>
</body>
</html>