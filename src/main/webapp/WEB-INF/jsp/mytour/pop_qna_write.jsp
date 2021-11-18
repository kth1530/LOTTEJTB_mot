<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_qna_write.jsp
	// 설명 : 자유여행 문의하기 쓰기
%>

<script type="text/javascript">

	/* *************************************************************************** */
	var title = '';
	var assortCd1 = '';
	var assortCd2 = '';
	var assortCd3 = '';
	var cont = '';
	var htel = '';
	var email = '';
	var emailRecvYN = '';
	var smsRecvYN = '';

	// [Ajax] 데이터 통신 부분 
	// 이메일 주소 조회 
	function fn_srchEmailCode() {
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
				html = html
						+ "<select id='email2' name='email2' class='email2_select' onchange='direct_email()'>";
				if (comcodeList != null) {
					for (var i = 0; i < comcodeList.length; i++) {
						if (i == 0) {
							html = html
									+ "<option value='"+comcodeList[i]["cd_nm"]+"' selected>"
									+ comcodeList[i]["cd_nm"] + "</option>";
						} else {
							html = html
									+ "<option value='"+comcodeList[i]["cd_nm"]+"'>"
									+ comcodeList[i]["cd_nm"] + "</option>";
						}
					}
					html = html + "<option value='direct'>직접입력<option>";
				}
				html = html + "</select>";
				$("#selectbox_email").html(html);

			},
			error : function(err) {
				console.log(err);
			},
			complete : function() {
			}
		});
	}

	// 핸드폰 번호 조회    
	var fn_srchHpSysComCode = function() {
		var formData = new FormData();
		formData.append("grp_cd", "HPTYPE");

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
				hpComcodeList = res.comcodeList;
				// console.log(">>>>>>>>>>>>>>>>>>>>>>>>> hpComcodeList >> " + hpComcodeList.length);

				// 대표 여행자
				var html = "";
				html = html
						+ "<select id='htel1' name='htel1' class='email2_select' maxlength='3' style='width:50px' data-role='none'>";
				if (hpComcodeList != null) {
					for (var i = 0; i < hpComcodeList.length; i++) {
						if (hpComcodeList[i]["cd"] != '000') {

							if (i == 0) {
								html = html
										+ "<option value='"+hpComcodeList[i]["cd"]+"' selected>"
										+ hpComcodeList[i]["cd"] + "</option>";
							} else {
								html = html
										+ "<option value='"+hpComcodeList[i]["cd"]+"'>"
										+ hpComcodeList[i]["cd"] + "</option>";
							}
						}
					}

				}
				html = html + "</select>";

				// console.log(">>>>>>>>>>>>>>>>>>>>>>>>> html >> " + html);
				$("#selectbox_htel").html(html);
			},
			error : function(err) {
				console.log(err);
			},
			complete : function() {
			}
		});
	};

	// 핸드폰 번호 조회    
	var fn_srchAssortList = function() {
		var assortCd1 = $("#assortCd1 option:selected").val();
		console.log("assortCd1 : " + assortCd1);

		if(assortCd1 != '000000') {
			var formData = new FormData();
			formData.append("PARENT_ASSORT_CD", assortCd1);

			cfn_ajax({
				url : "/mytour/srchAssortListAjax.do",
				type : "POST",
				data : formData,
				async : false,
				dataType : "json",
				cache : false,
				noloading : "no",
				timeOut : (5 * 60 * 1000),
				success : function(res) {
					var assortList = res.assortList;
					// console.log(">>>>>>>>>>>>>>>>>>>>>>>>> hpComcodeList >> " + hpComcodeList.length);

					// 대표 여행자
					var html = "";
					html = html
							+ "<select id='assortCd2' name='assortCd2' class='input'>";
					if (assortList != null) {
						for (var i = 0; i < assortList.length; i++) {
							if (assortList[i]["assort_CD"] != '000') {

								if (i == 0) {
									html = html
											+ "<option value='"+assortList[i]["assort_CD"]+"' selected>"
											+ assortList[i]["assort_NM"] + "</option>";
								} else {
									html = html
											+ "<option value='"+assortList[i]["assort_CD"]+"'>"
											+ assortList[i]["assort_NM"] + "</option>";
								}
							}
						}

					}
					html = html + "</select>";

					// console.log(">>>>>>>>>>>>>>>>>>>>>>>>> html >> " + html);
					$("#selectbox_assortlist").html(html);
				},
				error : function(err) {
					console.log(err);
				},
				complete : function() {
				}
			});
		}
	};


	function fn_GetParam() {
		title = $("#title").val();
		var from_email1 = $("#email1").val();
		var from_email2 = $("#email2 option:selected").val();
		email = from_email1 + "@" + from_email2;	

		var htel1 = $("#htel1 option:selected").val();
		var htel2 = $("#htel2").val();
		var htel3 = $("#htel3").val();

		htel = htel1 + htel2 + htel3;

		assortCd1 = $("#assortCd1 option:selected").val();
		assortCd2 = $("#assortCd2 option:selected").val();
		assortCd3 = $("#assortCd3 option:selected").val();

		if($("input:checkbox[id='emailRecvYN']").is(":checked")) {
			emailRecvYN = 'Y';
		}
		if($("input:checkbox[id='smsRecvYN']").is(":checked")) {
			smsRecvYN = 'Y';
		}	

		cont = $("#cont").val();
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

	// 파라미터 체크 
	function fn_CheckParam() {
		if(title == null || title == '') {
			alert("문의 제목을 입력해 주세요.");
			$("#title").focus();

			return false;
		}
		if(cont == null || cont == '') {
			alert("문의 내용을 입력해 주세요.");
			$("#cont").focus();
			return false;
		}
		if(htel == null || htel == '') {
			alert("핸드폰 번호를 입력해 주세요.");
			$("#htel2").focus();
			return false;

		}

		if(assortCd2 == null || assortCd2 == '') {
			alert("문의 분류를 선택해 주세요.");
			return false;

		}

		if(email == null || email == '') {
			alert("이메일 주소를 입력해 주세요.");
			$("#email1").focus();
			return false;

		}		

		return true;			
	}

	// 상담 신청 
	function saveCounsel() {
		// 미 로그인 시 
		
		console.log("saveCounsel");

		fn_GetParam();

		// 파라미터 값이 유효할 때 
		if(fn_CheckParam()) {

			var formData = new FormData();
			formData.append("TITLE", title);
			formData.append("ASSORT_CD", assortCd2);
			formData.append("CONT", cont);
			formData.append("EMAIL", email);
			formData.append("HTEL", htel);
			formData.append("USER_ID", '${cust_cd}');
			formData.append("EMAIL_RECV_YN", emailRecvYN);
			formData.append("SMS_RECV_YN", smsRecvYN);
			formData.append("REGTOR_ID", '${cust_cd}');

			cfn_ajax({
				url: "/mytour/saveCounselAjax.do",
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

					alert("정상적으로 처리 되었습니다.");
					
				},
				error:function(err){
					console.log(err);
					alert("정상적으로 처리가 되지 않았습니다.");
				},
				complete:function(){
					//fn_CounselList();
					closePopup();

				}
			});
		}
	}


	// 이메일 주소 직접 입력일 경우 
	function direct_email() {
		dp_email2 = $("#email2 option:selected").val();

		if (dp_email2 == "direct") {
			var html = "<input type='text' id='from_email2' name='from_email2' class='email2_input'  placeholder='이메일을 입력해주세요' style='width: 50px'  onkeyup='return f_IsValidEmail2(this);' value=''>";
			$("#selectbox_email").html(html);
		}
	}

	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};   
		document.location.href="/mytour/pop_qna_list.do";
		// opener.focus();		
	}


	fn_srchEmailCode();
	fn_srchHpSysComCode();
	$("#title").focus();

