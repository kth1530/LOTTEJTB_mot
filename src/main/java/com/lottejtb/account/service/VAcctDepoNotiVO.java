package com.lottejtb.account.service;

/**
 * 가상계좌 입금 통보 VO
 */
public class VAcctDepoNotiVO {
    
    /** 예약 유형(AIR: 항공, HTL: 호텔 */
    public static enum RSV_TYPE {
        AIR, HTL
    };
    
    /** 거래번호 */
    private String no_tid;
    
    /** 주문번호 */
    private String no_oid;
    
    /** 거래발생 기관코드 */
    private String cd_bank;
    
    /** 취급기관코드 */
    private String cd_deal;
    
    /** 거래일자 */
    private String dt_trans;
    
    /** 거래시각 */
    private String tm_trans;
    
    /** 계좌번호 */
    private String no_vacct;
    
    /** 입금금액 */
    private Long amt_input;
    
    /** 미결제타점권금액 */
    private Long amt_check;
    
    /** 마감구분 */
    private String flg_close;
    
    /** 마감구분코드 */
    private String cl_close;
    
    /** 거래구분 */
    private String type_msg;
    
    /** 입금은행명 */
    private String nm_inputbank;
    
    /** 입금자명 */
    private String nm_input;
    
    /** 입금기준일자 */
    private int dt_inputstd;
    
    /** 정산기준일자 */
    private int dt_calculstd;
    
    /** 거래기준일자 */
    private int dt_transbase;

    /** 거래구분코드 */
    private int cl_trans;

    /** 한글구분코드 */
    private int cl_kor;
    
    /** 현금영수증 발급일자 */
    private int dt_cshr;

    /** 현금영수증 발급시간 */
    private int tm_cshr;

    /** 현금영수증 발급번호 */
    private int no_cshr_appl;
    
    /** 현금영수증 발급TID */
    private String no_cshr_tid;
    
    /** 입금 확인 여부 */
    private String paymtConfYn;
    
    /** 등록자ID */
    private String regtorId;
    
    /** 수정자ID */
    private String modtorId;
    
    /** 승인 결과코드(00: 결제성공, 01: 결제실패) */
    private String resultCode; 

    /** 승인 결과 메시지 */
    private String resultMsg;
    
    /** 결제 지불방법(지불수단) */
    private String payMethod;
    
    /** PG 승인 일자 */
    private String pgAuthDate;
    
    /** PG 승인 시간 */
    private String pgAuthTime;
    
    /** 송금자주민번호(요청시 미입력할 경우 NULL) */
    private String perno;
    
    /** 입금예정일 */
    private String dtinput;
    
    /** 입금예정시각 */
    private String tmInput;

	/**
	 * @return the no_tid
	 */
	public String getNo_tid() {
		return no_tid;
	}

	/**
	 * @param no_tid the no_tid to set
	 */
	public void setNo_tid(String no_tid) {
		this.no_tid = no_tid;
	}

	/**
	 * @return the no_oid
	 */
	public String getNo_oid() {
		return no_oid;
	}

	/**
	 * @param no_oid the no_oid to set
	 */
	public void setNo_oid(String no_oid) {
		this.no_oid = no_oid;
	}

	/**
	 * @return the cd_bank
	 */
	public String getCd_bank() {
		return cd_bank;
	}

	/**
	 * @param cd_bank the cd_bank to set
	 */
	public void setCd_bank(String cd_bank) {
		this.cd_bank = cd_bank;
	}

	/**
	 * @return the cd_deal
	 */
	public String getCd_deal() {
		return cd_deal;
	}

	/**
	 * @param cd_deal the cd_deal to set
	 */
	public void setCd_deal(String cd_deal) {
		this.cd_deal = cd_deal;
	}

	/**
	 * @return the dt_trans
	 */
	public String getDt_trans() {
		return dt_trans;
	}

	/**
	 * @param dt_trans the dt_trans to set
	 */
	public void setDt_trans(String dt_trans) {
		this.dt_trans = dt_trans;
	}

	/**
	 * @return the tm_trans
	 */
	public String getTm_trans() {
		return tm_trans;
	}

	/**
	 * @param tm_trans the tm_trans to set
	 */
	public void setTm_trans(String tm_trans) {
		this.tm_trans = tm_trans;
	}

	/**
	 * @return the no_vacct
	 */
	public String getNo_vacct() {
		return no_vacct;
	}

	/**
	 * @param no_vacct the no_vacct to set
	 */
	public void setNo_vacct(String no_vacct) {
		this.no_vacct = no_vacct;
	}

