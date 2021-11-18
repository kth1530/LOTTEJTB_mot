package com.lottejtb.account.service;

public class LPointVO {
	private String code				=	"";	//리턴코드
	private String cardNum 			=	""; //카드번호
	private String usePoint_str 	= 	""; //가용포인트
	private String remainPointType 	= 	""; //잔여포인트부호
	private String remainPoint_str	= 	""; //잔여포인트
	private String message1 		= 	""; //메세지1
	private String message2 		= 	""; //메세지2
	
	private String apprNo				=	"";	//승인번호
	private String USE_ORG_APPRNO		=	"";	//원거래승인번호
	private String USE_ORG_APPRNO_DAY	=	"";	//원거래승인일자
	private String affRemainPointType	=	"";
	private String affRemainPoint		=	"";
	private String POINT_TID			=	"";
	
	private String apprCd				=	"";	//응답코드
	private String custNo				=	"";	//고객번호
	private String failCnt				=	"";	//비밀번호오류횟수
	
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCardNum() {
		return cardNum;
	}
	public void setCardNum(String cardNum) {
		this.cardNum = cardNum;
	}
	public String getUsePoint_str() {
		return usePoint_str;
	}
	public void setUsePoint_str(String usePoint_str) {
		this.usePoint_str = usePoint_str;
	}
	public String getRemainPointType() {
		return remainPointType;
	}
	public void setRemainPointType(String remainPointType) {
		this.remainPointType = remainPointType;
	}
	public String getRemainPoint_str() {
		return remainPoint_str;
	}
	public void setRemainPoint_str(String remainPoint_str) {
		this.remainPoint_str = remainPoint_str;
	}
	public String getMessage1() {
		return message1;
	}
	public void setMessage1(String message1) {
		this.message1 = message1;
	}
	public String getMessage2() {
		return message2;
	}
	public void setMessage2(String message2) {
		this.message2 = message2;
	}
	public String getApprNo() {
		return apprNo;
	}
	public void setApprNo(String apprNo) {
		this.apprNo = apprNo;
	}
	public String getUSE_ORG_APPRNO() {
		return USE_ORG_APPRNO;
	}
	public void setUSE_ORG_APPRNO(String uSE_ORG_APPRNO) {
		USE_ORG_APPRNO = uSE_ORG_APPRNO;
	}
	public String getUSE_ORG_APPRNO_DAY() {
		return USE_ORG_APPRNO_DAY;
	}
	public void setUSE_ORG_APPRNO_DAY(String uSE_ORG_APPRNO_DAY) {
		USE_ORG_APPRNO_DAY = uSE_ORG_APPRNO_DAY;
	}
	public String getAffRemainPointType() {
		return affRemainPointType;
	}
	public void setAffRemainPointType(String affRemainPointType) {
		this.affRemainPointType = affRemainPointType;
	}
	public String getAffRemainPoint() {
		return affRemainPoint;
	}
	public void setAffRemainPoint(String affRemainPoint) {
		this.affRemainPoint = affRemainPoint;
	}
	public String getPOINT_TID() {
		return POINT_TID;
	}
	public void setPOINT_TID(String pOINT_TID) {
		POINT_TID = pOINT_TID;
	}
	public String getApprCd() {
		return apprCd;
	}
	public void setApprCd(String apprCd) {
		this.apprCd = apprCd;
	}
	public String getCustNo() {
		return custNo;
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	public String getFailCnt() {
		return failCnt;
	}
	public void setFailCnt(String failCnt) {
		this.failCnt = failCnt;
	}
	
	
	
}
