package com.lottejtb.search.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lottejtb.comm.service.CommCtgVO;
import com.lottejtb.framework.common.CommAbstractDAO;
import com.lottejtb.search.service.SearchGoodsVO;
import com.lottejtb.search.service.TourMentoVO;

@Repository("SearchDAO")
public class SearchDAO extends CommAbstractDAO {
	

	public List srchGoodsList(SearchGoodsVO param) throws Exception {
		// TODO Auto-generated method stub
		return list("SearchDAO.selectGoodsList", param);
	}

	public int srchGoodsListCount(SearchGoodsVO param) throws Exception {
		// TODO Auto-generated method stub
		return (Integer) select("SearchDAO.selectGoodsListCount", param);
	}	
	
	public List selectAreaList(CommCtgVO param) throws Exception {
		// TODO Auto-generated method stub
		return list("SearchDAO.selectAreaList", param);
	}
	
	public List selectTourMentoList(TourMentoVO param) throws Exception {
		// TODO Auto-generated method stub
		return list("SearchDAO.selectTourMentoList", param);
	}
	
	public int selectTourMentoListCnt(TourMentoVO param) throws Exception {
		// TODO Auto-generated method stub
		return (Integer) select("SearchDAO.selectTourMentoListCnt", param);
	}
}
