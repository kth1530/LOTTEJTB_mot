package com.lottejtb.api.service;

import java.util.ArrayList;
import java.util.List;

import com.lottejtb.front.vo.PromotionVo;
import com.lottejtb.prom.service.PromotionHtListVO;


/* 호텔 룸 리스트 */

public class FUHTI0002VO {
	
	private String message;
	private String code;
	private Data data = new FUHTI0002VO.Data();
	
	public static class Data {
		private String suplrCd;
		private String hotelId;
		private String checkInDt;
		private String checkOutDt;
		private String checkInInst;
		private String specCheckInInst;
		private String exchangeRate;
		private String countryCd;
		private List<RoomInfos> roomInfos = new ArrayList<FUHTI0002VO.RoomInfos>();
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
		public String getCheckInInst() {
			return checkInInst;
		}
		public void setCheckInInst(String checkInInst) {
			this.checkInInst = checkInInst;
		}
		public String getSpecCheckInInst() {
			return specCheckInInst;
		}
		public void setSpecCheckInInst(String specCheckInInst) {
			this.specCheckInInst = specCheckInInst;
		}
		public String getExchangeRate() {
			return exchangeRate;
		}
		public void setExchangeRate(String exchangeRate) {
			this.exchangeRate = exchangeRate;
		}
		public String getCountryCd() {
			return countryCd;
		}
		public void setCountryCd(String countryCd) {
			this.countryCd = countryCd;
		}
		public List<RoomInfos> getRoomInfos() {
			return roomInfos;
		}
		public void setRoomInfos(List<RoomInfos> roomInfos) {
			this.roomInfos = roomInfos;
		}
	}
	
	public static class RoomInfos {
		private String roomTypeCd; //룸타입코드
		private String roomTypeDesc;//룸타입설명
		private String isBreakFast; //조식 포함여부  Y:조식포함
		private String smokingPref; //흡연/비흡연
		private String minGuestAge; //투숙객연령
		private String quotedOccu; //객실수용 최대인원
		private String rateCode;
		private String rateOccuPerRoom; //객실수용 최대인원(추가요금발생 가능고객)
		private String hotelId;         //
		private String suplrCd;
		private List<BedTypes> bedTypes = new ArrayList<FUHTI0002VO.BedTypes>();
		private List<RateInfos> rateInfos = new ArrayList<FUHTI0002VO.RateInfos>();
		private ArrayList<RoomImages> roomImages = new ArrayList<FUHTI0002VO.RoomImages>();
		private ArrayList<ValueAdds> valueAdds = new ArrayList<FUHTI0002VO.ValueAdds>();
		
