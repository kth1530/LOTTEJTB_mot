package com.lottejtb.api.service;

import java.util.ArrayList;

public class FUARI0001DataVO {
	private int availNo;
	private int segNo;
	
	private ArrayList<FareRuleInfoVO> fareRuleInfoDataBean = new ArrayList<FareRuleInfoVO>();
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

	public ArrayList<FareRuleInfoVO> getFareRuleInfoDataBean() {
		return fareRuleInfoDataBean;
	}

	public void setFareRuleInfoDataBean(
			ArrayList<FareRuleInfoVO> fareRuleInfoDataBean) {
		this.fareRuleInfoDataBean = fareRuleInfoDataBean;
	}
}
