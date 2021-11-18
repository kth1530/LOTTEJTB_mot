package com.lottejtb.event.service;

import java.sql.Date;

import com.lottejtb.comm.service.CommDefaultVO;

public class EventVO extends CommDefaultVO {
	
	private int eventSeq; //이벤트 번호
	private int eventTempSeq;
	private String eventNm; //이벤트명
	private String eventClsCd; //
	private String eventDetClsCd; //
	private String eventSmallImgUrl; //작으이미지
	private String eventBigImgurl; //큰이미지
	private String eventFrday; //이벤트시작일자
	private String eventToday; //이벤트종료일자
	private String eventFrtm; //이벤트시작시간
	private String eventTotm; //이벤트종료시간
    private String eventTypeCd; //진행유형코드
    private String dispYn; //진행상태코드
    private String eventUrl; //이벤트URL
    private int    roundApplaycnt; //회차별 응모가능획수
    private int    totalWinnerCnt; //전체당첨자수
    private String winLimitYn; //당첨자제한여부
    private String spotWinYn; //즉시 당청여부
    private String tempYn; //
    private String mngAns; //관리정답
    private String mapInfo;
    private String eventDesc; // 이벤트설명
    private String winYn;
    private String cnt; //
    private String displayTypeCd; //전시구분유형 (전체: ALL, 웹:Web, 모바일:Mbl)
    private String tempTypeCd; //템플릿유형 (10: 이미지,20:응모(1인1회),30:댓글,40:퀴즈
    private String mblEeventUrl; //모바일이벤트URL     
    private Date   insDt; //등록일시
    private String insId; //등록자번호
    private Date   updDt; //최종수정일시
    private String updId; //최종수정자번호
    private String etcDetDesc; //
    private String imgBottomPh;
    private String imgLeftBackPh;
    private String imgTopPh;
    private int    backheight;
    
    private String cd_nm01;
    private String cd_nm02;
    private String insEmpNm;
    private String updEmpNm;
    
    private String dispType;

    /****** 이벤트 댓글 ******/
    private String applySeq;
    private String custCd;
    private String custNm;
    private String eventTitle;
    private String eventCnts;
    private String applyNo;
    private String eventInput1;
    private String eventInput2;
    private String eventInput3;
    private String eventInput4;
    private String eventInput5;
    private String eventInput6;
    private String eventInput7;
    private String eventInput8;
    private String eventInput9;
    private String eventInput10;
    private String eventChgubun;
    private String custId;
    private String loginId;
    private String email;
    private String roundApplyCnt;
    private int applyCnt;
    
    /****** 이벤트 댓글 ******/
    
    private String event_chgubun; //출석체크 01:10회이상출석 , 02:15회이상, 03:100%출석
    
