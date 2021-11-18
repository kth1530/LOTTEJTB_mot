package com.lottejtb.front.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.lottejtb.front.service.FitReserveVO;
import com.lottejtb.front.service.ReqPromotionVO;
import com.lottejtb.front.service.ReqReserveVO;
import com.lottejtb.front.service.SmsVO;
import com.lottejtb.mytour.service.MytourVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("FreeReserveDAO")
public class FreeReserveDAO extends EgovAbstractDAO {
	@Resource(name="sqlMapClient_free")
	SqlMapClient sqlMapClient_free;
	

	public String insertFreeReserve(ReqReserveVO reqVO) throws Exception{
		String fitRsvNo = null;
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		result = (HashMap<String, Object>) sqlMapClient_free.queryForObject("FitReserveDAO.selectFitRsvNo");
		//result = (HashMap<String, Object>) select("FitReserveDAO.selectFitRsvNo");
		reqVO.setFitRsvNo(result.get("FIT_RSV_NO").toString());
		
		sqlMapClient_free.insert("FitReserveDAO.insertFitRsvMst", reqVO);
		//insert("FitReserveDAO.insertFitRsvMst", reqVO);
		
		return result.get("FIT_RSV_NO").toString();
	}
	

	public void deleteFreeReserve(ReqReserveVO reqVO) throws Exception{
		sqlMapClient_free.update("FitReserveDAO.deleteFreeReserve", reqVO);
	}
	
	/** <!-- 예약 UI > SMS 발송 --> **/
	public void insertSmsSend(SmsVO param) throws Exception {
		insert("ReserveDAO.insertSmsSend", param);
	}
	
	public void updateFreeReserve(ReqReserveVO reqVO) throws Exception{		
		sqlMapClient_free.update("FitReserveDAO.updateFitRsvMst", reqVO);
	}
	
	public FitReserveVO selectFreeReserve(FitReserveVO reserveVO) throws Exception {
		return (FitReserveVO)sqlMapClient_free.queryForObject("FitReserveDAO.selectFreeReserve", reserveVO);
		//return (ReserveVO)select("FitReserveDAO.selectFreeReserve", reserveVO);
	}
	
	public void insertFitPromReserve(ReqPromotionVO promVO) throws Exception{
		sqlMapClient_free.insert("FitReserveDAO.insertFitPromReserve", promVO);
	}
	
	public void updateFitReserveState(ReqReserveVO reqVO) throws Exception{
		sqlMapClient_free.update("FitRsvserveDAO.updateFitReserveState", reqVO);
	}
	
	public HashMap<String, List> freeReserve(String seqNo) throws Exception{
		HashMap<String, List> result = new HashMap<String, List>();
		List reserveMst;
		List reserveAir;
		List reserveHtl;
		List reserveRnt;
		
		reserveMst = sqlMapClient_free.queryForList("FitRsvserveDAO.selectFreeMstReserve", seqNo);
		reserveAir = sqlMapClient_free.queryForList("FitRsvserveDAO.selecrFreeAirReserve", seqNo);
		reserveHtl = sqlMapClient_free.queryForList("FitRsvserveDAO.selectFreeHtlReserve", seqNo);
		reserveRnt = sqlMapClient_free.queryForList("FitRsvserveDAO.selectFreeRntReserve", seqNo);
		
		result.put("mst", reserveMst);
		result.put("air", reserveAir);
		result.put("htl", reserveHtl);
		result.put("rnt", reserveRnt);
		
		return result;
	}
	
	public String getFitRsvNo(String rsvNo) throws Exception{
		return (String) sqlMapClient_free.queryForObject("FitReserveDAO.getFitRsvNo", rsvNo);
	}
}