package com.lottejtb.planning.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class PlanMonth  implements Serializable {

	private String month;
	private List<PlanDate> planDateList;
	private String goodsCD;

	public PlanMonth(String month, String goodsCD) {
		this.month = month;
		this.goodsCD = goodsCD;
		planDateList = new ArrayList<PlanDate>();
	}

	public String getGoodsCD() {
		return goodsCD;
	}

	public void setGoodsCD(String goodsCD) {
		this.goodsCD = goodsCD;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public List<PlanDate> getPlanDateList() {
		return planDateList;
	}

	public void setPlanDateList(List<PlanDate> planDateList) {
		this.planDateList = planDateList;
	}
}
