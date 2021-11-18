package com.lottejtb.customer.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lottejtb.customer.service.FaqVO;
import com.lottejtb.framework.common.CommAbstractDAO;

@Repository("FaqDAO")
public class FaqDAO extends CommAbstractDAO{
	
	public List selectFaqList(FaqVO vo) throws Exception{
        return list("FaqDAO.selectFaqList",vo);
    }
	
	public FaqVO selectFaqListAllCount(FaqVO vo) throws Exception{
		return (FaqVO) select("FaqDAO.selectFaqListAllCount",vo);
    }
	
	public List selectFaqFirstList(FaqVO vo) throws Exception{
        return list("FaqDAO.selectFaqFirstList",vo);
    }
	
}

