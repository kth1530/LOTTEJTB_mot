package com.lottejtb.front.air.service;

// 현지 연락처 정보  

public class ReqAirContactVO {

	private float paxNo = 0;					// 탑승자 번호 
	private String paxTy = "";				// 탑승자 유형 
	private String ctCd = "";				// 도시 코드 
	private String localContact = "";		// 현지 연락처 	
	private String paxContact = "";			// 탑승객 연락처 
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
	public String getCtCd() {
		return ctCd;
	}
	public void setCtCd(String ctCd) {
		this.ctCd = ctCd;
	}
	public String getLocalContact() {
		return localContact;
	}
	public void setLocalContact(String localContact) {
		this.localContact = localContact;
	}
	public String getPaxContact() {
		return paxContact;
	}
	public void setPaxContact(String paxContact) {
		this.paxContact = paxContact;
	}
	


}
