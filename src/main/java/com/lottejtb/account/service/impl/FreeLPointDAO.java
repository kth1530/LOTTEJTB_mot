package com.lottejtb.account.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.lottejtb.account.service.AirActPaymtVO;
import com.lottejtb.account.service.AirReceiptReqVO;
import com.lottejtb.account.service.AirRsvPaymtVO;
import com.lottejtb.account.service.CashVO;
import com.lottejtb.account.service.CoSettDetVO;
import com.lottejtb.account.service.CoSettFeeVO;
import com.lottejtb.account.service.CoSettMethVO;
import com.lottejtb.account.service.FaFitCashReceiptVO;
import com.lottejtb.account.service.FaFitPaymtInfVO;
import com.lottejtb.account.service.FaFitRsvMstVO;
import com.lottejtb.account.service.HtlActPaymtVO;
import com.lottejtb.account.service.HtlCardPaymtVO;
import com.lottejtb.account.service.HtlEtcPaymtVO;
import com.lottejtb.account.service.HtlGiftPaymtVO;
import com.lottejtb.account.service.PointHistoryVO;
import com.lottejtb.account.service.PointMstVO;
import com.lottejtb.account.service.RvPaymentVO;
import com.lottejtb.account.service.paramVO;
import com.lottejtb.framework.common.CommAbstractFreeDAO;
import com.lottejtb.account.service.LPointVO;

@Repository("FreeLPointDAO")
public class FreeLPointDAO extends CommAbstractFreeDAO {
	
	public HashMap<String, Object> selectLottePointSeq() throws Exception{
		return (HashMap<String, Object>) select("FreeMytourDAO.selectLottePointSeq");
    }
	
	public void insertLottePointSeq() throws Exception{
		insert("FreeMytourDAO.insertLottePointSeq");
    }
	
	public void updateLottePointSeq() throws Exception{
		insert("FreeMytourDAO.updateLottePointSeq");
    }

	public void insertLottePointMst(PointMstVO pointMstVO) throws Exception{
		insert("FreeMytourDAO.insertLottePointMst", pointMstVO);
    }

	public void insertLottePointHis(PointHistoryVO pointHistoryVO) throws Exception{
		insert("FreeMytourDAO.insertLottePointHis", pointHistoryVO);
    }
	
	public List<CoSettMethVO> selectSettMeth(paramVO pVO) {
		return (List<CoSettMethVO>) list("FreeMytourDAO.selectSettMeth", pVO);
	}
	
	public List<CoSettFeeVO> selectSettFee(paramVO pVO) {
		return (List<CoSettFeeVO>) list("FreeMytourDAO.selectSettFee", pVO);
	}
	
	public List<CoSettDetVO> selectSettDet(paramVO pVO) {
		return (List<CoSettDetVO>) list("FreeMytourDAO.selectSettDet", pVO);
	}
	
	public void insertPayment(RvPaymentVO rpVO) {
		 insert("FreeMytourDAO.insertPayment", rpVO);
	}
	
	public List<RvPaymentVO> selectIOcd(RvPaymentVO rpVO) {
		 return (List<RvPaymentVO>) list("FreeMytourDAO.selectIoCd", rpVO);
	}
	
	public String selectBusiNo(RvPaymentVO rvPaymentVO) throws Exception{
		return (String) select("FreeMytourDAO.selectBusiNo", rvPaymentVO);
    }
	
	public String selectCashNo() throws Exception{
		return (String) select("FreeMytourDAO.selectCashNo");
    }
	
	public void insertCash(CashVO cashVO) throws Exception{
		insert("FreeMytourDAO.insertCash", cashVO);
    }
	
	public void insertFitPayment(FaFitPaymtInfVO faFitPaymtInfVO) throws Exception{
		insert("FreeMytourDAO.insertFitPayment", faFitPaymtInfVO);
    }
	
	public void updateRsvMst(FaFitRsvMstVO faFitRsvMstVO) throws Exception{
		insert("FreeMytourDAO.updateRsvMst", faFitRsvMstVO);
    }
	
	public void insertAirRsvPaymt(AirRsvPaymtVO airRsvPaymtVO) throws Exception{
		insert("FreeMytourDAO.insertAirRsvPaymt", airRsvPaymtVO);
    }
	
	public void insertAirActPaymt(AirActPaymtVO airActPaymtVO) throws Exception{
		insert("FreeMytourDAO.insertAirActPaymt", airActPaymtVO);
    }
	
	public void updateAirRsvMst(Map paramMap) throws Exception{
		insert("FreeMytourDAO.updateAirRsvMst", paramMap);
    }
	
	public void insertAirReceiptReq(AirReceiptReqVO AirReceiptReqVO) throws Exception{
		insert("FreeMytourDAO.insertAirReceiptReq", AirReceiptReqVO);
    }
	
	public void insertHtlReceiptReq(AirReceiptReqVO AirReceiptReqVO) throws Exception{
		insert("FreeMytourDAO.insertHtlReceiptReq", AirReceiptReqVO);
    }

	public void insertFitCashReceipt(FaFitCashReceiptVO FaFitCashReceiptVO) throws Exception{
		insert("FreeMytourDAO.insertFitCashReceipt", FaFitCashReceiptVO);
    }
	
	public void insertHtlCardPaymt(HtlCardPaymtVO htlCardPaymtVO) throws Exception{
		insert("FreeMytourDAO.insertHtlCardPaymt", htlCardPaymtVO);
    }
	
	public void insertHtlActPaymt(HtlActPaymtVO htlActPaymtVO) throws Exception{
		insert("FreeMytourDAO.insertHtlActPaymt", htlActPaymtVO);
    }
	
	public void insertHtlGiftPaymt(HtlGiftPaymtVO htlGiftPaymtVO) throws Exception{
		insert("FreeMytourDAO.insertHtlGiftPaymt", htlGiftPaymtVO);
    }
	
	public void insertHtlEtcPaymt(HtlEtcPaymtVO htlEtcPaymtVO) throws Exception{
		insert("FreeMytourDAO.insertHtlEtcPaymt", htlEtcPaymtVO);
    }
	
	//LPOINT 사용 취소를 췽한 조회 
	public LPointVO selectUseLPointInfo(String fitRsvNo) throws Exception {
    	return (LPointVO) select("FreeMytourDAO.selectUseLPointInfo", fitRsvNo);
    }

	// Payment_TEMP 테이블 결제내용 insert
	public void insertPopCardPaymt(HtlCardPaymtVO htlCardPaymtVO) throws Exception{
		insert("FreeMytourDAO.insertPopCardPaymt", htlCardPaymtVO);
    }
	
}
