
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_rentcar_ifdetail.jsp
	// 설명 : 렌트카 검색 상세조건
%>

<link rel="stylesheet" href="/resources/common/css/normalize.css" />
<link rel="stylesheet" href="/resources/common/css/ion.rangeSlider.css" />
<link rel="stylesheet"
	href="/resources/common/css/ion.rangeSlider.skinFlat.css" />
<script src="/resources/common/js/ion.rangeSlider.js"></script>

<script type="text/javascript">
	var carSizeNm = ['경차(mini)', '소형차(subcompact)', '소형차(economy)', '준중형차(compact)', '중형차(midsize)', '중형차(intermediate)', '중형차(standard)'
	                 , '준대형차(fullsize)', '고급차(luxury)', '대형차(premium)', '특수차(special)', '경차(minielite)', '소형차(economy elite)', '준중형차(compact elite)', '중형차(intermediate elite)'
	                 , '중형차(standard elite)', '대형차(premium elite)', '대형차(premium elite)', '고급차(luxury elite)', 'oversize'];
	var carSizeFilter = {
		'경차(mini)' : 0,
		'소형차(subcompact)' : 0,
		'소형차(economy)' : 0,
		'준중형차(compact)' : 0,
		'중형차(midsize)' : 0,
		'중형차(intermediate)' : 0,
		'중형차(standard)' : 0,
		'준대형차(fullsize)' : 0,
		'고급차(luxury)' : 0,
		'대형차(premium)' : 0,
		'특수차(special)' : 0,
		'경차(minielite)' : 0,
		'소형차(economy elite)' : 0,
		'준중형차(compact elite)' : 0,
		'중형차(intermediate elite)' : 0,
		'중형차(standard elite)' : 0,
		'준대형차(fullsize elite)' : 0,
		'대형차(premium elite)' : 0,
		'고급차(luxury elite)' : 0,
		'oversize' : 0
	}
	var minPrice = 0;
	var maxPrice = 0;
	
	// 초기화
	var fn_init = function() {
		for(var i = 0; i < oriRentalCarList.length; i++){
			carSizeFilter[carSize[oriRentalCarList[i].carSize]]++;
			
			if(minPrice > (oriRentalCarList[i].estimatedTotalAmt * exchangeVal)){
				minPrice = Math.ceil((oriRentalCarList[i].estimatedTotalAmt * exchangeVal) / 10000) * 10000;
			}
			
			if(maxPrice < (oriRentalCarList[i].estimatedTotalAmt * exchangeVal)){
				maxPrice = Math.ceil((oriRentalCarList[i].estimatedTotalAmt * exchangeVal) / 10000) * 10000;
			}
		}

		var carSizeHTML = "<dt>차량종류</dt>";
		carSizeHTML += '<dd><p class="chkbox"><span><input id="chk_if1_1" class="carSize" type="checkbox" data-role="none" value="all"/></span><label for="chk_if1_1" style="margin-left:5px;">전체('+ oriRentalCarList.length +')</label></p></dd>';
		var carSizeIdx = 2;
		
		for(var j = 0; j < carSizeNm.length; j++){
			if(carSizeFilter[carSizeNm[j]] != 0){
				carSizeHTML += '<dd><p class="chkbox"><span><input id="chk_if1_'+ carSizeIdx +'" class="carSize carSizeSub" type="checkbox" data-role="none" value="'+ carSizeNm[j] +'"/></span><label for="chk_if1_'+ carSizeIdx +'" style="margin-left:5px;">'+ carSizeNm[j] +'('+ carSizeFilter[carSizeNm[j]] +')</label></p></dd>';
				carSizeIdx++;
			}
		}
		
		jQuery("#range").ionRangeSlider({
			type : "double",
			min : minPrice,
			max : maxPrice,
			from : minPrice,
			to : maxPrice,
			step : 10000,
			hide_min_max : true,
			hide_from_to : false,
			grid : false
		});
		
		$("#carSizeFilter").html(carSizeHTML);
		
		$(".carSize").click(function(){
			if($(this).val() == "all"){
				if($(this).is(":checked")){
					$(".carSize").prop("checked", true);
				}else{
					$(".carSize").prop("checked", false);
				}
			}else{
				if($(this).is(":checked")){
					var carSizeCheckYn = true;
					
					$(".carSizeSub").each(function(){
						if(!$(this).is(":checked")){
							carSizeCheckYn = false;
							return false;
						}
					});
					
					if(carSizeCheckYn){
						$("#chk_if1_1").prop("checked", true);
					}
					
				}else{
					$("#chk_if1_1").prop("checked", false);
				}
			}
		})
		
		$(".transmissionType").click(function(){
			if($(this).val() == "all"){
				if($(this).is(":checked")){
					$(".transmissionType").prop("checked", true);
				}else{
					$(".transmissionType").prop("checked", false);
				}
			}else{
				if($(this).is(":checked")){
					var transCheckYn = true;
					
					$(".transmissionTypeSub").each(function(){
						if(!$(this).is(":checked")){
							transCheckYn = false;
							return false;
						}
					});
					
					if(transCheckYn){
						$("#chk_if3_1").prop("checked", true);
					}
				}else{
					$("#chk_if3_1").prop("checked", false);	
				}
			}
		})
		
		if(nullToBlank(filterInfo) != ""){
			if(nullToBlank(filterInfo.carSizeVal) != ""){
				$(".carSize").each(function(){
					if(filterInfo.carSizeVal.indexOf(","+ $(this).val() +",") > -1){
						$(this).prop("checked", true);
					}
				})
			}
			
			if(filterInfo.limitYn){
				$("#chk_if2_2").prop("checked", true);
			}
			
			if(nullToBlank(filterInfo.transTypeVal) != ""){
				$(".transmissionType").each(function(){
					if(filterInfo.transTypeVal.indexOf(","+ $(this).val() +",") > -1){
						$(this).prop("checked", true);
					}
				})
			}
			
			var slider = $("#range").data("ionRangeSlider");
			slider && slider.update({
	            from: filterInfo.minPriceVal,
	            to: filterInfo.maxPriceVal
	        });				
		}
	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();
	});
	
	var fn_resetFilter = function(){
		var slider = $("#range").data("ionRangeSlider");
		//slider.reset();
		slider && slider.update({
            from: minPrice,
            to: maxPrice
        });
		
		$(".carSize").each(function(){
			$(this).prop("checked", false);
		})
		$(".transmissionType").each(function(){
			$(this).prop("checked", false);
		})
		
		$("#chk_if2_2").prop("checked", false);
	}
	
	var fn_applyFilter = function(){
		var slider = $("#range").data("ionRangeSlider");
		var carSizeVal = "";
		var limitYn = false;
		var transTypeVal = "";
		var minPriceVal = slider.result.from;
		var maxPriceVal = slider.result.to;
		
		$(".carSize").each(function(){
			if($(this).is(":checked")){
				carSizeVal += ","+ $(this).val();	
			}
		})
		
		if($("#chk_if2_2").is(":checked")){
			limitYn = true;
		}
		
		$(".transmissionType").each(function(){
			if($(this).is(":checked")){
				transTypeVal += ","+ $(this).val();
			}
		});
		
		carSizeVal += ",";
		transTypeVal += ",";
		
		rentalCarList = [];
		
		for(var i = 0; i < oriRentalCarList.length; i++){
			if(nullToBlank(carSizeVal) != "," && carSizeVal.indexOf("all") < 0){
				if(carSizeVal.indexOf("," + carSize[oriRentalCarList[i].carSize] + ",") > -1){
					if(limitYn){
						if(oriRentalCarList[i].unlimited == "true"){
							if(nullToBlank(transTypeVal) != "," && transTypeVal.indexOf("all") < 0){
								if(transTypeVal.indexOf(","+ oriRentalCarList[i].transType +",") > -1){
									if((oriRentalCarList[i].estimatedTotalAmt * exchangeVal).toFixed() >= minPriceVal && (oriRentalCarList[i].estimatedTotalAmt * exchangeVal).toFixed() <= maxPriceVal){
										rentalCarList.push(oriRentalCarList[i]);
									}
								}
							}else{
								if((oriRentalCarList[i].estimatedTotalAmt * exchangeVal).toFixed() >= minPriceVal && (oriRentalCarList[i].estimatedTotalAmt * exchangeVal).toFixed() <= maxPriceVal){
									rentalCarList.push(oriRentalCarList[i]);
								}
							}
						}
					}else{
						if(nullToBlank(transTypeVal) != "," && transTypeVal.indexOf("all") < 0){
							if(transTypeVal.indexOf(","+ oriRentalCarList[i].transType +",") > -1){
								if((oriRentalCarList[i].estimatedTotalAmt * exchangeVal).toFixed() >= minPriceVal && (oriRentalCarList[i].estimatedTotalAmt * exchangeVal).toFixed() <= maxPriceVal){
									rentalCarList.push(oriRentalCarList[i]);
								}
							}
						}else{
							if((oriRentalCarList[i].estimatedTotalAmt * exchangeVal).toFixed() >= minPriceVal && (oriRentalCarList[i].estimatedTotalAmt * exchangeVal).toFixed() <= maxPriceVal){
								rentalCarList.push(oriRentalCarList[i]);
							}
						}
					}
				}
			}else if(limitYn){
				if(oriRentalCarList[i].unlimited == "true"){
					if(nullToBlank(transTypeVal) != "," && transTypeVal.indexOf("all") < 0){
						if(transTypeVal.indexOf(","+ oriRentalCarList[i].transType +",") > -1){
							if((oriRentalCarList[i].estimatedTotalAmt * exchangeVal).toFixed() >= minPriceVal && (oriRentalCarList[i].estimatedTotalAmt * exchangeVal).toFixed() <= maxPriceVal){
								rentalCarList.push(oriRentalCarList[i]);
							}
						}
					}else{
						if((oriRentalCarList[i].estimatedTotalAmt * exchangeVal).toFixed() >= minPriceVal && (oriRentalCarList[i].estimatedTotalAmt * exchangeVal).toFixed() <= maxPriceVal){
							rentalCarList.push(oriRentalCarList[i]);
						}
					}
				}
			}else if(nullToBlank(transTypeVal) != "," && transTypeVal.indexOf("all") < 0){
				if(transTypeVal.indexOf(","+ oriRentalCarList[i].transType +",") > -1){
					if((oriRentalCarList[i].estimatedTotalAmt * exchangeVal).toFixed() >= minPriceVal && (oriRentalCarList[i].estimatedTotalAmt * exchangeVal).toFixed() <= maxPriceVal){
						rentalCarList.push(oriRentalCarList[i]);
					}
				}
			}else{
				if((oriRentalCarList[i].estimatedTotalAmt * exchangeVal).toFixed() >= minPriceVal && (oriRentalCarList[i].estimatedTotalAmt * exchangeVal).toFixed() <= maxPriceVal){
					rentalCarList.push(oriRentalCarList[i]);
				}
			}
		}
		
		var rentsort = $("#rentcar_sort").data('rentsort');
		
		if(rentsort == "A"){
			rentalCarList.sort(function(a, b){
				return a.estimatedTotalAmt - b.estimatedTotalAmt;
			});
		}else if(rentsort == "B"){
			rentalCarList.sort(function(a, b){
				return a.carSize - b.carSize;
			});
		}else if(rentsort == "C"){
			rentalCarList.sort(function(a, b){
				return a.carNm.charCodeAt(0) - b.carNm.charCodeAt(0);
			});
		}
		

		rentalCarCnt = rentalCarList.length; 
		var rentalCarLen = rentalCarCnt;
		
		if(rentalCarCnt > pageSize){
			rentalCarLen = pageSize;
			$("#rentalCarMore").show();
		}else{
			$("#rentalCarMore").hide();
		}
		
		$("#carCount").html("총 상품 "+ rentalCarLen +"개");
		var vHTML = "";		
		for(var i = 0 ; i < rentalCarLen; i++){
			vHTML += '<ul class="fr_carlist fr_carlist'+ i +'">';
			vHTML += '	<li>';
			vHTML += '		<p class="radioboxs radioboxs2"><input type="radio" name="radio" class="carRadio" id="radiot'+ i +'" data-num="'+ i +'" data-role="none"></p>';
			vHTML += '		<div class="frc_infobox">';
			vHTML += '			<p style="background:#fff url('+ rentalCarList[i].carImg +') center center no-repeat; background-size:110% auto"></p>';
			//vHTML += '			<p><img src="'+ rentalCarList[i].carImg +'" alt="" /></p>';
			vHTML += '			<ul class="car_info1">';
			if(rentalCarList[i].carNm.indexOf('OR SIMILAR') > -1){
				vHTML += '				<li class="car_infot1">OR SIMILAR</li>';
			}else{
				vHTML += '				<li class="car_infot1"></li>';
			}
			vHTML += '				<li class="car_infot2"><a href="#" class="ellipsis">'+ rentalCarList[i].carNm.replace('OR SIMILAR', '') +'</a></li>';
			vHTML += '				<li class="car_infot3">'+ carSize[rentalCarList[i].carSize] +'</li>';
			vHTML += '				<li class="car_infobtn">';
			vHTML += '					<button type="button" data-role="none">갼략내용</button>';
			vHTML += '					<button type="button" data-role="none">';
			vHTML += '						<a href="#" class="layerOpener" data-url="/pop/pop_rentcar_viewdetail.do" data-ok="yes" data-ctn="full" data-role="none" style="cursor=\'hand\';">상세보기</a>';
			//vHTML += '						<a href="#" onclick="moveLink(\'/pop/pop_rentcar_viewdetail.do?idx='+ i +'\', \'_system\')" class="ui-link">상세보기</a>';
			vHTML += '					</button>';
			vHTML += '				</li>';
			vHTML += '			</ul>';
			vHTML += '		</div>';
			vHTML += '		<table class="car_infotable1 car_infotable2">';
			vHTML += '			<tr>';
			vHTML += '				<th>추가사항</th>';
			vHTML += '				<th>요금</th>';
			vHTML += '				<th width="78px">수량/종류</th>';
			vHTML += '			</tr>';
			vHTML += '			<tr>';
			vHTML += '				<td>핸드 컨트롤</td>';
			vHTML += '				<td class="tr">무료</td>';
			vHTML += '				<td class="tc">';
			vHTML += '					<select name="" class="fr_select" data-role="none">';
			vHTML += '						<option value="">선택</option>';
			vHTML += '						<option value="오른쪽">오른쪽</option>';
			vHTML += '						<option value="왼쪽">왼쪽</option>';
			vHTML += '					</select>';
			vHTML += '				</td>';
			vHTML += '			</tr>';
			vHTML += '			<tr>';
			vHTML += '				<td>합계</td>';
			vHTML += '				<td class="f_purple tr" colspan="2" id="subOption'+ i +'">0원/일</td>';
			vHTML += '			</tr>';
			vHTML += '		</table>';
			vHTML += '		<table class="car_infotable1 car_infotable3">';
			vHTML += '			<tr>';
			vHTML += '				<th>승객 수</th>';
			vHTML += '				<td>'+ rentalCarList[i].passengerCnt +'명</td>';
			vHTML += '				<th>수화물 개수</th>';
			vHTML += '				<td>'+ rentalCarList[i].baggageCnt +'개</td>';
			vHTML += '			</tr>';
			vHTML += '			<tr>';
			vHTML += '				<th>에어컨</th>';
			if(rentalCarList[i].airCondition == "true"){
				vHTML += '				<td>있음</td>';
			}else{
				vHTML += '				<td>없음</td>';	
			}
			vHTML += '				<th>변속기</th>';
			if(rentalCarList[i].transType == "Automatic"){
				vHTML += '				<td>자동</td>';
			}else{
				vHTML += '				<td>수동</td>';	
			}
			vHTML += '			</tr>';
			vHTML += '			<tr>';
			vHTML += '				<th>연료</th>';
			vHTML += '				<td>'+ fuelType[rentalCarList[i].fuelType] +'</td>';
			vHTML += '				<th>연비</th>';
			vHTML += '				<td>'+ rentalCarList[i].furateKpl +'km/리터</td>';
			vHTML += '			</tr>';
			vHTML += '			<tr>';
			vHTML += '				<th>에어백</th>';
			if(rentalCarList[i].dualAbagYn == "Y"){
				vHTML += '				<td>듀얼 에어백</td>';
			}else if(rentalCarList[i].abagYn == "Y"){
				vHTML += '				<td>장착</td>';
			}else{
				vHTML += '				<td>미장착</td>';
			}
			vHTML += '				<th>주행거리제한</th>';
			if(rentalCarList[i].unlimited == "true"){
				vHTML += '				<td>무제한</td>';
			}else{
				vHTML += '				<td>'+ rentalCarList[i].distQuantiy +" "+ rentalCarList[i].distUnitNm +'</td>';
			}
			vHTML += '			</tr>';
			vHTML += '		</table>';
			vHTML += '	</li>';
			vHTML += '	<li>';
			vHTML += '		<span>요금 최저가(오늘환율기준)</span>';
			vHTML += '		<p>'+ comma((parseFloat(rentalCarList[i].estimatedTotalAmt) * exchangeVal).toFixed()) +'원/ <em>'+ rentalCarList[i].currency +' '+ comma(rentalCarList[i].estimatedTotalAmt) +'</em></p>';
			
			/*
			if(nullToBlank(rentalCarList[i].monthUnitNm) != ""){
				vHTML += '		<span>1개월 요금 최저가(오늘환율기준)</span>';
				vHTML += '		<p><em>'+ comma((parseFloat(rentalCarList[i].monthUnitCharge) * exchangeVal).toFixed()) +'</em>원</p>';
			}else if(nullToBlank(rentalCarList[i].weekUnitNm) != ""){
				vHTML += '		<span>1주 요금 최저가(오늘환율기준)</span>';
				vHTML += '		<p><em>'+ comma((parseFloat(rentalCarList[i].weekUnitCharge) * exchangeVal).toFixed()) +'</em>원</p>';
			}else if(nullToBlank(rentalCarList[i].dayUnitNm) != ""){
				vHTML += '		<span>1일 요금 최저가(오늘환율기준)</span>';
				vHTML += '		<p><em>'+ comma((parseFloat(rentalCarList[i].dayUnitCharge) * exchangeVal).toFixed()) +'</em>원</p>';
			}else if(nullToBlank(rentalCarList[i].hourUnitNm) != ""){
				vHTML += '		<span>1시간 요금 최저가(오늘환율기준)</span>';
				vHTML += '		<p><em>'+ comma((parseFloat(rentalCarList[i].hourUnitCharge) * exchangeVal).toFixed()) +'</em>원</p>';
			}else{
				vHTML += '		<span>요금 최저가(오늘환율기준)</span>';
				vHTML += '		<p><em>'+ comma((parseFloat(rentalCarList[i].unitCharge) * exchangeVal).toFixed()) +'</em>원</p>';
			}
			*/
			
			vHTML += '	</li>';
			vHTML += '</ul>';
		};
		
		sessionStorage.rentCarResultList = JSON.stringify(rentalCarList);
		$("#rentalCarList").html(vHTML);
		
		filterInfo = {
			'carSizeVal'	: carSizeVal,
			'limitYn'		: limitYn,
			'transTypeVal'	: transTypeVal,
			'minPriceVal'	: minPriceVal,
			'maxPriceVal'	: maxPriceVal
		}
		
		fn_cssScript();
		closePopup();
	}
	
	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}
