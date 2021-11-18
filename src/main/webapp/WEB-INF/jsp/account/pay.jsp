<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.lottejtb.goods.rn.service.* "%>
<%@ page import="com.lottejtb.reserve.service.* "%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.net.*"%>
<%@ page import="com.lottejtb.util.*"%>
<%@ page import="com.lottejtb.comm.util.*"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>

<%
	ReserveVO reservMst = (ReserveVO) request.getAttribute("reservMst");
	List reservRosterList = (List) request.getAttribute("reservRosterList");
	RNETMstVO rnEtMst = (RNETMstVO) request.getAttribute("rnEtMst");
	String knm	=	(String) request.getAttribute("knm");

	String cno = (String) request.getAttribute("cno");
	String M_TX_NUM = (String) request.getAttribute("M_TX_NUM");
%>
<head>
<script type="text/javascript" src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
<script type="text/javascript">
//var _userId = '${userInfo.userId}';
var payAmtInfo = {}; // 결제금액 정보
var proofCheck	=	"";

$(document).ready(function() {
  fn_init();
  fn_initEvent();
  
});

/**
 * 초기화
 */
function fn_init() {

	$("#submitLpayValue").hide();
	$("#lpayAprvIf").hide();
	$("#dlp").hide();
	$("#lpayTranCertIf").hide();
	$("#lpayMemCertIf").hide();
	$("#sub").hide();
	$("#dlp").hide();
	$("#dlpcard").hide();
	//$("#lpay").hide();
	
	$("#form1").hide();
	$("#form3").hide();
	
	$("#lpay").click(function(){
		
	});
	
	var formData = new FormData();
	cfn_ajax({
		type : "POST",
		async : false,
		url: "/account/LPointSrcAjax.do",
		data: formData,
		dataType: "json",
		cache : false,
		noloading : "yes",
		timeOut : 5 * 60 * 1000,
		success: function(data) {
			if(data.code == "00"){
				var usePoint	=	comma(parseInt(data.usePoint));
				
				var usePointTxt = "LPOINT (" + usePoint + "점)";
				
				$('#hiddenUseLpoint').val(usePoint);
				$('#useablepoint').text(usePointTxt);
			}
		},
		error : function(err) {
			setAlert("결제 도중 오류가 발생하였습니다.");
			console.log(err);
		},
		complete : function(e) {
			console.log(e);
			fn_depositHistory();
		}
	}); 

}

 //입금내역
 function fn_depositHistory() {
	 var formData = new FormData();
	 formData.append('RES_CD', '${reservMst.getRes_cd()}');
	 
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/account/depositHistoryAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 5 * 60 * 1000,
			success: function(data) {
				var data = data.dopositHistory;
				//var ioday = data[0].io_DAY;   //입금날짜
				var ioday;
				var ioFgCd;
				var ioDetailCd;
				var stsCd;
				var ioAmt = 0;
				var toTalPrice = 0;
				var cashReceipt;
				
				if(data != null) {
		
					vHtml = '';
					for(var i=0; i < data.length; i++) {
						
						ioDetailCd = data[i].io_DETAIL_CD;  //결제유형
						stsCd = data[i].status_CD;  //입금상태
						//ioAmt = parseInt(data[i].io_AMT);
						cashReceipt = data[i].cash_RECEIPT_FG;
						
						if(ioday == "") ioday = '-';
						else ioday=	data[0].io_DAY.substring(0, 4) + "-" + data[0].io_DAY.substring(4, 6) + "-" + data[0].io_DAY.substring(6);
						
						if(ioFgCd == "") ioFgCd = '-';
						if(ioDetailCd == "") ioDetailCd = '-';
						if(cashReceipt == "") cashReceipt = '-';
						
						//if(ioAmt == "") ioAmt = '-'; else ioAmt = comma(ioAmt);
						
						if((ioFgCd != '가상계좌') || (ioFgCd != '가상계좌' && stsCd != 'WT')) {
						
							ioFgCd = data[i].io_FG_CD; //결제수단
							if(ioFgCd == '카드') ioFgCd = "신용" + ioFgCd;
						}
						
						//입금상태
						if(stsCd == 'RK') { //환불완료
							stsCd = '환불';
						}else if(ioFgCd != '가상계좌' && ioFgCd != '은행' && stsCd != 'CX') {
							stsCd = '입금완료';
						}else if(ioFgCd != '가상계좌' && ioFgCd != '은행' && stsCd == 'CX') {
							stsCd = '입금취소';
						}else if(ioFgCd == '가상계좌' && stsCd == 'WT') {
							stsCd = '입금대기';
						}else if(ioFgCd == '가상계좌' && stsCd == 'CX') {
							stsCd= '입금취소';
						}else if(ioFgCd == '가상계좌' && stsCd == 'OK') {
							stsCd= '입금완료';
						}else if(ioFgCd == '은행' && stsCd == 'OK') {
							stsCd= '입금완료';
						}else if(ioFgCd == '은행' && stsCd == 'CX') {
							stsCd= '입금취소';
						}else 
							stsCd= '-';
						
						//
						
						
						vHtml +="	<tr>";
						vHtml +="		<th>입금날짜</th>";
						//vHtml +="		<td>" + ioday + "</td>";
						vHtml +="		<td>" + data[i].display1 + "</td>";
						vHtml +="	</tr>";
						vHtml +="	<tr>"
						vHtml +="		<th>결제수단</th>";
						//vHtml +="		<td>" + ioFgCd + "</td>";
						vHtml +="		<td>" + data[i].display2 + "</td>";
						vHtml +="	</tr>";
						vHtml +="	<tr>"
						vHtml +="		<th>결제유형</th>";
						//vHtml +="		<td>" + ioDetailCd + "</td>";
						vHtml +="		<td>" + data[i].display3 + "</td>";
						vHtml +="	</tr>";
						vHtml +="	<tr>";
						vHtml +="		<th>입금상태</th>";
						//vHtml +="		<td>" + stsCd+ "</td>";
						vHtml +="		<td>" + data[i].display4+ "</td>";
						vHtml +="	</tr>";
						vHtml +="	<tr>";
						vHtml +="		<th>금액</th>";
						//vHtml +="		<td>" + data[i].io_AMT + "원</td>";
						vHtml +="		<td>" + data[i].display5 + "원</td>";
						vHtml +="	</tr>";
						/*
						vHtml +="	<tr>";
						vHtml +="		<th>영수증</th>";
						vHtml +="		<td>-</td>";
						vHtml +="	</tr>";
						vHtml +="	<tr>";
						vHtml +="		<th>현금영수증</th>";
						vHtml +="		<td>"+ cashReceipt + "</td>";
						vHtml +="	</tr>";
						*/
						vHtml += "	<tr>";
						vHtml += "		<th style='background:#eee;height:3px;padding:0px !important;'></th>";
						vHtml += "		<td style='background:#eee;height:3px;padding:0px !important;'></td>";
						vHtml += "	</tr>";

						//[JEH] 아래 조건문 변수 stsCd -> data[i].status_CD 로 변경 20171106
						if(data[i].status_CD != 'CX') {  //취소완료상태가 아니고
							if(data[i].status_CD == 'RK') { //환불완료 이면
								toTalPrice -= parseInt(data[i].io_AMT);									
							} else {
								toTalPrice += parseInt(data[i].io_AMT);
							}
						}
					}
					
					vHtml +="	<tr class='tb_purple'>";
					vHtml +="		<th class='white2'>입금총액</th>";
					vHtml +="		<td>"+ comma(toTalPrice) +"원</td>";
					vHtml +="	</tr>";
										
					var totalAmt = 0;
					totalAmt = "${reservMst.getSale_amt()}";

					$("#toTalPriceText").text(comma(toTalPrice) + "원");
					totalAmtText	=	parseInt(totalAmt) - parseInt(toTalPrice);
						
					$("#totalAmt").text(comma(totalAmtText) + "원");
				} else {
					vHtml = '';
					vHtml +="	<div>";
					vHtml +="		<p><br> 입금 하신 내역이 없습니다.</p><br>";
					vHtml +="	</div>";
				}
				$('#dopositID').html(vHtml);		
					
			},
			error : function(err) {
				console.log(err);
			},
			complete : function(e) {
				console.log(e);
			}
		}); 
 }



/**
 * 이벤트 초기화
 */
