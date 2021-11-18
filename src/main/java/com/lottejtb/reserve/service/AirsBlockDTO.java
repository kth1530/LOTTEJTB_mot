package com.lottejtb.reserve.service;

import com.lottejtb.comm.service.CommDefaultVO;

public class AirsBlockDTO extends CommDefaultVO {
	private static final long serialVersionUID = 2239212408175874920L;

	private int event_block = 0;
	private int real_cnt = 0;
	private String event_cd = "";
	
	public int getEvent_block() {
		return event_block;
	}
	public void setEvent_block(int event_block) {
		this.event_block = event_block;
	}
	public int getReal_cnt() {
		return real_cnt;
	}
	public void setReal_cnt(int real_cnt) {
		this.real_cnt = real_cnt;
	}
	public String getEvent_cd() {
		return event_cd;
	}
	public void setEvent_cd(String event_cd) {
		this.event_cd = event_cd;
	}
}
