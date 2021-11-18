package com.lottejtb.comm.service;

import java.io.Serializable;

public class CommMemberVO extends CommDefaultVO {
	
	private int uniquenum;
	private String userid;
	private String usernm;
	private String pwd;
	private String email;
	private String zip;
	private String addr1;
	private String addr2;
	private String tel;
	private String hp;
	private String mtype;
	private String sex;
	private String solar;          // 1: 양력 , 2 : 음력
	private String birth;          // YYYY-MM-DD 
	private String realgubun;      // 실명인증방법(1:실명인증(나이스) 2:공공IPIN )
	private String realdt;         // 실명인증또는공공IPIN인증받은날짜
	private String realcd;         // 실명인증또는공공IPIN코드또는 사업자번호
	
	private String ceonm;          // 회사명
	private String chrnm;          // 담당자
	private String commailrecyn;   // 대표이메일 수신 여부
	private String chremail;       // 담당자 이메일
	private String chrhp;          // 담당자 휴대폰
	private String chrdept;        // 담당자 부서
	private String position;       // 담당자 직급
	private String chremailrecyn;  // 담당자 메일 수신여부
	private String chrtel;         // 담당자 전화번호
	private String chrhprecyn;     // 담당자 sms수신 여부
	
	private String emailauth;      // 이메일인증( 0: FALSE 1:TRUE - 외국인 회원일경우 필요 )
	private String emrecyn;        // 메일 수신여부
	private String smrecyn;        // sms 수신여부
	
	private String outcd;          // 0: 임의 탈퇴, 1:강제탈퇴
	private String outtype;        // PPT에 있는 콤보박스 사유들의 선택값그대로 넣는다.추후 변경이 가능하므로 
	private String outwhy;         // 탈퇴사유 상세
	private String moddt;
	private String wdate;
	
	
	public int getUniquenum() {
		return uniquenum;
	}
	public void setUniquenum(int uniquenum) {
		this.uniquenum = uniquenum;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsernm() {
		return usernm;
	}
	public void setUsernm(String usernm) {
		this.usernm = usernm;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getMtype() {
		return mtype;
	}
	public void setMtype(String mtype) {
		this.mtype = mtype;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getSolar() {
		return solar;
	}
	public void setSolar(String solar) {
		this.solar = solar;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getRealgubun() {
		return realgubun;
	}
	public void setRealgubun(String realgubun) {
		this.realgubun = realgubun;
	}
	public String getRealdt() {
		return realdt;
	}
	public void setRealdt(String realdt) {
		this.realdt = realdt;
	}
	public String getRealcd() {
		return realcd;
	}
	public void setRealcd(String realcd) {
		this.realcd = realcd;
	}
	public String getCeonm() {
		return ceonm;
	}
	public void setCeonm(String ceonm) {
		this.ceonm = ceonm;
	}
	public String getChrnm() {
		return chrnm;
	}
	public void setChrnm(String chrnm) {
		this.chrnm = chrnm;
	}
	public String getCommailrecyn() {
		return commailrecyn;
	}
	public void setCommailrecyn(String commailrecyn) {
		this.commailrecyn = commailrecyn;
	}
	public String getChremail() {
		return chremail;
	}
	public void setChremail(String chremail) {
		this.chremail = chremail;
	}
	public String getChrhp() {
		return chrhp;
	}
	public void setChrhp(String chrhp) {
		this.chrhp = chrhp;
	}
	public String getChrdept() {
		return chrdept;
	}
	public void setChrdept(String chrdept) {
		this.chrdept = chrdept;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getChremailrecyn() {
		return chremailrecyn;
	}
	public void setChremailrecyn(String chremailrecyn) {
		this.chremailrecyn = chremailrecyn;
	}
	public String getChrtel() {
		return chrtel;
	}
	public void setChrtel(String chrtel) {
		this.chrtel = chrtel;
	}
	public String getChrhprecyn() {
		return chrhprecyn;
	}
	public void setChrhprecyn(String chrhprecyn) {
		this.chrhprecyn = chrhprecyn;
	}
	public String getEmailauth() {
		return emailauth;
	}
	public void setEmailauth(String emailauth) {
		this.emailauth = emailauth;
	}
	public String getEmrecyn() {
		return emrecyn;
	}
	public void setEmrecyn(String emrecyn) {
		this.emrecyn = emrecyn;
	}
	public String getSmrecyn() {
		return smrecyn;
	}
	public void setSmrecyn(String smrecyn) {
		this.smrecyn = smrecyn;
	}
	public String getOutcd() {
		return outcd;
	}
	public void setOutcd(String outcd) {
		this.outcd = outcd;
	}
	public String getOuttype() {
		return outtype;
	}
	public void setOuttype(String outtype) {
		this.outtype = outtype;
	}
	public String getOutwhy() {
		return outwhy;
	}
	public void setOutwhy(String outwhy) {
		this.outwhy = outwhy;
	}
	public String getModdt() {
		return moddt;
	}
	public void setModdt(String moddt) {
		this.moddt = moddt;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	
	
	
	
}