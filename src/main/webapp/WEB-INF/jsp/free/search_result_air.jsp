<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>

<%
	String selAir = (String) request.getAttribute("selAir");
	String selHotel = (String) request.getAttribute("selHotel");
	String selRentcar = (String) request.getAttribute("selRentcar");

	// 서버 날짜 받아오기 
	Date systemDate2 = new Date();
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
	String serverDay2 = sdf2.format(systemDate2);
		
%>
<head>
<script src="/resources/common/js/fit/air_search.js"></script>
<script src="/resources/common/js/fit/paging.js"></script>
<script src="/resources/common/js/fit/common.js"></script>	
<script type="text/javascript">
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){

	if(nullToBlank(getCookieValue('airViewData')) != ""){
		sessionStorage.airViewData = getCookieValue('airViewData');
		setCookieValue('airViewData', "");
	}
	
	if(nullToBlank(getCookieValue('airSearchVal')) != ""){
		sessionStorage.airSearchVal = getCookieValue('airSearchVal');
		setCookieValue('airSearchVal', "");
	}

	//검색하기
	function fn_goSelPage() {
		var frm_action = '';
		
		var selAir =  $("#selAir").val();
		var selHotel = $("#selHotel").val();
		var selRentcar = $("#selRentcar").val();
		
		console.log("selAir >>> " + selAir);
		console.log("selHotel >>> " + selHotel);
		console.log("selRentcar >>> " + selRentcar);
		
		/** validation check */
		if(selAir == 'Y') {
			if(fn_set_air_research_value()){	//validation 유효성 체크
				frm_action = '/free/search_result_air.do';
			} else {
				return;
			}
		}
		/**
		if(selHotel == 'Y') {
			if(fn_set_hotel_search_value()){	
				if(frm_action == '') {
					frm_action = '/free/search_result_hotel.do';	
				}	
			} else {
				return;
			} 
		}

		if(selRentcar == 'Y') {
			
			if(frm_action == '') {
				frm_action = '/free/search_result_rentcar.do';	
			}		
		}
		**/

		if(frm_action == '') {
			alert('검색할 항목을 선택해 주세요.');
			return;
		} else {

			document.location.href = frm_action + '?selAir='+selAir+"&selHotel="+selHotel + "&selRentcar="+selRentcar;
		}
		
	}

	// 초기화
	var fn_init = function() {

		var airSelYn = '${selAir}';

		// url을 직접 입력하여 들어왔을경우 세션이 있는 검색값 초기화
		if(airSelYn != 'Y') {
			
			sessionStorage.airViewData = JSON.stringify({});
			sessionStorage.airSearchVal = JSON.stringify({});
		}
		
		// 항공 페이지이므로 항공 항상 Y
		$('#f_frm').children('input[name="selAir"]').val('Y');
		
		//검색값 세팅
		// gfn_loading_bar_draw('show');
		
	    if(sessionStorage.airViewData != undefined 
	    		&& JSON.parse(sessionStorage.airViewData).bodyDto != undefined) {
	        //화면에 보여줄 검색값 세팅
    	 	var search_div = $('#air_search_div');	//검색창 영역
		   	
    	 	// var search_body = JSON.parse(window.localStorage['airViewData']).bodyDto;
		    var search_body = JSON.parse(sessionStorage.airViewData).bodyDto;
		    // var input_availTy = search_body.availTy;
		   	var input_availTy = sessionStorage.availTy;


		    if(input_availTy != null && input_availTy != ''){
		    	
		    	var availData = search_body.availGroup;
		    	
				/**
		    	var availDiv = search_div.find('div[ar-att="availgroup"][ft-att="' + input_availTy + 'Group"]');
		    	search_div.find('input:radio[name="availTy"][value="' + input_availTy + '"]').prop('checked', true); 
		    	**/

				var availDiv = $('#air_search_div');
				
		    	var extra_text = "";

				if(input_availTy == 'RT' || input_availTy == 'OO') {	//왕복
				
				    availDiv.find('#depNm').html(availData[0].depNm);	//출발도시
				    availDiv.find('#depCd').html(availData[0].depCd);	//출발도시코드
				    availDiv.find('#arrNm').html(availData[0].arrNm);	//도착도시
				    availDiv.find('#arrCd').html(availData[0].arrCd);	//도착도시코드
				    availDiv.find('#depDt_retDt_text').html(gfn_setDateFormat(availData[0].depDt, '.')+" ~ " +gfn_setDateFormat(availData[0].arrDt, '.'));   	//출국일
					
					if(input_availTy == 'RT') {
						extra_text = "왕복";
					} else if(input_availTy == 'OO') {
						extra_text = "해외출발";
					}				    

				} else if (input_availTy == 'OW') {	//편도
				    availDiv.find('#depNm').html(availData[0].depNm);	//출발도시
				    availDiv.find('#depCd').html(availData[0].depCd);	//출발도시코드
				    availDiv.find('#arrNm').html(availData[0].arrNm);	//도착도시
				    availDiv.find('#arrCd').html(availData[0].arrCd);	//도착도시코드
				    availDiv.find('#depDt_retDt_text').html(gfn_setDateFormat(availData[0].depDt, '.'));   	//출국일
					
					if(input_availTy == 'OW') {
						extra_text = "편도";
					} 
		    	} else if (input_availTy == 'MT') {	//다구간
					availDiv.find('#depNm').html(availData[0].depNm);	//출발도시
					availDiv.find('#depCd').html(availData[0].depCd);	//출발도시코드
					availDiv.find('#arrNm').html(availData[availData.length-1].arrNm);	//도착도시
					availDiv.find('#arrCd').html(availData[availData.length-1].arrCd);	//도착도시코드
					availDiv.find('#depDt_retDt_text').html(gfn_setDateFormat(availData[0].depDt, '.'));   	//출국일

					/**
					for(var av_idx=0; av_idx<availData.length; av_idx++) {
						console.log(" >>>>>>>>>>>>>>>>>>> " + av_idx + " availData.length : " + availData.length);
						
						if(av_idx >= 3) {	//여정이 3개 이상이면 입력란을 늘려준다.
		    				addAvail();
		    				// $(".btn_delair.none").css("display","block");
		    			}
		    			var target_div = $('div[mt-data="' + (parseInt(av_idx)+1) + '"]');
		    			var target_data = availData[av_idx];
		    			console.log(" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		    			console.log(target_data);

		    			target_div.find('#srch_dep_ct_dis').html(target_data.depNm);	//출발도시
					    target_div.find('#srch_dep_ct').html(target_data.depCd);	//출발도시코드
					    target_div.find('#srch_arr_ct_dis').html(target_data.arrNm);	//도착도시
					    target_div.find('#srch_arr_ct').html(target_data.arrCd);	//도착도시코드
					    target_div.find('#dep_dt').html(gfn_setDateFormat(target_data.depDt, '.'));   	//출국일
						
					}
					**/
					extra_text = "다구간";
		    	}


				if(search_body.cabinClas == 'Y') { // 좌석 클래스 
					extra_text = extra_text + " , 일반석";
				} else if(search_body.cabinClas == 'W') {
					extra_text = extra_text + " , 프리미엄 일반석";
				} else if(search_body.cabinClas == 'C') {
					extra_text = extra_text + " , 비즈니스석";
				} else if(search_body.cabinClas == 'A') {
					extra_text = extra_text + " , 일등석";
				}

				if(parseInt(search_body.adtCnt) > 0) {
					extra_text = extra_text + " , 성인 " + search_body.adtCnt  + "";
				}
				
			   if(parseInt(search_body.chdCnt) > 0) {	//아동 탑승객 수
			   		extra_text = extra_text + " , 아동 " + search_body.chdCnt  + "";
				}

			   if(parseInt(search_body.infCnt) > 0) {	//유아 탑승객 수
			   		extra_text = extra_text + " , 유아 " + search_body.infCnt  + "";
				}
				
				$('#extraTxt').html(extra_text);

				$('#air_result_nodata_div').hide();
				$('#air_result_list_div').show();
				try {
					fn_air_list(JSON.parse(sessionStorage.airSearchVal).bodyDto);
					// air_filter_init();
				} catch (e) {
					$('#air_result_nodata_div').show();
					$('#air_result_list_div').hide();
				}
				// successPro(JSON.parse(sessionStorage.airSearchVal).bodyDto)
		    }

	    }

	};

	function air_filter_init() {
		air_fil_via_type = $("#air_fil_via_type").val();
		air_fil_class_type = $("#air_fil_class_type").val();
		air_fil_air_line = $("#air_fil_air_line").val();
		air_fil_dep_tm = $("#air_fil_dep_tm").val();

		console.log("air_filter_init() >> air_fil_via_type : " + air_fil_via_type);
		console.log("air_filter_init() >> air_fil_class_type : " + air_fil_class_type);
		console.log("air_filter_init() >> air_fil_air_line : " + air_fil_air_line);
		console.log("air_filter_init() >> air_fil_dep_tm : " + air_fil_dep_tm);

		if(air_fil_via_type != 'ALL') {
			$('input:checkbox[ar_att="filter_chk"][name="fil_via_type"][value="ALL"]').prop('checked', false);
			$('input:checkbox[ar_att="filter_chk"][name="fil_via_type"][value="ALL"]').attr('checked', false);
			
			var fil_via_type = air_fil_via_type.split(',');
			for(var i = 0; i < fil_via_type.length; i++) {
				$("input:checkbox[ar_att='filter_chk'][name='fil_via_type'][value='"+fil_via_type[i]+"']").prop('checked', true);
				$("input:checkbox[ar_att='filter_chk'][name='fil_via_type'][value='"+fil_via_type[i]+"']").attr('checked', true);
			}
		}

		if(air_fil_class_type != 'ALL') {
			$('input:checkbox[ar_att="filter_chk"][name="fil_class_type"][value="ALL"]').prop('checked', false);
			$('input:checkbox[ar_att="filter_chk"][name="fil_class_type"][value="ALL"]').prop('checked', false);

			var fil_class_type = air_fil_class_type.split(',');
			for(var i = 0; i < fil_class_type.length; i++) {
				$("input:checkbox[ar_att='filter_chk'][name='fil_class_type'][value='"+fil_class_type[i]+"']").prop('checked', true);
				$("input:checkbox[ar_att='filter_chk'][name='fil_class_type'][value='"+fil_class_type[i]+"']").attr('checked', true);
			}
		}

		if(air_fil_air_line != 'ALL') {
			$('input:checkbox[ar_att="filter_chk"][name="fil_air_line"][value="ALL"]').prop('checked', false);
			$('input:checkbox[ar_att="filter_chk"][name="fil_air_line"][value="ALL"]').attr('checked', false);

			var fil_air_line = air_fil_air_line.split(',');
			for(var i = 0; i < fil_air_line.length; i++) {
				$("input:checkbox[ar_att='filter_chk'][name='fil_air_line'][value='"+fil_air_line[i]+"']").prop('checked', true);
				$("input:checkbox[ar_att='filter_chk'][name='fil_air_line'][value='"+fil_air_line[i]+"']").attr('checked', true);
			}
		}

		if(air_fil_dep_tm != 'ALL') {
			$('input:checkbox[ar_att="filter_chk"][name="fil_dep_tm"][value="ALL"]').prop('checked', false);
			$('input:checkbox[ar_att="filter_chk"][name="fil_dep_tm"][value="ALL"]').attr('checked', false);
			
			var fil_dep_tm = air_fil_dep_tm.split(',');
			for(var i = 0; i < fil_dep_tm.length; i++) {			
				$("input:checkbox[ar_att='filter_chk'][name='fil_dep_tm'][value='"+fil_dep_tm[i]+"']").prop('checked', true);
				$("input:checkbox[ar_att='filter_chk'][name='fil_dep_tm'][value='"+fil_dep_tm[i]+"']").attr('checked', true);
			}

		}

		$("#filter_air").show();
	}

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};



	var mtOtherCnt = 3;
	function fn_chnAvailTy(chkAvailTy) {
		var airDiv = $('div#air_research_div');
		airDiv.find('div[ar-att="availgroup"]').hide();
		airDiv.find('div[ft-att="' + chkAvailTy + 'Group"]').show();
		
		$("#li_RT").removeClass("active");
		if(chkAvailTy == 'RT') $("#li_RT").addClass("active");
		if(chkAvailTy == 'OW') $("#li_OW").addClass("active");
		if(chkAvailTy == 'MT') $("#li_MT").addClass("active");
		if(chkAvailTy == 'OO') $("#li_OO").addClass("active");
		
		if(chkAvailTy == 'MT') {
			$('.chkv_show').hide();
		} else {
			$('.chkv_show').show();
		}

	}
    
	
    function fn_research_init() {
		if(sessionStorage.airViewData != undefined 
				&& JSON.parse(sessionStorage.airViewData).bodyDto != undefined) {
			//화면에 보여줄 검색값 세팅
			var search_div = $('#air_research_div');	//검색창 영역
			
			// var search_body = JSON.parse(window.localStorage['airViewData']).bodyDto;
			var search_body = JSON.parse(sessionStorage.airViewData).bodyDto;
			var input_availTy = sessionStorage.availTy;

			

			console.log("fn_research_init() >>>  input_availTy : " + input_availTy);

			fn_chnAvailTy(input_availTy);

			if(input_availTy != null && input_availTy != ''){
				
				var availData = search_body.availGroup;
				
				var availDiv = search_div.find('div[ar-att=availgroup][ft-att=' + input_availTy + 'Group]');
				// search_div.find('input:radio[name="availTy"][value="' + input_availTy + '"]').prop('checked', true); 
				
				if(input_availTy == 'RT' || input_availTy == 'OO') {	//왕복
					
					console.log("availDiv.find('#srch_dep_ct_dis') : " + availDiv.find('#srch_dep_ct_dis') + " availData[0].depNm : " + availData[0].depNm );
					console.log("availDiv.find('#srch_arr_ct') : " + availDiv.find('#srch_arr_ct') + " availData[0].arrCd : " + availData[0].arrCd);
					availDiv.find('#srch_dep_ct_dis').html(availData[0].depNm);	//출발도시
					availDiv.find('#srch_dep_ct').html(availData[0].depCd);	//출발도시코드
					availDiv.find('#srch_arr_ct_dis').html(availData[0].arrNm);	//도착도시
					availDiv.find('#srch_arr_ct').html(availData[0].arrCd);	//도착도시코드
					availDiv.find('#dep_dt').html(gfn_setDateFormat(availData[0].depDt, '.'));   	//출국일
					availDiv.find('#arr_dt').html(gfn_setDateFormat(availData[0].arrDt, '.'));		//귀국일
					//해외출발일 경우 출발도시의 속성을 제거한다.
					/**
					if(input_availTy == 'OO') {
						availDiv.find('#arr_dt').html(availData[0].arrDt);
					}
					**/

				} else if (input_availTy == 'OW') {	//편도
					availDiv.find('#srch_dep_ct_dis').html(availData[0].depNm);	//출발도시
					availDiv.find('#srch_dep_ct').html(availData[0].depCd);	//출발도시코드
					availDiv.find('#srch_arr_ct_dis').html(availData[0].arrNm);	//도착도시
					availDiv.find('#srch_arr_ct').html(availData[0].arrCd);	//도착도시코드
					availDiv.find('#dep_dt').html(gfn_setDateFormat(availData[0].depDt, '.'));   	//출국일
				} else if (input_availTy == 'MT') {	//다구간
					/**
					availDiv.find('#depNm').html(availData[0].depNm);	//출발도시
					availDiv.find('#depCd').html(availData[0].depCd);	//출발도시코드
					availDiv.find('#arrNm').html(availData[availData.length-1].arrNm);	//도착도시
					availDiv.find('#arrCd').html(availData[availData.length-1].arrCd);	//도착도시코드
					availDiv.find('#depDt_retDt_text').html(gfn_setDateFormat(availData[0].depDt, '.'));   	//출국일
		    		**/
					for(var av_idx=0; av_idx<availData.length; av_idx++) {

						console.log(" >>>>>>>>>>>>>>>>>>> " + av_idx + " availData.length : " + availData.length);
						
						if(av_idx >= 3) {	//여정이 3개 이상이면 입력란을 늘려준다.
		    				addAvail();
		    				// $(".btn_delair.none").css("display","block");
		    			}
		    			var target_div = availDiv.find('div[mt-data="' + (parseInt(av_idx)+1) + '"]');
		    			var target_data = availData[av_idx];
		    			// console.log(" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		    			// console.log(target_data);
						if(av_idx == 0) {						
							target_div.find('#srch_dep_ct_dis').html(target_data.depNm);	//출발도시
							target_div.find('#srch_dep_ct').html(target_data.depCd);	//출발도시코드
							target_div.find('#srch_arr_ct_dis').html(target_data.arrNm);	//도착도시
							target_div.find('#srch_arr_ct').html(target_data.arrCd);	//도착도시코드
							target_div.find('#dep_dt').html(gfn_setDateFormat(target_data.depDt, '.'));   	//출국일
						} else {

							var div_tag1 = "#srch_dep_ct_dis" + (av_idx+1);
							var div_tag2 = "#srch_dep_ct" + (av_idx+1);
							var div_tag3 = "#srch_arr_ct_dis" + (av_idx+1);
							var div_tag4 = "#srch_arr_ct" + (av_idx+1);
							var div_tag5 = "#dep_dt" + (av_idx+1);
							target_div.find(div_tag1).html(target_data.depNm);	//출발도시
							target_div.find(div_tag2).html(target_data.depCd);	//출발도시코드
							target_div.find(div_tag3).html(target_data.arrNm);	//도착도시
							target_div.find(div_tag4).html(target_data.arrCd);	//도착도시코드
							target_div.find(div_tag5).html(gfn_setDateFormat(target_data.depDt, '.'));   	//출국일
							
						}
					}	
					extra_text = "다구간";			
				}

				search_div.find('#cabinClas option[value="' + search_body.cabinClas + '"]').prop('selected', true);	//좌석클래스
				search_div.find('#adtCnt').html(search_body.adtCnt);	//성인 탑승객 수 
				search_div.find('#chdCnt').html(search_body.chdCnt);	//아동 탑승객 수
				search_div.find('#infCnt').html(search_body.infCnt);	//소아 탑승객 수
				
			}
		}
		
	}

	function addAvail() {
		var mtDiv = $('div[ar-att="availgroup"][ft-att="MTGroup"]');
		var mtOtherCnt = mtDiv.find('[name="depNm"]').length;
		
		if (mtOtherCnt >= 4) {	//여정은 4개까지 추가 가능	
			return;
		}

		if(mtOtherCnt < 5) {
			var html = "";

			// <!-- 여정 2 -->
			html = html + "<div class='many_travelbox' mt-data='"+mtOtherCnt+"' mt-att='availDiv'>";
			// <!-- 간략안내 -->
			html = html + "	<div class='travel'>";
			html = html + "		<p>여정 "+mtOtherCnt+" </p>";
			html = html + "	</div>";
			html = html + "	<div class='stable_guide oenway'>";
				
			html = html + "		<button type='button' class='layerOpener' data-url='/pop/pop_city_select2.do?availTy=MT&travelMtCnt="+ mtOtherCnt + "&type=D'  data-ctn='full' data-role='none' style='cursor='hand';'>";
			html = html + "			<p class='st_text'>";
			html = html + "				<span name='depCd' id='srch_dep_ct"+mtOtherCnt+"'>도착</span>";
			html = html + "				<input type='hidden' name='depCd' id='srch_dep_ct"+mtOtherCnt+"' value=''/>";
			html = html + "			</p>";
			html = html + "			<p>";
			html = html + "				<span name='depNm' ar-att='departure' target-id='srch_dep_ct"+mtOtherCnt+"' id='srch_dep_ct_dis"+mtOtherCnt+"'>도착지 선택</span>";
			html = html + "			</p>";
			html = html + "		</button>";

			html = html + "		<button type='button' class='layerOpener' data-url='/pop/pop_city_select2.do?availTy=MT&travelMtCnt="+ mtOtherCnt + "&type=A' data-ctn='full' data-role='none' style='cursor='hand';'>";
			html = html + "			<p class='st_text'>";
			html = html + "				<span name='arrCd' id='srch_arr_ct"+mtOtherCnt+"'>도착</span>";
			html = html + "			</p>";
			html = html + "			<p>";
			html = html + "				<span name='arrNm' id='srch_arr_ct_dis"+mtOtherCnt+"' target-id='srch_arr_ct"+mtOtherCnt+"' ar-att='arrive'>도착지 선택</span>";
			html = html + "			</p>";
			html = html + "		</button>";
			html = html + "	</div>";
			// <!-- 날짜 -->
			html = html + "	<ul class='tra_day tra_day1'>";
			html = html + "	  <li><button type='button' class='layerOpener' data-url='/pop/pop_calendar.do?type=AIR&availTy=MT&travelMtCnt="+ mtOtherCnt + "'  data-ctn='full' data-role='none' style='cursor='hand';'><span name='depDt' id='dep_dt"+mtOtherCnt+"'>출발일선택</span></button></li>";
			html = html + "	</ul>";
				
			html = html + "</div>";

			$('#div_othertravelplan').append(html);

			if(mtOtherCnt == 5) {
				$('#div_addtravelbtn').hide();
			}
		} else {
			$('#div_addtravelbtn').hide();
		}
	}

	function fn_addTravelPlan() {
		
		mtOtherCnt ++;

		if(mtOtherCnt < 5) {
			var html = "";

			// <!-- 여정 2 -->
			html = html + "<div class='many_travelbox' mt-data='"+mtOtherCnt+"' mt-att='availDiv'>";
			// <!-- 간략안내 -->
			html = html + "	<div class='travel'>";
			html = html + "		<p>여정 "+mtOtherCnt+" </p>";
			html = html + "	</div>";
			html = html + "	<div class='stable_guide oenway'>";
				
			html = html + "		<button type='button' class='layerOpener' data-url='/pop/pop_city_select2.do?availTy=MT&travelMtCnt="+ mtOtherCnt + "&type=D'  data-ctn='full' data-role='none' style='cursor='hand';'>";
			html = html + "			<p class='st_text'>";
			html = html + "				<span name='depCd' id='srch_dep_ct"+mtOtherCnt+"'>도착</span>";
			html = html + "				<input type='hidden' name='depCd' id='srch_dep_ct"+mtOtherCnt+"' value=''/>";
			html = html + "			</p>";
			html = html + "			<p>";
			html = html + "				<span name='depNm' ar-att='departure' target-id='srch_dep_ct"+mtOtherCnt+"' id='srch_dep_ct_dis"+mtOtherCnt+"'>도착지 선택</span>";
			html = html + "			</p>";
			html = html + "		</button>";

			html = html + "		<button type='button' class='layerOpener' data-url='/pop/pop_city_select2.do?availTy=MT&travelMtCnt="+ mtOtherCnt + "&type=A' data-ctn='full' data-role='none' style='cursor='hand';'>";
			html = html + "			<p class='st_text'>";
			html = html + "				<span name='arrCd' id='srch_arr_ct"+mtOtherCnt+"'>도착</span>";
			html = html + "			</p>";
			html = html + "			<p>";
			html = html + "				<span name='arrNm' id='srch_arr_ct_dis"+mtOtherCnt+"' target-id='srch_arr_ct"+mtOtherCnt+"' ar-att='arrive'>도착지 선택</span>";
			html = html + "			</p>";
			html = html + "		</button>";
			html = html + "	</div>";				
			// <!-- 날짜 -->
			html = html + "	<ul class='tra_day tra_day1'>";
			html = html + "		<li><button type='button' class='layerOpener' data-url='/pop/pop_calendar.do?type=AIR&availTy=MT&travelMtCnt="+ mtOtherCnt + "'  data-ctn='full' data-role='none' style='cursor='hand';'><span name='depDt' id='dep_dt"+mtOtherCnt+"'>출발일선택</span></button></li>";
			html = html + "	</ul>";

			html = html + "</div>";

			$('#div_othertravelplan').append(html);

			if(mtOtherCnt == 5) {
				$('#div_addtravelbtn').hide();
			}
		} else {
			$('#div_addtravelbtn').hide();
		}
	}



	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();
		$(".bodyWrap").addClass("foot2pd");
		fn_research_init();
		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});

	// });
