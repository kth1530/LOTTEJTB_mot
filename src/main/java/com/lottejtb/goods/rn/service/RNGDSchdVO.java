package com.lottejtb.goods.rn.service;

import com.lottejtb.comm.service.CommDefaultVO;
import com.lottejtb.comm.util.CommUtil;
import com.lottejtb.util.Util;

/**
* 클래스명    :  행사 상품  일정표 
* @ClassDesc  : 행사 상품  일정표 
* @FileName   : RNGDSchdVO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2017.02.03 /  / 최초작성
*/

public class RNGDSchdVO  extends CommDefaultVO   {
	
	private static final long serialVersionUID = -3848338804900518799L;
	
	private int schd_id = 0;
	private int reg_seq = 0;
	private int day_cnt = 0;
	private int seq = 0;
	private String schd_det_cd = "";
	
	private String schd_det_cd_val = "";
	private String schd_det_cntn = "";
	private String schd_det_clval = "";
	private String schd_det_nm = "";
	private String img_title = "";
	private String img_path = "";
	
	private String disp_yn = "";
	private String include_yn = "";
	private String o_op_cd = "";
	private String o_area_cd = "";
	private String o_option_cd = "";
	
	private String o_sub_area_cd = "";
	private String o_option_nm = "";
	private String o_country_cd = "";
	private String o_city_cd = "";
	private String o_price_info = "";
	
	private String o_op_time = "";
	private String o_option_desc = "";
	private String o_include_desc = "";
	private String o_use_yn = "";
	private String o_dept_cd = "";
	
	private String o_other_schd = "";
	private String o_guide_yn = "";
	private String d_country_cd = "";
	private String d_city_cd = "";
	// 신규 추가 
	private String d_city_nm = "";
	private String d_bus_time = "";
	private String d_cost = "";

	private String d_detail_cnts1 = "";	
	private String d_knm = "";
	
	private String h_lodge_knm = "";
	private String h_lodge_grade = "";
	private String h_country_cd = "";
	private String h_city_cd = "";
	
	private String h_hotel_desc = "";	
	private String h_homepage_url = "";
	private String h_phone_no = "";
	private String h_address = "";
	private String h_location_desc = "";
	
	private String d_imgs = "";
	private String o_imgs = "";
	private String h_imgs = "";
	
	private String event_cd = "";
	
	private String country_cd = "";
	private String country_nm = "";
	
	public RNGDSchdVO() {
		// TODO Auto-generated constructor stub
	}

	
	public String getEvent_cd() {
		return event_cd;
	}


	public void setEvent_cd(String event_cd) {
		this.event_cd = event_cd;
	}


	public int getSchd_id() {
		return schd_id;
	}

	public void setSchd_id(int schd_id) {
		this.schd_id = schd_id;
	}

	public int getReg_seq() {
		return reg_seq;
	}

	public void setReg_seq(int reg_seq) {
		this.reg_seq = reg_seq;
	}

	public int getDay_cnt() {
		return day_cnt;
	}

	public void setDay_cnt(int day_cnt) {
		this.day_cnt = day_cnt;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getSchd_det_cd() {
		return schd_det_cd;
	}

	public void setSchd_det_cd(String schd_det_cd) {
		this.schd_det_cd = schd_det_cd;
	}

	public String getSchd_det_cd_val() {
		return schd_det_cd_val;
	}

	public void setSchd_det_cd_val(String schd_det_cd_val) {
		this.schd_det_cd_val = schd_det_cd_val;
	}

	public String getSchd_det_cntn() {
		return schd_det_cntn;
	}

	public void setSchd_det_cntn(String schd_det_cntn) {
		
		this.schd_det_cntn = Util.strip_tags(schd_det_cntn);
	}

	public String getSchd_det_clval() {
		return schd_det_clval;
	}

	public void setSchd_det_clval(String schd_det_clval) {
		this.schd_det_clval = schd_det_clval;
	}

	public String getImg_title() {
		return img_title;
	}

	public void setImg_title(String img_title) {
		this.img_title = img_title;
	}

	public String getImg_path() {
		return img_path;
	}

	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}

	public String getDisp_yn() {
		return disp_yn;
	}

	public void setDisp_yn(String disp_yn) {
		this.disp_yn = disp_yn;
	}

	public String getInclude_yn() {
		return include_yn;
	}

	public void setInclude_yn(String include_yn) {
		this.include_yn = include_yn;
	}

	public String getO_op_cd() {
		return o_op_cd;
	}

	public void setO_op_cd(String o_op_cd) {
		this.o_op_cd = o_op_cd;
	}

	public String getO_area_cd() {
		return o_area_cd;
	}

	public void setO_area_cd(String o_area_cd) {
		this.o_area_cd = o_area_cd;
	}

	public String getO_option_cd() {
		return o_option_cd;
	}

	public void setO_option_cd(String o_option_cd) {
		this.o_option_cd = o_option_cd;
	}

	public String getO_sub_area_cd() {
		return o_sub_area_cd;
	}

	public void setO_sub_area_cd(String o_sub_area_cd) {
		this.o_sub_area_cd = o_sub_area_cd;
	}

	public String getO_option_nm() {
		return o_option_nm;
	}

	public void setO_option_nm(String o_option_nm) {
		this.o_option_nm = o_option_nm;
	}

	public String getO_country_cd() {
		return o_country_cd;
	}

