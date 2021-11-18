<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : inc_reserve_step4_travels_hotels_info.jsp
	// 설명 : 여행자 정보 입력 > 호텔 투숙객 정보 입력 
%>

<script type="text/javascript">
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){
	
	var basketCnt = 0;
	var inwonCnt = 0;
	var inKname = []; //한글명
	var inEname =[]; //영문명
	var inBirthday = []; //생년월일
	var inPhone = []; //phone
	var inSex = [];
	var inwon = [];
	var inputInfoCnt = 0;
	var peopleInfo;
	
	var htlAdtCheck = 0;
	var htlChdCheck = 0;
	var htlAgeOfChd = "";
	var htlAgeOfChdArr = [];
	
	//숙박자 정보	
	function fn_htltravlerInfo() {
		
		var basketData = JSON.parse(sessionStorage.hotelBasketData);
		var viewData = JSON.parse(sessionStorage.hotelViewData);
		
		peopleInfo = viewData.roomCont;
		console.log(peopleInfo);
		/*
			numOfAdt : 어른 수
			numOfChd : 아이 수
			ageOfChd : 아이 나이
		*/
		
		for(var i = 0; i < peopleInfo.length; i++){
			htlAdtCheck += parseInt(peopleInfo[i].numOfAdt);
			
			if(nullToBlank(peopleInfo[i].numOfChd) != ""){
				htlChdCheck += parseInt(peopleInfo[i].numOfChd);
			}
			
			if(nullToBlank(peopleInfo[i].ageOfChd) != ""){
				if(nullToBlank(htlAgeOfChd) == ""){
					htlAgeOfChd = peopleInfo[i].ageOfChd;
				}else{
					htlAgeOfChd += ","+ peopleInfo[i].ageOfChd;
				}
			}
		}
		
		console.log(htlAdtCheck);
		console.log(htlChdCheck);
		console.log(htlAgeOfChd);
		
		var inwonCntTemp = 0;
		var inputInfoCnt = 0;
		
		if(basketData == undefined || basketData == null || basketData == '[]') {
			console.log("로드 데이터가 없습니다");
		} else {
			
			vHtml = '';
			basketCnt = basketData.length;
			
			for(var i = 0; i < basketCnt; i++) {
				var roomType = basketData[i].setRoomData[0].roomTypeDesc.split(','); //roomType
			
				vHtml += "	<table class='ft_table2 ft_thd_tl step4app mt7'>"
				vHtml += "		<colgroup>"
				vHtml += " 			<col style='width:28%'>"
				vHtml += "  		<col style='width:72%'>"
				vHtml += "		</colgroup>"
				vHtml += " 		<tbody>"
				vHtml += "  		<tr>"
				vHtml += "    			<th>호텔명</th>"
				vHtml += " 				<td class='f_purple'>" + basketData[i].htleName +"<br>" + basketData[i].htlName + "</td>"
				vHtml += "			</tr>"
				vHtml += "			<tr>"
				vHtml += "				<th>객실타입</th>"
				vHtml += "				<td class='f_purple'>" + roomType[0] + "</td>"
				vHtml += "			</tr>"
				vHtml += "		</tbody>"
				vHtml += "   </table>"
				
				//객실수  정보
				var roomCnt = parseInt(basketData[i].htlInfo.stayinfo.roomcnt);
				for(var k=0; k < roomCnt; k++) {
				
						var inwonCnt = parseInt(basketData[i].htlInfo.stayinfo.roomCont[k].numOfAdt) + parseInt(basketData[i].htlInfo.stayinfo.roomCont[k].numOfChd);  //객실별 인원수
						
						for(var j=0; j < inwonCnt; j++) {
							
							
								if(i > 0 ) {
									inputInfoCnt = inwonCntTemp + (j+1);
								} else {
									if(k > 0)
										inputInfoCnt = inwonCntTemp + (j+1);
									else
										inputInfoCnt = inwonCntTemp + j;
								}
								
								vHtml += "	<table class='ft_table2 ft_thd_tl step4app mt7'>"
								vHtml += " 		<colgroup>"
								vHtml += "			<col style='width:28%'>"
								vHtml += "			<col style='width:72%' >"
								vHtml += "		</colgroup>"
								vHtml += " 		<tbody>"
								vHtml += "			<tr>"
								vHtml += "				<th>한글명<em class='f_red'>*</em></th>"
								vHtml += "				<td><input class='w75p' type='text' data-role='none' id='userName" + inputInfoCnt + "'/><em></em></td>"
								vHtml += "			</tr>"
								vHtml += "			<tr>"
								vHtml += "				<th>영문 성/이름<em class='f_red'>*</em></th>"
								vHtml += "				<td><p><input type='text' class='eng_name1' data-role='none' id='eFstName" + inputInfoCnt + "' /><input type='text' class='eng_name2' data-role='none' id='eSndName" + inputInfoCnt +"' /></p></td>"
								vHtml += "			</tr>"
								vHtml += "			<tr>"
								vHtml += "				<th>생년월일<em class='f_red'>*</em></th>"
								vHtml += "				<td><input type='number' data-role='none' placeholder='예) 19800701' id='birthday" + inputInfoCnt + "' pattern='[0-9]*' onkeydown='return f_Onlynum();' onkeyup='limitText(this, 8)'/></td>"
								vHtml += "			</tr>"
								vHtml += "			<tr>"
								vHtml += "				<th>연락처<em class='f_red'>*</em></th>"
								vHtml += "				<td><input type='number' data-role='none' placeholder='예) 01012345678' id='phone" + inputInfoCnt + "' pattern='[0-9]*' onkeydown='return f_Onlynum();' onkeyup='limitText(this, 12)'/></td>"
								vHtml += "			</tr>"
								vHtml += "			<tr>"
								vHtml += "				<th>성별<em class='f_red'>*</em></th>"
								vHtml += "				<td>"
								vHtml += "					<span class='radioboxs on radioboxs2'><input type='radio' name='radio" + inputInfoCnt + "_sex' id='radioM" + inputInfoCnt + "' data-role='none' value='M' checked='checked' ></span>"
								vHtml += "					<label for='radio" + inputInfoCnt + "_sex' class='wauto'>남자</label>"
								vHtml += "					<span class='radioboxs radioboxs2 ml10'><input type='radio' name='radio" + inputInfoCnt +"_sex' id='radioW" + inputInfoCnt + "' data-role='none' value='F' ></span>"
								vHtml += "					<label for='radio" + inputInfoCnt + "_sex' class='wauto'>여자</label>"
								vHtml += "				</td>"
								vHtml += "			</tr>"
								vHtml += "		</tbody>"
								vHtml += "	 </table>"	
							
								
							$('#htlTravlerInfo').html(vHtml);
					    }
						inwonCntTemp = inputInfoCnt;  //마지막 넘버
				}
				
				var inwonCnt = {
					'inwonCnt' : inwonCnt	
				}
				
				inwon.push(inwonCnt);
			}
	    	
		}
		
	}
	
	//유효성 체크
 	function fn_checkHtlInfo() {
 		var validateYn = true;
		var userName;
 		var eFstname;
 		var eSndName;
 		var birthday;
 		var phone;
 		var sex;
 		var inwonCnt = 0;
 		var inwonCntTemp = 0;
	 		
		for(var i= 0; i < basketCnt; i++) {
			inwonCnt = inwon[i].inwonCnt;
			
			for(var j=0; j < inwonCnt; j++) {
				
				if(i > 0) {
					inwonCntTemp = inwonCnt;
				} else {
					inwonCntTemp = 0;
				}
				
				inputInfoCnt = (j+inwonCntTemp);
				
				userName = "#userName" + inputInfoCnt;
				eFstName = "#eFstName" + inputInfoCnt;
				eSndName = '#eSndName' + inputInfoCnt;
				birthday = '#birthday' + inputInfoCnt;
				phone 	 = '#phone'	   + inputInfoCnt;	
				
				if(nullToBlank($(userName).val()) == '') {
					setAlert("한글명을 입력해 주세요.");
					$(userName).focus();
					validateYn = false;  	break;
				}  
				
				if(nullToBlank($(eFstName).val()) == '') {
					setAlert("영문 성을 입력해 주세요.");
					$(eFstName).focus();
					validateYn = false;  	break;
				}

				if(nullToBlank($(eSndName).val()) == '') {
					setAlert("영문 이름을 입력해 주세요.");
					$(eSndName).focus();
					validateYn = false;  	break;
				}

				if(nullToBlank($(birthday).val()) == '') {
					setAlert("생년월일 이름을 입력해 주세요.");
					$(birthday).focus();
					validateYn = false;  	break;
				}else if($(birthday).val().length != 8){
					setAlert("생년월일이 잘못 입력되었습니다.");
					$(birthday).focus();
					return false;
				}else{
					var birthYear = parseInt($(birthday).val().substring(0, 4));
					var birthMonth = parseInt($(birthday).val().substring(4, 6));
					var birthDay = parseInt($(birthday).val().substring(6, 8));
					
					var birthDate = new Date(birthYear, birthMonth - 1, birthDay);
					var endDay = new Array(31,28,31,30,31,30,31,31,30,31,30,31); //각달의 마지막 날짜
					var lastDay = endDay[birthDate.getMonth() - 1]; 	//변경된 월의 마지막 날짜
					
					if( (birthDate.getMonth() == 2) && (((birthDate.getYear() % 4 == 0) && (birthDate.getYear() % 100 != 0)) || birthDate.getYear() % 400 == 0) ) {
						lastDay = 29;
					} 
								
					if(birthYear > serverYear && birthYear < (serverYear - 120)){
						setAlert("생년월일을 잘못 입력하셨습니다.");
						$(birthday).focus();
						return false;
					}else if(birthMonth > 12){
						setAlert("생년월일을 잘못 입력하셨습니다.");
						$(birthday).focus();
						return false;
					}else if(birthDay > lastDay){
						setAlert("생년월일을 잘못 입력하셨습니다.");
						$(birthday).focus();
						return false;
					}
				}
				
				/*
				if (calcAge($(birthday).val()) > 120) { // 나이 계산이 120이 넘을 경우 
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$(birthday).focus();
					return false;
				}*/
				
				if(nullToBlank($(phone).val()) == '') {
					setAlert("폰번호를  입력해 주세요.");
					$(phone).focus();
					validateYn = false;
					break;
				}
				
			}
		}
		
		htlAgeOfChdArr = htlAgeOfChd.split(',');
		
		for(var i = 0; i < basketCnt; i++){
			$("birthday"+ i).val();
		}
 		
		/* if(nullToBlank($('#requestinfo').text()) == '') {
			setAlert("기타요청사항을 입력해 주세요");
			$('#requestinfo').focus();
			validateYn = false;
		} */
			
		if(!validateYn) return false;
		else return true;
 	}
	
	//동일정보 체크
 	function fn_equalChk() {
 		if($('input:checkbox[name="equalChkbox"]').is(":checked") == true) {
			fn_equalsApply();		 			
 		} else {
 			$('#userName0').val('');
        	$('#eFstName0').val('');
        	$('#eSndName0').val('');
        	$('#birthday0').val('');
        	$('#phone0').val('');
 		}
 	}
	
	function fn_equalsApply() {
		rsvMstUserInfo.selectT(function(tx, results){
        	if(results.rows.length > 0){
	        	var userBirthDay = results.rows.item(0).resBirthday.substring(0, 4) + results.rows.item(0).resBirthday.substring(4, 6) + results.rows.item(0).resBirthday.substring(6, 8)
	        	var telNo = convertTel(results.rows.item(0).resPhoneNum);
	        	var telArr = telNo.split('-');
	        	if(telNo != "")
	        		telNo = telArr[0] + telArr[1] + telArr[2];
	        	
	        	$('#userName0').val(results.rows.item(0).resKorNm);
	        	$('#eFstName0').val(results.rows.item(0).resLastNm);
	        	$('#eSndName0').val(results.rows.item(0).resFirstNm);
	        	$('#birthday0').val(userBirthDay);
	        	$('#phone0').val(telNo);
        	}        	
		}, jSessionID)	
      
	}
	
	
	//세팅되는 데이터들
	function fn_setHtlRsvData() { 
		var userName;
 		var eFstName;
 		var eSndName;
 		var birthday;
 		var phone;
 		var sex;
	
		for(var i=0; i <= inputInfoCnt; i++) {
			
			userName = "#userName" + i;
			eFstName = "#eFstName" + i;
			eSndName = '#eSndName' + i;
			birthday = '#birthday' + i;
			phone 	 = '#phone'	   + i;
			sex 	 = 'radio' + i + "_sex";
				
			inKname[i] = $(userName).val();
			inEname[i] = $(eFstName).val() + $(eSndName).val();
			inBirthday[i] = $(birthday).val();
			inPhone[i] = $(phone).val();
			inSex[i]= $('input:radio[name=' + sex + ']:checked').val();
			
			/* console.log("inKname[" + i + "]=" + inKname[i]);
			console.log("inEname[" + i + "]=" + inEname[i]);
			console.log("inBirthday[" + i + "]=" + inBirthday[i]);
			console.log("inPhone[" + i + "]=" + inPhone[i]);
			console.log("inSex[" + i + "]=" + inSex[i]); */
		}
		
	}
	
 	/* function fn_saveReserve() {
 		//if(fn_checkHtlInfo()) {
 		//	setAlert("유효성체크완료");
 			fn_setHtlRsvData();
 		//}
 			
 	} */

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();
		
		//숙박자 정보
		if(nullToBlank(sessionStorage.hotelBasketData) != "" && sessionStorage.hotelBasketData != "[]") {
			fn_htltravlerInfo();
		}
		
		for(var i=0; i < 9; i++) {
				
			$('#eFstName' + i).keyup(function(event) {
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					//var inputVal = $(this).val();
					$(this).val($(this).val().toUpperCase().replace(/[^A-Z]/gi,''));
				}
				
			});
			
			$('#eSndName' + i).keyup(function(event) {
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					//var inputVal = $(this).val();
					$(this).val($(this).val().toUpperCase().replace(/[^A-Z]/gi,''));
				}
			});
		}

		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});
