package com.lottejtb.framework.common;


import java.util.Locale;

import org.springframework.core.Ordered;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.AbstractUrlBasedView;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
 
public class CustomViewResolver extends UrlBasedViewResolver implements Ordered {
	
	/**
	 *   CustomViewResolver 구현체 Class
	 *   UrlBasedViewResolver 에서는 특정 surfix에 매칭되는 URL Pattern이 아니면 Exception을 발생하는 문제가 있음.
	 *   다중 View Resolver를 구현하기 위해서 Exception이 아닌 null을 반환하여 p:order값에 따른 여러
	 *   ViewResolver를 호출할 수 있도록 Customizing함.
	 */
	
 @Override
 protected View loadView(String viewName, Locale locale) throws Exception {
	 AbstractUrlBasedView view = buildView(viewName);
	 View viewObj = (View)getApplicationContext().getAutowireCapableBeanFactory().initializeBean(view, viewName);
	 if (viewObj instanceof JstlView) {
		 	JstlView jv = (JstlView) viewObj;
		 	/*
		 	System.out.println("//=====================");
		 	System.out.println(" getBeanName : "+jv.getBeanName());
		 	System.out.println(" getUrl : "+jv.getUrl());
		 	System.out.println(" toString : "+jv.toString());
		 	System.out.println(" getContentType : "+jv.getContentType());
		 	System.out.println(" getRequestContextAttribute : "+jv.getRequestContextAttribute());
		 	System.out.println(" getBeanName().indexOf(\"jsp\") : "+jv.getBeanName().indexOf(".jsp"));
		 	System.out.println("//=====================");
		 	*/
		 	if (jv.getBeanName().indexOf("/") != -1) {
		 			return null;
		 	}
	 }
	 return viewObj;
 }
 
}