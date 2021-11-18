package com.lottejtb.setting.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lottejtb.main.service.MainVO;
import com.lottejtb.setting.service.SettingService;
import com.lottejtb.setting.service.SettingVO;

@PropertySource("classpath:/config/config.properties")
@Controller
public class SettingController {
	@Autowired
	Environment env;
	
	@Resource(name = "SettingService")
	private SettingService settingService;
	

	private final Logger logger = Logger.getLogger(this.getClass());
	private final String _rootPath = "/";
	
	/** 앱 설정 **/
	@RequestMapping(value = "/setting/setting.do",method={RequestMethod.GET, RequestMethod.POST})
	public String setting(HttpServletRequest request, Model model)throws Exception{
		return _rootPath+"setting/setting";
	}
	
	/** 디바이스 정보 저장 **/
	@RequestMapping(value = "/setting/insertMarketingReceiveYn.do",method={RequestMethod.GET, RequestMethod.POST})
	public String insertMarketingReceiveYn(@ModelAttribute("SettingVO") SettingVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		int insertYn = settingService.selectMarketingReceiveCnt(vo);
		
		if(insertYn == 0){
			settingService.insertMarketingReceiveYn(vo);
		}else{
			settingService.updateMarketingReceiveYn(vo);
		}
		
	    return "jsonView";
	}
	
	/** 디바이스 정보 저장 **/
	@RequestMapping(value = "/setting/selectMarketingReceiveYn.do",method={RequestMethod.GET, RequestMethod.POST})
	public String selectMarketingReceiveYn(@ModelAttribute("SettingVO") SettingVO vo, HttpServletRequest request,ModelMap model) throws Exception{
		SettingVO obj = settingService.selectMarketingReceiveYn(vo);
		
		model.addAttribute("list", obj);
		
	    return "jsonView";
	}
	
	/** 앱 버전/무결성 체크 **/
	@RequestMapping(value = "/setting/appCheck.do",method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public SettingVO appCheck(@ModelAttribute("SettingVO") SettingVO vo, HttpServletRequest request, ModelMap model)throws Exception{
		
		SettingVO returnSettingVO = settingService.selectAppCheck(vo);
		model.addAttribute("list", returnSettingVO);
		
	    return returnSettingVO;
	}
}
