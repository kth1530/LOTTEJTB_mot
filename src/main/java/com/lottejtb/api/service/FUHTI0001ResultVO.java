package com.lottejtb.api.service;

import java.util.ArrayList;
import java.util.List;

public class FUHTI0001ResultVO {
	private static final long serialVersionUID = -5851211865099596588L;

	private String 	countryCd = ""; // 국가코드
	private String 	cityCd = ""; // 도시코드
	private String 	cityNm = ""; // 도시명
	private String 	suplrCd = ""; // 공급사코드
	private String 	hotelId = ""; // 호텔ID
	private String 	hotelNmKr = ""; // 호텔명-한글
	private String 	hotelNmEn = ""; // 호텔명-영문
	private String 	addr1 = ""; // 호텔주소1
	private String 	addr2 = ""; // 호텔주소2
	private String 	hotelRating = ""; // 호텔등급
	private String 	hotelRatingDisplay = ""; // 등급기준
	private String 	lat = ""; // 위도
	private String 	lon = ""; // 경도
	private String 	tripAdvRating = ""; // 리뷰 평점
	private int 	tripAdvReviewCnt = 0; // 리뷰 수
	private String 	tripAdvRatingUrl = ""; // 리뷰 평점 이미지URL
	private String 	locShortDesc = ""; // 간략 호텔 위치
	private String 	thumbNailUrl = ""; // 호텔이미지URL
	private List<RoomDetls> roomDetls 	= new ArrayList<RoomDetls>(); // 객실상세
	

	public String getCountryCd() {
		return countryCd;
	}

	public void setCountryCd(String countryCd) {
		this.countryCd = countryCd;
	}

	public String getCityCd() {
		return cityCd;
	}

	public void setCityCd(String cityCd) {
		this.cityCd = cityCd;
	}

	public String getCityNm() {
		return cityNm;
	}

	public void setCityNm(String cityNm) {
		this.cityNm = cityNm;
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

	public String getHotelNmKr() {
		return hotelNmKr;
	}

	public void setHotelNmKr(String hotelNmKr) {
		this.hotelNmKr = hotelNmKr;
	}

	public String getHotelNmEn() {
		return hotelNmEn;
	}

	public void setHotelNmEn(String hotelNmEn) {
		this.hotelNmEn = hotelNmEn;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2 == null ? "" : addr2;
	}

	public String getHotelRating() {
		return hotelRating;
	}

	public void setHotelRating(String hotelRating) {
		this.hotelRating = hotelRating;
	}

	public String getHotelRatingDisplay() {
		return hotelRatingDisplay;
	}

	public void setHotelRatingDisplay(String hotelRatingDisplay) {
		this.hotelRatingDisplay = hotelRatingDisplay;
	}

	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public String getLon() {
		return lon;
	}

	public void setLon(String lon) {
		this.lon = lon;
	}

	public String getTripAdvRating() {
		return tripAdvRating;
	}

	public void setTripAdvRating(String tripAdvRating) {
		this.tripAdvRating = tripAdvRating;
	}

	public int getTripAdvReviewCnt() {
		return tripAdvReviewCnt;
	}

	public void setTripAdvReviewCnt(int tripAdvReviewCnt) {
		this.tripAdvReviewCnt = tripAdvReviewCnt;
	}

	public String getTripAdvRatingUrl() {
		return tripAdvRatingUrl;
	}

	public void setTripAdvRatingUrl(String tripAdvRatingUrl) {
		this.tripAdvRatingUrl = tripAdvRatingUrl;
	}

	public String getLocShortDesc() {
		return locShortDesc;
	}

	public void setLocShortDesc(String locShortDesc) {
		this.locShortDesc = locShortDesc;
	}

	public String getThumbNailUrl() {
		return thumbNailUrl;
	}

	public void setThumbNailUrl(String thumbNailUrl) {
		this.thumbNailUrl = thumbNailUrl;
	}

	public List<RoomDetls> getRoomDetls() {
		return roomDetls;
	}

	public void setRoomDetls(List<RoomDetls> roomDetls) {
		this.roomDetls = roomDetls;
	}

	// 객실상세
	public static class RoomDetls {
		private String roomTypeCd = ""; // 룸타입코드
		private String roomTypeNm = ""; // 룸타입명
		private String avgBaseRate = ""; // 1박평균기본요금
		private String avgRate	 	= ""; // 1박평균요금
		private String taxAndServiceFee = ""; // 세금및봉사료
		private String smokingPref = ""; // 금연룸유무
		private String nonRefundable = ""; // 환불가능여부
		private String cancellationPolicy = ""; // 취소정책
		private List<ValAdds> 	valAdds 	= new ArrayList<ValAdds>(); // 부가서비스

		public String getRoomTypeCd() {
			return roomTypeCd;
		}

		public void setRoomTypeCd(String roomTypeCd) {
			this.roomTypeCd = roomTypeCd;
		}

		public String getRoomTypeNm() {
			return roomTypeNm;
		}

		public void setRoomTypeNm(String roomTypeNm) {
			this.roomTypeNm = roomTypeNm;
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

		public void setAvgRate(String avgRate) {
			this.avgRate = avgRate;
		}

		public String getTaxAndServiceFee() {
			return taxAndServiceFee;
		}

		public void setTaxAndServiceFee(String taxAndServiceFee) {
			this.taxAndServiceFee = taxAndServiceFee;
		}

		public String getSmokingPref() {
			return smokingPref;
		}

		public void setSmokingPref(String smokingPref) {
			this.smokingPref = smokingPref;
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
		

		public List<ValAdds> getValAdds() {
			return valAdds;
		}

		public void setValAdds(List<ValAdds> valAdds) {
			this.valAdds = valAdds;
		}

	}

	// 부가서비스
	public static class ValAdds {
		private String valueId = ""; // 부가서비스 ID
		private String valueNm = ""; // 부가서비스 명

		public String getValueId() {
			return valueId;
		}

		public void setValueId(String valueId) {
			this.valueId = valueId;
		}

		public String getValueNm() {
			return valueNm;
		}

		public void setValueNm(String valueNm) {
			this.valueNm = valueNm;
		}
	}
}
