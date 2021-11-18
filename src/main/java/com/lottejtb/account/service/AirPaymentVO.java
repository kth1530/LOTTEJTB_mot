package com.lottejtb.account.service;

public class AirPaymentVO {
	private String fitRsvNo = "";
	private int cashAmt = 0;							// 결제 금액 
	private String actNo = "";						// 입금 계좌번호 
	private String paymtSchDt = "";
	private String paymtSchHm = "";
	private int amtInput = 0;
	private String bankNm = "";
	private int cardPaymtAmt = 0;
	private String cardKiGb = "";
	private String cardInstallmnMn = "";
	private String cardPaymtSeqno = "";
	
	public String getFitRsvNo() {
		return fitRsvNo;
	}
	public void setFitRsvNo(String fitRsvNo) {
		this.fitRsvNo = fitRsvNo;
	}
	public int getCashAmt() {
		return cashAmt;
	}
	public void setCashAmt(int cashAmt) {
		this.cashAmt = cashAmt;
	}
	public String getActNo() {
		return actNo;
	}
	public void setActNo(String actNo) {
		this.actNo = actNo;
	}
	public String getPaymtSchDt() {
		return paymtSchDt;
	}
	public void setPaymtSchDt(String paymtSchDt) {
		this.paymtSchDt = paymtSchDt;
	}
	public String getPaymtSchHm() {
		return paymtSchHm;
	}
	public void setPaymtSchHm(String paymtSchHm) {
		this.paymtSchHm = paymtSchHm;
	}
	public int getAmtInput() {
		return amtInput;
	}
	public void setAmtInput(int amtInput) {
		this.amtInput = amtInput;
	}
	public String getBankNm() {
		return bankNm;
	}
	public void setBankNm(String bankNm) {
		this.bankNm = bankNm;
	}
	public int getCardPaymtAmt() {
		return cardPaymtAmt;
	}
	public void setCardPaymtAmt(int cardPaymtAmt) {
		this.cardPaymtAmt = cardPaymtAmt;
	}
	public String getCardKiGb() {
		return cardKiGb;
	}
	public void setCardKiGb(String cardKiGb) {
		this.cardKiGb = cardKiGb;
	}
	public String getCardInstallmnMn() {
		return cardInstallmnMn;
	}
	public void setCardInstallmnMn(String cardInstallmnMn) {
		this.cardInstallmnMn = cardInstallmnMn;
	}
	public String getCardPaymtSeqno() {
		return cardPaymtSeqno;
	}
	public void setCardPaymtSeqno(String cardPaymtSeqno) {
		this.cardPaymtSeqno = cardPaymtSeqno;
	}
	
	
	
}
