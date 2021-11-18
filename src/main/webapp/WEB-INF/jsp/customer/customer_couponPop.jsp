<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="/resources/common/js/html2canvas.js"></script>
	<script src="/resources/common/js/utils.js"></script>
	<script src="/resources/common/header.js"></script>
	<script src="/resources/common/js/download.js"></script>
</head>
<script>
	var param = location.hash.split("#");
	var txt1 = decodeURI(param[1]);
	var txt2 = decodeURI(param[2]);
	var imgNum = decodeURI(param[3]);
	var clickYn = true;
	
	$(document).ready(function(){
		$("#opt1").text($("#opt1").text() + txt1);
		$("#opt2").text($("#opt2").text() + txt2);
		
		if(imgNum == "1"){
			$("#img").attr("src", "/resources/images/bg/couponPop2019092501.jpg");
			$("#img").attr("alt", "롯데면세점 1만원");
			$("#title").text("면세점");
			//downImg(String url, String userAgent, String contentDisposition, String mimetype, long contentLength)
// 			$("#imageDown").attr("onclick", "window.js.downImg('http://mdev.lottejtb.com/resources/images/bg/couponPop2019092501.jpg', 'webview', 'coupon.jpg', 'image/jpg', '0')");
			$("#imageDown").attr("onclick", "window.js.downImg('http://m.lottejtb.com/resources/images/bg/couponPop2019092501.jpg', 'webview', 'coupon.jpg', 'image/jpg', '0')");
		}else if(imgNum == "2"){
			$("#img").attr("src", "/resources/images/bg/couponPop20191223.jpg");
			$("#img").attr("alt", "환율우대쿠폰");
			$("#title").text("우리은행 환율우대쿠폰");
// 			$("#imageDown").attr("onclick", "window.js.downImg('http://mdev.lottejtb.com/resources/images/bg/couponPop2019092502.jpg', 'webview', 'coupon.jpg', 'image/jpg', '0')");
			$("#imageDown").attr("onclick", "window.js.downImg('http://m.lottejtb.com/resources/images/bg/couponPop20191223.jpg', 'webview', 'coupon.jpg', 'image/jpg', '0')");
			
		}
		
	});
</script>
<style>
.ui-dialog-contain {
    max-width: 100% !important;
}
</style>
<body>
	<div data-role="page" data-dialog="true" data-overlay-theme="b" data-close-btn="right"  class="ui-nodisc-icon ui-alt-icon" id="couponPop">
		<div data-role="header" data-theme="a"><h1 id="title">면세점</h1></div>
		<div role="main" class="ui-content" data-theme="a" id="mainCoupon">
			<div class="img" style="text-align: center;">
				<img id="img" src="/resources/images/bg/customer_coupon_pop_20190925.jpg" alt="롯데면세점 1만원"/>
			</div>
			<div class="cntBox">
<!-- 				<span id="opt1">증정기간 : </span> -->
<!-- 				<span id="opt2">대상점 : </span> -->
				<span id="opt1"></span>
				<span id="opt2"></span>
			</div>	
		</div>
		<div data-role="footer" data-theme="a" >
			<button id="imageDown" onclick = "">이미지다운로드</button>
		</div>
	</div>
</body>		
</html>