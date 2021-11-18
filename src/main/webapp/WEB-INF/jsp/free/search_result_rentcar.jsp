<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<%
	String selAir = (String) request.getAttribute("selAir");
	String selHotel = (String) request.getAttribute("selHotel");
	String selRentcar = (String) request.getAttribute("selRentcar");
%>
<head>
<script src="/resources/common/js/fit/rentcar_search.js"></script>
<script src="/resources/common/js/fit/common.js"></script>
<script type="text/javascript">
	var searchData = JSON.parse(sessionStorage.rentCarSearchData);
	var vendorId= "${vendorId}";
	var pkOagCode = "${pkOagCode}";
	var rtOagCode = "${rtOagCode}";
	var pageSize = "${pageSize}";
	var exchangeVal = 0;
	var rentalCarList;
	var rentalCarCnt;
	var oriRentalCarList;
	var filterInfo;
	
	// 초기화
	var fn_init = function() {
		$("#same_place").change(function(){
			if($(this).is(":checked")){
				$("#arr_place").prop("disabled", true);
				
				var takePlaceCd = $("#take_place_cd").val();				
				var takePlaceNm = $("#dep_place").val();
				var countryCd = $("#take_place_countryCd").val();

				$("#return_place_cd").val(takePlaceCd);
				$("#return_place_countryCd").val(countryCd);
				$("#arr_place").val(takePlaceNm);
			}else{
				$("#arr_place").prop("disabled", false);
			}
		});
		
		var vHTML_time = "";
		var vHTML_driver = "";
		var type = '${type}';
		
		//재검색창 황성
		if(type == 'rentcar') {
			$('.re_search').click();
			type = '';
		}
		
		for(var x = 0; x < 24; x++){
			if(x < 10){
				vHTML_time += '<option value="0'+ x +'00">0'+ x +':00</option>';
				vHTML_time += '<option value="0'+ x +'30">0'+ x +':30</option>';
			}else{
				vHTML_time += '<option value="'+ x +'00">'+ x +':00</option>';
				vHTML_time += '<option value="'+ x +'30">'+ x +':30</option>';
			}
		}
		
		$("#takeTime").html(vHTML_time);
		$("#returnTime").html(vHTML_time);		
		
		vHTML_driver += '<option value="">운전자 나이 (인수일 기준)</option>';
		vHTML_driver += '<option value="70">만70+**세</option>';
		vHTML_driver += '<option value="30">만30~69세</option>';
		
		for(var y = 29; y > 17; y--){
			vHTML_driver += '<option value="'+ y +'">만'+ y +'세</option>';
		}
		
		$("#driverAge").html(vHTML_driver);
		
		var takeDateStr = searchData.rentTakeDate.substring(0, 4) + "." + searchData.rentTakeDate.substring(4, 6) + "." + searchData.rentTakeDate.substring(6, 8);
		var takeTimeStr = searchData.rentTakeTime.substring(0, 2) + ":" + searchData.rentTakeTime.substring(2, 4);
		var returnDateStr = searchData.rentReturnDate.substring(0, 4) + "." + searchData.rentReturnDate.substring(4, 6) + "." + searchData.rentReturnDate.substring(6, 8);
		var returnTimeStr = searchData.rentReturnTime.substring(0, 2) + ":" + searchData.rentReturnTime.substring(2, 4);
		
		$("#rentFromToDate").text(takeDateStr + " " + takeTimeStr + " ~ " + returnDateStr + " " + returnTimeStr);
		
		$(".re_schview").find("#dep_dt").text(takeDateStr);
		$(".re_schview").find("#take_date").val(searchData.rentTakeDate);
		$(".re_schview").find("#arr_dt").text(returnDateStr);
		$(".re_schview").find("#return_date").val(searchData.rentReturnDate);
		$(".re_schview").find("#takeTime").val(searchData.rentTakeTime).prop("selected", true);
		$(".re_schview").find("#returnTime").val(searchData.rentReturnTime).prop("selected", true);
		$(".re_schview").find("#driverAge").val(searchData.driverAge).prop("selected", true);
		
		if(searchData.rentTakeType == "CITY"){
			$(".re_schview").find("#take_place_cd").val(searchData.rentTakePlaceCd);
		}else{
			$(".re_schview").find("#take_place_oagCd").val(searchData.rentTakePlaceCd);
		}
		
		$(".re_schview").find("#dep_place").val(searchData.rentTakePlaceNm);
		$(".re_schview").find("#take_place_countryCd").val(searchData.rentTakePlaceCountryCd);
		$(".re_schview").find("#dep_place").val(searchData.rentTakePlaceNm);
		
		if(searchData.rentReturnType == "TYPE"){
			$(".re_schview").find("#return_place_cd").val(searchData.rentReturnPlaceCd);
		}else{
			$(".re_schview").find("#return_place_oagCd").val(searchData.rentReturnPlaceCd);	
		}
		
		$(".re_schview").find("#arr_place").val(searchData.rentReturnPlaceNm);
		$(".re_schview").find("#return_place_countryCd").val(searchData.rentReturnPlaceCountryCd);
		$(".re_schview").find("#arr_place").val(searchData.rentReturnPlaceNm);
		$("#resultTitle").html(searchData.rentTakePlaceNm);
		
		if(searchData.rentTakePlaceCd != searchData.rentReturnPlaceCd){
			$("#otherOffice").show();
		}else{
			$("#otherOffice").hide();
		}
		
		if(searchData.samePlaceYn){
			$("#same_place").click();
		}
		
		$("#rentalCarMore").off("click");
		$("#rentalCarMore").on("click", function(){
			var curRow = $("#rentalCarList").children().length;
			startRow = curRow + 1;
			endRow = curRow + Number(pageSize);
			
			if(rentalCarCnt > endRow){
				rentalCarLen = endRow;
				$("#rentalCarMore").show();
			}else{
				rentalCarLen = rentalCarCnt;
				$("#rentalCarMore").hide();
			}
			
			var vHTML = "";
			for(var i = curRow ; i < rentalCarLen; i++){
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
				vHTML += '						<a href="#" class="layerOpener" data-url="/pop/pop_rentcar_viewdetail.do?rcIdx='+i+'" data-ok="yes" data-ctn="full" data-role="none" style="cursor=\'hand\';">상세보기</a>';
				//vHTML += '						<a href="#" onclick="moveLink(\'/pop/pop_rentcar_viewdetail.do?idx='+ i +'\', \'_system\')" class="ui-link">상세보기</a>';
				vHTML += '					</button>';
				vHTML += '				</li>';
				vHTML += '			</ul>';
				vHTML += '		</div>';
				/*
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
				*/
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
			
			$("#rentalCarList").append(vHTML);
			
			fn_cssScript();
		})
	};
	
	var fn_cssScript = function(){
		$(".car_infobtn button:first-child").off("click")
		$(".car_infobtn button:first-child").on("click", function(){
			$(this).toggleClass("on");
			if($(this).hasClass("on")==true){
				$(this).parent().parent().parent().parent().find(".car_infotable3").show();
			}else{
				$(this).parent().parent().parent().parent().find(".car_infotable3").hide();
			}
		});
		/* 렌터카 라디오박스 이미지 및 타이틀 */
		$(".frc_infobox > p").off("click")
		$(".frc_infobox > p").on("click", function(){
			$(this).parent().parent().parent().parent().find(".radioboxs2").removeClass("on");
			$(this).parent().prev().addClass("on");	
			$(this).parent().prev().find("input").prop("checked", true);	
			var fec_index = $(this).parent().parent().parent().index(".fr_carlist");
			lt_car_tinfo(fec_index);
		});
		$(".frc_infobox .car_infot2").off("click")
		$(".frc_infobox .car_infot2").on("click", function(){
			$(this).parent().parent().parent().parent().parent().find(".radioboxs2").removeClass("on");
			$(this).parent().parent().prev().addClass("on");	
			$(this).parent().parent().prev().find("input").prop("checked", true);	
			var fec_index = $(this).parent().parent().parent().parent().index(".fr_carlist");
			lt_car_tinfo(fec_index);
		});
		var lt_car_tinfo = function(idx){
			$(".car_infotable1").hide();
			$(".car_infobtn button:first-child").removeClass("on");
			if($(".fr_carlist"+idx+" .radioboxs2 input").is(":checked")==true){
				$(".fr_carlist"+idx+" .car_infotable2").show();
			};
		};
	}

	var fn_search = function() {		
		var sdate = searchData.rentTakeDate.substring(0, 4) + "-" + searchData.rentTakeDate.substring(4, 6) + "-" + searchData.rentTakeDate.substring(6, 8);
		var edate = searchData.rentReturnDate.substring(0, 4) + "-" + searchData.rentReturnDate.substring(4, 6) + "-" + searchData.rentReturnDate.substring(6, 8);
		var stime = searchData.rentTakeTime.substring(0, 2) + ":" + searchData.rentTakeTime.substring(2, 4);
		var etime = searchData.rentReturnTime.substring(0, 2) + ":" + searchData.rentReturnTime.substring(2, 4);
		
		var formData = new FormData();
		formData.append("pickupOagCode",pkOagCode);
		formData.append("returnOagCode",rtOagCode);
		formData.append("pickupDate",sdate);
		formData.append("returnDate",edate);
		formData.append("pickupTime",stime);
		formData.append("returnTime",etime);
		formData.append("country", searchData.rentTakePlaceCountryCd);
		
		cfn_ajax({
			url: "/fit/rnt/selectRentcarList.do",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:"no",
			success: function(res) {
				rentalCarList = res.carList;
				oriRentalCarList = res.carList;
				var noDataHTML = ""; 
				noDataHTML += '<div class="fr_nodata" style="line-height:2;">';
				noDataHTML += '	<p>검색하신 조건으로<br>검색된 차량이 없습니다.</p>';
				noDataHTML += '</div>';
				
				if(nullToBlank(rentalCarList) == ""){
					$("#carCount").html("총 상품 0개");
					$("#rentalCarList").html(noDataHTML);
					$("#rentalCarMore").hide();
					
					gfn_loading_bar_draw('hide');
				}else{
					if(rentalCarList.length > 0){
						if(rentalCarList[0].sucess == "false"){
							$("#carCount").html("총 상품 0개");
							$("#rentalCarList").html(noDataHTML);
							$("#rentalCarMore").hide();
							
							gfn_loading_bar_draw('hide');
						}else if(rentalCarList[0].msg.indexOf("ErrorCode") != -1){
							$("#carCount").html("총 상품 0개");
							
							noDataHTML = "";
							noDataHTML += '<div class="fr_nodata" style="line-height:2;">';
							noDataHTML += '	<p>'+ rentalCarList[0].msg.replace("ErrorCode", "") +'</p>';
							noDataHTML += '</div>';
							
							$("#rentalCarList").html(noDataHTML);
							$("#rentalCarMore").hide();
							
							gfn_loading_bar_draw('hide');
						}else{
							$("#carCount").html("총 상품 "+ rentalCarList.length +"개");
							rentalCarCnt = rentalCarList.length;
							var exchangeData = new FormData();
							exchangeData.append("currCd", rentalCarList[0].currency);
							
							cfn_ajax({
								url: "/exchangeInfo.do",
								type: "POST",
								data: exchangeData,
								async: false,
								cache: false,
								dataType: "json",
								noloading: "no",
								success: function(res){
									if(res.data.length == 0){
										exchangeVal = 0;	
									}else{
										if(res.data.currCd == "JPY"){
											exchangeVal = parseFloat(res.data.basRate) / 100;
										}else{
											exchangeVal = res.data.basRate;	
										}
									}
									var rentalCarLen = rentalCarCnt;
									
									if(rentalCarCnt > pageSize){
										rentalCarLen = pageSize;
										$("#rentalCarMore").show();
									}else{
										$("#rentalCarMore").hide();
									}
									
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
										vHTML += '						<a href="#" class="layerOpener" data-url="/pop/pop_rentcar_viewdetail.do?rcIdx='+i+'" data-ok="yes" data-ctn="full" data-role="none" style="cursor=\'hand\';">상세보기</a>';
										//vHTML += '						<a href="#" onclick="moveLink(\'/pop/pop_rentcar_viewdetail.do?idx='+ i +'\', \'_system\')" class="ui-link">상세보기</a>';
										vHTML += '					</button>';
										vHTML += '				</li>';
										vHTML += '			</ul>';
										vHTML += '		</div>';
										/*
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
										*/
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
										
										/*
										if(rentalCarList[i].unitNm == "Day"){
											vHTML += '		<span>1일 요금 최저가(오늘환율기준)</span>';
											vHTML += '		<p><em>'+ comma((parseFloat(rentalCarList[i].unitCharge) * exchangeVal).toFixed()) +'</em>원</p>';
										}else if(rentalCarList[i].unitNm == "Week"){
											vHTML += '		<span>1일 요금 최저가(오늘환율기준)</span>';
											vHTML += '		<p><em>'+ comma(((parseFloat(rentalCarList[i].unitCharge) / 7) * exchangeVal).toFixed()) +'</em>원</p>';
										}else if(rentalCarList[i].unitNm == "Month"){
											vHTML += '		<span>1일 요금 최저가(오늘환율기준)</span>';
											vHTML += '		<p><em>'+ comma(((parseFloat(rentalCarList[i].unitCharge) / 28) * exchangeVal).toFixed()) +'</em>원</p>';
										}else if(rentalCarList[i].unitNm == "Hour"){
											vHTML += '		<span>1일 요금 최저가(오늘환율기준)</span>';
											vHTML += '		<p><em>'+ comma(((parseFloat(rentalCarList[i].unitCharge) * 24) * exchangeVal).toFixed()) +'</em>원</p>';
										}else{
											vHTML += '		<span>1일 요금 최저가(오늘환율기준)</span>';
											vHTML += '		<p><em>'+ comma((parseFloat(rentalCarList[i].unitCharge) * exchangeVal).toFixed()) +'</em>원</p>';
										}
										*/
										
										vHTML += '	</li>';
										vHTML += '</ul>';
									};
									
									sessionStorage.rentCarResultList = JSON.stringify(rentalCarList);
									$("#rentalCarList").html(vHTML);
									gfn_loading_bar_draw('hide');
								},
								error: function(err){
									gfn_loading_bar_draw('hide');
								},
								complete:function(){
									fn_cssScript();
								}
							});	
						}
					}else{
						$("#carCount").html("총 상품 0개");
						$("#rentalCarList").html(noDataHTML);
						$("#rentalCarMore").hide();
						gfn_loading_bar_draw('hide');
					}
				}
			},
			error:function(err){
				gfn_loading_bar_draw('hide');
			},
			complete:function(){
			}
		});
	};

	// 버튼 초기화
	var fn_initButton = function() {
	};
	
	var fn_rentReSearch = function() {
		var frm_action = '';
		
		if(fn_set_rentcar_search_value('RCREGroup')){
			if(frm_action == '') {
				frm_action = '/free/search_result_rentcar_office.do';	
			}
		}else{
			return;
		}
		
		document.location.href = frm_action + "?selAir=" + "<%=selAir%>" + "&selHotel=" + "<%=selHotel%>" + "&selRentcar=" + "<%=selRentcar%>";
	}
	
	function getRateCode(countryCode){
		/**
		var rateCode;
		
		/*
		if("CA" == countryCode || "AU" == countryCode || "NZ" == countryCode) {  // 미국 , 캐나다, 호주 , 뉴질랜드
        	rateCode = "ABC";
        } else if("US" == countryCode || "DK" == countryCode || "GL" == countryCode || "IS" == countryCode ||  "PL" == countryCode ||
                   "RS" == countryCode || "AT" == countryCode || "BY" == countryCode ||  "CZ" == countryCode ||
                   "DE" == countryCode || "GE" == countryCode || "GR" == countryCode ||  "LT" == countryCode ||
                   "LU" == countryCode || "SE" == countryCode || "SI" == countryCode ||  "TR" == countryCode ||
                   "VA" == countryCode || "AM" == countryCode || "EE" == countryCode ||  "HU" == countryCode ||
                   "NL" == countryCode || "RU" == countryCode || "VI" == countryCode ||  "AZ" == countryCode ||
                   "BE" == countryCode || "ES" == countryCode || "FI" == countryCode ||  "GI" == countryCode ||
                   "IT" == countryCode || "KG" == countryCode || "MD" == countryCode ||  "NO" == countryCode ||
                   "SK" == countryCode || "BG" == countryCode || "CS" == countryCode ||  "FO" == countryCode ||
                   "GB" == countryCode || "LV" == countryCode || "MC" == countryCode ||  "TM" == countryCode ||
                   "YU" == countryCode || "AL" == countryCode || "CY" == countryCode ||  "HR" == countryCode ||
                   "IE" == countryCode || "MT" == countryCode || "SM" == countryCode ||  "UA" == countryCode ||
                   "VG" == countryCode || "BA" == countryCode || "CH" == countryCode ||  "PT" == countryCode ||
                   "RO" == countryCode || "TJ" == countryCode || "FR" == countryCode) { // 유럽
            rateCode = "DEF";
        } else if("GU" == countryCode) { // 괌
            rateCode = "GUMCC";
        } else if("MP" == countryCode) { // 사이판
            rateCode = "KMP";
        } else if("UZ" == countryCode || "YE" == countryCode || "BN" == countryCode ||  "KP" == countryCode ||
                   "LA" == countryCode || "PK" == countryCode || "TH" == countryCode ||  "TW" == countryCode ||
                   "IN" == countryCode || "JP" == countryCode || "MN" == countryCode ||  "AF" == countryCode ||
                   "CC" == countryCode || "HK" == countryCode || "ID" == countryCode ||  "MO" == countryCode ||
                   "MV" == countryCode || "YT" == countryCode || "IQ" == countryCode ||  "KR" == countryCode ||
                   "KW" == countryCode || "KZ" == countryCode || "MM" == countryCode ||  "MY" == countryCode ||
                   "BH" == countryCode || "KH" == countryCode || "LK" == countryCode ||  "NP" == countryCode ||
                   "SG" == countryCode || "VN" == countryCode || "WF" == countryCode ||  "BD" == countryCode ||
                   "BT" == countryCode || "CN" == countryCode || "PH" == countryCode ||  "UM" == countryCode) { // 아시아
            rateCode = "AAS1";
        }
		*/
		
		if("AD" == countryCode || "AU" == countryCode || "AT" == countryCode || "BE" == countryCode || "CA" == countryCode || "HR" == countryCode ||
				"CZ" == countryCode || "DK" == countryCode || "EE" == countryCode || "FJ" == countryCode || "FI" == countryCode || "FR" == countryCode ||
				"DE" == countryCode || "HU" == countryCode || "IT" == countryCode || "LU" == countryCode || "MY" == countryCode || "MC" == countryCode || 
				"NL" == countryCode || "NZ" == countryCode || "NO" == countryCode || "PH" == countryCode || "PT" == countryCode || "RS" == countryCode ||
				"SG" == countryCode || "SK" == countryCode || "SI" == countryCode || "ZA" == countryCode || "ES" == countryCode || "CH" == countryCode ||
				"AE" == countryCode || "GB" == countryCode || "US" == countryCode){
			rateCode = "ABC";
		}else if("AD" == countryCode){
			rateCode = "GUMCC";
		}else{
			rateCode = "BEST";
		}

		return rateCode;
	}

	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();
		
		$("#selectPut").click(function(){
			var carSelYn = false;
			var dataIndex;
			var selCarList = [];
			
			$(".carRadio").each(function(){
				if($(this).is(":checked")){
					dataIndex = $(this).data("num");
					carSelYn = true;
					return false;
				}
			})
			
			if(!carSelYn){
				setAlert("차량을 선택해 주세요.");
				return false;
			}else{
				if(nullToBlank(sessionStorage.rentcarSelData) != ""){
					var rentcalSelList = JSON.parse(sessionStorage.rentcarSelData); 
					for(var i = 0; i < rentcalSelList.length; i++){
						selCarList.push(rentcalSelList[i]);
					}
				}
				
				rentalCarList[dataIndex].exchangeVal = exchangeVal;
				rentalCarList[dataIndex].searchTakeDate = searchData.rentTakeDate;
				rentalCarList[dataIndex].searchTakeTime = searchData.rentTakeTime;
				rentalCarList[dataIndex].searchReturnDate = searchData.rentReturnDate;
				rentalCarList[dataIndex].searchReturnTime = searchData.rentReturnTime;
				rentalCarList[dataIndex].searchTakePlace = searchData.rentTakePlaceNm;
				rentalCarList[dataIndex].searchReturnPlace = searchData.rentReturnPlaceNm;
				rentalCarList[dataIndex].nationCode = searchData.rentTakePlaceCountryCd;
				rentalCarList[dataIndex].rateCode = getRateCode(searchData.rentTakePlaceCountryCd);
				
				selCarList.push(rentalCarList[dataIndex]);
				sessionStorage.rentcarSelData = JSON.stringify(selCarList);
			}
		});
		
		gfn_loading_bar_draw('show');
		
		setTimeout(function(){
			fn_search();
		}, 400);
	});
