package com.lottejtb.goods.service;

import com.lottejtb.comm.service.CommDefaultVO;

public class EventMstVO extends CommDefaultVO  {
	
	private static final long serialVersionUID = 8534413245042987519L;

 	private int ctg_seq = 0;
 	private String goods_cd = "";
 	private String comp_cd = "";
 	private String goods_nm = "";
 	private String short_goods_nm = "";
 	
 	private String goods_desc = "";
 	private String trff_cls_cd = "";
 	private String cd_nm01 = "";
 	private int adult_price = 0;
 	private String et_days = "";
 	
 	private String img_path = "";
 	private String goods_tag = "";
 	private String img_title = "";
 	private String save_file_nm = "";
 	private int goods_day_cnt = 0;
 	
 	private int goods_night_cnt = 0;
 	private String ht_city_cd = "";
 	private String op_cd = "";
 	private String et_goods_id = "";
 	private String disp_yn = "";
 	
 	private String event_cd = "";
 	private String area_cd = "";
 	private String sub_area_cd = "";
 	private String goods_sub_cd = "";
 	private String start_cd = "";
 	
 	private String trff_cd = "";
 	private String trff_cd_short = "";
 	private String event_desc;
 	private String air_seat_cd = "";
 	private int air_seat_seq = 0;
 	
 	private String et_adm_cd = "";
 	private String etc_event_id = "";
 	private String event_nm = "";
 	private String disp_nm = "";
 	private int ev_night_cnt = 0;
 	
 	private int ev_day_cnt = 0;
 	private int fee_seq = 0;
 	private String via_yn = "";
 	private String start_day = "";
 	private String start_city = "";
 	
 	private String start_pyun = "";
 	private String start_time = "";
 	private String end_day_fr = "";
 	private String end_time_fr = "";
 	private int start_seat_cnt = 0;
 	
 	private String end_pyun = "";
 	private String end_day = "";
 	private String end_city = "";
 	private String start_day_to = "";
 	private String start_time_to = "";
 	
 	private String end_time = "";
 	private int tc_cnt = 0;
 	private int foc_cnt = 0;
 	private int ev_inwon = 0;
 	private int min_inwon = 0;
 	
 	private String crs_cd = "";
 	private String pnr_no = "";
 	private String insu_site_cd = "";
 	private String insu_target_cd = "";
 	private String lock_unit = "";
 	
 	private String event_memo = "";
 	private String seed_need_yn = "";
 	private String conf_yn = "";
 	private String agent_com = "";
 	private String site_com = "";
 	
 	private String tl_day = "";
 	private String proc_cd = "";
 	private String event_block = "";
 	private String country_cd = "";
 	private String city_cd = "";
 	
 	private String start_wday = "";
 	private String valid_term = "";
 	private String air_class = "";
 	private String conf_land = "";
 	private String conf_air = "";
 	
 	private String conf_insu = "";
 	private String conf_hotel = "";
 	private String grp_nm = "";
 	private String cha_id1 = "";
 	private String cha_id2 = "";
 	
 	private String cha_dept_cd1 = "";
 	private String cha_dept_cd2 = "";
 	private String air_id1 = "";
 	private String air_id2 = "";
 	private String insu_proc_yn = "";
 	private String insu_send_dt = "";
 	
 	private String insu_id = "";
 	private String early_res_dc_yn = "";
 	private String partner_dc_yn = "";
 	private int partner_base_cnt = 0;
 	private int partner_cd_rate = 0;
 	
 	private int partner_dc_amt = 0;
 	private String point_yn = "";
 	private String point_rate_amt_yn = "";
 	private int point_rate = 0;
 	private int point_amt = 0;
 	
 	private String ev_chg_yn = "";
 	private String rv_canc_yn = "";
 	private String rv_roster_add_yn = "";
 	private String rv_roster_chg_yn = "";
 	private String ins_dt = "";
 	
 	private String ins_id = "";
 	private String upd_dt = "";
 	private String upd_id = "";
 	private String ev_can_cd = "";
 	private String canc_id = "";
 	
