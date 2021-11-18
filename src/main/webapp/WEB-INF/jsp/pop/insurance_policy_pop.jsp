<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">
	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}
	
	$(document).ready(function(){
		fn_resize();
	});
	
	$(window).resize(fn_resize);
	
	function fn_resize(){
		var h = $(".layerPopup").outerHeight();
		$("#ifr_insu").attr("height", h-130);
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
						<strong class="popTitle">해외여행보험 약관</strong>
						<button type="button" class="layerClose"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></button>
					</div>
				</div>
				<div class="cntain" style="margin:0px;">
					<iframe id="ifr_insu"  src="/pdf/web/viewer.html?file=/pdf/insurance_policy.pdf" width="100%" height="100%"></iframe>
				</div>
				
			</div>
			<!-- 내용끝 -->
			<div class="popFoot">
				<div class="layerBtns"><button type="button" class="layerClose1" onclick="closePopup()">확인</button></div>
			</div>
	    </div>
	</div>
</body>