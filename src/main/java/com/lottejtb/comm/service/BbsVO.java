package com.lottejtb.comm.service;

import java.sql.Date;

public class BbsVO extends CommDefaultVO {
	
	private int    bbsSeq;        //게시글번호
	private String bbsNm; 
	private int    bbsHeadSeq;    //글번호
	private String title;         //제목
	private String custId;        //고객번호
	private String knm;           //고객한글성명
	private String email;
	private String tel;
	private String emailYn;
	private String smsYn;
	private String rvYn;
	private String clsCd;         //지역코드(AREA_CODE)
	private String detClsCd;      //국가코드(COUNTRY_CODE)
	private String detDetClsCd;
	private String dispYn;
	private String dispaTypeCd;   //전시불가사유코드[REJT]
	private int    recommendCnt;  //추천수
	private int    viewCnt;       //조회수
	private String replyCnt;
	private String bbsCnts;
	private String delYn;
	private String goodsCd;
	private String goodsNm;
	private String adultPrice;
	private Date insDt;           //등록일시
	private String insId;         //등록자번호
	private Date updDt;           //최종수정일시
	private String updId;         //수정자번호
	private String compCd;
	private String cnts;
	private String bbsTypeCd;
	
	public int getBbsSeq() {
		return bbsSeq;
	}
	public void setBbsSeq(int bbsSeq) {
		this.bbsSeq = bbsSeq;
	}
	
	public String getBbsNm() {
		return bbsNm;
	}
	public void setBbsNm(String bbsNm) {
		this.bbsNm = bbsNm;
	}
	public int getBbsHeadSeq() {
		return bbsHeadSeq;
	}
	public void setBbsHeadSeq(int bbsHeadSeq) {
		this.bbsHeadSeq = bbsHeadSeq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCustId() {
		return custId;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public String getKnm() {
		return knm;
	}
	public void setKnm(String knm) {
		this.knm = knm;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmailYn() {
		return emailYn;
	}
	public void setEmailYn(String emailYn) {
		this.emailYn = emailYn;
	}
	public String getSmsYn() {
		return smsYn;
	}
	public void setSmsYn(String smsYn) {
		this.smsYn = smsYn;
	}
	public String getRvYn() {
		return rvYn;
	}
	public void setRvYn(String rvYn) {
		this.rvYn = rvYn;
	}
	public String getClsCd() {
		return clsCd;
	}
	public void setClsCd(String clsCd) {
		this.clsCd = clsCd;
	}
	public String getDetClsCd() {
		return detClsCd;
	}
	public void setDetClsCd(String detClsCd) {
		this.detClsCd = detClsCd;
	}
	public String getDetDetClsCd() {
		return detDetClsCd;
	}
	public void setDetDetClsCd(String detDetClsCd) {
		this.detDetClsCd = detDetClsCd;
	}
	public String getDispYn() {
		return dispYn;
	}
	public void setDispYn(String dispYn) {
		this.dispYn = dispYn;
	}
	public String getDispaTypeCd() {
		return dispaTypeCd;
	}
	public void setDispaTypeCd(String dispaTypeCd) {
		this.dispaTypeCd = dispaTypeCd;
	}
	public int getRecommendCnt() {
		return recommendCnt;
	}
	public void setRecommendCnt(int recommendCnt) {
		this.recommendCnt = recommendCnt;
	}
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	public String getReplyCnt() {
		return replyCnt;
	}
	public void setReplyCnt(String replyCnt) {
		this.replyCnt = replyCnt;
	}
	public String getBbsCnts() {
		return bbsCnts;
	}
	public void setBbsCnts(String bbsCnts) {
		this.bbsCnts = bbsCnts;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public String getGoodsCd() {
		return goodsCd;
	}
	public void setGoodsCd(String goodsCd) {
		this.goodsCd = goodsCd;
	}
	public String getGoodsNm() {
		return goodsNm;
	}
	public void setGoodsNm(String goodsNm) {
		this.goodsNm = goodsNm;
	}
	public String getAdultPrice() {
		return adultPrice;
	}
	public void setAdultPrice(String adultPrice) {
		this.adultPrice = adultPrice;
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
	public String getCompCd() {
		return compCd;
	}
	public void setCompCd(String compCd) {
		this.compCd = compCd;
	}
	public String getCnts() {
		return cnts;
	}
	public void setCnts(String cnts) {
		this.cnts = cnts;
	}
	public String getBbsTypeCd() {
		return bbsTypeCd;
	}
	public void setBbsTypeCd(String bbsTypeCd) {
		this.bbsTypeCd = bbsTypeCd;
	}
	
}
