package com.lottejtb.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lottejtb.framework.filter.HttpsRequestWrapper;

public class CrossDomainFilter implements Filter {
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse servletResponse,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		if (!(request instanceof HttpServletRequest)) {
			throw new ServletException("This filter can "
					+ " only process HttpServletRequest requests");
		}
		
		// System.out.println("what is this");
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		response.addHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Headers", "origin, x-requested-with, content-type, accept");
		response.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT");
		
		//HttpsRequestWrapper httpsRequest = new HttpsRequestWrapper((HttpServletRequest)request);
	    //httpsRequest.setResponse((HttpServletResponse)response);

		chain.doFilter(request, response);
		/*for(String name : response.getHeaderNames()){
			System.out.println("name : " + name + " value : " + response.getHeader(name));
		}*/
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
	}
	
	
}