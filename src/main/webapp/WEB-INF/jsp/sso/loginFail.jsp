<%@ page import="java.net.URLDecoder" %>
<%@page import="com.lottejtb.comm.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<title></title>
</head>
<body>
<%
	String mLoginFailUrl = "";
	String returnurl = request.getParameter("returnurl");
	if(returnurl != null)
		returnurl = URLDecoder.decode(returnurl, "UTF-8"); 
			
	if ( returnurl != null && "".equals(returnurl)) {
		returnurl = URLDecoder.decode(returnurl);
	}	
	String popup = request.getParameter("popup");
	
	if ( popup == null)
		popup = "";
	if ( returnurl == null)
		returnurl = "";
	
	try {
		if(returnurl != "") {
			mLoginFailUrl = returnurl.substring(0 ,25);
		}	
	} catch(Exception e) {
		//e.printStackTrace();
		System.err.println("SubString Error!");
	} 
		
		
%>
<script language="javascript">


	<%	
	// 팝업 로그인은 www.lottejtb.com 에서만 가능 
	if ( "Y".equals(popup) ) {
	%>
		window.localStorage.removeItem('autoLogin');
		window.localStorage.removeItem('ACCESSINFO');
		alert("죄송합니다. 로그인 정보가 없습니다.\n다시 한번 확인하시고 입력해 주시기 바랍니다.");
		if(devType == 0) //개발
			document.location.href = "http://mdev.lottejtb.com/jsp/sso/login_popup.jsp?returnurl=<%=CommUtil.filterXSS(returnurl)%>";
		else
			document.location.href = "https://m.lottejtb.com/jsp/sso/login_popup.jsp?returnurl=<%=CommUtil.filterXSS(returnurl)%>";
	<%
	//
	// mobile login fail 추가
	}  else if("http://m.air.lottejtb.com".equals(mLoginFailUrl)) {	                        
	%>
		window.localStorage.removeItem('autoLogin');
		window.localStorage.removeItem('ACCESSINFO');
		document.location.href = "http://m.air.lottejtb.com/air/mobile/mobile/setting.html?loginfail=true";
	
	<%
	}
	else {
	%>
		window.localStorage.removeItem('autoLogin');
		window.localStorage.removeItem('ACCESSINFO');
		setAlert("죄송합니다. 로그인 정보가 없습니다.\n다시 한번 확인하시고 입력해 주시기 바랍니다..");
		if(devType == 0) //개발
			document.location.href = "http://mdev.lottejtb.com/sso/loginChk.do?returnurl=<%=CommUtil.filterXSS(returnurl)%>";
		else
			document.location.href = "http://m.lottejtb.com/sso/loginChk.do?returnurl=<%=CommUtil.filterXSS(returnurl)%>";
				
	<%
	} 	
%>	

</script>

</body>
</html>