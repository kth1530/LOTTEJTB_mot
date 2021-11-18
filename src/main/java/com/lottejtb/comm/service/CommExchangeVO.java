package com.lottejtb.comm.service;

public class CommExchangeVO {
	private String excDt;
	private int excSeq;
	private String currCd;
	private float basRate;
	private float buyCash;
	private float selCash;
	private float buyTrns;
	private float selTrns;
	private float buyCheck;
	private float selCheck;
	
	public String getExcDt() {
		return excDt;
	}
	public void setExcDt(String excDt) {
		this.excDt = excDt;
	}
	public int getExcSeq() {
		return excSeq;
	}
	public void setExcSeq(int excSeq) {
		this.excSeq = excSeq;
	}
	public String getCurrCd() {
		return currCd;
	}
	public void setCurrCd(String currCd) {
		this.currCd = currCd;
	}
	public float getBasRate() {
		return basRate;
	}
	public void setBasRate(float basRate) {
		this.basRate = basRate;
	}
	public float getBuyCash() {
		return buyCash;
	}
	public void setBuyCash(float buyCash) {
		this.buyCash = buyCash;
	}
	public float getSelCash() {
		return selCash;
	}
	public void setSelCash(float selCash) {
		this.selCash = selCash;
	}
	public float getBuyTrns() {
		return buyTrns;
	}
	public void setBuyTrns(float buyTrns) {
		this.buyTrns = buyTrns;
	}
	public float getSelTrns() {
		return selTrns;
	}
	public void setSelTrns(float selTrns) {
		this.selTrns = selTrns;
	}
	public float getBuyCheck() {
		return buyCheck;
	}
	public void setBuyCheck(float buyCheck) {
		this.buyCheck = buyCheck;
	}
	public float getSelCheck() {
		return selCheck;
	}
	public void setSelCheck(float selCheck) {
		this.selCheck = selCheck;
	}
}
