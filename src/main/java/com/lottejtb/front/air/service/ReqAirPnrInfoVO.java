package com.lottejtb.front.air.service;

public class ReqAirPnrInfoVO {
	public String readTy = "R";
	public String gdsCd = "";
	public int rsvSeqno = 0;
	
	public String getReadTy() {
		return readTy;
	}
	public void setReadTy(String readTy) {
		this.readTy = readTy;
	}
	public String getGdsCd() {
		return gdsCd;
	}
	public void setGdsCd(String gdsCd) {
		this.gdsCd = gdsCd;
	}
	public int getRsvSeqno() {
		return rsvSeqno;
	}
	public void setRsvSeqno(int rsvSeqno) {
		this.rsvSeqno = rsvSeqno;
	}


}
