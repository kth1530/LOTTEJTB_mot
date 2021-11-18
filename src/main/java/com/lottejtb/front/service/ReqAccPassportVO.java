package com.lottejtb.front.service;

import java.util.ArrayList;
import java.util.List;

import com.lottejtb.front.air.service.ReqAirPassportVO;

// 항공 여권 정보 

public class ReqAccPassportVO {

	private int rsvSeqno = 0;												// 항공 예약 번호 
	private List<ReqAirPassportVO> paxGroup = new ArrayList<ReqAirPassportVO>(); 	// 탑승자 그룹
	
	
	public int getRsvSeqno() {
		return rsvSeqno;
	}
	public void setRsvSeqno(int rsvSeqno) {
		this.rsvSeqno = rsvSeqno;
	}
	public List<ReqAirPassportVO> getPaxGroup() {
		return paxGroup;
	}
	public void setPaxGroup(List<ReqAirPassportVO> paxGroup) {
		this.paxGroup = paxGroup;
	}


}
