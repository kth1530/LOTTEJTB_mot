<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_select_air.jsp
	// 설명 : 선택확인 항공 장바구니 담기 화면 
%>
<script type="text/javascript">
	var popMode = '${mode}';
	var custCd = '${custCd}';
	var apiFlightData;
	var pkgPrice = 0;  //패키지 할인가
	var selConcMix;
			
	//상세보기 데이터 호출 ajax - 추후 상세보기 팝업과 합치면 됨 ajax X - 미완료
	function fn_detail() {
		var l_selData = JSON.parse(sessionStorage.airSelData);
		if(!l_selData.retDYn){	//상세데이터를 조회하지 않은 경우
			var cdata = fn_setAvailData_pop();
			
			gfn_callAjax3('/fit/air/viewInfo.do', cdata, 'fn_setDetailData', false, function(){
				fn_showDetailPop();
			});
		} else {
			fn_showDetailPop();
		}
	}
	
	//상세보기 팝업 - 임시 미완료
	function fn_showDetailPop () {
		
		//대상이 되는 inputbox 지정
		var detail_pop = $('div[ft-att="air_detail_pop"]'); 
			
		// 항공일정 
		// var arCnt = _obj;
		var air_fix_data_info = JSON.parse(sessionStorage.airSelData);
		console.log(air_fix_data_info);
		var arDetailList = air_fix_data_info[0].segmentGroup;
		var avail_cnt = air_fix_data_info[0].fltData.length;

		var availTy = air_fix_data_info[0].availTy;
		console.log(">>>>>>>>>>>>>>>>>> availTy : " + availTy);

		var avail_div = detail_pop.find('.cntain').find('div.air_cart_div');
		var tmp_arrDt = '';
		var tmp_arrTm = '';


		for(var d_idx=0; d_idx < arDetailList.length; d_idx++) {
			var arDetailInfo = arDetailList[d_idx];
			var arFixData = air_fix_data_info[0].fltData[(arDetailInfo.availNo - 1)];
			
			var tempDelayTime;
			try{
				tempDelayTime = apiFlightData[d_idx].data.durationTm; 
				arFixData.interval = tempDelayTime.substring(0, 2) + '시간 ' + tempDelayTime.substring(2, 4) + '분';
			}catch(e){}
			
			var tmpDetailDiv = $('#air_schd');
			var delayTxt = '';
			if(arDetailInfo.segNo == 1) {
				var tmpTitle = '';
				var segCnt = arFixData.segCnt;
				if(arDetailInfo.availNo == 1) {
					tmpTitle = "출발";
				} else if(arDetailInfo.availNo == avail_cnt) {
					tmpTitle = "도착";
				} else {
					tmpTitle = "다구간 여정";
				}
				// tmpDetailDiv.append(tmpTitle);
			} else {
				var f_delayTm = calcInterval(tmp_arrDt, tmp_arrTm, arDetailInfo.depDt, arDetailInfo.depTm).split(',');
				var delayTime = f_delayTm[1]-0;
				var delayMin = f_delayTm[2];
				if((f_delayTm[0]-0) > 0){
					delayTime += (f_delayTm[0]-0)*24;
				}
				delayTxt = '공항대기시간 : ' + strDateFormat(delayTime) + ':' + strDateFormat(delayMin);
			}
		
			tmp_arrDt = arDetailInfo.arrDt;
			tmp_arrTm = arDetailInfo.arrTm;
			
			
			var bookingClas = arDetailInfo.cabinClas;
			if(bookingClas == 'W') {
				bookingClas = '프리미엄일반석';
			} else if(bookingClas == 'F') {
				bookingClas = '일등석';
			} else if(bookingClas == 'C') {
				bookingClas = '비지니스석';
			} else{
				bookingClas = '일반석';
			}
			
			var viaNm = arFixData.stopYn;
			
			// 출발 항공 도시 표시가 NaN 표시 때문에 
			var dep_nm = arDetailInfo.depNm;  
			// console.log("arDetailInfo.depNm : " + arDetailInfo.depNm);


			var dep_tm = arDetailInfo.depTm.substring(0,2) + ':' + arDetailInfo.depTm.substring(2,4);
			var dep_dt = arDetailInfo.depDt.substring(0,4) + '.' + arDetailInfo.depDt.substring(4,6) + '.' + arDetailInfo.depDt.substring(6,8);
			var dep_dtArr = [];
			dep_dtArr[0] = 	arDetailInfo.depDt.substring(0,4);
			dep_dtArr[1] = 	arDetailInfo.depDt.substring(4,6);			
			dep_dtArr[2] = 	arDetailInfo.depDt.substring(6,8);
			var depDate = new Date(dep_dtArr[0], parseInt(dep_dtArr[1]-1), dep_dtArr[2]);
			var depNumber = getWeeks(depDate.getDay());
			dep_dt = dep_dt + '(' + depNumber + ')'; 
			
			var arr_tm = arDetailInfo.arrTm.substring(0,2) + ':' + arDetailInfo.arrTm.substring(2,4);
			var arr_dt = arDetailInfo.arrDt.substring(0,4) + '.' + arDetailInfo.arrDt.substring(4,6) + '.' + arDetailInfo.arrDt.substring(6,8);
			var arr_dtArr = [];
			arr_dtArr[0] = arDetailInfo.depDt.substring(0,4);
			arr_dtArr[1] = arDetailInfo.arrDt.substring(4,6);
			arr_dtArr[2] = arDetailInfo.arrDt.substring(6,8);
			var arrDate = new Date(arr_dtArr[0], parseInt(arr_dtArr[1]-1), arr_dtArr[2]);
			var arrNumber = getWeeks(arrDate.getDay());
			arr_dt = arr_dt + '(' + arrNumber + ')';
			
			
			//공동운항
			var codeShareYn = '';
			if(arDetailInfo.codeShare != ''){
				codeShareYn = arDetailInfo.codeShareNm + ' 공동운항'; 
			}
			
			var availInfo = "";
			availInfo = availInfo + "			<ul class='fr_porlist'>";
			availInfo = availInfo + "			<li><span>"+tmpTitle+"</span><span><img src='/resources/images/air/"+arDetailInfo.carrierCd+".png' alt=''>"+arDetailInfo.carrierNm+"</span>"
			availInfo = availInfo + "				<p>-편명 "+ arDetailInfo.fltNo + '(' + bookingClas + ')' + viaNm + "</p></li>";
			
			if(codeShareYn != '') {
				availInfo = availInfo + "<li class='air_com_trc2'><span>" + codeShareYn + " " + delayTxt + "</span></li>";
			} else if(arDetailInfo.segNo != 1) {
				availInfo = availInfo + "<li class='air_com_trc2'><span>" + delayTxt + "</span></li>";
			} 
			availInfo = availInfo + "						<li>";
			availInfo = availInfo + "							<ul>";
			availInfo = availInfo + "								<li id='" + arDetailInfo.depCd + "'>"+arDetailInfo.depCd+"</li>";
			availInfo = availInfo + "								<li>"+dep_dt+"</li>";
			availInfo = availInfo + "								<li></li>";
			availInfo = availInfo + "								<li id='" + arDetailInfo.arrCd + "'>"+ arDetailInfo.arrCd +"</li>";
			availInfo = availInfo + "								<li>"+ arr_dt + "</li>";
			// availInfo = availInfo + "								<li><span>+1D</span></li>";
			availInfo = availInfo + "								<li id='delayTime"+ d_idx +"'>"+ arFixData.interval +"</li>";
			availInfo = availInfo + "							</ul>";
			availInfo = availInfo + "						</li>";			

			tmpDetailDiv.append(availInfo);
		}
		var airSummary = JSON.parse(sessionStorage.airViewData).bodyDto;
		// console.log(airSummary);
		var airSummaryDiv = $('#air_summary');

		var air_summary = "";
	

		/** 다구간이 아닌 경우 **/
		if(availTy != 'MT') {
			air_summary = air_summary +"							<p class='st2_stext1 ellipsis'>"+airSummary.availGroup[0].depNm+"</p>";
			air_summary = air_summary +"							<p class='st2_text1'>"+airSummary.availGroup[0].depCd+"</p>";
			air_summary = air_summary +"							<p class='st2_gbox'></p>";
			air_summary = air_summary +"							<p class='st2_text2'>"+airSummary.availGroup[0].arrCd+"</p>";
			air_summary = air_summary +"							<p class='st2_stext2 ellipsis'>"+airSummary.availGroup[0].arrNm+"</p>";
		/** 다구간 일 경우 **/
		} else {
			air_summary = air_summary +"							<p class='st2_stext1 ellipsis'>"+airSummary.availGroup[0].depNm+"</p>";
			air_summary = air_summary +"							<p class='st2_text1'>"+airSummary.availGroup[0].depCd+"</p>";
			air_summary = air_summary +"							<p class='st2_gbox'></p>";
			air_summary = air_summary +"							<p class='st2_text2'>"+airSummary.availGroup[airSummary.availGroup.length-1].arrCd+"</p>";
			air_summary = air_summary +"							<p class='st2_stext2 ellipsis'>"+airSummary.availGroup[airSummary.availGroup.length-1].arrNm+"</p>";

		}
		airSummaryDiv.append(air_summary);

		//검색값 가져오기
		var inputvalue = JSON.parse(sessionStorage.airSearchVal).bodyDto;

		var iPasCnt = []; 
			
		iPasCnt[0] = inputvalue.adtCnt; 
		iPasCnt[1] = inputvalue.chdCnt;
		iPasCnt[2] = inputvalue.infCnt;
		
		var colspan_cnt = 0;
		if(inputvalue.adtCnt > 0) colspan_cnt ++;
		if(inputvalue.chdCnt > 0) colspan_cnt ++;
		if(inputvalue.infCnt > 0) colspan_cnt ++;
		
		//요금 계산

		var cont_html = "";
		cont_html = cont_html + "					<p class='pop_pinfo_title'>요금표</p>";
		cont_html = cont_html + "					<table class='pop_table1 ft_tb_tr'>";
		cont_html = cont_html + "						<colgroup>";
		cont_html = cont_html + "							<col style='width: 25%' />";
		cont_html = cont_html + "							<col style='width: 25%' />";
		cont_html = cont_html + "							<col style='width: 25%' />";
		cont_html = cont_html + "							<col style='width: 25%' />";
		cont_html = cont_html + "						</colgroup>";
		cont_html = cont_html + "						<thead>";
		cont_html = cont_html + "							<tr ft-att='gbn'>";
		cont_html = cont_html + "								<th>구분</th>";
		cont_html = cont_html + "							</tr>";
		cont_html = cont_html + "						</thead>";
		cont_html = cont_html + "						<tbody>";
		cont_html = cont_html + "							<tr ft-att='fare'>";
		cont_html = cont_html + "								<th>기본운임</th>";
		cont_html = cont_html + "							</tr>";
		cont_html = cont_html + "							<tr ft-att='tasf'>";
		cont_html = cont_html + "								<th>취급수수료</th>";
		cont_html = cont_html + "							</tr>";
		cont_html = cont_html + "							<tr ft-att='fuel'>";
		cont_html = cont_html + "								<th>유류할증료</th>";
		cont_html = cont_html + "							</tr>";
		cont_html = cont_html + "							<tr ft-att='tax'>";
		cont_html = cont_html + "								<th>제세공과금</th>";
		cont_html = cont_html + "							</tr>";
		cont_html = cont_html + "							<tr class='tb_purple' ft-att='price' style='display:none'>";
		cont_html = cont_html + "								<th>합계</th>";
		cont_html = cont_html + "							</tr>";
		// 프로모션 관련 현재 구현이 안됨. 
		cont_html = cont_html + "							<tr class='tb_purple' ft-att='promo'>";
		cont_html = cont_html + "								<th>프로모션할인</th>";
		//cont_html = cont_html + "								<td colspan='"+colspan_cnt+"'>0 원</td>";
		cont_html = cont_html + "							</tr>";
		cont_html = cont_html + "							<tr class='tb_purple'>";
		cont_html = cont_html + "								<th>총 운임</th>";
		cont_html = cont_html + "								<td colspan='"+colspan_cnt+"' id='totFare' name='totFare'>0원</td>";
		cont_html = cont_html + "							</tr>";
		cont_html = cont_html + "						</tbody>";
		cont_html = cont_html + "					</table>";

		detail_pop.find('#air_price_detail').html(cont_html);

		
		var fareDiv = detail_pop.find('.ft_tb_tr');
		var totFare = 0;
		var promSaleFare = 0;

		for(var f_idx=0; f_idx<iPasCnt.length; f_idx++) {
			var i_pas_cnt = iPasCnt[f_idx];
			if(i_pas_cnt > 0){
				//인원수
				var pasNm = '';
				if(f_idx == 0){
					pasNm = '성인' + i_pas_cnt + '명';
				} else if (f_idx == 1) {
					pasNm = '아동' + i_pas_cnt + '명';
				} else if (f_idx == 2) {
					pasNm = '유아' + i_pas_cnt + '명';
				}
				fareDiv.find('tr[ft-att="gbn"]').append('<th>' + pasNm + '</th>');
				
				var paxData = air_fix_data_info[0].paxDataBean[f_idx];
				//기본운임
				var faresum = paxData.fareCharge * i_pas_cnt;
				
				
				if(nullToBlank(paxData.promInfo) != ""){					
					if(paxData.promInfo.tyGb == "U"){
						promSaleFare -= (paxData.promInfo.promTotal-0) * i_pas_cnt;
						
						fareDiv.find('tr[ft-att="fare"]').append('<td>' + setPriceInput(faresum - promSaleFare) + '원</td>');
					}else{
						promSaleFare += (paxData.promInfo.promTotal-0) * i_pas_cnt;

						fareDiv.find('tr[ft-att="fare"]').append('<td>' + setPriceInput(faresum) + '원</td>');
					}
				}else{
					fareDiv.find('tr[ft-att="fare"]').append('<td>' + setPriceInput(faresum) + '원</td>');	
				}
				
				//TASF	20170327 엔진 추가
				var tasfsum = paxData.tasfCharge * i_pas_cnt;
				fareDiv.find('tr[ft-att="tasf"]').append('<td>' + setPriceInput(tasfsum) + '원</td>');

				//유류할증료 20170420 엔진 추가
				var fuelsum = 0; 
				
				if(nullToBlank(paxData.fuelSurcharge) != '') {
					fuelsum = paxData.fuelSurcharge * i_pas_cnt;
				} else {
					fuelsum = 0; 
				}	
						
				fareDiv.find('tr[ft-att="fuel"]').append('<td>' + setPriceInput(fuelsum) + '원</td>');
				
				//제세공과금
				var taxsum = paxData.taxCharge * i_pas_cnt;
				//var taxsum = (paxData.taxCharge - fuelsum)  * i_pas_cnt;
				fareDiv.find('tr[ft-att="tax"]').append('<td>' + setPriceInput(taxsum - fuelsum) + '원</td>');

				//프로모션할인
				/*
				if(paxData.promInfo != undefined){
					promSaleFare += (paxData.promInfo.promTotal-0) * i_pas_cnt;
				}
				*/

				if(promSaleFare > 0){
					fareDiv.find('tr[ft-att="promo"]').append('<td>' + setPriceInput(promSaleFare) + '원</td>');
				}else{
					fareDiv.find('tr[ft-att="promo"]').append('<td>0원</td>');
				}
				
				//총운임
				if(promSaleFare < 0){
					fareDiv.find('tr[ft-att="price"]').append('<td>' + setPriceInput((faresum + tasfsum + fuelsum + taxsum - promSaleFare)+'') + '원</td>');	
				}else{
					fareDiv.find('tr[ft-att="price"]').append('<td>' + setPriceInput((faresum + tasfsum + fuelsum + taxsum)+'') + '원</td>');
				}
				
				
				//전체운임 계산
				totFare += faresum + tasfsum + taxsum;
				
				if(promSaleFare != 0){
					totFare = totFare - promSaleFare; 
				}
			}
		}

		//전체운임 계산
		detail_pop.find('#totFare').text(setPriceInput(totFare+'') + '원');

		// 항공 총 결제금액 확인 
		detail_pop.find('#air_totFare').text(setPriceInput(totFare+'') + '원');
		detail_pop.find('#air_amt').val(totFare);
		detail_pop.find('.sub_amt').change();

		// 호텔 결제금액 확인 HIDE 처리
		// detail_pop_find("#hotel_totFare_div").hide();

		// 렌트카 결제금액 확인 HIDE 처리
		// detail_pop_find("#rentcar_totFare_div").hide();

		// 총 결제금액 확인 
		// detail_pop.find('#pay_totFare').text(setPriceInput(totFare+'') + '원');

	}
	
	function getWeeks(col) {
		var dayName=new Array("일", "월", "화", "수", "목", "금", "토"); // 숫자 요일을 문자 요일 바꿀 함수		
		return dayName[col];
	}


	// 팝업 > 요금규정, 상세보기 팝업 호출시 넘겨줄 데이터 세팅
	function fn_setAvailData_pop() {
		
		// var ar_cnt = $(_obj).parents('[ft-att="fare_list"]').attr('ar-cnt');
		var avail_info = JSON.parse(sessionStorage.airSelData);
		// console.log(avail_info);
		var gdsCd = sessionStorage.airSelGdsCd;
		var pax_info = JSON.parse(sessionStorage.airSearchVal).bodyDto;	
		
		cdata= {
			"gdsCd"		: gdsCd,		
			"availTy"	: pax_info.availTy,	
			"adtCnt"	: pax_info.adtCnt,		
			"chdCnt"	: pax_info.chdCnt,		
			"infCnt"	: pax_info.infCnt,
			"fmsKey"	: avail_info.fmsKey
		};
		
		cdata.segmentGroup = [];

	
		for(var seg_idx=0; seg_idx<avail_info[0].segmentGroup.length; seg_idx++) {
			var availData = avail_info[0].segmentGroup[seg_idx];
			cdata.segmentGroup[seg_idx] = {
				"availNo"	: availData.availNo,
				"segNo"		: availData.segNo,
				"depCd"		: availData.depCd,
				"fltEquip"	: availData.fltEquip,
				"arrCd"		: availData.arrCd,
				"arrTm"		: availData.arrTm,
				"arrDt"		: availData.arrDt,
				"fltNo"		: availData.fltNo,
				"bookingClas": availData.bookingClas,
				"depDt"		: availData.depDt,
				"carrierCd"	: availData.carrierCd,
				"depTm"		: availData.depTm
			};		
		}
		

		return cdata;
	}

	//날짜 format 맞추기
	function strDateFormat(str){
		if((str+"").length == 1) str = "0" + str;
		return str;				
	}


	//상세보기 결과값을 fltData에 담는다
	function fn_setDetailData(_data){
		// air_fix_data.fltData 에 조회한 상세정보를 입력한다.

		var l_fixData = JSON.parse(sessionStorage.airSelData);
			
		// API 조회 데이터set
		var apiData = _data;
		apiFlightData = apiData.flightInfo;
		var apiPriceData = apiData.pricing.data;
		
		var l_fltData = l_fixData.fltData;
		
		// 비행 시간 입력
		for ( var f_idx = 0; f_idx < l_fltData.length; f_idx++) {
			if (!apiFlightData[f_idx]) {
				var f_fltTm = apiFlightData[f_idx].data.durationTm;
				if (f_fltTm.length > 2) {
					l_fltData[f_idx].interval = f_fltTm.substring(0, 2) + '시간 '
							+ f_fltTm.substring(2, 4) + '분';
				}
			}
		}
		// console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		// console.log(apiPriceData);
		// console.log("apiPriceData[0].fuelCharge : " + apiPriceData[0].fuelCharge);
		// console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		/** 요금정보 업데이트 */
		var l_fixPaxDataArr = l_fixData.paxDataBean;

		if (apiPriceData.length > 0) {

			for ( var p_idx = 0; p_idx < apiPriceData.length; p_idx++) {
				var f_paxData = apiPriceData[p_idx];
				var f_paxTy = f_paxData.paxTy;

				for ( var fp_idx = 0; fp_idx < l_fixPaxDataArr.length; fp_idx++) {
					var l_fixPaxData = l_fixPaxDataArr[fp_idx];

					if (l_fixPaxData.paxTy == f_paxTy) {
						var i_fareCharge = f_paxData.fareCharge - 0;
						var i_sellCharge = f_paxData.sellCharge - 0;
						var i_fuelChare = f_paxData.fuelCharge - 0;

						l_fixPaxData.fuelCharge = i_fuelChare;
						l_fixPaxData.fareCharge = i_fareCharge;
						l_fixPaxData.taxCharge = i_sellCharge - i_fareCharge - i_fuelCharge;

						// 프로모션 추가 20170420
						l_fixPaxData.aplPromTotal = f_paxData.aplPromTotal-0;
						l_fixPaxData.promTotal = f_paxData.promTotal-0;
						l_fixPaxData.promId = f_paxData.promId;
					}
				}
			}
		}

		l_fixData.retDYn = 'Y';	//상세 조회 여부 추가
	}
	
	
	//선택 호텔 정보
 	function fn_selHotelInfo(length) {
		
	 	/**** roomtype 에 따른 정보는 수정 해야 한다.*///	
	
 		var size = length;
	 
 		var basketData = JSON.parse(sessionStorage.hotelBasketData);
		
		console.log(basketData);
		
		if(basketData == undefined || basketData == null || basketData == '[]' || basketData == '{}') { 
			$("#hotel_cart_div").hide();
			$("#hotel_nocart_div").show();
			
		} else {
		
			var htlPriceTemp = 0;
			var vHtml = '';
			//console.log(">>>>>[fn_selHotelInfo] size=" + size);
			
			if(size > 0) {
				var cnt = 0;  //호텔추가 버튼 보이질 말지..
				var total = 0;
				var ijwdiscnt = 0;
				var promTotal = 0;
				for(var i=0; i < size; i++) {
					//임직원 관련
					var custchk = basketData[i].setRoomData[0].custChk;
					var cancelPolicy='';
					var htlPrice = 0;
					var htlPrices = 0;
					
					if(custchk == "그룹직원"){
						total += Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].bfTotal));
						htlPrices = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].bfTotal));
					} else {
						total += Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].jtbTotal));
						htlPrices = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].jtbTotal));
					}
					var roomTypeCd = basketData[i].setRoomData[0].roomTypeDesc; 
					var nightDay = basketData[i].htlInfo.day.split("박");
					var exchangeRate = parseFloat(basketData[i].exchangeRate);
					
					var subchargeTotal = '';
					
					if(nullToBlank(basketData[i].setRoomData[0].rateInfos[0].surchargeTotal) == '' || basketData[i].setRoomData[0].rateInfos[0].surchargeTotal == '0') 
						subchargeTotal = '';
					else
						subchargeTotal = Math.ceil(exchangeRate * parseFloat(basketData[i].setRoomData[0].rateInfos[0].surchargeTotal));
					
					var day = '';
					
					if(basketData[i].htlInfo.day.indexOf('박') > 0) day = basketData[i].htlInfo.day;
					else
						day = basketData[i].htlInfo.day + '박';
					
					
					var salesTax = basketData[i].setRoomData[0].rateInfos[0].salesTax;
					var salesTaxT = 0;
					
					if(salesTax == "" || salesTax == "0") salesTaxT = 0;  
					else salesTaxT = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].salesTax));
									
					//var jtbTotal = parseInt(exchangeRate * basketData[i].setRoomData[0].rateInfos[0].jtbTotal);
					var roomCnt = basketData[i].htlInfo.stayinfo.roomcnt;

					if(basketData[i].setRoomData[0].rateInfos[0].jtbTotal != '') {
						//if(basketData[i].suplrCd == 'WHC') { //호텔패스인 경우만 호텔패스 환율적용해야 한다.
						//	htlPrice = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].jtbTotal));
						//}else {
							var promInfoData = basketData[i].setRoomData[0].rateInfos[0].promInfo;
							console.log(promInfoData);
						
							if(promInfoData != null && nullToBlank(promInfoData.aplPromTotal) != '' && custchk != "그룹직원") {
								//프로모션 적용가
								if(promInfoData.aplPromTotal > 0){
									htlPrice = Math.ceil(parseFloat(promInfoData.aplPromTotal));
									promTotal += (htlPrices-htlPrice);
									$("#prom_toFare").show();
									$('#pro_discnt').text(comma(promTotal) + "원");
								} else{
									htlPrice = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].jtbTotal));
								}
							} else if(custchk == "그룹직원") {
								htlPrice = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].bfTotal));
								ijwdiscnt += Math.ceil(basketData[i].setRoomData[0].rateInfos[0].bfTotal - basketData[i].setRoomData[0].rateInfos[0].jtbTotal);
								$("#prom_toFare").hide();
								$("#ijw_toFare").show();
								$('#ijw_discnt').text(comma(ijwdiscnt) + "원");								
							} else {
								htlPrice = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].jtbTotal));
							}
						//}
					}
						
					var cancelJtbDl = basketData[i].setRoomData[0].rateInfos[0].cancelJtbDl;
					//var jtbCancelDt = basketData[i].setRoomData[0].rateInfos[0].jtbCancelDt;
				   	//var jtbCancelTm = basketData[i].setRoomData[0].rateInfos[0].jtbCancelTm;
					
					
					if(salesTaxT == 0) salesTax ="";
					else salesTax = "(Sales Tax" + " " + comma(salesTaxT) + "원 포함 )";
					
					//조식 포함 여부
					var roomIsBreakfast = basketData[i].setRoomData[0].isBreakFast;
					if(roomIsBreakfast == 'Y')
						roomIsBreakfast = ' / ' + '조식 포함';
					else
						roomIsBreakfast = ' / ' + '조식 불포함';
					
					
					if(cancelJtbDl =='환불불가')  cancelPolicy = '환불불가';
					else
					cancelPolicy = cancelJtbDl;//jtbCancelDt +  "   " + jtbCancelTm + " 까지 무료 취소";
					//호텔운임료
					
					
					var adultnumber = basketData[i].htlInfo.stayinfo.adultnumber;
					var childnumber = basketData[i].htlInfo.stayinfo.childnumber;
					
					var htlInfo = "객실" + roomCnt + " / 성인" + adultnumber + "명, 아동"  +  childnumber + "명";
								
					vHtml += "	<dt>호텔" + (i+1) + ""
					vHtml += "		<button type='button' onclick='fn_htlSelectDel(" + i + ")'>삭제</button>"
					vHtml += "	</dt>"
					vHtml += "	<dd>"
					vHtml += "  	<table class='pop_table1 pop_table2_left pop_table2_vm'>"
					vHtml += "			<colgroup>";
					vHtml += "				<col style='width:17%'>";
					vHtml += "				<col style='width:auto'>";
					vHtml += "			</colgroup>";
					vHtml += "  		<thead>"
					vHtml += "  			<tr>"
					vHtml += "  				<th colspan='2'>" + basketData[i].htlName + "</th>"
					vHtml += "  			</tr>"
					vHtml += " 		 </thead>"
					vHtml += "  	 <tbody>"
					vHtml += "  		 <tr>"
					vHtml += "        		<th>투숙기간</th>"
					vHtml += "				<td>" +  basketData[i].htlInfo.checkinDate + "(" + basketData[i].htlInfo.checkinDay + ") ~ " +  basketData[i].htlInfo.checkoutDate + "(" + basketData[i].htlInfo.checkoutDay + ")"  + " " + day + "</td>"
					vHtml += "      	</tr>"
					vHtml += " 			<tr>"
					vHtml += "     			<th>객실상태</th>"
					vHtml += "				<td>"
					vHtml += "        			<p class='purple2'>즉시확정</p>"
					vHtml += "					<p>" + roomTypeCd + roomIsBreakfast + "</p>"
					vHtml += "					<p>" + htlInfo + "</p>"
					vHtml += "				</td>"
					vHtml += "			</tr>"
					vHtml += " 			<tr>"
					vHtml += "				<th>취소규정</th>"
					vHtml += " 				<td class='f_purple'>" + cancelPolicy + "</td>"
					vHtml += "			</tr>"
					
					//console.log("공급사=" + basketData[i].setRoomData[0].suplrCd + ",basketData[i].suplrCd=" + basketData[i].suplrCd);
					
					if(basketData[i].setRoomData[0].suplrCd == "EAN" && subchargeTotal != '') {	
						vHtml += " 			<tr>"
						vHtml += "				<th>세금 및 수수료</th>"
						vHtml += " 				<td class='tr'><span class='f_purple'>" + setPriceInput(subchargeTotal) + "원 " + salesTax + "</span></td>"
					}
					vHtml += "			</tr>"

					if(promInfoData.aplPromTotal > 0 && custchk != "그룹직원"){
						vHtml += "			<tr>"
						vHtml += "				<th>총 숙박료(TAX, 봉사료 포함)</th>"
						vHtml += "				<td class='tr'><span class='f_purple'>" + setPriceInput(htlPrices) + "</span> 원</td>"
						vHtml += "			</tr>"

						vHtml += "			<tr>"
						vHtml += "				<th>자유여행 프로모션</th>"
						vHtml += "				<td class='tr'><span class='f_red'>" + setPriceInput(htlPrices-htlPrice) + "</span> 원</td>"
						vHtml += "			</tr>"
						$("#pro_amt").val(promTotal);
						
					}
					if(custchk == "그룹직원"){
						vHtml += "			<tr>"
						vHtml += "				<th>롯데임직원 할인가</th>"
						vHtml += "				<td class='tr'><span class='f_red'>" + setPriceInput(Math.ceil(basketData[i].setRoomData[0].rateInfos[0].bfTotal - basketData[i].setRoomData[0].rateInfos[0].jtbTotal)) + "</span> 원</td>"
						vHtml += "			</tr>"
						$("#ijw_amt").val(ijwdiscnt);
					}
					
						vHtml += "			<tr>"
						vHtml += "				<th>호텔 총 요금</th>"
						vHtml += "				<td class='tr'><span class='f_purple'>" + setPriceInput(htlPrice) + "</span> 원</td>"
						vHtml += "			</tr>"
					
					
					vHtml += "	 	 </tbody>"
					vHtml += "	  </table>"
					vHtml += "	</dd>"
					
					$('#sel_hotel_info').html(vHtml);
					
					htlPriceTemp += parseInt(htlPrice); 
					//console.log(">>>>>htlPriceTemp=" + parseFloat(htlPriceTemp));
					//총 호텔 운임
