package com.lottejtb.account.web;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import net.sf.ehcache.Ehcache;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.inicis.std.util.SignatureUtil;
import com.lottejtb.account.service.AirActPaymtVO;
import com.lottejtb.account.service.AirCardPaymtVO;
import com.lottejtb.account.service.AirEtcPaymtVO;
import com.lottejtb.account.service.AirGiftPaymtVO;
import com.lottejtb.account.service.AirPaymentVO;
import com.lottejtb.account.service.AirPaymtService;
import com.lottejtb.account.service.AirReceiptReqVO;
import com.lottejtb.account.service.AirRefundMgtVO;
import com.lottejtb.account.service.AirRsvPaymtVO;
import com.lottejtb.account.service.FreeLPointService;
import com.lottejtb.account.service.HtlPaymtService;
import com.lottejtb.account.service.HtlRefundMgtVO;
import com.lottejtb.account.service.LPointVO;
import com.lottejtb.account.service.PaymentVO;
import com.lottejtb.account.service.VAcctDepoNotiVO;
import com.lottejtb.comm.service.CommCdService;
import com.lottejtb.comm.service.CommCdVO;
import com.lottejtb.comm.service.CommFileService;
import com.lottejtb.comm.util.CommInfo;
import com.lottejtb.front.air.service.RsvAirItinVO;
import com.lottejtb.front.air.service.RsvAirPaxVO;
import com.lottejtb.front.air.service.RsvAirService;
import com.lottejtb.front.air.service.RsvAirVO;
import com.lottejtb.front.service.FitReserveVO;
import com.lottejtb.front.service.FreeReserveService;
import com.lottejtb.sso.service.LoginService;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
@RequestMapping(value = "/free")
public class FreeAccountController {

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
    @Resource(name = "ehcache")
    Ehcache ehcache;
		
    @Resource(name = "CommFileService")
    private CommFileService fileService;
    
    @Resource(name = "FreeReserveService")
    private FreeReserveService reserveService;

	@Resource(name = "RsvAirService")
	private RsvAirService rsvAirService;
	
    @Resource(name = "FreeLPointService")
    private FreeLPointService lpointService;

    @Resource(name = "AirPaymtService")
    private AirPaymtService airPaymtService;
    
    @Resource(name = "HtlPaymtService")
    private HtlPaymtService htlPaymtService;
    
	@Resource(name = "CommCdService")
	private CommCdService commCdService;
	
	private static final Logger logger = LoggerFactory
			.getLogger(FreeAccountController.class);
	
	private final String _rootPath = "/account";
	
	@RequestMapping(value = "/account/pay_free.do", method={RequestMethod.GET, RequestMethod.POST})
	//public String pay(@RequestParam("seqNo") String seqNo, HttpServletRequest request, Model model) throws Exception {
	public String pay(HttpServletRequest request, Model model) throws Exception {
	    
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String cno			=	"";
		String mblNo		=	"";
		String mbrCustno	=	"";
		
		String custCd = "";
		String knm = "";
		String age = "";
		String sex = "";
		String id = "";
		String email = "";
		String custGradeCd = "";
		String birthday = "";
		
		String selAir = request.getParameter("selAir");
		String selHotel = request.getParameter("selHotel");
		String selRentcar = request.getParameter("selRentcar");
		
		if(sessionParam != null){
			if(sessionParam.get("mbrCustno") != null)
				mbrCustno = sessionParam.get("mbrCustno").toString();
			if(sessionParam.get("cno") != null)
				cno = sessionParam.get("cno").toString();
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
			if(sessionParam.get("mblNo") != null)
				mblNo = sessionParam.get("mblNo").toString();
			
		}
		//if(seqNo == null || seqNo.equals("")) seqNo = "0";
		
		//if(!seqNo.equals("0")) {
		/*
		if(selAir.equals("Y")){
			RsvAirVO rsvAirParam = new RsvAirVO();
			rsvAirParam.setAirRsvSeqno(Integer.parseInt(seqNo));
			RsvAirVO rsvAirResult =  null;
			
			RsvAirVO rsvAirResult = (RsvAirVO) rsvAirService.selectRsvAir(rsvAirParam);			
		}
		*/
		
		/*
		FitReserveVO reserveVO = new FitReserveVO();
		reserveVO.setFitRsvNo(seqNo);
		*/
		
		//FitReserveVO rsvResult = reserveService.selectFreeReserve(reserveVO);
				
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("email", email);
		model.addAttribute("age", age);
		model.addAttribute("id", id);		
		model.addAttribute("sex", sex);
		model.addAttribute("birthday", birthday);
		model.addAttribute("custGradeCd", custGradeCd);
		
		model.addAttribute("selAir", selAir);
		model.addAttribute("selHotel", selHotel);
		model.addAttribute("selRentcar", selRentcar);
		
		//model.addAttribute("rsvResult", rsvResult);
		//model.addAttribute("rsvAirResult", rsvAirResult);
		
		//L.pay??? ???????????? setting [???????????????(cno), ???????????????, ?????????(knm)]
		model.addAttribute("telno", mblNo.replace("-", ""));
		
		model.addAttribute("mbrCustno", mbrCustno);
		
		if("1101933961".equals(cno) ){
			model.addAttribute("cno", "1100020340");
		}else{
			model.addAttribute("cno", cno);
		}
		
		Timestamp tsmp	=	new Timestamp(System.currentTimeMillis());
		
		String M_TX_NUM	=	String.valueOf(tsmp);

		M_TX_NUM =  M_TX_NUM.replaceAll("-", "");
		M_TX_NUM =  M_TX_NUM.replaceAll(" ", "");
		M_TX_NUM =  M_TX_NUM.replaceAll(":", "");
		M_TX_NUM =  M_TX_NUM.replaceAll("\\.", "");
		System.out.println("M_TX_NUM:" + M_TX_NUM);
		model.addAttribute("M_TX_NUM", "P" + M_TX_NUM);
		
		return _rootPath+"/pay_free";
	}
	
	// <!--  ????????? ????????? ??????    -->
	@RequestMapping(value = "/account/getPayPriceAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String getPayPriceAjax(@RequestParam("price") String price, @RequestParam("type") String type, HttpServletRequest request, ModelMap model)throws Exception{
		if(price == null || price.equals("")) price = "0";
		
		PaymentVO paymentVo = lpointService.requestPayment(price, type);
		model.addAttribute("paymentVo", paymentVo);
		
		return "jsonView";		
	}

	// <!--  ????????? ????????? ??????    -->
	@RequestMapping(value = "/account/getAirPayAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String getAirPayAjax(@RequestParam("price") String price, HttpServletRequest request, ModelMap model)throws Exception{
		if(price == null || price.equals("")) price = "0";
		
		PaymentVO paymentVo = lpointService.requestAirPay(price);
		model.addAttribute("paymentVo", paymentVo);
		
		return "jsonView";		
	}

