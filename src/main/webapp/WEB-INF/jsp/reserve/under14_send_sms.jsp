<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:ui="http://java.sun.com/jsf/facelets"
      xmlns:pw="http://www.tmaxsoft.com/prowave"
      xmlns:jtb="http://www.lotte.com/jtb"
      xmlns:c="http://java.sun.com/jstl/core"      
      xmlns:d="http://java.sun.com/jsp/jstl/core"      
      xmlns:fn="http://java.sun.com/jsp/jstl/functions" lang="ko" xml:lang="ko">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="content-language" content="kr" />
<meta http-equiv="content-style-type" content="text/css" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="Author" content="Fu:z" />

<title>Travel&amp;Life LOTTEJTB</title>

<link rel="stylesheet" type="text/css" href="/css/css2015/import.css" media="all" />
<link href="/css/popup.css" type="text/css" rel="stylesheet" />
<link rel="shortcut icon" href="/images/common/lottejtb.ico" type="image/x-icon"/>

<script type="text/javascript" src="/js/js2015/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/js/select_design.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/js2015/common.js"></script>

<script type="text/javascript">

var test = "";

function f_SmsCheck(){

	var returnParam;

	returnParam = "SUCCESS";


	//sms발송 대상 이름

	if( document.getElementById("reserveForm:dp_nm").value == "" ){

		alert("성명을 입력하여 주십시요.");

		document.getElementById("reserveForm:dp_nm").focus();

		returnParam = "FAIL";		 

		return false;		

	}	

	

	//휴대전화 정보입력

	if( document.getElementById("reserveForm:dp_tel2").value == "" ){

		alert("휴대전화를 입력하여 주십시오.");

		document.getElementById("reserveForm:dp_tel2").focus();

		returnParam = "FAIL";		 

		return false;		

	}
	
	if( document.getElementById("reserveForm:dp_tel3").value == "" ){

		alert("휴대전화를 입력하여 주십시오.");

		document.getElementById("reserveForm:dp_tel3").focus();

		returnParam = "FAIL";		 

		return false;		

	}
	

	
	var phone1 = window.opener.document.getElementById("reserveForm:dp_tel1").value;
	var phone2 = window.opener.document.getElementById("reserveForm:dp_tel2").value;
	var phone3 = window.opener.document.getElementById("reserveForm:dp_tel3").value;	
	var phoneNum = null;
	
	//var phoneA = document.getElementById("reserveForm:dp_tel1").value;
	var phoneB = document.getElementById("reserveForm:dp_tel2").value;
	var phoneC = document.getElementById("reserveForm:dp_tel3").value;

	
	if(document.reserveForm.dp_tel1.selectedIndex == 0){
		phoneNum = "010"+phoneB+phoneC;
	}
	if(document.reserveForm.dp_tel1.selectedIndex == 1){
		phoneNum = "011"+phoneB+phoneC;
	}
	if(document.reserveForm.dp_tel1.selectedIndex == 2){
		phoneNum = "016"+phoneB+phoneC;
	}
	if(document.reserveForm.dp_tel1.selectedIndex == 3){
		phoneNum = "017"+phoneB+phoneC;
	}
	if(document.reserveForm.dp_tel1.selectedIndex == 4){
		phoneNum = "018"+phoneB+phoneC;
	}
	if(document.reserveForm.dp_tel1.selectedIndex == 5){
		phoneNum = "019"+phoneB+phoneC;
	}	
	
	document.reserveForm.action = "https://www.lottejtb.com/xhtml/popup/send_sms_process.jsp?phoneNum="+phoneNum;

	alert("SMS가 정상적으로 발송되었습니다.");
	//SMS발송 후 14세 미만 개인정보 수집동의 약관 동의
	window.opener.document.getElementById("reserveForm:inconfirm6").checked = true;	

	document.reserveForm.submit(); 

	
}

function f_onSuccess(){
	document.domain = "lottejtb.com";
	alert("SMS가 정상적으로 발송되었습니다.");
	//SMS발송 후 14세 미만 개인정보 수집동의 약관 동의
	window.opener.document.getElementById("reserveForm:inconfirm6").checked = true;
	window.self.close();	
}

	function InitSetting(){

	//이름
	var dpNm = window.opener.document.getElementById("reserveForm:dpNm").value;
	var phone1 = window.opener.document.getElementById("reserveForm:dp_tel1").value;
	var phone2 = window.opener.document.getElementById("reserveForm:dp_tel2").value;
	var phone3 = window.opener.document.getElementById("reserveForm:dp_tel3").value;

	
		
	document.getElementById("reserveForm:phoneNum").value = phone1+phone2+phone3;

	//이름
	document.getElementById("reserveForm:dp_nm").value = dpNm;	

	//휴대폰 2,3번째 자리
	document.getElementById("reserveForm:dp_tel2").value = phone2;	
	document.getElementById("reserveForm:dp_tel3").value = phone3;	
	
	//휴대폰 첫번째 자리 selected
	if(phone1 == "010"){
		document.reserveForm.dp_tel1.selectedIndex = 0;
	}
	if(phone1 == "011"){
		document.reserveForm.dp_tel1.selectedIndex = 1;
	}
	if(phone1 == "016"){
		document.reserveForm.dp_tel1.selectedIndex = 2;
	}
	if(phone1 == "017"){
		document.reserveForm.dp_tel1.selectedIndex = 3;
	}
	if(phone1 == "018"){
		document.reserveForm.dp_tel1.selectedIndex = 4;
	}
	if(phone1 == "019"){
		document.reserveForm.dp_tel1.selectedIndex = 5;
	}	

	
}
</script>

