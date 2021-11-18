package com.lottejtb.search.service;

import java.util.List;

import com.lottejtb.comm.service.CommCtgVO;

/**
* 클래스명    :  상품 검색 서비스를 정의한 인터페이스 
* @ClassDesc  : 상품 검색 서비스를 정의한 인터페이스 
* @FileName   : SearchService.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.11 /  / 최초작성
*/

public interface SearchService {
	
	/** 상품 검색 UI > 공통 > 상품 검색 리스트 조회 **/
	public List srchGoodsList(SearchGoodsVO param) throws Exception;

	/** 상품 검색 UI > 공통 > 상품 검색 리스트 카운트 조회 **/
	public int srchGoodsListCount(SearchGoodsVO param) throws Exception;
	
	/*투어멘토링 대분류*/
	public List selectAreaList(CommCtgVO param) throws Exception;	
	
	/*투어멘토링 검색리스트*/
	public List selectTourMentoList(TourMentoVO param) throws Exception;
	
	/*투어멘토링 검색리스트 count*/
	public int selectTourMentoListCnt(TourMentoVO param) throws Exception;
	
}
