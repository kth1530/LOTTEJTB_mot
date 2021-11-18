package com.lottejtb.api.service;

import java.util.ArrayList;
import java.util.List;

import com.lottejtb.prom.service.PromotionHtListVO;

public class FUHTI0001VO {
	
	private String 	code;
	private String 	message;
	private int		resultCnt;
	private ArrayList<Data> data =  new ArrayList<FUHTI0001VO.Data>();
	
	public static class Data {
		private String 	countryCd = ""; // �����ڵ�
		private String 	cityCd = ""; // �����ڵ�
		private String 	cityNm = ""; // ���ø�
		private String 	suplrCd = ""; // ���޻��ڵ�
		private String 	hotelId = ""; // ȣ��ID
		private String 	hotelNmKr = ""; // ȣ�ڸ�-�ѱ�
		private String 	hotelNmEn = ""; // ȣ�ڸ�-����
		private String 	addr1 = ""; // ȣ���ּ�1
		private String 	addr2 = ""; // ȣ���ּ�2
		private String 	hotelRating = ""; // ȣ�ڵ��
		private String 	hotelRatingDisplay = ""; // ��ޱ���
		private String 	lat = ""; // ����
		private String 	lon = ""; // �浵
		private String 	tripAdvRating = ""; // ���� ����
		private int 	tripAdvReviewCnt = 0; // ���� ��
		private String 	tripAdvRatingUrl = ""; // ���� ���� �̹���URL
		private String 	locShortDesc = ""; // ���� ȣ�� ��ġ
		private String 	thumbNailUrl = ""; // ȣ���̹���URL
		private String  exchangeRate = ""; //마크업 
		private String  jtbId = "";
		private String  hotelType ="";
 		private List<RoomDetls> roomDetls 	= new ArrayList<RoomDetls>(); // ���ǻ�
 		private String isRecomm = "";
 		
 		private String	cityId; // JTB 도시코드 추가 2019.02.19
 		
 		
 		private List<LandMarks> landMarks = new ArrayList<LandMarks>();
 		
 		
 		
 		
		public List<LandMarks> getLandMarks() {
			return landMarks;
		}

		public void setLandMarks(List<LandMarks> landMarks) {
			this.landMarks = landMarks;
		}

		public String getIsRecomm() {
			return isRecomm;
		}

		public void setIsRecomm(String isRecomm) {
			this.isRecomm = isRecomm;
		}

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
		
		public String getExchangeRate() {
			return exchangeRate;
		}

		public void setExchangeRate(String exchangeRate) {
			this.exchangeRate = exchangeRate;
		}

		public String getJtbId() {
			return jtbId;
		}

		public void setJtbId(String jtbId) {
			this.jtbId = jtbId;
		}
		
		public String getHotelType() {
			return hotelType;
		}

		public void setHotelType(String hotelType) {
			this.hotelType = hotelType;
		}

		public List<RoomDetls> getRoomDetls() {
			return roomDetls;
		}

		public void setRoomDetls(List<RoomDetls> roomDetls) {
			this.roomDetls = roomDetls;
		}

		public String getCityId() {
			return cityId;
		}

		public void setCityId(String cityId) {
			this.cityId = cityId;
		}
	}

	/**
	   * 20180725 랜드 마크
	   * @author huang
	   *
	   */
  public static class LandMarks {
		
		private String regionId;
		private String regionNmKr;
		private String subClass;
		private String eanId;
		  
		public String getRegionId() {
			return regionId;
		}
		public void setRegionId(String regionId) {
			this.regionId = regionId;
		}
		public String getRegionNmKr() {
			return regionNmKr;
		}
		public void setRegionNmKr(String regionNmKr) {
			this.regionNmKr = regionNmKr;
		}
		public String getSubClass() {
			return subClass;
		}
		public void setSubClass(String subClass) {
			this.subClass = subClass;
		}
		public String getEanId() {
			return eanId;
		}
		public void setEanId(String eanId) {
			this.eanId = eanId;
		}
	      
	  }

