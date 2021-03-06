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
	
	// ?????? ?????? ?????? ????????? 
	@Resource(name = "ReserveService")
	private ReserveService reserveService;
	
	// ?????? ??????
	@Resource(name = "HtlPaymtService")
	private HtlPaymtService htlPaymtService;
	
		
    @Resource(name = "ehcache")
    Ehcache ehcache;
    
	
	/**
	 *	???????????? ?????? ?????? 
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
					
					/*********** ?????? ?????? ?????? ??? ???????????? ?????? ?????? ???????????? ************/
					
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
					
					/** ????????? ?????? ??? ?????? ?????? 8111 : transaction time out ==> ????????? ?????? ?????? :: 2017.03.23 **/
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
							
							/*********** ?????? ?????? ?????? ??? ???????????? ?????? ?????? ???????????? ************/
							
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
							
							System.out.println("=================???????????? ?????? 1 start=====================");
							String errMsg = result.getString("message") + "|" + "?????? ????????? ??????????????????.\n?????? ????????? ???????????? ?????????.";
							reqVO.getReqReserve().setErr_msg(errMsg);
							freeRserveService.updateFreeReserve(reqVO.getReqReserve());
							
							reqVO.getReqReserve().setFitRsvNo(fitRsvNo);
							freeRserveService.deleteFreeReserve(reqVO.getReqReserve());
														
							nextStepYN = false;
							System.out.println("=================???????????? ?????? 2 end=====================");
						}					
						
					} else {
						result.put("code", 0);
						result.put("message", "error");
						
						System.out.println("=================???????????? ?????? 3 start=====================");
						String errMsg = result.getString("message") + "|" + "?????? ????????? ??????????????????.\n?????? ????????? ???????????? ?????????.";
						reqVO.getReqReserve().setErr_msg(errMsg);
						freeRserveService.updateFreeReserve(reqVO.getReqReserve());
																
						reqVO.getReqReserve().setFitRsvNo(fitRsvNo);
						freeRserveService.deleteFreeReserve(reqVO.getReqReserve());
						nextStepYN = false;
						System.out.println("=================???????????? ?????? 4 end=====================");
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
						
						System.out.println("=======================?????? ?????? ??????1=============start");
						String errMsg = "?????? ????????? ??????????????????. \n?????? ?????? ?????? ?????? ??????????????? ????????? ???????????????.";
						String suplErrMsg = result.getString("message").toLowerCase(); 
						
						// ?????? ???
			    		if(suplErrMsg.indexOf("soldout") != -1
			    				|| suplErrMsg.indexOf("sold out") != -1){
			    			
			    			errMsg = "?????????! ???????????????. \n?????? ????????? ?????? ????????? ????????? ????????? ?????? ?????????. \n?????? ?????? ??????????????? ?????? ?????? ????????? ?????????. \n????????? ?????? ?????? ?????? ????????? ?????? ?????????.";
			    		} else if(suplErrMsg.indexOf("processFail") != -1){
			    			
			    			errMsg = "???????????? ????????? ?????? ?????? ????????? ??????????????????. \n?????? ?????? ?????? ?????? ??????????????? ????????? ???????????????.";
			    		} else if(suplErrMsg.indexOf("nolonger") != -1){
			    			
			    			errMsg = "?????? ????????? ??????????????????. \n???????????? ????????? ??????????????? ???????????? ?????? ???????????????. \n?????? ?????? ?????? ?????? ??????????????? ????????? ???????????????.";
			    		}

	            		reqVO.getReqReserve().setErr_msg(result.getString("message") + " | " + errMsg);
	            		reqVO.getReqReserve().setHtlRsvStateGb("XX");
			    		//?????? ????????? ??????
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
							System.out.println("========?????? ?????? ?????? ?????? start=============");
							
							RestTemplate oRestTemplate = new RestTemplate();
							JSONObject reqParam = new JSONObject();
							
							reqParam.put("fitRsvNo", fitRsvNo);
							reqParam.put("cancelReason", "1");
							reqParam.put("msg", "????????????");
							
							htlPaymtService.cancelPayment(reqParam);						
							
							//?????? ?????? api ??????--start
							FreeCancelReserveVO vo = new FreeCancelReserveVO();
							vo.setFitRsvNo(fitRsvNo);
							fitReserveHtlCancel(vo,request,model);
							//?????? ?????? api ??????--end
							
							//???????????? ?????? ?????? ?????? ????????????.
							//JSONObject oJSONResponse1 = oRestTemplate.postForObject("http://fitdev.lottejtb.com/fit/rsv/paymentCancelAjax.do" , oJSONRequest, JSONObject.class);
							JSONObject oJSONResponse1 = oRestTemplate.postForObject("https://fit.lottejtb.com/fit/rsv/paymentCancelAjax.do" , reqParam, JSONObject.class);
							
							System.out.println("========?????? ?????? ?????? ?????? end=============");
						} catch (Exception e) {
							//e.printStackTrace();
							System.err.println("Reserve Error!");
						}
						
						if(reqVO.getAirYN().equals("Y")) {
							ReqAirReserveCancelVO airResCancelVO = new ReqAirReserveCancelVO();
							
							airResCancelVO.setRsvSeqno(Integer.parseInt(airResultVal.get("rsvSeqno").toString()));
							
							airService.reqAirReserveCancel(airResCancelVO, custCd);
							
							//?????? ?????? ?????? ??? ?????? ?????? ?????? ?????? ?????? ?????? ?????? 2019.03.13 bum
							if(!airResultVal.get("code").equals("1") && hotelResultVal.get("code").equals("1")){
								try {
									/*
									stateVO.setFitRsvNo(fitRsvNo);
									stateVO.setHtlRsvStateGb("ER");
									stateVO.setHtlPaymtstateGb("XR");
									stateVO.setUseYn("Y");
									
									freeRserveService.updateFitReserveState(stateVO);
									*/
									System.out.println("========?????? ?????? ?????? ?????? start=============");
									
									RestTemplate oRestTemplate = new RestTemplate();
									JSONObject reqParam = new JSONObject();
									
									reqParam.put("fitRsvNo", fitRsvNo);
									reqParam.put("cancelReason", "1");
									reqParam.put("msg", "????????????");
									
									htlPaymtService.cancelPayment(reqParam);						
									
									//?????? ?????? api ??????--start
									FreeCancelReserveVO vo = new FreeCancelReserveVO();
									vo.setFitRsvNo(fitRsvNo);
									fitReserveHtlCancel(vo,request,model);
									//?????? ?????? api ??????--end
									
									//???????????? ?????? ?????? ?????? ????????????.
									//JSONObject oJSONResponse1 = oRestTemplate.postForObject("http://fitdev.lottejtb.com/fit/rsv/paymentCancelAjax.do" , oJSONRequest, JSONObject.class);
									JSONObject oJSONResponse1 = oRestTemplate.postForObject("https://fit.lottejtb.com/fit/rsv/paymentCancelAjax.do" , reqParam, JSONObject.class);
									
									System.out.println("========?????? ?????? ?????? ?????? end=============");
								} catch (Exception e) {
									//e.printStackTrace();
									System.err.println("Reserve Error!");
								}
							}
						}
						
						freeRserveService.deleteFreeReserve(reqVO.getReqReserve());
						nextStepYN = false;
						
						System.out.println("=======================?????? ?????? ??????2===============end");
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
					
					System.out.println("=======================????????? ?????? ??????1 start===============");
					String errMsg = result.getString("message") + "|" + "????????? ????????? ??????????????????. \n?????? ???????????? ?????? ???????????? ?????? ????????? ???????????? ?????????.";
			    	reqVO.getReqReserve().setErr_msg(errMsg);
			    	//?????? ????????? ??????
					freeRserveService.updateFreeReserve(reqVO.getReqReserve());
					
					if(reqVO.getAirYN().equals("Y")) {
						ReqAirReserveCancelVO airResCancelVO = new ReqAirReserveCancelVO();
						
						airResCancelVO.setRsvSeqno(Integer.parseInt(airResultVal.get("rsvSeqno").toString()));
						
						airService.reqAirReserveCancel(airResCancelVO, custCd);
					}
					
					freeRserveService.deleteFreeReserve(reqVO.getReqReserve());
					nextStepYN = false;
					
					System.out.println("=======================????????? ?????? ??????2 end===============");
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
			logger.error("??????????????? ????????????!!!!!!!");
					
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
				System.out.println("================== ?????? ??????  start======================");
				String errMsg = "?????? ??? ???????????? ???????????? ?????? ?????????????????????.";
				reqVO.getReqReserve().setErr_msg(errMsg);
				freeRserveService.updateFreeReserve(reqVO.getReqReserve());
								
				freeRserveService.deleteFreeReserve(reqVO.getReqReserve());
				nextStepYN = false;
				
				System.out.println("================== ?????? ??????  end======================");
			} catch (Exception e1) {
				System.out.println(e1.getMessage());
			}
			//e.printStackTrace();
		}
		
		if(nextStepYN){
			result.put("code", 1);
			result.put("message", "success");
			System.out.println("???????????? ??????=" + nextStepYN);		
			
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
				
				//??????
				System.out.println("???????????? ###################################");
				System.out.println("???????????? ----------------------start------");
				JSONObject oJSONResponse = template.postForObject("https://fit.lottejtb.com/tos/sendRsvDataAjax.do" , oJSONRequest,  JSONObject.class);
				System.out.println("???????????? ----------------------end-------"); 
				System.out.println("???????????? ###################################");
				//??????
				//JSONObject oJSONResponse = template.postForObject("http://fitdev.lottejtb.com/tos/sendRsvDataAjax.do" , oJSONRequest,  JSONObject.class);
				
			} catch (Exception e) {
				//e.printStackTrace();
				System.err.println("Reserve Error!");
				System.out.println("???????????? ----------------------");
			}
			
	    	if(!fitRsvNo.equals("")) {
	    		FitReserveVO fitReserveVO =  null;
		    	/**
		    	 * ?????? ????????? SMS ?????? ?????? ?????????. 
		    	 * ----------------------------------------------------------------------------------
		    	 * SMS ?????? ?????? 
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
	
			    	cellNo = "1899-3325"; //????????????
	
			    	String smsCnt = "[??????????????????] ???????????? ????????? ?????????????????????.";
			    	smsCnt = smsCnt + "(????????????:" + fitRsvNo + ")?????????????????? ??????.";
			    	smsSendParam.setSerialno(serialno); 
			    	smsSendParam.setDestcallno(fitReserveVO.getMstRsvNmHtel());
			    	smsSendParam.setCallbackno(cellNo);
			    	smsSendParam.setSmsdata(smsCnt);
			    	smsSendParam.setSubject("0602");
			    	smsSendParam.setReserved("online");
		    		
		    		
	    			reserveService.saveSmsSend(smsSendParam);
	    			
	    			System.out.println(">>>>>>>>>>>>>>>>> SMS SEND COMPLETE !!!!!! ");
	    		
	
		    		
	    			// ------------------------------------------------------------------------------
	    			// SMS UMS ?????? ????????? 
					// -- SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
					// -- 2268019	SMS	3796419	0101	P161219-0001	0000000081	[??????JTB]????????? ?????????????????????.(????????????:P161219-0001)?????????????????? ??????.				2016/12/19 16:57:00	online
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
	    			
	    			//??????????????? ????????????
	    			
	    			
	    			
		    	} catch (Exception e) {
					//e.printStackTrace();
					System.out.println("SMS SEND FAIL !!!!!! " + e.getMessage());
				}
		    	
		    	
		    	/**
		    	 * ----------------------------------------------------------------------------------
		    	 * EMS ??????  ?????? ?????? 
		    	 * ----------------------------------------------------------------------------------
		    	 */
		    	try {
		    		
		    		EmsMailSendVO emsMailSendParam = new EmsMailSendVO();
		    		
		    		emsMailSendParam.setMail_code("701");
		    		emsMailSendParam.setMail_nm("???????????? ????????????");
		    		emsMailSendParam.setTo_name(fitReserveVO.getMstRsvNm());
		    		emsMailSendParam.setTo_email(fitReserveVO.getMstRsvNmEmail());
		    		
		    		String mail_url_mapping = "fitRsvNo=" + fitRsvNo;
		    		emsMailSendParam.setMail_url_mapping(mail_url_mapping);
		    		emsMailSendParam.setSubject("???????????? ????????? ?????????????????????.");
		    		emsMailSendParam.setFrom_email("webmaster@lottejtb.com");
		    		emsMailSendParam.setFrom_name("??????????????????");
		    		emsMailSendParam.setContents_mapping(mail_url_mapping);
		    		emsMailSendParam.setReg_dt(fitReserveVO.getRsvDt());
		    		reserveService.saveEmsMailSend(emsMailSendParam);
		    		
		    		System.out.println(">>>>>>>>>>>>>>>>> EMS MAIL SEND COMPLETE !!!!!! ");
		    		
		    		Map<String, Object> serialParam = new HashMap<String, Object>();
		    		int serialno = (Integer)  reserveService.srchEmsMailSendSeq(serialParam);
		    		
		    		System.out.println(" >>>>>>>>>>>>>>>>> SMS umskey >>> " + serialno);
		    		
	    			// ------------------------------------------------------------------------------
	    			// SMS UMS ?????? ????????? 
		    		// SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
		    		// 2267160	EMS	954666	0101	P161020-0294	0000169965	???????????????????????????.				2016/10/20 19:57:59	online
		    		// ------------------------------------------------------------------------------  			
	    			UmsLogVO umsLogParam = new UmsLogVO();
	    			umsLogParam.setUms_fg_cd("EMS");
	    			umsLogParam.setUms_det_cd("0601");
	    			umsLogParam.setUmskey(String.valueOf(serialno));
	    			umsLogParam.setCust_cd(custCd);
	    			// umsLogParam.setRes_cd(param.getRes_cd());
	    			umsLogParam.setUms_desc("????????? ?????????????????????.");
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
					
					System.out.println("========?????? ?????? ?????? ?????? start=============");
					
					RestTemplate oRestTemplate = new RestTemplate();
					JSONObject reqParam = new JSONObject();
					
					reqParam.put("fitRsvNo", fitRsvNo);
					reqParam.put("cancelReason", "1");
					reqParam.put("msg", "????????????");
					
					JSONObject oJSONResponse = htlPaymtService.cancelPayment(reqParam);

				    					
					//?????? ?????? ?????? ?????? ?????????
					reqVO.getReqReserve().setHtlRsvStateGb("XX");
					freeRserveService.updateFreeReserve(reqVO.getReqReserve());
					
					
					//?????? ?????? api ??????--start
					FreeCancelReserveVO vo = new FreeCancelReserveVO();
					vo.setFitRsvNo(fitRsvNo);
					fitReserveHtlCancel(vo,request,model);
					//?????? ?????? api ??????--end
					
					//???????????? ?????? ?????? ?????? ????????????.
					//JSONObject oJSONResponse1 = oRestTemplate.postForObject("http://fitdev.lottejtb.com/fit/rsv/paymentCancelAjax.do" , oJSONRequest, JSONObject.class);
					JSONObject oJSONResponse1 = oRestTemplate.postForObject("https://fit.lottejtb.com/fit/rsv/paymentCancelAjax.do" , reqParam, JSONObject.class);
					
					System.out.println("========?????? ?????? ?????? ?????? end=============");
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
	 *	???????????? ?????? ?????? 
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
			logger.error("??????????????? ????????????!!!!!!!");
			result.put("code", 0);
			result.put("message", "error");
			//e.printStackTrace();
		}
		

		model.addAttribute("result", result);
	
		return "jsonView";
					
	}
	
	/**
	 * 1. ?????? : ???????????? ??? ???????????? ?????? ?????? ?????? 
	 * 2. ???????????? : 
	 * 3. ???????????? : 
	 * ======================================
	 * 4. ????????? / ????????? : 
	 * ======================================
	 * 5. ????????????
	 * 5.1 ???????????? ID : 
	 *  - ????????? / ????????? :
	 *  - ???????????? / ?????? :
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
	 *	???????????? ?????? ???????????? ?????? 
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
			logger.error("??????????????? ????????????!!!!!!!");
			//e.printStackTrace();
		}

		model.addAttribute("airList", airList);
		
		return "jsonView";
					
	}
	
	/**
	 *	???????????? ?????? ???????????? ?????? 
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
			logger.error("??????????????? ????????????!!!!!!!");
			//e.printStackTrace();
		}

		model.addAttribute("result", resultVal);
		
		return "jsonView";
					
	}
	
	/**
	 *	???????????? ?????? ?????? ?????? 
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
			logger.error("??????????????? ????????????!!!!!!!");
			//e.printStackTrace();
		}

		model.addAttribute("result", resultVal);
		
		return "jsonView";
					
	}
	
	// <!-- ??????????????? ?????? ??????    -->
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
			logger.error("??????????????? ????????????!!!!!!!");
			//e.printStackTrace();
		}

		model.addAttribute("result", resultVal);
		
		return "jsonView";		
	}
	
	// <!-- ?????? ?????? ??????    -->
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
			logger.error("??????????????? ????????????!!!!!!!");
			//e.printStackTrace();
		}

		model.addAttribute("result", resultVal);
		
		return "jsonView";		
	}	
	
	// <!-- ?????? ?????? ??????    -->
	@RequestMapping(value = "/account/saveVisaAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String saveVisaAjax(@RequestParam("seqNo") String seqNo, HttpServletRequest request, ModelMap model)throws Exception{

		
		return "jsonView";		
	}	
	
	// <!-- ?????? ?????? ????????????   -->
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
			
			//?????? URL ?????? ??????
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
			
			//?????? URL ?????? ??????
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
			
			//?????? URL ?????? ??????
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
			
			//?????? URL ?????? ??????
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
			
			//?????? URL ?????? ??????
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
			
			//?????? URL ?????? ??????
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
			
			//?????? URL ?????? ??????
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
			
			//?????? URL ?????? ??????
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
			
			//?????? URL ?????? ??????
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
			
			//?????? URL ?????? ??????
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
	 *	???????????? ?????? ?????? ?????? 
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
					htlParam.put("htlRsvstateGb", "XX");		//[JEH] ??????_????????????_GB ?????? - 20180201
					htlParam.put("fitRsvNo", vo.getFitRsvNo());					
					
					//[JEH] ??????????????????
					if(!TextUtils.isEmpty(vo.getRfdBankCd())){
						htlParam.put("htlRsvstateGb", "RF");		//[JEH] ??????_????????????_GB ?????? - 20180201
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
					oJSONRequest.put("msg", "????????????");
			        
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
	    	 * ?????? ????????? SMS ?????? ?????? ?????????. 
	    	 * ----------------------------------------------------------------------------------
	    	 * SMS ?????? ?????? 
	    	 * ----------------------------------------------------------------------------------
	    	 */
			
			//?????? ?????? tos??????--start
			RestTemplate template = new RestTemplate();
			JSONObject oJSONRequest = new JSONObject();
			
			//??????
			//????????? ???????????? InvocationTargetException
			
			//JSONObject oJSONResponse = template.postForObject("http://fitdev.lottejtb.com /tos/sendCancelDataAjax.do" , oJSONRequest, JSONObject.class);

            System.out.println("========= [JEH] 20171026 FitReserveController - fitReserveCancel - ?????? Ajax ????????? ???????????? ?????????????????? ????????? ?????????????????????.");
			//??????
			//JSONObject oJSONResponse = template.postForObject("https://fit.lottejtb.com /tos/sendCancelDataAjax.do" , oJSONRequest, JSONObject.class);
																 			
			//?????? ?????? tos??????--end
			
	    	try {
	    		FitReserveVO fitRsvParam = new FitReserveVO();
	    		fitRsvParam.setFitRsvNo(vo.getFitRsvNo());
	    		fitReserveVO = freeRserveService.selectFreeReserve(fitRsvParam);
	    		
	    		Map<String, Object> serialParam = new HashMap<String, Object>();
	    		int serialno = (Integer)  reserveService.srchSmsSeq(serialParam);
	    		
	    		System.out.println(" >>>>>>>>>>>>>>>>> SMS umskey >>> " + serialno);
	    		
		    	SmsVO smsSendParam = new SmsVO();
		    	String cellNo = "02-6313-8000";

		    	cellNo = "1899-3325"; //????????????

		    	String smsCnt = "[??????????????????] ???????????? ????????? ?????????????????????.";
		    	smsCnt = smsCnt + "(????????????:" + vo.getFitRsvNo() + ")";
		    	smsSendParam.setSerialno(serialno); 
		    	smsSendParam.setDestcallno(fitReserveVO.getMstRsvNmHtel());
		    	smsSendParam.setCallbackno(cellNo);
		    	smsSendParam.setSmsdata(smsCnt);
		    	smsSendParam.setSubject("0602");
		    	smsSendParam.setReserved("online");
	    		
	    		
    			reserveService.saveSmsSend(smsSendParam);
    			
    			System.out.println(">>>>>>>>>>>>>>>>> SMS SEND COMPLETE !!!!!! ");
    		

	    		
    			// ------------------------------------------------------------------------------
    			// SMS UMS ?????? ????????? 
				// -- SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
				// -- 2268019	SMS	3796419	0101	P161219-0001	0000000081	[??????JTB]????????? ?????????????????????.(????????????:P161219-0001)?????????????????? ??????.				2016/12/19 16:57:00	online
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

				//[JEH] ????????????????????? ????????? SMS??????
				if(!TextUtils.isEmpty(vo.getRfdBankCd())){
		    		serialno = (Integer)  reserveService.srchSmsSeq(serialParam);
		    		
		    		System.out.println(" >>>>>>>>>>>>>>>>> SMS umskey >>> " + serialno);
		    		
			    	cellNo = "1899-3325"; //????????????

			    	smsCnt = "[??????????????????] ???????????? ??????????????? ?????????????????????.";
			    	smsCnt = smsCnt + "(????????????:" + vo.getFitRsvNo() + ")";
			    	smsSendParam.setSerialno(serialno); 
			    	smsSendParam.setDestcallno("01050202003");
			    	smsSendParam.setCallbackno(cellNo);
			    	smsSendParam.setSmsdata(smsCnt);
			    	smsSendParam.setSubject("0602");
			    	smsSendParam.setReserved("online");		    		
		    		
	    			reserveService.saveSmsSend(smsSendParam);
	    			
	    			System.out.println(">>>>>>>>>>>>>>>>> SMS SEND COMPLETE !!!!!! ");

	    			// ------------------------------------------------------------------------------
	    			// SMS UMS ?????? ????????? 
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
	    	 * EMS ??????  ?????? ?????? 
	    	 * ----------------------------------------------------------------------------------
	    	 */
	    	try {
	    		
	    		EmsMailSendVO emsMailSendParam = new EmsMailSendVO();
	    		
	    		emsMailSendParam.setMail_code("701");
	    		emsMailSendParam.setMail_nm("???????????? ????????????");
	    		emsMailSendParam.setTo_name(fitReserveVO.getMstRsvNm());
	    		emsMailSendParam.setTo_email(fitReserveVO.getMstRsvNmEmail());
	    		
	    		String mail_url_mapping = "fitRsvNo=" + vo.getFitRsvNo();
	    		emsMailSendParam.setMail_url_mapping(mail_url_mapping);
	    		emsMailSendParam.setSubject("???????????? ????????? ?????????????????????.");
	    		emsMailSendParam.setFrom_email("webmaster@lottejtb.com");
	    		emsMailSendParam.setFrom_name("??????????????????");
	    		emsMailSendParam.setContents_mapping(mail_url_mapping);
	    		emsMailSendParam.setReg_dt(fitReserveVO.getRsvDt());
	    		reserveService.saveEmsMailSend(emsMailSendParam);
	    		
	    		Map<String, Object> serialParam = new HashMap<String, Object>();
	    		int serialno = (Integer)  reserveService.srchEmsMailSendSeq(serialParam);
	    		
    			// ------------------------------------------------------------------------------
    			// SMS UMS ?????? ????????? 
	    		// SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
	    		// 2267160	EMS	954666	0101	P161020-0294	0000169965	???????????????????????????.				2016/10/20 19:57:59	online
	    		// ------------------------------------------------------------------------------  			
    			UmsLogVO umsLogParam = new UmsLogVO();
    			umsLogParam.setUms_fg_cd("EMS");
    			umsLogParam.setUms_det_cd("0601");
    			umsLogParam.setUmskey(String.valueOf(serialno));
    			umsLogParam.setCust_cd(custCd);
    			// umsLogParam.setRes_cd(param.getRes_cd());
    			umsLogParam.setUms_desc("????????? ?????????????????????.");
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
	 * ???????????? ?????? 
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
	 *	???????????? ?????? ????????????
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
		    	 * ?????? ????????? SMS ?????? ?????? ?????????. 
		    	 * ----------------------------------------------------------------------------------
		    	 * SMS ?????? ?????? 
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

			    	cellNo = "1899-3325"; //????????????

			    	String smsCnt = "[??????????????????] ???????????? ??????????????? ?????????????????????.";
			    	smsCnt = smsCnt + "(????????????:" + vo.getFitRsvNo() + ")";
			    	smsSendParam.setSerialno(serialno); 
			    	smsSendParam.setDestcallno(fitReserveVO.getMstRsvNmHtel());
			    	smsSendParam.setCallbackno(cellNo);
			    	smsSendParam.setSmsdata(smsCnt);
			    	smsSendParam.setSubject("0602");
			    	smsSendParam.setReserved("online");
		    		
		    		
	    			reserveService.saveSmsSend(smsSendParam);
		    		
	    			// ------------------------------------------------------------------------------
	    			// SMS UMS ?????? ????????? 
					// -- SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
					// -- 2268019	SMS	3796419	0101	P161219-0001	0000000081	[??????JTB]????????? ?????????????????????.(????????????:P161219-0001)?????????????????? ??????.				2016/12/19 16:57:00	online
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
		    	 * EMS ??????  ?????? ?????? 
		    	 * ----------------------------------------------------------------------------------
		    	 */
		    	try {
		    		
		    		EmsMailSendVO emsMailSendParam = new EmsMailSendVO();
		    		
		    		emsMailSendParam.setMail_code("701");
		    		emsMailSendParam.setMail_nm("???????????? ?????? ????????????");
		    		emsMailSendParam.setTo_name(fitReserveVO.getMstRsvNm());
		    		emsMailSendParam.setTo_email(fitReserveVO.getMstRsvNmEmail());
		    		
		    		String mail_url_mapping = "fitRsvNo=" + vo.getFitRsvNo();
		    		emsMailSendParam.setMail_url_mapping(mail_url_mapping);
		    		emsMailSendParam.setSubject("???????????? ?????? ????????? ?????????????????????.");
		    		emsMailSendParam.setFrom_email("webmaster@lottejtb.com");
		    		emsMailSendParam.setFrom_name("??????????????????");
		    		emsMailSendParam.setContents_mapping(mail_url_mapping);
		    		emsMailSendParam.setReg_dt(fitReserveVO.getRsvDt());
		    		reserveService.saveEmsMailSend(emsMailSendParam);
		    		
		    		Map<String, Object> serialParam = new HashMap<String, Object>();
		    		int serialno = (Integer)  reserveService.srchEmsMailSendSeq(serialParam);
		    		
	    			// ------------------------------------------------------------------------------
	    			// SMS UMS ?????? ????????? 
		    		// SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
		    		// 2267160	EMS	954666	0101	P161020-0294	0000169965	???????????????????????????.				2016/10/20 19:57:59	online
		    		// ------------------------------------------------------------------------------  			
	    			UmsLogVO umsLogParam = new UmsLogVO();
	    			umsLogParam.setUms_fg_cd("EMS");
	    			umsLogParam.setUms_det_cd("0601");
	    			umsLogParam.setUmskey(String.valueOf(serialno));
	    			umsLogParam.setCust_cd(custCd);
	    			// umsLogParam.setRes_cd(param.getRes_cd());
	    			umsLogParam.setUms_desc("??????????????? ?????????????????????.");
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
	 *	???????????? ?????? ???????????? 
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

				//[JEH] ??????????????????
				if(!TextUtils.isEmpty(vo.getRfdBankCd())){
					htlParam.put("rfdBankCd", vo.getRfdBankCd());
					htlParam.put("rfdActNo", vo.getRfdActNo());
					fitReserveService.updateActPaymt(htlParam);
				}
				
				RestTemplate oRestTemplate = new RestTemplate();
				JSONObject reqParam = new JSONObject();
				
				reqParam.put("fitRsvNo", vo.getFitRsvNo());
				reqParam.put("cancelReason", "1");
				reqParam.put("msg", "????????????");
				
				JSONObject oJSONResponse = htlPaymtService.cancelPayment(reqParam);
				
				//JSONObject oJSONResponse1 = oRestTemplate.postForObject("http://fitdev.lottejtb.com/fit/rsv/paymentCancelAjax.do" , oJSONRequest, JSONObject.class);
				JSONObject oJSONResponse1 = oRestTemplate.postForObject("https://fit.lottejtb.com/fit/rsv/paymentCancelAjax.do" , reqParam, JSONObject.class);
				
				FitReserveVO fitReserveVO =  null;
				
				/**
		    	 * ?????? ????????? SMS ?????? ?????? ?????????. 
		    	 * ----------------------------------------------------------------------------------
		    	 * SMS ?????? ?????? 
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

			    	cellNo = "1899-3325"; //????????????

			    	String smsCnt = "[??????????????????] ???????????? ??????????????? ?????????????????????.";
			    	smsCnt = smsCnt + "(????????????:" + vo.getFitRsvNo() + ")";
			    	smsSendParam.setSerialno(serialno); 
			    	smsSendParam.setDestcallno(fitReserveVO.getMstRsvNmHtel());
			    	smsSendParam.setCallbackno(cellNo);
			    	smsSendParam.setSmsdata(smsCnt);
			    	smsSendParam.setSubject("0602");
			    	smsSendParam.setReserved("online");
		    		
		    		
	    			reserveService.saveSmsSend(smsSendParam);
		    		
	    			// ------------------------------------------------------------------------------
	    			// SMS UMS ?????? ????????? 
					// -- SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
					// -- 2268019	SMS	3796419	0101	P161219-0001	0000000081	[??????JTB]????????? ?????????????????????.(????????????:P161219-0001)?????????????????? ??????.				2016/12/19 16:57:00	online
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
	    			

					//[JEH] ????????????????????? ????????? SMS??????
					if(!TextUtils.isEmpty(vo.getRfdBankCd())){
			    		serialno = (Integer)  reserveService.srchSmsSeq(serialParam);
			    		
			    		System.out.println(" >>>>>>>>>>>>>>>>> SMS umskey >>> " + serialno);
			    		
				    	cellNo = "1899-3325"; //????????????

				    	smsCnt = "[??????????????????] ???????????? ??????????????? ?????????????????????.";
				    	smsCnt = smsCnt + "(????????????:" + vo.getFitRsvNo() + ")";
				    	smsSendParam.setSerialno(serialno); 
				    	smsSendParam.setDestcallno("01050202003");
				    	smsSendParam.setCallbackno(cellNo);
				    	smsSendParam.setSmsdata(smsCnt);
				    	smsSendParam.setSubject("0602");
				    	smsSendParam.setReserved("online");		    		
			    		
		    			reserveService.saveSmsSend(smsSendParam);
		    			
		    			System.out.println(">>>>>>>>>>>>>>>>> SMS SEND COMPLETE !!!!!! ");

		    			// ------------------------------------------------------------------------------
		    			// SMS UMS ?????? ????????? 
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
		    	 * EMS ??????  ?????? ?????? 
		    	 * ----------------------------------------------------------------------------------
		    	 */
		    	try {
		    		
		    		EmsMailSendVO emsMailSendParam = new EmsMailSendVO();
		    		
		    		emsMailSendParam.setMail_code("701");
		    		emsMailSendParam.setMail_nm("???????????? ?????? ????????????");
		    		emsMailSendParam.setTo_name(fitReserveVO.getMstRsvNm());
		    		emsMailSendParam.setTo_email(fitReserveVO.getMstRsvNmEmail());
		    		
		    		String mail_url_mapping = "fitRsvNo=" + vo.getFitRsvNo();
		    		emsMailSendParam.setMail_url_mapping(mail_url_mapping);
		    		emsMailSendParam.setSubject("???????????? ?????? ????????? ?????????????????????.");
		    		emsMailSendParam.setFrom_email("webmaster@lottejtb.com");
		    		emsMailSendParam.setFrom_name("??????????????????");
		    		emsMailSendParam.setContents_mapping(mail_url_mapping);
		    		emsMailSendParam.setReg_dt(fitReserveVO.getRsvDt());
		    		reserveService.saveEmsMailSend(emsMailSendParam);
		    		
		    		Map<String, Object> serialParam = new HashMap<String, Object>();
		    		int serialno = (Integer)  reserveService.srchEmsMailSendSeq(serialParam);
		    		
	    			// ------------------------------------------------------------------------------
	    			// SMS UMS ?????? ????????? 
		    		// SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
		    		// 2267160	EMS	954666	0101	P161020-0294	0000169965	???????????????????????????.				2016/10/20 19:57:59	online
		    		// ------------------------------------------------------------------------------  			
	    			UmsLogVO umsLogParam = new UmsLogVO();
	    			umsLogParam.setUms_fg_cd("EMS");
	    			umsLogParam.setUms_det_cd("0601");
	    			umsLogParam.setUmskey(String.valueOf(serialno));
	    			umsLogParam.setCust_cd(custCd);
	    			// umsLogParam.setRes_cd(param.getRes_cd());
	    			umsLogParam.setUms_desc("??????????????? ?????????????????????.");
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
	 *	???????????? ?????? ?????? 
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
		    	 * ?????? ????????? SMS ?????? ?????? ?????????. 
		    	 * ----------------------------------------------------------------------------------
		    	 * SMS ?????? ?????? 
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

			    	cellNo = "1899-3325"; //????????????

			    	String smsCnt = "[??????????????????] ???????????? ????????? ????????? ?????????????????????.";
			    	smsCnt = smsCnt + "(????????????:" + vo.getFitRsvNo() + ")";
			    	smsSendParam.setSerialno(serialno); 
			    	smsSendParam.setDestcallno(fitReserveVO.getMstRsvNmHtel());
			    	smsSendParam.setCallbackno(cellNo);
			    	smsSendParam.setSmsdata(smsCnt);
			    	smsSendParam.setSubject("0602");
			    	smsSendParam.setReserved("online");
		    		
		    		
	    			reserveService.saveSmsSend(smsSendParam);
		    		
	    			// ------------------------------------------------------------------------------
	    			// SMS UMS ?????? ????????? 
					// -- SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
					// -- 2268019	SMS	3796419	0101	P161219-0001	0000000081	[??????JTB]????????? ?????????????????????.(????????????:P161219-0001)?????????????????? ??????.				2016/12/19 16:57:00	online
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
		    	 * EMS ??????  ?????? ?????? 
		    	 * ----------------------------------------------------------------------------------
		    	 */
		    	try {
		    		
		    		EmsMailSendVO emsMailSendParam = new EmsMailSendVO();
		    		
		    		emsMailSendParam.setMail_code("701");
		    		emsMailSendParam.setMail_nm("???????????? ????????? ????????????");
		    		emsMailSendParam.setTo_name(fitReserveVO.getMstRsvNm());
		    		emsMailSendParam.setTo_email(fitReserveVO.getMstRsvNmEmail());
		    		
		    		String mail_url_mapping = "fitRsvNo=" + vo.getFitRsvNo();
		    		emsMailSendParam.setMail_url_mapping(mail_url_mapping);
		    		emsMailSendParam.setSubject("???????????? ????????? ????????? ?????????????????????.");
		    		emsMailSendParam.setFrom_email("webmaster@lottejtb.com");
		    		emsMailSendParam.setFrom_name("??????????????????");
		    		emsMailSendParam.setContents_mapping(mail_url_mapping);
		    		emsMailSendParam.setReg_dt(fitReserveVO.getRsvDt());
		    		reserveService.saveEmsMailSend(emsMailSendParam);
		    		
		    		Map<String, Object> serialParam = new HashMap<String, Object>();
		    		int serialno = (Integer)  reserveService.srchEmsMailSendSeq(serialParam);
		    		
	    			// ------------------------------------------------------------------------------
	    			// SMS UMS ?????? ????????? 
		    		// SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
		    		// 2267160	EMS	954666	0101	P161020-0294	0000169965	???????????????????????????.				2016/10/20 19:57:59	online
		    		// ------------------------------------------------------------------------------  			
	    			UmsLogVO umsLogParam = new UmsLogVO();
	    			umsLogParam.setUms_fg_cd("EMS");
	    			umsLogParam.setUms_det_cd("0601");
	    			umsLogParam.setUmskey(String.valueOf(serialno));
	    			umsLogParam.setCust_cd(custCd);
	    			// umsLogParam.setRes_cd(param.getRes_cd());
	    			umsLogParam.setUms_desc("????????? ????????? ?????????????????????.");
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
