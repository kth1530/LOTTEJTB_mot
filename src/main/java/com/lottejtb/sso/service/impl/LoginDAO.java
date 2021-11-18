package com.lottejtb.sso.service.impl;

import java.awt.geom.CubicCurve2D;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.lottejtb.framework.common.CommAbstractDAO;
import com.lottejtb.sso.service.CookieInfoVO;
import com.lottejtb.sso.service.LoginVO;


@Repository("LoginDAO")
public class LoginDAO extends CommAbstractDAO {
	@Resource(name="sqlMapClient_free")
	SqlMapClient sqlMapClient_free; 
	
	public List checkGuestLogin(LoginVO vo) throws SQLException {
		List list = null;
		
		list = list("LoginDAO.checkGuestLogin", vo);
		
		if(list.size() == 0){
			//list = list("FreeMytourDAO.selectFitRsvMstCnt", vo);
			list = sqlMapClient_free.queryForList("FreeMytourDAO.selectFitRsvMst", vo);
		}
		
		return list; 
	}

	public List<CookieInfoVO> cookieSaveData(CookieInfoVO vo) throws SQLException {
		return (List<CookieInfoVO>)list("LoginDAO.cookieSaveData", vo);
	}

	public String cookieInsert(CookieInfoVO vo) throws SQLException {
		return (String) insert("LoginDAO.cookieInsert", vo);
	}

	public void cookieUpdate(CookieInfoVO vo) throws SQLException {
		update("LoginDAO.cookieUpdate", vo);
	}

	public List<CookieInfoVO> getCookieInfo(CookieInfoVO vo) throws SQLException {
		return (List<CookieInfoVO>)list("LoginDAO.getCookieInfo", vo);
	}
	
	public void updateDeviceCustId(CookieInfoVO vo) throws SQLException{
		update("LoginDAO.updateDeviceCustId", vo);
	}

	public String loginLogInsert(LoginVO vo) throws SQLException {
		return (String) insert("LoginDAO.loginLogInsert", vo);
	}

	public List selectLoginLog(LoginVO vo) throws SQLException {
		List list = null;
		
		list = list("LoginDAO.selectLoginLog", vo);
		return list; 
	}

}
