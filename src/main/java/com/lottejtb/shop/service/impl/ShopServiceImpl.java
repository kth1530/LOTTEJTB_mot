package com.lottejtb.shop.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lottejtb.shop.service.ShopService;
import com.lottejtb.shop.service.ShopVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("ShopService")
public class ShopServiceImpl extends EgovAbstractServiceImpl implements ShopService{
	@Resource(name="ShopDAO")
    private ShopDAO shopDAO;
	
	@Override
	public List selectShopList(ShopVO vo) throws Exception {
		return shopDAO.selectShopList(vo);
	}
	
	@Override
	public List selectShopListRoad(ShopVO vo) throws Exception {
		return shopDAO.selectShopListRoad(vo);
	}
	
	@Override
	public List selectShopListLotte(ShopVO vo) throws Exception {
		return shopDAO.selectShopListLotte(vo);
	}
	
	@Override
	public List selectShopListCount(ShopVO vo) throws Exception {
		return shopDAO.selectShopListCount(vo);
	}
}
