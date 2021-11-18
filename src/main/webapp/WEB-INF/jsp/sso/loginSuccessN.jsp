<%@page import="com.lottejtb.sso.service.CookieInfoVO"%>
<%@page import="org.codehaus.jackson.map.deser.std.FromStringDeserializer.URLDeserializer"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.sun.star.util.URL"%>
<%@page import="com.lottejtb.sso.service.LoginVO"%>
<%@page import="com.lottejtb.comm.util.*"%>
<%@page import="com.lotte.member.bean.ctm.secure.*" %> 
<%@page import="java.net.URLEncoder"%>
<%@page import="sun.misc.BASE64Decoder" %>
<%@page import="java.util.Properties" %>
<%@page import="java.io.FileInputStream" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Locale" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.nio.charset.Charset" %>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<title></title>
<%


String onlcno    = request.getParameter("onlcno");
String cno       = request.getParameter("cno");
String acesTkn   = request.getParameter("acesTkn");
String returnUrl = request.getParameter("returnUrl");
//String returnurl = (String)request.getAttribute("returnUrl");
String returnurl = request.getParameter("returnUrl");
String loginId   = request.getParameter("loginId");
String username  = request.getParameter("username");
String email     = request.getParameter("email");
String onl_cno    = request.getParameter("onlcno");

Cookie cu = new Cookie("onl_cno",onlcno);
Cookie du = new Cookie("onl_id",onlcno);
Cookie eu = new Cookie("acesTkn",acesTkn);
Cookie fu = new Cookie("mbrCno",cno);
Cookie gu = new Cookie("onlcno",onlcno);
Cookie hu = new Cookie("onl_cno",onlcno);
response.addCookie(cu);
response.addCookie(du);
response.addCookie(eu);
response.addCookie(fu);
response.addCookie(gu);
response.addCookie(hu);

System.out.println("onlcno:"+onlcno);
System.out.println("loginId:"+loginId);
System.out.println("username:"+username);
System.out.println("email:"+email);
System.out.println("onl_cno:"+onl_cno);
System.out.println("returnUrl:"+returnUrl);
System.out.println("returnurl:"+returnurl);
 
%>
<script language="javascript">
	function setCookieTop( cookieName, cookieValue, expireDate )
	{
		var today = new Date();
		today.setDate( today.getDate() + parseInt( expireDate ) );
		document.cookie = cookieName + "=" + escape( cookieValue ) + "; path=/; ";
		document.cookie = cookieName + "=" + escape( cookieValue ) + "; path=/; domain=.lottejtb.com;";
	}
	
	function getCookieTop(uName) {
		var flag = document.cookie.indexOf(uName+'=');
		if (flag != -1) {
			flag += uName.length + 1
			end = document.cookie.indexOf(';', flag)
		if (end == -1) end = document.cookie.length
			return unescape(document.cookie.substring(flag, end))
		}else {
			return '';
		}
	}

	//고객번호 ~~~~~~~~~~~
	var ocno = getCookieTop("onl_cno");
	setCookieTop("cust_id", ocno, "");
	var onlcno = getCookieTop("onl_cno");
	setCookieTop("onlcno", onlcno, "");
	var onl_cno = getCookieTop("onl_cno");
	setCookieTop("onl_cno", onl_cno, "")	
	//로그인ID
	var id = getCookieTop("onl_id");
	setCookieTop("login_id", id, "");
	var acesTkn = getCookieTop("acesTkn");
	setCookieTop("acesTkn", acesTkn, "");
	var mbrCno = getCookieTop("mbrCno");
	setCookieTop("mbrCno", mbrCno, "");
	//멤버스번호
	var inf_clng_yn = getCookieTop("inf_clng_yn");
	
	if(inf_clng_yn == "x6qDBrN3DkQEArZh1dZlDA%3D%3D"){ 
		setCookieTop("desc_inf_clng_yn", "Y", "");
	} else {
		setCookieTop("desc_inf_clng_yn", "N", "");
	}

	function eraseCookie(key)
	{
		var cookieDate = new Date(2000,11,19,30,30);
		document.cookie = key + "= ; expires="+cookieDate.toGMTString()+"; path=/";
	}

