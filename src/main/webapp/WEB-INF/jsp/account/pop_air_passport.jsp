<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.lottejtb.front.service.*" %>
<%@ page import="com.lottejtb.front.air.service.*" %>
<%@ page import="com.lottejtb.comm.util.*" %>

<%
	// 파일명 : pop_air_passport.jsp
	// 설명 : 항공 여권 정보 등록 팝업 

	String cust_cd = (String) request.getAttribute("cust_cd");
	String knm = (String) request.getAttribute("knm");
	String email = (String) request.getAttribute("email");
	String age = (String) request.getAttribute("age");
	String sex = (String) request.getAttribute("sex");
	FitReserveVO rsvFit = (FitReserveVO) request.getAttribute("rsvFit");
	List rsvAirPaxList = (List) request.getAttribute("rsvAirPaxList"); 

	Calendar limitTime = Calendar.getInstance();
	limitTime.add(Calendar.HOUR_OF_DAY, 24);
	SimpleDateFormat limitSdf = new SimpleDateFormat("yyyyMMdd-HHmm", Locale.KOREA);
	String limitDateTime = limitSdf.format(limitTime.getTime());

	String passportLimitDate = limitDateTime.substring(0, 8);

%>

<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="expires" content="-1">
	<meta name="robots" content="all">
	<meta name="keywords" content="">
	<script src="/resources/common/js/UserAgent.js"></script>
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<title>롯데홀리데이</title>
	<link rel="stylesheet" href="/resources/common/css/common.css">
	<link rel="stylesheet" href="/resources/common/css/common2.css">
	<link rel="shortcut icon" type="image/x-icon" href="/resources/common/css/lottejtb.ico">
	<script src="/resources/common/js/jquery-latest.min.js"></script>
	<script src="/resources/common/js/common.js"></script>
	<script src="/resources/common/js/common2.js"></script>
	<script src="/resources/common/js/utils.js"></script>
	<script src="/resources/common/js/swiper.js"></script>
	<script src="/resources/common/js/library/jquery.anchor.js"></script>
	<script src="/resources/common/js/common_decorator.js"></script>
	<script src="/resources/common/js/common_decorator2.js"></script>
	<script src="/resources/common/js/fit/common.js"></script>
	<script src="/resources/common/js/utils.js"></script>
	<script>
	<!--
	/* *************************************************************************** */
	// [AJAX] 데이타 통신 부분 	
	var rsvResult = "${rsvFit.getFitRsvNo()}";
	
	var paxCnt = 0;
	var rsvAirPaxList = null;

	// 탑승객 1 ~ 10
	var paxNo1;
	var paxTy1;
	var passportNo1;
	var expiredt1;
	var ntCd1;
	var ntNm1;
	var publishNtcd1;
	var ctCd1;
	var localContact1;
	var paxContact1;
	var addressTy1;
	var ctCdNm1;
	var stateCd1;
	var postCd1;
	var address1;
	var undecidedYn1;

	var paxNo2;
	var paxTy2;
	var passportNo2;
	var expiredt2;
	var ntCd2;
	var ntNm2;
	var publishNtcd2;
	var ctCd2;
	var localContact2;
	var paxContact2;
	var addressTy2;
	var ctCdNm2;
	var stateCd2;
	var postCd2;
	var address2;
	var undecidedYn2;

	var paxNo3;
	var paxTy3;
	var passportNo3;
	var expiredt3;
	var ntCd3;
	var ntNm3;
	var publishNtcd3;
	var ctCd3;
	var localContact3;
	var paxContact3;
	var addressTy3;
	var ctCdNm3;
	var stateCd3;
	var postCd3;
	var address3;
	var undecidedYn3;


	var paxNo4;
	var paxTy4;
	var passportNo4;
	var expiredt4;
	var ntCd4;
	var ntNm4;
	var publishNtcd4;
	var ctCd4;
	var localContact4;
	var paxContact4;
	var addressTy4;
	var ctCdNm4;
	var stateCd4;
	var postCd4;
	var address4;
	var undecidedYn4;

	var paxNo5;
	var paxTy5;
	var passportNo5;
	var expiredt5;
	var ntCd5;
	var ntNm5;
	var publishNtcd5;
	var ctCd5;
	var localContact5;
	var paxContact5;
	var addressTy5;
	var ctCdNm5;
	var stateCd5;
	var postCd5;
	var address5;
	var undecidedYn5;

	var paxNo6;
	var paxTy6;
	var passportNo6;
	var expiredt6;
	var ntCd6;
	var ntNm6;
	var publishNtcd6;
	var ctCd6;
	var localContact6;
	var paxContact6;
	var addressTy6;
	var ctCdNm6;
	var stateCd6;
	var postCd6;
	var address6;
	var undecidedYn6;

	var paxNo7;
	var paxTy7;
	var passportNo7;
	var expiredt7;
	var ntCd7;
	var ntNm7;
	var publishNtcd7;
	var ctCd7;
	var localContact7;
	var paxContact7;
	var addressTy7;
	var ctCdNm7;
	var stateCd7;
	var postCd7;
	var address7;
	var undecidedYn7;

	var paxNo8;
	var paxTy8;
	var passportNo8;
	var expiredt8;
	var ntCd8;
	var ntNm8;
	var publishNtcd8;
	var ctCd8;
	var localContact8;
	var paxContact8;
	var addressTy8;
	var ctCdNm8;
	var stateCd8;
	var postCd8;
	var address8;
	var undecidedYn8;

	var paxNo9;
	var paxTy9;
	var passportNo9;
	var expiredt9;
	var ntCd9;
	var ntNm9;
	var publishNtcd9;
	var ctCd9;
	var localContact9;
	var paxContact9;
	var addressTy9;
	var ctCdNm9;
	var stateCd9;
	var postCd9;
	var address9;
	var undecidedYn9;

	var paxNo10;
	var paxTy10;
	var passportNo10;
	var expiredt10;
	var ntCd10;
	var ntNm10;
	var publishNtcd10;
	var ctCd10;
	var localContact10;
	var paxContact10;
	var addressTy10;
	var ctCdNm10;
	var stateCd10;
	var postCd10;
	var address10;
	var undecidedYn10;

	// 항공 탑승객 리스트 조회 
	function fn_AirPaxList() {

		var formData = new FormData();
		formData.append('seqNo', <%=rsvFit.getAirRsvSeqno()%>);

		
		cfn_ajax({
			type: "POST",
			async: false,
			url: "/free/account/srchRsvAirPaxListAjax.do",
			data: formData,
			dataType: "json",
			cache: false,
			noloading:"no",
			timeOut: (5*60*1000),
			success: function(res) {
				rsvAirPaxList = res.rsvAirPaxList;
				paxCnt = rsvAirPaxList.length;

				var html = "";
				
				// 여권 정보 입력 리스트 
				if(rsvAirPaxList != null) {
					for(var i = 0; i < rsvAirPaxList.length; i++) {

						html = html + "		<table class='ft_table2 ft_tb_tl mt7' ft-att='passportGroup'>";
						html = html + "			<input type='hidden' id='paxNo"+rsvAirPaxList[i].paxNo+"' name='paxNo"+rsvAirPaxList[i].paxNo+"' data-role='none' value='"+rsvAirPaxList[i].paxNo+"'/>";
						html = html + "			<input type='hidden' id='paxTy"+rsvAirPaxList[i].paxNo+"' name='paxTy"+rsvAirPaxList[i].paxNo+"' data-role='none' value='"+rsvAirPaxList[i].paxTyGb+"'/>";
						html = html + "			<colgroup>";
						html = html + "				<col style='width: 28%'>";
						html = html + "				<col style='width: 72%'>";
						html = html + "			</colgroup>";
						html = html + "			<tbody>";
						html = html + "				<tr>";
						html = html + "					<th>탑승객</th>";
						html = html + "					<td>" + rsvAirPaxList[i].enSurNm + " / " + rsvAirPaxList[i].enFirstNm + "</td>";
						html = html + "				</tr>";
						html = html + "				<tr>";
						html = html + "					<th>법정<br>생년월일</th>";
						html = html + "					<td><input type='text' id='ymd"+rsvAirPaxList[i].paxNo+"' name='ymd"+rsvAirPaxList[i].paxNo+"' data-role='none' placeholder='예) 19800701' value='"+rsvAirPaxList[i].ymd+"' readonly/></td>";
						html = html + "				</tr>";
						html = html + "				<tr>";
						html = html + "					<th>여권번호<em class='f_red'>*</em></th>";
						html = html + "					<td><input type='text' id='passportNo"+rsvAirPaxList[i].paxNo+"' name='passportNo"+rsvAirPaxList[i].paxNo+"' data-role='none' /></td>";
						html = html + "				</tr>";
						html = html + "				<tr>";
						html = html + "					<th>여권만료일<em class='f_red'>*</em></th>";
						html = html + "					<td><input type='text' id='expiredt"+rsvAirPaxList[i].paxNo+"' data-role='none' placeholder='예) 19800701' /></td>";
						html = html + "				</tr>";
						html = html + "				<tr>";
						html = html + "					<th>성별<em class='f_red'>*</em></th>";
						html = html + "					<td>";
						html = html + "    					<span class='radioboxs radioboxs2'><input type='radio' name='genderGb"+rsvAirPaxList[i].paxNo+"' id='genderGb"+rsvAirPaxList[i].paxNo+"_1' data-role='none' value='M'></span>";
						html = html + "    					<label for='genderGb"+rsvAirPaxList[i].paxNo+"_1' class='wauto'>남성</label>";
						html = html + "    					<span class='radioboxs radioboxs2 ml10'><input type='radio' name='genderGb"+rsvAirPaxList[i].paxNo+"' id='genderGb"+rsvAirPaxList[i].paxNo+"_1' data-role='none' value='F'></span>";
						html = html + "    					<label for='genderGb"+rsvAirPaxList[i].paxNo+"_2' class='wauto'>여성</label>";						
						html = html + "					</td>";
						html = html + "				</tr>";												
						html = html + "				<tr>";
						html = html + "					<th>국적</th>";
						html = html + "					<td><select id='ntCd"+rsvAirPaxList[i].paxNo+"' name='ntCd"+rsvAirPaxList[i].paxNo+"' class='fr_select' data-role='none'>";
						html = html + "							<option value=''>선택하세요</option>";
						html = html + "							<option value='KR'>대한민국</option>";
						html = html + "					</select></td>";
						html = html + "				</tr>";
						html = html + "				<tr>";
						html = html + "					<th>발행국</th>";
						html = html + "					<td><select id='publishNtCd"+rsvAirPaxList[i].paxNo+"' name='publishNtCd"+rsvAirPaxList[i].paxNo+"' class='fr_select' data-role='none'>";
						html = html + "							<option value=''>선택하세요</option>";
						html = html + "							<option value='KR'>대한민국</option>";
						html = html + "					</select></td>";
						html = html + "				</tr>";
						html = html + "			</tbody>";
						html = html + "		</table>";


					}
				}

				
				$("#span_airRsvPaxList").html(html);


			},
			error:function(err){
				//console.log(err);
			},
			complete:function(){
				
			}
		});
	}

	// 여권 정보 가져오기 
	function fn_getPassportParam() {
		var passportGroup = $('table[ft-att="passportGroup"]');

		if(paxCnt > 0) {
			paxNo1 = passportGroup.find('#paxNo1').val();
			paxTy1 = passportGroup.find('#paxTy1').val();
			passportNo1 = passportGroup.find('#passportNo1').val();
			expiredt1 = passportGroup.find("#expiredt1").val();
			ntCd1 = passportGroup.find("#ntCd1 option:selected").val();
			publishNtcd1 = passportGroup.find("#publishNtcd1 option:selected").val();
		}

		if(paxCnt > 1) {
			paxNo2 = passportGroup.find('#paxNo2').val();
			paxTy2 = passportGroup.find('#paxTy2').val();
			passportNo2 = passportGroup.find('#passportNo2').val();
			expiredt2 = passportGroup.find("#expiredt2").val();
			ntCd2 = passportGroup.find("#ntCd2 option:selected").val();
			publishNtcd2 = passportGroup.find("#publishNtcd2 option:selected").val();
			
		}

		if(paxCnt > 2) {
			paxNo3 = passportGroup.find('#paxNo3').val();
			paxTy3 = passportGroup.find('#paxTy3').val();
			passportNo3 = passportGroup.find('#passportNo3').val();
			expiredt3 = passportGroup.find("#expiredt3").val();
			ntCd3 = passportGroup.find("#ntCd3 option:selected").val();
			publishNtcd3 = passportGroup.find("#publishNtcd3 option:selected").val();
			
		}

		if(paxCnt > 3) {
			paxNo4 = passportGroup.find('#paxNo4').val();
			paxTy4 = passportGroup.find('#paxTy4').val();
			passportNo4 = passportGroup.find('#passportNo4').val();
			expiredt4 = passportGroup.find("#expiredt4").val();
			ntCd4 = passportGroup.find("#ntCd4 option:selected").val();
			publishNtcd4 = passportGroup.find("#publishNtcd4 option:selected").val();
			
		}

		if(paxCnt > 4) {
			paxNo5 = passportGroup.find('#paxNo5').val();
			paxTy5 = passportGroup.find('#paxTy5').val();
			passportNo5 = passportGroup.find('#passportNo5').val();
			expiredt5 = passportGroup.find("#expiredt5").val();
			ntCd5 = passportGroup.find("#ntCd5 option:selected").val();
			publishNtcd5 = passportGroup.find("#publishNtcd5 option:selected").val();
			
		}		

		if(paxCnt > 5) {
			paxNo6 = passportGroup.find('#paxNo6').val();
			paxTy6 = passportGroup.find('#paxTy6').val();
			passportNo6 = passportGroup.find('#passportNo6').val();
			expiredt6 = passportGroup.find("#expiredt6").val();
			ntCd6 = passportGroup.find("#ntCd6 option:selected").val();
			publishNtcd6 = passportGroup.find("#publishNtcd6 option:selected").val();
			
		}	

		if(paxCnt > 6) {
			paxNo7 = passportGroup.find('#paxNo7').val();
			paxTy7 = passportGroup.find('#paxTy7').val();
			passportNo7 = passportGroup.find('#passportNo7').val();
			expiredt7 = passportGroup.find("#expiredt7").val();
			ntCd7 = passportGroup.find("#ntCd7 option:selected").val();
			publishNtcd7 = passportGroup.find("#publishNtcd7 option:selected").val();
			
		}	

		if(paxCnt > 7) {
			paxNo8 = passportGroup.find('#paxNo8').val();
			paxTy8 = passportGroup.find('#paxTy8').val();
			passportNo8 = passportGroup.find('#passportNo8').val();
			expiredt8 = passportGroup.find("#expiredt8").val();
			ntCd8 = passportGroup.find("#ntCd8 option:selected").val();
			publishNtcd8 = passportGroup.find("#publishNtcd8 option:selected").val();
			
		}		

		if(paxCnt > 8) {
			paxNo9 = passportGroup.find('#paxNo9').val();
			paxTy9 = passportGroup.find('#paxTy9').val();
			passportNo9 = passportGroup.find('#passportNo9').val();
			expiredt9 = passportGroup.find("#expiredt9").val();
			ntCd9 = passportGroup.find("#ntCd9 option:selected").val();
			publishNtcd9 = passportGroup.find("#publishNtcd9 option:selected").val();
		}	

		if(paxCnt > 9) {
			paxNo10 = passportGroup.find('#paxNo10').val();
			paxTy10 = passportGroup.find('#paxTy10').val();
			passportNo10 = passportGroup.find('#passportNo10').val();
			expiredt10 = passportGroup.find("#expiredt10").val();
			ntCd10 = passportGroup.find("#ntCd10 option:selected").val();
			publishNtcd10 = passportGroup.find("#publishNtcd10 option:selected").val();
			
		}									
	}

	// 여권정보 등록 체크 
	function fn_checkPassportParam() {
		var passportGroup = $('table[ft-att="passportGroup"]');
		var passportLimitDT = '<%=passportLimitDate%>';

		if(paxCnt > 0) {			
			if(expiredt1 == '' || expiredt1 == null) {
				alert("여권 만료일을 입력해 주세요.");
				passportGroup.find("#expiredt1").focus();
				return false;
			}
			
			if(expiredt1.length != 8) {
				alert("여권 만료일을 다시 입력해 주세요.");
				passportGroup.find("#expiredt1").focus();
				return false;
			}

			if(parseInt(expiredt1) < parseInt(passportLimitDT)) {
				alert("여권 만료일은 오늘 이후로 입력하실 수 있습니다.");
				passportGroup.find("#expiredt1").focus();
				return false;
			}

			if(passportNo1 == '' || passportNo1 == null) {
				alert("여권 번호를 입력해 주세요.");
				passportGroup.find("#passportNo1").focus();
				return false;
			}
		}

		if(paxCnt > 1) {			
			if(expiredt2 == '' || expiredt2 == null) {
				alert("여권 만료일을 입력해 주세요.");
				passportGroup.find("#expiredt2").focus();
				return false;
			}

			if(expiredt2.length != 8) {
				alert("여권 만료일을 다시 입력해 주세요.");
				passportGroup.find("#expiredt2").focus();
				return false;
			}

			if(parseInt(expiredt2) < parseInt(passportLimitDT)) {
				alert("여권 만료일은 오늘 이후로 입력하실 수 있습니다.");
				passportGroup.find("#expiredt2").focus();
				return false;
			}

			if(passportNo2 == '' || passportNo2 == null) {
				alert("여권 번호를 입력해 주세요.");
				passportGroup.find("#passportNo2").focus();
				return false;
			}
		}

		if(paxCnt > 2) {
			if(expiredt3 == '' || expiredt3 == null) {
				alert("여권 만료일을 입력해 주세요.");
				passportGroup.find("#expiredt3").focus();
				return false;
			}

			if(expiredt3.length != 8) {
				alert("여권 만료일을 다시 입력해 주세요.");
				passportGroup.find("#expiredt3").focus();
				return false;
			}

			if(parseInt(expiredt3) < parseInt(passportLimitDT)) {
				alert("여권 만료일은 오늘 이후로 입력하실 수 있습니다.");
				passportGroup.find("#expiredt3").focus();
				return false;
			}

			if(passportNo3 == '' || passportNo3 == null) {
				alert("여권 번호를 입력해 주세요.");
				passportGroup.find("#passportNo3").focus();
				return false;
			}
		}

		if(paxCnt > 3) {	
			if(expiredt4 == '' || expiredt4 == null) {
				alert("여권 만료일을 입력해 주세요.");
				passportGroup.find("#expiredt4").focus();
				return false;
			}

			if(expiredt4.length != 8) {
				alert("여권 만료일을 다시 입력해 주세요.");
				passportGroup.find("#expiredt4").focus();
				return false;
			}

			if(parseInt(expiredt4) < parseInt(passportLimitDT)) {
				alert("여권 만료일은 오늘 이후로 입력하실 수 있습니다.");
				passportGroup.find("#expiredt4").focus();
				return false;
			}

			if(passportNo4 == '' || passportNo4 == null) {
				alert("여권 번호를 입력해 주세요.");
				passportGroup.find("#passportNo4").focus();
				return false;
			}
		}

		if(paxCnt > 4) {	
			if(expiredt5 == '' || expiredt5 == null) {
				alert("여권 만료일을 입력해 주세요.");
				passportGroup.find("#expiredt5").focus();
				return false;
			}
			if(expiredt5.length != 8) {
				alert("여권 만료일을 다시 입력해 주세요.");
				passportGroup.find("#expiredt5").focus();
				return false;
			}	

			if(parseInt(expiredt5) < parseInt(passportLimitDT)) {
				alert("여권 만료일은 오늘 이후로 입력하실 수 있습니다.");
				passportGroup.find("#expiredt5").focus();
				return false;
			}

			if(passportNo5 == '' || passportNo5 == null) {
				alert("여권 번호를 입력해 주세요.");
				passportGroup.find("#passportNo5").focus();
				return false;
			}
		}

		if(paxCnt > 5) {
			if(expiredt6 == '' || expiredt6 == null) {
				alert("여권 만료일을 입력해 주세요.");
				passportGroup.find("#expiredt6").focus();
				return false;
			}	

			if(expiredt6.length != 8) {
				alert("여권 만료일을 다시 입력해 주세요.");
				passportGroup.find("#expiredt6").focus();
				return false;
			}	

			if(parseInt(expiredt6) < parseInt(passportLimitDT)) {
				alert("여권 만료일은 오늘 이후로 입력하실 수 있습니다.");
				passportGroup.find("#expiredt6").focus();
				return false;
			}

			if(passportNo6 == '' || passportNo6 == null) {
				alert("여권 번호를 입력해 주세요.");
				passportGroup.find("#passportNo6").focus();
				return false;
			}
		}

		if(paxCnt > 6) {
			if(expiredt7 == '' || expiredt7 == null) {
				alert("여권 만료일을 입력해 주세요.");
				passportGroup.find("#expiredt7").focus();
				return false;
			}

			if(expiredt7.length != 8) {
				alert("여권 만료일을 다시 입력해 주세요.");
				passportGroup.find("#expiredt7").focus();
				return false;
			}

			if(parseInt(expiredt7) < parseInt(passportLimitDT)) {
				alert("여권 만료일은 오늘 이후로 입력하실 수 있습니다.");
				passportGroup.find("#expiredt7").focus();
				return false;
			}

			if(passportNo7 == '' || passportNo7 == null) {
				alert("여권 번호를 입력해 주세요.");
				passportGroup.find("#passportNo7").focus();
				return false;
			}
		}

		if(paxCnt > 7) {	
			if(expiredt8 == '' || expiredt8 == null) {
				alert("여권 만료일을 입력해 주세요.");
				passportGroup.find("#expiredt8").focus();
				return false;
			}	

			if(expiredt8.length != 8) {
				alert("여권 만료일을 다시 입력해 주세요.");
				passportGroup.find("#expiredt8").focus();
				return false;
			}

			if(parseInt(expiredt8) < parseInt(passportLimitDT)) {
				alert("여권 만료일은 오늘 이후로 입력하실 수 있습니다.");
				passportGroup.find("#expiredt8").focus();
				return false;
			}

			if(passportNo8 == '' || passportNo8 == null) {
				alert("여권 번호를 입력해 주세요.");
				passportGroup.find("#passportNo8").focus();
				return false;
			}
		}

		if(paxCnt > 8) {
			if(expiredt9 == '' || expiredt9 == null) {
				alert("여권 만료일을 입력해 주세요.");
				passportGroup.find("#expiredt9").focus();
				return false;
			}	

			if(expiredt9.length != 8) {
				alert("여권 만료일을 다시 입력해 주세요.");
				passportGroup.find("#expiredt9").focus();
				return false;
			}

			if(parseInt(expiredt9) < parseInt(passportLimitDT)) {
				alert("여권 만료일은 오늘 이후로 입력하실 수 있습니다.");
				passportGroup.find("#expiredt9").focus();
				return false;
			}

			if(passportNo9 == '' || passportNo9 == null) {
				alert("여권 번호를 입력해 주세요.");
				passportGroup.find("#passportNo9").focus();
				return false;
			}
		}

		if(paxCnt > 9) {	
			if(expiredt10 == '' || expiredt10 == null) {
				alert("여권 만료일을 입력해 주세요.");
				passportGroup.find("#expiredt10").focus();
				return false;
			}

			if(expiredt10.length != 8) {
				alert("여권 만료일을 다시 입력해 주세요.");
				passportGroup.find("#expiredt10").focus();
				return false;
			}

			if(parseInt(expiredt10) < parseInt(passportLimitDT)) {
				alert("여권 만료일은 오늘 이후로 입력하실 수 있습니다.");
				passportGroup.find("#expiredt10").focus();
				return false;
			}

			if(passportNo10 == '' || passportNo10 == null) {
				alert("여권 번호를 입력해 주세요.");
				passportGroup.find("#passportNo10").focus();
				return false;
			}
		}
		
		return true;
	}


	// 여권 정보 저장  
	function fn_savePassport() {
		fn_getPassportParam();
		if(fn_checkPassportParam()) {
			var airPassportData = {
				// bodyDTO
				
			};
			airPassportData.bodyDTO = {
				"rsvSeqno"		: '<%=rsvFit.getAirRsvSeqno()%>'
			};

			airPassportData.bodyDTO.paxGroup = [];

			console.log("paxCnt : " + paxCnt);

			if(paxCnt > 0) {

				airPassportData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo1,
					"paxTy"				: paxTy1,
					"passportNo"		: passportNo1,
					"expiredt"			: expiredt1,
					"ntCd"				: ntCd1,
					"publishNtcd"		: publishNtcd1
				});
			}

			if(paxCnt > 1) {
				airPassportData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo2,
					"paxTy"				: paxTy2,
					"passportNo"		: passportNo2,
					"expiredt"			: expiredt2,
					"ntCd"				: ntCd2,
					"publishNtcd"		: publishNtcd2

				});
			}	

			if(paxCnt > 2) {
				airPassportData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo3,
					"paxTy"				: paxTy3,
					"passportNo"		: passportNo3,
					"expiredt"			: expiredt3,
					"ntCd"				: ntCd3,
					"publishNtcd"		: publishNtcd3

				});
			}	

			if(paxCnt > 3) {
				airPassportData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo4,
					"paxTy"				: paxTy4,
					"passportNo"		: passportNo4,
					"expiredt"			: expiredt4,
					"ntCd"				: ntCd4,
					"publishNtcd"		: publishNtcd4

				});
			}		

			if(paxCnt > 4) {
				airPassportData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo5,
					"paxTy"				: paxTy5,
					"passportNo"		: passportNo5,
					"expiredt"			: expiredt5,
					"ntCd"				: ntCd5,
					"publishNtcd"		: publishNtcd5

				});
			}	

			if(paxCnt > 5) {
				airPassportData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo6,
					"paxTy"				: paxTy6,
					"passportNo"		: passportNo6,
					"expiredt"			: expiredt6,
					"ntCd"				: ntCd6,
					"publishNtcd"		: publishNtcd6

				});
			}	

			if(paxCnt > 6) {
				airPassportData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo7,
					"paxTy"				: paxTy7,
					"passportNo"		: passportNo7,
					"expiredt"			: expiredt7,
					"ntCd"				: ntCd7,
					"publishNtcd"		: publishNtcd7

				});
			}	

			if(paxCnt > 7) {
				airPassportData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo8,
					"paxTy"				: paxTy8,
					"passportNo"		: passportNo8,
					"expiredt"			: expiredt8,
					"ntCd"				: ntCd8,
					"publishNtcd"		: publishNtcd8

				});
			}	

			if(paxCnt > 8) {
				airPassportData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo9,
					"paxTy"				: paxTy9,
					"passportNo"		: passportNo9,
					"expiredt"			: expiredt9,
					"ntCd"				: ntCd9,
					"publishNtcd"		: publishNtcd9
				});
			}		

			if(paxCnt > 9) {
				airPassportData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo10,
					"paxTy"				: paxTy10,
					"passportNo"		: passportNo10,
					"expiredt"			: expiredt10,
					"ntCd"				: ntCd10,
					"publishNtcd"		: publishNtcd10

				});
			}	
			console.log("paxCnt : " + paxCnt);
			console.log(airPassportData);

        	gfn_callAjax3('/fit/rsv/savePassportAjax.do', airPassportData.bodyDTO, 'successPassport');				
		}																																							
	}

	// 여권 정보 저장 후 처리 
    function successPassport(_data) {

        var data = _data.result.data;
        
        if (data.length > 0) {
        }
        if(_data.result.code == 1) {
 	       alert("여권 정보가 등록되었습니다.");

        } else {
            alert("여권 정보가 등록되지 않았습니다.");
        }

		closePopup();
		fn_close();
    }
	
	/**
     * 숫자만 입력하게 하는 함수
     * ex) : onkeypress="f_Onlynum()" style="ime-mode:disabled"
     */
    function f_Onlynum() {
        e = window.event;
        // 숫자열 0 ~ 9 : 48 ~ 57, 키패드 0 ~ 9 : 96 ~ 105 ,8 : backspace, 46 : delete --> 
        // 키코드값을 구분합니다. 저것들이 숫자랍니다.
        if(e.keyCode >= 48 && e.keyCode <= 57 || e.keyCode >= 96 && e.keyCode <= 105 || e.keyCode == 8 || e.keyCode == 9 || e.keyCode == 46)
        {
            return; //-->입력시킨다.
        } else { //숫자가 아니면 넣을수 없다.
            e.returnValue=false;
        }
    }

	function limitText(field, maxChar){
		var ref = $(field),
			val = ref.val();
		if ( val.length >= maxChar ){
			ref.val(function() {
				// console.log(val.substr(0, maxChar))
				return val.substr(0, maxChar);       
			});
		}
	}

	function fn_close() {
		history.back(-1);
	}
	
	$(document).ready(function() {
		fn_AirPaxList();

	});

	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}
	//-->
	</script>
</head>

<body>
<div class="lypopview">
    <div class="layerPop10">
		<!-- 내용시작 -->
		<div class="popCon pb70">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">여권정보 등록</strong>
					<button type="button" class="layerClose10" onclick="fn_close();"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></button>
				</div>
			</div>
			<div class="cntain cntain3 pop_airpay">
				<!-- 여권정보등록 -->
				<div id="passport_div">
					<%@ include file="/WEB-INF/jsp/account/inc_passport_info.jsp" %>
				</div>
				
			</div>				
		</div>
		<!-- 여권 정보 등록 -->
		<div class="popFoot posfd">
			<div class="layerBtns"><button type="button" class="layerOpener layerClose2" data-role="none" onClick="fn_savePassport()" data-ctn="full" data-ok="yes">여권 정보 등록</button></div>
		</div>		
    </div>
</div>
</body>
</html>