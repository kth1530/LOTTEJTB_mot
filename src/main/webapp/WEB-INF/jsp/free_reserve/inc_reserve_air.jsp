<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : inc_reserve_air.jsp
	// 설명 : 여행자 정보 입력 > 항공 예약 정보 

%>
<script type="text/javascript">
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){
		
	var apiFlightData;

	//상세보기 데이터 호출 ajax - 추후 상세보기 팝업과 합치면 됨 ajax X - 미완료
	function fn_detail() {
		var l_selData = JSON.parse(sessionStorage.airSelData);
		if(!l_selData.retDYn){	//상세데이터를 조회하지 않은 경우
			var cdata = fn_setAvailData_pop();
			
			gfn_callAjax3('/fit/air/viewInfo.do', cdata, 'fn_setDetailData', false, function(){
				fn_showDetailPop();
				sync_airdb();
			});
		} else {
			fn_showDetailPop();
			sync_airdb();
		}
	}

	// sessionStorage data ==> WebSQL DB 데이터로 변경함 
	function sync_airdb() {
		var air_fix_data_info = JSON.parse(sessionStorage.airSelData);
		var arDetail = air_fix_data_info[0];
		var arDetailList = arDetail.segmentGroup;
		var paxDataBean = arDetail.paxDataBean;

		// console.log(arDetailList);
		var jSessionID = '<%=request.getSession().getId()%>';
		// console.log(jSessionID);

		var search_body = JSON.parse(sessionStorage.airViewData).bodyDto;
		var adtCnt = 0;
		var chdCnt = 0;
		var infCnt = 0;

		var iPasCnt = []; 
			
		iPasCnt[0] = search_body.adtCnt; 
		iPasCnt[1] = search_body.chdCnt;
		iPasCnt[2] = search_body.infCnt;


		var adtFareCharge = 0;
		var adtTaxCharge = 0;
		var adtPromSaleFare = 0;
		var adtCabinClas = '';
		var adtBookingClas ='';
		var adtDiscntCharge = 0;
		var adtFuelSurcharge = 0;
		var adtQCharge = 0;
		var adtUpCharge = 0;
		var adtPmoDiscntCharge = 0;
		var adtPmoUpCharge = 0;

		var chdFareCharge = 0;
		var chdTaxCharge = 0;
		var chdPromSaleFare = 0;
		var chdCabinClas = '';
		var chdBookingClas ='';
		var chdDiscntCharge = 0;
		var chdFuelSurcharge = 0;
		var chdQCharge = 0;
		var chdUpCharge = 0;
		var chdPmoDiscntCharge = 0;
		var chdPmoUpCharge = 0;

		var infFareCharge = 0;
		var infTaxCharge = 0;
		var infPromSaleFare = 0;
		var infCabinClas = '';
		var infBookingClas ='';
		var infDiscntCharge = 0;
		var infFuelSurcharge = 0;
		var infQCharge = 0;
		var infUpCharge = 0;
		var infPmoDiscntCharge = 0;
		var infPmoUpCharge = 0;

		var totFare = 0;
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
				// fareDiv.find('tr[ft-att="gbn"]').append('<th>' + pasNm + '</th>');
				var adtPaxData = air_fix_data_info[0].paxDataBean[0];

				
				if(nullToBlank(adtPaxData) != ""){
					//기본운임
					if(adtPaxData.fareCharge != 'undefined')
						adtFareCharge = adtPaxData.fareCharge;
				
					//유류할증료
					var adtFuel = 0;
					if(adtPaxData.fuelCharge != 'undefined')
						adtFuel = adtPaxData.fuelCharge;
					
					//제세공과금
					if(adtPaxData.taxCharge != 'undefined')
						adtTaxCharge = adtPaxData.taxCharge;
					
					adtDiscntCharge = adtPaxData.discntCharge;
					adtFuelSurcharge = adtPaxData.fuelSurcharge;
					adtQCharge = adtPaxData.QCharge;
					adtUpCharge = adtPaxData.upCharge;
					
					if(nullToBlank(adtPaxData.promInfo) != ""){
						if(adtPaxData.promInfo.tyGb == "D"){
							if(adtPaxData.promInfo.diviGb == "R"){
								var airTotAmt = adtFareCharge + adtDiscntCharge + adtTaxCharge + adtUpCharge;
								adtPmoDiscntCharge = airTotAmt * (parseFloat(adtPaxData.promInfo.amt) / 100 );
							}else{
								adtPmoDiscntCharge = adtPaxData.promInfo.amt;
							}
						}else{
							if(adtPaxData.promInfo.diviGb == "R"){
								var airTotAmt = adtFareCharge + adtDiscntCharge + adtTaxCharge + adtUpCharge;
								adtPmoUpCharge = airTotAmt * (parseFloat(adtPaxData.promInfo.amt) / 100 );
							}else{
								adtPmoUpCharge = adtPaxData.promInfo.amt;	
							}
						}
					}
				}
				
				var chdPaxData = air_fix_data_info[0].paxDataBean[1];

				//기본운임
				if(nullToBlank(chdPaxData) != ""){
					if(chdPaxData.fareCharge != 'undefined')
						chdFareCharge = chdPaxData.fareCharge;
				
					//유류할증료
					var chdFuel = 0;
					if(chdPaxData.fuelCharge != 'undefined')
						chdFuel = chdPaxData.fuelCharge;
					
					//제세공과금
					if(chdPaxData.taxCharge != 'undefined')					
						chdTaxCharge = chdPaxData.taxCharge;
					
					chdDiscntCharge = chdPaxData.discntCharge;
					chdFuelSurcharge = chdPaxData.fuelSurcharge;
					chdQCharge = chdPaxData.QCharge;
					chdUpCharge = chdPaxData.upCharge;
					
					if(nullToBlank(chdPaxData.promInfo) != ""){
						if(chdPaxData.promInfo.tyGb == "D"){
							if(chdPaxData.promInfo.diviGb == "R"){
								var airTotAmt = chdFareCharge + chdDiscntCharge + chdTaxCharge + chdUpCharge;
								chdPmoDiscntCharge = chdPaxData.promInfo.amt;
							}else{
								chdPmoDiscntCharge = chdPaxData.promInfo.amt;
							}
						}else{
							if(chdPaxData.promInfo.diviGb == "R"){
								var airTotAmt = chdFareCharge + chdDiscntCharge + chdTaxCharge + chdUpCharge;
								chdPmoUpCharge = chdPaxData.promInfo.amt;
							}else{
								chdPmoUpCharge = chdPaxData.promInfo.amt;
							}
						}
					}
				}
				
				var infPaxData = air_fix_data_info[0].paxDataBean[2];
				
				if(nullToBlank(infPaxData) != ""){
					//기본운임
					if(infPaxData.fareCharge != 'undefined')
						infFareCharge = infPaxData.fareCharge;
				
					//유류할증료
					var infFuel = 0;
					if(infPaxData.fuelCharge != 'undefined')
						infFuel = infPaxData.fuelCharge;
					
					//제세공과금
					if(infPaxData.taxCharge != 'undefined')
						infTaxCharge = infPaxData.taxCharge;
					
					infDiscntCharge = infPaxData.discntCharge;
					infFuelSurcharge = infPaxData.fuelSurcharge;
					infQCharge = infPaxData.QCharge;
					infUpCharge = infPaxData.upCharge;
					
					if(nullToBlank(infPaxData.promInfo) != ""){
						if(infPaxData.promInfo.tyGb == "D"){
							if(infPaxData.promInfo.diviGb == "R"){
								var airTotAmt = infFareCharge + infDiscntCharge + infTaxCharge + infUpCharge;
								infPmoDiscntCharge = infPaxData.promInfo.amt;
							}else{
								infPmoDiscntCharge = infPaxData.promInfo.amt;
							}
						}else{
							if(infPaxData.promInfo.diviGb == "R"){
								var airTotAmt = infFareCharge + infDiscntCharge + infTaxCharge + infUpCharge;
								infPmoUpCharge = infPaxData.promInfo.amt;
							}else{
								infPmoUpCharge = infPaxData.promInfo.amt;
							}
						}
					}
				}
			}
		}

		
		var arDetailInfo = arDetailList[0];
		var arPaxDataBean = paxDataBean[0];
		var paxNo = 0;
		if(search_body.adtCnt != 'undefined'  &&  parseInt(search_body.adtCnt) > 0) { // 성인 탑승객 수 
			adtCnt = parseInt(search_body.adtCnt);

			for(var i = 0; i < adtCnt; i++) {
				// 여행자 정보 입력 
				paxNo++;
				if(i < adtCnt) {
					rsvAirPaxGroupT.insertT(jSessionID, paxNo, 'ADT', (i+1), '', '', '', '', '', '', '', '', adtFareCharge, adtTaxCharge, arDetailInfo.cabinClas, arDetailInfo.bookingClas, arPaxDataBean.vCarrierCd, adtDiscntCharge, adtFuelSurcharge, adtQCharge, adtUpCharge, adtPmoDiscntCharge, adtPmoUpCharge);
				}
			}
		}
		
		if(search_body.chdCnt != 'undefined'  &&  parseInt(search_body.chdCnt) > 0) {	//아동 탑승객 수
			chdCnt = parseInt(search_body.chdCnt);
			for(var i = 0; i < chdCnt; i++) {
				// 여행자 정보 입력 
				paxNo++;
				if(i < chdCnt) {
					rsvAirPaxGroupT.insertT(jSessionID, paxNo, 'CHD', (i+1), '', '', '', '', '', '', '', '', chdFareCharge, chdTaxCharge, arDetailInfo.cabinClas, arDetailInfo.bookingClas, arPaxDataBean.vCarrierCd, infDiscntCharge, chdFuelSurcharge, chdQCharge, chdUpCharge, chdPmoDiscntCharge, chdPmoUpCharge);
				}
			}
			
		}

		if(search_body.infCnt != 'undefined'  && parseInt(search_body.infCnt) > 0) {	//유아 탑승객 수
			infCnt = parseInt(search_body.infCnt);
			for(var i = 0; i < infCnt; i++) {
				// 여행자 정보 입력 
				paxNo++;
				if(i < infCnt) {
					rsvAirPaxGroupT.insertT(jSessionID, paxNo, 'INF', (i+1), '', '', '', '', '', '', '', '', infFareCharge, infTaxCharge, arDetailInfo.cabinClas, arDetailInfo.bookingClas, arPaxDataBean.vCarrierCd, infDiscntCharge, infFuelSurcharge, infQCharge, infUpCharge, infPmoDiscntCharge, infPmoUpCharge);
				}
			}
		}
		var rsvUserId = '';
		var rsvUserNm = '';
		var rsvEnSurNm = '';
		var rsvEnFirstNm = '';
		var rsvHtel = '';
		var rsvBirth = '';
		var rsvEmail = '';
		var rsvRemark = '';		
		var pmoId = '';
		
		if(nullToBlank(arDetail.promData) != ""){
			pmoId = arDetail.promData.promId;
		}

		rsvAirBodyDtoT.insertT(jSessionID, rsvUserId, rsvUserNm, rsvEnSurNm, rsvEnFirstNm,  rsvHtel, rsvBirth, rsvEmail, rsvRemark, arDetail.gdsCd, arDetail.availTy, 'I', arDetail.currency, arDetail.totSaleCharge, arDetail.totTaxCharge, adtCnt, chdCnt, infCnt, arDetail.fmsKey, arDetail.ruleKey, pmoId);

		for(var d_idx=0; d_idx < arDetailList.length; d_idx++) {
			var arDetailInfo = arDetailList[d_idx];
			// console.log(arDetailInfo);
			// rsvAirSegmentGroupT  데이타 동기화 	
			rsvAirSegmentGroupT.insertT(jSessionID, arDetailInfo.availNo, arDetailInfo.segNo, arDetailInfo.carrierCd, arDetailInfo.opCarrierCd, arDetailInfo.fltNo, arDetailInfo.fltEquip, arDetailInfo.depDt, arDetailInfo.depTm, arDetailInfo.depCd, arDetailInfo.arrDt, arDetailInfo.arrTm, arDetailInfo.arrCd, arDetailInfo.eTketYn, arDetailInfo.bookingClas, arDetailInfo.depTerminalNo, arDetailInfo.arrTerminalNo, arDetailInfo.carrierCd, arDetailInfo.carrierNm, arDetailInfo.cabinClas, arDetailInfo.availEFT, arDetailInfo.cnxTy);
			
			var arFixData = air_fix_data_info[0].paxDataBean[0].fareDataBean[(arDetailInfo.availNo - 1)];
			// console.log(arFixData);
			// rsvAirFareDataBeanT 데이타 동기화 
			rsvAirFareDataBeanT.insertT(jSessionID, arFixData.availNo, arFixData.segNo, arFixData.fareBasis, arFixData.fareTy, arFixData.paxTy, arFixData.cabinClas, arFixData.rbd, arFixData.breakPoint);


		}




	}

	//상세보기 팝업 - 임시 미완료
	function fn_showDetailPop () {
		
		//대상이 되는 inputbox 지정
		var detail_pop = $('div[ft-att="air_reserve"]'); 
			
		// 항공일정 
		// var arCnt = _obj;
		var air_fix_data_info = JSON.parse(sessionStorage.airSelData);
		var arDetailList = air_fix_data_info[0].segmentGroup;
		var avail_cnt = air_fix_data_info[0].fltData.length;
		var arDetail = air_fix_data_info;
		
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
			dep_dt = dep_dt + '(' + fn_getDay(dep_dt) + ')'; 
			
			var arr_tm = arDetailInfo.arrTm.substring(0,2) + ':' + arDetailInfo.arrTm.substring(2,4);
			var arr_dt = arDetailInfo.arrDt.substring(0,4) + '.' + arDetailInfo.arrDt.substring(4,6) + '.' + arDetailInfo.arrDt.substring(6,8);
			arr_dt = arr_dt + '(' + fn_getDay(arr_dt) + ')';
			
			//공동운항
			var codeShareYn = '';
			if(arDetailInfo.codeShare != ''){
				codeShareYn = arDetailInfo.codeShareNm + ' 공동운항'; 
			}
			
			var availInfo = "";
			availInfo = availInfo + "			<ul class='fr_porlist'>";
			availInfo = availInfo + "			<li><span>"+tmpTitle+"</span><span><img src='/resources/images/air/"+arDetailInfo.carrierCd+".png' alt=''>"+arDetailInfo.carrierNm + " -편명 " + arDetailInfo.fltNo + '(' + bookingClas + '), ' + viaNm + "</span>";
			availInfo = availInfo + "		    <p class='rbtn'>확정</p>";
			
			if(codeShareYn != '') {
				availInfo = availInfo + "		<div>" + codeShareYn + " " + delayTxt +  "</div>";
			} else if(arDetailInfo.segNo != 1) {
				availInfo = availInfo + "		<div>" + delayTxt + "</dt>";
			} 
			availInfo = availInfo + "			</li>";
			availInfo = availInfo + "						<li>";
			availInfo = availInfo + "							<ul>";
			availInfo = availInfo + "								<li id='" + arDetailInfo.depCd + "'>"+arDetailInfo.depCd+"</li>";
			availInfo = availInfo + "								<li>"+dep_dt+"</li>";
			availInfo = availInfo + "								<li></li>";
			availInfo = availInfo + "								<li id='" + arDetailInfo.arrCd + "'>"+ arDetailInfo.arrCd +"</li>";
			availInfo = availInfo + "								<li>"+ arr_dt + "</li>";
			// availInfo = availInfo + "								<li><span>+1D</span></li>";
			availInfo = availInfo + "								<li>"+ arFixData.interval +"</li>";
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
		/** 다구간인 경우 **/
		} else {
			air_summary = air_summary +"							<p class='st2_stext1 ellipsis'>"+airSummary.availGroup[0].depNm+"</p>";
			air_summary = air_summary +"							<p class='st2_text1'>"+airSummary.availGroup[0].depCd+"</p>";
			air_summary = air_summary +"							<p class='st2_gbox'></p>";
			air_summary = air_summary +"							<p class='st2_text2'>"+airSummary.availGroup[airSummary.availGroup.length -1].arrCd+"</p>";
			air_summary = air_summary +"							<p class='st2_stext2 ellipsis'>"+airSummary.availGroup[airSummary.availGroup.length -1].arrNm+"</p>";

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

		cont_html = cont_html + "<table class='ft_table2 ft_tb_tr'>";
		cont_html = cont_html + "	<colgroup>";
		cont_html = cont_html + "		<col style='width: 30%' />";
		cont_html = cont_html + "		<col style='width: 70%' />";
		cont_html = cont_html + "	</colgroup>";
		cont_html = cont_html + "	<tr ft-att='gbn'>";
		cont_html = cont_html + "		<th>인원</th>";
		//cont_html = cont_html + "		<td>성인 "+inputvalue.adtCnt+"명, 아동 "+inputvalue.chdCnt+"명, 유아 "+inputvalue.infCnt+"명</td>";
		cont_html = cont_html + "	</tr>";
		cont_html = cont_html + "	<tr class='tb_purple'>";
		cont_html = cont_html + "		<th>항공 총 운임</th>";
		cont_html = cont_html + "		<td colspan='3' id='air_totFare' name='air_totFare'>0원</td>";
		cont_html = cont_html + "	</tr>";
		cont_html = cont_html + "</table>";

		detail_pop.find('#air_price_detail').html(cont_html);

		
		var fareDiv = detail_pop.find('.ft_tb_tr');
		var totFare = 0;
		var promSaleFare = 0;
		var pasNm = '';
		
		for(var f_idx=0; f_idx<iPasCnt.length; f_idx++) {
			var i_pas_cnt = iPasCnt[f_idx];
			if(i_pas_cnt > 0){
				//인원수
				
				if(f_idx == 0){
					pasNm = pasNm + '성인' + i_pas_cnt + '명';
				} else if (f_idx == 1) {
					pasNm = pasNm +  ',아동' + i_pas_cnt + '명';
				} else if (f_idx == 2) {
					pasNm = pasNm +  ',유아' + i_pas_cnt + '명';
				}
				//fareDiv.find('tr[ft-att="gbn"]').append('<td>' + pasNm + '</td>');
				
				var paxData = air_fix_data_info[0].paxDataBean[f_idx];
				//기본운임
				var faresum = paxData.fareCharge * i_pas_cnt;
				
				//TASF	20170327 엔진 추가
				var tasfsum = paxData.tasfCharge * i_pas_cnt;
				
				//유류할증료 20170420 엔진 추가
				var fuelsum = 0; 
				
				if(nullToBlank(paxData.fuelCharge) != '') {
					fuelsum = paxData.fuelCharge * i_pas_cnt;
				} else {
					fuelsum = 0; 
				}	
							
				//제세공과금
				var taxsum = paxData.taxCharge * i_pas_cnt;
				
				//프로모션할인
				if(paxData.promInfo != undefined){
					if(paxData.promInfo.tyGb == "D"){
						promSaleFare += (paxData.promInfo.promTotal-0) * i_pas_cnt;
					}else{
						promSaleFare -= (paxData.promInfo.promTotal-0) * i_pas_cnt;
					}
				}

				//전체운임 계산
				totFare += faresum + tasfsum + fuelsum + taxsum - promSaleFare;
			}
		}

		fareDiv.find('tr[ft-att="gbn"]').append('<td>' + pasNm + '</td>');

		// 항공 총 결제금액 확인 
		detail_pop.find('#air_totFare').text(setPriceInput(totFare+'') + '원');

		var payment_div = $('div[ft-att="payment_reserve"]'); 
		
		// 항공 총 운임료 
		payment_div.find("#air_totFare").text(setPriceInput(totFare+'') + '원');
		
		// 호텔 + 렌트카 추가 시  합산된 금액을 표시하도록 추가 개발이 필요함 2017.01.20
		// 총 결제금액 
		payment_div.find("#payment_totFare").text(setPriceInput(totFare+'') + '원');
		payment_div.find('#air_amt').val(totFare);
		payment_div.find('.sub_amt').change();
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
			"fmsKey"   : avail_info.fmsKey
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



	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}

	//날짜 format 맞추기
	function strDateFormat(str){
		if((str+"").length == 1) str = "0" + str;
		return str;				
	}


	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		// sessionStorage 에 airSelData 가 없는 경우 

		if(sessionStorage.airSelData == undefined || sessionStorage.airSelData == null || sessionStorage.airSelData == '[]') {
			sessionStorage.airSelData = JSON.stringify([]); 
			//closePopup();
		}else{
			fn_detail();
			$("#air_cart_div").show();
			$("#air_nocart_div").hide();
			$("#hotel_nocart_div").hide();
			$("#rentcar_nocart_div").hide();	

			$("#btn_air_only_div").show();
			$("#btn_nolist_div").hide();
		}
	});

