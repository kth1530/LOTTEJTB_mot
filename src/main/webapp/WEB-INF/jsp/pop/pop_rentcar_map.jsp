<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_rentcar_map.jsp
	// 설명 : 렌트카 위치 보기
%>

<script type="text/javascript">
	var lat = '${lat}';
	var lng = '${lng}';

	// 초기화
	var fn_init = function() {
		var myLatLng = {
			lat : parseFloat(lat),
			lng : parseFloat(lng)
		};
	    
		var map = new google.maps.Map(document.getElementById('showMap'), {
			center : myLatLng,
			scrollwheel : false,
			zoom : 17
		});
		
		// Create a marker and set its position.
		var marker = new google.maps.Marker({
			position : myLatLng,
			map : map,
		    draggable: true,
		});
		
		marker.setMap(map);
		
		console.log(map);
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
	});
</script>


<div class="layerPopup">
	<div class="layerPop">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">위치보기</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain">
				<div id="showMap" style="width:100%;height:350px;"></div>
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