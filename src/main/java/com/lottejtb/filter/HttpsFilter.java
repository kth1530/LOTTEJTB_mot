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

public class HttpsFilter implements Filter{
	public void doFilter (ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpsRequestWrapper httpsRequest = new HttpsRequestWrapper((HttpServletRequest)request);
		httpsRequest.setResponse((HttpServletResponse)response);
		
		chain.doFilter(httpsRequest, response);
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}
}