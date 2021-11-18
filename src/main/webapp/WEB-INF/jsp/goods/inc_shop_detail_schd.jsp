<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<link href="http://vjs.zencdn.net/5.0.2/video-js.css" rel="stylesheet">
	<script src="http://vjs.zencdn.net/ie8/1.1.0/videojs-ie8.min.js"></script>

<!-- 일정표 -->
<div class="tabctn_com sd_info_box sd_info_box2">
<%
	if("JBW3001".equals(goodsCd)){
%>
<video oncontextmenu="return false;" id="myVideo" width="100%" controls poster="http://www.lottejtb.com/images/img2015/style/img_detail_TV.jpg" >
  <source src="https://www.lottejtb.com/upload/temp/fitpack_toyama.mp4" type="video/mp4">
</video>
<%
	}
%>
<%	
	////////////////////////////////////////////////////////////////////// 체크사항 ////////////////////////////////////////////////////////////////////// 		
%>
<%	
	String imgMeetingPlace = "";
	if(rnGDCommSchdList.size() > 0) {
		for(int i = 0; i < rnGDCommSchdList.size(); i++) {
			RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDCommSchdList.get(i);

			String tag = "";
			
			if(eventCommSchd.getSchd_det_cd().equals("3017")) { // 미팅장소안내
				tag = "미팅장소안내";
				imgMeetingPlace = eventCommSchd.getImg_path();
				
%>
	<dl class="sd_info_meet" data-role="none">
		<dt><%=tag%></dt>
		<dd data-role="none"><%=eventCommSchd.getSchd_det_cntn()%></dd>
	</dl>
<%
				if(imgMeetingPlace != null) {
%>	
	<p class="sd_info_gimg"><img src="<%=imgMeetingPlace%>"></p>

<%
					break;
				}
				
			}
		}
	}
%>
<%	
	////////////////////////////////////////////////////////////////////// 동선 ////////////////////////////////////////////////////////////////////// 		
%>
<%	
	String imgFlow = "";
	if(rnGDCommSchdList.size() > 0) {
		for(int i = 0; i < rnGDCommSchdList.size(); i++) {
			RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDCommSchdList.get(i);

			String tag = "";
			
			if(eventCommSchd.getSchd_det_cd().equals("3018")) { 
				tag = "여행 전체 동선 보기";
				imgFlow = eventCommSchd.getImg_path();
				
%>
	<dl class="sd_info_meet" data-role="none">
		<dt><%=tag%></dt>
		<dd data-role="none"><%=eventCommSchd.getSchd_det_cntn()%></dd>
	</dl>
<%
				if(imgFlow != null) {
%>	
	<p class="sd_info_gimg"><img src="<%=imgFlow%>"></p>

<%
					break;
				}
				
			}
		}
	}
%>


<%	
	////////////////////////////////////////////////////////////////////// 일정표  ////////////////////////////////////////////////////////////////////// 		
%>
	<p class="sd_inbox2_abtn">
		<button class="sd_all_btn" data-role="none">모두펼침</button>
	</p>
	
	<!-- DAY 일정표 -->
	<dl class="sd_tahaco sd_day_info">
<%
int nMaxDayCnt = rnEtMst.getEv_day_cnt(); // 일정표 일차 수 
int dayCnt = 0; // 해당 일수 
int beforeDayCnt = 0; // 해당일자만 비교 
String city_desc = "";
String city_knm = "";
String city_cd = "";
boolean tag_end = false;
int reg_seq = 0;
int schd_id =0;
String departDay = "";
String arrDay = "";
String departDay2 = "";
String arrDay2 = "";
String nowDate = "";
String m_eating = "";
String a_eating = "";
String e_eating = "";

