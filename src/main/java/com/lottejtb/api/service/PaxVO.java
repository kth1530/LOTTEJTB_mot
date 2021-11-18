package com.lottejtb.api.service;

public class PaxVO {
	private String birthDt;				//생년월일
	private String cabinClas;			//좌석클래스
	private String enFirstNm;			//영문 이름
	private String enSurNm;				//영문 성
	private int fare;					//운임료
	private String freeBaggageAllow;	//무료수화물
	private String genderGb;			//성별
	private String ltd;					//운임 유효기간
	private int parentPaxNo;			//부모탑승자번호
	private float paxNo;					//탑승자번호
	private String paxTy;				//탑승자유형
	private int tax;					//세금
	private String tketNo;				//티켓번호
	
	
	public String getBirthDt() {
		return birthDt;
	}
	public void setBirthDt(String birthDt) {
		this.birthDt = birthDt;
	}
	public String getCabinClas() {
		return cabinClas;
	}
	public void setCabinClas(String cabinClas) {
		this.cabinClas = cabinClas;
	}
	public String getEnFirstNm() {
		return enFirstNm;
	}
	public void setEnFirstNm(String enFirstNm) {
		this.enFirstNm = enFirstNm;
	}
	public String getEnSurNm() {
		return enSurNm;
	}
	public void setEnSurNm(String enSurNm) {
		this.enSurNm = enSurNm;
	}
	public int getFare() {
		return fare;
	}
	public void setFare(int fare) {
		this.fare = fare;
	}
	public String getFreeBaggageAllow() {
		return freeBaggageAllow;
	}
	public void setFreeBaggageAllow(String freeBaggageAllow) {
		this.freeBaggageAllow = freeBaggageAllow;
	}
	public String getGenderGb() {
		return genderGb;
	}
	public void setGenderGb(String genderGb) {
		this.genderGb = genderGb;
	}
	public String getLtd() {
		return ltd;
	}
	public void setLtd(String ltd) {
		this.ltd = ltd;
	}
	public int getParentPaxNo() {
		return parentPaxNo;
	}
	public void setParentPaxNo(int parentPaxNo) {
		this.parentPaxNo = parentPaxNo;
	}
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
	public int getTax() {
		return tax;
	}
	public void setTax(int tax) {
		this.tax = tax;
	}
	public String getTketNo() {
		return tketNo;
	}
	public void setTketNo(String tketNo) {
		this.tketNo = tketNo;
	}
}
