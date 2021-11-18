package com.lottejtb.front.hotel.service;

import java.util.ArrayList;
import java.util.List;

/*
 *  호텔 예약 input vo
 */

public class ReqHotelRerveInputVO {
	private String fitMix;
	private String hotelId;		    //호텔ID
	private String hotelNmKr;		//호텔 한글명
	private String hotelNmEn;		//호텔 영문명
	private String checkInDt;		//체크인날짜
	private String checkOutDt;      //체크아웃날짜
	private String cancelDl;  		//취소마감일
	private String suplrCd; 		//공급사코드
	private String rateKey; 		//예약키
	private String roomTypeCd;      //룸타입 코드
	private String isBreakFast;     //조식 여부 
	private String salesTax;		//세금
	private String rateCode;        //통화코드
	private String affiCfmAtionId;  //중복 예약방지
	private String affiCustId;  	//고객ID
	private String chargeableRate;  //청구총금액
	private String saleJtbAmt;      // 
	private String specialInfo;		//기타 고객 요구사항
	private String fitRsvCd;        //자유여행 예약번호 
	private String currencyCd;
	private String exchangeRate;
	private String pkgSavingsAmount; //패키지 할인 금액
	private String cancelDlJtb;    //jtb 취소마감일시
	private String checkInInst;
	private String specCheckInInst;
	private String cancellationPolicy;
	private String markAmt;
	private String whcExchangeRate;
	
	private String promAmt;			//프로모션 할인금액 추가 2019.07.15 bum
	
	private ArrayList<RoomGrps> roomGrps = new ArrayList<ReqHotelRerveInputVO.RoomGrps>();
	private CreditInfo creditInfo = new CreditInfo();
	private AddrInfo addrInfo = new AddrInfo();
	
	public static class RoomGrps {
		private String numOfAdt;
		private String numOfChd;
		private String bedTypeId;
		private String numOfBeds;
		private String smokingPref;
		private String roomId;
		private String roomTy;
		private ArrayList<GuestInfos> guestInfos = new ArrayList<ReqHotelRerveInputVO.GuestInfos>();
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
		public String getBedTypeId() {
			return bedTypeId;
		}
		public void setBedTypeId(String bedTypeId) {
			this.bedTypeId = bedTypeId;
		}
		public String getNumOfBeds() {
			return numOfBeds;
		}
		public void setNumOfBeds(String numOfBeds) {
			this.numOfBeds = numOfBeds;
		}
		public String getSmokingPref() {
			return smokingPref;
		}
		public String getRoomId() {
			return roomId;
		}
		public void setRoomId(String roomId) {
			this.roomId = roomId;
		}
		public String getRoomTy() {
			return roomTy;
		}
		public void setRoomTy(String roomTy) {
			this.roomTy = roomTy;
		}
		public void setSmokingPref(String smokingPref) {
			this.smokingPref = smokingPref;
		}
		public ArrayList<GuestInfos> getGuestInfos() {
			return guestInfos;
		}
		public void setGuestInfos(ArrayList<GuestInfos> guestInfos) {
			this.guestInfos = guestInfos;
		}
	}
	
	public static class GuestInfos {
		//private String roomSeq;
		private String childAges; 	//아동투숙객나이
		private String firstName; 	//투숙객 이름
		private String lastName; 	//투숙객 성
		private String guestNmKr; 	//투숙객 한글명
		private String birthDay;    //생년월일
		private String gender;      //성별
		private String tel;			//고객번호
		private String adtFlag; 	//성인여부
		
	/*	public String getRoomSeq() {
			return roomSeq;
		}
		public void setRoomSeq(String roomSeq) {
			this.roomSeq = roomSeq;
		}*/
		public String getChildAges() {
			return childAges;
		}
		public void setChildAges(String childAges) {
			this.childAges = childAges;
		}
		public String getFirstName() {
			return firstName;
		}
		public void setFirstName(String firstName) {
			this.firstName = firstName;
		}
		public String getLastName() {
			return lastName;
		}
		public void setLastName(String lastName) {
			this.lastName = lastName;
		}
		public String getGuestNmKr() {
			return guestNmKr;
		}
		public void setGuestNmKr(String guestNmKr) {
			this.guestNmKr = guestNmKr;
		}
		public String getBirthDay() {
			return birthDay;
		}
		public void setBirthDay(String birthDay) {
			this.birthDay = birthDay;
		}
		public String getGender() {
			return gender;
		}
		public void setGender(String gender) {
			this.gender = gender;
		}
		public String getTel() {
			return tel;
		}
		public void setTel(String tel) {
			this.tel = tel;
		}
		public String getAdtFlag() {
			return adtFlag;
		}
		public void setAdtFlag(String adtFlag) {
			this.adtFlag = adtFlag;
		}
		
	}
	