if(rnGDSchdList.size() > 0) {	
	for(int idx = 0; idx < rnGDSchdList.size(); idx++) {
		RNGDSchdVO eventSchd = (RNGDSchdVO) rnGDSchdList.get(idx);
		dayCnt = eventSchd.getDay_cnt();
		int n_schd_det_cd = 0;
		schd_id = eventSchd.getSchd_id();

		n_schd_det_cd = Integer.parseInt(eventSchd.getSchd_det_cd());
		if(n_schd_det_cd == 1001) { // 도시
			city_knm = eventSchd.getSchd_det_cntn();
		} 			
		
		departDay = rnEtMst.getStart_day().substring(0, 4) + "년  " + rnEtMst.getStart_day().substring(4, 6) + "월 " + rnEtMst.getStart_day().substring(6, 8) + "일 (" + rnEtMst.getStart_wday() + ")";
		arrDay = rnEtMst.getEnd_day().substring(0, 4) + "년 " + rnEtMst.getEnd_day().substring(4, 6) + "월 " + rnEtMst.getEnd_day().substring(6, 8) + "일  ("  + rnEtMst.getEnd_wday() +")";
		departDay2 = rnEtMst.getStart_day().substring(0, 4) + "년  " + rnEtMst.getStart_day().substring(4, 6) + "월 " + rnEtMst.getStart_day().substring(6, 8) + "일 (" + rnEtMst.getStart_wday() + ") " + city_knm;
		arrDay2 = rnEtMst.getEnd_day().substring(0, 4) + "년 " + rnEtMst.getEnd_day().substring(4, 6) + "월 " + rnEtMst.getEnd_day().substring(6, 8) + "일  ("  + rnEtMst.getEnd_wday() +") " + city_knm;


		
		if(beforeDayCnt != dayCnt) {
			beforeDayCnt = dayCnt;
				if(dayCnt == 1) { // 출발일 
%>
		<dt>
			<span><%=dayCnt%> DAY <em><%=departDay2%></em></span>
		</dt>
		<dd>

<%
			   	} else if(dayCnt == nMaxDayCnt) { // 도착일
%>
		<dt>
			<span><%=dayCnt%> DAY <em><%=arrDay2%></em></span>
		</dt>
		<dd>

<%
				} else {
					SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
						
					Date date = formatter.parse(rnEtMst.getStart_day());  // 날짜 입력하는곳 .
					date = new Date(date.getTime() + (1000*60*60*24*+(dayCnt-1)));  // 날짜에 하루를 더한 값 
					// 하루를 뺄려면 (1000*60*60*24*-1) 해주시면 됩니다.
					
					Calendar cal = Calendar.getInstance() ;
					cal.setTime(date);              // 하루더한 날자 값을 Calendar  넣는다.
					
					int dayNum = cal.get(Calendar.DAY_OF_WEEK);   // 요일을 구해온다. 			
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 ");
					nowDate = sdf.format(date);
					String nowDate2 = "";
					String day = "";
					switch (dayNum) {
						case 1: day = "일"; break;
						case 2: day = "월"; break;
						case 3: day = "화"; break;
						case 4: day = "수"; break;
						case 5: day = "목"; break;
						case 6: day = "금"; break;
						case 7: day = "토"; break;
					}	
					nowDate = nowDate + "(" + day + ")";		
					nowDate2 = nowDate + " " + city_knm;		   
%>
		<dt>
			<span><%=dayCnt%> DAY <em><%=nowDate2%></em></span>
		</dt>
		<dd>
<%		   
				} // 일차별 
			} // 일차가 다를 경우 

%>

<% 
		if(beforeDayCnt == dayCnt) {

			if(n_schd_det_cd == 1001 || n_schd_det_cd == 1002) {

				if(n_schd_det_cd == 1001) { // 도시
					city_cd = eventSchd.getD_city_cd();
					city_knm = eventSchd.getSchd_det_cntn();
%>

<%
				} 			
				
				if(n_schd_det_cd == 1002) { // 여정 	
					if(n_schd_det_cd == 1002) {
						reg_seq = eventSchd.getReg_seq();
						city_desc = eventSchd.getSchd_det_cntn();
						reg_seq = idx;
					}

				} 

				if(!city_knm.equals("") && !city_desc.equals("")) {
%>
			<dl>
				<dt class="space"><%=city_knm%></dt>
				<dd><%=city_desc%></dd>
			</dl>

<%
					// city_knm = "";
					city_desc = "";
				}

			}

			if(n_schd_det_cd == 1003) { // 관광지 
				if(eventSchd.getD_imgs() != null) {
					String[] schdCdArr = eventSchd.getSchd_det_cd_val().split("[/]"); // 10/1/OT/SINN
					String[] dImgs = eventSchd.getD_imgs().split("[|]");
					String schd_cd = schdCdArr[0]; 
					String[] d_imgs = dImgs[0].split("[@]"); // 20150419105510_001.JPG@주롱새공원 앵무새|20150419105645_001.jpg@주롱새공원 홍학20150419105510_001.JPG@주롱새공원 앵무새|20150419105645_001.jpg@주롱새공원 홍학
					String d_img = d_imgs[0];
					//d_img = d_img.replaceAll(".jpg", "_600.jpg");
					String[] imgFile = {".PNG",".png",".tif",".TIF",".pdf",".PDF",".htm",".HTM",".jxr",".JXR",
							".jpeg",".JPEG",".bmp",".BMP",".GIF",".gif",".jfif",".JFIF",".JPG",".jpg"};
					for(int i=0; i<imgFile.length; i++){
						d_img = d_img.replaceAll(imgFile[i], "_600"+imgFile[i]);
					}
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
				    // http://www.lottejtb.com/upload/common/areainfo/AE/DXB/area/20150605101151_001_600.jpg

					//String o_imagePath = "http://www.lottejtb.com/upload/common/areainfo/" + eventSchd.getD_country_cd() + "/" + eventSchd.getD_city_cd() +"/" + dir + "/" +  d_img;
					String o_imagePath = "/m_file/upload/common/areainfo/" + eventSchd.getD_country_cd() + "/" + eventSchd.getD_city_cd() +"/" + dir + "/" +  d_img;
%>
			<div class="ml45">
				<!-- 관광지 팝업 존재 -->
				<div class="sd_dinfo_tbbox">
					<button type="button" data-role="none" onclick="moveLink('/goods/pop_places.do?eventCd=<%=eventCd%>&regSeq=<%=eventSchd.getReg_seq()%>','_blank')"><span>[<%=eventSchd.getSchd_det_clval()%>] <%=eventSchd.getSchd_det_cntn()%></span></button>
					<div class="sd_chk_v1">
						<em class="img" onclick="moveLink('/goods/pop_places.do?eventCd=<%=eventCd%>&regSeq=<%=eventSchd.getReg_seq()%>', '_blank')" style="background:#f5f5f5 url(<%=o_imagePath%>) center center no-repeat; background-size:200px auto"></em>						
						<p><%=CommUtil.removeHtmlTag(eventSchd.getD_detail_cnts1())%></p>
					</div>
				</div>
			</div>
							
<%					
				} 
			} // end if 관광지일때 
			if(n_schd_det_cd == 1004) { // 옵션  

%>
			<dl>
				<dt class="chck">선택관광</dt>
				<dd>
					<!-- 선택관광 팝업 존재 -->
					<div class="sd_dinfo_tbbox">
						<p><%=eventSchd.getSchd_det_cntn()%></p>
						<p class="f_red">
							<span>소요시간 : <%=eventSchd.getO_op_time()%></span> <span>1인요금 : <%=eventSchd.getO_price_info()%></span>
						</p>
						<p class="f_purple sd_chk_v2">대체일정 : <%=eventSchd.getO_other_schd()%></p>
						<div class="sd_chk_v2">
<%
				if(eventSchd.getO_imgs() != null) {
					String[] oImgs = eventSchd.getO_imgs().split("[|]");
					String[] o_imgs = oImgs[0].split("[@]"); // 20150419105510_001.JPG@주롱새공원 앵무새|20150419105645_001.jpg@주롱새공원 홍학20150419105510_001.JPG@주롱새공원 앵무새|20150419105645_001.jpg@주롱새공원 홍학
					String o_img = o_imgs[0];
					//o_img = o_img.replaceAll(".jpg", "_600.jpg");
					String[] imgFile = {".PNG",".png",".tif",".TIF",".pdf",".PDF",".htm",".HTM",".jxr",".JXR",
							".jpeg",".JPEG",".bmp",".BMP",".GIF",".gif",".jfif",".JFIF",".JPG",".jpg"};
					for(int i=0; i<imgFile.length; i++){
						o_img = o_img.replaceAll(imgFile[i], "_600"+imgFile[i]); 
					}
					String dir = "option";
					

					//String o_imagePath = "http://www.lottejtb.com/upload/common/areainfo/" + eventSchd.getO_country_cd() + "/" + eventSchd.getO_city_cd() +"/" + dir + "/" +  o_img;
					String o_imagePath = "/m_file/upload/common/areainfo/" + eventSchd.getO_country_cd() + "/" + eventSchd.getO_city_cd() +"/" + dir + "/" +  o_img;
		
%>							
							<em class="img" style="background:#f5f5f5 url(<%=o_imagePath%>) center center no-repeat; background-size:200px auto"></em>
<%
				}

				if(eventSchd.getD_detail_cnts1() != null) {
%>
							<p><%=CommUtil.removeHtmlTag(eventSchd.getD_detail_cnts1())%></p>
<%
				} else {
%>
							<p></p>
<%					
				}
%>
						</div>
					</div>
				</dd>
			</dl>
<%
				
			}
			if(n_schd_det_cd == 2004 && dayCnt < nMaxDayCnt) { // 호텔 
%>
			<dl>
			
				<dt class="htico">호텔</dt>
				<dd><%=eventSchd.getSchd_det_cntn()%></dd>
			</dl>
<%
					if(eventSchd.getH_imgs() != null) {
%>
			<div class="ml45">
				<div class="sd_dinfo_tbbox">
					<button type="button" data-role="none" onclick="moveLink('/goods/pop_hotel.do?eventCd=<%=eventCd%>&regSeq=<%=eventSchd.getReg_seq()%>', '_blank')"><span>[숙박정보] <%=eventSchd.getH_lodge_knm()%> <%if(eventSchd.getH_lodge_grade() != null && !eventSchd.getH_lodge_grade().equals("")){%><em class="f_purple"><%=eventSchd.getH_lodge_grade()%></em><%}%></span></button>
					<div class="sd_chk_v3">
<%
						String[] dImgs = eventSchd.getH_imgs().split("[|]");
						String[] h_imgs = dImgs[0].split("[@]"); // 20150419105510_001.JPG@주롱새공원 앵무새|20150419105645_001.jpg@주롱새공원 홍학20150419105510_001.JPG@주롱새공원 앵무새|20150419105645_001.jpg@주롱새공원 홍학
						
						// http://www.lottejtb.com/upload/common/areainfo/MV/MLE/hotel/20141217120003_001.jpg
						//String h_imagePath = "http://www.lottejtb.com/upload/common/areainfo/" + eventSchd.getH_country_cd() + "/" + eventSchd.getH_city_cd() +"/hotel/" + h_imgs[0].replaceAll(".jpg", "_600.jpg");		
						String h_imagePath = "/m_file/upload/common/areainfo/" + eventSchd.getH_country_cd() + "/" + eventSchd.getH_city_cd() +"/hotel/" + h_imgs[0].replaceAll(".jpg", "_600.jpg");
%>						
							<em class="img" onclick="moveLink('/goods/pop_hotel.do?eventCd=<%=eventCd%>&regSeq=<%=eventSchd.getReg_seq()%>', '_blank')" style="background:#f5f5f5 url(<%=h_imagePath%>) center center no-repeat; background-size:200px auto"></em>
<%
					if(eventSchd.getH_hotel_desc() != null) {
%>							
						<p><%=CommUtil.removeHtmlTag(eventSchd.getH_hotel_desc())%></p>
<%
					} else {
%>
						<p>&nbsp;</p>
<%
					}
%>
					</div>
				</div>
			</div>

<%
					}

				}

				if(n_schd_det_cd == 2001 || n_schd_det_cd == 2002 || n_schd_det_cd == 2003) { // 조식, 중식, 석식 

					if(n_schd_det_cd == 2001) {
						if(!"".equals(eventSchd.getSchd_det_cntn())){
						m_eating = eventSchd.getSchd_det_nm()+"["+eventSchd.getSchd_det_cntn()+"]";
						}else{
						m_eating = eventSchd.getSchd_det_nm();	
						}
					}
					if(n_schd_det_cd == 2002) {
						if(!"".equals(eventSchd.getSchd_det_cntn())){
						a_eating = eventSchd.getSchd_det_nm()+"["+eventSchd.getSchd_det_cntn()+"]";
						}else{
							a_eating = eventSchd.getSchd_det_nm();	
						}
					}
					if(n_schd_det_cd == 2003) {
						if(!"".equals(eventSchd.getSchd_det_cntn())){
						e_eating = eventSchd.getSchd_det_nm()+"["+eventSchd.getSchd_det_cntn()+"]";
						}else{
						e_eating = eventSchd.getSchd_det_nm();	
						}
					}	

					if(!m_eating.equals("") && !a_eating.equals("") && !e_eating.equals("")) {			
						m_eating = m_eating.replaceAll("^선택안함", "");
						a_eating = a_eating.replaceAll("^선택안함", "");
						e_eating = e_eating.replaceAll("^선택안함", "");						
%>			

					<dl>
						<dt class="eatico">식사</dt>
						<dd class="eatbox">
							<span><em>조식</em> <%=m_eating%></span> 
							<span><em>중식</em> <%=a_eating%></span> 
							<span><em>석식</em> <%=e_eating%></span>
						</dd>
					</dl>				

					<!-- 현지 날씨 정보 -->
					<!-- <%@ include file="/WEB-INF/jsp/goods/inc_shop_detail_schd_weather.jsp"%> -->
					<!-- 현지 날씨 정보 -->
				</dd>
<%
						m_eating = "";
						a_eating = "";
						e_eating = "";
					
					}
				}
		}
	} // end for 등록된 스케쥴 만큼  
}
%>

	</dl>
	<!-- DAY 일정표 -->

	<!-- 현지시간 /환률 -->
	<%@ include file="/WEB-INF/jsp/goods/inc_shop_detail_schd_exchangerate.jsp"%>
	<!-- 현지시간 /환률  -->

	<!-- 일정체크 노출박스 -->
	<ul class="sd_chk_view">
		<li>
			<p class="chkbox">
				<span><input id="chk_ck10_1" type="checkbox" data-role="none" checked></span>
				<label for="chk_ck10_1">숙박정보</label>
			</p>
		</li>
		<li>
			<p class="chkbox">
				<span><input id="chk_ck10_2" type="checkbox" data-role="none" checked></span>
				<label for="chk_ck10_2">관광지정보</label>
			</p>
		</li>
		<li>
			<p class="chkbox">
				<span><input id="chk_ck10_3" type="checkbox" data-role="none" checked></span>
				<label for="chk_ck10_3">선택관광</label>
			</p>
		</li>
	</ul>
	<!-- 고객 상품평 -->
	<%@ include file="/WEB-INF/jsp/goods/inc_shop_detail_reviews.jsp"%>
	<!-- 고객 상품평 -->
	<!-- 버튼 -->
	<div class="btn_one sd_info1_tbtn1" id="btn_more" name="btn_more" onClick="fn_MoreReviewList()">
		<button class="white2 moreico" data-role="none">더보기</button>
	</div>
	<div class="btn_one sd_info1_tbtn2">
		<button class="layerOpener purple2" data-url="/goods/pop_review.do?ctg=<%=ctg%>&goodsCd=<%=goodsCd%>&eventCd=<%=eventCd%>&goodsNm=<%=disp_nm%>" onClick="sessionCheck()" data-ok="yes" data-role="none">상품평작성</button>
	</div>	
</div>


<script>
	// $("#chk_ck10_1").trigger("click");
	// $("#chk_ck10_2").trigger("click");
	// $("#chk_ck10_3").trigger("click");
</script>
<!-- 일정표 -->