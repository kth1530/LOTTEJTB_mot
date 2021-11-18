package com.lottejtb.account.service;

import java.util.List;

public interface AirPaymtService {

	public void saveAirActPaymt(AirActPaymtVO vo) throws Exception;
	public void saveAirCardPaymt(AirCardPaymtVO vo) throws Exception;
	public void saveAirEtcPaymt(AirEtcPaymtVO vo) throws Exception;
	public void saveAirGiftPaymt(AirGiftPaymtVO vo) throws Exception;
	public void saveAirRsvPaymt(AirRsvPaymtVO vo) throws Exception;
	public void saveAirReceiptReq(AirReceiptReqVO vo) throws Exception;
	public void saveAirRefundMgt(AirRefundMgtVO vo) throws Exception;
	public void saveUpdateCancelYnAirFitRsvMst(AirRefundMgtVO vo) throws Exception;
	public void updateAirRsvMst(int airRsvSeqno) throws Exception;
	public List<AirPaymentVO> selectAirPayment(String fitRsvNo) throws Exception;
	
}
