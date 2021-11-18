<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_email.jsp
	// 설명 : 이메일 보내기
	String cust_cd = (String) request.getAttribute("cust_cd");
	String knm = (String) request.getAttribute("knm");
	String email = (String) request.getAttribute("email");
	String age = (String) request.getAttribute("age");
	String id = (String) request.getAttribute("id");

	String sex = (String) request.getAttribute("sex");
	String birthday = (String) request.getAttribute("birthday");
	String custGradeCd = (String) request.getAttribute("custGradeCd");

	//String rsvSeqno = (String) request.getAttribute("rsvSeqno");

%>
<script src="/resources/common/js/utils.js"></script>
<script src="/resources/common/js/reserve.js"></script>

<script type='text/javascript'>
	var receiver_cnt = 1;
	var from_name = "";
	var from_email = "";
	var subject = "";
	var contents_mapping = "";
	
	var to_name1 = "";
	var to_name2 = "";
	var to_name3 = "";
	var to_name4 = "";
	var to_name5 = "";
	var to_name6 = "";
	var to_name7 = "";
	var to_name8 = "";
	var to_name9 = "";
	var to_name10 = "";

	var to_email1 = "";
	var to_email2 = "";
	var to_email3 = "";
	var to_email4 = "";
	var to_email5 = "";
	var to_email6 = "";
	var to_email7 = "";
	var to_email8 = "";
	var to_email9 = "";
	var to_email10 = "";

	function init() {
		var html = "";

		html = html + "								<tr>";
		html = html + "									<th>이름<em class='f_red'>*</em></th>";
		html = html + "									<td><input type='text' id='to_name"+receiver_cnt+"' name='to_name"+receiver_cnt+"' placeholder='이름을 입력하세요'/></td>";
		html = html + "								</tr>";
		html = html + "								<tr>";
		html = html + "									<th>이메일<em class='f_red'>*</em></th>";
		html = html + "<td><input type='text' class='email2_input' style='width:80px' id='to_email1' name='to_email1' value=''/>@";
		html = html + " <span id='selectbox_to_email1' name='selectbox_to_email1'></span>";
		html = html + "</td>";
		html = html + "								</tr>";

		$('#receiver_list').append(html);

		fn_srchFromEmailCode();
		fn_srchToEmailCode (1);
	}

	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}


	function addReceiver() {
		receiver_cnt = receiver_cnt + 1;
		if(receiver_cnt < 11) {
			var html = "";
			html = html + "								<tr>";
			html = html + "									<th>이름<em class='f_red'>*</em></th>";
			html = html + "									<td><input type='text' id='to_name"+receiver_cnt+"' name='to_name"+receiver_cnt+"' placeholder='이름을 입력하세요'/></td>";
			html = html + "								</tr>";
			html = html + "								<tr>";
			html = html + "									<th>이메일<em class='f_red'>*</em></th>";
			html = html + "<td><input type='text' class='email2_input' style='width:80px' id='to_email"+receiver_cnt+"' name='to_email"+receiver_cnt+"' value=''/>@";
			html = html + " <span id='selectbox_to_email"+receiver_cnt+"' name='selectbox_to_email"+receiver_cnt+"'></span>";
			html = html + "</td>";
			html = html + "								</tr>";



			$('#receiver_list').append(html);
			fn_srchToEmailCode (receiver_cnt);
		} else {
			alert("받는 사람 추가는 최대 10명 까지 추가하실 수 있습니다.");
		}
	}

	// 이메일 주소 조회 
	function fn_srchFromEmailCode () {
		var formData = new FormData();
		formData.append("grp_cd", "MAILGB");
		var comcodeList = null;

		cfn_ajax({
			url : "/reserve/srchSysComCodeAjax.do",
			type : "POST",
			data : formData,
			async : false,
			dataType : "json",
			cache : false,
			noloading : "no",
			timeOut : (5 * 60 * 1000),
			success : function(res) {
				comcodeList = res.comcodeList;
				var html = "";
				html = html + "<select id='from_email2' name='from_email2' class='email2_select' onchange='direct_from_email()'>";
				if (comcodeList != null) {
					for (var i = 0; i < comcodeList.length; i++) {
						if(i == 0) {
							html = html + "<option value='"+comcodeList[i]["cd_nm"]+"' selected>" + comcodeList[i]["cd_nm"] + "</option>";
						} else {
							html = html + "<option value='"+comcodeList[i]["cd_nm"]+"'>" + comcodeList[i]["cd_nm"] + "</option>";
						}
					}
					html = html + "<option value='direct'>직접입력<option>";
				}
				html = html + "</select>";
				$("#selectbox_from_email").html(html);

			},
			error : function(err) {
				console.log(err);
			},
			complete : function() {
			}
		});
	}

	// 이메일 주소 직접 입력일 경우 
	function direct_from_email() {
		dp_email2 = $("#from_email2 option:selected").val();

		if (dp_email2 == "direct") {
			var html = "<input type='text' id='from_email2' name='from_email2' class='email2_input'  placeholder='이메일을 입력해주세요' style='width:80px' onkeyup='return f_IsValidEmail2(this);' value=''>";
			$("#selectbox_from_email").html(html);
		}
	}

	// 이메일 주소 조회 
	function fn_srchToEmailCode (receiver) {
		var formData = new FormData();
		formData.append("grp_cd", "MAILGB");
		var comcodeList = null;

		cfn_ajax({
			url : "/reserve/srchSysComCodeAjax.do",
			type : "POST",
			data : formData,
			async : false,
			dataType : "json",
			cache : false,
			noloading : "no",
			timeOut : (5 * 60 * 1000),
			success : function(res) {
				comcodeList = res.comcodeList;
				var html = "";
				html = html + "<select id='to2_email"+receiver+"' name='to2_email"+receiver+"' class='email2_select' onchange='direct_to_email("+receiver+")'>";
				if (comcodeList != null) {
					for (var i = 0; i < comcodeList.length; i++) {
						if(i == 0) {
							html = html + "<option value='"+comcodeList[i]["cd_nm"]+"' selected>" + comcodeList[i]["cd_nm"] + "</option>";
						} else {
							html = html + "<option value='"+comcodeList[i]["cd_nm"]+"'>" + comcodeList[i]["cd_nm"] + "</option>";
						}
					}
					html = html + "<option value='direct'>직접입력<option>";
				}
				html = html + "</select>";

				var tag = "#selectbox_to_email" + receiver;
				$(tag).html(html);

			},
			error : function(err) {
				console.log(err);
			},
			complete : function() {
			}
		});
	}

	// 이메일 주소 직접 입력일 경우 
	function direct_to_email(receiver) {
		dp_email2 = $("#to2_email"+receiver+" option:selected").val();

		if (dp_email2 == "direct") {
			var html = "<input type='text' id='to2_email"+receiver+"' class='email2_input' style='width:80px' name='to2_email"+receiver+"' placeholder='이메일을 입력해주세요' onkeyup='return f_IsValidEmail2(this);' value=''>";
			var tag = "#selectbox_to_email" + receiver;
			$(tag).html(html);
		}
	}

	function deleteReceiver() {
		receiver_cnt = receiver_cnt - 1;
		var tag = "#receiver" + receiver_cnt;

		$(tag).hide();
	}

	function syncEmail() {
		var from_name = $("#from_name").val();
		var from_email1 = "";
		var from_email2 = "";

		<%
			if(cust_cd == null || cust_cd.equals("")) {
		%>
			from_email1 = $("#from_email1").val();
			from_email2 = $("#from_email2 option:selected").val();
		<%
			} else {
		%>
			from_email1 = $("#from_email").val();
			var form_email = from_email1.split("@");
			from_email1 = form_email[0];
			from_email2 = form_email[1];
		<%
			}
		%>

		console.log("from_name : " + from_name);
		console.log("from_email1 : " + from_email1);
		console.log("from_email2 : " + from_email2);
		
		$("#to_name1").val(from_name);
		$("#to_email1").val(from_email1);
		// $("#to2_email1 option:eq("+from_email2+")").attr("selected", "selected");
		$("#to2_email1 option[value='" + from_email2 + "']").attr("selected","selected");
	}

	function check_param() {

		if(from_name == null || from_name == "") {
			alert("보내는 분 이름을 입력해 주세요.");
			$('#from_name').focus();
			return false;
		}

		if(from_email == null || from_email == "") {
			alert("보내는 분 이메일 주소를 입력해 주세요.");
			$('#from_email').focus();
			return false;
		}

		if(!checkEmail(from_email)) {
			return false;
		}



		if(receiver_cnt > 0) {

			if(to_name1 == null || to_name1 == "") {
				alert("받는 분 이름을 입력해 주세요.");
				$('#to_name1').focus();
				return false;
			}

			if(to_email1 == null || to_email1 == "") {
				alert("받는 분 이메일 주소를 입력해 주세요.");
				$('#to_email1').focus();
				return false;
			}

			if(!checkEmail(to_email1)) {
				return false;
			}

		}

		if(receiver_cnt > 1) {

			if(to_name2 == null || to_name2 == "") {
				alert("받는 분 이름을 입력해 주세요.");
				$('#to_name2').focus();
				return false;
			}

			if(to_email2 == null || to_email2 == "") {
				alert("받는 분 이메일 주소를 입력해 주세요.");
				$('#to_email2').focus();
				return false;
			}

			if(!checkEmail(to_email2)) {
				return false;
			}

		}

		if(receiver_cnt > 2) {

			if(to_name3 == null || to_name3 == "") {
				alert("받는 분 이름을 입력해 주세요.");
				$('#to_name3').focus();
				return false;
			}

			if(to_email3 == null || to_email3 == "") {
				alert("받는 분 이메일 주소를 입력해 주세요.");
				$('#to_email3').focus();
				return false;
			}

			if(!checkEmail(to_email3)) {
				return false;
			}

		}

		if(receiver_cnt > 3) {


			if(to_name4 == null || to_name4 == "") {
				alert("받는 분 이름을 입력해 주세요.");
				$('#to_name4').focus();
				return false;
			}

			if(to_email4 == null || to_email4 == "") {
				alert("받는 분 이메일 주소를 입력해 주세요.");
				$('#to_email4').focus();
				return false;
			}

			if(!checkEmail(to_email4)) {
				return false;
			}

		}

		if(receiver_cnt > 4) {

			if(to_name5 == null || to_name5 == "") {
				alert("받는 분 이름을 입력해 주세요.");
				$('#to_name5').focus();
				return false;
			}

			if(to_email5 == null || to_email5 == "") {
				alert("받는 분 이메일 주소를 입력해 주세요.");
				$('#to_email5').focus();
				return false;
			}

			if(!checkEmail(to_email5)) {
				return false;
			}

		}

		if(receiver_cnt > 5) {

			if(to_name6 == null || to_name6 == "") {
				alert("받는 분 이름을 입력해 주세요.");
				$('#to_name6').focus();
				return false;
			}


			if(to_email6 == null || to_email6 == "") {
				alert("받는 분 이메일 주소를 입력해 주세요.");
				$('#to_email6').focus();
				return false;
			}

			if(!checkEmail(to_email6)) {
				return false;
			}

		}

		if(receiver_cnt > 6) {

			if(to_name7 == null || to_name7 == "") {
				alert("받는 분 이름을 입력해 주세요.");
				$('#to_name7').focus();
				return false;
			}

			if(to_email7 == null || to_email7 == "") {
				alert("받는 분 이메일 주소를 입력해 주세요.");
				$('#to_email7').focus();
				return false;
			}

			if(!checkEmail(to_email7)) {
				return false;
			}

		}

		if(receiver_cnt > 7) {

			if(to_name8 == null || to_name8 == "") {
				alert("받는 분 이름을 입력해 주세요.");
				$('#to_name8').focus();
				return false;
			}

			if(to_email8 == null || to_email8 == "") {
				alert("받는 분 이메일 주소를 입력해 주세요.");
				$('#to_email8').focus();
				return false;
			}

			if(!checkEmail(to_email8)) {
				return false;
			}

		}

		if(receiver_cnt > 8) {

			if(to_name9 == null || to_name9 == "") {
				alert("받는 분 이름을 입력해 주세요.");
				$('#to_name9').focus();
				return false;
			}


			if(to_email9 == null || to_email9 == "") {
				alert("받는 분 이메일 주소를 입력해 주세요.");
				$('#to_email9').focus();
				return false;
			}

			if(!checkEmail(to_email9)) {
				return false;
			}

		}

		if(receiver_cnt > 9) {

			if(to_name10 == null || to_name10 == "") {
				alert("받는 분 이름을 입력해 주세요.");
				$('#to_name10').focus();
				return false;
			}

			if(to_email10 == null || to_email10 == "") {
				alert("받는 분 이메일 주소를 입력해 주세요.");
				$('#to_email10').focus();
				return false;
			}

			if(!checkEmail(to_email10)) {
				return false;
			}

		}

		if(subject == null || subject == "") {
			alert("제목을 입력해 주세요.");
			$('#subject').focus();
			return false;
		}

		if(contents_mapping == null || contents_mapping == "") {
			alert("간단 메모를 입력해 주세요.");
			$('#contents_mapping').focus();
			return false;
		}

		return true;
	}

	function fn_GetParam() {
		from_name =  $('#from_name').val();
		subject = $('#subject').val();
		contents_mapping = $('#contents_mapping').val();
		var from_email1 = '';
		var from_email2 ='';

		<%
			if(cust_cd == null || cust_cd.equals("")) {
		%>
			from_email1 = $("#from_email1").val();
			from_email2 = $("#from_email2 option:selected").val();

			if(nullToBlank(from_email2) == '') {
				from_email2 = $("#from_email2").val();				
			}
			from_email = from_email1 + "@" + from_email2;
		<%
			} else {
		%>
			from_email = $("#from_email").val();
		<%
			}
		%>
		
		if(receiver_cnt > 0) {
			to_name1 =  $("#to_name1").val();

			if(nullToBlank($("#to2_email1  option:selected").val()) != '') {
				to_email1 =  $("#to_email1").val() + "@" + $("#to2_email1 option:selected").val();
			} else {
				to_email1 =  $("#to_email1").val() + "@" + $("#to2_email1").val();
			}
		}

		if(receiver_cnt > 1) {
			to_name2 =  $("#to_name2").val();
			if(nullToBlank($("#to2_email2  option:selected").val()) != '') {
				to_email2 =  $("#to_email2").val() + "@" + $("#to2_email2 option:selected").val();
			} else {
				to_email2 =  $("#to_email2").val() + "@" + $("#to2_email2").val();
			}
		}

		if(receiver_cnt > 2) {
			to_name3 =  $("#to_name3").val();
			if(nullToBlank($("#to2_email3  option:selected").val()) != '') {
				to_email3 =  $("#to_email3").val() + "@" + $("#to2_email3 option:selected").val();
			} else {
				to_email3 =  $("#to_email3").val() + "@" + $("#to2_email3").val();
			}

		}

		if(receiver_cnt > 3) {
			to_name4 =  $("#to_name4").val();
			if(nullToBlank($("#to2_email4  option:selected").val()) != '') {
				to_email4 =  $("#to_email4").val() + "@" + $("#to2_email4 option:selected").val();
			} else {
				to_email4 =  $("#to_email4").val() + "@" + $("#to2_email4").val();
			}
		}

		if(receiver_cnt > 4) {
			to_name5 =  $("#to_name5").val();
			if(nullToBlank($("#to2_email5  option:selected").val()) != '') {
				to_email5 =  $("#to_email5").val() + "@" + $("#to2_email5 option:selected").val();
			} else {
				to_email5 =  $("#to_email5").val() + "@" + $("#to2_email5").val();
			}
		}

		if(receiver_cnt > 5) {
			to_name6 =  $("#to_name6").val();
			if(nullToBlank($("#to2_email6  option:selected").val()) != '') {
				to_email6 =  $("#to_email6").val() + "@" + $("#to2_email6 option:selected").val();
			} else {
				to_email6 =  $("#to_email6").val() + "@" + $("#to2_email6").val();
			}
		}

		if(receiver_cnt > 6) {
			to_name7 =  $("#to_name7").val();
			if(nullToBlank($("#to2_email7  option:selected").val()) != '') {
				to_email7 =  $("#to_email7").val() + "@" + $("#to2_email7 option:selected").val();
			} else {
				to_email7 =  $("#to_email7").val() + "@" + $("#to2_email7").val();
			}
		}

		if(receiver_cnt > 7) {
			to_name8 =  $("#to_name8").val();
			if(nullToBlank($("#to2_email8  option:selected").val()) != '') {
				to_email8 =  $("#to_email8").val() + "@" + $("#to2_email8 option:selected").val();
			} else {
				to_email8 =  $("#to_email8").val() + "@" + $("#to2_email8").val();
			}
		}

		if(receiver_cnt > 8) {
			to_name9 =  $("#to_name9").val();
			if(nullToBlank($("#to2_email9  option:selected").val()) != '') {
				to_email9 =  $("#to_email9").val() + "@" + $("#to2_email9 option:selected").val();
			} else {
				to_email9 =  $("#to_email9").val() + "@" + $("#to2_email9").val();
			}
		}

		if(receiver_cnt > 9) {
			to_name10 =  $("#to_name10").val();
			if(nullToBlank($("#to2_email10  option:selected").val()) != '') {
				to_email10 =  $("#to_email10").val() + "@" + $("#to2_email10 option:selected").val();
			} else {
				to_email10 =  $("#to_email10").val() + "@" + $("#to2_email10").val();
			}
		}

	}

	// 메일 문의  
	function saveConsultMail() {
		// 미 로그인 시 

		if(confirm("메일을 보내시겠습니까?")) {
			fn_GetParam();

			// 파라미터 값이 유효할 때 
			if(check_param()) {

				var formData = new FormData();
				formData.append("from_name", from_name);
				formData.append("from_email", from_email);
				formData.append("receiver_cnt", receiver_cnt);
				formData.append("to_name1", to_name1);
				formData.append("to_email1", to_email1);
				formData.append("to_name2", to_name2);
				formData.append("to_email2", to_email2);
				formData.append("to_name3", to_name3);
				formData.append("to_email3", to_email3);
				formData.append("to_name4", to_name4);
				formData.append("to_email4", to_email4);
				formData.append("to_name5", to_name5);
				formData.append("to_email5", to_email5);
				formData.append("to_name6", to_name6);
				formData.append("to_email6", to_email6);
				formData.append("to_name7", to_name7);
				formData.append("to_email7", to_email7);
				formData.append("to_name7", to_name7);
				formData.append("to_email7", to_email7);
				formData.append("to_name8", to_name8);
				formData.append("to_email8", to_email8);
				formData.append("to_name9", to_name9);
				formData.append("to_email9", to_email9);
				formData.append("to_name10", to_name10);
				formData.append("to_email10", to_email10);

				formData.append("subject", subject);
				formData.append("contents_mapping", contents_mapping);
				formData.append("rsvSeqno", fitRsvNo);

				cfn_ajax({
					url: "/goods/saveConsultMailAjax2.do",
					type: "POST",
					data: formData,
					async: false,
					dataType: "json",
					cache: false,
					noloading:"no",
					timeOut: (5*60*1000),
					success: function(res) {		
						// var saveCnt = res.saveCnt;
						// console.log("saveCnt >>> " +  saveCnt);

						alert("메일발송이 정상적으로 처리되었습니다.");
						
					},
					error:function(err){
						console.log(err);
						alert("메일발송이 정상적으로 처리가 되지 않았습니다.");
					},
					complete:function(){

						closePopup();

					}
				});
			}
		}
	}

	function clearConsultMail() {
		$("#subject").val("");
		$("#contents_mapping").val("");
	}

	function checkEmail(email) {
			console.log("email >> " + email);

			var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			
			if(regex.test(email) === false) {
				alert("잘못된 이메일 형식입니다.");
				return false;
			} else {
				return true;
			}

	}

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		init();
	});

	
