package com.lottejtb.account.service.impl;

import org.springframework.stereotype.Repository;

import com.lottejtb.account.service.HtlRefundMgtVO;
import com.lottejtb.framework.common.CommAbstractFreeDAO;

@Repository("HtlPaymtDAO")
public class HtlPaymtDAO extends CommAbstractFreeDAO {
	
	public void updateCancelYnHtlRsvMst(HtlRefundMgtVO vo) {
		update("PaymtDAO.updateCancelYnHotelFitRsvMst", vo);
	}
	
	/**
	 * 호텔 결제 정보를 조회한다.
	 */
	public HtlRefundMgtVO selectPaymentInfo(HtlRefundMgtVO vo) throws Exception {
		return (HtlRefundMgtVO) select("PaymtDAO.selectPaymentInfo", vo);
    }
	
	/**
	 * 호텔 결제 정보 업데이트.
	 */
	public void updateCancelHtlPay(HtlRefundMgtVO vo) throws Exception{
		update("PaymtDAO.updateCancelHtlPay", vo);
	}
}
