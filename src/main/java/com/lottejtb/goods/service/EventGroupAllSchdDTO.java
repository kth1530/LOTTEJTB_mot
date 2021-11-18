package com.lottejtb.goods.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class EventGroupAllSchdDTO {

	// -------------------------------------------------------------------------
	// 일정표 관련 파라미터 
	// -------------------------------------------------------------------------
	
	private List countryDayPathKr = new ArrayList<Map>();
	private List countryDayPathEn = new ArrayList<Map>();
	private List countryDayPathKrEn = new ArrayList<Map>();
	private List countryDayPathEnKr = new ArrayList<Map>();
	
	private List cityDayPathKr = new ArrayList<Map>();
	private List cityDayPathEn = new ArrayList<Map>();
	private List cityDayPathKrEn = new ArrayList<Map>();
	private List cityDayPathEnKr = new ArrayList<Map>();
	
	private String countryFullPathKr = "";
	private String countryFullPathEn = "";
	private String countryFullPathKrEn = "";
	private String countryFullPathEnKr = "";
	
	private String cityFullPathKr = "";
	private String cityFullPathEn = "";
	private String cityFullPathKrEn = "";
	private String cityFullPathEnKr = "";
	
	private int maxDayCnt = 0; // 총 일정 수 
	private List<AreaInfoVO> rnGroupAreaDTO = null;	// 지역 정보 
	private List<HotelInfoVO> rnGroupHotelAllDTO = null; // 호텔 정보 
	
	public List getCountryDayPathKr() {
		return countryDayPathKr;
	}
	public void setCountryDayPathKr(List countryDayPathKr) {
		this.countryDayPathKr = countryDayPathKr;
	}
	public List getCountryDayPathEn() {
		return countryDayPathEn;
	}
	public void setCountryDayPathEn(List countryDayPathEn) {
		this.countryDayPathEn = countryDayPathEn;
	}
	public List getCountryDayPathKrEn() {
		return countryDayPathKrEn;
	}
	public void setCountryDayPathKrEn(List countryDayPathKrEn) {
		this.countryDayPathKrEn = countryDayPathKrEn;
	}
	public List getCountryDayPathEnKr() {
		return countryDayPathEnKr;
	}
	public void setCountryDayPathEnKr(List countryDayPathEnKr) {
		this.countryDayPathEnKr = countryDayPathEnKr;
	}
	public List getCityDayPathKr() {
		return cityDayPathKr;
	}
	public void setCityDayPathKr(List cityDayPathKr) {
		this.cityDayPathKr = cityDayPathKr;
	}
	public List getCityDayPathEn() {
		return cityDayPathEn;
	}
	public void setCityDayPathEn(List cityDayPathEn) {
		this.cityDayPathEn = cityDayPathEn;
	}
	public List getCityDayPathKrEn() {
		return cityDayPathKrEn;
	}
	public void setCityDayPathKrEn(List cityDayPathKrEn) {
		this.cityDayPathKrEn = cityDayPathKrEn;
	}
	public List getCityDayPathEnKr() {
		return cityDayPathEnKr;
	}
	public void setCityDayPathEnKr(List cityDayPathEnKr) {
		this.cityDayPathEnKr = cityDayPathEnKr;
	}
	public String getCountryFullPathKr() {
		return countryFullPathKr;
	}
	public void setCountryFullPathKr(String countryFullPathKr) {
		this.countryFullPathKr = countryFullPathKr;
	}
	public String getCountryFullPathEn() {
		return countryFullPathEn;
	}
	public void setCountryFullPathEn(String countryFullPathEn) {
		this.countryFullPathEn = countryFullPathEn;
	}
	public String getCountryFullPathKrEn() {
		return countryFullPathKrEn;
	}
	public void setCountryFullPathKrEn(String countryFullPathKrEn) {
		this.countryFullPathKrEn = countryFullPathKrEn;
	}
	public String getCountryFullPathEnKr() {
		return countryFullPathEnKr;
	}
	public void setCountryFullPathEnKr(String countryFullPathEnKr) {
		this.countryFullPathEnKr = countryFullPathEnKr;
	}
	public String getCityFullPathKr() {
		return cityFullPathKr;
	}
	public void setCityFullPathKr(String cityFullPathKr) {
		this.cityFullPathKr = cityFullPathKr;
	}
	public String getCityFullPathEn() {
		return cityFullPathEn;
	}
	public void setCityFullPathEn(String cityFullPathEn) {
		this.cityFullPathEn = cityFullPathEn;
	}
	public String getCityFullPathKrEn() {
		return cityFullPathKrEn;
	}
	public void setCityFullPathKrEn(String cityFullPathKrEn) {
		this.cityFullPathKrEn = cityFullPathKrEn;
	}
	public String getCityFullPathEnKr() {
		return cityFullPathEnKr;
	}
	public void setCityFullPathEnKr(String cityFullPathEnKr) {
		this.cityFullPathEnKr = cityFullPathEnKr;
	}
	public int getMaxDayCnt() {
		return maxDayCnt;
	}
	public void setMaxDayCnt(int maxDayCnt) {
		this.maxDayCnt = maxDayCnt;
	}
	public List<AreaInfoVO> getRnGroupAreaDTO() {
		return rnGroupAreaDTO;
	}
	public void setRnGroupAreaDTO(List<AreaInfoVO> rnGroupAreaDTO) {
		this.rnGroupAreaDTO = rnGroupAreaDTO;
	}
	public List<HotelInfoVO> getRnGroupHotelAllDTO() {
		return rnGroupHotelAllDTO;
	}
	public void setRnGroupHotelAllDTO(List<HotelInfoVO> rnGroupHotelAllDTO) {
		this.rnGroupHotelAllDTO = rnGroupHotelAllDTO;
	}
	
	

}
