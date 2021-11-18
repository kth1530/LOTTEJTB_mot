package com.lottejtb.sso.web;

import java.io.FileInputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.ehcache.Ehcache;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springmodules.validation.commons.DefaultBeanValidator;

import Decoder.BASE64Decoder;

import com.lotte.member.bean.ctm.secure.Seedx;
import com.lottejtb.comm.util.CommInfo;
import com.lottejtb.mytour.topass.net.TopassReserveUtil;
import com.lottejtb.sso.service.CookieInfoVO;
import com.lottejtb.sso.service.LoginService;
import com.lottejtb.sso.service.LoginVO;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
//#################################################################
//-----------------------------------------------------------------
//파일명 : LoginController.java
//설 명   : Login Controller   
//작성자 : kkm 
//작성일자 : 2016.11.11
//-----------------------------------------------------------------
//#################################################################
**/

@Controller
public class LoginController {

	//private static final String RETURN_URL = "http://localhost:8080";
	@Resource(name="LoginService")
	protected LoginService loginService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
    @Resource(name = "ehcache")
    Ehcache ehcache;
    
	
	@Resource(name = "CommInfo")
	CommInfo commInfo;
	
	private String returnUrl = "";
	
	//loginProcess
	@RequestMapping(value = "/sso/loginProcess.do",method={RequestMethod.GET, RequestMethod.POST})
	public String loginProcess(HttpServletRequest request,  Model model) throws Exception {
		
//		String coptoken = URLEncoder.encode((String)request.getParameter("copToken"), "UTF-8");
//		String copcls = (String)(request.getParameter("copCls"));
//		
//		System.out.println(">>loginProcess [copToken]=" + coptoken);
//		System.out.println(">>loginProcess [copCls]=" + copcls);
//		
//		model.addAttribute("copToken", coptoken);
//		model.addAttribute("copCls", copcls);

		
		return "/sso/loginProcess";
	}
	
	//loginProcess
	@RequestMapping(value = "/sso/loginProcess_test.do",method={RequestMethod.GET, RequestMethod.POST})
	public String loginProcess_test(HttpServletRequest request,  Model model) throws Exception {
		System.out.println("loginProcess");
		
		return "/sso/loginProcessTest";
	}
	
	@RequestMapping(value = "/jsp/sso/loginSuccess.do",method={RequestMethod.GET, RequestMethod.POST})
	public String loginSuccess(@ModelAttribute("CookieInfoVO") CookieInfoVO vo, HttpServletRequest request,  Model model) throws Exception {
		
		//String onlcno    = request.getParameter("onlcno");
		//String cno       = request.getParameter("cno");
		
		//vo.setCno(cno);
		//vo.setCust_cd(onlcno); 
		
		//commInfo.setSessionInfo(request,CommInfo.SESSION_ATTR_NAME, vo);
		        
		model.addAttribute("returnurl", returnUrl);
		return "/sso/loginSuccess";
	}
	
	@RequestMapping(value = "/jsp/sso/loginSuccessN.do",method={RequestMethod.GET, RequestMethod.POST})
	public String loginSuccessN(@ModelAttribute("CookieInfoVO") CookieInfoVO vo, HttpServletRequest request,  Model model) throws Exception {
		
		//String onlcno    = request.getParameter("onlcno");
		//String cno       = request.getParameter("cno");
		
		
		System.out.println("vo.getCust_id(): "+vo.getCust_id());
		
		
		//vo.setCno(cno);
		//vo.setCust_cd(onlcno); 
		
		//commInfo.setSessionInfo(request,CommInfo.SESSION_ATTR_NAME, vo);
		        
		model.addAttribute("returnurl", returnUrl);
		return "/sso/loginSuccessN";
	}
	
	@RequestMapping(value = "/jsp/sso/loginFail.do",method={RequestMethod.GET, RequestMethod.POST})
	public String loginFail(HttpServletRequest request,  Model model) throws Exception {
		System.out.println("loginFail~~");
		return "/sso/loginFail";
	}
	
