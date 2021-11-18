package com.lottejtb.push.service;

/*
 * push 정보 VO
 */

public class PushInfoVO {
	
	private String device_id;  //디바이스아이디
	private String cust_cd;
	private String os_type;  //AND, IOS
	private String device_token; //token 아이디
	private String ins_dt;
	private String ins_id;
	private String upd_dt;
	private String upd_id;
	private String device_model;
	private String os_version;
	private String marketing_yn; //마켓팅 수신동의
	
	//푸쉬통계
	private int total;
	private int tok_null;
	private int tok_not_null;
	private int and_succ;
	private int and_fail;
	private int and_err;
	private int and_not_reg;
	private int ios_succ;
	private int ios_fail;
	private int ios_err1;
	private int ios_err2;
	private int ios_err3;
	private int ios_err4;
	private int ios_err5;

	
	public String getDevice_id() {
		return device_id;
	}
	public void setDevice_id(String device_id) {
		this.device_id = device_id;
	}
	public String getCust_cd() {
		return cust_cd;
	}
	public void setCust_cd(String cust_cd) {
		this.cust_cd = cust_cd;
	}
	public String getOs_type() {
		return os_type;
	}
	public void setOs_type(String os_type) {
		this.os_type = os_type;
	}
	public String getDevice_token() {
		return device_token;
	}
	public void setDevice_token(String device_token) {
		this.device_token = device_token;
	}
	public String getIns_dt() {
		return ins_dt;
	}
	public void setIns_dt(String ins_dt) {
		this.ins_dt = ins_dt;
	}
	public String getIns_id() {
		return ins_id;
	}
	public void setIns_id(String ins_id) {
		this.ins_id = ins_id;
	}
	public String getUpd_dt() {
		return upd_dt;
	}
	public void setUpd_dt(String upd_dt) {
		this.upd_dt = upd_dt;
	}
	public String getUpd_id() {
		return upd_id;
	}
	public void setUpd_id(String upd_id) {
		this.upd_id = upd_id;
	}
	public String getDevice_model() {
		return device_model;
	}
	public void setDevice_model(String device_model) {
		this.device_model = device_model;
	}
	public String getOs_version() {
		return os_version;
	}
	public void setOs_version(String os_version) {
		this.os_version = os_version;
	}
	public String getMarketing_yn() {
		return marketing_yn;
	}
	public void setMarketing_yn(String marketing_yn) {
		this.marketing_yn = marketing_yn;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getTok_null() {
		return tok_null;
	}
	public void setTok_null(int tok_null) {
		this.tok_null = tok_null;
	}
	public int getTok_not_null() {
		return tok_not_null;
	}
	public void setTok_not_null(int tok_not_null) {
		this.tok_not_null = tok_not_null;
	}
	public int getAnd_succ() {
		return and_succ;
	}
	public void setAnd_succ(int and_succ) {
		this.and_succ = and_succ;
	}
	public int getAnd_fail() {
		return and_fail;
	}
	public void setAnd_fail(int and_fail) {
		this.and_fail = and_fail;
	}
	public int getAnd_err() {
		return and_err;
	}
	public void setAnd_err(int and_err) {
		this.and_err = and_err;
	}
	public int getAnd_not_reg() {
		return and_not_reg;
	}
	public void setAnd_not_reg(int and_not_reg) {
		this.and_not_reg = and_not_reg;
	}
	public int getIos_succ() {
		return ios_succ;
	}
	public void setIos_succ(int ios_succ) {
		this.ios_succ = ios_succ;
	}
	public int getIos_fail() {
		return ios_fail;
	}
	public void setIos_fail(int ios_fail) {
		this.ios_fail = ios_fail;
	}
	public int getIos_err1() {
		return ios_err1;
	}
	public void setIos_err1(int ios_err1) {
		this.ios_err1 = ios_err1;
	}
	public int getIos_err2() {
		return ios_err2;
	}
	public void setIos_err2(int ios_err2) {
		this.ios_err2 = ios_err2;
	}
	public int getIos_err3() {
		return ios_err3;
	}
	public void setIos_err3(int ios_err3) {
		this.ios_err3 = ios_err3;
	}
	public int getIos_err4() {
		return ios_err4;
	}
	public void setIos_err4(int ios_err4) {
		this.ios_err4 = ios_err4;
	}
	public int getIos_err5() {
		return ios_err5;
	}
	public void setIos_err5(int ios_err5) {
		this.ios_err5 = ios_err5;
	}

}
