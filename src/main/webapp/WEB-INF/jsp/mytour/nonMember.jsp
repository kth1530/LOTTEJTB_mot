<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">
	var resNm = "${userNm}";
	var email = "${email}";
	var r_phoneno = "${r_phoneno}";
	var resCd = "${resCd}";
	var exchangeObj = {};
	
	// 초기화
	var fn_init = function() {
		fn_reservationInfo();
	};
			
	// 버튼 초기화
	var fn_initButton = function() {
	};
	
	var fn_reservationInfo = function(){
		var reservFormData = new FormData();
		reservFormData.append('resNm', resNm);
		reservFormData.append('email', email);
		reservFormData.append('r_phoneno', r_phoneno);
		reservFormData.append('resCd', resCd);
		
		cfn_ajax({
			type: "POST",
			async: false,
			url: "<c:url value='/mytour/nonMemberResList.do' />",
			data: reservFormData,
			dataType: "json",
			cache: false,
			noloading:"no",
			success: function(res) {
				list = res.list.package;
				var listMst = res.list.mst;
				var listAir = res.list.air;
				var listHtl = res.list.htl;
				var listRnt = res.list.rnt;
				
				if(list.length > 0){
					$("#package_div").show();
				}
				
				if(listMst.length > 0){
					$("#free_div").show();
				}
				
				var reserHTML = "";
				for(var i = 0; i < list.length; i++){
					reserHTML += '<tr>';
					reserHTML += '	<th scope="row">예약일</th>';
					reserHTML += '	<td>'+ list[i].resDay +'</td>';
					reserHTML += '</tr>';
					reserHTML += '<tr>';
					reserHTML += '	<th scope="row">출발일</th>';
					reserHTML += '	<td>'+ list[i].startDay +'</td>';
					reserHTML += '</tr>';
					reserHTML += '<tr>';
					reserHTML += '	<th scope="row">총금액</th>';
					reserHTML += '	<td><b class="purple">'+ comma(list[i].totSaleAmt)+'원</b></td>';
					reserHTML += '</tr>';
					reserHTML += '<tr>';
					reserHTML += '	<th scope="row">예약상태</th>';
					if(list[i].statusRgCd == "RC"){
						reserHTML += '	<td>예약완료</td>';
					}else if(list[i].statusRgCd == "RW"){
						reserHTML += '	<td>예약대기</td>';
					}else if(list[i].statusRgCd == "RN"){
						reserHTML += '	<td>예약불가</td>';
					}else if(list[i].statusRgCd == "CC"){
						reserHTML += '	<td>취소완료</td>';
					}else{
						reserHTML += '	<td></td>';
					}
					reserHTML += '</tr>';
					reserHTML += '<tr>';
					reserHTML += '	<th scope="row">예약번호</th>';
					reserHTML += '	<td>'+ list[i].resCd +'</td>';
					if(list[i].statusCd == "10" || list[i].statusCd == "11" || list[i].statusCd == "H3"){
						reserHTML += '				<tr>';
						reserHTML += '					<th scope="row">결제상태</th>';
						reserHTML += '					<td><a href="#" class="purple2 myt_paybtn" onclick="fn_movePay(\''+ list[i].resCd +'\')">상세/결제</a></td>';
						reserHTML += '				</tr>';
					}
					reserHTML += '</tr>';
				}
				
				$("#reservationInfo").html(reserHTML);
				
				var freeMstHTML = "";
				
				for(var m = 0; m < listMst.length; m++){
					var totAmt = 0;
					var cancelAir = 'Y';
					var cancelHtl = 'Y';
					var cancelRnt = 'Y';
					var cancelYn;
					
					if(listMst[m].concMix.indexOf('A') > 0){
						cancelAir = listMst[m].cancelYnAir;
					}
					
					if(listMst[m].concMix.indexOf('H') > 0){
						cancelHtl = listMst[m].cancelYnHtl;
					}
					
					if(listMst[m].concMix.indexOf('C') > 0){
						cancelRnt = listMst[m].cancelYnRnt;
					}
					
					//cancelYn = cancelAir + cancelHtl + cancelRnt;
					cancelYn = cancelHtl;
					
					freeMstHTML += '<li>';
					freeMstHTML += '	<div class="free_myt_part on" id="div_'+ listMst[m].fitRsvNo +'">';
					freeMstHTML += '		<h3 class="free_myt_title1 ellipsis">예약코드 : '+ listMst[m].fitRsvNo +' / 예약일 : '+ listMst[m].rsvDt +'</h3>';
					freeMstHTML += '		<div class="fr_myt_gbox1">';
					if(cancelYn == "Y"){
						freeMstHTML += '			<span class="app_cancel_box">예약취소</span>';
					}else{
						freeMstHTML += '			<span class="app_end_box">예약완료</span>';
					}
					freeMstHTML += '			<button type="button" data-role="none" onclick="fn_rsvDetailMove(\''+ listMst[m].fitRsvNo +'\')">상세보기</button>';
					freeMstHTML += '		</div>';
					freeMstHTML += '		<dl class="fr_myt_gbox2">';
					freeMstHTML += '			<div class="cls_air">';
					freeMstHTML += '			</div>';
					freeMstHTML += '			<div class="cls_htl">';
					freeMstHTML += '			</div>';
					freeMstHTML += '			<div class="cls_rnt">';
					freeMstHTML += '			</div>';
					freeMstHTML += '		</dl>';
					freeMstHTML += '		<ul class="fr_myt_gbox3">';
					
					totAmt = listMst[m].saleAmtTot;
					
					if(listMst[m].ijwdiscntamt != '0' && listMst[m].promAmt != '0'){ 
						freeMstHTML += '			<li>임직원 할인금액<span>-'+ comma(listMst[m].promAmt) +'원</span></li>';
						totAmt = totAmt - parseInt(listMst[m].promAmt);
					}
					if(listMst[m].ijwdiscntamt == '0' && listMst[m].promAmt != '0'){
						freeMstHTML += '			<li>프로모션 할인금액<span>-'+ comma(listMst[m].promAmt) +'원</span></li>';
						totAmt = totAmt - parseInt(listMst[m].promAmt);
					}
					if(listMst[m].ijwdiscntamt == '0' && listMst[m].promAmt == '0'){
						if(nullToBlank(listMst[m].airDiscntAmt) != "" && listMst[m].airDiscntAmt > 0){
							freeMstHTML += '			<li>항공 프로모션 <span>-'+ comma(listMst[m].airDiscntAmt) +'원</span></li>';
							totAmt = totAmt - listMst[m].airDiscntAmt;
						}
						
						if(nullToBlank(listMst[m].htlDiscntAmt) != "" && listMst[m].htlDiscntAmt > 0){
							freeMstHTML += '			<li>호텔 프로모션 <span>-'+ comma(listMst[m].htlDiscntAmt) +'원</span></li>';
							totAmt = totAmt - listMst[m].htlDiscntAmt;
						}
						
						if(nullToBlank(listMst[m].rntDiscntAmt) != "" && listMst[m].rntDiscntAmt > 0){
							freeMstHTML += '			<li>렌트카 프로모션 <span>-'+ comma(listMst[m].rntDiscntAmt) +'원</span></li>';
							totAmt = totAmt - listMst[m].rntDiscntAmt;
						}
					}
					if(cancelYn == "Y"){
						totAmt = 0;
					}
					freeMstHTML += '			<li class="frmyt_allprice">총 결제예정금액 <span>'+ comma(totAmt) +'원</span></li>';
					/*
					freeMstHTML += '			<li id="'+ listMst[m].fitRsvNo +'_vou" style="display:none;">';
					freeMstHTML += '				<button type="button" data-role="none" id="'+ listMst[m].fitRsvNo +'_vou_air" style="display:none;">항공 E-Ticket</button>';
					freeMstHTML += '				<button type="button" data-role="none" id="'+ listMst[m].fitRsvNo +'_vou_htl" style="display:none;">호텔 바우처</button>';
					freeMstHTML += '				<button type="button" data-role="none" id="'+ listMst[m].fitRsvNo +'_vou_rnt" style="display:none;">렌터카 바우처</button>';
					freeMstHTML += '			</li>';
					*/
					freeMstHTML += '		</ul>';
					freeMstHTML += '	</div>';
					freeMstHTML += '</li>';
				}
				
				$('#freeReserve').append(freeMstHTML);
				
				setTimeout(function(){
					for(var a = 0; a < listAir.length; a++){
						var freeAirHTML = "";
						var inwan = "";
						
						if(listAir[a].itinShapeGb == "RT"){
							freeAirHTML += '		<dt class="ft_myy_ico1">'+ listAir[a].depNm +' - '+ listAir[a].firstArrNm +' - '+ listAir[a].lastArrNm +'</dt>';
						}else if(listAir[a].itinShapeGb == "OW"){
							freeAirHTML += '		<dt class="ft_myy_ico1">'+ listAir[a].depNm +' - '+ listAir[a].firstArrNm +'</dt>';
						}
						freeAirHTML += '		<dd>';
						freeAirHTML += '			<span class="fr_myt_gbtn1">'+ listAir[a].fareStateNm +'</span>';
						freeAirHTML += '			<span class="fr_myt_gbtn2">'+ listAir[a].rsvStateNm +'</span>';
						if(listAir[a].itinShapeGb == "RT"){
							freeAirHTML += '			<p>출발 : '+ listAir[a].depDt +' / 귀국 : '+ listAir[a].lastArrDt +'</p>';
						}else if(listAir[a].itinShapeGb == "OW"){
							freeAirHTML += '			<p>출발 : '+ listAir[a].depDt +'</p>';
						}
						
						if(listAir[a].adt != '0'){
							inwan += '성인'+ listAir[a].adt +'명 ';
						}
						if(listAir[a].chd != '0'){
							inwan += '소아'+ listAir[a].chd +'명 ';
						}
						if(listAir[a].inf != '0'){
							inwan += '유아'+ listAir[a].inf +'명 ';
						}
						
						var totSaleAmt = listAir[a].totSaleAmt;
						var totTasfAmt = listAir[a].totTasfAmt;
						var totSaleAmtT = 0;
						var totTasfAmtT = 0;
						
						if(nullToBlank(totSaleAmt) != '') totSaleAmtT = parseInt(totSaleAmt);
						if(nullToBlank(totTasfAmt) != '') totTasfAmtT = parseInt(totTasfAmt);
						
						freeAirHTML += '				<p>'+ inwan +'</p>';
						freeAirHTML += '				<div class="ft_myt_btp">';
						if(listAir[a].rsvStateGb == 'TK'){
							freeAirHTML += '					<button type="button" data-role="none" onclick="setAlert("서비스 준비중입니다.")">항공 E-Ticket</button>';
						}
						//freeAirHTML += '					<div>'+ comma(parseInt(totSaleAmtT) + parseInt(totTasfAmtT)) +'원</div>';
						freeAirHTML += '					<div>'+ comma(listAir[a].saleAmtAir) +'원</div>';
						freeAirHTML += '				</div>';
						//freeAirHTML += '			<div>'+ comma(listAir[a].totSaleAmt) +'원</div>';
						freeAirHTML += '		</dd>';
						
						$("#div_"+ listAir[a].fitRsvNo).find(".cls_air").append(freeAirHTML);
						
						/*
						if(listAir[a].rsvStateGb == "TK" || listAir[a].rsvStateGb == "TW"){
							$("#"+ listAir[a].fitRsvNo +"_vou").show();
							$("#"+ listAir[a].fitRsvNo +"_vou_air").show();
						}
						*/
					}
					
					for(var h = 0; h < listHtl.length; h++){
						var freeHtlHTML = "";
						var inwan = "";
						
						freeHtlHTML += '<dt class="ft_myy_ico2">'+ listHtl[h].htlNm +'</dt>';
						freeHtlHTML += '<dd>';
						freeHtlHTML += '	<span class="fr_myt_gbtn1">'+ listHtl[h].htlRsvstateNm +'</span>';
						if(nullToBlank(listHtl[h].htlPaymtstateNm) != ""){
							freeHtlHTML += '	<span class="fr_myt_gbtn2">'+ listHtl[h].htlPaymtstateNm +'</span>';
						}
						freeHtlHTML += '	<p>체크인 : '+ listHtl[h].checkinDt +' / 체크아웃 : '+ listHtl[h].checkoutDt +'</p>'
						if(listHtl[h].adtQty != '0'){
							inwan += '성인 '+ listHtl[h].adtQty +'명 ';
						}
						if(listHtl[h].childQty != '0'){
							inwan += '소아 '+ listHtl[h].childQty +'명 ';
						}
						freeHtlHTML += '	<p>객실 '+ listHtl[h].roomCnt +'개 '+ inwan +'</p>';
						freeHtlHTML += '	<div class="ft_myt_btp">';
						if(listHtl[h].htlRsvstateGb == "OK" && listHtl[h].htlPaymtstateGb == "OK"){
							freeHtlHTML += '		<button type="button" data-role="none" onClick="fn_goHtlVou(' +listHtl[h].htlRsvSeqno+ ')">호텔 바우처</button>';
						}
						
						var saleJtbAmt = listHtl[h].saleJtbAmt;
						if(saleJtbAmt == null) saleJtbAmt = '0'; 
						
						if(listHtl[h].saleCurrency == "KRW"){
							freeHtlHTML += '		<div>'+ comma(Math.ceil(parseFloat(saleJtbAmt))) +'원</div>';
						}else{
							freeHtlHTML += '		<div>'+ comma(Math.ceil(parseFloat(saleJtbAmt))) +'원</div>';	
						}
						
						//freeHtlHTML += '		<div>'+ comma(listHtl[h].saleAmt) +'원</div>';
						freeHtlHTML += '	</div>';
						//freeHtlHTML += '	<div>'+ comma(listHtl[h].saleAmt) +'원</div>';
						freeHtlHTML += '</dd>';
						
						$("#div_"+ listHtl[h].fitRsvNo).find(".cls_htl").append(freeHtlHTML);
						
						/*
						if(listHtl[h].htlPaymtstateGb == "OK"){
							$("#"+ listHtl[h].fitRsvNo +"_vou").show();
							$("#"+ listHtl[h].fitRsvNo +"_vou_htl").show();
						}
						*/
					}
					
					for(var r = 0; r < listRnt.length; r++){
						var freeRntHTML = "";
						var korAmt = (exchangeObj[listRnt[r].currencyCd] * parseFloat(listRnt[r].orgAmt)).toFixed();
						
						freeRntHTML += '<dt class="ft_myy_ico3">'+ listRnt[r].carModelNm +'</dt>';
						freeRntHTML += '<dd>';
						freeRntHTML += '	<p>인수 : '+ listRnt[r].pickupDt +' / 반납 : '+ listRnt[r].rtDt +'</p>';
						freeRntHTML += '	<span class="fr_myt_gbtn1">'+ listRnt[r].rntStateNm +'</span>';
						freeRntHTML += '	<div class="ft_myt_btp">';
						if(listRnt[r].rntStateGb == "OK"){
							freeRntHTML += '		<button type="button" data-role="none" onClick="fn_goRntVou(' +listRnt[r].rntRsvSeqno+ ')">렌터카 바우처</button>';
						}
						freeRntHTML += '		<div><span class="black_text1">'+ comma(korAmt) +'원/ </span>'+ comma(listRnt[r].orgAmt) + listRnt[r].currencyCd +'</div>';
						freeRntHTML += '	</div>';
						//freeRntHTML += '	<div><span class="black_text1">'+ comma(korAmt) +'원/ </span>'+ listRnt[r].orgAmt + listRnt[r].currencyCd +'</div>';
						freeRntHTML += '</dd>';
						
						$("#div_"+ listRnt[r].fitRsvNo).find(".cls_rnt").append(freeRntHTML);
						
						/*
						if(listRnt[r].rntStateGb == "OK"){
							$("#"+ listRnt[r].fitRsvNo +"_vou").show();
							$("#"+ listRnt[r].fitRsvNo +"_vou_rnt").show();
						}
						*/
					}
					
					for(var m = 0; m < listRnt.length; m++){
						for(var a = 0; a < listAir.length; a++){
							if(listMst[m].fitRsvNo == listAir[a].fitRsvNo){
								listAir.splice(a, 1);	
								
								a--;
							}
						}
						
						for(var h = 0; h < listHtl.length; h++){
							if(listMst[m].fitRsvNo == listHtl[h].fitRsvNo){
								listHtl.splice(h, 1);	
								
								h--;
							}
						}
						
						for(var r = 0; r < listRnt.length; r++){
							if(listMst[m].fitRsvNo == listRnt[r].fitRsvNo){
								listRnt.splice(r, 1);	
								
								r--;
							}
						}
					}
				}, 100);

				$("#freeReserve").trigger('create');
				
				$(".free_myt_part .free_myt_title1").off();
				$(".free_myt_part .free_myt_title1").on("click", function(){
					$(this).parent().toggleClass("on");
				});


			},
			error:function(err){
				console.log(err);
			},
			complete:function(){
				$("#reservationInfo").trigger('create');
			}
		});

		// -------------------------------------------------- 토파스 항공 예약 ---------------------------------------------------------
		/* var airReservFormData = new FormData();
		airReservFormData.append('rname', resNm);
		airReservFormData.append('remail', email);
		airReservFormData.append('rsvno', resCd);


		cfn_ajax({
			type: "POST",
			async: false,
			url: "/mytour/getTopassRsvListNonMemberAjax.do",
			data: airReservFormData,
			dataType: "json",
			cache: false,
			noloading:"no",
			success: function(res) {
				topassListAir = res.reserveAirList;
				
				topassListAirCnt = topassListAir.length;
				topassListAirLen = topassListAirCnt;
				
				var airMstHTML = "";
				
				for(var m = 0; m < topassListAirLen; m++){
					airMstHTML += '<li>';
					if(m == 0){
						airMstHTML += '	<div class="free_myt_part on" id="div_'+ topassListAir[m].PNR_SEQ_NO +'" data-collapsed="false">';
					}else{
						airMstHTML += '	<div class="free_myt_part" id="div_'+ topassListAir[m].PNR_SEQ_NO +'" data-collapsed="false">';	
					}
					airMstHTML += '		<h3 class="free_myt_title1 ellipsis">예약코드 : '+ topassListAir[m].PNR_SEQ_NO +' / 예약일 : '+ topassListAir[m].FORMAT_RESV_DATE +'</h3>';
					airMstHTML += '		<div class="fr_myt_gbox1">';
					airMstHTML += '			<span class="app_end_box">'+replaceTopassStatus(topassListAir[m].RM_LAST_STATUS)+'</span>';
					airMstHTML += '			<button type="button" data-role="none" onclick="fn_rsvAirDetailMove(\'' + topassListAir[m].PNR_SEQ_NO + '\')">상세보기</button>';
					airMstHTML += '		</div>';
					airMstHTML += '		<dl class="fr_myt_gbox2">';
					airMstHTML += '			<div class="cls_air">';
					airMstHTML += '				<dt class="ft_myy_ico1">'+ topassListAir[m].TOTAL_ITIN +'</dt>';
					airMstHTML += '			</div>';
					airMstHTML += '		</dl>';
					airMstHTML += '		<ul class="fr_myt_gbox3">';
					airMstHTML += '			<li class="tl frmyt_allprice">총 결제예정금액 <span>'+ topassListAir[m].FORMAT_TOTAL_FARE +'원</span></li>';
					airMstHTML += '		</ul>';
					airMstHTML += '	</div>';
					airMstHTML += '</li>';
				}
				
				$('#topassAirReserve').html(airMstHTML);
				console.log("topassListAir.length >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + topassListAir.length);

				
			},
			error: function(err) {
				
			},
			complete: function(){
				$("#topassAirReserve").trigger('create');
				
				
				$(".free_myt_part .free_myt_title1").off();
				$(".free_myt_part .free_myt_title1").on("click", function(){
					$(this).parent().toggleClass("on");
				});
			}
		}); */
	}
	
	// 호텔 바우쳐 링크 
	function fn_goHtlVou(rsvNo) {
		moveLink('http://fit.lottejtb.com/fit/htl/htlVoucherPop.do?rsvNo=' + rsvNo, '_system');
	}

	// 렌트카 바우쳐 링크 
	function fn_goRntVou(rsvNo) {
		moveLink('http://fit.lottejtb.com/fit/rnt/rntVoucherPop.do?rsvNo=' + rsvNo, '_system');
	}
	
	// 토파스 항공 예약 상세 
	function fn_rsvAirDetailMove(pnrseqno) {
		moveLink('https://m.air.lottejtb.com/air/b2cmpg/AIR/MBL/AIRMBLMYP0100100020.k1?KSESID=air:b2c:SELK138AX:SELK138AX::00&pnrseqno=' + pnrseqno, '_system');
	}

	// 토파스 항공 예약 단계 표시 
	function replaceTopassStatus(statusCd) {
		//     a. RMQQ : 예약대기
        //     b. RMPQ  : 예약확정
        //     c. RMTQ : 발권완료
        //     d. RMTK : 발권진행
        //     e. RMXX : 취소
		var strStatus = "";
		switch (statusCd)
		{
			case "RMQQ" :
				strStatus = "예약대기";
				break;
			case "RMPQ" :
				strStatus = "예약확정";
				break;
			case "RMTQ" :
				strStatus = "발권완료";
				break;
			case "RMTK" :
				strStatus = "발권진행";
				break;
			case "RMXX" :
				strStatus = "취소";
				break;
		}

		return strStatus;
	}

	var fn_rsvDetailMove = function(fitRsvNo) {
		document.location.href = "/free/account/free_info_detail.do?seqNo=" + fitRsvNo;
	}
	
	var fn_movePay = function(resNo){
		var payUrl = "/account/pay.do"
		location.href = payUrl + "?resCd="+ resNo
	}
	
	$(document).ready(function(){
		cfn_ajax({
			type: "POST",
			async: false,
			url: "<c:url value='/totalExchangeInfo.do' />",
			dataType: "json",
			cache: false,
			noloading:"no",
			success: function(res) {
				var list = res.list;
				
				for(var i = 0; i < list.length; i++){
					if(list[i].currCd == "JPY"){
						exchangeObj[list[i].currCd] = parseFloat(list[i].basRate) / 100;
					}else{
						exchangeObj[list[i].currCd] = list[i].basRate;	
					}
				}
			},
			error: function(err){
			}
		});
		
		fn_init();
		fn_initButton();
	});
	
