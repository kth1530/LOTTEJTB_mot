package com.lottejtb.front.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lottejtb.front.service.FitReserveVO;
import com.lottejtb.front.service.FreeReserveService;
import com.lottejtb.front.service.ReqPromotionVO;
import com.lottejtb.front.service.ReqReserveVO;
import com.lottejtb.mytour.service.MytourVO;

import egovframework.rte.fdl.property.EgovPropertyService;

@Service("FreeReserveService")
public class FreeReserveServiceImpl implements FreeReserveService {
	
	@Resource(name="FreeReserveDAO")
	private FreeReserveDAO reserveDao;
    
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;	
    
	
	public String insertFreeReserve(ReqReserveVO reqVO) throws Exception{
		return reserveDao.insertFreeReserve(reqVO);
	}
	
	public void deleteFreeReserve(ReqReserveVO reqVO) throws Exception{
		reserveDao.deleteFreeReserve(reqVO);
	}

	public FitReserveVO selectFreeReserve(FitReserveVO reserveVO) throws Exception{
		return reserveDao.selectFreeReserve(reserveVO);
	}
	
	@Override
	public void updateFreeReserve(ReqReserveVO reqVO) throws Exception {
		// TODO Auto-generated method stub
		reserveDao.updateFreeReserve(reqVO);
	}
	
	@Override
	public void insertFitPromReserve(ReqPromotionVO promVO) throws Exception{
		reserveDao.insertFitPromReserve(promVO);
	}
	
	@Override
	public void updateFitReserveState(ReqReserveVO reqVO) throws Exception{
		reserveDao.updateFitReserveState(reqVO);
	}
	
	
	@Override
	public HashMap<String, List> freeReserve(String seqNo) throws Exception{
		return reserveDao.freeReserve(seqNo);
	}
	
	@Override
	public String getFitRsvNo(String rsvNo) throws Exception{
		return reserveDao.getFitRsvNo(rsvNo);
	}
}
