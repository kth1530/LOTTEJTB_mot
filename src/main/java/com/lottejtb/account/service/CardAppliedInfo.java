package com.lottejtb.account.service;

public class CardAppliedInfo {
	private String month;

	private String limitAmt;

	private String noInterestRate;

	private String comYN;

	public CardAppliedInfo(int month) {
		this(month, "0", "0", "N");
	}

	public CardAppliedInfo(int month, String limitAmt, String noInterestRate,
			String comYN) {
		if (month == 1)
			this.month = "lumpsum";
		else
			this.month = month + "term";
		this.limitAmt = limitAmt;
		this.noInterestRate = noInterestRate;
		this.comYN = comYN;
	}

	public String getMonth() {
		return month;
	}
	
	public boolean isNoInterestWithTerm(){
		if ("0".equals(noInterestRate)) {
			return false;
		} else {
			return true;
		}		
	}

	public String toString() {
		if ("0".equals(noInterestRate)) {
			return this.month;
		} else {
			return this.month + "(limit: " + this.limitAmt + ")";
		}

	}

	public String getComYN() {
		return comYN;
	}

	public void setComYN(String comYN) {
		this.comYN = comYN;
	}

	public String getLimitAmt() {
		return limitAmt;
	}

	public void setLimitAmt(String limitAmt) {
		this.limitAmt = limitAmt;
	}

	public String getNoInterestRate() {
		return noInterestRate;
	}

	public void setNoInterestRate(String noInterestRate) {
		this.noInterestRate = noInterestRate;
	}

}
