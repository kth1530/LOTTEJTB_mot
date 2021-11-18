<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : inc_reserve_step4_travels_info.jsp
	// 설명 : 여행자 정보 입력 > 여행자 정보 입력 
%>

<script type="text/javascript">
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){
	
	function fn_display_div() {
		
		var i = 1;
		for (;i < 11; i++) {
			var html = "";
			html = html + "	<div class='obj_title1 mt7'>";
			html = html + "		여행자 정보"+i;
			if(i == 1) {
				html = html + "		<p class='chkbox'>";
				html = html + "			<span><input id='checkEqualsTraveler' type='checkbox' data-role='none' onClick='equalsTraveler()'></span>";
				html = html + "			<label for='chk_ck1'>예약자와 동일합니다</label>";
				html = html + "		</p>";
			}

			html = html + "	</div>";
			html = html + "	<table class='ft_table2 ft_thd_tl step4app mt7'>";
			html = html + "		<colgroup>";
			html = html + "			<col style='width: 28%'>";
			html = html + "			<col style='width: 72%'>";
			html = html + "		</colgroup>";
			html = html + "		<tbody>";
			html = html + "			<tr>";
			html = html + "				<th>한글명<em class='f_red'>*</em></th>";
			html = html + "				<td><input type='text' data-role='none' placeholder='한글' data-maxlength='5' value='' id='inwon"+i+"_nm' name='inwon"+i+"_nm' onkeyup='limitText(this, 5)'/></td>";
			html = html + "			</tr>";
			html = html + "			<tr>";
			html = html + "				<th>영문 성/이름<em class='f_red'>*</em></th>";
			html = html + "				<td>";
			html = html + "					<p>";
			html = html + "						<input type='text' class='eng_name1' data-role='none' id='inwon"+i+"_ename' name='inwon"+i+"_ename' placeholder='영문 이름' style='text-transform:uppercase;' value='' ft-att='inwon"+i+"_ename'/>";
			html = html + "						<input type='text' class='eng_name2' data-role='none' id='inwon"+i+"_efname' name='inwon"+i+"_efname' placeholder='영문 성' style='text-transform:uppercase;' value='' ft-att='inwon"+i+"_efname'/>";
			html = html + "					</p>";
			html = html + "				</td>";
			html = html + "			</tr>";
			html = html + "			<tr>";
			html = html + "				<th>생년월일<em class='f_red'>*</em></th>";
			html = html + "				<td><input type='text' data-role='none' placeholder='예) 19800701' id='inwon"+i+"_birthday' name='inwon"+i+"_birthday' ft-att='inwon"+i+"_birthday' pattern='[0-9]*' onkeydown='return f_Onlynum();'/></td>";
			html = html + "			</tr>";
			html = html + "			<tr>";
			html = html + "				<th>연락처<em class='f_red'>*</em></th>";
			html = html + "				<td><input type='text' data-role='none' placeholder='예) 01012345678' id='inwon"+i+"_htel' name='inwon"+i+"_htel' ft-att='inwon"+i+"_htel' pattern='[0-9]*' onkeydown='return f_Onlynum();'/></td>";
			html = html + "			</tr>";
			html = html + "			<tr>";
			html = html + "				<th>여권유무<em class='f_red'>*</em></th>";
			html = html + "				<td>";
			html = html + "					<span class='radioboxs radioboxs2'><input type='radio' id='inwon"+i+"_passYn1' name='inwon"+i+"_passYn' ft-att='inwon"+i+"_passYn'  data-role='none' value='N' checked></span><label for='inwon"+i+"_passYn1' class='wauto'>없음</label>"; 
			html = html + "					<span class='radioboxs radioboxs2 ml10'><input type='radio' id='inwon"+i+"_passYn2' name='inwon"+i+"_passYn' ft-att='inwon"+i+"_passYn'  data-role='none' value='Y' ></span> <label for='inwon"+i+"_passYn2' class='wauto'>있음</label>";
			html = html + "				</td>";
			html = html + "			</tr>";
			html = html + "			<tr>";
			html = html + "				<th>성별<em class='f_red'>*</em></th>";
			html = html + "				<td>";
			html = html + "					<span class='radioboxs radioboxs2'><input type='radio' id='inwon"+i+"_sex1' name='inwon"+i+"_sex' ft-att='inwon"+i+"_sex'  data-role='none' value='M' checked></span> <label for='inwon"+i+"_sex1' class='wauto'>남자</label>";
			html = html + "					<span class='radioboxs radioboxs2 ml10'><input type='radio' id='inwon"+i+"_sex2' name='inwon"+i+"_sex' ft-att='inwon"+i+"_sex'  data-role='none' value='F'></span> <label for='inwon"+i+"_sex2' class='wauto'>여자</label>";
			html = html + "				</td>";
			html = html + "			</tr>";
			html = html + "		</tbody>";
			html = html + "	</table>";


			var div_air_inwon = "div_air_inwon_" + i;
			$(div_air_inwon).html(html);
			$(div_air_inwon).show();
		}
	}

	function fn_init() {

		fn_display_div();
	}

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		// fn_initButton();

		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});

	
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