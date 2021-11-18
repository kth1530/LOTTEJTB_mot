package com.lottejtb.front.air.vo;

import java.util.ArrayList;

public class ReqAirListVO{
	private int 	adtCnt = 0;				//성인 탑승객 수
	private String 	availTy = "";		//여정 유형(RT:왕복, OW:편도, MT:다구간)
	private String 	cabinClas = "";      //좌석 클래스(Y:일반석, W:프리미엄 일반석, C:비지니스석, F:일등석) 
	private String 	carrierCd = "";      //선호 항공사
	private int 	chdCnt = 0;             //아동 탑승객 수
	private int	 	infCnt = 0;             //유아 탑승객 수
	private String 	routeTy = "";		//라우터 유형 (D:국내선, I:국제선)
	private String	concMix	= "";
	
	private ArrayList<ReqAirAvailVO> availGroup = new ArrayList<ReqAirAvailVO>();
	
	
	public int getAdtCnt() {
		return adtCnt;
	}
	public void setAdtCnt(int adtCnt) {
		this.adtCnt = adtCnt;
	}
	public String getAvailTy() {
		return availTy;
	}
	public void setAvailTy(String availTy) {
		this.availTy = availTy;
	}
	public String getCabinClas() {
		return cabinClas;
	}
	public void setCabinClas(String cabinClas) {
		this.cabinClas = cabinClas;
	}
	public String getCarrierCd() {
		return carrierCd;
	}
	public void setCarrierCd(String carrierCd) {
		this.carrierCd = carrierCd;
	}
	public int getChdCnt() {
		return chdCnt;
	}
	public void setChdCnt(int chdCnt) {
		this.chdCnt = chdCnt;
	}
	public int getInfCnt() {
		return infCnt;
	}
	public void setInfCnt(int infCnt) {
		this.infCnt = infCnt;
	}
	public void setAvailGroup(ArrayList<ReqAirAvailVO> availGroup) {
		this.availGroup = availGroup;
	}
	public ArrayList<ReqAirAvailVO> getAvailGroup() {
		return availGroup;
	}
	public void setRouteTy(String routeTy) {
		this.routeTy = routeTy;
	}
	public String getRouteTy() {
		return routeTy;
	}
	public String getConcMix() {
		return concMix;
	}
	public void setConcMix(String concMix) {
		this.concMix = concMix;
	}
}