package com.lottejtb.cooperation.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lottejtb.cooperation.service.CooperationService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("CooperationService")
public class CooperationServiceImpl extends EgovAbstractServiceImpl implements CooperationService{
	@Resource(name="CooperationDAO")
    private CooperationDAO cooperationDAO;
}