function fn_initEvent() {
	$('#card').click(function(){
		$('input[name=paymentMethod]').val("Card");			// 신용카드
		$("#userConfirm").show();
	});
	$('#virtual').click(function(){
		$('input[name=paymentMethod]').val("VBank");		// 무통장입금(가상계좌)
		$("#userConfirm").show();
	});
	$('#real').click(function(){
		$('input[name=paymentMethod]').val("DirectBank");	// 실시간계좌이체
		$("#userConfirm").show();
	});
	$('#dual').click(function(){
		$('input[name=paymentMethod]').val("Etc");			// 복합결제
		$("#userConfirm").show();
	});
	$('#lpay').click(function(){
		$('input[name=paymentMethod]').val("Lpay");			// LPAY
		
		$("#userConfirm").hide();

		var check_form = $('form[ft-att="check"]');
		
		if( check_form.find("#MEM_M_NUM").val() == ""	){
			$('.paylist_chkbox2 #card').click();
			
			setAlert("로그인을 하여 주십시요.");
			return;
		}
		
		//맴버인증
		lpayMemCertIf();
	});
	
	$('#schGift').click(function(){
		schGift("giftNo");			// 상품권조회
	});

 
	// 결제하기
	$('#btnPayment').on("click", function(){
		var submitform1 = $('form[ft-att="form1"]');	//	가상계좌
		var submitform3 = $('form[ft-att="form3"]');	//	신용카드
		var pointCheck = "0";
		
		//[JEH] 롯데면세점 프로모션일경우 - 20190510
		if("${rnEtMst.goods_cd}" == 'PGI1011'){
			$('input[name=paymentMethod]').val("Card")	;
			pointCheck = "0";
		}else{
	 		pointCheck	=	$('input[name="lottePoint"]').val();
		}
		

		if((pointCheck.trim() != "" && pointCheck.trim() != "0") && $('input[name="wpw"]').val() == ""	){
			if($("#lpay").hasClass("active")){
				var totLpoint = $("#hiddenUseLpoint").val();
				
				if(parseInt($("#totalAmt").text().replace('원','').replace(/,/gi, '')) == 0){
					setAlert("L.Point 본인확인을 하여 주십시요.");
					return;
				}
			}else{
				setAlert("L.Point 본인확인을 하여 주십시요.");
				return;
			}
		}
			
		if("Lpay" == $('input[name=paymentMethod]').val()){
			lpayTranCertIf();
		}else{
			
			if($('#userEmail').val() == "" || $('#userEmail').val() == null){
				setAlert("이메일을 입력해 주세요");
				$('#userEmail').fucus();
				return;
				
			}
	
			if($('#phoneNumber').val() == "" || $('#phoneNumber').val() == null){
				setAlert("이동전화를 입력해 주세요");
				$('#phoneNumber').fucus();
				return;
				
			}
			
			var formData = new FormData();
			var payPrice	= $("#totalAmt").text().replace('원','').replace(/,/gi, '');
			var type		=	"";
			
			if($('input[name=paymentMethod]').val() == "VBank"){	//	가상계좌
				type	=	"VBank";
			}else{
				type	=	"Card";
			}
			//payPrice	=	"1004";
			formData.append('price', payPrice);
			formData.append('type', type);
			
	 		cfn_ajax({
				type : "POST",
				async : false,
				url: "/account/getPayPriceAjax.do",
				data: formData,
				dataType: "json",
				cache : false,
				noloading : "yes",
				timeOut : 5 * 60 * 1000,
				success: function(data) {
					result	=	data.paymentVo;
					
					submitform1.find("#P_MID").val(result.mId);
					submitform1.find("#P_NEXT_URL").val(result.returnUrl);
					submitform1.find("#P_OID").val(result.oId);
					
					submitform3.find("#P_MID").val(result.mId);
					submitform3.find("#P_NEXT_URL").val(result.returnUrl);
					submitform3.find("#P_OID").val(result.oId);

//					$('input[name="goodname"]').val("테스트상품"); // 상품명

					console.log("P_MID:" + submitform3.find("#P_MID").val());
					console.log("P_NEXT_URL:" + submitform3.find("#P_NEXT_URL").val());
					console.log("P_OID:" + submitform3.find("#P_OID").val());
//					console.log("P_GOODS:" + submitform3.find("#P_GOODS").val("테스트상품"));
										
				},
				error : function(err) {
					setAlert("결제 도중 오류가 발생하였습니다.");
					console.log(err);
				},
				complete : function(e) {
					console.log(e);
				}
			}); 
	
	 		// 결제 수단
	 		
	 		var paymentMethod = $('input[name=paymentMethod]').val();
			//[JEH] 롯데면세점 프로모션일경우 신용카드(하나)로 고정 - 20190510
			if("${rnEtMst.goods_cd}" == 'PGI1011'){
				submitform3.find("#P_ONLY_CARDCODE").val("01");
			}

		  	if (paymentMethod !== '' || paymentMethod !== null) {
			  	var buyerEmail = ''; // 구매자 이메일
			  	var buyerTel = ''; // 구매자 전화번호
			  
			 	if (paymentMethod === 'Card') { // 신용카드
			 		payAmtInfo.payExpAmt = $("#totalAmt").text().replace('원','').replace(/,/gi, '');
			 		//payAmtInfo.payExpAmt = 1004;
			 	} else if (paymentMethod === 'VBank') { // 가상계좌(무통장입금)
	
	        		var acceptmethod = 'va_receipt';
	        		$('#acceptmethod').val(acceptmethod); // 초기화
	        
	        		// 현금영수증 미 발행 여부
			        if (!$('input:checkbox[id="cashReceipt"]').is(":checked")) {
						acceptmethod = 'no_receipt';
			        }
	        		$('#acceptmethod').val(acceptmethod);
					
					// 증빙 (가상계좌, 실시간 계좌이체)
	                var proof = document.getElementsByName("radio");
	                
	                for(var i=0;i< proof.length;i++){
	                     if(proof[i].checked){
	                         if(proof[i].value == "busi"){
	     				    	var $bizRegNo1 = $('#bizRegNo1');
	    				    	var $bizRegNo2 = $('#bizRegNo2');
	    				    	var $bizRegNo3 = $('#bizRegNo3');
	    			
	    				    	if ($bizRegNo1.val() === '') {
	    				    		setAlert('지출 증빙용 사업자 등록번호를 입력하세요.');
	    				    		$bizRegNo1.focus();
	    				    		return false;
	    				    	}
	    			    	
	    				    	if ($bizRegNo2.val() === '') {
	    				    		setAlert('지출 증빙용 사업자 등록번호를 입력하세요.');
	    				    		$bizRegNo2.focus();
	    				    		return false;
	    				    	}
	    			    	
	    				    	if ($bizRegNo3.val() === '') {
	    				    		setAlert('지출 증빙용 사업자 등록번호를 입력하세요.');
	    				    		$bizRegNo3.focus();
	    				    		return false;
	    				    	}
	    			    	
	    						var bizRegNo = $bizRegNo1.val() + $bizRegNo2.val() + $bizRegNo3.val();
	    						$('#vbankRegNo').val(bizRegNo);
	    						
	    						proofCheck	=	"busi";
	                         }else{
	     						var $cellCashCardNo1 = $('#cellCashCardNo1');
	    			      		if ($cellCashCardNo1.val() === '') {
	    			      			setAlert('스독공제 개인용 휴대폰 번호 또는 현금영수증 카드번호를 입력하세요.');
	    					        $cellCashCardNo1.focus();
	    					        return false;
	    						}
	    		
	    						$('#vbankRegNo').val($cellCashCardNo1.val());
	                         }
	                         
	                         break;
	                     }
	                }

			 		payAmtInfo.payExpAmt = $("#totalAmt").text().replace('원','').replace(/,/gi, '');
	        		//payAmtInfo.payExpAmt = 1004;
				} else if (paymentMethod === 'Etc') { // 복합결제
	
	 				var $cardPayAmt = $('#cardPayAmt');
			        
	        		if ($cardPayAmt.val() === '') {
	        			setAlert('카드 결제금액을 입력해 주세요.');
						$cardPayAmt.focus();
						return false;
					}
	        		
	        		payAmtInfo.payExpAmt = $cardPayAmt.val();
	        		
	        		var acceptmethod = 'va_receipt';
	        		$('#acceptmethod').val(acceptmethod); // 초기화
	        
	        		// 현금영수증 미 발행 여부
			        if (!$('input:checkbox[id="cashReceipt"]').is(":checked")) {
						acceptmethod = 'no_receipt';
			        }
	        		$('#acceptmethod').val(acceptmethod);
					
					// 증빙 (가상계좌, 실시간 계좌이체)
	                var proof = document.getElementsByName("radio");
	                
	                for(var i=0;i< proof.length;i++){
	                     if(proof[i].checked){
	                         if(proof[i].value == "busi"){
	     				    	var $bizRegNo1 = $('#bizRegNo1');
	    				    	var $bizRegNo2 = $('#bizRegNo2');
	    				    	var $bizRegNo3 = $('#bizRegNo3');
	    			
	    				    	if ($bizRegNo1.val() === '') {
	    				    		setAlert('지출 증빙용 사업자 등록번호를 입력하세요.');
	    				    		$bizRegNo1.focus();
	    				    		return false;
	    				    	}
	    			    	
	    				    	if ($bizRegNo2.val() === '') {
	    				    		setAlert('지출 증빙용 사업자 등록번호를 입력하세요.');
	    				    		$bizRegNo2.focus();
	    				    		return false;
	    				    	}
	    			    	
	    				    	if ($bizRegNo3.val() === '') {
	    				    		setAlert('지출 증빙용 사업자 등록번호를 입력하세요.');
	    				    		$bizRegNo3.focus();
	    				    		return false;
	    				    	}
	    			    	
	    						var bizRegNo = $bizRegNo1.val() + $bizRegNo2.val() + $bizRegNo3.val();
	    						$('#vbankRegNo').val(bizRegNo);
	    						
	    						proofCheck	=	"busi";
	                         }else{
	     						var $cellCashCardNo1 = $('#cellCashCardNo1');
	    			      		if ($cellCashCardNo1.val() === '') {
	    			      			setAlert('스독공제 개인용 휴대폰 번호 또는 현금영수증 카드번호를 입력하세요.');
	    					        $cellCashCardNo1.focus();
	    					        return false;
	    						}
	    		
	    						$('#vbankRegNo').val($cellCashCardNo1.val());
	                         }
	                         
	                         break;
	                     }
	                }
				  
				} else if (paymentMethod === 'Lpay') { 
					return;
				} else { // L.Pay 결제
	//				fn_authUserByLpay();
					setAlert("결제수단을 선택해 주세요");
					return;
				}
			}
			if($('#chk_ck10').is(":checked") == false) {
		  		alert("구매 동의에 체크해 주세요");
		  		return false;
		  	}
	
		  	///////////////////////////////
			//payAmtInfo.payExpAmt = 1004;
			var goodName = '<%=rnEtMst.getDisp_nm()%>';
			var buyerName = '<%=knm%>';
			///////////////////////////////
			
			buyerEmail	=	$('#userEmail').val();
			buyerTel	=	$('#phoneNumber').val();
			
			$('input[name="price"]').val(payAmtInfo.payExpAmt); 	// 총 결제금액			
			submitform1.find("#P_GOODS").val(goodName);
		  	submitform1.find("#P_AMT").val(payAmtInfo.payExpAmt);	//	총결제금액
		  	submitform1.find("#P_UNAME").val(buyerName);			//	구매자명
		  	submitform1.find("#P_MOBILE").val(buyerTel);			//	구매자 핸드폰번호
		  	submitform1.find("#P_EMAIL").val(buyerEmail);			//	구매자 이메일

			submitform3.find("#P_GOODS").val(goodName);
		  	submitform3.find("#P_AMT").val(payAmtInfo.payExpAmt);	//	총결제금액
		  	submitform3.find("#P_UNAME").val(buyerName);			//	구매자명
		  	submitform3.find("#P_MOBILE").val(buyerTel);			//	구매자 핸드폰번호
		  	submitform3.find("#P_EMAIL").val(buyerEmail);			//	구매자 이메일

		  	$('input[name="paymentMethod"]').val(paymentMethod === 'Etc' ? 'Card' : paymentMethod); // 결제수단 (복합결제일 경우 신용카드 결제로)
			$('input[name="buyeremail"]').val(buyerEmail); // 구매자 이메일
	 	  
			// ### 결제요청 정보 설정 ###
			console.log('paymentMethod', paymentMethod);
		  	console.log('buyerEmail', buyerEmail);
		  	console.log('payExpAmt', payAmtInfo.payExpAmt);
		  	console.log('buyerTel', buyerTel);
	/*	  
			goodsPrice		=	splitParam[0]; 		//	상품가격
			startDay		=	splitParam[1];		//	여행시작일자	 
			cardNo			=	splitParam[2]; 		//	LPoint카드번호
			wpw				=	splitParam[3]; 		//	LPoint패스워드
			lottePoint		=	splitParam[4]; 		//	사용포인트
			cashPayAmt		=	splitParam[5];		//	현금결제금액	(복합결제의경우)
			cashType		=	splitParam[6];		//	현금영수증타입(0:소득공제(소비자용), 1:지출증빙(사업자용))
			cashReceipts	=	splitParam[7];		//	현금영수증인증번호(핸드폰번호, 사업자등록번호)
			giftCard		=	splitParam[8]; 		//	상품권번호	 
			giftCardAmt		=	splitParam[9]; 		//	상품권금액	 
			buyerTel		=	splitParam[10]; 	//	구매자 전화번호
			buyerEmail		=	splitParam[11]; 	//	구매자 이메일
			goodName		=	splitParam[12]; 	//	상품명
			vcdbank			=	splitParam[13]; 	//	입금은행코드
			rescd			=	splitParam[14];		//	예약번호
			mid				=	splitParam[15];		//	결제구분
	*/
			var merchantDataVal	=	"";
			merchantDataVal	=	$('input[name="price"]').val();									//	상품가격(복합결제금액 제외 카드결제금액 또는 가상계좌금액)
		  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="startDay"]').val();		//	여행시작일자
		  	merchantDataVal	=	merchantDataVal + "	" + $('input[name="cardNo"]').val();		//	LPOINT 카드번호
		  	merchantDataVal	=	merchantDataVal + "	" + $('input[name="wpw"]').val();			//	LPOINT 패스워드
		  	merchantDataVal	=	merchantDataVal + "	" +	$('input[name="lottePoint"]').val();	//	사용포인트
		  	merchantDataVal	=	merchantDataVal + "	" + $('input[name="payAmt"]').val();		//	현금결제금액	(복합결제의경우)
		  	if(nullToBlank(proofCheck) != ""){
			  	if( "busi" == proofCheck){
				  	merchantDataVal	=	merchantDataVal + "	" +  "1";								//	현금영수증타입(1:지출증빙(사업자용) 0:소득공제(소비자용))
			  	}else{																				//	 
				  	merchantDataVal	=	merchantDataVal + "	" +  "0";								//	현금영수증타입(1:지출증빙(사업자용) 0:소득공제(소비자용))
			  	}
		  	}else{
		  		merchantDataVal	=	merchantDataVal + "	" +  "0";								//	현금영수증타입(1:지출증빙(사업자용) 0:소득공제(소비자용))
		  	}
		  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="vbankRegNo"]').val();	//	현금영수증인증번호(핸드폰번호, 사업자등록번호)
		  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="giftNo"]').val();		//	상품권번호
		  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="giftNoAmt"]').val();	//	상품권금액
		  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="phoneNumber"]').val();	//	구매자 전화번호
		  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="userEmail"]').val();	//	구매자 이메일
		  	merchantDataVal	=	merchantDataVal + "	" +  encodeURIComponent(goodName);			//	상품명
		  	merchantDataVal	=	merchantDataVal + "	" +  $("select[name=bankforvbank]").val();	//	입금은행코드
		  	merchantDataVal	=	merchantDataVal + "	" + $('input[name="resCd"]').val();			//	예약번호
		  	if($('input[name="paymentMethod"]').val() == "Card"){
		  		merchantDataVal	=	merchantDataVal + "	" + "Card";		//	결제구분
		  	}else{
		  		merchantDataVal	=	merchantDataVal + "	" + "VBank";	//	결제구분
		  	}
		  	submitform1.find("#P_NOTI").val(encodeURIComponent(merchantDataVal));			
		  	submitform3.find("#P_NOTI").val(encodeURIComponent(merchantDataVal));			
	   		
		  	console.log(submitform1.find("#P_MID").val());
		  	console.log(submitform1.find("#P_OID").val());
		  	console.log(submitform1.find("#P_AMT").val());
		  	console.log(submitform1.find("#P_UNAME").val());
		  	console.log(submitform1.find("#P_GOODS").val());
		  	console.log(submitform1.find("#P_NEXT_URL").val());
		  	console.log(submitform1.find("#P_TAX").val());
		  	console.log(submitform1.find("#P_RESERVED").val());
		  	console.log(submitform1.find("#P_NOTI").val());
		  	console.log(submitform1.find("#P_MOBILE").val());
		  	console.log(submitform1.find("#P_EMAIL").val());

		  	console.log(submitform3.find("#P_MID").val());
		  	console.log(submitform3.find("#P_OID").val());
		  	console.log(submitform3.find("#P_AMT").val());
		  	console.log(submitform3.find("#P_UNAME").val());
		  	console.log(submitform3.find("#P_GOODS").val());
		  	console.log(submitform3.find("#P_NEXT_URL").val());
		  	console.log(submitform3.find("#P_NOTI_URL").val());
		  	console.log(submitform3.find("#P_RETURN_URL").val());
		  	console.log(submitform3.find("#P_TAX").val());
		  	console.log(submitform3.find("#P_RESERVED").val());
		  	console.log(submitform3.find("#P_QUOTABASE").val());
		  	console.log(submitform3.find("#P_NOTI").val());
		  	console.log(submitform3.find("#P_MOBILE").val());
		  	console.log(submitform3.find("#P_EMAIL").val());
			
			if($('input[name=paymentMethod]').val() == "Card"){		// 신용카드
				document.getElementById("form3").submit();
//			document.getElementById("form1").submit();
			}else if(	$('input[name=paymentMethod]').val() == "VBank"){	// 무통장입금(가상계좌)
				document.getElementById("form1").submit();
			}
		}
	});
}

