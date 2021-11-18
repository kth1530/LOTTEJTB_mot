package com.lottejtb.schedule.web;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PushIController {
	
	@Scheduled( cron="0/3 * * * * ?" )
	public void  PushInterface() throws Exception{
		//System.out.println(">>>>>>>>>>>>>>>>>>>push send start~~~~~~~~~~~~~~");
		pushSend();
		
	}
	
	
	public String pushSend() {
		String url= "redirect:/push/sendPush.do";
		// System.out.println(">>>>>>>>>>>>>>>>>>>push send start~~~~~~~~~~~~~~");
		return url;
	}
	
}
