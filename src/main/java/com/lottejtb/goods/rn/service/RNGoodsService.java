package com.lottejtb.goods.rn.service;

import java.util.List;

/**
* 클래스명    :  상품 상세 화면 관련 서비스 정의 인터페이스 
* @ClassDesc  : 상품 상세 화면 관련 서비스 정의 인터페이스 
* @FileName   : RNGoodsDetService.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2017.02.03 /  / 최초작성
*/

public interface RNGoodsService {
	
	/** 상품 상세 UI > 상품 마스터 정보 조회 **/
	public RNGDMstVO srchGDMst(RNGDMstVO param) throws Exception;
	
	/** 상품 상세 UI >  행사 상품 정보 조회 **/
	public RNETMstVO srchETMst(RNETMstVO param) throws Exception;

	/** 예약 상세 UI >  행사 상품 정보 조회 **/
	public RNETMstVO srchETMst2(RNETMstVO param) throws Exception;
	
	/** 상품 상세 UI >  행사 상품 태그 정보 조회  **/
	public RNGDTagsVO srchGDTags(RNGDTagsVO param) throws Exception;
	
	/** 상품 상세 UI >  표준약관/특별약관/국내약관  **/
	public RNETClauseInfoVO srchETClauseInfo(RNETClauseInfoVO param) throws Exception;
	
	/** 상품 상세 UI > 상품 이미지 조회  **/
	public List<RNGDImgVO> srchGDImgList(RNGDImgVO param) throws Exception;

	
	/** 상품 상세 UI >  행사 상품 공통 사항 조회 **/
	public List<RNGDSchdVO> srchGDCommSchdList(RNGDSchdVO param) throws Exception;

	/** 상품 상세 UI > 행사 상품 일정표 조회  **/
	public List<RNGDSchdVO> srchGDSchdList(RNGDSchdVO param) throws Exception;
	
	/** 상품 상세 UI > 상품평 리스트  **/
	public List<RNReviewVO> srchReviewList(RNReviewVO param) throws Exception;
	
	/** 상품 상세 UI > 호텔 리스트  **/
	public List<RNHotelVO> srchHotelList(RNHotelVO param) throws Exception;	

	/** 상품 상세 UI > 일정표 상세 조회 **/
	public RNGDSchdVO srchGDSchdDetail(RNGDSchdVO param) throws Exception;
	
	/** 상품 상세 UI > 시차/환율 정보 조회  **/
	public List<RNTimeDifferCurrencyVO> srchTimeDifferCurrencyListSrch(RNTimeDifferCurrencyVO param) throws Exception;
	
	/** 상품 상세 UI > 날씨 정보 조회  **/
	public List<RNWeatherVO> srchWeatherListSrch(RNWeatherVO param) throws Exception;	

	/** 상품 상세 UI > 다른 이용항공사 조회   **/
	public List<ETMstOtherAirLineVO> srchETMstOtherAirLine(ETMstOtherAirLineVO param) throws Exception;	
	
	/** 임직원 가격 표시를 위해 임원 등급 조회 **/
	public String selectCustGrade(String custCd) throws Exception;
	
}
