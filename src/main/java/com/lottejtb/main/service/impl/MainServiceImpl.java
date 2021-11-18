package com.lottejtb.main.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lottejtb.main.service.CodeDetailVO;
import com.lottejtb.main.service.MainService;
import com.lottejtb.main.service.MainVO;
import com.lottejtb.main.service.MenuVO;
import com.lottejtb.main.service.PromoVO;
import com.lottejtb.main.service.RankVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("MainService")
public class MainServiceImpl extends EgovAbstractServiceImpl implements MainService{
    
    @Resource(name="MainDAO")
    private MainDAO mainDao;

    @Override
    public MainVO selecDetail(MainVO vo) throws Exception {
        return mainDao.selectDetail(vo);
    }

    @Override
    public List selectList(MainVO vo) throws Exception {
        return mainDao.selectList(vo);
    }
    
    @Override
	public List<MenuVO> menuList(HashMap<String, Object> parameter) throws Exception {
		return mainDao.menuList(parameter);
	}
    
    @Override
    public int selectDeviceInfoCnt(MainVO vo) throws Exception{
    	return mainDao.selectDeviceInfoCnt(vo);
    }
    
    @Override
    public void insertDeviceInfo(MainVO vo) throws Exception{
    	mainDao.insertDeviceInfo(vo);
    }
    
    @Override
    public void updateDeviceInfo(MainVO vo) throws Exception{
    	mainDao.updateDeviceInfo(vo);
    }
    
    @Override
	public List<PromoVO> bannerList(PromoVO vo) throws Exception{
    	return mainDao.bannerList(vo);
    }
    
    @Override
	public List<CodeDetailVO> codeDetailList(CodeDetailVO vo) throws Exception{
    	return mainDao.codeDetailList(vo);
    }
    
    @Override
	public List<PromoVO> bestDetailList(PromoVO vo) throws Exception{
    	return mainDao.bestDetailList(vo);
    }
    
    @Override
	public List menuMapList(MenuVO vo) throws Exception{
    	return mainDao.menuMapList(vo);
    }
    
    @Override
    public List realRanking(RankVO vo) throws Exception{
    	return mainDao.realRanking(vo);
    }
    
    @Override
    public List selectHotGoods(HashMap<String, Object> parameter) throws Exception{
    	return mainDao.selectHotGoods(parameter);
    }
    
    @Override
	public Object selectAdPop(HashMap<String, Object> parameter) throws Exception{
    	return mainDao.selectAdPop(parameter);
    }
    
    @Override
	public List selectTimeGoods(HashMap<String, Object> parameter) throws Exception{
    	return mainDao.selectTimeGoods(parameter);
    }
    
    @Override
	public void updateHitCount(HashMap<String, Object> parameter) throws Exception{
    	mainDao.updateHitCount(parameter);
    }
}