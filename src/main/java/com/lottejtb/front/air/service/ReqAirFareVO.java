package com.lottejtb.front.air.service;

public class ReqAirFareVO {
	private int 	availNo;	//여정번호
	private String 	breakPoint;	//breakPoint
	private String 	cabinClas;	//좌석클래스
	private String 	fareBasis;	//운임기준
	private String 	fareTy;		//운임유형
	private String 	paxTy;		//탑승자유형
	private String 	rbd;		//부킹클래스
	private int 	segNo;		//세그먼트번호
	
	
	public int getAvailNo() {
		return availNo;
	}
	public void setAvailNo(int availNo) {
		this.availNo = availNo;
	}
	public String getBreakPoint() {
		return breakPoint;
	}
	public void setBreakPoint(String breakPoint) {
		this.breakPoint = breakPoint;
	}
	public String getCabinClas() {
		return cabinClas;
	}
	public void setCabinClas(String cabinClas) {
		this.cabinClas = cabinClas;
	}
	public String getFareBasis() {
		return fareBasis;
	}
	public void setFareBasis(String fareBasis) {
		this.fareBasis = fareBasis;
	}
	public String getFareTy() {
		return fareTy;
	}
	public void setFareTy(String fareTy) {
		this.fareTy = fareTy;
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
	public int getSegNo() {
		return segNo;
	}
	public void setSegNo(int segNo) {
		this.segNo = segNo;
	}	
}
