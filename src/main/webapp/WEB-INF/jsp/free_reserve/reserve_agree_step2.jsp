<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.lottejtb.util.*"%>
<%
	String cust_cd = (String) request.getAttribute("cust_cd"); // 회원 로그인 유무 
	String age = (String) request.getAttribute("age"); // 회원 나이 
	
	String selAir = (String) request.getAttribute("selAir"); // 항공 
	String selHotel = (String) request.getAttribute("selHotel"); // 호텔
	String selRentcar = (String) request.getAttribute("selRentcar"); // 렌트카 
	
	if(age == null || age.equals(""))  age = "0";
%>

<head>
<script src="/resources/common/js/fit/reserve.js"></script>

<script type="text/javascript">
	var cust_cd = '${cust_cd}';
	var selAir = '${selAir}';
	var selHotel = '${selHotel}';
	var selRentcar = '${selRentcar}';
	
	jQuery(function(){
		jQuery('.clause1_1').load("/free_reserve/reserve_clause_txt1.do");
		jQuery('.clause1_2').load("/free_reserve/reserve_clause_txt1_1.do");
		jQuery('.clause1_3').load("/free_reserve/reserve_clause_txt2.do");
		jQuery('.clause1_4').load("/free_reserve/reserve_clause_txt3.do");
		jQuery('.clause1_5').load("/free_reserve/reserve_clause_txt4.do");
		jQuery('.clause1_6').load("/free_reserve/reserve_clause_txt5.do");
		jQuery('.clause1_7').load("/free_reserve/reserve_clause_txt6.do");
		jQuery('.clause1_8').load("/free_reserve/reserve_clause_txt7.do");
		jQuery('.clause1_9').load("/free_reserve/reserve_clause_txt8.do");

		jQuery('.clause2_1').load("/free_reserve/reserve_clause2_txt1.do");
		jQuery('.clause2_2').load("/free_reserve/reserve_clause2_txt2.do");
		jQuery('.clause2_3').load("/free_reserve/reserve_clause2_txt3.do");
		jQuery('.clause2_4').load("/free_reserve/reserve_clause2_txt4.do");

		jQuery('.clause3_1').load("/free_reserve/reserve_clause3_txt1.do");
		jQuery('.clause3_2').load("/free_reserve/reserve_clause3_txt2.do");
		jQuery('.clause3_3').load("/free_reserve/reserve_clause3_txt3.do");
		jQuery('.clause3_4').load("/free_reserve/reserve_clause3_txt4.do");
		
		jQuery('.clause4_1').load("/free_reserve/reserve_clause4_txt1.do");
		
	});

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		$(".air_agreement").hide();
		$(".hotel_agreement").hide();
		$(".rent_agreement").hide();
		
		if(nullToBlank(sessionStorage.airSelData) != "" && sessionStorage.airSelData != '[]'){
			$(".air_agreement").show();
			selAir = 'Y';
		}
		
		if(nullToBlank(sessionStorage.hotelBasketData) != "" && sessionStorage.hotelBasketData != '[]'){
			$(".hotel_agreement").show();
			selHotel = 'Y';
		}
		
		if(nullToBlank(sessionStorage.rentcarSelData) != "" && sessionStorage.rentcarSelData != '[]'){
			$(".rent_agreement").show();
			selRentcar = 'Y';
		}
	
		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});

	function checkAll() {
		console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> checkAll()  >>>>>>>>>>>>>>>>>>>>>>>>>>");
		var i;
		var chk = document.getElementsByName("agreement");
		var tot = chk.length;
		for (i = 0; i < tot; i++) {
			chk[i].checked = true;
		}
	}

	function uncheckAll() {
		console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> uncheckAll()  >>>>>>>>>>>>>>>>>>>>>>>>>>");

		var i;
		var chk = document.getElementsByName("agreement");
		var tot = chk.length;
		for (i = 0; i < tot; i++) {
			chk[i].checked = false;
		}
	}

	function check_btnAgreeAll() {
		if (!isCheckedAll) { // 전체 선택 
			$("input[name=agreement]:checkbox").each(function() {
				$(this).attr("checked", true);
				// $(this).prop("checked", true).checkboxradio("refresh");
			});
			isCheckedAll = true;
		} else { // 전체 해제 
			$("input[name=agreement]:checkbox").each(function() {
				$(this).attr("checked", false);
				// $(this).prop("checked", false).checkboxradio("refresh");

			});
			isCheckedAll = false;
		}
	}

	//예약 3단계로 이동 
	function fn_goReserve() {
		var jSessionID = '<%=request.getSession().getId()%>';
		
		console.log("cust_cd : " + cust_cd);

		if(cust_cd == '') {
			/** 비회원 로그인 시 **/
			if ($('input:checkbox[id="agreement1"]').is(":checked") == false) {
				setAlert("비회원 개인정보 수집 및 이용안내에 동의하셔야만 합니다.");
				return false;
			}		

		} else {
			/** 회원 로그인 시 **/
			if ($('input:checkbox[id="agreement1"]').is(":checked") == false) {
				setAlert("개인정보 수집 및 이용안내에 동의하셔야만 합니다.");
				return false;
			}


		}

		if ($('input:checkbox[id="agreement2"]').is(":checked") == false) {
			setAlert("고유식별정보 수집 및 이용안내에 동의하셔야만 합니다.");
			return false;
		}
		if ($('input:checkbox[id="agreement3"]').is(":checked") == false) {
			setAlert("개인정보 제3자 제공 이용안내에 동의하셔야만 합니다.");
			return false;
		}
		/**
		if ($('input:checkbox[id="agreement4"]').is(":checked") == false) {
			setAlert("해외여행 이용약관에 동의하셔야만 합니다.");
			return false;
		}
		**/

		if(nullToBlank(sessionStorage.airSelData) != "" && sessionStorage.airSelData != '[]'){
			if(!$("#agreement2_2").is(":checked")){
				setAlert("일반규정에 동의하셔야만 합니다.");
				return false;
			}
			
			if(!$("#agreement2_3").is(":checked")){
				setAlert("운임규정에 동의하셔야만 합니다.");
				return false;
			}
			
			if(!$("#agreement2_4").is(":checked")){
				setAlert("취소 및 환불규정에 동의하셔야만 합니다.");
				return false;
			}
			
			if(!$("#agreement2_5").is(":checked")){
				setAlert("결제규정에 동의하셔야만 합니다.");
				return false;
			}
		}
		
		if(nullToBlank(sessionStorage.hotelBasketData) != "" && sessionStorage.hotelBasketData != '[]') {
			/**
			if(!$("#agreement3_2").is(":checked")){
				setAlert("개인정보 수집 및 이용 안내(필수)에 동의하셔야만 합니다.");
				return false;
			}
			
			if(!$("#agreement3_3").is(":checked")){
				setAlert("개인정보 제3자 제공 안내(필수)에 동의하셔야만 합니다.");
				return false;
			}
			**/
			
			if(!$("#agreement3_4").is(":checked")){
				setAlert("취소규정에 동의하셔야만 합니다.");
				return false;
			}
			
			if(!$("#agreement3_5").is(":checked")){
				setAlert("예약 시 유의사항에 동의하셔야만 합니다.");
				return false;
			}
		}
		
		if(nullToBlank(sessionStorage.rentcarSelData) != "" && sessionStorage.rentcarSelData != '[]'){
			if(!$("#agreement4_2").is(":checked")){
				setAlert("임차 자격 및 이용규정에 동의하셔야만 합니다.");
				return false;
			}
		}
		
		//마켓팅 활용동의 
		if($('#agreement5').is(':checked') == true)
			sessionStorage.mkt_agree_yn = 'Y'
		else 
			sessionStorage.mkt_agree_yn = 'N';
		
		fn_goReserveStep3();
	}


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
		<div class="navstitle freeback">여행약관 동의<a href="javascript:history.back(-1);">뒤로</a></div>
		<div class="free_reserve collapse fr_step2">
			<div class="tabContent mt7">
				<div>
					<div class="allcheckDiv">
						<p class="chkbox">
							<span><input id="chk_all1" type="checkbox" data-role="none"></span>
							<label for="chk_all1">모든 약관에 동의 합니다.</label>
						</p>
					</div>	
					<dl class="ft2_acdon ft_acdon4 mt7">
				<%
					if (cust_cd != null && !cust_cd.equals("")) {
						/** 회원 로그인 시 **/
				%>
									
						<dt class="on">
							<p class="chkbox">
								<span><input id="agreement1" name="agreement" type="checkbox" data-role="none" class="step1Agree"></span>
								<label for="agreement1">개인정보 수집 및 이용안내</label>
							</p>
						</dt>
						<dd class="clause1_1"></dd>
				<%
					} else {
						/** 비회원 로그인 시 **/
				%>
						<dt>
							<p class="chkbox">
								<span><input id="agreement1" name="agreement" type="checkbox" data-role="none" class="step1Agree"></span>
								<label for="agreement1">비회원 개인정보 수집 및 이용안내</label>
							</p>
						</dt>
						<dd class="clause1_2"></dd>
				
				<%
					}
				%>	
						<dt>
							<p class="chkbox">
								<span><input id="agreement2" name="agreement" type="checkbox" data-role="none" class="step1Agree"></span>
								<label for="agreement2">고유 식별 정보 수집 및 이용안내</label>
							</p>
						</dt>
						<dd class="clause1_9"></dd>

						<dt>
							<p class="chkbox">
								<span><input id="agreement3" name="agreement"  type="checkbox" data-role="none" class="step1Agree"></span>
								<label for="agreement3">개인정보 제3자 제공 이용안내</label>
							</p>
						</dt>
						<dd class="clause1_3"></dd>

						<!-- dt>
							<p class="chkbox">
								<span><input id="agreement4" name="agreement"  type="checkbox" data-role="none"></span>
								<label for="agreement4">해외여행 이용약관</label>
							</p>
						</dt -->
						<dd class="clause1_4"></dd>

						<dt>
							<p class="chkbox">
								<span><input id="agreement5" name="agreement" type="checkbox" data-role="none"></span>
								<label for="agreement5">마케팅 활용 동의 (선택)</label>
							</p>
						</dt>
						<dd class="clause1_5"></dd>
				<%
					// 회원 로그인 이면서 나이 정보가 14세 미만인 경우에만 
					if(cust_cd != null && !age.equals("0") && Integer.parseInt(age) < 14) {
				%>
						<dt>
							<p class="chkbox">
								<span><input id="agreement6" name="agreement" type="checkbox" data-role="none"></span>
								<label for="agreement6">14세 미만 개인정보 수집동의 (선택)</label>
							</p>
						</dt>
				<%
					}
				%>
						<dd class="clause1_6"></dd>
					</dl>
				</div>

				<p class="pop_avtitle4 mt7 air_agreement">항공 예약 유의 사항 동의</p>
				<div class="air_agreement">
					<div class="allcheckDiv">
						<p class="chkbox">
						<span><input id="agreement2_1" name="agreement" type="checkbox" data-role="none"></span>
						<label for="agreement2_1">[필독] 일반규정에 동의합니다.</label>
						</p>
					</div>
					<dl class="ft2_acdon ft_acdon4 mt7">
						<dt>
							<p class="chkbox">
								<span><input id="agreement2_2" name="agreement" type="checkbox" data-role="none" class="step1Agree"></span>
								<label for="agreement2_2">일반규정</label>
							</p>
						</dt>
						<dd class="clause2_1"></dd>

						<dt>
							<p class="chkbox">
								<span><input id="agreement2_3" name="agreement" type="checkbox" data-role="none" class="step1Agree"></span>
								<label for="agreement2_3">운임규정</label>
							</p>
						</dt>
						<dd class="clause2_2"></dd>

						<dt>
							<p class="chkbox">
								<span><input id="agreement2_4" name="agreement" type="checkbox" data-role="none" class="step1Agree"></span>
								<label for="agreement2_4">취소 및 환불규정</label>
							</p>
						</dt>
						<dd class="clause2_3"></dd>

						<dt>
							<p class="chkbox">
								<span><input id="agreement2_5" name="agreement"  type="checkbox" data-role="none" class="step1Agree"></span>
								<label for="agreement2_5">결제규정</label>
							</p>
						</dt>
						<dd class="clause2_4"></dd>
					</dl>
				</div>

				<p class="pop_avtitle4 mt7 hotel_agreement">호텔 예약 유의 사항 동의</p>
				<div class="hotel_agreement">
					<div class="allcheckDiv">
						<p class="chkbox">
						<span><input id="agreement3_1" name="agreement" type="checkbox" data-role="none"></span>
						<label for="agreement3_1">[필독] 일반규정에 동의합니다.</label>
						</p>
					</div>
					<dl class="ft2_acdon ft_acdon4 mt7">
						<!-- dt>
							<p class="chkbox">
								<span><input id="agreement3_2" name="agreement" type="checkbox" data-role="none"></span>
								<label for="agreement3_2">개인정보 수집 및 이용 안내</label>
							</p>
						</dt>
						<dd class="clause3_1"></dd>

						<dt>
							<p class="chkbox">
								<span><input id="agreement3_3" name="agreement" type="checkbox" data-role="none"></span>
								<label for="agreement3_3">개인정보 제3자 제공 안내</label>
							</p>
						</dt>
						<dd class="clause3_2"></dd -->

						<dt>
							<p class="chkbox">
								<span><input id="agreement3_4" name="agreement" type="checkbox" data-role="none" class="step1Agree"></span>
								<label for="agreement3_4">취소규정</label>
							</p>
						</dt>
						<dd class="clause3_3"></dd>

						<dt>
							<p class="chkbox">
								<span><input id="agreement3_5" name="agreement" type="checkbox" data-role="none" class="step1Agree"></span>
								<label for="agreement3_5">예약 시 유의사항</label>
							</p>
						</dt>
						<dd class="clause3_4"></dd>
					</dl>
				</div>

				<p class="pop_avtitle4 mt7 rent_agreement">렌터카 예약 유의 사항 동의</p>
				<div class="rent_agreement">
					<div class="allcheckDiv">
						<p class="chkbox">
						<span><input id="agreement4_1" name="agreement" type="checkbox" data-role="none"></span>
						<label for="agreement4_1">[필독] 임차자격 및 이용규정에 동의합니다.</label>
						</p>
					</div>
					<dl class="ft2_acdon ft_acdon4 mt7">
						<dt>
							<p class="chkbox">
								<span><input id="agreement4_2" name="agreement"type="checkbox" data-role="none" class="step1Agree"></span>
								<label for="agreement4_2">임차 자격 및 이용규정</label>
							</p>
						</dt>
						<dd class="clause4_1"></dd>
					</dl>
				</div>
			</div>

			<!-- 버튼 -->
			<div class="btn_one air_tbtn"><button class="purple2" data-role="none" onClick="fn_goReserve()">다음</button></div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//content-->	
	
