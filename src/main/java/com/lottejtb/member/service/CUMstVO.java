package com.lottejtb.member.service;

import com.lottejtb.comm.service.CommDefaultVO;


/**
* 클래스명    : 회원 정보를 담고 있는 클래스 
* @ClassDesc  : 회원  정보를 담고 있는 클래스 
* @FileName   : CUMstVO.java
* @TableName  : t4dev/RV_MST
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.25 /  / 최초작성
*/

public class CUMstVO extends CommDefaultVO {
	private static final long serialVersionUID = 7481597541427568292L;
	
	private int jmno_cnt = 0;
	private int email_cnt = 0;
	private int handphone_cnt = 0;
	private int lotte_id_cnt = 0;
	private int tel_cnt = 0;
	private int cnt = 0;
	
	
	private String cust_cd = "";
	private String jmno = "";
	private String knm = "";
	private String last_enm = "";
	private String first_enm = "";
	
	private String repre_country_cd = ""; // 여권정보 및 고객의 대표국적
	private String sex = "";
	private String id = "";
	private String pass = "";
	private String regi_fg = "";			// 정회원,비회원, 준회원 구분 
	
	private String etc_tel_no = "";
	private String birthday = "";
	private String birth_chk = "";
	private String marry_day = "";
	private String spouse_yn = "";
	
	private String zip_cd = "";
	private String home_addr1 = "";
	private String home_addr2 = "";
	private String job_cd = "";
	private String comp_zip_cd = "";
	
	private String comp_addr1 = "";
	private String comp_addr2 = "";
	private String comp_nm = "";
	private String comp_email = "";
	private String comp_adm_info = "";
	
	private String job_nm = "";
	private String dept_nm = "";
	private String grade_nm = "";
	private String sch_nm = "";
	private String sch_yn = "";
	
	private String subject = "";
	private String cust_grade_cd = "";
	private String keyman_cd = "";
	private String aircard_cd = "";
	private String dm_yn = "";
	private String aircard_yn = "";
	
	private String email_yn = "";
	private String comp_desc = "";
	private String url = "";
	private String email = "";
	private String comp_fax = "";
	private String handphone_cd = "";
	private String handphone="";
	
	private String handphone1 = "";
	private String handphone2 = "";
	private String handphone3 = "";
	private String home_tel1 = "";
	private String home_tel2 = "";
	
	private String tel = "";
	private String home_tel3 = "";
	private String comp_tel1 = "";
	private String comp_tel2 = "";
	private String comp_tel3 = "";
	private String site_cd= "";
	
	private String sms_yn = "";
	private String info_open_yn = "";
	private String nick_nm = "";
	private String detail_cd = "";
	private String join_path = "";
	
	private String bad_cust_yn = "";
	private String real_nm_yn = "";
	private String repre_cust_key = "";
	private String rel_cd = "";
	private String remark = "";
	
	private String del_yn = "";
	private String del_dt = "";
	private String secession_cd = "";
	private String secession_remark = "";
	private String cha_id = "";
	
	private String chs_dept_cd = "";
	private int lotte_no = 0; 				// 롯데 통합 회원번호
	private String lotte_id = "";
	private String manag_type_cd = "";		// 관리유형 	
	private String manag_spot_cd = "";		// 관리지점
	
