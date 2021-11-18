package com.lottejtb.front.service.impl;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.lottejtb.framework.common.CommAbstractFreeDAO;
import com.lottejtb.front.service.FreeCancelReserveVO;

@Repository("FitReserveDAO")
public class FitReserveDAO extends CommAbstractFreeDAO {
	public ArrayList<FreeCancelReserveVO> selectCancelList(FreeCancelReserveVO vo){
		return (ArrayList<FreeCancelReserveVO>) list("FitReserveDAO.selectCancelList", vo);
	}
	
	public ArrayList<FreeCancelReserveVO> selectAirCancelList(FreeCancelReserveVO vo){
		return (ArrayList<FreeCancelReserveVO>) list("FitReserveDAO.selectAirCancelList", vo);
	}
	
	public ArrayList<FreeCancelReserveVO> selectHtlCancelList(FreeCancelReserveVO vo){
		return (ArrayList<FreeCancelReserveVO>) list("FitReserveDAO.selectHtlCancelList", vo);
	}
	
	public ArrayList<FreeCancelReserveVO> selectRntCancelList(FreeCancelReserveVO vo){
		return (ArrayList<FreeCancelReserveVO>) list("FitReserveDAO.selectRntCancelList", vo);
	}
	
	public void updateCancelFitReserve(HashMap<String, Object> param){
		update("FitReserveDAO.updateCancelFitReserve", param);
	}
	
	public void updateActPaymt(HashMap<String, Object> param){
		update("FitReserveDAO.updateActPaymt", param);
	}
}
