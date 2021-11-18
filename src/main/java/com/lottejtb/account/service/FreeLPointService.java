package com.lottejtb.account.service;

import java.util.Map;

import net.sf.json.JSONObject;


public interface FreeLPointService {

	LPointVO getLPointAvailable(String cno) throws Exception;
	LPointVO getLPointAuth(String cno, String cardno, String pw) throws Exception;

	LPointVO getLPointUse(String resCd, String cardNo, String wpw, String startDay, String lottePoint, String pointFg, String custcd) throws Exception;

	LPointVO getLPointAccum(String res_cd, String cardNo, String lottePoint, String saleAmt, String pointFg, String start_day, String custcd) throws Exception;

	PaymentVO requestPayment(String price, String type) throws Exception;
	PaymentVO requestAirPay(String price) throws Exception;
	
	PaymentVO authAndApprPayment(Map<String, String> paramMap) throws Exception;
	PaymentVO authAndApprAirPay(Map<String, String> paramMap) throws Exception;
	PaymentVO cancelPayment(Map<String, String> paramMap) throws Exception;
	
	VAcctDepoNotiVO insertVacct(Map<String, String> paramMap) throws Exception;
	PaymentVO lpayPayment(Map<String, String> paramMap) throws Exception;
	
	JSONObject cancelLpointUse(String fitRsvNo) throws Exception;
	
	PaymentVO requestPayments(String price) throws Exception;
	PaymentVO authAndApprPayments(Map<String, String> paramMap) throws Exception;

}
