package com.lottejtb.api.service;

import java.util.ArrayList;

public class FUARI0001VO {
	private String message;
	private String code;
	private ArrayList<FUARI0001DataVO> data = new ArrayList<FUARI0001DataVO>();
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public ArrayList<FUARI0001DataVO> getData() {
		return data;
	}
	public void setData(ArrayList<FUARI0001DataVO> data) {
		this.data = data;
	}
}
