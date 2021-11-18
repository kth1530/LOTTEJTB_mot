package com.lottejtb.front.hotel.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.lottejtb.front.service.ReqHotelRoomVO.RoomGroup;
import com.lottejtb.prom.service.PromotionHtListVO;

public class ReqHotelRoomVO {
	private String  fitMix;
	private String  suplrCd;
	private String 	hotelId;	 //호텔아이디
	private String 	checkInDt;  //체크인 날짜
	private String 	checkOutDt; //체크아웃날짜
	private String  rateCode;   //고객의 특정 객실 선택 후 사용(EAN) default : ""
	private String  roomTypeCode;   //고객의 특정 객실 선택 후 사용(EAN) default: ""
	private String  isDomestic;  //호텔 엔조이 추가2017.07.21
	private int 	roomCnt;    //호텔 엔조이 추가 2017.07.21
	
	//private PromotionHtListVO promInfo = new PromotionHtListVO();
	private List<RoomGroup> roomGroup = new ArrayList<RoomGroup>(); 
	
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
	public String getRateCode() {
		return rateCode;
	}
	public void setRateCode(String rateCode) {
		this.rateCode = rateCode;
	}
	public String getRoomTypeCode() {
		return roomTypeCode;
	}
	public void setRoomTypeCode(String roomTypeCode) {
		this.roomTypeCode = roomTypeCode;
	}
	public String getIsDomestic() {
		return isDomestic;
	}
	public void setIsDomestic(String isDomestic) {
		this.isDomestic = isDomestic;
	}
	public int getRoomCnt() {
		return roomCnt;
	}
	public void setRoomCnt(int roomCnt) {
		this.roomCnt = roomCnt;
	}
	public List<RoomGroup> getRoomGroup() {
		return roomGroup;
	}
	public void setRoomGroup(List<RoomGroup> roomGroup) {
		this.roomGroup = roomGroup;
	}

/*	public PromotionHtListVO getPromInfo() {
		return promInfo;
	}
	public void setPromInfo(PromotionHtListVO promInfo) {
		this.promInfo = promInfo;
	}*/

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