package com.lottejtb.planning.service;

import java.sql.Date;
import java.util.List;

import com.lottejtb.comm.service.CommDefaultVO;


//기획전 vo
public class PlanningVO extends CommDefaultVO {
	
  	private int    planSeq;  //기획전 번호
  	private String planType;
  	private String planNm;  //기획전명
  	private String goodsTypeCd; //상품유형
  	private String areaCd;  //지역구분
  	private String planFrday; //기획전 시작일자
  	private String planToday; //기획전 종료일자
  	private String planFrtm;  //기획전 시작시간
  	private String planTotm;  //기획전 종료시간
  	private String planUrl;   //기획전URL
  	private String planClsCd; //기획전 구분코드
  	private String planDetClsCd; //기획전 세부구분코드
  	private String planTyImgCd; //진행유형코드
  	private String templeteCd; //템플릿 코드
  	private String spectialYn;  //상품특전 사용여부
  	private String incYn; //포함사항 사용여부
  	private String notincYn; //불포함사용사용여부
  	private String optionYn; //옵션사항 사용유무
  	private String smallImgPh; //작은 이미지 경로
  	private String bigImgPh; //큰 이미지 경로
  	private String dispYn;  //전시여부
  	private String startDayYn;
  	private String cnts; //내용  //clob데이터
  	private String memo; //메모
  	private String html;
  	private Date   insDt; //등록일시
  	private String insId; //등록자번호
  	private Date   updDt; //최종 업데이트 날짜
  	private String updId;
  	private int    viewCnt;
	private String thnPath; //썸네일
  	private String mallCd; //몰코드
  	
  	private String goodsNm;
  	private String planTabSeq;
  	private String goodCd;
  	private String specialYn;
  	private String dispOrder;
  	private String opCd;
  	private String planTabTitle;
  	private String compCd;
  	private String goodsDesc;
  	
  	private String eventCd;
  	private String startDay;
  	private int    adultPrice; //성인요금
  	
  	private String cfg;
  	private String ctg_goods;  //카테고리상품.
  	private String cdNm;
  	private String cdNm01;
  	
  	//plan goods
  	private int goodsNightCnt;
  	private int goodsDayCnt;
  	private String goodsNightDay;
  	private String shortGoodsNm;  //전시용 미니 상품영
  	private String air_remark; 
  	private String homeShoppingYn;
  	private String planYn;
  	private String eventYn;
  	private String img_title;
  	private String save_file_nm;
  	
  	private String ctgSeq;
  	private String etDays;
  	private String mblPlanUrl;
  	private String displayTypeCd;
  	
  	private List<PlanMonth> planDateList;
  	
