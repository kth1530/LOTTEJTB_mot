package com.lottejtb.customer.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lottejtb.customer.service.QnaService;
import com.lottejtb.customer.service.QnaVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("QnaService")
public class QnaServiceImpl  extends EgovAbstractServiceImpl implements QnaService{

    @Resource(name="QnaDAO")
    private QnaDAO qnaDAO;
	
	/**
	 * 묻고답하기 목록
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List selectQnaList(QnaVO vo) throws Exception{
		return qnaDAO.selectQnaList(vo);
	}

	/**
	 * 묻고답하기 전체카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int selectQnaListCount(QnaVO vo) throws Exception{
		return qnaDAO.selectQnaListCount(vo);
	}

	/**
	 * 묻고답하기 상세
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public QnaVO selectQnaDetail(QnaVO vo) throws Exception {
		return qnaDAO.selectQnaDetail(vo);
	}
	
	/**
	 * 묻고답하기 코드 가져오기
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List selectQnaCode(HashMap<String, Object> commandMap) throws Exception{
		return qnaDAO.selectQnaCode(commandMap);
	}
	
	/**
	 * 묻고답하기 코드 가져오기
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public void insertConsultQna(QnaVO vo) throws Exception{
		qnaDAO.insertConsultQna(vo);
	}
}
