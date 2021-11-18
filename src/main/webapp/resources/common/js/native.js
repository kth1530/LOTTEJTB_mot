/**
 * cordova plugin Function
 */

var clickCount = 0;
var isFlag = false;

document.addEventListener("deviceready", function(){
	if(window.MobileAccessibility){
		window.MobileAccessibility.usePreferredTextZoom(false);
	}
	
	deviceInfo = device;
	
	if(nullToBlank(window.plugins.pushNotification) != ""){
		if(device.platform.toUpperCase() == 'ANDROID'){
			window.plugins.pushNotification.register(successHandler,errorHandler, {
				"senderID" : "1056462049853", // Google GCM 서비스에서 생성한 Project Number를 입력한다.
				"ecb" : "onNotificationGCM" // 디바이스로 푸시가 오면 onNotificationGCM 함수를 실행할 수 있도록 ecb(event callback)에 등록한다.
			});
			
			setTimeout(function(){
				cordova.getAppVersion.getVersionNumber(function (version) {
//					if(version == "1.0.4" || version == "1.0.5"){
				    if(version == "1.0.8"){	//[JEH]앱 재배포로 인한 버전 업그레이드
				    	
				    }else{
						alert("새로운 버전이 출시되었습니다. 앱을 업데이트 해주세요.", "알림");
				    	
				    	location.href = "market://details?id=com.lottejtb.mobile";
					}
				});
			}, 200);
		} else {
	        // PushPlugin을 설치했다면 window.plugins.pushNotification.register를 이용해서 iOS 푸시 서비스를 등록한다.
			window.plugins.pushNotification.register(tokenHandler, errorHandler, {
				"badge":"true", // 뱃지 기능을 사용한다.
				"sound":"true", // 사운드를 사용한다.
				"alert":"true", // alert를 사용한다.
				"ecb": "onNotificationAPN" // 디바이스로 푸시가 오면 onNotificationAPN 함수를 실행할 수 있도록 ecb(event callback)에 등록한다.
			});
		}
	}
	
	setTimeout(function(){
		document.removeEventListener("backbutton", fn_backButtonFunc, false);
		document.addEventListener('backbutton', fn_backButtonFunc, false);
	}, 200);
	
	
	/*
	navigator.Backbutton.goBack(function() {
		console.log('backButton');
		if(clickCount == 1){
			var isFlag = true;
			clickCount = 0;
			
			var msg = "어플을 종료 하시겠습니까?";

			try{
				setConfirm(msg, navigator.app.exitApp, function(){return false;}, "알림", "예", "아니오");
			}catch(e){
				console.log(e);
			}
			
			return false;
		}else{
			clickCount++;
			setTimeout(function(){
				if(clickCount == 1 && !isFlag){	
					isFlag = false;
					history.back();
				}
				
				clickCount = 0;
			}, 300);
		}
	}, function() {
	  console.log('fail')
	});
	*/
});

function fn_backButtonFunc(){

	if(clickCount == 1){
		var isFlag = true;
		clickCount = 0;
		
		var msg = "어플을 종료 하시겠습니까?";

		try{
			setConfirm(msg, navigator.app.exitApp, function(){return false;}, "알림", "예", "아니오");
		}catch(e){
			console.log(e);
		}
		
		return false;
	}else{
		clickCount++;
		setTimeout(function(){
			if(clickCount == 1 && !isFlag){	
				isFlag = false;
				history.back();
			}
			
			clickCount = 0;
		}, 300);
	}
};

/**
 * tokenHandler
 *
 * @param result
 *
 * 디바이스 토큰핸들러 콜백함수.
 * 푸시 서비스를 활성화 하였을 때, window.plugins.pushNotification.register 메소드가 실행되면서 디바이스 토큰을 가져와서 출력한다.
 * 만약에 푸시 서버로 디바이스 토큰을 보내야할 경우 이 함수 안에서 서버로 디바이스 토큰을 전송하면 된다.
 */
function tokenHandler(result){
	window.localStorage.setItem('tokenId', result);
	insertDeviceInfo(result)
}

/**
 * errorHandler
 *
 * @param err
 *
 * 에러 핸들러 콜백 함수.
 */
function errorHandler(err){
	console.log('error:' + err);
	insertDeviceInfo(null);
}

