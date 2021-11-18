package com.lottejtb.reserve.service;

import com.lottejtb.comm.service.CommDefaultVO;

public class SyCdDetVO extends CommDefaultVO {

	private static final long serialVersionUID = 9182357514203556941L;
	
	private String cd = "";
	private String site_cd = "";
	private String type_cd = "";
	private String comp_cd = "";
	private String event_cd = "";
	private String res_day = "";
	
	public String getEvent_cd() {
		return event_cd;
	}
	public void setEvent_cd(String event_cd) {
		this.event_cd = event_cd;
	}
	public String getRes_day() {
		return res_day;
	}
	public void setRes_day(String res_day) {
		this.res_day = res_day;
	}
	public String getComp_cd() {
		return comp_cd;
	}
	public void setComp_cd(String comp_cd) {
		this.comp_cd = comp_cd;
	}
	public String getCd() {
		return cd;
	}
	public void setCd(String cd) {
		this.cd = cd;
	}
	public String getSite_cd() {
		return site_cd;
	}
	public void setSite_cd(String site_cd) {
		this.site_cd = site_cd;
	}
	public String getType_cd() {
		return type_cd;
	}
	public void setType_cd(String type_cd) {
		this.type_cd = type_cd;
	}
	

}
