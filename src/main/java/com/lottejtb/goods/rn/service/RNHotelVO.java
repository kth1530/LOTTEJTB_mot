package com.lottejtb.goods.rn.service;

import com.lottejtb.comm.service.CommDefaultVO;

/**
* 클래스명    :  행사 상품의 호텔 정보 
* @ClassDesc  : 행사 상품의 호텔 정보 
* @FileName   : RNHotelVO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2017.02.06 /  / 최초작성
*/


public class RNHotelVO extends CommDefaultVO {

	private static final long serialVersionUID = 6351387008557830081L;
	
	private int hotel_grp_seq = 0;
	private String hotel_grp_nm = "";
	private String goods_cd = "";
	private String comp_cd = "";
	private String event_cd = "";
	private int ctg_seq = 0;
	private String start_day = "";
	
	
	public RNHotelVO() {
		// TODO Auto-generated constructor stub
	}


	public int getHotel_grp_seq() {
		return hotel_grp_seq;
	}


	public void setHotel_grp_seq(int hotel_grp_seq) {
		this.hotel_grp_seq = hotel_grp_seq;
	}


	public String getHotel_grp_nm() {
		return hotel_grp_nm;
	}


	public void setHotel_grp_nm(String hotel_grp_nm) {
		this.hotel_grp_nm = hotel_grp_nm;
	}


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


	public int getCtg_seq() {
		return ctg_seq;
	}


	public void setCtg_seq(int ctg_seq) {
		this.ctg_seq = ctg_seq;
	}


	public String getStart_day() {
		return start_day;
	}


	public void setStart_day(String start_day) {
		this.start_day = start_day;
	}
}
