package com.lottejtb.mytour.service;

import com.lottejtb.comm.service.CommDefaultVO;

public class FaFitCounselQuesVO extends CommDefaultVO {
	private static final long serialVersionUID = 5220912191584464012L;
	
	private int QUES_SEQNO = 0;
	private String ASSORT_CD = "";
	private String ASSORT_NM = "";
	private String TITLE = "";
	private String CONT = "";
	private String EMAIL = "";
	private String HTEL = "";
	
	private String USER_ID = "";
	private String EMAIL_RECV_YN = "";
	private String SMS_RECV_YN = "";
	private String REGTOR_ID = "";
	private String REG_DTT = "";
	
	private String MODTOR_ID = "";
	private String MOD_DTT = "";
	private String ANSW = "";
	
	public String getASSORT_NM() {
		return ASSORT_NM;
	}
	public void setASSORT_NM(String aSSORT_NM) {
		ASSORT_NM = aSSORT_NM;
	}	
	public String getANSW() {
		return ANSW;
	}
	public void setANSW(String aNSW) {
		ANSW = aNSW;
	}
	public int getQUES_SEQNO() {
		return QUES_SEQNO;
	}
	public void setQUES_SEQNO(int qUES_SEQNO) {
		QUES_SEQNO = qUES_SEQNO;
	}
	public String getASSORT_CD() {
		return ASSORT_CD;
	}
	public void setASSORT_CD(String aSSORT_CD) {
		ASSORT_CD = aSSORT_CD;
	}
	public String getTITLE() {
		return TITLE;
	}
	public void setTITLE(String tITLE) {
		TITLE = tITLE;
	}
	public String getCONT() {
		return CONT;
	}
	public void setCONT(String cONT) {
		CONT = cONT;
	}
	public String getEMAIL() {
		return EMAIL;
	}
	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}
	public String getHTEL() {
		return HTEL;
	}
	public void setHTEL(String hTEL) {
		HTEL = hTEL;
	}
	public String getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}
	public String getEMAIL_RECV_YN() {
		return EMAIL_RECV_YN;
	}
	public void setEMAIL_RECV_YN(String eMAIL_RECV_YN) {
		EMAIL_RECV_YN = eMAIL_RECV_YN;
	}
	public String getSMS_RECV_YN() {
		return SMS_RECV_YN;
	}
	public void setSMS_RECV_YN(String sMS_RECV_YN) {
		SMS_RECV_YN = sMS_RECV_YN;
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