		/**
		 *일본 JTB추가 
		 *HUANG 20180626
		 */
		private String roomCode;//룸코드
		private String rsWestySquareMeter;
		private String bedWidthCm;//침대넓이
		private String bedLengthCm;//침대길이
		private String roomCodeUrl;//룸이미지
		private String occupancy;//정원
		private String occupancyMinimum;//최소인원
	    private String occupancyMaximum;//최대인원
	    private String numberOfUnits;//예약가능 객실수
	    private String minimumAgeOfPax;//최소연령
	    private String discountCategory;//할인 0000없음 1자리 연박할인 2자리 조기예약 할인 3자리 마감임박 할인 4자리 패키지할인  
		private String minimumStay;//연박할인 박수
		private String startDosNDaySPriorTtfs;//마감 할인 시작일
		private String endDosNDaySPriorTtfs;//마감 할인 마지막일
		private String amenity;//룸부대시설
		private String description;//설명
		private String dinnerDescription;//석식 설명
		private String breakfastDescription;//조식 설명
		/*private String amenity1;//욕실여부
		private String amenity7;//노천탕
		private String amenity10;//화장실
		private String amenity14;//냉방
		private String amenity17;//난방
		private String amenity20;//냉장고
		private String amenity21;//텔레비전
		private String amenity34;//바지 프레서
	*/
		
		
		public String getRoomTypeCd() {
			return roomTypeCd;
		}
		public String getRoomCode() {
			return roomCode;
		}
		public void setRoomCode(String roomCode) {
			this.roomCode = roomCode;
		}
		public String getRsWestySquareMeter() {
			return rsWestySquareMeter;
		}
		public void setRsWestySquareMeter(String rsWestySquareMeter) {
			this.rsWestySquareMeter = rsWestySquareMeter;
		}
		public String getBedWidthCm() {
			return bedWidthCm;
		}
		public void setBedWidthCm(String bedWidthCm) {
			this.bedWidthCm = bedWidthCm;
		}
		public String getBedLengthCm() {
			return bedLengthCm;
		}
		public void setBedLengthCm(String bedLengthCm) {
			this.bedLengthCm = bedLengthCm;
		}
		public String getRoomCodeUrl() {
			return roomCodeUrl;
		}
		public void setRoomCodeUrl(String roomCodeUrl) {
			this.roomCodeUrl = roomCodeUrl;
		}
		public String getOccupancy() {
			return occupancy;
		}
		public void setOccupancy(String occupancy) {
			this.occupancy = occupancy;
		}
		public String getOccupancyMinimum() {
			return occupancyMinimum;
		}
		public void setOccupancyMinimum(String occupancyMinimum) {
			this.occupancyMinimum = occupancyMinimum;
		}
		public String getOccupancyMaximum() {
			return occupancyMaximum;
		}
		public void setOccupancyMaximum(String occupancyMaximum) {
			this.occupancyMaximum = occupancyMaximum;
		}
		public String getNumberOfUnits() {
			return numberOfUnits;
		}
		public void setNumberOfUnits(String numberOfUnits) {
			this.numberOfUnits = numberOfUnits;
		}
		public String getMinimumAgeOfPax() {
			return minimumAgeOfPax;
		}
		public void setMinimumAgeOfPax(String minimumAgeOfPax) {
			this.minimumAgeOfPax = minimumAgeOfPax;
		}
		public String getDiscountCategory() {
			return discountCategory;
		}
		public void setDiscountCategory(String discountCategory) {
			this.discountCategory = discountCategory;
		}
		public String getMinimumStay() {
			return minimumStay;
		}
		public void setMinimumStay(String minimumStay) {
			this.minimumStay = minimumStay;
		}
		public String getStartDosNDaySPriorTtfs() {
			return startDosNDaySPriorTtfs;
		}
		public void setStartDosNDaySPriorTtfs(String startDosNDaySPriorTtfs) {
			this.startDosNDaySPriorTtfs = startDosNDaySPriorTtfs;
		}
		public String getEndDosNDaySPriorTtfs() {
			return endDosNDaySPriorTtfs;
		}
		public void setEndDosNDaySPriorTtfs(String endDosNDaySPriorTtfs) {
			this.endDosNDaySPriorTtfs = endDosNDaySPriorTtfs;
		}
		public String getAmenity() {
			return amenity;
		}
		public void setAmenity(String amenity) {
			this.amenity = amenity;
		}
		public String getDescription() {
			return description;
		}
		public void setDescription(String description) {
			this.description = description;
		}
		public String getDinnerDescription() {
			return dinnerDescription;
		}
		public void setDinnerDescription(String dinnerDescription) {
			this.dinnerDescription = dinnerDescription;
		}
		public String getBreakfastDescription() {
			return breakfastDescription;
		}
		public void setBreakfastDescription(String breakfastDescription) {
			this.breakfastDescription = breakfastDescription;
		}
		public void setRoomTypeCd(String roomTypeCd) {
			this.roomTypeCd = roomTypeCd;
		}
		public String getRoomTypeDesc() {
			return roomTypeDesc;
		}
		public String getIsBreakFast() {
			return isBreakFast;
		}
		public void setIsBreakFast(String isBreakFast) {
			this.isBreakFast = isBreakFast;
		}
		public void setRoomTypeDesc(String roomTypeDesc) {
			this.roomTypeDesc = roomTypeDesc;
		}
		public String getSmokingPref() {
			return smokingPref;
		}
		public void setSmokingPref(String smokingPref) {
			this.smokingPref = smokingPref;
		}
		public String getMinGuestAge() {
			return minGuestAge;
		}
		public void setMinGuestAge(String minGuestAge) {
			this.minGuestAge = minGuestAge;
		}
		public String getQuotedOccu() {
			return quotedOccu;
		}
		public void setQuotedOccu(String quotedOccu) {
			this.quotedOccu = quotedOccu;
		}
		public String getRateCode() {
			return rateCode;
		}
		public void setRateCode(String rateCode) {
			this.rateCode = rateCode;
		}
		public String getRateOccuPerRoom() {
			return rateOccuPerRoom;
		}
		public void setRateOccuPerRoom(String rateOccuPerRoom) {
			this.rateOccuPerRoom = rateOccuPerRoom;
		}
		public String getHotelId() {
			return hotelId;
		}
		public void setHotelId(String hotelId) {
			this.hotelId = hotelId;
		}
		public String getSuplrCd() {
			return suplrCd;
		}
		public void setSuplrCd(String suplrCd) {
			this.suplrCd = suplrCd;
		}
		public List<BedTypes> getBedTypes() {
			return bedTypes;
		}
		public void setBedTypes(List<BedTypes> bedTypes) {
			this.bedTypes = bedTypes;
		}
		public List<RateInfos> getRateInfos() {
			return rateInfos;
		}
		public void setRateInfos(List<RateInfos> rateInfos) {
			this.rateInfos = rateInfos;
		}
		public ArrayList<RoomImages> getRoomImages() {
			return roomImages;
		}
		public void setRoomImages(ArrayList<RoomImages> roomImages) {
			this.roomImages = roomImages;
		}
		public ArrayList<ValueAdds> getValueAdds() {
			return valueAdds;
		}
		public void setValueAdds(ArrayList<ValueAdds> valueAdds) {
			this.valueAdds = valueAdds;
		}
	}
		
