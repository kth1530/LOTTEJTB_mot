package com.lottejtb.shop.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.ehcache.Ehcache;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.lottejtb.shop.service.ShopService;
import com.lottejtb.shop.service.ShopVO;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class ShopController {
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
    @Resource(name = "ehcache")
    Ehcache ehcache;
	
	@Resource(name = "ShopService")
	private ShopService shopService;

	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/";
	private final int PAGESIZE = 10;
	
	/** 매장안내 **/
	@RequestMapping(value = "/shop/shopList.do",method={RequestMethod.GET, RequestMethod.POST})
	public String setting(HttpServletRequest request, Model model)throws Exception{
		
		model.addAttribute("pageSize", PAGESIZE);
		
		return _rootPath+"shop/shop_list";
	}
	
	/** 매장 조회 **/
	@RequestMapping(value = "/shop/shopListSearch.do",method={RequestMethod.GET, RequestMethod.POST})
	public String shopListSearch(@ModelAttribute("ShopVO") ShopVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		List returnShopVO = shopService.selectShopList(vo);
		List returnRoadVO = shopService.selectShopListRoad(vo);
		List returnLotteVO = shopService.selectShopListLotte(vo);
		List returnCountVO = shopService.selectShopListCount(vo);
		
		model.addAttribute("list", returnShopVO);
		model.addAttribute("list_road", returnRoadVO);
		model.addAttribute("list_lotte", returnLotteVO);
		model.addAttribute("counts", returnCountVO);
		
	    return "jsonView";
	}
	
	/** 매장(전체) 조회 **/
	@RequestMapping(value = "/shop/shopAllListSearch.do",method={RequestMethod.GET, RequestMethod.POST})
	public String shopAllListSearch(@ModelAttribute("ShopVO") ShopVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		List returnShopVO = shopService.selectShopList(vo);
		
		model.addAttribute("list", returnShopVO);
		
	    return "jsonView";
	}
	
	/** 매장(로드샵) 조회 **/
	@RequestMapping(value = "/shop/shopRoadListSearch.do",method={RequestMethod.GET, RequestMethod.POST})
	public String shopRoadListSearch(@ModelAttribute("ShopVO") ShopVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		List returnShopVO = shopService.selectShopListRoad(vo);
		
		model.addAttribute("list", returnShopVO);
		
	    return "jsonView";
	}
	
	/** 매장(롯데매장) 조회 **/
	@RequestMapping(value = "/shop/shopLotteListSearch.do",method={RequestMethod.GET, RequestMethod.POST})
	public String shopLotteListSearch(@ModelAttribute("ShopVO") ShopVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		List returnShopVO = shopService.selectShopListLotte(vo);
		
		model.addAttribute("list", returnShopVO);
		
	    return "jsonView";
	}
}
