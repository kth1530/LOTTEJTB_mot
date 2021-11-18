package com.lottejtb.comm.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lottejtb.comm.service.CommApiService;
import com.lottejtb.comm.service.CommEanAPIVO;
import com.lottejtb.comm.service.CommExchangeVO;
import com.lottejtb.util.AutoComplete;

@Controller
public class CommApiController {
    
    private final Logger logger = Logger.getLogger(CommEanAPIController.class);
    
    @Resource(name = "CommApiService")
    private CommApiService comApiServ;
    
    
    @RequestMapping(value = "/CommAPInfoAjax.do")
    @ResponseBody
    public String CommApInfo(@ModelAttribute("CommEanAPIVO") CommEanAPIVO vo,HttpServletRequest request, Model model) throws Exception{
       return comApiServ.eanApiHotelList(vo, request);
    }
    
    /** 환율 정보 **/
	@RequestMapping(value = "/exchangeInfo.do",method={RequestMethod.GET, RequestMethod.POST})
	public String exchangeInfo(@ModelAttribute("CommExchangeVO") CommExchangeVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		CommExchangeVO data = new CommExchangeVO();
		data = comApiServ.exchangeInfo(vo);
		
		model.addAttribute("data", data);
		
	    return "jsonView";
	}
	
	/** 환율 정보 **/
	@RequestMapping(value = "/totalExchangeInfo.do",method={RequestMethod.GET, RequestMethod.POST})
	public String totalExchangeInfo(@ModelAttribute("CommExchangeVO") CommExchangeVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		List list = comApiServ.totalExchangeInfo();
		
		model.addAttribute("list", list);
		
	    return "jsonView";
	}
	
	/** 자동 완성 **/
	@RequestMapping(value = "/autoComplete.do", method={RequestMethod.GET, RequestMethod.POST})
	public String autoComplete(HttpServletRequest request, ModelMap model) throws Exception{
		AutoComplete auto_complete = new AutoComplete();
		String keyword = request.getParameter("keyword");
		
		List pList = auto_complete.getItems(keyword);
		
		model.addAttribute("list", pList);
		
		return "jsonView";
	}
}