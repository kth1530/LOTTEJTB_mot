package com.lottejtb.goods.rn.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.lottejtb.goods.rn.service.ETMstOtherAirLineVO;
import com.lottejtb.goods.rn.service.RNETClauseInfoVO;
import com.lottejtb.goods.rn.service.RNETMstVO;
import com.lottejtb.goods.rn.service.RNGDCommSchdVO;
import com.lottejtb.goods.rn.service.RNGDImgVO;
import com.lottejtb.goods.rn.service.RNGDMstVO;
import com.lottejtb.goods.rn.service.RNGDSchdVO;
import com.lottejtb.goods.rn.service.RNGDTagsVO;
import com.lottejtb.goods.rn.service.RNGoodsService;
import com.lottejtb.goods.rn.service.RNHotelVO;
import com.lottejtb.goods.rn.service.RNReviewVO;
import com.lottejtb.goods.rn.service.RNTimeDifferCurrencyVO;
import com.lottejtb.goods.rn.service.RNWeatherVO;

/**
* 클래스명    :  상품 상세 화면 관련 서비스 정의 인터페이스를 구현한 클래스 
* @ClassDesc  : 상품 상세 화면 관련 서비스 정의 인터페이스를 구현한 클래스  
* @FileName   : RNGoodsDetServiceImpl.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2017.02.03 /  / 최초작성
*/
@Service("RNGoodsService")
@SuppressWarnings("unchecked")

public class RNGoodsServiceImpl implements RNGoodsService {
	private Logger logger = Logger.getLogger(this.getClass());
	
    @Resource(name="RNGoodsDAO")
    private RNGoodsDAO goodsDAO;

	
	public RNGoodsServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	/** 상품 상세 UI > 상품 마스터 정보 조회 **/
	public RNGDMstVO srchGDMst(RNGDMstVO param) throws Exception {
		return goodsDAO.srchGDMst(param);
	}
	
	/** 상품 상세 UI >  행사 상품 정보 조회 **/
	public RNETMstVO srchETMst(RNETMstVO param) throws Exception {
		return goodsDAO.srchETMst(param);
	}

	/** 상품 상세 UI >  행사 상품 태그 정보 조회  **/
	public RNGDTagsVO srchGDTags(RNGDTagsVO param) throws Exception {
		return goodsDAO.srchGDTags(param);
	}
	
	/** 상품 상세 UI > 상품 이미지 조회  **/
	public List<RNGDImgVO> srchGDImgList(RNGDImgVO param) throws Exception {
		return goodsDAO.srchGDImgList(param);
	}
	
	/** 상품 상세 UI >  표준약관/특별약관/국내약관  **/
	public RNETClauseInfoVO srchETClauseInfo(RNETClauseInfoVO param) throws Exception {
		return goodsDAO.srchETClauseInfo(param);
	}
	
	/** 상품 상세 UI >  행사 상품 공통 사항 조회 **/
	public List<RNGDSchdVO> srchGDCommSchdList(RNGDSchdVO param) throws Exception {
		return goodsDAO.srchGDCommSchdList(param);
	}

	/** 상품 상세 UI > 행사 상품 일정표 조회  **/
	public List<RNGDSchdVO> srchGDSchdList(RNGDSchdVO param) throws Exception {
		return goodsDAO.srchGDSchdList(param);
	}
	
	/** 상품 상세 UI > 상품평 리스트  **/
	public List<RNReviewVO> srchReviewList(RNReviewVO param) throws Exception {
		return goodsDAO.srchReviewList(param);
	}
	
	/** 상품 상세 UI > 호텔 리스트  **/
	public List<RNHotelVO> srchHotelList(RNHotelVO param) throws Exception {
		return goodsDAO.srchHotelList(param);
	}
	
	/** 상품 상세 UI > 일정표 상세 조회 **/
	public RNGDSchdVO srchGDSchdDetail(RNGDSchdVO param) throws Exception {
		return goodsDAO.srchGDSchdDetail(param);
	}
	
	/** 상품 상세 UI > 시차/환율 정보 조회 **/
	@Override
	public List<RNTimeDifferCurrencyVO> srchTimeDifferCurrencyListSrch(RNTimeDifferCurrencyVO param)
			throws Exception {
		// TODO Auto-generated method stub
		return goodsDAO.srchTimeDifferCurrencyListSrch(param);
	}
	
	/** 상품 상세 UI > 날씨 정보 조회 **/
	@Override
	public List<RNWeatherVO> srchWeatherListSrch(RNWeatherVO param) throws Exception {
		// TODO Auto-generated method stub
		return goodsDAO.srchWeatherListSrch(param);
	}

	@Override
	public RNETMstVO srchETMst2(RNETMstVO param) throws Exception {
		// TODO Auto-generated method stub
		return goodsDAO.srchETMst2(param);
	}

	@Override
	public List<ETMstOtherAirLineVO> srchETMstOtherAirLine(ETMstOtherAirLineVO param) throws Exception {
		// TODO Auto-generated method stub
		return goodsDAO.srchETMstOtherAirLineSrch(param);
	}
	
	/** 임직원 가격 표시를 위해 임원 등급 조회 **/
	public String selectCustGrade(String custCd) throws Exception {
		return goodsDAO.selectCustGrade(custCd);
	}
	
}
