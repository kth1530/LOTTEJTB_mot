package com.lottejtb.front.service;

public class SearchRentCityVO {
	private String country;
	private String city;
	private String cityNm;
	private String nationCd;
	private String nationKrNm;
	private String nationEnNm;
	
	private String searchVal;

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getNationCd() {
		return nationCd;
	}

	public void setNationCd(String nationCd) {
		this.nationCd = nationCd;
	}

	public String getNationKrNm() {
		return nationKrNm;
	}

	public void setNationKrNm(String nationKrNm) {
		this.nationKrNm = nationKrNm;
	}

	public String getNationEnNm() {
		return nationEnNm;
	}

	public void setNationEnNm(String nationEnNm) {
		this.nationEnNm = nationEnNm;
	}

	public String getSearchVal() {
		return searchVal;
	}

	public void setSearchVal(String searchVal) {
		this.searchVal = searchVal;
	}

	public String getCityNm() {
		return cityNm;
	}

	public void setCityNm(String cityNm) {
		this.cityNm = cityNm;
	}
	
}
