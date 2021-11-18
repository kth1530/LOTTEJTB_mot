package com.lottejtb.mytour.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.lottejtb.comm.service.CommApiService;
import com.lottejtb.comm.util.CommInfo;
import com.lottejtb.comm.util.StringUtil;
import com.lottejtb.mytour.service.ComCodeVO;
import com.lottejtb.mytour.service.FaFitCounselAssortVO;
import com.lottejtb.mytour.service.FaFitCounselQuesVO;
import com.lottejtb.mytour.service.MytourService;
import com.lottejtb.mytour.service.MytourVO;
import com.lottejtb.mytour.topass.net.TopassReserveUtil;
import com.lottejtb.util.LottePointTcpClient;

@Controller
public class MytourController {
	
	@Resource(name = "MytourService")
	private MytourService mytourService;
	
	@Resource(name = "CommApiService")
    private CommApiService comApiServ;
	
	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/";
	private final int PAGESIZE = 10;
	private final int FREEPAGESIZE = 5;
	
	/** 마이투어 **/
	@RequestMapping(value = "/mytour/mytour.do",method={RequestMethod.GET, RequestMethod.POST})
	public String mytour(HttpServletRequest request, Model model)throws Exception{
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		String custCd = null;
		String knm = null;
		String custGradeNm = null;
		String mbrCustno = null;
		String tradeNo = null;
		String cardNo = null;
		String returnCode = null;
		String mblNo = null;
		String cno = null;
		
		String cardNum = null;
		String usePoint_str = null;
		String remainPointType = null;
		long usePoint = 0;
		String remainPoint_str = null;
		long remainPoint = 0;
		String message1 = null;
		String message2 = null;
		String jimNo = null;
		
		if(sessionParam != null){
			custCd = sessionParam.get("cust_cd").toString();
			
			if(sessionParam.containsKey("knm")){
				if(sessionParam.get("knm") != null){
					knm = sessionParam.get("knm").toString();
				}
			}
			
			if(sessionParam.containsKey("custGradeNm")){
				if(sessionParam.get("custGradeNm") != null){
					custGradeNm = sessionParam.get("custGradeNm").toString();
				}
			}
			
			if(sessionParam.containsKey("mbrCustno")){
				if(sessionParam.get("mbrCustno") != null){
					mbrCustno = sessionParam.get("mbrCustno").toString();
				}
			}
			
			if(sessionParam.containsKey("mblNo")){
				if(sessionParam.get("mblNo") != null){
					mblNo = sessionParam.get("mblNo").toString();
				}
			}
			
			if(sessionParam.containsKey("cno")){
				if(sessionParam.get("cno") != null){
					cno = sessionParam.get("cno").toString();
				}
			}
		}
		
		/****************************************************** 롯데 포인트 조회 ******************************************************/
		if (cno != null && !"".equals(cno)) {
			//String tempNo = "";
			StringBuilder tempNoSb = new StringBuilder();
			for(int i=0; i < (10 - (cno.trim()).length());i++){
				//tempNo += "0";
				tempNoSb.append("0");
			}
			cno = tempNoSb + (cno.trim());
			
			result = mytourService.selectLottePointSeq();
	
			if(result.get("TRADE_NO").toString().equals("00000")){
				mytourService.insertLottePointSeq();
			}
			
			mytourService.updateLottePointSeq();
			
			tradeNo = mytourService.selectLottePointSeq().get("TRADE_NO").toString();
			
			if(!tradeNo.equals(null)){
				byte[] reqFixedText2001 = null;
				reqFixedText2001 = LottePointTcpClient.sendFixedText2000(tradeNo, cno, cardNo);
				
				byte[] Header2001 = new byte[73];
				byte[] Body2001 = new byte[955]; //신전문
				
				System.arraycopy(reqFixedText2001, 2, Header2001, 0, 73);
				System.arraycopy(reqFixedText2001, 75, Body2001, 0, 955); //신전문
				
				
				String strHeader2001 = new String(Header2001,"EUC-KR");
				String strBody2001 = new String(Body2001,"EUC-KR");
				
				//if(!strHeader2001.equals(null) && !strHeader2001.equals("")){
				if(!StringUtil.isEmpty(strHeader2001)){
					returnCode = strHeader2001.substring(47, 49);
				}
				
				//if(!strBody2001.equals(null) && !strBody2001.equals("")){
				if(!StringUtil.isEmpty(strBody2001)){
					cardNum = strBody2001.substring(1, 38); //카드번호
					usePoint_str = strBody2001.substring(76, 85); //가용포인트
					remainPointType = strBody2001.substring(85, 86); //잔여포인트부호
					remainPoint_str = strBody2001.substring(86, 95); //잔여포인트
					message1 = strBody2001.substring(107, 171); //메세지1
					message2 = strBody2001.substring(171, 427); //메세지2
				}
				
				if("22".equals(returnCode)){
            		System.out.println("롯데포인트 시스템장애");
            	}else if("44".equals(returnCode)){
            		System.out.println("롯데포인트 승인거절");
            	}else if("69".equals(returnCode)){
            		System.out.println("롯데포인트 자료불일치");
            	}else if("77".equals(returnCode)){
            		System.out.println("롯데포인트 전문오류");
            	}else if("88".equals(returnCode)){
            		System.out.println("롯데포인트 DB 미등록");
            	}else if("80".equals(returnCode)){
            		System.out.println("롯데포인트 운영사 DBMS 장애");
            	}else if("92".equals(returnCode)){
            		System.out.println("롯데포인트 Control 오류");
            	}else if("99".equals(returnCode)){
            		System.out.println("롯데포인트 시간초과 재시도 요망");
            	}else if(!"00".equals(returnCode)){
            		System.out.println("롯데포인트 시스템장애");
            	}else{
					usePoint = Long.parseLong(usePoint_str);
					remainPoint = Long.parseLong(remainPoint_str);
				}
			}
		}
		/****************************************************** 롯데 포인트 조회 ******************************************************/		
		model.addAttribute("pageSize", PAGESIZE);
		model.addAttribute("freePageSize", FREEPAGESIZE);
		model.addAttribute("custCd", custCd);
		model.addAttribute("userName", knm);
		model.addAttribute("gradeNm", custGradeNm);
		model.addAttribute("usePoint", usePoint);
		model.addAttribute("remainPointType", remainPointType);
		model.addAttribute("remainPoint", remainPoint);
		model.addAttribute("mblNo", mblNo);
		model.addAttribute("cno", cno);
		model.addAttribute("mbrCustno", mbrCustno);
		
		return _rootPath+"mytour/mytour";
	}
	
