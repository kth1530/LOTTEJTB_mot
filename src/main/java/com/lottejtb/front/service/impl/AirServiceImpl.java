package com.lottejtb.front.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Service;

import com.lottejtb.api.service.ApiService;
import com.lottejtb.api.service.FUARI0001VO;
import com.lottejtb.api.service.FUARI0002VO;
import com.lottejtb.api.service.FUARI0005VO;
import com.lottejtb.api.service.FUARI0006VO;
import com.lottejtb.front.air.service.AirService;
import com.lottejtb.front.air.service.ComNtCdVO;
import com.lottejtb.front.air.service.ReqAirPnrInfoVO;
import com.lottejtb.front.air.service.ReqAirReserveCancelVO;
import com.lottejtb.front.air.service.ReqAirReserveVO;
import com.lottejtb.front.air.service.ReqAirRsvSyncVO;
import com.lottejtb.front.service.ReqReserveVO;
import com.lottejtb.front.air.vo.AirCarrierCdVO;
import com.lottejtb.front.air.vo.AirPaxVO;
import com.lottejtb.front.air.vo.AirRsvMstVO;
import com.lottejtb.front.air.vo.AirSegmentVO;
import com.lottejtb.front.air.vo.AirTasfVO;
import com.lottejtb.front.air.vo.ReqAirInfoVO;
import com.lottejtb.front.air.vo.ReqAirListVO;
import com.lottejtb.front.air.vo.ReqAirSegmentVO;
import com.lottejtb.front.service.ReqAccAddressVO;
import com.lottejtb.front.service.ReqAccContactVO;
import com.lottejtb.front.service.ReqAccMileageVO;
import com.lottejtb.front.service.ReqAccPassportVO;
import com.lottejtb.front.vo.PromotionVo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("AirService")
public class AirServiceImpl extends EgovAbstractServiceImpl implements AirService {

	private static final Logger logger = Logger.getLogger(AirServiceImpl.class);
	
	@Resource(name = "ApiService")
	private ApiService apiService;
	
	@Resource(name="AirDAO")
	private AirDAO airDao;

	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @Resource(name = "ehcache")
    Ehcache ehcache;
    

