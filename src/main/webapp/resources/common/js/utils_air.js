var debug = true;
var devType = 1; // 개발:0, 운영 : 1
//var socialType = 0; //소셜타입
var mUrl = "http://m.lottejtb.com";

/*=========================================================================
 * 자바스크립트 홈페이지 썸네일 가져오는 부분 
 ==========================================================================*/
function fn_chgImage(image, type) {
	var lastIndex = 0;
	var prefix_filename = "";
	var ext_filename 		= "";
	var thumb_file = "";
	
		if(image == null || image == "" || image == "undefined") {
		return "";	
	}	else {
		lastIndex = image.lastIndexOf('.');
		prefix_filename = image.substring(0, lastIndex);
		ext_filename = image.substring(lastIndex, image.length);

		// console.log(" >>>>>>>>>>>>>>>>>>>>> 이미지 변환 >>>>>>>>>>>>>>>>");
		// console.log(" >>>>>>>>>>>>>>>>>>>>> image : " + image);
		// console.log(" >>>>>>>>>>>>>>>>>>>>> type : "+ type);
		// console.log(" >>>>>>>>>>>>>>>>>>>>> prefix_filename : "+ prefix_filename);
		// console.log(" >>>>>>>>>>>>>>>>>>>>> ext_filename : "+ ext_filename);

		if(type == "L") {				// 리스트 화면 
			thumb_file = prefix_filename + "_440"  + ext_filename;
			// console.log(" >>>>>>>>>>>>>>>>>>>>> thumb_file : "+ thumb_file);

			return thumb_file;

		} else if(type == "D") {		// 상세 화면 
			thumb_file = prefix_filename + "_440" + ext_filename;
			// console.log(" >>>>>>>>>>>>>>>>>>>>> thumb_file : "+ thumb_file);

			return thumb_file;
		}
	}

	return "";
}

// -----------------------------------------------------------------------------
// 로그인 체크 
// return 1 : 로그인 완료, 0 : 로그인 미완료 
// -----------------------------------------------------------------------------
function fn_chkLogin(){
	var cookie = document.cookie;
	var info=document.cookie.split(";");
	var cust_id = '';
	for (var i=0; i<info.length; i++) {
		if (info[i].replace(/(^\s*)|(\s*$)|($\s*)/g, "").indexOf("cust_id")==0) {
			cust_id=info[i].substring(info[i].indexOf("=")+1,info[i].length);
		}
	}
	if(cust_id==''||cust_id==null||cust_id=='null'){
		return '0';
	}  else {
		return '1';
	}
}

//-----------------------------------------------------------------------------
// 로그인 쿠키 정보에서 로그인 아이디를 얻는 함수  
//return cust_id;  
//-----------------------------------------------------------------------------		
function fn_getCookieLogin(){
	var cookie = document.cookie;
	var info=document.cookie.split(";");
	var cust_id = '';
	for (var i=0; i<info.length; i++) {
		if (info[i].replace(/(^\s*)|(\s*$)|($\s*)/g, "").indexOf("cust_id")==0) {
			cust_id=info[i].substring(info[i].indexOf("=")+1,info[i].length);
		}
	}
	if(cust_id==''||cust_id==null||cust_id=='null'){
		return "";
	}  else {
		return cust_id;
	}
}

//-----------------------------------------------------------------------------
// 로그인 여부에 따라 로그인 화면으로 이동하는 함수  
// 미 로그인 시  /sso/loginChk.do 이동한다. 
//-----------------------------------------------------------------------------		
function fn_goLogin() {
	if(fn_chkLogin() == 0) {
		window.location.href = "/sso/loginChk.do";
	}
}

/* 
 *	로딩바 열기
 */
function showLoading(){
	try {
		 $.blockUI({
			 message: "<img src='" + mUrl + "/resources/images/bg/loading_bar.gif' />", 
			 css: {
				 background: "rgba(255, 255, 255, 0)",
				 width: '70%',
				 border: '0px',
				 left:'15%',
				 zIndex: 9999999},
			 overlayCSS	: {zIndex: 9999999}, 
			 fadeIn:0
		 });
	} catch (e) {
		console.log(e);
		console.log("showLoading err");
	}
}

