<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.lottejtb.util.*"%>
<%@ page import="com.lottejtb.reserve.service.*"%>
<%@ page import="com.lottejtb.goods.rn.service.*"%>
<%@ page import="com.lottejtb.comm.util.*"%>
<%
	String tabsNo = "02";

	String ctg = (String) request.getAttribute("ctg");
	String goodsCd = (String) request.getAttribute("goodsCd");
	String eventCd = (String) request.getAttribute("eventCd");

	RNETMstVO eventMstDTO = (RNETMstVO) request.getAttribute("rnEtMst"); // 행사 상품 마스터 

	String grade = "";
	if(request.getAttribute("grade") != null){
		grade = (String) request.getAttribute("grade");
	}
	//grade = "그룹직원";

	/**
	* 임직원 할인가격 적용 
	**/	
	double empAdultPrice = 0;
	double empChildPrice = 0;
	double empBabyPrice = 0;

	if(grade.equals("그룹직원")) {

		if(eventMstDTO.getEmp_rate() > 0) {
			empAdultPrice =  (1 - (Double.valueOf(String.valueOf(eventMstDTO.getEmp_rate())) / 100))  * Double.valueOf(String.valueOf(eventMstDTO.getAdult_price())) + Double.valueOf(String.valueOf(eventMstDTO.getEtc_price1()));
			empChildPrice =  (1 - (Double.valueOf(String.valueOf(eventMstDTO.getEmp_rate())) / 100))  * Double.valueOf(String.valueOf(eventMstDTO.getChild_price())) + Double.valueOf(String.valueOf(eventMstDTO.getEtc_price2()));
			empBabyPrice  =  (1 - (Double.valueOf(String.valueOf(eventMstDTO.getEmp_rate())) / 100))  * Double.valueOf(String.valueOf(eventMstDTO.getBaby_price())) + Double.valueOf(String.valueOf(eventMstDTO.getEtc_price3()));
								
		}

	}

%>
<head>
<!-- 회원 인증  -->
<%
	// @ include file="/WEB-INF/jsp/comm/session.jsp"
%>

