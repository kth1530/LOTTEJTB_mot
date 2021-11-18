<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.lottejtb.front.air.service.*" %>
<%@ page import="com.lottejtb.comm.util.*" %>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>

<head>

<script src="/resources/common/js/fit/common.js"></script>	
<script src="/resources/common/js/fit/pay.js"></script>
<script type="text/javascript">

	var rsvSeqNo = '${rsvResult.getAirRsvSeqno()}';
	var fitRsvNo = '${fitRsvNo}';
	var concMix = '${rsvResult.getConcMix()}';
	var rsvAir;
	var rsvCancelBtnYn = true;
	var airStateCd;
	var htlStateCd;
	var rntStateCd;
	var inAmt = 0;
	var fuelType = {
		'Unspecified' 			: '미정',
		'Diesel' 				: '디젤',
		'Hybrid' 				: '하이브리드',
		'Electric' 				: '전기',
		'LPG Compressed Gas'	: 'LPG',
		'Hydrogen' 				: '수소',
		'MultiFuel' 			: '다종연료',
		'Petrol' 				: '휘발유',
		'Ethanol' 				: '에탄올'
	}

	var pkgAmt = 0;
	
	var min_gap = '';				//[JEH] 추가 20180112
	var arr_cancelDL = [];		//[JEH] 추가 20180112
	var cancelDL_GB = '';		//[JEH] 추가 20180112
	var chgBtnStatus = 'Y';		//[JEH] 추가 20180112
	var cancelStatus = '';
	
	
	// 초기화
	var fn_init = function() {
		// pnr 업데이트 
		fn_syncPnr();
		fn_srchRfdBankCd();
		
	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};

	// 항공 예약 마스터 정보 조회 
	function fn_srchRsvAirMst() {
		var formData = new FormData();
		formData.append("seqNo", rsvSeqNo);
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/free/account/srchRsvAirAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 5 * 60 * 1000,
			success: function(data) {
				rsvAir	=	data.rsvAir;

				var html = "";
				
				if(nullToBlank(rsvAir) != ""){
					html = html + "	<p class='st2_stext1 ellipsis'>"+rsvAir.depNm+"</p>";
					html = html + "	<p class='st2_text1'>"+rsvAir.depCd+"</p>";
					html = html + "	<p class='st2_gbox'></p>";
					html = html + "	<p class='st2_text2'>"+rsvAir.arrCd+"</p>";
					html = html + "	<p class='st2_stext2 ellipsis'>"+rsvAir.firstArrNm+"</p>";
	
					$("#air_mst_info").html(html);
				}
				
			},
			error : function(err) {
				console.log(err);
			},
			complete : function(e) {
				//console.log(e);
				
				if(nullToBlank(rsvAir) != ""){
					$("#air_adt_cnt").html(rsvAir.adt);
					$("#air_adt_cnt2").html(rsvAir.adt);
					$("#air_adt_cnt3").html(rsvAir.adt);
					
					$("#air_chd_cnt").html(rsvAir.chd);
					$("#air_chd_cnt2").html(rsvAir.chd);
					$("#air_chd_cnt3").html(rsvAir.chd);
	
					$("#air_inf_cnt").html(rsvAir.inf);
					$("#air_inf_cnt2").html(rsvAir.inf);
					$("#air_inf_cnt3").html(rsvAir.inf);
					
					/**
					항공 예약 상태에 따라 버튼 처리 
					FN : 미결제 
					PN : 미처리
					RE : 재발행 
					RF : 환불 
					TK : 발권 완료 
					TW : 발권대상 
					VD : VOID
					WA : 결제중 
					XX : 예약 취소 
					**/
					
					if(rsvAir.rsvStateGb == 'FN' || rsvAir.rsvStateGb == 'PN' || rsvAir.rsvStateGb == 'RE') {
						$("#btn_air_paygroup").show();	
						$("#btn_air_pay").show();	
						$("#air_payment_list").hide();	
						$("#btn_air_paycancel").hide();	
						$("#btn_air_passport").hide();
						if(rsvCancelBtnYn){
							$("#reserveCancelBtn").show();
							$("#reserveCancelBtn").parent().removeClass("btn_one");
							$("#reserveCancelBtn").parent().addClass("btn_two");
						}
					}
					if(rsvAir.rsvStateGb == 'TW') {
						$("#btn_air_paygroup").show();	
						$("#btn_air_pay").hide();	
						$("#btn_air_paycancel").show();	
						$("#air_payment_list").show();	
						$("#btn_air_passport").show();
						$("#reserveCancelBtn").hide();
						$("#reserveCancelBtn").parent().removeClass("btn_two");
						$("#reserveCancelBtn").parent().addClass("btn_one");
						rsvCancelBtnYn = false;
					}
					if(rsvAir.rsvStateGb == 'WA') {
						$("#btn_air_paygroup").hide();	
						$("#btn_air_pay").hide();	
						$("#btn_air_paycancel").hide();	
						$("#btn_air_rsvcancel").hide();
						$("#air_payment_list").show();	
						$("#btn_air_passport").show();
						$("#reserveCancelBtn").hide();
						$("#reserveCancelBtn").parent().removeClass("btn_two");
						$("#reserveCancelBtn").parent().addClass("btn_one");
						rsvCancelBtnYn = false;
					}
					if(rsvAir.rsvStateGb == 'XX' || rsvAir.rsvStateGb == 'TK' || rsvAir.rsvStateGb == 'VD') {
						$("#btn_air_paygroup").hide();	
						$("#btn_air_pay").hide();	
						$("#btn_air_paycancel").hide();	
						$("#air_payment_list").hide();	
						$("#btn_air_passport").hide();
						$("#reserveCancelBtn").hide();
						$("#reserveCancelBtn").parent().removeClass("btn_two");
						$("#reserveCancelBtn").parent().addClass("btn_one");
						rsvCancelBtnYn = false;
					}
					
					if(rsvAir.resStateGb == 'XX'){
						airStateCd = false;
					}else{
						airStateCd = true;
					}
					
					$("#flightNo").html(rsvAir.carrierNm + " 편명 - " + rsvAir.depFltno);
	
					var html = "";
					html = html + "<tr>";
					html = html + "	<th>예약자 이름</th>";
					html = html + "	<td>"+rsvAir.rsvNm+"</td>";
					html = html + "</tr>";
					html = html + "<tr>";
					html = html + "	<th>이메일</th>";
					html = html + "	<td>"+rsvAir.rsvNmEmail+"</td>";
					html = html + "</tr>";
					html = html + "<tr>";
					html = html + "	<th>전화번호</th>";
					html = html + "	<td>"+rsvAir.rsvNmHtel+"</td>";
					html = html + "</tr>";
	
					$("#dp_inwon").html(html);
				}
			}
		}); 


	}

	// 항공 예약 여정 정보 조회 
	function fn_srchRsvAirItinList() {
		var formData = new FormData();
		formData.append("seqNo", rsvSeqNo);
		
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
						/**
						var cabinClasNm = '';
						if(rsvAirItinList[i].cabinClass == 'Y') {
							cabinClasNm = '일반석';
						} else if(rsvAirItinList[i].cabinClass == 'W') {
							cabinClasNm = '프리미엄 일반석';
						} else if(rsvAirItinList[i].cabinClass == 'C') {
							cabinClasNm = '비즈니스석';
						} else if(rsvAirItinList[i].cabinClass == 'F')  {
							cabinClasNm = '일등석';
						}
						**/
						var itinGrpNm = '';
						if(rsvAirItinList[i].itinGrpNo == 1) {
							itinGrpNm = '출발';
						} else {
							itinGrpNm = '도착';
						}

						html = html + "	<ul class='fr_porlist'>";
						html = html + "		<li><span>"+itinGrpNm+"</span><span><img src='/resources/images/air/"+rsvAir.carrierCd+".png' alt=''>"+rsvAir.carrierNm+" - 편명 "+rsvAir.depFltno+"</span>";
						html = html + "			<p class='rbtn'>"+rsvAir.fareStateNm+"</p></li>";
						html = html + "		<li>";
						html = html + "			<ul>";
						html = html + "				<li>"+rsvAirItinList[i].depCd+"</li>";
						html = html + "				<li>"+rsvAirItinList[i].depHm+"</li>";
						html = html + "				<li></li>";
						html = html + "				<li>"+rsvAirItinList[i].arrCd+"</li>";
						html = html + "				<li>"+rsvAirItinList[i].arrHm+"</li>";
						html = html + "				<li></li>";
						html = html + "				<li>"+rsvAirItinList[i].flyDurationHm+"</li>";
						html = html + "			</ul>";
						html = html + "		</li>";
						html = html + "	</ul>";


						
					}

				}	
				$("#air_itin_list").append(html);			
			},
			error : function(err) {
				console.log(err);
			},
			complete : function(e) {
				console.log(e);
			}
		}); 
	}

	// 항공 예약 탑승객 정보 조회 
	function fn_srchRsvAirPaxList() {
		var formData = new FormData();
		formData.append("seqNo", rsvSeqNo);
		
		var rsvAirPaxList;

		var adtCnt = 0;
		var chdCnt = 0;
		var infCnt = 0;

		var paxTyNm = "";
		var genderNm = "";
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/free/account/srchRsvAirPaxListAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 5 * 60 * 1000,
			success: function(data) {
				rsvAirPaxList = data.rsvAirPaxList;
				paxCnt = rsvAirPaxList.length;
				var html = "";
				// 여권 정보 입력 리스트 
				if(rsvAirPaxList != null) {
					for(var i = 0; i < rsvAirPaxList.length; i++) {
						if(rsvAirPaxList[i].paxTyGb == 'ADT') {
							adtCnt ++;
							paxTyNm = "성인" + adtCnt;
						} else if(rsvAirPaxList[i].paxTyGb == 'CHD') {
							chdCnt ++;	
							paxTyNm = "아동" + chdCnt;
						} else {							
							infCnt ++;
							paxTyNm = "유아" + infCnt;
						}
						
						if(rsvAirPaxList[i].genderGb == 'M') {
							genderNm = "남";
						} else {
							genderNm = "여";
						}

						html = html + "<table class='ft_table2 ft_tb_tl step4app mt7'>";
						html = html + "	<colgroup>";
						html = html + "		<col style='width: 28%'>";
						html = html + "		<col style='width: 72%'>";
						html = html + "	</colgroup>";
						html = html + "	<tbody>";
						html = html + "		<tr>";
						html = html + "			<th>한글명</th>";
						html = html + "			<td>"+rsvAirPaxList[i].krNm+"<em>"+paxTyNm+"</em></td>";	
						html = html + "		</tr>";
						html = html + "		<tr>";
						html = html + "			<th>영문 성/이름</th>";
						html = html + "			<td>" + rsvAirPaxList[i].enSurNm + " / " + rsvAirPaxList[i].enFirstNm + "</td>";
						html = html + "		</tr>";
						html = html + "		<tr>";
						html = html + "			<th>생년월일</th>";
						html = html + "			<td>"+rsvAirPaxList[i].ymd+"</td>";
						html = html + "		</tr>";
						html = html + "		<tr>";
						html = html + "			<th>연락처</th>";
						html = html + "			<td>"+rsvAirPaxList[i].hTel+"</td>";
						html = html + "		</tr>";
						html = html + "		<tr>";
						html = html + "			<th>성별</th>";
						html = html + "			<td>"+genderNm+"</td>";
						html = html + "		</tr>";
						html = html + "	</tbody>";
						html = html + "</table>";

					}
				}				
				
				$("#air_inwon_list").html(html);
			},
			error : function(err) {
				console.log(err);
			},
			complete : function(e) {
				console.log(e);
			}
		}); 
	}
	
	var paymentPrice = 0;
	/*호텔 에약 정보 조회*/
	var fn_srchRsvHtlInfo = function() {
		var formData = new FormData();
		formData.append("fitRsvNo", fitRsvNo);

		cfn_ajax({
			type : "POST",
			async : false,
			url: "/fit/htl/rsvHtlinfoList.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 5 * 60 * 1000,
			success: function(data) {
				var data = data.rsvInfo;
				
				console.log("******************");
				console.log(data);
				
				if(nullToBlank(data) != '') {
					vHtml = '';
					vUserHtml = '';
					
					for(var i=0; i < data.length; i++) {
						
						var taxAmt = ''; 
						
						if(nullToBlank(data[i].exchangeRate) != '')
							var exchangeRate = parseFloat(data[i].exchangeRate);	//환율
						
						//paymentPrice +=  (parseInt(exchangeRate * parseInt(data[i].saleAmt)) * parseInt(data[i].roomCnt));  //판매금액 * 객실수
						if(data[i].saleCurrency != "KRW"){
							//paymentPrice += Math.ceil(parseFloat(data[i].saleAmt) * exchangeRate); 
							paymentPrice += Math.ceil(parseFloat(data[i].saleJtbAmt));  
							taxAmt = Math.ceil(parseFloat(data[i].taxAmt) * exchangeRate);
						}else{
							paymentPrice += Math.ceil(parseFloat(data[i].saleJtbAmt));  //판매금액 * 객실수
							taxAmt = Math.ceil(parseFloat(data[i].taxAmt));
						}
						
						var checkIn = data[i].checkIn;
						var checkOut = data[i].checkOut;	
						var resState = data[i].rsvState;
						var isBrakFast = data[i].breakfastYn;
						var specChiPolicy = data[i].specChiPolicy;  //스페셜 체크인 정책
						var hotelFee = data[i].hotelFee;
						var saleCurrency = data[i].saleCurrency;     //
						
						var checkInPolicy = data[i].chkInPolicy; //체크인 정책
						var cancelPolicy = data[i].cancelPolicy;  //취소정책
						
						//패키지 할인가
						pkgAmt += data[i].pkgAmt;
						
						
						if(isBrakFast == '' || isBrakFast == null || isBrakFast == 'N') isBrakFast = ' / 조식 불포함';
						else isBrakFast = ' / 조식 포함';
							
						
						var salesTax = data[i].salesTax;
						
						if(salesTax == null || salesTax == '' || salesTax == '0' || salesTax == 0 ) salesTax = '';
						else {
							//var salesTaxP = Math.ceil(parseFloat(data[i].salesTax) * exchangeRate);
							var salesTaxP = Math.ceil(parseFloat(data[i].salesTax));
							var salesTaxT = "";
							if(taxAmt >  0) {
								if(salesTaxP > 0)  	salesTaxT = "[내 SalesTax  " +  comma(salesTaxP) +"원]";
							
						   		salesTax = "(TAX "+ comma(taxAmt) + "원" + salesTaxT + " 포함)";
							}
						}
						
						if(resState == null) resState = '대기';
						
					 	checkIn = checkIn.substr(0,4) + '.' + checkIn.substr(4,2) + '.' + checkIn.substr(6,2);
					 	checkOut = checkOut.substr(0,4) + '.' + checkOut.substr(4,2) + '.' + checkOut.substr(6,2);
					 	
					 	var cancelPolicy ='';
					 	var cancelDL = data[i].cancelDlJtb;
					 	var cancelCheckYN = true;
					 	
					 	arr_cancelDL[i] = data[i].cancelDlJtb;   //[JEH] 추가 20180112
					 	cancelDL_GB = data[i].cancelDlJtb;   //[JEH] 추가 20180112
					 	
					 	calTimeGap('one');   //[JEH] 추가 20180112
					 	
					 	if(cancelDL != null) {
							if(cancelDL =='환불불가'){
								cancelDL = '환불불가';
								$("#reserveCancelBtn").hide();
								$("#reserveCancelBtn").parent().removeClass("btn_two");
								$("#reserveCancelBtn").parent().addClass("btn_one");
								rsvCancelBtnYn = false;
								cancelCheckYN = false;
								chgBtnStatus = 'N';
							}else if(cancelStatus == '환불불가'){   //[JEH] 추가 20180112
								cancelDL = '무료취소기한이 지났습니다.(무료취소기한 : ' + cancelDL + ')';
								$("#reserveCancelBtn").hide();
								$("#reserveCancelBtn").parent().removeClass("btn_two");
								$("#reserveCancelBtn").parent().addClass("btn_one");
								rsvCancelBtnYn = false;
								cancelCheckYN = false;
								chgBtnStatus = 'N';
								cancelStatus = '';
							}else {
								//cancelDL = cancelDL + "까지 무료 취소";
								cancelCheckYN = true;
							}
					 	}
						//호텔운임료
						
						if(data[i].htlRsvstateGb == "OK" && rsvCancelBtnYn){
							$("#reserveCancelBtn").show();
							$("#reserveCancelBtn").parent().removeClass("btn_one");
							$("#reserveCancelBtn").parent().addClass("btn_two");
					 	}else if(data[i].htlRsvstateGb == "OK"){
					 		$("#goPayBtn").show();
					 	}else{
					 		$("#reserveCancelBtn").hide();
					 		$("#reserveCancelBtn").parent().removeClass("btn_two");
							$("#reserveCancelBtn").parent().addClass("btn_one");
							rsvCancelBtnYn = false;
							$("#goPayBtn").hide();
					 	}
						
						if(cancelCheckYN && data[i].htlRsvstateGb == "OK"){
							$("#btn_htl_cancel").show();
						}else{
							$("#btn_htl_cancel").hide();
						}
						
						if(data[i].htlRsvstateGb == "XX"){
							htlStateCd = false;
						}else{
							htlStateCd = true;
						}
						
						//현지 지불 TAX
						if(nullToBlank(hotelFee) == '') hotelFee = '';
						else 
							hotelFee = hotelFee + "  " + saleCurrency;
											
						var roomType = data[i].roomtyNm;
						if(nullToBlank(roomType) == '') roomType ='';
						 
						
						vHtml += "<dl class='pop_info_list'>"
					 	vHtml += "	<dt>호텔" + (i+1) + ""
						vHtml += "	</dt>"
						vHtml += "	<dd>"
						vHtml += "  	<table class='ft_table2 ft_tb_tl'>"
						vHtml += "  		<thead>"
						vHtml += "  			<tr>"
						if(nullToBlank(data[i].htlName) != ""){
							vHtml += "  				<th colspan='2'>" + data[i].htlName + "</th>"
						}else{
							vHtml += "  				<th colspan='2'>" + data[i].htlEnName + "</th>"
						}
						vHtml += "  			</tr>"
						vHtml += " 		 </thead>"
						vHtml += "  	 <tbody>"
						vHtml += "  		 <tr>"
						vHtml += "        		<th>투숙기간</th>"
						vHtml += "				<td>" + checkIn + "(" + fn_getDay(checkIn) +")" + " ~ " + checkOut + "(" + fn_getDay(checkOut) +")" + " (" + data[i].rnCnt + "박)" + "</td>"
						vHtml += "      	</tr>"
						vHtml += " 			<tr>"
						vHtml += "     			<th>객실</th>"
						vHtml += "				<td>"
						vHtml += "        			<p class='rbtn'>" + resState + "</p>"
						vHtml += "					<p>" + roomType + isBrakFast +"</p>"
						vHtml += "					<p>" + "객실 " + data[i].roomCnt + " / " + "성인 " + data[i].adtCnt + "명," + " 아동 " + data[i].chdCnt + "명" + "</p>"
						vHtml += "				</td>"
						vHtml += "			</tr>"
						vHtml += " 			<tr>"
						vHtml += "				<th>취소규정</th>"
						vHtml += " 				<td class='f_purple'>" + cancelDL +"</td>"
						vHtml += "			</tr>"
						vHtml += " 			<tr>"
						vHtml += "				<th>현지 지불 TAX</th>"
						vHtml += " 				<td class='f_purple'>" + hotelFee +"</td>"
						vHtml += "			</tr>"
						vHtml += "			<tr>"
						vHtml += "				<th>호텔 총 요금</th>"
						vHtml += "				<td class='tr'><span class='f_purple'>" + comma(Math.ceil(parseFloat(data[i].saleJtbAmt))) +"원" + salesTax + "</span></td>"
						vHtml += "			</tr>"
						if(nullToBlank(checkInPolicy) != '') {	
							vHtml += "			<tr>"
							vHtml += "				<td class='tl' colspan='2'>"
							vHtml += "				<p><b>[ 체크인 정책 ]</b></p>"
							vHtml += "				<div>"+ data[i].chkInPolicy +"</div>"
							vHtml += "				</td>"
							vHtml += "          </tr>"
						}
						if(nullToBlank(cancelPolicy) != '') {	
							vHtml += "			<tr>"
							vHtml += "				<td class='tl' colspan='2'>"
							vHtml += "				<p><b>[ 취소 정책 ]</b></p>"
							vHtml += "				<div>"+ data[i].cancelPolicy +"</div>"
							vHtml += "				</td>"
							vHtml += "          </tr>"
						}
						if(nullToBlank(specChiPolicy) != '') { 
							vHtml += "			<tr  id='spepolicy'" + i + "style='display:none'>"
							vHtml += "				<td class='tl' colspan='2'>"
							vHtml += "				<p><b>[ 스페셜 체크인 정책 ]</b></p>"
							vHtml += "				<div>"+ specChiPolicy +"</div>"
							vHtml += "				</td>"
							vHtml += "          </tr>"
						}
						vHtml += "	 	 </tbody>"
						vHtml += "	  </table>"
						vHtml += "	</dd>"
						vHtml +="</dl>"

						//[JEH] 호텔 개별 취소 버튼 추가 - 20180201
						vHtml += "<div class='btn_one air_tbtn' id='btn_htl_cancel'>"
						vHtml +=  	"<button class='purple2' data-role='none' onClick='fn_rsvCancel(" + data[i].rsvSeqNo + ")'>호텔" + (i+1) + " 예약취소</button>"
						vHtml += "</div>"
							
							
						vUserHtml +="	<table class='ft_table2 ft_tb_tl step4app mt7'>";
						vUserHtml +="		<colgroup>";
						vUserHtml +="			<col style='width: 28%'>";
						vUserHtml +="			<col style='width: 72%'>";
						vUserHtml +=" 		</colgroup>";
						vUserHtml +="		<tbody>";
						vUserHtml +=" 				<tr>";
						vUserHtml +="					<th>호텔명</th>";
						vUserHtml +="     				<td class='f_purple'>" + nullToBlank(data[i].htlEnName) + "<br><br>" + nullToBlank(data[i].htlName) +"</td>";
						vUserHtml +="				</tr>";
						vUserHtml +="				<tr>";
						vUserHtml +="					<th>객실타입</th>";
						vUserHtml +="					<td class='f_purple'>" + roomType + "</td>";
						vUserHtml +="				</tr>";
						vUserHtml +=" 		</tbody>";
						vUserHtml +="	</table>";
						vUserHtml +="	<div id='"+ data[i].rsvSeqNo +"'>";
						vUserHtml +="	</div>";
						
						
						$("#payment_hotel").text(comma(paymentPrice) +'원');
					}
					
					if(pkgAmt > 0) {
						$('#pkg_discntArea').show();
						$('#pkg_discnt').text(comma(pkgAmt) + '원');
					} else {
						$('#pkg_discntArea').hide();
					}
					 
					//[JEH] 추가 20180112
					if(chgBtnStatus == 'N'){
						$("#btn_htl_cancel").hide();
						$("#reserveCancelBtn").hide();
						$("#reserveCancelBtn").parent().removeClass("btn_two");
						$("#reserveCancelBtn").parent().addClass("btn_one");
						rsvCancelBtnYn = false;
						cancelCheckYN = false;
					}
					
					$('#htl_reserve_info').html(vHtml);
					$("#htl_travler_info").html(vUserHtml);
				}
				
				
				//숙박자 정보
				for(var j=0; j < data.length; j++) {
					fn_srchRsvHtlTraveler(data[j].rsvSeqNo);
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
	
	/*호텔 에약 숙박자 정보 조회*/
	var fn_srchRsvHtlTraveler = function(rsvSeqNo) {
		var formData = new FormData();
		formData.append("fitRsvNo", fitRsvNo);  //자유여행 번호
		formData.append("rsvSeqNo", rsvSeqNo);  //숙밪자정보
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/fit/htl/rsvHtlTravlerList.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 5 * 60 * 1000,
			success: function(res) {
				var data = res.rsvTrlInfo;
				
				
				console.log("<<<<<<<<<<<<<<<<<<<<<< htlPaymt=" + htlPaymt);
				
				if(nullToBlank(data) != '') {
					vHtml = '';
							
					for(var j= 0; j < data.length; j++) {
					
						vHtml +="	<table class='ft_table2 ft_tb_tl step4app mt7'>"
						vHtml +="		<colgroup>"
						vHtml +="			<col style='width: 28%'>"
						vHtml +="			<col style='width: 72%'>"
						vHtml +="		</colgroup>"
						vHtml +="		<tbody>"
						vHtml +="				<tr>"
						vHtml +="					<th>한글명</th>"
						vHtml +=" 					<td>" + data[j].guestKrName +"<em></em></td>"
						vHtml +="				</tr>"
						vHtml +="				<tr>"
						vHtml +="					<th>영문 성/이름</th>"
						vHtml +="					<td>" + data[j].guestEnName +"</td>"
						vHtml +="				</tr>"
						vHtml +="				<tr>"
						vHtml +="					<th>생년월일</th>"
						vHtml +="					<td>" + data[j].ymd + "</td>"
						vHtml +="				</tr>"
						vHtml +="				<tr>"
						vHtml +="					<th>연락처</th>"
						vHtml +="					<td>" + data[j].htel + "</td>"
						vHtml +="				</tr>"
						vHtml +="				<tr>"
						vHtml +="					<th>성별</th>"
						if(data[j].gender == 'M'){
							vHtml +="					<td>남</td>"
						}else{
							vHtml +="					<td>여</td>"
						}
						vHtml +=" 				</tr>"
						vHtml +="		</tbody>"
						vHtml +=" 	</table>"
					}	
					
					$('#'+ rsvSeqNo).html(vHtml);
					
				}
				
				//결제 내역 ///////////////
				var payHtml = "";
				var htlPaymt = res.htlPayment;
				
				var cashAmt = htlPaymt[0].cashAmt;  //현금금액
				var actNo = htlPaymt[[0]].actNo;  //가상계좌
				 
				var paySchDt = htlPaymt[0].paymtSchDt; //입금예정일자.입금마감시한
				if(paySchDt == '--') paySchDt = null;
				var psySchHm = htlPaymt[0].paymtSchHm; //입금 예정시분
				if(psySchHm == ':') psySchHm = null;
				var amtInput = htlPaymt[0].amtInput; //입금금액
				var bankNm = htlPaymt[0].bankNm;  //은행명
				var cardPayAmt = htlPaymt[0].cardPaymtAmt; //카드결제금액
				var cardKiGb = htlPaymt[0].cardKiGb ; //카드명
				var lpointUse = 0; //lpoint 사용
				if(htlPaymt[0].usePoint != null){
					lpointUse = htlPaymt[0].usePoint;
				}
				
				inAmt = amtInput;		//[JEH] 입금금액 환불체크를 위한 글로벌 변수에 할당
							
				if(cardKiGb != null) cardKiGb = cardKiGb + "카드";
				
				var cardInstallmnMn = htlPaymt[0].cardInstallmnMn; //카드개월수
				if(cardInstallmnMn != null) {
					if(cardInstallmnMn == "00") cardInstallmnMn = '일시불';
					else
						cardInstallmnMn = cardInstallmnMn + "개월";
				} 
				//else cardInstallmnMn = "-";
				
				var actPrice = 0;
				var price = 0;
				if(actNo != null) { //가상계좌 번호  //가상계좌 
					actPrice = cashAmt;
				}
				
				if(parseInt(cardPayAmt) > 0) { //카드 결제
					price = parseInt(cardPayAmt);
				}
							
							
				payHtml += "<p class='obj_title2 obj_bg_wht mt7'><span class='ico_paym'>결제내역</span></p>";
				payHtml += "<table id='tbl_payment' class='ft_table2 ft_th_tl ft_tb_tr'>";
				payHtml += "   <colgroup>";
				payHtml += "	<col style='width:30%' />";
				payHtml += "		<col style='width:70%' />";
				payHtml += "	</colgroup>";
				payHtml += "	<div id='paymtInfo'>";
				
				payHtml += " <tbody>";
				/* payHtml += " <tr>";
				payHtml	+= "  <th>L.point 사용금액</th>";
				payHtml	+= "  <td>-</td>";
				payHtml	+= " </tr>";
				payHtml += " <tr>";
				payHtml	+= "  <th>롯데JTB사용금액</th>";
				payHtml	+= "  <td>-</td>";
				payHtml	+= " </tr>"; 
				payHtml += " <tr>"; 
				payHtml	+= "  <th>사용금액</th>";
				payHtml	+= "  <td>" + comma(amtInput) + "원</td>";
				payHtml	+= " </tr>";*/
				if(cardKiGb != null) {
					payHtml += " <tr>";
					payHtml	+= "   <th>카드명</th>";
					payHtml	+= "   <td>"+ nullToBlank(cardKiGb) +"</td>";
					payHtml	+= " </tr>";
					payHtml += " <tr>";
					payHtml	+= "   <th>결제금액</th>";
					payHtml	+= "   <td>"+ comma(price) +"원</td>";
					payHtml	+= " </tr>";
				}
				if(cardInstallmnMn != null) {
					payHtml	+= " <tr>";
					payHtml	+= "   <th>할부개월수</th>";
					payHtml	+= "   <td>" + cardInstallmnMn + "</td>";
					payHtml	+= " </tr>";
				}

				if(lpointUse != null && lpointUse > 0) {
					var lpointPrice = parseInt(lpointUse);
					var inTr = payHtml.indexOf("<tr>");  //[JEH] 이전에 그려진 tr이 있는지 check - 20180124
					
					if(inTr != -1){
						payHtml	+= " <tr class='top_bold'>";
					}else{
						payHtml	+= " <tr>";
					}
					payHtml	+= "   <th>L.Point</th>";
					payHtml	+= "   <td>"+ comma(lpointPrice) + "point</td>";
					payHtml	+= " </tr>";
				}
				if(bankNm != null) {
					var inTr = payHtml.indexOf("<tr>");  //[JEH] 이전에 그려진 tr이 있는지 check - 20180124
					
					if(inTr != -1){
						payHtml	+= " <tr class='top_bold'>";
					}else{
						payHtml	+= " <tr>";
					}
					payHtml	+= "   <th>입금은행</th>";
					payHtml	+= "   <td>"+ nullToBlank(bankNm)  + "</td>";
					payHtml	+= " </tr>";
				}
				if(actNo != null) {
					payHtml += " <tr>";
					
					payHtml += "<input type='hidden' id='actYN' value='Y' />";
					
					payHtml	+= "  <th>가상계좌번호</th>";
					payHtml	+= "  <td>"+ nullToBlank(actNo)  + "</td>";
					payHtml	+= " </tr>";
				}
				if(paySchDt != null) {
					payHtml += " <tr>";
					payHtml	+= "  <th>입금마감시한</th>";
					payHtml	+= "  <td>" + paySchDt + "  " + psySchHm +"</td>";
					payHtml	+= " </tr>";
				}
				if(cashAmt != null && actNo != null) {
					payHtml += " <tr>";
					payHtml	+= "  <th>미입금금액</th>";
					payHtml	+= "  <td>"+ comma(actPrice-amtInput) + "원</td>";
					payHtml	+= " </tr>";
				}

				if(cardKiGb != null || cashAmt != null) {
					payHtml += " <tr class='top_double'>";
					payHtml	+= "   <th>총 결제금액</th>";
					payHtml	+= "   <td>"+ comma(amtInput+price+lpointUse) +"원</td>";
					payHtml	+= " </tr>";
				}
				
				payHtml += " </div>";	
				payHtml += "</table>"; 
				
				
				$('#paymtInfo').html(payHtml);
				
			},
			error : function(err) {
				console.log(err);
			},
			complete : function(e) {
				console.log(e);
				//예약취소를 위한 정보 조회
				fn_srchRsvHtlCancel();
			}
		}); 
	}
	
	
	/* 호텔 예약된 정보 조회 */
	var rsvCancelData;
	
	var fn_srchRsvHtlCancel = function() {
		var formData = new FormData();
		formData.append("fitRsvNo", fitRsvNo);
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/fit/htl/rsvHtlCancelInfo.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 5 * 60 * 1000,
			success: function(data) {
				rsvCancelData = data.rsvHtlCancel;
				console.log(rsvCancelData);
			},
			error : function(err) {
				console.log(err);
			},
			complete : function(e) {
				console.log(e);
			}
		}); 
	}
	
	
	/* 랜터카 */
	var fn_srchRsvRntMst = function(){
		var formData = new FormData();
		formData.append("fitRsvNo", fitRsvNo);
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/fit/rnt/selectRentcarRsvList.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			success: function(data) {
				var list = data.list;
				
				var vHTML = "";
				var vDvHTML = "";
				
				for(var i = 0; i < list.length; i++){
					var pickupDtArr = list[i].pickupDt.split('.');
					var rtDtArr = list[i].rtDt.split('.');
					
					var takeDate = new Date(pickupDtArr[0], parseInt(pickupDtArr[1]) - 1, pickupDtArr[2]);
					var takeNumday = getWeeks(takeDate.getDay());
					var returnDate = new Date(rtDtArr[0], parseInt(rtDtArr[1]) - 1, rtDtArr[2]);
					var returnNumday = getWeeks(returnDate.getDay());
					
					vHTML += '<dl class="pop_info_list">';
					vHTML += '	<dt>렌터카'+ (i + 1) +'</dt>';
					vHTML += '	<dd>';
					vHTML += '		<ul class="lc_acodion_info">';
					if(i == 0){
						vHTML += '			<li class="on"><div>';
					}else{
						vHTML += '			<li><div>';	
					}
					vHTML += '					<span>'+ list[i].carModelNm.replace("OR SIMILAR", "") +'</span>';
					if(list[i].carModelNm.indexOf("OR SIMILAR") > -1){
						vHTML += '					<span>OR SIMILAR</span>';	
					}
					vHTML += '				</div>';
					vHTML += '				<p>'+ list[i].carSizeNm +'</p></li>';
					vHTML += '			<li>';
					vHTML += '				<ul>';
					vHTML += '					<li>승객수 : '+ list[i].bodQty +'명</li>';
					vHTML += '					<li>수화물 개수 : '+ list[i].bageQty +'개</li>';
					if(list[i].airconYn == 'Y'){
						vHTML += '					<li>에어컨 : 있음</li>';
					}else{
						vHTML += '					<li>에어컨 : 없음</li>';	
					}
					vHTML += '					<li>변속기 : '+ list[i].transmissionNm +'</li>';
					vHTML += '					<li>연료 : '+ fuelType[list[i].fuelTy] +'</li>';
					vHTML += '					<li>연비 : '+ list[i].furateKpl +'km/리터</li>';
					if(list[i].dualAbagYn){
						vHTML += '					<li>에어백 : 듀얼</li>';
					}else if(list[i].abagYn){
						vHTML += '					<li>에어백 : 있음</li>';
					}else{
						vHTML += '					<li>에어백 : 없음</li>';	
					}
					
					if(list[i].carDistance == "true"){
						vHTML += '					<li>주행거리제한 : 무제한</li>';	
					}else{
						vHTML += '					<li>주행거리제한 : '+ list[i].carDistance +'</li>';
					}
					vHTML += '				</ul>';
					vHTML += '			</li>';
					vHTML += '		</ul>';
					vHTML += '		<table class="ft_table2 ft_tb_tl">';
					vHTML += '			<tr>';
					vHTML += '				<th>차량 인수일</th>';
					vHTML += '				<td>'+ list[i].pickupDt +' ('+ takeNumday + ') '+ list[i].pickupHm +'</td>';
					vHTML += '			</tr>';
					vHTML += '			<tr>';
					vHTML += '				<th>차량 반납일</th>';
					vHTML += '				<td>'+ list[i].rtDt +' ('+ returnNumday +') '+ list[i].rtHm +'</td>';
					vHTML += '			</tr>';
					vHTML += '			<tr>';
					vHTML += '				<th>인수 장소</th>';
					vHTML += '				<td>('+ list[i].nationKrNm + ')' + list[i].pickupLoc +'</td>';
					vHTML += '			</tr>';
					vHTML += '			<tr>';
					vHTML += '				<th>반납 장소</th>';
					vHTML += '				<td>('+ list[i].nationKrNm + ')' + list[i].rtLoc +'</td>';
					vHTML += '			</tr>';
					vHTML += '			<tr>';
					vHTML += '				<td colspan="2" style="color:#ff7878;background:#f6f6f8;text-align:center;">* 렌터카 추가사항은 현장에 장비를 보유한 경우 추가 할 수 있습니다. (추가비용 발생)</td>';
					vHTML += '			</tr>';
					vHTML += '			<tr>';
					vHTML += '				<th>렌터카 총 운임</th>';
					vHTML += '				<td class="tr"><span class="f_purple">'+ comma(list[i].orgAmt) +'</span> '+ list[i].currencyCd +'</td>';
					vHTML += '			</tr>';
					vHTML += '		</table>';
					vHTML += '	</dd>';
					vHTML += '</dl>';
					
					
					vDvHTML += '<table class="ft_table2 ft_tb_tl step4app mt7">';
					vDvHTML += '	<colgroup>';
					vDvHTML += '		<col style="width:28%">';
					vDvHTML += '		<col style="width:72%">';
					vDvHTML += '	</colgroup>';
					vDvHTML += '	<tbody>';
					vDvHTML += '	<tr>';
					vDvHTML += '		<th>차량명</th>';
					vDvHTML += '		<td class="f_purple">'+ list[i].carModelNm +'</td>';
					vDvHTML += '	</tr>';
					vDvHTML += '	<tr>';
					vDvHTML += '		<th>차량크기</th>';
					vDvHTML += '		<td class="f_purple">'+ list[i].carSizeNm +'</td>';
					vDvHTML += '	</tr>';
					vDvHTML += '	</tbody>';
					vDvHTML += '</table>';
					vDvHTML += '<table class="ft_table2 ft_tb_tl step4app mt7">';
					vDvHTML += '	<colgroup>';
					vDvHTML += '		<col style="width:28%">';
					vDvHTML += '		<col style="width:72%">';
					vDvHTML += '	</colgroup>';
					vDvHTML += '	<tbody>';
					vDvHTML += '	<tr>';
					vDvHTML += '		<th>한글명</th>';
					vDvHTML += '		<td>'+ list[i].operNmKr +'<em>운전자</em></td>';
					vDvHTML += '	</tr>';
					vDvHTML += '	<tr>';
					vDvHTML += '		<th>영문 성/이름</th>';
					vDvHTML += '		<td>'+ list[i].operNm +'</td>';
					vDvHTML += '	</tr>';
					vDvHTML += '	<tr>';
					vDvHTML += '		<th>생년월일</th>';
					vDvHTML += '		<td>'+ list[i].operAgeGb +'</td>';
					vDvHTML += '	</tr>';
					vDvHTML += '	<tr>';
					vDvHTML += '		<th>연락처</th>';
					vDvHTML += '		<td>'+ list[i].operTelno +'</td>';
					vDvHTML += '	</tr>';
					vDvHTML += '	</tbody>';
					vDvHTML += '</table>';
					
					if(list[i].rntStateGb == "OK"){
						$("#btn_rnt_cancel").show();
					}else{
						$("#btn_rnt_cancel").hide();
					}
					
					if(list[i].rntStateGb == "OK" && rsvCancelBtnYn){
						$("#reserveCancelBtn").show();
						$("#reserveCancelBtn").parent().removeClass("btn_one");
						$("#reserveCancelBtn").parent().addClass("btn_two");
					}else{
						$("#reserveCancelBtn").hide();
						$("#reserveCancelBtn").parent().removeClass("btn_two");
						$("#reserveCancelBtn").parent().addClass("btn_one");
						
						rsvCancelBtnYn = false;
					}
					
					if(list[i].rntStateGb == "CA"){
						rntStateCd = false;
					}else{
						rntStateCd = true;
					}
				}
				
				$("#rentcarInfo").html(vHTML);
				$("#driverInfo").html(vDvHTML);
			},
			error: function(err){
			},
			complete: function(){
			}
		});
	}
	
	function getWeeks(col) {
		var dayName=new Array("일", "월", "화", "수", "목", "금", "토"); // 숫자 요일을 문자 요일 바꿀 함수		
		return dayName[col];
	}
	
	//  항공 결제 내역 조회 
	function fn_srchRsvAirPaymentList() {
		var formData = new FormData();
		formData.append("fitRsvNo", '${fitRsvNo}');
		
		var paymentList;

		cfn_ajax({
			type : "POST",
			async : false,
			url: "/free/account/srchRsvAirPaymentAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 5 * 60 * 1000,
			success: function(data) {
				paymentList	=	data.paymentList;
				var html = "";
				if(paymentList != null) {
					for (var i = 0; i < paymentList.length; i++) {
	
						var cashAmt = 0;
						if(paymentList[i].cashAmt != null || paymentList[i].cashAmt > 0){
							cashAmt = paymentList[i].cashAmt;
						}
						var cardAmt = 0;
						if(paymentList[i].cardPaymtAmt != null || paymentList[i].cardPaymtAmt > 0){
							cardAmt = paymentList[i].cardPaymtAmt;
						}
							html = html + "	<p class='obj_title2 obj_bg_wht mt7'><span class='ico_paym'>결제내역</span></p>";
							html = html + "	<table class='ft_table2 ft_th_tl ft_tb_tr'>";
							html = html + "		<colgroup>";
							html = html + "			<col style='width:30%' />";
							html = html + "			<col style='width:70%' />";
							html = html + "		</colgroup>";
							html = html + "		<tbody>";
							if(nullToBlank(paymentList[i].actNo) != ""){
								html = html + "		<tr>";
								html = html + "			<th>입금은행</th>";
								html = html + "			<td>"+paymentList[i].bankNm+"</td>";
								html = html + "		</tr>";
								html = html + "		<tr>";
								html = html + "			<th>가상계좌번호</th>";
								html = html + "			<td>"+paymentList[i].actNo+"</td>";
								html = html + "		</tr>";
								html = html + "		<tr>";
								html = html + "			<th>입금마감시한</th>";
								html = html + "			<td>"+paymentList[i].paymtSchDt + " " +paymentList[i].paymtSchHm + "</td>";
								html = html + "		</tr>";
								html = html + "		<tr>";
								html = html + "			<th>미입금금액</th>";
								html = html + "			<td>"+comma(paymentList[i].cashAmt-paymentList[i].amtInput)+"</td>";
								html = html + "		</tr>";
							}
							
							if(nullToBlank(paymentList[i].cardPaymtSeqno) != ""){

								var inTr = html.indexOf("<tr>");  //[JEH] 이전에 그려진 tr이 있는지 check - 20180124
								
								if(inTr != -1){
									html	+= " <tr class='top_bold'>";
								}else{
									html	+= " <tr>";
								}
								
								html = html + "			<th>카드명</th>";
								html = html + "			<td>"+ paymentList[i].cardKiGb +"</td>";
								html = html + "		</tr>";
								html = html + "		<tr>";
								html = html + "			<th>결제금액</th>";
								html = html + "			<td>"+comma(paymentList[i].cardPaymtAmt)+"원</td>";
								html = html + "		</tr>";
								html = html + "		<tr>";
								html = html + "			<th>할부개월 수</th>";
								html = html + "			<td>"+ paymentList[i].cardInstallmnMn +"</td>";
								html = html + "		</tr>";
							}

							if(nullToBlank(paymentList[i].actNo) != "" || nullToBlank(paymentList[i].cardPaymtSeqno) != ""){
								html = html + "		<tr class='top_double'>";
								html = html + "			<th>총 결제금액</th>";
								html = html + "			<td>"+comma(cashAmt + cardAmt )+"원</td>";
								html = html + "		</tr>";
							}
							html = html + "		</tbody>";
							html = html + "	</table>";
					}

				}	
				$("#air_payment_list").html(html);
			},
			error : function(err) {
				console.log(err);
			},
			complete : function(e) {
				console.log(e);
			}
		}); 
	}
	
	//예약 취소
	var fn_rsvCancel = function() {
		/*
		if(nullToBlank(rsvCancelData) != '') {
			var cancelData = {
				'fitMix'  : rsvCancelData[0].fitMix,			//조합
				'suplrCd' : rsvCancelData[0].suplrCd,			//호텔 공급사
				'itineraryId' : rsvCancelData[0].itineraryId, //예약 고유id
				'email' : rsvCancelData[0].email,         //대표 예약자 메일    
				'reason' : 'OTH',
				'htlRsvSeqno' : rsvCancelData[0].htlRsvSeqno,
				'fitRsvNo'  : fitRsvNo,
				'confirmNum' : '1234'
			};
						
	 		gfn_callAjax ('/fit/htl/rsvHtlCancel.do', cancelData, 'fn_success');
		}
		*/
		
		var cancelYN = calTimeGap('arr');   //[JEH] 추가 20180112

		if(cancelYN == '환불불가'){
			alert('무료취소기한이 지난 호텔이 포함되어있어 예약을 취소 할 수 없습니다.');
			window.location.reload();
			return;
		}else{
			var info = fn_rtnActInfo('frmRtnActInfo'); //[JEH] 환불계좌정보 check
	
			if(info){
				
				var rfdBankCd = $("select[name=rfdBankCd]").val();
				var rfdActNo = $("#rfdActNo").val();
				
				setConfirm("예약을 취소하시겠습니까?" , function() {
	
						gfn_loading_bar_draw3('show');
						
						var formData = new FormData();
						formData.append("fitRsvNo", fitRsvNo);
						
						//환불계좌정보 append
						formData.append("rfdBankCd", rfdBankCd);
						formData.append("rfdActNo", rfdActNo);
						
						setTimeout(function(){
							cfn_ajax({
								type : "POST",
								async : false,
								url: "/fit/rsv/fitReserveCancel.do",
								data: formData,
								dataType: "json",
								cache : false,
								noloading : false,
								timeOut : 5 * 60 * 1000,
								success: function(data) {
									console.log("----cancel success!!");
									result = data.result;
									
									gfn_loading_bar_draw3('hide');
																					
									if(result.resultCode == 1){
										setAlert("예약취소 되었습니다.");
										//TOS 취소 연동
										if(devType ==0){
											document.location.href="http://fitdev.lottejtb.com/tos/sendCancelDataAjax.do";
											
										}else{
											document.location.href="https://fit.lottejtb.com/tos/sendCancelDataAjax.do";
										}
											
										history.back();
									}else{
										setAlert("예약취소를 실패했습니다. \n 다시 시도해 주세요.");
									}
								},
								error : function(err) {
									console.log("----cancel error!!");
									console.log(err);
									gfn_loading_bar_draw3('hide');
								},
								complete : function(e) {
									console.log("----cancel complete!!");
									gfn_loading_bar_draw3('hide');
								}
							});
						}, 500);
				},	 function(){
					return false;
				}, "알림", "확인", "취소");
			}
		}
		
	}
	
	var fn_success = function(_data) {
		var data = _data.htlresult;
		
		if(data.code == 1) {
			alert("호텔 예약이 취소되었습니다.");
		} else {
			alert("호텔 예약 취소 실패되었습니다.");
		}
		
	}
	
	//환불계좌정보
	function fn_rtnActInfo(formId){
		var actYN = 'N';
		var divStatus = 'N';
		
		actYN = $("#actYN").val();
		divStatus = $("#div_status").val();

		if(inAmt == '' || inAmt == null || inAmt == undefined){
			inAmt = 0;
		}

		if(actYN == 'Y'){
			if(divStatus == 'Y'){
				if($.trim($("#rfdBankCd").val()) == ''){
					alert('환불받으실 은행을 입력해주세요.');
					$("#rfdBankCd").focus();
					return false;
				}else if($.trim($("#rfdActNo").val()) == ''){
					alert('환불받으실 계좌번호를 입력해주세요.');
					$("#rfdActNo").focus();
					return false;
				}else{
					return true;
				}
			}else{
				if(inAmt > 0){
					alert('가상계좌로 결제하셨습니다. 환불받으실 계좌 정보를 입력해주세요.');
					$("#"+formId).append($("#div_rtn_act_info").html());
	// 				$("#div_rtn_act_info").show();
					$("#div_status").val('Y');
					$("#rfdBankCd").focus();
					return false;
				}else{
					$("#"+formId).remove();
//		 			$("#div_rtn_act_info").hide();
					$("#div_status").val('N');
					return true;
				}
			}
		}else{
			$("#"+formId).remove();
// 			$("#div_rtn_act_info").hide();
			$("#div_status").val('N');
			return true;
		}
	
	}
	
	
	// PNR 업데이트 
	function fn_syncPnr() {
		var cdata = fn_setPnrData();
		
		console.log(cdata);
		
		gfn_callAjax('/fit/air/syncRsvPNR.do', cdata, 'fn_showPnr', false);		
	}

	// PNR 업데이트 데이타 셋팅
	function fn_setPnrData() {
		
		// var ar_cnt = $(_obj).parents('[ft-att="fare_list"]').attr('ar-cnt');

		
		var cdata= {
			"gdsCd"		: '1A',		
			"rsvSeqno"  : '${rsvResult.getAirRsvSeqno()}'
		};
		
		return cdata;
	}

	// 처리 후 리턴을 받을 함수 
	function fn_showPnr(_data) {


	}	

	// 항공 운임 규정 조회
	function fn_fareCerti() {	
		
		
		var cdata = fn_setAvailData();
		
		console.log(cdata);
		
		gfn_callAjax('/fit/air/viewPnrFareCerti.do', cdata, 'fn_showCerti', false);

	}


	// 팝업 > 요금규정, 상세보기 팝업 호출시 넘겨줄 데이터 세팅
	function fn_setAvailData() {
		
		// var ar_cnt = $(_obj).parents('[ft-att="fare_list"]').attr('ar-cnt');

		
		var cdata= {
			"gdsCd"		: '1A',		
			"readTy"	: 'R',	
			"rsvSeqno"  : '${rsvResult.getAirRsvSeqno()}'
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
				} else if (fare_rule_info[f_idx].itemAttr == 'D') {
					cont_val = fare_rule_info[f_idx].itemTxt;
				}		
				certi_html.find('td.last').html(cont_val);		
				
				//리스트에 추가
				certi_list_div.append(certi_html);	
			}
		}
		
		$('table.certi_table').eq(c_idx).show();	//첫번째 요금 규정 노출
		acdon();

	}		

	/* *************************************************************************** */
	
	function fn_question() {
		location.href = '/mytour/pop_qna_list.do';
	}
	
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();
		
		$("#goPayBtn").off('click');
		$("#goPayBtn").on('click', function(){
			fn_goPay('${fitRsvNo}' , paymentPrice);
		});
		$("#btn_pay").hide();
		//if(nullToBlank(rsvSeqNo) != "" && parseInt(rsvSeqNo) > 0) {
		if(concMix.indexOf('A') > -1){
			fn_srchRsvAirMst();
			fn_srchRsvAirItinList();
			fn_srchRsvAirPaxList();

			$("#div_rsv_air").show();
			$("#div_rsv_air_member").show();
			// $("#btn_pay").hide();
			$("#air_payment_list").show();
		} else {
			$("#div_rsv_air").hide();
			$("#div_rsv_air_member").hide();
			$("#air_payment_list").hide();	
			// $("#btn_pay").hide();
		}
		
		if(concMix.indexOf('H') > -1){
			$("#div_rsv_hotel").show();
			$("#div_rsv_hotel_member").show();
			
			fn_srchRsvHtlInfo();
			$("#btn_pay").show();
		}else{
			$("#div_rsv_hotel").hide();
			$("#div_rsv_hotel_member").hide();
			$("#btn_pay").hide();
		}
		
		if(concMix.indexOf('C') > -1){
			$("#div_rsv_rentcar").show();
			$("#div_rsv_rent_member").show();
			
			fn_srchRsvRntMst();
			// $("#btn_pay").hide();
		}else{
			$("#div_rsv_rentcar").hide();
			$("#div_rsv_rent_member").hide();
			// $("#btn_pay").hide();
		}
		
		if('${rsvResult.getSaleAmtAir()}' != '0' && nullToBlank('${rsvResult.getSaleAmtAir()}') != ""){
			$("#payment_air").text(comma('${rsvResult.getSaleAmtAir()}')+'원');
			$("#payment_air2").text(comma('${rsvResult.getSaleAmtAir()}')+'원');
			$("#payment_air3").text(comma('${rsvResult.getSaleAmtAir()}')+'원');
		}else{
			$("#airPaymentArea").hide();
		}
		
		if('${rsvResult.getSaleAmtHtl()}' == '0' || nullToBlank('${rsvResult.getSaleAmtHtl()}') == ""){
			$("#htlPaymentArea").hide();
		}
		
		if('${rsvResult.getSaleAmtRnt()}' == '0' || nullToBlank('${rsvResult.getSaleAmtRnt()}') == ""){
			$("#rntPaymentArea").hide();
		}
		
		//$("#payment_hotel").text(comma('${rsvResult.getSaleAmtHtl()}')+'원');
		$("#payment_rentcar").text(comma('${rsvResult.getSaleAmtRnt()}')+'원');
		
		var promoHTML = "";
		if(nullToBlank('${rsvResult.getAirDiscntAmt()}') != "" && '${rsvResult.getAirDiscntAmt()}' != '0'){
			promoHTML += '<p class="ppred">항공 프로모션(항공 별도 할인) <span id="air_payment_promo" name="payment_promo">-'+ comma('${rsvResult.getAirDiscntAmt()}') +'원</span></p>';	
		}
		
		if(nullToBlank('${rsvResult.getHtlDiscntAmt()}') != "" && '${rsvResult.getHtlDiscntAmt()}' != '0'){
			promoHTML += '<p class="ppred">호텔 프로모션 <span id="htl_payment_promo" name="payment_promo">-'+ comma('${rsvResult.getHtlDiscntAmt()}') +'원</span></p>';
		}
		
		if(nullToBlank('${rsvResult.getRntDiscntAmt()}') != "" && '${rsvResult.getRntDiscntAmt()}' != '0'){
			promoHTML += '<p class="ppred">렌터카 프로모션 <span id="rnt_payment_promo" name="payment_promo">-'+ comma('${rsvResult.getRntDiscntAmt()}') +'원</span></p>';
		}
		
		if(nullToBlank('${rsvResult.getHtlDiscntAmt()}') != '')
			paymentPrice = parseInt(paymentPrice) - parseInt('${rsvResult.getHtlDiscntAmt()}');
		else
			paymentPrice = parseInt(paymentPrice);
		
		if(nullToBlank('${rsvResult.getPromId()}') != ""){
			if("${rsvResult.getPromAmount()}" != "0"){
				paymentPrice = paymentPrice - parseInt("${rsvResult.getPromAmount()}");
				
				promoHTML += '<p class="ppred">' +'${rsvResult.getPromNm()}'+ '<span id="mix_payment_promo" name="payment_promo">-'+ comma('${rsvResult.getPromAmount()}') +'원</span></p>';
			}
			
			if("${rsvResult.getPromRate()}" != "0"){
				var totPayment = paymentPrice + parseInt('${rsvResult.getSaleAmtAir()}') + parseInt('${rsvResult.getSaleAmtRnt()}');
				var promRate = ((totPayment - parseInt('${rsvResult.getAirDiscntAmt()}') - parseInt('${rsvResult.getRntDiscntAmt()}')) * parseFloat("${rsvResult.getPromRate()}")).toFixed();
				paymentPrice = paymentPrice - promRate;
				
				promoHTML += '<p class="ppred">' +'${rsvResult.getPromNm()}'+ '<span id="mix_payment_promo" name="payment_promo">-'+ comma(promRate) +'원</span></p>';
			}
		}
		
		$("#promoDiv").html(promoHTML);
		
		var totalSum = 0;
		if('${rsvResult.getSaleAmtAir()}' != '0' && nullToBlank('${rsvResult.getSaleAmtAir()}') != "") //항공 
			totalSum += parseInt('${rsvResult.getSaleAmtAir()}'); 
		if('${rsvResult.getSaleAmtRnt()}' != '0' && nullToBlank('${rsvResult.getSaleAmtRnt()}') != "") //렌트카
			totalSum += parseInt('${rsvResult.getSaleAmtRnt()}');
		
			
		totalSum += paymentPrice;
		
		//전체상품가
		$('#total_priceArea').show();
		$('#total_price').text(comma(totalSum)+'원');
		
		//패키지 상품 패키지 할인가가 있는 경우 
		if(concMix != 'XHX' && pkgAmt > 0)
			totalSum = totalSum - pkgAmt;
	
		$("#payment_total").text(comma(totalSum)+'원');
		
		setTimeout(function(){
			if(!airStateCd && !htlStateCd && !rntStateCd){
				$("#emailAndCancelBtn").hide();
			}else{
				$("#emailAndCancelBtn").show();
			}
		}, 100);

		// 항공 운임규정 조회
		fn_fareCerti();

		// 항공 결제 내역 조회 
		fn_srchRsvAirPaymentList();
	});
	

	$("#rfdActNo").keyup(function(){$(this).val( $(this).val().replace(/[^\!-z]/g,"") );} );
	

	//[JEH] 환불은행 목록 조회
	function fn_srchRfdBankCd(){
		var formData = new FormData();
		var grpCd = "FT016";
		formData.append("grpCd", grpCd);
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/free/account/listComCdAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			success: function(data) {
				
				var bnkList	=	data.commCdList;
				var html = "<option value=''>선택하세요</option>";
				
				if(bnkList.length > 0){
					for(var i = 0; i < bnkList.length; i++){
						html += "<option value='" + bnkList[i].cd + "'>" + bnkList[i].cdNmKr + "</option>";
					}
				}
					$("#rfdBankCd").html(html);
				
			},
			error : function(err) {
				console.log(err);
			},
			complete : function(e) {
			}
		});
	}
	

	//[JEH] 서버시간 20180112
	function srvTime(){
		var xmlHttp;
	
		if (window.XMLHttpRequest) {//분기하지 않으면 IE에서만 작동된다.
			xmlHttp = new XMLHttpRequest(); // IE 7.0 이상, 크롬, 파이어폭스 등
			xmlHttp.open('HEAD',window.location.href.toString(),false);
			xmlHttp.setRequestHeader("Content-Type", "text/html");
			xmlHttp.send('');
			return xmlHttp.getResponseHeader("Date");
		}else if (window.ActiveXObject) {
			xmlHttp = new ActiveXObject('Msxml2.XMLHTTP');
			xmlHttp.open('HEAD',window.location.href.toString(),false);
			xmlHttp.setRequestHeader("Content-Type", "text/html");
			xmlHttp.send('');
			return xmlHttp.getResponseHeader("Date");
	
		}

	};

	//[JEH] 자릿수 맞춰주기 20180112
	function addZeros(num, digit) { 
		  var zero = '';
		  num = num.toString();
		  if (num.length < digit) {
		    for (i = 0; i < digit - num.length; i++) {
		      zero += '0';
		    }
		  }
		  return zero + num;
	};

	//[JEH] 현재시간과 환불가능시간의 차이를 계산 20180112
	function calTimeGap(repType){

		var srv = srvTime();
		var now =  new Date(srv);

		var yyyy = now.getFullYear();
		var mm = addZeros(now.getMonth()+1,2);
		var dd = addZeros(now.getDate(),2);
		var h = addZeros(now.getHours(),2);
		var m = addZeros(now.getMinutes(),2);
		var s = addZeros(now.getSeconds(),2);
		
		var nowTime = yyyy + "-" + mm + "-" + dd + " " + h + ":" + m + ":" + s;
		
		if(repType == 'arr'){		//array 변수를 체크한다(취소요청을 클릭했을때 시간을 다시 체크하기 위함)
			for(var i = 0; i < arr_cancelDL.length; i++){

		 		if(arr_cancelDL[i] != null && arr_cancelDL[i] != '환불불가'){

		 			var cancelTime = arr_cancelDL[i] + ":00";

		 			if(nowTime >= cancelTime){
		 				cancelStatus = '환불불가';
		 			}else{
		 				cancelStatus = arr_cancelDL[i];
		 			}

		 		}else{
		 			cancelStatus = '환불불가';
		 		}
			}
		}else{		//단건에 대한 변수를 체크한다(예약 리스트 호출시 체크)

	 		if(cancelDL_GB != null && cancelDL_GB != '환불불가'){
	 			
	 			var cancelTime = cancelDL_GB + ":00";
	 			
	 			if(nowTime >= cancelTime){
	 				cancelStatus = '환불불가';
	 			}else{
	 				cancelStatus = cancelDL_GB;
	 			}

	 		}else{
	 			cancelStatus = '환불불가';
	 		}
		}

		return cancelStatus;
	};
