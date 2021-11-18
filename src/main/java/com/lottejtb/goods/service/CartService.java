package com.lottejtb.goods.service;

import java.util.List;

/**
* 클래스명    : 찜하기 서비스를 정의한 인터페이스  
* @ClassDesc  : 찜하기 서비스를 정의한 인터페이스  
* @FileName   : CartService.java
* @TableName  : t4dev/DI_WISH_LIST
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.25 /  / 최초작성
*/

public interface CartService {
	
	/**
	 * 찜하기 정보 리스트를 조회하는 기능 
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List srchCartList(DIWishListVO param) throws Exception;	
	
	/**
	 * 찜하기 정보를 등록하는 기능 
	 * @param vo
	 * @return
	 * @throws Exception
	 */	
	public void saveCart(DIWishListVO param) throws Exception;
	
	/**
	 * 찜하기 정보 중복체크하는 기능 
	 * @param vo
	 * @return
	 * @throws Exception
	 */	
	public int duplicationCheck(DIWishListVO param) throws Exception;
	
	/**
	 * 찜하기 정보를 업데이트하는 기능 
	 * @param vo
	 * @return
	 * @throws Exception
	 */	
	public void updateCart(DIWishListVO param) throws Exception;
}