	public static class BedTypes {
		private String bedTypeId;
		private String bedTypeDesc;
		public String getBedTypeId() {
			return bedTypeId;
		}
		public void setBedTypeId(String bedTypeId) {
			this.bedTypeId = bedTypeId;
		}
		public String getBedTypeDesc() {
			return bedTypeDesc;
		}
		public void setBedTypeDesc(String bedTypeDesc) {
			this.bedTypeDesc = bedTypeDesc;
		}
	}
	
	public static class RateInfos {
		private String numOfAdts;
		private String numOfChd;
		private String rateKey;
		private String rateType;
		private String rateTypeCd;
		private String nonRefundable; //환불불가여부
		private String cancellationPolicy; //취소정책
		private String avgBaseRate;
		private String avgRate;
		private String jtbBaseTotal;
		private String jtbTotal;
		private String whcExchangeRate;
		private String cancelDL;  //취소마감일
		private String cancelJtbDl; //호텔 취소마감시한(공휴일 포함 처리한 필드) 2015.05.03
		private String totalRate;
		private String surchargeTotal;
		private String salesTax;
		private String currencyCode; //통화코드
		private String cancelTL;
		private String commUsdTotal;
		private String exchangeRate;  //환율정보
		private String pkgSavingsAmount; //패키지 할인 금액
		private String markAmt = "0";  //마크업다운그액(0이아니고 다운일 경우-기호표시)
		
		private PromotionHtListVO promInfo;
				
		private List<CancelPolicyInfos> cancelPolicyInfos = new ArrayList<FUHTI0002VO.CancelPolicyInfos>();
		private List<Surcharges> surcharges = new ArrayList<FUHTI0002VO.Surcharges>();
		public String getNumOfAdts() {
			return numOfAdts;
		}
		public void setNumOfAdts(String numOfAdts) {
			this.numOfAdts = numOfAdts;
		}
		public String getNumOfChd() {
			return numOfChd;
		}
		public void setNumOfChd(String numOfChd) {
			this.numOfChd = numOfChd;
		}
		public String getRateKey() {
			return rateKey;
		}
		public void setRateKey(String rateKey) {
			this.rateKey = rateKey;
		}
		public String getRateType() {
			return rateType;
		}
		public void setRateType(String rateType) {
			this.rateType = rateType;
		}
		public String getRateTypeCd() {
			return rateTypeCd;
		}
		public void setRateTypeCd(String rateTypeCd) {
			this.rateTypeCd = rateTypeCd;
		}
		public String getNonRefundable() {
			return nonRefundable;
		}
		public void setNonRefundable(String nonRefundable) {
			this.nonRefundable = nonRefundable;
		}
		public String getCancellationPolicy() {
			return cancellationPolicy;
		}
		public void setCancellationPolicy(String cancellationPolicy) {
			this.cancellationPolicy = cancellationPolicy;
		}
		public String getAvgBaseRate() {
			return avgBaseRate;
		}
		public void setAvgBaseRate(String avgBaseRate) {
			this.avgBaseRate = avgBaseRate;
		}
		public String getAvgRate() {
			return avgRate;
		}
		public String getJtbBaseTotal() {
			return jtbBaseTotal;
		}
		public void setJtbBaseTotal(String jtbBaseTotal) {
			this.jtbBaseTotal = jtbBaseTotal;
		}
		public String getJtbTotal() {
			return jtbTotal;
		}
		public void setJtbTotal(String jtbTotal) {
			this.jtbTotal = jtbTotal;
		}
		public void setAvgRate(String avgRate) {
			this.avgRate = avgRate;
		}
		public String getWhcExchangeRate() {
			return whcExchangeRate;
		}
		public void setWhcExchangeRate(String whcExchangeRate) {
			this.whcExchangeRate = whcExchangeRate;
		}
		public String getCancelDL() {
			return cancelDL;
		}
		public void setCancelDL(String cancelDL) {
			this.cancelDL = cancelDL;
		}
		public String getCancelJtbDl() {
			return cancelJtbDl;
		}
		public void setCancelJtbDl(String cancelJtbDl) {
			this.cancelJtbDl = cancelJtbDl;
		}
		public String getTotalRate() {
			return totalRate;
		}
		public void setTotalRate(String totalRate) {
			this.totalRate = totalRate;
		}
		public String getSurchargeTotal() {
			return surchargeTotal;
		}
		public void setSurchargeTotal(String surchargeTotal) {
			this.surchargeTotal = surchargeTotal;
		}
		public String getSalesTax() {
			return salesTax;
		}
		public void setSalesTax(String salesTax) {
			this.salesTax = salesTax;
		}
		public String getCurrencyCode() {
			return currencyCode;
		}
		public void setCurrencyCode(String currencyCode) {
			this.currencyCode = currencyCode;
		}
		public String getCancelTL() {
			return cancelTL;
		}
		public void setCancelTL(String cancelTL) {
			this.cancelTL = cancelTL;
		}
		public List<CancelPolicyInfos> getCancelPolicyInfos() {
			return cancelPolicyInfos;
		}
		public void setCancelPolicyInfos(List<CancelPolicyInfos> cancelPolicyInfos) {
			this.cancelPolicyInfos = cancelPolicyInfos;
		}
		public List<Surcharges> getSurcharges() {
			return surcharges;
		}
		public void setSurcharges(List<Surcharges> surcharges) {
			this.surcharges = surcharges;
		}
		public String getCommUsdTotal() {
			return commUsdTotal;
		}
		public void setCommUsdTotal(String commUsdTotal) {
			this.commUsdTotal = commUsdTotal;
		}
		public String getExchangeRate() {
			return exchangeRate;
		}
		public void setExchangeRate(String exchangeRate) {
			this.exchangeRate = exchangeRate;
		}
		public String getPkgSavingsAmount() {
			return pkgSavingsAmount;
		}
		public void setPkgSavingsAmount(String pkgSavingsAmount) {
			this.pkgSavingsAmount = pkgSavingsAmount;
		}
		
