package com.lottejtb.account.service;

// 기타 사용 내역 
public class AirEtcPaymtVO {
	private int AIR_RSV_SEQNO = 0;						// 항공 예약 일련번호 
	private String ETC_USE_YN = "";						// 기타 사용 여부 
	private int ETC_PAYMT_AMT = 0;						// 기타 결제 금액 
	private String PAYMT_CONF_YN = "";					// 입금 확인 여부 
	private String NOTE = "";							// 비고 
	private String REGTOR_ID = "";						// 둥록자 ID 
	private String REG_DTT = "";							// 등록 일시 
	private String MODTOR_ID = "";						// 수정자 ID 
	private String MOD_DTT = "";							// 수정 일시 
	
	public int getAIR_RSV_SEQNO() {
		return AIR_RSV_SEQNO;
	}
	public void setAIR_RSV_SEQNO(int aIR_RSV_SEQNO) {
		AIR_RSV_SEQNO = aIR_RSV_SEQNO;
	}
	public String getETC_USE_YN() {
		return ETC_USE_YN;
	}
	public void setETC_USE_YN(String eTC_USE_YN) {
		ETC_USE_YN = eTC_USE_YN;
	}
	public int getETC_PAYMT_AMT() {
		return ETC_PAYMT_AMT;
	}
	public void setETC_PAYMT_AMT(int eTC_PAYMT_AMT) {
		ETC_PAYMT_AMT = eTC_PAYMT_AMT;
	}
	public String getPAYMT_CONF_YN() {
		return PAYMT_CONF_YN;
	}
	public void setPAYMT_CONF_YN(String pAYMT_CONF_YN) {
		PAYMT_CONF_YN = pAYMT_CONF_YN;
	}
	public String getNOTE() {
		return NOTE;
	}
	public void setNOTE(String nOTE) {
		NOTE = nOTE;
	}
	public String getREGTOR_ID() {
		return REGTOR_ID;
	}
	public void setREGTOR_ID(String rEGTOR_ID) {
		REGTOR_ID = rEGTOR_ID;
	}
	public String getREG_DTT() {
		return REG_DTT;
	}
	public void setREG_DTT(String rEG_DTT) {
		REG_DTT = rEG_DTT;
	}
	public String getMODTOR_ID() {
		return MODTOR_ID;
	}
	public void setMODTOR_ID(String mODTOR_ID) {
		MODTOR_ID = mODTOR_ID;
	}
	public String getMOD_DTT() {
		return MOD_DTT;
	}
	public void setMOD_DTT(String mOD_DTT) {
		MOD_DTT = mOD_DTT;
	}
	

}
