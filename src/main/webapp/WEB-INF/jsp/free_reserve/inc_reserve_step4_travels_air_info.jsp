<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : inc_reserve_step4_travels_info.jsp
	// 설명 : 여행자 정보 입력 > 여행자 정보 입력 
%>
<script type="text/javascript">
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){
	var jSessionID = '<%=request.getSession().getId()%>';
	var visaYn = 'N';
	var apisYn = 'N';

	// 대표 예약자 정보
	var rsvUserId = '';
	var rsvUserNm = '';
	var rsvEnSurNm = '';
	var rsvEnFirstNm = '';
	var rsvHtel = '';
	var rsvEmail = '';
	var rsvRemark = '';		
	
	var inwon_cnt = 0;

	var adt_cnt = 0; // 성인 탑승객 수 
	var chd_cnt = 0; // 아동 탑승객 수 
	var inf_cnt = 0; // 유아 탑승객 수 

	// 항공 여행자 정보 
	var inwon1_nm = "";
	var inwon1_ename = "";
	var inwon1_efname = "";
	var inwon1_birthday = "";
	var inwon1_htel = "";
	var inwon1_passYn = "";
	var inwon1_sex = "";

	var inwon2_nm = "";
	var inwon2_ename = "";
	var inwon2_efname = "";
	var inwon2_birthday = "";
	var inwon2_htel = "";
	var inwon2_passYn = "";
	var inwon2_sex = "";

	var inwon3_nm = "";
	var inwon3_ename = "";
	var inwon3_efname = "";
	var inwon3_birthday = "";
	var inwon3_htel = "";
	var inwon3_passYn = "";
	var inwon3_sex = "";

	var inwon4_nm = "";
	var inwon4_ename = "";
	var inwon4_efname = "";
	var inwon4_birthday = "";
	var inwon4_htel = "";
	var inwon4_passYn = "";
	var inwon4_sex = "";

	var inwon5_nm = "";
	var inwon5_ename = "";
	var inwon5_efname = "";
	var inwon5_birthday = "";
	var inwon5_htel = "";
	var inwon5_passYn = "";
	var inwon5_sex = "";

	var inwon6_nm = "";
	var inwon6_ename = "";
	var inwon6_efname = "";
	var inwon6_birthday = "";
	var inwon6_htel = "";
	var inwon6_passYn = "";
	var inwon6_sex = "";

	var inwon7_nm = "";
	var inwon7_ename = "";
	var inwon7_efname = "";
	var inwon7_birthday = "";
	var inwon7_htel = "";
	var inwon7_passYn = "";
	var inwon7_sex = "";

	var inwon8_nm = "";
	var inwon8_ename = "";
	var inwon8_efname = "";
	var inwon8_birthday = "";
	var inwon8_htel = "";
	var inwon8_passYn = "";
	var inwon8_sex = "";

	var inwon9_nm = "";
	var inwon9_ename = "";
	var inwon9_efname = "";
	var inwon9_birthday = "";
	var inwon9_htel = "";
	var inwon9_passYn = "";
	var inwon9_sex = "";

	var inwon10_nm = "";
	var inwon10_ename = "";
	var inwon10_efname = "";
	var inwon10_birthday = "";
	var inwon10_htel = "";
	var inwon10_passYn = "";
	var inwon10_sex = "";

	function fn_equalsTraveler() {
		
		var traveler = function(tx, results) {
				for(var i = 0; i < results.rows.length; i++){

					rsvUserId = results.rows.item(i).rsvUserId;
					rsvUserNm = results.rows.item(i).rsvUserNm;
					rsvEnSurNm = results.rows.item(i).rsvEnSurNm;
					rsvEnFirstNm = results.rows.item(i).rsvEnFirstNm;
					rsvHtel = results.rows.item(i).rsvHtel;
					revBirth = results.rows.item(i).rsvBirth;
					rsvEmail = results.rows.item(i).rsvEmail;
					rsvRemark = results.rows.item(i).rsvRemark;
					
					$('#inwon1_nm').val(rsvUserNm);
					$('#inwon1_ename').val(rsvEnSurNm);
					$('#inwon1_efname').val(rsvEnFirstNm);
					$('#inwon1_htel').val(rsvHtel);
					$('#inwon1_birthday').val(revBirth);
					
           		}

		};
		var traveler_info = rsvAirBodyDtoT.selectT(traveler, jSessionID);
	}

	function fn_display_div() {
		
		var carrierNm = '';
		var fltNo = '';
		if(sessionStorage.airViewData != undefined && JSON.parse(sessionStorage.airViewData).bodyDto != undefined) {

			// 항공일정 
			// var arCnt = _obj;
			var air_fix_data_info = JSON.parse(sessionStorage.airSelData);
			var arDetailList = air_fix_data_info[0].segmentGroup;
			var avail_cnt = air_fix_data_info[0].fltData.length;

			for(var d_idx=0; d_idx < arDetailList.length; d_idx++) {
				var arDetailInfo = arDetailList[d_idx];
				var arFixData = air_fix_data_info[0].fltData[(arDetailInfo.availNo - 1)];

				carrierNm = arDetailInfo.carrierNm;
				fltNo = arDetailInfo.fltNo;
			}			

			var search_body = JSON.parse(sessionStorage.airViewData).bodyDto;

			if(parseInt(search_body.adtCnt) > 0) {
				adt_cnt = parseInt(search_body.adtCnt);
			}
			
			if(parseInt(search_body.chdCnt) > 0) {	//아동 탑승객 수
				chd_cnt = parseInt(search_body.chdCnt);
			}

			if(parseInt(search_body.infCnt) > 0) {	//유아 탑승객 수
				inf_cnt = parseInt(search_body.infCnt); 
			}

			inwon_cnt = adt_cnt + chd_cnt + inf_cnt;

			if(inwon_cnt == 0) { 
				inwon_cnt = 2;
			} else {
				inwon_cnt = inwon_cnt + 1;
			}

			var i = 1;
			for (;i < inwon_cnt; i++) {
				var html = "";
				
				if(i == 1) {
					html = html + "			<p class='pop_avtitle4 mt7'>탑승객 정보</p>";
					html = html + "			<div class='white2 ft_whboxbd'>";
					html = html + "           <div class='obj_title2'>";
					html = html + "				<p class='chkbox'>";
					html = html + "					<span><input id='chk_ck1' type='checkbox' data-role='none' data-role='none' onClick='fn_equalsTraveler()'></span>";
					html = html + "					<label for='chk_ck1'>첫번째 탑승자가 예약자와 동일합니다.</label>";
					html = html + "				</p>";
					html = html + "			</div>";
				}	
				
				html = html + "	<table class='ft_table2 ft_thd_tl step4app mt7'>";
				html = html + "		<colgroup>";
				html = html + "			<col style='width: 28%'>";
				html = html + "			<col style='width: 72%'>";
				html = html + "		</colgroup>";

				if(i == 1) {
					// <!-- 항공 예약 관련 정보 첫번째 일때만 노출한다. --> //
					html = html + "		<tbody>";
					html = html + "			<tr>";
					html = html + "				<th>항공명</th>";
					html = html + "				<td class='f_purple'>"+carrierNm+" 편명-"+fltNo+"</td>";
					html = html + "			</tr>";
					html = html + "			<tr>";
					html = html + "				<th>탑승인원</th>";
					html = html + "				<td class='f_purple'>성인 : "+adt_cnt+" 명 / 아동 : "+chd_cnt+" 명 / 유아 : "+inf_cnt+" 명</td>";
					html = html + "			</tr>";
					html = html + "		</tbody>";
				}
				

				html = html + "		<tbody>";
				html = html + "			<tr>";
				html = html + "				<th>한글명<em class='f_red'>*</em></th>";
				html = html + "				<td><input type='text' data-role='none' placeholder='한글' data-maxlength='5' value='' id='inwon"+i+"_nm' name='inwon"+i+"_nm' onkeyup='limitText(this, 5)'/></td>";
				html = html + "			</tr>";
				html = html + "			<tr>";
				html = html + "				<th>영문 성/이름<em class='f_red'>*</em></th>";
				html = html + "				<td>";
				html = html + "					<p>";
				html = html + "						<input type='text' class='eng_name1' data-role='none' style='text-transform:uppercase;ime-mode:inactive' onpaste='javascript:return false;'  id='inwon"+i+"_ename' name='inwon"+i+"_ename' pattern='[A-Z]*' placeholder='영문 성' style='text-transform:uppercase;' value='' ft-att='inwon"+i+"_ename'/>";
				html = html + "						<input type='text' class='eng_name2' data-role='none' style='text-transform:uppercase;ime-mode:inactive' onpaste='javascript:return false;' id='inwon"+i+"_efname' name='inwon"+i+"_efname' pattern='[A-Z]*' placeholder='영문 이름' style='text-transform:uppercase;' value='' ft-att='inwon"+i+"_efname'/>";
				html = html + "					</p>";
				html = html + "				</td>";
				html = html + "			</tr>";
				html = html + "			<tr>";
				html = html + "				<th>생년월일<em class='f_red'>*</em></th>";
				html = html + "				<td><input type='number' data-role='none' placeholder='예) 19800701' id='inwon"+i+"_birthday' name='inwon"+i+"_birthday' ft-att='inwon"+i+"_birthday' pattern='[0-9]*' onkeydown='return f_Onlynum();' onkeyup='limitText(this, 8)' value=''/></td>";
				html = html + "			</tr>";
				html = html + "			<tr>";
				html = html + "				<th>연락처<em class='f_red'>*</em></th>";
				html = html + "				<td><input type='number' data-role='none' placeholder='예) 01012345678' id='inwon"+i+"_htel' name='inwon"+i+"_htel' ft-att='inwon"+i+"_htel' pattern='[0-9]*' onkeydown='return f_Onlynum();' onkeyup='limitText(this, 12)' value=''/></td>";
				html = html + "			</tr>";
				html = html + "			<tr>";
				html = html + "				<th>여권유무<em class='f_red'>*</em></th>";
				html = html + "				<td>";
				html = html + "					<span class='radioboxs radioboxs2'>";
				html = html + "						<input type='radio' id='inwon"+i+"_passYn1' name='inwon"+i+"_passYn' ft-att='inwon"+i+"_passYn'  data-role='none' value='N'>";
				html = html + "					</span>";
				html = html + "					<label for='inwon"+i+"_passYn1' class='wauto'>없음</label>"; 
				html = html + "					<span class='radioboxs radioboxs2 on ml10'>";
				html = html + "						<input type='radio' id='inwon"+i+"_passYn2' name='inwon"+i+"_passYn' ft-att='inwon"+i+"_passYn'  data-role='none' value='Y' checked>";
				html = html + "					</span>";
				html = html + "					<label for='inwon"+i+"_passYn2' class='wauto'>있음</label>";
				html = html + "				</td>";
				html = html + "			</tr>";
				html = html + "			<tr>";
				html = html + "				<th>성별<em class='f_red'>*</em></th>";
				html = html + "				<td>";
				html = html + "					<span class='radioboxs radioboxs2 on'>";
				html = html + "						<input type='radio' class='wauto' id='inwon"+i+"_sex1' name='inwon"+i+"_sex' ft-att='inwon"+i+"_sex'  data-role='none' value='M' checked>";
				html = html + "					</span>";
				html = html + "					<label for='inwon"+i+"_sex1' class='wauto'>남자</label>";
				html = html + "					<span class='radioboxs radioboxs2 ml10'>";
				html = html + "						<input type='radio'  class='wauto' id='inwon"+i+"_sex2' name='inwon"+i+"_sex' ft-att='inwon"+i+"_sex'  data-role='none' value='F'>";
				html = html + "					</span>";
				html = html + "					<label for='inwon"+i+"_sex2' class='wauto'>여자</label>";
				html = html + "				</td>";
				html = html + "			</tr>";
				html = html + "		</tbody>";				
				html = html + "	</table>";
				html = html + "</div>";					
				

				var div_air_inwon = "#div_air_inwon_" + i;
				
				$(div_air_inwon).html(html);
				$(div_air_inwon).show();
			}
		}
	}

	function fn_getParam() {

		if(inwon_cnt > 0) {
			inwon1_nm = $('#inwon1_nm').val();
			inwon1_ename = $('#inwon1_ename').val();
			inwon1_efname = $('#inwon1_efname').val();
			inwon1_birthday = $('#inwon1_birthday').val();
			inwon1_htel = $('#inwon1_htel').val();
			inwon1_passYn = $('input:radio[name=inwon1_passYn]:checked').val();
			inwon1_sex = $('input:radio[name=inwon1_sex]:checked').val();			
		}

		if(inwon_cnt > 1) {
			inwon2_nm = $('#inwon2_nm').val();
			inwon2_ename = $('#inwon2_ename').val();
			inwon2_efname = $('#inwon2_efname').val();
			inwon2_birthday = $('#inwon2_birthday').val();
			inwon2_htel = $('#inwon2_htel').val();
			inwon2_passYn = $('input:radio[name=inwon2_passYn]:checked').val();
			inwon2_sex = $('input:radio[name=inwon2_sex]:checked').val();			
		}		

		if(inwon_cnt > 2) {
			inwon3_nm = $('#inwon3_nm').val();
			inwon3_ename = $('#inwon3_ename').val();
			inwon3_efname = $('#inwon3_efname').val();
			inwon3_birthday = $('#inwon3_birthday').val();
			inwon3_htel = $('#inwon3_htel').val();
			inwon3_passYn = $('input:radio[name=inwon3_passYn]:checked').val();
			inwon3_sex = $('input:radio[name=inwon3_sex]:checked').val();			
		}		

		if(inwon_cnt > 3) {
			inwon4_nm = $('#inwon4_nm').val();
			inwon4_ename = $('#inwon4_ename').val();
			inwon4_efname = $('#inwon4_efname').val();
			inwon4_birthday = $('#inwon4_birthday').val();
			inwon4_htel = $('#inwon4_htel').val();
			inwon4_passYn = $('input:radio[name=inwon4_passYn]:checked').val();
			inwon4_sex = $('input:radio[name=inwon4_sex]:checked').val();			
		}		

		if(inwon_cnt > 4) {
			inwon5_nm = $('#inwon5_nm').val();
			inwon5_ename = $('#inwon5_ename').val();
			inwon5_efname = $('#inwon5_efname').val();
			inwon5_birthday = $('#inwon5_birthday').val();
			inwon5_htel = $('#inwon5_htel').val();
			inwon5_passYn = $('input:radio[name=inwon5_passYn]:checked').val();
			inwon5_sex = $('input:radio[name=inwon5_sex]:checked').val();			
		}		

		if(inwon_cnt > 5) {
			inwon6_nm = $('#inwon6_nm').val();
			inwon6_ename = $('#inwon6_ename').val();
			inwon6_efname = $('#inwon6_efname').val();
			inwon6_birthday = $('#inwon6_birthday').val();
			inwon6_htel = $('#inwon6_htel').val();
			inwon6_passYn = $('input:radio[name=inwon6_passYn]:checked').val();
			inwon6_sex = $('input:radio[name=inwon6_sex]:checked').val();			
		}		

		if(inwon_cnt > 6) {
			inwon7_nm = $('#inwon7_nm').val();
			inwon7_ename = $('#inwon7_ename').val();
			inwon7_efname = $('#inwon7_efname').val();
			inwon7_birthday = $('#inwon7_birthday').val();
			inwon7_htel = $('#inwon7_htel').val();
			inwon7_passYn = $('input:radio[name=inwon7_passYn]:checked').val();
			inwon7_sex = $('input:radio[name=inwon7_sex]:checked').val();			
		}		

		if(inwon_cnt > 7) {
			inwon8_nm = $('#inwon8_nm').val();
			inwon8_ename = $('#inwon8_ename').val();
			inwon8_efname = $('#inwon8_efname').val();
			inwon8_birthday = $('#inwon8_birthday').val();
			inwon8_htel = $('#inwon8_htel').val();
			inwon8_passYn = $('input:radio[name=inwon8_passYn]:checked').val();
			inwon8_sex = $('input:radio[name=inwon8_sex]:checked').val();			
		}	

		if(inwon_cnt > 8) {
			inwon9_nm = $('#inwon9_nm').val();
			inwon9_ename = $('#inwon9_ename').val();
			inwon9_efname = $('#inwon9_efname').val();
			inwon9_birthday = $('#inwon9_birthday').val();
			inwon9_htel = $('#inwon9_htel').val();
			inwon9_passYn = $('input:radio[name=inwon9_passYn]:checked').val();
			inwon9_sex = $('input:radio[name=inwon9_sex]:checked').val();			
		}	

		if(inwon_cnt > 9) {
			inwon10_nm = $('#inwon10_nm').val();
			inwon10_ename = $('#inwon10_ename').val();
			inwon10_efname = $('#inwon10_efname').val();
			inwon10_birthday = $('#inwon10_birthday').val();
			inwon10_htel = $('#inwon10_htel').val();
			inwon10_passYn = $('input:radio[name=inwon10_passYn]:checked').val();
			inwon10_sex = $('input:radio[name=inwon10_sex]:checked').val();			
		}	

	}

	function fn_airCheckParam() {
		fn_getParam();
		
		if(sessionStorage.airViewData != undefined && JSON.parse(sessionStorage.airViewData).bodyDto != undefined) {

			var search_body = JSON.parse(sessionStorage.airViewData).bodyDto;

			if(parseInt(search_body.adtCnt) > 0) {
				adt_cnt = parseInt(search_body.adtCnt);
			}
			
			if(parseInt(search_body.chdCnt) > 0) {	//아동 탑승객 수
				chd_cnt = parseInt(search_body.chdCnt);
			}

			if(parseInt(search_body.infCnt) > 0) {	//유아 탑승객 수
				inf_cnt = parseInt(search_body.infCnt); 
			}

			inwon_cnt = adt_cnt + chd_cnt + inf_cnt;
		}
		// console.log("inwon_cnt : " + inwon_cnt);

		if(inwon_cnt > 0) {
			// 여행자 1 파라미터 체크 
			if (inwon1_nm == null || inwon1_nm == "" || inwon1_nm =="undefined") {
				setAlert("한글명을 입력해 주세요.");
				$("#inwon1_nm").focus();
				return false;
			}

			if (inwon1_ename == null || inwon1_ename == "" || inwon1_ename =="undefined") {
				setAlert("영문 이름을 입력해 주세요.");
				$("#inwon1_ename").focus();
				return false;
			}

			if (inwon1_efname == null || inwon1_efname == "" || inwon1_efname =="undefined") {
				setAlert("영문 성을 입력해 주세요.");
				$("#inwon1_efname").focus();
				return false;
			}

			if (inwon1_birthday == null || inwon1_birthday == "" || inwon1_birthday =="undefined") {
				setAlert("생년월일을 입력해 주세요.");
				$("#inwon1_birthday").focus();
				return false;
			}else if(inwon1_birthday.length != 8){
				setAlert("생년월일이 잘못 입력되었습니다.");
				$("#inwon1_birthday").focus();
				return false;
			}else{
				var birthYear = parseInt($("#inwon1_birthday").val().substring(0, 4));
				var birthMonth = parseInt($("#inwon1_birthday").val().substring(4, 6));
				var birthDay = parseInt($("#inwon1_birthday").val().substring(6, 8));
				
				var birthDate = new Date(birthYear, birthMonth - 1, birthDay);
				var endDay = new Array(31,28,31,30,31,30,31,31,30,31,30,31); //각달의 마지막 날짜
				var lastDay = endDay[birthDate.getMonth() - 1]; 	//변경된 월의 마지막 날짜
				
				if( (birthDate.getMonth() == 2) && (((birthDate.getYear() % 4 == 0) && (birthDate.getYear() % 100 != 0)) || birthDate.getYear() % 400 == 0) ) {
					lastDay = 29;
				} 
							
				if(birthYear > serverYear && birthYear < (serverYear - 120)){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon1_birthday").focus();
					return false;
				}else if(birthMonth > 12){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon1_birthday").focus();
					return false;
				}else if(birthDay > lastDay){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon1_birthday").focus();
					return false;
				}
			}

			/*
			if (calcAge(inwon1_birthday) > 120) { // 나이 계산이 120이 넘을 경우 
				setAlert("생년월일을 잘못 입력하셨습니다.");
				$("#inwon6_birthday").focus();
				return false;
			}
			*/

			if (inwon1_htel == null || inwon1_htel == "" || inwon1_htel =="undefined") {
				setAlert("연락처를 입력해 주세요.");
				$("#inwon1_htel").focus();
				return false;
			}
			
			if (inwon1_passYn == null || inwon1_passYn == "" || inwon1_passYn =="undefined") {
				setAlert("여권유무를 입력해 주세요.");
				$("#inwon1_passYn").focus();
				return false;
			}

			if (inwon1_sex == null || inwon1_sex == "" || inwon1_sex =="undefined") {
				setAlert("성별을 입력해 주세요.");
				$("#inwon1_sex").focus();
				return false;
			}

		}

		if(inwon_cnt > 1) {
			// 여행자 2 파라미터 체크 
			if (inwon2_nm == null || inwon2_nm == "" || inwon2_nm =="undefined") {
				setAlert("한글명을 입력해 주세요.");
				$("#inwon2_nm").focus();
				return false;
			}

			if (inwon2_ename == null || inwon2_ename == "" || inwon2_ename =="undefined") {
				setAlert("영문 이름을 입력해 주세요.");
				$("#inwon2_ename").focus();
				return false;
			}

			if (inwon2_efname == null || inwon2_efname == "" || inwon2_efname =="undefined") {
				setAlert("영문 성을 입력해 주세요.");
				$("#inwon2_efname").focus();
				return false;
			}

			if (inwon2_birthday == null || inwon2_birthday == "" || inwon2_birthday =="undefined") {
				setAlert("생년월일을 입력해 주세요.");
				$("#inwon2_birthday").focus();
				return false;
			}else if(inwon2_birthday.length != 8){
				setAlert("생년월일이 잘못 입력되었습니다.");
				$("#inwon2_birthday").focus();
				return false;
			}else{
				var birthYear = parseInt($("#inwon2_birthday").val().substring(0, 4));
				var birthMonth = parseInt($("#inwon2_birthday").val().substring(4, 6));
				var birthDay = parseInt($("#inwon2_birthday").val().substring(6, 8));
				
				var birthDate = new Date(birthYear, birthMonth - 1, birthDay);
				var endDay = new Array(31,28,31,30,31,30,31,31,30,31,30,31); //각달의 마지막 날짜
				var lastDay = endDay[birthDate.getMonth() - 1]; 	//변경된 월의 마지막 날짜
				
				if( (birthDate.getMonth() == 2) && (((birthDate.getYear() % 4 == 0) && (birthDate.getYear() % 100 != 0)) || birthDate.getYear() % 400 == 0) ) {
					lastDay = 29;
				} 
							
				if(birthYear > serverYear && birthYear < (serverYear - 120)){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon2_birthday").focus();
					return false;
				}else if(birthMonth > 12){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon2_birthday").focus();
					return false;
				}else if(birthDay > lastDay){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon2_birthday").focus();
					return false;
				}
			}
			
			/*
			if (calcAge(inwon2_birthday) > 100) { // 나이 계산이 120이 넘을 경우 
				setAlert("생년월일을 잘못 입력하셨습니다.");
				$("#inwon2_birthday").focus();
				return false;
			}
			*/

			if (inwon2_htel == null || inwon2_htel == "" || inwon2_htel =="undefined") {
				setAlert("연락처를 입력해 주세요.");
				$("#inwon2_htel").focus();
				return false;
			}
			
			if (inwon2_passYn == null || inwon2_passYn == "" || inwon2_passYn =="undefined") {
				setAlert("여권유무를 입력해 주세요.");
				$("#inwon2_passYn").focus();
				return false;
			}

			if (inwon2_sex == null || inwon2_sex == "" || inwon2_sex =="undefined") {
				setAlert("성별을 입력해 주세요.");
				$("#inwon2_sex").focus();
				return false;
			}

		}

		if(inwon_cnt > 2) {
			// 여행자 3 파라미터 체크 
			if (inwon3_nm == null || inwon3_nm == "" || inwon3_nm =="undefined") {
				setAlert("한글명을 입력해 주세요.");
				$("#inwon3_nm").focus();
				return false;
			}

			if (inwon3_ename == null || inwon3_ename == "" || inwon3_ename =="undefined") {
				setAlert("영문 이름을 입력해 주세요.");
				$("#inwon3_ename").focus();
				return false;
			}

			if (inwon3_efname == null || inwon3_efname == "" || inwon3_efname =="undefined") {
				setAlert("영문 성을 입력해 주세요.");
				$("#inwon3_efname").focus();
				return false;
			}

			if (inwon3_birthday == null || inwon3_birthday == "" || inwon3_birthday =="undefined") {
				setAlert("생년월일을 입력해 주세요.");
				$("#inwon3_birthday").focus();
				return false;
			}else if(inwon3_birthday.length != 8){
				setAlert("생년월일이 잘못 입력되었습니다.");
				$("#inwon3_birthday").focus();
				return false;
			}else{
				var birthYear = parseInt($("#inwon3_birthday").val().substring(0, 4));
				var birthMonth = parseInt($("#inwon3_birthday").val().substring(4, 6));
				var birthDay = parseInt($("#inwon3_birthday").val().substring(6, 8));
				
				var birthDate = new Date(birthYear, birthMonth - 1, birthDay);
				var endDay = new Array(31,28,31,30,31,30,31,31,30,31,30,31); //각달의 마지막 날짜
				var lastDay = endDay[birthDate.getMonth() - 1]; 	//변경된 월의 마지막 날짜
				
				if( (birthDate.getMonth() == 2) && (((birthDate.getYear() % 4 == 0) && (birthDate.getYear() % 100 != 0)) || birthDate.getYear() % 400 == 0) ) {
					lastDay = 29;
				} 
							
				if(birthYear > serverYear && birthYear < (serverYear - 120)){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon3_birthday").focus();
					return false;
				}else if(birthMonth > 12){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon3_birthday").focus();
					return false;
				}else if(birthDay > lastDay){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon3_birthday").focus();
					return false;
				}
			}
			
			/*
			if (calcAge(inwon3_birthday) > 100) { // 나이 계산이 120이 넘을 경우 
				setAlert("생년월일을 잘못 입력하셨습니다.");
				$("#inwon3_birthday").focus();
				return false;
			}
			*/

			if (inwon3_htel == null || inwon3_htel == "" || inwon3_htel =="undefined") {
				setAlert("연락처를 입력해 주세요.");
				$("#inwon3_htel").focus();
				return false;
			}
			
			if (inwon3_passYn == null || inwon3_passYn == "" || inwon3_passYn =="undefined") {
				setAlert("여권유무를 입력해 주세요.");
				$("#inwon3_passYn").focus();
				return false;
			}

			if (inwon3_sex == null || inwon3_sex == "" || inwon3_sex =="undefined") {
				setAlert("성별을 입력해 주세요.");
				$("#inwon3_sex").focus();
				return false;
			}

		}

		if(inwon_cnt > 3) {
			// 여행자 4 파라미터 체크 
			if (inwon4_nm == null || inwon4_nm == "" || inwon4_nm =="undefined") {
				setAlert("한글명을 입력해 주세요.");
				$("#inwon4_nm").focus();
				return false;
			}

			if (inwon4_ename == null || inwon4_ename == "" || inwon4_ename =="undefined") {
				setAlert("영문 이름을 입력해 주세요.");
				$("#inwon4_ename").focus();
				return false;
			}

			if (inwon4_efname == null || inwon4_efname == "" || inwon4_efname =="undefined") {
				setAlert("영문 성을 입력해 주세요.");
				$("#inwon4_efname").focus();
				return false;
			}

			if (inwon4_birthday == null || inwon4_birthday == "" || inwon4_birthday =="undefined") {
				setAlert("생년월일을 입력해 주세요.");
				$("#inwon4_birthday").focus();
				return false;
			}else if(inwon4_birthday.length != 8){
				setAlert("생년월일이 잘못 입력되었습니다.");
				$("#inwon4_birthday").focus();
				return false;
			}else{
				var birthYear = parseInt($("#inwon4_birthday").val().substring(0, 4));
				var birthMonth = parseInt($("#inwon4_birthday").val().substring(4, 6));
				var birthDay = parseInt($("#inwon4_birthday").val().substring(6, 8));
				
				var birthDate = new Date(birthYear, birthMonth - 1, birthDay);
				var endDay = new Array(31,28,31,30,31,30,31,31,30,31,30,31); //각달의 마지막 날짜
				var lastDay = endDay[birthDate.getMonth() - 1]; 	//변경된 월의 마지막 날짜
				
				if( (birthDate.getMonth() == 2) && (((birthDate.getYear() % 4 == 0) && (birthDate.getYear() % 100 != 0)) || birthDate.getYear() % 400 == 0) ) {
					lastDay = 29;
				} 
							
				if(birthYear > serverYear && birthYear < (serverYear - 120)){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon4_birthday").focus();
					return false;
				}else if(birthMonth > 12){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon4_birthday").focus();
					return false;
				}else if(birthDay > lastDay){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon4_birthday").focus();
					return false;
				}
			}

			/*
			if (calcAge(inwon4_birthday) > 100) { // 나이 계산이 120이 넘을 경우 
				setAlert("생년월일을 잘못 입력하셨습니다.");
				$("#inwon4_birthday").focus();
				return false;
			}
			*/


			if (inwon4_htel == null || inwon4_htel == "" || inwon4_htel =="undefined") {
				setAlert("연락처를 입력해 주세요.");
				$("#inwon4_htel").focus();
				return false;
			}
			
			if (inwon4_passYn == null || inwon4_passYn == "" || inwon4_passYn =="undefined") {
				setAlert("여권유무를 입력해 주세요.");
				$("#inwon4_passYn").focus();
				return false;
			}

			if (inwon4_sex == null || inwon4_sex == "" || inwon4_sex =="undefined") {
				setAlert("성별을 입력해 주세요.");
				$("#inwon4_sex").focus();
				return false;
			}

		}

		if(inwon_cnt > 4) {
			// 여행자 5 파라미터 체크 
			if (inwon5_nm == null || inwon5_nm == "" || inwon5_nm =="undefined") {
				setAlert("한글명을 입력해 주세요.");
				$("#inwon5_nm").focus();
				return false;
			}

			if (inwon5_ename == null || inwon5_ename == "" || inwon5_ename =="undefined") {
				setAlert("영문 이름을 입력해 주세요.");
				$("#inwon5_ename").focus();
				return false;
			}

			if (inwon5_efname == null || inwon5_efname == "" || inwon5_efname =="undefined") {
				setAlert("영문 성을 입력해 주세요.");
				$("#inwon5_efname").focus();
				return false;
			}

			if (inwon5_birthday == null || inwon5_birthday == "" || inwon5_birthday =="undefined") {
				setAlert("생년월일을 입력해 주세요.");
				$("#inwon5_birthday").focus();
				return false;
			}else if(inwon5_birthday.length != 8){
				setAlert("생년월일이 잘못 입력되었습니다.");
				$("#inwon5_birthday").focus();
				return false;
			}else{
				var birthYear = parseInt($("#inwon5_birthday").val().substring(0, 4));
				var birthMonth = parseInt($("#inwon5_birthday").val().substring(4, 6));
				var birthDay = parseInt($("#inwon5_birthday").val().substring(6, 8));
				
				var birthDate = new Date(birthYear, birthMonth - 1, birthDay);
				var endDay = new Array(31,28,31,30,31,30,31,31,30,31,30,31); //각달의 마지막 날짜
				var lastDay = endDay[birthDate.getMonth() - 1]; 	//변경된 월의 마지막 날짜
				
				if( (birthDate.getMonth() == 2) && (((birthDate.getYear() % 4 == 0) && (birthDate.getYear() % 100 != 0)) || birthDate.getYear() % 400 == 0) ) {
					lastDay = 29;
				} 
							
				if(birthYear > serverYear && birthYear < (serverYear - 120)){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon5_birthday").focus();
					return false;
				}else if(birthMonth > 12){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon5_birthday").focus();
					return false;
				}else if(birthDay > lastDay){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon5_birthday").focus();
					return false;
				}
			}
			
			/*
			if (calcAge(inwon5_birthday) > 100) { // 나이 계산이 120이 넘을 경우 
				setAlert("생년월일을 잘못 입력하셨습니다.");
				$("#inwon5_birthday").focus();
				return false;
			}
			*/

			if (inwon5_htel == null || inwon5_htel == "" || inwon5_htel =="undefined") {
				setAlert("연락처를 입력해 주세요.");
				$("#inwon5_htel").focus();
				return false;
			}
			
			if (inwon5_passYn == null || inwon5_passYn == "" || inwon5_passYn =="undefined") {
				setAlert("여권유무를 입력해 주세요.");
				$("#inwon5_passYn").focus();
				return false;
			}

			if (inwon5_sex == null || inwon5_sex == "" || inwon5_sex =="undefined") {
				setAlert("성별을 입력해 주세요.");
				$("#inwon5_sex").focus();
				return false;
			}

		}

		if(inwon_cnt > 5) {
			// 여행자 6 파라미터 체크 
			if (inwon6_nm == null || inwon6_nm == "" || inwon6_nm =="undefined") {
				setAlert("한글명을 입력해 주세요.");
				$("#inwon6_nm").focus();
				return false;
			}

			if (inwon6_ename == null || inwon6_ename == "" || inwon6_ename =="undefined") {
				setAlert("영문 이름을 입력해 주세요.");
				$("#inwon6_ename").focus();
				return false;
			}

			if (inwon6_efname == null || inwon6_efname == "" || inwon6_efname =="undefined") {
				setAlert("영문 성을 입력해 주세요.");
				$("#inwon6_efname").focus();
				return false;
			}

			if (inwon6_birthday == null || inwon6_birthday == "" || inwon6_birthday =="undefined") {
				setAlert("생년월일을 입력해 주세요.");
				$("#inwon6_birthday").focus();
				return false;
			}else if(inwon6_birthday.length != 8){
				setAlert("생년월일이 잘못 입력되었습니다.");
				$("#inwon6_birthday").focus();
				return false;
			}else{
				var birthYear = parseInt($("#inwon6_birthday").val().substring(0, 4));
				var birthMonth = parseInt($("#inwon6_birthday").val().substring(4, 6));
				var birthDay = parseInt($("#inwon6_birthday").val().substring(6, 8));
				
				var birthDate = new Date(birthYear, birthMonth - 1, birthDay);
				var endDay = new Array(31,28,31,30,31,30,31,31,30,31,30,31); //각달의 마지막 날짜
				var lastDay = endDay[birthDate.getMonth() - 1]; 	//변경된 월의 마지막 날짜
				
				if( (birthDate.getMonth() == 2) && (((birthDate.getYear() % 4 == 0) && (birthDate.getYear() % 100 != 0)) || birthDate.getYear() % 400 == 0) ) {
					lastDay = 29;
				} 
							
				if(birthYear > serverYear && birthYear < (serverYear - 120)){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon6_birthday").focus();
					return false;
				}else if(birthMonth > 12){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon6_birthday").focus();
					return false;
				}else if(birthDay > lastDay){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon6_birthday").focus();
					return false;
				}
			}
			
			/*
			if (calcAge(inwon6_birthday) > 100) { // 나이 계산이 120이 넘을 경우 
				setAlert("생년월일을 잘못 입력하셨습니다.");
				$("#inwon6_birthday").focus();
				return false;
			}
			*/

			if (inwon6_htel == null || inwon6_htel == "" || inwon6_htel =="undefined") {
				setAlert("연락처를 입력해 주세요.");
				$("#inwon6_htel").focus();
				return false;
			}
			
			if (inwon6_passYn == null || inwon6_passYn == "" || inwon6_passYn =="undefined") {
				setAlert("여권유무를 입력해 주세요.");
				$("#inwon6_passYn").focus();
				return false;
			}

			if (inwon6_sex == null || inwon6_sex == "" || inwon6_sex =="undefined") {
				setAlert("성별을 입력해 주세요.");
				$("#inwon6_sex").focus();
				return false;
			}

		}

		if(inwon_cnt > 6) {
			// 여행자 7 파라미터 체크 
			if (inwon7_nm == null || inwon7_nm == "" || inwon7_nm =="undefined") {
				setAlert("한글명을 입력해 주세요.");
				$("#inwon7_nm").focus();
				return false;
			}

			if (inwon7_ename == null || inwon7_ename == "" || inwon7_ename =="undefined") {
				setAlert("영문 이름을 입력해 주세요.");
				$("#inwon7_ename").focus();
				return false;
			}

			if (inwon7_efname == null || inwon7_efname == "" || inwon7_efname =="undefined") {
				setAlert("영문 성을 입력해 주세요.");
				$("#inwon7_efname").focus();
				return false;
			}

			if (inwon7_birthday == null || inwon7_birthday == "" || inwon7_birthday =="undefined") {
				setAlert("생년월일을 입력해 주세요.");
				$("#inwon7_birthday").focus();
				return false;
			}else if(inwon7_birthday.length != 8){
				setAlert("생년월일이 잘못 입력되었습니다.");
				$("#inwon7_birthday").focus();
				return false;
			}else{
				var birthYear = parseInt($("#inwon7_birthday").val().substring(0, 4));
				var birthMonth = parseInt($("#inwon7_birthday").val().substring(4, 6));
				var birthDay = parseInt($("#inwon7_birthday").val().substring(6, 8));
				
				var birthDate = new Date(birthYear, birthMonth - 1, birthDay);
				var endDay = new Array(31,28,31,30,31,30,31,31,30,31,30,31); //각달의 마지막 날짜
				var lastDay = endDay[birthDate.getMonth() - 1]; 	//변경된 월의 마지막 날짜
				
				if( (birthDate.getMonth() == 2) && (((birthDate.getYear() % 4 == 0) && (birthDate.getYear() % 100 != 0)) || birthDate.getYear() % 400 == 0) ) {
					lastDay = 29;
				} 
							
				if(birthYear > serverYear && birthYear < (serverYear - 120)){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon7_birthday").focus();
					return false;
				}else if(birthMonth > 12){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon7_birthday").focus();
					return false;
				}else if(birthDay > lastDay){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon7_birthday").focus();
					return false;
				}
			}
			
			/*
			if (calcAge(inwon7_birthday) > 100) { // 나이 계산이 120이 넘을 경우 
				setAlert("생년월일을 잘못 입력하셨습니다.");
				$("#inwon7_birthday").focus();
				return false;
			}
			*/

			if (inwon7_htel == null || inwon7_htel == "" || inwon7_htel =="undefined") {
				setAlert("연락처를 입력해 주세요.");
				$("#inwon7_htel").focus();
				return false;
			}
			
			if (inwon7_passYn == null || inwon7_passYn == "" || inwon7_passYn =="undefined") {
				setAlert("여권유무를 입력해 주세요.");
				$("#inwon7_passYn").focus();
				return false;
			}

			if (inwon7_sex == null || inwon7_sex == "" || inwon7_sex =="undefined") {
				setAlert("성별을 입력해 주세요.");
				$("#inwon7_sex").focus();
				return false;
			}

		}

		if(inwon_cnt > 7) {
			// 여행자 8 파라미터 체크 
			if (inwon8_nm == null || inwon8_nm == "" || inwon8_nm =="undefined") {
				setAlert("한글명을 입력해 주세요.");
				$("#inwon8_nm").focus();
				return false;
			}

			if (inwon8_ename == null || inwon8_ename == "" || inwon8_ename =="undefined") {
				setAlert("영문 이름을 입력해 주세요.");
				$("#inwon8_ename").focus();
				return false;
			}

			if (inwon8_efname == null || inwon8_efname == "" || inwon8_efname =="undefined") {
				setAlert("영문 성을 입력해 주세요.");
				$("#inwon8_efname").focus();
				return false;
			}

			if (inwon8_birthday == null || inwon8_birthday == "" || inwon8_birthday =="undefined") {
				setAlert("생년월일을 입력해 주세요.");
				$("#inwon8_birthday").focus();
				return false;
			}else if(inwon8_birthday.length != 8){
				setAlert("생년월일이 잘못 입력되었습니다.");
				$("#inwon8_birthday").focus();
				return false;
			}else{
				var birthYear = parseInt($("#inwon8_birthday").val().substring(0, 4));
				var birthMonth = parseInt($("#inwon8_birthday").val().substring(4, 6));
				var birthDay = parseInt($("#inwon8_birthday").val().substring(6, 8));
				
				var birthDate = new Date(birthYear, birthMonth - 1, birthDay);
				var endDay = new Array(31,28,31,30,31,30,31,31,30,31,30,31); //각달의 마지막 날짜
				var lastDay = endDay[birthDate.getMonth() - 1]; 	//변경된 월의 마지막 날짜
				
				if( (birthDate.getMonth() == 2) && (((birthDate.getYear() % 4 == 0) && (birthDate.getYear() % 100 != 0)) || birthDate.getYear() % 400 == 0) ) {
					lastDay = 29;
				} 
							
				if(birthYear > serverYear && birthYear < (serverYear - 120)){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon8_birthday").focus();
					return false;
				}else if(birthMonth > 12){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon8_birthday").focus();
					return false;
				}else if(birthDay > lastDay){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon8_birthday").focus();
					return false;
				}
			}
			
			/*
			if (calcAge(inwon8_birthday) > 100) { // 나이 계산이 120이 넘을 경우 
				setAlert("생년월일을 잘못 입력하셨습니다.");
				$("#inwon8_birthday").focus();
				return false;
			}
			*/

			if (inwon8_htel == null || inwon8_htel == "" || inwon8_htel =="undefined") {
				setAlert("연락처를 입력해 주세요.");
				$("#inwon8_htel").focus();
				return false;
			}
			
			if (inwon8_passYn == null || inwon8_passYn == "" || inwon8_passYn =="undefined") {
				setAlert("여권유무를 입력해 주세요.");
				$("#inwon8_passYn").focus();
				return false;
			}

			if (inwon8_sex == null || inwon8_sex == "" || inwon8_sex =="undefined") {
				setAlert("성별을 입력해 주세요.");
				$("#inwon8_sex").focus();
				return false;
			}

		}

		if(inwon_cnt > 8) {
			// 여행자 9 파라미터 체크 
			if (inwon9_nm == null || inwon9_nm == "" || inwon9_nm =="undefined") {
				setAlert("한글명을 입력해 주세요.");
				$("#inwon9_nm").focus();
				return false;
			}

			if (inwon9_ename == null || inwon9_ename == "" || inwon9_ename =="undefined") {
				setAlert("영문 이름을 입력해 주세요.");
				$("#inwon9_ename").focus();
				return false;
			}

			if (inwon9_efname == null || inwon9_efname == "" || inwon9_efname =="undefined") {
				setAlert("영문 성을 입력해 주세요.");
				$("#inwon9_efname").focus();
				return false;
			}

			if (inwon9_birthday == null || inwon9_birthday == "" || inwon9_birthday =="undefined") {
				setAlert("생년월일을 입력해 주세요.");
				$("#inwon9_birthday").focus();
				return false;
			}else if(inwon9_birthday.length != 8){
				setAlert("생년월일이 잘못 입력되었습니다.");
				$("#inwon9_birthday").focus();
				return false;
			}else{
				var birthYear = parseInt($("#inwon9_birthday").val().substring(0, 4));
				var birthMonth = parseInt($("#inwon9_birthday").val().substring(4, 6));
				var birthDay = parseInt($("#inwon9_birthday").val().substring(6, 8));
				
				var birthDate = new Date(birthYear, birthMonth - 1, birthDay);
				var endDay = new Array(31,28,31,30,31,30,31,31,30,31,30,31); //각달의 마지막 날짜
				var lastDay = endDay[birthDate.getMonth() - 1]; 	//변경된 월의 마지막 날짜
				
				if( (birthDate.getMonth() == 2) && (((birthDate.getYear() % 4 == 0) && (birthDate.getYear() % 100 != 0)) || birthDate.getYear() % 400 == 0) ) {
					lastDay = 29;
				} 
							
				if(birthYear > serverYear && birthYear < (serverYear - 120)){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon9_birthday").focus();
					return false;
				}else if(birthMonth > 12){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon9_birthday").focus();
					return false;
				}else if(birthDay > lastDay){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon9_birthday").focus();
					return false;
				}
			}

			/*
			if (calcAge(inwon9_birthday) > 100) { // 나이 계산이 120이 넘을 경우 
				setAlert("생년월일을 잘못 입력하셨습니다.");
				$("#inwon9_birthday").focus();
				return false;
			}
			*/

			if (inwon9_htel == null || inwon9_htel == "" || inwon9_htel =="undefined") {
				setAlert("연락처를 입력해 주세요.");
				$("#inwon9_htel").focus();
				return false;
			}
			
			if (inwon9_passYn == null || inwon9_passYn == "" || inwon9_passYn =="undefined") {
				setAlert("여권유무를 입력해 주세요.");
				$("#inwon9_passYn").focus();
				return false;
			}

			if (inwon9_sex == null || inwon9_sex == "" || inwon9_sex =="undefined") {
				setAlert("성별을 입력해 주세요.");
				$("#inwon9_sex").focus();
				return false;
			}

		}

		if(inwon_cnt > 9) {
			// 여행자 10 파라미터 체크 
			if (inwon10_nm == null || inwon10_nm == "" || inwon10_nm =="undefined") {
				setAlert("한글명을 입력해 주세요.");
				$("#inwon10_nm").focus();
				return false;
			}

			if (inwon10_ename == null || inwon10_ename == "" || inwon10_ename =="undefined") {
				setAlert("영문 이름을 입력해 주세요.");
				$("#inwon10_ename").focus();
				return false;
			}

			if (inwon10_efname == null || inwon10_efname == "" || inwon10_efname =="undefined") {
				setAlert("영문 성을 입력해 주세요.");
				$("#inwon10_efname").focus();
				return false;
			}

			if (inwon10_birthday == null || inwon10_birthday == "" || inwon10_birthday =="undefined") {
				setAlert("생년월일을 입력해 주세요.");
				$("#inwon10_birthday").focus();
				return false;
			}else if(inwon10_birthday.length != 8){
				setAlert("생년월일이 잘못 입력되었습니다.");
				$("#inwon10_birthday").focus();
				return false;
			}else{
				var birthYear = parseInt($("#inwon10_birthday").val().substring(0, 4));
				var birthMonth = parseInt($("#inwon10_birthday").val().substring(4, 6));
				var birthDay = parseInt($("#inwon10_birthday").val().substring(6, 8));
				
				var birthDate = new Date(birthYear, birthMonth - 1, birthDay);
				var endDay = new Array(31,28,31,30,31,30,31,31,30,31,30,31); //각달의 마지막 날짜
				var lastDay = endDay[birthDate.getMonth() - 1]; 	//변경된 월의 마지막 날짜
				
				if( (birthDate.getMonth() == 2) && (((birthDate.getYear() % 4 == 0) && (birthDate.getYear() % 100 != 0)) || birthDate.getYear() % 400 == 0) ) {
					lastDay = 29;
				} 
							
				if(birthYear > serverYear && birthYear < (serverYear - 120)){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon10_birthday").focus();
					return false;
				}else if(birthMonth > 12){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon10_birthday").focus();
					return false;
				}else if(birthDay > lastDay){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#inwon10_birthday").focus();
					return false;
				}
			}

			/*
			if (calcAge(inwon10_birthday) > 100) { // 나이 계산이 120이 넘을 경우 
				setAlert("생년월일을 잘못 입력하셨습니다.");
				$("#inwon10_birthday").focus();
				return false;
			}
			*/


			if (inwon10_htel == null || inwon10_htel == "" || inwon10_htel =="undefined") {
				setAlert("연락처를 입력해 주세요.");
				$("#inwon10_htel").focus();
				return false;
			}
			
			if (inwon10_passYn == null || inwon10_passYn == "" || inwon10_passYn =="undefined") {
				setAlert("여권유무를 입력해 주세요.");
				$("#inwon10_passYn").focus();
				return false;
			}

			if (inwon10_sex == null || inwon10_sex == "" || inwon10_sex =="undefined") {
				setAlert("성별을 입력해 주세요.");
				$("#inwon10_sex").focus();
				return false;
			}

		}

		return true;
	}

	function fn_saveAirReserve() {
		var gdsCd = '';
		var availTy = '';
		var carrierCd = '';
		var routeTy = '';
		var currency = 0;
		var totSaleCharge = 0;
		var totTaxCharge = 0;
		var ruleKey;
		var pmoId;

		var airReserveData = {
			// bodyDTO
	
		};

		airReserveData.bodyDTO = {};

		// 세그먼트 그룹
		airReserveData.bodyDTO.segmentGroup = [];
		
		// 탑승자 그룹 
		airReserveData.bodyDTO.paxGroup  = [];	

		// 항공 INF 요청사항
		// 2017.04.25
		var fmsKey='';
		if(nullToBlank(sessionStorage.airSelData) != '') {
			var  airSelData = JSON.parse(sessionStorage.airSelData);
			fmsKey = airSelData[0].fmsKey;
		}

		console.log(" >>>>>>>>>>>> fmsKey : " + fmsKey);

		var dp_traveler = function(tx, results) {
				var tempArray = '';
				for(var i = 0; i < results.rows.length; i++){

					rsvUserId = results.rows.item(i).rsvUserId;
					rsvUserNm = results.rows.item(i).rsvUserNm;
					rsvEnSurNm = results.rows.item(i).rsvEnSurNm;
					rsvEnFirstNm = results.rows.item(i).rsvEnFirstNm;
					rsvHtel = convertTel(results.rows.item(i).rsvHtel);
					rsvEmail = results.rows.item(i).rsvEmail;
					rsvRemark = results.rows.item(i).rsvRemark;
					gdsCd = results.rows.item(i).gdsCd;
					availTy = results.rows.item(i).availTy;
					routeTy = results.rows.item(i).routeTy;
					currency = results.rows.item(i).currency;
					totSaleCharge = results.rows.item(i).totSaleCharge;
					totTaxCharge = results.rows.item(i).totTaxCharge;
					fmsKey = results.rows.item(i).fmsKey;
					ruleKey = results.rows.item(i).ruleKey;
					pmoId = results.rows.item(i).pmoId;
					if(rsvUserId == null || rsvUserId == '') rsvUserId = rsvEmail;
					
					tempArray = {
						"rsvUserId"		: rsvUserId,
						"rsvUserNm"		: rsvUserNm,
						"rsvHtel"		: rsvHtel,
						"rsvEmail"		: rsvEmail,
						"gdsCd"			: gdsCd,
						"availTy"		: availTy,
						"routeTy"		: routeTy,
						"currency"		: currency,
						"totSaleCharge"	: totSaleCharge,
						"totTaxCharge"	: totTaxCharge,
						"fmsKey"		: fmsKey,
						"ruleKey"		: ruleKey,
						"pmoId"			: pmoId
					};		
					// console.log(tempArray);
           		}
				
				airReserveData.bodyDTO = tempArray;

				
				var availNo = 0;
				var segNo = 0;
				var carrierCd = '';
				var opCarrierCd = '';
				var fltNo = '';
				var fltEquip = '';
				var depDt = '';
				var depTm = '';
				var depCd = '';
				var arrDt = '';
				var arrTm = '';
				var arrCd = '';
				var eTketYn = '';
				var depTerminal = '';
				var arrTerminal = '';
				var codeShare = '';
				var codeShareNm = '';
				var cabinClas = '';
				var duartionTm = '';
				var cnxTy = '';
				var segmentGroup = function(tx, results) {
						var tempArray = [];
						for(var i = 0; i < results.rows.length; i++){
							

							availNo = results.rows.item(i).availNo;
							segNo = results.rows.item(i).segNo;
							carrierCd = results.rows.item(i).carrierCd;
							opCarrierCd = results.rows.item(i).opCarrierCd;
							fltNo = results.rows.item(i).fltNo;
							fltEquip = results.rows.item(i).fltEquip;
							depDt = results.rows.item(i).depDt;
							depTm = results.rows.item(i).depTm;
							depCd = results.rows.item(i).depCd;
							arrDt = results.rows.item(i).arrDt;
							arrTm = results.rows.item(i).arrTm;
							arrCd = results.rows.item(i).arrCd;
							eTketYn = results.rows.item(i).eTketYn;
							depTerminal = results.rows.item(i).depTerminal;
							arrTerminal = results.rows.item(i).arrTerminal;
							codeShare = results.rows.item(i).codeShare;
							codeShareNm = results.rows.item(i).codeShareNm;
							cabinClas = results.rows.item(i).cabinClas;
							durationTm = results.rows.item(i).durationTm;
							bookingClas = results.rows.item(i).bookingClas;
							cnxTy = results.rows.item(i).cnxTy;
							// 항공 관련 정보 
							// fn_selAirport(arrCd);

							tempArray.push({
								"availNo"	: availNo,
								"segNo"		: segNo,
								"carrierCd"	: carrierCd,
								"opCarrierCd": opCarrierCd,
								"fltNo"		: fltNo,
								"fltEquip"	: fltEquip,
								"depDt"		: depDt,
								"depTm"		: depTm,
								"depCd"		: depCd,
								"arrDt"		: arrDt,
								"arrTm"		: arrTm,
								"arrCd"		: arrCd,
								"eTketYn"	: eTketYn,
								"bookingClas" :bookingClas,
								"depTerminal" : depTerminal,
								"arrTerminal" : arrTerminal,
								"codeShare"	  : codeShare,
								"codeShareNm" : codeShareNm,
								"cabinClas" : cabinClas,
								"durationTm" : durationTm,
								"cnxTy" : cnxTy
							});		

						}
						airReserveData.bodyDTO.segmentGroup = tempArray;

						var paxNo = 0;
						var paxTy = '';
						var krPaxNm = '';
						var enSurNm = '';
						var enFirstNm = '';
						var dateOfBirth = '';
						var paxTel = '';
						var paxEmail = '';
						var gender = '';
						var passportYn = '';
						var fareCharge = 0;
						var taxCharge = 0;
						var cabinClas = '';
						var bookingClas = '';
						var vCarrierCd = '';
						var discntCharge = 0;
						var fuelSurcharge = 0;
						var qCharge = 0;
						var upCharge = 0;
						var pmoDiscntCharge = 0;
						var pmoUpCharge = 0;

						var paxGroup = function(tx, results) {
								var tempArray = [];
								for(var i = 0; i < results.rows.length; i++){
									
									paxNo = results.rows.item(i).paxNo;
									paxTy = results.rows.item(i).paxTy;
									krPaxNm = results.rows.item(i).krPaxNm;
									enSurNm = results.rows.item(i).enSurNm;
									enFirstNm = results.rows.item(i).enFirstNm;
									dateOfBirth = results.rows.item(i).dateOfBirth;
									paxTel = convertTel(results.rows.item(i).paxTel);
									paxEmail = results.rows.item(i).paxEmail;
									gender = results.rows.item(i).gender;
									passportYn = results.rows.item(i).passportYn;
									fareCharge = results.rows.item(i).fareCharge;
									taxCharge = results.rows.item(i).taxCharge;
									cabinClas = results.rows.item(i).cabinClas;
									bookingClas = results.rows.item(i).bookingClas;
									vCarrierCd = results.rows.item(i).vCarrierCd;
									discntCharge = results.rows.item(i).discntCharge;
									fuelSurcharge = results.rows.item(i).fuelSurcharge;
									qCharge = results.rows.item(i).qCharge;
									upCharge = results.rows.item(i).upCharge;
									pmoDiscntCharge = results.rows.item(i).pmoDiscntCharge;
									pmoUpCharge = results.rows.item(i).pmoUpCharge;
									if(nullToBlank(vCarrierCd) == '') vCarrierCd = '';

									tempArray.push({
										"paxNo"				: paxNo,
										"paxTy"				: paxTy,
										"krPaxNm"			: krPaxNm,
										"enSurNm"			: enSurNm,
										"enFirstNm"		 	: enFirstNm,
										"dateOfBirth"		: dateOfBirth,
										"paxTel"			: paxTel,
										"paxEmail"			: paxEmail,
										"gender"			: gender,
										"passportYn"		: passportYn,
										"fareCharge"		: fareCharge,
										"taxCharge"			: taxCharge,
										"cabinClas"			: cabinClas,
										"bookingClas" 		: bookingClas,
										"vCarrierCd" 		: vCarrierCd,
										"discntCharge" 		: discntCharge,
										"fuelSurcharge"		: fuelSurcharge,
										"qCharge"			: qCharge,
										"upCharge"			: upCharge,
										"pmoDiscntCharge"	: pmoDiscntCharge,
										"pmoUpCharge"		: pmoUpCharge
									});	

									airReserveData.bodyDTO.paxGroup = tempArray;		
								}
										

								var segNo = 0;
								var fareBasis = '';
								var fareTy = '';
								var rbd = '';
								var breakPoint = '';
								

								// 요금료 
								for(var j = 0; j < airReserveData.bodyDTO.paxGroup.length; j++) {
									airReserveData.bodyDTO.paxGroup[j].fareDataBean  = [];
								}
								var fareData = function(tx, results) {
										for(var j = 0; j < airReserveData.bodyDTO.paxGroup.length; j++) {
											var tempArray = [];
											for(var i = 0; i < results.rows.length; i++){
												
												availNo = results.rows.item(i).availNo;
												segNo = results.rows.item(i).segNo;
												fareBasis = results.rows.item(i).fareBasis;
												fareTy = results.rows.item(i).fareTy;
												paxTy = results.rows.item(i).paxTy;
												cabinClas = results.rows.item(i).cabinClas;
												rbd = results.rows.item(i).rbd;
												breakPoint = results.rows.item(i).breakPoint;

												tempArray.push({
													"availNo"		: availNo,
													"segNo"			: segNo,
													"fareBasis"		: fareBasis,
													"fareTy"		: fareTy,
													"paxTy"	 		: paxTy,
													"cabinClas"		: cabinClas,
													"rbd"			: rbd,
													"breakPoint"	: breakPoint
												});
											}
											airReserveData.bodyDTO.paxGroup[j].fareDataBean  = tempArray;
											
										}
										fn_goReserveStep5(jSessionID, airReserveData);

								};
								var fare = rsvAirFareDataBeanT.selectT(fareData, jSessionID);

						};
						var pax = rsvAirPaxGroupT.selectT(paxGroup, jSessionID);

				};
				var segment = rsvAirSegmentGroupT.selectT(segmentGroup, jSessionID);

		};
		

		var traveler_info = rsvAirBodyDtoT.selectT(dp_traveler, jSessionID);

	}

	// ---------------------------------------------------------------------------------------------------------------------------------------------
	// 항공예약 > 항공 예약 탑승객 정보 > paxGroup 정보 
	// ---------------------------------------------------------------------------------------------------------------------------------------------

	function fn_syncAirPaxGroupDB() {
		var adt_index = 0;
		var chd_index = 0;
		var inf_index = 0;
		
		var adtCheck = parseInt(adt_cnt);
		var chdCheck = parseInt(chd_cnt);
		var infCheck = parseInt(inf_cnt);
		
		for(var i = 1; i <= inwon_cnt; i++){
			var age = calcAge($("#inwon"+ i +"_birthday").val());
			
			if(age < 2){
				infCheck--;	
			}else if(age < 12){
				chdCheck--;	
			}else{
				adtCheck--;
			}
		}
		
		if(infCheck != 0 || chdCheck != 0 || adtCheck != 0){
			setAlert("탑승인원이 맞지 않습니다.");
			return false;
		}
		
		if(inwon_cnt > 0) {
			var paxTy = fn_getPaxTy(inwon1_birthday);
			
			if(paxTy == 'ADT') {
				adt_index ++;
				rsvAirPaxGroupT.updateT(inwon1_nm, inwon1_ename, inwon1_efname, inwon1_birthday, inwon1_htel, '', inwon1_sex, inwon1_passYn, jSessionID, paxTy, adt_index);
			} else if(paxTy == 'CHD') {
				chd_index ++;
				rsvAirPaxGroupT.updateT(inwon1_nm, inwon1_ename, inwon1_efname, inwon1_birthday, inwon1_htel, '', inwon1_sex, inwon1_passYn, jSessionID, paxTy, chd_index);
			} else {
				inf_index ++;	
				rsvAirPaxGroupT.updateT(inwon1_nm, inwon1_ename, inwon1_efname, inwon1_birthday, inwon1_htel, '', inwon1_sex, inwon1_passYn, jSessionID, paxTy, inf_index);
			}
			
		}

		if(inwon_cnt > 1) {
			var paxTy = fn_getPaxTy(inwon2_birthday);
			
			if(paxTy == 'ADT') {
				adt_index ++;
				rsvAirPaxGroupT.updateT(inwon2_nm, inwon2_ename, inwon2_efname, inwon2_birthday, inwon2_htel, '', inwon2_sex, inwon2_passYn, jSessionID, paxTy, adt_index);
			} else if(paxTy == 'CHD') {
				chd_index ++;
				rsvAirPaxGroupT.updateT(inwon2_nm, inwon2_ename, inwon2_efname, inwon2_birthday, inwon2_htel, '', inwon2_sex, inwon2_passYn, jSessionID, paxTy, chd_index);
			} else {
				inf_index ++;	
				rsvAirPaxGroupT.updateT(inwon2_nm, inwon2_ename, inwon2_efname, inwon2_birthday, inwon2_htel, '', inwon2_sex, inwon2_passYn, jSessionID, paxTy, inf_index);
			}
			
		}

		if(inwon_cnt > 2) {
			var paxTy = fn_getPaxTy(inwon3_birthday);
			
			if(paxTy == 'ADT') {
				adt_index ++;
				rsvAirPaxGroupT.updateT(inwon3_nm, inwon3_ename, inwon3_efname, inwon3_birthday, inwon3_htel, '', inwon3_sex, inwon3_passYn, jSessionID, paxTy, adt_index);
			} else if(paxTy == 'CHD') {
				chd_index ++;
				rsvAirPaxGroupT.updateT(inwon3_nm, inwon3_ename, inwon3_efname, inwon3_birthday, inwon3_htel, '', inwon3_sex, inwon3_passYn, jSessionID, paxTy, chd_index);
			} else {
				inf_index ++;	
				rsvAirPaxGroupT.updateT(inwon3_nm, inwon3_ename, inwon3_efname, inwon3_birthday, inwon3_htel, '', inwon3_sex, inwon3_passYn,  jSessionID, paxTy, inf_index);
			}
			
		}

		if(inwon_cnt > 3) {
			var paxTy = fn_getPaxTy(inwon3_birthday);
			
			if(paxTy == 'ADT') {
				adt_index ++;
				rsvAirPaxGroupT.updateT(inwon4_nm, inwon4_ename, inwon4_efname, inwon4_birthday, inwon4_htel, '', inwon4_sex, inwon4_passYn, jSessionID, paxTy, adt_index);
			} else if(paxTy == 'CHD') {
				chd_index ++;
				rsvAirPaxGroupT.updateT(inwon4_nm, inwon4_ename, inwon4_efname, inwon4_birthday, inwon4_htel, '', inwon4_sex, inwon4_passYn, jSessionID, paxTy, chd_index);
			} else {
				inf_index ++;	
				rsvAirPaxGroupT.updateT(inwon4_nm, inwon4_ename, inwon4_efname, inwon4_birthday, inwon4_htel, '', inwon4_sex, inwon4_passYn,  jSessionID, paxTy, inf_index);
			}
			
		}

		if(inwon_cnt > 4) {
			var paxTy = fn_getPaxTy(inwon5_birthday);
			
			if(paxTy == 'ADT') {
				adt_index ++;
				rsvAirPaxGroupT.updateT(inwon5_nm, inwon5_ename, inwon5_efname, inwon5_birthday, inwon5_htel, '', inwon5_sex, inwon5_passYn, jSessionID, paxTy, adt_index);
			} else if(paxTy == 'CHD') {
				chd_index ++;
				rsvAirPaxGroupT.updateT(inwon5_nm, inwon5_ename, inwon5_efname, inwon5_birthday, inwon5_htel, '', inwon5_sex, inwon5_passYn, jSessionID, paxTy, chd_index);
			} else {
				inf_index ++;	
				rsvAirPaxGroupT.updateT(inwon5_nm, inwon5_ename, inwon5_efname, inwon5_birthday, inwon5_htel, '', inwon5_sex, inwon5_passYn, jSessionID, paxTy, inf_index);
			}
			
		}

		if(inwon_cnt > 5) {
			var paxTy = fn_getPaxTy(inwon6_birthday);
			
			if(paxTy == 'ADT') {
				adt_index ++;
				rsvAirPaxGroupT.updateT(inwon6_nm, inwon6_ename, inwon6_efname, inwon6_birthday, inwon6_htel, '', inwon6_sex, inwon6_passYn, jSessionID, paxTy, adt_index);
			} else if(paxTy == 'CHD') {
				chd_index ++;
				rsvAirPaxGroupT.updateT(inwon6_nm, inwon6_ename, inwon6_efname, inwon6_birthday, inwon6_htel, '', inwon6_sex, inwon6_passYn,  jSessionID, paxTy, chd_index);
			} else {
				inf_index ++;	
				rsvAirPaxGroupT.updateT(inwon6_nm, inwon6_ename, inwon6_efname, inwon6_birthday, inwon6_htel, '', inwon6_sex, inwon6_passYn,  jSessionID, paxTy, inf_index);
			}
			
		}	

		if(inwon_cnt > 6) {
			var paxTy = fn_getPaxTy(inwon7_birthday);
			
			if(paxTy == 'ADT') {
				adt_index ++;
				rsvAirPaxGroupT.updateT(inwon7_nm, inwon7_ename, inwon7_efname, inwon7_birthday, inwon7_htel, '', inwon7_sex, inwon7_passYn, jSessionID, paxTy, adt_index);
			} else if(paxTy == 'CHD') {
				chd_index ++;
				rsvAirPaxGroupT.updateT(inwon7_nm, inwon7_ename, inwon7_efname, inwon7_birthday, inwon7_htel, '', inwon7_sex, inwon7_passYn, jSessionID, paxTy, chd_index);
			} else {
				inf_index ++;	
				rsvAirPaxGroupT.updateT(inwon7_nm, inwon7_ename, inwon7_efname, inwon7_birthday, inwon7_htel, '', inwon7_sex, inwon7_passYn,  jSessionID, paxTy, inf_index);
			}
			
		}	

		if(inwon_cnt > 7) {
			var paxTy = fn_getPaxTy(inwon8_birthday);
			
			if(paxTy == 'ADT') {
				adt_index ++;
				rsvAirPaxGroupT.updateT(inwon8_nm, inwon8_ename, inwon8_efname, inwon8_birthday, inwon8_htel, '', inwon8_sex, inwon8_passYn, jSessionID, paxTy, adt_index);
			} else if(paxTy == 'CHD') {
				chd_index ++;
				rsvAirPaxGroupT.updateT(inwon8_nm, inwon8_ename, inwon8_efname, inwon8_birthday, inwon8_htel, '', inwon8_sex, inwon8_passYn, jSessionID, paxTy, chd_index);
			} else {
				inf_index ++;	
				rsvAirPaxGroupT.updateT(inwon8_nm, inwon8_ename, inwon8_efname, inwon8_birthday, inwon8_htel, '', inwon8_sex, inwon8_passYn, jSessionID, paxTy, inf_index);
			}
			
		}

		if(inwon_cnt > 8) {
			var paxTy = fn_getPaxTy(inwon9_birthday);
			
			if(paxTy == 'ADT') {
				adt_index ++;
				rsvAirPaxGroupT.updateT(inwon9_nm, inwon9_ename, inwon9_efname, inwon9_birthday, inwon9_htel, '', inwon9_sex, inwon9_passYn, jSessionID, paxTy, adt_index);
			} else if(paxTy == 'CHD') {
				chd_index ++;
				rsvAirPaxGroupT.updateT(inwon9_nm, inwon9_ename, inwon9_efname, inwon9_birthday, inwon9_htel, '', inwon9_sex, inwon9_passYn,  jSessionID, paxTy, chd_index);
			} else {
				inf_index ++;	
				rsvAirPaxGroupT.updateT(inwon9_nm, inwon9_ename, inwon9_efname, inwon9_birthday, inwon9_htel, '', inwon9_sex, inwon9_passYn,  jSessionID, paxTy, inf_index);
			}
			
		}	

		if(inwon_cnt > 9) {
			var paxTy = fn_getPaxTy(inwon10_birthday);
			
			if(paxTy == 'ADT') {
				adt_index ++;
				rsvAirPaxGroupT.updateT(inwon10_nm, inwon10_ename, inwon10_efname, inwon10_birthday, inwon10_htel, '', inwon10_sex, inwon10_passYn, jSessionID, paxTy, adt_index);
			} else if(paxTy == 'CHD') {
				chd_index ++;
				rsvAirPaxGroupT.updateT(inwon10_nm, inwon10_ename, inwon10_efname, inwon10_birthday, inwon10_htel, '', inwon10_sex, inwon10_passYn, jSessionID, paxTy, chd_index);
			} else {
				inf_index ++;	
				rsvAirPaxGroupT.updateT(inwon10_nm, inwon10_ename, inwon10_efname, inwon10_birthday, inwon10_htel, '', inwon10_sex, inwon10_passYn, jSessionID, paxTy, inf_index);
			}
			
		}
		
		setTimeout(function(){
			// 공동운항 팝업 관련  
			popComAirPop();
		}, 500);
	}


	function fn_airInit() {

		fn_display_div();
	}

	// ============================================================================
	// 예약 완료 후 띄우는 알럿 팝업 안내 
	// ============================================================================
	//공동 운항편 안내 팝업 
	function popComAirPop() {
		console.log(">>>>>>>>>>>>>>>>>>>>>>>>>> 공동 운항편 안내 팝업");

		// 항공일정 
		// var arCnt = _obj;
		var air_fix_data_info = JSON.parse(sessionStorage.airSelData);
		var arDetailList = air_fix_data_info[0].segmentGroup;

		
		var codeShareNm;
		var codeShare;

		for(var d_idx=0; d_idx < arDetailList.length; d_idx++) {
			var arDetailInfo = arDetailList[d_idx];
			codeShare = arDetailInfo.codeShare;
			codeShareNm = arDetailInfo.codeShareNm; 

			console.log("codeShareNm : " + codeShareNm);
		}

		if(arDetailInfo.codeShare != ''){
			var durl = "/pop/pop_commair.do";
			var w = 300;
			var h = 320;
			var ok = 'yes';
			var ps = "?";
			var para = durl.split('?');
			layerOpen2(para[0],jQuery(this),w,h,ok,ps,para[1]);
		} else {
			popStreetPop();

		}


	}

	//미주노선 안내 팝업 
	function popStreetPop() {
		console.log(">>>>>>>>>>>>>>>>>>>>>>>>>> 미주노선 안내 팝업 ");
		if(apisYn == 'Y') {
			var durl = "/pop/pop_street.do";
			var w = 300;
			var h = 230;
			var ok = 'yes';
			var ps = "?";
			var para = durl.split('?');
			layerOpen2(para[0],jQuery(this),w,h,ok,ps,para[1]);
		} else {
			popVisaPop();
		}
	}

	//비자 안내 팝업 
	function popVisaPop() {
		console.log(">>>>>>>>>>>>>>>>>>>>>>>>>> 비자 안내 팝업 ");
		if(visaYn == 'Y') {
			var durl = "/pop/pop_visa.do";
			var w = 300;
			var h = 280;
			var ok = 'yes';
			var ps = "?";
			var para = durl.split('?');
			layerOpen2(para[0],jQuery(this),w,h,ok,ps,para[1]);
		} else {
			console.log(sessionStorage.hotelBasketData);
			
			if(nullToBlank(sessionStorage.hotelBasketData) != "" && sessionStorage.hotelBasketData != '[]'){
				location.href = "/free/account/pay_free.do";
			}else{
				fn_saveAirReserve();
			}
		}
	}

	// 미주노선, 비자 발급 유무 판단 조회 
	function fn_selAirport() {

		var availNo = 0;
		var segNo = 0;
		var carrierCd = '';
		var opCarrierCd = '';
		var fltNo = '';
		var fltEquip = '';
		var depDt = '';
		var depTm = '';
		var depCd = '';
		var arrDt = '';
		var arrTm = '';
		var arrCd = '';
		var eTketYn = '';
		var depTerminal = '';
		var arrTerminal = '';
		var codeShare = '';
		var codeShareNm = '';
		var cabinClas = '';
		var duartionTm = '';
		var vCarrierCd = '';

		var segmentGroup = function(tx, results) {
			var tempArray = [];
			for(var i = 0; i < results.rows.length; i++){
				

				availNo = results.rows.item(i).availNo;
				segNo = results.rows.item(i).segNo;
				carrierCd = results.rows.item(i).carrierCd;
				opCarrierCd = results.rows.item(i).opCarrierCd;
				fltNo = results.rows.item(i).fltNo;
				fltEquip = results.rows.item(i).fltEquip;
				depDt = results.rows.item(i).depDt;
				depTm = results.rows.item(i).depTm;
				depCd = results.rows.item(i).depCd;
				arrDt = results.rows.item(i).arrDt;
				arrTm = results.rows.item(i).arrTm;
				arrCd = results.rows.item(i).arrCd;
				eTketYn = results.rows.item(i).eTketYn;
				depTerminal = results.rows.item(i).depTerminal;
				arrTerminal = results.rows.item(i).arrTerminal;
				codeShare = results.rows.item(i).codeShare;
				codeShareNm = results.rows.item(i).codeShareNm;
				cabinClas = results.rows.item(i).cabinClas;
				durationTm = results.rows.item(i).durationTm;
				bookingClas = results.rows.item(i).bookingClas;
				console.log("arrCd : " + arrCd);

				gfn_callAjax2('/fit/rsv//selAirPAjax.do', {'sVal' : arrCd.toUpperCase()}, 'fn_airport', true);


			}
		};
		var segment = rsvAirSegmentGroupT.selectT(segmentGroup, jSessionID);

		
	};

	//미주노선, 비자 발급 유무 판단 조회 
	function fn_airport(_data) {
		visaYn = _data.result.visaYn;
		apisYn = _data.result.apisYn;

		console.log(_data);
		console.log(">>>>>>>>>>>>>>>>>>>>>>> visaYn : " + visaYn + " apisYn : " + apisYn);

	}

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		if(nullToBlank(sessionStorage.airSelData) != "" && sessionStorage.airSelData != '[]'){
			fn_airInit();
			/******* 영문 성/이름 영문 대문자만 입력이 되도록 처리함 2017.04.12  *******/

			$("#inwon1_ename").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});		

			$("#inwon1_efname").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});

			$("#inwon2_ename").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});		

			$("#inwon2_efname").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});			
			
			$("#inwon3_ename").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});		

			$("#inwon3_efname").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});			
			$("#inwon4_ename").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});		

			$("#inwon4_efname").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});						
			
			$("#inwon5_ename").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});		

			$("#inwon5_efname").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});		

			$("#inwon6_ename").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});		

			$("#inwon6_efname").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});		
			
			$("#inwon7_ename").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});		

			$("#inwon7_efname").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});		
			
			$("#inwon8_ename").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});		

			$("#inwon8_efname").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});
			
			$("#inwon9_ename").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});		

			$("#inwon9_efname").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});
			
			$("#inwon10_ename").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});		

			$("#inwon10_efname").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[^A-Z]/gi,''));
				}
			});
			
			$("#inwon1_htel").keyup(function(){$(this).val( $(this).val().replace(/[^\!-z]/g,"") );} );
			$("#inwon2_htel").keyup(function(){$(this).val( $(this).val().replace(/[^\!-z]/g,"") );} );
			$("#inwon3_htel").keyup(function(){$(this).val( $(this).val().replace(/[^\!-z]/g,"") );} );
			$("#inwon4_htel").keyup(function(){$(this).val( $(this).val().replace(/[^\!-z]/g,"") );} );
			$("#inwon5_htel").keyup(function(){$(this).val( $(this).val().replace(/[^\!-z]/g,"") );} );
	
			$("#inwon6_htel").keyup(function(){$(this).val( $(this).val().replace(/[^\!-z]/g,"") );} );
			$("#inwon7_htel").keyup(function(){$(this).val( $(this).val().replace(/[^\!-z]/g,"") );} );
			$("#inwon8_htel").keyup(function(){$(this).val( $(this).val().replace(/[^\!-z]/g,"") );} );
			$("#inwon9_htel").keyup(function(){$(this).val( $(this).val().replace(/[^\!-z]/g,"") );} );
			$("#inwon10_htel").keyup(function(){$(this).val( $(this).val().replace(/[^\!-z]/g,"") );} );
	
			fn_selAirport();
		}
	});
	
	function calcAge(birth) {
		var airportInfo = JSON.parse(sessionStorage.airSelData);
		
		var airDepDt = airportInfo[0].segmentGroup[0].depDt;
		
		var airYear = airDepDt.substring(0, 4);
		var airMonth = airDepDt.substring(4, 6);
		var airDay = airDepDt.substring(6, 8);
		
	    var date = new Date(airYear, airMonth, airDay);
	    var year = date.getFullYear();
	    var month = (date.getMonth() + 1);
	    var day = date.getDate();       
	    if (month < 10) month = '0' + month;
	    if (day < 10) day = '0' + day;
	    var monthDay = month + day;
	       
	    birth = birth.replace('-', '').replace('-', '');
	    var birthdayy = birth.substr(0, 4);
	    var birthdaymd = birth.substr(4, 4);
	 
	    var age = monthDay < birthdaymd ? year - birthdayy - 1 : year - birthdayy;
	    return age;
	}

	
</script>


<div id='travelers_air_info_div' name='travelers_air_info_div'>
	<!-- 여행자 리스트 -->
	<div id="div_air_inwon_1" name="div_air_inwon_1"></div>
	<div id="div_air_inwon_2" name="div_air_inwon_2"></div>
	<div id="div_air_inwon_3" name="div_air_inwon_3"></div>
	<div id="div_air_inwon_4" name="div_air_inwon_4"></div>
	<div id="div_air_inwon_5" name="div_air_inwon_5"></div>
	<div id="div_air_inwon_6" name="div_air_inwon_6"></div>
	<div id="div_air_inwon_7" name="div_air_inwon_7"></div>
	<div id="div_air_inwon_8" name="div_air_inwon_8"></div>
	<div id="div_air_inwon_9" name="div_air_inwon_9"></div>
	<div id="div_air_inwon_10" name="div_air_inwon_10"></div>

</div>