	/**
	 * ?????? ?????? ??????/??????
	 * @return
	 */
	@RequestMapping(value = "/account/listComCdAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String listComCdAjax(@RequestParam("grpCd") String grpCd, HttpServletRequest request, Model model) {
		CommCdVO param = new CommCdVO();
		param.setGrpCd(grpCd);
		
		List<CommCdVO> cdList = null;
		
		try {
			cdList = commCdService.CommCdList(param);
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.print("???????????? ??????!");
		}

        model.addAttribute("commCdList" , cdList );
        model.addAttribute("grpCd" , param.getGrpCd() );	// ????????? ?????? ??????
		
		return "jsonview";
	}	
	
	@RequestMapping(value = "/account/pay_end.do", method = RequestMethod.GET )
	public String pay_end(@RequestParam("seqNo") String seqNo, HttpServletRequest request, Model model) throws Exception {
	    
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

		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("email", email);
		model.addAttribute("age", age);
		model.addAttribute("id", id);		
		model.addAttribute("sex", sex);
		model.addAttribute("birthday", birthday);
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("rsvSeqNo", seqNo);
		
		return _rootPath+"/pay_end";
	}
	
	@RequestMapping(value = "/account/free_info_detail.do", method = RequestMethod.GET )
	public String free_info_detail(@RequestParam("seqNo") String seqNo, HttpServletRequest request, Model model) throws Exception {
		FitReserveVO reserveVO = new FitReserveVO();
		reserveVO.setFitRsvNo(seqNo);
		
		FitReserveVO rsvResult = reserveService.selectFreeReserve(reserveVO);
		
		model.addAttribute("rsvResult", rsvResult);
		model.addAttribute("fitRsvNo", seqNo);
		
		return _rootPath+"/free_info_detail";
	}
	
	@RequestMapping(value = "/account/pop_air_pay.do", method = RequestMethod.GET )
	public String pop_air_pay(@RequestParam("seqNo") String seqNo, HttpServletRequest request, Model model) throws Exception {
	    
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

		FitReserveVO reserveVO = new FitReserveVO();
		reserveVO.setFitRsvNo(seqNo);
		
		FitReserveVO rsvFit = reserveService.selectFreeReserve(reserveVO);
		
		RsvAirVO rsvAirParam = new RsvAirVO();
		rsvAirParam.setAirRsvSeqno(Integer.parseInt(rsvFit.getAirRsvSeqno()));
		
		RsvAirVO rsvAir = null;
		if(!rsvFit.getAirRsvSeqno().equals("0")) {		
			rsvAir = (RsvAirVO) rsvAirService.selectRsvAir(rsvAirParam);
		} else {
			rsvAir = new RsvAirVO();
		}
		
		RsvAirPaxVO rsvAirPaxParam = new RsvAirPaxVO();		
		rsvAirPaxParam.setAirRsvSeqNo(Integer.parseInt(rsvFit.getAirRsvSeqno()));
		List rsvAirPaxList =  null;
		
		if(!rsvFit.getAirRsvSeqno().equals("0")) {
			rsvAirPaxList = (List) rsvAirService.selectRsvAirPaxList(rsvAirPaxParam);
		} else {
			rsvAirPaxList = new ArrayList<RsvAirPaxVO>();
		}
		
		
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("email", email);
		model.addAttribute("age", age);
		model.addAttribute("id", id);		
		model.addAttribute("sex", sex);
		model.addAttribute("birthday", birthday);
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("rsvSeqNo", seqNo);
		model.addAttribute("rsvFit", rsvFit);
		model.addAttribute("rsvAir", rsvAir);
		model.addAttribute("rsvAirPaxList", rsvAirPaxList);
		
		model.addAttribute("resCd", rsvFit.getAirRsvSeqno());

		return _rootPath+"/pop_air_pay";
	}
	
	@RequestMapping(value = "/account/pop_air_passport.do", method = RequestMethod.GET )
	public String pop_air_passport(@RequestParam("seqNo") String seqNo, HttpServletRequest request, Model model) throws Exception {
	    
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

		FitReserveVO reserveVO = new FitReserveVO();
		reserveVO.setFitRsvNo(seqNo);
		
		FitReserveVO rsvFit = reserveService.selectFreeReserve(reserveVO);
		
		RsvAirVO rsvAirParam = new RsvAirVO();
		rsvAirParam.setAirRsvSeqno(Integer.parseInt(rsvFit.getAirRsvSeqno()));
		
		RsvAirVO rsvAir = null;
		if(!rsvFit.getAirRsvSeqno().equals("0")) {		
			rsvAir = (RsvAirVO) rsvAirService.selectRsvAir(rsvAirParam);
		} else {
			rsvAir = new RsvAirVO();
		}
		
		RsvAirPaxVO rsvAirPaxParam = new RsvAirPaxVO();		
		rsvAirPaxParam.setAirRsvSeqNo(Integer.parseInt(rsvFit.getAirRsvSeqno()));
		List rsvAirPaxList =  null;
		
		if(!rsvFit.getAirRsvSeqno().equals("0")) {
			rsvAirPaxList = (List) rsvAirService.selectRsvAirPaxList(rsvAirPaxParam);
		} else {
			rsvAirPaxList = new ArrayList<RsvAirPaxVO>();
		}
		
		
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("email", email);
		model.addAttribute("age", age);
		model.addAttribute("id", id);		
		model.addAttribute("sex", sex);
		model.addAttribute("birthday", birthday);
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("rsvSeqNo", seqNo);
		model.addAttribute("rsvFit", rsvFit);
		model.addAttribute("rsvAir", rsvAir);
		model.addAttribute("rsvAirPaxList", rsvAirPaxList);
		
		model.addAttribute("resCd", rsvFit.getAirRsvSeqno());

		return _rootPath+"/pop_air_passport";
	}
		
	@RequestMapping(value = "/account/pop_paycancel.do", method = RequestMethod.GET )
	public String pop_paycancel(@RequestParam("seqNo") String seqNo, HttpServletRequest request, Model model) throws Exception {
	    
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



		
		
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("email", email);
		model.addAttribute("age", age);
		model.addAttribute("id", id);		
		model.addAttribute("sex", sex);
		model.addAttribute("birthday", birthday);
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("rsvSeqNo", seqNo);


		return _rootPath+"/pop_paycancel";
	}
	
	// <!--  ?????? ?????????  ??????    -->
	@RequestMapping(value = "/account/srchFreeRsvAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String srchFreeRsvAjax(@RequestParam("seqNo") String seqNo, HttpServletRequest request, ModelMap model)throws Exception{
		// -------------------------------------------------------------------
		// ???????????? ?????? ????????? 
		// -------------------------------------------------------------------
		
		HashMap<String, List> list = reserveService.freeReserve(seqNo);
		
		model.addAttribute("list", list);
		
		return "jsonView";		
	}
	
