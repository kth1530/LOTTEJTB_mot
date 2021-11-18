package com.lottejtb.front.hotel.service;

import org.apache.commons.lang.builder.ToStringBuilder;

public class ReqHotelInfoVO {
	private String  fitMix;	
	private String  suplrCd;
	private String 	hotelId;
    private String 	customerSessionId;
    
	public String getFitMix() {
		return fitMix;
	}
	public void setFitMix(String fitMix) {
		this.fitMix = fitMix;
	}
	public String getSuplrCd() {
		return suplrCd;
	}
	public void setSuplrCd(String suplrCd) {
		this.suplrCd = suplrCd;
	}
	public String getHotelId() {
		return hotelId;
	}
	public void setHotelId(String hotelId) {
		this.hotelId = hotelId;
	}
	public String getCustomerSessionId() {
		return customerSessionId;
	}
	public void setCustomerSessionId(String customerSessionId) {
		this.customerSessionId = customerSessionId;
	}

    
}