	/** 예약조회 **/
	@RequestMapping(value = "/mytour/myReservationList.do",method={RequestMethod.GET, RequestMethod.POST})
	public String myReservationList(@ModelAttribute("MytourVO") MytourVO vo, HttpServletRequest request, ModelMap model) throws Exception{
		List<MytourVO> listHistory;
		List<MytourVO> listCancel;
		
		listHistory = mytourService.myReservationList(vo);
		listCancel = mytourService.myCancelReservationList(vo);
		
		model.addAttribute("listHistory", listHistory);
		model.addAttribute("listCancel", listCancel);
		
		return "jsonView";
	}
	
	/** 예약조회(예약일자) **/
	@RequestMapping(value = "/mytour/myReservationDateList.do",method={RequestMethod.GET, RequestMethod.POST})
	public String myReservationDateList(@ModelAttribute("MytourVO") MytourVO vo, HttpServletRequest request, ModelMap model) throws Exception{
		List<MytourVO> listHistory;
		
		listHistory = mytourService.myReservationDateList(vo);
		
		model.addAttribute("listHistory", listHistory);
		
		return "jsonView";
	}
	
	/** 예약조회 **/
	@RequestMapping(value = "/mytour/freeReserve.do",method={RequestMethod.GET, RequestMethod.POST})
	public String freeReserve(@ModelAttribute("MytourVO") MytourVO vo, HttpServletRequest request, ModelMap model) throws Exception{
		HashMap<String, List> list = mytourService.freeReserve(vo);
		HashMap<String, List> cancelList = mytourService.freeCancelReserve(vo);
		
		model.addAttribute("list", list);
		model.addAttribute("cancelList", cancelList);
		
		return "jsonView";
	}
	
