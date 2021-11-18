<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<%
	// 서버 날짜 받아오기 
	Date systemDate2 = new Date();
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
	SimpleDateFormat sdfVal = new SimpleDateFormat("yyyMMdd", Locale.KOREA);
	String serverDay2 = sdf2.format(systemDate2);
	String serverDayVal = sdfVal.format(systemDate2);
		
%>
<script type="text/javascript">
	var fn_rentInit = function(){
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
		
		var date = new Date();
		date.setHours(date.getHours() + 2);
		date = date.format("HH");		
		
		//$("#takeTime").val(date + "00").prop("selected", true);
		//$("#returnTime").val(date + "00").prop("selected", true);
		
		$("#takeTime").val("1000").prop("selected", true);
		$("#returnTime").val("1000").prop("selected", true);
		
		
		vHTML_driver += '<option value="">운전자 나이 (인수일 기준)</option>';
		vHTML_driver += '<option value="70">만70+**세</option>';
		vHTML_driver += '<option value="30">만30~69세</option>';
		
		for(var y = 29; y > 17; y--){
			vHTML_driver += '<option value="'+ y +'">만'+ y +'세</option>';
		}
		
		$("#driverAge").html(vHTML_driver);
	}
	
	$(document).ready(function() {
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
		
		if(!$("#same_place").is(":checked")){
			$("#same_place").click();
		}else{
			$("#arr_place").prop("disabled", true);
		}
		
		fn_rentInit();
	});

	
</script>
<!-- 렌터카파트 -->
<div class="chkpart carpart" ft-att="RCGroup" id="car_search_div">
	<p class="pop_lcvtitle mt7">렌터카</p>
	<div class="car_box">
		<div class="fs_search car_search">
			<p class="schtitle">인수장소</p>
			<div class="csbox">
			<form>
				<fieldset>
					<legend>검색폼</legend>
					<input type="text" data-role="none" class="layerOpener" id="dep_place" data-url="/pop/pop_city_select3.do?availTy=RC&type=D" data-ctn="full" data-role="none" style="cursor='hand';" placeholder="도시, 호텔, 인근도시, 공항 등" />
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
						<span><input id="same_place" type="checkbox" data-role="none"/></span>
					</p>
				</p>
			</div>
			<div class="csbox">
				<form>
					<fieldset>
						<legend>검색폼</legend>
						<input type="text" data-role="none" class="layerOpener" id="arr_place" data-url="/pop/pop_city_select3.do?availTy=RC&type=A" data-ctn="full" data-role="none" style="cursor='hand';" placeholder="도시, 호텔, 인근도시, 공항 등"/>
						<input type="hidden" name="return_place_cd" id="return_place_cd"/>
						<input type="hidden" name="return_place_oagCd" id="return_place_oagCd"/>
						<input type="hidden" name="return_place_countryCd" id="return_place_countryCd"/>
						<button type="button" data-role="none">검색</button>
					</fieldset>
				</form>
			</div>
		</div>
		<!-- 날짜와 시간 -->
		<ul class="tra_day tra_day2 cardaytime">
			<li>
				<button type="button" data-role="none" class="layerOpener" data-url="/pop/pop_rc_calendar.do?type=RENTCAR&availTy=RC"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'>
					<em>차량 인수일</em><span class="noSelect" id="dep_dt">미지정</span>
				</button>
				<input type="hidden" name="take_date" id="take_date" value="<%=serverDayVal%>"/>
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
				<button type="button" data-role="none" class="layerOpener" data-url="/pop/pop_rc_calendar.do?type=RENTCAR&availTy=RC"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'>
					<em>차량 반납일</em><span class="noSelect" id="arr_dt">미지정</span>
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
		<!-- 기본버튼 -->
		<div class="seatbtn selectbox carageobx">
			<button type="button" class="layerOpener select_guidebtn" data-url="/pop/pop_age_text.do" data-role="none" style="cursor='hand';">설명</button>
			<select name="driverAge" data-role="none" class="centerSelect" id="driverAge">
			</select>
		</div>
		<!-- 버튼 -->
		<div class="btn_one air_tbtn chkv_hid"><button class="purple2" data-role="none" onclick="fn_goSelPage();">렌터카 검색하기</button></div>
	</div>	
</div>
