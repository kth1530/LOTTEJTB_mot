package com.lottejtb.goods.service;

import com.lottejtb.comm.service.CommDefaultVO;

public class ConsultVO extends CommDefaultVO {
	private static final long serialVersionUID = -9093767875981646945L;
	private String ctg = "";
	private String disp_nm = "";
	
	private String consult_cd = "";
	private String next_consult_day = "";
	private String area_cd = "";
	private String sub_area_cd = "";
	private String consult_title = "";
	
	private String consult_type_cd = "";
	private String event_cd = "";
	private String res_cd = "";
	private String cust_cd = "";
	private String res_nm = "";
	
	private int age = 0;
	private String sex = "";
	private String grp_spec_cd = "";
	private String tour_plan_cd = "";
	private String site_cd = "";
	
	private String site_cha_nm = "";
	private String grp_nm = "";
	private String country_cd = "";
	private String city_cd = "";
	private String start_day = "";
	
	private String start_time = "";
	private String end_day = "";
	private int ev_day_cnt = 0;
	private int adult_cnt = 0;
	private int child_cnt = 0;
	
	private int baby_cnt = 0;
	private String tc_yn = "";
	private int tc_cnt = 0;
	private String hotel_grade = "";
	private String air_cd_short = "";
	
	private String cont_day = "";
	private String cha_id = "";
	private String tour_area = "";
	private String fax = "";
	private String email = "";
	
	private String email1 = "";
	private String email2 = "";
	
	private String email_yn = "";
	private String sms_yn = "";
	private String channel_cd = "";
	private String title_yn = "";
	private String desc_yn = "";
	private String phone_fg = "";
	
	private String handphone1 = "";
	private String handphone2 = "";
	private String handphone3 = "";
	private String tel1 = "";
	private String tel2 = "";
	
	private String tel3 = "";
	private String comp_tel1 = "";
	private String comp_tel2 = "";
	private String comp_tel3 = "";
	private String cha_dept_cd = "";
	
	private String cha_site_cd = "";
	private String sale_id = "";
	private String sale_dept_cd = "";
	private String grp_detail_cd = "";
	private int adult_price = 0;
	
	private int child_price = 0;
	private int baby_price = 0;
	private String join_cust_type_cd = "";
	private String join_offline = "";
	private String join_online = "";
	
	private String floor_yn = "";
	private String trip_yn = "";
	private String join_etc = "";
	private String remark = "";
	
	private int view_cnt = 0;
	private String ins_dt = "";
	private String ins_id = "";
	private String ins_dept_cd = "";
	private String ins_site_cd = "";
	
	private String upd_dt = "";
	private String upd_id = "";
	private String canc_cd = "";
	private String canc_dt = "";
	private String canc_id = "";
	
	private String comp_cd = "";
	private String inc_fg = "";
	private String consult_mst_cd = "";
	private String proc_cd = "";
	private String goods_cd = "";
	
	
	