	// <!--  ?????? ?????????  ??????    -->
	@RequestMapping(value = "/account/srchRsvAirAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String srchRsvAirAjax(@RequestParam("seqNo") String seqNo, HttpServletRequest request, ModelMap model)throws Exception{
		if(seqNo == null || seqNo.equals("")) seqNo = "0";
		
		RsvAirVO rsvAirParam = new RsvAirVO();
		rsvAirParam.setAirRsvSeqno(Integer.parseInt(seqNo));
		
		RsvAirVO rsvAir = null;
			
		rsvAir = (RsvAirVO) rsvAirService.selectRsvAir(rsvAirParam);
		
		model.addAttribute("rsvAir", rsvAir);
		
		return "jsonView";		
	}
	
	// <!--  ????????? ????????? ??????    -->
	@RequestMapping(value = "/account/srchRsvAirPaxListAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String srchRsvAirPaxListAjax(@RequestParam("seqNo") String seqNo, HttpServletRequest request, ModelMap model)throws Exception{
		if(seqNo == null || seqNo.equals("")) seqNo = "0";
		
		RsvAirPaxVO rsvAirPaxParam = new RsvAirPaxVO();		
		rsvAirPaxParam.setAirRsvSeqNo(Integer.parseInt(seqNo));
		List rsvAirPaxList =  null;
		
		if(!seqNo.equals("0")) {
			rsvAirPaxList = (List) rsvAirService.selectRsvAirPaxList(rsvAirPaxParam);
		}
		
		model.addAttribute("rsvAirPaxList", rsvAirPaxList);
		
		return "jsonView";		
	}
	
	// <!--  ?????? ?????? ?????? ??????  ??????    -->
	@RequestMapping(value = "/account/srchRsvAirItinListAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String srchRsvAirItinListAjax(@RequestParam("seqNo") String seqNo, HttpServletRequest request, ModelMap model)throws Exception{
		if(seqNo == null || seqNo.equals("")) seqNo = "0";
		
		RsvAirItinVO rsvAirItinParam = new RsvAirItinVO();		
		rsvAirItinParam.setAirRsvSeqno(Integer.parseInt(seqNo));
		List rsvAirItinList =  null;
		
		if(!seqNo.equals("0")) {
			rsvAirItinList = (List) rsvAirService.selectRsvAirItinList(rsvAirItinParam);
		}
		
		model.addAttribute("rsvAirItinList", rsvAirItinList);
		
		return "jsonView";		
	}
	// ?????? ?????? ?????? ?????? 
	@RequestMapping(value = "/account/srchRsvAirPaymentAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String srchRsvAirPaymentAjax(@RequestParam("fitRsvNo") String fitRsvNo, HttpServletRequest request, ModelMap model)throws Exception{

		List<AirPaymentVO> airPaymentList = null;
			
		airPaymentList = (List<AirPaymentVO>) airPaymtService.selectAirPayment(fitRsvNo);
		
		model.addAttribute("paymentList", airPaymentList);
		
		return "jsonView";		
	}
	
	// <!-- ?????? ???????????? > ?????? ?????? ?????? ??????    -->
	@RequestMapping(value = "/account/saveAirRsvPaymentAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String saveAirRsvPaymentAjax(@ModelAttribute AirRsvPaymtVO reqVO,  HttpServletRequest request, ModelMap model)throws Exception{

		System.out.println("saveAirRsvPaymentAjax !!!!! ");
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
		
		reqVO.setREGTOR_ID(custCd);
		reqVO.setMODTOR_ID(custCd);
		airPaymtService.saveAirRsvPaymt(reqVO);
		
		return "jsonView";		
	}
	
	// <!-- ?????? ???????????? > ?????? ?????? ????????? ?????? ??????    -->
	@RequestMapping(value = "/account/saveAirActPaymentAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String saveAirActPaymentAjax(@ModelAttribute AirActPaymtVO reqVO,  HttpServletRequest request, ModelMap model)throws Exception{

		System.out.println("saveAirActPaymentAjax !!!!! ");
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
		
		reqVO.setREGTOR_ID(custCd);
		reqVO.setMODTOR_ID(custCd);
		
		airPaymtService.saveAirActPaymt(reqVO);
		airPaymtService.updateAirRsvMst(reqVO.getAIR_RSV_SEQNO());
		
		return "jsonView";		
	}
	
	// <!-- ?????? ???????????? > ?????? ?????? ????????? ?????? ??????    -->
	@RequestMapping(value = "/account/saveAirCardPaymentAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String saveAirCardPaymentAjax(@ModelAttribute AirCardPaymtVO reqVO,  HttpServletRequest request, ModelMap model)throws Exception{

		System.out.println("saveAirCardPaymentAjax !!!!! ");
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
		
		reqVO.setREGTOR_ID(custCd);
		reqVO.setMODTOR_ID(custCd);
		airPaymtService.saveAirCardPaymt(reqVO);
		airPaymtService.updateAirRsvMst(reqVO.getAIR_RSV_SEQNO());
		return "jsonView";		
	}
	
	// <!-- ?????? ???????????? > ?????? ?????? ???????????? ?????? ??????    -->
	@RequestMapping(value = "/account/saveAirEtcPaymentAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String saveAirEtcPaymentAjax(@ModelAttribute AirEtcPaymtVO reqVO,  HttpServletRequest request, ModelMap model)throws Exception{

		System.out.println("saveAirEtcPaymentAjax !!!!! ");
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
		
		reqVO.setREGTOR_ID(custCd);
		reqVO.setMODTOR_ID(custCd);
		airPaymtService.saveAirEtcPaymt(reqVO);
		airPaymtService.updateAirRsvMst(reqVO.getAIR_RSV_SEQNO());
		return "jsonView";		
	}
	
