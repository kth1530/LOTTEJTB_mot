
package com.lottejtb.api.service.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.lottejtb.api.service.ApiService;
import com.lottejtb.comm.util.CommInfo;
import com.lottejtb.sso.service.LoginService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("ApiService")
public class ApiServiceImpl extends EgovAbstractServiceImpl implements ApiService {

	private static final Logger logger = Logger.getLogger(ApiServiceImpl.class);
	private final String USER_AGENT = "Mozilla/5.0";
	
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	@Resource(name = "LoginService")
	private LoginService loginService;
    @Override
	public JSONObject getAirJsonData(JSONObject bodyDto, String aGbn,  String rGbn, String userCode) throws Exception {
    	JSONObject resultData = new JSONObject();
    	
    	String resultCode = "0";	//웹서비스 오류코드
		String errorMsg = "";
    	
		String IsBookingEngineUrl = propertiesService.getString("api." + aGbn + ".url");
		String gbn = propertiesService.getString("api." + aGbn + "." + rGbn);
		
		if(userCode == null || userCode.equals("")) userCode = "test";
		
		try {			
			JSONObject oJSONRequest = new JSONObject();

			JSONObject headerDto = new JSONObject();
			headerDto.put("deviceCd", "MB");
			headerDto.put("agentTy" , "B2C");
			headerDto.put("agentId", "app");
			headerDto.put("userCode", userCode);
			
			oJSONRequest.put("headerDto", headerDto);
			oJSONRequest.put("bodyDto", bodyDto);
			
			System.out.println("api url : " + IsBookingEngineUrl + gbn);
			System.out.println("reqParam : " + oJSONRequest);
			
			RestTemplate oRestTemplate = new RestTemplate();
			
			JSONObject oJSONResponse = oRestTemplate.postForObject(IsBookingEngineUrl + gbn, oJSONRequest, JSONObject.class);
			
			System.out.println("response : " + oJSONResponse);
			
			String resultNm = "RESULT";
			
			if(oJSONResponse != null && oJSONResponse.getJSONObject(resultNm) != null){
				try {
					resultCode = oJSONResponse.getJSONObject(resultNm).getString("code");
				} catch (Exception e) {
					resultNm = "Result";
					resultCode = oJSONResponse.getJSONObject(resultNm).getString("code");
				}
				
				resultData = oJSONResponse.getJSONObject(resultNm);
				if(!"1".equals(resultCode)){
					logger.error(oJSONResponse.getJSONObject(resultNm).getString("message"));
				}
			} else {
				if(oJSONResponse == null) {
					errorMsg = "null response";
				} else {
					errorMsg = "null result";
				}
				resultData.put("code", "00");
				resultData.put("message", errorMsg);
			}
		} catch (Exception e) {
			resultData.put("code", "00");
			resultData.put("message", "api error : " + e.toString());
			//e.printStackTrace();
			System.err.print("인터페이스 오류!");
		}
		 
		return resultData;
	}
    
