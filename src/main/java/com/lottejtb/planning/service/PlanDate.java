package com.lottejtb.planning.service;

import java.io.Serializable;

public class PlanDate implements Serializable{

	String day;
	String eventCD;
	boolean isLast;

	
	public boolean isLast() {
		return isLast;
	}

	public void setLast(boolean isLast) {
		this.isLast = isLast;
	}

	public PlanDate(String day, String eventCD) {
		this.day = day;
		this.eventCD = eventCD;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public String getEventCD() {
		return eventCD;
	}

	public void setEventCD(String eventCD) {
		this.eventCD = eventCD;
	}
}
