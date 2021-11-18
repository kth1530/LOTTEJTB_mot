package com.lottejtb.goods.service;

import com.lottejtb.comm.service.CommDefaultVO;

/**
* 클래스명    :  사이트 전시 태그 정보를 담고 있는 클래스   
* @ClassDesc  : 사이트 전시 태그 정보를 담고 있는 클래스   
* @FileName   : EventTagsDTO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.11 /  / 최초작성
*/


public class EventTagsDTO extends CommDefaultVO {

	private static final long serialVersionUID = -2026685182322719052L;
	
	private String homeshopping_yn = "";
	private String plan_yn = "";
	private String event_yn = "";
	private String premium_yn = "";
	private String classic_yn = "";
	private String save_yn = "";
	
	
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
