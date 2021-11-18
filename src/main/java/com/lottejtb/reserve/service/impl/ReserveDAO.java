package com.lottejtb.reserve.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.lottejtb.framework.common.CommAbstractDAO;
import com.lottejtb.goods.service.EmsMailSendVO;
import com.lottejtb.member.service.CUMstVO;
import com.lottejtb.reserve.service.AirsBlockDTO;
import com.lottejtb.reserve.service.ComCodeVO;
import com.lottejtb.reserve.service.EtPriceDTO;
import com.lottejtb.reserve.service.ManagerDTO;
import com.lottejtb.reserve.service.ReserveRosterVO;
import com.lottejtb.reserve.service.ReserveVO;
import com.lottejtb.reserve.service.RvPerInfoHisVO;
import com.lottejtb.reserve.service.RvPerInfoVO;
import com.lottejtb.reserve.service.SmsVO;
import com.lottejtb.reserve.service.SyCdDetVO;
import com.lottejtb.reserve.service.UmsLogVO;

@Repository("ReserveDAO")
public class ReserveDAO extends CommAbstractDAO {

	/** 예약 UI > 시스템 관련 코드 조회 **/
	public List selectComCode(ComCodeVO param) throws Exception {
		return (List) list("ReserveDAO.selectComCode", param);
	}
	
	/** 예약 UI > 업무 구분 코드 조회  **/
	public String selectGoodsOpCd(Map param) throws Exception {
		return (String) select("ReserveDAO.selectGoodsOpCd", param);
	}
	
	/** 에약 UI > 중복된 회원 정보 조회 **/
	public List checkDuplicatedMember(CUMstVO param) throws Exception {
		return (List) select("ReserveDAO.checkDuplicatedMember", param);
	}
	
	/** <!-- 예약 UI > 비회원인 고객 주문 > 중복 체크   --> **/
	public int checkDuplicatedMember2(CUMstVO param) throws Exception {
		return (Integer) select("ReserveDAO.checkDuplicatedMember2", param);
	}
	
	/** <!-- 예약 UI > 비회원인 고객 주문 > 고객 시퀀스 생성   --> **/
	public String selectCustCd(CUMstVO param) throws Exception {
		return (String) select("ReserveDAO.selectCustCd", param);
	}

	/** <!-- 예약 UI > 비회원인 고객 주문 > 고객 정보 등록  --> **/
	public void insertMember(CUMstVO param) throws Exception {
		insert("ReserveDAO.insertMember", param);
	}
	
	/** <!-- 예약 UI > 롯데 아이디 조회    --> **/
	public String selectLotteID(Map param) throws Exception {
		return (String) select("ReserveDAO.selectLotteID", param);
	}
	
	/** <!-- 예약 UI > 예약 번호  조회    --> **/
	public String selectResCd(Map param) throws Exception {
		return (String) select("ReserveDAO.selectResCd", param);
	}
	
	/** <!-- 예약 UI > 행사 담당자 정보 조회   --> **/
	public ManagerDTO selectEventManager(ManagerDTO param) throws Exception {
		return (ManagerDTO) select("ReserveDAO.selectEventManager", param);
	}
	
	/** <!-- 예약 UI > 몰 관련 코드 조회    --> **/
	public SyCdDetVO srchMallCd(SyCdDetVO param) throws Exception {
		return (SyCdDetVO) select("ReserveDAO.selectMallCd", param);
	}
	
	/** <!-- 예약 UI > 항공 블록수 조회     --> **/
	public AirsBlockDTO srchAirBlocks(AirsBlockDTO param) throws Exception {
		return (AirsBlockDTO) select("ReserveDAO.selectAirsBlocks", param);
	}
	
	/** <!-- 예약 UI > 예약 완료 상품 조회   --> **/
	public SyCdDetVO selectResconfirmGoods(SyCdDetVO param) throws Exception {
		return (SyCdDetVO) select("ReserveDAO.selectResconfirmGoods", param);
	}
	
	/** <!-- 예약 UI > 행사 상품 가격 정보 조회   --> **/
	public EtPriceDTO selectPrices(EtPriceDTO param) throws Exception {
		return (EtPriceDTO) select("ReserveDAO.selectPrices", param);
	}
	