</script>

<!-- 숙박자 정보 -->
			<p class="pop_avtitle4 mt7">숙박자 정보</p>
			<div class="obj_title2">
				<p class="chkbox">

					<span><input id="equalChkbox" name="equalChkbox" type="checkbox" data-role="none" onclick="fn_equalChk()"></span>
					<label for="equalChkbox">위 여행자와 모두 동일합니다.</label> 

					<!-- <span><input id="chk_ck1" type="checkbox" data-role="none"></span>
					<label for="chk_ck1">위 여행자와 모두 동일합니다.</label> -->

				</p>
			</div>
			<div id="htlTravlerInfo" name="htlTravlerInfo">
				<!-- 숙박자 정보 입력화면 -->	
			
			</div>
			<!-- <table class="ft_table2 ft_tb_tl step4app">
				<colgroup>
					<col style="width:28%">
					<col style="width:72%">
				</colgroup>
				<tbody>
				<tr>
					<th>호텔명</th>
					<td class="f_purple">Hotel Gracery Shinjuku<br>호텔 그레이서리 신주쿠</td>
				</tr>
				<tr>
					<th>객실타입</th>
					<td class="f_purple">Deluxe Room</td>
				</tr>
				</tbody>
			</table>
			<table class="ft_table2 ft_tb_tl step4app mt7">
				<colgroup>
					<col style="width:28%">
					<col style="width:72%">
				</colgroup>
				<tbody>
				<tr>
					<th>한글명<em class="f_red">*</em></th>
					<td><input class="w75p" type="text" data-role="none" /><em>성인1</em></td>
				</tr>
				<tr>
					<th>영문 성/이름<em class="f_red">*</em></th>
					<td><p><input type="text" class="eng_name1" data-role="none" /><input type="text" class="eng_name2" data-role="none" /></p></td>
				</tr>
				<tr>
					<th>생년월일<em class="f_red">*</em></th>
					<td><input type="text" data-role="none" placeholder="예) 19800701" /></td>
				</tr>
				<tr>
					<th>연락처<em class="f_red">*</em></th>
					<td><input type="text" data-role="none" placeholder="예) 01012345678" /></td>
				</tr>
				<tr>
					<th>성별<em class="f_red">*</em></th>
					<td>
						<span class="radioboxs radioboxs2"><input type="radio" name="radiot3" id="radiot3_1" data-role="none"></span>
						<label for="radiot3_1" class="wauto">남자</label>

						<span class="radioboxs radioboxs2 ml10"><input type="radio" name="radiot3" id="radiot4_2" data-role="none"></span>
						<label for="radiot4_2" class="wauto">여자</label>
					</td>
				</tr>
				</tbody>
			</table> -->
			<dl class="ft_acdon3 mt7">
				<dt>요청사항</dt>
				<dd>
					<p>[기준 투숙인원 외 동반 아동 추가 시]</p>
					<ul class="dotlist2">
						<li>만 12세 미만 아동일지라도 호텔에 따라 동반 투숙이 가능하거나 거절당할 수 있습니다.</li>
						<li>예약 진행 시 요청 사항 입력란에 동반자녀 수와 자녀이름, 만 나이를 기입해주시고 반드시 예약 담당자의 확인을 받으시기 바랍니다.</li>
						<li><span class="f_purple">취소불가능 조건 예약의 경우 반드시 예약 전 상담원에게 유선상 동반가능여부 확인</span>하시고 이에 따라 예약하시기 바랍니다. <span class="f_purple">어린이 동반을 기재만하시고 예약하실 경우 체크인 시 추가요금이 발생되거나 투숙 거부될 수 있으며, 이에 따른 예약의 변경/취소/환불은 불가합니다.</span></li>
					</ul>
				</dd>
				<dt>기타요청사항(Remarks)</dt>
				<dd>
					<p><textarea name="" id="requestinfo" class="t_area1" data-role="none" placeholder="요청사항은 공백 포함 한글기준 500자 이내로 작성해 주시기 바랍니다."></textarea></p>
					<ul class="dotlist2">
						<li>객실요청사항은 호텔의 사정에 따라 결정되는 사안으로 가급적 반영되지만, 확정사항은 아닙니다.</li>
						<li>해외에서 예약하시는 경우 현지 연락처를 꼭 적어주세요.</li>
					</ul>
				</dd>
			</dl>