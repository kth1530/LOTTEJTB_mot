package com.lottejtb.account.service;

import java.util.List;
import java.util.Map;


public interface LPointService {

	LPointVO getLPointAvailable(String cno) throws Exception;
	LPointVO getLPointAuth(String cno, String cardno, String pw) throws Exception;

	LPointVO getLPointUse(String resCd, String cardNo, String wpw, String startDay, String lottePoint, String pointFg, String custcd) throws Exception;

	LPointVO getLPointAccum(String res_cd, String cardNo, String lottePoint, String saleAmt, String pointFg, String start_day, String custcd) throws Exception;

	PaymentVO requestPayment(String price, String type) throws Exception;
	PaymentVO authAndApprPayment(Map<String, String> paramMap) throws Exception;
	PaymentVO cancelPayment(Map<String, String> paramMap) throws Exception;
	
	VAcctDepoNotiVO insertVacct(Map<String, String> paramMap) throws Exception;
	PaymentVO lpayPayment(Map<String, String> paramMap) throws Exception ;
	List<RvPaymentVO> selectDeposithistory(RvPaymentVO vo) throws Exception;

}
