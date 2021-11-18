package com.lottejtb.api.service;

public class FUARI0005VO {

	private FUARI0005DataVO data = new FUARI0005DataVO();
	
	private String message;	
	private String code;
	
	public FUARI0005DataVO getData() {
		return data;
	}
	public void setData(FUARI0005DataVO data) {
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