</script>
</head>
<form name="f_frm" id="f_frm" method="post">
	<input type="hidden" name="selAir" id="selAir"  value="${selAir}" />
	<input type="hidden" name="selHotel" id="selHotel" value="${selHotel}" />
	<input type="hidden" name="selRentcar" id="selRentcar" value="${selRentcar}" />
</form>	

<!--content-->
<div role="main" class="ui-content contentWrap freesearch">
	<div class="navstitle freeback">
		예약정보<a href="javascript:history.back(-1);">뒤로</a>
	</div>
	<div class="free_reserve collapse fr_rdetail">
		<p class="obj_title2 mt7">
			<span class="ico_info">예약상품정보</span>
		</p>
		<div id="div_rsv_air" name="div_rsv_air" style="display:none">
			<table class="ft_table2 ft_wht">
				<colgroup>
					<col style="width: 30%" />
					<col style="width: 70%" />
				</colgroup>
				<tr>
					<th>인원</th>
					<td>성인 <span id='air_adt_cnt' name='air_adt_cnt'>0</span>명, 아동 <span id='air_chd_cnt' name='air_chd_cnt'>0</span>명, 유아 <span id='air_inf_cnt' name='air_inf_cnt'>0</span>명</td>
				</tr>
				<tr class="tb_purple">
					<th>항공 총 운임</th>
					<td colspan="3"><span id="payment_air" name="payment_air"></span></td>
				</tr>
			</table>

			<!-- 항공 예약 정보 -->
			<%@include file="/WEB-INF/jsp/account/inc_free_info_detail_air.jsp" %>
			<!-- 항공 예약 정보 -->
		</div>
		<div id="air_payment_list" name="air_payment_list">
		</div>
		<div id="div_rsv_air_member" name="div_rsv_air_member" style="display:none">
			<%@include file="/WEB-INF/jsp/account/inc_free_info_detail_air_member.jsp" %>
		</div>

		<div id="div_rsv_hotel" name="div_rsv_hotel" style="display:none">
			<!-- 호텔 예약 정보 -->
			<%@include file="/WEB-INF/jsp/account/inc_free_info_detail_hotel.jsp" %>
			<!-- 호텔 예약 정보 -->
		</div>

		<div id="div_rsv_rentcar" name="div_rsv_rentcar" style="display:none">
			<!-- 렌트카 예약 정보 -->
			<%@include file="/WEB-INF/jsp/account/inc_free_info_detail_rentcar.jsp" %>
			<!-- 렌트카 예약 정보 -->

		</div>
		<!-- <p class="obj_title2 obj_bg_wht mt7"><span class="ico_paym">결제내역</span></p> -->
			
			<table class="ft_table2 ft_th_tl ft_tb_tr">
				<colgroup>
					<col style="width:30%" />
					<col style="width:70%" />
				</colgroup>
				<div id="paymtInfo">
					<!-- <tbody>
					<tr>
						<th>L.point 사용금액</th>
						<td>-</td>
					</tr>
					<tr>
						<th>롯데JTB상품권</th>
						<td>-</td>
					</tr>
					<tr>
						<th>사용금액</th>
						<td>-</td>
					</tr>
					<tr>
						<th>카드명</th>
						<td>-</td>
					</tr>
					<tr>
						<th>결제완료금액</th>
						<td>-</td>
					</tr>
					<tr>
						<th>할부개월수</th>
						<td></td>
					</tr>
					<tr>
						<th>입금은행</th>
						<td></td>
					</tr>
					<tr>
						<th>가상계좌번호</th>
						<td></td>
					</tr>
					<tr>
						<th>임금마감시한</th>
						<td></td>
					</tr>
					<tr>
						<th>미입급금액</th>
						<td></td>
					</tr>
					</tbody> -->
				</div>	
			</table> 
			
		<!-- 결제 -->
		<dl class="pop_chk_list pop_chk_list2 mt7">
			<dt class="pop_avtitle2">결제금액</dt>
			<dd class="pop_paytext1">
				<p id="airPaymentArea">
					항공(별도 결제) <span id="payment_air2" name="payment_air2"></span>
				</p>
				<p id="htlPaymentArea">
					호텔 <span id="payment_hotel" name="payment_hotel"></span>
				</p>
				<p id="rntPaymentArea">
					렌터카(후불) <span id="payment_rentcar" name="payment_rentcar"></span>
				</p>
				<p id="total_priceArea">
					전체상품가 <span id="total_price" name="total_price"></span>
				</p>
				<p id="pkg_discntArea">
					패키지할인가 <span id="pkg_discnt" name="pkg_discnt"></span>
				</p>
				
				<div id="promoDiv"></div>
			</dd>
		</dl>
		<p class="pop_avtitle3">
			총 결제예정금액 <span id="payment_total" name="payment_total">0</span>
		</p>
		<div class="pop_bt_text1 pop_bt_text2">
			<ul class="dotlist3">
				<li>항공 : 유류할증료&amp;제세공과금 포함</li>
				<li>호텔 : TAX, 봉사료 포함</li>
				<li>렌터카 : 후불 (현지에서 현지 통화료 결제)</li>
			</ul>
		</div>
		
		<div id="div_rsv_air_member" name="div_rsv_air_member" style="display:none">
			<!-- 항공 예약자 정보 -->
			<%@include file="/WEB-INF/jsp/account/inc_free_info_detail_air_member.jsp" %>
			<!-- 항공 예약자 정보 -->
		</div>
		<div id="div_rsv_hotel_member" name="div_rsv_hotel_member" style="display:none">
			<!-- 호텔 숙박자 정보 -->
			<%@include file="/WEB-INF/jsp/account/inc_free_info_detail_hotel_member.jsp" %>
			<!-- 호텔 숙박자 정보 -->
		</div>		
		<div id="div_rsv_rent_member" name="div_rsv_rent_member" style="display:none">
			<!-- 렌터카 운전자 정보 -->
			<%@include file="/WEB-INF/jsp/account/inc_free_info_detail_rentcar_member.jsp" %>
			<!-- 렌터카 운전자 정보 -->
		</div>
		
		
		<div id="frmRtnActInfo"></div>
