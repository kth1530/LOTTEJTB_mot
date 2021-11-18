<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_visa.jsp
	// 설명 : 예약확인 > VISA 안내
%>
<script src="/resources/common/js/fit/reserve.js"></script>
<script type="text/javascript">
function closePopup2() {
	if(nullToBlank(sessionStorage.hotelBasketData) != "" && sessionStorage.hotelBasketData != '[]'){
		opener.location.href = "/free/account/pay_free.do";
	}else{
		fn_saveAirReserve();
	}

	jQuery('html, body').css({'overflow':'auto'});
	if(jQuery('.layerPopup').size()){
		jQuery('.layerPopup').remove();                 
	};              
	// opener.focus();		
}

</script>

<div class="layerPopup2">
	<div class="layerPop2">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">주의! VISA 안내</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"
							onClick="closePopup2()">
					</button>
				</div>
			</div>
			<div class="cntain pop_basebox tc">
				<p class="pop_red_txt">주의! VISA가 필요한 국가입니다.</p>

				선택하신 도시는 VISA가 반드시 필요한 곳입니다. 아래 사항을 점검해 주십시오. <br> <br>
				1.VISA 필요 여부를 반드시 점검해 주시기 바랍니다.<br> 2.VISA의 유효기간을 반드시 확인해 주시기
				바랍니다.
			</div>
		</div>
		<!-- 내용끝 -->
		<div class="popFoot">
			<div class="layerBtns">
				<button type="button" class="layerClose1"
					onClick="closePopup2()">확인</button>
			</div>
		</div>
	</div>
</div>