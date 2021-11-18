<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<%
	String selAir = (String) request.getAttribute("selAir");
	String selHotel = (String) request.getAttribute("selHotel");
	String selRentcar = (String) request.getAttribute("selRentcar");
%>
<head>
<script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDb3QbLpTEk_Pa-32zEyUABiheOLebzQyQ" async defer></script>
<script src="/resources/common/js/jquery.googlemap.js"></script>
<script src="/resources/common/js/fit/common.js"></script>	
<script type="text/javascript">
	if(nullToBlank(getCookieValue('rentCarSearchData')) != ""){
		sessionStorage.rentCarSearchData = getCookieValue('rentCarSearchData');
		setCookieValue('rentCarSearchData', "");
	}
	
	var pageSize = '${pageSize}';
	var searchData = JSON.parse(sessionStorage.rentCarSearchData);
	var map;
	var officeCnt = 0;
	var officeDataset;
	var pickupLoc;
	var type;
	
	function getWeeksEng(col) {
		var dayName=new Array("SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"); // 숫자 요일을 문자 요일 바꿀 함수		
		return dayName[col];
	}
	
	// 초기화
	var fn_init = function() {
		var takeDay = searchData.rentTakeDate;
		var takeTime = searchData.rentTakeTime.substring(0, 2) + ":" + searchData.rentTakeTime.substring(2, 4);
		var returnDay = searchData.rentReturnDate;
		var returnTime = searchData.rentReturnTime.substring(0, 2) + ":" + searchData.rentReturnTime.substring(0, 2);
		
		var takeDate = new Date(takeDay.substring(0, 4), parseInt(takeDay.substring(4, 6)) - 1, takeDay.substring(6, 8));
		var takeNumday = getWeeksEng(takeDate.getDay());
		var returnDate = new Date(returnDay.substring(0, 4), parseInt(returnDay.substring(4, 6)) - 1, returnDay.substring(6, 8));
		var returnNumday = getWeeksEng(returnDate.getDay());
		
		var titTxt = "";
		if(searchData.samePlaceYn){
			type = "same";
			titTxt = "인수/반납";
		}else{
			type = "pickup";
			titTxt = "인수";
		}
		
		var formData = new FormData();
		formData.append('country', searchData.rentTakePlaceCountryCd);
		formData.append('city', searchData.rentTakePlaceCd);
		formData.append('searchType', searchData.rentTakeType);
		formData.append('takeNumday', takeNumday);
		formData.append('takeTime', takeTime);
		formData.append('returnNumday', returnNumday);
		formData.append('returnTime', returnTime);
		formData.append('type', type);
		
		cfn_ajax({
			url: "/fit/rnt/selectRentOffice.do",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:false,
			success: function(res) {
				officeDataset = res.officeList;
				officeCnt = officeDataset.length;
				
				var officeLen = officeCnt;
				
				//예약내역 더보기 버튼 활성화
				if(officeCnt < pageSize) {
					$("#officeMore").hide();
				} else {
					officeLen = pageSize;
					$("#officeMore").show();	
				}
				
				var vHTML = '';
				var dateList = [];
				
				$("#officeResult").html(titTxt +" 영업소 조회 결과 for "+ searchData.rentTakePlaceNm +" ("+ officeCnt +" locations)");
				
				for(var i = 0; i < officeLen; i++){
					var firstNm = "";
					var firstDt = "";
					var lastNm = "";
					var lastDt = "";
					var dateList = [
			                {'name' : 'MON', 'time' : officeDataset[i].monTime},
			                {'name' : 'TUE', 'time' : officeDataset[i].tueTime},
			                {'name' : 'WED', 'time' : officeDataset[i].wedTime},
			                {'name' : 'THU', 'time' : officeDataset[i].thuTime},
			                {'name' : 'FRI', 'time' : officeDataset[i].friTime},
			                {'name' : 'SAT', 'time' : officeDataset[i].satTime},
			                {'name' : 'SUN', 'time' : officeDataset[i].sunTime}
					];
					
					vHTML += '<dt>';
					vHTML += '	<em>'+ (i + 1) +'</em>';
					vHTML += '	<span>'+ officeDataset[i].descriptionLocationName +'</span>'
					//HTML += '	<a href="#" class="layerOpener ui-link" data-url="/pop/pop_rentcar_map.do?lat='+ dataset[i].latitude +'&lng='+ dataset[i].longitude +'" data-width="400" data-height="400" data-ctn="full"></a>'
					vHTML += '	<a href="#" onclick="openMap(\''+ officeDataset[i].latitude +'\',\''+ officeDataset[i].longitude +'\')"></a>'
					vHTML += '</dt>';
					vHTML += '<dd>';
					vHTML += '	<div class="fr_lc_textbox">';
					if(nullToBlank(officeDataset[i].wnaMsg) != ""){
						vHTML += '		<p class="f_red" style="margin-right: 5px;">* '+ officeDataset[i].wnaMsg +'</p>';
					}
					if(nullToBlank(officeDataset[i].pflMsg) != ""){
						vHTML += '		<p class="f_red" style="margin-right: 5px;">* '+ officeDataset[i].pflMsg +'</p>';
					}
					if(nullToBlank(officeDataset[i].hgoMsg) != ""){
						vHTML += '		<p class="f_red" style="margin-right: 5px;">* '+ officeDataset[i].hgoMsg +'</p>';	
					}
					vHTML += '		Shop '+ nullToBlank(officeDataset[i].address1) + ' ' + nullToBlank(officeDataset[i].address2) + ' ' + nullToBlank(officeDataset[i].address3) +'<br>';
					vHTML += '		'+ searchData.rentTakePlaceNm +'<br>';
					vHTML += '		<dl>';
					vHTML += '			<dt>전화번호 : </dt>';
					if(nullToBlank(officeDataset[i].phone) == ""){
						vHTML += '			<dd></dd>';
					}else if(officeDataset[i].phone.length == 10){
						vHTML += '			<dd>'+ officeDataset[i].phone.substring(0, 3) +'-'+ officeDataset[i].phone.substring(3, 6) +'-'+ officeDataset[i].phone.substring(7, 10) +'</dd>';
					}else if(officeDataset[i].phone.length == 11){
						vHTML += '			<dd>'+ officeDataset[i].phone.substring(0, 3) +'-'+ officeDataset[i].phone.substring(3, 7) +'-'+ officeDataset[i].phone.substring(7, 11) +'</dd>';
					}else{
						vHTML += '			<dd>'+ officeDataset[i].phone +'</dd>';
					}
					vHTML += '		</dl>';
					vHTML += '		<dl>';
					vHTML += '			<dt>영업시간 : </dt>';
					vHTML += '			<dd>';
					for(var j = 0; j < dateList.length; j++){
						//if(nullToBlank(firstDt) == ""){
						if(j == 0){
							firstNm = dateList[j].name;
							firstDt = dateList[j].time;	
						}else{
							if(firstDt == dateList[j].time){
								lastNm = dateList[j].name;
								lastDt = dateList[j].time;
							}else{
								if(nullToBlank(lastDt) == ""){
									if(firstDt == "00:00~24:00"){
										vHTML += firstNm +' open 24 hours<br/>';
									}else if(nullToBlank(firstDt) == ""){
										vHTML += firstNm +' closed<br/>';
									}else{
										vHTML += firstNm +' '+ firstDt +'<br/>';	
									}
								}else{
									if(firstDt == "00:00~24:00"){
										vHTML += firstNm +'-'+ lastNm +' open 24 hours<br/>';
									}else if(nullToBlank(firstDt) == ""){
										vHTML += firstNm +'-'+ lastNm +' closed<br/>';
									}else{
										vHTML += firstNm +'-'+ lastNm +' '+ firstDt +'<br/>';	
									}
								}
								
								firstNm = dateList[j].name;
								firstDt = dateList[j].time;
								lastNm = "";
								lastDt = "";
							}
						}
					}
					
					if(nullToBlank(firstNm) != ""){
						if(nullToBlank(lastNm) == ""){
							if(firstDt == "00:00~24:00"){
								vHTML += firstNm +' open 24 hours<br/>';
							}else if(nullToBlank(firstDt) == ""){
								vHTML += firstNm +' closed<br/>';
							}else{
								vHTML += firstNm +' '+ firstDt +'<br/>';	
							}
						}else{
							if(firstDt == "00:00~24:00"){
								vHTML += firstNm +'-'+ lastNm +' open 24 hours<br/>';
							}else if(nullToBlank(firstDt) == ""){
								vHTML += firstNm +'-'+ lastNm +' closed<br/>';
							}else{
								vHTML += firstNm +'-'+ lastNm +' '+ firstDt +'<br/>';	
							}
						}
					}
					vHTML += '				';
					vHTML += '			</dd>';
					vHTML += '		</dl>';
					//vHTML += '		영업소 종류 : 독립 라이센스 영업소';
					vHTML += '	</div>';
					vHTML += '	<div class="btn_one lc_re_tbtn"><button class="purple2" data-role="none" onclick="fn_selOffice(\''+ officeDataset[i].vendorIdBrand +'\', \''+ officeDataset[i].oagCode +'\', \''+ type +'\');">'+ titTxt +' 영업소 선택</button></div>';
					vHTML += '</dd>';
				}
					
				if(officeCnt == 0){
					vHTML += '<div class="fr_nodata" style="line-height:2;">';
					vHTML += '	<p>검색하신 조건으로<br>검색된 영업소가 없습니다.</p>';
					vHTML += '</div>';
				}
				
				$("#rentalCarOffice").html(vHTML);
			},
			error:function(err){
			},
			complete:function(){
			}
		});
	};
	
	var fn_officeMore = function(){
		//officeDataset
		var curRow = $("#rentalCarOffice").children("dt").length;
		startRow = curRow + 1;
		endRow = curRow + Number(pageSize);
		
		if(startRow > officeCnt) {
			setAlert("더이상 등록된 내역이 없습니다");
			return;
		}
		
		if(officeCnt > endRow){
			officeLen = endRow;
		}else{
			officeLen = officeCnt; 
			$("#officeMore").hide();
		}
		
		var titTxt =  "";
		
		if(type == "same"){
			titTxt = "인수/반납";
		}else if(type == "pickup"){
			titTxt = "인수"
		}else{
			titTxt = "반납"
		}
		
		var vHTML = "";
		for(var i = curRow; i < officeLen; i++){
			var firstNm = "";
			var firstDt = "";
			var lastNm = "";
			var lastDt = "";
			var dateList = [
	                {'name' : 'MON', 'time' : officeDataset[i].monTime},
	                {'name' : 'TUE', 'time' : officeDataset[i].tueTime},
	                {'name' : 'WED', 'time' : officeDataset[i].wedTime},
	                {'name' : 'THU', 'time' : officeDataset[i].thuTime},
	                {'name' : 'FRI', 'time' : officeDataset[i].friTime},
	                {'name' : 'SAT', 'time' : officeDataset[i].satTime},
	                {'name' : 'SUN', 'time' : officeDataset[i].sunTime}
			];
			
			vHTML += '<dt>';
			vHTML += '	<em>'+ (i + 1) +'</em>';
			vHTML += '	<span>'+ officeDataset[i].descriptionLocationName +'</span>'
			//HTML += '	<a href="#" class="layerOpener ui-link" data-url="/pop/pop_rentcar_map.do?lat='+ dataset[i].latitude +'&lng='+ dataset[i].longitude +'" data-width="400" data-height="400" data-ctn="full"></a>'
			vHTML += '	<a href="#" onclick="openMap(\''+ officeDataset[i].latitude +'\',\''+ officeDataset[i].longitude +'\')"></a>'
			vHTML += '</dt>';
			vHTML += '<dd>';
			vHTML += '	<div class="fr_lc_textbox">';
			if(nullToBlank(officeDataset[i].wnaMsg) != ""){
				vHTML += '		<p class="f_red" style="margin-right: 5px;">* '+ officeDataset[i].wnaMsg +'</p>';
			}
			if(nullToBlank(officeDataset[i].pflMsg) != ""){
				vHTML += '		<p class="f_red" style="margin-right: 5px;">* '+ officeDataset[i].pflMsg +'</p>';
			}
			if(nullToBlank(officeDataset[i].hgoMsg) != ""){
				vHTML += '		<p class="f_red" style="margin-right: 5px;">* '+ officeDataset[i].hgoMsg +'</p>';	
			}
			vHTML += '		Shop '+ nullToBlank(officeDataset[i].address1) + ' ' + nullToBlank(officeDataset[i].address2) + ' ' + nullToBlank(officeDataset[i].address3) +'<br>';
			if(type == "return"){
				vHTML += '		'+ searchData.rentReturnPlaceNm +'<br>';
			}else{
				vHTML += '		'+ searchData.rentTakePlaceNm +'<br>';
			}
			vHTML += '		<dl>';
			vHTML += '			<dt>전화번호 : </dt>';
			if(nullToBlank(officeDataset[i].phone) == ""){
				vHTML += '			<dd></dd>';
			}else if(officeDataset[i].phone.length == 10){
				vHTML += '			<dd>'+ officeDataset[i].phone.substring(0, 3) +'-'+ officeDataset[i].phone.substring(3, 6) +'-'+ officeDataset[i].phone.substring(7, 10) +'</dd>';
			}else if(officeDataset[i].phone.length == 11){
				vHTML += '			<dd>'+ officeDataset[i].phone.substring(0, 3) +'-'+ officeDataset[i].phone.substring(3, 7) +'-'+ officeDataset[i].phone.substring(7, 11) +'</dd>';
			}else{
				vHTML += '			<dd>'+ officeDataset[i].phone +'</dd>';
			}
			vHTML += '		</dl>';
			vHTML += '		<dl>';
			vHTML += '			<dt>영업시간 : </dt>';
			vHTML += '			<dd>';
			for(var j = 0; j < dateList.length; j++){
				//if(nullToBlank(firstDt) == ""){
				if(j == 0){
					firstNm = dateList[j].name;
					firstDt = dateList[j].time;	
				}else{
					if(firstDt == dateList[j].time){
						lastNm = dateList[j].name;
						lastDt = dateList[j].time;
					}else{
						if(nullToBlank(lastDt) == ""){
							if(firstDt == "00:00~24:00"){
								vHTML += firstNm +' open 24 hours<br/>';
							}else if(nullToBlank(firstDt) == ""){
								vHTML += firstNm +' closed<br/>';
							}else{
								vHTML += firstNm +' '+ firstDt +'<br/>';	
							}
						}else{
							if(firstDt == "00:00~24:00"){
								vHTML += firstNm +'-'+ lastNm +' open 24 hours<br/>';
							}else if(nullToBlank(firstDt) == ""){
								vHTML += firstNm +'-'+ lastNm +' closed<br/>';
							}else{
								vHTML += firstNm +'-'+ lastNm +' '+ firstDt +'<br/>';	
							}
						}
						
						firstNm = dateList[j].name;
						firstDt = dateList[j].time;
						lastNm = "";
						lastDt = "";
					}
				}
			}
			
			if(nullToBlank(firstNm) != ""){
				if(nullToBlank(lastNm) == ""){
					if(firstDt == "00:00~24:00"){
						vHTML += firstNm +' open 24 hours<br/>';
					}else if(nullToBlank(firstDt) == ""){
						vHTML += firstNm +' closed<br/>';
					}else{
						vHTML += firstNm +' '+ firstDt +'<br/>';	
					}
				}else{
					if(firstDt == "00:00~24:00"){
						vHTML += firstNm +'-'+ lastNm +' open 24 hours<br/>';
					}else if(nullToBlank(firstDt) == ""){
						vHTML += firstNm +'-'+ lastNm +' closed<br/>';
					}else{
						vHTML += firstNm +'-'+ lastNm +' '+ firstDt +'<br/>';	
					}
				}
			}
			vHTML += '				';
			vHTML += '			</dd>';
			vHTML += '		</dl>';
			//vHTML += '		영업소 종류 : 독립 라이센스 영업소';
			vHTML += '	</div>';
			vHTML += '	<div class="btn_one lc_re_tbtn"><button class="purple2" data-role="none" onclick="fn_selOffice(\''+ officeDataset[i].vendorIdBrand +'\', \''+ officeDataset[i].oagCode +'\', \''+ type +'\');">'+ titTxt +' 영업소 선택</button></div>';
			vHTML += '</dd>';
		}
			
		$("#rentalCarOffice").append(vHTML);
	}

	var fn_search = function() {
	};

	// 버튼 초기화
	var fn_initButton = function() {
	};
	
	var fn_selOffice = function(vendorId, oagCode, type) {
		if(type == 'pickup'){
			pickupLoc = oagCode
			setAlert("반납 영업소를 선택하세요");
			fn_returnOffice();
		}else if(type == 'return'){
			var parameter = "?vendorId="+ vendorId +"&pkOagCode="+ pickupLoc +"&rtOagCode="+ oagCode +"&selAir=" + "<%=selAir%>" + "&selHotel=" + "<%=selHotel%>" + "&selRentcar=" + "<%=selRentcar%>";
			
			movePage("/free/search_result_rentcar.do"+ parameter);	
		}else{
			var parameter = "?vendorId="+ vendorId +"&pkOagCode="+ oagCode +"&rtOagCode="+ oagCode +"&selAir=" + "<%=selAir%>" + "&selHotel=" + "<%=selHotel%>" + "&selRentcar=" + "<%=selRentcar%>";
			
			movePage("/free/search_result_rentcar.do"+ parameter);
		}
	}
	
	var fn_returnOffice = function(){
		type = 'return';
		titTxt = "반납";
		
		var rentalCarFt = $("div[ft-att=RCREGroup]");
		var takeDayArr = rentalCarFt.find("#dep_dt").text().split(".");
		var takeDay = takeDayArr[0] + takeDayArr[1] + takeDayArr[2];
		var takeTimeVal = rentalCarFt.find("#takeTime option:selected").val();
		var takeTime = takeTimeVal.substring(0, 2) + ":" + takeTimeVal.substring(2, 4);
		var returnDayArr = rentalCarFt.find("#arr_dt").text().split(".");
		var returnDay = returnDayArr[0] + returnDayArr[1] + returnDayArr[2];
		var returnTimeVal = rentalCarFt.find("#returnTime option:selected").val();
		var returnTime = returnTimeVal.substring(0, 2) + ":" + returnTimeVal.substring(0, 2);
		
		var takeDate = new Date(takeDay.substring(0, 4), parseInt(takeDay.substring(4, 6)) - 1, takeDay.substring(6, 8));
		var takeNumday = getWeeksEng(takeDate.getDay());
		var returnDate = new Date(returnDay.substring(0, 4), parseInt(returnDay.substring(4, 6)) - 1, returnDay.substring(6, 8));
		var returnNumday = getWeeksEng(returnDate.getDay());
		
		var rentTakePlaceCd;
		var rentTakeType;
		var rentReturnPlaceCd;
		var rentReturnType;
		
		if(nullToBlank(rentalCarFt.find("#take_place_cd").val()) != ""){
			rentTakePlaceCd = rentalCarFt.find("#take_place_cd").val();
			rentTakeType = "CITY";
		}else{
			rentTakePlaceCd = rentalCarFt.find("#take_place_oagCd").val();
			rentTakeType = "OAG_CODE";
		}
		
		if(nullToBlank(rentalCarFt.find("#return_place_cd").val()) != ""){
			rentReturnPlaceCd = rentalCarFt.find("#return_place_cd").val();
			rentReturnType = "CITY";
		}else{
			rentReturnPlaceCd = rentalCarFt.find("#return_place_cd").val();
			rentReturnType = "OAG_CODE";
		}
		
		var formData = new FormData();
		formData.append('country', rentalCarFt.find("#return_place_countryCd").val());
		formData.append('city', rentReturnPlaceCd);
		formData.append('searchType', rentTakeType);
		formData.append('takeNumday', takeNumday);
		formData.append('takeTime', takeTime);
		formData.append('returnNumday', returnNumday);
		formData.append('returnTime', returnTime);
		formData.append('type', type);
		
		cfn_ajax({
			url: "/fit/rnt/selectRentOffice.do",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:false,
			success: function(res) {
				officeDataset = res.officeList;
				officeCnt = officeDataset.length;
				
				var officeLen = officeCnt;
				
				//예약내역 더보기 버튼 활성화
				if(officeCnt < pageSize) {
					$("#officeMore").hide();
				} else {
					officeLen = pageSize;
					$("#officeMore").show();	
				}
				
				var vHTML = '';
				var dateList = [];
				
				$("#officeResult").html(titTxt +" 영업소 조회 결과 for "+ rentalCarFt.find("#arr_place").val() +" ("+ officeCnt +" locations)");
				
				for(var i = 0; i < officeLen; i++){
					var firstNm = "";
					var firstDt = "";
					var lastNm = "";
					var lastDt = "";
					var dateList = [
			                {'name' : 'MON', 'time' : officeDataset[i].monTime},
			                {'name' : 'TUE', 'time' : officeDataset[i].tueTime},
			                {'name' : 'WED', 'time' : officeDataset[i].wedTime},
			                {'name' : 'THU', 'time' : officeDataset[i].thuTime},
			                {'name' : 'FRI', 'time' : officeDataset[i].friTime},
			                {'name' : 'SAT', 'time' : officeDataset[i].satTime},
			                {'name' : 'SUN', 'time' : officeDataset[i].sunTime}
					];
					
					vHTML += '<dt>';
					vHTML += '	<em>'+ (i + 1) +'</em>';
					vHTML += '	<span>'+ officeDataset[i].descriptionLocationName +'</span>'
					//HTML += '	<a href="#" class="layerOpener ui-link" data-url="/pop/pop_rentcar_map.do?lat='+ dataset[i].latitude +'&lng='+ dataset[i].longitude +'" data-width="400" data-height="400" data-ctn="full"></a>'
					vHTML += '	<a href="#" onclick="openMap(\''+ officeDataset[i].latitude +'\',\''+ officeDataset[i].longitude +'\')"></a>'
					vHTML += '</dt>';
					vHTML += '<dd>';
					vHTML += '	<div class="fr_lc_textbox">';
					if(nullToBlank(officeDataset[i].wnaMsg) != ""){
						vHTML += '		<p class="f_red" style="margin-right: 5px;">* '+ officeDataset[i].wnaMsg +'</p>';
					}
					if(nullToBlank(officeDataset[i].pflMsg) != ""){
						vHTML += '		<p class="f_red" style="margin-right: 5px;">* '+ officeDataset[i].pflMsg +'</p>';
					}
					if(nullToBlank(officeDataset[i].hgoMsg) != ""){
						vHTML += '		<p class="f_red" style="margin-right: 5px;">* '+ officeDataset[i].hgoMsg +'</p>';	
					}
					vHTML += '		Shop '+ nullToBlank(officeDataset[i].address1) + ' ' + nullToBlank(officeDataset[i].address2) + ' ' + nullToBlank(officeDataset[i].address3) +'<br>';
					vHTML += '		'+ rentalCarFt.find("#arr_place").val() +'<br>';
					vHTML += '		<dl>';
					vHTML += '			<dt>전화번호 : </dt>';
					if(nullToBlank(officeDataset[i].phone) == ""){
						vHTML += '			<dd></dd>';
					}else if(officeDataset[i].phone.length == 10){
						vHTML += '			<dd>'+ officeDataset[i].phone.substring(0, 3) +'-'+ officeDataset[i].phone.substring(3, 6) +'-'+ officeDataset[i].phone.substring(7, 10) +'</dd>';
					}else if(officeDataset[i].phone.length == 11){
						vHTML += '			<dd>'+ officeDataset[i].phone.substring(0, 3) +'-'+ officeDataset[i].phone.substring(3, 7) +'-'+ officeDataset[i].phone.substring(7, 11) +'</dd>';
					}else{
						vHTML += '			<dd>'+ officeDataset[i].phone +'</dd>';
					}
					vHTML += '		</dl>';
					vHTML += '		<dl>';
					vHTML += '			<dt>영업시간 : </dt>';
					vHTML += '			<dd>';
					for(var j = 0; j < dateList.length; j++){
						//if(nullToBlank(firstDt) == ""){
						if(j == 0){
							firstNm = dateList[j].name;
							firstDt = dateList[j].time;	
						}else{
							if(firstDt == dateList[j].time){
								lastNm = dateList[j].name;
								lastDt = dateList[j].time;
							}else{
								if(nullToBlank(lastDt) == ""){
									if(firstDt == "00:00~24:00"){
										vHTML += firstNm +' open 24 hours<br/>';
									}else if(nullToBlank(firstDt) == ""){
										vHTML += firstNm +' closed<br/>';
									}else{
										vHTML += firstNm +' '+ firstDt +'<br/>';	
									}
								}else{
									if(firstDt == "00:00~24:00"){
										vHTML += firstNm +'-'+ lastNm +' open 24 hours<br/>';
									}else if(nullToBlank(firstDt) == ""){
										vHTML += firstNm +'-'+ lastNm +' closed<br/>';
									}else{
										vHTML += firstNm +'-'+ lastNm +' '+ firstDt +'<br/>';	
									}
								}
								
								firstNm = dateList[j].name;
								firstDt = dateList[j].time;
								lastNm = "";
								lastDt = "";
							}
						}
					}
					
					if(nullToBlank(firstNm) != ""){
						if(nullToBlank(lastNm) == ""){
							if(firstDt == "00:00~24:00"){
								vHTML += firstNm +' open 24 hours<br/>';
							}else if(nullToBlank(firstDt) == ""){
								vHTML += firstNm +' closed<br/>';
							}else{
								vHTML += firstNm +' '+ firstDt +'<br/>';	
							}
						}else{
							if(firstDt == "00:00~24:00"){
								vHTML += firstNm +'-'+ lastNm +' open 24 hours<br/>';
							}else if(nullToBlank(firstDt) == ""){
								vHTML += firstNm +'-'+ lastNm +' closed<br/>';
							}else{
								vHTML += firstNm +'-'+ lastNm +' '+ firstDt +'<br/>';	
							}
						}
					}
					vHTML += '				';
					vHTML += '			</dd>';
					vHTML += '		</dl>';
					//vHTML += '		영업소 종류 : 독립 라이센스 영업소';
					vHTML += '	</div>';
					vHTML += '	<div class="btn_one lc_re_tbtn"><button class="purple2" data-role="none" onclick="fn_selOffice(\''+ officeDataset[i].vendorIdBrand +'\', \''+ officeDataset[i].oagCode +'\', \''+ type +'\');">'+ titTxt +' 영업소 선택</button></div>';
					vHTML += '</dd>';
				}
					
				if(officeCnt == 0){
					vHTML += '<div class="fr_nodata" style="line-height:2;">';
					vHTML += '	<p>검색하신 조건으로<br>검색된 영업소가 없습니다.</p>';
					vHTML += '</div>';
				}
				
				$("#rentalCarOffice").html(vHTML);
			},
			error:function(err){
			},
			complete:function(){
			}
		});
	}
	
	var openMap = function(lat, lng){
		if(nullToBlank(lat) == "" || nullToBlank(lng) == ""){
			setAlert("해당하는 위치 정보가 없습니다.");
			return false;	
		}else{
			var myLatLng = {
				lat : parseFloat(lat),
				lng : parseFloat(lng)
			};
			
			map = new google.maps.Map(document.getElementById('showMap'), {
				center : myLatLng,
				scrollwheel : false,
				zoom : 17
			});
			
			// Create a marker and set its position.
			var marker = new google.maps.Marker({
				position : myLatLng,
				map : map,
			    draggable: true,
			});
			
			marker.setMap(map);
	
			$("#googleMapPop").click();
		}
	}
	
	function fn_searchSetting(){
		$("#same_place").change(function(){
			if($(this).is(":checked")){
				$("#arr_place").prop("disabled", true);
				
				var takePlaceCd = $("#take_place_cd").val();				
				var takePlaceNm = $("#dep_place").val();
				var countryCd = $("#take_place_countryCd").val();

				$("#return_place_cd").val(takePlaceCd);
				$("#return_place_countryCd").val(countryCd);
				$("#arr_place").val(takePlaceNm);
			}else{
				$("#arr_place").prop("disabled", false);
			}
		});
		
		var vHTML_time = "";
		var vHTML_driver = "";
		
		for(var x = 0; x < 24; x++){
			if(x < 10){
				vHTML_time += '<option value="0'+ x +'00">0'+ x +':00</option>';
				vHTML_time += '<option value="0'+ x +'30">0'+ x +':30</option>';
			}else{
				vHTML_time += '<option value="'+ x +'00">'+ x +':00</option>';
				vHTML_time += '<option value="'+ x +'30">'+ x +':30</option>';
			}
		}
		
		$("#takeTime").html(vHTML_time);
		$("#returnTime").html(vHTML_time);		
		
		vHTML_driver += '<option value="">운전자 나이 (인수일 기준)</option>';
		vHTML_driver += '<option value="70">만70+**세</option>';
		vHTML_driver += '<option value="30">만30~69세</option>';
		
		for(var y = 29; y > 17; y--){
			vHTML_driver += '<option value="'+ y +'">만'+ y +'세</option>';
		}
		
		$("#driverAge").html(vHTML_driver);
		
		var takeDateStr = searchData.rentTakeDate.substring(0, 4) + "." + searchData.rentTakeDate.substring(4, 6) + "." + searchData.rentTakeDate.substring(6, 8);
		var takeTimeStr = searchData.rentTakeTime.substring(0, 2) + ":" + searchData.rentTakeTime.substring(2, 4);
		var returnDateStr = searchData.rentReturnDate.substring(0, 4) + "." + searchData.rentReturnDate.substring(4, 6) + "." + searchData.rentReturnDate.substring(6, 8);
		var returnTimeStr = searchData.rentReturnTime.substring(0, 2) + ":" + searchData.rentReturnTime.substring(2, 4);
		
		$("#rentFromToDate").text(takeDateStr + " " + takeTimeStr + " ~ " + returnDateStr + " " + returnTimeStr);
		
		$(".re_schview").find("#dep_dt").text(takeDateStr);
		$(".re_schview").find("#take_date").val(searchData.rentTakeDate);
		$(".re_schview").find("#arr_dt").text(returnDateStr);
		$(".re_schview").find("#return_date").val(searchData.rentReturnDate);
		$(".re_schview").find("#takeTime").val(searchData.rentTakeTime).prop("selected", true);
		$(".re_schview").find("#returnTime").val(searchData.rentReturnTime).prop("selected", true);
		$(".re_schview").find("#driverAge").val(searchData.driverAge).prop("selected", true);
		
		if(searchData.rentTakeType == "CITY"){
			$(".re_schview").find("#take_place_cd").val(searchData.rentTakePlaceCd);
		}else{
			$(".re_schview").find("#take_place_oagCd").val(searchData.rentTakePlaceCd);
		}
		
		$(".re_schview").find("#dep_place").val(searchData.rentTakePlaceNm);
		$(".re_schview").find("#take_place_countryCd").val(searchData.rentTakePlaceCountryCd);
		$(".re_schview").find("#dep_place").val(searchData.rentTakePlaceNm);
		
		if(searchData.rentReturnType == "CITY"){
			$(".re_schview").find("#return_place_cd").val(searchData.rentReturnPlaceCd);
		}else{
			$(".re_schview").find("#return_place_oagCd").val(searchData.rentReturnPlaceCd);
		}
		
		$(".re_schview").find("#arr_place").val(searchData.rentReturnPlaceNm);
		$(".re_schview").find("#return_place_countryCd").val(searchData.rentReturnPlaceCountryCd);
		$(".re_schview").find("#arr_place").val(searchData.rentReturnPlaceNm);
		$("#resultTitle").html(searchData.rentTakePlaceNm);
		
		if(searchData.samePlaceYn){
			$("#same_place").click();
		}
	}
	
	function fn_rentReSearch(){
		var rentalCarFt = $("div[ft-att=RCREGroup]");
		var takeDayArr = rentalCarFt.find("#dep_dt").text().split(".");
		var takeDay = takeDayArr[0] + takeDayArr[1] + takeDayArr[2];
		var takeTimeVal = rentalCarFt.find("#takeTime option:selected").val();
		var takeTime = takeTimeVal.substring(0, 2) + ":" + takeTimeVal.substring(2, 4);
		var returnDayArr = rentalCarFt.find("#arr_dt").text().split(".");
		var returnDay = returnDayArr[0] + returnDayArr[1] + returnDayArr[2];
		var returnTimeVal = rentalCarFt.find("#returnTime option:selected").val();
		var returnTime = returnTimeVal.substring(0, 2) + ":" + returnTimeVal.substring(0, 2);
		
		var takeDate = new Date(takeDay.substring(0, 4), parseInt(takeDay.substring(4, 6)) - 1, takeDay.substring(6, 8));
		var takeNumday = getWeeksEng(takeDate.getDay());
		var returnDate = new Date(returnDay.substring(0, 4), parseInt(returnDay.substring(4, 6)) - 1, returnDay.substring(6, 8));
		var returnNumday = getWeeksEng(returnDate.getDay());
		
		var rentTakePlaceCd;
		var rentTakeType;
		var rentReturnPlaceCd;
		var rentReturnType;
		
		if(nullToBlank(rentalCarFt.find("#take_place_cd").val()) != ""){
			rentTakePlaceCd = rentalCarFt.find("#take_place_cd").val();
			rentTakeType = "CITY";
		}else{
			rentTakePlaceCd = rentalCarFt.find("#take_place_oagCd").val();
			rentTakeType = "OAG_CODE";
		}
		
		if(nullToBlank(rentalCarFt.find("#return_place_cd").val()) != ""){
			rentReturnPlaceCd = rentalCarFt.find("#return_place_cd").val();
			rentReturnType = "CITY";
		}else{
			rentReturnPlaceCd = rentalCarFt.find("#return_place_cd").val();
			rentReturnType = "OAG_CODE";
		}
		
		var searchSession = {
			"rentTakePlaceCd"			: rentTakePlaceCd,
			"rentTakeType"				: rentTakeType,
			"rentTakePlaceNm"			: rentalCarFt.find("#dep_place").val(),
			"rentTakePlaceCountryCd"	: rentalCarFt.find("#take_place_countryCd").val(),
			"rentReturnPlaceCd"			: rentReturnPlaceCd,
			"rentReturnType"			: rentReturnType,
			"rentReturnPlaceNm"			: rentalCarFt.find("#arr_place").val(),
			"rentReturnPlaceCountryCd"	: rentalCarFt.find("#return_place_countryCd").val(),
			"rentTakeDate"				: takeDay,
			"rentReturnDate"			: returnDay,
			"rentTakeTime"				: takeTimeVal,
			"rentReturnTime"			: returnTimeVal,
			"driverAge"					: rentalCarFt.find("#driverAge option:selected").val(),
			"samePlaceYn"				: rentalCarFt.find("#same_place").is(":checked")
		}
		
		sessionStorage.rentCarSearchData = JSON.stringify(searchSession);
		
		var titTxt = "";
		
		if(rentalCarFt.find("#same_place").is(":checked")){
			type = "same";
			titTxt = "인수/반납";
		}else{
			type = "pickup";
			titTxt = "인수";
		}
		
		var formData = new FormData();
		formData.append('country', rentalCarFt.find("#take_place_countryCd").val());
		formData.append('city', rentTakePlaceCd);
		formData.append('searchType', rentTakeType);
		formData.append('takeNumday', takeNumday);
		formData.append('takeTime', takeTime);
		formData.append('returnNumday', returnNumday);
		formData.append('returnTime', returnTime);
		formData.append('type', type);

		cfn_ajax({
			url: "/fit/rnt/selectRentOffice.do",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:false,
			success: function(res) {
				officeDataset = res.officeList;
				officeCnt = officeDataset.length;
				
				var officeLen = officeCnt;
				
				//예약내역 더보기 버튼 활성화
				if(officeCnt < pageSize) {
					$("#officeMore").hide();
				} else {
					officeLen = pageSize;
					$("#officeMore").show();	
				}
				
				var vHTML = '';
				var dateList = [];
				
				$("#officeResult").html(titTxt +" 영업소 조회 결과 for "+ rentalCarFt.find("#dep_place").val() +" ("+ officeCnt +" locations)");
				
				for(var i = 0; i < officeLen; i++){
					var firstNm = "";
					var firstDt = "";
					var lastNm = "";
					var lastDt = "";
					var dateList = [
			                {'name' : 'MON', 'time' : officeDataset[i].monTime},
			                {'name' : 'TUE', 'time' : officeDataset[i].tueTime},
			                {'name' : 'WED', 'time' : officeDataset[i].wedTime},
			                {'name' : 'THU', 'time' : officeDataset[i].thuTime},
			                {'name' : 'FRI', 'time' : officeDataset[i].friTime},
			                {'name' : 'SAT', 'time' : officeDataset[i].satTime},
			                {'name' : 'SUN', 'time' : officeDataset[i].sunTime}
					];
					
					vHTML += '<dt>';
					vHTML += '	<em>'+ (i + 1) +'</em>';
					vHTML += '	<span>'+ officeDataset[i].descriptionLocationName +'</span>'
					//HTML += '	<a href="#" class="layerOpener ui-link" data-url="/pop/pop_rentcar_map.do?lat='+ dataset[i].latitude +'&lng='+ dataset[i].longitude +'" data-width="400" data-height="400" data-ctn="full"></a>'
					vHTML += '	<a href="#" onclick="openMap(\''+ officeDataset[i].latitude +'\',\''+ officeDataset[i].longitude +'\')"></a>'
					vHTML += '</dt>';
					vHTML += '<dd>';
					vHTML += '	<div class="fr_lc_textbox">';
					if(nullToBlank(officeDataset[i].wnaMsg) != ""){
						vHTML += '		<p class="f_red" style="margin-right: 5px;">* '+ officeDataset[i].wnaMsg +'</p>';
					}
					if(nullToBlank(officeDataset[i].pflMsg) != ""){
						vHTML += '		<p class="f_red" style="margin-right: 5px;">* '+ officeDataset[i].pflMsg +'</p>';
					}
					if(nullToBlank(officeDataset[i].hgoMsg) != ""){
						vHTML += '		<p class="f_red" style="margin-right: 5px;">* '+ officeDataset[i].hgoMsg +'</p>';	
					}
					vHTML += '		Shop '+ nullToBlank(officeDataset[i].address1) + ' ' + nullToBlank(officeDataset[i].address2) + ' ' + nullToBlank(officeDataset[i].address3) +'<br>';
					vHTML += '		'+ rentalCarFt.find("#dep_place").val() +'<br>';
					vHTML += '		<dl>';
					vHTML += '			<dt>전화번호 : </dt>';
					if(nullToBlank(officeDataset[i].phone) == ""){
						vHTML += '			<dd></dd>';
					}else if(officeDataset[i].phone.length == 10){
						vHTML += '			<dd>'+ officeDataset[i].phone.substring(0, 3) +'-'+ officeDataset[i].phone.substring(3, 6) +'-'+ officeDataset[i].phone.substring(7, 10) +'</dd>';
					}else if(officeDataset[i].phone.length == 11){
						vHTML += '			<dd>'+ officeDataset[i].phone.substring(0, 3) +'-'+ officeDataset[i].phone.substring(3, 7) +'-'+ officeDataset[i].phone.substring(7, 11) +'</dd>';
					}else{
						vHTML += '			<dd>'+ officeDataset[i].phone +'</dd>';
					}
					vHTML += '		</dl>';
					vHTML += '		<dl>';
					vHTML += '			<dt>영업시간 : </dt>';
					vHTML += '			<dd>';
					for(var j = 0; j < dateList.length; j++){
						//if(nullToBlank(firstDt) == ""){
						if(j == 0){
							firstNm = dateList[j].name;
							firstDt = dateList[j].time;	
						}else{
							if(firstDt == dateList[j].time){
								lastNm = dateList[j].name;
								lastDt = dateList[j].time;
							}else{
								if(nullToBlank(lastDt) == ""){
									if(firstDt == "00:00~24:00"){
										vHTML += firstNm +' open 24 hours<br/>';
									}else if(nullToBlank(firstDt) == ""){
										vHTML += firstNm +' closed<br/>';
									}else{
										vHTML += firstNm +' '+ firstDt +'<br/>';	
									}
								}else{
									if(firstDt == "00:00~24:00"){
										vHTML += firstNm +'-'+ lastNm +' open 24 hours<br/>';
									}else if(nullToBlank(firstDt) == ""){
										vHTML += firstNm +'-'+ lastNm +' closed<br/>';
									}else{
										vHTML += firstNm +'-'+ lastNm +' '+ firstDt +'<br/>';	
									}
								}
								
								firstNm = dateList[j].name;
								firstDt = dateList[j].time;
								lastNm = "";
								lastDt = "";
							}
						}
					}
					
					if(nullToBlank(firstNm) != ""){
						if(nullToBlank(lastNm) == ""){
							if(firstDt == "00:00~24:00"){
								vHTML += firstNm +' open 24 hours<br/>';
							}else if(nullToBlank(firstDt) == ""){
								vHTML += firstNm +' closed<br/>';
							}else{
								vHTML += firstNm +' '+ firstDt +'<br/>';	
							}
						}else{
							if(firstDt == "00:00~24:00"){
								vHTML += firstNm +'-'+ lastNm +' open 24 hours<br/>';
							}else if(nullToBlank(firstDt) == ""){
								vHTML += firstNm +'-'+ lastNm +' closed<br/>';
							}else{
								vHTML += firstNm +'-'+ lastNm +' '+ firstDt +'<br/>';	
							}
						}
					}
					vHTML += '				';
					vHTML += '			</dd>';
					vHTML += '		</dl>';
					//vHTML += '		영업소 종류 : 독립 라이센스 영업소';
					vHTML += '	</div>';
					vHTML += '	<div class="btn_one lc_re_tbtn"><button class="purple2" data-role="none" onclick="fn_selOffice(\''+ officeDataset[i].vendorIdBrand +'\', \''+ officeDataset[i].oagCode +'\', \''+ type +'\');">'+ titTxt +' 영업소 선택</button></div>';
					vHTML += '</dd>';
				}
					
				if(officeCnt == 0){
					vHTML += '<div class="fr_nodata" style="line-height:2;">';
					vHTML += '	<p>검색하신 조건으로<br>검색된 영업소가 없습니다.</p>';
					vHTML += '</div>';
				}
				
				$("#rentalCarOffice").html(vHTML);
			},
			error:function(err){
			},
			complete:function(){
				$(".re_search_close").trigger("click");
			}
		});
	}

	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_searchSetting();
		fn_initButton();
		
		$("#popBack").click(function(){
			history.back();
		});
	});
