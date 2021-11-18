<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.lottejtb.front.air.service.*" %>
<%@ page import="com.lottejtb.comm.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<%@ include file="/WEB-INF/common/commTagLib.jsp"%>

<%
	String cust_cd = (String) request.getAttribute("cust_cd");
	pageContext.setAttribute("cust_cd", cust_cd);
	String knm = (String) request.getAttribute("knm");
	String email = (String) request.getAttribute("email");
	String age = (String) request.getAttribute("age");
	String sex = (String) request.getAttribute("sex");
	//RsvAirVO rsvAir = (RsvAirVO) request.getAttribute("rsvAirResult");
	String cno = (String) request.getAttribute("cno");
	String M_TX_NUM = (String) request.getAttribute("M_TX_NUM");
	
	//Date systemDate = new Date();
	Calendar cal = Calendar.getInstance();
	cal.add(Calendar.DATE, 1); //하루 추가
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
	String nowServerDay = sdf.format(cal.getTime());
	
	System.out.println("nowServerDay="  + nowServerDay);
	
	
	long curtime = System.currentTimeMillis();
	SimpleDateFormat sdf1 = new SimpleDateFormat("HH:mm:ss", Locale.KOREA);
	String curTL = sdf1.format(new Date(curtime));
	System.out.println("curTL=" + curTL);
	
%>
<head>
<script src="/resources/common/js/fit/pay.js"></script>
<script src="/resources/common/js/fit/common.js"></script>
<script type="text/javascript" src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
<script type="text/javascript">

	/* *************************************************************************** */
	// [AJAX] 데이타 통신 부분 	
	//var rsvResult = "${rsvResult.getFitRsvNo()}";
	var jSessionID = '<%=request.getSession().getId()%>';
	var nowServerDay = '<%=nowServerDay%>';
	var curDt = '<%=curTL%>';
	var payFitRsvNo = "";
	var proofCheck	=	"";
	
	var paxCnt = 0;
	var rsvAirPaxList = null;
	var totalAmtText	=	0;
	
	if(nullToBlank(sessionStorage.promotionInfo) != '' && sessionStorage.promotionInfo != '[]')
		var promotionInfo = JSON.parse(sessionStorage.promotionInfo);
	if(nullToBlank(sessionStorage.hotelBasketData) != '' && sessionStorage.hotelBasketData != '[]')
		var hotelInfo = JSON.parse(sessionStorage.hotelBasketData);
	var reqReserveInfo;

	function fn_lpointApply(){
		var lpoint				=	$("#lpoint").val();
		var lpointAmtText		= 0;
		var totalAmtText 		= 0;
		if(lpoint != "" ){
			var totalAmt	=	$("#final_hotelAmt").text().replace('원','').replace(/,/gi, '');
			var giftAmt		=	$("#giftAmtText").text().replace('원','').replace(/,/gi, '');
			var lpointAmt	=	$("#lpointAmtText").text().replace('원','').replace(/,/gi, '');
			
			console.log("fn_lpointApply() >> totalAmt : " + totalAmt);
			console.log("fn_lpointApply() >> giftAmt : " + giftAmt);
			console.log("fn_lpointApply() >> lpointAmt : " + lpoint);
			
			totalAmtText	=	parseInt(totalAmt) - parseInt(giftAmt) - parseInt(lpoint);
			
			$("#totalAmt").text(comma(totalAmtText) + "원");
			$("#lpointAmtText").text(comma(lpoint) + "원");
			$("#lpointAmt").show();
		}else{
			$("#lpointAmtText").text("0");
			$("#lpointAmt").hide();
		}
		
	/* 	if($('#selfAuth').css('display') == 'block') {
			$('#selfAuth').hide();	
		} */
	}
	
