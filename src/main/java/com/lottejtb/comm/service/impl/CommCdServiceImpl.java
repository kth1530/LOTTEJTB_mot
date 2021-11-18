package com.lottejtb.comm.service.impl;

import java.util.List;


import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.lottejtb.comm.service.CommCdService;
import com.lottejtb.comm.service.CommCdVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("CommCdService")
public class CommCdServiceImpl extends EgovAbstractServiceImpl implements CommCdService{
	
	private static final Logger logger = Logger.getLogger(CommCdServiceImpl.class);
	
    @Resource(name = "CommCdService")
    private CommCdService cdService;
	
	@Resource(name="CommCdDAO")
	private CommCdDAO cdDao;
	
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	@Override
	public List<CommCdVO> CommCdList(CommCdVO cdVO) throws Exception {
		return cdDao.selectCdList(cdVO);
	}
}