<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>


<%
	// 서버 날짜 받아오기 
	Date systemDate = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
	String serverDay = sdf.format(systemDate);
		
%>

<script>
	$(document).ready(function(){
		var hotelSearchData = JSON.parse(sessionStorage.hotelSearchVal);
		
		if(nullToBlank(hotelSearchData) != "" && hotelSearchData != '[]'){
			$("#srch_arr_ct_dis").val(hotelSearchData.countryNm);
			$("#searchCity").val(hotelSearchData.findLocNm);
			$("#searchCityNm").val(hotelSearchData.countryNm);
			$("#searchCountry").val(hotelSearchData.countryCd);
			
			var checkInDtArr = hotelSearchData.checkInDt.split("-");
			var checkOutDtArr = hotelSearchData.checkOutDt.split("-");
			
			$("#dep_dt").html(checkInDtArr[0] +"."+ checkInDtArr[1] +"."+ checkInDtArr[2]);
			$("#arr_dt").html(checkOutDtArr[0] +"."+ checkOutDtArr[1] +"."+ checkOutDtArr[2]);
			
			$("#srch_night_days").html(hotelSearchData.nightDay + "박");
			
			var searchRoomList = hotelSearchData.roomCont;
			
			for(var i = 0; i < searchRoomList.length; i++){
				var index = i + 1;
				
				if(i != 0){
					$(".hotal_clone"+ index).addClass("htshow");
					$(".hotal_clone"+ index).show();
				}
				
				$("#seat_"+ index).val(searchRoomList[i].roomTy);
				$("#ps_ad_cunt_"+ index).html(searchRoomList[i].numOfAdt);
				$("#ps_ch_cunt_"+ index).html(searchRoomList[i].numOfChd);
				
				if(nullToBlank(searchRoomList[i].ageOfChd) != ""){
					ageOfChdArr = searchRoomList[i].ageOfChd.split(",");
					
					$("#ageboxId"+ index).addClass("agenum"+ ageOfChdArr.length);
					
					for(var j = 0; j < ageOfChdArr.length; j++){
						var jIndex = (j + 1);
						
						$("#ht"+ index +"_chage"+ jIndex).val(ageOfChdArr[j]);
					}
				}
			}
		}
	});
