package com.lottejtb.goods.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.lottejtb.framework.common.CommAbstractDAO;
import com.lottejtb.goods.service.AreaInfoVO;
import com.lottejtb.goods.service.ConsultVO;
import com.lottejtb.goods.service.EmsMailSendVO;
import com.lottejtb.goods.service.EventCommSchdVO;
import com.lottejtb.goods.service.EventGroupAllSchdVO;
import com.lottejtb.goods.service.EventListDTO;
import com.lottejtb.goods.service.EventMstListVO;
import com.lottejtb.goods.service.EventMstVO;
import com.lottejtb.goods.service.GoodsCtgVO;
import com.lottejtb.goods.service.GoodsEvalPointVO;
import com.lottejtb.goods.service.GoodsEvalVO;
import com.lottejtb.goods.service.GoodsImgVO;
import com.lottejtb.goods.service.GoodsMstVO;
import com.lottejtb.goods.service.GoodsSchdClassVO;
import com.lottejtb.goods.service.GoodsVO;
import com.lottejtb.goods.service.HotelInfoVO;

@Repository("GoodsDAO")
public class GoodsMngDAO extends CommAbstractDAO {

	/** 상품 UI > 공통 > 사이트 카테고리 조회 **/
	public List srchSiteCtgSrch(GoodsCtgVO param) throws Exception {
		return list("GoodsDAO.selectSiteCtgSrch",param);
	}

	/** 상품 UI > 공통 > 사이트 카테고리 조회 **/
	public List srchSiteCtgSrch02(GoodsCtgVO param) throws Exception {
		return list("GoodsDAO.selectSiteCtgSrch02",param);
	}
	
	/** 상품 UI > 공통 > 사이트 DETPTH별 카테고리 조회 **/
	public List srchSiteCtgByDepthSrch(GoodsCtgVO param) throws Exception {
		return list("GoodsDAO.selectSiteCtgByDepthSrch",param);
	}
	
	/** 상품 UI > 공통 > 사이트 DETPTH별 카테고리 조회 **/
	public List srchSiteCtgByDepthSrch2(GoodsCtgVO param) throws Exception {
		return list("GoodsDAO.selectSiteCtgByDepthSrch2",param);
	}
	
	/** 상품 리스트 UI > 사이트 지역별 상품 리스트 조회 **/
	public List srchSiteGoodsSrchsByAreaList(GoodsVO param) throws Exception {
		return list("Goods.selectSiteGoodsSrchsByAreaList",param);
	}
	
	/** 상품 리스트 UI > 사이트 지역별 상품 리스트 조회 (카운터) **/
	public int srchSiteGoodsSrchsByAreaListCount(GoodsVO param) throws Exception {
		return (Integer)select("GoodsDAO.selectSiteGoodsSrchsByAreaListCount", param);
	}
	
	/** 상품 마스터 UI > 사이트 상품 종류 정보 조회 **/
	public GoodsMstVO srchSiteGoodsCtgSrch(GoodsMstVO param) throws Exception {
		return (GoodsMstVO) select("GoodsDAO.selectSiteGoodsCtgSrch",param);
	}
	/** 상품 마스터 UI > 사이트 상품 정보 조회 **/
	public GoodsVO srchSiteGoodsInfo(GoodsVO param) throws Exception {
		return (GoodsVO) select("GoodsDAO.selectSiteGoodsInfo",param);		
	}

	/** 상품 마스터 UI > 행사 마스터 일정 조회 **/
	public EventMstVO srchSiteGoodsEvntDays(EventMstVO param) throws Exception {
		return (EventMstVO) select("GoodsDAO.selectSiteGoodsEvntDays",param);		
	}
	
	/** 상품 마스터 UI > 행사 마스터 리스트 조회 **/
	public List srchSiteGoodsEvntList(EventListDTO param) throws Exception {
		return list("GoodsDAO.selectSiteGoodsEvntList",param);
	}
	
	/** 상품 마스터 UI > 예약 가능 상품 리스트 조회 **/
	public List srchSiteGoodsEvntListCanReserve(EventListDTO param) throws Exception {
		return list("GoodsDAO.selectSiteGoodsEvntListCanReserve",param);
	}
	
	/** 상품 마스터 UI > 행사 마스터 리스트 카운트 조회 **/
	public int srchSiteGoodsEvntListCount(EventListDTO param) throws Exception {
		return (Integer)select("GoodsDAO.selectSiteGoodsEvntListCount", param);
	}
	
	/** <!--  상품 상세 UI > 사이트 행사 정보 리스트 조회   --> **/
	public List srchEventMstList(EventMstListVO param) throws Exception {
		return list("GoodsDAO.selectEventMstList",param);
	}

