package com.lottejtb.reserve.service;

import com.lottejtb.comm.service.CommDefaultVO;


/**
* 클래스명    : 예약 인원 정보를 담고 있는 클래스 
* @ClassDesc  : 예약  인원 정보를 담고 있는 클래스 
* @FileName   : ReserveRosterVO.java
* @TableName  : t4dev/RV_MST
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.28 /  / 최초작성
*/

public class ReserveRosterVO extends CommDefaultVO {

	private static final long serialVersionUID = 8987361134173994489L;
	
	private String res_cd = "";
	private int res_seq = 0;
	private String res_day = "";
	private String etc_res_cd = "";
	private String nm_kor = "";
	
	private String enm_last = "";
	private String enm_first = "";
	private String jmno = "";
	private String sex = "";
	private String age_cd = "";
	
	private String roster_title = "";
	private String cust_cd = "";
	private String zip_cd= "";
	private String addr1= "";
	private String addr2 = "";
	private String phone_type = "";
	
	private String tel1 = "";
	private String tel2 = "";
	private String tel3 = "";
	private String handphone1 = "";
	private String handphone2 = "";
	
	private String handphone3 = "";
	private String email = "";
	private String pp_yn = "";
	private String pp_nat_cd = "";
	private String pp_no = "";
	
	private String pp_termi_day = "";
	private String visa_yn = "";
	private String visa_no = "";
	private String visa_termi_day = "";
	private String conn_yn = "";
	
	private String air_remark = "";
	private String land_remark = "";
	private String remark = "";
	private String pp_remark = "";
	private String visa_info = "";
	
	private String air_card_cd = "";
	private String air_card_no = "";
	private String apis_no = "";
	private String apis_crs = "";
	private String apis_remark = "";
	
	private String contract_send_yn = "";
	private String send_dt = "";
	private String contract_accept_yn = "";
	private String accept_dt = "";
	private int res_team_no = 0;
	
	private int res_room_seq = 0;
	private String parlor_cd = "";
	private String singel_yn = "";
	private int insu_price = 0;
	private String insu_target_cd = "";
	private String insu_enter_day = "";
	private String insu_remark = "";
	
	private String air_arng_yn = "";
	private String land_arng_yn = "";
	private String online_yn = "";
	private int event_amt = 0;
	private int dc_amt = 0;
	
	private int add_amt = 0;
	private int sale_amt = 0;
	private int site_comm_rate = 0;
	private int site_comm = 0;
	private int coop_comm_rate = 0;
	
	private int coop_comm = 0;
	private int full_amt_w = 0;
	private int fare_tax_amt = 0;
	private int fare_surcharge = 0;
	private String fare_charge_yn = "";
	
	private int agent_dc_rate = 0;
	private int agent_dc_amt = 0;
	private String air_dc_cd = "";
	private String prove_remark = "";
	private String air_issue_yn = "";
	
	private String ins_dt = "";
	private String ins_id = "";
	private String upd_dt = "";
	private String upd_id = "";
	private String canc_desc = "";
	
	private String canc_cd = "";
	private String canc_dt = "";
	private String canc_id = "";
	private int comp_comm_rate = 0;
	private int comp_comm = 0;
	
	private String insu_req_yn = "";
	private String insu_req_dt = "";
	private String insu_conf_yn = "";
	private String insu_conf_dt = "";
	private int add_site_comm_rate = 0;
	
	private int add_site_comm = 0;
	private int shop_comm_rate = 0;
	private int shop_comm = 0;
	private String shop_conf_day = "";
	private String conn_day = "";
	
	private String conn_time = "";
	private int fare_vat_amt = 0;
	private int res_send_seq = 0;
	private String air_argn_yn = "";
	private String lang_argn_yn = "";
	private int site_comm_amt = 0;
	
	private int fare_tex_amt = 0;
	private int fare_surcharse = 0;
	private String single_yn = "";
	private String pickup_area_cd = "";
	
