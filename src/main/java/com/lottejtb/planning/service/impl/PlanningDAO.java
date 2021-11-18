package com.lottejtb.planning.service.impl;

import java.io.Reader;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.ibatis.common.util.PaginatedList;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapSession;
import com.ibatis.sqlmap.client.event.RowHandler;
import com.ibatis.sqlmap.engine.execution.BatchException;
import com.lottejtb.framework.common.CommAbstractDAO;
import com.lottejtb.planning.service.PlanningVO;

import oracle.jdbc.OracleConnection;

@Repository("PlanningDAO")
@SuppressWarnings("unchecked")

public class PlanningDAO extends CommAbstractDAO {

	public List srchAllPlanList(PlanningVO vo) {
		return list("PlanningDAO.srchAllPlanList", vo);
	}

	public List selPlanList(PlanningVO vo) {
		return list("PlanningDAO.selPlanList", vo);
	}

	public void planningCnt(PlanningVO vo) {
		update("PlanningDAO.planningCnt",vo);
	}

	public int getplanCnt(PlanningVO vo) {
		return (Integer)select("PlanningDAO.getplanCnt",vo);
	}

	public List<PlanningVO> srchDetailPlanList(PlanningVO vo) {
		return (List<PlanningVO>) list("PlanningDAO.srchDetailPlanList",vo);
	}

	public List<PlanningVO> getplanSubInfo(PlanningVO vo) {
		Properties properties = new Properties();
        properties.setProperty(OracleConnection.DCN_QUERY_CHANGE_NOTIFICATION, "true");
		return (List<PlanningVO>)list("PlanningDAO.getplanSubInfo",vo);
	}

	public  List<PlanningVO> searchRNDiPlanAddInfo(PlanningVO vo) {
		return (List<PlanningVO>) list("PlanningDAO.searchRNDiPlanAddInfo",vo);
	}

	public int minCharge(PlanningVO vo) {
		return (Integer)select("PlanningDAO.minCharge",vo);
	}

	public List<PlanningVO> getPlanImage(PlanningVO vo) {
		return (List<PlanningVO>) list("PlanningDAO.getPlanImage",vo);
	}

	public List setDetailPlanList(PlanningVO vo) {
		return list("PlanningDAO.setDetailPlanList", vo);
	}
	
	public List getPlanTabList(PlanningVO vo) {
		return list("PlanningDAO.getPlanTabList", vo);
	}

	public int getTotalCnt(PlanningVO vo) {
		return (Integer)select("PlanningDAO.getTotalCnt",vo);
	}
}
