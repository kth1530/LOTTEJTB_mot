<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	
<script type="text/javascript">
	
	/*
	var fn_init = function() {
	};
	*/
	
	var fn_initButton = function() {
	};
	
	//선택 호텔 정보
 	function fn_rsvHotelInfo() {
		
	 	/**** roomtype 에 따른 정보는 수정 해야 한다.*///	
	 
 		var basketData = JSON.parse(sessionStorage.hotelBasketData);
		
		console.log(">>>basketData.length=" + basketData.length);
		
		if(basketData == undefined || basketData == null || basketData == '[]') {}
		else {
		
			var htlPriceTemp = 0;
			var vHtml = '';
			var ageofChd = '';
			
			if(basketData.length > 0) {
				var total = 0 ;
				var promTotal = 0 ;
				var ijwPromTotal = 0 ;
				for(var i=0; i < basketData.length; i++) {
					
					//임직원 관련
					var ijw = sessionStorage.ijw;
					var ijwk = sessionStorage.ijwk;
					var custchk = sessionStorage.custChk;
					var countrychk = JSON.parse(sessionStorage.hotelViewData);
					var cancelPolicy='';
					var htlPrice = 0;
					var htlPrices = 0;
					if(custchk == "그룹직원"){
						total += Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].bfTotal));
						htlPrices = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].bfTotal));
						if(basketData[i].countryCd == 'KR' || countrychk.countryCode == 'KR'){
							var ijwProm = Math.floor(Math.ceil(basketData[i].setRoomData[0].rateInfos[0].bfTotal) * (ijwk * 0.01));
							ijwPromTotal += ijwProm;
						} else {
							var ijwProm = Math.floor(Math.ceil(basketData[i].setRoomData[0].rateInfos[0].bfTotal) * (ijw * 0.01));
							ijwPromTotal += ijwProm;
						}
					} else {
						total += Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].jtbTotal));
						htlPrices = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].jtbTotal));
						var ijwProm = "";
					}					
					var roomType = basketData[i].setRoomData[0].roomTypeDesc.split(','); //roomType
					var exchangeRate = parseFloat(basketData[i].exchangeRate);
					var nightDay = basketData[i].htlInfo.day.split("박");
					var subchargeTotal = Math.ceil(exchangeRate * parseFloat(basketData[i].setRoomData[0].rateInfos[0].surchargeTotal));
					var roomCnt = basketData[i].htlInfo.stayinfo.roomcnt;
					var day = '';
					
					

					
					if(basketData[i].htlInfo.day.indexOf('박') > 0) day = basketData[i].htlInfo.day;
					else
						day = basketData[i].htlInfo.day + '박';
					
					var salesTax = basketData[i].setRoomData[0].rateInfos[0].salesTax;
					var salesTaxT = 0;
					
					if(salesTax == "" || salesTax == '0') salesTaxT = 0;  
					else salesTaxT = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].salesTax));
					
					if(basketData[i].setRoomData[0].rateInfos[0].jtbTotal != '') {
						//if(basketData[i].suplrCd == 'WHC') { //호텔패스인 경우만 호텔패스 환율적용해야 한다.
						//	htlPrice = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].jtbTotal));
						//} else {
							
							var promInfoData = basketData[i].setRoomData[0].rateInfos[0].promInfo;
							console.log(promInfoData);
						
							if(promInfoData != null && nullToBlank(promInfoData.aplPromTotal) != '' && custchk != "그룹직원") {
								if(promInfoData.aplPromTotal > 0 && custchk != "그룹직원") {
									//프로모션 적용가
									htlPrice = Math.ceil(parseFloat(promInfoData.aplPromTotal));
									promTotal += (htlPrices-htlPrice);
									$("#prom_toFare").show();
									$('#pro_discnt').text(comma(promTotal) + "원");
								}else {
									htlPrice = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].jtbTotal));
								}
							} else if(custchk == "그룹직원") {	
								htlPrice = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].bfTotal));
								$("#prom_toFare").hide();
								$("#ijw_toFare").show();
								$('#ijw_discnt').text(comma(ijwPromTotal) + "원");
							} else {	
								htlPrice = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].jtbTotal));
							}
						//}
					}
					
					var cancelJtbDl = basketData[i].setRoomData[0].rateInfos[0].cancelJtbDl;
					//var jtbCancelDt = basketData[i].setRoomData[0].rateInfos[0].jtbCancelDt;
				   //	var jtbCancelTm = basketData[i].setRoomData[0].rateInfos[0].jtbCancelTm;
					
					//아동수
					var ageofChdCnt = basketData[i].htlInfo.stayinfo.roomCont.length;
					for(var j=0; j < ageofChdCnt; j++) {
					
						if(ageofChd == '') 
							ageofChd = basketData[i].htlInfo.stayinfo.roomCont[j].ageOfChd;
						else
							ageofChd += ',' + basketData[i].htlInfo.stayinfo.roomCont[j].ageOfChd;
						
					}
					
					var age='';
					if(ageofChd != '') {
						var ageofChrArr =  ageofChd.split(',');
						for(var k=0; k < ageofChrArr.length; k++) {
							if(ageofChrArr.length == 1)
								age = ageofChrArr[k];
							else if(k == ageofChrArr.length - 1)
								age += ageofChrArr[k] + "살";
							else
								age += ageofChrArr[k] + "살,";
											
						}
						age = " " + "(" +  age + ")";
					}
					
					if(salesTaxT == 0) salesTax ="";
					else salesTax = "(Sales Tax" + " " + comma(salesTaxT) + "원 포함 )";
					
					//조식 포함 여부
					var roomIsBreakfast = basketData[i].setRoomData[0].isBreakFast;
					if(roomIsBreakfast == 'Y')
						roomIsBreakfast = ' / 조식 포함';
					else
						roomIsBreakfast = ' / 조식 불포함';
					
					if(cancelJtbDl =='환불불가')  cancelPolicy = '환불불가';
					else
					   cancelPolicy = cancelJtbDl; //jtbCancelDt +  "   " + jtbCancelTm + " 까지 무료 취소";
					//호텔운임료
					
					var adultnumber = basketData[i].htlInfo.stayinfo.adultnumber;
					var childnumber = basketData[i].htlInfo.stayinfo.childnumber;
									
					var htlInfo = "객실" + roomCnt + " / 성인" + adultnumber + "명, 아동"  +  childnumber + "명" + age;
					
					//통화코드
					var currcencyCd = basketData[i].setRoomData[0].rateInfos[0].currencyCode;
					
					if(nullToBlank(sessionStorage.hotelSelList) != '') {
						var hotelList = JSON.parse(sessionStorage.hotelSelList);
						var hotelfee = hotelList.hotelfee;
						if(nullToBlank(hotelfee) == '') hotelfee = '0.0';
					}
					
					vHtml += "	<dt>호텔" + (i+1) + ""
					vHtml += "	</dt>"
					vHtml += "	<dd>"
					vHtml += "  	<table class='ft_table2 ft_tb_tl'>"
					vHtml += "  		<thead>"
					vHtml += "  			<tr>"
					vHtml += "  				<th colspan='2'>" + basketData[i].htlName + "</th>"
					vHtml += "  			</tr>"
					vHtml += " 		 </thead>"
					vHtml += "  	 <tbody>"
					vHtml += "  		 <tr>"
					vHtml += "        		<th>투숙기간</th>"
					vHtml += "				<td>" +  basketData[i].htlInfo.checkinDate + "(" + basketData[i].htlInfo.checkinDay + ") ~ " +  basketData[i].htlInfo.checkoutDate + "(" + basketData[i].htlInfo.checkoutDay + ")"  + " " + day + "</td>"
					vHtml += "      	</tr>"
					vHtml += " 			<tr>"
					vHtml += "     			<th>객실</th>"
					vHtml += "				<td>"
					vHtml += "        			<p class='rbtn'>즉시확정</p>"
					vHtml += "					<p>" + roomType[0] + "   " + roomIsBreakfast + "</p>"
					vHtml += "					<p>" + htlInfo + "</p>"
					vHtml += "				</td>"
					vHtml += "			</tr>"
					vHtml += " 			<tr>"
					vHtml += "				<th>취소규정</th>"
					vHtml += " 				<td class='f_purple'>" + cancelPolicy +"</td>"
					vHtml += "			</tr>"
					
					if(basketData[i].setRoomData[0].suplrCd == "EAN") {	
						vHtml += " 			<tr>"
						vHtml += "				<th>세금 및 수수료</th>"
						vHtml += " 				<td class='tr'><span class='f_purple'>" + setPriceInput(subchargeTotal) + "원 " + salesTax + "</span></td>"
						vHtml += "			</tr>"
					}
					if(basketData[i].setRoomData[0].suplrCd == "EAN") {
						vHtml += " 			<tr>"
						vHtml += "				<th>현지 지불 TAX</th>"
						vHtml += " 				<td class='tr'><span class='f_purple'>" + hotelfee + " " + currcencyCd + "</span></td>"
						vHtml += "			</tr>"
					}
					if(promInfoData.aplPromTotal > 0 && custchk != "그룹직원"){
							vHtml += "			<tr>"
							vHtml += "				<th>총 숙박료(TAX, 봉사료 포함)</th>"
							vHtml += "				<td class='tr'><span class='f_purple'>" + setPriceInput(htlPrices) + "</span> 원</td>"
							vHtml += "			</tr>"

							vHtml += "			<tr>"
							vHtml += "				<th>자유여행 프로모션</th>"
							vHtml += "				<td class='tr'><span class='f_red'>" + setPriceInput(htlPrices-htlPrice) + "</span> 원</td>"
							vHtml += "			</tr>"
							$("#pro_amt").val(promTotal);	
					}	
					if(custchk == "그룹직원") {
							vHtml += "			<tr>"
							vHtml += "				<th>롯데임직원 할인가</th>"
							vHtml += "				<td class='tr'><span class='f_red'>" + setPriceInput(ijwProm) + "</span> 원</td>"
							vHtml += "			</tr>"
							$("#ijw_amt").val(ijwPromTotal);
					}
					
					vHtml += "			<tr>"
					vHtml += "				<th>호텔 총 요금</th>"
					vHtml += "				<td class='tr'><span class='f_purple'>" + setPriceInput(htlPrice) + "</span> 원</td>"
					vHtml += "			</tr>"
					vHtml += "	 	 </tbody>"
					vHtml += "	  </table>"
					vHtml += "	</dd>"
					
					$('#sel_hotel_info').html(vHtml);
					htlPriceTemp += parseInt(htlPrice); 
					console.log(">>>>>htlPriceTemp=" + parseInt(htlPriceTemp));
					//총 호텔 운임
