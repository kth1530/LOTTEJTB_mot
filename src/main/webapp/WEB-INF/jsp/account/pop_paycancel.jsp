<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="expires" content="-1">
	<meta name="robots" content="all">
	<meta name="keywords" content="">
	<script src="/resources/common/js/UserAgent.js"></script>
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<title>롯데홀리데이</title>
	<link rel="stylesheet" href="/resources/common/css/common.css">
	<link rel="stylesheet" href="/resources/common/css/common2.css">
	<link rel="shortcut icon" type="image/x-icon" href="/resources/common/css/lottejtb.ico">
	<script src="/resources/common/js/jquery-latest.min.js"></script>
	<script src="/resources/common/js/common.js"></script>
	<script src="/resources/common/js/common2.js"></script>
	<script src="/resources/common/js/utils.js"></script>
	<script src="/resources/common/js/swiper.js"></script>
	<script src="/resources/common/js/library/jquery.anchor.js"></script>
	<script src="/resources/common/js/common_decorator.js"></script>
	<script src="/resources/common/js/common_decorator2.js"></script>
	<script src="/resources/common/js/utils.js"></script>
	<script>

		var listMst;
		var listAir;
		var listHtl;
		var listRnt;

		function fn_SelectRsv(seqNo) {

		}

		function fn_srchFreeRsv() {
			var freeReservFormData = new FormData();
			freeReservFormData.append('seqNo', '${rsvSeqNo}');

			cfn_ajax({
				type: "POST",
				async: false,
				url: "/free/account/srchFreeRsvAjax.do",
				data: freeReservFormData,
				dataType: "json",
				cache: false,
				noloading:"no",
				success: function(res) {
					listFree = res.list;
					
					
					listMst = listFree.mst;
					listAir = listFree.air;
					listHtl = listFree.htl;
					listRnt = listFree.rnt;
					
					var freeMstHTML = "";
					if(listMst != null) {
						for(var m = 0; m < listMst.length; m++){
							freeMstHTML = '예약코드 : '+ listMst[m].fitRsvNo +' / 예약일 : '+ listMst[m].rsvDt +'';
						}	
					}
					$('#payment_mst').html(freeMstHTML);	

					// 항공 예약 
					var idx = 0;
					var freeAirHTML = "";
					if(listAir != null) {
						for(var m = 0; m < listAir.length; m++){
							idx++;
							freeAirHTML = freeAirHTML + "					<ul class='payc_list'>";
							freeAirHTML = freeAirHTML + "						<li>";
							freeAirHTML = freeAirHTML + "							<p class='chkbox'>";
							if(listAir[m].itinShapeGb == "RT") { // 왕복 
								freeAirHTML = freeAirHTML + "								<span><input id='rsvAirSeqno1' name='rsvAirSeqno' type='checkbox' data-role='none' value='"+listAir[m].airRsvSeqno+"' onClick='fn_SelectRsv("+listAir[m].airRsvSeqno+")'></span> <label for='rsvSeqNo"+idx+"'>"+ listAir[m].depNm +' - '+ listAir[m].firstArrNm +' - '+ listAir[m].lastArrNm +"</label>";
							} else if(listAir[m].itinShapeGb == "OW") { // 편도
								freeAirHTML = freeAirHTML + "								<span><input id='rsvAirSeqno1' name='rsvAirSeqno'  type='checkbox' data-role='none' value='"+listAir[m].airRsvSeqno+"' onClick='fn_SelectRsv("+listAir[m].airRsvSeqno+")'></span> <label for='rsvSeqNo"+idx+"'>"+ listAir[m].depNm +' - '+ listAir[m].firstArrNm +"</label>";
							}
							freeAirHTML = freeAirHTML + "							</p>";
							freeAirHTML = freeAirHTML + "							<div class='pcl_guide'>";
							freeAirHTML = freeAirHTML + "								<span class='gray3'>취소가능</span>";
							freeAirHTML = freeAirHTML + "							</div>";
							freeAirHTML = freeAirHTML + "						</li>";
							if(listAir[m].itinShapeGb == "RT"){
								freeAirHTML = freeAirHTML + "						<li>출발 : "+ listAir[m].depDt +" / 귀국 : "+ listAir[m].lastArrDt +"</li>";
							} else if(listAir[m].itinShapeGb == "OW") { // 편도
								freeAirHTML = freeAirHTML + "						<li>출발 : "+ listAir[m].depDt +"</li>";

							}
							freeAirHTML = freeAirHTML + "						<li>";
							freeAirHTML = freeAirHTML + "							<p>";
							freeAirHTML = freeAirHTML + "								<em>"+ comma(listAir[m].totSaleAmt) +"</em>원";
							freeAirHTML = freeAirHTML + "							</p>";
							freeAirHTML = freeAirHTML + "						</li>";
							freeAirHTML = freeAirHTML + "					</ul>";

						}	
					}
					$('#free_list').append(freeAirHTML);	

					// 호텔 예약 
					/* idx = 0;
					var freeHtlHTML = "";
					
					if(listHtl != null) {
										
						for(var h = 0; h < listHtl.length; h++){
							idx++;
							
							console.log(listHtl[h]);
							
							var saleAmt = listHtl[h].saleAmt;
							var exchangeRate = parseFloat(listHtl[h].exchangeRate);
							
							
							//console.log(">>>>saleAmt=" + parseFloat(saleAmt));
							//console.log(">>>>exchgeRate=" + parseFloat(exchangeRate));
							
							
							if(nullToBlank(saleAmt) == "") saleAmt = 0;
							else
								saleAmt = Math.ceil(parseFloat(listHtl[h].saleAmt) * parseFloat(exchangeRate)); 
								
							freeHtlHTML = freeHtlHTML + "					<ul class='payc_list'>";
							freeHtlHTML = freeHtlHTML + "						<li>";
							freeHtlHTML = freeHtlHTML + "							<p class='chkbox'>";
							freeHtlHTML = freeHtlHTML + "								<span><input id='rsvHtlSeqNo"+idx+"' name='rsvHtlSeqNo' type='checkbox' data-role='none' value='${rsvSeqNo}' onClick='fn_SelectRsv(\"${rsvSeqNo}\")'></span> <label for='chk_cusm1'>"+ listHtl[h].htlNm + "</label>";
							freeHtlHTML = freeHtlHTML + "							</p>";
							freeHtlHTML = freeHtlHTML + "							<div class='pcl_guide'>";
							freeHtlHTML = freeHtlHTML + "								<span class='gray3'>취소가능</span>";
							freeHtlHTML = freeHtlHTML + "							</div>";
							freeHtlHTML = freeHtlHTML + "						</li>";
							freeHtlHTML = freeHtlHTML + "						<li>체크인 : "+ listHtl[h].checkinDt +" / 체크아웃 : "+ listHtl[h].checkoutDt +"</li>";
							freeHtlHTML = freeHtlHTML + "						<li>";
							freeHtlHTML = freeHtlHTML + "							<p>";
							freeHtlHTML = freeHtlHTML + "								<em>"+ comma(saleAmt) +"</em>원";
							freeHtlHTML = freeHtlHTML + "							</p>";
							freeHtlHTML = freeHtlHTML + "						</li>";
							freeHtlHTML = freeHtlHTML + "					</ul>";

						}	
					}
					$('#free_list').append(freeHtlHTML);	 */
					// 렌트카 예약 
					//idx = 0;
					//var freeRntHTML = "";
		/* 			if(listRnt != null) {
						for(var r = 0; r < listRnt.length; r++){
							var korAmt = (exchangeObj[listRnt[r].currencyCd] * parseFloat(listRnt[r].orgAmt)).toFixed();

							freeRntHTML = freeRntHTML + "					<ul class='payc_list'>";
							freeRntHTML = freeRntHTML + "						<li>";
							freeRntHTML = freeRntHTML + "							<p class='chkbox'>";
							freeRntHTML = freeRntHTML + "								<span><input id='rsvRntSeqNo"+idx+"' name='rsvRntSeqNo'  type='checkbox' data-role='none' value='${rsvSeqNo}' onClick='fn_SelectRsv(\"${rsvSeqNo}\")' readonly></span> <label for='rsvSeqNo"+idx+"'>"+ listRnt[r].carModelNm +"</label>";
							freeRntHTML = freeRntHTML + "							</p>";
							freeRntHTML = freeRntHTML + "							<div class='pcl_guide'>";
							freeRntHTML = freeRntHTML + "								<span class='red2'>취소불가능</span>";
							freeRntHTML = freeRntHTML + "							</div>";
							freeRntHTML = freeRntHTML + "						</li>";
							freeRntHTML = freeRntHTML + "						<li>인수 : "+ listRnt[r].pickupDt + " / 반납 : "+ listRnt[r].rtDt +"</li>";
							freeRntHTML = freeRntHTML + "						<li>";
							freeRntHTML = freeRntHTML + "							<p>";
							freeRntHTML = freeRntHTML + "								<span class='black_text1'><em>"+ comma(korAmt) +"</em>원 / </span><em>"+ comma(listRnt[r].orgAmt) + " " + listRnt[r].currencyCd +"</em>원";
							freeRntHTML = freeRntHTML + "							</p>";
							freeRntHTML = freeRntHTML + "						</li>";
							freeRntHTML = freeRntHTML + "					</ul>";

						}	
					} */
					// $('#free_list').append(freeRntHTML);	
				}
			});


		}

		function fn_RefundPay() {
			// 항공 예약이 있을 때만 
			console.log("listAir : " + listAir );
			console.log("listHtl : " + listHtl );
			console.log("listRnt : " + listRnt );
			
			if(listAir != null)  {

				// 항공 예약에 대해서 체크가 된 경우에만 
				if ($('input:checkbox[id="rsvAirSeqno1"]').is(":checked")) {
					var airRsvSeqno = $('input:checkbox[id="rsvAirSeqno1"]').val();
					var formData = new FormData();
					formData.append('resCd', '${rsvSeqNo}');	// 자유여행 예약 번호  
					formData.append('cancelYnAir', 'Y'); 	// 항공 결제 취소 여부 	

					formData.append('airRsvSeqno', airRsvSeqno);
					formData.append('acctor', '');
					formData.append('bankCdGb', '');
					formData.append('actNo', '');
					
					cfn_ajax({
						type: "POST",
						async: false,
						url: "/free/account/saveAirRefundMgtAjax.do",
						data: formData,
						dataType: "json",
						cache: false,
						noloading:"no",
						timeOut: (5*60*1000),
						success: function(res) {
							
						},
						error:function(err){
							//console.log(err);
							alert("결제 취소 요청이 등록되지 않았습니다.");
						},
						complete:function(){
							alert("결제 취소 요청이 등록 되었습니다.");
							history.back(-1);
						}
					});	
				} 
			}
			
			
			// 호텔 예약이 있을 때만 
			if(listHtl != null)  {
				
				 if($('input:checkbox[id="rsvHtlSeqNo1"]').is(":checked") == true) {
					
					var formData = new FormData();
					formData.append('resCd', '${rsvSeqNo}');	// 자유여행 예약 번호  
					formData.append('cancelYnHtl', 'Y'); 	// 호텔 취소여부
					
					cfn_ajax({
						type: "POST",
						async: false,
						url: "/free/account/payCancelReqAjax.do",
						data: formData,
						dataType: "json",
						cache: false,
						noloading:"no",
						timeOut: (5*60*1000),
						success: function(res) {
							
						},
						error:function(err){
							//console.log(err);
							alert("결제 취소 요청이 등록되지 않았습니다.");
						},
						complete:function(){
							alert("결제 취소 요청이 등록 되었습니다.");
							history.back(-1);
						}
					});	
				}
				
			}
		}

		$(document).ready(function() {
			fn_srchFreeRsv();
		});

	</script>

