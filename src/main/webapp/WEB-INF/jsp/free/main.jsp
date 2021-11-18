<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>

<head>
<script src="/resources/common/js/fit/air_search.js"></script>
<script src="/resources/common/js/fit/hotel_search.js"></script>
<script src="/resources/common/js/fit/rentcar_search.js"></script>
<script src="/resources/common/js/fit/common.js"></script>

<script type="text/javascript">
	var tabType = "${tabType}";
	var remainYN = "${remainYN}";
	var domesticYn = "${domesticYn}";
	
	//var htlSameChk = false;
	//var rntSameChk = false;

	// 초기화
	var fn_init = function() {
			
	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};

	//검색하기
	function fn_goSelPage() {
		var frm_action = '';
		
		var useAir =  $("input:checkbox[id='aircheck']").is(":checked");
		var useHotel = $("input:checkbox[id='hotelcheck']").is(":checked");
		var useRentcar = $("input:checkbox[id='carcheck']").is(":checked");
		
		console.log("useAir >>> " + useAir);
		console.log("useHotel >>> " + useHotel);
		console.log("useRentcar >>> " + useRentcar);
		
		useAir ? $('#selAir').val("Y") : $('#selAir').val("N");
		useHotel ? $('#selHotel').val("Y") : $('#selHotel').val("N");
		useRentcar ? $('#selRentcar').val("Y") : $('#selRentcar').val("N");
						
		/** validation check */
		if(useAir) {
			if(fn_set_air_search_value()){	//validation 유효성 체크
				if(useHotel) {
					fn_set_hotel_search_value();					
				}
				if(useRentcar) {
					fn_set_rentcar_search_value();
				}
				
				frm_action = '/free/search_result_air.do';
			} else {
				return;
			}
		}
		
		if(useHotel) {
			if(fn_set_hotel_search_value()){	//validation 유효성 체크
				if(useRentcar) {
					fn_set_rentcar_search_value();
				}
				if(frm_action == '') {
					frm_action = '/free/search_result_hotel.do';	
				}	
			} else {
				return;
			} 
		}

		if(useRentcar) {
			if(fn_set_rentcar_search_value()){
				if(frm_action == '') {
					frm_action = '/free/search_result_rentcar_office.do';	
				}
			}else{
				return;
			}
		}
		
		var selAir = 'N';
		var selHotel = 'N';
		var selRentcar = 'N';

		if(frm_action == '') {
			alert('검색할 항목을 선택해 주세요.');
			return;
		} else {
			/**
			var f_frm = $('#f_frm'); 
			
			f_frm.children('input[name="selAir"]').val(useAir?'Y':'N');
			f_frm.children('input[name="selHotel"]').val(useHotel?'Y':'N');
			f_frm.children('input[name="selRentcar"]').val(useRentcar?'Y':'N');
			console.log("frm_action >>> " + frm_action);
			
			f_frm.attr('action', frm_action).submit();
			**/

			selAir = useAir?'Y':'N';
			selHotel = useHotel?'Y':'N';
			selRentcar = useRentcar?'Y':'N';
			
			var f_frm = $('#f_frm'); 
			f_frm.children('input[name="selAir"]').val(useAir?'Y':'N');
			f_frm.children('input[name="selHotel"]').val(useHotel?'Y':'N');
			f_frm.children('input[name="selRentcar"]').val(useRentcar?'Y':'N');
						
			if(useAir && !useHotel && !useRentcar){
				var topas_url = "";
				var topas_param = "";
				
				var airType = $(".free_airtab").find('.active button').attr('value');
				var tabDiv = $("div[ft-att="+ airType +"Group]");
				if(airType == 'MT'){
					
					topas_url = "https://m.air.lottejtb.com/air/b2c/AIR/MBL/AIRMBLSCH0100100010.k1";
					
					var depCt_param = "";
					var arrCt_param = "";
					var depDt_param = "";
					var opencase_param = "";
					var other_param = "";
					
					topas_param 	+= "initform="+ airType;
					topas_param 	+= "&domintgubun=I";
					depCt_param 	+= "&depctycd="+ tabDiv.find("#srch_dep_ct").text();
					arrCt_param 	+= "&arrctycd="+ tabDiv.find("span#srch_arr_ct").text();
					depDt_param 	+= "&depdt="+ tabDiv.find("#dep_dt").text().replace(/\./g, '-');
					opencase_param 	+= "&opencase=N";
					
					if(tabDiv.find("#srch_dep_ct2").text() != "도착" && tabDiv.find("#srch_dep_ct2").text() != ""){
						depCt_param 	+= "&depctycd="+ tabDiv.find("#srch_dep_ct2").text();
						arrCt_param 	+= "&arrctycd="+ tabDiv.find("#srch_arr_ct2").text();
						depDt_param 	+= "&depdt="+ tabDiv.find("#dep_dt2").text().replace(/\./g, '-');
						opencase_param 	+= "&opencase=N";
					}else{
						depCt_param 	+= "&depctycd=";
						arrCt_param 	+= "&arrctycd=";
						depDt_param 	+= "&depdt=";
						opencase_param 	+= "&opencase=Y";
					}
					if(tabDiv.find("#srch_dep_ct3").text() != "도착" && tabDiv.find("#srch_dep_ct3").text() != ""){
						depCt_param 	+= "&depctycd="+ tabDiv.find("#srch_dep_ct3").text();
						arrCt_param 	+= "&arrctycd="+ tabDiv.find("#srch_arr_ct3").text();
						depDt_param 	+= "&depdt="+ tabDiv.find("#dep_dt3").text().replace(/\./g, '-');
						opencase_param 	+= "&opencase=N";
					}else{
						depCt_param 	+= "&depctycd=";
						arrCt_param 	+= "&arrctycd=";
						depDt_param 	+= "&depdt=";
						opencase_param 	+= "&opencase=Y";
					}
					if(tabDiv.find("#srch_dep_ct4").text() != "도착" && tabDiv.find("#srch_dep_ct4").text() != ""){
						depCt_param 	+= "&depctycd="+ tabDiv.find("#srch_dep_ct4").text();
						arrCt_param 	+= "&arrctycd="+ tabDiv.find("#srch_arr_ct4").text();
						depDt_param		+= "&depdt="+ tabDiv.find("#dep_dt4").text().replace(/\./g, '-');
						opencase_param 	+= "&opencase=N";
					}else{
						depCt_param 	+= "&depctycd=";
						arrCt_param 	+= "&arrctycd=";
						depDt_param 	+= "&depdt=";
						opencase_param 	+= "&opencase=Y";
					}
					
					other_param += "&openday=";
					other_param += "&openday=";
					other_param += "&openday=";
					other_param += "&depdomintgbn=D";
					other_param += "&tasktype=B2C";
					other_param += "&adtcount="+ tabDiv.find("#adtCnt").text();
					other_param += "&chdcount="+ tabDiv.find("#chdCnt").text();
					other_param += "&infcount="+ tabDiv.find("#infCnt").text();
					other_param += "&cabinclass="+ tabDiv.find("#cabinClas :selected").val();
					other_param += "&preferaircd=";
					other_param += "&secrchType=FARE";
					other_param += "&maxprice=";
					other_param += "&availcount=250";
					other_param += "&KSESID=air:b2c:SELK138AX:SELK138AX:00:00";
					
					topas_param = topas_param + depCt_param + arrCt_param + depDt_param + opencase_param + other_param;
				}else if(airType == 'OW'){
					if(tabDiv.find("#srch_dep_naCd").val() == "KR" && tabDiv.find("#srch_arr_naCd").val() == "KR"){
						topas_url = "https://m.air.lottejtb.com/air/b2c/AIR/MBL/AIRMBLSCH0100100090.k1";
						topas_param += "initform="+ airType;
						topas_param += "&domintgubun=D";
						topas_param += "&depctycd="+ tabDiv.find("#srch_dep_ct").text();
						topas_param += "&depctycd=";
						topas_param += "&arrctycd="+ tabDiv.find("#srch_arr_ct").text();
						topas_param += "&arrctycd=";
						topas_param += "&depctynm="+ tabDiv.find("#srch_dep_ct_dis").text();
						topas_param += "&depctynm=";
						topas_param += "&arrctynm="+ tabDiv.find("#srch_arr_ct_dis").text();
						topas_param += "&arrctynm=";
						topas_param += "&depdt="+ tabDiv.find("#dep_dt").text().replace(/\./g, '-');
						topas_param += "&depdt=";
						topas_param += "&opencase=";
						topas_param += "&openday=";
						topas_param += "&tasktype=B2C";
						topas_param += "&adtcount="+ tabDiv.find("#adtCnt").text();
						topas_param += "&chdcount="+ tabDiv.find("#chdCnt").text();
						topas_param += "&infcount="+ tabDiv.find("#infCnt").text();
						topas_param += "&cabinclass="+ tabDiv.find("#cabinClas :selected").val();
						topas_param += "&preferaircd=";
						topas_param += "&maxprice=";
						topas_param += "&availcount=250";
						topas_param += "&deptman=";
						topas_param += "&deptmpm=";
						topas_param += "&nonstop=";
						topas_param += "&KSESID=air:b2c:SELK138AX:SELK138AX:00:00";
					}else{
						topas_url = "https://m.air.lottejtb.com/air/b2c/AIR/MBL/AIRMBLSCH0100100010.k1";
						topas_param += "initform="+ airType;
						topas_param += "&domintgubun=I";
						topas_param += "&depctycd="+ tabDiv.find("#srch_dep_ct").text();
						topas_param += "&depctycd=";
						topas_param += "&depctycd=";
						topas_param += "&depctycd=";
						topas_param += "&arrctycd="+ tabDiv.find("#srch_arr_ct").text();
						topas_param += "&arrctycd=";
						topas_param += "&arrctycd=";
						topas_param += "&arrctycd=";
						topas_param += "&depdt="+ tabDiv.find("#dep_dt").text().replace(/\./g, '-');
						topas_param += "&depdt=";
						topas_param += "&depdt=";
						topas_param += "&depdt=";
						topas_param += "&opencase=";
						topas_param += "&opencase=";
						topas_param += "&opencase=";
						topas_param += "&openday=";
						topas_param += "&openday=";
						topas_param += "&openday=";
						topas_param += "&depdomintgbn=D";
						topas_param += "&tasktype=B2C";
						topas_param += "&adtcount="+ tabDiv.find("#adtCnt").text();
						topas_param += "&chdcount="+ tabDiv.find("#chdCnt").text();
						topas_param += "&infcount="+ tabDiv.find("#infCnt").text();
						topas_param += "&cabinclass="+ tabDiv.find("#cabinClas :selected").val();
						topas_param += "&preferaircd=";
						topas_param += "&secrchType=";
						topas_param += "&maxprice=";
						topas_param += "&availcount=250";
						topas_param += "&KSESID=air:b2c:SELK138AX:SELK138AX:00:00";
					}
				}else{
					if(tabDiv.find("#srch_dep_naCd").val() == "KR" && tabDiv.find("#srch_arr_naCd").val() == "KR"){
						if(airType == "OO"){
							airType = "RT";
						}
						topas_url = "https://m.air.lottejtb.com/air/b2c/AIR/MBL/AIRMBLSCH0100100090.k1";
						topas_param += "initform="+ airType;
						topas_param += "&domintgubun=D";
						topas_param += "&depctycd="+ tabDiv.find("#srch_dep_ct").text();
						topas_param += "&depctycd="+ tabDiv.find("#srch_arr_ct").text();
						topas_param += "&arrctycd="+ tabDiv.find("#srch_arr_ct").text();
						topas_param += "&arrctycd="+ tabDiv.find("#srch_dep_ct").text();
						topas_param += "&depctynm="+ tabDiv.find("#srch_dep_ct_dis").text();
						topas_param += "&depctynm="+ tabDiv.find("#srch_arr_ct_dis").text();
						topas_param += "&arrctynm="+ tabDiv.find("#srch_arr_ct_dis").text();
						topas_param += "&arrctynm="+ tabDiv.find("#srch_dep_ct_dis").text();
						topas_param += "&depdt="+ tabDiv.find("span#dep_dt").text().replace(/\./g, '-');
						topas_param += "&depdt="+ tabDiv.find("span#arr_dt").text().replace(/\./g, '-');
						topas_param += "&opencase=N";
						topas_param += "&openday=";
						topas_param += "&tasktype=B2C";
						topas_param += "&adtcount="+ tabDiv.find("#adtCnt").text();
						topas_param += "&chdcount="+ tabDiv.find("#chdCnt").text();
						topas_param += "&infcount="+ tabDiv.find("#infCnt").text();
						topas_param += "&cabinclass="+ tabDiv.find("#cabinClas :selected").val();
						topas_param += "&preferaircd=";
						topas_param += "&maxprice=";
						topas_param += "&availcount=250";
						topas_param += "&deptman=";
						topas_param += "&deptmpm=";
						topas_param += "&nonstop=";
						topas_param += "&KSESID=air:b2c:SELK138AX:SELK138AX:00:00";
					}else{
						if(airType == "OO"){
							airType = "RT";
						}
						topas_url = "https://m.air.lottejtb.com/air/b2c/AIR/MBL/AIRMBLSCH0100100010.k1";
						topas_param += "initform="+ airType;
						topas_param += "&domintgubun=I";
						topas_param += "&depctycd="+ tabDiv.find("#srch_dep_ct").text();
						topas_param += "&depctycd="+ tabDiv.find("#srch_arr_ct").text();
						topas_param += "&depctycd=";
						topas_param += "&depctycd=";
						topas_param += "&arrctycd="+ tabDiv.find("#srch_arr_ct").text();
						topas_param += "&arrctycd="+ tabDiv.find("#srch_dep_ct").text();
						topas_param += "&arrctycd=";
						topas_param += "&arrctycd=";
						topas_param += "&depdt="+ tabDiv.find("span#dep_dt").text().replace(/\./g, '-');
						topas_param += "&depdt="+ tabDiv.find("span#arr_dt").text().replace(/\./g, '-');
						topas_param += "&depdt=";
						topas_param += "&depdt=";
						topas_param += "&opencase=N";
						topas_param += "&opencase=";
						topas_param += "&opencase=";
						topas_param += "&openday=";
						topas_param += "&openday=";
						topas_param += "&openday=";
						if(tabDiv.find("#srch_dep_naCd").val() == "KR"){
							topas_param += "&depdomintgbn=D";
						}else{
							topas_param += "&depdomintgbn=I";	
						}
						topas_param += "&tasktype=B2C";
						topas_param += "&adtcount="+ tabDiv.find("#adtCnt").text();
						topas_param += "&chdcount="+ tabDiv.find("#chdCnt").text();
						topas_param += "&infcount="+ tabDiv.find("#infCnt").text();
						topas_param += "&cabinclass="+ tabDiv.find("#cabinClas :selected").val();
						topas_param += "&preferaircd=";
						topas_param += "&secrchType=FARE";
						topas_param += "&maxprice=";
						topas_param += "&availcount=250";
						topas_param += "&KSESID=air:b2c:SELK138AX:SELK138AX:00:00";
					}
				}
				
				//document.location.href = topas_url +"?"+ topas_param;
				moveLink(topas_url +"?"+ topas_param, '_system');
			}else{
				document.location.href = frm_action + '?selAir='+selAir+"&selHotel="+selHotel + "&selRentcar="+selRentcar;	
			}
		}
	}
	
	var fn_totalSearch = function(){
		var useAir =  $("input:checkbox[id='aircheck']").is(":checked");
		var useHotel = $("input:checkbox[id='hotelcheck']").is(":checked");
		var useRentcar = $("input:checkbox[id='carcheck']").is(":checked");
		
		var selAir = useAir?'Y':'N';
		var selHotel = useHotel?'Y':'N';
		var selRentcar = useRentcar?'Y':'N';
		
		useAir ? $('#selAir').val("Y") : $('#selAir').val("N");
		useHotel ? $('#selHotel').val("Y") : $('#selHotel').val("N");
		useRentcar ? $('#selRentcar').val("Y") : $('#selRentcar').val("N");
		
		var frm_action = "";
		
		if(useAir) {
			if(fn_set_air_search_value()){	//validation 유효성 체크
				frm_action = '/free/search_result_air.do';
			} else {
				return;
			}
		}
		
		if(useHotel) {
			if(fn_set_hotel_search_value()){	//validation 유효성 체크
				if(frm_action == '') {
					frm_action = '/free/search_result_hotel.do';	
				}	
			} else {
				return;
			} 
		}

		if(useRentcar) {
			if(fn_set_rentcar_search_value()){
				if(frm_action == '') {
					frm_action = '/free/search_result_rentcar_office.do';	
				}
			}else{
				return;
			}
		}
		
		document.location.href = frm_action + '?selAir='+selAir+"&selHotel="+selHotel + "&selRentcar="+selRentcar;
	}
	
	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();
		
		htlSameChk = false;
		rntSameChk = false;
		
		if(remainYN != "Y"){
			try{
				rsvAirBodyDtoT.clearT();
				rsvAirSegmentGroupT.clearT();
				rsvAirPaxGroupT.clearT();
				rsvAirFareDataBeanT.clearT();
				
				rsvMstUserInfo.createT();
			}catch(e){
				
			}
			
			sessionStorage.clear();
		}
		

		//국내상품인 경우는 조합불가 멘트 노티
		if(domesticYn == 'Y') {
			$("#aircheck").click("on", function(){
				setAlert("국내호텔은 항공조합이 불가합니다.");
				$("#aircheck").prop("checked", false);
				return;
			});
			$("#carcheck").click("on", function(){
				setAlert("국내호텔은 렌터카조합이 불가합니다.");
				$("#carcheck").prop("checked", false);
				return;
			});
			
		}
		

		var historyYn = false;
		$("#air_search_div").hide();
		$("#hotel_search_div").hide();
		$("#car_search_div").hide();
		
		
		if($("#aircheck").is(":checked")){
			$("#air_search_div").show();
			historyYn = true;
		}
		
		if($("#hotelcheck").is(":checked")){
			$("#hotel_search_div").show();
			historyYn = true;
		}
		
		if($("#carcheck").is(":checked")){
			$("#car_search_div").show();
			historyYn = true;
		}
		
		if(!historyYn){
			if(tabType == "hotel"){
				//$("#aircheck").click();
				//$("#hotelcheck").click();
				
				$(".free_topchk").find('li').removeClass('chked');
				$(".free_topchk").find('li input').prop('checked', false);
				$("#hotelcheck").parent().addClass('chked');
				$("#hotelcheck").prop('checked', true);
				
				$("#air_search_div").hide();
				$("#hotel_search_div").show();
				$("#car_search_div").hide();
			}else if(tabType == "rent"){
				//$("#aircheck").click();
				//$("#carcheck").click();
				
				$(".free_topchk").find('li').removeClass('chked');
				$(".free_topchk").find('li input').prop('checked', false);
				$("#carcheck").parent().addClass('chked');
				$("#carcheck").prop('checked', true);
				
				$("#air_search_div").hide();
				$("#hotel_search_div").hide();
				$("#car_search_div").show();
			}else{
				$(".free_topchk").find('li').removeClass('chked');
				$(".free_topchk").find('li input').prop('checked', false);
				$("#aircheck").parent().addClass('chked');
				$("#aircheck").prop('checked', true);
				
				$("#air_search_div").show();
				$("#hotel_search_div").hide();
				$("#car_search_div").hide();
				
				$("#hotelcheck").click();
			}
			
		}
		
		sessionStorage.domesticYn = "${domesticYn}";
		
		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
		
		
	});
	
	//선택지역 호텔 동일적용
	var fn_htlEqualsChk = function() {
		var availGroup = '';
		var htlGroup = $('div[ft-att="HTGroup"]');
		var airCheckTap = $(".free_airtab").find('.active button').attr('value');
		
		if(airCheckTap == 'RT')	{
			availGroup = $('div[ft-att="RTGroup"]');  //왑복
		}else if(airCheckTap == 'OW') {
			availGroup = $('div[ft-att="OWGroup"]'); //편도
		}else if(airCheckTap == 'MT') {
			availGroup = $('div[ft-att="MTGroup"]'); //다구간
		}else if(airCheckTap == 'OO') {
			availGroup = $('div[ft-att="OOGroup"]'); //해외출발
		}
		
		//선택 지역 호텔 동일 적용
		if($('#chk_cusm1').is(':checked') == true) {
			 if(nullToBlank(availGroup.find("#srch_arr_naCd").val()) == ""){
				$('#chk_cusm1').prop('checked', false);
				setAlert("도착지를 선택해 주세요.");
				return false;
			}
			
			if(airCheckTap == 'RT'){
				if(availGroup.find("#arr_dt").text() == "미지정"){
					$('#chk_cusm1').prop('checked', false);
					setAlert("도착일자를 선택해 주세요.");
					return false;
				}
			}
			
			//if(availGroup.find('#srch_arr_ct_dis').text() =='도착지 선택') availGroup.find('#srch_arr_ct_dis').text('');
			
			htlGroup.find('#srch_arr_ct_dis').val(availGroup.find('#srch_arr_ct_dis').text());
			
			if(nullToBlank(availGroup.find('#srch_arr_htlCt').val()) != ""){
				htlGroup.find('#searchCity').val(availGroup.find('#srch_arr_htlCt').val());
			}else{
				htlGroup.find('#searchCity').val(availGroup.find('#srch_arr_ct').text());
			}

			htlGroup.find('#searchCityNmEn').val(availGroup.find('#searchCityNmEn').val());
			htlGroup.find('#searchCountry').val(availGroup.find('#srch_arr_naCd').val());
			//체크
			htlGroup.find('#dep_dt').text(availGroup.find('#dep_dt').text());
			htlGroup.find('#dep_dt').removeClass("noSelect");
			if(airCheckTap == 'RT' || airCheckTap == 'OO') {
				var equalDepDtArr = availGroup.find('#dep_dt').text().split(".");
				var equalArrDtArr = availGroup.find('#arr_dt').text().split(".");
				
				var equalDepDate = new Date(equalDepDtArr[0], parseInt(equalDepDtArr[1]) - 1, equalDepDtArr[2]);
				var equalArrDate = new Date(equalArrDtArr[0], parseInt(equalArrDtArr[1]) - 1, equalArrDtArr[2]);
				
				var timeDiff = Math.abs(equalArrDate.getTime() - equalDepDate.getTime());
				var dayDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));
				
				htlGroup.find('#arr_dt').text(availGroup.find('#arr_dt').text());
				htlGroup.find('#arr_dt').removeClass("noSelect");
				htlGroup.find('#srch_night_days').text(dayDiff + '박');
			}
		} else {
			//호텔인경우
			htlGroup.find('#srch_arr_ct_dis').val('');
			htlGroup.find('#searchCity').val('');
			htlGroup.find('#searchCountry').val('');
			htlGroup.find('#dep_dt').text('미지정');
			htlGroup.find('#dep_dt').addClass('noSelect');
			htlGroup.find('#arr_dt').text('미지정');
			htlGroup.find('#arr_dt').addClass('noSelect');
			htlGroup.find('#srch_night_days').text('선택');
		}
	}
	
	//선택 지역 렌터카 동일적용
	var fn_rcEqualsChk = function() {
		var rcGroup = $('div[ft-att="RCGroup"]');
		var airCheckTap = $(".free_airtab").find('.active button').attr('value');
		
		if(airCheckTap == 'RT')	availGroup = $('div[ft-att="RTGroup"]');  //왕복
		else if(airCheckTap == 'OW') availGroup = $('div[ft-att="OWGroup"]'); //편도
		
		if($('#chk_cusm2').is(':checked') == true) {
			if(nullToBlank(availGroup.find("#srch_arr_naCd").val()) == ""){
				$('#chk_cusm2').prop('checked', false);
				setAlert("도착지를 선택해 주세요.");
				return false;
			}
			
			if(airCheckTap == 'RT'){
				if(availGroup.find("#arr_dt").text() == "미지정"){
					$('#chk_cusm2').prop('checked', false);
					setAlert("도착일자를 선택해 주세요.");
					return false;
				}
			}
			
			//if(availGroup.find('#srch_arr_ct_dis').text() =='도착지 선택') availGroup.find('#srch_arr_ct_dis').text('');
			
			rcGroup.find('#dep_place').val(availGroup.find('#srch_arr_ct_dis').text());
			
			if(nullToBlank(availGroup.find('#srch_arr_rntCt').text()) != ""){
				rcGroup.find('#take_place_cd').val(availGroup.find('#srch_arr_rntCt').text());	
				rcGroup.find('#take_place_oagCd').val('');
			}else{
				rcGroup.find('#take_place_cd').val('');
				rcGroup.find('#take_place_oagCd').val(availGroup.find('#srch_arr_ct').text());
			}
			
			rcGroup.find('#take_place_countryCd').val(availGroup.find('#srch_arr_naCd').val());
			
			var equalDepDtArr = availGroup.find('#dep_dt').text().split(".");
			var equalDepDt = equalDepDtArr[0] + equalDepDtArr[1] + equalDepDtArr[2];
			rcGroup.find('#dep_dt').text(availGroup.find('#dep_dt').text());
			rcGroup.find('#dep_dt').removeClass('noSelect');
			rcGroup.find('#take_date').val(equalDepDt);
			
			if(airCheckTap == 'RT' || airCheckTap == 'OO'){
				var equalArrDtArr = availGroup.find('#arr_dt').text().split(".");
				var equalArrDt = equalArrDtArr[0] + equalArrDtArr[1] + equalArrDtArr[2];
				rcGroup.find('#arr_dt').text(availGroup.find('#arr_dt').text());
				rcGroup.find('#return_date').val(equalArrDt);
				rcGroup.find('#arr_dt').removeClass('noSelect');
			}
			
			if($('#same_place').is(':checked') == true) { //인수장소와 동일
				rcGroup.find('#arr_place').val(availGroup.find('#srch_arr_ct_dis').text());

				if(nullToBlank(availGroup.find('#srch_arr_rntCt').text()) != ""){
					rcGroup.find('#return_place_cd').val(availGroup.find('#srch_arr_rntCt').text());	
					rcGroup.find('#return_place_oagCd').val('');
				}else{
					rcGroup.find('#return_place_cd').val('');
					rcGroup.find('#return_place_oagCd').val(availGroup.find('#srch_arr_ct').text());
				}

				rcGroup.find('#return_place_countryCd').val(availGroup.find('#srch_arr_naCd').val());
			} else {
				rcGroup.find('#arr_place').val('');
				rcGroup.find('#return_place_oagCd').val('');
				rcGroup.find('#return_place_countryCd').val('');
			}
		} else {
			rcGroup.find('#dep_place').val('');
			rcGroup.find('#take_place_oagCd').val('');
			rcGroup.find('#take_place_countryCd').val('');
			rcGroup.find('#arr_place').val('');
			rcGroup.find('#return_place_oagCd').val('');
			rcGroup.find('#dep_dt').text('미지정');
			rcGroup.find('#dep_dt').addClass('noSelect');
			rcGroup.find('#arr_dt').text('미지정');
			rcGroup.find('#arr_dt').addClass('noSelect');
			rcGroup.find('#return_date').val('');
		}
	}
	
	var fn_rcEqualsChkFromHtl = function() {
		var rcGroup = $('div[ft-att="RCGroup"]');
		var availGroup = $('div[ft-att="HTGroup"]');
		
		if($('#chk_cusm6').is(':checked') == true) {
			if(nullToBlank(availGroup.find("#searchCountry").val()) == ""){
				$('#chk_cusm6').prop('checked', false);
				setAlert("도시를 선택해 주세요.");
				return false;
			}

			rcGroup.find('#dep_place').val(availGroup.find('#srch_arr_ct_dis').val());
			
			if(nullToBlank(availGroup.find('#searchRntCity').val()) != ""){
				rcGroup.find('#take_place_cd').val(availGroup.find('#searchRntCity').val());
				rcGroup.find('#take_place_oagCd').val('');	
			}else{
				rcGroup.find('#take_place_cd').val('');
				rcGroup.find('#take_place_oagCd').val(availGroup.find('#searchCity').val());
			}
			
			rcGroup.find('#take_place_countryCd').val(availGroup.find('#searchCountry').val());
			
			var equalDepDtArr = availGroup.find('#dep_dt').text().split(".");
			var equalDepDt = equalDepDtArr[0] + equalDepDtArr[1] + equalDepDtArr[2];
			rcGroup.find('#dep_dt').text(availGroup.find('#dep_dt').text());
			rcGroup.find('#take_date').val(equalDepDt);
			
			var equalArrDtArr = availGroup.find('#arr_dt').text().split(".");
			var equalArrDt = equalArrDtArr[0] + equalArrDtArr[1] + equalArrDtArr[2];
			rcGroup.find('#arr_dt').text(availGroup.find('#arr_dt').text());
			rcGroup.find('#return_date').val(equalArrDt);
			rcGroup.find('#arr_dt').removeClass('noSelect');
			
			if($('#same_place').is(':checked') == true) { //인수장소와 동일
				rcGroup.find('#arr_place').val(availGroup.find('#srch_arr_ct_dis').val());
				
				if(nullToBlank(availGroup.find('#searchRntCity').val()) != ""){
					rcGroup.find('#return_place_cd').val(availGroup.find('#searchRntCity').val());
					rcGroup.find('#return_place_oagCd').val('');	
				}else{
					rcGroup.find('#return_place_cd').val('');
					rcGroup.find('#return_place_oagCd').val(availGroup.find('#searchCity').val());
				}

				rcGroup.find('#return_place_countryCd').val(availGroup.find('#searchCountry').val());
			} else {
				rcGroup.find('#arr_place').val('');
				rcGroup.find('#return_place_oagCd').val('');
				rcGroup.find('#return_place_countryCd').val('');
			}
		} else {
			rcGroup.find('#dep_place').val('');
			rcGroup.find('#take_place_oagCd').val('');
			rcGroup.find('#take_place_countryCd').val('');
			rcGroup.find('#arr_place').val('');
			rcGroup.find('#return_place_oagCd').val('');
			rcGroup.find('#arr_dt').text('미지정');
			rcGroup.find('#arr_dt').addClass('noSelect');
			rcGroup.find('#return_date').val('');
		}	
	}
	
	
</script>
</head>
<body>

	<form name="f_frm" id="f_frm" method="post">
		<input type="hidden" name="selAir" id="selAir" value="N" />
		<input type="hidden" name="selHotel" id="selHotel" value="N" />
		<input type="hidden" name="selRentcar" id="selRentcar" value="N" />
	</form>	

	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="collapse freetop">

			<!-- 중복텝 -->
			<div class="free_box">
				<ul class="free_topchk">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" /><label for="aircheck">항공</label></li>
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" /><label for="hotelcheck">호텔</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>

			<!-- 항공 파트 -->
			<%@include file="/WEB-INF/jsp/free/inc_air_search.jsp"%>

			<!-- 호텔파트 -->
			<%@include file="/WEB-INF/jsp/free/inc_hotel_search.jsp"%>

			<!-- 렌터카파트 -->
			<%@include file="/WEB-INF/jsp/free/inc_rentcar_search.jsp"%>

			<!-- 종합 검색 버튼 -->
			<div class="btn_one air_tbtn ttsch">
				<button class="purple2" data-role="none" onclick="fn_totalSearch()">검색하기</button>
			</div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	<!--//content-->
	</div>