    @Override
	public JSONObject getHotelJsonData(JSONObject bodyDto, String aGbn, String rGbn, String custCd) throws Exception {
    	
    	HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
    	HttpSession ssn = req.getSession();
    	
    	// 임직원 마크업 추가 2019.04.16 bum
    	String ssnId = custCd;
    	//String ssnId = "0000002916";
    	String custCdChk = loginService.checkCustCdChk(ssnId);
    	bodyDto.put("custChk",custCdChk);
    	
		//브라우저 확인
		String agent = req.getHeader("User-Agent");
		System.out.println(">>>>>>agent=" + agent);
		//agent = getBrowser(agent);
		
		//ip
        String remoteAddr = req.getHeader("X-FORWARDED-FOR");
        if (remoteAddr == null)
        	remoteAddr = req.getRemoteAddr();
        System.out.println("remoteAddr=" + remoteAddr);
    	
    	JSONObject resultData = new JSONObject();
    	
    	String resultCode = "0";	//웹서비스 오류코드
		String errorMsg = "";
    	
		String IsBookingEngineUrl = propertiesService.getString("api." + aGbn + ".url"); //"http://10.141.1.66/rest/htl/";
		String gbn = propertiesService.getString("api." + aGbn + "." + rGbn);
		
		try {			
			JSONObject oJSONRequest = new JSONObject();

			JSONObject headerDto = new JSONObject();
			headerDto.put("deviceCd", "MB");
			headerDto.put("agentTy" , "B2C");
			headerDto.put("agentId", "FRONT");
			headerDto.put("userId", custCd);
			headerDto.put("remoteAddr", remoteAddr);
			headerDto.put("userAgent", agent);
			
			
			oJSONRequest.put("headerDto", headerDto);
			bodyDto.put("sessionId", ssnId);
			oJSONRequest.put("bodyDto", bodyDto);
			
			System.out.println("api url : " + IsBookingEngineUrl + gbn);
			System.out.println("getJsonData reqParam : " + oJSONRequest);
			
			RestTemplate oRestTemplate = new RestTemplate();
			
			JSONObject oJSONResponse = oRestTemplate.postForObject(IsBookingEngineUrl + gbn , oJSONRequest, JSONObject.class);

			int endStr = 4000;
			if(oJSONResponse != null) {
				String resStr = oJSONResponse.toString();
				if(resStr.length() < 4000){
					endStr = resStr.length(); 
				}
				System.out.println("getJsonData response : " + oJSONResponse.toString().substring(0, endStr));
			} else {
				System.out.println("getJsonData response : local null");
			}
			
			String resultNm = "RESULT";
			
			if(oJSONResponse != null && oJSONResponse.getJSONObject(resultNm) != null){
				try {
					resultCode = oJSONResponse.getJSONObject(resultNm).getString("code");
				} catch (Exception e) {
					resultNm = "Result";
					resultCode = oJSONResponse.getJSONObject(resultNm).getString("code");
				}
				
				resultData = oJSONResponse.getJSONObject(resultNm);
				if(!"1".equals(resultCode)){
					logger.error(oJSONResponse.getJSONObject(resultNm).getString("message"));
				}
			} else {
				if(oJSONResponse == null) {
					errorMsg = "null response";
				} else {
					errorMsg = "null result";
				}
				resultData.put("code", "00");
				resultData.put("message", errorMsg);
			}
		} catch (Exception e) {
			resultData.put("code", "00");
			resultData.put("message", "api error : " + e.toString());
			//e.printStackTrace();
			System.err.print("인터페이스 오류!");
		}
        
        return resultData;
	}
    
    public JSONObject getRentCarJsonData(JSONObject bodyDto, String aGbn, String rGbn) throws Exception {
        JSONObject resultData = new JSONObject();
    	JSONArray resultList = new JSONArray();
    	
    	String resultCode = "0";	//웹서비스 오류코드
		String errorMsg = "";
    	
    	String IsRentcarEngineUrl = propertiesService.getString("api." + aGbn + ".url");
		String gbn = propertiesService.getString("api." + aGbn + "." + rGbn);
		
		try {			
			JSONObject oJSONRequest = new JSONObject();

			JSONObject headerDto = new JSONObject();
			headerDto.put("deviceCd", "MB");
			headerDto.put("agentTy" , "B2C");
			headerDto.put("agentId", "FRONT");
			headerDto.put("userCode", "test");
			
			oJSONRequest.put("headerDto", headerDto);
			oJSONRequest.put("bodyDto", bodyDto);
			
			System.out.println("api url : " + IsRentcarEngineUrl + gbn);
			System.out.println("getJsonData reqParam : " + oJSONRequest);
			
			RestTemplate oRestTemplate = new RestTemplate();
			
			JSONObject oJSONResponse = oRestTemplate.postForObject(IsRentcarEngineUrl + gbn , oJSONRequest, JSONObject.class);
			
			int endStr = 4000;
			if(oJSONResponse != null) {
				String resStr = oJSONResponse.toString();
				if(resStr.length() < 4000){
					endStr = resStr.length(); 
				}
				System.out.println("getJsonData response : " + oJSONResponse.toString().substring(0, endStr));
			} else {
				System.out.println("getJsonData response : local null");
			}
			
			
			if(oJSONResponse != null && oJSONResponse.getString("message") != null){
				try {
					resultCode = oJSONResponse.getString("code");
				} catch (Exception e) {
					resultCode = "0";
				}
				
				resultList = oJSONResponse.getJSONArray("data");
				resultData.put("code", oJSONResponse.getString("code"));
				resultData.put("message", oJSONResponse.getString("message"));
				resultData.put("data", resultList);
				if(!"1".equals(resultCode)){
					logger.error(oJSONResponse.getString("message"));
				}
			} else {
				if(oJSONResponse == null) {
					errorMsg = "null response";
				} else {
					errorMsg = "null result";
				}
				resultData.put("code", "00");
				resultData.put("message", errorMsg);
			}
		} catch (Exception e) {
			resultData.put("code", "00");
			resultData.put("message", "api error : " + e.toString());
			//e.printStackTrace();
			System.err.print("인터페이스 오류!");
		}
        
        return resultData;
    }
    