</head>	

<div class="lypopview">
    <div class="layerPop10">
		<!-- 내용시작 -->

		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">결제취소요청</strong>
					<button type="button" class="layerClose10" onclick="history.back(-1);"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></button>
				</div>
			</div>			
			<div class="cntain plpoint">
				<ul class="white2 dotlist2">
					<li>결제 취소를 요청하시면 해당 내용을 담당자가 확인 후 수수료, 프로모션 할인 등을 재계산 후 고객님의
						마이투어 > 예약 상세화면에서 재결제 버튼이 표시됩니다. 재결제 버튼을 통해 변경된 내용에 대한 결제를 진행 후 기존
						예약에 대한 결제 취소 처리 됩니다.</li>
					<li>기존 결제내역이 취소 처리되기까지 최대 3~5 일 (공휴일 제외) 정도 소요될 수 있습니다.</li>
					<li>L.pay로 결제한 예약은 부분취소가 되지 않으니 유의바랍니다.</li>
				</ul>
				<p class="obj_title2 obj_bg_wht payc_title">
					<span class="ico_exclamat" id="payment_mst" name="payment_mst"></span>
				</p>
				<!-- 자유 여행 예약 정보 -->
				<div id="free_list" name="free_list">
				</div>
				<!-- 자유 여행 예약 정보 -->
			</div>
		</div>
		<!-- 내용끝 -->
		<div class="pop_btn_one mt7"><button class="purple2" data-role="none" id="btnPayment" onClick="fn_RefundPay()">결제취소요청</button></div>
	</div>
</div>
</body>
</html>