package com.lottejtb.cruise.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lottejtb.cruise.service.CruiseService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("CruiseService")
public class CruiseServiceImpl extends EgovAbstractServiceImpl implements CruiseService{
	@Resource(name="CruiseDAO")
	private CruiseDAO cruiseDAO;
}