	// <!-- ?????? ???????????? > ?????? ?????? ????????? ?????? ?????? ??????    -->
	@RequestMapping(value = "/account/saveAirGiftPaymentAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String saveAirGiftPaymentAjax(@RequestParam("giftSeq") String giftSeq,   HttpServletRequest request, ModelMap model)throws Exception{

		System.out.println("saveAirGiftPaymentAjax !!!!! ");
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
		
		List<AirGiftPaymtVO> giftList = new ArrayList<AirGiftPaymtVO>();
		
		if(giftSeq == null || giftSeq.equals(""))  giftSeq = "0";
		int nGiftSeq = Integer.parseInt(giftSeq);
		
		AirGiftPaymtVO reqVO = new AirGiftPaymtVO();
		
		String AIR_RSV_SEQNO = (String) request.getParameter("AIR_RSV_SEQNO");
		
		reqVO.setAIR_RSV_SEQNO(Integer.parseInt(AIR_RSV_SEQNO));
		
		String GIFT_DIVI_GB = "";
		String GIFT_AMT =  "";
		String GIFT_NO = "";
		String GIFT_RECP_YN = "";
		
		if(nGiftSeq > 0) {
			GIFT_DIVI_GB = (String) request.getParameter("GIFT_DIVI_GB1");
			GIFT_AMT = (String) request.getParameter("GIFT_AMT1");
			GIFT_NO = (String) request.getParameter("GIFT_NO1");
			GIFT_RECP_YN = (String) request.getParameter("GIFT_RECP_YN1");
			
			reqVO.setGIFT_DIVI_GB(GIFT_DIVI_GB);
			reqVO.setGIFT_AMT(Integer.parseInt(GIFT_AMT));
			reqVO.setGIFT_NO(GIFT_NO);
			reqVO.setGIFT_RECP_YN(GIFT_RECP_YN);
			
		}
		reqVO.setREGTOR_ID(custCd);
		reqVO.setMODTOR_ID(custCd);
		
		giftList.add(reqVO);
		
		
		if(nGiftSeq > 1) {
			GIFT_DIVI_GB = (String) request.getParameter("GIFT_DIVI_GB2");
			GIFT_AMT = (String) request.getParameter("GIFT_AMT2");
			GIFT_NO = (String) request.getParameter("GIFT_NO2");
			GIFT_RECP_YN = (String) request.getParameter("GIFT_RECP_YN2");
			
			reqVO.setGIFT_DIVI_GB(GIFT_DIVI_GB);
			reqVO.setGIFT_AMT(Integer.parseInt(GIFT_AMT));
			reqVO.setGIFT_NO(GIFT_NO);
			reqVO.setGIFT_RECP_YN(GIFT_RECP_YN);
			
		}
		reqVO.setREGTOR_ID(custCd);
		reqVO.setMODTOR_ID(custCd);
		
		giftList.add(reqVO);

		if(nGiftSeq > 2) {
			GIFT_DIVI_GB = (String) request.getParameter("GIFT_DIVI_GB3");
			GIFT_AMT = (String) request.getParameter("GIFT_AMT3");
			GIFT_NO = (String) request.getParameter("GIFT_NO3");
			GIFT_RECP_YN = (String) request.getParameter("GIFT_RECP_YN3");
			
			reqVO.setGIFT_DIVI_GB(GIFT_DIVI_GB);
			reqVO.setGIFT_AMT(Integer.parseInt(GIFT_AMT));
			reqVO.setGIFT_NO(GIFT_NO);
			reqVO.setGIFT_RECP_YN(GIFT_RECP_YN);
			
		}
		reqVO.setREGTOR_ID(custCd);
		reqVO.setMODTOR_ID(custCd);
		giftList.add(reqVO);
		
		if(nGiftSeq > 3) {
			GIFT_DIVI_GB = (String) request.getParameter("GIFT_DIVI_GB4");
			GIFT_AMT = (String) request.getParameter("GIFT_AMT4");
			GIFT_NO = (String) request.getParameter("GIFT_NO4");
			GIFT_RECP_YN = (String) request.getParameter("GIFT_RECP_YN4");
			
			reqVO.setGIFT_DIVI_GB(GIFT_DIVI_GB);
			reqVO.setGIFT_AMT(Integer.parseInt(GIFT_AMT));
			reqVO.setGIFT_NO(GIFT_NO);
			reqVO.setGIFT_RECP_YN(GIFT_RECP_YN);
			
		}
		reqVO.setREGTOR_ID(custCd);
		reqVO.setMODTOR_ID(custCd);
		giftList.add(reqVO);
		

		if(nGiftSeq > 4) {
			GIFT_DIVI_GB = (String) request.getParameter("GIFT_DIVI_GB5");
			GIFT_AMT = (String) request.getParameter("GIFT_AMT5");
			GIFT_NO = (String) request.getParameter("GIFT_NO5");
			GIFT_RECP_YN = (String) request.getParameter("GIFT_RECP_YN5");
			
			reqVO.setGIFT_DIVI_GB(GIFT_DIVI_GB);
			reqVO.setGIFT_AMT(Integer.parseInt(GIFT_AMT));
			reqVO.setGIFT_NO(GIFT_NO);
			reqVO.setGIFT_RECP_YN(GIFT_RECP_YN);
			
		}
		reqVO.setREGTOR_ID(custCd);
		reqVO.setMODTOR_ID(custCd);
		giftList.add(reqVO);

		
		if(nGiftSeq > 5) {
			GIFT_DIVI_GB = (String) request.getParameter("GIFT_DIVI_GB6");
			GIFT_AMT = (String) request.getParameter("GIFT_AMT6");
			GIFT_NO = (String) request.getParameter("GIFT_NO6");
			GIFT_RECP_YN = (String) request.getParameter("GIFT_RECP_YN6");
			
			reqVO.setGIFT_DIVI_GB(GIFT_DIVI_GB);
			reqVO.setGIFT_AMT(Integer.parseInt(GIFT_AMT));
			reqVO.setGIFT_NO(GIFT_NO);
			reqVO.setGIFT_RECP_YN(GIFT_RECP_YN);
			
		}
		reqVO.setREGTOR_ID(custCd);
		reqVO.setMODTOR_ID(custCd);
		giftList.add(reqVO);
		
		
		if(nGiftSeq > 6) {
			GIFT_DIVI_GB = (String) request.getParameter("GIFT_DIVI_GB7");
			GIFT_AMT = (String) request.getParameter("GIFT_AMT7");
			GIFT_NO = (String) request.getParameter("GIFT_NO7");
			GIFT_RECP_YN = (String) request.getParameter("GIFT_RECP_YN7");
			
			reqVO.setGIFT_DIVI_GB(GIFT_DIVI_GB);
			reqVO.setGIFT_AMT(Integer.parseInt(GIFT_AMT));
			reqVO.setGIFT_NO(GIFT_NO);
			reqVO.setGIFT_RECP_YN(GIFT_RECP_YN);
			
		}
		reqVO.setREGTOR_ID(custCd);
		reqVO.setMODTOR_ID(custCd);
		giftList.add(reqVO);

		
		if(nGiftSeq > 7) {
			GIFT_DIVI_GB = (String) request.getParameter("GIFT_DIVI_GB8");
			GIFT_AMT = (String) request.getParameter("GIFT_AMT8");
			GIFT_NO = (String) request.getParameter("GIFT_NO8");
			GIFT_RECP_YN = (String) request.getParameter("GIFT_RECP_YN8");
			
			reqVO.setGIFT_DIVI_GB(GIFT_DIVI_GB);
			reqVO.setGIFT_AMT(Integer.parseInt(GIFT_AMT));
			reqVO.setGIFT_NO(GIFT_NO);
			reqVO.setGIFT_RECP_YN(GIFT_RECP_YN);
			
		}
		reqVO.setREGTOR_ID(custCd);
		reqVO.setMODTOR_ID(custCd);
		giftList.add(reqVO);

		if(nGiftSeq > 8) {
			GIFT_DIVI_GB = (String) request.getParameter("GIFT_DIVI_GB9");
			GIFT_AMT = (String) request.getParameter("GIFT_AMT9");
			GIFT_NO = (String) request.getParameter("GIFT_NO9");
			GIFT_RECP_YN = (String) request.getParameter("GIFT_RECP_YN9");
			
			reqVO.setGIFT_DIVI_GB(GIFT_DIVI_GB);
			reqVO.setGIFT_AMT(Integer.parseInt(GIFT_AMT));
			reqVO.setGIFT_NO(GIFT_NO);
			reqVO.setGIFT_RECP_YN(GIFT_RECP_YN);
			
		}
		reqVO.setREGTOR_ID(custCd);
		reqVO.setMODTOR_ID(custCd);
		giftList.add(reqVO);

		if(nGiftSeq > 9) {
			GIFT_DIVI_GB = (String) request.getParameter("GIFT_DIVI_GB10");
			GIFT_AMT = (String) request.getParameter("GIFT_AMT10");
			GIFT_NO = (String) request.getParameter("GIFT_NO10");
			GIFT_RECP_YN = (String) request.getParameter("GIFT_RECP_YN10");
			
			reqVO.setGIFT_DIVI_GB(GIFT_DIVI_GB);
			reqVO.setGIFT_AMT(Integer.parseInt(GIFT_AMT));
			reqVO.setGIFT_NO(GIFT_NO);
			reqVO.setGIFT_RECP_YN(GIFT_RECP_YN);
			
		}
		reqVO.setREGTOR_ID(custCd);
		reqVO.setMODTOR_ID(custCd);
		giftList.add(reqVO);
		
		
		for(int idx = 0; idx < giftList.size(); idx++) {
			
			reqVO = (AirGiftPaymtVO) giftList.get(idx);
			
			airPaymtService.saveAirGiftPaymt(reqVO);
		
		}
		airPaymtService.updateAirRsvMst(reqVO.getAIR_RSV_SEQNO());
		return "jsonView";		
	}
	