	private String ins_dt = "";	
	private String ins_id = "";
	private String upd_dt = "";
	private String upd_id = "";
	private String lotte_cust_no = "";
	
	
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getHandphone() {
		return handphone;
	}
	public void setHandphone(String handphone) {
		this.handphone = handphone;
	}	
	public String getAircard_yn() {
		return aircard_yn;
	}
	public void setAircard_yn(String aircard_yn) {
		this.aircard_yn = aircard_yn;
	}	
	public int getJmno_cnt() {
		return jmno_cnt;
	}
	public void setJmno_cnt(int jmno_cnt) {
		this.jmno_cnt = jmno_cnt;
	}
	public int getEmail_cnt() {
		return email_cnt;
	}
	public void setEmail_cnt(int email_cnt) {
		this.email_cnt = email_cnt;
	}
	public int getHandphone_cnt() {
		return handphone_cnt;
	}
	public void setHandphone_cnt(int handphone_cnt) {
		this.handphone_cnt = handphone_cnt;
	}
	public int getLotte_id_cnt() {
		return lotte_id_cnt;
	}
	public void setLotte_id_cnt(int lotte_id_cnt) {
		this.lotte_id_cnt = lotte_id_cnt;
	}
	public int getTel_cnt() {
		return tel_cnt;
	}
	public void setTel_cnt(int tel_cnt) {
		this.tel_cnt = tel_cnt;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getCust_cd() {
		return cust_cd;
	}
	public void setCust_cd(String cust_cd) {
		this.cust_cd = cust_cd;
	}
	public String getJmno() {
		return jmno;
	}
	public void setJmno(String jmno) {
		this.jmno = jmno;
	}
	public String getKnm() {
		return knm;
	}
	public void setKnm(String knm) {
		this.knm = knm;
	}
	public String getLast_enm() {
		return last_enm;
	}
	public void setLast_enm(String last_enm) {
		this.last_enm = last_enm;
	}
	public String getFirst_enm() {
		return first_enm;
	}
	public void setFirst_enm(String first_enm) {
		this.first_enm = first_enm;
	}
	public String getRepre_country_cd() {
		return repre_country_cd;
	}
	public void setRepre_country_cd(String repre_country_cd) {
		this.repre_country_cd = repre_country_cd;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getRegi_fg() {
		return regi_fg;
	}
	public void setRegi_fg(String regi_fg) {
		this.regi_fg = regi_fg;
	}
	public String getEtc_tel_no() {
		return etc_tel_no;
	}
	public void setEtc_tel_no(String etc_tel_no) {
		this.etc_tel_no = etc_tel_no;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getBirth_chk() {
		return birth_chk;
	}
	public void setBirth_chk(String birth_chk) {
		this.birth_chk = birth_chk;
	}
	public String getMarry_day() {
		return marry_day;
	}
	public void setMarry_day(String marry_day) {
		this.marry_day = marry_day;
	}
	public String getSpouse_yn() {
		return spouse_yn;
	}
	public void setSpouse_yn(String spouse_yn) {
		this.spouse_yn = spouse_yn;
	}
	public String getZip_cd() {
		return zip_cd;
	}
	public void setZip_cd(String zip_cd) {
		this.zip_cd = zip_cd;
	}
	public String getHome_addr1() {
		return home_addr1;
	}
	public void setHome_addr1(String home_addr1) {
		this.home_addr1 = home_addr1;
	}
	public String getHome_addr2() {
		return home_addr2;
	}
	public void setHome_addr2(String home_addr2) {
		this.home_addr2 = home_addr2;
	}
	public String getJob_cd() {
		return job_cd;
	}
	public void setJob_cd(String job_cd) {
		this.job_cd = job_cd;
	}
	public String getComp_zip_cd() {
		return comp_zip_cd;
	}
	public void setComp_zip_cd(String comp_zip_cd) {
		this.comp_zip_cd = comp_zip_cd;
	}
	public String getComp_addr1() {
		return comp_addr1;
	}
	public void setComp_addr1(String comp_addr1) {
		this.comp_addr1 = comp_addr1;
	}
	public String getComp_addr2() {
		return comp_addr2;
	}
	public void setComp_addr2(String comp_addr2) {
		this.comp_addr2 = comp_addr2;
	}
	public String getComp_nm() {
		return comp_nm;
	}
	public void setComp_nm(String comp_nm) {
		this.comp_nm = comp_nm;
	}
	public String getComp_email() {
		return comp_email;
	}
	public void setComp_email(String comp_email) {
		this.comp_email = comp_email;
	}
	public String getComp_adm_info() {
		return comp_adm_info;
	}
	public void setComp_adm_info(String comp_adm_info) {
		this.comp_adm_info = comp_adm_info;
	}
	public String getJob_nm() {
		return job_nm;
	}
	public void setJob_nm(String job_nm) {
		this.job_nm = job_nm;
	}
	public String getDept_nm() {
		return dept_nm;
	}
	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}
	public String getGrade_nm() {
		return grade_nm;
	}
	public void setGrade_nm(String grade_nm) {
		this.grade_nm = grade_nm;
	}
	public String getSch_nm() {
		return sch_nm;
	}
	public void setSch_nm(String sch_nm) {
		this.sch_nm = sch_nm;
	}
	public String getSch_yn() {
		return sch_yn;
	}
	public void setSch_yn(String sch_yn) {
		this.sch_yn = sch_yn;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getCust_grade_cd() {
		return cust_grade_cd;
	}
	public void setCust_grade_cd(String cust_grade_cd) {
		this.cust_grade_cd = cust_grade_cd;
	}
	public String getKeyman_cd() {
		return keyman_cd;
	}
	public void setKeyman_cd(String keyman_cd) {
		this.keyman_cd = keyman_cd;
	}
	public String getAircard_cd() {
		return aircard_cd;
	}
	public void setAircard_cd(String aircard_cd) {
		this.aircard_cd = aircard_cd;
	}
	public String getDm_yn() {
		return dm_yn;
	}
	public void setDm_yn(String dm_yn) {
		this.dm_yn = dm_yn;
	}
	public String getEmail_yn() {
		return email_yn;
	}
	public void setEmail_yn(String email_yn) {
		this.email_yn = email_yn;
	}
	public String getComp_desc() {
		return comp_desc;
	}
	public void setComp_desc(String comp_desc) {
		this.comp_desc = comp_desc;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getComp_fax() {
		return comp_fax;
	}
	public void setComp_fax(String comp_fax) {
		this.comp_fax = comp_fax;
	}
	public String getHandphone_cd() {
		return handphone_cd;
	}
	public void setHandphone_cd(String handphone_cd) {
		this.handphone_cd = handphone_cd;
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
	public String getHome_tel1() {
		return home_tel1;
	}
	public void setHome_tel1(String home_tel1) {
		this.home_tel1 = home_tel1;
	}
	public String getHome_tel2() {
		return home_tel2;
	}
	public void setHome_tel2(String home_tel2) {
		this.home_tel2 = home_tel2;
	}
	public String getHome_tel3() {
		return home_tel3;
	}
	public void setHome_tel3(String home_tel3) {
		this.home_tel3 = home_tel3;
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
	public String getSite_cd() {
		return site_cd;
	}
	public void setSite_cd(String site_cd) {
		this.site_cd = site_cd;
	}
	public String getSms_yn() {
		return sms_yn;
	}
	public void setSms_yn(String sms_yn) {
		this.sms_yn = sms_yn;
	}
	public String getInfo_open_yn() {
		return info_open_yn;
	}
	public void setInfo_open_yn(String info_open_yn) {
		this.info_open_yn = info_open_yn;
	}
	public String getNick_nm() {
		return nick_nm;
	}
	public void setNick_nm(String nick_nm) {
		this.nick_nm = nick_nm;
	}
	public String getDetail_cd() {
		return detail_cd;
	}
	public void setDetail_cd(String detail_cd) {
		this.detail_cd = detail_cd;
	}
	public String getJoin_path() {
		return join_path;
	}
	public void setJoin_path(String join_path) {
		this.join_path = join_path;
	}
	public String getBad_cust_yn() {
		return bad_cust_yn;
	}
	public void setBad_cust_yn(String bad_cust_yn) {
		this.bad_cust_yn = bad_cust_yn;
	}
	public String getReal_nm_yn() {
		return real_nm_yn;
	}
	public void setReal_nm_yn(String real_nm_yn) {
		this.real_nm_yn = real_nm_yn;
	}
	public String getRepre_cust_key() {
		return repre_cust_key;
	}
	public void setRepre_cust_key(String repre_cust_key) {
		this.repre_cust_key = repre_cust_key;
	}
	public String getRel_cd() {
		return rel_cd;
	}
	public void setRel_cd(String rel_cd) {
		this.rel_cd = rel_cd;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getDel_dt() {
		return del_dt;
	}
	public void setDel_dt(String del_dt) {
		this.del_dt = del_dt;
	}
	public String getSecession_cd() {
		return secession_cd;
	}
	public void setSecession_cd(String secession_cd) {
		this.secession_cd = secession_cd;
	}
	public String getSecession_remark() {
		return secession_remark;
	}
	public void setSecession_remark(String secession_remark) {
		this.secession_remark = secession_remark;
	}
	public String getCha_id() {
		return cha_id;
	}
	public void setCha_id(String cha_id) {
		this.cha_id = cha_id;
	}
	public String getChs_dept_cd() {
		return chs_dept_cd;
	}
	public void setChs_dept_cd(String chs_dept_cd) {
		this.chs_dept_cd = chs_dept_cd;
	}
	public int getLotte_no() {
		return lotte_no;
	}
	public void setLotte_no(int lotte_no) {
		this.lotte_no = lotte_no;
	}
	public String getLotte_id() {
		return lotte_id;
	}
	public void setLotte_id(String lotte_id) {
		this.lotte_id = lotte_id;
	}
	public String getManag_type_cd() {
		return manag_type_cd;
	}
	public void setManag_type_cd(String manag_type_cd) {
		this.manag_type_cd = manag_type_cd;
	}
	public String getManag_spot_cd() {
		return manag_spot_cd;
	}
	public void setManag_spot_cd(String manag_spot_cd) {
		this.manag_spot_cd = manag_spot_cd;
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
	public String getLotte_cust_no() {
		return lotte_cust_no;
	}
	public void setLotte_cust_no(String lotte_cust_no) {
		this.lotte_cust_no = lotte_cust_no;
	}


}
