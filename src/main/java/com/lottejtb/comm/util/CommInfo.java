package com.lottejtb.comm.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.lottejtb.comm.service.CommService;
import com.lottejtb.comm.service.impl.CommDao;
import com.lottejtb.sso.service.CookieInfoVO;


@Service("CommInfo")
public class CommInfo {
	
	public static final String SESSION_ATTR_NAME = "loginInfo";
	//private static String custCd; //고객코드
	//private static String knm;  //고객명
	//private static String id;   //고객아이디
	//private static String email; //고객이메일
	//private static String sex;  //성별
	//private static String custGradeCd;	// 고객등급 코드
	//private static String custGradeNm;	// 고객등급 명
	//private static String birthday;		// 생년월일
	//private static int age;
	
	@Resource(name = "commDao")
	CommDao dao;
		
	@Resource(name = "commService")
	CommService commService;
	
	
	public void setSessionUserInfo(HttpServletRequest request, Map<String, Object> map)throws Exception {
			
		Map<String, Object> paramMap = new HashMap<String, Object>();	
		Map<String, Object> returnMap = new HashMap<String, Object>();	
		
		paramMap.putAll((Map)request.getSession().getAttribute("tmp_loginInfo"));
		
		returnMap = dao.select("selectUserInfo", paramMap);
		
		request.getSession().setAttribute(SESSION_ATTR_NAME, returnMap);
	}
	
	public void resetSessionUserInfo(HttpServletRequest request)throws Exception{
		
		Map<String, Object> returnMap = new HashMap<String, Object>();	
		Map<String, Object> commandMap = new HashMap<String, Object>();	
		
		commandMap.put("USER_ID",getSessionUserInfo(request, "SS_USER_ID").get("SS_USER_ID"));
		commandMap.put("SS_LANG_TYPE",getSessionUserInfo(request, "SS_LANG_TYPE").get("SS_LANG_TYPE"));
		
		returnMap =(Map<String, Object>)dao.select("selectUserInfo", commandMap);
		
		Map<String,Object> tempMap = (Map<String, Object>)getSessionInfo(request, SESSION_ATTR_NAME);
		
		tempMap.putAll(returnMap);
		
		request.getSession().setAttribute(SESSION_ATTR_NAME, tempMap);	
	}
	
	public void modifySessionUserInfo(HttpServletRequest request, Map<String, Object> sessionMap, Map<String, Object> modifyMap )  throws Exception{
		if(sessionMap != null){
			for(String key : modifyMap.keySet()){
				sessionMap.put(key, modifyMap.get(key));
			}
			
			request.getSession().setAttribute(SESSION_ATTR_NAME, sessionMap);
		}
	}
	
	public void setSessionInfo(HttpServletRequest request, String key, Object value)  throws Exception{
		request.getSession().setAttribute(key, value);
	}
	
	public Object getSessionInfo(HttpServletRequest request, String key)  throws Exception{
		return request.getSession().getAttribute(key);
	}
	
	public void removeSessionInfo(HttpServletRequest request, String key)  throws Exception{
		request.getSession().removeAttribute(key);
	}
	
	public Map getSessionUserInfo(HttpServletRequest request, String paramList){
		Map<String, Object> paramMap = (Map<String, Object>)request.getSession().getAttribute(SESSION_ATTR_NAME);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		String[] conditionList = paramList.split(",");
		
		if(paramMap != null){
			if(conditionList.length > 0){
				
				int roopCnt = conditionList.length;
				
				for(int i =0 ; i < roopCnt ; i ++ ){
					returnMap.put(conditionList[i], paramMap.get(conditionList[i]));
				}
			}				
		}

		return returnMap;
	}
	