/* 	function fn_lpointSelf() {
		if($('#selfAuth').css('display') == 'block') {
			$('#selfAuth').hide();	
		}
			
		
	} */

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	var payAmtInfo = {}; // 결제금액 정보
	$(document).ready(function() {
		$("#passport_div").hide();
		$("#arr_info_div").hide();
		$("#contact_info_div").hide();
	 	
	 	$("#cardPayAmt").on("keyup", function(){
	 		var remainAmt = parseInt(totalAmtText) - parseInt($(this).val());
	 		
	 		$("#payAmt").val(remainAmt);
	 	});
	 	
	 	$("#payAmt").on("keyup", function(){
			var remainAmt = parseInt(totalAmtText) - parseInt($(this).val());
	 		
	 		$("#cardPayAmt").val(remainAmt);
	 	});
	 	
	 	
// 	   	$('#lpay').click(function() {
// 	 		if($('#selfAuth').css('display') == 'none')
// 	 			$('#selfAuth').show();
// 	 	}); 
	 	
	 	if(nullToBlank(hotelInfo) != '') {
		 	for(var i = 0; i < hotelInfo.length; i++){
		 		var cancelJtbDl = hotelInfo[i].setRoomData[0].rateInfos[0].cancelJtbDl; //hotelInfo[i].setRoomData[0].rateInfos[0].jtbCancelDt;
				var cancelTL = '16:00:00';//hotelInfo[i].setRoomData[0].rateInfos[0].jtbCancelTm;
				
		/* 		var cancelDLArr = cancelDL.split("-");
				
				if(cancelDLArr.length == 1){
					cancelDLArr[0] = cancelDL.substring(0, 4);
					cancelDLArr[1] = cancelDL.substring(4, 6);
					cancelDLArr[2] = cancelDL.substring(6, 8);
				}
				
				var weekChk = new Date(cancelDLArr[0], parseInt(cancelDLArr[1]) - 1, cancelDLArr[2]);
				var cancelDayChk = new Date(cancelDLArr[0], parseInt(cancelDLArr[1]) - 1, cancelDLArr[2]);
				cancelDayChk.setDate(cancelDayChk.getDate() - 1);
		 		
				if(weekChk.getDay() == 0){
					weekChk.setDate(weekChk.getDate() - 2);
					cancelTL = "16:00:00";
				}else if(weekChk.getDay() == 6){
					weekChk.setDate(weekChk.getDate() - 1);
					cancelTL = "16:00:00";
				}
				
				if(cancelDayChk.getDay() == 0){
					cancelDayChk.setDate(cancelDayChk.getDate() - 2);
				}else if(cancelDayChk.getDay() == 6){
					cancelDayChk.setDate(cancelDayChk.getDate() - 1);
				}
				
				cancelDL = weekChk.format("yyyy-MM-dd");
				cancelDay = cancelDayChk.format("yyyy-MM-dd");
				 */
				//console.log(nowServerDay);
				//console.log(cancelDay);
				if(nullToBlank(cancelJtbDl) != '' && cancelJtbDl != '환불불가')
				{
					var cancelDay = cancelJtbDl.split("16:00");
					console.log(cancelDay[0]);
				}
				
		 		if(cancelJtbDl == '환불불가'){
		 			$("#virtual").hide();
		 			$("#dual").hide();
		 			$("#lpay").hide();
		 		}else if(nowServerDay >= cancelDay[0] && cancelTL <= curDt){
		 			$("#virtual").hide();
		 			$("#dual").hide();
		 			$("#lpay").hide();
		 		}
		 		
		 		//$("#lpay").hide();
		 	}
	 	}
	 	
	 
	 	rsvMstUserInfo.selectT(function(tx, results){
	 		if(results.rows.length > 0){
	 			var telNo = convertTel(results.rows.item(0).resPhoneNum);
	 			var custchk = sessionStorage.custChk;
	 			var countrychk = JSON.parse(sessionStorage.hotelViewData);
	 			var ijw = sessionStorage.ijw;
	 			var ijwk = sessionStorage.ijwk;
	 			var basketData = JSON.parse(sessionStorage.hotelBasketData);
	 			var ijwpay = 0;
	 			var cntHtl = 1;
	 			for(var i=0; i < basketData.length; i++){
	 				if(custchk == "그룹직원"){
	 					if(basketData[i].countryCd == 'KR' || countrychk.countryCode == 'KR'){
	 						var ijwpays = Math.floor(basketData[i].setRoomData[0].rateInfos[0].bfTotal * (ijwk * 0.01));
	 						ijwpay += ijwpays;
	 					} else {
	 						var ijwpays = Math.floor(basketData[i].setRoomData[0].rateInfos[0].bfTotal * (ijw * 0.01));
	 						ijwpay += ijwpays;
	 					}
	 				} else {
	 					var ijwpays = "";
	 					ijwpay = "";
	 				}
	 				cntHtl += i;
	 			}
	 			
	 			if(cntHtl > 1){
			 			$("#dual").hide();
	 			}
	 			
	 			reqReserveInfo = {
    	        	'concMix'		: results.rows.item(0).concMix,
    	        	'userId'		: results.rows.item(0).resUserId,
    	        	'userNm'		: results.rows.item(0).resKorNm,
    	        	'userEmail'		: results.rows.item(0).resEmail,
    	        	'userTel'		: telNo,
    	        	'saleAmtTot'	: results.rows.item(0).saleAmtTot,
    	        	'saleAmtAir'	: results.rows.item(0).saleAmtAir,
    	        	'saleAmtHtl'	: results.rows.item(0).saleAmtHtl,
    	        	'saleAmtRnt'	: results.rows.item(0).saleAmtRnt,
    	        	'airDiscntAmt'	: results.rows.item(0).airDiscntAmt,
    	        	'htlDiscntAmt'	: results.rows.item(0).htlDiscntAmt,
    	        	'rntDiscntAmt'	: results.rows.item(0).rntDiscntAmt,
    	        	'ijwDiscntAmt'	: ijwpay
	        	}

	 			gfn_callAjax('/fit/rsv/insertFreeRsvNo.do', reqReserveInfo, 'fn_saveFitRsvNo');
	 		};
	 		
	 		fn_init();
			fn_initEvent();
	 	}, jSessionID);
	});
	
	function fn_saveFitRsvNo(_data){
		payFitRsvNo = _data.fitRsvNo;
		console.log(_data.fitRsvNo);
		
		$("#FIT_RSV_NO").val(payFitRsvNo);
		$("#resCd").val(payFitRsvNo)
	}
	
	function convertTel(hp) {
        // 입력값이 있을때만 실행합니다.
        if(hp != null && hp != '')
        {
            // 총 핸드폰 자리수는 11글자이거나, 10자여야 합니다.
            if(hp.length==11) 
            {   
                hp = hp.substring(0, 3) + "-" + hp.substring(3, hp.length - 4) + "-" +hp.substring(hp.length-4, hp.length);                
            } else if(hp.length==10) {
                 hp = hp.substring(0, 3) + "-" + hp.substring(3, hp.length-4) + "-" +hp.substring(hp.length-4, hp.length);                
            }
        }
        
        return hp;
    }

	/**
	 * 초기화
	 */
	function fn_init() {
		if(nullToBlank(reqReserveInfo) == '') return;
		
		//임직원 관련
		var custchk = sessionStorage.custChk;
		var countrychk = JSON.parse(sessionStorage.hotelViewData);
		var ijw = sessionStorage.ijw;
		var ijwk = sessionStorage.ijwk;
		var basketData = JSON.parse(sessionStorage.hotelBasketData);
		var ijwpay = 0;
		
		for(var i=0; i < basketData.length; i++){
			if(custchk == "그룹직원"){
				if(basketData[i].countryCd == 'KR' || countrychk.countryCode == 'KR'){
					var ijwpays = Math.floor(basketData[i].setRoomData[0].rateInfos[0].bfTotal * (ijwk * 0.01));
					ijwpay += ijwpays;
				} else {
					var ijwpays = Math.floor(basketData[i].setRoomData[0].rateInfos[0].bfTotal * (ijw * 0.01));
					ijwpay += ijwpays;
				}
			} else {
				var ijwpays = "";
				ijwpay = "";
			}	
		}
		
		$('#userEmail').val(reqReserveInfo.userEmail);
		$('#phoneNumber').val(reqReserveInfo.userTel);

		$("#final_hotelAmt").text(comma(reqReserveInfo.saleAmtHtl) +"원");
		
		var promTotAmt = 0;
		var htlDisAmt = 0;
		var promoHTML = "";
		var promoLiHTML = "";
		
		
		if(nullToBlank(reqReserveInfo.htlDiscntAmt) != "" && reqReserveInfo.htlDiscntAmt != '0' && custchk != "그룹직원"){
			promoHTML += '<p class="ppred">호텔 프로모션 <span>-'+ comma(reqReserveInfo.htlDiscntAmt) +'원</span></p>';
			promoLiHTML += '<p>호텔 프로모션 <span class="f_red">'+ comma(reqReserveInfo.htlDiscntAmt) +'원</span></p>';
			htlDisAmt = parseInt(reqReserveInfo.htlDiscntAmt);
		}
		
		if(custchk == "그룹직원"){
				promoHTML += '<p class="ppred">롯데임직원 할인가 <span>'+ comma(ijwpay) +'원</span></p>';
				promoLiHTML += '<p>롯데임직원 할인가 <span class="f_red">'+ comma(ijwpay) +'원</span></p>';
				htlDisAmt = parseInt(ijwpay);
		}  
		
		if(nullToBlank(promotionInfo.promId) != ""){
			if(nullToBlank(promotionInfo.promAmount) != "" && promotionInfo.promAmount != '0'){
				promoHTML += '<p class="ppred">'+ promotionInfo.promName +'<span>-'+ comma(promotionInfo.promAmount) +'원</span></p>';
				promoLiHTML += '<p>'+ promotionInfo.promName +'<span class="f_red">'+ comma(promotionInfo.promAmount) +'원</span></p>';
				
				promTotAmt = parseInt(promotionInfo.promAmount);
			}else if(nullToBlank(promotionInfo.promRate) != "" && promotionInfo.promRate != '0'){
				var totalAmt = reqReserveInfo.saleAmtTot;
				var discntTotAmt = parseInt(totalAmt) - parseInt(reqReserveInfo.airDiscntAmt) - parseInt(reqReserveInfo.htlDiscntAmt);
				promTotAmt = Math.floor(discntTotAmt * parseFloat(promotionInfo.promRate));
				
				promoHTML += '<p class="ppred">'+ promotionInfo.promName +'<span>-'+ comma(promTotAmt) +'원</span></p>';
				promoLiHTML += '<p>'+ promotionInfo.promName +'<span class="f_red">'+ comma(promTotAmt) +'원</span></p>';
			}
		}
		
		
		$("#promoDiv").html(promoHTML);
		if(promoLiHTML == ""){
			$("#promoLi").hide();
		}else{
			$("#promoLi").html(promoLiHTML);
		}
		var htlTotAmt = parseInt(reqReserveInfo.saleAmtHtl);	
		
		htlTotAmt = htlTotAmt - htlDisAmt - promTotAmt;
		totalAmtText = htlTotAmt;

		$("#totalAmt").text(comma(htlTotAmt) +"원");
		
//		$("#final_rentAmt").text(comma('${rsvResult.getSaleAmtRnt()}') +"원");

		$("#submitLpayValue").hide();
		$("#lpayAprvIf").hide();
		$("#dlp").hide();
		$("#lpayTranCertIf").hide();
		$("#lpayMemCertIf").hide();
		$("#sub").hide();
		$("#dlp").hide();
		$("#dlpcard").hide();

		$("#form1").hide();
		$("#form3").hide();

		var formData = new FormData();
		cfn_ajax({
			type : "POST",
			async : false,
			url: "/free/account/LPointSrcAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			timeOut : 5 * 60 * 1000,
			success: function(data) {
				if(data.code == "00"){
					var usePoint	=	comma(parseInt(data.usePoint));
					
					usePoint = "LPOINT (" + usePoint + "점)";
					
					$('#useablepoint').text(usePoint);
				}
			},
			error : function(err) {
				setAlert("결제 도중 오류가 발생하였습니다.");
				console.log(err);
			},
			complete : function(e) {
				console.log(e);
				fn_rsvInfo();
			}
		}); 
	}

	/**
	* 대표 예약자 정보 
	*/
	var fn_rsvInfo = function() {
		/*
		var formData = new FormData();
		formData.append("fitRsvNo", rsvResult);
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
				var revInfo = data.rsvHtlCancel;
				console.log(">>>=" + revInfo[0].name);
				//이니시스 결제 예약자명 전달 위함.
				var vHtml = "<input type='hidden' id='rsvName' data-role='none' class='pro_price' value=" + revInfo[0].name + " />"
				
				$('#divName').html(vHtml);
				
//				document.lpayTranCertIf.P_REQ_NM_org.value = revInfo[0].name;
//				document.lpayMemCertIf.P_REQ_NM_org.value = revInfo[0].name;				
			},
			error : function(err) {
				console.log(err);
			},
			complete : function(e) {
				console.log(e);
			}
		});
		*/
		
		if(reqReserveInfo.length > 0){
			var vHtml = "<input type='hidden' id='rsvName' data-role='none' class='pro_price' value=" + reqReserveInfo.userNm + " />"
			
			$('#divName').html(vHtml);
		}
	};
	
	
	/**
	 * 이벤트 초기화
	 */
	function fn_initEvent() {
		$('#card').click(function(){
			
			$('input[name=paymentMethod]').val("Card")			// 신용카드

			$('#cellCashCardNo1').val("");
			$('#bizRegNo1').val("");
			$('#bizRegNo2').val("");
			$('#bizRegNo3').val("");
			$('#vbankRegNo').val("");
			
			$("#chk_ck20").prop('checked', false) ;
			
			$('#cardPayAmt').val("");
			$('#payAmt').val("0");
			$('#bankforvbank').val("");
		});
		$('#virtual').click(function(){
			$('input[name=paymentMethod]').val("VBank");		// 무통장입금(가상계좌)
			
			
			$('#cardPayAmt').val("");
			$('#payAmt').val("0");
			$('#bankforvbank').val("");
		});
//		$('#real').click(function(){
//			$('input[name=paymentMethod]').val("DirectBank");	// 실시간계좌이체
//		});
		$('#dual').click(function(){
			$('input[name=paymentMethod]').val("Etc");			// 복합결제 
			console.log("ETC:" + $('input[name=paymentMethod]').val())
			
		});
		
		
		$('#lpay').click(function(){
			$('input[name=paymentMethod]').val("Lpay");			// LPAY 
			
			var check_form = $('form[ft-att="check"]');
			
			if( check_form.find("#MEM_M_NUM").val() == ""	){
				$('.paylist_chkbox2 #card').click();
				
				setAlert("로그인을 하여 주십시요.");
				return;
			}
			
			$('#cellCashCardNo1').val("");
			$('#bizRegNo1').val("");
			$('#bizRegNo2').val("");
			$('#bizRegNo3').val("");
			$('#vbankRegNo').val("");
			
			$("#chk_ck20").prop('checked', false) ;
			
			$('#cardPayAmt').val("");
			$('#payAmt').val("0");
			$('#bankforvbank').val("");
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
			
			var pointCheck	=	$('input[name="lottePoint"]').val();
			
			if(nullToBlank(pointCheck) != ""){
				if(    (pointCheck.trim() != "" && pointCheck.trim() != "0") && $('input[name="wpw"]').val() == ""	){
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
				var payPrice = $("#totalAmt").text().replace('원','').replace(/,/gi, '');
				//payPrice	=	"1004";
				var type		=	"";
				
				if($('input[name=paymentMethod]').val() == "VBank"){	//	가상계좌
					type	=	"VBank";
				}else{
					type	=	"Card";
				}
				formData.append('price', payPrice);
				formData.append('type', type);
				
		 		cfn_ajax({
					type : "POST",
					async : false,
					url: "/free/account/getPayPriceAjax.do",
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
						submitform1.find("#P_GOODS").val("자유여행 ["+ payFitRsvNo +"]");
						
						submitform3.find("#P_MID").val(result.mId);
						submitform3.find("#P_NEXT_URL").val(result.returnUrl);
						submitform3.find("#P_OID").val(result.oId);
						submitform3.find("#P_GOODS").val("자유여행 ["+ payFitRsvNo +"]");

						$('input[name="goodname"]').val("자유여행 ["+ payFitRsvNo +"]"); // 상품명

						console.log("P_MID:" + submitform3.find("#P_MID").val());
						console.log("P_NEXT_URL:" + submitform3.find("#P_NEXT_URL").val());
						console.log("P_OID:" + submitform3.find("#P_OID").val());
						console.log("P_GOODS:" + submitform3.find("#P_GOODS").val());

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
				var proofCheck	=	"";
	
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
		                var proof = document.getElementsByName("proof");
		                
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
		    			      			setAlert('소득공제 개인용 휴대폰 번호 또는 현금영수증 카드번호를 입력하세요.');
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
		                var proof = document.getElementsByName("proof");
		                
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
	
					} else if (paymentMethod === 'Lpay') { // 
						return;
					} else { // L.Pay 결제
	//					fn_authUserByLpay();
						setAlert("결제수단을 선택해 주세요");
						return;
					}
				}
			  	if($('#chk_ck10').is(":checked") == false) {
			  		alert("구매 동의에 체크해 주세요");
			  		return false;
			  	}
	
			  	///////////////////////////////
				buyerEmail = $('#userEmail').val();
				buyerTel = $('#phoneNumber').val();
				/* alert(JSON.stringify(reqReserveInfo)); */
				/* alert(payAmtInfo.payExpAmt); */
				var buyerName = reqReserveInfo.userNm; 
				///////////////////////////////
	
			  	// ### 결제요청 정보 설정 ###
				console.log('paymentMethod', paymentMethod);
			  	console.log('buyerEmail', buyerEmail);
			  	console.log('payExpAmt', payAmtInfo.payExpAmt);
			  	console.log('buyerTel', buyerTel);
			  	
			  	submitform1.find("#P_AMT").val(payAmtInfo.payExpAmt);	//	총결제금액
			  	submitform1.find("#P_UNAME").val(buyerName);			//	구매자명
			  	submitform1.find("#P_MOBILE").val(buyerTel);			//	구매자 핸드폰번호
			  	submitform1.find("#P_EMAIL").val(buyerEmail);			//	구매자 이메일

			  	submitform3.find("#P_AMT").val(payAmtInfo.payExpAmt);	//	총결제금액
			  	submitform3.find("#P_UNAME").val(buyerName);			//	구매자명
			  	submitform3.find("#P_MOBILE").val(buyerTel);			//	구매자 핸드폰번호
			  	submitform3.find("#P_EMAIL").val(buyerEmail);			//	구매자 이메일

			  	$('input[name="paymentMethod"]').val(paymentMethod === 'Etc' ? 'Card' : paymentMethod); // 결제수단 (복합결제일 경우 신용카드 결제로)
				$('input[name="buyeremail"]').val(buyerEmail); // 구매자 이메일
		 	  
	//			goodsPrice		=	splitParam[0]; 		//	상품가격
	//			startDay		=	splitParam[1]; 		//	여행시작일자
	//			cardNo			=	splitParam[2]; 		//	LPoint카드번호
	//			wpw				=	splitParam[3]; 		//	LPoint패스워드
	//			lottePoint		=	splitParam[4]; 		//	사용포인트
	//			cashPayAmt		=	splitParam[5];		//	현금결제금액	(복합결제의경우)
	//			cashType		=	splitParam[6];		//	현금영수증타입(0:소득공제(소비자용), 1:지출증빙(사업자용))
	//			cashReceipts	=	splitParam[7];		//	현금영수증인증번호(핸드폰번호, 사업자등록번호)	
	//			giftCard		=	splitParam[8]; 		//	상품권번호	 
	//			giftCardAmt		=	splitParam[9]; 		//	상품권금액	 
	//			buyerTel		=	splitParam[10]; 	//	구매자 전화번호
	//			buyerEmail		=	splitParam[11]; 	//	구매자 이메일
	//			goodName		=	splitParam[12]; 	//	상품명
	//			vcdbank			=	splitParam[13]; 	//	입금은행코드
	//			rescd			=	splitParam[14]; 	//	예약번호
	//			mid				=	splitParam[15];		//	결제구분
			  	var merchantDataVal	=	"";
	
				merchantDataVal	=	$('input[name="P_AMT"]').val();									//	상품가격(복합결제금액 제외 카드결제금액 또는 가상계좌금액)
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
			  	merchantDataVal	=	merchantDataVal + "	" +  encodeURIComponent($('input[name="goodname"]').val());	//	상품명
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
				
				if($('input[name=paymentMethod]').val() == "Card"){				// 신용카드
					document.getElementById("form3").submit();
//				document.getElementById("form1").submit();
				}else if(	$('input[name=paymentMethod]').val() == "VBank"){	// 무통장입금(가상계좌)
					document.getElementById("form1").submit();
				}
			}
		});
	}
</script>
<!-- ----------------------- L.Pay용 script start ---------------------------- -->
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
	
	document.lpayMemCertIf.returnURL.value ="https://m.lottejtb.com/returnlpayMemCertIf.jsp"
// 	document.lpayMemCertIf.returnURL.value ="http://mdev.lottejtb.com/returnlpayMemCertIf.jsp"
	document.lpayMemCertIf.action="http://www.lottejtb.com/jsp/lpay/lpayMemCertIf.faces";
	document.lpayMemCertIf.submit();
}

