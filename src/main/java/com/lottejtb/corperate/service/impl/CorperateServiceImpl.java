package com.lottejtb.corperate.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lottejtb.corperate.service.CorperateService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("CorperateService")
public class CorperateServiceImpl extends EgovAbstractServiceImpl implements CorperateService{
	@Resource(name="CorperateDAO")
    private CorperateDAO CorperateDAO;
}