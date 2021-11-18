<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.lottejtb.goods.rn.service.*"%>

<%
	// 파일명 : pop_mail.jsp
	// 설명 : 일정표 메일 발송

%>


<script src="/resources/common/js/utils.js"></script>
<script src="/resources/common/js/reserve.js"></script>
<script>

	var knm = "${knm}";
	var cust_cd = "${cust_cd}";
	var email = "${email}";
	var ctg = "${ctg}";
	var goodsCd = "${goodsCd}";
	var eventCd = "${eventCd}";
	var dispNm = $('#disp_nm').val();

	console.log("dispNm : " + dispNm);
	console.log("ctg : " + ctg);

	// 초기화
	var fn_init = function() {
		$('#from_name').val(knm);
		$('#from_email').val(email);
		$('#subject').val(dispNm);
		// 이메일 주소 조회 
		// fn_srchEmailSysComCode();
	};
	

	var fn_search = function(){
		
	};
	
			
	// 버튼 초기화
	var fn_initButton = function() {
	
	};

	function syncEmail() {
		var from_email = $('#from_email').val(); 
		var from_name =  $('#from_name').val();

		if(from_name == null || from_name == '') {
			$('#from_name').focus();
		} else if(from_email == null || from_email == '') {
			$('#from_email').focus();
		} else {
			document.all.to_email.value = from_email;
			document.all.to_name.value = from_name;		
		}
	}	

	function checkEmail(email) {
			var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			
			if(regex.test(email) === false) {
				alert("잘못된 이메일 형식입니다.");
				return false;
			} else {
				return true;
			}

	}
	function check_param() {
		var frmCounselTel = document.frmCounselTel;

		var from_email = $('#from_email').val(); 
		var from_name =  $('#from_name').val();
		var to_email = $('#to_email').val(); 
		var to_name =  $('#to_name').val();
		var subject = $('#subject').val();
		var contents_mapping = $('#contents_mapping').val();

		
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

		if(to_name == null || to_name == "") {
			alert("받는 분 이름을 입력해 주세요.");
			$('#to_name').focus();
			return false;
		}

		if(to_email == null || to_email == "") {
			alert("받는 분 이메일 주소를 입력해 주세요.");
			$('#to_email').focus();
			return false;
		}

		if(!checkEmail(to_email)) {
			return false;
		}

		if(subject == null || subject == "") {
			alert("제목을 입력해 주세요.");
			$('#subject').focus();
			return false;
		}



		return true;
	}
	
	// 이메일 주소 직접 입력일 경우 
	function direct_email() {
		dp_email2 = $("#dp_email2 option:selected").val();

		if (dp_email2 == "direct") {
			var html = "<input type='text' id='email2' name='email2' placeholder='' onkeyup='return f_IsValidEmail2(this);' style='width:150px' value=''>";
			$("#selectbox_email2").html(html);
		}
	}

	// 이메일 주소 조회 
	var fn_srchEmailSysComCode = function() {
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
				html = html + "<select id='dp_email2' name='dp_email2' class='email2' style='width:180px' onchange='direct_email()'>";
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
				$("#selectbox_email2").html(html);

			},
			error : function(err) {
				console.log(err);
			},
			complete : function() {
			}
		});
	};

	// 메일 문의  
	var saveConsultMail = function() {
		// 미 로그인 시 
		/**
		if(fn_chkLogin() == 1) {
			var cust_id = fn_getCookieLogin();
		**/	

			var event_cd = eventCd;
			var goods_cd = goodsCd;
			var from_email = "";
			var from_name = "";
			var to_email = "";
			var to_name = "";
			var subject = "";
			var contents_mapping = "";

			cust_cd = "${cust_cd}";

			from_email = $('#from_email').val(); 
			from_name =  $('#from_name').val();
			to_email = $('#to_email').val(); 
			to_name =  $('#to_name').val();
			subject = $('#subject').val();
			contents_mapping = $('#contents_mapping').val();

			// 파라미터 값이 유효할 때 
			if(check_param()) {

				var formData = new FormData();
				formData.append("from_name", from_name);
				formData.append("from_email", from_email);
				formData.append("to_name", to_name);
				formData.append("to_email", to_email);
				formData.append("subject", subject);
				formData.append("contents_mapping", contents_mapping);


				formData.append("ctg", ctg);
				formData.append("event_cd", event_cd);
				formData.append("goods_cd", goods_cd);

				cfn_ajax({
					url: "/goods/saveConsultMailAjax.do",
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

						alert("등록되었습니다.");
						
					},
					error:function(err){
						console.log(err);
					},
					complete:function(){

						closePopup();
	
					}
				});
			}
		/**	
		} else {
			history.back(-1);
		}
		**/
	};

	function closePopup() {
		jQuery("html, body").css({"overflow":"auto"});
		if(jQuery(".layerPopup").size()){
			jQuery(".layerPopup").remove();                 
		};              
		opener.focus();		
	}
	// [COMMON] 공통사항 
	$(document).ready(function(){
		fn_init();
		fn_initButton();
		$("#to_name").focus();
		
		/*document.addEventListener("deviceready", function(){
		fn_init();
		fn_initButton();					
		}, false);*/
	});


//-->
</script>

<div class="layerPopup">
    <div class="layerPop">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">일정표 메일발송</strong>
					<button type="button" class="layerClose"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></button>
				</div>
			</div>
			<div class="cntain">
				<div class="popemail" >
					<table>                                
						<colgroup>
							<col width="30%">
							<col width="70%">															  
						</colgroup>
							<tbody>
							<tr>
								<th>보내는분</th>
							</tr>
							<tr>    
								<td class="bd0">
								<input type="text" class="wfull" id="from_name" name="from_name" placeholder="이름을 입력하세요" value=""/>
								<input type="text" class="wfull" id="from_email" name="email" placeholder="이메일주소를 입력하세요" value=""/>
								</td>
							</tr>
							<tr>
								<th>받는분
									<div class="floatR selectpop_checkbox emailchkbox">
									<span class="checkbox"><input type="checkbox" id="agreement01" onclick="syncEmail()"></span><label for="agreement01">보내는분과 동일</label>																	
									</div>
								</th>
							</tr>
							<tr>    
								<td class="bd0">
								<input type="text" class="wfull" id="to_name" name="to_name" placeholder="이름을 입력하세요" />
								<input type="text" class="wfull" id="to_email" name="to_email" placeholder="이메일주소를 입력하세요" value=""/>
								</td>
							</tr>
							<tr>
								<th>제목</th>
							</tr>
							<tr>    
								<td class="bd0"><input type="text" class="wfull" id="subject" name="subject" value="" /></td>
							</tr>		                                    
							<tr>
								<th>간단메모</th>
							</tr>
							<tr>    
								<td>		                                        
								<textarea id="contents_mapping" name="contents_mapping"  class="textarea smmemo"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- 내용끝 -->
		<div class="popFoot">
			<div class="layerBtns"><button type="button" onClick="saveConsultMail()" class="layerClose1">이메일 발송</button></div>
		</div>
    </div>
</div>