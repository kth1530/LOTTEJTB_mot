package com.lottejtb.front.hotel.service;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONObject;

import com.lottejtb.api.service.FUHTI0001VO;
import com.lottejtb.api.service.FUHTI0002VO;
import com.lottejtb.api.service.FUHTI0003VO;
import com.lottejtb.api.service.FUHTI0006VO;
import com.lottejtb.front.service.SearchHotelCityVO;
import com.lottejtb.goods.service.EmsMailSendVO;
import com.lottejtb.prom.service.PromotionHtListVO;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface HotelService {
	FUHTI0001VO selectListHotel (ReqHotelVO htlVo,String custCd) throws Exception;
	FUHTI0002VO selectListHotelRoom (ReqHotelRoomVO htlVo,String custCd) throws Exception;
	FUHTI0003VO selectListHotelInfo (ReqHotelInfoVO htlVo,String custCd) throws Exception;
	FUHTI0006VO getCancelPolicy (ReqHotelCancelPolicy htlCp, String custCd) throws Exception;
	ArrayList<HotelVO> selectHotelInfo(HotelVO htlVo) throws Exception;
	ArrayList<HotelVO> selectCancelCerti(HotelVO htlVo) throws Exception;
	List<?> selectListCity (String sVal, String sDome) throws Exception;
	JSONObject getRadarJsonData(ReqMapRadarVO mapVo) throws Exception;
	JSONObject getRadarDetailData(ReqMapRadarVO mapVo) throws Exception; 
	JSONObject getCityLarlon(ReqMapRadarVO mapVo) throws Exception;
	List<EgovMap> selectRsvList(EgovMap map) throws Exception;
	List<RsvHtlInfoVO>selectRsvHtlInfo(RsvHtlInfoVO vo) throws Exception;
	List<RsvHtlTravlerVO>selectRsvHtlTravler(RsvHtlTravlerVO vo) throws Exception;
	List<ReqHotelReserveCancelVO> selectRsvHtlCancelInfo(ReqHotelReserveCancelVO vo) throws Exception;
	List<HotelPaymentVO> selectHtlPaymentInfo(String resNo) throws Exception;
	List<HotelLotteVO> selectLotteHtlList(HotelLotteVO vo) throws Exception;
	
	JSONObject reqHotelReserve(ReqHotelRerveInputVO hotelReserve, String fitRsvNo, String custCd) throws Exception;
	JSONObject reqHotelReserveCancel(ReqHotelReserveCancelVO hotelReserve, String fitRsvNo, String custCd) throws Exception;
	
	//호텔추천 메일보내기*
	void saveEmsMailSend(EmsMailSendVO param) throws Exception;
	String hotelIdMapping(EgovMap param) throws Exception;
	List<PromotionHtListVO> getPromotion(PromotionHtListVO promVO) throws Exception;
	List<SearchHotelCityVO> selectListDomeCityCd() throws Exception;
	List<SearchHotelCityVO> selectListDomeCityCdDetail() throws Exception;
}
