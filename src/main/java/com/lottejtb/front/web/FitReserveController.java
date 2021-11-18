package com.lottejtb.front.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.ehcache.Ehcache;
import net.sf.json.JSONObject;

import org.apache.http.util.TextUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.lottejtb.account.service.HtlPaymtService;
import com.lottejtb.comm.util.CommInfo;
import com.lottejtb.front.air.service.AirService;
import com.lottejtb.front.air.service.ComNtCdVO;
import com.lottejtb.front.air.service.ReqAirReserveCancelVO;
import com.lottejtb.front.air.service.RsvAirService;
import com.lottejtb.front.air.service.RsvAirVO;
import com.lottejtb.front.air.vo.AirCarrierCdVO;
import com.lottejtb.front.hotel.service.HotelService;
import com.lottejtb.front.hotel.service.ReqHotelReserveCancelVO;
import com.lottejtb.front.service.FitReserveService;
import com.lottejtb.front.service.FitReserveVO;
import com.lottejtb.front.service.FreeCancelReserveVO;
import com.lottejtb.front.service.FreeReserveService;
import com.lottejtb.front.service.RentalcarService;
import com.lottejtb.front.service.ReqAccAddressVO;
import com.lottejtb.front.service.ReqAccContactVO;
import com.lottejtb.front.service.ReqAccMileageVO;
import com.lottejtb.front.service.ReqAccPassportVO;
import com.lottejtb.front.service.ReqMstReserveVO;
import com.lottejtb.front.service.ReqReserveVO;
import com.lottejtb.front.service.SearchArrCdVO;
import com.lottejtb.goods.service.EmsMailSendVO;
import com.lottejtb.goods.service.SiteGoodsMngService;
import com.lottejtb.reserve.service.ReserveService;
import com.lottejtb.reserve.service.SmsVO;
import com.lottejtb.reserve.service.UmsLogVO;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
@RequestMapping(value = "/fit/rsv")
public class FitReserveController {
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

    private static final Logger logger = LoggerFactory.getLogger(FitReserveController.class);
    private static final String _rootPath = "/fit/rsv/";
	
	@Resource(name = "AirService")
	private AirService airService;
	
	@Resource(name = "HotelService")
	private HotelService hotelService;
	
	@Resource(name = "RentalcarService")
	private RentalcarService rentalcarService;
	
	@Resource(name = "RsvAirService")
	private RsvAirService rsvAirService;
	
	@Resource(name = "FreeReserveService")
	private FreeReserveService freeRserveService;
	
	@Resource(name = "GoodsService")
	private SiteGoodsMngService goodsService;
	
	@Resource(name = "FitReserveService")
	private FitReserveService fitReserveService;
	
	// 예약 정보 관련 서비스 
	@Resource(name = "ReserveService")
	private ReserveService reserveService;
	
