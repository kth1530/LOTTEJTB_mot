package com.lottejtb.front.hotel.service;

import org.apache.commons.lang.builder.ToStringBuilder;

public class ReqMapRadarVO {
	
    private String latitude;
    private String longitude;
    private String radius = "50000";
    private String types;
    private String key = "AIzaSyD7Ofh1fQwL-osDzzlbdvRjvlG2Y8-nEyU";
    private String placeid;
    private String language = "ko";
    private String address;

	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getPlaceid() {
		return placeid;
	}
	public void setPlaceid(String placeid) {
		this.placeid = placeid;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getRadius() {
		return radius;
	}
	public void setRadius(String radius) {
		this.radius = radius;
	}
	public String getTypes() {
		return types;
	}
	public void setTypes(String types) {
		this.types = types;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}