/* 
 *	로딩바 종료
 */
function hideLoading(){
	try {
		$.unblockUI();
	} catch (e) {
		console.log("hideLoading err");
	}
}
	
String.prototype.trim = function()
{
	return this.replace(/(^\s*)|(\s*$)/g, "");
};

String.prototype.replaceAll = function(va,re)
{
	var reValue = this;
	while(reValue.search(va)  > -1) 
		reValue = reValue.replace(va,re);
	
	return reValue;
};

// ------------------------------------------------------------------------
//  1000 단위마다 Comma(,) 찍기
// ------------------------------------------------------------------------
function toCurrencyString(strCurrency) 
{
	strCurrency += "";
	var isMinus = false;
	var ipos;

	if (strCurrency.charAt(0) == '-') { strCurrency = strCurrency.substring(1); isMinus = true; }

	strlen  = strCurrency.length;
	cntLoop = Math.floor(strlen / 3);
	rem     = strlen % 3;
	
	if(rem == 0) { rem = 3; cntLoop--; }
	result = strCurrency.substr(0, rem);
	
	for(ipos = 0 ; ipos < cntLoop ; ipos++)
		result += "," + strCurrency.substr(3 * ipos + rem , 3);

	if (isMinus) result = "-" + result;
	return result;
};


/** 
 * 지정된 소숫점 자릿수로 Round해서 값을 리턴한다.
 * Math Object에 추가선언
 * @param {Number} val 반올림할 값
 * @param {Number} precision 소숫점 자리수
 * @return 지정한 소숫점 자리수에 따른 반올림 값
 */
Math.roundPrecision = function(val, precision) {
	var p = this.pow(10, precision);
	return this.round(val * p) / p;
};


/**
 * 쿠키를 배열로 get
 * @returns {___anonymous4530_4532}
 */
function get_cookies_array() {
    var cookies = { };

    if (document.cookie && document.cookie != '') {
        var split = document.cookie.split(';');
        for (var i = 0; i < split.length; i++) {
            var name_value = split[i].split("=");
            name_value[0] = name_value[0].replace(/^ /, '');
            cookies[decodeURIComponent(name_value[0])] = decodeURIComponent(name_value[1]);
        }
    }
    return cookies;
}


function cfn_chkLogin() {
    var cookie = document.cookie;
    var info = document.cookie.split(";");
    var cust_id = '';
    for (var i = 0; i < info.length; i++) {
        if (info[i].replace(/(^\s*)|(\s*$)|($\s*)/g, "").indexOf("cust_id") == 0) {
            cust_id = info[i].substring(info[i].indexOf("=") + 1, info[i].length);
        }
    }
    if (cust_id == '' || cust_id == null || cust_id == 'null') {
        return '0';
    } else {
        return '1';
    }
}

/*==================================================================Start====
 * cfn_ajax 공통 비동기 통신
 ==========================================================================*/
