package com.lottejtb.front.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.ehcache.Ehcache;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.lottejtb.comm.util.CommInfo;
import com.lottejtb.front.air.service.AirService;
import com.lottejtb.front.air.service.AirVO;
import com.lottejtb.front.air.service.ReqAirPnrInfoVO;
import com.lottejtb.front.air.service.ReqAirRsvSyncVO;
import com.lottejtb.front.air.vo.ReqAirInfoVO;
import com.lottejtb.front.air.vo.ReqAirListVO;
import com.lottejtb.front.service.SearchCityVO;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 1. 기능 : 항공 Controller
 * 2. 처리 개요 : 항공 검색에 대한 로직을 처리한다.
 * 3. 주의사항 : 
 * 4. 작성자 / 작성일 : / 2016.11.02
 * =======================================
 * 5. 수정사항
 * 5.1 요구사항ID : 
 *  - 수정자/수정일 : 
 *  - 수정사유/내역
 * =======================================
 * @author Administrator
 * @version : v0.1
 * @see : 
 * @since : J2EE 1.7 
 **/

@Controller
@RequestMapping(value = "/fit/air")
public class AirController {
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	private final Logger logger = Logger.getLogger(AirController.class);
	private final String _rootPath = "/fit/air/";
	
	@Resource(name = "AirService")
	private AirService airService;

    @Resource(name = "ehcache")
    Ehcache ehcache;
	
	/**
	 * 1. 기능 : 항공권 검색 리스트 페이지 호출
	 * ======================================
	 * 4. 작성자 / 작성일 : 윤영민 / 2016-12-06
	 * ======================================
	 * 5. 수정사항
	 * 5.1 요구사항 ID : 
	 *  - 수정자 / 수정일 :
	 *  - 수정사유 / 내역 :
	 * ======================================
	 * @param  
	 * @return
	 */
	@RequestMapping(value = "/searchMain.do")
	public String airSearchMain(HttpServletRequest request, Model model) {
		String selAir = request.getParameter("selAir");
		String selHotel = request.getParameter("selHotel");
		String selRentcar = request.getParameter("selRentcar");
		
		model.addAttribute("selAir", selAir);
		model.addAttribute("selHotel", selHotel);
		model.addAttribute("selRentcar", selRentcar);
		
		return _rootPath + "airSearchMain";
	}
	
	/**
	 * 1. 기능 : 항공권 리스트 조회/검색
	 * ======================================
	 * 4. 작성자 / 작성일 : 윤영민 / 2016-12-06
	 * ======================================
	 * 5. 수정사항
	 * 5.1 요구사항 ID : 
	 *  - 수정자 / 수정일 :
	 *  - 수정사유 / 내역 :
	 * ======================================
	 * @param  	AirSearchVO
	 * @return	json
	 * @throws
	 */
	@RequestMapping(value = "/listSearchAjax.do")
	public String searchAirList(@RequestBody ReqAirListVO reqVO, HttpServletRequest request, Model model) throws Exception {
		
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
	    
		String custCd = "";
		String knm = "";
		String age = "";
		String sex = "";
		String id = "";
		String email = "";
		String custGradeCd = "";
		String birthday = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
			if(sessionParam.get("knm") != null)
				knm = sessionParam.get("knm").toString();
			if(sessionParam.get("age") != null)
				age = sessionParam.get("age").toString();
			if(sessionParam.get("sex") != null)
				sex = sessionParam.get("sex").toString();
			if(sessionParam.get("id") != null)
				id = sessionParam.get("id").toString();
			if(sessionParam.get("email") != null)
				email = sessionParam.get("email").toString();
			if(sessionParam.get("custGradeCd") != null)
				custGradeCd = sessionParam.get("custGradeCd").toString();
			if(sessionParam.get("birthday") != null)
				birthday = sessionParam.get("birthday").toString();
		}
		
//		FUARI0002VO resultVal = new FUARI0002VO();
		JSONObject resultVal = airService.selectListAirFare2(reqVO, custCd);
		
//		try {
//			Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");
//			
//			ObjectMapper jsonMapper = new ObjectMapper();
//			Element listCache = cache.get("airList"+jsonMapper.writeValueAsString(reqVO));
//			
//			if( listCache == null ){
////	            System.out.println("//NO Cache");
//				resultVal = airService.selectListAirFare(reqVO, request);
//				//결과값이 있을 경우 ehcache에 담는다. 1000초 유지
//				if(resultVal.getCode() != null && !"".equals(resultVal.getCode())){
////					 cache.put(new Element("airList"+jsonMapper.writeValueAsString(reqVO), resultVal));
//				}
//	        }else{
////	        	System.out.println("//IN Cache");
//				resultVal = (FUARI0002VO) listCache.getObjectValue();
//	        }
//			
//		} catch (Exception e) {
//			logger.error("컨트롤러도 에러난다!!!!!!!");
//			e.printStackTrace();
//		}

