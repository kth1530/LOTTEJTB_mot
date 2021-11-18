package com.lottejtb.front.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.lottejtb.framework.common.CommAbstractFreeDAO;
import com.lottejtb.front.air.service.ComNtCdVO;
import com.lottejtb.front.air.vo.AirCarrierCdVO;
import com.lottejtb.front.air.vo.AirPaxVO;
import com.lottejtb.front.air.vo.AirRsvMstVO;
import com.lottejtb.front.air.vo.AirSegmentVO;
import com.lottejtb.front.air.vo.AirTasfVO;
import com.lottejtb.front.air.vo.AirTlVO;
import com.lottejtb.front.air.vo.AirUSCityVO;
import com.lottejtb.front.service.ReqReserveVO;
import com.lottejtb.front.vo.PromotionVo;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("AirDAO")
public class AirDAO extends CommAbstractFreeDAO {
	
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;	
	
	public List<?> selectListCity (String sVal) {
		return list("CommCdCityDAO.selectCityList",sVal);
	}
	
	public ComNtCdVO selectNtCd (String sVal) {
		return (ComNtCdVO) select("CommNtCdDAO.selectAirNtCd", sVal);
	}
	
    /** 탑승자 정보 불러오기 */
    @SuppressWarnings("unchecked")
	public List<AirPaxVO> selectAirPaxInfo(ReqReserveVO vo) throws Exception{
        return (List<AirPaxVO>) list("AirDAO.selectAirPaxInfo",vo);
    }
    
    /** segment 정보 불러오기 */
    @SuppressWarnings("unchecked")
	public List<AirSegmentVO> selectAirSegInfo(ReqReserveVO vo) throws Exception{
        return (List<AirSegmentVO>) list("AirDAO.selectAirSegInfo",vo);
    }

	@SuppressWarnings("unchecked")
	public List<AirTasfVO> selectAirTasf (AirTasfVO vo) {
		return (List<AirTasfVO>) list("AirDAO.selectAirTasf",vo);
	}
	
	/** 전체 TASF 업데이트 */
	public void updateAirTotTasf(ReqReserveVO vo) throws Exception{
		update("AirDAO.updateAirTotTasf", vo);
	}
	
	/** 좌석명 가져오기 */
	public String selectCabinNm(String sVal) throws Exception{
        return (String) select("AirDAO.selectCabinNm",sVal);
    }
	
	/** 공항명 가져오기 */
	public String selectAirportNm(String sVal) throws Exception{
        return (String) select("AirDAO.selectAirportNm",sVal);
    }
	
	/** 공항명 가져오기 */
	public EgovMap selectApisVisaInfo(String arrCt) throws Exception{
        return (EgovMap) select("AirDAO.selectApisVisaInfo",arrCt);
    }
	
	/** 항공 예약 정보 가져오기 */
	public AirRsvMstVO selectAirMstInfo(AirRsvMstVO airVo) throws Exception{
        return (AirRsvMstVO) select("AirDAO.selectAirMstInfo",airVo);
    }
	
	/**
	 * 항공 예약 정보 삭제
	 */
	public int deleteAirRsvMst(ReqReserveVO airVo) throws Exception{
        return delete("AirDAO.deleteAirRsvMst",airVo);
    }
	
	/** 항공 예약 정보 가져오기 */
	@SuppressWarnings("unchecked")
	public List<PromotionVo> selectAirPromList(PromotionVo vo) throws Exception{
        return (List<PromotionVo>) list("AirDAO.selectAirPromList", vo);
    }
	
	/** 미주 지역 검색하기 */
	@SuppressWarnings("unchecked")
	public List<AirUSCityVO> selectUSCityList(String sVal) throws Exception{
        return (List<AirUSCityVO>) list("AirDAO.selectUSCityList",sVal);
    }
	
	/** 미주 지역 검색하기 */
	public AirTlVO selectPaymentTl(AirTlVO vo) throws Exception{
        return (AirTlVO) select("AirDAO.selectPaymentTl",vo);
    }	
	
	/** 적립 마일리지 항공사 리스트 조회 **/
	public List<AirCarrierCdVO> selectAirMileageList(AirCarrierCdVO vo) {
		return (List<AirCarrierCdVO>) list("AirDAO.selectAirMileageList",vo);
	}
	
	
}
