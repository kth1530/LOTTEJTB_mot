<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>


<%
	// 파일명 : pop_calendar.jsp
	// 설명 : 출발일/도착일 선택
	
	// 서버 날짜 받아오기 
	Date systemDate = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
	String nowServerDay = sdf.format(systemDate);

    // 항공 구매 가능 날짜로 받아오기 
	String serverDay = (String) request.getAttribute("sellDate");
		
	// 달력 표시 종료 날짜 
	Calendar cal = Calendar.getInstance(); 
	// 당월 + 11개월 마지막달 
	cal.add(cal.MONTH, 11);
	String endYearMonth = ""; 
	if((cal.get(cal.MONTH) + 1) < 10) {
		endYearMonth = cal.get(cal.YEAR) + "0" + (cal.get(cal.MONTH) + 1);
	} else {
		endYearMonth = cal.get(cal.YEAR) + "" + (cal.get(cal.MONTH) + 1);
	}

%>
<script type="text/javascript">
	var startYear = '';
	var startMonth = '';
	var startDay = '';
	var uiType = "${type}";  // 항공 : AIR, 호텔 : HOTEL, 렌트카 : RENTCAR
	var availTy = "${availTy}"; // 선택 항목  [RT : 왕복, OW : 편도, MT : 다구간, OO : 해외출발]
	var travelMtCnt = "${travelMtCnt}"; // availTy == 'MT' 다구간 선택일 때만 몇번째 여정인지 
	var canSellDate = "${sellDate}"; // 항공 구매 가능 날짜 
	var useAir =  $("input:checkbox[id='aircheck']").is(":checked");
	var useHotel = $("input:checkbox[id='hotelcheck']").is(":checked");
	var useRentcar = $("input:checkbox[id='carcheck']").is(":checked");

	/******* // 항공 단독 검색시엔 TOPAS 로 연결이라서 현재 서버 시간으로 체크함. // *****/
	if(useAir && !useHotel && !useRentcar) { 
		canSellDate = "0";
	}

	var availGroup = $('div[ft-att="' + availTy + 'Group"]');

	var endYear = '';
	var endMonth = '';
	var endDay = '';

	var selectedStartDay = 0;
	var selectedEndDay = 0;
	var clickCnt = 1;
	
	var dayIndex = 0;

	// 다구간 여정 1 ~ 여정 3
	var srch_dep_dt;
	var srch_dep_dt2;
	var srch_dep_dt3;

	function fn_initAirMtCalendar() {
		var dep_dt;
		var dep_dt2;
		var dep_dt3;

		dep_dt = availGroup.find('#dep_dt').html().split(".");
		dep_dt2 = availGroup.find('#dep_dt2').html().split(".");
		dep_dt3 = availGroup.find('#dep_dt3').html().split(".");
		
		
		if(dep_dt != '미지정' && dep_dt != '출발일선택' && dep_dt != 'undefined') {
			srch_dep_dt = dep_dt[0] + dep_dt[1] + dep_dt[2];
			var tag1 = "#div_" + srch_dep_dt;
			$(tag1).removeClass('cld_view');
			$(tag1).removeClass('cld_start');
			$(tag1).removeClass('cld_end');
			$(tag1).addClass('cld_start_air2');
			$(tag1).html("<p>"+dep_dt[2]+"</p><span>출국일</span>");
		} else {
			srch_dep_dt = '';
		}
		
		if(dep_dt2 != '미지정' && dep_dt2 != '출발일선택' && dep_dt2 != 'undefined') {		
			srch_dep_dt2 = dep_dt2[0] + dep_dt2[1] + dep_dt2[2];
			var tag2 = "#div_" + srch_dep_dt2;
			$(tag2).removeClass('cld_view');
			$(tag2).removeClass('cld_start');
			$(tag2).removeClass('cld_end');
			$(tag2).addClass('cld_start_air2');
			$(tag2).html("<p>"+dep_dt2[2]+"</p><span>중간일</span>");

		} else {
			srch_dep_dt2 = '';
		}
		
		if(dep_dt3 != '미지정' && dep_dt3 != '출발일선택' && dep_dt3 != 'undefined') {			
			srch_dep_dt3 = dep_dt3[0] + dep_dt3[1] + dep_dt3[2];
			var tag3 = "#div_" + srch_dep_dt3;
			$(tag3).removeClass('cld_view');
			$(tag3).removeClass('cld_start');
			$(tag3).removeClass('cld_end');
			$(tag3).addClass('cld_start_air2');
			$(tag3).html("<p>"+dep_dt3[2]+"</p><span>귀국일</span>");		
		} else {
			srch_dep_dt3 = '';
		}

		console.log("srch_dep_dt : " + srch_dep_dt);
		console.log("srch_dep_dt2 : " + srch_dep_dt2);
		console.log("srch_dep_dt3 : " + srch_dep_dt3);
		

	}

	function fn_init() {
		setCalendar();	
		
		if(availTy == 'MT') { // 다구간 일때만 달력에 여정 출발일 표시 
			fn_initAirMtCalendar();
		}
		var serverDate = '<%=nowServerDay%>';
		startYear = serverDate.substring(0, 4);
		startMonth = serverDate.substring(4, 6);
		startDay = serverDate.substring(6, 8);
		
		if(availTy == "OW" || availTy == "MT"){
			var selTodayDay = startYear + ""+startMonth + ""+startDay;
			
			if(nullToBlank(travelMtCnt) == "" || travelMtCnt == 1){
				var insStartDate = availGroup.find('#dep_dt').html().split(".");
				
				if(nullToBlank(insStartDate) != "" && insStartDate !="출발일선택" && insStartDate != "미지정"){
					var startDate = new Date(insStartDate[0], parseInt(insStartDate[1] - 1), insStartDate[2]);
					var startNumday = getWeeks(startDate.getDay());    // 첫번째 날짜 1일의 숫자 요일
					var strSelectedStartDay = insStartDate[0] + "."+insStartDate[1]+"."+ insStartDate[2] + " (" + startNumday+ ")";
					
					selectedStartDay = insStartDate[0] + insStartDate[1] + insStartDate[2];
					
					var tag1 = "#div_"+selectedStartDay;
					$(tag1).addClass("cld_start");
					
					if(selTodayDay != selectedStartDay){
						var todayTag = "#div_"+ selTodayDay;
						$(todayTag).addClass("cld_today");
					}
					
					$('#selectedStartDay').html(strSelectedStartDay);
				}else{
					var todayTag = "#div_"+ selTodayDay;
					$(todayTag).addClass("cld_today");
				}
			}else{
				var insStartDate = availGroup.find('#dep_dt'+ travelMtCnt).html().split(".");
				
				if(nullToBlank(insStartDate) != "" && insStartDate !="출발일선택" && insStartDate != "미지정"){
					var startDate = new Date(insStartDate[0], parseInt(insStartDate[1] - 1), insStartDate[2]);
					var startNumday = getWeeks(startDate.getDay());    // 첫번째 날짜 1일의 숫자 요일
					var strSelectedStartDay = insStartDate[0] + "."+insStartDate[1]+"."+ insStartDate[2] + " (" + startNumday+ ")";
					
					selectedStartDay = insStartDate[0] + insStartDate[1] + insStartDate[2];
					
					var tag1 = "#div_"+selectedStartDay;
					$(tag1).addClass("cld_start");
					
					if(selTodayDay != selectedStartDay){
						var todayTag = "#div_"+ selTodayDay;
						$(todayTag).addClass("cld_today");
					}
					
					$('#selectedStartDay').html(strSelectedStartDay);
				}else{
					var todayTag = "#div_"+ selTodayDay;
					$(todayTag).addClass("cld_today");
				}
			}
		}else{
			var insStartDate = availGroup.find('#dep_dt').html().split(".");
			var insEndDate = availGroup.find('#arr_dt').html().split(".");
			
			if(nullToBlank(insStartDate) != "" && insStartDate != "출발일선택" && insStartDate != "미지정"){
				var startDate = new Date(insStartDate[0], parseInt(insStartDate[1] - 1), insStartDate[2]);
				
				var startNumday = getWeeks(startDate.getDay());    // 첫번째 날짜 1일의 숫자 요일
				var strSelectedStartDay = insStartDate[0] + "."+insStartDate[1]+"."+ insStartDate[2] + " (" + startNumday+ ")";
				
				selectedStartDay = insStartDate[0] + insStartDate[1] + insStartDate[2];
				selTodayDay = startYear + ""+startMonth + ""+startDay;
				
				var tag1 = "#div_"+selectedStartDay;
				
				if(nullToBlank(insEndDate) == "" || insEndDate.length < 2){
					if(selTodayDay == selectedStartDay){
						$(tag1).addClass("cld_start");
					}else{
						var todayTag = "#div_"+selTodayDay;
						$(todayTag).addClass("cld_today");
						
						$(tag1).addClass("cld_start");	
					}
				}else{
					$(tag1).addClass("cld_start");
					
					var todayTag = "#div_"+selTodayDay;
					$(todayTag).addClass("cld_today");
				}
				
				// 메인 화면 날짜 표시 영역에 표시함. 
				availGroup.find("#dep_dt").html(insStartDate[0] + "."+ insStartDate[1] +"."+insStartDate[2]);
				
				if(nullToBlank(insEndDate) != ""){
					if(insEndDate.length > 2){
						var endDate = new Date(insEndDate[0], parseInt(insEndDate[1] - 1), insEndDate[2]);	
						clickCnt++;
						
						var endNumday = getWeeks(endDate.getDay());    // 첫번째 날짜 1일의 숫자 요일
						var strSelectedEndDay = insEndDate[0] + "."+insEndDate[1]+"."+ insEndDate[2] + " (" + endNumday+ ")";
						
						selectedEndDay = insEndDate[0] + insEndDate[1] + insEndDate[2];
						
						var tag2 = "#div_"+selectedEndDay;
						$(tag2).addClass("cld_end");
						
						var startDayIndex = $(tag1).data('index');
						var endDayIndex = $(tag2).data('index');
						
						$('#selectedEndDay').html(strSelectedEndDay);
						
						for(var d = startDayIndex + 1; d < endDayIndex; d++){
							$('.calendarDay[data-index='+ d +']').addClass('cld_view');
						}
					}
				}
			}else{
				selTodayDay = startYear + ""+startMonth + ""+startDay;
				
				var tag1 = "#div_"+selectedStartDay;
				
				var todayTag = "#div_"+selTodayDay;
				$(todayTag).addClass("cld_today");
				
				/*
				var startDate = new Date(startYear, parseInt(startMonth - 1), startDay);
				
				var startNumday = getWeeks(startDate.getDay());    // 첫번째 날짜 1일의 숫자 요일
				var strSelectedStartDay = startYear + "."+startMonth+"."+startDay + " (" + startNumday+ ")";
	
				selectedStartDay = startYear + ""+startMonth + ""+startDay;
				
				var tag1 = "#div_"+selectedStartDay;
				$(tag1).addClass("cld_today");
				
				// 메인 화면 날짜 표시 영역에 표시함. 
				availGroup.find("#dep_dt").html(startYear + "."+startMonth+"."+startDay );
				*/
			}
			
			// 하단 출발 날짜 
			if(nullToBlank(strSelectedStartDay) != ""){
				$('#selectedStartDay').html(strSelectedStartDay);	
			}
	
			if(uiType == 'HOTEL') {
	
				var nightDays = $('#srch_night_days').text();
				var days = nightDays.substring(0, nightDays.lastIndexOf('박'));
				
				startDay = parseInt(startDay);
				startDay += parseInt(days);
				
				// console.log("days : " + days);
				
				var endDate = new Date(startYear, startMonth, startDay);
	
				
				endYear = endDate.getFullYear();
				if(endDate.getMonth() < 10) {
					endMonth = "0" + endDate.getMonth(); 
				} else {
					endMonth = endDate.getMonth(); 
				}
	
				if(endDate.getDate() < 10) {
					endDay = "0" + endDate.getDate();
				} else {
					endDay = endDate.getDate();
				}
	
				var endNumday = getWeeks(endDate.getDay());    // 첫번째 날짜 1일의 숫자 요일
				var strSelectedEndDay = endYear + "."+endMonth+"."+endDay + " (" + endNumday+ ")";
				// 하단 귀국 날짜 
				$('#selectedEndDay').html(strSelectedEndDay);
				// 메인 귀국 날자 
				availGroup.find("#arr_dt").html(endYear + "."+endMonth+"."+endDay);
				
				selectedEndDay = endYear + "" + endMonth + "" + endDay;
				// console.log("fn_init >>>>  selectedEndDay : " + selectedEndDay);
	
							
				var i = parseInt(selectedStartDay)+1;
				for(;i < parseInt(selectedEndDay); i++) {
					var tag3 = "#div_"+i;
					$(tag3).addClass("cld_view");
				}		
	
				var tag2 = "#div_"+selectedEndDay;
				$(tag2).addClass("cld_end");
			}
		}
	}


	function setCalendar() {

		var serverDate = '<%=nowServerDay%>';
		startYear = serverDate.substring(0, 4);
		startMonth = serverDate.substring(4, 6);
		startDay = serverDate.substring(6, 8);
	
		// console.log("startYear : " +  startYear + " startMonth : " + startMonth + " startDay : " + startDay);
		
    	var startYearMonth = new Date(startYear, startMonth, startDay);
		// 당월 + 11개월 마지막달 
		var i = 0;
		for(i = 0; i < 12; ) {
			var sYear = parseInt(startYearMonth.getFullYear());
			var sMonth = parseInt(startYearMonth.getMonth()) + i;
			
			// console.log("sYear : " + sYear + " sMonth : " + sMonth);
			
			var sYearMonth = "";
			if(parseInt(sMonth) < 10) {
				sYearMonth = sYear + "0" + sMonth;
			} else {
				sYearMonth = sYear +""+ sMonth;
			}
			
			
			// console.log("sYearMonth >>>>>> " + sYearMonth);
			if(sYearMonth != '<%=endYearMonth%>') {
				calendarAirs(sYearMonth.substring(0, 4), sYearMonth.substring(4,6));
			}
			i++;
		}
	}

	function calendarAirs(sYear, sMonth) {
		
		// console.log("sYear : " + sYear + " sMonth : " + sMonth);
		
		var tYear = sYear;
		var tMonth = sMonth;

		var currYearMonth = "";
		/**
		if(tMonth < 10) {
			currYearMonth = tYear +"0"+tMonth;
		} else {
		**/
			currYearMonth = tYear +""+tMonth;
		// }


		var nowDate = new Date();//오늘 날짜 객체 선언
		var nYear = nowDate.getFullYear(); //오늘의 년도
		var nMonth = nowDate.getMonth() ;  //오늘의 월 ※ 0월부터 시작
		var nDate = nowDate.getDate(); //오늘의 날
		var nNumday = nowDate.getDay();    //오늘의 요일 0=일요일...6=토요일


		var endDay=new Array(31,28,31,30,31,30,31,31,30,31,30,31); //각달의 마지막 날짜
		var dayName=new Array("일", "월", "화", "수", "목", "금", "토"); // 숫자 요일을 문자 요일 바꿀 함수
		var col=0;  //나중에 앞뒤 빈 날짜칸 계산 

		eDate= new Date(sYear, parseInt(sMonth)-1, 1);  // 변경된 날짜 객체 선언
		/*
		eDate.setFullYear(parseInt(sYear));// 변경된 년도 세팅
		eDate.setMonth(parseInt(sMonth)-1);  // 변경된 월 세팅
		eDate.setDate(1);   // 날짜는 1일로 설정해서
		*/
		var fNumday=eDate.getDay();    // 첫번째 날짜 1일의 숫자 요일
		var lastDay=endDay[eDate.getMonth()]; //변경된 월의 마지막 날짜

		// console.log(eDate.getFullYear()+"-"+eDate.getMonth() + "-" + eDate.getDate() + " fNumday : " + fNumday + " lastDay : " + lastDay);

		// 0월 부터 시작하므로 1는 2월임. 윤달 계산 4년마다 29일 , 100년는 28일, 400년 째는 29일
		if ((eDate.getMonth()==1)&&(((eDate.getYear()%4==0)&&(eDate.getYear() %100 !=0))||eDate.getYear() % 400 ==0 )) {
			lastDay=29;
		} 

		calendarStr  = "<div class='cldarbox cldarpart cntain5'>";
		calendarStr  = "	<div class='cldarbox'>";
		
		//이번달 
		if(eDate.getMonth() + 1 < 10){
			calendarStr +="		<p class='cld_title'>"+eDate.getFullYear()+".0"+ (eDate.getMonth() + 1) +"</p>";	
			currYearMonth = eDate.getFullYear() + "0" + (eDate.getMonth() + 1);
		}else{
			calendarStr +="		<p class='cld_title'>"+eDate.getFullYear()+"."+(eDate.getMonth() + 1)+"</p>";
			currYearMonth = eDate.getFullYear() + "" + (eDate.getMonth() + 1);
		}

		calendarStr += " 	<table class='pop_cldstyle'>";
		// 요일 정보 
		calendarStr += "		<thead>";
		calendarStr += "			<tr>";
		calendarStr += "				<th>SUN</th>";
		calendarStr += "				<th>MON</th>";
		calendarStr += "				<th>TUE</th>";
		calendarStr += "				<th>WED</th>";
		calendarStr += "				<th>THU</th>";
		calendarStr += "				<th>FRI</th>";
		calendarStr += "				<th>SAT</th>";
		calendarStr += "			</tr>";
		calendarStr += "		</thead>";

		calendarStr += "		<tbody>";
		calendarStr += "			<tr>";

		col = 0;
		for (i=0;i<fNumday;i++){// 첫번째 날짜의 숫자 요일을 구해서 그전까지는 빈칸 처리
			col++; 
			calendarStr += "				<td></td>";
		}  


		// 요일 표시 
		var tagReserveDay = "";
		var day;
		var nowDay = '<%=serverDay %>';
		
		for ( i=1; i<=lastDay; i++){  // 해당 월의 달력 
			if(i<10) {
				tagReserveDay = "div_"+ currYearMonth + "0"+i;
				day = currYearMonth + "0"+i;
			} else {
				tagReserveDay = "div_"+ currYearMonth + ""+i;
				day = currYearMonth + ""+i;
			}

			if(col==0){    //일요일이면
				if(day < nowDay){
					calendarStr += "			<td class='calendarDay cld_glay' id='"+ tagReserveDay +"' name='" + tagReserveDay + "' data-index='"+ dayIndex +"' ><p>"+i+"</p></td>";
				}else{
					calendarStr += "			<td class='calendarDay' id='"+ tagReserveDay +"' name='" + tagReserveDay + "' data-index='"+ dayIndex +"' data-day='"+ day +"' onclick=\"fn_selectDay(\'" + day + "\',\'"+canSellDate+"\')\"><p>"+i+"</p></td>";
				}
			}else if(1<=col && col<=5) {//그외 평범한 날이면
				if(day < nowDay){
					calendarStr += "			<td class='calendarDay cld_glay' id='"+ tagReserveDay +"' name='" + tagReserveDay + "' data-index='"+ dayIndex +"' ><p>"+i+"</p></td>";
				}else{
					calendarStr += "			<td class='calendarDay' id='"+ tagReserveDay +"' name='" + tagReserveDay + "' data-index='"+ dayIndex +"' data-day='"+ day +"' onclick=\"fn_selectDay(\'" + day + "\',\'"+canSellDate+"\')\"><p>"+i+"</p></td>";
				}

			} else if(col==6){   //토요일이면
				if(day < nowDay){
					calendarStr += "			<td class='calendarDay cld_glay' id='"+ tagReserveDay +"' name='" + tagReserveDay + "' data-index='"+ dayIndex +"'><p>"+i+"</p></td>";
				}else{
					calendarStr += "			<td class='calendarDay' id='"+ tagReserveDay +"' name='" + tagReserveDay + "' data-index='"+ dayIndex +"' data-day='"+ day +"' onclick=\"fn_selectDay(\'" + day + "\',\'"+canSellDate+"\')\"><p>"+i+"</p></td>";
				}
				calendarStr += "			</tr>";
				calendarStr += "			<tr>";				
			} 
			col++;
			if(col==7){	//	7칸을 만들면 줄 바꾸어 새 줄을 만들고 다시 첫 칸부터 시작
		
				col=0;
			}
			
			dayIndex++;
		}   
		
		if(col != 0){
			for(var j = col; j < 8; j++){
				calendarStr += "		<td></td>";
			}
		};
		
		calendarStr +=" 		</tbody>";
		calendarStr +="		</table>";
		calendarStr +="	</div>";
		calendarStr += "</div>";

		$("#calendarEvnt").append(calendarStr);
	}
	
	function fn_warningAlert(canSellDate){
		/* var alert_comment;
		if(canSellDate.length == 8) {
			var canSellDay = new Date(canSellDate.substring(0, 4), parseInt(canSellDate.substring(4, 6)) - 1, canSellDate.substring(6, 8));
			canSellDay.setDate(canSellDay.getDate() + 1);
			canSellDate = canSellDay.format("yyyyMMdd");
			
			alert_comment = "항공권 검색을 " + canSellDate.substring(0, 4) + "년 " + canSellDate.substring(4, 6) + "월 " + canSellDate.substring(6, 8) + "일 이후로 검색하셔야 구매가 가능합니다.";
		} else {
			alert_comment = "항공권 검색을 " + canSellDate + "일 이후로 검색하셔야 구매가 가능합니다.";
		}
		
		setAlert(alert_comment);
		return false; */
	}

	function fn_selectDay(day, canSellDate) {

		if(canSellDate == null) canSellDate = '';

		// console.log("day >> " + day);
		// console.log("canSellDate >> " + canSellDate);
		// console.log("clickCnt >> " + clickCnt);
		var alert_comment;
	/* 	if(canSellDate.length == 8) {
			alert_comment = "항공권 검색을 " + canSellDate.substring(0, 4) + "년 " + canSellDate.substring(4, 6) + "월 " + canSellDate.substring(6, 8) + "일 이후로 검색하셔야 구매가 가능합니다.";
		} else {
			alert_comment = "항공권 검색을 " + canSellDate + "일 이후로 검색하셔야 구매가 가능합니다.";
		} */
		var serverDate = '<%=nowServerDay%>';
		selTodayDay = serverDate.substring(0, 4) + serverDate.substring(4, 6) + serverDate.substring(6, 8);
		
		if(availTy != 'OW' && availTy != 'MT') { // 편도 와 다구간이 아닐 때만 동작하도록 
			if(clickCnt > 0) {
				clickCnt = 0;

				$(".pop_cldstyle").find('tbody').find('td').removeClass('cld_view');
				$(".pop_cldstyle").find('tbody').find('td').removeClass('cld_start');
				$(".pop_cldstyle").find('tbody').find('td').removeClass('cld_end');

				// alert('선택된 날짜를 초기화했습니다.');
				selectedStartDay = '';
				selectedEndDay = '';
				
				selectedStartDay = day;
				var tag1 = "#div_"+selectedStartDay;
				$(tag1).addClass("cld_start");
				
				if(selTodayDay != day){
					var todayTag = '#div_'+ selTodayDay;
					$(todayTag).addClass("cld_today");
				}
				
				if(parseInt(day) > parseInt(canSellDate)) {
					startYear = selectedStartDay.substring(0, 4);
					startMonth = selectedStartDay.substring(4, 6);
					startDay = selectedStartDay.substring(6, 8);
					var startDate = new Date(startYear, parseInt(startMonth)-1, startDay);
					var startNumday = getWeeks(startDate.getDay());    // 첫번째 날짜 1일의 숫자 요일

					var strSelectedStartDay = startYear + "."+startMonth+"."+startDay + " (" + startNumday+ ")";
					$('#selectedStartDay').html(strSelectedStartDay);
					$('#selectedEndDay').html("");
				} else {
					//alert(alert_comment);
				}
				//availGroup.find("#dep_dt").html(startYear + "."+startMonth+"."+startDay );
				
			} else {
				if(selectedStartDay == null || selectedStartDay == '') {
					selectedStartDay = day;
					var tag1 = "#div_"+selectedStartDay;
					$(tag1).addClass("cld_start");
					
					if(selTodayDay != day){
						var todayTag = '#div_'+ selTodayDay;
						$(todayTag).addClass("cld_today");
					}

					if(parseInt(day) > parseInt(canSellDate)) {
						startYear = selectedStartDay.substring(0, 4);
						startMonth = selectedStartDay.substring(4, 6);
						startDay = selectedStartDay.substring(6, 8);
						var startDate = new Date(startYear, parseInt(startMonth)-1, startDay);
						var startNumday = getWeeks(startDate.getDay());    // 첫번째 날짜 1일의 숫자 요일

						var strSelectedStartDay = startYear + "."+startMonth+"."+startDay + " (" + startNumday+ ")";
						$('#selectedStartDay').html(strSelectedStartDay);
						$('#selectedEndDay').html("");
					//availGroup.find("#dep_dt").html(startYear + "."+startMonth+"."+startDay );
					} else {
						//alert(alert_comment);
					}
				} else {
					if(parseInt(day) > parseInt(selectedStartDay)) {
						selectedEndDay = day;
						var tag2 = "#div_"+selectedEndDay;
						$(tag2).addClass("cld_end");
						
						
						if(parseInt(day) > parseInt(canSellDate)) {
							endYear = selectedEndDay.substring(0, 4);
							endMonth = selectedEndDay.substring(4, 6);
							endDay = selectedEndDay.substring(6, 8);
							var endDate = new Date(endYear, parseInt(endMonth)-1, endDay);
							var endNumday = getWeeks(endDate.getDay());    // 첫번째 날짜 1일의 숫자 요일

							var strSelectedEndDay = endYear + "."+endMonth+"."+endDay + " (" + endNumday+ ")";
							$('#selectedEndDay').html(strSelectedEndDay);
							//availGroup.find("#arr_dt").html(endYear + "."+endMonth+"."+endDay);
							
							var i = parseInt(selectedStartDay)+1;
							for(;i < parseInt(selectedEndDay); i++) {
								var tag3 = "#div_"+i;
								$(tag3).addClass("cld_view");
							}
						} else {
							//alert(alert_comment);
						}
					} else {
						$(".pop_cldstyle").find('tbody').find('td').removeClass('cld_view');
						$(".pop_cldstyle").find('tbody').find('td').removeClass('cld_start');
						$(".pop_cldstyle").find('tbody').find('td').removeClass('cld_end');

						// alert('선택된 날짜를 초기화했습니다.');
						selectedStartDay = '';
						selectedEndDay = '';
						
						selectedStartDay = day;
						var tag1 = "#div_"+selectedStartDay;
						$(tag1).addClass("cld_start");
						
						if(selTodayDay != day){
							var todayTag = '#div_'+ selTodayDay;
							$(todayTag).addClass("cld_today");
						}
						
						if(parseInt(day) > parseInt(canSellDate)) {
							startYear = selectedStartDay.substring(0, 4);
							startMonth = selectedStartDay.substring(4, 6);
							startDay = selectedStartDay.substring(6, 8);
							var startDate = new Date(startYear, parseInt(startMonth)-1, startDay);
							var startNumday = getWeeks(startDate.getDay());    // 첫번째 날짜 1일의 숫자 요일

							var strSelectedStartDay = startYear + "."+startMonth+"."+startDay + " (" + startNumday+ ")";
							$('#selectedStartDay').html(strSelectedStartDay);
							$('#selectedEndDay').html("");

						} else {
							//alert(alert_comment);
						}
						//alert('잘못 선택하셨습니다.');
						return false;
					}
				}
				
				clickCnt ++;
			}
		} else { // 편도 와 다구간이 일 때만 동작하도록 

			
			// console.log(day);
			// console.log(canSellDate);

			var isMtDayCheck = false;
			if(availTy == 'MT') {
				if(srch_dep_dt != '') {
					if(parseInt(srch_dep_dt) > parseInt(day)) {
						alert("지정한 날짜 이후로 선택하셔야만 합니다.");
						isMtDayCheck = false;
					} else {
						isMtDayCheck = true;
					} 
				} else if(srch_dep_dt2 != '') {
					if(parseInt(srch_dep_dt2) > parseInt(day)) {
						alert("지정한 날짜 이후로 선택하셔야만 합니다.");
						isMtDayCheck = false;
					} else {
						isMtDayCheck = true;
					}

				} else {
					isMtDayCheck = true;
				}

				if(isMtDayCheck) {
								
					if(parseInt(day) > parseInt(canSellDate)) {

						$(".pop_cldstyle").find('tbody').find('td').removeClass('cld_view');
						$(".pop_cldstyle").find('tbody').find('td').removeClass('cld_start');
						$(".pop_cldstyle").find('tbody').find('td').removeClass('cld_end');

						// alert('선택된 날짜를 초기화했습니다.');
						selectedStartDay = '';
						selectedEndDay = '';
						
						selectedStartDay = day;
						var tag1 = "#div_"+selectedStartDay;
						$(tag1).addClass("cld_start");
						
						if(selTodayDay != selectedStartDay){
							var todayTag = "#div_"+ selTodayDay;
							$(todayTag).addClass("cld_today");
						}
						
						startYear = selectedStartDay.substring(0, 4);
						startMonth = selectedStartDay.substring(4, 6);
						startDay = selectedStartDay.substring(6, 8);
						var startDate = new Date(startYear, startMonth, startDay);
						var startNumday = getWeeks(startDate.getDay());    // 첫번째 날짜 1일의 숫자 요일

						var strSelectedStartDay = startYear + "."+startMonth+"."+startDay + " (" + startNumday+ ")";
						$('#selectedStartDay').html(strSelectedStartDay);
					} else {
						//alert(alert_comment);
					}					
				}
			} else { // 편도 일때만

				if(parseInt(day) > parseInt(canSellDate)) {
					$(".pop_cldstyle").find('tbody').find('td').removeClass('cld_view');
					$(".pop_cldstyle").find('tbody').find('td').removeClass('cld_start');
					$(".pop_cldstyle").find('tbody').find('td').removeClass('cld_end');

					// alert('선택된 날짜를 초기화했습니다.');
					selectedStartDay = '';
					selectedEndDay = '';
					
					selectedStartDay = day;
					var tag1 = "#div_"+selectedStartDay;
					$(tag1).addClass("cld_start");
					
					if(selTodayDay != selectedStartDay){
						var todayTag = "#div_"+ selTodayDay;
						$(todayTag).addClass("cld_today");
					}

					startYear = selectedStartDay.substring(0, 4);
					startMonth = selectedStartDay.substring(4, 6);
					startDay = selectedStartDay.substring(6, 8);
					var startDate = new Date(startYear, startMonth, startDay);
					var startNumday = getWeeks(startDate.getDay());    // 첫번째 날짜 1일의 숫자 요일

					var strSelectedStartDay = startYear + "."+startMonth+"."+startDay + " (" + startNumday+ ")";
					$('#selectedStartDay').html(strSelectedStartDay);
				} else {
					//alert(alert_comment);
				}
			} 
		}
	}

	function getWeeks(col) {
		var dayName=new Array("일", "월", "화", "수", "목", "금", "토"); // 숫자 요일을 문자 요일 바꿀 함수		
		return dayName[col];
	}

	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}
	
	function settingDate(){	
		if(availTy == 'OW' || availTy == 'MT') {
			var selStartDay = $(".cld_start").data("day");
			
			if(nullToBlank(selStartDay) != ""){
				var startYear = selStartDay.toString().substring(0, 4);
				var startMonth = selStartDay.toString().substring(4, 6);
				var startDay = selStartDay.toString().substring(6, 8);
				
				if(nullToBlank(travelMtCnt) != "" && travelMtCnt != '1') {
					var tag = "#dep_dt" + travelMtCnt;
					availGroup.find(tag).html(startYear + "."+startMonth+"."+startDay );
					availGroup.find(tag).removeClass("noSelect");
				} else {
					availGroup.find("#dep_dt").html(startYear + "."+startMonth+"."+startDay );
					availGroup.find("#dep_dt").removeClass("noSelect");
					
					if(location.pathname == "/free/main.do"){
						if(nullToBlank(htlSameChk) != ""){
							if(htlSameChk){
								$("div[ft-att='HTGroup']").find("#dep_dt").text(startYear + "."+startMonth+"."+startDay);
								$("div[ft-att='HTGroup']").find("#dep_dt").removeClass("noSelect");
							}	
						}
						
						if(nullToBlank(rntSameChk) != ""){
							if(rntSameChk){
								$("div[ft-att='RCGroup']").find("#dep_dt").text(startYear + "."+startMonth+"."+startDay);
								$("div[ft-att='RCGroup']").find("#dep_dt").removeClass("noSelect");
								$("div[ft-att='RCGroup']").find("#take_date").val(startYear + "" + startMonth + "" + startDay);
							}	
						}
					}
				}
			}else{
				setAlert("출발일을 선택해 주세요.");
				return false;
			}
		} else {
			var selStartDay = $(".cld_start").data("day");
			var selEndDay = $(".cld_end").data("day");
			
			if(nullToBlank(selEndDay) != ""){				
				var startYear = selStartDay.toString().substring(0, 4);
				var startMonth = selStartDay.toString().substring(4, 6);
				var startDay = selStartDay.toString().substring(6, 8);
				
				availGroup.find("#dep_dt").html(startYear + "." + startMonth + "." + startDay);
				availGroup.find("#dep_dt").removeClass("noSelect");
				
				var endYear = selEndDay.toString().substring(0, 4);
				var endMonth = selEndDay.toString().substring(4, 6);
				var endDay = selEndDay.toString().substring(6, 8);
				
				availGroup.find("#arr_dt").html(endYear + "." + endMonth + "." + endDay);
				availGroup.find("#arr_dt").removeClass("noSelect");
				
				if(location.pathname == "/free/main.do"){
					if(nullToBlank(htlSameChk) != ""){
						if(htlSameChk){
							var equalDepDate = new Date(startYear, parseInt(startMonth) - 1, startDay);
							var equalArrDate = new Date(endYear, parseInt(endMonth) - 1, endDay);
							
							var timeDiff = Math.abs(equalArrDate.getTime() - equalDepDate.getTime());
							var dayDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));
								
							$("div[ft-att='HTGroup']").find("#dep_dt").text(startYear + "."+startMonth+"."+startDay);
							$("div[ft-att='HTGroup']").find("#arr_dt").html(endYear + "." + endMonth + "." + endDay);
							$("div[ft-att='HTGroup']").find("#dep_dt").removeClass("noSelect");
							$("div[ft-att='HTGroup']").find("#arr_dt").removeClass("noSelect");
							
							$("div[ft-att='HTGroup']").find('#srch_night_days').text(dayDiff + '박');
						}
					}
					
					if(nullToBlank(rntSameChk)){
						if(rntSameChk){
							$("div[ft-att='RCGroup']").find("#dep_dt").text(startYear + "."+startMonth+"."+startDay);
							$("div[ft-att='RCGroup']").find("#arr_dt").html(endYear + "." + endMonth + "." + endDay);
							$("div[ft-att='RCGroup']").find("#dep_dt").removeClass("noSelect");
							$("div[ft-att='RCGroup']").find("#arr_dt").removeClass("noSelect");
							$("div[ft-att='RCGroup']").find("#take_date").val(startYear + "" + startMonth + "" + startDay);
							$("div[ft-att='RCGroup']").find("#return_date").val(endYear + "" + endMonth + "" + endDay);
						}
					}
				}
			}else{
				setAlert("도착일을 선택해 주세요.");
				return false;
			}
		}
		
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};
	}

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
	});
</script>

<div class="layerPopup">
	<div class="layerPop">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">출발일/도착일 선택</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<!-- 캘린더 -->
			<div id='calendarEvnt' name='calendarEvnt' class='cntain cldarpart cntain5'></div>
			<!-- 캘린더 -->
		</div>
		<!-- 하단 날짜 안내 -->
		<ul class="pop_clddayg">
			<li>
				<p>출발일</p>
				<p id='selectedStartDay'></p>
			</li>
			<li>
				<p>도착일</p>
				<p id='selectedEndDay'></p>
			</li>
		</ul>
		<!-- 내용끝 -->
		<div class="popFoot">
			<div class="layerBtns">
				<button type="button" class="layerClose2" onClick='settingDate()'>확인</button>
			</div>
		</div>
	</div>
</div>