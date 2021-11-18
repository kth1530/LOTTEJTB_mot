<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<script>
	function fn_htlRsvCancel(fitRsvNo){
		
		var cancelYN = calTimeGap('arr');   //[JEH] 추가 20180112
		if(cancelYN == '환불불가'){
			alert('무료취소기한이 지난 호텔이 포함되어있어 예약을 취소 할 수 없습니다.');
			window.location.reload();
			return;
		}else{
			var info = fn_rtnActInfo('rtnForm'); //[JEH] 환불계좌정보 check
					
			if(info){
	
				var rfdBankCd = $("select[name=rfdBankCd]").val();
				var rfdActNo = $("#rfdActNo").val();
				
				setConfirm("호텔 예약 취소하시겠습니까?", function() {
					var formData = new FormData();
					formData.append("fitRsvNo", fitRsvNo);
	
					//환불계좌정보 append
					formData.append("rfdBankCd", rfdBankCd);
					formData.append("rfdActNo", rfdActNo);
					
					gfn_loading_bar_draw3('show');
					
					setTimeout(function(){
						cfn_ajax({
							type : "POST",
							async : false,
							url: "/fit/rsv/fitReserveHtlCancel.do",
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

									//TOS 취소 연동
									if(devType == 0) {
										//console.log("예약취소 tos연동---start");
										document.location.href="http://fitdev.lottejtb.com/tos/sendCancelDataAjax.do";
										//console.log("예약취소 tos연동---end");
									}else
										document.location.href="https://fit.lottejtb.com/tos/sendCancelDataAjax.do";
									
									history.back();
									/*
									var cancelFormData = {
										"fitRsvNo" : fitRsvNo
									}	        		
									gfn_callAjax ('https://fit.lottejtb.com/fit/rsv/paymentCancelAjax.do', cancelFormData, 'successReserve');
									*/
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
				} , function() {
					return false;
				}, "알림","확인","취소");
			}
		}
	}
	
	function successCancel(_data){
		console.log(_data);
		
		//history.back();
	}
</script>

<p class="pop_htvtitle">호텔</p>
<div id = 'htl_reserve_info'>
	<!-- <dl class="pop_info_list">
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
	</dl> -->
</div>
<!-- <dl class="pop_info_list">
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
</dl> -->
<p class="txbox4">(TAX, 봉사료 포함)</p>
<ul class="txbox2">
	<li>예약 후 호텔변경, 박수변경, 일정변경 불가하며 변경을 원하실 경우 취소 후 재 예약 하셔야 합니다.</li>
</ul>
<!-- <div id="rtnForm"></div> -->
<!-- div class="btn_one air_tbtn" id="btn_htl_cancel">
 	<button class="purple2" data-role="none" onClick="fn_htlRsvCancel('${rsvResult.getFitRsvNo()}')">호텔 예약취소</button>
</div> -->