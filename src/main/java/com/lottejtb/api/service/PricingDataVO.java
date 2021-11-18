package com.lottejtb.api.service;

public class PricingDataVO {	
	
	private String currency;
	private int fareCharge;
	private String paxTy;
	private int sellCharge;
	private String fuelCharge;
	
	public String getFuelCharge() {
		return fuelCharge;
	}
	public void setFuelCharge(String fuelCharge) {
		this.fuelCharge = fuelCharge;
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
	public int getSellCharge() {
		return sellCharge;
	}
	public void setSellCharge(int sellCharge) {
		this.sellCharge = sellCharge;
	}
}
