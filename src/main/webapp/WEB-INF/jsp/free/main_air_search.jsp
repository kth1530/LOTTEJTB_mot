<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<%
	// 서버 날짜 받아오기 
	Date systemDate = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
	String serverDay = sdf.format(systemDate);		
%>
<script>
	var mtOtherCnt = 3;

	function fn_chnAvailTy(chkAvailTy) {
		var airDiv = $('div#air_search_div');
		airDiv.find('div[ar-att="availgroup"]').hide();
		airDiv.find('div[ft-att="' + chkAvailTy + 'Group"]').show();
	}

	function fn_addTravelPlan() {
		
		mtOtherCnt ++;

		if(mtOtherCnt < 5) {
			var html = "";

			// <!-- 여정 2 -->
			html = html + "<div class='many_travelbox'>";
			// <!-- 간략안내 -->
			html = html + "	<div class='travel' mt-data='"+mtOtherCnt+"' mt-att='availDiv'>";
			html = html + "		<p>여정 "+mtOtherCnt+" </p>";
			html = html + "	</div>";
			html = html + "	<div class='stable_guide oenway'>";
				
			html = html + "		<button type='button' class='layerOpener' data-url='/pop/pop_city_select2.do?availTy=MT&travelMtCnt="+ mtOtherCnt + "&type=D'  data-ctn='full' data-role='none' style='cursor='hand';'>";
			html = html + "			<p class='st_text'>";
			html = html + "				<span name='depCd' id='srch_dep_ct"+mtOtherCnt+"'>도착</span>";
			html = html + "				<input type='hidden' name='depCd' id='srch_dep_ct"+mtOtherCnt+"' value=''/>";
			html = html + "				<input type='hidden' id='srch_dep_naCd"+mtOtherCnt+"' name='srch_dep_naCd"+mtOtherCnt+"' value='' />";
			html = html + "			</p>";
			html = html + "			<p>";
			html = html + "				<span name='depNm' ar-att='departure' target-id='srch_dep_ct"+mtOtherCnt+"' id='srch_dep_ct_dis"+mtOtherCnt+"'>도착지 선택</span>";
			html = html + "			</p>";
			html = html + "		</button>";

			html = html + "		<button type='button' class='layerOpener' data-url='/pop/pop_city_select2.do?availTy=MT&travelMtCnt="+ mtOtherCnt + "&type=A' data-ctn='full' data-role='none' style='cursor='hand';'>";
			html = html + "			<p class='st_text'>";
			html = html + "				<span name='arrCd' id='srch_arr_ct"+mtOtherCnt+"'>도착</span>";
			html = html + "				<input type='hidden' id='srch_arr_naCd"+mtOtherCnt+"' name='srch_arr_naCd"+mtOtherCnt+"' value='' />";
			html = html + "			</p>";
			html = html + "			<p>";
			html = html + "				<span name='arrNm' id='srch_arr_ct_dis"+mtOtherCnt+"' target-id='srch_arr_ct"+mtOtherCnt+"' ar-att='arrive'>도착지 선택</span>";
			html = html + "			</p>";
			html = html + "		</button>";

			html = html + "	</div>";
				
			// <!-- 날짜 -->
			html = html + "	<ul class='tra_day tra_day1'>";
			html = html + "		<li><button type='button' class='layerOpener' data-url='/pop/pop_calendar.do?type=AIR&availTy=MT&travelMtCnt="+ mtOtherCnt + "'  data-ctn='full' data-role='none' style='cursor='hand';' data-ok='yes'><span name='depDt' id='dep_dt"+mtOtherCnt+"'><%=serverDay%></span></button></li>";
			html = html + "	</ul>";
			html = html + "</div>";

			$('#div_othertravelplan').append(html);

			if(mtOtherCnt == 4) {
				$('#div_addtravelbtn').hide();
			}
		} else {
			$('#div_addtravelbtn').hide();
		}
	}
	
	$("document").ready(function(){
		var airDiv = $('div#air_search_div');
		airDiv.find('div[ar-att="availgroup"]').hide();
		airDiv.find('div[ft-att="RTGroup"]').show();
	})
	
</script>

