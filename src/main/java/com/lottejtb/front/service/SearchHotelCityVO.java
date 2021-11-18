package com.lottejtb.front.service;

public class SearchHotelCityVO {
	
	/** INPUT PARAM */
	private String searchVal;
	private String domesticYn;
	
	public String getSearchVal() {
		return searchVal;
	}
	public void setSearchVal(String searchVal) {
		this.searchVal = searchVal;
	}
	
	public String getDomesticYn(){
		return domesticYn;
	}
	
	public void setDomesticYn(String domesticYn){
		this.domesticYn = domesticYn;
	}
	
	
	/** OUTPUT PARAM */
	private String countryCd;
	private String cityNmEn;
	private String cityNmKr;
	private String cityId;
	private String regionNmEn;
	private String countryNm;

	public String getCountryCd() {
		return countryCd;
	}
	public void setCountryCd(String countryCd) {
		this.countryCd = countryCd;
	}
	public String getCityNmEn() {
		return cityNmEn;
	}
	public void setCityNmEn(String cityNmEn) {
		this.cityNmEn = cityNmEn;
	}
	public String getCityNmKr() {
		return cityNmKr;
	}
	public void setCityNmKr(String cityNmKr) {
		this.cityNmKr = cityNmKr;
	}
	public String getCityId() {
		return cityId;
	}
	public void setCityId(String cityId) {
		this.cityId = cityId;
	}
	public String getRegionNmEn() {
		return regionNmEn;
	}
	public void setRegionNmEn(String regionNmEn) {
		this.regionNmEn = regionNmEn;
	}
	public String getCountryNm() {
		return countryNm;
	}
	public void setCountryNm(String countryNm) {
		this.countryNm = countryNm;
	}
	
//	private String countryCd;
//	private String citynmEn;
//	private String citynmKr;
//	private String eanCode;
//	private String gtaCode;
//	private String hpCode;
//	private String bicoCode;
//	private String njoyCode;
//	private String countryNm;
//	
//	public String getCountryNm() {
//		return countryNm;
//	}
//	public void setCountryNm(String countryNm) {
//		this.countryNm = countryNm;
//	}
//	public String getCountryCd() {
//		return countryCd;
//	}
//	public void setCountryCd(String countryCd) {
//		this.countryCd = countryCd;
//	}
//	public String getCitynmEn() {
//		return citynmEn;
//	}
//	public void setCitynmEn(String citynmEn) {
//		this.citynmEn = citynmEn;
//	}
//	public String getCitynmKr() {
//		return citynmKr;
//	}
//	public void setCitynmKr(String citynmKr) {
//		this.citynmKr = citynmKr;
//	}
//	public String getEanCode() {
//		return eanCode;
//	}
//	public void setEanCode(String eanCode) {
//		this.eanCode = eanCode;
//	}
//	public String getGtaCode() {
//		return gtaCode;
//	}
//	public void setGtaCode(String gtaCode) {
//		this.gtaCode = gtaCode;
//	}
//	public String getHpCode() {
//		return hpCode;
//	}
//	public void setHpCode(String hpCode) {
//		this.hpCode = hpCode;
//	}
//	public String getBicoCode() {
//		return bicoCode;
//	}
//	public void setBicoCode(String bicoCode) {
//		this.bicoCode = bicoCode;
//	}
//	public String getNjoyCode() {
//		return njoyCode;
//	}
//	public void setNjoyCode(String njoyCode) {
//		this.njoyCode = njoyCode;
//	}
}
