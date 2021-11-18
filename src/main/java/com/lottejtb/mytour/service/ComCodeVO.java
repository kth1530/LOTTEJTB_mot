package com.lottejtb.mytour.service;

import com.lottejtb.comm.service.CommDefaultVO;

public class ComCodeVO extends CommDefaultVO {

	private static final long serialVersionUID = 2819172894037764674L;
	
	private String cd = "";
	private String cd_nm = "";
	private String cd_jp_nm = "";
	private String cd_en_nm = "";
	private String grp_cd = "";
	
	
	public String getCd() {
		return cd;
	}
	public void setCd(String cd) {
		this.cd = cd;
	}
	public String getCd_nm() {
		return cd_nm;
	}
	public void setCd_nm(String cd_nm) {
		this.cd_nm = cd_nm;
	}
	public String getCd_jp_nm() {
		return cd_jp_nm;
	}
	public void setCd_jp_nm(String cd_jp_nm) {
		this.cd_jp_nm = cd_jp_nm;
	}
	public String getCd_en_nm() {
		return cd_en_nm;
	}
	public void setCd_en_nm(String cd_en_nm) {
		this.cd_en_nm = cd_en_nm;
	}
	public String getGrp_cd() {
		return grp_cd;
	}
	public void setGrp_cd(String grp_cd) {
		this.grp_cd = grp_cd;
	}
	

}	
