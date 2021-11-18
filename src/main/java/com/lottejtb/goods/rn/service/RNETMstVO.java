package com.lottejtb.goods.rn.service;

import com.lottejtb.comm.service.CommDefaultVO;
import com.lottejtb.util.Util;

/**
* 클래스명    :  행사 상품 마스터 DAO 
* @ClassDesc  :  행사 상품 마스터 DAO 
* @FileName   : RNETMstVO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2017.02.03 /  / 최초작성
*/

public class RNETMstVO extends CommDefaultVO {

	private static final long serialVersionUID = -8898036874904252040L;

	private String comp_cd = "";
	private String disp_nm = "";
	private int ev_day_cnt = 0;
	private int ev_night_cnt = 0;
	private String start_day = "";
	
	private String start_wday = "";
	private String start_time = "";
	private String start_pyun = "";
	private String end_day_fr = "";
	private String end_time_fr = "";
	
	private String end_day = "";
	private String end_wday = "";
	private String end_time = "";
	private String end_pyun = "";
	private String start_day_to = "";
	
	private String start_time_to = "";
	private String trff_cd = "";
	private String cd_nm = "";
	private String trff_cd_short = "";
	private int fee_seq = 0;
	private int adult_price = 0;
	
	private int child_price = 0;
	private int baby_price = 0;
	private String etc_price_title1 = "";
	private int etc_price1 = 0;
	private String etc_price_title2 = "";
	
	private int etc_price2 = 0;
	private String etc_price_title3 = "";
	private int etc_price3 = 0;
	private int ev_inwon = 0;
	private int min_inwon = 0;
	
	private String proc_cd = "";
	private String lock_unit = "";
	private int tc_cnt = 0;
	private String point_yn = "";
	private float point_rate = 0.0f;
	private int point_amt = 0;
	
	private String et_adm_cd = "";
	private int rv_cnt = 0;
	private String img_url = "";
	private String goods_tag_text = "";
	private String conf_yn = "";
	private String conf_land = "";
	
	private String conf_air = "";
	private String conf_insu = "";
	private String conf_hotel = "";
	private String goods_type_cd = "";
	private int emp_rate = 0;
	
	private String goods_join_cd = "";
	private String biz_insu_yn = "";
	private String pkg_insu_yn = "";
	private String guide_yn = "";
	private String desc_file_path = "";
	
	private String desc_file_nm = "";
	private String goods_cd = "";
	private String opt_desc = "";
	private String pro_desc = "";
	private String pro_desc2 = "";
	
	private int tot_amt1 = 0;
	private int tot_amt2 = 0;
	private int tot_amt3 = 0;

	private String min_yn = "";
	private String ctg = "";
	
	public int getTot_amt1() {
		return tot_amt1;
	}

	public void setTot_amt1(int tot_amt1) {
		this.tot_amt1 = tot_amt1;
	}

	public int getTot_amt2() {
		return tot_amt2;
	}

	public void setTot_amt2(int tot_amt2) {
		this.tot_amt2 = tot_amt2;
	}

	public int getTot_amt3() {
		return tot_amt3;
	}

	public void setTot_amt3(int tot_amt3) {
		this.tot_amt3 = tot_amt3;
	}

	public String event_cd = "";

	public String getComp_cd() {
		return comp_cd;
	}

	public void setComp_cd(String comp_cd) {
		this.comp_cd = comp_cd;
	}

	public String getDisp_nm() {
		return disp_nm;
	}

	public void setDisp_nm(String disp_nm) {
		this.disp_nm = disp_nm;
	}

	public int getEv_day_cnt() {
		return ev_day_cnt;
	}

	public void setEv_day_cnt(int ev_day_cnt) {
		this.ev_day_cnt = ev_day_cnt;
	}

	public int getEv_night_cnt() {
		return ev_night_cnt;
	}

	public void setEv_night_cnt(int ev_night_cnt) {
		this.ev_night_cnt = ev_night_cnt;
	}

	public String getStart_day() {
		return start_day;
	}

	public void setStart_day(String start_day) {
		this.start_day = start_day;
	}

	public String getStart_wday() {
		return start_wday;
	}