function returnlpayTranCertIf(data){
	showLoading();
	var dlp =  eval("("+data+")");
	
	if(dlp["RESULT_VAL"] == 'S'){
	//setAlert('?');
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
    
	document.dlp.returnURL.value ="https://m.lottejtb.com/returnDLP.jsp"
// 	document.dlp.returnURL.value ="http://mdev.lottejtb.com/returnDLP.jsp"
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
   // document.lpayTranCertIf.GDS_TOT_AMT.value = 1004; 	//	상품금액
    document.lpayTranCertIf.GDS_SUP_AMT.value = $("#totalAmt").text().replace('원','').replace(/,/gi, '');
  //  document.lpayTranCertIf.GDS_SUP_AMT.value = 1004; 	//	공급가액
    
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
// 	document.lpayTranCertIf.returnURL.value ="http://mdev.lottejtb.com/returnlpayTranCertIf.jsp"
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
	  
	document.lpayAprvIf.returnURL.value ="https://m.lottejtb.com/returnlpayAprvIf.jsp"
// 	document.lpayAprvIf.returnURL.value ="http://mdev.lottejtb.com/returnlpayAprvIf.jsp"
	document.lpayAprvIf.action="http://www.lottejtb.com/jsp/lpay/lpayAprvIf.faces";
	document.lpayAprvIf.submit();
 
}

function returnlpayAprvIf(data){
	var res =  eval("("+data+")");
	
	if(res["RESULT_VAL"] == 'S'){
		// 성공 DB 저장 시작해야 함
		saveLpayDB();
	}else{
		hideLoading();
		setAlert('L.Pay 결제에 실패하였습니다.');
	}
}

function saveLpayDB(){
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
		
		merchantDataVal	=	$('input[name="P_AMT"]').val();									//	상품가격(복합결제금액 제외 카드결제금액 또는 가상계좌금액)
	  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="startDay"]').val();		//	여행시작일자
	  	merchantDataVal	=	merchantDataVal + "	" + $('input[name="cardNo"]').val();		//	LPOINT 카드번호
	  	merchantDataVal	=	merchantDataVal + "	" + $('input[name="wpw"]').val();			//	LPOINT 패스워드
	  	merchantDataVal	=	merchantDataVal + "	" +	$('input[name="lottePoint"]').val();	//	사용포인트
	  	merchantDataVal	=	merchantDataVal + "	" + $('input[name="payAmt"]').val();		//	현금결제금액	(복합결제의경우)
	  	if( "busi" == proofCheck){
		  	merchantDataVal	=	merchantDataVal + "	" +  "1";								//	현금영수증타입(0:소득공제(소비자용), 1:지출증빙(사업자용))
	  	}else{
		  	merchantDataVal	=	merchantDataVal + "	" +  "0";								//	현금영수증타입(0:소득공제(소비자용), 1:지출증빙(사업자용))
	  	}
	  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="vbankRegNo"]').val();	//	현금영수증인증번호(핸드폰번호, 사업자등록번호)
	  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="giftNo"]').val();		//	상품권번호
	  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="giftNoAmt"]').val();	//	상품권금액
	  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="phoneNumber"]').val();	//	구매자 전화번호
	  	merchantDataVal	=	merchantDataVal + "	" +  $('input[name="userEmail"]').val();	//	구매자 이메일
	  	merchantDataVal	=	merchantDataVal + "	" +  encodeURIComponent($('input[name="goodname"]').val());	//	상품명
	  	merchantDataVal	=	merchantDataVal + "	" +  $("select[name=bankforvbank]").val();	//	입금은행코드
	  	merchantDataVal	=	merchantDataVal + "	" + $('input[name="resCd"]').val();			//	예약번호
	  	if($('input[name="paymentMethod"]').val() == "Card"){
	  		merchantDataVal	=	merchantDataVal + "	" + "Card";		//	결제구분
	  	}else{
	  		merchantDataVal	=	merchantDataVal + "	" + "VBank";	//	결제구분
	  	}
	  	submitform1.find("#P_NOTI2").val(encodeURIComponent(merchantDataVal));			
	  	hideLoading();
		document.submitLpayValue.action = "https://m.lottejtb.com/free/account/paymentLpayReturn.do";
