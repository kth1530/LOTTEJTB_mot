package com.lottejtb.api.service;

import java.util.ArrayList;

public class FUARI0002DataVO {
	private String carrierCd;
	private String carrierNm;
	private String currency;
	private String gdsCd;
	private int numOfStops;
	private String paxTy;
	private String stopYn;
	private String ruleKey;
	private String fmsKey;
	//private int totFualCharge;		2016-12-20 삭제
	private int totSaleCharge;
	private int totTaxCharge;
	private int totTasfCharge;		//2017-03-27 추가
	private String fuelSurcharge;
	
	private ArrayList<AvailDataVO> segmentGroup = new ArrayList<AvailDataVO>() ;	//20161220 변경 availDataBean -> segmentGroup
	private ArrayList<PaxDataVO> paxDataBean = new ArrayList<PaxDataVO>();
	
	
	public ArrayList<PaxDataVO> getPaxDataBean() {
		return paxDataBean;
	}
	public void setPaxDataBean(ArrayList<PaxDataVO> paxDataBean) {
		this.paxDataBean = paxDataBean;
	}
	public String getGdsCd() {
		return gdsCd;
	}
	public void setGdsCd(String gdsCd) {
		this.gdsCd = gdsCd;
	}
	public int getTotTaxCharge() {
		return totTaxCharge;
	}
	public void setTotTaxCharge(int totTaxCharge) {
		this.totTaxCharge = totTaxCharge;
	}
	public int getNumOfStops() {
		return numOfStops;
	}
	public void setNumOfStops(int numOfStops) {
		this.numOfStops = numOfStops;
	}
	public String getCarrierCd() {
		return carrierCd;
	}
	public void setCarrierCd(String carrierCd) {
		this.carrierCd = carrierCd;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public String getStopYn() {
		return stopYn;
	}
	public void setStopYn(String stopYn) {
		this.stopYn = stopYn;
	}
	public int getTotSaleCharge() {
		return totSaleCharge;
	}
	public void setTotSaleCharge(int totSaleCharge) {
		this.totSaleCharge = totSaleCharge;
	}
	public String getCarrierNm() {
		return carrierNm;
	}
	public void setCarrierNm(String carrierNm) {
		this.carrierNm = carrierNm;
	}
	public void setPaxTy(String paxTy) {
		this.paxTy = paxTy;
	}
	public String getPaxTy() {
		return paxTy;
	}
	public void setSegmentGroup(ArrayList<AvailDataVO> segmentGroup) {
		this.segmentGroup = segmentGroup;
	}
	public ArrayList<AvailDataVO> getSegmentGroup() {
		return segmentGroup;
	}
	public String getRuleKey() {
		return ruleKey;
	}
	public void setRuleKey(String ruleKey) {
		this.ruleKey = ruleKey;
	}
	public String getFmsKey() {
		return fmsKey;
	}
	public void setFmsKey(String fmsKey) {
		this.fmsKey = fmsKey;
	}
	public int getTotTasfCharge() {
		return totTasfCharge;
	}
	public void setTotTasfCharge(int totTasfCharge) {
		this.totTasfCharge = totTasfCharge;
	}
	public String getFuelSurcharge() {
		return fuelSurcharge;
	}
	public void setFuelSurcharge(String fuelSurcharge) {
		this.fuelSurcharge = fuelSurcharge;
	}	
	
	
}
