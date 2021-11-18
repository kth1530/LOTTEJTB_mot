<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_comair.jsp
	// 설명 : 예약확인 > 공동운행편 안내


%>
<script src="/resources/common/js/database.js"></script>
<script type="text/javascript">
	var jSessionID = '<%=request.getSession().getId()%>';

	function closePopup() {
		popStreetPop();
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}

	function init() {

		// 항공일정 
		// var arCnt = _obj;
		var air_fix_data_info = JSON.parse(sessionStorage.airSelData);
		var arDetailList = air_fix_data_info[0].segmentGroup;

		
		var codeShareNm;
		for(var d_idx=0; d_idx < arDetailList.length; d_idx++) {
			var arDetailInfo = arDetailList[d_idx];

			codeShareNm = arDetailInfo.codeShareNm; 

			console.log("codeShareNm : " + codeShareNm);
		}

		var airSummary = JSON.parse(sessionStorage.airViewData).bodyDto;

		var html = "";
		html = html + "	항공사간 제휴로 <span class='f_red'>["+airSummary.availGroup[0].depNm+"-"+airSummary.availGroup[0].arrNm+"]</span>구간의 실제탑승은"; 
		html = html + "	<span class='f_red'>[["+codeShareNm+"]</span>항공기로 운항하는 공동운항편입니다.<br> 공동운항편의";
		html = html + "	운임은["+codeShareNm+"] 항공사 구매 시의 <span class='f_purple'>[운임]과 다를 수 있습니다.</span><br>";
		html = html + "	(운임 차이는 항공사로 검색하여 확인하시기 바랍니다)<br>";
		html = html + "	<br> 수하물 규정은 공동운항 협정에 따라 운항 항공사 또는 판매 항공사의 규정이 적용되므로 사전에 확인하여";
		html = html + "	주시기 바랍니다.";
		
		$("#commair").html(html);
	}
	init();
</script>

<div class='layerPopup'>
	<div class="layerPop">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">공동운항편 안내</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"
							onClick="closePopup()">
					</button>
				</div>
			</div>
			<!-- 공동운항편 안내 메세지 부분 -->
			<div class="cntain" id="commair" name="commair">
			</div>
			<!-- 공동운항편 안내 메세지 부분 -->
		</div>
		<!-- 내용끝 -->
		<div class="popFoot pf1">
			<!-- 
			<div class="layerBtns">
				<button type="button" class="layerClose1 layerClose"
					onClick="closePopup()">취소</button>
			</div>
			 -->
			<div class="layerBtns">
				<button type="button" class="layerClose2" onClick="closePopup()">확인</button>
			</div>
		</div>
	</div>
</div>