package com.lottejtb.shop.service;

import java.util.List;


public interface ShopService {
	/**
	 * 매장 리스트 (전체)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List selectShopList(ShopVO vo) throws Exception;
	
	/**
	 * 매장 리스트 (로드샵)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List selectShopListRoad(ShopVO vo) throws Exception;
	
	/**
	 * 매장 리스트 (롯데매장)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List selectShopListLotte(ShopVO vo) throws Exception;
	
	/**
	 * 매장 리스트 카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List selectShopListCount(ShopVO vo) throws Exception;
}
