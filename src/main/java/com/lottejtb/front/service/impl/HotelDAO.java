package com.lottejtb.front.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.lottejtb.framework.common.CommAbstractFreeDAO;
import com.lottejtb.front.hotel.service.HotelLotteVO;
import com.lottejtb.front.hotel.service.HotelPaymentVO;
import com.lottejtb.front.hotel.service.HotelVO;
import com.lottejtb.front.hotel.service.ReqHotelReserveCancelVO;
import com.lottejtb.front.hotel.service.RsvHtlInfoVO;
import com.lottejtb.front.hotel.service.RsvHtlTravlerVO;
import com.lottejtb.front.service.SearchHotelCityVO;
import com.lottejtb.goods.service.EmsMailSendVO;
import com.lottejtb.prom.service.PromotionHtListVO;
import com.lottejtb.prom.service.PromotionParamVO;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("HotelDAO")
public class HotelDAO extends CommAbstractFreeDAO {

	public ArrayList<HotelVO> selectHotelInfo(HotelVO htlVo) {
		return null;
	}

	public ArrayList<HotelVO> selectCancelCerti(HotelVO htlVo) {
		return null;
	}
		
	public List<?> selectListCity (String sVal, String sDome) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		
		param.put("sVal", sVal);
		param.put("sDome", sDome);
		
		//return list("CommCdCityDAO.selectHotelCityList",param);
		return list("CommCdCityDAO.selectHotelCityList",sVal);
	}

	public List<EgovMap> selectRsvList(EgovMap map) {
        return (List<EgovMap>) list("HotelDAO.selectRsvList", map);
    }
	
	/* 예약 상세 호텔*/
	public List<RsvHtlInfoVO> selectRsvHtlInfo(RsvHtlInfoVO vo) {
		return (List<RsvHtlInfoVO>) list("HotelDAO.selectRsvHtlInfo", vo);
	}
	
	/* 예약 상세 호텔 숙박자정보*/
	public List<RsvHtlTravlerVO> selectRsvHtlTravler(RsvHtlTravlerVO vo) {
		return (List<RsvHtlTravlerVO>) list("HotelDAO.selectRsvHtlTravler", vo);
	}
	
	/* 호텔 예약 취소 */
	public List<ReqHotelReserveCancelVO> selectRsvHtlCancelInfo(ReqHotelReserveCancelVO vo) {
		return (List<ReqHotelReserveCancelVO>) list("HotelDAO.selectRsvHtlCancelInfo", vo);
	}

	public ArrayList<HashMap<String, Object>> selectHotelEnList(HashMap<String, Object> param){
		return (ArrayList<HashMap<String, Object>>) list("HotelDAO.selectHotelEnList", param);
	}

	
	public Float selectDestiCurrency(String vo) {
		return (Float) select("HotelDAO.selectDestiCurrency" , vo);
	}

	public List<PromotionHtListVO> getPromoHtlAmt(PromotionHtListVO vo) throws Exception{
		return (List<PromotionHtListVO>) list("HotelDAO.getPromoHtl", vo);
	}
	
	//호텔 결제 내역
	public List<HotelPaymentVO> selectHtlPaymentInfo(String resNo){ 
		return (List<HotelPaymentVO>) list("HotelDAO.selectHtlPaymentInfo", resNo);
	}
	
	public List<HotelLotteVO> selectLotteHtlList(HotelLotteVO vo) throws Exception {
		return (List<HotelLotteVO>) list("HotelDAO.selectLotteHtlList", vo);
	}
	
	public void insertEmsMailSend(EmsMailSendVO vo) throws Exception {
		insert("HotelDAO.insertEmsMailSend",vo);
	}
	
	public String hotelIdMapping(EgovMap param) throws Exception {
		return (String) select("HotelDAO.hotelIdMapping", param);
	}
	
	public EgovMap selectTelInfo(String hotelId) {
		return (EgovMap) select("HotelDAO.selectTelInfo", hotelId);
	}

	public List<SearchHotelCityVO> selectListDomeCityCd() throws Exception {
		return (List<SearchHotelCityVO>) list("CommCdCityDAO.selectListDomeCityCd");
	}

	public List<SearchHotelCityVO> selectListDomeCityCdDetail() {
		return (List<SearchHotelCityVO>) list("CommCdCityDAO.selectListDomeCityCdDetail");
	}
	
}
