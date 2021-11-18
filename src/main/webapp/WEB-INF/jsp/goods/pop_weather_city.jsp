<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.net.*"%>
<%@ page import="com.lottejtb.util.*"%>
<%@ page import="com.lottejtb.goods.rn.service.*"%>
<%@ page import="com.lottejtb.comm.util.*"%>
<%
	String schdId = (String) request.getAttribute("schdId");
	String eventCd = (String) request.getAttribute("eventCd");
	String dayCnt = (String) request.getAttribute("dayCnt");
	String weatDt = (String) request.getAttribute("weatDt");
	String cityKnm = (String) request.getAttribute("cityKnm");

	List weatherList = (List) request.getAttribute("weatherList");
%>

<script>
	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}

	function fn_setWeather(dayCnt, weatDt, cityKnm) {
		fn_srchWeatherInfo<%=dayCnt%>(dayCnt, weatDt, cityKnm);
		closePopup();
	}
</script>
<div class="layerPopup">
	<div class="layerPop">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">주요도시 선택</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain">
				<ul class="selectpop_radio">
<%
	if(weatherList != null) {		
		for(int idx = 0; idx < weatherList.size(); idx++) {
			RNWeatherVO weatherVO = (RNWeatherVO) weatherList.get(idx);

%>					
					<li onClick="fn_setWeather(<%=dayCnt%>,'<%=weatherVO.getWeatDt()%>' ,'<%=weatherVO.getCityKnm()%>');"><span class="radiobox <%=(cityKnm.equals(weatherVO.getCityKnm()))?"on":""%>"><input type="radio" name="radio" id="radio0" checked="checked"></span><label for="radio0"><%=weatherVO.getCountryNm()%>-<%=weatherVO.getCityKnm()%></label></li>
<%
		}
	}
%>
				</ul>
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
