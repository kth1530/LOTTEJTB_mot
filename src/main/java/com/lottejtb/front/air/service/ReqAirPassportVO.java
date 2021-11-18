package com.lottejtb.front.air.service;

// 여권 정보 

public class ReqAirPassportVO {
	
	private float paxNo = 0;					// 탑승자 그룹 
	private String paxTy = "";				// 탑승자 번호 
	private String passportNo = "";			// 탑승자 유형 
	private String expiredt = "";			// 여권번호 
	private String ntCd = "";				// 국적
	private String publishNtcd = "";			// 발행국 
	
	
	public float getPaxNo() {
		return paxNo;
	}
	public void setPaxNo(float paxNo) {
		this.paxNo = paxNo;
	}
	public String getPaxTy() {
		return paxTy;
	}
	public void setPaxTy(String paxTy) {
		this.paxTy = paxTy;
	}
	public String getPassportNo() {
		return passportNo;
	}
	public void setPassportNo(String passportNo) {
		this.passportNo = passportNo;
	}
	public String getExpiredt() {
		return expiredt;
	}
	public void setExpiredt(String expiredt) {
		this.expiredt = expiredt;
	}
	public String getNtCd() {
		return ntCd;
	}
	public void setNtCd(String ntCd) {
		this.ntCd = ntCd;
	}
	public String getPublishNtcd() {
		return publishNtcd;
	}
	public void setPublishNtcd(String publishNtcd) {
		this.publishNtcd = publishNtcd;
	}
	
	

}