// 					$("#hotel_totFare").text(setPriceInput(htlPriceTemp) + "원");
// 					$("#hotel_amt").val(htlPriceTemp);
					$("#hotel_totFare").text(setPriceInput(total) + "원");
					$("#hotel_amt").val(total);
					setTimeout(function(){				
						$(".sub_amt").change();
					}, 50);
					
					
					//호텔 버튼 추가 노출 건 관련
					if((nullToBlank(selConcMix) != '' && selConcMix != 'XHX') && cancelJtbDl == '환불불가') {
						cnt++;
					} 
					console.log("cnt=" + cnt);
				}
				//환불불가 상품이 하나도 없으면
				//if(nullToBlank(selConcMix) == '') {
				//	if(cnt > 0)
				//		$('#btn_hotel_only_div').hide();
				//	else {
				//		if(cancelJtbDl == '환불불가')  //환불불가가 있으면 
				//			$('#btn_hotel_only_div').hide();
				//		else
				//			$('#btn_hotel_only_div').show();
				//	}
				//} else {
					if(nullToBlank(selConcMix) != '') {
						if(selConcMix == 'XHX')  //호텔 단품
							$('#btn_hotel_only_div').hide();
						else {
							if(cnt > 0)
								$('#btn_hotel_only_div').hide();
							else 
								$('#btn_hotel_only_div').show();
						}
					}
				//}
				 
			}
		}
	}
	

	// 장바구니 화면에서  호텔 스케쥴 삭제 
	function fn_htlSelectDel(idx) {
		setConfirm("선택상품을 삭제하시겠습니까?", function() {
			var roomData = JSON.parse(sessionStorage.hotelBasketData);
					
			//패키지 상품인경우
			if(roomData[idx].suplrCd == 'EAN' && selConcMix != 'XHX') {
				pkgSavingsAmount = roomData[idx].setRoomData[0].rateInfos[0].pkgSavingsAmount;
				if(nullToBlank(pkgSavingsAmount) != '') {
					pkgPrice -= Math.ceil(parseFloat(pkgSavingsAmount));
					$('#pkg_discnt').text(comma(pkgPrice) + "원");
					
				}
			} 
			
			//삭제
			var nightDay = roomData[idx].htlInfo.day.split("박");
			var exchangeRate = roomData[idx].exchangeRate;
			var subchargeTotal = parseInt(exchangeRate * roomData[idx].setRoomData[0].rateInfos[0].surchargeTotal);
			var salesTax = parseInt(exchangeRate * roomData[idx].setRoomData[0].rateInfos[0].salesTax);
			//var jtbTotal = parseInt(exchangeRate * roomData[idx].setRoomData[0].rateInfos[0].jtbTotal);
			var roomCnt = roomData[idx].htlInfo.stayinfo.roomcnt;
			var removePirce = 0;
			
			if(roomData[idx].setRoomData[0].rateInfos[0].jtbTotal != '') {
				if(roomData[idx].suplrCd == 'WHC')  //호텔패스
					removePirce = Math.ceil(parseFloat(roomData[idx].setRoomData[0].rateInfos[0].jtbTotal));  //호텔료
				else
					//removePirce = parseInt(parseFloat(exchangeRate) * parseFloat(roomData[idx].setRoomData[0].rateInfos[0].jtbTotal));
					removePirce = Math.ceil(parseFloat(roomData[idx].setRoomData[0].rateInfos[0].jtbTotal));
			}
			
			roomData.splice(idx,1);
			
			sessionStorage.hotelBasketData = JSON.stringify(roomData);
			
			console.log(">>>>>>>=" + roomData.length);
			
			if(roomData.length > 0){
				fn_selHotelInfo(roomData.length);
				
				var htlSaleTot = 0;
				var mstMaxSale = 0;
				
				promoList.htlProm.splice(idx, 1);
				$("#htlPromArea").remove();
				$("#mstPromArea").remove();
				
				for(var h = 0; h < promoList.htlProm.length; h++){
					if(nullToBlank(promoList.htlProm[h]) != ""){
						htlSaleTot += parseInt(promoList.htlProm[h].saleAmt);
					}
				}
				
				var vHTML = "";
				if(htlSaleTot != 0){
					vHTML += '<p class="ppred" id="htlPromArea">';
					vHTML += '	호텔 프로모션 <span>-'+ comma(htlSaleTot) +'원</span>';
					vHTML += '	<input type="hidden" class="sub_amt promo_amt_class" data-sign="-" value="'+ htlSaleTot +'" />';
					vHTML += '</p>';
				}
				
				var otherSaleTot = parseInt(removePirce) + parseInt(htlSaleTot);
				
				if(nullToBlank($("#airPromArea").find(".sub_amt").val()) != ""){
					otherSaleTot += $("#airPromArea").find(".sub_amt").val();
				}
				
				for(var m = 0; m < promoList.mstProm.length; m++){
					if(nullToBlank(promoList.mstProm[m]) != ""){
						var thisSale = 0;
						
						if(promoList.mstProm[m].saleDivi == 'R'){
							thisSale = ($("#pay_totFare").data('amt') - otherSaleTot) * promoList.mstProm[m].saleAmt;
						}else{
							thisSale = promoList.mstProm[m].saleAmt
						}
						
						if(mstMaxSale < thisSale){
							mstMaxSale = thisSale;
							mstMaxIndex = m;
						}
					}
				}
				
				//console.log(otherSaleTot);
				
				mstMaxSale = Math.floor(mstMaxSale);
				
				if(mstMaxSale != 0){
					vHTML += '<p class="ppred" id="mstPromArea" data-conc="'+ promoList.mstProm[mstMaxIndex].concMix +'">';
					vHTML += '	'+ promoList.mstProm[mstMaxIndex].promNm +'<span>-'+ comma(mstMaxSale) +'원</span>';
					vHTML += '	<input type="hidden" class="sub_amt promo_amt_class" data-sign="-" value="'+ mstMaxSale +'" />';
					vHTML += '	<input type="hidden" id="promId" value="'+ promoList.mstProm[mstMaxIndex].promId +'" />';
					vHTML += '	<input type="hidden" id="promAmount" value="'+ promoList.mstProm[mstMaxIndex].saleAmt +'" />';
					vHTML += '	<input type="hidden" id="promDivi" value="'+ promoList.mstProm[mstMaxIndex].saleDivi +'" />';
					vHTML += '</p>';
				}

				
				$("#promo_fee").append(vHTML);
				
				$(".sub_amt").change();
			} else {
				closePopup();		
			}
			$(".radioboxs").removeClass('on');
		}, function(){
			return false;
		}, "알림", "확인", "취소");
	}
	
	
	function fn_goHtlSearch() {
		var thisStepParam = '';

		thisStepParam = '?selAir='+ $("#selAir").val() +'&selHotel='+ $("#selHotel").val() +'&selRentcar='+ $("#selRentcar").val();
		document.location.href='/free/search_result_hotel.do' + thisStepParam + '&type=hotel';
	
	}
	
	var fn_addRentCar = function(){
		var thisStepParam = '';
		thisStepParam = '?selAir='+ $("#selAir").val() +'&selHotel='+ $("#selHotel").val() +'&selRentcar='+ $("#selRentcar").val();
		movePage('/free/search_result_rentcar.do' + thisStepParam + '&type=rentcar');
		//movePage('/free/main.do?tabType=rent&remainYN=Y');
	}
	
	var fn_delSelRentalcar = function(index){
		setConfirm("선택상품을 삭제하시겠습니까?", function(){
				var selRentalCarInfo = JSON.parse(sessionStorage.rentcarSelData);
				var removeAmt = (selRentalCarInfo[index].estimatedTotalAmt * selRentalCarInfo[index].exchangeVal).toFixed()
				
				selRentalCarInfo.splice(index, 1);
				sessionStorage.rentcarSelData = JSON.stringify(selRentalCarInfo);
				
				if(selRentalCarInfo.length > 0){
					fn_rentcalRraw('del', removeAmt);
				}else{
					closePopup();
				}
				
				setAlert("정상적으로 처리되었습니다.");
			}, function(){
				return false;
			}, "알림", "확인", "취소");
	}
	
	var fn_rentcalRraw = function(type, removeAmt){
		var rentHTML = "";
		var selRentalCarInfo = JSON.parse(sessionStorage.rentcarSelData);
		var rentalcarTot = 0;
		
		if(selRentalCarInfo.length == 0){
			rentHTML += "<dd class='tc'>";
			rentHTML += "	<p class='nodata'>선택된 내용이 없습니다.</p>";
			rentHTML += "	<div class='pop_btn_one mb10'><button class='purple2' data-role='none' onclick='fn_addRentCar();' id='rntRsv' style='display:none'>렌터카 예약하기</button></div>";
			rentHTML += "</dd>";
			
			$("#rentalcar_div").html(rentHTML);
			$("#rentcar_totFare").html(comma(rentalcarTot) +'원');
			$("#rentcar_amt").val(rentalcarTot);
			
			setTimeout(function(){				
				$(".sub_amt").change();
			}, 50);
		}else{
			for(var i = 0; i < selRentalCarInfo.length; i++){				
				var takeYear = selRentalCarInfo[i].searchTakeDate.substring(0, 4);
				var takeMonth = selRentalCarInfo[i].searchTakeDate.substring(4, 6);
				var takeDay = selRentalCarInfo[i].searchTakeDate.substring(6, 8);
				
				var returnYear = selRentalCarInfo[i].searchReturnDate.substring(0, 4);
				var returnMonth = selRentalCarInfo[i].searchReturnDate.substring(4, 6);
				var returnDay = selRentalCarInfo[i].searchReturnDate.substring(6, 8);
				
				var carTakeDt = takeYear + "." + takeMonth + "." + takeDay;
				var carTakeTime = selRentalCarInfo[i].searchTakeTime.substring(0, 2) +":"+ selRentalCarInfo[i].searchTakeTime.substring(2, 4);
				var carReturnDt = returnYear + "." + returnMonth + "." + returnDay;
				var carTakeTime = selRentalCarInfo[i].searchReturnTime.substring(0, 2) +":"+ selRentalCarInfo[i].searchReturnTime.substring(2, 4);
				
				var takeDate = new Date(takeYear, parseInt(takeMonth) - 1, takeDay);
				var takeNumday = getWeeks(takeDate.getDay());
				var returnDate = new Date(returnYear, parseInt(returnMonth) - 1, returnDay);
				var returnNumday = getWeeks(returnDate.getDay());
				
				if(i == 0){
					rentHTML += '<dl class="pop_info_list">';
				}else{
					rentHTML += '<dl class="pop_info_list pop_selinfobox">';
				}
				
				rentHTML += '<dt>렌터카'+ (i + 1) +'<button type="button" onclick="fn_delSelRentalcar('+ i +')">삭제</button></dt>';
				rentHTML += '<dd>';
				rentHTML += '	<ul class="lc_acodion_info">';
				if(i == 0){
					rentHTML += '		<li class="on"><div>';	
				}else{
					rentHTML += '		<li><div>';
				}
				rentHTML += '			<span>'+ selRentalCarInfo[i].carNm.replace('OR SIMILAR', '') +'</span>';
				if(selRentalCarInfo[i].carNm.indexOf('OR SIMILAR') > -1){
					rentHTML += '			<span>OR SIMILAR</span>';
				}else{
					rentHTML += '			<span></span>';
				}
				rentHTML += '			</div>';
				rentHTML += '			<p>'+ carSize[selRentalCarInfo[i].carSize] +'</p></li>';
				rentHTML += '		<li>';
				rentHTML += '			<ul>';
				rentHTML += '				<li>승객수 : '+ selRentalCarInfo[i].passengerCnt +'명</li>';
				rentHTML += '				<li>수화물 개수 : '+ selRentalCarInfo[i].baggageCnt +'개</li>';
				if(selRentalCarInfo[i].airCondition == "true"){
					rentHTML += '				<li>에어컨 : 있음</li>';
				}else{
					rentHTML += '				<li>에어컨 : 없음</li>';
				}
				
				if(selRentalCarInfo[i].transType == "Automatic"){
					rentHTML += '				<li>변속기 : 자동</li>';
				}else{
					rentHTML += '				<li>변속기 : 수동</li>';
				}
				rentHTML += '				<li>연료 : '+ fuelType[selRentalCarInfo[i].fuelType] +'</li>';
				rentHTML += '				<li>연비 : '+ selRentalCarInfo[i].furateKpl +'km/리터</li>';
				if(selRentalCarInfo[i].dualAbagYn == "Y"){
					rentHTML += '				<li>에어백 : 듀얼 에어백</li>';
				}else if(selRentalCarInfo[i].abagYn == "Y"){
					rentHTML += '				<li>에어백 : 장착</li>';
				}else{
					rentHTML += '				<li>에어백 : 미장착</li>';
				}
				if(selRentalCarInfo[i].unlimited == "true"){
					rentHTML += '				<li>주행거리제한 : 무제한</li>';
				}else{
					rentHTML += '				<li>주행거리제한 : '+ selRentalCarInfo[i].distQuantiy +" "+ selRentalCarInfo[i].distUnitNm +'</li>';	
				}
				rentHTML += '			</ul>';
				rentHTML += '		</li>';
				rentHTML += '	</ul>';
				rentHTML += '	<table class="pop_table3 pop_table3_left">';
				rentHTML += '		<tr>';
				rentHTML += '			<th>차량 인수일</th>';
				rentHTML += '			<td>'+ carTakeDt +'('+ takeNumday +') '+ carTakeTime +'</td>';
				rentHTML += '		</tr>';
				rentHTML += '		<tr>';
				rentHTML += '			<th>차량 반납일</th>';
				rentHTML += '			<td>'+ carReturnDt +'('+ returnNumday +') '+ carTakeTime +'</td>';
				rentHTML += '		</tr>';
				rentHTML += '		<tr>';
				rentHTML += '			<th>인수 장소</th>';
				rentHTML += '			<td>'+ selRentalCarInfo[i].searchTakePlace +'</td>';
				rentHTML += '		</tr>';
				rentHTML += '		<tr>';
				rentHTML += '			<th>반납 장소</th>';
				rentHTML += '			<td>'+ selRentalCarInfo[i].searchReturnPlace +'</td>';
				rentHTML += '		</tr>';
				/*
				rentHTML += '		<tr>';
				rentHTML += '			<th colspan="2">추가 선택 사항</th>';
				rentHTML += '			<td>';
				rentHTML += '				<ul>';
				rentHTML += '					<li>승객수 : 4명</li>';
				rentHTML += '				</ul>';
				rentHTML += '			</td>';
				*/
				rentHTML += '		<tr>';
				rentHTML += '			<td colspan="2" style="color:#ff7878;background:#f6f6f8;text-align:center;">* 렌터카 추가사항은 현장에 장비를 보유한 경우 추가 할 수 있습니다. (추가비용 발생)</td>';
				rentHTML += '		</tr>';
				rentHTML += '		</tr>';
				rentHTML += '		<tr>';
				rentHTML += '			<th>렌터카 총 운임</th>';
				rentHTML += '			<td class="tr">'+ comma((selRentalCarInfo[i].estimatedTotalAmt * selRentalCarInfo[i].exchangeVal).toFixed()) +'원/ <span class="f_purple">'+ selRentalCarInfo[i].currency +' '+ comma(selRentalCarInfo[i].estimatedTotalAmt) +'</span></td>';
				rentHTML += '		</tr>';
				rentHTML += '	</table>';
				rentHTML += '</dd>';
				rentHTML += '</dl>';
				
				rentalcarTot += parseInt((selRentalCarInfo[i].estimatedTotalAmt * selRentalCarInfo[i].exchangeVal).toFixed());
			}
			
			rentHTML += '<div class="pop_btn_one mt7" style="margin-bottom:7px;"><button class="purple2" data-role="none" onclick="fn_addRentCar();">렌터카 추가</button></div>';
			
			$("#rentalcar_div").html(rentHTML);
			$("#rentcar_totFare").html(comma(rentalcarTot) +'원');
			$("#rentcar_amt").val(rentalcarTot);
			
			if(type == 'del'){
				$("#mstPromArea").remove();
				
				var otherSaleTot = parseInt(removeAmt);
				
				if(nullToBlank($("#airPromArea").find(".sub_amt").val()) != ""){
					otherSaleTot += parseInt($("#airPromArea").find(".sub_amt").val());
				}
				
				if(nullToBlank($("#htlPromArea").find(".sub_amt").val()) != ""){
					otherSaleTot += parseInt($("#htlPromArea").find(".sub_amt").val());
				}
				
				var mstMaxSale = 0;
				
				for(var m = 0; m < promoList.mstProm.length; m++){
					if(nullToBlank(promoList.mstProm[m]) != ""){
						var thisSale = 0;
						
						if(promoList.mstProm[m].saleDivi == 'R'){
							thisSale = ($("#pay_totFare").data('amt') - otherSaleTot) * promoList.mstProm[m].saleAmt;
						}else{
							thisSale = promoList.mstProm[m].saleAmt
						}
						
						if(mstMaxSale < thisSale){
							mstMaxSale = thisSale;
							mstMaxIndex = m;
						}
					}
				}
				
				mstMaxSale = Math.floor(mstMaxSale);
				
				var vHTML = "";
				if(mstMaxSale != 0){
					vHTML += '<p class="ppred" id="mstPromArea" data-conc="'+ promoList.mstProm[mstMaxIndex].concMix +'">';
					vHTML += '	'+ promoList.mstProm[mstMaxIndex].promNm +'<span>'+ comma(mstMaxSale) +'원</span>';
					vHTML += '	<input type="hidden" class="sub_amt promo_amt_class" data-sign="-" value="'+ mstMaxSale +'" />';
					vHTML += '	<input type="hidden" id="promId" value="'+ promoList.mstProm[mstMaxIndex].promId +'" />';
					vHTML += '	<input type="hidden" id="promAmount" value="'+ promoList.mstProm[mstMaxIndex].saleAmt +'" />';
					vHTML += '	<input type="hidden" id="promDivi" value="'+ promoList.mstProm[mstMaxIndex].saleDivi +'" />';
					vHTML += '</p>';
				}
				
				$("#promo_fee").append(vHTML);
			}
			
			setTimeout(function(){
				$(".pop_info_list .lc_acodion_info > li").off("click")
				$(".pop_info_list .lc_acodion_info > li").on("click", function(){
					$(this).toggleClass("on");
				});
				
				$(".sub_amt").change();
			}, 50);
		}
	}
	
	function closePopup() {
		var roomData = JSON.parse(sessionStorage.hotelBasketData);
		if(($("#selAir").val() == 'N' && $("#selHotel").val() == 'Y' && $("#selRentcar").val() == 'N')
				|| roomData.length == 0) { //호텔 갯수가 0인경우
			$('.hotel_radio_btn').each(function() {
				var dataIndex = $(this).data("index");
				var tag = '#chk_cusm' + dataIndex;
				$(tag).prop("checked", false);
			 });
			 
			sessionStorage.hotelSelData = JSON.stringify([]);
			sessionStorage.hotelBasketData = JSON.stringify([]);
			g_hotel_basket_data = [];
		}
		
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		
		$(".radioboxs").removeClass("on");
	}
	
	function getWeeks(col) {
		var dayName=new Array("일", "월", "화", "수", "목", "금", "토"); // 숫자 요일을 문자 요일 바꿀 함수		
		return dayName[col];
	}
	

	function fn_nextStep() {
		var thisStepUrl = location.pathname;
		var thisStepParam = "";
		try{
			thisStepParam = '?selAir='+ $("#selAir").val() +'&selHotel='+ $("#selHotel").val() +'&selRentcar='+ $("#selRentcar").val();
		}catch(e){}
		
		if(thisStepUrl == "/free/search_result_air.do"){
			if($("#selHotel").val() == 'Y'){
				movePage('/free/search_result_hotel.do'+ thisStepParam);
			}else if($("#selRentcar").val() == 'Y'){
				movePage('/free/search_result_rentcar_office.do'+ thisStepParam);
			}else{
				fn_selectComplete();
			}
		}else if(thisStepUrl == "/free/hotel_detail_hotel.do"){
			if($("#selRentcar").val() == 'Y'){
				movePage('/free/search_result_rentcar_office.do'+ thisStepParam);
			}else{
				fn_selectComplete();
			}
		}else if(thisStepUrl == "/free/search_result_rentcar.do"){
			fn_selectComplete();
		}
		
	}
	
	function fn_selectComplete(){
		var selectGoodsYn = false;
		
		if(nullToBlank(sessionStorage.airSelData) != "" && sessionStorage.airSelData != '[]'){
			selectGoodsYn = true;
		}
		
		if(nullToBlank(sessionStorage.hotelBasketData) != "" && sessionStorage.hotelBasketData != '[]'){
			selectGoodsYn = true;
			
			/* var data = JSON.parse(sessionStorage.hotelBasketData);
			var chkinMTemp=0;
			var chkoutMTemp=0;
						
			if(nullToBlank(data) != null && data.length > 0) {
				for(var i = 0; i < data.length; i++) {
				
					var chkDate = new Date(data[i].htlInfo.checkinDate);
					var chkinM = chkDate.getTime();
					var chkoutDate = new Date(g_hotel_basket_data[i].htlInfo.checkoutDate);
					var chkoutM = chkoutDate.getTime(); 
					
					console.log("checkin[" + i + "]=" + chkinM);
					console.log("checkout[" + i + "]=" + chkoutM);
					console.log("chkinMTemp[" + i + "]=" + chkinMTemp);
					console.log("chkoutMTemp[" + i + "]=" + chkoutMTemp);
										
					if(data.length > 1 && (chkinMTemp > 0 && chkoutMTemp > 0)) {
						
						//A.종료일자 >= B.시작일자 AND A.시작일자 <= B.종료일자 
						
						if(chkinM <= chkoutMTemp && chkinMTemp >= chkoutM) {
							alert('선택하는 호텔 날짜가 겹쳤습니다. 다른 날짜로 선택해주세요.');
							return false;
						}
						
						if(chkinM <= chkinMTemp && chkoutM >= chkoutMTemp) {
							alert('선택하는 호텔 날짜가 겹쳤습니다. 다른 날짜로 선택해주세요.');
							return false;
						}
						if(chkinM <= chkinMTemp && chkoutM <= chkoutMTemp) {
							alert('선택하는 호텔 날짜가 겹쳤습니다. 다른 날짜로 선택해주세요.');
							return false;
						}
						
						if(chkinM > chkinMTemp && chkoutM > chkoutMTemp) {
							alert('선택하는 호텔 날짜가 겹쳤습니다. 다른 날짜로 선택해주세요.');
							return false;
						}
						
						if(chkinM > chkinMTemp && chkoutM < chkoutMTemp) {
							alert('선택하는 호텔 날짜가 겹쳤습니다. 다른 날짜로 선택해주세요.');
							return false;
						}
					
					}
					chkinMTemp = chkinM;
					chkoutMTemp = chkoutM;
				
					
				}
			} */
		}
		
		if(nullToBlank(sessionStorage.rentcarSelData) != "" && sessionStorage.rentcarSelData != '[]'){
			selectGoodsYn = true;
		}
		
		var thisStepParam = "";
		try{
			thisStepParam = '?selAir='+ $("#selAir").val() +'&selHotel='+ $("#selHotel").val() +'&selRentcar='+ $("#selRentcar").val();
		}catch(e){}
		
		if(selectGoodsYn){
			setConfirm("선택하신 스케쥴로 예약 하시겠습니까?", function(){
				var airAmtTot = $("#air_amt").val();
				var htlAmtTot = $("#hotel_amt").val();
				var rntAmtTot = $("#rentcar_amt").val();
				var mstAmtTot = 0;
				var airPromAmtTot = 0;
				var htlPromAmtTot = 0;
				var rntPromAmtTot = 0;
				var mstPromAmtTot = 0;
				var fitPromAmtTot = $("#pro_amt").val();		//[JEH] 자유여행 프로모션 추가 - 20190228
				var ijwPromAmtTot = $("#ijw_amt").val();
				
				mstAmtTot = parseInt(airAmtTot) + parseInt(htlAmtTot) + parseInt(rntAmtTot);
				
				if(nullToBlank($("#airPromArea").find(".sub_amt").val()) != ""){
					airPromAmtTot = $("#airPromArea").find(".sub_amt").val();
				}
				if(nullToBlank($("#htlPromArea").find(".sub_amt").val()) != ""){
					htlPromAmtTot = $("#htlPromArea").find(".sub_amt").val();
				}
				if(nullToBlank($("#rntPromArea").find(".sub_amt").val()) != ""){
					rntPromAmtTot = $("#rntPromArea").find(".sub_amt").val();
				}
				if(nullToBlank($("#mstPromArea").find(".sub_amt").val()) != ""){
					mstPromAmtTot = $("#mstPromArea").find(".sub_amt").val();
				}

				var totAmtObj = {
					'airAmtTot'		: airAmtTot,
					'htlAmtTot'		: htlAmtTot,
					'rntAmtTot' 	: rntAmtTot,
					'mstAmtTot'		: mstAmtTot,
					'airPromAmtTot'	: airPromAmtTot,
					'htlPromAmtTot'	: fitPromAmtTot,
					'rntPromAmtTot'	: rntPromAmtTot,
					'mstPromAmtTot'	: mstPromAmtTot
				}
				
				sessionStorage.mstAmtList = JSON.stringify(totAmtObj);
				
				var url = escape('/free_reserve/reserve_info_step1.do'+ thisStepParam);
				
		 		if(custCd == null || custCd == '') {
					document.location.href = "/sso/freenologinPage.do?returnUrl=" + url;
					
				} else {
					movePage('/free_reserve/reserve_info_step1.do'+ thisStepParam);
				}
			}, function(){
			}, "선택완료", "확인", "취소")	
		}else{
			setAlert("상품을 선택해 주세요.", "선택확인");
		}
	}
	
	function fn_promSetting(param){
		var formData = new FormData();
		formData.append('PromotionParamVO', param);
		
		gfn_callAjax ('/promo/selectPromoAmt.do', param, 'successProm');
	}
	
	var promoList;
	function successProm(data){
		setTimeout(function(){
			var list = data.list;
			promoList = list;
			var mstMaxSale = 0;
			var mstMaxIndex;
			var airSaleTot = 0;
			var htlSaleTot = 0;
			
			for(var a = 0; a < list.airProm.length; a++){
				if(nullToBlank(list.airProm[a]) != ""){
					airSaleTot += parseInt(list.airProm[a].saleAmt);
				}
			}
			
			for(var h = 0; h < list.htlProm.length; h++){
				if(nullToBlank(list.htlProm[h]) != ""){
					htlSaleTot += parseInt(list.htlProm[h].saleAmt);
				}
			}
			
			var vHTML = "";
			
			setTimeout(function(){
				var otherSaleTot = parseInt(airSaleTot) + parseInt(htlSaleTot);
				
				for(var m = 0; m < list.mstProm.length; m++){
					if(nullToBlank(list.mstProm[m]) != ""){
						var thisSale = 0;
						
						if(list.mstProm[m].saleDivi == 'R'){
							thisSale = ($("#pay_totFare").data('amt') - otherSaleTot) * list.mstProm[m].saleAmt;
						}else{
							thisSale = list.mstProm[m].saleAmt
						}
						
						if(mstMaxSale < thisSale){
							mstMaxSale = thisSale;
							mstMaxIndex = m;
						}
					}
				}
				
				mstMaxSale = Math.floor(mstMaxSale);
				
				if(airSaleTot != 0){
					vHTML += '<p class="ppred" id="airPromArea">';
					vHTML += '	항공 프로모션 <span>-'+ comma(airSaleTot) +'원</span>';
					vHTML += '	<input type="hidden" class="sub_amt promo_amt_class" data-sign="-" value="'+ airSaleTot +'" />';
					vHTML += '</p>';
				}
				
				if(htlSaleTot != 0 && custChk != "그룹직원"){
					vHTML += '<p class="ppred" id="htlPromArea">';
					vHTML += '	호텔 프로모션 <span>-'+ comma(htlSaleTot) +'원</span>';
					vHTML += '	<input type="hidden" class="sub_amt promo_amt_class" data-sign="-" value="'+ htlSaleTot +'" />';
					vHTML += '</p>';
				}
				if(mstMaxSale != 0){
					vHTML += '<p class="ppred" id="mstPromArea" data-conc="'+ list.mstProm[mstMaxIndex].concMix +'">';
					vHTML += '	'+ list.mstProm[mstMaxIndex].promNm +'<span>-'+ comma(mstMaxSale) +'원</span>';
					vHTML += '	<input type="hidden" class="sub_amt promo_amt_class" data-sign="-" value="'+ mstMaxSale +'" />';
					vHTML += '	<input type="hidden" id="promId" value="'+ list.mstProm[mstMaxIndex].promId +'" />';
					vHTML += '	<input type="hidden" id="promAmount" value="'+ list.mstProm[mstMaxIndex].saleAmt +'" />';
					vHTML += '	<input type="hidden" id="promDivi" value="'+ list.mstProm[mstMaxIndex].saleDivi +'" />';
					vHTML += '</p>';
				}
				
				$("#promo_fee").html(vHTML);
				
				$(".sub_amt").change();
			}, 50);
		}, 100);
	}

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		// sessionStorage 에 airSelData 가 없는 경우 

		// console.log(sessionStorage.airSelData);
		// console.log(sessionStorage.hotelSelData);
		// console.log(sessionStorage.rentcarSelData);
		
		var selAirDataset;
		var selHtlDataset = [];
		var selAirYN = 'X';
		var selHtlYN = 'X';
		var selRntYN = 'X';
		var suplrCd = '';
		var pkgSavingsAmount;
		
		if(popMode == 'show'){
			$("#btn_air_only_div").hide();
			$("#btn_nolist_div").show();
		}else{
			$("#btn_air_only_div").show();
			$("#btn_nolist_div").hide();
		}
		
			
	 	if(sessionStorage.airSelData == undefined || sessionStorage.airSelData == null || sessionStorage.airSelData == '[]') {
			//alert("항공권을 선택해 주세요.");
			//closePopup();
	 		$("#air_cart_div").hide();
			$("#air_nocart_div").show();
			
		} else { 
			fn_detail();
			if(sessionStorage.airSelData != null) {
				airDataset = JSON.parse(sessionStorage.airSelData);
				
				selAirDataset = {
					'carrierCd' 	: airDataset[0].carrierCd,
					'cabin'			: airDataset[0].cabinClas,
					'gdsTyGb'		: airDataset[0].gdsCd,
					'coalCardGb'	: '',
					'amt'			: airDataset[0].totCharge
				}
				
				selAirYN = 'A';
				$("#air_cart_div").show();
				$("#air_nocart_div").hide();
				//$("#btn_air_only_div").show();
			} else {
				$("#air_cart_div").hide();
				$("#air_nocart_div").show();
			}
			//$("#btn_nolist_div").hide();
		} 

	 	//호텔의 경우
		if(sessionStorage.hotelBasketData == undefined || sessionStorage.hotelBasketData == null || sessionStorage.hotelBasketData == '[]' || sessionStorage.hotelBasketData == '{}') {
			$("#hotel_cart_div").hide();
			$("#hotel_nocart_div").show();
			
		} else {
			$("#hotel_nocart_div").hide();
			$("#hotel_cart_div").show();
			
			if($("#selAir").val() == 'N' && $("#selHotel").val() == 'Y' && $("#selRentcar").val() == 'N') { //호텔 단품인경우만
				$('#btn_hotel_only_div').hide();
			} else {
				$('#btn_hotel_only_div').show();
			}
			
			//선택 호텔정보
			var roomData = JSON.parse(sessionStorage.hotelBasketData);
			//console.log(roomData);
			console.log("roomData.length=" + roomData.length);
			if(roomData == 'undefined' || roomData == null || roomData == '[]') {}		
			else{
			
				htlDataList = JSON.parse(sessionStorage.hotelBasketData);
								
				for(var i = 0; i < htlDataList.length; i++){
					var htlPrice = 0;
					var nightDay = htlDataList[i].htlInfo.day.split("박");
					var exchangeRate = htlDataList[i].exchangeRate;
					var subchargeTotal = parseInt(exchangeRate * htlDataList[i].setRoomData[0].rateInfos[0].surchargeTotal);
					var salesTax = parseInt(exchangeRate * htlDataList[i].setRoomData[0].rateInfos[0].salesTax);
					//var jtbTotal = parseInt(exchangeRate * htlDataList[i].setRoomData[0].rateInfos[0].jtbTotal);
					var roomCnt = htlDataList[i].htlInfo.stayinfo.roomcnt;
				
					//var htlPrice = (parseInt(jtbTotal) * parseInt(nightDay[0]) * parseInt(roomCnt)) + parseInt(subchargeTotal);  //호텔료
					if(htlDataList[i].setRoomData[0].rateInfos[0].jtbTotal != '') {
						//if(htlDataList[i].suplrCd == 'WHC') { //호텔패스인 경우만 호텔패스 환율적용해야 한다.
						//	htlPrice = Math.ceil(parseFloat(htlDataList[i].setRoomData[0].rateInfos[0].jtbTotal));
						
						//} else {
							var promInfoData = htlDataList[i].setRoomData[0].rateInfos[0].promInfo;
							console.log(promInfoData);
							
							if(nullToBlank(promInfoData) != '') {
								//프로모션 적용가
								if(promInfoData.aplPromTotal > 0)
									htlPrice = Math.ceil(parseFloat(promInfoData.aplPromTotal));
								else
									htlPrice = Math.ceil(parseFloat(htlDataList[i].setRoomData[0].rateInfos[0].jtbTotal));		
							}
							else {
								htlPrice = Math.ceil(parseFloat(htlDataList[i].setRoomData[0].rateInfos[0].jtbTotal));
							}
						//}
							
					}
					
					var tempHtlDataset = {
						'targetId'		: 'htl_'+ i,
						'suplrId' 		: htlDataList[i].suplrCd,
						'htlNationCd' 	: htlDataList[i].countryCd,
						'htlCityCd' 	: htlDataList[i].cityCd,
						'htlCd' 		: htlDataList[i].hotelId,
						'coalCardGb'	: '',
						'amt' 			: htlPrice
					}
					
					selHtlDataset.push(tempHtlDataset);
					
					suplrCd = htlDataList[i].suplrCd;
					
					if(suplrCd == 'EAN') {
						pkgSavingsAmount = htlDataList[i].setRoomData[0].rateInfos[0].pkgSavingsAmount;
						//console.log('패키지 할인가=' + pkgSavingsAmount);
						if(nullToBlank(pkgSavingsAmount) != '') {
							$("#pkg_toFare").show();
							pkgPrice += Math.ceil(parseFloat(pkgSavingsAmount));
							$('#pkg_discnt').text(comma(pkgPrice) + "원");
							
						}
					}
				}
				selHtlYN = 'H';
				fn_selHotelInfo(roomData.length);
			}	
		}
	 	
	
		if(sessionStorage.rentcarSelData == undefined || sessionStorage.rentcarSelData == null || sessionStorage.rentcarSelData == '[]') {
			//$("#rentcar_nocart_div").hide();
			var rentHTML = "";
		
			rentHTML += "<dd class='tc'>";
			rentHTML += "	<p class='nodata'>선택된 내용이 없습니다.</p>";
			rentHTML += "	<div class='pop_btn_one mb10'><button class='purple2' data-role='none' onclick='fn_addRentCar();' id='rntRsv' style='display:none'>렌터카 예약하기</button></div>";
			rentHTML += "</dd>";
			
			$("#rentalcar_div").html(rentHTML)
		} else {
			//$("#rentcar_nocart_div").show();
			selRntYN = 'C';
			fn_rentcalRraw();
		}
		
		$(".sub_amt").change(function(){
			var totAmt = 0;
			
			$(".sub_amt").each(function(){
				if($(this).data("sign") == "+"){
					totAmt += parseInt($(this).val());	
				}else{
					totAmt -= parseInt($(this).val());
				}
			});
			
						
			selConcMix = ($("#selAir").val() == 'Y' ? 'A' : 'X') +
						 ($("#selHotel").val() == 'Y' ? 'H' : 'X') + 
						 ($("#selRentcar").val() == 'Y' ? 'C' : 'X');
			
			console.log("selConcMix=" + selConcMix);
			
			//패키지 할인금액이 있는 경우는 전체 상품가 표시
			if(selConcMix != 'XHX' && suplrCd == 'EAN') {
				if(nullToBlank(pkgSavingsAmount) != '') {
					//전체 상품가
					$('#total_totFare').show();
					$('#total_price').html(comma(totAmt)+"원");
				}
				
			} else {
				$('#total_totFare').hide();
				$('#pkg_toFare').hide();
			}
			
			totAmt  = totAmt - pkgPrice;  //패키지 할인가 ean
			
			$("#pay_totFare").html(comma(totAmt)+"원");
			$("#pay_totFare").attr('data-amt', totAmt);
		});
		
		var promParam = {
			'promMst'	: {
				'concMix' : selConcMix,
			},
			'promAir'	: selAirDataset,
			'promHtl'	: selHtlDataset 
		}
		
		fn_promSetting(promParam);
		
		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
		
		
		//호텔엔조이 호텔인경우
		var domestic = sessionStorage.domesticYn;
		if(domestic == 'Y') {
			$('#airRsv').hide();
			$('#rntRsv').hide();
		} else {
			$('#airRsv').show();
			$('#rntRsv').show();
		}
		
	});

