package com.lottejtb.comm.web;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.lottejtb.comm.util.CommInfo;
import com.lottejtb.comm.util.CommUtil;

public class CommInterceptor extends HandlerInterceptorAdapter {
	
	protected static final Logger logger = LoggerFactory.getLogger(CommInterceptor.class);
	
	private final boolean sessionCheck  = true; // true : 로그인 검사 OFF, false : 로그인 검사 ON
	private final boolean requestLogger = true; // false로 변경시 REQUEST LOGGER OFF
	private final String START_TIME = "startTime";
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		if (requestLogger) {
			request.setAttribute(START_TIME, System.currentTimeMillis());
			this.printRequestLog(request);
		}
		/* 다국어 처리 */
		HttpSession session = request.getSession();
		Locale locales = null;
		String lang = request.getParameter("language");
		if ( lang !=null ){
    		if (lang.matches("en")) {
    		    locales = Locale.ENGLISH;
    	    } else {
    	        locales = Locale.KOREAN;
    	    }
		}else {
            locales = Locale.KOREAN;
        }
		session.setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, locales);
		
		/* 안드로이드 버젼 체크*/
	    String andVer = CommUtil.getNateCaAndVer(request);
	    System.out.println("//===================");
	    System.out.println("Mobile Version : "+andVer);
	    System.out.println("Language Locale : "+locales);
	    System.out.println("//===================");
	    
		String servletPath = request.getServletPath();
		logger.debug("servletPath : "+servletPath);
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		if (requestLogger) {
			this.printRequestProcessingTime(request);
		}
		
		if (sessionCheck) {
			boolean result = this.needSessionCheck(request.getServletPath());
			
			if(!result){
				HttpSession session = request.getSession(true);
				HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
				
				if(sessionParam == null){
					//RequestDispatcher dispatcher = request.getSession().getServletContext().getRequestDispatcher("/sso/loginChk.do?returnUrl=" + request.getServletPath());
					//dispatcher.forward(request,response);
					response.sendRedirect("/sso/loginChk.do?returnUrl=" + request.getServletPath());
					return;
				}
			}
		}
	}
	
	private boolean needSessionCheck(String _path) {
		boolean result = true;
		ArrayList<String> ignoreList = new ArrayList<String>();
		ignoreList.add("/comm/loginForm.do");
		ignoreList.add("/comm/loginProcAjax.do");
		ignoreList.add("/mytour/mytour.do");
		ignoreList.add("/customer/qnaWrite.do");
		// 예약 관련 페이지 		
		//ignoreList.add("/reserve/reserve_clause.do");
		//ignoreList.add("/reserve/reserve_info.do");
		//ignoreList.add("/reserve/reserve_finish.do");
		
		// 상품 상세 
		 // ignoreList.add("/goods/pop_mail.do");
		 // ignoreList.add("/goods/pop_tel.do");
		 ignoreList.add("/goods/pop_review.do");
		
		// 세션 체크 안할 URL은 ignoreList에 추가해야함.
		for (String ignorePath : ignoreList) {
			if (_path.contains(ignorePath)) {
				result = false;
				break;
			}
		}
		return result;
	}
	
	private void printRequestProcessingTime(HttpServletRequest request) {
		long startTime = (Long) request.getAttribute(START_TIME);
		long endTime = System.currentTimeMillis();
		long executeTime = endTime - startTime;
		logger.info(String.format("[RES]_[ %s ]_EXECUTETIME_[ %sms ]", request.getServletPath(), executeTime));
	}
	
	private void printRequestLog(HttpServletRequest request) {
		try {
			StringBuffer sb = new StringBuffer();
			sb.append(String.format("[REQ]_IP_[ %s ]_URL_[ %s ]_PARAM_[ ", request.getRemoteAddr(), request.getServletPath()));

			// parameter
			Enumeration<?> eNames = request.getParameterNames();
			while (eNames.hasMoreElements()) {
				String name = (String) eNames.nextElement();
				String[] values = request.getParameterValues(name);
				//String paramIngo = "[" + name + ":";
				StringBuilder paramIngoSb = new StringBuilder();
				paramIngoSb.append("["+name+":");
				for (int x = 0; x < values.length; x++) {
					if (x == 0) {
						// paramIngo += URLEncoder.encode(values[x], "UTF-8");
						//paramIngo += values[x];
						paramIngoSb.append(values[x]);
					} else {
						// paramIngo += ", "+URLEncoder.encode(values[x], "UTF-8");
						//paramIngo += ", " + values[x];
						paramIngoSb.append(", "+ values[x]);
					}
				}
				if (StringUtils.isNotEmpty(name)) {
					if (name.equals("mbPw")) {
						//paramIngo = "[mbPw=xxxxxxxx]";
						paramIngoSb.append("[mbPw=xxxxxxxx]");
					}else {
						//paramIngo += "]";
						paramIngoSb.append("]");
					}
				}
				if (eNames.hasMoreElements()) {
					sb.append(paramIngoSb.toString() + ", ");
				} else {
					sb.append(paramIngoSb.toString());
				}
			}
			sb.append(" ]");
			logger.info(sb.toString());
		} catch (Exception e) {
			logger.error("{}", e);
		}
	}
}