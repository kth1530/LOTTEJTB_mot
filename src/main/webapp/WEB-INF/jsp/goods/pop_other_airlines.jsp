<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.net.*"%>
<%@ page import="com.lottejtb.util.*"%>
<%@ page import="com.lottejtb.goods.rn.service.*"%>
<%@ page import="com.lottejtb.comm.util.*"%>
<%
	// 파일명 : pop_other_airlines.jsp
	// 내용 : 다른 이용 항공사 보기 
	String eventCd = (String) request.getAttribute("eventCd");
	List rnEtMstList = (List) request.getAttribute("rnEtMstList");

%>
<script>

	function selectOtherAirLine(eventCd) {
		fn_goOtherAirLine(eventCd);
		closePopup();
	}

	function closePopup() {
		jQuery("html, body").css({"overflow":"auto"});
		if(jQuery(".layerPopup").size()){
			jQuery(".layerPopup").remove();                 
		};              
		opener.focus();		
	}	
</script>
<div class="layerPopup">
	<div class="layerPop">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">다른 이용항공 보기</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain">
				<ul class="selectpop_radio">
<%
	for(int idx = 0; idx < rnEtMstList.size(); idx++) {
		ETMstOtherAirLineVO otherAirLineVO = (ETMstOtherAirLineVO) rnEtMstList.get(idx);
		
		String trffKnm = otherAirLineVO.getTrff_knm();

		if(trffKnm == null || trffKnm.equals("")) otherAirLineVO.getStart_pyun();
		String airLines =  trffKnm + " (" + otherAirLineVO.getSel_txt() + ")";

%>
					<li><span class="radiobox <%=(otherAirLineVO.getEvent_cd().equals(eventCd)?"on":"")%>"><input type="radio" name="airLine" id="airLine<%=idx%>" checked="checked" onClick="selectOtherAirLine('<%=otherAirLineVO.getEvent_cd()%>')"></span>
					<label for="airLine<%=idx%>"><%=airLines%></label></li>
<%
	}
%>				
				</ul>
			</div>

		</div>
		<!-- 내용끝 -->
		<div class="popFoot">
			<div class="layerBtns">
				<button type="button" class="layerClose1" onClick="closePopup()">확인</button>
			</div>
		</div>
	</div>
</div>