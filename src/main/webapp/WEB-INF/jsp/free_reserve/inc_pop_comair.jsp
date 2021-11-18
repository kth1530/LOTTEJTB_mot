<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : inc_pop_comair.jsp
	// 설명 : 예약확인 > 공동운행편 안내 
%>

<script type="text/javascript">
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){

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

<div id="popCommAirPop">
    <div class="layerPopup">
        <div class="layerPop">
                <!-- 내용시작 -->
                <div class="popCon"> 
                    <div class="popHead">
                        <div class="popTpart">
                            <strong class="popTitle">공동운항편 안내</strong>
                            <button type="button" class="layerClose"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></button>
                        </div>
                    </div>
                    <div class="cntain">
    항공사간 제휴로 <span class="f_purple">[홍차오-홍콩]</span>구간의 실제탑승은 <span class="f_purple">[[상해항공]</span>항공기로 운항하는 공동운항편입니다.<br>
    공동운항편의 운임은[상해항공] 항공사 구매 시의 <span class="f_purple">[운임과 다를 수 있습니다.</span><br>
    (운임 차이는 항공사로 검색하여 확인하시기 바랍니다)<br><br>
    수하물 규정은 공동운항 협정에 따라 운항 항공사 또는 판매 항공사의 규정이 적용되므로 사전에 확인하여 주시기 바랍니다.
                    </div>
                </div>
                <!-- 내용끝 -->
                <div class="popFoot pf2">
                    <div class="layerBtns"><button type="button" class="layerClose1 layerClose">취소</button></div>
                    <div class="layerBtns"><button type="button" class="layerClose2">확인</button></div>
                </div>
        </div>
    </div>
</div>