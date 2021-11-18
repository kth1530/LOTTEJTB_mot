package com.lottejtb.api.service;

import java.util.ArrayList;

public class FUARI0002VO {

	private ArrayList<FUARI0002DataVO> data = new ArrayList<FUARI0002DataVO>();
	
	private String message;	
	private String code;
	
	public ArrayList<FUARI0002DataVO> getData() {
		return data;
	}
	public void setData(ArrayList<FUARI0002DataVO> data) {
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
