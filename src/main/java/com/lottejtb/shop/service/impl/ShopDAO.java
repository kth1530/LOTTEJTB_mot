package com.lottejtb.shop.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lottejtb.framework.common.CommAbstractDAO;
import com.lottejtb.shop.service.ShopVO;

@Repository("ShopDAO")
public class ShopDAO extends CommAbstractDAO {
	public List selectShopList(ShopVO vo) throws Exception{
		return list("ShopDAO.selectShopList",vo);
    }
	
	public List selectShopListRoad(ShopVO vo) throws Exception{
		return list("ShopDAO.selectShopListRoad",vo);
    }
	
	public List selectShopListLotte(ShopVO vo) throws Exception{
		return list("ShopDAO.selectShopListLotte",vo);
    }
	
	public List selectShopListCount(ShopVO vo) throws Exception{
		return list("ShopDAO.selectShopListCount",vo);
    }
}
