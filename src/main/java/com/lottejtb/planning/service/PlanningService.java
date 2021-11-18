package com.lottejtb.planning.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;


public interface PlanningService {
	
	
	//기획전 전체 목록 조회
	public List srchAllPlanList(PlanningVO vo) throws SQLException;
	
	//기횝전 선택목록 조회
	public List selPlanList(PlanningVO vo) throws SQLException;
	
	//조회수 증가
	public void planningCnt(PlanningVO vo) throws SQLException;
	public int getplanCnt(PlanningVO vo) throws SQLException;

	//기획전 상세조회
	public List<PlanningVO> srchDetailPlanList(PlanningVO vo) throws SQLException;

	//기획전 삼품행사요금, 날짜정보조회
	public List<PlanningVO> getplanSubInfo(PlanningVO vo) throws SQLException;

	//기획전 추가 정보조회
	public  List<PlanningVO> searchRNDiPlanAddInfo(PlanningVO vo) throws SQLException;

	public int minCharge(PlanningVO vo) throws SQLException;

	public List<PlanningVO> planImage(PlanningVO vo) throws SQLException;

	public List setDetailPlanList(PlanningVO vo) throws SQLException;
	
	//기획전 탭 목록
	public List getPlanTabList(PlanningVO vo) throws SQLException;

	public int getTotalCnt(PlanningVO vo) throws SQLException;
}