	// ���ǻ�
	public static class RoomDetls {
		private String roomTypeCd 			= ""; // ��Ÿ���ڵ�
		private String roomTypeNm 			= ""; // ��Ÿ�Ը�
		private String currencyCd           = ""; // 통화코드 
		private String avgBaseRate 			= ""; // 1����ձ⺻���
		private String avgRate	 			= ""; // 1����տ��
		private String jtbBaseTotal			= "";
		private String jtbTotal				= "";
		private String exchangeRate         = "";  //환율정보
		private String taxAndServiceFee 	= ""; // ���ݹ׺����
		private String smokingPref 			= ""; // �ݿ�������
		private String hotelFee            ="" ; //호텔fee
		private String nonRefundable 		= ""; // ȯ�Ұ��ɿ���
		private String cancellationPolicy 	= ""; // �����å
		private String pkgSavingsAmount 	= ""; //패키지 활인 금액
		private String aplPromTotal;		//프로모션 적용가
		private String promTotal;			//프로모션 할인가
		private String promId;
		private String promTxt;
		private double	amt;
		private String	tyGb;
		private String	diviGb;
		private PromotionHtListVO  promInfo = new PromotionHtListVO();
		private List<ValAdds> valAdds		= new ArrayList<ValAdds>(); // �ΰ�����


		public String getSmokingPref() {
			return smokingPref;
		}

		public void setSmokingPref(String smokingPref) {
			this.smokingPref = smokingPref;
		}
		public String getHotelFee() {
			return hotelFee;
		}

		public void setHotelFee(String hotelFee) {
			this.hotelFee = hotelFee;
		}

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
		public String getCurrencyCd() {
			return currencyCd;
		}

		public void setCurrencyCd(String currencyCd) {
			this.currencyCd = currencyCd;
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
		public String getExchangeRate() {
			return exchangeRate;
		}

		public void setExchangeRate(String exchangeRate) {
			this.exchangeRate = exchangeRate;
		}

		public String getTaxAndServiceFee() {
			return taxAndServiceFee;
		}

		public void setTaxAndServiceFee(String taxAndServiceFee) {
			this.taxAndServiceFee = taxAndServiceFee;
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
		
		public String getPkgSavingsAmount() {
			return pkgSavingsAmount;
		}

		public void setPkgSavingsAmount(String pkgSavingsAmount) {
			this.pkgSavingsAmount = pkgSavingsAmount;
		}

		public void setCancellationPolicy(String cancellationPolicy) {
			this.cancellationPolicy = cancellationPolicy;
		}
		public String getAplPromTotal() {
			return aplPromTotal;
		}

		public void setAplPromTotal(String aplPromTotal) {
			this.aplPromTotal = aplPromTotal;
		}

		public String getPromTotal() {
			return promTotal;
		}

		public void setPromTotal(String promTotal) {
			this.promTotal = promTotal;
		}

		public String getPromId() {
			return promId;
		}

		public void setPromId(String promId) {
			this.promId = promId;
		}

		public String getPromTxt() {
			return promTxt;
		}

		public void setPromTxt(String promTxt) {
			this.promTxt = promTxt;
		}

		public double getAmt() {
			return amt;
		}

		public void setAmt(double amt) {
			this.amt = amt;
		}

		public String getTyGb() {
			return tyGb;
		}

		public void setTyGb(String tyGb) {
			this.tyGb = tyGb;
		}

		public String getDiviGb() {
			return diviGb;
		}

		public void setDiviGb(String diviGb) {
			this.diviGb = diviGb;
		}

		public List<ValAdds> getValAdds() {
			return valAdds;
		}

		public void setValAdds(List<ValAdds> valAdds) {
			this.valAdds = valAdds;
		}

		public PromotionHtListVO getPromInfo() {
			return promInfo;
		}

		public void setPromInfo(PromotionHtListVO promInfo) {
			this.promInfo = promInfo;
		}
		

	}

	// �ΰ�����
	public static class ValAdds {
		private String valueId = ""; // �ΰ����� ID
		private String valueNm = ""; // �ΰ����� ��

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
	public int getResultCnt() {
		return resultCnt;
	}
	public void setResultCnt(int resultCnt) {
		this.resultCnt = resultCnt;
	}
	public ArrayList<Data> getData() {
		return data;
	}
	public void setData(ArrayList<Data> data) {
		this.data = data;
	}
}
