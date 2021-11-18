package com.lottejtb.account.service;

// 상품권 사용 내역 
public class AirGiftPaymtVO {
	private int GIFT_SEQNO = 0;									// 상품권 일련번호 
	private int AIR_RSV_SEQNO = 0;								// 항공 예약 일련번호 
	private String GIFT_DIVI_GB = "";							// 상품권 구분 GB 
	private String GIFT_NO = "";									// 상품권 번호 
	private int GIFT_AMT = 0;									// 상품권 금액 
	private String GIFT_RECP_YN = "";							// 상품권 수령 여부 
	private String NOTE = "";									// 비고 
	private String REGTOR_ID = "";								// 등록자 ID 
	private String REG_DTT = "";									// 등록 일시 
	private String MODTOR_ID = "";								// 수정자 ID 
	private String MOD_DTT = "";									// 수정 일시 
	
	public int getGIFT_SEQNO() {
		return GIFT_SEQNO;
	}
	public void setGIFT_SEQNO(int gIFT_SEQNO) {
		GIFT_SEQNO = gIFT_SEQNO;
	}
	public int getAIR_RSV_SEQNO() {
		return AIR_RSV_SEQNO;
	}
	public void setAIR_RSV_SEQNO(int aIR_RSV_SEQNO) {
		AIR_RSV_SEQNO = aIR_RSV_SEQNO;
	}
	public String getGIFT_DIVI_GB() {
		return GIFT_DIVI_GB;
	}
	public void setGIFT_DIVI_GB(String gIFT_DIVI_GB) {
		GIFT_DIVI_GB = gIFT_DIVI_GB;
	}
	public String getGIFT_NO() {
		return GIFT_NO;
	}
	public void setGIFT_NO(String gIFT_NO) {
		GIFT_NO = gIFT_NO;
	}
	public int getGIFT_AMT() {
		return GIFT_AMT;
	}
	public void setGIFT_AMT(int gIFT_AMT) {
		GIFT_AMT = gIFT_AMT;
	}
	public String getGIFT_RECP_YN() {
		return GIFT_RECP_YN;
	}
	public void setGIFT_RECP_YN(String gIFT_RECP_YN) {
		GIFT_RECP_YN = gIFT_RECP_YN;
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
