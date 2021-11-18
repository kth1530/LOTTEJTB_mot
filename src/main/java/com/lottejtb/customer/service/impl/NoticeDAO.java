package com.lottejtb.customer.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lottejtb.customer.service.FaqVO;
import com.lottejtb.customer.service.NoticeVO;
import com.lottejtb.framework.common.CommAbstractDAO;

@Repository("NoticeDAO")
public class NoticeDAO extends CommAbstractDAO{

	/**
	 * 공지사항 목록
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List selectNoticeList(NoticeVO vo) throws Exception{
		return list("NoticeDAO.selectNoticeList",vo);
	}

	/**
	 * 공지사항 전체카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int selectNoticeListCount(NoticeVO vo) throws Exception{
		return (Integer)select("NoticeDAO.selectNoticeListCount",vo);
	}

	/**
	 * 공지사항 상세 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public NoticeVO selectNoticeDetail(NoticeVO vo) throws Exception{
		return (NoticeVO)select("NoticeDAO.selectNoticeDetail",vo);
	}
	
	/**
	 * 공지사항 조회 카운트 업데이트
	 * @param vo
	 * @throws Exception
	 */
	public void updateNoticeCount(NoticeVO vo) throws Exception{
		update("NoticeDAO.updateNoticeCount", vo);
	}
	
}

