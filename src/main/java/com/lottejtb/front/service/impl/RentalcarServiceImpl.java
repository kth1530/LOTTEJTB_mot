package com.lottejtb.front.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Service;

import com.lottejtb.api.service.ApiService;
import com.lottejtb.api.service.FURTI0001ResultVO;
import com.lottejtb.comm.service.impl.CommCdServiceImpl;
import com.lottejtb.front.rentcar.service.ReqRentcarCarVO;
import com.lottejtb.front.rentcar.service.RsvRentcarVO;
import com.lottejtb.front.service.FreeCancelReserveVO;
import com.lottejtb.front.service.RentalcarService;
import com.lottejtb.front.service.RentalcarVO;
import com.lottejtb.front.service.ReqMstReserveVO;
import com.lottejtb.front.service.ReqRentcarVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("RentalcarService")
public class RentalcarServiceImpl extends EgovAbstractServiceImpl implements RentalcarService {

	private static final Logger logger = Logger.getLogger(CommCdServiceImpl.class);
	
	@Resource(name = "ApiService")
	private ApiService apiService;
	
    @Resource(name = "RentalcarService")
    private RentalcarService rntService;
	
	@Resource(name="RentalcarDAO")
	private RentalcarDAO rntDao;

	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @Override
	public ArrayList<RentalcarVO> selectListRentalcar (RentalcarVO rntVo) throws Exception {
    	return rntDao.selectListRentalcar(rntVo);
    }
    
    @Override
	public ArrayList<RentalcarVO> selectRentalcarInfo (RentalcarVO rntVo) throws Exception {
    	return rntDao.selectRentalcarInfo(rntVo);
    }
    
    @Override
	public List selectListPlace (HashMap<String, Object> parameter) throws Exception {
    	return rntDao.selectListPlace(parameter);
    }
    
    @Override
    public List selectRentOffice(HashMap<String, Object> paramter) throws Exception{
    	return rntDao.selectRentOffice(paramter);
    }
    
