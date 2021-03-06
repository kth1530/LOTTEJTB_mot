package com.lottejtb.goods.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.ehcache.Ehcache;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.extrus.asn1.ocsp.Request;
import com.lottejtb.comm.util.CommInfo;
import com.lottejtb.goods.rn.service.ETMstOtherAirLineVO;
import com.lottejtb.goods.rn.service.RNETMstVO;
import com.lottejtb.goods.rn.service.RNGDImgVO;
import com.lottejtb.goods.rn.service.RNGDMstVO;
import com.lottejtb.goods.rn.service.RNGDSchdVO;
import com.lottejtb.goods.rn.service.RNGDTagsVO;
import com.lottejtb.goods.rn.service.RNGoodsService;
import com.lottejtb.goods.rn.service.RNTimeDifferCurrencyVO;
import com.lottejtb.goods.rn.service.RNWeatherVO;
import com.lottejtb.goods.service.AreaInfoVO;
import com.lottejtb.goods.service.CartService;
import com.lottejtb.goods.service.ConsultVO;
import com.lottejtb.goods.service.DIWishListVO;
import com.lottejtb.goods.service.EmsMailSendVO;
import com.lottejtb.goods.service.EventCommSchdVO;
import com.lottejtb.goods.service.EventGroupAllSchdDTO;
import com.lottejtb.goods.service.EventGroupAllSchdVO;
import com.lottejtb.goods.service.EventListDTO;
import com.lottejtb.goods.service.EventMstListVO;
import com.lottejtb.goods.service.EventMstVO;
import com.lottejtb.goods.service.GoodsCtgVO;
import com.lottejtb.goods.service.GoodsEvalPointVO;
import com.lottejtb.goods.service.GoodsEvalVO;
import com.lottejtb.goods.service.GoodsImgVO;
import com.lottejtb.goods.service.GoodsMstVO;
import com.lottejtb.goods.service.GoodsVO;
import com.lottejtb.goods.service.HotelInfoVO;
import com.lottejtb.goods.service.SiteGoodsMngService;
import com.lottejtb.main.service.MenuVO;
import com.lottejtb.reserve.service.ComCodeVO;
import com.lottejtb.reserve.service.ReserveService;
import com.lottejtb.util.Util;

import egovframework.rte.fdl.property.EgovPropertyService;

import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.io.BufferedReader;
import java.io.IOException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.Element;
import org.xml.sax.InputSource;

@Controller
public class GoodsController {
	
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
    @Resource(name = "ehcache")
    Ehcache ehcache;
	
	@Resource(name = "GoodsService")
	private SiteGoodsMngService goodsService;
	
	@Resource(name = "RNGoodsService")
	private RNGoodsService rnGoodsService;
	
	@Resource(name = "CartService")
	private CartService cartService;
	
	// ?????? ?????? ?????? ????????? 
	@Resource(name = "ReserveService")
	private ReserveService reserveService;
	
	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/";
	private final int PAGESIZE = 10;
	
	// <!-- ?????? ????????? ?????? ???????????? -->

	// <!-- ?????? ?????? ?????? ???????????? -->
	List<AreaInfoVO> rnGroupAreaDTO = null;
	List<HotelInfoVO> rnGroupHotelAllDTO = null;
	
	// <!-- ?????? ????????? -->
	@RequestMapping(value = "/goods/list.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String list(@RequestParam("ctg") String ctg,  @RequestParam("orderby") String orderby, HttpServletRequest request, ModelMap model)throws Exception {
	
		int startRow = 1;
		int endRow = PAGESIZE;
		String returnUrl = "goods/list";

		if("6548".equals(ctg)){
			returnUrl = "goods/list_golf";
		}
		
		if(orderby == "" || orderby.equals("")) orderby = "01";
		model.addAttribute("pageSize", PAGESIZE);	
		model.addAttribute("ctg", ctg);
		model.addAttribute("orderby", orderby);
		
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = null;
		String knm = null;
		String age = null;
		String sex = null;
		String id = null;
		String email = null;
		String custGradeCd = null;
		String birthday = null;
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
			if(sessionParam.get("knm") != null)
				knm = sessionParam.get("knm").toString();
			if(sessionParam.get("email") != null)
				email = sessionParam.get("email").toString();
		}
		
		/** ????????? ?????? ?????? **/
		String grade = "";
		if(custCd != null && !custCd.equals("")) {
			grade = (String) rnGoodsService.selectCustGrade(custCd);	
		}
		
