package com.lottejtb.reserve.service;

import com.lottejtb.comm.service.CommDefaultVO;



/**
* 클래스명    : 상품 가격 정보를 담고 있는 클래스 
* @ClassDesc  : 상품 가격 정보를 담고 있는 클래스 
* @FileName   : EtPriceDTO.java
* @TableName  : t4dev/ET_PRICE
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.25 /  / 최초작성
*/

public class EtPriceDTO extends CommDefaultVO {
	private static final long serialVersionUID = 8400593174044960537L;

	private int adult_price = 0;
	private int child_price = 0;
	private int baby_price = 0;
	private int etc_price1 = 0;
	private int etc_price2 = 0;
	
	private int etc_price3 = 0;
	private String event_cd = "";
	
	
	public String getEvent_cd() {
		return event_cd;
	}
	public void setEvent_cd(String event_cd) {
		this.event_cd = event_cd;
	}
	public int getAdult_price() {
		return adult_price;
	}
	public void setAdult_price(int adult_price) {
		this.adult_price = adult_price;
	}
	public int getChild_price() {
		return child_price;
	}
	public void setChild_price(int child_price) {
		this.child_price = child_price;
	}
	public int getBaby_price() {
		return baby_price;
	}
	public void setBaby_price(int baby_price) {
		this.baby_price = baby_price;
	}
	public int getEtc_price1() {
		return etc_price1;
	}
	public void setEtc_price1(int etc_price1) {
		this.etc_price1 = etc_price1;
	}
	public int getEtc_price2() {
		return etc_price2;
	}
	public void setEtc_price2(int etc_price2) {
		this.etc_price2 = etc_price2;
	}
	public int getEtc_price3() {
		return etc_price3;
	}
	public void setEtc_price3(int etc_price3) {
		this.etc_price3 = etc_price3;
	}
}
