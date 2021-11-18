<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.net.*"%>
<%@ page import="com.lottejtb.util.*"%>
<%@ page import="com.lottejtb.goods.rn.service.*"%>
<%@ page import="com.lottejtb.comm.util.*"%>

<%

	String ctg = (String) request.getAttribute("ctg");
	String goodsCd = (String) request.getAttribute("goodsCd");
	String eventCd = (String) request.getAttribute("eventCd");
	String flag = (String) request.getAttribute("flag"); /** 담당자 조회가 필요한 경우는 flag=BO 파라미터 출발일 체크 항목을 피함 **/

	RNETMstVO rnEtMst = (RNETMstVO) request.getAttribute("rnEtMst");	
	List rnGDCommSchdList = (List) request.getAttribute("rnGDCommSchdList");
	List rnGDSchdList = (List) request.getAttribute("rnGDSchdList");
	
	// 출발일이 지난 상품인지 체크함.
	if(flag == null || !flag.equals("BO")) {
		String start_day = rnEtMst.getStart_day();
		int nStartDay = Integer.parseInt(start_day);

		// 서버 날짜 받아오기 
		Date systemDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		String serverDay = sdf.format(systemDate);
		int nServerDay = Integer.parseInt(serverDay);

		if(nServerDay > nStartDay) {
// 			RequestDispatcher dispatcher = request.getSession().getServletContext().getRequestDispatcher("http://m.lottejtb.com/");
// 			dispatcher.forward(request,response);
			//response.sendRedirect("http://m.lottejtb.com");
		}
	}	
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="euc-kr" />
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, width=device-width" />
<meta name="format-detection" content="telephone=no" />
<title>롯데제이티비 | 모바일 일정표</title>
<link rel="stylesheet" href="/resources/common/css/schedule.css" />
<script type="text/javascript">
    (function() {
        function resizeParentIframe() {
            if (top === self) {
                return;
            }
            var parentUrl = document.referrer,
                docHeight = document.body.clientHeight;
            parent.postMessage({
                targetEl: 'frm',
                height: docHeight
            }, parentUrl);
        }

        window.addEventListener('load', function() {
            resizeParentIframe();

            window.addEventListener('resize', function() {
                setTimeout(function() {
                    resizeParentIframe();
                }, 300);
            }, false);
        }, false);
    }());
</script>
</head>
<body>

<%	
	////////////////////////////////////////////////////////////////////// 일정표  ////////////////////////////////////////////////////////////////////// 		
%>
<%
int nMaxDayCnt = rnEtMst.getEv_day_cnt(); // 일정표 일차 수 
int dayCnt = 0; // 해당 일수 
int beforeDayCnt = 0; // 해당일자만 비교 
String city_desc = "";
String city_knm = "";
String city_cd = "";
boolean tag_end = false;
int reg_seq = 0;
String m_text = null;
String a_text = null;
String d_text = null;