/**
 * successHandler
 *
 * @param result
 *
 * 디바이스로 푸시 메세지를 받았을 때 뱃지처리 이후 호출하는 콜백함수
 */
function successHandler(result){
	console.log('result:'+result);
}

/**
 * onNotificationAPN
 *
 * @param event
 *
 * iOS 디바이스로 푸시 메세지를 받을 때 호출되는 콜백함수, window.plugins.pushNotification.register 옵션 설정에서 ecb의 이름에 매칭된다.
 */
function onNotificationAPN (event){
	// 푸시 메세지에 alert 값이 있을 경우
	if (event.alert){
		//navigator.notification.alert(event.alert);
		//if(event.forground == "0") {
		//window.location.href= event.tagetUrl;
			navigator.notification.alert(event.alert,
					 function() {
						alertDismissed(event.tagetUrl)
					 },
					 '알림', 
					 'OK');
					 
////			navigator.notification.alert(event.alert);
		//}
	}

	// 푸시 메세지에 bage 값이 있을 경우
	if (event.badge){
		window.plugins.pushNotification.setApplicationIconBadgeNumber(successHandler, errorHandler, event.badge);
	}
}

/**
 * onNotificationGCM
 *
 * @param e
 *
 * 안드로이드 디바이스로 푸시 메세지를 받을 때 호출되는 함수, window.plugins.pushNotification.register 옵션에 설정에서 ecb의 이름에 매칭된다.
 */
function onNotificationGCM (e){
	switch (e.event) {
	case 'registered': // 안드로이드 디바이스의 registerID를 획득하는 event 중 registerd 일 경우 호출된다.
		window.localStorage.setItem('tokenId', e.regid);
		insertDeviceInfo(e.regid);
		break;
	case 'message': // 안드로이드 디바이스에 푸시 메세지가 오면 호출된다.
		{
			if (e.foreground){ // 푸시 메세지가 왔을 때 앱이 실행되고 있을 경우
			} else { // 푸시 메세지가 왔을 때 앱이 백그라운드로 실행되거나 실행되지 않을 경우
				if (e.coldstart) { // 푸시 메세지가 왔을 때 푸시를 선택하여 앱이 열렸을 경우
					console.log("알림 왔을 때 앱이 열리고 난 다음에 실행 될때");
				} else { // 푸시 메세지가 왔을 때 앱이 백그라운드로 사용되고 있을 경우
					console.log("앱이 백그라운드로 실행될 때");
				}
			}
			console.log(e.payload.tagetUrl);
			console.log(e.payload.message);
			//console.log(e.payload,tagetUrl);
			setTimeout(function() {
				navigator.notification.alert(e.payload.message,
											 function() {
												alertDismissed(e.payload.tagetUrl)
											 },
											 e.payload.title, 
											 'OK');
			}, 1000);
			//document.location.href= e.payload.tagetUrl;
		}
		break;
	case 'error': // 푸시 메세지 처리에 에러가 발생하면 호출한다.
		console.log('error:' + e.msg);
		break;
	case 'default':
		console.log('알수 없는 이벤트');
		break;
	}
}

//callback
function alertDismissed(targetUrl) {
	console.log("targetUrl="+ targetUrl);
	window.location.href= targetUrl;	
}

//regid 밍 token값을 받은 후 device정보 업데이트
function insertDeviceInfo(deviceToken){
	if(nullToBlank(deviceInfo) != ""){
		if(nullToBlank(deviceInfo.uuid) != ""){
			var deviceModel = deviceInfo.model;
			var deviceUUID = deviceInfo.uuid;
			var deviceVersion = deviceInfo.version;
			//var deviceToken = window.localStorage.getItem('tokenId');
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
			if(deviceToken){
				formData.append('deviceToken', deviceToken);
			}
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
				},
				complete : function(data, status) {
				},
				error : function(jqXHR, textStatus, errorThrown) {
				}
			});
		}
	}else{
	}
}

/*
function setConfirm(msg, callback, title, btn1, btn2){
	try{
		navigator.notification.confirm(
			msg,
			function(btnIndex){
				if(btnIndex == 1){
					callback();
				}
			},
			title,
			[btn1, btn2]
		);
	}catch(e){
		if(confirm(msg)){
			callback();
			return false;
		};
	}
}
*/
