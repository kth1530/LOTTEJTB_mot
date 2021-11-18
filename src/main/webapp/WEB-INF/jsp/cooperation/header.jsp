<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">

	// 초기화
	var fn_init = function() {
		$('.appt_downbox').css("height", "0px");
	};
			
	// 버튼 초기화
	var fn_initButton = function() {
	};
	
	$(document).ready(function(){
		fn_init();
		fn_initButton();
	});
	
</script>
</head>
<body>
<!--content-->    
	<div role="main" class="ui-content contentWrap">
		
		
		<!--bottom-->
		<!-- <script src="/resources/common/bottom.js"></script> -->
		<!--bottom-->
	</div>
	<!--//contentWrap End-->
</body>