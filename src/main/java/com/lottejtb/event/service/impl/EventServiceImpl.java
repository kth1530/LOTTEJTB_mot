package com.lottejtb.event.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lottejtb.event.service.EventService;
import com.lottejtb.event.service.EventVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
//#################################################################
//-----------------------------------------------------------------
//파일명 : EventServiceImpl.java
//설 명   : Event service   
//작성자 : kkm 
//작성일자 : 2016.10.28
//
//변경이력 
//-----------------------------------------------------------------
//2016.10.28 
//
//-----------------------------------------------------------------
//#################################################################
**/

@Service("EventService")
@SuppressWarnings("unchecked")
public class EventServiceImpl extends EgovAbstractServiceImpl implements EventService {

	@Resource(name="EventDAO")
	protected EventDAO eventDAO;

	@Override
	public List srchEventList(EventVO vo) throws Exception {
		return eventDAO.srchEventList(vo);
	}
	
	@Override
	public List srchEventingList(EventVO vo) throws Exception{
		return eventDAO.srchEventingList(vo);
	}
	
	@Override
	public int srchEventingCnt(EventVO vo) throws Exception{
		return eventDAO.srchEventingCnt(vo);
	}
	
	@Override
	public List srchEventEndList(EventVO vo) throws Exception{
		return eventDAO.srchEventEndList(vo);
	}
	
	@Override 
	public int srchEventEndCnt(EventVO vo) throws Exception{
		return eventDAO.srchEventEndCnt(vo);
	}

	@Override
	public List winnerList(EventVO vo) throws Exception {
		return eventDAO.winnerList(vo);
	}
	
	@Override
	public int winnerCnt(EventVO vo) throws Exception {
		return eventDAO.winnerCnt(vo);
	}

	@Override
	public int eventCnt(EventVO vo) throws Exception {
		return eventDAO.eventCnt(vo);
	}

	@Override
	public ArrayList<EventVO> templateSrch(EventVO vo) throws Exception {
		return eventDAO.templateSrch(vo);
	}
	
	@Override
	public List commentList(EventVO vo) throws Exception{
		return eventDAO.commentList(vo);
	}
	
	@Override
	public int commentCnt(EventVO vo) throws Exception{
		return eventDAO.commentCnt(vo);
	}

	@Override
	public List eventListDetail(EventVO vo) throws Exception {
		return eventDAO.eventListDetail(vo);
	}

	@Override
	public int getCnt(EventVO vo) throws Exception {
		return eventDAO.getCnt(vo);
	}
	
	@Override
	public void insertComment(EventVO vo) throws Exception{
		eventDAO.insertComment(vo);
	}
	
	@Override
	public int applyCountCheck(EventVO vo) throws Exception{
		return eventDAO.applyCountCheck(vo);
	}
	
	@Override
	public int attendApplyCountCheck(EventVO vo) throws Exception {
		return eventDAO.attendApplyCountCheck(vo);
	}
	
	@Override
	public void deleteComment(EventVO vo) throws Exception{
		eventDAO.deleteComment(vo);
	}
	
	@Override
	public void insertEventEntry (EventVO vo) throws Exception{
		eventDAO.insertEventEntry(vo);
	}
	
	@Override
	public void insertEventQuiz (EventVO vo) throws Exception{
		eventDAO.insertEventQuiz(vo);
	}

	@Override
	public List voteContentList(EventVO vo) throws Exception {
		return eventDAO.voteContentList(vo);
	}

	@Override
	public void insertEventAttend(EventVO vo) throws Exception {
		eventDAO.insertEventAttend(vo);
		
	}
	
	@Override
	public void insertEventVote(EventVO vo) throws Exception {
		eventDAO.insertEventVote(vo);
		
	}

	@Override
	public List attendChkList(EventVO vo) throws Exception {
		return eventDAO.attendChkList(vo);
	}

}
