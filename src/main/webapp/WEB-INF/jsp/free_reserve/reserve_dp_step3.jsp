<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<%
	String cust_cd = (String) request.getAttribute("cust_cd");
	String knm = (String) request.getAttribute("knm");
	String sex = (String) request.getAttribute("id");
	String email = (String) request.getAttribute("email");
	String custGradeCd = (String) request.getAttribute("custGradeCd");
	String birthday = (String) request.getAttribute("birthday");
	
	Date systemDate = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
	String serverDay = sdf.format(systemDate);
%>

<head>
<script src="/resources/common/js/fit/reserve.js"></script>

<script type="text/javascript">
	
	var dp_nm = "";
	var dp_efname = "";
	var dp_ename = "";
	var dp_email = "";
	var dp_handphone = "";
	var dp_birthday = "";
	var dp_comment = "";

	function fn_init() {
		 $("#dp_nm").focus();
	}

	function fn_getParam() {
		dp_nm = $("#dp_nm").val();
		dp_efname = $("#dp_efname").val();
		dp_ename = $("#dp_ename").val();
		dp_email = $("#dp_email").val();
		dp_handphone = $("#dp_handphone").val();
		dp_birthday = $("#dp_birthday").val();
		// dp_comment = $("#dp_comment").val();
	}

	function fn_checkParam() {
		
		if(dp_nm == '' || dp_nm == null) {
			setAlert("예약자 이름을 입력해 주세요");
			$("#dp_nm").focus();
			return false;
		}

		if(dp_ename == '' || dp_ename == null) {
			setAlert("예약자 영문 이름을 입력해 주세요");
			$("#dp_ename").focus();
			return false;
		
		}
		
		if(dp_efname == '' || dp_efname == null) {
			setAlert("예약자 영문 성을 입력해 주세요");
			$("#dp_efname").focus();
			return false;
		
		}
		
		if(nullToBlank(sessionStorage.hotelBasketData) != '' && sessionStorage.hotelBasketData != '[]') {
			var  data = JSON.parse(sessionStorage.hotelBasketData);
						
			//DOTW 글자수 유효성 체크
			for(var i=0; i < data.length; i++) {
				if(data[i].setRoomData.suplrCd == 'DOTW') {
					if(dp_ename.length < 2 || dp_ename.length > 25) {
						setAlert("예약자 영문 이름의 길이는 2자~25자로 입력해주세요.");
						$("#dp_ename").focus();
						return false;
					
					}
					
					if(dp_efname.length < 2 || dp_efname.length > 25) {
						setAlert("예약자 영문 성의 길이는 2자~25자로 입력해주세요.");
						$("#dp_efname").focus();
						
						return false;
					}	
				}
			}
		}

		if(dp_email == '' || dp_email == null) {
			setAlert("이메일 주소를 입력해 주세요.");
			$("#dp_email").focus();
			return false;
		
		}		

		var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		
		if(regex.test(dp_email) === false) {
			alert("잘못된 이메일 형식입니다.");
			$("#dp_email").focus();
			return false;
		}	

		if(dp_handphone == '' || dp_handphone == null) {
			setAlert("핸드폰 번호를 입력해 주세요.");
			$("#dp_handphone").focus();
			return false;
		
		}
		
		if(dp_birthday == '' || dp_birthday == null) {
			setAlert("생년월일을 입력해 주세요.");
			$("#dp_birthday").focus();
			return false;
		}else if(dp_birthday.length != 8){
			setAlert("생년월일이 잘못 입력되었습니다.");
			$("#dp_birthday").focus();
			return false;
		}else{
			var serverDate = '<%=serverDay%>';
			serverYear = parseInt(serverDate.substring(0, 4));
			serverMonth = parseInt(serverDate.substring(4, 6));
			serverDay = parseInt(serverDate.substring(6, 8));
			
			var birthYear = parseInt($("#dp_birthday").val().substring(0, 4));
			var birthMonth = parseInt($("#dp_birthday").val().substring(4, 6));
			var birthDay = parseInt($("#dp_birthday").val().substring(6, 8));
			
			var birthDate = new Date(birthYear, birthMonth - 1, birthDay);
			var endDay = new Array(31,28,31,30,31,30,31,31,30,31,30,31); //각달의 마지막 날짜
			var lastDay = endDay[birthDate.getMonth() - 1]; 	//변경된 월의 마지막 날짜
			
			if( (birthDate.getMonth() == 2) && (((birthDate.getYear() % 4 == 0) && (birthDate.getYear() % 100 != 0)) || birthDate.getYear() % 400 == 0) ) {
				lastDay = 29;
			} 
						
			if(birthYear > serverYear && birthYear < (serverYear - 120)){
				setAlert("생년월일을 잘못 입력하셨습니다.");
				return false;
			}else if(birthMonth > 12){
				setAlert("생년월일을 잘못 입력하셨습니다.");
				return false;
			}else if(birthDay > lastDay){
				setAlert("생년월일을 잘못 입력하셨습니다.");
				return false;
			}
			
		}
		
		/* else if (calcAge($("#dp_birthday").val()) > 100) { // 나이 계산이 120이 넘을 경우 
			alert("생년월일을 잘못 입력하셨습니다.");
			$("#dp_birthday").focus();
			return false;
	    }*/
	    

		return true;
	}

	function fn_saveDpInfo() {
		var jSessionID = '<%=request.getSession().getId()%>';

		var rsvUserId = '${cust_cd}';
		var rsvUserNm = dp_nm;
		var rsvUserEngNm = dp_ename.toUpperCase(); 
		var rsvUserFirstEngNm = dp_efname.toUpperCase();
		var rsvHtel = dp_handphone;
		var rsvBirth = dp_birthday;
		var rsvEmail = dp_email;
		var rsvRemark = dp_comment;
		
		if(nullToBlank(sessionStorage.airSelData) != "" && sessionStorage.airSelData != '[]'){
			rsvAirBodyDtoT.updateT(rsvUserId, rsvUserNm , rsvUserEngNm, rsvHtel, rsvBirth, rsvEmail, rsvRemark, rsvUserFirstEngNm, jSessionID);
		}
		
		rsvMstUserInfo.updateT(function(){
			fn_goReserveStep4();
		}, rsvUserNm, rsvUserEngNm, rsvUserFirstEngNm, rsvEmail, rsvHtel, rsvBirth, rsvUserId, jSessionID);
	}

	function fn_goReserve() {
		fn_getParam();

		if(fn_checkParam()) {
			// WEB SQL 에 대표예약자 정보를 저장합니다. [TB_RSV_AIR_BODYDTO]
			fn_saveDpInfo();
		}
	}
	
	function limitText(field, maxChar){
		var ref = $(field),
			val = ref.val();
		if ( val.length >= maxChar ){
			ref.val(function() {
				return val.substr(0, maxChar);       
			});
		}
	}

	function hideKeyboard() {
		//this set timeout needed for case when hideKeyborad
		//is called inside of 'onfocus' event handler
		setTimeout(function() {

			//creating temp field
			var field = document.createElement('input');
			field.setAttribute('type', 'text');
			//hiding temp field from peoples eyes
			//-webkit-user-modify is nessesary for Android 4.x
			field.setAttribute('style', 'position:absolute; top: 0px; opacity: 0; -webkit-user-modify: read-write-plaintext-only; left:0px;');
			document.body.appendChild(field);

			//adding onfocus event handler for out temp field
			field.onfocus = function(){
			//this timeout of 200ms is nessasary for Android 2.3.x
			setTimeout(function() {

				field.setAttribute('style', 'display:none;');
				setTimeout(function() {
				document.body.removeChild(field);
				document.body.focus();
				}, 14);

			}, 200);
			};
			//focusing it
			field.focus();

		}, 50);
	}

    /**
     * 숫자만 입력하게 하는 함수
     * ex) : onkeypress="f_Onlynum()" style="ime-mode:disabled"
     */
    function f_Onlynum() {
        e = window.event;
        //숫자열 0 ~ 9 : 48 ~ 57, 키패드 0 ~ 9 : 96 ~ 105 ,8 : backspace, 46 : delete -->키코드값을 구분합니다. 저것들이 숫자랍니다.

        if((e.keyCode >= 48 && e.keyCode <= 57) || (e.keyCode >= 96 && e.keyCode <= 105) || e.keyCode == 8 || e.keyCode == 9 || e.keyCode == 46){
            return; //입력시킨다.
        }else{ //숫자가 아니면 넣을수 없다.
            e.returnValue=false;
        }
    }

	
	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();

		/******* 영문 성/이름 영문 대문자만 입력이 되도록 처리함 2017.03.24 *******/
		// $("#dp_ename").bind("keyup", function() { $(this).val($(this).val().toUpperCase()); });
		// $("#dp_efname").bind("keyup", function() { $(this).val($(this).val().toUpperCase()); });
		
		$("#dp_ename").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^A-Z]/gi,''));
			}
		});		

		$("#dp_efname").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^A-Z]/gi,''));
			}
		});

		$("#dp_handphone").keyup(function(){$(this).val( $(this).val().replace(/[^\!-z]/g,"") );} );
		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/

	});
