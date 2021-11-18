package com.lottejtb.goods.service;

import com.lottejtb.comm.service.CommDefaultVO;

/**
* 클래스명    :  상품  정보를 담고 있는 클래스   
* @ClassDesc  : 상품 정보를 담고 있는 클래스   
* @FileName   : GoodsVO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.02 /  / 최초작성
*/


public class GoodsVO extends CommDefaultVO  {

	private static final long serialVersionUID = -3284756388830918420L;

	private String comp_cd = "";
	private String goods_cd = "";
	private String goods_nm = "";
	private String short_goods_nm = "";
	private String emp_rate = "";
	
	private String adult_price = "";
	private String str_adult_price = "";
	private String et_days = "";
	private int goods_night_cnt = 0;
	private int goods_day_cnt = 0;
	private String goods_desc = "";
	
	private String img_path = "";
	private String save_file_nm = "";
	private int ctg_seq = 0;
	private String homeshopping_yn = "";
	private String plan_yn = "";
	
	private String event_yn = "";
	private String premium_yn = "";
	private String classic_yn = "";
	private String save_yn = "";
	private int disp_order = 0;
	private String disp_yn = "";
	
	private String str_et_price1 = "";
	private String str_et_price2 = "";
	private int et_price1 = 0;
	private int et_price2 = 0;
	
	
	private String air_remark = "";
	private String bus_time = "";
	private String orderby = "";				// 정렬 방식 
	private String start_day = "";			// 시작일자 
	private String goods_nights = ""; 		// 숙박일수 

	private String adult_price2 = "";
	private String etc_price1 = "";
	
	public String getGoods_nights() {
		return goods_nights;
	}
	public void setGoods_nights(String goods_nights) {
		this.goods_nights = goods_nights;
	}
	public String getStr_adult_price() {
		return str_adult_price;
	}
	public void setStr_adult_price(String str_adult_price) {
		this.str_adult_price = str_adult_price;
	}

	public String getStart_day() {
		return start_day;
	}
	public void setStart_day(String start_day) {
		this.start_day = start_day;
	}
	public String getOrderby() {
		return orderby;
	}
	public void setOrderby(String orderby) {
		this.orderby = orderby;
	}
	
	public String getComp_cd() {
		return comp_cd;
	}
	public void setComp_cd(String comp_cd) {
		this.comp_cd = comp_cd;
	}
	public String getGoods_cd() {
		return goods_cd;
	}
	public void setGoods_cd(String goods_cd) {
		this.goods_cd = goods_cd;
	}
	public String getGoods_nm() {
		return goods_nm;
	}
	public void setGoods_nm(String goods_nm) {
		this.goods_nm = goods_nm;
	}
	public String getShort_goods_nm() {
		return short_goods_nm;
	}
	public void setShort_goods_nm(String short_goods_nm) {
		this.short_goods_nm = short_goods_nm;
	}
	public String getEmp_rate() {
		return emp_rate;
	}
	public void setEmp_rate(String emp_rate) {
		this.emp_rate = emp_rate;
	}
	public String getAdult_price() {
		return adult_price;
	}
	public void setAdult_price(String adult_price) {
		this.adult_price = adult_price;
	}
	public String getEt_days() {
		return et_days;
	}
	public void setEt_days(String et_days) {
		this.et_days = et_days;
	}
	public int getGoods_night_cnt() {
		return goods_night_cnt;
	}
	public void setGoods_night_cnt(int goods_night_cnt) {
		this.goods_night_cnt = goods_night_cnt;
	}
	public int getGoods_day_cnt() {
		return goods_day_cnt;
	}
	public void setGoods_day_cnt(int goods_day_cnt) {
		this.goods_day_cnt = goods_day_cnt;
	}
	public String getGoods_desc() {
		return goods_desc;
	}
	public void setGoods_desc(String goods_desc) {
		this.goods_desc = goods_desc;
	}
	public String getImg_path() {
		return img_path;
	}
	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}
	public String getSave_file_nm() {
		return save_file_nm;
	}
	public void setSave_file_nm(String save_file_nm) {
		this.save_file_nm = save_file_nm;
	}
	public int getCtg_seq() {
		return ctg_seq;
	}
	public void setCtg_seq(int ctg_seq) {
		this.ctg_seq = ctg_seq;
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
	public int getDisp_order() {
		return disp_order;
	}
	public void setDisp_order(int disp_order) {
		this.disp_order = disp_order;
	}
	public String getDisp_yn() {
		return disp_yn;
	}
	public void setDisp_yn(String disp_yn) {
		this.disp_yn = disp_yn;
	}

	public String getStr_et_price1() {
		return str_et_price1;
	}
	public void setStr_et_price1(String str_et_price1) {
		this.str_et_price1 = str_et_price1;
	}
	public int getEt_price1() {
		return et_price1;
	}
	public void setEt_price1(int et_price1) {
		this.et_price1 = et_price1;
	}
	public int getEt_price2() {
		return et_price2;
	}
	public void setEt_price2(int et_price2) {
		this.et_price2 = et_price2;
	}	
	public void setStr_et_price(String str_et_price1) {
		this.str_et_price1 = str_et_price1;
	}
	public String getStr_et_price2() {
		return str_et_price2;
	}
	public void setStr_et_price2(String str_et_price2) {
		this.str_et_price2 = str_et_price2;
	}
	public String getAir_remark() {
		return air_remark;
	}
	public void setAir_remark(String air_remark) {
		this.air_remark = air_remark;
	}
	public String getBus_time() {
		return bus_time;
	}
	public void setBus_time(String bus_time) {
		this.bus_time = bus_time;
	}
	public String getAdult_price2() {
		return adult_price2;
	}
	public void setAdult_price2(String adult_price2) {
		this.adult_price2 = adult_price2;
	}
	public String getEtc_price1() {
		return etc_price1;
	}
	public void setEtc_price1(String etc_price1) {
		this.etc_price1 = etc_price1;
	}
	

	
}
