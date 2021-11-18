<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
	// 파일명 : pop_pay_select.jsp
	// 설명 : 주요도시 선택 (결과)

	String type = (String) request.getAttribute("type");
%>
<script type="text/javascript">

	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){
	
	
	var setTitle = '';
	var baseCityList = []; //도시리스트
	var _type="<%=type%>";

	setTitle = '주요도시 선택';
	
	baseCityList = [
					{ naNm: '일본', cityList: [{ ctCd: 'TYO', naCd: 'JP', ctNm: '도쿄' }, { ctCd: 'OSA', naCd: 'JP', ctNm: '오사카' }, { ctCd: 'FUK', naCd: 'JP', ctNm: '후쿠오카' }, { ctCd: 'NGO', naCd: 'JP', ctNm: '나고야' }]}
					, { naNm: '중국/홍콩', cityList: [{ ctCd: 'HKG', naCd: 'HK', ctNm: '홍콩' }, { ctCd: 'SHA', naCd: 'CN', ctNm: '상하이' }, { ctCd: 'BJS', naCd: 'CN', ctNm: '베이징' }, { ctCd: 'MAU', naCd: 'CN', ctNm: '마카오' }]}
					, { naNm: '아시아', cityList: [{ ctCd: 'SIN', naCd: 'SG', ctNm: '싱가폴' }, { ctCd: 'BKK', naCd: 'TH', ctNm: '방콕' }, { ctCd: 'TPE', naCd: 'TW', ctNm: '타이페이' }, { ctCd: 'MNL', naCd: 'PH', ctNm: '마닐라' }, { ctCd: 'KUL', naCd: 'MY', ctNm: '쿠알라룸푸르' }]}
					, { naNm: '미주', cityList: [{ ctCd: 'NYC', naCd: 'US', ctNm: '뉴욕' }, { ctCd: 'LAX', naCd: 'US', ctNm: 'L.A' }, { ctCd: 'SFO', naCd: 'US', ctNm: '샌프란시스코' }, { ctCd: 'LAS', naCd: 'US', ctNm: '라스베이거스' }, { ctCd: 'CHA', naCd: 'US', ctNm: '시카고' }]}
					, { naNm: '유럽', cityList: [{ ctCd: 'PAR', naCd: 'FR', ctNm: '파리' }, { ctCd: 'LON', naCd: 'GB', ctNm: '런던' }, { ctCd: 'ROM', naCd: 'IT', ctNm: '로마' }, { ctCd: 'FRA', naCd: 'DE', ctNm: '프랑크푸르트' }]}
					, { naNm: '휴양지', cityList: [{ ctCd: 'HNL', naCd: 'US', ctNm: '하와이' }, { ctCd: 'HKT', naCd: 'TH', ctNm: '푸껫' }, { ctCd: 'DPS', naCd: 'ID', ctNm: '발리' }, { ctCd: 'CEB', naCd: 'PH', ctNm: '세부' }, { ctCd: 'GUM', naCd: 'GU', ctNm: '괌' }]
	}];

	// 초기화
	var fn_init = function() {

		console.log("pop_hotel_city_select---fn_init~~~~~~~~~~~~~~~~");
		
		var html = "";
		html = html + "<div class='layerPopup'>";
		html = html + "	<div class='layerPop bgwhite'>";
		html = html + "		<div class='popCon'>";
		html = html + "			<div class='popHead'>";
		html = html + "				<div class='popTpart'>";
		html = html + "					<strong class='popTitle'>" + setTitle + "</strong>";
		html = html + "					<button type='button' class='layerClose'>";
		html = html
				+ "						<img src='/resources/images/btn/btn_exit.png' alt='레이어 닫기'>";
		html = html + "					</button>";
		html = html + "				</div>";
		html = html + "			</div>";
		html = html + "			<div class='cntain'>";
		// <!-- 검색 폼 --> //	
		html = html + "				<div class='fs_search'>";
		html = html + "					<div class='csbox'>";
		html = html + "							<fieldset>";
		html = html + "								<legend>검색폼</legend>";
		html = html
				+ "								<input type='text' data-role='none' placeholder='도시, 호텔, 인근도시, 공항 등' id='cityPopInput' title='검색어를 입력하세요.' onkeyup='fn_htl_search()'/>";
		html = html
				+ "								<button type='button' data-role='none' onclick='fn_htl_search()'>검색</button>";
		html = html + "							</fieldset>";
		html = html + "					</div>";
		// <!-- 검색 결과 --> //
		html = html + "					<div class='search_nowkey' ft-att='resultSearch' id='resultSearch' name='resultSearch'>";
		html = html + "					</div>";
		html = html + "				</div>";
		// <!-- 기본 도시  --> //
		html = html + "				<table class='pop_table2 mt10'>";
		html = html + "					<colgroup>";
		html = html + "						<col style='width: 12%' />";
		html = html + "						<col span='4' style='width: 22%' />";
		html = html + "					</colgroup>";
		html = html + "					<tbody ft-att='city_list_div'>";

		// var city_div = html.find('tbody[ft-att="city_list_div"]');	

		for (var c_idx = 0; c_idx < baseCityList.length; c_idx++) {
			var cityGroup = baseCityList[c_idx];
			var row_cnt = parseInt(cityGroup.cityList.length / 3);
			if (cityGroup.cityList.length % 3 > 0) {
				row_cnt++;
			}
			html = html + "					<tr>";
			html = html + "						<th scope='row' rowspan='" + row_cnt + "'>"
					+ cityGroup.naNm + "</th>";

			//호텔 도시 검색
			for (var l_idx = 0; l_idx < cityGroup.cityList.length; l_idx++) {
				var city_list = cityGroup.cityList[l_idx];
				var funcNm = "\selectCityList('" + cityGroup.naNm + "','" + city_list.naCd + "','" + city_list.ctCd + "','" + city_list.ctNm + "'\)";
				html = html + '				<td city-data="'+ city_list.ctCd + '" country-data="' + city_list.naCd + '" onClick="' + funcNm + '">' + city_list.ctNm + '</td>';

				if (cityGroup.cityList.length == (l_idx + 1)) {
					var vNo = cityGroup.cityList.length % 3;
					if (vNo > 0) {
						for (var v_idx = vNo; v_idx < 3; v_idx++) {
							html = html + "	<td></td>";
						}
					}
				}
				if ((l_idx + 1) > 2 && ((l_idx + 1) % 3 == 0)) {
					html = html + "</tr><tr>";
				}
			}

			html = html + "</tr>";
		}

		html = html + "					</tbody>";
		html = html + "				</table>";
		// <!-- 기본 도시  --> //
		html = html + "			</div>";
		html = html + "		</div>";
		html = html + "		<div class='popFoot'>";
		html = html + "			<div class='layerBtns'>";
		html = html
				+ "				<button type='button' class='layerClose1'>확인</button>";
		html = html + "			</div>";
		html = html + "		</div>";
		html = html + "	</div>";
		html = html + "</div>";

		$("#popupDepartCityCd").html(html);
		
		setTimeout(function(){
			$("#cityPopInput").focus();
		}, 50);

	};


	// 도시검색 팝업 선택 
	function selectCityList(naNm, naCd, cityCd, cityNm){
		var availTy = "${availTy}"; // 선택 항목  [RT : 왕복, OW : 편도, MT : 다구간, OO : 해외출발]
		var travelMtCnt = "${travelMtCnt}"; // 다구간 선택일 때만 [RT : 왕복, OW : 편도, MT : 다구간, OO : 해외출발] 몇번째 여정인지 
		var type = "${type}"; // 출발 : D, 도착 : A
		var availGroup = $('table[ft-att="' + availTy + 'Group"]');
		console.log("availTy : " + availTy);
		console.log("type : " + type);
		console.log("travelMtCnt : " + travelMtCnt);
		// console.log("availGroup=" + availGroup);
		if(availTy == 'address' || availTy == 'address2') { // 목적지/도착지 정보 전송 
			if(travelMtCnt != '') {
				
				var tag1 = '#ctCd'+travelMtCnt;
				var tag2 = '#ctCdNm'+travelMtCnt;
				var tag3 = '#ntCd'+travelMtCnt;
				var tag4 = '#ntNm'+travelMtCnt;
				availGroup.find(tag1).val(cityCd);
				availGroup.find(tag2).html(cityNm);	
				availGroup.find(tag3).val(naCd);
				availGroup.find(tag4).html(naNm);
				
			} else { 
				availGroup.find('#ctCd').val(cityCd);
				availGroup.find('#ctCdNm').html(cityNm);	
				availGroup.find('#ntCd').val(naCd);	
				availGroup.find('#ntNm').html(ntNm);				
			}
		} else { // 현지 연락처 정보 일 경우에만 
			if(travelMtCnt != '1') {
				var tag1 = '#ctCd'+travelMtCnt;
				var tag2 = '#ctCdNm'+travelMtCnt;
				availGroup.find(tag1).val(cityCd);
				availGroup.find(tag2).html(cityNm);	
			} else { 
				availGroup.find('#ctCd').val(cityCd);
				availGroup.find('#ctCdNm').html(cityNm);	
			}
			
		}
		closePopup();

	}

	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}


	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();

		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});
</script>



<!-- 도시 선택 레이어 영역 -->
<div id="popupDepartCityCd"></div>