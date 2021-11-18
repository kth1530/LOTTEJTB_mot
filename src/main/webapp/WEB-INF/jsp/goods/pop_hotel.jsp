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
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDb3QbLpTEk_Pa-32zEyUABiheOLebzQyQ" async defer></script>
<script src="/resources/common/js/jquery.googlemap.js"></script>
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
					<strong class="popTitle">숙박 정보</strong>
					<button type="button" class="layerClose10" onClick="fn_close()">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기" onClick="fn_close();">
					</button>
				</div>
			</div -->
			<div class="cntain cntain3">
				<p class="pop_avtitle">
					[숙박정보] <%=eventSchd.getH_lodge_knm()%> <%if(eventSchd.getH_lodge_grade() != null && !eventSchd.getH_lodge_grade().equals("")){%><em class="f_purple"><%=eventSchd.getH_lodge_grade()%></em><%}%>
				</p>
				<div class="swiper-container imgGallery pop_travel_slider"> 
					<div class="swiper-wrapper">
<%
	if(eventSchd.getH_imgs() != null) {
		String[] dImgs = eventSchd.getH_imgs().split("[|]");

		for(int jj = 0; jj < dImgs.length; jj ++) {
			String[] h_imgs = dImgs[jj].split("[@]"); // 20150419105510_001.JPG@주롱새공원 앵무새|20150419105645_001.jpg@주롱새공원 홍학20150419105510_001.JPG@주롱새공원 앵무새|20150419105645_001.jpg@주롱새공원 홍학
			
			// http://www.lottejtb.com/upload/common/areainfo/MV/MLE/hotel/20141217120003_001.jpg
			//String h_imagePath = "http://www.lottejtb.com/upload/common/areainfo/" + eventSchd.getH_country_cd() + "/" + eventSchd.getH_city_cd() +"/hotel/" + h_imgs[0].replaceAll(".jpg", "_600.jpg");;		
			String h_imagePath = "/m_file/upload/common/areainfo/" + eventSchd.getH_country_cd() + "/" + eventSchd.getH_city_cd() +"/hotel/" + h_imgs[0].replaceAll(".jpg", "_600.jpg");;
%>	

						<div class="swiper-slide">
							<img src="<%=h_imagePath%>" alt="<%=eventSchd.getH_lodge_knm()%>"/>
						</div>
<%
		} // end for
	} // end if
%>

					</div>
					<div class="swiper-pagination"></div>
					<div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div>
				</div>
<%
	if(eventSchd.getH_hotel_desc() != null) {
%>
				<div class="pop_travel_txt"><%=eventSchd.getH_hotel_desc()%></div>
<%
	} else {
%>
				<div class="pop_travel_txt"></div>
<%
	}
%>
				<div class="pop_travel2_tb">
					<table class="pop_table2 pop_table2_left">
						<colgroup>
							<col style="width: 30%">
							<col style="width: 70%">
						</colgroup>
						<tbody>
							<tr>
								<th>홈페이지</th>
								<td><%=(eventSchd.getH_homepage_url() != null)?eventSchd.getH_homepage_url():""%></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><%=eventSchd.getH_phone_no()%></td>
							</tr>						
<%
// 추후 운영 데이타가 등록이 된 경우에  
// 구글 맵 및 하위 호텔 정보 표시 부분 개발이 추가적으로 필요함
// 2017.02.10

%>
							<tr>
								<th>주소</th>
								<td class="sd_tv_box"><div><%=eventSchd.getH_address()%></div>
									<button type="button" class="layerOpener sd_tv_map" data-url="/goods/pop_hotel_maps.do?address=<%=eventSchd.getH_address()%>">지도</button></td>
							</tr>
							<tr>
								<th>부대시설</th>
								<td>-</td>
							</tr>
							<tr>
								<th>교통편</th>
								<td>-</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- 내용끝 -->
	</div>
</div>
</body>
</html>