	public Map getParameterMap(HttpServletRequest request) throws Exception{
		
		Map<String, Object> commandMap = new HashMap<String, Object>();
		
		Enumeration<?> enumeration;
		enumeration = request.getParameterNames();
		
		while (enumeration.hasMoreElements()) {
			String key = (String) enumeration.nextElement();
			String[] values = request.getParameterValues(key);
			if (values != null) {
				if(key.indexOf("[]") == -1){
					commandMap.put(key, (values.length > 1) ? values : StringUtil.unescapeHtml(values[0]));
				}else{
					List rtnList=new ArrayList();
					for (String value : values) {
						rtnList.add(value);
					}
					commandMap.put(key.substring(0,key.lastIndexOf("[]")), rtnList);
				}
			}
		}
		
		return commandMap;
	}
	
	//세션값 셋팅
	public void setSessionInfo(HttpServletRequest request, String name, CookieInfoVO dto) {
		request.getSession(true).invalidate();
		if(dto != null) {
			/*
			String custCd = dto.get(0).getCust_cd();
			String knm = dto.get(0).getKnm();
			String id = dto.get(0).getId();
			String email = dto.get(0).getEmail();
			String sex = dto.get(0).getSex();
			String custGradeCd = dto.get(0).getCustGradeCd();
			String custGradeNm = dto.get(0).getCustGradeNm();
			String birthday = dto.get(0).getBirthday();
			*/
			
			String custCd = dto.getCust_cd();
			String knm = dto.getKnm();
			String id = dto.getId();
			String email = dto.getEmail();
			String sex = dto.getSex();
			String custGradeCd = dto.getCustGradeCd();
			String custGradeNm = dto.getCustGradeNm();
			String birthday = dto.getBirthday();
			String cno = dto.getCno();
			String mbrCustno = dto.getMbrCustno();
			String mblNo = dto.getMblNo();
			
			int age;
			if(birthday == null){
				age = 0;
			}else{
				Calendar cal = Calendar.getInstance();
				SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
				String todayDt = simple.format(cal.getTime()); // 8자리 아라비아숫자 반환
				
				String str = birthday.substring(2, 4); // 생년월일 연도 두자리
				String year = todayDt.substring(2, 4); // 현재년도 두자리
				
				age = Integer.parseInt(year) - Integer.parseInt(str) + 1;
				if (age < 0) {
					age += 100;
				}
			}
				
			Map<String, Object> list = new HashMap<String, Object>();
			
			list.put("cust_cd", custCd);
			list.put("knm", knm);
			list.put("id", id);
			list.put("email", email);
			list.put("sex", sex);
			list.put("custGradeCd", custGradeCd);
			list.put("custGradeNm", custGradeNm);
			list.put("birthday", birthday);
			list.put("age", String.valueOf(age));
			list.put("cno", cno);
			list.put("mbrCustno", mbrCustno);
			list.put("mblNo", mblNo);
			
			request.getSession(true).setAttribute(name, list);
			
			//session.setAttribute(name, dto);
		}
	}
	
	//세션 초기화
	public void setSessionInit(HttpServletRequest request) {
		request.getSession().setAttribute(SESSION_ATTR_NAME, null);
		
		System.out.println("=======session init==================");
		
//		String custCd = "";
//		String knm= "";
//		String id= "";
//		String email="";
//		String sex="";
//		String custGradeCd = "";
//		String custGradeNm = "";
//		String birthday = "";
//		int    age = 0;
	}
	
