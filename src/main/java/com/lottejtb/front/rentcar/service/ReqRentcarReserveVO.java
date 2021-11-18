package com.lottejtb.front.rentcar.service;

import java.util.ArrayList;

public class ReqRentcarReserveVO{
	private String operAgeGb;
	private String operSurNm;
	private String operGivenNm;
	private String telAreaNo;
	private String telNo;
	private String emailAddr;
	private String userId;
	
	private ArrayList<ReqRentcarCarVO> carInfo = new ArrayList<ReqRentcarCarVO>();

	public String getOperAgeGb() {
		return operAgeGb;
	}

	public void setOperAgeGb(String operAgeGb) {
		this.operAgeGb = operAgeGb;
	}

	public String getOperSurNm() {
		return operSurNm;
	}

	public void setOperSurNm(String operSurNm) {
		this.operSurNm = operSurNm;
	}

	public String getOperGivenNm() {
		return operGivenNm;
	}

	public void setOperGivenNm(String operGivenNm) {
		this.operGivenNm = operGivenNm;
	}

	public String getTelAreaNo() {
		return telAreaNo;
	}

	public void setTelAreaNo(String telAreaNo) {
		this.telAreaNo = telAreaNo;
	}

	public String getTelNo() {
		return telNo;
	}

	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}

	public String getEmailAddr() {
		return emailAddr;
	}

	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public ArrayList<ReqRentcarCarVO> getCarInfo() {
		return carInfo;
	}

	public void setCarInfo(ArrayList<ReqRentcarCarVO> carInfo) {
		this.carInfo = carInfo;
	}
}
