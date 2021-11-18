package com.lottejtb.front.service.impl;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Service;

import com.lottejtb.api.service.ApiService;
import com.lottejtb.api.service.FUHTI0001VO;
import com.lottejtb.api.service.FUHTI0002VO;
import com.lottejtb.api.service.FUHTI0002VO.RoomInfos;
import com.lottejtb.api.service.FUHTI0003VO;
import com.lottejtb.api.service.FUHTI0006VO;
import com.lottejtb.comm.service.impl.CommCdServiceImpl;
import com.lottejtb.front.hotel.service.HotelLotteVO;
import com.lottejtb.front.hotel.service.HotelPaymentVO;
import com.lottejtb.front.hotel.service.HotelService;
import com.lottejtb.front.hotel.service.HotelVO;
import com.lottejtb.front.hotel.service.ReqHotelCancelPolicy;
import com.lottejtb.front.hotel.service.ReqHotelInfoVO;
import com.lottejtb.front.hotel.service.ReqHotelRerveInputVO;
import com.lottejtb.front.hotel.service.ReqHotelReserveCancelVO;
import com.lottejtb.front.hotel.service.ReqHotelRoomVO;
import com.lottejtb.front.hotel.service.ReqHotelVO;
import com.lottejtb.front.hotel.service.ReqMapRadarVO;
import com.lottejtb.front.hotel.service.RsvHtlInfoVO;
import com.lottejtb.front.hotel.service.RsvHtlTravlerVO;
import com.lottejtb.front.service.SearchHotelCityVO;
import com.lottejtb.front.vo.PromotionVo;
import com.lottejtb.goods.service.EmsMailSendVO;
import com.lottejtb.prom.service.PromotionHtListVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("HotelService")
public class HotelServiceImpl extends EgovAbstractServiceImpl implements HotelService {
	
@SuppressWarnings("unused")
private static final Logger logger = Logger.getLogger(CommCdServiceImpl.class);
	
	@Resource(name = "ApiService")
	private ApiService apiService;
	
	@Resource(name="HotelDAO")
	private HotelDAO htlDao;

	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @Resource(name = "ehcache")
    Ehcache ehcache;
    
    @Override
   	public FUHTI0001VO selectListHotel(ReqHotelVO htlVo,String custCd) throws Exception {
       	
       	FUHTI0001VO resultData = new FUHTI0001VO();

       	try {
       		ObjectMapper jsonMapper = new ObjectMapper();

               JSONObject oJSONResponse = apiService.getHotelJsonData(JSONObject.fromObject(htlVo), "hotel", "list", custCd);
               
               if("SUCCESS".equals(oJSONResponse.getString("message"))) {
       			 resultData = jsonMapper.readValue(oJSONResponse.toString(), FUHTI0001VO.class);
               }
       		
   		} catch (Exception e) {
   			e.printStackTrace();
   			System.err.println("Hotel Setting Error!");
   		}
       	return resultData;    
   	}
    