	/**
	 * @return the amt_input
	 */
	public Long getAmt_input() {
		return amt_input;
	}

	/**
	 * @param amt_input the amt_input to set
	 */
	public void setAmt_input(Long amt_input) {
		this.amt_input = amt_input;
	}

	/**
	 * @return the amt_check
	 */
	public Long getAmt_check() {
		return amt_check;
	}

	/**
	 * @param amt_check the amt_check to set
	 */
	public void setAmt_check(Long amt_check) {
		this.amt_check = amt_check;
	}

	/**
	 * @return the flg_close
	 */
	public String getFlg_close() {
		return flg_close;
	}

	/**
	 * @param flg_close the flg_close to set
	 */
	public void setFlg_close(String flg_close) {
		this.flg_close = flg_close;
	}

	/**
	 * @return the cl_close
	 */
	public String getCl_close() {
		return cl_close;
	}

	/**
	 * @param cl_close the cl_close to set
	 */
	public void setCl_close(String cl_close) {
		this.cl_close = cl_close;
	}

	/**
	 * @return the type_msg
	 */
	public String getType_msg() {
		return type_msg;
	}

	/**
	 * @param type_msg the type_msg to set
	 */
	public void setType_msg(String type_msg) {
		this.type_msg = type_msg;
	}

	/**
	 * @return the nm_inputbank
	 */
	public String getNm_inputbank() {
		return nm_inputbank;
	}

	/**
	 * @param nm_inputbank the nm_inputbank to set
	 */
	public void setNm_inputbank(String nm_inputbank) {
		this.nm_inputbank = nm_inputbank;
	}

	/**
	 * @return the nm_input
	 */
	public String getNm_input() {
		return nm_input;
	}

	/**
	 * @param nm_input the nm_input to set
	 */
	public void setNm_input(String nm_input) {
		this.nm_input = nm_input;
	}

	/**
	 * @return the dt_inputstd
	 */
	public int getDt_inputstd() {
		return dt_inputstd;
	}

	/**
	 * @param dt_inputstd the dt_inputstd to set
	 */
	public void setDt_inputstd(int dt_inputstd) {
		this.dt_inputstd = dt_inputstd;
	}

	/**
	 * @return the dt_calculstd
	 */
	public int getDt_calculstd() {
		return dt_calculstd;
	}

	/**
	 * @param dt_calculstd the dt_calculstd to set
	 */
	public void setDt_calculstd(int dt_calculstd) {
		this.dt_calculstd = dt_calculstd;
	}

	/**
	 * @return the dt_transbase
	 */
	public int getDt_transbase() {
		return dt_transbase;
	}

	/**
	 * @param dt_transbase the dt_transbase to set
	 */
	public void setDt_transbase(int dt_transbase) {
		this.dt_transbase = dt_transbase;
	}

	/**
	 * @return the cl_trans
	 */
	public int getCl_trans() {
		return cl_trans;
	}

	/**
	 * @param cl_trans the cl_trans to set
	 */
	public void setCl_trans(int cl_trans) {
		this.cl_trans = cl_trans;
	}

	/**
	 * @return the cl_kor
	 */
	public int getCl_kor() {
		return cl_kor;
	}

	/**
	 * @param cl_kor the cl_kor to set
	 */
	public void setCl_kor(int cl_kor) {
		this.cl_kor = cl_kor;
	}

	/**
	 * @return the dt_cshr
	 */
	public int getDt_cshr() {
		return dt_cshr;
	}

	/**
	 * @param dt_cshr the dt_cshr to set
	 */
	public void setDt_cshr(int dt_cshr) {
		this.dt_cshr = dt_cshr;
	}

	/**
	 * @return the tm_cshr
	 */
	public int getTm_cshr() {
		return tm_cshr;
	}

	/**
	 * @param tm_cshr the tm_cshr to set
	 */
	public void setTm_cshr(int tm_cshr) {
		this.tm_cshr = tm_cshr;
	}

	/**
	 * @return the no_cshr_appl
	 */
	public int getNo_cshr_appl() {
		return no_cshr_appl;
	}

	/**
	 * @param no_cshr_appl the no_cshr_appl to set
	 */
	public void setNo_cshr_appl(int no_cshr_appl) {
		this.no_cshr_appl = no_cshr_appl;
	}

	/**
	 * @return the no_cshr_tid
	 */
	public String getNo_cshr_tid() {
		return no_cshr_tid;
	}

	/**
	 * @param no_cshr_tid the no_cshr_tid to set
	 */
	public void setNo_cshr_tid(String no_cshr_tid) {
		this.no_cshr_tid = no_cshr_tid;
	}

