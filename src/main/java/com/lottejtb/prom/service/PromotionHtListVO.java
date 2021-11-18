package com.lottejtb.prom.service;

public class PromotionHtListVO {
	private String	promId;    
	private String	concMix;   
	private String	carrierCd; 
	private String	cabin;     
	private String	adtTyGb;   
	private String	adtDiviGb;  
	private String	adtAmt;
	private String	gdsTyGb;   
	private String	suplrId;     
	private String	htlNationCd; 
	private String	htlCtCd;     
	private String	htlCd;       
	private String	tyGb;        
	private String	diviGb;      
	private String	amt;
	private int		amount;
	private String	promRate;
	private String	fitRsvNo;
	private String 	userId;
	private String	aplPromTotal;		//프로모션 적용가
	private int		promTotal;			//프로모션 할인가
	private String	promTxt;
	private String	checkinDt;			//YYYY-MM-DD
	private String	htlCoalCardGb;
	private String	airCoalCardGb;
	private String	coalCardNm;
	private String	promIdAir;
	private String	promIdHtl;
	private String	gbnDate;
	private String	enDt;
	private String	stDt;
	private String[] startDt;
	private String	promNm;
	private String	coalCardGb;

	// 출국일 파라메터 조회용 추가 UI단 depDt 와는 별도 문정호
    private String depDt;

	public String getPromId() {
		return promId;
	}

	public void setPromId(String promId) {
		this.promId = promId;
	}

	public String getConcMix() {
		return concMix;
	}

	public void setConcMix(String concMix) {
		this.concMix = concMix;
	}

	public String getCarrierCd() {
		return carrierCd;
	}

	public void setCarrierCd(String carrierCd) {
		this.carrierCd = carrierCd;
	}

	public String getCabin() {
		return cabin;
	}

	public void setCabin(String cabin) {
		this.cabin = cabin;
	}

	public String getAdtTyGb() {
		return adtTyGb;
	}

	public void setAdtTyGb(String adtTyGb) {
		this.adtTyGb = adtTyGb;
	}

	public String getAdtDiviGb() {
		return adtDiviGb;
	}

	public void setAdtDiviGb(String adtDiviGb) {
		this.adtDiviGb = adtDiviGb;
	}

	public String getAdtAmt() {
		return adtAmt;
	}

	public void setAdtAmt(String adtAmt) {
		this.adtAmt = adtAmt;
	}

	public String getGdsTyGb() {
		return gdsTyGb;
	}

	public void setGdsTyGb(String gdsTyGb) {
		this.gdsTyGb = gdsTyGb;
	}

	public String getSuplrId() {
		return suplrId;
	}

	public void setSuplrId(String suplrId) {
		this.suplrId = suplrId;
	}

	public String getHtlNationCd() {
		return htlNationCd;
	}

	public void setHtlNationCd(String htlNationCd) {
		this.htlNationCd = htlNationCd;
	}

	public String getHtlCtCd() {
		return htlCtCd;
	}

	public void setHtlCtCd(String htlCtCd) {
		this.htlCtCd = htlCtCd;
	}

	public String getHtlCd() {
		return htlCd;
	}

	public void setHtlCd(String htlCd) {
		this.htlCd = htlCd;
	}

	public String getTyGb() {
		return tyGb;
	}

	public void setTyGb(String tyGb) {
		this.tyGb = tyGb;
	}

	public String getDiviGb() {
		return diviGb;
	}

	public void setDiviGb(String diviGb) {
		this.diviGb = diviGb;
	}

	public String getAmt() {
		return amt;
	}

	public void setAmt(String amt) {
		this.amt = amt;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getPromRate() {
		return promRate;
	}

	public void setPromRate(String promRate) {
		this.promRate = promRate;
	}

	public String getFitRsvNo() {
		return fitRsvNo;
	}

	public void setFitRsvNo(String fitRsvNo) {
		this.fitRsvNo = fitRsvNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getAplPromTotal() {
		return aplPromTotal;
	}

	public void setAplPromTotal(String aplPromTotal) {
		this.aplPromTotal = aplPromTotal;
	}

	public int getPromTotal() {
		return promTotal;
	}

	public void setPromTotal(int promTotal) {
		this.promTotal = promTotal;
	}

	public String getPromTxt() {
		return promTxt;
	}

	public void setPromTxt(String promTxt) {
		this.promTxt = promTxt;
	}

	public String getCheckinDt() {
		return checkinDt;
	}

	public void setCheckinDt(String checkinDt) {
		this.checkinDt = checkinDt;
	}

	public String getHtlCoalCardGb() {
		return htlCoalCardGb;
	}

	public void setHtlCoalCardGb(String htlCoalCardGb) {
		this.htlCoalCardGb = htlCoalCardGb;
	}

	public String getAirCoalCardGb() {
		return airCoalCardGb;
	}

	public void setAirCoalCardGb(String airCoalCardGb) {
		this.airCoalCardGb = airCoalCardGb;
	}

	public String getCoalCardNm() {
		return coalCardNm;
	}

	public void setCoalCardNm(String coalCardNm) {
		this.coalCardNm = coalCardNm;
	}

	public String getPromIdAir() {
		return promIdAir;
	}

	public void setPromIdAir(String promIdAir) {
		this.promIdAir = promIdAir;
	}

	public String getPromIdHtl() {
		return promIdHtl;
	}

	public void setPromIdHtl(String promIdHtl) {
		this.promIdHtl = promIdHtl;
	}

	public String getGbnDate() {
		return gbnDate;
	}

	public void setGbnDate(String gbnDate) {
		this.gbnDate = gbnDate;
	}

	public String getEnDt() {
		return enDt;
	}

	public void setEnDt(String enDt) {
		this.enDt = enDt;
	}

	public String getStDt() {
		return stDt;
	}

	public void setStDt(String stDt) {
		this.stDt = stDt;
	}

	public String[] getStartDt() {
		return startDt;
	}

	public void setStartDt(String[] startDt) {
		this.startDt = startDt;
	}

	public String getPromNm() {
		return promNm;
	}

	public void setPromNm(String promNm) {
		this.promNm = promNm;
	}

	public String getCoalCardGb() {
		return coalCardGb;
	}

	public void setCoalCardGb(String coalCardGb) {
		this.coalCardGb = coalCardGb;
	}

	public String getDepDt() {
		return depDt;
	}

	public void setDepDt(String depDt) {
		this.depDt = depDt;
	} 
	
	
	
}
