<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%
	String loginid = request.getParameter("id");
	String password = request.getParameter("pw");
	password = URLDecoder.decode(password, "UTF-8");//비밀번호중 #문자가 포함될경우 공백으로 치환되는 경우가 있어서 encode,decode를 통하여 로그인 비밀번호를 얻어온다.
	String returnurl = request.getParameter("returnurl");
	StringBuffer returntest = new StringBuffer();
	returntest = request.getRequestURL();
	String sid = request.getParameter("sid");
	
	System.out.println("loginid=" + loginid);
	System.out.println("password=" + password);
	System.out.println("returnurl=" + returnurl);
	System.out.println("returntest1=" + returntest);
	System.out.println("returntest2=" + request.getRequestURL());
	System.out.println("sid=" + sid);
	//String dom = "https://testmembers.lpoint.com:500";
	//String clntAkInf = SsoServerLibrary.generateClntAkInf();  // 클라이언트요청정보

%>
</head>
<body>
<form name="frm" method="post"> 
		<input type="hidden" name="loginid" value="<%=loginid%>"/>
		<input type="hidden" name="password" value="<%=password%>"/>
		<input type="hidden" name="returnurl" value="<%=returnurl%>"/>
		<input type="hidden" name="sid" value="<%=sid%>"/>
</form>
<script language="javascript">
	
	//if(devType == 0)  { //개발
	//	document.frm.action = "https://testmember.lpoint.com/door/sso/authMblUser.jsp";
	
	//	console.log("dev~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	//}
	//else {
	//	document.frm.action = "https://member.lpoint.com/door/sso/authMblUser.jsp";
	//	console.log("real~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	//}
	//document.frm.action =   "https://security.lottejtb.com/jsp/sso/loginProcess_test_dev_mobile.jsp";
	document.frm.action = "https://security.lottejtb.com/jsp/sso/loginProcess_real_mobile.jsp"; 
	document.frm.submit(); 

</script>
</body>
</html>