	/**
	 * @return the paymtConfYn
	 */
	public String getPaymtConfYn() {
		return paymtConfYn;
	}

	/**
	 * @param paymtConfYn the paymtConfYn to set
	 */
	public void setPaymtConfYn(String paymtConfYn) {
		this.paymtConfYn = paymtConfYn;
	}

	/**
	 * @return the regtorId
	 */
	public String getRegtorId() {
		return regtorId;
	}

	/**
	 * @param regtorId the regtorId to set
	 */
	public void setRegtorId(String regtorId) {
		this.regtorId = regtorId;
	}

	/**
	 * @return the modtorId
	 */
	public String getModtorId() {
		return modtorId;
	}

	/**
	 * @param modtorId the modtorId to set
	 */
	public void setModtorId(String modtorId) {
		this.modtorId = modtorId;
	}

	/**
	 * @return the resultCode
	 */
	public String getResultCode() {
		return resultCode;
	}

	/**
	 * @param resultCode the resultCode to set
	 */
	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}

	/**
	 * @return the resultMsg
	 */
	public String getResultMsg() {
		return resultMsg;
	}

	/**
	 * @param resultMsg the resultMsg to set
	 */
	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}

	/**
	 * @return the payMethod
	 */
	public String getPayMethod() {
		return payMethod;
	}

	/**
	 * @param payMethod the payMethod to set
	 */
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}

	/**
	 * @return the pgAuthDate
	 */
	public String getPgAuthDate() {
		return pgAuthDate;
	}

	/**
	 * @param pgAuthDate the pgAuthDate to set
	 */
	public void setPgAuthDate(String pgAuthDate) {
		this.pgAuthDate = pgAuthDate;
	}

	/**
	 * @return the pgAuthTime
	 */
	public String getPgAuthTime() {
		return pgAuthTime;
	}

	/**
	 * @param pgAuthTime the pgAuthTime to set
	 */
	public void setPgAuthTime(String pgAuthTime) {
		this.pgAuthTime = pgAuthTime;
	}

	/**
	 * @return the perno
	 */
	public String getPerno() {
		return perno;
	}

	/**
	 * @param perno the perno to set
	 */
	public void setPerno(String perno) {
		this.perno = perno;
	}

	/**
	 * @return the dtinput
	 */
	public String getDtinput() {
		return dtinput;
	}

	/**
	 * @param dtinput the dtinput to set
	 */
	public void setDtinput(String dtinput) {
		this.dtinput = dtinput;
	}

	/**
	 * @return the tmInput
	 */
	public String getTmInput() {
		return tmInput;
	}

	/**
	 * @param tmInput the tmInput to set
	 */
	public void setTmInput(String tmInput) {
		this.tmInput = tmInput;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("VAcctDepoNotiVO [no_tid=").append(no_tid).append(", no_oid=").append(no_oid)
				.append(", cd_bank=").append(cd_bank).append(", cd_deal=").append(cd_deal).append(", dt_trans=")
				.append(dt_trans).append(", tm_trans=").append(tm_trans).append(", no_vacct=").append(no_vacct)
				.append(", amt_input=").append(amt_input).append(", amt_check=").append(amt_check)
				.append(", flg_close=").append(flg_close).append(", cl_close=").append(cl_close).append(", type_msg=")
				.append(type_msg).append(", nm_inputbank=").append(nm_inputbank).append(", nm_input=").append(nm_input)
				.append(", dt_inputstd=").append(dt_inputstd).append(", dt_calculstd=").append(dt_calculstd)
				.append(", dt_transbase=").append(dt_transbase).append(", cl_trans=").append(cl_trans)
				.append(", cl_kor=").append(cl_kor).append(", dt_cshr=").append(dt_cshr).append(", tm_cshr=")
				.append(tm_cshr).append(", no_cshr_appl=").append(no_cshr_appl).append(", no_cshr_tid=")
				.append(no_cshr_tid).append(", paymtConfYn=").append(paymtConfYn).append(", regtorId=").append(regtorId)
				.append(", modtorId=").append(modtorId).append(", resultCode=").append(resultCode)
				.append(", resultMsg=").append(resultMsg).append(", payMethod=").append(payMethod)
				.append(", pgAuthDate=").append(pgAuthDate).append(", pgAuthTime=").append(pgAuthTime)
				.append(", perno=").append(perno).append(", dtinput=").append(dtinput).append(", tmInput=")
				.append(tmInput).append("]");
		return builder.toString();
	}

}