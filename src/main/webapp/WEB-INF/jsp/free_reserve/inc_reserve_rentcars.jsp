<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript">
	var fn_rentInit = function(){
		var rentHTML = "";
		var selRentalCarInfo = JSON.parse(sessionStorage.rentcarSelData);
		var rentalcarTot = 0;
		
		for(var i = 0; i < selRentalCarInfo.length; i++){				
			var takeYear = selRentalCarInfo[i].searchTakeDate.substring(0, 4);
			var takeMonth = selRentalCarInfo[i].searchTakeDate.substring(4, 6);
			var takeDay = selRentalCarInfo[i].searchTakeDate.substring(6, 8);
			
			var returnYear = selRentalCarInfo[i].searchReturnDate.substring(0, 4);
			var returnMonth = selRentalCarInfo[i].searchReturnDate.substring(4, 6);
			var returnDay = selRentalCarInfo[i].searchReturnDate.substring(6, 8);
			
			var carTakeDt = takeYear + "." + takeMonth + "." + takeDay;
			var carTakeTime = selRentalCarInfo[i].searchTakeTime.substring(0, 2) +":"+ selRentalCarInfo[i].searchTakeTime.substring(2, 4);
			var carReturnDt = returnYear + "." + returnMonth + "." + returnDay;
			var carTakeTime = selRentalCarInfo[i].searchReturnTime.substring(0, 2) +":"+ selRentalCarInfo[i].searchReturnTime.substring(2, 4);
			
			var takeDate = new Date(takeYear, parseInt(takeMonth) - 1, takeDay);
			var takeNumday = getWeeks(takeDate.getDay());
			var returnDate = new Date(returnYear, parseInt(returnMonth) - 1, returnDay);
			var returnNumday = getWeeks(returnDate.getDay());
			
			rentHTML += '<dl class="pop_info_list">';
			rentHTML += '	<dt>렌터카'+ (i + 1);
			rentHTML += '	<dd>';
			rentHTML += '		<ul class="lc_acodion_info">';
			if(i == 0){
				rentHTML += '			<li class="on"><div>';	
			}else{
				rentHTML += '			<li><div>';
			}
			rentHTML += '				<span>'+ selRentalCarInfo[i].carNm.replace('OR SIMILAR', '') +'</span>';
			if(selRentalCarInfo[i].carNm.indexOf('OR SIMILAR') > -1){
				rentHTML += '				<span>OR SIMILAR</span>';
			}else{
				rentHTML += '				<span></span>';
			}
			rentHTML += '				</div>';
			rentHTML += '				<p>'+ carSize[selRentalCarInfo[i].carSize] +'</p></li>';
			rentHTML += '			<li>';
			rentHTML += '				<ul>';
			rentHTML += '					<li>승객수 : '+ selRentalCarInfo[i].passengerCnt +'명</li>';
			rentHTML += '					<li>수화물 개수 : '+ selRentalCarInfo[i].baggageCnt +'개</li>';
			if(selRentalCarInfo[i].airCondition == "true"){
				rentHTML += '					<li>에어컨 : 있음</li>';
			}else{
				rentHTML += '					<li>에어컨 : 없음</li>';
			}
			
			if(selRentalCarInfo[i].transType == "Automatic"){
				rentHTML += '					<li>변속기 : 자동</li>';
			}else{
				rentHTML += '					<li>변속기 : 수동</li>';
			}
			rentHTML += '					<li>연료 : '+ fuelType[selRentalCarInfo[i].fuelType] +'</li>';
			rentHTML += '					<li>연비 : '+ selRentalCarInfo[i].furateKpl +'km/리터</li>';
			if(selRentalCarInfo[i].dualAbagYn == "Y"){
				rentHTML += '				<li>에어백 : 듀얼 에어백</li>';
			}else if(selRentalCarInfo[i].abagYn == "Y"){
				rentHTML += '				<li>에어백 : 장착</li>';
			}else{
				rentHTML += '				<li>에어백 : 미장착</li>';
			}
			if(selRentalCarInfo[i].unlimited == "true"){
				rentHTML += '					<li>주행거리제한 : 무제한</li>';
			}else{
				rentHTML += '					<li>주행거리제한 : '+ selRentalCarInfo[i].distQuantiy +" "+ selRentalCarInfo[i].distUnitNm +'</li>';	
			}
			rentHTML += '				</ul>';
			rentHTML += '			</li>';
			rentHTML += '		</ul>';
			rentHTML += '		<table class="ft_table2 ft_tb_tl">';
			rentHTML += '			<tr>';
			rentHTML += '				<th>차량 인수일</th>';
			rentHTML += '				<td>'+ carTakeDt +'('+ takeNumday +') '+ carTakeTime +'</td>';
			rentHTML += '			</tr>';
			rentHTML += '			<tr>';
			rentHTML += '				<th>차량 반납일</th>';
			rentHTML += '				<td>'+ carReturnDt +'('+ returnNumday +') '+ carTakeTime +'</td>';
			rentHTML += '			</tr>';
			rentHTML += '			<tr>';
			rentHTML += '				<th>인수 장소</th>';
			rentHTML += '				<td>'+ selRentalCarInfo[i].searchTakePlace +'</td>';
			rentHTML += '			</tr>';
			rentHTML += '			<tr>';
			rentHTML += '				<th>반납 장소</th>';
			rentHTML += '				<td>'+ selRentalCarInfo[i].searchReturnPlace +'</td>';
			rentHTML += '			</tr>';
			/*
			rentHTML += '			<tr>';
			rentHTML += '				<th colspan="2">추가 선택 사항</th>';
			rentHTML += '				<td>';
			rentHTML += '					<ul class="dotlist2">';
			rentHTML += '						<li>승객수 : 4명</li>';
			rentHTML += '						<li>수화물 개수 : 2개</li>';
			rentHTML += '					</ul>';
			rentHTML += '				</td>';
			*/
			rentHTML += '			</tr>';
			rentHTML += '			<tr>';
			rentHTML += '				<td colspan="2" style="color:#ff7878;background:#f6f6f8;text-align:center;">* 렌터카 추가사항은 현장에 장비를 보유한 경우 추가 할 수 있습니다. (추가비용 발생)</td>';
			rentHTML += '			</tr>';
			rentHTML += '			<tr>';
			rentHTML += '				<th>렌터카 총 운임</th>';
			rentHTML += '				<td class="tr">'+ comma((selRentalCarInfo[i].estimatedTotalAmt * selRentalCarInfo[i].exchangeVal).toFixed()) +'원/ <span class="f_purple">'+ selRentalCarInfo[i].currency +' '+ comma(selRentalCarInfo[i].estimatedTotalAmt) +'</span></td>';
			rentHTML += '			</tr>';
			rentHTML += '		</table>';
			rentHTML += '	</dd>';
			rentHTML += '</dl>';
			
			rentalcarTot += parseInt((selRentalCarInfo[i].estimatedTotalAmt * selRentalCarInfo[i].exchangeVal).toFixed());
		}
		
		$("#rentalcar_div").html(rentHTML);
		$("#rentcar_totFare").html(comma(rentalcarTot) +'원');
		$("#rentcar_amt").val(rentalcarTot);
		
		setTimeout(function(){
			$(".pop_info_list .lc_acodion_info > li").off("click")
			$(".pop_info_list .lc_acodion_info > li").on("click", function(){
				$(this).toggleClass("on");
			});
			
			$(".sub_amt").change();
		}, 50);
	}
	
	$(document).ready(function() {
		if(nullToBlank(sessionStorage.rentcarSelData) != "" && sessionStorage.rentcarSelData != "[]"){
			fn_rentInit();
		}
	});
</script>

<p class="pop_lcvtitle mt7">렌터카</p>
<div id="rentalcar_div">
</div>
<p class="txbox4">(TAX 포함)</p>
<ul class="txbox2">
	<li>렌터카 금액은 금일 환율 기준이며, 환율변동에 의해 매일 변경될 수 있습니다.</li>
</ul>