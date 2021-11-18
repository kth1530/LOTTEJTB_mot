package com.lottejtb.front.air.service;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.lottejtb.api.service.FUARI0001VO;
import com.lottejtb.api.service.FUARI0002VO;
import com.lottejtb.api.service.FUARI0005VO;
import com.lottejtb.api.service.FUARI0006VO;
import com.lottejtb.front.air.vo.AirCarrierCdVO;
import com.lottejtb.front.air.vo.AirPaxVO;
import com.lottejtb.front.air.vo.AirSegmentVO;
import com.lottejtb.front.air.vo.AirTasfVO;
import com.lottejtb.front.air.vo.ReqAirInfoVO;
import com.lottejtb.front.air.vo.ReqAirListVO;
import com.lottejtb.front.service.ReqAccAddressVO;
import com.lottejtb.front.service.ReqAccContactVO;
import com.lottejtb.front.service.ReqAccMileageVO;
import com.lottejtb.front.service.ReqAccPassportVO;
import com.lottejtb.front.service.ReqReserveVO;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface AirService {
	public  JSONObject selectListAirFare2 (ReqAirListVO reqVo, String userCode) throws Exception;
	public  FUARI0002VO selectListAirFare (ReqAirListVO reqVo, String userCode) throws Exception;
	public  JSONObject selectAirPricing2 (ReqAirInfoVO reqVo, String userCode) throws Exception;
	public  FUARI0006VO selectAirPricing (ReqAirInfoVO reqVo, String userCode) throws Exception;
	public  JSONArray selectFlightInfo2 (ReqAirInfoVO reqVo, String userCode) throws Exception;
	public  ArrayList<FUARI0005VO> selectFlightInfo (ReqAirInfoVO reqVo, String userCode) throws Exception;
	public  JSONObject selectAirfareCerti2 (JSONObject reqVo, String userCode) throws Exception;
	public  JSONObject selectPnrAirfareCerti(ReqAirPnrInfoVO reqVo, String userCode) throws Exception;
	public  JSONObject selectAirRsvSync(ReqAirRsvSyncVO reqVo, String userCode) throws Exception;
	
	public  FUARI0001VO selectAirfareCerti (ReqAirInfoVO reqVo, String userCode) throws Exception;
	public  List<?> selectListCity (String sVal) throws Exception;
	public  ComNtCdVO selectNtCd (String sVal) throws Exception;
	
	public  List<AirPaxVO> selectAirPaxInfo(ReqReserveVO vo) throws Exception;
	public  List<AirSegmentVO> selectAirSegInfo(ReqReserveVO vo) throws Exception;
	public  List<AirTasfVO> selectAirTasf (AirTasfVO vo) throws Exception;
	
	public  String selectCabinNm(String sVal) throws Exception;
	public  String selectAirportNm(String sVal) throws Exception;
	public  EgovMap selectApisVisaInfo(String arrCt) throws Exception;
	
	public  JSONObject reqAirReserve (com.lottejtb.front.air.service.ReqAirReserveVO reqVO, String userCode) throws Exception;
	public  JSONObject saveAirMileage (ReqAccMileageVO reqVO, String userCode) throws Exception;
	public  JSONObject saveAirPassport (ReqAccPassportVO reqVO, String userCode) throws Exception;
	public  JSONObject saveAirContact (ReqAccContactVO reqVO, String userCode) throws Exception;
	public  JSONObject saveAirAddress (ReqAccAddressVO reqVO, String userCode) throws Exception;
	public  JSONObject reqAirReserveCancel (ReqAirReserveCancelVO reqVO, String userCode) throws Exception;
	public  JSONObject getAirSellDate(String userCode) throws Exception;
	
	public  List<AirCarrierCdVO> selectAirMileageList (AirCarrierCdVO vo) throws Exception;
}
