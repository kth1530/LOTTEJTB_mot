<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_cancel1.jsp
	// 설명 : 취소규정 안내1
%>

<script type="text/javascript">
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){

	// 초기화
	var fn_init = function() {
		
		var cancelPolicy = '${cancelPolicy}';
		var selIdx = '${selIdx}';
		var vHtml = '';
				
		if(cancelPolicy == "") {	//EAN제외한 공급사
			fn_CancelPolicy(selIdx);
			
		} else { //공급사가 EAN인경우
		
			if(cancelPolicy == '999' || cancelPolicy == '환불불가') {
				
				vHtml +="<br><p><b>무료취소기한 : 취소/변경/환불불가</b></p>";
				vHtml +="<br><p> 이 요금은 취소/변경/환불이 불가능한 조건입니다.</p>";
			} else {
				vHtml +="<br><p><b>무료 취소 기한 :" + "  " + cancelPolicy + "</b></p>";
				vHtml +="<br><p> 이 요금은 위의 기간까지 무료 취소가 가능합니다.</p>";
			} 
		}
				
		$('#cancelPolicy').html(vHtml);
	};
	
	//상세페이지 취소규정 api 연동
	var fn_CancelPolicy = function(selIdx) {
		
		console.log(">>>>fn_CancelPolicy<<<< = " + selIdx);
		
		if(nullToBlank(sessionStorage.hotelViewData) != '' || (sessionStorage.hotelViewData) != '[]')
		{		
			var viewData = JSON.parse(sessionStorage.hotelViewData);
						
			var fitMix =   ($("#selAir").val() == 'Y' ? 'A' : 'X')
						 + ($("#selHotel").val() == 'Y' ? 'H' : 'X')
						 + ($("#selRentcar").val() == 'Y' ? 'C' : 'X');
			
			var suplrCd = g_hotel_room_data.roomInfos[selIdx].suplrCd;
			var hotelId = g_hotel_room_data.roomInfos[selIdx].hotelId;
			var rateKey = g_hotel_room_data.roomInfos[selIdx].rateInfos[0].rateKey;
			var roomId = g_hotel_room_data.roomInfos[selIdx].roomTypeCd;
			var roomTy = viewData.roomCont[0].roomTy;
			var numOfChd = viewData.roomCont[0].numOfChd;
			var ageOfChd = viewData.roomCont[0].ageOfChd;
			var checkInDt = viewData.checkInDate;
			var checkOutDt = viewData.checkOutDate;
			
			var setData = {
				'fitMix' : fitMix,
				'suplrCd' : suplrCd,
				'rateKey' : rateKey,
				'checkInDt' : checkInDt ,
				'checkOutDt' : checkOutDt,
				'hotelId' : hotelId,
				'roomId'  : roomId,
				'numOfChd' : parseInt(numOfChd),
				'ageOfChd' : ageOfChd,
				'roomTy' : roomTy
			};
			//console.log("======fn_CancelPolicy start=====");
			console.log(setData);
			//console.log("======fn_CancelPolicy end ======");
					
			gfn_callAjax('/fit/htl/cancelPolicy.do', setData, 'fn_drawCancelPolicy', false);
		}
		
	}
	
	var fn_drawCancelPolicy = function(data) {
		
		var cancelData = data.hotelCancelPolicy.cancelDl;
		var jtbCancelDl = data.hotelCancelPolicy.cancelJtbDl;
		
		var cancelDt = "16:00";
		
		console.log(data.hotelCancelPolicy);
		console.log(cancelData);
		
	/* 	var jtbCancelDl = cancelData;
		console.log(cancelData);
		
		var i_now = new Date();
		
		var i_yyyy	= i_now.getFullYear();
		var i_mm	= i_now.getMonth()+1;
		i_mm = i_mm < 10 ? '0'+(i_mm+'') : i_mm; 
		var i_dd	= i_now.getDate();
		i_dd = i_dd < 10 ? '0'+(i_dd+'') : i_dd;
		var i_hh24	= i_now.getHours();
		i_hh24 = i_hh24 < 10 ? '0'+(i_hh24+'') : i_hh24;
		var i_mi	= i_now.getMinutes();
		i_mi = i_mi < 10 ? '0'+(i_mi+'') : i_mi;
		
		var i_nowDt = i_yyyy + '' + i_mm + i_dd;
		var i_nowHm = i_hh24 + '' + i_mi;
		var calcResult = calcInterval2(i_nowDt, i_nowHm, jtbCancelDl, '1600').split(',');
		
		for(var ci=0; ci<calcResult.length; ci++){
			if(calcResult[ci] != 0 ){
				if(calcResult[ci] < 0){
					jtbCancelDl = '환불불가';
					break;
				}
			}
		}
		
		if(jtbCancelDl != '환불불가'){
			jtbCancelDl = jtbCancelDl + ' 16:00';
		} */
		
		var vHtml = '';
		
		if(nullToBlank(cancelData) != '') {
			console.log("데이터" + cancelData);
		
			if(jtbCancelDl == '환불불가') {
				vHtml +="<br><p><b>무료 취소 기한 : 취소/변경/" + jtbCancelDl + "</b></p>";
				vHtml +="<br><p> 이 요금은 취소/변경/환불이 불가능한 조건입니다.</p>";
			} else {
				vHtml +="<br><p><b>무료 취소 기한 :" + "  " + jtbCancelDl + "</b></p>";
				vHtml +="<br><p> 이 요금은 위의 기간까지 무료 취소가 가능합니다.</p>";
			}
		} else {
			console.log("취소규정에러=" + cancelData);
			setAlert("취소규정 정보를 불러오지 못했습니다.");
		}
				
		$('#cancelPolicy').html(vHtml);
		
		g_hotel_room_data.roomInfos[selTemp].rateInfos[0].cancelJtbDl = jtbCancelDl;
		g_hotel_room_data.roomInfos[selTemp].rateInfos[0].cancelDL = cancelData;
		g_hotel_room_data.roomInfos[selTemp].rateInfos[0].cancelTL = '16:00';
		
		var cancelDesc = data.hotelCancelPolicy.cancelDesc;
		if(cancelDesc == ''){
			cancelDesc = cancelData;
		}
		
		g_hotel_room_data.roomInfos[selTemp].rateInfos[0].cancellationPolicy = cancelDesc; 
			
	}
	
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

		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});
	
	
	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}

</script>

<div class="layerPopup">
	<div class="layerPop">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">취소규정 안내</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain pop_basebox pd0" id="cancelPolicy">
				<!-- 
				<p class="pop_pp_txt">무료취소 : 2016.10.26 까지</p>

				이 요금은 위의 기간까지 무료취소가 가능 합니다.<br> 단, 변경불가 상품으로 변경 시 취소 후 공실 여부 황인
				후 재 예약 하시기 바랍니다.
 -->			</div>
		</div>
		<!-- 내용끝 -->
		<div class="popFoot">
			<div class="layerBtns">
				<button type="button" class="layerClose1" onclick="closePopup()">확인</button>
			</div>
		</div>
	</div>
</div>