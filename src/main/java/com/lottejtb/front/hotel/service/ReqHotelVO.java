package com.lottejtb.front.hotel.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.lottejtb.front.hotel.service.ReqHotelVO.RoomCont;

public class ReqHotelVO {
	private String fitMix;
	private String countryCd;
	private String countryNm;
	private String stateProvCd;
	private String findLocNm;
	private String checkInDt;
	private String checkOutDt;
	private String roomCnt;
	private String searchType;
	private String nightDay;
	private String isDomestic;
	private List<RoomCont> roomCont = new ArrayList<RoomCont>();
	
	public String getFitMix() {
		return fitMix;
	}
	public void setFitMix(String fitMix) {
		this.fitMix = fitMix;
	}
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
	
	public String getRoomCnt() {
		return roomCnt;
	}
	public void setRoomCnt(String roomCnt) {
		this.roomCnt = roomCnt;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public List<RoomCont> getRoomCont() {
		return roomCont;
	}
	public String getCheckOutDt() {
		return checkOutDt;
	}
	public void setCheckOutDt(String checkOutDt) {
		this.checkOutDt = checkOutDt;
	}
	public void setRoomCont(List<RoomCont> roomCont) {
		this.roomCont = roomCont;
	}
	public String getNightDay() {
		return nightDay;
	}
	public void setNightDay(String nightDay) {
		this.nightDay = nightDay;
	}
	public String getIsDomestic() {
		return isDomestic;
	}
	public void setIsDomestic(String isDomestic) {
		this.isDomestic = isDomestic;
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


	public String getCountryNm() {
		return countryNm;
	}
	public void setCountryNm(String countryNm) {
		this.countryNm = countryNm;
	}
}