package com.lottejtb.account.service;

public class HtlRefundMgtVO {
	
	private String resCd;
	private String cancelYnHtl;
	private String mstRsvNm;
	private String tidNo;
	private String actNo;
	private String fitRsvNo;
	private String htlPaymtstateGb;
	
	public String getResCd() {
		return resCd;
	}
	public String getMstRsvNm() {
		return mstRsvNm;
	}
	public void setMstRsvNm(String mstRsvNm) {
		this.mstRsvNm = mstRsvNm;
	}
	public String getTidNo() {
		return tidNo;
	}
	public void setTidNo(String tidNo) {
		this.tidNo = tidNo;
	}
	public String getActNo() {
		return actNo;
	}
	public void setActNo(String actNo) {
		this.actNo = actNo;
	}
	public String getFitRsvNo() {
		return fitRsvNo;
	}
	public void setFitRsvNo(String fitRsvNo) {
		this.fitRsvNo = fitRsvNo;
	}
	public void setResCd(String resCd) {
		this.resCd = resCd;
	}
	public String getCancelYnHtl() {
		return cancelYnHtl;
	}
	public void setCancelYnHtl(String cancelYnHtl) {
		this.cancelYnHtl = cancelYnHtl;
	}
	public String getHtlPaymtstateGb() {
		return htlPaymtstateGb;
	}
	public void setHtlPaymtstateGb(String htlPaymtstateGb) {
		this.htlPaymtstateGb = htlPaymtstateGb;
	}
}
