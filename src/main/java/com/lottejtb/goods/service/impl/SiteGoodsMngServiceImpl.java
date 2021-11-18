package com.lottejtb.goods.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

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
import com.lottejtb.goods.service.SiteGoodsMngService;


/**
* 클래스명    :  상품 관련 서비스  구현  클래스 
* @ClassDesc  : 상품 관련 서비스  구현  클래스 
* @FileName   : SiteGoodsMngServiceImpl.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.02 /  / 최초작성
*/

@Service("GoodsService")
@SuppressWarnings("unchecked")
public class SiteGoodsMngServiceImpl implements SiteGoodsMngService {
	private Logger logger = Logger.getLogger(this.getClass());
	
    @Resource(name="GoodsDAO")
    private GoodsMngDAO goodsDAO;

	
	/** 상품 UI > 공통 > 사이트 카테고리 조회 **/
	public List srchSiteCtgSrch(GoodsCtgVO param) throws Exception {
		return goodsDAO.srchSiteCtgSrch(param);
	}

	/** 상품 UI > 공통 > 사이트 카테고리 조회 **/
	public List srchSiteCtgSrch02(GoodsCtgVO param) throws Exception {
		return goodsDAO.srchSiteCtgSrch02(param);
	}
	
	/** 상품 UI > 공통 > 사이트 DETPTH별 카테고리 조회 **/
	public List srchSiteCtgByDepthSrch(GoodsCtgVO param) throws Exception {
		return goodsDAO.srchSiteCtgByDepthSrch(param);
	}
	
	/** 상품 리스트 UI > 사이트 지역별 상품 리스트 조회 **/
	public List<Map<String, Object>> srchSiteGoodsSrchsByAreaList(GoodsVO param) throws Exception {
		return goodsDAO.srchSiteGoodsSrchsByAreaList(param);
	}
	
	/** 상품 리스트 UI > 사이트 지역별 상품 리스트 조회 (카운터) **/
	public int srchSiteGoodsSrchsByAreaListCount(GoodsVO param) throws Exception {
		return goodsDAO.srchSiteGoodsSrchsByAreaListCount(param);
	}
	
	/** 상품 마스터 UI > 사이트 상품 종류 정보 조회 **/
	public GoodsMstVO srchSiteGoodsCtgSrch(GoodsMstVO param) throws Exception {
		return goodsDAO.srchSiteGoodsCtgSrch(param);
	}
	/** 상품 마스터 UI > 사이트 상품 정보 조회 **/
	public GoodsVO srchSiteGoodsInfo(GoodsVO param) throws Exception {
		return goodsDAO.srchSiteGoodsInfo(param);
	}

	/** 상품 마스터 UI > 행사 마스터 일정 조회 **/
	public EventMstVO srchSiteGoodsEvntDays(EventMstVO param) throws Exception {
		return goodsDAO.srchSiteGoodsEvntDays(param);
	}
	
	/** 상품 마스터 UI > 행사 마스터 리스트 조회 **/
	public List srchSiteGoodsEvntList(EventListDTO param) throws Exception {
		return goodsDAO.srchSiteGoodsEvntList(param);
	}
	
	/** 상품 마스터 UI > 행사 마스터 리스트 조회 **/
	public List srchSiteGoodsEvntListCanReserve(EventListDTO param) throws Exception {
		return goodsDAO.srchSiteGoodsEvntListCanReserve(param);
	}
	
	/** 상품 마스터 UI > 행사 마스터 리스트 카운트 조회 **/
	public int srchSiteGoodsEvntListCount(EventListDTO param) throws Exception {
		return goodsDAO.srchSiteGoodsEvntListCount(param);
	}
	
	/** <!--  상품 상세 UI > 사이트 행사 정보 리스트 조회   --> **/
	public List srchEventMstList(EventMstListVO param) throws Exception {
		return goodsDAO.srchEventMstList(param);
	}

	/** <!--  상품 상세 UI > 사이트 행사 정보 리스트 카운트 조회   --> **/
	public int srchEventMstListCount(EventMstListVO param) throws Exception {
		return goodsDAO.srchEventMstListCount(param);
	}

	
	/** <!--  상품 상세 UI > 사이트 상품 이미지  조회  --> **/
	public List srchGoodsImgList(GoodsImgVO param) throws Exception {
		return goodsDAO.srchGoodsImgList(param);
	}
	
