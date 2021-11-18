package com.lottejtb.front.service;

import java.util.ArrayList;

import com.lottejtb.front.air.service.ReqAirReserveVO;
import com.lottejtb.front.hotel.service.ReqHotelReserveVO;
import com.lottejtb.front.rentcar.service.ReqRentcarCarVO;

public class ReqMstReserveVO {
	private ReqAirReserveVO airReserve 				= new ReqAirReserveVO();
	private ReqHotelReserveVO hotelReserve 			= new ReqHotelReserveVO();
	private ArrayList<ReqRentcarCarVO> rentcarReserve 	= new ArrayList<ReqRentcarCarVO>();
	private ReqReserveVO reqReserve					= new ReqReserveVO();
	private ReqPromotionVO promReserve				= new ReqPromotionVO();
	
	private String airYN;
	private String hotelYN;
	private String rentcarYN;
		
	public ReqAirReserveVO getAirReserve() {
		return airReserve;
	}
	public void setAirReserve(ReqAirReserveVO airReserve) {
		this.airReserve = airReserve;
	}
	public ReqHotelReserveVO getHotelReserve() {
		return hotelReserve;
	}
	public void setHotelReserve(ReqHotelReserveVO hotelReserve) {
		this.hotelReserve = hotelReserve;
	}
	public ArrayList<ReqRentcarCarVO> getRentcarReserve() {
		return rentcarReserve;
	}
	public void setRentcarReserve(ArrayList<ReqRentcarCarVO> rentcarReserve) {
		this.rentcarReserve = rentcarReserve;
	}
	public ReqReserveVO getReqReserve() {
		return reqReserve;
	}
	public void setReqReserve(ReqReserveVO reqReserve) {
		this.reqReserve = reqReserve;
	}
	public ReqPromotionVO getPromReserve() {
		return promReserve;
	}
	public void setPromReserve(ReqPromotionVO promReserve) {
		this.promReserve = promReserve;
	}
	
	public String getAirYN() {
		return airYN;
	}
	public void setAirYN(String airYN) {
		this.airYN = airYN;
	}
	public String getHotelYN() {
		return hotelYN;
	}
	public void setHotelYN(String hotelYN) {
		this.hotelYN = hotelYN;
	}
	public String getRentcarYN() {
		return rentcarYN;
	}
	public void setRentcarYN(String rentcarYN) {
		this.rentcarYN = rentcarYN;
	}

}