		/** ???????????? ?????? ?????? **/
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("sex", sex);
		model.addAttribute("id", id);
		model.addAttribute("email", email);		
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("birthday", birthday);	
		model.addAttribute("grade", grade);
		
		
		return _rootPath+returnUrl;
	}
	
	// <!-- ?????? ????????? -->
	@RequestMapping(value = "/goods/master.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String master(@RequestParam("ctg") String ctg, @RequestParam("goodsCd") String goodsCd, HttpServletRequest request, ModelMap model)throws Exception{
		int startRow = 1;
		int endRow = PAGESIZE;
		GoodsMstVO result = new GoodsMstVO();
		HashMap<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("goodsCd", goodsCd);
		parameter.put("ctg", ctg);
		
		result = goodsService.getCtgCode(parameter);
		
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = null;
		String knm = null;
		String age = null;
		String sex = null;
		String id = null;
		String email = null;
		String custGradeCd = null;
		String birthday = null;
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
			if(sessionParam.get("knm") != null)
				knm = sessionParam.get("knm").toString();
			if(sessionParam.get("email") != null)
				email = sessionParam.get("email").toString();
		}
		
		/** ????????? ?????? ?????? **/
		String grade = "";
		if(custCd != null && !custCd.equals("")) {
			grade = (String) rnGoodsService.selectCustGrade(custCd);	
		}
		
		/** ???????????? ?????? ?????? **/
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("sex", sex);
		model.addAttribute("id", id);
		model.addAttribute("email", email);		
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("birthday", birthday);	
		model.addAttribute("grade", grade);
		
		model.addAttribute("ctg", result.getCtg_seq());
		model.addAttribute("goodsCd", goodsCd);
		model.addAttribute("pageSize", PAGESIZE);
		
		if(!"".equals(request.getParameter("price"))){
			model.addAttribute("price", request.getParameter("price"));	
		}
		
		return _rootPath+"goods/master";
	}
	
	
	// <!-- ?????? ???????????? ????????? ??????  -->
	@RequestMapping(value = "/goods/category.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String category(@RequestParam("ctg") String ctg, ModelMap model)throws Exception{
		
		model.addAttribute("ctg", ctg);
		
		return _rootPath+"goods/category";
	}
	
	// <!-- ?????? ???????????? ????????? ??????  -->
	@RequestMapping(value = "/goods/theme.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String theme(@RequestParam("ctg") String ctg, ModelMap model)throws Exception{
		
		model.addAttribute("ctg", ctg);
		
		return _rootPath+"goods/theme";
	}
	
	// <!-- ?????? ???????????? ????????? ?????? -->
	@RequestMapping(value = "/goods/categoryListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String categoryListAjax(@ModelAttribute("MenuVO") MenuVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		HashMap<String, Object> parameter = new HashMap<String, Object>();
		String ctgCodes = vo.getCtgCode();
		String[] ctgCode = ctgCodes.split(",");
		
		for(int i = 0; i < ctgCode.length ; i++){
			parameter.put("ctgCode", ctgCode[i]);
			
			model.addAttribute(ctgCode[i], goodsService.srchCategoryList(parameter));
		}
		
	    return "jsonView";
	}
	
	
	// <!-- ?????? ?????? -->
	@RequestMapping(value = "/goods/11st_detail.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String detail_11st(@RequestParam("ctg") String ctg, @RequestParam("eventCd") String eventCd, HttpServletRequest request, ModelMap model)throws Exception{
		
		
		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		
		if(logger.isInfoEnabled()) {
			logger.info("ctg : " + ctg);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
		}
		
		
		System.out.println("ctg : " + ctg);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		

		/** ?????? ?????? ?????? ?????? ????????? ?????? **/
		RNGDSchdVO rnGDCommSchdParam = new RNGDSchdVO();
		rnGDCommSchdParam.setEvent_cd(eventCd);
		List rnGDCommSchdList = (List) rnGoodsService.srchGDCommSchdList(rnGDCommSchdParam);
		
		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);		
		model.addAttribute("eventCd", eventCd);
		

		model.addAttribute("rnGDCommSchdList", rnGDCommSchdList);
		

	
		return _rootPath+"goods/11st_detail";
	}
	
	// <!-- ?????? ?????? -->
	@RequestMapping(value = "/goods/11st_detail2.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String detail_11st2(@RequestParam("ctg") String ctg, @RequestParam("eventCd") String eventCd, HttpServletRequest request, ModelMap model)throws Exception{
		
		
		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		
		if(logger.isInfoEnabled()) {
			logger.info("ctg : " + ctg);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
		}
		
		
		System.out.println("ctg : " + ctg);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		

		/** ?????? ?????? ?????? ?????? ????????? ?????? **/
		RNGDSchdVO rnGDCommSchdParam = new RNGDSchdVO();
		rnGDCommSchdParam.setEvent_cd(eventCd);
		List rnGDCommSchdList = (List) rnGoodsService.srchGDCommSchdList(rnGDCommSchdParam);
		
		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);		
		model.addAttribute("eventCd", eventCd);
		

		model.addAttribute("rnGDCommSchdList", rnGDCommSchdList);
		

	
		return _rootPath+"goods/11st_detail2";
	}
	
	
	// <!-- ?????? ?????? -->
	@RequestMapping(value = "/goods/11st_detail3.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String detail_11st3(@RequestParam("ctg") String ctg, @RequestParam("eventCd") String eventCd, HttpServletRequest request, ModelMap model)throws Exception{
		
		
		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		
		if(logger.isInfoEnabled()) {
			logger.info("ctg : " + ctg);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
		}
		
		
		System.out.println("ctg : " + ctg);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		

		/** ?????? ?????? ?????? ?????? ????????? ?????? **/
		RNGDSchdVO rnGDCommSchdParam = new RNGDSchdVO();
		rnGDCommSchdParam.setEvent_cd(eventCd);
		List rnGDCommSchdList = (List) rnGoodsService.srchGDCommSchdList(rnGDCommSchdParam);
		
		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);		
		model.addAttribute("eventCd", eventCd);
		

		model.addAttribute("rnGDCommSchdList", rnGDCommSchdList);
		

	
		return _rootPath+"goods/11st_detail3";
	}
	
	// <!-- ?????? ?????? -->
	@RequestMapping(value = "/goods/11st_detail4.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String detail_11st4(@RequestParam("ctg") String ctg, @RequestParam("eventCd") String eventCd, HttpServletRequest request, ModelMap model)throws Exception{
		
		
		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		
		if(logger.isInfoEnabled()) {
			logger.info("ctg : " + ctg);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
		}
		
		
		System.out.println("ctg : " + ctg);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		

		/** ?????? ?????? ?????? ?????? ????????? ?????? **/
		RNGDSchdVO rnGDCommSchdParam = new RNGDSchdVO();
		rnGDCommSchdParam.setEvent_cd(eventCd);
		List rnGDCommSchdList = (List) rnGoodsService.srchGDCommSchdList(rnGDCommSchdParam);
		
		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);		
		model.addAttribute("eventCd", eventCd);
		

		model.addAttribute("rnGDCommSchdList", rnGDCommSchdList);	
		
		return _rootPath+"goods/11st_detail4";
	}	
	
	
	// <!-- ?????? ?????? ??????  -->
	@RequestMapping(value = "/goods/11st_policy.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String pop_policy(@RequestParam("ctg") String ctg, @RequestParam("eventCd") String eventCd, ModelMap model)throws Exception {
	
		
		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		
		if(logger.isInfoEnabled()) {
			logger.info("ctg : " + ctg);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
		}
		
		int startRow = 1;
		int endRow = PAGESIZE;
		
		System.out.println("ctg : " + ctg);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		
		/** ?????? ?????? ?????? ?????? **/
		RNGDTagsVO rnGDTagsParam = new RNGDTagsVO();
		rnGDTagsParam.setEvent_cd(eventCd);
		
		RNGDTagsVO rnGDTagsResult = new RNGDTagsVO();
		rnGDTagsResult = (RNGDTagsVO) rnGoodsService.srchGDTags(rnGDTagsParam);
		
		/** ?????? ?????? ????????? ?????? **/
		RNETMstVO rnEtMstParam = new RNETMstVO();
		rnEtMstParam.setEvent_cd(eventCd);
		rnEtMstParam.setComp_cd(rnGDTagsResult.getComp_cd());
		rnEtMstParam.setGoods_cd(goodsCd);
		
		RNETMstVO rnEtMstResult = new RNETMstVO();
		rnEtMstResult = (RNETMstVO) rnGoodsService.srchETMst(rnEtMstParam);
		

		

		
		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);		
		model.addAttribute("eventCd", eventCd);
		
		model.addAttribute("rnEtMst", rnEtMstResult);
		
		return _rootPath+"goods/11st_policy";
	}
	
	
	// <!-- ????????? ???????????? ???????????? ??????  -->
	@RequestMapping(value = "/goods/pop_mail.do" ,method=RequestMethod.GET)
	public String pop_mail(HttpServletRequest request, ModelMap model)throws Exception{
		try {
			String ctg = (String) request.getParameter("ctg");
			String eventCd = (String) request.getParameter("eventCd");
			String dispNm = (String) request.getParameter("dispNm");
			
			String goodsCd = "";
			if(eventCd != null && !eventCd.equals("")) 
				goodsCd = eventCd.substring(0, 7);
			
			
			if(logger.isInfoEnabled()) {
				logger.info("ctg : " + ctg);
				logger.info("goodsCd : " + goodsCd);
				logger.info("eventCd : " + eventCd);
			}
						
			
			HttpSession session = request.getSession(true);
			HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
			
			String custCd = null;
			String knm = null;
			String age = null;
			String sex = null;
			String id = null;
			String email = null;
			String custGradeCd = null;
			String birthday = null;
			
			if(sessionParam != null){
				
				if(sessionParam.get("cust_cd") != null)
					custCd = sessionParam.get("cust_cd").toString();
				if(sessionParam.get("knm") != null)
					knm = sessionParam.get("knm").toString();
				if(sessionParam.get("email") != null)
					email = sessionParam.get("email").toString();
			}
			

			
			model.addAttribute("ctg", ctg);
			model.addAttribute("goodsCd", goodsCd);
			model.addAttribute("eventCd", eventCd);
			model.addAttribute("dispNm", dispNm);
			
			/** ???????????? ?????? ?????? **/
			model.addAttribute("cust_cd", custCd);
			model.addAttribute("knm", knm);
			model.addAttribute("sex", sex);
			model.addAttribute("id", id);
			model.addAttribute("email", email);		
			model.addAttribute("custGradeCd", custGradeCd);
			model.addAttribute("birthday", birthday);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return _rootPath+"goods/pop_mail";
	}
	
	// <!-- ?????? ?????? ????????????   -->
	@RequestMapping(value = "/goods/saveConsultMailAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String saveConsultMailAjax(@ModelAttribute("EmsMailSendVO") EmsMailSendVO param, HttpServletRequest request, ModelMap model)throws Exception{
		
		// DEFAULT VALUE 
		/**
		param.setTitle_yn("Y");
		param.setDesc_yn("Y");
		param.setEmail_yn("Y");
		param.setSms_yn("Y");
		
		param.setChannel_cd("AA");
		param.setConsult_title("????????? ???????????? ??????");
		param.setPhone_fg("1");
		param.setInc_fg("C");
		param.setConsult_mst_cd("01");
		param.setIns_dept_cd("541000");
		param.setIns_id("MOBILEUSER");
		
		goodsService.saveConsult(param);
		**/
		String ctg = (String) request.getParameter("ctg");
		param.setCtg(ctg);
		
		System.out.println("ctg : " + param.getCtg());
		System.out.println("goods_cd : " + param.getGoods_cd());
		System.out.println("event_cd : " + param.getEvent_cd());
		
		param.setMail_code("007");
		param.setMail_nm("?????? ?????????");
		String mail_url_mapping = "";
		
		//?????? URL ?????? ??????
		if("007".equals(param.getMail_code())){
			// ctg=5836&eventCd=ASP22871611232&Flag=BO&siteNm=0&siteTel=0&siteUser=0&mall_cd=1
			mail_url_mapping = "ctg="+param.getCtg()+"&eventCd="+param.getEvent_cd()+"&Flag=BO&siteNm=0&siteTel=0&siteUser=0";
			
		} else if("030".equals(param.getMail_code())){
			mail_url_mapping = "ctg="+param.getCtg()+"&eventCd="+param.getEvent_cd()+"&Flag=B0&siteNm=0&siteTel=0&siteUser=0";
			
		}
		
		param.setMail_url_mapping(mail_url_mapping);
		goodsService.saveEmsMailSend(param);
		
		return "jsonView";
	}
	
	// <!-- ?????? ?????? ????????????   -->
	@RequestMapping(value = "/goods/saveConsultMailAjax2.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String saveConsultMailAjax2(HttpServletRequest request, ModelMap model)throws Exception{
		
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
			
			param.setMail_code("701");
			param.setMail_nm("????????????");
			param.setSubject(subject);
			String mail_url_mapping = "";
			
			//?????? URL ?????? ??????
			mail_url_mapping = "fitRsvNo="+rsvSeqno;
			
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email1);
			param.setTo_name(to_name1);
			param.setContents_mapping(mail_url_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 1) {
			to_name2 = (String) request.getParameter("to_name2");
			to_email2 = (String) request.getParameter("to_email2");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("701");
			param.setMail_nm("????????????");
			param.setSubject(subject);
			String mail_url_mapping = "";
			
			//?????? URL ?????? ??????
			
			mail_url_mapping = "fitRsvNo="+rsvSeqno;
				
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email2);
			param.setTo_name(to_name2);
			param.setContents_mapping(mail_url_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 2) {
			to_name3 = (String) request.getParameter("to_name3");
			to_email3 = (String) request.getParameter("to_email3");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("701");
			param.setMail_nm("????????????");
			param.setSubject(subject);
			String mail_url_mapping = "";
			
			//?????? URL ?????? ??????
			mail_url_mapping = "fitRsvNo="+rsvSeqno;
			
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email3);
			param.setTo_name(to_name3);
			param.setContents_mapping(mail_url_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 3) {
			to_name4 = (String) request.getParameter("to_name4");
			to_email4 = (String) request.getParameter("to_email4");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("701");
			param.setMail_nm("????????????");
			param.setSubject(subject);
			String mail_url_mapping = "";
			
			//?????? URL ?????? ??????
			mail_url_mapping = "fitRsvNo="+rsvSeqno;
			
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email4);
			param.setTo_name(to_name4);
			param.setContents_mapping(mail_url_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 4) {
			to_name5 = (String) request.getParameter("to_name5");
			to_email5 = (String) request.getParameter("to_email5");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("701");
			param.setMail_nm("????????????");
			param.setSubject(subject);
			String mail_url_mapping = "";
			
			//?????? URL ?????? ??????
			mail_url_mapping = "fitRsvNo="+rsvSeqno;
			
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email5);
			param.setTo_name(to_name5);
			param.setContents_mapping(mail_url_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 5) {
			to_name6 = (String) request.getParameter("to_name6");
			to_email6 = (String) request.getParameter("to_email6");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("701");
			param.setMail_nm("????????????");
			param.setSubject(subject);
			String mail_url_mapping = "";
			
			//?????? URL ?????? ??????
			mail_url_mapping = "fitRsvNo="+rsvSeqno;
			
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email6);
			param.setTo_name(to_name6);
			param.setContents_mapping(mail_url_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 6) {
			to_name7 = (String) request.getParameter("to_name7");
			to_email7 = (String) request.getParameter("to_email7");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("701");
			param.setMail_nm("????????????");
			param.setSubject(subject);
			String mail_url_mapping = "";
			
			//?????? URL ?????? ??????
			mail_url_mapping = "fitRsvNo="+rsvSeqno;
			
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email7);
			param.setTo_name(to_name7);
			param.setContents_mapping(mail_url_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 7) {
			to_name8 = (String) request.getParameter("to_name8");
			to_email8 = (String) request.getParameter("to_email8");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("701");
			param.setMail_nm("????????????");
			param.setSubject(subject);
			String mail_url_mapping = "";
			
			//?????? URL ?????? ??????
			mail_url_mapping = "fitRsvNo="+rsvSeqno;
			
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email8);
			param.setTo_name(to_name8);
			param.setContents_mapping(mail_url_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 8) {
			to_name9 = (String) request.getParameter("to_name9");
			to_email9 = (String) request.getParameter("to_email9");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("701");
			param.setMail_nm("????????????");
			param.setSubject(subject);
			String mail_url_mapping = "";
			
			//?????? URL ?????? ??????
			mail_url_mapping = "fitRsvNo="+rsvSeqno;
			
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email9);
			param.setTo_name(to_name9);
			param.setContents_mapping(mail_url_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}

		if(nReceiver_cnt > 9) {
			to_name10 = (String) request.getParameter("to_name10");
			to_email10 = (String) request.getParameter("to_email10");
			
			EmsMailSendVO param = new EmsMailSendVO();
			
			param.setMail_code("701");
			param.setMail_nm("????????????");
			param.setSubject(subject);
			String mail_url_mapping = "";
			
			//?????? URL ?????? ??????
			mail_url_mapping = "fitRsvNo="+rsvSeqno;
			
			param.setFrom_email(from_email);
			param.setFrom_name(from_name);
			param.setTo_email(to_email10);
			param.setTo_name(to_name10);
			param.setContents_mapping(mail_url_mapping);
			param.setMail_url_mapping(mail_url_mapping);
			goodsService.saveEmsMailSend(param);
			
		}
		

		
		return "jsonView";
	}
	
	// <!-- ?????? ?????? ????????????   -->
	@RequestMapping(value = "/goods/saveConsultTelAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String saveConsultTelAjax(@ModelAttribute("ConsultVO") ConsultVO param, ModelMap model)throws Exception{
		param.setInc_fg("C");
/*		// ?????? ????????? ?????? 
		String consult_cd = goodsService.srchConsultSeq(param);
		param.setConsult_cd(consult_cd);		*/
		
		// DEFAULT VALUE 
		param.setEmail("N");
		param.setPhone_fg("1");
		
		param.setChannel_cd("AA");
		param.setTitle_yn("Y");
		param.setConsult_title("???????????? ??????");
		
		param.setDesc_yn("Y");
		param.setEmail_yn("N");
		param.setSms_yn("N");
		param.setConsult_mst_cd("03"); // callbacksystem

		param.setConsult_mst_cd("01");
		param.setIns_dept_cd("541000");
		param.setIns_id("MOBILEUSER");
		
		
		// ?????? ?????? ?????? 
		//int saveCnt  = goodsService.saveConsult(param);				
		//model.put("saveCnt", saveCnt);
		
		goodsService.saveConsult(param);
		
		return "jsonView";
	}
	
	// <!-- ?????? ?????? ????????????   -->
	@RequestMapping(value = "/goods/saveGoodsReviewAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String saveGoodsReviewAjax(@ModelAttribute("GoodsEvalVO") GoodsEvalVO param, ModelMap model)throws Exception{
		
		// DEFAULT VALUE 
		param.setDel_yn("N");
		param.setDisp_yn("Y");
		param.setArea_cd(param.getGoods_cd().substring(0, 2));
		
		HashMap selectMaxParam = new HashMap<String, Object>();
		
		// ????????? ?????? ?????? 
		int selectMaxEvalNum = goodsService.selectMaxEvalNum(selectMaxParam);

		if(selectMaxEvalNum < 0) return "";
		
		//????????? ?????? 
		goodsService.saveGoodsEval(param);				
		
		// ????????? ?????? 
		GoodsEvalPointVO pointParam = new GoodsEvalPointVO();
		pointParam.setGoods_eval_seq(selectMaxEvalNum);
		pointParam.setEval_item_cd("01");
		pointParam.setEval_point(param.getEval_avg());
		goodsService.saveGoodsEvalPoint(pointParam);	
		pointParam.setEval_item_cd("02");
		goodsService.saveGoodsEvalPoint(pointParam);			
		pointParam.setEval_item_cd("03");
		goodsService.saveGoodsEvalPoint(pointParam);			
		pointParam.setEval_item_cd("04");
		goodsService.saveGoodsEvalPoint(pointParam);		
		
		return "jsonView";
	}
	
	// <!-- ????????? ???????????? ???????????? ??????  -->
	@RequestMapping(value = "/goods/pop_tel.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String pop_tel(@RequestParam("ctg") String ctg, @RequestParam("goodsCd") String goodsCd, @RequestParam("eventCd") String eventCd, HttpServletRequest request, ModelMap model)throws Exception{
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = null;
		String knm = null;
		String age = null;
		String sex = null;
		String id = null;
		String email = null;
		String custGradeCd = null;
		String birthday = null;
		
		if(sessionParam != null){
			
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
			if(sessionParam.get("knm") != null)
				knm = sessionParam.get("knm").toString();
			if(sessionParam.get("email") != null)
				email = sessionParam.get("email").toString();
		}
		
		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);
		model.addAttribute("eventCd", eventCd);
		
		/** ???????????? ?????? ?????? **/
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("sex", sex);
		model.addAttribute("id", id);
		model.addAttribute("email", email);		
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("birthday", birthday);	
		
		return _rootPath+"goods/pop_tel";
	}	
	
	// <!-- ????????? ??????   -->
	@RequestMapping(value = "/goods/pop_review.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String pop_review(@RequestParam("ctg") String ctg, @RequestParam("goodsCd") String goodsCd, @RequestParam("eventCd") String eventCd, @RequestParam("goodsNm") String goodsNm, HttpServletRequest request, ModelMap model)throws Exception{
		
		
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = null;
		String knm = null;
		String age = null;
		String sex = null;
		String id = null;
		String email = null;
		String custGradeCd = null;
		String birthday = null;
		
		if(sessionParam != null){
			
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
			if(sessionParam.get("knm") != null)
				knm = sessionParam.get("knm").toString();
			if(sessionParam.get("email") != null)
				email = sessionParam.get("email").toString();
		}
		
		
		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);
		model.addAttribute("eventCd", eventCd);
		model.addAttribute("goodsNm", goodsNm);
		
		/** ???????????? ?????? ?????? **/
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("email", email);		
		
		return _rootPath+"goods/pop_review";
	}	
	
	/** ????????? DEPTH??? ???????????? ????????? ?????? Ajax **/
	@RequestMapping(value = "/goods/saveGoodsCart.do",method={RequestMethod.GET, RequestMethod.POST})
	public String saveGoodsCart(@ModelAttribute("DIWishListVO") DIWishListVO vo, ModelMap model) throws Exception{
	
		vo.setWish_cd("01");
		
		// ????????? ?????? ??? ????????? ????????? ?????? 
		// for debug
		//vo.setCust_cd("9999999999"); // ?????? ?????? ?????? 
		
		//?????? ???????????? ?????? ??????
		int duplication = cartService.duplicationCheck(vo);
		
		if(duplication < 1){
			cartService.saveCart(vo);
		}else{
			cartService.updateCart(vo);
		}
		
		model.put("saveCnt", 1);
		
	    return "jsonView";
	}
	
	/** ????????? DEPTH??? ???????????? ????????? ?????? Ajax **/
	@RequestMapping(value = "/goods/srchMyReviewCountAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String srchMyReviewCountAjax(@ModelAttribute("GoodsEvalVO") GoodsEvalVO param, ModelMap model) throws Exception{
	
		
		//?????? ???????????? ?????? ?????? 
		int saveCnt  = goodsService.srchMyReviewCount(param);				
		model.put("saveCnt", saveCnt);
		
	    return "jsonView";
	}
	
	
	
	/** ????????? DEPTH??? ???????????? ????????? ?????? Ajax **/
	@RequestMapping(value = "/goods/goodsCtgListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String goodsCtgListAjax(@RequestParam("ctg") String ctg,  @ModelAttribute("GoodsCtgVO") GoodsCtgVO vo, ModelMap model) throws Exception{
	
		
		int nCtg = Integer.parseInt(ctg);
		
		vo.setCtg_seq(nCtg);
		
		//?????? ???????????? ?????? ?????? 
		List list = null;
		if(nCtg >= 5749 && nCtg <= 5759) {
			list = goodsService.srchSiteCtgSrch(vo);						
			
		} else if(nCtg == 5740 || nCtg == 5741 || nCtg == 5746 || nCtg == 5808) {
			list = goodsService.srchSiteCtgSrch(vo);	
		} else {
			list = goodsService.srchSiteCtgSrch02(vo);						
			
		}
		
		model.put("list", list);
		
	    return "jsonView";
	}
	
	/** ????????? DEPTH??? ???????????? 2 ????????? ?????? Ajax **/
	@RequestMapping(value = "/goods/goodsCtgListDepthAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String goodsCtgListDepthAjax(@RequestParam("ctg") String ctg,  @ModelAttribute("GoodsCtgVO") GoodsCtgVO vo, ModelMap model) throws Exception{
		
		int nCtg = Integer.parseInt(ctg);
		
		vo.setCtg_seq(nCtg);
		
		//?????? ???????????? ?????? ?????? 
		List list = null;
		list = goodsService.srchSiteCtgByDepthSrch(vo);				
				
		model.put("list", list);
		
	    return "jsonView";

	}
	
	/** ????????? DEPTH??? ???????????? 2 ????????? ?????? Ajax **/
	@RequestMapping(value = "/goods/goodsCtgListDepthAjax2.do",method={RequestMethod.GET, RequestMethod.POST})
	public String goodsCtgListDepthAjax2(@RequestParam("ctg") String ctg,  @ModelAttribute("GoodsCtgVO") GoodsCtgVO vo, ModelMap model) throws Exception{
		vo.setCtg_seq(Integer.parseInt(ctg));
		
		//?????? ???????????? ?????? ?????? 
		List list = goodsService.srchSiteCtgByDepthSrch2(vo);						
		model.put("list", list);
		
	    return "jsonView";

	}
	
	// <!-- ????????? ?????? ????????? ?????? -->
	@RequestMapping(value = "/goods/srchSiteGoodsSrchsByAreaListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String siteGoodsSrchsByAreaListAjax(@RequestParam("ctg") String ctg, @RequestParam("orderby") String orderby,  @ModelAttribute("GoodsVO") GoodsVO vo,  ModelMap model) throws Exception{
		
		int startRow = 1;
		int endRow = PAGESIZE;
		
		// ????????? ?????? ????????? ?????? ?????? ??????  
		vo.setCtg_seq(Integer.parseInt(ctg));
		vo.setOrderby(orderby);
		vo.setStartRow(startRow);
		vo.setEndRow(endRow);

		// ?????? ?????? ???????????? 
		Date systemDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		String startDay = sdf.format(systemDate);
		vo.setStart_day(startDay);
		
		List list =  goodsService.srchSiteGoodsSrchsByAreaList(vo);		
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}
	
	// <!-- ????????? ?????? ????????? ?????? -->
	@RequestMapping(value = "/goods/srchSiteGoodsSrchsByAreaListCountAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String siteGoodsSrchsByAreaListCountAjax(@RequestParam("ctg") String ctg, @ModelAttribute("GoodsVO") GoodsVO vo,  ModelMap model) throws Exception{

		vo.setCtg_seq(Integer.parseInt(ctg));
		// ?????? ?????? ???????????? 
		Date systemDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		String startDay = sdf.format(systemDate);
		vo.setStart_day(startDay);
		
		Integer totalSize =  goodsService.srchSiteGoodsSrchsByAreaListCount(vo);		
		
		model.addAttribute("totalSize", totalSize);
		
		
		return "jsonView";
	}
	
	
	// <!-- ????????? ?????? ????????? ?????? -->
	@RequestMapping(value = "/goods/moreSrchSiteGoodsSrchsByAreaListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String moreSrchSiteGoodsSrchsByAreaListAjax(@RequestParam("ctg") String ctg, @RequestParam("orderby") String orderby, @RequestParam("startRow") String startRow, @RequestParam("endRow") String endRow, @ModelAttribute("GoodsVO") GoodsVO vo, ModelMap model) throws Exception{

		// ????????? ?????? ????????? ?????? ?????? ??????  
		vo.setCtg_seq(Integer.parseInt(ctg));
		vo.setOrderby(orderby);
		vo.setStartRow(Integer.parseInt(startRow));
		vo.setEndRow(Integer.parseInt(endRow));
		
		// ?????? ?????? ???????????? 
		Date systemDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		String startDay = sdf.format(systemDate);
		vo.setStart_day(startDay);
		
		List list =  goodsService.srchSiteGoodsSrchsByAreaList(vo);		
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}	
	
		
	// <!-- ?????? ????????? ?????? ?????? --> Ajax
	@RequestMapping(value = "/goods/srchSiteGoodsInfoAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String srchSiteGoodsInfoAjax(@RequestParam("ctg") String ctg, @RequestParam("goodsCd") String goodsCd, @ModelAttribute("GoodsVO") GoodsVO vo, ModelMap model) throws Exception{
		// http://localhost:8080/goods/srchSiteGoodsInfoAjax.do?ctg=5749&goodsCd=EUP0841
		
		GoodsMstVO param = new GoodsMstVO();	
		// param.setCtg_seq(Integer.parseInt(ctg));
		param.setGoods_cd(goodsCd);
		
		// ?????? ?????? ?????? 
		GoodsMstVO goodsMstVO = (GoodsMstVO) goodsService.srchSiteGoodsCtgSrch(param);

		// ???????????? ?????? 
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		String startday = sdf.format(new Date());
		vo.setStart_day(startday);		
		vo.setCtg_seq(Integer.parseInt(ctg));
		vo.setGoods_cd(goodsCd);
		vo.setComp_cd(goodsMstVO.getComp_cd());
		//??????  ?????? ?????? 
		GoodsVO goodsDetail = (GoodsVO) goodsService.srchSiteGoodsInfo(vo);						
		model.addAttribute("master", goodsDetail);
		
		return "jsonView";
	}
		
	@RequestMapping(value = "/goods/srchSiteGoodsEvntScheduleAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String srchSiteGoodsEvntScheduleAjax(@RequestParam("ctg") String ctg, @RequestParam("goodsCd") String goodsCd, @ModelAttribute("EventMstVO") EventMstVO vo, ModelMap model) throws Exception{
		// http://localhost:8080/goods/srchSiteGoodsEvntScheduleAjax.do?ctg=5749&goodsCd=EUP0841
		

		GoodsMstVO param = new GoodsMstVO();	
		// param.setCtg_seq(Integer.parseInt(ctg));
		param.setGoods_cd(goodsCd);
		
		// ?????? ?????? ?????? 
		GoodsMstVO goodsMstVO = (GoodsMstVO) goodsService.srchSiteGoodsCtgSrch(param);

		// ???????????? ?????? 
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		String startday = sdf.format(new Date());
		vo.setStart_day(startday);		
		vo.setCtg_seq(Integer.parseInt(ctg));
		vo.setGoods_cd(goodsCd);
		vo.setComp_cd(goodsMstVO.getComp_cd());
		
		//??????  ????????? ????????? ?????? 
		EventMstVO eventDTO = (EventMstVO) goodsService.srchSiteGoodsEvntDays(vo);						
		model.addAttribute("eventDTO", eventDTO);
		
		return "jsonView";
	}	
	
	@RequestMapping(value = "/goods/srchSiteGoodsEvntListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String srchSiteGoodsEvntListAjax(@RequestParam("ctg") String ctg
														, @RequestParam("goodsCd") String goodsCd
														, @RequestParam("eventCd") String eventCd
														, @RequestParam("startDay") String startDay
														,@RequestParam("flagReserve") String flagReserve
														, @RequestParam("startRow") String startRow
														, @RequestParam("endRow") String endRow
														, @RequestParam("price") String price
														, @ModelAttribute("EventListDTO") EventListDTO dto
														, ModelMap model) throws Exception{
		// http://localhost:8080/goods/srchSiteGoodsEvntListAjax.do?ctg=5834&goodsCd=ASP1924&eventCd=201611&startDay=20161101&startRow=1&endRow=10
		String endDay = "";
		
		if(logger.isInfoEnabled()) {
			logger.info("ctg : " + ctg);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
			logger.info("startDay : " + startDay);
			logger.info("flagReserve : " + flagReserve);		
			logger.info("startRow : " + startRow);
			
			logger.info("endRow : " + endRow);
		}
		
		System.out.println("ctg : " + ctg);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		System.out.println("startDay : " + startDay);
		System.out.println("startRow : " + startRow);
		System.out.println("endRow : " + endRow);
		System.out.println("flagReserve : " + flagReserve);	
		System.out.println("price : " + price);	
		
		int year = 0;
		int month = 0;
		int date = 0;
		
		if(!startDay.equals("") && startDay.length() == 8) {
			year = Integer.parseInt(startDay.substring(0, 4));
			month = Integer.parseInt(startDay.substring(4, 6));
			date = Integer.parseInt(startDay.substring(6, 8));
			System.out.println("year : " + year);
			System.out.println("month : " + month);
			System.out.println("date : " + date);
			
			if(year < 0) return "";
			if(month < 0) return "";
			if(date < 0) return "";
			
			if (month == 12) {
				year = year + 1;
				month = 1;
			} else {
				month = month + 1;
			}
			
			if(month < 10) {
				endDay = year + "0" + month + "01";
			} else {
				endDay = year + "" + month + "01";
			}
			
			System.out.println("endDay : " + endDay);
		}

		GoodsMstVO paramMap = new GoodsMstVO();	
		// param.setCtg_seq(Integer.parseInt(ctg));
		paramMap.setGoods_cd(goodsCd);
		
		// ?????? ?????? ?????? 
		GoodsMstVO goodsMstVO = (GoodsMstVO) goodsService.srchSiteGoodsCtgSrch(paramMap);
		if(goodsMstVO == null) goodsMstVO = new GoodsMstVO();
		
		EventListDTO param = new EventListDTO();	
		param.setGoods_cd(goodsCd);	
		if(Integer.parseInt(ctg) > 0) param.setCtg_seq(Integer.parseInt(ctg));
		param.setEvent_cd(eventCd);
		param.setComp_cd(goodsMstVO.getComp_cd());
		
		// ?????? ?????????????????? ????????? ???
		param.setStart_day(startDay); 
		// ?????? ?????????????????? ????????? ??? 
		param.setEnd_day(endDay);
		param.setPrice(price);
		
		
		// ?????? ?????? ?????? 
		// param.setFlag_reserve(flagReserve);
		
		if(Integer.parseInt(startRow) > 0) param.setStartRow(Integer.parseInt(startRow));
		if(Integer.parseInt(endRow) > 0)  param.setEndRow(Integer.parseInt(endRow));
		
		List list =  goodsService.srchSiteGoodsEvntList(param);		
		if(list == null) list = new ArrayList();
		
		model.addAttribute("list", list);
		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);
		model.addAttribute("startDay", startDay);
		model.addAttribute("eventCd", eventCd);
		model.addAttribute("opCd", goodsMstVO.getOp_cd());
		
		
		return "jsonView";		
	} 
	
	@RequestMapping(value = "/goods/srchSiteGoodsEvntListCountAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String srchSiteGoodsEvntListCountAjax(@RequestParam("ctg") String ctg
																, @RequestParam("goodsCd") String goodsCd, @RequestParam("eventCd") String eventCd
																, @RequestParam("startDay") String startDay,@RequestParam("flagReserve") String flagReserve
																, @RequestParam("price") String price
																, @ModelAttribute("EventListDTO") EventListDTO dto
																, ModelMap model) throws Exception{
		// http://localhost:8080/goods/srchSiteGoodsEvntListCountAjax.do?ctg=5834&goodsCd=ASP1924&eventCd=201611&startDay=20161101
		String endDay = "";
		if(logger.isInfoEnabled()) {
			logger.info("ctg : " + ctg);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
			logger.info("startDay : " + startDay);
		}
		
		
		System.out.println("ctg : " + ctg);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		System.out.println("startDay : " + startDay);
		System.out.println("flagReserve : " + flagReserve);		
		
		int year = 0;
		int month = 0;
		int date = 0;
		
		if(!startDay.equals("") && startDay.length() == 8) {
			year = Integer.parseInt(startDay.substring(0, 4));
			month = Integer.parseInt(startDay.substring(4, 6));
			date = Integer.parseInt(startDay.substring(6, 8));
			System.out.println("year : " + year);
			System.out.println("month : " + month);
			System.out.println("date : " + date);
			
			if(year < 0) return "";
			if(month < 0) return "";
			if(date < 0) return "";
			
			
			if (month == 12) {
				year = year + 1;
				month = 1;
			} else {
				month = month+1;
			}
			
			if(month < 10) {
				endDay = year + "0" + month + "01";
			} else {
				endDay = year + "" + month + "01";
			}
			
			System.out.println("endDay : " + endDay);
		}
		
		GoodsMstVO paramMap = new GoodsMstVO();	
		// param.setCtg_seq(Integer.parseInt(ctg));
		paramMap.setGoods_cd(goodsCd);
		
		// ?????? ?????? ?????? 
		GoodsMstVO goodsMstVO = (GoodsMstVO) goodsService.srchSiteGoodsCtgSrch(paramMap);

		EventListDTO param = new EventListDTO();	
		// param.setCtg_seq(Integer.parseInt(ctg));
		param.setGoods_cd(goodsCd);	
		if(Integer.parseInt(ctg) > 0) param.setCtg_seq(Integer.parseInt(ctg));
		param.setEvent_cd(eventCd);
		param.setComp_cd(goodsMstVO.getComp_cd());
		
		// ?????? ?????????????????? ????????? ???
		param.setStart_day(startDay); 
		param.setEnd_day(endDay);
		param.setPrice(price);
		// ?????? ?????? ?????? 
		// param.setFlag_reserve(flagReserve);
		
		Integer totalSize =  goodsService.srchSiteGoodsEvntListCount(param);		
		
		model.addAttribute("totalSize", totalSize);
		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);
		model.addAttribute("startDay", startDay);
		model.addAttribute("eventCd", eventCd);
		
		return "jsonView";				
	}
	
	@RequestMapping(value = "/goods/srchSiteGoodsEvntListCountCanReserveAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String srchSiteGoodsEvntListCountCanReserveAjax(@RequestParam("ctg") String ctg
																				, @RequestParam("goodsCd") String goodsCd
																				, @RequestParam("price") String price
																				, @RequestParam("eventCd") String eventCd
																				, @RequestParam("startDay") String startDay
																				,@RequestParam("flagReserve") String flagReserve
																				, @ModelAttribute("EventListDTO") EventListDTO dto
																				, ModelMap model) throws Exception{
		// http://localhost:8080/goods/srchSiteGoodsEvntListCountAjax.do?ctg=5834&goodsCd=ASP1924&eventCd=201611&startDay=20161101
		
		String endDay = "";
		if(logger.isInfoEnabled()) {
			logger.info("ctg : " + ctg);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
			logger.info("startDay : " + startDay);
		}
		
		
		System.out.println("ctg : " + ctg);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		System.out.println("startDay : " + startDay);
		System.out.println("flagReserve : " + flagReserve);		
		
		int year = 0;
		int month = 0;
		int date = 0;
		
		if(!startDay.equals("") && startDay.length() == 8) {
			year = Integer.parseInt(startDay.substring(0, 4));
			month = Integer.parseInt(startDay.substring(4, 6));
			date = Integer.parseInt(startDay.substring(6, 8));
			System.out.println("year : " + year);
			System.out.println("month : " + month);
			System.out.println("date : " + date);
			
			if(year < 0) return "";
			if(month < 0) return "";
			if(date < 0) return "";
			
			if (month == 12) {
				year = year + 1;
				month = 1;
			} else {
				month = month+1;
			}
			
			if(month < 10) {
				endDay = year + "0" + month + "01";
			} else {
				endDay = year + "" + month + "01";
			}
			
			System.out.println("endDay : " + endDay);
		}
		
		GoodsMstVO paramMap = new GoodsMstVO();	
		// param.setCtg_seq(Integer.parseInt(ctg));
		paramMap.setGoods_cd(goodsCd);
		
		// ?????? ?????? ?????? 
		GoodsMstVO goodsMstVO = (GoodsMstVO) goodsService.srchSiteGoodsCtgSrch(paramMap);
		if(goodsMstVO == null) goodsMstVO = new GoodsMstVO();
		
		EventListDTO param = new EventListDTO();	
		// param.setCtg_seq(Integer.parseInt(ctg));
		param.setGoods_cd(goodsCd);	
		if(Integer.parseInt(ctg) > 0) param.setCtg_seq(Integer.parseInt(ctg));
		param.setEvent_cd(eventCd);
		param.setComp_cd(goodsMstVO.getComp_cd());
		
		// ?????? ?????????????????? ????????? ???
		param.setStart_day(startDay); 
		param.setEnd_day(endDay);
		param.setPrice(price);
		
		// ?????? ?????? ?????? 
		// param.setFlag_reserve(flagReserve);
		
	
		List list =  goodsService.srchSiteGoodsEvntListCanReserve(param);	
		if(list == null) list = new ArrayList();
		
		int rvCnt = 0;
		int evInwon = 0;
		String lockUnit = "";
		String procCd = "";
		
		int totalSize = 0;
		if(list != null) {
			for(int i = 0; i < list.size(); i++) {
				EventListDTO listDTO = (EventListDTO) list.get(i);
				
				rvCnt = listDTO.getRv_cnt();
				evInwon = listDTO.getEv_inwon();
				lockUnit = listDTO.getLock_unit();
				procCd = listDTO.getProc_cd();
				
				/**
				 * [AS_IS] ?????? ?????? ??? ?????? ??????/?????? ?????? ???????????????. 
				**/		
				if (rvCnt >= evInwon) { // ?????? ?????? 
					
				} else {
					if (evInwon == 0) { // ?????? ??????
						
					} else {
						if (procCd == "RE") { // ?????? ??????
							
						} else {
							if (lockUnit == "Y") { // ?????? ?????? 
								
							} else {							
								if (procCd == "SE") { // ???????????? 
									
								} else { // ?????? ?????? 
									totalSize ++;
								}
							}
						}
					}
				}
			}
		}
		
		System.out.println ("?????? ?????? ?????? ??????  : " + totalSize);
		
		model.addAttribute("totalSize", totalSize);
		return "jsonView";				
	}
	
	// <!-- ?????? ????????? ?????? ????????? ?????? --> Ajax
	@RequestMapping(value = "/goods/srchEventMstListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String srchEventMstListAjax(@RequestParam("ctg") String ctg, @RequestParam("eventCd") String eventCd, @ModelAttribute("EventMstListVO") EventMstListVO vo, ModelMap model) throws Exception{
		// http://localhost:8080/goods/srchEventMstListAjax.do?ctg=6291&goodsCd=EUP0420&eventCd=EUP04201611171
		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		
		if(logger.isInfoEnabled()) {
			logger.info("ctg : " + ctg);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
		}
		
		int startRow = 1;
		int endRow = PAGESIZE;
		
		System.out.println("ctg : " + ctg);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		
		GoodsMstVO paramMap = new GoodsMstVO();	
		// param.setCtg_seq(Integer.parseInt(ctg));
		paramMap.setGoods_cd(goodsCd);
		
		// ?????? ?????? ?????? 
		GoodsMstVO goodsMstVO = (GoodsMstVO) goodsService.srchSiteGoodsCtgSrch(paramMap);

		
		if(ctg != null && !ctg.equals("")) vo.setCtg_seq(Integer.parseInt(ctg));
		vo.setGoods_cd(goodsCd);
		vo.setEvent_cd(eventCd);		
		vo.setStartRow(startRow);
		vo.setEndRow(endRow);
		vo.setComp_cd(goodsMstVO.getComp_cd());
		/** ?????? ????????? ????????? ?????? ?????? **/
		List eventMstList =  goodsService.srchEventMstList(vo);		
		
		/** ?????? ????????? ????????? ?????? **/
		Integer totalSize =  goodsService.srchEventMstListCount(vo);		
		
		/** ?????? ????????? ?????? ?????? **/
		GoodsImgVO goodsImgParam = new GoodsImgVO();
		goodsImgParam.setGoods_cd(goodsCd);
		
		List goodsImgList = goodsService.srchGoodsImgList(goodsImgParam);
		
		EventGroupAllSchdVO eventParam = new EventGroupAllSchdVO();
		
		eventParam.setDivision("E");
		eventParam.setGoods_cd(goodsCd);
		eventParam.setEvent_cd(eventCd);
		eventParam.setComp_cd(goodsMstVO.getComp_cd());
		eventParam.setSect_seq(0);
		eventParam.setCtg_seq(Integer.parseInt(ctg));
		
		// ?????? ?????? ??????
		List eventAllSchdList = (List) goodsService.srchEventGroupAllSchdList(eventParam);
					
		model.addAttribute("eventMstList", eventMstList);
		model.addAttribute("goodsImgList", goodsImgList);
		model.addAttribute("eventAllSchdList", eventAllSchdList);
		
		model.addAttribute("totalSize", totalSize);
		
		return "jsonView";
	}
	
	// <!-- ?????? ?????? UI > ?????? ?????? ?????? ??????   --> Ajax
	@RequestMapping(value = "/goods/srchEventCommSchdListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String srchEventCommSchdListAjax(@RequestParam("goodsCd") String goodsCd, @RequestParam("eventCd") String eventCd, @ModelAttribute("EventCommSchdVO") EventCommSchdVO vo, ModelMap model) throws Exception{
		// http://localhost:8080/goods/srchEventCommSchdListAjax.do?goodsCd=EUP0420&eventCd=EUP04201611171
		
		
		if(logger.isInfoEnabled()) {
			logger.info("eventCd : " + eventCd);
		}
		
		System.out.println("eventCd : " + eventCd);
		
		EventCommSchdVO paramMap = new EventCommSchdVO();	
		// param.setCtg_seq(Integer.parseInt(ctg));
		paramMap.setEvent_cd(eventCd);
		
		// ?????? ?????? ?????? ??????
		List eventCommSchdList = (List) goodsService.srchEventCommSchdList(paramMap);
		
		
		GoodsEvalVO reviewListParam = new GoodsEvalVO();
		reviewListParam.setGoods_cd(goodsCd);
		reviewListParam.setStartRow(1);
		reviewListParam.setStartRow(2);		
		
		// ?????? ????????? ????????? ?????? 
		List goodsReviewList = (List) goodsService.srchGoodsReviewList(reviewListParam);
		
		model.addAttribute("eventCommSchdList", eventCommSchdList);
		model.addAttribute("goodsReviewList", goodsReviewList);
		
		return "jsonView";
	}	
	
	/** ?????? ?????? UI > ?????? ?????? ?????? ?????? > ????????? ????????? ?????? **/
	@RequestMapping(value = "/goods/srchReviewListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String srchReviewListAjax(@RequestParam("goodsCd") String goodsCd, @RequestParam("startRow") String startRow, @RequestParam("endRow") String endRow, @ModelAttribute("GoodsEvalVO") GoodsEvalVO reviewListParam, ModelMap model) throws Exception{
		// http://localhost:8080/goods/srchReviewListAjax.do?goodsCd=EUP0420&startRow=1&endRow=10
		if(logger.isInfoEnabled()) {
			logger.info("goodsCd : " + goodsCd);
			logger.info("startRow : " + startRow);			
			logger.info("endRow : " + endRow);
		}
		
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("startRow : " + startRow);
		System.out.println("endRow : " + endRow);
		
		reviewListParam.setGoods_cd(goodsCd);
		reviewListParam.setStartRow(Integer.parseInt(startRow));
		reviewListParam.setEndRow(Integer.parseInt(endRow));		
		
		// ?????? ????????? ????????? ?????? 
		List goodsReviewList = (List) goodsService.srchGoodsReviewList(reviewListParam);
		
		model.addAttribute("goodsReviewList", goodsReviewList);
		
		
		return "jsonView";		
	}
	
	/** ?????? ?????? UI > ?????? ?????? ?????? ?????? > ????????? ????????? ?????? **/
	@RequestMapping(value = "/goods/srchMoreReviewListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String srchMoreReviewListAjax(@RequestParam("goodsCd") String goodsCd, @RequestParam("startRow") String startRow, @RequestParam("endRow") String endRow, @ModelAttribute("GoodsEvalVO") GoodsEvalVO reviewListParam, ModelMap model) throws Exception{
		// http://localhost:8080/goods/srchReviewListAjax.do?goodsCd=EUP0420&startRow=1&endRow=10
		if(logger.isInfoEnabled()) {
			logger.info("goodsCd : " + goodsCd);
			logger.info("startRow : " + startRow);			
			logger.info("endRow : " + endRow);
		}
		
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("startRow : " + startRow);
		System.out.println("endRow : " + endRow);
		
		reviewListParam.setGoods_cd(goodsCd);
		reviewListParam.setStartRow(Integer.parseInt(startRow));
		reviewListParam.setEndRow(Integer.parseInt(endRow));		
		
		// ?????? ????????? ????????? ?????? 
		List goodsReviewList = (List) goodsService.srchGoodsReviewList(reviewListParam);
		
		model.addAttribute("goodsReviewList", goodsReviewList);
		
		
		return "jsonView";		
	}
	
	/** ?????? ?????? UI > ?????? ?????? ?????? ?????? > ????????? ????????? ????????? ?????? **/
	@RequestMapping(value = "/goods/srchReviewListCountAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String srchReviewListCountAjax(@RequestParam("goodsCd") String goodsCd, @ModelAttribute("GoodsEvalVO") GoodsEvalVO reviewListParam, ModelMap model) throws Exception{
		// http://localhost:8080/goods/srchReviewListCountAjax.do?goodsCd=EUP0420&startRow=1&endRow=10
		if(logger.isInfoEnabled()) {
			logger.info("goodsCd : " + goodsCd);
		}
		
		System.out.println("goodsCd : " + goodsCd);
		
		reviewListParam.setGoods_cd(goodsCd);
		
		// ?????? ????????? ????????? ?????? 
		Integer reviewTotalSize = (Integer) goodsService.srchGoodsReviewListCount(reviewListParam);
		
		model.addAttribute("reviewTotalSize", reviewTotalSize);
		
		
		return "jsonView";		
	}	
	
	/** ?????? ?????? UI > ?????? ?????? > ?????? ?????? ??????  **/
	@RequestMapping(value = "/goods/srchEventGroupAllSchdListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String srchEventGroupAllSchdListAjax(@RequestParam("ctg") String ctg, @RequestParam("division") String division, @RequestParam("goodsCd") String goodsCd, @RequestParam("eventCd") String eventCd, @ModelAttribute("EventGroupAllSchdVO") EventGroupAllSchdVO param, ModelMap model) throws Exception{
		// http://localhost:8080/goods/srchEventGroupAllSchdListAjax.do?goodsCd=EUP0420&eventCd=EUP04201611171
		if(logger.isInfoEnabled()) {
			logger.info("division : " + division);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);			
		}
		
		System.out.println("division : " + division);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);	
		
		GoodsMstVO paramMap = new GoodsMstVO();	
		// param.setCtg_seq(Integer.parseInt(ctg));
		paramMap.setGoods_cd(goodsCd);
		
		// ?????? ?????? ?????? 
		GoodsMstVO goodsMstVO = (GoodsMstVO) goodsService.srchSiteGoodsCtgSrch(paramMap);
		
		param.setDivision(division);
		param.setGoods_cd(goodsCd);
		param.setEvent_cd(eventCd);
		param.setComp_cd(goodsMstVO.getComp_cd());
		// param.setSect_seq(0);
		param.setCtg_seq(Integer.parseInt(ctg));
		
		// ?????? ?????? ??????
		List eventGroupAllSchdList = (List) goodsService.srchEventGroupAllSchdList(param);
		
		// ?????? ?????? ????????? ?????? 
		// scheduleGroup(eventGroupAllSchdList);
		
		model.addAttribute("eventGroupAllSchdList", eventGroupAllSchdList);
		model.addAttribute("rnGroupAreaDTO", rnGroupAreaDTO);
		model.addAttribute("rnGroupHotelAllDTO", rnGroupHotelAllDTO);
		
		return "jsonView";		
	}		
	

	
	// ?????? ?????? 
	public List<Map> searchRNGroupHotelInfo2(Map params) {
		Map hotelHashMap = null;
		
		List resultMultiList = null;
		try {
			String opCd = Util.nvl(params.get("op_cd"));
			String cityCd = Util.nvl(params.get("city_cd"));
			String lodgeCd = Util.nvl(params.get("lodge_cd"));
			
			HotelInfoVO param = new HotelInfoVO();
			param.setOp_cd(opCd);
			param.setCity_cd(cityCd);
			param.setLodge_cd(lodgeCd);
			resultMultiList = goodsService.srchHotelInfo(param);

			if (null != resultMultiList) {
				int listSize = resultMultiList.size();
				if(rnGroupHotelAllDTO == null) rnGroupHotelAllDTO = new ArrayList<HotelInfoVO>();
				for (int i = 0; i < listSize; i++) {
					HotelInfoVO tempMap = (HotelInfoVO) resultMultiList.get(i);
					String img_path = tempMap.getImg_paths();
					img_path = img_path.replaceAll("_001.", "_001_600."); 
																		  
					tempMap.setImg_paths(img_path);
					rnGroupHotelAllDTO.add(tempMap);
				}
			}
		} catch (Exception e) {
			logger.error(e);
		}

		return resultMultiList;

	}	
	
	// ?????? ?????? 
	public List<Map> searchRNGroupAreaInfo(Map params) {
		List<Map> resultMultiList = null;
		String opCd = "";
		String cityCd = "";
		String areaInfoTypeCd = "";
		String areaInfoSeq = "";
		int i = 0;
		int listSize = 0;
		AreaInfoVO tempMap = null;

		try {
			resultMultiList = new ArrayList<Map>();
			opCd = (String) params.get("op_cd");
			cityCd = (String) params.get("city_cd");
			areaInfoTypeCd = (String) params.get("area_info_type_cd");
			areaInfoSeq = (String) params.get("area_info_seq");

			AreaInfoVO param = new AreaInfoVO();
			param.setOp_cd(opCd);
			param.setCity_cd(cityCd);
			param.setArea_info_type_cd(areaInfoTypeCd);
			param.setArea_info_seq(Integer.parseInt(areaInfoSeq));
			
			resultMultiList = goodsService.srchAreaInfo(param);
			
			if (null != resultMultiList) {
				listSize = resultMultiList.size();
				if(rnGroupAreaDTO == null) rnGroupAreaDTO = new ArrayList<AreaInfoVO>();
				for (i = 0; i < listSize; i++) {
					tempMap = (AreaInfoVO) resultMultiList.get(i);
					String img_repath = tempMap.getImg_paths();
					img_repath = img_repath.replaceAll("_001.", "_001_600.");
					tempMap.setImg_paths(img_repath); 
					rnGroupAreaDTO.add(tempMap);

				}
			}
			
		} catch (Exception e) {
			logger.error(e);
		}

		return resultMultiList;

	}
	
	// ????????? ?????? 
	public void setDayPath(List<Map> listMap, String dayCnt, String cd, String path) {
		try {
			int day = Util.nvl(dayCnt, 0);
			Map map = listMap.get(day);
			String dayPath = Util.nvl(map.get("DAY_PATH"));
			if ((null != path) && (!"".equals(path))) {
				if (null != dayPath) {
					if (0 < cd.length()) {
						if (1 > dayPath.length()) {
							dayPath = dayPath + path;
						} else {
							dayPath = dayPath
									+ ">" + path;
						}
					}
				} else {
					dayPath = "";
				}
			}
			map.put("DAY_PATH", dayPath);
			map.put("DAY_CNT", day);
			listMap.set(day, map);
		} catch (Exception ex) {
			logger.error(ex);
		}
	}
	
	// <!-- ?????? ???????????? ????????? ??????  -->
	@RequestMapping(value = "/goods/categoryOther.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String categoryOther(@RequestParam("ctg") String ctg, HttpServletRequest request, ModelMap model)throws Exception{
		String subCtg = "";
		
		subCtg = request.getParameter("subCtg");
		
		model.addAttribute("ctg", ctg);
		model.addAttribute("subCtg", subCtg);
		
		return _rootPath+"goods/category_other";
	}
	
	// <!-- ?????? UI > ????????? ??????  ??????  -->
	@RequestMapping(value = "/goods/pop_places.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String pop_places(@RequestParam("eventCd") String eventCd, @RequestParam("regSeq") String regSeq, HttpServletRequest request, ModelMap model)throws Exception{
		
		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		if(regSeq == null || regSeq.equals("")) regSeq = "0";
		
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		
		if(logger.isInfoEnabled()) {
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
		}
		
		
		/** ?????? ?????? ????????? ?????? ?????? **/
		RNGDSchdVO rnGDSchdParam = new RNGDSchdVO();
		rnGDSchdParam.setEvent_cd(eventCd);
		rnGDSchdParam.setReg_seq(Integer.parseInt(regSeq));
		
		RNGDSchdVO rnGDSchd = (RNGDSchdVO) rnGoodsService.srchGDSchdDetail(rnGDSchdParam);
		
		model.addAttribute("rnGDSchd", rnGDSchd);
		
		return _rootPath+"goods/pop_places";
	}
	
	// <!-- ?????? UI > ?????? ??????  ??????  -->
	@RequestMapping(value = "/goods/pop_hotel.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String pop_hotel(@RequestParam("eventCd") String eventCd, @RequestParam("regSeq") String regSeq, HttpServletRequest request, ModelMap model)throws Exception{

		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		if(regSeq == null || regSeq.equals("")) regSeq = "0";
		
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		
		if(logger.isInfoEnabled()) {
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
		}
		
		
		/** ?????? ?????? ????????? ?????? ?????? **/
		RNGDSchdVO rnGDSchdParam = new RNGDSchdVO();
		rnGDSchdParam.setEvent_cd(eventCd);
		rnGDSchdParam.setReg_seq(Integer.parseInt(regSeq));
		
		RNGDSchdVO rnGDSchd = (RNGDSchdVO) rnGoodsService.srchGDSchdDetail(rnGDSchdParam);
		
		model.addAttribute("rnGDSchd", rnGDSchd);
		
		return _rootPath+"goods/pop_hotel";
	}
	
	// <!-- ?????? ???????????? ????????? ?????? -->
	@RequestMapping(value = "/goods/categoryOtherListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String categoryOtherListAjax(@ModelAttribute("MenuVO") MenuVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		HashMap<String, Object> parameter = new HashMap<String, Object>();
		String ctgCodes = vo.getCtgCode();
		
		parameter.put("ctgCode", ctgCodes);		
		model.addAttribute("list", goodsService.srchCategoryList(parameter));
		
	    return "jsonView";
	}
	
	// <!--  ????????? ?????? ??????   -->
	@RequestMapping(value = "/goods/srchSysComCodeAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String srchSysComCodeAjax(@ModelAttribute("ComCodeVO") ComCodeVO param, ModelMap model)throws Exception{
		
		/** ????????? ?????? ?????? **/
		List comcodeList =  reserveService.srchComCode(param);		
		model.addAttribute("comcodeList", comcodeList);
		
		return "jsonView";
	}
		
	// <!-- ?????? ?????? :: TO-BE ????????? ????????? ??? ?????????  -->
	@RequestMapping(value = "/goods/detail_goods.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String detail(@RequestParam("ctg") String ctg, @RequestParam("eventCd") String eventCd, @RequestParam("schd") String schd,HttpServletRequest request, ModelMap model)throws Exception{
		
		String flag = (String) request.getParameter("flag");
		
		
		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		
		if(logger.isInfoEnabled()) {
			logger.info("ctg : " + ctg);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
			logger.info("schd : " + schd);
		}
		
		int startRow = 1;
		int endRow = PAGESIZE;
		
		System.out.println("ctg : " + ctg);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		System.out.println("schd : " + schd);
		
		/** ?????? ?????? ?????? ?????? **/
		RNGDTagsVO rnGDTagsParam = new RNGDTagsVO();
		rnGDTagsParam.setEvent_cd(eventCd);
		
		RNGDTagsVO rnGDTagsResult = new RNGDTagsVO();
		rnGDTagsResult = (RNGDTagsVO) rnGoodsService.srchGDTags(rnGDTagsParam);
		
		/** ?????? ?????? ????????? ?????? **/
		RNETMstVO rnEtMstParam = new RNETMstVO();
		rnEtMstParam.setEvent_cd(eventCd);
		rnEtMstParam.setComp_cd(rnGDTagsResult.getComp_cd());
		rnEtMstParam.setGoods_cd(goodsCd);
		rnEtMstParam.setCtg(ctg);
		
		RNETMstVO rnEtMstResult = new RNETMstVO();
		rnEtMstResult = (RNETMstVO) rnGoodsService.srchETMst(rnEtMstParam);
		
		/** ?????? ?????? ????????? ?????? **/
		RNGDMstVO rnGDMstParam = new RNGDMstVO();
		rnGDMstParam.setComp_cd(rnGDTagsResult.getComp_cd());
		rnGDMstParam.setGoods_cd(goodsCd);
		
		RNGDMstVO rnGDMstResult = new RNGDMstVO();
		rnGDMstResult = (RNGDMstVO) rnGoodsService.srchGDMst(rnGDMstParam);
		
		
		/** ?????? ?????? ?????? ????????? ?????? **/
		RNGDImgVO rnGDImgParam = new RNGDImgVO();
		rnGDImgParam.setGoods_cd(goodsCd);
		List rnGDImgList = (List) rnGoodsService.srchGDImgList(rnGDImgParam);

		/** ?????? ?????? ?????? ?????? ????????? ?????? **/
		RNGDSchdVO rnGDCommSchdParam = new RNGDSchdVO();
		rnGDCommSchdParam.setEvent_cd(eventCd);
		List rnGDCommSchdList = (List) rnGoodsService.srchGDCommSchdList(rnGDCommSchdParam);
		//System.out.println("rnGDCommSchdList >>>>>>>>>>>>>> " + rnGDCommSchdList);
		System.out.println("rnGDCommSchdList >>>>>>>>>>>>>> " + rnGDCommSchdList.size());
		/** ?????? ?????? ????????? ????????? ?????? **/
		RNGDSchdVO rnGDSchdParam = new RNGDSchdVO();
		rnGDSchdParam.setEvent_cd(eventCd);
		List rnGDSchdList = (List) rnGoodsService.srchGDSchdList(rnGDSchdParam);
		//System.out.println("rnGDSchdList >>>>>>>>>>>>>> " + rnGDSchdList);
		System.out.println("rnGDSchdList >>>>>>>>>>>>>> " + rnGDSchdList.size());
		
		RNGDSchdVO rnGDSchdResult = null;
		if(rnGDSchdList.size() > 0) {
			rnGDSchdResult = (RNGDSchdVO) rnGDSchdList.get(0);
		} else {
			rnGDSchdResult = new RNGDSchdVO();
		}
		/** ?????? ?????? **/
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		String weatherDate = sdf.format(new Date());
		
		RNWeatherVO weatherParam = new RNWeatherVO();
		weatherParam.setSchdId(String.valueOf(rnGDSchdResult.getSchd_id()));
		weatherParam.setEventCd(eventCd);
		// weatherParam.setWeatDt(rnEtMstResult.getStart_day());
		weatherParam.setWeatDt(weatherDate);
		
		List weatherList = (List) rnGoodsService.srchWeatherListSrch(weatherParam);

		/** ?????? / ?????? ?????? **/
		RNTimeDifferCurrencyVO currencyParam = new RNTimeDifferCurrencyVO();
		currencyParam.setSchdId(String.valueOf(rnGDSchdResult.getSchd_id()));
		currencyParam.setEventCd(eventCd);
		
		List timeDifferCurrencyList = (List) rnGoodsService.srchTimeDifferCurrencyListSrch(currencyParam);		

		String arrCountry = "";
		String arrCountryNm = "";
		String arrCountryNmTrim = "";
		String apiResult = "";
		String apiContResult = "";
		String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";

		//[JEH] ???????????? ????????? ?????? ????????? ??????  - 20190709
		for(int i = 0; i < rnGDSchdList.size(); i++){
			
			RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDSchdList.get(i);
			
			String data = eventCommSchd.getSchd_det_cd();	
			String val = eventCommSchd.getSchd_det_cd_val();	
			
			if("1001".equals(data)){
				if(eventCommSchd.getSchd_det_cd_val() != null){
					String[] area = val.split("/");
					if("OT".equals(area[0]) && eventCommSchd.getCountry_cd() != null){
						if(!"".equals(arrCountry)){
							if(arrCountry.indexOf(eventCommSchd.getCountry_cd()) == -1){
								arrCountry += "," + eventCommSchd.getCountry_cd();
								arrCountryNm += "," + eventCommSchd.getCountry_nm();
								
								String nm = eventCommSchd.getCountry_nm().replaceAll("\\s", "");
								arrCountryNmTrim += "," + nm.replaceAll(match, "");
							}
						}else{
							arrCountry += eventCommSchd.getCountry_cd();
							arrCountryNm += eventCommSchd.getCountry_nm();
							
							String nm = eventCommSchd.getCountry_nm().replaceAll("\\s", "");
							arrCountryNmTrim +=  nm.replaceAll(match, "");
						}
					}
				}
			}
		}
			
//		System.out.println("=======================>>>>arrCountry : " + arrCountry);
//		System.out.println("=======================>>>>arrCountryNm : " + arrCountryNm);
		
		ArrayList srchSafetyInfo = new ArrayList<Map>();

		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1262000/TravelWarningService/getTravelWarningList"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=wOoIiGzmMnjipzU%2Bzi88UyhBPL9PkB%2F5ec2Pqe2BUsM0gAw0ta3B3VITRkrS56h%2FSfaXeESrinqcynZ2FZHi9A%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*??? ????????? ?????? ???*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*????????? ??????*/
        
        String[] isoCode = arrCountry.split(",");
        
        /*ISO ????????????-10????????? */
        if(isoCode.length > 0){
	        for(int i = 0; i < isoCode.length; i++){
	        	urlBuilder.append("&" + URLEncoder.encode("isoCode"+(i+1),"UTF-8") + "=" + URLEncoder.encode(isoCode[i], "UTF-8")); 
	        }	        
	
//	        System.out.println("urlBuilder: " + urlBuilder.toString());
	        URL url = new URL(urlBuilder.toString());
	        int TIMEOUT_VALUE = 5000;
	        try{	
		        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		        conn.setConnectTimeout(TIMEOUT_VALUE);
		        conn.setReadTimeout(TIMEOUT_VALUE);
		        conn.setRequestMethod("GET");
		        conn.setRequestProperty("Content-type", "application/json");
		//        System.out.println("Response code: " + conn.getResponseCode());
		        BufferedReader rd;
		        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
		            rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		        } else {
		            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		        }
		        StringBuilder sb = new StringBuilder();
		        String line;
		        while ((line = rd.readLine()) != null) {
		            sb.append(line);
		        }
		        rd.close();
		        conn.disconnect();
//		        System.out.println(sb.toString());
		        
		        String xml = sb.toString();
		
				DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
				DocumentBuilder db = dbf.newDocumentBuilder();
				Document doc = db.newDocument();
			
				doc = db.parse(new InputSource(new StringReader(xml)));
				Document root = doc;
				
				NodeList node = root.getElementsByTagName("item");			
				
				NodeList errMsg = root.getElementsByTagName("cmmMsgHeader");			
		
				if(errMsg.getLength() > 0){
					apiResult = "N";
				}else{
					for(int i = 0; i < node.getLength(); i++){
						Node nNode = node.item(i);
			
						if(nNode.getNodeType() == Node.ELEMENT_NODE){
							Element ele = (Element)nNode;
							Map<String, String> map = new HashMap<String, String>();
							
							//System.out.println("countryName : " + getTagValue("countryName", ele));
	
							map.put("countryName", getTagValue("countryName", ele));
							String nm = getTagValue("countryName", ele);
							String splt[] = nm.split("\\(");
							String countryNameTrim = splt[0].replaceAll("\\s", "");
							map.put("countryNameTrim", countryNameTrim.replaceAll(match, ""));
							
							//???????????? 
			//				System.out.println("attention : " + getTagValue("attention", ele));
			//				System.out.println("attentionPartial : " + getTagValue("attentionPartial", ele));
			//				System.out.println("attentionNote : " + getTagValue("attentionNote", ele));
							
							map.put("attention", getTagValue("attention", ele));
							map.put("attentionPartial", getTagValue("attentionPartial", ele));
							map.put("attentionNote", getTagValue("attentionNote", ele));
							//???????????? 
			//				System.out.println("limita : " + getTagValue("limita", ele));
			//				System.out.println("limitaPartial : " + getTagValue("limitaPartial", ele));
			//				System.out.println("limitaNote : " + getTagValue("limitaNote", ele));
							
							map.put("limita", getTagValue("limita", ele));
							map.put("limitaPartial", getTagValue("limitaPartial", ele));
							map.put("limitaNote", getTagValue("limitaNote", ele));
							//???????????? 
			//				System.out.println("control : " + getTagValue("control", ele));
			//				System.out.println("controlPartial : " + getTagValue("controlPartial", ele));
			//				System.out.println("controlNote : " + getTagValue("controlNote", ele));
							
							map.put("control", getTagValue("control", ele));
							map.put("controlPartial", getTagValue("controlPartial", ele));
							map.put("controlNote", getTagValue("controlNote", ele));
			
			//				System.out.println("--------------------------------------------------");
							srchSafetyInfo.add(map);
						}
					}
					apiResult = "Y";
				}
	        }catch(Exception e){
	        	System.out.println("API ?????? ??????------>" + e);
	        	Map<String, String> map = new HashMap<String, String>();
	        	map.put("error", "API ?????? ??????");
	        	srchSafetyInfo.add(map);
	        }
        }

        //??????????????? 
		ArrayList srchContactInfo = new ArrayList<Map>();

		StringBuilder urlBuilder2 = new StringBuilder("http://apis.data.go.kr/1262000/ContactService/getContactList"); /*URL*/
        urlBuilder2.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=wOoIiGzmMnjipzU%2Bzi88UyhBPL9PkB%2F5ec2Pqe2BUsM0gAw0ta3B3VITRkrS56h%2FSfaXeESrinqcynZ2FZHi9A%3D%3D"); /*Service Key*/
        urlBuilder2.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*??? ????????? ?????? ???*/
        urlBuilder2.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*????????? ??????*/
        
        //String[] isoCode2 = arrCountry.split(",");
        
        /*ISO ????????????-10????????? */
        if(isoCode.length > 0){
	        for(int i = 0; i < isoCode.length; i++){
	        	urlBuilder2.append("&" + URLEncoder.encode("isoCode"+(i+1),"UTF-8") + "=" + URLEncoder.encode(isoCode[i], "UTF-8")); 
	        }	        
	
//	        System.out.println("urlBuilder: " + urlBuilder2.toString());
	        URL url2 = new URL(urlBuilder2.toString());
	        int TIMEOUT_VALUE2 = 5000;
	        try{	
		        HttpURLConnection conn2 = (HttpURLConnection) url2.openConnection();
		        conn2.setConnectTimeout(TIMEOUT_VALUE2);
		        conn2.setReadTimeout(TIMEOUT_VALUE2);
		        conn2.setRequestMethod("GET");
		        conn2.setRequestProperty("Content-type", "application/json");
		//        System.out.println("Response code: " + conn.getResponseCode());
		        BufferedReader rd;
		        if(conn2.getResponseCode() >= 200 && conn2.getResponseCode() <= 300) {
		            rd = new BufferedReader(new InputStreamReader(conn2.getInputStream(), "UTF-8"));
		        } else {
		            rd = new BufferedReader(new InputStreamReader(conn2.getErrorStream()));
		        }
		        StringBuilder sb = new StringBuilder();
		        String line;
		        while ((line = rd.readLine()) != null) {
		            sb.append(line);
		        }
		        rd.close();
		        conn2.disconnect();
//		        System.out.println(sb.toString());
		        
		        String xml = sb.toString();
		
				DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
				DocumentBuilder db = dbf.newDocumentBuilder();
				Document doc = db.newDocument();
			
				doc = db.parse(new InputSource(new StringReader(xml)));
				Document root = doc;
				
				NodeList node = root.getElementsByTagName("item");			
				
				NodeList errMsg = root.getElementsByTagName("cmmMsgHeader");			
		
				if(errMsg.getLength() > 0){
					apiContResult = "N";
				}else{
					for(int i = 0; i < node.getLength(); i++){
						Node nNode = node.item(i);
			
						if(nNode.getNodeType() == Node.ELEMENT_NODE){
							Element ele = (Element)nNode;
							Map<String, String> map = new HashMap<String, String>();
	
							map.put("countryName", getTagValue("countryName", ele));
							String nm = getTagValue("countryName", ele);
							String splt[] = nm.split("\\(");
							String countryNameTrim = splt[0].replaceAll("\\s", "");
							map.put("countryNameTrim", countryNameTrim.replaceAll(match, ""));
							
							//???????????????
							//System.out.println("contact : " + getTagValue("contact", ele));						
							map.put("contact", getTagValue("contact", ele));
							
							//System.out.println("--------------------------------------------------");
							srchContactInfo.add(map);
						}
					}
					apiContResult = "Y";
				}
				
	        }catch(Exception e){
	        	System.out.println("API ?????? ??????------>" + e);
	        	Map<String, String> map = new HashMap<String, String>();
	        	map.put("error", "API ?????? ??????");
	        	srchContactInfo.add(map);
	        }
        }
        
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = null;
		String knm = null;
		String age = null;
		String sex = null;
		String id = null;
		String email = null;
		String custGradeCd = null;
		String birthday = null;
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
			if(sessionParam.get("knm") != null)
				knm = sessionParam.get("knm").toString();
			if(sessionParam.get("email") != null)
				email = sessionParam.get("email").toString();
		}
		
		/** ????????? ?????? ?????? **/
		String grade = "";
		if(custCd != null && !custCd.equals("")) {
			grade = (String) rnGoodsService.selectCustGrade(custCd);	
		}
		
		/** ???????????? ?????? ?????? **/
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("sex", sex);
		model.addAttribute("id", id);
		model.addAttribute("email", email);		
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("birthday", birthday);	
		model.addAttribute("grade", grade);
		
		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);		
		model.addAttribute("eventCd", eventCd);
		model.addAttribute("flag", flag);
		model.addAttribute("schd", schd);
		
		model.addAttribute("rnEtMst", rnEtMstResult);
		model.addAttribute("rnGDMst", rnGDMstResult);
		model.addAttribute("rnGDTags", rnGDTagsResult);
		model.addAttribute("rnGDImgList", rnGDImgList);
		model.addAttribute("rnGDCommSchdList", rnGDCommSchdList);
		model.addAttribute("rnGDSchdList", rnGDSchdList);
		model.addAttribute("weatherList", weatherList);
		model.addAttribute("timeDifferCurrencyList", timeDifferCurrencyList);
		
		model.addAttribute("arrCountryNm", arrCountryNm);
		model.addAttribute("arrCountryNmTrim", arrCountryNmTrim);
		model.addAttribute("srchSafetyInfo", srchSafetyInfo);
		model.addAttribute("apiResult", apiResult);
		model.addAttribute("srchContactInfo", srchContactInfo);
		model.addAttribute("apiContResult", apiContResult);
		
		return _rootPath+"goods/shop_detail";
       
	}	
	
	
	    //<!-- ???????????? ???????????????  -->
		@RequestMapping(value = "/goods/detail_goods_shd.do" ,method={RequestMethod.GET, RequestMethod.POST})
		public String detail_shd(@RequestParam("ctg") String ctg, @RequestParam("eventCd") String eventCd, HttpServletRequest request, ModelMap model)throws Exception{
			
			String flag = (String) request.getParameter("flag");
			
			String goodsCd = "";
			if(eventCd != null && !eventCd.equals("")){ 
				goodsCd = eventCd.substring(0, 7);
			}
			
			if(logger.isInfoEnabled()) {
				logger.info("ctg : " + ctg);
				logger.info("goodsCd : " + goodsCd);
				logger.info("eventCd : " + eventCd);
			}
			
			int startRow = 1;
			int endRow = PAGESIZE;
			
			System.out.println("ctg : " + ctg);
			System.out.println("goodsCd : " + goodsCd);
			System.out.println("eventCd : " + eventCd);
			
			/** ?????? ?????? ?????? ?????? **/
			RNGDTagsVO rnGDTagsParam = new RNGDTagsVO();
			rnGDTagsParam.setEvent_cd(eventCd);
			
			RNGDTagsVO rnGDTagsResult = new RNGDTagsVO();
			rnGDTagsResult = (RNGDTagsVO) rnGoodsService.srchGDTags(rnGDTagsParam);
			
			/** ?????? ?????? ????????? ?????? **/
			RNETMstVO rnEtMstParam = new RNETMstVO();
			rnEtMstParam.setEvent_cd(eventCd);
			rnEtMstParam.setComp_cd(rnGDTagsResult.getComp_cd());
			rnEtMstParam.setGoods_cd(goodsCd);
			rnEtMstParam.setCtg(ctg);
			
			RNETMstVO rnEtMstResult = new RNETMstVO();
			rnEtMstResult = (RNETMstVO) rnGoodsService.srchETMst(rnEtMstParam);
			
			/** ?????? ?????? ????????? ?????? **/
			RNGDMstVO rnGDMstParam = new RNGDMstVO();
			rnGDMstParam.setComp_cd(rnGDTagsResult.getComp_cd());
			rnGDMstParam.setGoods_cd(goodsCd);
			
			RNGDMstVO rnGDMstResult = new RNGDMstVO();
			rnGDMstResult = (RNGDMstVO) rnGoodsService.srchGDMst(rnGDMstParam);
			
			
			/** ?????? ?????? ?????? ????????? ?????? **/
			RNGDImgVO rnGDImgParam = new RNGDImgVO();
			rnGDImgParam.setGoods_cd(goodsCd);
			List rnGDImgList = (List) rnGoodsService.srchGDImgList(rnGDImgParam);

			/** ?????? ?????? ?????? ?????? ????????? ?????? **/
			RNGDSchdVO rnGDCommSchdParam = new RNGDSchdVO();
			rnGDCommSchdParam.setEvent_cd(eventCd);
			List rnGDCommSchdList = (List) rnGoodsService.srchGDCommSchdList(rnGDCommSchdParam);
			/** ?????? ?????? ????????? ????????? ?????? **/
			RNGDSchdVO rnGDSchdParam = new RNGDSchdVO();
			rnGDSchdParam.setEvent_cd(eventCd);
			List rnGDSchdList = (List) rnGoodsService.srchGDSchdList(rnGDSchdParam);
			
			RNGDSchdVO rnGDSchdResult = null;
			if(rnGDSchdList.size() > 0) {
				rnGDSchdResult = (RNGDSchdVO) rnGDSchdList.get(0);
			} else {
				rnGDSchdResult = new RNGDSchdVO();
			}
	        
			HttpSession session = request.getSession(true);
			HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
						
			/** ???????????? ?????? ?????? **/
			model.addAttribute("ctg", ctg);
			model.addAttribute("goodsCd", goodsCd);		
			model.addAttribute("eventCd", eventCd);
			model.addAttribute("flag", flag);
			
			model.addAttribute("rnEtMst", rnEtMstResult);
			model.addAttribute("rnGDMst", rnGDMstResult);
			model.addAttribute("rnGDTags", rnGDTagsResult);
			model.addAttribute("rnGDImgList", rnGDImgList);
			model.addAttribute("rnGDCommSchdList", rnGDCommSchdList);
			model.addAttribute("rnGDSchdList", rnGDSchdList);
						
			return _rootPath+"goods/shop_detail_schd";
	       
		}
	

	private static String getTagValue(String tag, Element eElement) {
		try{
			NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
			Node nValue = (Node) nlList.item(0);
			if (nValue == null) {
				return null;
			}
			return nValue.getNodeValue();
		}catch(Exception e){
			return null;
		}
	}
	// <!-- ?????? ?????? :: TO-BE ????????? ????????? ??? ?????????  -->
	@RequestMapping(value = "/goods/pop_other_airlines.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String pop_other_airlines(@RequestParam("eventCd") String eventCd, @RequestParam("startDay") String startDay, HttpServletRequest request, ModelMap model)throws Exception{
		
		
		
		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		
		if(logger.isInfoEnabled()) {
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
		}
		
		
		System.out.println("eventCd : " + eventCd);
		
		/** ?????? ?????? ?????? ?????? **/
		RNGDTagsVO rnGDTagsParam = new RNGDTagsVO();
		rnGDTagsParam.setEvent_cd(eventCd);
		
		RNGDTagsVO rnGDTagsResult = new RNGDTagsVO();
		rnGDTagsResult = (RNGDTagsVO) rnGoodsService.srchGDTags(rnGDTagsParam);
		
		/** ?????? ?????? ????????? ?????? **/
		ETMstOtherAirLineVO rnEtMstParam = new ETMstOtherAirLineVO();
		rnEtMstParam.setEvent_cd(eventCd);
		rnEtMstParam.setComp_cd(rnGDTagsResult.getComp_cd());
		rnEtMstParam.setGoods_cd(goodsCd);
		rnEtMstParam.setStart_day(startDay);
		
		List rnEtMstList = (List) rnGoodsService.srchETMstOtherAirLine(rnEtMstParam);
		

		
		model.addAttribute("eventCd", eventCd);	
		model.addAttribute("rnEtMstList", rnEtMstList);
		
		
		return _rootPath+"goods/pop_other_airlines";
	}	
	
	// <!-- ?????? ?????? UI > ?????? ?????? ??????  -->
	@RequestMapping(value = "/goods/srchWeatherListAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String srchWeatherListAjax(HttpServletRequest request, ModelMap model)throws Exception{
		String schdId = (String) request.getParameter("schdId");
		String eventCd = (String) request.getParameter("eventCd");
		String dayCnt = (String) request.getParameter("dayCnt");
		String weatDt = (String) request.getParameter("weatDt");
		String cityKnm = (String) request.getParameter("cityKnm");
		
		if(dayCnt == null || dayCnt.equals("")) dayCnt = "0";
		RNWeatherVO param = new RNWeatherVO();
		param.setSchdId(schdId);
		param.setEventCd(eventCd);
		param.setWeatDt(weatDt);
		if(!dayCnt.equals("0")) {
			param.setDayCnt(Integer.parseInt(dayCnt));
		}
		
		if(cityKnm != "") {
			param.setCityKnm(cityKnm);
		}
		
		List weatherList = (List) rnGoodsService.srchWeatherListSrch(param);
		
		model.addAttribute("weatherList", weatherList);
		
		return "jsonView";
	}
	
	// <!-- ?????? ?????? UI > ?????? ?????? ??????  -->
	@RequestMapping(value = "/goods/srchTimeDifferCurrencyListAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String srchTimeDifferCurrencyListAjax(HttpServletRequest request, ModelMap model)throws Exception{
		String schdId = (String) request.getParameter("schdId");
		String eventCd = (String) request.getParameter("eventCd");
		String countryKnm = (String) request.getParameter("countryKnm");
		RNTimeDifferCurrencyVO param = new RNTimeDifferCurrencyVO();
		param.setSchdId(schdId);
		param.setEventCd(eventCd);
		param.setCountryKnm(countryKnm);
		
		List timeDifferCurrencyList = (List) rnGoodsService.srchTimeDifferCurrencyListSrch(param);
		
		model.addAttribute("timeDifferCurrencyList", timeDifferCurrencyList);
		
		return "jsonView";
	}
	
	// <!-- ?????? ?????? UI > ?????? ?????? ??????  -->
	@RequestMapping(value = "/goods/pop_weather_city.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String pop_weather_city(HttpServletRequest request, ModelMap model)throws Exception{
		String schdId = (String) request.getParameter("schdId");
		String eventCd = (String) request.getParameter("eventCd");
		String dayCnt = (String) request.getParameter("dayCnt");
		String weatDt = (String) request.getParameter("weatDt");
		String cityKnm = (String) request.getParameter("cityKnm");
		
		if(dayCnt == null || dayCnt.equals("")) dayCnt = "0";
		RNWeatherVO param = new RNWeatherVO();
		param.setSchdId(schdId);
		param.setEventCd(eventCd);
		param.setWeatDt(weatDt);
		if(!dayCnt.equals("0")) {
			param.setDayCnt(Integer.parseInt(dayCnt));
		}
		
		List weatherList = (List) rnGoodsService.srchWeatherListSrch(param);

		model.addAttribute("schdId", schdId);
		model.addAttribute("eventCd", eventCd);
		model.addAttribute("dayCnt", dayCnt);
		model.addAttribute("weatDt", weatDt);	
		model.addAttribute("cityKnm", cityKnm);	
		model.addAttribute("weatherList", weatherList);
		
		return _rootPath+"goods/pop_weather_city";
	}
	
	// <!-- ?????? ?????? UI > ?????? ?????? ??????  -->
	@RequestMapping(value = "/goods/pop_hotel_maps.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String pop_hotel_maps(HttpServletRequest request, ModelMap model)throws Exception{

		String address = (String) request.getParameter("address");
		model.addAttribute("address", address);
		
		return _rootPath+"goods/pop_hotel_maps";
	}
	
	// <!-- ?????? ?????? UI > ?????? ?????? ??????  -->
	@RequestMapping(value = "/goods/pop_currency_city.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String pop_currency_city(HttpServletRequest request, ModelMap model)throws Exception{
		String schdId = (String) request.getParameter("schdId");
		String eventCd = (String) request.getParameter("eventCd");
		RNTimeDifferCurrencyVO param = new RNTimeDifferCurrencyVO();
		param.setSchdId(schdId);
		param.setEventCd(eventCd);
		
		List timeDifferCurrencyList = (List) rnGoodsService.srchTimeDifferCurrencyListSrch(param);

		model.addAttribute("schdId", schdId);
		model.addAttribute("eventCd", eventCd);	
		model.addAttribute("timeDifferCurrencyList", timeDifferCurrencyList);
		
		return _rootPath+"goods/pop_currency_city";
	}

	//[JEH] ???????????? ?????? ????????? ?????? ?????? ?????? ?????? - 20180202
	@RequestMapping(value = "/goods/srchSiteGoodsEvntDetailAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String srchSiteGoodsEvntDetailAjax(@RequestParam("ctg") String ctg, @RequestParam("eventCd") String eventCd, HttpServletRequest request, ModelMap model)throws Exception{
		
		String flag = (String) request.getParameter("flag");
		
		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		
		if(logger.isInfoEnabled()) {
			logger.info("ctg : " + ctg);
			logger.info("goodsCd : " + goodsCd);
			logger.info("eventCd : " + eventCd);
		}
		
		int startRow = 1;
		int endRow = PAGESIZE;
		
		System.out.println("ctg : " + ctg);
		System.out.println("goodsCd : " + goodsCd);
		System.out.println("eventCd : " + eventCd);
		
		/** ?????? ?????? ?????? ?????? **/
		RNGDTagsVO rnGDTagsParam = new RNGDTagsVO();
		rnGDTagsParam.setEvent_cd(eventCd);
		
		RNGDTagsVO rnGDTagsResult = new RNGDTagsVO();
		rnGDTagsResult = (RNGDTagsVO) rnGoodsService.srchGDTags(rnGDTagsParam);
		
		/** ?????? ?????? ????????? ?????? **/
		RNETMstVO rnEtMstParam = new RNETMstVO();
		rnEtMstParam.setEvent_cd(eventCd);
		rnEtMstParam.setComp_cd(rnGDTagsResult.getComp_cd());
		rnEtMstParam.setGoods_cd(goodsCd);
		
		RNETMstVO rnEtMstResult = new RNETMstVO();
		rnEtMstResult = (RNETMstVO) rnGoodsService.srchETMst(rnEtMstParam);
		
		model.addAttribute("rnEtMst", rnEtMstResult);
		
		return "jsonView";		
	} 
	

	// <!-- ?????? ????????? -->
	@RequestMapping(value = "/goods/visa.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String visa(HttpServletRequest request, ModelMap model)throws Exception{
		
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = null;
		String knm = null;
		String age = null;
		String sex = null;
		String id = null;
		String email = null;
		String custGradeCd = null;
		String birthday = null;
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custCd = sessionParam.get("cust_cd").toString();
			if(sessionParam.get("knm") != null)
				knm = sessionParam.get("knm").toString();
			if(sessionParam.get("email") != null)
				email = sessionParam.get("email").toString();
		}
		
		/** ????????? ?????? ?????? **/
		String grade = "";
		if(custCd != null && !custCd.equals("")) {
			grade = (String) rnGoodsService.selectCustGrade(custCd);	
		}
		
		/** ???????????? ?????? ?????? **/
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("sex", sex);
		model.addAttribute("id", id);
		model.addAttribute("email", email);		
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("birthday", birthday);	
		model.addAttribute("grade", grade);
		
		
		return _rootPath+"goods/list_visa";
	}
	
	
}
