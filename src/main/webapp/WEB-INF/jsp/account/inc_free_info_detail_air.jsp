<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<script>
	function fn_GoAirPay(seqNo) {
		document.location.href='/free/account/pop_air_pay.do?seqNo=' + seqNo;
	}
	
	function fn_GoAirPayCancel(seqNo) {
		document.location.href='/free/account/pop_paycancel.do?seqNo=' + seqNo;
	}

	function fn_GoAirPassport(seqNo) {
		document.location.href='/free/account/pop_air_passport.do?seqNo=' + seqNo;
	}
	
	function fn_airRsvCancel(fitRsvNo){
		setConfirm("항공 예약 취소 하시겠습니까?", function() {
			var formData = new FormData();
			formData.append("fitRsvNo", fitRsvNo);
			
			gfn_loading_bar_draw3('show');
			
			setTimeout(function(){
				cfn_ajax({
					type : "POST",
					async : false,
					url: "/fit/rsv/fitReserveAirCancel.do",
					data: formData,
					dataType: "json",
					cache : false,
					noloading : false,
					timeOut : 5 * 60 * 1000,
					success: function(data) {
						result = data.result;
						
						gfn_loading_bar_draw3('hide');
						
						if(result.resultCode == 1){
							setAlert("예약취소 되었습니다.");
							history.back();
						}else{
							setAlert("예약취소를 실패했습니다. \n 다시 시도해 주세요.");
						}
					},
					error : function(err) {
						console.log(err);
					},
					complete : function(e) {
						gfn_loading_bar_draw3('hide');
					}
				});
			}, 500);
		}, function() {
			return false;
		}, "알림","확인","취소");
	}
	

</script>

<p class="pop_avtitle mt7">항공 (별도 결제)</p>
<!-- 간략안내 -->
<div class="stable_guide2" id='air_mst_info' name='air_mst_info'>

</div>
<!-- 항공 여정 정보 -->
<div id='air_itin_list' name='air_itin_list'>

</div>
<table class="ft_table2 ft_tb_tr">
	<colgroup>
		<col style="width: 30%" />
		<col style="width: 70%" />
	</colgroup>
	<tr>
		<th>인원</th>
		<td>성인 <span id='air_adt_cnt2' name='air_adt_cnt2'>0</span>명, 아동 <span id='air_chd_cnt2' name='air_chd_cnt2'>0</span>명, 유아 <span id='air_inf_cnt2' name='air_inf_cnt2'>0</span>명</td>
	</tr>
	<tr class="tb_purple">
		<th>항공 총 운임</th>
		<td colspan="3"><span id="payment_air3" name="payment_air3"></span></td>
	</tr>
</table>
<p class="txbox4">(유류할증료, 제세공과금 포함)</p>
<ul class="txbox2">
	<li>상기 요금은 유류할증료 및 제세공과금 포함한 총액요금이며, 유류할증료 및 제세공과금은 유가와 환율에 따라 변동
		가능합니다. 상기 요금에는 취급수수료가 포함되어 있지 않습니다.</li>
	<li>TAX 금액은 유류할증료 및 환율 변동에 의해 차이가 있으므로 예약완료 후에 정확한 요금을 확인하실 수
		있습니다. 경우에 따라 일부 항공사나 일부 구간의 TAX는 조회가 안될 수 있습니다.</li>
	<!-- li class="txbox2_none">※ 항공권은 예약 후 담당자가 개별적으로 연락 후 결제금액과 방법을 전달해드립니다.</li -->
</ul>

<div ft-att="air_certi_pop">
	<dl>
		<dd>
			<ul class="txbox2">
				<li>전체 여정에 <span>상이한 운임과 규정</span>이 적용되었습니다. </li>
				<li>각 운임 규정 중 가장 제한적인 규정이 적용됩니다. 상세 운임규정은 여행사 <span>예약 담당자를 통해서 재확인</span> 하시기 바랍니다.</li>
				<li>예) 다음 규정의 경우 더 제한적인 규정인 ‘10만원 징수 후 환불’이 적용됩니다. </li>
				<li>첫 번째 환불 규정 : 5만원 징수 후 가능<br>두 번째 환불 규정 : 10만원 징수 후 가능</li>
			</ul>
		</dd>
	</dl>
	<dl class="ft_acdon ft_acdon1 pop_acdon1" style="background:#fff; margin-bottom:10px; padding-bottom:0px;border-bottom: 1px solid #d1d1d6;" ft-att='certi_table_list'></dl>
</div>
<div class="btn_two air_tbtn addbtn2" id="btn_air_paygroup" name="btn_air_paygroup">
	<button id="btn_air_pay" name="btn_air_pay" class="purple2" data-role="none" onClick="fn_GoAirPay('${rsvResult.getFitRsvNo()}')">항공 결제요청</button>
	<button id="btn_air_paycancel" name="btn_air_paycancel"  class="purple2" data-role="none" onClick="fn_GoAirPayCancel('${rsvResult.getFitRsvNo()}')">항공 결제취소</button>
	<button id="btn_air_rsvcancel" name="btn_air_rsvcancel" class="purple2" data-role="none" onClick="fn_airRsvCancel('${rsvResult.getFitRsvNo()}')">항공 예약취소</button>
</div>

<div class="btn_one air_tbtn" id="btn_air_passport" name="btn_air_passport">
	<button id="btn_passport" name="btn_passport" class="purple2" data-role="none" onClick="fn_GoAirPassport('${rsvResult.getFitRsvNo()}')">항공 여권정보 등록</button>
</div>