	public String getSingle_yn() {
		return single_yn;
	}
	public void setSingle_yn(String single_yn) {
		this.single_yn = single_yn;
	}
	public int getFare_surcharse() {
		return fare_surcharse;
	}
	public void setFare_surcharse(int fare_surcharse) {
		this.fare_surcharse = fare_surcharse;
	}
	public int getFare_tex_amt() {
		return fare_tex_amt;
	}
	public void setFare_tex_amt(int fare_tex_amt) {
		this.fare_tex_amt = fare_tex_amt;
	}
	public int getSite_comm_amt() {
		return site_comm_amt;
	}
	public void setSite_comm_amt(int site_comm_amt) {
		this.site_comm_amt = site_comm_amt;
	}
	public String getLang_argn_yn() {
		return lang_argn_yn;
	}
	public void setLang_argn_yn(String lang_argn_yn) {
		this.lang_argn_yn = lang_argn_yn;
	}
	public String getAir_argn_yn() {
		return air_argn_yn;
	}
	public void setAir_argn_yn(String air_argn_yn) {
		this.air_argn_yn = air_argn_yn;
	}
	public int getRes_send_seq() {
		return res_send_seq;
	}
	public void setRes_send_seq(int res_send_seq) {
		this.res_send_seq = res_send_seq;
	}
	public int getFare_vat_amt() {
		return fare_vat_amt;
	}
	public void setFare_vat_amt(int fare_vat_amt) {
		this.fare_vat_amt = fare_vat_amt;
	}
	public String getConn_time() {
		return conn_time;
	}
	public void setConn_time(String conn_time) {
		this.conn_time = conn_time;
	}
	public String getConn_day() {
		return conn_day;
	}
	public void setConn_day(String conn_day) {
		this.conn_day = conn_day;
	}
	public String getRes_cd() {
		return res_cd;
	}
	public void setRes_cd(String res_cd) {
		this.res_cd = res_cd;
	}
	public int getRes_seq() {
		return res_seq;
	}
	public void setRes_seq(int res_seq) {
		this.res_seq = res_seq;
	}
	public String getRes_day() {
		return res_day;
	}
	public void setRes_day(String res_day) {
		this.res_day = res_day;
	}
	public String getEtc_res_cd() {
		return etc_res_cd;
	}
	public void setEtc_res_cd(String etc_res_cd) {
		this.etc_res_cd = etc_res_cd;
	}
	public String getNm_kor() {
		return nm_kor;
	}
	public void setNm_kor(String nm_kor) {
		this.nm_kor = nm_kor;
	}
	public String getEnm_last() {
		return enm_last;
	}
	public void setEnm_last(String enm_last) {
		this.enm_last = enm_last;
	}
	public String getEnm_first() {
		return enm_first;
	}
	public void setEnm_first(String enm_first) {
		this.enm_first = enm_first;
	}
	public String getJmno() {
		return jmno;
	}
	public void setJmno(String jmno) {
		this.jmno = jmno;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getAge_cd() {
		return age_cd;
	}
	public void setAge_cd(String age_cd) {
		this.age_cd = age_cd;
	}
	public String getRoster_title() {
		return roster_title;
	}
	public void setRoster_title(String roster_title) {
		this.roster_title = roster_title;
	}
	public String getCust_cd() {
		return cust_cd;
	}
	public void setCust_cd(String cust_cd) {
		this.cust_cd = cust_cd;
	}
	public String getZip_cd() {
		return zip_cd;
	}
	public void setZip_cd(String zip_cd) {
		this.zip_cd = zip_cd;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getPhone_type() {
		return phone_type;
	}
	public void setPhone_type(String phone_type) {
		this.phone_type = phone_type;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPp_yn() {
		return pp_yn;
	}
	public void setPp_yn(String pp_yn) {
		this.pp_yn = pp_yn;
	}
	public String getPp_nat_cd() {
		return pp_nat_cd;
	}
	public void setPp_nat_cd(String pp_nat_cd) {
		this.pp_nat_cd = pp_nat_cd;
	}
	public String getPp_no() {
		return pp_no;
	}
	public void setPp_no(String pp_no) {
		this.pp_no = pp_no;
	}
	public String getPp_termi_day() {
		return pp_termi_day;
	}
	public void setPp_termi_day(String pp_termi_day) {
		this.pp_termi_day = pp_termi_day;
	}
	public String getVisa_yn() {
		return visa_yn;
	}
	public void setVisa_yn(String visa_yn) {
		this.visa_yn = visa_yn;
	}
	public String getVisa_no() {
		return visa_no;
	}
	public void setVisa_no(String visa_no) {
		this.visa_no = visa_no;
	}
	public String getVisa_termi_day() {
		return visa_termi_day;
	}
	public void setVisa_termi_day(String visa_termi_day) {
		this.visa_termi_day = visa_termi_day;
	}
	public String getConn_yn() {
		return conn_yn;
	}
	public void setConn_yn(String conn_yn) {
		this.conn_yn = conn_yn;
	}
	public String getAir_remark() {
		return air_remark;
	}
	public void setAir_remark(String air_remark) {
		this.air_remark = air_remark;
	}
	public String getLand_remark() {
		return land_remark;
	}
	public void setLand_remark(String land_remark) {
		this.land_remark = land_remark;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getPp_remark() {
		return pp_remark;
	}
	public void setPp_remark(String pp_remark) {
		this.pp_remark = pp_remark;
	}
	public String getVisa_info() {
		return visa_info;
	}
	public void setVisa_info(String visa_info) {
		this.visa_info = visa_info;
	}
	public String getAir_card_cd() {
		return air_card_cd;
	}
	public void setAir_card_cd(String air_card_cd) {
		this.air_card_cd = air_card_cd;
	}
	public String getAir_card_no() {
		return air_card_no;
	}
	public void setAir_card_no(String air_card_no) {
		this.air_card_no = air_card_no;
	}
	public String getApis_no() {
		return apis_no;
	}
	public void setApis_no(String apis_no) {
		this.apis_no = apis_no;
	}
	public String getApis_crs() {
		return apis_crs;
	}
	public void setApis_crs(String apis_crs) {
		this.apis_crs = apis_crs;
	}
	public String getApis_remark() {
		return apis_remark;
	}
	public void setApis_remark(String apis_remark) {
		this.apis_remark = apis_remark;
	}
	public String getContract_send_yn() {
		return contract_send_yn;
	}
	public void setContract_send_yn(String contract_send_yn) {
		this.contract_send_yn = contract_send_yn;
	}
	public String getSend_dt() {
		return send_dt;
	}
	public void setSend_dt(String send_dt) {
		this.send_dt = send_dt;
	}
	public String getContract_accept_yn() {
		return contract_accept_yn;
	}
	public void setContract_accept_yn(String contract_accept_yn) {
		this.contract_accept_yn = contract_accept_yn;
	}
	public String getAccept_dt() {
		return accept_dt;
	}
	public void setAccept_dt(String accept_dt) {
		this.accept_dt = accept_dt;
	}
	public int getRes_team_no() {
		return res_team_no;
	}
	public void setRes_team_no(int res_team_no) {
		this.res_team_no = res_team_no;
	}
	public int getRes_room_seq() {
		return res_room_seq;
	}
	public void setRes_room_seq(int res_room_seq) {
		this.res_room_seq = res_room_seq;
	}
	public String getParlor_cd() {
		return parlor_cd;
	}
	public void setParlor_cd(String parlor_cd) {
		this.parlor_cd = parlor_cd;
	}
	public String getSingel_yn() {
		return singel_yn;
	}
	public void setSingel_yn(String singel_yn) {
		this.singel_yn = singel_yn;
	}
	public int getInsu_price() {
		return insu_price;
	}
	public void setInsu_price(int insu_price) {
		this.insu_price = insu_price;
	}
	public String getInsu_target_cd() {
		return insu_target_cd;
	}
	public void setInsu_target_cd(String insu_target_cd) {
		this.insu_target_cd = insu_target_cd;
	}
	public String getInsu_enter_day() {
		return insu_enter_day;
	}
	public void setInsu_enter_day(String insu_enter_day) {
		this.insu_enter_day = insu_enter_day;
	}
	public String getInsu_remark() {
		return insu_remark;
	}
	public void setInsu_remark(String insu_remark) {
		this.insu_remark = insu_remark;
	}
	public String getAir_arng_yn() {
		return air_arng_yn;
	}
	public void setAir_arng_yn(String air_arng_yn) {
		this.air_arng_yn = air_arng_yn;
	}
	public String getLand_arng_yn() {
		return land_arng_yn;
	}
	public void setLand_arng_yn(String land_arng_yn) {
		this.land_arng_yn = land_arng_yn;
	}
	public String getOnline_yn() {
		return online_yn;
	}
	public void setOnline_yn(String online_yn) {
		this.online_yn = online_yn;
	}
	public int getEvent_amt() {
		return event_amt;
	}
	public void setEvent_amt(int event_amt) {
		this.event_amt = event_amt;
	}
	public int getDc_amt() {
		return dc_amt;
	}
	public void setDc_amt(int dc_amt) {
		this.dc_amt = dc_amt;
	}
	public int getAdd_amt() {
		return add_amt;
	}
	public void setAdd_amt(int add_amt) {
		this.add_amt = add_amt;
	}
	public int getSale_amt() {
		return sale_amt;
	}
	public void setSale_amt(int sale_amt) {
		this.sale_amt = sale_amt;
	}
	public int getSite_comm_rate() {
		return site_comm_rate;
	}
	public void setSite_comm_rate(int site_comm_rate) {
		this.site_comm_rate = site_comm_rate;
	}
	public int getSite_comm() {
		return site_comm;
	}
	public void setSite_comm(int site_comm) {
		this.site_comm = site_comm;
	}
	public int getCoop_comm_rate() {
		return coop_comm_rate;
	}
	public void setCoop_comm_rate(int coop_comm_rate) {
		this.coop_comm_rate = coop_comm_rate;
	}
	public int getCoop_comm() {
		return coop_comm;
	}
	public void setCoop_comm(int coop_comm) {
		this.coop_comm = coop_comm;
	}
	public int getFull_amt_w() {
		return full_amt_w;
	}
	public void setFull_amt_w(int full_amt_w) {
		this.full_amt_w = full_amt_w;
	}
	public int getFare_tax_amt() {
		return fare_tax_amt;
	}
	public void setFare_tax_amt(int fare_tax_amt) {
		this.fare_tax_amt = fare_tax_amt;
	}
	public int getFare_surcharge() {
		return fare_surcharge;
	}
	public void setFare_surcharge(int fare_surcharge) {
		this.fare_surcharge = fare_surcharge;
	}
	public String getFare_charge_yn() {
		return fare_charge_yn;
	}
	public void setFare_charge_yn(String fare_charge_yn) {
		this.fare_charge_yn = fare_charge_yn;
	}
	public int getAgent_dc_rate() {
		return agent_dc_rate;
	}
	public void setAgent_dc_rate(int agent_dc_rate) {
		this.agent_dc_rate = agent_dc_rate;
	}
	public int getAgent_dc_amt() {
		return agent_dc_amt;
	}
	public void setAgent_dc_amt(int agent_dc_amt) {
		this.agent_dc_amt = agent_dc_amt;
	}
	public String getAir_dc_cd() {
		return air_dc_cd;
	}
	public void setAir_dc_cd(String air_dc_cd) {
		this.air_dc_cd = air_dc_cd;
	}
	public String getProve_remark() {
		return prove_remark;
	}
	public void setProve_remark(String prove_remark) {
		this.prove_remark = prove_remark;
	}
	public String getAir_issue_yn() {
		return air_issue_yn;
	}
	public void setAir_issue_yn(String air_issue_yn) {
		this.air_issue_yn = air_issue_yn;
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
	public String getCanc_desc() {
		return canc_desc;
	}
	public void setCanc_desc(String canc_desc) {
		this.canc_desc = canc_desc;
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
	public int getComp_comm_rate() {
		return comp_comm_rate;
	}
	public void setComp_comm_rate(int comp_comm_rate) {
		this.comp_comm_rate = comp_comm_rate;
	}
	public int getComp_comm() {
		return comp_comm;
	}
	public void setComp_comm(int comp_comm) {
		this.comp_comm = comp_comm;
	}
	public String getInsu_req_yn() {
		return insu_req_yn;
	}
	public void setInsu_req_yn(String insu_req_yn) {
		this.insu_req_yn = insu_req_yn;
	}
	public String getInsu_req_dt() {
		return insu_req_dt;
	}
	public void setInsu_req_dt(String insu_req_dt) {
		this.insu_req_dt = insu_req_dt;
	}
	public String getInsu_conf_yn() {
		return insu_conf_yn;
	}
	public void setInsu_conf_yn(String insu_conf_yn) {
		this.insu_conf_yn = insu_conf_yn;
	}
	public String getInsu_conf_dt() {
		return insu_conf_dt;
	}
	public void setInsu_conf_dt(String insu_conf_dt) {
		this.insu_conf_dt = insu_conf_dt;
	}
	public int getAdd_site_comm_rate() {
		return add_site_comm_rate;
	}
	public void setAdd_site_comm_rate(int add_site_comm_rate) {
		this.add_site_comm_rate = add_site_comm_rate;
	}
	public int getAdd_site_comm() {
		return add_site_comm;
	}
	public void setAdd_site_comm(int add_site_comm) {
		this.add_site_comm = add_site_comm;
	}
	public int getShop_comm_rate() {
		return shop_comm_rate;
	}
	public void setShop_comm_rate(int shop_comm_rate) {
		this.shop_comm_rate = shop_comm_rate;
	}
	public int getShop_comm() {
		return shop_comm;
	}
	public void setShop_comm(int shop_comm) {
		this.shop_comm = shop_comm;
	}
	public String getShop_conf_day() {
		return shop_conf_day;
	}
	public void setShop_conf_day(String shop_conf_day) {
		this.shop_conf_day = shop_conf_day;
	}
	public String getPickup_area_cd() {
		return pickup_area_cd;
	}
	public void setPickup_area_cd(String pickup_area_cd) {
		this.pickup_area_cd = pickup_area_cd;
	}

}