	// <!-- ?????? ???????????? > ?????? ?????? ?????? ????????? ??????  ??????    -->
	@RequestMapping(value = "/account/saveAirReceiptReqAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String saveAirReceiptReqAjax(@ModelAttribute AirReceiptReqVO reqVO,  HttpServletRequest request, ModelMap model)throws Exception{

		System.out.println("saveAirReceiptReqAjax !!!!! ");
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
		
		reqVO.setREGTOR_ID(custCd);
		reqVO.setMODTOR_ID(custCd);
		airPaymtService.saveAirReceiptReq(reqVO);
		
		return "jsonView";		
	}
	
	
	// <!-- ?????? ???????????? > ?????? ?????? ?????? ????????? ??????  ??????    -->
	@RequestMapping(value = "/account/saveAirRefundMgtAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String saveAirRefundMgtAjax(@ModelAttribute AirRefundMgtVO reqVO,  HttpServletRequest request, ModelMap model)throws Exception{

		System.out.println("saveAirRefundMgtAjax !!!!! ");
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
		
		if(custCd == null || custCd.equals("")) custCd = "MOBILEUSER";
		
		reqVO.setRegtorId(custCd);
		reqVO.setModtorId(custCd);
		airPaymtService.saveAirRefundMgt(reqVO);
		
		// --------------------------------------------------------------
		// ???????????? ?????? ?????? ???????????? ?????? ?????? ?????? ???????????? 
		// --------------------------------------------------------------
		airPaymtService.saveUpdateCancelYnAirFitRsvMst(reqVO);
		
		return "jsonView";		
	}
	
