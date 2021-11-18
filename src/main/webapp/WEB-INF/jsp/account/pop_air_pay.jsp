<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.lottejtb.front.service.*" %>
<%@ page import="com.lottejtb.front.air.service.*" %>
<%@ page import="com.lottejtb.comm.util.*" %>

<%
	// 파일명 : pop_air_pay.jsp
	// 설명 : 항공권 결제 요청 
	String cust_cd = (String) request.getAttribute("cust_cd");
	String knm = (String) request.getAttribute("knm");
	String email = (String) request.getAttribute("email");
	String age = (String) request.getAttribute("age");
	String sex = (String) request.getAttribute("sex");
	FitReserveVO rsvFit = (FitReserveVO) request.getAttribute("rsvFit");
	RsvAirVO rsvAir = (RsvAirVO) request.getAttribute("rsvAir");
	List rsvAirPaxList = (List) request.getAttribute("rsvAirPaxList"); 

	//String strTotalAmt = CommUtil.decimalFormat(rsvAir.getTotSaleAmt() + rsvAir.getTotTasfAmt());
	//int totalAmt = rsvAir.getTotSaleAmt() + rsvAir.getTotTasfAmt();
	String strTotalAmt = CommUtil.decimalFormat(rsvAir.getSaleAmtAir());
	int totalAmt = rsvAir.getSaleAmtAir();
	Date serverDate = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy", Locale.KOREA);
	String serverYear = sdf.format(serverDate);
	int nServerYear = Integer.parseInt(serverYear);
	
	Calendar limitTime = Calendar.getInstance();
	limitTime.add(Calendar.HOUR_OF_DAY, 24);
	SimpleDateFormat limitSdf = new SimpleDateFormat("yyyyMMdd-HHmm", Locale.KOREA);
	String limitDateTime = limitSdf.format(limitTime.getTime());

	String passportLimitDate = limitDateTime.substring(0, 8);

	int nAdtCnt = 0;
	int nChdCnt = 0;
	int nInfCnt = 0;	

	String strTasfAmt = "";
	int tasfAmt = 0;

	if(rsvAirPaxList != null) {
		for(int idx = 0; idx < rsvAirPaxList.size(); idx++) {
			RsvAirPaxVO rsvAirPaxVO = (RsvAirPaxVO) rsvAirPaxList.get(idx);

			
			if(rsvAirPaxVO.getPaxTyGb().equals("ADT")) {
				nAdtCnt ++;
			} else if(rsvAirPaxVO.getPaxTyGb().equals("CHD")) {
				nChdCnt ++;
			} else {
				nInfCnt ++;		
			}

			strTasfAmt =  CommUtil.decimalFormat(rsvAirPaxVO.getTasfAmt());
			tasfAmt = rsvAirPaxVO.getTasfAmt();

		}
	}
%>

