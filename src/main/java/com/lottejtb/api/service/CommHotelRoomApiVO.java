package com.lottejtb.api.service;

public class CommHotelRoomApiVO {
    
    private String uniqueNum;
    
    // EAN 
    private String hotelId;
    private String arrivalDate;
    private String departureDate;
    private String hotelName_Kr;
    private String hotelName_En;
    private String supplier;    // 공급자
    private String thumImg1;     // 썸네일이미지
    private String thumImg2;     // 썸네일이미지
    private String thumImg3;     // 썸네일이미지
    private String thumImg4;     // 썸네일이미지
    private String hotelAddress;
    private String hotelCity;
    private String hotelStateProvince;
    private String hotelCountry;
    private String numberOfRoomsRequested; //요청 방수 
    private String checkInInstructions; // 출발전 알아둘 사항
    private String tripAdvisorRating;
    private String tripAdvisorReviewCount;  //리뷰 카운트
    private String tripAdvisorRatingUrl;    // 리뷰 트립어드바이져 등급
    
    /** Loop **/
    private String rateCode;
    private String roomTypeCode;
    private String rateDesc;
    private String roomTypeDesc;
    private String propertyId;
    private String BedTypesSize;
    private String BedTypeId;
    private String BedTypeDesc;
    private String smokingPrefer;  // NS : 비흡연, S:흡연 E:둘중 하나
    private int quotedOccupancy;  //추가 요금을 제외한 객실 수용 최대 가능 인원
    private String rateKey; // 검색 요인 및 가격을 결정하는 기타 값에 대한 키 . 검색이 될때마다 새 값을 얻어야 함.
    
    private String promoDesc; //프로모션 설명
    private String promoId; // 프로모션 상품의 ID입니다
    private boolean promo; //프로모션 요금 적용 유무 
    private boolean priceBreakdown; // 청구된 전체 요금 내역에 세금과 총금액이 포함되어 있는지 나타냅니다.
    
    private int lowRate; //프로모션이 적용이후  숙박비 
    private int highRate; //프로모션이 적용이후  숙박비 
    private int lowbaseRate; //프로모션이 적용전  숙박비 
    private int highbaseRate; //프로모션이 적용전  숙박비 
    
    
    private String maxNightlyRate; //ChargeableRateInfo arttribute 반환된 모든 요금에서 가장 높은 1박 요금입니다.
    private int total; // 예약에 청구되는 모든 숙박비, 세금 및 추가 요금의 총합입니다. 고객에게 표시되어야 하는 전체 값이며 예약 요청에 포함됩니다.
    private String currencyCode; //반환된 요금에 대한 통화 코드 

    private String CheckInDate;         //체크인 날짜
    private String CheckOutDate;        //체크 아웃 날짜
    
    private String syyyy;
    private String smm;
    private String sdd;
    private String eyyyy;
    private String emm;
    private String edd;
    private long Duration;
    
    private int    NumberOfAdults;
    private String NumberOfChildren;
    private String ageOfChildren;  //아이가 1명 이상일때 나이순서 , 단위 ( 5,6,7 )
    
    
    private String customerSessionId;
    
