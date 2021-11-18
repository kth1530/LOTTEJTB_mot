package com.lottejtb.framework.servlet;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.Enumeration;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lottejtb.framework.common.CommConstStat;
import com.lottejtb.framework.common.CommProperty;
import com.lottejtb.util.AutoComplete;

/**
 * <pre class="doc_class">
 * Title: 웹서버가 처음 기동할 때 한번 수행하는 INIT Servlet
 * Description
 * 		- globals.propertis 를 읽어 servletContext 영역에 넣는다.
 * </pre>
 */
@SuppressWarnings("serial")
public class InitServlet extends HttpServlet {

	//private final Logger logger = Logger.getLogger(this.getClass());
	private static final Logger logger = LoggerFactory.getLogger(InitServlet.class);
	//private final boolean isInfoEnabled = logger.isInfoEnabled();
	//private static int intLoop = 0;

	public InitServlet() {
		super();
	}

	/**
	 * SERVER 시작을 Log에 기록한다.<br/>
	 * 프로퍼티 파일을 servletContext에 넣는다.
	 * 
	 * @param config web.xml에서 설정한 변수값
	 * @throws ServletException
	 * @see javax.servlet.GenericServlet#init(javax.servlet.ServletConfig)
	 */
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		/*
		System.out.println("DEBUG : " + logger.isDebugEnabled());
		System.out.println("INFO :  " + logger.isInfoEnabled());
		
		System.out.println("//=============="+isInfoEnabled);
		*/
		
		AutoComplete auto_complete = new AutoComplete();
		
		/*
		if (isInfoEnabled) {
			logger.info("");
			logger.info("===================== SERVER INIT START ====================");
			logger.info("");
		}
		*/

		loadProperty();

		loadConstant();

		//loadCommCode();
		
		/*
		if (isInfoEnabled) {
			logger.info("");
			logger.info("===================== SERVER INIT END ====================");
			logger.info("");
		}
		*/
	}

	/**
	 * Propery 파일을 로드하여 servletContext에 넣는다.
	 */
	private void loadProperty() {
		Properties propertyMap = CommProperty.getPropertyMap();
		/*
		if (logger.isInfoEnabled()) {
			Enumeration e = propertyMap.keys();
			logger.info("1) properties ");
			while (e.hasMoreElements()) {
				String key = (String) e.nextElement();
				//logger.info("== ["+intLoop+"] " + key + " : " + propertyMap.getProperty(key));
				//intLoop = intLoop + 1;
			}
		}
		*/
		
		super.getServletContext().setAttribute("prop", propertyMap);
	}

	/**
	 * 공통코드를 서블릿 컨텍스트에 저장한다.
	
	private void loadCommCode() {

		CachedCode.init(getServletContext());
		super.getServletContext().setAttribute("codeFullCd", CachedCode.getCodeFullCdMap());
		super.getServletContext().setAttribute("codeMaster", CachedCode.getCodeMasterMap());
	}
	 */

	/**
	 * CommConstStat에 정의한 상수를 출력하고 컨텍스트에 저장한다.
	 */
	private void loadConstant() {
		Class<CommConstStat> constClass = CommConstStat.class;
		Field[] constFields = constClass.getFields();
		logger.info("2) ConstUtil");
		for (Field field : constFields) {
			if (isPublicStaticFinal(field)) {
				try {
					//logger.info("== ["+intLoop+"] " + field.getName() + " : " + field.get(null));
					super.getServletContext().setAttribute(field.getName(), field.get(null));
					//intLoop = intLoop + 1;
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				}
			}
		}
	}

	/**
	 * CommConstStat의 객체가 public, static, final로 정의 되어있는지 확인.
	 * 
	 * @param field
	 * @return
	 */
	private boolean isPublicStaticFinal(Field field) {
		int modifiers = field.getModifiers();
		return (Modifier.isPublic(modifiers) && Modifier.isStatic(modifiers) && Modifier.isFinal(modifiers));
	}
}
