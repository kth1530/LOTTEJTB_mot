package com.lottejtb.main.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface MainService{
    
    MainVO  selecDetail(MainVO vo) throws Exception;
    List    selectList(MainVO vo)  throws Exception;
    
    /**
	 * 메뉴가져오기
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public List<MenuVO> menuList(HashMap<String, Object> parameter) throws Exception;	
	
	/**
	 * 디바이스 정보 존재여부 판단
	 * @param MainVO
	 * @return
	 * @throws Exception
	 */
	public int selectDeviceInfoCnt(MainVO vo) throws Exception;
	
	/**
	 * 디바이스 정보 저장하기
	 * @param MainVO
	 * @return
	 * @throws Exception
	 */
	public void insertDeviceInfo(MainVO vo) throws Exception;
	
	/**
	 * 디바이스 정보 수정하기
	 * @param MainVO
	 * @return
	 * @throws Exception
	 */
	public void updateDeviceInfo(MainVO vo) throws Exception;
	
	/**
	 * 배너 가져오기
	 * @param PromotionVO
	 * @return
	 * @throws Exception
	 */
	public List<PromoVO> bannerList(PromoVO vo) throws Exception;
	
	/**
	 * 코드상세 가져오기
	 * @param CodeDetailVO
	 * @return
	 * @throws Exception
	 */
	public List<CodeDetailVO> codeDetailList(CodeDetailVO vo) throws Exception;
	
	/**
	 * bastHoliday 상세 리스트
	 * @param PromotionVO
	 * @return
	 * @throws Exception
	 */
	public List<PromoVO> bestDetailList(PromoVO vo) throws Exception;
	
	/**
	 * 매뉴맵 리스트
	 * @param
	 * @return
	 * @throws Exception
	 */
	public List menuMapList(MenuVO vo) throws Exception;
	
	/**
	 * 실시간 랭킹 리스트
	 * @param
	 * @return
	 * @throws Exception
	 */
	public List realRanking(RankVO vo) throws Exception;
	
	/**
	 * 핫한 여행가기
	 * @param
	 * @return
	 * @throws Exception
	 */
	public List selectHotGoods(HashMap<String, Object> parameter) throws Exception;
	
	/**
	 * 광고팝업
	 * @param
	 * @return
	 * @throws Exception
	 */
	public Object selectAdPop(HashMap<String, Object> parameter) throws Exception;
	
	/**
	 * 타임특가
	 * @param
	 * @return
	 * @throws Exception
	 */
	public List selectTimeGoods(HashMap<String, Object> parameter) throws Exception;
	
	/**
	 * 히트수 증가
	 * @param
	 * @return
	 * @throws Exception
	 */
	public void updateHitCount(HashMap<String, Object> parameter) throws Exception;
}