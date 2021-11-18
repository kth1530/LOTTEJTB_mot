package com.lottejtb.mytour.service;

import com.lottejtb.comm.service.CommDefaultVO;

public class FreeMytourVO extends CommDefaultVO {
	private String fitRsvNo;
	private String mstRsvNm;
	private String mstRsvNmEmail;
	private String concMix;
	private String saleAmtTot;
	private String saleAmtAir;
	private String saleAmtHtl;
	private String saleAmtRnt;
	private String rsvDt;
	private String cancelYnAir;
	private String cancelYnHtl;
	private String cancelYnRnt;
	private String airDiscntAmt;
	private String htlDiscntAmt;
	private String rntDiscntAmt;
	private String promId;
	private String promNm;
	private String promAmount;
	private String promRate;
	private String promAmt; //프로모션 할인 금액 추가 2019.07.31 bum
	
	/****** Air Reserve ******/
	private String airRsvSeqno;
	private String itinShapeGb;
	private String rsvNmId;
	private String rsvStateGb;
	private String rsvStateNm;
	private String fareStateGb;
	private String fareStateNm;
	private String rsvDtt;
	private String totSaleAmt;
	private String totTasfAmt;
	private String depFltno;
	private String depCd;
	private String depNm;
	private String depDt;
	private String depHm;
	private String arrCd;
	private String firstArrNm;
	private String arrFltno;
	private String lastArrNm;
	private String lastArrDt;
	private String lastArrHm;
	private String adt;
	private String chd;
	private String inf;
	/****** Air Reserve ******/
	
	/****** Hotel Reserve ******/
	private String htlIntnum;
	private String htlNm;
	private String checkinDt;
	private String checkoutDt;
	private String htlRsvSeqno;
	private String adtQty;
	private String childQty;
	private String saleAmt;
	private String saleJtbAmt;
	private String roomCnt;
	private String htlRsvstateGb;
	private String htlRsvstateNm;
	private String htlPaymtstateGb;
	private String htlPaymtstateNm;
	private String exchangeRate;
	private String saleCurrency;
	private String ijwdiscntamt;
	/****** Hotel Reserve ******/
	
