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
	String serverDay = sdf.format(systemDate);

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

<script src="/resources/common/js/date.js"></script>

<script type="text/javascript">
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){

	// console.log("serverDate  >>> " + serverDate);
	// console.log("endYearMonth  >>> " + '<%=endYearMonth%>');
	
	var startYear = '';
	var startMonth = '';
	var startDay = '';
	var uiType = "${type}";  // 항공 : AIR, 호텔 : HOTEL, 렌트카 : RENTCAR
	var availTy = "${availTy}"; // 선택 항목  [RT : 왕복, OW : 편도, MT : 다구간, OO : 해외출발]
	var travelMtCnt = "${travelMtCnt}"; // availTy == 'MT' 다구간 선택일 때만 몇번째 여정인지 
	var availGroup = $('div[ft-att="' + availTy + 'Group"]');

	var endYear = '';
	var endMonth = '';
	var endDay = '';

	var selectedStartDay = 0;
	var selectedEndDay = 0;
	var clickCnt = 1;
	
	var dayIndex = 0;

	function fn_init() {
		setCalendar();	
		
		var serverDate = '<%=serverDay%>';
		startYear = serverDate.substring(0, 4);
		startMonth = serverDate.substring(4, 6);
		startDay = serverDate.substring(6, 8);
		var url = location.href;
		var insStartDate;
		var insEndDate;
		
		if(url.indexOf("/search.do") > -1){
			insStartDate = availGroup.find('#dep_dt').text().split(".");
			insEndDate = availGroup.find('#arr_dt').text().split(".");
		}else{
			insStartDate = availGroup.find('#dep_dt').html().split(".");
			insEndDate = availGroup.find('#arr_dt').html().split(".");
		}
		
		if(nullToBlank(insStartDate) != "" && insStartDate != "미지정"){
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
			
			var todayTag = "#div_"+selTodayDay;
			$(todayTag).addClass("cld_today");
			
			/*
			var startDate = new Date(startYear, parseInt(startMonth - 1), startDay);
			
			var startNumday = getWeeks(startDate.getDay());    // 첫번째 날짜 1일의 숫자 요일
			var strSelectedStartDay = startYear + "."+startMonth+"."+startDay + " (" + startNumday+ ")";

			selectedStartDay = startYear + ""+startMonth + ""+startDay;
			
			var tag1 = "#div_"+selectedStartDay;
			$(tag1).addClass("cld_start");
			
			// 메인 화면 날짜 표시 영역에 표시함. 
			availGroup.find("#dep_dt").html(startYear + "."+startMonth+"."+startDay );
			*/
		}
		
		// 하단 출발 날짜 
		if(nullToBlank(strSelectedStartDay) != ""){
			$('#selectedStartDay').html(strSelectedStartDay);
		}
	}


	function setCalendar() {

		var serverDate = '<%=serverDay%>';
		
		startYear = serverDate.substring(0, 4);
		startMonth = serverDate.substring(4, 6);
		startDay = serverDate.substring(6, 8);

		dayIndex = 0;
    	var startYearMonth = new Date(startYear, startMonth, startDay);
		// 당월 + 11개월 마지막달 
		var i = 0;
		for(i = 0; i < 12; i++) {
			var sYear = startYearMonth.getFullYear();
			var sMonth = startYearMonth.getMonth() + i;

			var sYearMonth = "";
			if(sMonth < 10) {
				sYearMonth = sYear + "0" + sMonth;
			} else {
				sYearMonth = sYear +""+ sMonth;
			}

			// console.log("sYearMonth >>>>>> " + sYearMonth);
			if(sYearMonth != '<%=endYearMonth%>') {
				calendarAirs(sYearMonth.substring(0, 4), sYearMonth.substring(4,6));
			}
		}
	}

	function calendarAirs(sYear, sMonth) {
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

		if (tYear==null)   //null 일경우, 처음 페이지가 로드 될때의 년도는 
			{tYear=nYear;} // 현재 년도를 가져오고

		if (tMonth==null)   //null 일경우, 처음 페이지가 로드 될때의 월은
			{tMonth=nMonth;}//현재 월을 가져오고
		
		eDate= new Date(tYear, parseInt(tMonth)-1, 1);  					// 변경된 날짜 객체 선언
		/*
		eDate.setFullYear(tYear);				// 변경된 년도 세팅
		eDate.setMonth(parseInt(tMonth)-1); 	// 변경된 월 세팅
		eDate.setDate(1);   					// 날짜는 1일로 설정해서
		*/
		var fNumday=eDate.getDay();    			// 첫번째 날짜 1일의 숫자 요일
		var lastDay=endDay[eDate.getMonth()]; 	//변경된 월의 마지막 날짜

		// console.log(eDate.getFullYear()+"-"+eDate.getMonth() + "-" + eDate.getDate() + " fNumday : " + fNumday + " lastDay : " + lastDay);

		// 0월 부터 시작하므로 1는 2월임. 윤달 계산 4년마다 29일 , 100년는 28일, 400년 째는 29일
		if ((eDate.getMonth()==1)&&(((eDate.getYear()%4==0)&&(eDate.getYear() %100 !=0))||eDate.getYear() % 400 ==0 )) {
			lastDay=29;
		} 

		calendarStr  = "<div class='cldarbox cldarpart cntain5'>";
		calendarStr  = "	<div class='cldarbox'>";
		console.log(eDate);
		//이번달 
		if(eDate.getMonth()+1 < 10) {
			calendarStr +="		<p class='cld_title'>"+eDate.getFullYear()+".0"+(eDate.getMonth()+1)+"</p>"; 
			currYearMonth = eDate.getFullYear()+"0"+(eDate.getMonth()+1);
		} else {
			calendarStr +="		<p class='cld_title'>"+eDate.getFullYear()+"."+(eDate.getMonth()+1)+"</p>";
			currYearMonth = eDate.getFullYear()+""+(eDate.getMonth()+1);
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
		//영업개시일 3일
		nowDay = workingDayCheck(nowDay, 3);
		//
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
					calendarStr += "			<td class='calendarDay cld_glay' id='"+ tagReserveDay +"' name='" + tagReserveDay + "' data-index='"+ dayIndex +"'><p>"+i+"</p></td>";
				}else{
					calendarStr += "			<td class='calendarDay' id='"+ tagReserveDay +"' name='" + tagReserveDay + "' data-index='"+ dayIndex +"' data-day='"+ day +"' onclick=\"fn_selectDay(\'" + day + "\')\"><p>"+i+"</p></td>";
				}

			}else if(1<=col && col<=5) {//그외 평범한 날이면
				if(day < nowDay){
					calendarStr += "			<td class='calendarDay cld_glay' id='"+ tagReserveDay +"' name='" + tagReserveDay + "' data-index='"+ dayIndex +"'><p>"+i+"</p></td>";
				}else{
					calendarStr += "			<td class='calendarDay' id='"+ tagReserveDay +"' name='" + tagReserveDay + "' data-index='"+ dayIndex +"' data-day='"+ day +"' onclick=\"fn_selectDay(\'" + day + "\')\"><p>"+i+"</p></td>";
				}
			} else if(col==6){   //토요일이면
				if(day < nowDay){
					calendarStr += "			<td class='calendarDay cld_glay' id='"+ tagReserveDay +"' name='" + tagReserveDay + "' data-index='"+ dayIndex +"'><p>"+i+"</p></td>";
				}else{
					calendarStr += "			<td class='calendarDay' id='"+ tagReserveDay +"' name='" + tagReserveDay + "' data-index='"+ dayIndex +"' data-day='"+ day +"' onclick=\"fn_selectDay(\'" + day + "\')\"><p>"+i+"</p></td>";
				}
			
				calendarStr += "			</tr>";
				calendarStr += "			<tr>";				
			} 
			col++;
			if(col==7){//7칸을 만들면 줄 바꾸어 새 줄을 만들고 다시 첫 칸부터 시작
		
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
	
	function fn_selectDay(day) {
		// console.log("day >> " + day);
		// console.log("clickCnt >> " + clickCnt);
		var serverDate = '<%=serverDay%>';
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
					var todayTag = "#div_"+selTodayDay;
					$(todayTag).addClass("cld_today");
				}

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
				if(selectedStartDay == null || selectedStartDay == '') {
					selectedStartDay = day;
					var tag1 = "#div_"+selectedStartDay;
					$(tag1).addClass("cld_start");

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
					if(parseInt(day) > parseInt(selectedStartDay)) {
						selectedEndDay = day;
						var tag2 = "#div_"+selectedEndDay;
						$(tag2).addClass("cld_end");

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

						startYear = selectedStartDay.substring(0, 4);
						startMonth = selectedStartDay.substring(4, 6);
						startDay = selectedStartDay.substring(6, 8);
						var startDate = new Date(startYear, parseInt(startMonth)-1, startDay);
						var startNumday = getWeeks(startDate.getDay());    // 첫번째 날짜 1일의 숫자 요일

						var strSelectedStartDay = startYear + "."+startMonth+"."+startDay + " (" + startNumday+ ")";
						$('#selectedStartDay').html(strSelectedStartDay);
						$('#selectedEndDay').html("");
						//alert('잘못 선택하셨습니다.');
						
						return false;
					}


				}
				
				clickCnt ++;
			}
		} else { // 편도 와 다구간이 일 때만 동작하도록 
				$(".pop_cldstyle").find('tbody').find('td').removeClass('cld_view');
				$(".pop_cldstyle").find('tbody').find('td').removeClass('cld_start');
				$(".pop_cldstyle").find('tbody').find('td').removeClass('cld_end');

				// alert('선택된 날짜를 초기화했습니다.');
				selectedStartDay = '';
				selectedEndDay = '';
				
				selectedStartDay = day;
				var tag1 = "#div_"+selectedStartDay;
				$(tag1).addClass("cld_start");

				startYear = selectedStartDay.substring(0, 4);
				startMonth = selectedStartDay.substring(4, 6);
				startDay = selectedStartDay.substring(6, 8);
				var startDate = new Date(startYear, startMonth, startDay);
				var startNumday = getWeeks(startDate.getDay());    // 첫번째 날짜 1일의 숫자 요일

				var strSelectedStartDay = startYear + "."+startMonth+"."+startDay + " (" + startNumday+ ")";
				$('#selectedStartDay').html(strSelectedStartDay);

				if(availTy == 'MT') {
					if(travelMtCnt != '1') {
						var tag = "#dep_dt" + travelMtCnt;
						availGroup.find(tag).html(startYear + "."+startMonth+"."+startDay );			
					} else {
						availGroup.find("#dep_dt").html(startYear + "."+startMonth+"."+startDay );			
					} 
				} else {
					availGroup.find("#dep_dt").html(startYear + "."+startMonth+"."+startDay );
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
		var selStartDay = $(".cld_start").data("day");
		var selEndDay = $(".cld_end").data("day");
		
		if(nullToBlank(selStartDay) == ""){
			setAlert("체크인을 선택해 주세요.")
			return false;
		}else if(nullToBlank(selEndDay) == ""){
			setAlert("체크아웃 날짜를 선택해 주세요.")
			return false
		}
		
		var startYear = selStartDay.toString().substring(0, 4);
		var startMonth = selStartDay.toString().substring(4, 6);
		var startDay = selStartDay.toString().substring(6, 8);
		var url = location.href;
		
		if(nullToBlank(selEndDay) != ""){
			var endYear = selEndDay.toString().substring(0, 4);
			var endMonth = selEndDay.toString().substring(4, 6);
			var endDay = selEndDay.toString().substring(6, 8);
			
			var startIndex = $(".cld_start").data("index");
			var endIndex = $(".cld_end").data("index");
			
			var selNightDays = parseInt(endIndex) - parseInt(startIndex);
			
			availGroup.find("#dep_dt").html(startYear + "." + startMonth + "." + startDay);
			availGroup.find("#arr_dt").html(endYear + "." + endMonth + "." + endDay);
			availGroup.find("#srch_night_days").html(selNightDays + "박");
			availGroup.find("#dep_dt").removeClass("noSelect");
			availGroup.find("#arr_dt").removeClass("noSelect");
			
			if(location.pathname == "/free/main.do"){
				if(nullToBlank(rntSameChk) != ""){
					if(rntSameChk){
						$("div[ft-att='RCGroup']").find("#dep_dt").text(startYear + "."+startMonth+"."+startDay);
						$("div[ft-att='RCGroup']").find("#arr_dt").html(endYear + "." + endMonth + "." + endDay);
						$("div[ft-att='RCGroup']").find("#dep_dt").removeClass("noSelect");
						$("div[ft-att='RCGroup']").find("#arr_dt").removeClass("noSelect");
						$("div[ft-att='RCGroup']").find("#take_date").val(startYear + "" + startMonth + "" + startDay);
						$("div[ft-att='RCGroup']").find("#return_date").val(endYear + "" + endMonth + "" + endDay);
					}
				}
			}else if(url.indexOf("/search.do") > -1){ //[JEH]투어멘토링에 사용하려고 만듦 - 20190110
				$("div[ft-att='RCGroup']").find("#dep_dt").text(startYear + "."+startMonth+"."+startDay);
				$("div[ft-att='RCGroup']").find("#arr_dt").text(endYear + "." + endMonth + "." + endDay);
				$("div[ft-att='RCGroup']").find("#dep_dt").removeClass("noSelect");
				$("div[ft-att='RCGroup']").find("#arr_dt").removeClass("noSelect");
				sortList();		
			}
		}else{
			availGroup.find("#dep_dt").html(startYear + "." + startMonth + "." + startDay);
			availGroup.find("#dep_dt").removeClass("noSelect");
			availGroup.find("#srch_night_days").html("선택");
			
			availGroup.find("#arr_dt").html("미지정");
			availGroup.find("#arr_dt").addClass("noSelect");
			
			if(location.pathname == "/free/main.do"){
				if(nullToBlank(rntSameChk) != ""){
					if(rntSameChk){
						$("div[ft-att='RCGroup']").find("#dep_dt").text(startYear + "." + startMonth + "." + startDay);
						$("div[ft-att='RCGroup']").find("#dep_dt").removeClass("noSelect");
						$("div[ft-att='RCGroup']").find("#take_date").val(startYear + "" + startMonth + "" + startDay);
					}
				}
			}
			
		}
		
		//availGroup.find("#dep_dt").html(startYear + "."+startMonth+"."+startDay );
		//availGroup.find("#arr_dt").html(startYear + "."+startMonth+"."+startDay );
		
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
		fn_initButton();
		

		/*document.addEventListener('deviceready', function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});


	
</script>

<div class="layerPopup">
	<div class="layerPop">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">체크인/체크아웃 선택</strong>
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
				<p>체크인</p>
				<p id='selectedStartDay'></p>
			</li>
			<li>
				<p>체크아웃</p>
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