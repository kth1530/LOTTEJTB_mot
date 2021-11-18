package com.lottejtb.event.service;

import java.util.ArrayList;
import java.util.List;


public interface EventService {
    
	//이벤트목로조회
	public List srchEventList(EventVO vo) throws Exception;
	
	//이벤트목록조회(진행중)
	public List srchEventingList(EventVO vo) throws Exception;
	
	//이벤트목록 갯수(진행중)
	public int srchEventingCnt(EventVO vo) throws Exception;
	
	//이벤트목로조회(종료)
	public List srchEventEndList(EventVO vo) throws Exception;
	
	//이벤트목로 갯수(종료)
	public int srchEventEndCnt(EventVO vo) throws Exception;
	
	//당첨자 목록조회
	public List winnerList(EventVO vo) throws Exception;
	
	//당첨자 목록 갯수
	public int winnerCnt(EventVO vo) throws Exception;
	
	public int eventCnt(EventVO vo) throws Exception;
	
	public ArrayList<EventVO> templateSrch(EventVO vo) throws Exception;
	
	public List commentList(EventVO vo) throws Exception;
	
	public int commentCnt(EventVO vo) throws Exception;
	
	//투표내용조회
	public List voteContentList(EventVO vo) throws Exception;

	
	//이벤트 상세조회
	public List eventListDetail(EventVO vo) throws Exception;

	public int getCnt(EventVO vo) throws Exception;
	
	public void insertComment(EventVO vo) throws Exception;
	
	public int applyCountCheck(EventVO vo) throws Exception;
	
	public int attendApplyCountCheck(EventVO vo) throws Exception;
	
	public void deleteComment(EventVO vo) throws Exception;
	
	public void insertEventEntry (EventVO vo) throws Exception;
	
	public void insertEventQuiz (EventVO vo) throws Exception;

	public void insertEventVote(EventVO vo) throws Exception;
	
	public void insertEventAttend(EventVO vo) throws Exception;

	public List attendChkList(EventVO vo) throws Exception;
	
}
