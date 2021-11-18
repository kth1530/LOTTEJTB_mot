package com.lottejtb.goods.service;

import java.io.Serializable;

import com.lottejtb.comm.service.CommDefaultVO;

/**
* 클래스명    :  상품  마스터 정보를 담고 있는 클래스   
* @ClassDesc  : 상품 마스터 정보를 담고 있는 클래스   
* @FileName   : GoodsMstVO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.02 /  / 최초작성
*/


public class GoodsMstVO extends CommDefaultVO  {

	private static final long serialVersionUID = 1487523090799454645L;
	
	private int ctg_seq = 0;
	private String goods_cd = "";
	private String op_cd = "";
	private String goods_nm = "";
	private String shart_goods_nm = "";
	
	private int etc_price1 = 0;
	private int etc_price2 = 0;
	private String alr_remark = "";
	private int et_days = 0;
	private String bus_time = "";
	
	private String goods = "";
	private String cd_desc = "";
	private String cd_desc2 = "";
	private String comp_cd = "";
	
	public String getComp_cd() {
		return comp_cd;
	}

	public void setComp_cd(String comp_cd) {
		this.comp_cd = comp_cd;
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

	public String getOp_cd() {
		return op_cd;
	}

	public void setOp_cd(String op_cd) {
		this.op_cd = op_cd;
	}

	public String getGoods_nm() {
		return goods_nm;
	}

	public void setGoods_nm(String goods_nm) {
		this.goods_nm = goods_nm;
	}

	public String getShart_goods_nm() {
		return shart_goods_nm;
	}

	public void setShart_goods_nm(String shart_goods_nm) {
		this.shart_goods_nm = shart_goods_nm;
	}

	public int getEtc_price1() {
		return etc_price1;
	}

	public void setEtc_price1(int etc_price1) {
		this.etc_price1 = etc_price1;
	}

	public int getEtc_price2() {
		return etc_price2;
	}

	public void setEtc_price2(int etc_price2) {
		this.etc_price2 = etc_price2;
	}

	public String getAlr_remark() {
		return alr_remark;
	}

	public void setAlr_remark(String alr_remark) {
		this.alr_remark = alr_remark;
	}

	public int getEt_days() {
		return et_days;
	}

	public void setEt_days(int et_days) {
		this.et_days = et_days;
	}

	public String getBus_time() {
		return bus_time;
	}

	public void setBus_time(String bus_time) {
		this.bus_time = bus_time;
	}

	public String getGoods() {
		return goods;
	}

	public void setGoods(String goods) {
		this.goods = goods;
	}

	public String getCd_desc() {
		return cd_desc;
	}

	public void setCd_desc(String cd_desc) {
		this.cd_desc = cd_desc;
	}

	public String getCd_desc2() {
		return cd_desc2;
	}

	public void setCd_desc2(String cd_desc2) {
		this.cd_desc2 = cd_desc2;
	}

	

}