	//logout
	@RequestMapping(value = "/jsp/sso/loginOut.do",method={RequestMethod.GET, RequestMethod.POST})
	public String loginOut(HttpServletRequest request,  Model model, HttpSession session) throws Exception {
		System.out.println("loginOut~~");
		
		request.getSession().setAttribute(CommInfo.SESSION_ATTR_NAME, null);
		request.getSession().invalidate();
		
		return "/sso/loginOut";
	}
	
	@RequestMapping(value = "/sso/loginChk.do",method={RequestMethod.GET, RequestMethod.POST})
	public String login(HttpServletRequest request,  Model model) throws Exception {
		
		String popYn = request.getParameter("popYN");
		
		//Map<String, Object> logInfo = commInfo.getSessionUserInfo(request, "IS_LOGOUT");
//		if(logInfo != null)
//		{
//			logInfo.put("IS_LOGOUT", true);
//			commInfo.modifySessionUserInfo(request, (Map<String,Object>)request.getSession().getAttribute(commInfo.SESSION_ATTR_NAME), logInfo);
//		}
		model.addAttribute("popYN", popYn);
		//제휴사 페이지인경우
		model.addAttribute("returnurl", request.getParameter("returnurl"));
		return "/sso/loginPage";
	}

	//SSO 고도화 테스트
	@RequestMapping(value = "/sso/loginChk_test.do",method={RequestMethod.GET, RequestMethod.POST})
	public String login_test(HttpServletRequest request,  Model model) throws Exception {
		
		String popYn = request.getParameter("popYN");

		model.addAttribute("popYN", popYn);
		//제휴사 페이지인경우
		model.addAttribute("returnurl", request.getParameter("returnurl"));
		return "/sso/loginPage_test";
	}
	//비회원예약 페이지
	@RequestMapping(value = "/sso/nologinPage.do",method={RequestMethod.GET, RequestMethod.POST})
	public String nologinPage(HttpServletRequest request,  Model model, HttpSession session) throws Exception {
		
		System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA__"+request.getParameter("returnurl"));
		System.out.println("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB__"+request.getParameter("returnUrl"));
		
		return "/sso/nologinPage";
	}
	
	//자유여행 비회원예약페이지
	@RequestMapping(value = "/sso/freenologinPage.do",method={RequestMethod.GET, RequestMethod.POST})
	public String freenologinPage(HttpServletRequest request,  Model model, HttpSession session) throws Exception {
		
		String returnUrl = request.getParameter("returnUrl");
		returnUrl = URLDecoder.decode(returnUrl, "UTF-8");
		
		model.addAttribute("returnUrl", returnUrl);
		
		return "/sso/freenologinPage";
	}
	
	
	//비회원예약 페이지
	@RequestMapping(value = "/jsp/sso/dht_login.do",method={RequestMethod.GET, RequestMethod.POST})
	public String dht_login(HttpServletRequest request,  Model model, HttpSession session) throws Exception {
		System.out.println("dht_login1=" + request.getParameter("returnurl"));
		return "/sso/dht_login";
	}
	

	@RequestMapping(value = "/sso/loginProcessAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String loginProcessAjax(@ModelAttribute("LoginVO") LoginVO vo, HttpServletRequest request,ModelMap model) throws Exception {
				
	    //returnUrl encoding
		returnUrl = URLEncoder.encode(vo.getReturnUrl(), "UTF-8"); //vo.getReturnUrl();
		String pass = URLEncoder.encode(vo.getPassword(), "UTF-8");//비밀번호중 #문자가 포함될경우 공백으로 치환되는 경우가 있어서 encode,decode를 통하여 로그인 비밀번호를 얻어온다.
				

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("loginId", vo.getLoginId());
		//map.put("password", vo.getPassword());
		map.put("password", pass);
		map.put("returnUrl", returnUrl);
		map.put("sid", vo.getSid());
		map.put("openType", "");
		map.put("copToken", request.getParameter("copToken"));
		map.put("copCls", "01");
		
		
		model.addAttribute("list", map);
		
		return "jsonView";
	}
	
