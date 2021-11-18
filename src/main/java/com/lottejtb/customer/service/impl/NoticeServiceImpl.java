package com.lottejtb.customer.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lottejtb.customer.service.NoticeService;
import com.lottejtb.customer.service.NoticeVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("NoticeService")
public class NoticeServiceImpl  extends EgovAbstractServiceImpl implements NoticeService{

    @Resource(name="NoticeDAO")
    private NoticeDAO noticeDAO;
	
	/**
	 * 공지사항 목록
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List selectNoticeList(NoticeVO vo) throws Exception{
		return noticeDAO.selectNoticeList(vo);
	}

	/**
	 * 공지사항 전체카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int selectNoticeListCount(NoticeVO vo) throws Exception{
		return noticeDAO.selectNoticeListCount(vo);
	}
	

	/**
	 * 공지사항 상세 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public NoticeVO selectNoticeDetail(NoticeVO vo) throws Exception{
		return noticeDAO.selectNoticeDetail(vo);
	}

	
	/**
	 * 공지사항 조회 카운트 업데이트
	 * @param vo
	 * @throws Exception
	 */
	public void updateNoticeCount(NoticeVO vo) throws Exception{
		noticeDAO.updateNoticeCount(vo);
	}

}