	/****** RentalCar Reserve ******/
	private String rntRsvSeqno;
	private String carModelNm;
	private String rntStateGb;
	private String rntStateNm;
	private String pickupDt;
	private String rtDt;
	private String orgAmt;
	private String discntAmt;
	private String currencyCd;
	/****** RentalCar Reserve ******/
	public String getFitRsvNo() {
		return fitRsvNo;
	}
	public void setFitRsvNo(String fitRsvNo) {
		this.fitRsvNo = fitRsvNo;
	}
	public String getMstRsvNm() {
		return mstRsvNm;
	}
	public void setMstRsvNm(String mstRsvNm) {
		this.mstRsvNm = mstRsvNm;
	}
	public String getMstRsvNmEmail() {
		return mstRsvNmEmail;
	}
	public void setMstRsvNmEmail(String mstRsvNmEmail) {
		this.mstRsvNmEmail = mstRsvNmEmail;
	}
	public String getConcMix() {
		return concMix;
	}
	public void setConcMix(String concMix) {
		this.concMix = concMix;
	}
	public String getSaleAmtTot() {
		return saleAmtTot;
	}
	public void setSaleAmtTot(String saleAmtTot) {
		this.saleAmtTot = saleAmtTot;
	}
	public String getSaleAmtAir() {
		return saleAmtAir;
	}
	public void setSaleAmtAir(String saleAmtAir) {
		this.saleAmtAir = saleAmtAir;
	}
	public String getSaleAmtHtl() {
		return saleAmtHtl;
	}
	public void setSaleAmtHtl(String saleAmtHtl) {
		this.saleAmtHtl = saleAmtHtl;
	}
	public String getSaleAmtRnt() {
		return saleAmtRnt;
	}
	public void setSaleAmtRnt(String saleAmtRnt) {
		this.saleAmtRnt = saleAmtRnt;
	}
	public String getRsvDt() {
		return rsvDt;
	}
	public void setRsvDt(String rsvDt) {
		this.rsvDt = rsvDt;
	}
	public String getCancelYnAir() {
		return cancelYnAir;
	}
	public void setCancelYnAir(String cancelYnAir) {
		this.cancelYnAir = cancelYnAir;
	}
	public String getCancelYnHtl() {
		return cancelYnHtl;
	}
	public void setCancelYnHtl(String cancelYnHtl) {
		this.cancelYnHtl = cancelYnHtl;
	}
	public String getCancelYnRnt() {
		return cancelYnRnt;
	}
	public void setCancelYnRnt(String cancelYnRnt) {
		this.cancelYnRnt = cancelYnRnt;
	}
	public String getAirDiscntAmt() {
		return airDiscntAmt;
	}
	public void setAirDiscntAmt(String airDiscntAmt) {
		this.airDiscntAmt = airDiscntAmt;
	}
	public String getHtlDiscntAmt() {
		return htlDiscntAmt;
	}
	public void setHtlDiscntAmt(String htlDiscntAmt) {
		this.htlDiscntAmt = htlDiscntAmt;
	}
	public String getRntDiscntAmt() {
		return rntDiscntAmt;
	}
	public void setRntDiscntAmt(String rntDiscntAmt) {
		this.rntDiscntAmt = rntDiscntAmt;
	}
	public String getPromId() {
		return promId;
	}
	public void setPromId(String promId) {
		this.promId = promId;
	}
	public String getPromNm() {
		return promNm;
	}
	public void setPromNm(String promNm) {
		this.promNm = promNm;
	}
	public String getPromAmount() {
		return promAmount;
	}
	public void setPromAmount(String promAmount) {
		this.promAmount = promAmount;
	}
	public String getPromRate() {
		return promRate;
	}
	public void setPromRate(String promRate) {
		this.promRate = promRate;
	}
	public String getAirRsvSeqno() {
		return airRsvSeqno;
	}
	public void setAirRsvSeqno(String airRsvSeqno) {
		this.airRsvSeqno = airRsvSeqno;
	}
	public String getItinShapeGb() {
		return itinShapeGb;
	}
	public void setItinShapeGb(String itinShapeGb) {
		this.itinShapeGb = itinShapeGb;
	}
	public String getRsvNmId() {
		return rsvNmId;
	}
	public void setRsvNmId(String rsvNmId) {
		this.rsvNmId = rsvNmId;
	}
	public String getRsvStateGb() {
		return rsvStateGb;
	}
	public void setRsvStateGb(String rsvStateGb) {
		this.rsvStateGb = rsvStateGb;
	}
	public String getRsvStateNm() {
		return rsvStateNm;
	}
	public void setRsvStateNm(String rsvStateNm) {
		this.rsvStateNm = rsvStateNm;
	}
	public String getFareStateGb() {
		return fareStateGb;
	}
	public void setFareStateGb(String fareStateGb) {
		this.fareStateGb = fareStateGb;
	}
	public String getFareStateNm() {
		return fareStateNm;
	}
	public void setFareStateNm(String fareStateNm) {
		this.fareStateNm = fareStateNm;
	}
	public String getRsvDtt() {
		return rsvDtt;
	}
	public void setRsvDtt(String rsvDtt) {
		this.rsvDtt = rsvDtt;
	}
	public String getTotSaleAmt() {
		return totSaleAmt;
	}
	public void setTotSaleAmt(String totSaleAmt) {
		this.totSaleAmt = totSaleAmt;
	}
	public String getTotTasfAmt() {
		return totTasfAmt;
	}
	public void setTotTasfAmt(String totTasfAmt) {
		this.totTasfAmt = totTasfAmt;
	}
	public String getDepFltno() {
		return depFltno;
	}
	public void setDepFltno(String depFltno) {
		this.depFltno = depFltno;
	}
	public String getDepCd() {
		return depCd;
	}
	public void setDepCd(String depCd) {
		this.depCd = depCd;
	}
	public String getDepNm() {
		return depNm;
	}
	public void setDepNm(String depNm) {
		this.depNm = depNm;
	}
	public String getDepDt() {
		return depDt;
	}
	public void setDepDt(String depDt) {
		this.depDt = depDt;
	}
	public String getDepHm() {
		return depHm;
	}
	public void setDepHm(String depHm) {
		this.depHm = depHm;
	}
	public String getArrCd() {
		return arrCd;
	}
	public void setArrCd(String arrCd) {
		this.arrCd = arrCd;
	}
	public String getFirstArrNm() {
		return firstArrNm;
	}
	public void setFirstArrNm(String firstArrNm) {
		this.firstArrNm = firstArrNm;
	}
	public String getArrFltno() {
		return arrFltno;
	}
	public void setArrFltno(String arrFltno) {
		this.arrFltno = arrFltno;
	}
	public String getLastArrNm() {
		return lastArrNm;
	}
	public void setLastArrNm(String lastArrNm) {
		this.lastArrNm = lastArrNm;
	}
	public String getLastArrDt() {
		return lastArrDt;
	}
	public void setLastArrDt(String lastArrDt) {
		this.lastArrDt = lastArrDt;
	}
	public String getLastArrHm() {
		return lastArrHm;
	}
	public void setLastArrHm(String lastArrHm) {
		this.lastArrHm = lastArrHm;
	}
	public String getAdt() {
		return adt;
	}
	public void setAdt(String adt) {
		this.adt = adt;
	}
	public String getChd() {
		return chd;
	}
	public void setChd(String chd) {
		this.chd = chd;
	}
	public String getInf() {
		return inf;
	}
	public void setInf(String inf) {
		this.inf = inf;
	}
	public String getHtlIntnum() {
		return htlIntnum;
	}
	public void setHtlIntnum(String htlIntnum) {
		this.htlIntnum = htlIntnum;
	}
	public String getHtlNm() {
		return htlNm;
	}
	public void setHtlNm(String htlNm) {
		this.htlNm = htlNm;
	}
	public String getCheckinDt() {
		return checkinDt;
	}
	public void setCheckinDt(String checkinDt) {
		this.checkinDt = checkinDt;
	}
	public String getCheckoutDt() {
		return checkoutDt;
	}
	public void setCheckoutDt(String checkoutDt) {
		this.checkoutDt = checkoutDt;
	}
	public String getHtlRsvSeqno() {
		return htlRsvSeqno;
	}
	public void setHtlRsvSeqno(String htlRsvSeqno) {
		this.htlRsvSeqno = htlRsvSeqno;
	}
	public String getAdtQty() {
		return adtQty;
	}
	public void setAdtQty(String adtQty) {
		this.adtQty = adtQty;
	}
	public String getChildQty() {
		return childQty;
	}
	public void setChildQty(String childQty) {
		this.childQty = childQty;
	}
	public String getSaleAmt() {
		return saleAmt;
	}
	public void setSaleAmt(String saleAmt) {
		this.saleAmt = saleAmt;
	}
	public String getSaleJtbAmt() {
		return saleJtbAmt;
	}
	public void setSaleJtbAmt(String saleJtbAmt) {
		this.saleJtbAmt = saleJtbAmt;
	}
	public String getRoomCnt() {
		return roomCnt;
	}
	public void setRoomCnt(String roomCnt) {
		this.roomCnt = roomCnt;
	}
	public String getHtlRsvstateGb() {
		return htlRsvstateGb;
	}
	public void setHtlRsvstateGb(String htlRsvstateGb) {
		this.htlRsvstateGb = htlRsvstateGb;
	}
	public String getHtlRsvstateNm() {
		return htlRsvstateNm;
	}
	public void setHtlRsvstateNm(String htlRsvstateNm) {
		this.htlRsvstateNm = htlRsvstateNm;
	}
	public String getHtlPaymtstateGb() {
		return htlPaymtstateGb;
	}
	public void setHtlPaymtstateGb(String htlPaymtstateGb) {
		this.htlPaymtstateGb = htlPaymtstateGb;
	}
	public String getHtlPaymtstateNm() {
		return htlPaymtstateNm;
	}
	public void setHtlPaymtstateNm(String htlPaymtstateNm) {
		this.htlPaymtstateNm = htlPaymtstateNm;
	}
	public String getExchangeRate() {
		return exchangeRate;
	}
	public void setExchangeRate(String exchangeRate) {
		this.exchangeRate = exchangeRate;
	}
	public String getSaleCurrency() {
		return saleCurrency;
	}
	public void setSaleCurrency(String saleCurrency) {
		this.saleCurrency = saleCurrency;
	}
	public String getRntRsvSeqno() {
		return rntRsvSeqno;
	}
	public void setRntRsvSeqno(String rntRsvSeqno) {
		this.rntRsvSeqno = rntRsvSeqno;
	}
	public String getCarModelNm() {
		return carModelNm;
	}
	public void setCarModelNm(String carModelNm) {
		this.carModelNm = carModelNm;
	}
	public String getRntStateGb() {
		return rntStateGb;
	}
	public void setRntStateGb(String rntStateGb) {
		this.rntStateGb = rntStateGb;
	}
	public String getRntStateNm() {
		return rntStateNm;
	}
	public void setRntStateNm(String rntStateNm) {
		this.rntStateNm = rntStateNm;
	}
	public String getPickupDt() {
		return pickupDt;
	}
	public void setPickupDt(String pickupDt) {
		this.pickupDt = pickupDt;
	}
	public String getRtDt() {
		return rtDt;
	}
	public void setRtDt(String rtDt) {
		this.rtDt = rtDt;
	}
	public String getOrgAmt() {
		return orgAmt;
	}
	public void setOrgAmt(String orgAmt) {
		this.orgAmt = orgAmt;
	}
	public String getDiscntAmt() {
		return discntAmt;
	}
	public void setDiscntAmt(String discntAmt) {
		this.discntAmt = discntAmt;
	}
	public String getCurrencyCd() {
		return currencyCd;
	}
	public void setCurrencyCd(String currencyCd) {
		this.currencyCd = currencyCd;
	}
	public String getIjwdiscntamt() {
		return ijwdiscntamt;
	}
	public void setIjwdiscntamt(String ijwdiscntamt) {
		this.ijwdiscntamt = ijwdiscntamt;
	}
	public String getPromAmt() {
		return promAmt;
	}
	public void setPromAmt(String promAmt) {
		this.promAmt = promAmt;
	}
	
	
}
