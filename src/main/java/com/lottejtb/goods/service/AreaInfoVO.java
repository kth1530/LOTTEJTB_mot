package com.lottejtb.goods.service;

import com.lottejtb.comm.service.CommDefaultVO;

/**
* 클래스명    : 지역 정보를 담고 있는 클래스   
* @ClassDesc  : 지역 정보를 담고 있는 클래스     
* @FileName   : AreaInfoVO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.15 /  / 최초작성
*/


public class AreaInfoVO extends CommDefaultVO {
	private static final long serialVersionUID = 7043038660484102370L;

	private String area_info_type_cd = "";
	private int area_info_seq = 0;
	private String op_cd = "";
	private String city_cd = "";
	private String city_knm = "";
	
	private String country_cd = "";
	private String country_knm = "";
	private String detail_nm = "";
	private String detail_intro = "";
	private String detail_cnts1 = "";
	
	private String detail_cnts2 = "";
	private String detail_cnts3 = "";
	private String knm = "";
	private String place_nm = "";
	private String addr = "";
	
	private String tel = "";
	private String path = "";
	private String url = "";
	private String bus_time = "";
	private String bus_off_day = "";
	
	private String admission = "";
	private String cost = "";
	private String tip = "";
	private String remark = "";
	private String use_yn = "";
	
	private String img_titles = "";
	private String img_paths = "";
	private String info_descs = "";
	
	public String getArea_info_type_cd() {
		return area_info_type_cd;
	}
	public void setArea_info_type_cd(String area_info_type_cd) {
		this.area_info_type_cd = area_info_type_cd;
	}
	public int getArea_info_seq() {
		return area_info_seq;
	}
	public void setArea_info_seq(int area_info_seq) {
		this.area_info_seq = area_info_seq;
	}
	public String getOp_cd() {
		return op_cd;
	}
	public void setOp_cd(String op_cd) {
		this.op_cd = op_cd;
	}
	public String getCity_cd() {
		return city_cd;
	}
	public void setCity_cd(String city_cd) {
		this.city_cd = city_cd;
	}
	public String getCity_knm() {
		return city_knm;
	}
	public void setCity_knm(String city_knm) {
		this.city_knm = city_knm;
	}
	public String getCountry_cd() {
		return country_cd;
	}
	public void setCountry_cd(String country_cd) {
		this.country_cd = country_cd;
	}
	public String getCountry_knm() {
		return country_knm;
	}
	public void setCountry_knm(String country_knm) {
		this.country_knm = country_knm;
	}
	public String getDetail_nm() {
		return detail_nm;
	}
	public void setDetail_nm(String detail_nm) {
		this.detail_nm = detail_nm;
	}
	public String getDetail_intro() {
		return detail_intro;
	}
	public void setDetail_intro(String detail_intro) {
		this.detail_intro = detail_intro;
	}
	public String getDetail_cnts1() {
		return detail_cnts1;
	}
	public void setDetail_cnts1(String detail_cnts1) {
		this.detail_cnts1 = detail_cnts1;
	}
	public String getDetail_cnts2() {
		return detail_cnts2;
	}
	public void setDetail_cnts2(String detail_cnts2) {
		this.detail_cnts2 = detail_cnts2;
	}
	public String getDetail_cnts3() {
		return detail_cnts3;
	}
	public void setDetail_cnts3(String detail_cnts3) {
		this.detail_cnts3 = detail_cnts3;
	}
	public String getKnm() {
		return knm;
	}
	public void setKnm(String knm) {
		this.knm = knm;
	}
	public String getPlace_nm() {
		return place_nm;
	}
	public void setPlace_nm(String place_nm) {
		this.place_nm = place_nm;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getBus_time() {
		return bus_time;
	}
	public void setBus_time(String bus_time) {
		this.bus_time = bus_time;
	}
	public String getBus_off_day() {
		return bus_off_day;
	}
	public void setBus_off_day(String bus_off_day) {
		this.bus_off_day = bus_off_day;
	}
	public String getAdmission() {
		return admission;
	}
	public void setAdmission(String admission) {
		this.admission = admission;
	}
	public String getCost() {
		return cost;
	}
	public void setCost(String cost) {
		this.cost = cost;
	}
	public String getTip() {
		return tip;
	}
	public void setTip(String tip) {
		this.tip = tip;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getImg_titles() {
		return img_titles;
	}
	public void setImg_titles(String img_titles) {
		this.img_titles = img_titles;
	}
	public String getImg_paths() {
		return img_paths;
	}
	public void setImg_paths(String img_paths) {
		this.img_paths = img_paths;
	}
	public String getInfo_descs() {
		return info_descs;
	}
	public void setInfo_descs(String info_descs) {
		this.info_descs = info_descs;
	}
	
	
}
