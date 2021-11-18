<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.lottejtb.goods.rn.service.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.net.*"%>
<%@ page import="com.lottejtb.util.*"%>
<%@ page import="com.lottejtb.comm.util.*"%>
<%
	// 현지시간/ 홥불 정보

	if(timeDifferCurrencyList.size() > 0) {
		String nowDay3 = "";
		RNTimeDifferCurrencyVO currencyVO = null;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			
		Date serverDate = new Date();  // 날짜 입력하는곳 .
		
		Calendar cal2 = Calendar.getInstance() ;
		cal2.setTime(serverDate);              // 하루더한 날자 값을 Calendar  넣는다.
		int dayNum = cal2.get(Calendar.DAY_OF_WEEK);   // 요일을 구해온다. 				
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");		
		nowDay3 = sdf.format(serverDate);
		SimpleDateFormat sdf2 = new SimpleDateFormat("HH시 mm분");
		String nowDay4 = sdf2.format(serverDate);

		String day2 = "";
		switch (dayNum) {
			case 1: day2 = "일"; break;
			case 2: day2 = "월"; break;
			case 3: day2 = "화"; break;
			case 4: day2 = "수"; break;
			case 5: day2 = "목"; break;
			case 6: day2 = "금"; break;
			case 7: day2 = "토"; break;
		}	
		nowDay3 = nowDay3 + "(" + day2 + ") " + nowDay4;	

		for(int idx4 = 0; idx4 < timeDifferCurrencyList.size(); idx4++) {
			if(idx4 == 0) {
				currencyVO = (RNTimeDifferCurrencyVO) timeDifferCurrencyList.get(idx4);
				break;
			}
		}

		if(currencyVO != null) {

%>
<!-- 현지시간 /환률 -->
<p class="sd_trv4_title mt10">현지 시간 / 환율 정보</p>
<dl class="sd_wnerinfo" id="div_currency" name="div_currency">
	<dt>
		<button class="layerOpener" type="button" data-role="none" data-url='/goods/pop_currency_city.do?eventCd=<%=eventCd%>&schdId=<%=schd_id%>'>
			<span><%=currencyVO.getCountryKnm()%>-<%=currencyVO.getCityKnm()%></span>
		</button>
	</dt>
	<dd>
		<table class="ft_table2 ft_tb_tl">
			<colgroup>
				<col width="25%">
				<col width="auto">
			</colgroup>
			<tbody>
			<%
				if(currencyVO.getTimeDiff() != null && !currencyVO.getTimeDiff().equals("0")) {
			%>	
				<tr>
					<th>시차</th>
					<td>현지 시간 <%=nowDay3%> 시차 <%=currencyVO.getTimeDiff()%>시간</td>
				</tr>
			<%
				}
			%>
				<tr>
					<th>환율</th>
					<td><%=currencyVO.getCountryKnm()%> <%=currencyVO.getCurrencyNm()%> = 대한민국 KRW <%=CommUtil.decimalFormat(currencyVO.getCashBuyRate())%>원</td>
				</tr>
			</tbody>
		</table>
	</dd>
</dl>

<%
		} // end if
	} // end if
%>

<script>
	function fn_getDay(dayNum) {
		var day = "";
		switch (dayNum) {
			case 1: day = "일"; break;
			case 2: day = "월"; break;
			case 3: day = "화"; break;
			case 4: day = "수"; break;
			case 5: day = "목"; break;
			case 6: day = "금"; break;
			case 7: day = "토"; break;
		}	

		return day;
	}
	
	function fn_srchCurrency(countryKnm) {
        //console.log("goodsCd  >>> " + goodsCd);
         //console.log("startRow  >>> " + startRow);
         //console.log("endRow  >>> " + endRow);

         var formData = new FormData();
         formData.append('eventCd', '<%=eventCd%>');
         formData.append('schdId', <%=schd_id%>);
         formData.append('countryKnm', countryKnm);
		 
		 var timeDifferCurrencyList;

		 var d = new Date();
		 var nowDate = "";

		 nowDate = d.getFullYear() + "년 " + (d.getMonth() + 1)+"월 "+ d.getDate() + "일(" + fn_getDay(d.getDay())+ ") " + d.getHours() + "시 " +d.getMinutes() +"분";



         cfn_ajax({
             type: "POST",
             async: false,
             url: "<c:url value='/goods/srchTimeDifferCurrencyListAjax.do'  />",
             data: formData,
             dataType: "json",
             cache: false,
             noloading: "no",
             timeOut: (5 * 60 * 1000),
             success: function(res) {
                 timeDifferCurrencyList = res.timeDifferCurrencyList;
 
                 var html = "";

				 for(var i = 0; i < timeDifferCurrencyList.length; i++) {
					if(i == 0) {
			
						html = html + "	<dt>";
						html = html + "		<button data-role='none'>";
						html = html + "			<span>"+timeDifferCurrencyList[i].countryKnm+"-"+timeDifferCurrencyList[i].cityKnm+"</span>";
						html = html + "		</button>";
						html = html + "	</dt>";
						html = html + "	<dd>";
						html = html + "		<table class='ft_table2 ft_tb_tl'>";
						html = html + "			<colgroup>";
						html = html + "				<col width='25%'>";
						html = html + "				<col width='auto'>";
						html = html + "			</colgroup>";
						html = html + "			<tbody>";
						if(timeDifferCurrencyList[i].timeDiff != 0) {
							html = html + "				<tr>";
							html = html + "					<th>시차</th>";
							html = html + "					<td>현지 시간 "+nowDate+" 시차 " + timeDifferCurrencyList[i].timeDiff + "시간</td>";
							html = html + "				</tr>";									
						}								
						html = html + "				<tr>";
						html = html + "					<th>환율</th>";
						html = html + "					<td>"+timeDifferCurrencyList[i].countryKnm+" "+timeDifferCurrencyList[i].cityCd+" = 대한민국 KRW "+ timeDifferCurrencyList[i].cashBuyRate+ "원</td>";
						html = html + "				</tr>";
						html = html + "			</tbody>";
						html = html + "		</table>";
						html = html + "	</dd>";


					}
				 }

				 // console.log(html);

                 $("#div_currency").html(html);

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
