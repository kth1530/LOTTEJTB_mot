package com.lottejtb.api.service;

public class RsvPersonVO {
	private String rsvNm;		//예약자명
	private String rsvHtel;		//휴대전화
	private String rsvEmail;	//이메일
	
	
	public String getRsvNm() {
		return rsvNm;
	}
	public void setRsvNm(String rsvNm) {
		this.rsvNm = rsvNm;
	}
	public String getRsvHtel() {
		return rsvHtel;
	}
	public void setRsvHtel(String rsvHtel) {
		this.rsvHtel = rsvHtel;
	}
	public String getRsvEmail() {
		return rsvEmail;
	}
	public void setRsvEmail(String rsvEmail) {
		this.rsvEmail = rsvEmail;
	}
}
