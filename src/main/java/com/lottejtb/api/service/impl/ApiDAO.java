package com.lottejtb.api.service.impl;

import javax.annotation.Resource;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;

import com.lottejtb.framework.common.CommAbstractFreeDAO;

import egovframework.rte.fdl.property.EgovPropertyService;

@Repository("ApiDAO")
public class ApiDAO extends CommAbstractFreeDAO {
	
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;	
	
	public JSONObject apiPostRequest(JSONObject jobj, String sgbn) {
		JSONObject oJSONResponse = new JSONObject();	//결과값
		String resultCode = "0";	//웹서비스 오류코드
		
		String IsBookingEngineUrl = propertiesService.getString("api.basic.url");
		String gbn = propertiesService.getString("api." + sgbn);
		
		try {
			JSONObject oJSONRequest = new JSONObject();
			
			JSONObject headerDtoJson = new JSONObject();
			headerDtoJson.put("deviceCd", "MB");
			headerDtoJson.put("agentTy", "B2C");
			headerDtoJson.put("agentId", "app");
			
			oJSONRequest.put("headerDto", headerDtoJson);
			
			oJSONRequest.put("bodyDto", jobj);

			RestTemplate oRestTemplate = new RestTemplate();
			
			oJSONResponse = oRestTemplate.postForObject(IsBookingEngineUrl + gbn, oJSONRequest, JSONObject.class);
			
			if(oJSONResponse.getJSONObject("RESULT") != null){
				resultCode = oJSONResponse.getJSONObject("RESULT").getString("code");
				
				if("1".equals(resultCode)){

				}
			} 
		} catch (Exception e) {
			JSONObject oJSONError = new JSONObject();
			try {
				oJSONError.put("code", "99");
				oJSONError.put("message", e.getMessage());
				oJSONResponse.put("RESULT", oJSONError);
			} catch (JSONException e1) {
				// TODO Auto-generated catch block
				//e1.printStackTrace();
				System.err.print("결과값 오류!");
			}
			//e.printStackTrace();
			System.err.print("인터페이스 오류!");
		}
		return oJSONResponse;
	}
}
