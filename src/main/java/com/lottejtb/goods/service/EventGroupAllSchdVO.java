package com.lottejtb.goods.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.lottejtb.comm.service.CommDefaultVO;


/**
* 클래스명    :  상세일정 그룹 전체조회 정보를 담고 있는 클래스   
* @ClassDesc  :  상세일정 그룹 전체조회 정보를 담고 있는 클래스     
* @FileName   : EventGroupAllSchdVO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.11 /  / 최초작성
*/

public class EventGroupAllSchdVO extends CommDefaultVO {

	private static final long serialVersionUID = -1595416356843202927L;
	
	// ----------------------------------------------------------------------------
	private String group_id = "";
	private String sub_group = "";
	private String division = "";
	private String key_seq = "";
	private String event_cd = "";
	
	private String goods_cd = "";
	private String comp_cd = "";
	private int sect_seq = 0;
	private int day_cnt = 0;
	private int seq = 0;
	
	private int orders = 0;	
	private String ins_dt = "";
	private String ins_id = "";
	private String upd_dt = "";
	private String upd_id = "";
	
	private String continent_cd = "";
	private String continent_knm = "";
	private String continent_enm = "";
	private String country_cd = "";
	private String country_knm = "";
	
	private String country_enm = "";
	private String city_cd = "";
	private String city_knm = "";
	private String city_enm = "";
	private String title = "";
	
	private String ampm = "";
	private String hour = "";
	private String minute = "";
	private String ole = "";
	private String img_title1 = "";
	
	private String img_path_local1= "";
	private String img_path_server1 = "";
	private String img_alt1 = "";
	private String img_link_url1 = "";
	private String target_type1 = "";
	
	private String img_title2 = "";
	private String img_path_local2 = "";
	private String img_path_server2 = "";
	private String img_alt2 = "";
	private String img_link_url2 = "";
	
	private String target_type2 = "";
	private String img_title3 = "";
	private String img_path_local3 = "";
	private String img_path_server3 = "";
	private String img_alt3 = "";
	
	private String img_link_url3 = "";
	private String target_type3 = "";
	private String area_info_type_cd = "";
	private String area_info_seq = "";
	private String op_cd = "";
	
	private String knm = "";
	private String detail_nm = "";
	private String img_path = "";
	private String img_path_web = "";
	private String img_title = "";
	
	private String info_desc = "";
	private String hotel_reserve_type = "";
	private String etc_text = "";
	private String before_day_pendency = "";
	private String notify_type_pendency = "";
	
	private String before_day_schedule = "";
	private String notify_type_schedule = "";
	private String op_cd_confirm = "";
	private String city_cd_confirm = "";
	private String lodge_cd_confirm = "";
	
	private String op_cd1 = "";
	private String city_cd1 = "";
	private String lodge_cd1 = "";
	private String op_cd2 = "";
	private String city_cd2 = "";
	
	private String lodge_cd2 = "";
	private String op_cd3 = "";
	private String city_cd3 = "";
	private String lodge_cd3 = "";	
	private String op_cd4 = "";
	
	private String city_cd4 = "";
	private String lodge_cd4 = "";
	private String op_cd5 = "";
	private String city_cd5 = "";
	private String lodge_cd5 = "";
	
	private String hotel_knm_confirm = "";
	private String hotel_enm_confirm = "";
	
	private String homepage_url_confirm = "";
	private String hotel1_enm = "";
	private String hotel1_knm = "";
	private String hotel1_homepage_url = "";	
	
	private String hotel2_enm = "";	
	private String hotel2_knm = "";
	private String hotel2_homepage_url = "";
	private String hotel3_enm = "";
	private String hotel3_knm = "";

	private String hotel3_homepage_url = "";
	private String hotel4_enm = "";
	private String hotel4_knm = "";	
	private String hotel4_homepage_url = "";
	private String hotel5_enm = "";
	
	private String hotel5_knm = "";	
	private String hotel5_homepage_url = "";
	private String hotel_grade_confirm = "";
	private String hotel1_grade = "";
	private String hotel2_grade = "";
	
	private String hotel3_grade = "";
	private String hotel4_grade = "";
	private String hotel5_grade = "";
	private String before_day_pendency_name = "";
	private String notify_type_pendency_name = "";
	
	private String before_day_schedule_name = "";
	private String notify_type_schedule_name = "";
	private String etc = "";
	private String area_cd = "";
	private String option_cd = "";
	
	private String option_nm = "";
	private String img_titles = "";
	private String img_paths = "";
	private String info_descs = "";
	private String place_nm = "";
	
