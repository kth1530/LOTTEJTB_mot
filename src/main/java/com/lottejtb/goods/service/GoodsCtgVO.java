package com.lottejtb.goods.service;

import com.lottejtb.comm.service.CommDefaultVO;

/**
* 클래스명    :  상품 카테고리 정보를 담고 있는 클래스   
* @ClassDesc  : 상품 카테고리 정보를 담고 있는 클래스   
* @FileName   : GoodsCtgVO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.02 /  / 최초작성
*/

public class GoodsCtgVO extends CommDefaultVO {
	private static final long serialVersionUID = -6260398247294896486L;

	private int ctg_seq = 0;
	private int ctg_upr_seq = 0;

	private String ctg_nm = "";
	private String goods_cd = "";
	private String comp_cd = "";
	private String goods_nm = "";
	private String disp_grade = "";
	
	private int goods_day_cnt = 0;
	private int adult_price = 0;
	private String disp_yn = "";
	private String short_goods_nm = "";
	private String ins_dt = "";
	
	private String upd_dt = "";
	private String ins_id = "";
	private String upd_id = "";
	
	public int getCtg_upr_seq() {
		return ctg_upr_seq;
	}

	public void setCtg_upr_seq(int ctg_upr_seq) {
		this.ctg_upr_seq = ctg_upr_seq;
	}
	
	public String getCtg_nm() {
		return ctg_nm;
	}
	
	public void setCtg_nm(String ctg_nm) {
		this.ctg_nm = ctg_nm;
	}	

	public String getShort_goods_nm() {
		return short_goods_nm;
	}
	public void setShort_goods_nm(String short_goods_nm) {
		this.short_goods_nm = short_goods_nm;
	}
	public String getIns_dt() {
		return ins_dt;
	}
	public void setIns_dt(String ins_dt) {
		this.ins_dt = ins_dt;
	}
	public String getUpd_dt() {
		return upd_dt;
	}
	public void setUpd_dt(String upd_dt) {
		this.upd_dt = upd_dt;
	}
	public String getIns_id() {
		return ins_id;
	}
	public void setIns_id(String ins_id) {
		this.ins_id = ins_id;
	}
	public String getUpd_id() {
		return upd_id;
	}
	public void setUpd_id(String upd_id) {
		this.upd_id = upd_id;
	}
	public int getCtg_seq() {
		return ctg_seq;
	}
	public void setCtg_seq(int ctg_seq) {
		this.ctg_seq = ctg_seq;
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
	public String getGoods_nm() {
		return goods_nm;
	}
	public void setGoods_nm(String goods_nm) {
		this.goods_nm = goods_nm;
	}
	public String getDisp_grade() {
		return disp_grade;
	}
	public void setDisp_grade(String disp_grade) {
		this.disp_grade = disp_grade;
	}
	public int getGoods_day_cnt() {
		return goods_day_cnt;
	}
	public void setGoods_day_cnt(int goods_day_cnt) {
		this.goods_day_cnt = goods_day_cnt;
	}
	public int getAdult_price() {
		return adult_price;
	}
	public void setAdult_price(int adult_price) {
		this.adult_price = adult_price;
	}
	public String getDisp_yn() {
		return disp_yn;
	}
	public void setDisp_yn(String disp_yn) {
		this.disp_yn = disp_yn;
	}

}
