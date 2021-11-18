<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.net.*"%>
<%@ page import="com.lottejtb.util.*"%>
<%@ page import="com.lottejtb.goods.rn.service.*"%>
<%@ page import="com.lottejtb.comm.util.*"%>

<%
	List timeDifferCurrencyList = (List) request.getAttribute("timeDifferCurrencyList");
%>
<script>
	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}

	function fn_setCurrency(countryKnm) {
		fn_srchCurrency(countryKnm);
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
	if(timeDifferCurrencyList != null) {		
		for(int idx = 0; idx < timeDifferCurrencyList.size(); idx++) {
			RNTimeDifferCurrencyVO currencyVO = (RNTimeDifferCurrencyVO) timeDifferCurrencyList.get(idx);

%>						
					<li onClick="fn_setCurrency('<%=currencyVO.getCountryKnm()%>');"><span class="radiobox <%=(idx == 0)?"on":""%>"><input type="radio" name="radio" id="radio0" checked="checked"></span><label for="radio0"><%=currencyVO.getCountryKnm()%>-<%=currencyVO.getCityKnm()%></label></li>
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
