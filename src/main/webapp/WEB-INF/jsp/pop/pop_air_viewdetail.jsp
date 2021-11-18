<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>

<%
	// 파일명 : pop_air_viewdetail.jsp
	// 설명 : 항공권 상세보기
%>
<script type='text/javascript'>
	// require(['jquery','jquery.blockUI','jquery.mobile'], function($){
	// require(['jquery','jquery.blockUI'], function($){

	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}

	//상세보기 결과값을 담을 임시 전역변수
	var tmp_obj = null;
	var arrCnt = 0;
	var l_fixData;
	var airPriceData;
	var apiFlightData;

	//상세보기 데이터 호출 ajax - 추후 상세보기 팝업과 합치면 됨 ajax X - 미완료
	function fn_detail(arCnt) {
		arrCnt = arCnt;
		var l_selData = air_fix_data[arCnt];
		if(!l_selData.retDYn){	//상세데이터를 조회하지 않은 경우
			var cdata = fn_setAvailData_pop(arCnt);
			
			tmp_obj = arCnt;
			
			gfn_callAjax3('/fit/air/viewInfo.do', cdata, 'fn_setDetailData', false, function(){
				fn_showDetailPop(arCnt);
				setTimeout(function(){
					tmp_obj = null;
				}, 0);
			});
			
		} else {
			fn_showDetailPop(arCnt);
		}
		
	}

	//상세보기 팝업 - 임시 미완료
	function fn_showDetailPop (arCnt) {
		
		//대상이 되는 inputbox 지정
		var detail_pop = $('div[ft-att="air_detail_pop"]'); 
			
		// 항공일정 
		// var arCnt = _obj;
		var air_fix_data_info = air_fix_data[arCnt];
		// var air_fix_data_info = l_fixData;
		var arDetailList = air_fix_data_info.segmentGroup;
		var avail_cnt = air_fix_data_info.fltData.length;

		
		var avail_div = detail_pop.find('.cntain').find('div.air');
		var tmp_arrDt = '';
		var tmp_arrTm = '';

		for(var d_idx=0; d_idx < arDetailList.length; d_idx++) {
			var arDetailInfo = arDetailList[d_idx];
			var arFixData = air_fix_data_info.fltData[(arDetailInfo.availNo - 1)];
			
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
					tmpTitle = "<p class='pop_avtitle'>출발여정</p>";
				} else if(arDetailInfo.availNo == avail_cnt) {
					tmpTitle = "<p class='pop_avtitle'>도착여정</p>";
				} else {
					tmpTitle = "<p class='pop_avtitle'>다구간 여정</p>";
				}
				tmpDetailDiv.append(tmpTitle);
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
			dep_dt = dep_dt + '(' + gfn_getDay_jum(dep_dt) + ')'; 
			
			var arr_tm = arDetailInfo.arrTm.substring(0,2) + ':' + arDetailInfo.arrTm.substring(2,4);
			var arr_dt = arDetailInfo.arrDt.substring(0,4) + '.' + arDetailInfo.arrDt.substring(4,6) + '.' + arDetailInfo.arrDt.substring(6,8);
			arr_dt = arr_dt + '(' + gfn_getDay_jum(arr_dt) + ')';
			
			//공동운항
			var codeShareYn = '';
			if(arDetailInfo.codeShare != ''){
				codeShareYn = ' [' + arDetailInfo.codeShareNm + ' 공동운항]'; 
			}
			
			var availInfo = "";

			availInfo = availInfo + "				<dl class='ft_acdon3 pop_av_dl'>";
			availInfo = availInfo + "					<dt style='background: #fff url(/resources/images/air/"+ arDetailInfo.carrierCd + ".png) 10px center no-repeat;'>";
			availInfo = availInfo + "						" +  arDetailInfo.carrierNm + " <span>-편명 "+ arDetailInfo.fltNo + '(' + bookingClas + ')' + viaNm + "</span>";
			availInfo = availInfo + "					</dt>";
			if(codeShareYn != '') {
				availInfo = availInfo + "					<dt class='air_com_trc'>" + codeShareYn + " " + delayTxt + "</dt>";
			} else if(arDetailInfo.segNo != 1) {
				availInfo = availInfo + "					<dt class='air_com_trc'>" + delayTxt + "</dt>";
			} 
			availInfo = availInfo + "					<dd>";
			availInfo = availInfo + "						<table class='pop_av_tb'>";
			availInfo = availInfo + "							<colgroup>";
			availInfo = availInfo + "								<col style='width: 15%' />";
			availInfo = availInfo + "								<col style='width: 22%' />";
			availInfo = availInfo + "								<col style='width: 30%' />";
			availInfo = availInfo + "								<col style='width: 23%' />";
			availInfo = availInfo + "							</colgroup>";
			availInfo = availInfo + "							<tr>";
			availInfo = availInfo + "								<td>" + dep_tm + "</td>";
			availInfo = availInfo + "								<td>" + dep_dt + "</td>";
			availInfo = availInfo + "								<td class='pat_point' id='" + arDetailInfo.depCd + "'>" + arDetailInfo.depNm + '(' + arDetailInfo.depCd + ')' + "</td>";
			availInfo = availInfo + "								<td rowspan='2' class='pat_dey'>"+ arFixData.interval + "</td>";
			availInfo = availInfo + "							</tr>";
			availInfo = availInfo + "							<tr>";
			availInfo = availInfo + "								<td>"+ arr_tm + "</td>";
			availInfo = availInfo + "								<td>"+ arr_dt + "</td>";
			availInfo = availInfo + "								<td class='pat_point' id='" + arDetailInfo.arrCd + "'>" + arDetailInfo.arrNm + '(' + arDetailInfo.arrCd + ')' + "</td>";
			// availInfo = availInfo + "								<td rowspan='2' class='pat_dey'>"+ arDetailInfo.interval +"</td>";
			availInfo = availInfo + "							</tr>";
			availInfo = availInfo + "						</table>";
			availInfo = availInfo + "					</dd>";
			availInfo = availInfo + "				</dl>";


			
			tmpDetailDiv.append(availInfo);
		}
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
		/*
		cont_html = cont_html + "							<tr class='tb_purple' ft-att='price'>";
		cont_html = cont_html + "								<th>합계</th>";
		cont_html = cont_html + "							</tr>";
		*/
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

		detail_pop.find('#price_detail').html(cont_html);

		
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
				
				var paxData = air_fix_data_info.paxDataBean[f_idx];
				//기본운임
				var faresum = paxData.fareCharge * i_pas_cnt;
				
				//프로모션할인
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
				
				if(nullToBlank(paxData.fuelCharge) != '') {
					fuelsum = paxData.fuelCharge * i_pas_cnt;
				} else {
					fuelsum = 0; 
				}	


				// var fuelsum = 0;
				fareDiv.find('tr[ft-att="fuel"]').append('<td>' + setPriceInput(fuelsum) + '원</td>');
				
				//제세공과금
				/* var taxsum = (paxData.taxCharge - fuelsum) * i_pas_cnt; */
				var taxsum = paxData.taxCharge * i_pas_cnt;
				fareDiv.find('tr[ft-att="tax"]').append('<td>' + setPriceInput(taxsum - fuelsum) + '원</td>');

				if(promSaleFare > 0){
					if(paxData.promInfo.tyGb == "D"){
						fareDiv.find('tr[ft-att="promo"]').append('<td>' + setPriceInput(promSaleFare) + '원</td>');
					}else{
						fareDiv.find('tr[ft-att="promo"]').append('<td>0원</td>');
					}
				}else{
					fareDiv.find('tr[ft-att="promo"]').append('<td>0원</td>');
				}
				
				//총운임
				//fareDiv.find('tr[ft-att="price"]').append('<td>' + setPriceInput((faresum + fuelsum + taxsum)+'') + '원</td>');
				
				//전체운임 계산
				/* totFare += faresum + tasfsum + fuelsum + taxsum; */
				totFare += faresum + tasfsum + taxsum;
			}
		}

		//전체운임 계산
		detail_pop.find('#totFare').text(setPriceInput(totFare - promSaleFare) + '원');
	}


	// 팝업 > 요금규정, 상세보기 팝업 호출시 넘겨줄 데이터 세팅
	function fn_setAvailData_pop(_obj) {
		
		// var ar_cnt = $(_obj).parents('[ft-att="fare_list"]').attr('ar-cnt');
		var ar_cnt = _obj;
		var avail_info = air_fix_data[ar_cnt];
		// console.log("avail_info : " + avail_info);

		var pax_info = JSON.parse(sessionStorage.airSearchVal).bodyDto;	
		
		cdata= {
			"gdsCd"		: avail_info.gdsCd,		
			"availTy"	: pax_info.availTy,	
			"adtCnt"	: pax_info.adtCnt,		
			"chdCnt"	: pax_info.chdCnt,		
			"infCnt"	: pax_info.infCnt,
			"fmsKey"   : avail_info.fmsKey
		};
		
		cdata.segmentGroup = [];
		
		for(var seg_idx=0; seg_idx<avail_info.segmentGroup.length; seg_idx++) {
			var availData = avail_info.segmentGroup[seg_idx];
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
		//cdata.paxGroup = avail_info.paxDataBean;
		
		cdata.paxGroup = [];
		
		for(var pax_idx=0; pax_idx < avail_info.paxDataBean.length; pax_idx++){
			var paxData = avail_info.paxDataBean[pax_idx];
			cdata.paxGroup[pax_idx] = {
				'qCharge'		: paxData.QCharge,
				'bookingClas'	: paxData.bookingClas,
				'cabinClas'		: paxData.cabinClas,
				'discntCharge'	: paxData.discntCharge,
				'fareCharge'	: paxData.fareCharge,
				'fareDataBean'	: paxData.fareDataBean,
				'fuelSurcharge'	: paxData.fuelSurcharge,
				'ltd'			: paxData.ltd,
				'paxCnt'		: paxData.paxCnt,
				'paxNo'			: paxData.paxNo,
				'paxTy'			: paxData.paxTy,
				'penAmount'		: paxData.penAmount,
				'tasfCharge'	: paxData.tasfCharge,
				'taxCharge'		: paxData.taxCharge,
				'upCharge'		: paxData.upCharge,
				'vCarrierCd'	: paxData.vCarrierCd
			}
		}
		
		return cdata;
	}

	//상세보기 결과값을 fltData에 담는다
	function fn_setDetailData(_data){
		// air_fix_data.fltData 에 조회한 상세정보를 입력한다.

		var detail_pop = $('div[ft-att="air_detail_pop"]');
		
		var l_fixData = air_fix_data[arrCnt];
			
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
						
						l_fixPaxCnt = l_fixPaxData.paxCnt;
						
						i_totSaleCharge += (i_fareCharge + i_taxCharge) * l_fixPaxCnt;
						i_totTaxCharge += (i_taxCharge) * l_fixPaxCnt;

						// 프로모션 추가 20170420
						l_fixPaxData.aplPromTotal = f_paxData.aplPromTotal-0;
						l_fixPaxData.promTotal = f_paxData.promTotal-0;
						l_fixPaxData.promId = f_paxData.promId;
					}
				}
			}
		}
		l_fixData.totSaleCharge = i_totSaleCharge;
		l_fixData.totTaxCharge = i_totTaxCharge;
		
		// console.log(apiPriceData);
		
		l_fixData.retDYn = 'Y';	//상세 조회 여부 추가
		// air_fix_data[arrCnt] = l_fixData;
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
		var ar_cnt = '${ar_cnt}';
		
		// console.log('ar_cnt >> ' + ar_cnt);
		fn_detail(ar_cnt);

		/*document.addEventListener('deviceready', function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});
</script>

<div class='layerPopup' ft-att='air_detail_pop'>
	<div class='layerPop bggray'>
		<!-- 내용시작 -->
		<div class='popCon'>
			<div class='popHead'>
				<div class='popTpart'>
					<strong class='popTitle'>상세보기</strong>
					<button type='button' class='layerClose'>
						<img src='/resources/images/btn/btn_exit.png' alt='레이어 닫기'>
					</button>
				</div>
			</div>

			<div class='cntain' id='air' name='air'>
				<!-- 항공 스케쥴 -->
				<div id='air_schd' name='air_schd'>
				</div>
			    <!-- 요금표 -->
				<div class='pop_payinfobox' id='price_detail' name='price_detail'>
				</div>
				<!-- 요금표 -->
			</div>
		</div>
		<!-- 내용끝 -->
		<div class='popFoot'>
			<div class='layerBtns'>
				<button type='button' class='layerClose1' onClick='closePopup()'>확인</button>
			</div>
		</div>
	</div>
</div>