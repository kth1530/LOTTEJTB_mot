package com.lottejtb.mytour.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lottejtb.mytour.service.AirRsvCounselVO;
import com.lottejtb.mytour.service.ComCodeVO;
import com.lottejtb.mytour.service.FaFitCounselAnswVO;
import com.lottejtb.mytour.service.FaFitCounselAssortVO;
import com.lottejtb.mytour.service.FaFitCounselQuesVO;
import com.lottejtb.mytour.service.MytourService;
import com.lottejtb.mytour.service.MytourVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("MytourService")
public class MytourServiceImpl extends EgovAbstractServiceImpl implements MytourService{
	@Resource(name="MytourDAO")
    private MytourDAO mytourDAO;
	
	@Resource(name="FreeMytourDAO")
    private FreeMytourDAO freeMytourDAO;
	
	@Override
	public List<MytourVO> myReservationList(MytourVO vo) throws Exception{
		return mytourDAO.myReservationList(vo);
	}
	
	@Override
	public List<MytourVO> myReservationDateList(MytourVO vo) throws Exception{
		return mytourDAO.myReservationDateList(vo);
	}
	
	@Override
	public List<MytourVO> myCancelReservationList(MytourVO vo) throws Exception{
		return mytourDAO.myCancelReservationList(vo);
	}
	
	@Override
	public HashMap<String, List> freeReserve(MytourVO vo) throws Exception{
		return mytourDAO.freeReserve(vo);
	}
	
	@Override
	public HashMap<String, List> freeCancelReserve(MytourVO vo) throws Exception{
		return mytourDAO.freeCancelReserve(vo);
	}
	
	@Override
	public int choiceGoodsCount(MytourVO vo) throws Exception{
		return mytourDAO.choiceGoodsCount(vo);
	}
	
	@Override
	public List choiceGoodsList(MytourVO vo) throws Exception{
		return mytourDAO.choiceGoodsList(vo);
	}
    
	@Override
	public int myEventCount(MytourVO vo) throws Exception {
		return mytourDAO.myEventCount(vo);
	}
	
	@Override
	public List myEventList(MytourVO vo) throws Exception {
		return mytourDAO.myEventList(vo);
	}
	
	@Override
	public HashMap<String, List> nonMemberResList(MytourVO vo) throws Exception{
		return mytourDAO.nonMemberResList(vo);
	}
	
	@Override
	public HashMap<String, Object> selectLottePointSeq() throws Exception{
		return mytourDAO.selectLottePointSeq();
	}
	
	@Override
	public void insertLottePointSeq() throws Exception{
		mytourDAO.insertLottePointSeq();
	}
	
	@Override
	public void updateLottePointSeq() throws Exception{
		mytourDAO.updateLottePointSeq();
	}
	
	@Override
	public void delectSelChoiceGoods(MytourVO vo) throws Exception{
		mytourDAO.delectSelChoiceGoods(vo);
	}
	
	@Override
	public void delectAllChoiceGoods(MytourVO vo) throws Exception{
		mytourDAO.delectAllChoiceGoods(vo);
	}
	
	@Override
	public List srchAirCounselList(AirRsvCounselVO vo) throws Exception {
		// TODO Auto-generated method stub
		return freeMytourDAO.srchAirCounselList(vo);
	}

	@Override
	public void saveAirCounsel(AirRsvCounselVO vo) throws Exception {
		// TODO Auto-generated method stub
		freeMytourDAO.saveAirCounsel(vo);
	}

	@Override
	public int srchAirCounselListCount(AirRsvCounselVO vo) throws Exception {
		// TODO Auto-generated method stub
		return freeMytourDAO.srchAirCounselListCount(vo);
	}

	@Override
	public List srchCounselQuesList(FaFitCounselQuesVO vo) throws Exception {
		// TODO Auto-generated method stub
		return freeMytourDAO.srchCounselQuesList(vo);
	}

	@Override
	public int srchCounselQuesListCount(FaFitCounselQuesVO vo) throws Exception {
		// TODO Auto-generated method stub
		return freeMytourDAO.srchCounselQuesListCount(vo);
	}

	@Override
	public void saveCounselQues(FaFitCounselQuesVO vo) throws Exception {
		// TODO Auto-generated method stub
		freeMytourDAO.saveCounselQues(vo);
	}

	@Override
	public List srchCounselAnswList(FaFitCounselAnswVO vo) throws Exception {
		// TODO Auto-generated method stub
		return freeMytourDAO.srchCounselAnswList(vo);
	}

	@Override
	public List srchCounselAssortList(FaFitCounselAssortVO vo) throws Exception {
		// TODO Auto-generated method stub
		return freeMytourDAO.srchCounselAssortList(vo);
	}

	@Override
	public List srchComCode(ComCodeVO param) throws Exception {
		// TODO Auto-generated method stub
		return freeMytourDAO.selectComCode(param);
	}

	@Override
	public FaFitCounselAssortVO srchCounselAssort(FaFitCounselAssortVO vo)
			throws Exception {
		// TODO Auto-generated method stub
		return freeMytourDAO.srchCounselAssort(vo);
	}
}