    public JSONObject getJsonGetData(String reqParam, String aGbn, String rGbn) throws Exception {
               
    	JSONObject resultData = new JSONObject();
    	BufferedReader in = null;
    	HttpURLConnection con = null;

    	String IsHotelEngineUrl = propertiesService.getString("api." + aGbn + ".url");
    	String gbn = "";
    	if(!"".equals(rGbn)){
    		gbn = propertiesService.getString("api." + aGbn + "." + rGbn);
    	}

        try {
        	String url = IsHotelEngineUrl + gbn + "json?" + reqParam;
            System.out.println("\nSending 'GET' request to URL : \n" + url);
            URL obj = new URL(url);
            con = (HttpURLConnection) obj.openConnection();

            con.setRequestMethod("GET");
            con.setDoOutput(true);
            int responseCode = con.getResponseCode();
            
            System.out.println("Response Code : \n" + responseCode);

            in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            
            

            System.out.println("resParam : " + response.toString());
            //print result
            resultData = JSONObject.fromObject(response.toString());
        } catch (Exception e) {
           //e.printStackTrace();
        	System.err.print("인터페이스 오류!");
        } finally {
        	if(in != null){
        		in.close();
        	}
        	
        	if(con != null){
        		con.disconnect();
        	}
        }
        
        return resultData;
    }

	@Override
	public JSONObject getHotelJsonDataTest(JSONObject bodyDto, String aGbn,String rGbn) throws Exception {
		
		
		JSONObject resultData = new JSONObject();
    	
    	String resultCode = "0";	//웹서비스 오류코드
    	String IsBookingEngineUrl = "http://localhost:8080";//propertiesService.getString("api.local.url");
    	
		
		try {			
			JSONObject oJSONRequest = new JSONObject();

			oJSONRequest.put("bodyDto", bodyDto);
			
			System.out.println("api url : test");
			
			RestTemplate oRestTemplate = new RestTemplate();
			
			resultData = oRestTemplate.postForObject(IsBookingEngineUrl + "/json/" + aGbn, oJSONRequest, JSONObject.class);
			
			System.out.println("test res : " + resultData);
			
			try {
				resultCode = resultData.getString("code");
			} catch (Exception e) {
				resultCode = resultData.getString("code");
			}
			
			if(!"1".equals(resultCode)){
				logger.error(resultData.getString("message"));
			}
		} catch (Exception e) {
			resultData.put("code", "00");
			resultData.put("message", "api error : " + e.toString());
			//e.printStackTrace();
			System.err.print("인터페이스 오류!");
		}
		 
		return resultData;	
	}
	
	@Override
	public JSONObject getRentalCarJsonData(HashMap<String, String> bodyDto, String aGbn, String rGbn) throws Exception {
    	JSONObject resultData = new JSONObject();
    	
    	String resultCode = "0";	//웹서비스 오류코드
		String errorMsg = "";
    	
		String IsBookingEngineUrl = propertiesService.getString("api." + aGbn + ".url");
		String gbn = propertiesService.getString("api." + aGbn + "." + rGbn);
		
		try {			
			JSONObject oJSONRequest = new JSONObject();

			JSONObject headerDto = new JSONObject();
			headerDto.put("deviceCd", "MB");
			headerDto.put("agentTy" , "B2C");
			headerDto.put("agentId", "app");
			
			oJSONRequest.put("headerDto", headerDto);
			oJSONRequest.put("bodyDto", bodyDto);
			
			System.out.println("api url : " + IsBookingEngineUrl + gbn);
			System.out.println("reqParam : " + oJSONRequest);
			
			RestTemplate oRestTemplate = new RestTemplate();
			
			String jsonStr = oRestTemplate.postForObject(IsBookingEngineUrl + gbn, bodyDto, String.class);
			
			JSONParser jsonParser = new JSONParser();
			JSONObject oJSONResponse = JSONObject.fromObject(jsonParser.parse(jsonStr));
			
			System.out.println("response : " + oJSONResponse);
			//oJSONResponse.getJSONObject("result").getJSONObject("OTA_VehRetResRS").getJSONObject("VehRetResRSCore").getJSONObject("VehReservation").getJSONObject("VehSegmentCore").getJSONObject("ConfID")
			//oJSONResponse.getString("resultMsg")
			
			if(oJSONResponse != null && oJSONResponse.getString("resultMsg") != null){
				if(rGbn.equals("reserve")){
					resultData = oJSONResponse.getJSONObject("result").getJSONObject("OTA_VehRetResRS").getJSONObject("VehRetResRSCore").getJSONObject("VehReservation").getJSONObject("VehSegmentCore").getJSONObject("ConfID");
				}
				
				resultData.put("message", oJSONResponse.getString("resultMsg"));
			} else {
				if(oJSONResponse == null) {
					errorMsg = "null response";
				} else {
					errorMsg = "null result";
				}
				resultData.put("code", "00");
				resultData.put("message", errorMsg);
			}
		} catch (Exception e) {
			resultData.put("code", "00");
			resultData.put("message", "api error : " + e.toString());
			//e.printStackTrace();
			System.err.print("인터페이스 오류!");
		}
		 
        return resultData;
	}

