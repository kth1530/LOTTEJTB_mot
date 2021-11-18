package com.lottejtb.schedule.service;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service
public class PushIService {

	public ModelAndView doJob() {
		System.out.println("doJob");
		String url = "redirect:/push/sendPush.do";
		return new ModelAndView(url);
	}
}
