package com.lottejtb.goods.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.lottejtb.goods.service.CartService;
import com.lottejtb.goods.service.DIWishListVO;

/**
* 클래스명    : 찜하기 서비스를 정의한 인터페이스를 구현한 클래스  
* @ClassDesc  : 찜하기 서비스를 정의한 인터페이스를 구현한 클래스    
* @FileName   : CartServiceImpl.java
* @TableName  : t4dev/DI_WISH_LIST
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.25 /  / 최초작성
*/

@Service("CartService")
@SuppressWarnings("unchecked")
public class CartServiceImpl implements CartService {

	private Logger logger = Logger.getLogger(this.getClass());
	
    @Resource(name="CartDAO")
    private CartDAO cartDAO;
    
	/**
	 * 찜하기 정보 리스트를 조회하는 기능 
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List srchCartList(DIWishListVO param) throws Exception {
		return cartDAO.selectCartList(param);
	}
	
	/**
	 * 찜하기 정보를 등록하는 기능 
	 * @param vo
	 * @return
	 * @throws Exception
	 */	
	public void saveCart(DIWishListVO param) throws Exception {
		cartDAO.insertCart(param);
	}
	
	/**
	 * 찜하기 정보 중복체크하는 기능 
	 * @param vo
	 * @return
	 * @throws Exception
	 */	
	public int duplicationCheck(DIWishListVO param) throws Exception{
		return cartDAO.duplicationCheck(param);
	}
	
	/**
	 * 찜하기 정보를 업데이트하는 기능 
	 * @param vo
	 * @return
	 * @throws Exception
	 */	
	public void updateCart(DIWishListVO param) throws Exception{
		cartDAO.updateCart(param);
	}
}
