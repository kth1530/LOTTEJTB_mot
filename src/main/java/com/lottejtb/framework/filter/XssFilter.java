package com.lottejtb.framework.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.MDC;

import com.lottejtb.comm.web.CommLoginSessionManager;

public class XssFilter implements Filter {
	
	protected static final Logger logger = Logger.getLogger(XssFilter.class);
	
	@Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
	
	@Override
    public void destroy() {
    }

	@Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)throws IOException, ServletException {
	    
	    try {
	        request.setCharacterEncoding("utf-8");
            chain.doFilter(new XssRequestWrapper((HttpServletRequest) request), response);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
	    
	    /*
    	String userId = null;
    	String userName = null;
    	String userAddr =  null;
    	HttpSession session = ((HttpServletRequest) request).getSession();
    	CommLoginSessionManager loginSessionManager = (CommLoginSessionManager)session.getAttribute("scopedTarget.loginSessionManager");
    	
    	if(loginSessionManager != null){
	    	userId   = loginSessionManager.getLoginVO().getUserid()   == null ? "" : loginSessionManager.getLoginVO().getUserid();
	    	userName = loginSessionManager.getLoginVO().getUsernm() == null ? "" : loginSessionManager.getLoginVO().getUsernm();
	    	userAddr = request.getRemoteAddr();
    	}
    	try{
    		MDC.put("userId", userId);
    		MDC.put("userNm",userName );
    		MDC.put("userAddr", userAddr);
    		request.setCharacterEncoding("utf-8");
    		chain.doFilter(new XssRequestWrapper((HttpServletRequest) request), response);
    	}catch (Exception e) {
    		logger.error(e.getMessage());
		}finally{
			MDC.remove("userId");
			MDC.remove("userNm");
			MDC.remove("userAddr");
			MDC.clear();
		}
    	*/
    }

}
