<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.net.*"%>
<%@ page import="com.lottejtb.util.*"%>
<%@ page import="com.lottejtb.goods.rn.service.*"%>


<%
	RNGDSchdVO eventSchd = (RNGDSchdVO) request.getAttribute("rnGDSchd");

	if(eventSchd == null)
		eventSchd = new RNGDSchdVO();
%>

<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="expires" content="-1">
<meta name="robots" content="all">
<meta name="keywords" content="">
<script src="/resources/common/js/UserAgent.js"></script>
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<title>롯데홀리데이</title>
<link rel="stylesheet" href="/resources/common/css/swiper.min.css">
<link rel="stylesheet" href="/resources/common/css/common.css">
<link rel="stylesheet" href="/resources/common/css/common2.css">
<link rel="shortcut icon" type="image/x-icon" href="/resources/common/css/lottejtb.ico">
<script src="/resources/common/js/jquery-latest.min.js"></script>
<script src="/resources/common/js/common.js"></script>
<script src="/resources/common/js/common2.js"></script>
<script src="/resources/common/js/swiper.js"></script>
<script src="/resources/common/js/library/jquery.anchor.js"></script>
<script src="/resources/common/js/common_decorator.js"></script>
<script src="/resources/common/js/common_decorator2.js"></script>


<script>
	//한번만 실행하게 프로그램 조정 필요
	jQuery(function(){
		var gallery = new Swiper('.pop_travel_slider', {
			pagination: '.swiper-pagination',
			spaceBetween: 0,
			loop:true,
			autoplay: 2500,
			nextButton: '.swiper-button-next',
			prevButton: '.swiper-button-prev',
			followFinger: false,
			paginationType: 'fraction'
		});	
		var wh = jQuery(window).width();
		var hh = wh/100 * 60;
		jQuery(".pop_travel_slider .swiper-slide").css({"height":hh+"px"});
	});
	
	function fn_close() {
		window.close();
        // window.opener.location.reload();
	}
	
</script>

<div class="lypopview">
	<div class="layerPop10">
		<!-- 내용시작 -->
		<div class="popCon popCinfo">
			<!-- div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">관광지 정보</strong>
					<button type="button" class="layerClose10" onclick="fn_close();">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기" onclick="fn_close();">
					</button>
				</div>
			</div-->
			<div class="cntain cntain3">
				<p class="pop_avtitle">[<%=eventSchd.getSchd_det_clval()%>] <%=eventSchd.getSchd_det_cntn()%></p>
				<div class="swiper-container imgGallery pop_travel_slider"> 
					<div class="swiper-wrapper">
<%
	if(eventSchd.getD_imgs() != null) {
		String[] schdCdArr = eventSchd.getSchd_det_cd_val().split("[/]"); // 10/1/OT/SINN
		String[] dImgs = eventSchd.getD_imgs().split("[|]");
		String schd_cd = schdCdArr[0]; 
		String dir = "";
		if(schd_cd.equals("10")) {
			dir = "area";
		} else if(schd_cd.equals("20")) {
			dir = "food";
		} else if(schd_cd.equals("30")) {
			dir = "leisure";
		} else if(schd_cd.equals("40")) {
			dir = "festival";
		} else if(schd_cd.equals("50")) {
			dir = "shooping";
		}	

		String[] d_imgs = dImgs[0].split("[@]"); // 20150419105510_001.JPG@주롱새공원 앵무새|20150419105645_001.jpg@주롱새공원 홍학20150419105510_001.JPG@주롱새공원 앵무새|20150419105645_001.jpg@주롱새공원 홍학
		for(int ii = 0; ii < d_imgs.length; ii++) {
			String d_img = d_imgs[ii];
			d_img = d_img.replaceAll(".jpg", "_600.jpg");
			
			//String o_imagePath = "http://www.lottejtb.com/upload/common/areainfo/" + eventSchd.getD_country_cd() + "/" + eventSchd.getD_city_cd() +"/" + dir + "/" +  d_img;
			String o_imagePath = "/m_file/upload/common/areainfo/" + eventSchd.getD_country_cd() + "/" + eventSchd.getD_city_cd() +"/" + dir + "/" +  d_img;
%>
						<div class="swiper-slide">
							<img src="<%=o_imagePath%>" alt='<%=eventSchd.getD_knm()%>' />
						</div>
<%
		}
	}
%>						

					</div>
					<div class="swiper-pagination"></div>
					<div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div>
				</div>
				<div class="pop_travel_txt"><%=eventSchd.getD_detail_cnts1()%></div>
			</div>
		</div>
		<!-- 내용끝 -->
	</div>
</div>
</body>
</html>