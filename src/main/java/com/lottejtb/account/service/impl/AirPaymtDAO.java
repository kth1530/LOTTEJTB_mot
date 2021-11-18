package com.lottejtb.account.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lottejtb.account.service.AirActPaymtVO;
import com.lottejtb.account.service.AirCardPaymtVO;
import com.lottejtb.account.service.AirEtcPaymtVO;
import com.lottejtb.account.service.AirGiftPaymtVO;
import com.lottejtb.account.service.AirPaymentVO;
import com.lottejtb.account.service.AirReceiptReqVO;
import com.lottejtb.account.service.AirRefundMgtVO;
import com.lottejtb.account.service.AirRsvPaymtVO;
import com.lottejtb.account.service.paramVO;
import com.lottejtb.framework.common.CommAbstractFreeDAO;

@Repository("AirPaymtDAO")
public class AirPaymtDAO extends CommAbstractFreeDAO {

	
	public void saveAirActPaymt(AirActPaymtVO vo) throws Exception {
		// TODO Auto-generated method stub
		insert("PaymtDAO.insertAirActPaymt", vo);
	}

	
	public void saveAirCardPaymt(AirCardPaymtVO vo) throws Exception {
		// TODO Auto-generated method stub
		insert("PaymtDAO.insertAirCardPaymt", vo);
	}

	public void saveAirEtcPaymt(AirEtcPaymtVO vo) throws Exception {
		// TODO Auto-generated method stub
		insert("PaymtDAO.insertAirEtcPaymt", vo);
	}


	public void saveAirGiftPaymt(AirGiftPaymtVO vo) throws Exception {
		// TODO Auto-generated method stub
		insert("PaymtDAO.insertAirGiftPaymt", vo);
	}

	public void saveAirRsvPaymt(AirRsvPaymtVO vo) throws Exception {
		// TODO Auto-generated method stub
		insert("PaymtDAO.insertAirRsvPaymt", vo);
	}

	public void saveAirReceiptReq(AirReceiptReqVO vo) throws Exception {
		// TODO Auto-generated method stub
		insert("PaymtDAO.insertAirReceiptReq", vo);
	}
	
	public void saveAirRefundMgt(AirRefundMgtVO vo) throws Exception {
		// TODO Auto-generated method stub
		insert("PaymtDAO.insertAirRefundMgt", vo);
	}
	
	public void saveUpdateCancelYnAirFitRsvMst(AirRefundMgtVO vo) throws Exception {
		// TODO Auto-generated method stub
		update("PaymtDAO.updateCancelYnAirFitRsvMst", vo);
	}	
	
	public void updateAirRsvMst(int airRsvSeqno) throws Exception {
		// TODO Auto-generated method stub
		update("PaymtDAO.updateAirRsvMst", airRsvSeqno);
	}	
	
	public List<AirPaymentVO> selectAirPayment(String fitRsvNo) {
		return (List<AirPaymentVO>) list("PaymtDAO.selectAirPayment", fitRsvNo);
	}
		
}