	/** <!-- 예약 UI > 예약 마스터 프론트 용 정보 조회    --> **/
	public ReserveVO selectReserve(ReserveVO param) throws Exception {
		return (ReserveVO) select("ReserveDAO.selectReserve", param);
	}
	/** <!-- 예약 UI > 제휴사 수수료 정보 조회     --> **/
	public int selectCoopCommRate(Map param) throws Exception {
		return (Integer) select("ReserveDAO.selectCoopCommRate", param);
	}
	
	/** <!-- 예약 UI > SMS 테이블의 시퀀스 조회      --> **/
	public int selectSmsSeq(Map param) throws Exception {
		return (Integer) select("ReserveDAO.selectSmsSeq", param);
	}
	
	/** <!-- 예약 UI > EMS 테이블의 시퀀스 조회      --> **/
	public int selectEmsMailSendSeq(Map param) throws Exception {
		return (Integer) select("ReserveDAO.selectEmsMailSendSeq", param);
	}
	
	
	/** <!-- 예약 UI > 고객 정보 조회 (프론트 일행용) --> **/
	public String selectCustCd02(Map param) throws Exception {
		return (String) select("ReserveDAO.selectCustCd02", param);
	}
	
	/** <!-- 예약 UI > 예약 정보 입력 --> **/
	public void insertReserve(ReserveVO param) throws Exception {
		insert("ReserveDAO.insertReserve", param);
	}	
	
	/** <!-- 예약 UI > 예약 인원 현황 정보 입력 --> **/
	public void insertReserveRoster(ReserveRosterVO param) throws Exception {
		insert("ReserveDAO.insertReserveRoster", param);
	}	
	
	/** <!-- 예약 UI > EMS 메일 보내기 --> **/
	public void insertEmsMailSend(EmsMailSendVO param) throws Exception {
		insert("ReserveDAO.insertEmsMailSend", param);
	}

	/** <!-- 예약 UI > SMS 발송 --> **/
	public void insertSmsSend(SmsVO param) throws Exception {
		insert("ReserveDAO.insertSmsSend", param);
	}
	/** <!-- 예약 UI > SMS 발송 --> **/
	public void insertKakaoSmsSend(SmsVO param) throws Exception {
		insert("ReserveDAO.insertKakaoSmsSend", param);
	}
	/** <!-- 예약 UI > SMS 발송 --> **/
	public String selectKakaoSmsSend(String res_cd) throws Exception {
		return (String) select("ReserveDAO.selectKakaoSmsSend", res_cd);
	}
	/** <!-- 예약 UI > SMS 발송 --> **/
	public String selectKakaoSmsSend2(String res_cd) throws Exception {
		return (String) select("ReserveDAO.selectKakaoSmsSend2", res_cd);
	}
	
	/** <!-- 예약 UI > UMS 로그 남기기  --> **/
	public void insertUmsLog(UmsLogVO param) throws Exception {
		insert("ReserveDAO.insertUmsLog", param);
	}
	
	/** <!-- 예약 UI > 예약 인원 현황 정보 수정 --> **/
	public void updateReserveRoster(ReserveRosterVO param) throws Exception {
		update("ReserveDAO.updateReserveRoster", param);
	}	
	
	/** <!-- 예약 UI > 예약 인원 정보 조회 --> **/
	public List selectReserveRosters(ReserveRosterVO param) throws Exception {
		return (List) list("ReserveDAO.selectReserveRosters", param);
	}

	/** <!-- 예약 UI > 마케팅 및 14세 미만 동의 여부 저장  --> **/
	public void insertRvPerInfo(RvPerInfoVO param) throws Exception {
		insert("ReserveDAO.insertRvPerInfo", param);
	}	
	
	/** <!-- 예약 UI > 마케팅 및 14세 미만 동의 여부 저장  --> **/
	public void insertRvPerInfoHis(RvPerInfoHisVO param) throws Exception {
		insert("ReserveDAO.insertRvPerInfoHis", param);
	}		
}
