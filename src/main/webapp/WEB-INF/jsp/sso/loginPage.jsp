<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.lottejtb.comm.util.*"%>
<%@page import="java.util.HashMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 

<head>

<meta http-equiv="Expires" content="-1">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">

<script src="<c:url value='/resources/common/js/facebook.js' />"></script>
<script src="<c:url value='/resources/common/js/naver.js' />"></script>  
	
<script src="<c:url value='/resources/common/js/hex_md5.js' />"></script>	
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
<script type="text/javascript" charset="utf-8" src="https://static.nid.naver.com/js/naverLogin.js"></script>
<script type="text/javascript">


	// 통합인증서비스(SSO)
	// 통합인증서비스(SSO)
	//var LOTTEJTB_REGUSER = "https://member.lpoint.com/door/user/regUser.jsp?sid=LOTTEJTB"; // 회원가입
	//var LOTTEJTB_REQUESTPASSWD = "https://member.lpoint.com/door/user/requestPasswd.jsp?sid=LOTTEJTB"; // 비밀번호찾기  
	//var LOTTEJTB_REQUESTID = "https://member.lpoint.com/door/user/requestId.jsp?sid=LOTTEJTB"; // 아이디찾기
	//var LOTTEJTB_EDITPASSWD = "https://member.lpoint.com/door/user/editPasswd.jsp?sid=LOTTEJTB"; // 비밀번호 변경
	//var LOTTEJTB_EDITEMAIL = "https://member.lpoint.com/door/user/editEmail.jsp?sid=LOTTEJTB"; // Email 변경
	//var LOTTEJTB_EDITADDR = "https://member.lpoint.com/door/user/editAddr.jsp?sid=LOTTEJTB"; // 연락처 변경
	//var LOTTEJTB_EDITOTHERS = "https://member.lpoint.com/door/user/editUserInfo.jsp?sid=LOTTEJTB"; // 부가정보 변경
	//var LOTTEJTB_WITHDRAWL = "https://member.lpoint.com/door/user/withdrawl.jsp?sid=LOTTEJTB"; // 회원탈퇴
	
	<%
		HttpSession sessionInfo = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)sessionInfo.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = null;
		if(sessionParam != null){
			custCd = sessionParam.get("cust_cd").toString();
		}
		
		if(custCd != null)
			System.out.println("##custCd##=" + custCd);
		
		String returnUrl = request.getParameter("returnUrl");
		System.out.println("###returnUrl#####=" + returnUrl);
		String returnUrlAir = (String)request.getAttribute("returnurl");
		
		//제휴사 페이지 
		String dhtReUrl = (String)request.getAttribute("returnurl");
		if(dhtReUrl != null)		
			dhtReUrl = URLEncoder.encode(dhtReUrl);	
		System.out.println("###dhtReUrl#####=" + dhtReUrl);
		
		String test = (String)request.getAttribute("returnurl");

		System.out.println("returnUrl------>"+returnUrl);
		System.out.println("returnUrlAir------>"+returnUrlAir);
		System.out.println("test------>"+test);

		
	%>
	
	var loginid=""; 
	var pw="";
	var popYn = "${popYN}";
	var returnUrlAir = '<%= returnUrlAir %>';
	
	//비회원예약
	var username= '';
	var email='';
	var reserveNumber='';	
	
	//var loginType = 0; // 0: 일반로그인, 1: 네이버로그인, 2: 페이스북 로그인
	var facabookToken = "";
	var naverToken = "";
	
	
	if(popYn == 'Y'){
		closeLink();
	}
		
	// 회원 로그인
	function fn_LoginSubmit() {
		loginid = $("#loginId").val();
		pw = $("#loginPw").val();
		
		if ( loginid == '') {
			setAlert("아이디를 입력해 주세요");
			$("#loginId").focus();
			return false;
		}
		if ( pw == '') {
			setAlert("비밀번호를 입력해 주세요");
			$("#loginPw").focus();
			return false;
		}
		// 통합인증서비스(SSO) 비밀번호 암호화 하여 전송   
		//$("#loginPw").val(pw);		
		//
		//var url = "https://security.lottejtb.com/jsp/sso/loginProcess.jsp";
		//var url = "http://10.141.1.40:8080/jsp/sso/loginProcess.jsp";
		//if(devType == 0) {
		//	var url = "http://www.lottejtb.com/jsp/sso/loginProcess.jsp";
		//} else {
			
		//}
			
		//var url = "http://www.lottejtb.com/jsp/sso/loginProcess.jsp";
		//document.frm.action = url;
		//document.frm.submit();
		
		if($("#autoLogin").is(":checked")){
			var enId = Encrypt(loginid);
			var enPw = Encrypt(hex_md5(pw));
			
			var userInfo = {'me01' : enId, 'me02' : enPw};
			
			window.localStorage.setItem('ACCESSINFO', JSON.stringify(userInfo));
			window.localStorage.setItem('autoLogin', 'Y');	
		}else{
			window.localStorage.setItem('autoLogin', 'N');
		}
		
		fn_login(0);
	}; 
	
	
	
	//비회원 예약 확인
	function fn_GuestLoginSubmit() {
		if ($('#username').val() == '') {
			setAlert("이름을 입력해주십시오");
			$('#username').focus();
			
			return false;
		//}else if($('#useremail').val() == '') {
		//	setAlert("이메일을 입력해주십시오");
		//	$('#useremail').focus();
			
		//	return false;
		//}else if($('#useremail').val() == '') {
		//	setAlert("이메일을 입력해주십시오");
		//	$('#useremail').focus();
			
		//	return false;
		}else if($('#r_phoneno').val() == '') {
			setAlert("휴대전화를 입력해주십시오");
			$('#r_phoneno').focus();
			return false;
		}else if($('#rescd').val() == '') {
			setAlert("예약번호를 입력해주십시오");
			$('#rescd').focus();
			
			return false;
		}else{
			fn_checkGuestLogin();
		}
	}
	
	//로그아웃
	function fn_LogoutSubmit() {
		document.location.href = "/sso/loginOut.do";
	};
	
	//email 형식 체크
	function fn_emailCheck(strMail) { 
	    var check1 = /(@.*@)|(\.\.)|(@\.)|(\.@)|(^\.)/;  
	    var check2 = /^[a-zA-Z0-9\-\.\_]+\@[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,4})$/; 
	    if ( !check1.test(strMail) && check2.test(strMail) ) { 
	        return true; 
	    } 
	    return false; 
	}
	
	//로그인 정보
	var fn_login = function(loginType) {
		var preUrl = getCookieValue('preUrl');
		var nowUrl = getCookieValue('nowUrl');
		var formData = new FormData();
		
		if(nowUrl.length > 0){
			nowUrl = nowUrl.substring(nowUrl.indexOf("returnurl=")+10,nowUrl.length);
			//alert(nowUrl);
		}
		


		formData.append('loginId', $("#loginId").val()); //입력방은 회원사별 ID
		formData.append('password', $("#loginPw").val());     //패스퉈드
		formData.append('sid' , 'LOTTEJTB');  //기할당받은 사이트식별자 
		formData.append('sch', '');             //앱여부구분값(값이 없으면 모바일웹)
		<%
		if(dhtReUrl != null && dhtReUrl.indexOf("dht.lottejtb.com") > -1) {
		%>
			formData.append('returnUrl', "http://m.lottejtb.com/domestic/dmt_detail_domestic.do?url=" + '<%=dhtReUrl%>' + "&ctgname=국내숙소");
		<%
		}else if(dhtReUrl != null && (dhtReUrl.indexOf("air.lottejtb.com") > -1 || dhtReUrl.indexOf("local.lottejtb.com") > -1 || dhtReUrl.indexOf("renewal.lottejtb.com") > -1 || dhtReUrl.indexOf("dev1.lottejtb.com") > -1|| dhtReUrl.indexOf("mhotel2.lottejtb.com") > -1)){
		%>
			formData.append('returnUrl', '<%=dhtReUrl%>');
		<%
		}else {
		
		%>	
			if(nullToBlank(preUrl) == '' || preUrl.indexOf('/jsp/sso/loginSuccess.do') != -1 || preUrl.indexOf('/sso/loginChk.do') != -1) {
				if(devType == 0)
					formData.append('returnUrl', 'http://mdev.lottejtb.com/main.do');
				else
					formData.append('returnUrl', 'http://m.lottejtb.com/main.do');
			} else {
					
				<%
				 if(returnUrl == null || returnUrl == "") {  //preURL 값을 리턴 URL로 넘김.
				%>
					if(devType == 0)
						formData.append('returnUrl', 'http://mdev.lottejtb.com' + preUrl);
					else
						formData.append('returnUrl', 'http://m.lottejtb.com' + preUrl);
				<%
				 } else {   //commIntercepter에 의해서 들어오는 경우 
				%>
					if(devType == 0)
						formData.append('returnUrl', 'http://mdev.lottejtb.com' + '<%=CommUtil.filterXSS(returnUrl)%>');
					else
						formData.append('returnUrl', 'http://m.lottejtb.com' + '<%=CommUtil.filterXSS(returnUrl)%>');
				<%
				 }
				%>
			 }
		<%
		}
		%>
		formData.append('openType', '');  //값이 없으면 기본창, 팝업일 경우 : 'P'		
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/sso/loginProcessAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 5 * 60 * 1000,
			success: function(data) {
				var list = data.list;
				
				try {	
					if(loginType == 0) {
							document.location.href = "/sso/loginProcess.do?id=" + list['loginId'] + "&pw=" + list['password'] + "&returnurl=" + list['returnUrl'] + "&sid=" + list['sid'];
							//document.location.href = "/sso/loginProcess.do?id=" + list['loginId'] + "&pw=" + list['password'] + "&returnurl=" + nowUrl + "&sid=" + list['sid'];
					} else if(loginType == 1) { //페이스북
						if(nullToBlank(facebookToken) != '') {
								if(devType == 0)
									document.location.href = encodeURI("https://testmember.lpoint.com/door/sso/authMblUser.jsp?&returnurl=" + list['returnUrl'] + "&copToken=" + facebookToken + "&copCls=01&sid=" + list['sid']);
								else
									document.location.href = encodeURI("https://member.lpoint.com/door/sso/authMblUser.jsp?&returnurl=" + list['returnUrl'] + "&copToken=" + facebookToken + "&copCls=01&sid=" + list['sid']);
								//socialType = 1;
						}
					} else if(loginType == 2) {  //네이버로긴
						if(nullToBlank(naverToken) != '') {
								if(devType == 0)
									document.location.href = encodeURI("https://testmember.lpoint.com/door/sso/authMblUser.jsp?&returnurl=" + list['returnUrl']) + "&copToken=" + naverToken + encodeURI("&copCls=02&sid=" + list['sid']);
								else
									document.location.href = encodeURI("https://member.lpoint.com/door/sso/authMblUser.jsp?&returnurl=" + list['returnUrl']) + "&copToken=" + naverToken + encodeURI("&copCls=02&sid=" + list['sid']);
								//socialType = 2;	
						}	
						
				
					} else {
							//console.log(">>>>loginType=" + loginType);	
					}
				} catch(e) {
					console.log(e);
				}
				//alert(list);
			},
			error : function(err) {
				console.log(err);
				window.localStorage.removeItem('autoLogin');
				setAlert("조회 결과가 없습니다.");
				
			},
			complete : function(e) {
				console.log(e);
			}
			
		});
		
	};	
	
	//비회원예약 조회
	var fn_checkGuestLogin = function() {

		var resCd = $('#rescd').val();
		if((resCd.startsWith('F') && resCd.length == 15) || (resCd.startsWith('P') && resCd.length == 12) || (resCd.startsWith('I') && resCd.length == 12)){
			var formData = new FormData();
			formData.append('res_nm', $('#username').val());
			formData.append('email', $('#useremail').val());
			formData.append('r_phoneno', $('#r_phoneno').val());
			formData.append('res_cd', $('#rescd').val());
			var res_cd = $('#rescd').val();
	
			cfn_ajax({
				type: "POST" ,
				async : false,
				url: "/sso/checkGuestLoginAjax.do",
				data: formData,
				dataType: "json",
				cache : false,
				noloading : "yes",
				timeOut : 5 * 60 * 1000,
				success: function(data) {
					var list = data.checkGuestLogin;
					
					if(list.length == 0) {
						setAlert("죄송합니다.입력하신 예약정보가 없습니다.");
					} else {
						/* if(list !=null 
								&& list[0]["res_cd"] != null) {   //에약 정보 맞을시 마이투어로 이동
							document.location.href="/mytour/mytour.do?cust_cd=" + list[0]["cut_cd"];  
						} */
						<%
							if(custCd == null || custCd == "") { //비회원예약인경우
						%>
							document.location.href="/mytour/nonMember.do?userNm=" + $('#username').val() + "&email=" + $('#useremail').val() + "&r_phoneno=" + $('#r_phoneno').val() + "&resCd=" + $('#rescd').val();
							//document.location.href="/mytour/nonMember.do?userNm=" + $('#username').val() + "&r_phoneno=" + $('#r_phoneno').val() + "&resCd=" + $('#rescd').val();
						<%
							} else {
						%>
							setAlert("비회원예약확인 페이지입니다. L.point 로그인페이지에서 로그인 해주시기 바랍니다.");
						<%
							}
						%>
					}
					
				},
				error: function(e) {
					console.log(e);
				},
				complete:function(e) {
					console.log(e);
				}
			});
		}else{		

			//[JEH] 항공 비회원예약조회 추가 - 20190725
			localStorage.setItem("r_name", $('#username').val());
			localStorage.setItem("r_email", $('#useremail').val());
			localStorage.setItem("r_phoneno", $('#r_phoneno').val());
			localStorage.setItem("rsvno", $('#rescd').val());
			
			$("#frmAir input[name=r_name]").val($('#username').val());
			$("#frmAir input[name=r_email]").val($('#useremail').val());
			$("#frmAir input[name=r_phoneno]").val($('#r_phoneno').val());
			$("#frmAir input[name=rsvno]").val($('#rescd').val());


			var __domain = "https://m.air.lottejtb.com";

			if(returnUrlAir.indexOf("m.air.lottejtb.com") > -1){
				__domain = "https://m.air.lottejtb.com";
			}else if(returnUrlAir.indexOf("renewal.lottejtb.com") > -1){
				__domain = "http://renewal.lottejtb.com:20000";
			}else if(returnUrlAir.indexOf("local.lottejtb.com") > -1){
				__domain = "http://local.lottejtb.com";
			}else if(returnUrlAir.indexOf("dev1.lottejtb.com") > -1){
				__domain = "http://dev1.lottejtb.com:20000";
			}
			
			var formAction = __domain + "/air/b2c/auth/loginAction.k1";
			
			$("#frmAir").attr("action",formAction);
			$("#frmAir input[name=returnurl]").val(__domain + "/air/b2c/AIR/MBL/AIRMBLLST0100000010.k1");
			
			$("#frmAir").submit();
		}
	};
	
	//회원가입
    function fn_join() {
		if(devType == 0)
			moveLink("https://testmember.lpoint.com/door/user/mobile/login_common.jsp?sid=LOTTEJTB&returnurl=http://mdev.lottejtb.com/sso/loginChk.do?popYN=Y", '_system', 'location=no');
		else
			//moveLink("https://member.lpoint.com/door/user/mobile/login_common.jsp?sid=LOTTEJTB&returnurl=https://m.lottejtb.com/sso/loginChk.do?popYN=Y", '_system', 'location=no');
		moveLink("https://security.lottejtb.com/jsp/sso/loginProcess_MbrJoin.jsp?sid=LOTTEJTB&returnurl=https://m.lottejtb.com/sso/loginChk.do?popYN=Y", '_system', 'location=no');
	}
	
	//아이디 찾기
	function fn_findId() {
		if(devType == 0){
			moveLink("https://testmember.lpoint.com/door/user/mobile/requestId.jsp?sid=LOTTEJTB&returnurl=http://mdev.lottejtb.com/sso/loginChk.do?popYN=Y", '_self', 'location=no');
		}else{
			//moveLink("https://member.lpoint.com/door/user/mobile/requestId.jsp?sid=LOTTEJTB&returnurl=https://m.lottejtb.com/sso/loginChk.do?popYN=Y", '_self', 'location=no');
			moveLink("https://security.lottejtb.com/jsp/sso/loginProcess_findId.jsp?sid=LOTTEJTB&returnurl=https://m.lottejtb.com/sso/loginChk.do?popYN=Y", '_system', 'location=no');
		}
	}
	
	//비밀번호찾기
    function fn_findPw() {
    	if(devType == 0)
    		moveLink("https://testmember.lpoint.com/door/user/mobile/requestPasswd.jsp?sid=LOTTEJTB&returnurl=http://mdev.lottejtb.com/sso/loginChk.do?popYN=Y", '_self', 'location=no');
    	else
    	//moveLink("https://member.lpoint.com/door/user/mobile/requestPasswd.jsp?sid=LOTTEJTB&returnurl=https://m.lottejtb.com/sso/loginChk.do?popYN=Y", '_self', 'location=no');
    	moveLink("https://security.lottejtb.com/jsp/sso/loginProcess_findPw.jsp?sid=LOTTEJTB&returnurl=https://m.lottejtb.com/sso/loginChk.do?popYN=Y", '_system', 'location=no');
	}

	function keydown(event){
		if(event.keyCode==13){   // keyCode == 13  : 엔터키를 뜻함
			if( $("#loginId").val() == '' ) {
				$("#loginId").focus();
				return false;
			}
			if(  $("#loginPw").val() == '' ) {
				$("#loginPw").focus();
				return false;
			}	
			fn_LoginSubmit();
	  	}
	}	
	
	$(document).ready(function(){
		$("input").focus(function(){
			var topFocus = parseInt($(this)[0].offsetTop) + 5;
		
			jQuery('body,html').animate({
		      scrollTop: topFocus
		    }, 50);
		});

		//[JEH] 임시 -  자동로그인시 데이터 깨지는 현상으로 자동로그인 안되도록 수정 - 20190723
	    /*
		$("#autoLogin").change(function(){
	        if($("#autoLogin").is(":checked")){
	            alert("현재 자동로그인 기능 점검 중으로 사용하실 수 없습니다.\n이용에 불편을 드려서 죄송합니다.");
	            $('#autoLogin').attr( 'checked', false );
	            return false;
	        }
	    });
		*/

		/*
		if(window.localStorage.getItem('autoLogin') == "Y"){
			var userInfo = $.parseJSON(window.localStorage.getItem('ACCESSINFO'));
			
			var userId = Decrypt(userInfo['me01']);
			var userPw = Decrypt(userInfo['me02']);
			
			$("#loginId").val(userId);
			$("#loginPw").val(userPw);
			
			setTimeout(function(){
				fn_login(0);
			}, 100);
		}
		*/
	});
	
	 // This is called with the results from from FB.getLoginStatus().
	 function statusChangeCallback(response) {
	    console.log('statusChangeCallback');
	    console.log(response);
	  
	    if (response.status === 'connected') {  //페이스북에 로그인했으며 앱에 로그인한 상태
	    	facebookToken = response.authResponse.accessToken;
	    	console.log('facebookToken: ' + facebookToken);
	    	
	    	// 이곳에 별도의 submit 처리가 필요함
	    	//앱용 로그인을 위한 멥버스와 연동처리
	    	//추가 파라미터 
	    	//copToken : accessToken, copCls : 01
	    	
	    	console.log('Successful expiresIn: ' + response.authResponse.expiresIn);
	    	//토큰이 만료되어 갱신해야 하는 UNIX 시간을 표시
	    	console.log('Successful signedRequest: ' + response.authResponse.signedRequest);
	    	//앱사용자의 ID
	    	console.log('Successful userID: ' + response.authResponse.userID);
	    	   
	       	fn_connect();
	    } else if (response.status === 'not_authorized') {  //페이스북에 로그인했지만 앱에 미로그인 상태
	       // 사용자가 페이스북 APP 사용 동의를 안 했을 때 처리할 부분
           setAlert('Facebook 정보 제공에 동의해 주셔야 Facebook ID로 로그인하실 수 있습니다.');
	      
	    } else {  //unknown
	       //face book에 로그인 하지 않았으므로 facebook login 창 유도
	       FB.login(function(response){
			   	// Handle the response object, like in statusChangeCallback() in our demo
	  		   	// code.
			   	statusChangeCallback(response);
		   }, {scope: 'public_profile,email,user_friends'});
	    }
	  }
	
	  // This function is called when someone finishes with the Login
	  // Button.  See the onlogin handler attached to it in the sample
	  // code below.
	  function checkLoginState() {
 	    FB.getLoginStatus(function(response) {
	      statusChangeCallback(response);
	    }); 
	  }
	
	  window.fbAsyncInit = function() {
		  FB.init({
		    appId      : '1097753987019439',  //facebook app ID
		    cookie     : true,  // enable cookies to allow the server to access 
		                        // the session
		    xfbml      : true,  // parse social plugins on this page
		    version    : 'v2.8' // use graph api version 2.8
		  });
		
		  // Now that we've initialized the JavaScript SDK, we call 
		  // FB.getLoginStatus().  This function gets the state of the
		  // person visiting this page and can return one of three states to
		  // the callback you provide.  They can be:
		  //
		  // 1. Logged into your app ('connected')
		  // 2. Logged into Facebook, but not your app ('not_authorized')
		  // 3. Not logged into Facebook and can't tell if they are logged into
		  //    your app or not.
		  //
		  // These three cases are handled in the callback function.
		
	 	  /* FB.getLoginStatus(function(response) {
		    statusChangeCallback(response);
		  }); */
		
	  };
	
	  // Load the SDK asynchronously
	  (function(d, s, id) {
		    var js, fjs = d.getElementsByTagName(s)[0];
		    if (d.getElementById(id)) return;
		    js = d.createElement(s); js.id = id;
		    js.src = "https://connect.facebook.net/ko_KR/all.js";
		    fjs.parentNode.insertBefore(js, fjs);
	  }(document, 'script', 'facebook-jssdk'));
	
	  // Here we run a very simple test of the Graph API after login is
	  // successful.  See statusChangeCallback() for when this call is made.
	  function fn_connect() {
	      console.log('Welcome!  Fetching your information.... ');
	      FB.api('/me', function(response) {
		      console.log('Successful login name: ' + response.name);
		      console.log('Successful login email: ' + response.email);
		      console.log('Successful login first_name: ' + response.first_name);
		      console.log('Successful login id: ' + response.id);
		      console.log('Successful login last_name: ' + response.last_name);
		      console.log('Successful login link: ' + response.link);
		      console.log('Successful login locale: ' + response.locale);
		      console.log('Successful login timezone: ' + response.timezone);
		      console.log('Successful login verified: ' + response.verified);
		      console.log('Successful login updated_time: ' + response.updated_time);
		      
		      console.log("페이스북과 앱 로그인성공");
		     		      
		      fn_login(1);
	    
	    });
	  }
	  
	  //임시로그아웃
	  function fn_logout() {
			FB.logout(function(response) {
				console.log("fb logout");
			});  
	  };
	
	
	/* 네이버 로그인  */
	
	<%
		String code = request.getParameter("code");
		//String redirectUrl = "http://mdev.lottejtb.com/sso/loginChk.do";
		//redirectUrl = URLEncoder.encode(redirectUrl, "UTF-8");
		System.out.println("code=" + code);
	%>
	
	var redirectUrl = '';
	if(devType == 0) {
		redirectUrl = "http://mdev.lottejtb.com/sso/loginChk.do";
	} else {
		redirectUrl = "http://m.lottejtb.com/sso/loginChk.do";
	}
	//redirectUrl = encodeURI(redirectUrl);
	
	redirectUrl = encodeURI(redirectUrl+"?returnurl="+returnUrlAir);
	
	var code = '<%=CommUtil.filterXSS(code)%>';
	//if(code != null && code != '') {
		//loginType = 2;
	//}
	
	//state값 생성
	var generaterState = function() {
		var oDate = new Date();
		console.log("time=" + oDate.getTime());
		return oDate.getTime();
	};
	
	//state값 저장
	var saveState = function(state) {
		$.removeCookie("state_token");
		$.cookie("state_token", state);
		
	};
	
	var naver = NaverAuthorize({
		client_id : "OhsItzD2iA6zsuSRyyXI",
		client_secret : "TbBmuv8Zw_",
		redirect_uri : redirectUrl
	});
	
	//네이버 로그인 버튼에 싱행 할 자바스크립트 
	function fn_LoginWithNaver() {
		
		var state = generaterState();
		saveState(state);
		//naver.login(state);
		//loginType= 2;
		//[JEH]필수제공정보 변경에 따른 parameter(auth_type) 추가 - 20181219
		document.location.href= "https://nid.naver.com/oauth2.0/authorize?client_id=OhsItzD2iA6zsuSRyyXI&response_type=code&redirect_uri=" + redirectUrl + "&state=" + state;
// 		document.location.href= "https://nid.naver.com/oauth2.0/authorize?client_id=OhsItzD2iA6zsuSRyyXI&response_type=code&redirect_uri=" + redirectUrl + "&state=" + state + "&auth_type=reprompt";
		//console.log("fn_LoginWithNaver = " + loginType);
	};
	
	//저장된 session 스토리지 삭제.
	function fn_naverLogout() {
		sessionStorage.clear();
		// 저장된 모든 값 삭제
		document.location.href="http://nid.naver.com/nidlogin.logout";
	}
	
	function hpkeyup(val){
		  var hp = val;
		  var hpval = hp.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
		  
		  $("#r_phoneno").text(hpval);
	}
	
	//휴대전화 입력 시 하이픈 처리
	function key_up(val){

		var number = val.value.replace(/[^0-9]/g, ""); 
		var phone = "";
		
		if(number.length < 4) {
			return number; 
		} else if(number.length < 7) {
			phone += number.substr(0, 3); 
			phone += "-"; 
			phone += number.substr(3); 
		} else if(number.length < 11) {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3, 3);
			phone += "-"; phone += number.substr(6);
		} else { 
			phone += number.substr(0, 3); 
			phone += "-"; 
			phone += number.substr(3, 4); 
			phone += "-"; 
			phone += number.substr(7); 
		} 
		
		val.value = phone;


	}		
	
	
    $(function() {
    	// console.log("Naver callback!~!~ = " + loginType);
    	 if(nullToBlank(code) != '')  { //네이버로 로그인하는 경우에만.
    		//callback이 오면 checkLoginState()함수를 호출한다.
    			fn_checkLoginState();
    		
    			var tokenInfo = {accessToken:"", refresh_token:""};
    			
    			function fn_checkLoginState() {
    				
    		        var state = $.cookie("state_token");
    		        console.log("state=" + state);
    		  
    		        if(naver.checkAuthorizeState(state) ==="connected") {
    		        	//정상적으로 Callback정보가 전달되었을 경우 Access Token발급 요청 수행
    		        	naver.getAccessToken(function(data) {
    		            
    			            var response = data._response.responseJSON;
    			            
    			            if(response.error == "fail") {
    			            	//access token생설 실패
    			            	return;
    			            }
    			            //tokenInfo.accessToken = response.access_token;
    			            naverToken = response.access_token;
    			            tokenInfo.refresh_token = response.refresh_token;
    		        		
    			            console.log(">>tokenInfo.access_token=" + naverToken);
    			            console.log(">>tokenInfo.refresh_token=" + tokenInfo.refresh_token);
    			            
    			            console.log("네이버 로그인 성공");
    			            
    			            fn_login(2);
    			            
    			            //no valid data in session 오류의 경우는
    						//동일한 요청(접근토큰발급요청)이 두번이상 호출되었을 경우에 발생합니다.
    						//callback으로 전달받은 code값은 reply attack을 방지하기 위하여
    						//최초 1회만 사용가능합니다. (접근토큰발급요청API호출시 사용)
    						//( 한번 사용된 (접근토큰이 발급되면) 기 사용한 code값은 만료가 되며
    						//이후 동일한 code값으로 재 요청을 수행하면 인증실패가 발생합니다. )
    			            
    						//롯데제이티비 소셜로그인 ---> 앱이름
    						//access_token =  AAAAN7cuiMVCzmeZCd3N9hm/KjrWnaT3/LK/zUkDCkk1248lg705d/n8ypvbrPm8AAbsVvfmeYh8WZYMU2c0ZxoOL38=
    						//refresh_token = YQwM4jdvIK0O8w1ngXFFLlvFKVuQdglgB18WVWkylCngipOwgMT7nmiidu5lUo1LexdKq94wBxzjE2geGmV0rJvfL5x85OfaiiiiPKxbT9z0Bpfl2T4nMSwpXocE8JCjWFZx
    		        		// 이곳에 별도의 submit 처리가 필요함
    						//copToken: access_token , copCls : 02
    			          
    		            });
    		            
    		    	 } else {
    		    		//Callback으로 전달된 데이터가 정상적이지 않을 경우에 대한 처리
    		    		//alert('Naver 정보 제공에 동의해 주셔야 Naver ID로 로그인하실 수 있습니다.');
    		            return ;
    		    	 }
    			}
			
    	 }
     });
		
	</script>	
