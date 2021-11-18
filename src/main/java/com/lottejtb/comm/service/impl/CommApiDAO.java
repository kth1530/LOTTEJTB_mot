package com.lottejtb.comm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lottejtb.comm.service.CommExchangeVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("CommApiDAO")
public class CommApiDAO extends EgovAbstractDAO{
	public CommExchangeVO exchangeInfo(CommExchangeVO vo){
		return (CommExchangeVO) select("CommApiDAO.exchangeInfo", vo);
	}
	
	public List totalExchangeInfo(){
		return list("CommApiDAO.totalExchangeInfo");
	}
}
