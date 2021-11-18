package com.lottejtb.front.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

public class ReqHotelVO {
	
	private String countryCd;
	private String stateProvCd;
	private String findLocNm;
	private String checkInDt;
	private String checkOutDt;
	private String roomCnt;
	private List<RoomCont> roomCont = new ArrayList<RoomCont>();
	
	public String getCountryCd() {
		return countryCd;
	}
	public void setCountryCd(String countryCd) {
		this.countryCd = countryCd;
	}
	public String getStateProvCd() {
		return stateProvCd;
	}
	public void setStateProvCd(String stateProvCd) {
		this.stateProvCd = stateProvCd;
	}
	public String getFindLocNm() {
		return findLocNm;
	}
	public void setFindLocNm(String findLocNm) {
		this.findLocNm = findLocNm;
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
	public String getRoomCnt() {
		return roomCnt;
	}
	public void setRoomCnt(String roomCnt) {
		this.roomCnt = roomCnt;
	}
	public List<RoomCont> getRoomCont() {
		return roomCont;
	}
	public void setRoomCont(List<RoomCont> roomCont) {
		this.roomCont = roomCont;
	}


	public static class RoomCont {
		private String roomTy;
		private String numOfAdt;
		private String numOfChd;
		private String ageOfChd;
		public String getRoomTy() {
			return roomTy;
		}
		public void setRoomTy(String roomTy) {
			this.roomTy = roomTy;
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
	
	
	
	
	
	/*private String 	ageOfChildren;
	private String 	checkInDate;
	private String 	checkOutDate;
	private String 	cityCode;
	private String 	countryCode;
	private String 	numberOfAdults;
	private String 	numberOfChildren;
	private int 	roomCnt;
    private String 	customerSessionId;
    private String 	city;
    private int    	numberOfResults;
	
	public int getNumberOfResults() {
		return numberOfResults;
	}
	public void setNumberOfResults(int numberOfResults) {
		this.numberOfResults = numberOfResults;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCustomerSessionId() {
		return customerSessionId;
	}
	public void setCustomerSessionId(String customerSessionId) {
		this.customerSessionId = customerSessionId;
	}
	public String getAgeOfChildren() {
		return ageOfChildren;
	}
	public void setAgeOfChildren(String ageOfChildren) {
		this.ageOfChildren = ageOfChildren;
	}
	public String getCityCode() {
		return cityCode;
	}
	public String getCheckInDate() {
		return checkInDate;
	}
	public void setCheckInDate(String checkInDate) {
		this.checkInDate = checkInDate;
	}
	public String getCheckOutDate() {
		return checkOutDate;
	}
	public void setCheckOutDate(String checkOutDate) {
		this.checkOutDate = checkOutDate;
	}
	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}
	public String getCountryCode() {
		return countryCode;
	}
	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}
	public String getNumberOfAdults() {
		return numberOfAdults;
	}
	public void setNumberOfAdults(String numberOfAdults) {
		this.numberOfAdults = numberOfAdults;
	}
	public String getNumberOfChildren() {
		return numberOfChildren;
	}
	public void setNumberOfChildren(String numberOfChildren) {
		this.numberOfChildren = numberOfChildren;
	}
	public int getRoomCnt() {
		return roomCnt;
	}
	public void setRoomCnt(int roomCnt) {
		this.roomCnt = roomCnt;
	}
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }*/
}