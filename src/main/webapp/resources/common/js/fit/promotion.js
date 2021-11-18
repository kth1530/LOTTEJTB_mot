$(document).ready(function() {
	
	// 프로모션 유무 조회
	var promInfo = {
		'condition'	: '',
		'promData'	: []
	};
	
	if(nullToBlank(sessionStorage.promInfo) != ''){
		promInfo = JSON.parse(sessionStorage.promInfo); 
	}
	
		
	var fitMix =  ($("#selAir").val() == 'Y' ? 'A' : 'X')
	 				+ ($("#selHotel").val() == 'Y' ? 'H' : 'X')
	 				+ ($("#selRentcar").val() == 'Y' ? 'C' : 'X');

	//console.log("promotion fitMix=" + fitMix);
	
	if(fitMix != 'XXX'){
		var reqData = {
			'concMix'	: fitMix,
			'startDt'	: []
		};
		
		if(nullToBlank(sessionStorage.airSearchVal) != '' && sessionStorage.airSearchVal != '[]') { 
			var airSearchData = JSON.parse(sessionStorage.airSearchVal);
			var depDt = airSearchData.bodyDto.availGroup[0].depDt;
			
			if(depDt != undefined && depDt != '' && depDt.length > 7){
				
				reqData.startDt.push(gfn_setDateFormat(depDt, '-'));
			}
		}
		
		if(nullToBlank(sessionStorage.hotelSearchVal) != '' && sessionStorage.hotelSearchVal != '[]'){
			var hotelSearData = JSON.parse(sessionStorage.hotelSearchVal);
			reqData.htlNationCd = hotelSearData.countryCd;
			reqData.htlCtCd = hotelSearData.findLocNm;
			reqData.startDt.push(hotelSearData.checkInDt);
		}
		
		if(nullToBlank(sessionStorage.rntcarSearchVal) != '' && sessionStorage.rntcarSearchVal != '[]'){
			var rntSearchData = JSON.parse(sessionStorage.rntcarSearchVal);
			reqData.startDt.push(rntSearchData.pickupDate);
		}
		
		var reqStr = JSON.stringify(reqData);
		
		//if(promInfo.condition != reqStr){
			promInfo.condition = reqStr;
			
			sessionStorage.promInfo = JSON.stringify(promInfo); 

			gfn_callAjax('/fit/htl//promotion.do', reqData, 'setPromInfo', true);
		//}
	}
});

// 검색조건에 맞는 프로모션 리스트 세팅
var setPromInfo = function(_data){
	var promInfo = JSON.parse(sessionStorage.promInfo);
	promInfo.promData = _data.promotion;
	sessionStorage.promInfo = JSON.stringify(promInfo);  
};

/**	항공 프로모션 적용
 *	@param	gdsTyGb, cabin, carrierCd
 *	@return applyAirProm
 */
function applyAirProm(p_gdsTyGb, p_cabin, p_carrierCd){
	var promInfo = JSON.parse(sessionStorage.promInfo);
	var promDataArr = promInfo.promData;
	
	var applyAirProm = []; 
	if(promDataArr.length > 0){
		for(var i=0; i<promDataArr.length; i++){
			var promData = promDataArr[i];
			
			if(promData.gdsTyGb != null && promData.gdsTyGb != p_gdsTyGb){
				continue;
			} else if(promData.cabin != null && promData.cabin != p_cabin){
				continue;
			} else if(promData.carrierCd != null && promData.carrierCd != p_carrierCd){
				continue;
			} else {
				var applyAirData = {
					'adtTyGb'		: promData.adtTyGb,
					'adtDiviGb'		: promData.adtDiviGb,
					'airCoalCardGb'	: promData.airCoalCardGb,
					'airCoalCardNm'	: promData.airCoalCardNm,
					'adtAmt'		: promData.adtAmt,
					'promNm'		: promData.promNm,
					'promId'		: promData.promId
				};
				
				applyAirProm.push(applyAirData);
			}
		}
	}
	
	return applyAirProm;
}

/**	호텔 프로모션 적용
 *	@param	suplrId, htlNationCd, htlCtCd, htlCd
 *	@return applyHtlProm
 */
function applyHtlProm(p_suplrId, p_htlNationCd, p_htlCtCd, p_htlCd){
	var promInfo = JSON.parse(sessionStorage.promInfo);
	var promDataArr = promInfo.promData;
	
	var applyHtlProm = []; 
	if(promDataArr.length > 0){
		for(var i=0; i<promDataArr.length; i++){
			var promData = promDataArr[i];
			
			if(promData.suplrId != null && promData.suplrId != p_suplrId){
				continue;
			} else if(promData.htlNationCd != null && promData.htlNationCd != p_htlNationCd){
				continue;
			} else if(promData.htlCtCd != null && promData.htlCtCd != p_htlCtCd){
				continue;
			} else if(promData.htlCd != null && promData.htlCd != p_htlCd){
				continue;
			} else {
				var applyHtlData = {
					'tyGb'			: promData.tyGb,
					'diviGb'		: promData.diviGb,
					'htlCoalCardGb'	: promData.htlCoalCardGb,
					'amt'			: promData.amt,
					'promNm'		: promData.promNm,
					'promId'		: promData.promId
				};
				
				applyHtlProm.push(applyHtlData);
			}
		}
	}
	
	return applyHtlProm;
}