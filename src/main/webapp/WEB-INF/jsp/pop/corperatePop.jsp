<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">
	$('document').ready(function(){
		switch(location.pathname){
		case '/corperate/corperate.do':
			$('#popTitleText').html('회사소개');
			$('.radiobox').removeClass('on');
			$("#radiobox_1").addClass('on');
			
			break;
		case '/corperate/corperate_info.do' :
			$('#popTitleText').html('법인상용');
			$('.radiobox').removeClass('on');
			$("#radiobox_2").addClass('on');
			
			break;
		case '/corperate/corperate_lpoint.do' :
			$('#popTitleText').html('L.point 회사소개');
			$('.radiobox').removeClass('on');
			$("#radiobox_3").addClass('on');
			
			break;
		case '/shop/shopList.do' :
			$('#popTitleText').html('매장안내');
			$('.radiobox').removeClass('on');
			$("#radiobox_4").addClass('on');
			
			break;
		}
	});
	
	$(".dateRadio").click(function(){
		switch($(this).val()){
		case '01' :
			setTimeout(function(){
				moveMenu("/corperate/corperate.do", 1);
			}, 50);
			break;
		case '02' :
			setTimeout(function(){
				moveMenu("/corperate/corperate_info.do", 1);
			}, 50);
			break;
		case '03' :
			setTimeout(function(){
				moveMenu("/corperate/corperate_lpoint.do", 1);
			}, 50);
			break;
		case '04' :
			setTimeout(function(){
				moveMenu("/shop/shopList.do", 1);
			}, 50);
			break;
		}
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
						<strong class="popTitle" id="popTitleText"></strong>
						<button type="button" class="layerClose"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></button>
					</div>
				</div>
				<div class="cntain">
					<ul class="selectpop_radio">
						<li><span class="radiobox" id="radiobox_1"><input type="radio" class="dateRadio" name="radio" id="radio0" value="01"></span><label for="radio0">회사소개</label></li>
						<li><span class="radiobox" id="radiobox_2"><input type="radio" class="dateRadio" name="radio" id="radio1" value="02"></span><label for="radio1">법인상용</label></li>
<!-- 						<li><span class="radiobox" id="radiobox_3"><input type="radio" class="dateRadio" name="radio" id="radio2" value="03"></span><label for="radio2">L.point 회사소개</label></li> -->
						<li><span class="radiobox" id="radiobox_4"><input type="radio" class="dateRadio" name="radio" id="radio3" value="04"></span><label for="radio3">매장안내</label></li>
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