</script>

<p class='pop_avtitle mt7'>항공</p>
<!-- ### 간략 안내 ### -->
<div class='stable_guide2' id='air_summary' name='air_summary'>
</div>
<!-- ### 간략 안내 ### -->
<!-- ### 항공 스케쥴 ### -->
<div id='air_schd' name='air_schd'>
</div>
<!-- ### 항공 스케쥴 ### -->
<!-- ### 항공 운임료 ### -->
<div id='air_price_detail' name='air_price_detail'>
</div>	


<!-- ### 항공 운임료 ### -->
<p class='txbox4'>(유류할증료, 제세공과금 포함)</p>
<ul class="txbox2">
	<li>상기 요금은 유류할증료 및 제세공과금 포함한 총액요금이며, 유류할증료 및 제세공과금은 유가와 환율에 따라 변동 가능합니다. 상기 요금에는 취급수수료가 포함되어 있지 않습니다.</li>
	<li>TAX 금액은 유류할증료 및 환율 변동에 의해 차이가 있으므로 예약완료 후에 정확한 요금을 확인하실 수 있습니다. 경우에 따라 일부 항공사나 일부 구간의 TAX는 조회가 안될 수 있습니다.</li>
	<!-- li class="txbox2_none">※ 항공권은 예약 후 담당자가 개별적으로 연락 후 결제금액과 방법을 전달해드립니다.</li -->
</ul>