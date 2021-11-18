package com.lottejtb.push.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.lottejtb.push.service.PushService;
import com.lottejtb.sso.service.LoginService;
import com.lottejtb.util.RequestUtil;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class PushController {
	
	@Autowired
	private PushService pushService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	/*@RequestMapping(value = "/push/sendPush.do",method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView sendPush(HttpServletRequest request,HttpServletResponse response)  throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HashMap<String, Object> commandMap = RequestUtil.getParameterMap(request);
		
		pushService.sendPushMessage();
			
		return modelAndView;
		
	}*/
	
	// 1분마다 스케줄러 실행되도록 설정*/
	//@Scheduled( cron="0 0/1 * * * ?" )
	public void  PushInterface() throws Exception {
		System.out.println(">>>>>push send start<<<<<");
		//잠깐 막아놓자.
		pushService.sendPushMessage();
		
	}
	
}