    private String img1;
    private String img2;
    private String img3;
    private String img4;
    
    
    public String getUniqueNum() {
        return uniqueNum;
    }
    public void setUniqueNum(String uniqueNum) {
        this.uniqueNum = uniqueNum;
    }
    public String getHotelId() {
        return hotelId;
    }
    public void setHotelId(String hotelId) {
        this.hotelId = hotelId;
    }
    public String getArrivalDate() {
        return arrivalDate;
    }
    public void setArrivalDate(String arrivalDate) {
        this.arrivalDate = arrivalDate;
    }
    public String getDepartureDate() {
        return departureDate;
    }
    public void setDepartureDate(String departureDate) {
        this.departureDate = departureDate;
    }
    public String getHotelName_Kr() {
        return hotelName_Kr;
    }
    public void setHotelName_Kr(String hotelName_Kr) {
        this.hotelName_Kr = hotelName_Kr;
    }
    public String getHotelName_En() {
        return hotelName_En;
    }
    public void setHotelName_En(String hotelName_En) {
        this.hotelName_En = hotelName_En;
    }
    public String getSupplier() {
        return supplier;
    }
    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }
    public String getThumImg1() {
        return thumImg1;
    }
    public void setThumImg1(String thumImg1) {
        this.thumImg1 = thumImg1;
    }
    public String getThumImg2() {
        return thumImg2;
    }
    public void setThumImg2(String thumImg2) {
        this.thumImg2 = thumImg2;
    }
    public String getThumImg3() {
        return thumImg3;
    }
    public void setThumImg3(String thumImg3) {
        this.thumImg3 = thumImg3;
    }
    public String getThumImg4() {
        return thumImg4;
    }
    public void setThumImg4(String thumImg4) {
        this.thumImg4 = thumImg4;
    }
    public String getHotelAddress() {
        return hotelAddress;
    }
    public void setHotelAddress(String hotelAddress) {
        this.hotelAddress = hotelAddress;
    }
    public String getHotelCity() {
        return hotelCity;
    }
    public void setHotelCity(String hotelCity) {
        this.hotelCity = hotelCity;
    }
    public String getHotelStateProvince() {
        return hotelStateProvince;
    }
    public void setHotelStateProvince(String hotelStateProvince) {
        this.hotelStateProvince = hotelStateProvince;
    }
    public String getHotelCountry() {
        return hotelCountry;
    }
    public void setHotelCountry(String hotelCountry) {
        this.hotelCountry = hotelCountry;
    }
    public String getNumberOfRoomsRequested() {
        return numberOfRoomsRequested;
    }
    public void setNumberOfRoomsRequested(String numberOfRoomsRequested) {
        this.numberOfRoomsRequested = numberOfRoomsRequested;
    }
    public String getCheckInInstructions() {
        return checkInInstructions;
    }
    public void setCheckInInstructions(String checkInInstructions) {
        this.checkInInstructions = checkInInstructions;
    }
    public String getTripAdvisorRating() {
        return tripAdvisorRating;
    }
    public void setTripAdvisorRating(String tripAdvisorRating) {
        this.tripAdvisorRating = tripAdvisorRating;
    }
    public String getTripAdvisorReviewCount() {
        return tripAdvisorReviewCount;
    }
    public void setTripAdvisorReviewCount(String tripAdvisorReviewCount) {
        this.tripAdvisorReviewCount = tripAdvisorReviewCount;
    }
    public String getTripAdvisorRatingUrl() {
        return tripAdvisorRatingUrl;
    }
    public void setTripAdvisorRatingUrl(String tripAdvisorRatingUrl) {
        this.tripAdvisorRatingUrl = tripAdvisorRatingUrl;
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
    public String getRateDesc() {
        return rateDesc;
    }
    public void setRateDesc(String rateDesc) {
        this.rateDesc = rateDesc;
    }
    public String getRoomTypeDesc() {
        return roomTypeDesc;
    }
    public void setRoomTypeDesc(String roomTypeDesc) {
        this.roomTypeDesc = roomTypeDesc;
    }
    public String getPropertyId() {
        return propertyId;
    }
    public void setPropertyId(String propertyId) {
        this.propertyId = propertyId;
    }
    public String getBedTypesSize() {
        return BedTypesSize;
    }
    public void setBedTypesSize(String bedTypesSize) {
        BedTypesSize = bedTypesSize;
    }
    public String getBedTypeId() {
        return BedTypeId;
    }
    public void setBedTypeId(String bedTypeId) {
        BedTypeId = bedTypeId;
    }
    public String getBedTypeDesc() {
        return BedTypeDesc;
    }
    public void setBedTypeDesc(String bedTypeDesc) {
        BedTypeDesc = bedTypeDesc;
    }
    public String getSmokingPrefer() {
        return smokingPrefer;
    }
    public void setSmokingPrefer(String smokingPrefer) {
        this.smokingPrefer = smokingPrefer;
    }
    public int getQuotedOccupancy() {
        return quotedOccupancy;
    }
    public void setQuotedOccupancy(int quotedOccupancy) {
        this.quotedOccupancy = quotedOccupancy;
    }
    public String getRateKey() {
        return rateKey;
    }
    public void setRateKey(String rateKey) {
        this.rateKey = rateKey;
    }
    public String getPromoDesc() {
        return promoDesc;
    }
    public void setPromoDesc(String promoDesc) {
        this.promoDesc = promoDesc;
    }
    public String getPromoId() {
        return promoId;
    }
    public void setPromoId(String promoId) {
        this.promoId = promoId;
    }
    public boolean isPromo() {
        return promo;
    }
    public void setPromo(boolean promo) {
        this.promo = promo;
    }
    public boolean isPriceBreakdown() {
        return priceBreakdown;
    }
    public void setPriceBreakdown(boolean priceBreakdown) {
        this.priceBreakdown = priceBreakdown;
    }
    public int getLowRate() {
        return lowRate;
    }
    public void setLowRate(int lowRate) {
        this.lowRate = lowRate;
    }
    public int getHighRate() {
        return highRate;
    }
    public void setHighRate(int highRate) {
        this.highRate = highRate;
    }
    public int getLowbaseRate() {
        return lowbaseRate;
    }
    public void setLowbaseRate(int lowbaseRate) {
        this.lowbaseRate = lowbaseRate;
    }
    public int getHighbaseRate() {
        return highbaseRate;
    }
    public void setHighbaseRate(int highbaseRate) {
        this.highbaseRate = highbaseRate;
    }
    public String getMaxNightlyRate() {
        return maxNightlyRate;
    }
    public void setMaxNightlyRate(String maxNightlyRate) {
        this.maxNightlyRate = maxNightlyRate;
    }
    public int getTotal() {
        return total;
    }
    public void setTotal(int total) {
        this.total = total;
    }
    public String getCurrencyCode() {
        return currencyCode;
    }
    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }
    public String getCheckInDate() {
        return CheckInDate;
    }
    public void setCheckInDate(String checkInDate) {
        CheckInDate = checkInDate;
    }
    public String getCheckOutDate() {
        return CheckOutDate;
    }
    public void setCheckOutDate(String checkOutDate) {
        CheckOutDate = checkOutDate;
    }
    public String getSyyyy() {
        return syyyy;
    }
    public void setSyyyy(String syyyy) {
        this.syyyy = syyyy;
    }
    public String getSmm() {
        return smm;
    }
    public void setSmm(String smm) {
        this.smm = smm;
    }
    public String getSdd() {
        return sdd;
    }
    public void setSdd(String sdd) {
        this.sdd = sdd;
    }
    public String getEyyyy() {
        return eyyyy;
    }
    public void setEyyyy(String eyyyy) {
        this.eyyyy = eyyyy;
    }
    public String getEmm() {
        return emm;
    }
    public void setEmm(String emm) {
        this.emm = emm;
    }
    public String getEdd() {
        return edd;
    }
    public void setEdd(String edd) {
        this.edd = edd;
    }
    public long getDuration() {
        return Duration;
    }
    public void setDuration(long duration) {
        Duration = duration;
    }
    public int getNumberOfAdults() {
        return NumberOfAdults;
    }
    public void setNumberOfAdults(int numberOfAdults) {
        NumberOfAdults = numberOfAdults;
    }
    public String getNumberOfChildren() {
        return NumberOfChildren;
    }
    public void setNumberOfChildren(String numberOfChildren) {
        NumberOfChildren = numberOfChildren;
    }
    public String getAgeOfChildren() {
        return ageOfChildren;
    }
    public void setAgeOfChildren(String ageOfChildren) {
        this.ageOfChildren = ageOfChildren;
    }
    public String getCustomerSessionId() {
        return customerSessionId;
    }
    public void setCustomerSessionId(String customerSessionId) {
        this.customerSessionId = customerSessionId;
    }
    public String getImg1() {
        return img1;
    }
    public void setImg1(String img1) {
        this.img1 = img1;
    }
    public String getImg2() {
        return img2;
    }
    public void setImg2(String img2) {
        this.img2 = img2;
    }
    public String getImg3() {
        return img3;
    }
    public void setImg3(String img3) {
        this.img3 = img3;
    }
    public String getImg4() {
        return img4;
    }
    public void setImg4(String img4) {
        this.img4 = img4;
    }
    
                   
}