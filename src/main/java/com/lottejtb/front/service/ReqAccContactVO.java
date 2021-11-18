package com.lottejtb.front.service;

import java.util.ArrayList;
import java.util.List;

import com.lottejtb.front.air.service.ReqAirContactVO;

public class ReqAccContactVO {

	private int rsvSeqno = 0;												// 항공 예약 번호 
	private List<ReqAirContactVO> paxGroup = new ArrayList<ReqAirContactVO>(); 			// 탑승자 그룹
	
	public int getRsvSeqno() {
		return rsvSeqno;
	}
	public void setRsvSeqno(int rsvSeqno) {
		this.rsvSeqno = rsvSeqno;
	}
	public List<ReqAirContactVO> getPaxGroup() {
		return paxGroup;
	}
	public void setPaxGroup(List<ReqAirContactVO> paxGroup) {
		this.paxGroup = paxGroup;
	}
	
	
}
