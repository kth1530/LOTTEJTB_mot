package com.lottejtb.goods.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lottejtb.framework.common.CommAbstractDAO;
import com.lottejtb.goods.service.DIWishListVO;

@Repository("CartDAO")
public class CartDAO extends CommAbstractDAO {

	/**
	 * 찜하기 정보 리스트를 조회하는 기능 
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List selectCartList(DIWishListVO param) throws Exception {
		return list("CartDAO.selectCartList", param);
	}
	
	/**
	 * 찜하기 정보를 등록하는 기능 
	 * @param vo
	 * @return
	 * @throws Exception
	 */	
	public void insertCart(DIWishListVO param) throws Exception {
		insert("CartDAO.insertCart", param);
	}
	
	/**
	 * 찜하기 정보 중복체크하는 기능 
	 * @param vo
	 * @return
	 * @throws Exception
	 */	
	public int duplicationCheck(DIWishListVO param) throws Exception {
		return (Integer) select("CartDAO.duplicationCheck", param);
	}
	
	/**
	 * 찜하기 정보를 업데이트하는 기능 
	 * @param vo
	 * @return
	 * @throws Exception
	 */	
	public void updateCart(DIWishListVO param) throws Exception {
		update("CartDAO.updateCart", param);
	}
}
