package com.lottejtb.api.service;

import java.util.ArrayList;

public class FUARI0005DataVO {
	
	private int availNo;
	private String depDayWeek;
	private String durationTm;
	private int numOfStops;
	private int segNo;
		
	private ArrayList<FlightInfoDataVO> flightInfoDataBean = new ArrayList<FlightInfoDataVO>();

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

	public String getDurationTm() {
		return durationTm;
	}

	public void setDurationTm(String durationTm) {
		this.durationTm = durationTm;
	}

	public int getNumOfStops() {
		return numOfStops;
	}

	public void setNumOfStops(int numOfStops) {
		this.numOfStops = numOfStops;
	}

	public String getDepDayWeek() {
		return depDayWeek;
	}

	public void setDepDayWeek(String depDayWeek) {
		this.depDayWeek = depDayWeek;
	}

	public ArrayList<FlightInfoDataVO> getFlightInfoDataBean() {
		return flightInfoDataBean;
	}

	public void setFlightInfoDataBean(ArrayList<FlightInfoDataVO> flightInfoDataBean) {
		this.flightInfoDataBean = flightInfoDataBean;
	}
}