<html lang="ko">
<head>	
	<title>롯데홀리데이</title>
	<meta name="viewport" content="width=device-width, initial-scale=1,  user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
	<meta name="format-detection" content="telephone=no" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
	<script src="/resources/common/js/UserAgent.js"></script>
	<!-- meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" -->
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
	<script src="/resources/common/js/fit/reserve.js"></script>
	<script src="/resources/common/js/utils.js"></script>
	<script type="text/javascript" src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
	<script type="text/javascript">
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
	
	var limitTime = '<%=limitDateTime%>';
	
	var rsvSeqNo = '${rsvSeqNo}';

	// 항공 탑승객 리스트 조회 
	function fn_AirPaxList() {

		var formData = new FormData();
		formData.append('seqNo', '${rsvAir.getAirRsvSeqno()}');

		
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
						html = html + "					<td><input type='number' id='ymd"+rsvAirPaxList[i].paxNo+"' name='ymd"+rsvAirPaxList[i].paxNo+"' data-role='none' placeholder='예) 19800701' value='"+rsvAirPaxList[i].ymd+"' readonly/></td>";
						html = html + "				</tr>";
						html = html + "				<tr>";
						html = html + "					<th>여권번호<em class='f_red'>*</em></th>";
						html = html + "					<td><input type='text' id='passportNo"+rsvAirPaxList[i].paxNo+"' name='passportNo"+rsvAirPaxList[i].paxNo+"' data-role='none' /></td>";
						html = html + "				</tr>";
						html = html + "				<tr>";
						html = html + "					<th>여권만료일<em class='f_red'>*</em></th>";
						html = html + "					<td><input type='number' id='expiredt"+rsvAirPaxList[i].paxNo+"' onkeydown='return f_Onlynum();' data-role='none' placeholder='예) 19800701' /></td>";
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

				html = "";
				// 목적지/거주지 정보 등록
				html = html + "<div ft-att='addressGroup'>";
				if(rsvAirPaxList != null) {
					for(var i = 0; i < rsvAirPaxList.length; i++) {
						html = html + "	<table class='ft_table2 ft_thd_tl'>";
						html = html + "		<input type='hidden' id='paxNo"+rsvAirPaxList[i].paxNo+"' name='paxNo"+rsvAirPaxList[i].paxNo+"' data-role='none' value='"+rsvAirPaxList[i].paxNo+"'/>";
						html = html + "		<input type='hidden' id='paxTy"+rsvAirPaxList[i].paxNo+"' name='paxTy"+rsvAirPaxList[i].paxNo+"' data-role='none' value='"+rsvAirPaxList[i].paxTyGb+"'/>";						
						html = html + "		<colgroup>";
						html = html + "			<col style='width: 28%'>";
						html = html + "			<col style='width: 72%'>";
						html = html + "		</colgroup>";
						html = html + "		<tbody>";
						html = html + "			<tr>";
						html = html + "				<th>탑승객</th>";
						html = html + "				<td>" + rsvAirPaxList[i].enSurNm + " / " + rsvAirPaxList[i].enFirstNm + "</td>";
						html = html + "			</tr>";
						html = html + "			<tr>";
						html = html + "				<th>구분</th>";
						html = html + "				<td><select id='addressTy"+rsvAirPaxList[i].paxNo+"' name='addressTy"+rsvAirPaxList[i].paxNo+"' class='fr_select' data-role='none'>";
						html = html + "						<option value=''>선택하세요</option>";
						html = html + "						<option value='D'>목적지</option>";
						html = html + "						<option value='R'>거주지</option>";
						html = html + "				</select></td>";
						html = html + "			</tr>";

						html = html + "			<tr>";
						html = html + "				<th>체류나라</th>";
						html = html + "				<td><button class='layerOpener ft_city_btn' type='button' data-url='/free/account/pop_hotel_city_select.do?availTy=HT&paxNo="+rsvAirPaxList[i].paxNo+"'  data-ctn='full' data-role='none'>";
						html = html + "						<span id='ntNm"+rsvAirPaxList[i].paxNo+"' name='ntNm"+rsvAirPaxList[i].paxNo+"'>도시선택</span>";
						html = html + "					</button></td>";
						html = html + "				<input type='hidden' id='ntCd"+rsvAirPaxList[i].paxNo+"' name='ntCd"+rsvAirPaxList[i].paxNo+"' value='' />";
						html = html + "			</tr>";
						
						html = html + "			<tr>";
						html = html + "				<th>체류도시</th>";
						html = html + "				<td><button class='layerOpener ft_city_btn' type='button' data-url='/free/account/pop_hotel_city_select.do?availTy=HT&paxNo="+rsvAirPaxList[i].paxNo+"'  data-ctn='full' data-role='none'>";
						html = html + "						<span id='ctCdNm"+rsvAirPaxList[i].paxNo+"' name='ctCdNm"+rsvAirPaxList[i].paxNo+"'>도시선택</span>";
						html = html + "					</button></td>";
						html = html + "				<input type='hidden' id='ctCd"+rsvAirPaxList[i].paxNo+"' name='ctCd"+rsvAirPaxList[i].paxNo+"' value='' />";
						html = html + "				<input type='hidden' id='stateCd"+rsvAirPaxList[i].paxNo+"' name='stateCd"+rsvAirPaxList[i].paxNo+"' value='' />";
						html = html + "			</tr>";

						html = html + "			<tr>";
						html = html + "				<th>우편번호<em class='f_red'>*</em></th>";
						html = html + "				<td><input type='text' data-role='none' id='postCd"+rsvAirPaxList[i].paxNo+"' name='postCd"+rsvAirPaxList[i].paxNo+"' value=''/></td>";
						html = html + "			</tr>";
						html = html + "			<tr>";
						html = html + "				<th>세부주소<em class='f_red'>*</em></th>";
						html = html + "				<td><input type='text' data-role='none' id='address"+rsvAirPaxList[i].paxNo+"' name='address"+rsvAirPaxList[i].paxNo+"' value='' style='ime-mode:inactive;' pattern='[a-zA-Z]*' placeholder='*영문으로 기재해 주세요.'/></td>";
						html = html + "			</tr>";
						html = html + "			<tr>";
						html = html + "				<th>미확정</th>";
						html = html + "				<td><p class='chkbox'>";
						html = html + "						<span><label for='chk_ck3'><input id='undecideYn"+rsvAirPaxList[i].paxNo+"' name='undecideYn"+rsvAirPaxList[i].paxNo+"' type='checkbox' data-role='none' value='Y'></label></span>";
						html = html + "					</p></td>";
						html = html + "			</tr>";
						html = html + "		</tbody>";
						html = html + "	</table>";				
					}
				}	
				html = html + "</div>";
				$("#div_airPaxArrList").html(html);		
				
				// 현지 연락처 정보 전송 
				html = "";
				if(rsvAirPaxList != null) {
					for(var i = 0; i < rsvAirPaxList.length; i++) {								
						html = html + "	<table class='ft_table2 ft_thd_tl' ft-att='contactGroup'>";
						html = html + "		<colgroup>";
						html = html + "			<col style='width: 28%'>";
						html = html + "			<col style='width: 72%'>";
						html = html + "		</colgroup>";
						html = html + "		<tbody>";
						html = html + "			<tr>";
						html = html + "				<th>탑승객<br>(영문명)</th>";
						html = html + "				<td>" + rsvAirPaxList[i].enSurNm + " / " + rsvAirPaxList[i].enFirstNm + "</td>";
						html = html + "			</tr>";						
						html = html + "			<tr>";
						html = html + "				<th>여행도시<em class='f_red'>*</em></th>";
						html = html + "				<td><input type='text' id='ctCdNm"+rsvAirPaxList[i].paxNo+"' name='ctCdNm"+rsvAirPaxList[i].paxNo+"' data-role='none' placeholder='영문으로 기재해 주세요.' /></td>";
						html = html + "			</tr>";
						html = html + "			<tr>";
						html = html + "				<th>현지연락처<em class='f_red'>*</em></th>";
						html = html + "				<td><input type='text' id='localContact"+rsvAirPaxList[i].paxNo+"' name='localContact"+rsvAirPaxList[i].paxNo+"' data-role='none' placeholder='예) 82-10-1234-1234' /></td>";
						html = html + "			</tr>";
						html = html + "			<tr>";
						html = html + "				<th>탑승객연락처<em class='f_red'>*</em></th>";
						html = html + "				<td><input type='text' id='paxContact"+rsvAirPaxList[i].paxNo+"' name='paxContact"+rsvAirPaxList[i].paxNo+"' data-role='none' placeholder='예) 010-1234-1234' /></td>";
						html = html + "			</tr>";
						html = html + "		</tbody>";
						html = html + "	</table>";
					}
				}
				$("#div_contactDetail").html(html);	

			},
			error:function(err){
				//console.log(err);
			},
			complete:function(){
				
			}
		});
	}
	function goPostCodeMove() {
		moveLink('https://tools.usps.com/go/ZipLookupAction!input.action', '_blank');
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
				"rsvSeqno"		: '${rsvAir.getAirRsvSeqno()}'
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
	
	//항공 결제취소요청	
	function fn_paycancel() {
		document.location.href= "/free/account/pop_paycancel.do?seqNo=" + rsvSeqNo;
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
    }
	
	// 목적지/거주지 정보 변경 가져오기 
	function fn_getAddressParam() {
		var addressGroup = $('div[ft-att="addressGroup"]');

		if(paxCnt > 0) {
			paxNo1 = addressGroup.find('#paxNo1').val();
			paxTy1 = addressGroup.find('#paxTy1').val();
			addressTy1 = addressGroup.find('#addressTy1 option:selected').val();
			ntCd1 = addressGroup.find("#ntCd1").val();
			ntNm1 = addressGroup.find("#ntNm1").text();
			ctCd1 = addressGroup.find("#ctCd1").val();
			ctCdNm1 = addressGroup.find("#ctCdNm1").text();	
			stateCd1 = addressGroup.find("#stateCd1").val();	
			postCd1 = addressGroup.find("#postCd1").val();
			address1 = addressGroup.find("#address1").val();
			undecideYn1 = addressGroup.find("#undecideYn1").val();
		}

		if(paxCnt > 1) {
			paxNo2 = addressGroup.find('#paxNo2').val();
			paxTy2 = addressGroup.find('#paxTy2').val();
			addressTy2 = addressGroup.find('#addressTy2 option:selected').val();
			ntCd2 = addressGroup.find("#ntCd2").val();
			ntNm1 = addressGroup.find("#ntNm1").text();
			ctCd2 = addressGroup.find("#ctCd2").val();
			ctCdNm2 = addressGroup.find("#ctCdNm2").text();	
			stateCd2 = addressGroup.find("#stateCd2").val();	
			postCd2 = addressGroup.find("#postCd2").val();
			address2 = addressGroup.find("#address2").val();
			undecideYn2 = addressGroup.find("#undecideYn2").val();		
		}

		if(paxCnt > 2) {
			paxNo3 = addressGroup.find('#paxNo3').val();
			paxTy3 = addressGroup.find('#paxTy3').val();
			addressTy3 = addressGroup.find('#addressTy3 option:selected').val();
			ntCd3 = addressGroup.find("#ntCd3").val();
			ntNm3 = addressGroup.find("#ntNm3").text();
			ctCd3 = addressGroup.find("#ctCd3").val();
			ctCdNm3 = addressGroup.find("#ctCdNm3").text();	
			stateCd3 = addressGroup.find("#stateCd3").val();	
			postCd3 = addressGroup.find("#postCd3").val();
			address3 = addressGroup.find("#address3").val();
			undecideYn3 = addressGroup.find("#undecideYn3").val();				
		}

		if(paxCnt > 3) {
			paxNo4 = addressGroup.find('#paxNo4').val();
			paxTy4 = addressGroup.find('#paxTy4').val();
			addressTy4 = addressGroup.find('#addressTy4 option:selected').val();
			ntCd4 = addressGroup.find("#ntCd4").val();
			ntNm4 = addressGroup.find("#ntNm4").text();
			ctCd4 = addressGroup.find("#ctCd4").val();
			ctCdNm4 = addressGroup.find("#ctCdNm4").text();	
			stateCd4 = addressGroup.find("#stateCd4").val();	
			postCd4 = addressGroup.find("#postCd4").val();
			address4 = addressGroup.find("#address4").val();
			undecideYn4 = addressGroup.find("#undecideYn4").val();	
		}

		if(paxCnt > 4) {
			paxNo5 = addressGroup.find('#paxNo5').val();
			paxTy5 = addressGroup.find('#paxTy5').val();
			addressTy5 = addressGroup.find('#addressTy5 option:selected').val();
			ntCd5 = addressGroup.find("#ntCd5").val();
			ntNm5 = addressGroup.find("#ntNm5").text();
			ctCd5 = addressGroup.find("#ctCd5").val();
			ctCdNm5 = addressGroup.find("#ctCdNm5").text();	
			stateCd5 = addressGroup.find("#stateCd5").val();	
			postCd5 = addressGroup.find("#postCd5").val();
			address5 = addressGroup.find("#address5").val();
			undecideYn5 = addressGroup.find("#undecideYn5").val();	
			
		}		

		if(paxCnt > 5) {
			paxNo6 = addressGroup.find('#paxNo6').val();
			paxTy6 = addressGroup.find('#paxTy6').val();
			addressTy6 = addressGroup.find('#addressTy6 option:selected').val();
			ntCd6 = addressGroup.find("#ntCd6").val();
			ntNm6 = addressGroup.find("#ntNm6").text();
			ctCd6 = addressGroup.find("#ctCd6").val();
			ctCdNm6 = addressGroup.find("#ctCdNm6").text();	
			stateCd6 = addressGroup.find("#stateCd6").val();	
			postCd6 = addressGroup.find("#postCd6").val();
			address6 = addressGroup.find("#address6").val();
			undecideYn6 = addressGroup.find("#undecideYn6").val();	
			
		}	

		if(paxCnt > 6) {
			paxNo7 = addressGroup.find('#paxNo7').val();
			paxTy7 = addressGroup.find('#paxTy7').val();
			addressTy7 = addressGroup.find('#addressTy7 option:selected').val();
			ntCd7 = addressGroup.find("#ntCd7").val();
			ntNm7 = addressGroup.find("#ntNm7").text();
			ctCd7 = addressGroup.find("#ctCd7").val();
			ctCdNm7 = addressGroup.find("#ctCdNm7").text();	
			stateCd7 = addressGroup.find("#stateCd7").val();	
			postCd7 = addressGroup.find("#postCd7").val();
			address7 = addressGroup.find("#address7").val();
			undecideYn7 = addressGroup.find("#undecideYn7").val();	
			
		}	

		if(paxCnt > 7) {
			paxNo8 = addressGroup.find('#paxNo8').val();
			paxTy8 = addressGroup.find('#paxTy8').val();
			addressTy8 = addressGroup.find('#addressTy8 option:selected').val();
			ntCd8 = addressGroup.find("#ntCd8").val();
			ntNm8 = addressGroup.find("#ntNm8").text();
			ctCd8 = addressGroup.find("#ctCd8").val();
			ctCdNm8 = addressGroup.find("#ctCdNm8").text();	
			stateCd8 = addressGroup.find("#stateCd8").val();	
			postCd8 = addressGroup.find("#postCd8").val();
			address8 = addressGroup.find("#address8").val();
			undecideYn8 = addressGroup.find("#undecideYn8").val();	
			
		}		

		if(paxCnt > 8) {
			paxNo9 = addressGroup.find('#paxNo9').val();
			paxTy9 = addressGroup.find('#paxTy9').val();
			addressTy9 = addressGroup.find('#addressTy9 option:selected').val();
			ntCd9 = addressGroup.find("#ntCd9").val();
			ntNm9 = addressGroup.find("#ntNm9").text();
			ctCd9 = addressGroup.find("#ctCd9").val();
			ctCdNm9 = addressGroup.find("#ctCdNm9").val();	
			stateCd9 = addressGroup.find("#stateCd9").val();	
			postCd9 = addressGroup.find("#postCd9").val();
			address9 = addressGroup.find("#address9").val();
			undecideYn9 = addressGroup.find("#undecideYn9").val();	
		}	

		if(paxCnt > 9) {
			paxNo10 = addressGroup.find('#paxNo10').val();
			paxTy10 = addressGroup.find('#paxTy10').val();
			addressTy10 = addressGroup.find('#addressTy10 option:selected').val();
			ntCd10 = addressGroup.find("#ntCd10").val();
			ntNm10 = addressGroup.find("#ntNm10").text();
			ctCd10 = addressGroup.find("#ctCd10").val();
			ctCdNm10 = addressGroup.find("#ctCdNm10").text();	
			stateCd10 = addressGroup.find("#stateCd10").val();	
			postCd10 = addressGroup.find("#postCd10").val();
			address10 = addressGroup.find("#address10").val();
			undecideYn10 = addressGroup.find("#undecideYn10").val();	
			
		}									
	}

	// 목적지/거주지 정보 등록 체크 
	function fn_checkAddressParam() {
		var addressGroup = $('div[ft-att="addressGroup"]');

		if(paxCnt > 0) {			
			if(address1 == '' || address1 == null) {
				alert("주소를 입력해 주세요.");
				addressGroup.find("#address1").focus();
				return false;
			}
		}

		if(paxCnt > 1) {			
			if(address2 == '' || address2 == null) {
				alert("주소를 입력해 주세요.");
				addressGroup.find("#address2").focus();
				return false;
			}
		}

		if(paxCnt > 2) {			
			if(address3 == '' || address3 == null) {
				alert("주소를 입력해 주세요.");
				addressGroup.find("#address3").focus();
				return false;
			}
		}

		if(paxCnt > 3) {			
			if(address4 == '' || address4 == null) {
				alert("주소를 입력해 주세요.");
				addressGroup.find("#address4").focus();
				return false;
			}
		}

		if(paxCnt > 4) {			
			if(address5 == '' || address5 == null) {
				alert("주소를 입력해 주세요.");
				addressGroup.find("#address5").focus();
				return false;
			}
		}

		if(paxCnt > 5) {			
			if(address6 == '' || address6 == null) {
				alert("주소를 입력해 주세요.");
				addressGroup.find("#address6").focus();
				return false;
			}
		}

		if(paxCnt > 6) {			
			if(address7 == '' || address7 == null) {
				alert("주소를 입력해 주세요.");
				addressGroup.find("#address7").focus();
				return false;
			}
		}

		if(paxCnt > 7) {			
			if(address8 == '' || address8 == null) {
				alert("주소를 입력해 주세요.");
				addressGroup.find("#address8").focus();
				return false;
			}
		}

		if(paxCnt > 8) {			
			if(address9 == '' || address9 == null) {
				alert("주소를 입력해 주세요.");
				addressGroup.find("#address9").focus();
				return false;
			}
		}

		if(paxCnt > 9) {			
			if(address10 == '' || address10 == null) {
				alert("주소를 입력해 주세요.");
				addressGroup.find("#address10").focus();
				return false;
			}
		}
		
		return true;
	}

	// 목적지/거주지 정보 등록 
	function fn_saveAddress() {
		fn_getAddressParam();
		if(fn_checkAddressParam()) {
			var airAddressData = {
				// bodyDTO
				
			};
			airAddressData.bodyDTO = {
				"rsvSeqno"		: '${rsvAir.getAirRsvSeqno()}'
			};

			airAddressData.bodyDTO.paxGroup = [];

			console.log("paxCnt : " + paxCnt);

			if(paxCnt > 0) {

				airAddressData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo1,
					"paxTy"				: paxTy1,
					"addressTy"			: addressTy1,
					"ntCd"				: ntCd1,
					"ctCd"				: ctCd1,
					"ctCdNm"			: ctCdNm1,
					"stateCd"			: stateCd1,
					"postCd"			: postCd1,
					"address"			: address1,
					"undecideYn"		: undecideYn1
				});
			}

			if(paxCnt > 1) {
				airAddressData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo2,
					"paxTy"				: paxTy2,
					"addressTy"			: addressTy2,
					"ntCd"				: ntCd2,
					"ctCd"				: ctCd2,
					"ctCdNm"			: ctCdNm2,
					"stateCd"			: stateCd2,
					"postCd"			: postCd2,
					"address"			: address2,
					"undecideYn"		: undecideYn2
				});
			}	

			if(paxCnt > 2) {
				airAddressData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo3,
					"paxTy"				: paxTy3,
					"addressTy"			: addressTy3,
					"ntCd"				: ntCd3,
					"ctCd"				: ctCd3,
					"ctCdNm"			: ctCdNm3,
					"stateCd"			: stateCd3,
					"postCd"			: postCd3,
					"address"			: address3,
					"undecideYn"		: undecideYn3
				});
			}	

			if(paxCnt > 3) {
				airAddressData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo4,
					"paxTy"				: paxTy4,
					"addressTy"			: addressTy4,
					"ntCd"				: ntCd4,
					"ctCd"				: ctCd4,
					"ctCdNm"			: ctCdNm4,
					"stateCd"			: stateCd4,
					"postCd"			: postCd4,
					"address"			: address4,
					"undecideYn"		: undecideYn4
				});
			}		

			if(paxCnt > 4) {
				airAddressData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo5,
					"paxTy"				: paxTy5,
					"addressTy"			: addressTy5,
					"ntCd"				: ntCd5,
					"ctCd"				: ctCd5,
					"ctCdNm"			: ctCdNm5,
					"stateCd"			: stateCd5,
					"postCd"			: postCd5,
					"address"			: address5,
					"undecideYn"		: undecideYn5
				});
			}	

			if(paxCnt > 5) {
				airAddressData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo6,
					"paxTy"				: paxTy6,
					"addressTy"			: addressTy6,
					"ntCd"				: ntCd6,
					"ctCd"				: ctCd6,
					"ctCdNm"			: ctCdNm6,
					"stateCd"			: stateCd6,
					"postCd"			: postCd6,
					"address"			: address6,
					"undecideYn"		: undecideYn6
				});
			}	

			if(paxCnt > 6) {
				airAddressData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo7,
					"paxTy"				: paxTy7,
					"addressTy"			: addressTy7,
					"ntCd"				: ntCd7,
					"ctCd"				: ctCd7,
					"ctCdNm"			: ctCdNm7,
					"stateCd"			: stateCd7,
					"postCd"			: postCd7,
					"address"			: address7,
					"undecideYn"		: undecideYn7
				});
			}	

			if(paxCnt > 7) {
				airAddressData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo8,
					"paxTy"				: paxTy8,
					"addressTy"			: addressTy8,
					"ntCd"				: ntCd8,
					"ctCd"				: ctCd8,
					"ctCdNm"			: ctCdNm8,
					"stateCd"			: stateCd8,
					"postCd"			: postCd8,
					"address"			: address8,
					"undecideYn"		: undecideYn8
				});
			}	

			if(paxCnt > 8) {
				airAddressData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo9,
					"paxTy"				: paxTy9,
					"addressTy"			: addressTy9,
					"ntCd"				: ntCd9,
					"ctCd"				: ctCd9,
					"ctCdNm"			: ctCdNm9,
					"stateCd"			: stateCd9,
					"postCd"			: postCd9,
					"address"			: address9,
					"undecideYn"		: undecideYn9
				});
			}		

			if(paxCnt > 9) {
				airAddressData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo10,
					"paxTy"				: paxTy10,
					"addressTy"			: addressTy10,
					"ntCd"				: ntCd10,
					"ctCd"				: ctCd10,
					"ctCdNm"			: ctCdNm10,
					"stateCd"			: stateCd10,
					"postCd"			: postCd10,
					"address"			: address10,
					"undecideYn"		: undecideYn10
				});
			}	
			console.log("paxCnt : " + paxCnt);
			console.log(airAddressData);

        	gfn_callAjax3('/fit/rsv/saveAddressAjax.do', airAddressData.bodyDTO, 'successAddress');				
		}																																							
	}

	// 목적지/거주지 정보 후 처리 
    function successAddress(_data) {

        var data = _data.result.data;
        
        if (data.length > 0) {
        }
        if(_data.result.code == 1) {
 	       alert("목적지/거주지 정보가 등록되었습니다.");
        } else {
           alert("목적지/거주지 정보가 등록되지 않았습니다.");
        }
    }

	// 목적지/거주지 정보 복사하기
	function fn_syncAddress() {
		fn_getAddressParam();

		var addressGroup = $('div[ft-att="addressGroup"]');

		if(paxCnt > 1) {

			var div_addressTy = "#addressTy2 option:eq(" +addressTy1+")";
			addressGroup.find(div_addressTy).attr("selected", "selected");
			addressGroup.find("#ntCd2").val(ntCd1);
			addressGroup.find("#ntNm2").text(ntNm1);
			addressGroup.find("#ctCd2").val(ctCd1);
			addressGroup.find("#ctCdNm2").text(ctCdNm1);	
			addressGroup.find("#stateCd2").val(stateCd1);	
			addressGroup.find("#postCd2").val(postCd1);
			addressGroup.find("#address2").val(address1);			
			if(undecideYn1 == 'Y') {
				addressGroup.find("#undecideYn2").prop('checked', true) ;
				addressGroup.find("#undecideYn2").attr('checked', true) ;			
			}
		}

		if(paxCnt > 2) {
			var div_addressTy = "#addressTy3 option:eq(" +addressTy1+")";
			addressGroup.find(div_addressTy).attr("selected", "selected");
			addressGroup.find("#ntCd3").val(ntCd1);
			addressGroup.find("#ntNm3").text(ntNm1);
			addressGroup.find("#ctCd3").val(ctCd1);
			addressGroup.find("#ctCdNm3").text(ctCdNm1);	
			addressGroup.find("#stateCd3").val(stateCd1);	
			addressGroup.find("#postCd3").val(postCd1);
			addressGroup.find("#address3").val(address1);			
			if(undecideYn1 == 'Y') {
				addressGroup.find("#undecideYn3").prop('checked', true) ;
				addressGroup.find("#undecideYn3").attr('checked', true) ;			
			}		
		}

		if(paxCnt > 3) {
			var div_addressTy = "#addressTy4 option:eq(" +addressTy1+")";
			addressGroup.find(div_addressTy).attr("selected", "selected");
			addressGroup.find("#ntCd4").val(ntCd1);
			addressGroup.find("#ntNm4").text(ntNm1);
			addressGroup.find("#ctCd4").val(ctCd1);
			addressGroup.find("#ctCdNm4").text(ctCdNm1);	
			addressGroup.find("#stateCd4").val(stateCd1);	
			addressGroup.find("#postCd4").val(postCd1);
			addressGroup.find("#address4").val(address1);			
			if(undecideYn1 == 'Y') {
				addressGroup.find("#undecideYn4").prop('checked', true) ;
				addressGroup.find("#undecideYn4").attr('checked', true) ;			
			}
		}

		if(paxCnt > 4) {
			var div_addressTy = "#addressTy5 option:eq(" +addressTy1+")";
			addressGroup.find(div_addressTy).attr("selected", "selected");
			addressGroup.find("#ntCd5").val(ntCd1);
			addressGroup.find("#ntNm5").text(ntNm1);
			addressGroup.find("#ctCd5").val(ctCd1);
			addressGroup.find("#ctCdNm5").text(ctCdNm1);	
			addressGroup.find("#stateCd5").val(stateCd1);	
			addressGroup.find("#postCd5").val(postCd1);
			addressGroup.find("#address5").val(address1);			
			if(undecideYn1 == 'Y') {
				addressGroup.find("#undecideYn5").prop('checked', true) ;
				addressGroup.find("#undecideYn5").attr('checked', true) ;			
			}	
			
		}		

		if(paxCnt > 5) {
			var div_addressTy = "#addressTy6 option:eq(" +addressTy1+")";
			addressGroup.find(div_addressTy).attr("selected", "selected");
			addressGroup.find("#ntCd6").val(ntCd1);
			addressGroup.find("#ntNm6").text(ntNm1);
			addressGroup.find("#ctCd6").val(ctCd1);
			addressGroup.find("#ctCdNm6").text(ctCdNm1);	
			addressGroup.find("#stateCd6").val(stateCd1);	
			addressGroup.find("#postCd6").val(postCd1);
			addressGroup.find("#address6").val(address1);			
			if(undecideYn1 == 'Y') {
				addressGroup.find("#undecideYn6").prop('checked', true) ;
				addressGroup.find("#undecideYn6").attr('checked', true) ;			
			}	
			
		}	

		if(paxCnt > 6) {
			var div_addressTy = "#addressTy7 option:eq(" +addressTy1+")";
			addressGroup.find(div_addressTy).attr("selected", "selected");
			addressGroup.find("#ntCd7").val(ntCd1);
			addressGroup.find("#ntNm7").text(ntNm1);
			addressGroup.find("#ctCd7").val(ctCd1);
			addressGroup.find("#ctCdNm7").text(ctCdNm1);	
			addressGroup.find("#stateCd7").val(stateCd1);	
			addressGroup.find("#postCd7").val(postCd1);
			addressGroup.find("#address7").val(address1);			
			if(undecideYn1 == 'Y') {
				addressGroup.find("#undecideYn7").prop('checked', true) ;
				addressGroup.find("#undecideYn7").attr('checked', true) ;			
			}	
			
		}	

		if(paxCnt > 7) {
			var div_addressTy = "#addressTy8 option:eq(" +addressTy1+")";
			addressGroup.find(div_addressTy).attr("selected", "selected");
			addressGroup.find("#ntCd8").val(ntCd1);
			addressGroup.find("#ntNm8").text(ntNm1);
			addressGroup.find("#ctCd8").val(ctCd1);
			addressGroup.find("#ctCdNm8").text(ctCdNm1);	
			addressGroup.find("#stateCd8").val(stateCd1);	
			addressGroup.find("#postCd8").val(postCd1);
			addressGroup.find("#address8").val(address1);			
			if(undecideYn1 == 'Y') {
				addressGroup.find("#undecideYn8").prop('checked', true) ;
				addressGroup.find("#undecideYn8").attr('checked', true) ;			
			}	
			
		}		

		if(paxCnt > 8) {
			var div_addressTy = "#addressTy9 option:eq(" +addressTy1+")";
			addressGroup.find(div_addressTy).attr("selected", "selected");
			addressGroup.find("#ntCd9").val(ntCd1);
			addressGroup.find("#ntNm9").text(ntNm1);
			addressGroup.find("#ctCd9").val(ctCd1);
			addressGroup.find("#ctCdNm9").text(ctCdNm1);	
			addressGroup.find("#stateCd9").val(stateCd1);	
			addressGroup.find("#postCd9").val(postCd1);
			addressGroup.find("#address9").val(address1);			
			if(undecideYn1 == 'Y') {
				addressGroup.find("#undecideYn9").prop('checked', true) ;
				addressGroup.find("#undecideYn9").attr('checked', true) ;			
			}	
		}	

		if(paxCnt > 9) {
			var div_addressTy = "#addressTy10 option:eq(" +addressTy1+")";
			addressGroup.find(div_addressTy).attr("selected", "selected");
			addressGroup.find("#ntCd10").val(ntCd1);
			addressGroup.find("#ntNm10").text(ntNm1);
			addressGroup.find("#ctCd10").val(ctCd1);
			addressGroup.find("#ctCdNm10").text(ctCdNm1);	
			addressGroup.find("#stateCd10").val(stateCd1);	
			addressGroup.find("#postCd10").val(postCd1);
			addressGroup.find("#address10").val(address1);			
			if(undecideYn1 == 'Y') {
				addressGroup.find("#undecideYn9").prop('checked', true) ;
				addressGroup.find("#undecideYn9").attr('checked', true) ;			
			}		
			
		}					

	}


	// 현지연락처 정보 가져오기 
	function fn_getContactParam() {
		var contactGroup = $('table[ft-att="contactGroup"]');

		if(paxCnt > 0) {
			paxNo1 = contactGroup.find('#paxNo1').val();
			paxTy1 = contactGroup.find('#paxTy1').val();
			ctCd1 = contactGroup.find("#ctCd1").val();
			ctCdNm1 = contactGroup.find("#ctCdNm1").val();	
			localContact1 = contactGroup.find("#localContact1").val();	
			paxContact1 = contactGroup.find("#paxContact1").val();
		}

		if(paxCnt > 1) {
			paxNo2 = contactGroup.find('#paxNo2').val();
			paxTy2 = contactGroup.find('#paxTy2').val();
			ctCd2 = contactGroup.find("#ctCd2").val();
			ctCdNm2 = contactGroup.find("#ctCdNm2").val();	
			localContact2 = contactGroup.find("#localContact2").val();	
			paxContact2 = contactGroup.find("#paxContact2").val();
		}

		if(paxCnt > 2) {
			paxNo3 = contactGroup.find('#paxNo3').val();
			paxTy3 = contactGroup.find('#paxTy3').val();
			ctCd3 = contactGroup.find("#ctCd3").val();
			ctCdNm3 = contactGroup.find("#ctCdNm3").val();	
			localContact3 = contactGroup.find("#localContact3").val();	
			paxContact3 = contactGroup.find("#paxContact3").val();			
		}

		if(paxCnt > 3) {
			paxNo4 = contactGroup.find('#paxNo4').val();
			paxTy4 = contactGroup.find('#paxTy4').val();
			ctCd4 = contactGroup.find("#ctCd4").val();
			ctCdNm4 = contactGroup.find("#ctCdNm4").val();	
			localContact4 = contactGroup.find("#localContact4").val();	
			paxContact4 = contactGroup.find("#paxContact4").val();		
		}

		if(paxCnt > 4) {
			paxNo5 = contactGroup.find('#paxNo5').val();
			paxTy5 = contactGroup.find('#paxTy5').val();
			ctCd5 = contactGroup.find("#ctCd5").val();
			ctCdNm5 = contactGroup.find("#ctCdNm5").val();	
			localContact5 = contactGroup.find("#localContact5").val();	
			paxContact5 = contactGroup.find("#paxContact5").val();			
			
		}		

		if(paxCnt > 5) {
			paxNo6 = contactGroup.find('#paxNo6').val();
			paxTy6 = contactGroup.find('#paxTy6').val();
			ctCd6 = contactGroup.find("#ctCd6").val();
			ctCdNm6 = contactGroup.find("#ctCdNm6").val();	
			localContact6 = contactGroup.find("#localContact6").val();	
			paxContact6 = contactGroup.find("#paxContact6").val();			
			
		}	

		if(paxCnt > 6) {
			paxNo7 = contactGroup.find('#paxNo7').val();
			paxTy7 = contactGroup.find('#paxTy7').val();
			ctCd7 = contactGroup.find("#ctCd7").val();
			ctCdNm7 = contactGroup.find("#ctCdNm7").val();	
			localContact7 = contactGroup.find("#localContact7").val();	
			paxContact7 = contactGroup.find("#paxContact7").val();			
			
		}	

		if(paxCnt > 7) {
			paxNo8 = contactGroup.find('#paxNo8').val();
			paxTy8 = contactGroup.find('#paxTy8').val();
			ctCd8 = contactGroup.find("#ctCd8").val();
			ctCdNm8 = contactGroup.find("#ctCdNm8").val();	
			localContact8 = contactGroup.find("#localContact8").val();	
			paxContact8 = contactGroup.find("#paxContact8").val();			
		}		

		if(paxCnt > 8) {
			paxNo9 = contactGroup.find('#paxNo9').val();
			paxTy9 = contactGroup.find('#paxTy9').val();
			ctCd9 = contactGroup.find("#ctCd9").val();
			ctCdNm9 = contactGroup.find("#ctCdNm9").val();	
			localContact9 = contactGroup.find("#localContact9").val();	
			paxContact9 = contactGroup.find("#paxContact9").val();			
		}	

		if(paxCnt > 9) {
			paxNo10 = contactGroup.find('#paxNo10').val();
			paxTy10 = contactGroup.find('#paxTy10').val();
			ctCd10 = contactGroup.find("#ctCd10").val();
			ctCdNm10 = contactGroup.find("#ctCdNm10").val();	
			localContact10 = contactGroup.find("#localContact10").val();	
			paxContact10 = contactGroup.find("#paxContact10").val();
		}									
	}

	// 목적지/거주지 정보 등록 체크 
	function fn_checkContactParam() {
		var contactGroup = $('table[ft-att="contactGroup"]');

		if(paxCnt > 0) {			
			if(localContact1 == '' || localContact1 == null) {
				alert("현지 연락처를 입력해 주세요.");
				contactGroup.find("#localContact1").focus();
				return false;
			}
		}

		if(paxCnt > 1) {			
			if(localContact2 == '' || localContact2 == null) {
				alert("현지 연락처를 입력해 주세요.");
				contactGroup.find("#localContact2").focus();
				return false;
			}
		}

		if(paxCnt > 2) {			
			if(localContact3 == '' || localContact3 == null) {
				alert("현지 연락처를 입력해 주세요.");
				contactGroup.find("#localContact3").focus();
				return false;
			}
		}

		if(paxCnt > 3) {			
			if(localContact4 == '' || localContact4 == null) {
				alert("현지 연락처를 입력해 주세요.");
				contactGroup.find("#localContact4").focus();
				return false;
			}
		}

		if(paxCnt > 4) {			
			if(localContact5 == '' || localContact5 == null) {
				alert("현지 연락처를 입력해 주세요.");
				contactGroup.find("#localContact5").focus();
				return false;
			}
		}

		if(paxCnt > 5) {			
			if(localContact6 == '' || localContact6 == null) {
				alert("현지 연락처를 입력해 주세요.");
				contactGroup.find("#localContact6").focus();
				return false;
			}
		}

		if(paxCnt > 6) {			
			if(localContact7 == '' || localContact7 == null) {
				alert("현지 연락처를 입력해 주세요.");
				contactGroup.find("#localContact7").focus();
				return false;
			}
		}

		if(paxCnt > 7) {			
			if(localContact8 == '' || localContact8 == null) {
				alert("현지 연락처를 입력해 주세요.");
				contactGroup.find("#localContact8").focus();
				return false;
			}
		}

		if(paxCnt > 8) {			
			if(localContact9 == '' || localContact9 == null) {
				alert("현지 연락처를 입력해 주세요.");
				contactGroup.find("#localContact9").focus();
				return false;
			}
		}

		if(paxCnt > 9) {			
			if(localContact10 == '' || localContact10 == null) {
				alert("현지 연락처를 입력해 주세요.");
				contactGroup.find("#localContact10").focus();
				return false;
			}
		}
		
		return true;
	}

	// 현지연락처 전송 
	function fn_saveContact() {
		fn_getContactParam();
		if(fn_checkContactParam()) {
			var airContactData = {
				// bodyDTO
				
			};
			airContactData.bodyDTO = {
				"rsvSeqno"	: "${rsvAir.getAirRsvSeqno()}"
			};

			airContactData.bodyDTO.paxGroup = [];

			console.log("paxCnt : " + paxCnt);

			if(paxCnt > 0) {

				airContactData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo1,
					"paxTy"				: paxTy1,
					"ctCd"				: ctCd1,
					"localContact"		: localContact1,
					"paxContact"		: paxContact1
				});
			}

			if(paxCnt > 1) {
				airContactData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo2,
					"paxTy"				: paxTy2,
					"ctCd"				: ctCd2,
					"localContact"		: localContact2,
					"paxContact"		: paxContact2
				});

			}	

			if(paxCnt > 2) {
				airContactData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo3,
					"paxTy"				: paxTy3,
					"ctCd"				: ctCd3,
					"localContact"		: localContact3,
					"paxContact"		: paxContact3
				});
			}	

			if(paxCnt > 3) {
				airContactData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo4,
					"paxTy"				: paxTy4,
					"ctCd"				: ctCd4,
					"localContact"		: localContact4,
					"paxContact"		: paxContact4
				});
			}		

			if(paxCnt > 4) {
				airContactData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo5,
					"paxTy"				: paxTy5,
					"ctCd"				: ctCd5,
					"localContact"		: localContact5,
					"paxContact"		: paxContact5
				});
			}	

			if(paxCnt > 5) {
				airContactData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo6,
					"paxTy"				: paxTy6,
					"ctCd"				: ctCd6,
					"localContact"		: localContact6,
					"paxContact"		: paxContact6
				});
			}	

			if(paxCnt > 6) {
				airContactData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo7,
					"paxTy"				: paxTy7,
					"ctCd"				: ctCd7,
					"localContact"		: localContact7,
					"paxContact"		: paxContact7
				});
			}	

			if(paxCnt > 7) {
				airContactData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo8,
					"paxTy"				: paxTy8,
					"ctCd"				: ctCd8,
					"localContact"		: localContact8,
					"paxContact"		: paxContact8
				});
			}	

			if(paxCnt > 8) {
				airContactData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo9,
					"paxTy"				: paxTy9,
					"ctCd"				: ctCd9,
					"localContact"		: localContact9,
					"paxContact"		: paxContact9
				});
			}		

			if(paxCnt > 9) {
				airContactData.bodyDTO.paxGroup.push({
					"paxNo"				: paxNo10,
					"paxTy"				: paxTy10,
					"ctCd"				: ctCd10,
					"localContact"		: localContact10,
					"paxContact"		: paxContact10
				});
			}	
			console.log("paxCnt : " + paxCnt);
			console.log(airContactData);

        	gfn_callAjax3('/fit/rsv/saveContactAjax.do', airContactData.bodyDTO, 'successContact');				
		}	

		return true;																																						
	}

	// 현지연락처 정보 저장 후 처리 
    function successContact(_data) {

        var data = _data.result.data;
        
        if (data.length > 0) {
        }
        if(_data.result.code == 1) {
 	       alert("현지연락처 정보가 등록되었습니다.");
        } else {
           alert("현지연락처 정보가 등록되지 않았습니다.");
        }
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
	
	function payCard() { // 신용카드 
		var card_div = $('div[ft-att="card"]');
		var card_all = $('div[ft-att="CARD_ALL"]');
		var card_pax = $('div[ft-att="CARD_PAX"]');
		var cardType = card_div.find('input:radio[name="cardType1"]').filter(':checked').val();
		// alert(cardType);

		var CARD_PAYMT_AMT = '';
		var TASF_AMT = '';
		var PAX_NO = '';
		var CARD_OWNER_GB = '';
		var CARD_OWNER_NM = '';
		var CARD_KI_GB = '';
		var CARD_NO = '';
		var CARD_NO1 = '';
		var CARD_NO2 = '';
		var CARD_NO3 = '';
		var CARD_NO4 = '';
		var CARD_EXPIR_DATE_MN = '';
		var CARD_EXPIR_DATE_YEAR = '';
		var CARD_INSTALLMN_MN = '';
		var FRONT_PASS = '';
		var CARD_CVS_NO = '';

		console.log("cardType : " + cardType);

		if(cardType == '01') {
			CARD_PAYMT_AMT = card_all.find("#totalAmt").val();
			TASF_AMT = card_all.find("#tasfAmt").val();
			PAX_NO = card_all.find("#PAX_NO").val();
			CARD_OWNER_GB = card_all.find('input:radio[name="CARD_OWNER_GB1"]').filter(':checked').val();
			console.log("CARD_OWNER_GB1 : " + CARD_OWNER_GB);
			CARD_OWNER_NM = card_all.find("#CARD_OWNER_NM").val();
			// CARD_KI_GB = card_all.find("#select#CARD_KI_GB option:selected").val();
			CARD_KI_GB = card_all.find("select#CARD_KI_GB option:selected").val();
			CARD_NO1 = card_all.find("#CARD_NO01").val();
			CARD_NO2 = card_all.find("#CARD_NO02").val();
			CARD_NO3 = card_all.find("#CARD_NO03").val();
			CARD_NO4 = card_all.find("#CARD_NO04").val();
			CARD_NO = CARD_NO1 + CARD_NO2 + CARD_NO3 + CARD_NO4;
			CARD_EXPIR_DATE_MN = card_all.find("select#CARD_EXPIR_DATE_MN option:selected").val();
			CARD_EXPIR_DATE_YEAR = card_all.find("select#CARD_EXPIR_DATE_YEAR option:selected").val();
			CARD_INSTALLMN_MN = card_all.find("select#CARD_INSTALLMN_MN option:selected").val();
			FRONT_PASS = card_all.find("#FRONT_PASS").val();
			// CARD_CVS_NO = card_all.find("#CARD_CVS_NO").val();
		} else {
			CARD_PAYMT_AMT = card_pax.find("#totalAmt").val();
			TASF_AMT = card_pax.find("#tasfAmt").val();
			PAX_NO = card_pax.find("#PAX_NO").val();
			CARD_OWNER_GB = card_pax.find('input:radio[name="CARD_OWNER_GB2"]').filter(':checked').val();
			console.log("CARD_OWNER_GB2 : " + CARD_OWNER_GB);

			CARD_OWNER_NM = card_pax.find("#CARD_OWNER_NM").val();
			CARD_KI_GB = card_pax.find("select#CARD_KI_GB option:selected").val();
			CARD_NO1 = card_pax.find("#CARD_NO01").val();
			CARD_NO2 = card_pax.find("#CARD_NO02").val();
			CARD_NO3 = card_pax.find("#CARD_NO03").val();
			CARD_NO4 = card_pax.find("#CARD_NO04").val();
			CARD_NO = CARD_NO1 + CARD_NO2 + CARD_NO3 + CARD_NO4;
			CARD_EXPIR_DATE_MN = card_pax.find("select#CARD_EXPIR_DATE_MN option:selected").val();
			CARD_EXPIR_DATE_YEAR = card_pax.find("select#CARD_EXPIR_DATE_YEAR option:selected").val();
			CARD_INSTALLMN_MN = card_pax.find("select#CARD_INSTALLMN_MN option:selected").val();
			FRONT_PASS = card_pax.find("#FRONT_PASS").val();
			// CARD_CVS_NO = card_pax.find("#CARD_CVS_NO").val();
		}
	
		var paxCnt = <%=rsvAirPaxList.size()%>;
		// if(CARD_OWNER_GB == 'undefined') 
		// CARD_OWNER_GB = '001';

		console.log("CARD_OWNER_GB : " + CARD_OWNER_GB);
		console.log("CARD_KI_GB : " + CARD_KI_GB);
		
		// 항공 결제요청 정보 저장 

		var airRsvForm = new FormData();
		airRsvForm.append('AIR_RSV_SEQNO', '${rsvAir.getAirRsvSeqno()}');
		airRsvForm.append('PAYMT_APPROVE_AMT', parseInt(CARD_PAYMT_AMT) + parseInt(TASF_AMT));
		airRsvForm.append('PAYMT_UNPAID_AMT',0);
		airRsvForm.append('TASF_AMT',TASF_AMT);
		airRsvForm.append('CARD_USE_YN','Y');
		airRsvForm.append('CARD_ALL_YN', 'Y');

		airRsvForm.append('ACT_USE_YN','N');
		airRsvForm.append('GIFT_USE_YN','N');
		airRsvForm.append('ETC_USE_YN','N');
		airRsvForm.append('REGTOR_ID','');
		airRsvForm.append('REG_DTT','');
		airRsvForm.append('MODTOR_ID','');
		airRsvForm.append('MOD_DTT','');
		


		// 카드 결제 정보  저장 
		var cardPayForm = new FormData();
		cardPayForm.append('AIR_RSV_SEQNO', '${rsvAir.getAirRsvSeqno()}');
		cardPayForm.append('CARD_PAYMT_AMT',CARD_PAYMT_AMT);
		cardPayForm.append('TASF_AMT',TASF_AMT);
		cardPayForm.append('CARD_OWNER_GB',CARD_OWNER_GB);
		cardPayForm.append('CARD_OWNER_NM',CARD_OWNER_NM);		
		cardPayForm.append('CARD_KI_GB',CARD_KI_GB);
		cardPayForm.append('CARD_NO',CARD_NO);
		cardPayForm.append('CARD_EXPIR_DATE_MN',CARD_EXPIR_DATE_MN);
		cardPayForm.append('CARD_EXPIR_DATE_YEAR',CARD_EXPIR_DATE_YEAR);
		cardPayForm.append('CARD_INSTALLMN_MN',CARD_INSTALLMN_MN);
		cardPayForm.append('FRONT_PASS',FRONT_PASS);
		// cardPayForm.append("CARD_CVS_NO", CARD_CVS_NO);
		cardPayForm.append("CARD_RELAT_GB", '');
		cardPayForm.append('REGTOR_ID','');
		cardPayForm.append('REG_DTT','');
		cardPayForm.append('MODTOR_ID','');
		cardPayForm.append('MOD_DTT','');


		if(cardPayForm == '01') {
			cardPayForm.append('PAX_NO', '0');
		} else {
			if(paxCnt > 1) {
				var PAX_NO1 = card_div.find("#PAX_NO1").val();
				cardPayForm.append('PAX_NO', PAX_NO1);
			}
		}
		cardPayForm.append('APPROVE_CONF_YN', 'N');
		cardPayForm.append('CARD_CVS_NO', '');

		if(CARD_OWNER_GB == '') {
			alert("카드소유를 선택해 주세요.");
		} else if(CARD_OWNER_NM == '') {
			alert("소유자명을 입력해 주세요.");
		} else if(CARD_KI_GB == '') {
			alert("카드 선택을 해주세요.");
		} else if(CARD_NO == '') {
			alert("카드 번호를 입력해 주세요.");		
		} else if(CARD_EXPIR_DATE_MN == '' || CARD_EXPIR_DATE_YEAR == '') {
			alert("유효 기간을 선택해 주세요.");								
		} else if(CARD_INSTALLMN_MN == '') {
			alert("할부 기간을 선택해 주세요.");		
		/**
		} else if(CARD_CVS_NO == '') {
			alert("카드 CVS2 번호를 입력해 주세요.");					
		**/
		} else if(FRONT_PASS == '') {
			alert("비밀번호를 입력해 주세요.");					
		} else {
			cfn_ajax({ 
				type: "POST",
				async: false,
				url: "/free/account/saveAirRsvPaymentAjax.do",
				data: airRsvForm,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
				},
				error:function(err){
					//console.log(err);
				},
				complete:function(){
					
				}
			});
					
			cfn_ajax({
				type: "POST",
				async: false,
				url: "/free/account/saveAirCardPaymentAjax.do",
				data: cardPayForm,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
				},
				error:function(err){
					//console.log(err);
					alert("저장되지 않았습니다.");
				},
				complete:function(){
					alert("저장되었습니다.");
					history.back(-1);
				}
			});
		}
	}
	
	function payVBank() { // 무통장입금(가상계좌)
		
		var virtual_div = $('div[ft-att="virtual"]');
		var submitform1 = $('form[ft-att="form1"]');	//	가상계좌

		// 결제 수단
		var paymentMethod = $('input[name=paymentMethod]').val();
		var proofCheck	=	"";
		var buyerEmail = virtual_div.find('#email').val();
		var buyerTel = virtual_div.find('#phoneNumber').val();
		
		var buyerName = '<%=knm%>';

		if(paymentMethod	==	"VBank"){
			if(buyerEmail == "" || buyerEmail == null){
				alert("이메일을 입력해 주세요");
				$('#email').fucus();
				return;
				
			}

			if(buyerTel == "" || buyerTel == null){
				alert("이동전화를 입력해 주세요");
				$('#phoneNumber').fucus();
				return;
				
			}
			
			var formData = new FormData();
			var payPrice	=	virtual_div.find('#payment_air').text().replace(/,/gi, '');
			console.log("ajax price:" + payPrice);
			//payPrice	=	1004;
			formData.append('price', payPrice);
			
			cfn_ajax({
				type : "POST",
				async : false,
				url: "/free/account/getAirPayAjax.do",
				data: formData,
				dataType: "json",
				cache : false,
				noloading : "yes",
				timeOut : 5 * 60 * 1000,
				success: function(data) {
					result	=	data.paymentVo;
						
					$("#version").val(result.version);
					$("#mid").val(result.mId);
					$("#currency").val(result.currency);
					$("#timestamp").val(result.timeStamp);
					$("#signature").val(result.signature);
					$("#returnUrl").val(result.returnUrl); 
					$("#mKey").val(result.mKey);
					$("#offerPeriod").val(result.offerPeriod);
					$("#charset").val(result.charset);
					$("#closeUrl").val(result.closeUrl);
					$("#popupUrl").val(result.popupUrl);
					$("#quotabase").val(result.quotaBase);
					$("#oid").val(result.oId);
					$("#goodname").val("자유여행 항공결제[" + '${rsvFit.getFitRsvNo()}' + "]");
					
					submitform1.find("#P_MID").val(result.mId);
					submitform1.find("#P_NEXT_URL").val(result.returnUrl);
					submitform1.find("#P_OID").val(result.oId);
					submitform1.find("#P_GOODS").val("자유여행 항공결제[" + '${rsvFit.getFitRsvNo()}' + "]");
										
				},
				error : function(err) {
					alert("결제 요청 도중 오류가 발생하였습니다.");
					console.log(err);
				},
				complete : function(e) {
					console.log(e);
				}
			}); 

			var acceptmethod = 'va_receipt';
			$('#acceptmethod').val(acceptmethod); // 초기화
	
			// 현금영수증 미 발행 여부
			if (!$('input:checkbox[id="cashReceipt"]').is(":checked")) {
				acceptmethod = 'no_receipt';
			}
			$('#acceptmethod').val(acceptmethod);
			
			// 증빙 (가상계좌, 실시간 계좌이체)
            var proof = document.getElementsByName("RECEIPT_DIVI_GB1");
            for(var i=0;i< proof.length;i++){
                if(proof[i].checked){
                    if(proof[i].value == "002"){
        				var $bizRegNo1 = virtual_div.find('#CORP_NO01').val();
        				var $bizRegNo2 = virtual_div.find('#CORP_NO02').val();
        				var $bizRegNo3 = virtual_div.find('#CORP_NO03').val();
        	
        				if ($bizRegNo1.val() === '') {
        					alert('지출 증빙용 사업자 등록번호를 입력하세요.');
        					$bizRegNo1.focus();
        					return false;
        				}
        			
        				if ($bizRegNo2.val() === '') {
        					alert('지출 증빙용 사업자 등록번호를 입력하세요.');
        					$bizRegNo2.focus();
        					return false;
        				}
        			
        				if ($bizRegNo3.val() === '') {
        					alert('지출 증빙용 사업자 등록번호를 입력하세요.');
        					$bizRegNo3.focus();
        					return false;
        				}
        			
        				var bizRegNo = $bizRegNo1.val() + $bizRegNo2.val() + $bizRegNo3.val();
        				$('#vbankRegNo').val(bizRegNo);
						
						proofCheck	=	"002";
                    }else{
        				var ISSUE_HTEL = virtual_div.find('#ISSUE_HTEL').val();
        				if (ISSUE_HTEL === '') {
        					alert('스독공제 개인용 휴대폰 번호 또는 현금영수증 카드번호를 입력하세요.');
        					$cellCashCardNo1.focus();
        					return false;
        				}

        				$('#vbankRegNo').val(ISSUE_HTEL);
                    }
                    
                    break;
                }
           	}

			// ### 결제요청 정보 설정 ###
			console.log('paymentMethod', paymentMethod);
			console.log('buyerEmail', buyerEmail);
			console.log('payExpAmt', payAmtInfo.payExpAmt);
			console.log('buyerTel', buyerTel);

			var merchantDataVal	=	"";
			merchantDataVal	=	$('input[name="resCd"]').val();			//	예약번호
			if( proofCheck	== "002" ){
				merchantDataVal	=	merchantDataVal + "	" +  "1";								//	현금영수증타입(0:소득공제(소비자용), 1:지출증빙(사업자용))
			}else{
				merchantDataVal	=	merchantDataVal + "	" +  "0";								//	현금영수증타입(0:소득공제(소비자용), 1:지출증빙(사업자용))
			}
			merchantDataVal	=	merchantDataVal + "	" +  $('input[name="vbankRegNo"]').val();	//	현금영수증인증번호(핸드폰번호, 사업자등록번호)
			merchantDataVal	=	merchantDataVal + "	" +  virtual_div.find('#tasfAmt').val();	//	TASF_금액
			$('input[name="merchantData"]').val(merchantDataVal);
			submitform1.find("#P_NOTI").val(encodeURIComponent(merchantDataVal))
			
			// TODO: 테스트 코드 추후 제거 필요
			///////////////////////////////
			payAmtInfo.payExpAmt = virtual_div.find('#payment_air').text().replace(/,/gi, '');
			//payAmtInfo.payExpAmt = 1004;
			
			///////////////////////////////
			console.log("payAmtInfo.payExpAmt:" + payAmtInfo.payExpAmt);
			
			$('input[name="gopaymethod"]').val("VBank"); // 결제수단 (복합결제일 경우 신용카드 결제로)
			$('input[name="buyeremail"]').val(buyerEmail); // 구매자 이메일
			$('input[name="price"]').val(payAmtInfo.payExpAmt); // 총 			
			$('input[name="buyername"]').val(buyerName); // 구매자 명		  
			$('input[name="buyertel"]').val(buyerTel); // 구매자 전화번호
			
		  	submitform1.find("#P_UNAME").val(buyerName);			//	구매자명
		  	submitform1.find("#P_EMAIL").val(buyerEmail);			//	구매자 이메일
		  	submitform1.find("#P_AMT").val(payAmtInfo.payExpAmt);	//	총결제금액
		  	submitform1.find("#P_MOBILE").val(buyerTel);			//	구매자 핸드폰번호

			// 결제요청
			document.getElementById("form1").submit();
		}
		
		/* 
		var virtual_div = $('div[ft-att="virtual"]');
		var RECEIPT_DIVI_GB = '';
		var ISSUE_HTEL = '';
		var CORP_NO = '';
		var CORP_NO01 = '';
		var CORP_NO02 = '';
		var CORP_NO03 = '';
		var CASH_AMT = 0;
		var TASF_AMT = 0;
		var BANK_CD_GB = ''; // 은행 코드 GB
		var ACT_NO = ''; // 계좌번호 
		var ACT_PAYMTOR_NM = ''; // 계좌 입금자 명
		var PAYMT_CONF_YN = ''; // 입금 예정일자 
		var NOTE = ''; // 비고 
		var CASH_RECEIPT_DIVI_GB = ''; // 현금 영수증 구분 GB 
		var VIRTUAL_ACT_YN = ''; // 가상 계좌 여부 
		var TID_NO = ''; // TID_NO
		var REGTOR_ID = ''; // 등록자 ID 
		var REG_DTT = ''; // 등록일자 
		var MODTOR_ID = ''; // 수정자 ID 
		var MOD_DTT = ''; // 수정일자 
		var PAYMT_SCH_DT = '';

		RECEIPT_DIVI_GB = virtual_div.find('input:radio[name="RECEIPT_DIVI_GB1"]').filter(':checked').val();
		console.log("RECEIPT_DIVI_GB1 : " + RECEIPT_DIVI_GB);


		if(RECEIPT_DIVI_GB == '001') {
			ISSUE_HTEL = virtual_div.find('#ISSUE_HTEL').val();
		} else {
			CORP_NO01 = virtual_div.find('#CORP_NO01').val();
			CORP_NO02 = virtual_div.find('#CORP_NO02').val();
			CORP_NO03 = virtual_div.find('#CORP_NO03').val();
			CORP_NO = CORP_NO01 + "-" + CORP_NO02 + "-"+ CORP_NO03;
		}

		CORP_NO = CORP_NO01 + "-" + CORP_NO02 + "-" + CORP_NO03;
		CASH_AMT = virtual_div.find("#totalAmt").val();
		TASF_AMT = virtual_div.find("#tasfAmt").val();

		// 항공 결제요청 정보 저장 
		var airRsvForm = new FormData();
		airRsvForm.append('AIR_RSV_SEQNO', '${rsvAir.getAirRsvSeqno()}');
		airRsvForm.append('CASH_AMT', parseInt(CASH_AMT) + parseInt(TASF_AMT));
		airRsvForm.append('PAYMT_UNPAID_AMT',0);
		airRsvForm.append('TASF_AMT',TASF_AMT);
		airRsvForm.append('CARD_USE_YN','N');
		airRsvForm.append('CARD_ALL_YN', 'N');

		airRsvForm.append('ACT_USE_YN','Y');
		airRsvForm.append('GIFT_USE_YN','N');
		airRsvForm.append('ETC_USE_YN','N');
		airRsvForm.append('REGTOR_ID','');
		airRsvForm.append('REG_DTT','');
		airRsvForm.append('MODTOR_ID','');
		airRsvForm.append('MOD_DTT','');
		


		// 무통장입금 (가상계좌) 정보 저장 
		var virtualForm = new FormData();
		virtualForm.append('AIR_RSV_SEQNO', '${rsvAir.getAirRsvSeqno()}');
		virtualForm.append('CASH_AMT',parseInt(CASH_AMT) + parseInt(TASF_AMT));
		virtualForm.append('BANK_CD_GB',BANK_CD_GB);
		virtualForm.append('ACT_NO',ACT_NO);
		virtualForm.append('ACT_PAYMTOR_NM',ACT_PAYMTOR_NM);		
		virtualForm.append('PAYMT_SCH_DT',PAYMT_SCH_DT);
		virtualForm.append('NOTE',NOTE);
		virtualForm.append('CASH_RECEIPT_DIVI_GB',CASH_RECEIPT_DIVI_GB);
		virtualForm.append('PAYMT_CONF_YN','N');
		virtualForm.append('VIRTUAL_ACT_YN','Y');
		virtualForm.append('TID_NO',TID_NO);
		virtualForm.append('REGTOR_ID','');
		virtualForm.append('REG_DTT','');
		virtualForm.append('MODTOR_ID','');
		virtualForm.append('MOD_DTT','');
		if(RECEIPT_DIVI_GB == '') {
			alert("증빙서류 발급용도를 선택해 주세요.");
		} else {
			cfn_ajax({
				type: "POST",
				async: false,
				url: "/free/account/saveAirRsvPaymentAjax.do",
				data: airRsvForm,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
				},
				error:function(err){
					//console.log(err);
				},
				complete:function(){
					
				}
			});
					
			cfn_ajax({
				type: "POST",
				async: false,
				url: "/free/account/saveAirActPaymentAjax.do",
				data: virtualForm,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
				},
				error:function(err){
					//console.log(err);
					alert("저장되지 않았습니다.");
				},
				complete:function(){
					alert("저장되었습니다.");
				}
			});	
		}
 */
	}

	function payEtc1() { // 신용카드+현금 
		// 신용카드 정보 
		var card_div = $('div[ft-att="dual1"]');
		var card_all = card_div.find('div[ft-att="dual1ALL"]');
		var card_pax = card_div.find('div[ft-att="dual1PAX"]');
		
		var cardType = card_div.find('input:radio[name="cardType3"]').filter(':checked').val();
		console.log("cardType3 : " + cardType);
		var CARD_PAYMT_AMT = '';
		var TASF_AMT = '';
		var PAX_NO = '';
		var CARD_OWNER_GB = '';
		var CARD_OWNER_NM = '';
		var CARD_KI_GB = '';
		var CARD_NO = '';
		var CARD_NO1 = '';
		var CARD_NO2 = '';
		var CARD_NO3 = '';
		var CARD_NO4 = '';
		var CARD_EXPIR_DATE_MN = '';
		var CARD_EXPIR_DATE_YEAR = '';
		var CARD_INSTALLMN_MN = '';
		var FRONT_PASS = '';
		var CARD_CVS_NO = '';

		console.log("cardType : " + cardType);

		if(cardType == '01') {
			CARD_PAYMT_AMT = card_all.find("#totalAmt").val();
			TASF_AMT = card_all.find("#tasfAmt").val();
			PAX_NO = card_all.find("#PAX_NO").val();
			CARD_OWNER_GB = card_all.find('input[name="CARD_OWNER_GB3"]').filter(':checked').val();
			console.log("CARD_OWNER_GB3 : " + CARD_OWNER_GB);
			CARD_OWNER_NM = card_all.find("#CARD_OWNER_NM").val();
			// CARD_KI_GB = card_all.find("#select#CARD_KI_GB option:selected").val();
			CARD_KI_GB = card_all.find("select#CARD_KI_GB option:selected").val();
			CARD_NO1 = card_all.find("#CARD_NO01").val();
			CARD_NO2 = card_all.find("#CARD_NO02").val();
			CARD_NO3 = card_all.find("#CARD_NO03").val();
			CARD_NO4 = card_all.find("#CARD_NO04").val();
			CARD_NO = CARD_NO1 + CARD_NO2 + CARD_NO3 + CARD_NO4;
			CARD_EXPIR_DATE_MN = card_all.find("select#CARD_EXPIR_DATE_MN option:selected").val();
			CARD_EXPIR_DATE_YEAR = card_all.find("select#CARD_EXPIR_DATE_YEAR option:selected").val();
			CARD_INSTALLMN_MN = card_all.find("select#CARD_INSTALLMN_MN option:selected").val();
			FRONT_PASS = card_all.find("#FRONT_PASS").val();
			// CARD_CVS_NO = card_all.find("#CARD_CVS_NO").val();
		} else {
			CARD_PAYMT_AMT = card_pax.find("#totalAmt").val();
			TASF_AMT = card_pax.find("#tasfAmt").val();
			PAX_NO = card_pax.find("#PAX_NO").val();
			CARD_OWNER_GB = card_pax.find('input[name="CARD_OWNER_GB4"]').filter(':checked').val();
			console.log("CARD_OWNER_GB4 : " + CARD_OWNER_GB);
			CARD_OWNER_NM = card_pax.find("#CARD_OWNER_NM").val();
			CARD_KI_GB = card_pax.find("select#CARD_KI_GB option:selected").val();
			CARD_NO1 = card_pax.find("#CARD_NO01").val();
			CARD_NO2 = card_pax.find("#CARD_NO02").val();
			CARD_NO3 = card_pax.find("#CARD_NO03").val();
			CARD_NO4 = card_pax.find("#CARD_NO04").val();
			CARD_NO = CARD_NO1 + CARD_NO2 + CARD_NO3 + CARD_NO4;
			CARD_EXPIR_DATE_MN = card_pax.find("select#CARD_EXPIR_DATE_MN option:selected").val();
			CARD_EXPIR_DATE_YEAR = card_pax.find("select#CARD_EXPIR_DATE_YEAR option:selected").val();
			CARD_INSTALLMN_MN = card_pax.find("select#CARD_INSTALLMN_MN option:selected").val();
			FRONT_PASS = card_pax.find("#FRONT_PASS").val();
			// CARD_CVS_NO = card_pax.find("#CARD_CVS_NO").val();
		}
	
		var paxCnt = <%=rsvAirPaxList.size()%>;
		
		// if(CARD_OWNER_GB == 'undefined') 
		CARD_OWNER_GB = '001';
		console.log("CARD_OWNER_GB : " + CARD_OWNER_GB);
		console.log("CARD_KI_GB : " + CARD_KI_GB);
		
		// 항공 결제요청 정보 저장 
		var airRsvForm = new FormData();
		airRsvForm.append('AIR_RSV_SEQNO', '${rsvAir.getAirRsvSeqno()}');
		airRsvForm.append('PAYMT_APPROVE_AMT', parseInt(CARD_PAYMT_AMT) + parseInt(TASF_AMT));
		airRsvForm.append('PAYMT_UNPAID_AMT',0);
		airRsvForm.append('TASF_AMT',TASF_AMT);
		airRsvForm.append('CARD_USE_YN','Y');
		airRsvForm.append('CARD_ALL_YN', 'Y');

		airRsvForm.append('ACT_USE_YN','N');
		airRsvForm.append('GIFT_USE_YN','N');
		airRsvForm.append('ETC_USE_YN','N');
		airRsvForm.append('REGTOR_ID','');
		airRsvForm.append('REG_DTT','');
		airRsvForm.append('MODTOR_ID','');
		airRsvForm.append('MOD_DTT','');
		


		// 카드 결제 정보  저장 
		var cardPayForm = new FormData();
		cardPayForm.append('AIR_RSV_SEQNO', '${rsvAir.getAirRsvSeqno()}');
		cardPayForm.append('CARD_PAYMT_AMT',CARD_PAYMT_AMT);
		cardPayForm.append('TASF_AMT',TASF_AMT);
		cardPayForm.append('CARD_OWNER_GB',CARD_OWNER_GB);
		cardPayForm.append('CARD_OWNER_NM',CARD_OWNER_NM);		
		cardPayForm.append('CARD_KI_GB',CARD_KI_GB);
		cardPayForm.append('CARD_NO',CARD_NO);
		cardPayForm.append('CARD_EXPIR_DATE_MN',CARD_EXPIR_DATE_MN);
		cardPayForm.append('CARD_EXPIR_DATE_YEAR',CARD_EXPIR_DATE_YEAR);
		cardPayForm.append('CARD_INSTALLMN_MN',CARD_INSTALLMN_MN);
		cardPayForm.append('FRONT_PASS',FRONT_PASS);
		// cardPayForm.append("CARD_CVS_NO", CARD_CVS_NO);
		cardPayForm.append("CARD_RELAT_GB", '');
		cardPayForm.append('REGTOR_ID','');
		cardPayForm.append('REG_DTT','');
		cardPayForm.append('MODTOR_ID','');
		cardPayForm.append('MOD_DTT','');


		if(cardType == '01') {
			cardPayForm.append('PAX_NO', '0');
		} else {
			if(paxCnt > 1) {
				var PAX_NO1 = card_div.find("#PAX_NO1").val();
				cardPayForm.append('PAX_NO', PAX_NO1);
			}
		}
		cardPayForm.append('APPROVE_CONF_YN', 'N');
		cardPayForm.append('CARD_CVS_NO', '');



		var RECEIPT_DIVI_GB = '';
		var ISSUE_HTEL = '';
		var CORP_NO = '';
		var CORP_NO01 = '';
		var CORP_NO02 = '';
		var CORP_NO03 = '';
		var CASH_AMT = 0;
		
		var BANK_CD_GB = ''; 		// 은행 코드 GB
		var ACT_NO = ''; 			// 계좌번호 
		var ACT_PAYMTOR_NM = ''; 	// 계좌 입금자 명
		var PAYMT_SCH_DT = ''; 		// 입금 예정 일자 
		var PAYMT_CONF_YN = ''; 	// 입금 확인 여부 
		var NOTE = ''; 				// 비고 
		var CASH_RECEIPT_DIVI_GB = ''; // 현금 영수증 구분 GB 
		var VIRTUAL_ACT_YN = ''; 	// 가상 계좌 여부 
		var TID_NO = ''; 			// TID_NO
		
		BANK_CD_GB 				= card_div.find("select#bankforvbank option:selected").val(); 		// 은행 코드 GB
		ACT_NO 					= card_div.find('#ACT_NO').val(); 			// 계좌번호 
		ACT_PAYMTOR_NM 			= card_div.find('#ACT_PAYMTOR_NM').val(); 	// 계좌 입금자 명
		PAYMT_SCH_DT 			= card_div.find('#PAYMT_SCH_DT').val(); 		// 입금 예정 일자 
		PAYMT_CONF_YN 			= 'N'; 	// 입금 확인 여부 
		NOTE 					= ''; 				// 비고 
		CASH_RECEIPT_DIVI_GB 	= ''; // 현금 영수증 구분 GB 
		VIRTUAL_ACT_YN 			= 'Y'; 	// 가상 계좌 여부 
		TID_NO 					= card_div.find('#TID_NO').val(); 			// TID_NO
		
		// RECEIPT_DIVI_GB = card_all.find('input[name="RECEIPT_DIVI_GB"]:checked').val();
		RECEIPT_DIVI_GB = card_all.find('input:radio[name="RECEIPT_DIVI_GB2"]').filter(':checked').val();
		CASH_RECEIPT_DIVI_GB = RECEIPT_DIVI_GB;
		
		console.log("RECEIPT_DIVI_GB2 : " + RECEIPT_DIVI_GB);

		if(RECEIPT_DIVI_GB == '001') {
			ISSUE_HTEL = card_all.find('#ISSUE_HTEL').val();
		} else {
			CORP_NO01 = card_all.find('#CORP_NO01').val();
			CORP_NO02 = card_all.find('#CORP_NO02').val();
			CORP_NO03 = card_all.find('#CORP_NO03').val();
			CORP_NO = CORP_NO01 + "-" + CORP_NO02 + "-"+ CORP_NO03;
		}
		
		CASH_AMT = CARD_PAYMT_AMT;

		// 소득 공제용 영수증 제공 
		var receiptForm = new FormData();
		receiptForm.append('AIR_RSV_SEQNO', '${rsvAir.getAirRsvSeqno()}');
		receiptForm.append('RECEIPT_DIVI_GB',RECEIPT_DIVI_GB);
		receiptForm.append('ISSUE_HTEL',ISSUE_HTEL);
		receiptForm.append('CORP_NO',CORP_NO);
		receiptForm.append('REGTOR_ID','');
		receiptForm.append('REG_DTT','');
		receiptForm.append('MODTOR_ID','');
		receiptForm.append('MOD_DTT','');

		if(CARD_OWNER_GB == '') {
			alert("카드소유를 선택해 주세요.");
		} else if(CARD_OWNER_NM == '') {
			alert("소유자명을 입력해 주세요.");
		} else if(CARD_KI_GB == '') {
			alert("카드 선택을 해주세요.");
		} else if(CARD_NO == '') {
			alert("카드 번호를 입력해 주세요.");		
		} else if(CARD_EXPIR_DATE_MN == '' || CARD_EXPIR_DATE_YEAR == '') {
			alert("유효 기간을 선택해 주세요.");								
		} else if(CARD_INSTALLMN_MN == '') {
			alert("할부 기간을 선택해 주세요.");		
		/**
		} else if(CARD_CVS_NO == '') {
			alert("카드 CVS2 번호를 입력해 주세요.");					
		**/
		}  else if(FRONT_PASS == '') {
			alert("비밀번호를 입력해 주세요.");					
		} else {
			cfn_ajax({
				type: "POST",
				async: false,
				url: "/free/account/saveAirRsvPaymentAjax.do",
				data: airRsvForm,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
				},
				error:function(err){
					//console.log(err);
				},
				complete:function(){
					
				}
			});
					
			cfn_ajax({
				type: "POST",
				async: false,
				url: "/free/account/saveAirCardPaymentAjax.do",
				data: cardPayForm,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
				},
				error:function(err){
					//console.log(err);
				},
				complete:function(){
					
				}
			});

			cfn_ajax({
				type: "POST",
				async: false,
				url: "/free/account/saveAirReceiptReqAjax.do",
				data: receiptForm,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
				},
				error:function(err){
					//console.log(err);
					alert("저장되지 않았습니다.");
				},
				complete:function(){
					alert("저장되었습니다.");
				}
			});
		}
	}

	function payEtc2() { // 복합결제
		var dual2_div = $('div[ft-att="dual2"]');
		var card_all = dual2_div.find('div[ft-att="dual2ALL"]')
		var card_pax = dual2_div.find('div[ft-att="dual1PAX"]');

		var cardType = dual2_div.find('input:radio[name="cardType4"]').filter(':checked').val();
		console.log("cardType4 : " + cardType);

		var CARD_PAYMT_AMT = '';
		var TASF_AMT = '';
		var PAX_NO = '';
		var CARD_OWNER_GB = '';
		var CARD_OWNER_NM = '';
		var CARD_KI_GB = '';
		var CARD_NO = '';
		var CARD_NO1 = '';
		var CARD_NO2 = '';
		var CARD_NO3 = '';
		var CARD_NO4 = '';
		var CARD_EXPIR_DATE_MN = '';
		var CARD_EXPIR_DATE_YEAR = '';
		var CARD_INSTALLMN_MN = '';
		var FRONT_PASS = '';
		var CARD_CVS_NO = '';


		if(cardType == '01') {
			CARD_PAYMT_AMT = card_all.find("#totalAmt").val();
			TASF_AMT = card_all.find("#tasfAmt").val();
			PAX_NO = card_all.find("#PAX_NO").val();
			CARD_OWNER_GB = card_all.find('input:radio[name="CARD_OWNER_GB5"]').filter(':checked').val();
			console.log("CARD_OWNER_GB5 : " + CARD_OWNER_GB);

			CARD_OWNER_NM = card_all.find("#CARD_OWNER_NM").val();
			// CARD_KI_GB = card_all.find("#select#CARD_KI_GB option:selected").val();
			CARD_KI_GB = card_all.find("select#CARD_KI_GB option:selected").val();
			CARD_NO1 = card_all.find("#CARD_NO01").val();
			CARD_NO2 = card_all.find("#CARD_NO02").val();
			CARD_NO3 = card_all.find("#CARD_NO03").val();
			CARD_NO4 = card_all.find("#CARD_NO04").val();
			CARD_NO = CARD_NO1 + CARD_NO2 + CARD_NO3 + CARD_NO4;
			CARD_EXPIR_DATE_MN = card_all.find("select#CARD_EXPIR_DATE_MN option:selected").val();
			CARD_EXPIR_DATE_YEAR = card_all.find("select#CARD_EXPIR_DATE_YEAR option:selected").val();
			CARD_INSTALLMN_MN = card_all.find("select#CARD_INSTALLMN_MN option:selected").val();
			FRONT_PASS = card_all.find("#FRONT_PASS").val();
			// CARD_CVS_NO = card_all.find("#CARD_CVS_NO").val();
		} else {
			CARD_PAYMT_AMT = card_pax.find("#totalAmt").val();
			TASF_AMT = card_pax.find("#tasfAmt").val();
			PAX_NO = card_pax.find("#PAX_NO").val();
			CARD_OWNER_GB = card_pax.find('input:radio[name="CARD_OWNER_GB6"]').filter(':checked').val();
			console.log("CARD_OWNER_GB6 : " + CARD_OWNER_GB);
			CARD_OWNER_NM = card_pax.find("#CARD_OWNER_NM").val();
			CARD_KI_GB = card_pax.find("select#CARD_KI_GB option:selected").val();
			CARD_NO1 = card_pax.find("#CARD_NO01").val();
			CARD_NO2 = card_pax.find("#CARD_NO02").val();
			CARD_NO3 = card_pax.find("#CARD_NO03").val();
			CARD_NO4 = card_pax.find("#CARD_NO04").val();
			CARD_NO = CARD_NO1 + CARD_NO2 + CARD_NO3 + CARD_NO4;
			CARD_EXPIR_DATE_MN = card_pax.find("select#CARD_EXPIR_DATE_MN option:selected").val();
			CARD_EXPIR_DATE_YEAR = card_pax.find("select#CARD_EXPIR_DATE_YEAR option:selected").val();
			CARD_INSTALLMN_MN = card_pax.find("select#CARD_INSTALLMN_MN option:selected").val();
			FRONT_PASS = card_pax.find("#FRONT_PASS").val();
			// CARD_CVS_NO = card_pax.find("#CARD_CVS_NO").val();
		}
	
		var paxCnt = <%=rsvAirPaxList.size()%>;
		// if(CARD_OWNER_GB == 'undefined') 
		CARD_OWNER_GB = '001';
		console.log("CARD_OWNER_GB : " + CARD_OWNER_GB);
		console.log("CARD_KI_GB : " + CARD_KI_GB);
		
		// 항공 결제요청 정보 저장 
		var airRsvForm = new FormData();
		airRsvForm.append('AIR_RSV_SEQNO', '${rsvAir.getAirRsvSeqno()}');
		airRsvForm.append('PAYMT_APPROVE_AMT', parseInt(CARD_PAYMT_AMT) + parseInt(TASF_AMT));
		airRsvForm.append('PAYMT_UNPAID_AMT',0);
		airRsvForm.append('TASF_AMT',TASF_AMT);
		airRsvForm.append('CARD_USE_YN','Y');
		airRsvForm.append('CARD_ALL_YN', 'Y');

		airRsvForm.append('ACT_USE_YN','N');
		airRsvForm.append('GIFT_USE_YN','N');
		airRsvForm.append('ETC_USE_YN','N');
		airRsvForm.append('REGTOR_ID','');
		airRsvForm.append('REG_DTT','');
		airRsvForm.append('MODTOR_ID','');
		airRsvForm.append('MOD_DTT','');
		


		// 카드 결제 정보  저장 
		var cardPayForm = new FormData();
		cardPayForm.append('AIR_RSV_SEQNO', '${rsvAir.getAirRsvSeqno()}');
		cardPayForm.append('CARD_PAYMT_AMT',CARD_PAYMT_AMT);
		cardPayForm.append('TASF_AMT',TASF_AMT);
		cardPayForm.append('CARD_OWNER_GB',CARD_OWNER_GB);
		cardPayForm.append('CARD_OWNER_NM',CARD_OWNER_NM);		
		cardPayForm.append('CARD_KI_GB',CARD_KI_GB);
		cardPayForm.append('CARD_NO',CARD_NO);
		cardPayForm.append('CARD_EXPIR_DATE_MN',CARD_EXPIR_DATE_MN);
		cardPayForm.append('CARD_EXPIR_DATE_YEAR',CARD_EXPIR_DATE_YEAR);
		cardPayForm.append('CARD_INSTALLMN_MN',CARD_INSTALLMN_MN);
		cardPayForm.append('FRONT_PASS',FRONT_PASS);
		// cardPayForm.append("CARD_CVS_NO", CARD_CVS_NO);
		cardPayForm.append("CARD_RELAT_GB", '');
		cardPayForm.append('REGTOR_ID','');
		cardPayForm.append('REG_DTT','');
		cardPayForm.append('MODTOR_ID','');
		cardPayForm.append('MOD_DTT','');


		if(cardType == '01') {
			cardPayForm.append('PAX_NO', '0');
		} else {
			if(paxCnt > 1) {
				var PAX_NO1 = card_div.find("#PAX_NO1").val();
				cardPayForm.append('PAX_NO', PAX_NO1);
			}
		}
		cardPayForm.append('APPROVE_CONF_YN', 'N');
		cardPayForm.append('CARD_CVS_NO', '');


		
		// 상품권 정보 
		var AIR_RSV_SEQNO = '${rsvAir.getAirRsvSeqno()}';

		var GIFT_DIVI_GB1 = '';
		var GIFT_DIVI_GB2 = '';
		var GIFT_DIVI_GB3 = '';
		var GIFT_DIVI_GB4 = '';
		var GIFT_DIVI_GB5 = '';
		var GIFT_DIVI_GB6 = '';
		var GIFT_DIVI_GB7 = '';
		var GIFT_DIVI_GB8 = '';
		var GIFT_DIVI_GB9 = '';
		var GIFT_DIVI_GB10 = '';

		var GIFT_NO1 = '';
		var GIFT_NO2 = '';
		var GIFT_NO3 = '';
		var GIFT_NO4 = '';
		var GIFT_NO5 = '';
		var GIFT_NO6 = '';
		var GIFT_NO7 = '';
		var GIFT_NO8 = '';
		var GIFT_NO9 = '';
		var GIFT_NO10 = '';

		var GIFT_AMT1 = 0;
		var GIFT_AMT2 = 0;
		var GIFT_AMT3 = 0;
		var GIFT_AMT4 = 0;
		var GIFT_AMT5 = 0;
		var GIFT_AMT6 = 0;
		var GIFT_AMT7 = 0;
		var GIFT_AMT8 = 0;
		var GIFT_AMT9 = 0;
		var GIFT_AMT10 = 0;

		var GIFT_RECP_YN1 = 'Y';
		var GIFT_RECP_YN2 = 'Y';
		var GIFT_RECP_YN3 = 'Y';
		var GIFT_RECP_YN4 = 'Y';
		var GIFT_RECP_YN5 = 'Y';
		var GIFT_RECP_YN6 = 'Y';
		var GIFT_RECP_YN7 = 'Y';
		var GIFT_RECP_YN8 = 'Y';
		var GIFT_RECP_YN9 = 'Y';
		var GIFT_RECP_YN10 = 'Y';
		
		var NOTE1 = '';
		var NOTE2 = '';
		var NOTE3 = '';
		var NOTE4 = '';
		var NOTE5 = '';
		var NOTE6 = '';
		var NOTE7 = '';
		var NOTE8 = '';
		var NOTE9 = '';
		var NOTE10 = '';

		var REGTOR_ID = '';
		var REG_DTT = '';
		var MODTOR_ID = '';
		var MOD_DTT = '';
		
		
		
		GIFT_DIVI_GB1 = dual2_div.find("select#GIFT_DIVI_GB1 option:selected").val();
		GIFT_AMT1 = dual2_div.find("#GIFT_AMT1").val();
		GIFT_NO1 = dual2_div.find("#GIFT_NO1").val();

		if(giftNo > 1) {
			GIFT_DIVI_GB2 = dual2_div.find("select#GIFT_DIVI_GB2 option:selected").val();
			GIFT_AMT2 = dual2_div.find("#GIFT_AMT2").val();
			GIFT_NO2 = dual2_div.find("#GIFT_NO2").val();		
		}

		if(giftNo > 2) {
			GIFT_DIVI_GB3 = dual2_div.find("select#GIFT_DIVI_GB3 option:selected").val();
			GIFT_AMT3 = dual2_div.find("#GIFT_AMT3").val();
			GIFT_NO3 = dual2_div.find("#GIFT_NO3").val();		
		}

		if(giftNo > 3) {
			GIFT_DIVI_GB4 = dual2_div.find("select#GIFT_DIVI_GB4 option:selected").val();
			GIFT_AMT4 = dual2_div.find("#GIFT_AMT4").val();
			GIFT_NO4 = dual2_div.find("#GIFT_NO4").val();		
		}

		if(giftNo > 4) {
			GIFT_DIVI_GB5 = dual2_div.find("select#GIFT_DIVI_GB5 option:selected").val();
			GIFT_AMT5 = dual2_div.find("#GIFT_AMT5").val();
			GIFT_NO5 = dual2_div.find("#GIFT_NO5").val();		
		}

		if(giftNo > 5) {
			GIFT_DIVI_GB6 = dual2_div.find("select#GIFT_DIVI_GB6 option:selected").val();
			GIFT_AMT6 = dual2_div.find("#GIFT_AMT6").val();
			GIFT_NO6 = dual2_div.find("#GIFT_NO6").val();		
		}

		if(giftNo > 6) {
			GIFT_DIVI_GB7 = dual2_div.find("select#GIFT_DIVI_GB7 option:selected").val();
			GIFT_AMT7 = dual2_div.find("#GIFT_AMT7").val();
			GIFT_NO7 = dual2_div.find("#GIFT_NO7").val();		
		}

		if(giftNo > 7) {
			GIFT_DIVI_GB8 = dual2_div.find("select#GIFT_DIVI_GB8 option:selected").val();
			GIFT_AMT8 = dual2_div.find("#GIFT_AMT8").val();
			GIFT_NO8 = dual2_div.find("#GIFT_NO8").val();		
		}

		if(giftNo > 8) {
			GIFT_DIVI_GB9 = dual2_div.find("select#GIFT_DIVI_GB9 option:selected").val();
			GIFT_AMT9 = dual2_div.find("#GIFT_AMT9").val();
			GIFT_NO9 = dual2_div.find("#GIFT_NO9").val();		
		}	

		if(giftNo > 9) {
			GIFT_DIVI_GB10 = dual2_div.find("select#GIFT_DIVI_GB10 option:selected").val();
			GIFT_AMT10 = dual2_div.find("#GIFT_AMT10").val();
			GIFT_NO10 = dual2_div.find("#GIFT_NO10").val();		
		}		

		var giftForm = new FormData();
		giftForm.append('AIR_RSV_SEQNO', '${rsvAir.getAirRsvSeqno()}');
		giftForm.append('giftSeq', giftNo);

		giftForm.append('GIFT_DIVI_GB1', GIFT_DIVI_GB1);
		giftForm.append('GIFT_AMT1', GIFT_AMT1);
		giftForm.append('GIFT_NO1', GIFT_NO1);
		giftForm.append('GIFT_RECP_YN1', GIFT_RECP_YN1);			

		giftForm.append('GIFT_DIVI_GB2', GIFT_DIVI_GB2);
		giftForm.append('GIFT_AMT2', GIFT_AMT2);
		giftForm.append('GIFT_NO2', GIFT_NO2);
		giftForm.append('GIFT_RECP_YN2', GIFT_RECP_YN2);			

		giftForm.append('GIFT_DIVI_GB3', GIFT_DIVI_GB3);
		giftForm.append('GIFT_AMT3', GIFT_AMT3);
		giftForm.append('GIFT_NO3', GIFT_NO3);
		giftForm.append('GIFT_RECP_YN3', GIFT_RECP_YN3);			

		giftForm.append('GIFT_DIVI_GB4', GIFT_DIVI_GB4);
		giftForm.append('GIFT_AMT4', GIFT_AMT4);
		giftForm.append('GIFT_NO4', GIFT_NO4);	
		giftForm.append('GIFT_RECP_YN4', GIFT_RECP_YN4);			

		giftForm.append('GIFT_DIVI_GB5', GIFT_DIVI_GB5);
		giftForm.append('GIFT_AMT5', GIFT_AMT5);
		giftForm.append('GIFT_NO5', GIFT_NO5);		
		giftForm.append('GIFT_RECP_YN5', GIFT_RECP_YN5);			

		giftForm.append('GIFT_DIVI_GB6', GIFT_DIVI_GB6);
		giftForm.append('GIFT_AMT6', GIFT_AMT6);
		giftForm.append('GIFT_NO6', GIFT_NO6);		
		giftForm.append('GIFT_RECP_YN6', GIFT_RECP_YN6);			

		giftForm.append('GIFT_DIVI_GB7', GIFT_DIVI_GB7);
		giftForm.append('GIFT_AMT7', GIFT_AMT7);
		giftForm.append('GIFT_NO7', GIFT_NO7);		
		giftForm.append('GIFT_RECP_YN7', GIFT_RECP_YN7);			

		giftForm.append('GIFT_DIVI_GB8', GIFT_DIVI_GB8);
		giftForm.append('GIFT_AMT8', GIFT_AMT8);
		giftForm.append('GIFT_NO8', GIFT_NO8);		
		giftForm.append('GIFT_RECP_YN8', GIFT_RECP_YN8);			

		giftForm.append('GIFT_DIVI_GB9', GIFT_DIVI_GB9);
		giftForm.append('GIFT_AMT9', GIFT_AMT9);
		giftForm.append('GIFT_NO9', GIFT_NO9);	
		giftForm.append('GIFT_RECP_YN9', GIFT_RECP_YN9);			

		giftForm.append('GIFT_DIVI_GB10', GIFT_DIVI_GB10);
		giftForm.append('GIFT_AMT10', GIFT_AMT10);
		giftForm.append('GIFT_NO10', GIFT_NO10);
		giftForm.append('GIFT_RECP_YN10', GIFT_RECP_YN10);			
		

		
		var RECEIPT_DIVI_GB = '';
		var ISSUE_HTEL = '';
		var CORP_NO = '';
		var CORP_NO01 = '';
		var CORP_NO02 = '';
		var CORP_NO03 = '';
		var CASH_AMT = 0;
		var TASF_AMT = 0;
		var BANK_CD_GB = ''; // 은행 코드 GB
		var ACT_NO = ''; // 계좌번호 
		var ACT_PAYMTOR_NM = ''; // 계좌 입금자 명
		var PAYMT_CONF_YN = ''; // 입금 예정일자 
		var NOTE = ''; // 비고 
		var CASH_RECEIPT_DIVI_GB = ''; // 현금 영수증 구분 GB 
		var VIRTUAL_ACT_YN = ''; // 가상 계좌 여부 
		var TID_NO = ''; // TID_NO
		var REGTOR_ID = ''; // 등록자 ID 
		var REG_DTT = ''; // 등록일자 
		var MODTOR_ID = ''; // 수정자 ID 
		var MOD_DTT = ''; // 수정일자 

		BANK_CD_GB 				= dual2_div.find("select#bankforvbank option:selected").val(); 		// 은행 코드 GB
		ACT_NO 					= dual2_div.find('#ACT_NO').val(); 			// 계좌번호 
		ACT_PAYMTOR_NM 			= dual2_div.find('#ACT_PAYMTOR_NM').val(); 	// 계좌 입금자 명
		PAYMT_SCH_DT 			= dual2_div.find('#PAYMT_SCH_DT').val(); 		// 입금 예정 일자 
		PAYMT_CONF_YN 			= 'N'; 	// 입금 확인 여부 
		NOTE 					= ''; 				// 비고 
		CASH_RECEIPT_DIVI_GB 	= ''; // 현금 영수증 구분 GB 
		VIRTUAL_ACT_YN 			= 'Y'; 	// 가상 계좌 여부 
		TID_NO 					= dual2_div.find('#TID_NO').val(); 			// TID_NO
		
		RECEIPT_DIVI_GB = dual2_div.find('input:radio[name="RECEIPT_DIVI_GB3"]').val();
		console.log("RECEIPT_DIVI_GB3 : " + RECEIPT_DIVI_GB);
		if(RECEIPT_DIVI_GB == '001') {
			ISSUE_HTEL = dual2_div.find('#ISSUE_HTEL').val();
		} else {
			CORP_NO01 = dual2_div.find('#CORP_NO01').val();
			CORP_NO02 = dual2_div.find('#CORP_NO02').val();
			CORP_NO03 = dual2_div.find('#CORP_NO03').val();
			CORP_NO = CORP_NO01 + "-" + CORP_NO02 + "-" + CORP_NO03;
		}
		
		CASH_AMT = dual2_div.find("#totalAmt").val();
		TASF_AMT = dual2_div.find("#tasfAmt").val();

		// 무통장입금 (가상계좌) 정보 저장 
		var virtualForm = new FormData();
		virtualForm.append('AIR_RSV_SEQNO', '${rsvAir.getAirRsvSeqno()}');
		virtualForm.append('CASH_AMT',parseInt(CASH_AMT) + parseInt(TASF_AMT));
		virtualForm.append('BANK_CD_GB',BANK_CD_GB);
		virtualForm.append('ACT_NO',ACT_NO);
		virtualForm.append('ACT_PAYMTOR_NM',ACT_PAYMTOR_NM);		
		virtualForm.append('PAYMT_SCH_DT',PAYMT_SCH_DT);
		virtualForm.append('NOTE',NOTE);
		virtualForm.append('CASH_RECEIPT_DIVI_GB',CASH_RECEIPT_DIVI_GB);
		virtualForm.append('PAYMT_CONF_YN','N');
		virtualForm.append('VIRTUAL_ACT_YN','Y');
		virtualForm.append('TID_NO',TID_NO);
		virtualForm.append('REGTOR_ID','');
		virtualForm.append('REG_DTT','');
		virtualForm.append('MODTOR_ID','');
		virtualForm.append('MOD_DTT','');


		CASH_AMT = CARD_PAYMT_AMT;

		// 소득 공제용 자료 제공 
		var receiptForm = new FormData();
		receiptForm.append('AIR_RSV_SEQNO', '${rsvAir.getAirRsvSeqno()}');
		receiptForm.append('RECEIPT_DIVI_GB',RECEIPT_DIVI_GB);
		receiptForm.append('ISSUE_HTEL',ISSUE_HTEL);
		receiptForm.append('CORP_NO',CORP_NO);
		receiptForm.append('REGTOR_ID','');
		receiptForm.append('REG_DTT','');
		receiptForm.append('MODTOR_ID','');
		receiptForm.append('MOD_DTT','');


		if(CARD_OWNER_GB == '') {
			alert("카드소유를 선택해 주세요.");
		} else if(CARD_OWNER_NM == '') {
			alert("소유자명을 입력해 주세요.");
		} else if(CARD_KI_GB == '') {
			alert("카드 선택을 해주세요.");
		} else if(CARD_NO == '') {
			alert("카드 번호를 입력해 주세요.");		
		} else if(CARD_EXPIR_DATE_MN == '' || CARD_EXPIR_DATE_YEAR == '') {
			alert("유효 기간을 선택해 주세요.");								
		} else if(CARD_INSTALLMN_MN == '') {
			alert("할부 기간을 선택해 주세요.");		
/**		
		} else if(CARD_CVS_NO == '') {
			alert("카드 CVS2 번호를 입력해 주세요.");					
**/		
		}  else if(FRONT_PASS == '') {
			alert("비밀번호를 입력해 주세요.");					
		} else {
			cfn_ajax({
				type: "POST",
				async: false,
				url: "/free/account/saveAirRsvPaymentAjax.do",
				data: airRsvForm,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
				},
				error:function(err){
					//console.log(err);
				},
				complete:function(){
					
				}
			});
			
			cfn_ajax({
				type: "POST",
				async: false,
				url: "/free/account/saveAirCardPaymentAjax.do",
				data: cardPayForm,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
				},
				error:function(err){
					//console.log(err);
				},
				complete:function(){
					
				}
			});

			
			cfn_ajax({
				type: "POST",
				async: false,
				url: "/free/account/saveAirGiftPaymentAjax.do",
				data: giftForm,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
				},
				error:function(err){
					//console.log(err);
				},
				complete:function(){
					// alert("저장되었습니다.");
				}
			});

			cfn_ajax({
				type: "POST",
				async: false,
				url: "/free/account/saveAirActPaymentAjax.do",
				data: virtualForm,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
				},
				error:function(err){
					//console.log(err);
				},
				complete:function(){
					
				}
			});		

			cfn_ajax({
				type: "POST",
				async: false,
				url: "/free/account/saveAirReceiptReqAjax.do",
				data: receiptForm,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
				},
				error:function(err){
					//console.log(err);
					alert("저장되지 않았습니다.");
				},
				complete:function(){
					alert("저장되었습니다.");
				}
			});
		}
	}

	function payGift() { // 상품권 
		// 상품권 정보 
		var AIR_RSV_SEQNO = '${rsvAir.getAirRsvSeqno()}';

		var GIFT_DIVI_GB1 = '';
		var GIFT_DIVI_GB2 = '';
		var GIFT_DIVI_GB3 = '';
		var GIFT_DIVI_GB4 = '';
		var GIFT_DIVI_GB5 = '';
		var GIFT_DIVI_GB6 = '';
		var GIFT_DIVI_GB7 = '';
		var GIFT_DIVI_GB8 = '';
		var GIFT_DIVI_GB9 = '';
		var GIFT_DIVI_GB10 = '';

		var GIFT_NO1 = '';
		var GIFT_NO2 = '';
		var GIFT_NO3 = '';
		var GIFT_NO4 = '';
		var GIFT_NO5 = '';
		var GIFT_NO6 = '';
		var GIFT_NO7 = '';
		var GIFT_NO8 = '';
		var GIFT_NO9 = '';
		var GIFT_NO10 = '';

		var GIFT_AMT1 = 0;
		var GIFT_AMT2 = 0;
		var GIFT_AMT3 = 0;
		var GIFT_AMT4 = 0;
		var GIFT_AMT5 = 0;
		var GIFT_AMT6 = 0;
		var GIFT_AMT7 = 0;
		var GIFT_AMT8 = 0;
		var GIFT_AMT9 = 0;
		var GIFT_AMT10 = 0;

		var GIFT_RECP_YN1 = 'Y';
		var GIFT_RECP_YN2 = 'Y';
		var GIFT_RECP_YN3 = 'Y';
		var GIFT_RECP_YN4 = 'Y';
		var GIFT_RECP_YN5 = 'Y';
		var GIFT_RECP_YN6 = 'Y';
		var GIFT_RECP_YN7 = 'Y';
		var GIFT_RECP_YN8 = 'Y';
		var GIFT_RECP_YN9 = 'Y';
		var GIFT_RECP_YN10 = 'Y';
		
		var NOTE1 = '';
		var NOTE2 = '';
		var NOTE3 = '';
		var NOTE4 = '';
		var NOTE5 = '';
		var NOTE6 = '';
		var NOTE7 = '';
		var NOTE8 = '';
		var NOTE9 = '';
		var NOTE10 = '';

		var REGTOR_ID = '';
		var REG_DTT = '';
		var MODTOR_ID = '';
		var MOD_DTT = '';
		
		var gift_div = $('div[ft-att="gift"]');
		
		GIFT_DIVI_GB1 = gift_div.find("select#GIFT_DIVI_GB1 option:selected").val();
		GIFT_AMT1 = gift_div.find("#GIFT_AMT1").val();
		GIFT_NO1 = gift_div.find("#GIFT_NO1").val();

		if(giftNo2 > 1) {
			GIFT_DIVI_GB2 = gift_div.find("select#GIFT_DIVI_GB2 option:selected").val();
			GIFT_AMT2 = gift_div.find("#GIFT_AMT2").val();
			GIFT_NO2 = gift_div.find("#GIFT_NO2").val();		
		}

		if(giftNo2 > 2) {
			GIFT_DIVI_GB3 = gift_div.find("select#GIFT_DIVI_GB3 option:selected").val();
			GIFT_AMT3 = gift_div.find("#GIFT_AMT3").val();
			GIFT_NO3 = gift_div.find("#GIFT_NO3").val();		
		}

		if(giftNo2 > 3) {
			GIFT_DIVI_GB4 = gift_div.find("select#GIFT_DIVI_GB4 option:selected").val();
			GIFT_AMT4 = gift_div.find("#GIFT_AMT4").val();
			GIFT_NO4 = gift_div.find("#GIFT_NO4").val();		
		}

		if(giftNo2 > 4) {
			GIFT_DIVI_GB5 = gift_div.find("select#GIFT_DIVI_GB5 option:selected").val();
			GIFT_AMT5 = gift_div.find("#GIFT_AMT5").val();
			GIFT_NO5 = gift_div.find("#GIFT_NO5").val();		
		}

		if(giftNo2 > 5) {
			GIFT_DIVI_GB6 = gift_div.find("select#GIFT_DIVI_GB6 option:selected").val();
			GIFT_AMT6 = gift_div.find("#GIFT_AMT6").val();
			GIFT_NO6 = gift_div.find("#GIFT_NO6").val();		
		}

		if(giftNo2 > 6) {
			GIFT_DIVI_GB7 = gift_div.find("select#GIFT_DIVI_GB7 option:selected").val();
			GIFT_AMT7 = gift_div.find("#GIFT_AMT7").val();
			GIFT_NO7 = gift_div.find("#GIFT_NO7").val();		
		}

		if(giftNo2 > 7) {
			GIFT_DIVI_GB8 = gift_div.find("select#GIFT_DIVI_GB8 option:selected").val();
			GIFT_AMT8 = gift_div.find("#GIFT_AMT8").val();
			GIFT_NO8 = gift_div.find("#GIFT_NO8").val();		
		}

		if(giftNo2 > 8) {
			GIFT_DIVI_GB9 = gift_div.find("select#GIFT_DIVI_GB9 option:selected").val();
			GIFT_AMT9 = gift_div.find("#GIFT_AMT9").val();
			GIFT_NO9 = gift_div.find("#GIFT_NO9").val();		
		}	

		if(giftNo2 > 9) {
			GIFT_DIVI_GB10 = gift_div.find("select#GIFT_DIVI_GB10 option:selected").val();
			GIFT_AMT10 = gift_div.find("#GIFT_AMT10").val();
			GIFT_NO10 = gift_div.find("#GIFT_NO10").val();		
		}		

		var giftForm = new FormData();
		giftForm.append('AIR_RSV_SEQNO', '${rsvAir.getAirRsvSeqno()}');
		giftForm.append('giftSeq', giftNo2);

		giftForm.append('GIFT_DIVI_GB1', GIFT_DIVI_GB1);
		giftForm.append('GIFT_AMT1', GIFT_AMT1);
		giftForm.append('GIFT_NO1', GIFT_NO1);
		giftForm.append('GIFT_RECP_YN1', GIFT_RECP_YN1);			

		giftForm.append('GIFT_DIVI_GB2', GIFT_DIVI_GB2);
		giftForm.append('GIFT_AMT2', GIFT_AMT2);
		giftForm.append('GIFT_NO2', GIFT_NO2);
		giftForm.append('GIFT_RECP_YN2', GIFT_RECP_YN2);			

		giftForm.append('GIFT_DIVI_GB3', GIFT_DIVI_GB3);
		giftForm.append('GIFT_AMT3', GIFT_AMT3);
		giftForm.append('GIFT_NO3', GIFT_NO3);
		giftForm.append('GIFT_RECP_YN3', GIFT_RECP_YN3);			

		giftForm.append('GIFT_DIVI_GB4', GIFT_DIVI_GB4);
		giftForm.append('GIFT_AMT4', GIFT_AMT4);
		giftForm.append('GIFT_NO4', GIFT_NO4);	
		giftForm.append('GIFT_RECP_YN4', GIFT_RECP_YN4);			

		giftForm.append('GIFT_DIVI_GB5', GIFT_DIVI_GB5);
		giftForm.append('GIFT_AMT5', GIFT_AMT5);
		giftForm.append('GIFT_NO5', GIFT_NO5);		
		giftForm.append('GIFT_RECP_YN5', GIFT_RECP_YN5);			

		giftForm.append('GIFT_DIVI_GB6', GIFT_DIVI_GB6);
		giftForm.append('GIFT_AMT6', GIFT_AMT6);
		giftForm.append('GIFT_NO6', GIFT_NO6);		
		giftForm.append('GIFT_RECP_YN6', GIFT_RECP_YN6);			

		giftForm.append('GIFT_DIVI_GB7', GIFT_DIVI_GB7);
		giftForm.append('GIFT_AMT7', GIFT_AMT7);
		giftForm.append('GIFT_NO7', GIFT_NO7);		
		giftForm.append('GIFT_RECP_YN7', GIFT_RECP_YN7);			

		giftForm.append('GIFT_DIVI_GB8', GIFT_DIVI_GB8);
		giftForm.append('GIFT_AMT8', GIFT_AMT8);
		giftForm.append('GIFT_NO8', GIFT_NO8);		
		giftForm.append('GIFT_RECP_YN8', GIFT_RECP_YN8);			

		giftForm.append('GIFT_DIVI_GB9', GIFT_DIVI_GB9);
		giftForm.append('GIFT_AMT9', GIFT_AMT9);
		giftForm.append('GIFT_NO9', GIFT_NO9);	
		giftForm.append('GIFT_RECP_YN9', GIFT_RECP_YN9);			

		giftForm.append('GIFT_DIVI_GB10', GIFT_DIVI_GB10);
		giftForm.append('GIFT_AMT10', GIFT_AMT10);
		giftForm.append('GIFT_NO10', GIFT_NO10);
		giftForm.append('GIFT_RECP_YN10', GIFT_RECP_YN10);			
		

		// 소득 공제용 자료 제출 

		var RECEIPT_DIVI_GB = '';
		var ISSUE_HTEL = '';
		var CORP_NO = '';
		var CORP_NO01 = '';
		var CORP_NO02 = '';
		var CORP_NO03 = '';
		var CASH_AMT = 0;
		
		var BANK_CD_GB = ''; // 은행 코드 GB
		var ACT_NO = ''; // 계좌번호 
		var ACT_PAYMTOR_NM = ''; // 계좌 입금자 명
		var PAYMT_SCH_DT = ''; // 입금 예정 일자 
		var PAYMT_CONF_YN = ''; // 입금 확인 여부 
		var NOTE = ''; // 비고 
		var CASH_RECEIPT_DIVI_GB = ''; // 현금 영수증 구분 GB 
		var VIRTUAL_ACT_YN = ''; // 가상 계좌 여부 
		var TID_NO = ''; // TID_NO
		
		var CARD_PAYMT_AMT = gift_div.find("#totalAmt").val();
		var TASF_AMT = gift_div.find("#tasfAmt").val();
			
		RECEIPT_DIVI_GB = gift_div.find('input:radio[name="RECEIPT_DIVI_GB4"]').filter(':checked').val();
		console.log("RECEIPT_DIVI_GB4 : " + RECEIPT_DIVI_GB);
		if(RECEIPT_DIVI_GB == '001') {
			ISSUE_HTEL = gift_div.find('#ISSUE_HTEL').val();
		} else {
			CORP_NO01 = gift_div.find('#CORP_NO01').val();
			CORP_NO02 = gift_div.find('#CORP_NO02').val();
			CORP_NO03 = gift_div.find('#CORP_NO03').val();
			CORP_NO = CORP_NO01 + "-" + CORP_NO02 + "-"+ CORP_NO03;
		}

		CASH_AMT = CARD_PAYMT_AMT;

		// 소득 공제용 자료 제공 
		var receiptForm = new FormData();
		receiptForm.append('AIR_RSV_SEQNO', '${rsvAir.getAirRsvSeqno()}');
		receiptForm.append('RECEIPT_DIVI_GB',RECEIPT_DIVI_GB);
		receiptForm.append('ISSUE_HTEL',ISSUE_HTEL);
		receiptForm.append('CORP_NO',CORP_NO);
		receiptForm.append('REGTOR_ID','');
		receiptForm.append('REG_DTT','');
		receiptForm.append('MODTOR_ID','');
		receiptForm.append('MOD_DTT','');

		if(GIFT_DIVI_GB1 == '') {
			alert("상품권 종류를 선택해 주세요.");
		} else if(GIFT_AMT1 == '') {
			alert("결제 금액을 입력해 주세요.");
		} else if(GIFT_NO1 == '') {
			alert("상품권 번호를 입력해 주세요.");
		} else {
			cfn_ajax({
				type: "POST",
				async: false,
				url: "/free/account/saveAirGiftPaymentAjax.do",
				data: giftForm,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
				},
				error:function(err){
					//console.log(err);
				},
				complete:function(){
					// alert("저장되었습니다.");
				}
			});
			
			cfn_ajax({
				type: "POST",
				async: false,
				url: "/free/account/saveAirReceiptReqAjax.do",
				data: receiptForm,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
				},
				error:function(err){
					//console.log(err);
					alert("저장되지 않았습니다.");
				},
				complete:function(){
					alert("저장되었습니다.");
				}
			});
		}
	}
	
	// 상품권 추가 스크립트 
	var giftNo = 1;
	function fn_cloneGiftBox() {
		giftNo ++;

		if(giftNo < 11) {
			var html = '';
			html = html + "						<table class='pop_table2 pop_ap_teble mt7 coup_table'>";
			html = html + "							<colgroup>";
			html = html + "								<col style='width:25%'>";
			html = html + "								<col style='width:75%'>";
			html = html + "							</colgroup>";
			html = html + "							<tbody>";
			html = html + "								<tr>";
			html = html + "									<th>상품권<br><em class='f_red'>*</em></th>";
			html = html + "									<td>";
			html = html + "										<p class='pop_ap_inpr'><input type='number' id='GIFT_AMT"+giftNo+"' name='GIFT_AMT"+giftNo+"' value='' pattern='[0-9]*' onkeydown='return f_Onlynum();'/> 원</p>";
			html = html + "									</td>";
			html = html + "								</tr>";
			html = html + "								<tr>";
			html = html + "									<th>상품권종류<em class='f_red'>*</em></th>";
			html = html + "									<td>";
			html = html + "										<select name='GIFT_DIVI_GB"+giftNo+"' id='GIFT_DIVI_GB"+giftNo+"'>";
			html = html + "											<option value='00' selected>상품권선택</option>";
			html = html + "											<option value='JG'>롯데제이티비 상품권</option>";
			html = html + "										</select>";
			html = html + "									</td>";
			html = html + "								</tr>";
			html = html + "								<tr>";
			html = html + "									<th>상품권번호<em class='f_red'>*</em></th>";
			html = html + "									<td><input type='number' id='GIFT_NO"+giftNo+"' name='GIFT_NO"+giftNo+"' value='' pattern='[0-9]*' onkeydown='return f_Onlynum();'/></td>";
			html = html + "								</tr>";
			html = html + "								<tr>";
			html = html + "									<th>이메일<em class='f_red'>*</em></th>";
			html = html + "									<td><input type='text' data-role='none' id='email' name='email' placeholder='예) lottejtb@lottejtb.com' /></td>";
			html = html + "								</tr>";						
			html = html + "								<tr>";
			html = html + "									<th>이동전화<em class='f_red'>*</em></th>";
			html = html + "									<td><input type='number' id='phoneNumber' name='phoneNumber' data-role='none' placeholder='예) 01012341234' value='' pattern='[0-9]*' onkeydown='return f_Onlynum();' onkeyup='limitText(this, 12)'/></td>";
			html = html + "								</tr>";	
			html = html + "							</tbody>";
			html = html + "						</table>";

			$("#div_giftList").append(html);
		}
	}

	var giftNo2 = 1;
	function fn_cloneGiftBox2() {
		giftNo2 ++;
		if(giftNo2 < 11) {
			var html = '';
			html = html + "						<table class='pop_table2 pop_ap_teble mt7 coup_table'>";
			html = html + "							<colgroup>";
			html = html + "								<col style='width:25%'>";
			html = html + "								<col style='width:75%'>";
			html = html + "							</colgroup>";
			html = html + "							<tbody>";
			html = html + "								<tr>";
			html = html + "									<th>상품권<br><em class='f_red'>*</em></th>";
			html = html + "									<td>";
			html = html + "										<p class='pop_ap_inpr'><input type='number' id='GIFT_AMT"+giftNo2+"' name='GIFT_AMT"+giftNo2+"' value='' pattern='[0-9]*' onkeydown='return f_Onlynum();'/> 원</p>";
			html = html + "									</td>";
			html = html + "								</tr>";
			html = html + "								<tr>";
			html = html + "									<th>상품권종류<em class='f_red'>*</em></th>";
			html = html + "									<td>";
			html = html + "										<select name='GIFT_DIVI_GB"+giftNo2+"' id='GIFT_DIVI_GB"+giftNo2+"'>";
			html = html + "											<option value='00' selected>상품권선택</option>";
			html = html + "											<option value='JG'>롯데제이티비 여행상품권</option>";
			html = html + "										</select>";
			html = html + "									</td>";
			html = html + "								</tr>";
			html = html + "								<tr>";
			html = html + "									<th>상품권번호<em class='f_red'>*</em></th>";
			html = html + "									<td><input type='number' id='GIFT_NO"+giftNo2+"' name='GIFT_NO"+giftNo2+"' value='' pattern='[0-9]*' onkeydown='return f_Onlynum();'/></td>";
			html = html + "								</tr>";
			html = html + "								<tr>";
			html = html + "									<th>이메일<em class='f_red'>*</em></th>";
			html = html + "									<td><input type='text' data-role='none' id='email' name='email' placeholder='예) lottejtb@lottejtb.com' /></td>";
			html = html + "								</tr>";						
			html = html + "								<tr>";
			html = html + "									<th>이동전화<em class='f_red'>*</em></th>";
			html = html + "									<td><input type='number' id='phoneNumber' name='phoneNumber' data-role='none' placeholder='예) 01012341234' value='' pattern='[0-9]*' onkeydown='return f_Onlynum();' onkeyup='limitText(this, 12)'/></td>";
			html = html + "								</tr>";
			html = html + "							</tbody>";
			html = html + "						</table>";

			$("#div_giftList2").append(html);
		}
	}


	function payAccount() {
		var payMethod = $('input[name=paymentMethod]').val();

		if(payMethod == null) payMethod = 'Card';

		if ($('input:checkbox[id="agreement1"]').is(":checked") == false) {
			alert("결제 전 확인사항에 동의하셔야만 합니다.");
			
		} else if ($('input:checkbox[id="agreement2"]').is(":checked") == false) {
			alert("발권동의에 동의하셔야만 합니다.");
			
		} else if ($('input:checkbox[id="agreement3"]').is(":checked") == false) {
			alert("동의하셔야만 결제가 진행가 됩니다.");
			
		} else {
			console.log("payMethod : " + payMethod);
			
			// 여권 정보 저장 
			// fn_savePassport();

			// 목적지/거주지 정보 등록 
			// fn_saveAddress();

			// 현지 연락처 전송 
			if(fn_saveContact()) {

				if(payMethod == 'Card') { // 신용카드
					payCard();
				}
				if(payMethod == 'VBank') { // 무통장입금(가상계좌)
					payVBank();
				}

				if(payMethod == 'Etc1') { // 신용카드+현금 
					payEtc1();
				}

				if(payMethod == 'Etc2')	{ // 복합결제
					payEtc2();
				}	

				if(payMethod == 'Gift') { // 상품권 
					payGift();
				}
			}
		}
 	}

	var payAmtInfo = {}; //  정보
	
	function fn_PaymentGbn(gbnCode) {
		$("#paymentGbn001").hide();
		$("#paymentGbn002").hide();
		$("#paymentGbn003").hide();
		$("#paymentGbn004").hide();
		$("#paymentGbn005").hide();

		switch (gbnCode) {
			case '001' : // 신용카드
				$("#paymentGbn001").show();
				$('input[name=paymentMethod]').val("Card");
				
				break;
			case '002' : // 무통장입금(가상계좌)
				$("#paymentGbn002").show();
				$('input[name=paymentMethod]').val("VBank");

				break;
			case '003' : // 신용카드+현금 
				$("#paymentGbn003").show();
				$('input[name=paymentMethod]').val("Etc1");
				break;
			case '004' : // 복합결제 
				$("#paymentGbn004").show();
				$('input[name=paymentMethod]').val("Etc2");	

				break;
			case '005' : // 상품권 
				$("#paymentGbn005").show();
				$('input[name=paymentMethod]').val("Gift");			
				break;
		}


		// fn_GetCardType();
		// fn_GetBankType();				
	}

	// 카드 유형 관련 조회 
	function fn_GetCardType() {

		var formData = new FormData();
		formData.append('grpCd', 'FT009');

		
		cfn_ajax({
			type: "POST",
			async: false,
			url: "/free/account/listComCdAjax.do",
			data: formData,
			dataType: "json",
			cache: false,
			noloading:"no",
			timeOut: (5*60*1000),
			success: function(res) {
				commCdList = res.commCdList;

				var html = "";
				html = html + "<select name='CARD_KI_GB' id='CARD_KI_GB'>";
				html = html + "	<option value='000' selected>카드선택</option>";

				// 카드 유형 관련 조회 
				if(commCdList != null) {
					for(var i = 0; i < commCdList.length; i++) {
						html = html + "	<option value='"+commCdList[i].cd+"'>"+commCdList[i].cdNmKr+"</option>";						
					}
				}
				html = html + "</select>";
				// console.log(html);
				
				$("#span_cardType").html(html);
				$("#span_cardType2").html(html);
				$("#span_cardType3").html(html);
				$("#span_cardType4").html(html);
				$("#span_cardType5").html(html);
				$("#span_cardType6").html(html);
				$("#span_cardType7").html(html);
			},
			error:function(err){
				//console.log(err);
			},
			complete:function(){
				
			}
		});
	}

	// 은행 코드 관련 조회 
	function fn_GetBankType() {

		var formData = new FormData();
		formData.append('grpCd', 'FT006');

		
		cfn_ajax({
			type: "POST",
			async: false,
			url: "/free/account/listComCdAjax.do",
			data: formData,
			dataType: "json",
			cache: false,
			noloading:"no",
			timeOut: (5*60*1000),
			success: function(res) {
				commCdList = res.commCdList;

				var html = "";
				html = html + "<select name='BANK_CD_GB' id='BANK_CD_GB'>";
				html = html + "	<option value='' selected>은행선택</option>";

				// 카드 유형 관련 조회 
				if(commCdList != null) {
					for(var i = 0; i < commCdList.length; i++) {
						html = html + "	<option value='"+commCdList[i].cd+"'>"+commCdList[i].cdNmKr+"</option>";						
					}
				}
				html = html + "</select>";
				// console.log(html);
				
				$("#span_bankType").html(html);
				$("#span_bankType2").html(html);
			},
			error:function(err){
				//console.log(err);
			},
			complete:function(){
				
			}
		});
	}

	function fn_CreateAccNo(div){ 
		var accno_div = "";
		var price	=	"";
		
		if(div == 'dual2'){
			accno_div = $('div[ft-att="dual2"]');
			price		=	accno_div.find('#ETC_PAYMT_AMT').val();			//	가격 
		} else if(div == 'dual1'){
			accno_div = $('div[ft-att="dual1"]');
			price		=	accno_div.find('#ETC_PAYMT_AMT').val();			//	가격 
		} else{
			accno_div 	= $('div[ft-att="virtual"]');
			price		=	accno_div.find('#CASH_AMT').val();			//	가격 
		}
		
		var goodName	=	"항공상품명";									//	상품명
		var nminput		=	accno_div.find('#ACT_PAYMTOR_NM').val();	//	입금자명
		var dtinput		=	accno_div.find('#PAYMT_SCH_DT').val();		//	입금예정일
		var phoneNumber	=	accno_div.find('#phoneNumber').val();		//	구매자이동전화번호
		var email		=	accno_div.find('#email').val();				//	구매자이메일
		var bankCd 		=	accno_div.find("select#bankforvbank option:selected").val();	//	은행코드
		
		if(bankCd	==	""){
			setAlert("입금은행을 선택해 주세요");
			return;
		}
		
		if(dtinput	==	""){
			setAlert("입금예정일을 입력해 주세요");
			return;
		}
		
		if(phoneNumber	==	""){
			setAlert("입금자 이동전화번호를 입력해 주세요");
			return;
		}
		
		if(email	==	""){
			setAlert("이메일을 선택해 주세요");
			return;
		}
		
		var formData = new FormData();
		formData.append('vcdbank', bankCd);
		formData.append('dtinput', dtinput);
		formData.append('buyername', nminput);
		formData.append('buyertel', phoneNumber);
		formData.append('buyeremail', email);

		formData.append('goodName', goodName);
		formData.append('cashPayAmt', price);
		formData.append('nminput', nminput);
		
		cfn_ajax({
			type: "POST",
			async: false,
			url: "/free/account/getAccountNo.do",
			data: formData,
			dataType: "json",
			cache: false,
			noloading:"no",
			timeOut: (5*60*1000),
			success: function(res) {
				accno_div.find('#ACT_NO').val(res.ACT_NO);
				accno_div.find('#TID_NO').val(res.TID_NO);
				
				console.log("res.ACT_NO:" + res.ACT_NO);
				console.log("res.TID_NO:" + res.TID_NO);
			},
			error:function(err){
				//console.log(err);
			},
			complete:function(){
				
			}
		});
		
		
	}
	
	function autoCalcDual1() {
		var dual1_div = $('div[ft-att="daul1"]');
		var dual1_all = $('div[ft-att="dual1ALL"]');
		var dual1_pax = $('div[ft-att="dual1PAX"]');
		
		var cardType = dual1_div.find('input:radio[name="card2Type01"]').filter(':checked').val();
		var totalAmt =  dual1_div.find('#totalAmt').val();
		
		if(cardType == '01') { // 전체 일 경우 
			var cardAmt = dual1_div.find('#CARD_PAYMT_AMT').val();
			var cashAmt = parseInt(totalAmt) - parseInt(cardAmt);
			dual1_div.find("#CASH_AMT").val(cashAmt);
		} else {
			var cardAmt = 0;
			paxCnt = <%=rsvAirPaxList.size()%>;
			for(var idx = 0; idx < paxCnt; idx++) {
				var tag = "#paxNo"+(idx+1);
				var paxCardAmt = dual1_pax.find(tag).find('#CARD_PAYMT_AMT').val();
				cardAmt += paxCardAmt;
			}
			var cashAmt = parseInt(totalAmt) - parseInt(cardAmt);
			dual1_div.find("#CASH_AMT").val(cashAmt);

		}

	}

	// 항공 운임 규정 조회
	//규정보기 ajax 호출
	function fn_fareCerti() {	
		
		
		var cdata = fn_setAvailData();
		
		console.log(cdata);
		
		gfn_callAjax3('/fit/air/viewPnrFareCerti.do', cdata, 'fn_showCerti', false);

	}


	// 팝업 > 요금규정, 상세보기 팝업 호출시 넘겨줄 데이터 세팅
	function fn_setAvailData() {
		
		// var ar_cnt = $(_obj).parents('[ft-att="fare_list"]').attr('ar-cnt');

		
		var cdata= {
			"gdsCd"		: '1A',		
			"readTy"	: 'R',	
			"rsvSeqno"  : '${rsvFit.getAirRsvSeqno()}'
		};
		
		return cdata;
	}

	//규정보기 팝업
	function fn_showCerti(_data) {

		var certi_pop = $('div[ft-att="air_certi_pop"]'); 
		
		var certi_div = certi_pop.find('dl[ft-att="certi_table_list"]');
		var certi_data = _data.fareCerti.data;
		var caption = certi_pop.find('#notibox');
		
		// 규정 수만큼  for
		for(var c_idx=0; c_idx<certi_data.length; c_idx++) {
			var tmp_table = "							<dt>요금규정" +  (c_idx+1) + "</dt>";
			tmp_table = tmp_table + "					<dd>";
			tmp_table = tmp_table + "						<table class='pop_table2 pop_table2_left' ft-att='certi_list_div'>";
			tmp_table = tmp_table + "						</table>";
			tmp_table = tmp_table + "					</dd>";		

			certi_div.append(tmp_table);
			
			var certi_list_div = certi_div.find('table[ft-att="certi_list_div"]').eq(c_idx);
			var certi_html = "";
			certi_html = certi_html + "							<colgroup>";
			certi_html = certi_html + "								<col style='width: 25%' />";
			certi_html = certi_html + "								<col style='width: auto' />";
			certi_html = certi_html + "							</colgroup>";
			certi_list_div.append(certi_html);

			var fare_rule_info = certi_data[c_idx].fareRuleInfoDataBean;
			
			for(var f_idx=0; f_idx<fare_rule_info.length; f_idx++) {
				var certi_html = $('<tr></tr>');
				certi_html.append('<th scope="row">' + fare_rule_info[f_idx].itemNm + '</th>');
				certi_html.append('<td class="last"></td>');
				
				//규정 내용 입력	내용 속성 미적용 - 미완료
				var cont_val = '';
				if(fare_rule_info[f_idx].itemAttr == 'C'){
					cont_val = fare_rule_info[f_idx].itemTxt;
				} else if (fare_rule_info[f_idx].itemAttr == 'B') {
					cont_val = fare_rule_info[f_idx].itemTxt;
					console.log('볼드맨');
				} else if (fare_rule_info[f_idx].itemAttr == 'D') {
					cont_val = fare_rule_info[f_idx].itemTxt;
					console.log('볼드맨');
				}		
				certi_html.find('td.last').html(cont_val);		
				
				//리스트에 추가
				certi_list_div.append(certi_html);	
			}
		}
		
		$('table.certi_table').eq(c_idx).show();	//첫번째 요금 규정 노출
		acdon();
		$("#arr_info_div").hide();
		$("#arr_info_div_btn").hide();

		// 항공 예약 여정 정보 중 미주노선 조회 
		fn_srchRsvAirItinList();
	}



	//  항공 예약 여정 정보 중 미주노선 조회 
	function fn_srchRsvAirItinList() {
		var formData = new FormData();
		formData.append("seqNo", '${rsvFit.getAirRsvSeqno()}');
		
		var rsvAirItinList;
		var itinGrpNo = 0;

		cfn_ajax({
			type : "POST",
			async : false,
			url: "/free/account/srchRsvAirItinListAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 5 * 60 * 1000,
			success: function(data) {
				rsvAirItinList	=	data.rsvAirItinList;
				var html = "";
				if(rsvAirItinList != null) {
					for (var i = 0; i < rsvAirItinList.length; i++) {
	
						var arrCd = rsvAirItinList[i].arrCd;

						gfn_callAjax3('/fit/rsv/selAirPAjax.do', {'sVal' : arrCd.toUpperCase()}, 'fn_setAirport', true);
					}

				}	
			},
			error : function(err) {
				console.log(err);
			},
			complete : function(e) {
				console.log(e);
			}
		}); 
	}

	//미주노선, 비자 발급 유무 판단 조회 
	function fn_setAirport(_data) {
		visaYn = _data.result.visaYn;
		apisYn = _data.result.apisYn;

		// console.log(_data);
		console.log(">>>>>>>>>>>>>>>>>>>>>>> visaYn : " + visaYn + " apisYn : " + apisYn);

		// 미주 노선 일 경우 

		if(apisYn == 'Y') {
			$("#arr_info_div").show();
			$("#arr_info_div_btn").show();
		}
	}


	$(document).ready(function() {
		fn_AirPaxList();
		fn_GetCardType();
		fn_GetBankType();	



		jQuery(".pop_at_chk .radioboxs:first-child,td .radioboxs:first-child").addClass("on").find("input").attr("checked",true);
		jQuery(".pop_at_chk .radioboxs:first-child,td .radioboxs:first-child").addClass("on").find("input").prop("checked", true);
		
		limitTimeArr = limitTime.split("-");
		
		$("#P_VBANK_DT").val(limitTimeArr[0]);
		$("#P_VBANK_TM").val(limitTimeArr[1]);

		// 결제하기
		$('#btnPayment').on("click", function(){

		});


		$("#address1").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^A-Za-z0-9]/gi,''));
			}
		});

		$("#address2").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^A-Za-z0-9]/gi,''));
			}
		});

		$("#address3").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^A-Za-z0-9]/gi,''));
			}
		});

		$("#address4").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^A-Za-z0-9]/gi,''));
			}
		});

		$("#address5").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^A-Za-z0-9]/gi,''));
			}
		});

		$("#address6").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^A-Za-z0-9]/gi,''));
			}
		});


		$("#address7").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^A-Za-z0-9]/gi,''));
			}
		});


		$("#address8").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^A-Za-z0-9]/gi,''));
			}
		});

		$("#address9").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^A-Za-z0-9]/gi,''));
			}
		});


		$("#address10").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^A-Za-z0-9]/gi,''));
			}
		});		

		// 항공 운임 규정 조회 
		fn_fareCerti();
	});

	</script>
