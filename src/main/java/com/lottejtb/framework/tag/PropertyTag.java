package com.lottejtb.framework.tag;

import java.io.IOException;

import javax.servlet.jsp.JspContext;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.log4j.Logger;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.lottejtb.comm.util.StringUtil;

import egovframework.rte.fdl.property.EgovPropertyService;


public class PropertyTag extends SimpleTagSupport {

	private static final Logger logger = Logger.getLogger(PropertyTag.class);
	
	private String key; 
	private String var; 

	/**
	 * key Setter Method
	 * @param key
	 */
	public void setKey(String key) {
		this.key = key;
	}

	/**
	 * var Setter Method
	 * @param var
	 */
	public void setVar(String var) {
		this.var = var;
	}

	/* (non-Javadoc)
	 * @see javax.servlet.jsp.tagext.SimpleTagSupport#doTag()
	 */
	public void doTag() throws JspException {
		JspContext ctx = getJspContext();
		JspWriter out = ctx.getOut();
		WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(((PageContext) ctx).getServletContext());
		EgovPropertyService propertiesService = (EgovPropertyService) wac.getBean("propertiesService");
		
		try {
			if(!StringUtil.isEmpty(var)){
				getJspContext().setAttribute(var, propertiesService.getString(key));
			}
			else{
				out.print(propertiesService.getString(key));
			}
			
		} catch (IOException e) {
			logger.error(e);
		}
	}
	
}
