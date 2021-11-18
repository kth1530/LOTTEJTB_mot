package com.lottejtb.goods.rn.service;

import com.lottejtb.comm.service.CommDefaultVO;

/**
* 클래스명    :  행사 상품 태그들 
* @ClassDesc  : 행사 상품 태그들 
* @FileName   : RNGDTagsVO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2017.02.03 /  / 최초작성
*/


public class RNGDTagsVO  extends CommDefaultVO  {
	
	private static final long serialVersionUID = -8726756049088283759L;
	
	private String event_cd = "";
	private String comp_cd = "";
	private String homeshopping_yn = "";
	private String plan_yn = "";
	private String event_yn = "";
	private String premium_yn = "";
	
	private String classic_yn = "";
	private String save_yn = "";
	
	public RNGDTagsVO() {
		// TODO Auto-generated constructor stub
	}

	
	public String getEvent_cd() {
		return event_cd;
	}

	public void setEvent_cd(String event_cd) {
		this.event_cd = event_cd;
	}

	
	public String getComp_cd() {
		return comp_cd;
	}


	public void setComp_cd(String comp_cd) {
		this.comp_cd = comp_cd;
	}


	public String getHomeshopping_yn() {
		return homeshopping_yn;
	}

	public void setHomeshopping_yn(String homeshopping_yn) {
		this.homeshopping_yn = homeshopping_yn;
	}

	public String getPlan_yn() {
		return plan_yn;
	}

	public void setPlan_yn(String plan_yn) {
		this.plan_yn = plan_yn;
	}

	public String getEvent_yn() {
		return event_yn;
	}

	public void setEvent_yn(String event_yn) {
		this.event_yn = event_yn;
	}

	public String getPremium_yn() {
		return premium_yn;
	}

	public void setPremium_yn(String premium_yn) {
		this.premium_yn = premium_yn;
	}

	public String getClassic_yn() {
		return classic_yn;
	}

	public void setClassic_yn(String classic_yn) {
		this.classic_yn = classic_yn;
	}

	public String getSave_yn() {
		return save_yn;
	}

	public void setSave_yn(String save_yn) {
		this.save_yn = save_yn;
	}

	
}