</script>
</head>
<form name="f_frm" id="f_frm" method="post">
	<input type="hidden" name="selAir" id="selAir" value="${selAir}" />
	<input type="hidden" name="selHotel" id="selHotel" value="${selHotel}" />
	<input type="hidden" name="selRentcar" id="selRentcar" value="${selRentcar}" />
</form>

<body>

	<form name="f_frm" id="f_frm" method="post">
		<input type="hidden" name="selAir" id="selAir"  value="${selAir}" />
		<input type="hidden" name="selHotel" id="selHotel" value="${selHotel}" />
		<input type="hidden" name="selRentcar" id="selRentcar" value="${selRentcar}" />
	</form>	

	<!-- 항공 검색 조건 필터링 -->
	<input type="hidden" ar_att="filter_chk"  name="air_fil_via_type" id="air_fil_via_type" value="ALL" />
	<input type="hidden" ar_att="filter_chk"  name="air_fil_class_type" id="air_fil_class_type" value="ALL" />
	<input type="hidden" ar_att="filter_chk"  name="air_fil_air_line" id="air_fil_air_line" value="ALL" />
	<input type="hidden" ar_att="filter_chk"  name="air_fil_dep_tm" id="air_fil_dep_tm" value="ALL" />
	<input type="hidden" ar_att="filter_chk"  name="air_fil_fare_type" id="air_fil_fare_type" value="ALL" />

	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="collapse freetop">
			<!-- 중복텝 -->
			<%
				// 항공 || 호텔 || 렌트카
				if(selAir.equals("Y") && selHotel.equals("Y") && selRentcar.equals("Y")) {
			%>
			<div class="free_box">
				<ul class="free_toprst frrst3">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" disabled="true" /><label for="hotelcheck">호텔</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
				// 항공 || 호텔
				if(selAir.equals("Y") && selHotel.equals("Y") && !selRentcar.equals("Y")) {
			%> 
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" disabled="true" /><label for="hotelcheck">호텔</label></li>
				</ul>
			</div>
			<%
				}
				// 항공 || 렌트카 
				if(selAir.equals("Y") && !selHotel.equals("Y") && selRentcar.equals("Y")) {
			%>
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
				// 호텔 || 렌트카 
				if(!selAir.equals("Y") && selHotel.equals("Y") && selRentcar.equals("Y")) {			
			%>
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="hotelcheck">호텔</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
				// 항공
				if(selAir.equals("Y") && !selHotel.equals("Y") && !selRentcar.equals("Y")) {			
			%>			
			<div class="free_box">
				<ul class="free_toprst frrst1">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="aircheck">항공</label></li>
				</ul>
			</div>
			<%
				}
			%>
			<!-- 간략안내 -->
			<div class="re_sarchbox re_very_sarchbox">
				<!-- 항공 검색 조건 탭 -->
				<div id="air_search_div" name="air_search_div">
					<div class="stable_guide2">
						<p class="st2_stext1 ellipsis" id='depNm'></p>
						<p class="st2_text1" id='depCd'></p>
						<p class="st2_gbox"></p>
						<p class="st2_text2" id='arrCd'></p>
						<p class="st2_stext2 ellipsis" id='arrNm'></p>
					</div>
					<div class="txbox1">
						<div id='depDt_retDt_text'></div>
						<p id='extraTxt'></p>
					</div>
				</div>
				<!-- 검색버튼 -->
				<button type="button" data-role="none" class="re_search">재검색</button>
				
				<!-- 정렬박스 -->
				<ul class="fr_sortbox">
					<li>총 상품 <span ft-arr="totCnt" id="totCnt" name="totCnt">0000</span>개</li>
					<li><button type="button" class="layerOpener" data-url="/pop/pop_air_sorting.do" data-width="300" data-height="400" data-ok="yes" data-ctn="full" data-role="none" style="cursor='hand';"><span id="air_sort" name='air_sort' data-airsort='C'>직항+최저 요금 순</span></button></li>
					<li><button type="button" class="layerOpener" data-url="/pop/pop_air_ifdetail.do" data-ok="yes" data-ctn="full" data-role="none" style="cursor='hand';"></button></li>
				</ul>

				<!-- 빈데이터 -->
				<div id='air_result_nodata_div' name="air_result_nodata_div">
					<div class="fr_nodata">
						<p>
							검색하신 조건으로<br>검색된 항공이 없습니다.
						</p>
					</div>		
				</div>		

				<!-- 검색 결과 리스트 -->
				<div id="air_result_list_div" name="air_result_list_div">

				</div>
				<!-- 검색 결과 리스트 -->

				<!-- 버튼 -->
				<div class="btn_one air_tbtn" id="air_paging_div" name="air_paging_div">
					<button class="white2 moreico" data-role="none" onclick='fn_air_paging()'>더보기</button>
				</div>

				<!-- *********************** 재검색 레이어 ******************* -->
				<div class="re_schview">
					<!-- 재검색 UI -->
					<%@include file="/WEB-INF/jsp/free/inc_air_search_result.jsp"%>
					<!-- 재검색 UI -->
					<button type="button" data-role="none" class="re_search_close">닫기</button>
				</div>
				<!-- *********************** 재검색 레이어 ******************* -->
				<!-- *********************** 항공 필터링 레이어 ******************* -->
				<div id="filter_air" name='filter_air'>
					<%@include file="/WEB-INF/jsp/free/inc_search_result_air_ifdetail.jsp"%>
				</div>
				<!-- *********************** 항공 필터링 레이어 ******************* -->

			</div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//content-->