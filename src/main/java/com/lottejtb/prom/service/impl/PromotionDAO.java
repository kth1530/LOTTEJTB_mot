package com.lottejtb.prom.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.lottejtb.framework.common.CommAbstractFreeDAO;
import com.lottejtb.prom.service.PromotionHtListVO;
import com.lottejtb.prom.service.PromotionHtlVO;
import com.lottejtb.prom.service.PromotionParamVO;

@Repository("PromotionDAO")
public class PromotionDAO extends CommAbstractFreeDAO{
	public HashMap<String, List> selectPromoAmt(PromotionParamVO vo) throws Exception{
		HashMap<String, List> result = new HashMap<String, List>();
		List airResult = new ArrayList();
		List htlResult = new ArrayList();
		List ijwResult = new ArrayList();
		
		result.put("mstProm", list("PromotionDAO.selectPromoMst", vo.getPromMst()));
		
		
		airResult.add(select("PromotionDAO.selectPromoAir", vo.getPromAir()));
		
		result.put("airProm", airResult);
		
		//for(PromotionHtlVO paramVO : vo.getPromHtl()){
		for(int j = 0; j < vo.getPromHtl().size(); j++){
			htlResult.add(select("PromotionDAO.selectPromoHtl", vo.getPromHtl().get(j)));
			ijwResult.add(select("PromotionDAO.selectPromoIjw"));
		}
		
		result.put("htlProm", htlResult);
		result.put("ijwProm", ijwResult);
		
		return result;
	}
	
}
