package com.lottejtb.front.service;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONObject;

import com.lottejtb.api.service.FUHTI0001VO;
import com.lottejtb.api.service.FUHTI0002VO;
import com.lottejtb.api.service.FUHTI0003VO;
import com.lottejtb.front.hotel.service.ReqHotelInfoVO;
import com.lottejtb.front.hotel.service.ReqHotelReserveVO;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface HotelService {
	FUHTI0001VO selectListHotel (ReqHotelVO htlVo) throws Exception;
	FUHTI0002VO selectListHotelRoom (ReqHotelRoomVO htlVo) throws Exception;
	FUHTI0003VO selectListHotelInfo(ReqHotelInfoVO htlVO) throws Exception;
	//ArrayList<HotelVO> selectHotelInfo (HotelVO htlVo) throws Exception;
	ArrayList<HotelVO> selectCancelCerti (HotelVO htlVo) throws Exception;
	List<?> selectListCity (String sVal) throws Exception;
	JSONObject getRadarJsonData(ReqMapRadarVO mapVo) throws Exception;
	JSONObject getRadarDetailData(ReqMapRadarVO mapVo) throws Exception; 
	JSONObject getCityLarlon(ReqMapRadarVO mapVo) throws Exception;
	List<EgovMap> selectRsvList(EgovMap map) throws Exception;
	JSONObject reqHotelReserve(ReqHotelReserveVO hotelReserve, String custCd) throws Exception;
	
}
