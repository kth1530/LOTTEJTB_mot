<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_rentcar_sorting.jsp
	// 설명 : 정렬방식
%>
<script src="/resources/common/js/fit/rentcar_search.js"></script>
<script src="/resources/common/js/fit/paging.js"></script>
<script src="/resources/common/js/fit/common.js"></script>	
<script type="text/javascript">
	// 초기화
	var fn_init = function() {
		var rentsort = $("#rentcar_sort").data("rentsort");

		$(".radiobox").removeClass('on');
		$("#rent_sort").removeAttr("checked");
		$("#rent_sort"+ rentsort).parent().addClass('on');
		$("#rent_sort"+ rentsort).prop("checked", true);

	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};

	function fn_rentSortPop(rentsort) {
		$(".radiobox").removeClass('on');
		$(".rent_sort").removeAttr("checked");
		$("#rent_sort"+ rentsort).parent().parent().addClass('on');
		$("#rent_sort"+ rentsort).prop("checked", true);
		
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
		
		setTimeout(function(){
			if(rentsort == 'A') {
				$("#rentcar_sort").text("가격 순");
				$('#rentcar_sort').data('rentsort', 'A');
			} else if(rentsort == 'B') {
				$("#rentcar_sort").text("차량 종류 순");
				$('#rentcar_sort').data('rentsort', 'B');
			} else {
				$("#rentcar_sort").text("차량 이름 순");
				$('#rentcar_sort').data('rentsort', 'C');
			}
			
			fn_cssScript();
			closePopup();
		}, 10);	

	}

	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();

		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});
</script>

<div class="layerPopup">
	<div class="layerPop">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">정렬방식</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain">
				<ul class="selectpop_radio">
					<li onclick="fn_rentSortPop('A')"><a><span class="radiobox"><input type="radio" name="rent_sort" id="rent_sortA" value='A'></span><label for="rent_sortA">가격 순</label></a></li>
					<li onclick="fn_rentSortPop('B')"><a><span class="radiobox"><input type="radio" name="rent_sort" id="rent_sortB" value='B'></span><label for="rent_sortB">차량 종류 순</label></a></li>
					<li onclick="fn_rentSortPop('C')"><a><span class="radiobox"><input type="radio" name="rent_sort" id="rent_sortC" value='C'></span><label for="rent_sortC">차량 이름 순</label></a></li>
				</ul>
			</div>

		</div>
		<!-- 내용끝 -->
		<div class="popFoot">
			<div class="layerBtns">
				<button type="button" class="layerClose1" onclick="closePopup()">확인</button>
			</div>
		</div>
	</div>
</div>