	//연락처 및 신용카드 정보
	public static class CreditInfo {
		private String email;      //고객 이메일주소
		private String firstName;  //카드보유자의 이름
		private String lastName;  //카드보유자의 성
		private String homePhone; //대표예약자 집 전화번호
		private String workPhone; //대표예약자 직장전화번호
		private String cardType;  //신용카드유형
		private String cardNum;   //신용카드번호
		private String cardExpMonth; //신용카드 만료 월
		private String cardExpYear; //신용카드 만료 년
		private String cardIdentifier;
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getFirstName() {
			return firstName;
		}
		public void setFirstName(String firstName) {
			this.firstName = firstName;
		}
		public String getLastName() {
			return lastName;
		}
		public void setLastName(String lastName) {
			this.lastName = lastName;
		}
		public String getHomePhone() {
			return homePhone;
		}
		public void setHomePhone(String homePhone) {
			this.homePhone = homePhone;
		}
		public String getWorkPhone() {
			return workPhone;
		}
		public void setWorkPhone(String workPhone) {
			this.workPhone = workPhone;
		}
		public String getCardType() {
			return cardType;
		}
		public void setCardType(String cardType) {
			this.cardType = cardType;
		}
		public String getCardNum() {
			return cardNum;
		}
		public void setCardNum(String cardNum) {
			this.cardNum = cardNum;
		}
		public String getCardExpMonth() {
			return cardExpMonth;
		}
		public void setCardExpMonth(String cardExpMonth) {
			this.cardExpMonth = cardExpMonth;
		}
		public String getCardExpYear() {
			return cardExpYear;
		}
		public void setCardExpYear(String cardExpYear) {
			this.cardExpYear = cardExpYear;
		}
		public String getCardIdentifier() {
			return cardIdentifier;
		}
		public void setCardIdentifier(String cardIdentifier) {
			this.cardIdentifier = cardIdentifier;
		}
		
	}
	
	public static class AddrInfo {
		private String addr1;
		private String addr2;
		private String addr3;
		private String city;
		private String stateProvinceCd;
		private String countryCd;
		private String postalCd;
		
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
		public String getCity() {
			return city;
		}
		public void setCity(String city) {
			this.city = city;
		}
		public String getStateProvinceCd() {
			return stateProvinceCd;
		}
		public void setStateProvinceCd(String stateProvinceCd) {
			this.stateProvinceCd = stateProvinceCd;
		}
		public String getCountryCd() {
			return countryCd;
		}
		public void setCountryCd(String countryCd) {
			this.countryCd = countryCd;
		}
		public String getPostalCd() {
			return postalCd;
		}
		public void setPostalCd(String postalCd) {
			this.postalCd = postalCd;
		}
		
	}
	
	public String getFitMix() {
		return fitMix;
	}
	public void setFitMix(String fitMix) {
		this.fitMix = fitMix;
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

	public String getCancelDl() {
		return cancelDl;
	}

	public void setCancelDl(String cancelDl) {
		this.cancelDl = cancelDl;
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

	public String getRoomTypeCd() {
		return roomTypeCd;
	}

	public void setRoomTypeCd(String roomTypeCd) {
		this.roomTypeCd = roomTypeCd;
	}
	
	public String getIsBreakFast() {
		return isBreakFast;
	}
	public void setIsBreakFast(String isBreakFast) {
		this.isBreakFast = isBreakFast;
	}
	public String getSalesTax() {
		return salesTax;
	}
	public void setSalesTax(String salesTax) {
		this.salesTax = salesTax;
	}
	public String getAffiCfmAtionId() {
		return affiCfmAtionId;
	}

	public void setAffiCfmAtionId(String affiCfmAtionId) {
		this.affiCfmAtionId = affiCfmAtionId;
	}

	public String getAffiCustId() {
		return affiCustId;
	}

	public void setAffiCustId(String affiCustId) {
		this.affiCustId = affiCustId;
	}

	public String getRateCode() {
		return rateCode;
	}

	public void setRateCode(String rateCode) {
		this.rateCode = rateCode;
	}

	public String getChargeableRate() {
		return chargeableRate;
	}

	public void setChargeableRate(String chargeableRate) {
		this.chargeableRate = chargeableRate;
	}
	public String getSaleJtbAmt() {
		return saleJtbAmt;
	}
	public void setSaleJtbAmt(String saleJtbAmt) {
		this.saleJtbAmt = saleJtbAmt;
	}
	public String getSpecialInfo() {
		return specialInfo;
	}
	public void setSpecialInfo(String specialInfo) {
		this.specialInfo = specialInfo;
	}
	public String getFitRsvCd() {
		return fitRsvCd;
	}
	public void setFitRsvCd(String fitRsvCd) {
		this.fitRsvCd = fitRsvCd;
	}
	public String getCurrencyCd() {
		return currencyCd;
	}
	public void setCurrencyCd(String currencyCd) {
		this.currencyCd = currencyCd;
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
	
	public String getCancelDlJtb() {
		return cancelDlJtb;
	}
	public void setCancelDlJtb(String cancelDlJtb) {
		this.cancelDlJtb = cancelDlJtb;
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
	public String getCancellationPolicy() {
		return cancellationPolicy;
	}
	public void setCancellationPolicy(String cancellationPolicy) {
		this.cancellationPolicy = cancellationPolicy;
	}	
	public String getMarkAmt() {
		return markAmt;
	}
	public void setMarkAmt(String markAmt) {
		this.markAmt = markAmt;
	}
	public String getWhcExchangeRate() {
		return whcExchangeRate;
	}
	public void setWhcExchangeRate(String whcExchangeRate) {
		this.whcExchangeRate = whcExchangeRate;
	}
	public List<RoomGrps> getRoomGrps() {
		return roomGrps;
	}
	public CreditInfo getCreditInfo() {
		return creditInfo;
	}
	public void setCreditInfo(CreditInfo creditInfo) {
		this.creditInfo = creditInfo;
	}
	public AddrInfo getAddrInfo() {
		return addrInfo;
	}
	public void setAddrInfo(AddrInfo addrInfo) {
		this.addrInfo = addrInfo;
	}
	public void setRoomGrps(ArrayList<RoomGrps> roomGrps) {
		this.roomGrps = roomGrps;
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
	public String getPromAmt() {
		return promAmt;
	}
	public void setPromAmt(String promAmt) {
		this.promAmt = promAmt;
	}
}