function cfn_ajax(options){
	
	if(!options.noloading){
		gfn_loading_bar_draw('show');
	}
	
	$.ajax({
		url: options.url, 
		type: options.type,
		data: options.data,
		async: false,
		cache: false,
		dataType: "json",
		contentType: false,
	    processData: false,
		success : function(data, status) {
			var msg = data.message;
			try {
				if(status == "success"){ //성공
					
					if(data.exception){
						if(options.exception) {
							options.exception(data);
							return;
						}else{
							if(data.exception.message){
								if(debug){
									// alert(data.exception.message);
								}else{
									alert("fail");
								}
							}else{
								var verror = {};
								verror.message = 'error';
								
								if(verror.message){
									// alert(verror.message);
								}
							}
							
							if(options.exceptionUrl){
								location.href = options.exceptionUrl;
							}
							
						}
					}else{
					
						if(options.success) {
							options.success(data, status);
						}else{
							var verror = {};
					 		verror.code = 'success_msg';
							verror.message = 'success';
							// alert(message);
						}
					}
				}else{
					if(options.exception) {
						options.exception(data);
						return;
					}else{
						
						if(data.exception.message){
							if(debug){
								// alert(data.exception.message);
							}else{
								alert("fail");
							}
						}else{
							var verror = {};
							verror.message = 'error';
							
							if(verror.message){
								// alert(verror.message);
							}
						}
						
						if(options.exceptionUrl){
							location.href = options.exceptionUrl;
						}
					}
				}
			} catch(e) {
				gfn_loading_bar_draw('hide');
				console.log(e);
				// alert(e);
			}
		},
		complete : function(data, status) {
			try{
				if(options.complete) {
					options.complete(data, status);	
				}
			}catch(e){
				throw e;
			}finally{
				
				if(!options.noloading){
					gfn_loading_bar_draw('hide');
				}
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
					
			if(options.error) {
				options.error(jqXHR, textStatus, errorThrown);	
			}else{
				if(jqXHR.status == "404") {
			 		
			 		var verror = {};
					
			 		verror.code = 'notfound_url';
					verror.message = 'notfound';
					
					if(options.exception) {
						options.exception(verror);
					}else{
						alert(verror.message);
					}
					
					return;
				}
				
				var errorObj = null;
				try {
					errorObj = JSON.parse(jqXHR.responseText);
				}catch(ex) {
					var verror = {};
					verror.code = 'unknown_error';
					verror.message = 'unknown_error';
					
					if(options.exception) {
						options.exception(verror);
					}else{
						alert(verror.message);
					}
					return;
				}
				if(options.exception && errorObj.error) {
					options.exception(errorObj.error);
				}
			}
		}		
		
	});

}


/*==================================================================Start====
 * 자바스크립트 html 태그 정리
 ==========================================================================*/
function cfn_RemoveHtml(text)
{
	text = text.replace(/<br>/ig, "\n"); // <br>을 엔터로 변경
	text = text.replace(/&nbsp;/ig, " "); // 공백      
	// HTML 태그제거
	text = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
	
	// shkim.add.
	text = text.replace(/<(no)?script[^>]*>.*?<\/(no)?script>/ig, "");
	text = text.replace(/<style[^>]*>.*<\/style>/ig, "");
	text = text.replace(/<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>/ig, "");
	text = text.replace(/<\\w+\\s+[^<]*\\s*>/ig, "");
	text = text.replace(/&[^;]+;/ig, "");
	text = text.replace(/\\s\\s+/ig, "");
	
	return text;
}


function cfn_getData(list, name, chkVal){
	var returnList = [];
	for(var i = 0; i < list.length; i++){
		if(list[i][name] == chkVal){
			returnList.push(list[i]);
		}
	}
	
	return returnList;
}

function cfn_collapsibleAll(){
	$(".ui-collapsible-heading").addClass("ui-collapsible-heading-collapsed");
	$(".ui-collapsible-content").addClass("ui-collapsible-content-collapsed");
}


function cfn_expandAll(){
	$(".ui-collapsible-heading").removeClass("ui-collapsible-heading-collapsed");
	$(".ui-collapsible-content").removeClass("ui-collapsible-content-collapsed");
}

function cfn_scrollTop(height, delay){
	
	if(delay){
		$('body,html').animate({
			scrollTop: height
		}, delay);
	}else{
		$('body,html').animate({
			scrollTop: height
		}, 100);	
	}
}

/* 
 *	null값 체크
 */
function nullToBlank(message){
	message = message + '';

	if(message == 'undefined' || message == 'NULL' || message == 'null' || message == null){
		message = '';
	}

	return message;
}

var inappVal;
function moveLink(url, target, option){
	try{
		if(nullToBlank(url) != ""){
			cordova.InAppBrowser.open(url, target, option);
			//inappVal = cordova.InAppBrowser.open(url, target, option);
			/*
			inappVal.addEventListener('loadstart', function(event) {
			 	if (event.url.match("mobile/close")) {
			 		inappVal.close();
				}
			});
			*/
			
			//inappVal.show();
		}
	}catch(e){
		if(target == "_system"){
			window.open(url, "_blank", option);
		}else{
			window.open(url, target, option);
		}
	}
}

function closeLink(){
	window.open('mobile/close');
}


var default_image=mUrl+"/resources/images/bg/default_img.jpg";   //기본이미지
var default_image2=mUrl+"/resources/images/bg/default_img02.jpg";   //세로가 가로보다 긴 이미지

//이미지가 없을경우 이미지타입(490,440,400,600)별로 이미지의 유무를 체크해서 최적의 이미지를 뿌려주는 function
function noimg_setting(obj, type){
	var img_url = jQuery(obj).attr("src");
	if(type==1){	//타입의 경우 두가지 의 경우수가 있다
		if(img_url.indexOf("490.")>-1){ //이미지 사이즈가 490인데 에러가 날경우
			jQuery(obj).attr("src",img_url.replace("490","440"));  //이미지 사이즈가 440인 이미지를 뿌린다
		}else{  //440이미지도 없을경우
			jQuery(obj).attr("src",default_image);  //디폴트 노이미지를 뿌려준다
			jQuery(obj).attr("alt","이미지를 준비중입니다.");
		}
	}else if(type==2){	
		if(img_url.indexOf("400.")>-1){//이미지 사이즈가 400인데 에러가 날경우
			jQuery(obj).attr("src",img_url.replace("400","600"));//이미지 사이즈가 600인 이미지를 뿌린다
		}else{//600이미지도 없을경우
			jQuery(obj).attr("src",default_image);//디폴트 노이미지를 뿌려준다
			jQuery(obj).attr("alt","이미지를 준비중입니다.");
		}
	}
	else{  
		if(img_url.indexOf("490.")>-1){ //이미지 사이즈가 490인데 에러가 날경우
			jQuery(obj).attr("src",img_url.replace("490","440"));  //이미지 사이즈가 440인 이미지를 뿌린다
		}else{  //440이미지도 없을경우
			jQuery(obj).attr("src",default_image2);  //노이미지의  크기가  세로가 가로보다 긴 이미지를 뿌려준다
			jQuery(obj).attr("alt","이미지를 준비중입니다.");
		}
		
	}	
}

function comma(jbSplit) {
	var len, point, str, num0, num1;

	if(jbSplit == undefined){
		str = "0";
	}else{
		jbSplit = String(jbSplit);
		//소수점 앞
		num0 = String(jbSplit).split(".")[0];

		num0 = num0 + "";
		point = num0.length % 3 ;
		len = num0.length;

		str = num0.substring(0, point);
		while (point < len) {
			if (str != "") {
				if(str != "-"){
					str += ",";
				}
			}
			str += num0.substring(point, point + 3);
			point += 3;
		}
		//소수점 뒤
		num1 = jbSplit.split(".")[1];
		if(num1 == undefined){
			num1 = "";
		}else{
			str += "." + num1;
		}
	}
	return str;
}


function pageBack(){
	history.back();
}

function pageForward(){
	window.history.forward();
}

function agreePopup(type){
	var date = new Date();
	date = date.format("yyyy.MM.dd HH");
	var agreeMessage = "";
	var marketingYn;
	
	/*
	var vTEXT = '(롯데 JTB,'+ date +')';
	if(type == 'Y'){
		$("#alramPop_jtbY_date").text(vTEXT);
		$("#alramPop_jtbY").popup("open");
		window.localStorage.setItem("adAgreement", true);
	}else{
		$("#alramPop_jtbN_date").text(vTEXT);
		$("#alramPop_jtbN").popup("open");
		window.localStorage.setItem("adAgreement", false);
	}
	*/
	if(type == 'Y'){
		window.localStorage.setItem("adAgreement", true);
		marketingYn = 'Y';
		agreeMessage = "고객님의 이벤트/혜택알림 서비스가 \"수신함\" 처리되었습니다. \n (롯데 JTB,"+ date +")";
	}else{
		window.localStorage.setItem("adAgreement", false);
		marketingYn = 'N';
		agreeMessage = "고객님의 이벤트/혜택알림 서비스가 \"수신안함\" 처리되었습니다. \n (롯데 JTB,"+ date +")";
	}
	
	try{
		if(nullToBlank(device.uuid) != ""){
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
			formData.append('deviceId', device.uuid);
			formData.append('marketingYn', marketingYn);
			formData.append('deviceModel', deviceModel);
			formData.append('osVersion', deviceVersion);
			formData.append('deviceToken', deviceToken);
			formData.append('osType', deviceOsType);
			
			cfn_ajax({
				url: mUrl+"/setting/insertMarketingReceiveYn.do",
				type: "POST",
				data: formData,
				async: false,
				cache: false,
				dataType: "json",
				noloading:"no",
				success: function() {
					/*
					try{//huang 20180704 FCM TOPIC적용
						
						if(marketingYn == 'Y'){
							FCMPlugin.unsubscribeFromTopic('marketN');
							FCMPlugin.subscribeToTopic('marketY');
						}else{
							FCMPlugin.unsubscribeFromTopic('marketY');
							FCMPlugin.subscribeToTopic('marketN');
						}
					}catch(e){
						console.log(JSON.stringify(e));
					}
					*/
					setAlert(agreeMessage, "롯데 JTB알림");
				},
				error:function(err){
					setAlert("등록에 실패하였습니다. \n 설정에서 다시 등록 바랍니다.", "롯데 JTB알림");
				},
				complete:function(){
				}
			});
		}
	}catch(e){
		
	}
}

Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";
 
    var weekName = ["일", "월", "화", "수", "목", "금", "토"];
    var d = this;
     
    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};
 
