<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_car_list.jsp
	// 설명 : 차량종류
%>

<script type="text/javascript">
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){

	// 초기화
	var fn_init = function() {
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

		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});
</script>

<div class="layerPopup">
	<div class="layerPop bgwhite">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">차량종류</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain pop_acdonbox">
				<dl class="ft_acdon ft_acdon1 pop_acdon1">
					<dt class="on">Green Collection</dt>
					<dd>차량을 예약하시고 환경도 보존하십시오. Green Collection 차량에는 연료 효율이 뛰어나며 환경
						친화적인 차량들이 포함되어 있습니다. Green Collection 차량은 미국, 캐나다, 호주, 유럽에서 이용
						가능합니다. 제조회사와 모델을 지정하여 예약이 가능합니다.</dd>
					<dt>Green Traveler Collection</dt>
					<dd>차량 이용과 더불어 환경도 보존하십시오. Hertz Green Collection 차량은 연료 효율이
						좋으며 환경친화적인 차량들로 구성되어 있습니다. 미국과 캐나다에서 이용 가능하며 제조회사와 모델을 지정하여 예약할 수
						있습니다.</dd>
					<dt>Adrenaline Collection</dt>
					<dd>Hertz Adrenaline Collecton ™은 미국에서 이용이 가능하며 Chevy Camaro
						SS, Ford Mustang GT Premium 과 Dodge Challenge RT와 같은 특별하고 인기가 높고
						대단히 매력적이고 가슴을 설레게 하는 놀라운 성능을 자랑하는 차량들로 구성되어 있습니다. 60년대 & 70년대의 차량의
						특징인 힘과 과거의 클래식컬한 자동차 경주용의 유명 소형 자동차들을 연상시키는 현대적인 바디라인과 색감 & 디자인이
						접목시킨 새로운 모델들입니다. 제조회사와 모델을 지정하여 예약할 수 있습니다 -- 예약한 차량으로 바로 이용이
						가능합니다. 미국의 Adrenaline 차량에는 SIRIUS XM 위성 라디오가 장착되어 있습니다. 유의사항: 상기
						차량은 만 25세 이상의 운전자만 이용이 가능합니다. 모든 영업소에서 모든 차량이 이용가능한 것은 아닙니다.
						Collection 차량은 사전예고없이 변경될 수 있습니다. SIRIUS XM은 SIRIUS XM Radio Inc의
						등록상표입니다.</dd>
					<dt>Fun Collection</dt>
					<dd>
						Hertz Fun Collection® 차량에는 독특하고 재미있는 모양의 컨버터블, 쿠페 및 SUV 차량들이 포함되어
						있습니다. Fun Collection 차량은 제조회사와 모델을 지정하여 예약이 가능하므로 예약한 차량 모델을 실제로
						이용할 수 있습니다. <br> <br> 유럽의 경우 Fun Collection 차량에
						NeverLost® 네비게이션 시스템을 추가로 대여할 수 있으며 미국의 경우 Fun Collection 차량에
						SIRIUS® 또는 XM® 위성라디오가 장착되어 있습니다 <br> <br> 모든 차량이 모든
						영업소에서 이용 가능한 것은 아닙니다. 안내된 Collection 차량 모델은 사전예고 없이 변경될 수 있습니다.
					</dd>
					<dt>Prestige Collection</dt>
					<dd>
						미국, 캐나다, 유럽과 호주에서는 고급스럽고 뛰어난 성능을 자랑하는 Prestige Collection 차량은
						제조회사와 모델을 지정하여 예약이 가능합니다. 미국과 캐나다에서는 차량에 NeverLost® 네비게이션 시스템 및
						SIRIUS® 또는 XM® 위성라디오가 장착되어 있습니다. Prestige Collection 차량의 임차 가능 연령은
						만 25세 이상(예외 적용)입니다. <br> <br> 모든 차량이 모든 영업소에서 이용 가능한 것은
						아닙니다. 안내된 Collection 차량 모델은 사전예고 없이 변경될 수 있습니다.
					</dd>
					<dt>Compact/Midsize</dt>
					<dd>
						일반적으로 2/4 도어이며 4~5명이 탑승할 수 있습니다. <br> <br> 수하물은 최대 3개의
						가방을 실을 수 있습니다 (단, 가방의크기와 차량의 크기에 따라 다를 수 있습니다)
					</dd>
					<dt>Fullsize/Standard</dt>
					<dd>상기 차량은 일반적으로 4 도어 차량으로 성인 4-5인 탑승, 최대 4-5 개의 수하물 탑재가
						가능합니다. (탑재 가능한 수하물 갯수는 수하물의 크기의 차량 모델에 따라 다를 수 있습니다).</dd>
					<dt>Premium</dt>
					<dd>상기 premium 및 luxury 차량은 일반적으로 2-4 도어 차량으로 4-5인 탑승, 최대 4/5
						개의 수하물 탑재가 가능합니다.(탑재 가능한 수하물 갯수는 수하물의 크기의 차량 모델에 따라 다를 수 있습니다).</dd>
					<dt>SUV/Minivan</dt>
					<dd>SUV 차량은 2WD, 4WD, AWD와 All-Terrain (모든 지형 운행가능) 차량으로 구성되어
						있습니다. 2-4도어 차량으로 성인 5-7인 탑승, 최대 4 개의 수하물 탑재가 가능합니다. (탑재 가능한 수하물
						갯수는 수하물의 크기의 차량 모델에 따라 다를 수 있습니다). Minivan은 최대 7-15인 탑승, 최대 8-10
						개의 수하물 탑재가 가능합니다. (탑재 가능한 수하물 갯수는 수하물의 크기의 차량 모델에 따라 다를 수 있습니다).</dd>
					<dt>Convertible</dt>
					<dd>컨버터블 차량 (soft 혹은 hard top)은 2-4도어 차량으로 성인 4-5인 탑승, 최대 3 개의
						수하물 탑재가 가능합니다. (탑재 가능한 수하물 갯수는 수하물의 크기의 차량 모델에 따라 다를 수 있습니다.</dd>
				</dl>
			</div>

		</div>
		<!-- 내용끝 -->
		<div class="popFoot">
			<div class="layerBtns">
				<button type="button" class="layerClose1">확인</button>
			</div>
		</div>
	</div>
</div>