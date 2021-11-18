package com.lottejtb.account.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

@Service("HtlPaymtService")
public interface HtlPaymtService {
	 public void updateCancelYnHtlRsvMst(HtlRefundMgtVO reqVO) throws Exception;	 
	 public JSONObject cancelPayment(JSONObject reqParam) throws Exception;
}