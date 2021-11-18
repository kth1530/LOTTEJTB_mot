package com.lottejtb.api.service;

import java.util.ArrayList;

public class FareRuleInfoVO {	
	private String itemTxt;
	private int itemNo;
	private String itemNm;
	private String itemAttr;
	private String itemAttrTxt;
	
	private ArrayList<ContentInfoVO> contentGroup = new ArrayList<ContentInfoVO>();
	
	
	public ArrayList<ContentInfoVO> getContentGroup() {
		return contentGroup;
	}
	public void setContentGroup(ArrayList<ContentInfoVO> contentGroup) {
		this.contentGroup = contentGroup;
	}
	public String getItemTxt() {
		return itemTxt;
	}
	public void setItemTxt(String itemTxt) {
		this.itemTxt = itemTxt;
	}
	public int getItemNo() {
		return itemNo;
	}
	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
	}
	public String getItemNm() {
		return itemNm;
	}
	public void setItemNm(String itemNm) {
		this.itemNm = itemNm;
	}
	public String getItemAttr() {
		return itemAttr;
	}
	public void setItemAttr(String itemAttr) {
		this.itemAttr = itemAttr;
	}
	public String getItemAttrTxt() {
		return itemAttrTxt;
	}
	public void setItemAttrTxt(String itemAttrTxt) {
		this.itemAttrTxt = itemAttrTxt;
	}
}