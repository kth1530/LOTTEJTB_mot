<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ page import='java.util.*'%>
<%@ page import='java.text.*'%>
<%@ page import='net.sf.json.*'%>
<%
	// 파일명 : pop_city_select1.jsp
	// 설명 : 주요도시 선택 (출발)
	String baseCityList = "{naNm : '출발지', cityList : [{ctCd : 'SEL',ctNm : '인천/김포'},{ctCd : 'ICN',ctNm : '인천'},{ctCd : 'GMP',ctNm : '김포'},{ctCd : 'PUS',ctNm : '부산'},{ctCd : 'CJJ',ctNm : '청주'},{ctCd : 'MWX',ctNm : '무안(광주)'},{ctCd : 'KWJ',ctNm : '광주'},{ctCd : 'SHO',ctNm : '속초'},{ctCd : 'KUV',ctNm : '군산'},{ctCd : 'WJU',ctNm : '원주'},{ctCd : 'KAG',ctNm : '강릉'},{ctCd : 'CJU',ctNm : '제주'},{ctCd : 'TAE',ctNm : '대구'},{ctCd : 'RSU',ctNm : '여수'},{ctCd : 'HIN',ctNm : '진주'},{ctCd : 'MPK',ctNm : '목포'},{ctCd : 'USN',ctNm : '울산'},{ctCd : 'KPO',ctNm : '포항'}]}";
	
	
	JSONObject baseCityJSON = null;
	JSONArray baseCityListArray = null;

	try {
		baseCityJSON = JSONObject.fromObject((String) baseCityList);
		baseCityListArray = baseCityJSON.getJSONArray("cityList");

	} catch (Exception e) {

	}

%>

<script type='text/javascript'>
	var availTy = "${availTy}"; // 선택 항목  [RT : 왕복, OW : 편도, MT : 다구간, OO : 해외출발]
	var travelMtCnt = "${travelMtCnt}"; // 다구간 선택일 때만 
	var type = "${type}"; // D: 출발지 , A : 도착지
	var availGroup = $('div[ft-att="' + availTy + 'Group"]');
	var cityCd = "";

	if(availTy == 'MT' && travelMtCnt > 1) {
		var tag = "#srch_arr_ct" + travelMtCnt;
		cityCd = availGroup.find(tag).text();
	} else {
		cityCd = availGroup.find('#srch_dep_ct').text();
		
	}

	function fn_selectCity(cityCd, cityNm) {
		
		console.log(" >>>>>>>>>>>>>>>> availTy=" + availTy);
		console.log(" >>>>>>>>>>>>>>>> travelMtCnt=" + travelMtCnt);
		console.log(" >>>>>>>>>>>>>>>> type=" + type);

		$(".radiobox").removeClass('on');
		$(".ctCd").removeAttr("checked");
		$("#ctCd_"+ cityCd).parent().parent().addClass('on');
		$("#ctCd_"+ cityCd).prop("checked", true);

		setTimeout(function(){
			jQuery("html, body").css({"overflow":"auto"});
			jQuery(".layerPopup").hide();
			
			if(availTy == 'MT') {
				if(type == 'A') { // 도착 : A 도착지 선택 
					if(parseInt(travelMtCnt) > 1) {
						
						var tag1 = '#srch_arr_ct'+parseInt(travelMtCnt);
						var tag2 = '#srch_arr_ct_dis'+parseInt(travelMtCnt);
						// var tag3 = '#srch_arr_naCd'+parseInt(travelMtCnt);
						console.log(" >>>>>>>>>>>>>>>> tag1=" + tag1);
						console.log(" >>>>>>>>>>>>>>>> tag2=" + tag2);
						// console.log(" >>>>>>>>>>>>>>>> tag3=" + tag3);


						availGroup.find(tag1).html(cityCd);
						availGroup.find(tag2).html(cityNm);
						// availGroup.find(tag3).val(nationCd);

					} else { 
						availGroup.find('#srch_arr_ct').html(cityCd);
						availGroup.find('#srch_arr_ct_dis').html(cityNm);
						// availGroup.find('#srch_arr_naCd').val(nationCd);
					
					}
				} else { // 출발 : D 출발지 선택 
					if(parseInt(travelMtCnt) > 1) {
						var tag1 = '#srch_dep_ct'+travelMtCnt;
						var tag2 = '#srch_dep_ct_dis'+travelMtCnt;
						// var tag3 = '#srch_dep_naCd'+travelMtCnt;
						availGroup.find(tag1).html(cityCd);				
						availGroup.find(tag2).html(cityNm);
						// availGroup.find(tag3).val(nationCd);
					} else { 
						availGroup.find('#srch_dep_ct').html(cityCd);
						availGroup.find('#srch_dep_ct_dis').html(cityNm);
						// availGroup.find('#srch_dep_naCd').val(nationCd);
					}
				}
			} else {
				availGroup.find('#srch_dep_ct').html(cityCd);				
				availGroup.find('#srch_dep_ct_dis').html(cityNm);					
			}
			// closePopup();
		}, 10);	

		
	}

	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}

	function init() {
		
		var html = "";
		html = html + "<div class='layerPopup'>";
		html = html + "	<div class='layerPop'>";
		html = html + "		<div class='popCon'>";
		html = html + "			<div class='popHead'>";
		html = html + "				<div class='popTpart'>";
		html = html + "					<strong class='popTitle'>주요도시 선택</strong>";
		html = html + "					<button type='button' class='layerClose'>";
		html = html + "						<img src='/resources/images/btn/btn_exit.png' alt='레이어 닫기'>";
		html = html + "					</button>";
		html = html + "				</div>";
		html = html + "			</div>";
		html = html + "			<div class='cntain'>";
		html = html + "				<ul class='selectpop_radio'>";
		<%
			for (Iterator i = baseCityListArray.iterator(); i.hasNext();) {
				JSONObject cityJSON = (JSONObject) i.next();
				String ctCd = cityJSON.getString("ctCd");
				String ctNm = cityJSON.getString("ctNm");
		%>
			if(cityCd == '<%=ctCd%>') {
				html = html + "<li><a href='#' class='layerClose1' onClick=\"fn_selectCity('<%=ctCd%>', '<%=ctNm%>')\"><span class='radiobox on'><input type='radio' name='ctCd_<%=ctCd%>' id='ctCd_<%=ctCd%>' value='<%=ctCd%>' checked='checked'></span><label for='ctCd_<%=ctCd%>'><%=ctNm%></label></a></li>";
			} else {
				html = html + "<li><a href='#' class='layerClose1' onClick=\"fn_selectCity('<%=ctCd%>', '<%=ctNm%>')\"><span class='radiobox'><input type='radio' name='ctCd_<%=ctCd%>' id='ctCd_<%=ctCd%>' value='<%=ctCd%>'></span><label for='ctCd_<%=ctCd%>'><%=ctNm%></label></a></li>";
			}
		<%
		
			}
		%>

		html = html + "				</ul>";
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

		$("#popupStartCityCd").html(html);
	}

	init();
</script>
<!-- 도시 선택 레이어 영역 -->
<div id="popupStartCityCd"></div>