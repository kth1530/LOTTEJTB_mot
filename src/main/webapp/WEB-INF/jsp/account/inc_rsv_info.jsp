<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
	$(document).ready(function(){
		var reqReserveInfo;
		
		//임직원 관련
		var custchk = sessionStorage.custChk;
		var basketData = JSON.parse(sessionStorage.hotelBasketData);
		var countrychk = JSON.parse(sessionStorage.hotelViewData);
		var ijw = sessionStorage.ijw;
		var ijwk = sessionStorage.ijwk;
		
		for(var i=0; i < basketData.length; i++) {
			if(custchk == "그룹직원"){
				if(basketData[i].countryCd == 'KR' || countrychk.countryCode == 'KR'){
					var ijwPay = Math.floor(Math.ceil(basketData[i].setRoomData[0].rateInfos[0].bfTotal) * (ijwk * 0.01));
				} else {
					var ijwPay = Math.floor(Math.ceil(basketData[i].setRoomData[0].rateInfos[0].bfTotal) * (ijw * 0.01));
				}
			} else {
				var ijwpay = "";
			}
		}
		/*
		$("#payment_air").text(comma('${rsvResult.getSaleAmtAir()}'));
		$("#payment_hotel").text(comma('${rsvResult.getSaleAmtHtl()}'));
		$("#payment_rentcar").text(comma('${rsvResult.getSaleAmtRnt()}'));
		
		var total = parseInt('${rsvResult.getSaleAmtAir()}') 
				   	+ parseInt('${rsvResult.getSaleAmtHtl()}')
				   	+ parseInt('${rsvResult.getSaleAmtRnt()}');
		*/
		
		rsvMstUserInfo.selectT(function(tx, results){
	 		if(results.rows.length > 0){
	 			var telNo = convertTel(results.rows.item(0).resPhoneNum);
	 			
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
    	        	'rntDiscntAmt'	: results.rows.item(0).rntDiscntAmt
	        	}
	 		};
	 		
	 		if(nullToBlank(reqReserveInfo) != ''){
	 			$("#payment_total").text(comma(reqReserveInfo.saleAmtHtl)); 				 			
	 		}
	 			
	 	}, jSessionID);
		
		/*
		if('${rsvResult.getPayMtDt()}' != ".."){
			$("#limitedTime").text('${rsvResult.getPayMtDt()} ${rsvResult.getPayMtHm()}');
		}
		*/
	});
</script>

<!-- 예약상품정보 -->
<!--
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
		<td>${rsvResult.getFitRsvNo()}</td>
	</tr>
	 
	<tr>
		<th>결제마감시한</th>
		<td id="limitedTime"></td>
	</tr>
	
</table>
 -->
<!-- 결제정보 -->
<p class="obj_title2 obj_bg_wht mt7">
	<span class="ico_paym">결제 정보</span>
</p>
<table class="ft_table2 ft_th_tl ft_tb_tr">
	<colgroup>
		<col style="width: 30%" />
		<col style="width: 70%" />
	</colgroup>
	<tbody>
		<!-- 
		<tr>
			<th>항공</th>
			<td><span id="payment_air" name="payment_air"></span>원</td>
		</tr>
		<tr>
			<th>호텔</th>
			<td><span id="payment_hotel" name="payment_hotel"></span>원</td>
		</tr>
		<tr>
			<th>렌터카</th>
			<td><span id="payment_rentcar" name="payment_rentcar"></span>원</td>
		</tr>
		 -->
		<tr class="tb_purple">
			<th>상품가</th>
			<td><span id="payment_total" name="payment_total">0</span>원</td>
		</tr>
	</tbody>
</table>