String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};

var maxCookieSize = 9;
function setTodayEvents(event_cd, ctg, imgpath, disp_nm, ev_day_cnt, ev_night_cnt, adult_price, cdNm){
	if(!ctg){
		ctg = "";
	}
	var itmCookieVal = event_cd + "▤" + ctg + "▤" + imgpath + "▤" + disp_nm + "▤" + ev_day_cnt + "▤" + ev_night_cnt + "▤" + adult_price + "▤" + cdNm;
	var oldCookieVal = getCookie("TODAY_EVENTS");
	var newCookieVal = "";
	if(oldCookieVal){// 쿠키가 있으면
		if(oldCookieVal.indexOf(itmCookieVal) == -1){// 중복 쿠키가 아니면
			var cookieValArr = oldCookieVal.split("▥");
			if(cookieValArr.length < maxCookieSize){// maxCookieSize개 미만일때
				newCookieVal = oldCookieVal + "▥"+itmCookieVal;
			}else{// maxCookieSize개 이상일때
				newCookieVal = itmCookieVal;
				for(var i=(cookieValArr.length-1), j = 0; i >= 0; i--){
					if(++j >= maxCookieSize){
						break;
					}else{
						newCookieVal = cookieValArr[i] + "▥" + newCookieVal;
					}
				}
			}
			setTodayCookie("TODAY_EVENTS", newCookieVal, 1);
		}else{// 중복쿠키이면
			newCookieVal = oldCookieVal.replace("▥"+itmCookieVal,"");
			newCookieVal = newCookieVal.replace(itmCookieVal+"▥","");
			newCookieVal = newCookieVal.replace(itmCookieVal,"");
			if(newCookieVal.length==0){
				newCookieVal += itmCookieVal;
			}else{
				newCookieVal += "▥"+itmCookieVal;
			}  
			setTodayCookie("TODAY_EVENTS", newCookieVal, 1);
		}
	}else{// 쿠키가 없으면
		setTodayCookie("TODAY_EVENTS", itmCookieVal, 1);
	}
}