	//?????? ?????? ????????????
	@RequestMapping(value = "/account/payCancelReqAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String payCancelReqAjax(@ModelAttribute HtlRefundMgtVO reqVO,  HttpServletRequest request, ModelMap model)throws Exception{
			
			htlPaymtService.updateCancelYnHtlRsvMst(reqVO);
			return "jsonView";		
	}
	
	
	/**
	 * ??????????????? ?????????????????? ???????????? (LPOINT ??????)
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/account/LPointSrcAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String LPointSrcAjax(HttpServletRequest request, Model model) throws Exception {
		System.out.println("======================LPointSrcAjax start================================================");
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String cno		=	"";				//	

		if(sessionParam != null){
			if(sessionParam.containsKey("cno")){
				if(sessionParam.get("cno") != null){
					cno = sessionParam.get("cno").toString();
				}
			}
		}
		LPointVO LPontUseVo	=	lpointService.getLPointAvailable(cno);
		
		model.addAttribute("code", LPontUseVo.getCode());						//????????????
		model.addAttribute("cardNo", LPontUseVo.getCardNum());					//????????????
		model.addAttribute("usePoint", LPontUseVo.getUsePoint_str());			//???????????????
		model.addAttribute("remainPointType", LPontUseVo.getRemainPointType());	//?????????????????????
		model.addAttribute("remainPoint", LPontUseVo.getRemainPoint_str());		//???????????????
		model.addAttribute("message1", LPontUseVo.getMessage1());				//?????????1
		model.addAttribute("message2", LPontUseVo.getMessage2());				//?????????2

		System.out.println("======================LPointSrcAjax end================================================");
		return "jsonview";
	}
	
	
	/**
	 * ??????????????? ?????? ??? ?????????????????? ???????????? (LPOINT ?????? ??? ??????)
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/account/LPointAuthAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String LPointAuthAjax(HttpServletRequest request, Model model) throws Exception {
		System.out.println("======================LPointAuthAjax start================================================");
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String cno		=	"";				//	

		if(sessionParam != null){
			if(sessionParam.containsKey("cno")){
				if(sessionParam.get("cno") != null){
					cno = sessionParam.get("cno").toString();
				}
			}
		}
		
		String cardno	=	request.getParameter("cardNo");
		String pw		=	request.getParameter("PW");
		
		LPointVO LPontUseVo	=	lpointService.getLPointAuth(cno, cardno, pw);
		
		model.addAttribute("code", LPontUseVo.getCode());						//????????????
		model.addAttribute("cardNo", LPontUseVo.getCardNum());					//????????????
		model.addAttribute("custNo", LPontUseVo.getCustNo());					//????????????
		model.addAttribute("apprCd", LPontUseVo.getApprCd());					//????????????
		model.addAttribute("remainPoint", LPontUseVo.getRemainPoint_str());		//???????????????
		model.addAttribute("usePoint", LPontUseVo.getUsePoint_str());			//???????????????
		model.addAttribute("failCnt", LPontUseVo.getFailCnt());					//????????????????????????

		System.out.println("======================LPointAuthAjax end================================================");
		return "jsonview";
	}

	/**
	 * ??????????????? ???????????? (LPOINT ??????)
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/account/LPointUseAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String LPointUseAjax(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String resCd		=	""; 		//	????????????
		String cardNo		=	""; 		//	LPoint????????????
		String wpw			=	""; 		//	LPoint????????????
		String startDay		=	""; 		//	??????????????????
		String lottePoint	=	""; 		//	???????????????
		String pointFg		=	"";			//	?
		String custcd		=	"";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custcd = sessionParam.get("cust_cd").toString();
		}
		
		LPointVO LPontUseVo	=	lpointService.getLPointUse(resCd, cardNo, wpw, startDay, lottePoint, pointFg, custcd);
		
		model.addAttribute("code", LPontUseVo.getCode());									//????????????
		model.addAttribute("getApprNo", LPontUseVo.getApprNo());							//?????????????????????
		model.addAttribute("getUSE_ORG_APPRNO", LPontUseVo.getUSE_ORG_APPRNO());			//?????????????????????
		model.addAttribute("getUSE_ORG_APPRNO_DAY", LPontUseVo.getUSE_ORG_APPRNO_DAY());	//?????????????????????
		model.addAttribute("getUsePoint_str", LPontUseVo.getUsePoint_str());				//???????????????
		model.addAttribute("getRemainPointType", LPontUseVo.getRemainPointType());			//?????????????????????
		model.addAttribute("getRemainPoint_str", LPontUseVo.getRemainPoint_str());			//???????????????
		model.addAttribute("getAffRemainPointType", LPontUseVo.getAffRemainPointType());	//??????????????????????????????
		model.addAttribute("getAffRemainPoint", LPontUseVo.getAffRemainPoint());			//????????? ???????????????
		model.addAttribute("getPOINT_TID", LPontUseVo.getPOINT_TID());						//?????????TID
		model.addAttribute("getCardNum", LPontUseVo.getCardNum());							//????????????

		return "jsonview";
	}	

	
	/**
	 * ??????????????? ???????????? (LPOINT ??????)
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/account/LPointAccumAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String LPointAccumAjax(HttpServletRequest request, Model model) throws Exception {
		System.out.println("======================LPointAccumAjax start================================================");
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String cardNo = "";
		String lottePoint = "";				
		String saleAmt = "";
		String pointFg = "";
		String res_cd	=	"";
		String startDay		=	""; 		//	??????????????????
		String custcd		=	"";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custcd = sessionParam.get("cust_cd").toString();
		}
		
		
		//========================================================================
		//	???????????? ??????setting
		//========================================================================
		res_cd		=	"A170207-1"; 		//	????????????
		cardNo		=	"8710400970377574"; //	LPoint????????????
		startDay	=	"20170607"; 		//	??????????????????
		lottePoint	=	"10"; 				//	???????????????
		saleAmt		=	"100";				//	????????????(????????????)
		pointFg		=	"U";				//	?
		//========================================================================
		
		LPointVO LPontUseVo	=	lpointService.getLPointAccum(res_cd, cardNo, lottePoint, saleAmt, pointFg, startDay, custcd);
		
		model.addAttribute("code", LPontUseVo.getCode());									//????????????
		model.addAttribute("getApprNo", LPontUseVo.getApprNo());							//?????????????????????
		model.addAttribute("getUSE_ORG_APPRNO", LPontUseVo.getUSE_ORG_APPRNO());			//?????????????????????
		model.addAttribute("getUSE_ORG_APPRNO_DAY", LPontUseVo.getUSE_ORG_APPRNO_DAY());	//?????????????????????
		model.addAttribute("getUsePoint_str", LPontUseVo.getUsePoint_str());				//???????????????
		model.addAttribute("getRemainPointType", LPontUseVo.getRemainPointType());			//?????????????????????
		model.addAttribute("getRemainPoint_str", LPontUseVo.getRemainPoint_str());			//???????????????
		model.addAttribute("getAffRemainPointType", LPontUseVo.getAffRemainPointType());	//??????????????????????????????
		model.addAttribute("getAffRemainPoint", LPontUseVo.getAffRemainPoint());			//????????? ???????????????
		model.addAttribute("getPOINT_TID", LPontUseVo.getPOINT_TID());						//?????????TID
		model.addAttribute("getCardNum", LPontUseVo.getCardNum());							//????????????

		return "jsonview";
	}	
	
	/**
	 * ??????jtb ????????? ????????????
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/account/giftcardUseAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String giftcardUseAjax(HttpServletRequest request, Model model) throws Exception {
		System.out.println("======================giftcardUseAjax start================================================");
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String cardNo = "";
		String lottePoint = "";				
		String saleAmt = "";
		String pointFg = "";
		String res_cd	=	"";
		String startDay		=	""; 		//	??????????????????
		String custcd		=	"";
		
		//system.out.println("=============================1");
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custcd = sessionParam.get("cust_cd").toString();
		}
				
		
		return "jsonview";
	}	
	
//	==============================================================================================================================
//	???????????? ?????????	
//	==============================================================================================================================
	
    /**
     * ??????????????? L.POINT ??????
     * 
     * @return
     */
    @RequestMapping(value = "/account/lPointPop.do", method = RequestMethod.GET)
    public String lPointPop(Model model) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
       
        model.addAttribute("toDay", sdf.format(new Date()));
        