	/*
	public static String getCustCD(HttpServletRequest request) {
		String custCd = "";
		HttpSession sessionReq = request.getSession(true); 
		Map<String, Object> param = new HashMap<String, Object>();
		
		if(sessionReq != null) {
			param = (Map<String, Object>)sessionReq.getAttribute(SESSION_ATTR_NAME);
			
			if(param != null){
				custCd = param.get("cust_cd").toString();
			}
		}
		
		return custCd;
	}
	//고객명
	public static String getKnm(HttpServletRequest request){
		String knm = null;
		HttpSession sessionReq = request.getSession(true);
		Map<String, Object> param = new HashMap<String, Object>();
		
		if(sessionReq != null) {
			param = (Map<String, Object>)sessionReq.getAttribute(SESSION_ATTR_NAME);
			
			if(param != null){
				knm = param.get("knm").toString();
			}
		}
		return knm;
	}
	//id
	public static String getId(HttpServletRequest request) {
		String id = null;
		HttpSession sessionReq = request.getSession(true);
		Map<String, Object> param = new HashMap<String, Object>();
		
		if(sessionReq != null) {
			param = (Map<String, Object>)sessionReq.getAttribute(SESSION_ATTR_NAME);
			
			if(param != null){
				id = param.get("id").toString();
			}
		}
		return id;
	}
	//email
	public static String getEmail(HttpServletRequest request) {
		email= null;
		HttpSession sessionReq = request.getSession(true);
		Map<String, Object> param = new HashMap<String, Object>();
		
		if(sessionReq != null) {
			param = (Map<String, Object>)sessionReq.getAttribute(SESSION_ATTR_NAME);
			
			if(param != null){
				email = param.get("email").toString();
			}
		}
		return email;
	}
	//
	public static String getSex(HttpServletRequest request) {
		sex = null;
		HttpSession sessionReq = request.getSession(true);
		Map<String, Object> param = new HashMap<String, Object>();
		
		if(sessionReq != null) {
			param = (Map<String, Object>)sessionReq.getAttribute(SESSION_ATTR_NAME);
			
			if(param != null){
				sex = param.get("sex").toString();
			}
		}
		return sex;
	}
	
	public static String getCustGradeCd(HttpServletRequest request) {
		custGradeCd = null;
		HttpSession sessionReq = request.getSession(true);
		Map<String, Object> param = new HashMap<String, Object>();
		
		if(sessionReq != null) {
			param = (Map<String, Object>)sessionReq.getAttribute(SESSION_ATTR_NAME);
			
			if(param != null){
				custGradeCd = param.get("custGradeCd").toString();
			}
		}
		return custGradeCd;
	}
	
	public static String getCustGradeNm(HttpServletRequest request) {
		String custGradeNm = null;
		HttpSession sessionReq = request.getSession(true);
		Map<String, Object> param = new HashMap<String, Object>();
		
		if(sessionReq != null) {
			param = (Map<String, Object>)sessionReq.getAttribute(SESSION_ATTR_NAME);
			
			if(param != null){
				custGradeNm = param.get("custGradeNm").toString();
			}
		}
		return custGradeNm;
	}
	
	public static String getBirthday(HttpServletRequest request){
		birthday = null;
		HttpSession sessionReq = request.getSession(true);
		Map<String, Object> param = new HashMap<String, Object>();
		
		if(sessionReq != null) {
			param = (Map<String, Object>)sessionReq.getAttribute(SESSION_ATTR_NAME);
			
			if(param != null){
				birthday = param.get("birthday").toString();
			}
		}
		return birthday;
	}
	
	public static int getAge(HttpServletRequest request){
		age = 0;
		HttpSession sessionReq = request.getSession(true);
		if(sessionReq != null) {
			Map<String, Object> param = (Map<String, Object>)sessionReq.getAttribute(SESSION_ATTR_NAME);
			
			if(param != null){
				age = Integer.parseInt(param.get("age").toString());
			}
		}
		return age;
	}
	*/
	
	public Object getDataFormat(String paramList){
		DateFormat sc = DateFormat.getInstance();
		return sc.getInstance().getDataFormatMap(paramList);
	}
	
	/**
	 * 널, 빈값체크
	 * @param val
	 * @return
	 */
	public boolean isNullOrEmpty(Object val){
		return(val == null || "".equals(val)) ? true : false;	
	}
	
	public String loginCheck(){
		String moveUrl = "";
		/*
		if(CommInfo.getCustCD() == null){
			moveUrl = "";
		}
		*/
		
		return moveUrl;
	}
	
	public String loginCheck(String successUrl){
		String moveUrl = "";
		
		return moveUrl;
	}
	
	public String loginCheck(String successUrl, String failUrl){
		String moveUrl = "";
		
		return moveUrl;
	}
}