</script>

<div class='layerPopup'>
	<div class='layerPop'>
		<!-- 내용시작 -->
		<div class='popCon'>
			<div class='popHead'>
				<div class='popTpart'>
					<strong class='popTitle'>메일보내기</strong>
					<button type='button' class='layerClose'>
						<img src='/resources/images/btn/btn_exit.png' alt='레이어 닫기' onClick='closePopup()'>
					</button>
				</div>
			</div>
			<div class='cntain mailsend'>
				<dl class='pop_chk_list pop_chk_list2'>
					<dt>보내는 사람</dt>
					<dd>
						<table class='pop_table2 pop_table2_left'>
							<colgroup>
								<col style='width: 30%' />
								<col style='width: 70%' />
							</colgroup>
							<tbody>
							<%
								// 비회원 일 경우 
								if(cust_cd == null || cust_cd.equals("")) {
							%>
								<tr>
									<th>이름<em class='f_red'>*</em></th>
									<td><input type='text' name="from_name" id="from_name" value="" placeholder='이름을 입력해주세요'/></td>
								</tr>
								<tr>
									<th>이메일<em class='f_red'>*</em></th>
									<td><input type='text' class='email2_input' style='width:80px' id='from_email1' name='from_email1' value=""/>@ <span id="selectbox_from_email" name="selectbox_from_email"></span></td>
								</tr>
							<%
								// 회원 일 경우 
								} else {
							%>
								<tr>
									<th>이름<em class='f_red'>*</em></th>
									<td><input type='text' name="from_name" id="from_name" value="<%=knm%>" placeholder='이름을 입력해주세요' readonly/></td>
								</tr>
								<tr>
									<th>이메일<em class='f_red'>*</em></th>
									<td><input type='text' class='email2_input' id='from_email' name='from_email' value="<%=email%>" readonly/></td>
								</tr>							
							<%		
								}
							%>
							</tbody>
						</table>
					</dd>
				</dl>
				<dl class='pop_chk_list pop_chk_list2 mt7'>
					<dt>
						받는 사람
						<div class='email2_btn'>
							<button type='button' onClick="addReceiver()">받는사람 추가</button>
							<button type='button' onClick="deleteReceiver()">삭제</button>
						</div>
					</dt>
					<dd class='email2_chk'>
						<p class='chkbox'>
							<span><input id='chk_if3' type='checkbox' id="agreement01" onclick="syncEmail()"/></span> 
							<label for='agreement01'>보내는 사람 동일</label>
						</p>
					</dd>					
					<dd>
						<table class='pop_table2 pop_table2_left' ft-att='receiver1' id='receiver1' name='receiver1'>
							<colgroup>
								<col style='width: 30%' />
								<col style='width: 70%' />
							</colgroup>
							<!-- 받는 사람 리스트 -->
							<tbody id="receiver_list" name="receiver_list">
							</tbody>
							<!-- 받는 사람 리스트 -->
							<tbody>
								<tr>
									<th>제목<em class='f_red'>*</em></th>
									<td><input type='text' id='subject' name='subject' value='' /></td>
								</tr>
								<tr>
									<th>간단메모<em class='f_red'>*</em></th>
									<td><textarea name='contents_mapping' id='contents_mapping' class='email2_tarea'></textarea></td>
								</tr>
							</tbody>
						</table>
					</dd>
					<!-- 받는 사람 리스트 -->
				</dl>
			</div>
		</div>
		<!-- 내용끝 -->
		<div class='popFoot pf2'>
			<div class='layerBtns'>
				<button type='button' class='layerClose1' onClick="clearConsultMail()">다시작성</button>
			</div>
			<div class='layerBtns'>
				<button type='button' class='layerClose2' onClick='saveConsultMail()'>메일보내기</button>
			</div>
		</div>
	</div>
</div>