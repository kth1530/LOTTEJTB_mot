package com.lottejtb.comm.service;

public class CommEanAPIVO extends CommDefaultVO {
    
    private String cid;                    //API 계약 번호
    private String sig;                    //SIG MD5 암호화 값 매번 변경되어야 함.
    private String minorRev;               //불러오는 리스트 갯수 
    private String apiKey;                 //계약된 API 키값
    private String locale;                 //
    private String currencyCode;
    private String customerIpAddress;
    private String customerUserAgent;
    private String customerSessionId;
    private String arrivalDate;
    private String departureDate;
    private String numberOfAdults = "0";
    private String numberOfChildren = "0";
    private String childAges;
    private String city;
    private String stateProvinceCode;
    private String countryCode;
    private int numberOfResults = 3;          //결과 리스트 갯수
    
    public String getCid() {
        return cid;
    }
    public void setCid(String cid) {
        this.cid = cid;
    }
    public String getSig() {
        return sig;
    }
    public void setSig(String sig) {
        this.sig = sig;
    }
    public String getMinorRev() {
        return minorRev;
    }
    public void setMinorRev(String minorRev) {
        this.minorRev = minorRev;
    }
    public String getApiKey() {
        return apiKey;
    }
    public void setApiKey(String apiKey) {
        this.apiKey = apiKey;
    }
    public String getLocale() {
        return locale;
    }
    public void setLocale(String locale) {
        this.locale = locale;
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
    public String getChildAges() {
        return childAges;
    }
    public void setChildAges(String childAges) {
        this.childAges = childAges;
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
    public String getCountryCode() {
        return countryCode;
    }
    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }
    public int getNumberOfResults() {
        return numberOfResults;
    }
    public void setNumberOfResults(int numberOfResults) {
        this.numberOfResults = numberOfResults;
    }
    
       
}