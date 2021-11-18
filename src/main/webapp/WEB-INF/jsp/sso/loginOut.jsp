
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8" session="true"  pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.util.*"%>
<%@page import="com.lottejtb.comm.util.*"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 

<head>
<script src="<c:url value='/resources/common/js/facebook.js' />"></script>
<script src="<c:url value='/resources/common/js/naver.js' />"></script>
<script src="<c:url value='/resources/common/js/utils.js' />"></script> 
<title></title>
 
</head>
<body>
<%
		String returnurl = request.getParameter("returnurl");
		if(returnurl != null)
			returnurl = URLDecoder.decode(returnurl, "UTF-8");
		
		boolean reUrlFlag = false;
		if(returnurl == null || "".equals(returnurl) || returnurl.length() < 5) {
			reUrlFlag = true;
		}
		
	try {	// 국내 숙박(호텔 엔조이)용 쿠키 삭제 처리
	
		// 국내 숙박(호텔 엔조이)용 쿠키 삭제 처리
	/*  	Cookie dht_cust_id = new Cookie("dht_cust_id",  null);
	 	dht_cust_id.setDomain("m.lottejtb.com");
		dht_cust_id.setMaxAge(0);
		dht_cust_id.setPath("/");
		response.addCookie(dht_cust_id);
		
		Cookie dht_user_name = new Cookie("dht_user_name",  null);
		dht_user_name.setDomain("m.lottejtb.com");
		dht_user_name.setMaxAge(0);
		dht_user_name.setPath("/");
		response.addCookie(dht_user_name);
		
		Cookie dht_email = new Cookie("dht_email",  null);
		dht_email.setDomain("m.lottejtb.com");
		dht_email.setMaxAge(0);
		dht_email.setPath("/");
		response.addCookie(dht_email); */
		
		
		request.getSession().invalidate();
		
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++){
				// 쿠키를 읽어서 내가 본 상품인 경우 그대로 두고 나머지 쿠키는 모두 날린다.
				if (reUrlFlag && cookies[i].getName().indexOf("returnurl") != -1) {
					String agenturl = cookies[i].getValue();
					if(agenturl != null && !"".equals(agenturl) && agenturl.length() > 4){
						returnurl = agenturl;
						reUrlFlag = false;
					}
				}
				
				if(cookies[i].getName().indexOf("TODAY_EVENTS") == -1 && cookies[i].getName().indexOf("preUrl") == -1 && cookies[i].getName().indexOf("nowUrl") == -1 && cookies[i].getName().indexOf("appDownYN") == -1 && cookies[i].getName().indexOf("accessYN") == -1){
					Cookie tempCookie = new Cookie(cookies[i].getName(), null);
					//tempCookie.setDomain(cookies[i].getDomain());
					tempCookie.setMaxAge(0);
					tempCookie.setPath("/");
					
					System.out.println("Cookies Info - "+ tempCookie.getName() +" : "+ tempCookie.getValue() +":"+ tempCookie.getDomain());
					//cookies[i].setValue(null);
					response.addCookie(tempCookie);	
				}	
			}	
		}
		
	/* 	Cookie cust_id = new Cookie("cust_id",  null);
		//cust_id.setDomain("m.lottejtb.com");
		cust_id.setMaxAge(0);
		cust_id.setPath("/");
		response.addCookie(cust_id);
		 */
		// 자체 발행한 쿠키를 삭제
		/*
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++){
				// 쿠키를 읽어서 내가 본 상품인 경우 그대로 두고 나머지 쿠키는 모두 날린다.
				if (reUrlFlag && cookies[i].getName().indexOf("returnurl") != -1) {
					String agenturl = cookies[i].getValue();
					if(agenturl != null && !"".equals(agenturl) && agenturl.length() > 4){
						returnurl = agenturl;
						reUrlFlag = false;
					}
				}
	//	  		if ( cookies[i].getName().indexOf("TODAY_EVENTS") == -1) {
		  			//cookies[i].setDomain(null);
			  		cookies[i].setMaxAge(0);
					cookies[i].setValue(null);
					//cookies[i].setPath(null);
					response.addCookie(cookies[i]);
					
		//		}	
			}	
		}
		
		
		Cookie cust_id = new Cookie("cust_id",  null);
		cust_id.setDomain("m.lottejtb.com");
		cust_id.setMaxAge(0);
		cust_id.setPath("/");
		response.addCookie(cust_id);
		
		Cookie login_id = new Cookie("login_id",  null);
		login_id.setDomain("m.lottejtb.com");
		login_id.setMaxAge(0);
		login_id.setPath("/");
		response.addCookie(login_id);
		
		Cookie username = new Cookie("username",  null);
		username.setDomain("m.lottejtb.com");
		username.setMaxAge(0);
		username.setPath("/");
		response.addCookie(username);
		
		Cookie cust_type = new Cookie("cust_type",  null);
		cust_type.setDomain("m.lottejtb.com");
		cust_type.setMaxAge(0);
		cust_type.setPath("/");
		response.addCookie(cust_type);
		
		Cookie email = new Cookie("email",  null);
		email.setDomain("m.lottejtb.com");
		email.setMaxAge(0);
		email.setPath("/");
		response.addCookie(email);
		
		Cookie mbr_cust_no = new Cookie("mbr_cust_no",  null);
		mbr_cust_no.setDomain("m.lottejtb.com");
		mbr_cust_no.setMaxAge(0);
		mbr_cust_no.setPath("/");
		response.addCookie(mbr_cust_no);

		Cookie desc_inf_clng_yn = new Cookie("desc_inf_clng_yn",  null);
		desc_inf_clng_yn.setDomain("m.lottejtb.com");
		desc_inf_clng_yn.setMaxAge(0);
		desc_inf_clng_yn.setPath("/");
		response.addCookie(desc_inf_clng_yn);
		
		Cookie desc_inf_clng_yn1 = new Cookie("desc_inf_clng_yn1",  null);
		desc_inf_clng_yn1.setDomain("m.lottejtb.com");
		desc_inf_clng_yn1.setMaxAge(0);
		desc_inf_clng_yn1.setPath("/");
		response.addCookie(desc_inf_clng_yn1);
		

		System.out.println("cookies.length=" + cookies.length);
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++){
				// 쿠키를 읽어서 내가 본 상품인 경우 그대로 두고 나머지 쿠키는 모두 날린다.
		  		//if ( cookies[i].getName().indexOf("TODAY_EVENTS") == -1) {
					cookies[i].setDomain("m.lottejtb.com");
					cookies[i].setMaxAge(0);
					cookies[i].setValue(null);
					cookies[i].setPath("/");
					response.addCookie(cookies[i]);
				//}	
			}	
		} 
		*/
		
		
	/* 	// security 로 생성된 쿠키 삭제
		for(int i=0; i<cookies.length; i++){
			// 쿠키를 읽어서 내가 본 상품인 경우 그대로 두고 나머지 쿠키는 모두 날린다.
	  		if ( cookies[i].getName().indexOf("TODAY_EVENTS") == -1) {
				cookies[i].setDomain(".lottejtb.com");
				cookies[i].setMaxAge(0);
				cookies[i].setValue(null);
				cookies[i].setPath("/");
				response.addCookie(cookies[i]);
			}	
		}	
		
		
		for(int i=0; i<cookies.length; i++){
			// 쿠키를 읽어서 내가 본 상품인 경우 그대로 두고 나머지 쿠키는 모두 날린다.
	  		if ( cookies[i].getName().indexOf("TODAY_EVENTS") == -1) {
				cookies[i].setDomain(".m.lottejtb.com");
				cookies[i].setMaxAge(0);
				cookies[i].setValue(null);
				cookies[i].setPath("/");
				response.addCookie(cookies[i]);
			}	
		} */

		
		/* 		
		// 국내 숙박(호텔 엔조이)용 쿠키가 추가될 경우를 대비하여 쿠키 모두 삭제
		for(int i=0; i<cookies.length; i++){
			// 쿠키를 읽어서 내가 본 상품인 경우 그대로 두고 나머지 쿠키는 모두 날린다.
	  		if ( cookies[i].getName().indexOf("TODAY_EVENTS") == -1) {
				cookies[i].setDomain("dht.lottejtb.com");
				cookies[i].setMaxAge(0);
				cookies[i].setValue(null);
				cookies[i].setPath("/");
				response.addCookie(cookies[i]);
			}	
		}	
		
		for(int i=0; i<cookies.length; i++){
			// 쿠키를 읽어서 내가 본 상품인 경우 그대로 두고 나머지 쿠키는 모두 날린다.
	  		if ( cookies[i].getName().indexOf("TODAY_EVENTS") == -1) {
				cookies[i].setDomain("www.lottejtb.com");
				cookies[i].setMaxAge(0);
				cookies[i].setValue(null);
				cookies[i].setPath("/");
				response.addCookie(cookies[i]);
			}	
		}	 */
				
		// 개인화 관련 쿠키정보 삭제
		/* Cookie isOpen = new Cookie("isOpen",  null);
		isOpen.setMaxAge(0);
		isOpen.setPath("/");
		response.addCookie(isOpen); */
		
		HttpSession session1 = request.getSession(false);
		
		if(session1 != null) {
			//세션 초기화
			session1.setMaxInactiveInterval(0);
			session1.setAttribute("loginInfo", null);
			session1.invalidate();
		}
		
	} catch(Exception e) {
		//e.printStackTrace();
		System.err.println("session Error!");
	}
 %>
 <script>
	var getParameters = function (paramName) {
		// 리턴값을 위한 변수 선언
		var returnValue;
	
		// 현재 URL 가져오기
		var url = "<%=returnurl%>";
	
		// get 파라미터 값을 가져올 수 있는 ? 를 기점으로 slice 한 후 split 으로 나눔
		var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&');
	
		// 나누어진 값의 비교를 통해 paramName 으로 요청된 데이터의 값만 return
		for (var i = 0; i < parameters.length; i++) {
			var varName = parameters[i].split('=')[0];
			if (varName.toUpperCase() == paramName.toUpperCase()) {
				returnValue = parameters[i].split('=')[1];
				return decodeURIComponent(returnValue);
			}
		}
	};
	
 	window.localStorage.removeItem('autoLogin');
 	window.localStorage.removeItem('ljInfo');
 	window.localStorage.removeItem('lmInfo');

	 <%	
	  if(returnurl != null && !returnurl.equals("")){
		  if(returnurl.indexOf("m.lottejtb.com") > -1){
	  %>
				var KSESID = "";
				KSESID = getParameters("KSESID");
				
				if(KSESID != null || KSESID != "" || KSESID != "null"){
					KSESID = "air:b2c:SELK138AX:SELK138AX::00";
					document.location.href = "https://m.air.lottejtb.com/air/b2c/auth/logoutAction.k1?KSESID=" + KSESID + "&returnurl=https://m.lottejtb.com";	
				}
				
	  <%
		 }else if(returnurl.indexOf("m.air.lottejtb.com") > -1 || returnurl.indexOf("renewal.lottejtb.com") > -1 || returnurl.indexOf("local.lottejtb.com") > -1 || returnurl.indexOf("dev1.lottejtb.com") > -1){

		  String returnUrlAir = "";
		  String domain = "https://m.air.lottejtb.com";
			if(returnurl.indexOf("m.air.lottejtb.com") > -1){
				domain = "https://m.air.lottejtb.com";
			}else if(returnurl.indexOf("renewal.lottejtb.com") > -1){
				domain = "http://renewal.lottejtb.com:20000";
			}else if(returnurl.indexOf("local.lottejtb.com") > -1){
				domain = "http://local.lottejtb.com";
			}else if(returnurl.indexOf("dev1.lottejtb.com") > -1){
				domain = "http://dev1.lottejtb.com:20000";
			}
	 %>		
<%-- 		document.location.href = "http://air.lottejtb.com/air/b2c/auth/logoutAction.k1?KSESID=air:b2c:SELK138AX:SELK138AX::00&returnurl=<%=CommUtil.filterXSS(returnurl)%>";	 --%>
		document.location.href = <%=domain%> + "/air/b2c/auth/logoutAction.k1?KSESID=air:b2c:SELK138AX:SELK138AX::00&returnurl=<%=CommUtil.filterXSS(returnurl)%>";	
	 <%
	 }
	 else {
	 %>
 	
		if(devType == 0) {
	 		window.location.href = "http://mdev.lottejtb.com/index.jsp";
	 	} else {
	 		window.location.href = "http://m.lottejtb.com/index.jsp";	
	 	}
	 	
	 	
	 <%
	 } 	
		  }else{
	 %>
	 if(devType == 0) {
	 		window.location.href = "http://mdev.lottejtb.com/index.jsp";
	 	} else {
	 		window.location.href = "http://m.lottejtb.com/index.jsp";	
	 	}
	 	
	 	
	 <%
	 } 	
	 %>
</script>
</body>
</html>