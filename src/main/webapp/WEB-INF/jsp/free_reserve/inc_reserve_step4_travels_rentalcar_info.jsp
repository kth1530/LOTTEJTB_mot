<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : inc_reserve_step4_travels_hotels_info.jsp
	// 설명 : 여행자 정보 입력 > 호텔 투숙객 정보 입력 
%>

<script type="text/javascript">
	var fn_driverInfo = function(){
		
		if(nullToBlank(sessionStorage.rentcarSelData) != '' && sessionStorage.rentcarSelData != '[]') {
				carinfoList = JSON.parse(sessionStorage.rentcarSelData);
				
				var driverHTML = "";
				
				for(var i = 0; i < carinfoList.length; i++){
					driverHTML +='<div class="white2 ft_whboxbd">';
					driverHTML +='	<table class="ft_table2 ft_thd_tl step4app">';
					driverHTML +='		<colgroup>';
					driverHTML +='			<col style="width:28%">';
					driverHTML +='			<col style="width:72%">';
					driverHTML +='		</colgroup>';
					driverHTML +='		<tbody>';
					driverHTML +='			<tr>';
					driverHTML +='				<th>차량명</th>';
					driverHTML +='				<td class="f_purple">'+ carinfoList[i].carNm +'</td>';
					driverHTML +='			</tr>';
					driverHTML +='			<tr>';
					driverHTML +='				<th>차량종류</th>';
					driverHTML +='				<td class="f_purple">'+ carSize[carinfoList[i].carSize] +'</td>';
					driverHTML +='			</tr>';
					driverHTML +='		</tbody>';
					driverHTML +='	</table>';
					driverHTML +='	<table class="ft_table2 ft_thd_tl step4app mt7">';
					driverHTML +='		<colgroup>';
					driverHTML +='			<col style="width:28%">';
					driverHTML +='			<col style="width:72%">';
					driverHTML +='		</colgroup>';
					driverHTML +='		<tbody>';
					driverHTML +='			<tr>';
					driverHTML +='				<th>한글명<em class="f_red">*</em></th>';
					driverHTML +='				<td><input class="w75p operNmKr" type="text" data-role="none" id="operNmKr'+ i +'"/><em>운전자</em></td>';
					driverHTML +='			</tr>';
					driverHTML +='			<tr>';
					driverHTML +='				<th>영문 성/이름<em class="f_red">*</em></th>';
					driverHTML +='				<td>';
					driverHTML +='					<p>';
					driverHTML +='						<input type="text" class="eng_name1 operSurNm" style="text-transform:uppercase;ime-mode:inactive;" data-role="none" id="operSurNm'+ i +'" pattern="[A-Z]*"/>';
					driverHTML +='						<input type="text" class="eng_name2 operGivenNm" style="text-transform:uppercase;ime-mode:inactive;" data-role="none" id="operGivenNm'+ i +'" pattern="[A-Z]*"/>';
					driverHTML +='					</p>';
					driverHTML +='				</td>';
					driverHTML +='			</tr>';
					driverHTML +='			<tr>';
					driverHTML +='				<th>이메일 주소<em class="f_red">*</em></th>';
					driverHTML +='				<td><input type="text" data-role="none" class="emailAddr" id="emailAddr'+ i +'" placeholder="예) lottejtb@lottejtb.com"/></td>';
					driverHTML +='			</tr>';
					driverHTML +='			<tr>';
					driverHTML +='				<th>생년월일<em class="f_red">*</em></th>';
					driverHTML +='				<td><input type="number" data-role="none" class="birthday" id="birthday'+ i +'" pattern="[0-9]*" onkeydown="return f_Onlynum();" onkeyup="limitText(this, 8)" placeholder="예) 19800701" /></td>';
					driverHTML +='			</tr>';
					driverHTML +='			<tr>';
					driverHTML +='				<th>연락처<em class="f_red">*</em></th>';
					driverHTML +='				<td><input type="number" data-role="none" class="telNo" id="telNo'+ i +'" pattern="[0-9]*" onkeydown="return f_Onlynum();" onkeyup="limitText(this, 12)" placeholder="예) 01012345678" /></td>';
					driverHTML +='			</tr>';
					driverHTML +='		</tbody>';
					driverHTML +='	</table>';
					driverHTML +='</div>';
				}
				
				$("#driverInfoDiv").html(driverHTML);
		}
	}
	
	var fn_rentCheckParam = function(){
		for(var i = 0 ; i < carinfoList.length; i++){
			if(nullToBlank($("#operNmKr"+ i).val()) == ""){
				setAlert("한글명을 입력해 주세요.");
				$("#operNmkr"+ i).focus();
				
				return false;
			}
			
			if(nullToBlank($("#operSurNm"+ i).val()) == ""){
				setAlert("영문 성을 입력해 주세요.");
				$("#operSurNm"+i).focus();
				
				return false;
			}
						
			if(nullToBlank($("#operGivenNm"+ i).val()) == ""){
				setAlert("영문 이름을 입력해 주세요.");
				$("#operGivenNm"+ i).focus();
				
				return false;
			}
			
			if(nullToBlank($("#emailAddr"+ i).val()) == ""){
				setAlert("이메일 주소를 입력해 주세요.");
				$("#emailAddr"+ i).focus();
				
				return false;
			}
			
			if(nullToBlank($("#telNo"+ i).val()) == ""){
				setAlert("핸드폰 번호를 입력해 주세요.");
				$("#telNo"+ i).focus();
				
				return false;
			}else if($("#telNo"+ i).val().length != '11'){
				setAlert("핸드폰 번호를 입력을 잘못 입력하셨습니다.");
				$("#telNo"+ i).focus();
				
				return false;
			}
			
			if(nullToBlank($("#birthday"+ i).val()) == ""){
				setAlert("생년월일을 입력해 주세요.");
				$("#birthday"+ i).focus();
				
				return false;
			}else if($("#birthday"+ i).val().length != 8){
				setAlert("생년월일을 잘못 입력하셨습니다.");
				$("#birthday"+ i).focus();
				
				return false;
			}else{
				var birthYear = parseInt($("#birthday"+ i).val().substring(0, 4));
				var birthMonth = parseInt($("#birthday"+ i).val().substring(4, 6));
				var birthDay = parseInt($("#birthday"+ i).val().substring(6, 8));
				
				var birthDate = new Date(birthYear, birthMonth - 1, birthDay);
				var endDay = new Array(31,28,31,30,31,30,31,31,30,31,30,31); //각달의 마지막 날짜
				var lastDay = endDay[birthDate.getMonth() - 1]; 	//변경된 월의 마지막 날짜
				
				if( (birthDate.getMonth() == 2) && (((birthDate.getYear() % 4 == 0) && (birthDate.getYear() % 100 != 0)) || birthDate.getYear() % 400 == 0) ) {
					lastDay = 29;
				} 
							
				if(birthYear > serverYear && birthYear < (serverYear - 120)){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#birthday"+ i).focus();
					return false;
				}else if(birthMonth > 12){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#birthday"+ i).focus();
					return false;
				}else if(birthDay > lastDay){
					setAlert("생년월일을 잘못 입력하셨습니다.");
					$("#birthday"+ i).focus();
					return false;
				}
			}
		}
		
		return true;
	}
	
	function fn_rntEqualChk(){
		if($("#rntEqualChkbox").is(":checked")){
			rsvMstUserInfo.selectT(function(tx, results){
	        	if(results.rows.length > 0){
		        	var userBirthDay = results.rows.item(0).resBirthday.substring(0, 4) + results.rows.item(0).resBirthday.substring(4, 6) + results.rows.item(0).resBirthday.substring(6, 8)
		        	var telNo = convertTel(results.rows.item(0).resPhoneNum);
		        	var telArr = telNo.split('-');
		        	if(telNo != "")
		        		telNo = telArr[0] + telArr[1] + telArr[2];
		        	
		        	$('#driverInfoDiv #operNmKr0').val(results.rows.item(0).resKorNm);
		        	$('#driverInfoDiv #operSurNm0').val(results.rows.item(0).resLastNm);
		        	$('#driverInfoDiv #operGivenNm0').val(results.rows.item(0).resFirstNm);
		        	$('#driverInfoDiv #emailAddr0').val(results.rows.item(0).resEmail);
		        	$('#driverInfoDiv #birthday0').val(userBirthDay);
		        	$('#driverInfoDiv #telNo0').val(telNo);
	        	}        	
			}, jSessionID)
		}else{
			$('#driverInfoDiv #operNmKr0').val('');
        	$('#driverInfoDiv #operSurNm0').val('');
        	$('#driverInfoDiv #operGivenNm0').val('');
        	$('#driverInfoDiv #emailAddr0').val('');
        	$('#driverInfoDiv #birthday0').val('');
        	$('#driverInfoDiv #telNo0').val('');
		}
	}
	
	$(document).ready(function() {
		fn_driverInfo();
	});
