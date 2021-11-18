package com.lottejtb.customer.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.lottejtb.customer.service.QnaVO;
import com.lottejtb.framework.common.CommAbstractDAO;

@Repository("QnaDAO")
public class QnaDAO extends CommAbstractDAO{

	/**
	 * 묻고답하기 목록
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List selectQnaList(QnaVO vo) throws Exception{
		return list("QnaDAO.selectQnaList",vo);
	}

	/**
	 * 묻고답하기 전체카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int selectQnaListCount(QnaVO vo) throws Exception{
		return (Integer)select("QnaDAO.selectQnaListCount",vo);
	}


	/**
	 * 묻고답하기 목록
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public QnaVO selectQnaDetail(QnaVO vo) throws Exception{
		return (QnaVO) select("QnaDAO.selectQnaDetail",vo);
	}
	
	/**
	 * 묻고답하기 코드 가져오기
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List selectQnaCode(HashMap<String, Object> commandMap) throws Exception{
		return list("QnaDAO.selectQnaCode",commandMap);
	}
	
	/**
	 * 묻고답하기 등록하기
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public void insertConsultQna(QnaVO vo) throws Exception{
		insert("QnaDAO.insertConsultQna",vo);
	}
}

