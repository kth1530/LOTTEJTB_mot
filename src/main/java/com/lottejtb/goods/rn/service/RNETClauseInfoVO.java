package com.lottejtb.goods.rn.service;

import com.lottejtb.comm.service.CommDefaultVO;
import com.lottejtb.util.Util;

public class RNETClauseInfoVO extends CommDefaultVO {
	private static final long serialVersionUID = 7594740050308666547L;
	private String clause_fg = "";
	private String clause_desc = "";
	private String clause_desc2 = "";
	
	private String event_cd = "";

	public RNETClauseInfoVO() {
		// TODO Auto-generated constructor stub
	}
	
	public String getClause_fg() {
		return clause_fg;
	}

	public void setClause_fg(String clause_fg) {
		this.clause_fg = clause_fg;
	}

	public String getClause_desc() {
		return clause_desc;
	}

	public void setClause_desc(String clause_desc) {
		this.clause_desc = Util.convertStringTotag(Util.strip_tags(clause_desc));
	}

	public String getEvent_cd() {
		return event_cd;
	}

	public void setEvent_cd(String event_cd) {
		this.event_cd = event_cd;
	}

	public String getClause_desc2() {
		return clause_desc2;
	}

	public void setClause_desc2(String clause_desc2) {
		this.clause_desc2 = Util.convertStringTotag(Util.strip_tags(clause_desc2));
	}

}