	/** <!-- 상품 상세 UI >  행사공통사항 일정조회 체크사항   조회  --> **/
	public List srchEventCommSchdList(EventCommSchdVO param) throws Exception {
		return goodsDAO.srchEventCommSchdList(param);
	}
	
	/** <!-- 상품 상세 UI >  상품평 리스트 조회   --> **/
	public List srchGoodsReviewList(GoodsEvalVO param) throws Exception {
		return goodsDAO.srchGoodsReviewList(param);
	}
	
	/** <!-- 상품 상세 UI >  상품평 리스트 카운트 조회   --> **/
	public int srchGoodsReviewListCount(GoodsEvalVO param) throws Exception {
		return goodsDAO.srchGoodsReviewListCount(param);
	}
	
	/** <!-- 상품 상세 UI >  상세일정 그룹 전체조회 정보 조회    --> **/
	public List srchEventGroupAllSchdList(EventGroupAllSchdVO param) throws Exception {
		return goodsDAO.srchEventGroupAllSchdList(param);
	}
	
	/** <!-- 상품 상세 UI >  상세일정 그룹 전체조회 정보 (카운트) 조회   --> **/
	public int srchEventGroupAllSchdListCount(EventGroupAllSchdVO param) throws Exception {
		return goodsDAO.srchEventGroupAllSchdListCount(param);
	}
	
	/** <!-- 상품 상세 UI > 일정표  (호텔 정보) 조회   --> **/
	public List  srchHotelInfo(HotelInfoVO param) throws Exception {
		return goodsDAO.srchHotelInfo(param);
	}
	
	/** <!-- 상품 상세 UI > 일정표  (지역 정보) 조회   --> **/
	public List  srchAreaInfo(AreaInfoVO param) throws Exception {
		return goodsDAO.srchAreaInfo(param);
	}
	/** <!-- 상품 상세 UI >  출발 비행기의 SECT_CD 조회 쿼리 >> 행사 스케쥴 중 식사 정보 조회시 필요함.     --> **/
	public GoodsSchdClassVO srchGoodsSchdClass(GoodsSchdClassVO param) throws Exception {
		return goodsDAO.srchGoodsSchdClass(param);
	}
	/** <!-- 상품 카테고리 UI > 상품 카테고리 정보 조회 --> **/
	public List srchCategoryList(HashMap<String, Object> param) throws Exception {
		return goodsDAO.srchCategoryList(param);
	}
	
	/** <!--  상품 상세 UI >  상담 문의 신청 등록   --> **/
	public void saveConsult(ConsultVO param) throws Exception {
		goodsDAO.insertConsult(param);
	}
	
	/** <!-- 상품 상세 UI > 상품평 최대 숫자 조회 --> **/
	public int selectMaxEvalNum(HashMap param) throws Exception {
		return goodsDAO.selectMaxEvalNum(param);
	}
	
	/** <!-- 상품 상세 UI > 상품평 등록  --> **/
	public void saveGoodsEval(GoodsEvalVO param) throws Exception {
		goodsDAO.insertGoodsEval(param);
	}
	
	/** <!-- 상품 상세 UI > 상품평 점수 등록   --> **/
	public void saveGoodsEvalPoint(GoodsEvalPointVO param) throws Exception {
		goodsDAO.insertGoodsEvalPoint(param);
	}
	
	/** <!-- 상품 상세 UI > 일정표 메일 발송 등록   --> **/
	public void saveEmsMailSend(EmsMailSendVO param) throws Exception {
		goodsDAO.insertEmsMailSend(param);
	}
		
	/** <!-- 상품 상세 UI > 상담 시퀀스  조회   --> **/
	public String srchConsultSeq(ConsultVO param) throws Exception {
		return goodsDAO.selectConsultSeq(param);
	}	
	
	/** <!-- 상품 마스터 UI >  내가 남긴 해당 상품에 대한 상품평 카운터 조회  --> **/
	public int srchMyReviewCount(GoodsEvalVO param) throws Exception {
		return goodsDAO.selectMyReviewCount(param);
	}
	
	/** 상품 UI > 공통 > 사이트 DETPTH별 카테고리 조회 **/
	public List srchSiteCtgByDepthSrch2(GoodsCtgVO param) throws Exception {
		return goodsDAO.srchSiteCtgByDepthSrch2(param);
	}
	
	/** <!-- 상품 마스터 UI > CTG_SEQ 가져오기**/
	public GoodsMstVO getCtgCode(HashMap<String, Object> parameter) throws Exception{
		return goodsDAO.getCtgCode(parameter);
	}
}