<!-- 		환불계좌정보 템플릿 -->
		<div id="div_rtn_act_info" style="display:none;">
			<input type="hidden" id="div_status" name="div_status" value="N" />
			<p class="obj_title2">
				<span class="ico_paym">환불 계좌 정보(예약자 명의의 계좌로만 환불 가능합니다.)</span>
			</p>
			<table class="ft_table2 ft_tb_tl step4app mt7">
					<colgroup>
						<col style="width: 28%">
						<col style="width: 72%">
					</colgroup>
					<tbody>
						<tr>
							<th>은행</th>
							<td>
<!-- 								<input type="text" id="rfdBankCd" name="rfdBankCd" /> -->
								<select id="rfdBankCd" name="rfdBankCd" data-role="none" style="width:100%;">
									
								</select>
							</td>
						</tr>
						<tr>
							<th>계좌번호</th>
							<td>
								<input type="number" id="rfdActNo" name="rfdActNo" data-role="none" pattern='[0-9]*' onkeydown='return f_Onlynum();' style="width:100%;" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			
			
		<!-- 버튼 -->
		<!-- 
		<div class="btn_one air_tbtn" id="btn_pay" name='btn_pay'>
			<button class="purple2" data-role="none" id="goPayBtn" >결제하기</button>
		</div>
		 -->
		<div class="btn_two air_tbtn addbtn2" id="emailAndCancelBtn">
		
			
			
			<button class="layerOpener white2" data-url="/pop/pop_email.do?rsvSeqno=${fitRsvNo}"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'>메일보내기</button>
			<!-- button class="white2" data-role="none" onclick="fn_rsvCancel();">메일보내기</button -->
			<button class="white2" id="reserveCancelBtn" data-role="none" onclick="fn_rsvCancel();">예약취소</button>
		</div>
		<div class="btn_one air_tbtn">
			<button class="purple2" data-role="none" onclick="history.back();">확인</button>
		</div>
		<div class="btn_one qna_tbtn"><button class="purple2" data-role="none" onclick="fn_question();" style="height:40px">문의하기</button></div>
	</div>
	<!--bottom-->
	<script src="/resources/common/bottom.js"></script>
	<!--bottom-->
</div>
<!--//content-->
