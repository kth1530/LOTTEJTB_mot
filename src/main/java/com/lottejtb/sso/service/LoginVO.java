package com.lottejtb.sso.service;

public class LoginVO {
	
	private String loginId;  //아이디
	private String password;  //패스워드
	private String sid;      //사이트 식별자
	private String sch;      //앱여부구분값
	private String returnUrl;  //리턴URL
	private String redirect_fg; //로그아웃 프로세스의 구분   Y 인경우 로그아웃 처리 이후 화면전환필요
	
	private String cust_id;  //고객아이디
	private String cust_cd;//고객코드
	private String res_cd; //예약번호
	private String res_nm; //예약자명
	private String email;  //이메일
	private String openType;   //팝업여부
	private String aceTkn;
	
	private String r_phoneno; //휴대폰번호
	
	public String getAceTkn() {
		return aceTkn;
	}
	public void setAceTkn(String aceTkn) {
		this.aceTkn = aceTkn;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getSch() {
		return sch;
	}
	public void setSch(String sch) {
		this.sch = sch;
	}
	public String getReturnUrl() {
		return returnUrl;
	}
	public void setReturnUrl(String returnUrl) {
		this.returnUrl = returnUrl;
	}
	public String getOpenType() {
		return openType;
	}
	public void setOpenType(String openType) {
		this.openType = openType;
	}
	public String getRedirect_fg() {
		return redirect_fg;
	}
	public void setRedirect_fg(String redirect_fg) {
		this.redirect_fg = redirect_fg;
	}
//	public String getCust_id() {
//		return cust_id;
//	}
//	public void setCust_id(String cust_id) {
//		this.cust_id = cust_id;
//	}
	public String getCust_cd() {
		return cust_cd;
	}
	public void setCust_cd(String cust_cd) {
		this.cust_cd = cust_cd;
	}
	public String getRes_cd() {
		return res_cd;
	}
	public void setRes_cd(String res_cd) {
		this.res_cd = res_cd;
	}
	public String getRes_nm() {
		return res_nm;
	}
	public void setRes_nm(String res_nm) {
		this.res_nm = res_nm;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCust_id() {
		return cust_id;
	}
	public void setCust_id(String cust_id) {
		this.cust_id = cust_id;
	}
	
	public String getR_phoneno() {
		return r_phoneno;
	}
	public void setR_phoneno(String r_phoneno) {
		this.r_phoneno = r_phoneno;
	}
	
}