    /**
     * 항공권 리스트 조회
     */
    @SuppressWarnings("unchecked")
	public JSONObject selectListAirFare2(ReqAirListVO reqVo, String userCode) throws Exception{

//    	FUARI0002VO resultVo = new FUARI0002VO();
    	JSONObject oJSONResponse  = new JSONObject();
    	
		try {			
//			ObjectMapper jsonMapper = new ObjectMapper();
			
			JSONObject bodyDtoObj = JSONObject.fromObject(reqVo);
			
			oJSONResponse = apiService.getAirJsonData(bodyDtoObj, "air", "avail", userCode);
			
//			if(oJSONResponse.getString("code") != null){
//				
//				resultVo = jsonMapper.readValue(oJSONResponse.toString(), FUARI0002VO.class);
//			} 
			
			/* 항공 프로모션가 적용 */
			String resultCd = oJSONResponse.getString("code"); 
			if(resultCd != null && "1".equals(resultCd)){
				JSONArray airList = oJSONResponse.getJSONArray("data");
				Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");

				// 프로모션 정보를 임시 저장할 캐쉬 아이디 생성
    			String tmpId = new SimpleDateFormat("yymmddHHmmss").format(Calendar.getInstance().getTime());
    			String concMix = reqVo.getConcMix();
				for(int i=0; i<airList.size(); i++){
					JSONObject airData = (JSONObject) airList.get(i);
					String gdsTyGb = airData.getString("gdsCd");
					Element listPromCache = cache.get("prom" + gdsTyGb + tmpId);
    				List<PromotionVo> airprom = new ArrayList<PromotionVo>();
    				if( listPromCache == null ){
    					PromotionVo promVo = new PromotionVo();
    					promVo.setGdsTyGb(gdsTyGb);
    					promVo.setConcMix(concMix);
    					airprom = airDao.selectAirPromList(promVo);
    					cache.put(new Element("prom" + gdsTyGb + tmpId, airprom));
        	        }else{
        	        	airprom = (List<PromotionVo>) listPromCache.getObjectValue();
        	        }

					JSONArray paxArr = airData.getJSONArray("paxDataBean");
					
					for(int k=0; k<paxArr.size(); k++){
						JSONObject paxData = paxArr.getJSONObject(k);
						
	    				for(int j=0; j<airprom.size(); j++){
	    					PromotionVo promData = airprom.get(j);
	
	    					if(promData.getAmt() == null || promData.getTyGb() == null || promData.getDiviGb() == null){
	    						continue;
	    					}
	    					
							double amt = Double.parseDouble(promData.getAmt());
							String tyGb = promData.getTyGb();
							String diviGb = promData.getDiviGb();
							
							double newTotal = 0;
							
							String promTxt = "";
							
	    					if((promData.getCarrierCd() == null || promData.getCarrierCd().equals(airData.getString("carrierCd")))
	    							&& (promData.getCabin() == null || promData.getCabin().equals(reqVo.getCabinClas()))){
    							// 프로모션가 적용 범위 - 운임 + tax + tasf
	    						int saleCharge = paxData.getInt("fareCharge") + paxData.getInt("taxCharge"); // + paxData.getInt("tasfCharge"); tasf 제외
    							
    							PromotionVo addPromInfo = new PromotionVo();
	    						addPromInfo.setPromId(promData.getPromId());
	    						addPromInfo.setPromNm(promData.getPromNm());
	    						
	    						if("R".equals(diviGb)) {
	    							
	    							//totRate
	    							double airSalePrice = saleCharge * amt/100;
	    							airSalePrice = Math.round(airSalePrice);
	    							
	    							if("U".equals(tyGb)){
	    								newTotal = saleCharge + airSalePrice;
	    							} else if("D".equals(tyGb)) {
	    								newTotal = saleCharge - airSalePrice;
		    							promTxt = "프로모션<br/>" + String.valueOf(amt) + "% 할인";
	    							}
	    							
	    							addPromInfo.setPromTotal(String.valueOf(airSalePrice));
	    							
	    							addPromInfo.setPromTxt(promTxt);
	    							
	    						} else if ("A".equals(diviGb)){
	
	    							if("U".equals(tyGb)){
	    								newTotal = saleCharge + amt;
	    							} else if("D".equals(tyGb)) {
	    								newTotal = saleCharge - amt;
		    							promTxt = "프로모션<br/>" + String.valueOf(amt) + "원 할인";
	    							}
	    							
	    							addPromInfo.setPromTotal(String.valueOf(amt));
	    							addPromInfo.setPromTxt(promTxt);
	    						}
	    						
	    						addPromInfo.setAplPromTotal(String.valueOf(newTotal));
	    						addPromInfo.setConcMix(promData.getConcMix());
	    						addPromInfo.setTyGb(tyGb);
	    						addPromInfo.setDiviGb(diviGb);
	    						addPromInfo.setAmt(String.valueOf(amt));
	    						
	    	    				paxData.put("promInfo", JSONObject.fromObject(addPromInfo));
	    	    				break;
    						}
    					}
    				}
				}
			}
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		
		return oJSONResponse;
	}
    
    /**
     * 항공 운임정보 조회  
     */
	public JSONObject selectAirPricing2(ReqAirInfoVO reqVo, String userCode) throws Exception{

    	JSONObject pricing = new JSONObject();
				
		try {			
//			ObjectMapper jsonMapper = new ObjectMapper();
			
			JSONObject bodyDtoObj = JSONObject.fromObject(reqVo);
			PromotionVo promInfo = reqVo.getPromInfo();
			
			bodyDtoObj.remove("promInfo");
			
			pricing = apiService.getAirJsonData(bodyDtoObj, "air", "pricing", userCode);
			
//			JSONObject oJSONResponse = apiService.getJsonData(bodyDtoObj, "air", "pricing", req);
//			
//			
//			if(oJSONResponse.getString("code") != null){
//				pricing = jsonMapper.readValue(oJSONResponse.toString(), FUARI0006VO.class);
//			} 
			
			/* 프로모션 적용 - 20170420 */
			String resultCd = pricing.getString("code");
			if(resultCd != null && "1".equals(resultCd)){
				if(promInfo.getPromId() != null && !"".equals(promInfo.getPromId())){
					JSONArray paxInfoArr = pricing.getJSONArray("data");
					
					String promId = promInfo.getPromId();
					double amt = Double.parseDouble(promInfo.getAmt()); 
					String tyGb = promInfo.getTyGb();
					String diviGb = promInfo.getDiviGb();
					
					for(int i=0; i< paxInfoArr.size(); i++){
						JSONObject paxInfo = paxInfoArr.getJSONObject(i);
						int saleTotal = paxInfo.getInt("sellCharge");
    					double newTotal = 0;
    					
    					PromotionVo promVo = new PromotionVo();
    					if("R".equals(diviGb)) {
    						//totRate
    						double airSalePrice = saleTotal * amt/100;
    						airSalePrice = Math.round(airSalePrice);
    						
    						if("U".equals(tyGb)){
    							newTotal = saleTotal + airSalePrice;
    						} else if("D".equals(tyGb)) {
    							newTotal = saleTotal - airSalePrice;
    						}
    						promVo.setPromTotal(String.valueOf(airSalePrice));
        					
    					} else if ("A".equals(diviGb)){
    						if("U".equals(tyGb)){
    							newTotal = saleTotal + amt;
    						} else if("D".equals(tyGb)) {
    							newTotal = saleTotal - amt;
    						}
    						promVo.setPromTotal(String.valueOf(amt));
        					
    					}

						promVo.setPromId(promId);
						promVo.setAplPromTotal(String.valueOf(newTotal));
						paxInfo.put("promInfo", JSONObject.fromObject(promVo));
					}
				}
			}
			
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		
		return pricing;
	}
    
    /**
     * 항공 비행정보 조회
     */
	public JSONArray selectFlightInfo2 (ReqAirInfoVO reqVo, String userCode) throws Exception{
    	
//    	ArrayList<FUARI0005VO> flightInfo = new ArrayList<FUARI0005VO>();
    	JSONArray oJSONResponse = new JSONArray();
    	
		try {			
//			ObjectMapper jsonMapper = new ObjectMapper();
			JSONObject bodyDtoObj = new JSONObject();
			
			bodyDtoObj.put("gdsCd", reqVo.getGdsCd());
			
			ArrayList<ReqAirSegmentVO> segArr = reqVo.getSegmentGroup();
			int arrCnt = segArr.size();
			for(int i=0; i<arrCnt; i++){
				ReqAirSegmentVO tmpVo = segArr.get(i);
				
				bodyDtoObj.put("carrierCd", tmpVo.getCarrierCd());
				bodyDtoObj.put("fltNo", tmpVo.getFltNo());
				bodyDtoObj.put("depDt", tmpVo.getDepDt());
				bodyDtoObj.put("depTm", tmpVo.getDepTm());
				bodyDtoObj.put("depCd", tmpVo.getDepCd());
				bodyDtoObj.put("arrDt", tmpVo.getArrDt());
				bodyDtoObj.put("arrTm", tmpVo.getArrTm());
				bodyDtoObj.put("arrCd", tmpVo.getArrCd());
				try {
					oJSONResponse.add(apiService.getAirJsonData(bodyDtoObj, "air", "flight", userCode));
					/*if(oJSONResponse.getString("code") != null){
						flightInfo.add(jsonMapper.readValue(oJSONResponse.toString(), FUARI0005VO.class));
					}*/
				} catch (Exception e) {
//					System.out.println(i + "번째 오류");
					//e.printStackTrace();
					System.err.println("Objecr Add Error!");
				}
			}
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		
		return oJSONResponse;
	}
    
    /**
     * 항공 운임규정 조회
     */
	public JSONObject selectAirfareCerti2(JSONObject reqVo, String userCode) throws Exception{

    	JSONObject certiInfo = new JSONObject();
		
		try {			
//			ObjectMapper jsonMapper = new ObjectMapper();
			
			JSONObject bodyDtoObj = JSONObject.fromObject(reqVo);

			bodyDtoObj.remove("promInfo");
			
			int chCnt = 0;
			boolean sucessGb = false;
			
			do {
				certiInfo = apiService.getAirJsonData(bodyDtoObj, "air", "fareRule", userCode);
				
				if(certiInfo.get("code") != null && "1".equals(certiInfo.getString("code"))){
					sucessGb = true;
				} else {
					chCnt++;
				}
			} while (!sucessGb && chCnt<10);
			
			
			
			/*if(oJSONResponse.getString("code") != null){
				certiInfo = jsonMapper.readValue(oJSONResponse.toString(), FUARI0001VO.class);
			}*/ 
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		return certiInfo;
	}
    
 	public FUARI0002VO selectListAirFare (ReqAirListVO reqVo, String userCode) throws Exception{

    	FUARI0002VO resultVo = new FUARI0002VO();

		try {			
			ObjectMapper jsonMapper = new ObjectMapper();
			
			JSONObject bodyDtoObj = JSONObject.fromObject(reqVo);
			
			JSONObject oJSONResponse = apiService.getAirJsonData(bodyDtoObj, "air", "avail", userCode);
			
			if(oJSONResponse.getString("code") != null){
				resultVo = jsonMapper.readValue(oJSONResponse.toString(), FUARI0002VO.class);
			} 
			
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		
		return resultVo;
	}
    
	public FUARI0006VO selectAirPricing (ReqAirInfoVO reqVo, String userCode) throws Exception{

    	FUARI0006VO pricing = new FUARI0006VO();
				
		try {			
			ObjectMapper jsonMapper = new ObjectMapper();
			
			JSONObject bodyDtoObj = JSONObject.fromObject(reqVo);
			
			JSONObject oJSONResponse = apiService.getAirJsonData(bodyDtoObj, "air", "pricing", userCode);
			
			
			if(oJSONResponse.getString("code") != null){
				pricing = jsonMapper.readValue(oJSONResponse.toString(), FUARI0006VO.class);
			} 
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		
		return pricing;
	}
    
    @Override
	public ArrayList<FUARI0005VO> selectFlightInfo (ReqAirInfoVO reqVo, String userCode) throws Exception{
    	
    	ArrayList<FUARI0005VO> flightInfo = new ArrayList<FUARI0005VO>();
				
		try {			
			ObjectMapper jsonMapper = new ObjectMapper();
			
			JSONObject bodyDtoObj = new JSONObject();
			
			bodyDtoObj.put("gdsCd", reqVo.getGdsCd());
			
			
			ArrayList<ReqAirSegmentVO> segArr = reqVo.getSegmentGroup();
			int arrCnt = segArr.size();
			for(int i=0; i<arrCnt; i++){
				ReqAirSegmentVO tmpVo = segArr.get(i);
				
				bodyDtoObj.put("carrierCd", tmpVo.getCarrierCd());
				bodyDtoObj.put("fltNo", tmpVo.getFltNo());
				bodyDtoObj.put("depDt", tmpVo.getDepDt());
				bodyDtoObj.put("depTm", tmpVo.getDepTm());
				bodyDtoObj.put("depCd", tmpVo.getDepCd());
				bodyDtoObj.put("arrDt", tmpVo.getArrDt());
				bodyDtoObj.put("arrTm", tmpVo.getArrTm());
				bodyDtoObj.put("arrCd", tmpVo.getArrCd());
				try {
					JSONObject oJSONResponse = apiService.getAirJsonData(bodyDtoObj, "air", "flight", userCode);
					
					if(oJSONResponse.getString("code") != null){
						flightInfo.add(jsonMapper.readValue(oJSONResponse.toString(), FUARI0005VO.class));
					}
				} catch (Exception e) {
					System.out.println(i + "번째 오류");
					//e.printStackTrace();
				}
				 
			}
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		
		return flightInfo;
	}
    
	public FUARI0001VO selectAirfareCerti(ReqAirInfoVO reqVo, String userCode) throws Exception{

    	FUARI0001VO certiInfo = new FUARI0001VO();
		
		try {			
			ObjectMapper jsonMapper = new ObjectMapper();
			
			JSONObject bodyDtoObj = JSONObject.fromObject(reqVo);
			
			JSONObject oJSONResponse = apiService.getAirJsonData(bodyDtoObj, "air", "fareRule", userCode);
			
			if(oJSONResponse.getString("code") != null){
				certiInfo = jsonMapper.readValue(oJSONResponse.toString(), FUARI0001VO.class);
			} 
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		
		return certiInfo;
	}
    
    @Override
	public List<?> selectListCity (String sVal) throws Exception{
		return airDao.selectListCity(sVal);
	}
    
    @Override
	public JSONObject reqAirReserve (ReqAirReserveVO reqVO, String userCode) throws Exception{

    	JSONObject resultInfo = new JSONObject();
		
		try {			
			JSONObject bodyDtoObj = JSONObject.fromObject(reqVO);
			resultInfo = apiService.getAirJsonData(bodyDtoObj, "air", "book", userCode);
			
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		return resultInfo;
	}
    @Override
	public JSONObject saveAirMileage(ReqAccMileageVO reqVO, String userCode) throws Exception{

    	JSONObject resultInfo = new JSONObject();
		
		try {			
			JSONObject bodyDtoObj = JSONObject.fromObject(reqVO);
			resultInfo = apiService.getAirJsonData(bodyDtoObj, "air", "mileage", userCode);
			
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		return resultInfo;
	}
    @Override
    public JSONObject saveAirPassport(ReqAccPassportVO reqVO, String userCode) throws Exception{

    	JSONObject resultInfo = new JSONObject();
		
		try {			
			JSONObject bodyDtoObj = JSONObject.fromObject(reqVO);
			resultInfo = apiService.getAirJsonData(bodyDtoObj, "air", "passport", userCode);
			
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		return resultInfo;
	}
    @Override
	public JSONObject saveAirContact(ReqAccContactVO reqVO, String userCode) throws Exception{

    	JSONObject resultInfo = new JSONObject();
		
		try {			
			JSONObject bodyDtoObj = JSONObject.fromObject(reqVO);
			resultInfo = apiService.getAirJsonData(bodyDtoObj, "air", "contact", userCode);
			
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		return resultInfo;
	}

	@Override
	public JSONObject saveAirAddress(ReqAccAddressVO reqVO, String userCode) throws Exception {
		// TODO Auto-generated method stub
    	JSONObject resultInfo = new JSONObject();
		
		try {			
			JSONObject bodyDtoObj = JSONObject.fromObject(reqVO);
			resultInfo = apiService.getAirJsonData(bodyDtoObj, "air", "address", userCode);
			
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		return resultInfo;
	}

	@Override
	public ComNtCdVO selectNtCd(String sVal) throws Exception {
		// TODO Auto-generated method stub
		return airDao.selectNtCd(sVal);
	}

	@Override
	public JSONObject reqAirReserveCancel(ReqAirReserveCancelVO reqVO, String userCode) throws Exception {
		// TODO Auto-generated method stub
	   	JSONObject resultInfo = new JSONObject();
		
		try {			
			JSONObject bodyDtoObj = JSONObject.fromObject(reqVO);
			resultInfo = apiService.getAirJsonData(bodyDtoObj, "air", "cancel", userCode);
			
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		return resultInfo;
	}

	@Override
	public JSONObject getAirSellDate(String userCode) throws Exception {
		// TODO Auto-generated method stub
	   	JSONObject resultInfo = new JSONObject();
		
		try {			
		
			resultInfo = apiService.getAirJsonData(null, "air", "selldate", userCode);
			
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		return resultInfo;
	}
	
	/**
     * 항공 탑승자 리스트
     */
	public List<AirPaxVO> selectAirPaxInfo(ReqReserveVO vo) throws Exception {

		List<AirPaxVO> resultVo = airDao.selectAirPaxInfo(vo);

		return resultVo;
	}

	public List<AirSegmentVO> selectAirSegInfo(ReqReserveVO vo) throws Exception {
		List<AirSegmentVO> resultVo = airDao.selectAirSegInfo(vo);
	
		return resultVo;
	}

	public List<AirTasfVO> selectAirTasf(AirTasfVO vo) throws Exception {
		List<AirTasfVO> result = airDao.selectAirTasf(vo);
		
		return result;
	}

	public String selectCabinNm(String sVal) throws Exception {
		return airDao.selectCabinNm(sVal);
	}

	public String selectAirportNm(String sVal) throws Exception {
		return airDao.selectAirportNm(sVal);
	}

	public EgovMap selectApisVisaInfo(String arrCt) throws Exception {
		return airDao.selectApisVisaInfo(arrCt);
	}

	public AirRsvMstVO selectAirMstInfo(AirRsvMstVO airVo) throws Exception {
		return airDao.selectAirMstInfo(airVo);
	}

	public List<AirCarrierCdVO> selectAirMileageList(AirCarrierCdVO vo)
			throws Exception {
		// TODO Auto-generated method stub
		return airDao.selectAirMileageList(vo);
	}

	/**
     * PNR 항공 운임규정 조회
     */
	public JSONObject selectPnrAirfareCerti(ReqAirPnrInfoVO reqVo,
			String userCode) throws Exception {
		// TODO Auto-generated method stub

    	JSONObject certiInfo = new JSONObject();
		
		try {			
//			ObjectMapper jsonMapper = new ObjectMapper();
			
			JSONObject bodyDtoObj = JSONObject.fromObject(reqVo);

			bodyDtoObj.remove("promInfo");
			
			int chCnt = 0;
			boolean sucessGb = false;
			
			do {
				certiInfo = apiService.getAirJsonData(bodyDtoObj, "air", "pnrFareRule", userCode);
				
				if(certiInfo.get("code") != null && "1".equals(certiInfo.getString("code"))){
					sucessGb = true;
				} else {
					chCnt++;
				}
			} while (!sucessGb && chCnt<1);
			
			
			
			/*if(oJSONResponse.getString("code") != null){
				certiInfo = jsonMapper.readValue(oJSONResponse.toString(), FUARI0001VO.class);
			}*/ 
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		return certiInfo;
	}

	@Override
	public JSONObject selectAirRsvSync(ReqAirRsvSyncVO reqVo, String userCode)
			throws Exception {
		// TODO Auto-generated method stub
    	JSONObject syncInfo = new JSONObject();
		
		try {			
//			ObjectMapper jsonMapper = new ObjectMapper();
			
			JSONObject bodyDtoObj = JSONObject.fromObject(reqVo);

			bodyDtoObj.remove("promInfo");
			
			int chCnt = 0;
			boolean sucessGb = false;
			
			do {
				syncInfo = apiService.getAirJsonData(bodyDtoObj, "air", "pnrFareRule", userCode);
				
				if(syncInfo.get("code") != null && "1".equals(syncInfo.getString("code"))){
					sucessGb = true;
				} else {
					chCnt++;
				}
			} while (!sucessGb && chCnt<1);
			
			
			
			/*if(oJSONResponse.getString("code") != null){
				certiInfo = jsonMapper.readValue(oJSONResponse.toString(), FUARI0001VO.class);
			}*/ 
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		return syncInfo;
	}


}