	//비회원 예약 조회
	@RequestMapping(value = "/sso/checkGuestLoginAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String checkGuestLoginAjax(@ModelAttribute("LoginVO") LoginVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		
		List list = null;
        
		// 자유여행 예약 번호 (F로 시작 ~) 및 패키지 상품 예약 번호 가 아닌 경우 (P로  시작)
		//[JEH] 롯데면세점 프로모션으로 I 추가 - 20190510
		if((vo.getRes_cd().startsWith("F") && vo.getRes_cd().length() == 15) || (vo.getRes_cd().startsWith("P") && vo.getRes_cd().length() == 12) || (vo.getRes_cd().startsWith("I") && vo.getRes_cd().length() == 12)) {
        	System.out.println("@@@@@@@@@@LoginControllerAA@@@@@@@@@@@");
        	System.out.println("res_nm() : "+vo.getRes_nm());
        	System.out.println("R_phoneno() : "+vo.getR_phoneno());
        	System.out.println("Res_cd() : "+vo.getRes_cd());
        	System.out.println("@@@@@@@@@@LoginControllerAA@@@@@@@@@@@");
        	list = loginService.checkGuestLogin(vo);
        } else {
        	
        	System.out.println("@@@@@@@@@@LoginControllerBB@@@@@@@@@@@");
        	System.out.println("res_nm() : "+vo.getRes_nm());
        	System.out.println("R_phoneno() : "+vo.getR_phoneno());
        	System.out.println("Res_cd() : "+vo.getRes_cd());
        	System.out.println("@@@@@@@@@@LoginControllerBB@@@@@@@@@@@");

    		// 토파스 항공 예약 조회 
			TopassReserveUtil rsvUtil = new TopassReserveUtil();
    		//rsvUtil.setAirReservInfoNonMember(vo.getRes_nm(), vo.getEmail(), vo.getRes_cd());
			rsvUtil.setAirReservInfoNonMember(vo.getRes_nm(), vo.getR_phoneno(), vo.getRes_cd());
    		
    		list = rsvUtil.getReserveAirList();  
        }
		
		model.addAttribute("checkGuestLogin", list);
		
		return "jsonView";
	} 
	
	//로그인 cookie 정보 저장
	@RequestMapping(value = "/cookie/cookieSaveDataAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String cookieSaveData(@ModelAttribute("CookieInfoVO") CookieInfoVO vo, HttpServletRequest request,ModelMap model, HttpSession session) throws Exception {		
		List<CookieInfoVO> list = null;
		CookieInfoVO membersData = new CookieInfoVO();
		String custCd="";
		membersData.setCust_id(vo.getCust_id().trim());
		membersData.setKnm(vo.getKnm());
		membersData.setId(vo.getId());
		membersData.setEmail(vo.getEmail());
		membersData.setSex(vo.getSex());
		membersData.setMblNo(vo.getMblNo());
		membersData.setCno(vo.getCno());

		//cust_cd값 get.
		list = loginService.cookieSaveData(vo);
		
		for(int i=0; i < list.size(); i++) {
			custCd = list.get(i).getCust_cd();
		}

		if(custCd.equals("")) { //cust_cd값이 업으면.
			custCd = loginService.cookieInsert(vo);
			
			//list = loginService.getcustCd(vo);
			
			/*
			for(int i=0; i < list_af.size(); i++) {
				custCd = list_af.get(i).getCust_cd();
			}
			*/
		} else{
		//	loginService.cookieUpdate(vo);
		}
//		else {
//			System.out.println("update~~~~");
//			loginService.cookieUpdate(vo);
//		}
		
		vo.setCust_cd(custCd);
		
		list = loginService.getCookieInfo(vo);
		
		if(!vo.getDeviceId().equals("") && !vo.getDeviceId().equals(null)){
			loginService.updateDeviceCustId(vo);
		}

		//session저장
		if(list != null) {
			membersData.setCust_cd(list.get(0).getCust_cd());
			membersData.setCustGradeCd(list.get(0).getCustGradeCd());
			membersData.setCustGradeNm(list.get(0).getCustGradeNm());
			membersData.setBirthday(list.get(0).getBirthday());
			membersData.setMbrCustno(list.get(0).getCust_id());
			commInfo.setSessionInfo(request,CommInfo.SESSION_ATTR_NAME, membersData);
		}
        
		model.addAttribute("cookieData", list);
		return "jsonView";
	} 
	
