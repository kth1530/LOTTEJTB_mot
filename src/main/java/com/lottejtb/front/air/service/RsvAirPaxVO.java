package com.lottejtb.front.air.service;

import com.lottejtb.comm.service.CommDefaultVO;

public class RsvAirPaxVO extends CommDefaultVO {

	private static final long serialVersionUID = 8577700345987955827L;

	private int airRsvSeqNo = 0;
	private float paxNo = 0;
	private String genderGb = "";
	private String krNm = "";
	private String enSurNm = "";
	
	private String enFirstNm = "";
	private String passportYn = "";
	private String titleTyGb = "";
	private String paxTyGb = "";
	private String ymd = "";
	
	private String infAccoYn = "";
	private String proofConfYn = "";
	private String proofConfById = "";
	private String proofConfDtt = "";
	private String parentPaxNo = "";
	
	private String tketDtt = "";
	private String reqDtt = "";
	private String hTel = "";
	private String email = "";
	private String regtorId = "";
	
	private String regDtt = "";
	private String modtorId = "";
	private String modDtt = "";
	private String tattodPaxNo = "";
	private int tasfAmt = 0;

	public RsvAirPaxVO() {
		// TODO Auto-generated constructor stub
	}

	public int getTasfAmt() {
		return tasfAmt;
	}

	public void setTasfAmt(int tasfAmt) {
		this.tasfAmt = tasfAmt;
	}
	
	public int getAirRsvSeqNo() {
		return airRsvSeqNo;
	}

	public void setAirRsvSeqNo(int airRsvSeqNo) {
		this.airRsvSeqNo = airRsvSeqNo;
	}

	public float getPaxNo() {
		return paxNo;
	}

	public void setPaxNo(float paxNo) {
		this.paxNo = paxNo;
	}

	public String getGenderGb() {
		return genderGb;
	}

	public void setGenderGb(String genderGb) {
		this.genderGb = genderGb;
	}

	public String getKrNm() {
		return krNm;
	}

	public void setKrNm(String krNm) {
		this.krNm = krNm;
	}

	public String getEnSurNm() {
		return enSurNm;
	}

	public void setEnSurNm(String enSurNm) {
		this.enSurNm = enSurNm;
	}

	public String getEnFirstNm() {
		return enFirstNm;
	}

	public void setEnFirstNm(String enFirstNm) {
		this.enFirstNm = enFirstNm;
	}

	public String getPassportYn() {
		return passportYn;
	}

	public void setPassportYn(String passportYn) {
		this.passportYn = passportYn;
	}

	public String getTitleTyGb() {
		return titleTyGb;
	}

	public void setTitleTyGb(String titleTyGb) {
		this.titleTyGb = titleTyGb;
	}

	public String getPaxTyGb() {
		return paxTyGb;
	}

	public void setPaxTyGb(String paxTyGb) {
		this.paxTyGb = paxTyGb;
	}

	public String getYmd() {
		return ymd;
	}

	public void setYmd(String ymd) {
		this.ymd = ymd;
	}

	public String getInfAccoYn() {
		return infAccoYn;
	}

	public void setInfAccoYn(String infAccoYn) {
		this.infAccoYn = infAccoYn;
	}

	public String getProofConfYn() {
		return proofConfYn;
	}

	public void setProofConfYn(String proofConfYn) {
		this.proofConfYn = proofConfYn;
	}

	public String getProofConfById() {
		return proofConfById;
	}

	public void setProofConfById(String proofConfById) {
		this.proofConfById = proofConfById;
	}

	public String getProofConfDtt() {
		return proofConfDtt;
	}

	public void setProofConfDtt(String proofConfDtt) {
		this.proofConfDtt = proofConfDtt;
	}

	public String getParentPaxNo() {
		return parentPaxNo;
	}

	public void setParentPaxNo(String parentPaxNo) {
		this.parentPaxNo = parentPaxNo;
	}

	public String getTketDtt() {
		return tketDtt;
	}

	public void setTketDtt(String tketDtt) {
		this.tketDtt = tketDtt;
	}

	public String getReqDtt() {
		return reqDtt;
	}

	public void setReqDtt(String reqDtt) {
		this.reqDtt = reqDtt;
	}

	public String gethTel() {
		return hTel;
	}

	public void sethTel(String hTel) {
		this.hTel = hTel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRegtorId() {
		return regtorId;
	}

	public void setRegtorId(String regtorId) {
		this.regtorId = regtorId;
	}

	public String getRegDtt() {
		return regDtt;
	}

	public void setRegDtt(String regDtt) {
		this.regDtt = regDtt;
	}

	public String getModtorId() {
		return modtorId;
	}

	public void setModtorId(String modtorId) {
		this.modtorId = modtorId;
	}

	public String getModDtt() {
		return modDtt;
	}

	public void setModDtt(String modDtt) {
		this.modDtt = modDtt;
	}

	public String getTattodPaxNo() {
		return tattodPaxNo;
	}

	public void setTattodPaxNo(String tattodPaxNo) {
		this.tattodPaxNo = tattodPaxNo;
	}

	
}
