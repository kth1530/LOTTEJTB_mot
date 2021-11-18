package com.lottejtb.goods.rn.service;

public class RNWeatherVO {
	private String opCd = "";
	private String countryCd = "";
	private String cityCd = "";
	private String cityKnm = "";
	private String countryNm = "";
	
	private int maxTemper = 0;
	private int minTemper = 0;
	private int weatCd = 0;
	private String weatNm = "";
	private int dayCnt = 0;
	
	private String schdId = "";
	private String eventCd = "";
	private String weatDt = "";
	
	public String getWeatDt() {
		return weatDt;
	}
	public void setWeatDt(String weatDt) {
		this.weatDt = weatDt;
	}
	public String getOpCd() {
		return opCd;
	}
	public void setOpCd(String opCd) {
		this.opCd = opCd;
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
	public String getCityKnm() {
		return cityKnm;
	}
	public void setCityKnm(String cityKnm) {
		this.cityKnm = cityKnm;
	}
	public String getCountryNm() {
		return countryNm;
	}
	public void setCountryNm(String countryNm) {
		this.countryNm = countryNm;
	}
	public int getMaxTemper() {
		return maxTemper;
	}
	public void setMaxTemper(int maxTemper) {
		this.maxTemper = maxTemper;
	}
	public int getMinTemper() {
		return minTemper;
	}
	public void setMinTemper(int minTemper) {
		this.minTemper = minTemper;
	}
	public int getWeatCd() {
		return weatCd;
	}
	public void setWeatCd(int weatCd) {
		this.weatCd = weatCd;
	}
	public String getWeatNm() {
		return weatNm;
	}
	public void setWeatNm(String weatNm) {
		this.weatNm = weatNm;
	}
	public int getDayCnt() {
		return dayCnt;
	}
	public void setDayCnt(int dayCnt) {
		this.dayCnt = dayCnt;
	}
	public String getSchdId() {
		return schdId;
	}
	public void setSchdId(String schdId) {
		this.schdId = schdId;
	}
	public String getEventCd() {
		return eventCd;
	}
	public void setEventCd(String eventCd) {
		this.eventCd = eventCd;
	}
}