</script>

<!-- 운전자 정보 -->
<p class="pop_lcvtitle mt7">렌터카 정보</p>
<div class="obj_title2">
	<p class="chkbox">
		<span><input id="rntEqualChkbox" name="rntEqualChkbox" type="checkbox" data-role="none" onclick="fn_rntEqualChk()"></span>
		<label for="rntEqualChkbox">대표예약자와 운전자가 동일합니다.</label> 
	</p>
</div>
<div id="driverInfoDiv">
</div>

<dl class="ft_acdon3 mt7">
	<dt>요청사항</dt>
	<dd>
		<ul class="dotlist2">
			<li>운전자 나이가 만 25세 미만일 경우 차량 및 보험 추가 비용이 발생하니 차량 대여 비용을 확인하세요.</li>
			<li>여권 영문이름과 동일하지 않을 경우 대여가 불가능 하니, 여권 영문이름과 동일한 정보 입력을 해주세요.</li>
			<li>협지에서 예약한 차량 결제 시, 여권 검사를 하니 대여점 방문 시 반드시 여권을 지참해주세요.</li>
		</ul>
	</dd>
	<dt>기타요청사항(Remarks)</dt>
	<dd>
		<p><textarea name="rentMemo" id="rentMemo" class="t_area1" data-role="none" placeholder="요청사항은 공백 포함 한글기준 500자 이내로 작성해 주시기 바랍니다."></textarea></p>
	</dd>
</dl>