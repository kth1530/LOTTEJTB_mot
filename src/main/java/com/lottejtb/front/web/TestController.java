package com.lottejtb.front.web;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/fit/test")
public class TestController {
	
	private final Logger logger = Logger.getLogger(TestController.class);
	private final String _rootPath = "/fit/test/";
	
	@RequestMapping(value = "/test.do")
	public String testPage() {
		
		return _rootPath + "test";
		
	}
	
	@RequestMapping(value = "/test2.do")
	public String test2Page() {
		
		return _rootPath + "test2";
		
	}
}