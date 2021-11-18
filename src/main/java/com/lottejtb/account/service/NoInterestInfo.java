package com.lottejtb.account.service;

import java.math.BigDecimal;
import java.util.Map;
import java.util.TreeMap;

public class NoInterestInfo {
	Map<Integer, CardAppliedInfo> map;

	String fee;

	int selected;

	public NoInterestInfo() {
		this("0");
	}

	public NoInterestInfo(String fee) {
		if (fee == null || "".equals(fee))
			fee = "0";
		else
			this.fee = fee;
		map = new TreeMap<Integer, CardAppliedInfo>();
		map.put(new Integer("1"), new CardAppliedInfo(1));
		map.put(new Integer("2"), new CardAppliedInfo(2));
		map.put(new Integer("3"), new CardAppliedInfo(3));
		map.put(new Integer("4"), new CardAppliedInfo(4));
		map.put(new Integer("5"), new CardAppliedInfo(5));
		map.put(new Integer("6"), new CardAppliedInfo(6));
		map.put(new Integer("7"), new CardAppliedInfo(7));
		map.put(new Integer("8"), new CardAppliedInfo(8));
		map.put(new Integer("9"), new CardAppliedInfo(9));
		map.put(new Integer("10"), new CardAppliedInfo(10));
		map.put(new Integer("11"), new CardAppliedInfo(11));
		map.put(new Integer("12"), new CardAppliedInfo(12));
		map.put(new Integer("13"), new CardAppliedInfo(13));
		map.put(new Integer("14"), new CardAppliedInfo(14));
		map.put(new Integer("15"), new CardAppliedInfo(15));
		map.put(new Integer("16"), new CardAppliedInfo(16));
		map.put(new Integer("17"), new CardAppliedInfo(17));
		map.put(new Integer("18"), new CardAppliedInfo(18));
		map.put(new Integer("19"), new CardAppliedInfo(19));
		map.put(new Integer("20"), new CardAppliedInfo(20));
		map.put(new Integer("21"), new CardAppliedInfo(21));
		map.put(new Integer("22"), new CardAppliedInfo(22));
		map.put(new Integer("23"), new CardAppliedInfo(23));
		map.put(new Integer("24"), new CardAppliedInfo(24));		
	}

	public void append(String month, CardAppliedInfo info) {
		map.put(new Integer(month), info);
	}
	
	public void append(BigDecimal dec, CardAppliedInfo info ){
		map.put(new Integer(dec.intValue()), info);
	}

	public Map<Integer, CardAppliedInfo> getMap() {
		return map;
	}

	public CardAppliedInfo get(String key) {
		return map.get(new Integer(key));
	}

	public String getFee() {
		return fee;
	}

	public void select(int a) {
		this.selected = a;
	}

	public CardAppliedInfo getSelectedCardAppliedInfo() {
		return map.get(new Integer(selected));
	}
	
	public String toString(){
		return map.toString();
	}

}