<script src="/resources/common/js/reserve.js"></script>
<script type="text/javascript">
	var opCd = '${opCd}';
	var ctg = '${ctg}';
	var goodsCd = '${goodsCd}';
	var eventCd = '${eventCd}';
	var compCd = '${compCd}';

	var traveler = 1; // 여행자 정보 순번 
	var hpComcodeList;
	var reserveFlag = false;
	var grade = "<%=grade%>";

	// ----------------------------------------------------------------
	// 결제 금액 정보  
	// ----------------------------------------------------------------
	
	var adult_price = <%=eventMstDTO.getTot_amt1()%>; // 성인
	var child_price = <%=eventMstDTO.getTot_amt2()%>; // 아동
	var baby_price = <%=eventMstDTO.getTot_amt3()%>; // 유아 
	var comp_cd = "<%=eventMstDTO.getComp_cd()%>";

	//기본상품가
	var adult_base_price = <%=eventMstDTO.getAdult_price()%>; // 성인
	var child_base_price = <%=eventMstDTO.getChild_price()%>; // 아동
	var baby_base_price = <%=eventMstDTO.getBaby_price()%>; // 유아 
	//유류할증료
	var etc_price1 = '<%=eventMstDTO.getEtc_price1()%>';
	var etc_price2 = '<%=eventMstDTO.getEtc_price2()%>';
	var etc_price3 = '<%=eventMstDTO.getEtc_price3()%>';
	
	
	setTimeout(function(){
		$("#startPyun").html('- '+ nullToBlank('<%=eventMstDTO.getStart_pyun()%>'));
		$("#endPyun").html('- '+ nullToBlank('<%=eventMstDTO.getEnd_pyun()%>'));
		
		console.log('<%=eventMstDTO.getEnd_pyun()%>');
	}, 100);

	// 성인 여행자 총 포함 인원 및 금액 
	var tot_adult_inwon = 0;
	var tot_adult_price = 0;

	// 아동 여행자 총 포함 인원 및 금액 
	var tot_child_inwon = 0;
	var tot_child_price = 0;

	// 유아 여행자 총 포함 인원 및 금액 
	var tot_baby_inwon = 0;
	var tot_baby_price = 0;

	// 총 결제 금액 
	var tot_acc_price = 0;

	// 주문 타입 
	var order_type = "";

	// ----------------------------------------------------------------
	// 예약에 필요한 정보 
	// 추후 회원 쿠키 정보에서 얻어오는 것으로 변경이 되어야 한다. 
	// ----------------------------------------------------------------
	var cust_cd = '${custCd}';
	var knm = '${knm}';
	var jumin_no1 = '${birthday}';
	var jumin_no2 = "";
	var email1 = "";
	var email2 = "";
	order_type = "1"; // 회원 주문 
	var email = '${email}';

	if(email != null || email == '' || email != 'undefined') {
		var strEmailArr =  email.split('@');
		email1 = strEmailArr[0];
		email2 = strEmailArr[1];
	}
	/**
	if (cust_cd == null || cust_cd == "") {
		cust_cd = "0000002911";
	}
	**/
	// ----------------------------------------------------------------

	// ----------------------------------------------------------------
	// 예약 정보 파라미터
	// ----------------------------------------------------------------
	var dp_nm = "";
	var dp_handphone1 = "";
	var dp_handphone2 = "";
	var dp_handphone3 = "";
	var dp_email = "";
	var dp_email1 = "";
	var dp_email2 = "";
	var dp_email3 = "";
	var dp_comment = "";
	var dp_equalsFlag = "";

	var inwon1_knm = "";
	var inwon1_efname = "";
	var inwon1_ename = "";
	var inwon1_ssnL = "";
	var inwon1_handphone1 = "";
	var inwon1_handphone2 = "";
	var inwon1_handphone3 = "";
	var inwon1_passYn = "";
	var inwon1_passYn2 = "";
	var inwon1_sex = "";
	var inwon1_age = 0;
	var inwon1_price = 0;
	var inwon1_pickup_area_cd = "";

	var inwon2_knm = "";
	var inwon2_efname = "";
	var inwon2_ename = "";
	var inwon2_ssnL = "";
	var inwon2_handphone1 = "";
	var inwon2_handphone2 = "";
	var inwon2_handphone3 = "";
	var inwon2_passYn = "";
	var inwon2_passYn2 = "";
	var inwon2_sex = "";
	var inwon2_age = 0;
	var inwon2_price = 0;
	var inwon2_pickup_area_cd = "";

	var inwon3_knm = "";
	var inwon3_efname = "";
	var inwon3_ename = "";
	var inwon3_ssnL = "";
	var inwon3_handphone1 = "";
	var inwon3_handphone2 = "";
	var inwon3_handphone3 = "";
	var inwon3_passYn = "";
	var inwon3_passYn2 = "";
	var inwon3_sex = "";
	var inwon3_age = 0;
	var inwon3_price = 0;
	var inwon3_pickup_area_cd = "";

	var inwon4_knm = "";
	var inwon4_efname = "";
	var inwon4_ename = "";
	var inwon4_ssnL = "";
	var inwon4_handphone1 = "";
	var inwon4_handphone2 = "";
	var inwon4_handphone3 = "";
	var inwon4_passYn = "";
	var inwon4_passYn2 = "";
	var inwon4_sex = "";
	var inwon4_age = 0;
	var inwon4_price = 0;
	var inwon4_pickup_area_cd = "";

	var inwon5_knm = "";
	var inwon5_efname = "";
	var inwon5_ename = "";
	var inwon5_ssnL = "";
	var inwon5_handphone1 = "";
	var inwon5_handphone2 = "";
	var inwon5_handphone3 = "";
	var inwon5_passYn = "";
	var inwon5_passYn2 = "";
	var inwon5_sex = "";
	var inwon5_age = 0;
	var inwon5_price = 0;
	var inwon5_pickup_area_cd = "";

	var inwon6_knm = "";
	var inwon6_efname = "";
	var inwon6_ename = "";
	var inwon6_ssnL = "";
	var inwon6_handphone1 = "";
	var inwon6_handphone2 = "";
	var inwon6_handphone3 = "";
	var inwon6_passYn = "";
	var inwon6_passYn2 = "";
	var inwon6_sex = "";
	var inwon6_age = 0;
	var inwon6_price = 0;
	var inwon6_pickup_area_cd = "";

	var inwon7_knm = "";
	var inwon7_efname = "";
	var inwon7_ename = "";
	var inwon7_ssnL = "";
	var inwon7_handphone1 = "";
	var inwon7_handphone2 = "";
	var inwon7_handphone3 = "";
	var inwon7_passYn = "";
	var inwon7_passYn2 = "";
	var inwon7_sex = "";
	var inwon7_age = 0;
	var inwon7_price = 0;
	var inwon7_pickup_area_cd = "";

	var inwon8_knm = "";
	var inwon8_efname = "";
	var inwon8_ename = "";
	var inwon8_ssnL = "";
	var inwon8_handphone1 = "";
	var inwon8_handphone2 = "";
	var inwon8_handphone3 = "";
	var inwon8_passYn = "";
	var inwon8_passYn2 = "";
	var inwon8_sex = "";
	var inwon8_age = 0;
	var inwon8_price = 0;
	var inwon8_pickup_area_cd = "";

	var inwon9_knm = "";
	var inwon9_efname = "";
	var inwon9_ename = "";
	var inwon9_ssnL = "";
	var inwon9_handphone1 = "";
	var inwon9_handphone2 = "";
	var inwon9_handphone3 = "";
	var inwon9_passYn = "";
	var inwon9_passYn2 = "";
	var inwon9_sex = "";
	var inwon9_age = 0;
	var inwon9_price = 0;
	var inwon9_pickup_area_cd = "";

	var inwon10_knm = "";
	var inwon10_efname = "";
	var inwon10_ename = "";
	var inwon10_ssnL = "";
	var inwon10_handphone1 = "";
	var inwon10_handphone2 = "";
	var inwon10_handphone3 = "";
	var inwon10_passYn = "";
	var inwon10_passYn2 = "";
	var inwon10_sex = "";
	var inwon10_age = 0;
	var inwon10_price = 0;
	var inwon10_pickup_area_cd = "";

	var mktAgreeYn = '${mktAgreeYn}';
	var childAgreeYn = '${childAgreeYn}';
	
	var smsAgreeYn = '${smsAgreeYn}';
	var emailAgreeYn = '${emailAgreeYn}';


	// 초기화
	var fn_init = function() {

		// 이메일 주소 조회 
		fn_srchEmailSysComCode();

		// 여행자 정보 리스트 셋팅 
		setTravelerList();

		// 핸드폰 번호 조회 
		fn_srchHpSysComCode();

		// 탑승지역 표시 
		if(opCd != 'OT') {
			fn_srchPickupAreaSysComCode();
		}

		if(cust_cd == null || cust_cd == "") {
			$("#dp_nm").focus();
		}

		$("#dp_nm").val(knm);
		$("#dp_email1").val(email1);
		$("#dp_email2").val(email2);
	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};
	// 취소시 이동 
	function fn_goMain() {
		document.location.href = "/main.do";
	}

	// 파라미터 유효성 체크 
	function check_param() {
		// 여행 대표자 정보 및 여행자 정보 얻기  
		fn_getParams();
		

		// 대표 예약자 파라미터 체크 
		if (dp_nm == null || dp_nm == "" || dp_nm =="undefined") {
			alert("이름을 입력해 주세요.");
			$("#dp_nm").focus();
			return false;
		}

		if (dp_handphone2 == null || dp_handphone2 == "" || dp_handphone2 =="undefined") {
			alert("핸드폰 번호를 입력해 주세요.");
			$("#dp_handphone2").focus();
			return false;
		}

		if (dp_handphone3 == null || dp_handphone3 == "" || dp_handphone3 =="undefined") {
			alert("핸드폰 번호를 입력해 주세요.");
			$("#dp_handphone3").focus();
			return false;
		}

		if (dp_email1 == null || dp_email1 == "" || dp_email1 =="undefined") {
			alert("이메일 주소를 입력해 주세요.");
			$("#dp_email1").focus();
			return false;
		}
		
		dp_email = dp_email1 + "@" + dp_email2;

		var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		
		if(regex.test(dp_email) === false) {
			alert("잘못된 이메일 형식입니다.");
			$("#dp_email3").focus();
			return false;
		}		
				
		
		// 여행자 정보 1
		if (inwon1_knm == null || inwon1_knm == "" || inwon1_knm =="undefined") {
			alert("이름를 입력해 주세요.");
			$("#inwon1_knm").focus();
			return false;
		}

		if (inwon1_efname == null || inwon1_efname == "" || inwon1_efname =="undefined") {
			alert("영문성/이름을 입력해 주세요.");
			$("#inwon1_efname").focus();
			return false;
		}

		if (inwon1_ename == null || inwon1_ename == "" || inwon1_ename =="undefined") {
			alert("영문성/이름을 입력해 주세요.");
			$("#inwon1_ename").focus();
			return false;
		}

		if (inwon1_ssnL == null || inwon1_ssnL == "" || inwon1_ssnL =="undefined" || inwon1_ssnL.length != 8) {
			alert("생년월일을 입력해 주세요.");
			$("#inwon1_ssnL").focus();
			return false;
		}

		if (inwon1_handphone2 == null || inwon1_handphone2 == "" || inwon1_handphone2 =="undefined") {
			alert("연락처를 입력해 주세요.");
			$("#inwon1_handphone2").focus();
			return false;
		}

		if (inwon1_handphone3 == null || inwon1_handphone3 == "" || inwon1_handphone3 =="undefined") {
			alert("연락처를 입력해 주세요.");
			$("#inwon1_handphone3").focus();
			return false;
		}

		if (inwon1_passYn == null || inwon1_passYn == "" || inwon1_passYn =="undefined") {
			alert("여권 유무를 선택해 주세요.");
			$("#inwon1_passYn").focus();
			return false;
		}

		if (inwon1_sex == null || inwon1_sex == "" || inwon1_sex =="undefined") {
			alert("성별을 선택해 주세요.");
			$("#inwon1_sex").focus();
			return false;
		}

		if (inwon1_age == null || inwon1_age == "" || inwon1_age =="undefined") {
			alert("연령을 선택해 주세요.");
			$("#inwon1_age").focus();
			return false;
		}

		if(opCd != 'OT') {
			if (inwon1_pickup_area_cd == null || inwon1_pickup_area_cd == "" || inwon1_pickup_area_cd =="undefined") {
				alert("탑승지역을 선택해 주세요.");
				$("#inwon1_pickup_area_cd").focus();
				return false;
			}			
		}

		if (traveler > 1) {
			// 여행자 정보 2
			if (inwon2_knm == null || inwon2_knm == "" || inwon2_knm =="undefined") {
				alert("이름를 입력해 주세요.");
				$("#inwon2_knm").focus();
				return false;
			}

			if (inwon2_efname == null || inwon2_efname == "" || inwon2_efname =="undefined") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon2_efname").focus();
				return false;
			}

			if (inwon2_ename == null || inwon2_ename == "" || inwon2_ename =="undefined") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon2_ename").focus();
				return false;
			}

			if (inwon2_ssnL == null || inwon2_ssnL == "" || inwon2_ssnL =="undefined" || inwon2_ssnL.length != 8) {
				alert("생년월일을 입력해 주세요.");
				$("#inwon2_ssnL").focus();
				return false;
			}

			if (inwon2_handphone2 == null || inwon2_handphone2 == ""  || inwon2_handphone2 =="undefined") {
				alert("연락처를 입력해 주세요.");
				$("#inwon2_handphone2").focus();
				return false;
			}

			if (inwon2_handphone3 == null || inwon2_handphone3 == "" || inwon2_handphone3 =="undefined") {
				alert("연락처를 입력해 주세요.");
				$("#inwon2_handphone3").focus();
				return false;
			}

			if (inwon2_passYn == null || inwon2_passYn == "" || inwon2_passYn =="undefined") {
				alert("여권 유무를 선택해 주세요.");
				$("#inwon2_passYn").focus();
				return false;
			}

			if (inwon2_sex == null || inwon2_sex == "" || inwon2_sex =="undefined") {
				alert("성별을 선택해 주세요.");
				$("#inwon2_sex").focus();
				return false;
			}

			if (inwon2_age == null || inwon2_age == "" || inwon2_age =="undefined") {
				alert("연령을 선택해 주세요.");
				$("#inwon2_age").focus();
				return false;
			}

			if(opCd != 'OT') {
				if (inwon2_pickup_area_cd == null || inwon2_pickup_area_cd == "" || inwon2_pickup_area_cd =="undefined") {
					alert("탑승지역을 선택해 주세요.");
					$("#inwon2_pickup_area_cd").focus();
					return false;
				}			
			}
			
		}

		if (traveler > 2) {
			// 여행자 정보 3
			if (inwon3_knm == null || inwon3_knm == "") {
				alert("이름를 입력해 주세요.");
				$("#inwon3_knm").focus();
				return false;
			}

			if (inwon3_efname == null || inwon3_efname == "") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon3_efname").focus();
				return false;
			}

			if (inwon3_ename == null || inwon3_ename == "") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon3_ename").focus();
				return false;
			}

			if (inwon3_ssnL == null || inwon3_ssnL == "" || inwon3_ssnL.length != 8) {
				alert("생년월일을 입력해 주세요.");
				$("#inwon3_ssnL").focus();
				return false;
			}

			if (inwon3_handphone2 == null || inwon3_handphone2 == "") {
				alert("연락처를 입력해 주세요.");
				$("#inwon3_handphone2").focus();
				return false;
			}

			if (inwon3_handphone3 == null || inwon3_handphone3 == "") {
				alert("연락처를 입력해 주세요.");
				$("#inwon3_handphone3").focus();
				return false;
			}

			if (inwon3_passYn == null || inwon3_passYn == "") {
				alert("여권 유무를 선택해 주세요.");
				$("#inwon3_passYn").focus();
				return false;
			}

			if (inwon3_sex == null || inwon3_sex == "") {
				alert("성별을 선택해 주세요.");
				$("#inwon3_sex").focus();
				return false;
			}

			if (inwon3_age == null || inwon3_age == "") {
				alert("연령을 선택해 주세요.");
				$("#inwon3_age").focus();
				return false;
			}

			if(opCd != 'OT') {
				if (inwon3_pickup_area_cd == null || inwon3_pickup_area_cd == "" || inwon3_pickup_area_cd =="undefined") {
					alert("탑승지역을 선택해 주세요.");
					$("#inwon3_pickup_area_cd").focus();
					return false;
				}			
			}			
		}

		if (traveler > 3) {
			// 여행자 정보 4
			if (inwon4_knm == null || inwon4_knm == "") {
				alert("이름를 입력해 주세요.");
				$("#inwon4_knm").focus();
				return false;
			}

			if (inwon4_efname == null || inwon4_efname == "") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon4_efname").focus();
				return false;
			}

			if (inwon4_ename == null || inwon4_ename == "") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon4_ename").focus();
				return false;
			}

			if (inwon4_ssnL == null || inwon4_ssnL == "" || inwon4_ssnL.length != 8) {
				alert("생년월일을 입력해 주세요.");
				$("#inwon4_ssnL").focus();
				return false;
			}

			if (inwon4_handphone2 == null || inwon4_handphone2 == "") {
				alert("연락처를 입력해 주세요.");
				$("#inwon4_handphone2").focus();
				return false;
			}

			if (inwon4_handphone3 == null || inwon4_handphone3 == "") {
				alert("연락처를 입력해 주세요.");
				$("#inwon4_handphone3").focus();
				return false;
			}

			if (inwon4_passYn == null || inwon4_passYn == "") {
				alert("여권 유무를 선택해 주세요.");
				$("#inwon4_passYn").focus();
				return false;
			}

			if (inwon4_sex == null || inwon4_sex == "") {
				alert("성별을 선택해 주세요.");
				$("#inwon4_sex").focus();
				return false;
			}

			if (inwon4_age == null || inwon4_age == "") {
				alert("연령을 선택해 주세요.");
				$("#inwon4_age").focus();
				return false;
			}

			if(opCd != 'OT') {
				if (inwon4_pickup_area_cd == null || inwon4_pickup_area_cd == "" || inwon4_pickup_area_cd =="undefined") {
					alert("탑승지역을 선택해 주세요.");
					$("#inwon4_pickup_area_cd").focus();
					return false;
				}			
			}					
		}

		if (traveler > 4) {
			// 여행자 정보 5
			if (inwon5_knm == null || inwon5_knm == "") {
				alert("이름를 입력해 주세요.");
				$("#inwon5_knm").focus();
				return false;
			}

			if (inwon5_efname == null || inwon5_efname == "") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon5_efname").focus();
				return false;
			}

			if (inwon5_ename == null || inwon5_ename == "") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon5_ename").focus();
				return false;
			}

			if (inwon5_ssnL == null || inwon5_ssnL == "" || inwon5_ssnL.length != 8) {
				alert("생년월일을 입력해 주세요.");
				$("#inwon5_ssnL").focus();
				return false;
			}

			if (inwon5_handphone2 == null || inwon5_handphone2 == "") {
				alert("연락처를 입력해 주세요.");
				$("#inwon5_handphone2").focus();
				return false;
			}

			if (inwon5_handphone3 == null || inwon5_handphone3 == "") {
				alert("연락처를 입력해 주세요.");
				$("#inwon5_handphone3").focus();
				return false;
			}

			if (inwon5_passYn == null || inwon5_passYn == "") {
				alert("여권 유무를 선택해 주세요.");
				$("#inwon5_passYn").focus();
				return false;
			}

			if (inwon5_sex == null || inwon5_sex == "") {
				alert("성별을 선택해 주세요.");
				$("#inwon5_sex").focus();
				return false;
			}

			if (inwon5_age == null || inwon5_age == "") {
				alert("연령을 선택해 주세요.");
				$("#inwon5_age").focus();
				return false;
			}

			if(opCd != 'OT') {
				if (inwon5_pickup_area_cd == null || inwon5_pickup_area_cd == "" || inwon5_pickup_area_cd =="undefined") {
					alert("탑승지역을 선택해 주세요.");
					$("#inwon5_pickup_area_cd").focus();
					return false;
				}			
			}						
		}

		if (traveler > 5) {
			// 여행자 정보 6
			if (inwon6_knm == null || inwon6_knm == "") {
				alert("이름를 입력해 주세요.");
				$("#inwon6_knm").focus();
				return false;
			}

			if (inwon6_efname == null || inwon6_efname == "") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon6_efname").focus();
				return false;
			}

			if (inwon6_ename == null || inwon6_ename == "") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon6_ename").focus();
				return false;
			}

			if (inwon6_ssnL == null || inwon6_ssnL == "" || inwon6_ssnL.length != 8) {
				alert("생년월일을 입력해 주세요.");
				$("#inwon6_ssnL").focus();
				return false;
			}

			if (inwon6_handphone2 == null || inwon6_handphone2 == "") {
				alert("연락처를 입력해 주세요.");
				$("#inwon6_handphone2").focus();
				return false;
			}

			if (inwon6_handphone3 == null || inwon6_handphone3 == "") {
				alert("연락처를 입력해 주세요.");
				$("#inwon6_handphone3").focus();
				return false;
			}

			if (inwon6_passYn == null || inwon6_passYn == "") {
				alert("여권 유무를 선택해 주세요.");
				$("#inwon6_passYn").focus();
				return false;
			}

			if (inwon6_sex == null || inwon6_sex == "") {
				alert("성별을 선택해 주세요.");
				$("#inwon6_sex").focus();
				return false;
			}

			if (inwon6_age == null || inwon6_age == "") {
				alert("연령을 선택해 주세요.");
				$("#inwon6_age").focus();
				return false;
			}

			if(opCd != 'OT') {
				if (inwon6_pickup_area_cd == null || inwon6_pickup_area_cd == "" || inwon6_pickup_area_cd =="undefined") {
					alert("탑승지역을 선택해 주세요.");
					$("#inwon6_pickup_area_cd").focus();
					return false;
				}			
			}				
		}

		if (traveler > 6) {
			// 여행자 정보 7
			if (inwon7_knm == null || inwon7_knm == "") {
				alert("이름를 입력해 주세요.");
				$("#inwon7_knm").focus();
				return false;
			}

			if (inwon7_efname == null || inwon7_efname == "") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon7_efname").focus();
				return false;
			}

			if (inwon7_ename == null || inwon7_ename == "") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon7_ename").focus();
				return false;
			}

			if (inwon7_ssnL == null || inwon7_ssnL == "" || inwon7_ssnL.length != 8) {
				alert("생년월일을 입력해 주세요.");
				$("#inwon7_ssnL").focus();
				return false;
			}

			if (inwon7_handphone2 == null || inwon7_handphone2 == "") {
				alert("연락처를 입력해 주세요.");
				$("#inwon7_handphone2").focus();
				return false;
			}

			if (inwon7_handphone3 == null || inwon7_handphone3 == "") {
				alert("연락처를 입력해 주세요.");
				$("#inwon7_handphone3").focus();
				return false;
			}

			if (inwon7_passYn == null || inwon7_passYn == "") {
				alert("여권 유무를 선택해 주세요.");
				$("#inwon7_passYn").focus();
				return false;
			}

			if (inwon7_sex == null || inwon7_sex == "") {
				alert("성별을 선택해 주세요.");
				$("#inwon7_sex").focus();
				return false;
			}

			if (inwon7_age == null || inwon7_age == "") {
				alert("연령을 선택해 주세요.");
				$("#inwon7_age").focus();
				return false;
			}

			if(opCd != 'OT') {
				if (inwon7_pickup_area_cd == null || inwon7_pickup_area_cd == "" || inwon7_pickup_area_cd =="undefined") {
					alert("탑승지역을 선택해 주세요.");
					$("#inwon7_pickup_area_cd").focus();
					return false;
				}			
			}					
		}


		if (traveler > 7) {
			// 여행자 정보 8
			if (inwon8_knm == null || inwon8_knm == "") {
				alert("이름를 입력해 주세요.");
				$("#inwon8_knm").focus();
				return false;
			}

			if (inwon8_efname == null || inwon8_efname == "") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon8_efname").focus();
				return false;
			}

			if (inwon8_ename == null || inwon8_ename == "") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon8_ename").focus();
				return false;
			}

			if (inwon8_ssnL == null || inwon8_ssnL == "" || inwon8_ssnL.length != 8) {
				alert("생년월일을 입력해 주세요.");
				$("#inwon8_ssnL").focus();
				return false;
			}

			if (inwon8_handphone2 == null || inwon8_handphone2 == "") {
				alert("연락처를 입력해 주세요.");
				$("#inwon8_handphone2").focus();
				return false;
			}

			if (inwon8_handphone3 == null || inwon8_handphone3 == "") {
				alert("연락처를 입력해 주세요.");
				$("#inwon8_handphone3").focus();
				return false;
			}

			if (inwon8_passYn == null || inwon8_passYn == "") {
				alert("여권 유무를 선택해 주세요.");
				$("#inwon8_passYn").focus();
				return false;
			}

			if (inwon8_sex == null || inwon8_sex == "") {
				alert("성별을 선택해 주세요.");
				$("#inwon8_sex").focus();
				return false;
			}

			if (inwon8_age == null || inwon8_age == "") {
				alert("연령을 선택해 주세요.");
				$("#inwon8_age").focus();
				return false;
			}

			if(opCd != 'OT') {
				if (inwon8_pickup_area_cd == null || inwon8_pickup_area_cd == "" || inwon8_pickup_area_cd =="undefined") {
					alert("탑승지역을 선택해 주세요.");
					$("#inwon8_pickup_area_cd").focus();
					return false;
				}			
			}					
		}

		if (traveler > 8) {
			// 여행자 정보 9
			if (inwon9_knm == null || inwon9_knm == "") {
				alert("이름를 입력해 주세요.");
				$("#inwon9_knm").focus();
				return false;
			}

			if (inwon9_efname == null || inwon9_efname == "") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon9_efname").focus();
				return false;
			}

			if (inwon9_ename == null || inwon9_ename == "") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon9_ename").focus();
				return false;
			}

			if (inwon9_ssnL == null || inwon9_ssnL == "" || inwon9_ssnL.length != 8) {
				alert("생년월일을 입력해 주세요.");
				$("#inwon9_ssnL").focus();
				return false;
			}

			if (inwon9_handphone2 == null || inwon9_handphone2 == "") {
				alert("연락처를 입력해 주세요.");
				$("#inwon9_handphone2").focus();
				return false;
			}

			if (inwon9_handphone3 == null || inwon9_handphone3 == "") {
				alert("연락처를 입력해 주세요.");
				$("#inwon9_handphone3").focus();
				return false;
			}

			if (inwon9_passYn == null || inwon9_passYn == "") {
				alert("여권 유무를 선택해 주세요.");
				$("#inwon9_passYn").focus();
				return false;
			}

			if (inwon9_sex == null || inwon9_sex == "") {
				alert("성별을 선택해 주세요.");
				$("#inwon9_sex").focus();
				return false;
			}

			if (inwon9_age == null || inwon9_age == "") {
				alert("연령을 선택해 주세요.");
				$("#inwon9_age").focus();
				return false;
			}

			if(opCd != 'OT') {
				if (inwon9_pickup_area_cd == null || inwon9_pickup_area_cd == "" || inwon9_pickup_area_cd =="undefined") {
					alert("탑승지역을 선택해 주세요.");
					$("#inwon9_pickup_area_cd").focus();
					return false;
				}			
			}					
		}

		if (traveler > 9) {
			// 여행자 정보 10
			if (inwon10_knm == null || inwon10_knm == "") {
				alert("이름를 입력해 주세요.");
				$("#inwon10_knm").focus();
				return false;
			}

			if (inwon10_efname == null || inwon10_efname == "") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon10_efname").focus();
				return false;
			}

			if (inwon10_ename == null || inwon10_ename == "") {
				alert("영문성/이름을 입력해 주세요.");
				$("#inwon10_ename").focus();
				return false;
			}

			if (inwon10_ssnL == null || inwon10_ssnL == "" || inwon10_ssnL.length != 8) {
				alert("생년월일을 입력해 주세요.");
				$("#inwon10_ssnL").focus();
				return false;
			}

			if (inwon10_handphone2 == null || inwon10_handphone2 == "") {
				alert("연락처를 입력해 주세요.");
				$("#inwon10_handphone2").focus();
				return false;
			}

			if (inwon10_handphone3 == null || inwon10_handphone3 == "") {
				alert("연락처를 입력해 주세요.");
				$("#inwon10_handphone3").focus();
				return false;
			}

			if (inwon10_passYn == null || inwon10_passYn == "") {
				alert("여권 유무를 선택해 주세요.");
				$("#inwon10_passYn").focus();
				return false;
			}

			if (inwon10_sex == null || inwon10_sex == "") {
				alert("성별을 선택해 주세요.");
				$("#inwon10_sex").focus();
				return false;
			}

			if (inwon10_age == null || inwon10_age == "") {
				alert("연령을 선택해 주세요.");
				$("#inwon10_age").focus();
				return false;
			}

			if(opCd != 'OT') {
				if (inwon10_pickup_area_cd == null || inwon10_pickup_area_cd == "" || inwon10_pickup_area_cd =="undefined") {
					alert("탑승지역을 선택해 주세요.");
					$("#inwon10_pickup_area_cd").focus();
					return false;
				}			
			}					
		}

		return true;
	}

	// 대표 예약자 정보 랑 동일 
	function equalsTraveler() {
			
		if($('input:checkbox[id="checkEqualsTraveler"]').is(":checked") == true) {
		
			dp_nm = $("#dp_nm").val();
			dp_handphone1 = $("#dp_handphone1 option:selected").text();
	
			console.log("dp_handphone1 >>>>>>>>>>>>> " + dp_handphone1);
	
			dp_handphone2 = $("#dp_handphone2").val();
			dp_handphone3 = $("#dp_handphone3").val();
			dp_email1 = $("#dp_email1").val();
			dp_email2 = $("#dp_email2 option:selected").val();
			
			console.log("dp_email2 >>>>>>>>>>>>> " + dp_email2);
	
			$("#inwon1_knm").val(dp_nm);
			$("#inwon1_handphone1 option:eq("+ dp_handphone1+ ")").attr("selected", "selected");
			$("#inwon1_handphone1").selectmenu("refresh");
			$("#inwon1_handphone2").val(dp_handphone2);
			$("#inwon1_handphone3").val(dp_handphone3);

			dp_equalsFlag = "Y";
		} else {
			dp_nm = "";
			dp_handphone1 = $("#dp_handphone1 option:selected").text();
	
			dp_handphone2 = "";
			dp_handphone3 = "";
			dp_email1 = "";
			dp_email2 = "";
			
			$("#inwon1_knm").val(dp_nm);
			$("#inwon1_handphone1 option:eq("+ dp_handphone1+ ")").attr("selected", "selected");
			$("#inwon1_handphone1").selectmenu("refresh");
			$("#inwon1_handphone2").val(dp_handphone2);
			$("#inwon1_handphone3").val(dp_handphone3);
			dp_equalsFlag = "N";
		}	
	}

	// 이메일 주소 직접 입력일 경우 
	function direct_email() {
		dp_email2 = $("#dp_email2 option:selected").val();

		if (dp_email2 == "direct") {
			var html = "<input type='text' id='dp_email3' name='dp_email3' placeholder='' style='width:100px' value=''>";
			// var html = "<input type='text' id='dp_email2' name='dp_email2' placeholder='' onkeyup='return f_IsValidEmail2(this);' style='width:150px' value=''>";
			$("#selectbox_email2").html(html);
			$("#dp_email3").focus();
		}
	}

	// 여행자 추가 
	function addTraveler() {
		traveler = parseInt(traveler + 1);
		console.log("traveler >>> " + traveler);

		if (traveler > 10) {
			alert("여행자는 최대 10명까지 추가할 수 있습니다.");
		} else {
			
		if(traveler < 2) {
			document.all.div_inwon_1.style.display= "";
			console.log("traveler 1 be abled");

		}
		if(traveler > 1) {
			document.all.div_inwon_2.style.display = "";
			console.log("traveler 2 be abled");
		}
		if(traveler > 2) {
			document.all.div_inwon_3.style.display= "";
			console.log("traveler 3 be abled");
		}
		if(traveler > 3) {
			document.all.div_inwon_4.style.display= "";
			console.log("traveler 4 be abled");
		}
		if(traveler > 4) {
			document.all.div_inwon_5.style.display= "";
			console.log("traveler 5 be abled");
		}		
		if(traveler > 5) {
			document.all.div_inwon_6.style.display= "";
			console.log("traveler 6 be abled");
		}		
		if(traveler > 6) {
			document.all.div_inwon_7.style.display= "";
			console.log("traveler 7 be abled");
		}
		if(traveler > 7) {
			document.all.div_inwon_8.style.display= "";
			console.log("traveler 8 be abled");
		}	
		if(traveler > 8) {
			document.all.div_inwon_9.style.display= "";
			console.log("traveler 9 be abled");
		}
		if(traveler > 9) {
			document.all.div_inwon_10.style.display= "";
			console.log("traveler 10 be abled");	
		}									
			$("#traveler_cnt option:eq("+ traveler+ ")").attr("selected", "selected").selectmenu("refresh", true);
		}

	}

	// 여행자 인원 선택  
	function selectbox_traveler() {
		traveler = parseInt($("#traveler_cnt option:selected").val());
		console.log("traveler >>> " + traveler);
		
		document.all.div_inwon_2.style.display= "none";
		document.all.div_inwon_3.style.display= "none";
		document.all.div_inwon_4.style.display= "none";
		document.all.div_inwon_5.style.display= "none";
		document.all.div_inwon_6.style.display= "none";
		document.all.div_inwon_7.style.display= "none";
		document.all.div_inwon_8.style.display= "none";
		document.all.div_inwon_9.style.display= "none";
		document.all.div_inwon_9.style.display= "none";
		
		// alert("traveler " + traveler);
		if(traveler < 2) {
			document.all.div_inwon_1.style.display= "";
			console.log("traveler 1 be abled");

		}
		if(traveler > 1) {
			document.all.div_inwon_2.style.display = "";
			console.log("traveler 2 be abled");
		}
		if(traveler > 2) {
			document.all.div_inwon_3.style.display= "";
			console.log("traveler 3 be abled");
		}
		if(traveler > 3) {
			document.all.div_inwon_4.style.display= "";
			console.log("traveler 4 be abled");
		}
		if(traveler > 4) {
			document.all.div_inwon_5.style.display= "";
			console.log("traveler 5 be abled");
		}		
		if(traveler > 5) {
			document.all.div_inwon_6.style.display= "";
			console.log("traveler 6 be abled");
		}		
		if(traveler > 6) {
			document.all.div_inwon_7.style.display= "";
			console.log("traveler 7 be abled");
		}
		if(traveler > 7) {
			document.all.div_inwon_8.style.display= "";
			console.log("traveler 8 be abled");
		}	
		if(traveler > 8) {
			document.all.div_inwon_9.style.display= "";
			console.log("traveler 9 be abled");
		}
		if(traveler > 9) {
			document.all.div_inwon_10.style.display= "";
			console.log("traveler 10 be abled");	
		}	
		
	}

	// 연령대에 대한 가격표 셋팅 
	function fn_setInwonAge(idx) {

		var tag = "#inwon" + idx + "_age option:selected";
		var tag2 = "#inwon" + idx + "_price";
		var age = $(tag).val();

		console.log("fn_setInwonAge() >>>>> age : " + age);
		console.log("tag2 >>>>>>>>>>>>>>  " + tag2);
		
		//[JEH] 임직원 할인 추가 - 20190610
		if(grade == "그룹직원" && <%=empAdultPrice%> > 0){
			if (age == "") { // 없음 
				$(tag2).html("0");
	
			} else if (age == "adult") { // 성인
	
				$(tag2).html(toWon(Math.round(<%=empAdultPrice%>)));
				adult_price = Math.round(<%=empAdultPrice%>);
	
			} else if (age == "child") { // 아동 
	
				$(tag2).html(toWon(Math.round(<%=empChildPrice%>)));
				child_price = Math.round(<%=empChildPrice%>);
	
			} else if (age == "baby") { // 유아 
	
				$(tag2).html(toWon(Math.round(<%=empBabyPrice%>)));
				baby_price = Math.round(<%=empBabyPrice%>);
	
			}
		}else{
			if (age == "") { // 없음 
				$(tag2).html("0");

			} else if (age == "adult") { // 성인

				$(tag2).html(toWon(adult_price));

			} else if (age == "child") { // 아동 

				$(tag2).html(toWon(child_price));

			} else if (age == "baby") { // 유아 

				$(tag2).html(toWon(baby_price));

			}
		}
		setAlign_prices();
	}

	// ----------------------------------------------------------------
	// 상품 가격 정렬 
	// ----------------------------------------------------------------

	function setAlign_prices() {
		var i;
		var tag = "";
		var age = "";

		// 예약 상품 가격 초기화 
		init_prices();

		for (i = 1; i < 11; i++) {
			tag = "#inwon" + i + "_age option:selected";
			age = $(tag).val();

			console.log("setAlign_prices() >>>>> age : " + age);

			if (age == "adult") { // 성인

				tot_adult_inwon = tot_adult_inwon + 1;

			} else if (age == "child") { // 아동 

				tot_child_inwon = tot_child_inwon + 1;

			} else if (age == "baby") { // 유아 

				tot_baby_inwon = tot_baby_inwon + 1;

			}

		}

		// 총 합산 
		//[JEH] 임직원 할인 추가 - 20190610
		if(grade == "그룹직원" && <%=empAdultPrice%> > 0){
			tot_adult_price = Math.round(<%=empAdultPrice%> * tot_adult_inwon);
			tot_child_price = Math.round(<%=empChildPrice%> * tot_child_inwon);
			tot_baby_price = Math.round(<%=empBabyPrice%> * tot_baby_inwon);
		}else{
			tot_adult_price = adult_price * tot_adult_inwon;
			tot_child_price = child_price * tot_child_inwon;
			tot_baby_price = baby_price * tot_baby_inwon;
		}
		tot_acc_price = tot_adult_price + tot_child_price + tot_baby_price;

		$("#tot_adult_inwon").html(toWon(tot_adult_inwon));
		$("#tot_adult_price").html(toWon(tot_adult_price));

		$("#tot_child_inwon").html(toWon(tot_child_inwon));
		$("#tot_child_price").html(toWon(tot_child_price));

		$("#tot_baby_inwon").html(toWon(tot_baby_inwon));
		$("#tot_baby_price").html(toWon(tot_baby_price));

		$("#tot_acc_price").html(toWon(tot_acc_price));

	}

	function init_prices() {
		console.log("init_prices() >>>>>>>>>>>>>  초기화 >>>>>>>>>>>>>>>>> ");

		// 성인 여행자 총 포함 인원 및 금액 
		tot_adult_inwon = 0;
		tot_adult_price = 0;

		// 아동 여행자 총 포함 인원 및 금액 
		tot_child_inwon = 0;
		tot_child_price = 0;

		// 유아 여행자 총 포함 인원 및 금액 
		tot_baby_inwon = 0;
		tot_baby_price = 0;

		// 총 결제 금액 
		tot_acc_price = 0;

		$("#tot_adult_inwon").html(toWon(tot_adult_inwon));
		$("#tot_adult_price").html(toWon(tot_adult_price));

		$("#tot_child_inwon").html(toWon(tot_child_inwon));
		$("#tot_child_price").html(toWon(tot_child_price));

		$("#tot_baby_inwon").html(toWon(tot_baby_inwon));
		$("#tot_baby_price").html(toWon(tot_baby_price));

		$("#tot_acc_price").html(toWon(tot_acc_price));
	}

	// 연령대별 가격 정보 얻기 
	function fn_getPricePerAge(age) {
		if (age == "adult") {
			return adult_price;
		} else if (age == "child") {
			return child_price;
		} else if (age == "baby") {
			return baby_price;
		} else {
			return 0;
		}
	}

	// 여행자 정보 값 얻기
	function fn_getParams() {
		// 대표 여행자 정보
		dp_nm = $("#dp_nm").val();
		dp_handphone1 = $("#dp_handphone1 option:selected").val();
		dp_handphone2 = $("#dp_handphone2").val();
		dp_handphone3 = $("#dp_handphone3").val();
		dp_email1 = $("#dp_email1").val();
		dp_email2 = $("#dp_email2 option:selected").val();

		
		// 직접 입력일 경우 dp_email3 에서 입력된 정보로 셋팅 
		if (dp_email2 == null || dp_email2 == "" || dp_email2 =="undefined") {
			dp_email3 =  $("#dp_email3").val();
			dp_email2 = dp_email3;	
		} 

		
		//[JEH] 롯데면세점일경우 공백처리 - 20190510
		if(goodsCd == 'PGI1011'){
			dp_comment = "";
		}else{
			dp_comment = $("#dp_comment").val();
		}
		
		if($('input:checkbox[id="checkEqualsTraveler"]').is(":checked") == true) {
			dp_equalsFlag = "Y";
		} else {	
			dp_equalsFlag = "N";
		}
		// 여행자 정보 1
		inwon1_knm = $("#inwon1_knm").val();
		inwon1_efname = $("#inwon1_efname").val();
		inwon1_ename = $("#inwon1_ename").val();
		inwon1_ssnL = $("#inwon1_ssnL").val();
		inwon1_handphone1 = $("#inwon1_handphone1 option:selected").val();
		inwon1_handphone2 = $("#inwon1_handphone2").val();
		inwon1_handphone3 = $("#inwon1_handphone3").val();
		inwon1_passYn = $('input:radio[name=inwon1_passYn]:checked').val();
		inwon1_sex = $('input:radio[name=inwon1_sex]:checked').val();
		inwon1_age = $("#inwon1_age option:selected").val();
		inwon1_price = fn_getPricePerAge(inwon1_age);
		inwon1_pickup_area_cd = $("#inwon1_pickup_area_cd option:selected").val();

		console.log("inwon1_pickup_area_cd : " + inwon1_pickup_area_cd);

		if (traveler > 1) {
			// 여행자 정보 2
			inwon2_knm = $("#inwon2_knm").val();
			inwon2_efname = $("#inwon2_efname").val();
			inwon2_ename = $("#inwon2_ename").val();
			inwon2_ssnL = $("#inwon2_ssnL").val();
			inwon2_handphone1 = $("#inwon2_handphone1 option:selected").val();
			inwon2_handphone2 = $("#inwon2_handphone2").val();
			inwon2_handphone3 = $("#inwon2_handphone3").val();
			inwon2_passYn = $('input:radio[name=inwon2_passYn]:checked').val();
			inwon2_sex = $('input:radio[name=inwon2_sex]:checked').val();
			inwon2_age = $("#inwon2_age option:selected").val();
			inwon2_price = fn_getPricePerAge(inwon2_age);
			inwon2_pickup_area_cd = $("#inwon2_pickup_area_cd option:selected").val();
		}

		if (traveler > 2) {
			// 여행자 정보 3
			inwon3_knm = $("#inwon3_knm").val();
			inwon3_efname = $("#inwon3_efname").val();
			inwon3_ename = $("#inwon3_ename").val();
			inwon3_ssnL = $("#inwon3_ssnL").val();
			inwon3_handphone1 = $("#inwon3_handphone1 option:selected").val();
			inwon3_handphone2 = $("#inwon3_handphone2").val();
			inwon3_handphone3 = $("#inwon3_handphone3").val();
			inwon3_passYn = $('input:radio[name=inwon3_passYn]:checked').val();
			inwon3_sex = $('input:radio[name=inwon3_sex]:checked').val();
			inwon3_age = $("#inwon3_age option:selected").val();
			inwon3_price = fn_getPricePerAge(inwon3_age);
			inwon3_pickup_area_cd = $("#inwon3_pickup_area_cd option:selected").val();

		}

		if (traveler > 3) {
			// 여행자 정보 4
			inwon4_knm = $("#inwon4_knm").val();
			inwon4_efname = $("#inwon4_efname").val();
			inwon4_ename = $("#inwon4_ename").val();
			inwon4_ssnL = $("#inwon4_ssnL").val();
			inwon4_handphone1 = $("#inwon4_handphone1 option:selected").val();
			inwon4_handphone2 = $("#inwon4_handphone2").val();
			inwon4_handphone3 = $("#inwon4_handphone3").val();
			inwon4_passYn = $('input:radio[name=inwon4_passYn]:checked').val();
			inwon4_sex = $('input:radio[name=inwon4_sex]:checked').val();
			inwon4_age = $("#inwon4_age option:selected").val();
			inwon4_price = fn_getPricePerAge(inwon4_age);
			inwon4_pickup_area_cd = $("#inwon4_pickup_area_cd option:selected").val();

		}

		if (traveler > 4) {
			// 여행자 정보 5
			inwon5_knm = $("#inwon5_knm").val();
			inwon5_efname = $("#inwon5_efname").val();
			inwon5_ename = $("#inwon5_ename").val();
			inwon5_ssnL = $("#inwon5_ssnL").val();
			inwon5_handphone1 = $("#inwon5_handphone1 option:selected").val();
			inwon5_handphone2 = $("#inwon5_handphone2").val();
			inwon5_handphone3 = $("#inwon5_handphone3").val();
			inwon5_passYn = $('input:radio[name=inwon5_passYn]:checked').val();
			inwon5_sex = $('input:radio[name=inwon5_sex]:checked').val();
			inwon5_age = $("#inwon5_age option:selected").val();
			inwon5_price = fn_getPricePerAge(inwon5_age);
			inwon5_pickup_area_cd = $("#inwon5_pickup_area_cd option:selected").val();
			
		}

		if (traveler > 5) {
			// 여행자 정보 6
			inwon6_knm = $("#inwon6_knm").val();
			inwon6_efname = $("#inwon6_efname").val();
			inwon6_ename = $("#inwon6_ename").val();
			inwon6_ssnL = $("#inwon6_ssnL").val();
			inwon6_handphone1 = $("#inwon6_handphone1 option:selected").val();
			inwon6_handphone2 = $("#inwon6_handphone2").val();
			inwon6_handphone3 = $("#inwon6_handphone3").val();
			inwon6_passYn = $('input:radio[name=inwon6_passYn]:checked').val();
			inwon6_sex = $('input:radio[name=inwon6_sex]:checked').val();
			inwon6_age = $("#inwon6_age option:selected").val();
			inwon6_price = fn_getPricePerAge(inwon6_age);
			inwon6_pickup_area_cd = $("#inwon6_pickup_area_cd option:selected").val();
		
		}
		if (traveler > 6) {
			// 여행자 정보 7
			inwon7_knm = $("#inwon7_knm").val();
			inwon7_efname = $("#inwon7_efname").val();
			inwon7_ename = $("#inwon7_ename").val();
			inwon7_ssnL = $("#inwon7_ssnL").val();
			inwon7_handphone1 = $("#inwon7_handphone1 option:selected").val();
			inwon7_handphone2 = $("#inwon7_handphone2").val();
			inwon7_handphone3 = $("#inwon7_handphone3").val();
			inwon7_passYn = $('input:radio[name=inwon7_passYn]:checked').val();
			inwon7_sex = $('input:radio[name=inwon7_sex]:checked').val();
			inwon7_age = $("#inwon7_age option:selected").val();
			inwon7_price = fn_getPricePerAge(inwon7_age);
			inwon7_pickup_area_cd = $("#inwon7_pickup_area_cd option:selected").val();
		
		}

		if (traveler > 7) {
			// 여행자 정보 8
			inwon8_knm = $("#inwon8_knm").val();
			inwon8_efname = $("#inwon8_efname").val();
			inwon8_ename = $("#inwon8_ename").val();
			inwon8_ssnL = $("#inwon8_ssnL").val();
			inwon8_handphone1 = $("#inwon8_handphone1 option:selected").val();
			inwon8_handphone2 = $("#inwon8_handphone2").val();
			inwon8_handphone3 = $("#inwon8_handphone3").val();
			inwon8_passYn = $('input:radio[name=inwon8_passYn]:checked').val();
			inwon8_sex = $('input:radio[name=inwon8_sex]:checked').val();
			inwon8_age = $("#inwon8_age option:selected").val();
			inwon8_price = fn_getPricePerAge(inwon8_age);
			inwon8_pickup_area_cd = $("#inwon8_pickup_area_cd option:selected").val();

		}

		if (traveler > 8) {
			// 여행자 정보 9
			inwon9_knm = $("#inwon9_knm").val();
			inwon9_efname = $("#inwon9_efname").val();
			inwon9_ename = $("#inwon9_ename").val();
			inwon9_ssnL = $("#inwon9_ssnL").val();
			inwon9_handphone1 = $("#inwon9_handphone1 option:selected").val();
			inwon9_handphone2 = $("#inwon9_handphone2").val();
			inwon9_handphone3 = $("#inwon9_handphone3").val();
			inwon9_passYn = $('input:radio[name=inwon9_passYn]:checked').val();
			inwon9_sex = $('input:radio[name=inwon9_sex]:checked').val();
			inwon9_age = $("#inwon9_age option:selected").val();
			inwon9_price = fn_getPricePerAge(inwon9_age);
			inwon9_pickup_area_cd = $("#inwon9_pickup_area_cd option:selected").val();
			
		}

		if (traveler > 9) {
			// 여행자 정보 10
			inwon10_knm = $("#inwon10_knm").val();
			inwon10_efname = $("#inwon10_efname").val();
			inwon10_ename = $("#inwon10_ename").val();
			inwon10_ssnL = $("#inwon10_ssnL").val();
			inwon10_handphone1 = $("#inwon10_handphone1 option:selected").val();
			inwon10_handphone2 = $("#inwon10_handphone2").val();
			inwon10_handphone3 = $("#inwon10_handphone3").val();
			inwon10_passYn = $('input:radio[name=inwon10_passYn]:checked').val();
			inwon10_sex = $('input:radio[name=inwon10_sex]:checked').val();
			inwon10_age = $("#inwon10_age option:selected").val();
			inwon10_price = fn_getPricePerAge(inwon10_age);
			inwon10_pickup_area_cd = $("#inwon10_pickup_area_cd option:selected").val();
			
		}
	}

	/*******************************************************************************/
	// [Ajax] 데이터 통신 부분 
	// 회원 정보 조회 
	var fn_srchMember = function() {
		var formData = new FormData();
		formData.append("event_cd", eventCd);

		cfn_ajax({
			url : "/reserve/saveReserveAjax.do",
			type : "POST",
			data : formData,
			async : false,
			dataType : "json",
			cache : false,
			noloading : "no",
			timeOut : (5 * 60 * 1000),
			success : function(res) {

			},
			error : function(err) {
				console.log(err);
			},
			complete : function() {
			}
		});
	};

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
				html = html + "<select id='dp_handphone1' name='dp_handphone1' class='input' maxlength='3'>";
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

				// 여행자 1 ~ 10까지
				for (var index = 1; index < 11; index++) {
					var html2 = "<select id='inwon" +index+ "_handphone1' name='inwon" +index+ "_handphone1' class='input' maxlength='3'>";
					if (hpComcodeList != null) {
						for (var i = 0; i < hpComcodeList.length; i++) {
							if (hpComcodeList[i]["cd"] != '000') {
							if(i == 0) {
								html2 = html2 + "<option value='"+hpComcodeList[i]["cd"]+"' selected>" + hpComcodeList[i]["cd"] + "</option>";
							} else {
								html2 = html2 + "<option value='"+hpComcodeList[i]["cd"]+"'>" + hpComcodeList[i]["cd"] + "</option>";
							}

							}
						}

					}
					html2 = html2 + "</select>";
					var tag = "#selectbox_inwon" + index + "_handphone1";
					// console.log(">>>>>>>>>>>>>>>>>>>>>>>>> html2 >> " + html2);

					$(tag).html(html2);
				}

			},
			error : function(err) {
				console.log(err);
			},
			complete : function() {
			}
		});
	};

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
				if(nullToBlank(email2) == ""){
					setTimeout(function(){
						//$("#dp_email2").val("naver.com").selectmenu('refresh');
						$("#dp_email2").val("hanmail.net").selectmenu('refresh');
					}, 10);
				}
			}
		});
	};

	// 탑승지역 코드 조회 
	var fn_srchPickupAreaSysComCode = function() {
		var formData = new FormData();
		formData.append("grp_cd", "PICKUPAREA");
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
				
				// 여행자 1 ~ 10까지
				for (var index = 1; index < 11; index++) {				
					var html =  "<select id='inwon" +index+ "_pickup_area_cd' name='inwon" +index+ "_pickup_area_cd' class='input' style='width:180px'>";
					if (comcodeList != null) {
						for (var i = 0; i < comcodeList.length; i++) {
							if(i == 0) {
								html = html + "<option value='"+comcodeList[i]["cd"]+"' selected>" + comcodeList[i]["cd_nm"] + "</option>";
							} else {
								html = html + "<option value='"+comcodeList[i]["cd"]+"'>" + comcodeList[i]["cd_nm"] + "</option>";
							}
						}
					}
					html = html + "</select>";
					
					var tag = "#selectbox_inwon" + index + "_pickup_area_cd";

					$(tag).html(html);					
				}
			},
			error : function(err) {
				console.log(err);
			},
			complete : function() {
				
			}
		});
	};

	// 여행자 정보 리스트 셋팅 
	function setTravelerList() {
		for (var i = 1; i < 11; i++) {

			var html = "";
			if (i == 1) {
				html = html + "				<h1 class='collapsHeading'>";
				html = html + "					여행자 정보 1 <div class='check_wrap floatR finishck'><input type='checkbox' id='checkEqualsTraveler' onClick='equalsTraveler()'> <label for='checkEqualsTraveler'><i>대표예약자와 동일</i></label></div>"
				html = html + "				</h1>";
			} else {
				html = html + "            <h1 class='collapsHeading'>여행자 정보 " + i + "</h1>";

			}
			html = html + "                <div class='collapsContent'>";
			html = html + "                	<table>";
			html = html + "                    <colgroup>";
			html = html + "                        <col width='30%'>";
			html = html + "                        <col width='70%'>";
			html = html + "                    </colgroup>";
			html = html + "                    <tbody>";
			html = html + "                       <tr>";
			html = html + "                           <th>이름</th>";
			html = html + "                           <td><input type='text' id='inwon"+i+"_knm' name='inwon"+i+"_knm' value=''></td>";
			html = html + "                        </tr>";
			html = html + "                        <tr>";
			html = html + "                           <th>영문성/이름</th>";
			html = html + "                           <td><input type='text' id='inwon"+i+"_efname' name='inwon"+i+"_efname' value='' onpaste='javascript:return false;' style='text-transform:uppercase;'><span class='divide'>/</span><input type='text' id='inwon"+i+"_ename' name='inwon"+i+"_ename' value='' style='text-transform:uppercase;' onpaste='javascript:return false;'></td>";
			html = html + "                        </tr>";
			html = html + "                        <tr>";
			html = html + "                           <th>생년월일</th>";
			html = html + "                           <td><input type='number' id='inwon" + i + "_ssnL' name='inwon" + i + "_ssnL' value='' maxlength='8' pattern='[0-9]*' style='text-align:center;IME-MODE:disabled;' onkeydown='return f_Onlynum();'  onkeyup='limitText(this, 8)'><span class='birthtext'>숫자만 입력해주세요. Ex) 19701213</span></td>";
			html = html + "                        </tr>";
			html = html + "                        <tr>";
			html = html + "                           <th>연락처</th>";
			html = html + "                           <td class='hp'><div id='selectbox_inwon"+i+"_handphone1' name='selectbox_inwon"+i+"_handphone1'></div><input type='number' id='inwon"+ i+ "_handphone2' name='inwon"+ i+ "_handphone2' data-maxlength='4' onkeydown='return f_Onlynum();' value='' onkeyup='limitText(this, 4)'><span class='hyphen'></span><input type='number' id='inwon"+ i+ "_handphone3' name='inwon"+ i+ "_handphone3' data-maxlength='4' onkeydown='return f_Onlynum();' value='' onkeyup='limitText(this, 4)'></td>";
			html = html + "                        </tr>";
			html = html + "                        <tr>";
			html = html + "                            <th>여권유무</th>";
			html = html + "								<td class='rd'>";
			html = html + "									<input type='radio' name='inwon"+i+"_passYn' id='inwon"+i+"_passYn' value='N' checked>";
			html = html + "									<label for='inwon"+i+"_passYn'><span class='radioTxt'>없음</span></label>";
			html = html + "									<input type='radio' name='inwon"+i+"_passYn' id='inwon"+i+"_passYn2' value='Y'>";
			html = html + "									<label for='inwon"+i+"_passYn2'><span class='radioTxt'>있음</span></label>";
			html = html + "								</td>";
			html = html + "                        </tr>";
			html = html + "                        <tr>";
			html = html + "                           <th>성별</th>";
			html = html + "							  <td class='rd'>";
			html = html + "								<input type='radio' name='inwon"+i+"_sex' id='inwon"+i+"_sex' value='M' checked>";
			html = html + "								<label for='inwon"+i+"_sex'><span class='radioTxt'>남자</span></label>";
			html = html + "								<input type='radio' name='inwon"+i+"_sex' id='inwon"+i+"_sex2' value='F'>";
			html = html + "								<label for='inwon"+i+"_sex2'><span class='radioTxt'>여자</span></label>";
			html = html + "							  </td>";
			html = html + "                        </tr>";
			html = html + "                        <tr>";
			html = html + "                            <th>연령</th>";
			html = html + "                            <td>";
			html = html + "                                <select id='inwon" + i + "_age' name='inwon" + i + "_age' class='input' onchange='fn_setInwonAge(" + i + ")'>";
			html = html + "                                   <option value=''>없음</option>";
			html = html + "                                   <option value='adult'>성인</option>";
			html = html + "                                   <option value='child'>아동</option>";
			html = html + "                                   <option value='baby'>유아</option>";
			html = html + "                                </select>";
			html = html + "                                <span class='travtxt'>여행경비 <i class='point'><div id='inwon"+i+"_price' name='inwon"+i+"_price'>0</div></i>원</span>";
			html = html + "                            </td>";
			html = html + "                        </tr>";
			
			////////////////////////////////////// 국내 여행일 때만 ////////////////////////////////////// 
			if(opCd != 'OT') { // GDMst 테이블내 OP_CD 가 OT 아니면 국내여행, OP_CD가 OT 이면 해외여행 
				html = html + "	          			   <tr class='pickup_area'>";
				html = html + "	          					<th>탑승지역</th>";
				html = html + "	          					<td class='in_area_rsv'><span id='selectbox_inwon"+i+"_pickup_area_cd' name='selectbox_inwon"+i+"_pickup_area_cd' data-role='none'></span></td>";
				html = html + "							</tr>";
			}

			html = html + "                    </tbody>";
			html = html + "                	</table>";
			html = html + "            	   </div>";
			var tag = "#div_inwon_" + i;
			$(tag).html(html);

		}
		//[JEH] 탑승지역 hidden 처리 - 20190513
		if(eventCd == "KIB7541190520NA1" || eventCd == "KIB7551190527NA1"){
			$(".pickup_area").attr("style", "display:none");
		}
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

	// 예약 정보 입력   
	var fn_saveReserve = function() {
		
		
		console.log(reserveFlag);
		
		// 미 로그인 시 
		/**
		if(fn_chkLogin() == 1) {
			var cust_id = fn_getCookieLogin();
		 **/
		
		// 여행 대표자 정보 및 여행자 정보 얻기  
		fn_getParams();

		// 파라미터 값이 유효할 때 
		if (check_param()) {
		
			showLoading();
		
			if(reserveFlag){
				return false;
			}
			
			reserveFlag = true;

			var formData = new FormData();
			formData.append("event_cd", eventCd);
			formData.append("reserve_cnt", traveler);
			formData.append("order_type", order_type); // 비회원 주문의 경우 공백 
			formData.append("comp_cd", comp_cd);
			formData.append("adult_price", adult_price);
			formData.append("child_price", child_price);
			formData.append("baby_price", baby_price);
			//기본상품가
			formData.append("adult_base_price", adult_base_price);
			formData.append("child_base_price", child_base_price);
			formData.append("baby_base_price", baby_base_price);
			//유류할증료
			formData.append("etc_price1", etc_price1);
			formData.append("etc_price2", etc_price2);
			formData.append("etc_price3", etc_price3);
			
			formData.append("join_area", ctg);
			formData.append("comp_cd", compCd);
			
			// 대표 여행자 정보 
			formData.append("dp_nm", dp_nm);
			formData.append("dp_handphone1", dp_handphone1);
			formData.append("dp_handphone2", dp_handphone2);
			formData.append("dp_handphone3", dp_handphone3);
			formData.append("dp_email1", dp_email1);

			formData.append("dp_email2", dp_email2);
			formData.append("dp_comment", dp_comment);
			formData.append("dp_equalsFlag", dp_equalsFlag);
			// 여행자 정보 1
			formData.append("inwon1_knm", inwon1_knm);
			formData.append("inwon1_efname", inwon1_efname);
			formData.append("inwon1_ename", inwon1_ename);
			formData.append("inwon1_ssnL", inwon1_ssnL);
			formData.append("inwon1_handphone1", inwon1_handphone1);

			formData.append("inwon1_handphone2", inwon1_handphone2);
			formData.append("inwon1_handphone3", inwon1_handphone3);
			formData.append("inwon1_passYn", inwon1_passYn);
			formData.append("inwon1_passYn2", inwon1_passYn2);
			formData.append("inwon1_sex", inwon1_sex);

			formData.append("inwon1_sex2", inwon1_sex2);
			formData.append("inwon1_age", inwon1_age);
			formData.append("inwon1_price", inwon1_price);
			formData.append("inwon1_pickup_area_cd", inwon1_pickup_area_cd);
			
			if(grade == "그룹직원"){
				formData.append("mass_site_cd", "MM");
			}else{
				formData.append("mass_site_cd", "LM");
			}

			if (traveler > 1) {
				// 여행자 정보 2
				formData.append("inwon2_knm", inwon2_knm);
				formData.append("inwon2_efname", inwon2_efname);
				formData.append("inwon2_ename", inwon2_ename);
				formData.append("inwon2_ssnL", inwon2_ssnL);
				formData.append("inwon2_handphone1", inwon2_handphone1);

				formData.append("inwon2_handphone2", inwon2_handphone2);
				formData.append("inwon2_handphone3", inwon2_handphone3);
				formData.append("inwon2_passYn", inwon2_passYn);
				formData.append("inwon2_passYn2", inwon2_passYn2);
				formData.append("inwon2_sex", inwon2_sex);

				formData.append("inwon2_sex2", inwon2_sex2);
				formData.append("inwon2_age", inwon2_age);
				formData.append("inwon2_price", inwon2_price);
				formData.append("inwon2_pickup_area_cd", inwon2_pickup_area_cd);
			
			}

			if (traveler > 2) {
				// 여행자 정보 3
				formData.append("inwon3_knm", inwon3_knm);
				formData.append("inwon3_efname", inwon3_efname);
				formData.append("inwon3_ename", inwon3_ename);
				formData.append("inwon3_ssnL", inwon3_ssnL);
				formData.append("inwon3_handphone1", inwon3_handphone1);

				formData.append("inwon3_handphone2", inwon3_handphone2);
				formData.append("inwon3_handphone3", inwon3_handphone3);
				formData.append("inwon3_passYn", inwon3_passYn);
				formData.append("inwon3_passYn2", inwon3_passYn2);
				formData.append("inwon3_sex", inwon3_sex);

				formData.append("inwon3_sex2", inwon3_sex2);
				formData.append("inwon3_age", inwon3_age);
				formData.append("inwon3_price", inwon3_price);
				formData.append("inwon3_pickup_area_cd", inwon3_pickup_area_cd);
			}

			if (traveler > 3) {
				// 여행자 정보 4
				formData.append("inwon4_knm", inwon4_knm);
				formData.append("inwon4_efname", inwon4_efname);
				formData.append("inwon4_ename", inwon4_ename);
				formData.append("inwon4_ssnL", inwon4_ssnL);
				formData.append("inwon4_handphone1", inwon4_handphone1);

				formData.append("inwon4_handphone2", inwon4_handphone2);
				formData.append("inwon4_handphone3", inwon4_handphone3);
				formData.append("inwon4_passYn", inwon4_passYn);
				formData.append("inwon4_passYn2", inwon4_passYn2);
				formData.append("inwon4_sex", inwon4_sex);

				formData.append("inwon4_sex2", inwon4_sex2);
				formData.append("inwon4_age", inwon4_age);
				formData.append("inwon4_price", inwon4_price);
				formData.append("inwon4_pickup_area_cd", inwon4_pickup_area_cd);
			}

			if (traveler > 4) {
				// 여행자 정보 5
				formData.append("inwon5_knm", inwon5_knm);
				formData.append("inwon5_efname", inwon5_efname);
				formData.append("inwon5_ename", inwon5_ename);
				formData.append("inwon5_ssnL", inwon5_ssnL);
				formData.append("inwon5_handphone1", inwon5_handphone1);

				formData.append("inwon5_handphone2", inwon5_handphone2);
				formData.append("inwon5_handphone3", inwon5_handphone3);
				formData.append("inwon5_passYn", inwon5_passYn);
				formData.append("inwon5_passYn2", inwon5_passYn2);
				formData.append("inwon5_sex", inwon5_sex);

				formData.append("inwon5_sex2", inwon5_sex2);
				formData.append("inwon5_age", inwon5_age);
				formData.append("inwon5_price", inwon5_price);
				formData.append("inwon5_pickup_area_cd", inwon5_pickup_area_cd);
			}

			if (traveler > 5) {
				// 여행자 정보 6
				formData.append("inwon6_knm", inwon6_knm);
				formData.append("inwon6_efname", inwon6_efname);
				formData.append("inwon6_ename", inwon6_ename);
				formData.append("inwon6_ssnL", inwon6_ssnL);
				formData.append("inwon6_handphone1", inwon6_handphone1);

				formData.append("inwon6_handphone2", inwon6_handphone2);
				formData.append("inwon6_handphone3", inwon6_handphone3);
				formData.append("inwon6_passYn", inwon6_passYn);
				formData.append("inwon6_passYn2", inwon6_passYn2);
				formData.append("inwon6_sex", inwon6_sex);

				formData.append("inwon6_sex2", inwon6_sex2);
				formData.append("inwon6_age", inwon6_age);
				formData.append("inwon6_price", inwon6_price);
				formData.append("inwon6_pickup_area_cd", inwon6_pickup_area_cd);
			}

			if (traveler > 6) {
				// 여행자 정보 7
				formData.append("inwon7_knm", inwon7_knm);
				formData.append("inwon7_efname", inwon7_efname);
				formData.append("inwon7_ename", inwon7_ename);
				formData.append("inwon7_ssnL", inwon7_ssnL);
				formData.append("inwon7_handphone1", inwon7_handphone1);

				formData.append("inwon7_handphone2", inwon7_handphone2);
				formData.append("inwon7_handphone3", inwon7_handphone3);
				formData.append("inwon7_passYn", inwon7_passYn);
				formData.append("inwon7_passYn2", inwon7_passYn2);
				formData.append("inwon7_sex", inwon7_sex);

				formData.append("inwon7_sex2", inwon7_sex2);
				formData.append("inwon7_age", inwon7_age);
				formData.append("inwon7_price", inwon7_price);
				formData.append("inwon7_pickup_area_cd", inwon7_pickup_area_cd);
			}

			if (traveler > 7) {
				// 여행자 정보 8
				formData.append("inwon8_knm", inwon8_knm);
				formData.append("inwon8_efname", inwon8_efname);
				formData.append("inwon8_ename", inwon8_ename);
				formData.append("inwon8_ssnL", inwon8_ssnL);
				formData.append("inwon8_handphone1", inwon8_handphone1);

				formData.append("inwon8_handphone2", inwon8_handphone2);
				formData.append("inwon8_handphone3", inwon8_handphone3);
				formData.append("inwon8_passYn", inwon8_passYn);
				formData.append("inwon8_passYn2", inwon8_passYn2);
				formData.append("inwon8_sex", inwon8_sex);

				formData.append("inwon8_sex2", inwon8_sex2);
				formData.append("inwon8_age", inwon8_age);
				formData.append("inwon8_price", inwon8_price);
				formData.append("inwon8_pickup_area_cd", inwon8_pickup_area_cd);
			}

			if (traveler > 8) {
				// 여행자 정보 9
				formData.append("inwon9_knm", inwon9_knm);
				formData.append("inwon9_efname", inwon9_efname);
				formData.append("inwon9_ename", inwon9_ename);
				formData.append("inwon9_ssnL", inwon9_ssnL);
				formData.append("inwon9_handphone1", inwon9_handphone1);

				formData.append("inwon9_handphone2", inwon9_handphone2);
				formData.append("inwon9_handphone3", inwon9_handphone3);
				formData.append("inwon9_passYn", inwon9_passYn);
				formData.append("inwon9_passYn2", inwon9_passYn2);
				formData.append("inwon9_sex", inwon9_sex);

				formData.append("inwon9_sex2", inwon9_sex2);
				formData.append("inwon9_age", inwon9_age);
				formData.append("inwon9_price", inwon9_price);
				formData.append("inwon9_pickup_area_cd", inwon9_pickup_area_cd);
			}

			if (traveler > 9) {
				// 여행자 정보 10
				formData.append("inwon10_knm", inwon10_knm);
				formData.append("inwon10_efname", inwon10_efname);
				formData.append("inwon10_ename", inwon10_ename);
				formData.append("inwon10_ssnL", inwon10_ssnL);
				formData.append("inwon10_handphone1", inwon10_handphone1);

				formData.append("inwon10_handphone2", inwon10_handphone2);
				formData.append("inwon10_handphone3", inwon10_handphone3);
				formData.append("inwon10_passYn", inwon10_passYn);
				formData.append("inwon10_passYn2", inwon10_passYn2);
				formData.append("inwon10_sex", inwon10_sex);

				formData.append("inwon10_sex2", inwon10_sex2);
				formData.append("inwon10_age", inwon10_age);
				formData.append("inwon10_price", inwon10_price);
				formData.append("inwon10_pickup_area_cd", inwon10_pickup_area_cd);
			}
			formData.append("mktAgreeYn", mktAgreeYn);
			formData.append("childAgreeYn", childAgreeYn);
			
			formData.append("smsAgreeYn", smsAgreeYn);
			formData.append("emailAgreeYn", emailAgreeYn);			
			
			var resCd = "";
			cfn_ajax({
				url : "/reserve/saveReserveAjax.do",
				type : "POST",
				data : formData,
				async : false,
				dataType : "json",
				cache : false,
				noloading : "no",
				timeOut : (5 * 60 * 1000),
				success : function(res) {
					resCd = res.resCd;
					console.log("**********************");
					console.log(res.accYn);
					if(res.accYn == 'N'){
						alert("예약 마감되었습니다.");
					}
					
					console.log(" >>>>>>>>>>>>>> 예약 정보 입력 >>>>>>>>>>>>>>>> " + resCd);

				},
				error : function(err) {
					console.log(err);
					alert("예약 정보 저장에 실패했습니다. 다시 시도해 주세요. ");
					reserveFlag = false;
				},
				complete : function() {
					hideLoading();
					if(resCd != null && resCd != '') {
						document.location.replace("/reserve/reserve_finish.do?ctg=" + ctg + "&eventCd=" + eventCd+"&resCd="+resCd);
					}else{
						reserveFlag = false;
					}
				}
			});
		}

		/**	
		} else {
			history.back(-1);
		}
		 **/
	};

	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();
		$(".collapsDiv").trigger("create");
		$(".mT10").trigger("create");
		
		//대문자 처리 영문성명
		/***
		 for(var i=1; i < 11; i++) {
			var tag = "#inwon" + i + "_efname";
			var tag1 = "#inwon" + i + "_ename";
		
			$(tag).bind("keyup", function() {
				$(this).val($(this).val().toUpperCase());
			});
			
			$(tag1).bind("keyup", function() {
				$(this).val($(this).val().toUpperCase());
			});
		}
		**/
 		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});

