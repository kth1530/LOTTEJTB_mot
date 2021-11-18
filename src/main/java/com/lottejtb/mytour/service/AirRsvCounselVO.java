package com.lottejtb.mytour.service;

import com.lottejtb.comm.service.CommDefaultVO;

public class AirRsvCounselVO extends CommDefaultVO {
	
	private int COUNSEL_SEQ_NO = 0;					// 상담 일련번호 
	private int AIR_RSV_SEQNO = 0;						// 항공 예약 일련 번호 
	private String PREPARED_BY_NM = "";				// 작성자 명 
	private String COUNSEL_ASSORT_GB = "";				// 상담 분류 GB 
	private String CONT = "";						// 내용 
	
	private String COUNSEL_REQ_DTT = "";				// 상담 요청 일시 
	private String COUNSEL_STATE_GB = "";				// 상담 상태 GB 	
	private String ANSWER_CONT = "";					// 응답 내용 
	private String ANSWER_DTT = "";					// 응답 일시 
	private String PCHARGE_ID = "";					// 담당자 ID 
	
	private String REGTOR_ID = "";					// 등록자 ID 
	private String REG_DTT = "";						// 등록 일시 
	private String MODTOR_ID = "";					// 수정자 ID 
	private String MOD_DTT = "";						// 수정 일시 
	
	public int getCOUNSEL_SEQ_NO() {
		return COUNSEL_SEQ_NO;
	}
	public void setCOUNSEL_SEQ_NO(int cOUNSEL_SEQ_NO) {
		COUNSEL_SEQ_NO = cOUNSEL_SEQ_NO;
	}
	public int getAIR_RSV_SEQNO() {
		return AIR_RSV_SEQNO;
	}
	public void setAIR_RSV_SEQNO(int aIR_RSV_SEQNO) {
		AIR_RSV_SEQNO = aIR_RSV_SEQNO;
	}
	public String getPREPARED_BY_NM() {
		return PREPARED_BY_NM;
	}
	public void setPREPARED_BY_NM(String pREPARED_BY_NM) {
		PREPARED_BY_NM = pREPARED_BY_NM;
	}
	public String getCOUNSEL_ASSORT_GB() {
		return COUNSEL_ASSORT_GB;
	}
	public void setCOUNSEL_ASSORT_GB(String cOUNSEL_ASSORT_GB) {
		COUNSEL_ASSORT_GB = cOUNSEL_ASSORT_GB;
	}
	public String getCONT() {
		return CONT;
	}
	public void setCONT(String cONT) {
		CONT = cONT;
	}
	public String getCOUNSEL_REQ_DTT() {
		return COUNSEL_REQ_DTT;
	}
	public void setCOUNSEL_REQ_DTT(String cOUNSEL_REQ_DTT) {
		COUNSEL_REQ_DTT = cOUNSEL_REQ_DTT;
	}
	public String getCOUNSEL_STATE_GB() {
		return COUNSEL_STATE_GB;
	}
	public void setCOUNSEL_STATE_GB(String cOUNSEL_STATE_GB) {
		COUNSEL_STATE_GB = cOUNSEL_STATE_GB;
	}
	public String getANSWER_CONT() {
		return ANSWER_CONT;
	}
	public void setANSWER_CONT(String aNSWER_CONT) {
		ANSWER_CONT = aNSWER_CONT;
	}
	public String getANSWER_DTT() {
		return ANSWER_DTT;
	}
	public void setANSWER_DTT(String aNSWER_DTT) {
		ANSWER_DTT = aNSWER_DTT;
	}
	public String getPCHARGE_ID() {
		return PCHARGE_ID;
	}
	public void setPCHARGE_ID(String pCHARGE_ID) {
		PCHARGE_ID = pCHARGE_ID;
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