</head>
<body>
<div class="lypopview">
    <div class="layerPop10">
			<!-- 내용시작 -->
	        <div class="popCon">
				<div class="popHead">
					<div class="popTpart">
						<strong class="popTitle">항공 결제요청</strong>
						<button type="button" class="layerClose10" onclick="history.back(-1);"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></button>
					</div>
				</div>
				<div ft-att="air_certi_pop">
					<dl class="pop_airpay_list mt7">
						<dd>
							<ul class="hplist1">
								<li>전체 여정에 <span>상이한 운임과 규정</span>이 적용되었습니다. </li>
								<li>각 운임 규정 중 가장 제한적인 규정이 적용됩니다. 상세 운임규정은 여행사 <span>예약 담당자를 통해서 재확인</span> 하시기 바랍니다.</li>
								<li>예) 다음 규정의 경우 더 제한적인 규정인 ‘10만원 징수 후 환불’이 적용됩니다. </li>
								<li>첫 번째 환불 규정 : 5만원 징수 후 가능<br>두 번째 환불 규정 : 10만원 징수 후 가능</li>
							</ul>
						</dd>
					</dl>
					<dl class="ft_acdon ft_acdon1 pop_acdon1 pop_airtxtbox_re1" ft-att='certi_table_list'></dl>
				</div>
				<div class="cntain cntain3 pop_airpay">
					<dl class="pop_airpay_list">
						<dt class="ico_exclamat">결제 전 확인사항</dt>
						<dd>
							<ul class="hplist1">
								<li>여행일정(날짜/경유지/도착지/공항)등을 확인 하셨습니까?</li>
								<li>탑승객의 영문명은 여권상의 영문명과 동일합니까?</li>
								<li>입력하신 탑승객의 여권정보, 비자정보, 생년월일은 확인 하셨습니까?</li>
								<li>탑승객의 여권유효기간이 출국일로부터 6개월 이상 남아 있습니까?</li>
								<li>요금규정(변경/취소/조건)등을 확인 하셨습니까?</li>
								<li>결제시한 내에 결제가 이루어지지 않으면 예약이 자동 취소되므로 결제시한을 지켜주셔야 합니다.</li>
							</ul>
						</dd>
						<dd class="pop_airpay_check">
							<p class="chkbox">
								<span><input id="agreement1" name="agreement1" type="checkbox" data-role="none"></span>
								<label for="agreement01">위 모든 사항을 확인하셨으며, 해당사항을 모두 확인 하였습니다. </label>
							</p>
						</dd>
					</dl>

					<dl class="pop_airpay_list mt7">
						<dt class="ico_exclamat">발권동의 <p class="f_purple2">(결제 전 아래사항을 반드시 체크하여 주십시오.)</p></dt>
						<dd>
							<ul class="hplist1">
								<li>결제시한 내에 결제가 이루어지지 않을 경우 예약은 자동취소 됩니다.</li>
								<li>항공예약 규정 및 예약의 변경/취소/환불/재 발행 관련 위약금과 요금규정을 숙지 하였으며, 이를 수용하는 조건으로 예약을 진행합니다.</li>
								<li>신용카드 결제 시 실시간으로 바로 처리 되지 않으며, 발권시점에 승인요청이 되어 집니다. </li>
								<li>따라서 카드번호를 입력하셨더라도 결제가 완료된 것이 아니라 담당자의 확인 절차를 거쳐야만 구매가 최종 완료됩니다.</li>
							</ul>
						</dd>
						<dd class="pop_airpay_check">
							<p class="chkbox">
								<span><input id="agreement2" name="agreement2" type="checkbox" data-role="none"></span>
								<label for="agreement02">위 모든 사항을 확인하셨으며, 해당사항을 모두 확인 하였습니다. </label>
							</p>
						</dd>
					</dl>

					<dl class="pop_airpay_list mt7">
						<dt class="ico_exclamat">결제 방법 선택</dt>
						<dd>
							<ul class="hplist1">
								<li>결제시한까지 결제해 주십시오. 결제시한 이후에는 항공사 사정으로 예약이 사전통보 없이 취소될 수 있습니다.</li>
								<li>결제시한은 주말, 공휴일 및 항공사 사정에 의해 사전 통보 없이 자동 변경될 수 있습니다.</li>
								<li>동남아, 일본, 중국은 결제 시한이 남아 있어도 업무시간 기준 2시간 내에 결제 요청 해주실 것을 권장합니다.</li>
							</ul>
						</dd>
					</dl>
					<div class="pop_air_allbox"> 
						<p>항공권 총 결제금액</p>
						<p><em><span id="payment_air" name="payment_air"><%=strTotalAmt%></span></em><span>원 (취급수수료 포함)</span></p>
					</div>				
					<!-- 항공 마일리지 등록 -->
					<div class="pop_btn_one mt7">
						<button class="layerOpener purple2" data-role="none" data-url="/pop/pop_mileage.do?seqNo=${rsvAir.getAirRsvSeqno()}" data-ctn="full" data-ok="yes">항공 마일리지 등록</button>
					</div>

					<!-- 여권정보등록 -->
					<div id="passport_div">
						<%@ include file="/WEB-INF/jsp/account/inc_passport_info.jsp" %>
					</div>
					<div class="pop_btn_one mt7">
						<button class="purple2" data-role="none" onClick="fn_savePassport()">여권 정보 등록</button>
					</div>
			
					<!-- 여권정보등록 -->
					<!-- 목적지/거주지 정보 등록 및 변경 -->
					<div id="arr_info_div" name='arr_info_div'>
						<%@ include file="/WEB-INF/jsp/account/inc_arr_info.jsp" %>
					</div>
					<div class="pop_btn_one mt7" id='arr_info_div_btn' name='arr_info_div_btn'>
						<button class="purple2" data-role="none" onClick="fn_saveAddress()">목적지/거주지 정보 등록</button>
					</div>
					
					<!-- 목적지/거주지 정보 등록 및 변경 -->
			
					<!-- 현지 연락처 등록 및 변경 -->
					<div id="contact_info_div">
						<%@ include file="/WEB-INF/jsp/account/inc_contact_info.jsp" %>
					</div>
					<!-- 현지 연락처 등록 및 변경 -->

					<!-- div class="pop_btn_one mt7">
						<button class="purple2" data-role="none" onClick="fn_saveContact()">현지 연락처 정보 등록</button>
					</div -->

					<!-- 결제 선택 -->
					<ul class="paylist_chkbox2 pop_plist_chk">
						<li><button type="button" class="active" data-role="none" id="card" onClick="fn_PaymentGbn('001')">신용카드</button></li>
						<li><button type="button" data-role="none" id="virtual" onClick="fn_PaymentGbn('002')">무통장입금<br>(가상계좌)</button></li>
						<li><button type="button" data-role="none" id="dual1" onClick="fn_PaymentGbn('003')">신용카드<br>+ 현금</button></li>
						<!-- <li><button type="button" data-role="none" id="dual2" onClick="fn_PaymentGbn('004')">복합결제<p class="plchb_text1">(신용카드<br>+현금+상품권)</p></button></li>  -->
						<li><button type="button" data-role="none" id="dual2" onClick="fn_PaymentGbn('004')">신용카드<br>+현금+상품권</button></li>
						<li><button type="button" data-role="none" id="gift" onClick="fn_PaymentGbn('005')">상품권</button></li>
					</ul>
					<!-- 신용카드 -->
					<div class="card_part" id="paymentGbn001" name="paymentGbn001" ft-att='card'>
						<div class="pop_airp_title0">
							<p class="pop_at_chk">
								<span class="radioboxs radioboxs2"><input type="radio" name="cardType1" id="cardType1_1" data-chk="card_part_chk1" data-role="none" value="01"></span>
								<label for="cardType1_1" class="wauto">일괄결제</label>

								<span class="radioboxs radioboxs2 ml10"><input type="radio" name="cardType1" id="cardType1_2" data-chk="card_part_chk2" data-role="none" value="02"></span>
								<label for="cardType1_2" class="wauto">개별결제</label>
							</p>
						</div>
						<!-- 일괄결제 -->
						<div class="part_chk card_part_chk1" id='div_airCardAllList' name='div_airCardAllList' ft-att='CARD_ALL'>
							<div class="obj_title3 pop_airp_title1">
								<span class="ico_mem">전체</span>
							</div>
							<table class="pop_table2 pop_ap_teble">
								<colgroup>
									<col style="width:25%">
									<col style="width:75%">
								</colgroup>
								<tbody>
									<tr>
										<th></th>
										<td>
											<input type='hidden' id='PAX_NO' name='PAX_NO' value='0'>
											<input type='hidden' id="totalAmt" name="totalAmt" value="<%=totalAmt%>">
											<input type='hidden' id="tasfAmt" name="tasfAmt" value="<%=tasfAmt%>">
											<p class="pop_ap_point1"><span id="payment_air" name="payment_air"><%=strTotalAmt%></span>원</p>
											<p class="pop_ap_stxt1">(취급수수료 : <%=strTasfAmt%>원(성인<%=nAdtCnt%>, 아동<%=nChdCnt%>, 유아<%=nInfCnt%>) 포함)</p>
										</td>
									</tr>
								</tbody>
							</table>

							<table class="pop_table2 pop_ap_teble mt7">
								<colgroup>
									<col style="width:25%">
									<col style="width:75%">
								</colgroup>
								<tbody>
									<tr>
										<th>카드소유<em class="f_red">*</em></th>
										<td>
											<span class="radioboxs radioboxs2"><input type="radio" name="CARD_OWNER_GB1" id="CARD_OWNER_GB1_1" data-role="none" value='001'></span>
											<label for="CARD_OWNER_GB1_1" class="wauto">개인</label>

											<span class="radioboxs radioboxs2 ml10"><input type="radio" name="CARD_OWNER_GB1" id="CARD_OWNER_GB1_2" data-role="none" value='002'></span>
											<label for="CARD_OWNER_GB1_2" class="wauto">법인</label>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<p class="obj_title2 obj_bg_wht mt7"><span class="ico_exclamat">증빙서류</span></p>	
											<ul class="txbox2">
												<li>항공권결제는 제3자 카드가 불가합니다. 단, 같이 탑승하시는 일행의 카드인 경우는 가능합니다.<br>
												- 일행이 아닌 가족카드의 경우 가족관계증명서가 필요합니다.<br>
												- 법인카드의 경우 재직증명서/사업자등록사본/신용카드 앞, 뒷명 사본이 필요합니다.<br>
												- 주민등록번호 등의 개인정보는 반드시 마스킹 조치 후 첨부바랍니다.<br>
												- 증빙서류는 이메일 : OOO@lottejtb.com 로 발송 바랍니다.</li></ul>
										</td>
									</tr>									
									<tr>
										<th>소유자명<em class="f_red">*</em></th>
										<td><input type="text" id='CARD_OWNER_NM' name='CARD_OWNER_NM' value=''/></td>
									</tr>
									<tr>
										<th>카드선택<em class="f_red">*</em></th>
										<td><span id="span_cardType" name="span_cardType"></span></td>
									</tr>
									<tr>
										<th>카드번호<em class="f_red">*</em></th>
										<td class="card_nb_input"><input type="number" id='CARD_NO01' name='CARD_NO01' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/> <input type="number" id='CARD_NO02' name='CARD_NO02' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/> <input type="password" id='CARD_NO03' name='CARD_NO03' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/> <input type="password" id='CARD_NO04' name='CARD_NO04' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/></td>
									</tr>
									<tr>
										<th>유효기간<em class="f_red">*</em></th>
										<td class="card_yd_select">
											<select name="CARD_EXPIR_DATE_MN" id="CARD_EXPIR_DATE_MN">
												<option value="00" selected>월</option>
												<option value="01">1</option>
												<option value="02">2</option>
												<option value="03">3</option>
												<option value="04">4</option>
												<option value="05">5</option>
												<option value="06">6</option>
												<option value="07">7</option>
												<option value="08">8</option>
												<option value="09">9</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												
											</select>
											<select name="CARD_EXPIR_DATE_YEAR" id="CARD_EXPIR_DATE_YEAR">
												<option value="0000" selected>년</option>
									<%
										for(int y_idx = 0; y_idx < 50; y_idx++) {
											int yyyyDate = nServerYear + y_idx;
									%>			
												<option value="<%=yyyyDate%>"><%=yyyyDate%></option>
									<%
										}
									%>
											</select>
										</td>
									</tr>
									<tr>
										<th>할부기간<em class="f_red">*</em></th>
										<td>
											<select name="CARD_INSTALLMN_MN" id="CARD_INSTALLMN_MN">
												<option value="00" selected>일시불</option>
												<option value="02">02개월</option>
												<option value="03">03개월</option>
												<option value="04">04개월</option>
												<option value="05">05개월</option>
												<option value="06">06개월</option>
												<option value="07">07개월</option>
												<option value="08">08개월</option>
												<option value="09">09개월</option>
												<option value="10">10개월</option>
												<option value="11">11개월</option>
												<option value="12">12개월</option>
											</select>
										</td>
									</tr>
									<!-- tr>
										<th>CVS2<em class="f_red">*</em></th>
										<td>
											<p class="card_pw_input"><input type="password" maxlength="3" id='CARD_CVS_NO' name='CARD_CVS_NO' value='' pattern='[0-9]*' onkeyup="limitText(this, 3)" onkeydown='return f_Onlynum();'/></p>
											<p class="pop_ap_stxt1">※ 카드 뒷면 CVS 번호 입력 </p>	
										</td>
									</tr -->									
									<tr>
										<th>비밀번호<em class="f_red">*</em></th>
										<td>
											<p class="card_pw_input"><input type="password" maxlength="2" id='FRONT_PASS' name='FRONT_PASS' value='' pattern='[0-9]*' onkeyup="limitText(this, 2)" onkeydown='return f_Onlynum();'/><span> ● ●</span></p>
											<p class="pop_ap_stxt1">※ 카드 비밀번호 앞 두 자리만 입력</p>	
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- 탑승객 리스트 -->
						<div class="part_chk card_part_chk2 obj_none" id='div_airCardPaxList' name='div_airCardPaxList' ft-att='CARD_PAX'>