</script>
</head>
<body>
<!--content-->    
	<div role="main" class="ui-content contentWrap">
	 	<div class="nav navstitle">MY TOUR</div>
	  	<div class="mytour mgT10">
			<!--L.POINT 회원 로그인 Tab-->
			<div id="tab1" class="tabContent mytrctn">
				<div class="contentBox"><!--tab1 Start-->
					<div id="package_div" style="display:none;">
						<h1 class="collapsHeading">예약/취소 내역</h1>
						<div class="listContent mytrctntb" data-role="collapsible"  data-theme="e" data-collapsed="false">
							<table>
								<colgroup>
								<col width="30%">
								<col width="70%">
							</colgroup>
							<tbody id="reservationInfo">
							</tbody>
							</table>
						</div>
					</div>
					
					<div id="free_div" style="display:none;">
						<div data-role="collapsible" data-iconpos="right" class="mgT10" data-collapsed="false">
							<h1 class="ui-nodisc-icon ui-alt-icon">자유여행 예약내역</h1>
							<div class="listContent" style="width:100%">
								<ul data-role="listView" id="freeReserve" class="free_myt_box">
								</ul>
							</div>
						</div>
					</div>

					<div id="topass_div" style="display:none;">
						<div data-role="collapsible" data-iconpos="right" class="mgT10" data-collapsed="false">
							<h1 class="ui-nodisc-icon ui-alt-icon">항공 예약내역</h1>
							<div class="listContent" style="width:100%">
								<ul data-role="listView" id="topassAirReserve" class="free_myt_box">
								</ul>
							</div>
						</div>
					</div>
				</div><!--#tab1 End-->
			</div>
			<div class="contentBox pd1EM bdBox bgf6f6f8 lglist1">
				<ul>
					<li>여행상품 결제문의 02)3782-3000</li>
					<li>비회원의 예약 내역은 예약 확인 시 입력하신 예약번호에 해당하는 상품 1건에 한하여 조회됩니다.</li>
					<li>예약을 취소하고자 하실 경우에는 고객감동센터로 문의 주시길 바랍니다.상담전화 <em>1577-6511</em></li>
				</ul>
			</div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div><!--//contentWrap End-->
</body>