    @Override
    public FURTI0001ResultVO selectRentCarList(ReqRentcarVO rntVo) throws Exception{
    	FURTI0001ResultVO resultData = new FURTI0001ResultVO();

    	try {
    		JSONObject bodyDto = new JSONObject();
    		
    		bodyDto.put("pickupDate", rntVo.getPickupDate());
    		bodyDto.put("pickupTime", rntVo.getPickupTime());
    		bodyDto.put("returnDate", rntVo.getReturnDate());
    		bodyDto.put("returnTime", rntVo.getReturnTime());
    		bodyDto.put("pickupOagCode", rntVo.getPickupOagCode());
    		bodyDto.put("returnOagCode", rntVo.getReturnOagCode());
    		bodyDto.put("country", rntVo.getCountry());
    		
    		/*
    		String urlParameters = rntVo.toString();
    		
    		System.out.println("urlParameters : " + urlParameters);
            int startParam = urlParameters.indexOf("[");
            int endParam = urlParameters.lastIndexOf("]");
            urlParameters = urlParameters.substring(startParam+1, endParam);
            urlParameters = urlParameters.replace(",", "&");
            urlParameters = urlParameters.replace("&#44;", ",");
            urlParameters = urlParameters.replace("<null>", "");
            */
    		
    		JSONObject oJSONResponse = apiService.getRentCarJsonData(bodyDto, "rental", "carList");
    		
    		if("SUCCESS".equals(oJSONResponse.getString("message"))) {
    			ObjectMapper jsonMapper = new ObjectMapper();
    			resultData = jsonMapper.readValue(oJSONResponse.toString(), FURTI0001ResultVO.class);
    		}
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return resultData;    	
    }
    
    @Override
    public List reserveRentalCar(ReqMstReserveVO reqVO, String fitRsvNo) throws Exception{
    	HashMap<String, String> parameter = new HashMap<String, String>();
    	JSONObject resultData = new JSONObject();
    	ArrayList<JSONObject> results = new ArrayList<JSONObject>();
    	boolean successYn = true;
    	
    	for(ReqRentcarCarVO carVO : reqVO.getRentcarReserve()){
    		parameter.clear();
    		
    		parameter.put("supplier", carVO.getSupplier());
    		parameter.put("carCode", carVO.getCarCode());
    		parameter.put("paymentGb", carVO.getPaymentGb());
    		parameter.put("fitRsvNo", fitRsvNo);
    		parameter.put("nationCd", carVO.getNationCd());
    		parameter.put("rateCode", carVO.getRateCode());
    		parameter.put("pcNo", carVO.getPcNo());
    		parameter.put("pickupLoc", carVO.getPickupLoc());
    		parameter.put("pickupDt", carVO.getPickupDt());
    		parameter.put("pickupHm", carVO.getPickupHm());
    		parameter.put("rtLoc", carVO.getRtLoc());
    		parameter.put("rtDt", carVO.getRtDt());
    		parameter.put("rtHm", carVO.getRtHm());
    		parameter.put("operAgeGb", carVO.getOperAgeGb());
    		parameter.put("operNmKr", carVO.getOperNmKr());
    		parameter.put("operSurNm", carVO.getOperSurNm());
    		parameter.put("operGivenNm", carVO.getOperGivenNm());
    		parameter.put("telAreaNo", carVO.getTelAreaNo());
    		parameter.put("telNo", carVO.getTelNo());
    		parameter.put("emailAddr", carVO.getEmailAddr());
    		parameter.put("equipTyCd1", carVO.getEquipTyCd1());
    		parameter.put("equipTyCd2", carVO.getEquipTyCd2());
    		parameter.put("equipTyCd3", carVO.getEquipTyCd3());
    		parameter.put("equipTyCd4", carVO.getEquipTyCd4());
    		parameter.put("equipTyCd1Qty", carVO.getEquipTyCd1Qty());
    		parameter.put("equipTyCd2Qty", carVO.getEquipTyCd2Qty());
    		parameter.put("equipTyCd3Qty", carVO.getEquipTyCd3Qty());
    		parameter.put("equipTyCd4Qty", carVO.getEquipTyCd4Qty());
    		parameter.put("memo", carVO.getMemo());
    		parameter.put("userId", carVO.getUserId());
            
    		resultData = apiService.getRentalCarJsonData(parameter, "rental", "reserve");
    		
    		if(resultData.get("message").equals("success")){
    			results.add(resultData);
    		}else{
    			successYn = false;
    			break;
    		}
    	}
    	
    	if(!successYn){
    		HashMap<String, String> cancelParam = new HashMap<String, String>();
    		for(int j = 0; j < results.size(); j++){
    			cancelParam.clear();
    			
    			cancelParam.put("rsvConfId", results.get(j).get("ID").toString());
    			cancelParam.put("rsvConfName", reqVO.getRentcarReserve().get(j).getOperSurNm());
    			cancelParam.put("userId", reqVO.getRentcarReserve().get(j).getUserId());
    			
    			apiService.getRentalCarJsonData(cancelParam, "rental", "cancel");
    		}
    		
    		results.clear();
    		JSONObject cancelData = new JSONObject();
    		cancelData.put("message", "error");
    		
    		//results.add(cancelData);
    	}
    	
    	return results;
    }
    
    @Override
    public List selectRentcarRsvList(RsvRentcarVO resVO) throws Exception{
    	return rntDao.selectRentcarRsvList(resVO); 
    }
    
    @Override
    public HashMap<String, Object> reserveCancelRentalCar(FreeCancelReserveVO vo) throws Exception{
    	HashMap<String, Object> result = new HashMap<String, Object>();
    	HashMap<String, String> cancelParam = new HashMap<String, String>();
    	JSONObject cancelResult = new JSONObject();
    	
		cancelParam.clear();
		
		cancelParam.put("rsvConfId", vo.getSuplrRsvNo());
		cancelParam.put("rsvConfName", vo.getOperSurName());
		cancelParam.put("userId", vo.getMstRsvNmId());
		
		cancelResult = apiService.getRentalCarJsonData(cancelParam, "rental", "cancel");
		
		
		result.put("resultMsg", cancelResult.get("message"));
		
		if(cancelResult.get("message").equals("success")){
			result.put("resultCode", "1");
		}else{
			result.put("resultCode", "0");
		}
		
    	
    	return result;
    }
}