	@RequestMapping(value = "/mytour/freeReserveInfo.do",method={RequestMethod.GET, RequestMethod.POST})
	public String freeReserveInfo(HttpServletRequest request, Model model) throws Exception {
	    
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
		
		return _rootPath+"/free_info_detail";
	}
	
	/** 찜상품 총 갯수 **/
	@RequestMapping(value = "/mytour/choiceGoodsCount.do",method={RequestMethod.GET, RequestMethod.POST})
	public String choiceGoodsCount(@ModelAttribute("MytourVO") MytourVO vo, HttpServletRequest request, ModelMap model) throws Exception{
		int count = mytourService.choiceGoodsCount(vo);
		
		model.addAttribute("totalCount", count);
		
		return "jsonView";
	}
	
	/** 찜상품 **/
	@RequestMapping(value = "/mytour/choiceGoodsList.do",method={RequestMethod.GET, RequestMethod.POST})
	public String choiceGoodsList(@ModelAttribute("MytourVO") MytourVO vo, HttpServletRequest request, ModelMap model) throws Exception{
		List list = mytourService.choiceGoodsList(vo);
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}
	
	/** 마이 이벤트 총 갯수 **/
	@RequestMapping(value = "/mytour/myEventCount.do",method={RequestMethod.GET, RequestMethod.POST})
	public String myEventmyEventCount(@ModelAttribute("MytourVO") MytourVO vo, HttpServletRequest request, ModelMap model) throws Exception{
		int count = mytourService.myEventCount(vo);
		
		model.addAttribute("totalCount", count);
		
		return "jsonView";
	}
	
	/** 마이 이벤트 **/
	@RequestMapping(value = "/mytour/myEventList.do",method={RequestMethod.GET, RequestMethod.POST})
	public String myEventList(@ModelAttribute("MytourVO") MytourVO vo, HttpServletRequest request, ModelMap model) throws Exception{
		List list = mytourService.myEventList(vo);
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}
	
	/** 마이투어(비회원) **/
	@RequestMapping(value = "/mytour/nonMember.do",method={RequestMethod.GET, RequestMethod.POST})
	public String nonMember(HttpServletRequest request, Model model)throws Exception{
		model.addAttribute("pageSize", PAGESIZE);
		model.addAttribute("userNm", request.getParameter("userNm"));
		model.addAttribute("email", request.getParameter("email"));
		model.addAttribute("r_phoneno", request.getParameter("r_phoneno"));
		model.addAttribute("resCd", request.getParameter("resCd"));
		
		return _rootPath+"mytour/nonMember";
	}
	
	/** 비회원 예약확인 **/
	@RequestMapping(value = "/mytour/nonMemberResList.do",method={RequestMethod.GET, RequestMethod.POST})
	public String nonMemberResList(@ModelAttribute("MytourVO") MytourVO vo, HttpServletRequest request, ModelMap model) throws Exception{
		//List list = mytourService.nonMemberResList(vo);
		HashMap<String, List> list = mytourService.nonMemberResList(vo);
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}
	
	/** 선택된 찜 상품 삭제 **/
	@RequestMapping(value = "/mytour/delectSelChoiceGoods.do",method={RequestMethod.GET, RequestMethod.POST})
	public String delectSelChoiceGoods(@ModelAttribute("MytourVO") MytourVO vo, HttpServletRequest request, ModelMap model) throws Exception{
		mytourService.delectSelChoiceGoods(vo);
		
		return "jsonView";
	}
	
