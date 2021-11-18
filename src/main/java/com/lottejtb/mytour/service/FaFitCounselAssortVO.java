package com.lottejtb.mytour.service;

import com.lottejtb.comm.service.CommDefaultVO;

public class FaFitCounselAssortVO extends CommDefaultVO {

	private static final long serialVersionUID = -7347710077157149332L;
	
	private String ASSORT_CD = "";
	private String ASSORT_NM = "";
	private String PARENT_ASSORT_CD = "";
	private String USE_YN = "";
	private String REGTOR_ID = "";
	
	private String REG_DTT = "";	
	private String MODTOR_ID = "";
	private String MOD_DTT = "";
	private int ASSORT_LEVEL = 0;
	
	public String getASSORT_CD() {
		return ASSORT_CD;
	}
	public void setASSORT_CD(String aSSORT_CD) {
		ASSORT_CD = aSSORT_CD;
	}
	public String getASSORT_NM() {
		return ASSORT_NM;
	}
	public void setASSORT_NM(String aSSORT_NM) {
		ASSORT_NM = aSSORT_NM;
	}
	public String getPARENT_ASSORT_CD() {
		return PARENT_ASSORT_CD;
	}
	public void setPARENT_ASSORT_CD(String pARENT_ASSORT_CD) {
		PARENT_ASSORT_CD = pARENT_ASSORT_CD;
	}
	public String getUSE_YN() {
		return USE_YN;
	}
	public void setUSE_YN(String uSE_YN) {
		USE_YN = uSE_YN;
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
	public int getASSORT_LEVEL() {
		return ASSORT_LEVEL;
	}
	public void setASSORT_LEVEL(int aSSORT_LEVEL) {
		ASSORT_LEVEL = aSSORT_LEVEL;
	}

	
}
