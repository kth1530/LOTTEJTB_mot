package com.lottejtb.front.hotel.service;

/*
 *  호텔패스,GTA용 취소정책 정보를 받기 위한 VO,
 *  2015.05.23
 * 
 */

public class ReqHotelCancelPolicy {
	
	private String fitMix;   //조합값
	private String suplrCd;  //서플라이어 EAN: E
	private String rateKey;  //공급사 예약키 
	private String checkInDt;  //체크인   YYYY-MM-DD
	private String checkOutDt; //체크아웃 YYYY-MM-DD
	private String hotelId;    //호텔아이디 
	private String roomId;     //객실ID
	private int numOfChd;   //아동수
	private String ageOfChd;   //아동나이
	private String roomTy;      //객실타입   01: 싱글 , 02:트윈, 03:더블 , 04:트리플
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
	public String getRateKey() {
		return rateKey;
	}
	public void setRateKey(String rateKey) {
		this.rateKey = rateKey;
	}
	public String getCheckInDt() {
		return checkInDt;
	}
	public void setCheckInDt(String checkInDt) {
		this.checkInDt = checkInDt;
	}
	public String getCheckOutDt() {
		return checkOutDt;
	}
	public void setCheckOutDt(String checkOutDt) {
		this.checkOutDt = checkOutDt;
	}
	public String getHotelId() {
		return hotelId;
	}
	public void setHotelId(String hotelId) {
		this.hotelId = hotelId;
	}
	public String getRoomId() {
		return roomId;
	}
	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}
	public int getNumOfChd() {
		return numOfChd;
	}
	public void setNumOfChd(int numOfChd) {
		this.numOfChd = numOfChd;
	}
	public String getAgeOfChd() {
		return ageOfChd;
	}
	public void setAgeOfChd(String ageOfChd) {
		this.ageOfChd = ageOfChd;
	}
	public String getRoomTy() {
		return roomTy;
	}
	public void setRoomTy(String roomTy) {
		this.roomTy = roomTy;
	}
	
}
