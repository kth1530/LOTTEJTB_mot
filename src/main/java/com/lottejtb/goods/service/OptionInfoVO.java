package com.lottejtb.goods.service;

import com.lottejtb.comm.service.CommDefaultVO;

/**
* 클래스명    : 옵션 정보를 담고 있는 클래스   
* @ClassDesc  : 옵션 정보를 담고 있는 클래스     
* @FileName   : OptionInfoVO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.15 /  / 최초작성
*/

public class OptionInfoVO extends CommDefaultVO {

	private static final long serialVersionUID = -4542248402025811784L;

	private String event_cd = "";
	private String op_cd = "";
	private String area_cd = "";
	private String option_cd = "";
	private String sub_area_cd = "";
	
	private String country_cd = "";
	private String contry_knm = "";
	private String city_cd = "";
	private String city_knm = "";
	private String price_info = "";
	
	private String op_time = "";
	private String option_desc = "";
	private String include_desc = "";
	private String use_yn = "";	
	private String img_titles = "";
	
	private String img_paths = "";
	private String info_descs = "";
	private String detail_yn = "";
	private String date_yn = "";
	private String other_schd = "";
	
	private String guide_yn = "";

	public String getEvent_cd() {
		return event_cd;
	}

	public void setEvent_cd(String event_cd) {
		this.event_cd = event_cd;
	}

	public String getOp_cd() {
		return op_cd;
	}

	public void setOp_cd(String op_cd) {
		this.op_cd = op_cd;
	}

	public String getArea_cd() {
		return area_cd;
	}

	public void setArea_cd(String area_cd) {
		this.area_cd = area_cd;
	}

	public String getOption_cd() {
		return option_cd;
	}

	public void setOption_cd(String option_cd) {
		this.option_cd = option_cd;
	}

	public String getSub_area_cd() {
		return sub_area_cd;
	}

	public void setSub_area_cd(String sub_area_cd) {
		this.sub_area_cd = sub_area_cd;
	}

	public String getCountry_cd() {
		return country_cd;
	}

	public void setCountry_cd(String country_cd) {
		this.country_cd = country_cd;
	}

	public String getContry_knm() {
		return contry_knm;
	}

	public void setContry_knm(String contry_knm) {
		this.contry_knm = contry_knm;
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

	public String getPrice_info() {
		return price_info;
	}

	public void setPrice_info(String price_info) {
		this.price_info = price_info;
	}

	public String getOp_time() {
		return op_time;
	}

	public void setOp_time(String op_time) {
		this.op_time = op_time;
	}

	public String getOption_desc() {
		return option_desc;
	}

	public void setOption_desc(String option_desc) {
		this.option_desc = option_desc;
	}

	public String getInclude_desc() {
		return include_desc;
	}

	public void setInclude_desc(String include_desc) {
		this.include_desc = include_desc;
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

	public String getDetail_yn() {
		return detail_yn;
	}

	public void setDetail_yn(String detail_yn) {
		this.detail_yn = detail_yn;
	}

	public String getDate_yn() {
		return date_yn;
	}

	public void setDate_yn(String date_yn) {
		this.date_yn = date_yn;
	}

	public String getOther_schd() {
		return other_schd;
	}

	public void setOther_schd(String other_schd) {
		this.other_schd = other_schd;
	}

	public String getGuide_yn() {
		return guide_yn;
	}

	public void setGuide_yn(String guide_yn) {
		this.guide_yn = guide_yn;
	}
	
}
