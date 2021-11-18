package com.lottejtb.front.air.vo;

import java.util.ArrayList;

import com.lottejtb.front.vo.PromotionVo;

public class ReqAirInfoVO{
	private String gdsCd;
	private String availTy;
	private int adtCnt;
	private int chdCnt;
	private int infCnt;
	private String routeTy;		//20161220 추가
	private String ruleKey;		//20170406 추가
	private String fmsKey;		//20170406 추가
	
	private ArrayList<ReqAirSegmentVO> segmentGroup = new ArrayList<ReqAirSegmentVO>();
	private ArrayList<AirPaxVO> paxGroup = new ArrayList<AirPaxVO>();
	private PromotionVo	promInfo = new PromotionVo();

	public String getGdsCd() {
		return gdsCd;
	}

	public void setGdsCd(String gdsCd) {
		this.gdsCd = gdsCd;
	}

	public String getAvailTy() {
		return availTy;
	}

	public void setAvailTy(String availTy) {
		this.availTy = availTy;
	}

	public int getAdtCnt() {
		return adtCnt;
	}

	public void setAdtCnt(int adtCnt) {
		this.adtCnt = adtCnt;
	}

	public int getChdCnt() {
		return chdCnt;
	}

	public void setChdCnt(int chdCnt) {
		this.chdCnt = chdCnt;
	}

	public int getInfCnt() {
		return infCnt;
	}

	public void setInfCnt(int infCnt) {
		this.infCnt = infCnt;
	}

	public ArrayList<ReqAirSegmentVO> getSegmentGroup() {
		return segmentGroup;
	}

	public void setSegmentGroup(ArrayList<ReqAirSegmentVO> segmentGroup) {
		this.segmentGroup = segmentGroup;
	}

	public void setRouteTy(String routeTy) {
		this.routeTy = routeTy;
	}

	public String getRouteTy() {
		return routeTy;
	}

	public String getRuleKey() {
		return ruleKey;
	}

	public void setRuleKey(String ruleKey) {
		this.ruleKey = ruleKey;
	}

	public String getFmsKey() {
		return fmsKey;
	}

	public void setFmsKey(String fmsKey) {
		this.fmsKey = fmsKey;
	}

	public ArrayList<AirPaxVO> getPaxGroup() {
		return paxGroup;
	}

	public void setPaxGroup(ArrayList<AirPaxVO> paxGroup) {
		this.paxGroup = paxGroup;
	}

	public PromotionVo getPromInfo() {
		return promInfo;
	}

	public void setPromInfo(PromotionVo promInfo) {
		this.promInfo = promInfo;
	}
}