function fn_lpointApply(){
	var lpoint			=	$("#lpoint").val();
	var totalAmtText	=	0;
	var totalMinusAmt 	= 	0;
	var toTalPriceText = 0;
	var totalLpoint = $("#hiddenUseLpoint").val().replace('원','').replace(/,/gi, '');

	if(lpoint != "" ){
		var totalAmt	=	$("#pTotalAmt").text().replace('원','').replace(/,/gi, '');
		// var giftAmt		=	$("#giftAmtText").text().replace('원','').replace(/,/gi, '');
		var giftAmt 	= 0;
		var lpointAmt	=	$("#lpointAmtText").text().replace('원','').replace(/,/gi, '');

		toTalPriceText = $("#toTalPriceText").text().replace('원','').replace(/,/gi, '');

// 		console.log("fn_lpointApply() >> totalAmt : " + totalAmt);
// 		console.log("fn_lpointApply() >> giftAmt : " + giftAmt);
// 		console.log("fn_lpointApply() >> lpointAmt : " + lpoint);
		
		lpoint = parseInt(lpoint);
		totalLpoint = parseInt(totalLpoint);
		
// 		console.log("fn_lpointApply() >> lpoint : " + lpoint);
// 		console.log("fn_lpointApply() >> totalLpoint : " + totalLpoint);
		
		if(lpoint > totalLpoint){
			alert("사용가능하신 L.POINT는 " + comma(totalLpoint) + "P 입니다.");
			$("#lpoint").val('0');
		}else if(lpoint > parseInt(totalAmt * 0.1)){			//[JEH] L.POINT 사용액 제한 - 20191121
			alert("L.POINT는 상품금액의 10%까지 사용가능합니다.(최대 " + comma(parseInt(totalAmt * 0.1)) + "P 사용가능)");
			$("#lpoint").val('0');
		}else{
			totalMinusAmt	=	parseInt(giftAmt) + parseInt(lpoint);
			totalAmtText	=	parseInt(totalAmt) - parseInt(giftAmt) - parseInt(lpoint) - parseInt(toTalPriceText);
				
			
			$("#totalMinusAmtText").text(comma(totalMinusAmt) + "원");
			$("#totalAmt").text(comma(totalAmtText) + "원");
			// $("#lpointAmtText").text(comma(lpoint) + "원");
			$("#lpointAmt").show();
		}
	}else{
		$("#lpointAmtText").text("0");
		$("#lpointAmt").hide();
	}
}



$(document).ready(function() {
	$("#applyLpoint").click(function(){
 		cfn_ajax({
			type : "POST",
			async : false,
//			url: "/account/giftcardUseAjax.do",
			url: "/account/LPointSrcAjax.do",
//			url: "/account/LPointAccumAjax.do",
//			url: "/account/LPointUseAjax.do",
//			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 5 * 60 * 1000,
			success: function(data) {
//				alert("code:" + data.code);											//리턴코드
//				alert("사용가능포인트" + data.remainPoint);
				$('#lpoint').val(parseInt(data.remainPoint)); // 구매자 전화번호
			},
			error : function(err) {
				setAlert("결제 도중 오류가 발생하였습니다.");
				console.log(err);
			},
			complete : function(e) {
				console.log(e);
			}
		}); 
 		
	});
	
	
});
</script>
<!-- ----------------------- L.Pay용 Script start ---------------------------- -->
<script type="text/javascript">
var jobj;
function returnlpayMemCertIf( data ){
  jobj =  eval("("+data+")");
  
  if(jobj["RESULT_VAL"] == 'S'){
	$("#paymentInfo option").remove();
	var paymentList = jobj["MEMBER_CARD_LIST"];
	
	for(var i =0;i <jobj["dbio_total_count_"]; i++){
		var cardLastNum = paymentList[i]["P_M_NUM"].substring(paymentList[i]["P_M_NUM"].length - 4, paymentList[i]["P_M_NUM"].length);
	  	$("#paymentInfo").append("<option value='"+i+"'>"+ paymentList[i]["F_C_NM"] + "("+ cardLastNum +")"+"</option>");
	}
		
	if(jobj["MEMBER_CARD_LIST"] != 0){
		$("#lPayCardInfo").html("L.pay에 등록된 카드/계좌 ("+ jobj["MEMBER_CARD_LIST"].length +"개)를 조회하였습니다.");
	}else{
		$("#lPayCardInfo").html("L.pay에 등록된 카드/계좌가 없습니다.");
	}
  }else{
	setAlert('사용자 인증에 실패했습니다.');
	$("#paymentInfo option").remove();
	$("#paymentInfo").append("<option value=''>결제수단이 없습니다</option>");
  }
  
}

function lpayMemCertIf(){
	//	MEM_M_NUM		맴버스 고객번호 
	//	P_REQ_NM		결제요청자명 
	//	P_REQ_HP_NUM	결제요청자 휴대폰번호 
	document.lpayMemCertIf.P_REQ_NM.value = encodeURI(document.lpayMemCertIf.P_REQ_NM_org.value); 
	
	//document.lpayMemCertIf.returnURL.value ="http://mdev.lottejtb.com/returnlpayMemCertIf.jsp"
	document.lpayMemCertIf.returnURL.value ="https://m.lottejtb.com/returnlpayMemCertIf.jsp"
	document.lpayMemCertIf.action="http://www.lottejtb.com/jsp/lpay/lpayMemCertIf.faces";
	document.lpayMemCertIf.submit();
}

