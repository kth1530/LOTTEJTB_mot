package com.lottejtb.comm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lottejtb.comm.service.CommService;
import com.lottejtb.comm.util.CommInfo;

@Service("commService")
@SuppressWarnings("unchecked")
public class CommServiceImpl implements CommService {

	@Resource(name = "CommInfo")
	CommInfo commInfo;
	
	/** commDao */
	@Resource(name="commDao")
	protected CommDao dao;
	
	public List selectList(String sqlId, Map searchMap) throws Exception {
		return dao.selectList(sqlId, searchMap);
	}
	
	public int selectListTotCnt(String sqlId, Map searchVO) throws Exception {
		return dao.selectListTotCnt(sqlId, searchVO);
	}
	
	public Map select(String sqlId, Map vo) throws Exception {
		return dao.select(sqlId, vo);
	}
}
