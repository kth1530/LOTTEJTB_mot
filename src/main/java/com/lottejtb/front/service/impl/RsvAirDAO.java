package com.lottejtb.front.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.lottejtb.framework.common.CommAbstractFreeDAO;
import com.lottejtb.front.air.service.RsvAirItinVO;
import com.lottejtb.front.air.service.RsvAirPaxVO;
import com.lottejtb.front.air.service.RsvAirVO;
import com.lottejtb.front.service.FaFitAtxtCdVO;

import egovframework.rte.fdl.property.EgovPropertyService;

@Repository("RsvAirDAO")
public class RsvAirDAO extends CommAbstractFreeDAO {
	
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;	
	
	public RsvAirVO selectRsvAir(Object reqVo) {
		return (RsvAirVO) select("RsvAirDAO.selectRsvAir", reqVo);
	}
	

	public List selectRsvAirPaxList(RsvAirPaxVO reqVo) {
		// TODO Auto-generated method stub
		return (List) list("RsvAirDAO.selectRsvAirPaxList", reqVo);
	}

	public List selectRsvAirItinList(RsvAirItinVO reqVo) {
		// TODO Auto-generated method stub
		return (List) list("RsvAirDAO.selectRsvAirItinList", reqVo);
	}
	
	public FaFitAtxtCdVO selectRsvFitAtxt(Object reqVo) {
		return (FaFitAtxtCdVO) select("RsvAirDAO.selectRsvFitAtxt", reqVo);
	}
		
}