	/** 전체 찜 상품 삭제 **/
	@RequestMapping(value = "/mytour/delectAllChoiceGoods.do",method={RequestMethod.GET, RequestMethod.POST})
	public String delectAllChoiceGoods(@ModelAttribute("MytourVO") MytourVO vo, HttpServletRequest request, ModelMap model) throws Exception{
		mytourService.delectAllChoiceGoods(vo);
		
		return "jsonView";
	}
	
	@RequestMapping(value = "/mytour/pop_qna_list.do", method = RequestMethod.GET )
	public String pop_qna_list(HttpServletRequest request, Model model) throws Exception {
	    
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
		
		return _rootPath+"mytour/pop_qna_list";
	}
	
	// 자유여행 문의하기 작성
	@RequestMapping(value = "/mytour/pop_qna_write.do", method = RequestMethod.GET )
	public String pop_qna_write(HttpServletRequest request, Model model) throws Exception {

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
		
		return _rootPath+"mytour/pop_qna_write";
	}
	
	// 자유여행 문의하기 리스트 
	@RequestMapping(value = "/mytour/counselListAjax.do", method = {RequestMethod.GET, RequestMethod.POST} )
	public String counselListAjax(HttpServletRequest request, Model model) throws Exception {
		String startRow = (String) request.getParameter("startRow");
		String endRow = (String) request.getParameter("endRow");
		String userID = (String) request.getParameter("userID");
		
		if(startRow == null || startRow.equals("")) startRow = "1";
		if(endRow == null || endRow.equals("")) endRow = String.valueOf(PAGESIZE);
		
		FaFitCounselQuesVO param = new FaFitCounselQuesVO();
		param.setStartRow(Integer.parseInt(startRow));
		param.setEndRow(Integer.parseInt(endRow));
		if(userID != null && !userID.equals("")) param.setUSER_ID(userID);
		
		List list = (List) mytourService.srchCounselQuesList(param);
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}	
	
	// 자유여행 문의하기 리스트 카운트 수 조회
	@RequestMapping(value = "/mytour/counselListCountAjax.do", method = {RequestMethod.GET, RequestMethod.POST} )
	public String counselListCountAjax(HttpServletRequest request, Model model) throws Exception {
		String userID = (String) request.getParameter("userID");
		
		FaFitCounselQuesVO param = new FaFitCounselQuesVO();
		if(userID != null && !userID.equals("")) param.setUSER_ID(userID);
		int totalSize = (int) mytourService.srchCounselQuesListCount(param);
		
		model.addAttribute("totalSize", totalSize);
		
		return "jsonView";
	}	
	
	// 자유여행 문의하기 저장 
	@RequestMapping(value = "/mytour/srchAssortListAjax.do", method = {RequestMethod.GET, RequestMethod.POST} )
	public String srchAssortListAjax(HttpServletRequest request, Model model) throws Exception {
		String PARENT_ASSORT_CD = (String) request.getParameter("PARENT_ASSORT_CD");
		System.out.println("PARENT_ASSORT_CD : " + PARENT_ASSORT_CD);
		
		FaFitCounselAssortVO param = new FaFitCounselAssortVO();
		param.setPARENT_ASSORT_CD(PARENT_ASSORT_CD);
		/** 시스템 코드 조회 **/
		List assortList =  mytourService.srchCounselAssortList(param);		
		model.addAttribute("assortList", assortList);
		
		return "jsonView";
	}
	
	
	// 자유여행 문의하기 저장 
	@RequestMapping(value = "/mytour/saveCounselAjax.do", method = {RequestMethod.GET, RequestMethod.POST} )
	public String saveCounselAjax(@ModelAttribute("FaFitCounselQuesVO") FaFitCounselQuesVO vo, HttpServletRequest request, Model model) throws Exception {
		FaFitCounselAssortVO param = new FaFitCounselAssortVO();
		param.setASSORT_CD(vo.getASSORT_CD());
		
		FaFitCounselAssortVO result = (FaFitCounselAssortVO) mytourService.srchCounselAssort(param);
		vo.setASSORT_NM(result.getASSORT_NM());
		
		mytourService.saveCounselQues(vo);
		
		return "jsonView";
	}
	
