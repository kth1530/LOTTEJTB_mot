package com.lottejtb.reserve.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.lottejtb.goods.service.EmsMailSendVO;
import com.lottejtb.member.service.CUMstVO;
import com.lottejtb.reserve.service.AirsBlockDTO;
import com.lottejtb.reserve.service.ComCodeVO;
import com.lottejtb.reserve.service.EtPriceDTO;
import com.lottejtb.reserve.service.ManagerDTO;
import com.lottejtb.reserve.service.ReserveRosterVO;
import com.lottejtb.reserve.service.ReserveService;
import com.lottejtb.reserve.service.ReserveVO;
import com.lottejtb.reserve.service.RvPerInfoHisVO;
import com.lottejtb.reserve.service.RvPerInfoVO;
import com.lottejtb.reserve.service.SmsVO;
import com.lottejtb.reserve.service.SyCdDetVO;
import com.lottejtb.reserve.service.UmsLogVO;


/**
* 클래스명    :  예약 관련 서비스  구현  클래스 
* @ClassDesc  : 예약 관련 서비스  구현  클래스 
* @FileName   : ReserveServiceImpl.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.28 /  / 최초작성
*/

@Service("ReserveService")
@SuppressWarnings("unchecked")
public class ReserveServiceImpl implements ReserveService {

	private Logger logger = Logger.getLogger(this.getClass());
	
    @Resource(name="ReserveDAO")
    private ReserveDAO reserveDAO;
    
	/** 예약 UI > 시스템 관련 코드 조회 **/
	public List srchComCode(ComCodeVO param) throws Exception {
		return reserveDAO.selectComCode(param);
	}
    
	/** 예약 UI > 업무 구분 코드 조회  **/
	public String srchGoodsOpCd(Map param) throws Exception {
		return reserveDAO.selectGoodsOpCd(param);
	}
	
	/** 에약 UI > 중복된 회원 정보 조회 **/
	public List checkDuplicatedMember(CUMstVO param) throws Exception {
		return reserveDAO.checkDuplicatedMember(param);
	}
	
	/** <!-- 예약 UI > 비회원인 고객 주문 > 중복 체크   --> **/
	public int checkDuplicatedMember2(CUMstVO param) throws Exception {
		return reserveDAO.checkDuplicatedMember2(param);
	}
	
	/** <!-- 예약 UI > 비회원인 고객 주문 > 고객 시퀀스 생성   --> **/
	public String srchCustCd(CUMstVO param) throws Exception {
		return reserveDAO.selectCustCd(param);
	}

	/** <!-- 예약 UI > 비회원인 고객 주문 > 고객 정보 등록  --> **/
	public void saveMember(CUMstVO param) throws Exception {
		reserveDAO.insertMember(param);
	}
	
	/** <!-- 예약 UI > 롯데 아이디 조회    --> **/
	public String srchLotteID(Map param) throws Exception {
		return reserveDAO.selectLotteID(param);
	}
	
	/** <!-- 예약 UI > 예약 번호  조회    --> **/
	public String srchResCd(Map param) throws Exception {
		return reserveDAO.selectResCd(param);
	}
	
	/** <!-- 예약 UI > 몰 관련 코드 조회    --> **/
	public SyCdDetVO srchMallCd(SyCdDetVO param) throws Exception {
		return reserveDAO.srchMallCd(param);
	}
	
	/** <!-- 예약 UI > 항공 블록수 조회     --> **/
	public AirsBlockDTO srchAirBlocks(AirsBlockDTO param) throws Exception {
		return reserveDAO.srchAirBlocks(param);
	}
	
	/** <!-- 예약 UI > 행사 담당자 정보 조회   --> **/
	public ManagerDTO srchEventManager(ManagerDTO param) throws Exception {
		return reserveDAO.selectEventManager(param);
	}
	
