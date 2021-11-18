package com.lottejtb.cooperation.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lottejtb.cooperation.service.CooperationService;
import com.lottejtb.corperate.service.CorperateService;

/*
 * 제휴사 header,footer제공 controller
 */

@Controller
public class CooperationController {
	
	@Resource(name = "CooperationService")
	private CooperationService cooperationService;
	
	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/";
	

	/** header **/
	@RequestMapping(value = "/cooperation/re_dht_header.do",method={RequestMethod.GET, RequestMethod.POST})
	public String header(HttpServletRequest request, Model model)throws Exception{
		return _rootPath+"cooperation/header";
	}
	
	/** footer **/
	@RequestMapping(value = "/cooperation/re_dht_footer.do",method={RequestMethod.GET, RequestMethod.POST})
	public String footer(HttpServletRequest request, Model model)throws Exception{
		return _rootPath+"cooperation/footer";
	}
}
