package com.lottejtb.customer.service;

import java.util.List;

public interface NoticeService {

	/**
	 * 공지사항 목록
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List selectNoticeList(NoticeVO vo) throws Exception;	

	/**
	 * 공지사항 전체카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int selectNoticeListCount(NoticeVO vo) throws Exception;
	

	/**
	 * 공지사항 상세 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public NoticeVO selectNoticeDetail(NoticeVO vo) throws Exception;

	
	/**
	 * 공지사항 조회 카운트 업데이트
	 * @param vo
	 * @throws Exception
	 */
	public void updateNoticeCount(NoticeVO vo) throws Exception;
}
