package com.lottejtb.api.service;

import java.util.ArrayList;

public class FUARI0006DataVO {
		
	private String currency;
	private int fareCharge;
	private String paxTy;
	private int penaltyCharge;
	private int sellCharge;
	private String fuelCharge;
	private String taxCharge;
	

	private ArrayList<AvailDataVO> segmentGroup = new ArrayList<AvailDataVO>() ;	//20161220 변경 availDataBean -> segmentGroup
	//private ArrayList<PricingDataVO> pricingGroup = new ArrayList<PricingDataVO>();
	
	public ArrayList<AvailDataVO> getSegmentGroup() {
		return segmentGroup;
	}
	public String getTaxCharge() {
		return taxCharge;
	}
	public void setTaxCharge(String taxCharge) {
		this.taxCharge = taxCharge;
	}
	public void setSegmentGroup(ArrayList<AvailDataVO> segmentGroup) {
		this.segmentGroup = segmentGroup;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public int getFareCharge() {
		return fareCharge;
	}
	public void setFareCharge(int fareCharge) {
		this.fareCharge = fareCharge;
	}
	public String getPaxTy() {
		return paxTy;
	}
	public void setPaxTy(String paxTy) {
		this.paxTy = paxTy;
	}
	public int getPenaltyCharge() {
		return penaltyCharge;
	}
	public void setPenaltyCharge(int penaltyCharge) {
		this.penaltyCharge = penaltyCharge;
	}
	public int getSellCharge() {
		return sellCharge;
	}
	public void setSellCharge(int sellCharge) {
		this.sellCharge = sellCharge;
	}
	public String getFuelCharge() {
		return fuelCharge;
	}
	public void setFuelCharge(String fuelCharge) {
		this.fuelCharge = fuelCharge;
	}
}
