package com.lottejtb.front.air.service;

public class ReqAirSegmentVO{
	private String 	arrCd;
	private String 	arrDt;
	private String 	arrTm;
	private int 	availNo;
	private String 	bookingClas;
	private String 	carrierCd;
	private String 	depCd;
	private String 	depDt;
	private String 	depTm;
	private String 	fltEquip;
	private String 	fltNo;
	private int 	segNo;
	private String  cnxTy;
	
	/** 예약 처리 정보 추가 */
	private String	opCarrierCd;	// 운행 항공사 코드
	private String	eTketYn;		// 전자티켓여부
	private String	depTerminal;	// 탑승터미널
	private String	arrTerminal;	// 출구터미널
	private String	codeShare;		// 코드셰어
	private String	codeShareNm;	// 코드셰어명
	private String	cabinClas;		// 좌석등급코드
	private String	durationTm;		// 비행지속시간
	
	public String getCnxTy() {
		return cnxTy;
	}
	public void setCnxTy(String cnxTy) {
		this.cnxTy = cnxTy;
	}
	public String getArrCd() {
		return arrCd;
	}
	public String getOpCarrierCd() {
		return opCarrierCd;
	}
	public void setOpCarrierCd(String opCarrierCd) {
		this.opCarrierCd = opCarrierCd;
	}
	public String geteTketYn() {
		return eTketYn;
	}
	public void seteTketYn(String eTketYn) {
		this.eTketYn = eTketYn;
	}
	public String getDepTerminal() {
		return depTerminal;
	}
	public void setDepTerminal(String depTerminal) {
		this.depTerminal = depTerminal;
	}
	public String getArrTerminal() {
		return arrTerminal;
	}
	public void setArrTerminal(String arrTerminal) {
		this.arrTerminal = arrTerminal;
	}
	public String getCodeShare() {
		return codeShare;
	}
	public void setCodeShare(String codeShare) {
		this.codeShare = codeShare;
	}
	public String getCodeShareNm() {
		return codeShareNm;
	}
	public void setCodeShareNm(String codeShareNm) {
		this.codeShareNm = codeShareNm;
	}
	public String getCabinClas() {
		return cabinClas;
	}
	public void setCabinClas(String cabinClas) {
		this.cabinClas = cabinClas;
	}
	public String getDurationTm() {
		return durationTm;
	}
	public void setDurationTm(String durationTm) {
		this.durationTm = durationTm;
	}
	public void setArrCd(String arrCd) {
		this.arrCd = arrCd;
	}
	public String getArrDt() {
		return arrDt;
	}
	public void setArrDt(String arrDt) {
		this.arrDt = arrDt;
	}
	public String getArrTm() {
		return arrTm;
	}
	public void setArrTm(String arrTm) {
		this.arrTm = arrTm;
	}
	public int getAvailNo() {
		return availNo;
	}
	public void setAvailNo(int availNo) {
		this.availNo = availNo;
	}
	public String getBookingClas() {
		return bookingClas;
	}
	public void setBookingClas(String bookingClas) {
		this.bookingClas = bookingClas;
	}
	public String getCarrierCd() {
		return carrierCd;
	}
	public void setCarrierCd(String carrierCd) {
		this.carrierCd = carrierCd;
	}
	public String getDepCd() {
		return depCd;
	}
	public void setDepCd(String depCd) {
		this.depCd = depCd;
	}
	public String getDepDt() {
		return depDt;
	}
	public void setDepDt(String depDt) {
		this.depDt = depDt;
	}
	public String getDepTm() {
		return depTm;
	}
	public void setDepTm(String depTm) {
		this.depTm = depTm;
	}
	public String getFltEquip() {
		return fltEquip;
	}
	public void setFltEquip(String fltEquip) {
		this.fltEquip = fltEquip;
	}
	public String getFltNo() {
		return fltNo;
	}
	public void setFltNo(String fltNo) {
		this.fltNo = fltNo;
	}
	public int getSegNo() {
		return segNo;
	}
	public void setSegNo(int segNo) {
		this.segNo = segNo;
	}
}
