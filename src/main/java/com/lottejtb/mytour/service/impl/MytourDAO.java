package com.lottejtb.mytour.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.lottejtb.comm.service.CommExchangeVO;
import com.lottejtb.framework.common.CommAbstractDAO;
import com.lottejtb.mytour.service.MytourVO;

@Repository("MytourDAO")
public class MytourDAO extends CommAbstractDAO{
	@Resource(name="sqlMapClient_free")
	SqlMapClient sqlMapClient_free;
	
	public List<MytourVO> myReservationList(MytourVO vo) throws Exception{
		return (List<MytourVO>) list("MytourDAO.myReservationList", vo);
	}
	
	public List<MytourVO> myReservationDateList(MytourVO vo) throws Exception{
		return (List<MytourVO>) list("MytourDAO.myReservationDateList", vo);
	}
	
	public List<MytourVO> myCancelReservationList(MytourVO vo) throws Exception{
		return (List<MytourVO>) list("MytourDAO.myCancelReservationList", vo);
	}
	
	public HashMap<String, List> freeReserve(MytourVO vo) throws Exception{
		HashMap<String, List> result = new HashMap<String, List>();
		List reserveMst;
		List reserveAir;
		List reserveHtl;
		List reserveRnt;
		
		reserveMst = sqlMapClient_free.queryForList("FreeMytourDAO.selectFreeMstReserve", vo);
		reserveAir = sqlMapClient_free.queryForList("FreeMytourDAO.selecrFreeAirReserve", vo);
		reserveHtl = sqlMapClient_free.queryForList("FreeMytourDAO.selectFreeHtlReserve", vo);
		reserveRnt = sqlMapClient_free.queryForList("FreeMytourDAO.selectFreeRntReserve", vo);
		
		result.put("mst", reserveMst);
		result.put("air", reserveAir);
		result.put("htl", reserveHtl);
		result.put("rnt", reserveRnt);
		
		return result;
	}
	
	public HashMap<String, List> freeCancelReserve(MytourVO vo) throws Exception{
		HashMap<String, List> result = new HashMap<String, List>();
		List reserveMst;
		List reserveAir;
		List reserveHtl;
		List reserveRnt;
		
		reserveMst = sqlMapClient_free.queryForList("FreeMytourDAO.selectFreeMstCancelReserve", vo);
		reserveAir = sqlMapClient_free.queryForList("FreeMytourDAO.selecrFreeAirCancelReserve", vo);
		reserveHtl = sqlMapClient_free.queryForList("FreeMytourDAO.selectFreeHtlCancelReserve", vo);
		reserveRnt = sqlMapClient_free.queryForList("FreeMytourDAO.selectFreeRntCancelReserve", vo);
		
		result.put("mst", reserveMst);
		result.put("air", reserveAir);
		result.put("htl", reserveHtl);
		result.put("rnt", reserveRnt);
		
		return result;
	}
	
	public int choiceGoodsCount(MytourVO vo) throws Exception{
		return (Integer) select("MytourDAO.choiceGoodsCount",vo);
    }
    
	public List choiceGoodsList(MytourVO vo) throws Exception{
		return list("MytourDAO.choiceGoodsList",vo);
    }
	
	public int myEventCount(MytourVO vo) throws Exception{
		return (Integer) select("MytourDAO.myEventCount",vo);
    }
    
	public List myEventList(MytourVO vo) throws Exception{
		return list("MytourDAO.myEventList",vo);
    }
	
	public HashMap<String, List> nonMemberResList(MytourVO vo) throws Exception{
		HashMap<String, List> result = new HashMap<String, List>();
		ArrayList<HashMap<String, Object>> subList = new ArrayList<HashMap<String, Object>>();
		ArrayList<HashMap<String, Object>> airList = new ArrayList<HashMap<String, Object>>();
		ArrayList<HashMap<String, Object>> htlList = new ArrayList<HashMap<String, Object>>();
		ArrayList<HashMap<String, Object>> rntList = new ArrayList<HashMap<String, Object>>();
		
		result.put("package", list("MytourDAO.nonMemberResList",vo));
		
		result.put("mst", sqlMapClient_free.queryForList("FreeMytourDAO.selectFreeMstReserveForReserveNo", vo));
		result.put("air", sqlMapClient_free.queryForList("FreeMytourDAO.selecrFreeAirReserveForReserveNo", vo));
		result.put("htl", sqlMapClient_free.queryForList("FreeMytourDAO.selectFreeHtlReserveForReserveNo", vo));
		result.put("rnt", sqlMapClient_free.queryForList("FreeMytourDAO.selectFreeRntReserveForReserveNo", vo));
		
		/*
		if(list.size() == 0){
			//list = sqlMapClient_free.queryForList("", vo);
		}
		*/
		
		return result; 
    }
	
	public HashMap<String, Object> selectLottePointSeq() throws Exception{
		return (HashMap<String, Object>) select("MytourDAO.selectLottePointSeq");
    }
	
	public void insertLottePointSeq() throws Exception{
		insert("MytourDAO.insertLottePointSeq");
    }
	
	public void updateLottePointSeq() throws Exception{
		insert("MytourDAO.updateLottePointSeq");
    }
	
	public void delectSelChoiceGoods(MytourVO vo) throws Exception{
		update("MytourDAO.delectSelChoiceGoods", vo);
	}
	
	public void delectAllChoiceGoods(MytourVO vo) throws Exception{
		update("MytourDAO.delectAllChoiceGoods", vo);
	}
}