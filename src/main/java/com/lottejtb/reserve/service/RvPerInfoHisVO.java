package com.lottejtb.reserve.service;

public class RvPerInfoHisVO {
	public String resCd = "";
	public int resSeq = 0;
	public int hisNo = 0;
	public String sendYn = "";
	public String sendDate = "";
	public String agreeYn = "";
	
	public String agreeDate = "";
	public String agreeType = "";
	
	public String handphone1 = "";
	public String handphone2 = "";
	public String handphone3 = "";
	
	public String insDt = "";
	public String insId = "";
	public String updDt = "";
	
	public String updId = "";
	public String mktAgreeYn = ""; // 마케팅 활용 동의 여부 
	public String childAgreeYn = ""; // 14세 미만 동의 여부 
	
	public String smsAgreeYn = "";		// SMS활용동의
	public String emailAgreeYn = "";	// EMAIL활용동의 	
	
	
	public int getHisNo() {
		return hisNo;
	}
	public void setHisNo(int hisNo) {
		this.hisNo = hisNo;
	}
	public String getHandphone1() {
		return handphone1;
	}
	public void setHandphone1(String handphone1) {
		this.handphone1 = handphone1;
	}
	public String getHandphone2() {
		return handphone2;
	}
	public void setHandphone2(String handphone2) {
		this.handphone2 = handphone2;
	}
	public String getHandphone3() {
		return handphone3;
	}
	public void setHandphone3(String handphone3) {
		this.handphone3 = handphone3;
	}
	public String getResCd() {
		return resCd;
	}
	public void setResCd(String resCd) {
		this.resCd = resCd;
	}
	public int getResSeq() {
		return resSeq;
	}
	public void setResSeq(int resSeq) {
		this.resSeq = resSeq;
	}
	public String getSendYn() {
		return sendYn;
	}
	public void setSendYn(String sendYn) {
		this.sendYn = sendYn;
	}
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
	public String getAgreeYn() {
		return agreeYn;
	}
	public void setAgreeYn(String agreeYn) {
		this.agreeYn = agreeYn;
	}
	public String getAgreeDate() {
		return agreeDate;
	}
	public void setAgreeDate(String agreeDate) {
		this.agreeDate = agreeDate;
	}
	public String getAgreeType() {
		return agreeType;
	}
	public void setAgreeType(String agreeType) {
		this.agreeType = agreeType;
	}
	public String getInsDt() {
		return insDt;
	}
	public void setInsDt(String insDt) {
		this.insDt = insDt;
	}
	public String getInsId() {
		return insId;
	}
	public void setInsId(String insId) {
		this.insId = insId;
	}
	public String getUpdDt() {
		return updDt;
	}
	public void setUpdDt(String updDt) {
		this.updDt = updDt;
	}
	public String getUpdId() {
		return updId;
	}
	public void setUpdId(String updId) {
		this.updId = updId;
	}
	public String getMktAgreeYn() {
		return mktAgreeYn;
	}
	public void setMktAgreeYn(String mktAgreeYn) {
		this.mktAgreeYn = mktAgreeYn;
	}
	public String getChildAgreeYn() {
		return childAgreeYn;
	}
	public void setChildAgreeYn(String childAgreeYn) {
		this.childAgreeYn = childAgreeYn;
	}
	
	public void setSmsAgreeYn(String smsAgreeYn) {
		this.smsAgreeYn = smsAgreeYn;
	}
	public String getSmsAgreeYn() {
		return smsAgreeYn;
	}
	public void setEmailAgreeYn(String emailAgreeYn) {
		this.emailAgreeYn = emailAgreeYn;
	}
	public String getEmailAgreeYn() {
		return emailAgreeYn;
	}		

	

}
