<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">
	var index = "${index}";
	
	if(dateVal == "02"){
		$(".radiobox").removeClass("on");
		$(".dateRadio").attr("checked", false);
		
		$("#radio1").attr("checked", "checked");
		$("#radio1").parent().addClass("on");
	}else if(dateVal == "03"){
		$(".radiobox").removeClass("on");
		$(".dateRadio").attr("checked", false);
		
		$("#radio2").attr("checked", "checked");
		$("#radio2").parent().addClass("on");
	}else if(dateVal == "04"){
		$(".radiobox").removeClass("on");
		$(".dateRadio").attr("checked", false);
		
		$("#radio3").attr("checked", "checked");
		$("#radio3").parent().addClass("on");
	}
	
	$(".dateRadio").click(function(){
		var textName = $(this).parent().parent().children().eq(1).text();
		fn_popClick($(this).val(), textName);
		
		jQuery("html, body").css({"overflow":"auto"});
		if(jQuery(".layerPopup").size()){
			jQuery(".layerPopup").remove();                 
		};
	});
</script>
</head>
<body>
	<div class="layerPopup">
	    <div class="layerPop">
			<!-- 내용시작 -->
	        <div class="popCon">
				<div class="popHead">
					<div class="popTpart">
						<strong class="popTitle">기간조회</strong>
						<button type="button" class="layerClose"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></button>
					</div>
				</div>
				<div class="cntain">
					<ul class="selectpop_radio">
						<li><span class="radiobox on"><input type="radio" class="dateRadio" name="radio" id="radio0" value="01" checked="checked"></span><label for="radio0">최근 1개월</label></li>
						<li><span class="radiobox"><input type="radio" class="dateRadio" name="radio" id="radio1" value="02"></span><label for="radio1">최근 3개월</label></li>
						<li><span class="radiobox"><input type="radio" class="dateRadio" name="radio" id="radio2" value="03"></span><label for="radio2">최근 1년</label></li>
						<li><span class="radiobox"><input type="radio" class="dateRadio" name="radio" id="radio3" value="04"></span><label for="radio3">전체</label></li>
					</ul>
				</div>
				
			</div>
			<!-- 내용끝 -->
			<div class="popFoot">
				<div class="layerBtns"><button type="button" class="layerClose1">확인</button></div>
			</div>
	    </div>
	</div>
</body>