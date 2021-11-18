<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">
	$('document').ready(function(){
		switch(location.pathname){
		case '/customer/noticeList.do':
			$('.radiobox').removeClass('on');
			$("#radiobox_notice").addClass('on');
			
			break;
		case '/customer/faq.do' :
			$('.radiobox').removeClass('on');
			$("#radiobox_faq").addClass('on');
			
			break;
		case '/customer/qnaList.do' :
		case '/customer/qnaWrite.do' :
			$('.radiobox').removeClass('on');
			$("#radiobox_qna").addClass('on');
			
			break;
		case '/customer/coupon.do' :
			$('.radiobox').removeClass('on');
			$("#radiobox_coupon").addClass('on');
			
			break;
		case '/corperate/corperate_lpoint.do' :
			$('.radiobox').removeClass('on');
			$("#radiobox_lpoint").addClass('on');
			
			break;
		}
	});
	
	$(".dateRadio").click(function(){
		switch($(this).val()){
		case '01' :
			moveMenu("/customer/noticeList.do", 1);
			break;
		case '02' :
			moveMenu("/customer/faq.do", 1);
			break;
		case '03' :
			moveMenu("/customer/qnaList.do", 1);
			break;
		case '04' :
			moveMenu("/customer/coupon.do", 1);
			break;
		case '05' :
			moveMenu("/corperate/corperate_lpoint.do", 1);
			break;
		}
	});
	
	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
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
						<strong class="popTitle">고객센터</strong>
						<button type="button" class="layerClose"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></button>
					</div>
				</div>
				<div class="cntain">
					<ul class="selectpop_radio">
						<li><span class="radiobox" id="radiobox_notice"><input type="radio" class="dateRadio" name="radio" id="radio0" value="01"></span><label for="radio0">공지사항</label></li>
						<li><span class="radiobox" id="radiobox_faq"><input type="radio" class="dateRadio" name="radio" id="radio1" value="02"></span><label for="radio1">자주찾는질문</label></li>
						<li><span class="radiobox" id="radiobox_qna"><input type="radio" class="dateRadio" name="radio" id="radio2" value="03"></span><label for="radio2">묻고답하기</label></li>
						<li><span class="radiobox" id="radiobox_lpoint"><input type="radio" class="dateRadio" name="radio" id="radio4" value="05"></span><label for="radio4">L.POINT 안내</label></li>
						<li><span class="radiobox" id="radiobox_coupon"><input type="radio" class="dateRadio" name="radio" id="radio3" value="04"></span><label for="radio3">상품권/쿠폰</label></li>
					</ul>
				</div>
				
			</div>
			<!-- 내용끝 -->
			<div class="popFoot">
				<div class="layerBtns"><button type="button" class="layerClose1" onclick="closePopup()">확인</button></div>
			</div>
	    </div>
	</div>
</body>