	public void setStart_wday(String start_wday) {
		this.start_wday = start_wday;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getStart_pyun() {
		return start_pyun;
	}

	public void setStart_pyun(String start_pyun) {
		this.start_pyun = start_pyun;
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

	public String getEnd_day() {
		return end_day;
	}

	public void setEnd_day(String end_day) {
		this.end_day = end_day;
	}

	public String getEnd_wday() {
		return end_wday;
	}

	public void setEnd_wday(String end_wday) {
		this.end_wday = end_wday;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public String getEnd_pyun() {
		return end_pyun;
	}

	public void setEnd_pyun(String end_pyun) {
		this.end_pyun = end_pyun;
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

	public String getTrff_cd() {
		return trff_cd;
	}

	public void setTrff_cd(String trff_cd) {
		this.trff_cd = trff_cd;
	}

	public String getCd_nm() {
		return cd_nm;
	}

	public void setCd_nm(String cd_nm) {
		this.cd_nm = cd_nm;
	}

	public String getTrff_cd_short() {
		return trff_cd_short;
	}

	public void setTrff_cd_short(String trff_cd_short) {
		this.trff_cd_short = trff_cd_short;
	}

	public int getFee_seq() {
		return fee_seq;
	}

	public void setFee_seq(int fee_seq) {
		this.fee_seq = fee_seq;
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

	public String getEtc_price_title1() {
		return etc_price_title1;
	}

	public void setEtc_price_title1(String etc_price_title1) {
		this.etc_price_title1 = etc_price_title1;
	}

	public int getEtc_price1() {
		return etc_price1;
	}

	public void setEtc_price1(int etc_price1) {
		this.etc_price1 = etc_price1;
	}

	public String getEtc_price_title2() {
		return etc_price_title2;
	}

	public void setEtc_price_title2(String etc_price_title2) {
		this.etc_price_title2 = etc_price_title2;
	}

	public int getEtc_price2() {
		return etc_price2;
	}

	public void setEtc_price2(int etc_price2) {
		this.etc_price2 = etc_price2;
	}

	public String getEtc_price_title3() {
		return etc_price_title3;
	}

	public void setEtc_price_title3(String etc_price_title3) {
		this.etc_price_title3 = etc_price_title3;
	}

	public int getEtc_price3() {
		return etc_price3;
	}

	public void setEtc_price3(int etc_price3) {
		this.etc_price3 = etc_price3;
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

	public String getProc_cd() {
		return proc_cd;
	}

	public void setProc_cd(String proc_cd) {
		this.proc_cd = proc_cd;
	}

	public String getLock_unit() {
		return lock_unit;
	}

	public void setLock_unit(String lock_unit) {
		this.lock_unit = lock_unit;
	}

	public int getTc_cnt() {
		return tc_cnt;
	}

	public void setTc_cnt(int tc_cnt) {
		this.tc_cnt = tc_cnt;
	}

	public float getPoint_rate() {
		return point_rate;
	}

	public void setPoint_rate(float point_rate) {
		this.point_rate = point_rate;
	}

	public int getPoint_amt() {
		return point_amt;
	}

	public void setPoint_amt(int point_amt) {
		this.point_amt = point_amt;
	}

	public String getEt_adm_cd() {
		return et_adm_cd;
	}

	public void setEt_adm_cd(String et_adm_cd) {
		this.et_adm_cd = et_adm_cd;
	}

	public int getRv_cnt() {
		return rv_cnt;
	}

	public void setRv_cnt(int rv_cnt) {
		this.rv_cnt = rv_cnt;
	}

	public String getImg_url() {
		return img_url;
	}

	public void setImg_url(String img_url) {
		this.img_url = img_url;
	}

	public String getGoods_tag_text() {
		return goods_tag_text;
	}

	public void setGoods_tag_text(String goods_tag_text) {
		this.goods_tag_text = goods_tag_text;
	}

	public String getConf_yn() {
		return conf_yn;
	}

	public void setConf_yn(String conf_yn) {
		this.conf_yn = conf_yn;
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

	public String getGoods_type_cd() {
		return goods_type_cd;
	}

	public void setGoods_type_cd(String goods_type_cd) {
		this.goods_type_cd = goods_type_cd;
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

	public String getDesc_file_path() {
		return desc_file_path;
	}

	public void setDesc_file_path(String desc_file_path) {
		this.desc_file_path = desc_file_path;
	}

	public String getDesc_file_nm() {
		return desc_file_nm;
	}

	public void setDesc_file_nm(String desc_file_nm) {
		this.desc_file_nm = desc_file_nm;
	}

	public String getGoods_cd() {
		return goods_cd;
	}

	public void setGoods_cd(String goods_cd) {
		this.goods_cd = goods_cd;
	}

	public String getOpt_desc() {
		return opt_desc;
	}

	public void setOpt_desc(String opt_desc) {
		this.opt_desc = opt_desc;
	}

	public String getPro_desc() {
		return pro_desc;
	}

	public void setPro_desc(String pro_desc) {
		this.pro_desc = Util.convertStringTotag(Util.strip_tags(pro_desc));
	}

	public String getEvent_cd() {
		return event_cd;
	}

	public void setEvent_cd(String event_cd) {
		this.event_cd = event_cd;
	}

	public String getPro_desc2() {
		return pro_desc2;
	}

	public void setPro_desc2(String pro_desc2) {
		this.pro_desc2 =  Util.convertStringTotag(Util.strip_tags(pro_desc2));
	}

	public String getPoint_yn() {
		return point_yn;
	}

	public void setPoint_yn(String point_yn) {
		this.point_yn = point_yn;
	}

	public String getMin_yn() {
		return min_yn;
	}

	public void setMin_yn(String min_yn) {
		this.min_yn = min_yn;
	}

	public String getCtg() {
		return ctg;
	}

	public void setCtg(String ctg) {
		this.ctg = ctg;
	}
	
	
}