	public void setO_country_cd(String o_country_cd) {
		this.o_country_cd = o_country_cd;
	}

	public String getO_city_cd() {
		return o_city_cd;
	}

	public void setO_city_cd(String o_city_cd) {
		this.o_city_cd = o_city_cd;
	}

	public String getO_price_info() {
		return o_price_info;
	}

	public void setO_price_info(String o_price_info) {
		this.o_price_info = o_price_info;
	}

	public String getO_op_time() {
		return o_op_time;
	}

	public void setO_op_time(String o_op_time) {
		this.o_op_time = o_op_time;
	}

	public String getO_option_desc() {
		return o_option_desc;
	}

	public void setO_option_desc(String o_option_desc) {
		this.o_option_desc = o_option_desc;
	}

	public String getO_include_desc() {
		return o_include_desc;
	}

	public void setO_include_desc(String o_include_desc) {
		this.o_include_desc = o_include_desc;
	}

	public String getO_use_yn() {
		return o_use_yn;
	}

	public void setO_use_yn(String o_use_yn) {
		this.o_use_yn = o_use_yn;
	}

	public String getO_dept_cd() {
		return o_dept_cd;
	}

	public void setO_dept_cd(String o_dept_cd) {
		this.o_dept_cd = o_dept_cd;
	}

	public String getO_other_schd() {
		return o_other_schd;
	}

	public void setO_other_schd(String o_other_schd) {
		this.o_other_schd = o_other_schd;
	}

	public String getO_guide_yn() {
		return o_guide_yn;
	}

	public void setO_guide_yn(String o_guide_yn) {
		this.o_guide_yn = o_guide_yn;
	}

	public String getD_country_cd() {
		return d_country_cd;
	}

	public void setD_country_cd(String d_country_cd) {
		this.d_country_cd = d_country_cd;
	}

	public String getD_city_cd() {
		return d_city_cd;
	}

	public void setD_city_cd(String d_city_cd) {
		this.d_city_cd = d_city_cd;
	}

	public String getD_detail_cnts1() {
		return d_detail_cnts1;
	}

	public void setD_detail_cnts1(String d_detail_cnts1) {
		this.d_detail_cnts1 = d_detail_cnts1;
	}

	public String getD_knm() {
		return d_knm;
	}

	public void setD_knm(String d_knm) {
		this.d_knm = d_knm;
	}

	public String getH_lodge_knm() {
		return h_lodge_knm;
	}

	public void setH_lodge_knm(String h_lodge_knm) {
		this.h_lodge_knm = h_lodge_knm;
	}

	public String getH_lodge_grade() {
		return h_lodge_grade;
	}

	public void setH_lodge_grade(String h_lodge_grade) {
		this.h_lodge_grade = h_lodge_grade;
	}

	public String getH_country_cd() {
		return h_country_cd;
	}

	public void setH_country_cd(String h_country_cd) {
		this.h_country_cd = h_country_cd;
	}

	public String getH_city_cd() {
		return h_city_cd;
	}

	public void setH_city_cd(String h_city_cd) {
		this.h_city_cd = h_city_cd;
	}

	public String getH_hotel_desc() {
		return h_hotel_desc;
	}

	public void setH_hotel_desc(String h_hotel_desc) {
		this.h_hotel_desc = h_hotel_desc;
	}

	public String getH_homepage_url() {
		return h_homepage_url;
	}

	public void setH_homepage_url(String h_homepage_url) {
		this.h_homepage_url = h_homepage_url;
	}

	public String getH_phone_no() {
		return h_phone_no;
	}

	public void setH_phone_no(String h_phone_no) {
		this.h_phone_no = h_phone_no;
	}

	public String getH_address() {
		return h_address;
	}

	public void setH_address(String h_address) {
		this.h_address = h_address;
	}

	public String getH_location_desc() {
		return h_location_desc;
	}

	public void setH_location_desc(String h_location_desc) {
		this.h_location_desc = h_location_desc;
	}

	public String getD_imgs() {
		return d_imgs;
	}

	public void setD_imgs(String d_imgs) {
		this.d_imgs = d_imgs;
	}

	public String getO_imgs() {
		return o_imgs;
	}

	public void setO_imgs(String o_imgs) {
		this.o_imgs = o_imgs;
	}

	public String getH_imgs() {
		return h_imgs;
	}

	public void setH_imgs(String h_imgs) {
		this.h_imgs = h_imgs;
	}
	
	public String getD_city_nm() {
		return d_city_nm;
	}


	public void setD_city_nm(String d_city_nm) {
		this.d_city_nm = d_city_nm;
	}


	public String getD_bus_time() {
		return d_bus_time;
	}


	public void setD_bus_time(String d_bus_time) {
		this.d_bus_time = d_bus_time;
	}


	public String getD_cost() {
		return d_cost;
	}


	public void setD_cost(String d_cost) {
		this.d_cost = d_cost;
	}
	
	public String getSchd_det_nm() {
		return schd_det_nm;
	}


	public void setSchd_det_nm(String schd_det_nm) {
		this.schd_det_nm = schd_det_nm;
	}


	public String getCountry_cd() {
		return country_cd;
	}


	public void setCountry_cd(String country_cd) {
		this.country_cd = country_cd;
	}


	public String getCountry_nm() {
		return country_nm;
	}


	public void setCountry_nm(String country_nm) {
		this.country_nm = country_nm;
	}	
}