</script>
</head>
<body>
	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="collapse freetop">
			<!-- 중복텝 -->
			<%
				// 항공 || 호텔 || 렌트카
				if(selAir.equals("Y") && selHotel.equals("Y") && selRentcar.equals("Y")) {
			%>
			<div class="free_box">
				<ul class="free_toprst frrst3">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" disabled="true" /><label for="hotelcheck">호텔</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
				// 항공 || 호텔
				else if(selAir.equals("Y") && selHotel.equals("Y") && !selRentcar.equals("Y")) {
			%> 
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" disabled="true" /><label for="hotelcheck">호텔</label></li>
				</ul>
			</div>
			<%
				}
				// 항공 || 렌트카 
				else if(selAir.equals("Y") && !selHotel.equals("Y") && selRentcar.equals("Y")) {
			%>
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
				// 호텔 || 렌트카 
				else if(!selAir.equals("Y") && selHotel.equals("Y") && selRentcar.equals("Y")) {			
			%>
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" disabled="true" /><label for="hotelcheck">호텔</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
				// 항공
				else if(selAir.equals("Y") && !selHotel.equals("Y") && !selRentcar.equals("Y")) {			
			%>			
			<div class="free_box">
				<ul class="free_toprst frrst1">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="aircheck">항공</label></li>
				</ul>
			</div>
			<%
				}
				
				// 호텔
				else if(!selAir.equals("Y") && selHotel.equals("Y") && !selRentcar.equals("Y")) {
			%>
			<div class="free_box">
				<ul class="free_toprst frrst1">
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="hotelcheck">호텔</label></li>
				</ul>
			</div>
			<%
				}
				
				// 렌터카
				else if(!selAir.equals("Y") && !selHotel.equals("Y") && selRentcar.equals("Y")) {
			%>
			<div class="free_box">
				<ul class="free_toprst frrst1">
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
			%>
			
			<!-- 간략안내 -->
			<div class="re_sch_lentcar">
				<!--
				<div class="stable_guide3">
					<p class="st3_stext ellipsis">Los Angeles Airport (LAX)</p>
				</div>
				<div class="txbox1">2016.12.02 ~ 2016.12.05</div>
				-->
				
				<!-- 검색버튼 -->
				<button type="button" data-role="none" class="re_search">재검색</button>
				
				<!--
				<!-- 정렬박스 --/>
				<ul class="fr_sortbox">
					<li>총 상품 0000개</li>
					<li><button type="button" data-role="none">차량 종류순</button></li>
					<li><button type="button" data-role="none"></button></li>
				</ul>
				-->
				<p class="txbox3" id="officeResult"></p>
				<dl class="fr_lc_wstore" id="rentalCarOffice">
				</dl>
				<!-- 버튼 -->
				<div class="btn_one air_tbtn" id="officeMore"><button class="white2 moreico" data-role="none" onclick="fn_officeMore();">더보기</button></div>

				<!-- *********************** 재검색 레이어 ******************* -->
				<div class="re_schview" ft-att="RCREGroup">
					<div class="chkpart carpart">
						<div class="car_box">				
							<div class="fs_search car_search">
								<p class="schtitle">인수장소</p>
								<div class="csbox">
								<form>
									<fieldset>
										<legend>검색폼</legend>
										<input type="text" data-role="none" class="layerOpener" id="dep_place" data-url="/pop/pop_city_select3.do?availTy=RCRE&type=D" data-ctn="full" data-role="none" style="cursor='hand';" placeholder="도시, 호텔, 인근도시, 공항 등" />
										<input type="hidden" name="take_place_cd" id="take_place_cd"/>
										<input type="hidden" name="take_place_oagCd" id="take_place_oagCd"/>
										<input type="hidden" name="take_place_countryCd" id="take_place_countryCd"/>
										<button type="button" data-role="none">검색</button>
									</fieldset>
								</form>
								</div>
							</div>
							<div class="fs_search car_search">
								<div class="schtitle">반납위치 
									<p>
										<p class="chkbox">
											<label for="same_place">인수장소와 동일</label>
											<span><input id="same_place" type="checkbox" data-role="none" /></span>
										</p>
									</p>
								</div>
								<div class="csbox">
									<form>
										<fieldset>
											<legend>검색폼</legend>
											<input type="text" data-role="none" class="layerOpener" id="arr_place" data-url="/pop/pop_city_select3.do?availTy=RCRE&type=A" data-ctn="full" data-role="none" style="cursor='hand';" placeholder="도시, 호텔, 인근도시, 공항 등"/>
											<input type="hidden" name="return_place_cd" id="return_place_cd"/>
											<input type="hidden" name="return_place_oagCd" id="return_place_oagCd"/>
											<input type="hidden" name="return_place_countryCd" id="return_place_countryCd"/>
											<button type="button" data-role="none">검색</button>
										</fieldset>
									</form>
								</div>
							</div>
							<ul class="tra_day tra_day2 cardaytime">
								<li>
									<button type="button" data-role="none" class="layerOpener" data-url="/pop/pop_rc_calendar.do?type=RENTCAR&availTy=RCRE"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'>
										<em>차량 인수일</em><span id="dep_dt"></span>
									</button>
									<input type="hidden" name="take_date" id="take_date" />
								</li>
								<li>
								<div class="seatbtn carselbox carselbox">
									<em>인수시간</em>
									<select name="takeTime" data-role="none" id="takeTime">
									</select>
								</div>
								</li>
							</ul>
							<ul class="tra_day tra_day2 cardaytime">
								<li>
									<button type="button" data-role="none" class="layerOpener" data-url="/pop/pop_rc_calendar.do?type=RENTCAR&availTy=RCRE"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'>
										<em>차량 반납일</em><span id="arr_dt"></span>
									</button>
									<input type="hidden" name="return_date" id="return_date" />
								</li>
								<li>
								<div class="seatbtn carselbox carselbox">
									<em>반납시간</em>
									<select name="returnTime" data-role="none" id="returnTime">
									</select>
								</div>
								</li>
							</ul>
							<div class="seatbtn selectbox carageobx">
								<button type="button" class="layerOpener select_guidebtn" data-url="/pop/pop_age_text.do"  data-ctn="full" data-role="none" style="cursor='hand';">설명</button>
								<select name="driverAge" data-role="none" class="centerSelect" id="driverAge">
								</select>
							</div>
							<div class="btn_one air_tbtn"><button class="purple2" data-role="none" onclick="fn_rentReSearch()">렌터카 검색하기</button></div>
						</div>	
					</div>

					<button type="button" data-role="none" class="re_search_close">닫기</button>
				</div>
			</div>
		</div>
		
		<a href="#popupGeo" id="googleMapPop" data-rel="popup" data-position-to="window" class="ui-btn ui-corner-all ui-shadow ui-btn-inline" style="display:none;"></a>
		
		<div id="popupGeo" data-role="popup" data-overlay-theme="a" class="ui-content" data-dismissible="false" style="max-height:100%;max-width:100%;top:0px;left:0px;">
			<!-- <a href="#" id="popupGeoClose" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>  -->
			<div style="width:100%;height:50px;">
				<div style="width:100%;height:50px;background-color:#705399;z-index:999">
					<strong style="display:block;padding:0;color:#fff;text-align:left;text-indent:15px;font-size:15px;line-height:3.3">위치보기</strong>
					<div data-rel="back" id="popBack" style="position: absolute;right: 15px;top: 15px;background: transparent;border: 0;width: 20px;height: 20px;padding: 0;line-height: 0;margin: 0;"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></div>
				</div>
			</div>
			<div id="showMap" style="width:100%;height:350px;"></div>
		</div>
		
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//content-->
</body>