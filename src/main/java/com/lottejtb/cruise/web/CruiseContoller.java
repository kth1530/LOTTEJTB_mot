package com.lottejtb.cruise.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lottejtb.cruise.service.CruiseService;

@Controller
public class CruiseContoller {
	@Resource(name = "CruiseService")
	private CruiseService cruiseService;
	
	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/";
	
	@RequestMapping(value = "/cruise/cruise_view.do",method={RequestMethod.GET, RequestMethod.POST})
	public String cruiseView(HttpServletRequest request, Model model) throws Exception{
		return _rootPath+"cruise/cruise_view";
	}
}