</script>
</head>
<body>
	<form name="f_frm" id="f_frm" method="post">
		<input type="hidden" name="selAir" id="selAir" value="${selAir}" />
		<input type="hidden" name="selHotel" id="selHotel" value="${selHotel}" />
		<input type="hidden" name="selRentcar" id="selRentcar" value="${selRentcar}" />
	</form>
	
	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="collapse freetop">
			<!-- 중복텝 -->
			<%
				// 항공 || 호텔 || 렌트카
				if(selAir.equals("Y") && selHotel.equals("Y") && selRentcar.equals("Y")) {
			%>
			<div class="free_box">
				<ul class="free_toprst frrst3">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" disabled="true" /><label for="hotelcheck">호텔</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
				// 항공 || 호텔
				else if(selAir.equals("Y") && selHotel.equals("Y") && !selRentcar.equals("Y")) {
			%> 
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" disabled="true" /><label for="hotelcheck">호텔</label></li>
				</ul>
			</div>
			<%
				}
				// 항공 || 렌트카 
				else if(selAir.equals("Y") && !selHotel.equals("Y") && selRentcar.equals("Y")) {
			%>
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
				// 호텔 || 렌트카 
				else if(!selAir.equals("Y") && selHotel.equals("Y") && selRentcar.equals("Y")) {			
			%>
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" disabled="true" /><label for="hotelcheck">호텔</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
				// 항공
				else if(selAir.equals("Y") && !selHotel.equals("Y") && !selRentcar.equals("Y")) {			
			%>			
			<div class="free_box">
				<ul class="free_toprst frrst1">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" disabled="true" /><label for="aircheck">항공</label></li>
				</ul>
			</div>
			<%
				}
				
				// 호텔
				else if(!selAir.equals("Y") && selHotel.equals("Y") && !selRentcar.equals("Y")) {
			%>
			<div class="free_box">
				<ul class="free_toprst frrst1">
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" disabled="true" /><label for="hotelcheck">호텔</label></li>
				</ul>
			</div>
			<%
				}
				
				// 렌터카
				else if(!selAir.equals("Y") && !selHotel.equals("Y") && selRentcar.equals("Y")) {
			%>
			<div class="free_box">
				<ul class="free_toprst frrst1">
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
			%>
			<!-- 간략안내 -->
			<div class="re_sch_lentcar">
				<div class="stable_guide3">
					<p class="st3_stext ellipsis" id="resultTitle"></p>
				</div>
				<div class="txbox1" id="rentFromToDate"></div>
				<!-- 검색버튼 -->
				<button type="button" data-role="none" class="re_search">재검색</button>
				<!-- 정렬박스 -->
				<ul class="fr_sortbox">
					<li id="carCount"></li>
					<li><button type="button" class="layerOpener" data-url="/pop/pop_rentcar_sorting.do" data-width="300" data-height="400" data-ok="yes" data-ctn="full" data-role="none" style="cursor='hand';"><span id="rentcar_sort" data-rentsort=''>차량정렬</span></button></li>
					<li><button type="button" class="layerOpener" data-url="/pop/pop_rentcar_ifdetail.do" data-ok="yes" data-ctn="full" data-role="none" style="cursor='hand';"></button></li>
				</ul>
				<button type="button" data-role="none" class="car_typebtn"><a href="#" class="layerOpener ui-link" data-url="/pop/pop_car_list.do" data-ctn="full"><span>차량종류</span></a></button>
				<p class="f_red fr_carlist" id="otherOffice" style="font-size:.8em;padding:0 10px 0 10px;font-weight:bold;">* 인수/반납 영업소가 다를 경우 추가비용이 발생할 수 있습니다.</p>
				<div id="rentalCarList">
				</div>
				<!-- 버튼 -->
				<div class="btn_one air_tbtn" id="rentalCarMore"><button class="white2 moreico" data-role="none">더보기</button></div>
				
				<!-- *********************** 재검색 레이어 ******************* -->
				<div class="re_schview" ft-att="RCREGroup">
					<!-- 렌터카파트 -->
					<div class="chkpart carpart">
						<div class="car_box">				
							<div class="fs_search car_search">
								<p class="schtitle">인수장소</p>
								<div class="csbox">
								<form>
									<fieldset>
										<legend>검색폼</legend>
										<input type="text" data-role="none" class="layerOpener" id="dep_place" data-url="/pop/pop_city_select3.do?availTy=RCRE&type=D" data-ctn="full" data-role="none" style="cursor='hand';" placeholder="도시, 호텔, 인근도시, 공항 등" />
										<input type="hidden" name="take_place_cd" id="take_place_cd"/>
										<input type="hidden" name="take_place_oagCd" id="take_place_oagCd"/>
										<input type="hidden" name="take_place_countryCd" id="take_place_countryCd"/>
										<button type="button" data-role="none">검색</button>
									</fieldset>
								</form>
								</div>
							</div>
							<div class="fs_search car_search">
								<div class="schtitle">반납위치 
									<p>
										<p class="chkbox">
											<label for="same_place">인수장소와 동일</label>
											<span><input id="same_place" type="checkbox" data-role="none" /></span>
										</p>
									</p>
								</div>
								<div class="csbox">
									<form>
										<fieldset>
											<legend>검색폼</legend>
											<input type="text" data-role="none" class="layerOpener" id="arr_place" data-url="/pop/pop_city_select3.do?availTy=RCRE&type=A" data-ctn="full" data-role="none" style="cursor='hand';" placeholder="도시, 호텔, 인근도시, 공항 등"/>
											<input type="hidden" name="return_place_cd" id="return_place_cd"/>
											<input type="hidden" name="return_place_oagCd" id="return_place_oagCd"/>
											<input type="hidden" name="return_place_countryCd" id="return_place_countryCd"/>
											<button type="button" data-role="none">검색</button>
										</fieldset>
									</form>
								</div>
							</div>
							<!-- 날짜와 시간 -->
							<ul class="tra_day tra_day2 cardaytime">
								<li>
									<button type="button" data-role="none" class="layerOpener" data-url="/pop/pop_rc_calendar.do?type=RENTCAR&availTy=RCRE"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'>
										<em>차량 인수일</em><span id="dep_dt"></span>
									</button>
									<input type="hidden" name="take_date" id="take_date" />
								</li>
								<li>
								<div class="seatbtn carselbox carselbox">
									<em>인수시간</em>
									<select name="takeTime" data-role="none" id="takeTime">
									</select>
								</div>
								</li>
							</ul>
							<ul class="tra_day tra_day2 cardaytime">
								<li>
									<button type="button" data-role="none" class="layerOpener" data-url="/pop/pop_rc_calendar.do?type=RENTCAR&availTy=RCRE"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'>
										<em>차량 반납일</em><span id="arr_dt"></span>
									</button>
									<input type="hidden" name="return_date" id="return_date"/>
								</li>
								<li>
								<div class="seatbtn carselbox carselbox">
									<em>반납시간</em>
									<select name="returnTime" data-role="none" id="returnTime">
									</select>
								</div>
								</li>
							</ul>
							<!-- 기본버튼 -->
							<div class="seatbtn selectbox carageobx">
								<button type="button" class="layerOpener select_guidebtn" data-url="/pop/pop_age_text.do" data-role="none" style="cursor='hand';">설명</button>
								<select name="driverAge" data-role="none" class="centerSelect" id="driverAge">
								</select>
							</div>
							<!-- 버튼 -->
							<div class="btn_one air_tbtn"><button class="purple2" data-role="none" onclick="fn_rentReSearch()">렌터카 검색하기</button></div>
						</div>	
					</div>

					<!-- 닫기튼 -->
					<button type="button" data-role="none" class="re_search_close">닫기</button>
				</div>
			</div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//content-->
</body>