    /***** 이벤트 투표 *******/
    private String eventVote1;
    private String eventVote2;
    private String eventVote3;
    private String eventVote4;
    private String eventVote5;
    private String eventVote6;
    private String eventVote7;
    private String eventVote8;
    private String eventVote9;
    private String eventVote10;
    
    
	public int getEventSeq() {
		return eventSeq;
	}
	public void setEventSeq(int eventSeq) {
		this.eventSeq = eventSeq;
	}
	public String getEventNm() {
		return eventNm;
	}
	public void setEventNm(String eventNm) {
		this.eventNm = eventNm;
	}
	public String getEventClsCd() {
		return eventClsCd;
	}
	public void setEventClsCd(String eventClsCd) {
		this.eventClsCd = eventClsCd;
	}
	public String getEventDetClsCd() {
		return eventDetClsCd;
	}
	public void setEventDetClsCd(String eventDetClsCd) {
		this.eventDetClsCd = eventDetClsCd;
	}
	public String getEventSmallImgUrl() {
		return eventSmallImgUrl;
	}
	public void setEventSmallImgUrl(String eventSmallImgUrl) {
		this.eventSmallImgUrl = eventSmallImgUrl;
	}
	public String getEventBigImgurl() {
		return eventBigImgurl;
	}
	public void setEventBigImgurl(String eventBigImgurl) {
		this.eventBigImgurl = eventBigImgurl;
	}
	public String getEventFrday() {
		return eventFrday;
	}
	public void setEventFrday(String eventFrday) {
		this.eventFrday = eventFrday;
	}
	public String getEventToday() {
		return eventToday;
	}
	public void setEventToday(String eventToday) {
		this.eventToday = eventToday;
	}
	public String getEventFrtm() {
		return eventFrtm;
	}
	public void setEventFrtm(String eventFrtm) {
		this.eventFrtm = eventFrtm;
	}
	public String getEventTotm() {
		return eventTotm;
	}
	public void setEventTotm(String eventTotm) {
		this.eventTotm = eventTotm;
	}
	public String getEventTypeCd() {
		return eventTypeCd;
	}
	public void setEventTypeCd(String eventTypeCd) {
		this.eventTypeCd = eventTypeCd;
	}
	public String getDispYn() {
		return dispYn;
	}
	public void setDispYn(String dispYn) {
		this.dispYn = dispYn;
	}
	public String getEventUrl() {
		return eventUrl;
	}
	public void setEventUrl(String eventUrl) {
		this.eventUrl = eventUrl;
	}
	public int getRoundApplaycnt() {
		return roundApplaycnt;
	}
	public void setRoundApplaycnt(int roundApplaycnt) {
		this.roundApplaycnt = roundApplaycnt;
	}
	public int getTotalWinnerCnt() {
		return totalWinnerCnt;
	}
	public void setTotalWinnerCnt(int totalWinnerCnt) {
		this.totalWinnerCnt = totalWinnerCnt;
	}
	public String getWinLimitYn() {
		return winLimitYn;
	}
	public void setWinLimitYn(String winLimitYn) {
		this.winLimitYn = winLimitYn;
	}
	public String getSpotWinYn() {
		return spotWinYn;
	}
	public void setSpotWinYn(String spotWinYn) {
		this.spotWinYn = spotWinYn;
	}
	public String getTempYn() {
		return tempYn;
	}
	public void setTempYn(String tempYn) {
		this.tempYn = tempYn;
	}
	public String getMngAns() {
		return mngAns;
	}
	public void setMngAns(String mngAns) {
		this.mngAns = mngAns;
	}
	public String getMapInfo() {
		return mapInfo;
	}
	public void setMapInfo(String mapInfo) {
		this.mapInfo = mapInfo;
	}
	public String getEventDesc() {
		return eventDesc;
	}
	public void setEventDesc(String eventDesc) {
		this.eventDesc = eventDesc;
	}
	public String getWinYn() {
		return winYn;
	}
	public void setWinYn(String winYn) {
		this.winYn = winYn;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getDisplayTypeCd() {
		return displayTypeCd;
	}
	public void setDisplayTypeCd(String displayTypeCd) {
		this.displayTypeCd = displayTypeCd;
	}
	public String getTempTypeCd() {
		return tempTypeCd;
	}
	public void setTempTypeCd(String tempTypeCd) {
		this.tempTypeCd = tempTypeCd;
	}
	public String getMblEeventUrl() {
		return mblEeventUrl;
	}
	public void setMblEeventUrl(String mblEeventUrl) {
		this.mblEeventUrl = mblEeventUrl;
	}
	public Date getInsDt() {
		return insDt;
	}
	public void setInsDt(Date insDt) {
		this.insDt = insDt;
	}
	public String getInsId() {
		return insId;
	}
	public void setInsId(String insId) {
		this.insId = insId;
	}
	public Date getUpdDt() {
		return updDt;
	}
	public void setUpdDt(Date updDt) {
		this.updDt = updDt;
	}
	public String getUpdId() {
		return updId;
	}
	public void setUpdId(String updId) {
		this.updId = updId;
	}
	public String getEtcDetDesc() {
		return etcDetDesc;
	}
	public void setEtcDetDesc(String etcDetDesc) {
		this.etcDetDesc = etcDetDesc;
	}
	public String getCd_nm01() {
		return cd_nm01;
	}
	public void setCd_nm01(String cd_nm01) {
		this.cd_nm01 = cd_nm01;
	}
	public String getCd_nm02() {
		return cd_nm02;
	}
	public void setCd_nm02(String cd_nm02) {
		this.cd_nm02 = cd_nm02;
	}
	public String getInsEmpNm() {
		return insEmpNm;
	}
	public void setInsEmpNm(String insEmpNm) {
		this.insEmpNm = insEmpNm;
	}
	public String getUpdEmpNm() {
		return updEmpNm;
	}
	public void setUpdEmpNm(String updEmpNm) {
		this.updEmpNm = updEmpNm;
	}
	public String getDispType() {
		return dispType;
	}
	public void setDispType(String dispType) {
		this.dispType = dispType;
	}
	public int getEventTempSeq() {
		return eventTempSeq;
	}
	public void setEventTempSeq(int eventTempSeq) {
		this.eventTempSeq = eventTempSeq;
	}
	public String getImgBottomPh() {
		return imgBottomPh;
	}
	public void setImgBottomPh(String imgBottomPh) {
		this.imgBottomPh = imgBottomPh;
	}
	public String getImgLeftBackPh() {
		return imgLeftBackPh;
	}
	public void setImgLeftBackPh(String imgLeftBackPh) {
		this.imgLeftBackPh = imgLeftBackPh;
	}
	public String getImgTopPh() {
		return imgTopPh;
	}
	public void setImgTopPh(String imgTopPh) {
		this.imgTopPh = imgTopPh;
	}
	public int getBackheight() {
		return backheight;
	}
	public void setBackheight(int backheight) {
		this.backheight = backheight;
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
	public String getEventTitle() {
		return eventTitle;
	}
	public void setEventTitle(String eventTitle) {
		this.eventTitle = eventTitle;
	}
	public String getEventCnts() {
		return eventCnts;
	}
	public void setEventCnts(String eventCnts) {
		this.eventCnts = eventCnts;
	}
	public String getApplyNo() {
		return applyNo;
	}
	public void setApplyNo(String applyNo) {
		this.applyNo = applyNo;
	}
	public String getEventInput1() {
		return eventInput1;
	}
	public void setEventInput1(String eventInput1) {
		this.eventInput1 = eventInput1;
	}
	public String getEventInput2() {
		return eventInput2;
	}
	public void setEventInput2(String eventInput2) {
		this.eventInput2 = eventInput2;
	}
	public String getEventInput3() {
		return eventInput3;
	}
	public void setEventInput3(String eventInput3) {
		this.eventInput3 = eventInput3;
	}
	public String getEventInput4() {
		return eventInput4;
	}
	public void setEventInput4(String eventInput4) {
		this.eventInput4 = eventInput4;
	}
	public String getEventInput5() {
		return eventInput5;
	}
	public void setEventInput5(String eventInput5) {
		this.eventInput5 = eventInput5;
	}
	public String getEventInput6() {
		return eventInput6;
	}
	public void setEventInput6(String eventInput6) {
		this.eventInput6 = eventInput6;
	}
	public String getEventInput7() {
		return eventInput7;
	}
	public void setEventInput7(String eventInput7) {
		this.eventInput7 = eventInput7;
	}
	public String getEventInput8() {
		return eventInput8;
	}
	public void setEventInput8(String eventInput8) {
		this.eventInput8 = eventInput8;
	}
	public String getEventInput9() {
		return eventInput9;
	}
	public void setEventInput9(String eventInput9) {
		this.eventInput9 = eventInput9;
	}
	public String getEventInput10() {
		return eventInput10;
	}
	public void setEventInput10(String eventInput10) {
		this.eventInput10 = eventInput10;
	}
	public String getCustId() {
		return custId;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRoundApplyCnt() {
		return roundApplyCnt;
	}
	public void setRoundApplyCnt(String roundApplyCnt) {
		this.roundApplyCnt = roundApplyCnt;
	}
	public int getApplyCnt() {
		return applyCnt;
	}
	public void setApplyCnt(int applyCnt) {
		this.applyCnt = applyCnt;
	}
	public String getEvent_chgubun() {
		return event_chgubun;
	}
	public void setEvent_chgubun(String event_chgubun) {
		this.event_chgubun = event_chgubun;
	}
	public String getEventVote1() {
		return eventVote1;
	}
	public void setEventVote1(String eventVote1) {
		this.eventVote1 = eventVote1;
	}
	public String getEventVote2() {
		return eventVote2;
	}
	public void setEventVote2(String eventVote2) {
		this.eventVote2 = eventVote2;
	}
	public String getEventVote3() {
		return eventVote3;
	}
	public void setEventVote3(String eventVote3) {
		this.eventVote3 = eventVote3;
	}
	public String getEventVote4() {
		return eventVote4;
	}
	public void setEventVote4(String eventVote4) {
		this.eventVote4 = eventVote4;
	}
	public String getEventVote5() {
		return eventVote5;
	}
	public void setEventVote5(String eventVote5) {
		this.eventVote5 = eventVote5;
	}
	public String getEventVote6() {
		return eventVote6;
	}
	public void setEventVote6(String eventVote6) {
		this.eventVote6 = eventVote6;
	}
	public String getEventVote7() {
		return eventVote7;
	}
	public void setEventVote7(String eventVote7) {
		this.eventVote7 = eventVote7;
	}
	public String getEventVote8() {
		return eventVote8;
	}
	public void setEventVote8(String eventVote8) {
		this.eventVote8 = eventVote8;
	}
	public String getEventVote9() {
		return eventVote9;
	}
	public void setEventVote9(String eventVote9) {
		this.eventVote9 = eventVote9;
	}
	public String getEventVote10() {
		return eventVote10;
	}
	public void setEventVote10(String eventVote10) {
		this.eventVote10 = eventVote10;
	}
	public String getEventChgubun() {
		return eventChgubun;
	}
	public void setEventChgubun(String eventChgubun) {
		this.eventChgubun = eventChgubun;
	}
}
