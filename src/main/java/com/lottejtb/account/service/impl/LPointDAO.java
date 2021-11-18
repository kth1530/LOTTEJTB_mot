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
import com.lottejtb.account.service.FaFitPaymtInfVO;
import com.lottejtb.account.service.FaFitRsvMstVO;
import com.lottejtb.account.service.PointHistoryVO;
import com.lottejtb.account.service.PointMstVO;
import com.lottejtb.account.service.RvPaymentVO;
import com.lottejtb.account.service.paramVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("LPointDAO")
public class LPointDAO extends EgovAbstractDAO {
	
	public HashMap<String, Object> selectLottePointSeq() throws Exception{
		return (HashMap<String, Object>) select("MytourDAO.selectLottePointSeq");
    }
	
	public void insertLottePointSeq() throws Exception{
		insert("MytourDAO.insertLottePointSeq");
    }
	
	public void updateLottePointSeq() throws Exception{
		insert("MytourDAO.updateLottePointSeq");
    }

	public void insertLottePointMst(PointMstVO pointMstVO) throws Exception{
		insert("MytourDAO.insertLottePointMst", pointMstVO);
    }

	public void insertLottePointHis(PointHistoryVO pointHistoryVO) throws Exception{
		insert("MytourDAO.insertLottePointHis", pointHistoryVO);
    }
	
	public List<CoSettMethVO> selectSettMeth(paramVO pVO) {
		return (List<CoSettMethVO>) list("MytourDAO.selectSettMeth", pVO);
	}
	
	public List<CoSettFeeVO> selectSettFee(paramVO pVO) {
		return (List<CoSettFeeVO>) list("MytourDAO.selectSettFee", pVO);
	}
	
	public List<CoSettDetVO> selectSettDet(paramVO pVO) {
		return (List<CoSettDetVO>) list("MytourDAO.selectSettDet", pVO);
	}
	
	public void insertPayment(RvPaymentVO rpVO) {
		 insert("MytourDAO.insertPayment", rpVO);
	}
	
	public List<RvPaymentVO> selectIOcd(RvPaymentVO rpVO) {
		 return (List<RvPaymentVO>) list("MytourDAO.selectIoCd", rpVO);
	}
	
	public String selectBusiNo(RvPaymentVO rvPaymentVO) throws Exception{
		return (String) select("MytourDAO.selectBusiNo", rvPaymentVO);
    }
	
	public String selectCashNo() throws Exception{
		return (String) select("MytourDAO.selectCashNo");
    }
	
	public void insertCash(CashVO cashVO) throws Exception{
		insert("MytourDAO.insertCash", cashVO);
    }
	
	public void insertFitPayment(FaFitPaymtInfVO faFitPaymtInfVO) throws Exception{
		insert("MytourDAO.insertFitPayment", faFitPaymtInfVO);
    }
	
	public void updateRsvMst(FaFitRsvMstVO faFitRsvMstVO) throws Exception{
		insert("MytourDAO.updateRsvMst", faFitRsvMstVO);
    }
	
	public void insertAirRsvPaymt(AirRsvPaymtVO airRsvPaymtVO) throws Exception{
		insert("MytourDAO.insertAirRsvPaymt", airRsvPaymtVO);
    }
	
	public void insertAirActPaymt(AirActPaymtVO airActPaymtVO) throws Exception{
		insert("MytourDAO.insertAirActPaymt", airActPaymtVO);
    }
	
	public void updateAirRsvMst(Map paramMap) throws Exception{
		insert("MytourDAO.updateAirRsvMst", paramMap);
    }
	
	public void insertAirReceiptReq(AirReceiptReqVO AirReceiptReqVO) throws Exception{
		insert("MytourDAO.insertAirReceiptReq", AirReceiptReqVO);
    }
	
	public String selectEtcRscCd(RvPaymentVO rvPaymentVO) throws Exception{
		return (String) select("MytourDAO.selectEtcRscCd", rvPaymentVO);
    }
	
	//입금내역 조회
	public List<RvPaymentVO> selectDeposithistory(RvPaymentVO vo) throws Exception {
		return(List<RvPaymentVO>) list("MytourDAO.selectDeposithistory", vo);
	}
	
}