</script>

<form name="f_frm" id="f_frm" method="post">
	<input type="hidden" name="selAir" id="selAir"  value="${selAir}" />
	<input type="hidden" name="selHotel" id="selHotel" value="${selHotel}" />
	<input type="hidden" name="selRentcar" id="selRentcar" value="${selRentcar}" />
</form>	
<div class='layerPopup' ft-att='air_detail_pop'>
	<div class='layerPop'>
		<!-- 내용시작 -->
		<div class='popCon'>
			<div class='popHead'>
				<div class='popTpart'>
					<strong class='popTitle'>선택확인</strong>
					<button type='button' class='layerClose' onclick="closePopup();">
						<img src='/resources/images/btn/btn_exit.png' alt='레이어 닫기'>
					</button>
				</div>
			</div>
			
			<!-- 항공 장바구니 내역 -->
			<div class='cntain pop_secokbox' id='cart_div' name='cart_div'>				
				<p class='pop_avtitle'>선택 항공 정보</p>
				<!-- 항공은 한개만 담을 수 있음 -->
				<div id='air_cart_div' name='air_cart_div'>
					<dl class='pop_info_list'>
						<dt>
							항공
							<button type='button' onClick='fn_reSelect()'>삭제</button>
						</dt>
						<dd>
							<!-- 간략표 -->
							<div class='stable_guide2' id='air_summary' name='air_summary'>
							</div>
							
							<!-- 항공 스케쥴 -->
							<div id='air_schd' name='air_schd'>
							</div>
							<!-- 요금표 -->
							<div class='pop_payinfobox pop_selinfobox' id='air_price_detail' name='air_price_detail'>
							</div>	
						</dd>
					</dl>
				</div>
				<!-- 장바구니 항공이 없는 경우 -->
				<div id='air_nocart_div' name='air_nocart_div'>
				<!-- <p class='pop_avtitle'>선택 항공 정보</p> -->
					<dl class='pop_info_list pop_chk_list2'>
						<!-- dt>항공</dt  -->
						<dd class='tc'>
							<p class='nodata'>선택된 내용이 없습니다.</p>
							<div class='pop_btn_one mb10'><button class='purple2' data-role='none' id='airRsv' style='display:none'>항공권 예약하기</button></div>
						</dd>
					</dl>
				</div>
				<!-- 장바구니 호텔이 있는 경우 -->
				<div class="cntain pop_secokbox" id="hotel_cart_div" name="hotel_cart_div" style="display:none">
					<p class="pop_htvtitle">선택 호텔 정보</p>
					<dl class="pop_info_list" id="sel_hotel_info" name="sel_hotel_info">
						<!-- <dt>
							호텔1
							<button type="button" onclick="fn_selectDel()">삭제</button>
						</dt>
						<dd>
							<table class="pop_table1 pop_table2_left">
								<thead>
									<tr>
										<th colspan="2">방콕 샹그릴라 호텔</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th>투숙기간</th>
										<td>2016.11.07(월) ~ 2016.11.09(수) 2박</td>
									</tr>
									<tr>
										<th>객실</th>
										<td>
											<p class="purple2">바로확정</p>
											<p>Deluxe Room 조식포함</p>
											<p>객실 2 / 성인 3명, 아동 2명, 유아 0명</p>
										</td>
									</tr>
									<tr>
										<th>합계</th>
										<td class="f_purple">2016.11.01 16:00까지 무료</td>
									</tr>
									<tr>
										<th>총 운임</th>
										<td class="tr"><span class="f_purple">764,400</span> 원</td>
									</tr>
								</tbody>
							</table>
						</dd> -->
					</dl>
				</div>
				
				<div class="pop_btn_one mb10" id="btn_hotel_only_div" name="btn_hotel_only_div" style="display:none">
					<button class="purple2" data-role="none" onclick="fn_goHtlSearch();">호텔 추가</button>
				</div>
				
							
				<!-- 장바구니 호텔이 없는 경우 -->
				<div id='hotel_nocart_div' name='hotel_nocart_div'>
					<p class='pop_htvtitle'>선택 호텔 정보</p>
					<dl class='pop_info_list pop_chk_list2'>
						<!-- dt>호텔</dt  -->
						<dd class='tc'>
							<p class='nodata'>선택된 내용이 없습니다.</p>
							<div class='pop_btn_one mb10'><button class='purple2' data-role='none' onclick='fn_goHtlSearch()'> 호텔 예약하기</button></div>
						</dd>
					</dl>
				</div>
				<!-- 장바구니 렌트카가 없는 경우 -->
				<div id='rentcar_nocart_div' name='rentcar_nocart_div'>
				
					<p class='pop_lcvtitle'>선택 렌터카 정보</p>
					<div id="rentalcar_div">
					</div>
				</div>

				<!-- 결제금액확인 -->
				<dl class='pop_chk_list pop_chk_list2'>
					<dt class='pop_avtitle2'>결제금액확인</dt>
					<dd class='pop_paytext1'>
						<p id='air_totFare_div' name='air_totFare_div'>
							항공 <span id='air_totFare' name='air_totFare'>0원</span>
							<input type="hidden" class="sub_amt" id="air_amt" data-sign="+" value="0" />
						</p>
						<p id='hotel_totFare_div' name='hotel_totFare_div'>
							호텔 <span id='hotel_totFare' name='hotel_totFare'>0원</span>
							<input type="hidden" class="sub_amt" id="hotel_amt" data-sign="+" value="0" />
						</p>
						<p id='rentcar_totFare_div' name='rentcar_totFare_div'>
							렌터카(후불) <span id='rentcar_totFare' name='rentcar_totFare'>0원</span>
							<input type="hidden" class="sub_amt" id="rentcar_amt" data-sign="+" value="0" />
						</p>
						<p id="total_totFare" name="total_totFare">
							전체 상품가 <span id='total_price' name='total_price'>0원</span>
							<input type="hidden" class="sub_amt" id="total_amt" data-sign="+" value="0" />
						</p>
						<p id="pkg_toFare" style="display:none">
							패키지 할인가 <span id="pkg_discnt" name="pkg_discnt">0원</span>
							<input type="hidden" class="sub_amt" id="pkg_amt" data-sign="-" value="0" />
						</p>