</script>

<div class="layerPopup">
	<div class="layerPop bgwhite">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">상세조건</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain pop_lc_box">
				<!-- 차량종류 -->
				<dl class="pop_chk_list" id="carSizeFilter">
				</dl>
				<!-- 가격 -->
				<dl class="pop_chk_list pop_chk_list2">
					<dt>가격</dt>
					<dd>
						<div class="pop_range">
							<input type="text" id="range" value="" name="range"/>
						</div>
					</dd>
				</dl>
				<!-- 주행거리 -->
				<dl class="pop_chk_list">
					<dt>주행거리</dt>
					<!-- 
					<dd>
						<p class="chkbox">
							<span><input id="chk_if2_1" type="checkbox" data-role="none" value="all"/></span><label for="chk_if2_1">전체</label>
						</p>
					</dd>
					 -->
					<dd>
						<p class="chkbox">
							<span><input id="chk_if2_2" type="checkbox" data-role="none" value="unlimite"/></span><label for="chk_if2_2">무제한</label>
						</p>
					</dd>
				</dl>
				<!-- 변속기 -->
				<dl class="pop_chk_list pop_chk_list2">
					<dt>변속기</dt>
					<dd>
						<p class="chkbox">
							<span><input id="chk_if3_1" class="transmissionType" type="checkbox" data-role="none" value="all"/></span> <label for="chk_if3_1">전체</label>
						</p>
					</dd>
					<dd>
						<p class="chkbox">
							<span><input id="chk_if3_2" class="transmissionType transmissionTypeSub" type="checkbox" data-role="none" value="Automatic"/></span> <label for="chk_if3_2">자동</label>
						</p>
					</dd>
					<dd>
						<p class="chkbox">
							<span><input id="chk_if3_3" class="transmissionType transmissionTypeSub" type="checkbox" data-role="none" value="Manual"/></span> <label for="chk_if3_3">수동</label>
						</p>
					</dd>
				</dl>
			</div>
		</div>
		<!-- 내용끝 -->
		<div class="popFoot pf2">
			<div class="layerBtns">
				<button type="button" class="layerClose1" onclick="fn_resetFilter();">초기화</button>
			</div>
			<div class="layerBtns">
				<button type="button" class="layerClose2" onclick="fn_applyFilter();">적용</button>
			</div>
		</div>
	</div>
</div>