 	private String canc_dt = "";
 	private String acc_yn = "";
 	private String close_fg = "";
 	private String acc_dt = "";
 	private int emp_rate = 0;
 	
 	private String goods_join_cd = "";
 	private String biz_insu_yn = "";
 	private String pkg_insu_yn = "";
 	private String guide_yn = "";
 	private String agent_memo = "";
 	
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
	public String getShort_goods_nm() {
		return short_goods_nm;
	}
	public void setShort_goods_nm(String short_goods_nm) {
		this.short_goods_nm = short_goods_nm;
	}
	public String getGoods_desc() {
		return goods_desc;
	}
	public void setGoods_desc(String goods_desc) {
		this.goods_desc = goods_desc;
	}
	public String getTrff_cls_cd() {
		return trff_cls_cd;
	}
	public void setTrff_cls_cd(String trff_cls_cd) {
		this.trff_cls_cd = trff_cls_cd;
	}
	public String getCd_nm01() {
		return cd_nm01;
	}
	public void setCd_nm01(String cd_nm01) {
		this.cd_nm01 = cd_nm01;
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
	public String getImg_path() {
		return img_path;
	}
	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}
	public String getGoods_tag() {
		return goods_tag;
	}
	public void setGoods_tag(String goods_tag) {
		this.goods_tag = goods_tag;
	}
	public String getImg_title() {
		return img_title;
	}
	public void setImg_title(String img_title) {
		this.img_title = img_title;
	}
	public String getSave_file_nm() {
		return save_file_nm;
	}
	public void setSave_file_nm(String save_file_nm) {
		this.save_file_nm = save_file_nm;
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
	public String getHt_city_cd() {
		return ht_city_cd;
	}
	public void setHt_city_cd(String ht_city_cd) {
		this.ht_city_cd = ht_city_cd;
	}
	public String getOp_cd() {
		return op_cd;
	}
	public void setOp_cd(String op_cd) {
		this.op_cd = op_cd;
	}
	public String getEt_goods_id() {
		return et_goods_id;
	}
	public void setEt_goods_id(String et_goods_id) {
		this.et_goods_id = et_goods_id;
	}
	public String getDisp_yn() {
		return disp_yn;
	}
	public void setDisp_yn(String disp_yn) {
		this.disp_yn = disp_yn;
	}
	public String getEvent_cd() {
		return event_cd;
	}
	public void setEvent_cd(String event_cd) {
		this.event_cd = event_cd;
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
	public String getTrff_cd() {
		return trff_cd;
	}
	public void setTrff_cd(String trff_cd) {
		this.trff_cd = trff_cd;
	}
	public String getTrff_cd_short() {
		return trff_cd_short;
	}
	public void setTrff_cd_short(String trff_cd_short) {
		this.trff_cd_short = trff_cd_short;
	}
	public String getEvent_desc() {
		return event_desc;
	}
	public void setEvent_desc(String event_desc) {
		this.event_desc = event_desc;
	}
	public String getAir_seat_cd() {
		return air_seat_cd;
	}
	public void setAir_seat_cd(String air_seat_cd) {
		this.air_seat_cd = air_seat_cd;
	}
	public int getAir_seat_seq() {
		return air_seat_seq;
	}
	public void setAir_seat_seq(int air_seat_seq) {
		this.air_seat_seq = air_seat_seq;
	}
	public String getEt_adm_cd() {
		return et_adm_cd;
	}
	public void setEt_adm_cd(String et_adm_cd) {
		this.et_adm_cd = et_adm_cd;
	}
	public String getEtc_event_id() {
		return etc_event_id;
	}
	public void setEtc_event_id(String etc_event_id) {
		this.etc_event_id = etc_event_id;
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
	public int getEv_night_cnt() {
		return ev_night_cnt;
	}
	public void setEv_night_cnt(int ev_night_cnt) {
		this.ev_night_cnt = ev_night_cnt;
	}
	public int getEv_day_cnt() {
		return ev_day_cnt;
	}
	public void setEv_day_cnt(int ev_day_cnt) {
		this.ev_day_cnt = ev_day_cnt;
	}
	public int getFee_seq() {
		return fee_seq;
	}
	public void setFee_seq(int fee_seq) {
		this.fee_seq = fee_seq;
	}
	public String getVia_yn() {
		return via_yn;
	}
	public void setVia_yn(String via_yn) {
		this.via_yn = via_yn;
	}
	public String getStart_day() {
		return start_day;
	}
	public void setStart_day(String start_day) {
		this.start_day = start_day;
	}
	public String getStart_city() {
		return start_city;
	}
	public void setStart_city(String start_city) {
		this.start_city = start_city;
	}
	public String getStart_pyun() {
		return start_pyun;
	}
	public void setStart_pyun(String start_pyun) {
		this.start_pyun = start_pyun;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_day_fr() {
		return end_day_fr;
	}
	public void setEnd_day_fr(String end_day_fr) {
		this.end_day_fr = end_day_fr;
	}
	public String getEnd_time_fr() {
		return end_time_fr;
	}
	public void setEnd_time_fr(String end_time_fr) {
		this.end_time_fr = end_time_fr;
	}
	public int getStart_seat_cnt() {
		return start_seat_cnt;
	}
	public void setStart_seat_cnt(int start_seat_cnt) {
		this.start_seat_cnt = start_seat_cnt;
	}
	public String getEnd_pyun() {
		return end_pyun;
	}
	public void setEnd_pyun(String end_pyun) {
		this.end_pyun = end_pyun;
	}
	public String getEnd_day() {
		return end_day;
	}
	public void setEnd_day(String end_day) {
		this.end_day = end_day;
	}
	public String getEnd_city() {
		return end_city;
	}
	public void setEnd_city(String end_city) {
		this.end_city = end_city;
	}
	public String getStart_day_to() {
		return start_day_to;
	}
	public void setStart_day_to(String start_day_to) {
		this.start_day_to = start_day_to;
	}
	public String getStart_time_to() {
		return start_time_to;
	}
	public void setStart_time_to(String start_time_to) {
		this.start_time_to = start_time_to;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public int getTc_cnt() {
		return tc_cnt;
	}
	public void setTc_cnt(int tc_cnt) {
		this.tc_cnt = tc_cnt;
	}
	public int getFoc_cnt() {
		return foc_cnt;
	}
	public void setFoc_cnt(int foc_cnt) {
		this.foc_cnt = foc_cnt;
	}
	public int getEv_inwon() {
		return ev_inwon;
	}
	public void setEv_inwon(int ev_inwon) {
		this.ev_inwon = ev_inwon;
	}
	public int getMin_inwon() {
		return min_inwon;
	}
	public void setMin_inwon(int min_inwon) {
		this.min_inwon = min_inwon;
	}
	public String getCrs_cd() {
		return crs_cd;
	}
	public void setCrs_cd(String crs_cd) {
		this.crs_cd = crs_cd;
	}
	public String getPnr_no() {
		return pnr_no;
	}
	public void setPnr_no(String pnr_no) {
		this.pnr_no = pnr_no;
	}
	public String getInsu_site_cd() {
		return insu_site_cd;
	}
	public void setInsu_site_cd(String insu_site_cd) {
		this.insu_site_cd = insu_site_cd;
	}
	public String getInsu_target_cd() {
		return insu_target_cd;
	}
	public void setInsu_target_cd(String insu_target_cd) {
		this.insu_target_cd = insu_target_cd;
	}
	public String getLock_unit() {
		return lock_unit;
	}
	public void setLock_unit(String lock_unit) {
		this.lock_unit = lock_unit;
	}
	public String getEvent_memo() {
		return event_memo;
	}
	public void setEvent_memo(String event_memo) {
		this.event_memo = event_memo;
	}
	public String getSeed_need_yn() {
		return seed_need_yn;
	}
	public void setSeed_need_yn(String seed_need_yn) {
		this.seed_need_yn = seed_need_yn;
	}
	public String getConf_yn() {
		return conf_yn;
	}
	public void setConf_yn(String conf_yn) {
		this.conf_yn = conf_yn;
	}
	public String getAgent_com() {
		return agent_com;
	}
	public void setAgent_com(String agent_com) {
		this.agent_com = agent_com;
	}
	public String getSite_com() {
		return site_com;
	}
	public void setSite_com(String site_com) {
		this.site_com = site_com;
	}
	public String getTl_day() {
		return tl_day;
	}
	public void setTl_day(String tl_day) {
		this.tl_day = tl_day;
	}
	public String getProc_cd() {
		return proc_cd;
	}
	public void setProc_cd(String proc_cd) {
		this.proc_cd = proc_cd;
	}
	public String getEvent_block() {
		return event_block;
	}
	public void setEvent_block(String event_block) {
		this.event_block = event_block;
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
	public String getStart_wday() {
		return start_wday;
	}
	public void setStart_wday(String start_wday) {
		this.start_wday = start_wday;
	}
	public String getValid_term() {
		return valid_term;
	}
	public void setValid_term(String valid_term) {
		this.valid_term = valid_term;
	}
	public String getAir_class() {
		return air_class;
	}
	public void setAir_class(String air_class) {
		this.air_class = air_class;
	}
	public String getConf_land() {
		return conf_land;
	}
	public void setConf_land(String conf_land) {
		this.conf_land = conf_land;
	}
	public String getConf_air() {
		return conf_air;
	}
	public void setConf_air(String conf_air) {
		this.conf_air = conf_air;
	}
	public String getConf_insu() {
		return conf_insu;
	}
	public void setConf_insu(String conf_insu) {
		this.conf_insu = conf_insu;
	}
	public String getConf_hotel() {
		return conf_hotel;
	}
	public void setConf_hotel(String conf_hotel) {
		this.conf_hotel = conf_hotel;
	}
	public String getGrp_nm() {
		return grp_nm;
	}
	public void setGrp_nm(String grp_nm) {
		this.grp_nm = grp_nm;
	}
	public String getCha_id1() {
		return cha_id1;
	}
	public void setCha_id1(String cha_id1) {
		this.cha_id1 = cha_id1;
	}
	public String getCha_id2() {
		return cha_id2;
	}
	public void setCha_id2(String cha_id2) {
		this.cha_id2 = cha_id2;
	}
	public String getCha_dept_cd1() {
		return cha_dept_cd1;
	}
	public void setCha_dept_cd1(String cha_dept_cd1) {
		this.cha_dept_cd1 = cha_dept_cd1;
	}
	public String getCha_dept_cd2() {
		return cha_dept_cd2;
	}
	public void setCha_dept_cd2(String cha_dept_cd2) {
		this.cha_dept_cd2 = cha_dept_cd2;
	}
	public String getAir_id1() {
		return air_id1;
	}
	public void setAir_id1(String air_id1) {
		this.air_id1 = air_id1;
	}
	public String getAir_id2() {
		return air_id2;
	}
	public void setAir_id2(String air_id2) {
		this.air_id2 = air_id2;
	}
	public String getInsu_proc_yn() {
		return insu_proc_yn;
	}
	public void setInsu_proc_yn(String insu_proc_yn) {
		this.insu_proc_yn = insu_proc_yn;
	}
	public String getInsu_send_dt() {
		return insu_send_dt;
	}
	public void setInsu_send_dt(String insu_send_dt) {
		this.insu_send_dt = insu_send_dt;
	}
	public String getInsu_id() {
		return insu_id;
	}
	public void setInsu_id(String insu_id) {
		this.insu_id = insu_id;
	}
	public String getEarly_res_dc_yn() {
		return early_res_dc_yn;
	}
	public void setEarly_res_dc_yn(String early_res_dc_yn) {
		this.early_res_dc_yn = early_res_dc_yn;
	}
	public String getPartner_dc_yn() {
		return partner_dc_yn;
	}
	public void setPartner_dc_yn(String partner_dc_yn) {
		this.partner_dc_yn = partner_dc_yn;
	}
	public int getPartner_base_cnt() {
		return partner_base_cnt;
	}
	public void setPartner_base_cnt(int partner_base_cnt) {
		this.partner_base_cnt = partner_base_cnt;
	}
	public int getPartner_cd_rate() {
		return partner_cd_rate;
	}
	public void setPartner_cd_rate(int partner_cd_rate) {
		this.partner_cd_rate = partner_cd_rate;
	}
	public int getPartner_dc_amt() {
		return partner_dc_amt;
	}
	public void setPartner_dc_amt(int partner_dc_amt) {
		this.partner_dc_amt = partner_dc_amt;
	}
	public String getPoint_yn() {
		return point_yn;
	}
	public void setPoint_yn(String point_yn) {
		this.point_yn = point_yn;
	}
	public String getPoint_rate_amt_yn() {
		return point_rate_amt_yn;
	}
	public void setPoint_rate_amt_yn(String point_rate_amt_yn) {
		this.point_rate_amt_yn = point_rate_amt_yn;
	}
	public int getPoint_rate() {
		return point_rate;
	}
	public void setPoint_rate(int point_rate) {
		this.point_rate = point_rate;
	}
	public int getPoint_amt() {
		return point_amt;
	}
	public void setPoint_amt(int point_amt) {
		this.point_amt = point_amt;
	}
	public String getEv_chg_yn() {
		return ev_chg_yn;
	}
	public void setEv_chg_yn(String ev_chg_yn) {
		this.ev_chg_yn = ev_chg_yn;
	}
	public String getRv_canc_yn() {
		return rv_canc_yn;
	}
	public void setRv_canc_yn(String rv_canc_yn) {
		this.rv_canc_yn = rv_canc_yn;
	}
	public String getRv_roster_add_yn() {
		return rv_roster_add_yn;
	}
	public void setRv_roster_add_yn(String rv_roster_add_yn) {
		this.rv_roster_add_yn = rv_roster_add_yn;
	}
	public String getRv_roster_chg_yn() {
		return rv_roster_chg_yn;
	}
	public void setRv_roster_chg_yn(String rv_roster_chg_yn) {
		this.rv_roster_chg_yn = rv_roster_chg_yn;
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
	public String getEv_can_cd() {
		return ev_can_cd;
	}
	public void setEv_can_cd(String ev_can_cd) {
		this.ev_can_cd = ev_can_cd;
	}
	public String getCanc_id() {
		return canc_id;
	}
	public void setCanc_id(String canc_id) {
		this.canc_id = canc_id;
	}
	public String getCanc_dt() {
		return canc_dt;
	}
	public void setCanc_dt(String canc_dt) {
		this.canc_dt = canc_dt;
	}
	public String getAcc_yn() {
		return acc_yn;
	}
	public void setAcc_yn(String acc_yn) {
		this.acc_yn = acc_yn;
	}
	public String getClose_fg() {
		return close_fg;
	}
	public void setClose_fg(String close_fg) {
		this.close_fg = close_fg;
	}
	public String getAcc_dt() {
		return acc_dt;
	}
	public void setAcc_dt(String acc_dt) {
		this.acc_dt = acc_dt;
	}
	public int getEmp_rate() {
		return emp_rate;
	}
	public void setEmp_rate(int emp_rate) {
		this.emp_rate = emp_rate;
	}
	public String getGoods_join_cd() {
		return goods_join_cd;
	}
	public void setGoods_join_cd(String goods_join_cd) {
		this.goods_join_cd = goods_join_cd;
	}
	public String getBiz_insu_yn() {
		return biz_insu_yn;
	}
	public void setBiz_insu_yn(String biz_insu_yn) {
		this.biz_insu_yn = biz_insu_yn;
	}
	public String getPkg_insu_yn() {
		return pkg_insu_yn;
	}
	public void setPkg_insu_yn(String pkg_insu_yn) {
		this.pkg_insu_yn = pkg_insu_yn;
	}
	public String getGuide_yn() {
		return guide_yn;
	}
	public void setGuide_yn(String guide_yn) {
		this.guide_yn = guide_yn;
	}
	public String getAgent_memo() {
		return agent_memo;
	}
	public void setAgent_memo(String agent_memo) {
		this.agent_memo = agent_memo;
	}
 	
 	
}