</script>
</head>

<body>

	<!--content-->
	<div role="main" class="ui-content contentWrap">
		<div class="navstitle">예약하기</div>
		<div class="reserve">
			<div data-role="navbar" class="tabsnav mgT10">
				<ul>
					<li data-theme="a" data-ajax="false">약관동의</li>
					<li data-theme="a" data-ajax="false" class="ui-btn-active">정보입력</li>
					<li data-theme="a" data-ajax="false">예약완료</li>
				</ul>
			</div>
			<%
				int rvCnt = eventMstDTO.getRv_cnt();
				int evInwon = eventMstDTO.getEv_inwon();
				String lockUnit = eventMstDTO.getLock_unit();
				String procCd = eventMstDTO.getProc_cd();
			%>
			<!-- 예약 정보 입력 TAB -->
			<div class="tabContent info mgt5">
				<!--tab1 Start-->
				<div class="collapsDiv">
					<h1 class="collapsHeading">선택하신 상품정보</h1>
					<div class="collapsContent">
						<table>
							<colgroup>
								<col width="30%">
								<col width="70%">
							</colgroup>
							<tbody>
								<tr>
									<th>상품명</th>
									<td><%=eventMstDTO.getDisp_nm()%></td>

								</tr>
								<tr>
									<th>출발일</th>
									<td><%=eventMstDTO.getStart_day().substring(0, 4)%>년 <%=eventMstDTO.getStart_day().substring(4, 6)%>월
										<%=eventMstDTO.getStart_day().substring(6, 8)%>일 (<%=eventMstDTO.getStart_wday()%>)
										
