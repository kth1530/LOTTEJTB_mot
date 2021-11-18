<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<script>
	function fn_rntRsvCancel(fitRsvNo){
		setConfirm("렌터카 예약 취소하시겠습니까?", function() {
			var formData = new FormData();
			formData.append("fitRsvNo", fitRsvNo);
			
			gfn_loading_bar_draw3('show');
	
			setTimeout(function(){
				cfn_ajax({
					type : "POST",
					async : false,
					url: "/fit/rsv/fitReserveRntCancel.do",
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
		} , function() {
			return false;
		}, "알림","확인","취소");
	}
</script>

<p class="pop_lcvtitle mt7">렌터카 (후불)</p>
<div id="rentcarInfo">
</div>
<p class="txbox4">(후불, 현지에서 현지 통화로 결제)</p>
<ul class="txbox2">
	<li>렌터카 금액은 금일 환율 기준이며, 현지에서 차량 인수 시 현지 화페로 지불 하셔야 합니다.</li>
</ul>

<div class="btn_one air_tbtn" id="btn_rnt_cancel">
	<button class="purple2" data-role="none" onClick="fn_rntRsvCancel('${rsvResult.getFitRsvNo()}')">렌트카 예약취소</button>
</div>
