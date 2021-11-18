package com.lottejtb.account.service;

// 항공 결제 정보 
public class AirRsvPaymtVO {
	private int AIR_RSV_SEQNO = 0;						// 항공 예약 일련번호 
	private int PAYMT_APPROVE_AMT = 0;					// 결제 승인 금액 (TASF 취급수수료 포함한 금액)
	private int PAYMT_UNPAID_AMT = 0;					// 결제 미수 금액 
	private int TASF_AMT = 0;							// TASF 취급수수료 포함 
	private String CARD_USE_YN = "";						// 카드 사용 여부 
	private String CARD_ALL_YN = "";						// 카드 전체 사용 여부 
	private String ACT_USE_YN = "";						// 무통장 사용 여부 
	private String GIFT_USE_YN = "";						// 상품권 사용 여부 
	private String ETC_USE_YN = "";						// 기타 사용 유무 
	private String REGTOR_ID = "";						// 등록자 ID 
	private String REG_DTT = "";							// 등록일시 
	private String MODTOR_ID = "";						// 수정자 ID 
	private String MOD_DTT = "";							// 수정 일시 


	public int getAIR_RSV_SEQNO() {
		return AIR_RSV_SEQNO;
	}


	public void setAIR_RSV_SEQNO(int aIR_RSV_SEQNO) {
		AIR_RSV_SEQNO = aIR_RSV_SEQNO;
	}


	public int getPAYMT_APPROVE_AMT() {
		return PAYMT_APPROVE_AMT;
	}


	public void setPAYMT_APPROVE_AMT(int pAYMT_APPROVE_AMT) {
		PAYMT_APPROVE_AMT = pAYMT_APPROVE_AMT;
	}


	public int getPAYMT_UNPAID_AMT() {
		return PAYMT_UNPAID_AMT;
	}


	public void setPAYMT_UNPAID_AMT(int pAYMT_UNPAID_AMT) {
		PAYMT_UNPAID_AMT = pAYMT_UNPAID_AMT;
	}


	public int getTASF_AMT() {
		return TASF_AMT;
	}


	public void setTASF_AMT(int tASF_AMT) {
		TASF_AMT = tASF_AMT;
	}


	public String getCARD_USE_YN() {
		return CARD_USE_YN;
	}


	public void setCARD_USE_YN(String cARD_USE_YN) {
		CARD_USE_YN = cARD_USE_YN;
	}


	public String getCARD_ALL_YN() {
		return CARD_ALL_YN;
	}


	public void setCARD_ALL_YN(String cARD_ALL_YN) {
		CARD_ALL_YN = cARD_ALL_YN;
	}


	public String getACT_USE_YN() {
		return ACT_USE_YN;
	}


	public void setACT_USE_YN(String aCT_USE_YN) {
		ACT_USE_YN = aCT_USE_YN;
	}


	public String getGIFT_USE_YN() {
		return GIFT_USE_YN;
	}


	public void setGIFT_USE_YN(String gIFT_USE_YN) {
		GIFT_USE_YN = gIFT_USE_YN;
	}


	public String getETC_USE_YN() {
		return ETC_USE_YN;
	}


	public void setETC_USE_YN(String eTC_USE_YN) {
		ETC_USE_YN = eTC_USE_YN;
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
