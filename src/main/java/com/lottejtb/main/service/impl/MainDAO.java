package com.lottejtb.main.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.lottejtb.framework.common.CommAbstractDAO;
import com.lottejtb.main.service.CodeDetailVO;
import com.lottejtb.main.service.MainVO;
import com.lottejtb.main.service.MenuVO;
import com.lottejtb.main.service.PromoVO;
import com.lottejtb.main.service.RankVO;

@Repository("MainDAO")
public class MainDAO  extends CommAbstractDAO{
    
    public MainVO selectDetail(MainVO vo) throws Exception{
        return (MainVO) select("MainDAO.selectDetail",vo);
    }
    
    public List selectList(MainVO vo) throws Exception{
        return list("MainDAO.selectList",vo);
    }
    
    public List<MenuVO> menuList(HashMap<String, Object> parameter) throws Exception{
        return (List<MenuVO>) list("MainDAO.menuList",parameter);
    }
    
    public int selectDeviceInfoCnt(MainVO vo) throws Exception{
    	return (Integer) select("MainDAO.selectDeviceInfoCnt", vo);
    }
    
    public void insertDeviceInfo(MainVO vo) throws Exception{
    	insert("MainDAO.insertDeviceInfo", vo);
    }
    
    public void updateDeviceInfo(MainVO vo) throws Exception{
    	insert("MainDAO.updateDeviceInfo", vo);
    }
    
    public List<PromoVO> bannerList(PromoVO vo) throws Exception{
    	return (List<PromoVO>) list("MainDAO.bannerList",vo);
    }
    
    public List<CodeDetailVO> codeDetailList(CodeDetailVO vo) throws Exception{
    	return (List<CodeDetailVO>) list("MainDAO.codeDetailList", vo);
    }
    
    public List<PromoVO> bestDetailList(PromoVO vo) throws Exception{
    	return (List<PromoVO>) list("MainDAO.bestDetailList", vo);
    }
    
    public List menuMapList(MenuVO vo) throws Exception{
    	return list("MainDAO.menuMapList", vo);
    }
    
    public List realRanking(RankVO vo) throws Exception{
    	return list("MainDAO.realRanking", vo);
    }
    
    public List selectHotGoods(HashMap<String, Object> parameter) throws Exception{
    	return list("MainDAO.selectHotGoods", parameter);
    }
    
    public Object selectAdPop(HashMap<String, Object> parameter) throws Exception{
    	return select("MainDAO.selectAdPop", parameter);
    }
    
    public List selectTimeGoods(HashMap<String, Object> parameter) throws Exception{
    	return list("MainDAO.selectTimeGoods", parameter);
    }
    
    public void updateHitCount(HashMap<String, Object> parameter) throws Exception{
    	update("MainDAO.updateHitCount", parameter);
    }
}