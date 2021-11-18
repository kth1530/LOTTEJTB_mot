<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>

<head>
<script src="/resources/common/js/fit/air_search.js"></script>
<script src="/resources/common/js/fit/paging.js"></script>
<script src="/resources/common/js/fit/common.js"></script>	
<script src="/resources/common/js/fit/reserve.js"></script>
<script src="/resources/common/js/database.js"></script>

<script type="text/javascript">
	var jSessionID = '<%=request.getSession().getId()%>';
	var concMix;
	var pkgPrice = 0;  //패키지 할인가
	var pkgSavingsAmount;
	var suplrCd = '';
	var promAmt;
	// 초기화
	var fn_init = function() {
		rsvMstUserInfo.createT();
		
		var selAirDataset;
		var selHtlDataset = [];
		var concMixAir = "X";
		var concMixHtl = "X";
		var concMixRnt = "X";
		
		if(nullToBlank(sessionStorage.airSelData) == "" || sessionStorage.airSelData == "[]") {
			sessionStorage.airSelData = JSON.stringify([]); 
			$("#air_reserve_div").hide(); // 비활성화
		} else {
			concMixAir = "A";
			
			airDataset = JSON.parse(sessionStorage.airSelData);
			
			selAirDataset = {
				'carrierCd' 	: airDataset[0].carrierCd,
				'cabin'			: airDataset[0].cabinClas,
				'gdsTyGb'		: airDataset[0].gdsCd,
				'coalCardGb'	: '',
				'amt'			: airDataset[0].totCharge
			}
			
			$("#air_reserve_div").show(); // 활성화 	
			db_init_air_reserv();
		}

		// 호텔 정보 확인 
		if(nullToBlank(sessionStorage.hotelBasketData) == "" || sessionStorage.hotelBasketData == "[]") {
			sessionStorage.hotelBasketData = JSON.stringify([]);
			$("#hotel_reserve_div").hide(); //  비활성화 	
			$("#pkg_toFare").hide();
		} else {
			concMixHtl = "H"
			
			htlDataList = JSON.parse(sessionStorage.hotelBasketData)
				
			for(var i = 0; i < htlDataList.length; i++){
				var nightDay = htlDataList[i].htlInfo.day.split("박");
				var exchangeRate = htlDataList[i].exchangeRate;
				var subchargeTotal = parseInt(exchangeRate * htlDataList[i].setRoomData[0].rateInfos[0].surchargeTotal);
				var salesTax = parseInt(exchangeRate * htlDataList[i].setRoomData[0].rateInfos[0].salesTax);
				var jtbTotal = htlDataList[i].setRoomData[0].rateInfos[0].jtbTotal;
				var roomCnt = htlDataList[i].htlInfo.stayinfo.roomcnt;
				//var htlPrice = (parseInt(jtbTotal) * parseInt(nightDay[0]) * parseInt(roomCnt)) + parseInt(subchargeTotal);  //호텔료
				var htlPrice = (parseInt(jtbTotal) * parseInt(roomCnt)) + parseInt(subchargeTotal);  //호텔료
				
				var tempHtlDataset = {
					'targetId'		: 'htl_'+ i,
					'suplrId' 		: htlDataList[i].suplrCd,
					'htlNationCd' 	: htlDataList[i].countryCd,
					'htlCityCd' 	: htlDataList[i].cityCd,
					'htlCd' 		: htlDataList[i].hotelId,
					'coalCardGb'	: '',
					'amt' 			: htlPrice
				}
				
				selHtlDataset.push(tempHtlDataset);
				
				suplrCd = htlDataList[i].suplrCd; 
				//익스피디어 
				if(suplrCd == 'EAN') {
					pkgSavingsAmount = htlDataList[i].setRoomData[0].rateInfos[0].pkgSavingsAmount;
					if(nullToBlank(pkgSavingsAmount) != '') {
						$("#pkg_toFare").show();
						pkgPrice += Math.ceil(parseFloat(pkgSavingsAmount));
						$('#pkg_discnt').text(comma(pkgPrice) + "원");
						
					}
					
				}
				
			}
			$("#hotel_reserve_div").show(); // 활성화 	
			
		}
		
		// 렌트카 정보 확인 
		if(nullToBlank(sessionStorage.rentcarSelData) == "" || sessionStorage.rentcarSelData == "[]") {
			sessionStorage.rentcarSelData = JSON.stringify([]); 
			$("#rentcar_reserve_div").hide(); //  비활성화 			
		} else {
			concMixRnt = "C"
			$("#rentcar_reserve_div").show(); // 활성화 	
		}
		
		
		concMix = concMixAir + concMixHtl + concMixRnt;
		
		var promParam = {
			'promMst'	: {
				'concMix' : concMix,
			},
			'promAir'	: selAirDataset,
			'promHtl'	: selHtlDataset 
		}
		
		fn_promSetting(promParam);
	};
	
	function fn_promSetting(param){
		var formData = new FormData();
		formData.append('PromotionParamVO', param);
		
		gfn_callAjax ('/promo/selectPromoAmt.do', param, 'successProm');
	}
	
	function successProm(data){
		setTimeout(function(){
			var list = data.list;
			var mstMaxSale = 0;
			var mstMaxIndex;
			var airSaleTot = 0;
			var htlSaleTot = 0;
			var ijw = list.ijwProm[0].ijw;
			var ijwk = list.ijwProm[0].ijwk;
			var ijwInfo = $('[ft-att="custInfo"]');
			
			custChk = ijwInfo.find('[name="custChk"]').val();
			
			var countrychk = JSON.parse(sessionStorage.hotelViewData);
			var htlDataInfo = JSON.parse(sessionStorage.hotelBasketData);
			for(var i=0; i < htlDataInfo.length; i++) {
				var ijwTotal = htlDataInfo[i].setRoomData[0].rateInfos[0].bfTotal;
				var ijwChk = htlDataInfo[i].setRoomData[0].custChk;
				var ijwPay = 0;
				if(custChk == '그룹직원'){
					if(htlDataInfo[0].countryCd == 'KR' || countrychk.countryCode == 'KR'){
						var ijwPay = Math.floor(Math.ceil(ijwTotal) * (ijwk * 0.01));
					} else {
						var ijwPay = Math.floor(Math.ceil(ijwTotal) * (ijw * 0.01));
					}
					promAmt = ijwPay;
				} else {
					promAmt = Math.ceil(htlDataInfo[i].setRoomData[0].rateInfos[0].jtbTotal - htlDataInfo[i].setRoomData[0].rateInfos[0].promInfo.aplPromTotal);
				}
			}
			for(var a = 0; a < list.airProm.length; a++){
				if(nullToBlank(list.airProm[a]) != ""){
					airSaleTot += parseInt(list.airProm[a].saleAmt);
				}
			}
			
			for(var h = 0; h < list.htlProm.length; h++){
				if(nullToBlank(list.htlProm[h]) != ""){
					htlSaleTot += parseInt(list.htlProm[h].saleAmt);
				}
			}
			sessionStorage.setItem("ijw", ijw);
			sessionStorage.setItem("ijwk", ijwk);
			sessionStorage.setItem("custChk", custChk);
			
			setTimeout(function(){
				var otherSaleTot = parseInt(airSaleTot) + parseInt(htlSaleTot);
				
				for(var m = 0; m < list.mstProm.length; m++){
					if(nullToBlank(list.mstProm[m]) != ""){
						var thisSale = 0;
						
						if(list.mstProm[m].saleDivi == 'R'){
							thisSale = (parseInt($("#payment_totFare").data('amt')) - parseInt(otherSaleTot)) * list.mstProm[m].saleAmt;
						}else{
							thisSale = list.mstProm[m].saleAmt
						}
						
						if(mstMaxSale < thisSale){
							mstMaxSale = thisSale;
							mstMaxIndex = m;
						}
					}
				}
				
				var vHTML = "";
				
				mstMaxSale = Math.floor(mstMaxSale);
				
				if(airSaleTot != 0){
					vHTML += '<p class="ppred" id="airPromArea">';
					vHTML += '	항공 프로모션 <span>-'+ comma(airSaleTot) +'원</span>';
					vHTML += '	<input type="hidden" class="sub_amt promo_amt_class" data-sign="-" value="'+ airSaleTot +'" />';
					vHTML += '</p>';
				}
				
				if(htlSaleTot != 0 && custChk != '그룹직원'){
					vHTML += '<p class="ppred" id="htlPromArea">';
					vHTML += '	호텔 프로모션 <span>'+ comma(htlSaleTot) +'원</span>';
					vHTML += '	<input type="hidden" class="sub_amt promo_amt_class" data-sign="-" value="'+ htlSaleTot +'" />';
					vHTML += '</p>';
				}
				
				if(mstMaxSale != 0){
					vHTML += '<p class="ppred" id="mstPromArea" data-conc="'+ list.mstProm[mstMaxIndex].concMix +'">';
					vHTML += '	'+ list.mstProm[mstMaxIndex].promNm +'<span>-'+ comma(mstMaxSale) +'원</span>';
					vHTML += '	<input type="hidden" class="sub_amt promo_amt_class" data-sign="-" value="'+ mstMaxSale +'" />';
					vHTML += '	<input type="hidden" id="promId" value="'+ list.mstProm[mstMaxIndex].promId +'" />';
					vHTML += '	<input type="hidden" id="promAmount" value="'+ list.mstProm[mstMaxIndex].saleAmt +'" />';
					vHTML += '	<input type="hidden" id="promDivi" value="'+ list.mstProm[mstMaxIndex].saleDivi +'" />';
					vHTML += '	<input type="hidden" id="promName" value="'+ list.mstProm[mstMaxIndex].promNm +'" />';
					vHTML += '</p>';
				}
				
				$("#promo_fee").html(vHTML);
				
				$(".sub_amt").change();
			}, 50);
			if(custChk == "그룹직원"){
			     if (self.name != 'reload') {
			         self.name = 'reload';
			         self.location.reload(true);
			     }
			     else self.name = '';	
			}
		}, 100);
	}
	
	function getWeeks(col) {
		var dayName=new Array("일", "월", "화", "수", "목", "금", "토"); // 숫자 요일을 문자 요일 바꿀 함수		
		return dayName[col];
	}

	function db_init_air_reserv() {
		// 항공 예약 관련 테이블 생성 

		// ---------------------------------------------------------------------------------------------------------------------------------------------
		// 항공예약 > 항공 예약 처리 API > BodyDTO 정보 
		// ---------------------------------------------------------------------------------------------------------------------------------------------
		
		rsvAirBodyDtoT.createT();

		// ---------------------------------------------------------------------------------------------------------------------------------------------
		// 항공예약 > 항공 예약 처리 API > SegmentGroup 정보 
		// ---------------------------------------------------------------------------------------------------------------------------------------------
		
		rsvAirSegmentGroupT.createT();

		// ---------------------------------------------------------------------------------------------------------------------------------------------
		// 항공예약 > 항공 예약 처리 API > paxGroup 정보 
		// ---------------------------------------------------------------------------------------------------------------------------------------------
		
		rsvAirPaxGroupT.createT();

		// ---------------------------------------------------------------------------------------------------------------------------------------------
		// 항공예약 > 항공 예약 처리 API > fareDataBean 정보 
		// ---------------------------------------------------------------------------------------------------------------------------------------------
		
		rsvAirFareDataBeanT.createT();

	}
	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};
	
	var insertSuccFunc = function(){
		var promAmount = 0;
		var promRate = 0;
		
		if($("#promDivi").val() == 'R'){
			promRate = $("#promAmount").val();
		}else{
			promAmount = $("#promAmount").val();
		}
		
		var promotionInfo = {
			'promId'		: $("#promId").val(),
			'promAmount'	: promAmount,
			'promRate'		: promRate,
			'promName'		: $("#promName").val()
		}
		
		sessionStorage.promotionInfo = JSON.stringify(promotionInfo);

		fn_goReserveStep2();
	}
	
	var fn_reserveSave = function(){
		var amtList = JSON.parse(sessionStorage.mstAmtList);
		rsvMstUserInfo.insertT(insertSuccFunc, jSessionID, "", "", "", "", "", "", "", concMix, amtList.mstAmtTot, amtList.airAmtTot, amtList.htlAmtTot, amtList.rntAmtTot, amtList.airPromAmtTot, amtList.htlPromAmtTot, amtList.rntPromAmtTot);
	}	
	
	
	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();
		
		$(".sub_amt").change(function(){
			var totAmt = 0;
			
			$(".sub_amt").each(function(){
				if($(this).data("sign") == "+"){
					totAmt += parseInt($(this).val());	
				}else{
					totAmt -= parseInt($(this).val());
				}
			});
			
			//패키지 할인금액이 있는 경우는 전체 상품가 표시
			if(concMix != 'XHX' && suplrCd == 'EAN') {
				if(nullToBlank(pkgSavingsAmount) != '') {
					//전체 상품가
					$('#total_totFare').show();
					$('#total_price').html(comma(totAmt)+"원");
				}
				
			} else {
				$('#total_totFare').hide();
				$('#pkg_toFare').hide();
			}
			
			totAmt  = totAmt - pkgPrice;  //패키지 할인가 ean
			
			$("#payment_totFare").html(comma(totAmt)+"원");
			$("#payment_totFare").attr('data-amt', totAmt);
		});

		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});
