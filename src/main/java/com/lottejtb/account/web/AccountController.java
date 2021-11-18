package com.lottejtb.account.web;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.lottejtb.account.service.LPointService;
import com.lottejtb.account.service.LPointVO;
import com.lottejtb.account.service.PaymentVO;
import com.lottejtb.account.service.RvPaymentVO;
import com.lottejtb.comm.service.CommFileService;
import com.lottejtb.comm.util.CommInfo;
import com.lottejtb.goods.rn.service.RNETMstVO;
import com.lottejtb.goods.rn.service.RNGDTagsVO;
import com.lottejtb.goods.rn.service.RNGoodsService;
import com.lottejtb.reserve.service.ReserveRosterVO;
import com.lottejtb.reserve.service.ReserveService;
import com.lottejtb.reserve.service.ReserveVO;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class AccountController {

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
    @Resource(name = "ehcache")
    Ehcache ehcache;
		
    @Resource(name = "CommFileService")
    private CommFileService fileService;

	// 상품 상세 정보 관련 서비스 신규 
	@Resource(name = "RNGoodsService")
	private RNGoodsService rnGoodsService;
	
	// 예약 정보 관련 서비스 
	@Resource(name = "ReserveService")
	private ReserveService reserveService;
	
	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/account";
	
    @Resource(name = "LPointService")
    private LPointService lpointService;

	@RequestMapping(value = "/account/pay.do", method = RequestMethod.GET )
	public String pay(@RequestParam("resCd") String resCd, HttpServletRequest request, Model model) throws Exception {
	    
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
		
		String cno	=	"";
		String mblNo	=	"";
		
		if(sessionParam != null){
			if(sessionParam.get("mblNo") != null)
				mblNo = sessionParam.get("mblNo").toString();
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
		}
		
		System.out.println("[JEH]================예약 정보 마스터 조회======");
		/** 예약 정보 마스터 조회 **/
		ReserveVO reserveParam = new ReserveVO();
		reserveParam.setRes_cd(resCd);
		
		ReserveVO resvMst = (ReserveVO) reserveService.srchReserve(reserveParam);
		
		System.out.println("[JEH]================예약자 수======");
		/** 예약자 수 **/
		ReserveRosterVO rosterParam = new ReserveRosterVO();
		rosterParam.setRes_cd(resCd);
		
		List reservRosterList = (List) reserveService.srchReserveRosters(rosterParam);
		
		System.out.println("[JEH]================행사 상품 태그 조회======");
		/** 행사 상품 태그 조회 **/
		RNGDTagsVO rnGDTagsParam = new RNGDTagsVO();
		rnGDTagsParam.setEvent_cd(resvMst.getEvent_cd());
		
		RNGDTagsVO rnGDTagsResult = new RNGDTagsVO();
		rnGDTagsResult = (RNGDTagsVO) rnGoodsService.srchGDTags(rnGDTagsParam);
		
		String goodsCd = "";
		
		System.out.println("[JEH]================이벤트 코드 체크======");
		if(resvMst.getEvent_cd() != null && !resvMst.getEvent_cd().equals("")) { 
			goodsCd = resvMst.getEvent_cd().substring(0, 7);
		}
		
		System.out.println("[JEH]================행사 상품 이벤트 조회======");
		/** 행사 상품 이벤트 조회 **/
		RNETMstVO rnEtMstParam = new RNETMstVO();
		rnEtMstParam.setEvent_cd(resvMst.getEvent_cd());
		rnEtMstParam.setComp_cd(rnGDTagsResult.getComp_cd());
		rnEtMstParam.setGoods_cd(goodsCd);

		RNETMstVO rnEtMstResult = new RNETMstVO();
		rnEtMstResult = (RNETMstVO) rnGoodsService.srchETMst2(rnEtMstParam);	
		
		System.out.println("[JEH]================Attribute setting======");
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("email", email);
		model.addAttribute("age", age);
		model.addAttribute("id", id);		
		model.addAttribute("sex", sex);
		model.addAttribute("birthday", birthday);
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("reservMst", resvMst);
		model.addAttribute("reservRosterList", reservRosterList);
		model.addAttribute("rnEtMst", rnEtMstResult);

		System.out.println("[JEH]================cust_cd:" + custCd);
		System.out.println("[JEH]================knm:" + knm);
		System.out.println("[JEH]================email:" + email);
		System.out.println("[JEH]================age:" + age);
		System.out.println("[JEH]================id:" + id);
		System.out.println("[JEH]================sex:" + sex);
		System.out.println("[JEH]================birthday:" + birthday);
		System.out.println("[JEH]================custGradeCd:" + custGradeCd);
		System.out.println("[JEH]================reservMst:" + resvMst);
		System.out.println("[JEH]================reservRosterList:" + reservRosterList);
		System.out.println("[JEH]================rnEtMst:" + rnEtMstResult);
		
		System.out.println("[JEH]================L.pay용 파라메터 setting======");
		//L.pay용 파라메터 setting [맴버스번호(cno), 핸드폰번호, 고객명(knm)]
		model.addAttribute("telno", mblNo.replace("-", ""));
		
		System.out.println("[JEH]================cno check======");
		if("1101933961".equals(cno) ){
			model.addAttribute("cno", "1100020340");
		}else{
			model.addAttribute("cno", cno);
		}
		
		System.out.println("[JEH]================Timestamp======");
		Timestamp tsmp	=	new Timestamp(System.currentTimeMillis());
		
		String M_TX_NUM	=	String.valueOf(tsmp);

		M_TX_NUM =  M_TX_NUM.replaceAll("-", "");
		M_TX_NUM =  M_TX_NUM.replaceAll(" ", "");
		M_TX_NUM =  M_TX_NUM.replaceAll(":", "");
		M_TX_NUM =  M_TX_NUM.replaceAll("\\.", "");
		
		System.out.println("[JEH]================M_TX_NUM======");
		System.out.println("M_TX_NUM:" + M_TX_NUM);
		model.addAttribute("M_TX_NUM", "P" + M_TX_NUM);

		return _rootPath+"/pay";
	}
	
	@RequestMapping(value = "/account/payTest.do", method = RequestMethod.GET )
	public String payTest(@RequestParam("resCd") String resCd, HttpServletRequest request, Model model) throws Exception {
	    
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
		
		String cno	=	"";
		String mblNo	=	"";
		
		if(sessionParam != null){
			if(sessionParam.get("mblNo") != null)
				mblNo = sessionParam.get("mblNo").toString();
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
		}
		
		/** 예약 정보 마스터 조회 **/
		ReserveVO reserveParam = new ReserveVO();
		reserveParam.setRes_cd(resCd);
		
		ReserveVO resvMst = (ReserveVO) reserveService.srchReserve(reserveParam);
		
		/** 예약자 수 **/
		ReserveRosterVO rosterParam = new ReserveRosterVO();
		rosterParam.setRes_cd(resCd);
		
		List reservRosterList = (List) reserveService.srchReserveRosters(rosterParam);
		
		/** 행사 상품 태그 조회 **/
		RNGDTagsVO rnGDTagsParam = new RNGDTagsVO();
		rnGDTagsParam.setEvent_cd(resvMst.getEvent_cd());
		
		RNGDTagsVO rnGDTagsResult = new RNGDTagsVO();
		rnGDTagsResult = (RNGDTagsVO) rnGoodsService.srchGDTags(rnGDTagsParam);
		
		String goodsCd = "";
		
		if(resvMst.getEvent_cd() != null && !resvMst.getEvent_cd().equals("")) { 
			goodsCd = resvMst.getEvent_cd().substring(0, 7);
		}
		
		/** 행사 상품 이벤트 조회 **/
		RNETMstVO rnEtMstParam = new RNETMstVO();
		rnEtMstParam.setEvent_cd(resvMst.getEvent_cd());
		rnEtMstParam.setComp_cd(rnGDTagsResult.getComp_cd());
		rnEtMstParam.setGoods_cd(goodsCd);

		RNETMstVO rnEtMstResult = new RNETMstVO();
		rnEtMstResult = (RNETMstVO) rnGoodsService.srchETMst2(rnEtMstParam);	
		
		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("email", email);
		model.addAttribute("age", age);
		model.addAttribute("id", id);		
		model.addAttribute("sex", sex);
		model.addAttribute("birthday", birthday);
		model.addAttribute("custGradeCd", custGradeCd);
		model.addAttribute("reservMst", resvMst);
		model.addAttribute("reservRosterList", reservRosterList);
		model.addAttribute("rnEtMst", rnEtMstResult);
		
		//L.pay용 파라메터 setting [맴버스번호(cno), 핸드폰번호, 고객명(knm)]
		model.addAttribute("telno", mblNo.replace("-", ""));
		
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

		return _rootPath+"/payTest";
	}
	
	// <!--  탑승객 리스트 조회    -->
	@RequestMapping(value = "/account/getPayPriceAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String getPayPriceAjax(@RequestParam("price") String price, @RequestParam("type") String type, HttpServletRequest request, ModelMap model)throws Exception{
		if(price == null || price.equals("")) price = "0";
		
		PaymentVO paymentVo = lpointService.requestPayment(price, type);
		model.addAttribute("paymentVo", paymentVo);
		
		return "jsonView";		
	}

	@RequestMapping(value = "/account/pay_end_air.do", method = RequestMethod.GET )
	public String pay_end_air(@RequestParam("seqNo") String seqNo, HttpServletRequest request, Model model) throws Exception {
	    
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
		
		return _rootPath+"/pay_end_air";
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
	
	@RequestMapping(value = "/account/pay_fail_end.do", method = RequestMethod.GET )
	public String pay_fail_end(HttpServletRequest request, Model model) throws Exception {
	    
		return _rootPath+"/pay_fail_end";
	}
	
	/**
	 * 롯데포인트 사용가능금액 가져오기 (LPOINT 조회)
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
		
		model.addAttribute("code", LPontUseVo.getCode());						//리턴코드
		model.addAttribute("cardNo", LPontUseVo.getCardNum());					//카드번호
		model.addAttribute("usePoint", LPontUseVo.getUsePoint_str());			//가용포인트
		model.addAttribute("remainPointType", LPontUseVo.getRemainPointType());	//잔여포인트부호
		model.addAttribute("remainPoint", LPontUseVo.getRemainPoint_str());		//잔여포인트
		model.addAttribute("message1", LPontUseVo.getMessage1());				//메세지1
		model.addAttribute("message2", LPontUseVo.getMessage2());				//메세지2

		System.out.println("======================LPointSrcAjax end================================================");
		return "jsonview";
	}
	
	
	/**
	 * 롯데포인트 인증 및 사용가능금액 가져오기 (LPOINT 인증 및 조회)
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
		
		model.addAttribute("code", LPontUseVo.getCode());						//리턴코드
		model.addAttribute("cardNo", LPontUseVo.getCardNum());					//카드번호
		model.addAttribute("custNo", LPontUseVo.getCustNo());					//고객번호
		model.addAttribute("apprCd", LPontUseVo.getApprCd());					//응답코드
		model.addAttribute("remainPoint", LPontUseVo.getRemainPoint_str());		//잔여포인트
		model.addAttribute("usePoint", LPontUseVo.getUsePoint_str());			//가용포인트
		model.addAttribute("failCnt", LPontUseVo.getFailCnt());					//비밀번호오류횟수

		System.out.println("======================LPointAuthAjax end================================================");
		return "jsonview";
	}
	
	
	/**
	 * 롯데포인트 사용하기 (LPOINT 사용)
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/account/LPointUseAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String LPointUseAjax(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String resCd		=	""; 		//	예약번호
		String cardNo		=	""; 		//	LPoint카드번호
		String wpw			=	""; 		//	LPoint패스워드
		String startDay		=	""; 		//	여행시작일자
		String lottePoint	=	""; 		//	사용포인트
		String pointFg		=	"";			//	?
		String custcd		=	"";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custcd = sessionParam.get("cust_cd").toString();
		}
		
		
		LPointVO LPontUseVo	=	lpointService.getLPointUse(resCd, cardNo, wpw, startDay, lottePoint, pointFg, custcd);
		
		model.addAttribute("code", LPontUseVo.getCode());									//리턴코드
		model.addAttribute("getApprNo", LPontUseVo.getApprNo());							//제휴사승인번호
		model.addAttribute("getUSE_ORG_APPRNO", LPontUseVo.getUSE_ORG_APPRNO());			//원거래승인번호
		model.addAttribute("getUSE_ORG_APPRNO_DAY", LPontUseVo.getUSE_ORG_APPRNO_DAY());	//원거래승인일자
		model.addAttribute("getUsePoint_str", LPontUseVo.getUsePoint_str());				//가용포인트
		model.addAttribute("getRemainPointType", LPontUseVo.getRemainPointType());			//잔여포인트부호
		model.addAttribute("getRemainPoint_str", LPontUseVo.getRemainPoint_str());			//잔여포인트
		model.addAttribute("getAffRemainPointType", LPontUseVo.getAffRemainPointType());	//제휴사잔여포인트부호
		model.addAttribute("getAffRemainPoint", LPontUseVo.getAffRemainPoint());			//제휴사 잔여포인트
		model.addAttribute("getPOINT_TID", LPontUseVo.getPOINT_TID());						//포인트TID
		model.addAttribute("getCardNum", LPontUseVo.getCardNum());							//카드번호

		return "jsonview";
	}	

	
	/**
	 * 롯데포인트 적립하기 (LPOINT 적립)
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
		String startDay		=	""; 		//	여행시작일자
		String custcd		=	"";
		
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custcd = sessionParam.get("cust_cd").toString();
		}
		
		
		//========================================================================
		//	테스트용 강세setting
		//========================================================================
		res_cd		=	"A170207-1"; 		//	예약번호
		cardNo		=	"8710400970377574"; //	LPoint카드번호
		startDay	=	"20170607"; 		//	여행시작일자
		lottePoint	=	"10"; 				//	사용포인트
		saleAmt		=	"100";				//	상품가격(판매금액)
		pointFg		=	"U";				//	?
		//========================================================================
		
		LPointVO LPontUseVo	=	lpointService.getLPointAccum(res_cd, cardNo, lottePoint, saleAmt, pointFg, startDay, custcd);
		
		model.addAttribute("code", LPontUseVo.getCode());									//리턴코드
		model.addAttribute("getApprNo", LPontUseVo.getApprNo());							//제휴사승인번호
		model.addAttribute("getUSE_ORG_APPRNO", LPontUseVo.getUSE_ORG_APPRNO());			//원거래승인번호
		model.addAttribute("getUSE_ORG_APPRNO_DAY", LPontUseVo.getUSE_ORG_APPRNO_DAY());	//원거래승인일자
		model.addAttribute("getUsePoint_str", LPontUseVo.getUsePoint_str());				//가용포인트
		model.addAttribute("getRemainPointType", LPontUseVo.getRemainPointType());			//잔여포인트부호
		model.addAttribute("getRemainPoint_str", LPontUseVo.getRemainPoint_str());			//잔여포인트
		model.addAttribute("getAffRemainPointType", LPontUseVo.getAffRemainPointType());	//제휴사잔여포인트부호
		model.addAttribute("getAffRemainPoint", LPontUseVo.getAffRemainPoint());			//제휴사 잔여포인트
		model.addAttribute("getPOINT_TID", LPontUseVo.getPOINT_TID());						//포인트TID
		model.addAttribute("getCardNum", LPontUseVo.getCardNum());							//카드번호

		return "jsonview";
	}	
	
	/**
	 * 롯데jtb 상품권 조회하기
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
		String startDay		=	""; 		//	여행시작일자
		String custcd		=	"";
		
		//system.out.println("=============================1");
		if(sessionParam != null){
			if(sessionParam.get("cust_cd") != null)
				custcd = sessionParam.get("cust_cd").toString();
		}
		
		try{				
//			List<Map> resultMultiList = new ArrayList<Map>();
//			List<Map> conditionList = new ArrayList<Map>();
//			Map map = new HashMap<String, Object>();
//
//			System.out.println("=============================2");
//			ChannelManager instance = ChannelManager.getInstance();
//			System.out.println("=============================3");
//			Channel channel  = instance.getChannel();  		
//			System.out.println("=============================4");
//			channel.setAnnotated(false);
//			
//			System.out.println("=============================5");
//			
//			channel.registerValue("RES_CD","P170213-0003");
//			System.out.println("=============================6");
//			channel.correspondWith("T2-RV/RVPaymentSO/getPaymentListWeb"); 
//
//			System.out.println("=============================resultMultiList.size()=[start]");
//			paymentList = (ArrayList<Map>) channel.lookupValue("rVPaymentDTO");
//			System.out.println("=============================resultMultiList.size()=["+paymentList.size()+"]");
//			
//			if (1 > resultMultiList.size()) {
////				System.out.println("RNGDCommonBean.java   siteEventSrch   2");
//				List<Map> conditionList2 = new ArrayList<Map>();
//				Map map2 = new HashMap<String, Object>();	
//				
//				ChannelManager instance2 = ChannelManager.getInstance();
//				Channel channel2  = instance2.getChannel();  		
//				channel2.setAnnotated(false);
//				
//				map2.put("CTG_SEQ", null);
//				map2.put("GOODS_CD", goodsCd);
//				map2.put("EVENT_DESC", 1);
//				map2.put("START_DAY", startDay);
//				//COMP_CD 수정
//				map2.put("COMP_CD", "LT");
//				
//				//조회월 셋팅(ex.200812)
//				if(startDay != null && startDay.length() > 0){
//					map2.put("EVENT_DESC", startDay.substring(0, 6));
//				}
//				
//				conditionList2.add(map2);
//				
//				channel2.registerValue("RNPwSiteEventInfoDTO",  conditionList2);
//				channel2.registerValue("dbio_total_count_", String.valueOf(1));  //디폴트=1
//				//channel.correspondWith("T2-PW/PWSiteGoodsMngSO/siteEventSrch");
//				channel2.correspondWith("T2-PW/PWSiteGoodsMngSO/siteEventSrch"); 
//				
//				resultMultiList = (List<Map>)channel2.lookupValue("RNPwSiteEventInfoDTO");			
//			}
//			System.out.println("RNGDCommonBean.java   siteEventSrch   2-1   resultMultiList.size()=["+resultMultiList.size()+"]");			
		} catch ( Exception e) {
			//e.printStackTrace();
			System.err.print("결제 오류!");
		}			
		
		
		return "jsonview";
	}	
	
//	==============================================================================================================================
//	이니시스 테스트	
//	==============================================================================================================================
	
    /**
     * 마이페이지 L.POINT 팝업
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
     * 결제 인증수신/승인API
     * 
     * @param request HttpServletRequest
     * @param model 모델 객체
     * @return
     */
    @RequestMapping(value = "/account/paymentReturn.do")
    public String paymentReturn(HttpServletRequest request, Model model) {
        System.out.println("########## paymentReturn ##########");
        
        String movePath	=	"/pay_end";
        
        try {

    		HttpSession session = request.getSession(true);
    		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
    		
    		String custcd		=	"";
    		String knm			=	"";
    		
    		if(sessionParam != null){
    			if(sessionParam.get("cust_cd") != null)
    				custcd = sessionParam.get("cust_cd").toString();
    			if(sessionParam.get("knm") != null)		//	로그인자명
    				knm = sessionParam.get("knm").toString();
    		}

    		//#############################
            // 인증결과 파라미터 일괄 수신
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

            System.out.println("result paymentReturnVo: " + paymentReturnVo.toString());
            
            model.addAttribute("paymentReturnVo", paymentReturnVo);
            model.addAttribute("rsvSeqNo", paymentReturnVo.getResCd());
            
            if(paymentReturnVo.getResCd() == null || "".equals(paymentReturnVo.getResCd())){
            	movePath = "/pay_fail_end";
            	throw new Exception("결제 실패");
            }
            
            if(paymentReturnVo.getVacctVo() != null){
                model.addAttribute("No_vacct", paymentReturnVo.getVacctVo().getNo_vacct());
                model.addAttribute("Nm_input", paymentReturnVo.getVacctVo().getNm_input());
                model.addAttribute("Nm_inputbank", paymentReturnVo.getVacctVo().getNm_inputbank());
                System.out.println("Nm_inputbank: " + paymentReturnVo.getVacctVo().getNm_inputbank());
            }else{
                model.addAttribute("No_vacct", "");
                model.addAttribute("Nm_input", "");
                model.addAttribute("Nm_inputbank", "");
                System.out.println("Nm_inputbank: none" );
            }
            
        } catch(Exception e) {
            logger.error("ReserveController.paymentReturn error: {}", e);
            movePath	=	"/pay_fail_end";
        }
        
        //return "/payment/INIStdPayReturn";
        
        return _rootPath + movePath;               
    }

    /**
     * 이니시스 팝업의 취소버튼 클릭
     * 
     * @param request HttpServletRequest
     * @param model 모델 객체
     * @return
     */
    @RequestMapping(value = "/account/paymentCancel.do")
    public String paymentCancel(HttpServletRequest request, Model model) {
        return _rootPath + "/pay_cancel";
    }
   
    
	@RequestMapping(value = "/pop/lpointPop.do", method = RequestMethod.GET )
	public String pop_lpoint(HttpServletRequest request, Model model) throws Exception {
	    
		
		return "/pop/lpointPop";
	}	


    /**
     * 결제 인증수신/승인API
     * 
     * @param request HttpServletRequest
     * @param model 모델 객체
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
    		String mblNo		=	"";
    		String cno			=	"";
    		
    		if(sessionParam != null){
    			if(sessionParam.get("cno") != null)
    				cno = sessionParam.get("cno").toString();
    			if(sessionParam.get("cust_cd") != null)
    				custcd = sessionParam.get("cust_cd").toString();
    			if(sessionParam.get("knm") != null)		//	로그인자명
    				knm = sessionParam.get("knm").toString();
    			if(sessionParam.get("mblNo") != null)
    				mblNo = sessionParam.get("mblNo").toString();
    		}

    		//#############################
            // 인증결과 파라미터 일괄 수신
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
            paramMap.put("telno", mblNo);
            paramMap.put("buyerName", knm);
            
            //system.out.println("paramMap: " + paramMap.toString());
            
            PaymentVO paymentReturnVo = lpointService.lpayPayment(paramMap);

            //system.out.println("result paymentReturnVo: " + paymentReturnVo.toString());
            
            model.addAttribute("paymentReturnVo", paymentReturnVo);
            model.addAttribute("rsvSeqNo", paymentReturnVo.getResCd());
            
        } catch(Exception e) {
            logger.error("ReserveController.paymentReturn error: {}", e);
        }
        
        //return "/payment/INIStdPayReturn";
        
        
        return _rootPath + "/pay_end";               
    }
//	==============================================================================================================================
    
    
    
	/**
	 * 결제 입금내역 정보가져오기
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/account/depositHistoryAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String depositHistory(HttpServletRequest request, Model model) throws Exception {
		
		 RvPaymentVO vo = new RvPaymentVO();
		 vo.setRES_CD(request.getParameter("RES_CD"));
		 
		 List<RvPaymentVO> list = lpointService.selectDeposithistory(vo);
		
		 model.addAttribute("dopositHistory", list);						
		 return "jsonview";
	}
	
}
