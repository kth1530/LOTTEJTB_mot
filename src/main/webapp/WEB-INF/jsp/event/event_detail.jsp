<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<head>
<%
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
<script type = "text/javascript">
	 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	 //이벤트 달력함수
	 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	 var attendChkDay = [];
	 var attendText = "";
	 var lastDay;  //달력의 마지막 날
	 var attendChkCnt= 0;
	 var checkedValue = ""; //투표 선택값
	 
	 function setCalendar() {
	
		var serverDate = '<%=serverDay%>';
		startYear = serverDate.substring(0, 4);
		startMonth = serverDate.substring(4, 6);
		startDay = serverDate.substring(6, 8);
	
		console.log("startYear : " +  startYear + " startMonth : " + startMonth + " startDay : " + startDay);
		
		var startYearMonth = new Date();//new Date(startYear, startMonth, startDay);
		
		// 당월 + 11개월 마지막달 
		//var i = 0;
		
			var sYear = parseInt(startYearMonth.getFullYear());
			var sMonth = parseInt(startYearMonth.getMonth()) + 1;
			
			// console.log("sYear : " + sYear + " sMonth : " + sMonth);
			
			var sYearMonth = "";
			if(parseInt(sMonth) < 10) {
				sYearMonth = sYear + "0" + sMonth;
			} else {
				sYearMonth = sYear +""+ sMonth;
			}
			
			
			// console.log("sYearMonth >>>>>> " + sYearMonth);
			if(sYearMonth != '<%=endYearMonth%>') {
				calendarEvent(sYearMonth.substring(0, 4), sYearMonth.substring(4,6));
			}
		
	}
	 
   function calendarEvent(sYear, sMonth) {
		
		console.log("sYear : " + sYear + " sMonth : " + sMonth);
		
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
	
		eDate= new Date();  // 변경된 날짜 객체 선언
		eDate.setFullYear(parseInt(sYear));// 변경된 년도 세팅
		eDate.setMonth(parseInt(sMonth)-1);  // 변경된 월 세팅
		eDate.setDate(1);   // 날짜는 1일로 설정해서
		var fNumday=eDate.getDay();    // 첫번째 날짜 1일의 숫자 요일
		lastDay=endDay[parseInt(sMonth)-1]; //변경된 월의 마지막 날짜
		
		var dayIndex = 0;
	
		// 0월 부터 시작하므로 1는 2월임. 윤달 계산 4년마다 29일 , 100년는 28일, 400년 째는 29일
		if ((eDate.getMonth()==1)&&(((eDate.getYear()%4==0)&&(eDate.getYear() %100 !=0))||eDate.getYear() % 400 ==0 )) {
			lastDay=29;
		} 
		
		
		calendarStr  = "	<div class='cldarbox'>";
		
		//이번달 
		calendarStr +="		<p class='cld_title'>"+sYear+"."+sMonth+"<span id='attendDayText'></span></p>"; 
	
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
		var tagetDay = "";
		var selDayTag = "";
		var day;
		var nowDay = '<%=serverDay %>';
		
		for ( i=1; i<=lastDay; i++){  // 해당 월의 달력 
			if(i<10) {
				tagetDay = "div_"+ currYearMonth + "0"+i;
				day = currYearMonth + "0"+i;
			} else {
				tagetDay = "div_"+ currYearMonth + ""+i;
				day = currYearMonth + ""+i;
			}
			selDayTag = "#" + tagetDay;
			
			if(col==0){    //일요일이면
				if(day < nowDay){
					calendarStr += "			<td id='"+ tagetDay +"' name='" + tagetDay + "' data-index='"+ dayIndex +"' ><p>"+i+"</p></td>";
				}else{
					calendarStr += "			<td id='"+ tagetDay +"' name='" + tagetDay + "' data-index='"+ dayIndex +"' data-day='"+ day +"' ><p>"+i+"</p></td>";
				}
			}else if(1<=col && col<=5) {//그외 평범한 날이면
				if(day < nowDay){
					calendarStr += "			<td id='"+ tagetDay +"' name='" + tagetDay + "' data-index='"+ dayIndex +"' ><p>"+i+"</p></td>";
				}else{
					calendarStr += "			<td id='"+ tagetDay +"' name='" + tagetDay + "' data-index='"+ dayIndex +"' data-day='"+ day +"' ><p>"+i+"</p></td>";
				}
	
			} else if(col==6){   //토요일이면
				if(day < nowDay){
					calendarStr += "			<td id='"+ tagetDay +"' name='" + tagetDay + "' data-index='"+ dayIndex +"' ><p>"+i+"</p></td>";
				}else{
					calendarStr += "			<td id='"+ tagetDay +"' name='" + tagetDay + "' data-index='"+ dayIndex +"' data-day='"+ day +"' ><p>"+i+"</p></td>";
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
		
		/* calendarStr +="	<ul class='cld_chk_event'>";
		calendarStr +=" 	<li><span>10회 이상</span> 출석하고 <a class='more' data-role='none'><span>응모하기</span></a></li>";
		calendarStr +=" 	<li><span>15회 이상</span> 출석하고 <a class='more' data-role='none'><span>응모하기</span></a></li>";
		calendarStr +="		<li><span>100%</span> 출석하고 <a class='more' data-role='none'><span>응모하기</span></a></li>";
		calendarStr +="	</ul>" */

	   	$("#calendarEvent").append(calendarStr);
		$('#attendDayText').text("출석체크 : 0");
		
		if(nullToBlank(attendChkDay) != '' && attendChkDay.length > 0) {
	    	//출석체크 했던날들 표시
	       	fn_attendedChkDay(attendChkDay);
	    }
		
	}
   
    //선택한 오늘 날짜
   	function fn_attendChkDay(selday) {
    	selDayTag = "#div_" + selday;
   		$(selDayTag).addClass('cld_attdc');
   		$('#attendChkText').text("출석완료");
   		attendText = "출석체크 :" + "" + (attendChkDay.length + 1);
   		$('#attendDayText').text(attendText);
   	}
    
    //출석체크 했던 날짜들 표시하기 위함.
    function fn_attendedChkDay(chkDay) {
    	
    	for(var i=0; i < attendChkDay.length; i++) {
			selDayTag = "#div_" + chkDay[i];
			console.log("selDayTag=" + selDayTag);
			$(selDayTag).addClass('cld_attdc');
    	}
    	
    	attendText = "출석체크 :" + "" + attendChkCnt;
    	$('#attendDayText').text(attendText);
    }
    
    
</script>

<script type = "text/javascript">
	var eventSeq = "${eventSeq}";
	var custCd = "${custCd}";
	var knm = "${knm}";
	var id = "${id}";
	var email = "${email}";
	var mbrCustno = "${mbrCustno}";
	
	var pageSize = 10;
	var eventTitle = "";
	var commentCnt = 0;
	
	var applyCount = 0;
	var eventLimitDay;
	var quizMngAns;
	
	//투표선택내요
	var eventVote = [];
	
		
	//이벤트 상세	
	$(document).ready(function() {
		fn_init();
		fn_srchDetailtList();
		
		$("#goListBtn").click(function(){
			var preLocation = getCookieValue('preUrl');
			if(preLocation != '/event/event_list.do'){
				location.href = '/event/event_list.do';
			}else{
				pageBack();
			}
		});
		
		$("#insertComment").click(function(){
			showLoading();
			/*
			if(nullToBlank(custCd) == ""){
				location.href = "/sso/loginChk.do";
				return false;
			}
			
			if(!$("#chkAll").is(":checked")){
				alert("정보제공에 동의하여 주시기 바랍니다.");
				return false;
			}
			
			if(nullToBlank($("#cmtContent").val()) == ""){
				alert("댓글을 입력하세요.");
				return false;
			}
			
			var formData = new FormData();
			formData.append('eventSeq', eventSeq);
			formData.append('custCd', custCd);
			formData.append('custNm', knm);
			formData.append('loginId', id);
			formData.append('email', email);
			formData.append('custId', mbrCustno);
			formData.append('eventTitle', eventTitle);
			formData.append('eventCnts', $("#cmtContent").val());
			formData.append('winYn', 'N');
			formData.append('eventInput1', 'Y');
			
			cfn_ajax({
				type : "POST",
				async : false,
				url: "<c:url value='/event/insertComment.do' />",
				data: formData,
				dataType: "json",
				cache : false,
				noloading : "no",
				timeOut : 60 * 5 * 1000,
				success: function() {
					alert("등록되었습니다.");
					$("#cmtContent").val('');
					
					fn_selectComment();
				},
				error : function(err) {
				},
				done : function(e) {
				}
			});
			*/
		});
		
		$("#commentMore").click(function(){
			
		});
	});
	
	var fn_srchDetailtList = function() {
		var startRow = 1;
		var endRow = Number(pageSize);
		
		var formData = new FormData();
		formData.append('eventSeq', eventSeq);
		formData.append('startRow', startRow);
		formData.append('endRow', endRow);
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "<c:url value='/event/event_detailAjax.do' />",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "no",
			timeOut : 60 * 5 * 1000,
			success: function(data) {
				var detailCnt = data.cnt;
				var list = data.list;
				var vHTML = "";
				var date = new Date();
				date = date.format("yyyy-MM-dd");

				if(list.length > 0){
					if(nullToBlank(list[0].eventDesc) != "" && list[0].eventToday < date) {
						var event_desc = list[0].eventDesc
						
						if(nullToBlank(event_desc) != ""){
							event_desc = event_desc.replace("http://www.lottejtb.com", "");
						}
						
						eventTitle = list[0].eventNm;
						applyCount = list[0].roundApplyCnt;
						eventLimitDay = list[0].eventToday;
						quizMngAns = list[0].mngAns;
							
						try {
							
							if(list[0].eventVote1 != null)
								eventVote[0] = list[0].eventVote1;
							if(list[0].eventVote2 != null)
								eventVote[1] = list[0].eventVote2;
							if(list[0].eventVote3 != null)
								eventVote[2] = list[0].eventVote3;
							if(list[0].eventVote4 != null)
								eventVote[3] = list[0].eventVote4;
							if(list[0].eventVote5 != null)
								eventVote[4] = list[0].eventVote5;
							if(list[0].eventVote6 != null)
								eventVote[5] = list[0].eventVote6;
							if(list[0].eventVote7 != null)
								eventVote[6] = list[0].eventVote7;
							if(list[0].eventVote8 != null)
								eventVote[7] = list[0].eventVote8;
							if(list[0].eventVote9 != null)
								eventVote[8] = list[0].eventVote9;
							if(list[0].eventVote10 != null)
								eventVote[9] = list[0].eventVote10; 
						
						} catch(e) {
							console.log(e);
						}
						
						vHTML += "<li class='header'>";
						vHTML += "	<h3><span class='gray'>" + "당첨자발표" +"</span>" + list[0].eventNm + "</h3>";
						vHTML += "	<em>" + list[0].eventFrday + "-" + list[0].eventToday + "</em><i>" + "조회수:" + detailCnt + "</i>";
						vHTML += "</li>";
						vHTML += "<li class='content'>";
						vHTML += "	<div class='txt'>";
						vHTML += "		<p>" + list[0].eventNm + "</p>";
						vHTML += "		<div class='plan_cont_img'>";
						if(list[0].spotWinYn == 'Y'){
							//vHTML += "			<p><iframe  id='winnerHtml' name='winnerHtml' frameborder='0' marginheight='0' marginwidth='0'  src='http://www.lottejtb.com" + event_desc + "' onload='javascript:resizeEvent(this);'" +  " width='100%' style='height:60vh;' /></p>";
							vHTML += "			<p><iframe  id='winnerHtml' name='winnerHtml' frameborder='0' marginheight='0' marginwidth='0'  src='http://www.lottejtb.com" + event_desc + "' onload='javascript:resizeEvent(this);'" +  " width='100%' style='height:60vh;' /></p>";
						}else{
							vHTML += "			<p>"+ event_desc +"</p>";
						}
						vHTML += "		</div>";
						vHTML += "	</div>";
						vHTML += "</li>";
						
						$('#detailTab3').html(vHTML);
						$('#tabContent3').show();
					}else{
						var event_img = list[0].mblEeventUrl;
						
						if(nullToBlank(event_img) != "") {
							event_img = event_img.replace("http://www.lottejtb.com", "");
						};
						
						eventTitle = list[0].eventNm;
						applyCount = list[0].roundApplyCnt;
						eventLimitDay = list[0].eventToday;
						quizMngAns = list[0].mngAns;
						
						try {
							
							if(list[0].eventVote1 != null)
								eventVote[0] = list[0].eventVote1;
							if(list[0].eventVote2 != null)
								eventVote[1] = list[0].eventVote2;
							if(list[0].eventVote3 != null)
								eventVote[2] = list[0].eventVote3;
							if(list[0].eventVote4 != null)
								eventVote[3] = list[0].eventVote4;
							if(list[0].eventVote5 != null)
								eventVote[4] = list[0].eventVote5;
							if(list[0].eventVote6 != null)
								eventVote[5] = list[0].eventVote6;
							if(list[0].eventVote7 != null)
								eventVote[6] = list[0].eventVote7;
							if(list[0].eventVote8 != null)
								eventVote[7] = list[0].eventVote8;
							if(list[0].eventVote9 != null)
								eventVote[8] = list[0].eventVote9;
							if(list[0].eventVote10 != null)
								eventVote[9] = list[0].eventVote10; 
						
						} catch(e) {
							console.log(e);
						}
						
						vHTML += "<li class='header'>"
						vHTML += "	<h3>" + list[0].eventNm + "</h3><em>" + list[0].eventFrday + "~" + list[0].eventToday + "</em><i id='eventCnt'>" + "조회수:" + detailCnt + "</i>";
						vHTML += "</li>";
						vHTML += "<li class='content'>";
						vHTML += "	<div class='img'>";
						
						if(nullToBlank(event_img) != "") {
							//vHTML += "			<p><iframe  id='eventHtml' name='eventHtml' frameborder='0' marginheight='0' marginwidth='0'  src='http://www.lottejtb.com" + event_img + "' onload='javascript:resizeEvent1(this);'" +  " width='100%' style='height:60vh;' /></p>";
							vHTML += "			<p><iframe  id='eventHtml' name='eventHtml' frameborder='0' marginheight='0' marginwidth='0'  src='http://www.lottejtb.com" + event_img + "' onload='javascript:resizeEvent1(this);'" +  " width='100%' style='height:60vh;' /></p>";
						}
						vHTML += "	</div>";
						vHTML += "</li>";
						
						$('#detailTab1').html(vHTML);
						$('#tabContent1').show();
						
						/********************** 응모1 **********************/
						if(list[0].tempTypeCd == "20"){
							$("#entryTag").show();
						}
						/********************** 응모1**********************/
						
						/********************** 응모2 **********************/
						if(list[0].tempTypeCd == "60") {
							$("#entryTag2").show();
							
							//내용
							var etc_det_desc = list[0].etcDetDesc;
							
							if(nullToBlank(etc_det_desc) != "") {
								
								etc_det_desc.replaceAll("\n" , "<br/>");
								etc_det_desc.replaceAll("\r\n" , "<br/>");
								
								console.log(etc_det_desc);
								
								var desc = etc_det_desc.split("\n");
								
								if(desc != null && desc.length > 0) {
									for(var i=0; i < desc.length; i++) {
										$("#entryTag2_content").append("<li>" + desc[i] + "</li>");															
									}
								} 

							}
							
						}
						/********************** 응모2 **********************/
						
						
						/********************** 댓글 **********************/
						if(list[0].tempTypeCd == "30"){
							var commentList = data.commentList;
							commentCnt = data.commentCnt;
							var commentHTML = "";
							$("#commentTag").show();
							$("#commentMore").show();
							
							for(var i = 0; i < commentList.length; i++){
								commentHTML += "<li>";
								commentHTML += 		"<p>";
								commentHTML += 		"	<span>"+ msgBinding(commentList[i].loginId) +"</span>";
								if(commentList[i].custCd == custCd){
									commentHTML += 		"	<span>"+ commentList[i].insDt +"<em><a href='#' class='btnbox layerOpener' data-url='/commentConfirmPop.do?applySeq="+ commentList[i].applySeq +"' data-width='300' data-height='200' data-ok='yes' style='color:#ffffff;'>X삭제</a></em></span>";
								}else{
									commentHTML += 		"	<span>"+ commentList[i].insDt +"</span>";
								}
								commentHTML += 		"</p>";
								commentHTML += 		"<div>"+ commentList[i].eventCnts +"</div>";
								commentHTML += "</li>";
							}
							
							$("#commentList").html(commentHTML);
						}
						/********************** 댓글 **********************/
						
						/********************** 퀴즈 **********************/
						if(list[0].tempTypeCd == "40"){
							$("#quizTag").show();
						}
						/********************** 퀴즈 **********************/
						
						/********************** 출석체크 **********************/
						if(list[0].tempTypeCd == "50"){
							$("#attendTag").show();
														
							var attendlist = data.attendChkList;
							var tmpChk = 0;
							var insdt = "";
							for(var i= 0; i < attendlist.length; i++) {
								insdt = attendlist[i].insDt.split("-");
								if(nullToBlank(insdt) != '' && attendlist[i].eventChgubun != '01' && attendlist[i].eventChgubun != '02' && attendlist[i].eventChgubun != '03') {
									insdt = insdt[0] + insdt[1] + insdt[2];	
								}
								attendChkDay[i] = insdt;
								//console.log("attendlist=" + attendChkDay[i] + "length=" + attendChkDay.length);
								
								if(attendlist[i].eventChgubun == '01') { //10
									$("#ten_attend").addClass("event_off");
									$("#ten_attend").text("응모하셨습니다").css({"color":"white","font-size":".8em"});
								} else if(attendlist[i].eventChgubun == '02') { //15
									$('#fifteen_attend').addClass('event_off');
									$("#fifteen_attend").text("응모하셨습니다").css({"color":"white","font-size":".8em"});
								} else if(attendlist[i].eventChgubun == '03') { //100
									$('#hundread_attend').addClass('event_off');
									$("#hundread_attend").text("응모하셨습니다").css({"color":"white","font-size":".8em"});
								} else {
									tmpChk ++;
									//$('#ten_attend').removeClass('event_off');
									//$('#fifteen_attend').removeClass('event_off');
									//$('#hundread_attend').removeClass('event_off');
								}
							}
							//attendChkCnt = attendChkDay.length;
							attendChkCnt = tmpChk;
							setCalendar();
							
						
						}
						/********************** 출석체크 **********************/
						
						/********************** 투표 **********************/
						if(list[0].tempTypeCd == "70") {
						 	//fn_getVoteContentList();
						 						 
							var vHtml = '';
							$('#voteTag').show();
							
							console.log(">>>>>>>>>>>>>>>eventVote.length=" + eventVote.length);
							for(var i = 0; i < eventVote.length; i++) {
								if(i == 0){
									vHtml += "<li>";
									vHtml += "	<a onclick='javascript:fn_selVote(" + i + ")'>";
									vHtml += "		<span class='radiobox on' name='radiobox" + i + "'id='radiobox" + i + "'>";
									vHtml += "			<input data-role='none' type='radio' name='radio' id='radio" + i + "' value='" + eventVote[i] + "' checked='checked'>";
									vHtml += "		</span>";
									vHtml += "		<label for='sel_view" + i + "'>" + eventVote[i] + "</label>";
									vHtml += "	</a>";
									vHtml += "</li>";
								}else{
									vHtml += "<li>";
									vHtml += "	<a onclick='javascript:fn_selVote(" + i + ")'>";
									vHtml += "		<span class='radiobox' name='radiobox" + i + "'id='radiobox" + i + "'>";
									vHtml += "			<input data-role='none' type='radio' name='radio' id='radio" + i + "' value='" + eventVote[i] + "'>";
									vHtml += "		</span>";
									vHtml += "		<label for='sel_view" + i + "'>" + eventVote[i] + "</label>";
									vHtml += "	</a>";
									vHtml += "</li>";
								}
							}
							$('#selectpop_radio').append(vHtml);
						
						}
						/********************** 투표**********************/
						
					}
				}else{
					alert("조회 결과가 없습니다.");
					
					var preLocation = getCookieValue('preUrl');
					if(preLocation != '/event/event_list.do'){
						location.href = '/event/event_list.do';
					}else{
						pageBack();
					}
				}
			},
			error : function(err) {
				alert("조회 결과가 없습니다.");
				var preLocation = getCookieValue('preUrl');
				
				if(preLocation != '/event/event_list.do'){
					location.href = '/event/event_list.do';
				}else{
					pageBack();
				}
				
			},
			done : function(e) {
			}
			
		});
	};
	
	function fn_init() {
		//출석체크 활성화
		$('#attendChk').addClass('appon');
		$('#attendChkText').text("출석체크");
	}

	//투표선택값
	function fn_selVote(idx) {

		var radioboxTag = "#radiobox" + idx;
		var radioTag = "#radio" + idx;

		$('.radiobox').removeClass('on');
		$('.radio').removeAttr("checked");
		$(radioboxTag).addClass('on');
		$(radioTag).prop("checked", true);

		checkedValue = $('input:radio[name="radio"]:checked').val();
		console.log("checkedValue=" + checkedValue);

	}

	//투표 content 내용조회
	function fn_getVoteContentList() {

		var formData = new FormData();
		formData.append('eventSeq', eventSeq);

		cfn_ajax({
			type : "POST",
			async : false,
			url : "<c:url value='/event/voteContentList.do' />",
			data : formData,
			dataType : "json",
			cache : false,
			noloading : "no",
			timeOut : 60 * 5 * 1000,
			success : function(data) {
				/* var votelist = data.votecontentlist; 
				var vHtml = '';
				$('#voteTag').show();
				
				console.log("votelist=" + votelist);
				
				//for(var i = 0; i < votelist.length; i++) {
				for(var i = 0; i < 4; i++) {
					if(i == 0)
						vHtml += "<li><a href='javascript:fn_selVote(" + i + ")'><span class='radiobox on' name='radiobox" + i + "'id='radiobox" + i + "'><input data-role='none' type='radio' name='radio' id='radio" + i + "' value='선택" + i + "' checked='checked'></span><label for='sel_view" + i + "'>선택" + (i+1) + "</label></li>";
					else
						vHtml += "<li><a href='javascript:fn_selVote(" + i + ")'><span class='radiobox' name='radiobox" + i + "'id='radiobox" + i + "'><input data-role='none' type='radio' name='radio' id='radio" + i + "' value='선택" + i + "'></span><label for='sel_view" + i + "'>선택" + (i+1) + "</label></li>";
				}
				$('#selectpop_radio').append(vHtml); */

			},
			error : function(err) {
			},
			done : function(e) {
			}
		});
	}

	function resizeEvent(iframe) {
		/*
		var innerBody = iframe.contentWindow.document.body;
		var innerHeight = innerBody.scrollHeight + (innerBody.offsetHeight - innerBody.clientHeight);
		document.getElementById("winnerHtml").height = innerHeight;
		 */
	}

	function resizeEvent1(iframe) {
		/*
		var innerBody = iframe.contentWindow.document.body;
		var innerHeight = innerBody.scrollHeight + (innerBody.offsetHeight - innerBody.clientHeight);
		document.getElementById("eventHtml").height = innerHeight;
		 */
	}

	var fn_selectComment = function() {
		var startRow = 1;
		var endRow = Number(pageSize);

		var formCmtData = new FormData();
		formCmtData.append('eventSeq', eventSeq);
		formCmtData.append('startRow', startRow);
		formCmtData.append('endRow', endRow);

		cfn_ajax({
			type : "POST",
			async : false,
			url : "<c:url value='/event/commentList.do' />",
			data : formCmtData,
			dataType : "json",
			cache : false,
			noloading : "no",
			timeOut : 60 * 5 * 1000,
			success : function(data) {
				var commentList = data.commentList;
				commentCnt = data.commentCnt;
				var commentHTML = "";

				for (var i = 0; i < commentList.length; i++) {
					commentHTML += "<li>";
					commentHTML += "<p>";
					commentHTML += "	<span>"
							+ msgBinding(commentList[i].loginId) + "</span>";
					if (commentList[i].custCd == custCd) {
						commentHTML += "	<span>"
								+ commentList[i].insDt
								+ "<em><a href='#' class='btnbox layerOpener' data-url='/commentConfirmPop.do?applySeq="
								+ commentList[i].applySeq
								+ "' data-width='300' data-height='200' data-ok='yes' style='color:#ffffff;'>X삭제</a></em></span>";
					} else {
						commentHTML += "	<span>" + commentList[i].insDt
								+ "</span>";
					}
					commentHTML += "</p>";
					commentHTML += "<div>" + commentList[i].eventCnts
							+ "</div>";
					commentHTML += "</li>";
				}

				$("#commentList").html(commentHTML);
			},
			error : function(err) {

			},
			done : function(e) {
			}
		});
	}

	var fn_delComment = function(eventSeq, applySeq) {
		var formData = new FormData();
		formData.append('eventSeq', eventSeq);
		formData.append('applySeq', applySeq);

		cfn_ajax({
			type : "POST",
			async : false,
			url : "<c:url value='/event/deleteComment.do' />",
			data : formData,
			dataType : "json",
			cache : false,
			noloading : "no",
			timeOut : 60 * 5 * 1000,
			success : function(data) {
				alert("삭제되었습니다.");

				fn_selectComment();
			},
			error : function(err) {

			},
			done : function(e) {
			}
		});
	}

	var fn_moreComment = function() {
		var curRow = $("#commentList").children().length;
		startRow = curRow + 1;
		endRow = curRow + Number(pageSize);

		if (startRow > commentCnt) {
			alert("더이상 등록된 내역이 없습니다");
			return;
		}

		var formCmtData = new FormData();
		formCmtData.append('eventSeq', eventSeq);
		formCmtData.append('startRow', startRow);
		formCmtData.append('endRow', endRow);

		cfn_ajax({
			type : "POST",
			async : false,
			url : "<c:url value='/event/commentList.do' />",
			data : formCmtData,
			dataType : "json",
			cache : false,
			noloading : "no",
			timeOut : 60 * 5 * 1000,
			success : function(data) {
				var commentList = data.commentList;
				var commentHTML = "";

				for (var i = 0; i < commentList.length; i++) {
					commentHTML += "<li>";
					commentHTML += "<p>";
					commentHTML += "	<span>"
							+ msgBinding(commentList[i].loginId) + "</span>";
					if (commentList[i].custCd == custCd) {
						commentHTML += "	<span>"
								+ commentList[i].insDt
								+ "<em><a href='#' class='btnbox layerOpener' data-url='/commentConfirmPop.do?applySeq="
								+ commentList[i].applySeq
								+ "' data-width='300' data-height='200' data-ok='yes' style='color:#ffffff;'>X삭제</a></em></span>";
					} else {
						commentHTML += "	<span>" + commentList[i].insDt
								+ "</span>";
					}
					commentHTML += "</p>";
					commentHTML += "<div>" + commentList[i].eventCnts
							+ "</div>";
					commentHTML += "</li>";
				}

				$("#commentList").append(commentHTML);
			},
			error : function(err) {

			},
			done : function(e) {
			}
		});
		
		
		//10회이상 인경우
		$('#attend_10').on("click", function() {
				
		   if(attendChkDay.length < 10) {
				alert("응모대상이 아닙니다.");
			} else {
				document.location.href = "/eventAttendPop.do?atChkCnt=1";	
			}
		});
		
		
		//15회이상 인경우
		$('#attend_15').on("click", function() {
			if(attendChkDay.length < 15) {
				alert("응모대상이 아닙니다.");
			} else {
				document.location.href = "/eventAttendPop.do?atChkCnt=15";	
			}
		});
		

		//100% 인경우
		$('#attend_100').on("click", function() {
			if(attendChkDay.length < lastDay) {
				alert("응모대상이 아닙니다.");
			} else {
				document.location.href = "/eventAttendPop.do?atChkCnt=100";	
			}
		});
		
	}
	

	//[JEH] iframe 링크 클릭시 호출되는합수 - 20180131
	window.addEventListener("message", fn_ifrClickEvt, false);
	function fn_ifrClickEvt(event){
		var data = event.data;
		var org = event.origin
		
		if(org == 'http://www.lottejtb.com' && data == 'Y'){

			if(nullToBlank(custCd) == ""){
				hideLoading();
				$("html, body").css({"overflow":"auto"});
				if($(".layerPopup").size()){
					$(".layerPopup").remove();                 
				};
				
				location.href = "/sso/loginChk.do";
				return false;
			}else{
				var openWindow = window.open("about:blank");
				openWindow.location.href = "https://member.lpoint.com/door/user/mobile/change_user_info.jsp?sid=MLOTTEJTB";
// 				location.href = "https://member.lpoint.com/door/user/mobile/change_user_info.jsp?sid=MLOTTEJTB";
			}
			
		}else{
			console.log('postMessage 보안 에러');
			return;
		}
	};
	
</script>
	
</head>

<body>    
	<div role="main" class="ui-content contentWrap">
		<div class="nav navstitle">이벤트</div>
		
		<div class="event">
			<div id="tabContent1" class="tabContent1 mgT10" style="display:none">
				<ul data-role="listView" class="detail" id="detailTab1">
				</ul>
			</div>
			<div id="tabContent3" class="tabContent3 mgT10" style="display:none">
				<ul data-role="listView" class="detail"  id="detailTab3">
				</ul>
			</div>
			
			<!-- 응모 이벤트 -->
			<div id="entryTag" style="display:none;">
				<div class="check_wrap">
					<!-- <input type="checkbox" id="chkEntry">-->
					<!-- <label for="chkEntry"><i>이벤트 당첨자 선정 및 경품 발송을 위한 고객 정보 제공에 동의 합니다.</i></label>-->
					
				<!-- 정보제공동의 -->
				<div style="text-align: left; font-size: 13px; font-color:#303030">
					<p style="font-size: 15px; font-weight: bold">개인정보 수집 및 이용안내(선택)</p>
					<p>1) 당사는 여행상품의 예약 및 여행관련 서비스 제공 등의 업무처리를 위하여 아래와 같이 고객으로부터 최소한의 필수 정보를 수집하며, </p>
					<p>제공한 모든 개인정보는 별도의 동의가 없는 한 해당 목적 이외의 다른 목적으로 사용하지 않습니다.</p><br/>
					
						<div class="table_box st2">
							<table style="text-align: center; align: center;width:955px;">
								<colgroup>
									<col width="15%" />
									<col width="23%" />
									<col width="35%" />
									<col width="20%" />
								</colgroup>
							<thead>
								<tr>
								<th>구분</th>
								<th>수집하는 항목</th>
								<th>이용목적</th>
								<th>보유 및 이용기간</th>
								</tr>
							</thead>
							<tbody>
								<tr class="bor_top" style="text-align: center; align: center">
								<td>선택정보</td>
								<td>성명, 연락처, 주소, 이메일주소</td>
								<td>혜택 각종 이벤트 및 행사관련정보안내, 티켓 및 상품수령</td>
								<td style="font-size: 15px; font-weight: bold">목적달성 후 즉시 파기</td>
								</tr>
							</tbody>
							</table><br/>
						</div>
						
				<p>단, 상법 등 법령의 규정에 의하여 거래 관련 권리의무관계의 확인 등을 이유로 일정기간 보유해야 할 필요가 있을 경우에는 관련법령이 정한 기간 동안 보관 할 수 있습니다. </p><br/>
				<p>2) 동의 거부권 및 불이익 </p>
				<p>여행 예약 시 개인정보 수집, 이용에 대한 동의를 거부할 권리가 있으나, 동의를 거부할 경우 여행상품 예약 서비스 이용에 제한이 있음을 알려드립니다. </p>
				</div>	
				
					<div class="collapsContent">
						<div class="clauseList yakgwan clause1">
							<!--회원으로 로그인 할 경우-->
						</div>
							<div class="check_wrap floatR">
								<input type="radio" id="chkYNN4" name="chkYN4" value="N" class="rd" checked="checked">
								<label for="chkYNN4"><i>동의안함</i></label>
							</div>
							<div class="check_wrap float">
								<input type="radio" id="chkYNY4" name="chkYN4"  value="Y" class="rd">
								<label for="chkYNY34"><i>동의함</i></label>
							</div>							
					</div>						
					
					
					
				</div>
				<div class="more btn_apply appon">
					<a href="#" class="btnbox layerOpener" data-url="/eventEntryPop.do" data-width="300" data-height="200" data-ok="yes"><span class="purple2">이벤트 응모하기</span></a>
				</div>
			</div>
			<!-- 응모 이벤트 -->
			
			<!-- 응모이벤트2 -->
			<div id="entryTag2" style="display:none;">
				<div class="tabContent evinglist">
					<dl class="ft_acdon3 mt7 evt_list_box1" id ="entryTag2"> 						
						<!-- <dt id="entryTag2_title"><p>롯데 JTB 문화지원 프로젝트</p> 영화 &lt;몬스터&gt; 예매권 증정 이벤트</dt>-->
						<dd>
							<ul id="entryTag2_content">
								<!--<li id="entryTag2_content">영 화 명 : 몬수터 (만 19세 미만 관람 불가)</li>
								<li>응 모 기 간 : 2014. 2. 17 ~ 3. 9</li>
								<li>응 모 대 상 : 롯데제이티비 회원 중 만 19세 이상 회원 누구나</li>
								<li>당 첨 발 표 : 2014. 3. 11(화) / 당첨자 SMS 개별연락</li>
								<li>당 첨 인 원 : 40쌍 (1인 2매 예매권)</li>
								<li>예 매 방 법 : 추후 공지</li>
								<li>주 의 사 항 : 만 19세 미만 관람 불가 영화로 관람일 당일 신분증을 지참해 주세요,</li> -->
							</ul>
						</dd>
					</dl>
					<ul class="evt_list_box2" style="display:none;">
						<li>원활한 이벤트 진행을 위해 당첨된 고객님의 정보 (이름, 아이디, 핸드폰 뒷 4자리)가 제휴사에 제공 될 수 있으니 응모에 참고하시기 바랍니다.</li>
						<li>본 이벤트는 제휴사 및 롯데 JTB의 사정에 따라 변경 될 수 있습니다.</li>
						<li>수도권에서 진행되는 행사의 경우 지방 거주중인 고객님이 당첨되시더라도 예매권 및 기타 경품으로 변경되지 않습니다.</li>
					</ul>
					<div class="check_wrap evt_agree_chk">
						<!-- <input type="checkbox" id="chkEntry2">-->
						<!-- <label for="chkEntry2"><i>개인 정보 제공에 동의 합니다.<br>고객님의 정보는 이벤트 종료 후 한달 간 보관 후 폐기 됩니다.</i></label>-->
						
				<!-- 정보제공동의 -->
				<div style="text-align: left; font-size: 13px; font-color:#303030">
					<p style="font-size: 15px; font-weight: bold">개인정보 수집 및 이용안내(선택)</p>
					<p>1) 당사는 여행상품의 예약 및 여행관련 서비스 제공 등의 업무처리를 위하여 아래와 같이 고객으로부터 최소한의 필수 정보를 수집하며, </p>
					<p>제공한 모든 개인정보는 별도의 동의가 없는 한 해당 목적 이외의 다른 목적으로 사용하지 않습니다.</p><br/>
					
						<div class="table_box st2">
							<table style="text-align: center; align: center;width:955px;">
								<colgroup>
									<col width="15%" />
									<col width="23%" />
									<col width="35%" />
									<col width="20%" />
								</colgroup>
							<thead>
								<tr>
								<th>구분</th>
								<th>수집하는 항목</th>
								<th>이용목적</th>
								<th>보유 및 이용기간</th>
								</tr>
							</thead>
							<tbody>
								<tr class="bor_top" style="text-align: center; align: center">
								<td>선택정보</td>
								<td>성명, 연락처, 주소, 이메일주소</td>
								<td>혜택 각종 이벤트 및 행사관련정보안내, 티켓 및 상품수령</td>
								<td style="font-size: 15px; font-weight: bold">목적달성 후 즉시 파기</td>
								</tr>
							</tbody>
							</table><br/>
						</div>
						
				<p>단, 상법 등 법령의 규정에 의하여 거래 관련 권리의무관계의 확인 등을 이유로 일정기간 보유해야 할 필요가 있을 경우에는 관련법령이 정한 기간 동안 보관 할 수 있습니다. </p><br/>
				<p>2) 동의 거부권 및 불이익 </p>
				<p>여행 예약 시 개인정보 수집, 이용에 대한 동의를 거부할 권리가 있으나, 동의를 거부할 경우 여행상품 예약 서비스 이용에 제한이 있음을 알려드립니다. </p>
				</div>	
				
					<div class="collapsContent">
						<div class="clauseList yakgwan clause1">
							<!--회원으로 로그인 할 경우-->
						</div>
							<div class="check_wrap floatR">
								<input type="radio" id="chkYNN3" name="chkYN3" value="N" class="rd" checked="checked">
								<label for="chkYNN3"><i>동의안함</i></label>
							</div>
							<div class="check_wrap float">
								<input type="radio" id="chkYNY3" name="chkYN3"  value="Y" class="rd">
								<label for="chkYNY3"><i>동의함</i></label>
							</div>							
					</div>							
						
						
					</div>
					<div class="more btn_apply appon">
						<a href="#" class="btnbox layerOpener" data-url="/eventEntry2Pop.do" data-width="300" data-height="200" data-ok="yes"><span class="purple2">이벤트 응모하기</span></a>
					</div>
				</div>
			</div>
			<!-- 응모이벤트2 -->
			
			<!-- 댓글 이벤트 -->
			<div id="commentTag" style="display:none;">

				<div class="check_wrap">
					<!--<input type="checkbox" id="chkAll">
					<label for="chkAll"><i>이벤트 당첨자 선정 및 경품 발송을 위한 고객 정보 제공에 동의 합니다.</i></label>-->
					<div style="display:none;">
						<input type="checkbox" id="chkAll" checked="true">
					</div>
				<!-- 정보제공동의 -->
				<div style="text-align: left; font-size: 13px; font-color:#303030">
					<p style="font-size: 15px; font-weight: bold">개인정보 수집 및 이용안내(선택)</p>
					<p>1) 당사는 여행상품의 예약 및 여행관련 서비스 제공 등의 업무처리를 위하여 아래와 같이 고객으로부터 최소한의 필수 정보를 수집하며, </p>
					<p>제공한 모든 개인정보는 별도의 동의가 없는 한 해당 목적 이외의 다른 목적으로 사용하지 않습니다.</p><br/>
					
						<div class="table_box st2">
							<table style="text-align: center; align: center;width:955px;">
								<colgroup>
									<col width="15%" />
									<col width="23%" />
									<col width="35%" />
									<col width="20%" />
								</colgroup>
							<thead>
								<tr>
								<th>구분</th>
								<th>수집하는 항목</th>
								<th>이용목적</th>
								<th>보유 및 이용기간</th>
								</tr>
							</thead>
							<tbody>
								<tr class="bor_top" style="text-align: center; align: center">
								<td>선택정보</td>
								<td>성명, 연락처, 주소, 이메일주소</td>
								<td>혜택 각종 이벤트 및 행사관련정보안내, 티켓 및 상품수령</td>
								<td style="font-size: 15px; font-weight: bold">목적달성 후 즉시 파기</td>
								</tr>
							</tbody>
							</table><br/>
						</div>
						
				<p>단, 상법 등 법령의 규정에 의하여 거래 관련 권리의무관계의 확인 등을 이유로 일정기간 보유해야 할 필요가 있을 경우에는 관련법령이 정한 기간 동안 보관 할 수 있습니다. </p><br/>
				<p>2) 동의 거부권 및 불이익 </p>
				<p>여행 예약 시 개인정보 수집, 이용에 대한 동의를 거부할 권리가 있으나, 동의를 거부할 경우 여행상품 예약 서비스 이용에 제한이 있음을 알려드립니다. </p>
				</div>	
				
					<div class="collapsContent">
						<div class="clauseList yakgwan clause1">
							<!--회원으로 로그인 할 경우-->
						</div>
							<div class="check_wrap floatR">
								<input type="radio" id="chkYNN1" name="chkYN1" value="N" class="rd" checked="checked">
								<label for="chkYNN1"><i>동의안함</i></label>
							</div>
							<div class="check_wrap float">
								<input type="radio" id="chkYNY1" name="chkYN1"  value="Y" class="rd">
								<label for="chkYNY1"><i>동의함</i></label>
							</div>							
					</div>									
					
				<div class="cmt_inputbox">
					<input type="text" data-role="none" placeholder="댓글을 입력해주세요" id="cmtContent"/>
				</div>					

				</div>
				<!-- id="insertComment"-->
				<div class="more btnBG2">
					<a href="#" class="btnbox layerOpener" id="insertComment" data-url="/commentAlertPop.do" data-width="300" data-height="200" data-ok="yes"><span>댓글입력</span></a>
				</div>
				<ul class="cmt_list" id="commentList">
				</ul>
			</div>
			<!-- 댓글 이벤트 -->
			
			<!-- 퀴즈 이벤트 -->
			<div id="quizTag" style="display:none;">

				<div class="check_wrap">
					<!-- <input type="checkbox" id="chkQuiz">
					<label for="chkQuiz"><i>이벤트 당첨자 선정 및 경품 발송을 위한 고객 정보 제공에 동의 합니다.</i></label>-->
					
				<!-- 정보제공동의 -->
				<div style="text-align: left; font-size: 13px; font-color:#303030">
					<p style="font-size: 15px; font-weight: bold">개인정보 수집 및 이용안내(선택)</p>
					<p>1) 당사는 여행상품의 예약 및 여행관련 서비스 제공 등의 업무처리를 위하여 아래와 같이 고객으로부터 최소한의 필수 정보를 수집하며, </p>
					<p>제공한 모든 개인정보는 별도의 동의가 없는 한 해당 목적 이외의 다른 목적으로 사용하지 않습니다.</p><br/>
					
						<div class="table_box st2">
							<table style="text-align: center; align: center;width:955px;">
								<colgroup>
									<col width="15%" />
									<col width="23%" />
									<col width="35%" />
									<col width="20%" />
								</colgroup>
							<thead>
								<tr>
								<th>구분</th>
								<th>수집하는 항목</th>
								<th>이용목적</th>
								<th>보유 및 이용기간</th>
								</tr>
							</thead>
							<tbody>
								<tr class="bor_top" style="text-align: center; align: center">
								<td>선택정보</td>
								<td>성명, 연락처, 주소, 이메일주소</td>
								<td>혜택 각종 이벤트 및 행사관련정보안내, 티켓 및 상품수령</td>
								<td style="font-size: 15px; font-weight: bold">목적달성 후 즉시 파기</td>
								</tr>
							</tbody>
							</table><br/>
						</div>
						
				<p>단, 상법 등 법령의 규정에 의하여 거래 관련 권리의무관계의 확인 등을 이유로 일정기간 보유해야 할 필요가 있을 경우에는 관련법령이 정한 기간 동안 보관 할 수 있습니다. </p><br/>
				<p>2) 동의 거부권 및 불이익 </p>
				<p>여행 예약 시 개인정보 수집, 이용에 대한 동의를 거부할 권리가 있으나, 동의를 거부할 경우 여행상품 예약 서비스 이용에 제한이 있음을 알려드립니다. </p>
				</div>	
				
					<div class="collapsContent">
						<div class="clauseList yakgwan clause1">
							<!--회원으로 로그인 할 경우-->
						</div>
							<div class="check_wrap floatR">
								<input type="radio" id="chkYNN5" name="chkYN5" value="N" class="rd" checked="checked">
								<label for="chkYNN5"><i>동의안함</i></label>
							</div>
							<div class="check_wrap float">
								<input type="radio" id="chkYNY5" name="chkYN5"  value="Y" class="rd">
								<label for="chkYNY5"><i>동의함</i></label>
							</div>							
					</div>						
					
				</div>
				
				<div class="cmt_inputbox">
					<input type="text" data-role="none" placeholder="정답을 입력해주세요" id="quizAnswerText"/>
				</div>				
				
				<div class="more btn_apply">
					<a href="#" class="btnbox layerOpener" data-url="/eventQuizPop.do" data-width="300" data-height="200" data-ok="yes"><span>응모하기</span></a>
				</div>
			</div>
			<!-- 퀴즈 이벤트 -->
			
			<!-- 출석체크 -->
			<div id="attendTag" style="display:none;">
				<div class="check_wrap">
						<!-- <input type="checkbox" id="chkAttend">-->
						<!-- <label for="chkAttend"><i>이벤트 당첨자 선정 및 경품 발송을 위한 고객 정보 제공에 동의 합니다.</i></label>-->
					<div style="display:none;">
						<input type="checkbox" id="chkAttend" checked="true">
					</div>
					
				<!-- 정보제공동의 -->
				<div style="text-align: left; font-size: 13px; font-color:#303030">
					<p style="font-size: 15px; font-weight: bold">개인정보 수집 및 이용안내(선택)</p>
					<p>1) 당사는 여행상품의 예약 및 여행관련 서비스 제공 등의 업무처리를 위하여 아래와 같이 고객으로부터 최소한의 필수 정보를 수집하며, </p>
					<p>제공한 모든 개인정보는 별도의 동의가 없는 한 해당 목적 이외의 다른 목적으로 사용하지 않습니다.</p><br/>
					
						<div class="table_box st2">
							<table style="text-align: center; align: center;width:955px;">
								<colgroup>
									<col width="15%" />
									<col width="23%" />
									<col width="35%" />
									<col width="20%" />
								</colgroup>
							<thead>
								<tr>
								<th>구분</th>
								<th>수집하는 항목</th>
								<th>이용목적</th>
								<th>보유 및 이용기간</th>
								</tr>
							</thead>
							<tbody>
								<tr class="bor_top" style="text-align: center; align: center">
								<td>선택정보</td>
								<td>성명, 연락처, 주소, 이메일주소</td>
								<td>혜택 각종 이벤트 및 행사관련정보안내, 티켓 및 상품수령</td>
								<td style="font-size: 15px; font-weight: bold">목적달성 후 즉시 파기</td>
								</tr>
							</tbody>
							</table><br/>
						</div>
						
				<p>단, 상법 등 법령의 규정에 의하여 거래 관련 권리의무관계의 확인 등을 이유로 일정기간 보유해야 할 필요가 있을 경우에는 관련법령이 정한 기간 동안 보관 할 수 있습니다. </p><br/>
				<p>2) 동의 거부권 및 불이익 </p>
				<p>여행 예약 시 개인정보 수집, 이용에 대한 동의를 거부할 권리가 있으나, 동의를 거부할 경우 여행상품 예약 서비스 이용에 제한이 있음을 알려드립니다. </p>
				</div>	
				
					<div class="collapsContent">
						<div class="clauseList yakgwan clause1">
							<!--회원으로 로그인 할 경우-->
						</div>
							<div class="check_wrap floatR">
								<input type="radio" id="chkYNN2" name="chkYN2" value="N" class="rd" checked="checked">
								<label for="chkYNN2"><i>동의안함</i></label>
							</div>
							<div class="check_wrap float">
								<input type="radio" id="chkYNY2" name="chkYN2"  value="Y" class="rd">
								<label for="chkYNY2"><i>동의함</i></label>
							</div>							
					</div>						
											
					</div>
					<div class="more btn_apply" id="attendChk">
						<a href="#" class="btnbox layerOpener" data-url="/eventAttendPop.do?atChkCnt=1" data-width="300" data-height="200" data-ok="yes"><span class="purple2" id="attendChkText">출석체크</span></a>
	
					</div>
		
					<div id="calendarEvent">
					<!-- <div class="cldarbox">
						<p class="cld_title">2017.01 <span>출석일수 : 14일</span></p>
						<table class="pop_cldstyle">
							<thead>
								<tr>
									<th>SUN</th>
									<th>MON</th>
									<th>TUE</th>
									<th>WED</th>
									<th>THU</th>
									<th>FRI</th>
									<th>SAT</th>
								</tr>
							</thead>
							<tbody>
							<tr>
								<td><p></p></td>
								<td><p></p></td>
								<td><p></p></td>
								<td><p>1</p></td>
								<td><p>2</p></td>
								<td><p>3</p></td>
								<td><p>4</p></td>
							</tr>
							<tr>
								<td><p>5</p></td>
								<td><p>6</p></td>
								<td><p>7</p></td>
								<td class="cld_attdc"><p>8</p></td>
								<td><p>9</p></td>
								<td><p>10</p></td>
								<td><p>11</p></td>
							</tr>
							<tr>
								<td><p>12</p></td>
								<td><p>13</p></td>
								<td><p>14</p></td>
								<td><p>15</p></td>
								<td><p>16</p></td>
								<td><p>17</p></td>
								<td><p>18</p></td>
							</tr>
							<tr>
								<td><p>19</p></td>
								<td><p>20</p></td>
								<td><p>21</p></td>
								<td><p>22</p></td>
								<td><p>23</p></td>
								<td><p>24</p></td>
								<td><p>25</p></td>
							</tr>
							<tr>
								<td><p>26</p></td>
								<td><p>27</p></td>
								<td><p>28</p></td>
								<td><p>29</p></td>
								<td><p>30</p></td>
								<td><p></p></td>
								<td><p></p></td>
							</tr>
						</tbody>
						</table>
					</div>	 -->
					</div>
					<ul class="cld_chk_event">
						<li><span>10회 이상</span> 출석하고 <a class="btnbox layerOpener more" id="ten_attend" data-url="/eventAttendPop.do?atChkCnt=10" data-role="none" href="#" data-width="300" data-height="200" data-ok="yes"><span>응모하기</span></a></li>
						<li><span>15회 이상</span> 출석하고 <a class="btnbox layerOpener more" id="fifteen_attend" data-url="/eventAttendPop.do?atChkCnt=15" data-role="none" href="#" data-width="300" data-height="200" data-ok="yes"><span>응모하기</span></a></li>
						<li><span>100%</span> 출석하고 <a  class="btnbox layerOpener more" id="hundread_attend" data-url="/eventAttendPop.do?atChkCnt=100" data-role="none" href="#" data-width="300" data-height="200" data-ok="yes"><span>응모하기</span></a></li>
					</ul> 
				
			</div>
			<!-- 출석체크 -->
			
			<!-- 투표 -->
			<div id="voteTag" style="display:none;">

				<div class="check_wrap">
					<!-- <input type="checkbox" id="chkVote">
					<label for="chkVote"><i>이벤트 당첨자 선정 및 경품 발송을 위한 고객 정보 제공에 동의 합니다.</i></label>-->
					
				<!-- 정보제공동의 -->
				<div style="text-align: left; font-size: 13px; font-color:#303030">
					<p style="font-size: 15px; font-weight: bold">개인정보 수집 및 이용안내(선택)</p>
					<p>1) 당사는 여행상품의 예약 및 여행관련 서비스 제공 등의 업무처리를 위하여 아래와 같이 고객으로부터 최소한의 필수 정보를 수집하며, </p>
					<p>제공한 모든 개인정보는 별도의 동의가 없는 한 해당 목적 이외의 다른 목적으로 사용하지 않습니다.</p><br/>
					
						<div class="table_box st2">
							<table style="text-align: center; align: center;width:955px;">
								<colgroup>
									<col width="15%" />
									<col width="23%" />
									<col width="35%" />
									<col width="20%" />
								</colgroup>
							<thead>
								<tr>
								<th>구분</th>
								<th>수집하는 항목</th>
								<th>이용목적</th>
								<th>보유 및 이용기간</th>
								</tr>
							</thead>
							<tbody>
								<tr class="bor_top" style="text-align: center; align: center">
								<td>선택정보</td>
								<td>성명, 연락처, 주소, 이메일주소</td>
								<td>혜택 각종 이벤트 및 행사관련정보안내, 티켓 및 상품수령</td>
								<td style="font-size: 15px; font-weight: bold">목적달성 후 즉시 파기</td>
								</tr>
							</tbody>
							</table><br/>
						</div>
						
				<p>단, 상법 등 법령의 규정에 의하여 거래 관련 권리의무관계의 확인 등을 이유로 일정기간 보유해야 할 필요가 있을 경우에는 관련법령이 정한 기간 동안 보관 할 수 있습니다. </p><br/>
				<p>2) 동의 거부권 및 불이익 </p>
				<p>여행 예약 시 개인정보 수집, 이용에 대한 동의를 거부할 권리가 있으나, 동의를 거부할 경우 여행상품 예약 서비스 이용에 제한이 있음을 알려드립니다. </p>
				</div>	
				
					<div class="collapsContent">
						<div class="clauseList yakgwan clause1">
							<!--회원으로 로그인 할 경우-->
						</div>
							<div class="check_wrap floatR">
								<input type="radio" id="chkYNN6" name="chkYN6" value="N" class="rd" checked="checked">
								<label for="chkYNN6"><i>동의안함</i></label>
							</div>
							<div class="check_wrap float">
								<input type="radio" id="chkYNY6" name="chkYN6"  value="Y" class="rd">
								<label for="chkYNY6"><i>동의함</i></label>
							</div>							
					</div>						
					
				</div>			
				
				<ul class="selectpop_radio" id="selectpop_radio">
				<!-- 
					<li><span class="radiobox on"><input data-role="none" type="radio" name="radio" id="radio0" checked="checked"></span><label for="radio0">선택 1</label></li>
					<li><span class="radiobox"><input data-role="none" type="radio" name="radio" id="radio1"></span><label for="radio1">선택 2</label></li>
					<li><span class="radiobox"><input data-role="none" type="radio" name="radio" id="radio2"></span><label for="radio2">선택 3</label></li>
					<li><span class="radiobox"><input data-role="none" type="radio" name="radio" id="radio3"></span><label for="radio3">선택 4</label></li>
				 -->
				</ul>						
					
				</div>
				<div class="more btn_apply appon">
					<a href="#" class="btnbox layerOpener" data-url="/eventVotePop.do" data-width="300" data-height="200" data-ok="yes"><span class="purple2">응모하기</span></a>
				</div>
			<!-- 투표 -->
			
			
		</div>
			
		<div class="more" id="commentMore" style="display:none;" onclick="fn_moreComment();"><i class="fa fa-angle-down fa-2x"></i>더보기</div>
		<div class="more" id="goListBtn"><i class="fa fa-bars mgr5 list"></i>목록으로</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
</body>