package com.lottejtb.front.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.poi.ss.formula.functions.Roman;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.lottejtb.api.service.FUHTI0001VO;
import com.lottejtb.api.service.FUHTI0002VO;
import com.lottejtb.api.service.FUHTI0003VO;
import com.lottejtb.api.service.FUHTI0006VO;
import com.lottejtb.comm.util.CommInfo;
import com.lottejtb.front.hotel.service.HotelLotteVO;
import com.lottejtb.front.hotel.service.HotelPaymentVO;
import com.lottejtb.front.hotel.service.ReqHotelCancelPolicy;
import com.lottejtb.front.hotel.service.ReqHotelInfoVO;
import com.lottejtb.front.hotel.service.HotelService;
import com.lottejtb.front.hotel.service.HotelVO;
import com.lottejtb.front.hotel.service.ReqHotelReserveCancelVO;
import com.lottejtb.front.hotel.service.ReqHotelRoomVO;
import com.lottejtb.front.hotel.service.ReqHotelVO;
import com.lottejtb.front.hotel.service.ReqMapRadarVO;
import com.lottejtb.front.hotel.service.RsvHtlInfoVO;
import com.lottejtb.front.hotel.service.RsvHtlTravlerVO;
import com.lottejtb.front.service.ReqMstReserveVO;
import com.lottejtb.front.service.SearchHotelCityVO;
import com.lottejtb.front.vo.PromotionVo;
import com.lottejtb.goods.service.EmsMailSendVO;
import com.lottejtb.prom.service.PromotionHtListVO;
import com.lottejtb.reserve.service.UmsLogVO;
import com.sun.star.util.Date;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
@RequestMapping(value = "/fit/htl")
public class HotelController {
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/fit/htl/";

	@Resource(name = "HotelService")
	private HotelService hotelService;

    @Resource(name = "ehcache")
    Ehcache ehcache;
	
	/**
	 * ?????? ?????? ????????? ????????? ??????
	 * @return
	 */
/*	@RequestMapping(value = "/searchMain.do")
	public String HotelSearchMain(HttpServletRequest request, Model model) {
		String selAir = request.getParameter("selAir");
		String selHotel = request.getParameter("selHotel");
		String selRentcar = request.getParameter("selRentcar");
		
		model.addAttribute("selAir", selAir);
		model.addAttribute("selHotel", selHotel);
		model.addAttribute("selRentcar", selRentcar);
		
		return _rootPath + "hotelSearchMain";
	}*/
	
	
	/**
	 * ?????? ????????? ??????/??????
	 * @return
	 */
	@RequestMapping(value = "/hotelListAjax.do")
	public String searchHotelList(@RequestBody ReqHotelVO htlVO, HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
		}

		FUHTI0001VO hotelList = new FUHTI0001VO();
				
		try {
			Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");
			//??????????????? ?????? ??????????????????
		    //reSrch = false, reSrch=true(?????????) 
			String reSrch = request.getParameter("reSrch");
			
			ObjectMapper jsonMapper = new ObjectMapper();
			Element listCache = cache.get("hotelList"+jsonMapper.writeValueAsString(htlVO) + htlVO.getFindLocNm() + htlVO.getCheckInDt() + htlVO.getCheckOutDt());
			
			if(reSrch.equals("true")) {
			    hotelList = hotelService.selectListHotel(htlVO,custCd);  //search
			} else {
						
				if( listCache == null ) {
		           System.out.println("//NO Cache");
		            hotelList = hotelService.selectListHotel(htlVO,custCd);
		            
		            if(hotelList != null && (hotelList.getData() != null && hotelList.getData().size() > 0))
		            	cache.put(new Element("hotelList"+jsonMapper.writeValueAsString(htlVO) + htlVO.getFindLocNm() + htlVO.getCheckInDt() + htlVO.getCheckOutDt(), hotelList));
		         } else {
		        	System.out.println("//IN Cache");
		        	hotelList = (FUHTI0001VO) listCache.getObjectValue();
		         }
			}
			
		} catch (Exception e) {
			logger.error("??????????????? ????????????!!!!!!!");
			//e.printStackTrace();
		}
		