</head>

<body onload="javascript:InitSetting();">
<!--<form name="reserveForm">-->
<pw:form id="reserveForm" method="post">



	<div class="mail_pop">

		<div class="mail_title">	<h1>SMS 발송</h1></div>

		<div class="mail_content">

			<div class="ta_cont">

				<table class="table08 tal" summary="보내는사람, 받는사람, 제목, 간단메모로 구성되어짐">

					<caption>	메일공유</caption>

					<colgroup>

					<col width="20%" />

					<col width="80%" />

					</colgroup>

					<tbody>

						<tr>

							<th scope="row" class="left_line"><strong class="fd40000">*</strong> 이름</th>
								<td>
									<input type="text" title="이름을 입력해주세요." id="dp_nm" class="phone_input" name="dp_nm" maxlength="12" value="" />
								</td>
							<!--<td id="dispNm"></td>-->

						</tr>

						<tr>

							<th scope="row" class="left_line"><strong class="fd40000">*</strong> 휴대전화</th>

							<td>

								<!--<label for="dp_tel1">휴대폰 앞번호 선택</label>-->

								<select id="dp_tel1" name="dp_tel1" class="w78 clauses_select">
									<!--<option value="010" selected="selected">010</option>-->
									<option value="010" >010</option>
									<option value="011" >011</option>
									<option value="016" >016</option>
									<option value="017" >017</option>
									<option value="018" >018</option>
									<option value="019" >019</option>
								</select>

								-

								<!--<label for="dp_tel2">휴대폰 가운데 번호 입력</label>-->

								<input type="text" title="휴대폰 가운데 번호를 입력해주세요." id="dp_tel2" class="phone_input" name="dp_tel2" value="" maxlength="4" onkeydown="return f_Onlynum();" />

								-

								<!--<label for="dp_tel3">휴대폰 끝번호 입력</label>-->

								<input type="text" title="휴대폰 끝번호를 입력해주세요." id="dp_tel3" class="phone_input"  name="dp_tel3" value="" maxlength="4" onkeydown="return f_Onlynum();" />
								
								<input type="hidden" id="phoneNum" name="phoneNum" value="" />

							</td>

						</tr><br/><br/>


					</tbody>

				</table>

				<!--<p class="mt15 mb5" style="float:none">이메일 발송 서비스 제공을 위해 아래와 같이 개인정보를 수집할 수 있습니다.</p>

				<p><input type="checkbox" title="이메일 발송 서비스를 위한 개인정보 수집 항목에 동의합니다." /> 이메일 발송 서비스를 위한 개인정보 수집 및 이용에 동의합니다.</p>-->

				<table class="table01 mt10">

					<caption>수집항목, 수집목적, 보유기간으로 구성된 표</caption>

					<colgroup>

						<col style="width:33%" />

						<col />

						<col style="width:33%" />

					</colgroup>

					<thead>

						<tr>

							<th scope="col">수집항목</th>

							<th scope="col">수집목적</th>

							<th scope="col">보유기간</th>

						</tr>

					</thead>

					<tbody>

						<tr>

							<td>이름, 휴대전화번호</td>

							<td>법정대리인 동의사실 확인문자 발송</td>

							<!--<td><span style="font-size:2px;font-weight:bold;">즉시 파기</span></td>-->
							<td>즉시 파기</td>

						</tr>

					</tbody>

				</table>

				<p class="mt15 mb5" style="float:none">*개인정보 수집 및 이용에 대하여 동의를 거부할 수 있으나, 동의 거부 시 서비스 이용이 불가능함을 안내드립니다.</p>
			</div>
			
			<input type="text" name="test1" id="test1" value=""/>

			<div class="mail_btn01">
			
					<input type="button" name="sendSms" id="sendSms" value="SMS발송" onclick="javascript:f_SmsCheck();" />
					
					<!--<input type="button" name="sendSms" id="sendSms" value="SMS발송" />-->
					


				<!--<a href="#none" onclick="return false;"><img src="/images/img2015/common/btn_re.gif" alt="다시작성" onclick="reset(); return false;"/></a>-->

			</div>

		</div>

	</div>
</pw:form>	
<!--</form>	-->

</body>

</html>