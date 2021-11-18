package com.lottejtb.front.air.service;

import java.util.ArrayList;

public class ReqAirReserveVO{
	private String 	rsvUserId;		// 예약자 아이디
	private String 	rsvUserNm;		// 예약자 명
	private String 	rsvHtel;		// 예약자 휴대전화
	private String 	rsvEmail;		// 예약자 이메일
	private String 	gdsCd;			// GDS 코드
	private String 	availTy;		// 여정 유형
	private String 	routeTy;		// 라우터 유형
	private String 	currency;		// 통화
	private int		totSaleCharge;	// 총 판매금액
	private int		totTaxCharge;	// 총 TAX
	private String 	fmsKey;			// 항공 INF 추가 요청 처리 2017.04.24
	private String  ruleKey;
	private String  pmoId;
	
	private ArrayList<ReqAirSegmentVO> 	segmentGroup 	= new ArrayList<ReqAirSegmentVO>();	// 세그먼트 그룹
	private ArrayList<ReqAirPaxVO> 		paxGroup 		= new ArrayList<ReqAirPaxVO>();		// 탑승자 그룹
	
	
	public String getFmsKey() {
		return fmsKey;
	}
	public void setFmsKey(String fmsKey) {
		this.fmsKey = fmsKey;
	}
	public String getRsvUserId() {
		return rsvUserId;
	}
	public void setRsvUserId(String rsvUserId) {
		this.rsvUserId = rsvUserId;
	}
	public String getRsvUserNm() {
		return rsvUserNm;
	}
	public void setRsvUserNm(String rsvUserNm) {
		this.rsvUserNm = rsvUserNm;
	}
	public String getRsvHtel() {
		return rsvHtel;
	}
	public void setRsvHtel(String rsvHtel) {
		this.rsvHtel = rsvHtel;
	}
	public String getRsvEmail() {
		return rsvEmail;
	}
	public void setRsvEmail(String rsvEmail) {
		this.rsvEmail = rsvEmail;
	}
	public String getGdsCd() {
		return gdsCd;
	}
	public void setGdsCd(String gdsCd) {
		this.gdsCd = gdsCd;
	}
	public String getAvailTy() {
		return availTy;
	}
	public void setAvailTy(String availTy) {
		this.availTy = availTy;
	}
	public String getRouteTy() {
		return routeTy;
	}
	public void setRouteTy(String routeTy) {
		this.routeTy = routeTy;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public int getTotSaleCharge() {
		return totSaleCharge;
	}
	public void setTotSaleCharge(int totSaleCharge) {
		this.totSaleCharge = totSaleCharge;
	}
	public int getTotTaxCharge() {
		return totTaxCharge;
	}
	public void setTotTaxCharge(int totTaxCharge) {
		this.totTaxCharge = totTaxCharge;
	}
	public ArrayList<ReqAirSegmentVO> getSegmentGroup() {
		return segmentGroup;
	}
	public void setSegmentGroup(ArrayList<ReqAirSegmentVO> segmentGroup) {
		this.segmentGroup = segmentGroup;
	}
	public ArrayList<ReqAirPaxVO> getPaxGroup() {
		return paxGroup;
	}
	public void setPaxGroup(ArrayList<ReqAirPaxVO> paxGroup) {
		this.paxGroup = paxGroup;
	}
	public String getRuleKey() {
		return ruleKey;
	}
	public void setRuleKey(String ruleKey) {
		this.ruleKey = ruleKey;
	}
	public String getPmoId() {
		return pmoId;
	}
	public void setPmoId(String pmoId) {
		this.pmoId = pmoId;
	}
}
