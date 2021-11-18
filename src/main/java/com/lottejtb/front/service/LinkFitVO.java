package com.lottejtb.front.service;

import com.lottejtb.front.air.service.ReqAirListVO;
import com.lottejtb.front.hotel.service.ReqHotelVO;

public class LinkFitVO{
	private String 	selAir;
	private String 	selHotel;
	private String 	selRentcar;
	
	private ReqAirListVO airSearchValue;
	private ReqHotelVO hotelSearchValue;
	
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
	public String getSelRentcar() {
		return selRentcar;
	}
	public void setSelRentcar(String selRentcar) {
		this.selRentcar = selRentcar;
	}
	public ReqAirListVO getAirSearchValue() {
		return airSearchValue;
	}
	public void setAirSearchValue(ReqAirListVO airSearchValue) {
		this.airSearchValue = airSearchValue;
	}
	public ReqHotelVO getHotelSearchValue() {
		return hotelSearchValue;
	}
	public void setHotelSearchValue(ReqHotelVO hotelSearchValue) {
		this.hotelSearchValue = hotelSearchValue;
	}
}