	@Override
	public JSONObject getHotelJsonRstCancel(JSONObject bodyDto, String aGbn, String rGbn, String custCd) throws Exception {
			
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		HttpSession ssn = req.getSession();
    	
    	String ssnId = ssn.getId();
		//브라우저 확인
		String agent = req.getHeader("User-Agent");
	//	agent = getBrowser(agent);
		
		//ip
        String remoteAddr = req.getHeader("X-FORWARDED-FOR");
        if (remoteAddr == null)
        	remoteAddr = req.getRemoteAddr();
        System.out.println("remoteAddr=" + remoteAddr);
    	

        JSONObject resultData = new JSONObject();
        
        String resultCode = "0";	//웹서비스 오류코드
		String errorMsg = "";
    	
		String IsBookingEngineUrl = propertiesService.getString("api." + aGbn + ".url"); //"http://10.141.1.66/rest/htl/";
		String gbn = propertiesService.getString("api." + aGbn + "." + rGbn);
		
		//global properties가 안읽혀서 임시로 테스트
//		if(rGbn.equals("book.cancel")) {
//			gbn = "bookingCancel";
//		}
		
		try {			
			JSONObject oJSONRequest = new JSONObject();

			JSONObject headerDto = new JSONObject();
			headerDto.put("deviceCd", "MB");
			headerDto.put("agentTy" , "B2C");
			headerDto.put("agentId", "FRONT");
			headerDto.put("userId", custCd);
			headerDto.put("remoteAddr", remoteAddr);
			headerDto.put("userAgent", agent);
			
			oJSONRequest.put("headerDto", headerDto);
			bodyDto.put("sessionId", ssnId);
			oJSONRequest.put("bodyDto", bodyDto);
			
			System.out.println("api url : " + IsBookingEngineUrl + gbn);
			System.out.println("getJsonData reqParam : " + oJSONRequest);
			
			RestTemplate oRestTemplate = new RestTemplate();
			
			JSONObject oJSONResponse = oRestTemplate.postForObject(IsBookingEngineUrl + gbn , oJSONRequest, JSONObject.class);

			int endStr = 4000;
			if(oJSONResponse != null) {
				String resStr = oJSONResponse.toString();
				if(resStr.length() < 4000){
					endStr = resStr.length(); 
				}
				System.out.println("getJsonData response : " + oJSONResponse.toString().substring(0, endStr));
			} else {
				System.out.println("getJsonData response : local null");
			}
			
			String resultNm = "RESULT";
			
			if(oJSONResponse != null && oJSONResponse.getJSONObject(resultNm) != null){
				try {
					resultCode = oJSONResponse.getJSONObject(resultNm).getString("code");
				} catch (Exception e) {
					resultNm = "Result";
					resultCode = oJSONResponse.getJSONObject(resultNm).getString("code");
				}
				
				resultData = oJSONResponse.getJSONObject(resultNm);
				if(!"1".equals(resultCode)){
					logger.error(oJSONResponse.getJSONObject(resultNm).getString("message"));
				}
			} else {
				if(oJSONResponse == null) {
					errorMsg = "null response";
				} else {
					errorMsg = "null result";
				}
				resultData.put("code", "00");
				resultData.put("message", errorMsg);
			}
		} catch (Exception e) {
			resultData.put("code", "00");
			resultData.put("message", "api error : " + e.toString());
			//e.printStackTrace();
			System.err.print("인터페이스 오류!");
		}
		return resultData;
	}
	
	//브라우저 확인
	private String getBrowser(String header) {
	  if (header != null) {
		   if (header.indexOf("Trident") > -1) {
		    return "MSIE";
		   } else if (header.indexOf("Chrome") > -1) {
		    return "Chrome";
		   } else if (header.indexOf("Opera") > -1) {
		    return "Opera";
		   } else if (header.indexOf("iPhone") > -1
		     && header.indexOf("Mobile") > -1) {
		    return "iPhone";
		   } else if (header.indexOf("Android") > -1
		     && header.indexOf("Mobile") > -1) {
		    return "Android";
		   }
	  }
	  return "Firefox";
	}
}