	public FUHTI0001VO selectListHotel_bak(ReqHotelVO htlVo,String custCd) throws Exception {
    	
    	FUHTI0001VO resultData = new FUHTI0001VO();

    	try {
    		ObjectMapper jsonMapper = new ObjectMapper();

            JSONObject oJSONResponse = apiService.getHotelJsonData(JSONObject.fromObject(htlVo), "hotel", "list", custCd);
            
            if("SUCCESS".equals(oJSONResponse.getString("message"))) {
    			resultData = jsonMapper.readValue(oJSONResponse.toString(), FUHTI0001VO.class);
    			
    			
    			String hotelNmEn = "";
    			
    			Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");
    			
    			// 환율 정보나 프로모션 정보를 임시 저장할 캐쉬 아이디 생성
    			String tmpId = new SimpleDateFormat("yymmddHHmmss").format(Calendar.getInstance().getTime());
    			
    			HashMap<String, Object> htlNmMap = new HashMap<String, Object>();
    			HashMap<String, Object> param = new HashMap<String, Object>();
    			
    			ArrayList<FUHTI0001VO.Data> aList = resultData.getData();
    			if(aList != null && aList.size() > 0) {
	    			param.put("countryCd", htlVo.getCountryCd());
					
					ArrayList<HashMap<String, Object>> hotelNmList = new ArrayList<HashMap<String, Object>>();
					hotelNmList = htlDao.selectHotelEnList(param);
					
					for(HashMap<String, Object> tempHtlNm : hotelNmList){
						if(tempHtlNm.containsKey("HOTELID")){
							htlNmMap.put(tempHtlNm.get("HOTELID").toString(), tempHtlNm.get("NAME"));
						}
					}
    			}
    			
    			if(aList != null) {
    				for (int i=0; i < aList.size(); i++) {
    					   		
	    					String suplrCd = aList.get(i).getSuplrCd();
	    					String currency = aList.get(i).getRoomDetls().get(0).getCurrencyCd();
	    					String concMix = htlVo.getFitMix();
	    					String checkinDt = htlVo.getCheckInDt();
	    					
	    					if(suplrCd != null) {
	    						
	    						String hotelId = aList.get(i).getHotelId();
	        					//hotelNmEn = htlDao.selectHotelEnName(hotelId);
	        					//if(hotelNmEn == null) hotelNmEn = "";
	    						
	    						if(htlNmMap.containsKey(hotelId)){
	    							hotelNmEn = htlNmMap.get(hotelId).toString();
	    						}else{
	    							hotelNmEn = "";
	    						}
	
	        					
	        					resultData.getData().get(i).setHotelNmEn(hotelNmEn);
	        					
	        					//익스피디어는 기본 USD만 하자
	        					/*if(currency == null || currency.equals("")) {
	        						currency = "USD";
	        						aList.get(i).getRoomDetls().get(0).setCurrencyCd(currency);
	        					}*/
	        					
	    					}
	    					
	    					/*if(currency == null || currency.equals("")) {
	    						//currency = "KRW";
	    						currency = "USD";
	    						aList.get(i).getRoomDetls().get(0).setCurrencyCd(currency);
	    					}
	    					
	    					double rate = 1;
	        				Element listCache = cache.get("exchange"+ currency);
	        				if( listCache == null ){
	
	        					rate = htlDao.selectDestiCurrency(currency);
	        					cache.put(new Element("exchange"+currency, rate));
	            	        }else{
	            	        	rate = (Double) listCache.getObjectValue();
	            	        }
	    					resultData.getData().get(i).getRoomDetls().get(0).setExchangeRate(String.valueOf(rate));
	    					*/
	    			
	    					//프로모션 적용 홈페이지 참조
	    				   /* List<PromotionHtListVO> promList = new ArrayList<PromotionHtListVO>();
	    				    Element listPromCache = cache.get("prom" + suplrCd + concMix + checkinDt + tmpId);
	            			if(listPromCache == null) {
	            				PromotionHtListVO reqVo = new PromotionHtListVO();
	            				reqVo.setSuplrId(suplrCd);
	            				reqVo.setConcMix(concMix);
	            				reqVo.setCheckinDt(checkinDt);
	            				
	            				promList = htlDao.getPromoHtlAmt(reqVo);
	            				cache.put(new Element("prom" + suplrCd + concMix + checkinDt + tmpId, promList));
	            			} else {
	            				promList = (List<PromotionHtListVO>) listPromCache.getObjectValue();
	            			}
	            		
	            			String jtbTotalStr = aList.get(i).getRoomDetls().get(0).getJtbTotal();
	        				double jtbTotal = 0;
	        				
	        				if(jtbTotalStr == null || "".equals(jtbTotalStr)){
	        					jtbTotal = Double.parseDouble(aList.get(i).getRoomDetls().get(0).getAvgRate());
	        					aList.get(i).getRoomDetls().get(0).setJtbTotal(String.valueOf(jtbTotal));
	        					aList.get(i).getRoomDetls().get(0).setJtbBaseTotal(String.valueOf(aList.get(i).getRoomDetls().get(0).getAvgBaseRate()));
	        				} else {
	        					jtbTotal = Double.parseDouble(aList.get(i).getRoomDetls().get(0).getJtbTotal());
	        				}
	            			
	        				aList.get(i).getRoomDetls().get(0).setAplPromTotal(String.valueOf(jtbTotal));
	        				
	            			for(int j=0; j < promList.size(); j++) {
	            				PromotionHtListVO promData = promList.get(j);

	        					if(promData.getAmt() == null || promData.getTyGb() == null || promData.getDiviGb() == null){
	        						continue;
	        					}
	        					
	    						double amt = Double.parseDouble(promData.getAmt());
	    						String tyGb = promData.getTyGb();
	    						String diviGb = promData.getDiviGb();
	    						
	    						double newTotal = 0;
	    						String promTxt = "";
	    						
	        					if(promData.getHtlCd() != null && promData.getHtlCd().equals(aList.get(i).getHotelId())){

	        						PromotionHtListVO addPromInfo = new PromotionHtListVO();
	        						addPromInfo.setPromId(promData.getPromId());
	        						addPromInfo.setAmt(String.valueOf(amt));
	        						addPromInfo.setTyGb(tyGb);
	        						addPromInfo.setDiviGb(diviGb);
	        						
	        						if(promList.get(j).getCoalCardGb() != null){
	    								String cardNm = promList.get(j).getCoalCardNm();
	    								if(cardNm.indexOf("카드") == -1){
	    									cardNm = cardNm + "카드";
	    								}
	    								promTxt = cardNm + " : ";  
	    								
	    								addPromInfo.setCoalCardGb(promList.get(j).getCoalCardGb());
	    								addPromInfo.setCoalCardNm(cardNm);
	    							} else {
	    								//promTxt = "프로모션 : ";
	    							}
	        						
	        						if("R".equals(diviGb)) {
	        							
	        							double htlSalePrice = jtbTotal * amt /100;
	        							htlSalePrice = Math.round(htlSalePrice);
	        							
	        							if("U".equals(tyGb)){
	        								newTotal = jtbTotal + htlSalePrice;
	        							} else if("D".equals(tyGb)) {
	        								newTotal = jtbTotal - htlSalePrice;
	    									promTxt = "프로모션 : " + String.valueOf(amt) + "% 할인";
	        							}
	        							
	        							addPromInfo.setPromTotal(String.valueOf(htlSalePrice));
	        							addPromInfo.setPromTxt(promTxt);
	        							
	        						} else if ("A".equals(diviGb)){

	        							if("U".equals(tyGb)){
	        								newTotal = jtbTotal + amt;
	        							} else if("D".equals(tyGb)) {
	        								newTotal = jtbTotal - amt;
	        								DecimalFormat df = new DecimalFormat("#,##0");
	            							promTxt = "프로모션 : " +  df.format(amt) + "원 할인";
	        							}
	        							
	        							addPromInfo.setPromTotal(String.valueOf(amt));
	        							addPromInfo.setPromTxt(promTxt);
	        						}
	        						
	        						addPromInfo.setAplPromTotal(String.valueOf(newTotal));
	        						addPromInfo.setConcMix(promData.getConcMix());
	        						aList.get(i).getRoomDetls().get(0).setPromInfo(addPromInfo);
	        						break;
	        					}
	        					
	        					if(promData.getHtlCd() == null && promData.getHtlCtCd() != null && promData.getHtlCtCd().equals(aList.get(i).getCityCd())){
	        						
	        						PromotionHtListVO addPromInfo = new PromotionHtListVO();
	        						addPromInfo.setPromId(promData.getPromId());
	        						addPromInfo.setAmt(String.valueOf(amt));
	        						addPromInfo.setTyGb(tyGb);
	        						addPromInfo.setDiviGb(diviGb);
	        						
	        						if("R".equals(diviGb)) {
	        							
	        							//totRate
	        							double htlSalePrice = jtbTotal * amt/100;
	        							htlSalePrice = Math.round(htlSalePrice);
	        							
	        							if("U".equals(tyGb)){
	        								newTotal = jtbTotal + htlSalePrice;
	        							} else if("D".equals(tyGb)) {
	        								newTotal = jtbTotal - htlSalePrice;
	            							promTxt = "프로모션 : " + String.valueOf(amt) + "% 할인";
	        							}
	        							
	        							addPromInfo.setPromTotal(String.valueOf(htlSalePrice));
	        							addPromInfo.setPromTxt(promTxt);
	        							
	        						} else if ("A".equals(diviGb)){

	        							if("U".equals(tyGb)){
	        								newTotal = jtbTotal + amt;
	        							} else if("D".equals(tyGb)) {
	        								newTotal = jtbTotal - amt;
	        								DecimalFormat df = new DecimalFormat("#,##0");
	            							promTxt = "프로모션 : " +  df.format(amt) + "원 할인";
	        							}
	        							
	        							addPromInfo.setPromTotal(String.valueOf(amt));
	        							addPromInfo.setPromTxt(promTxt);
	        						}
	        						
	        						addPromInfo.setAplPromTotal(String.valueOf(newTotal));
	        						addPromInfo.setConcMix(promData.getConcMix());
	        						aList.get(i).getRoomDetls().get(0).setPromInfo(addPromInfo);
	        						break;
	        					}
	        					
	        					if(promData.getHtlCd() == null && promData.getHtlCtCd() == null && promData.getHtlNationCd() != null && promData.getHtlNationCd().equals(aList.get(i).getCountryCd())){
	        						
	        						PromotionHtListVO addPromInfo = new PromotionHtListVO();
	        						addPromInfo.setPromId(promData.getPromId());
	        						addPromInfo.setAmt(String.valueOf(amt));
	        						addPromInfo.setTyGb(tyGb);
	        						addPromInfo.setDiviGb(diviGb);
	        						
	        						if("R".equals(diviGb)) {
	        							
	        							//totRate
	        							double htlSalePrice = jtbTotal * amt/100;
//	        							htlSalePrice = Math.round(htlSalePrice);	// 반올림은 최종단계에서..
	        							
	        							if("U".equals(tyGb)){
	        								newTotal = jtbTotal + htlSalePrice;
	        							} else if("D".equals(tyGb)) {
	        								newTotal = jtbTotal - htlSalePrice;
	            							promTxt = "프로모션 :" + String.valueOf(amt) + "% 할인";
	        							}
	        							
	        							addPromInfo.setPromTotal(String.valueOf(htlSalePrice));
	        							addPromInfo.setPromTxt(promTxt);
	        							
	        						} else if ("A".equals(diviGb)){

	        							if("U".equals(tyGb)){
	        								newTotal = jtbTotal + amt;
	        							} else if("D".equals(tyGb)) {
	        								newTotal = jtbTotal - amt;
	            							promTxt = "프로모션 :" + String.valueOf(amt) + "원 할인";
	        							}
	        							
	        							addPromInfo.setPromTotal(String.valueOf(amt));
	        							addPromInfo.setPromTxt(promTxt);
	        						}
	        						
	        						addPromInfo.setAplPromTotal(String.valueOf(newTotal));
	        						addPromInfo.setConcMix(promData.getConcMix());
	        						aList.get(i).getRoomDetls().get(0).setPromInfo(addPromInfo);
	        						break;
	        					}
	        					
	        					if(promData.getHtlCd() == null && promData.getHtlCtCd() == null && promData.getHtlNationCd() == null) {
	        						
	        						PromotionHtListVO addPromInfo = new PromotionHtListVO();
	        						addPromInfo.setPromId(promData.getPromId());
	        						addPromInfo.setAmt(String.valueOf(amt));
	        						addPromInfo.setTyGb(tyGb);
	        						addPromInfo.setDiviGb(diviGb);
	        						
	        						if("R".equals(diviGb)) {
	        							
	        							//totRate
	        							double htlSalePrice_tmp = jtbTotal * amt/100;
	        							int htlSalePrice = (int) Math.round(htlSalePrice_tmp);
	        							
	        							if("U".equals(tyGb)){
	        								newTotal = jtbTotal + htlSalePrice;
	        							} else if("D".equals(tyGb)) {
	        								newTotal = jtbTotal - htlSalePrice;
	            							promTxt = "프로모션 :" + String.valueOf(amt) + "% 할인";
	        							}
	        							
	        							addPromInfo.setPromTotal(String.valueOf(htlSalePrice));
	        							addPromInfo.setPromTxt(promTxt);
	        							
	        						} else if ("A".equals(diviGb)){

	        							if("U".equals(tyGb)){
	        								newTotal = jtbTotal + amt;
	        							} else if("D".equals(tyGb)) {
	        								newTotal = jtbTotal - amt;
	        								String strAmt = String.valueOf((int) amt);
	        								String retValue = "";
	        								if(strAmt.length() > 0){
	        									for(int m=1; m<=strAmt.length(); m++ ){
	        										if(m > 1 && (m%3)==1) {
	    	    										retValue = strAmt.charAt(strAmt.length() - m) + "," + retValue;
	    	    									} else {
	    	    										retValue = strAmt.charAt(strAmt.length() - m) + retValue;
	    	    									}
	    	    								}
	        								}
	        								
	            							promTxt += retValue + "원 할인";
	        							}
	        							
	        							addPromInfo.setPromTotal(String.valueOf((int) Math.floor(amt)));
	        							addPromInfo.setPromTxt(promTxt);
	        						}
	        						
	        						addPromInfo.setAplPromTotal(String.valueOf(newTotal));
	        						addPromInfo.setConcMix(promData.getConcMix());
	        						aList.get(i).getRoomDetls().get(0).setPromInfo(addPromInfo);
	        						break;
	        					}
	        					
	        				}*/
	            			
	//            			if(promList != null) {
	//	            				for(int j=0; j < promList.size(); j++) {
	//	            					PromotionHtListVO promData = promList.get(j);
	//	            					
	//	            					double amt = Double.parseDouble(promData.getAmt());
	//	            					//if(promData.getHtlCd() != null 
	//	            					//		&& promData.getHtlCd().equals(aList.get(i).getHotelId())) {
	//		            					PromotionHtListVO addPromInfo = new PromotionHtListVO();
	//		            					addPromInfo.setPromId(promData.getPromId());
	//		            					addPromInfo.setConcMix(promData.getConcMix());
	//		            					addPromInfo.setAmt(String.valueOf(amt));
	//		            					addPromInfo.setTyGb(promData.getTyGb());
	//		            					addPromInfo.setDiviGb(promData.getDiviGb());
	//		            					addPromInfo.setConcMix(promData.getConcMix());
	//		            					addPromInfo.setHtlCd(promData.getHtlCd());
	//		            					addPromInfo.setHtlCtCd(promData.getHtlCtCd());
	//		            					addPromInfo.setHtlNationCd(promData.getHtlNationCd());
	//		            					aList.get(i).getRoomDetls().get(0).setPromInfo(addPromInfo);
	//	            					//}
	//	            					break;
	//	            					
	//	            				}
	//            			   }
            				
            			}
        				
    				
    				}
    				
    			}
    			
    		
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Hotel Setting Error!");
		}
    	return resultData;    
	}

