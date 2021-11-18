<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_street.jsp
	// 설명 : 예약확인 > 미주노선 안내
%>

<script type="text/javascript">
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
					<strong class="popTitle">미주노선안내</strong>
					<button type="button" class="layerClose" onClick="closePopup()">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain">
				미주 출/도착편 예약/발권 시, 반드시 출발 72시간 전까지 승객의 정확한 여권정보를 필수 입력해야 하며, 해당 정보는
				변경 불가합니다.<br> 승객의 정보는 출발 72시간 전에 미국 교통 안전국(TSA)에 제출되어야 하고, 부정확한
				정보 제공의 경우, 탑승에 제약을 받을 수 있습니다.
			</div>
		</div>
		<!-- 내용끝 -->
		<div class="popFoot">
			<div class="layerBtns">
				<button type="button" class="layerClose1" onClick="popVisaPop();closePopup();">확인</button>
			</div>
		</div>
	</div>
</div>