package com.lottejtb.comm.web;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lottejtb.comm.util.CommInfo;
import com.lottejtb.main.service.MainVO;

@Controller
public class CommPopController {
	
	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/";
	
	@RequestMapping(value = "/travelDownPop.do",method = RequestMethod.GET )
	public String travelDownPop(@ModelAttribute MainVO vo,HttpServletRequest request, Model model) throws Exception {		
		return _rootPath+"pop/travelDownConfirm";
	}
	
	@RequestMapping(value = "/mytourDatePop.do",method = RequestMethod.GET )
	public String mytourDatePop(@ModelAttribute MainVO vo,HttpServletRequest request, Model model) throws Exception {
		return _rootPath+"pop/mytourDateSearch";
	}
	
	@RequestMapping(value = "/mytourChoicePop.do",method = RequestMethod.GET )
	public String mytourDatePop(HttpServletRequest request, Model model) throws Exception {
		return _rootPath+"pop/mytourChoicePop";
	}
	
	@RequestMapping(value = "/mytourAllChoicePop.do",method = RequestMethod.GET )
	public String mytourAllChoicePop(HttpServletRequest request, Model model) throws Exception {
		return _rootPath+"pop/mytourAllChoicePop";
	}
	
	@RequestMapping(value = "/customerPop.do",method = RequestMethod.GET )
	public String customerPop(HttpServletRequest request, Model model) throws Exception {
		return _rootPath+"pop/customerPop";
	}
	
	@RequestMapping(value = "/corperatePop.do",method = RequestMethod.GET )
	public String corperatePop(HttpServletRequest request, Model model) throws Exception {
		return _rootPath+"pop/corperatePop";
	}
	
	@RequestMapping(value = "/goodsSaveCartPop.do",method = RequestMethod.GET )
	public String goodsSaveCartPop(HttpServletRequest request, Model model) throws Exception {
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

		model.addAttribute("cust_cd", custCd);
		model.addAttribute("knm", knm);
		model.addAttribute("email", email);		
		
		return _rootPath+"pop/goodsSaveCartPop";
	}
	
	@RequestMapping(value = "/commentAlertPop.do",method = RequestMethod.GET )
	public String commentAlertPop(HttpServletRequest request, Model model) throws Exception {
		return _rootPath+"pop/commentAlertPop";
	}
	
	@RequestMapping(value = "/commentConfirmPop.do",method = RequestMethod.GET )
	public String commentConfirmPop(HttpServletRequest request, Model model) throws Exception {
		model.addAttribute("applySeq", request.getParameter("applySeq"));
		return _rootPath+"pop/commentConfirmPop";
	}
	/*응모1타입*/
	@RequestMapping(value = "/eventEntryPop.do",method = RequestMethod.GET )
	public String eventEntryPop(HttpServletRequest request, Model model) throws Exception {
		return _rootPath+"pop/eventEntryPop";
	}
	/*응모2타입*/
	@RequestMapping(value = "/eventEntry2Pop.do",method = RequestMethod.GET )
	public String eventEntry2Pop(HttpServletRequest request, Model model) throws Exception {
		return _rootPath+"pop/eventEntry2Pop";
	}
	
	@RequestMapping(value = "/eventQuizPop.do",method = RequestMethod.GET )
	public String eventQuizPop(HttpServletRequest request, Model model) throws Exception {
		return _rootPath+"pop/eventQuizPop";
	}
	
	@RequestMapping(value = "/eventAttendPop.do",method = RequestMethod.GET )
	public String eventAttendPop( HttpServletRequest request, Model model) throws Exception {
		
		model.addAttribute("atChkCnt", (String)request.getParameter("atChkCnt"));
		return _rootPath+"pop/eventAttendPop";
	}
	
	@RequestMapping(value = "/eventVotePop.do",method = RequestMethod.GET )
	public String eventVotePop(HttpServletRequest request, Model model) throws Exception {
		return _rootPath+"pop/eventVotePop";
	}
}