	//로그인 cookie 정보 저장
		@RequestMapping(value = "/cookie/cookieSaveDataAjaxN.do",method={RequestMethod.GET, RequestMethod.POST})
		public String cookieSaveDataN(@ModelAttribute("CookieInfoVO") CookieInfoVO vo, HttpServletRequest request,ModelMap model, HttpSession session) throws Exception {		
			List<CookieInfoVO> list = null;
			CookieInfoVO membersData = new CookieInfoVO();
			String custCd="";
			membersData.setCust_id(vo.getCust_id().trim());
			membersData.setKnm(vo.getKnm());
			membersData.setId(vo.getId());
			membersData.setEmail(vo.getEmail());
			membersData.setSex(vo.getSex());
			membersData.setMblNo(vo.getMblNo());
			membersData.setCno(vo.getCno());

			//cust_cd값 get.
			list = loginService.cookieSaveData(vo);
			
			for(int i=0; i < list.size(); i++) {
				custCd = list.get(i).getCust_cd();
			}

			if(custCd.equals("")) { //cust_cd값이 업으면.
				custCd = loginService.cookieInsert(vo);
				
				//list = loginService.getcustCd(vo);
				
				/*
				for(int i=0; i < list_af.size(); i++) {
					custCd = list_af.get(i).getCust_cd();
				}
				*/
			} else{
				//loginService.cookieUpdate(vo);
			}
//			else {
//				System.out.println("update~~~~");
//				loginService.cookieUpdate(vo);
//			}
			
			vo.setCust_cd(custCd);
			
			list = loginService.getCookieInfo(vo);
			
			if(!vo.getDeviceId().equals("") && !vo.getDeviceId().equals(null)){
				loginService.updateDeviceCustId(vo);
			}

			//session저장
			if(list != null) {
				membersData.setCust_cd(list.get(0).getCust_cd());
				membersData.setCustGradeCd(list.get(0).getCustGradeCd());
				membersData.setCustGradeNm(list.get(0).getCustGradeNm());
				membersData.setBirthday(list.get(0).getBirthday());
				membersData.setMbrCustno(list.get(0).getCust_id());
				membersData.setCno(vo.getCno());

				commInfo.setSessionInfo(request,CommInfo.SESSION_ATTR_NAME, membersData);
			}
	        
			model.addAttribute("cookieData", list);
			return "jsonView";
		} 
	
	
	
	
	@RequestMapping(value = "/sso/saveSessionLoginInfo.do",method={RequestMethod.GET, RequestMethod.POST})
	public String saveSessionLoginInfo(@ModelAttribute("CookieInfoVO") CookieInfoVO vo, HttpServletRequest request,ModelMap model, HttpSession session) throws Exception {
		System.out.println("/sso/saveSessionLoginInfo.do---->시작 ");
		System.out.println("vo.getCust_id(): "+vo.getCust_id());
		System.out.println("/sso/saveSessionLoginInfo.do");
		List<CookieInfoVO> list = null;
		//List<CookieInfoVO> list_af = null;
		CookieInfoVO membersData = new CookieInfoVO();
		String custCd = "";
		
		String t_cust_id = "";
	    String t_username = "";
	    String t_login_id = "";
	    String t_email = "";
	    String t_sex = "";
	    String t_mbl_no = "";
	    String t_mbr_custno = "";
	    String t_cust_type = "";
	    String t_cno = "";
		
		BASE64Decoder decoder = new BASE64Decoder();
		String confPath = request.getRealPath("/WEB-INF/lottesso.conf");
		String strSID = "LOTTEJTB";
		FileInputStream fInput = null;
		
		try{
			Properties ps = new Properties();
	        fInput = new FileInputStream(confPath);
	        ps.load(fInput);
	        String STR_KEY = ps.getProperty("LOTTEJTB");
	        String decStr = "";
	        
	        byte[] BYTE_KEY = decoder.decodeBuffer(STR_KEY);
	        
	        Seedx seed = new Seedx(BYTE_KEY);
	        
	        if(!vo.getCust_id().equals("") && !vo.getCust_id().equals(null) && !vo.getCust_id().equals("undefined")){
		        
	        	if(vo.getCust_id().length()>10){
	        	byte bEncBuff[] = decoder.decodeBuffer(vo.getCust_id());
			    byte bDecBuff[] = seed.decrypt(bEncBuff);
			    t_cust_id = new String(bDecBuff, "EUC-KR");
	        	}else{
	        		t_cust_id = vo.getCust_id();
	        	}
			}
	        
	        if(!vo.getKnm().equals("") && !vo.getKnm().equals(null) && !vo.getKnm().equals("undefined")){
	        	if(vo.getCust_id().length()>10){
	        	byte bEncBuff[] = decoder.decodeBuffer(vo.getKnm());
			    byte bDecBuff[] = seed.decrypt(bEncBuff);
			    	t_username = new String(bDecBuff, "EUC-KR");
	        	}else{
	        		t_username = vo.getKnm();	
	        	}
			    
	        }
	        
	        if(!vo.getId().equals("") && !vo.getId().equals(null) && !vo.getId().equals("undefined")){
	        	if(vo.getCust_id().length()>10){
	        	byte bEncBuff[] = decoder.decodeBuffer(vo.getId());
			    byte bDecBuff[] = seed.decrypt(bEncBuff);
			    t_login_id = new String(bDecBuff, "EUC-KR");
	        	}else{
	        		t_login_id =vo.getId();	
	        	}
			    
	        }
	        
	        if(!vo.getEmail().equals("") && !vo.getEmail().equals(null) && !vo.getEmail().equals("undefined")){
	        	if(vo.getCust_id().length()>10){
	        	byte bEncBuff[] = decoder.decodeBuffer(vo.getEmail());
			    byte bDecBuff[] = seed.decrypt(bEncBuff);
			    t_email = new String(bDecBuff, "EUC-KR");
	        	}else{
			    t_email =vo.getEmail();
	        	}
	        }
	        
	        if(!vo.getPersonalNo().equals("") && !vo.getPersonalNo().equals(null) && !vo.getPersonalNo().equals("undefined")){ 
		        byte bEncBuff[] = decoder.decodeBuffer(vo.getPersonalNo());
			    byte bDecBuff[] = seed.decrypt(bEncBuff);
			    String t_personal_no = new String(bDecBuff, "EUC-KR");
			    int tempSex;
			    		
	    		if(!t_personal_no.equals(null) && !t_personal_no.equals("")){
			    	tempSex = Integer.parseInt(t_personal_no.substring(6,7));
			    	switch(tempSex){
			    	case 1 :
			    	case 3 :
			    	case 5 :
			    	case 7 :
			    		t_sex =	"man";
			    		break;
			    	case 2 :
			    	case 4 :
			    	case 6 :
			    	case 8 :
			    		t_sex =	"woman";
			    		break;
			    	}
			    } 
	        }
	        
	        if(!vo.getMblNo().equals("") && !vo.getMblNo().equals(null) && !vo.getMblNo().equals("undefined")){
	        	if(vo.getCust_id().length()>10){
	        	byte bEncBuff[] = decoder.decodeBuffer(vo.getMblNo());
			    byte bDecBuff[] = seed.decrypt(bEncBuff);
			    t_mbl_no = new String(bDecBuff, "EUC-KR");
	        	}else{
			    t_mbl_no = vo.getMblNo();
	        	}
	        }
	        
	        if(!vo.getMbrCustno().equals("") && !vo.getMbrCustno().equals(null) && !vo.getMbrCustno().equals("undefined")){
	        	if(vo.getCust_id().length()>10){
	        	byte bEncBuff[] = decoder.decodeBuffer(vo.getMbrCustno());
			    byte bDecBuff[] = seed.decrypt(bEncBuff);
			    t_mbr_custno = new String(bDecBuff, "EUC-KR");
	        	}else{
			    t_mbr_custno = vo.getMbrCustno();
	        	}
	        }
	        
	        if(!vo.getCustGradeCd().equals("") && !vo.getCustGradeCd().equals(null) && !vo.getCustGradeCd().equals("undefined")){
	        	if(vo.getCust_id().length()>10){
	        	byte bEncBuff[] = decoder.decodeBuffer(vo.getCustGradeCd());
			    byte bDecBuff[] = seed.decrypt(bEncBuff);
			    t_cust_type = new String(bDecBuff, "EUC-KR");
	        	}else{
			    t_cust_type = vo.getCustGradeCd();
	        	}
	        }
	        if(!vo.getCno().equals("") && !vo.getCno().equals(null) && !vo.getCno().equals("undefined")){
	        	if(vo.getCust_id().length()>10){
	        	byte bEncBuff[] = decoder.decodeBuffer(vo.getCno());
			    byte bDecBuff[] = seed.decrypt(bEncBuff);
			    t_cno = new String(bDecBuff, "EUC-KR");
	        	}else{
			    t_cno = vo.getCno();
	        	}
	        }
	        
		}catch(Exception e){
			//e.printStackTrace();
			System.err.println("Buffer Error!");
		}
		if(vo.getCust_id().length()>10){ 
			vo.setCust_id(t_cust_id.trim());
			vo.setKnm(t_username.trim());
			vo.setId(t_login_id.trim());
			vo.setEmail(t_email.trim());
			vo.setSex(t_sex);
			vo.setMblNo(t_mbl_no);
			vo.setMbrCustno(t_mbr_custno);
			vo.setCustGradeCd(t_cust_type);
			vo.setCno(t_cno);
		}	
		System.out.println("/sso/saveSessionLoginInfo.do");
		System.out.println("vo.getCust_id(): "+vo.getCust_id());
		System.out.println("/sso/saveSessionLoginInfo.do---->끝");
		membersData.setCust_id(vo.getCust_id().trim());
		membersData.setKnm(vo.getKnm());
		membersData.setId(vo.getId());
		membersData.setEmail(vo.getEmail());
		membersData.setSex(vo.getSex());
		membersData.setMblNo(vo.getMblNo());
		membersData.setCno(vo.getCno());
		 
		//cust_cd값 get.
		list = loginService.cookieSaveData(vo);
		
		for(int i=0; i < list.size(); i++) {
			custCd = list.get(i).getCust_cd();
		}

		if(custCd.equals("")) { //cust_cd값이 업으면.
			custCd = loginService.cookieInsert(vo);
		}
		
		vo.setCust_cd(custCd);
		
		list = loginService.getCookieInfo(vo);
		
		if(!vo.getDeviceId().equals("") && !vo.getDeviceId().equals(null)){
			loginService.updateDeviceCustId(vo);
		}
		
		//session저장
		if(list != null) {
			membersData.setCust_cd(list.get(0).getCust_cd());
			membersData.setCustGradeCd(list.get(0).getCustGradeCd());
			membersData.setCustGradeNm(list.get(0).getCustGradeNm());
			membersData.setBirthday(list.get(0).getBirthday());
			membersData.setMbrCustno(list.get(0).getCust_id());
			commInfo.setSessionInfo(request,CommInfo.SESSION_ATTR_NAME, membersData);
		}
		
		HttpSession sessionInfo = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)sessionInfo.getAttribute(CommInfo.SESSION_ATTR_NAME);
        