for(int idx = 0; idx < rnGDSchdList.size(); idx++) {
	RNGDSchdVO eventSchd = (RNGDSchdVO) rnGDSchdList.get(idx);
	dayCnt = eventSchd.getDay_cnt();
	int n_schd_det_cd = 0;

	n_schd_det_cd = Integer.parseInt(eventSchd.getSchd_det_cd());
	
	if(n_schd_det_cd == 1001) { // 도시
		city_knm = eventSchd.getSchd_det_cntn();
	} 			
	String departDay = rnEtMst.getStart_day().substring(0, 4) + "년  " + rnEtMst.getStart_day().substring(4, 6) + "월 " + rnEtMst.getStart_day().substring(6, 8) + "일 (" + rnEtMst.getStart_wday() + ") ";
	if(rnEtMst.getStart_time() != null) { 
		departDay = departDay + rnEtMst.getStart_time().substring(0, 2) + ":" + rnEtMst.getStart_time().substring(2, 4);
	}
	
	String arrDay = rnEtMst.getEnd_day().substring(0, 4) + "년 " + rnEtMst.getEnd_day().substring(4, 6) + "월 " + rnEtMst.getEnd_day().substring(6, 8) + "일  ("  + rnEtMst.getEnd_wday() +") ";
	if(rnEtMst.getEnd_time() != null) {
		arrDay = arrDay + rnEtMst.getEnd_time().substring(0, 2) + ":" + rnEtMst.getEnd_time().substring(2, 4);
	}

	
	if(beforeDayCnt != dayCnt) {
		beforeDayCnt = dayCnt;
	
%>
	<!--  1 일차  -->
	<div class="schedule">	
<%
		if(dayCnt == 1) { // 출발일 
%>	
		<div class="schedule_tit">
			<h1><%=dayCnt%> 일차</h1>
			<div class="info">
				<span class="place"><%=city_knm %> 출발</span> <span class="date"><%=departDay%></span>
			</div>
		</div>
<% 
			String imgMeetingPlace = "";
			if(rnGDCommSchdList != null) {
				for(int i = 0; i < rnGDCommSchdList.size(); i++) {
					RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDCommSchdList.get(i);
			
					String tag = "";
					
					if(eventCommSchd.getSchd_det_cd().equals("3017")) { // 미팅장소안내
						tag = "미팅장소안내";
						imgMeetingPlace = eventCommSchd.getImg_path();
		
%>
		<div class="schedule_con">
			<h2 class="tit_ico1"><%=tag%></h2>
			<div class="photo_area">
				<img src="<%=imgMeetingPlace%>" alt="<%=tag%>">
			</div>
			<ul>
				<li><%=eventCommSchd.getSchd_det_cntn()%></li>
			</ul>
		</div>
<%
					}// end if
				} // end for
			}
		} else if(dayCnt == nMaxDayCnt) { // 도착일
%>
		<div class="schedule_tit">
			<h1><%=dayCnt%> 일차</h1>
			<div class="info">
				<span class="place"><%=city_knm %> 도착</span> <span class="date"><%=arrDay%></span>
			</div>
		</div>
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
			String nowDate = sdf.format(date);
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
%>
		<div class="schedule_tit">
			<h1><%=dayCnt%> 일차</h1>
			<div class="info">
				<span class="date"><%=nowDate%></span>
			</div>
		</div>
<%
		}

	} // end if 단 한번만 출력 
				
%>

<% 
		if(beforeDayCnt == dayCnt) {

			if(n_schd_det_cd == 1001 || n_schd_det_cd == 1002) {

				if(n_schd_det_cd == 1001) { // 도시
					city_cd = eventSchd.getD_city_cd();
					city_knm = eventSchd.getSchd_det_cntn();
				} // end if
				
				if(n_schd_det_cd == 1002) { // 여정 	

					reg_seq = eventSchd.getReg_seq();
					city_desc = eventSchd.getSchd_det_cntn();
					reg_seq = idx;				
				}
				if(!city_knm.equals("") && !city_desc.equals("")) {
%>
		<div class="schedule_con">
			<h2 class="tit_ico2"><%=city_knm%></h2>
			<ul>
				<li><%=city_desc%></li>
			</ul>
		</div>
<%
					city_knm = "";
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

					//String o_imagePath = "http://www.lottejtb.com/upload/common/areainfo/" + eventSchd.getD_country_cd() + "/" + eventSchd.getD_city_cd() +"/" + dir + "/" +  d_img;
					String o_imagePath = "/m_file/upload/common/areainfo/" + eventSchd.getD_country_cd() + "/" + eventSchd.getD_city_cd() +"/" + dir + "/" +  d_img;
%>
		<div class="schedule_con">
			<ul>
				<li>
					<div class="photo_area">
						<img src='<%=o_imagePath%>' alt='<%=eventSchd.getD_knm()%>'>
						<h3>[<%=eventSchd.getSchd_det_clval()%>] <%=eventSchd.getSchd_det_cntn()%></h3>
						<p><%=CommUtil.removeHtmlTag(eventSchd.getD_detail_cnts1())%></p>
					</div>
				</li>
			</ul>
		</div>
<%					
				} 
			} // end if 관광지일때 
			if(n_schd_det_cd == 1004) { // 옵션  

%>		
		<div class="schedule_con">
			<h2 class="tit_ico1">선택관광</h2>
			<ul>
				<li>
					<div class="photo_area2">
<%
				if(eventSchd.getO_imgs() != null) {
					String[] oImgs = eventSchd.getO_imgs().split("[|]");
					String[] o_imgs = oImgs[0].split("[@]"); // 20150419105510_001.JPG@주롱새공원 앵무새|20150419105645_001.jpg@주롱새공원 홍학20150419105510_001.JPG@주롱새공원 앵무새|20150419105645_001.jpg@주롱새공원 홍학
					String o_img = o_imgs[0];
					String dir = "option";
					

					//String o_imagePath = "http://www.lottejtb.com/upload/common/areainfo/" + eventSchd.getO_country_cd() + "/" + eventSchd.getO_city_cd() +"/" + dir + "/" +  o_img;
					String o_imagePath = "/m_file/upload/common/areainfo/" + eventSchd.getO_country_cd() + "/" + eventSchd.getO_city_cd() +"/" + dir + "/" +  o_img;
		
%>								
						<img src="<%=o_imagePath%>" alt="<%=eventSchd.getSchd_det_cntn()%>">
<%
				}
%>
						<h3><%=eventSchd.getSchd_det_cntn()%></h3>
						<h3 class="f_pink">소요시간 : <%=eventSchd.getO_op_time()%> / 1인요금 : <%=eventSchd.getO_price_info()%></h3>
						<h3 class="f_purple">대체일정 : <%=eventSchd.getO_other_schd()%></h3>
<%
				if(eventSchd.getD_detail_cnts1() != null) {
%>
						<p><%=eventSchd.getD_detail_cnts1()%></p>
<%
				} else {
%>
						<p></p>
<%					
				}
%>
					</div>
				</li>
			</ul>
		</div>
<%
				
			}
%>
<% 
			if(n_schd_det_cd == 2004) { // 호텔 
				if(eventSchd.getSeq() == 0) {		
%>		
		<div class="schedule_con">
			<h2 class="tit_ico3">호텔</h2>
			<ul>
				<li><%=eventSchd.getSchd_det_cntn()%>
<%
				} else {
%>
					<div class="photo_area">
<%
					if(eventSchd.getSchd_det_cd_val() != null && eventSchd.getH_imgs() != null) {
						String[] dImgs = eventSchd.getH_imgs().split("[|]");
						String[] h_imgs = dImgs[0].split("[@]"); // 20150419105510_001.JPG@주롱새공원 앵무새|20150419105645_001.jpg@주롱새공원 홍학20150419105510_001.JPG@주롱새공원 앵무새|20150419105645_001.jpg@주롱새공원 홍학
						
						// http://www.lottejtb.com/upload/common/areainfo/MV/MLE/hotel/20141217120003_001.jpg
						//String h_imagePath = "http://www.lottejtb.com/upload/common/areainfo/" + eventSchd.getH_country_cd() + "/" + eventSchd.getH_city_cd() +"/hotel/" + h_imgs[0];		
						String h_imagePath = "/m_file/upload/common/areainfo/" + eventSchd.getH_country_cd() + "/" + eventSchd.getH_city_cd() +"/hotel/" + h_imgs[0];
%>	
						<a href="<%=eventSchd.getH_homepage_url()%>" target="_blank"><img src="<%=h_imagePath%>" alt="<%=eventSchd.getH_lodge_knm()%>" border="0"/></a>
<%
					}
%>
						<h3>
							[숙박정보] <%=eventSchd.getH_lodge_knm()%><em class="f_purple"><%=eventSchd.getH_lodge_grade().substring(0,1)%></em>
						</h3>
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
				</li>
			</ul>
		</div>
<%
				}
			}

%>
<%


			if(n_schd_det_cd == 2001) { // 조식  	
				m_text = eventSchd.getSchd_det_nm();
			} 
			if(n_schd_det_cd == 2002) { // 중식  	
				a_text = eventSchd.getSchd_det_nm();
			}	
			if(n_schd_det_cd == 2003) { // 석식  	
				d_text = eventSchd.getSchd_det_nm();
			}		
			
			if(m_text != null && a_text != null && d_text != null) {
%>	
		<div class="schedule_con">
			<h2 class="tit_ico4">식사</h2>
			<ul>
				<li class="scd_lch"><span>조식</span> <%=m_text%><span>중식</span> <%=a_text%><span>석식</span> <%=d_text%></li>
			</ul>
			<br>
		</div>
<% 	
				m_text = null;
				a_text = null;
				d_text = null;
			}
%>
	</div>
<%
	}
} // end for
%>
	
</body>
</html>