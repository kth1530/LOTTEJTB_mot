<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 파일명 : pop_cart.jsp
	// 설명 : 찜하기 완료 팝업
%>

<script>
	if (fn_chkLogin() == 1) {
		document.write('	<div data-role="popup" id="favoPop" class="ui-content" data-overlay-theme="b" data-position-to="window">');
		document.write('			   <div data-role="header" >찜하기</div>');
		document.write('			<div data-role="content" >');
		document.write('		            <p>선택한 여행상품을 찜하기에 담았습니다.</p>');
		document.write('		            <span>찜!여행상품 목록에서 확인하시겠습니까?</span>');
		document.write('		        </div>');
		document.write('			<div data-role="footer" ><a href="#" data-rel="back" class="ui-btn align-c">계속여행</a><a href="#" onClick="fn_goMyTour()" class="ui-btn align-c point">목록확인</a></div>');
		document.write('		 </div>');

	} else {

	}
</script>

