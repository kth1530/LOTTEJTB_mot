package com.lottejtb.mytour.service;

import com.lottejtb.comm.service.CommDefaultVO;

public class FaFitCounselAnswVO extends CommDefaultVO {

	private static final long serialVersionUID = 6089886075341695833L;

	private int QUES_SEQNO = 0;
	private String CONT = "";
	private String REGTOR_ID = "";
	private String REG_DTT = "";
	private String MODTOR_ID = "";
	
	private String MOD_DTT = "";

	public int getQUES_SEQNO() {
		return QUES_SEQNO;
	}

	public void setQUES_SEQNO(int qUES_SEQNO) {
		QUES_SEQNO = qUES_SEQNO;
	}

	public String getCONT() {
		return CONT;
	}

	public void setCONT(String cONT) {
		CONT = cONT;
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
