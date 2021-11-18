package com.lottejtb.event.web;

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

import org.apache.http.HttpRequest;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.lottejtb.comm.util.CommInfo;
import com.lottejtb.customer.service.FaqVO;
import com.lottejtb.event.service.EventService;
import com.lottejtb.event.service.EventVO;


/**
//#################################################################
//-----------------------------------------------------------------
//파일명 : EventController.java
//설 명   : Event Controller   
//작성자 : kkm 
//작성일자 : 2016.10.28
//
//변경이력 
//-----------------------------------------------------------------
//2016.10.28 
//
//-----------------------------------------------------------------
//#################################################################
**/

@Controller
public class EventController {
	
	@Autowired
	@Resource(name = "EventService")
	protected EventService service;
	
	//이벤트 목록
	@RequestMapping(value = "/event/event_list.do",method={RequestMethod.GET, RequestMethod.POST})
	public String event_list(HttpServletRequest request,  Model model) throws Exception {
		model.addAttribute("param_seq", request.getParameter("eventSeq"));
		model.addAttribute("param_nm", request.getParameter("eventNm"));
		model.addAttribute("param_s", request.getParameter("eventS"));
		model.addAttribute("param_e", request.getParameter("eventE"));
		model.addAttribute("param_tabNo", request.getParameter("tabNo"));
		model.addAttribute("param_backYn", request.getParameter("backYn"));
		
		return "/event/event_list";
	}
	//이벤트상세
	@RequestMapping(value = "/event/event_detail.do",method={RequestMethod.GET, RequestMethod.POST})
	public String event_detail(HttpServletRequest request,  Model model) throws Exception {
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = null;
		String knm = null;
		String id = null;
		String email = null;
		String mbrCustno = null;
		
		if(sessionParam != null){
			if(sessionParam.containsKey("cust_cd")){
				if(sessionParam.get("cust_cd") != null){
					custCd = sessionParam.get("cust_cd").toString();
				}
			}
			
			if(sessionParam.containsKey("knm")){
				if(sessionParam.get("knm") != null){
					knm = sessionParam.get("knm").toString();
				}
			}
			
			if(sessionParam.containsKey("id")){
				if(sessionParam.get("id") != null){
					id = sessionParam.get("id").toString();
				}
			}
			
			if(sessionParam.containsKey("email")){
				if(sessionParam.get("email") != null){
					email = sessionParam.get("email").toString();
				}
			}
			
			if(sessionParam.containsKey("mbrCustno")){
				if(sessionParam.get("mbrCustno") != null){
					mbrCustno = sessionParam.get("mbrCustno").toString();
				}
			}
			
			model.addAttribute("custCd" , custCd);
			model.addAttribute("knm" , knm);
			model.addAttribute("id" , id);
			model.addAttribute("email" , email);
			model.addAttribute("mbrCustno" , mbrCustno);
		}
		
		model.addAttribute("eventSeq", request.getParameter("eventSeq"));
		
		return "/event/event_detail";
	}
	
	@RequestMapping(value = "/event/event_listAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String event_listAjax(@ModelAttribute("PlanningVO") EventVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		
//		vo.setStartRow(1);
//		vo.setEndRow(100);
		
		Object list1 = service.srchEventingList(vo);
		Object list2 = service.srchEventEndList(vo);
		
		int totalCnt1 = service.srchEventingCnt(vo);
		int totalCnt2 = service.srchEventEndCnt(vo);
		
		model.addAttribute("list1", list1);
		model.addAttribute("list2", list2);
		model.addAttribute("totalCnt1", totalCnt1);
		model.addAttribute("totalCnt2", totalCnt2);
		
		return "jsonView";
	}
	
	//이벤트 더보기 목록조회
	@RequestMapping(value = "/event/event_moreListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String event_moreListAjax(@ModelAttribute("EventVO") EventVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		Object list = null;
		
		if(vo.getDispType().equals("0")){
			list = service.srchEventingList(vo);
		}else if(vo.getDispType().equals("1")){
			list = service.srchEventEndList(vo);
		}
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}
		
	
	//당첨자 목록조회
	@RequestMapping(value = "/event/event_winnerAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String event_winnerAjax(@ModelAttribute("EventVO") EventVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		
		vo.setStartRow(1);
		vo.setEndRow(10);
		vo.setDispYn("Y");
		
		Object list = service.winnerList(vo);
		int totalCnt = service.winnerCnt(vo);
		
		model.addAttribute("list", list);
		model.addAttribute("totalCnt", totalCnt);
		
		return "jsonView";
	}
	
	//당첨자 더보기목록조회
	@RequestMapping(value = "/event/event_WinnerListAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String event_WinnerListAjax(@ModelAttribute("EventVO") EventVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		
		vo.setDispYn("Y");
		
		Object list = service.winnerList(vo);
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}	
	
	//이벤트 상세 조회수
	@RequestMapping(value = "/event/event_detailAjax.do",method={RequestMethod.GET, RequestMethod.POST})
	public String event_detailAjax(@ModelAttribute("EventVO") EventVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		int eventCnt = 0;
		ArrayList<EventVO> list;
		
		HttpSession session = request.getSession(true);
		HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
		
		String custCd = null;
		if(sessionParam != null) {
			if(sessionParam.containsKey("cust_cd")){
				if(sessionParam.get("cust_cd") != null){
					custCd = sessionParam.get("cust_cd").toString();
				}
			}
		}	
		service.eventCnt(vo);
		eventCnt = service.getCnt(vo);
		list = service.templateSrch(vo);
		
		for(EventVO detail : list) {
			if(detail.getTempTypeCd() != null) {
				if(detail.getTempTypeCd().equals("30")){
					List commentList = service.commentList(vo);
					int commentCnt = service.commentCnt(vo);
					
					model.addAttribute("commentList", commentList);
					model.addAttribute("commentCnt", commentCnt);
				} else if(detail.getTempTypeCd().equals("50")){
					vo.setCustCd(custCd);
					System.out.println(">>>custCd<<<=" + custCd);
					List attendChkList = service.attendChkList(vo);
					model.addAttribute("attendChkList", attendChkList);
				} 
			}
		}
				
		model.addAttribute("cnt", eventCnt);
		model.addAttribute("list", list);
		
		return "jsonView";
	}
	
