package com.lottejtb.front.service.impl;

import java.util.ArrayList;
import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lottejtb.front.service.FitReserveService;
import com.lottejtb.front.service.FreeCancelReserveVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("FitReserveService")
public class FitReserveServiceImpl extends EgovAbstractServiceImpl implements FitReserveService{
	
	@Resource(name="FitReserveDAO")
	private FitReserveDAO fitReserveDAO;
	
	@Override
	public ArrayList<FreeCancelReserveVO> selectCancelList(FreeCancelReserveVO vo) throws Exception{
		return fitReserveDAO.selectCancelList(vo);
	}
	
	@Override
	public ArrayList<FreeCancelReserveVO> selectAirCancelList(FreeCancelReserveVO vo) throws Exception{
		return fitReserveDAO.selectAirCancelList(vo);
	}
	
	@Override
	public ArrayList<FreeCancelReserveVO> selectHtlCancelList(FreeCancelReserveVO vo) throws Exception{
		return fitReserveDAO.selectHtlCancelList(vo);
	}
	
	@Override
	public ArrayList<FreeCancelReserveVO> selectRntCancelList(FreeCancelReserveVO vo) throws Exception{
		return fitReserveDAO.selectRntCancelList(vo);
	}
	
	@Override
	public void updateCancelFitReserve(HashMap<String, Object> param) throws Exception{
		fitReserveDAO.updateCancelFitReserve(param);
	}
	
	@Override
	public void updateActPaymt(HashMap<String, Object> param) throws Exception{
		fitReserveDAO.updateActPaymt(param);
	}
}
