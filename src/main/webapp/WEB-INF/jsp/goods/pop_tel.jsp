<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
	// 파일명 : pop_tel.jsp
	// 설명 : 전화상담 신청
	String ctg = (String) request.getAttribute("ctg"); // 카테고리 코드
	String goodsCd = (String) request.getAttribute("goodsCd"); // 상품 코드 
	String eventCd = (String) request.getAttribute("eventCd"); // 행사 코드  

%>

<script src="/resources/common/js/utils.js"></script>

<script>
<!--
	var knm = "${knm}";
	var cust_cd = "${cust_cd}";
	var email = "${email}";

	// 초기화
	var fn_init = function() {
		$('#res_nm').val(knm);

		// 핸드폰 번호 조회 
		fn_srchHpSysComCode();
	};
	

	var fn_search = function(){
		
	};
	
			
	// 버튼 초기화
	var fn_initButton = function() {
	
	};
				

	function check_param() {
		var frmCounselTel = document.frmCounselTel;
		var target = document.getElementById("handphone1");

		var handphone1 = target.options[target.selectedIndex].text;;
		var handphone2 = $('#handphone2').val(); 
		var handphone3 = $('#handphone3').val(); 
		var remark = $('#remark').val();
		var res_nm =  $('#res_nm').val();

		
		if(res_nm == null || res_nm == "") {
			alert("이름을 입력해 주세요.");
			$('#res_nm').focus();
			return false;
		}

		if(handphone2 == null || handphone2 == "") {
			alert("연락처를 입력해 주세요.");
			$('#handphone2').focus();
			return false;
		}

		if(handphone3 == null || handphone3 == "") {
			alert("연락처를 입력해 주세요.");
			$('#handphone3').focus();
			return false;
		}

		if(remark == null || remark == "") {
			alert("메모를 입력해 주세요.");
			$('#remark').focus();
			return false;
		}



		return true;
	}

	// 핸드폰 번호 조회    
	var fn_srchHpSysComCode = function() {
		var formData = new FormData();
		formData.append("grp_cd", "HPTYPE");

		cfn_ajax({
			url : "/goods/srchSysComCodeAjax.do",
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
				html = html + "<select id='handphone1' name='handphone1' class='pop_hpselect' data-role='none' style='width:80px' maxlength='3'>";
				if (hpComcodeList != null) {
					for (var i = 0; i < hpComcodeList.length; i++) {
						if (hpComcodeList[i]["cd"] != '000') {

							if(i == 0) {
								html = html + "<option value='"+hpComcodeList[i]["cd"]+"' selected>" + hpComcodeList[i]["cd"] + "</option>";
							} else {
								html = html + "<option value='"+hpComcodeList[i]["cd"]+"'>" + hpComcodeList[i]["cd"] + "</option>";
							}
						}
					}

				}
				html = html + "</select>";

				// console.log(">>>>>>>>>>>>>>>>>>>>>>>>> html >> " + html);
				$("#selectbox_handphone1").html(html);

			},
			error : function(err) {
				console.log(err);
			},
			complete : function() {
			}
		});
	};

	// 전화 상담 문의 
	var saveConsultTel = function() {
		// 미 로그인 시 
		/**
		if(fn_chkLogin() == 1) {
			var cust_id = fn_getCookieLogin();
		**/	

			var ctg = "<%=ctg%>";
			var event_cd = "<%=eventCd%>";
			var goods_cd = "<%=goodsCd%>";
			var email1	= "";
			var email2  = "";
			var tel1 = "";
			var tel2 = "";
			var tel3 = "";
			var comp_tel1 = "";
			var comp_tel2 = "";
			var comp_tel3 = "";

			var frmCounselTel = document.frmCounselTel;
			var target = document.getElementById("handphone1");

			var handphone1 = target.options[target.selectedIndex].text;;
			var handphone2 = $('#handphone2').val(); 
			var handphone3 = $('#handphone3').val(); 
			var remark = $('#remark').val();
			var res_nm =  $('#res_nm').val();

			// 파라미터 값이 유효할 때 
			if(check_param()) {

				var formData = new FormData();
				formData.append("res_nm", res_nm);
				formData.append("handphone1", handphone1);
				formData.append("handphone2", handphone2);
				formData.append("handphone3", handphone3);
				formData.append("remark", remark);

				formData.append("ctg", ctg);
				formData.append("email1", email1);
				formData.append("email2", email2);
				formData.append("tel1", tel1);
				formData.append("tel2", tel2);
				formData.append("tel3", tel3);

				formData.append("comp_tel1", comp_tel1);
				formData.append("comp_tel2", comp_tel2);
				formData.append("comp_tel3", comp_tel3);
				formData.append("cust_cd", cust_cd);
				formData.append("ctg", ctg);
				formData.append("event_cd", event_cd);
				formData.append("goods_cd", goods_cd);

				cfn_ajax({
					url: "/goods/saveConsultTelAjax.do",
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

						alert("전화상담 문의가 등록되었습니다.");
						
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

	function limitText(field, maxChar){
		var ref = $(field),
			val = ref.val();
		if ( val.length >= maxChar ){
			ref.val(function() {
				console.log(val.substr(0, maxChar))
				return val.substr(0, maxChar);       
			});
		}
	}

	// [COMMON] 공통사항 
	$(document).ready(function(){
		fn_init();
		fn_initButton();

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
						<strong class="popTitle">전화상담 신청</strong>
						<button type="button" class="layerClose"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></button>
					</div>
				</div>
				<div class="cntain">
				

					<div class="pop_hp_box">
						<table class="pop_table2 pop_table2_left">
							<colgroup>
							<col width="25%">
							<col width="75%">			  
							</colgroup>
							<tbody>	
							<!-- /////////////////// 폼 데이타 ////////////////// -->	                                 	
							<form name="frmCounselTel">
							<tr>
								<th>이름</th>
								<td><input type="text" id="res_nm" name="res_nm"  value=""/></td>		                                        
							</tr>
							<tr>
								<th>연락처</th>
								<td class="pop_hpnum">
									<span id="selectbox_handphone1" name="selectbox_handphone1"></span> <input type="number" id="handphone2" name="handphone2"  data-role='none' value="" maxlength="4" onkeyup="limitText(this, 4)"> <input type="number" id="handphone3" name="handphone3" data-role='none' value="" maxlength="4" onkeyup="limitText(this, 4)">
								</td>
							</tr>
							<tr>
								<th>메모</th>
								<td>
								<textarea name="remark" id="remark"  class="pop_textarea"></textarea>
								</td>					    
							</tr>
							</form>
							<!-- /////////////////// 폼 데이타 ////////////////// -->
							</tbody>
						</table>
						<p class="ptguide">추가적으로 상담 가능시간 혹은 문의내용을 간략히 적어주시면 최대한 빠른시간에 기입하신 연락처로 상담원이 직접 안내드립니다.</p>			
						<div class="cntBox">
							<span>개인정보의 수집 및 이용목적 : 원할한 여행 상품의 상담 및 서비스 제공 </span>
							<span>보유기간 : 개인정보 수집 후 30일 이내, 혹은 서비스 제공을 위해 30일 이상</span>
							<span>보유기간이 필요할 경우 목적 달성 후 지체없이 파기, 귀하는 개인정보 제공을 거부할 수 있으나, 거부시 서비스 이용에 제한이 있습니다.</span>
						</div>
						<div class="box">
							<span>개인정보 이용에 동의 합니다. 본 정보는 전화상담신청에만 이용됩니다.</span>
							<b>상담신청</b><b class="mgr5">평일 09:00 ~18:00</b><b>휴일 10:00 ~ 19:00</b>
						</div>	
					</div>

				</div>
			</div>
			<!-- 내용끝 -->
			<div class="popFoot">
				<div class="layerBtns"><button type="button" onclick="saveConsultTel()"  class="layerClose1">상담신청</button></div>
			</div>
    </div>
</div>