// 					$("#hotel_totFare").text(setPriceInput(htlPriceTemp) + "원");
// 					$("#hotel_amt").val(htlPriceTemp);
					$("#hotel_totFare").text(setPriceInput(total) + "원");
					$("#hotel_amt").val(total);
					$('.sub_amt').change();
				}
			}
		}
	}

	$(document).ready(function() {
		//fn_init();
		fn_initButton();
		fn_rsvHotelInfo();
		
	});


</script>

<p class="pop_htvtitle mt7">호텔</p>
<dl class="pop_info_list" id="sel_hotel_info" name="sel_hotel_info">
	
</dl>
<p class="txbox4">(TAX, 봉사료 포함)</p>
<ul class="txbox2">
	<li>예약 후 호텔변경, 박수변경, 일정변경 불가하며 변경을 원하실 경우 취소 후 재 예약 하셔야 합니다.</li>
</ul>
<!-- <p class="pop_htvtitle mt7">호텔</p>
<dl class="pop_info_list">
	<dt>호텔1</dt>
	<dd>
		<table class="ft_table2 ft_tb_tl">
			<thead>
				<tr>
					<th colspan="2">방콕 샹그릴라 호텔</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>투숙기간</th>
					<td>2016.11.07(월) ~ 2016.11.09(수) 2박</td>
				</tr>
				<tr>
					<th>객실</th>
					<td>
						<p class="purple2">바로확정</p>
						<p>Deluxe Room 조식포함</p>
						<p>객실 2 / 성인 3명, 아동 2명, 유아 0명</p>
					</td>
				</tr>
				<tr>
					<th>합계</th>
					<td class="f_purple">2016.11.01 16:00까지 무료</td>
				</tr>
				<tr>
					<th>총 운임</th>
					<td class="tr"><span class="f_purple">764,400</span> 원</td>
				</tr>
			</tbody>
		</table>
	</dd>
</dl>
<dl class="pop_info_list">
	<dt>호텔2</dt>
	<dd>
		<table class="ft_table2 ft_tb_tl">
			<thead>
				<tr>
					<th colspan="2">방콕 샹그릴라 호텔</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>투숙기간</th>
					<td>2016.11.07(월) ~ 2016.11.09(수) 2박</td>
				</tr>
				<tr>
					<th>객실</th>
					<td>
						<p class="purple2">바로확정</p>
						<p>Deluxe Room 조식포함</p>
						<p>객실 2 / 성인 3명, 아동 2명, 유아 0명</p>
					</td>
				</tr>
				<tr>
					<th>합계</th>
					<td class="f_purple">2016.11.01 16:00까지 무료</td>
				</tr>
				<tr>
					<th>총 운임</th>
					<td class="tr"><span class="f_purple">764,400</span> 원</td>
				</tr>
			</tbody>
		</table>
	</dd>
</dl>
<p class="txbox4">(TAX, 봉사료 포함)</p>
<ul class="txbox2">
	<li>예약 후 호텔변경, 박수변경, 일정변경 불가하며 변경을 원하실 경우 취소 후 재 예약 하셔야 합니다. .</li>
</ul> -->