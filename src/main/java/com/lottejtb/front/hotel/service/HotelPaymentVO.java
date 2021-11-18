package com.lottejtb.front.hotel.service;

/*
 * 호텔 결제 내역 
 */
public class HotelPaymentVO {
	private double	cashAmt;
	private String	actNo;
	private String	paymtSchDt;
	private String	paymtSchHm;
    private double	amtInput;
    private String	bankNm;
    private String	cardPaymtAmt;
    private String	cardKiGb;
    private String	cardInstallmnMn;
    private String  usePoint;
    private String  giftAmt;
	public double getCashAmt() {
		return cashAmt;
	}
	public void setCashAmt(double cashAmt) {
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
	public double getAmtInput() {
		return amtInput;
	}
	public void setAmtInput(double amtInput) {
		this.amtInput = amtInput;
	}
	public String getBankNm() {
		return bankNm;
	}
	public void setBankNm(String bankNm) {
		this.bankNm = bankNm;
	}
	public String getCardPaymtAmt() {
		return cardPaymtAmt;
	}
	public void setCardPaymtAmt(String cardPaymtAmt) {
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
	public String getUsePoint() {
		return usePoint;
	}
	public void setUsePoint(String usePoint) {
		this.usePoint = usePoint;
	}
	public String getGiftAmt() {
		return giftAmt;
	}
	public void setGiftAmt(String giftAmt) {
		this.giftAmt = giftAmt;
	}
}
