package com.lottejtb.api.service;

public class FlightInfoDataVO {	
	private String 	arrCd;		//20161220 변경 arrCtCd -> arrCd
	private String 	arrDt;		
	private String 	arrTm;
	private String 	depCd;		//20161220 변경 depCtCd -> depCd
	private String 	depDt;
	private String 	depTm;
	private String 	durationTm;
	private int 	flightSeqno;
	private String 	fltEquip;
	private String 	waitTm;
		
	
	public int getFlightSeqno() {
		return flightSeqno;
	}
	public void setFlightSeqno(int flightSeqno) {
		this.flightSeqno = flightSeqno;
	}
	public String getWaitTm() {
		return waitTm;
	}
	public void setWaitTm(String waitTm) {
		this.waitTm = waitTm;
	}
	public String getArrCd() {
		return arrCd;
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
	public String getDurationTm() {
		return durationTm;
	}
	public void setDurationTm(String durationTm) {
		this.durationTm = durationTm;
	}
	public String getFltEquip() {
		return fltEquip;
	}
	public void setFltEquip(String fltEquip) {
		this.fltEquip = fltEquip;
	}
}
