package com.lottejtb.domestic.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lottejtb.domestic.service.DomesticService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("DomesticService")
public class DomesticServiceImpl extends EgovAbstractServiceImpl implements DomesticService {

	@Resource(name="DomesticDAO")
    private DomesticDAO DomesticDAO;
	
}