		model.addAttribute("result", resultVal);
		return "jsonview";
	}
	
	
	/**
	public String searchAirList(@RequestBody ReqAirListVO reqVO, HttpServletRequest request, Model model) throws Exception {

		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
	    
		String custCd = "";
		String knm = "";
		String age = "";
		String sex = "";
		String id = "";
		String email = "";
		String custGradeCd = "";
		String birthday = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
			if(sessionParam.get("knm") != null)
				knm = sessionParam.get("knm").toString();
			if(sessionParam.get("age") != null)
				age = sessionParam.get("age").toString();
			if(sessionParam.get("sex") != null)
				sex = sessionParam.get("sex").toString();
			if(sessionParam.get("id") != null)
				id = sessionParam.get("id").toString();
			if(sessionParam.get("email") != null)
				email = sessionParam.get("email").toString();
			if(sessionParam.get("custGradeCd") != null)
				custGradeCd = sessionParam.get("custGradeCd").toString();
			if(sessionParam.get("birthday") != null)
				birthday = sessionParam.get("birthday").toString();
		}
		
		FUARI0002VO resultVal = new FUARI0002VO();		
		try {
			Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");
			
			ObjectMapper jsonMapper = new ObjectMapper();
			Element listCache = cache.get("airList"+jsonMapper.writeValueAsString(reqVO));
			
			if( listCache == null ){
	            System.out.println("//NO Cache");
				resultVal = airService.selectListAirFare(reqVO, custCd);
				//결과값이 있을 경우 ehcache에 담는다. 1000초 유지
				if(resultVal.getCode() != null && !"".equals(resultVal.getCode())){
					cache.put(new Element("airList"+jsonMapper.writeValueAsString(reqVO), resultVal));
				}
	        }else{
	        	System.out.println("//IN Cache");
				resultVal = (FUARI0002VO) listCache.getObjectValue();
	        }
			
		} catch (Exception e) {
			logger.error("컨트롤러도 에러난다!!!!!!!");
			e.printStackTrace();
		}

		model.addAttribute("result", resultVal);
		return "jsonview";
	}
	**/
	/**
	 * 1. 기능 : 항공권 상세보기 조회
	 * 2. 처리개요 : 
	 * 3. 주의사항 : 
	 * ======================================
	 * 4. 작성자 / 작성일 : 
	 * ======================================
	 * 5. 수정사항
	 * 5.1 요구사항 ID : 
	 *  - 수정자 / 수정일 :
	 *  - 수정사유 / 내역 :
	 * ======================================
	 * @param  
	 * @return
	 * @throws
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/viewInfo.do")
	public String viewAirinfo(@RequestBody ReqAirInfoVO reqVO, HttpServletRequest request, Model model) throws Exception {

		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
	    
		String custCd = "";
		String knm = "";
		String age = "";
		String sex = "";
		String id = "";
		String email = "";
		String custGradeCd = "";
		String birthday = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
			if(sessionParam.get("knm") != null)
				knm = sessionParam.get("knm").toString();
			if(sessionParam.get("age") != null)
				age = sessionParam.get("age").toString();
			if(sessionParam.get("sex") != null)
				sex = sessionParam.get("sex").toString();
			if(sessionParam.get("id") != null)
				id = sessionParam.get("id").toString();
			if(sessionParam.get("email") != null)
				email = sessionParam.get("email").toString();
			if(sessionParam.get("custGradeCd") != null)
				custGradeCd = sessionParam.get("custGradeCd").toString();
			if(sessionParam.get("birthday") != null)
				birthday = sessionParam.get("birthday").toString();
		}		
//		Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");
//		ObjectMapper jsonMapper = new ObjectMapper();
//		
//		ArrayList<FUARI0005VO> flightInfo = new ArrayList<FUARI0005VO>();
		//FUARI0006VO pricing = new FUARI0006VO();	
		//JSONObject resultobj = new JSONObject();
		
		 JSONArray resultobj = airService.selectFlightInfo2(reqVO, custCd);
		 JSONObject pricing = airService.selectAirPricing2(reqVO, custCd);
		/*try {
			
			Element flightCache = cache.get("FlightInfo"+jsonMapper.writeValueAsString(reqVO));
			
			if( flightCache == null ){
	            System.out.println("//NO Cache");
	           //flightInfo = airService.selectFlightInfo(reqVO, request);
	            resultobj = airService.selectFlightInfo(reqVO, request);
	            
	            boolean chkData = false;
	            
	            if(flightInfo != null && flightInfo.size() > 0){
	            	chkData = true;
		            for(int c_idx=0; c_idx<flightInfo.size(); c_idx++){
		            	String tmp_code = flightInfo.get(c_idx).getCode();
		            	if(tmp_code == null || "".equals(tmp_code)){
		            		chkData = false;
		            		break;
		            	}
		            }
	            }
	            if(chkData){
//	            	cache.put(new Element("FlightInfo"+jsonMapper.writeValueAsString(reqVO), flightInfo));
				}
				
	        }else{
	        	System.out.println("//IN Cache");
	        	//flightInfo = (ArrayList<FUARI0005VO>) flightCache.getObjectValue();
	        }
		} catch (Exception e) {
			logger.error("FlightInfo error");
			e.printStackTrace();
		}
		*/
		
