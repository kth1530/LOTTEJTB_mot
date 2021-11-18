package com.lottejtb.api.service;

public class CommHotelApiVO {
    
    // EAN 
    private String cid;      //API 계약 번호
    private String Sig;                 //SIG MD5 암호화 값 매번 변경되어야 함.
    private String MinorRev;
    private String ApiKey;
    private String secret;
    private String Locale;    // 지원 로케일 http://developer.ean.com/general-info/hotel-language-options/
    private String currencyCode;
    private String customerIpAddress; //요청 아이피
    private String customerUserAgent;
    private String customerSessionId;
    
    private String CheckInDate;         //체크인 날짜
    private String CheckOutDate;
    
    private int    roomCnt = 0;              //룸수 
    private String numberOfAdults;      //어른 수
    private String numberOfChildren;
    private String ageOfChildren;       //아이가 1명 이상일때 나이순서 , 단위 ( 5,6,7 )
    
    private String countryCode;         //지역 코드
    private String countryNm;
    private String cityCode;            //도시 코드
    private String city;            //도시 코드
    
    private String stateProvinceCode;  //Massachusetts 시/도를 나타내는 두 자리의 코드로, 지정된 도시를 포함합니다.
    private int    numberOfResults;        //응답당 반환할 수 있는 최대 호텔 수. 날짜가 없는 목록 요청의 결과를 제한하지 않습니다.
    
    /* XML 에서 반환되는 호텔 엘리먼트 */
    private String hotelId;
    private String hotelNm_kr;
    private String hotelNm_en;
    private String airPortCode;
    private String supplier;
    private String thumImg;
    private String lat;
    private String longi;
    private String url;
    private String addr;
    private String star;
    private String conts;
    private String highRate;
    private String lowRate;
    private String currency;
    private String tel;
    private String rtn;
    private String userAgent;
    private int uniqueNum;
    
    
    private String syyyy;
    private String smm;
    private String sdd;
    private String eyyyy;
    private String emm;
    private String edd;
    private long Duration;
    
    
    public String getCid() {
        return cid;
    }
    public void setCid(String cid) {
        this.cid = cid;
    }
    public String getSig() {
        return Sig;
    }
    public void setSig(String sig) {
        Sig = sig;
    }
    public String getMinorRev() {
        return MinorRev;
    }
    public void setMinorRev(String minorRev) {
        MinorRev = minorRev;
    }
    public String getApiKey() {
        return ApiKey;
    }
    public void setApiKey(String apiKey) {
        ApiKey = apiKey;
    }
    public String getSecret() {
        return secret;
    }
    public void setSecret(String secret) {
        this.secret = secret;
    }
    public String getLocale() {
        return Locale;
    }
    public void setLocale(String locale) {
        Locale = locale;
    }
    public String getCurrencyCode() {
        return currencyCode;
    }
    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }
    public String getCustomerIpAddress() {
        return customerIpAddress;
    }
    public void setCustomerIpAddress(String customerIpAddress) {
        this.customerIpAddress = customerIpAddress;
    }
    public String getCustomerUserAgent() {
        return customerUserAgent;
    }
    public void setCustomerUserAgent(String customerUserAgent) {
        this.customerUserAgent = customerUserAgent;
    }
    public String getCustomerSessionId() {
        return customerSessionId;
    }
    public void setCustomerSessionId(String customerSessionId) {
        this.customerSessionId = customerSessionId;
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
    public int getRoomCnt() {
        return roomCnt;
    }
    public void setRoomCnt(int roomCnt) {
        this.roomCnt = roomCnt;
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
    public String getAgeOfChildren() {
        return ageOfChildren;
    }
    public void setAgeOfChildren(String ageOfChildren) {
        this.ageOfChildren = ageOfChildren;
    }
    public String getCountryCode() {
        return countryCode;
    }
    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }
    public String getCountryNm() {
        return countryNm;
    }
    public void setCountryNm(String countryNm) {
        this.countryNm = countryNm;
    }
    public String getCityCode() {
        return cityCode;
    }
    public void setCityCode(String cityCode) {
        this.cityCode = cityCode;
    }
    public String getCity() {
        return city;
    }
    public void setCity(String city) {
        this.city = city;
    }
    public String getStateProvinceCode() {
        return stateProvinceCode;
    }
    public void setStateProvinceCode(String stateProvinceCode) {
        this.stateProvinceCode = stateProvinceCode;
    }
    public int getNumberOfResults() {
        return numberOfResults;
    }
    public void setNumberOfResults(int numberOfResults) {
        this.numberOfResults = numberOfResults;
    }
    public String getHotelId() {
        return hotelId;
    }
    public void setHotelId(String hotelId) {
        this.hotelId = hotelId;
    }
    public String getHotelNm_kr() {
        return hotelNm_kr;
    }
    public void setHotelNm_kr(String hotelNm_kr) {
        this.hotelNm_kr = hotelNm_kr;
    }
    public String getHotelNm_en() {
        return hotelNm_en;
    }
    public void setHotelNm_en(String hotelNm_en) {
        this.hotelNm_en = hotelNm_en;
    }
    public String getAirPortCode() {
        return airPortCode;
    }
    public void setAirPortCode(String airPortCode) {
        this.airPortCode = airPortCode;
    }
    public String getSupplier() {
        return supplier;
    }
    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }
    public String getThumImg() {
        return thumImg;
    }
    public void setThumImg(String thumImg) {
        this.thumImg = thumImg;
    }
    public String getLat() {
        return lat;
    }
    public void setLat(String lat) {
        this.lat = lat;
    }
    public String getLongi() {
        return longi;
    }
    public void setLongi(String longi) {
        this.longi = longi;
    }
    public String getUrl() {
        return url;
    }
    public void setUrl(String url) {
        this.url = url;
    }
    public String getAddr() {
        return addr;
    }
    public void setAddr(String addr) {
        this.addr = addr;
    }
    public String getStar() {
        return star;
    }
    public void setStar(String star) {
        this.star = star;
    }
    public String getConts() {
        return conts;
    }
    public void setConts(String conts) {
        this.conts = conts;
    }
    public String getHighRate() {
        return highRate;
    }
    public void setHighRate(String highRate) {
        this.highRate = highRate;
    }
    public String getLowRate() {
        return lowRate;
    }
    public void setLowRate(String lowRate) {
        this.lowRate = lowRate;
    }
    public String getCurrency() {
        return currency;
    }
    public void setCurrency(String currency) {
        this.currency = currency;
    }
    public String getTel() {
        return tel;
    }
    public void setTel(String tel) {
        this.tel = tel;
    }
    public String getRtn() {
        return rtn;
    }
    public void setRtn(String rtn) {
        this.rtn = rtn;
    }
    public String getUserAgent() {
        return userAgent;
    }
    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }
    public int getUniqueNum() {
        return uniqueNum;
    }
    public void setUniqueNum(int uniqueNum) {
        this.uniqueNum = uniqueNum;
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
    
    
              
}