package com.lottejtb.front.service;

import java.util.ArrayList;
import java.util.List;

import com.lottejtb.front.air.service.ReqAirMileageVO;

// 항공 마일리지 

public class ReqAccMileageVO {

	private int rsvSeqno = 0;											// 항공 예약 번호 
	private List<ReqAirMileageVO> paxGroup = new ArrayList<ReqAirMileageVO>(); 	// 탑승자 그룹
	
	
	public int getRsvSeqno() {
		return rsvSeqno;
	}
	public void setRsvSeqno(int rsvSeqno) {
		this.rsvSeqno = rsvSeqno;
	}
	public List<ReqAirMileageVO> getPaxGroup() {
		return paxGroup;
	}
	public void setPaxGroup(List<ReqAirMileageVO> paxGroup) {
		this.paxGroup = paxGroup;
	}
	

}