</script>

<div class="layerPopup">
	<div class="layerPop">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">자유여행 문의하기</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain pop_qna_write">
				<div class="pop_chk_list pop_chk_list2">
					<table class="pop_table2 pop_table2_left">
						<colgroup>
							<col style="width: 30%" />
							<col style="width: 70%" />
						</colgroup>
						<tbody>
							<tr>
								<th>문의제목</th>
								<td><input type="text" id='title' name='title' value='' /></td>
							</tr>
							<tr>
								<th rowspan="2">문의분류</th>
								<td><select name="assortCd1" id="assortCd1" onchange="fn_srchAssortList()">
										<option value="000000">선택하세요</option>
										<option value="100000">자유여행</option>
										<option value="200000">항공</option>
										<option value="300000">호텔</option>
										<option value="400000">렌트카</option>
										
								</select></td>
							</tr>
							<tr>
								<td><span id="selectbox_assortlist" name="selectbox_assortlist"></span></td>
							</tr>
							<tr>
								<th>문의내용</th>
								<td><textarea name="cont" id="cont"></textarea></td>
							</tr>
						</tbody>
					</table>
					<ul class="pop_qna_agrbox">
						<li class="pqa_email"><p class="chkbox">
								<span><input id="emailRecvYN" name='emailRecvYN'
									type="checkbox" /></span> <label for="chk_if1"> 이메일수신</label>
							</p> <span><input type="text" id='email1' name='email1'
								value='' class='input' /><em>@</em></span><span id="selectbox_email"
							name="selectbox_email"></span></li>
						<li class="pqa_sms"><p class="chkbox">
								<span><input id="smsRecvYN" name='smsRecvYN'
									type="checkbox" /></span><label for="chk_if2"> SMS수신</label>
							</p> <span id="selectbox_htel" name="selectbox_htel"></span><input
							type="number" class='email2_select' id="htel2" name='htel2' value=''
							style='width:80px;margin-left:22px' maxlength="4" data-role='none'/><input type="number" id="htel3"
							name='htel3' class='email2_select' value='' maxlength="4" style='width:80px;margin-left:5px' data-role='none'/></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 내용끝 -->
		<div class="popFoot pf2">
			<div class="layerBtns">
				<button type="button" class="layerClose1" onClick="closePopup()">목록으로</button>
			</div>
			<div class="layerBtns">
				<button type="button" class="layerClose2" onClick="saveCounsel()">상담신청</button>
			</div>
		</div>
	</div>
</div>