</script>

</head>
<body>
<P>
	
<%

//	private final Charset UTF8_CHARSET = Charset.forName("UTF-8");

	String t_personal_no="";
	String t_login_id ="";
	String t_age="";
	String t_sex="";
	String t_year="";
	String t_cust_id="";
	String t_username="";
	String t_email = "";
	String pop_login_yn = "";
	String t_mbr_custno ="";
	String t_mbl_no = "";
	String t_inf_clng_yn ="";
	int n_age=0;
	String t_marry_fg = "";
	String t_cno = "";
	String t_cust_type = "";
	
	String d_cust_id = "";
	String d_login_id = "";
	String d_username = "";
	String d_email = "";
	String d_personal_no = "";
	String d_inf_clng_yn = "";
	String d_cust_type = "";
	String d_marry_fg = "";
	String d_mbr_custno = "";
	String d_mbl_no = "";
	String d_cno = "";

	try {
			t_cust_id = onlcno;
			d_cust_id = onlcno;
			t_cno = cno;
			d_cno = cno;
	}
	catch ( Exception e ) {
		System.out.println("IEMASTER FAILED.." +"Lotte ID is: " + t_cust_id.trim());
				
	} 
%> 


<script type="text/javascript">

$(document).ready(function() {
<%
	System.out.println("****************");
	System.out.println(t_cust_id);
	System.out.println("****************"); 
	if(t_cust_id.trim() == null || t_cust_id.trim() == "") {  
		t_cust_id = onlcno;
		d_cust_id = onlcno;
		t_cno = onlcno;
		d_cno = onlcno;
    }
	if(t_cust_id.trim() == null || t_cust_id.trim() == "") {  
%> 
	setAlert("정상적인 로그인 정보를 얻어올 수 없습니다.\n 브라우저 설정의 쿠키허용을 확인해 주시기 바랍니다.");
     if(devType == 0)
     	document.location.href = "http://mdev.lottejtb.com";
     else
    	document.location.href = "http://m.lottejtb.com";
<%
	} else {
%>
	 fn_loginData();  //로그인 로직
<%
	}
%>	 
});