	private String detail_intro = "";
	private String detail_cnts1 = "";
	private String detail_cnts2 = "";
	private String detail_cnts3 = "";
	private String price_info = "";
	
	private String include_desc = "";	
	private int ctg_seq = 0;


	public int getCtg_seq() {
		return ctg_seq;
	}

	public void setCtg_seq(int ctg_seq) {
		this.ctg_seq = ctg_seq;
	}

	public String getHotel_knm_confirm() {
		return hotel_knm_confirm;
	}

	public void setHotel_enm_confirm(String hotel_enm_confirm) {
		this.hotel_enm_confirm = hotel_enm_confirm;
	}

	public String getGroup_id() {
		return group_id;
	}

	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}

	public String getSub_group() {
		return sub_group;
	}

	public void setSub_group(String sub_group) {
		this.sub_group = sub_group;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getKey_seq() {
		return key_seq;
	}

	public void setKey_seq(String key_seq) {
		this.key_seq = key_seq;
	}

	public String getEvent_cd() {
		return event_cd;
	}

	public void setEvent_cd(String event_cd) {
		this.event_cd = event_cd;
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

	public int getSect_seq() {
		return sect_seq;
	}

	public void setSect_seq(int sect_seq) {
		this.sect_seq = sect_seq;
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

	public int getOrders() {
		return orders;
	}

	public void setOrders(int orders) {
		this.orders = orders;
	}

	public String getIns_dt() {
		return ins_dt;
	}

	public void setIns_dt(String ins_dt) {
		this.ins_dt = ins_dt;
	}

	public String getIns_id() {
		return ins_id;
	}

	public void setIns_id(String ins_id) {
		this.ins_id = ins_id;
	}

	public String getUpd_dt() {
		return upd_dt;
	}

	public void setUpd_dt(String upd_dt) {
		this.upd_dt = upd_dt;
	}

	public String getUpd_id() {
		return upd_id;
	}

	public void setUpd_id(String upd_id) {
		this.upd_id = upd_id;
	}

	public String getContinent_cd() {
		return continent_cd;
	}

	public void setContinent_cd(String continent_cd) {
		this.continent_cd = continent_cd;
	}

	public String getContinent_knm() {
		return continent_knm;
	}

	public void setContinent_knm(String continent_knm) {
		this.continent_knm = continent_knm;
	}

	public String getContinent_enm() {
		return continent_enm;
	}

	public void setContinent_enm(String continent_enm) {
		this.continent_enm = continent_enm;
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

	public String getCountry_enm() {
		return country_enm;
	}

	public void setCountry_enm(String country_enm) {
		this.country_enm = country_enm;
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

	public String getCity_enm() {
		return city_enm;
	}

	public void setCity_enm(String city_enm) {
		this.city_enm = city_enm;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAmpm() {
		return ampm;
	}

	public void setAmpm(String ampm) {
		this.ampm = ampm;
	}

	public String getHour() {
		return hour;
	}

	public void setHour(String hour) {
		this.hour = hour;
	}

	public String getMinute() {
		return minute;
	}

	public void setMinute(String minute) {
		this.minute = minute;
	}

	public String getOle() {
		return ole;
	}

	public void setOLE(String ole) {
		ole = ole;
	}

	public String getImg_title1() {
		return img_title1;
	}

	public void setImg_title1(String img_title1) {
		this.img_title1 = img_title1;
	}

	public String getImg_path_local1() {
		return img_path_local1;
	}

	public void setImg_path_local1(String img_path_local1) {
		this.img_path_local1 = img_path_local1;
	}

	public String getImg_path_server1() {
		return img_path_server1;
	}

	public void setImg_path_server1(String img_path_server1) {
		this.img_path_server1 = img_path_server1;
	}

	public String getImg_alt1() {
		return img_alt1;
	}

	public void setImg_alt1(String img_alt1) {
		this.img_alt1 = img_alt1;
	}

	public String getImg_link_url1() {
		return img_link_url1;
	}

	public void setImg_link_url1(String img_link_url1) {
		this.img_link_url1 = img_link_url1;
	}

	public String getTarget_type1() {
		return target_type1;
	}

	public void setTarget_type1(String target_type1) {
		this.target_type1 = target_type1;
	}

	public String getImg_title2() {
		return img_title2;
	}

	public void setImg_title2(String img_title2) {
		this.img_title2 = img_title2;
	}

	public String getImg_path_local2() {
		return img_path_local2;
	}

	public void setImg_path_local2(String img_path_local2) {
		this.img_path_local2 = img_path_local2;
	}

	public String getImg_path_server2() {
		return img_path_server2;
	}

	public void setImg_path_server2(String img_path_server2) {
		this.img_path_server2 = img_path_server2;
	}

	public String getImg_alt2() {
		return img_alt2;
	}

	public void setImg_alt2(String img_alt2) {
		this.img_alt2 = img_alt2;
	}

	public String getImg_link_url2() {
		return img_link_url2;
	}

	public void setImg_link_url2(String img_link_url2) {
		this.img_link_url2 = img_link_url2;
	}

	public String getTarget_type2() {
		return target_type2;
	}

	public void setTarget_type2(String target_type2) {
		this.target_type2 = target_type2;
	}

	public String getImg_title3() {
		return img_title3;
	}

	public void setImg_title3(String img_title3) {
		this.img_title3 = img_title3;
	}

	public String getImg_path_local3() {
		return img_path_local3;
	}

	public void setImg_path_local3(String img_path_local3) {
		this.img_path_local3 = img_path_local3;
	}

	public String getImg_path_server3() {
		return img_path_server3;
	}

	public void setImg_path_server3(String img_path_server3) {
		this.img_path_server3 = img_path_server3;
	}

	public String getImg_alt3() {
		return img_alt3;
	}

	public void setImg_alt3(String img_alt3) {
		this.img_alt3 = img_alt3;
	}

	public String getImg_link_url3() {
		return img_link_url3;
	}

	public void setImg_link_url3(String img_link_url3) {
		this.img_link_url3 = img_link_url3;
	}

	public String getTarget_type3() {
		return target_type3;
	}

	public void setTarget_type3(String target_type3) {
		this.target_type3 = target_type3;
	}

	public String getArea_info_type_cd() {
		return area_info_type_cd;
	}

	public void setArea_info_type_cd(String area_info_type_cd) {
		this.area_info_type_cd = area_info_type_cd;
	}

	public String getArea_info_seq() {
		return area_info_seq;
	}

	public void setArea_info_seq(String area_info_seq) {
		this.area_info_seq = area_info_seq;
	}

	public String getOp_cd() {
		return op_cd;
	}

	public void setOp_cd(String op_cd) {
		this.op_cd = op_cd;
	}

	public String getKnm() {
		return knm;
	}

	public void setKnm(String knm) {
		this.knm = knm;
	}

	public String getDetail_nm() {
		return detail_nm;
	}

	public void setDetail_nm(String detail_nm) {
		this.detail_nm = detail_nm;
	}

	public String getImg_path() {
		return img_path;
	}

	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}

	public String getImg_path_web() {
		return img_path_web;
	}

	public void setImg_path_web(String img_path_web) {
		this.img_path_web = img_path_web;
	}

	public String getImg_title() {
		return img_title;
	}

	public void setImg_title(String img_title) {
		this.img_title = img_title;
	}

	public String getInfo_desc() {
		return info_desc;
	}

	public void setInfo_desc(String info_desc) {
		this.info_desc = info_desc;
	}

	public String getHotel_reserve_type() {
		return hotel_reserve_type;
	}

	public void setHotel_reserve_type(String hotel_reserve_type) {
		this.hotel_reserve_type = hotel_reserve_type;
	}

	public String getEtc_text() {
		return etc_text;
	}

	public void setEtc_text(String etc_text) {
		this.etc_text = etc_text;
	}

	public String getBefore_day_pendency() {
		return before_day_pendency;
	}

	public void setBefore_day_pendency(String before_day_pendency) {
		this.before_day_pendency = before_day_pendency;
	}

	public String getNotify_type_pendency() {
		return notify_type_pendency;
	}

	public void setNotify_type_pendency(String notify_type_pendency) {
		this.notify_type_pendency = notify_type_pendency;
	}

	public String getBefore_day_schedule() {
		return before_day_schedule;
	}

	public void setBefore_day_schedule(String before_day_schedule) {
		this.before_day_schedule = before_day_schedule;
	}

	public String getNotify_type_schedule() {
		return notify_type_schedule;
	}

	public void setNotify_type_schedule(String notify_type_schedule) {
		this.notify_type_schedule = notify_type_schedule;
	}

	public String getOp_cd_confirm() {
		return op_cd_confirm;
	}

	public void setOp_cd_confirm(String op_cd_confirm) {
		this.op_cd_confirm = op_cd_confirm;
	}

	public String getCity_cd_confirm() {
		return city_cd_confirm;
	}

	public void setCity_cd_confirm(String city_cd_confirm) {
		this.city_cd_confirm = city_cd_confirm;
	}

	public String getLodge_cd_confirm() {
		return lodge_cd_confirm;
	}

	public void setLodge_cd_confirm(String lodge_cd_confirm) {
		this.lodge_cd_confirm = lodge_cd_confirm;
	}

	public String getOp_cd1() {
		return op_cd1;
	}

	public void setOp_cd1(String op_cd1) {
		this.op_cd1 = op_cd1;
	}

	public String getCity_cd1() {
		return city_cd1;
	}

	public void setCity_cd1(String city_cd1) {
		this.city_cd1 = city_cd1;
	}

	public String getLodge_cd1() {
		return lodge_cd1;
	}

	public void setLodge_cd1(String lodge_cd1) {
		this.lodge_cd1 = lodge_cd1;
	}

	public String getOp_cd2() {
		return op_cd2;
	}

	public void setOp_cd2(String op_cd2) {
		this.op_cd2 = op_cd2;
	}

	public String getCity_cd2() {
		return city_cd2;
	}

	public void setCity_cd2(String city_cd2) {
		this.city_cd2 = city_cd2;
	}

	public String getLodge_cd2() {
		return lodge_cd2;
	}

	public void setLodge_cd2(String lodge_cd2) {
		this.lodge_cd2 = lodge_cd2;
	}

	public String getOp_cd3() {
		return op_cd3;
	}

	public void setOp_cd3(String op_cd3) {
		this.op_cd3 = op_cd3;
	}

	public String getCity_cd3() {
		return city_cd3;
	}

	public void setCity_cd3(String city_cd3) {
		this.city_cd3 = city_cd3;
	}

	public String getLodge_cd3() {
		return lodge_cd3;
	}

	public void setLodge_cd3(String lodge_cd3) {
		this.lodge_cd3 = lodge_cd3;
	}

	public String getOp_cd4() {
		return op_cd4;
	}

	public void setOp_cd4(String op_cd4) {
		this.op_cd4 = op_cd4;
	}

	public String getCity_cd4() {
		return city_cd4;
	}

	public void setCity_cd4(String city_cd4) {
		this.city_cd4 = city_cd4;
	}

	public String getLodge_cd4() {
		return lodge_cd4;
	}

	public void setLodge_cd4(String lodge_cd4) {
		this.lodge_cd4 = lodge_cd4;
	}

	public String getOp_cd5() {
		return op_cd5;
	}

	public void setOp_cd5(String op_cd5) {
		this.op_cd5 = op_cd5;
	}

	public String getCity_cd5() {
		return city_cd5;
	}

	public void setCity_cd5(String city_cd5) {
		this.city_cd5 = city_cd5;
	}

	public String getLodge_cd5() {
		return lodge_cd5;
	}

	public void setLodge_cd5(String lodge_cd5) {
		this.lodge_cd5 = lodge_cd5;
	}

	public String getHotel_enm_confirm() {
		return hotel_knm_confirm;
	}

	public void setHotel_knm_confirm(String hotel_knm_confirm) {
		this.hotel_knm_confirm = hotel_knm_confirm;
	}

	public String getHomepage_url_confirm() {
		return homepage_url_confirm;
	}

	public void setHomepage_url_confirm(String homepage_url_confirm) {
		this.homepage_url_confirm = homepage_url_confirm;
	}

	public String getHotel1_enm() {
		return hotel1_enm;
	}

	public void setHotel1_enm(String hotel1_enm) {
		this.hotel1_enm = hotel1_enm;
	}

	public String getHotel1_knm() {
		return hotel1_knm;
	}

	public void setHotel1_knm(String hotel1_knm) {
		this.hotel1_knm = hotel1_knm;
	}

	public String getHotel1_homepage_url() {
		return hotel1_homepage_url;
	}

	public void setHotel1_homepage_url(String hotel1_homepage_url) {
		this.hotel1_homepage_url = hotel1_homepage_url;
	}

	public String getHotel2_enm() {
		return hotel2_enm;
	}

	public void setHotel2_enm(String hotel2_enm) {
		this.hotel2_enm = hotel2_enm;
	}

	public String getHotel2_knm() {
		return hotel2_knm;
	}

	public void setHotel2_knm(String hotel2_knm) {
		this.hotel2_knm = hotel2_knm;
	}

	public String getHotel2_homepage_url() {
		return hotel2_homepage_url;
	}

	public void setHotel2_homepage_url(String hotel2_homepage_url) {
		this.hotel2_homepage_url = hotel2_homepage_url;
	}

	public String getHotel3_enm() {
		return hotel3_enm;
	}

	public void setHotel3_enm(String hotel3_enm) {
		this.hotel3_enm = hotel3_enm;
	}

	public String getHotel3_knm() {
		return hotel3_knm;
	}

	public void setHotel3_knm(String hotel3_knm) {
		this.hotel3_knm = hotel3_knm;
	}

	public String getHotel3_homepage_url() {
		return hotel3_homepage_url;
	}

	public void setHotel3_homepage_url(String hotel3_homepage_url) {
		this.hotel3_homepage_url = hotel3_homepage_url;
	}

	public String getHotel4_enm() {
		return hotel4_enm;
	}

	public void setHotel4_enm(String hotel4_enm) {
		this.hotel4_enm = hotel4_enm;
	}

	public String getHotel4_knm() {
		return hotel4_knm;
	}

	public void setHotel4_knm(String hotel4_knm) {
		this.hotel4_knm = hotel4_knm;
	}

	public String getHotel4_homepage_url() {
		return hotel4_homepage_url;
	}

	public void setHotel4_homepage_url(String hotel4_homepage_url) {
		this.hotel4_homepage_url = hotel4_homepage_url;
	}

	public String getHotel5_enm() {
		return hotel5_enm;
	}

	public void setHotel5_enm(String hotel5_enm) {
		this.hotel5_enm = hotel5_enm;
	}

	public String getHotel5_knm() {
		return hotel5_knm;
	}

	public void setHotel5_knm(String hotel5_knm) {
		this.hotel5_knm = hotel5_knm;
	}

	public String getHotel5_homepage_url() {
		return hotel5_homepage_url;
	}

	public void setHotel5_homepage_url(String hotel5_homepage_url) {
		this.hotel5_homepage_url = hotel5_homepage_url;
	}

	public String getHotel_grade_confirm() {
		return hotel_grade_confirm;
	}

	public void setHotel_grade_confirm(String hotel_grade_confirm) {
		this.hotel_grade_confirm = hotel_grade_confirm;
	}

	public String getHotel1_grade() {
		return hotel1_grade;
	}

	public void setHotel1_grade(String hotel1_grade) {
		this.hotel1_grade = hotel1_grade;
	}

	public String getHotel2_grade() {
		return hotel2_grade;
	}

	public void setHotel2_grade(String hotel2_grade) {
		this.hotel2_grade = hotel2_grade;
	}

	public String getHotel3_grade() {
		return hotel3_grade;
	}

	public void setHotel3_grade(String hotel3_grade) {
		this.hotel3_grade = hotel3_grade;
	}

	public String getHotel4_grade() {
		return hotel4_grade;
	}

	public void setHotel4_grade(String hotel4_grade) {
		this.hotel4_grade = hotel4_grade;
	}

	public String getHotel5_grade() {
		return hotel5_grade;
	}

	public void setHotel5_grade(String hotel5_grade) {
		this.hotel5_grade = hotel5_grade;
	}

	public String getBefore_day_pendency_name() {
		return before_day_pendency_name;
	}

	public void setBefore_day_pendency_name(String before_day_pendency_name) {
		this.before_day_pendency_name = before_day_pendency_name;
	}

	public String getNotify_type_pendency_name() {
		return notify_type_pendency_name;
	}

	public void setNotify_type_pendency_name(String notify_type_pendency_name) {
		this.notify_type_pendency_name = notify_type_pendency_name;
	}

	public String getBefore_day_schedule_name() {
		return before_day_schedule_name;
	}

	public void setBefore_day_schedule_name(String before_day_schedule_name) {
		this.before_day_schedule_name = before_day_schedule_name;
	}

	public String getNotify_type_schedule_name() {
		return notify_type_schedule_name;
	}

	public void setNotify_type_schedule_name(String notify_type_schedule_name) {
		this.notify_type_schedule_name = notify_type_schedule_name;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
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

	public String getOption_nm() {
		return option_nm;
	}

	public void setOption_nm(String option_nm) {
		this.option_nm = option_nm;
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

	public String getPlace_nm() {
		return place_nm;
	}

	public void setPlace_nm(String place_nm) {
		this.place_nm = place_nm;
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

	public String getPrice_info() {
		return price_info;
	}

	public void setPrice_info(String price_info) {
		this.price_info = price_info;
	}

	public String getInclude_desc() {
		return include_desc;
	}

	public void setInclude_desc(String include_desc) {
		this.include_desc = include_desc;
	}
	
	public void setOle(String ole) {
		this.ole = ole;
	}
	
	
	
}
