package com.lottejtb.api.service;

/*
 * 
 * 호텔 예약 정보
 * 
 */
public class FUHTI0004VO {
	private String code;
	private String message;
	private Data data = new FUHTI0004VO.Data();
	
	//데이터
	public static class Data {
		private String itineraryId; //예약고유ID
		private String confirmNums; //예약화인번호
		private String procWithConfirm; //예약확인여부(호텔)
		private String supplierType;  //공급사코드
		private String rsvStatusCd;  //예약상태코드
		private String numOfRoomsBooked; //예약된 객실 수
		private String checkInInstructions; //기본 체크인지침
		private String speciCheckInInstructions; //중요체크인정보
		private String checkInDt;
		private String checkOutDt;
		private String commTotal ; //총 커미션
		private String commJtb; //JTB커미션   총 커미션*0.5(비율 5:5임시)
		public String getItineraryId() {
			return itineraryId;
		}
		public void setItineraryId(String itineraryId) {
			this.itineraryId = itineraryId;
		}
		public String getConfirmNums() {
			return confirmNums;
		}
		public void setConfirmNums(String confirmNums) {
			this.confirmNums = confirmNums;
		}
		public String getProcWithConfirm() {
			return procWithConfirm;
		}
		public void setProcWithConfirm(String procWithConfirm) {
			this.procWithConfirm = procWithConfirm;
		}
		public String getSupplierType() {
			return supplierType;
		}
		public void setSupplierType(String supplierType) {
			this.supplierType = supplierType;
		}
		public String getRsvStatusCd() {
			return rsvStatusCd;
		}
		public void setRsvStatusCd(String rsvStatusCd) {
			this.rsvStatusCd = rsvStatusCd;
		}
		public String getNumOfRoomsBooked() {
			return numOfRoomsBooked;
		}
		public void setNumOfRoomsBooked(String numOfRoomsBooked) {
			this.numOfRoomsBooked = numOfRoomsBooked;
		}
		public String getCheckInInstructions() {
			return checkInInstructions;
		}
		public void setCheckInInstructions(String checkInInstructions) {
			this.checkInInstructions = checkInInstructions;
		}
		public String getSpeciCheckInInstructions() {
			return speciCheckInInstructions;
		}
		public void setSpeciCheckInInstructions(String speciCheckInInstructions) {
			this.speciCheckInInstructions = speciCheckInInstructions;
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
		public String getCommTotal() {
			return commTotal;
		}
		public void setCommTotal(String commTotal) {
			this.commTotal = commTotal;
		}
		public String getCommJtb() {
			return commJtb;
		}
		public void setCommJtb(String commJtb) {
			this.commJtb = commJtb;
		}
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Data getData() {
		return data;
	}

	public void setData(Data data) {
		this.data = data;
	}

}
