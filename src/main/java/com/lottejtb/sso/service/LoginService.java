package com.lottejtb.sso.service;

import java.util.List;

public interface LoginService {

	/**
	 * 비회원예약 
	 * @param vo
	 * @return
	 * @throws Exception
	 */

	public List checkGuestLogin(LoginVO vo) throws Exception;

	public List<CookieInfoVO> cookieSaveData(CookieInfoVO vo) throws Exception;

	public String cookieInsert(CookieInfoVO vo) throws Exception;

	public void cookieUpdate(CookieInfoVO vo) throws Exception;

	public List<CookieInfoVO> getCookieInfo(CookieInfoVO vo) throws Exception;
	
	public void updateDeviceCustId(CookieInfoVO vo) throws Exception;
	
	public String loginLogInsert(LoginVO vo) throws Exception;
	
	public List selectLoginLog(LoginVO vo) throws Exception;
}
