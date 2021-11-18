package com.lottejtb.reserve.web;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.ehcache.Ehcache;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.lottejtb.comm.service.CommFileService;
import com.lottejtb.comm.util.CommInfo;
import com.lottejtb.front.air.service.RsvAirService;
import com.lottejtb.front.air.service.RsvAirVO;
import com.lottejtb.main.service.MainService;
import com.lottejtb.sso.service.LoginService;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class FreeReserveController {

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
    @Resource(name = "ehcache")
    Ehcache ehcache;
	
	@Resource(name = "MainService")
	private MainService mainService;

	@Resource(name = "LoginService")
	private LoginService loginService;	
    
	@Resource(name = "CommFileService")
    private CommFileService fileService;

	@Resource(name = "RsvAirService")
	private RsvAirService rsvAirService;
	
	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/free_reserve";
	

	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause_txt1.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause_txt1(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause_txt1";
	}
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause_txt1_1.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause_txt1_1(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause_txt1_1";
	}	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause_txt2.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause_txt2(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause_txt2";
	}	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause_txt3.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause_txt3(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause_txt3";
	}
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause_txt4.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause_txt4(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause_txt4";
	}
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause_txt5.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause_txt5(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause_txt5";
	}	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause_txt6.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause_txt6(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause_txt6";
	}	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause_txt7.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause_txt7(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause_txt7";
	}		
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause_txt8.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause_txt8(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause_txt8";
	}	
	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause2_txt1.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause2_txt1(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause2_txt1";
	}	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause2_txt2.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause2_txt2(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause2_txt2";
	}	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause2_txt3.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause2_txt3(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause2_txt3";
	}	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause2_txt4.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause2_txt4(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause2_txt4";
	}	
	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause3_txt1.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause3_txt1(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause3_txt1";
	}	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause3_txt2.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause3_txt2(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause3_txt2";
	}		
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause3_txt3.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause3_txt3(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause3_txt3";
	}	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause3_txt4.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause3_txt4(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause3_txt4";
	}	
	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause3_txt5.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause3_txt5(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause3_txt5";
	}
	
	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/free_reserve/reserve_clause4_txt1.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause4_txt1(ModelMap model)throws Exception {
		
		return _rootPath+"/reserve_clause4_txt1";
	}	
	
	@RequestMapping(value = "/free_reserve/reserve_info_step1.do", method = RequestMethod.GET )
	public String reserve_info_step1(HttpServletRequest request, Model model) throws Exception {
	    
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
		
		//String ssnId = "0001354597";
		String ssnId = custCd;
		String custChk = loginService.checkCustCdChk(ssnId);
		
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("sex", sex);
		model.addAttribute("id", id);
		model.addAttribute("email", email);		
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("birthday", birthday);
		model.addAttribute("custChk", custChk);
		
		String selAir = (String) request.getParameter("selAir");
		String selHotel = (String) request.getParameter("selHotel");
		String selRentcar = (String) request.getParameter("selRentcar");
		
		System.out.println("selAir : " + selAir);
		System.out.println("selHotel : " + selHotel);
		System.out.println("selRentcar : " + selRentcar);
		
		if(selAir == null || selAir.equals("")) selAir = "N";
		if(selHotel == null || selHotel.equals("")) selHotel = "N";
		if(selRentcar == null || selRentcar.equals("")) selRentcar = "N";
		
		model.addAttribute("selAir", selAir);
		model.addAttribute("selHotel", selHotel);
		model.addAttribute("selRentcar", selRentcar);
		
		return _rootPath + "/reserve_info_step1";
	}

	@RequestMapping(value = "/free_reserve/reserve_agree_step2.do", method = RequestMethod.GET )
	public String reserve_agree_step2(HttpServletRequest request, Model model) throws Exception {
	    
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
		model.addAttribute("sex", sex);
		model.addAttribute("id", id);
		model.addAttribute("email", email);		
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("birthday", birthday);		

		String selAir = (String) request.getParameter("selAir");
		String selHotel = (String) request.getParameter("selHotel");
		String selRentcar = (String) request.getParameter("selRentcar");
		
		System.out.println("selAir : " + selAir);
		System.out.println("selHotel : " + selHotel);
		System.out.println("selRentcar : " + selRentcar);
		
		if(selAir == null || selAir.equals("")) selAir = "N";
		if(selHotel == null || selHotel.equals("")) selHotel = "N";
		if(selRentcar == null || selRentcar.equals("")) selRentcar = "N";
		
		model.addAttribute("selAir", selAir);
		model.addAttribute("selHotel", selHotel);
		model.addAttribute("selRentcar", selRentcar);		
		return _rootPath + "/reserve_agree_step2";
	}
	
	@RequestMapping(value = "/free_reserve/reserve_dp_step3.do", method = RequestMethod.GET )
	public String reserve_dp_step3(HttpServletRequest request, Model model) throws Exception {
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
		model.addAttribute("sex", sex);
		model.addAttribute("id", id);
		model.addAttribute("email", email);		
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("birthday", birthday);		

		String selAir = (String) request.getParameter("selAir");
		String selHotel = (String) request.getParameter("selHotel");
		String selRentcar = (String) request.getParameter("selRentcar");
		
		System.out.println("selAir : " + selAir);
		System.out.println("selHotel : " + selHotel);
		System.out.println("selRentcar : " + selRentcar);
		
		if(selAir == null || selAir.equals("")) selAir = "N";
		if(selHotel == null || selHotel.equals("")) selHotel = "N";
		if(selRentcar == null || selRentcar.equals("")) selRentcar = "N";
		
		model.addAttribute("selAir", selAir);
		model.addAttribute("selHotel", selHotel);
		model.addAttribute("selRentcar", selRentcar);		
		return _rootPath + "/reserve_dp_step3";
	}
	
	@RequestMapping(value = "/free_reserve/reserve_travelers_step4.do", method = RequestMethod.GET )
	public String reserve_travelers_step4(HttpServletRequest request, Model model) throws Exception {
	    
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
		model.addAttribute("sex", sex);
		model.addAttribute("id", id);
		model.addAttribute("email", email);		
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("birthday", birthday);		

		String selAir = (String) request.getParameter("selAir");
		String selHotel = (String) request.getParameter("selHotel");
		String selRentcar = (String) request.getParameter("selRentcar");
		
		System.out.println("selAir : " + selAir);
		System.out.println("selHotel : " + selHotel);
		System.out.println("selRentcar : " + selRentcar);
		
		if(selAir == null || selAir.equals("")) selAir = "N";
		if(selHotel == null || selHotel.equals("")) selHotel = "N";
		if(selRentcar == null || selRentcar.equals("")) selRentcar = "N";
		
		model.addAttribute("selAir", selAir);
		model.addAttribute("selHotel", selHotel);
		model.addAttribute("selRentcar", selRentcar);
		
		return _rootPath + "/reserve_travelers_step4";
	}
	
	@RequestMapping(value = "/free_reserve/reserve_append_step5.do", method = RequestMethod.GET )
	public String reserve_append_step5(HttpServletRequest request, Model model) throws Exception {
	    
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
		model.addAttribute("sex", sex);
		model.addAttribute("id", id);
		model.addAttribute("email", email);		
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("birthday", birthday);		

		String selAir = (String) request.getParameter("selAir");
		String selHotel = (String) request.getParameter("selHotel");
		String selRentcar = (String) request.getParameter("selRentcar");
		String rsvSeqno = (String) request.getParameter("rsvSeqno");
		
		
		if(rsvSeqno == null || rsvSeqno.equals("")) rsvSeqno = "0";
		
		/*
		RsvAirVO rsvAirParam = new RsvAirVO();		
		rsvAirParam.setAirRsvSeqno(Integer.parseInt(rsvSeqno));
		RsvAirVO rsvAirResult =  null;
		
		if(!rsvSeqno.equals("0")) {
			rsvAirResult = (RsvAirVO) rsvAirService.selectRsvAir(rsvAirParam);
		}
		
		*/
		System.out.println("selAir : " + selAir);
		System.out.println("selHotel : " + selHotel);
		System.out.println("selRentcar : " + selRentcar);
		System.out.println("rsvSeqno : " + rsvSeqno);
		
		if(selAir == null || selAir.equals("")) selAir = "N";
		if(selHotel == null || selHotel.equals("")) selHotel = "N";
		if(selRentcar == null || selRentcar.equals("")) selRentcar = "N";
		
		model.addAttribute("selAir", selAir);
		model.addAttribute("selHotel", selHotel);
		model.addAttribute("selRentcar", selRentcar);
		model.addAttribute("fitRsvNo", rsvSeqno);
		
		//model.addAttribute("rsvAirResult", rsvAirResult);
		
		return _rootPath + "/reserve_append_step5";
	}

	@RequestMapping(value = "/free_reserve/reserve_info_detail.do", method = RequestMethod.GET )
	public String reserve_info_detail(HttpServletRequest request, Model model) throws Exception {

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
		model.addAttribute("sex", sex);
		model.addAttribute("id", id);
		model.addAttribute("email", email);		
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("birthday", birthday);		
		
		
		return _rootPath + "/reserve_info_detail";
	}
}
