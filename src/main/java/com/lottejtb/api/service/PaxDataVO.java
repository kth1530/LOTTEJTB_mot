package com.lottejtb.api.service;

import java.util.ArrayList;

public class PaxDataVO {	
	
	private String bookingClas;
	private String cabinClas;
	private int fareCharge;	//20161220 변경 fare-> fareCharge
	//private String currency;	20161220 삭제
	//private String dateOfBirth;	20161220 삭제
	//private String enFirstNm;	20161220 삭제
	//private String enSurNm;	20161220 삭제
	private String ltd;
	private int paxCnt;	//20161220 추가
	private float paxNo;
	private String paxTy;
	private int penAmount;
	//private String tatooNo;	20161220 삭제
	private int taxCharge;	//20161220 변경 tax-> taxCharge
	private int tasfCharge;	//2017-03-27 추가
	//private String title;
	private String vCarrierCd; // 2017-04-11 추가 
	private String fuelCharge;
	
	private ArrayList<FareDataVO> fareDataBean = new ArrayList<FareDataVO>();

	
	public String getFuelCharge() {
		return fuelCharge;
	}

	public void setFuelCharge(String fuelCharge) {
		this.fuelCharge = fuelCharge;
	}

	public String getLtd() {
		return ltd;
	}

	public void setLtd(String ltd) {
		this.ltd = ltd;
	}

	public int getPenAmount() {
		return penAmount;
	}

	public void setPenAmount(int penAmount) {
		this.penAmount = penAmount;
	}

	public String getBookingClas() {
		return bookingClas;
	}

	public void setBookingClas(String bookingClas) {
		this.bookingClas = bookingClas;
	}

	public String getCabinClas() {
		return cabinClas;
	}

	public void setCabinClas(String cabinClas) {
		this.cabinClas = cabinClas;
	}

	public int getFareCharge() {
		return fareCharge;
	}

	public void setFareCharge(int fareCharge) {
		this.fareCharge = fareCharge;
	}

	public int getPaxCnt() {
		return paxCnt;
	}

	public void setPaxCnt(int paxCnt) {
		this.paxCnt = paxCnt;
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

	public int getTaxCharge() {
		return taxCharge;
	}

	public void setTaxCharge(int taxCharge) {
		this.taxCharge = taxCharge;
	}

	public ArrayList<FareDataVO> getFareDataBean() {
		return fareDataBean;
	}

	public void setFareDataBean(ArrayList<FareDataVO> fareDataBean) {
		this.fareDataBean = fareDataBean;
	}

	public int getTasfCharge() {
		return tasfCharge;
	}

	public void setTasfCharge(int tasfCharge) {
		this.tasfCharge = tasfCharge;
	}

	public String getvCarrierCd() {
		return vCarrierCd;
	}

	public void setvCarrierCd(String vCarrierCd) {
		this.vCarrierCd = vCarrierCd;
	}
	
	
}
