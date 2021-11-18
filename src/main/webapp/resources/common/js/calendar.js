
    var arrSchEvent = null;
	var arrEtDays = null;
	var arrProtectedDays = null;

	var nStartDayYear = null;
	var nStartDayMonth = null;
	var nStartDayDay = null;

	// 행사 스케쥴 표시 달력 
	function goodsEventCalendar(serverDate, tDays, etDays) {

		var startMonth = "";
		var endMonth = "";
		arrEtDays = etDays;

		console.log(">>>>>>>>>>>>>> tDays : " + tDays);

		arrSchEvent = tDays.split("|");

		// var nowDate = new Date();	// 오늘 날짜 객체 선언
		// var nYear = nowDate.getFullYear();// 오늘의 년도
		// var nMonth = nowDate.getMonth()+1;// 오늘의 월 ※ 0월부터 시작
		// var nDay = nowDate.getDay();// 오늘의 일자 

		nStartDayYear = serverDate.substring(0, 4);
		nStartDayMonth = serverDate.substring(4, 6);
		nStartDayDay = serverDate.substring(6, 8);

	    console.log("nStartDayYear : " + nStartDayYear);
	    console.log("nStartDayMonth : " + nStartDayMonth);
		console.log("nStartDayDay : " + nStartDayDay);
		console.log("etDays : " + etDays);
	    /** 
	    if(nMonth < 10) {
		   nMonth = "0" + nMonth;
	    } 
		**/

	    var nYearMonth = nStartDayYear +"" + nStartDayMonth;
	    var nCase = -1;
	    if(arrSchEvent != null || arrSchEvent.length > 0) {
			for (i = 0; i < arrSchEvent.length; i++) {
			var schEvent = arrSchEvent[i];
		
				if(schEvent == nYearMonth) {
						nCase = i;
						break;
				} 
			}
		}

	    console.log(">>>>>>>> nCase : " + nCase);
	    
		// 출발 가능 요일 관련 

	    // 행사 기간내 포함이 된 경우 
	    if(nCase > -1) {
	     	console.log(">>>>>>>>>>>>>>>>>>>>> 행사 기간내 이벤트 스케쥴 셋팅 !!!!! 1 ");
			console.log(">>>>> arrSchEvent.length > " + arrSchEvent.length); 
			startMonth = arrSchEvent[0];
			if(arrSchEvent.length > 2) {
				endMonth = arrSchEvent[arrSchEvent.length-2];
			} else {
				endMonth = arrSchEvent[arrSchEvent.length-1];
			}
			console.log(">>>>> startMonth > " + startMonth);
			console.log(">>>>> endMonth > " + endMonth);
			console.log(">>>>> caledar > " + arrSchEvent[nCase]);

	   		searchCalendar(startMonth, endMonth, arrSchEvent[nCase].substring(0, 4), arrSchEvent[nCase].substring(4, arrSchEvent[nCase].length));

	    } else if (nCase == -1) { // 
	     	console.log(">>>>>>>>>>>>>>>>>>>>> 행사 기간내 이벤트 스케쥴 셋팅 !!!!! 2 ");
			 	var serverDate2 = arrSchEvent[0];				
				var nStartDayYear2 = serverDate2.substring(0, 4);
				var nStartDayMonth2 = serverDate2.substring(4, 6);
				var nStartDayDay2 = "01";				
				
				if(nStartDayYear == nStartDayYear2 && nStartDayMonth == nStartDayMonth2) {

				} else {
					nStartDayYear = nStartDayYear2;
					nStartDayMonth = nStartDayMonth2;
					nStartDayDay = nStartDayDay2;
				}

				startMonth = nStartDayYear + "" + nStartDayMonth;

				console.log(">>>>> arrSchEvent.length > " + arrSchEvent.length);
				endMonth = arrSchEvent[arrSchEvent.length-2];
				
				console.log(">>>>> startMonth > " + startMonth);
				console.log(">>>>> endMonth > " + endMonth);
				console.log(">>>>> caledar > " + nStartDayYear + "" + nStartDayMonth);

				searchCalendar(startMonth, endMonth, nStartDayYear, nStartDayMonth);

	    } else {
			console.log("기본 달력 날짜 셋팅 >>>> 행사 기간내 이벤트 스케쥴 셋팅 !!!!! 3 ");
			startMonth = nStartDayYear + "" + (nStartDayMonth-1);
			endMonth = nStartDayYear + "" + (nStartDayMonth+1);

			console.log(">>>>> startMonth > " + startMonth);
			console.log(">>>>> endMonth > " + endMonth);
			console.log(">>>>> caledar > " + nStartDayYear + "" + nStartDayMonth);

			searchCalendar(startMonth, endMonth, nStartDayYear, nStartDayMonth); 
			
	  
	    }
	    
	}

	// -----------------------------------------------------
	// 달력 스와이프 
	// -----------------------------------------------------

	function searchCalendar(startMonth, endMonth, tYear, tMonth) { //달력 함수

		if(parseInt(tMonth) < 10) {
			tMonth = "0" + parseInt(tMonth);
		}

		if(tYear == nStartDayYear && tMonth == nStartDayMonth) { // 같은 달일 경우
			startDay = nStartDayDay; // 시작일자를 현재 날짜 기준으로 셋팅 
		} else { // 다른 달일 경우 
			startDay = "0" + 1;  // 시작일자를 1로 셋팅 
		}

		var start_day = tYear + "" +  tMonth + "" + startDay;

		console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		console.log("> searchCalendar() >>>>>>>>>>>>>>>> startMonth > " + startMonth);
		console.log("> searchCalendar() >>>>>>>>>>>>>>>> endMonth > " + endMonth);
		console.log("> searchCalendar() >>>>>>>>>>>>>>>> tYear > " + tYear);
		console.log("> searchCalendar() >>>>>>>>>>>>>>>> tMonth > " + tMonth);	
		console.log("> searchCalendar() >>>>>>>>>>>>>>>> start_day > " + start_day);
		console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		// 행사 리스트 출력 
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		
		console.log(">>>>>>>>>>>>>> 행사 리스트 출력 시작 >>>>>>>>>>>> " +  start_day);
		
		
				
		calendar(startMonth, endMonth, tYear, tMonth);
		fn_SiteGoodsEvntList('', start_day);

		console.log(">>>>>>>>>>>>>> 행사 리스트 출력 마침 >>>>>>>>>>>> " +  start_day);


	}
	
	function calendar(startMonth, endMonth, tYear, tMonth){ //달력 함수
		var startDay = 1;

		var currYearMonth = "";
		if(parseInt(tMonth) < 10) {
			currYearMonth = parseInt(tYear) +"0"+parseInt(tMonth);
		} else {
			currYearMonth = parseInt(tYear) +""+parseInt(tMonth);
		}
		var prevStartMoth = "";
		var nextEndMonth = "";
		var oDate = new Date(tYear, tMonth, 1);
		var strPrevStartMonth = "";
		var strNextEndMonth = "";

	    console.log("tYear : " + tYear);
	    console.log("tMonth : " + tMonth);


				
		prevStartMonth = new Date(oDate.getFullYear(), oDate.getMonth(), 0);
		nextEndMonth = new Date(oDate.getFullYear(), oDate.getMonth()+1, 0);

		var prevStartYear;
		var prevStartMonth;
		var nextEndYear;
		var nextEndMonth;

		prevStartYear = prevStartMonth.getFullYear();
		if(prevStartMonth.getMonth() < 10) {
			if(prevStartMonth.getMonth() == 0) {
				strPrevStartMonth = prevStartMonth.getFullYear() +"0"+ (prevStartMonth.getMonth() + 1);
				prevStartMonth = "0"+ (prevStartMonth.getMonth() + 1);
			} else {
				strPrevStartMonth = prevStartMonth.getFullYear() +"0"+ prevStartMonth.getMonth();
				prevStartMonth = "0"+ prevStartMonth.getMonth();
			}
		} else {
			strPrevStartMonth = prevStartMonth.getFullYear() +""+ prevStartMonth.getMonth();
			prevStartMonth = prevStartMonth.getMonth();
		}
		
		nextEndYear = nextEndMonth.getFullYear();

		if((nextEndMonth.getMonth()+1) < 10) {
			strNextEndMonth = nextEndMonth.getFullYear() +"0" +(nextEndMonth.getMonth()+1);
			nextEndMonth = "0" + (nextEndMonth.getMonth()+1);
		} else {
			strNextEndMonth = nextEndMonth.getFullYear() +"" +(nextEndMonth.getMonth()+1);
			nextEndMonth = nextEndMonth.getMonth()+1;
		}
	    console.log("startMonth : " + startMonth);
	    console.log("endMonth : " + endMonth);

	    console.log("strPrevStartMonth : " + strPrevStartMonth);
		var strPrevYear = strPrevStartMonth.substring(0, 4);
		var strPrevMonth = strPrevStartMonth.substring(4, 6);

		if(strPrevMonth == '00') {
			prevStartYear = prevStartYear - 1;
			prevStartMonth = "12";

			console.log("prevStartYear : " + prevStartYear);
			console.log("prevStartMonth : " + prevStartMonth);
		}

	    console.log("strNextEndMonth : " + strNextEndMonth);
	    


		var nowDate = new Date();//오늘 날짜 객체 선언
		var nYear = nowDate.getFullYear(); //오늘의 년도
		var nMonth = nowDate.getMonth() ;  //오늘의 월 ※ 0월부터 시작
		var nDate = nowDate.getDate(); //오늘의 날
		var nNumday = nowDate.getDay();    //오늘의 요일 0=일요일...6=토요일

		console.log("같은 달인 지 여부 판단 tYear >>>>>>>> " + tYear);
		console.log("같은 달인 지 여부 판단 nStartDayYear >>>>>>>> " + nStartDayYear);
		console.log("같은 달인 지 여부 판단 tMonth >>>>>>>> " + tMonth);
		console.log("같은 달인 지 여부 판단 nStartDayMonth >>>>>>>> " + nStartDayMonth);

		if(tYear == nStartDayYear && tMonth == nStartDayMonth) { // 같은 달일 경우
			startDay = parseInt(nStartDayDay); // 시작일자를 현재 날짜 기준으로 셋팅 
		} else { // 다른 달일 경우 
			startDay = 1;  // 시작일자를 1로 셋팅 
		}

		console.log("startDay >>>>>>>> " + startDay);

		var endDay=new Array(31,28,31,30,31,30,31,31,30,31,30,31); //각달의 마지막 날짜
		var dayName=new Array("일", "월", "화", "수", "목", "금", "토"); // 숫자 요일을 문자 요일 바꿀 함수
		var col=0;  //나중에 앞뒤 빈 날짜칸 계산 

		if (tYear==null)   //null 일경우, 처음 페이지가 로드 될때의 년도는 
			{tYear=nYear;} // 현재 년도를 가져오고

		if (tMonth==null)   //null 일경우, 처음 페이지가 로드 될때의 월은
			{tMonth=nMonth;}//현재 월을 가져오고

		eDate= new Date();  // 변경된 날짜 객체 선언
		eDate.setFullYear(tYear);// 변경된 년도 세팅
		eDate.setMonth(tMonth-1);  // 변경된 월 세팅
		eDate.setDate(startDay);   // 날짜는 1일로 설정해서
		var fNumday=eDate.getDay();    // 첫번째 날짜 1일의 숫자 요일
		var lastDay=endDay[eDate.getMonth()]; //변경된 월의 마지막 날짜

		if ((eDate.getMonth()==1)&&(((eDate.getYear()%4==0)&&(eDate.getYear() %100 !=0))||eDate.getYear() % 400 ==0 ))
			{lastDay=29;} // 0월 부터 시작하므로 1는 2월임. 윤달 계산 4년마다 29일 , 100년는 28일, 400년 째는 29일

			calendarStr  = titleHtml + "<div class='sd_cld_ymd'>";
		
		console.log("이전 달이 존재하는 지 여부 판단 startMonth >>>>>>>> " + startMonth);
		console.log("이전 달이 존재하는 지 여부 판단 strPrevStartMonth >>>>>>>> " + strPrevStartMonth);
		
		if(parseInt(startMonth) < parseInt(strPrevStartMonth)) {
			calendarStr +="<button type='button' data-role='none' onClick='searchCalendar("+ startMonth +"," + endMonth + "," +prevStartYear+","+ prevStartMonth +")'><span>이전달</span></button>"; //월을 넘길때 빼기 -1을 해서 넘긴다(년도는 자동 계산됨)
		} else if(startMonth == strPrevStartMonth) {
			calendarStr +="<button type='button' data-role='none' onClick='searchCalendar("+ startMonth +"," + endMonth + "," +prevStartYear+","+ prevStartMonth +")'><span>이전달</span></button>"; //월을 넘길때 빼기 -1을 해서 넘긴다(년도는 자동 계산됨)
		} else {
			calendarStr +="<button type='button' data-role='none' onClick='alertMesg()'><span>이전달</span></button>"; //월을 넘길때 빼기 -1을 해서 넘긴다(년도는 자동 계산됨)
		} 
		// 이번달 
		/** 
		if(eDate.getMonth()+1 < 10) {
			calendarStr +="<li class='year'><a href='javascript:void(0);'>"+eDate.getFullYear()+".0"+(eDate.getMonth()+1)+"</a></li>"; 
		} else {
			calendarStr +="<li class='year'><a href='javascript:void(0);'>"+eDate.getFullYear()+"."+(eDate.getMonth()+1)+"</a></li>"; 
		}
		**/
		// 이번달 표시 
		calendarStr +="<a href='javascript:void(0);'>"+tYear+"."+tMonth+"</a></li>"; 

		console.log("다음 달이 존재하는 지 여부 판단 endMonth >>>>>>>> " + endMonth);
		console.log("다음 달이 존재하는 지 여부 판단 strNextEndMonth >>>>>>>> " + strNextEndMonth);

		if(parseInt(endMonth) > parseInt(strNextEndMonth)) { 
			calendarStr +="<button type='button' data-role='none' onClick='searchCalendar("+ startMonth +","+endMonth+"," +nextEndYear+","+ nextEndMonth +")'><span>다음달</span></button>"; //다음달
		} else if(endMonth == strNextEndMonth) {
			calendarStr +="<button type='button' data-role='none' onClick='searchCalendar("+ startMonth +","+endMonth+"," +nextEndYear+","+ nextEndMonth +")'><span>다음달</span></button>"; //다음달
		} else {
			calendarStr +="<button type='button' data-role='none' onClick='alertMesg()'><span>다음달</span></button>"; //다음달
		}
		calendarStr +="</div>";
		col = 0;
		for (i=0;i<fNumday;i++){// 첫번째 날짜의 숫자 요일을 구해서 그전까지는 빈칸 처리
			col++; 
		}  

		// console.log("arrEtDays.indexOf('목') : " + arrEtDays.indexOf("목"));

		// 요일 표시 
		calendarStr +="<div class='swiper-container sd_cld_list'>";
		calendarStr +="<div class='swiper-wrapper'>";

		var tagReserveDay = "";
		
		for ( i=startDay; i<=lastDay; i++){  // 해당 월의 달력 
			if(i<10) {
				tagReserveDay = "div_"+ currYearMonth + "0"+i;
			} else {
				tagReserveDay = "div_"+ currYearMonth + ""+i;
			}

			if(col==0){    //일요일이면
				calendarStr += "<div id='"+ tagReserveDay +"' name='" + tagReserveDay + "' class='swiper-slide'>"; 
				if(i<10) {
					calendarStr += "<a href=\"javascript:fn_SiteGoodsEvntList(\'\',\'" + currYearMonth + "0" + i + "\')\"><em>" + dayName[col]  + "</em><span>" + "0" + i + "</span>";
				} else {
					calendarStr += "<a href=\"javascript:fn_SiteGoodsEvntList(\'\',\'" + currYearMonth  + "" + i + "\')\"><em>" + dayName[col]  + "</em><span>" + i + "</span>";
				}
			calendarStr += "</a>";
			calendarStr += "</div>";

			}else if(1<=col && col<=5) {//그외 평범한 날이면

				if(col == 1) { // 월
					calendarStr +="<div id='"+ tagReserveDay +"' name='" + tagReserveDay + "' class='swiper-slide'>"; // 숫자 요일을 날짜 요일로 입력
				} else if(col == 2) { // 화 
					calendarStr +="<div id='"+ tagReserveDay +"' name='" + tagReserveDay + "' class='swiper-slide'>"; // 숫자 요일을 날짜 요일로 입력
				} else if(col == 3) { // 수 
					calendarStr +="<div id='"+ tagReserveDay +"' name='" + tagReserveDay + "' class='swiper-slide'>"; // 숫자 요일을 날짜 요일로 입력
				} else if(col == 4) { // 목 
					calendarStr +="<div id='"+ tagReserveDay +"' name='" + tagReserveDay + "' class='swiper-slide'>"; // 숫자 요일을 날짜 요일로 입력
				} else if(col == 5) { // 금 
					calendarStr +="<div id='"+ tagReserveDay +"' name='" + tagReserveDay + "' class='swiper-slide'>"; // 숫자 요일을 날짜 요일로 입력
				} 

				if(i<10) {
					calendarStr += "<a href=\"javascript:fn_SiteGoodsEvntList(\'\',\'" + currYearMonth  + "0" + i + "\')\"><em>" + dayName[col]  + "</em><span>" + "0" + i + "</span>";
				} else {
					calendarStr += "<a href=\"javascript:fn_SiteGoodsEvntList(\'\',\'" + currYearMonth  + "" + i + "\')\"><em>" + dayName[col]  + "</em><span>" + i + "</span>";
				}

				calendarStr += "</a>";
				calendarStr += "</div>";
			} else if(col==6){   //토요일이면

				calendarStr += "<div id='"+ tagReserveDay +"' name='" + tagReserveDay + "' class='swiper-slide'>"; 
				if(i<10) {
					calendarStr += "<a href=\"javascript:fn_SiteGoodsEvntList(\'\',\'" + currYearMonth  + "0" + i + "\')\"><em>" + dayName[col]  + "</em><span>" + "0" + i + "</span>";
				} else {
					calendarStr += "<a href=\"javascript:fn_SiteGoodsEvntList(\'\',\'" + currYearMonth  + "" + i + "\')\"><em>" + dayName[col]  + "</em><span>" + i + "</span>";
				}


				calendarStr += "</a>";
				calendarStr += "</div>";
			} 

			col++;
			if(col==7){//7칸을 만들면 줄 바꾸어 새 줄을 만들고 다시 첫 칸부터 시작
		
				col=0;
			}
		}   
		
		calendarStr +=" </div>";
		calendarStr +="</div>";
		calendarStr += "<ul class='sd_cld_guide'><li><em></em> 출발가능</li><li><em></em> 예약가능</li><li><em></em> 예약마감</li><li><em></em> 긴급모객</li></ul>";
		
		
		
//		console.log("calendarStr:" + calendarStr);
		
		// document.getElementById('calendarEvnt').innerHTML = calendarStr;
		$("#calendarEvnt").html(calendarStr);
//		$("#calendarEvnt").append(calendarStr);

		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		// 스와이프 초기화 부분  
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		
		Init_CalendarSwiper();




	}

	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	// 스와이프 초기화 함수 
	// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

	function Init_CalendarSwiper() {
		var weekDay = new Swiper('.sd_cld_list', {
			spaceBetween: 0,
			slidesPerView:8,
			touchRatio: 0.4,			
			paginationClickable: true,
			slideToClickedSlide: true,
			loop:false
		});
	}

	function alertMesg() {
		alert("등록된 행사가 없습니다.");
	}