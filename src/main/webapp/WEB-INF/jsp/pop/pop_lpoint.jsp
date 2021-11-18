<script type="text/javascript">
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){

	// 초기화
	var fn_init = function() {
			   
        var date = new Date();

        var year  = date.getFullYear();
        var month = date.getMonth() + 1; // 0부터 시작하므로 1더함 더함
        var day   = date.getDate();
    
   		if (("" + month).length == 1) { month = "0" + month; }
        if (("" + day).length   == 1) { day   = "0" + day;   }
       
		$("#toDay").text(year + "-" + month + "-" + day);  
	           
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

		$("#closePopup").click(function(){
			
			var cardno	= $("#card1").val() + $("#card2").val() + $("#card3").val() + $("#card4").val();
			var pw	=	$("#PW").val();
			
			var formData = new FormData();
			formData.append('cardNo', cardno);
			formData.append('PW', pw);

			console.log("cardno:" + cardno);
			console.log("pw:" + pw);
			
			cfn_ajax({
				type : "POST",
				async : false,
				url: "/account/LPointAuthAjax.do",
				data: formData,
				dataType: "json",
				cache : false,
				noloading : "yes",
				timeOut : 5 * 60 * 1000,
				success: function(data) {
//					alert("code:" + data.code);											//리턴코드
//					alert("사용가능포인트" + data.remainPoint);
					if(data.code == "00"){
						$('#lpoint').val(parseInt(data.remainPoint)); // 사용가능 L.Point

						if(parseInt(data.remainPoint) > 0){
							$('#chk_ck30').prop("checked", true); 
						}
						
//						self.close();
					}else{
						alert("L.point 인증 실패");
					}
				},
				error : function(err) {
					alert("결제 도중 오류가 발생하였습니다.");
					console.log(err);
				},
				complete : function(e) {
					console.log(e);
				}
			}); 
			
			
		});
	});
</script>

<div class="layerPopup">
    <div class="layerPop">
			<!-- 내용시작 -->
	        <div class="popCon">
				<div class="popHead">
					<div class="popTpart">
						<strong class="popTitle">L.POINT</strong>
						<button type="button" class="layerClose"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></button>
					</div>
				</div>
				<div class="cntain plpoint">
					<ul class="white2 dotlist2">
						<li>고객님의 롯데멤버스카드 또는 롯데카드 번호를 입력해주세요.</li>
					</ul>					
					<ul class="pop_chk_list pop_chk_list2">
						<li>
							<table class="pop_table2 ft_th_tl ft_td_tl">
							<colgroup>
								<col style="width:35%" />
								<col style="width:65%" />
							</colgroup>
							<tbody>
								<tr>
									<th>사용가맹점</th>
									<td>롯데제이티비</td>
								</tr>
								<tr>
									<th>날짜</th>
									<td id="toDay"></td>
								</tr>
								<tr>
									<th colspan="2">카드번호 <em class="f_red">*</em> <span class="plp_text1">13~16자리 입력</span></th>
								</tr>
								<tr>
									<td colspan="2" class="tc">
									<input type="text" class="lpt_input" id="card1" />
									<input type="text" class="lpt_input" id="card2" />
									<input type="text" class="lpt_input" id="card3" />
									<input type="text" class="lpt_input" id="card4" />
									</td>
								</tr>
								<tr>
									<th colspan="2">L.point 비밀번호 <em class="f_red">*</em> <span class="plp_text1">6~8자리 입력</span></th>
								</tr>
								<tr>
									<td colspan="2" class="tc">
									<input type="password" class="lpt_input2" id="PW" />
									</td>
								</tr>
							</tbody>
						</table>
						</li>
					</ul>
					
					<dl class="pop_chk_list pop_chk_list2 mt7">
						<dt>이용안내</dt>
						<dd>
							<ul class="white2 dotlist2">
								<li>카드번호 입력란에는 소유하고 계신 롯데멤버스카드 또는 롯데카드 (신용카드) 번호를 입력해주시기 바랍니다.</li>
								<li>본인 명의의 카드로만 조회/사용이 가능합니다.</li>
								<li>L.POINT 비밀번호는 영/숫자 혼합 6~8자리 입니다. (신용카드 비밀번호 4자리와 별도입니다.)</li>
								<li>5회 이상 비밀번호 입력 오류 시, 새로운 비밀번호를 등록해 주셔야합니다.</li>
							</ul>
						</dd>
					</dl>
				</div>
			</div>
			<!-- 내용끝 -->
			<div class="popFoot">
				<div class="layerBtns"><button type="button" class="layerClose" id="closePopup">확인</button></div>
			</div>
    </div>
</div>