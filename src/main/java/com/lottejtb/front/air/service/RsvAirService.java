package com.lottejtb.front.air.service;

import java.util.List;

import com.lottejtb.front.service.FaFitAtxtCdVO;


public interface RsvAirService {
	RsvAirVO selectRsvAir (RsvAirVO reqVo) throws Exception;
	List selectRsvAirPaxList(RsvAirPaxVO reqVo) throws Exception;	
	List selectRsvAirItinList(RsvAirItinVO reqVo) throws Exception;	
	FaFitAtxtCdVO selectRsvFitAtxt(String atxtCd) throws Exception;
}
