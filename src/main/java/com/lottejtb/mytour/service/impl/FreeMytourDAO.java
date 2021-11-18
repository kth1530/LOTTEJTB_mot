package com.lottejtb.mytour.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lottejtb.framework.common.CommAbstractDAO;
import com.lottejtb.framework.common.CommAbstractFreeDAO;
import com.lottejtb.mytour.service.AirRsvCounselVO;
import com.lottejtb.mytour.service.ComCodeVO;
import com.lottejtb.mytour.service.FaFitCounselAnswVO;
import com.lottejtb.mytour.service.FaFitCounselAssortVO;
import com.lottejtb.mytour.service.FaFitCounselQuesVO;
import com.lottejtb.mytour.service.MytourVO;

@Repository("FreeMytourDAO")
public class FreeMytourDAO extends CommAbstractFreeDAO {
	public List freeReserve(MytourVO vo) throws Exception {
        return list("FreeMytourDAO.freeReserve", vo);
    }
	
	public List freeCancelReserve(MytourVO vo) throws Exception {
		return list("FreeMytourDAO.freeCancelReserve", vo);
	}
	
	
	public List srchAirCounselList(AirRsvCounselVO vo) throws Exception {
		// TODO Auto-generated method stub
		return list("FreeMytourDAO.selectAirCounselList", vo);
	}

	public int srchAirCounselListCount(AirRsvCounselVO vo) throws Exception {
		// TODO Auto-generated method stub
		return (Integer) select("FreeMytourDAO.selectAirCounselListCount", vo);
	}
	
	
	public void saveAirCounsel(AirRsvCounselVO vo) throws Exception {
		// TODO Auto-generated method stub
		insert("FreeMytourDAO.insertAirCounsel", vo);
	}
	
	public List srchCounselQuesList(FaFitCounselQuesVO vo) throws Exception {
		// TODO Auto-generated method stub
		return list("FreeMytourDAO.selectCounselQuesList", vo);
	}

	public int srchCounselQuesListCount(FaFitCounselQuesVO vo) throws Exception {
		// TODO Auto-generated method stub
		return (Integer) select("FreeMytourDAO.selectCounselQuesListCount", vo);
	}

	public void saveCounselQues(FaFitCounselQuesVO vo) throws Exception {
		// TODO Auto-generated method stub
		insert("FreeMytourDAO.insertCounselQues", vo);
	}

	public List srchCounselAnswList(FaFitCounselAnswVO vo) throws Exception {
		// TODO Auto-generated method stub
		return list("FreeMytourDAO.selectCounselAnswList", vo);
	}

	public List srchCounselAssortList(FaFitCounselAssortVO vo) throws Exception {
		// TODO Auto-generated method stub
		return list("FreeMytourDAO.selectCounselAssortList", vo);
	}
	
	public FaFitCounselAssortVO srchCounselAssort(FaFitCounselAssortVO vo) throws Exception {
		// TODO Auto-generated method stub
		return (FaFitCounselAssortVO) select("FreeMytourDAO.selectCounselAssort", vo);
	}
	
	public List selectComCode(ComCodeVO param) throws Exception {
		return (List) list("ReserveDAO.selectComCode", param);
	}
}
