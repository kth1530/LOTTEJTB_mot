package com.lottejtb.goods.rn.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lottejtb.framework.common.CommAbstractDAO;
import com.lottejtb.goods.rn.service.ETMstOtherAirLineVO;
import com.lottejtb.goods.rn.service.RNETClauseInfoVO;
import com.lottejtb.goods.rn.service.RNETMstVO;
import com.lottejtb.goods.rn.service.RNGDImgVO;
import com.lottejtb.goods.rn.service.RNGDMstVO;
import com.lottejtb.goods.rn.service.RNGDSchdVO;
import com.lottejtb.goods.rn.service.RNGDTagsVO;
import com.lottejtb.goods.rn.service.RNHotelVO;
import com.lottejtb.goods.rn.service.RNReviewVO;
import com.lottejtb.goods.rn.service.RNTimeDifferCurrencyVO;
import com.lottejtb.goods.rn.service.RNWeatherVO;

/**
* 클래스명    :  상품 상세 화면 관련 DAO 
* @ClassDesc  : 상품 상세 화면 관련 DAO 
* @FileName   : RNGoodsDetDAO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2017.02.03 /  / 최초작성
*/
@Repository("RNGoodsDAO")
public class RNGoodsDAO extends CommAbstractDAO {

	public RNGoodsDAO() {
		// TODO Auto-generated constructor stub
	}

	/** 상품 상세 UI > 상품 마스터 정보 조회 **/
	public RNGDMstVO srchGDMst(RNGDMstVO param) throws Exception {
		return (RNGDMstVO) select("RNGoodsDAO.selectGDMstSrch",param);
	}
	
	/** 상품 상세 UI >  행사 상품 정보 조회 **/
	public RNETMstVO srchETMst(RNETMstVO param) throws Exception {
		return (RNETMstVO) select("RNGoodsDAO.selectETMstSrch",param);
	}

	/** 예약 상세 UI >  행사 상품 정보 조회 **/
	public RNETMstVO srchETMst2(RNETMstVO param) throws Exception {
		return (RNETMstVO) select("RNGoodsDAO.selectETMstSrch2",param);
	}
	
	/** 상품 상세 UI >  행사 상품 태그 정보 조회  **/
	public RNGDTagsVO srchGDTags(RNGDTagsVO param) throws Exception {
		return (RNGDTagsVO) select("RNGoodsDAO.selectGDTagsSrch",param);
	}
	
	/** 상품 상세 UI > 상품 이미지 조회  **/
	public List srchGDImgList(RNGDImgVO param) throws Exception {
		return (List) list("RNGoodsDAO.selectGDImgListSrch", param);
		
	}

	/** 상품 상세 UI >  표준약관/특별약관/국내약관  **/
	public RNETClauseInfoVO srchETClauseInfo(RNETClauseInfoVO param) throws Exception {
		return (RNETClauseInfoVO) select("RNGoodsDAO.selectETClauseInfoSrch",param);
	}
	
	/** 상품 상세 UI >  행사 상품 공통 사항 조회 **/
	public List srchGDCommSchdList(RNGDSchdVO param) throws Exception {
		return list("RNGoodsDAO.selectGDCommSchdListSrch", param);
	}

	/** 상품 상세 UI > 행사 상품 일정표 조회  **/
	public List srchGDSchdList(RNGDSchdVO param) throws Exception {
		return (List) list("RNGoodsDAO.selectGDSchdListSrch", param);
	}
	
	/** 상품 상세 UI > 상품평 리스트 조회 **/
	public List srchReviewList(RNReviewVO param) throws Exception {
		return (List) list("RNGoodsDAO.selectReviewListSrch", param);		
	}
	
	/** 상품 상세 UI > 호텔 리스트  조회 **/
	public List<RNHotelVO> srchHotelList(RNHotelVO param) throws Exception {
		return (List) list("RNGoodsDAO.selectHotelListSrch", param);	
	}
	
	/** 상품 상세 UI > 일정표 상세 조회 **/
	public RNGDSchdVO srchGDSchdDetail(RNGDSchdVO param) throws Exception {
		return (RNGDSchdVO) select("RNGoodsDAO.srchGDSchdDetailSrch",param);
	}
	
	/** 상품 상세 UI > 시차/환율 정보 조회 **/
	public List<RNTimeDifferCurrencyVO> srchTimeDifferCurrencyListSrch(RNTimeDifferCurrencyVO param) throws Exception {
		// TODO Auto-generated method stub
		return (List) list("RNGoodsDAO.selectTimeDifferCurrencyListSrch", param);	
	}
	
	/** 상품 상세 UI > 날씨 정보 조회 **/
	public List<RNWeatherVO> srchWeatherListSrch(RNWeatherVO param) throws Exception {
		// TODO Auto-generated method stub
		return (List) list("RNGoodsDAO.selectWeatherListSrch", param);	
	}	
	
	/** 상품 상세 UI > 날씨 정보 조회 **/
	public List<ETMstOtherAirLineVO> srchETMstOtherAirLineSrch(ETMstOtherAirLineVO param) throws Exception {
		// TODO Auto-generated method stub
		return (List) list("RNGoodsDAO.selectETMstOtherAirLineSrch", param);	
	}	
	
	public String selectCustGrade(String custCd) throws Exception {
		return (String) select("RNGoodsDAO.selectCustGrade", custCd);
	}
}
