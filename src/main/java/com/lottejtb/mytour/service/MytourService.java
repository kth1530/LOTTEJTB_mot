package com.lottejtb.mytour.service;

import java.util.HashMap;
import java.util.List;


public interface MytourService {
	/**
	 * 예약내역
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<MytourVO> myReservationList(MytourVO vo) throws Exception;
	
	/**
	 * 예약내역(날자조건)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<MytourVO> myReservationDateList(MytourVO vo) throws Exception;
	
	/**
	 * 취소예약내역
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<MytourVO> myCancelReservationList(MytourVO vo) throws Exception;
	
	/**
	 * 자유여행 예약내역
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public HashMap<String, List> freeReserve(MytourVO vo) throws Exception;
	
	/**
	 * 자유여행 취소예약내역
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public HashMap<String, List> freeCancelReserve(MytourVO vo) throws Exception;
	
	/**
	 * 찜상품 총갯수
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int choiceGoodsCount(MytourVO vo) throws Exception;
	
	/**
	 * 찜상품 이벤트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List choiceGoodsList(MytourVO vo) throws Exception;	
	
	/**
	 * 마이투어 이벤트 총갯수
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int myEventCount(MytourVO vo) throws Exception;
	
	/**
	 * 마이투어 이벤트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List myEventList(MytourVO vo) throws Exception;	
	
	/**
	 * 비회원 예약확인
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public HashMap<String, List> nonMemberResList(MytourVO vo) throws Exception;
	
	/**
	 * 롯데포인트 시퀀스 번호 가져오기
	 * @param
	 * @return
	 * @throws Exception
	 */
	public HashMap<String, Object> selectLottePointSeq() throws Exception;
	
	/**
	 * 롯데포인트 시퀀스 번호 저장하기
	 * @param
	 * @return
	 * @throws Exception
	 */
	public void insertLottePointSeq() throws Exception;
	
	/**
	 * 롯데포인트 시퀀스 번호 수정하기
	 * @param
	 * @return
	 * @throws Exception
	 */
	public void updateLottePointSeq() throws Exception;
	
	/**
	 * 선택된 찜내역 제거
	 * @param
	 * @return
	 * @throws Exception
	 */
	public void delectSelChoiceGoods(MytourVO vo) throws Exception;
	
	/**
	 * 전체 찜내역 제거
	 * @param
	 * @return
	 * @throws Exception
	 */
	public void delectAllChoiceGoods(MytourVO vo) throws Exception;
	
	public List srchAirCounselList(AirRsvCounselVO vo) throws Exception;
	
	public int srchAirCounselListCount(AirRsvCounselVO vo) throws Exception;
	
	public void saveAirCounsel(AirRsvCounselVO vo) throws Exception; 
	
	public List srchCounselQuesList(FaFitCounselQuesVO vo) throws Exception;
	
	public int srchCounselQuesListCount(FaFitCounselQuesVO vo) throws Exception;
	
	public void saveCounselQues(FaFitCounselQuesVO vo) throws Exception;
	
	public List srchCounselAnswList(FaFitCounselAnswVO vo) throws Exception;
	
	public List srchCounselAssortList(FaFitCounselAssortVO vo) throws Exception;
	
	public FaFitCounselAssortVO srchCounselAssort(FaFitCounselAssortVO vo) throws Exception;
	
	public List srchComCode(ComCodeVO param) throws Exception;
	
	
}