	/** <!--  상품 상세 UI > 사이트 행사 정보 리스트 카운트 조회   --> **/
	public int srchEventMstListCount(EventMstListVO param) throws Exception {
		return (Integer)select("GoodsDAO.selectEventMstListCount", param);
	}
	
	
	/** <!--  상품 상세 UI > 사이트 상품 이미지  조회  --> **/
	public List srchGoodsImgList(GoodsImgVO param) throws Exception {
		return list("GoodsDAO.selectGoodsImgList",param);
	}
	
	/** <!-- 상품 상세 UI >  행사공통사항 일정조회 체크사항   조회  --> **/
	public List srchEventCommSchdList(EventCommSchdVO param) throws Exception {	
		return list("GoodsDAO.selectEventCommSchdList",param);
	}
	
	/** <!-- 상품 상세 UI >  상품평 리스트 조회   --> **/
	public List srchGoodsReviewList(GoodsEvalVO param) throws Exception {
		return list("GoodsDAO.selectGoodsReviewList",param);
	}
	
	/** <!-- 상품 상세 UI >  상품평 리스트 카운트 조회   --> **/
	public int srchGoodsReviewListCount(GoodsEvalVO param) throws Exception {
		return (Integer)select("GoodsDAO.selectGoodsReviewListCount", param);
	}
	
	/** <!-- 상품 상세 UI >  상세일정 그룹 전체조회 정보 조회    --> **/
	public List srchEventGroupAllSchdList(EventGroupAllSchdVO param) throws Exception {
		return list("GoodsDAO.selectEventGroupAllSchdList",param);
	}
	
	/** <!-- 상품 상세 UI >  상세일정 그룹 전체조회 정보 (카운트) 조회   --> **/
	public int srchEventGroupAllSchdListCount(EventGroupAllSchdVO param) throws Exception {
		return (Integer)select("GoodsDAO.selectEventGroupAllSchdListCount", param);
	}	
	
	/** <!-- 상품 상세 UI > 일정표  (호텔 정보) 조회   --> **/
	public List  srchHotelInfo(HotelInfoVO param) throws Exception {
		return  list("GoodsDAO.selectHotelInfo", param);
	}
	
	/** <!-- 상품 상세 UI > 일정표  (지역 정보) 조회   --> **/
	public List  srchAreaInfo(AreaInfoVO param) throws Exception {
		return list("GoodsDAO.selectAreaInfo", param);
	}
	
	/** <!-- 상품 상세 UI >  출발 비행기의 SECT_CD 조회 쿼리 >> 행사 스케쥴 중 식사 정보 조회시 필요함.     --> **/
	public GoodsSchdClassVO srchGoodsSchdClass(GoodsSchdClassVO param) throws Exception {
		return (GoodsSchdClassVO) select("GoodsDAO.selectGoodsSchdClass",param);
	}
	
	/** <!-- 상품 카테고리 UI > 상품 카테고리 정보 조회 --> **/
	public List srchCategoryList(HashMap<String, Object> param) throws Exception {
		return list("GoodsDAO.selectCategoryList", param);
	}
	
	/** <!--  상품 상세 UI >  상담 문의 신청 등록   --> **/
	public void insertConsult(ConsultVO param) throws Exception {
		insert("GoodsDAO.insertConsult", param); 
	}
	
	/** <!-- 상품 상세 UI > 상품평 최대 숫자 조회 --> **/
	public int selectMaxEvalNum(HashMap param) throws Exception {
		return (Integer) select("GoodsDAO.selectMaxEvalNum", param);
	}
	
	/** <!-- 상품 상세 UI > 상품평 등록  --> **/
	public void insertGoodsEval(GoodsEvalVO param) throws Exception {
		insert("GoodsDAO.insertGoodsEval", param);
	}
	
	/** <!-- 상품 상세 UI > 상품평 등록  --> **/
	public void insertGoodsEvalPoint(GoodsEvalPointVO param) throws Exception {
		insert("GoodsDAO.insertGoodsEvalPoint", param);
	}
	
	/** <!-- 상품 상세 UI > 일정표 메일 발송 등록  --> **/
	public void insertEmsMailSend(EmsMailSendVO param) throws Exception {
		insert("GoodsDAO.insertEmsMailSend", param);
	}
	
	/** <!-- 상품 상세 UI > 상담 시퀀스  조회   --> **/
	public String selectConsultSeq(ConsultVO param) throws Exception {
		return (String) select("GoodsDAO.selectConsultSeq", param);
	}
	
	/** <!-- 상품 마스터 UI >  내가 남긴 해당 상품에 대한 상품평 카운터 조회  --> **/
	public int selectMyReviewCount(GoodsEvalVO param) throws Exception {
		return (Integer) select("GoodsDAO.selectMyReviewCount", param);
	}
	
	/** <!-- 상품 마스터 UI > CTG_SEQ 가져오기**/
	public GoodsMstVO getCtgCode(HashMap<String, Object> parameter) throws Exception{
		return (GoodsMstVO) select("GoodsDAO.getCtgCode", parameter);
	}
}
