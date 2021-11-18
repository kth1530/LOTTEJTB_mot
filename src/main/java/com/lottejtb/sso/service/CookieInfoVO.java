package com.lottejtb.sso.service;


//고객 정보 VO클래스 

public class CookieInfoVO {
	
	private String cust_id="";     
	private String cust_cd="";   	//고객코드
	private String jmno="";      	//고객주민번호
	private String knm="";       	//한글성명
	private String id="";        	//아이디
	private String email="";     	//이메일
	private String sex="";       	//성별
	private String del_yn="";    	//삭제여부
	private String lotte_id=""; 	//롯데통홥회원아이
	private String ins_dt="";    	//등록일
	private String ins_id="";    	//등록자
	private String upd_dt="";    	//수정일시
	private String upd_id="";    	//수정자
	private String custGradeCd="";	//고객등급 코드
	private String custGradeNm=""; 	//고객등급 명
	private String birthday="";		//생년월일
	private String age;  			//나이
	private String mbrCustno; 		
	private String mblNo;
	private String cno;
	private String personalNo;
	private String acesTkn;

	public String getAcesTkn() {
		return acesTkn;
	}
	public void setAcesTkn(String acesTkn) {
		this.acesTkn = acesTkn;
	}
	private String deviceId;
	
	public String getCust_id() {
		return cust_id;
	}
	public void setCust_id(String cust_id) {
		this.cust_id = cust_id;
	}
	public String getCust_cd() {
		return cust_cd;
	}
	public void setCust_cd(String cust_cd) {
		this.cust_cd = cust_cd;
	}
	public String getJmno() {
		return jmno;
	}
	public void setJmno(String jmno) {
		this.jmno = jmno;
	}
	public String getKnm() {
		return knm;
	}
	public void setKnm(String knm) {
		this.knm = knm;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getLotte_id() {
		return lotte_id;
	}
	public void setLotte_id(String lotte_id) {
		this.lotte_id = lotte_id;
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
	public String getCustGradeCd() {
		return custGradeCd;
	}
	public void setCustGradeCd(String custGradeCd) {
		this.custGradeCd = custGradeCd;
	}
	public String getCustGradeNm() {
		return custGradeNm;
	}
	public void setCustGradeNm(String custGradeNm) {
		this.custGradeNm = custGradeNm;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getMbrCustno() {
		return mbrCustno;
	}
	public void setMbrCustno(String mbrCustno) {
		this.mbrCustno = mbrCustno;
	}
	public String getMblNo() {
		return mblNo;
	}
	public void setMblNo(String mblNo) {
		this.mblNo = mblNo;
	}
	public String getCno() {
		return cno;
	}
	public void setCno(String cno) {
		this.cno = cno;
	}
	public String getDeviceId() {
		return deviceId;
	}
	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}
	public String getPersonalNo() {
		return personalNo;
	}
	public void setPersonalNo(String personalNo) {
		this.personalNo = personalNo;
	}
	
}
