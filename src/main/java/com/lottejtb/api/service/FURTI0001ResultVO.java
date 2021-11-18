package com.lottejtb.api.service;

import java.util.ArrayList;

import com.lottejtb.front.service.ReqRentcarVO;

public class FURTI0001ResultVO {
	/*
	private String message;
	private ReqRentcarVO commRentCarSchVO;
	private ArrayList<ReqRentcarVO> resultList;
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public ReqRentcarVO getCommRentCarSchVO() {
		return commRentCarSchVO;
	}
	public void setCommRentCarSchVO(ReqRentcarVO commRentCarSchVO) {
		this.commRentCarSchVO = commRentCarSchVO;
	}
	public ArrayList<ReqRentcarVO> getResultList() {
		return resultList;
	}
	public void setResultList(ArrayList<ReqRentcarVO> resultList) {
		this.resultList = resultList;
	}
	*/
	private String code;
	private String message;
	
	private Object data;
	
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
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
}
