package com.lottejtb.customer.service;

import java.util.HashMap;
import java.util.List;

public interface QnaService {

	/**
	 * 묻고답하기 목록
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List selectQnaList(QnaVO vo) throws Exception;	

	/**
	 * 묻고답하기 전체카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int selectQnaListCount(QnaVO vo) throws Exception;
	
	/**
	 * 묻고답하기 상세
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public QnaVO selectQnaDetail(QnaVO vo) throws Exception;	
	
	/**
	 * 묻고답하기 코드 가져오기
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List selectQnaCode(HashMap<String, Object> commandMap) throws Exception;
	
	/**
	 * 묻고답하기 코드 가져오기
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public void insertConsultQna(QnaVO vo) throws Exception;

}
