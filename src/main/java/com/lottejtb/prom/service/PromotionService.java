package com.lottejtb.prom.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface PromotionService {
	public HashMap<String, List> selectPromoAmt(PromotionParamVO vo) throws Exception;
}
