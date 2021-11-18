package com.lottejtb.prom.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.lottejtb.prom.service.PromotionHtListVO;
import com.lottejtb.prom.service.PromotionParamVO;
import com.lottejtb.prom.service.PromotionService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("PromotionService")
@Repository
public class PromotionServiceImpl extends EgovAbstractServiceImpl implements PromotionService{
	@Resource(name="PromotionDAO")
	private PromotionDAO promotionDAO;
	
	@Override
	public HashMap<String, List> selectPromoAmt(PromotionParamVO vo) throws Exception{
		return promotionDAO.selectPromoAmt(vo);
	}
	
}