        return "/fit/pop/lPointPop";
    }

    /**
     * ?????? ????????????/??????API
     * 
     * @param request HttpServletRequest
     * @param model ?????? ??????
     * @return
     */
    @RequestMapping(value = "/account/paymentReturn.do")
    public String paymentReturn(HttpServletRequest request, Model model) {
        //system.out.println("########## paymentReturn ##########");

        String movePath	=	"/pay_end_reserve";

        try {

    		HttpSession session = request.getSession(true);
    		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
    		
    		String custcd		=	"";
    		String knm			=	"";
    		
    		if(sessionParam != null){
    			if(sessionParam.get("cust_cd") != null)
    				custcd = sessionParam.get("cust_cd").toString();
    			if(sessionParam.get("knm") != null)		//	???????????????
    				knm = sessionParam.get("knm").toString();
    		}

    		//#############################
            // ???????????? ???????????? ?????? ??????
            //#############################
            request.setCharacterEncoding("UTF-8");

            Map<String, String> paramMap = new HashMap<String, String>();

            Enumeration<?> elems = request.getParameterNames();

            String temp = "";

            while(elems.hasMoreElements())
            {
                temp = (String) elems.nextElement();
                paramMap.put(temp, request.getParameter(temp));
            }
            
            paramMap.put("custcd", custcd);
            paramMap.put("buyerName", knm);
            
            //system.out.println("paramMap: " + paramMap.toString());
            
            PaymentVO paymentReturnVo = lpointService.authAndApprPayment(paramMap);

            //system.out.println("result paymentReturnVo: " + paymentReturnVo.toString());
            
            model.addAttribute("paymentReturnVo", paymentReturnVo);
            if(paymentReturnVo != null){
            	model.addAttribute("accountVo", paymentReturnVo.getVacctVo());
                model.addAttribute("rsvSeqNo", paymentReturnVo.getResCd());
            }
            
            if(paymentReturnVo.getVacctVo() != null){
                model.addAttribute("No_vacct", paymentReturnVo.getVacctVo().getNo_vacct());
                model.addAttribute("Nm_input", paymentReturnVo.getVacctVo().getNm_input());
                model.addAttribute("Nm_inputbank", paymentReturnVo.getVacctVo().getNm_inputbank());
            }else{
                model.addAttribute("No_vacct", "");
                model.addAttribute("Nm_input", "");
                model.addAttribute("Nm_inputbank", "");
            }
            model.addAttribute("rsvSeqNo", paymentReturnVo.getResCd());
            
            if(paymentReturnVo.getResCd() == null || "".equals(paymentReturnVo.getResCd())){
            	movePath	=	"/pay_fail_end";
            	throw new Exception("?????? ??????");
            }
            
        } catch(Exception e) {
        	//e.printStackTrace();
        	System.err.print("?????? ??????!");
            movePath	=	"/pay_fail_end";
        }
        
        //return "/payment/INIStdPayReturn";
        
        
        return _rootPath + movePath;               
    }

    /**
     * ?????? ?????? ????????????/??????API
     * 
     * @param request HttpServletRequest
     * @param model ?????? ??????
     * @return
     */
    @RequestMapping(value = "/account/airPayReturn.do")
    public String airPayReturn(HttpServletRequest request, Model model) {
        //system.out.println("########## paymentReturn ##########");

        String movePath	=	"/pay_end_air";

        try {

    		HttpSession session = request.getSession(true);
    		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
    		
    		String custcd		=	"";
    		String knm			=	"";
    		
    		if(sessionParam != null){
    			if(sessionParam.get("cust_cd") != null)
    				custcd = sessionParam.get("cust_cd").toString();
    			if(sessionParam.get("knm") != null)		//	???????????????
    				knm = sessionParam.get("knm").toString();
    		}

    		//#############################
            // ???????????? ???????????? ?????? ??????
            //#############################
            request.setCharacterEncoding("UTF-8");

            Map<String, String> paramMap = new HashMap<String, String>();

            Enumeration<?> elems = request.getParameterNames();

            String temp = "";

            while(elems.hasMoreElements())
            {
                temp = (String) elems.nextElement();
                paramMap.put(temp, request.getParameter(temp));
            }
            
            paramMap.put("custcd", custcd);
            paramMap.put("buyerName", knm);
            
            //system.out.println("paramMap: " + paramMap.toString());
            
            PaymentVO paymentReturnVo = lpointService.authAndApprAirPay(paramMap);
            
            String fitRsvNo = reserveService.getFitRsvNo(paymentReturnVo.getResCd());

            //system.out.println("result paymentReturnVo: " + paymentReturnVo.toString());
            
            model.addAttribute("paymentReturnVo", paymentReturnVo);
            //model.addAttribute("rsvSeqNo", paymentReturnVo.getResCd());
            model.addAttribute("rsvSeqNo", fitRsvNo);
            if(paymentReturnVo.getVacctVo() != null){
                model.addAttribute("No_vacct", paymentReturnVo.getVacctVo().getNo_vacct());
                model.addAttribute("Nm_input", paymentReturnVo.getVacctVo().getNm_input());
                model.addAttribute("Nm_inputbank", paymentReturnVo.getVacctVo().getNm_inputbank());
            }else{
                model.addAttribute("No_vacct", "");
                model.addAttribute("Nm_input", "");
                model.addAttribute("Nm_inputbank", "");
            }
            
            if(paymentReturnVo.getResCd() == null || "".equals(paymentReturnVo.getResCd())){
            	throw new Exception("?????? ??????");
            }
            
        } catch(Exception e) {
        	//e.printStackTrace();
        	System.err.print("?????? ??????!");
            movePath	=	"/pay_fail_end";
        }
        
        //return "/payment/INIStdPayReturn";
        
        
        return _rootPath + movePath;               
    }

    /**
     * ???????????? ????????? ???????????? ??????
     * 
     * @param request HttpServletRequest
     * @param model ?????? ??????
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = "/account/getAccountNo.do")
    public String getAccountNo(HttpServletRequest request, Model model) throws Exception {
    	
		System.out.println("type:VBANK");
    	String oid	=	propertiesService.getString("payment.Vbank.mId") + SignatureUtil.getTimestamp();
    	
    	Map<String, String> merchantData = new HashMap<String, String>();
    	merchantData.put("goodname", (String) request.getParameter("goodName"));
    	merchantData.put("cashPayAmt", (String) request.getParameter("cashPayAmt"));
    	merchantData.put("buyername", (String) request.getParameter("buyername"));
    	merchantData.put("buyertel", (String) request.getParameter("buyertel"));
    	merchantData.put("buyeremail", (String) request.getParameter("buyeremail"));
    	merchantData.put("vcdbank", (String) request.getParameter("vcdbank"));
    	merchantData.put("dtinput", (String) request.getParameter("dtinput"));
    	merchantData.put("oid", oid);
    	merchantData.put("nminput", (String) request.getParameter("nminput"));
    	
    	// ???????????? ??????
		VAcctDepoNotiVO vAcctInfo = lpointService.insertVacct(merchantData);
		
		if(!"00".equals(vAcctInfo.getResultCode()) ){
			throw new Exception("???????????? ?????? ??????");
		}
		
		String ACT_NO 			= vAcctInfo.getNo_vacct();  //'??????_??????';
		String TID_NO 			= vAcctInfo.getNo_tid();  //'TID_??????';
		
        model.addAttribute("ACT_NO", ACT_NO);
        model.addAttribute("TID_NO", TID_NO);
    	
        return "jsonView";
    }

    /**
     * ???????????? ????????? ???????????? ??????
     * 
     * @param request HttpServletRequest
     * @param model ?????? ??????
     * @return
     */
    @RequestMapping(value = "/account/paymentCancel.do")
    public String paymentCancel(HttpServletRequest request, Model model) {
        return _rootPath + "/pay_cancel";
    }
   

    /**
     * ?????? ????????????/??????API
     * 
     * @param request HttpServletRequest
     * @param model ?????? ??????
     * @return
     */
    @RequestMapping(value = "/account/paymentLpayReturn.do")
    public String paymentLpayReturn(HttpServletRequest request, Model model) {
        //system.out.println("########## paymentReturn ##########");

        try {

    		HttpSession session = request.getSession(true);
    		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
    		
    		String custcd		=	"";
    		String knm			=	"";
    		
    		if(sessionParam != null){
    			if(sessionParam.get("cust_cd") != null)
    				custcd = sessionParam.get("cust_cd").toString();
    			if(sessionParam.get("knm") != null)		//	???????????????
    				knm = sessionParam.get("knm").toString();
    		}

    		//#############################
            // ???????????? ???????????? ?????? ??????
            //#############################
            request.setCharacterEncoding("UTF-8");

            Map<String, String> paramMap = new HashMap<String, String>();

            Enumeration<?> elems = request.getParameterNames();

            String temp = "";

            while(elems.hasMoreElements())
            {
                temp = (String) elems.nextElement();
                paramMap.put(temp, request.getParameter(temp));
            }
            
            paramMap.put("custcd", custcd);
            paramMap.put("buyerName", knm);
            
            //system.out.println("paramMap: " + paramMap.toString());
            
            PaymentVO paymentReturnVo = lpointService.lpayPayment(paramMap);

            //system.out.println("result paymentReturnVo: " + paymentReturnVo.toString());
            
            model.addAttribute("paymentReturnVo", paymentReturnVo);
            model.addAttribute("rsvSeqNo", paymentReturnVo.getResCd());
            
        } catch(Exception e) {
        	//e.printStackTrace();
        	System.err.print("?????? ??????!");
        }
        
        //return "/payment/INIStdPayReturn";
        
        
        return _rootPath + "/pay_end";               
    }

	@RequestMapping(value = "/account/pop_hotel_city_select.do", method = RequestMethod.GET )
	public String pop_hotel_city_select(HttpServletRequest request, @RequestParam("availTy") String availTy, @RequestParam("paxNo") String paxNo,  Model model) throws Exception {

		model.addAttribute("availTy", availTy);
		model.addAttribute("paxNo", paxNo);
		
		 return _rootPath + "/pop_hotel_city_select";
	}
	
	// tag?????? ????????? ???????????? ?????????
	private static String getTagValue(String tag, org.w3c.dom.Element eElement) {
	    NodeList nlList = ((org.w3c.dom.Element) eElement).getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null) 
	        return null;
	    return nValue.getNodeValue();
	}
	
	// <!--  ????????? ???????????? ??????    -->
	@RequestMapping(value = "/account/paymentPop.do")
	public String paymentPop(HttpServletRequest request, ModelMap model)throws Exception{
		
		String agentId = "jtbcp";
		String agentPw = "jtbcp2016";		
		String buyerName ="";
		String buyerEmail = "";
		String buyerTel = "";
		
		String price = request.getParameter("price");
		String fitRsvCd = request.getParameter("fitRsvCd");
		String hotelpassData = request.getParameter("hotelpassData");
		
		try{
			
			// parsing??? url ??????(API ??? ????????????)
			String url = "http://hotel2.lottejtb.com/cp/jtb/xmlLotteJTBReserveInfo.asp?agentId=" + agentId + "&agentPw=" + agentPw + "&BKNo=" + fitRsvCd;
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(url);
			
			// root tag 
			doc.getDocumentElement().normalize();
			
			// ????????? tag
			NodeList nList = doc.getElementsByTagName("masterStart");
							
			Node nNode = nList.item(0);
			if(nNode.getNodeType() == Node.ELEMENT_NODE){
				
				org.w3c.dom.Element eElement = (org.w3c.dom.Element) nNode;					
				buyerName = getTagValue("memName", eElement);
				buyerEmail = getTagValue("CustEmail", eElement);
				buyerTel = getTagValue("CustCellphone", eElement);
			}
		
		} catch (Exception e){	
			e.printStackTrace();
		}
		
		PaymentVO paymentVo = lpointService.requestPayments(price);
		
		model.addAttribute("fitRsvNo", fitRsvCd);
		model.addAttribute("price", price);
		model.addAttribute("hotelpassData", hotelpassData);
		model.addAttribute("buyerEmail", buyerEmail);
		model.addAttribute("buyerTel", buyerTel);
		model.addAttribute("buyerName", buyerName);
	
		model.addAttribute("mId", paymentVo.getmId());
		model.addAttribute("oId", paymentVo.getoId());
		
		return _rootPath + "/paymentPop";
	}
	
    /**
     * ?????? ????????????/??????API
     * 
     * @param request HttpServletRequest
     * @param model ?????? ??????
     * @return
     */
    @RequestMapping(value = "/account/paymentReturns.do")
    public String paymentReturns(HttpServletRequest request, Model model) {
        System.out.println("########## paymentReturns ##########");
    	
        String movePath	=	"/paymentPop_end";

        try {

    		//#############################
            // ???????????? ???????????? ?????? ??????
            //#############################
            request.setCharacterEncoding("UTF-8");

            Map<String, String> paramMap = new HashMap<String, String>();

            Enumeration<?> elems = request.getParameterNames();

            String temp = "";

            while(elems.hasMoreElements())
            {
                temp = (String) elems.nextElement();
                paramMap.put(temp, request.getParameter(temp));
            }
            
            logger.debug("paramMap: {}", paramMap.toString());
            
            PaymentVO paymentReturnVo = lpointService.authAndApprPayments(paramMap);
            
            model.addAttribute("paymentReturnVo", paymentReturnVo);
            if(paymentReturnVo != null){
            	model.addAttribute("accountVo", paymentReturnVo.getVacctVo());
                model.addAttribute("rsvSeqNo", paymentReturnVo.getResCd());
                model.addAttribute("hotelpassData", paymentReturnVo.getHotelpassData());
                model.addAttribute("resultCode", paymentReturnVo.getResultCode());
                model.addAttribute("price", paymentReturnVo.getPrice());
                model.addAttribute("cardCode", paymentReturnVo.getIniCardCode());
                model.addAttribute("resultTid", paymentReturnVo.gettId());                
            }
            model.addAttribute("No_vacct", "");
            model.addAttribute("Nm_input", "");
            model.addAttribute("Nm_inputbank", "");
            
            if(paymentReturnVo.getResCd() == null || "".equals(paymentReturnVo.getResCd())){
            	movePath	=	"/pay_fail_end";
            	throw new Exception("?????? ??????");
            }
            
        } catch(Exception e) {
        	//e.printStackTrace();
        	System.err.print("?????? ??????!");
            movePath	=	"/pay_fail_end";
        }        
        
        return _rootPath + movePath;               
    }
    
}