//cookie값 저장데이터
var fn_loginData = function() {

	//[JEH] login log - 20180308
	 fnLoginLog('<%=onlcno%>'); 
	
	if(window.localStorage.getItem('autoLogin') == 'Y'){
		var lotteJtbCookies = {
			'cst_nm'				: '<%=CommUtil.filterXSS(d_username)%>',
			'prv_ag_dt'				: getCookieTop("prv_ag_dt"),
			'prv_ag_dc'				: getCookieTop("prv_ag_dc"),
			'bf_onl_id'				: getCookieTop("bf_onl_id"),
			'bf_onl_id_ch_dtti'		: getCookieTop("bf_onl_id_ch_dtti"),
			'cco_optin_ml'			: getCookieTop("cco_optin_ml"),
			'cco_optin_ml_dtti'		: getCookieTop("cco_optin_ml_dtti"),
			'cco_optin_sms'			: getCookieTop("cco_optin_sms"),
			'cco_optin_sms_dtti'	: getCookieTop("cco_optin_sms_dtti"),
			'inf_clng_yn'			: getCookieTop("inf_clng_yn"),
			'personal_no'			: '<%=CommUtil.filterXSS(d_personal_no)%>',
			'cno'					: '<%=CommUtil.filterXSS(d_cno)%>',
			'onl_id'				: '<%=CommUtil.filterXSS(d_login_id)%>',
			'onl_cst_dc'			: getCookieTop("onl_cst_dc"),
			'elc_add'				: '<%=CommUtil.filterXSS(d_email)%>',
			'mbl_no'				: '<%=CommUtil.filterXSS(d_mbl_no)%>',
			'onl_cno'				: '<%=onlcno%>',
			'onlcno'				: '<%=onlcno%>',
		}

		var mLotteJtbCookies = {
			'desc_inf_clng_yn'		: getCookieTop("desc_inf_clng_yn"),
			'login_id'				: '<%=CommUtil.filterXSS(d_login_id)%>',
			'mbl_no'				: '<%=CommUtil.filterXSS(d_mbl_no)%>',
			'cust_id'				: '<%=CommUtil.filterXSS(d_cust_id)%>',
			'mbr_cust_no'			: '<%=CommUtil.filterXSS(d_mbr_custno)%>',
			'cust_type'				: '<%=CommUtil.filterXSS(d_cust_type)%>',
			'desc_inf_clng_yn1'		: getCookieTop("desc_inf_clng_yn1"),
			'email'					: '<%=CommUtil.filterXSS(d_email)%>',
			'username'				: '<%=CommUtil.filterXSS(d_username)%>',
			'onlcno'				: '<%=onlcno%>',
			'onl_cno'				: '<%=onlcno%>'
		}
		
		window.localStorage.setItem("lmInfo", JSON.stringify(lotteJtbCookies));
		window.localStorage.setItem("ljInfo", JSON.stringify(mLotteJtbCookies));
	}
	
	var deviceUUID = "";
	
	if(nullToBlank(deviceInfo) != ""){
		deviceUUID = deviceInfo.uuid;
	}
	
	var formData = new FormData();
	formData.append('cust_id','<%=onlcno%>');
	formData.append('knm','<%=username%>');
	formData.append('id','<%=loginId%>');
	formData.append('email','<%=email%>');
	formData.append('sex','<%=CommUtil.filterXSS(t_sex.trim())%>');
	formData.append('mblNo', '<%=CommUtil.filterXSS(t_mbl_no.trim())%>');
	formData.append('mbrCustno', '<%=CommUtil.filterXSS(t_mbr_custno.trim())%>');
	formData.append('custGradeCd', '<%=CommUtil.filterXSS(t_cust_type.trim())%>');
	formData.append('cno', getCookieTop("mbrCno")); 
	formData.append('deviceId', deviceUUID);

	cfn_ajax({
		type : "POST",
		async : false,
		url: "/cookie/cookieSaveDataAjax.do",
		data: formData,
		dataType: "json",
		cache : false,
		noloading : "yes",
		timeOut : 5 * 60 * 1000,
		success: function(data) {
			var list = data.cookieData;
						
			<%
			//returnurl = (String)request.getAttribute("returnurl");
			
			if(returnurl != null){
				returnurl = URLDecoder.decode(returnurl, "UTF-8");
				System.out.println("returnurl3333333333333333333333333333=" + returnurl);
			}
						
			// 리턴 페이지가 없을때
			if ( returnurl == null || returnurl.equals("") || returnurl.indexOf("/jsp/sso/loginSuccess.do") > -1 || returnurl.indexOf("/sso/loginChk.do") > -1 || returnurl.indexOf("/sso/loginProcess.do") > -1) { 
			%>
				if(devType == 0){	
					document.location.href = 'http://mdev.lottejtb.com/';
				}
				else{
					System.out.println("returnurlAAAAAAAAAAAAAAAAAAAAAAAAAA=" + returnurl);
					document.location.href = 'http://m.lottejtb.com/';
			
			<%
			} else if ( returnurl.indexOf("dht.lottejtb.com") > -1 ) {
				// 호텔엔조이(국내숙박) 관련
				//returnurl = URLEncoder.encode(returnurl);
				System.out.println("returnurl44444444444444444444444444444444444444=" + returnurl);
			%>
			<%System.out.println("returnurl555555555555555555555555555555555555555555=" + returnurl);%>
			document.location.href = 'http://m.lottejtb.com/jsp/sso/dht_login.do?returnurl=<%=returnurl%>';
			
				//document.location.href = 'http://m.lottejtb.com/domestic/dmt_detail_domestic.do?url=http://dht.lottejtb.com/alliance/mobile/main.php?AID=LTJTB&ctgname=국내숙소';
				//alert("서비스 준비중 입니다");
			<%	
			}else if ( returnurl.indexOf("m.air.lottejtb.com") > -1 || returnurl.indexOf("local.lottejtb.com") > -1 || returnurl.indexOf("renewal.lottejtb.com") > -1 || returnurl.indexOf("dev1.lottejtb.com") > -1) {
				System.out.println("returnurl66666666666666666666=" + returnurl);
				returnurl = URLDecoder.decode(returnurl);
			%>
			<%System.out.println("returnurl777777777777777777777777777777777777=" + returnurl);%>
				//document.location.href = decodeURIComponent('<%=returnurl%>');
				document.location.href = '<%=returnurl%>';
				
			<%	
			}
			// 일반 로그인
			else  {
			%>
			<%System.out.println("returnurl4888888888888888888888888888888888888888888=" + returnurl);%>
			console.log("returnUrl :" + '<%=returnurl%>');
				// 팝업 로그인
				if ( opener != null ) {

					//현재 주소에서 returnurl 파라미터만 읽음
					var return_url = document.location.href.split("=");
					var pop_login = "N";
					
					//네이버 통해서 들어온 경우(opener != null) 이기 때문에 분기 필요
					//==================================================
					for (var i=0; i<return_url.length; i++) {
						//마이투어 로그인 할 경우(바닥로그인)
						
						if (return_url[i].indexOf("security.lottejtb.com")>=0) {
							pop_login = "N"
							
						}
					}		
					//==================================================
					pop_login = '<%=CommUtil.filterXSS(pop_login_yn)%>';


					//팝업 로그인
					if(pop_login == "Y"){

						
						//쿠키삭제
						eraseCookie("pop_login_yn");
						
						if(opener != null)
							opener.location.reload();
						if(self != null)
							self.close();	
					//바닥 로그인
					}else{
						<%System.out.println("returnurlBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=" + returnurl);%>
						document.location.href = '<%=CommUtil.filterXSS(returnurl)%>';
						
					}
				}
				// 바닥 로그인
				else	{
					<%System.out.println("returnurlCCCCCCCCCCCCCCCCCCCCCCCCCC=" + returnurl);%>
					//document.location.href = '<%=CommUtil.filterXSS(returnurl)%>';
					var rrrr = "<%=CommUtil.filterXSS(returnurl)%>";
					var rrrr1 = rrrr.replace("&amp;","&");
					var rrrr2 = rrrr1.replace("&amp%3b","&");
					document.location.href = rrrr2;
					
				}
			<%
			}
			%>
			<%System.out.println("returnurl99999999999999999999999999999999999999=" + returnurl);%>
			document.location.href = '<%=returnurl%>';
			//document.location.href = 'https://m.lottejtb.com/main.do';
			
			
			var urltest = '<%=returnurl%>';
			
			if ( urltest.indexOf("m.air.lottejtb.com") > -1 ){
				
				<%System.out.println("AIROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO__"+returnurl);%>
				//document.location.href = 'https://m.lottejtb.com/main.do';
			}else{
				
				<%System.out.println("AIRXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX__"+returnurl);%>
				//document.location.href = '<%=returnurl%>';
			}
		    
			return;
			
		},
		error : function(err) {
			
			alert(err);
		
		},
		complete : function(e) {
			console.log(e);
			
		}
		
	});

	//[JEH] login log - 20180308
	 function fnLoginLog(cust_id){

		console.log("+++++++++++ login Success 111 ++++++++++++++");
		
		var formData = new FormData();
		formData.append('cust_id','<%=onlcno%>');
		formData.append('aceTkn','<%=acesTkn%>');
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/sso/loginLogInsertAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			success: function(data) {
				console.log('succ');					
			},
			error : function(err) {
				console.log('err : ' + err);			
			}
		});
	} 
	
};
 
</script>
 

</body>
</html>