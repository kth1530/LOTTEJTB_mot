package com.lottejtb.front.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lottejtb.front.air.service.RsvAirItinVO;
import com.lottejtb.front.air.service.RsvAirPaxVO;
import com.lottejtb.front.air.service.RsvAirService;
import com.lottejtb.front.air.service.RsvAirVO;
import com.lottejtb.front.service.FaFitAtxtCdVO;

import egovframework.rte.fdl.property.EgovPropertyService;

@Service("RsvAirService")
public class RsvAirServiceImpl implements RsvAirService {

	@Resource(name="RsvAirDAO")
	private RsvAirDAO rsvAirDao;
    
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;	
    
	public RsvAirServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public RsvAirVO selectRsvAir(RsvAirVO reqVo) throws Exception {
		// TODO Auto-generated method stub
		return rsvAirDao.selectRsvAir(reqVo);
	}

	@Override
	public List selectRsvAirPaxList(RsvAirPaxVO reqVo)
			throws Exception {
		// TODO Auto-generated method stub
		return rsvAirDao.selectRsvAirPaxList(reqVo);
	}

	@Override
	public List selectRsvAirItinList(RsvAirItinVO reqVo) throws Exception {
		// TODO Auto-generated method stub
		return rsvAirDao.selectRsvAirItinList(reqVo);
	}

	@Override
	public FaFitAtxtCdVO selectRsvFitAtxt(String atxtCd) throws Exception {
		// TODO Auto-generated method stub
		return rsvAirDao.selectRsvFitAtxt(atxtCd);
	}

}