<%
	int adtCnt = 0;
	int chdCnt = 0;
	int infCnt = 0;

	if(rsvAirPaxList != null) {
		for(int idx = 0; idx < rsvAirPaxList.size(); idx++) {
			RsvAirPaxVO rsvAirPaxVO = (RsvAirPaxVO) rsvAirPaxList.get(idx);

%>
							<div class='obj_title3 pop_airp_title1'>
<%
			String paxTyGbNm = "";
			if(rsvAirPaxVO.getPaxTyGb().equals("ADT")) {
				adtCnt ++;
				paxTyGbNm = "성인" + String.valueOf(adtCnt);

			} else if(rsvAirPaxVO.getPaxTyGb().equals("CHD")) {
				chdCnt ++;
				paxTyGbNm = "소인" + String.valueOf(chdCnt);

			} else {
				infCnt ++;
				paxTyGbNm = "유아" + String.valueOf(infCnt);				
			}
%>
								<span class='ico_mem'><%=paxTyGbNm%></span>
							</div>
							<table class='pop_table2 pop_ap_teble'>
								<colgroup>
									<col style='width: 25%'>
									<col style='width: 75%'>
								</colgroup>
								<tbody>
									<tr>
										<input type='hidden' id='PAX_NO<%=idx%>' name='PAX_NO<%=idx%>' value='<%=rsvAirPaxVO.getPaxNo()%>'>
										<th>고객선택</th>
										<td><%=rsvAirPaxVO.getEnFirstNm()%> <%=rsvAirPaxVO.getEnSurNm()%></td>
									</tr>
									<tr>
										<th></th>
										<td>
											<input type='hidden' id="totalAmt" name="totalAmt" value="<%=totalAmt%>">
											<input type='hidden' id="tasfAmt" name="tasfAmt" value="<%=tasfAmt%>">
											<p class="pop_ap_point1"><span id="payment_air" name="payment_air"><%=strTotalAmt%></span>원</p>
											<p class="pop_ap_stxt1">(취급수수료 : <%=strTasfAmt%>원(성인<%=nAdtCnt%>, 아동<%=nChdCnt%>, 유아<%=nInfCnt%>) 포함)</p>
											
										</td>
									</tr>
									<tr>
										<th>카드소유<em class='f_red'>*</em></th>
										<td>
											<span class="radioboxs radioboxs2"><input type="radio" name="CARD_OWNER_GB2" id="CARD_OWNER_GB2_1" data-role="none" value='001'></span>
											<label for="CARD_OWNER_GB2_1" class="wauto">개인</label>

											<span class="radioboxs radioboxs2 ml10"><input type="radio" name="CARD_OWNER_GB2" id="CARD_OWNER_GB2_2" data-role="none" value='002'></span>
											<label for="CARD_OWNER_GB2_2" class="wauto">법인</label>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<p class="obj_title2 obj_bg_wht mt7"><span class="ico_exclamat">증빙서류</span></p>	
											<ul class="txbox2">
												<li>항공권결제는 제3자 카드가 불가합니다. 단, 같이 탑승하시는 일행의 카드인 경우는 가능합니다.<br>
												- 일행이 아닌 가족카드의 경우 가족관계증명서가 필요합니다.<br>
												- 법인카드의 경우 재직증명서/사업자등록사본/신용카드 앞, 뒷명 사본이 필요합니다.<br>
												- 주민등록번호 등의 개인정보는 반드시 마스킹 조치 후 첨부바랍니다.<br>
												- 증빙서류는 이메일 : OOO@lottejtb.com 로 발송 바랍니다.</li></ul>
										</td>
									</tr>									
									<tr>
										<th>소유자명<em class='f_red'>*</em></th>
										<td><input type='text' name="CARD_OWNER_NM" id="CARD_OWNER_NM" value=""/></td>
									</tr>
									<tr>
										<th>카드선택<em class='f_red'>*</em></th>
										<td><span id="span_cardType2" name="span_cardType2"></span></td>
									</tr>
									<tr>
										<th>카드번호<em class='f_red'>*</em></th>
										<td class="card_nb_input"><input type="number" id='CARD_NO01' name='CARD_NO01' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/> <input type="number" id='CARD_NO02' name='CARD_NO02' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/> <input type="password" id='CARD_NO03' name='CARD_NO03' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/> <input type="password" id='CARD_NO04' name='CARD_NO04' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/></td>
									</tr>
									<tr>
										<th>유효기간<em class="f_red">*</em></th>
										<td class="card_yd_select">
											<select name="CARD_EXPIR_DATE_MN" id="CARD_EXPIR_DATE_MN">
												<option value="00" selected>월</option>
												<option value="01">1</option>
												<option value="02">2</option>
												<option value="03">3</option>
												<option value="04">4</option>
												<option value="05">5</option>
												<option value="06">6</option>
												<option value="07">7</option>
												<option value="08">8</option>
												<option value="09">9</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												
											</select>
											<select name="CARD_EXPIR_DATE_YEAR" id="CARD_EXPIR_DATE_YEAR">
												<option value="0000" selected>년</option>
									<%
										for(int y_idx = 0; y_idx < 50; y_idx++) {
											int yyyyDate = nServerYear + y_idx;
									%>			
												<option value="<%=yyyyDate%>"><%=yyyyDate%></option>
									<%
										}
									%>
											</select>
										</td>
									</tr>
									<tr>
										<th>할부기간<em class="f_red">*</em></th>
										<td>
											<select name="CARD_INSTALLMN_MN" id="CARD_INSTALLMN_MN">
												<option value="00" selected>일시불</option>
												<option value="02">02개월</option>
												<option value="03">03개월</option>
												<option value="04">04개월</option>
												<option value="05">05개월</option>
												<option value="06">06개월</option>
												<option value="07">07개월</option>
												<option value="08">08개월</option>
												<option value="09">09개월</option>
												<option value="10">10개월</option>
												<option value="11">11개월</option>
												<option value="12">12개월</option>
											</select>
										</td>
									</tr>
									<!-- tr>
										<th>CVS2<em class="f_red">*</em></th>
										<td>
											<p class="card_pw_input"><input type="password" maxlength="3" id='CARD_CVS_NO' name='CARD_CVS_NO' value='' pattern='[0-9]*' onkeyup="limitText(this, 3)" onkeydown='return f_Onlynum();'/></p>
											<p class="pop_ap_stxt1">※ 카드 뒷면 CVS 번호 입력 </p>	
										</td>
									</tr -->										
									<tr>
										<th>비밀번호<em class='f_red'>*</em></th>
										<td>
											<p class='card_pw_input'>
												<input type='password' maxlength='2' id="FRONT_PASS" name='FRONT_PASS' value='' pattern='[0-9]*' onkeyup="limitText(this, 2)" onkeydown='return f_Onlynum();'/><span> ● ●</span>
											</p>
											<p class='pop_ap_stxt1'>※ 카드 비밀번호 앞 두 자리만 입력</p>
										</td>
									</tr>
								</tbody>
							</table>
<%
		} // end for 
	} // end if
