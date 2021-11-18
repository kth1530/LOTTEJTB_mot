package com.lottejtb.account.service;

// 소득 증빙용 서류 저장 
public class AirReceiptReqVO {
	
	String RECEIPT_SEQNO    = ""; 			// 영수증 일련 번호 
	String AIR_RSV_SEQNO    = "";			// 항공 예약 번호 
	String RECEIPT_DIVI_GB  = "";			// 영수증 구분 GB 
	String ISSUE_HTEL       = "";			// 발급 휴대전화 
	String CORP_NO          = "";			// 사업자 번호 
	String REGTOR_ID        = "";			// 등록자 ID 
	String REG_DTT          = "";			// 등록 일시 
	String MODTOR_ID        = "";			// 수정자 ID		 
	String MOD_DTT          = "";			// 수정 일시 
	
	public String getRECEIPT_SEQNO() {
		return RECEIPT_SEQNO;
	}
	public void setRECEIPT_SEQNO(String rECEIPT_SEQNO) {
		RECEIPT_SEQNO = rECEIPT_SEQNO;
	}
	public String getAIR_RSV_SEQNO() {
		return AIR_RSV_SEQNO;
	}
	public void setAIR_RSV_SEQNO(String aIR_RSV_SEQNO) {
		AIR_RSV_SEQNO = aIR_RSV_SEQNO;
	}
	public String getRECEIPT_DIVI_GB() {
		return RECEIPT_DIVI_GB;
	}
	public void setRECEIPT_DIVI_GB(String rECEIPT_DIVI_GB) {
		RECEIPT_DIVI_GB = rECEIPT_DIVI_GB;
	}
	public String getISSUE_HTEL() {
		return ISSUE_HTEL;
	}
	public void setISSUE_HTEL(String iSSUE_HTEL) {
		ISSUE_HTEL = iSSUE_HTEL;
	}
	public String getCORP_NO() {
		return CORP_NO;
	}
	public void setCORP_NO(String cORP_NO) {
		CORP_NO = cORP_NO;
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
