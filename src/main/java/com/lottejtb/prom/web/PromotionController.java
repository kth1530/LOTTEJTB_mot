package com.lottejtb.prom.web;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.ehcache.Ehcache;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.lottejtb.front.service.ReqMstReserveVO;
import com.lottejtb.prom.service.PromotionParamVO;
import com.lottejtb.prom.service.PromotionService;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class PromotionController {
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
    @Resource(name = "ehcache")
    Ehcache ehcache;
    
    private Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/";
	
	@Resource(name = "PromotionService")
	private PromotionService service;
	
	@RequestMapping(value = "/promo/selectPromoAmt.do",method={RequestMethod.GET, RequestMethod.POST})
	public String selectPromoAmt(@RequestBody PromotionParamVO vo, HttpServletRequest request, Model model) throws NumberFormatException{
		HashMap<String, List> list = new HashMap<String, List>();
		try {
			list = service.selectPromoAmt(vo);
		} catch (Exception e) {
			System.out.println("error");
		}
		
		model.addAttribute("list", list);
		
		return "jsonView";
	}
	
}