%>
						</div>
						<!-- 탑승객 리스트 -->
					</div>
					<!-- 무통장입금 -->
					<div class="bank_part obj_none" id="paymentGbn002" name="paymentGbn002" ft-att='virtual'>
						<div class="obj_title3 pop_airp_title1">
							<span class="ico_mem">전체</span>
						</div>
						<table class="pop_table2 pop_ap_teble">
							<colgroup>
								<col style="width:25%">
								<col style="width:75%">
							</colgroup>
							<tbody>
								<tr>
									<th>결제금액</th>
									<td>
										<input type="hidden" name="CASH_AMT" id="CASH_AMT" value="<%=rsvAir.getTotSaleAmt()%>"/>
										<input type='hidden' id="totalAmt" name="totalAmt" value="<%=totalAmt%>">
										<input type='hidden' id="tasfAmt" name="tasfAmt" value="<%=tasfAmt%>">
										<p class="pop_ap_point1"><span id="payment_air" name="payment_air"><%=strTotalAmt%></span>원</p>
										<p class="pop_ap_stxt1">(취급수수료 : <%=strTasfAmt%>원(성인<%=nAdtCnt%>, 아동<%=nChdCnt%>, 유아<%=nInfCnt%>) 포함)</p>
									</td>
								</tr>
							</tbody>
						</table>
						<table class="pop_table2 pop_ap_teble mt7">
							<colgroup>
								<col style="width: 25%">
								<col style="width: 75%">
							</colgroup>
							<tbody>
								<tr>
									<th>입금은행<em class="f_red">*</em></th>
									<td>
										<select name="bankforvbank" id="bankforvbank" class="fr_select" data-role="none">
											<option value="">선택해주세요</option>
											<option value="11"> NH농협은행</option>
											<option value="04"> KB국민은행</option>
											<option value="88"> 신한은행</option>
											<option value="20"> 우리은행</option>
											<option value="03"> 기업은행</option>
											<option value="81"> KEB 하나은행</option>
											<option value="31"> 대구은행</option>
											<option value="32"> 부산은행</option>
											<option value="71"> 우체국</option>
											<option value="34"> 광주은행</option>
											<option value="23"> SC은행</option>
											<option value="39"> 경남은행</option>
											<option value="27"> 한국씨티은행</option>
											<option value="07"> 수협중앙회</option>
										</select>	
									</td>
								</tr>
								<tr>
									<th>입금예정일<em class="f_red">*</em></th>
									<td class="card_yd_select">
										<input type="number" id="PAYMT_SCH_DT" name="PAYMT_SCH_DT" value="" pattern='[0-9]*' onkeyup="limitText(this, 8)" onkeydown='return f_Onlynum();'/>
										<span class="vm">예) 20170101</span>
									</td>
								</tr>
								<tr>
									<th>입금자명<em class="f_red">*</em></th>
									<td><input type="text" id="ACT_PAYMTOR_NM" name="ACT_PAYMTOR_NM" value=""/></td>
								</tr>
								<tr>
									<th>계좌번호<em class="f_red">*</em></th>
									<td class="paynumber"><input type="text" id="ACT_NO" name="ACT_NO" value="" readOnly />
										<input type="hidden" id="TID_NO" name="TID_NO" value="" readOnly />
										<button type="button"  class="gray2" onClick="fn_CreateAccNo('virtual')">계좌번호발급</button></td>
								</tr>									
								<tr>
									<th>이메일<em class="f_red">*</em></th>
									<td><input type="text" id="email" name="email" placeholder="test@test.com" value=''/></td>
								</tr>
								<tr>
									<th>이동전화<em class="f_red">*</em></th>
									<td><input type="number" id="phoneNumber" name='phoneNumber' placeholder="" value='' pattern='[0-9]*' onkeyup="limitText(this, 12)" onkeydown='return f_Onlynum();'/></td>
								</tr>
							</tbody>
						</table>
						<!-- 증빙서류 -->
						<table class="pop_table2 pop_ap_teble mt7">
							<colgroup>
								<col style="width:25%">
								<col style="width:75%">
							</colgroup>
							<tbody>
								<tr>
									<th>증빙서류<br>발금용도<em class="f_red">*</em></th>
									<td>
										<p class="pop_ppchk">
											<span class="radioboxs radioboxs2">
											<input type="radio" name="RECEIPT_DIVI_GB1" id="RECEIPT_DIVI_GB1_1" data-chk="pop_bp_pp1" data-role="none" value="001">
											</span>
											<label for="RECEIPT_DIVI_GB1_1" class="wauto"><span class="pop_ac_paper">소득공제용<em>(개인용)</em></span></label>

											<span class="radioboxs radioboxs2 ml10">
											<input type="radio" name="RECEIPT_DIVI_GB1" id="RECEIPT_DIVI_GB1_2" data-chk="pop_bp_pp2" data-role="none" value="002">
											</span>
											<label for="RECEIPT_DIVI_GB1_2" class="wauto"><span class="pop_ac_paper">지출증빙용<em>(사업자용)</em></span></label>
										</p>
										<div class="pop_pp pop_bp_pp1">
											<p><input type="number" id="ISSUE_HTEL" name="ISSUE_HTEL" value="" maxlength="12" pattern='[0-9]*' onkeyup="limitText(this, 12)" onkeydown='return f_Onlynum();'/></p>
											<p class="pop_ap_stxt1">휴대폰 번호 ('-' 없이 숫자만 입력해 주세요.)</p>
										</div>
										<div class="pop_pp pop_bp_pp2 obj_none">
											<p><input type="number" id="CORP_NO01" name="CORP_NO" value='' pattern='[0-9]*' onkeyup="limitText(this, 3)" onkeydown='return f_Onlynum();'/> <input type="number" id="CORP_NO02" name="CORP_NO" value='' pattern='[0-9]*' onkeyup="limitText(this, 2)" onkeydown='return f_Onlynum();'/> <input type="number" id="CORP_NO03" name="CORP_NO" value='' pattern='[0-9]*' onkeyup="limitText(this, 5)" onkeydown='return f_Onlynum();'/></p>
											<p class="pop_ap_stxt1">사업자등록번호</p>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- 신용카드 & 현금 -->
					<div class="card_cash_part obj_none" id="paymentGbn003" name="paymentGbn003" ft-att='dual1'>
						<div class="pop_airp_title0">
							<p class="pop_at_chk">
								<span class="radioboxs radioboxs2"><input type="radio" name="cardType3" id="cardType3_1" data-chk="card_cash_chk1" data-role="none" value='01'></span>
								<label for="card2Type01" class="wauto">일괄결제</label>

								<span class="radioboxs radioboxs2 ml10"><input type="radio" name="cardType3" id="cardType3_2" data-chk="card_cash_chk2" data-role="none" value='02'></span>
								<label for="card2Type01" class="wauto">개별결제</label>
							</p>
						</div>
						<!-- 일괄결제 -->
						<div class="part_chk card_cash_chk1" id='div_airDual1AllList' name='div_airDual1AllList' ft-att='dual1ALL'>
							<div class="obj_title3 pop_airp_title1">
								<span class="ico_mem">전체</span>
							</div>
							<table class="pop_table2 pop_ap_teble">
								<colgroup>
									<col style="width:25%">
									<col style="width:75%">
								</colgroup>
								<tbody>
									<tr>
										<th></th>
										<td>
											<input type='hidden' id="totalAmt" name="totalAmt" value="<%=totalAmt%>">
											<input type='hidden' id="tasfAmt" name="tasfAmt" value="<%=tasfAmt%>">
											<p class="pop_ap_point1"><span id="payment_air" name="payment_air"><%=strTotalAmt%></span>원</p>
											<p class="pop_ap_stxt1">(취급수수료 : <%=strTasfAmt%>원(성인<%=nAdtCnt%>, 아동<%=nChdCnt%>, 유아<%=nInfCnt%>) 포함)</p>

										</td>
									</tr>
								</tbody>
							</table>

							<table class="pop_table2 pop_ap_teble mt7">
								<colgroup>
									<col style="width:25%">
									<col style="width:75%">
								</colgroup>
								<tbody>
									<tr>
										<th>카드<em class="f_red">*</em></th>
										<td>
											<p class="pop_ap_inpr"><input type="number" id="CARD_PAYMT_AMT" name="CARD_PAYMT_AMT" value='0' pattern='[0-9]*' onkeydown='return f_Onlynum();'/> 원</p>
											<p class="pop_ap_stxt1">(고객님께서 카드로 결제하실 금액을 입력해 주세요.)</p>	
										</td>
									</tr>
									<tr>
										<th>카드소유<em class="f_red">*</em></th>
										<td>
											<span class="radioboxs radioboxs2"><input type="radio" name="CARD_OWNER_GB3" id="CARD_OWNER_GB3_1" data-role="none" value='001'></span>
											<label for="CARD_OWNER_GB3_1" class="wauto">개인</label>

											<span class="radioboxs radioboxs2 ml10"><input type="radio" name="CARD_OWNER_GB3" id="CARD_OWNER_GB3_2" data-role="none" value='002'></span>
											<label for="CARD_OWNER_GB3_2" class="wauto">법인</label>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<p class="obj_title2 obj_bg_wht mt7"><span class="ico_exclamat">증빙서류</span></p>	
											<ul class="txbox2">
												<li>항공권결제는 제3자 카드가 불가합니다. 단, 같이 탑승하시는 일행의 카드인 경우는 가능합니다.<br>
												- 일행이 아닌 가족카드의 경우 가족관계증명서가 필요합니다.<br>
												- 법인카드의 경우 재직증명서/사업자등록사본/신용카드 앞, 뒷명 사본이 필요합니다.<br>
												- 주민등록번호 등의 개인정보는 반드시 마스킹 조치 후 첨부바랍니다.<br>
												- 증빙서류는 이메일 : OOO@lottejtb.com 로 발송 바랍니다.</li></ul>
										</td>
									</tr>									
									<tr>
										<th>소유자명<em class="f_red">*</em></th>
										<td><input type="text" name="CARD_OWNER_NM" id="CARD_OWNER_NM" value=""/></td>
									</tr>
									<tr>
										<th>카드선택<em class="f_red">*</em></th>
										<td><span id="span_cardType3" name="span_cardType3"></span></td>
									</tr>
									<tr>
										<th>카드번호<em class="f_red">*</em></th>
										<td class="card_nb_input"><input type="number" id='CARD_NO01' name='CARD_NO01' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/> <input type="number" id='CARD_NO02' name='CARD_NO02' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/> <input type="password" id='CARD_NO03' name='CARD_NO03' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/> <input type="password" id='CARD_NO04' name='CARD_NO04' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/></td>
									</tr>
									<tr>
										<th>유효기간<em class="f_red">*</em></th>
										<td class="card_yd_select">
											<select name="CARD_EXPIR_DATE_MN" id="CARD_EXPIR_DATE_MN">
												<option value="00" selected>월</option>
												<option value="01">1</option>
												<option value="02">2</option>
												<option value="03">3</option>
												<option value="04">4</option>
												<option value="05">5</option>
												<option value="06">6</option>
												<option value="07">7</option>
												<option value="08">8</option>
												<option value="09">9</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												
											</select>
											<select name="CARD_EXPIR_DATE_YEAR" id="CARD_EXPIR_DATE_YEAR">
												<option value="0000" selected>년</option>
									<%
										for(int y_idx = 0; y_idx < 50; y_idx++) {
											int yyyyDate = nServerYear + y_idx;
									%>			
												<option value="<%=yyyyDate%>"><%=yyyyDate%></option>
									<%
										}
									%>
											</select>
										</td>
									</tr>
									<tr>
										<th>할부기간<em class="f_red">*</em></th>
										<td>
											<select name="CARD_INSTALLMN_MN" id="CARD_INSTALLMN_MN">
												<option value="00" selected>일시불</option>
												<option value="02">02개월</option>
												<option value="03">03개월</option>
												<option value="04">04개월</option>
												<option value="05">05개월</option>
												<option value="06">06개월</option>
												<option value="07">07개월</option>
												<option value="08">08개월</option>
												<option value="09">09개월</option>
												<option value="10">10개월</option>
												<option value="11">11개월</option>
												<option value="12">12개월</option>
											</select>
										</td>
									</tr>
									<!-- tr>
										<th>CVS2<em class="f_red">*</em></th>
										<td>
											<p class="card_pw_input"><input type="password" maxlength="3" id='CARD_CVS_NO' name='CARD_CVS_NO' value='' pattern='[0-9]*' onkeyup="limitText(this, 3)" onkeydown='return f_Onlynum();'/></p>
											<p class="pop_ap_stxt1">※ 카드 뒷면 CVS 번호 입력 </p>	
										</td>
									</tr -->										
									<tr>
										<th>비밀번호<em class="f_red">*</em></th>
										<td>
											<p class="card_pw_input"><input type="password" maxlength="2" id="FRONT_PASS" name='FRONT_PASS' value='' pattern='[0-9]*' onkeyup="limitText(this, 2)" onkeydown='return f_Onlynum();'/><span> ● ●</span></p>
											<p class="pop_ap_stxt1">※ 카드 비밀번호 앞 두 자리만 입력</p>	
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- 탑승객 리스트 -->
						<div class="part_chk card_cash_chk2 obj_none" id='div_airDual1PaxList' name='div_airDual1PaxList' ft-att='dual1PAX'>
