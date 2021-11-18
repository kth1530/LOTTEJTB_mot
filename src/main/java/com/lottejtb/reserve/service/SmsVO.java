package com.lottejtb.reserve.service;

import com.lottejtb.comm.service.CommDefaultVO;


/**
* 클래스명    : SMS 보내기 정보를 담고 있는 클래스 
* @ClassDesc  : SMS 보내기 정보를 담고 있는 클래스 
* @FileName   : SmsVO.java
* @TableName  : t4dev/SMS_WAIT 
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.25 /  / 최초작성
*/

public class SmsVO extends CommDefaultVO {
	private static final long serialVersionUID = 6576176470401513751L;
	
	private int serialno = 0;
	private String destcallno = "";
	private String callbackno = "";
	private String type = "";
	private String smsdata = "";
	
	private String jeobsu_time = "";
	private String yeyak_time = "";
	private String start_time = "";
	private String end_time = "";
	private String result = "";
	
	private String reserved = "";
	private String subject = "";
	private int user_no = 0;
	private int company_no = 0;
	private int jeobsu_no = 0;
	
	private int jeobsu_sub_no = 0;
	
	private String res_cd;
	private String remark;

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getRes_cd() {
		return res_cd;
	}

	public void setRes_cd(String res_cd) {
		this.res_cd = res_cd;
	}

	public int getSerialno() {
		return serialno;
	}

	public void setSerialno(int serialno) {
		this.serialno = serialno;
	}

	public String getDestcallno() {
		return destcallno;
	}

	public void setDestcallno(String destcallno) {
		this.destcallno = destcallno;
	}

	public String getCallbackno() {
		return callbackno;
	}

	public void setCallbackno(String callbackno) {
		this.callbackno = callbackno;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSmsdata() {
		return smsdata;
	}

	public void setSmsdata(String smsdata) {
		this.smsdata = smsdata;
	}

	public String getJeobsu_time() {
		return jeobsu_time;
	}

	public void setJeobsu_time(String jeobsu_time) {
		this.jeobsu_time = jeobsu_time;
	}

	public String getYeyak_time() {
		return yeyak_time;
	}

	public void setYeyak_time(String yeyak_time) {
		this.yeyak_time = yeyak_time;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getReserved() {
		return reserved;
	}

	public void setReserved(String reserved) {
		this.reserved = reserved;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public int getCompany_no() {
		return company_no;
	}

	public void setCompany_no(int company_no) {
		this.company_no = company_no;
	}

	public int getJeobsu_no() {
		return jeobsu_no;
	}

	public void setJeobsu_no(int jeobsu_no) {
		this.jeobsu_no = jeobsu_no;
	}

	public int getJeobsu_sub_no() {
		return jeobsu_sub_no;
	}

	public void setJeobsu_sub_no(int jeobsu_sub_no) {
		this.jeobsu_sub_no = jeobsu_sub_no;
	}
}