	// 결제 취소
	@Resource(name = "HtlPaymtService")
	private HtlPaymtService htlPaymtService;
	
		
    @Resource(name = "ehcache")
    Ehcache ehcache;
    
	
	/**
	 *	자유여행 예약 처리 
	 * @return
	 */
	@RequestMapping(value = "/procRsvAjax.do", method =  {RequestMethod.GET, RequestMethod.POST})
	//public String reserveFreeTravel(@RequestBody ReqAirReserveVO reqVO, HttpServletRequest request, Model model) throws NumberFormatException {ReqMstReserveVO
	public String reserveFreeTravel(@RequestBody ReqMstReserveVO reqVO, HttpServletRequest request, Model model) throws NumberFormatException {
		System.out.println("reserveFreeTravel !!!!! ");
		
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String fitRsvNo = "";
	    
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
		
		JSONObject result = new JSONObject();
		JSONObject airResultVal = new JSONObject();
		JSONObject hotelResultVal = new JSONObject();
		ArrayList rentResultVal = new ArrayList<JSONObject>();
		String limitDate = "";
		boolean nextStepYN = true;
		ReqReserveVO stateVO = new ReqReserveVO();
		RsvAirVO rsvAirResult = null;
		
		try {
			if(reqVO.getReqReserve().getFitRsvNo() == null || reqVO.getReqReserve().getFitRsvNo().equals("null") || reqVO.getReqReserve().getFitRsvNo().equals("")){
				fitRsvNo = freeRserveService.insertFreeReserve(reqVO.getReqReserve());
				reqVO.getReqReserve().setFitRsvNo(fitRsvNo);
			}else{
				fitRsvNo = reqVO.getReqReserve().getFitRsvNo();
			}
			
			if(reqVO.getAirYN().equals("Y")){
				airResultVal = airService.reqAirReserve(reqVO.getAirReserve(), custCd);
				
				if(airResultVal.get("code").equals("1")){
					
					JSONObject data = (JSONObject) airResultVal.get("data");					
					String strAirRsvSeqno = data.get("rsvSeqno").toString();
					System.out.println("strAirRsvSeqno : " + strAirRsvSeqno);
					
					/*********** 항공 결제 시한 및 자유여행 예약 번호 업데이트 ************/
					
					RsvAirVO rsvAirParam = new RsvAirVO();
					rsvAirParam.setAirRsvSeqno(Integer.parseInt(strAirRsvSeqno));					
					rsvAirResult = (RsvAirVO) rsvAirService.selectRsvAir(rsvAirParam);
					
					ReqReserveVO reserveVO = new ReqReserveVO();
					reserveVO.setFitRsvNo(fitRsvNo);
					reserveVO.setAirRsvSeqno(rsvAirParam.getAirRsvSeqno());
					reserveVO.setPaymtTl(rsvAirParam.getPayMtDt());
					
					freeRserveService.updateFreeReserve(reserveVO);
					
					result.put("code", 1);
					result.put("message", "success");
				} else {
					
					/** 항공권 예약 시 오류 코드 8111 : transaction time out ==> 재시도 로직 추가 :: 2017.03.23 **/
					if(airResultVal.get("code").equals("8111")) {
						System.out.println(">>>>>>>>>>>>>>>>>>>>>> Retry Air Reserve !!!!!!!!!!!!!!!!!!!");
						
						airResultVal = airService.reqAirReserve(reqVO.getAirReserve(), custCd);
						System.out.println("Retry airResultVal : " + airResultVal);
						
						/*
						if(!airResultVal.get("code").equals("1")){
							reqVO.getReqReserve().setFitRsvNo(fitRsvNo);
							
							freeRserveService.deleteFreeReserve(reqVO.getReqReserve());
						}
						*/
						
						if(airResultVal.get("code").equals("1")){
							
							JSONObject data = (JSONObject) airResultVal.get("data");					
							String strAirRsvSeqno = data.get("rsvSeqno").toString();
							System.out.println("strAirRsvSeqno : " + strAirRsvSeqno);
							
							/*********** 항공 결제 시한 및 자유여행 예약 번호 업데이트 ************/
							
							RsvAirVO rsvAirParam = new RsvAirVO();
							rsvAirParam.setAirRsvSeqno(Integer.parseInt(strAirRsvSeqno));					
							rsvAirResult = (RsvAirVO) rsvAirService.selectRsvAir(rsvAirParam);
							
							ReqReserveVO reserveVO = new ReqReserveVO();
							reserveVO.setFitRsvNo(fitRsvNo);
							reserveVO.setAirRsvSeqno(rsvAirParam.getAirRsvSeqno());
							reserveVO.setPaymtTl(rsvAirParam.getPayMtDt());
							
							freeRserveService.updateFreeReserve(reserveVO);
							
							result.put("code", 1);
							result.put("message", "success");
						} else {						

							result.put("code", 0);
							result.put("message", "error");
							
							System.out.println("=================항공예약 실패 1 start=====================");
							String errMsg = result.getString("message") + "|" + "항공 예약에 실패했습니다.\n다른 여정을 선택하여 주세요.";
							reqVO.getReqReserve().setErr_msg(errMsg);
							freeRserveService.updateFreeReserve(reqVO.getReqReserve());
							
							reqVO.getReqReserve().setFitRsvNo(fitRsvNo);
							freeRserveService.deleteFreeReserve(reqVO.getReqReserve());
														
							nextStepYN = false;
							System.out.println("=================항공예약 실패 2 end=====================");
						}					
						
					} else {
						result.put("code", 0);
						result.put("message", "error");
						
						System.out.println("=================항공예약 실패 3 start=====================");
						String errMsg = result.getString("message") + "|" + "항공 예약에 실패했습니다.\n다른 여정을 선택하여 주세요.";
						reqVO.getReqReserve().setErr_msg(errMsg);
						freeRserveService.updateFreeReserve(reqVO.getReqReserve());
																
						reqVO.getReqReserve().setFitRsvNo(fitRsvNo);
						freeRserveService.deleteFreeReserve(reqVO.getReqReserve());
						nextStepYN = false;
						System.out.println("=================항공예약 실패 4 end=====================");
					}
				}
			}
			
			if(reqVO.getHotelYN().equals("Y") && nextStepYN){				
				for(int i = 0; i < reqVO.getHotelReserve().getBasketData().size(); i++) {
					hotelResultVal = hotelService.reqHotelReserve(reqVO.getHotelReserve().getBasketData().get(i), fitRsvNo, custCd);
					
					if(hotelResultVal.get("code").equals("1")){
						result.put("code", 1);
						result.put("message", "success");
						
						stateVO.setHtlRsvStateGb("OK");
						//stateVO.setHtlPaymtstateGb("WA");
					} else {
						
						result.put("code", 0);
						result.put("message", "error");
						
						System.out.println("=======================호텔 예약 실패1=============start");
						String errMsg = "호텔 예약에 실패했습니다. \n다른 객실 또는 다른 숙박시설로 예약을 시도하세요.";
						String suplErrMsg = result.getString("message").toLowerCase(); 
						
						// 매진 시
			    		if(suplErrMsg.indexOf("soldout") != -1
			    				|| suplErrMsg.indexOf("sold out") != -1){
			    			
			    			errMsg = "고객님! 죄송합니다. \n해당 호텔은 객실 만실로 인하여 예약이 불가 합니다. \n이용 하신 카드정보는 즉시 승인 취소가 됩니다. \n이용에 불편 끼쳐 드려 대단히 죄송 합니다.";
			    		} else if(suplErrMsg.indexOf("processFail") != -1){
			    			
			    			errMsg = "공급사의 오류로 인해 호텔 예약에 실패했습니다. \n다른 객실 또는 다른 숙박시설로 예약을 시도하세요.";
			    		} else if(suplErrMsg.indexOf("nolonger") != -1){
			    			
			    			errMsg = "호텔 예약에 실패했습니다. \n선택하신 객실은 공급사에서 지원하지 않는 호텔입니다. \n다른 객실 또는 다른 숙박시설로 예약을 시도하세요.";
			    		}

	            		reqVO.getReqReserve().setErr_msg(result.getString("message") + " | " + errMsg);
	            		reqVO.getReqReserve().setHtlRsvStateGb("XX");
			    		//에러 메시지 에러
						freeRserveService.updateFreeReserve(reqVO.getReqReserve());
						
						// 						
						try {
							/*
							stateVO.setFitRsvNo(fitRsvNo);
							stateVO.setHtlRsvStateGb("ER");
							stateVO.setHtlPaymtstateGb("XR");
							stateVO.setUseYn("Y");
							
							freeRserveService.updateFitReserveState(stateVO);
							*/
							System.out.println("========호텔 에러 로직 처리 start=============");
							
							RestTemplate oRestTemplate = new RestTemplate();
							JSONObject reqParam = new JSONObject();
							
							reqParam.put("fitRsvNo", fitRsvNo);
							reqParam.put("cancelReason", "1");
							reqParam.put("msg", "예약실패");
							
							htlPaymtService.cancelPayment(reqParam);						
							
							//예약 취소 api 연동--start
							FreeCancelReserveVO vo = new FreeCancelReserveVO();
							vo.setFitRsvNo(fitRsvNo);
							fitReserveHtlCancel(vo,request,model);
							//예약 취소 api 연동--end
							
							//홈페이지 결제 취소 로직 요청한다.
							//JSONObject oJSONResponse1 = oRestTemplate.postForObject("http://fitdev.lottejtb.com/fit/rsv/paymentCancelAjax.do" , oJSONRequest, JSONObject.class);
							JSONObject oJSONResponse1 = oRestTemplate.postForObject("https://fit.lottejtb.com/fit/rsv/paymentCancelAjax.do" , reqParam, JSONObject.class);
							
							System.out.println("========호텔 에러 로직 처리 end=============");
						} catch (Exception e) {
							//e.printStackTrace();
							System.err.println("Reserve Error!");
						}
						
						if(reqVO.getAirYN().equals("Y")) {
							ReqAirReserveCancelVO airResCancelVO = new ReqAirReserveCancelVO();
							
							airResCancelVO.setRsvSeqno(Integer.parseInt(airResultVal.get("rsvSeqno").toString()));
							
							airService.reqAirReserveCancel(airResCancelVO, custCd);
							
							//항공 예약 실패 시 결제 진행 되면 결제 취소 임시 조치 2019.03.13 bum
							if(!airResultVal.get("code").equals("1") && hotelResultVal.get("code").equals("1")){
								try {
									/*
									stateVO.setFitRsvNo(fitRsvNo);
									stateVO.setHtlRsvStateGb("ER");
									stateVO.setHtlPaymtstateGb("XR");
									stateVO.setUseYn("Y");
									
									freeRserveService.updateFitReserveState(stateVO);
									*/
									System.out.println("========호텔 에러 로직 처리 start=============");
									
									RestTemplate oRestTemplate = new RestTemplate();
									JSONObject reqParam = new JSONObject();
									
									reqParam.put("fitRsvNo", fitRsvNo);
									reqParam.put("cancelReason", "1");
									reqParam.put("msg", "예약실패");
									
									htlPaymtService.cancelPayment(reqParam);						
									
									//예약 취소 api 연동--start
									FreeCancelReserveVO vo = new FreeCancelReserveVO();
									vo.setFitRsvNo(fitRsvNo);
									fitReserveHtlCancel(vo,request,model);
									//예약 취소 api 연동--end
									
									//홈페이지 결제 취소 로직 요청한다.
									//JSONObject oJSONResponse1 = oRestTemplate.postForObject("http://fitdev.lottejtb.com/fit/rsv/paymentCancelAjax.do" , oJSONRequest, JSONObject.class);
									JSONObject oJSONResponse1 = oRestTemplate.postForObject("https://fit.lottejtb.com/fit/rsv/paymentCancelAjax.do" , reqParam, JSONObject.class);
									
									System.out.println("========호텔 에러 로직 처리 end=============");
								} catch (Exception e) {
									//e.printStackTrace();
									System.err.println("Reserve Error!");
								}
							}
						}
						
						freeRserveService.deleteFreeReserve(reqVO.getReqReserve());
						nextStepYN = false;
						
						System.out.println("=======================호텔 예약 실패2===============end");
						break;
					}
				}
			}
			
			if(reqVO.getRentcarYN().equals("Y") && nextStepYN){
				rentResultVal = (ArrayList) rentalcarService.reserveRentalCar(reqVO, fitRsvNo);
				
				if(rentResultVal.size() > 0){
					result.put("code", 1);
					result.put("message", "success");
					
					stateVO.setRntRsvstateGb("OK");
				}else{
					result.put("code", 0);
					result.put("message", "error");
					
					System.out.println("=======================런테카 예약 실패1 start===============");
					String errMsg = result.getString("message") + "|" + "렌터카 예약에 실패했습니다. \n다른 차량이나 다른 영업소로 다시 예약을 시도하여 주세요.";
			    	reqVO.getReqReserve().setErr_msg(errMsg);
			    	//에러 메시지 에러
					freeRserveService.updateFreeReserve(reqVO.getReqReserve());
					
					if(reqVO.getAirYN().equals("Y")) {
						ReqAirReserveCancelVO airResCancelVO = new ReqAirReserveCancelVO();
						
						airResCancelVO.setRsvSeqno(Integer.parseInt(airResultVal.get("rsvSeqno").toString()));
						
						airService.reqAirReserveCancel(airResCancelVO, custCd);
					}
					
					freeRserveService.deleteFreeReserve(reqVO.getReqReserve());
					nextStepYN = false;
					
					System.out.println("=======================런테카 예약 실패2 end===============");
				}
				
				if(result.get("message").equals("error")){
					if(reqVO.getAirYN().equals("Y")) {
						ReqAirReserveCancelVO airResCancelVO = new ReqAirReserveCancelVO();
						
						airResCancelVO.setRsvSeqno(Integer.parseInt(airResultVal.get("rsvSeqno").toString()));
						
						airService.reqAirReserveCancel(airResCancelVO, custCd);
					}
					freeRserveService.deleteFreeReserve(reqVO.getReqReserve());
					nextStepYN = false;
				}
			}
	    	
		} catch (Exception e) {
			logger.error("컨트롤러도 에러난다!!!!!!!");
					
			if(reqVO.getAirYN().equals("Y")){
				ReqAirReserveCancelVO airResCancelVO = new ReqAirReserveCancelVO();
				
				airResCancelVO.setRsvSeqno(Integer.parseInt(airResultVal.get("rsvSeqno").toString()));
				
				try {
					airService.reqAirReserveCancel(airResCancelVO, custCd);
					freeRserveService.deleteFreeReserve(reqVO.getReqReserve());
					nextStepYN = false;
					
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					System.out.println(e1.getMessage());
				}				
			}
			
			result.put("code", 0);
			result.put("message", "error");
					
			try {
				System.out.println("================== 통신 에러  start======================");
				String errMsg = "예약 중 통신장애 발생되어 예약 실패되었습니다.";
				reqVO.getReqReserve().setErr_msg(errMsg);
				freeRserveService.updateFreeReserve(reqVO.getReqReserve());
								
				freeRserveService.deleteFreeReserve(reqVO.getReqReserve());
				nextStepYN = false;
				
				System.out.println("================== 통신 에러  end======================");
			} catch (Exception e1) {
				System.out.println(e1.getMessage());
			}
			//e.printStackTrace();
		}
		
		if(nextStepYN){
			result.put("code", 1);
			result.put("message", "success");
			System.out.println("예약완료 성공=" + nextStepYN);		
			
			try {
				reqVO.getPromReserve().setFitRsvNo(fitRsvNo);
				reqVO.getPromReserve().setRegtorId(custCd);
				reqVO.getPromReserve().setModtorId(custCd);
				stateVO.setFitRsvNo(fitRsvNo);
				stateVO.setUseYn("Y");
				stateVO.setMkt_agree_yn(reqVO.getReqReserve().getMkt_agree_yn());
				
				if(reqVO.getPromReserve().getPromId() != null){
					freeRserveService.insertFitPromReserve(reqVO.getPromReserve());
				}
				
				freeRserveService.updateFitReserveState(stateVO);
				
				RestTemplate template = new RestTemplate();
				JSONObject oJSONRequest = new JSONObject();
				
				//운영
				System.out.println("예약완료 ###################################");
				System.out.println("예약완료 ----------------------start------");
				JSONObject oJSONResponse = template.postForObject("https://fit.lottejtb.com/tos/sendRsvDataAjax.do" , oJSONRequest,  JSONObject.class);
				System.out.println("예약완료 ----------------------end-------"); 
				System.out.println("예약완료 ###################################");
				//개발
				//JSONObject oJSONResponse = template.postForObject("http://fitdev.lottejtb.com/tos/sendRsvDataAjax.do" , oJSONRequest,  JSONObject.class);
				
			} catch (Exception e) {
				//e.printStackTrace();
				System.err.println("Reserve Error!");
				System.out.println("예약실패 ----------------------");
			}
			
	    	if(!fitRsvNo.equals("")) {
	    		FitReserveVO fitReserveVO =  null;
		    	/**
		    	 * 예약 완료시 SMS 발송 기능 필요함. 
		    	 * ----------------------------------------------------------------------------------
		    	 * SMS 발송 연동 
		    	 * ----------------------------------------------------------------------------------
		    	 */
		    	try {
		    		FitReserveVO fitRsvParam = new FitReserveVO();
		    		fitRsvParam.setFitRsvNo(fitRsvNo);
		    		fitReserveVO = freeRserveService.selectFreeReserve(fitRsvParam);
		    		
		    		Map<String, Object> serialParam = new HashMap<String, Object>();
		    		int serialno = (Integer)  reserveService.srchSmsSeq(serialParam);
		    		
		    		System.out.println(" >>>>>>>>>>>>>>>>> SMS umskey >>> " + serialno);
		    		
			    	SmsVO smsSendParam = new SmsVO();
			    	String cellNo = "02-6313-8000";
	
			    	cellNo = "1899-3325"; //닷컴유입
	
			    	String smsCnt = "[롯데제이티비] 자유여행 예약이 완료되었습니다.";
			    	smsCnt = smsCnt + "(예약번호:" + fitRsvNo + ")마이투어에서 확인.";
			    	smsSendParam.setSerialno(serialno); 
			    	smsSendParam.setDestcallno(fitReserveVO.getMstRsvNmHtel());
			    	smsSendParam.setCallbackno(cellNo);
			    	smsSendParam.setSmsdata(smsCnt);
			    	smsSendParam.setSubject("0602");
			    	smsSendParam.setReserved("online");
		    		
		    		
	    			reserveService.saveSmsSend(smsSendParam);
	    			
	    			System.out.println(">>>>>>>>>>>>>>>>> SMS SEND COMPLETE !!!!!! ");
	    		
	
		    		
	    			// ------------------------------------------------------------------------------
	    			// SMS UMS 로그 남기기 
					// -- SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
					// -- 2268019	SMS	3796419	0101	P161219-0001	0000000081	[롯데JTB]예약이 완료되었습니다.(예약번호:P161219-0001)마이투어에서 확인.				2016/12/19 16:57:00	online
	    			// ------------------------------------------------------------------------------  			
	    			
	    			UmsLogVO umsLogParam = new UmsLogVO();
	    			umsLogParam.setUms_fg_cd("SMS");
	    			umsLogParam.setUms_det_cd("0602");
	    			umsLogParam.setUmskey(String.valueOf(serialno));
	    			umsLogParam.setCust_cd(custCd);
	    			// umsLogParam.setRes_cd(fitRsvNo);
	    			umsLogParam.setUms_desc(smsCnt);
	    			umsLogParam.setIns_id("online");
	    			
	    			reserveService.saveUmsLog(umsLogParam);
	    			
	    			System.out.println(">>>>>>>>>>>>>>>>> SMS SEND UMS LOG SAVE !!!!!! ");
	    			
	    			//마켓팅동의 업데이트
	    			
	    			
	    			
		    	} catch (Exception e) {
					//e.printStackTrace();
					System.out.println("SMS SEND FAIL !!!!!! " + e.getMessage());
				}
		    	
		    	
		    	/**
		    	 * ----------------------------------------------------------------------------------
		    	 * EMS 메일  발송 연동 
		    	 * ----------------------------------------------------------------------------------
		    	 */
		    	try {
		    		
		    		EmsMailSendVO emsMailSendParam = new EmsMailSendVO();
		    		
		    		emsMailSendParam.setMail_code("701");
		    		emsMailSendParam.setMail_nm("자유여행 예약완료");
		    		emsMailSendParam.setTo_name(fitReserveVO.getMstRsvNm());
		    		emsMailSendParam.setTo_email(fitReserveVO.getMstRsvNmEmail());
		    		
		    		String mail_url_mapping = "fitRsvNo=" + fitRsvNo;
		    		emsMailSendParam.setMail_url_mapping(mail_url_mapping);
		    		emsMailSendParam.setSubject("자유여행 예약이 완료되었습니다.");
		    		emsMailSendParam.setFrom_email("webmaster@lottejtb.com");
		    		emsMailSendParam.setFrom_name("롯데제이티비");
		    		emsMailSendParam.setContents_mapping(mail_url_mapping);
		    		emsMailSendParam.setReg_dt(fitReserveVO.getRsvDt());
		    		reserveService.saveEmsMailSend(emsMailSendParam);
		    		
		    		System.out.println(">>>>>>>>>>>>>>>>> EMS MAIL SEND COMPLETE !!!!!! ");
		    		
		    		Map<String, Object> serialParam = new HashMap<String, Object>();
		    		int serialno = (Integer)  reserveService.srchEmsMailSendSeq(serialParam);
		    		
		    		System.out.println(" >>>>>>>>>>>>>>>>> SMS umskey >>> " + serialno);
		    		
	    			// ------------------------------------------------------------------------------
	    			// SMS UMS 로그 남기기 
		    		// SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
		    		// 2267160	EMS	954666	0101	P161020-0294	0000169965	예약완료되었습니다.				2016/10/20 19:57:59	online
		    		// ------------------------------------------------------------------------------  			
	    			UmsLogVO umsLogParam = new UmsLogVO();
	    			umsLogParam.setUms_fg_cd("EMS");
	    			umsLogParam.setUms_det_cd("0601");
	    			umsLogParam.setUmskey(String.valueOf(serialno));
	    			umsLogParam.setCust_cd(custCd);
	    			// umsLogParam.setRes_cd(param.getRes_cd());
	    			umsLogParam.setUms_desc("예약이 완료되었습니다.");
	    			umsLogParam.setIns_id("online");
	    			
	    			reserveService.saveUmsLog(umsLogParam);
	    			
	    			System.out.println(">>>>>>>>>>>>>>>>> EMS MAIL SEND UMS LOG SAVE !!!!!! ");
		    		
		    	} catch (Exception e) {
					//e.printStackTrace();
					System.out.println("EMS MAIL SEND FAIL !!!!!! " + e.getMessage());
		    	}
		    	
		    	System.out.println(">>>>>>>>>>>>>>>>> UMS/SMS SEND COMPLETE !!!!!! ");
			}
		}else{
			result.put("code", 0);
			result.put("message", "error");
		}
		
		
/*		if(result.get("code").equals(0)){
			if(reqVO.getHotelYN().equals("Y")){
				//
				try {
					
					stateVO.setFitRsvNo(fitRsvNo);
					stateVO.setHtlRsvStateGb("ER");
					stateVO.setHtlPaymtstateGb("XR");
					stateVO.setUseYn("Y");
					
					freeRserveService.updateFitReserveState(stateVO);
					
					System.out.println("========호텔 에러 로직 처리 start=============");
					
					RestTemplate oRestTemplate = new RestTemplate();
					JSONObject reqParam = new JSONObject();
					
					reqParam.put("fitRsvNo", fitRsvNo);
					reqParam.put("cancelReason", "1");
					reqParam.put("msg", "예약실패");
					
					JSONObject oJSONResponse = htlPaymtService.cancelPayment(reqParam);

				    					
					//호텔 예약 취소 로직 태운다
					reqVO.getReqReserve().setHtlRsvStateGb("XX");
					freeRserveService.updateFreeReserve(reqVO.getReqReserve());
					
					
					//예약 취소 api 연동--start
					FreeCancelReserveVO vo = new FreeCancelReserveVO();
					vo.setFitRsvNo(fitRsvNo);
					fitReserveHtlCancel(vo,request,model);
					//예약 취소 api 연동--end
					
					//홈페이지 결제 취소 로직 요청한다.
					//JSONObject oJSONResponse1 = oRestTemplate.postForObject("http://fitdev.lottejtb.com/fit/rsv/paymentCancelAjax.do" , oJSONRequest, JSONObject.class);
					JSONObject oJSONResponse1 = oRestTemplate.postForObject("https://fit.lottejtb.com/fit/rsv/paymentCancelAjax.do" , reqParam, JSONObject.class);
					
					System.out.println("========호텔 에러 로직 처리 end=============");
				} catch (Exception e) {
					//e.printStackTrace();
					System.err.println("Reserve Error!");
				}
			}
		}*/
		
				
		model.addAttribute("result", result);
		model.addAttribute("airResult", airResultVal);
		model.addAttribute("hotelResult",hotelResultVal);
		model.addAttribute("rentResult", rentResultVal);
		model.addAttribute("fitRsvNo", fitRsvNo);
		model.addAttribute("limitDate", limitDate);
		
		return "jsonView";
					
	}
	