<%
	adtCnt = 0;
	chdCnt = 0;
	infCnt = 0;

	if(rsvAirPaxList != null) {
		for(int idx = 0; idx < rsvAirPaxList.size(); idx++) {
			RsvAirPaxVO rsvAirPaxVO = (RsvAirPaxVO) rsvAirPaxList.get(idx);

%>
							<div class="obj_title3 pop_airp_title1" ft-att='paxNo<%=(idx+1)%>'>
<%
			String paxTyGbNm = "";
			if(rsvAirPaxVO.getPaxTyGb().equals("ADT")) {
				adtCnt ++;
				paxTyGbNm = "성인" + String.valueOf(adtCnt);

			} else if(rsvAirPaxVO.getPaxTyGb().equals("CHD")) {
				chdCnt ++;
				paxTyGbNm = "소인" + String.valueOf(chdCnt);

			} else {
				infCnt ++;
				paxTyGbNm = "유아" + String.valueOf(infCnt);				
			}
%>
								<span class="ico_mem"><%=paxTyGbNm%></span>
							</div>
							<table class="pop_table2 pop_ap_teble">
								<colgroup>
									<col style="width: 25%">
									<col style="width: 75%">
								</colgroup>
								<tbody>
									<tr>
										<th>고객선택</th>
										<td><%=rsvAirPaxVO.getEnFirstNm()%> <%=rsvAirPaxVO.getEnSurNm()%></td>
									</tr>
									<tr>
										<th rowspan="2"></th>
										<td>
											<input type='hidden' id="totalAmt" name="totalAmt" value="<%=totalAmt%>">
											<input type='hidden' id="tasfAmt" name="tasfAmt" value="<%=tasfAmt%>">
											<p class="pop_ap_point1"><span id="payment_air" name="payment_air"><%=strTotalAmt%></span>원</p>
											<p class="pop_ap_stxt1">(취급수수료 : <%=strTasfAmt%>원(성인<%=nAdtCnt%>, 아동<%=nChdCnt%>, 유아<%=nInfCnt%>) 포함)</p>

										</td>
									</tr>
									<tr>
										<td>
											<p class="pop_ap_stxt0">카드<em class="f_red">*</em></p>
											<p class="pop_ap_inpr"><input type="number" id="CARD_PAYMT_AMT" name="CARD_PAYMT_AMT" value='0'/> 원</p>
											<p class="pop_ap_stxt1">(고객님께서 카드로 결제하실 금액을 입력해 주세요.)</p>
										</td>
									</tr>
									<tr>
										<th>카드소유<em class="f_red">*</em></th>
										<td>
											<span class="radioboxs radioboxs2"><input type="radio" name="CARD_OWNER_GB4" id="CARD_OWNER_GB4_1" data-role="none" value='001'></span>
											<label for="CARD_OWNER_GB4_1" class="wauto">개인</label>

											<span class="radioboxs radioboxs2 ml10"><input type="radio" name="CARD_OWNER_GB4" id="CARD_OWNER_GB4_2" data-role="none" value='002'></span>
											<label for="CARD_OWNER_GB4_2" class="wauto">법인</label>
										</td>	
									</tr>
									<tr>
										<td colspan="2">
											<p class="obj_title2 obj_bg_wht mt7"><span class="ico_exclamat">증빙서류</span></p>	
											<ul class="txbox2">
												<li>항공권결제는 제3자 카드가 불가합니다. 단, 같이 탑승하시는 일행의 카드인 경우는 가능합니다.<br>
												- 일행이 아닌 가족카드의 경우 가족관계증명서가 필요합니다.<br>
												- 법인카드의 경우 재직증명서/사업자등록사본/신용카드 앞, 뒷명 사본이 필요합니다.<br>
												- 주민등록번호 등의 개인정보는 반드시 마스킹 조치 후 첨부바랍니다.<br>
												- 증빙서류는 이메일 : OOO@lottejtb.com 로 발송 바랍니다.</li></ul>
										</td>
									</tr>									
									<tr>
										<th>소유자명<em class="f_red">*</em></th>
										<td><input type="text" /></td>
									</tr>
									<tr>
										<th>카드선택<em class="f_red">*</em></th>
										<td><span id="span_cardType4" name="span_cardType4"></span></td>
									</tr>
									<tr>
										<th>카드번호<em class="f_red">*</em></th>
										<td class="card_nb_input"><input type="number" id='CARD_NO01' name='CARD_NO01' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/> <input type="number" id='CARD_NO02' name='CARD_NO02' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/> <input type="password" id='CARD_NO03' name='CARD_NO03' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/> <input type="password" id='CARD_NO04' name='CARD_NO04' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/></td>
									</tr>
									<tr>
										<th>유효기간<em class="f_red">*</em></th>
										<td class="card_yd_select">
											<select name="CARD_EXPIR_DATE_MN" id="CARD_EXPIR_DATE_MN">
												<option value="00" selected>월</option>
												<option value="01">1</option>
												<option value="02">2</option>
												<option value="03">3</option>
												<option value="04">4</option>
												<option value="05">5</option>
												<option value="06">6</option>
												<option value="07">7</option>
												<option value="08">8</option>
												<option value="09">9</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												
											</select>
											<select name="CARD_EXPIR_DATE_YEAR" id="CARD_EXPIR_DATE_YEAR">
												<option value="0000" selected>년</option>
									<%
										for(int y_idx = 0; y_idx < 50; y_idx++) {
											int yyyyDate = nServerYear + y_idx;
									%>			
												<option value="<%=yyyyDate%>"><%=yyyyDate%></option>
									<%
										}
									%>
											</select>
										</td>
									</tr>
									<tr>
										<th>할부기간<em class="f_red">*</em></th>
										<td>
											<select name="CARD_INSTALLMN_MN" id="CARD_INSTALLMN_MN">
												<option value="00" selected>일시불</option>
												<option value="02">02개월</option>
												<option value="03">03개월</option>
												<option value="04">04개월</option>
												<option value="05">05개월</option>
												<option value="06">06개월</option>
												<option value="07">07개월</option>
												<option value="08">08개월</option>
												<option value="09">09개월</option>
												<option value="10">10개월</option>
												<option value="11">11개월</option>
												<option value="12">12개월</option>
											</select>
										</td>
									</tr>
									<!-- tr>
										<th>CVS2<em class="f_red">*</em></th>
										<td>
											<p class="card_pw_input"><input type="password" maxlength="3" id='CARD_CVS_NO' name='CARD_CVS_NO' value='' pattern='[0-9]*' onkeyup="limitText(this, 3)" onkeydown='return f_Onlynum();'/></p>
											<p class="pop_ap_stxt1">※ 카드 뒷면 CVS 번호 입력 </p>	
										</td>
									</tr -->							
									<tr>
										<th>비밀번호<em class="f_red">*</em></th>
										<td>
											<p class="card_pw_input">
												<input type="password" maxlength="2" value="" id="FRONT_PASS" name="FRONT_PASS" pattern='[0-9]*' onkeyup="limitText(this, 2)" onkeydown='return f_Onlynum();'/><span> ● ●</span>
											</p>
											<p class="pop_ap_stxt1">※ 카드 비밀번호 앞 두 자리만 입력</p>
										</td>
									</tr>
								</tbody>
							</table>
<%
		} // end for 
	} // end if
