package com.lottejtb.search.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.lottejtb.comm.service.CommCtgVO;
import com.lottejtb.search.service.SearchGoodsVO;
import com.lottejtb.search.service.SearchService;
import com.lottejtb.search.service.TourMentoVO;

/**
* 클래스명    :  상품 관련 서비스  구현  클래스 
* @ClassDesc  : 상품 관련 서비스  구현  클래스 
* @FileName   : SiteGoodsMngServiceImpl.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.02 /  / 최초작성
*/

@Service("SearchService")
@SuppressWarnings("unchecked")
public class SearchServiceImpl implements SearchService {
	private Logger logger = Logger.getLogger(this.getClass());
	
    @Resource(name="SearchDAO")
    private SearchDAO searchDAO;

	@Override
	public List srchGoodsList(SearchGoodsVO param) throws Exception {
		// TODO Auto-generated method stub
		return searchDAO.srchGoodsList(param);
	}

	@Override
	public int srchGoodsListCount(SearchGoodsVO param) throws Exception {
		// TODO Auto-generated method stub
		return searchDAO.srchGoodsListCount(param);
	}

	
	@Override
	public List selectAreaList(CommCtgVO param) throws Exception {
		// TODO Auto-generated method stub
		return searchDAO.selectAreaList(param);
	}
	
	@Override
	public List selectTourMentoList(TourMentoVO param) throws Exception {
		// TODO Auto-generated method stub
		return searchDAO.selectTourMentoList(param);
	}
	
	@Override
	public int selectTourMentoListCnt(TourMentoVO param) throws Exception {
		// TODO Auto-generated method stub
		return searchDAO.selectTourMentoListCnt(param);
	}
}
