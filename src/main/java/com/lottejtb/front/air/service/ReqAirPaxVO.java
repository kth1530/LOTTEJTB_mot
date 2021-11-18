package com.lottejtb.front.air.service;

import java.util.ArrayList;

public class ReqAirPaxVO {
	private float 	paxNo;				//탑승자번호
	private String 	paxTy;				//탑승자유형
	private String 	krPaxNm;			//한글 탑승자
	private String 	enSurNm;			//영문 성
	private String 	enFirstNm;			//영문 이름
	private String 	dateOfBirth;		//생년월일
	private String 	paxTel;				//탑승자 연락처
	private String 	paxEmail;			//탑승자 이메일
	private String 	gender;				//성별
	private String 	passportYn;			//여권유무
	private String 	fareCharge;			//운임료
	private String 	taxCharge;			//세금
	private String 	bookingClas;		//부킹클래스
	private String  cabinClas;
	private String  vCarrierCd; 			// 탑승자 데이타빈.운행항공사 코드 
	private String  discntCharge;		// 할인금액 [2017.05.03] 추가
	private String	fuelSurcharge;		// 유료할증료 [2017.05.03] 추가
	private String	qCharge;				// Q Charge [2017.05.03] 추가
	private String	upCharge;			// 업 금액 [2017.05.03] 추가
	private String	pmoDiscntCharge;		// 프로모션 할인금액 [2017.05.03] 추가
	private String	pmoUpCharge;			// 프로모션 업금액 [2017.05.03] 추가
	
	private ArrayList<ReqAirFareVO> fareDataBean = new ArrayList<ReqAirFareVO>();

	public String getvCarrierCd() {
		return vCarrierCd;
	}

	public void setvCarrierCd(String vCarrierCd) {
		this.vCarrierCd = vCarrierCd;
	}
	
	public String getCabinClas() {
		return cabinClas;
	}

	public void setCabinClas(String cabinClas) {
		this.cabinClas = cabinClas;
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

	public String getKrPaxNm() {
		return krPaxNm;
	}

	public void setKrPaxNm(String krPaxNm) {
		this.krPaxNm = krPaxNm;
	}

	public String getEnSurNm() {
		return enSurNm;
	}

	public void setEnSurNm(String enSurNm) {
		this.enSurNm = enSurNm;
	}

	public String getEnFirstNm() {
		return enFirstNm;
	}

	public void setEnFirstNm(String enFirstNm) {
		this.enFirstNm = enFirstNm;
	}

	public String getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getPaxTel() {
		return paxTel;
	}

	public void setPaxTel(String paxTel) {
		this.paxTel = paxTel;
	}

	public String getPaxEmail() {
		return paxEmail;
	}

	public void setPaxEmail(String paxEmail) {
		this.paxEmail = paxEmail;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPassportYn() {
		return passportYn;
	}

	public void setPassportYn(String passportYn) {
		this.passportYn = passportYn;
	}

	public String getFareCharge() {
		return fareCharge;
	}

	public void setFareCharge(String fareCharge) {
		this.fareCharge = fareCharge;
	}

	public String getTaxCharge() {
		return taxCharge;
	}

	public void setTaxCharge(String taxCharge) {
		this.taxCharge = taxCharge;
	}

	public String getBookingClas() {
		return bookingClas;
	}

	public void setBookingClas(String bookingClas) {
		this.bookingClas = bookingClas;
	}

	public ArrayList<ReqAirFareVO> getFareDataBean() {
		return fareDataBean;
	}

	public void setFareDataBean(ArrayList<ReqAirFareVO> fareDataBean) {
		this.fareDataBean = fareDataBean;
	}

	public String getDiscntCharge() {
		return discntCharge;
	}

	public void setDiscntCharge(String discntCharge) {
		this.discntCharge = discntCharge;
	}

	public String getFuelSurcharge() {
		return fuelSurcharge;
	}

	public void setFuelSurcharge(String fuelSurcharge) {
		this.fuelSurcharge = fuelSurcharge;
	}

	public String getqCharge() {
		return qCharge;
	}

	public void setqCharge(String qCharge) {
		this.qCharge = qCharge;
	}

	public String getUpCharge() {
		return upCharge;
	}

	public void setUpCharge(String upCharge) {
		this.upCharge = upCharge;
	}

	public String getPmoDiscntCharge() {
		return pmoDiscntCharge;
	}

	public void setPmoDiscntCharge(String pmoDiscntCharge) {
		this.pmoDiscntCharge = pmoDiscntCharge;
	}

	public String getPmoUpCharge() {
		return pmoUpCharge;
	}

	public void setPmoUpCharge(String pmoUpCharge) {
		this.pmoUpCharge = pmoUpCharge;
	} 
}
