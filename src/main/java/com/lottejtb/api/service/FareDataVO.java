package com.lottejtb.api.service;

public class FareDataVO {	
	private int availNo;
	private String breakPoint;
	private String cabinClas;
	private String fareBasis;
	private String fareTy;	
	private String paxTy;
	private String rbd;
	private int segNo;
	
	public int getAvailNo() {
		return availNo;
	}
	public void setAvailNo(int availNo) {
		this.availNo = availNo;
	}
	public String getFareTy() {
		return fareTy;
	}
	public void setFareTy(String fareTy) {
		this.fareTy = fareTy;
	}
	public String getFareBasis() {
		return fareBasis;
	}
	public void setFareBasis(String fareBasis) {
		this.fareBasis = fareBasis;
	}
	public String getCabinClas() {
		return cabinClas;
	}
	public void setCabinClas(String cabinClas) {
		this.cabinClas = cabinClas;
	}
	public int getSegNo() {
		return segNo;
	}
	public void setSegNo(int segNo) {
		this.segNo = segNo;
	}
	public String getPaxTy() {
		return paxTy;
	}
	public void setPaxTy(String paxTy) {
		this.paxTy = paxTy;
	}
	public String getRbd() {
		return rbd;
	}
	public void setRbd(String rbd) {
		this.rbd = rbd;
	}
	public String getBreakPoint() {
		return breakPoint;
	}
	public void setBreakPoint(String breakPoint) {
		this.breakPoint = breakPoint;
	}
}