	public int getPlanSeq() {
		return planSeq;
	}
	public void setPlanSeq(int planSeq) {
		this.planSeq = planSeq;
	}
	public String getPlanType() {
		return planType;
	}
	public void setPlanType(String planType) {
		this.planType = planType;
	}
	public String getPlanNm() {
		return planNm;
	}
	public void setPlanNm(String planNm) {
		this.planNm = planNm;
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
	public String getPlanFrday() {
		return planFrday;
	}
	public void setPlanFrday(String planFrday) {
		this.planFrday = planFrday;
	}
	public String getPlanToday() {
		return planToday;
	}
	public void setPlanToday(String planToday) {
		this.planToday = planToday;
	}
	public String getPlanFrtm() {
		return planFrtm;
	}
	public void setPlanFrtm(String planFrtm) {
		this.planFrtm = planFrtm;
	}
	public String getPlanTotm() {
		return planTotm;
	}
	public void setPlanTotm(String planTotm) {
		this.planTotm = planTotm;
	}
	public String getPlanUrl() {
		return planUrl;
	}
	public void setPlanUrl(String planUrl) {
		this.planUrl = planUrl;
	}
	public String getPlanClsCd() {
		return planClsCd;
	}
	public void setPlanClsCd(String planClsCd) {
		this.planClsCd = planClsCd;
	}
	public String getPlanDetClsCd() {
		return planDetClsCd;
	}
	public void setPlanDetClsCd(String planDetClsCd) {
		this.planDetClsCd = planDetClsCd;
	}
	public String getPlanTyImgCd() {
		return planTyImgCd;
	}
	public void setPlanTyImgCd(String planTyImgCd) {
		this.planTyImgCd = planTyImgCd;
	}
	public String getTempleteCd() {
		return templeteCd;
	}
	public void setTempleteCd(String templeteCd) {
		this.templeteCd = templeteCd;
	}
	public String getSpectialYn() {
		return spectialYn;
	}
	public void setSpectialYn(String spectialYn) {
		this.spectialYn = spectialYn;
	}
	public String getIncYn() {
		return incYn;
	}
	public void setIncYn(String incYn) {
		this.incYn = incYn;
	}
	public String getNotincYn() {
		return notincYn;
	}
	public void setNotincYn(String notincYn) {
		this.notincYn = notincYn;
	}
	public String getOptionYn() {
		return optionYn;
	}
	public void setOptionYn(String optionYn) {
		this.optionYn = optionYn;
	}
	public String getSmallImgPh() {
		return smallImgPh;
	}
	public void setSmallImgPh(String smallImgPh) {
		this.smallImgPh = smallImgPh;
	}
	public String getBigImgPh() {
		return bigImgPh;
	}
	public void setBigImgPh(String bigImgPh) {
		this.bigImgPh = bigImgPh;
	}
	public String getDispYn() {
		return dispYn;
	}
	public void setDispYn(String dispYn) {
		this.dispYn = dispYn;
	}
	public String getStartDayYn() {
		return startDayYn;
	}
	public void setStartDayYn(String startDayYn) {
		this.startDayYn = startDayYn;
	}
	public String getCnts() {
		return cnts;
	}
	public void setCnts(String cnts) {
		this.cnts = cnts;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getHtml() {
		return html;
	}
	public void setHtml(String html) {
		this.html = html;
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
	public String getThnPath() {
		return thnPath;
	}
	public void setThnPath(String thnPath) {
		this.thnPath = thnPath;
	}
	public String getMallCd() {
		return mallCd;
	}
	public void setMallCd(String mallCd) {
		this.mallCd = mallCd;
	}
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	public String getGoodsNm() {
		return goodsNm;
	}
	public void setGoodsNm(String goodsNm) {
		this.goodsNm = goodsNm;
	}
	public String getPlanTabSeq() {
		return planTabSeq;
	}
	public void setPlanTabSeq(String planTabSeq) {
		this.planTabSeq = planTabSeq;
	}
	public String getGoodCd() {
		return goodCd;
	}
	public void setGoodCd(String goodCd) {
		this.goodCd = goodCd;
	}
	public String getSpecialYn() {
		return specialYn;
	}
	public void setSpecialYn(String specialYn) {
		this.specialYn = specialYn;
	}
	public String getDispOrder() {
		return dispOrder;
	}
	public void setDispOrder(String dispOrder) {
		this.dispOrder = dispOrder;
	}
	public String getOpCd() {
		return opCd;
	}
	public void setOpCd(String opCd) {
		this.opCd = opCd;
	}
	public String getPlanTabTitle() {
		return planTabTitle;
	}
	public void setPlanTabTitle(String planTabTitle) {
		this.planTabTitle = planTabTitle;
	}
	public String getCompCd() {
		return compCd;
	}
	public void setCompCd(String compCd) {
		this.compCd = compCd;
	}
	public String getGoodsDesc() {
		return goodsDesc;
	}
	public void setGoodsDesc(String goodsDesc) {
		this.goodsDesc = goodsDesc;
	}
	public String getEventCd() {
		return eventCd;
	}
	public void setEventCd(String eventCd) {
		this.eventCd = eventCd;
	}
	public String getStartDay() {
		return startDay;
	}
	public void setStartDay(String startDay) {
		this.startDay = startDay;
	}
	public int getAdultPrice() {
		return adultPrice;
	}
	public void setAdultPrice(int adultPrice) {
		this.adultPrice = adultPrice;
	}
	public String getCfg() {
		return cfg;
	}
	public void setCfg(String cfg) {
		this.cfg = cfg;
	}
	public String getCtg_goods() {
		return ctg_goods;
	}
	public void setCtg_goods(String ctg_goods) {
		this.ctg_goods = ctg_goods;
	}
	public String getCdNm() {
		return cdNm;
	}
	public void setCdNm(String cdNm) {
		this.cdNm = cdNm;
	}
	public String getCdNm01() {
		return cdNm01;
	}
	public void setCdNm01(String cdNm01) {
		this.cdNm01 = cdNm01;
	}
	public int getGoodsNightCnt() {
		return goodsNightCnt;
	}
	public void setGoodsNightCnt(int goodsNightCnt) {
		this.goodsNightCnt = goodsNightCnt;
	}
	public int getGoodsDayCnt() {
		return goodsDayCnt;
	}
	public void setGoodsDayCnt(int goodsDayCnt) {
		this.goodsDayCnt = goodsDayCnt;
	}
	public String getGoodsNightDay() {
		return goodsNightDay;
	}
	public void setGoodsNightDay(String goodsNightDay) {
		this.goodsNightDay = goodsNightDay;
	}
	public String getShortGoodsNm() {
		return shortGoodsNm;
	}
	public void setShortGoodsNm(String shortGoodsNm) {
		this.shortGoodsNm = shortGoodsNm;
	}
	public String getAir_remark() {
		return air_remark;
	}
	public void setAir_remark(String air_remark) {
		this.air_remark = air_remark;
	}
	public String getHomeShoppingYn() {
		return homeShoppingYn;
	}
	public void setHomeShoppingYn(String homeShoppingYn) {
		this.homeShoppingYn = homeShoppingYn;
	}
	public String getPlanYn() {
		return planYn;
	}
	public void setPlanYn(String planYn) {
		this.planYn = planYn;
	}
	public String getEventYn() {
		return eventYn;
	}
	public void setEventYn(String eventYn) {
		this.eventYn = eventYn;
	}
	public String getImg_title() {
		return img_title;
	}
	public void setImg_title(String img_title) {
		this.img_title = img_title;
	}
	public String getSave_file_nm() {
		return save_file_nm;
	}
	public void setSave_file_nm(String save_file_nm) {
		this.save_file_nm = save_file_nm;
	}
	public List<PlanMonth> getPlanDateList() {
		return planDateList;
	}
	public void setPlanDateList(List<PlanMonth> planDateList) {
		this.planDateList = planDateList;
	}
	public String getCtgSeq() {
		return ctgSeq;
	}
	public void setCtgSeq(String ctgSeq) {
		this.ctgSeq = ctgSeq;
	}
	public String getEtDays() {
		return etDays;
	}
	public void setEtDays(String etDays) {
		this.etDays = etDays;
	}
	public String getMblPlanUrl() {
		return mblPlanUrl;
	}
	public void setMblPlanUrl(String mblPlanUrl) {
		this.mblPlanUrl = mblPlanUrl;
	}
	public String getDisplayTypeCd() {
		return displayTypeCd;
	}
	public void setDisplayTypeCd(String displayTypeCd) {
		this.displayTypeCd = displayTypeCd;
	}
	
}