%>
						</div>
						<!-- 탑승객 리스트 -->
						<!-- 현금 -->
						<table class="pop_table2 pop_ap_teble mt7">
							<colgroup>
								<col style="width:25%">
								<col style="width:75%">
							</colgroup>
							<tbody>
								<tr>
									<th>현금<em class="f_red">*</em></th>
									<td>
										<p class="pop_ap_inpr"><input type="number" name="CASH_AMT" id="CASH_AMT" value="" pattern='[0-9]*' onkeydown='return f_Onlynum();'/> 원</p>
									</td>
								</tr>
								<tr>
									<th>입금은행<em class="f_red">*</em></th>
									<td>
										<select name="bankforvbank" id="bankforvbank" class="fr_select" data-role="none">
											<option value="">선택해주세요</option>
											<option value="11"> NH농협은행</option>
											<option value="04"> KB국민은행</option>
											<option value="88"> 신한은행</option>
											<option value="20"> 우리은행</option>
											<option value="03"> 기업은행</option>
											<option value="81"> KEB 하나은행</option>
											<option value="31"> 대구은행</option>
											<option value="32"> 부산은행</option>
											<option value="71"> 우체국</option>
											<option value="34"> 광주은행</option>
											<option value="23"> SC은행</option>
											<option value="39"> 경남은행</option>
											<option value="27"> 한국씨티은행</option>
											<option value="07"> 수협중앙회</option>
										</select>	
									</td>
								</tr>
								<tr>
									<th>입금예정일<em class="f_red">*</em></th>
									<td class="card_yd_select">
										<input type="number" id="PAYMT_SCH_DT" name="PAYMT_SCH_DT" value="" pattern='[0-9]*' onkeyup="limitText(this, 8)" onkeydown='return f_Onlynum();'/>
										<span class="vm">예) 20170101</span>
									</td>
								</tr>
								<tr>
									<th>입금자명<em class="f_red">*</em></th>
									<td><input type="text" id="ACT_PAYMTOR_NM" name="ACT_PAYMTOR_NM" value=""/></td>
								</tr>
								<tr>
									<th>계좌번호<em class="f_red">*</em></th>
									<td class="paynumber"><input type="text" id="ACT_NO" name="ACT_NO" value="" readOnly />
										<input type="hidden" id="TID_NO" name="TID_NO" value="" readOnly />
										<button type="button"  class="gray2" onClick="fn_CreateAccNo('dual1')">계좌번호발급</button></td>
								</tr>	
								<tr>
									<th>이메일<em class="f_red">*</em></th>
									<td><input type="text" id="email" name="email" placeholder="test@test.com" value=''/></td>
								</tr>
								<tr>
									<th>이동전화<em class="f_red">*</em></th>
									<td><input type="text" id="phoneNumber" name='phoneNumber' placeholder="" value='' pattern='[0-9]*' onkeyup="limitText(this, 12)" onkeydown='return f_Onlynum();'/></td>
								</tr>														
							</tbody>
						</table>
						<!-- 증빙서류 -->
						<table class="pop_table2 pop_ap_teble mt7">
							<colgroup>
								<col style="width:25%">
								<col style="width:75%">
							</colgroup>
							<tbody>
								<tr>
									<th>증빙서류<br>발금용도<em class="f_red">*</em></th>
									<td>
										<p class="pop_ppchk">
											<span class="radioboxs radioboxs2">
											<input type="radio" name="RECEIPT_DIVI_GB2" id="RECEIPT_DIVI_GB2_1" data-chk="pop_bp_pp1" data-role="none" value="001">
											</span>
											<label for="RECEIPT_DIVI_GB2_1" class="wauto"><span class="pop_ac_paper">소득공제용<em>(개인용)</em></span></label>

											<span class="radioboxs radioboxs2 ml10">
											<input type="radio" name="RECEIPT_DIVI_GB2" id="RECEIPT_DIVI_GB2_2" data-chk="pop_bp_pp2" data-role="none" value="002">
											</span>
											<label for="RECEIPT_DIVI_GB2_2" class="wauto"><span class="pop_ac_paper">지출증빙용<em>(사업자용)</em></span></label>
										</p>
										<div class="pop_pp pop_bp_pp1">
											<p><input type="number" id="ISSUE_HTEL" name="ISSUE_HTEL" value="" maxlength="12" pattern='[0-9]*' onkeyup="limitText(this, 12)" onkeydown='return f_Onlynum();'/></p>
											<p class="pop_ap_stxt1">휴대폰 번호 ('-' 없이 숫자만 입력해 주세요.)</p>
										</div>
										<div class="pop_pp pop_bp_pp2 obj_none">
											<p><input type="number" id="CORP_NO01" name="CORP_NO" value='' pattern='[0-9]*' onkeyup="limitText(this, 3)" onkeydown='return f_Onlynum();'/> <input type="number" id="CORP_NO02" name="CORP_NO" value='' pattern='[0-9]*' onkeyup="limitText(this, 2)" onkeydown='return f_Onlynum();'/> <input type="number" id="CORP_NO03" name="CORP_NO" value='' pattern='[0-9]*' onkeyup="limitText(this, 5)" onkeydown='return f_Onlynum();'/></p>
											<p class="pop_ap_stxt1">사업자등록번호</p>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- 신용카드 & 현금 & 상품권 -->
					<div class="card_cash_coup_part obj_none" id="paymentGbn004" name="paymentGbn004" ft-att='dual2'>
						<div class="pop_airp_title0">
							<p class="pop_at_chk">
								<span class="radioboxs radioboxs2"><input type="radio" name="cardType4" id="cardType4_1" data-chk="card_cash_coup_chk1" data-role="none" value='01'></span>
								<label for="cardType4_1" class="wauto">일괄결제</label>

								<span class="radioboxs radioboxs2 ml10"><input type="radio" name="cardType4" id="cardType4_2" data-chk="card_cash_coup_chk2" data-role="none" value='02'></span>
								<label for="cardType4_2" class="wauto">개별결제</label>
							</p>
						</div>
						<!-- 일괄결제 -->
						<div class="part_chk card_cash_coup_chk1" id='div_airDual2AllList' name='div_airDual2AllList' ft-att='dual2ALL'>
							<div class="obj_title3 pop_airp_title1">
								<span class="ico_mem">전체</span>
							</div>
							<table class="pop_table2 pop_ap_teble">
								<colgroup>
									<col style="width:25%">
									<col style="width:75%">
								</colgroup>
								<tbody>
									<tr>
										<th></th>
										<td>
											<input type='hidden' id="totalAmt" name="totalAmt" value="<%=totalAmt%>">
											<input type='hidden' id="tasfAmt" name="tasfAmt" value="<%=tasfAmt%>">
											<p class="pop_ap_point1"><span id="payment_air" name="payment_air"><%=strTotalAmt%></span>원</p>
											<p class="pop_ap_stxt1">(취급수수료 : <%=strTasfAmt%>원(성인<%=nAdtCnt%>, 아동<%=nChdCnt%>, 유아<%=nInfCnt%>) 포함)</p>

										</td>
									</tr>
								</tbody>
							</table>

							<table class="pop_table2 pop_ap_teble mt7">
								<colgroup>
									<col style="width:25%">
									<col style="width:75%">
								</colgroup>
								<tbody>
									<tr>
										<th>카드<em class="f_red">*</em></th>
										<td>
											<p class="pop_ap_inpr"><input type="number" id="CARD_PAYMT_AMT" name="CARD_PAYMT_AMT" value='0'/> 원</p>
											<p class="pop_ap_stxt1">(고객님께서 카드로 결제하실 금액을 입력해 주세요.)</p>	
										</td>
									</tr>
									<tr>
										<th>카드소유<em class="f_red">*</em></th>
										<td>
											<span class="radioboxs radioboxs2"><input type="radio" name="CARD_OWNER_GB5" id="CARD_OWNER_GB5_1" data-role="none"></span>
											<label for="CARD_OWNER_GB5_1" class="wauto">개인</label>

											<span class="radioboxs radioboxs2 ml10"><input type="radio" name="CARD_OWNER_GB5" id="CARD_OWNER_GB5_2" data-role="none"></span>
											<label for="CARD_OWNER_GB5_2" class="wauto">법인</label>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<p class="obj_title2 obj_bg_wht mt7"><span class="ico_exclamat">증빙서류</span></p>	
											<ul class="txbox2">
												<li>항공권결제는 제3자 카드가 불가합니다. 단, 같이 탑승하시는 일행의 카드인 경우는 가능합니다.<br>
												- 일행이 아닌 가족카드의 경우 가족관계증명서가 필요합니다.<br>
												- 법인카드의 경우 재직증명서/사업자등록사본/신용카드 앞, 뒷명 사본이 필요합니다.<br>
												- 주민등록번호 등의 개인정보는 반드시 마스킹 조치 후 첨부바랍니다.<br>
												- 증빙서류는 이메일 : OOO@lottejtb.com 로 발송 바랍니다.</li></ul>
										</td>
									</tr>									
									<tr>
										<th>소유자명<em class="f_red">*</em></th>
										<td><input type="text" /></td>
									</tr>
									<tr>
										<th>카드선택<em class="f_red">*</em></th>
										<td><span id="span_cardType5" name="span_cardType5"></span></td>
									</tr>
									<tr>
										<th>카드번호<em class="f_red">*</em></th>
										<td class="card_nb_input"><input type="number" id='CARD_NO01' name='CARD_NO01' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/> <input type="number" id='CARD_NO02' name='CARD_NO02' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/> <input type="password" id='CARD_NO03' name='CARD_NO03' value='' maxlength='4' data-role='none'/> <input type="password" id='CARD_NO04' name='CARD_NO04' value='' maxlength='4' data-role='none'/></td>
									</tr>
									<tr>
										<th>유효기간<em class="f_red">*</em></th>
										<td class="card_yd_select">
											<select name="CARD_EXPIR_DATE_MN" id="CARD_EXPIR_DATE_MN">
												<option value="00" selected>월</option>
												<option value="01">1</option>
												<option value="02">2</option>
												<option value="03">3</option>
												<option value="04">4</option>
												<option value="05">5</option>
												<option value="06">6</option>
												<option value="07">7</option>
												<option value="08">8</option>
												<option value="09">9</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												
											</select>
											<select name="CARD_EXPIR_DATE_YEAR" id="CARD_EXPIR_DATE_YEAR">
												<option value="0000" selected>년</option>
									<%
										for(int y_idx = 0; y_idx < 50; y_idx++) {
											int yyyyDate = nServerYear + y_idx;
									%>			
												<option value="<%=yyyyDate%>"><%=yyyyDate%></option>
									<%
										}
									%>
											</select>
										</td>
									</tr>
									<tr>
										<th>할부기간<em class="f_red">*</em></th>
										<td>
											<select name="CARD_INSTALLMN_MN" id="CARD_INSTALLMN_MN">
												<option value="00" selected>일시불</option>
												<option value="02">02개월</option>
												<option value="03">03개월</option>
												<option value="04">04개월</option>
												<option value="05">05개월</option>
												<option value="06">06개월</option>
												<option value="07">07개월</option>
												<option value="08">08개월</option>
												<option value="09">09개월</option>
												<option value="10">10개월</option>
												<option value="11">11개월</option>
												<option value="12">12개월</option>
											</select>
										</td>
									</tr>
									<!-- tr>
										<th>CVS2<em class="f_red">*</em></th>
										<td>
											<p class="card_pw_input"><input type="password" maxlength="3" id='CARD_CVS_NO' name='CARD_CVS_NO' value='' pattern='[0-9]*' onkeyup="limitText(this, 3)" onkeydown='return f_Onlynum();'/></p>
											<p class="pop_ap_stxt1">※ 카드 뒷면 CVS 번호 입력 </p>	
										</td>
									</tr -->										
									<tr>
										<th>비밀번호<em class="f_red">*</em></th>
										<td>
											<p class="card_pw_input"><input type="password" maxlength="2" pattern='[0-9]*' onkeyup="limitText(this, 2)" onkeydown='return f_Onlynum();'/><span> ● ●</span></p>
											<p class="pop_ap_stxt1">※ 카드 비밀번호 앞 두 자리만 입력</p>	
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- 탑승객 -->
						<div class="part_chk card_cash_coup_chk2 obj_none" id='div_airDual2PaxList' name='div_airDual2PaxList' ft-att='dual2PAX'>