	/** <!-- 예약 UI > 예약 완료 상품 조회   --> **/
	public SyCdDetVO srchResconfirmGoods(SyCdDetVO param) throws Exception {
		return reserveDAO.selectResconfirmGoods(param);
	}
	
	/** <!-- 예약 UI > 행사 상품 가격 정보 조회   --> **/
	public EtPriceDTO srchPrices(EtPriceDTO param) throws Exception {
		return reserveDAO.selectPrices(param);
	}
	
	/** <!-- 예약 UI > 예약 마스터 프론트 용 정보 조회    --> **/
	public ReserveVO srchReserve(ReserveVO param) throws Exception {
		return reserveDAO.selectReserve(param);
	}
	/** <!-- 예약 UI > 제휴사 수수료 정보 조회     --> **/
	public int srchCoopCommRate(Map param) throws Exception {
		return reserveDAO.selectCoopCommRate(param);
	}
	
	/** <!-- 예약 UI > SMS 테이블의 시퀀스 조회      --> **/
	public int srchSmsSeq(Map param) throws Exception {
		return reserveDAO.selectSmsSeq(param);
	}
	
	/** <!-- 예약 UI > EMS 테이블의 시퀀스 조회      --> **/
	public int srchEmsMailSendSeq(Map param) throws Exception {
		return reserveDAO.selectEmsMailSendSeq(param);
	}
	
	
	/** <!-- 예약 UI > 고객 정보 조회 (프론트 일행용) --> **/
	public String srchCustCd02(Map param) throws Exception {
		return reserveDAO.selectCustCd02(param);
	}
	
	/** <!-- 예약 UI > 예약 정보 입력 --> **/
	public void saveReserve(ReserveVO param) throws Exception {
		reserveDAO.insertReserve(param);
	}
	
	/** <!-- 예약 UI > EMS 메일 보내기 --> **/
	public void saveEmsMailSend(EmsMailSendVO param) throws Exception {
		reserveDAO.insertEmsMailSend(param);
	}

	/** <!-- 예약 UI > SMS 발송 --> **/
	public void saveSmsSend(SmsVO param) throws Exception {
		reserveDAO.insertSmsSend(param);
	}
	
	/** <!-- 예약 UI > SMS 발송 --> **/
	public void saveKakaoSmsSend(SmsVO param) throws Exception {
		reserveDAO.insertKakaoSmsSend(param);
	}
		
	public String selectKakaoSmsSend(String res_cd) throws Exception{
		return reserveDAO.selectKakaoSmsSend(res_cd);
	};
	public String selectKakaoSmsSend2(String res_cd) throws Exception{
		return reserveDAO.selectKakaoSmsSend2(res_cd);
	};
	
	/** <!-- 예약 UI > UMS 로그 남기기  --> **/
	public void saveUmsLog(UmsLogVO param) throws Exception {
		reserveDAO.insertUmsLog(param);
	}
	
	/** <!-- 예약 UI > 예약 인원 현황 정보 입력 --> **/
	public void saveReserveRosters(ReserveRosterVO param) throws Exception {
		reserveDAO.insertReserveRoster(param);
	}
	
	/** <!-- 예약 UI > 예약 인원 현황 정보 수정 --> **/
	public void updateReserveRoster(ReserveRosterVO param) throws Exception {
		reserveDAO.updateReserveRoster(param);
	}
	
	/** <!-- 예약 UI > 예약 인원 정보 조회 --> **/
	public List srchReserveRosters(ReserveRosterVO param) throws Exception {
		return reserveDAO.selectReserveRosters(param);
	}

	@Override
	public void saveRvPerInfo(RvPerInfoVO param) throws Exception {
		// TODO Auto-generated method stub
		reserveDAO.insertRvPerInfo(param);
	}

	@Override
	public void saveRvPerInfoHis(RvPerInfoHisVO param) throws Exception {
		// TODO Auto-generated method stub
		reserveDAO.insertRvPerInfoHis(param);
	}
	
}
