package com.lottejtb.front.service;

import java.util.HashMap;
import java.util.List;


public interface FreeReserveService {
	// JSONObject reqReserve (ReqReserveVO reqVO) throws Exception;
	public String insertFreeReserve(ReqReserveVO reqVO) throws Exception;
	public void updateFreeReserve(ReqReserveVO reqVO) throws Exception;
	public void deleteFreeReserve(ReqReserveVO reqVO) throws Exception;
	public void insertFitPromReserve(ReqPromotionVO promVO) throws Exception;
	public void updateFitReserveState(ReqReserveVO reqVO) throws Exception;
	
	public FitReserveVO selectFreeReserve(FitReserveVO reserveVO) throws Exception;
	public HashMap<String, List> freeReserve(String seqNo) throws Exception;
	public String getFitRsvNo(String rsvNo) throws Exception;
}