function returnlpayTranCertIf(data){
	showLoading();
	var dlp =  eval("("+data+")");
	
	if(dlp["RESULT_VAL"] == 'S'){
	//alert('?');
	document.dlp.a.value = dlp['a'];
	document.dlp.b.value = dlp['b'];
	document.dlp.c.value = dlp['c'];
	document.dlp.d.value = dlp['d'];
	document.dlp.e.value = dlp['e'];
	document.dlp.f.value = dlp['f'];
	document.dlp.g.value = dlp['g'];
	document.dlp.setKey.value = dlp['setKey'];
	document.dlp.INST_CHO_CD.value = dlp['INST_CHO_CD'];
	document.dlp.SUM_GD_NM_org.value = dlp['SUM_GD_NM'];
	document.dlp.P_REQ_HP_NUM.value = dlp['P_REQ_HP_NUM'];
	document.dlp.P_REQ_NM_org.value = dlp['P_REQ_NM'];
	
	document.dlp.P_REQ_NM.value = encodeURI(document.dlp.P_REQ_NM_org.value); 
    document.dlp.SUM_GD_NM.value = encodeURI(document.dlp.SUM_GD_NM_org.value); 
    
	//document.dlp.returnURL.value ="http://mdev.lottejtb.com/returnDLP.jsp"
	document.dlp.returnURL.value ="https://m.lottejtb.com/returnDLP.jsp"
//	document.dlp.action="http://10.141.1.40/jsp/lpay/lpay_json.jsp";
	document.dlp.action="http://www.lottejtb.com/jsp/lpay/lpay_json.jsp";
	document.dlp.submit();
	}else{
		hideLoading();
		setAlert('인증에 실패했습니다.');
	}
	
}

function lpayTranCertIf(){
	var payment =  jobj["MEMBER_CARD_LIST"][$("#paymentInfo").val()];
    
	//	멤버스 고객번호		MEM_M_NUM
	//	가맹점 거래번호		M_TX_NUM   ?
	//	요약 상품명			SUM_GD_NM
	//	상품금액(총거래금액)	GDS_TOT_AMT
	//	공급금액			GDS_SUP_AMT
	//	부가세				GDS_VAT
	//	봉사료				PSC_AMT
	//	결제요청자명			P_REQ_NM
	//	결제요청자 휴대폰번호	P_REQ_HP_NUM
		
    document.lpayTranCertIf.P_REQ_NM.value = encodeURI(document.lpayTranCertIf.P_REQ_NM_org.value); 	//	결제요청자명
    document.lpayTranCertIf.SUM_GD_NM.value = encodeURI(document.lpayTranCertIf.SUM_GD_NM_org.value); 	//	상품명
    document.lpayTranCertIf.IMONTH_NUM.value = "00"; 	//	할부개월수
    
    document.lpayTranCertIf.IMONTH_NUM.value = $("#lPayMonth option:selected").val();

    document.lpayTranCertIf.GDS_TOT_AMT.value = $("#totalAmt").text().replace('원','').replace(/,/gi, '');
    //document.lpayTranCertIf.GDS_TOT_AMT.value = 1004; 	//	상품금액
    document.lpayTranCertIf.GDS_SUP_AMT.value = $("#totalAmt").text().replace('원','').replace(/,/gi, '');
    //document.lpayTranCertIf.GDS_SUP_AMT.value = 1004; 	//	공급가액
    
    var F_CO_CD =  (payment['F_CO_CD'] += "");
	if(F_CO_CD.length ==1){
		F_CO_CD ='0'+F_CO_CD;
	}
	
    document.lpayTranCertIf.P_M_DIV_CD.value = payment['P_M_DIV_CD'];
    document.lpayTranCertIf.F_CO_CD.value =F_CO_CD;
    document.lpayTranCertIf.F_C_NM_org.value = payment['F_C_NM'];
    document.lpayTranCertIf.P_M_ID.value = payment['P_M_ID'];
    document.lpayTranCertIf.P_M_ANM_org.value = payment['P_M_ANM'];
    document.lpayTranCertIf.P_M_ANM.value = encodeURI(document.lpayTranCertIf.P_M_ANM_org.value);
    document.lpayTranCertIf.F_C_NM.value = encodeURI(document.lpayTranCertIf.F_C_NM_org.value);  
    
    document.lpayTranCertIf.REQ_AMT.value =document.lpayTranCertIf.GDS_TOT_AMT.value;
    if(nullToBlank($("#userUseLpoint").text()) != "" && $("#userUseLpoint").text() != "0"){
    	document.lpayTranCertIf.LPOINT_USE_AMT.value = parseInt($("#userUseLpoint").text());
    }
 
    document.lpayTranCertIf.returnURL.value ="https://m.lottejtb.com/returnlpayTranCertIf.jsp"
//    document.lpayTranCertIf.returnURL.value ="http://m.lottejtb.com/returnlpayTranCertIf.jsp"
//    document.lpayTranCertIf.action="http://10.141.1.40/jsp/lpay/lpayTranCertIf.faces";
    document.lpayTranCertIf.action="http://www.lottejtb.com/jsp/lpay/lpayTranCertIf.faces";
	document.lpayTranCertIf.submit();
}

function returdlp(data){
	var resdlp =  eval("("+data+")");
	document.lpayAprvIf.PR_TYPE_CD.value = resdlp['PR_TYPE_CD'];
	document.lpayAprvIf.MEM_M_NUM.value = resdlp['MEM_M_NUM'];
	
	document.lpayAprvIf.P_REQ_ID.value = resdlp['P_REQ_ID'];
	document.lpayAprvIf.M_TX_NUM.value = resdlp['M_TX_NUM'];
	
	document.lpayAprvIf.P_REQ_HP_NUM.value = resdlp['P_REQ_HP_NUM'];
	document.lpayAprvIf.P_M_DIV_CD.value = resdlp['P_M_DIV_CD'];
 
	var F_CO_CD =  (resdlp['F_CO_CD'] += "");
	if(F_CO_CD.length ==1){
		F_CO_CD ='0'+F_CO_CD;
	}
	
	document.lpayAprvIf.F_CO_CD.value = F_CO_CD;
	
	document.lpayAprvIf.P_M_ID.value = resdlp['P_M_ID'];
	document.lpayAprvIf.P_M_NUM.value = resdlp['P_M_NUM'];
	document.lpayAprvIf.P_C_MID.value = resdlp['P_C_MID'];
	document.lpayAprvIf.INST_CHO_CD.value = resdlp['INST_CHO_CD'];
	document.lpayAprvIf.IMONTH_NUM.value = resdlp['IMONTH_NUM'];
	document.lpayAprvIf.REQ_AMT.value = resdlp['REQ_AMT'];
	document.lpayAprvIf.OTC_NUM.value = resdlp['OTC_NUM'];
	document.lpayAprvIf.CAVV.value = resdlp['CAVV'];
	document.lpayAprvIf.ECI.value = resdlp['ECI'];
	document.lpayAprvIf.P_M_DIV_CD.value = resdlp['P_M_DIV_CD'];
	document.lpayAprvIf.XID.value = resdlp['XID'];
	document.lpayAprvIf.TR_ID.value = resdlp['TR_ID'];
	document.lpayAprvIf.CARD_YYMM.value = resdlp['CARD_YYMM'];
	 
	document.lpayAprvIf.P_REQ_NM_org.value = resdlp['P_REQ_NM'];
	document.lpayAprvIf.SUM_GD_NM_org.value = resdlp['SUM_GD_NM'];
	document.lpayAprvIf.P_M_ANM_org.value = resdlp['P_M_ANM'];
	document.lpayAprvIf.F_C_NM_org.value = resdlp['F_C_NM'];
	  
	  
	document.lpayAprvIf.P_REQ_NM.value = encodeURI(document.lpayAprvIf.P_REQ_NM_org.value); 
	document.lpayAprvIf.SUM_GD_NM.value = encodeURI(document.lpayAprvIf.SUM_GD_NM_org.value);
	document.lpayAprvIf.P_M_ANM.value = encodeURI(document.lpayAprvIf.P_M_ANM_org.value);
	document.lpayAprvIf.F_C_NM.value = encodeURI(document.lpayAprvIf.F_C_NM_org.value);
	
	if(nullToBlank($("#userUseLpoint").text()) != "" && $("#userUseLpoint").text() != "0"){
    	document.lpayAprvIf.LPOINT_USE_AMT.value = parseInt($("#userUseLpoint").text());
    }

//	document.lpayAprvIf.returnURL.value ="http://mdev.lottejtb.com/returnlpayAprvIf.jsp"
	document.lpayAprvIf.returnURL.value ="https://m.lottejtb.com/returnlpayAprvIf.jsp"
//	document.lpayAprvIf.action="http://10.141.1.40/jsp/lpay/lpayAprvIf.faces";
	document.lpayAprvIf.action="http://www.lottejtb.com/jsp/lpay/lpayAprvIf.faces";
	document.lpayAprvIf.submit();
}

function returnlpayAprvIf(data){
	var res =  eval("("+data+")");
	
	if(res["RESULT_VAL"] == 'S'){
		// 성공 DB 저장 시작해야 함
//		alert("성공");
		saveLpayDB();
	}else{
		hideLoading();
		setAlert('L.Pay 결제에 실패하였습니다.');
	}
}