function getCookie(name) {
	var cname = name + '=';
	var dc    = document.cookie;
	if (dc.length > 0 ) {
		begin = dc.indexOf(cname);
		if (begin != -1) {
			begin = begin + cname.length;
			end   = dc.indexOf(';', begin);
			if (end == -1) end = dc.length;
			return unescape(dc.substring(begin,end));
		}
	}
	return null;
}

function setTodayCookie( cookie_name, cookie_value, date){
	var newNextDay = new Date(new Date().getTime()+((24*60*60*1000) * date));
    document.cookie = cookie_name + "=" + escape( cookie_value ) + "; path=/; expires=" + newNextDay.toGMTString() + ";" 
}

var fn_moveMytour = function(){
	document.location.href = mUrl+"/mytour/mytour.do";
}


var fn_goToList = function() {
	document.location.href=mUrl+"/event/event_list.do";
}


String.prototype.trim = function() {
    return this.replace(/(^\s*)|(\s*$)/gi, "");
}

var fn_airAppLink = function(){
	var userAgent = navigator.userAgent || navigator.vendor || window.opera;
	
	if( userAgent.match(/Android/i)){
		location.href = "Intent://test#Intent;scheme=lotte_jtb;package=com.lottejtb.app;end";
		//location.href = "https://play.google.com/store/apps/details?id=com.lottejtb.app";
	}else if(userAgent.match(/iPhone/i) || userAgent.match(/iPod/i) || userAgent.match(/iPad/i)){
		location.href = "https://appsto.re/kr/xdMW8.i";
	}
}

