<%@page import="com.lottejtb.comm.util.*"%>
<%@page import="java.util.Properties" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html lang="en">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<head>   

	<%
	String accessCheck = request.getHeader("X-Requested-With"); 
	%>
</head>

<script>
	var expire = new Date();
	expire.setDate(expire.getDate());
	cookies = "onCallYn" + '=' + escape(null) + '; path=/ ';
	document.cookie = cookies;
	
	cookies = "appDownYN" + '=' + escape(null) + '; path=/ ';
	document.cookie = cookies;
	
</script>
<style>
#img_access{
 	width:100%; 
 	text-align:center;
}
</style>
<body style="margin:0;">

	<div class="img_access" id="img_access" style="display:none;">
			<img src="/resources/images/bg/appAccessYN.jpg" onclick="javascript:fn_accessYN();" id="accImg"/>
	</div>
	
	<div id="img_intro" style="display:none;">
		<img src="/resources/images/bg/intro.jpg" width="100%" />
	</div>
</body>

<script type="text/javascript">

//[JEH] 앱 최초실행시 접근권한 팝업 open 20180713
var accessType = "browser";

var accessCheck = "<%=CommUtil.filterXSS(accessCheck)%>";
var userAgent = window.navigator.userAgent.toLowerCase();
var safari = /safari/.test(userAgent);
var ios = /iphone|ipod|ipad/.test(userAgent);
var android = /android/.test(userAgent);

if(ios) {
	if(!safari) {
		accessType = "app";
	}
}else if(android){
	if(accessCheck == 'com.lottejtb.mobile'){
		accessType = "appAnd";
	}
};



var accessYN = getCookieValue("accessYN");

var img_access = document.getElementById("img_access");
var img_intro = document.getElementById("img_intro");
var accImg = document.getElementById("accImg");

// accessType = "app";
if(accessType == "appAnd"){
	fn_chkAccessYN();
}else{
	img_access.style.display = "none";
	img_intro.style.display = "block";
	
	setTimeout(function(){
		location.href = "/main.do";
	}, 2000);
}

function fn_chkAccessYN(){

	if(accessYN == "Y"){
		img_access.style.display = "none";
		img_intro.style.display = "block";
		
		setTimeout(function(){
			location.href = "/main.do";
		}, 2000);
		
	}else{
		img_intro.style.display = "none";
		img_access.style.display = "block";	

		document.body.style.background = "rgba(0,0,0, 0.4)";
		
		var winW = window.outerWidth;
		
		var winh = window.outerHeight;
		var poph = "362";
		var wpcenter = winh/2 - poph/2;

		img_access.style.paddingTop = wpcenter+"px";
		accImg.style.width = winW-50+"px";
		
		
	}

}

function fn_accessYN(){
	setCookieValue("accessYN", "Y", "");
	
	img_access.style.display = "none";
	img_intro.style.display = "block";
	
	setTimeout(function(){
		location.href = "/main.do";
	}, 2000);
	
}

function setCookieValue(cName, cValue, domain){
    var expire = new Date();
    expire.setDate(expire.getDate());
    
    if(domain != ""){
    	cookies = cName + '=' + escape(cValue) + '; path=/; domain='+ domain; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
    }else{
    	cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
    }
    
    document.cookie = cookies;
//     console.log(document.cookie);
    
}

function getCookieValue(cName) {
    cName = cName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cName);
    var cValue = '';
    if(start != -1){
        start += cName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cValue = cookieData.substring(start, end);
    }
    return unescape(cValue);
}

</script>
</html>