	/**
	 *	자유여행 예약 처리 
	 * @return
	 */
	@RequestMapping(value = "/procRsvAirCancelAjax.do", method =  {RequestMethod.GET, RequestMethod.POST})
	public String procRsvAirCancelAjax(@RequestBody ReqAirReserveCancelVO reqVO, HttpServletRequest request, Model model) throws NumberFormatException {
		System.out.println("procRsvAirCancelAjax !!!!! ");
		
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
			if(!sessionParam.get("birthday").equals(null) && sessionParam.get("birthday") != null)
				birthday = sessionParam.get("birthday").toString();
		}
		
		JSONObject result = new JSONObject();

		try {

				result = airService.reqAirReserveCancel(reqVO, custCd);
		} catch (Exception e) {
			logger.error("컨트롤러도 에러난다!!!!!!!");
			result.put("code", 0);
			result.put("message", "error");
			//e.printStackTrace();
		}
		

		model.addAttribute("result", result);
	
		return "jsonView";
					
	}
	
	/**
	 * 1. 기능 : 비자발급 및 미주노선 관련 정보 조회 
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
	@RequestMapping(value = "/selAirPAjax.do", method =  {RequestMethod.GET, RequestMethod.POST})
	public String selAirPAjax(@RequestBody SearchArrCdVO sVo, HttpServletRequest request, Model model)  throws NumberFormatException {
		System.out.println("selAirPAjax !!!!! ");
		
		ComNtCdVO airport = new ComNtCdVO();

		try {
			airport = airService.selectNtCd(sVo.getsVal());
		} catch (Exception e) {
			//e.printStackTrace();
			//System.out.println(e.getMessage());
			System.err.println("Select Nation Code Error!");
		}
		
		JSONObject resultVal = new JSONObject();		
		resultVal.put("visaYn", airport.getVisaUseYn());
		resultVal.put("apisYn", airport.getApisYn());
		
		model.addAttribute("result", resultVal);
		
		return "jsonView";
	}
	
	
	/**
	 *	자유여행 항공 마일리지 등록 
	 * @return
	 */
	@RequestMapping(value = "/srchAirMileageListAjax.do", method =  {RequestMethod.GET, RequestMethod.POST})
	public String srchAirMileageListAjax(HttpServletRequest request, Model model) throws NumberFormatException {
		System.out.println("srchAirMileageListAjax !!!!! ");
		
		AirCarrierCdVO param = new AirCarrierCdVO();
		List<AirCarrierCdVO> airList = null;
		
		try {
			
			airList = airService.selectAirMileageList(param);
			
		} catch (Exception e) {
			logger.error("컨트롤러도 에러난다!!!!!!!");
			//e.printStackTrace();
		}

		model.addAttribute("airList", airList);
		
		return "jsonView";
					
	}
	
	/**
	 *	자유여행 항공 마일리지 등록 
	 * @return
	 */
	@RequestMapping(value = "/saveMileageAjax.do", method =  RequestMethod.POST)
	public String saveMileageAjax(@RequestBody ReqAccMileageVO reqVO, HttpServletRequest request, Model model) throws NumberFormatException {
		System.out.println("saveMileageAjax !!!!! ");

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
		
		JSONObject resultVal = new JSONObject();		
		try {
			
				resultVal = airService.saveAirMileage(reqVO, custCd);
			
		} catch (Exception e) {
			logger.error("컨트롤러도 에러난다!!!!!!!");
			//e.printStackTrace();
		}

		model.addAttribute("result", resultVal);
		
		return "jsonView";
					
	}
	
	/**
	 *	자유여행 여권 정보 등록 
	 * @return
	 */
	@RequestMapping(value = "/savePassportAjax.do", method =  RequestMethod.POST)
	public String savePassportAjax(@RequestBody ReqAccPassportVO reqVO, HttpServletRequest request, Model model) throws NumberFormatException {
		System.out.println("savePassportAjax !!!!! ");
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
		JSONObject resultVal = new JSONObject();		
		try {
			
				resultVal = airService.saveAirPassport(reqVO, custCd);
			
		} catch (Exception e) {
			logger.error("컨트롤러도 에러난다!!!!!!!");
			//e.printStackTrace();
		}

		model.addAttribute("result", resultVal);
		
		return "jsonView";
					
	}
	
	// <!-- 현지연락처 정보 저장    -->
	@RequestMapping(value = "/saveContactAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String saveContactAjax(@RequestBody ReqAccContactVO reqVO,  HttpServletRequest request, ModelMap model)throws Exception{

		System.out.println("saveContactAjax !!!!! ");
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
		JSONObject resultVal = new JSONObject();		
		try {
			
				resultVal = airService.saveAirContact(reqVO, custCd);
			
		} catch (Exception e) {
			logger.error("컨트롤러도 에러난다!!!!!!!");
			//e.printStackTrace();
		}

		model.addAttribute("result", resultVal);
		
		return "jsonView";		
	}
	
	// <!-- 비자 정보 저장    -->
	@RequestMapping(value = "/saveAddressAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String saveAddressAjax(@RequestBody ReqAccAddressVO reqVO, HttpServletRequest request, ModelMap model)throws Exception{

		System.out.println("saveAddressAjax !!!!! ");
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
		JSONObject resultVal = new JSONObject();		
		try {
			
				resultVal = airService.saveAirAddress(reqVO, custCd);
			
		} catch (Exception e) {
			logger.error("컨트롤러도 에러난다!!!!!!!");
			//e.printStackTrace();
		}

		model.addAttribute("result", resultVal);
		
		return "jsonView";		
	}	
	
	// <!-- 비자 정보 저장    -->
	@RequestMapping(value = "/account/saveVisaAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String saveVisaAjax(@RequestParam("seqNo") String seqNo, HttpServletRequest request, ModelMap model)throws Exception{

		
		return "jsonView";		
	}	
	
	// <!-- 메일 문의 저장하기   -->
	@RequestMapping(value = "/saveConsultMailAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String saveConsultMailAjax(HttpServletRequest request, ModelMap model)throws Exception{
		
		// DEFAULT VALUE 

		String from_name = (String) request.getParameter("from_name");
		String from_email = (String) request.getParameter("from_email");
		String receiver_cnt = (String) request.getParameter("receiver_cnt");
		String subject = (String) request.getParameter("subject");
		String contents_mapping = (String) request.getParameter("contents_mapping");
		String rsvSeqno = (String) request.getParameter("rsvSeqno");
		
		if(receiver_cnt == null || receiver_cnt.equals("")) receiver_cnt = "0";
		int nReceiver_cnt = Integer.parseInt(receiver_cnt);
		
		String to_name1 = "";
		String to_email1 = "";
		String to_name2 = "";
		String to_email2 = "";
		String to_name3 = "";
		String to_email3 = "";
		String to_name4 = "";
		String to_email4 = "";
		String to_name5 = "";
		String to_email5 = "";
		String to_name6 = "";
		String to_email6 = "";
		String to_name7 = "";
		String to_email7 = "";
		String to_name8 = "";
		String to_email8 = "";		
		String to_name9 = "";
		String to_email9 = "";		
		String to_name10 = "";
		String to_email10 = "";
		
		if(nReceiver_cnt > 0) {
			to_name1 = (String) request.getParameter("to_name1");
			to_email1 = (String) request.getParameter("to_email1");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("007");
			param.setMail_nm(subject);
			String mail_url_mapping = "";
			
			//메일 URL 매핑 셋팅
			if("007".equals(param.getMail_code())){
				// ctg=5836&eventCd=ASP22871611232&Flag=BO&siteNm=0&siteTel=0&siteUser=0&mall_cd=1
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=BO&siteNm=0&siteTel=0&siteUser=0";
				
			} else if("030".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=B0&siteNm=0&siteTel=0&siteUser=0";
				
			}
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email1);
			param.setTo_name(to_name1);
			param.setContents_mapping(contents_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 1) {
			to_name2 = (String) request.getParameter("to_name2");
			to_email2 = (String) request.getParameter("to_email2");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("007");
			param.setMail_nm(subject);
			String mail_url_mapping = "";
			
			//메일 URL 매핑 셋팅
			if("007".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=BO&siteNm=0&siteTel=0&siteUser=0";
				
			} else if("030".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=B0&siteNm=0&siteTel=0&siteUser=0";
				
			}
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email2);
			param.setTo_name(to_name2);
			param.setContents_mapping(contents_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 2) {
			to_name3 = (String) request.getParameter("to_name3");
			to_email3 = (String) request.getParameter("to_email3");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("007");
			param.setMail_nm(subject);
			String mail_url_mapping = "";
			
			//메일 URL 매핑 셋팅
			if("007".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=BO&siteNm=0&siteTel=0&siteUser=0";
				
			} else if("030".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=B0&siteNm=0&siteTel=0&siteUser=0";
				
			}
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email3);
			param.setTo_name(to_name3);
			param.setContents_mapping(contents_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 3) {
			to_name4 = (String) request.getParameter("to_name4");
			to_email4 = (String) request.getParameter("to_email4");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("007");
			param.setMail_nm(subject);
			String mail_url_mapping = "";
			
			//메일 URL 매핑 셋팅
			if("007".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=BO&siteNm=0&siteTel=0&siteUser=0";
				
			} else if("030".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=B0&siteNm=0&siteTel=0&siteUser=0";
				
			}
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email4);
			param.setTo_name(to_name4);
			param.setContents_mapping(contents_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 4) {
			to_name5 = (String) request.getParameter("to_name5");
			to_email5 = (String) request.getParameter("to_email5");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("007");
			param.setMail_nm(subject);
			String mail_url_mapping = "";
			
			//메일 URL 매핑 셋팅
			if("007".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=BO&siteNm=0&siteTel=0&siteUser=0";
				
			} else if("030".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=B0&siteNm=0&siteTel=0&siteUser=0";
				
			}
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email5);
			param.setTo_name(to_name5);
			param.setContents_mapping(contents_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 5) {
			to_name6 = (String) request.getParameter("to_name6");
			to_email6 = (String) request.getParameter("to_email6");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("007");
			param.setMail_nm(subject);
			String mail_url_mapping = "";
			
			//메일 URL 매핑 셋팅
			if("007".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=BO&siteNm=0&siteTel=0&siteUser=0";
				
			} else if("030".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=B0&siteNm=0&siteTel=0&siteUser=0";
				
			}
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email6);
			param.setTo_name(to_name6);
			param.setContents_mapping(contents_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 6) {
			to_name7 = (String) request.getParameter("to_name7");
			to_email7 = (String) request.getParameter("to_email7");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("007");
			param.setMail_nm(subject);
			String mail_url_mapping = "";
			
			//메일 URL 매핑 셋팅
			if("007".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=BO&siteNm=0&siteTel=0&siteUser=0";
				
			} else if("030".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=B0&siteNm=0&siteTel=0&siteUser=0";
				
			}
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email7);
			param.setTo_name(to_name7);
			param.setContents_mapping(contents_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 7) {
			to_name8 = (String) request.getParameter("to_name8");
			to_email8 = (String) request.getParameter("to_email8");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("007");
			param.setMail_nm(subject);
			String mail_url_mapping = "";
			
			//메일 URL 매핑 셋팅
			if("007".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=BO&siteNm=0&siteTel=0&siteUser=0";
				
			} else if("030".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=B0&siteNm=0&siteTel=0&siteUser=0";
				
			}
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email8);
			param.setTo_name(to_name8);
			param.setContents_mapping(contents_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 8) {
			to_name9 = (String) request.getParameter("to_name9");
			to_email9 = (String) request.getParameter("to_email9");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("007");
			param.setMail_nm(subject);
			String mail_url_mapping = "";
			
			//메일 URL 매핑 셋팅
			if("007".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=BO&siteNm=0&siteTel=0&siteUser=0";
				
			} else if("030".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=B0&siteNm=0&siteTel=0&siteUser=0";
				
			}
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email9);
			param.setTo_name(to_name9);
			param.setContents_mapping(contents_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 9) {
			to_name10 = (String) request.getParameter("to_name10");
			to_email10 = (String) request.getParameter("to_email10");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("007");
			param.setMail_nm(subject);
			String mail_url_mapping = "";
			
			//메일 URL 매핑 셋팅
			if("007".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=BO&siteNm=0&siteTel=0&siteUser=0";
				
			} else if("030".equals(param.getMail_code())){
				mail_url_mapping = "rsvSeqno="+rsvSeqno+"&Flag=B0&siteNm=0&siteTel=0&siteUser=0";
				
			}
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email10);
			param.setTo_name(to_name10);
			param.setContents_mapping(contents_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}
		return "jsonView";
	}
	
	/**
	 *	자유여행 예약 취소 처리 
	 * @return
	 */
	@RequestMapping(value = "/fitReserveCancel.do", method =  {RequestMethod.GET, RequestMethod.POST})
	public String fitReserveCancel(@ModelAttribute FreeCancelReserveVO vo, HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		ArrayList<FreeCancelReserveVO> reserveResult = fitReserveService.selectCancelList(vo);
		int airCnt = 0;
		int htlCnt = 0;
		int rntCnt = 0;
		
		String custCd = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
		}
		
		ArrayList<ReqAirReserveCancelVO> airResCancelVOList = new ArrayList<ReqAirReserveCancelVO>();
		ArrayList<ReqHotelReserveCancelVO> htlResCancelObjList = new ArrayList<ReqHotelReserveCancelVO>();
		ArrayList<FreeCancelReserveVO> rntResCancelVOList = new ArrayList<FreeCancelReserveVO>();
		boolean successYN = true;
		
		
		for(FreeCancelReserveVO tempVO : reserveResult){
			if(tempVO.getRsvType().equals("AIR")){
				ReqAirReserveCancelVO airResCancelVO = new ReqAirReserveCancelVO();
				
				airResCancelVO.setRsvSeqno(Integer.parseInt(tempVO.getAirRsvSeqno()));
				
				airResCancelVOList.add(airResCancelVO);
			}else if(tempVO.getRsvType().equals("HTL")){
				ReqHotelReserveCancelVO htlResCancelObj = new ReqHotelReserveCancelVO();
				
				htlResCancelObj.setFitMix(tempVO.getConcMix());
				htlResCancelObj.setSuplrCd(tempVO.getSuplrGb());
				htlResCancelObj.setItineraryId(tempVO.getSuplrRsvNo());
				htlResCancelObj.setEmail(tempVO.getMstRsvNmEmail());
				htlResCancelObj.setReason(tempVO.getReason());
				htlResCancelObj.setHtlRsvSeqno(tempVO.getHtlRsvSeqno());
				htlResCancelObj.setFitRsvNo(tempVO.getFitRsvNo());
				htlResCancelObj.setConfirmNum(tempVO.getConfirmNum());
				
				htlResCancelObjList.add(htlResCancelObj);
				
			}else if(tempVO.getRsvType().equals("RNT")){
				FreeCancelReserveVO rntResCancelVO = new FreeCancelReserveVO();
				String[] operNmArr = tempVO.getOperNm().split(" ");
				
				rntResCancelVO.setSuplrRsvNo(tempVO.getSuplrRsvNo());
				rntResCancelVO.setOperSurName(operNmArr[0]);
				rntResCancelVO.setMstRsvNmId(tempVO.getMstRsvNmId());
				
				rntResCancelVOList.add(rntResCancelVO);
			}
		}		
		
		JSONObject airResult = null;
		for(airCnt = 0; airCnt < airResCancelVOList.size(); airCnt++){
			airResult = airService.reqAirReserveCancel(airResCancelVOList.get(airCnt), custCd);
		}
		
		if(airCnt > 0){
			if(airResult.get("code").equals("1")){
				HashMap<String, Object> airParam = new HashMap<String, Object>();
				airParam.put("target", "CANCEL_YN_AIR");
				airParam.put("fitRsvNo", vo.getFitRsvNo());
				
				fitReserveService.updateCancelFitReserve(airParam);
				result.put("resultCode", "1");
				result.put("resultMsg", "success");
			}else{
				result.put("resultCode", "0");
				result.put("resultMsg", "error");
				
				successYN = false;
			}
		}
		
		if(successYN){
			JSONObject htlResult = null;
			for(htlCnt = 0; htlCnt < htlResCancelObjList.size(); htlCnt++){
				htlResult = hotelService.reqHotelReserveCancel(htlResCancelObjList.get(htlCnt), htlResCancelObjList.get(htlCnt).getFitRsvNo(), custCd);
			}
			
			if(htlCnt > 0){
				if(htlResult.get("code").equals("1")){
					HashMap<String, Object> htlParam = new HashMap<String, Object>();
					htlParam.put("target", "CANCEL_YN_HTL");
					htlParam.put("htlPaymtstateGb", "XX");
					htlParam.put("htlRsvstateGb", "XX");		//[JEH] 호텔_예약상태_GB 추가 - 20180201
					htlParam.put("fitRsvNo", vo.getFitRsvNo());					
					
					//[JEH] 환불계좌정보
					if(!TextUtils.isEmpty(vo.getRfdBankCd())){
						htlParam.put("htlRsvstateGb", "RF");		//[JEH] 호텔_예약상태_GB 추가 - 20180201
						htlParam.put("rfdBankCd", vo.getRfdBankCd());
						htlParam.put("rfdActNo", vo.getRfdActNo());
						fitReserveService.updateActPaymt(htlParam);
					}
					
					fitReserveService.updateCancelFitReserve(htlParam);
					
					result.put("resultCode", "1");
					result.put("resultMsg", "success");
					
					RestTemplate oRestTemplate = new RestTemplate(); 
					JSONObject oJSONRequest = new JSONObject();

		            System.out.println("========= [JEH] log check!====="); 
					oJSONRequest.put("fitRsvNo", vo.getFitRsvNo());
					oJSONRequest.put("cancelReason", "1");
					oJSONRequest.put("msg", "예약취소");
			        
					System.out.println("[JEH] [htlPaymtService.cancelPayment start---------------------------]");  
					JSONObject oJSONResponse = htlPaymtService.cancelPayment(oJSONRequest);
			        System.out.println("[JEH] [htlPaymtService.cancelPayment end---------------------------]");     
					
					//JSONObject oJSONResponse1 = oRestTemplate.postForObject("http://fitdev.lottejtb.com/fit/rsv/paymentCancelAjax.do" , oJSONRequest, JSONObject.class);
					System.out.println("[Front paymentCancelAjax start---------------------------]");
//					JSONObject oJSONResponse1 = oRestTemplate.postForObject("https://fit.lottejtb.com/fit/rsv/paymentCancelAjax.do" , oJSONRequest, JSONObject.class);
					System.out.println("[Front paymentCancelAjax end---------------------------]");
				}else{
					result.put("resultCode", "0");
					result.put("resultMsg", "error");
					
					successYN = false;
				}
			}
		}
		
		if(successYN){
			HashMap<String, Object> rntResult = new HashMap<String, Object>();
			for(rntCnt = 0; rntCnt < rntResCancelVOList.size(); rntCnt++){
				rntResult = rentalcarService.reserveCancelRentalCar(rntResCancelVOList.get(rntCnt));
			}
			
			
			if(rntCnt > 0){
				if(rntResult.get("resultCode").equals("1")){
					HashMap<String, Object> rntParam = new HashMap<String, Object>();
					rntParam.put("target", "CANCEL_YN_RNT");
					rntParam.put("fitRsvNo", vo.getFitRsvNo());
					rntParam.put("rntRsvstateGb", "CA");
					
					fitReserveService.updateCancelFitReserve(rntParam);
					
					result.put("resultCode", "1");
					result.put("resultMsg", "success");
				}else{
					result.put("resultCode", "0");
					result.put("resultMsg", "error");
					
					successYN = false;
				}
			}
		}
		
		if(successYN){
			FitReserveVO fitReserveVO =  null;
	    	/**
	    	 * 예약 취소시 SMS 발송 기능 필요함. 
	    	 * ----------------------------------------------------------------------------------
	    	 * SMS 발송 연동 
	    	 * ----------------------------------------------------------------------------------
	    	 */
			
			//예약 취소 tos연동--start
			RestTemplate template = new RestTemplate();
			JSONObject oJSONRequest = new JSONObject();
			
			//개발
			//아래꺼 호출되면 InvocationTargetException
			
			//JSONObject oJSONResponse = template.postForObject("http://fitdev.lottejtb.com /tos/sendCancelDataAjax.do" , oJSONRequest, JSONObject.class);

            System.out.println("========= [JEH] 20171026 FitReserveController - fitReserveCancel - 아래 Ajax 호출은 서버에서 배치돌고있기 때문에 주석처리하였음.");
			//운영
			//JSONObject oJSONResponse = template.postForObject("https://fit.lottejtb.com /tos/sendCancelDataAjax.do" , oJSONRequest, JSONObject.class);
																 			
			//예약 취소 tos연동--end
			
	    	try {
	    		FitReserveVO fitRsvParam = new FitReserveVO();
	    		fitRsvParam.setFitRsvNo(vo.getFitRsvNo());
	    		fitReserveVO = freeRserveService.selectFreeReserve(fitRsvParam);
	    		
	    		Map<String, Object> serialParam = new HashMap<String, Object>();
	    		int serialno = (Integer)  reserveService.srchSmsSeq(serialParam);
	    		
	    		System.out.println(" >>>>>>>>>>>>>>>>> SMS umskey >>> " + serialno);
	    		
		    	SmsVO smsSendParam = new SmsVO();
		    	String cellNo = "02-6313-8000";

		    	cellNo = "1899-3325"; //닷컴유입

		    	String smsCnt = "[롯데제이티비] 자유여행 예약이 취소되었습니다.";
		    	smsCnt = smsCnt + "(예약번호:" + vo.getFitRsvNo() + ")";
		    	smsSendParam.setSerialno(serialno); 
		    	smsSendParam.setDestcallno(fitReserveVO.getMstRsvNmHtel());
		    	smsSendParam.setCallbackno(cellNo);
		    	smsSendParam.setSmsdata(smsCnt);
		    	smsSendParam.setSubject("0602");
		    	smsSendParam.setReserved("online");
	    		
	    		
    			reserveService.saveSmsSend(smsSendParam);
    			
    			System.out.println(">>>>>>>>>>>>>>>>> SMS SEND COMPLETE !!!!!! ");
    		

	    		
    			// ------------------------------------------------------------------------------
    			// SMS UMS 로그 남기기 
				// -- SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
				// -- 2268019	SMS	3796419	0101	P161219-0001	0000000081	[롯데JTB]예약이 완료되었습니다.(예약번호:P161219-0001)마이투어에서 확인.				2016/12/19 16:57:00	online
    			// ------------------------------------------------------------------------------  			
    			
    			UmsLogVO umsLogParam = new UmsLogVO();
    			umsLogParam.setUms_fg_cd("SMS");
    			umsLogParam.setUms_det_cd("0602");
    			umsLogParam.setUmskey(String.valueOf(serialno));
    			umsLogParam.setCust_cd(custCd);
    			// umsLogParam.setRes_cd(fitRsvNo);
    			umsLogParam.setUms_desc(smsCnt);
    			umsLogParam.setIns_id("online");
    			
    			reserveService.saveUmsLog(umsLogParam);
    			
    			System.out.println(">>>>>>>>>>>>>>>>> SMS SEND UMS LOG SAVE !!!!!! ");

				//[JEH] 환불계좌정보가 있으면 SMS발송
				if(!TextUtils.isEmpty(vo.getRfdBankCd())){
		    		serialno = (Integer)  reserveService.srchSmsSeq(serialParam);
		    		
		    		System.out.println(" >>>>>>>>>>>>>>>>> SMS umskey >>> " + serialno);
		    		
			    	cellNo = "1899-3325"; //닷컴유입

			    	smsCnt = "[롯데제이티비] 자유여행 환불요청이 접수되었습니다.";
			    	smsCnt = smsCnt + "(예약번호:" + vo.getFitRsvNo() + ")";
			    	smsSendParam.setSerialno(serialno); 
			    	smsSendParam.setDestcallno("01050202003");
			    	smsSendParam.setCallbackno(cellNo);
			    	smsSendParam.setSmsdata(smsCnt);
			    	smsSendParam.setSubject("0602");
			    	smsSendParam.setReserved("online");		    		
		    		
	    			reserveService.saveSmsSend(smsSendParam);
	    			
	    			System.out.println(">>>>>>>>>>>>>>>>> SMS SEND COMPLETE !!!!!! ");

	    			// ------------------------------------------------------------------------------
	    			// SMS UMS 로그 남기기 
	    			// ------------------------------------------------------------------------------  			
	    			
	    			umsLogParam.setUms_fg_cd("SMS");
	    			umsLogParam.setUms_det_cd("0602");
	    			umsLogParam.setUmskey(String.valueOf(serialno));
	    			umsLogParam.setCust_cd(custCd);
	    			// umsLogParam.setRes_cd(fitRsvNo);
	    			umsLogParam.setUms_desc(smsCnt);
	    			umsLogParam.setIns_id("online");
	    			
	    			reserveService.saveUmsLog(umsLogParam);
	    			
	    			System.out.println(">>>>>>>>>>>>>>>>> SMS SEND UMS LOG SAVE !!!!!! ");

				}
    			
	    	} catch (Exception e) {
				//e.printStackTrace();
				System.out.println("SMS SEND FAIL !!!!!! " + e.getMessage());
			}
	    	
	    	
	    	/**
	    	 * ----------------------------------------------------------------------------------
	    	 * EMS 메일  발송 연동 
	    	 * ----------------------------------------------------------------------------------
	    	 */
	    	try {
	    		
	    		EmsMailSendVO emsMailSendParam = new EmsMailSendVO();
	    		
	    		emsMailSendParam.setMail_code("701");
	    		emsMailSendParam.setMail_nm("자유여행 예약취소");
	    		emsMailSendParam.setTo_name(fitReserveVO.getMstRsvNm());
	    		emsMailSendParam.setTo_email(fitReserveVO.getMstRsvNmEmail());
	    		
	    		String mail_url_mapping = "fitRsvNo=" + vo.getFitRsvNo();
	    		emsMailSendParam.setMail_url_mapping(mail_url_mapping);
	    		emsMailSendParam.setSubject("자유여행 예약이 취소되었습니다.");
	    		emsMailSendParam.setFrom_email("webmaster@lottejtb.com");
	    		emsMailSendParam.setFrom_name("롯데제이티비");
	    		emsMailSendParam.setContents_mapping(mail_url_mapping);
	    		emsMailSendParam.setReg_dt(fitReserveVO.getRsvDt());
	    		reserveService.saveEmsMailSend(emsMailSendParam);
	    		
	    		Map<String, Object> serialParam = new HashMap<String, Object>();
	    		int serialno = (Integer)  reserveService.srchEmsMailSendSeq(serialParam);
	    		
    			// ------------------------------------------------------------------------------
    			// SMS UMS 로그 남기기 
	    		// SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
	    		// 2267160	EMS	954666	0101	P161020-0294	0000169965	예약완료되었습니다.				2016/10/20 19:57:59	online
	    		// ------------------------------------------------------------------------------  			
    			UmsLogVO umsLogParam = new UmsLogVO();
    			umsLogParam.setUms_fg_cd("EMS");
    			umsLogParam.setUms_det_cd("0601");
    			umsLogParam.setUmskey(String.valueOf(serialno));
    			umsLogParam.setCust_cd(custCd);
    			// umsLogParam.setRes_cd(param.getRes_cd());
    			umsLogParam.setUms_desc("예약이 취소되었습니다.");
    			umsLogParam.setIns_id("online");
    			
    			reserveService.saveUmsLog(umsLogParam);
    			
    			System.out.println(">>>>>>>>>>>>>>>>> EMS MAIL SEND UMS LOG SAVE !!!!!! ");
	    		
	    	} catch (Exception e) {
				//e.printStackTrace();
				System.out.println("EMS MAIL SEND FAIL !!!!!! " + e.getMessage());
	    	}
		}
		
		System.out.println("=============result======================" + result.toString());
		model.addAttribute("result", result);
	
		return "jsonView";
	}

	/**
	 * 예약번호 저장 
	 * @return
	 */
	@RequestMapping(value = "/insertFreeRsvNo.do", method =  {RequestMethod.GET, RequestMethod.POST})
	public String insertFreeRsvNo(@RequestBody ReqReserveVO reqVO, HttpServletRequest request, Model model) throws NumberFormatException {
		String fitRsvNo = "";
		
		try {
			fitRsvNo = freeRserveService.insertFreeReserve(reqVO);
			reqVO.setFitRsvNo(fitRsvNo);
		}catch(Exception e){
			//e.printStackTrace();
			System.err.println("Reserve Insert Error!");
		}
		
		model.addAttribute("fitRsvNo", fitRsvNo);
		
		return "jsonView";
	}
	
	/**
	 *	자유여행 항공 예약취소
	 * @return
	 */
	@RequestMapping(value = "/fitReserveAirCancel.do", method =  {RequestMethod.GET, RequestMethod.POST})
	public String fitReserveAirCancel(@ModelAttribute FreeCancelReserveVO vo, HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		ArrayList<FreeCancelReserveVO> reserveResult = fitReserveService.selectAirCancelList(vo);
		int airCnt = 0;
		
		String custCd = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
		}
		
		ArrayList<ReqAirReserveCancelVO> airResCancelVOList = new ArrayList<ReqAirReserveCancelVO>();
		
		for(FreeCancelReserveVO tempVO : reserveResult){
			if(tempVO.getRsvType().equals("AIR")){
				ReqAirReserveCancelVO airResCancelVO = new ReqAirReserveCancelVO();
				
				airResCancelVO.setRsvSeqno(Integer.parseInt(tempVO.getAirRsvSeqno()));
				
				airResCancelVOList.add(airResCancelVO);
			}
		}
		
		JSONObject airResult = null;
		for(airCnt = 0; airCnt < airResCancelVOList.size(); airCnt++){
			airResult = airService.reqAirReserveCancel(airResCancelVOList.get(airCnt), custCd);
		}
		
		if(airCnt > 0){
			if(airResult.get("code").equals("1")){
				HashMap<String, Object> airParam = new HashMap<String, Object>();
				airParam.put("target", "CANCEL_YN_AIR");
				airParam.put("fitRsvNo", vo.getFitRsvNo());
				
				fitReserveService.updateCancelFitReserve(airParam);
				result.put("resultCode", "1");
				result.put("resultMsg", "success");
				
				FitReserveVO fitReserveVO =  null;
				
		    	/**
		    	 * 예약 취소시 SMS 발송 기능 필요함. 
		    	 * ----------------------------------------------------------------------------------
		    	 * SMS 발송 연동 
		    	 * ----------------------------------------------------------------------------------
		    	 */
		    	try {
		    		FitReserveVO fitRsvParam = new FitReserveVO();
		    		fitRsvParam.setFitRsvNo(vo.getFitRsvNo());
		    		fitReserveVO = freeRserveService.selectFreeReserve(fitRsvParam);
		    		
		    		Map<String, Object> serialParam = new HashMap<String, Object>();
		    		int serialno = (Integer)  reserveService.srchSmsSeq(serialParam);
		    				    		
			    	SmsVO smsSendParam = new SmsVO();
			    	String cellNo = "02-6313-8000";

			    	cellNo = "1899-3325"; //닷컴유입

			    	String smsCnt = "[롯데제이티비] 자유여행 항공예약이 취소되었습니다.";
			    	smsCnt = smsCnt + "(예약번호:" + vo.getFitRsvNo() + ")";
			    	smsSendParam.setSerialno(serialno); 
			    	smsSendParam.setDestcallno(fitReserveVO.getMstRsvNmHtel());
			    	smsSendParam.setCallbackno(cellNo);
			    	smsSendParam.setSmsdata(smsCnt);
			    	smsSendParam.setSubject("0602");
			    	smsSendParam.setReserved("online");
		    		
		    		
	    			reserveService.saveSmsSend(smsSendParam);
		    		
	    			// ------------------------------------------------------------------------------
	    			// SMS UMS 로그 남기기 
					// -- SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
					// -- 2268019	SMS	3796419	0101	P161219-0001	0000000081	[롯데JTB]예약이 완료되었습니다.(예약번호:P161219-0001)마이투어에서 확인.				2016/12/19 16:57:00	online
	    			// ------------------------------------------------------------------------------  			
	    			
	    			UmsLogVO umsLogParam = new UmsLogVO();
	    			umsLogParam.setUms_fg_cd("SMS");
	    			umsLogParam.setUms_det_cd("0602");
	    			umsLogParam.setUmskey(String.valueOf(serialno));
	    			umsLogParam.setCust_cd(custCd);
	    			// umsLogParam.setRes_cd(fitRsvNo);
	    			umsLogParam.setUms_desc(smsCnt);
	    			umsLogParam.setIns_id("online");
	    			
	    			reserveService.saveUmsLog(umsLogParam);
		    	} catch (Exception e) {
					//e.printStackTrace();
					System.out.println("SMS SEND FAIL !!!!!! " + e.getMessage());
				}
		    	
		    	
		    	/**
		    	 * ----------------------------------------------------------------------------------
		    	 * EMS 메일  발송 연동 
		    	 * ----------------------------------------------------------------------------------
		    	 */
		    	try {
		    		
		    		EmsMailSendVO emsMailSendParam = new EmsMailSendVO();
		    		
		    		emsMailSendParam.setMail_code("701");
		    		emsMailSendParam.setMail_nm("자유여행 항공 예약취소");
		    		emsMailSendParam.setTo_name(fitReserveVO.getMstRsvNm());
		    		emsMailSendParam.setTo_email(fitReserveVO.getMstRsvNmEmail());
		    		
		    		String mail_url_mapping = "fitRsvNo=" + vo.getFitRsvNo();
		    		emsMailSendParam.setMail_url_mapping(mail_url_mapping);
		    		emsMailSendParam.setSubject("자유여행 항공 예약이 취소되었습니다.");
		    		emsMailSendParam.setFrom_email("webmaster@lottejtb.com");
		    		emsMailSendParam.setFrom_name("롯데제이티비");
		    		emsMailSendParam.setContents_mapping(mail_url_mapping);
		    		emsMailSendParam.setReg_dt(fitReserveVO.getRsvDt());
		    		reserveService.saveEmsMailSend(emsMailSendParam);
		    		
		    		Map<String, Object> serialParam = new HashMap<String, Object>();
		    		int serialno = (Integer)  reserveService.srchEmsMailSendSeq(serialParam);
		    		
	    			// ------------------------------------------------------------------------------
	    			// SMS UMS 로그 남기기 
		    		// SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
		    		// 2267160	EMS	954666	0101	P161020-0294	0000169965	예약완료되었습니다.				2016/10/20 19:57:59	online
		    		// ------------------------------------------------------------------------------  			
	    			UmsLogVO umsLogParam = new UmsLogVO();
	    			umsLogParam.setUms_fg_cd("EMS");
	    			umsLogParam.setUms_det_cd("0601");
	    			umsLogParam.setUmskey(String.valueOf(serialno));
	    			umsLogParam.setCust_cd(custCd);
	    			// umsLogParam.setRes_cd(param.getRes_cd());
	    			umsLogParam.setUms_desc("항공예약이 취소되었습니다.");
	    			umsLogParam.setIns_id("online");
	    			
	    			reserveService.saveUmsLog(umsLogParam);
		    	} catch (Exception e) {
					//e.printStackTrace();
					System.out.println("EMS MAIL SEND FAIL !!!!!! " + e.getMessage());
		    	}
			}else{
				result.put("resultCode", "0");
				result.put("resultMsg", "error");
			}
		}
		
		model.addAttribute("result", result);
	
		return "jsonView";
	}
	
	/**
	 *	자유여행 호텔 예약취소 
	 * @return
	 */
	@RequestMapping(value = "/fitReserveHtlCancel.do", method =  {RequestMethod.GET, RequestMethod.POST})
	public String fitReserveHtlCancel(@ModelAttribute FreeCancelReserveVO vo, HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		ArrayList<FreeCancelReserveVO> reserveResult = fitReserveService.selectHtlCancelList(vo);
		int airCnt = 0;
		int htlCnt = 0;
		int rntCnt = 0;
		
		String custCd = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
		}
		
		ArrayList<ReqHotelReserveCancelVO> htlResCancelObjList = new ArrayList<ReqHotelReserveCancelVO>();
		boolean successYN = true;
		
		for(FreeCancelReserveVO tempVO : reserveResult){
			ReqHotelReserveCancelVO htlResCancelObj = new ReqHotelReserveCancelVO();
			
			htlResCancelObj.setFitMix(tempVO.getConcMix());
			htlResCancelObj.setSuplrCd(tempVO.getSuplrGb());
			htlResCancelObj.setItineraryId(tempVO.getSuplrRsvNo());
			htlResCancelObj.setEmail(tempVO.getMstRsvNmEmail());
			htlResCancelObj.setReason(tempVO.getReason());
			htlResCancelObj.setHtlRsvSeqno(tempVO.getHtlRsvSeqno());
			htlResCancelObj.setFitRsvNo(tempVO.getFitRsvNo());
			htlResCancelObj.setConfirmNum(tempVO.getConfirmNum());
			
			htlResCancelObjList.add(htlResCancelObj);
		}

		JSONObject htlResult = null;
		for(htlCnt = 0; htlCnt < htlResCancelObjList.size(); htlCnt++){
			htlResult = hotelService.reqHotelReserveCancel(htlResCancelObjList.get(htlCnt), htlResCancelObjList.get(htlCnt).getFitRsvNo(), custCd);
		}
		
		if(htlCnt > 0){
			if(htlResult.get("code").equals("1")){
				HashMap<String, Object> htlParam = new HashMap<String, Object>();
				htlParam.put("target", "CANCEL_YN_HTL");
				htlParam.put("htlPaymtstateGb", "XX");
				htlParam.put("fitRsvNo", vo.getFitRsvNo());
				
				fitReserveService.updateCancelFitReserve(htlParam);
				result.put("resultCode", "1");
				result.put("resultMsg", "success");

				//[JEH] 환불계좌정보
				if(!TextUtils.isEmpty(vo.getRfdBankCd())){
					htlParam.put("rfdBankCd", vo.getRfdBankCd());
					htlParam.put("rfdActNo", vo.getRfdActNo());
					fitReserveService.updateActPaymt(htlParam);
				}
				
				RestTemplate oRestTemplate = new RestTemplate();
				JSONObject reqParam = new JSONObject();
				
				reqParam.put("fitRsvNo", vo.getFitRsvNo());
				reqParam.put("cancelReason", "1");
				reqParam.put("msg", "예약취소");
				
				JSONObject oJSONResponse = htlPaymtService.cancelPayment(reqParam);
				
				//JSONObject oJSONResponse1 = oRestTemplate.postForObject("http://fitdev.lottejtb.com/fit/rsv/paymentCancelAjax.do" , oJSONRequest, JSONObject.class);
				JSONObject oJSONResponse1 = oRestTemplate.postForObject("https://fit.lottejtb.com/fit/rsv/paymentCancelAjax.do" , reqParam, JSONObject.class);
				
				FitReserveVO fitReserveVO =  null;
				
				/**
		    	 * 예약 취소시 SMS 발송 기능 필요함. 
		    	 * ----------------------------------------------------------------------------------
		    	 * SMS 발송 연동 
		    	 * ----------------------------------------------------------------------------------
		    	 */
		    	try {
		    		FitReserveVO fitRsvParam = new FitReserveVO();
		    		fitRsvParam.setFitRsvNo(vo.getFitRsvNo());
		    		fitReserveVO = freeRserveService.selectFreeReserve(fitRsvParam);
		    		
		    		Map<String, Object> serialParam = new HashMap<String, Object>();
		    		int serialno = (Integer)  reserveService.srchSmsSeq(serialParam);
		    				    		
			    	SmsVO smsSendParam = new SmsVO();
			    	String cellNo = "02-6313-8000";

			    	cellNo = "1899-3325"; //닷컴유입

			    	String smsCnt = "[롯데제이티비] 자유여행 호텔예약이 취소되었습니다.";
			    	smsCnt = smsCnt + "(예약번호:" + vo.getFitRsvNo() + ")";
			    	smsSendParam.setSerialno(serialno); 
			    	smsSendParam.setDestcallno(fitReserveVO.getMstRsvNmHtel());
			    	smsSendParam.setCallbackno(cellNo);
			    	smsSendParam.setSmsdata(smsCnt);
			    	smsSendParam.setSubject("0602");
			    	smsSendParam.setReserved("online");
		    		
		    		
	    			reserveService.saveSmsSend(smsSendParam);
		    		
	    			// ------------------------------------------------------------------------------
	    			// SMS UMS 로그 남기기 
					// -- SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
					// -- 2268019	SMS	3796419	0101	P161219-0001	0000000081	[롯데JTB]예약이 완료되었습니다.(예약번호:P161219-0001)마이투어에서 확인.				2016/12/19 16:57:00	online
	    			// ------------------------------------------------------------------------------  			
	    			
	    			UmsLogVO umsLogParam = new UmsLogVO();
	    			umsLogParam.setUms_fg_cd("SMS");
	    			umsLogParam.setUms_det_cd("0602");
	    			umsLogParam.setUmskey(String.valueOf(serialno));
	    			umsLogParam.setCust_cd(custCd);
	    			// umsLogParam.setRes_cd(fitRsvNo);
	    			umsLogParam.setUms_desc(smsCnt);
	    			umsLogParam.setIns_id("online");
	    			
	    			reserveService.saveUmsLog(umsLogParam);
	    			

					//[JEH] 환불계좌정보가 있으면 SMS발송
					if(!TextUtils.isEmpty(vo.getRfdBankCd())){
			    		serialno = (Integer)  reserveService.srchSmsSeq(serialParam);
			    		
			    		System.out.println(" >>>>>>>>>>>>>>>>> SMS umskey >>> " + serialno);
			    		
				    	cellNo = "1899-3325"; //닷컴유입

				    	smsCnt = "[롯데제이티비] 자유여행 환불요청이 접수되었습니다.";
				    	smsCnt = smsCnt + "(예약번호:" + vo.getFitRsvNo() + ")";
				    	smsSendParam.setSerialno(serialno); 
				    	smsSendParam.setDestcallno("01050202003");
				    	smsSendParam.setCallbackno(cellNo);
				    	smsSendParam.setSmsdata(smsCnt);
				    	smsSendParam.setSubject("0602");
				    	smsSendParam.setReserved("online");		    		
			    		
		    			reserveService.saveSmsSend(smsSendParam);
		    			
		    			System.out.println(">>>>>>>>>>>>>>>>> SMS SEND COMPLETE !!!!!! ");

		    			// ------------------------------------------------------------------------------
		    			// SMS UMS 로그 남기기 
		    			// ------------------------------------------------------------------------------  			
		    			
		    			umsLogParam.setUms_fg_cd("SMS");
		    			umsLogParam.setUms_det_cd("0602");
		    			umsLogParam.setUmskey(String.valueOf(serialno));
		    			umsLogParam.setCust_cd(custCd);
		    			// umsLogParam.setRes_cd(fitRsvNo);
		    			umsLogParam.setUms_desc(smsCnt);
		    			umsLogParam.setIns_id("online");
		    			
		    			reserveService.saveUmsLog(umsLogParam);
		    			
		    			System.out.println(">>>>>>>>>>>>>>>>> SMS SEND UMS LOG SAVE !!!!!! ");

					}
	    			
		    	} catch (Exception e) {
					//e.printStackTrace();
					System.out.println("SMS SEND FAIL !!!!!! " + e.getMessage());
				}
		    	
		    	
		    	/**
		    	 * ----------------------------------------------------------------------------------
		    	 * EMS 메일  발송 연동 
		    	 * ----------------------------------------------------------------------------------
		    	 */
		    	try {
		    		
		    		EmsMailSendVO emsMailSendParam = new EmsMailSendVO();
		    		
		    		emsMailSendParam.setMail_code("701");
		    		emsMailSendParam.setMail_nm("자유여행 호텔 예약취소");
		    		emsMailSendParam.setTo_name(fitReserveVO.getMstRsvNm());
		    		emsMailSendParam.setTo_email(fitReserveVO.getMstRsvNmEmail());
		    		
		    		String mail_url_mapping = "fitRsvNo=" + vo.getFitRsvNo();
		    		emsMailSendParam.setMail_url_mapping(mail_url_mapping);
		    		emsMailSendParam.setSubject("자유여행 호텔 예약이 취소되었습니다.");
		    		emsMailSendParam.setFrom_email("webmaster@lottejtb.com");
		    		emsMailSendParam.setFrom_name("롯데제이티비");
		    		emsMailSendParam.setContents_mapping(mail_url_mapping);
		    		emsMailSendParam.setReg_dt(fitReserveVO.getRsvDt());
		    		reserveService.saveEmsMailSend(emsMailSendParam);
		    		
		    		Map<String, Object> serialParam = new HashMap<String, Object>();
		    		int serialno = (Integer)  reserveService.srchEmsMailSendSeq(serialParam);
		    		
	    			// ------------------------------------------------------------------------------
	    			// SMS UMS 로그 남기기 
		    		// SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
		    		// 2267160	EMS	954666	0101	P161020-0294	0000169965	예약완료되었습니다.				2016/10/20 19:57:59	online
		    		// ------------------------------------------------------------------------------  			
	    			UmsLogVO umsLogParam = new UmsLogVO();
	    			umsLogParam.setUms_fg_cd("EMS");
	    			umsLogParam.setUms_det_cd("0601");
	    			umsLogParam.setUmskey(String.valueOf(serialno));
	    			umsLogParam.setCust_cd(custCd);
	    			// umsLogParam.setRes_cd(param.getRes_cd());
	    			umsLogParam.setUms_desc("호텔예약이 취소되었습니다.");
	    			umsLogParam.setIns_id("online");
	    			
	    			reserveService.saveUmsLog(umsLogParam);
		    	} catch (Exception e) {
					//e.printStackTrace();
					System.out.println("EMS MAIL SEND FAIL !!!!!! " + e.getMessage());
		    	}
			}else{
				result.put("resultCode", "0");
				result.put("resultMsg", "error");
				
				successYN = false;
			}
		}
		
		model.addAttribute("result", result);
	
		return "jsonView";
	}
	
	/**
	 *	자유여행 예약 처리 
	 * @return
	 */
	@RequestMapping(value = "/fitReserveRntCancel.do", method =  {RequestMethod.GET, RequestMethod.POST})
	public String fitReserveRntCancel(@ModelAttribute FreeCancelReserveVO vo, HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		ArrayList<FreeCancelReserveVO> reserveResult = fitReserveService.selectRntCancelList(vo);

		int rntCnt = 0;
		
		String custCd = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
		}
		
		ArrayList<FreeCancelReserveVO> rntResCancelVOList = new ArrayList<FreeCancelReserveVO>();

		
		for(FreeCancelReserveVO tempVO : reserveResult){

			FreeCancelReserveVO rntResCancelVO = new FreeCancelReserveVO();
			String[] operNmArr = tempVO.getOperNm().split(" ");
			
			rntResCancelVO.setSuplrRsvNo(tempVO.getSuplrRsvNo());
			rntResCancelVO.setOperSurName(operNmArr[0]);
			rntResCancelVO.setMstRsvNmId(tempVO.getMstRsvNmId());
			
			rntResCancelVOList.add(rntResCancelVO);
		}		
	
		HashMap<String, Object> rntResult = new HashMap<String, Object>();
		for(rntCnt = 0; rntCnt < rntResCancelVOList.size(); rntCnt++){
			rntResult = rentalcarService.reserveCancelRentalCar(rntResCancelVOList.get(rntCnt));
		}
		
		
		if(rntCnt > 0){
			if(rntResult.get("resultCode").equals("1")){
				HashMap<String, Object> rntParam = new HashMap<String, Object>();
				rntParam.put("target", "CANCEL_YN_RNT");
				rntParam.put("fitRsvNo", vo.getFitRsvNo());
				rntParam.put("rntRsvstateGb", "CA");
				
				fitReserveService.updateCancelFitReserve(rntParam);
				
				result.put("resultCode", "1");
				result.put("resultMsg", "success");
				
				FitReserveVO fitReserveVO =  null;
				
				/**
		    	 * 예약 취소시 SMS 발송 기능 필요함. 
		    	 * ----------------------------------------------------------------------------------
		    	 * SMS 발송 연동 
		    	 * ----------------------------------------------------------------------------------
		    	 */
		    	try {
		    		FitReserveVO fitRsvParam = new FitReserveVO();
		    		fitRsvParam.setFitRsvNo(vo.getFitRsvNo());
		    		fitReserveVO = freeRserveService.selectFreeReserve(fitRsvParam);
		    		
		    		Map<String, Object> serialParam = new HashMap<String, Object>();
		    		int serialno = (Integer)  reserveService.srchSmsSeq(serialParam);
		    				    		
			    	SmsVO smsSendParam = new SmsVO();
			    	String cellNo = "02-6313-8000";

			    	cellNo = "1899-3325"; //닷컴유입

			    	String smsCnt = "[롯데제이티비] 자유여행 렌터카 예약이 취소되었습니다.";
			    	smsCnt = smsCnt + "(예약번호:" + vo.getFitRsvNo() + ")";
			    	smsSendParam.setSerialno(serialno); 
			    	smsSendParam.setDestcallno(fitReserveVO.getMstRsvNmHtel());
			    	smsSendParam.setCallbackno(cellNo);
			    	smsSendParam.setSmsdata(smsCnt);
			    	smsSendParam.setSubject("0602");
			    	smsSendParam.setReserved("online");
		    		
		    		
	    			reserveService.saveSmsSend(smsSendParam);
		    		
	    			// ------------------------------------------------------------------------------
	    			// SMS UMS 로그 남기기 
					// -- SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
					// -- 2268019	SMS	3796419	0101	P161219-0001	0000000081	[롯데JTB]예약이 완료되었습니다.(예약번호:P161219-0001)마이투어에서 확인.				2016/12/19 16:57:00	online
	    			// ------------------------------------------------------------------------------  			
	    			
	    			UmsLogVO umsLogParam = new UmsLogVO();
	    			umsLogParam.setUms_fg_cd("SMS");
	    			umsLogParam.setUms_det_cd("0602");
	    			umsLogParam.setUmskey(String.valueOf(serialno));
	    			umsLogParam.setCust_cd(custCd);
	    			// umsLogParam.setRes_cd(fitRsvNo);
	    			umsLogParam.setUms_desc(smsCnt);
	    			umsLogParam.setIns_id("online");
	    			
	    			reserveService.saveUmsLog(umsLogParam);
		    	} catch (Exception e) {
					//e.printStackTrace();
					System.out.println("SMS SEND FAIL !!!!!! " + e.getMessage());
				}
		    	
		    	
		    	/**
		    	 * ----------------------------------------------------------------------------------
		    	 * EMS 메일  발송 연동 
		    	 * ----------------------------------------------------------------------------------
		    	 */
		    	try {
		    		
		    		EmsMailSendVO emsMailSendParam = new EmsMailSendVO();
		    		
		    		emsMailSendParam.setMail_code("701");
		    		emsMailSendParam.setMail_nm("자유여행 렌터카 예약취소");
		    		emsMailSendParam.setTo_name(fitReserveVO.getMstRsvNm());
		    		emsMailSendParam.setTo_email(fitReserveVO.getMstRsvNmEmail());
		    		
		    		String mail_url_mapping = "fitRsvNo=" + vo.getFitRsvNo();
		    		emsMailSendParam.setMail_url_mapping(mail_url_mapping);
		    		emsMailSendParam.setSubject("자유여행 렌터카 예약이 취소되었습니다.");
		    		emsMailSendParam.setFrom_email("webmaster@lottejtb.com");
		    		emsMailSendParam.setFrom_name("롯데제이티비");
		    		emsMailSendParam.setContents_mapping(mail_url_mapping);
		    		emsMailSendParam.setReg_dt(fitReserveVO.getRsvDt());
		    		reserveService.saveEmsMailSend(emsMailSendParam);
		    		
		    		Map<String, Object> serialParam = new HashMap<String, Object>();
		    		int serialno = (Integer)  reserveService.srchEmsMailSendSeq(serialParam);
		    		
	    			// ------------------------------------------------------------------------------
	    			// SMS UMS 로그 남기기 
		    		// SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
		    		// 2267160	EMS	954666	0101	P161020-0294	0000169965	예약완료되었습니다.				2016/10/20 19:57:59	online
		    		// ------------------------------------------------------------------------------  			
	    			UmsLogVO umsLogParam = new UmsLogVO();
	    			umsLogParam.setUms_fg_cd("EMS");
	    			umsLogParam.setUms_det_cd("0601");
	    			umsLogParam.setUmskey(String.valueOf(serialno));
	    			umsLogParam.setCust_cd(custCd);
	    			// umsLogParam.setRes_cd(param.getRes_cd());
	    			umsLogParam.setUms_desc("렌터카 예약이 취소되었습니다.");
	    			umsLogParam.setIns_id("online");
	    			
	    			reserveService.saveUmsLog(umsLogParam);
		    	} catch (Exception e) {
					//e.printStackTrace();
					System.out.println("EMS MAIL SEND FAIL !!!!!! " + e.getMessage());
		    	}
			}else{
				result.put("resultCode", "0");
				result.put("resultMsg", "error");
			}
		}
		
		model.addAttribute("result", result);
	
		return "jsonView";
	}
}
