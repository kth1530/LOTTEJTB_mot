package com.lottejtb.front.service;

import java.util.ArrayList;
import java.util.List;

import com.lottejtb.front.air.service.ReqAirAddressVO;
public class ReqAccAddressVO {

	private int rsvSeqno = 0;															// 항공 예약 번호 
	private List<ReqAirAddressVO> paxGroup = new ArrayList<ReqAirAddressVO>(); 			// 탑승자 그룹
	
	public int getRsvSeqno() {
		return rsvSeqno;
	}
	public void setRsvSeqno(int rsvSeqno) {
		this.rsvSeqno = rsvSeqno;
	}
	public List<ReqAirAddressVO> getPaxGroup() {
		return paxGroup;
	}
	public void setPaxGroup(List<ReqAirAddressVO> paxGroup) {
		this.paxGroup = paxGroup;
	}


}