<%
if(eventMstDTO.getStart_time() != null) {
%>
										<%=eventMstDTO.getStart_time().substring(0, 2)%>:<%=eventMstDTO.getStart_time().substring(2, 4)%>
										<span id="startPyun"></span>
										
	<%
		}
	%>
										</td>

								</tr>
								<tr>
									<th>도착일</th>
									<td><%=eventMstDTO.getEnd_day().substring(0, 4)%>년 <%=eventMstDTO.getEnd_day().substring(4, 6)%>월
										<%=eventMstDTO.getEnd_day().substring(6, 8)%>일 (<%=eventMstDTO.getEnd_wday()%>)							
<%
if(eventMstDTO.getStart_time() != null) {
%>
										<%=eventMstDTO.getEnd_time().substring(0, 2)%>:<%=eventMstDTO.getEnd_time().substring(2, 4)%>
										<span id="endPyun"></span>							
	<%
		}
	%>
										</td>
								</tr>
								<tr>
									<th>여행기간</th>
									<td><%=eventMstDTO.getEv_night_cnt()%>박 <%=eventMstDTO.getEv_day_cnt()%>일</td>
								</tr>
<%
if(eventMstDTO.getTrff_cd().toUpperCase().equals("AIR")) {
%>
								<tr>
									<th>이용항공</th>
									<td>
	<%
	// 항공사 별 이미지 표시 
	if (eventMstDTO.getCd_nm() != null) {
	%><img src='/resources/images/air/<%=eventMstDTO.getTrff_cd_short()%>.png' class='img'> <%=eventMstDTO.getCd_nm()%> 

	<%
		}
	%>
									</td>
								</tr>
<%
} else if(eventMstDTO.getTrff_cd().toUpperCase().startsWith("BUS")) {
%>
								<tr>
									<th>이용교통</th>
									<td><img src='/resources/images/ico/BUS.png' class='img'> <%=eventMstDTO.getStart_pyun()%> </td>
								</tr>
<%
} else if(eventMstDTO.getTrff_cd().toUpperCase().startsWith("SHP")) {
%>
								<tr>
									<th>이용교통</th>
									<td><img src='/resources/images/ico/SHP.png' class='img'> <%=eventMstDTO.getStart_pyun()%> </td>
								</tr>
<%
} else if(eventMstDTO.getTrff_cd().toUpperCase().startsWith("TRA")) {
%>
								<tr>
									<th>이용교통</th>
									<td><img src='/resources/images/ico/TRA.png' class='img'> <%=eventMstDTO.getStart_pyun()%> </td>
								</tr>
<%
} else if(eventMstDTO.getTrff_cd().toUpperCase().startsWith("CAR")) {
%>
								<tr>
									<th>이용교통</th>
									<td><img src='/resources/images/ico/CAR.png' class='img'> <%=eventMstDTO.getStart_pyun()%> </td>
								</tr>
<%
}
%>

								<!-- [JEH] 롯데면세점 프로모션일경우에만 노출 - 20190510 -->
								<c:if test="${goodsCd == 'PGI1011'  }">
									<tr>
										<th>상품특전</th>
										<td>
											■ Weekend 드림 항공권 결제시 롯데면세점 Weekend 드림 바우처 증정 
											<br/>○ Weekend 드림 바우처 內 구성품 
											<br/>① 롯데면세점 선불카드 2만원 
											<br/>② 롯데면세점 인터넷점 더 드림 $3 
											<br/>③ 롯데면세점 괌 공항점 15% 할인권 
											<br/>④ 해외여행자보험 가입 (항공권 발권시 자동으로 가입 됩니다.)
											<br/>⑤ 롯데면세점 Gold VIP 부여
										</td>
									</tr>
									<tr>
										<th>예약시 유의사항</th>
										<td>
											■ 롯데면세점 WEEKEND 드림 2차 - 괌 항공권 판매 공지 사항
											<br />○ 예약 
											<br />- 예약 후 2시간 이내에 하나카드(신용/체크)으로 결제를 완료하셔야 예약 확정이 됩니다.
											<br />- 예약 후 2시간 이내 결제가 되지 않을시 자동 취소 됩니다.
											<br />
											<br /><strong><span style="color:red;font-weight:bold;">○ 결제</span></strong>
											<br /><strong><span style="color:red;font-weight:bold;">- 하나카드(신용/체크)만 가능합니다.</span></strong>
											<br />
											<br /><strong><span style="color:red;font-weight:bold;">○ 취소 규정</span></strong>
											<br />- 본 항공권은 항공료 전액이 항공사로 선납되어 있습니다. 하단의 취소료 규정을 반드시 확인하여 불이익 없으시기를 바랍니다.
											<br />- 진단서를 첨부하더라도 선납된 항공료에 대한 수수료가 취소 시점에 따라 부과 됩니다.
											<br /><span style="color:red">- 무료 취소 가능 기간 : 결제 후 2일까지만 가능</span> (예:5/20 결제시 5/22까지만 무료 취소 가능)
											<br />- 무료 취소 가능 기간이 지나면 아래의 취소료 규정이 적용 됩니다.
											<br />- 취소 규정일은 영업일 기준으로 적용 됩니다. (월~금 09:00 ~ 18:00, 주말 및 공휴일 제외)
											<br /><span style="color:red">① 출발 30일 전 : 항공료의 50% 부과 됨</span>
											<br /><span style="color:red">② 출발29일 ~ 출발 당일 : 항공료의 100% 부과 됨	</span>
											<br />
											<br />○ 문의 : 02-6313-8257, kapark@lottejtb.com (상담 가능 시간 : 월~금 09:00 ~ 18:00, 주말 및 공휴일 제외)
										</td>
									</tr>
									<tr>
										<th>롯데면세점 혜택 수령<br/>안내 사항</th>
										<td>
											○ 항공권 결제 완료 후 WEEKEND 드림 프로모션 바우처을 수령할 수 있는 개인화 교환코드가 문자로 발송 됩니다.
											<br />   여권과 문자를 지참 후 지정된 롯데면세점의 증정데스크를 방문하시면 혜택 수령이 가능합니다.
											<br />   단, 여행자보험은 항공권 발권시 자동 가입됩니다.
											<br />   <span style="color:red">→ 개인화 교환코드 문자 발송일 : 매주 화요일 &amp; 금요일</span>
											<br />   <span style="color:red">→ 바우처 증정 가능 지점 : 롯데면세점 명동본점, 월드타워점, 코엑스점, 부산점 </span>
											<br />	<span style="color:red">(바우처는 5월 21일 부터 증정 가능합니다) </span>
											<br />○ Weekend 드림 바우처 증정을 위해 본인 여권과 개인화 코드를 지참하셔야 합니다.
											<br />   (아동도 프로모션 혜택 제공됩니다. 유아는 프로모션 혜택에서 제외 됩니다)
											<br />○ 수령하신 코드는 고유한 개인 코드임으로 1회 사용 이후에는 코드가 무효화 처리 됩니다.
											<br />○ 혜택 수령 후 항공권 취소를 원하실 경우 롯데면세점 증정데스크에 방문하여 수령하신 혜택 쿠폰을 반납하셔야 합니다.
											<br />   선불카드 또는 혜택 쿠폰을 사용하신 경우 혜택의 소비자가격을 면세점에 회수 후 항공권 취소가 가능한 점 꼭 유의 부탁 드립니다.
											<br />   <span style="color:red">(사은품 회수 전 취소 절대 불가)</span>
											<br />○교환하신 롯데면세점 선불카드의 유효기간은 1년이며 롯데면세점 오프라인 전점에서 일부 브랜드 및 담배를 제외하고 사용 가능합니다.(선불카드 이용 제외 브랜드 문의 : 롯데면세점 고객센터 1688-3000)
										</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
					<%
						String reservTag = "";
						if (rvCnt >= evInwon) {
							reservTag = "<span class='mgL5'>예약마감</span>";
						} else {
							if (evInwon == 0) {
								reservTag = "<span class='mgL5'>예약마감</span>";
							} else {
								if (procCd == "RE") {
									reservTag = "<span class='mgL5'>예약마감</span>";
								} else {
									if (lockUnit == "Y") {
										reservTag = "<span class='mgL5'>예약마감</span>";
									} else {
										if (procCd == "SE") {
											reservTag = "<span class='purple mgL5'>출발가능</span>";
										} else {
											reservTag = "";
										}
									}
								}
							}
						}
					%>
					<!-- 행사 상품 가격 정보 -->
					<div class="collapsDiv">
						<h1 class="collapsHeading btnAll">
							상품가격 <b><%=reservTag%></b><a href="#"
								class="btn btnbox allopenbtn1">모두펼침</a>
						</h1>
						<div class="collapsContent center pd0">
							<div data-role="collapsible" data-iconpos="right">
								<h1 class="ui-nodisc-icon ui-alt-icon">성인(만 12세 이상)</h1>
								<div>
									<p>총 상품가격<span><b class="mgL5 purple"> <%=CommUtil.decimalFormat(eventMstDTO.getTot_amt1())%></b>원</span></p>
									<%if(grade.equals("그룹직원") && empAdultPrice > 0) {%>
										<p><span class="f_red2 f_bold">임직원 할인가 <b style="font-size: 1.3em;"><%=CommUtil.decimalFormat(empAdultPrice) %></b>원</span></p>
									<%}%>
									<p>기본상품가격<span><b class="mgL5"> <%=CommUtil.decimalFormat(eventMstDTO.getAdult_price())%></b>원</span></p>
									<p>유류할증료<span><b class="mgL5"> <%=CommUtil.decimalFormat(eventMstDTO.getEtc_price1())%></b>원</span></p>
								</div>
							</div>
							<div data-role="collapsible" data-iconpos="right">
								<h1 class="ui-nodisc-icon ui-alt-icon">아동(만 12세 미만)</h1>
								<div>
									<p>총 상품가격<span><b class="mgL5 purple"> <%=CommUtil.decimalFormat(eventMstDTO.getTot_amt2())%></b>원</span></p>
									<%if(grade.equals("그룹직원") && empChildPrice > 0) {%>
										<p><span class="f_red2 f_bold">임직원 할인가 <b style="font-size: 1.3em;"><%=CommUtil.decimalFormat(empChildPrice) %></b>원</span></p>
									<%}%>
									<p>기본상품가격<span><b class="mgL5"> <%=CommUtil.decimalFormat(eventMstDTO.getChild_price())%></b>원</span></p>
									<p>유류할증료<span><b class="mgL5"> <%=CommUtil.decimalFormat(eventMstDTO.getEtc_price2())%>원</b></span></p>
								</div>
							</div>
							<div data-role="collapsible" data-iconpos="right">
								<h1 class="ui-nodisc-icon ui-alt-icon">유아(만 2세 미만)</h1>
								<div>
									<p>총 상품가격<span><b class="mgL5 purple"> <%=CommUtil.decimalFormat(eventMstDTO.getTot_amt3())%></b>원</span></p>
									<%if(grade.equals("그룹직원") && empBabyPrice > 0) {%>
										<p><span class="f_red2 f_bold">임직원 할인가 <b style="font-size: 1.3em;"><%=CommUtil.decimalFormat(empBabyPrice) %></b>원</span></p>
									<%}%>
									<p>기본상품가격<span><b class="mgL5"> <%=CommUtil.decimalFormat(eventMstDTO.getBaby_price())%></b>원</span></p>
									<p>유류할증료<span><b class="mgL5"> <%=CommUtil.decimalFormat(eventMstDTO.getEtc_price3())%></b>원</span></p>
								</div>
							</div>
							<div class="last">유류할증료는 유가와 환율에 따라 변동될 수 있습니다.</div>
						</div>
					</div>
					<!-- 행사 상품 가격 정보 -->
					<!-- 대표 여행자 정보 -->
					<div class="collapsDiv">
						<h1 class="collapsHeading">대표 예약자 정보</h1>
						<div class="collapsContent">
							<table>
								<colgroup>
									<col width="30%">
									<col width="70%">
								</colgroup>
								<tbody>
									<tr>
										<th>이름</th>
										<td><input type="text" id="dp_nm" name="dp_nm"
											placeholder="" style="width: 150px" value="" data-maxlength="10"></td>
									</tr>
									<tr>
										<th>휴대전화</th>
										<td class="hp"><div id="selectbox_handphone1"
												name="selectbox_handphone1"></div>
											<input type="number" id="dp_handphone2" name="dp_handphone2"
											value="" data-maxlength="4" pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' ><span class="hyphen"></span><input
											type="number" id="dp_handphone3" name="dp_handphone3"
											onkeydown='return f_Onlynum();' pattern='[0-9]*' value="" onkeyup="limitText(this, 4)" data-maxlength="4"></td>
									<tr>
										<th>이메일</th>
										<td><input type="text" id="dp_email1" name="dp_email1"
											placeholder="" style="width: 150px" value=""><span
											class="divide">@</span>
										<div id="selectbox_email2" name="selectbox_email2"></div></td>
									</tr>
									
									<!-- [JEH] 롯데면세점 프로모션일경우에는 제외 - 20190510 -->
									<c:if test="${goodsCd != 'PGI1011'  }">
										<tr>
											<th>요청사항</th>
											<td><textarea id="dp_comment" name="dp_comment"
													class="textarea"
													onkeyup="return f_Cal_byte('dp_comment', 1000);"
													onchange="return f_Cal_byte('dp_comment', 1000);"></textarea></td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</div>
					</div>
					<!-- 대표 여행자 정보 -->
					<!-- 여행자 인원 선택 -->
					<div class="collapsDiv">
						<h1 class="collapsHeading">
							여행자 정보 <span class="floatR finishsel1"> <select id="traveler_cnt" name="traveler_cnt" class="input" onchange="selectbox_traveler()">
					
					<%
					//[JEH] JOF2291180501001 추가 - 20180418 
					if(eventCd.equals("JAP5011170601JR1") || eventCd.equals("JOF2291180501001") || eventCd.equals("JOF2301180601NO1") || eventCd.equals("KIB7541190520NA1") || eventCd.equals("KIB7551190527NA1")) {
					%>
									<optgroup label="인원선택">
										<option value="1">1명</option>
									</optgroup>
										
					<%
					} else if(eventCd.equals("PSP1571180226TW1")) {
					%>				
									<optgroup label="인원선택">
										<option value="1">1명</option>
										<option value="2">2명</option>
										<option value="3">3명</option>
										<option value="4">4명</option>
									</optgroup>
											
					<%
					} else if(eventCd.equals("PGC2001170720KE1")) {
					%>
									<optgroup label="인원선택">
										<option value="1">2명</option>
										<option value="2">3명</option>
									</optgroup>				
					<%
					// 2017.04.21 전산실 IS 성민환대리 요청사항입니다.
					// eventCd : ATP1121170501001 
					// 일 경우에 인원 2명만 선택하도록 변경함
					// CHP10811705107C1 추가 성민환 대리
					// APP1511170527PR1 추가 성민환 대리 
					} else if(eventCd.equals("JTF2231180401KE1") || eventCd.equals("CHP1081170502OZ1") || eventCd.equals("CHP10811705107C1") || eventCd.equals("APP1511170527PR1") || eventCd.equals("JWP3131170829TW1")) { // 행사일 경우 2명만 선택이 되도록 하드코딩함.
					%>			
									<optgroup label="인원선택">
										<option value="1">1명</option>
										<option value="2">2명</option>
									</optgroup>
					<%
					} else {
					%>
									<optgroup label="인원선택">
										<option value="1">1명</option>
										<option value="2">2명</option>
										<option value="3">3명</option>
										<option value="4">4명</option>
										<option value="5">5명</option>
										<option value="6">6명</option>
										<option value="7">7명</option>
										<option value="8">8명</option>
										<option value="9">9명</option>
										<option value="10">10명</option>
									</optgroup>					
					<%
					}
					%>				
							</select>
							</span>
						</h1>
						<div class="collapsContent">
							<!-- [JEH] 롯데면세점 프로모션일경우에는 제외 - 20190510 -->
							<c:if test="${goodsCd != 'PGI1011'  }">
								<p>※ 11인 이상 예약인 경우 고객센터로 문의해 주시기 바랍니다.</p>
								<p>※ 영문이름이 여권에 기재된 것과 상이한 경우 항공기 탑승이 거부 될 수 있습니다.</p>
								<p>※ 외국인의 경우 고객센터를 통한 전화예약만 가능합니다. (고객센터 1577-6511)</p>
								<p>※ 귀하의 주민등록번호는 여행자보험 가입을 위해 필요합니다.</p>
							</c:if>
						</div>
					</div>
					<!-- 여행자 인원 선택 -->

					<!-- 여행자 리스트 -->
					<div class="collapsDiv" id="div_inwon_1" name="div_inwon_1" style=""></div>
					<div class="collapsDiv" id="div_inwon_2" name="div_inwon_2"
						style="display: none;"></div>
					<div class="collapsDiv" id="div_inwon_3" name="div_inwon_3"
						style="display: none;"></div>
					<div class="collapsDiv" id="div_inwon_4" name="div_inwon_4"
						style="display: none;"></div>
					<div class="collapsDiv" id="div_inwon_5" name="div_inwon_5"
						style="display: none;"></div>
					<div class="collapsDiv" id="div_inwon_6" name="div_inwon_6"
						style="display: none;"></div>
					<div class="collapsDiv" id="div_inwon_7" name="div_inwon_7"
						style="display: none;"></div>
					<div class="collapsDiv" id="div_inwon_8" name="div_inwon_8"
						style="display: none;"></div>
					<div class="collapsDiv" id="div_inwon_9" name="div_inwon_9"
						style="display: none;"></div>
					<div class="collapsDiv" id="div_inwon_10" name="div_inwon_10"
						style="display: none;"></div>
					<!-- 여행자 리스트 -->

					<!-- 예약자 정보 추가 버튼 시작 -->
					<!-- 
					<div class="collapsDiv">
						<div class="collapsContent">
							<div class="more reserveadd">
								<a href="javascript:addTraveler()">추가하기</a>
							</div>
						</div>
					</div>
					-->
					<!-- 예약자 정보 추가 버튼 시작 -->

					<!-- 결제 정보 -->
					<div class="collapsDiv">
						<h1 class="collapsHeading">결제정보</h1>
						<div class="collapsContent">
							<table>
								<colgroup>
									<col width="25%">
									<col width="25%">
									<col width="50%">
								</colgroup>
								<tbody>
									<tr>
										<th>성인</th>
										<td><span id="tot_adult_inwon" name="tot_adult_inwon">0</span>명</td>
										<td><span id="tot_adult_price" name="tot_adult_price">0</span>원</td>
									</tr>
									<tr>
										<th>아동</th>
										<td><span id="tot_child_inwon" name="tot_child_inwon">0</span>명</td>
										<td><span id="tot_child_price" name="tot_child_price">0</span>원</td>
									</tr>
									<tr>
										<th>유아</th>
										<td><span id="tot_baby_inwon" name="tot_baby_inwon">0</span>명</td>
										<td><span id="tot_baby_price" name="tot_baby_price">0</span>원</td>
									</tr>
									<tr class="sum">
										<th>총계</th>
										<td colspan="2"><span id="tot_acc_price"
											name="tot_acc_price">0</span>원</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!-- 결제 정보 -->

					<!-- 예약 관련 버튼 시작 -->
					<div data-role="navbar" class="tabsnav mgT10 resbtbtn">
						<ul>
							<li><a href="javascript:fn_goMain()" class="more" style="">취소</a></li>

							<li><a href="javascript:fn_saveReserve()"
								class="more btnBG2" style="">확인</a></li>
							<!--li><a href="#"
								class="more btnBG2" style="">확인</a></li -->	
						</ul>
					</div>
					<!-- 예약 관련 버튼 마침 -->

				</div>
			</div>
			<!-- 예약 정보 입력 TAB End-->
			<!--bottom-->
			<script src="/resources/common/bottom.js"></script>
			<!--bottom-->
		</div>
		<!--tabs End-->
	</div>
	<!--//contentWrap End-->
	<!--//content-->