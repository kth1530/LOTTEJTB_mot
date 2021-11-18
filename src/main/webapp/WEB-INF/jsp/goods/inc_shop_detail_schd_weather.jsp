<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.lottejtb.goods.rn.service.*"%>
<%
	// 현지 날씨 정보
	String nowDay = "";
	String nowDay2 = "";
	RNWeatherVO weatherVO = null;
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	Date weatherDate = new Date();

	// String nowDate = formatter.format(weatherDate);	
	// Date date = formatter.parse(rnEtMst.getStart_day());  // 날짜 입력하는곳 .
	// Date date = formatter.parse("20170201");  // 날짜 입력하는곳 .
	// date = new Date(date.getTime() + (1000*60*60*24*+(dayCnt-1)));  // 날짜에 하루를 더한 값 
	// 하루를 뺄려면 (1000*60*60*24*-1) 해주시면 됩니다.
	
	Calendar cal = Calendar.getInstance() ;
	cal.setTime(weatherDate);              // 하루더한 날자 값을 Calendar  넣는다.
	int dayNum = cal.get(Calendar.DAY_OF_WEEK);   // 요일을 구해온다. 			
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 ");		
	nowDay2 = sdf.format(weatherDate);
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");		
	nowDay = sdf2.format(weatherDate);

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
	nowDay2 = nowDay2 + "(" + day + ")";	

	if(weatherList.size() > 0) {

		for(int idx2 = 0; idx2 < weatherList.size(); idx2++) {
			RNWeatherVO weather = (RNWeatherVO) weatherList.get(idx2);

			// 같은 날짜이면서 일차가 같을 경우 
			if(weather.getWeatDt().equals(nowDay) && weather.getDayCnt() == dayCnt)  {
			// if(weather.getWeatDt().equals(nowDay))  {
				weatherVO = weather;
				break;
			}
		}

		if(weatherVO != null) {
%>

<dl>
	<dt class="wnerico">현지날씨 정보</dt>
	<dd>
		<div class="sd_dinfo_tbbox" id="weather<%=dayCnt%>" name="weather<%=dayCnt%>">
			<button class="layerOpener sd_wner_btn" type="button" data-role="none" data-url='/goods/pop_weather_city.do?eventCd=<%=eventCd%>&weatDt=<%=weatherVO.getWeatDt()%>&dayCnt=<%=dayCnt%>&schdId=<%=schd_id%>&cityKnm=<%=weatherVO.getCityKnm()%>'>
				<span id="weather_city_<%=dayCnt%>"><%=weatherVO.getCountryNm()%>-<%=weatherVO.getCityKnm()%></span>
			</button>
			<div class='sd_dtboxinfo'>
				<div>
					<img src='/resources/images/ico/ico_wner<%=weatherVO.getWeatCd()%>.png' alt='' />
				</div>
				<div class="wner_info">
					<span>현재 날씨</span> <span>기온 <%=weatherVO.getMinTemper()%>˚C ~ <%=weatherVO.getMaxTemper()%>˚C</span>
					<span><%=weatherVO.getWeatNm()%></span>
				</div>
			</div>
		</div>
	</dd>
</dl>
<%
		}
	}

%>
<script>
	function fn_srchWeatherInfo<%=dayCnt%>(dayCnt, weatDt, cityKnm) {
        //console.log("goodsCd  >>> " + goodsCd);
         //console.log("startRow  >>> " + startRow);
         //console.log("endRow  >>> " + endRow);
		
         var formData = new FormData();
         formData.append('eventCd', '<%=eventCd%>');
         formData.append('schdId', <%=schd_id%>);
         formData.append('dayCnt', dayCnt);
		 formData.append("weatDt", weatDt);
		 formData.append("cityKnm", cityKnm);
		 
         cfn_ajax({
             type: "POST",
             async: false,
             url: "<c:url value='/goods/srchWeatherListAjax.do'  />",
             data: formData,
             dataType: "json",
             cache: false,
             noloading: "no",
             timeOut: (5 * 60 * 1000),
             success: function(res) {
                 weatherList = res.weatherList;
 
                 var html = "";

				 for(var i = 0; i < weatherList.length; i++) {
					if(i == 0) {
			
						html  = html + "			<button class='layerOpener sd_wner_btn' type='button' data-role='none' data-url='/goods/pop_weather_city.do?eventCd=<%=eventCd%>&weatDt="+weatherList[i].weatDt+"&dayCnt=<%=dayCnt%>&schdId=<%=schd_id%>&cityKnm="+weatherList[i].cityKnm +"'>";
						html  = html + "				<span>"+weatherList[i].countryNm+"-"+weatherList[i].cityKnm+"</span>";
						html  = html + "			</button>";
						html  = html + "			<div class='sd_dtboxinfo'>";
						html  = html + "				<div>";
						html  = html + "					<img src='/resources/images/ico/ico_wner"+weatherList[i].weatCd+".png' alt='' />";
						html  = html + "				</div>";
						html  = html + "				<div class='wner_info'>";
						html  = html + "					<span>현재 날씨</span> <span>기온 "+weatherList[i].maxTemper+"˚C  ~ "+weatherList[i].minTemper+"˚C</span>";
						html  = html + "					<span>"+weatherList[i].weatNm+"</span>";
						html  = html + "				</div>";
						html  = html + "			</div>";

					}
				 }

				 // console.log(html);

                 $("#weather<%=dayCnt%>").html(html);

             },
             error: function(err) {
                 //console.log(err);
             },
             complete: function() {
				
             }
         });

	}
	
	// fn_srchWeatherInfo<%=dayCnt%>(<%=dayCnt%>, '');
</script>
