package com.lottejtb.setting.service.impl;

import org.springframework.stereotype.Repository;

import com.lottejtb.framework.common.CommAbstractDAO;
import com.lottejtb.setting.service.SettingVO;

@Repository("SettingDAO")
public class SettingDAO extends CommAbstractDAO{
	
	public SettingVO selectAppCheck(SettingVO vo) throws Exception{
		return (SettingVO) select("SettingDAO.selectAppCheck",vo);
    }
	
	public void insertMarketingReceiveYn(SettingVO vo) throws Exception{
		update("SettingDAO.insertMarketingReceiveYn", vo);
	}
	
	public SettingVO selectMarketingReceiveYn(SettingVO vo) throws Exception{
		return (SettingVO) select("SettingDAO.selectMarketingReceiveYn", vo);
	}
	
	public int selectMarketingReceiveCnt(SettingVO vo) throws Exception{
		return (Integer) select("SettingDAO.selectMarketingReceiveCnt", vo);
	}
	
	public void updateMarketingReceiveYn(SettingVO vo) throws Exception{
		update("SettingDAO.updateMarketingReceiveYn", vo);
	}
}
