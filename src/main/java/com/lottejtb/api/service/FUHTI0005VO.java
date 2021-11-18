package com.lottejtb.api.service;

/*
 * 호텔 예약 취소 (결과데이터)
 */

public class FUHTI0005VO {
	private String code;
	private String message;
	private String cancellationNum; //취소번호
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getCancellationNum() {
		return cancellationNum;
	}
	public void setCancellationNum(String cancellationNum) {
		this.cancellationNum = cancellationNum;
	}
}
