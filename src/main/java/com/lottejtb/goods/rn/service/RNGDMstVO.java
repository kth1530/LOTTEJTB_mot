package com.lottejtb.goods.rn.service;

import com.lottejtb.comm.service.CommDefaultVO;

/**
* 클래스명    :  상품 마스터 테이블 정보 관련 
* @ClassDesc  : 상품 마스터 테이블 정보 관련 
* @FileName   : RNGDMstVO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2017.02.03 /  / 최초작성
*/

public class RNGDMstVO  extends CommDefaultVO  {
	
	private static final long serialVersionUID = -7815318596752756012L;
	
	private String op_cd = "";
	private String goods_type_cd = "";
	private String area_cd = "";
	private String sub_area_cd = "";
	private String goods_sub_cd = "";
	
	private String start_cd = "";
	private String city_nm = "";
	private String comp_cd = "";
	private String comp_nm = "";
	private String goods_nm = "";
	
	private String short_goods_nm = "";
	private String goods_night_day = "";
	private String goods_cd = "";


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
	public String getSub_area_cd() {
		return sub_area_cd;
	}
	public void setSub_area_cd(String sub_area_cd) {
		this.sub_area_cd = sub_area_cd;
	}
	public String getGoods_sub_cd() {
		return goods_sub_cd;
	}
	public void setGoods_sub_cd(String goods_sub_cd) {
		this.goods_sub_cd = goods_sub_cd;
	}
	public String getStart_cd() {
		return start_cd;
	}
	public void setStart_cd(String start_cd) {
		this.start_cd = start_cd;
	}
	public String getCity_nm() {
		return city_nm;
	}
	public void setCity_nm(String city_nm) {
		this.city_nm = city_nm;
	}
	public String getComp_cd() {
		return comp_cd;
	}
	public void setComp_cd(String comp_cd) {
		this.comp_cd = comp_cd;
	}
	public String getComp_nm() {
		return comp_nm;
	}
	public void setComp_nm(String comp_nm) {
		this.comp_nm = comp_nm;
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
	public String getGoods_night_day() {
		return goods_night_day;
	}
	public void setGoods_night_day(String goods_night_day) {
		this.goods_night_day = goods_night_day;
	}
	

}
