package com.lottejtb.front.hotel.service;

/*
 * 예약 호텔 숙박자 정보
 */
public class RsvHtlTravlerVO {
	private String fitRsvNo;
	private String guestKrName;
	private String guestEnName;
	private String ymd;
	private String htel;
	private String gender;
	private String rsvSeqNo;  //숙박자정보 key
	
	public String getFitRsvNo() {
		return fitRsvNo;
	}
	public void setFitRsvNo(String fitRsvNo) {
		this.fitRsvNo = fitRsvNo;
	}
	public String getGuestKrName() {
		return guestKrName;
	}
	public void setGuestKrName(String guestKrName) {
		this.guestKrName = guestKrName;
	}
	public String getGuestEnName() {
		return guestEnName;
	}
	public void setGuestEnName(String guestEnName) {
		this.guestEnName = guestEnName;
	}
	public String getYmd() {
		return ymd;
	}
	public void setYmd(String ymd) {
		this.ymd = ymd;
	}
	public String getHtel() {
		return htel;
	}
	public void setHtel(String htel) {
		this.htel = htel;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getRsvSeqNo() {
		return rsvSeqNo;
	}
	public void setRsvSeqNo(String rsvSeqNo) {
		this.rsvSeqNo = rsvSeqNo;
	}
}
