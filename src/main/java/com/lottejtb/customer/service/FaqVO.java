package com.lottejtb.customer.service;

import com.lottejtb.comm.service.BbsVO;

public class FaqVO extends BbsVO {
	
	private int    beginNo;       //시작번호 
	private String schTxt;        //검색어
	
	private int type0;         	  //항목구분
	private int type10;           //항목구분 
	private int type20;		      //항목구분
	private int type30;           //항목구분
	private int type40;           //항목구분
	private int type50;           //항목구분
	private int type60;           //항목구분

	public int getBeginNo() {
		return beginNo;
	}
	public void setBeginNo(int beginNo) {
		this.beginNo = beginNo;
	}
	public String getSchTxt() {
		return schTxt;
	}
	public void setSchTxt(String schTxt) {
		this.schTxt = schTxt;
	}
	
	public int getType0() {
		return type0;
	}
	public void setType0(int type0) {
		this.type0 = type0;
	}
	public int getType10() {
		return type10;
	}
	public void setType10(int type10) {
		this.type10 = type10;
	}
	public int getType20() {
		return type20;
	}
	public void setType20(int type20) {
		this.type20 = type20;
	}
	public int getType30() {
		return type30;
	}
	public void setType30(int type30) {
		this.type30 = type30;
	}
	public int getType40() {
		return type40;
	}
	public void setType40(int type40) {
		this.type40 = type40;
	}
	public int getType50() {
		return type50;
	}
	public void setType50(int type50) {
		this.type50 = type50;
	}
	public int getType60() {
		return type60;
	}
	public void setType60(int type60) {
		this.type60 = type60;
	}
}