<%
	adtCnt = 0;
	chdCnt = 0;
	infCnt = 0;

	if(rsvAirPaxList != null) {
		for(int idx = 0; idx < rsvAirPaxList.size(); idx++) {
			RsvAirPaxVO rsvAirPaxVO = (RsvAirPaxVO) rsvAirPaxList.get(idx);

%>
							<div class="obj_title3 pop_airp_title1">
<%
			String paxTyGbNm = "";
			if(rsvAirPaxVO.getPaxTyGb().equals("ADT")) {
				adtCnt ++;
				paxTyGbNm = "성인" + String.valueOf(adtCnt);

			} else if(rsvAirPaxVO.getPaxTyGb().equals("CHD")) {
				chdCnt ++;
				paxTyGbNm = "소인" + String.valueOf(chdCnt);

			} else {
				infCnt ++;
				paxTyGbNm = "유아" + String.valueOf(infCnt);				
			}
%>
								<span class="ico_mem"><%=paxTyGbNm%></span>
							</div>
							<table class="pop_table2 pop_ap_teble">
								<colgroup>
									<col style="width:25%">
									<col style="width:75%">
								</colgroup>
								<tbody>
									<tr>
										<th>고객선택</th>
										<td><%=rsvAirPaxVO.getEnFirstNm()%> <%=rsvAirPaxVO.getEnSurNm()%></td>
									</tr>
									<tr>
										<th rowspan="2"></th>
										<td>
											<input type='hidden' id="totalAmt" name="totalAmt" value="<%=totalAmt%>">
											<input type='hidden' id="tasfAmt" name="tasfAmt" value="<%=tasfAmt%>">
											<p class="pop_ap_point1"><span id="payment_air" name="payment_air"><%=strTotalAmt%></span>원</p>
											<p class="pop_ap_stxt1">(취급수수료 : <%=strTasfAmt%>원(성인<%=nAdtCnt%>, 아동<%=nChdCnt%>, 유아<%=nInfCnt%>) 포함)</p>
										</td>
									</tr>
									<tr> 
										<td>
											<p class="pop_ap_stxt0">카드<em class="f_red">*</em></p>
											<p class="pop_ap_inpr"><input type="number" /> 원</p>
											<p class="pop_ap_stxt1">(고객님께서 카드로 결제하실 금액을 입력해 주세요.)</p>	
										</td>
									</tr>
									<tr>
										<th>카드소유<em class="f_red">*</em></th>
										<td>
											<span class="radioboxs radioboxs2"><input type="radio" name="CARD_OWNER_GB6" id="CARD_OWNER_GB6_1" data-role="none"></span>
											<label for="CARD_OWNER_GB6_1" class="wauto">개인</label>

											<span class="radioboxs radioboxs2 ml10"><input type="radio" name="CARD_OWNER_GB6" id="CARD_OWNER_GB6_2" data-role="none"></span>
											<label for="CARD_OWNER_GB6_2" class="wauto">법인</label>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<p class="obj_title2 obj_bg_wht mt7"><span class="ico_exclamat">증빙서류</span></p>	
											<ul class="txbox2">
												<li>항공권결제는 제3자 카드가 불가합니다. 단, 같이 탑승하시는 일행의 카드인 경우는 가능합니다.<br>
												- 일행이 아닌 가족카드의 경우 가족관계증명서가 필요합니다.<br>
												- 법인카드의 경우 재직증명서/사업자등록사본/신용카드 앞, 뒷명 사본이 필요합니다.<br>
												- 주민등록번호 등의 개인정보는 반드시 마스킹 조치 후 첨부바랍니다.<br>
												- 증빙서류는 이메일 : OOO@lottejtb.com 로 발송 바랍니다.</li></ul>
										</td>
									</tr>									
									<tr>
										<th>소유자명<em class="f_red">*</em></th>
										<td><input type="text" name="CARD_OWNER_NM" id="CARD_OWNER_NM" value=""/></td>
									</tr>
									<tr>
										<th>카드선택<em class="f_red">*</em></th>
										<td><span id="span_cardType6" name="span_cardType6"></span></td>
									</tr>
									<tr>
										<th>카드번호<em class="f_red">*</em></th>
										<td class="card_nb_input"><input type="number" id='CARD_NO01' name='CARD_NO01' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/> <input type="number" id='CARD_NO02' name='CARD_NO02' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/> <input type="password" id='CARD_NO03' name='CARD_NO03' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/> <input type="password" id='CARD_NO04' name='CARD_NO04' value='' maxlength='4' pattern='[0-9]*' onkeyup="limitText(this, 4)" onkeydown='return f_Onlynum();' data-role='none'/></td>
									</tr>
									<tr>
										<th>유효기간<em class="f_red">*</em></th>
										<td class="card_yd_select">
											<select name="CARD_EXPIR_DATE_MN" id="CARD_EXPIR_DATE_MN">
												<option value="00" selected>월</option>
												<option value="01">1</option>
												<option value="02">2</option>
												<option value="03">3</option>
												<option value="04">4</option>
												<option value="05">5</option>
												<option value="06">6</option>
												<option value="07">7</option>
												<option value="08">8</option>
												<option value="09">9</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												
											</select>
											<select name="CARD_EXPIR_DATE_YEAR" id="CARD_EXPIR_DATE_YEAR">
												<option value="0000" selected>년</option>
									<%
										for(int y_idx = 0; y_idx < 50; y_idx++) {
											int yyyyDate = nServerYear + y_idx;
									%>			
												<option value="<%=yyyyDate%>"><%=yyyyDate%></option>
									<%
										}
									%>
											</select>
										</td>
									</tr>
									<tr>
										<th>할부기간<em class="f_red">*</em></th>
										<td>
											<select name="CARD_INSTALLMN_MN" id="CARD_INSTALLMN_MN">
												<option value="00" selected>일시불</option>
												<option value="02">02개월</option>
												<option value="03">03개월</option>
												<option value="04">04개월</option>
												<option value="05">05개월</option>
												<option value="06">06개월</option>
												<option value="07">07개월</option>
												<option value="08">08개월</option>
												<option value="09">09개월</option>
												<option value="10">10개월</option>
												<option value="11">11개월</option>
												<option value="12">12개월</option>
											</select>
										</td>
									</tr>
									<!-- tr>
										<th>CVS2<em class="f_red">*</em></th>
										<td>
											<p class="card_pw_input"><input type="password" maxlength="3" id='CARD_CVS_NO' name='CARD_CVS_NO' value='' pattern='[0-9]*' onkeyup="limitText(this, 3)" onkeydown='return f_Onlynum();'/></p>
											<p class="pop_ap_stxt1">※ 카드 뒷면 CVS 번호 입력 </p>	
										</td>
									</tr -->										
									<tr>
										<th>비밀번호<em class="f_red">*</em></th>
										<td>
											<p class="card_pw_input"><input type="password" maxlength="2" id="FRONT_PASS" name='FRONT_PASS' value='' pattern='[0-9]*' onkeyup="limitText(this, 2)" onkeydown='return f_Onlynum();'/><span> ● ●</span></p>
											<p class="pop_ap_stxt1">※ 카드 비밀번호 앞 두 자리만 입력</p>	
										</td>
									</tr>
								</tbody>
							</table>
<%
		} // end for 
	} // end if
%>
						</div>
						<!-- 탑승객 리스트 -->
						<!-- 상품권 -->
						<div class="coup_btnbox">
							<button type="button" onClick='fn_cloneGiftBox()'>상품권 추가</button>
						</div>
						<table class="pop_table2 pop_ap_teble mt7 coup_table">
							<colgroup>
								<col style="width:25%">
								<col style="width:75%">
							</colgroup>
							<tbody>
								<tr>
									<th>상품권<em class="f_red">*</em></th>
									<td>
										<p class="pop_ap_inpr"><input type="number" id="GIFT_AMT1" name='GIFT_AMT1' value="" pattern='[0-9]*' onkeydown='return f_Onlynum();'/> 원</p>
									</td>
								</tr>
								<tr>
									<th>상품권종류<em class="f_red">*</em></th>
									<td>
										<select name="GIFT_DIVI_GB1" id="GIFT_DIVI_GB1">
											<option value="00" selected>상품권선택</option>
											<option value="JG">롯데제이티비 여행상품권</option>
										</select>
									</td>
								</tr>
								<tr>
									<th>상품권번호<em class="f_red">*</em></th>
									<td><input type="number" id="GIFT_NO1" name="GIFT_NO1" value="" pattern='[0-9]*' onkeydown='return f_Onlynum();'/></td>
								</tr>
								<tr>
									<th>이동전화<em class="f_red">*</em></th>
									<td><input type="number" data-role="none" placeholder="예) 01012341234" /></td>
								</tr>
								<tr>
									<th>이메일<em class="f_red">*</em></th>
									<td><input type="text" data-role="none" placeholder="예) lottejtb@lottejtb.com" /></td>
								</tr>								
							</tbody>
						</table>
						<!-- 위의 상품권 코드 복사할 공간 -->
						<div class="coup_clone" id="div_giftList" name='div_giftList'></div>
						<!-- 현금 -->
						<table class="pop_table2 pop_ap_teble mt7">
							<colgroup>
								<col style="width:25%">
								<col style="width:75%">
							</colgroup>
							<tbody>
								<tr>
									<th>현금<em class="f_red">*</em></th>
									<td>
										<p class="pop_ap_inpr"><input type="number" name="ETC_PAYMT_AMT" id="ETC_PAYMT_AMT" value="" pattern='[0-9]*' onkeydown='return f_Onlynum();'/> 원</p>
									</td>
								</tr>
								<tr>
									<th>입금은행<em class="f_red">*</em></th>
									<td>
										<select name="bankforvbank" id="bankforvbank" class="fr_select" data-role="none">
											<option value="">선택해주세요</option>
											<option value="11"> NH농협은행</option>
											<option value="04"> KB국민은행</option>
											<option value="88"> 신한은행</option>
											<option value="20"> 우리은행</option>
											<option value="03"> 기업은행</option>
											<option value="81"> KEB 하나은행</option>
											<option value="31"> 대구은행</option>
											<option value="32"> 부산은행</option>
											<option value="71"> 우체국</option>
											<option value="34"> 광주은행</option>
											<option value="23"> SC은행</option>
											<option value="39"> 경남은행</option>
											<option value="27"> 한국씨티은행</option>
											<option value="07"> 수협중앙회</option>
										</select>	
									</td>
								</tr>
								<tr>
									<th>입금예정일<em class="f_red">*</em></th>
									<td class="card_yd_select">
										<input type="number" id="PAYMT_SCH_DT" name="PAYMT_SCH_DT" value=""/>
										<span class="vm">예) 2017-01-01</span>
									</td>
								</tr>
								<tr>
									<th>입금자명<em class="f_red">*</em></th>
									<td><input type="text" id="ACT_PAYMTOR_NM" name="ACT_PAYMTOR_NM" value=""/></td>
								</tr>
								<tr>
									<th>계좌번호<em class="f_red">*</em></th>
									<td class="paynumber"><input type="text" id="ACT_NO" name="ACT_NO" value="" readOnly />
										<input type="hidden" id="TID_NO" name="TID_NO" value="" />
										<button type="button"  class="gray2" onClick="fn_CreateAccNo('dual2')">계좌번호발급</button></td>
								</tr>
								<tr>
									<th>이메일<em class="f_red">*</em></th>
									<td><input type="text" id="email" name="email" placeholder="test@test.com" value=''/></td>
								</tr>
								<tr>
									<th>이동전화<em class="f_red">*</em></th>
									<td><input type="text" id="phoneNumber" name='phoneNumber' placeholder="" value='' pattern='[0-9]*' onkeyup="limitText(this, 12)" onkeydown='return f_Onlynum();'/></td>
								</tr>								
							</tbody>
						</table>
						<!-- 증빙서류 -->
						<table class="pop_table2 pop_ap_teble mt7">
							<colgroup>
								<col style="width:25%">
								<col style="width:75%">
							</colgroup>
							<tbody>
								<tr>
									<th>증빙서류<br>발금용도<em class="f_red">*</em></th>
									<td>
										<p class="pop_ppchk">
											<span class="radioboxs radioboxs2">
											<input type="radio" name="RECEIPT_DIVI_GB3" id="RECEIPT_DIVI_GB3_1" data-chk="pop_bp_pp1" data-role="none" value="001">
											</span>
											<label for="RECEIPT_DIVI_GB3_1" class="wauto"><span class="pop_ac_paper">소득공제용<em>(개인용)</em></span></label>

											<span class="radioboxs radioboxs2 ml10">
											<input type="radio" name="RECEIPT_DIVI_GB3" id="RECEIPT_DIVI_GB3_2" data-chk="pop_bp_pp2" data-role="none" value="002">
											</span>
											<label for="RECEIPT_DIVI_GB3_2" class="wauto"><span class="pop_ac_paper">지출증빙용<em>(사업자용)</em></span></label>
										</p>
										<div class="pop_pp pop_bp_pp1">
											<p><input type="number" id="ISSUE_HTEL" name="ISSUE_HTEL" value="" maxlength="12" pattern='[0-9]*' onkeyup="limitText(this, 12)" onkeydown='return f_Onlynum();'/></p>
											<p class="pop_ap_stxt1">휴대폰 번호 ('-' 없이 숫자만 입력해 주세요.)</p>
										</div>
										<div class="pop_pp pop_bp_pp2 obj_none">
											<p><input type="number" id="CORP_NO01" name="CORP_NO" value='' pattern='[0-9]*' onkeyup="limitText(this, 3)" onkeydown='return f_Onlynum();'/> <input type="number" id="CORP_NO02" name="CORP_NO" value='' pattern='[0-9]*' onkeyup="limitText(this, 2)" onkeydown='return f_Onlynum();'/> <input type="number" id="CORP_NO03" name="CORP_NO" value='' pattern='[0-9]*' onkeyup="limitText(this, 5)" onkeydown='return f_Onlynum();'/></p>
											<p class="pop_ap_stxt1">사업자등록번호</p>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- 상품권 -->
					<div class="coup_part obj_none" id="paymentGbn005" name="paymentGbn005" ft-att='gift'>
						<div class="part_chk">
							<div class="obj_title3 pop_airp_title1">
								<span class="ico_mem">전체</span>
							</div>
							<table class="pop_table2 pop_ap_teble">
								<colgroup>
									<col style="width:25%">
									<col style="width:75%">
								</colgroup>
								<tbody>
									<tr>
										<th></th>
										<td>
											<input type='hidden' id="totalAmt" name="totalAmt" value="<%=totalAmt%>">
											<input type='hidden' id="tasfAmt" name="tasfAmt" value="<%=tasfAmt%>">
											<p class="pop_ap_point1"><span id="payment_air" name="payment_air"><%=strTotalAmt%></span>원</p>
											<p class="pop_ap_stxt1">(취급수수료 : <%=strTasfAmt%>원(성인<%=adtCnt%>, 아동<%=chdCnt%>, 유아<%=infCnt%>) 포함)</p>

										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- 상품권 -->
						<div class="coup_btnbox">
							<button type="button" onClick='fn_cloneGiftBox2()'>상품권 추가</button>
						</div>
						<table class="pop_table2 pop_ap_teble mt7 coup_table">
							<colgroup>
								<col style="width:25%">
								<col style="width:75%">
							</colgroup>
							<tbody>
								<tr>
									<th>상품권<br>결제금액<em class="f_red">*</em></th>
									<td>
										<p class="pop_ap_inpr"><input type="number" id="GIFT_AMT1" name="GIFT_AMT1" value="" pattern='[0-9]*' onkeydown='return f_Onlynum();'/> 원</p>
									</td>
								</tr>
								<tr>
									<th>상품권종류<em class="f_red">*</em></th>
									<td>
										<select name="GIFT_DIVI_GB1" id="GIFT_DIVI_GB1">
											<option value="00" selected>상품권선택</option>
											<option value="JG">롯데제이티비 여행상품권</option>
										</select>
									</td>
								</tr>
								<tr>
									<th>상품권번호<em class="f_red">*</em></th>
									<td><input type="number" id="GIFT_NO1" name="GIFT_NO1" value="" pattern='[0-9]*' onkeydown='return f_Onlynum();'/></td>
								</tr>
								<tr>
									<th>이메일<em class="f_red">*</em></th>
									<td><input type="text" id="email" name="email" placeholder="test@test.com" value=''/></td>
								</tr>
								<tr>
									<th>이동전화<em class="f_red">*</em></th>
									<td><input type="text" id="phoneNumber" name='phoneNumber' placeholder="" value='' pattern='[0-9]*' onkeyup="limitText(this, 12)" onkeydown='return f_Onlynum();'/></td>
								</tr>								
							</tbody>
						</table>
						<!-- 위의 상품권 코드 복사할 공간 -->
						<div class="coup_clone" id='div_giftList2' name='div_giftList2'></div>
						<!-- 증빙서류 -->
						<table class="pop_table2 pop_ap_teble mt7">
							<colgroup>
								<col style="width:25%">
								<col style="width:75%">
							</colgroup>
							<tbody>
								<tr>
									<th>증빙서류<br>발금용도<em class="f_red">*</em></th>
									<td>
										<p class="pop_ppchk">
											<span class="radioboxs radioboxs2">
											<input type="radio" name="RECEIPT_DIVI_GB4" id="RECEIPT_DIVI_GB4_1" data-chk="pop_bp_pp1" data-role="none" value="001">
											</span>
											<label for="RECEIPT_DIVI_GB4_1" class="wauto"><span class="pop_ac_paper">소득공제용<em>(개인용)</em></span></label>

											<span class="radioboxs radioboxs2 ml10">
											<input type="radio" name="RECEIPT_DIVI_GB4" id="RECEIPT_DIVI_GB4_2" data-chk="pop_bp_pp2" data-role="none" value="002">
											</span>
											<label for="RECEIPT_DIVI_GB4_2" class="wauto"><span class="pop_ac_paper">지출증빙용<em>(사업자용)</em></span></label>
										</p>
										<div class="pop_pp pop_bp_pp1">
											<p><input type="number" id="ISSUE_HTEL" name="ISSUE_HTEL" value="" maxlength="12" pattern='[0-9]*' onkeyup="limitText(this, 12)" onkeydown='return f_Onlynum();'/></p>
											<p class="pop_ap_stxt1">휴대폰 번호 ('-' 없이 숫자만 입력해 주세요.)</p>
										</div>
										<div class="pop_pp pop_bp_pp2 obj_none">
											<p><input type="number" id="CORP_NO01" name="CORP_NO" value='' pattern='[0-9]*' onkeyup="limitText(this, 3)" onkeydown='return f_Onlynum();'/> <input type="number" id="CORP_NO02" name="CORP_NO" value='' pattern='[0-9]*' onkeyup="limitText(this, 2)" onkeydown='return f_Onlynum();'/> <input type="number" id="CORP_NO03" name="CORP_NO" value='' pattern='[0-9]*' onkeyup="limitText(this, 5)" onkeydown='return f_Onlynum();'/></p>
											<p class="pop_ap_stxt1">사업자등록번호</p>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- 안내문구 -->
					<div class="pop_airpay_check2">
						<p class="chkbox">
							<span><input id="agreement3" name="agreement3" type="checkbox" data-role="none"></span>
							<label for="chk3">고객님께서 입력하신 카드정보는 항공사 시스템을 통해 결제 진행 시에 사용되며 이외의 용도로는 사용되지 않습니다. 이에 동의하고 진행을 합니다.</label>
						</p>
					</div>
							
					<div class="pop_btn_one mt7"><button class="purple2" data-role="none" id="btnPayment" onClick="payAccount()">결제요청</button></div>
				</div>				
			</div>
    </div>
</div>

<input type="hidden" name="paymentMethod" id="paymentMethod" value="Card" >
<input type="hidden" name="resCd" id="resCd" value="${resCd}" >

<form id="paymentReqForm" name="paymentReqForm" method="POST">
	<!-- ***** 필 수 ***** -->
	<input type="hidden" name="version" id = "version" value="" >
	<input type="hidden" name="mid" id = "mid" value="" >
	<input type="hidden" name="goodname" id = "goodname" value="" >
	<input type="hidden" name="oid" id = "oid" value="" > <!-- 필수 -->
	<input type="hidden" name="price" id = "price" value="" > <!-- 필수 -->
	<input type="hidden" name="currency" id = "currency" value="" >
	<input type="hidden" name="buyername" id = "buyername" value="" >
	<input type="hidden" name="buyertel" id = "buyertel" value="" >
	<input type="hidden" name="buyeremail" id = "buyeremail" value="" >
	<input type="hidden" name="timestamp" id = "timestamp" value="" > <!-- 필수 -->
	<input type="hidden" name="signature" id = "signature" value="" >
	<input type="hidden" name="returnUrl" id = "returnUrl" value="" >
	<input type="hidden" name="mKey" id = "mKey" value="" >
							
	<!-- ***** 기본 옵션 ***** -->
	<input type="hidden" name="gopaymethod" id = "gopaymethod" value="" > <!-- 결제 수단 선택 -->
	<input type="hidden" name="offerPeriod" id = "offerPeriod" value="" > <!-- 제공기간 -->
<!-- 		<input type="hidden" name="acceptmethod" value="CARDPOINT:HPP(1):no_receipt:va_receipt:vbanknoreg(0):below1000" > acceptmethod -->

	<input type="hidden" name="acceptmethod" id="acceptmethod" value="" >

	<!-- ***** 표시 옵션 ***** -->
	<input type="hidden" name="languageView" id = "languageView" value="" > <!-- 초기 표시 언어 -->
	<input type="hidden" name="charset" id = "charset" value="" > <!-- 리턴 인코딩: [UTF-8|EUC-KR] (default:UTF-8) -->
	<input type="hidden" name="payViewType" id = "payViewType" value="" > <!-- 결제창 표시방법: [overlay] (default:overlay) -->
	<input type="hidden" name="closeUrl" id = "closeUrl" value="" > <!-- payViewType='overlay','popup'시 취소버튼 클릭시 창닥기 처리 URL(가맹점에 맞게 설정) close.jsp 샘플사용(생략가능, 미설정시 사용자에 의해 취소 버튼 클릭시 인증결과 페이지로 취소 결과를 보냅니다.) -->	
	<input type="hidden" name="popupUrl" id = "popupUrl" value="" > <!-- payViewType='popup'시 팝업을 띄울수 있도록 처리해주는 URL(가맹점에 맞게 설정) popup.jsp 샘플사용(생략가능,payViewType='popup'으로 사용시에는 반드시 설정) -->
		
	<!-- ***** 결제 수단별 옵션 ***** -->
	<!-- 카드(간편결제도 사용) -->
	<input type="hidden" name="quotabase" id = "quotabase" value="" > <!-- 할부 개월 설정 -->
	<input type="hidden" name="ini_onlycardcode" id = "ini_onlycardcode" value="" > <!-- 중복 카드 코드 -->
	<input type="hidden" name="ini_cardcode" id = "ini_cardcode" value="" > <!-- 카드 코드 -->
	<input type="hidden" name="ansim_quota" id = "ansim_quota" value="" > <!-- 할부 선택 -->
	
	<!-- 가상계좌 -->		
	<input type="hidden" name="vbankRegNo" id = "vbankRegNo" value="" > <!-- 주민번호 설정 기능: 13자리(주민번호),10자리(사업자번호),미입력시(화면에서입력가능) -->
	
	<!-- 상품권관련 -->
	<input type="hidden" name="giftCard" id = "giftCard" value="" > <!-- 상품권번호 -->
	<input type="hidden" name="giftCardAmt" id = "giftCardAmt" value="" > <!-- 상품권금액 -->
	
	<!-- LPOINT관련 -->
	<input type="hidden" name="cardNo" id = "cardNo" value="" > <!-- LPOINT 카드번호 -->
	<input type="hidden" name="wpw" id = "wpw" value="" > <!-- LPOINT 패스워드 -->
	
	<!-- ***** 추가옵션 ***** -->
		<!-- 	
				rescd			=	splitParam[0]; 		//	예약번호
				RECEIPT_DIVI_GB	=	splitParam[1]; 		//	현금영수증구분
				ISSUE_HTEL		=	splitParam[2]; 		//	핸드폰번호
				CORP_NO			=	splitParam[2]; 		//	사업자등록번호
				TASF_AMT		=	splitParam[3]; 		//	TASF_금액
		-->
		<input type="hidden" name="merchantData" value="" > <!--  가맹점 관리데이터(2000byte) 인증결과 리턴시 함께 전달됨 -->
</form>
<!-- //결제 요청 폼  -->
<meta http-equiv="Content-Type" content="text/html;charset=euc-kr"/>
<!-- 
1트렌  가상계좌 성공
-->
<form id="form1" name="form1" method="post" accept-charset="euc-kr" action="https://mobile.inicis.com/smart/vbank/" ft-att="form1">
	<input type="hidden" name="P_MID" id="P_MID" value="" />
	<input type="hidden" name="P_OID" id="P_OID" value="" />
	<input type="hidden" name="P_AMT" id="P_AMT" value="" />
	<input type="hidden" name="P_UNAME" id="P_UNAME" value="" />
	<input type="hidden" name="P_GOODS" id="P_GOODS" value="" />
	<input type="hidden" name="P_NEXT_URL" id="P_NEXT_URL" value="http://m.lottejtb.com/free/account/paymentReturn.do" />
	<input type="hidden" name="P_TAX" id="P_TAX" value="0" />
	<input type="hidden" name="P_RESERVED" id="P_RESERVED" value="auth_charset=utf8" />
	<input type="hidden" name="P_VBANK_DT" id="P_VBANK_DT" value="" />
	<input type="hidden" name="P_VBANK_TM" id="P_VBANK_TM" value="" />
	
	<input type="hidden" name="P_NOTI" id="P_NOTI" value="" />
	<input type="hidden" name="P_MOBILE" id="P_MOBILE" value="" />
	<input type="hidden" name="P_EMAIL" id="P_EMAIL" value="" />
	<input type="button" onclick="formSubmit();" >가상계좌</>
</form>	
</body>
</html>