var fn_hotelMove = function(){
	location.href = mUrl+"/domestic/dmt_detail_domestic.do?url=http://m.cp.hotelpass.net/search.asp?cp_agent=jtbmo&ctgname=호텔";
	// /domestic/dmt_detail_domestic.do?url=http://m.cp.hotelpass.net/?cp_agent=jtbmo&ctgname=호텔
}

var fn_travelCaluse = function(){
	window.open('https://m.lottejtb.com/pdf/web/viewer.html?file=/pdf/insurance.pdf', "_blank");
	//location.href = "/pdf/web/viewer.html?file=/pdf/insurance.pdf";
	//$("#travelDown").click();
}

//상품 카테고리 1 띄우는 스크립트 
function popGoodsCategory1() {
	jQuery(function(){
		var etclaypop = function(w,h){
			var obj = jQuery("#popGoodsCategory1");
			obj.parent().show();
			obj.find(".popFoot").hide();
			obj.find(".cntain").addClass("cntain2");
			obj.find(".popTpart").width(w);
			obj.width(w).height(h).css({"margin-top": (obj.height()/2)*-1+"px","margin-left": (obj.width()/2)*-1+"px"});
			//jQuery("body").bind('touchmove', function(e){e.preventDefault()});
			jQuery("html, body").css({"overflow":"hidden"});
		};
		etclaypop(300,400);
		jQuery(document.body).on("click",".etclayerClose",function(){
			jQuery("html, body").css({"overflow":"auto"});
			jQuery(".layerPopup2").hide(); 
			return false;
		});
	});
}

//상품 카테고리 2 띄우는 스크립트 
function popGoodsCategory2() {
	jQuery(function(){
		var etclaypop = function(w,h){
			var obj = jQuery("#popGoodsCategory2");
			obj.parent().show();
			obj.find(".popFoot").hide();
			obj.find(".cntain").addClass("cntain2");
			obj.find(".popTpart").width(w);
			obj.width(w).height(h).css({"margin-top": (obj.height()/2)*-1+"px","margin-left": (obj.width()/2)*-1+"px"});
			//jQuery("body").bind('touchmove', function(e){e.preventDefault()});
			jQuery("html, body").css({"overflow":"hidden"});
		};
		etclaypop(300,400);
		jQuery(document.body).on("click",".etclayerClose",function(){
			jQuery("html, body").css({"overflow":"auto"});
			jQuery(".layerPopup2").hide(); 
			return false;
		});
	});
}

//정렬선택 띄우는 스크립트 
function popGoodsOrderBy() {
	jQuery(function(){
		var etclaypop = function(w,h){
			var obj = jQuery("#goodsOrderByPop");
			obj.parent().show();
			obj.find(".popFoot").hide();
			obj.find(".cntain").addClass("cntain2");
			obj.find(".popTpart").width(w);
			obj.width(w).height(h).css({"margin-top": (obj.height()/2)*-1+"px","margin-left": (obj.width()/2)*-1+"px"});
			//jQuery("body").bind('touchmove', function(e){e.preventDefault()});
			jQuery("html, body").css({"overflow":"hidden"});
		};
		etclaypop(300,400);
		jQuery(document.body).on("click",".etclayerClose",function(){
			jQuery("html, body").css({"overflow":"auto"});
			jQuery(".layerPopup2").hide(); 
			return false;
		});
	});
}

function msgBinding(message){
	var result = "";
	if(nullToBlank(message) == ""){
		result = message;
	}else{
		result = "***" + message.substring(3, message.length);
	}
	
	return result
}