</script>
<!-- 호텔파트 -->
<div class="chkpart hotelpart">
	<div id="hotel_search_div" class="ht_clone ps_view" ft-att="HTGroup">
		<div class="fs_search">
			<div class="csbox">
				<form name="" method="#">
					<fieldset>
						<legend>검색폼</legend>
						<input type="text" name="srch_arr_ct_dis" id="srch_arr_ct_dis" class="layerOpener" data-url="/pop/pop_hotel_city_select.do?availTy=HT"  data-ctn="full" data-role="none" style="cursor='hand';"
							placeholder="도시, 호텔, 인근도시, 공항 등" />
						 <input type="hidden" name="searchCity" id="searchCity" value="" />
	                     <input type="hidden" name="searchCityNm" id="searchCityNm" value="" />
	                     <input type="hidden" name="searchCityNmEn" id="searchCityNmEn" value="" />
	                     <input type="hidden" name="searchCountry" id="searchCountry" value="" />	
						<button type="button" data-role="none">검색</button>
					</fieldset>
				</form>
			</div>
		</div>
		<!-- 날짜 -->
		<ul class="tra_day tra_day2 tra_day3">
			<li><button type="button" data-role="none" class="layerOpener" data-url="/pop/pop_ht_calendar.do?type=HOTEL&availTy=HT"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'>
					<span name="depDt" id="dep_dt"><%=serverDay%></span>
				</button></li>
			<li><button type="button" class="layerOpener" data-url="/pop/pop_nightdays.do"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'><span name='nightDays' id="srch_night_days">선택</button></li>
			<li><button type="button" data-role="none" data-role="none" class="layerOpener" data-url="/pop/pop_ht_calendar.do?type=HOTEL&availTy=HT"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'>
					<span class="noSelect" name="arrDt" id="arr_dt">미지정</span>
				</button></li>
		</ul>
		<!-- 동일 적용 -->
		<div class="selectchk chkv_show2">
			<p class="chkbox ah_show2">
				<span><input id="chk_cusm5" type="checkbox" data-role="none" /></span>
				<label for="chk_cusm5">선택 지역 호텔 동일 적용</label>
			</p>
			<p class="chkbox hc_show2">
				<span><input id="chk_cusm6" type="checkbox" data-role="none" /></span>
				<label for="chk_cusm6">선택 지역 렌터카 동일 적용</label>
			</p>
		</div>
		<!-- 객실추가 Clone -->
	
		<div class="hotal_clone hotal_clone1">
				<!-- 객실 선택버튼 -->
				<div class="seatbtn setroom selectbox">
					<span>객실1</span>
					<button class="setroom_remove" type="button" data-role="none">삭제</button>
					<select name="seat_1" id = "seat_1" data-role="none" class="centerSelect">
						<option value="01">1인실 (싱글룸)</option>
						<option value="03">2인실 (더블 요청)</option>
						<option value="02">2인실 (트윈 요청)</option>
						<option value="04">3인실</option>
						 
						<option value="05">4인실</option>
						<!--
						<option value="06">트윈 + 아동</option>
						<option value="07">더블 + 아동</option>
						 -->
					</select>
				</div>
				<!-- 인원수 체크 -->
				<ul class="personnel psa2" data-msg="성인, 아동의 합이 9명을 넘길 수 없습니다.">
					<li>
						<dl>
							<dt><em>성인</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id ="ps_ad_cunt_1">1</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><em>아동</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id="ps_ch_cunt_1">0</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
				</ul>
				<!-- 아동나이버튼 -->
				<div class="agebox" id="ageboxId1">
					<div class="seatbtn agebox2 selectbox">
						<select name="ht1_chage1" id="ht1_chage1" data-role="none" class="leftSelect">
							<option value="">아동1 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht1_chage2" id="ht1_chage2" data-role="none" class="leftSelect">
							<option value="">아동2 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht1_chage3" id="ht1_chage3" data-role="none" class="leftSelect">
							<option value="">아동3 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
				</div>
			</div>
			<div class="hotal_clone hotal_clone2">
				<!-- 객실 선택버튼 -->
				<div class="seatbtn setroom selectbox">
					<span>객실2</span>
					<button class="setroom_remove" type="button" data-role="none">삭제</button>
					<select name="seat_2" id="seat_2" data-role="none" class="centerSelect">
						<option value="01">1인실 (싱글룸)</option>
						<option value="03">2인실 (더블 요청)</option>
						<option value="02">2인실 (트윈 요청)</option>
						<option value="04">3인실</option>
						
						<option value="05">4인실</option>
						<!-- 
						<option value="06">트윈 + 아동</option>
						<option value="07">더블 + 아동</option>
						 -->
					</select>
				</div>
				<!-- 인원수 체크 -->
				<ul class="personnel psa2" data-msg="성인, 아동의 합이 9명을 넘길 수 없습니다.">
					<li>
						<dl>
							<dt><em>성인</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id="ps_ad_cunt_2">1</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><em>아동</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id="ps_ch_cunt_2">0</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
				</ul>
				<!-- 아동나이버튼 -->
				<div class="agebox" id="ageboxId2">
					<div class="seatbtn agebox2 selectbox">
						<select name="ht2_chage1" id="ht2_chage1" data-role="none" class="leftSelect">
							<option value="">아동1 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht2_chage2" id="ht2_chage2" data-role="none" class="leftSelect">
							<option value="">아동2 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht2_chage3" id="ht2_chage3" data-role="none" class="leftSelect">
							<option value="">아동3 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
				</div>
			</div>
			<div class="hotal_clone hotal_clone3">
				<!-- 객실 선택버튼 -->
				<div class="seatbtn setroom selectbox">
					<span>객실3</span>
					<button class="setroom_remove" type="button" data-role="none">삭제</button>
					<select name="seat_3" id="seat_3" data-role="none" class="centerSelect">
						<option value="01">1인실 (싱글룸)</option>
						<option value="03">2인실 (더블 요청)</option>
						<option value="02">2인실 (트윈 요청)</option>
						<option value="04">3인실</option>
						 
						<option value="05">4인실</option>
						<!--
						<option value="06">트윈 + 아동</option>
						<option value="07">더블 + 아동</option>
						 -->
					</select>
				</div>
				<!-- 인원수 체크 -->
				<ul class="personnel psa2" data-msg="성인, 아동의 합이 9명을 넘길 수 없습니다.">
					<li>
						<dl>
							<dt><em>성인</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id="ps_ad_cunt_3">1</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><em>아동</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id="ps_ch_cunt_3">0</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
				</ul>
				<!-- 아동나이버튼 -->
				<div class="agebox" id="ageboxId3">
					<div class="seatbtn agebox2 selectbox">
						<select name="ht3_chage1" id="ht3_chage1" data-role="none" class="leftSelect">
							<option value="">아동1 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht3_chage2" id="ht3_chage2" data-role="none" class="leftSelect">
							<option value="">아동2 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht3_chage3" id="ht3_chage3" data-role="none" class="leftSelect">
							<option value="">아동3 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
				</div>
			</div>
			<div class="hotal_clone hotal_clone4">
				<!-- 객실 선택버튼 -->
				<div class="seatbtn setroom selectbox">
					<span>객실4</span>
					<button class="setroom_remove" type="button" data-role="none">삭제</button>
					<select name="seat_4" id="seat_4" data-role="none" class="centerSelect">
						<option value="01">1인실 (싱글룸)</option>
						<option value="03">2인실 (더블 요청)</option>
						<option value="02">2인실 (트윈 요청)</option>
						<option value="04">3인실</option>
						
						<option value="05">4인실</option>
						<!-- 
						<option value="06">트윈 + 아동</option>
						<option value="07">더블 + 아동</option>
						 -->
					</select>
				</div>
				<!-- 인원수 체크 -->
				<ul class="personnel psa2" data-msg="성인, 아동의 합이 9명을 넘길 수 없습니다.">
					<li>
						<dl>
							<dt><em>성인</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id="ps_ad_cunt_4">1</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><em>아동</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id="ps_ch_cunt_4">0</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
				</ul>
				<!-- 아동나이버튼 -->
				<div class="agebox" id="ageboxId4">
					<div class="seatbtn agebox2 selectbox">
						<select name="ht4_chage1" id="ht4_chage1" data-role="none" class="leftSelect">
							<option value="">아동1 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht4_chage2" id="ht4_chage2" data-role="none" class="leftSelect">
							<option value="">아동2 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht4_chage3" id="ht4_chage3" data-role="none" class="leftSelect">
							<option value="">아동3 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
				</div>
			</div>
			<div class="hotal_clone hotal_clone5">
				<!-- 객실 선택버튼 -->
				<div class="seatbtn setroom selectbox">
					<span>객실5</span>
					<button class="setroom_remove" type="button" data-role="none">삭제</button>
					<select name="seat_5" id="seat_5" data-role="none" class="centerSelect">
						<option value="01">1인실 (싱글룸)</option>
						<option value="03">2인실 (더블 요청)</option>
						<option value="02">2인실 (트윈 요청)</option>
						<option value="04">3인실</option>
						 
						<option value="05">4인실</option>
						<!--
						<option value="06">트윈 + 아동</option>
						<option value="07">더블 + 아동</option>
						 -->
					</select>
				</div>
				<!-- 인원수 체크 -->
				<ul class="personnel psa2" data-msg="성인, 아동의 합이 9명을 넘길 수 없습니다.">
					<li>
						<dl>
							<dt><em>성인</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id="ps_ad_cunt_5">1</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><em>아동</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id="ps_ch_cunt_5">0</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
				</ul>
				<!-- 아동나이버튼 -->
				<div class="agebox" id="ageboxId5">
					<div class="seatbtn agebox2 selectbox">
						<select name="ht5_chage1" id="ht5_chage1" data-role="none" class="leftSelect">
							<option value="">아동1 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht5_chage2" id="ht5_chage2" data-role="none" class="leftSelect">
							<option value="">아동2 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht5_chage3" id="ht5_chage3" data-role="none" class="leftSelect">
							<option value="">아동3 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
				</div>
			</div>
			<div class="hotal_clone hotal_clone6">
				<!-- 객실 선택버튼 -->
				<div class="seatbtn setroom selectbox">
					<span>객실6</span>
					<button class="setroom_remove" type="button" data-role="none">삭제</button>
					<select name="seat_6" id="seat_6" data-role="none" class="centerSelect">
						<option value="01">1인실 (싱글룸)</option>
						<option value="03">2인실 (더블 요청)</option>
						<option value="02">2인실 (트윈 요청)</option>
						<option value="04">3인실</option>
						 
						<option value="05">4인실</option>
						<!--
						<option value="06">트윈 + 아동</option>
						<option value="07">더블 + 아동</option>
						 -->
					</select>
				</div>
				<!-- 인원수 체크 -->
				<ul class="personnel psa2" data-msg="성인, 아동의 합이 9명을 넘길 수 없습니다.">
					<li>
						<dl>
							<dt><em>성인</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id="ps_ad_cunt_6">1</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><em>아동</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id="ps_ch_cunt_6">0</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
				</ul>
				<!-- 아동나이버튼 -->
				<div class="agebox" id="ageboxId6">
					<div class="seatbtn agebox2 selectbox">
						<select name="ht6_chage1" id="ht6_chage1" data-role="none" class="leftSelect">
							<option value="">아동1 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht6_chage2" id="ht6_chage2" data-role="none" class="leftSelect">
							<option value="">아동2 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht6_chage3" id="ht6_chage3" data-role="none" class="leftSelect">
							<option value="">아동3 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
				</div>
			</div>
			<div class="hotal_clone hotal_clone7">
				<!-- 객실 선택버튼 -->
				<div class="seatbtn setroom selectbox">
					<span>객실7</span>
					<button class="setroom_remove" type="button" data-role="none">삭제</button>
					<select name="seat_7" id="seat_7" data-role="none" class="centerSelect">
						<option value="01">1인실 (싱글룸)</option>
						<option value="03">2인실 (더블 요청)</option>
						<option value="02">2인실 (트윈 요청)</option>
						<option value="04">3인실</option>
						 
						<option value="05">4인실</option>
						<!--
						<option value="06">트윈 + 아동</option>
						<option value="07">더블 + 아동</option>
						 -->
					</select>
				</div>
				<!-- 인원수 체크 -->
				<ul class="personnel psa2" data-msg="성인, 아동의 합이 9명을 넘길 수 없습니다.">
					<li>
						<dl>
							<dt><em>성인</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id="ps_ad_cunt_7">1</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><em>아동</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id="ps_ch_cunt_7">0</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
				</ul>
				<!-- 아동나이버튼 -->
				<div class="agebox" id="ageboxId7">
					<div class="seatbtn agebox2 selectbox">
						<select name="ht7_chage1" id="ht7_chage1" data-role="none" class="leftSelect">
							<option value="">아동1 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht7_chage2" id="ht7_chage2" data-role="none" class="leftSelect">
							<option value="">아동2 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht7_chage3" id="ht7_chage3" data-role="none" class="leftSelect">
							<option value="">아동3 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
				</div>
			</div>
			<div class="hotal_clone hotal_clone8">
				<!-- 객실 선택버튼 -->
				<div class="seatbtn setroom selectbox">
					<span>객실8</span>
					<button class="setroom_remove" type="button" data-role="none">삭제</button>
					<select name="seat_8" id="seat_8" data-role="none" class="centerSelect">
						<option value="01">1인실 (싱글룸)</option>
						<option value="03">2인실 (더블 요청)</option>
						<option value="02">2인실 (트윈 요청)</option>
						<option value="04">3인실</option>
						
						<option value="05">4인실</option>
						<!-- 
						<option value="06">트윈 + 아동</option>
						<option value="07">더블 + 아동</option>
						 -->
					</select>
				</div>
				<!-- 인원수 체크 -->
				<ul class="personnel psa2" data-msg="성인, 아동의 합이 9명을 넘길 수 없습니다.">
					<li>
						<dl>
							<dt><em>성인</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id="ps_ad_cunt_8">1</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><em>아동</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id="ps_ch_cunt_8">0</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
				</ul>
				<!-- 아동나이버튼 -->
				<div class="agebox" id="ageboxId8">
					<div class="seatbtn agebox2 selectbox">
						<select name="ht8_chage1" id="ht8_chage1" data-role="none" class="leftSelect">
							<option value="">아동1 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht8_chage2" id="ht8_chage2" data-role="none" class="leftSelect">
							<option value="">아동2 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht8_chage3" id="ht8_chage3" data-role="none" class="leftSelect">
							<option value="">아동3 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
				</div>
			</div>
			<div class="hotal_clone hotal_clone9">
				<!-- 객실 선택버튼 -->
				<div class="seatbtn setroom selectbox">
					<span>객실9</span>
					<button class="setroom_remove" type="button" data-role="none">삭제</button>
					<select name="seat_9" id="seat_9" data-role="none" class="centerSelect">
					<option value="01">1인실 (싱글룸)</option>
						<option value="03">2인실 (더블 요청)</option>
						<option value="02">2인실 (트윈 요청)</option>
						<option value="04">3인실</option>
						
						<option value="05">4인실</option>
						<!-- 
						<option value="06">트윈 + 아동</option>
						<option value="07">더블 + 아동</option>
						 -->
					</select>
				</div>
				<!-- 인원수 체크 -->
				<ul class="personnel psa2" data-msg="성인, 아동의 합이 9명을 넘길 수 없습니다.">
					<li>
						<dl>
							<dt><em>성인</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id="ps_ad_cunt_9">1</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><em>아동</em></dt>
							<dd class="ps_c1"><button data-role="none">내림</button></dd>
							<dd class="ps_cunt"><span id="ps_ch_cunt_9">0</span></dd>
							<dd class="ps_c2"><button data-role="none">올림</button></dd>
						</dl>
					</li>
				</ul>
				<!-- 아동나이버튼 -->
				<div class="agebox" id="ageboxId9">
					<div class="seatbtn agebox2 selectbox">
						<select name="ht9_chage1" id="ht9_chage1" data-role="none" class="leftSelect">
							<option value="">아동1 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht9_chage2" id="ht9_chage2" data-role="none" class="leftSelect">
							<option value="">아동2 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
					<div class="seatbtn agebox2 selectbox">
						<select name="ht9_chage3" id="ht9_chage3" data-role="none" class="leftSelect">
							<option value="">아동3 나이</option>
							<option value="1">만 1세</option>
							<option value="2">만 2세</option>
							<option value="3">만 3세</option>
							<option value="4">만 4세</option>
							<option value="5">만 5세</option>
							<option value="6">만 6세</option>
							<option value="7">만 7세</option>
							<option value="8">만 8세</option>
							<option value="9">만 9세</option>
							<option value="10">만 10세</option>
							<option value="11">만 11세</option>
							<option value="12">만 12세</option>
							<option value="13">만 13세</option>
							<option value="14">만 14세</option>
							<option value="15">만 15세</option>
							<option value="16">만 16세</option>
						</select>
					</div>
				</div>
			</div>
	</div>
	
	<!-- 버튼 -->
	<div class="btn_one air_tbtn addbtn2">
		<button class="white2" data-role="none">객실추가</button>
	</div>
	<div class="btn_one air_tbtn chkv_hid">
		<button class="purple2" data-role="none" onclick="fn_HotelResearch();" id="hotelSearch">호텔검색하기</button>
	</div>
</div>