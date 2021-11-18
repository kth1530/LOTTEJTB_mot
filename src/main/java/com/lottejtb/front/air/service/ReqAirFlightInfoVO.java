package com.lottejtb.front.air.service;

import java.util.ArrayList;

public class ReqAirFlightInfoVO{
	private String gdsCd;
	private String availTy;
	private int adtCnt;
	private int chdCnt;
	private int infCnt;
	private String routeTy;		//20161220 추가
	
	private ArrayList<ReqAirSegmentVO> segmentGroup = new ArrayList<ReqAirSegmentVO>();

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
}
