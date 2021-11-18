package com.lottejtb.api.service;

public class AvailDataVO {	
	private String 	arrCd;		//20161220 변경 arrCtCd -> arrCd
	private String 	arrDt;		
	private String 	arrNm;		//20161220 변경 arrCtNm -> arrNm
	private String 	arrTerminalNo;
	private String 	arrTm;
	private String 	availEFT;
	private int 	availNo;
	private String 	bookingClas;
	private String 	cabinClas;
	private String 	carrierCd;
	private String 	carrierNm;
	//private String cabinStatusCd;	20161220 삭제
	private String 	codeShare;
	private String 	codeShareNm;
	private String 	depCd;		//20161220 변경 depCtCd -> depCd
	private String 	depDt;
	private String 	depNm;		//20161220 변경 depCtCd -> depNm
	private String 	depTerminalNo;
	private String 	depTm;
	private String 	eTketYn;
	private String 	fareBasis;
	private String 	fltEquip;
	private String 	fltNo;
	private String 	freeBaggage;	// 20161220 변경 freeBaggageAllow -> freeBaggage
	private String 	mealServiceCd;
	private String 	opCarrierCd;
	private String 	opCarrierNm;
	//private int	paxCnt;			20161220 삭제
	private int 	segNo;
	private String  cnxTy;
	
	//private ArrayList<FareRuleInfoVO> fareRuleInfoGroup = new ArrayList<FareRuleInfoVO>();	20161220 삭제
	
	
	public String getOpCarrierNm() {
		return opCarrierNm;
	}
	public String getCnxTy() {
		return cnxTy;
	}
	public void setCnxTy(String cnxTy) {
		this.cnxTy = cnxTy;
	}
	public void setOpCarrierNm(String opCarrierNm) {
		this.opCarrierNm = opCarrierNm;
	}
	public String getArrDt() {
		return arrDt;
	}
	public void setArrDt(String arrDt) {
		this.arrDt = arrDt;
	}
	public String getArrTerminalNo() {
		return arrTerminalNo;
	}
	public void setArrTerminalNo(String arrTerminalNo) {
		this.arrTerminalNo = arrTerminalNo;
	}
	public String getDepNm() {
		return depNm;
	}
	public void setDepNm(String depNm) {
		this.depNm = depNm;
	}
	public String getCodeShareNm() {
		return codeShareNm;
	}
	public void setCodeShareNm(String codeShareNm) {
		this.codeShareNm = codeShareNm;
	}
	public String getCodeShare() {
		return codeShare;
	}
	public void setCodeShare(String codeShare) {
		this.codeShare = codeShare;
	}
	public String getDepTm() {
		return depTm;
	}
	public void setDepTm(String depTm) {
		this.depTm = depTm;
	}
	public String getArrNm() {
		return arrNm;
	}
	public void setArrNm(String arrNm) {
		this.arrNm = arrNm;
	}
	public String getFltEquip() {
		return fltEquip;
	}
	public void setFltEquip(String fltEquip) {
		this.fltEquip = fltEquip;
	}
	public String getArrCd() {
		return arrCd;
	}
	public void setArrCd(String arrCd) {
		this.arrCd = arrCd;
	}
	public String getDepDt() {
		return depDt;
	}
	public void setDepDt(String depDt) {
		this.depDt = depDt;
	}
	public String getCarrierCd() {
		return carrierCd;
	}
	public void setCarrierCd(String carrierCd) {
		this.carrierCd = carrierCd;
	}
	public String getAvailEFT() {
		return availEFT;
	}
	public void setAvailEFT(String availEFT) {
		this.availEFT = availEFT;
	}
	public int getAvailNo() {
		return availNo;
	}
	public void setAvailNo(int availNo) {
		this.availNo = availNo;
	}
	public int getSegNo() {
		return segNo;
	}
	public void setSegNo(int segNo) {
		this.segNo = segNo;
	}
	public String getDepCd() {
		return depCd;
	}
	public void setDepCtCd(String depCd) {
		this.depCd = depCd;
	}
	public String getArrTm() {
		return arrTm;
	}
	public void setArrTm(String arrTm) {
		this.arrTm = arrTm;
	}
	public String getDepTerminalNo() {
		return depTerminalNo;
	}
	public void setDepTerminalNo(String depTerminalNo) {
		this.depTerminalNo = depTerminalNo;
	}
	public String getFltNo() {
		return fltNo;
	}
	public void setFltNo(String fltNo) {
		this.fltNo = fltNo;
	}
	public String getBookingClas() {
		return bookingClas;
	}
	public void setBookingClas(String bookingClas) {
		this.bookingClas = bookingClas;
	}
	public String getOpCarrierCd() {
		return opCarrierCd;
	}
	public void setOpCarrierCd(String opCarrierCd) {
		this.opCarrierCd = opCarrierCd;
	}
	public String getCarrierNm() {
		return carrierNm;
	}
	public void setCarrierNm(String carrierNm) {
		this.carrierNm = carrierNm;
	}
	public String geteTketYn() {
		return eTketYn;
	}
	public void seteTketYn(String eTketYn) {
		this.eTketYn = eTketYn;
	}
	public void setCabinClas(String cabinClas) {
		this.cabinClas = cabinClas;
	}
	public String getCabinClas() {
		return cabinClas;
	}
	public void setMealServiceCd(String mealServiceCd) {
		this.mealServiceCd = mealServiceCd;
	}
	public String getMealServiceCd() {
		return mealServiceCd;
	}
	public void setFreeBaggage(String freeBaggage) {
		this.freeBaggage = freeBaggage;
	}
	public String getFreeBaggage() {
		return freeBaggage;
	}
	public void setFareBasis(String fareBasis) {
		this.fareBasis = fareBasis;
	}
	public String getFareBasis() {
		return fareBasis;
	}
}
