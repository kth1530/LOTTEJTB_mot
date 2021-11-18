package com.lottejtb.sso.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;





import com.lottejtb.sso.service.CookieInfoVO;
import com.lottejtb.sso.service.LoginService;
import com.lottejtb.sso.service.LoginVO;

@Service("LoginService")
public class LoginServiceImpl implements LoginService {

	@Resource(name="LoginDAO")
	private LoginDAO loginDAO;
	
	@Override
	public List checkGuestLogin(LoginVO vo) throws Exception {
		return loginDAO.checkGuestLogin(vo);
	}

	@Override
	public List<CookieInfoVO> cookieSaveData(CookieInfoVO vo) throws Exception {
		return loginDAO.cookieSaveData(vo);
	}

	@Override
	public String cookieInsert(CookieInfoVO vo) throws Exception {
		return loginDAO.cookieInsert(vo);
	}

	@Override
	public void cookieUpdate(CookieInfoVO vo) throws Exception {
		loginDAO.cookieUpdate(vo);
	}

	@Override
	public List<CookieInfoVO> getCookieInfo(CookieInfoVO vo) throws Exception {
		return loginDAO.getCookieInfo(vo);
	}

	@Override
	public void updateDeviceCustId(CookieInfoVO vo) throws Exception{
		loginDAO.updateDeviceCustId(vo);
	}

	@Override
	public String loginLogInsert(LoginVO vo) throws Exception {
		return loginDAO.loginLogInsert(vo);
	}

	@Override
	public List selectLoginLog(LoginVO vo) throws Exception {
		return loginDAO.selectLoginLog(vo);
	}

}
