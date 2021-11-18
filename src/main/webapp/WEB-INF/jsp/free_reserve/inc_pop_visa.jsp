<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : inc_pop_visa.jsp
	// 설명 : 예약확인 > VISA 안내
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

<div id="popVisaPop">
    <div class="layerPopup2">
        <div class="layerPop2">
            <!-- 내용시작 -->
            <div class="popCon">
                <div class="popHead">
                    <div class="popTpart">
                        <strong class="popTitle">주의! VISA 안내</strong>
                        <button type="button" class="layerClose">
                            <img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
                        </button>
                    </div>
                </div>
                <div class="cntain pop_basebox tc">
                    <p class="pop_red_txt">주의! VISA가 필요한 국가입니다.</p>

                    선택하신 도시는 VISA가 반드시 필요한 곳입니다. 아래 사항을 점검해 주십시오. <br>
                    <br> 1.VISA 필요 여부를 반드시 점검해 주시기 바랍니다.<br> 2.VISA의 유효기간을 반드시
                    확인해 주시기 바랍니다.
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
</div>