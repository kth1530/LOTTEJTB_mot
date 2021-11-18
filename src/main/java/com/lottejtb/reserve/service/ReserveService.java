package com.lottejtb.reserve.service;

import java.util.List;
import java.util.Map;

import com.lottejtb.goods.service.EmsMailSendVO;
import com.lottejtb.member.service.CUMstVO;


/**
* 클래스명    :  예약 관련 서비스를 정의한 인터페이스  
* @ClassDesc  : 예약 관련 서비스를 정의한 인터페이스  
* @FileName   : ReserveService.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.25 /  / 최초작성
*/

public interface ReserveService {
	/** 예약 UI > 시스템 관련 코드 조회 **/
	public List srchComCode(ComCodeVO param) throws Exception;
	
	/** 예약 UI > 업무 구분 코드 조회  **/
	public String srchGoodsOpCd(Map param) throws Exception;
	
	/** 에약 UI > 중복된 회원 정보 조회 **/
	public List checkDuplicatedMember(CUMstVO param) throws Exception;
	
	/** <!-- 예약 UI > 비회원인 고객 주문 > 중복 체크   --> **/
	public int checkDuplicatedMember2(CUMstVO param) throws Exception;
	
	/** <!-- 예약 UI > 비회원인 고객 주문 > 고객 시퀀스 생성   --> **/
	public String srchCustCd(CUMstVO param) throws Exception;
	
	/** <!-- 예약 UI > 롯데 아이디 조회    --> **/
	public String srchLotteID(Map param) throws Exception;
	
	/** <!-- 예약 UI > 예약 번호  조회    --> **/
	public String srchResCd(Map param) throws Exception;
	
	/** <!-- 예약 UI > 행사 담당자 정보 조회   --> **/
	public ManagerDTO srchEventManager(ManagerDTO param) throws Exception;
	
	/** <!-- 예약 UI > 몰 관련 코드 조회    --> **/
	public SyCdDetVO srchMallCd(SyCdDetVO param) throws Exception;
	
	/** <!-- 예약 UI > 항공 블록수 조회     --> **/
	public AirsBlockDTO srchAirBlocks(AirsBlockDTO param) throws Exception;
	
	/** <!-- 예약 UI > 예약 완료 상품 조회   --> **/
	public SyCdDetVO srchResconfirmGoods(SyCdDetVO param) throws Exception;
	
	/** <!-- 예약 UI > 행사 상품 가격 정보 조회   --> **/
	public EtPriceDTO srchPrices(EtPriceDTO param) throws Exception;
	
	/** <!-- 예약 UI > 예약 마스터 프론트 용 정보 조회    --> **/
	public ReserveVO srchReserve(ReserveVO param) throws Exception;
	
	/** <!-- 예약 UI > 제휴사 수수료 정보 조회     --> **/
	public int srchCoopCommRate(Map param) throws Exception;
	
	/** <!-- 예약 UI > 고객 정보 조회 (프론트 일행용) --> **/
	public String srchCustCd02(Map param) throws Exception;

	/** <!-- 예약 UI > 비회원인 고객 주문 > 고객 정보 등록  --> **/
	public void saveMember(CUMstVO param) throws Exception;

	/** <!-- 예약 UI > 예약 정보 입력 --> **/
	public void saveReserve(ReserveVO param) throws Exception;
	
	/** <!-- 예약 UI > EMS 메일 보내기 --> **/
	public void saveEmsMailSend(EmsMailSendVO param) throws Exception;

	/** <!-- 예약 UI > SMS 발송 --> **/
	public void saveSmsSend(SmsVO param) throws Exception;
	
	/** <!-- 예약 UI > SMS 발송 --> **/
	public void saveKakaoSmsSend(SmsVO param) throws Exception;
	/** <!-- 예약 UI > 고객 정보 조회 (프론트 일행용) --> **/
	public String selectKakaoSmsSend(String res_cd) throws Exception;
	
	public String selectKakaoSmsSend2(String res_cd) throws Exception;
		
	/** <!-- 예약 UI > UMS 로그 남기기  --> **/
	public void saveUmsLog(UmsLogVO param) throws Exception;
	
	/** <!-- 예약 UI > 예약 인원 현황 정보 입력 --> **/
	public void saveReserveRosters(ReserveRosterVO param) throws Exception;	

	/** <!-- 예약 UI > 예약 인원 현황 정보 수정 --> **/
	public void updateReserveRoster(ReserveRosterVO param) throws Exception;
	
	/** <!-- 예약 UI > 예약 인원 정보 조회 --> **/
	public List srchReserveRosters(ReserveRosterVO param) throws Exception;
	
	/** <!-- 예약 UI > SMS 테이블의 시퀀스 조회      --> **/
	public int srchSmsSeq(Map param) throws Exception;
	
	/** <!-- 예약 UI > EMS 테이블의 시퀀스 조회      --> **/
	public int srchEmsMailSendSeq(Map param) throws Exception;
		
	/** <!-- 예약 UI > 마케팅 및 14세 미만 동의 여부 --> **/
	public void saveRvPerInfo(RvPerInfoVO param) throws Exception;	
	
	/** <!-- 예약 UI > 마케팅 및 14세 미만 동의 여부 --> **/
	public void saveRvPerInfoHis(RvPerInfoHisVO param) throws Exception;		
}
