package com.lottejtb.mytour.service;

import com.lottejtb.comm.service.CommDefaultVO;

public class MytourVO extends CommDefaultVO {
	/** 예약내역 S **/
	private String resCd;
	private String resDay;
	private String etcResCd;
	private String goodsTypeCd;
	private String areaCd;
	private String resChkCd;
	private String compCd;
	private String siteCd;
	private String resNm;
	private int resCnt;
	private int cancCnt;
	private String okwt;
	private int eventAmt;
	private int totSaleAmt;
	private int addAmt;
	private int totInAmt;
	private int misuAmt;
	private String siteComm;
	private String chaId;
	private String chaDeptCd;
	private String startPyun;
	private String cancCd;
	private String StatusNm;
	private String statusCd;
	private String statusRgCd;
	private String endDayFr;
	private String startTime;
	private String endTimeFr;
	private String cityCd;
	private String htCityCd;
	private String etcGoodsId;
	private int saleAmt;
	private String hpSaleAmtW;
	private String resDate;
	private String email;
	private String tradeNo;
	
	/** 예약내역 E**/
	
	/** 마이투어 이벤트 S **/
	private String eventSeq;
	private String applySeq;
	private String custCd;
	private String custNm;
	private String eventNm;
	private String cnt;
	private String eventFrDay;
	private String eventToDay;
	private String eventDesc;
	private String eventUrl;
	private String dispYn;
	private String insDt;
	private String winSeq;
	/** 마이투어 이벤트 E **/
	
	/** 찜 상품 S **/
	private String goodsCd;
	private String eventCd;
	private int ctgSeq;
	private String adultPrice;
	private String saveFileNm;
	private String startDay;
	private String endDay;
	private String wishCd;
	private String evNightCnt;
	private String evDayCnt;
	private String opCd;
	private String trffKnm;
	private String wishSeq;
	private String wishSeqs;
	
	/** 찜 상품 E **/
	
