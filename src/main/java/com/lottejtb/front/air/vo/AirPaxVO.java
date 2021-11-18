package com.lottejtb.front.air.vo;

import java.util.ArrayList;

import com.lottejtb.front.vo.PromotionVo;

public class AirPaxVO {
	private float 	paxNo;				//탑승자번호
	private String 	paxTy;				//탑승자유형
	private String 	paxTyNm;			//탑승자유형명
	private String 	krPaxNm;			//한글 탑승자
	private String 	enSurNm;			//영문 성
	private String 	enFirstNm;			//영문 이름
	private String 	dateOfBirth;		//생년월일
	private String 	paxTel;				//탑승자 연락처
	private String 	paxEmail;			//탑승자 이메일
	private String 	gender;				//성별
	private String 	genderGb;			//성별 코드
	private String 	passportYn;			//여권유무
	private int 	fareCharge;			//운임료
	private int 	taxCharge;			//세금
	private String 	bookingClas;		//부킹클래스
	private String	depDt;
	private int		saleAmt;			// 개별 요금
	private int		tasfAmt;
	private int		paxCnt;
	private String	vCarrierCd;			// 운행항공사 코드
	private int		penAmount;
	private int 	tasfCharge;
	private String	ltd;
	private String	cabinClas;
	private String	aplPromTotal;		//
	private String	promId;
	private String	promTotal;
	private int 	fuelCharge;			// 유류 할증료
	private int		qCharge;			// q 차지
	private int		discntCharge;		// 다운 차지
	private int 	upCharge;			// 업 차지
	private int 	fuelSurcharge;
	
	private PromotionVo promInfo = new PromotionVo();
	private ArrayList<ReqAirFareVO> fareDataBean = new ArrayList<ReqAirFareVO>();

	
	public int getFuelCharge() {
		return fuelCharge;
	}

	public void setFuelCharge(int fuelCharge) {
		this.fuelCharge = fuelCharge;
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

	public int getFareCharge() {
		return fareCharge;
	}

	public void setFareCharge(int fareCharge) {
		this.fareCharge = fareCharge;
	}

	public int getTaxCharge() {
		return taxCharge;
	}

	public void setTaxCharge(int taxCharge) {
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

	public String getDepDt() {
		return depDt;
	}

	public void setDepDt(String depDt) {
		this.depDt = depDt;
	}

	public String getGenderGb() {
		return genderGb;
	}

	public void setGenderGb(String genderGb) {
		this.genderGb = genderGb;
	}

	public int getSaleAmt() {
		return saleAmt;
	}

	public void setSaleAmt(int saleAmt) {
		this.saleAmt = saleAmt;
	}

	public String getPaxTyNm() {
		return paxTyNm;
	}

	public void setPaxTyNm(String paxTyNm) {
		this.paxTyNm = paxTyNm;
	}

	public int getTasfAmt() {
		return tasfAmt;
	}

	public void setTasfAmt(int tasfAmt) {
		this.tasfAmt = tasfAmt;
	}

	public int getPaxCnt() {
		return paxCnt;
	}

	public void setPaxCnt(int paxCnt) {
		this.paxCnt = paxCnt;
	}

	public String getvCarrierCd() {
		return vCarrierCd;
	}

	public void setvCarrierCd(String vCarrierCd) {
		this.vCarrierCd = vCarrierCd;
	}

	public int getPenAmount() {
		return penAmount;
	}

	public void setPenAmount(int penAmount) {
		this.penAmount = penAmount;
	}

	public int getTasfCharge() {
		return tasfCharge;
	}

	public void setTasfCharge(int tasfCharge) {
		this.tasfCharge = tasfCharge;
	}

	public String getLtd() {
		return ltd;
	}

	public void setLtd(String ltd) {
		this.ltd = ltd;
	}

	public String getCabinClas() {
		return cabinClas;
	}

	public void setCabinClas(String cabinClas) {
		this.cabinClas = cabinClas;
	}

	public PromotionVo getPromInfo() {
		return promInfo;
	}

	public void setPromInfo(PromotionVo promInfo) {
		this.promInfo = promInfo;
	}

	public String getAplPromTotal() {
		return aplPromTotal;
	}

	public void setAplPromTotal(String aplPromTotal) {
		this.aplPromTotal = aplPromTotal;
	}

	public String getPromId() {
		return promId;
	}

	public void setPromId(String promId) {
		this.promId = promId;
	}

	public String getPromTotal() {
		return promTotal;
	}

	public void setPromTotal(String promTotal) {
		this.promTotal = promTotal;
	}

	public int getDiscntCharge() {
		return discntCharge;
	}

	public void setDiscntCharge(int discntCharge) {
		this.discntCharge = discntCharge;
	}

	public int getUpCharge() {
		return upCharge;
	}

	public void setUpCharge(int upCharge) {
		this.upCharge = upCharge;
	}

	public int getqCharge() {
		return qCharge;
	}

	public void setqCharge(int qCharge) {
		this.qCharge = qCharge;
	}

	public int getFuelSurcharge() {
		return fuelSurcharge;
	}

	public void setFuelSurcharge(int fuelSurcharge) {
		this.fuelSurcharge = fuelSurcharge;
	}
	
}