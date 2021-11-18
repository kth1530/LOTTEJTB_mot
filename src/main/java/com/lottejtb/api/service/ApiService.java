package com.lottejtb.api.service;

import java.util.HashMap;

import net.sf.json.JSONObject;

public interface ApiService {
	JSONObject getAirJsonData(JSONObject bodyDto, String aGbn, String rGbn, String userCode) throws Exception;
	JSONObject getHotelJsonData(JSONObject bodyDto, String aGbn, String rGbn, String custCd)throws Exception;
	JSONObject getHotelJsonRstCancel(JSONObject bodyDto, String aGbn, String rGbn, String custCd) throws Exception;
	JSONObject getRentCarJsonData(JSONObject bodyDto, String aGbn, String rGbn) throws Exception;
	JSONObject getJsonGetData(String reqParam, String aGbn, String rGbn) throws Exception;
	JSONObject getHotelJsonDataTest(JSONObject bodyDto, String aGbn, String rGbn) throws Exception;
	JSONObject getRentalCarJsonData(HashMap<String, String> bodyDto, String aGbn, String rGbn) throws Exception;
	
}
