package com.lottejtb.front.air.service;

public class ReqAirAddressVO {
	
	private float paxNo = 0.0f;				// 탑승자 번호 
	private String paxTy = "";			// 탑승자 유형 
	private String addressTy = "";		// 주소 구분 
	private String ntCd = "";			// 체류 나라 
	private String ctCd = "";			// 체류 도시코드 
	private String ctCdNm = "";			// 체류 도시명 
	private String stateCd = "";			// 체류 주 코드 
	private String postCd = "";			// 우편번호 
	private String address = "";			// 세부주소 
	private String undecideYn = "";		// 미확정여부 
	
	public ReqAirAddressVO() {
		// TODO Auto-generated constructor stub
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

	public String getAddressTy() {
		return addressTy;
	}

	public void setAddressTy(String addressTy) {
		this.addressTy = addressTy;
	}

	public String getNtCd() {
		return ntCd;
	}

	public void setNtCd(String ntCd) {
		this.ntCd = ntCd;
	}

	public String getCtCd() {
		return ctCd;
	}

	public void setCtCd(String ctCd) {
		this.ctCd = ctCd;
	}

	public String getCtCdNm() {
		return ctCdNm;
	}

	public void setCtCdNm(String ctCdNm) {
		this.ctCdNm = ctCdNm;
	}

	public String getStateCd() {
		return stateCd;
	}

	public void setStateCd(String stateCd) {
		this.stateCd = stateCd;
	}

	public String getPostCd() {
		return postCd;
	}

	public void setPostCd(String postCd) {
		this.postCd = postCd;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getUndecideYn() {
		return undecideYn;
	}

	public void setUndecideYn(String undecideYn) {
		this.undecideYn = undecideYn;
	}


}