</script>
</head>
<body>

	<form name="f_frm" id="f_frm" method="post">
		<input type="hidden" name="selAir" id="selAir"  value="${selAir}" />
		<input type="hidden" name="selHotel" id="selHotel" value="${selHotel}" />
		<input type="hidden" name="selRentcar" id="selRentcar" value="${selRentcar}" />
	</form>	
	<div ft-att="custInfo" style="display:none;">
		<input type="hidden" name="custChk" value="${custChk}" />
	</div>	
	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="navstitle freeback">
			예약정보<a href="javascript:history.back(-1);">뒤로</a>
		</div>
		<div class="free_reserve collapse fr_step1">
			<!-- 항공 -->
			<div id="air_reserve_div" name="air_reserve_div" ft-att="air_reserve">
				<%@include file="/WEB-INF/jsp/free_reserve/inc_reserve_air.jsp"%>
			</div>
			<!-- 호텔 -->
			<div id="hotel_reserve_div" name="hotel_reserve_div">
				<%@include file="/WEB-INF/jsp/free_reserve/inc_reserve_hotels.jsp"%>
			</div>
			<!-- 렌터카 -->
			<div id="rentcar_reserve_div" name="rentcar_reserve_div">
				<%@include file="/WEB-INF/jsp/free_reserve/inc_reserve_rentcars.jsp"%>
			</div>
			<!-- 결제 -->
			<div id="payment_reserve_div" name="payment_reserve_div" ft-att="payment_reserve">
				<dl class="pop_chk_list pop_chk_list2">
					<dt class="pop_avtitle2">결제금액확인</dt>
					<dd class="pop_paytext1">
						<p>
							항공 <span id="air_totFare" name="air_totFare">0원</span>
							<input type="hidden" class="sub_amt" id="air_amt" data-sign="+" value="0" />
						</p>
						<p>
							호텔 <span id="hotel_totFare" name="hotel_totFare"> 0원</span>
							<input type="hidden" class="sub_amt" id="hotel_amt" data-sign="+" value="0" />
						</p>
						<p>
							렌터카(후불) <span id="rentcar_totFare" name="rentcar_totFare">0원</span>
							<input type="hidden" class="sub_amt" id="rentcar_amt" data-sign="+" value="0" />
						</p>
						<p id="total_totFare" name="total_totFare" style="display:none">
							전체 상품가 <span id="total_price" name="total_price">0원</span>
							<input type="hidden" class="sub_amt" id="total_amt" data-sign="+" value="0" />
						</p>
						<p id="pkg_toFare" style="display:none">
							패키지 할인가 <span id="pkg_discnt" name="pkg_discnt">0원</span>
							<input type="hidden" class="sub_amt" id="pkg_amt" data-sign="-" value="0" />
						</p>
						<p id="prom_toFare" style="display:none" class="ppred">
							프로모션 할인가 <span id="pro_discnt" name="pro_discnt">0원</span>
							<input type="hidden" class="sub_amt" id="pro_amt" data-sign="-" value="0" />
						</p>
						<p id="ijw_toFare" style="display:none" class="ppred">
							롯데임직원 할인가 <span id="ijw_discnt" name="ijw_discnt">0원</span>
							<input type="hidden" class="sub_amt" id="ijw_amt" data-sign="-" value="0" />
						</p>						
						<div id="promo_fee">
						</div>
					</dd>
				</dl>
				<p class="pop_avtitle3" id='pay_totFare' name='pay_totFare'>
					총 결제예정금액 <span id="payment_totFare" name="payment_totFare" data-amt='0'>0원</span>
				</p>
				<div class="pop_bt_text1 pop_bt_text2">
					<ul class="dotlist3">
						<li>항공 : 유류할증료&제세공과금 포함</li>
						<li>호텔 : TAX, 봉사료 포함</li>
						<li>렌터카 : 추가사항 포함</li>
					</ul>
				</div>
			</div>
			<!-- 버튼 -->
			<div class="btn_one air_tbtn">
				<button class="purple2" data-role="none"  onClick="fn_reserveSave();">다음</button>
			</div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//content-->