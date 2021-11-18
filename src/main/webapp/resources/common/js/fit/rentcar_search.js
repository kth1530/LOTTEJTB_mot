/**
 * 
 */	
function fn_set_rentcar_search_value(ftGroup) {
	if(nullToBlank(ftGroup) != ""){
		var rentTakePlaceCd = "";
		var rentTakeType;
		var rentReturnPlaceCd = "";
		var rentReturnType;
		
		if(nullToBlank($("div[ft-att="+ ftGroup +"]").find("#take_place_cd").val()) != ""){
			rentTakePlaceCd = $("div[ft-att="+ ftGroup +"]").find("#take_place_cd").val();
			rentTakeType = "CITY";
		}else{
			rentTakePlaceCd = $("div[ft-att="+ ftGroup +"]").find("#take_place_oagCd").val();
			rentTakeType = "OAG_CODE"
		}
		
		var rentTakePlaceNm = $("div[ft-att="+ ftGroup +"]").find("#dep_place").val();
		var rentTakePlaceCountryCd = $("div[ft-att="+ ftGroup +"]").find("#take_place_countryCd").val();
		
		if(nullToBlank($("div[ft-att="+ ftGroup +"]").find("#return_place_cd").val()) != ""){
			rentReturnPlaceCd = $("div[ft-att="+ ftGroup +"]").find("#return_place_cd").val();
			rentReturnType = "CITY";
		}else{
			rentReturnPlaceCd = $("div[ft-att="+ ftGroup +"]").find("#return_place_oagCd").val();
			rentReturnType = "OAG_CODE"
		}
		
		var rentReturnPlaceNm = $("div[ft-att="+ ftGroup +"]").find("#arr_place").val();
		var rentReturnPlaceCountryCd = $("div[ft-att="+ ftGroup +"]").find("#return_place_countryCd").val();
		var rentTakeDate = $("div[ft-att="+ ftGroup +"]").find("#take_date").val();
		var rentReturnDate = $("div[ft-att="+ ftGroup +"]").find("#return_date").val();
		var rentTakeTime = $("div[ft-att="+ ftGroup +"]").find("#takeTime :selected").val();
		var rentReturnTime = $("div[ft-att="+ ftGroup +"]").find("#returnTime :selected").val();
		var driverAge = $("div[ft-att="+ ftGroup +"]").find("#driverAge :selected").val();
		var samePlaceYn = $("div[ft-att="+ ftGroup +"]").find("#same_place").is(':checked');
	}else{
		var rentTakePlaceCd = "";
		var rentTakeType;
		var rentReturnPlaceCd = "";
		var rentReturnType;
		
		if(nullToBlank($("div[ft-att=RCGroup]").find("#take_place_cd").val()) != ""){
			rentTakePlaceCd = $("div[ft-att=RCGroup]").find("#take_place_cd").val();
			rentTakeType = "CITY";
		}else{
			rentTakePlaceCd = $("div[ft-att=RCGroup]").find("#take_place_oagCd").val();
			rentTakeType = "OAG_CODE"
		}
		
		var rentTakePlaceNm = $("div[ft-att=RCGroup]").find("#dep_place").val();
		var rentTakePlaceCountryCd = $("div[ft-att=RCGroup]").find("#take_place_countryCd").val();
		
		if(nullToBlank($("div[ft-att=RCGroup]").find("#return_place_cd").val()) != ""){
			rentReturnPlaceCd = $("div[ft-att=RCGroup]").find("#return_place_cd").val();
			rentReturnType = "CITY";
		}else{
			rentReturnPlaceCd = $("div[ft-att=RCGroup]").find("#return_place_oagCd").val();
			rentReturnType = "OAG_CODE";
		}
		
		var rentReturnPlaceNm = $("div[ft-att=RCGroup]").find("#arr_place").val();
		var rentReturnPlaceCountryCd = $("div[ft-att=RCGroup]").find("#return_place_countryCd").val();
		var rentTakeDate = $("div[ft-att=RCGroup]").find("#take_date").val();
		var rentReturnDate = $("div[ft-att=RCGroup]").find("#return_date").val();
		var rentTakeTime = $("div[ft-att=RCGroup]").find("#takeTime :selected").val();
		var rentReturnTime = $("div[ft-att=RCGroup]").find("#returnTime :selected").val();
		var driverAge = $("div[ft-att=RCGroup]").find("#driverAge :selected").val();
		var samePlaceYn = $("div[ft-att=RCGroup]").find("#same_place").is(':checked');
	}
	
	if(nullToBlank(rentTakePlaceCd) == ""){
		setAlert("인수장소를 입력하세요.");
		return false;
	}
	
	if(nullToBlank(rentReturnPlaceCd) == ""){
		setAlert("반납장소를 입력하세요.");
		return false;
	}
	
	if(nullToBlank(rentTakeDate) == ""){
		setAlert("인수일자를 입력하세요.");
		return false;
	}
	
	if(nullToBlank(rentReturnDate) == ""){
		setAlert("반납일자를 입력하세요.");
		return false;
	}
	
	if(nullToBlank(rentTakeTime) == ""){
		setAlert("인수시간을 선택하세요.");
		return false;
	}
	
	if(nullToBlank(rentReturnTime) == ""){
		setAlert("반납시간을 선택하세요.");
		return false;
	}
	
	if(nullToBlank(driverAge) == ""){
		setAlert("운전자 나이를 선택하세요.");
		return false;
	}
	
	var rentCarSearchData = {
			"rentTakePlaceCd" 			: rentTakePlaceCd,
			"rentTakeType"				: rentTakeType,
			"rentTakePlaceNm" 			: rentTakePlaceNm,
			"rentTakePlaceCountryCd" 	: rentTakePlaceCountryCd,
			"rentReturnPlaceCd" 		: rentReturnPlaceCd,
			"rentReturnType"			: rentReturnType,
			"rentReturnPlaceNm" 		: rentReturnPlaceNm,
			"rentReturnPlaceCountryCd"	: rentReturnPlaceCountryCd,
			"rentTakeDate" 				: rentTakeDate,
			"rentReturnDate" 			: rentReturnDate,
			"rentTakeTime" 				: rentTakeTime,
			"rentReturnTime" 			: rentReturnTime,
			"driverAge" 				: driverAge,
			"samePlaceYn"				: samePlaceYn
	}
	
	sessionStorage.rentCarSearchData = JSON.stringify(rentCarSearchData);
	setCookieValue('rentCarSearchData', JSON.stringify(rentCarSearchData));
	
	return true;
}