	public String getEmail1() {
		return email1;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	public String getEmail2() {
		return email2;
	}

	public void setEmail2(String email2) {
		this.email2 = email2;
	}

	public String getCtg() {
		return ctg;
	}

	public void setCtg(String ctg) {
		this.ctg = ctg;
	}

	public String getDisp_nm() {
		return disp_nm;
	}

	public void setDisp_nm(String disp_nm) {
		this.disp_nm = disp_nm;
	}

	public String getGoods_cd() {
		return goods_cd;
	}

	public void setGoods_cd(String goods_cd) {
		this.goods_cd = goods_cd;
	}

	public String getProc_cd() {
		return proc_cd;
	}

	public void setProc_cd(String proc_cd) {
		this.proc_cd = proc_cd;
	}

	public String getConsult_mst_cd() {
		return consult_mst_cd;
	}

	public void setConsult_mst_cd(String consult_mst_cd) {
		this.consult_mst_cd = consult_mst_cd;
	}

	public String getInc_fg() {
		return inc_fg;
	}

	public void setInc_fg(String inc_fg) {
		this.inc_fg = inc_fg;
	}

	public String getConsult_cd() {
		return consult_cd;
	}

	public void setConsult_cd(String consult_cd) {
		this.consult_cd = consult_cd;
	}

	public String getNext_consult_day() {
		return next_consult_day;
	}

	public void setNext_consult_day(String next_consult_day) {
		this.next_consult_day = next_consult_day;
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

	public String getConsult_title() {
		return consult_title;
	}

	public void setConsult_title(String consult_title) {
		this.consult_title = consult_title;
	}

	public String getConsult_type_cd() {
		return consult_type_cd;
	}

	public void setConsult_type_cd(String consult_type_cd) {
		this.consult_type_cd = consult_type_cd;
	}

	public String getEvent_cd() {
		return event_cd;
	}

	public void setEvent_cd(String event_cd) {
		this.event_cd = event_cd;
	}

	public String getRes_cd() {
		return res_cd;
	}

	public void setRes_cd(String res_cd) {
		this.res_cd = res_cd;
	}

	public String getCust_cd() {
		return cust_cd;
	}

	public void setCust_cd(String cust_cd) {
		this.cust_cd = cust_cd;
	}

	public String getRes_nm() {
		return res_nm;
	}

	public void setRes_nm(String res_nm) {
		this.res_nm = res_nm;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getGrp_spec_cd() {
		return grp_spec_cd;
	}

	public void setGrp_spec_cd(String grp_spec_cd) {
		this.grp_spec_cd = grp_spec_cd;
	}

	public String getTour_plan_cd() {
		return tour_plan_cd;
	}

	public void setTour_plan_cd(String tour_plan_cd) {
		this.tour_plan_cd = tour_plan_cd;
	}

	public String getSite_cd() {
		return site_cd;
	}

	public void setSite_cd(String site_cd) {
		this.site_cd = site_cd;
	}

	public String getSite_cha_nm() {
		return site_cha_nm;
	}

	public void setSite_cha_nm(String site_cha_nm) {
		this.site_cha_nm = site_cha_nm;
	}

	public String getGrp_nm() {
		return grp_nm;
	}

	public void setGrp_nm(String grp_nm) {
		this.grp_nm = grp_nm;
	}

	public String getCountry_cd() {
		return country_cd;
	}

	public void setCountry_cd(String country_cd) {
		this.country_cd = country_cd;
	}

	public String getCity_cd() {
		return city_cd;
	}

	public void setCity_cd(String city_cd) {
		this.city_cd = city_cd;
	}

	public String getStart_day() {
		return start_day;
	}

	public void setStart_day(String start_day) {
		this.start_day = start_day;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_day() {
		return end_day;
	}

	public void setEnd_day(String end_day) {
		this.end_day = end_day;
	}

	public int getEv_day_cnt() {
		return ev_day_cnt;
	}

	public void setEv_day_cnt(int ev_day_cnt) {
		this.ev_day_cnt = ev_day_cnt;
	}

	public int getAdult_cnt() {
		return adult_cnt;
	}

	public void setAdult_cnt(int adult_cnt) {
		this.adult_cnt = adult_cnt;
	}

	public int getChild_cnt() {
		return child_cnt;
	}

	public void setChild_cnt(int child_cnt) {
		this.child_cnt = child_cnt;
	}

	public int getBaby_cnt() {
		return baby_cnt;
	}

	public void setBaby_cnt(int baby_cnt) {
		this.baby_cnt = baby_cnt;
	}

	public String getTc_yn() {
		return tc_yn;
	}

	public void setTc_yn(String tc_yn) {
		this.tc_yn = tc_yn;
	}

	public int getTc_cnt() {
		return tc_cnt;
	}

	public void setTc_cnt(int tc_cnt) {
		this.tc_cnt = tc_cnt;
	}

	public String getHotel_grade() {
		return hotel_grade;
	}

	public void setHotel_grade(String hotel_grade) {
		this.hotel_grade = hotel_grade;
	}

	public String getAir_cd_short() {
		return air_cd_short;
	}

	public void setAir_cd_short(String air_cd_short) {
		this.air_cd_short = air_cd_short;
	}

	public String getCont_day() {
		return cont_day;
	}

	public void setCont_day(String cont_day) {
		this.cont_day = cont_day;
	}

	public String getCha_id() {
		return cha_id;
	}

	public void setCha_id(String cha_id) {
		this.cha_id = cha_id;
	}

	public String getTour_area() {
		return tour_area;
	}

	public void setTour_area(String tour_area) {
		this.tour_area = tour_area;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail_yn() {
		return email_yn;
	}

	public void setEmail_yn(String email_yn) {
		this.email_yn = email_yn;
	}

	public String getSms_yn() {
		return sms_yn;
	}

	public void setSms_yn(String sms_yn) {
		this.sms_yn = sms_yn;
	}

	public String getChannel_cd() {
		return channel_cd;
	}

	public void setChannel_cd(String channel_cd) {
		this.channel_cd = channel_cd;
	}

	public String getTitle_yn() {
		return title_yn;
	}

	public void setTitle_yn(String title_yn) {
		this.title_yn = title_yn;
	}

	public String getDesc_yn() {
		return desc_yn;
	}

	public void setDesc_yn(String desc_yn) {
		this.desc_yn = desc_yn;
	}

	public String getPhone_fg() {
		return phone_fg;
	}

	public void setPhone_fg(String phone_fg) {
		this.phone_fg = phone_fg;
	}

	public String getHandphone1() {
		return handphone1;
	}

	public void setHandphone1(String handphone1) {
		this.handphone1 = handphone1;
	}

	public String getHandphone2() {
		return handphone2;
	}

	public void setHandphone2(String handphone2) {
		this.handphone2 = handphone2;
	}

	public String getHandphone3() {
		return handphone3;
	}

	public void setHandphone3(String handphone3) {
		this.handphone3 = handphone3;
	}

	public String getTel1() {
		return tel1;
	}

	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}

	public String getTel2() {
		return tel2;
	}

	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}

	public String getTel3() {
		return tel3;
	}

	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}

	public String getComp_tel1() {
		return comp_tel1;
	}

	public void setComp_tel1(String comp_tel1) {
		this.comp_tel1 = comp_tel1;
	}

	public String getComp_tel2() {
		return comp_tel2;
	}

	public void setComp_tel2(String comp_tel2) {
		this.comp_tel2 = comp_tel2;
	}

	public String getComp_tel3() {
		return comp_tel3;
	}

	public void setComp_tel3(String comp_tel3) {
		this.comp_tel3 = comp_tel3;
	}

	public String getCha_dept_cd() {
		return cha_dept_cd;
	}

	public void setCha_dept_cd(String cha_dept_cd) {
		this.cha_dept_cd = cha_dept_cd;
	}

	public String getCha_site_cd() {
		return cha_site_cd;
	}

	public void setCha_site_cd(String cha_site_cd) {
		this.cha_site_cd = cha_site_cd;
	}

	public String getSale_id() {
		return sale_id;
	}

	public void setSale_id(String sale_id) {
		this.sale_id = sale_id;
	}

	public String getSale_dept_cd() {
		return sale_dept_cd;
	}

	public void setSale_dept_cd(String sale_dept_cd) {
		this.sale_dept_cd = sale_dept_cd;
	}

	public String getGrp_detail_cd() {
		return grp_detail_cd;
	}

	public void setGrp_detail_cd(String grp_detail_cd) {
		this.grp_detail_cd = grp_detail_cd;
	}

	public int getAdult_price() {
		return adult_price;
	}

	public void setAdult_price(int adult_price) {
		this.adult_price = adult_price;
	}

	public int getChild_price() {
		return child_price;
	}

	public void setChild_price(int child_price) {
		this.child_price = child_price;
	}

	public int getBaby_price() {
		return baby_price;
	}

	public void setBaby_price(int baby_price) {
		this.baby_price = baby_price;
	}

	public String getJoin_cust_type_cd() {
		return join_cust_type_cd;
	}

	public void setJoin_cust_type_cd(String join_cust_type_cd) {
		this.join_cust_type_cd = join_cust_type_cd;
	}

	public String getJoin_offline() {
		return join_offline;
	}

	public void setJoin_offline(String join_offline) {
		this.join_offline = join_offline;
	}

	public String getJoin_online() {
		return join_online;
	}

	public void setJoin_online(String join_online) {
		this.join_online = join_online;
	}

	public String getFloor_yn() {
		return floor_yn;
	}

	public void setFloor_yn(String floor_yn) {
		this.floor_yn = floor_yn;
	}

	public String getTrip_yn() {
		return trip_yn;
	}

	public void setTrip_yn(String trip_yn) {
		this.trip_yn = trip_yn;
	}

	public String getJoin_etc() {
		return join_etc;
	}

	public void setJoin_etc(String join_etc) {
		this.join_etc = join_etc;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public int getView_cnt() {
		return view_cnt;
	}

	public void setView_cnt(int view_cnt) {
		this.view_cnt = view_cnt;
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

	public String getIns_dept_cd() {
		return ins_dept_cd;
	}

	public void setIns_dept_cd(String ins_dept_cd) {
		this.ins_dept_cd = ins_dept_cd;
	}

	public String getIns_site_cd() {
		return ins_site_cd;
	}

	public void setIns_site_cd(String ins_site_cd) {
		this.ins_site_cd = ins_site_cd;
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

	public String getCanc_cd() {
		return canc_cd;
	}

	public void setCanc_cd(String canc_cd) {
		this.canc_cd = canc_cd;
	}

	public String getCanc_dt() {
		return canc_dt;
	}

	public void setCanc_dt(String canc_dt) {
		this.canc_dt = canc_dt;
	}

	public String getCanc_id() {
		return canc_id;
	}

	public void setCanc_id(String canc_id) {
		this.canc_id = canc_id;
	}

	public String getComp_cd() {
		return comp_cd;
	}

	public void setComp_cd(String comp_cd) {
		this.comp_cd = comp_cd;
	}
	
	
}
