package com.lottejtb.api.service;

import java.util.ArrayList;
import java.util.List;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

/*
 * 
 * 호텔 상세 정보
 */


@JsonIgnoreProperties(ignoreUnknown = true)
public class FUHTI0003VO {
	
	private String message;
	private String code;
	private Data data = new FUHTI0003VO.Data();

	public static class Data {
		private String suplrCd;   //공급사 코드
		private String hotelId;   //호텔ID
		private String addr1;
		private String addr2;
		private String addr3;
		private String addr4;
		private String numOfRooms; //총객실수
		private String propertyInfo; //호텔소개1
		private String propertyDesc; //호텔소개2
		private String propertyPolicy; //호텔정책
		private String checkInTm;   //체크인시간
		private String checkOutTm;  //체크아웃시간
		private String areaInfo;    //주변명소
		private String roomInfo; //호텔객실정보
		private String roomDetailDesc; //객실편의시설
		private String knowBeforeYouGoDescription;   //추가면책조항
		private String tel; //호텔 전화번호
		private String fax;  //호텔 팩스번호
		private String web;  //홈페이지
		private String trafficInfo; //교통정보
		private String extrachargeInfo; //
		private List<RoomInfos> roomInfos = new ArrayList<FUHTI0003VO.RoomInfos>();
		private List<PropertyAmenities> propertyAmenities = new ArrayList<FUHTI0003VO.PropertyAmenities>();
		private List<PropertyImages> propertyImages = new ArrayList<FUHTI0003VO.PropertyImages>();
		
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
			this.addr2 = addr2;
		}
		public String getAddr3() {
			return addr3;
		}
		public void setAddr3(String addr3) {
			this.addr3 = addr3;
		}
		public String getAddr4() {
			return addr4;
		}
		public void setAddr4(String addr4) {
			this.addr4 = addr4;
		}
		public String getNumOfRooms() {
			return numOfRooms;
		}
		public void setNumOfRooms(String numOfRooms) {
			this.numOfRooms = numOfRooms;
		}
		public String getPropertyInfo() {
			return propertyInfo;
		}
		public void setPropertyInfo(String propertyInfo) {
			this.propertyInfo = propertyInfo;
		}
		public String getPropertyDesc() {
			return propertyDesc;
		}
		public void setPropertyDesc(String propertyDesc) {
			this.propertyDesc = propertyDesc;
		}
		public String getPropertyPolicy() {
			return propertyPolicy;
		}
		public void setPropertyPolicy(String propertyPolicy) {
			this.propertyPolicy = propertyPolicy;
		}
		public String getCheckInTm() {
			return checkInTm;
		}
		public void setCheckInTm(String checkInTm) {
			this.checkInTm = checkInTm;
		}
		public String getCheckOutTm() {
			return checkOutTm;
		}
		public void setCheckOutTm(String checkOutTm) {
			this.checkOutTm = checkOutTm;
		}
		public String getAreaInfo() {
			return areaInfo;
		}
		public void setAreaInfo(String areaInfo) {
			this.areaInfo = areaInfo;
		}
		public String getRoomInfo() {
			return roomInfo;
		}
		public void setRoomInfo(String roomInfo) {
			this.roomInfo = roomInfo;
		}
		public String getRoomDetailDesc() {
			return roomDetailDesc;
		}
		public void setRoomDetailDesc(String roomDetailDesc) {
			this.roomDetailDesc = roomDetailDesc;
		}
		public String getKnowBeforeYouGoDescription() {
			return knowBeforeYouGoDescription;
		}
		public void setKnowBeforeYouGoDescription(String knowBeforeYouGoDescription) {
			this.knowBeforeYouGoDescription = knowBeforeYouGoDescription;
		}
		public String getTel() {
			return tel;
		}
		public void setTel(String tel) {
			this.tel = tel;
		}
		public String getFax() {
			return fax;
		}
		public void setFax(String fax) {
			this.fax = fax;
		}
		public String getWeb() {
			return web;
		}
		public void setWeb(String web) {
			this.web = web;
		}
		public String getTrafficInfo() {
			return trafficInfo;
		}
		public void setTrafficInfo(String trafficInfo) {
			this.trafficInfo = trafficInfo;
		}
		public String getExtrachargeInfo() {
			return extrachargeInfo;
		}
		public void setExtrachargeInfo(String extrachargeInfo) {
			this.extrachargeInfo = extrachargeInfo;
		}
		public List<RoomInfos> getRoomInfos() {
			return roomInfos;
		}
		public void setRoomInfos(List<RoomInfos> roomInfos) {
			this.roomInfos = roomInfos;
		}
		public List<PropertyAmenities> getPropertyAmenities() {
			return propertyAmenities;
		}
		public void setPropertyAmenities(List<PropertyAmenities> propertyAmenities) {
			this.propertyAmenities = propertyAmenities;
		}
		public List<PropertyImages> getPropertyImages() {
			return propertyImages;
		}
		public void setPropertyImages(List<PropertyImages> propertyImages) {
			this.propertyImages = propertyImages;
		}
		
	}
	
	public static class RoomInfos {
		private String roomTypeId;
		private String roomCode;
		private String roomDescS;
		private String roomDescL;
		private List<RoomAmenities> roomAmenities = new ArrayList<FUHTI0003VO.RoomAmenities>();
		
		public String getRoomTypeId() {
			return roomTypeId;
		}
		public void setRoomTypeId(String roomTypeId) {
			this.roomTypeId = roomTypeId;
		}
		public String getRoomCode() {
			return roomCode;
		}
		public void setRoomCode(String roomCode) {
			this.roomCode = roomCode;
		}
		public String getRoomDescS() {
			return roomDescS;
		}
		public void setRoomDescS(String roomDescS) {
			this.roomDescS = roomDescS;
		}
		public String getRoomDescL() {
			return roomDescL;
		}
		public void setRoomDescL(String roomDescL) {
			this.roomDescL = roomDescL;
		}
		public List<RoomAmenities> getRoomAmenities() {
			return roomAmenities;
		}
		public void setRoomAmenities(List<RoomAmenities> roomAmenities) {
			this.roomAmenities = roomAmenities;
		}
	}
	
	public static class RoomAmenities {
		private String amenityId;
		private String amenityNm;
		public String getAmenityId() {
			return amenityId;
		}
		public void setAmenityId(String amenityId) {
			this.amenityId = amenityId;
		}
		public String getAmenityNm() {
			return amenityNm;
		}
		public void setAmenityNm(String amenityNm) {
			this.amenityNm = amenityNm;
		}
	}
	
	public static class PropertyAmenities {
		private String amenityId;
		private String amenityNm;
		public String getAmenityId() {
			return amenityId;
		}
		public void setAmenityId(String amenityId) {
			this.amenityId = amenityId;
		}
		public String getAmenityNm() {
			return amenityNm;
		}
		public void setAmenityNm(String amenityNm) {
			this.amenityNm = amenityNm;
		}
	}
	
	public static class PropertyImages {
		private String caption;
		private String category;
		private String height;
		private String propertyImageId;
		private String propertyImageNm;
		private String thumbUrl;
		private String type;
		private String url;
		private String width;
		public String getCaption() {
			return caption;
		}
		public void setCaption(String caption) {
			this.caption = caption;
		}
		public String getCategory() {
			return category;
		}
		public void setCategory(String category) {
			this.category = category;
		}
		public String getHeight() {
			return height;
		}
		public void setHeight(String height) {
			this.height = height;
		}
		public String getPropertyImageId() {
			return propertyImageId;
		}
		public void setPropertyImageId(String propertyImageId) {
			this.propertyImageId = propertyImageId;
		}
		public String getPropertyImageNm() {
			return propertyImageNm;
		}
		public void setPropertyImageNm(String propertyImageNm) {
			this.propertyImageNm = propertyImageNm;
		}
		public String getThumbUrl() {
			return thumbUrl;
		}
		public void setThumbUrl(String thumbUrl) {
			this.thumbUrl = thumbUrl;
		}
		public String getType() {
			return type;
		}
		public void setType(String type) {
			this.type = type;
		}
		public String getUrl() {
			return url;
		}
		public void setUrl(String url) {
			this.url = url;
		}
		public String getWidth() {
			return width;
		}
		public void setWidth(String width) {
			this.width = width;
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
