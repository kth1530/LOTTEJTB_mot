<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html lang="en">
<head>
<script src="/resources/common/js/jquery-latest.min.js"></script> 
<%
String accessCheck = request.getHeader("X-Requested-With");
%>

<script>
/*
function getURL(){
	var url = location.href;
	var ArrUrl = url.split("//");
	url = ArrUrl[1].substr(0,ArrUrl[1].indexOf("/"));
	return url;
}
var host = getURL();
var loc = "/default.do";
if ( host == "localhost:9000" ){
	loc = "/default.do";
}
*/

var topCtg;
var httpsPage = ['/sso/', '/mytour/', '/reserve/'];
var httpFlages = false;
var accessType = "browser";
var deviceInfo;
var accessCheck = "<%=accessCheck%>";

var userAgent = window.navigator.userAgent.toLowerCase();
var safari = /safari/.test(userAgent);
var ios = /iphone|ipod|ipad/.test(userAgent);
var android = /android/.test(userAgent);

function nullCheck(message){
	message = message + '';

	if(message == 'undefined' || message == 'NULL' || message == 'null'){
		message = '';
	}

	return message;
}

if(ios) {
	if(!safari) {
		accessType = "app";
		document.write('<' + 'script src="/resources/cordova/ios/cordova.js"' + ' type="text/javascript"><' + '/script>');
		document.write('<' + 'script src="/resources/common/js/native.js"' + ' type="text/javascript"><' + '/script>');
	}
}else if(android){
	if(accessCheck == 'com.lottejtb.mobile'){
		accessType = "app";
		document.write('<' + 'script src="/resources/cordova/android/cordova.js"' + ' type="text/javascript"><' + '/script>');
		document.write('<' + 'script src="/resources/common/js/native.js"' + ' type="text/javascript"><' + '/script>');
	}
};

$("document").ready(function(){
	setTimeout(function(){
		if(accessType == "app" && nullCheck(deviceInfo.uuid) != "" && nullCheck(deviceInfo) != ""){
			var deviceModel = deviceInfo.model;
			var deviceUUID = deviceInfo.uuid;
			var deviceVersion = deviceInfo.version;
			var deviceToken = window.localStorage.getItem('tokenId');
			var deviceOsType = "";
			
			if(deviceInfo.platform.toUpperCase() == "ANDROID"){
				deviceOsType = "AND";
			}else if(deviceInfo.platform.toUpperCase() == "IOS"){
				deviceOsType = "IOS"
			}
			
			var formData = new FormData();
			formData.append('deviceId', deviceUUID);
			formData.append('deviceModel', deviceModel);
			formData.append('osVersion', deviceVersion);
			formData.append('deviceToken', deviceToken);
			formData.append('osType', deviceOsType);
			
			$.ajax({
				url: "/insertDeviceInfo.do", 
				type: "POST",
				data: formData,
				async: false,
				cache: false,
				dataType: "json",
				contentType: false,
			    processData: false,
				success : function(data, status) {
					window.location = "/main.do";
				},
				complete : function(data, status) {
				},
				error : function(jqXHR, textStatus, errorThrown) {
					window.location = "/main.do";
				}
			});
		}else{
			var expire = new Date();
		    expire.setDate(expire.getDate());
		    cookies = "appDownYN" + '=' + escape(null) + '; path=/ ';
		    document.cookie = cookies;
		    
			window.location = "/main.do";
		}
	}, 500);
});
</script>
</head>
<body>
	<img src="/resources/images/bg/intro.png" width="100%" />
</body>
</html>
