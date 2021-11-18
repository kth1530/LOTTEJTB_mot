package com.lottejtb.front.service;

import java.util.ArrayList;
import java.util.HashMap;

public interface FitReserveService {
	public ArrayList<FreeCancelReserveVO> selectCancelList(FreeCancelReserveVO vo) throws Exception;
	public ArrayList<FreeCancelReserveVO> selectAirCancelList(FreeCancelReserveVO vo) throws Exception;
	public ArrayList<FreeCancelReserveVO> selectHtlCancelList(FreeCancelReserveVO vo) throws Exception;
	public ArrayList<FreeCancelReserveVO> selectRntCancelList(FreeCancelReserveVO vo) throws Exception;
	public void updateCancelFitReserve(HashMap<String, Object> param) throws Exception;
	public void updateActPaymt(HashMap<String, Object> param) throws Exception;
}