<!-- 								[JEH] 자유여행 프로모션 추가 - 20190228 -->
						<p id="prom_toFare" style="display:none" class="ppred">
							프로모션 할인가 <span id="pro_discnt" name="pro_discnt">0원</span>
							<input type="hidden" class="sub_amt" id="pro_amt" data-sign="-" value="0" />
						</p>
						<p id="ijw_toFare" style="display:none" class="ppred">
							롯데임직원 할인가 <span id="ijw_discnt" name="ijw_discnt">0원</span>
							<input type="hidden" class="sub_amt" id="ijw_amt" data-sign="-" value="0" />
						</p>
						<div id="promo_fee">
						</div>
					</dd>
				</dl>
				<p class='pop_avtitle3' id='pay_totFare_div' name='pay_totFare_div'>
					총 결제예정금액 <span id='pay_totFare' data-amt='0' name='pay_totFare'>0원</span>
				</p>
				<p class='pop_bt_text1' id='air_pay_text_div' name='air_pay_text_div'>
					<ul class="dotlist3">
							<li>항공 : 유류할증료&제세공과금 포함</li>
							<li>호텔 : TAX, 봉사료 포함</li>
							<li>렌터카 : 추가사항 포함</li>
					</ul>
				</p>
			</div>
		</div>
		<!-- 항공 장바구니 내역  -->
		
		<!-- 항공 장바구니만 있는 경우 -->
		<div class='popFoot' id='btn_air_only_div' name='btn_air_only_div'>
			<div class='layerBtns'>
				<!-- button type='button' class='layerClose2' onClick='fn_goReserve()'>다음</button -->
				<button type='button' class='layerClose2' onClick='fn_nextStep()'>다음</button>
			</div>
		</div>
	

		<!-- 항공/호텔/렌트카가 없는 경우 -->
		<div class='popFoot' id='btn_nolist_div' name='btn_nolist_div'>
			<div class='layerBtns'><button type='button' class='layerClose2' onclick="closePopup();">예약확인</button></div>
		</div>

	</div>
</div>


