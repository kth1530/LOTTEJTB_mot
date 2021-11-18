package com.lottejtb.prom.service;

import java.util.ArrayList;

public class PromotionParamVO {
	private PromotionMstVO promMst = new PromotionMstVO();
	private PromotionAirVO promAir = new PromotionAirVO();
	private ArrayList<PromotionHtlVO> promHtl = new ArrayList<PromotionHtlVO>();
	
	public PromotionMstVO getPromMst() {
		return promMst;
	}
	public void setPromMst(PromotionMstVO promMst) {
		this.promMst = promMst;
	}
	public PromotionAirVO getPromAir() {
		return promAir;
	}
	public void setPromAir(PromotionAirVO promAir) {
		this.promAir = promAir;
	}
	public ArrayList<PromotionHtlVO> getPromHtl() {
		return promHtl;
	}
	public void setPromHtl(ArrayList<PromotionHtlVO> promHtl) {
		this.promHtl = promHtl;
	}
}
