<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
	
	$(document).ready(function() {
		
		if(nullToBlank(sessionStorage.hotelBasketData) != '' && sessionStorage.hotelBasketData != '[]') {
			var basketData = JSON.parse(sessionStorage.hotelBasketData);
			var cancelJtbDl ='';
			var cancelTxt = '';
			var cancelTxt2 = '';
			var star='';
			for(var i=0; i < basketData.length; i++) {
				vHtml = '';
				cancelJtbDl = basketData[i].setRoomData[0].rateInfos[0].cancelJtbDl;
				if(cancelJtbDl == '환불불가') {
					cancelTxt = " 환불 불가 : (Non-refundable) 규정적용";
					cancelTxt2 =" (예약확정 후 변경/취소 시 지불하신 금액은 환불되지 않습니다.)";
				} else {
					if(nullToBlank(cancelJtbDl) != '') {	
						cancelTxt = " 취소 마감일 : "  + cancelJtbDl + "까지";
						cancelTxt2= " (토,일요일 및 법정 공휴일 제외)";
					}
				}
				if(cancelTxt != '') star = '*';
				vHtml = star + '<span style="font-weight:bold; color: red;">' + cancelTxt + '</span>' + cancelTxt2;
	       			
			}  
			$('#cancelDl').html(vHtml);
		}
		
	});
</script>



<div class='clause_box'>
	 <ul>
       <li class="st_re01" ft-att="cancelTxt"></li>
	       <li id='cancelDl'>
	       		<span style="font-weight:bold; color: red;">취소마감일 : 2017년 08월 21일 16시</span>
	       		 "까지 (토,일요일 및 법정 공휴일 제외)"
	       </li> 
           <li>* 모든 호텔 예약의 취소 요청은 롯데JTB를 통해서만 이루어져야 합니다. </li>
           <li>* 취소규정은 각 요금 별로 상이하며, 상품별 정확한 취소 일자와 수수료는 각 상품 예약 시 동의하신 규정에 따릅니다.</li>
           <li>* 예약 완료 후, 현지 사정/박람회/성수기 등의 특별 행사에 의해 취소 규정이 변동될 수 있는 점 양해 부탁 드립니다. </li>
           <li>* 예약과 동시에 취소/변경이 불가한 상품의 경우 호텔에서 지정한 특별규정을 따르며 사전 안내 후 규정 변경이 될 수 있습니다.</li>
           <li>* 취소마감일이 지난 상품을 예약하실 경우에는 예약과 동시에 결제가 이루어집니다.(카드 결제만 가능)</li>
           <li>* 취소마감일이 지난 상품에 대하여 미결제일 경우에는 자동 취소 됩니다.</li>
           <li>* 취소 마감일 이전 : 취소수수료 부과되지 않으며 무료 취소 가능합니다. </li>
           <li>* 취소 마감일 이후 : 결제전액 취소 수수료 부과 되어 환불 불가합니다. </li>
           <li>* 변경/취소/환불 불가 규정 : 예약 및 결제완료 후에는 변경/취소/환불 불가합니다. 변경/취소 시 수수료는 결제전액 입니다. </li>
           <li>* 체크인 당일(혹은 이후) 변경/취소 또는 No-Show : 결제전액 수수료로 부과되어 환불 불가합니다.</li>
           <li>* 시스템 변경/취소 불가 조건 요금은 예약확정과 동시에 전일정 변경/취소/환불 불가합니다.</li>
   </ul>
</div>




<!-- <script type="text/javascript">

  $(document).ready(function() {	
	  fn_cancelPolicy();
  });
  
  function fn_cancelPolicy() {
	 var vHtml = '';
		 
	 if(nullToBlank(sessionStorage.hotelBasketData) != '' && sessionStorage.hotelBasketData != '[]')
		 var data = JSON.parse(sessionStorage.hotelBasketData);
	 
	     console.log(data);
	 
		 if(nullToBlank(data) != '') { 		
	 
			 vHtml += '<div class=clause_box>';
			 
			 vHtml += '<p class="clause_tit mgt5 tc" style="text-align:left">* 취소 규정 유의사항</p>';
		 	 vHtml +=' <div class="clause_txt">'+ data[0].setRoomData[0].rateInfos[0].cancellationPolicy +'</div>';
	
	  		 $('#cancel').html(vHtml);	
		 }
  }
  
</script>
<div id="cancel">
</div> -->
<!-- 
<div class=clause_box>
	<p class="clause_tit mgt5 tc">
		최종 취소 가능일<br>2016-12-12 16:00까지 취소 가능.
	</p>
	<p class="clause_tit mgt5">※ 본 요금은 예약변경이 불가 합니다. (투숙일자, 부분취소, 투숙객이름
		등)</p>
	<div class="clause_txt">예약변경이 예상되시는 분은 다른 조건의 요금으로 예약하시기 바랍니다.</div>
	<p class="clause_tit mgt5">※ 취소위약금 발생조건</p>
	<div class="clause_txt">
		<ul class="dotlist2">
			<li>상기에 명시된 최종 취소 가능일 전 취소 : 위약금없음</li>
			<li>상기에 명시된 취소 가능일 이후 취소 : 일부 또는 전체요금에 해당되는 위약금 부과 (예약확정서에 표기된
				규정을 기준)</li>
		</ul>
	</div>
</div>
 -->