</head>
<body >
<!--[JEH] 항공 비회원 데이터 - 20190725 -->
<form id="frmAir" method="post">
	<input type="hidden" name="r_sitecode" value="SELK138AX" readonly="readonly" />
	<input type="hidden" name="r_userid" value="lotteguest" readonly="readonly">
	<input type="hidden" name="r_sitemem" value="N" readonly="readonly">
	<input type="hidden" name="KSESID" value="air:b2c:SELK138AX:SELK138AX::00">
	<input type="hidden" name="returnurl" value="">
	<input type="hidden" name=r_name value="N" readonly="readonly">
	<input type="hidden" name="r_email" value="N" readonly="readonly">
	<input type="hidden" name="phoneno" value="N" readonly="readonly">
	<input type="hidden" name="rsvno" value="N" readonly="readonly">
	<input type="hidden" name="r_phoneno" value="" readonly="readonly">
</form>

	<!--content-->
	<div role="main" class="ui-content contentWrap">
	   <div class="nav navstitle">로그인</div>

		<div data-role="tabs" class="clause loginbox">
		   <div data-role="navbar" class="tabsnav mgT10">
			  <ul>
				<li><a href="#tab1" data-theme="a" data-ajax="false" id="loginTab" class="ui-btn-active">L.POINT 회원 로그인</a></li>
				<li><a href="#tab2" data-theme="a" data-ajax="false" id="guestTab">비회원 예약확인</a></li>
			  </ul>
		   </div>
			<!--L.POINT 회원 로그인 Tab-->
		   
		   <form id="frm" name="frm" method="post" enctype="application/x-www-form-urlencoded" onKeydown="keydown(event);">
	
			<div id="tab1" class="tabContent" > <!--tab1 Start-->
				<div class="contentBox pd1EM bdBox lgctnbox">
					<dl>
						<dt id="loginid">아이디입력</dt>
						<dd><input type="text" id="loginId" name="" class="" value="" placeholder="아이디"></dd>
						<dt id="password">비밀번호입력</dt>
						<dd><input type="password" id="loginPw"  name="" class=""  value ="" placeholder="비밀번호"></dd>
					</dl>
					<div class="more btnBG2"><a href="#" onclick="javascript:fn_LoginSubmit();">로그인</a></div>
					<div class="check_wrap chk_autologin">
						<div class="ui-checkbox"><label for="autoLogin" class="ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-left ui-checkbox-off" style="height:25px;"><i>자동로그인</i></label><input type="checkbox" id="autoLogin" data-cacheval="true"></div>
					</div>
				</div>
				
				<div data-role="navbar" class="tabsnav logctnbtn">
				  <ul>
					<li><a href="#" onclick="javascript:fn_findId();"><span>아이디 찾기</span></a></li>
					<li><a href="#" onclick="javascript:fn_findPw();"><span>비밀번호 찾기</span></a></li>
				  </ul>
		   		</div>
		   		<!-- Sns Login -->
				<ul class="sns_loginobx">
					<li><button type="button" data-role="none" onclick="fn_LoginWithNaver();"><em>네이버</em>로그인</button></li>
					<li><button type="button" data-role="none" onclick="checkLoginState();"><em>페이스북</em>로그인</button></li>
					<!-- <fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
					</fb:login-button> -->
				</ul>
		   		<div class="contentBox pd1EM bdBox bgf6f6f8 lglist1">
					<ul>
						<li><span>L.POINT 회원가입을 하시면 다양한 혜택을 받으실 수 있습니다.</span><a href="#" onclick="fn_lpoinIntro();" target="_new" class="mgL10 btn_login">L.POINT 회원 소개</a></li>
						<li><span>예약번호 분실 시, 고객센터 1577-6511로 문의주세요.</span><a href="#" onclick="moveMenu('/customer/faq.do', 1)" class="mgL10 btn_login">고객센터</a></li>
						<!-- <li>제주 실시간 항공권의 예약내역에 관한 예약 확인 및 결제를 원하시면 확인 버튼을 눌러주세요.<a href="http://dht3.lottejtb.com/reserve/rv_cf_login.html?agt=JTB" class="mgL10 btn_login">확인</a></li>  -->
					</ul>
				</div>
			    <div class="more"><a href="#" onclick="javascript:fn_join();">회원가입</a></div>
			</div><!--#tab1 End-->
			</form>
			<!--//L.POINT 회원 로그인 Tab-->
			<!--비회원 예약확인 Tab--> 
			<div id="tab2" class="tabContent"><!--tab2 Start-->
				<div class="contentBox pd1EM bdBox lgctnbox">
				<dl>
					<dt>이름</dt>
					<dd><input type="text" id="username" name="username" class="" value="" placeholder=""></dd>
					<!--<dt>이메일</dt>
					<dd><input type="text" id="useremail" name="useremail" class="" value="" placeholder=""></dd>-->
					<dt>휴대전화</dt>
					<dd><input type="text" id="r_phoneno" name="r_phoneno" class="" value="" placeholder="" onkeyup="key_up(this);"></dd>					
					<dt>예약번호</dt>
					<dd><input type="text"  id="rescd" name="rescd" class="" placeholder=""></dd>
				 </dl>
				<span>예약번호는 이메일/문자로 확인하실 수 있습니다.</span>
				<span>예약번호 입력은 "-"을 포함하여 입력해 주세요.</span>				
				</div>
				<div class="more btnBG2"><a href="#" onclick="fn_GuestLoginSubmit();">확인</a></div>
			   <div class="more"><a href="#" onclick="javascript:fn_join();">회원가입</a></div>
			</div><!--#tab2 End-->		
			<!--//비회원 예약확인 Tab-->	
			<!--bottom-->
			<script src="/resources/common/bottom.js"></script>
			<!--bottom-->	 
		 </div><!--tabs End-->
  </div><!--//contentWrap End-->
<!--//content-->
</body>

