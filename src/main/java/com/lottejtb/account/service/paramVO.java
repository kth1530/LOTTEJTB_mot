package com.lottejtb.account.service;

public class paramVO {
	
	private String SETT_CD				=	"";	//	결재수단
	private String SETT_DET_CD			=	"";	//	결재수단코드
	private String USE_YN				=	"";	//	사용여부 N:사용안함 Y:사용함
	
	private String CONF_DAY				=	"";	//

	public String getSETT_CD() {
		return SETT_CD;
	}
	public void setSETT_CD(String sETT_CD) {
		SETT_CD = sETT_CD;
	}
	public String getSETT_DET_CD() {
		return SETT_DET_CD;
	}
	public void setSETT_DET_CD(String sETT_DET_CD) {
		SETT_DET_CD = sETT_DET_CD;
	}
	public String getUSE_YN() {
		return USE_YN;
	}
	public void setUSE_YN(String uSE_YN) {
		USE_YN = uSE_YN;
	}
	
	public String getCONF_DAY() {
		return CONF_DAY;
	}
	public void setCONF_DAY(String cONF_DAY) {
		CONF_DAY = cONF_DAY;
	}
	
}
