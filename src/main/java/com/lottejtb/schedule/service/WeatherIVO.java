package com.lottejtb.schedule.service;

import com.lottejtb.comm.service.CommDefaultVO;

public class WeatherIVO extends CommDefaultVO {

	private static final long serialVersionUID = 9182357514203556941L;
	
	private String country_map_cd = "";
	private String city_map_cd = "";
	private String weat_dt = "";
	private String city_nm = "";
	private String weat_cd = "";
	private String weat_nm = "";
	private String max_temper = "";
	private String min_temper = "";

	private String am_rainfall = "";
	private String pm_rainfall = "";
	private String wind_direction = "";
	private String wind_speed = "";
	
	private String ins_id = "";

	private String weather_img = "";

	public String getCountry_map_cd() {
		return country_map_cd;
	}

	public void setCountry_map_cd(String country_map_cd) {
		this.country_map_cd = country_map_cd;
	}

	public String getCity_map_cd() {
		return city_map_cd;
	}

	public void setCity_map_cd(String city_map_cd) {
		this.city_map_cd = city_map_cd;
	}

	public String getWeat_dt() {
		return weat_dt;
	}

	public void setWeat_dt(String weat_dt) {
		this.weat_dt = weat_dt;
	}

	public String getCity_nm() {
		return city_nm;
	}

	public void setCity_nm(String city_nm) {
		this.city_nm = city_nm;
	}

	public String getWeat_cd() {
		return weat_cd;
	}

	public void setWeat_cd(String weat_cd) {
		this.weat_cd = weat_cd;
	}

	public String getWeat_nm() {
		return weat_nm;
	}

	public void setWeat_nm(String weat_nm) {
		this.weat_nm = weat_nm;
	}

	public String getMax_temper() {
		return max_temper;
	}

	public void setMax_temper(String max_temper) {
		this.max_temper = max_temper;
	}

	public String getMin_temper() {
		return min_temper;
	}

	public void setMin_temper(String min_temper) {
		this.min_temper = min_temper;
	}

	public String getAm_rainfall() {
		return am_rainfall;
	}

	public void setAm_rainfall(String am_rainfall) {
		this.am_rainfall = am_rainfall;
	}

	public String getPm_rainfall() {
		return pm_rainfall;
	}

	public void setPm_rainfall(String pm_rainfall) {
		this.pm_rainfall = pm_rainfall;
	}

	public String getWind_direction() {
		return wind_direction;
	}

	public void setWind_direction(String wind_direction) {
		this.wind_direction = wind_direction;
	}

	public String getWind_speed() {
		return wind_speed;
	}

	public void setWind_speed(String wind_speed) {
		this.wind_speed = wind_speed;
	}

	public String getIns_id() {
		return ins_id;
	}

	public void setIns_id(String ins_id) {
		this.ins_id = ins_id;
	}

	public String getWeather_img() {
		return weather_img;
	}

	public void setWeather_img(String weather_img) {
		this.weather_img = weather_img;
	}
	
	

	
}