</script>
</head>
<body>

	<form name="f_frm" id="f_frm" method="post">
		<input type="hidden" name="selAir" id="selAir"  value="${selAir}" />
		<input type="hidden" name="selHotel" id="selHotel" value="${selHotel}" />
		<input type="hidden" name="selRentcar" id="selRentcar" value="${selRentcar}" />
	</form>	
	
	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="navstitle freeback">
			예약자 정보<a href="javascript:history.back(-1);">뒤로</a>
		</div>
		<div class="free_reserve collapse fr_step3" ft-att="dp_reserve">
			<div class="ft_whbox mt7">
				
				<!-- 회원 예약 시 -->
			<%
				if(cust_cd != null && !cust_cd.equals("")) {
			%>				
				<table class="ft_table2 ft_thd_tl step3app">
					<colgroup>
						<col style="width:28%">
						<col style="width:72%">
					</colgroup>
					<tbody>
					<tr>
						<th>예약자 이름<em class="f_red">*</em></th>
							<td>
								<p>
									<input type="hidden" id="dp_userid" name="dp_userid" value="${cust_cd}"> 
									<%=knm%><input type="hidden" id="dp_nm" name="dp_nm" data-role="none" placeholder="한글" data-maxlength="5" value="<%=knm%>" ft-att="dp_nm" onkeyup="limitText(this, 5)"/>
								</p>
								<p>
									<input type="text" id="dp_ename" name="dp_ename" class="eng_name1" data-role="none"
										placeholder="영문 성" style='text-transform:uppercase;' value="" pattern='[A-Z]*' ft-att="dp_ename" style='ime-mode:inactive' pattern='[A-Z]*'/><input type="text" id="dp_efname" name="dp_efname" class="eng_name2"
										data-role="none" placeholder="영문 이름" pattern='[A-Z]*' style='text-transform:uppercase;' value="" style='ime-mode:inactive' pattern='[A-Z]*' ft-att="dp_efname"/>
								</p>
							</td>
					</tr>
					<tr>
						<th>이메일<em class="f_red">*</em></th>
						<td><%=email%><input type="hidden" id="dp_email" name="dp_email" data-role="none"
								placeholder="예) lottejtb@lottejtb.com" onkeyup="return f_IsValidEmail(this);" onchange="return f_IsValidEmail(this);" ft-att="dp_email" value="<%=email%>"/></td>
					</tr>
					<tr>
						<th>휴대폰번호<em class="f_red">*</em></th>
						<td><input type="number" id="dp_handphone" name="dp_handphone"  data-role="none" placeholder="예) 01012345678" pattern='[0-9]*' onkeydown='return f_Onlynum();' value="" ft-att="dp_handphone" onkeyup="limitText(this, 12)"/></td>
					</tr>
					<tr>
						<th>생년월일<em class="f_red">*</em></th>
						<td><input type="number" id="dp_birthday" name="dp_birthday"  data-role="none"
							placeholder="예) 20171231" pattern='[0-9]*' onkeydown='return f_Onlynum();' value="" ft-att="dp_birthday" onkeyup="limitText(this, 8)"/></td>
					</tr>
					</tbody>
				</table>
				<!-- 회원 예약 시 -->
			<%
				} else {
			%>	
				<!-- 비회원 예약시 -->
				<table class="ft_table2 ft_thd_tl step3app">
					<colgroup>
						<col style="width: 28%">
						<col style="width: 72%">
					</colgroup>
					<tbody>
						<tr>
							<th>예약자 이름<em class="f_red">*</em></th>
							<td>
								<p>
									<input type="hidden" id="dp_userid" name="dp_userid" value="${cust_cd}"> 
									<input type="text" id="dp_nm" name="dp_nm" data-role="none" placeholder="한글" data-maxlength="5" value="<%=knm%>" ft-att="dp_nm" onkeyup="limitText(this, 5)"/>
								</p>
								<p>
									<input type="text" id="dp_ename" name="dp_ename" class="eng_name1" data-role="none" placeholder="영문 성" style='text-transform:uppercase;' onpaste="javascript:return false;"  value="" ft-att="dp_ename" pattern='[A-Z]*'/>
									<input type="text" id="dp_efname" name="dp_efname" class="eng_name2" data-role="none" placeholder="영문 이름" style='text-transform:uppercase;' onpaste="javascript:return false;"  value="" ft-att="dp_efname" pattern='[A-Z]*'/>
								</p>
							</td>
						</tr>
						<tr>
							<th>이메일<em class="f_red">*</em></th>
							<td><input type="text" id="dp_email" name="dp_email" data-role="none"
								placeholder="예) lottejtb@lottejtb.com" onkeyup="return f_IsValidEmail(this);" onchange="return f_IsValidEmail(this);" ft-att="dp_email" value="<%=email%>"/></td>
						</tr>
						<tr>
							<th>휴대폰번호<em class="f_red">*</em></th>
							<td><input type="number" id="dp_handphone" name="dp_handphone"  data-role="none"
								placeholder="예) 01012345678" pattern='[0-9]*' onkeydown='return f_Onlynum();' value="" ft-att="dp_handphone" /></td>
						</tr>
						<tr>
							<th>생년월일<em class="f_red">*</em></th>
							<td><input type="number" id="dp_birthday" name="dp_birthday"  data-role="none"
								placeholder="예) 20171231" pattern='[0-9]*' onkeydown='return f_Onlynum();' value="" ft-att="dp_birthday" onkeyup="limitText(this, 8)"/></td>
						</tr>
					</tbody>
				</table>
			<%
				}
			%>
			</div>
			<!-- 버튼 -->
			<div class="btn_one air_tbtn">
				<button class="purple2" data-role="none" onClick="fn_goReserve()">다음</button>
			</div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//content-->