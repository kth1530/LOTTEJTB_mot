//package com.lottejtb.api.service;
//
//import java.util.ArrayList;
//import java.util.List;
//
///*
// * 호텔 룸리스트 정보
// * 
// */
//
//public class FUHTI0002ResultVO {
//
//	private static final long serialVersionUID = -5851211865099596588L;
//	
//	private String suplrCd;  //공금사코드
//	private String hotelId; //호텔ID
//	private String checkInDt; //체크인날짜
//	private String checkOutDt; //체크아웃날짜
//	private String checkInInst; //기본 체크인지침
//	private String specCheckInInst; //중요체크인지침
//	private List<Data> data = new ArrayList<Data>();
//
//	public String getSuplrCd() {
//		return suplrCd;
//	}
//	public void setSuplrCd(String suplrCd) {
//		this.suplrCd = suplrCd;
//	}
//	public String getHotelId() {
//		return hotelId;
//	}
//	public void setHotelId(String hotelId) {
//		this.hotelId = hotelId;
//	}
//	public String getCheckInDt() {
//		return checkInDt;
//	}
//	public void setCheckInDt(String checkInDt) {
//		this.checkInDt = checkInDt;
//	}
//	public String getCheckOutDt() {
//		return checkOutDt;
//	}
//	public void setCheckOutDt(String checkOutDt) {
//		this.checkOutDt = checkOutDt;
//	}
//	public String getCheckInInst() {
//		return checkInInst;
//	}
//	public void setCheckInInst(String checkInInst) {
//		this.checkInInst = checkInInst;
//	}
//	public String getSpecCheckInInst() {
//		return specCheckInInst;
//	}
//	public void setSpecCheckInInst(String specCheckInInst) {
//		this.specCheckInInst = specCheckInInst;
//	}
//	public List<Data> getData() {
//		return data;
//	}
//	public void setData(List<Data> data) {
//		this.data = data;
//	}
//
//	public static class Data {
//		private String roomTypeCd; //룸타입코드
//		private String roomTypeDesc; //룸타입설명
//		private String smokingPref; //흡연/비흡연
//		private String minGuestAge; //투숙객 최소연령
//		private String quotedOccu;  //갤실수용 최대인원
//		private String rateOccuPerRoom; //갤실수용 최대인원(추가요금발생가능고객)
//		private List<RoomInfo> roomInfo = new ArrayList<RoomInfo>();
//		public String getRoomTypeCd() {
//			return roomTypeCd;
//		}
//		public void setRoomTypeCd(String roomTypeCd) {
//			this.roomTypeCd = roomTypeCd;
//		}
//		public String getRoomTypeDesc() {
//			return roomTypeDesc;
//		}
//		public void setRoomTypeDesc(String roomTypeDesc) {
//			this.roomTypeDesc = roomTypeDesc;
//		}
//		public String getSmokingPref() {
//			return smokingPref;
//		}
//		public void setSmokingPref(String smokingPref) {
//			this.smokingPref = smokingPref;
//		}
//		public String getMinGuestAge() {
//			return minGuestAge;
//		}
//		public void setMinGuestAge(String minGuestAge) {
//			this.minGuestAge = minGuestAge;
//		}
//		public String getQuotedOccu() {
//			return quotedOccu;
//		}
//		public void setQuotedOccu(String quotedOccu) {
//			this.quotedOccu = quotedOccu;
//		}
//		public String getRateOccuPerRoom() {
//			return rateOccuPerRoom;
//		}
//		public void setRateOccuPerRoom(String rateOccuPerRoom) {
//			this.rateOccuPerRoom = rateOccuPerRoom;
//		}
//		public List<RoomInfo> getRoomInfo() {
//			return roomInfo;
//		}
//		public void setRoomInfo(List<RoomInfo> roomInfo) {
//			this.roomInfo = roomInfo;
//		}
//	}
//	
//	public static class RoomInfo {
//		private 
//		
//		
//		
//		
//	}
//	
//	
//	
//	public static class BedTypes {
//		private String bedTypeId; //베드타입 ID
//		private String bedTypeDesc; //베드타입설명
//		public String getBedTypeId() {
//			return bedTypeId;
//		}
//		public void setBedTypeId(String bedTypeId) {
//			this.bedTypeId = bedTypeId;
//		}
//		public String getBedTypeDesc() {
//			return bedTypeDesc;
//		}
//		public void setBedTypeDesc(String bedTypeDesc) {
//			this.bedTypeDesc = bedTypeDesc;
//		}
//	}
//	
//	//요금정보
//	public static class RateInfos {
//		private String numOfAdts; //성인수
//		private String numOfChd;  //아동수
//		private String rateKey;   //예약 필수키
//		private String rateType;  //
//		private String cancellationPolicy; //취소정책
//		private List<CancelPolicyInfos> cancelPolicyInfos = new ArrayList<CancelPolicyInfos>();
//		public String getNumOfAdts() {
//			return numOfAdts;
//		}
//		public void setNumOfAdts(String numOfAdts) {
//			this.numOfAdts = numOfAdts;
//		}
//		public String getNumOfChd() {
//			return numOfChd;
//		}
//		public void setNumOfChd(String numOfChd) {
//			this.numOfChd = numOfChd;
//		}
//		public String getRateKey() {
//			return rateKey;
//		}
//		public void setRateKey(String rateKey) {
//			this.rateKey = rateKey;
//		}
//		public String getRateType() {
//			return rateType;
//		}
//		public void setRateType(String rateType) {
//			this.rateType = rateType;
//		}
//		public String getCancellationPolicy() {
//			return cancellationPolicy;
//		}
//		public void setCancellationPolicy(String cancellationPolicy) {
//			this.cancellationPolicy = cancellationPolicy;
//		}
//		public List<CancelPolicyInfos> getCancelPolicyInfos() {
//			return cancelPolicyInfos;
//		}
//		public void setCancelPolicyInfos(List<CancelPolicyInfos> cancelPolicyInfos) {
//			this.cancelPolicyInfos = cancelPolicyInfos;
//		}
//	
//	}
//	
//	public static class CancelPolicyInfos {
//		private String cancelTimes;
//		private String startWindowHourss;
//		private String nightCounts;
//		private String timeZoneDescs;
//		private String avgBaseRate; //1박평군기본요금
//		private String avgRate; //1박평군요금
//		private String totalRate; //총금액
//		private String surchargeTotal; //
//		private String currencyCode;
//		private List<Surcharges> surcharges = new ArrayList<Surcharges>();
//		public String getCancelTimes() {
//			return cancelTimes;
//		}
//		public void setCancelTimes(String cancelTimes) {
//			this.cancelTimes = cancelTimes;
//		}
//		public String getStartWindowHourss() {
//			return startWindowHourss;
//		}
//		public void setStartWindowHourss(String startWindowHourss) {
//			this.startWindowHourss = startWindowHourss;
//		}
//		public String getNightCounts() {
//			return nightCounts;
//		}
//		public void setNightCounts(String nightCounts) {
//			this.nightCounts = nightCounts;
//		}
//		public String getTimeZoneDescs() {
//			return timeZoneDescs;
//		}
//		public void setTimeZoneDescs(String timeZoneDescs) {
//			this.timeZoneDescs = timeZoneDescs;
//		}
//		public String getAvgBaseRate() {
//			return avgBaseRate;
//		}
//		public void setAvgBaseRate(String avgBaseRate) {
//			this.avgBaseRate = avgBaseRate;
//		}
//		public String getAvgRate() {
//			return avgRate;
//		}
//		public void setAvgRate(String avgRate) {
//			this.avgRate = avgRate;
//		}
//		public String getTotalRate() {
//			return totalRate;
//		}
//		public void setTotalRate(String totalRate) {
//			this.totalRate = totalRate;
//		}
//		public String getSurchargeTotal() {
//			return surchargeTotal;
//		}
//		public void setSurchargeTotal(String surchargeTotal) {
//			this.surchargeTotal = surchargeTotal;
//		}
//		public String getCurrencyCode() {
//			return currencyCode;
//		}
//		public void setCurrencyCode(String currencyCode) {
//			this.currencyCode = currencyCode;
//		}
//		public List<Surcharges> getSurcharges() {
//			return surcharges;
//		}
//		public void setSurcharges(List<Surcharges> surcharges) {
//			this.surcharges = surcharges;
//		}
//	}
//	
//	//특정 추가요금
//	public static class Surcharges{ 
//		private String surchargeType; //특정추가요금유형
//		private String surchargeAmt; //특정추가요금총합
//		public String getSurchargeType() {
//			return surchargeType;
//		}
//		public void setSurchargeType(String surchargeType) {
//			this.surchargeType = surchargeType;
//		}
//		public String getSurchargeAmt() {
//			return surchargeAmt;
//		}
//		public void setSurchargeAmt(String surchargeAmt) {
//			this.surchargeAmt = surchargeAmt;
//		}
//		
//	}
//	
//	//무료서비스
//	public static class ValueAdds {
//		private String valueAddId;
//		private String valueAddNm;
//		public String getValueAddId() {
//			return valueAddId;
//		}
//		public void setValueAddId(String valueAddId) {
//			this.valueAddId = valueAddId;
//		}
//		public String getValueAddNm() {
//			return valueAddNm;
//		}
//		public void setValueAddNm(String valueAddNm) {
//			this.valueAddNm = valueAddNm;
//		}
//	}
//	
//	//룸이미지
//	public static class RoomImages {
//		private String imageUrl;
//
//		public String getImageUrl() {
//			return imageUrl;
//		}
//
//		public void setImageUrl(String imageUrl) {
//			this.imageUrl = imageUrl;
//		}
//	}
//	
//}
