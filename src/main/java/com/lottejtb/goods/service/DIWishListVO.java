package com.lottejtb.goods.service;

import com.lottejtb.comm.service.CommDefaultVO;

/**
* 클래스명    : 찜하기 정보를 담고 있는 클래스 
* @ClassDesc  : 찜하기 정보를 담고 있는 클래스 
* @FileName   : DIWishListVO.java
* @TableName  : t4dev/DI_WISH_LIST
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.25 /  / 최초작성
*/

public class DIWishListVO extends CommDefaultVO  {

	private static final long serialVersionUID = 6644463605851391649L;

	private int wish_seq = 0;
	private String wish_cd = "";
	private int ctg_seq = 0;
	private String cust_cd = "";
	private String goods_cd = "";
	
	private String event_cd = "";
	private String start_day = "";
	
	
	public int getWish_seq() {
		return wish_seq;
	}
	public void setWish_seq(int wish_seq) {
		this.wish_seq = wish_seq;
	}
	public String getWish_cd() {
		return wish_cd;
	}
	public void setWish_cd(String wish_cd) {
		this.wish_cd = wish_cd;
	}
	public int getCtg_seq() {
		return ctg_seq;
	}
	public void setCtg_seq(int ctg_seq) {
		this.ctg_seq = ctg_seq;
	}
	public String getCust_cd() {
		return cust_cd;
	}
	public void setCust_cd(String cust_cd) {
		this.cust_cd = cust_cd;
	}
	public String getGoods_cd() {
		return goods_cd;
	}
	public void setGoods_cd(String goods_cd) {
		this.goods_cd = goods_cd;
	}
	public String getEvent_cd() {
		return event_cd;
	}
	public void setEvent_cd(String event_cd) {
		this.event_cd = event_cd;
	}
	public String getStart_day() {
		return start_day;
	}
	public void setStart_day(String start_day) {
		this.start_day = start_day;
	}
	
	
}