	// 자유여행 항공 웹 예약 내역 조회 
	@RequestMapping(value = "/mytour/getTopassRsvListAjax.do", method = {RequestMethod.GET, RequestMethod.POST} )
	public String getTopassRsvListAjax(HttpServletRequest request, Model model) throws Exception {

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
		
		ArrayList<Map> reserveAirList = new ArrayList<Map>();
		ArrayList<Map> reserveAirCancelList = new ArrayList<Map>();
		
		TopassReserveUtil rsvUtil = new TopassReserveUtil();
		rsvUtil.setAirReservInfo(request);
		
		reserveAirList = rsvUtil.getReserveAirList();
		reserveAirCancelList = rsvUtil.getReserveAirCancelList();
		int reserveAirListCount = rsvUtil.getReserveGoodsCount();
		int reserveAirCancelListCount = rsvUtil.getCancelAirGoodsCount();
		
		model.addAttribute("reserveAirList", reserveAirList);
		model.addAttribute("reserveAirCancelList", reserveAirCancelList);
		model.addAttribute("reserveAirListCount", reserveAirListCount);
		model.addAttribute("reserveAirCancelListCount", reserveAirCancelListCount);
		
		return "jsonView";
	}
	
	// 자유여행 항공 웹 예약 내역 조회 (비회원 예약 리스트) 
	@RequestMapping(value = "/mytour/getTopassRsvListNonMemberAjax.do", method = {RequestMethod.GET, RequestMethod.POST} )
	public String getTopassRsvListNonMemberAjax(@RequestParam("rname") String rname, @RequestParam("remail") String remail, @RequestParam("rsvno") String rsvno, HttpServletRequest request, Model model) throws Exception {
		
		ArrayList<Map> reserveAirList = new ArrayList<Map>();
		ArrayList<Map> reserveAirCancelList = new ArrayList<Map>();
		
		TopassReserveUtil rsvUtil = new TopassReserveUtil();
		rsvUtil.setAirReservInfoNonMember(rname, remail, rsvno);
		
		reserveAirList = rsvUtil.getReserveAirList();
		reserveAirCancelList = rsvUtil.getReserveAirCancelList();
		int reserveAirListCount = rsvUtil.getReserveGoodsCount();
		int reserveAirCancelListCount = rsvUtil.getCancelAirGoodsCount();
		
		model.addAttribute("reserveAirList", reserveAirList);
		model.addAttribute("reserveAirCancelList", reserveAirCancelList);
		model.addAttribute("reserveAirListCount", reserveAirListCount);
		model.addAttribute("reserveAirCancelListCount", reserveAirCancelListCount);
		
		return "jsonView";
	}
	
	// <!--  시스템 코드 조회   -->
	@RequestMapping(value = "/mytour/srchSysComCodeAjax.do" ,method={RequestMethod.GET, RequestMethod.POST})
	public String srchSysComCodeAjax(@ModelAttribute("ComCodeVO") ComCodeVO param, ModelMap model)throws Exception{
		
		/** 시스템 코드 조회 **/
		List comcodeList =  mytourService.srchComCode(param);		
		model.addAttribute("comcodeList", comcodeList);
		
		return "jsonView";
	}
	
	//[JEH] 호텔패스 마이페이지 아이프레임 - 20191227
	@RequestMapping(value = "/mytour/freeMyPagepop.do",method={RequestMethod.GET, RequestMethod.POST})
	public String ifrHP(HttpServletRequest request, Model model)throws Exception{
	
		return _rootPath+"mytour/ifrHP";
	}
}