	public String getEventSeq() {
		return eventSeq;
	}
	public void setEventSeq(String eventSeq) {
		this.eventSeq = eventSeq;
	}
	public String getApplySeq() {
		return applySeq;
	}
	public void setApplySeq(String applySeq) {
		this.applySeq = applySeq;
	}
	public String getCustCd() {
		return custCd;
	}
	public void setCustCd(String custCd) {
		this.custCd = custCd;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getEventNm() {
		return eventNm;
	}
	public void setEventNm(String eventNm) {
		this.eventNm = eventNm;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getEventFrDay() {
		return eventFrDay;
	}
	public void setEventFrDay(String eventFrDay) {
		this.eventFrDay = eventFrDay;
	}
	public String getEventToDay() {
		return eventToDay;
	}
	public void setEventToDay(String eventToDay) {
		this.eventToDay = eventToDay;
	}
	public String getEventDesc() {
		return eventDesc;
	}
	public void setEventDesc(String eventDesc) {
		this.eventDesc = eventDesc;
	}
	public String getEventUrl() {
		return eventUrl;
	}
	public void setEventUrl(String eventUrl) {
		this.eventUrl = eventUrl;
	}
	public String getDispYn() {
		return dispYn;
	}
	public void setDispYn(String dispYn) {
		this.dispYn = dispYn;
	}
	public String getInsDt() {
		return insDt;
	}
	public void setInsDt(String insDt) {
		this.insDt = insDt;
	}
	public String getWinSeq() {
		return winSeq;
	}
	public void setWinSeq(String winSeq) {
		this.winSeq = winSeq;
	}
	public String getGoodsCd() {
		return goodsCd;
	}
	public void setGoodsCd(String goodsCd) {
		this.goodsCd = goodsCd;
	}
	public String getEventCd() {
		return eventCd;
	}
	public void setEventCd(String eventCd) {
		this.eventCd = eventCd;
	}
	public int getCtgSeq() {
		return ctgSeq;
	}
	public void setCtgSeq(int ctgSeq) {
		this.ctgSeq = ctgSeq;
	}
	public String getAdultPrice() {
		return adultPrice;
	}
	public void setAdultPrice(String adultPrice) {
		this.adultPrice = adultPrice;
	}
	public String getSaveFileNm() {
		return saveFileNm;
	}
	public void setSaveFileNm(String saveFileNm) {
		this.saveFileNm = saveFileNm;
	}
	public String getStartDay() {
		return startDay;
	}
	public void setStartDay(String startDay) {
		this.startDay = startDay;
	}
	public String getEndDay() {
		return endDay;
	}
	public void setEndDay(String endDay) {
		this.endDay = endDay;
	}
	public String getWishCd() {
		return wishCd;
	}
	public void setWishCd(String wishCd) {
		this.wishCd = wishCd;
	}
	public String getEvNightCnt() {
		return evNightCnt;
	}
	public void setEvNightCnt(String evNightCnt) {
		this.evNightCnt = evNightCnt;
	}
	public String getEvDayCnt() {
		return evDayCnt;
	}
	public void setEvDayCnt(String evDayCnt) {
		this.evDayCnt = evDayCnt;
	}
	public String getOpCd() {
		return opCd;
	}
	public void setOpCd(String opCd) {
		this.opCd = opCd;
	}
	public String getTrffKnm() {
		return trffKnm;
	}
	public void setTrffKnm(String trffKnm) {
		this.trffKnm = trffKnm;
	}
	public String getResCd() {
		return resCd;
	}
	public void setResCd(String resCd) {
		this.resCd = resCd;
	}
	public String getResDay() {
		return resDay;
	}
	public void setResDay(String resDay) {
		this.resDay = resDay;
	}
	public String getEtcResCd() {
		return etcResCd;
	}
	public void setEtcResCd(String etcResCd) {
		this.etcResCd = etcResCd;
	}
	public String getGoodsTypeCd() {
		return goodsTypeCd;
	}
	public void setGoodsTypeCd(String goodsTypeCd) {
		this.goodsTypeCd = goodsTypeCd;
	}
	public String getAreaCd() {
		return areaCd;
	}
	public void setAreaCd(String areaCd) {
		this.areaCd = areaCd;
	}
	public String getResChkCd() {
		return resChkCd;
	}
	public void setResChkCd(String resChkCd) {
		this.resChkCd = resChkCd;
	}
	public String getCompCd() {
		return compCd;
	}
	public void setCompCd(String compCd) {
		this.compCd = compCd;
	}
	public String getSiteCd() {
		return siteCd;
	}
	public void setSiteCd(String siteCd) {
		this.siteCd = siteCd;
	}
	public String getResNm() {
		return resNm;
	}
	public void setResNm(String resNm) {
		this.resNm = resNm;
	}
	public int getResCnt() {
		return resCnt;
	}
	public void setResCnt(int resCnt) {
		this.resCnt = resCnt;
	}
	public int getCancCnt() {
		return cancCnt;
	}
	public void setCancCnt(int cancCnt) {
		this.cancCnt = cancCnt;
	}
	public String getOkwt() {
		return okwt;
	}
	public void setOkwt(String okwt) {
		this.okwt = okwt;
	}
	public int getEventAmt() {
		return eventAmt;
	}
	public void setEventAmt(int eventAmt) {
		this.eventAmt = eventAmt;
	}
	public int getTotSaleAmt() {
		return totSaleAmt;
	}
	public void setTotSaleAmt(int totSaleAmt) {
		this.totSaleAmt = totSaleAmt;
	}
	public int getAddAmt() {
		return addAmt;
	}
	public void setAddAmt(int addAmt) {
		this.addAmt = addAmt;
	}
	public int getTotInAmt() {
		return totInAmt;
	}
	public void setTotInAmt(int totInAmt) {
		this.totInAmt = totInAmt;
	}
	public int getMisuAmt() {
		return misuAmt;
	}
	public void setMisuAmt(int misuAmt) {
		this.misuAmt = misuAmt;
	}
	public String getSiteComm() {
		return siteComm;
	}
	public void setSiteComm(String siteComm) {
		this.siteComm = siteComm;
	}
	public String getChaId() {
		return chaId;
	}
	public void setChaId(String chaId) {
		this.chaId = chaId;
	}
	public String getChaDeptCd() {
		return chaDeptCd;
	}
	public void setChaDeptCd(String chaDeptCd) {
		this.chaDeptCd = chaDeptCd;
	}
	public String getStartPyun() {
		return startPyun;
	}
	public void setStartPyun(String startPyun) {
		this.startPyun = startPyun;
	}
	public String getCancCd() {
		return cancCd;
	}
	public void setCancCd(String cancCd) {
		this.cancCd = cancCd;
	}
	public String getStatusNm() {
		return StatusNm;
	}
	public void setStatusNm(String statusNm) {
		StatusNm = statusNm;
	}
	public String getStatusCd() {
		return statusCd;
	}
	public void setStatusCd(String statusCd) {
		this.statusCd = statusCd;
	}
	public String getStatusRgCd() {
		return statusRgCd;
	}
	public void setStatusRgCd(String statusRgCd) {
		this.statusRgCd = statusRgCd;
	}
	public String getEndDayFr() {
		return endDayFr;
	}
	public void setEndDayFr(String endDayFr) {
		this.endDayFr = endDayFr;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTimeFr() {
		return endTimeFr;
	}
	public void setEndTimeFr(String endTimeFr) {
		this.endTimeFr = endTimeFr;
	}
	public String getCityCd() {
		return cityCd;
	}
	public void setCityCd(String cityCd) {
		this.cityCd = cityCd;
	}
	public String getHtCityCd() {
		return htCityCd;
	}
	public void setHtCityCd(String htCityCd) {
		this.htCityCd = htCityCd;
	}
	public String getEtcGoodsId() {
		return etcGoodsId;
	}
	public void setEtcGoodsId(String etcGoodsId) {
		this.etcGoodsId = etcGoodsId;
	}
	public int getSaleAmt() {
		return saleAmt;
	}
	public void setSaleAmt(int saleAmt) {
		this.saleAmt = saleAmt;
	}
	public String getHpSaleAmtW() {
		return hpSaleAmtW;
	}
	public void setHpSaleAmtW(String hpSaleAmtW) {
		this.hpSaleAmtW = hpSaleAmtW;
	}
	public String getResDate() {
		return resDate;
	}
	public void setResDate(String resDate) {
		this.resDate = resDate;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTradeNo() {
		return tradeNo;
	}
	public void setTradeNo(String tradeNo) {
		this.tradeNo = tradeNo;
	}
	public String getWishSeq() {
		return wishSeq;
	}
	public void setWishSeq(String wishSeq) {
		this.wishSeq = wishSeq;
	}
	public String getWishSeqs() {
		return wishSeqs;
	}
	public void setWishSeqs(String wishSeqs) {
		this.wishSeqs = wishSeqs;
	}
	
}
	