		public String getMarkAmt() {
			return markAmt;
		}
		public void setMarkAmt(String markAmt) {
			this.markAmt = markAmt;
		}
		public PromotionHtListVO getPromInfo() {
			return promInfo;
		}
		public void setPromInfo(PromotionHtListVO promInfo) {
			this.promInfo = promInfo;
		}
		
	}
	
	public static class CancelPolicyInfos {
		private String cancelTime;
		private String startWindowHours;
		private String nightCount;
		private String timeZoneDesc;
		public String getCancelTime() {
			return cancelTime;
		}
		public void setCancelTime(String cancelTime) {
			this.cancelTime = cancelTime;
		}
		public String getStartWindowHours() {
			return startWindowHours;
		}
		public void setStartWindowHours(String startWindowHours) {
			this.startWindowHours = startWindowHours;
		}
		public String getNightCount() {
			return nightCount;
		}
		public void setNightCount(String nightCount) {
			this.nightCount = nightCount;
		}
		public String getTimeZoneDesc() {
			return timeZoneDesc;
		}
		public void setTimeZoneDesc(String timeZoneDesc) {
			this.timeZoneDesc = timeZoneDesc;
		}
	}
	
	public static class Surcharges {
		private String surchargeType;
		private String surchargeAmt;
		public String getSurchargeType() {
			return surchargeType;
		}
		public void setSurchargeType(String surchargeType) {
			this.surchargeType = surchargeType;
		}
		public String getSurchargeAmt() {
			return surchargeAmt;
		}
		public void setSurchargeAmt(String surchargeAmt) {
			this.surchargeAmt = surchargeAmt;
		}
	}
	
	public static class RoomImages {
		private String imageUrl;

		public String getImageUrl() {
			return imageUrl;
		}
		public void setImageUrl(String imageUrl) {
			this.imageUrl = imageUrl;
		}
	}

	public static class ValueAdds {
		private String valueAddId;
		private String valueAddNm;
		
		public String getValueAddId() {
			return valueAddId;
		}
		public void setValueAddId(String valueAddId) {
			this.valueAddId = valueAddId;
		}
		public String getValueAddNm() {
			return valueAddNm;
		}
		public void setValueAddNm(String valueAddNm) {
			this.valueAddNm = valueAddNm;
		}
	}
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public Data getData() {
		return data;
	}
	public void setData(Data data) {
		this.data = data;
	}

}
