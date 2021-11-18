package com.lottejtb.customer.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lottejtb.customer.service.FaqService;
import com.lottejtb.customer.service.FaqVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("FaqService")
public class FaqServiceImpl  extends EgovAbstractServiceImpl implements FaqService{

    @Resource(name="FaqDAO")
    private FaqDAO faqDAO;
    
	@Override
	public List selectFaqList(FaqVO vo) throws Exception {
		return faqDAO.selectFaqList(vo);
	}

	@Override
	public FaqVO selectFaqListAllCount(FaqVO vo) throws Exception {
		return faqDAO.selectFaqListAllCount(vo);
	}

	@Override
	public List selectFaqFirstList(FaqVO vo) throws Exception {
		return faqDAO.selectFaqFirstList(vo);
	}

}
