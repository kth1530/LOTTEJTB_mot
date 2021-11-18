package com.lottejtb.account.service;

// 무통장 입금 (현금 입급) 내역 
public class AirActPaymtVO {
	private int AIR_RSV_SEQNO = 0;					// 항공 예약 일련번호 
	private int CASH_AMT = 0;						// 현금 금액 
	private String BANK_CD_GB = "";					// 은행 코드 GB 
	private String ACT_NO = "";						// 계좌 번호 
	private String ACT_PAYMTOR_NM = "";				// 계좌 입금자 명 
	private String PAYMT_SCH_DT = "";				// 입금 예정 일자 
	private String PAYMT_SCH_HM = "";				// 입금 마감시간
	private String NOTE = "";						// 비고 
	private String CASH_RECEIPT_DIVI_GB = "";		// 현금 영수증 구분 GB 
	private String PAYMT_CONF_YN = "";				// 입금 확인 여부 
	private String VIRTUAL_ACT_YN = "";				// 가상 게좌 여부 
	private String OID_NO ="";						//OID_NO 이니시스 주문번호
	private String TID_NO = "";						// TID_NO
	private String REGTOR_ID = "";					// 등록자 ID 
	private String REG_DTT = "";						// 등록 일자 
	private String MODTOR_ID = "";					// 수정자 ID 
	private String MOD_DTT = "";						// 수정 일시 
	
	public int getAIR_RSV_SEQNO() {
		return AIR_RSV_SEQNO;
	}
	public void setAIR_RSV_SEQNO(int aIR_RSV_SEQNO) {
		AIR_RSV_SEQNO = aIR_RSV_SEQNO;
	}
	public int getCASH_AMT() {
		return CASH_AMT;
	}
	public void setCASH_AMT(int cASH_AMT) {
		CASH_AMT = cASH_AMT;
	}
	public String getBANK_CD_GB() {
		return BANK_CD_GB;
	}
	public void setBANK_CD_GB(String bANK_CD_GB) {
		BANK_CD_GB = bANK_CD_GB;
	}
	public String getACT_NO() {
		return ACT_NO;
	}
	public void setACT_NO(String aCT_NO) {
		ACT_NO = aCT_NO;
	}
	public String getACT_PAYMTOR_NM() {
		return ACT_PAYMTOR_NM;
	}
	public void setACT_PAYMTOR_NM(String aCT_PAYMTOR_NM) {
		ACT_PAYMTOR_NM = aCT_PAYMTOR_NM;
	}
	public String getPAYMT_SCH_DT() {
		return PAYMT_SCH_DT;
	}
	public void setPAYMT_SCH_DT(String pAYMT_SCH_DT) {
		PAYMT_SCH_DT = pAYMT_SCH_DT;
	}
	public String getPAYMT_SCH_HM() {
		return PAYMT_SCH_HM;
	}
	public void setPAYMT_SCH_HM(String pAYMT_SCH_HM) {
		PAYMT_SCH_HM = pAYMT_SCH_HM;
	}
	public String getNOTE() {
		return NOTE;
	}
	public void setNOTE(String nOTE) {
		NOTE = nOTE;
	}
	public String getCASH_RECEIPT_DIVI_GB() {
		return CASH_RECEIPT_DIVI_GB;
	}
	public void setCASH_RECEIPT_DIVI_GB(String cASH_RECEIPT_DIVI_GB) {
		CASH_RECEIPT_DIVI_GB = cASH_RECEIPT_DIVI_GB;
	}
	public String getPAYMT_CONF_YN() {
		return PAYMT_CONF_YN;
	}
	public void setPAYMT_CONF_YN(String pAYMT_CONF_YN) {
		PAYMT_CONF_YN = pAYMT_CONF_YN;
	}
	public String getVIRTUAL_ACT_YN() {
		return VIRTUAL_ACT_YN;
	}
	public void setVIRTUAL_ACT_YN(String vIRTUAL_ACT_YN) {
		VIRTUAL_ACT_YN = vIRTUAL_ACT_YN;
	}
	public String getOID_NO() {
		return OID_NO;
	}
	public void setOID_NO(String oID_NO) {
		OID_NO = oID_NO;
	}
	public String getTID_NO() {
		return TID_NO;
	}
	public void setTID_NO(String tID_NO) {
		TID_NO = tID_NO;
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
