package com.lottejtb.reserve.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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

import com.lottejtb.comm.util.CommInfo;
import com.lottejtb.goods.rn.service.RNETMstVO;
import com.lottejtb.goods.rn.service.RNGDMstVO;
import com.lottejtb.goods.rn.service.RNGDTagsVO;
import com.lottejtb.goods.rn.service.RNGoodsService;
import com.lottejtb.goods.service.EmsMailSendVO;
import com.lottejtb.member.service.CUMstVO;
import com.lottejtb.reserve.service.AirsBlockDTO;
import com.lottejtb.reserve.service.ComCodeVO;
import com.lottejtb.reserve.service.ManagerDTO;
import com.lottejtb.reserve.service.ReserveRosterVO;
import com.lottejtb.reserve.service.ReserveService;
import com.lottejtb.reserve.service.ReserveVO;
import com.lottejtb.reserve.service.RvPerInfoHisVO;
import com.lottejtb.reserve.service.RvPerInfoVO;
import com.lottejtb.reserve.service.SmsVO;
import com.lottejtb.reserve.service.SyCdDetVO;
import com.lottejtb.reserve.service.UmsLogVO;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class ReserveController {

	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/";
	private final int PAGESIZE = 10;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
    @Resource(name = "ehcache")
    Ehcache ehcache;

	// 상품 상세 정보 관련 서비스 신규 
	@Resource(name = "RNGoodsService")
	private RNGoodsService rnGoodsService;
	
	// 예약 정보 관련 서비스 
	@Resource(name = "ReserveService")
	private ReserveService reserveService;
	
	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/reserve/reserve_clause.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause(@RequestParam("ctg") String ctg, @RequestParam("eventCd") String eventCd, HttpServletRequest request,  ModelMap model)throws Exception {
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
		
		String goodsCd = "";
		if(eventCd != null && !eventCd.equals("")) 
			goodsCd = eventCd.substring(0, 7);
		
		model.addAttribute("ctg", ctg);		
		model.addAttribute("goodsCd", goodsCd);
		model.addAttribute("eventCd", eventCd);	
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("age", age);
		
		return _rootPath+"reserve/reserve_clause";
	}

	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/reserve/reserve_clause_txt1.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause_txt1(ModelMap model)throws Exception {
		
		return _rootPath+"reserve/reserve_clause_txt1";
	}

	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/reserve/reserve_clause_txt1_1.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause_txt1_1(ModelMap model)throws Exception {
		
		return _rootPath+"reserve/reserve_clause_txt1";
	}	
	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/reserve/reserve_clause_txt2.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause_txt2(ModelMap model)throws Exception {
		
		return _rootPath+"reserve/reserve_clause_txt2";
	}	
	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/reserve/reserve_clause_txt3.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause_txt3(ModelMap model)throws Exception {
		
		return _rootPath+"reserve/reserve_clause_txt3";
	}	
	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/reserve/reserve_clause_txt4.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause_txt4(ModelMap model)throws Exception {
		
		return _rootPath+"reserve/reserve_clause_txt4";
	}	
	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/reserve/reserve_clause_txt5.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause_txt5(ModelMap model)throws Exception {
		
		return _rootPath+"reserve/reserve_clause_txt5";
	}	
	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/reserve/reserve_clause_txt6.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause_txt6(ModelMap model)throws Exception {
		
		return _rootPath+"reserve/reserve_clause_txt6";
	}	
	
	// <!-- 예약 UI > 약관  -->
	@RequestMapping(value = "/reserve/reserve_clause_txt7.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_clause_txt7(ModelMap model)throws Exception {
		return _rootPath+"reserve/reserve_clause_txt7";
	}
	
	// <!-- 예약 UI > 예약 정보 입력   -->
	@RequestMapping(value = "/reserve/reserve_info.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve(@RequestParam("ctg") String ctg, @RequestParam("eventCd") String eventCd, HttpServletRequest request,  ModelMap model)throws Exception {
	
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
		
		String mktAgreeYn = (String) request.getParameter("mktAgreeYn");
		String childAgreeYn = (String) request.getParameter("childAgreeYn");
		String smsAgreeYn = (String) request.getParameter("smsAgreeYn");
		String emailAgreeYn = (String) request.getParameter("emailAgreeYn");
		

		/** 행사 상품 태그 조회 **/
		RNGDTagsVO rnGDTagsParam = new RNGDTagsVO();
		rnGDTagsParam.setEvent_cd(eventCd);
		
		RNGDTagsVO rnGDTagsResult = new RNGDTagsVO();
		rnGDTagsResult = (RNGDTagsVO) rnGoodsService.srchGDTags(rnGDTagsParam);
		
		/** 행사 상품 마스터 조회 **/
		RNGDMstVO rnGDMstParam = new RNGDMstVO();
		rnGDMstParam.setComp_cd(rnGDTagsResult.getComp_cd());
		rnGDMstParam.setGoods_cd(goodsCd);
		
		RNGDMstVO rnGDMstResult = new RNGDMstVO();
		rnGDMstResult = (RNGDMstVO) rnGoodsService.srchGDMst(rnGDMstParam);
		
		/** 행사 상품 이벤트 조회 **/
		RNETMstVO rnEtMstParam = new RNETMstVO();
		rnEtMstParam.setEvent_cd(eventCd);
		rnEtMstParam.setComp_cd(rnGDTagsResult.getComp_cd());
		rnEtMstParam.setGoods_cd(goodsCd);
		
		RNETMstVO rnEtMstResult = new RNETMstVO();
		rnEtMstResult = (RNETMstVO) rnGoodsService.srchETMst2(rnEtMstParam);	
		
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

		/** 임직원 등급 조회 **/
		String grade = "";
		if(custCd != null && !custCd.equals("")) {
			grade = (String) rnGoodsService.selectCustGrade(custCd);	
		}
		model.addAttribute("grade", grade);
		
		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);
		model.addAttribute("eventCd", eventCd);	
		
		model.addAttribute("rnGDMst", rnGDMstResult);
		model.addAttribute("rnEtMst", rnEtMstResult);
		model.addAttribute("opCd", rnGDMstResult.getOp_cd());
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("sex", sex);
		model.addAttribute("id", id);
		model.addAttribute("email", email);		
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("birthday", birthday);		

		model.addAttribute("mktAgreeYn", mktAgreeYn);		
		model.addAttribute("childAgreeYn", childAgreeYn);		

		model.addAttribute("smsAgreeYn", smsAgreeYn);		
		model.addAttribute("emailAgreeYn", emailAgreeYn);	
		

		return _rootPath+"reserve/reserve_info";
	}

	// <!-- 예약 UI > 예약 정보 입력   -->
	@RequestMapping(value = "/reserve/reserve_finish.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String reserve_finish(@RequestParam("ctg") String ctg,  @RequestParam("eventCd") String eventCd,  @RequestParam("resCd") String resCd, HttpServletRequest request, ModelMap model)throws Exception {
		
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
		
		/** 행사 상품 태그 조회 **/
		RNGDTagsVO rnGDTagsParam = new RNGDTagsVO();
		rnGDTagsParam.setEvent_cd(eventCd);
		
		RNGDTagsVO rnGDTagsResult = new RNGDTagsVO();
		rnGDTagsResult = (RNGDTagsVO) rnGoodsService.srchGDTags(rnGDTagsParam);
		
		/** 행사 상품 이벤트 조회 **/
		RNETMstVO rnEtMstParam = new RNETMstVO();
		rnEtMstParam.setEvent_cd(eventCd);
		rnEtMstParam.setComp_cd(rnGDTagsResult.getComp_cd());
		rnEtMstParam.setGoods_cd(goodsCd);
		
		RNETMstVO rnEtMstResult = new RNETMstVO();
		rnEtMstResult = (RNETMstVO) rnGoodsService.srchETMst2(rnEtMstParam);	
		
		/** 예약 정보 마스터 조회 **/
		ReserveVO reserveParam = new ReserveVO();
		reserveParam.setRes_cd(resCd);
		
		ReserveVO reserveResult = (ReserveVO) reserveService.srchReserve(reserveParam);
		
		/** 예약 인원 정보 리스트  조회 **/
		ReserveRosterVO rosterParam = new ReserveRosterVO();
		rosterParam.setRes_cd(resCd);
		
		List reserveRosterList = (List) reserveService.srchReserveRosters(rosterParam);

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

		/** 임직원 등급 조회 **/
		String grade = "";
		if(custCd != null && !custCd.equals("")) {
			grade = (String) rnGoodsService.selectCustGrade(custCd);	
		}
		model.addAttribute("grade", grade);
		
		model.addAttribute("ctg", ctg);
		model.addAttribute("goodsCd", goodsCd);
		model.addAttribute("eventCd", eventCd);	
		
		model.addAttribute("rnEtMst", rnEtMstResult);
		model.addAttribute("reserveMst", reserveResult);
		model.addAttribute("reserveRosterList", reserveRosterList);
		model.addAttribute("resCd", resCd);			
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("sex", sex);
		model.addAttribute("id", id);
		model.addAttribute("email", email);		
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("birthday", birthday);		
		
		return _rootPath+"reserve/reserve_finish";
	}
	
	// <!--  예약 정보 입력    -->
	@RequestMapping(value = "/reserve/srchReserveRosterListAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String srchReserveRosterListAjax(@ModelAttribute("ReserveRosterVO") ReserveRosterVO param, ModelMap model)throws Exception{
		
		List reserveRosterList = (List) reserveService.srchReserveRosters(param);
		
		model.addAttribute("reserveRosterList", reserveRosterList);
		
		return "jsonView";
	}
	
	// <!--  예약 정보 입력    -->
	@RequestMapping(value = "/reserve/saveReserveAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String saveReserveAjax(@ModelAttribute("ReserveVO") ReserveVO param, HttpServletRequest request, ModelMap model)throws Exception{
		
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
		
		String errCode = "";
		
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
		

		
		
		try {
			// 제휴사 
			if(param.getMall_cd()  == null || param.getMall_cd().length() == 0 || "1".equals(param.getMall_cd())) {
				param.setMall_cd("1");
			}
			System.out.println("cust_cd >>>>>>>>>>>>>>>>>>>>>>>>>>> " + param.getCust_cd());
			
			String goodsCd = "";
			if(param.getEvent_cd() != null && !param.getEvent_cd().equals("")) 
				goodsCd = param.getEvent_cd().substring(0, 7);
			
			// 대표 예약자 정보 입력 
			if(param.getDp_handphone1() != null) param.setHandphone1(param.getDp_handphone1());
			if(param.getDp_handphone2() != null) param.setHandphone2(param.getDp_handphone2());
			if(param.getDp_handphone3() != null) param.setHandphone3(param.getDp_handphone3());
			
			if(param.getReserve_cnt() > 0) param.setRes_cnt(param.getReserve_cnt());
			if(param.getDp_email1() != null) param.setEmail(param.getDp_email1() + "@" + param.getDp_email2());
			if(param.getAdult_price() > 0)  param.setEvent_amt(param.getAdult_price());
			if(param.getAdult_price() > 0) param.setSale_amt(param.getAdult_price());
			if(param.getDp_comment() != null)  param.setRemark(param.getDp_comment());
			// param.setMass_cd("ONI"); // 온라인예약(유입상세)
			param.setRes_chk_cd("10"); // 직판
			
			//[JEH] 롯데면세점일경우 예약확정으로 변경 - 20190510
			if("PGI1011".equals(goodsCd)){
				param.setStatus_cd("10");
			}else{
				param.setStatus_cd("01");
			}
			
			param.setJoin_shop(param.getMall_cd());
			param.setRes_nm(param.getDp_nm());
			param.setPosi_cd("SELLT");
			param.setCopy_yn("N");
			param.setCust_tour_yn("N");
			// param.setRemark(param.getDp_comment());
			param.setCust_cd(custCd);
			
			// param.setMass_cd("LTB"); // 하드코딩 
			// param.setMass_site_cd("LM"); // 하드 코딩
			
			java.util.Date resDate = new java.util.Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
			String res_day = sdf.format(resDate);
			param.setRes_day(res_day);
			
			System.out.println(">>>>>>>>>>>>>>>>> 1");
			
			String deptCd = "414100";//콜센터
			String gdTypeCd = null;
	
			if(param.getEvent_cd() != null && !param.getEvent_cd().equals("")){
				gdTypeCd = param.getEvent_cd().substring(2,3);
				
				//FIT,허니문,해외골프,크루즈,스페셜,국내골프
				if("M".equals(gdTypeCd) || "C".equals(gdTypeCd) || "Y".equals(gdTypeCd) || "O".equals(gdTypeCd)){
					deptCd = "612600";//상품기획3팀
				//국내숙박,국내테마,명품국내,제주도여행,롯데호텔,할인입장권,렌터카
				}else if("B".equals(gdTypeCd) || "D".equals(gdTypeCd) || "J".equals(gdTypeCd) || "K".equals(gdTypeCd) || "N".equals(gdTypeCd)|| "Q".equals(gdTypeCd)|| "R".equals(gdTypeCd)){
					deptCd = "612500";//상품기획4팀(국내영업팀)
				}else if("F".equals(gdTypeCd)){
					deptCd = "612100";//상품기획2팀
				}else if("G".equals(gdTypeCd)) {
					deptCd = "612300";//일본팀
					
				}
			}
			
			param.setDept_cd(deptCd);
			
			System.out.println(">>>>>>>>>>>>>>>>> deptCd : " + deptCd);
			///////비회원예약
			
			if(param.getOrder_type() != null && param.getOrder_type().length() > 0){
				param.setIs_new_reg("Y"); // 회원 정보 신규 등록 
			}
			
			//////////////////////////////////////// 여행자 정보 셋팅 ////////////////////////////////////////////////
			List<ReserveRosterVO> travelerList = new ArrayList<ReserveRosterVO>();
			
			int travelerCnt = 0;
			int babyCnt = 0;
			int babyPrice = 0;
			int childCnt = 0;
			int childPrice = 0;
			int adultCnt = 0;
			int adultPrice = 0;
			int totalAmt = 0;
	
			
	
			ReserveRosterVO travelerDTO = new ReserveRosterVO();
			
			// 여행자 1
			travelerDTO.setRes_seq(travelerCnt+1);
			if(param.getInwon1_knm() != null)  travelerDTO.setNm_kor(param.getInwon1_knm());
			if(param.getInwon1_efname() != null)  travelerDTO.setEnm_last(param.getInwon1_efname().toUpperCase()); /** 강제 대문자로 셋팅 **/
			if(param.getInwon1_ename() != null) travelerDTO.setEnm_first(param.getInwon1_ename().toUpperCase()); /** 강제 대문자로 셋팅 **/
			if(param.getInwon1_handphone1() != null) travelerDTO.setHandphone1(param.getInwon1_handphone1());
			if(param.getInwon1_handphone2() != null) travelerDTO.setHandphone2(param.getInwon1_handphone2());
			
			if(param.getInwon1_handphone3() != null) travelerDTO.setHandphone3(param.getInwon1_handphone3());
			// travelerDTO.setJmno(param.getInwon1_ssnL());
			if(param.getInwon1_passYn() != null) travelerDTO.setPp_yn(param.getInwon1_passYn());
			if(param.getInwon1_sex() != null) travelerDTO.setSex(param.getInwon1_sex());
			travelerDTO.setRes_day(res_day);
			
			// 대표 예약자랑 동일할 경우 
			if(param.getDp_equalsFlag().equals("Y")) {
				travelerDTO.setCust_cd(custCd);
			}
			
			//금액
			if(param.getStart_day() != null) {
				
				//유아
				if(param.getInwon1_age() != null && param.getInwon1_age().equals("baby")){
					travelerDTO.setAge_cd("I");
					babyCnt = babyCnt + 1;
					babyPrice = babyPrice + param.getBaby_price();				
					totalAmt = totalAmt + param.getBaby_price(); //예약 총 금액				
				//소아
				}else if(param.getInwon1_age() != null && param.getInwon1_age().equals("child")){
					travelerDTO.setAge_cd("C");
					childCnt = childCnt + 1;
					childPrice = childPrice + param.getChild_price();				
					totalAmt = totalAmt + param.getChild_price(); //예약 총 금액
				//성인
				}else{
					travelerDTO.setAge_cd("A");	
					adultCnt = adultCnt + 1;
					adultPrice = adultPrice + param.getAdult_price();
					totalAmt = totalAmt + param.getAdult_price(); //예약 총 금액
				}
			}
			
			if(param.getInwon1_pickup_area_cd() != null && !param.getInwon1_pickup_area_cd().equals("undefined")) {
				travelerDTO.setPickup_area_cd(param.getInwon1_pickup_area_cd());	
			}
			
			travelerList.add(travelerDTO);
			travelerCnt++;
	
			System.out.println(">>>>>>>>>>>>>>>>> 2");
			
			if(param.getReserve_cnt() > 1) {
				travelerDTO = new ReserveRosterVO();
				// 여행자 2
				travelerDTO.setRes_seq(travelerCnt+1);
				if(param.getInwon2_knm() != null) travelerDTO.setNm_kor(param.getInwon2_knm());
				if(param.getInwon2_efname() != null) travelerDTO.setEnm_last(param.getInwon2_efname().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon2_ename() != null) travelerDTO.setEnm_first(param.getInwon2_ename().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon2_handphone1() != null) travelerDTO.setHandphone1(param.getInwon2_handphone1());
				if(param.getInwon2_handphone2() != null) travelerDTO.setHandphone2(param.getInwon2_handphone2());
				
				if(param.getInwon2_handphone3() != null) travelerDTO.setHandphone3(param.getInwon2_handphone3());
				// travelerDTO.setJmno(param.getInwon2_ssnL());
				if(param.getInwon2_passYn() != null) travelerDTO.setPp_yn(param.getInwon2_passYn());
				if(param.getInwon2_sex() != null) travelerDTO.setSex(param.getInwon2_sex());
				
				//금액
				if(param.getStart_day() != null){
					
					//유아
					if(param.getInwon2_age() != null && param.getInwon2_age().equals("baby")){
						travelerDTO.setAge_cd("I");
						babyCnt = babyCnt + 1;
						babyPrice = babyPrice + param.getBaby_price();				
						totalAmt = totalAmt + param.getBaby_price(); //예약 총 금액				
					//소아
					}else if(param.getInwon2_age() != null && param.getInwon2_age().equals("child")){
						travelerDTO.setAge_cd("C");
						childCnt = childCnt + 1;
						childPrice = childPrice + param.getChild_price();				
						totalAmt = totalAmt + param.getChild_price(); //예약 총 금액
					//성인
					}else{
						travelerDTO.setAge_cd("A");	
						adultCnt = adultCnt + 1;
						adultPrice = adultPrice + param.getAdult_price();
						totalAmt = totalAmt + param.getAdult_price(); //예약 총 금액
					}
				}
				if(param.getInwon1_pickup_area_cd() != null && !param.getInwon1_pickup_area_cd().equals("undefined")) {

					travelerDTO.setPickup_area_cd(param.getInwon2_pickup_area_cd());
				}
				travelerList.add(travelerDTO);
				travelerCnt ++;
			}
			System.out.println(">>>>>>>>>>>>>>>>> 3");
			
			if(param.getReserve_cnt() > 2) {
				travelerDTO = new ReserveRosterVO();
				// 여행자 3
				travelerDTO.setRes_seq(travelerCnt+1);
				if(param.getInwon3_knm() != null) travelerDTO.setNm_kor(param.getInwon3_knm());
				if(param.getInwon3_efname() != null) travelerDTO.setEnm_last(param.getInwon3_efname().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon3_ename() != null) travelerDTO.setEnm_first(param.getInwon3_ename().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon3_handphone1() != null) travelerDTO.setHandphone1(param.getInwon3_handphone1());
				if(param.getInwon3_handphone2() != null) travelerDTO.setHandphone2(param.getInwon3_handphone2());
				
				if(param.getInwon3_handphone3() != null) travelerDTO.setHandphone3(param.getInwon3_handphone3());
				// travelerDTO.setJmno(param.getInwon3_ssnL());
				if(param.getInwon3_passYn() != null) travelerDTO.setPp_yn(param.getInwon3_passYn());
				if(param.getInwon3_sex() != null) travelerDTO.setSex(param.getInwon3_sex());
				
				//금액
				if(param.getStart_day() != null){
					
					//유아
					if(param.getInwon3_age() != null && param.getInwon3_age().equals("baby")){
						travelerDTO.setAge_cd("I");
						babyCnt = babyCnt + 1;
						babyPrice = babyPrice + param.getBaby_price();				
						totalAmt = totalAmt + param.getBaby_price(); //예약 총 금액				
					//소아
					}else if(param.getInwon3_age() != null && param.getInwon3_age().equals("child")){
						travelerDTO.setAge_cd("C");
						childCnt = childCnt + 1;
						childPrice = childPrice + param.getChild_price();				
						totalAmt = totalAmt + param.getChild_price(); //예약 총 금액
					//성인
					}else{
						travelerDTO.setAge_cd("A");	
						adultCnt = adultCnt + 1;
						adultPrice = adultPrice + param.getAdult_price();
						totalAmt = totalAmt + param.getAdult_price(); //예약 총 금액
					}
				}
				if(param.getInwon1_pickup_area_cd() != null && !param.getInwon1_pickup_area_cd().equals("undefined")) {

					travelerDTO.setPickup_area_cd(param.getInwon3_pickup_area_cd());
				}
				travelerList.add(travelerDTO);
				travelerCnt ++;
			}
			
			System.out.println(">>>>>>>>>>>>>>>>> 4");
	
			if(param.getReserve_cnt() > 3) {
				travelerDTO = new ReserveRosterVO();
				// 여행자 4
				travelerDTO.setRes_seq(travelerCnt+1);
				if(param.getInwon4_knm() != null) travelerDTO.setNm_kor(param.getInwon4_knm());
				if(param.getInwon4_efname() != null) travelerDTO.setEnm_last(param.getInwon4_efname().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon4_ename() != null) travelerDTO.setEnm_first(param.getInwon4_ename().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon4_handphone1() != null) travelerDTO.setHandphone1(param.getInwon4_handphone1()); 
				if(param.getInwon4_handphone2() != null) travelerDTO.setHandphone2(param.getInwon4_handphone2());
				
				if(param.getInwon4_handphone3() != null) travelerDTO.setHandphone3(param.getInwon4_handphone3());
				// travelerDTO.setJmno(param.getInwon4_ssnL());
				if(param.getInwon4_passYn() != null) travelerDTO.setPp_yn(param.getInwon4_passYn());
				if(param.getInwon4_sex() != null) travelerDTO.setSex(param.getInwon4_sex());
				
				//금액
				if(param.getStart_day() != null){
					
					//유아
					if(param.getInwon4_age() != null && param.getInwon4_age().equals("baby")){
						travelerDTO.setAge_cd("I");
						babyCnt = babyCnt + 1;
						babyPrice = babyPrice + param.getBaby_price();				
						totalAmt = totalAmt + param.getBaby_price(); //예약 총 금액				
					//소아
					}else if(param.getInwon4_age() != null && param.getInwon4_age().equals("child")){
						travelerDTO.setAge_cd("C");
						childCnt = childCnt + 1;
						childPrice = childPrice + param.getChild_price();				
						totalAmt = totalAmt + param.getChild_price(); //예약 총 금액
					//성인
					}else{
						travelerDTO.setAge_cd("A");	
						adultCnt = adultCnt + 1;
						adultPrice = adultPrice + param.getAdult_price();
						totalAmt = totalAmt + param.getAdult_price(); //예약 총 금액
					}
				}
				if(param.getInwon1_pickup_area_cd() != null && !param.getInwon1_pickup_area_cd().equals("undefined")) {

					travelerDTO.setPickup_area_cd(param.getInwon4_pickup_area_cd());
				}
				travelerList.add(travelerDTO);
				travelerCnt ++;
			}
			
			System.out.println(">>>>>>>>>>>>>>>>> 5");
	
			if(param.getReserve_cnt() > 4) {
				travelerDTO = new ReserveRosterVO();
				// 여행자 5
				travelerDTO.setRes_seq(travelerCnt+1);
				if(param.getInwon5_knm() != null) travelerDTO.setNm_kor(param.getInwon5_knm());
				if(param.getInwon5_efname() != null) travelerDTO.setEnm_last(param.getInwon5_efname().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon5_ename() != null) travelerDTO.setEnm_first(param.getInwon5_ename().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon5_handphone1() != null) travelerDTO.setHandphone1(param.getInwon5_handphone1());
				if(param.getInwon5_handphone2() != null) travelerDTO.setHandphone2(param.getInwon5_handphone2());
				
				if(param.getInwon5_handphone3() != null) travelerDTO.setHandphone3(param.getInwon5_handphone3());
				// travelerDTO.setJmno(param.getInwon5_ssnL());
				if(param.getInwon5_passYn() != null) travelerDTO.setPp_yn(param.getInwon5_passYn());
				if(param.getInwon5_sex() != null) travelerDTO.setSex(param.getInwon5_sex());
				
				//금액
				if(param.getStart_day() != null){
					
					//유아
					if(param.getInwon5_age() != null && param.getInwon5_age().equals("baby")){
						travelerDTO.setAge_cd("I");
						babyCnt = babyCnt + 1;
						babyPrice = babyPrice + param.getBaby_price();				
						totalAmt = totalAmt + param.getBaby_price(); //예약 총 금액				
					//소아
					}else if(param.getInwon5_age() != null && param.getInwon5_age().equals("child")){
						travelerDTO.setAge_cd("C");
						childCnt = childCnt + 1;
						childPrice = childPrice + param.getChild_price();				
						totalAmt = totalAmt + param.getChild_price(); //예약 총 금액
					//성인
					}else{
						travelerDTO.setAge_cd("A");	
						adultCnt = adultCnt + 1;
						adultPrice = adultPrice + param.getAdult_price();
						totalAmt = totalAmt + param.getAdult_price(); //예약 총 금액
					}
				}
				if(param.getInwon1_pickup_area_cd() != null && !param.getInwon1_pickup_area_cd().equals("undefined")) {

					travelerDTO.setPickup_area_cd(param.getInwon5_pickup_area_cd());
				}
				travelerList.add(travelerDTO);
				travelerCnt ++;
			}
	
			System.out.println(">>>>>>>>>>>>>>>>> 6");
	
			if(param.getReserve_cnt() > 5) {
				travelerDTO = new ReserveRosterVO();
				// 여행자 6
				travelerDTO.setRes_seq(travelerCnt+1);
				if(param.getInwon6_knm() != null) travelerDTO.setNm_kor(param.getInwon6_knm());
				if(param.getInwon6_efname() != null) travelerDTO.setEnm_last(param.getInwon6_efname().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon6_ename() != null) travelerDTO.setEnm_first(param.getInwon6_ename().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon6_handphone1() != null) travelerDTO.setHandphone1(param.getInwon6_handphone1());
				if(param.getInwon6_handphone2() != null) travelerDTO.setHandphone2(param.getInwon6_handphone2());
				
				if(param.getInwon6_handphone3() != null) travelerDTO.setHandphone3(param.getInwon6_handphone3());
				// travelerDTO.setJmno(param.getInwon6_ssnL());
				if(param.getInwon6_passYn() != null) travelerDTO.setPp_yn(param.getInwon6_passYn());
				if(param.getInwon6_sex() != null) travelerDTO.setSex(param.getInwon6_sex());
				
				//금액
				if(param.getStart_day() != null){
					
					//유아
					if(param.getInwon6_age() != null && param.getInwon6_age().equals("baby")){
						travelerDTO.setAge_cd("I");
						babyCnt = babyCnt + 1;
						babyPrice = babyPrice + param.getBaby_price();				
						totalAmt = totalAmt + param.getBaby_price(); //예약 총 금액				
					//소아
					}else if(param.getInwon6_age() != null && param.getInwon6_age().equals("child")){
						travelerDTO.setAge_cd("C");
						childCnt = childCnt + 1;
						childPrice = childPrice + param.getChild_price();				
						totalAmt = totalAmt + param.getChild_price(); //예약 총 금액
					//성인
					}else{
						travelerDTO.setAge_cd("A");	
						adultCnt = adultCnt + 1;
						adultPrice = adultPrice + param.getAdult_price();
						totalAmt = totalAmt + param.getAdult_price(); //예약 총 금액
					}
				}
				if(param.getInwon1_pickup_area_cd() != null && !param.getInwon1_pickup_area_cd().equals("undefined")) {

					travelerDTO.setPickup_area_cd(param.getInwon6_pickup_area_cd());
				}
				travelerList.add(travelerDTO);
				travelerCnt ++;
			}
			
			System.out.println(">>>>>>>>>>>>>>>>> 7");
	
			if(param.getReserve_cnt() > 6) {
				travelerDTO = new ReserveRosterVO();
				// 여행자 7
				travelerDTO.setRes_seq(travelerCnt+1);
				if(param.getInwon7_knm() != null) travelerDTO.setNm_kor(param.getInwon7_knm());
				if(param.getInwon7_efname() != null) travelerDTO.setEnm_last(param.getInwon7_efname().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon7_ename() != null) travelerDTO.setEnm_first(param.getInwon7_ename().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon7_handphone1() != null) travelerDTO.setHandphone1(param.getInwon7_handphone1());
				if(param.getInwon7_handphone2() != null) travelerDTO.setHandphone2(param.getInwon7_handphone2());
				
				if(param.getInwon7_handphone3() != null) travelerDTO.setHandphone3(param.getInwon7_handphone3());
				// travelerDTO.setJmno(param.getInwon7_ssnL());
				if(param.getInwon7_passYn() != null) travelerDTO.setPp_yn(param.getInwon7_passYn());
				if(param.getInwon7_sex() != null) travelerDTO.setSex(param.getInwon7_sex());
				
				//금액
				if(param.getStart_day() != null){
					
					//유아
					if(param.getInwon7_age() != null && param.getInwon7_age().equals("baby")){
						travelerDTO.setAge_cd("I");
						babyCnt = babyCnt + 1;
						babyPrice = babyPrice + param.getBaby_price();				
						totalAmt = totalAmt + param.getBaby_price(); //예약 총 금액				
					//소아
					}else if(param.getInwon7_age() != null && param.getInwon7_age().equals("child")){
						travelerDTO.setAge_cd("C");
						childCnt = childCnt + 1;
						childPrice = childPrice + param.getChild_price();				
						totalAmt = totalAmt + param.getChild_price(); //예약 총 금액
					//성인
					}else{
						travelerDTO.setAge_cd("A");	
						adultCnt = adultCnt + 1;
						adultPrice = adultPrice + param.getAdult_price();
						totalAmt = totalAmt + param.getAdult_price(); //예약 총 금액
					}
				}
				if(param.getInwon1_pickup_area_cd() != null && !param.getInwon1_pickup_area_cd().equals("undefined")) {

					travelerDTO.setPickup_area_cd(param.getInwon7_pickup_area_cd());
				}
				travelerList.add(travelerDTO);
				travelerCnt ++;
			}
			
			System.out.println(">>>>>>>>>>>>>>>>> 8");
	
			if(param.getReserve_cnt() > 7) {
				travelerDTO = new ReserveRosterVO();
				// 여행자 8
				travelerDTO.setRes_seq(travelerCnt+1);
				if(param.getInwon8_knm() != null) travelerDTO.setNm_kor(param.getInwon8_knm());
				if(param.getInwon8_efname() != null) travelerDTO.setEnm_last(param.getInwon8_efname().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon8_ename() != null) travelerDTO.setEnm_first(param.getInwon8_ename().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon8_handphone1() != null) travelerDTO.setHandphone1(param.getInwon8_handphone1());
				if(param.getInwon8_handphone2() != null) travelerDTO.setHandphone2(param.getInwon8_handphone2());
				
				if(param.getInwon8_handphone3() != null) travelerDTO.setHandphone3(param.getInwon8_handphone3());
				// travelerDTO.setJmno(param.getInwon8_ssnL());
				if(param.getInwon8_passYn() != null) travelerDTO.setPp_yn(param.getInwon8_passYn());
				if(param.getInwon8_sex() != null) travelerDTO.setSex(param.getInwon8_sex());
				
				//금액
				if(param.getStart_day() != null){
					
					//유아
					if(param.getInwon8_age() != null && param.getInwon8_age().equals("baby")){
						travelerDTO.setAge_cd("I");
						babyCnt = babyCnt + 1;
						babyPrice = babyPrice + param.getBaby_price();				
						totalAmt = totalAmt + param.getBaby_price(); //예약 총 금액				
					//소아
					}else if(param.getInwon8_age() != null && param.getInwon8_age().equals("child")){
						travelerDTO.setAge_cd("C");
						childCnt = childCnt + 1;
						childPrice = childPrice + param.getChild_price();				
						totalAmt = totalAmt + param.getChild_price(); //예약 총 금액
					//성인
					}else{
						travelerDTO.setAge_cd("A");	
						adultCnt = adultCnt + 1;
						adultPrice = adultPrice + param.getAdult_price();
						totalAmt = totalAmt + param.getAdult_price(); //예약 총 금액
					}
				}
				if(param.getInwon1_pickup_area_cd() != null && !param.getInwon1_pickup_area_cd().equals("undefined")) {

					travelerDTO.setPickup_area_cd(param.getInwon8_pickup_area_cd());
				}
				travelerList.add(travelerDTO);
				travelerCnt ++;
			}
			
			System.out.println(">>>>>>>>>>>>>>>>> 9");
	
			if(param.getReserve_cnt() > 8) {
				travelerDTO = new ReserveRosterVO();
				// 여행자 9
				travelerDTO.setRes_seq(travelerCnt+1);
				if(param.getInwon9_knm() != null) travelerDTO.setNm_kor(param.getInwon9_knm());
				if(param.getInwon9_efname() != null) travelerDTO.setEnm_last(param.getInwon9_efname().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon9_ename() != null) travelerDTO.setEnm_first(param.getInwon9_ename().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon9_handphone1() != null) travelerDTO.setHandphone1(param.getInwon9_handphone1());
				if(param.getInwon9_handphone2() != null) travelerDTO.setHandphone2(param.getInwon9_handphone2());
				
				if(param.getInwon9_handphone3() != null) travelerDTO.setHandphone3(param.getInwon9_handphone3());
				// travelerDTO.setJmno(param.getInwon9_ssnL());
				if(param.getInwon9_passYn() != null) travelerDTO.setPp_yn(param.getInwon9_passYn());
				if(param.getInwon9_sex() != null) travelerDTO.setSex(param.getInwon9_sex());
				
				//금액
				if(param.getStart_day() != null){
					
					//유아
					if(param.getInwon9_age() != null && param.getInwon9_age().equals("baby")){
						travelerDTO.setAge_cd("I");
						babyCnt = babyCnt + 1;
						babyPrice = babyPrice + param.getBaby_price();				
						totalAmt = totalAmt + param.getBaby_price(); //예약 총 금액				
					//소아
					}else if(param.getInwon9_age() != null && param.getInwon9_age().equals("child")){
						travelerDTO.setAge_cd("C");
						childCnt = childCnt + 1;
						childPrice = childPrice + param.getChild_price();				
						totalAmt = totalAmt + param.getChild_price(); //예약 총 금액
					//성인
					}else{
						travelerDTO.setAge_cd("A");	
						adultCnt = adultCnt + 1;
						adultPrice = adultPrice + param.getAdult_price();
						totalAmt = totalAmt + param.getAdult_price(); //예약 총 금액
					}
				}
				if(param.getInwon1_pickup_area_cd() != null && !param.getInwon1_pickup_area_cd().equals("undefined")) {

					travelerDTO.setPickup_area_cd(param.getInwon9_pickup_area_cd());
				}
				travelerList.add(travelerDTO);
				travelerCnt ++;
			}
			
			System.out.println(">>>>>>>>>>>>>>>>> 10");
	
			if(param.getReserve_cnt() > 9) {
				travelerDTO = new ReserveRosterVO();
				// 여행자 10
				travelerDTO.setRes_seq(travelerCnt+1);
				if(param.getInwon10_knm() != null) travelerDTO.setNm_kor(param.getInwon10_knm());
				if(param.getInwon10_efname() != null) travelerDTO.setEnm_last(param.getInwon10_efname().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon10_ename() != null) travelerDTO.setEnm_first(param.getInwon10_ename().toUpperCase()); /** 강제 대문자로 셋팅 **/
				if(param.getInwon10_handphone1() != null) travelerDTO.setHandphone1(param.getInwon10_handphone1());
				if(param.getInwon10_handphone2() != null) travelerDTO.setHandphone2(param.getInwon10_handphone2());
				
				if(param.getInwon10_handphone3() != null) travelerDTO.setHandphone3(param.getInwon10_handphone3());
				// travelerDTO.setJmno(param.getInwon10_ssnL());
				if(param.getInwon10_passYn() != null) travelerDTO.setPp_yn(param.getInwon10_passYn());
				if(param.getInwon10_sex() != null) travelerDTO.setSex(param.getInwon10_sex());
				
				//금액
				if(param.getStart_day() != null){
					
					//유아
					if(param.getInwon10_age() != null && param.getInwon10_age().equals("baby")){
						travelerDTO.setAge_cd("I");
						babyCnt = babyCnt + 1;
						babyPrice = babyPrice + param.getBaby_price();				
						totalAmt = totalAmt + param.getBaby_price(); //예약 총 금액				
					//소아
					}else if(param.getInwon10_age() != null && param.getInwon10_age().equals("child")){
						travelerDTO.setAge_cd("C");
						childCnt = childCnt + 1;
						childPrice = childPrice + param.getChild_price();				
						totalAmt = totalAmt + param.getChild_price(); //예약 총 금액
					//성인
					}else{
						travelerDTO.setAge_cd("A");	
						adultCnt = adultCnt + 1;
						adultPrice = adultPrice + param.getAdult_price();
						totalAmt = totalAmt + param.getAdult_price(); //예약 총 금액
					}
				}
				if(param.getInwon1_pickup_area_cd() != null && !param.getInwon1_pickup_area_cd().equals("undefined")) {

					travelerDTO.setPickup_area_cd(param.getInwon10_pickup_area_cd());
				}
				travelerList.add(travelerDTO);
				travelerCnt ++;
			}
			
			System.out.println(">>>>>>>>>>>>>>>>> 11");
	
			
	    	///////////////////////////////////////// 응답 코드 //////////////////////////////////////
	    	String resCd = "";
	    	String resMessage = "";
	    	//////////////////////////////////////////////////////////////////////////////////////
	    	
	    	Calendar today = Calendar.getInstance();
	    	String yyyy = Integer.toString(today.get(Calendar.YEAR));
	    	String mm = Integer.toString(today.get(Calendar.MONTH)+1);
	    	String dd = Integer.toString(today.get(Calendar.DATE));
	    	
	    	if(mm.length() == 1){
	    		mm = "0"+mm;
	    	}
	    	
	    	/*오늘날짜*/
	    	String today_str = yyyy+""+mm+""+dd;
	    	
	    	/*출발일*/
	    	String eventCd = param.getEvent_cd();
	    	String startDay = "20"+eventCd.substring(7, 13);
	    	
	    	/*결과*/
	    	String gubun = "Y";
	    	
	    	String comp_cd = "";
	    	
	    	if(!param.getComp_cd().equals("")) {
	    		comp_cd = param.getComp_cd().substring(0, param.getComp_cd().lastIndexOf(","));
	    		System.out.println("comp_cd >>>>>>>>>>> " + comp_cd);
	    		
	    	} else {
	    		comp_cd = "LT";
	    	}
	    	
	    	/** 업무 구분 코드 조회 **/
	    	Map<String, Object> paramMap = new HashMap<String, Object>();
	    	paramMap.put("goods_cd", goodsCd);
	    	paramMap.put("comp_cd", comp_cd);
	    	
	    	String opCd = (String) reserveService.srchGoodsOpCd(paramMap);
	    	
	    	// 출발일 국내 2일, 해외 4일 체크 
	    	if("OT".equals(opCd)){
	    		if( Integer.parseInt(startDay) - Integer.parseInt(today_str) < 4){ // 해외 
	    			gubun = "N";
	    		}
	    	}else{
	    		if( Integer.parseInt(startDay) - Integer.parseInt(today_str) < 2){ // 국내 
	    			gubun = "N";
	    		}	            		
	    	}
	    	
	    	//샤롯데행사 제외:ZEZ0015
	    	String chkGdCd = eventCd.substring(0, 7);
	
	    	if("ZEZ0015".equals(chkGdCd)){
	    		gubun = "Y";
	    	}
	    	
	    	if("N".equals(gubun)){
		    	resCd = "COME2042";
		    }	 
	    	///////////////////////////////////////////////////////////////////////
	    	// 비회원 예약의 경우 >> 회원 정보 등록 
	    	///////////////////////////////////////////////////////////////////////    
	    	// cust_cd 가 없는 경우 비회원으로 인식 
	    	param.setIs_new_reg("N");
	    	
	    	System.out.println(" >>>>>>>>>>>>>>>>>>>>>>>>>> cust_cd :  " + param.getCust_cd());
	    	
	    	if(param.getCust_cd() == null || param.getCust_cd().equals("")) {
	    		param.setIs_new_reg("Y");
	    		System.out.println(" >>>>>>>>>>>>>>>>>>>>>>>>>> 비회원 예약 인 경우 ");
	    		
			}
	
	    	CUMstVO guestVO = new CUMstVO();
	    	String cust_cd = "";
	    	if(param.getIs_new_reg().equals("Y")) {
	    		
	    		// 성함 및 핸드폰 번호로 조회 
	    		
	    		Map guestParam = new HashMap<String, Object>();
	    		
	    		guestParam.put("knm", param.getRes_nm());
	    		guestParam.put("handphone1",  param.getDp_handphone1());
	       		guestParam.put("handphone2",  param.getDp_handphone2());
	       		guestParam.put("handphone3",  param.getDp_handphone3());
	       		
	       		// 비회원 예약의 경우 CUST_CD 조회
	       		cust_cd =  reserveService.srchCustCd02(guestParam);
	       		System.out.println("  reserveService.srchCustCd02 >>>>>>>>>>>>>>>>> " + cust_cd);
	       		
	    		// 비회원 예약의 경우 시퀀스 생성 
	       		if(cust_cd == null || cust_cd.equals("")) {
	       			cust_cd = reserveService.srchCustCd(guestVO);
	       			System.out.println("  reserveService.srchCustCd >>>>>>>>>>>>>>>>> " + cust_cd);
		    		param.setCust_cd(cust_cd);
		    		
		    		guestVO.setCust_cd(cust_cd);
		    		if(param.getDp_nm() != null) guestVO.setKnm(param.getDp_nm());
		    		if(param.getJmno() != null) guestVO.setJmno(param.getJmno());
		    		if(param.getEmail() != null) guestVO.setEmail(param.getEmail());
		    		
		    		if(param.getDp_handphone1() != null && !param.getDp_handphone1().equals("undefined")) guestVO.setHandphone1(param.getDp_handphone1());
		    		else guestVO.setHandphone1("010");
		    		
		    		if(param.getDp_handphone2() != null) guestVO.setHandphone2(param.getDp_handphone2());
		    		if(param.getDp_handphone3() != null) guestVO.setHandphone3(param.getDp_handphone3());
		    		guestVO.setIns_id("MOBILEUSER");
		    		
		    		try {
			    		// 비회원 예약 등록 
			    		reserveService.saveMember(guestVO);	       			
		    		} catch (Exception e) {
		    			System.out.println("reserveService.saveMember(guestVO) >>>>>>>>>>>>>> Error !!!! : " + e.getMessage());
		    		}
		    	} else {
	       			param.setCust_cd(cust_cd);
	       		}
	    		

	    	}
			System.out.println(">>>>>>>>>>>>>>>>> 12");
	
	    	/** 프론트용 롯데 아이디 조회 **/
	    	paramMap = new HashMap<String, Object>();
	    	paramMap.put("cust_cd", param.getCust_cd());
	    	
	    	String strLotteID = (String) reserveService.srchLotteID(paramMap);
	    	
	    	
	    	paramMap = new HashMap<String, Object>();
	    	paramMap.put("goods_type_cd", gdTypeCd);
			System.out.println(">>>>>>>>>>>>>>>>> 13");  	
	    	/** 예약 번호 조회  **/    	
	    	String res_cd = (String) reserveService.srchResCd(paramMap);
	    	if(res_cd != null) param.setRes_cd(res_cd);
	    	
	    	ManagerDTO paramManager = new ManagerDTO();
	    	if(param.getEvent_cd() != null) paramManager.setEvent_cd(param.getEvent_cd());
	    	if(comp_cd != null) paramManager.setComp_cd(comp_cd);
	    	if(goodsCd != null) paramManager.setGoods_cd(goodsCd);
	    	
	    	
			System.out.println(">>>>>>>>>>>>>>>>> 14");
	    	/** 프론트 행사 담당자 조회 **/   	
	    	ManagerDTO resultManager = (ManagerDTO) reserveService.srchEventManager(paramManager);
	    	if(resultManager == null) resultManager = new ManagerDTO();
	    	
	    	String cha_id = resultManager.getCha_id();
	    	String cha_dept_cd = resultManager.getCha_dept_cd();
	    	String mobile = resultManager.getMobile();
	    	
	    	if(cha_id != null) param.setCha_id(cha_id);
	    	if(cha_dept_cd != null)param.setCha_dept_cd(cha_dept_cd);
	    	
	    	System.out.println ("cha_id >>>>>>>>>>>>>>>>>>>> " + cha_id);
	    	System.out.println ("cha_dept_cd >>>>>>>>>>>>>>>>>>>> " + cha_dept_cd);
	    	
			
	    	SyCdDetVO mallParam = new SyCdDetVO();
	    	if(comp_cd != null) mallParam.setComp_cd(comp_cd);
	    	
	    	/** 몰 관련 정보 조회 **/
	    	SyCdDetVO resultMallCd = (SyCdDetVO) reserveService.srchMallCd(mallParam);  
			System.out.println(">>>>>>>>>>>>>>>>> 15");
			
	    	String site_cd = "";
	    	if(resultMallCd != null) {
	    		site_cd = resultMallCd.getSite_cd();
	    		// param.setMass_site_cd(resultMallCd.getCd());
	    	}
	    	
	        if (site_cd.equals("000002")) 
	        {
	
		        // param.setRes_day(DateUtil.toDateString());
		    	   	
		    	param.setCha_id("hnyang");
		    	param.setCha_dept_cd("532109");
		    	param.setSale_id("hnyang");
		    	param.setSale_dept_cd("532109");
		    	param.setIns_id("MOBILEUSER"); 
		    	param.setUpd_id("MOBILEUSER");
		    	
	        } else {
	
	        	// param.setRes_day(DateUtil.toDateString());
	        	param.setCha_id(cha_id);
	        	param.setCha_dept_cd(cha_dept_cd);
	        	param.setSale_id(cha_id);
	        	param.setSale_dept_cd(cha_dept_cd);
		    	param.setIns_id("MOBILEUSER"); 
		    	param.setUpd_id("MOBILEUSER");
	        }
	
	        System.out.println ("param.getCha_id() >>>>>>>>>>>>>>>>>>>> " + param.getCha_id());
	        System.out.println ("param.getCha_dept_cd() >>>>>>>>>>>>>>>>>>>> " + param.getCha_dept_cd());
	        System.out.println ("param.getSale_id() >>>>>>>>>>>>>>>>>>>> " + param.getSale_id());
	        System.out.println ("param.getSale_dept_cd() >>>>>>>>>>>>>>>>>>>> " + param.getSale_dept_cd());
	        
	        if(site_cd != null) param.setSite_cd(site_cd);
	        if(custCd != null) param.setCust_id(custCd);
	    	
	    	int blockNum = 0; // 블록 수 
	    	int realCnt = 0; // 실제 예약수 
	    	int currCnt = 0; // 현재 예약 인원 수 
	    	int totalCnt = 0; // 총 예약 건수 
	    	
	    	// 항공 이나 호텔이 아닌 경우 
	    	if(!gdTypeCd.startsWith("H") && !gdTypeCd.startsWith("A")) {
	    		
	    		
	    		AirsBlockDTO paramAirsBlock = new AirsBlockDTO();
	    		if(param.getEvent_cd() != null) paramAirsBlock.setEvent_cd(param.getEvent_cd());
	    		/** 항공 블록 수 조회 **/
	    		AirsBlockDTO resultAirsBlock = (AirsBlockDTO) reserveService.srchAirBlocks(paramAirsBlock);
	    		
	    		if(resultAirsBlock == null) resultAirsBlock = new AirsBlockDTO();
	    		
	    		System.out.println(">>>>>>>>>>>>>>>>> 16");
	    		blockNum = resultAirsBlock.getEvent_block();
	    		realCnt = resultAirsBlock.getReal_cnt();
	    		currCnt = param.getReserve_cnt();
	    		
	    		totalCnt = realCnt + currCnt;
	    		if ( blockNum>=totalCnt ) {
	    			res_cd = "00000000";
	    			logger.info("예약상태 세팅: 0000");
	    		} else {
	    			res_cd = "COME2040";
	    			logger.info("예약상태 에러 : 인원 초과 " + "COME2040");
	    			errCode = "COME2040";
	    			throw new Exception();
	    		}
	    		
	    		/** 예약 완료 상품 여부 조회 **/
	    		mallParam = new SyCdDetVO();
	    		if(comp_cd != null) mallParam.setComp_cd(comp_cd);
	        	
	    	    SyCdDetVO resultResconfirmReserv = (SyCdDetVO) reserveService.srchResconfirmGoods(mallParam);  
	    	    if(resultResconfirmReserv == null) resultResconfirmReserv = new SyCdDetVO();
	    	    
	    	    System.out.println(">>>>>>>>>>>>>>>>> 17");
	    	    String chkEventCd = resultResconfirmReserv.getEvent_cd();
	        	res_day = resultResconfirmReserv.getRes_day();
	        	
	        	if ( chkEventCd !=null && !"".equals(chkEventCd)) {
	        		param.setStatus_cd("01"); // 예약 완료 
	        	}
	        	
	    	    
	        	
	    	} else if(gdTypeCd.startsWith("H")) {
	    		param.setStatus_cd("H9"); // 예약 대기  
	    		
	    	} else if(gdTypeCd.startsWith("A")) {
	    		param.setStatus_cd("01"); // 예약 대기  
	    	}
	    	
	    	param.setTotalcnt(param.getReserve_cnt());
	    	
	    	/** 제휴사 수수료 조회 **/
	    	paramMap = new HashMap<String, Object>();
	    	paramMap.put("site_cd", site_cd);
	    	int comm_rate = reserveService.srchCoopCommRate(paramMap);
	    	
	    	
	    	/** 대표자 예약자 정보 등록 **/
	    	param.setEvent_amt(totalAmt);
			param.setSale_amt(totalAmt);
			param.setAcc_yn("N");
			
			
	    	// --------------------------------------------------------------------------------------------------------------
	    	// 모바일 유입코드  2017.04.05 그랜드 오픈 용 
	    	// 대분류(MASS_FG) : 03
	    	// 중분류(MASS_CD) : LTB
	    	// 소분류(MASS_SITE_CD) : LM    	
	    	// --------------------------------------------------------------------------------------------------------------	    	
	    	param.setMass_fg("03");
	    	param.setMass_cd("LTB");
	    	//param.setMass_site_cd("LM");
	    	
			try {
				reserveService.saveReserve(param);
			} catch (Exception e) {
				//e.printStackTrace();
				System.out.println(" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> reserveService.saveReserve() Exception : " + e.getMessage());
				param.setRes_cd("");
			}
	    	
	    	System.out.println(">>>>>>>>>>>>>>>>> 18");
	    	System.out.println(">>>>>>>>>>>>>>>>> travelerList.size() : " + travelerList.size());
	    	/** 예약자 1 ~ 10 등록 **/
	    	if(travelerList != null && travelerList.size() > 0) {
	    		for(int idx = 0; idx < travelerList.size(); idx++) {
	    			ReserveRosterVO travelerVO = (ReserveRosterVO) travelerList.get(idx);
	    			
	    			System.out.println(">>>>>>>>>>>>>>>>> ReserveRosterVO seq : " + travelerVO.getRes_seq());
	    			System.out.println(">>>>>>>>>>>>>>>>> ReserveRosterVO nm_kor : " + travelerVO.getNm_kor());
	    			System.out.println(">>>>>>>>>>>>>>>>> ReserveRosterVO enm_first : " + travelerVO.getEnm_first());
	    			System.out.println(">>>>>>>>>>>>>>>>> ReserveRosterVO enm_last : " + travelerVO.getEnm_last());
	    			
	    			
		    		Map guestParam = new HashMap<String, Object>();
		    		
		    		guestParam.put("knm", travelerVO.getNm_kor());
		    		guestParam.put("handphone1",  travelerVO.getHandphone1());
		       		guestParam.put("handphone2",  travelerVO.getHandphone2());
		       		guestParam.put("handphone3",  travelerVO.getHandphone3());
		       		
		       		// 비회원 예약의 경우 CUST_CD 조회
		       		String guest_cust_cd =  reserveService.srchCustCd02(guestParam);
		       		
		       		// 여행자 정보 중 CUST_CD 불일치건 수정 후 조치함. 2017.05.22)
		       		
		       		if(param.getDp_nm().equals(travelerVO.getNm_kor()) && param.getDp_equalsFlag().equals("Y")) {
		       			travelerVO.setCust_cd(param.getCust_cd());		       			
		       		} else {
		       			
			    		// 비회원 예약의 경우 시퀀스 생성 
			       		if(guest_cust_cd == null || guest_cust_cd.equals("")) {
			       			guest_cust_cd = reserveService.srchCustCd(guestVO);
			       			System.out.println(" >>>>>>> (travelerList) reserveService.srchCustCd >>>>>>>>>>>>>>>>> " + guest_cust_cd);
				    		
				    		
			       			CUMstVO guestVO2 = new CUMstVO();
			       			guestVO2.setCust_cd(guest_cust_cd);
			       			if(travelerVO.getNm_kor() != null) guestVO2.setKnm(travelerVO.getNm_kor());
			       			// guestVO2.setJmno(param.getJmno());
			       			if(travelerVO.getEmail() != null) guestVO2.setEmail(travelerVO.getEmail());
				    		guestVO2.setIns_id("MOBILEUSER");
				    		
				    		try {
					    		// 비회원 예약 등록 
					    		reserveService.saveMember(guestVO2);	       			
				    		} catch (Exception e) {
				    			System.out.println(" >>>>>>> (travelerList) reserveService.saveMember(guestVO) >>>>>>>>>>>>>> Error !!!! : " + e.getMessage());
				    		}
				    		travelerVO.setCust_cd(guest_cust_cd);
				    		//travelerVO.setCust_cd(guest_cust_cd);
			       		} else {
			       			travelerVO.setCust_cd(guest_cust_cd);
			       			//travelerVO.setCust_cd(guest_cust_cd);
			       		}
			       		
		       			
		       		}
		       		
	    			/** 예약자 인원별 정보 셋팅 **/
		       		
	    			travelerVO.setRes_cd(param.getRes_cd());
	    			travelerVO.setRes_day(param.getRes_day());
	    			System.out.println(">>>>>>>>>>>>>>>>> ReserveRosterVO res_day  : " + param.getRes_day());
	    			if(travelerVO.getAge_cd().equals("A")) {
	    				travelerVO.setEvent_amt(param.getAdult_base_price());
	    				travelerVO.setSale_amt(param.getAdult_price());
	    				travelerVO.setFull_amt_w(param.getAdult_price());
	    				travelerVO.setAdd_amt(param.getEtc_price1());
	    				// travelerVO.setRes_day(res_day);
	    				travelerVO.setComp_comm_rate(comm_rate);
	    				travelerVO.setComp_comm(comm_rate);
	    				travelerVO.setIns_id("MOBILEUSER");
	    				travelerVO.setUpd_id("MOBILEUSER");    				
	    			} else if(travelerVO.getAge_cd().equals("C")) {
	    				travelerVO.setEvent_amt(param.getChild_base_price());
	    				travelerVO.setSale_amt(param.getChild_price());
	    				travelerVO.setFull_amt_w(param.getChild_price());
	    				travelerVO.setAdd_amt(param.getEtc_price2());
	    				// travelerVO.setRes_day(res_day);
	    				travelerVO.setComp_comm_rate(comm_rate);
	    				travelerVO.setComp_comm(comm_rate);
	    				travelerVO.setIns_id("MOBILEUSER");
	    				travelerVO.setUpd_id("MOBILEUSER");    			
	    				
	    			} else if(travelerVO.getAge_cd().equals("I")) {
	    				travelerVO.setEvent_amt(param.getBaby_base_price());
	    				travelerVO.setSale_amt(param.getBaby_price());
	    				travelerVO.setFull_amt_w(param.getBaby_price());
	    				travelerVO.setAdd_amt(param.getEtc_price3());
	    				// travelerVO.setRes_day(res_day);
	    				travelerVO.setComp_comm_rate(comm_rate);
	    				travelerVO.setComp_comm(comm_rate);
	    				travelerVO.setIns_id("MOBILEUSER");
	    				travelerVO.setUpd_id("MOBILEUSER");    	    			
	    			}
	    			// travelerVO.setRes_day(res_day);
	    			try {
		    			// 예약자 정보 등록 
		    			reserveService.saveReserveRosters(travelerVO);
	    			} catch (Exception e) {
	    				//e.printStackTrace();
	    				System.out.println(" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> reserveService.saveReserveRosters() Exception : " + e.getMessage());
	    				param.setRes_cd("");
	    			}
	    		}  		
	    	}
	    	System.out.println(">>>>>>>>>>>>>>>>> 19");
	    	
	    	String mktAgreeYn = (String) request.getParameter("mktAgreeYn");
	    	String childAgreeYn = (String) request.getParameter("childAgreeYn");
	    	String smsAgreeYn = (String) request.getParameter("smsAgreeYn");
	    	String emailAgreeYn = (String) request.getParameter("emailAgreeYn");	    	
	    	
	    	if(!param.getRes_cd().equals("")) {
	    		
		    	// ---------------------------------------------------------------------------------
		    	// 마케팅 활용 정보 동의 여부 및 14세 미만 이용약관 동의 여부 업데이트 
		    	// ---------------------------------------------------------------------------------
	    		RvPerInfoVO rvPerInfoVO = new RvPerInfoVO();
	    		rvPerInfoVO.setResCd(param.getRes_cd());
	    		rvPerInfoVO.setResSeq(1);
	    		rvPerInfoVO.setSendYn("");
	    		rvPerInfoVO.setAgreeYn("Y");
	    		rvPerInfoVO.setAgreeType("05");
	    		rvPerInfoVO.setInsId("MOBILEUSER");
	    		rvPerInfoVO.setMktAgreeYn(mktAgreeYn);
	    		rvPerInfoVO.setChildAgreeYn(childAgreeYn);
	    		rvPerInfoVO.setSmsAgreeYn(smsAgreeYn);
	    		rvPerInfoVO.setEmailAgreeYn(emailAgreeYn);
	    		rvPerInfoVO.setCustCd(cust_cd);
	    		rvPerInfoVO.setUpdId("MOBILEUSER");
	    		try {
	    			
	    			reserveService.saveRvPerInfo(rvPerInfoVO);
	    			System.out.println("마케팅 활용 정보 동의 여부 및 14세 미만 이용약관 동의 여부 업데이트 " + param.getRes_cd());
	    			
	    		} catch (Exception e) {
					//e.printStackTrace();
					System.out.println("RV_PER_INFO INSERT FAIL !!!!!! " + e.getMessage());	    			
	    		}
	    		
	    		
	    		RvPerInfoHisVO rvPerInfoHisVO = new RvPerInfoHisVO();
	    		rvPerInfoHisVO.setResCd(param.getRes_cd());
	    		rvPerInfoHisVO.setResSeq(1);
	    		rvPerInfoHisVO.setHisNo(1);
	    		rvPerInfoHisVO.setSendYn("");
	    		rvPerInfoHisVO.setAgreeYn("Y");
	    		rvPerInfoHisVO.setAgreeType("05");
	    		if(param.getDp_handphone1() != null) rvPerInfoHisVO.setHandphone1(param.getDp_handphone1());
	    		if(param.getDp_handphone2() != null) rvPerInfoHisVO.setHandphone2(param.getDp_handphone2());
	    		if(param.getDp_handphone3() != null) rvPerInfoHisVO.setHandphone3(param.getDp_handphone3());
	    		rvPerInfoHisVO.setInsId("MOBILEUSER");
	    		rvPerInfoHisVO.setUpdId("MOBILEUSER");
	    		rvPerInfoHisVO.setMktAgreeYn(mktAgreeYn);
	    		rvPerInfoHisVO.setChildAgreeYn(childAgreeYn);
	    		rvPerInfoHisVO.setSmsAgreeYn(smsAgreeYn);
	    		rvPerInfoHisVO.setEmailAgreeYn(emailAgreeYn);	    		
	    		
	    		
	    		try {
	    			reserveService.saveRvPerInfoHis(rvPerInfoHisVO);
	    			System.out.println("마케팅 활용 정보 동의 여부 및 14세 미만 이용약관 동의 여부 업데이트 2 " + param.getRes_cd());
	    		} catch (Exception e) {
					//e.printStackTrace();
					System.out.println("RV_PER_INFO_HIS INSERT FAIL !!!!!! " + e.getMessage());	    			
	    		}
	    		
		    	/**
		    	 * ----------------------------------------------------------------------------------
		    	 * SMS 발송 연동 
		    	 * ----------------------------------------------------------------------------------
		    	 */
		    	try {
		    		
		    		Map<String, Object> serialParam = new HashMap<String, Object>();
		    		int serialno = (Integer)  reserveService.srchSmsSeq(serialParam);
		    		
		    		System.out.println(" >>>>>>>>>>>>>>>>> SMS umskey >>> " + serialno);
		    		
			    	SmsVO smsSendParam = new SmsVO();
			    	String cellNo = "02-6313-8000";
	
			    	
			    	if("000002".equals(site_cd))
			    		cellNo = "1899-3325"; //닷컴유입
			    	
			    	String REMARK = reserveService.selectKakaoSmsSend(param.getRes_cd());
			    	String REMARK_AGENT = reserveService.selectKakaoSmsSend2(param.getRes_cd()); 
			    	//String smsCnt = "[롯데제이티비]예약이 완료되었습니다.";
			    	//smsCnt = smsCnt + "(예약번호:" + param.getRes_cd() + ")마이투어에서 확인.";
			    	smsSendParam.setSerialno(serialno); 
			    	smsSendParam.setDestcallno(param.getDp_handphone1()+"-"+param.getDp_handphone2()+"-"+param.getDp_handphone3());
			    	smsSendParam.setCallbackno(cellNo);
			    	smsSendParam.setSmsdata(REMARK);
			    	smsSendParam.setSubject("0101"); // smsDto.setUMS_DET_CD("0101");
			    	smsSendParam.setReserved("online");
			    	smsSendParam.setRes_cd(param.getRes_cd());
			    	smsSendParam.setRemark(REMARK_AGENT);
			    	// smsSendParam.setCust_cd(cust_cd);
			    	// smsSendParam.setIns_id("online");
		    				    		
		    		//reserveService.saveSmsSend(smsSendParam);
	    			reserveService.saveKakaoSmsSend(smsSendParam);
	    				    			
	    			System.out.println(">>>>>>>>>>>>>>>>> SMS SEND COMPLETE !!!!!! ");
	    					    		
	    			// ------------------------------------------------------------------------------
	    			// SMS UMS 로그 남기기 
					// -- SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
					// -- 2268019	SMS	3796419	0101	P161219-0001	0000000081	[롯데JTB]예약이 완료되었습니다.(예약번호:P161219-0001)마이투어에서 확인.				2016/12/19 16:57:00	online
	    			// ------------------------------------------------------------------------------  			
	    			UmsLogVO umsLogParam = new UmsLogVO();
	    			umsLogParam.setUms_fg_cd("SMS");
	    			umsLogParam.setUms_det_cd("0101");
	    			umsLogParam.setUmskey(String.valueOf(serialno));
	    			umsLogParam.setCust_cd(cust_cd);
	    			umsLogParam.setRes_cd(param.getRes_cd());
	    			umsLogParam.setUms_desc(REMARK);
	    			umsLogParam.setIns_id("online");
	    			
	    			//reserveService.saveUmsLog(umsLogParam);
	    			
	    			System.out.println(">>>>>>>>>>>>>>>>> SMS SEND UMS LOG SAVE !!!!!! ");
	    			
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
		    		
		    		emsMailSendParam.setMail_code("001");
		    		emsMailSendParam.setMail_nm("예약완료");
		    		emsMailSendParam.setTo_name(param.getRes_nm());
		    		emsMailSendParam.setTo_email(param.getDp_email1()+"@"+param.getDp_email2());
		    		
		    		String mail_url_mapping = "RES_CD=" + param.getRes_cd();
		    		emsMailSendParam.setMail_url_mapping(mail_url_mapping);
		    		emsMailSendParam.setSubject("예약이 완료되었습니다.");
		    		emsMailSendParam.setFrom_email("webmaster@lottejtb.com");
		    		emsMailSendParam.setFrom_name("롯데제이티비");
		    		emsMailSendParam.setReg_dt(param.getRes_day());
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
	    			umsLogParam.setUms_det_cd("0101");
	    			umsLogParam.setUmskey(String.valueOf(serialno));
	    			umsLogParam.setCust_cd(cust_cd);
	    			umsLogParam.setRes_cd(param.getRes_cd());
	    			umsLogParam.setUms_desc("예약이 완료되었습니다.");
	    			umsLogParam.setIns_id("online");
	    			
	    			reserveService.saveUmsLog(umsLogParam);
	    			
	    			System.out.println(">>>>>>>>>>>>>>>>> EMS MAIL SEND UMS LOG SAVE !!!!!! ");
		    		
		    	} catch (Exception e) {
					//e.printStackTrace();
					System.out.println("EMS MAIL SEND FAIL !!!!!! " + e.getMessage());	    		
		    	}
		    	
		    	System.out.println(">>>>>>>>>>>>>>>>> UMS/SMS SEND COMPLETE !!!!!! ");
		    	
		    	
		    	/**
		    	 * ----------------------------------------------------------------------------------
		    	 * SMS 발송 연동  (행사 담당자에게 SMS 전송)
		    	 * ----------------------------------------------------------------------------------
		    	 */
		    	
		    	if(mobile != null && !mobile.equals("")) {
			    	try {
			    		
			    		Map<String, Object> serialParam = new HashMap<String, Object>();
			    		int serialno = (Integer)  reserveService.srchSmsSeq(serialParam);
			    		
			    		System.out.println(" >>>>>>>>>>>>>>>>> SMS umskey >>> " + serialno);
			    		
				    	SmsVO smsSendParam = new SmsVO();
				    	String cellNo = "02-6313-8000";
					    	
				    	if("000002".equals(site_cd))
				    		cellNo = "1899-3325"; //닷컴유입
		
				    	String smsCnt = "[롯데제이티비] 모바일 예약이 접수되었습니다.";
				    	smsCnt = smsCnt + "(예약번호:" + param.getRes_cd() + ")";
				    	smsSendParam.setSerialno(serialno); 
				    	smsSendParam.setDestcallno(mobile);
				    	smsSendParam.setCallbackno(cellNo);
				    	smsSendParam.setSmsdata(smsCnt);
				    	smsSendParam.setSubject("0101"); // smsDto.setUMS_DET_CD("0101");
				    	smsSendParam.setReserved("online");
				    	// smsSendParam.setCust_cd(cust_cd);
				    	// smsSendParam.setIns_id("online");
			    					    		
		    			reserveService.saveSmsSend(smsSendParam);
		    			
		    			System.out.println(">>>>>>>>>>>>>>>>> 담당자에게 SMS SEND COMPLETE !!!!!! ");
		    						    		
		    			// ------------------------------------------------------------------------------
		    			// SMS UMS 로그 남기기 
						// -- SEQ	UMS_FG_CD	UMSKEY	UMS_DET_CD	RES_CD	CUST_CD	UMS_DESC	TRANS_CD	TRANS_DT	TRANS_ERR	INS_DT	INS_ID
						// -- 2268019	SMS	3796419	0101	P161219-0001	0000000081	[롯데JTB]예약이 완료되었습니다.(예약번호:P161219-0001)마이투어에서 확인.				2016/12/19 16:57:00	online
		    			// ------------------------------------------------------------------------------  			
		    			/**
		    			UmsLogVO umsLogParam = new UmsLogVO();
		    			umsLogParam.setUms_fg_cd("SMS");
		    			umsLogParam.setUms_det_cd("0101");
		    			umsLogParam.setUmskey(String.valueOf(serialno));
		    			umsLogParam.setCust_cd(cust_cd);
		    			umsLogParam.setRes_cd(param.getRes_cd());
		    			umsLogParam.setUms_desc(smsCnt);
		    			umsLogParam.setIns_id("online");
		    			
		    			reserveService.saveUmsLog(umsLogParam);
		    			**/
		    			// System.out.println(">>>>>>>>>>>>>>>>> 담당자에게 SMS SEND UMS LOG SAVE !!!!!! ");
		    			
			    	} catch (Exception e) {
						//e.printStackTrace();
						System.out.println("SMS SEND FAIL !!!!!! " + e.getMessage());
					}
			    			    	
		    	}
	    	} 
	    	
	    	model.addAttribute("resCd", param.getRes_cd());
		} catch (Exception e) {
			//e.printStackTrace();
			System.out.println(" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Exception : " + e.getMessage());
			if("COME2040".equals(errCode)){
				param.setAcc_yn("N");
			}
			param.setRes_cd("");
			model.addAttribute("resCd", param.getRes_cd());
			model.addAttribute("accYn", param.getAcc_yn());
		}
		
		return "jsonView";
	}
	
	// <!--  시스템 코드 조회   -->
	@RequestMapping(value = "/reserve/srchSysComCodeAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String srchSysComCodeAjax(@ModelAttribute("ComCodeVO") ComCodeVO param, ModelMap model)throws Exception{
		
		/** 시스템 코드 조회 **/
		List comcodeList =  reserveService.srchComCode(param);		
		model.addAttribute("comcodeList", comcodeList);
		
		return "jsonView";
	}
		
	
}
