package com.lottejtb.front.air.service;

// 항공 마일리지 정보 

public class ReqAirMileageVO {
	private float paxNo = 0; 						// 탑승자 번호 
	private String paxTy = "";					// 탑승자 유형
	private String mileageNo = "";				// 마일리지 번호  
	private String carrierCd = "";				// 적랍 항공사 코드 
	private String sendYn = "";					// 전송 여부 
	
	public ReqAirMileageVO() {
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

	public String getMileageNo() {
		return mileageNo;
	}

	public void setMileageNo(String mileageNo) {
		this.mileageNo = mileageNo;
	}

	public String getCarrierCd() {
		return carrierCd;
	}

	public void setCarrierCd(String carrierCd) {
		this.carrierCd = carrierCd;
	}

	public String getSendYn() {
		return sendYn;
	}

	public void setSendYn(String sendYn) {
		this.sendYn = sendYn;
	}

	
}
