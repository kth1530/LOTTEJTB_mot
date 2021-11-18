package com.lottejtb.reserve.service;

import com.lottejtb.comm.service.CommDefaultVO;

/**
* 클래스명    : 행사 담당자 정보를 담고 있는 클래스 
* @ClassDesc  : 행사 담당자 정보를 담고 있는 클래스 
* @FileName   : ManagerDTO.java
* @TableName  : t4dev/RV_MST
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.25 /  / 최초작성
*/

public class ManagerDTO extends CommDefaultVO {

	private static final long serialVersionUID = 6744833091719424436L;

	private String cha_id = "";
	private String cha_dept_cd = "";
	private String mobile = "";
	private String handphone = "";
	private String event_cd = "";
	private String goods_cd = "";
	
	private String comp_cd = "";
	
	
	public String getGoods_cd() {
		return goods_cd;
	}
	public void setGoods_cd(String goods_cd) {
		this.goods_cd = goods_cd;
	}
	public String getComp_cd() {
		return comp_cd;
	}
	public void setComp_cd(String comp_cd) {
		this.comp_cd = comp_cd;
	}
	public String getEvent_cd() {
		return event_cd;
	}
	public void setEvent_cd(String event_cd) {
		this.event_cd = event_cd;
	}
	public String getHandphone() {
		return handphone;
	}
	public void setHandphone(String handphone) {
		this.handphone = handphone;
	}
	public String getCha_id() {
		return cha_id;
	}
	public void setCha_id(String cha_id) {
		this.cha_id = cha_id;
	}
	public String getCha_dept_cd() {
		return cha_dept_cd;
	}
	public void setCha_dept_cd(String cha_dept_cd) {
		this.cha_dept_cd = cha_dept_cd;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}


}
