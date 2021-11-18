package com.lottejtb.setting.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lottejtb.setting.service.SettingService;
import com.lottejtb.setting.service.SettingVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("SettingService")
public class SettingServiceImpl extends EgovAbstractServiceImpl implements SettingService {
	@Resource(name="SettingDAO")
    private SettingDAO settingDAO;
    
	@Override
	public SettingVO selectAppCheck(SettingVO vo) throws Exception {
		return settingDAO.selectAppCheck(vo);
	}
	
	@Override
	public void insertMarketingReceiveYn(SettingVO vo) throws Exception{
		settingDAO.insertMarketingReceiveYn(vo);
	}
	
	@Override
	public SettingVO selectMarketingReceiveYn(SettingVO vo) throws Exception{
		return settingDAO.selectMarketingReceiveYn(vo);
	}
	
	@Override
	public int selectMarketingReceiveCnt(SettingVO vo) throws Exception{
		return settingDAO.selectMarketingReceiveCnt(vo);
	}
	
	@Override
	public void updateMarketingReceiveYn(SettingVO vo) throws Exception{
		settingDAO.updateMarketingReceiveYn(vo);
	}
}