//		try {
//			Element pricingCache = cache.get("FareInfo"+jsonMapper.writeValueAsString(reqVO));
//			
//			if( pricingCache == null ){
//	            System.out.println("//NO Cache");
//	            pricing = airService.selectAirPricing(reqVO, request);
//	            
//	            if(pricing.getCode() != null && !"".equals(pricing.getCode())){
////	            	cache.put(new Element("FareInfo"+jsonMapper.writeValueAsString(reqVO), pricing));
//				}
//				
//	        }else{
//	        	System.out.println("//IN Cache");
//	        	pricing = (FUARI0006VO) pricingCache.getObjectValue();
//	        }
//
//		} catch (Exception e) {
//			logger.error("FareInfo error");
//			e.printStackTrace();
//		}
		
		model.addAttribute("flightInfo", resultobj);
		model.addAttribute("pricing", pricing);
				
		return "jsonview";
	}
		
	/**
	public String viewAirinfo(@RequestBody ReqAirInfoVO reqVO, HttpServletRequest request, Model model) throws NumberFormatException {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
	    
		String custCd = "";
		String knm = "";
		String age = "";
		String sex = "";
		String id = "";
		String email = "";
		String custGradeCd = "";
		String birthday = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
			if(sessionParam.get("knm") != null)
				knm = sessionParam.get("knm").toString();
			if(sessionParam.get("age") != null)
				age = sessionParam.get("age").toString();
			if(sessionParam.get("sex") != null)
				sex = sessionParam.get("sex").toString();
			if(sessionParam.get("id") != null)
				id = sessionParam.get("id").toString();
			if(sessionParam.get("email") != null)
				email = sessionParam.get("email").toString();
			if(sessionParam.get("custGradeCd") != null)
				custGradeCd = sessionParam.get("custGradeCd").toString();
			if(sessionParam.get("birthday") != null)
				birthday = sessionParam.get("birthday").toString();
		}
		
		Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");
		ObjectMapper jsonMapper = new ObjectMapper();
		
		ArrayList<FUARI0005VO> flightInfo = new ArrayList<FUARI0005VO>();
		FUARI0006VO pricing = new FUARI0006VO();	
		
		try {
			
			Element flightCache = cache.get("FlightInfo"+jsonMapper.writeValueAsString(reqVO));
			
			if( flightCache == null ){
	            System.out.println("//NO Cache");
	            flightInfo = airService.selectFlightInfo(reqVO, custCd);
	            
	            boolean chkData = false;
	            
	            if(flightInfo != null && flightInfo.size() > 0){
	            	chkData = true;
		            for(int c_idx=0; c_idx<flightInfo.size(); c_idx++){
		            	String tmp_code = flightInfo.get(c_idx).getCode();
		            	if(tmp_code == null || "".equals(tmp_code)){
		            		chkData = false;
		            		break;
		            	}
		            }
	            }
	            if(chkData){
	            	cache.put(new Element("FlightInfo"+jsonMapper.writeValueAsString(reqVO), flightInfo));
				}
				
	        }else{
	        	System.out.println("//IN Cache");
	        	flightInfo = (ArrayList<FUARI0005VO>) flightCache.getObjectValue();
	        }
		} catch (Exception e) {
			logger.error("FlightInfo error");
			e.printStackTrace();
		}
		
		try {
			Element pricingCache = cache.get("FareInfo"+jsonMapper.writeValueAsString(reqVO));
			
			if( pricingCache == null ){
	            System.out.println("//NO Cache");
	            pricing = airService.selectAirPricing(reqVO, custCd);
	            
	            if(pricing.getCode() != null && !"".equals(pricing.getCode())){
	            	cache.put(new Element("FareInfo"+jsonMapper.writeValueAsString(reqVO), pricing));
				}
				
	        }else{
	        	System.out.println("//IN Cache");
	        	pricing = (FUARI0006VO) pricingCache.getObjectValue();
	        }

		} catch (Exception e) {
			logger.error("FareInfo error");
			e.printStackTrace();
		}
		
		model.addAttribute("flightInfo", flightInfo);
		model.addAttribute("pricing", pricing);
				
		return "jsonview";
	}
	**/
	/**
	 * 1. 기능 : 항공권 요금 규정 조회
	 * 2. 처리개요 : 
	 * 3. 주의사항 : 
	 * ======================================
	 * 4. 작성자 / 작성일 : 
	 * ======================================
	 * 5. 수정사항
	 * 5.1 요구사항 ID : 
	 *  - 수정자 / 수정일 :
	 *  - 수정사유 / 내역 :
	 * ======================================
	 * @param  
	 * @return
	 * @throws
	 */
	@RequestMapping(value = "/viewFareCerti.do")
	// public String viewAirFareCerti(@RequestBody ReqAirInfoVO reqVO, HttpServletRequest request, Model model) throws Exception {
	public String viewAirFareCerti(@RequestBody JSONObject reqVO, HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
	    
		String custCd = "";
		String knm = "";
		String age = "";
		String sex = "";
		String id = "";
		String email = "";
		String custGradeCd = "";
		String birthday = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
			if(sessionParam.get("knm") != null)
				knm = sessionParam.get("knm").toString();
			if(sessionParam.get("age") != null)
				age = sessionParam.get("age").toString();
			if(sessionParam.get("sex") != null)
				sex = sessionParam.get("sex").toString();
			if(sessionParam.get("id") != null)
				id = sessionParam.get("id").toString();
			if(sessionParam.get("email") != null)
				email = sessionParam.get("email").toString();
			if(sessionParam.get("custGradeCd") != null)
				custGradeCd = sessionParam.get("custGradeCd").toString();
			if(sessionParam.get("birthday") != null)
				birthday = sessionParam.get("birthday").toString();
		}				
		
		/*FUARI0001VO airFareCerti = new FUARI0001VO();
		
		try {
			Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");
			
			ObjectMapper jsonMapper = new ObjectMapper();
			Element CertiCache = cache.get("airCerti"+jsonMapper.writeValueAsString(reqVO));
			
			if( CertiCache == null ){
	            System.out.println("//NO Cache");
	            airFareCerti = airService.selectAirfareCerti(reqVO, request);
	            
	            if(airFareCerti.getCode() != null && !"".equals(airFareCerti.getCode())){
	            	cache.put(new Element("airCerti"+jsonMapper.writeValueAsString(reqVO), airFareCerti));
				}
	        }else{
	        	System.out.println("//IN Cache");
	        	airFareCerti = (FUARI0001VO) CertiCache.getObjectValue();
	        }
			
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		
		JSONObject airFareCerti = airService.selectAirfareCerti2(reqVO, custCd);
		
		model.addAttribute("fareCerti", airFareCerti);
				
		return "jsonview";
	}	
	
	/**
	 * 1. 기능 : PNR 항공권 요금 규정 조회
	 * 2. 처리개요 : 
	 * 3. 주의사항 : 
	 * ======================================
	 * 4. 작성자 / 작성일 : 
	 * ======================================
	 * 5. 수정사항
	 * 5.1 요구사항 ID : 
	 *  - 수정자 / 수정일 :
	 *  - 수정사유 / 내역 :
	 * ======================================
	 * @param  
	 * @return
	 * @throws
	 */
	@RequestMapping(value = "/viewPnrFareCerti.do")
	public String viewAirPnrFareCerti(@RequestBody ReqAirPnrInfoVO reqVO, HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
	    
		String custCd = "";
		String knm = "";
		String age = "";
		String sex = "";
		String id = "";
		String email = "";
		String custGradeCd = "";
		String birthday = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
			if(sessionParam.get("knm") != null)
				knm = sessionParam.get("knm").toString();
			if(sessionParam.get("age") != null)
				age = sessionParam.get("age").toString();
			if(sessionParam.get("sex") != null)
				sex = sessionParam.get("sex").toString();
			if(sessionParam.get("id") != null)
				id = sessionParam.get("id").toString();
			if(sessionParam.get("email") != null)
				email = sessionParam.get("email").toString();
			if(sessionParam.get("custGradeCd") != null)
				custGradeCd = sessionParam.get("custGradeCd").toString();
			if(sessionParam.get("birthday") != null)
				birthday = sessionParam.get("birthday").toString();
		}				
		
		/*FUARI0001VO airFareCerti = new FUARI0001VO();
		
		try {
			Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");
			
			ObjectMapper jsonMapper = new ObjectMapper();
			Element CertiCache = cache.get("airCerti"+jsonMapper.writeValueAsString(reqVO));
			
			if( CertiCache == null ){
	            System.out.println("//NO Cache");
	            airFareCerti = airService.selectAirfareCerti(reqVO, request);
	            
	            if(airFareCerti.getCode() != null && !"".equals(airFareCerti.getCode())){
	            	cache.put(new Element("airCerti"+jsonMapper.writeValueAsString(reqVO), airFareCerti));
				}
	        }else{
	        	System.out.println("//IN Cache");
	        	airFareCerti = (FUARI0001VO) CertiCache.getObjectValue();
	        }
			
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		
		JSONObject airFareCerti = airService.selectPnrAirfareCerti(reqVO, custCd);
		
		model.addAttribute("fareCerti", airFareCerti);
				
		return "jsonview";
	}	
	
	
	/**
	 * 1. 기능 : PNR 항공권 요금 규정 조회
	 * 2. 처리개요 : 
	 * 3. 주의사항 : 
	 * ======================================
	 * 4. 작성자 / 작성일 : 
	 * ======================================
	 * 5. 수정사항
	 * 5.1 요구사항 ID : 
	 *  - 수정자 / 수정일 :
	 *  - 수정사유 / 내역 :
	 * ======================================
	 * @param  
	 * @return
	 * @throws
	 */
	@RequestMapping(value = "/syncRsvPNR.do")
	public String syncRsvPNR(@RequestBody ReqAirRsvSyncVO reqVO, HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
	    
		String custCd = "";
		String knm = "";
		String age = "";
		String sex = "";
		String id = "";
		String email = "";
		String custGradeCd = "";
		String birthday = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
			if(sessionParam.get("knm") != null)
				knm = sessionParam.get("knm").toString();
			if(sessionParam.get("age") != null)
				age = sessionParam.get("age").toString();
			if(sessionParam.get("sex") != null)
				sex = sessionParam.get("sex").toString();
			if(sessionParam.get("id") != null)
				id = sessionParam.get("id").toString();
			if(sessionParam.get("email") != null)
				email = sessionParam.get("email").toString();
			if(sessionParam.get("custGradeCd") != null)
				custGradeCd = sessionParam.get("custGradeCd").toString();
			if(sessionParam.get("birthday") != null)
				birthday = sessionParam.get("birthday").toString();
		}				
		
		/*FUARI0001VO airFareCerti = new FUARI0001VO();
		
		try {
			Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");
			
			ObjectMapper jsonMapper = new ObjectMapper();
			Element CertiCache = cache.get("airCerti"+jsonMapper.writeValueAsString(reqVO));
			
			if( CertiCache == null ){
	            System.out.println("//NO Cache");
	            airFareCerti = airService.selectAirfareCerti(reqVO, request);
	            
	            if(airFareCerti.getCode() != null && !"".equals(airFareCerti.getCode())){
	            	cache.put(new Element("airCerti"+jsonMapper.writeValueAsString(reqVO), airFareCerti));
				}
	        }else{
	        	System.out.println("//IN Cache");
	        	airFareCerti = (FUARI0001VO) CertiCache.getObjectValue();
	        }
			
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		
		JSONObject airSyncPnr = airService.selectAirRsvSync(reqVO, custCd);
		
		model.addAttribute("syncPnr", airSyncPnr);
				
		return "jsonview";
	}	
	
	
	/**
	public String viewAirFareCerti(@RequestBody ReqAirInfoVO reqVO, HttpServletRequest request, Model model) throws NumberFormatException {

		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
	    
		String custCd = "";
		String knm = "";
		String age = "";
		String sex = "";
		String id = "";
		String email = "";
		String custGradeCd = "";
		String birthday = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
			if(sessionParam.get("knm") != null)
				knm = sessionParam.get("knm").toString();
			if(sessionParam.get("age") != null)
				age = sessionParam.get("age").toString();
			if(sessionParam.get("sex") != null)
				sex = sessionParam.get("sex").toString();
			if(sessionParam.get("id") != null)
				id = sessionParam.get("id").toString();
			if(sessionParam.get("email") != null)
				email = sessionParam.get("email").toString();
			if(sessionParam.get("custGradeCd") != null)
				custGradeCd = sessionParam.get("custGradeCd").toString();
			if(sessionParam.get("birthday") != null)
				birthday = sessionParam.get("birthday").toString();
		}
		
		FUARI0001VO airFareCerti = new FUARI0001VO();
		
		try {
			Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");
			
			ObjectMapper jsonMapper = new ObjectMapper();
			Element CertiCache = cache.get("airCerti"+jsonMapper.writeValueAsString(reqVO));
			
			if( CertiCache == null ){
	            System.out.println("//NO Cache");
	            airFareCerti = airService.selectAirfareCerti(reqVO, custCd);
	            
	            if(airFareCerti.getCode() != null && !"".equals(airFareCerti.getCode())){
	            	cache.put(new Element("airCerti"+jsonMapper.writeValueAsString(reqVO), airFareCerti));
				}
	        
			}else{
	        	System.out.println("//IN Cache");
	        	airFareCerti = (FUARI0001VO) CertiCache.getObjectValue();
	        }
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("fareCerti", airFareCerti);
				
		return "jsonview";
	}
	**/
	/**
	 * 1. 기능 : 도시검색
	 * 2. 처리개요 : 
	 * 3. 주의사항 : 
	 * ======================================
	 * 4. 작성자 / 작성일 : 
	 * ======================================
	 * 5. 수정사항
	 * 5.1 요구사항 ID : 
	 *  - 수정자 / 수정일 :
	 *  - 수정사유 / 내역 :
	 * ======================================
	 * @param  
	 * @return
	 * @throws
	 */
	@RequestMapping(value = "/listCityL.do")
	public String searchCityList(@RequestBody SearchCityVO sVo, HttpServletRequest request, Model model) {
		String sVal = sVo.getSearchVal();
		
		List<?> cityList = new ArrayList<AirVO>();

		try {
			cityList = airService.selectListCity(sVal);
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Select City Error!");
		}
		
		model.addAttribute("cityList", cityList);
				
		return "jsonview";
	}
	
	/**
	 * 1. 기능 : 항공권 요금 규정 조회
	 * 2. 처리개요 : 
	 * 3. 주의사항 : 
	 * ======================================
	 * 4. 작성자 / 작성일 : 
	 * ======================================
	 * 5. 수정사항
	 * 5.1 요구사항 ID : 
	 *  - 수정자 / 수정일 :
	 *  - 수정사유 / 내역 :
	 * ======================================
	 * @param  
	 * @return
	 * @throws
	 */
	@RequestMapping(value = "/getAirSellDate.do")
	public String getAirSellDate(HttpServletRequest request, Model model) throws NumberFormatException {

		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
	    
		String custCd = "";
		String knm = "";
		String age = "";
		String sex = "";
		String id = "";
		String email = "";
		String custGradeCd = "";
		String birthday = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
			if(sessionParam.get("knm") != null)
				knm = sessionParam.get("knm").toString();
			if(sessionParam.get("age") != null)
				age = sessionParam.get("age").toString();
			if(sessionParam.get("sex") != null)
				sex = sessionParam.get("sex").toString();
			if(sessionParam.get("id") != null)
				id = sessionParam.get("id").toString();
			if(sessionParam.get("email") != null)
				email = sessionParam.get("email").toString();
			if(sessionParam.get("custGradeCd") != null)
				custGradeCd = sessionParam.get("custGradeCd").toString();
			if(sessionParam.get("birthday") != null)
				birthday = sessionParam.get("birthday").toString();
		}
		
		JSONObject airSelDate = new JSONObject();
		
		try {

	            System.out.println("//NO Cache");
	            airSelDate = airService.getAirSellDate(custCd);
	            
	
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Cache Error!");
		}
		
		model.addAttribute("airSelDate", airSelDate);
				
		return "jsonview";
	}
		
}