	@Override
	public FUHTI0002VO selectListHotelRoom(ReqHotelRoomVO htlVo,String custCd) throws Exception {
		FUHTI0002VO resultData = new FUHTI0002VO();
		
    	try {
    		ObjectMapper jsonMapper = new ObjectMapper();
    		
    		JSONObject reqObj = JSONObject.fromObject(htlVo);
    							
    		PromotionHtListVO promData = null;//htlVo.getPromInfo();
    		
    		reqObj.remove("promInfo");
            JSONObject oJSONResponse = apiService.getHotelJsonData(reqObj, "hotel", "room.list", custCd);
    		
    		if("SUCCESS".equals(oJSONResponse.getString("message"))) {
    			resultData = jsonMapper.readValue(oJSONResponse.toString(), FUHTI0002VO.class);
    			/*Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");
    			
    			List<com.lottejtb.api.service.FUHTI0002VO.RoomInfos> roomInfos = resultData.getData().getRoomInfos();
    			
    			String promId = "";
    			String amtStr = ""; 
				String tyGb = "";
				String diviGb = "";
				
				// 환율 정보나 프로모션 정보를 임시 저장할 캐쉬 아이디 생성
    			String tmpId = new SimpleDateFormat("yymmddHHmmss").format(Calendar.getInstance().getTime());
				//프로모션 적용 홈페이지 참조
			    List<PromotionHtListVO> promList = new ArrayList<PromotionHtListVO>();
			    String fitMix = htlVo.getFitMix();
    			String checkIn = htlVo.getCheckInDt();
    			String checkOut = htlVo.getCheckOutDt();
    			
			    Element listPromCache = cache.get("prom" + fitMix + checkIn + checkOut + tmpId);
			    
				if(listPromCache == null) {
    				PromotionHtListVO reqVo = new PromotionHtListVO();
			
    				reqVo.setCheckinDt(checkIn);
    				
    				promList = htlDao.getPromoHtlAmt(reqVo);
    				if(promList != null && promList.size() > 0)
    					cache.put(new Element("prom"+ fitMix + checkIn + checkOut + tmpId, promList));
    			} else {
    				promList = (List<PromotionHtListVO>) listPromCache.getObjectValue();
    			}
			    
				if(promList != null && promList.size() > 0) {
	    			
					for(int i=0; i < promList.size(); i++) {
	    					    				    				
	    				for(int j=0; j < roomInfos.size(); j++) {
	    				
	    						if(promList != null && promList.size() > 0) {
			    					PromotionHtListVO promListData = promList.get(i);
			    					RoomInfos roomData = roomInfos.get(j);
			    				   				
				    				if(promListData.getPromId() != null && !"".equals(promListData.getPromId())){
				    					
						    				amtStr = promListData.getAmt();
						    				tyGb = promListData.getTyGb();
						    				diviGb = promListData.getDiviGb();
						    				promId = promListData.getPromId();
				    				}
			    				}
			 				
			    				int jtbTotal = (int)(Double.parseDouble(resultData.getData().getRoomInfos().get(i).getRateInfos().get(0).getJtbTotal()));
			    				
			    				if(jtbTotal == 0){
			    					double exchangeRate = Double.parseDouble(resultData.getData().getExchangeRate());
			    					double avgRate = Double.parseDouble(resultData.getData().getRoomInfos().get(i).getRateInfos().get(0).getAvgRate());
			    					jtbTotal = (int) Math.ceil(exchangeRate * avgRate);
			    					resultData.getData().getRoomInfos().get(i).getRateInfos().get(0).setJtbTotal(String.valueOf(jtbTotal));
			    				}
			
			    				 프로모션 적용 
			    				if(promId != null && !"".equals(promId)){
									
									PromotionHtListVO promNData = new PromotionHtListVO(); 
			    					
			    					double amt = Double.parseDouble(amtStr);
			    					double newTotal = 0;
			    					if("R".equals(diviGb)) {
			    						//totRate
			    						double htlSalePrice_tmp = jtbTotal * amt/100;
			    						int htlSalePrice = (int) Math.floor(htlSalePrice_tmp);
			
			    						
			    						if("U".equals(tyGb)){
			    							newTotal = jtbTotal + htlSalePrice;
			    						} else if("D".equals(tyGb)) {
			    							newTotal = jtbTotal - htlSalePrice;
			    							promNData.setPromTotal(String.valueOf(htlSalePrice));
			    						}
			    						
			    					} else if ("A".equals(diviGb)){
			    						if("U".equals(tyGb)){
			    							newTotal = jtbTotal + amt;
			    						} else if("D".equals(tyGb)) {
			    							newTotal = jtbTotal - amt;
			    							promNData.setPromTotal(String.valueOf((int) Math.floor(amt)));
			    						}
			    					}
			    					
			    					promNData.setAmt(amtStr);
			    					promNData.setTyGb(tyGb);
			    					promNData.setDiviGb(diviGb);
			    					promNData.setPromId(promId);
			    					
			    					promNData.setAplPromTotal(String.valueOf(newTotal));
			    					roomInfos.get(i).getRateInfos().get(0).setPromInfo(promNData);
			    					System.out.println(promNData);
			    				} 
	    				}
	    			}
				}*/
    			
    		}
    		
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Hotel Room Error!");
		}
    	return resultData;  
	}

