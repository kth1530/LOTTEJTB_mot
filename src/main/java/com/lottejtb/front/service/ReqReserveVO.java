package com.lottejtb.front.service;


public class ReqReserveVO {
	
    
	private String 	fitRsvNo; 			// 자유여행_예약_번호
	private int 	airRsvSeqno;		// 항공_예약_일련번호
	private String 	concMix;			// 구성_조합
	private String 	userId;				// 대표_예약자_ID
	private String 	userNm;				// 대표_예약자
	private String 	userEmail;			// 대표_예약자_이메일
	private String 	userTel;			// 대표_예약자_전화번호
	private String 	cashReceiptOrdYn;	// 현금영수증_신청_여부
	private int 	saleAmtTot;			// 판매_금액_총
	private int 	saleAmtAir;			// 판매_금액_항공
	private int 	saleAmtHtl;			// 판매_금액_호텔	
	private int 	saleAmtRnt;			// 판매_금액_렌터카
	private String 	htlRsvStateGb;		// 호텔 예약상태코드
	private String	htlPaymtstateGb;	// 호텔 결제상태코드
	private String 	rntRsvstateGb;		// 렌터카 예약상태코드
	private int 	totDiscntAmt;		// 총_할인_금액
	private int 	airDiscntAmt;		// 항공_할인_금액
	private int 	htlDiscntAmt;		// 호텔_할인_금액
	private int 	rntDiscntAmt;		// 렌터카_할인_금액
	private int 	ijwDiscntAmt;		// 임직원_할인_금액
	private String 	reqDiviGb;			// 요청_구분_GB
	private String 	reqDtt;				// 요청_일시
	private String 	paymtTl;			// 결제시한
	private String 	cancelYnAir;		// 취소_여부_항공 (요청)
	private String 	cancelYnHtl;		// 취소_여부_호텔 (요청)
	private String 	cancelYnRnt;		// 취소_여부_렌터카 (요청)
	private String  useYn;				// 사용여부
	private int 	totTasfCharge;
	private String  err_msg;    //예약 실패시 메시지
	private String  mkt_agree_yn; //마켓팅활용동의
		
	public int getTotTasfCharge() {
		return totTasfCharge;
	}
	public void setTotTasfCharge(int totTasfCharge) {
		this.totTasfCharge = totTasfCharge;
	}
	public String getFitRsvNo() {
		return fitRsvNo;
	}
	public void setFitRsvNo(String fitRsvNo) {
		this.fitRsvNo = fitRsvNo;
	}
	public int getAirRsvSeqno() {
		return airRsvSeqno;
	}
	public void setAirRsvSeqno(int airRsvSeqno) {
		this.airRsvSeqno = airRsvSeqno;
	}
	public String getConcMix() {
		return concMix;
	}
	public void setConcMix(String concMix) {
		this.concMix = concMix;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserTel() {
		return userTel;
	}
	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}
	public String getCashReceiptOrdYn() {
		return cashReceiptOrdYn;
	}
	public void setCashReceiptOrdYn(String cashReceiptOrdYn) {
		this.cashReceiptOrdYn = cashReceiptOrdYn;
	}
	public int getSaleAmtTot() {
		return saleAmtTot;
	}
	public void setSaleAmtTot(int saleAmtTot) {
		this.saleAmtTot = saleAmtTot;
	}
	public int getSaleAmtAir() {
		return saleAmtAir;
	}
	public void setSaleAmtAir(int saleAmtAir) {
		this.saleAmtAir = saleAmtAir;
	}
	public int getSaleAmtHtl() {
		return saleAmtHtl;
	}
	public void setSaleAmtHtl(int saleAmtHtl) {
		this.saleAmtHtl = saleAmtHtl;
	}
	public int getSaleAmtRnt() {
		return saleAmtRnt;
	}
	public void setSaleAmtRnt(int saleAmtRnt) {
		this.saleAmtRnt = saleAmtRnt;
	}
	public int getTotDiscntAmt() {
		return totDiscntAmt;
	}
	public void setTotDiscntAmt(int totDiscntAmt) {
		this.totDiscntAmt = totDiscntAmt;
	}
	public int getAirDiscntAmt() {
		return airDiscntAmt;
	}
	public void setAirDiscntAmt(int airDiscntAmt) {
		this.airDiscntAmt = airDiscntAmt;
	}
	public int getHtlDiscntAmt() {
		return htlDiscntAmt;
	}
	public void setHtlDiscntAmt(int htlDiscntAmt) {
		this.htlDiscntAmt = htlDiscntAmt;
	}
	public int getRntDiscntAmt() {
		return rntDiscntAmt;
	}
	public void setRntDiscntAmt(int rntDiscntAmt) {
		this.rntDiscntAmt = rntDiscntAmt;
	}
	public String getReqDiviGb() {
		return reqDiviGb;
	}
	public void setReqDiviGb(String reqDiviGb) {
		this.reqDiviGb = reqDiviGb;
	}
	public String getReqDtt() {
		return reqDtt;
	}
	public void setReqDtt(String reqDtt) {
		this.reqDtt = reqDtt;
	}
	public String getPaymtTl() {
		return paymtTl;
	}
	public void setPaymtTl(String paymtTl) {
		this.paymtTl = paymtTl;
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
	public String getHtlRsvStateGb() {
		return htlRsvStateGb;
	}
	public void setHtlRsvStateGb(String htlRsvStateGb) {
		this.htlRsvStateGb = htlRsvStateGb;
	}
	public String getHtlPaymtstateGb() {
		return htlPaymtstateGb;
	}
	public void setHtlPaymtstateGb(String htlPaymtstateGb) {
		this.htlPaymtstateGb = htlPaymtstateGb;
	}
	public String getRntRsvstateGb() {
		return rntRsvstateGb;
	}
	public void setRntRsvstateGb(String rntRsvstateGb) {
		this.rntRsvstateGb = rntRsvstateGb;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getErr_msg() {
		return err_msg;
	}
	public void setErr_msg(String err_msg) {
		this.err_msg = err_msg;
	}
	public String getMkt_agree_yn() {
		return mkt_agree_yn;
	}
	public void setMkt_agree_yn(String mkt_agree_yn) {
		this.mkt_agree_yn = mkt_agree_yn;
	}
	public int getIjwDiscntAmt() {
		return ijwDiscntAmt;
	}
	public void setIjwDiscntAmt(int ijwDiscntAmt) {
		this.ijwDiscntAmt = ijwDiscntAmt;
	}
	
}