function setCookieValue(cName, cValue, domain){
    var expire = new Date();
    expire.setDate(expire.getDate());
    
    if(nullToBlank(domain) != ""){
    	cookies = cName + '=' + escape(cValue) + '; path=/; domain='+ domain; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
    }else{
    	cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
    }
    
    document.cookie = cookies;
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

function setAlert(message, title){
	try{
		if(nullToBlank(title) == ""){
			navigator.notification.alert(message, null, '알림', '확인');
		}else{
			navigator.notification.alert(message, null, title, '확인');
		}
	}catch(e){
		alert(message);
	}
}

function setConfirm(msg, successCallback, cancelCallback, title, btn1, btn2){
	try{
		navigator.notification.confirm(
			msg,
			function(btnIndex){
				confirmFuncSetting(btnIndex, successCallback, cancelCallback);
				/*
				if(btnIndex == 1){
					successCallback();
				}else{
					cancelCallback();
				}
				*/
			},
			title,
			[btn1, btn2]
		);
	}catch(e){
		if(confirm(msg)){
			successCallback();
			return false;
		}else{
			cancelCallback();
		}
	}
}

function confirmFuncSetting(btnIndex, successCallback, cancelCallback){
	if(btnIndex == 1){
		successCallback();
	}else{
		cancelCallback();
	}
}

function Encrypt(theText) {
    output = new String;
    Temp = new Array();
    Temp2 = new Array();
    TextSize = theText.length;
    for (var i = 0; i < TextSize; i++) {
        rnd = Math.round(Math.random() * 122) + 68;
        
        if(rnd == 92){
        	rnd = rnd + 1;
        }
        
        Temp[i] = theText.charCodeAt(i) + rnd;
        Temp2[i] = rnd;
    }
    for (var i = 0; i < TextSize; i++) {
        output += String.fromCharCode(Temp[i], Temp2[i]);
    }
    return output;
}

function Decrypt(theText) {
    output = new String;
    Temp = new Array();
    Temp2 = new Array();
    TextSize = theText.length;
    for (var i = 0; i < TextSize; i++) {
        Temp[i] = theText.charCodeAt(i);
        Temp2[i] = theText.charCodeAt(i + 1);
    }
    for (var i = 0; i < TextSize; i = i+2) {
        output += String.fromCharCode(Temp[i] - Temp2[i]);
    }
    return output;
}

function getJSessionId(){
    var jsId = document.cookie.match(/JSESSIONID=[^;]+/);
    if(jsId != null) {
        if (jsId instanceof Array)
            jsId = jsId[0].substring(11);
        else
            jsId = jsId.substring(11);
    }
    return jsId;
}

//로딩바 호출/제거
function gfn_loading_bar_draw(_flag) {
	if($('#test_loading_bar').length < 1){
		$('body').append('<div id="test_loading_bar"></div>');

	}
	
	if($('#test_loading_bar_img').length < 1){
		$('#test_loading_bar').append('<img id="test_loading_bar_img" src="' + mUrl + '/resources/images/img/loading.gif" style="width:296px;"></img>');
	}
	
	$('#test_loading_bar').css({
		'position': 'fixed', 
		'top': '0px',
		'left': '0px',
		'width': '100%', 
		'height': '100%', 
		'display': 'none', 
		'background-color': '#fff',
		'opacity': 0.9,
		'z-index': 99999,
		'text-align' : 'center'
	}).attr('ar-data', 'show');

	var set_bottom = ($('#test_loading_bar').innerHeight() - 168)/2;
	var set_right = ($('#test_loading_bar').innerWidth() - 296)/2;
	$('#test_loading_bar > img').css({
		'position' : 'fixed',
		'right' : set_right,
		'bottom' : set_bottom
	});
	
	//	gfn_setPosition($('#test_loading_bar'), 0);
	testLoading(_flag);
}

function testLoading(_flag) {
	if(_flag == ''){
		_flag = $('#test_loading_bar').attr('ar-data');
	}
 
	if(_flag == 'show') {
		$('#test_loading_bar').show();
		$('#test_loading_bar').attr('ar-data', 'hide');
	//	$('html').css('overflow', 'hidden');
	} else {
	//	$('#test_loading_bar').hide();
		$('#test_loading_bar').attr('ar-data', 'show');
	//	$('html').css('overflow', 'auto');
	}
}

var fn_moveFreePage = function(type){
	if(nullToBlank(type) != ""){
		location.href = mUrl+"/free/main.do?tabType="+ type;
	}else{
		location.href = mUrl+"/free/main.do";
	}
}

function movePage(url){
	document.location.href = url;
}

//특정 날짜 요일 구하기
// day = 20170405
function fn_getDay(day) {
	var date = day.split('.');
	var year = date[0];
	var month = date[1];
	var day = date[2];
	var selDate = new Date(year, month - 1, day);
	var week = ['일', '월', '화', '수', '목', '금', '토'];

	if(day == undefined || day == 'undefined' || day == null) {
		day = '';
	}
	
	var dayOfWeek = week[selDate.getDay()];
	console.log("week=" + dayOfWeek);
	
	return dayOfWeek;
}

function appDownLink(){
	if(ios) {
		location.href = "http://itunes.apple.com/app/id1226857733?mt=8";
	}else{
		location.href = "market://details?id=" + "com.lottejtb.app";
	}
	//location.href = 'http://m.lottejtb.com/lottejtb.apk';
}

function fn_autoComplete(){
	
	var keyword = $("#autoComplete").val();
		
	if(nullToBlank(keyword) != ""){
		
		//[JEH] 투어멘토링 hide start - 20190111
		var tmp_li = $(".Mentoring_box_list").find('li');
		$.each(tmp_li, function(k, v){
			$(v).removeClass("on");
		});
		
		$(".Mentoring_box").css("display", "none");
		//[JEH] 투어멘토링 hide end - 20190111
		
		var formData = new FormData();
		formData.append('keyword', keyword);

		cfn_ajax({
			url: mUrl+'/autoComplete.do',
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:"no",
			success: function(res) {
				list = res.list;
				
				if(list.length > 0){
					vHTML = "";
					for(var i = 0; i < list.length; i++){
						vHTML += '<li onclick="fn_textSetting(\''+ list[i] +'\')">'+ list[i] +'</li>';	
					}
					
					$("#autoWords").html(vHTML);
					$(".fs_search .search_nowkey").show();
				}else{
					$("#autoWords").html("");
					$(".fs_search .search_nowkey").hide();
				}
			},
			error:function(err){
				console.log(err);
			},
			complete:function(){
			}
		});	
	}else{
		$(".fs_search .search_nowkey").hide();
		//[JEH] 투어멘토링show - 20190111
		$(".Mentoring_box").css("display", "block");
		
	}
}

function fn_textSetting(txt){
	$("#autoComplete").val(txt);
	
	$(".fs_search .search_nowkey").hide();
}

function fn_keywordSearch(){
	//[JEH] 투어멘토링 선택시 해당 검색페이지로 이동 - 20190111

	var tmp_li = $(".Mentoring_box_list").find('li');
    var mentoYn = "N";
    
	$.each(tmp_li, function(k, v){
		if($(v).hasClass("on")){
			mentoYn = "Y";
		};
	});	
    
    if(nullToBlank($("#autoComplete").val()) == "" && mentoYn == "N"){
    	alert('함께 여행할 분을 선택해 주세요.');
    	return false;
    }else{
    	if(mentoYn == "Y"){
    		
    		var tmp_li = $('.Mentoring_box_list').find('li');
    		var catg = [];
    		jQuery.each(tmp_li, function(k, v){		
    			if(jQuery(v).hasClass('on')){
    				catg.push($(v).attr('attr-val'));
    			}
    		});
    		
    		location.href = mUrl+"/search/search.do?searchKeyword="+encodeURIComponent(catg) + "&sechType=TM";				
    	}else{
    		
    		if(nullToBlank($("#autoComplete").val()) != ""){
    			location.href = mUrl+"/search/search.do?searchKeyword="+$("#autoComplete").val();				
    		}else{
    			setAlert("검색어를 입력하세요.");	
    		}
    		
    	}
    }
    
}

function fn_lpoinIntro(){
	location.href = mUrl+"/corperate/corperate_lpoint.do";
}