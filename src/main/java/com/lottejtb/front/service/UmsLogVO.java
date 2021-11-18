package com.lottejtb.front.service;

import com.lottejtb.comm.service.CommDefaultVO;

/**
* 클래스명    : SMS 보내기 정보를 담고 있는 클래스 
* @ClassDesc  : SMS 보내기 정보를 담고 있는 클래스 
* @FileName   : SmsVO.java
* @TableName  : t4dev/UMS_LOG (관련 테이블이 안 보임) 
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.25 /  / 최초작성
*/

public class UmsLogVO extends CommDefaultVO {

	private static final long serialVersionUID = 8674051746504328320L;

	private int seq = 0;
	private String ums_fg_cd = "";
	private String umskey = "";
	private String ums_det_cd = "";
	private String res_cd = "";
	private String cust_cd = "";
	
	private String ums_desc = "";
	private String trans_cd = "";
	private String ins_dt = "";
	private String ins_id = "";
	
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getUms_fg_cd() {
		return ums_fg_cd;
	}
	public void setUms_fg_cd(String ums_fg_cd) {
		this.ums_fg_cd = ums_fg_cd;
	}
	public String getUmskey() {
		return umskey;
	}
	public void setUmskey(String umskey) {
		this.umskey = umskey;
	}
	public String getUms_det_cd() {
		return ums_det_cd;
	}
	public void setUms_det_cd(String ums_det_cd) {
		this.ums_det_cd = ums_det_cd;
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
	public String getUms_desc() {
		return ums_desc;
	}
	public void setUms_desc(String ums_desc) {
		this.ums_desc = ums_desc;
	}
	public String getTrans_cd() {
		return trans_cd;
	}
	public void setTrans_cd(String trans_cd) {
		this.trans_cd = trans_cd;
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
}
