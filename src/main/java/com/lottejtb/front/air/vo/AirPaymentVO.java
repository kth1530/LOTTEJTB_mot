package com.lottejtb.front.air.vo;

import java.util.ArrayList;

public class AirPaymentVO {
	private String	fitRsvNo;
	private ArrayList<ReqCardInfoVO> cardInfo = new ArrayList<ReqCardInfoVO>();
	private ReqActInfoVO actInfo = new ReqActInfoVO();;
	
	public String getFitRsvNo() {
		return fitRsvNo;
	}
	public void setFitRsvNo(String fitRsvNo) {
		this.fitRsvNo = fitRsvNo;
	}
	public ArrayList<ReqCardInfoVO> getCardInfo() {
		return cardInfo;
	}
	public void setCardInfo(ArrayList<ReqCardInfoVO> cardInfo) {
		this.cardInfo = cardInfo;
	}
	public ReqActInfoVO getActInfo() {
		return actInfo;
	}
	public void setActInfo(ReqActInfoVO actInfo) {
		this.actInfo = actInfo;
	}
}
