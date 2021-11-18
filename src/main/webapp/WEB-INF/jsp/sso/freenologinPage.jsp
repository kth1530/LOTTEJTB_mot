<%@page import="java.net.URLEncoder"%>
<%@page import="com.lottejtb.comm.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 

<head>
<script src="<c:url value='/resources/common/js/hex_md5.js' />"></script>
<!-- 네이버 메소드 사용 스트립트 -->

<!-- <script type="text/javascript" charset="utf-8" src="/resources/common/js/naverLogin.js"></script> -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
<script type="text/javascript" charset="utf-8" src="https://static.nid.naver.com/js/naverLogin.js"></script>
<script type="text/javascript">

	<%
		String returnUrl = request.getParameter("returnUrl");
		System.out.println("###returnUrl#####=" + returnUrl);

		String selAir = "N";
		String selHotel = "N";
		String selRentCar = "N";
		try {		
			String [] arr = returnUrl.split("\\?");
			//System.out.println("0=" + arr[0] + "1=" +arr[1]);
			String [] div = arr[1].split("\\&");
			String [] air = div[0].split("\\=");
			String [] hotel = div[1].split("\\=");
			String [] rentcar = div[2].split("\\=");
			
			selAir = air[1];
			selHotel = hotel[1];
			selRentCar = rentcar[1];
			
			//System.out.println("selAir=" + selAir + "selHotel=" + selHotel + "selRentCar" + selRentCar);
		} catch(Exception e) {
			//e.printStackTrace();
			System.err.println("Array Process Error!");
		}
		
	%>	

	var loginid=""; 
	var pw="";
	var popYn = "${popYN}";
	
	//var loginType = 0; // 0: 일반로그인, 1: 네이버로그인, 2: 페이스북 로그인
	var facabookToken = "";
	var naverToken = "";
	
	
	var preUrl = window.localStorage.getItem('preUrl');
	
	//비회원예약
	var username= '';
	var email='';
	var reserveNumber='';
	
	//closeLink();
	if(popYn == 'Y'){
		closeLink();
	}
		
	// 회원 로그인
	function fn_LoginSubmit() {
		//
		loginid = $("#loginId").val();
		pw = $("#loginPw").val();
		
		if ( loginid == '') {
			alert("아이디를 입력해 주세요");
			$("#loginId").focus();
			return false;
		}
		if ( pw == '') {
			alert("비밀번호를 입력해 주세요");
			$("#loginPw").focus();
			return false;
		}
		// 통합인증서비스(SSO) 비밀번호 암호화 하여 전송   
		pw = $("#loginPw").val(hex_md5(pw));		
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
		
		fn_login(0);
	}; 
	
	
	//비회원 예약 확인
	function fn_GuestLoginSubmit() {
		
		username = $('#username').val();
		email = $('#useremail').val();
		reserveNumber = $('#rescd').val();
		
		if ( username == '') {
			alert("이름을 입력해주십시오");
			$('#username').focus();
			return false;
		}
		
		if (email == '') {
			alert("이메일을 입력해주십시오");
			$('#useremail').focus();
			return false;
		}
		
		if (!fn_emailCheck(email)){
		  	alert('이메일주소 형식이 맞지 않습니다');
		  	$('#useremail').focus();
			return false;
		}
		
		if ( reserveNumber == '') {
			alert("예약번호를 입력해주십시오");
			$('#rescd').focus();
			return false;
		}
		
		fn_checkGuestLogin();
		return true;
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
		
		var formData = new FormData();
		formData.append('loginId', $("#loginId").val()); //입력방은 회원사별 ID
		formData.append('password', $("#loginPw").val());     //패스퉈드
		formData.append('sid' , 'LOTTEJTB');  //기할당받은 사이트식별자 
		formData.append('sch', '');             //앱여부구분값(값이 없으면 모바일웹)
		if(nullToBlank(preUrl) == '') {
			if(devType == 0)
				formData.append('returnUrl', 'http://mdev.lottejtb.com/main.do');
			else
				formData.append('returnUrl', 'https://m.lottejtb.com/main.do');
		} else {
				
			<%
			 if(returnUrl == null || returnUrl == "") {  //preURL 값을 리턴 URL로 넘김.
			%>
				if(devType == 0)
					formData.append('returnUrl', 'http://mdev.lottejtb.com' + preUrl);
				else
					formData.append('returnUrl', 'https://m.lottejtb.com' + preUrl);
				console.log("preUrl=" + preUrl);
			<%
			 } else {   //commIntercepter에 의해서 들어오는 경우 
			%>
				if(devType == 0)
					formData.append('returnUrl', 'http://mdev.lottejtb.com' + '<%=CommUtil.filterXSS(returnUrl)%>');
				else
					formData.append('returnUrl', 'https://m.lottejtb.com' + '<%=CommUtil.filterXSS(returnUrl)%>');
			<%
			 }
			%>
		}
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
				console.log(list);
				
				try {
					if(loginType == 0)
						document.location.href = "/sso/loginProcess.do?id=" + list['loginId'] + "&pw=" + list['password'] + "&returnurl=" + list['returnUrl'] + "&sid=" + list['sid'];
					else if(loginType == 1) { //페이스북
						if(nullToBlank(facebookToken) != '')
							document.location.href = encodeURI("https://testmember.lpoint.com/door/sso/authMblUser.jsp?&returnurl=" + list['returnUrl'] + "&copToken=" + facebookToken + "&copCls=01&sid=" + list['sid']);
						//console.log(">>>>loginType1<<<<=" + document.location.href);
				   	}
					else if(loginType == 2) {  //네이버로긴
						if(nullToBlank(naverToken) != '')
							document.location.href = encodeURI("https://testmember.lpoint.com/door/sso/authMblUser.jsp?&returnurl=" + list['returnUrl'] + "&copToken=" + naverToken + "&copCls=02&sid=" + list['sid']);
						//console.log(">>>>loginType2<<<<=" + document.location.href);
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
				alert("조회 결과가 없습니다.");
				
			},
			complete : function(e) {
				console.log(e);
			}
			
		});
		
	};	
	
	//회원가입
    function fn_join() {
		if(devType == 0)
			moveLink("https://testmember.lpoint.com/door/user/mobile/login_common.jsp?sid=LOTTEJTB&returnurl=http://mdev.lottejtb.com/sso/loginChk.do?popYN=Y", '_system', 'location=no');
		else
			moveLink("https://member.lpoint.com/door/user/mobile/login_common.jsp?sid=LOTTEJTB&returnurl=https://m.lottejtb.com/sso/loginChk.do?popYN=Y", '_system', 'location=no');
	}
	
	//아이디 찾기
	function fn_findId() {
		if(devType == 0){
			moveLink("https://testmember.lpoint.com/door/user/mobile/requestId.jsp?sid=LOTTEJTB&returnurl=http://mdev.lottejtb.com/sso/loginChk.do?popYN=Y", '_self', 'location=no');
		}else{
			moveLink("https://member.lpoint.com/door/user/mobile/requestId.jsp?sid=LOTTEJTB&returnurl=https://m.lottejtb.com/sso/loginChk.do?popYN=Y", '_self', 'location=no');
		}
	}
	
	//비밀번호찾기
    function fn_findPw() {
    	if(devType == 0)
    		moveLink("https://testmember.lpoint.com/door/user/mobile/requestPasswd.jsp?sid=LOTTEJTB&returnurl=http://mdev.lottejtb.com/sso/loginChk.do?popYN=Y", '_self', 'location=no');
    	else
    		moveLink("https://member.lpoint.com/door/user/mobile/requestPasswd.jsp?sid=LOTTEJTB&returnurl=https://m.lottejtb.com/sso/loginChk.do?popYN=Y", '_self', 'location=no');
	}
	
	function fn_goRvt() {
		var url = escape('/free_reserve/reserve_info_step1.do'+ thisStepParam);
		var thisStepParam = '?selAir='+ '<%=CommUtil.filterXSS(selAir)%>' +'&selHotel='+ '<%=CommUtil.filterXSS(selHotel)%>' +'&selRentcar='+ '<%=CommUtil.filterXSS(selRentCar)%>';
		
		document.location.href ='/free_reserve/reserve_info_step1.do'+ thisStepParam;
		
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
	
	function keydown(event){
		if(event.keyCode==13){   // keyCode == 13  : 엔터키를 뜻함
			if( $("#loginId").val() == '' ) {
				$("#loginId").val().focus();
				return false;
			}
			if(  $("#loginPw").val() == '' ) {
				$("#loginPw").focus();
				return false;
			}	
			fn_LoginSubmit();
	  	}
	}	
	
	</script>
	<!---------------------------------------------------------------->	
	<!-- facebook 연동 초괴화-->
	
	<script>
	
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
           alert('Facebook 정보 제공에 동의해 주셔야 Facebook ID로 로그인하실 수 있습니다.');
	      
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
		    js.src = "http://connect.facebook.net/ko_KR/all.js";
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
		//String redirectUrl = "http://m.lottejtb.com:8085/";
		//redirectUrl = URLEncoder.encode(redirectUrl, "UTF-8");
		System.out.println("code=" + code);
	%>
	var code = '<%=CommUtil.filterXSS(code)%>';
	//if(code != null && code != '') {
		//loginType = 2;
	//}
	
	var redirectUrl = '';
	if(devType == 0) {
		redirectUrl = "http://mdev.lottejtb.com/sso/loginChk.do";
	} else {
		redirectUrl = "http://m.lottejtb.com/sso/loginChk.do";
	}
	redirectUrl = encodeURI(redirectUrl);
	
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
		document.location.href= "https://nid.naver.com/oauth2.0/authorize?client_id=OhsItzD2iA6zsuSRyyXI&response_type=code&redirect_uri=" + redirectUrl + "&state=" + state;
		//console.log("fn_LoginWithNaver = " + loginType);
	};
	
	//저장된 session 스토리지 삭제.
	function fn_naverLogout() {
		sessionStorage.clear();
		// 저장된 모든 값 삭제
		document.location.href="http://nid.naver.com/nidlogin.logout";
	}
	
	
    $(function() {
    	 //console.log("Naver callback!~!~ = " + loginType);
    	 if(nullToBlank(code) != '')  { //네이버로 로그인하는 경우에만.
    		 
			fn_checkLoginState();
		
			var tokenInfo = {accessToken:"", refresh_token:""};
			
			function fn_checkLoginState() {
				
		        var state = $.cookie("state_token");
		        console.log("state=" + state);
		  
		        if(naver.checkAuthorizeState(state) === "connected") {
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
<body>
	<!--content-->
	<div role="main" class="ui-content contentWrap">
	   <div data-role="navbar" data-iconpos="right" class="nav">
		<ul><li><a href="#navPop"  data-rel="popup" data-icon="carat-d" class="ui-nodisc-icon ui-alt-icon">로그인</a></li></ul>  
	   </div>

		<div class="clause loginbox nologin">
			<!--L.POINT 회원 로그인 Tab-->
			<div id="tab1" class="tabContent"><!--tab1 Start-->
				<div class="contentBox pd1EM bdBox lgctnbox">
				<dl>
					<dt>아이디입력</dt>
					<dd><input type="text" id="loginId" name="" class="" value="" placeholder="아이디"></dd>
					<dt>비밀번호입력</dt>
					<dd><input type="password" id="loginPw"  name="" class=""  value ="" placeholder="****"></dd>
				</dl>
				<div class="more btnBG2" onclick="javascript:fn_LoginSubmit();">로그인</div> 
				<div class="more" onclick="javascript:fn_goRvt();">비회원 예약</a></div>				
				</div>
				<div data-role="navbar" class="tabsnav logctnbtn">
				  <ul>
					<li><a href="#" onclick="javascript:fn_findId();">아이디 찾기</a></li>
					<li><a href="#" onclick="javascript:fn_findPw();">비밀번호 찾기</a></li>
				  </ul>
		   		</div>
		   		<!-- Sns Login -->
				<ul class="sns_loginobx">
					<li><button type="button" data-role="none" onclick="fn_LoginWithNaver();"><em>네이버</em>로그인</button></li>
					<li><button type="button" data-role="none" onclick="checkLoginState();"><em>페이스북</em>로그인</button></li>
					<!-- <fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
					</fb:login-button> -->
				</ul>
				<ul style="display:none">
					<li><button type="button" data-role="none" onclick="fn_logout();"><em>페이스북</em>로그아웃</button></li>
				</ul>
				<ul style="display:none">
					<li><button type="button" data-role="none" onclick="fn_naverLogout();"><em>네이버</em>로그아웃</button></li>
				</ul>
		   		<div class="contentBox pd1EM bdBox bgf6f6f8 lglist1">
					<ul>
						<li><span>L.POINT 회원가입을 하시면 다양한 혜택을 받으실 수 있습니다.</span><a href="#" onclick="fn_lpoinIntro();" target="_new" class="mgL10 btn_login">L.POINT 회원 소개</a></li>
						<li><span>예약번호 분실 시, 고객센터 1577-6511로 문의주세요.</span><a href="#" onclick="moveMenu('/customer/faq.do', 1)" class="mgL10 btn_login">고객센터</a></li>
						<!-- <li><span>제주 실시간 항공권의 예약내역에 관한 예약 확인 및 결제를 원하시면 확인 버튼을 눌러주세요.</span><a href="#" class="mgL10 btn_login">확인</a></li> -->
					</ul>
				</div>
			    <div class="more"><a href="#" onclick="javascript:fn_join();">회원가입</a></div>
			</div>	
			 
			<!--bottom-->
			<script src="/resources/common/bottom.js"></script>
			<!--bottom-->	 
		 </div><!--tabs End-->
  </div><!--//contentWrap End-->
</body>

