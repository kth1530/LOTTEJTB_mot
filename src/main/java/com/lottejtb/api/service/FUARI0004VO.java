package com.lottejtb.api.service;

public class FUARI0004VO {
	private HeaderVO headDto = new HeaderVO();
	private BodyVO bodyDto = new BodyVO();
	
	private int errCd;
	private String errTy;
	private String errMsg;
	private String sysErrCd;
	private String programId;
	
	public BodyVO getBodyDto() {
		return bodyDto;
	}
	public void setBodyDto(BodyVO bodyDto) {
		this.bodyDto = bodyDto;
	}
	public HeaderVO getHeadDto() {
		return headDto;
	}
	public void setHeadDto(HeaderVO headDto) {
		this.headDto = headDto;
	}
	public int getErrCd() {
		return errCd;
	}
	public void setErrCd(int errCd) {
		this.errCd = errCd;
	}
	public String getErrTy() {
		return errTy;
	}
	public void setErrTy(String errTy) {
		this.errTy = errTy;
	}
	public String getErrMsg() {
		return errMsg;
	}
	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}
	public String getSysErrCd() {
		return sysErrCd;
	}
	public void setSysErrCd(String sysErrCd) {
		this.sysErrCd = sysErrCd;
	}
	public String getProgramId() {
		return programId;
	}
	public void setProgramId(String programId) {
		this.programId = programId;
	}	
}
