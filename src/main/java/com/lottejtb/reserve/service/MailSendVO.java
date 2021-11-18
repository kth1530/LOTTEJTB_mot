package com.lottejtb.reserve.service;

import com.lottejtb.comm.service.CommDefaultVO;

/**
* 클래스명    : 메일 보내기 정보를 담고 있는 클래스 
* @ClassDesc  : 메일 보내기 정보를 담고 있는 클래스 
* @FileName   : MailSendVO.java
* @TableName  : t4dev/EMS_MAIL_SEND (TBL 안보임)
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.25 /  / 최초작성
*/

public class MailSendVO extends CommDefaultVO {

	private static final long serialVersionUID = 4479573998509052194L;
	
	private int schd_seq = 0;
	
	private String reg_dt = "";
	private String mail_code = "";
	private String mail_nm = "";
	private String to_name = "";
	private String to_email = "";
	
	private String from_name = "";
	private String from_email = "";
	private String subject = "";
	private String contents_mapping = "";
	private String mail_url_mapping = "";
	
	private String send_yn = "";
	private String crt_date = "";
	
	
	public int getSchd_seq() {
		return schd_seq;
	}
	public void setSchd_seq(int schd_seq) {
		this.schd_seq = schd_seq;
	}
	public String getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getMail_code() {
		return mail_code;
	}
	public void setMail_code(String mail_code) {
		this.mail_code = mail_code;
	}
	public String getMail_nm() {
		return mail_nm;
	}
	public void setMail_nm(String mail_nm) {
		this.mail_nm = mail_nm;
	}
	public String getTo_name() {
		return to_name;
	}
	public void setTo_name(String to_name) {
		this.to_name = to_name;
	}
	public String getTo_email() {
		return to_email;
	}
	public void setTo_email(String to_email) {
		this.to_email = to_email;
	}
	public String getFrom_name() {
		return from_name;
	}
	public void setFrom_name(String from_name) {
		this.from_name = from_name;
	}
	public String getFrom_email() {
		return from_email;
	}
	public void setFrom_email(String from_email) {
		this.from_email = from_email;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContents_mapping() {
		return contents_mapping;
	}
	public void setContents_mapping(String contents_mapping) {
		this.contents_mapping = contents_mapping;
	}
	public String getMail_url_mapping() {
		return mail_url_mapping;
	}
	public void setMail_url_mapping(String mail_url_mapping) {
		this.mail_url_mapping = mail_url_mapping;
	}
	public String getSend_yn() {
		return send_yn;
	}
	public void setSend_yn(String send_yn) {
		this.send_yn = send_yn;
	}
	public String getCrt_date() {
		return crt_date;
	}
	public void setCrt_date(String crt_date) {
		this.crt_date = crt_date;
	}
	
	

}
