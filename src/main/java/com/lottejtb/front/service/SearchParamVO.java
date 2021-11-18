package com.lottejtb.front.service;

public class SearchParamVO {
	private String selAir = "N";		//항공 선택 여부
	private String selHotel = "N";		//호텔 선택 여부
	private String selRentalcar = "N";	//렌터카 선택 여부
	
	/** 항공 파라메타 */
	private String availTy;		//여정 타입
	private String depCtCd;		//출발도시
	private String arrCtCd;		//도착도시
	private String depDt;		//출발일
	private String retDt;		//귀국일
	private int adtCnt;			//성인인원수
	private int chdCnt;			//아동인원수
	private int infCnt;			//유아인원수
	private String cabinClas;	//좌석 클래스
	private String carrierCd;	//선호항공
	private int availNo;		//여정순서
	
	
	
	public String getSelAir() {
		return selAir;
	}
	public void setSelAir(String selAir) {
		this.selAir = selAir;
	}
	public String getSelHotel() {
		return selHotel;
	}
	public void setSelHotel(String selHotel) {
		this.selHotel = selHotel;
	}
	public String getSelRentalcar() {
		return selRentalcar;
	}
	public void setSelRentalcar(String selRentalcar) {
		this.selRentalcar = selRentalcar;
	}
	public String getAvailTy() {
		return availTy;
	}
	public void setAvailTy(String availTy) {
		this.availTy = availTy;
	}
	public String getDepCtCd() {
		return depCtCd;
	}
	public void setDepCtCd(String depCtCd) {
		this.depCtCd = depCtCd;
	}
	public String getArrCtCd() {
		return arrCtCd;
	}
	public void setArrCtCd(String arrCtCd) {
		this.arrCtCd = arrCtCd;
	}
	public String getDepDt() {
		return depDt;
	}
	public void setDepDt(String depDt) {
		this.depDt = depDt;
	}
	public String getRetDt() {
		return retDt;
	}
	public void setRetDt(String retDt) {
		this.retDt = retDt;
	}
	public int getAdtCnt() {
		return adtCnt;
	}
	public void setAdtCnt(int adtCnt) {
		this.adtCnt = adtCnt;
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
	public int getAvailNo() {
		return availNo;
	}
	public void setAvailNo(int availNo) {
		this.availNo = availNo;
	}
	
	/** 호텔 파라메타 */
	// 여행지
	// 체크인 날짜
	// 체크아웃 날짜
	// 객실 수
	// 객실 타입
	// 성인 인원 수 
	// 아동 인원 수
	// 아동 나이
	
	/** 렌터카 파라메타 */
	// 인수장소
	// 반납장소
	// 차량 인수일
	// 인수 시간
	// 차량 반납일
	// 반납 시간
	// 운전자 나이	
}
