package com.lottejtb.account.service;

// 카드 결제 내역 
public class AirCardPaymtVO {
	private int CARD_PAYMT_SEQNO = 0;				// 카드 결제 일련번호 
	private int AIR_RSV_SEQNO = 0;					// 항공 예약 일련번호 
	private int PAX_NO = 0;							// 탑승객 번호 
	private int CARD_PAYMT_AMT = 0;					// 카드 결제 금액 
	private String CARD_KI_GB = "";					// 카드 종류 GB 
	private String CARD_USE_YN = "";					// 카드 사용 유무 
	private String CARD_NO = "";						// 카드 번호 
	private String CARD_EXPIR_DATE_MN = "";			// 카드 유효기간_월 
	private String CARD_EXPIR_DATE_YEAR = "";		// 카드 유효기간_년도 
	private String CARD_INSTALLMN_MN = "";			// 카드 할부 개월 
	private String CARD_OWNER_GB = "";				// 카드 소유자 GB 
	private String CARD_RELAT_GB = "";				// 카드 관계 GB 
	private String CARD_OWNER_NM = "";				// 카드 소유자 명 
	private String CARD_CVS_NO = "";					// 카드 CVS 번호 
	private String CARD_APPROVE_NO = "";				// 카드 승인 번호 
	private String APPROVE_CONF_YN = "";				// 승인 확인 여부 
	private String FRONT_PASS = "";					// 앞_비밀번호 
	private int TASF_AMT = 0;						// TASF 금액 
	private String REGTOR_ID = "";					// 등록자 ID 
	private String REG_DTT = "";						// 등록일자 
	private String MODTOR_ID = "";					// 수정자 ID 
	private String MOD_DTT = "";						// 수정 일자 
	
	public int getCARD_PAYMT_SEQNO() {
		return CARD_PAYMT_SEQNO;
	}
	public void setCARD_PAYMT_SEQNO(int cARD_PAYMT_SEQNO) {
		CARD_PAYMT_SEQNO = cARD_PAYMT_SEQNO;
	}
	public int getAIR_RSV_SEQNO() {
		return AIR_RSV_SEQNO;
	}
	public void setAIR_RSV_SEQNO(int aIR_RSV_SEQNO) {
		AIR_RSV_SEQNO = aIR_RSV_SEQNO;
	}
	public int getPAX_NO() {
		return PAX_NO;
	}
	public void setPAX_NO(int pAX_NO) {
		PAX_NO = pAX_NO;
	}
	public int getCARD_PAYMT_AMT() {
		return CARD_PAYMT_AMT;
	}
	public void setCARD_PAYMT_AMT(int cARD_PAYMT_AMT) {
		CARD_PAYMT_AMT = cARD_PAYMT_AMT;
	}
	public String getCARD_KI_GB() {
		return CARD_KI_GB;
	}
	public void setCARD_KI_GB(String cARD_KI_GB) {
		CARD_KI_GB = cARD_KI_GB;
	}
	public String getCARD_USE_YN() {
		return CARD_USE_YN;
	}
	public void setCARD_USE_YN(String cARD_USE_YN) {
		CARD_USE_YN = cARD_USE_YN;
	}
	public String getCARD_NO() {
		return CARD_NO;
	}
	public void setCARD_NO(String cARD_NO) {
		CARD_NO = cARD_NO;
	}
	public String getCARD_EXPIR_DATE_MN() {
		return CARD_EXPIR_DATE_MN;
	}
	public void setCARD_EXPIR_DATE_MN(String cARD_EXPIR_DATE_MN) {
		CARD_EXPIR_DATE_MN = cARD_EXPIR_DATE_MN;
	}
	public String getCARD_EXPIR_DATE_YEAR() {
		return CARD_EXPIR_DATE_YEAR;
	}
	public void setCARD_EXPIR_DATE_YEAR(String cARD_EXPIR_DATE_YEAR) {
		CARD_EXPIR_DATE_YEAR = cARD_EXPIR_DATE_YEAR;
	}
	public String getCARD_INSTALLMN_MN() {
		return CARD_INSTALLMN_MN;
	}
	public void setCARD_INSTALLMN_MN(String cARD_INSTALLMN_MN) {
		CARD_INSTALLMN_MN = cARD_INSTALLMN_MN;
	}
	public String getCARD_OWNER_GB() {
		return CARD_OWNER_GB;
	}
	public void setCARD_OWNER_GB(String cARD_OWNER_GB) {
		CARD_OWNER_GB = cARD_OWNER_GB;
	}
	public String getCARD_RELAT_GB() {
		return CARD_RELAT_GB;
	}
	public void setCARD_RELAT_GB(String cARD_RELAT_GB) {
		CARD_RELAT_GB = cARD_RELAT_GB;
	}
	public String getCARD_OWNER_NM() {
		return CARD_OWNER_NM;
	}
	public void setCARD_OWNER_NM(String cARD_OWNER_NM) {
		CARD_OWNER_NM = cARD_OWNER_NM;
	}
	public String getCARD_CVS_NO() {
		return CARD_CVS_NO;
	}
	public void setCARD_CVS_NO(String cARD_CVS_NO) {
		CARD_CVS_NO = cARD_CVS_NO;
	}
	public String getCARD_APPROVE_NO() {
		return CARD_APPROVE_NO;
	}
	public void setCARD_APPROVE_NO(String cARD_APPROVE_NO) {
		CARD_APPROVE_NO = cARD_APPROVE_NO;
	}
	public String getAPPROVE_CONF_YN() {
		return APPROVE_CONF_YN;
	}
	public void setAPPROVE_CONF_YN(String aPPROVE_CONF_YN) {
		APPROVE_CONF_YN = aPPROVE_CONF_YN;
	}
	public String getFRONT_PASS() {
		return FRONT_PASS;
	}
	public void setFRONT_PASS(String fRONT_PASS) {
		FRONT_PASS = fRONT_PASS;
	}
	public int getTASF_AMT() {
		return TASF_AMT;
	}
	public void setTASF_AMT(int tASF_AMT) {
		TASF_AMT = tASF_AMT;
	}
	public String getREGTOR_ID() {
		return REGTOR_ID;
	}
	public void setREGTOR_ID(String rEGTOR_ID) {
		REGTOR_ID = rEGTOR_ID;
	}
	public String getREG_DTT() {
		return REG_DTT;
	}
	public void setREG_DTT(String rEG_DTT) {
		REG_DTT = rEG_DTT;
	}
	public String getMODTOR_ID() {
		return MODTOR_ID;
	}
	public void setMODTOR_ID(String mODTOR_ID) {
		MODTOR_ID = mODTOR_ID;
	}
	public String getMOD_DTT() {
		return MOD_DTT;
	}
	public void setMOD_DTT(String mOD_DTT) {
		MOD_DTT = mOD_DTT;
	}


}
