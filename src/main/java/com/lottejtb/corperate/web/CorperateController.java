package com.lottejtb.corperate.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lottejtb.corperate.service.CorperateService;

@Controller
public class CorperateController {
	@Resource(name = "CorperateService")
	private CorperateService corperateService;
	

	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/";
	
	/** 회사소개 **/
	@RequestMapping(value = "/corperate/corperate.do",method={RequestMethod.GET, RequestMethod.POST})
	public String corperate(HttpServletRequest request, Model model)throws Exception{
		String tabMenu = request.getParameter("tab");
		
		model.addAttribute("tab", tabMenu);
		
		return _rootPath+"corperate/corperate";
	}
	
	/** 범인상용 **/
	@RequestMapping(value = "/corperate/corperate_info.do",method={RequestMethod.GET, RequestMethod.POST})
	public String corperate_info(HttpServletRequest request, Model model)throws Exception{
		return _rootPath+"corperate/corperate_info";
	}
	
	/** 회사소개 lpoint **/
	@RequestMapping(value = "/corperate/corperate_lpoint.do",method={RequestMethod.GET, RequestMethod.POST})
	public String corperate_lpoint(HttpServletRequest request, Model model)throws Exception{
		return _rootPath+"corperate/corperate_lpoint";
	}
}
