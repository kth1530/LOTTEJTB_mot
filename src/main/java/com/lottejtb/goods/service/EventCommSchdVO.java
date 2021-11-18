package com.lottejtb.goods.service;

import com.lottejtb.comm.service.CommDefaultVO;

/**
* 클래스명    :  행사공통사항 일정조회 체크사항 정보를 담고 있는 클래스   
* @ClassDesc  :  행사공통사항 일정조회 체크사항 정보를 담고 있는 클래스     
* @FileName   : EventCommSchdVO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.11 /  / 최초작성
*/


public class EventCommSchdVO extends CommDefaultVO {
	private static final long serialVersionUID = 8597249955637792204L;
	private int ctg_seq = 0;
	
	private String goods_cd = "";

	private String event_cd = "";
	private int comm_seq = 0;
	private String comm_cd = "";
	private String comm_desc = "";
	private int comm_num = 0;
	
	private String comm_yn = "";
	private int det_seq = 0;
	private String comm_desc_det = "";
	private String img_title = "";
	private String img_path = "";
	
	private String img_desc = "";	
	private String img_link = "";
	private String img_pop_yn = "";
	private String etc1 = "";
	private String etc2 = "";
	
	private String etc3 = "";
	private String etc4 = "";
	private String etc5 = "";
	private String comm_type = "";
	private String ins_dt = "";
	
	private String ins_id = "";
	private String upd_dt = "";
	private String upd_id = "";
	
	public int getCtg_seq() {
		return ctg_seq;
	}
	public void setCtg_seq(int ctg_seq) {
		this.ctg_seq = ctg_seq;
	}
	public String getEvent_cd() {
		return event_cd;
	}
	public void setEvent_cd(String event_cd) {
		this.event_cd = event_cd;
	}
	public int getComm_seq() {
		return comm_seq;
	}
	public void setComm_seq(int comm_seq) {
		this.comm_seq = comm_seq;
	}
	public String getComm_cd() {
		return comm_cd;
	}
	public void setComm_cd(String comm_cd) {
		this.comm_cd = comm_cd;
	}
	public String getComm_desc() {
		return comm_desc;
	}
	public void setComm_desc(String comm_desc) {
		this.comm_desc = comm_desc;
	}
	public int getComm_num() {
		return comm_num;
	}
	public void setComm_num(int comm_num) {
		this.comm_num = comm_num;
	}
	public String getComm_yn() {
		return comm_yn;
	}
	public void setComm_yn(String comm_yn) {
		this.comm_yn = comm_yn;
	}
	public int getDet_seq() {
		return det_seq;
	}
	public void setDet_seq(int det_seq) {
		this.det_seq = det_seq;
	}
	public String getComm_desc_det() {
		return comm_desc_det;
	}
	public void setComm_desc_det(String comm_desc_det) {
		this.comm_desc_det = comm_desc_det;
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
	public String getImg_desc() {
		return img_desc;
	}
	public void setImg_desc(String img_desc) {
		this.img_desc = img_desc;
	}
	public String getImg_link() {
		return img_link;
	}
	public void setImg_link(String img_link) {
		this.img_link = img_link;
	}
	public String getImg_pop_yn() {
		return img_pop_yn;
	}
	public void setImg_pop_yn(String img_pop_yn) {
		this.img_pop_yn = img_pop_yn;
	}
	public String getEtc1() {
		return etc1;
	}
	public void setEtc1(String etc1) {
		this.etc1 = etc1;
	}
	public String getEtc2() {
		return etc2;
	}
	public void setEtc2(String etc2) {
		this.etc2 = etc2;
	}
	public String getEtc3() {
		return etc3;
	}
	public void setEtc3(String etc3) {
		this.etc3 = etc3;
	}
	public String getEtc4() {
		return etc4;
	}
	public void setEtc4(String etc4) {
		this.etc4 = etc4;
	}
	public String getEtc5() {
		return etc5;
	}
	public void setEtc5(String etc5) {
		this.etc5 = etc5;
	}
	public String getComm_type() {
		return comm_type;
	}
	public void setComm_type(String comm_type) {
		this.comm_type = comm_type;
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
	public String getGoods_cd() {
		return goods_cd;
	}
	public void setGoods_cd(String goods_cd) {
		this.goods_cd = goods_cd;
	}
}