// 		document.submitLpayValue.action = "http://mdev.lottejtb.com/free/account/paymentLpayReturn.do";
		document.submitLpayValue.submit();
}


function regDlp(){
	var check_form = $('form[ft-att="check"]');
	
	if( check_form.find("#MEM_M_NUM").val() == ""	){
		setAlert("로그인을 하여 주십시요.");
		return;
	}
	
	$('.paylist_chkbox2 #card').click();


	document.dlpcard.returnURL.value ="http://www.lottejtb.com/returnRegDlp.jsp";
	document.dlpcard.action="http://www.lottejtb.com/jsp/lpay/lpayRegPayment.faces";
	document.dlpcard.submit();
	
}

function returnRegDlp(data){

 	if(data == 'S'){
//	     setAlert('성공했습니다.');
	}else{
		setAlert('L.pay연동에 실패하였습니다.');
	}
}

</script>
<!-- ----------------------- L.Pay용 script end ---------------------------- -->
<!-- ----------------------- 상품권을 위한 Script ---------------------------- -->
<script>
// 상품권 번호 조회 
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

	var totalAmt	=	$("#final_hotelAmt").text().replace('원','').replace(/,/gi, '');
	var giftAmt		=	$("#giftAmtText").text().replace('원','').replace(/,/gi, '');
	var lpointAmt	=	$("#lpointAmtText").text().replace('원','').replace(/,/gi, '');

	console.log("fn_giftApply() >> totalAmt : " + totalAmt);
	console.log("fn_giftApply() >> giftAmt : " + giftAmt);
	console.log("fn_giftApply() >> lpointAmt : " + lpoint);
	
	totalMinusAmt	=	parseInt(giftAmt) + parseInt(lpoint);
	totalAmtText	=	parseInt(totalAmt) - parseInt(giftAmt) - parseInt(lpoint);
	
	// totalAmtText	=	parseInt(totalAmt) + parseInt(giftAmt) + parseInt(lpointAmt);
	$("#totalMinusAmtText").text(comma(totalMinusAmt) + "원");
	$("#totalAmt").text(comma(totalAmtText) + "원");
	// $("#lpointAmtText").text(comma(lpoint) + "원");
	// $("#lpointAmt").show();
}

