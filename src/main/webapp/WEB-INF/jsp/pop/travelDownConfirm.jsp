<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script>
	var fn_travelDown = function(){
		location.href = "http://www.lottejtb.com/docs/insurance_policy.zip";
		
		jQuery("html, body").css({"overflow":"auto"});
		if(jQuery(".layerPopup").size()){
			jQuery(".layerPopup").remove();                 
		};
	}
</script>
</head>
<body>
	<div class="layerPopup">
	    <div class="layerPop">
			<!-- 내용시작 -->
	        <div class="popCon">
				<div class="popHead">
					<div class="popTpart">
						<strong class="popTitle">해외여행 약관다운</strong>
						<button type="button" class="layerClose"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></button>
					</div>
				</div>
				<div class="cntain">
					해외여행 약관파일을 <br/>다운로드 하시겠습니까?
				</div>
				
			</div>
			<!-- 내용끝 -->
			<div class="popFoot pf2">
				<div class="layerBtns"><button type="button" class="layerClose1 layerClose">취소</button></div>
				<div class="layerBtns"><button type="button" class="layerClose2" onclick="fn_travelDown();">확인</button></div>
			</div>
	    </div>
	</div>
</body>