function saveLpayDB(){
		var goodName = '<%=rnEtMst.getDisp_nm()%>';
		var submitform1 = $("#submitLpayValue");
		//가상계좌T
		// FIT_RSV_NO  로딩시 setting
		document.submitLpayValue.P_M_DIV_CD.value			=	document.lpayTranCertIf.P_M_DIV_CD.value;	//	현금/카드구분
		document.submitLpayValue.BANK_CD_GB.value			=	document.lpayTranCertIf.F_CO_CD.value;		//	은행/카드사코드
		document.submitLpayValue.ACT_PAYMTOR_NM.value		=	document.lpayTranCertIf.P_REQ_NM.value;		//	입금자명

	  	if( "busi" == $(':radio[name="proof"]:checked').val()){
		  	document.submitLpayValue.CASH_RECEIPT_DIVI_GB.value	=	"002";		//	현금영수증구분
			document.submitLpayValue.CORP_NO.value			=	$('input[name="vbankRegNo"]').val();		//	현금영수증발급번호
	  	}else{
		  	document.submitLpayValue.CASH_RECEIPT_DIVI_GB.value	=	"001";		//	현금영수증구분
			document.submitLpayValue.CORP_NO.value			=	$('input[name="vbankRegNo"]').val();		//	현금영수증발급번호
	  	}
		document.submitLpayValue.TID_NO.value				=	document.lpayAprvIf.P_REQ_ID.value;			//	TID(거래번호)
		
		//	카드T
		document.submitLpayValue.CARD_KI_GB.value			=	document.lpayTranCertIf.F_CO_CD.value;		//	카드용 은행/카드사코드
		document.submitLpayValue.CARD_NO.value				=	document.lpayAprvIf.P_M_NUM.value;			//	카드번호
		document.submitLpayValue.CARD_INSTALLMN_MN.value	=	document.lpayTranCertIf.IMONTH_NUM.value;	//	할부개월수
		document.submitLpayValue.CARD_APPROVE_NO.value		=	document.lpayAprvIf.P_REQ_ID.value;			//	TID(거래번호)
		
		document.submitLpayValue.TOTALAMT.value				=	document.lpayTranCertIf.REQ_AMT.value;		//	결제금액
		
		var merchantDataVal	=	"";
		merchantDataVal	=	$('input[name="price"]').val();									//	상품가격(복합결제금액 제외 카드결제금액 또는 가상계좌금액)
	  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="startDay"]').val();		//	여행시작일자
	  	merchantDataVal	=	merchantDataVal + "	" + $('input[name="cardNo"]').val();		//	LPOINT 카드번호
	  	merchantDataVal	=	merchantDataVal + "	" + $('input[name="wpw"]').val();			//	LPOINT 패스워드
	  	merchantDataVal	=	merchantDataVal + "	" +	$('input[name="lottePoint"]').val();	//	사용포인트
	  	merchantDataVal	=	merchantDataVal + "	" + $('input[name="payAmt"]').val();		//	현금결제금액	(복합결제의경우)
	  	if(nullToBlank(proofCheck) != ""){
		  	if( "busi" == proofCheck){
			  	merchantDataVal	=	merchantDataVal + "	" +  "1";								//	현금영수증타입(1:지출증빙(사업자용) 0:소득공제(소비자용))
		  	}else{																				//	 
			  	merchantDataVal	=	merchantDataVal + "	" +  "0";								//	현금영수증타입(1:지출증빙(사업자용) 0:소득공제(소비자용))
		  	}
	  	}else{
	  		merchantDataVal	=	merchantDataVal + "	" +  "0";								//	현금영수증타입(1:지출증빙(사업자용) 0:소득공제(소비자용))
	  	}
	  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="vbankRegNo"]').val();	//	현금영수증인증번호(핸드폰번호, 사업자등록번호)
	  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="giftNo"]').val();		//	상품권번호
	  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="giftNoAmt"]').val();	//	상품권금액
	  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="phoneNumber"]').val();	//	구매자 전화번호
	  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="userEmail"]').val();	//	구매자 이메일
	  	merchantDataVal	=	merchantDataVal + "	" +  encodeURIComponent(goodName);			//	상품명
	  	merchantDataVal	=	merchantDataVal + "	" +  $("select[name=bankforvbank]").val();	//	입금은행코드
	  	merchantDataVal	=	merchantDataVal + "	" + $('input[name="resCd"]').val();			//	예약번호
	  	if($('input[name="paymentMethod"]').val() == "Card"){
	  		merchantDataVal	=	merchantDataVal + "	" + "Card";		//	결제구분
	  	}else{
	  		merchantDataVal	=	merchantDataVal + "	" + "VBank";	//	결제구분
	  	}
	  	submitform1.find("#P_NOTI2").val(encodeURIComponent(merchantDataVal));
	  	hideLoading();
		//document.submitLpayValue.action = "http://mdev.lottejtb.com/account/paymentLpayReturn.do";
		document.submitLpayValue.action = "https://m.lottejtb.com/account/paymentLpayReturn.do";
		document.submitLpayValue.submit();
}

function regDlp(){
	var check_form = $('form[ft-att="check"]');
	
	if( check_form.find("#MEM_M_NUM").val() == ""	){
		setAlert("로그인을 하여 주십시요.");
		hideLoading();
		return;
	}
	
	//$('.paylist_chkbox2 #card').click();
	
//	document.dlpcard.returnURL.value = "http://mdev.lottejtb.com/returnRegDlp.jsp";
	document.dlpcard.returnURL.value = "https://m.lottejtb.com/account/returnRegDlp.do";
//	document.dlpcard.action="http://10.141.1.40/jsp/lpay/lpayRegPayment.faces";
	document.dlpcard.action="http://www.lottejtb.com/jsp/lpay/lpayRegPayment.faces";
	document.dlpcard.submit();
	
}

function returnRegDlp(data){

	if(data == 'S'){
//	     alert('성공했습니다.');
	}else{
		hideLoading();
		setAlert('L.pay연동에 실패하였습니다.');
	} 
	
}
</script>
<!-- ----------------------- 상품권을 위한 Script ---------------------------- -->
<script>
function schGift(id){
	if(document.getElementById(id).value == "상품권번호입력" || document.getElementById(id).value == ""){
		setAlert("상품권번호를 입력해주세요.");
		return false;
	}else{
		chkGiftNumberCertIf(id, '1');
		document.getElementById('giftNoAmt').value = 0;
	}
}

// 상품권 사용 
function fn_giftApply(){
	
	var totalAmtText  =	0;
	var totalMinusAmt = 0;
	var lpoint			=	$("#lpoint").val();
	var toTalPriceText = 0;

	var totalAmt	=	$("#pTotalAmt").text().replace('원','').replace(/,/gi, '');
	var giftAmt		=	$("#giftAmtText").text().replace('원','').replace(/,/gi, '');
	var lpointAmt	=	$("#lpointAmtText").text().replace('원','').replace(/,/gi, '');

	toTalPriceText = $("#toTalPriceText").text().replace('원','').replace(/,/gi, '');

	console.log("fn_giftApply() >> totalAmt : " + totalAmt);
	console.log("fn_giftApply() >> giftAmt : " + giftAmt);
	console.log("fn_giftApply() >> lpointAmt : " + lpoint);
	
	totalMinusAmt	=	parseInt(giftAmt) + parseInt(lpoint);
	totalAmtText	=	parseInt(totalAmt) - parseInt(giftAmt) - parseInt(lpoint) - parseInt(toTalPriceText);
	
	// totalAmtText	=	parseInt(totalAmt) + parseInt(giftAmt) + parseInt(lpointAmt);
	$("#totalMinusAmtText").text(comma(totalMinusAmt) + "원");
	$("#totalAmt").text(comma(totalAmtText) + "원");
	// $("#lpointAmtText").text(comma(lpoint) + "원");
	// $("#lpointAmt").show();
}


function returnGiftNumberCertIf(data){
   var gift =  eval("("+data+")");

   if(gift.COUPON["RETCODE"] == 'S'){
	   if(gift.COUPON["REALAMT"] < 0){
	       setAlert('쿠폰번호를 확인해주세요.');
		   return;
	   }
	   document.getElementById('giftNoAmt').value = gift.COUPON["REALAMT"];
	   $("#giftAmtText").text(comma(gift.COUPON["REALAMT"])+ "원");
	   fn_giftApply();
   }else{
       setAlert('쿠폰번호를 확인해주세요.');
   }
}

function chkGiftNumberCertIf(id, type){
	document.giftNumberCertIf.GIFTNO.value = document.getElementById(id).value;
	document.giftNumberCertIf.RETURNDATA.value = type;
	document.giftNumberCertIf.returnURL.value ="https://m.lottejtb.com/returnGiftNumberCertIf.jsp"
	//document.giftNumberCertIf.returnURL.value ="http://mdev.lottejtb.com/returnGiftNumberCertIf.jsp"
	document.giftNumberCertIf.action="http://www.lottejtb.com/jsp/gift/giftNumberCertIf.faces";
	document.giftNumberCertIf.submit();
}
</script>
<!-- ----------------------- L.Pay용 Script End ---------------------------- -->

</head>
<body>

	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="navstitle freeback">
			예약/결제<a href="javascript:history.back(-1);">뒤로</a>
		</div>
		<div class="free_reserve collapse fr_paybox">
			<!-- 예약상품정보 -->
			<p class="obj_title2 obj_bg_wht mt7">
				<span class="ico_info">예약상품정보</span>
			</p>
			<table class="ft_table2 ft_th_tl">
				<colgroup>
					<col style="width: 30%" />
					<col style="width: 70%" />
				</colgroup>
				<tr>
					<th>예약번호</th>
					<td><%=reservMst.getRes_cd()%></td>
				</tr>
				<tr>
					<th>상품명</th>
					<td class="f_purple"><%=rnEtMst.getDisp_nm()%></td>
				</tr>
				<tr>
					<th>예약상태</th>
					<td>
						<p>[<%=rnEtMst.getEv_night_cnt()%>박 <%=rnEtMst.getEv_day_cnt()%>일]</p>
						<dl>
							<%
								if (rnEtMst.getStart_pyun() != null && !rnEtMst.getStart_pyun().equals("")) {
							%>
							<dt class="mt5">출발일</dt>
							<dd><%=rnEtMst.getStart_day().substring(0, 4)%>년 <%=rnEtMst.getStart_day().substring(4, 6)%>월 <%=rnEtMst.getStart_day().substring(6, 8)%>일 (<%=rnEtMst.getStart_wday()%>)
								<%
									if (rnEtMst.getStart_time() != null) {
								%>
								<%=rnEtMst.getStart_time().substring(0, 2)%>:<%=rnEtMst.getStart_time().substring(2, 4)%>
								<%
									}
								%>
								- <%=rnEtMst.getStart_pyun()%>
							</dd>
							<%
								} else {
							%>
							<dt class="mt5">출발일</dt>
							<dd>
								<%=rnEtMst.getStart_day().substring(0, 4)%>년 <%=rnEtMst.getStart_day().substring(4, 6)%>월 <%=rnEtMst.getStart_day().substring(6, 8)%>일 (<%=rnEtMst.getStart_wday()%>)
								<%
									if (rnEtMst.getStart_time() != null) {
								%>
								<%=rnEtMst.getStart_time().substring(0, 2)%>:<%=rnEtMst.getStart_time().substring(2, 4)%>
								<%
									}
								%>
							</dd>
							<%
								}
							%>
							<%
								if (rnEtMst.getEnd_pyun() != null && !rnEtMst.getEnd_pyun().equals("")) {
							%>
							<dt class="mt5">도착일</dt>
							<dd>
								<%=rnEtMst.getEnd_day().substring(0, 4)%>년 <%=rnEtMst.getEnd_day().substring(4, 6)%>월 <%=rnEtMst.getEnd_day().substring(6, 8)%>일 (<%=rnEtMst.getEnd_wday()%>)
								<%
									if (rnEtMst.getEnd_time() != null) {
								%>
								<%=rnEtMst.getEnd_time().substring(0, 2)%>:<%=rnEtMst.getEnd_time().substring(2, 4)%>
								<%
									}
								%>
								- <%=rnEtMst.getEnd_pyun()%>
							</dd>
							<%
								} else {
							%>
							<dt class="mt5">도착일</dt>
							<dd>
								<%=rnEtMst.getEnd_day().substring(0, 4)%>년 <%=rnEtMst.getEnd_day().substring(4, 6)%>월 <%=rnEtMst.getEnd_day().substring(6, 8)%>일 (<%=rnEtMst.getEnd_wday()%>)
								<%
									if (rnEtMst.getEnd_time() != null) {
								%>
								<%=rnEtMst.getEnd_time().substring(0, 2)%>:<%=rnEtMst.getEnd_time().substring(2, 4)%>
								<%
									}
								%>
							</dd>
							<%
								}
							%>
						</dl>
					</td>
				</tr>
				<!-- tr>
					<th>예약지점</th>
					<td>동남아팀</td>
				</tr>
				<tr>
					<th>예약담당자</th>
					<td>심춘향(02-1234-5678)</td>
				</tr -->
				
				<!-- [JEH] 롯데면세점 프로모션일경우에만 노출 - 20190510 -->
				<c:if test="${rnEtMst.goods_cd == 'PGI1011'  }">
					
					<tr>
						<th>유의사항</th>
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
				</c:if>
				
				
				
				
				
				
			</table>
			<!-- 여행자 결제정보 -->
			<p class="obj_title2 obj_bg_wht mt7">
				<span class="ico_exclamat">여행자 결제정보</span>
			</p>
			<table class="ft_table2 ft_th_tl ft_tb_tl">
				<colgroup>
					<col style="width: 20%" />
					<col style="width: 30%" />
					<col style="width: 20%" />
					<col style="width: 30%" />
				</colgroup>
				<tbody>