		model.addAttribute("hotelList", hotelList.getData());
		return "jsonview";
	}
	
	/**
	 * ?????? ???????????? ??????
	 * @return
	 */
	@RequestMapping(value = "/viewInfo.do", method = RequestMethod.POST )
	public String viewHotelinfo(@RequestBody ReqHotelInfoVO htlVO, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		String custCd = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
		}
		
		FUHTI0003VO hotelInfo = new FUHTI0003VO();
		
		try {
			Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");
//			
			ObjectMapper jsonMapper = new ObjectMapper();
			Element listCache = cache.get("hotelInfo"+jsonMapper.writeValueAsString(htlVO));
//			
//			if( listCache == null ){
	            System.out.println("//NO Cache");
	            hotelInfo = hotelService.selectListHotelInfo(htlVO,custCd);
				cache.put(new Element("hotelInfo"+jsonMapper.writeValueAsString(htlVO), hotelInfo));
//	        }else{
//	        	System.out.println("//IN Cache");
//	        	hotelRoomList = (FUHTI0003VO) listCache.getObjectValue();
//	        }
			
		} catch (Exception e) {
			logger.error("??????????????? ????????????!!!!!!!");
			//e.printStackTrace();
		}
		
		model.addAttribute("hotelInfo", hotelInfo.getData());
				
		return "jsonview";
	}
	
	/**
	 * ?????? ???????????? ??????
	 * @return
	 */
	@RequestMapping(value = "/roomListAjax.do")
	public String searchRoomList(@RequestBody ReqHotelRoomVO htlVO, HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		String custCd = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
		}
		
		FUHTI0002VO roomAvail = new FUHTI0002VO();
		
		
		try {
			Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");
//			
			ObjectMapper jsonMapper = new ObjectMapper();
			Element listCache = cache.get("roomAvail"+jsonMapper.writeValueAsString(htlVO));
//			
//			if( listCache == null ){
	            System.out.println("//NO Cache");
	            roomAvail = hotelService.selectListHotelRoom(htlVO,custCd);
				cache.put(new Element("roomAvail"+jsonMapper.writeValueAsString(htlVO), roomAvail));
//	        }else{
//	        	System.out.println("//IN Cache");
//	        	hotelRoomList = (FUHTI0002VO) listCache.getObjectValue();
//	        }
			
		} catch (Exception e) {
			logger.error("??????????????? ????????????!!!!!!!");
			//e.printStackTrace();
		}
		
		model.addAttribute("roomAvail", roomAvail.getData());
		model.addAttribute("message", roomAvail.getMessage());
				
		return "jsonview";
	}
	
	/*
	 *  ????????? : ????????????,GTA ??? ???????????? ????????? ?????? ?????? api
	 */
	@RequestMapping(value= "/cancelPolicy.do", method = RequestMethod.POST)
	public String cancelPolicy(@RequestBody ReqHotelCancelPolicy htlCp, HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		String custCd = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
		}
		
		FUHTI0006VO hotelCancelPolicy = new FUHTI0006VO();
		
		try {
			Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");
//			
			ObjectMapper jsonMapper = new ObjectMapper();
			Element listCache = cache.get("hotelCancelPolicy"+jsonMapper.writeValueAsString(htlCp));
//			
//			if( listCache == null ){
	            System.out.println("//NO Cache");
	            hotelCancelPolicy = hotelService.getCancelPolicy(htlCp, custCd);
				cache.put(new Element("hotelCancelPolicy"+jsonMapper.writeValueAsString(htlCp), hotelCancelPolicy));
//	        }else{
//	        	System.out.println("//IN Cache");
//	        	hotelRoomList = (FUHTI0003VO) listCache.getObjectValue();
//	        }
			
		} catch (Exception e) {
			logger.error("??????????????? ????????????!!!!!!!");
			//e.printStackTrace();
		}
		
		model.addAttribute("hotelCancelPolicy", 	hotelCancelPolicy.getData());
			
		return "jsonview";
		
	}
	
	
	
	/**
	 * ?????? ?????? ?????? ??????
	 * @return
	 */
	@RequestMapping(value = "/viewCcCerti.do", method = RequestMethod.POST )
	public String viewHotelCancelCerti(@ModelAttribute HotelVO htlVO, HttpServletRequest request, Model model) {

		ArrayList<HotelVO> ccCerti = new ArrayList<HotelVO>();
		
		try {
			ccCerti = hotelService.selectCancelCerti(htlVO);
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Select Hotel Cancel Certi Error!");
		}
		
		model.addAttribute("ccCerti", ccCerti);
				
		return "jsonview";
	}
	
	/**
	 * ??????/???????????? ??????
	 * @return
	 */
	@RequestMapping(value = "/hotelCityL.do")
	public String searchCityList(@RequestBody SearchHotelCityVO htlVO, HttpServletRequest request, Model model) {
		String sVal = htlVO.getSearchVal();
		String sDome = htlVO.getDomesticYn();
		
		List<?> cityList = new ArrayList<HotelVO>();
		
		try {
			cityList = hotelService.selectListCity(sVal, sDome);
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Select City List Error!");
		}
		
		model.addAttribute("cityList", cityList);
				
		return "jsonview";
	}

	
	 
    /**
     * ?????? ?????? ??????
     */
    @RequestMapping(value = "/domeCityCd.do")
    public String selectListDomeCityCd(HttpServletRequest request, Model model) {
        List<SearchHotelCityVO> cityList;

        try {
            cityList = hotelService.selectListDomeCityCd();

            model.addAttribute("cityList", cityList);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "jsonview";
    }
    
    
    /**
     * ?????? ?????? ?????? - ??????
     */
    @RequestMapping(value = "/domeCityCdDetail.do")
    public String selectListDomeCityCdDetail(HttpServletRequest request, Model model) {
        List<SearchHotelCityVO> cityList;

        try {
        	
            cityList = hotelService.selectListDomeCityCdDetail();

            model.addAttribute("cityList", cityList);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "jsonview";
    }
	
	
	/**
	 * ???????????? ?????? (?????? API ??????)
	 * @return
	 */
	@RequestMapping(value = "/radarsearchAjax.do")
	public String radarsearch(@RequestBody ReqMapRadarVO htlVO, HttpServletRequest request, Model model) {
		//https://maps.googleapis.com/maps/api/place/radarsearch/json?location=51.503186,-0.126446&radius=5000&types=museum&key=AIzaSyD7Ofh1fQwL-osDzzlbdvRjvlG2Y8-nEyU
		
		JSONObject radarList = new JSONObject();
		
		try {
			radarList = hotelService.getRadarJsonData(htlVO);
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Get Radar Json Date Error!");
		}
		
		model.addAttribute("radarList", radarList);
				
		return "jsonview";
	}
	
	/**
	 * ???????????? ?????? (?????? API ??????)
	 * @return
	 */
	@RequestMapping(value = "/radarDetailsearchAjax.do")
	public String radarDetailsearch(@RequestBody ReqMapRadarVO htlVO, HttpServletRequest request, Model model) {
		//https://maps.googleapis.com/maps/api/place/radarsearch/json?location=51.503186,-0.126446&radius=5000&types=museum&key=AIzaSyD7Ofh1fQwL-osDzzlbdvRjvlG2Y8-nEyU
		
		JSONObject radarData = new JSONObject();
		
		try {
			radarData = hotelService.getRadarDetailData(htlVO);
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("get Radar Detail Data Error!");
		}
		
		model.addAttribute("radarData", radarData);
				
		return "jsonview";
	}
	
	/**
	 * ?????? ?????? ????????? (?????? API ??????)
	 * @return
	 */
	@RequestMapping(value = "/getCityLatlngAjax.do")
	public String getCityLatlngAjax(@RequestBody ReqMapRadarVO htlVO, HttpServletRequest request, Model model) {
		
		JSONObject cityLatlng = new JSONObject();
		
		try {
			cityLatlng = hotelService.getCityLarlon(htlVO);
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("get City Larlon Error!");
		}
		
		model.addAttribute("cityLatlng", cityLatlng);
				
		return "jsonview";
	}

    /**
     * ?????? ?????? ??????
     *
     * @param fitRsvNo ???????????? ????????????
     * @param rsvType ????????????(0: ??????, 1: ?????????)
     * @param model ?????? ????????????
     * @return ?????? ?????? ??????
     */
    @RequestMapping(value = "/rsvListPop.do", method={RequestMethod.GET, RequestMethod.POST})
    public String rsvListPop(@RequestParam("fitRsvNo") String fitRsvNo, @RequestParam(value="rsvType", defaultValue="0") String rsvType, Model model) throws Exception {
        EgovMap egovMap = new EgovMap();
        egovMap.put("fitRsvNo", fitRsvNo);
        egovMap.put("rsvType", rsvType);
                
        List<EgovMap> rsvList = hotelService.selectRsvList(egovMap);
        model.addAttribute("rsvList", rsvList);
        
        System.out.println(rsvList);
        
        return "/fit/pop/rsvListPop";
    }
    
    /* 
     * ???????????? ?????? ?????? ??????*
     */
    @RequestMapping(value = "/rsvHtlinfoList.do", method={RequestMethod.GET, RequestMethod.POST})
    public String rsvHtlinfoList(@RequestParam("fitRsvNo") String fitRsvNo, HttpServletRequest request, Model model) throws Exception {
        
       RsvHtlInfoVO rsvinfo = new RsvHtlInfoVO();
       rsvinfo.setFitRsvNo(fitRsvNo);
       
       List<RsvHtlInfoVO> list = hotelService.selectRsvHtlInfo(rsvinfo);
       
       model.addAttribute("rsvInfo", list); 
      
       return "jsonview";
    }
    
    
    /* 
     * ???????????? ?????? ?????? ???????????????*
     */
    @RequestMapping(value = "/rsvHtlTravlerList.do", method={RequestMethod.GET, RequestMethod.POST})
    public String rsvHtlTravlerList(@RequestParam("fitRsvNo") String fitRsvNo, @RequestParam("rsvSeqNo") String rsvSeqNo, HttpServletRequest request, Model model) throws Exception {
        
       RsvHtlTravlerVO rsvTrlInfo = new RsvHtlTravlerVO();
       rsvTrlInfo.setRsvSeqNo(rsvSeqNo);
       
       //????????? ??????
       List<RsvHtlTravlerVO> list = hotelService.selectRsvHtlTravler(rsvTrlInfo);
       System.out.println("list.size=" + list.size());       

       //?????? ???????????? ??????
       List<HotelPaymentVO> htlPayment = hotelService.selectHtlPaymentInfo(fitRsvNo);
       
       model.addAttribute("rsvTrlInfo", list);
       model.addAttribute("htlPayment" , htlPayment);
       
       return "jsonview";
    }
    
    /* ???????????? ?????? ?????? ????????? ?????? ?????? ?????? */
    @RequestMapping(value = "/rsvHtlCancelInfo.do", method={RequestMethod.GET, RequestMethod.POST})
    public String rsvHtlCancelInfo(@RequestParam("fitRsvNo") String fitRsvNo, HttpServletRequest request, Model model) throws Exception {
        
       ReqHotelReserveCancelVO cancelInfo = new ReqHotelReserveCancelVO();
       cancelInfo.setFitRsvNo(fitRsvNo);
       
       List<ReqHotelReserveCancelVO> list = hotelService.selectRsvHtlCancelInfo(cancelInfo);
       
       model.addAttribute("rsvHtlCancel", list); 
       
       return "jsonview";
    }
    
    
    /* 
     * ?????? ???????????? ??????
     */
    @RequestMapping(value = "/rsvHtlCancel.do", method={RequestMethod.GET, RequestMethod.POST})
    public String rsvHtlCancel(@RequestBody ReqHotelReserveCancelVO reqVO, HttpServletRequest request, Model model) throws Exception {
    	
    	JSONObject list = new JSONObject();
    	
    	HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		String custCd = "";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
		}
       
		list = hotelService.reqHotelReserveCancel(reqVO,reqVO.getFitRsvNo(),custCd);
		
		if(list.get("code").equals("1")) {
			model.addAttribute("htlresult", 1);
		} else {
			model.addAttribute("htlresult", 0);
		}
       
		System.out.println("list.size=" + list.size());       
       
		return "jsonview";
    }
    
	/*???????????? ???????????????*/
	@RequestMapping(value = "/lottehotel.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String lottehotelList(HttpServletRequest request, ModelMap model)throws Exception {
		return _rootPath + "lottehotel";
	}
	
	/*???????????? ???????????????*/
	@RequestMapping(value = "/lottehotelAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String lottehotelAjax(HttpServletRequest request, ModelMap model)throws Exception {
		
		HotelLotteVO vo = new HotelLotteVO();
		List lotteHtlList = (List) hotelService.selectLotteHtlList(vo);
		
		model.addAttribute("htllist", lotteHtlList); 
	
		return "jsonview";
	}
	
	/*
	 * ?????? ??????,??????????????????
	 * 
	 */
	@RequestMapping(value = "/htl_email.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String htlEmail(HttpServletRequest request, ModelMap model)throws Exception {

		model.addAttribute("hotelCd", request.getParameter("hotelCd"));
		System.out.println("hotelCd=" + request.getParameter("hotelCd"));
		return _rootPath + "htl_Email"; 
	}		

	@RequestMapping(value = "/htl_emailSendAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String htl_emailSendAjax(HttpServletRequest request, ModelMap model)throws Exception {

		String fromName = request.getParameter("fromName"); //???????????????
		String fromEmail = request.getParameter("fromEmail");//????????????????????????
		String toName = request.getParameter("toName");
		String toEmail = request.getParameter("toEmail");
		String subject = request.getParameter("subject"); //??????
		String htlId = request.getParameter("htlId");  //??????id
		
		SimpleDateFormat formatter = new SimpleDateFormat("YYYY-MM-DD hh:mm:ss");
		String date = formatter.format(new java.util.Date());
		int result = 0;
				
		try {
    		
    		EmsMailSendVO emsMailSendParam = new EmsMailSendVO();
    		
    		emsMailSendParam.setMail_code("701");
    		emsMailSendParam.setMail_nm("?????? ?????? ???????????????");
    		emsMailSendParam.setTo_name(toName);
    		emsMailSendParam.setTo_email(toEmail);
    		
    		String mail_url_mapping = "fitRsvNo=" + htlId + "&testStr=HR";
    		emsMailSendParam.setMail_url_mapping(mail_url_mapping);
    		emsMailSendParam.setSubject(subject);
    		emsMailSendParam.setFrom_email(fromEmail);
    		emsMailSendParam.setFrom_name(fromName);
    		emsMailSendParam.setContents_mapping(mail_url_mapping);
    		emsMailSendParam.setReg_dt(date);
    		
    		//hotelService.saveEmsMailSend(emsMailSendParam);
    		
			System.out.println(">>>>>>>>>>>>>>>>> HOTEL EMS MAIL SEND E !!!!!! ");
			result = 1;
    		
    	} catch (Exception e) {
			//e.printStackTrace();
			result = 0;
			System.out.println("HOTEL EMS MAIL SEND E !!!!!! " + e.getMessage());
    	}
		
		model.addAttribute("code", result);
		return "jsonview"; 
	}	
	
	//EAN??? ???????????? hotelid
	@RequestMapping(value = "/htl_mappingAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String htl_mappingAjax(HttpServletRequest request, ModelMap model)throws Exception {
		
		EgovMap param = new EgovMap();
		param.put("hotelId", request.getParameter("hotelId"));
		param.put("suplrCd", request.getParameter("suplrCd"));
		
		String suplirdId = (String) hotelService.hotelIdMapping(param);
		
		model.addAttribute("htlId", suplirdId);
		return "jsonview";
	}
	
	
	/*
	 * ???????????? 
	 */
	@RequestMapping(value= "/promotion.do", method={RequestMethod.GET, RequestMethod.POST})
	public String promotion(@RequestBody PromotionHtListVO promVO, HttpServletRequest request, ModelMap model) throws Exception {

		List<PromotionHtListVO> promotion = (List<PromotionHtListVO>) hotelService.getPromotion(promVO);
		model.addAttribute("promotion", promotion);
		
		return "jsonview";
	
	}
    
}
