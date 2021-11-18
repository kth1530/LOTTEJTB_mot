package com.lottejtb.event.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.lottejtb.event.service.EventVO;
import com.lottejtb.framework.common.CommAbstractDAO;



@Repository("EventDAO")
@SuppressWarnings("unchecked")
public class EventDAO extends CommAbstractDAO {

	//이벤트 목록
	public List srchEventList(EventVO vo) throws SQLException {
		return list("EventDAO.srchEventList", vo);
	}
	
	//이벤트 목록(진행중)
	public List srchEventingList(EventVO vo) throws SQLException {
		return list("EventDAO.srchEventingList", vo);
	}
	
	//이벤트 갯수(진행중)
	public int srchEventingCnt(EventVO vo) throws SQLException {
		return (Integer) select("EventDAO.srchEventingCnt", vo);
	}
	
	//이벤트 목록(종료)
	public List srchEventEndList(EventVO vo) throws SQLException {
		return list("EventDAO.srchEventEndList", vo);
	}
	
	//이벤트 갯수(종료)
	public int srchEventEndCnt(EventVO vo) throws SQLException {
		return (Integer) select("EventDAO.srchEventEndCnt", vo);
	}

	public List winnerList(EventVO vo) throws SQLException {
		return list("EventDAO.winnerList", vo);
	}
	
	public int winnerCnt(EventVO vo) throws SQLException {
		return (Integer) select("EventDAO.winnerCnt", vo);
	}
	
	//이벤트 상세 cnt증가
	public int eventCnt(EventVO vo) throws SQLException { // TODO Auto-generated method stub
		return update("EventDAO.eventCnt",vo);
	}
	
    //이벤트 상세 
	public List eventListDetail(EventVO vo) throws SQLException {
		return list("EventDAO.ListDetail", vo);
	}

	//EVENT_SEQ에 해당하는 탬플릿의 상세정보를 조회	
	public ArrayList<EventVO> templateSrch(EventVO vo) throws SQLException {
		return (ArrayList<EventVO>) list("EventDAO.templateSrch", vo);
	}
	
	public List commentList(EventVO vo) throws SQLException {
		return list("EventDAO.commentList", vo);
	}
	
	public int commentCnt(EventVO vo) throws SQLException{
		return (Integer) select("EventDAO.commentCnt", vo);
	}
	
	public List voteContentList(EventVO vo) throws SQLException {
		return list("EventDAO.voteContentList", vo);
	}

	public int getCnt(EventVO vo) {
		return (Integer)select("EventDAO.getCnt",vo);	
	}
	
	public void insertComment(EventVO vo){
		insert("EventDAO.insertComment", vo);
	}
	
	public int applyCountCheck(EventVO vo){
		return (Integer)select("EventDAO.applyCountCheck", vo);
	}
	
	public int attendApplyCountCheck(EventVO vo){
		return (Integer)select("EventDAO.attendApplyCountCheck", vo);
	}

	public void deleteComment(EventVO vo){
		delete("EventDAO.deleteComment", vo);
	}
	
	public void insertEventEntry(EventVO vo){
		insert("EventDAO.insertEventEntry", vo);
	}
	
	public void insertEventQuiz(EventVO vo){
		insert("EventDAO.insertEventQuiz", vo);
	}
	
	public void insertEventAttend(EventVO vo) {
		insert("EventDAO.insertEventAttend", vo);
	}
	public void insertEventVote(EventVO vo){
		insert("EventDAO.insertEventVote", vo);
	}
	
	public List attendChkList(EventVO vo) throws SQLException {
		return list("EventDAO.attendChkList", vo);
	}
}
