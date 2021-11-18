package com.lottejtb.front.air.service;

import java.util.ArrayList;

import com.lottejtb.front.hotel.service.ReqHotelReserveVO;
import com.lottejtb.front.rentcar.service.ReqRentcarReserveVO;

public class ReqReserveVO {
		
	private ArrayList<ReqAirReserveVO> airReserve 			= new ArrayList<ReqAirReserveVO>();
	private ArrayList<ReqHotelReserveVO> hotelReserve 		= new ArrayList<ReqHotelReserveVO>();
	private ArrayList<ReqRentcarReserveVO> rentcarReserve 	= new ArrayList<ReqRentcarReserveVO>();

	public ArrayList<ReqAirReserveVO> getAirReserve() {
		return airReserve;
	}
	public void setAirReserve(ArrayList<ReqAirReserveVO> airReserve) {
		this.airReserve = airReserve;
	}
	public ArrayList<ReqHotelReserveVO> getHotelReserve() {
		return hotelReserve;
	}
	public void setHotelReserve(ArrayList<ReqHotelReserveVO> hotelReserve) {
		this.hotelReserve = hotelReserve;
	}
	public ArrayList<ReqRentcarReserveVO> getRentcarReserve() {
		return rentcarReserve;
	}
	public void setRentcarReserve(ArrayList<ReqRentcarReserveVO> rentcarReserve) {
		this.rentcarReserve = rentcarReserve;
	}
}
