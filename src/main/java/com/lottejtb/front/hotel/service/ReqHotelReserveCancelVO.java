package com.lottejtb.front.hotel.service;

/*
 *  호텔 예약 취소 (inputData)
 */

public class ReqHotelReserveCancelVO {
	private String fitMix;	    //자유여행 구성조합
	private String suplrCd;     //공급사 코드
	private String itineraryId;  //예약고유ID
	private String email;         //대표 예약자 email
	private String name;          //대표 예약자 name
	private String reason;      //취소사유  
	private String htlRsvSeqno; //JTB 호텔 예약번호
	private String fitRsvNo;	//
	private String confirmNum; //취소 객실번호
	
	public String getFitMix() {
		return fitMix;
	}
	public void setFitMix(String fitMix) {
		this.fitMix = fitMix;
	}
	public String getSuplrCd() {
		return suplrCd;
	}
	public void setSuplrCd(String suplrCd) {
		this.suplrCd = suplrCd;
	}
	public String getItineraryId() {
		return itineraryId;
	}
	public void setItineraryId(String itineraryId) {
		this.itineraryId = itineraryId;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getHtlRsvSeqno() {
		return htlRsvSeqno;
	}
	public void setHtlRsvSeqno(String htlRsvSeqno) {
		this.htlRsvSeqno = htlRsvSeqno;
	}
	public String getFitRsvNo() {
		return fitRsvNo;
	}
	public void setFitRsvNo(String fitRsvNo) {
		this.fitRsvNo = fitRsvNo;
	}
	public String getConfirmNum() {
		return confirmNum;
	}
	public void setConfirmNum(String confirmNum) {
		this.confirmNum = confirmNum;
	}
}
