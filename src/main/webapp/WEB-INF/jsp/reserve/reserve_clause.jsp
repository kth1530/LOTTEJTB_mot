<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.lottejtb.util.*"%>
<%@ page import="com.lottejtb.reserve.service.*"%>

<%
	String tabsNo = "01";
	String cust_cd = (String) request.getAttribute("cust_cd"); // 회원 로그인 유무 
	String age = (String) request.getAttribute("age"); // 회원 로그인 유무 

	if(age == null || age.equals("")) age = "0";

	String ctg = (String) request.getAttribute("ctg");
	String goodsCd = (String) request.getAttribute("goodsCd");
	String eventCd = (String) request.getAttribute("eventCd");
%>

<head>
<!-- 회원 인증  -->
<%
	// @ include file="/WEB-INF/jsp/comm/session.jsp"
%>

<script type="text/javascript">
<!--
	var ctg = '${ctg}';
	var goodsCd = '${goodsCd}';
	var eventCd = '${eventCd}';
	var isCheckedAll = false;
	var age = '<%=age%>';

	setTimeout(function(){
		if(topCtg == 5740){
			$("#domesticDiv").show();
			$("#otherDiv").hide();
		}else{
			$("#domesticDiv").hide();
			$("#otherDiv").show();
		}
	}, 1000);

	// 초기화
	var fn_init = function() {
		jQuery(function() {
			jQuery('.clause1').load("/reserve/reserve_clause_txt1.do");
			jQuery('.clause2').load("/reserve/reserve_clause_txt1_1.do");
			jQuery('.clause3').load("/reserve/reserve_clause_txt2.do");
			jQuery('.clause4').load("/reserve/reserve_clause_txt3.do");
			jQuery('.clause5').load("/reserve/reserve_clause_txt4.do");
			jQuery('.clause6').load("/reserve/reserve_clause_txt5.do");
			jQuery('.clause7').load("/reserve/reserve_clause_txt6.do");
			jQuery('.clause8').load("/reserve/reserve_clause_txt7.do");
			jQuery('.clause9').load("/reserve/reserve_clause_txt2_new.do");
			//jQuery('.clause10').load("/reserve/reserve_clause_txt8.do");
			//jQuery('.clause9').load("/reserve/reserve_clause_txt8.do");
		});
	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var 
	fn_initButton = function() {

	};

	var underSendSMS = function() {

		if ($('input:checkbox[id="agreement06"]').is(":checked") == false) {
			//window.open('/reserve/under14_send_sms.jsp','','resizable=no scrollbars=yes width=808, height=439 left=0 top=0');
			window.location.href = "http://mdev.lottejtb.com/reserve/under14_send_sms.jsp";
		}

	};

	function checkAll() {
		console
				.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> checkAll()  >>>>>>>>>>>>>>>>>>>>>>>>>>");
		var i;
		var chk = document.getElementsByName("agreement");
		var tot = chk.length;
		for (i = 0; i < tot; i++) {
			chk[i].checked = true;
		}
	}

	function uncheckAll() {
		console
				.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> uncheckAll()  >>>>>>>>>>>>>>>>>>>>>>>>>>");

		var i;
		var chk = document.getElementsByName("agreement");
		var tot = chk.length;
		for (i = 0; i < tot; i++) {
			chk[i].checked = false;
		}
	}

	function check_btnAgreeAll2() {

		$('input:radio[name=agreement01]:input[value="a1"]').attr("checked", true).checkboxradio("refresh");
		$('input:radio[name=agreement02]:input[value="b1"]').attr("checked", true).checkboxradio("refresh");
		$('input:radio[name=agreement03]:input[value="c1"]').attr("checked", true).checkboxradio("refresh");
		$('input:radio[name=agreement04]:input[value="d1"]').attr("checked", true).checkboxradio("refresh");
		$('input:radio[name=agreement05]:input[value="g1"]').attr("checked", true).checkboxradio("refresh");
		$('input:radio[name=agreement06]:input[value="f1"]').attr("checked", true).checkboxradio("refresh");
		$('input:radio[name=agreement07]:input[value="e1"]').attr("checked", true).checkboxradio("refresh");

	}

	//$("input:checkbox[id='agreement02']").prop("checked", true);
	//$("input:checkbox[id='agreement03']").prop("checked", true);

	//if (!isCheckedAll) { // 전체 선택 
	//	$("input[name=agreement]:checkbox").each(function() {
	//		$(this).attr("checked", true);
	//		$(this).prop("checked", true).checkboxradio("refresh");
	//	});
	//	isCheckedAll = true;
	//} else { // 전체 해제 
	//	$("input[name=agreement]:checkbox").each(function() {
	//		$(this).attr("checked", false);
	//		$(this).prop("checked", false).checkboxradio("refresh");
	//
	//	});
	//	isCheckedAll = false;
	//}
	//}

	// 예약하기 화면으로 이동 
	function goReserve() {

		if ($('input:radio[id="agreement01"]').is(":checked") == false) {
			alert("개인정보 수집 및 이용안내에 동의하셔야만 합니다.");
			$("agreement01").focus();
			return false;
		} else if ($('input:radio[id="agreement02"]').is(":checked") == false) {
			alert("고유식별정보 수집 및 이용안내에 동의하셔야만 합니다.");
			return false;

		} else if ($('input:radio[id="agreement03"]').is(":checked") == false) {
			alert("개인정보 제3자 제공 이용안내에 동의하셔야만 합니다.");
			return false;
		}

		if (topCtg == 5740) {
			if ($('input:radio[id="agreement07"]').is(":checked") == false) {
				alert("국내여행 이용약관에 동의하셔야만 합니다.");
				return false;
			}
		} else {
			if ($('input:radio[id="agreement04"]').is(":checked") == false) {
				alert("해외여행 이용약관에 동의하셔야만 합니다.");
				return false;
			}
		}
		

		//마케팅 활용동의 동의 시 SMS 또는 EMAIL 필수 선택
		if ($('input:radio[id="agreement05"]').is(":checked") == true) {
			if ($('input:checkbox[id="chkSMS"]').is(":checked") == false && $('input:checkbox[id="chkEMAIL"]').is(":checked") == false) {
				alert("마케팅 활용동의 동의 시 SMS 또는 EMAIL을 필수 선택 하셔야 합니다.");
				return false;
			}
		}
		
		
		
		//if ($('input:radio[id="agreement06"]').is(":checked") == false) {
		//	alert("14세 미만 개인정보 수집 동의를 선택하셔야 합니다.");
		//	return false;
		//}

		//if ($('input:radio[id="agreement05"]').is(":checked") == false) {
		//	alert("마케팅 활용동의 안내를 선택하셔야 합니다.");
		//	return false;
		//}			

		var mktAgreeYn;
		var childAgreeYn;
		var smsAgreeYn;
		var emailAgreeYn;
		
		// 마케팅 활용동의 안내
		if ($('input:radio[id="agreement05"]').is(":checked") == true) {
			mktAgreeYn = 'Y';
		} else {
			mktAgreeYn = 'N';
		}

		// 14세 미만 개인정보 수집동의
		if (parseInt(age) < 15) {
			if ($('input:radio[id="agreement06"]').is(":checked") == true) {
				childAgreeYn = 'Y';
			} else {
				childAgreeYn = 'N';
			}
		}
		
		// SMS 수집동의
		if ($('input:checkbox[id="chkSMS"]').is(":checked") == true) {
			smsAgreeYn = 'Y';
		} else {
			smsAgreeYn = 'N';
		}
		
		// EMAIL 수집동의
		if ($('input:checkbox[id="chkEMAIL"]').is(":checked") == true) {
			emailAgreeYn = 'Y';
		} else {
			emailAgreeYn = 'N';
		}	

		document.location
				.replace("/reserve/reserve_info.do?ctg=" + ctg + "&goodsCd="
						+ goodsCd + "&eventCd=" + eventCd + "&mktAgreeYn="
						+ mktAgreeYn + "&childAgreeYn=" + childAgreeYn+ "&smsAgreeYn=" 
						+ smsAgreeYn+ "&emailAgreeYn=" + emailAgreeYn);

		/*
		else if ($('input:checkbox[id="agreement05"]').is(":checked") == false) {
			alert("마케팅 활용동의 안내에 동의하셔야만 합니다.");
			return false;
		} else if ($('input:checkbox[id="agreement05"]').is(":checked") == false) {
			alert("14세 미만 개인정보 수집동의에 동의하셔야만 합니다.");
			return false;
		}
		 */

		return true;
	}
	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {

		fn_init();
		fn_initButton();

		if (parseInt(age) < 15) {
			$("#div_agreement06").show();
		} else {
			$("#div_agreement06").hide();
		}
		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});

	// });