<%
	if(reservRosterList != null) {
		for (int idx = 0; idx < reservRosterList.size(); idx++) {
			ReserveRosterVO reservRosterVO = (ReserveRosterVO) reservRosterList.get(idx);

			if(reservMst.getRes_nm().equals(reservRosterVO.getNm_kor())) {

%>
					<tr>
						<th>번호</th>
						<td>1</td>
						<th>구분</th>
						<td>
						<%
							if(reservRosterVO.getAge_cd().equals("A")) {
								out.print("성인");
							} else if(reservRosterVO.getAge_cd().equals("C")) {
								out.print("아동");
							} else if(reservRosterVO.getAge_cd().equals("B")) {
								out.print("유아");
							}
						%>							
						</td>
					</tr>
					<tr>
						<th>여행자명</th>
						<td><%=reservRosterVO.getNm_kor()%></td>
						<td colspan="2"><%=reservRosterVO.getEnm_last()%>/<%=reservRosterVO.getEnm_first()%></td>
					</tr>
					<tr class="tb_purple">
						<th>상품금액</th>
						<td colspan="3" class="tr"><%=CommUtil.decimalFormat(reservRosterVO.getSale_amt())%>원</td>
					</tr>
<%
			}
		}
	}
%>
				</tbody>
			</table>
			<!-- 입금내역 -->
			<p class="obj_title2 obj_bg_wht mt7">
				<span class="ico_paym">입금내역</span>
			</p>
			<table class="ft_table2 ft_th_tl ft_tb_tr">
				<colgroup>
					<col style="width: 30%" />
					<col style="width: 70%" />
				</colgroup>
				<tbody id="dopositID">
					<!-- <tr>
						<th>입금날짜</th>
						<td>-</td>
					</tr>
					<tr>
						<th>결제수단</th>
						<td>-</td>
					</tr>
					<tr>
						<th>입금상태</th>
						<td>-</td>
					</tr>
					<tr>
						<th>금액</th>
						<td>-</td>
					</tr>
					<tr>
						<th>영수증</th>
						<td>-</td>
					</tr>
					<tr>
						<th>현금영수증</th>
						<td>-</td>
					</tr>
					<tr class="tb_purple">
						<th class="white2">입금총액</th>
						<td>원</td>
					</tr>  -->
				</tbody>
			</table>

			<!-- 결제하기 -->
			<p class="obj_title2 obj_bg_wht mt7">
				<span class="ico_paym">결제하기</span>
			</p>
			<ul class="payinfo_ctnbox payinfo_ctnbox2">
				<li style="padding:0px;"><p><span></span></p></li>
				<!-- [JEH]롯데면세점 프로모션일경우 숨김 - 20190510 -->
				<c:if test="${rnEtMst.goods_cd != 'PGI1011'}">
					<li>
							<div>
								<input type="hidden" id="hiddenUseLpoint" name="hiddenUseLpoint" value="0" />
								<em id="useablepoint">LPOINT (0점)</em> <em class="f_red" id="userUseLpoint">0</em>
		 						<button class="payc_btn payc_view" type="button" data-role="none">본인확인</button>  
								<button class="payc_btn payc_use" type="button" data-role="none" onClick="javascript:fn_lpointApply();">적용</button>
							</div>
						<div class="pc_lpoint_div1">
							<button class="layerOpener" data-role="none" data-url="/pop/lpointPop.do" data-ctn="full" data-ok="yes" id="userConfirm">본인확인</button>
	<!--						<button type="button" data-role="none" id="applyLpoint">본인확인</button> -->
							<input type="text" data-role="none" class="lpoint_text in-num" id="lpoint"	name="lottePoint"value="0"/>P
							<p class="chkbox">
								<span><input id="chk_ck30" type="checkbox" data-role="none"></span> <label for="chk_ck30">전체사용</label>
							</p>
						</div>
					</li>
				</c:if>
				
				<c:if test="${rnEtMst.goods_cd == 'PGI1011'}">
								<input type="hidden" id="hiddenUseLpoint" name="hiddenUseLpoint" value="0" />
							<input type="hidden" data-role="none" class="lpoint_text" id="lpoint"	name="lottePoint"value="0"/>
				</c:if>
				<!-- li>
					<div>
						<em>상품권</em> <em class="f_red">0원</em>
						<button class="payc_btn payc_view" type="button" data-role="none">조회</button>
						<button class="payc_btn payc_use" type="button" data-role="none">적용</button>
					</div>
					<div class="pc_lpoint_div2">
						<input type="hidden" data-role="none" class="pro_price"	id="giftNoAmt" name="giftNoAmt" value="0" /> 
						<input type="text" data-role="none"	placeholder="상품권 번호 입력" id="giftNo" name="giftNo" />
						<button type="button" data-role="none" id="schGift">조회</button>
					</div>
				</li -->
			</ul>
			<!-- 결제 선택 -->
			<ul class="paylist_chkbox2">
				<!-- [JEH]롯데면세점 프로모션일경우 신용카드로 고정 - 20190510 -->
				<c:if test="${rnEtMst.goods_cd == 'PGI1011'}">
				<li><button type="button" data-role="none" id="card" class="active">하나카드<br/>(신용/체크)</button></li>
				</c:if>
				<!-- [JEH]롯데면세점 프로모션일경우 숨김 - 20190510 -->
				<c:if test="${rnEtMst.goods_cd != 'PGI1011'}">
					<li><button type="button" data-role="none" id="card">신용카드</button></li>
					<li><button type="button" data-role="none" id="virtual">가상계좌</button></li>
					<li><button type="button" data-role="none" id="dual">복합결제</button></li>
				</c:if>
				<!-- <li><button type="button" data-role="none" id="lpay">Lpay<br>간편결제</button></li> -->
			</ul>
			<!-- 결제 선택 : 신용카드, 무통장입금 -->
			<dl class="caronline_bankinfo obj_none">
				<dt>신용카드 + 무통장입금</dt>
				<dd>
					<table class="ft_table2 ft_th_tl">
						<colgroup>
							<col style="width: 30%" />
							<col style="width: 70%" />
						</colgroup>
						<tr>
							<th>카드결제금액<em class="f_red">*</em></th>
							<td><input type="text" data-role="none" /> 원
								<p class="ft_text_guide1">(고객님께서 결제하실 금액을 입력해 주세요)</p></td>
						</tr>
						<tr>
							<th>현금결제금액<em class="f_red">*</em></th>
							<td><input type="text" data-role="none" id="payAmt" name="payAmt" value = "0"/> 원</td>
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
					</table>
				</dd>
			</dl>
			<!-- 결제 선택 : 무이자 할부정보 -->
			
			<!-- [JEH]롯데면세점 프로모션일경우 숨김 - 20190510 -->
			<c:if test="${rnEtMst.goods_cd != 'PGI1011'}">
				<dl class="toggle_acdon card_bankinfo obj_none">
					<dt>무이자 할부정보</dt>
					<dd>
						<p>하나카드 (2~8개월)</p>
						<p>비씨카드 (2~6개월)</p>
						<p>씨티카드 (2~6개월)</p>
						<p>삼성카드 (2~6개월)</p>
						<p>현대카드 (2~7개월)</p>
						<p>농협카드 (2~8개월)</p>
						<p>신한카드 (2~7개월)</p>
						<p>국민카드 (2~6개월)</p>
						<p>롯데카드 (2~4개월)</p>
					</dd>
				</dl>
			</c:if>
			<!-- 결제 선택 : 증빙거래 영수증 -->
			<dl class="online_bankinfo obj_none">
				<dt>증빙거래 영수증</dt>
				<dd>
					<p class="chkbox">
						<span><input id="chk_ck20" type="checkbox" data-role="none"></span>
						<label for="chk_ck20">현금영수증 신청 <!-- em>(현금영수증 미 신청 시 자진발급됩니다)</em --><br/>
						<em> * 상품권/무통장입금/실시간 계좌이체로 이용한 금액 만 현금영수증 발행이 가능합니다.</em></label>
					</p>
				</dd>
				<dd class="ob_num_box1">
					<span class="radioboxs"><input type="radio" name="radio" id="proof" data-role="none" value="indi"></span> <label for="radio1">소득공제용(개인용)
						<em>휴대폰 번호 또는 현금영수증 카드번호</em>
					</label>
					<p>
						<input type="text" data-role="none" id="cellCashCardNo1"/>
					</p>
				</dd>
				<dd class="ob_num_box2">
					<span class="radioboxs"><input type="radio" name="radio" id="proof" data-role="none" value="busi"></span> <label for="radio2">지출
						증빙용(사업자용) <em>사업자 등록번호</em>
					</label>
					<p>
						<input type="text" data-role="none" id="bizRegNo1"/> - <input type="text"
							data-role="none" id="bizRegNo2"/> - <input type="text" data-role="none" id="bizRegNo3"/>
					</p>
				</dd>
			</dl>
			<!-- 결제 선택 : L pay -->
			<dl class="toggle_acdon lpay_bankinfo obj_none">
				<dt>
					<p id="lPayCardInfo">L.pay에 등록된 카드/계좌가 없습니다.</p>
					<button type="button" data-role="none" onClick="javascript:regDlp();">카드등록</button>
				</dt>
				<dt>L.pay 간편결제 서비스 이용안내</dt>
				<dd>
					<div class="lpay_text_box">
						<div>
							<p>비밀번호 없이 한 번에 결제 OK!</p>
							최초 1회 결제 후 결제 비밀번호 입력없이 바로 결제 가능한 “<span>빠른결제</span>”서비스 입니다.
						</div>
						<ul class="dotlist1">
							<li>카드사/금융사별 정책에 따라 고액 결제 시 추가 인증이 필요합니다.</li>
							<li>USIM이 없는 휴대폰에서는 사용하실 수 없습니다.</li>
						</ul>
					</div>
				</dd>
			</dl>
			<ul class="lpay_bank_sel obj_none">
				<li>
				<select id="paymentInfo" name="paymentInfo" class="fr_select" data-role="none">
				</select>