<!-- 항공파트 -->
<div class="airpart" ft-att="srchKind" id="air_search_div">
	<ul class="tablist_com free_airtab" data-ctn="airbox" style="display:none;">
		<li class="active"><button type="button" data-role="none" id="chkC" name="availTy" onclick="fn_chnAvailTy('RT');" value='RT'>왕복</button></li>
		<li><button type="button" data-role="none" id="chkI" name="availTy" onclick="fn_chnAvailTy('OW');" value='OW'>편도</button></li>
		<li class="chkv_hid"><button type="button" data-role="none" id="chkH" name="availTy" onclick="fn_chnAvailTy('MT');" value='MT'>다구간</button></li>
		<li class="chkv_hid"><button type="button" data-role="none" id="chkM" name="availTy" onclick="fn_chnAvailTy('OO');" value='OO'>해외출발</button></li>
	</ul>
	<!-- 왕복 도시, 날짜, 인원 선택 -->
	<div class="tabctn_com airbox1" ft-att="RTGroup" ar-att="availgroup" style="display:block;">
		<!-- 간략안내 -->
		<div class="stable_guide sground">
			<button type="button" class="layerOpener" data-url="/pop/pop_city_select1.do?availTy=RT" data-width="300" data-height="400" data-ctn="full" data-role="none" style="cursor='hand';">
				<p class="st_text">
					<span name="depCd" id="srch_dep_ct">SEL</span>
					<input type='hidden' id='srch_dep_naCd' name='srch_dep_naCd' value='KR' />
				</p>
				<p>
					<span name="depNm" ar-att="departure" target-id="srch_dep_ct" id="srch_dep_ct_dis">인천/김포</span>
				</p>
			</button>

			<button type="button" class="layerOpener" data-url="/pop/pop_city_select2.do?availTy=RT"  data-ctn="full" data-role="none" style="cursor='hand';">
				<p class="st_text">
					<span name="arrCd" id="srch_arr_ct">도착</span>
					<input type="hidden" id="srch_arr_naCd" name="srch_arr_naCd" value="" />
				</p>
				<p>
					<span name="arrNm" id="srch_arr_ct_dis" target-id="srch_arr_ct" ar-att="arrive">도착지 선택</span>
				</p>
			</button>
		</div>
		<!-- 날짜 -->
		<ul class="tra_day tra_day2">
			<li><button type="button" class="layerOpener" data-url="/pop/pop_calendar.do?type=AIR&availTy=RT"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'><span class="noSelect" name="depDt" id="dep_dt">미지정</span></button></li>
			<li><button type="button" class="layerOpener" data-url="/pop/pop_calendar.do?type=AIR&availTy=RT"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'><span class="noSelect" name="arrDt" id="arr_dt">미지정</span></button></li>
		</ul>
		<!-- 기본목록버튼 -->
		<div class="seatbtn selectbox" id="cabinClasSelectBox">
			<select id="cabinClas" name="cabinClas" data-role="none" class="centerSelect">
				<option value="Y">일반석</option>
				<option value="W">프리미엄 일반석</option>
				<option value="C">비즈니스석</option>
				<option value="F">일등석</option>
			</select>
		</div>
		<!-- 인원수 체크 -->
		<ul class="personnel" data-msg="성인, 소아, 유아의 합이 9명을 넘길 수 없습니다." id='RTmembers'>
			<li>
				<dl>
					<dt>
						<em>성인</em><span>(만12세이상)</span>
					</dt>
					<dd class="ps_c1">
						<button data-role="none">내림</button>
					</dd>
					<dd class="ps_cunt">
						<span id="adtCnt" name="adtCnt">1</span>
					</dd>
					<dd class="ps_c2">
						<button data-role="none">올림</button>
					</dd>
				</dl>
			</li>
			<li>
				<dl>
					<dt>
						<em>소아</em><span>(만2~12세미만)</span>
					</dt>
					<dd class="ps_c1">
						<button data-role="none">내림</button>
					</dd>
					<dd class="ps_cunt">
						<span id="chdCnt" name="chdCnt">0</span>
					</dd>
					<dd class="ps_c2">
						<button data-role="none">올림</button>
					</dd>
				</dl>
			</li>
			<li>
				<dl>
					<dt>
						<em>유아</em><span>(2세미만)</span>
					</dt>
					<dd class="ps_c1">
						<button data-role="none">내림</button>
					</dd>
					<dd class="ps_cunt">
						<span id="infCnt" name="infCnt">0</span>
					</dd>
					<dd class="ps_c2">
						<button data-role="none">올림</button>
					</dd>
				</dl>
			</li>
		</ul>
		<!-- 버튼 -->
		<div class="btn_one air_tbtn chkv_hid">
			<button class="purple2" data-role="none" onclick="fn_goSelPage()">항공권 검색하기</button>
		</div>
	</div>
	<!-- 편도 도시, 날짜 선택 -->
	<div class="tabctn_com airbox airbox2" ft-att="OWGroup" ar-att="availgroup">
		<!-- 간략안내 -->
		<div class="stable_guide oenway">
			<button type="button" class="layerOpener" data-url="/pop/pop_city_select1.do?availTy=OW" data-width="300" data-height="400" data-ctn="full" data-role="none" style="cursor='hand';">
				<p class="st_text">
					<span name="depCd" id="srch_dep_ct">SEL</span>
					<input type='hidden' id='srch_dep_naCd' name='srch_dep_naCd' value='KR' />
				</p>
				<p>
					<span name="depNm" ar-att="departure" target-id="srch_dep_ct" id="srch_dep_ct_dis">인천/김포</span>
				</p>
			</button>
			<button type="button" class="layerOpener" data-url="/pop/pop_city_select2.do?availTy=OW"  data-ctn="full" data-role="none" style="cursor='hand';">
				<p class="st_text">
					<span name="arrCd" id="srch_arr_ct">도착</span>
					<input type="hidden" id="srch_arr_naCd" name="srch_arr_naCd" value="" />
				</p>
				<p>
					<span name="arrNm" id="srch_arr_ct_dis" target-id="srch_arr_ct" ar-att="arrive">도착지 선택</span>
				</p>
			</button>
		</div>
		<!-- 날짜 -->
		<ul class="tra_day tra_day1">
			<li><button type="button" class="layerOpener" data-url="/pop/pop_calendar.do?availTy=OW&type=AIR"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'><span name="depDt" id="dep_dt"><%=serverDay%></span></button></li>
		</ul>
		<!-- 기본목록버튼 -->
		<div class="seatbtn selectbox">
			<select id="cabinClas" name="cabinClas" data-role="none" class="centerSelect">
				<option value="Y">일반석</option>
				<option value="W">프리미엄 일반석</option>
				<option value="C">비즈니스석</option>
				<option value="F">일등석</option>
			</select>
		</div>
		<!-- 인원수 체크 -->
		<ul class="personnel" data-msg="성인, 소아, 유아의 합이 9명을 넘길 수 없습니다." id='OWmembers'>
			<li>
				<dl>
					<dt>
						<em>성인</em><span>(만12세이상)</span>
					</dt>
					<dd class="ps_c1">
						<button data-role="none">내림</button>
					</dd>
					<dd class="ps_cunt">
						<span id="adtCnt" name="adtCnt">1</span>
					</dd>
					<dd class="ps_c2">
						<button data-role="none">올림</button>
					</dd>
				</dl>
			</li>
			<li>
				<dl>
					<dt>
						<em>소아</em><span>(만2~12세미만)</span>
					</dt>
					<dd class="ps_c1">
						<button data-role="none">내림</button>
					</dd>
					<dd class="ps_cunt">
						<span id="chdCnt" name="chdCnt">0</span>
					</dd>
					<dd class="ps_c2">
						<button data-role="none">올림</button>
					</dd>
				</dl>
			</li>
			<li>
				<dl>
					<dt>
						<em>유아</em><span>(2세미만)</span>
					</dt>
					<dd class="ps_c1">
						<button data-role="none">내림</button>
					</dd>
					<dd class="ps_cunt">
						<span id="infCnt" name="infCnt">0</span>
					</dd>
					<dd class="ps_c2">
						<button data-role="none">올림</button>
					</dd>
				</dl>
			</li>
		</ul>
		<!-- 버튼 -->
		<div class="btn_one air_tbtn chkv_hid">
			<button class="purple2" data-role="none" onclick="fn_goSelPage()">항공권 검색하기</button>
		</div>
	</div>
	<!-- 다구간 도시, 날짜 1-->
	<div class="tabctn_com airbox airbox3" ft-att="MTGroup" ar-att="availgroup">
		<!-- 여정 1 -->
		<div class="many_travelbox">
			<!-- 간략안내 -->
			<div class="travel" mt-data="1" mt-att="availDiv">
				<p>여정 1</p>
			</div>
			<div class="stable_guide oenway">
				<button type="button" class="layerOpener" data-url="/pop/pop_city_select1.do?availTy=MT" data-width="300" data-height="400" data-ctn="full" data-role="none" style="cursor='hand';">
					<p class="st_text">
						<span name="depCd" id="srch_dep_ct">SEL</span>
						<input type='hidden' id='srch_dep_naCd' name='srch_dep_naCd' value='KR' />
					</p>
					<p>
						<span name="depNm" ar-att="departure" target-id="srch_dep_ct" id="srch_dep_ct_dis">인천/김포</span>
					</p>
				</button>

				<button type="button" class="layerOpener" data-url="/pop/pop_city_select2.do?availTy=MT&travelMtCnt=1&type=A" data-ctn="full" data-role="none" style="cursor='hand';">
					<p class="st_text">
						<span name="arrCd" id="srch_arr_ct">도착</span>
						<input type='hidden' name="arrCd" id="srch_arr_ct" value=''/>
						<input type='hidden' id='srch_arr_naCd' name='srch_arr_naCd' value='' />
					</p>
					<p>
						<span name="arrNm" id="srch_arr_ct_dis" target-id="srch_arr_ct" ar-att="arrive">도착지 선택</span>
						<input type='hidden' name="arrNm" id="srch_arr_ct_dis" target-id="srch_arr_ct" ar-att="arrive" value=''/>
					</p>
				</button>
			</div>
			<!-- 날짜 -->
			<ul class="tra_day tra_day1">
				<li><button type="button" class="layerOpener" data-url="/pop/pop_calendar.do?type=AIR&availTy=MT&travelMtCnt=1"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'><span name="depDt" id="dep_dt"><%=serverDay%></span></button></li>
			</ul>
		</div>
		
		<!-- 여정 2 -->
		<div class='many_travelbox'>
			<!-- 간략안내 -->
			<div class='travel' mt-data='2' mt-att='availDiv'>
				<p>여정 2</p>
			</div>
			<div class='stable_guide oenway'>
			
				<button type='button' class='layerOpener' data-url='/pop/pop_city_select2.do?availTy=MT&travelMtCnt=2&type=D'  data-ctn='full' data-role='none' style='cursor='hand';'>
					<p class='st_text'>
						<span name='depCd' id='srch_dep_ct2'>도착</span>
						<input type='hidden' name='depCd' id='srch_dep_ct2' value=''/>
						<input type='hidden' id='srch_dep_naCd2' name='srch_dep_naCd2' value='' />
					</p>
					<p>
						<span name='depNm' ar-att='departure' target-id='srch_dep_ct2' id='srch_dep_ct_dis2'>도착지 선택</span>
					</p>
				</button>

				<button type='button' class='layerOpener' data-url='/pop/pop_city_select2.do?availTy=MT&travelMtCnt=2&type=A' data-ctn='full' data-role='none' style='cursor='hand';'>
					<p class='st_text'>
						<span name='arrCd' id='srch_arr_ct2'>도착</span>
						<input type="hidden" id="srch_arr_naCd2" name="srch_arr_naCd2" value="" />
					</p>
					<p>
						<span name='arrNm' id='srch_arr_ct_dis2' target-id='srch_arr_ct2' ar-att='arrive'>도착지 선택</span>
					</p>
				</button>
			</div>			
			<!-- 날짜 -->
			<ul class='tra_day tra_day1'>
				<li><button type='button' class='layerOpener' data-url='/pop/pop_calendar.do?type=AIR&availTy=MT&travelMtCnt=2'  data-ctn='full' data-role='none' style='cursor='hand';'  data-ok='yes'><span name='depDt' id='dep_dt2'><%=serverDay%></span></button></li>
			</ul>
		</div>

		<!-- 여정 3 -->
		<div class='many_travelbox'>
			<!-- 간략안내 -->
			<div class='travel' mt-data='3' mt-att='availDiv'>
				<p>여정 3</p>
			</div>
			<div class='stable_guide oenway'>
			
				<button type='button' class='layerOpener' data-url='/pop/pop_city_select2.do?availTy=MT&travelMtCnt=3&type=D'  data-ctn='full' data-role='none' style='cursor='hand';'>
					<p class='st_text'>
						<span name='depCd' id='srch_dep_ct3'>도착</span>
						<input type='hidden' name='depCd' id='srch_dep_ct3' value=''/>
						<input type='hidden' id='srch_dep_naCd3' name='srch_dep_naCd3' value='' />
					</p>
					<p>
						<span name='depNm' ar-att='departure' target-id='srch_dep_ct3' id='srch_dep_ct_dis3'>도착지 선택</span>
					</p>
				</button>

				<button type='button' class='layerOpener' data-url='/pop/pop_city_select2.do?availTy=MT&travelMtCnt=3&type=A' data-ctn='full' data-role='none' style='cursor='hand';'>
					<p class='st_text'>
						<span name='arrCd' id='srch_arr_ct3'>도착</span>
						<input type="hidden" id="srch_arr_naCd3" name="srch_arr_naCd3" value="" />
					</p>
					<p>
						<span name='arrNm' id='srch_arr_ct_dis3' target-id='srch_arr_ct3' ar-att='arrive'>도착지 선택</span>
					</p>
				</button>
			</div>			
			<!-- 날짜 -->
			<ul class='tra_day tra_day1'>
				<li><button type='button' class='layerOpener' data-url='/pop/pop_calendar.do?type=AIR&availTy=MT&travelMtCnt=3'  data-ctn='full' data-role='none' style='cursor='hand';'  data-ok='yes'><span name='depDt' id='dep_dt3'><%=serverDay%></span></button></li>
			</ul>
		</div>

		<!-- 여정 4 ~ 5 -->
		<div id="div_othertravelplan" name="div_othertravelplan"></div>

		<!-- 버튼 -->
		<div class="btn_one air_tbtn" id="div_addtravelbtn" name="div_addtravelbtn">
			<button class="white2" data-role="none" onClick="fn_addTravelPlan()">여정추가</button>
		</div>

		<!-- 기본목록버튼 -->
		<div class="seatbtn selectbox">
			<select id="cabinClas" name="cabinClas" data-role="none" class="centerSelect">
				<option value="Y">일반석</option>
				<option value="W">프리미엄 일반석</option>
				<option value="C">비즈니스석</option>
				<option value="F">일등석</option>
			</select>
		</div>
		<!-- 인원수 체크 -->
		<ul class="personnel" data-msg="성인, 소아, 유아의 합이 9명을 넘길 수 없습니다." id='MTmembers'>
			<li>
				<dl>
					<dt>
						<em>성인</em><span>(만12세이상)</span>
					</dt>
					<dd class="ps_c1">
						<button data-role="none">내림</button>
					</dd>
					<dd class="ps_cunt">
						<span id="adtCnt" name="adtCnt">1</span>
					</dd>
					<dd class="ps_c2">
						<button data-role="none">올림</button>
					</dd>
				</dl>
			</li>
			<li>
				<dl>
					<dt>
						<em>소아</em><span>(만2~12세미만)</span>
					</dt>
					<dd class="ps_c1">
						<button data-role="none">내림</button>
					</dd>
					<dd class="ps_cunt">
						<span id="chdCnt" name="chdCnt">0</span>
					</dd>
					<dd class="ps_c2">
						<button data-role="none">올림</button>
					</dd>
				</dl>
			</li>
			<li>
				<dl>
					<dt>
						<em>유아</em><span>(2세미만)</span>
					</dt>
					<dd class="ps_c1">
						<button data-role="none">내림</button>
					</dd>
					<dd class="ps_cunt">
						<span id="infCnt" name="infCnt">0</span>
					</dd>
					<dd class="ps_c2">
						<button data-role="none">올림</button>
					</dd>
				</dl>
			</li>
		</ul>
		<!-- 버튼 -->
		<div class="btn_one air_tbtn chkv_hid">
			<button class="purple2" data-role="none" onclick="fn_goSelPage()">항공권 검색하기</button>
		</div>
	</div>
	<!-- 해외출발 -->
	<div class="tabctn_com airbox airbox4" ft-att="OOGroup" ar-att="availgroup">
		<!-- 간략안내 -->
		<div class="stable_guide sground">
			<!--
			<button type="button" class="layerOpener" data-url="/pop/pop_city_select1.do?availTy=OO" data-width="300" data-height="400" data-ctn="full" data-role="none" style="cursor='hand';">
				<p class="st_text">
					<span name="depCd" id="srch_dep_ct">SEL</span>
					<input type='hidden' id='srch_dep_naCd' name='srch_dep_naCd' value='KR' />
				</p>
				<p>
					<span name="depNm" ar-att="departure" target-id="srch_dep_ct" id="srch_dep_ct_dis">인천/김포</span>
				</p>
			</button>
			-->
			<button type="button" class="layerOpener" data-url="/pop/pop_city_select2.do?availTy=OO" data-ctn="full" data-role="none" style="cursor='hand';">
				<p class="st_text">
					<span name="depCd" id="srch_dep_ct">도착</span>
					<input type="hidden" id="srch_dep_naCd" name="srch_dep_naCd" value="" />
				</p>
				<p>
					<span name="depNm" id="srch_dep_ct_dis" target-id="srch_dep_ct" ar-att="departure">도착지 선택</span>
				</p>
			</button>
			
			<button type="button" class="layerOpener" data-url="/pop/pop_city_select2.do?availTy=OO&type=A" data-ctn="full" data-role="none" style="cursor='hand';">
				<p class="st_text">
					<span name="arrCd" id="srch_arr_ct">도착</span>
					<input type="hidden" id="srch_arr_naCd" name="srch_arr_naCd" value="" />
				</p>
				<p>
					<span name="arrNm" id="srch_arr_ct_dis" target-id="srch_arr_ct" ar-att="arrive">도착지 선택</span>
				</p>
			</button>
		</div>
		<!-- 날짜 -->
		<ul class="tra_day tra_day2">
			<li><button type="button" class="layerOpener" data-url="/pop/pop_calendar.do?type=AIR&availTy=OO"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'><span name="depDt" id="dep_dt"><%=serverDay%></span></button></li>
			<li><button type="button" class="layerOpener" data-url="/pop/pop_calendar.do?type=AIR&availTy=OO"  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'><span class="noSelect" name="arrDt" id="arr_dt">미지정</span><input type='hidden' name="arrDt" id="arr_dt" value=''/></button></li>
		</ul>
		<!-- 기본목록버튼 -->
		<div class="seatbtn selectbox">
			<select id="cabinClas" name="cabinClas" data-role="none" class="centerSelect">
				<option value="Y">일반석</option>
				<option value="W">프리미엄 일반석</option>
				<option value="C">비즈니스석</option>
				<option value="F">일등석</option>
			</select>
		</div>
		<!-- 인원수 체크 -->
		<ul class="personnel" data-msg="성인, 소아, 유아의 합이 9명을 넘길 수 없습니다." id='OOmembers'>
			<li>
				<dl>
					<dt>
						<em>성인</em><span>(만12세이상)</span>
					</dt>
					<dd class="ps_c1">
						<button data-role="none">내림</button>
					</dd>
					<dd class="ps_cunt">
						<span id="adtCnt" name="adtCnt">1</span>
					</dd>
					<dd class="ps_c2">
						<button data-role="none">올림</button>
					</dd>
				</dl>
			</li>
			<li>
				<dl>
					<dt>
						<em>소아</em><span>(만2~12세미만)</span>
					</dt>
					<dd class="ps_c1">
						<button data-role="none">내림</button>
					</dd>
					<dd class="ps_cunt">
						<span id="chdCnt" name="chdCnt">0</span>
					</dd>
					<dd class="ps_c2">
						<button data-role="none">올림</button>
					</dd>
				</dl>
			</li>
			<li>
				<dl>
					<dt>
						<em>유아</em><span>(2세미만)</span>
					</dt>
					<dd class="ps_c1">
						<button data-role="none">내림</button>
					</dd>
					<dd class="ps_cunt">
						<span id="infCnt" name="infCnt">0</span>
					</dd>
					<dd class="ps_c2">
						<button data-role="none">올림</button>
					</dd>
				</dl>
			</li>
		</ul>
		<!-- 버튼 -->
		<div class="btn_one air_tbtn chkv_hid">
			<button class="purple2" data-role="none" onclick="fn_goSelPage()">항공권 검색하기</button>
		</div>
	</div>
	<!-- 동일 적용 -->
	<div class="selectchk chkv_show">
		<p class="chkbox ah_show">
			<span><input id="chk_cusm1" type="checkbox" data-role="none" /></span>
			<label for="chk_cusm1">선택 지역 호텔 동일 적용</label>
		</p>
		<p class="chkbox hc_show">
			<span><input id="chk_cusm2" type="checkbox" data-role="none" /></span>
			<label for="chk_cusm2">선택 지역 렌터카 동일 적용</label>
		</p>
	</div>
</div>