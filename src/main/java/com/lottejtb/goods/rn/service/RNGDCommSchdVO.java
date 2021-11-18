package com.lottejtb.goods.rn.service;

import com.lottejtb.comm.service.CommDefaultVO;
import com.lottejtb.comm.util.CommUtil;
import com.lottejtb.util.Util;

/**
* 클래스명    :  행사 상품 공통 코드 
* @ClassDesc  : 행사 상품 공통 코드 
* @FileName   : RNGDCommSchdVO.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2017.02.03 /  / 최초작성
*/

public class RNGDCommSchdVO  extends CommDefaultVO  {

	private static final long serialVersionUID = -1878025055445441414L;

	private String event_cd = "";
	
	private int schd_id = 0;
	private int reg_seq = 0;
	private int day_cnt = 0;
	private int seq = 0;
	private String schd_det_cd = "";
	
	private String schd_det_cd_val = "";
	private String schd_det_cntn = "";
	private String schd_det_clval = "";
	private String img_title = "";
	private String img_path = "";
	
	private String disp_yn = "";
	private String include_yn = "";
	
	public RNGDCommSchdVO() {
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

	
}