    @Override
	public FUHTI0003VO selectListHotelInfo(ReqHotelInfoVO htlVO, String custCd) throws Exception {
    	FUHTI0003VO resultData = new FUHTI0003VO();

    	try {
    		ObjectMapper jsonMapper = new ObjectMapper();
    		
            JSONObject oJSONResponse = apiService.getHotelJsonData(JSONObject.fromObject(htlVO), "hotel", "room.info", custCd);
    		
    		if("SUCCESS".equals(oJSONResponse.getString("message"))) {
    			resultData = jsonMapper.readValue(oJSONResponse.toString(), FUHTI0003VO.class);
    		}
    		
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
    	
    	try {
			if(resultData.getData().getTel() == null || "".equals(resultData.getData().getTel())){
				String hotelId = htlVO.getHotelId();
				EgovMap telInfo = htlDao.selectTelInfo(hotelId);
				resultData.getData().setTel((String) telInfo.get("telNo"));
				resultData.getData().setFax((String) telInfo.get("faxNo"));
			}
		} catch (Exception e) {
			//e.printStackTrace();
		}
    	
    	return resultData;    	
	}
    
    
    /* 호텔패스 GTA 취소정책 */
	@Override
	public FUHTI0006VO getCancelPolicy(ReqHotelCancelPolicy htlCp, String custCd)  throws Exception {
		FUHTI0006VO resultData = new FUHTI0006VO();
		
		try {
			ObjectMapper jsonMapper = new ObjectMapper();
			
			JSONObject oJSONResponse = apiService.getHotelJsonData(JSONObject.fromObject(htlCp), "hotel", "cancelPolicy", custCd);
			if("SUCCESS".equals(oJSONResponse.getString("message"))) {
				resultData = jsonMapper.readValue(oJSONResponse.toString(), FUHTI0006VO.class);
			}
			
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return resultData;
	}
    
    @Override
	public ArrayList<HotelVO> selectHotelInfo(HotelVO htlVo) throws Exception {
		return htlDao.selectHotelInfo(htlVo);
	}

	@Override
	public ArrayList<HotelVO> selectCancelCerti(HotelVO htlVo) throws Exception {
		return htlDao.selectCancelCerti(htlVo); 
	}
	
    @Override
    public  List<?> selectListCity (String sVal, String sDome) throws Exception {
    	return htlDao.selectListCity(sVal, sDome);    	
    }
    
    @Override
	public JSONObject getRadarJsonData(ReqMapRadarVO mapVo) throws Exception {
    	JSONObject resultData = new JSONObject();
    	
    	//?location=51.503186,-0.126446&radius=5000&types=museum&key=AIzaSyD7Ofh1fQwL-osDzzlbdvRjvlG2Y8-nEyU
    	
    	String reqStr = "";
    	reqStr += "location=" + mapVo.getLatitude() + "," + mapVo.getLongitude();	//기�????�치
    	reqStr += "&radius=" + mapVo.getRadius();	//범위
    	reqStr += "&types=" + mapVo.getTypes();		//검?��???
    	reqStr += "&key=" + mapVo.getKey();			//api??
    	reqStr += "&name=";			//api??
    	reqStr += "&language=" + mapVo.getLanguage();
    	
    	try {
    		resultData = apiService.getJsonGetData(reqStr, "google.map", "rdr");
		} catch (Exception e) {
			// TODO: handle exception
			//e.printStackTrace();
			System.err.println("Interface Error!");
		}
    	
    	return resultData;
	}

	@Override
	public JSONObject getRadarDetailData(ReqMapRadarVO mapVo) throws Exception {
		JSONObject resultData = new JSONObject();
    	
    	String reqStr = "placeid=" + mapVo.getPlaceid();
    	reqStr += "&key=" + mapVo.getKey();			//api??
    	reqStr += "&language=" + mapVo.getLanguage();
    	
    	try {
    		resultData = apiService.getJsonGetData(reqStr, "google.map", "dtl");
		} catch (Exception e) {
			// TODO: handle exception
			//e.printStackTrace();
			System.err.println("Interface Error!");
		}
    	return resultData;
	}

	@Override
	public JSONObject getCityLarlon(ReqMapRadarVO mapVo) throws Exception {
		JSONObject resultData = new JSONObject();
		//	xml?address=%EB%89%B4%EC%9A%95&language=ko&sensor=false
    	String reqStr = "address=" + mapVo.getAddress();
    	reqStr += "&language=" + mapVo.getLanguage();
    	reqStr += "&sensor=false";
    	
    	try {
    		resultData = apiService.getJsonGetData(reqStr, "google.geo", "");
		} catch (Exception e) {
			// TODO: handle exception
			//e.printStackTrace();
			System.err.println("Interface Error!");
		}
    	return resultData;
	}
    /**
     * ?�약목록 조회
     * 
     * @param map ?�유?�행?�약번호, ?�약?�형(0: ?�텔, 1: ?�터�?
     * @return ?�약 목록
     */
    public List<EgovMap> selectRsvList(EgovMap map) throws Exception {
        List<EgovMap> rsvList = htlDao.selectRsvList(map);

        try {
            rsvList = htlDao.selectRsvList(map);
        } catch (Exception e) {
            logger.error("hotelServiceImpl.selectRsvList error: " + e.getMessage());
        }
        return rsvList;
    }

    /*
     * 
     *  호텔 예약 
     */
    
	@Override
	public JSONObject reqHotelReserve(ReqHotelRerveInputVO hotelReserve, String fitRsvNo,String custCd) throws Exception {
		JSONObject resultInfo = new JSONObject();
		JSONObject resultCancel = new JSONObject();
		
		try {
			hotelReserve.setFitRsvCd(fitRsvNo); //예약시 생성되는 번호
			JSONObject bodyDtoObj = JSONObject.fromObject(hotelReserve);
			resultInfo = apiService.getHotelJsonData(bodyDtoObj, "hotel", "book", custCd);
			
		} catch (Exception e) {
			logger.error("문서 파싱 중 예외 발생");
			//e.printStackTrace();
		}
		return resultInfo;
	}

	/*
	 * 예약취소
	 */
	@Override
	public JSONObject reqHotelReserveCancel(ReqHotelReserveCancelVO hotelReserveCancel, String fitRsvNo, String custCd) throws Exception {
		JSONObject resultInfo = new JSONObject();
		
		try {
			JSONObject bodyDtoObj = JSONObject.fromObject(hotelReserveCancel);
			resultInfo = apiService.getHotelJsonRstCancel(bodyDtoObj, "hotel", "book.cancel", custCd);
			
			System.out.println(resultInfo.toString());
		} catch(Exception e) {
			//e.printStackTrace();
			System.err.println("Interface Error!");
		}
		return resultInfo;
	}

	@Override
	public List<RsvHtlInfoVO> selectRsvHtlInfo(RsvHtlInfoVO vo)  throws Exception {
		 return (List<RsvHtlInfoVO>)htlDao.selectRsvHtlInfo(vo);
	}

	@Override
	public List<RsvHtlTravlerVO> selectRsvHtlTravler(RsvHtlTravlerVO vo) throws Exception {
		return (List<RsvHtlTravlerVO>)htlDao.selectRsvHtlTravler(vo);
	}

	@Override
	public List<ReqHotelReserveCancelVO> selectRsvHtlCancelInfo(ReqHotelReserveCancelVO vo) throws Exception {
		return (List<ReqHotelReserveCancelVO>)htlDao.selectRsvHtlCancelInfo(vo);
	}

	@Override
	public List<HotelPaymentVO> selectHtlPaymentInfo(String resNo) throws Exception {
		return (List<HotelPaymentVO>)htlDao.selectHtlPaymentInfo(resNo);
	}

	@Override
	public List<HotelLotteVO> selectLotteHtlList(HotelLotteVO vo) throws Exception {
		// TODO Auto-generated method stub
		return (List<HotelLotteVO>) htlDao.selectLotteHtlList(vo);
	}

	@Override
	public void saveEmsMailSend(EmsMailSendVO param) throws Exception {
		 htlDao.insertEmsMailSend(param);
		
	}

	@Override
	public String hotelIdMapping(EgovMap param) throws Exception {
		return (String) htlDao.hotelIdMapping(param);
	}

	@Override
	public List<PromotionHtListVO> getPromotion(PromotionHtListVO promVO)throws Exception {
		return (List<PromotionHtListVO>) htlDao.getPromoHtlAmt(promVO);
	}

	@Override
	public List<SearchHotelCityVO> selectListDomeCityCd() throws Exception {
		return (List<SearchHotelCityVO>) htlDao.selectListDomeCityCd();
	}

	@Override
	public List<SearchHotelCityVO> selectListDomeCityCdDetail() throws Exception {
		return (List<SearchHotelCityVO>) htlDao.selectListDomeCityCdDetail();
	}

}
