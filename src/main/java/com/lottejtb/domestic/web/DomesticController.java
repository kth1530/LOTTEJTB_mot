package com.lottejtb.domestic.web;

import java.net.URLEncoder;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lottejtb.corperate.service.CorperateService;
import com.lottejtb.domestic.service.DomesticService;

/*
 * 제유사 연동controller
 * 
 */
@Controller
public class DomesticController {
	
	@Resource(name = "DomesticService")
	private DomesticService domesticService;
	

	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/";
	
	/**제휴사 카테고리 **/
	@RequestMapping(value = "/domestic/dmt_category_domestic.do",method={RequestMethod.GET, RequestMethod.POST})
	public String dmt_category(HttpServletRequest request, Model model)throws Exception{
		return _rootPath+"domestic/dmt_category";
	}
	
	/**제휴사 상세 **/            
	@RequestMapping(value = "/domestic/dmt_detail_domestic.do",method={RequestMethod.GET, RequestMethod.POST})
	public String dmt_detail(HttpServletRequest request, Model model)throws Exception{
		String url = (String)request.getParameter("url");
		String ctgname = (String)request.getParameter("ctgname");
				
		if(url != null) {
			url = URLEncoder.encode(url, "UTF-8");
		}
		model.addAttribute("url", url);
		model.addAttribute("ctgname", ctgname);
		return _rootPath+"domestic/dmt_detail";
	}
	
}