<!-- 				<select name="" class="fr_select" data-role="none">
						<option value="">카드선택</option>
						<option value="롯데카드">롯데카드</option>
						<option value="국민카드">국민카드</option>
				</select>	 -->
				</li>
				<li>
					<select id="lPayMonth" name="lPayMonth" class="fr_select" data-role="none">
							<option value="00">일시불</option>
							<option value="02">2개월</option>
							<option value="03">3개월</option>
							<option value="04">4개월</option>
							<option value="05">5개월</option>
							<option value="06">6개월</option>
							<option value="07">7개월</option>
							<option value="08">8개월</option>
							<option value="09">9개월</option>
							<option value="10">10개월</option>
							<option value="11">11개월</option>
							<option value="12">12개월</option>
							<option value="13">13개월</option>
							<option value="14">14개월</option>
							<option value="15">15개월</option>
							<option value="16">16개월</option>
							<option value="17">17개월</option>
							<option value="18">18개월</option>
							<option value="19">19개월</option>
							<option value="20">20개월</option>
							<option value="21">21개월</option>
							<option value="22">22개월</option>
							<option value="23">23개월</option>
							<option value="24">24개월</option>
					</select>	
<!--
				<a href="javascript:lpayTranCertIf();">거래인증</a>
-->
				</li>
			</ul>
			<!-- 최종결제 정보 -->
			<ul class="pop_chk_list payinfolist">
				<li class="pop_paytext1">
					<p>총 상품금액 <span id="pTotalAmt"><%=CommUtil.decimalFormat(reservMst.getSale_amt())%>원</span></p>
					<p class="ppred">- 총 입금액 <span id="toTalPriceText">0원</span></p>
					<p class="ppred" id="totalMinusAmt">- 총 할인금액 <span id="totalMinusAmtText">0원</span></p>
					<p class="ppred" id="lpointAmt">- L.Point<span id="lpointAmtText">0원</span></p>
					<p class="ppred" id="giftAmt">- 상품권<span id="giftAmtText">0원</span></p>
				</li>
			</ul>
			<p class="pop_avtitle3">
				총 결제예정금액 <span id="totalAmt"><%=CommUtil.decimalFormat(reservMst.getSale_amt())%>원</span>
			</p>
			<div class="white2">
				<table class="ft_table2 ft_tb_tl">
					<colgroup>
						<col style="width: 25%">
						<col style="width: 75%">
					</colgroup>
					<tbody>
						<tr>
							<th>이메일<em class="f_red">*</em></th>
							<td><input type="text" data-role="none"	placeholder="test@test.com" id="userEmail" name="userEmail" /></td>
						</tr>
						<tr>
							<th>이동전화<em class="f_red">*</em></th>
							<td><input type="text" data-role="none" placeholder="" id="phoneNumber" name="phoneNumber" /></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="obj_bg_wht payend_sel_box">
				<p class="chkbox">
					<span><input id="chk_ck10" type="checkbox" data-role="none"></span>
					<label for="chk_ck10">상품명, 가격, 유의사항을 확인하였으며, 구매에 동의합니다.</label>
				</p>
			</div>
			<!-- 버튼 -->
			<div class="btn_one air_tbtn addbtn2">
				<button class="purple2" data-role="none" id="btnPayment">결제하기</button>
			</div>
			<div class="btn_one air_tbtn">
				<button class="white2" data-role="none">취소하기</button>
			</div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//content-->
		<input type="hidden" name="paymentMethod" id="paymentMethod" value="" >
	
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
		
		<!-- 상품관련 -->
		<input type="hidden" name="startDay" id = "startDay" value="" > <!-- 출발일자 -->
		<input type="hidden" name="resCd" id = "resCd" value="${reservMst.getRes_cd()}" > <!-- 예약번호 -->

		<!-- ***** 추가옵션 ***** -->
		<!-- 	
				goodsPrice		=	splitParam[0]; 		//	상품가격
				rescd			=	splitParam[1]; 		//	예약번호
				cardNo			=	splitParam[2]; 		//	LPoint카드번호
				wpw				=	splitParam[3]; 		//	LPoint패스워드
				lottePoint		=	splitParam[4]; 		//	사용포인트
				cashPayAmt		=	splitParam[5];		//	현금결제금액	(복합결제의경우)
				cashType		=	splitParam[6];		//	현금영수증타입(0:소득공제(소비자용), 1:지출증빙(사업자용))
				cashReceipts	=	splitParam[7];		//	현금영수증인증번호(핸드폰번호, 사업자등록번호)
				giftCard		=	splitParam[8]; 		//	상품권번호	 
				giftCardAmt		=	splitParam[9]; 		//	상품권금액	 
				buyerTel		=	splitParam[10]; 	//	구매자 전화번호
				buyerEmail		=	splitParam[11]; 	//	구매자 이메일
				goodName		=	splitParam[12]; 	//	상품명
				vcdbank			=	splitParam[13]; 	//	입금은행코드
				startDay		=	splitParam[14];		//	여행시작일자	 
				
		<input type="hidden" name="merchantData" value="1010	P170213-0001	8710400970377574	1q2w3e	10	0					20170607" > 신용카드
		<input type="hidden" name="merchantData" value="1010	P170213-0002	8710400970377574	1q2w3e	10	0	01	01027249613			20170607" > 가상계좌
		<input type="hidden" name="merchantData" value="1010	P170213-0003	8710400970377574	1q2w3e	10	0					20170607" > 실시간계좌이체
		<input type="hidden" name="merchantData" value="1530	P170213-0001	8710400970377574	1q2w3e	10	50001	01027249613	11111	20	20170607" > 복합결제
		-->
		<input type="hidden" name="merchantData" value="" > <!--  가맹점 관리데이터(2000byte) 인증결과 리턴시 함께 전달됨 -->

	</form>
	<!-- //결제 요청 폼  -->
<!-- ----------------------- L.Pay용 iframe & form start ---------------------------- -->
<iframe id="sub" name="sub"  width="1000" height="1000"  >
</iframe>

<form id="lpayMemCertIf" name="lpayMemCertIf"  method="post" target="sub" ft-att="check">
	결제요청타입코드(PR_TYPE_CD) : <input type="text" id="PR_TYPE_CD" name="PR_TYPE_CD" value="6000001"/>
	<br/>
	멤버스 고객번호(MEM_M_NUM):<input type="text" id="MEM_M_NUM" name="MEM_M_NUM" value="${cno}"/>
	<br/>
	결제요청자명(P_REQ_NM) : <input type="text" id="P_REQ_NM_org" name="P_REQ_NM_org" value="${knm}"/>
	<br/>
	결제요청자 휴대폰번호(P_REQ_HP_NUM) : <input type="text" id="P_REQ_HP_NUM" name="P_REQ_HP_NUM" value="${telno}"/>
	<br/>
	P_REQ_NM(PAYOR_HP_NUM) :<input type="text" id="PAYOR_HP_NUM" name="PAYOR_HP_NUM" value=""/>
	returnURL : <input type="text" id="returnURL" name="returnURL" value=""/>
	P_REQ_NM : <input type="text" id="P_REQ_NM" name="P_REQ_NM" value=""/>
	<br/>
</form>

<form id="lpayTranCertIf" name="lpayTranCertIf"  method="post" target="sub">
	결제요청자 휴대폰번호(PR_TYPE_CD) : <input type="text" id="PR_TYPE_CD" name="PR_TYPE_CD" value="6000001"/>
	<br/>
	가맹점 거래번호(M_TX_NUM) : <input type="text" id="M_TX_NUM" name="M_TX_NUM" value="${M_TX_NUM}"/>
	<br/>
	멤버스 고객번호(MEM_M_NUM) : <input type="text" id="MEM_M_NUM" name="MEM_M_NUM" value="${cno}"/>
	<br/>
	요약 상품명(SUM_GD_NM) : <input type="text" id="SUM_GD_NM_org" name="SUM_GD_NM_org" value="test상품"/>
	<input type="hidden" id="SUM_GD_NM" name="SUM_GD_NM" value="test상품"/>
	<br/>
	상품금액(총거래금액)(GDS_TOT_AMT) : <input type="text" id="GDS_TOT_AMT" name="GDS_TOT_AMT" value="0"/>
	<br/>
	공급금액(GDS_SUP_AMT) : <input type="text" id="GDS_SUP_AMT" name="GDS_SUP_AMT" value="0"/>
	<br/>
	부가세(GDS_VAT) : <input type="text" id="GDS_VAT" name="GDS_VAT" value="0"/>
	<br/>
	봉사료(PSC_AMT) : <input type="text" id="PSC_AMT" name="PSC_AMT" value=""/>
	<br/>
	<br/>
	결제요청자명(P_REQ_NM) : <input type="text" id="P_REQ_NM_org" name="P_REQ_NM_org" value="${knm}"/>
	<input type="hidden" id="P_REQ_NM" name="P_REQ_NM" value=""/>
	<br/>
	결제요청자 휴대폰번호(P_REQ_HP_NUM) : <input type="text" id="P_REQ_HP_NUM" name="P_REQ_HP_NUM" value="${telno}"/>
	
	<br/>P_M_DIV_CD:<input type="text" id="P_M_DIV_CD" name="P_M_DIV_CD" value=""/>
	<br/>F_CO_CD:<input type="text" id="F_CO_CD" name="F_CO_CD" value=""/>
	<br/>F_C_NM:<input type="text" id="F_C_NM_org" name="F_C_NM_org" value=""/>
	<input type="hidden" id="F_C_NM" name="F_C_NM" value=""/>
	<br/>P_M_ID:<input type="text" id="P_M_ID" name="P_M_ID" value=""/>
	<br/>P_M_ANM:<input type="text" id="P_M_ANM_org" name="P_M_ANM_org" value=""/>
	<input type="hidden" id="P_M_ANM" name="P_M_ANM" value=""/>
	<br/>INST_CHO_CD:<input type="text" id="INST_CHO_CD" name="INST_CHO_CD" value="6100001"/>
	<br/>IMONTH_NUM:<input type="text" id="IMONTH_NUM" name="IMONTH_NUM" value="00"/>
	<br/>REQ_AMT:<input type="text" id="REQ_AMT" name="REQ_AMT" value=""/>
	<br/>LPOINT_USE_AMT:<input type="text" id="LPOINT_USE_AMT" name="LPOINT_USE_AMT" value="0"/>
	<input type="hidden" id="returnURL" name="returnURL" value=""/>
