package com.lottejtb.front.air.vo;

public class ReqAirAvailVO{
	private String 	arrCd = "";		//도착도시코드
	private String 	arrDt = "";		//도착일자
	private int 	availNo = 0;		//여정번호
	private String 	depCd = "";		//출발도시코드
	private String 	depDt = "";		//출발일자

	public String getArrCd() {
		return arrCd;
	}
	public void setArrCd(String arrCd) {
		this.arrCd = arrCd;
	}
	public String getArrDt() {
		return arrDt;
	}
	public void setArrDt(String arrDt) {
		this.arrDt = arrDt;
	}
	public int getAvailNo() {
		return availNo;
	}
	public void setAvailNo(int availNo) {
		this.availNo = availNo;
	}
	public String getDepCd() {
		return depCd;
	}
	public void setDepCd(String depCd) {
		this.depCd = depCd;
	}
	public String getDepDt() {
		return depDt;
	}
	public void setDepDt(String depDt) {
		this.depDt = depDt;
	}
}
