package com.lottejtb.front.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

public class ReqHotelRoomVO {
	
	private String 	hotelId;	 //호텔아이디
	private String 	checkInDt;  //체크인 날짜
	private String 	checkOutDt; //체크아웃날짜
	private List<RoomGroup> roomGroup = new ArrayList<RoomGroup>(); 
	
	public String getHotelId() {
		return hotelId;
	}
	public void setHotelId(String hotelId) {
		this.hotelId = hotelId;
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
	public List<RoomGroup> getRoomGroup() {
		return roomGroup;
	}
	public void setRoomGroup(List<RoomGroup> roomGroup) {
		this.roomGroup = roomGroup;
	}

	public static class RoomGroup {
		private String roomType;  //객실타입
		private String numOfAdt; //성인수
		private String numOfChd; //아동수
		private String ageOfChd;  //아동나이
		
		public String getRoomType() {
			return roomType;
		}
		public void setRoomType(String roomType) {
			this.roomType = roomType;
		}
		public String getNumOfAdt() {
			return numOfAdt;
		}
		public void setNumOfAdt(String numOfAdt) {
			this.numOfAdt = numOfAdt;
		}
		public String getNumOfChd() {
			return numOfChd;
		}
		public void setNumOfChd(String numOfChd) {
			this.numOfChd = numOfChd;
		}
		public String getAgeOfChd() {
			return ageOfChd;
		}
		public void setAgeOfChd(String ageOfChd) {
			this.ageOfChd = ageOfChd;
		}
	}
	
}