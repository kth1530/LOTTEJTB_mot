package com.lottejtb.api.service;

import java.util.ArrayList;

public class FUARI0006VO {
	
	private ArrayList<FUARI0006DataVO> data = new ArrayList<FUARI0006DataVO>();
	
	private String message;	
	private String code;
	
	public ArrayList<FUARI0006DataVO> getData() {
		return data;
	}
	public void setData(ArrayList<FUARI0006DataVO> data) {
		this.data = data;
	}
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
}