//-->
</script>
</head>
<body>

	<!--content-->
	<div role="main" class="ui-content contentWrap">
		<div class="navstitle">예약하기</div>
		<div class="reserve">
			<div data-role="navbar" class="tabsnav mgT10">
				<ul>
					<li data-theme="a" data-ajax="false" class="ui-btn-active">약관동의</li>
					<li data-theme="a" data-ajax="false">정보입력</li>
					<li data-theme="a" data-ajax="false">예약완료</li>
				</ul>
			</div>
			<!-- 약관 동의 Tab-->
			<div class="tabContent mgt5">
				<!--tab1 Start-->
				<%
					if (!cust_cd.equals("")) {
						/** 회원 로그인 시 **/
				%>
				<!--개인정보 수집 및 이용안내-->
				<div class="collapsDiv">
				<div class="check_wrap float">
					<h1 class="collapsHeading">1-1.개인정보 수집 및 이용안내(필수)</h1>
				</div>

					
					<div class="collapsContent">
						<div class="clauseList yakgwan clause1">
							<!--회원으로 로그인 할 경우-->
						</div>
					<div class="check_wrap floatR">
						<input type="radio" id="agreement11" name="agreement01" value="a2" class="rd" checked="checked">
						<label for="agreement11"><i>동의안함</i></label>
					</div>
					<div class="check_wrap float">
						<input type="radio" id="agreement01" name="agreement01" value="a1" class="rd">
						<label for="agreement01"><i>동의함</i></label>
					</div>							
					</div>
					
				
					
				</div>
				<%
					} else {
						/** 비회원 로그인 시 **/
				%>
				<!--비회원 개인정보 수집 및 이용안내-->
				<div class="collapsDiv">
					<div class="check_wrap float">
					<h1 class="collapsHeading">1-1.비회원 개인정보 수집 및 이용안내(필수)</h1>
					</div>

					<div class="collapsContent">
						<div class="clauseList yakgwan clause2">
							<!--비회원으로 로그인이 안된 경우-->
						</div>
					<div class="check_wrap floatR">
						<input type="radio" id="agreement11" name="agreement01" value="a2" class="rd" checked="checked">
						<label for="agreement11"><i>동의안함</i></label>
					</div>
					<div class="check_wrap float">
						<input type="radio" id="agreement01" name="agreement01" value="a1" class="rd">
						<label for="agreement01"><i>동의함</i></label>
					</div>							
					</div>
					
				
					
				</div>
				<%
					}
				%>
				
				<!--1-2 개인정보 수집 및 이용안내(선택)-->
				<div class="collapsDiv">
					<div class="check_wrap float">
						<h1 class="collapsHeading">1-2 개인정보 수집 및 이용안내(선택)</h1>
					</div>

					<div class="collapsContent">
						<div class="clauseList yakgwan clause15">
							<div class=clause_box>
								<p class="clause_tit mgt5">
								1-2. 개인정보의 수집 및 이용안내(선택)
								</p>
								<p class=clause_in_tit>
								1) 당사는 여행상품의 예약 및 여행관련 서비스 제공 등의 업무처리를 위하여 아래와 같이 고객으로부터 최소한의 필수정보를 수집하며,<br/>
								 제공한 모든 개인정보는 별도의 동의가 없는 한 해당목적 이외의 다른 목적으로 사용하지 않습니다.<br/>
								</p>
								<p class=clause_tit>
								</p>
								<div class="table_box st2">
									<table summary="선택, 여행기간, 상품가격으로 구성되어짐">
										<caption>
										선택, 여행기간, 상품가격으로 나타낸 표
										</caption>
										<colgroup>
											<col width="15%">
											<col width="33%">
											<col width="33%">
											<col width="auto">
										</colgroup>
										<tbody>
											<tr>
												<th scope="row">구분</th>
												<th scope="row">수집하는 항목</th>
												<th scope="row">이용목적</th>
												<th scope="row">보유 및 이용기간</th>
											</tr>
											<tr>
												<td rowspan="2" style="vertical-align: middle;">선택정보</td>
												<td rowspan="2" style="vertical-align: middle;">성명, 연락처, 주소, 이메일주소</td>
												<td>혜택 각종이벤트 및 행사관련정보안내,티켓 및 상품수령</td>
												<td style="vertical-align: middle;"><b style="font-size: 17px;"><u>목적달성 후 즉시파기</u></b></td>
											</tr>
											<tr>
												<td>소비자의 불만 및 문의 사항 답변</td>
												<td style="vertical-align: middle;"><b style="font-size: 17px;"><u>3년</u></b></td>										
											</tr>
										</tbody>
									</table>
								</div>
								<br><br>
								<p class=clause_tit>
								3. 거부권 및 불이익
								</p>
								여행예약 시 개인정보 수집, 이용에 대한 동의를 거부할 권리가 있으나, 동의를 거부할 경우 여행상품 예약 서비스 이용에 제한이 있음을 알려드립니다.<br><br>
							</div>
					</div>
					
					<div class="check_wrap floatR">
						<input type="radio" id="agreement99" name="agreement09" value="h2" class="rd" checked="checked">
						<label for="agreement99"><i>동의안함</i></label>
					</div>
					<div class="check_wrap float">
						<input type="radio" id="agreement09" name="agreement09" value="h1" class="rd">
						<label for="agreement09"><i>동의함</i></label>
					</div>					
					
				</div>	

				
				
				
				
							
				
				<!--고유식별정보 수집 및 이용안내-->
				<div class="collapsDiv">
					<div class="check_wrap float">
						<h1 class="collapsHeading">2,고유식별정보 수집 및 이용안내(필수)</h1>
					</div>

					<div class="collapsContent">
						<div class="clauseList yakgwan clause3">
						</div>
					<div class="check_wrap floatR">
						<input type="radio" id="agreement22" name="agreement02" value="b2" class="rd" checked="checked">
						<label for="agreement22"><i>동의안함</i></label>
					</div>
					<div class="check_wrap float">
						<input type="radio" id="agreement02" name="agreement02" value="b1" class="rd">
						<label for="agreement02"><i>동의함</i></label>
					</div>						
					</div>
				</div>

				<!--개인정보 제3자 제공 이용안내-->
				<div class="collapsDiv">
					<div class="check_wrap float">
						<h1 class="collapsHeading">3.개인정보 제3자 제공 이용안내(필수)</h1>
					</div>

					<div class="collapsContent">
						<div class="clauseList yakgwan clause4"></div>
						
					<div class="check_wrap floatR">
						<input type="radio" id="agreement33" name="agreement03" value="c2" class="rd" checked="checked">
						<label for="agreement33"><i>동의안함</i></label>
					</div>
					<div class="check_wrap float">
						<input type="radio" id="agreement03" name="agreement03" value="c1" class="rd">
						<label for="agreement03"><i>동의함</i></label>
					</div>						
						
					</div>
				</div>

				<!--해외여행 이용약관-->
				<div class="collapsDiv" id="otherDiv">
					<div class="check_wrap float">
						<h1 class="collapsHeading">해외여행 이용약관</h1>
					</div>

					
					<div class="collapsContent">
						<div class="clauseList yakgwan clause5"></div>
						
					<div class="check_wrap floatR">
						<input type="radio" id="agreement44" name="agreement04" value="d2" class="rd" checked="checked">
						<label for="agreement44"><i>동의안함</i></label>
					</div>
					<div class="check_wrap float">
						<input type="radio" id="agreement04" name="agreement04" value="d1" class="rd">
						<label for="agreement04"><i>동의함</i></label>
					</div>						
						
					</div>
				</div>
				
				<!--국내여행 이용약관-->
				<div class="collapsDiv" id="domesticDiv" style="display:none;">
					<div class="check_wrap float">
						<h1 class="collapsHeading">국내여행 이용약관</h1>
					</div>

					
					<div class="collapsContent">
						<div class="clauseList yakgwan clause8"></div>
						
					<div class="check_wrap floatR">
						<input type="radio" id="agreement77" name="agreement07" value="e2" class="rd" checked="checked">
						<label for="agreement77"><i>동의안함</i></label>
					</div>
					<div class="check_wrap float">
						<input type="radio" id="agreement07" name="agreement07" value="e1" class="rd">
						<label for="agreement07"><i>동의함</i></label>
					</div>						
						
					</div>
				</div>
				
				<!--14세 미만 개인정보 수집동의-->
				<div class="collapsDiv" id="div_agreement06" name="div_agreement06">
					<div class="check_wrap float">
						<h1 class="collapsHeading">4.14세 미만 개인정보 수집동의 (선택)</h1>
					</div>

					
					<div class="collapsContent">
						<div class="clauseList yakgwan clause7"></div>
						
					<div class="check_wrap floatR">
						<!-- <input type="checkbox" id="agreement06" onclick="javascript:underSendSMS();"> -->
						<input type="radio" id="agreement66" name="agreement06" value="f2" class="rd" checked="checked">
						<label for="agreement66"><i>동의안함</i></label>
					</div>
					<div class="check_wrap float">
						<!-- <input type="checkbox" id="agreement06" onclick="javascript:underSendSMS();"> -->
						<input type="radio" id="agreement06" name="agreement06" value="f1" class="rd">
						<label for="agreement06"><i>동의함</i></label>
					</div>						
						
					</div>
				</div>				

				<!--마케팅 활용동의 안내-->
				<div class="collapsDiv">
					<div class="check_wrap float">
						<h1 class="collapsHeading">5.마케팅 활용동의 안내 (선택)</h1>
					</div>

					
					<div class="collapsContent">
						<!--  <div class="clauseList yakgwan clause6"></div>  -->
						<div class="clauseList yakgwan clause77">
								<p class="clause_tit mgt5">
								5.마케팅 활용동의 안내 (선택)
								</p>
								<p class=clause_in_tit>
								1) 개인정보 활용 목적<br/>
								 제공한 모든 개인정보는 별도의 동의가 없는 한 해당목적 이외의 다른 목적으로 사용하지 않습니다.<br/>
								 고객님의 개인정보는 고객님에게 적합한 맞춤 여행상품 안내서비스 및 맞춤 상담을 위해 아래와 같이 활용될 수 있습니다.<br/>
								(1) 회사의 여행 상품 및 여행관련 서비스를 이용한 고객에게 한정하여 회사가 기획한 여행상품이나 다양한 맞춤서비스 홍보 및 안내하기 위하여 개인정보 활용에 동의한 고객에게 다양한 맞춤 서비스를 제공할 수 있습니다.<br/>
								(2) 신규서비스 개발 및 특화, 인구통계학적 특성에 따른 서비스 제공 및 광고 게재, 당사 및 제휴사 상품 / 제휴카드 안내, 이벤트 등 광고성 정보 전달, 회원의 서비스 이용에 대한 통계, 회원 대상 각종 마케팅 활동에 활용됩니다.<br/><br/>
								</p>
								<p class=clause_tit>
								2). 개인정보 수집 항목
								</p>
								<div class="table_box st2">
									<table summary="개인정보 항목,용도,보유 및 이용기간으로 구성되어짐">
										<caption>
										개인정보 항목,용도,보유 및 이용기간으로 나타낸 표
										</caption>
										<colgroup>
											<col width="35%">
											<col width="auto">
											<col width="15%">
										</colgroup>
										<tbody>
											<tr>
												<th scope="row">개인정보 항목</th>
												<th scope="row">용도</th>
												<th scope="row">보유 및 이용기간</th>
											</tr>
											<tr>
												<td style="vertical-align: middle;">성명, 연락처, 이메일주소</td>
												<td style="vertical-align: middle;"><b style="font-size: 17px;">맞춤서비스 제공, 이벤트 안내, 상품안내 등 마케팅 및 광고에 활용</b></td>
												<td style="vertical-align: middle;"><b style="font-size: 17px;"><u>1년</u></b></td>
											</tr>
										</tbody>
									</table>
								</div>
								<br><br>
								<p class=clause_tit>
								3) 동의거부권 및 불이익
								</p>
								  개인정보 주체자는 개인정보 활용에 대한 동의를 거부할 권리가 있습니다. 동의를 거부할 경우에도 여행서비스 이용에는 영향이 없습니다<br><br>						
						</div>
						
					<div class="check_wrap floatR">
						<input type="radio" id="agreement55" name="agreement05" value="g2" class="rd" checked="checked">
						<label for="agreement55"><i>동의안함</i></label>
					</div>
					<div class="check_wrap float">
						<input type="radio" id="agreement05" name="agreement05" value="g1" class="rd">
						<label for="agreement05"><i>동의함</i></label>
					</div>						
						
					</div>
				</div>

				
				
				<div class="collapsDiv">
					<h1 class="collapsHeading">6.광고성 정보 전송에 대한 동의 (선택)</h1>
					<div class="collapsContent">
						<div class="clauseList yakgwan clause9">
						*하단의 수단에 동의 시 해당 수단으로 마케팅 소식을 받아 볼 수 있습니다.
						
					<p class="tar pr20">
						<label for="agreement99"><input type="checkbox" title="SMS" name="chkSMS" id="chkSMS"/> <i>SMS</i></label>
					</p>
					<p class="tar pr20">
						<label for="agreement98"><input type="checkbox" title="EMAIL" name="chkEMAIL" id="chkEMAIL"/> <i>EMAIL</i></label>
					</p>

						</div>
					</div>
				</div>				
						

				<!--개인정보 파기절차 및 방법-->
				<div class="collapsDiv">
					<h1 class="collapsHeading">7.개인정보 파기절차 및 방법</h1>
					<div class="collapsContent">
						<div class="clauseList yakgwan clause9">
						당사는 수집한 개인정보의 이용목적이 달성된 후에는 이용 및 보관기간에 따라 해당 정보를 지체 없이 파기하며 파기절차 및 방법은 다음과 같습니다. <br/><br/> 
						1).파기절차<br/>
						고객님의 여행서비스 이용을 위해 기재한 개인정보는 이용 목적이 달성된 후 내부방침 및 기타 관련 법령에 의한 정보보호 사유에 따라 일정기간 동안 저장된 후 삭제되거나 파기합니다.<br/><br/>
						2).파기방법<br/>
						종이에 출력된 개인정보 : 분쇄기를 이용하여 분쇄<br/>
						전자적 파일형태로 저장된 개인정보 :  개인정보는 남기지 않으며, 기록을 재생할 수 없는 방법을 통하여 기록삭제<br/>						
						</div>
					</div>
				</div>


				<div class="allcheckDiv">
					<div class="check_wrap floatR">
						<input type="checkbox" id="chkAll" name="chkAll"
							onClick="check_btnAgreeAll2()"> <label for="chkAll"><i>위
								사항에 모두 동의합니다.</i></label>
					</div>
				</div>

				<div data-role="navbar" class="tabsnav mgT10 resbtbtn">
					<ul>
						<li><a href="#" class="more" onClick="history.back(-1)">동의하지
								않습니다.</a></li>
						<li><a href="#" class="more btnBG2" onClick="goReserve()">동의합니다</a></li>
					</ul>
				</div>
			</div>
			<!-- 약관 동의 Tab End-->
			<!--bottom-->
			<script src="/resources/common/bottom.js"></script>
			<!--bottom-->
		</div>
		<!--tabs End-->
	</div>
	<!--//contentWrap End-->
	<!--//content-->