	//이벤트 댓글 등록
	@RequestMapping(value = "/event/insertComment.do",method={RequestMethod.GET, RequestMethod.POST})
	public String insertComment(@ModelAttribute("EventVO") EventVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		int applyCnt = 0;
		int regApplyCnt = 0;
		
		if(vo.getRoundApplyCnt().equals(null) || vo.getRoundApplyCnt().equals("null")){
			service.insertComment(vo);
			model.addAttribute("resultCode", "ok");
		}else{
			applyCnt = Integer.parseInt(vo.getRoundApplyCnt());
			regApplyCnt = service.applyCountCheck(vo);
			
			if(applyCnt <= regApplyCnt){
				model.addAttribute("resultCode", "duplication");
			}else{
				service.insertComment(vo);
				model.addAttribute("resultCode", "ok");
			}
		}
		
		return "jsonView";
	}
	
	//이벤트 댓글 조회
	@RequestMapping(value = "/event/commentList.do",method={RequestMethod.GET, RequestMethod.POST})
	public String commentList(@ModelAttribute("EventVO") EventVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		List commentList = service.commentList(vo);
		int commentCnt = service.commentCnt(vo);
		
		model.addAttribute("commentList", commentList);
		model.addAttribute("commentCnt", commentCnt);
		
		return "jsonView";
	}
	
	//이벤트 댓글 삭제
	@RequestMapping(value = "/event/deleteComment.do",method={RequestMethod.GET, RequestMethod.POST})
	public String deleteComment(@ModelAttribute("EventVO") EventVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		service.deleteComment(vo);
		
		return "jsonView";
	}
	
	//이벤트 응모하기
	@RequestMapping(value = "/event/insertEventEntry.do",method={RequestMethod.GET, RequestMethod.POST})
	public String insertEventEntry(@ModelAttribute("EventVO") EventVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		int regApplyCnt = service.applyCountCheck(vo);
		
		if(regApplyCnt > 0){
			model.addAttribute("resultCode", "duplication");
		}else{
			service.insertEventEntry(vo);
			model.addAttribute("resultCode", "ok");
		}
		
		return "jsonView";
	}
	
	//퀴즈 응모하기
	@RequestMapping(value = "/event/insertEventQuiz.do",method={RequestMethod.GET, RequestMethod.POST})
	public String insertEventQuiz(@ModelAttribute("EventVO") EventVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		int applyCnt = Integer.parseInt(vo.getRoundApplyCnt());
		int regApplyCnt = service.applyCountCheck(vo);
		
		if(applyCnt <= regApplyCnt){
			model.addAttribute("resultCode", "duplication");
		}else{
			service.insertEventQuiz(vo);
			model.addAttribute("resultCode", "ok");
		}
		
		return "jsonView";
	}
	
	//투표 선택 내용
//	@RequestMapping(value = "/event/voteContentList.do",method={RequestMethod.GET, RequestMethod.POST})
//	public String voteContentList(@ModelAttribute("EventVO") EventVO vo, HttpServletRequest request,ModelMap model) throws Exception {
//		
//		//List votecontentlist = service.voteContentList(vo);
//		
//		//model.addAttribute("votecontentlist", "");
//		
//		return "jsonView";
//	}
	
	//출석체크
	@RequestMapping(value = "/event/insertEventAttend.do",method={RequestMethod.GET, RequestMethod.POST})
	public String insertEventAttend(@ModelAttribute("EventVO") EventVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		
		//System.out.println("applyCnt=" + applyCnt + "regApplyCnt=" + regApplyCnt);
		String event_chgubun = request.getParameter("event_chgubun");
		System.out.println("event_chgubun=" + event_chgubun);
		
		if(event_chgubun != null) {
			service.insertEventAttend(vo);
			model.addAttribute("resultCode", "ok");
			event_chgubun = null;
		} else {
		
			int regApplyCnt = service.attendApplyCountCheck(vo);
			
			if(regApplyCnt > 0) {
				model.addAttribute("resultCode", "duplication");
			}else{
				service.insertEventAttend(vo);
				model.addAttribute("resultCode", "ok");
			}
		}
		return "jsonView";
	}
	
	//투표응모하기
	@RequestMapping(value = "/event/insertEventVote.do",method={RequestMethod.GET, RequestMethod.POST})
	public String insertEventVote(@RequestParam("eventCnts") String input,@ModelAttribute("EventVO") EventVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		
		System.out.println("inputparameter=" + input);
		int regApplyCnt = service.applyCountCheck(vo);
		
	//	System.out.println("applyCnt=" + applyCnt + "regApplyCnt=" + regApplyCnt);
		
		if(regApplyCnt > 0) {
			model.addAttribute("resultCode", "duplication");
		} else {
			service.insertEventVote(vo);
			model.addAttribute("resultCode", "ok");
		}
		return "jsonView";
	}
	
}