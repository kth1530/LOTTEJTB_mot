package com.lottejtb.search.service;

import com.lottejtb.comm.service.CommDefaultVO;


/**
* 클래스명    :  상품 검색 정보를 담고 있는 클래스   
* @ClassDesc  :  상품 검색 정보를 담고 있는 클래스      
* @FileName   : SearchGoodsVO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.11 /  / 최초작성
*/

public class SearchGoodsVO extends CommDefaultVO {

	private static final long serialVersionUID = 61796222266397332L;
	
	private int ctg_seq = 0;
	private String comp_cd = "";
	private String goods_cd = "";
	private String op_cd = "";
	private String goods_type_cd = "";
	
	private String area_cd = "";
	private String cd_nm01 = "";
	private String sub_area_cd = "";
	private String cd_nm02 = "";
	private String goods_sub_cd = "";
	
	private String goods_nm = "";
	private int goods_day_cnt = 0;
	private int goods_night_cnt = 0;
	private int disp_grade = 0;
	private int disp_order = 0;
	
	private int adult_price = 0;
	private String et_days = "";
	private String save_file_nm = "";
	private String img_path = "";
	private String start_cd_nm = "";
	
	private String short_goods_nm = "";
	private String event_nm = "";
	private String disp_nm = "";
	private String event_desc;
	private String emp_rate = "";
	
	private String homeshopping_yn = "";
	private String plan_yn = "";
	private String event_yn = "";
	private String str_adult_price = "";
	private String orderby = "";
	private String goods_nights = "";
	private String start_day = "";
	
	
	public String getStart_day() {
		return start_day;
	}
	public void setStart_day(String start_day) {
		this.start_day = start_day;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getGoods_nights() {
		return goods_nights;
	}
	public void setGoods_nights(String goods_nights) {
		this.goods_nights = goods_nights;
	}
	public String getOrderby() {
		return orderby;
	}
	public void setOrderby(String orderby) {
		this.orderby = orderby;
	}
	public String getStr_adult_price() {
		return str_adult_price;
	}
	public void setStr_adult_price(String str_adult_price) {
		this.str_adult_price = str_adult_price;
	}
	public int getCtg_seq() {
		return ctg_seq;
	}
	public void setCtg_seq(int ctg_seq) {
		this.ctg_seq = ctg_seq;
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
	public String getOp_cd() {
		return op_cd;
	}
	public void setOp_cd(String op_cd) {
		this.op_cd = op_cd;
	}
	public String getGoods_type_cd() {
		return goods_type_cd;
	}
	public void setGoods_type_cd(String goods_type_cd) {
		this.goods_type_cd = goods_type_cd;
	}
	public String getArea_cd() {
		return area_cd;
	}
	public void setArea_cd(String area_cd) {
		this.area_cd = area_cd;
	}
	public String getCd_nm01() {
		return cd_nm01;
	}
	public void setCd_nm01(String cd_nm01) {
		this.cd_nm01 = cd_nm01;
	}
	public String getSub_area_cd() {
		return sub_area_cd;
	}
	public void setSub_area_cd(String sub_area_cd) {
		this.sub_area_cd = sub_area_cd;
	}
	public String getCd_nm02() {
		return cd_nm02;
	}
	public void setCd_nm02(String cd_nm02) {
		this.cd_nm02 = cd_nm02;
	}
	public String getGoods_sub_cd() {
		return goods_sub_cd;
	}
	public void setGoods_sub_cd(String goods_sub_cd) {
		this.goods_sub_cd = goods_sub_cd;
	}
	public String getGoods_nm() {
		return goods_nm;
	}
	public void setGoods_nm(String goods_nm) {
		this.goods_nm = goods_nm;
	}
	public int getGoods_day_cnt() {
		return goods_day_cnt;
	}
	public void setGoods_day_cnt(int goods_day_cnt) {
		this.goods_day_cnt = goods_day_cnt;
	}
	public int getGoods_night_cnt() {
		return goods_night_cnt;
	}
	public void setGoods_night_cnt(int goods_night_cnt) {
		this.goods_night_cnt = goods_night_cnt;
	}
	public int getDisp_grade() {
		return disp_grade;
	}
	public void setDisp_grade(int disp_grade) {
		this.disp_grade = disp_grade;
	}
	public int getDisp_order() {
		return disp_order;
	}
	public void setDisp_order(int disp_order) {
		this.disp_order = disp_order;
	}
	public int getAdult_price() {
		return adult_price;
	}
	public void setAdult_price(int adult_price) {
		this.adult_price = adult_price;
	}
	public String getEt_days() {
		return et_days;
	}
	public void setEt_days(String et_days) {
		this.et_days = et_days;
	}
	public String getSave_file_nm() {
		return save_file_nm;
	}
	public void setSave_file_nm(String save_file_nm) {
		this.save_file_nm = save_file_nm;
	}
	public String getImg_path() {
		return img_path;
	}
	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}
	public String getStart_cd_nm() {
		return start_cd_nm;
	}
	public void setStart_cd_nm(String start_cd_nm) {
		this.start_cd_nm = start_cd_nm;
	}
	public String getShort_goods_nm() {
		return short_goods_nm;
	}
	public void setShort_goods_nm(String short_goods_nm) {
		this.short_goods_nm = short_goods_nm;
	}
	public String getEvent_nm() {
		return event_nm;
	}
	public void setEvent_nm(String event_nm) {
		this.event_nm = event_nm;
	}
	public String getDisp_nm() {
		return disp_nm;
	}
	public void setDisp_nm(String disp_nm) {
		this.disp_nm = disp_nm;
	}
	public String getEvent_desc() {
		return event_desc;
	}
	public void setEvent_desc(String event_desc) {
		this.event_desc = event_desc;
	}
	public String getEmp_rate() {
		return emp_rate;
	}
	public void setEmp_rate(String emp_rate) {
		this.emp_rate = emp_rate;
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
	
	
}
