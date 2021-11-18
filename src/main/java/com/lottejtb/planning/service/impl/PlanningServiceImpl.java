package com.lottejtb.planning.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.lottejtb.customer.service.impl.FaqDAO;
import com.lottejtb.planning.service.PlanningService;
import com.lottejtb.planning.service.PlanningVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("PlanningService")
@Repository
public class PlanningServiceImpl extends EgovAbstractServiceImpl implements PlanningService {
	
	
	@Resource(name="PlanningDAO")
	private PlanningDAO planningDAO;
	
	
	@Override
	public List srchAllPlanList(PlanningVO vo) throws SQLException {
		return planningDAO.srchAllPlanList(vo);
	}

	@Override
	public List selPlanList(PlanningVO vo) throws SQLException {
		return planningDAO.selPlanList(vo);
	}

	@Override
	public void planningCnt(PlanningVO vo) throws SQLException {
		planningDAO.planningCnt(vo);
	}

	@Override
	public int getplanCnt(PlanningVO vo) throws SQLException {
		return planningDAO.getplanCnt(vo);
	}

	@Override
	public List<PlanningVO> srchDetailPlanList(PlanningVO vo) throws SQLException {
		return planningDAO.srchDetailPlanList(vo);
	}

	@Override
	public List<PlanningVO> getplanSubInfo(PlanningVO vo) throws SQLException {
		return planningDAO.getplanSubInfo(vo);
	}

	@Override
	public  List<PlanningVO> searchRNDiPlanAddInfo(PlanningVO vo) throws SQLException {
		return planningDAO.searchRNDiPlanAddInfo(vo);
	}

	@Override
	public int minCharge(PlanningVO vo) throws SQLException {
		return planningDAO.minCharge(vo);
	}

	@Override
	public List<PlanningVO> planImage(PlanningVO vo) throws SQLException {
		return planningDAO.getPlanImage(vo);
	}

	@Override
	public List setDetailPlanList(PlanningVO vo) throws SQLException {
		return planningDAO.setDetailPlanList(vo);
	}
	
	@Override
	public List getPlanTabList(PlanningVO vo) throws SQLException{
		return planningDAO.getPlanTabList(vo);
	}

	@Override
	public int getTotalCnt(PlanningVO vo) throws SQLException {
		return planningDAO.getTotalCnt(vo);
	}

}