// 상품권 사용 리턴 
function returnGiftNumberCertIf(data){
   var gift =  eval("("+data+")");

   if(gift.COUPON["RETCODE"] == 'S'){
	   if(gift.COUPON["REALAMT"] < 0){
		   document.getElementById('giftNoAmt').value = "100";
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
// 	document.giftNumberCertIf.returnURL.value ="http://mdev.lottejtb.com/returnGiftNumberCertIf.jsp"
	document.giftNumberCertIf.action="http://www.lottejtb.com/jsp/gift/giftNumberCertIf.faces";
	document.giftNumberCertIf.submit();
}
</script>

</head>
<body>

	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="navstitle freeback">
			결제하기<!-- a href="javascript:history.back(-1);">뒤로</a -->
		</div>
		<div class="free_reserve collapse fr_paybox">
			<div id="divName">
				
			</div>
			<!-- 예약상품정보 및 결제상품정보-->
			<%@ include file="/WEB-INF/jsp/account/inc_rsv_info.jsp" %>
			<!-- 예약상품정보 및 결제상품정보-->			
			<!-- 마일리지 버튼 -->
			<%-- <div class="btn_one air_tbtn addbtn2">
				<button class="layerOpener purple2" data-role="none" data-url="/pop/pop_mileage.do?seqNo=${seqNo}" data-ctn="full" data-ok="yes">마일리지 등록</button>
			</div> --%>
			 
			<!--  <p class="obj_title2 obj_bg_wht mt7"><span class="ico_paym">입금내역</span></p>
			
			<table class="ft_table2 ft_th_tl ft_tb_tr">
				<colgroup>
					<col style="width:30%" />
					<col style="width:70%" />
				</colgroup>
				<tbody>
				<tr>
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
					<td></td>
				</tr>
				<tr class="tb_purple">
					<th class="white2">입금총액</th>
					<td>0원</td>
				</tr>
				</tbody>
			</table>  -->
		
			<!-- 여권정보등록 -->
			<div id="passport_div">
				<%@ include file="/WEB-INF/jsp/account/inc_passport_info.jsp" %>
			</div>
			<!-- 여권정보등록 -->
			<!-- 목적지/거주지 정보 등록 및 변경 -->
			<div id="arr_info_div">
				<%@ include file="/WEB-INF/jsp/account/inc_arr_info.jsp" %>
			</div>
			<!-- 목적지/거주지 정보 등록 및 변경 -->
			<!-- 비자정보 등록 및 변경 -->
			<!-- 현지 연락처 등록 및 변경 -->
			<div id="contact_info_div">
				<%@ include file="/WEB-INF/jsp/account/inc_contact_info.jsp" %>
			</div>
			<!-- 현지 연락처 등록 및 변경 -->

			<!-- 결제하기 -->
			<p class="obj_title2 obj_bg_wht mt7">
				<span class="ico_paym">결제하기</span>
			</p>
			<ul class="payinfo_ctnbox">
				<li id="promoLi">
				</li>
				<li>
					<div>
						<em id="useablepoint">LPOINT (0점)</em> <em class="f_red">&nbsp;</em>
						<button class="payc_btn payc_view" type="button" data-role="none">본인확인</button>
						<button class="payc_btn payc_use" type="button" data-role="none" onClick="javascript:fn_lpointApply();">적용</button>
					</div>
					<div class="pc_lpoint_div1">
						<button class="layerOpener" data-role="none" data-url="/pop/lpointPop.do" data-ctn="full" data-ok="yes">본인확인</button>
<!--  						<button type="button" data-role="none" id="applyLpoint">본인확인</button> -->
						<input type="text" data-role="none" class="lpoint_text"  id="lpoint" name="lottePoint"	value="0"/>P
						<p class="chkbox">
							<span><input id="chk_ck30" type="checkbox" data-role="none"></span> <label for="chk_ck30">전체사용</label>
						</p>
					</div>
				</li>
				<!-- <li>
					<div>
						<em>롯데제이티비 여행상품권</em> <em class="f_red">&nbsp;</em>
						<button class="payc_btn payc_view" type="button" data-role="none">조회</button>
						<button class="payc_btn payc_use" type="button" data-role="none">적용</button>
					</div>
					<div class="pc_lpoint_div2">
						<input type="hidden" data-role="none" class="pro_price" id="giftNoAmt" name="giftNoAmt" value="0" /> 
						<input type="text" data-role="none" placeholder="상품권 번호 입력"  id="giftNo" name="giftNo" value="" />
						<button type="button" data-role="none" id="schGift">조회</button>
					</div>
				</li> -->
				
			</ul>
			<!-- 결제 선택 -->	
			<ul class="paylist_chkbox2">
				<c:if test="${cust_cd == '0000888789'}">
					<li><button type="button" data-role="none" id="lpay" >Lpay<br>간편결제</button></li>
				</c:if>
				<li><button type="button" data-role="none" id="card">신용카드</button></li>
				<li><button type="button" data-role="none" id="virtual">가상계좌</button></li>
				<li><button type="button" data-role="none" id="dual">신용카드 +<br/> 무통장입금</button></li>
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
							<td><input type="text" data-role="none" id="cardPayAmt"/> 원
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
			<dl class="toggle_acdon card_bankinfo obj_none">
				<dt>무이자 할부정보</dt>
				<dd>
						<p>하나카드 (2~6개월)</p>
						<p>비씨카드 (2~6개월)</p>
						<p>씨티카드 (2~6개월)</p>
						<p>삼성카드 (2~6개월)</p>
						<p>현대카드 (2~6개월)</p>
						<p>농협카드 (2~8개월)</p>
						<p>신한카드 (2~5개월)</p>
						<p>국민카드 (2~6개월)</p>
					<p>롯데카드 미제공</p>
				</dd>
			</dl>
			<!-- 결제 선택 : 증빙거래 영수증 -->
			<dl class="online_bankinfo obj_none">
				<dt>증빙거래 영수증</dt>
				<dd>
					<p class="chkbox">
						<span><input id="chk_ck20" type="checkbox" data-role="none"></span>
						<label for="chk_ck20">현금영수증 신청 <br/>
							<!-- em>(현금영수증 미 신청 시 자진 발급됩니다)</em><br --> 
							<em> * 상품권/무통장입금/실시간 계좌이체로 이용한 금액 만 현금영수증 발행이 가능합니다.</em>
						</label>
					</p>
				</dd>
				<dd class="ob_num_box1">
					<span class="radioboxs"><input type="radio" name="proof" id="proof1" data-role="none" value="indi"></span> 
					<label for="radio1">소득공제용(개인용)
						<em>휴대폰 번호 또는 현금영수증 카드번호</em>
					</label>
					<p>
						<input type="text" data-role="none" id="cellCashCardNo1"/>
					</p>
				</dd>
				<dd class="ob_num_box2">
					<span class="radioboxs"><input type="radio" name="proof" id="proof2" data-role="none" value="busi"></span> 
					<label for="radio2">지출증빙용(사업자용) 
						<em>사업자 등록번호</em>
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
					L.pay에 등록된 카드/계좌가 없습니다.
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
				
				<!-- 	<select name="" class="fr_select" data-role="none">
						<option value="">카드선택</option>
						<option value="롯데카드">롯데카드</option>
						<option value="국민카드">국민카드</option>
				 	</select> -->
				
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
					<!-- <p>항공 <span id="final_airAmt"></span></p> -->
					<p>호텔 <span id="final_hotelAmt"></span></p>
					<!-- <p>렌터카(후불) <span id="final_rentAmt"></span></p> -->
					<div id="promoDiv"></div>
					<!-- <p class="ppred">프로모션 <span>0원</span></p> -->
					<p class="ppred" id="lpointAmt" style="display:none">L.Point<span id="lpointAmtText">0원</span></p>
					<p class="ppred" id="giftAmt" style="display:none">상품권<span id="giftAmtText">0원</span></p>
				</li>
			</ul>
			<p class="pop_avtitle3">
				총 결제예정금액 <span id="totalAmt">0원</span>
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
							<td><input type="text" data-role="none"	id="userEmail" name="userEmail" placeholder="test@test.com" /></td>
						</tr>
						<tr>
							<th>이동전화<em class="f_red">*</em></th>
							<td><input type="text" data-role="none" id="phoneNumber" name="phoneNumber" placeholder="" /></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="obj_bg_wht payend_sel_box">
				<p class="chkbox">
					<span><input id="chk_ck10" type="checkbox" data-role="none"></span>
					<label for="chk_ck10">주문하실 상품의 상품명, 가격, 유의사항을 확인하였으며, 구매에 동의합니다.</label>
				</p>
			</div>
			<!-- 버튼 -->
			<div class="btn_one air_tbtn addbtn2">
				<button class="purple2" data-role="none" id="btnPayment">결제하기</button>
			</div>
			<div class="btn_one air_tbtn">
				<button class="white2" data-role="none" onclick="pageBack();">취소하기</button>
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
		<input type="hidden" name="resCd" id = "resCd" value="" > <!-- 예약번호 -->

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
					startDay		=	splitParam[14]; 	//	여행시작일자
				
		<input type="hidden" name="merchantData" value="1010	P170213-0001	8710400970377574	1q2w3e	10	0					20170607" > 신용카드
		<input type="hidden" name="merchantData" value="1010	P170213-0002	8710400970377574	1q2w3e	10	0	1	01027249613			20170607" > 가상계좌
		<input type="hidden" name="merchantData" value="1010	P170213-0003	8710400970377574	1q2w3e	10	0					20170607" > 실시간계좌이체
		<input type="hidden" name="merchantData" value="1530	P170213-0001	8710400970377574	1q2w3e	10	500	1	01027249613	11111	20	20170607" > 복합결제
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
<input type="hidden" id="FIT_RSV_NO" name="FIT_RSV_NO" value=""/>	<!-- 예약번호 -->
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
</form>

<form id="dlpcard" name="dlpcard"  method="post" target="sub">
	<br/>c:<input type="text" id="c" name="c" value="${cno}"/>
	<input type="hidden" id="returnURL" name="returnURL" value=""/>상품명
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
<input type="hidden" name="P_NEXT_URL" id="P_NEXT_URL" value="https://m.lottejtb.com/free/account/paymentReturn.do" />
<input type="hidden" name="P_TAX" id="P_TAX" value="0" />
<input type="hidden" name="P_RESERVED" id="P_RESERVED" value="auth_charset=utf8" />
<input type="hidden" name="P_NOTI_URL" id="P_NOTI_URL" value="https://fit.lottejtb.com/payment/vacct/depoNoti.do" />

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
<input type="hidden" name="P_NEXT_URL" id="P_NEXT_URL" value="https://m.lottejtb.com/free/account/paymentReturn.do" />
<input type="hidden" name="P_NOTI_URL" id="P_NOTI_URL" value="https://fit.lottejtb.com/payment/vacct/depoNoti.do" />
<input type="hidden" name="P_RETURN_URL" id="P_RETURN_URL" value="https://m.lottejtb.com/free/account/paymentReturn.do" />
<input type="hidden" name="P_TAX" id="P_TAX" value="0" />
<input type="hidden" name="P_RESERVED" id="P_RESERVED" value="twotrs_isp=Y&block_isp=Y&twotrs_isp_noti=N&apprun_check=N&auth_charset=utf8" />
<input type="hidden" name="P_QUOTABASE" id="P_QUOTABASE" value="01:02:03:04:05:06:07:08:09:10:11:12:13:14:15:16:17:18:19:20:21:22:23:24:25:26:27:28:29:30:31:32:33:34:35:36" />

<input type="hidden" name="P_NOTI" id="P_NOTI" value="" />
<input type="hidden" name="P_MOBILE" id="P_MOBILE" value="" />
<input type="hidden" name="P_EMAIL" id="P_EMAIL" value="" />
<input type="button" onclick="formSubmit();" >신용카드T3-4</>
</form>	

<!-- 상품권관련 -->
<form id="giftNumberCertIf " name="giftNumberCertIf"  method="post" target="sub" style="display:none;">
    <input type="text" id="GIFTNO" name="GIFTNO" value=""/>
    <input type="text" id="RETURNDATA" name="RETURNDATA" value=""/>
    <input type="hidden" id="returnURL" name="returnURL" value=""/>
</form>