		model.addAttribute("custCd", list.get(0).getCust_cd());
		
		return "jsonView";
	}
	
	//쿠키 정보 insert
//	@RequestMapping(value = "/sso/cookieInsertAjax.do",method={RequestMethod.GET, RequestMethod.POST})
//	public String cookieInsert(@ModelAttribute("CookieInfoVO") CookieInfoVO vo, HttpServletRequest request,ModelMap model,HttpSession session) throws Exception {
//		
//		loginService.cookieInsert(vo);
//		
//		List list = loginService.getCookieInfo(vo);
//		
//		System.out.println("cust_id=" + list.get(0).toString());
//		System.out.println("cust_cd=" + list.get(1).toString());
//		System.out.println("jmno=" + list.get(2).toString());
//		System.out.println("jnm=" + list.get(3).toString());
//		System.out.println("id=" + list.get(4).toString());
//		System.out.println("email=" + list.get(5).toString());
//		
//		//session 저장
//		if(list != null) {
//			 session.setAttribute(commInfo.SESSION_ATTR_NAME, list);
//		}
//        
//		model.addAttribute("cookieInsert", list);
//		return "jsonView";
//	} 
	
	//쿠키 정보 update
//	@RequestMapping(value = "/sso/cookieUpdateAjax.do",method={RequestMethod.GET, RequestMethod.POST})
//	public String cookieUpdate(@ModelAttribute("CumstVO") CookieInfoVO vo, HttpServletRequest request,ModelMap model) throws Exception {
//		
//		loginService.cookieUpdate(vo);
//        
//		model.addAttribute("cookieUpdate", null);
//		return "jsonView";
//	} 

	@RequestMapping(value = "/sso/loginLogInsertAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String loginLogInsertAjax(@ModelAttribute("LoginVO") LoginVO vo, HttpServletRequest request,ModelMap model) throws Exception {

		BASE64Decoder decoder = new BASE64Decoder();
		String confPath = request.getRealPath("/WEB-INF/lottesso.conf");
		String strSID = "LOTTEJTB";
		FileInputStream fInput = null;
		
		Properties ps = new Properties();
        fInput = new FileInputStream(confPath);
        ps.load(fInput);
        String STR_KEY = ps.getProperty("LOTTEJTB");
        String decStr = "";
        
        byte[] BYTE_KEY = decoder.decodeBuffer(STR_KEY);
        
        Seedx seed = new Seedx(BYTE_KEY);
	        
		String t_cust_id = "";

        if(!vo.getCust_id().equals("") && !vo.getCust_id().equals(null) && !vo.getCust_id().equals("undefined")){
	        byte bEncBuff[] = decoder.decodeBuffer(vo.getCust_id());
		    byte bDecBuff[] = seed.decrypt(bEncBuff);
		    //t_cust_id = new String(bDecBuff, "EUC-KR");
		    if(vo.getCust_id().length()>10){
	             t_cust_id = new String(bDecBuff, "EUC-KR");
	          }else{
	             t_cust_id = vo.getCust_id();
	          }
		    //t_cust_id = vo.getCust_id();
        }

		if(!"".equals(t_cust_id)){ 
			//vo.setCust_id(t_cust_id.trim());
			System.out.println("==============================>>>vo.setCust_id : " + vo.getCust_id());
			
			//List<LoginVO> list = loginService.selectLoginLog(vo);
			//System.out.println("==============================>>>list size : " + list.size());
			
			//if(list.size() <= 0){
			loginService.loginLogInsert(vo); 
			//}
		}
		
		return "jsonView";
	}
	
	
	@RequestMapping(value = "/sso/loginLogInsertAjaxN.do",method={RequestMethod.GET, RequestMethod.POST})
	public String loginLogInsertAjaxN(@ModelAttribute("LoginVO") LoginVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		
		BASE64Decoder decoder = new BASE64Decoder();
		String confPath = request.getRealPath("/WEB-INF/lottesso.conf");
		String strSID = "LOTTEJTB";
		FileInputStream fInput = null;
		
		Properties ps = new Properties();
        fInput = new FileInputStream(confPath);
        ps.load(fInput);
        String STR_KEY = ps.getProperty("LOTTEJTB");
        String decStr = "";
        
        byte[] BYTE_KEY = decoder.decodeBuffer(STR_KEY);
        
        Seedx seed = new Seedx(BYTE_KEY);
	        
		String t_cust_id = "";

        if(!vo.getCust_id().equals("") && !vo.getCust_id().equals(null) && !vo.getCust_id().equals("undefined")){
	        //byte bEncBuff[] = decoder.decodeBuffer(vo.getCust_id());
		    //byte bDecBuff[] = seed.decrypt(bEncBuff);
		    //t_cust_id = new String(bDecBuff, "EUC-KR");
        }

		//if(!"".equals(t_cust_id)){ 
			
			//	vo.setCust_id(t_cust_id.trim());
			
			System.out.println("==============================>>>vo.setCust_id : " + vo.getCust_id());
			 
			//List<LoginVO> list = loginService.selectLoginLog(vo);
			//System.out.println("==============================>>>list size : " + list.size());
			
			//if(list.size() <= 0){
			loginService.loginLogInsert(vo); 
			//} 
		//}
		
		return "jsonView";
	}
	
	
}