</form>
	
<form id="dlp" name="dlp"  method="post" target="sub">
	<br/>a:<input type="text" id="a" name="a" value=""/>
	<br/>b:<input type="text" id="b" name="b" value=""/>
	<br/>c:<input type="text" id="c" name="c" value=""/>
	<br/>d:<input type="text" id="d" name="d" value=""/>
	<br/>e:<input type="text" id="e" name="e" value=""/>
	<br/>f:<input type="text" id="f" name="f" value=""/>
	<br/>g:<input type="text" id="g" name="g" value=""/>
	<br/>setKey:<input type="text" id="setKey" name="setKey" value=""/>
	<br/>INST_CHO_CD:<input type="text" id="INST_CHO_CD" name="INST_CHO_CD" value=""/>
	<br/>P_REQ_NM:<input type="text" id="P_REQ_NM_org" name="P_REQ_NM_org" value=""/>
	<input type="hidden" id="P_REQ_NM" name="P_REQ_NM" value=""/>
	<br/>P_REQ_HP_NUM:<input type="text" id="P_REQ_HP_NUM" name="P_REQ_HP_NUM" value=""/>
	<br/>SUM_GD_NM:<input type="text" id="SUM_GD_NM_org" name="SUM_GD_NM_org" value=""/>
	<input type="hidden" id="SUM_GD_NM" name="SUM_GD_NM" value=""/>
	<input type="hidden" id="returnURL" name="returnURL" value=""/>
</form>
	
<form id="lpayAprvIf" name="lpayAprvIf"  method="post" target="sub">
<br/>PR_TYPE_CD:<input type="text" id="PR_TYPE_CD" name="PR_TYPE_CD" value=""/>
<br/>MEM_M_NUM:<input type="text" id="MEM_M_NUM" name="MEM_M_NUM" value=""/>
<br/>SUM_GD_NM:<input type="text" id="SUM_GD_NM_org" name="SUM_GD_NM_org" value=""/>
	<input type="hidden" id="SUM_GD_NM" name="SUM_GD_NM" value=""/>
<br/>P_REQ_ID:<input type="text" id="P_REQ_ID" name="P_REQ_ID" value=""/>
<br/>M_TX_NUM:<input type="text" id="M_TX_NUM" name="M_TX_NUM" value=""/>
<br/>P_REQ_NM: <input type="text" id="P_REQ_NM_org" name="P_REQ_NM_org" value=""/>
	<input type="hidden" id="P_REQ_NM" name="P_REQ_NM" value=""/>
<br/>P_REQ_HP_NUM:<input type="text" id="P_REQ_HP_NUM" name="P_REQ_HP_NUM" value=""/>
<br/>P_C_MID:<input type="text" id="P_C_MID" name="P_C_MID" value=""/>
<br/>P_M_DIV_CD:<input type="text" id="P_M_DIV_CD" name="P_M_DIV_CD" value=""/>
<br/>F_CO_CD:<input type="text" id="F_CO_CD" name="F_CO_CD" value=""/>
<br/>F_C_NM:<input type="text" id="F_C_NM_org" name="F_C_NM_org" value=""/>
<input type="hidden" id="F_C_NM" name="F_C_NM" value=""/>
<br/>P_M_ID:<input type="text" id="P_M_ID" name="P_M_ID" value=""/>
<br/>P_M_NUM:<input type="text" id="P_M_NUM" name="P_M_NUM" value=""/>
<br/>P_M_ANM:<input type="text" id="P_M_ANM_org" name="P_M_ANM_org" value=""/>
<input type="hidden" id="P_M_ANM" name="P_M_ANM" value=""/>
<br/>INST_CHO_CD:<input type="text" id="INST_CHO_CD" name="INST_CHO_CD" value=""/>
<br/>IMONTH_NUM:<input type="text" id="IMONTH_NUM" name="IMONTH_NUM" value=""/>
<br/>REQ_AMT:<input type="text" id="REQ_AMT" name="REQ_AMT" value=""/>
<br/>OTC_NUM:<input type="text" id="OTC_NUM" name="OTC_NUM" value=""/>
<br/>CAVV:<input type="text" id="CAVV" name="CAVV" value=""/>
<br/>ECI:<input type="text" id="ECI" name="ECI" value=""/>
<br/>XID:<input type="text" id="XID" name="XID" value=""/>
<br/>TR_ID:<input type="text" id="TR_ID" name="TR_ID" value=""/>
<br/>CARD_YYMM:<input type="text" id="CARD_YYMM" name="CARD_YYMM" value=""/>
<br/>LPOINT_USE_AMT:<input type="text" id="LPOINT_USE_AMT" name="LPOINT_USE_AMT" value="0"/>
<input type="hidden" id="returnURL" name="returnURL" value=""/>
</form>

<form id="submitLpayValue" name="submitLpayValue"  method="post">
<input type="hidden" id="rescd" name="rescd" value="${reservMst.getRes_cd()}"/>	<!-- 예약번호 -->
<input type="hidden" id="P_M_DIV_CD" name="P_M_DIV_CD" value=""/>	<!-- 현금/카드구분 -->
<input type="hidden" id="BANK_CD_GB" name="BANK_CD_GB" value=""/>	<!-- 은행/카드사코드 -->
<input type="hidden" id="ACT_PAYMTOR_NM" name="ACT_PAYMTOR_NM" value=""/>	<!-- 입금자명 -->
<input type="hidden" id="CASH_RECEIPT_DIVI_GB" name="CASH_RECEIPT_DIVI_GB" value=""/>	<!-- 현금영수증구분 -->
<input type="hidden" id="CORP_NO" name="CORP_NO" value=""/>	<!-- 현금영수증발급번호 -->
<input type="hidden" id="TID_NO" name="TID_NO" value=""/>	<!-- TID(거래번호) -->
<input type="hidden" id="CARD_KI_GB" name="CARD_KI_GB" value=""/>	<!-- 카드용 은행/카드사코드-->
<input type="hidden" id="CARD_NO" name="CARD_NO" value=""/>	<!-- 카드번호 -->
<input type="hidden" id="CARD_INSTALLMN_MN" name="CARD_INSTALLMN_MN" value=""/>	<!--할부개월수 -->
<input type="hidden" id="CARD_APPROVE_NO" name="CARD_APPROVE_NO" value=""/>	<!-- TID(거래번호) -->
<input type="hidden" id="TOTALAMT" name="TOTALAMT" value=""/>	<!-- 결제금액 -->
<input type="hidden" id="P_NOTI2" name="P_NOTI2" value=""/>	<!-- 결제금액 -->
</form>	

<form id="dlpcard" name="dlpcard"  method="post" target="sub">
	<br/>c:<input type="text" id="c" name="c" value="${cno}"/>
	<input type="hidden" id="returnURL" name="returnURL" value=""/>
</form>
<!-- ----------------------- L.Pay용 iframe & form end ---------------------------- -->

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
<!-- <input type="hidden" name="P_NEXT_URL" id="P_NEXT_URL" value="http://mdev.lottejtb.com/account/paymentReturn.do" /> -->
<input type="hidden" name="P_NEXT_URL" id="P_NEXT_URL" value="https://m.lottejtb.com/account/paymentReturn.do" /> 
<input type="hidden" name="P_TAX" id="P_TAX" value="0" />
<input type="hidden" name="P_RESERVED" id="P_RESERVED" value="auth_charset=utf8" />
<input type="hidden" name="P_NOTI_URL" id="P_NOTI_URL" value="http://www.lottejtb.com/jsp/inicis/frontInputVirtualAccount.faces" />

<input type="hidden" name="P_NOTI" id="P_NOTI" value="" />
<input type="hidden" name="P_MOBILE" id="P_MOBILE" value="" />
<input type="hidden" name="P_EMAIL" id="P_EMAIL" value="" />
<input type="button" onclick="formSubmit();" >가상계좌</>
</form>	

<!-- 2트렌 신용카드-->
<form id="form3" name="form3" method="post" accept-charset="euc-kr" action="https://mobile.inicis.com/smart/wcard/" ft-att="form3">
<input type="hidden" name="P_MID" id="P_MID" value="" />
<input type="hidden" name="P_OID" id="P_OID" value="" />
<input type="hidden" name="P_AMT" id="P_AMT" value="" />
<input type="hidden" name="P_UNAME" id="P_UNAME" value="" />
<input type="hidden" name="P_GOODS" id="P_GOODS" value="" />
<input type="hidden" name="P_NEXT_URL" id="P_NEXT_URL" value="https://m.lottejtb.com/account/paymentReturn.do" />
<input type="hidden" name="P_NOTI_URL" id="P_NOTI_URL" value="https://m.lottejtb.com/account/paymentReturn.do" />
<input type="hidden" name="P_RETURN_URL" id="P_RETURN_URL" value="https://m.lottejtb.com/account/paymentReturn.do" />
<input type="hidden" name="P_TAX" id="P_TAX" value="0" />
<input type="hidden" name="P_RESERVED" id="P_RESERVED" value="twotrs_isp=Y&block_isp=Y&twotrs_isp_noti=N&apprun_check=Y&auth_charset=utf8" />
<input type="hidden" name="P_QUOTABASE" id="P_QUOTABASE" value="01:02:03:04:05:06:07:08:09:10:11:12:13:14:15:16:17:18:19:20:21:22:23:24:25:26:27:28:29:30:31:32:33:34:35:36" />

<input type="hidden" name="P_NOTI" id="P_NOTI" value="" />
<input type="hidden" name="P_MOBILE" id="P_MOBILE" value="" />
<input type="hidden" name="P_EMAIL" id="P_EMAIL" value="" />

<!-- [JEH] 롯데면세점 프로모션 진행시 카드 고정을 위해 추가 - 20190513 -->
<input type="hidden" name="P_ONLY_CARDCODE" id="P_ONLY_CARDCODE" value="" />
<input type="button" onclick="formSubmit();" >신용카드T3-4</>
</form>	

<!-- 상품권관련 -->
<form id="giftNumberCertIf " name="giftNumberCertIf"  method="post" target="sub">
    <input type="text" id="GIFTNO" name="GIFTNO" value=""/>
    <input type="text" id="RETURNDATA" name="RETURNDATA" value=""/>
    <input type="hidden" id="returnURL" name="returnURL" value=""/>
</form>
