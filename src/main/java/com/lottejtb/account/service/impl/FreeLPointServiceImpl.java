package com.lottejtb.account.service.impl;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.CharBuffer;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.inicis.inipay.INIpay;
import com.inicis.std.util.HttpUtil;
import com.inicis.std.util.ParseUtil;
import com.inicis.std.util.SignatureUtil;
import com.lottejtb.account.service.AirActPaymtVO;
import com.lottejtb.account.service.AirReceiptReqVO;
import com.lottejtb.account.service.AirRsvPaymtVO;
import com.lottejtb.account.service.FaFitCashReceiptVO;
import com.lottejtb.account.service.FaFitPaymtInfVO;
import com.lottejtb.account.service.FaFitRsvMstVO;
import com.lottejtb.account.service.FreeLPointService;
import com.lottejtb.account.service.HtlActPaymtVO;
import com.lottejtb.account.service.HtlCardPaymtVO;
import com.lottejtb.account.service.HtlEtcPaymtVO;
import com.lottejtb.account.service.HtlGiftPaymtVO;
import com.lottejtb.account.service.LPointVO;
import com.lottejtb.account.service.PaymentVO;
import com.lottejtb.account.service.PointHistoryVO;
import com.lottejtb.account.service.PointMstVO;
import com.lottejtb.account.service.RvPaymentVO;
import com.lottejtb.account.service.VAcctDepoNotiVO;
import com.lottejtb.comm.util.DateUtil;
import com.lottejtb.comm.util.StringUtil;
import com.lottejtb.util.LottePointTcpClient;
import com.lottejtb.util.Util;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("FreeLPointService")
public class FreeLPointServiceImpl extends EgovAbstractServiceImpl implements FreeLPointService {	
	@Resource(name="FreeLPointDAO")
	private FreeLPointDAO freeLpointDao;

	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @Override
	public LPointVO getLPointAvailable (String cno) throws Exception{
    	
    	LPointVO resultVo = new LPointVO();
    	HashMap<String, Object> result = new HashMap<String, Object>();
    	String tradeNo		=	"";
    	String returnCode	=	"";
    	String cardNo		=	"";
    	
		String tempNo = "";
		StringBuilder tempNoSb = new StringBuilder();
		for(int i=0; i < (10 - (cno.trim()).length());i++){
			tempNoSb.append("0");
			//tempNo += "0";
		}
		cno = tempNoSb + (cno.trim());
		
		result = freeLpointDao.selectLottePointSeq();

		if(result.get("TRADE_NO").toString().equals("00000")){
			freeLpointDao.insertLottePointSeq();
		}
		
		freeLpointDao.updateLottePointSeq();
		
		tradeNo = freeLpointDao.selectLottePointSeq().get("TRADE_NO").toString();
		
		if(!tradeNo.equals(null)){
			byte[] reqFixedText2001 = null;
			reqFixedText2001 = LottePointTcpClient.sendFixedText2000(tradeNo, cno, cardNo);
			
			byte[] Header2001 = new byte[73];
			byte[] Body2001 = new byte[955]; //신전문
			
			System.arraycopy(reqFixedText2001, 2, Header2001, 0, 73);
			System.arraycopy(reqFixedText2001, 75, Body2001, 0, 955); //신전문
			
			
			String strHeader2001 = new String(Header2001,"EUC-KR");
			String strBody2001 = new String(Body2001,"EUC-KR");
			
			if(!StringUtil.isEmpty(strHeader2001)){
				returnCode = strHeader2001.substring(47, 49);
			}
			
			if(!StringUtil.isEmpty(strBody2001)){
//				System.out.println("strBody2001:" + strBody2001);
				resultVo.setCode(returnCode); 								//리턴코드
				resultVo.setCardNum(strBody2001.substring(1, 38)) ; 		//카드번호
				resultVo.setUsePoint_str(strBody2001.substring(76, 85)); 	//가용포인트
				resultVo.setRemainPointType(strBody2001.substring(85, 86));	//잔여포인트부호
				resultVo.setRemainPoint_str(strBody2001.substring(86, 95));	//잔여포인트
				resultVo.setMessage1(strBody2001.substring(111, 167)); 		//메세지1
				resultVo.setMessage2(strBody2001.substring(175, 427)); 		//메세지2
			}
			
			if("22".equals(returnCode)){
        		System.out.println("롯데포인트 시스템장애");
        	}else if("44".equals(returnCode)){
        		System.out.println("롯데포인트 승인거절");
        	}else if("69".equals(returnCode)){
        		System.out.println("롯데포인트 자료불일치");
        	}else if("77".equals(returnCode)){
        		System.out.println("롯데포인트 전문오류");
        	}else if("88".equals(returnCode)){
        		System.out.println("롯데포인트 DB 미등록");
        	}else if("80".equals(returnCode)){
        		System.out.println("롯데포인트 운영사 DBMS 장애");
        	}else if("92".equals(returnCode)){
        		System.out.println("롯데포인트 Control 오류");
        	}else if("99".equals(returnCode)){
        		System.out.println("롯데포인트 시간초과 재시도 요망");
        	}else if(!"00".equals(returnCode)){
        		System.out.println("롯데포인트 시스템장애");
        	}
		}
		
		return resultVo;
	}
    
    
    @Override
	public LPointVO getLPointAuth (String cno, String cardNo, String pw) throws Exception{
    	
    	LPointVO resultVo = new LPointVO();
    	HashMap<String, Object> result = new HashMap<String, Object>();
    	String tradeNo		=	"";
    	String returnCode	=	"";
     	
		String tempNo = "";
		StringBuilder tempNoSb = new StringBuilder();
		for(int i=0; i < (10 - (cno.trim()).length());i++){
			//tempNo += "0";
			tempNoSb.append("0");
		}
		cno = tempNoSb.toString() + (cno.trim());
		
		result = freeLpointDao.selectLottePointSeq();

		if(result.get("TRADE_NO").toString().equals("00000")){
			freeLpointDao.insertLottePointSeq();
		}
		
		freeLpointDao.updateLottePointSeq();
		
		tradeNo = freeLpointDao.selectLottePointSeq().get("TRADE_NO").toString();
		
		if(!tradeNo.equals(null)){
			byte[] reqFixedText7611 = null;
			reqFixedText7611 = LottePointTcpClient.sendFixedText7610(tradeNo, cardNo, cno, pw );
			
			// [원본배열], [원본배열시작위치],[복사할배열], [복사할 배열의 시작위치], [복사할 개수]
			byte[] Header7611 = new byte[73];
			byte[] Body7611 = new byte[166];
			System.arraycopy(reqFixedText7611, 2, Header7611, 0, 73);
			System.arraycopy(reqFixedText7611, 75, Body7611, 0, 166);
	
			String strHeader7611 = new String(Header7611,"EUC_KR");
			String strBody7611 = new String(Body7611,"EUC_KR");
			System.out.println("++++++++++ strHeader7611 : ["+strHeader7611+"]");
			System.out.println("++++++++++ strBody7611 : ["+strBody7611+"]");
			
			//헤더에서 리턴코드 구함
			if(!StringUtil.isEmpty(strHeader7611)){
				returnCode = strHeader7611.substring(47, 49);
				System.out.println("++++ returnCode : ["+returnCode+"]");
			}
			
			// body에서 값을 구함
			if(!StringUtil.isEmpty(strBody7611)){
				resultVo.setCode(returnCode); 									//리턴코드
				resultVo.setCardNum(strBody7611.substring(0, 16).trim());		//카드번호
				resultVo.setCustNo(strBody7611.substring(17, 28));				//고객번호
				resultVo.setApprCd(strBody7611.substring(28, 29));				//응답코드
				resultVo.setRemainPoint_str(strBody7611.substring(107, 116));	//잔여포인트
				resultVo.setUsePoint_str(strBody7611.substring(116, 125));		//가용포인트
				resultVo.setFailCnt(strBody7611.substring(125, 126));			//비밀번호오류횟수
			}
			
			if("22".equals(returnCode)){
        		System.out.println("롯데포인트 시스템장애");
        	}else if("44".equals(returnCode)){
        		System.out.println("롯데포인트 승인거절");
        	}else if("69".equals(returnCode)){
        		System.out.println("롯데포인트 자료불일치");
        	}else if("77".equals(returnCode)){
        		System.out.println("롯데포인트 전문오류");
        	}else if("88".equals(returnCode)){
        		System.out.println("롯데포인트 DB 미등록");
        	}else if("80".equals(returnCode)){
        		System.out.println("롯데포인트 운영사 DBMS 장애");
        	}else if("92".equals(returnCode)){
        		System.out.println("롯데포인트 Control 오류");
        	}else if("99".equals(returnCode)){
        		System.out.println("롯데포인트 시간초과 재시도 요망");
        	}else if(!"00".equals(returnCode)){
        		System.out.println("롯데포인트 시스템장애");
        	}
		}
		
		return resultVo;
	}

    @Override
	public LPointVO getLPointUse (String resCd, String cardNo, String wpw, String startDay, String lottePoint, String pointFg, String custcd) throws Exception{
    	/*
    	 * point fg
    	 * 	A	추후적립취소
			C	즉시접립취소
			D	즉시적립
			E	에러
			F	사용취소
			I	일괄적립
			J	일괄적립완료
			R	추후적립대기
			S	추후적립완료
			U	사용
    	 */
    	LPointVO resultVo = new LPointVO();
    	PointMstVO pointMstVO	=	new PointMstVO();
    	PointHistoryVO pointHistoryVO	=	new PointHistoryVO();
    	HashMap<String, Object> result = new HashMap<String, Object>();
    	
    	String tradeNo				=	"";
    	String returnCode			=	"";
    	
		String saveFg				=	"1";	//	적립구분 1: 정상, 2:취소
		String apprNo				=	"";		//	제휴사승인번호(3900 + yymmdd + tradeNo + 0001)
		
		String pointTid				=	"";
		
		String usePoint				=	"";
		String remainType			=	""; 	// 잔여포인트부호
		String remainPoint			=	""; 	// 잔여포인트
		String affRemainPointType	=	""; 	// 제휴사잔여포인트 부호
		String affRemainPoint		=	""; 	// 제휴사잔여포인트 
		String message1				=	"";	
		
		String orgApprNo			=	"";		//	포인트 사용은 원거래번호가 없음
		String orgTradeDay			=	"";		//	포인트 사용은 원거래번호가 없음
		
		result = freeLpointDao.selectLottePointSeq();

		if(result.get("TRADE_NO").toString().equals("00000")){
			freeLpointDao.insertLottePointSeq();
		}
		
		freeLpointDao.updateLottePointSeq();
		
		tradeNo = freeLpointDao.selectLottePointSeq().get("TRADE_NO").toString();

		if(!tradeNo.equals(null)){
			byte[] reqFixedText7211 = null;

			apprNo = "3900"+DateUtil.getToday().substring(2)+tradeNo+"0001";	//제휴사승인번호

			reqFixedText7211 = LottePointTcpClient.sendFixedText7210_7220(tradeNo, wpw, cardNo, saveFg, apprNo, lottePoint, orgApprNo, orgTradeDay);
			
			byte[] Header7211 = new byte[73];
			byte[] Body7211 = new byte[591];
			System.arraycopy(reqFixedText7211, 2, Header7211, 0, 73);
			System.arraycopy(reqFixedText7211, 75, Body7211, 0, 591);
	
			String strHeader7211 = new String(Header7211,"EUC_KR");
			String strBody7211 = new String(Body7211,"EUC_KR");
			
			//헤더에서 리턴코드 구함
			if(!StringUtil.isEmpty(strHeader7211)){
				returnCode = strHeader7211.substring(47, 49);
//				System.out.println("++++ returnCode : ["+returnCode+"]");
				if("22".equals(returnCode)){
	        		System.out.println("롯데포인트 시스템장애");
	        	}else if("44".equals(returnCode)){
	        		System.out.println("롯데포인트 승인거절");
	        	}else if("69".equals(returnCode)){
	        		System.out.println("롯데포인트 자료불일치");
	        	}else if("77".equals(returnCode)){
	        		System.out.println("롯데포인트 전문오류");
	        	}else if("88".equals(returnCode)){
	        		System.out.println("롯데포인트 DB 미등록");
	        	}else if("80".equals(returnCode)){
	        		System.out.println("롯데포인트 운영사 DBMS 장애");
	        	}else if("92".equals(returnCode)){
	        		System.out.println("롯데포인트 Control 오류");
	        	}else if("99".equals(returnCode)){
	        		System.out.println("롯데포인트 시간초과 재시도 요망");
	        	}else if(!"00".equals(returnCode)){
	        		System.out.println("롯데포인트 시스템장애");
	        	}
			}
			
			// body에서 값을 구함
			if(!StringUtil.isEmpty(strBody7211)){
				cardNo				=	strBody7211.substring(0, 16).trim();	// 카드번호
				apprNo				=	strBody7211.substring(71, 90);			// 제휴사 승인번호
				usePoint			=	strBody7211.substring(198, 207);		// 가용포인트
				remainType			=	strBody7211.substring(207, 208); 		// 잔여포인트부호
				remainPoint			=	strBody7211.substring(208, 217); 		// 잔여포인트
				affRemainPointType	=	strBody7211.substring(217, 218); 		// 제휴사잔여포인트 부호
				affRemainPoint		=	strBody7211.substring(218, 227); 		// 제휴사잔여포인트 
				message1			=	strBody7211.substring(227, 291);
				
				pointTid = DateUtil.getToday().substring(2) + "0039000001" + tradeNo;
				
				// 포인트마스터 셋팅
				pointMstVO.setPOINT_TID(pointTid);
				pointMstVO.setENTDATE(DateUtil.getToday());
				pointMstVO.setPOINT_FG(pointFg);
				pointMstVO.setRES_CD(resCd);
				pointMstVO.setSTART_DAY(startDay);	//	출발일자
				pointMstVO.setCARD_NO(cardNo);
				pointMstVO.setUSE_DATE(DateUtil.getToday());
				pointMstVO.setSALE_AMT(0);
				pointMstVO.setUSE_POINT(Integer.parseInt(lottePoint));
				pointMstVO.setUSE_APPRNO(apprNo);
				pointMstVO.setUSE_ORG_APPRNO(apprNo);
				pointMstVO.setINS_FG("1");
				pointMstVO.setINS_ID(custcd);
				pointMstVO.setUPD_ID(custcd);
				
				freeLpointDao.insertLottePointMst(pointMstVO);
				
				// 포인트히스토리 셋팅
				pointHistoryVO.setPOINT_TID(pointTid);
				pointHistoryVO.setPOINT_FG("U");
				pointHistoryVO.setPOINT_FG(pointFg);
				pointHistoryVO.setCARD_NO(cardNo);
				pointHistoryVO.setPOINT_AMT(lottePoint);
				pointHistoryVO.setAPPRNO(apprNo);
				pointHistoryVO.setORG_APPRNO(apprNo);

				freeLpointDao.insertLottePointHis(pointHistoryVO);
			}
		
		}
		
		resultVo.setCode(returnCode);						//	결과코드
		resultVo.setApprNo(apprNo);							//	제휴사승인번호
		resultVo.setUSE_ORG_APPRNO(apprNo);					//	원거래승인번호
		resultVo.setUSE_ORG_APPRNO_DAY(orgTradeDay);		//	원거래승인일자
		resultVo.setUsePoint_str(usePoint);					//	가용포인트
		resultVo.setRemainPointType(remainType);			//	잔여포인트부호
		resultVo.setRemainPoint_str(remainPoint);			//	잔여포인트
		resultVo.setAffRemainPointType(affRemainPointType);	//	제휴사잔여포인트 부호
		resultVo.setAffRemainPoint(affRemainPoint);			//	제휴사 잔여포인트
		resultVo.setPOINT_TID(pointTid);					//	포인트TID
		resultVo.setCardNum(cardNo);						//	카드번호
		
		return resultVo;
    }    
    
    /*
     * LPoint 취소처리
     * 
     */
    @Override
	public JSONObject cancelLpointUse(String fitRsvNo) throws Exception {
    	System.out.println("LPOINT 취소처리로직 start ==============================================");
    	
    	HashMap<String, Object> result = new HashMap<String, Object>();
		
    	//lpoint 취소를 위한 조회
    	System.out.println("==================== [JEH] FreeLPointServiceImpl - cancelLpointUse - lpoint 취소조회 start! =====");
    	LPointVO lpointvo = freeLpointDao.selectUseLPointInfo(fitRsvNo);
    	System.out.println("==================== [JEH] FreeLPointServiceImpl - cancelLpointUse - lpoint 취소조회 end! =====");
//    	System.out.println("==================== [JEH] FreeLPointServiceImpl - cancelLpointUse - lpointvo : " + lpointvo);
    	    	    	    	
    	System.out.println("==================== [JEH] FreeLPointServiceImpl - cancelLpointUse - lpoint 취소 로직 start! =====");
    	if(lpointvo != null && lpointvo.getApprNo() != null && !"".equals(lpointvo.getApprNo())) {
    		System.out.println("==================== [JEH] FreeLPointServiceImpl - cancelLpointUse - lpoint 취소 로직 in =====");
    		System.out.println("point_tid : " + lpointvo.getPOINT_TID());
			System.out.println("cardNum : " + lpointvo.getCardNum());
			System.out.println("usePoint_str : " + lpointvo.getUsePoint_str());
			System.out.println("use_org_apprno : " + lpointvo.getUSE_ORG_APPRNO());
			System.out.println("use_org_apprno_day : " + lpointvo.getUSE_ORG_APPRNO_DAY());
    	
			result = freeLpointDao.selectLottePointSeq();
    	
			System.out.println("TRADE_NO=" + result.get("TRADE_NO").toString().equals("00000"));
			if(result.get("TRADE_NO").toString().equals("00000")){
				freeLpointDao.insertLottePointSeq();
			}
			
			freeLpointDao.updateLottePointSeq();
			
			String tradeNo = result.get("TRADE_NO").toString();
    	
			String apprNo = "3900"+DateUtil.getToday().substring(2)+tradeNo+"0001";	//제휴사승인번호
			
			System.out.println("cancelLpointUse=" + apprNo);
			
			//취소전문
			byte[] reqFixedText = LottePointTcpClient.sendFixedText7210_7220( tradeNo ,
																				""	  ,
																				"",
																				"2"   ,  //적립구분 2:취소
																				apprNo,
																				"",
																				lpointvo.getUSE_ORG_APPRNO(),
																				lpointvo.getUSE_ORG_APPRNO_DAY()
																			 );
			System.out.println("================ reqFixedText : " + reqFixedText.length);
			System.out.println(reqFixedText);
			

			byte[] Header7211 = new byte[73];
			byte[] Body7211 = new byte[591];
	
			// 사용취소전문 1211_1121 = 길이 2 + 헤더 73   + 바디   1165    +    테일   3 = 1243
			// reqFixedText 669
			System.arraycopy(reqFixedText, 2, Header7211, 0, 73);
			System.arraycopy(reqFixedText, 75, Body7211, 0, 591);

			String strHeader7211 = new String(Header7211,"EUC_KR");
			String strBody7211 = new String(Body7211,"EUC_KR");
			
			System.out.println("==================== result ==================");
			System.out.println("strHeader7211 : " + strHeader7211);
			System.out.println("strBody7211 : " + strBody7211);
			//헤더에서 리턴코드 구함
			if (!StringUtil.isEmpty(strHeader7211)) {
				String returnCode = strHeader7211.substring(47, 49);
				System.out.println("++++ returnCode : ["+returnCode+"]");
				if ("22".equals(returnCode)) {
	        		System.out.println("롯데포인트 시스템장애");
	        	} else if ("44".equals(returnCode)) {
	        		System.out.println("롯데포인트 승인거절");
	        	} else if ("69".equals(returnCode)) {
	        		System.out.println("롯데포인트 자료불일치");
	        	} else if ("77".equals(returnCode)) {
	        		System.out.println("롯데포인트 전문오류");
	        	} else if ("88".equals(returnCode)) {
	        		System.out.println("롯데포인트 DB 미등록");
	        	} else if ("80".equals(returnCode)) {
	        		System.out.println("롯데포인트 운영사 DBMS 장애");
	        	} else if ("92".equals(returnCode)) {
	        		System.out.println("롯데포인트 Control 오류");
	        	} else if ("99".equals(returnCode)) {
	        		System.out.println("롯데포인트 시간초과 재시도 요망");
	        	} else if (!"00".equals(returnCode)) {
	        		System.out.println("롯데포인트 시스템장애");
	        	}
			}

			// body에서 값을 구함
			if (!StringUtil.isEmpty(strBody7211)) {
				String cardNo				=	strBody7211.substring(0, 16).trim();	// 카드번호
				String rtApprNo				=	strBody7211.substring(71, 90);			// 제휴사 승인번호
				String usePoint				=	strBody7211.substring(198, 207);		// 가용포인트
				String remainType			=	strBody7211.substring(207, 208); 		// 잔여포인트부호
				String remainPoint			=	strBody7211.substring(208, 217); 		// 잔여포인트
				String affRemainPointType	=	strBody7211.substring(217, 218); 		// 제휴사잔여포인트 부호
				String affRemainPoint		=	strBody7211.substring(218, 227); 		// 제휴사잔여포인트
				String message1				=	strBody7211.substring(227, 291);

				String pointTid = DateUtil.getToday().substring(2) + "0039000001" + tradeNo;
				
				System.out.println("cardNo : " + cardNo);
				System.out.println("apprNo : " + rtApprNo);
				System.out.println("usePoint : " + usePoint);
				System.out.println("remainType : " + remainType);
				System.out.println("remainPoint : " + remainPoint);
				System.out.println("affRemainPointType : " + affRemainPointType);
				System.out.println("affRemainPoint : " + affRemainPoint);
				System.out.println("message1 : " + message1);
				System.out.println("pointTid : " + pointTid);
			}
			System.out.println("LPOINT 취소처리로직 end ==============================================");	
    	}
		System.out.println("==================== [JEH] FreeLPointServiceImpl - cancelLpointUse - lpoint 취소 로직 end!=====");
//    	System.out.println("lpointvo" + lpointvo.toString());
    	return null;
	}
    
    @Override
	public LPointVO getLPointAccum (String res_cd, String cardNo, String lottePoint, String saleAmt, String pointFg, String startDay, String custcd) throws Exception{

    	LPointVO resultVo = new LPointVO();
    	PointMstVO pointMstVO	=	new PointMstVO();
    	PointHistoryVO pointHistoryVO	=	new PointHistoryVO();
    	HashMap<String, Object> result = new HashMap<String, Object>();
    	
    	String tradeNo				=	"";
    	String returnCode			=	"";
    	
		String saveFg				=	"1";	//	적립구분 1: 정상, 2:취소
		String apprNo				=	"";		//	제휴사승인번호(3900 + yymmdd + tradeNo + 0001)
		
		String pointTid				=	"";
		
		String usePoint				=	"";
		String createPoint			=	"";
		String remainType			=	""; 	// 잔여포인트부호
		String remainPoint			=	""; 	// 잔여포인트
		String affRemainPointType	=	""; 	// 제휴사잔여포인트 부호
		String affRemainPoint		=	""; 	// 제휴사잔여포인트 
		String message1				=	"";
		String message2				=	"";
		
		String orgApprNo			=	"";		//	포인트 사용은 원거래번호가 없음
		String orgTradeDay			=	"";		//	포인트 사용은 원거래번호가 없음
		
		result = freeLpointDao.selectLottePointSeq();

		if(result.get("TRADE_NO").toString().equals("00000")){
			freeLpointDao.insertLottePointSeq();
		}
		
		freeLpointDao.updateLottePointSeq();
		
		tradeNo = freeLpointDao.selectLottePointSeq().get("TRADE_NO").toString();

		if(!tradeNo.equals(null)){
			apprNo = "3900"+DateUtil.getToday().substring(2)+tradeNo+"0001";	//제휴사승인번호

        	byte[] reqFixedText1171 = null;
        	reqFixedText1171 = LottePointTcpClient.sendFixedText1170_1180(tradeNo, cardNo, saveFg, apprNo, saleAmt, lottePoint, orgApprNo, orgTradeDay);
			
        	byte[] Header1171 = new byte[73];
			byte[] Body1171 = new byte[1090];
			System.arraycopy(reqFixedText1171, 2, Header1171, 0, 73);
			System.arraycopy(reqFixedText1171, 75, Body1171, 0, 1090);
	
			String strHeader1171 = new String(Header1171,"EUC_KR");
			String strBody1171 = new String(Body1171,"EUC_KR");
			
			//헤더에서 리턴코드 구함
			if(!StringUtil.isEmpty(strHeader1171)){
				returnCode = strHeader1171.substring(47, 49);
//				System.out.println("++++ returnCode : ["+returnCode+"]");
				if("22".equals(returnCode)){
	        		System.out.println("롯데포인트 시스템장애");
	        	}else if("44".equals(returnCode)){
	        		System.out.println("롯데포인트 승인거절");
	        	}else if("69".equals(returnCode)){
	        		System.out.println("롯데포인트 자료불일치");
	        	}else if("77".equals(returnCode)){
	        		System.out.println("롯데포인트 전문오류");
	        	}else if("88".equals(returnCode)){
	        		System.out.println("롯데포인트 DB 미등록");
	        	}else if("80".equals(returnCode)){
	        		System.out.println("롯데포인트 운영사 DBMS 장애");
	        	}else if("92".equals(returnCode)){
	        		System.out.println("롯데포인트 Control 오류");
	        	}else if("99".equals(returnCode)){
	        		System.out.println("롯데포인트 시간초과 재시도 요망");
	        	}else if(!"00".equals(returnCode)){
	        		System.out.println("롯데포인트 시스템장애");
	        	}
			}
			
			// body에서 값을 구함
			if(!StringUtil.isEmpty(strBody1171)){
				cardNo				=	strBody1171.substring(1, 38).trim();	//카드번호
				apprNo				=	strBody1171.substring(76, 95);			//제휴사 승인번호
				createPoint			=	strBody1171.substring(137, 146);		//금회생성/취소포인트
				usePoint			=	strBody1171.substring(194, 203);		//가용포인트
				remainType			=	strBody1171.substring(203, 204); 		//잔여포인트부호
				remainPoint			=	strBody1171.substring(204, 213); 		//잔여포인트
				affRemainPointType	=	strBody1171.substring(213, 214); 		//제휴사잔여포인트 부호
				affRemainPoint		=	strBody1171.substring(214, 223); 		//제휴사잔여포인트 
				message1			=	strBody1171.substring(223, 287);		//메시지1
				message2			=	strBody1171.substring(287, 543);		//메시지2
				
				pointTid = DateUtil.getToday().substring(2) + "0039000001" + tradeNo;
				
				// 포인트마스터 셋팅
				pointMstVO.setPOINT_TID(pointTid);
				pointMstVO.setENTDATE(DateUtil.getToday());
				pointMstVO.setPOINT_FG(pointFg);
				pointMstVO.setRES_CD(res_cd);
				pointMstVO.setSTART_DAY(startDay);
				pointMstVO.setCARD_NO(cardNo);
				pointMstVO.setSALE_AMT(Integer.parseInt(saleAmt));
				pointMstVO.setSAVE_DATE(DateUtil.getToday());
				pointMstVO.setSAVE_POINT(Integer.parseInt(lottePoint));
				pointMstVO.setSAVE_APPRNO(apprNo);
				pointMstVO.setSAVE_ORG_APPRNO(apprNo);
				pointMstVO.setINS_FG("1");
				pointMstVO.setINS_ID(custcd);
				pointMstVO.setUPD_ID(custcd);

				freeLpointDao.insertLottePointMst(pointMstVO);
				
				// 포인트히스토리 셋팅
				pointHistoryVO.setPOINT_TID(pointTid);
				pointHistoryVO.setPOINT_FG(pointFg);
				pointHistoryVO.setCARD_NO(cardNo);
				pointHistoryVO.setPOINT_AMT(lottePoint);
				pointHistoryVO.setSALE_AMT(saleAmt);
				pointHistoryVO.setAPPRNO(apprNo);
				pointHistoryVO.setORG_APPRNO(apprNo);

				freeLpointDao.insertLottePointHis(pointHistoryVO);
			}
		
		}
		
    	resultVo.setCode(returnCode);						//	결과코드
		resultVo.setApprNo(apprNo);							//	제휴사승인번호
		resultVo.setUSE_ORG_APPRNO(apprNo);					//	원거래승인번호
		resultVo.setUSE_ORG_APPRNO_DAY(orgTradeDay);		//	원거래승인일자
		resultVo.setUsePoint_str(usePoint);					//	가용포인트
		resultVo.setRemainPointType(remainType);			//	잔여포인트부호
		resultVo.setRemainPoint_str(remainPoint);			//	잔여포인트
		resultVo.setAffRemainPointType(affRemainPointType);	//	제휴사잔여포인트 부호
		resultVo.setAffRemainPoint(affRemainPoint);			//	제휴사 잔여포인트
		resultVo.setPOINT_TID(pointTid);					//	포인트TID
		resultVo.setCardNum(cardNo);						//	카드번호
		
		return resultVo;
    }
    
	/**
	 * 결제 요청
	 * 
	 * @return 결제 요청 기본 정보
	 * @throws Exception 결제 요청 시 발생하는 예외
	 */
	@Override
	public PaymentVO requestPayment(String price, String type) throws Exception {
		
//		System.out.println("##### 결제 요청 기본 정보 설정 #####");
		
		PaymentVO paymentVo = new PaymentVO();
		
		try {
					
			/*
		    	//*** 위변조 방지체크를 signature 생성  ***
		
		        oid, price, timestamp 3개의 키와 값을
		
		        key=value 형식으로 하여 '&'로 연결한 하여 SHA-256 Hash로 생성 된값
		
		        ex) oid=INIpayTest_1432813606995&price=819000&timestamp=2012-02-01 09:19:04.004
		            
		        // key기준 알파벳 정렬
		
		        // timestamp는 반드시 signature생성에 사용한 timestamp 값을 timestamp input에 그대로 사용하여야함
			 */
	
		    //############################################
		    // 1.전문 필드 값 설정(***가맹점 개발수정***)
		    //############################################
			
			paymentVo.setVersion(propertiesService.getString("payment.version")); // 버전
			if("VBank".equals(type)){
				System.out.println("type1:" + type);
				paymentVo.setmId(propertiesService.getString("payment.Vbank.mId")); // 상점 아이디
				paymentVo.setSignKey(propertiesService.getString("payment.vbank_signKey")); // 사인키
			}else{
				System.out.println("type2:" + type);
				paymentVo.setmId(propertiesService.getString("payment.Card.mId")); // 상점 아이디
				paymentVo.setSignKey(propertiesService.getString("payment.card_signKey")); // 사인키
			}
//			paymentVo.setmId(propertiesService.getString("payment.mId")); // 상점 아이디
	//		paymentVo.setSignKey(propertiesService.getString("payment.signKey")); // 사인키
			paymentVo.setCharset(propertiesService.getString("payment.charset")); // 결과 인코딩

		    // 여기에 설정된 값은 Form 필드에 동일한 값으로 설정
			paymentVo.setCurrency("WON");
//			paymentVo.setBuyerName("홍길동");
//			paymentVo.setBuyerEmail("010-1234-5678");
//			paymentVo.setBuyerTel("test@inicis.com");
		    paymentVo.setPrice(price); // 상품가격(특수기호 제외, 가맹점에서 직접 설정)
		    //String cardNoInterestQuota  = "11-2:3:,34-5:12,14-6:12:24,12-12:36,06-9:12,01-3:4"; // 카드 무이자 여부 설정(가맹점에서 직접 설정)
		    //String cardQuotaBase        = "2:3:4:5:6:11:12:24:36"; // 가맹점에서 사용할 할부 개월수 설정		    
		    paymentVo.setQuotaBase("2:3:4:5"); // 가맹점에서 사용할 할부 개월수 설정 생략시 일시불만

		    paymentVo.setTimeStamp(SignatureUtil.getTimestamp()); // util에 의해서 자동생성
		    paymentVo.setoId(paymentVo.getmId() + "_" + SignatureUtil.getTimestamp()); // 가맹점 주문번호(가맹점에서 직접 설정)
		    System.out.println("oid:" + paymentVo.getoId());
		
		    //###############################################
		    // 2. 가맹점 확인을 위한 signKey를 해시값으로 변경 (SHA-256방식 사용)
		    //###############################################
//		    String mKey = SignatureUtil.hash(paymentVo.getSignKey(), "SHA-256");		
//			paymentVo.setmKey(mKey);
//	
//		    //###############################################
//		    // 2.signature 생성
//		    //###############################################
//		    Map<String, String> signParam = new HashMap<String, String>();
//		
//		    signParam.put("oid", paymentVo.getoId());			  // 필수
//		    signParam.put("price", paymentVo.getPrice());   	  // 필수
//		    signParam.put("timestamp", paymentVo.getTimeStamp()); // 필수
//		
//		    // signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로 나열해 hash)	    
//			String signature = SignatureUtil.makeSignature(signParam);
//			paymentVo.setSignature(signature);
	
		    /* 기타 */
		    ///String siteDomain = "http://127.0.0.1:8080/INIpayStdSample"; //가맹점 도메인 입력
//		    String siteDomain = "http://m.lottejtb.com/free/account"; //가맹점 도메인 입력
		    //String siteDomain = "http://mdev.lottejtb.com/free/account"; //가맹점 도메인 입력
		    String siteDomain = "https://m.lottejtb.com/free/account"; //가맹점 도메인 입력
		    
		    paymentVo.setSiteDomain(siteDomain);
		    
		    // 페이지 URL에서 고정된 부분을 적는다.
		    // Ex) returnURL이 http://localhost:8080INIpayStdSample/INIStdPayReturn.jsp 라면
		    // http://localhost:8080/INIpayStdSample 까지만 기입한다.
		    
		    paymentVo.setOfferPeriod("20151001-20151231"); // 제공기간
		    paymentVo.setAcceptMethod("CARDPOINT:HPP(1):no_receipt:va_receipt:vbanknoreg(0):below1000"); // acceptmethod

		    paymentVo.setReturnUrl(siteDomain + "/paymentReturn.do");
		    paymentVo.setCloseUrl(siteDomain + "/paymentCancel.do");
		    paymentVo.setPopupUrl(siteDomain + "/popup.jsp");
		    
//		    System.out.println("##### 결제 요청 기본 정보:" + paymentVo.toString());
		} catch (Exception e) {
			System.out.println("PaymentServiceImpl.requestPayment error :" + e);

		}
		
		return paymentVo;
	}

    
	/**
	 * 항공결제 이니시스 기초데이터 획득
	 * 
	 * @return 결제 요청 기본 정보
	 * @throws Exception 결제 요청 시 발생하는 예외
	 */
	@Override
	public PaymentVO requestAirPay(String price) throws Exception {
		
//		System.out.println("##### 결제 요청 기본 정보 설정 #####");
		
		PaymentVO paymentVo = new PaymentVO();
		
		try {
					
		    //############################################
		    // 1.전문 필드 값 설정(***가맹점 개발수정***)
		    //############################################
			paymentVo.setVersion(propertiesService.getString("payment.version")); // 버전
			System.out.println("type:VBANK");
			paymentVo.setmId(propertiesService.getString("payment.Vbank.mId")); // 상점 아이디
			
			//paymentVo.setSignKey(propertiesService.getString("payment.signKey")); // 사인키
			//####운영시 아래것으로 변경######
			paymentVo.setSignKey(propertiesService.getString("payment.vbank_signKey")); // 사인키
			
			paymentVo.setCharset(propertiesService.getString("payment.charset")); // 결과 인코딩

		    // 여기에 설정된 값은 Form 필드에 동일한 값으로 설정
			paymentVo.setCurrency("WON");
		    paymentVo.setPrice(price); // 상품가격(특수기호 제외, 가맹점에서 직접 설정)
		    paymentVo.setQuotaBase("2:3:4:5"); // 가맹점에서 사용할 할부 개월수 설정 생략시 일시불만

		    paymentVo.setTimeStamp(SignatureUtil.getTimestamp()); // util에 의해서 자동생성
		    paymentVo.setoId(paymentVo.getmId() + "_" + SignatureUtil.getTimestamp()); // 가맹점 주문번호(가맹점에서 직접 설정)
		
		
//		    //###############################################
//		    // 2. 가맹점 확인을 위한 signKey를 해시값으로 변경 (SHA-256방식 사용)
//		    //###############################################
//		    String mKey = SignatureUtil.hash(paymentVo.getSignKey(), "SHA-256");		
//			paymentVo.setmKey(mKey);
//	
//		    //###############################################
//		    // 2.signature 생성
//		    //###############################################
//		    Map<String, String> signParam = new HashMap<String, String>();
//		
//		    signParam.put("oid", paymentVo.getoId());			  // 필수
//		    signParam.put("price", paymentVo.getPrice());   	  // 필수
//		    signParam.put("timestamp", paymentVo.getTimeStamp()); // 필수
//		
//		    // signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로 나열해 hash)	    
//			String signature = SignatureUtil.makeSignature(signParam);
//			paymentVo.setSignature(signature);
	
		    /* 기타 */
		    ///String siteDomain = "http://127.0.0.1:8080/INIpayStdSample"; //가맹점 도메인 입력
//		    String siteDomain = "http://m.lottejtb.com/free/account"; //가맹점 도메인 입력
		   // String siteDomain = "http://mdev.lottejtb.com/free/account"; //가맹점 도메인 입력
		    String siteDomain = "https://m.lottejtb.com/free/account"; //가맹점 도메인 입력
		    
		    paymentVo.setSiteDomain(siteDomain);
		    
		    // 페이지 URL에서 고정된 부분을 적는다.
		    // Ex) returnURL이 http://localhost:8080INIpayStdSample/INIStdPayReturn.jsp 라면
		    // http://localhost:8080/INIpayStdSample 까지만 기입한다.
		    
		    paymentVo.setOfferPeriod("20151001-20151231"); // 제공기간
		    paymentVo.setAcceptMethod("CARDPOINT:HPP(1):no_receipt:va_receipt:vbanknoreg(0):below1000"); // acceptmethod

		    paymentVo.setReturnUrl(siteDomain + "/airPayReturn.do");
		    paymentVo.setCloseUrl(siteDomain + "/paymentCancel.do");
		    paymentVo.setPopupUrl(siteDomain + "/popup.jsp");
		    
//		    System.out.println("##### 결제 요청 기본 정보:" + paymentVo.toString());
		} catch (Exception e) {
			System.out.println("PaymentServiceImpl.requestPayment error :" + e);

		}
		
		return paymentVo;
	}
	
	/**
	 * 결제 인증수신/승인API 처리
	 * 
     * @param paramMap 결제승인 정보
     * @return 결제 인증 및 승인 결과
	 * @throws Exception 결제 인증 및 승인 시 발생하는 예외
	 */
	@Override
	public PaymentVO authAndApprPayment(Map<String, String> paramMap) throws Exception {

		PaymentVO paymentVo = new PaymentVO();
//		FaFitPaymtInfVO faFitPaymtInfVO = new FaFitPaymtInfVO();
		FaFitRsvMstVO faFitRsvMstVO = new FaFitRsvMstVO();
		AirReceiptReqVO airReceiptReqVO = new AirReceiptReqVO();
		FaFitCashReceiptVO faFitCashReceiptVO = new FaFitCashReceiptVO();
		HtlCardPaymtVO htlCardPaymtVO = new HtlCardPaymtVO();
		HtlActPaymtVO htlActPaymtVO = new HtlActPaymtVO();
		HtlEtcPaymtVO htlEtcPaymtVO = new HtlEtcPaymtVO();
		HtlGiftPaymtVO htlGiftPaymtVO = new HtlGiftPaymtVO();
		
		String goodsPrice	=	"";			//	상품가격
		String rescd		=	"";			//	예약번호
		String cardNo		=	""; 		//	LPoint카드번호
		String wpw			=	""; 		//	LPoint패스워드
		String lottePoint	=	""; 		//	사용포인트
		String pointFg		=	"U";		//	
		String giftCard		=	"";			//	상품권번호
		String giftCardAmt	=	"";			//	상품권금액
		String buyerTel		=	""; 		//	구매자 전화번호
		String buyerEmail	=	""; 		//	구매자 이메일
		String goodName		=	""; 		//	상품명
		String vcdbank		=	""; 		//	입금은행코드
		String startDay		=	"";			//	여행시작일자
		String buyerName	=	"";			//	구매자명
//		String personalNo	=	"";			//	현금영수증 주민등록번호
		String custcd		=	"";			//	로그인id
		String ioCd			=	"";			//	입금환불코드		--	입금환불코드 초기값 가져오는 곳은?
		String cashPayAmt	=	"";
		String cashType		=	"";			//	현금영수증타입(0:소득공제(소비자용), 1:지출증빙(사업자용))	
		String cashReceipts	=	"";			//	현금영수증인증번호(핸드폰번호, 사업자등록번호)	
		
		String RECEIPT_DIVI_GB		= "";    // '영수증_구분_GB';
		String ISSUE_HTEL			= "";    // '발급_휴대전화';
		String CORP_NO				= "";    // '사업자_번호';		

		String TID_NO	=	"";										//	이니시스TID
		String OID_NO	= 	"";										//  이니시스OID
		String CASH_AMT	=	"";										//	현금 결제 금액
		
		String accNoOwner	=	"";									//	예금주명
		String bankName		=	"";									//	은행명
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//	가상계좌
    	String FIT_RSV_NO            = "";
    	String BANK_CD_GB            = "";
    	String ACT_NO                = "";
    	String ACT_PAYMTOR_NM        = "";
    	String PAYMT_SCH_DT          = "";
    	String PAYMT_SCH_HM			 = "";
    	String NOTE                  = "";
    	String CASH_RECEIPT_DIVI_GB  = "";
    	String PAYMT_CONF_YN         = "";
    	String VIRTUAL_ACT_YN        = "";
    	String REGTOR_ID             = "";
    	String REG_DTT               = "";
    	String MODTOR_ID             = "";
    	String MOD_DTT               = "";
    	
    	//	기타
    	String ETC_USE_YN     = "";
    	String ETC_PAYMT_AMT  = "";

    	//	카드
    	String CARD_PAYMT_SEQNO     = ""; 
    	String PAX_NO               = ""; 
    	String CARD_PAYMT_AMT       = ""; 
    	String CARD_KI_GB           = ""; 
    	String CARD_NO              = ""; 
    	String CARD_EXPIR_DATE_MN   = ""; 
    	String CARD_EXPIR_DATE_YEAR = ""; 
    	String CARD_INSTALLMN_MN    = ""; 
    	String CARD_OWNER_GB        = ""; 
    	String CARD_RELAT_GB        = ""; 
    	String CARD_OWNER_NM        = ""; 
    	String CARD_CVS_NO          = ""; 
    	String CARD_APPROVE_NO      = ""; 
    	String CARD_TID_NO 			= "";
    	String CARD_OID_NO 			= "";
    	String APPROVE_CONF_YN      = ""; 
    	String FRONT_PASS           = ""; 
    	
    	//	상품권
		String GIFT_DIVI_GB = "";    								//'상품권_구분_GB';
		String GIFT_NO = "";    									//'상품권_번호';
		String GIFT_AMT = "";    									//'상품권_금액';
		String GIFT_RECP_YN = "N";    								//'상품권_수령_여부';

		//L 포인트 금액
		String L_POINT_AMT 			= "";    						//'L_포인트_금액';
		
		//문자변환용
		String originalStr = "";
		//현금영수증여부
		String cashYn		=	"";
		//취소용 TID
		String cancelTid	=	"";
		//	결제구분
		String paymentGb	=	"";
		////////////////////////////////////////////////////////////////////////////////////////////////////
    	
		try {

			System.out.println("paramMap FREE:" +  paramMap.toString());

			//#####################
			// 인증이 성공일 경우만
			//#####################
			if ("00".equals(paramMap.get("P_STATUS"))) {
	
				System.out.println("#### 인증성공/승인요청 ####");
				
//				================================================================================================
//				L.Point 로직 시작	: L.Point관련 데이터를 merchantData에 담아 inicis에 던져서 그대로 받고 pasing하여 사용한다.					
//				================================================================================================
				String[] splitParam =	URLDecoder.decode(String.valueOf(paramMap.get("P_NOTI")), "UTF-8").split("\t"); 
				
				goodsPrice		=	splitParam[0]; 		//	상품가격
				startDay		=	splitParam[1]; 		//	여행시작일자
				cardNo			=	splitParam[2]; 		//	LPoint카드번호
				wpw				=	splitParam[3]; 		//	LPoint패스워드
				lottePoint		=	splitParam[4]; 		//	사용포인트
				cashPayAmt		=	splitParam[5];		//	현금결제금액	(복합결제의경우)
				cashType		=	splitParam[6];		//	현금영수증타입(0:소득공제(소비자용), 1:지출증빙(사업자용))
				cashReceipts	=	splitParam[7];		//	현금영수증인증번호(핸드폰번호, 사업자등록번호)	
				//giftCard		=	splitParam[8]; 		//	상품권번호	 
				//giftCardAmt		=	splitParam[9]; 		//	상품권금액	 
				buyerTel		=	splitParam[10]; 	//	구매자 전화번호
				buyerEmail		=	splitParam[11]; 	//	구매자 이메일
				goodName		=	splitParam[12]; 	//	상품명
				vcdbank			=	splitParam[13]; 	//	입금은행코드
				rescd			=	splitParam[14]; 	//	예약번호
				paymentGb		=	splitParam[15]; 	//	결제구분

				
				
				System.out.println(">>>================================================");
				System.out.println("goodsPrice:" + goodsPrice);
				System.out.println("startDay:" + startDay);
				System.out.println("cardNo:" + cardNo);
				System.out.println("wpw:" + wpw);
				System.out.println("lottePoint:" + lottePoint);
				System.out.println("cashPayAmt:" + cashPayAmt);
				System.out.println("cashType:" + cashType);
				System.out.println("cashReceipts:" + cashReceipts);
				System.out.println("giftCard:" + giftCard);
				System.out.println("giftCardAmt:" + giftCardAmt);
				System.out.println("buyerTel:" + buyerTel);
				System.out.println("buyerEmail:" + buyerEmail);
				System.out.println("goodName:" + goodName);
				System.out.println("vcdbank:" + vcdbank);
				System.out.println("rescd:" + rescd);
				System.out.println("paymentGb:" + paymentGb);
				System.out.println(">>>>================================================");
				
				
				//############################################
				// 1. 전문 필드 값 설정(***가맹점 개발수정***)
				//############################################
	
				String pTID		= paramMap.get("P_TID");
				String authUrl	= paramMap.get("P_REQ_URL");
				String mId 		= "";
				System.out.println("type:" + paymentGb);
				if("Card".equals(paymentGb)){
					System.out.println("type1:" + paymentGb);
					mId	=	propertiesService.getString("payment.Card.mId");
				}else if("VBank".equals(paymentGb)){
					System.out.println("type2:" + paymentGb);
					mId	=	propertiesService.getString("payment.Vbank.mId");
				}
				
				custcd			=	paramMap.get("custcd");
				buyerName		=	paramMap.get("buyerName");
				
				System.out.println("paramMap:" + paramMap.toString());
				
		      
				//#####################
				// 3. API 요청 전문 생성
				//#####################
						
				Map<String, String> authMap = new HashMap<String, String>();
	
				authMap.put("P_MID"			,mId);	// 필수
				authMap.put("P_TID"			,pTID);	// 필수

	
				System.out.println("## 승인요청 API 요청 ##");
	
				HttpUtil httpUtil = new HttpUtil();
				
				try {
	
					//#####################
					// 4. API 통신 시작
					//#####################
	
					String authResultString = "";
					
					authResultString = httpUtil.processHTTP(authMap, authUrl);
					
					//############################################################
					// 5. API 통신결과 처리(***가맹점 개발수정***)
					//############################################################
					System.out.println("## 승인 API 결과 ##");
					
					String test = authResultString.replace(",", "&").replace(":", "=").replace("\"", "").replace(" ","").replace("\n", "").replace("}", "").replace("{", "");
					
					//out.println("<pre>"+authResultString.replaceAll("<", "&lt;").replaceAll(">", "&gt;")+"</pre>");
	
					Map<String, String> resultMap = new HashMap<String, String>();
					
					resultMap = ParseUtil.parseStringToMap(test); //문자열을 MAP형식으로 파싱
	
					if ("00".equals(resultMap.get("P_STATUS")) ) {	
						/*****************************************************************************
						 * 여기에 가맹점 내부 DB에 결제 결과를 반영하는 관련 프로그램 코드를 구현한다.  
					   
						 [중요!] 승인내용에 이상이 없음을 확인한 뒤 가맹점 DB에 해당건이 정상처리 되었음을 반영함
								  처리중 에러 발생시 망취소를 한다.
						 ******************************************************************************/
	
						originalStr	=	resultMap.get("P_RMESG1");
//						String [] charSet = {"utf-8","euc-kr","ksc5601","iso-8859-1","x-windows-949"};
//						for (int i=0; i<charSet.length; i++) {
//							for (int j=0; j<charSet.length; j++) {
//								try {
//									System.out.println("[" + charSet[i] +"," + charSet[j] +"] = " + new String(originalStr.getBytes(charSet[i]), charSet[j]));
//								} catch (UnsupportedEncodingException e) {
//									e.printStackTrace();
//								}
//							}
//						}
						resultMap.put("P_RMESG1", new String(originalStr.getBytes("iso-8859-1"), "euc-kr"));

						// 결과정보
						System.out.println("결과 코드1: " +  resultMap.get("P_STATUS"));
						System.out.println("결과 내용1: " +  resultMap.get("P_RMESG1"));
						
						paymentVo.setIsSuccDeal(Boolean.TRUE); // 거래 성공 여부
						paymentVo.setResultCode(resultMap.get("P_STATUS")); // 결과 코드
						paymentVo.setResultMsg(resultMap.get("P_RMESG1")); // 결과 메시지
						
					} else {
	
						originalStr	=	resultMap.get("P_RMESG1");
						resultMap.put("P_RMESG1", new String(originalStr.getBytes("iso-8859-1"), "euc-kr"));

						paymentVo.setIsSuccDeal(Boolean.FALSE); // 거래 성공 여부
						paymentVo.setResultCode(resultMap.get("P_STATUS")); // 결과 코드
						paymentVo.setResultMsg(resultMap.get("P_RMESG1")); // 결과 메시지
						throw new Exception("거래실패");
					}
						
					// 공통 부분만
					System.out.println("거래 번호: " +  resultMap.get("P_TID"));
					System.out.println("결제방법(지불수단): " +  resultMap.get("P_TYPE"));
					System.out.println("결제완료금액: " +  resultMap.get("P_AMT"));
					System.out.println("주문 번호: " +  resultMap.get("P_OID"));
					System.out.println("승인날짜: " +  resultMap.get("P_AUTH_DT"));	//	YYYYmmddHHmmss
					
					cancelTid	=	resultMap.get("P_TID");
					
					if("1".equals(splitParam[6])){
						CASH_RECEIPT_DIVI_GB	= 	"002";				//	현금영수증구분
						RECEIPT_DIVI_GB			=	"002";				//	현금영수증구분
						CORP_NO					= 	splitParam[7];    	// '사업자_번호';	
					}else{
						CASH_RECEIPT_DIVI_GB	= 	"001";				//	현금영수증구분
						RECEIPT_DIVI_GB			=	"001";				//	현금영수증구분
						ISSUE_HTEL				= 	splitParam[7];    	// '발급_휴대전화';
					}

					//결제 테이블입력용 변수처리////////////////////////////////////////////////////
					FIT_RSV_NO 	= 	rescd;    							//'자유여행_예약_번호';
					L_POINT_AMT	=	lottePoint;
					//////////////////////////////////////////////////////////////////////
					
					// 수신결과를 파싱후 resultCode가 "0000"이면 승인성공 이외 실패
					// 가맹점에서 스스로 파싱후 내부 DB 처리 후 화면에 결과 표시
					// 내부DB 저장 로직 추가
					System.out.println("payMethod: " +  resultMap.get("P_TYPE") + ":");
					if ("VBANK".equals(resultMap.get("P_TYPE"))) { // 가상계좌
						cashYn	=	"Y";		//	현금영수증 발급
						
						originalStr	=	resultMap.get("P_VACT_NAME");
						resultMap.put("P_VACT_NAME", new String(originalStr.getBytes("iso-8859-1"), "euc-kr"));

						System.out.println("입금 계좌번호: " +  resultMap.get("P_VACT_NUM"));
						System.out.println("입금 은행코드: " +  resultMap.get("P_VACT_BANK_CODE"));
						System.out.println("예금주 명: " +  resultMap.get("P_VACT_NAME"));		
						System.out.println("송금 일자: " +  resultMap.get("P_VACT_DATE"));
						System.out.println("송금 시간: " +  resultMap.get("P_VACT_TIME"));

						///////////////////////////////////////////////////////////////////////////////////////////////
						//	가상계좌
						///////////////////////////////////////////////////////////////////////////////////////////////
						//결제 테이블입력용 변수처리////////////////////////////////////////////////////
						// 가상계좌
						CASH_AMT				= goodsPrice;										//	현금결제금액
						BANK_CD_GB 				= resultMap.get("P_VACT_BANK_CODE");   				//'은행_코드_GB';
						ACT_NO 					= resultMap.get("P_VACT_NUM");    					//'계좌_번호';
//						ACT_PAYMTOR_NM 			= resultMap.get("VACT_InputName");  				//'계좌_입금자_명';
						PAYMT_SCH_DT 			= resultMap.get("P_VACT_DATE");    					//'입금_예정_일자';
						PAYMT_SCH_HM 			= resultMap.get("P_VACT_TIME");    					//'입금마감시간';  hh:mm:ss
						NOTE                  	= "";
						PAYMT_CONF_YN         	= "N";												//'입금_처리_여부';
						VIRTUAL_ACT_YN        	= "Y";
						TID_NO					= resultMap.get("P_TID");							//	결제TID
						OID_NO 					= resultMap.get("P_OID");							// 	결제OID

						accNoOwner				=	resultMap.get("P_VACT_NAME");					//	예금주명
						bankName				=	getBankName(resultMap.get("P_VACT_BANK_CODE"));	//	은행명
						//////////////////////////////////////////////////////////////////////
						
						//입금 기한을 결제 시간 기준 24시간 까지 하도록 조정
						//정책 유효기간 + 1일
						String dpstDueDate = DateFormatUtils.format(DateUtils.addHours(new Date(), 24), "yyyyMMddHHmm");
						
						//입금마감시간 시분까지 4자리만 짤라서 넣어주어야 함. 
						PAYMT_SCH_DT = dpstDueDate.substring(0,8);
						PAYMT_SCH_HM = dpstDueDate.substring(8,12);  
						
						System.out.println("dpstDueDate=" + dpstDueDate);
						System.out.println("PAYMT_SCH_DT=" + PAYMT_SCH_DT);
						System.out.println("PAYMT_SCH_HM=" + PAYMT_SCH_HM);
						
						htlActPaymtVO.setFIT_RSV_NO(FIT_RSV_NO);           
						htlActPaymtVO.setCASH_AMT(CASH_AMT);             
						htlActPaymtVO.setBANK_CD_GB(BANK_CD_GB);           
						htlActPaymtVO.setACT_NO(ACT_NO);               
						htlActPaymtVO.setACT_PAYMTOR_NM(ACT_PAYMTOR_NM);       
						htlActPaymtVO.setPAYMT_SCH_DT(PAYMT_SCH_DT);    
						htlActPaymtVO.setPAYMT_SCH_HM(PAYMT_SCH_HM);
						htlActPaymtVO.setNOTE(NOTE);                 
						htlActPaymtVO.setCASH_RECEIPT_DIVI_GB(CASH_RECEIPT_DIVI_GB); 
						htlActPaymtVO.setPAYMT_CONF_YN(PAYMT_CONF_YN);        
						htlActPaymtVO.setVIRTUAL_ACT_YN(VIRTUAL_ACT_YN);       
						htlActPaymtVO.setTID_NO(TID_NO); 
						htlActPaymtVO.setOID_NO(OID_NO);
						htlActPaymtVO.setREGTOR_ID(custcd);            
						htlActPaymtVO.setMODTOR_ID(custcd);            
						//////////////////////////////////////////////////////////////////////
						
						freeLpointDao.insertHtlActPaymt(htlActPaymtVO);						
						//////////////////////////////////////////////////////////////////////
					} else { // 카드, 복합결제 중 카드 금액

						originalStr	=	resultMap.get("P_FN_NM");
						resultMap.put("P_FN_NM", new String(originalStr.getBytes("iso-8859-1"), "euc-kr"));

						System.out.println("발급사코드: " +  resultMap.get("P_CARD_ISSUER_CODE"));
						System.out.println("가맹점번호: " +  resultMap.get("P_CARD_MEMBER_NUM"));
						System.out.println("매입사 코드: " +  resultMap.get("P_CARD_PURCHASE_CODE"));
						System.out.println("부분취소 가능여부: " +  resultMap.get("P_CARD_PRTC_CODE"));
						System.out.println("무이자 할부여부: " +  resultMap.get("P_CARD_INTEREST"));
						System.out.println("체크카드 여부: " +  resultMap.get("P_CARD_CHECKFLAG"));
						System.out.println("메시지2(할부개월수): " +  resultMap.get("P_RMESG2"));
						System.out.println("카드코드: " +  resultMap.get("P_FN_CD1"));
						System.out.println("승인번호: " +  resultMap.get("P_AUTH_NO"));
						System.out.println("VP 카드코드: " +  resultMap.get("P_ISP_CARDCODE"));
						System.out.println("결제카드한글명: " +  resultMap.get("P_FN_NM"));
						System.out.println("이벤트코드: " +  resultMap.get("P_EVENT_CODE"));
						System.out.println("카드번호: " +  resultMap.get("P_VACT_NUM"));
						
						///////////////////////////////////////////////////////////////////////////////////////////////
						//				카드 결제						
						///////////////////////////////////////////////////////////////////////////////////////////////
						//결제 테이블입력용 변수처리////////////////////////////////////////////////////
						//신용카드결제
						PAX_NO               	= ""; 
						CARD_PAYMT_AMT       	= goodsPrice;    				//'결제_금액'(상품가격); 
						CARD_KI_GB 				= resultMap.get("P_CARD_PURCHASE_CODE");	//'카드_종류_GB'(카드발급사);
						CARD_NO 				= resultMap.get("P_VACT_NUM");    //'카드_번호';
						CARD_EXPIR_DATE_MN 		= "";    						//'카드_유효기간_월'===========알수없음;
						CARD_EXPIR_DATE_YEAR 	= "";    						//'카드_유효기간_년도'===========알수없음;
						CARD_INSTALLMN_MN 		= resultMap.get("P_RMESG2");	//'카드_할부_개월';
						CARD_OWNER_GB        	= "";     						//'카드_소유_GB'===========알수없음;
						CARD_RELAT_GB 		 	= "";    						//'카드_관계_GB'===========알수없음;
						CARD_OWNER_NM 			= "";    						//'카드_소유자_명'===========알수없음;
						CARD_CVS_NO 			= "";    						//'카드_CVS_번호'===========알수없음;
						CARD_APPROVE_NO 		= resultMap.get("P_AUTH_NO");   //'카드_승인_번호'(카드승인번호);
						CARD_TID_NO 			= resultMap.get("P_TID");   	//'카드_승인_번호'(이니시스 승인/거래번호);
						CARD_OID_NO 			= resultMap.get("P_OID");		// 	결제OID
						APPROVE_CONF_YN      	= "Y";    						//'입금_처리_여부';
						FRONT_PASS           	= ""; 							//'앞_비밀번호';
						//////////////////////////////////////////////////////////////////////

						htlCardPaymtVO.setFIT_RSV_NO(FIT_RSV_NO);            
						htlCardPaymtVO.setPAX_NO(PAX_NO);                
						htlCardPaymtVO.setCARD_PAYMT_AMT(CARD_PAYMT_AMT);        
						htlCardPaymtVO.setCARD_KI_GB(CARD_KI_GB);            
						htlCardPaymtVO.setCARD_NO(CARD_NO);               
						htlCardPaymtVO.setCARD_EXPIR_DATE_MN(CARD_EXPIR_DATE_MN);    
						htlCardPaymtVO.setCARD_EXPIR_DATE_YEAR(CARD_EXPIR_DATE_YEAR);  
						htlCardPaymtVO.setCARD_INSTALLMN_MN(CARD_INSTALLMN_MN);     
						htlCardPaymtVO.setCARD_OWNER_GB(CARD_OWNER_GB);         
						htlCardPaymtVO.setCARD_RELAT_GB(CARD_RELAT_GB);         
						htlCardPaymtVO.setCARD_OWNER_NM(CARD_OWNER_NM);         
						htlCardPaymtVO.setCARD_CVS_NO(CARD_CVS_NO);           
						htlCardPaymtVO.setCARD_APPROVE_NO(CARD_APPROVE_NO);  
						htlCardPaymtVO.setTID_NO(CARD_TID_NO);
						htlCardPaymtVO.setOID_NO(CARD_OID_NO);
						htlCardPaymtVO.setAPPROVE_CONF_YN(APPROVE_CONF_YN);       
						htlCardPaymtVO.setFRONT_PASS(FRONT_PASS);            
						htlCardPaymtVO.setREGTOR_ID(custcd);             
						htlCardPaymtVO.setMODTOR_ID(custcd);         
						
						
						System.out.println("setCARD_KI_GB=" + CARD_KI_GB);
						System.out.println("setCARD_NO=" + CARD_NO);
						System.out.println("setCARD_APPROVE_NO=" + CARD_APPROVE_NO);
						System.out.println("setCARD_INSTALLMN_MN=" + CARD_INSTALLMN_MN);
						
										
						freeLpointDao.insertHtlCardPaymt(htlCardPaymtVO);						
						//////////////////////////////////////////////////////////////////////
				    }

		            // 복합결제일 경우 가상계좌 생성
		            if (cashPayAmt != null && !"".equals(cashPayAmt) && Integer.parseInt(cashPayAmt) > 0) {
						cashYn	=	"Y";		//	현금영수증 발급여부
		            	Map<String, String> merchantData = new HashMap<String, String>();
		            	
		            	goodName	=	URLDecoder.decode(String.valueOf(goodName), "UTF-8");
		            	
		            	merchantData.put("goodname", goodName);
		            	merchantData.put("cashPayAmt", cashPayAmt);
		            	merchantData.put("buyername", buyerName);
		            	merchantData.put("buyertel", buyerTel);
		            	merchantData.put("buyeremail", buyerEmail);
		            	merchantData.put("oid", resultMap.get("P_OID"));
		            	merchantData.put("vcdbank", vcdbank);
		            	merchantData.put("nminput", "");
		            	
	            		// 가상계좌 정보
	            		VAcctDepoNotiVO vAcctInfo = insertVacct(merchantData);
	            		
	            		if(!"00".equals(vAcctInfo.getResultCode()) ){
	            			throw new Exception("가상계좌 획득 오류");
	            		}
	            		
						CASH_AMT		= cashPayAmt;				//	현금결제금액
						BANK_CD_GB 		= vAcctInfo.getCd_bank();	//'은행_코드_GB';
						ACT_NO 			= vAcctInfo.getNo_vacct();  //'계좌_번호';
						ACT_PAYMTOR_NM 	= merchantData.get("");   	//'계좌_입금자_명';
						PAYMT_SCH_DT 	= vAcctInfo.getDtinput();   //'입금_예정_일자';
						NOTE            = "";
						PAYMT_CONF_YN   = "N";						//'입금_처리_여부';
						VIRTUAL_ACT_YN  = "Y";
						TID_NO			= vAcctInfo.getNo_tid();	//	거래번호

						accNoOwner		=	vAcctInfo.getNm_input();//	예금주명
						bankName		= getBankName(BANK_CD_GB);	//	은행명
						
						paymentVo.setVacctVo(vAcctInfo);

						htlActPaymtVO.setFIT_RSV_NO(FIT_RSV_NO);           
						htlActPaymtVO.setCASH_AMT(CASH_AMT);             
						htlActPaymtVO.setBANK_CD_GB(BANK_CD_GB);           
						htlActPaymtVO.setACT_NO(ACT_NO);               
						htlActPaymtVO.setACT_PAYMTOR_NM(ACT_PAYMTOR_NM);       
						htlActPaymtVO.setPAYMT_SCH_DT(PAYMT_SCH_DT);         
						htlActPaymtVO.setNOTE(NOTE);                 
						htlActPaymtVO.setCASH_RECEIPT_DIVI_GB(CASH_RECEIPT_DIVI_GB); 
						htlActPaymtVO.setPAYMT_CONF_YN(PAYMT_CONF_YN);        
						htlActPaymtVO.setVIRTUAL_ACT_YN(VIRTUAL_ACT_YN);       
						htlActPaymtVO.setTID_NO(TID_NO);               
						htlActPaymtVO.setREGTOR_ID(custcd);            
						htlActPaymtVO.setMODTOR_ID(custcd);            
						//////////////////////////////////////////////////////////////////////
						
						freeLpointDao.insertHtlActPaymt(htlActPaymtVO);						
						//////////////////////////////////////////////////////////////////////
		            }

		            ///////////////////////////////////////////////////////////////////////////////////////////////
					//	상품권 관련 입력
					///////////////////////////////////////////////////////////////////////////////////////////////
					if(giftCard	!=null && !"".equals(giftCard)){
						//결제 테이블입력용 변수처리////////////////////////////////////////////////////
						//상품권
						GIFT_DIVI_GB = "JG";   								//'상품권_구분_GB';
						GIFT_NO = giftCard;    								//'상품권_번호';
						GIFT_AMT = giftCardAmt;    							//'상품권_금액';
						GIFT_RECP_YN = "N";    								//'상품권_수령_여부';
						FIT_RSV_NO	=	rescd;
						System.out.println("FIT_RSV_NO:" + FIT_RSV_NO);
						htlGiftPaymtVO.setGIFT_DIVI_GB(GIFT_DIVI_GB);
						htlGiftPaymtVO.setGIFT_NO(GIFT_NO);
						htlGiftPaymtVO.setGIFT_AMT(GIFT_AMT);
						htlGiftPaymtVO.setGIFT_RECP_YN(GIFT_RECP_YN);
						htlGiftPaymtVO.setREGTOR_ID(custcd);            
						htlGiftPaymtVO.setMODTOR_ID(custcd);    
						htlGiftPaymtVO.setFIT_RSV_NO(FIT_RSV_NO);
						//////////////////////////////////////////////////////////////////////
						freeLpointDao.insertHtlGiftPaymt(htlGiftPaymtVO);		
						//////////////////////////////////////////////////////////////////////
					}
					///////////////////////////////////////////////////////////////////////////////////////////////

					///////////////////////////////////////////////////////////////////////////////////////////////
					//	L.Point 로직 시작	: L.Point관련 데이터를 merchantData에 담아 inicis에 던져서 그대로 받고 pasing하여 사용한다.					
					///////////////////////////////////////////////////////////////////////////////////////////////
					if(lottePoint != null && !"".equals(lottePoint) && Integer.parseInt(lottePoint) > 0){
						// L Point 연동처리(사용)
						LPointVO lpointVo	=	getLPointUse (rescd, cardNo, wpw, startDay, lottePoint, pointFg, custcd);
						
						if(!"00".equals(lpointVo.getCode())){
							throw new Exception("L.Point error : resultCode[" + lpointVo.getCode() + "]");
						}

						//결제 테이블입력용 변수처리////////////////////////////////////////////////////
						ETC_USE_YN     = "Y";
						ETC_PAYMT_AMT  = L_POINT_AMT;
						PAYMT_CONF_YN  = "Y";
						NOTE           = "LPOINT";
						
						htlEtcPaymtVO.setFIT_RSV_NO(FIT_RSV_NO);     
						htlEtcPaymtVO.setETC_USE_YN(ETC_USE_YN);     
						htlEtcPaymtVO.setETC_PAYMT_AMT(ETC_PAYMT_AMT);  
						htlEtcPaymtVO.setPAYMT_CONF_YN(PAYMT_CONF_YN);  
						htlEtcPaymtVO.setNOTE(NOTE);           
						htlEtcPaymtVO.setREGTOR_ID(custcd);      
						htlEtcPaymtVO.setMODTOR_ID(custcd);      
						
						//////////////////////////////////////////////////////////////////////
						freeLpointDao.insertHtlEtcPaymt(htlEtcPaymtVO);		
						//////////////////////////////////////////////////////////////////////
					}
					///////////////////////////////////////////////////////////////////////////////////////////////
					
					///////////////////////////////////////////////////////////////////////////////////////////////
					//	현금영수증 관련 입력
					///////////////////////////////////////////////////////////////////////////////////////////////
//					///////////////////////////////////////////////////////////////////////////////////////////////

//					///////////////////////////////////////////////////////////////////////////////////////////////
//					//	자유여행 결제DB 입력
//					///////////////////////////////////////////////////////////////////////////////////////////////
					faFitRsvMstVO.setFIT_RSV_NO(FIT_RSV_NO);
					if( ACT_NO != null && !"".equals(ACT_NO) ){	//	가상계좌번호가 있으면 WA
						faFitRsvMstVO.setHTL_RSVSTATE_GB("WA");
						faFitRsvMstVO.setHTL_PAYMTSTATE_GB("WA");	//	없으면 OK
					}else{
						faFitRsvMstVO.setHTL_RSVSTATE_GB("OK");
						faFitRsvMstVO.setHTL_PAYMTSTATE_GB("OK");
					}
					
					faFitRsvMstVO.setMODTOR_ID(custcd);
					
					freeLpointDao.updateRsvMst(faFitRsvMstVO);

					airReceiptReqVO.setAIR_RSV_SEQNO(FIT_RSV_NO);			// '호텔_예약_일련번호';
					airReceiptReqVO.setRECEIPT_DIVI_GB(RECEIPT_DIVI_GB);    // '영수증_구분_GB';
					airReceiptReqVO.setISSUE_HTEL(ISSUE_HTEL);    			// '발급_휴대전화';
					airReceiptReqVO.setCORP_NO(CORP_NO);    				// '사업자_번호';		
					
					if("Y".equals(cashYn)){
						freeLpointDao.insertHtlReceiptReq(airReceiptReqVO);
					}
					///////////////////////////////////////////////////////////////////////////////////////////////
//					================================================================================================

					
				} catch (Exception ex) {
	
					//####################################
					// 실패시 처리(***가맹점 개발수정***)
					//####################################
	
					//---- db 저장 실패시 등 예외처리----//
					System.out.println("결제 실패: " +  ex);
	
//					//#####################
//					// 모바일은 취소가 없으므로 웹의 취소 로직을 따른다.
//					//#####################
					System.out.println("## 취소 API 결과 ##");
					
					Map<String, String> cancelMap = new HashMap<String, String>();
					
					cancelMap.put("cancelreason", "");
					cancelMap.put("mid", mId);
					cancelMap.put("tid", cancelTid);
					cancelMap.put("msg", "System Error");
					
					cancelPayment(cancelMap);
					// 취소 결과 확인
					System.out.println("취소 결과 확인: " +  paymentVo.getResultCode().replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
					
				}
	
			} else {
	
				//#############
				// 인증 실패시
				//#############
				
				System.out.println("#### 인증실패 FREE####");
				originalStr	=	paramMap.get("P_RMESG1");
//				String [] charSet = {"utf-8","euc-kr","ksc5601","iso-8859-1","x-windows-949"};
//				for (int i=0; i<charSet.length; i++) {
//					for (int j=0; j<charSet.length; j++) {
//						try {
//							System.out.println("[" + charSet[i] +"," + charSet[j] +"] = " + new String(originalStr.getBytes(charSet[i]), charSet[j]));
//						} catch (UnsupportedEncodingException e) {
//							e.printStackTrace();
//						}
//					}
//				}
				paramMap.put("P_RMESG1", new String(originalStr.getBytes("iso-8859-1"), "euc-kr"));

				System.out.println("paramMap FREE:" +  paramMap.toString());
				System.out.println("결과 내용FREE1: " +  paramMap.get("P_RMESG1"));
				
	
			}
		
		} catch (Exception e) {

			System.out.println("Exception: " + e);
			
		}
		paymentVo.setResCd(rescd);
		
		VAcctDepoNotiVO vacctVo = new VAcctDepoNotiVO();
		
		if(ACT_NO != null && !"".equals(ACT_NO)){
			vacctVo.setNo_vacct(ACT_NO);			// 가상계좌번호		
			vacctVo.setNm_input(accNoOwner);		// 예금주명
			vacctVo.setNm_inputbank(bankName);			// 상점주문번호

			paymentVo.setVacctVo(vacctVo);
		}else{
			paymentVo.setVacctVo(null);
		}
		return paymentVo;
	}

	
	/**
	 * 항공 결제 인증수신/승인API 처리
	 * 
     * @param paramMap 결제승인 정보
     * @return 결제 인증 및 승인 결과
	 * @throws Exception 결제 인증 및 승인 시 발생하는 예외
	 */
	@Override
	public PaymentVO authAndApprAirPay(Map<String, String> paramMap) throws Exception {

		PaymentVO paymentVo = new PaymentVO();
		AirRsvPaymtVO airRsvPaymtVO = new AirRsvPaymtVO();
		AirActPaymtVO airActPaymtVO = new AirActPaymtVO();
		AirReceiptReqVO airReceiptReqVO = new AirReceiptReqVO();

		String rescd		=	"";			//	예약번호
		String buyerName	=	"";

//		String cashPayAmt	=	"";
//		String cashType		=	"";			//	현금영수증타입(0:소득공제(소비자용), 1:지출증빙(사업자용))	
//		String cashReceipts	=	"";			//	현금영수증인증번호(핸드폰번호, 사업자등록번호)	
		
		//자유여행 항공결제정보 저장용 변수///////////////////////////////////////////////////////////////////
		int AIR_RSV_SEQNO			= 0 ;    // '항공_예약_일련번호';
		int PAYMT_APPROVE_AMT		= 0;    // '결제_승인_금액';
		int PAYMT_UNPAID_AMT		= 0 ;    // '결제_미수_금액';
		int TASF_AMT				= 0 ;    // 'TASF_금액';  
		String CARD_USE_YN			= "N";    // '카드_사용_여부';
		String CARD_ALL_YN			= "N";    // '카드_전체_여부';
		String ACT_USE_YN			= "Y";    // '무통장_사용_여부';
		String GIFT_USE_YN			= "N";    // '상품권_사용_여부';
		String ETC_USE_YN			= "N";    // '기타_사용_여부';
		String REGTOR_ID			= "" ;    // '등록자_ID';
		String MODTOR_ID			= "" ;    // '수정자_ID';
		
		int CASH_AMT				= 0 ;    // '현금_금액';
		String BANK_CD_GB			= "" ;    // '은행_코드_GB';
		String ACT_NO				= "" ;    // '계좌_번호';
		String ACT_PAYMTOR_NM		= "" ;    // '계좌_입금자_명';
		String PAYMT_SCH_DT			= "" ;    // '입금_예정_일자';
		String PAYMT_SCH_HM			= "" ;	  // 임금마감시간	
		String NOTE					= "" ;    // '비고';
		String CASH_RECEIPT_DIVI_GB	= "" ;    // '현금_영수증_구분_GB';
		String PAYMT_CONF_YN		= "N";    // '입금_확인_여부';
		String VIRTUAL_ACT_YN		= "Y";    // '가상_계좌_여부';
		String TID_NO				= "" ;    // 'TID_NO';
		String OID_NO				= "" ;    //이니시스 주문번호
		
		String RECEIPT_DIVI_GB		= "";    // '영수증_구분_GB';
		String ISSUE_HTEL			= "";    // '발급_휴대전화';
		String CORP_NO				= "";    // '사업자_번호';		
		
		String accNoOwner			=	"";		//	예금주명
		String bankName				=	"";		//	은행명
		
		//한글변환용
		String originalStr	=	"";
		//취소용TID
		String cancelTid	=	"";
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		try {

			//#####################
			// 인증이 성공일 경우만
			//#####################
			if ("00".equals(paramMap.get("P_STATUS"))) {
	
				System.out.println("#### 인증성공/승인요청 ####");
				
				//############################################
				// 1. 전문 필드 값 설정(***가맹점 개발수정***)
				//############################################
				
				String pTID		= paramMap.get("P_TID");
				String authUrl	= paramMap.get("P_REQ_URL");
				System.out.println("type:VBANK");
				String mId = propertiesService.getString("payment.Vbank.mId");
				
				//#####################
				// 3. API 요청 전문 생성
				//#####################
						
				Map<String, String> authMap = new HashMap<String, String>();
	
				authMap.put("P_TID"			,pTID);			// 필수
				authMap.put("P_MID"			,mId);			// 필수
				
				System.out.println("## 승인요청 API 요청 ##");
	
				HttpUtil httpUtil = new HttpUtil();
				
				try {
	
					//#####################
					// 4. API 통신 시작
					//#####################
	
					String authResultString = "";
					
					authResultString = httpUtil.processHTTP(authMap, authUrl);
					
					//############################################################
					// 5. API 통신결과 처리(***가맹점 개발수정***)
					//############################################################
					System.out.println("## 승인 API 결과 ##");
					
					String test = authResultString.replace(",", "&").replace(":", "=").replace("\"", "").replace(" ","").replace("\n", "").replace("}", "").replace("{", "");
					
					//out.println("<pre>"+authResultString.replaceAll("<", "&lt;").replaceAll(">", "&gt;")+"</pre>");
	
					Map<String, String> resultMap = new HashMap<String, String>();
					
					resultMap = ParseUtil.parseStringToMap(test); //문자열을 MAP형식으로 파싱
	
					if ("00".equals(resultMap.get("P_STATUS")) ) {	//결제보안 강화 2016-05-18
					   /*****************************************************************************
				       * 여기에 가맹점 내부 DB에 결제 결과를 반영하는 관련 프로그램 코드를 구현한다.  
					   
						 [중요!] 승인내용에 이상이 없음을 확인한 뒤 가맹점 DB에 해당건이 정상처리 되었음을 반영함
								  처리중 에러 발생시 망취소를 한다.
				       ******************************************************************************/
	
						originalStr	=	resultMap.get("P_RMESG1");
						resultMap.put("P_RMESG1", new String(originalStr.getBytes("iso-8859-1"), "euc-kr"));
						// 결과정보
						System.out.println("결과 코드2: " +  resultMap.get("P_STATUS"));
						System.out.println("결과 내용2: " +  resultMap.get("P_RMESG1"));
						
						paymentVo.setIsSuccDeal(Boolean.TRUE); // 거래 성공 여부
						paymentVo.setResultCode(resultMap.get("P_STATUS")); // 결과 코드
						paymentVo.setResultMsg(resultMap.get("P_RMESG1")); // 결과 메시지
	
					} else {
	
						originalStr	=	resultMap.get("P_RMESG1");
						resultMap.put("P_RMESG1", new String(originalStr.getBytes("iso-8859-1"), "euc-kr"));

						paymentVo.setIsSuccDeal(Boolean.FALSE); // 거래 성공 여부
						paymentVo.setResultCode(resultMap.get("P_STATUS")); // 결과 코드
						paymentVo.setResultMsg(resultMap.get("P_RMESG1")); // 결과 메시지
	
					}
						
					// 공통 부분만
					System.out.println("거래 번호: " +  resultMap.get("P_TID"));
					System.out.println("결제방법(지불수단): " +  resultMap.get("P_TYPE"));
					System.out.println("결제완료금액: " +  resultMap.get("P_AMT"));
					System.out.println("주문 번호: " +  resultMap.get("P_OID"));
					System.out.println("승인날짜: " +  resultMap.get("P_AUTH_DT"));	//	YYYYmmddHHmmss
					
					cancelTid	=	resultMap.get("P_TID");

					String[] splitParam	=	URLDecoder.decode(String.valueOf(paramMap.get("P_NOTI")), "UTF-8").split("\t");
					
					rescd			=	splitParam[0]; 		//	예약번호
					if("1".equals(splitParam[1])){
						CASH_RECEIPT_DIVI_GB	=	"002";
						RECEIPT_DIVI_GB			=	"002";
						CORP_NO					= splitParam[2];    // '사업자_번호';	
					}else{
						CASH_RECEIPT_DIVI_GB	=	"001";
						RECEIPT_DIVI_GB			=	"001";
						ISSUE_HTEL				= splitParam[2];    // '발급_휴대전화';
					}
					
					if(splitParam.length > 3){
						TASF_AMT			=	Integer.parseInt(splitParam[3]);
					}
					//결제 테이블입력용 변수처리////////////////////////////////////////////////////
					AIR_RSV_SEQNO 		= Integer.parseInt(rescd);   					//'자유여행_예약_번호';
					TID_NO				= resultMap.get("P_TID") ;    					// 'TID_NO';
					OID_NO				= resultMap.get("P_OID");						// 이니시스 주문번호
					PAYMT_UNPAID_AMT 	= Integer.parseInt(resultMap.get("P_AMT"));		//'결제_금액'(상품가격);
					CASH_AMT 			= Integer.parseInt(resultMap.get("P_AMT"));		//'결제_금액'(가상계좌입금금액);
					//////////////////////////////////////////////////////////////////////
					
					// 수신결과를 파싱후 resultCode가 "0000"이면 승인성공 이외 실패
					// 가맹점에서 스스로 파싱후 내부 DB 처리 후 화면에 결과 표시
					// 내부DB 저장 로직 추가
					if ("VBANK".equals(resultMap.get("P_TYPE"))) { // 가상계좌
						
						originalStr	=	resultMap.get("P_VACT_NAME");
						resultMap.put("P_VACT_NAME", new String(originalStr.getBytes("iso-8859-1"), "euc-kr"));

						System.out.println("입금 계좌번호: " +  resultMap.get("P_VACT_NUM"));
						System.out.println("입금 은행코드: " +  resultMap.get("P_VACT_BANK_CODE"));
						System.out.println("예금주 명: " +  resultMap.get("P_VACT_NAME"));		
						System.out.println("송금 일자: " +  resultMap.get("P_VACT_DATE"));
						System.out.println("송금 시간: " +  resultMap.get("P_VACT_TIME"));
						System.out.println("주문번호: " + resultMap.get("P_OID"));

						//결제 테이블입력용 변수처리////////////////////////////////////////////////////
						// 가상계좌
						BANK_CD_GB 		= resultMap.get("P_VACT_BANK_CODE");    			//'은행_코드_GB';
						ACT_NO 			= resultMap.get("P_VACT_NUM");    					//'계좌_번호';
//						ACT_PAYMTOR_NM 	= resultMap.get("VACT_InputName");   				//'계좌_입금자_명';
						PAYMT_SCH_DT 	= resultMap.get("P_VACT_DATE");    					//'입금_예정_일자';
						PAYMT_SCH_HM 	= resultMap.get("P_VACT_TIME");						// 입금 마감시간   hh:mm:ss
						accNoOwner		=	resultMap.get("P_VACT_NAME");					//	예금주명
						bankName		= getBankName(resultMap.get("P_VACT_BANK_CODE"));	//	은행명  -- 찾는 로직 추가
						//////////////////////////////////////////////////////////////////////
					}

					///////////////////////////////////////////////////////////////////////////////////////////////
					//	상품권 관련 입력
					///////////////////////////////////////////////////////////////////////////////////////////////
					// 없음
					///////////////////////////////////////////////////////////////////////////////////////////////

					///////////////////////////////////////////////////////////////////////////////////////////////
					//	L.Point 로직 시작	: L.Point관련 데이터를 merchantData에 담아 inicis에 던져서 그대로 받고 pasing하여 사용한다.					
					///////////////////////////////////////////////////////////////////////////////////////////////
					// 없음
					///////////////////////////////////////////////////////////////////////////////////////////////
					
					///////////////////////////////////////////////////////////////////////////////////////////////
					//	복합결제 시 현금결제금액 관련 처리
					///////////////////////////////////////////////////////////////////////////////////////////////
					//	없음
					///////////////////////////////////////////////////////////////////////////////////////////////

					///////////////////////////////////////////////////////////////////////////////////////////////
					//	자유여행 결제DB 입력
					///////////////////////////////////////////////////////////////////////////////////////////////
					
					//입금 기한을 결제 시간 기준 24시간 까지 하도록 조정 
					//입금마감시간 시분까지 4자리만 짤라서  넣어주어야 함. 
					PAYMT_SCH_HM = PAYMT_SCH_HM.substring(0, 4);
					
					airRsvPaymtVO.setAIR_RSV_SEQNO(AIR_RSV_SEQNO);			// '항공_예약_일련번호';
					airRsvPaymtVO.setPAYMT_APPROVE_AMT(PAYMT_APPROVE_AMT);  // '결제_승인_금액';
					airRsvPaymtVO.setPAYMT_UNPAID_AMT(PAYMT_UNPAID_AMT);    // '결제_미수_금액';
					airRsvPaymtVO.setTASF_AMT(TASF_AMT);    				// 'TASF_금액';   
					airRsvPaymtVO.setCARD_USE_YN(CARD_USE_YN);    			// '카드_사용_여부';
					airRsvPaymtVO.setCARD_ALL_YN(CARD_ALL_YN);    			// '카드_전체_여부';
					airRsvPaymtVO.setACT_USE_YN(ACT_USE_YN);    			// '무통장_사용_여부';
					airRsvPaymtVO.setGIFT_USE_YN(GIFT_USE_YN);    			// '상품권_사용_여부';
					airRsvPaymtVO.setETC_USE_YN(ETC_USE_YN);    			// '기타_사용_여부';
					airRsvPaymtVO.setREGTOR_ID(REGTOR_ID);    				// '등록자_ID';
					airRsvPaymtVO.setMODTOR_ID(MODTOR_ID);    				// '수정자_ID';
					
					airActPaymtVO.setAIR_RSV_SEQNO(AIR_RSV_SEQNO);			// '항공_예약_일련번호';
					airActPaymtVO.setCASH_AMT(CASH_AMT);					// '현금금액';
					airActPaymtVO.setBANK_CD_GB(BANK_CD_GB);    			// '은행_코드_GB';
					airActPaymtVO.setACT_NO(ACT_NO);    					// '계좌_번호';
					airActPaymtVO.setACT_PAYMTOR_NM(ACT_PAYMTOR_NM);    	// '계좌_입금자_명';
					airActPaymtVO.setPAYMT_SCH_DT(PAYMT_SCH_DT);    		// '입금_예정_일자';
					airActPaymtVO.setPAYMT_SCH_HM(PAYMT_SCH_HM);			//  입금 마감시간      
					airActPaymtVO.setNOTE(NOTE);    						// '비고';
					airActPaymtVO.setCASH_RECEIPT_DIVI_GB(CASH_RECEIPT_DIVI_GB);    // '현금_영수증_구분_GB';
					airActPaymtVO.setPAYMT_CONF_YN(PAYMT_CONF_YN);    		// '입금_확인_여부';
					airActPaymtVO.setVIRTUAL_ACT_YN(VIRTUAL_ACT_YN);   		// '가상_계좌_여부';
					airActPaymtVO.setOID_NO(OID_NO);						//이니시스 주문번호;
					airActPaymtVO.setTID_NO(TID_NO);    					// 'TID_NO';
					airActPaymtVO.setREGTOR_ID(REGTOR_ID);    				// '등록자_ID';
					airActPaymtVO.setMODTOR_ID(MODTOR_ID);    				// '수정자_ID';
					
					airReceiptReqVO.setAIR_RSV_SEQNO(Integer.toString(AIR_RSV_SEQNO));		// '항공_예약_일련번호';
					airReceiptReqVO.setRECEIPT_DIVI_GB(RECEIPT_DIVI_GB);    // '영수증_구분_GB';
					airReceiptReqVO.setISSUE_HTEL(ISSUE_HTEL);    			// '발급_휴대전화';
					airReceiptReqVO.setCORP_NO(CORP_NO);    				// '사업자_번호';		
					airReceiptReqVO.setREGTOR_ID(REGTOR_ID);    			// '등록자_ID';
					airReceiptReqVO.setMODTOR_ID(MODTOR_ID);    			// '수정자_ID';

					freeLpointDao.insertAirRsvPaymt(airRsvPaymtVO);

					freeLpointDao.insertAirActPaymt(airActPaymtVO);
					
					freeLpointDao.insertAirReceiptReq(airReceiptReqVO);

					HashMap<String, Object> param = new HashMap<String, Object>();
					
					param.put("MODTOR_ID", MODTOR_ID);
					param.put("AIR_RSV_SEQNO", AIR_RSV_SEQNO);
					
					freeLpointDao.updateAirRsvMst(param);
//					///////////////////////////////////////////////////////////////////////////////////////////////
//					================================================================================================

					
				} catch (Exception ex) {
	
					//####################################
					// 실패시 처리(***가맹점 개발수정***)
					//####################################
	
					//---- db 저장 실패시 등 예외처리----//
					System.out.println("결제 실패: " +  ex);
	
					Map<String, String> cancelMap = new HashMap<String, String>();
					
					cancelMap.put("cancelreason", "");
					cancelMap.put("mid", mId);
					cancelMap.put("tid", cancelTid);
					cancelMap.put("msg", "System Error");
					
					cancelPayment(cancelMap);
					// 취소 결과 확인
					System.out.println("취소 결과 확인: " +  paymentVo.getResultCode().replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
					
				}
	
			} else {
	
				//#############
				// 인증 실패시
				//#############
				
				System.out.println("#### 인증실패 ####");
				System.out.println("paramMap: " +  paramMap.toString());
	
			}
		
		} catch (Exception e) {

			System.out.println("Exception: " + e);
			
		}
		paymentVo.setResCd(rescd);
		VAcctDepoNotiVO vacctVo = new VAcctDepoNotiVO();
		
		if(ACT_NO != null && !"".equals(ACT_NO)){
			vacctVo.setNo_vacct(ACT_NO);			// 가상계좌번호		
			vacctVo.setNm_input(accNoOwner);		// 예금주명
			vacctVo.setNm_inputbank(bankName);			// 상점주문번호

			paymentVo.setVacctVo(vacctVo);
		}else{
			paymentVo.setVacctVo(null);
		}
		return paymentVo;
	}

	/**
	 * 가상계좌 생성
	 * 
     * @param paymentVo 결제정보 vo
     * @return 생성된 가상계좌 정보
	 * @throws Exception 가상계좌 생성 시 발생하는 에외
	 */
	/* (non-Javadoc)
	 * @see com.lottejtb.front.payment.service.PaymentService#insertVacct(org.json.simple.JSONObject)
	 */
	@Override
	public VAcctDepoNotiVO insertVacct(Map<String, String> merchantData) throws Exception {

		System.out.println("가상계좌 생성 파라미터: " + merchantData.toString());
		
		VAcctDepoNotiVO vAcctDepoNotiVO = new VAcctDepoNotiVO();

		try {

			//#############################################################################
			//# 1. INIpay 클래스의 인스턴스 생성 #
			//#############################################################################
			com.inicis.inipay4.INIpay inipay = new com.inicis.inipay4.INIpay();
			com.inicis.inipay4.util.INIdata data = new com.inicis.inipay4.util.INIdata();
			
			//#############################################################################
			//# 2. 정보 설정 #
			//#############################################################################
			String inipayHome = propertiesService.getString("payment.inipayHome");
			String logMode = propertiesService.getString("payment.logMode");
			String keyPW = propertiesService.getString("payment.keyPW");
			System.out.println("type:VBANK");
			String mId = propertiesService.getString("payment.Vbank.mId");

			// 입금예정일(현재 일 기준 7일)
			String dpstDueDate = "";
			if(merchantData.get("dtinput") == null || "".equals(merchantData.get("dtinput"))){
				dpstDueDate	=	DateUtil.addDay(DateUtil.getToday(), 7);
			}else{
				dpstDueDate	=	merchantData.get("dtinput");
			}
			data.setData("type", "vbank");                                    			// 결제 type(수정불가)
			data.setData("inipayHome", inipayHome);            							// 이니페이가 설치된 절대경로
			data.setData("logMode", logMode);                                			// logMode
			data.setData("keyPW", keyPW);                                    			// 키패스워드
			data.setData("subPgip","203.238.37.3");                           			// Sub PG IP (고정)
			data.setData("mid", mId);              										// 상점아이디
			data.setData("uid", mId);            										// INIpay User ID
			data.setData("goodname", URLDecoder.decode(String.valueOf(merchantData.get("goodname")), "UTF-8"));	  // 상품명 (최대 40자)
			data.setData("currency", propertiesService.getString("payment.currency")); 	// 화폐단위
			data.setData("price", String.valueOf(merchantData.get("cashPayAmt")));      // 가격
			data.setData("buyername", URLDecoder.decode(String.valueOf(merchantData.get("buyername")), "UTF-8")); // 구매자 (최대 15자)
			data.setData("buyertel", String.valueOf(merchantData.get("buyertel")));     // 구매자이동전화
			data.setData("buyeremail", String.valueOf(merchantData.get("buyeremail")));	// 구매자이메일
			data.setData("paymethod", "VBank");											// 지불수단. (VBank고정,대소문자 유의 절대수정불가)
			data.setData("url", "http://www.your_domain.co.kr");						// 홈페이지 주소(URL)
			data.setData("uip", "127.0.0.1");											// IP Addr
			data.setData("crypto", "execure");                        					// Extrus 암호화 모듈 적용(고정)

			//data.setData("perno", paramMap.get("perno1") + paramMap.get("perno2")); 	// 주민번호(선택)
			data.setData("void", String.valueOf(merchantData.get("oid")));  	  		// 상점주문번호(필수)
			data.setData("vcdbank", String.valueOf(merchantData.get("vcdbank"))); 		// 은행코드 (필수)
			data.setData("dtinput", dpstDueDate); 										// 입금예정일 (필수)
			data.setData("nminput", String.valueOf(merchantData.get("nminput"))); 		// 입금자명
			//data.setData("tminput", paramMap.get("tminput")); 						// 입금예정시각(선택)
			data.setData("vacct_type", "1");
			//data.setData("recvname", paramMap.get("recvname"));  						// 수취인명(선택)
			//data.setData("recvtel", paramMap.get("recvtel")); 						// 수취연락처(선택)
			//data.setData("recvaddr", paramMap.get("recvaddr")); 						// 수취인주소(선택)
			//data.setData("recvpostnum", paramMap.get("recvpostnum")); 				// 수취인우편번호(선택)
			//data.setData("recvmsg", paramMap.get("recvmsg")); 						// 전달메시지(선택)
	
			//###############################################################################
			//# 3. 지불 요청 #
			//###############################################################################  
			data = inipay.payRequest(data);
			
			System.out.println("가상계좌 지불 요청 데이터: " +  data);
			System.out.println("가상계좌 지불 요청 데이터: " +  data.getData("ResultCode"));
		
			//###############################################################################
			//# 4. ACK 요청 및 DB처리 #
			//############################################################################### 
			if ("00".equals(data.getData("ResultCode"))) {

				if (inipay.payAck()) {
			        try {
						// 채번된 가상계좌 정보 설정
						vAcctDepoNotiVO.setResultCode(data.getData("ResultCode"));	// 승인 결과코드 (00: 결제성공, 01: 결제실패)
						vAcctDepoNotiVO.setResultMsg(data.getData("ResultMsg"));	// 승인 결과 메시지
						vAcctDepoNotiVO.setPayMethod(data.getData("paymethod"));	// 결제 지불방법(지불수단)
						vAcctDepoNotiVO.setNo_tid(data.getData("tid"));				// 거래번호
						vAcctDepoNotiVO.setPgAuthDate(data.getData("PGauthdate"));	// PG 승인 일자
						vAcctDepoNotiVO.setPgAuthTime(data.getData("PGauthtime"));	// PG 승인 시간
						vAcctDepoNotiVO.setNo_vacct(data.getData("vacct"));			// 가상계좌번호		
						vAcctDepoNotiVO.setCd_bank(data.getData("vcdbank"));		// 은행코드
						vAcctDepoNotiVO.setPerno(data.getData("perno"));			// 송금자주민번호 (요청시 미입력할 경우 NULL)												
						vAcctDepoNotiVO.setDtinput(data.getData("dtinput"));		// 입금예정일
						vAcctDepoNotiVO.setTmInput(data.getData("tminput"));		// 입금예정시각						
						vAcctDepoNotiVO.setNm_input(data.getData("nmvacct"));		// 예금주명
						vAcctDepoNotiVO.setNo_oid(data.getData("void"));			// 상점주문번호
						
						System.out.println("가상계좌 채번 정보: " +  vAcctDepoNotiVO.toString());

					} catch (Exception e) {  // DB처리중 exception 발생시, 채번요청건 자동취소

						System.out.println("DB 처리중 예외 발생:" + e);
						
						data.setData("type", "cancel");                   	// 결제 type
						data.setData("inipayHome", inipayHome);           	// 이니페이가 설치된 절대경로
						data.setData("logMode", logMode);                 	// logMode
						data.setData("keyPW", keyPW);                      	// Sub PG IP (고정)
						data.setData("mid", mId); 						  	// 상점아이디
						data.setData("tid", data.getData("oid") );        	// 취소할 TID
						data.setData("cancelMsg", "MERCHANT'S DB FAIL");	// INIpay User ID
						//data.setData("uip", request.getRemoteAddr());     // IP Addr
						data.setData("uip", "127.0.0.1");     				// IP Addr

						data = inipay.payRequest(data);
					}
				}
			}
		
			vAcctDepoNotiVO.setResultCode(data.getData("ResultCode"));
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.print("INIPay Error!");
		}
		
		return vAcctDepoNotiVO;
	}

	
	/**
	 * 결제를 취소한다
	 * 
	 * @param paramMap 결제 취소 정보
	 * @return 결제 취소 결과
	 * @throws Exception 결제 취소 시 발생하는 예외
	 */
	@Override
	public PaymentVO cancelPayment(Map<String, String> paramMap) throws Exception {
		PaymentVO paymentVo = new PaymentVO();
		
		try {
		
			/***************************************
			 * 1. INIpay 클래스의 인스턴스 생성
			 ***************************************/
			INIpay inipay = new INIpay();
			
			/*********************
			 * 2. 취소 정보 설정
			 *********************/
			inipay.SetField("inipayhome", propertiesService.getString("payment.inipayHome"));  	// 이니페이 홈디렉터리(상점수정 필요)
			inipay.SetField("type", "cancel");                   			// 고정 (절대 수정 불가)
			inipay.SetField("debug", "true");                    			// 로그모드("true"로 설정하면 상세로그가 생성됨.)
			inipay.SetField("mid", paramMap.get("mid"));         			// 상점아이디
			inipay.SetField("admin", "1111");                             	// 상점 키패스워드 (비대칭키)
			inipay.SetField("cancelreason", paramMap.get("cancelreason"));  // 현금영수증 취소코드
			  
			//***********************************************************************************************************
			//* admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다.      *
			//* 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해 주시기 바랍니다.*
			//* 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다.                               *
			//* 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오.             *
			//***********************************************************************************************************
			inipay.SetField("tid", paramMap.get("tid")); 		// 취소할 거래의 거래아이디
			inipay.SetField("cancelmsg", paramMap.get("msg"));  // 취소사유
			inipay.SetField("crypto", "execure");				// Extrus 암호화모듈 사용(고정)
	
			/****************
			 * 3. 취소 요청
			 ****************/
			inipay.startAction();
	
			/****************************************************************
			 * 4. 취소 결과
			 ****************************************************************/					
			paymentVo.setResultCode(inipay.GetResult("ResultCode")); // 결과코드
			paymentVo.setResultMsg(inipay.GetResult("ResultMsg")); // 결과내용
			paymentVo.settId(inipay.GetResult("tid")); // 거래번호
			paymentVo.setCancelDate(inipay.GetResult("CancelDate")); // 취소날짜
			paymentVo.setCancelTime(inipay.GetResult("CancelTime")); // 취소시각
			paymentVo.setCshrCancelNum(inipay.GetResult("CSHR_CancelNum")); // 현금영수증 취소승인번호
			System.out.println("취소결과:" + inipay.GetResult("ResultCode"));
			System.out.println("취소결과:" + inipay.GetResult("ResultMsg"));
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.print("INIPay Error!");
		}
		
		return paymentVo;
	}

	
	private String getBankName(String bankcd){ 
//		System.out.println("=============================bankcd:" + bankcd);
		String bankName	=	"";
		
	    switch (bankcd) {
			case	"02"  : bankName = "한국산업은행"; break;
			case	"03"  : bankName = "기업은행"; break;
			case	"04"  : bankName = "국민은행"; break;
			case	"05"  : bankName = "하나은행 (구 외환)"; break;
			case	"06"  : bankName = "국민은행 (구 주택)"; break;
			case	"07"  : bankName = "수협중앙회"; break;
			case	"11"  : bankName = "농협중앙회"; break;
			case	"12"  : bankName = "단위농협"; break;
			case	"16"  : bankName = "축협중앙회"; break;
			case	"20"  : bankName = "우리은행"; break;
			case	"21"  : bankName = "구)조흥은행"; break;
			case	"22"  : bankName = "상업은행"; break;
			case	"23"  : bankName = "SC제일은행"; break;
			case	"24"  : bankName = "한일은행"; break;
			case	"25"  : bankName = "서울은행"; break;
			case	"26"  : bankName = "구)신한은행"; break;
			case	"27"  : bankName = "한국씨티은행 (구 한미)"; break;
			case	"31"  : bankName = "대구은행"; break;
			case	"32"  : bankName = "부산은행"; break;
			case	"34"  : bankName = "광주은행"; break;
			case	"35"  : bankName = "제주은행"; break;
			case	"37"  : bankName = "전북은행"; break;
			case	"38"  : bankName = "강원은행"; break;
			case	"39"  : bankName = "경남은행"; break;
			case	"41"  : bankName = "비씨카드"; break;
			case	"45"  : bankName = "새마을금고"; break;
			case	"48"  : bankName = "신용협동조합중앙회"; break;
			case	"50"  : bankName = "상호저축은행"; break;
			case	"53"  : bankName = "한국씨티은행"; break;
			case	"54"  : bankName = "홍콩상하이은행"; break;
			case	"55"  : bankName = "도이치은행"; break;
			case	"56"  : bankName = "ABN 암로"; break;
			case	"57"  : bankName = "JP모건"; break;
			case	"59"  : bankName = "미쓰비시도쿄은행"; break;
			case	"60"  : bankName = "BOA(Bank of America)"; break;
			case	"64"  : bankName = "산림조합"; break;
			case	"70"  : bankName = "신안상호저축은행"; break;
			case	"71"  : bankName = "우체국"; break;
			case	"81"  : bankName = "하나은행"; break;
			case	"83"  : bankName = "평화은행"; break;
			case	"87"  : bankName = "신세계"; break;
			case	"88"  : bankName = "신한(통합)은행"; break;
			case	"D1"  : bankName = "유안타증권(구 동양증권)"; break;
			case	"D2"  : bankName = "현대증권"; break;
			case	"D3"  : bankName = "미래에셋증권"; break;
			case	"D4"  : bankName = "한국투자증권"; break;
			case	"D5"  : bankName = "우리투자증권"; break;
			case	"D6"  : bankName = "하이투자증권"; break;
			case	"D7"  : bankName = "HMC 투자증권"; break;
			case	"D8"  : bankName = "SK 증권"; break;
			case	"D9"  : bankName = "대신증권"; break;
			case	"DA"  : bankName = "하나대투증권"; break;
			case	"DB"  : bankName = "굿모닝신한증권"; break;
			case	"DC"  : bankName = "동부증권"; break;
			case	"DD"  : bankName = "유진투자증권"; break;
			case	"DE"  : bankName = "메리츠증권"; break;
			case	"DF"  : bankName = "신영증권"; break;
			case	"DG"  : bankName = "대우증권"; break;
			case	"DH"  : bankName = "삼성증권"; break;
			case	"DI"  : bankName = "교보증권"; break;
			case	"DJ"  : bankName = "키움증권"; break;
			case	"DK"  : bankName = "이트레이드"; break;
			case	"DL"  : bankName = "솔로몬증권"; break;
			case	"DM"  : bankName = "한화증권"; break;
			case	"DN"  : bankName = "NH증권"; break;
			case	"DO"  : bankName = "부국증권"; break;
			case	"DP"  : bankName = "LIG증권"; break;
		}		
	    
	    return bankName;
	}
	
    private String filledString(int number) {
        int numOfPosition = ((int)Math.floor(Math.log10((double)number))+1);
        int numOfZero = 3-numOfPosition;
        
        StringBuilder resultString = new StringBuilder();
        //String result = Integer.toString(number);
        resultString.append(Integer.toString(number));
        
        for(int i=0; i<numOfZero;i++){
        	resultString.insert(0, "0");
        	//result = "0"+result;
        }
        
        return resultString.toString();  
    }	  

	/**
	 * lpay 처리완료 후  DB처리
	 * 
     * @param paramMap 결제승인 정보
     * @return 결제 인증 및 승인 결과
	 * @throws Exception 결제 인증 및 승인 시 발생하는 예외
	 */
	@Override
	public PaymentVO lpayPayment(Map<String, String> paramMap) throws Exception {

		PaymentVO paymentVo = new PaymentVO();
		FaFitRsvMstVO faFitRsvMstVO = new FaFitRsvMstVO();
		AirReceiptReqVO airReceiptReqVO = new AirReceiptReqVO();
		HtlCardPaymtVO htlCardPaymtVO = new HtlCardPaymtVO();
		HtlActPaymtVO htlActPaymtVO = new HtlActPaymtVO();
		HtlEtcPaymtVO htlEtcPaymtVO = new HtlEtcPaymtVO();
		HtlGiftPaymtVO htlGiftPaymtVO = new HtlGiftPaymtVO();
		
		String RECEIPT_DIVI_GB		= "";    // '영수증_구분_GB';
		String ISSUE_HTEL			= "";    // '발급_휴대전화';
		String CORP_NO				= "";    // '사업자_번호';		

		String TID_NO	=	"";										//	이니시스TID
		String CASH_AMT	=	"";										//	현금 결제 금액
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//	가상계좌
    	String FIT_RSV_NO            = "";
    	String BANK_CD_GB            = "";
    	String ACT_NO                = "";
    	String ACT_PAYMTOR_NM        = "";
    	String PAYMT_SCH_DT          = "";
    	String NOTE                  = "";
    	String CASH_RECEIPT_DIVI_GB  = "";
    	String PAYMT_CONF_YN         = "";
    	String VIRTUAL_ACT_YN        = "";
    	String REGTOR_ID             = "";
    	String REG_DTT               = "";
    	String MODTOR_ID             = "";
    	String MOD_DTT               = "";
    	
    	//	기타
    	String ETC_USE_YN     = "";
    	String ETC_PAYMT_AMT  = "";

    	//	카드
    	String CARD_PAYMT_SEQNO     = ""; 
    	String PAX_NO               = ""; 
    	String CARD_PAYMT_AMT       = ""; 
    	String CARD_KI_GB           = ""; 
    	String CARD_NO              = ""; 
    	String CARD_EXPIR_DATE_MN   = ""; 
    	String CARD_EXPIR_DATE_YEAR = ""; 
    	String CARD_INSTALLMN_MN    = ""; 
    	String CARD_OWNER_GB        = ""; 
    	String CARD_RELAT_GB        = ""; 
    	String CARD_OWNER_NM        = ""; 
    	String CARD_CVS_NO          = ""; 
    	String CARD_APPROVE_NO      = ""; 
    	String APPROVE_CONF_YN      = ""; 
    	String FRONT_PASS           = ""; 
    	
    	String custcd				=	"";
    	String rescd				=	"";
    	//L 포인트 금액
//		String L_POINT_AMT 			= "";    						//'L_포인트_금액';
		String goodsPrice	=	"";			//	상품가격
		String cardNo		=	""; 		//	LPoint카드번호
		String wpw			=	""; 		//	LPoint패스워드
		String lottePoint	=	""; 		//	사용포인트
		String pointFg		=	"U";		//	
		String giftCard		=	"";			//	상품권번호
		String giftCardAmt	=	"";			//	상품권금액
		String buyerTel		=	""; 		//	구매자 전화번호
		String buyerEmail	=	""; 		//	구매자 이메일
		String goodName		=	""; 		//	상품명
		String vcdbank		=	""; 		//	입금은행코드
		String startDay		=	"";			//	여행시작일자
		String buyerName	=	"";			//	구매자명
		String cashPayAmt	=	"";
		String cashType		=	"";			//	현금영수증타입(0:소득공제(소비자용), 1:지출증빙(사업자용))	
		String cashReceipts	=	"";			//	현금영수증인증번호(핸드폰번호, 사업자등록번호)	

		String GIFT_DIVI_GB = "JG";   								//'상품권_구분_GB';
		String GIFT_NO = "";    								//'상품권_번호';
		String GIFT_AMT = "";    							//'상품권_금액';
		String GIFT_RECP_YN = "N";    								//'상품권_수령_여부';
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
    	
		try {

			String[] splitParam =	URLDecoder.decode(String.valueOf(paramMap.get("P_NOTI2")), "UTF-8").split("\t"); 
			System.out.println("merchantData :" +  URLDecoder.decode(String.valueOf(paramMap.get("P_NOTI2")), "UTF-8") + ":");
			System.out.println("merchantData.length :" +  splitParam.length);
			
			goodsPrice		=	splitParam[0]; 		//	상품가격
			startDay		=	splitParam[1]; 		//	여행시작일자
			cardNo			=	splitParam[2]; 		//	LPoint카드번호
			wpw				=	splitParam[3]; 		//	LPoint패스워드
			lottePoint		=	splitParam[4]; 		//	사용포인트
			cashPayAmt		=	splitParam[5];		//	현금결제금액	(복합결제의경우)
			cashType		=	splitParam[6];		//	현금영수증타입(0:소득공제(소비자용), 1:지출증빙(사업자용))
			cashReceipts	=	splitParam[7];		//	현금영수증인증번호(핸드폰번호, 사업자등록번호)	
			//giftCard		=	splitParam[8]; 		//	상품권번호	 
			//giftCardAmt		=	splitParam[9]; 		//	상품권금액	 
			buyerTel		=	splitParam[10]; 	//	구매자 전화번호
			buyerEmail		=	splitParam[11]; 	//	구매자 이메일
			goodName		=	splitParam[12]; 	//	상품명
			vcdbank			=	splitParam[13]; 	//	입금은행코드
			rescd			=	splitParam[14]; 	//	예약번호
			
			System.out.println("goodsPrice:"  + goodsPrice + ":");
			System.out.println("startDay:"  + startDay + ":");
			System.out.println("cardNo:"  + cardNo + ":");
			System.out.println("wpw:"  + wpw + ":");
			System.out.println("lottePoint:"  + lottePoint + ":");
			System.out.println("cashPayAmt:"  + cashPayAmt + ":");
			System.out.println("cashType:"  + cashType + ":");
			System.out.println("cashReceipts:"  + cashReceipts + ":");
			System.out.println("giftCard:"  + giftCard + ":");
			System.out.println("giftCardAmt:"  + giftCardAmt + ":");
			System.out.println("buyerTel:"  + buyerTel + ":");
			System.out.println("buyerEmail:"  + buyerEmail + ":");
			System.out.println("goodName:"  + goodName + ":");
			System.out.println("vcdbank:"  + vcdbank + ":");
			System.out.println("rescd:"  + rescd + ":");

			//#####################
			// 인증이 성공일 경우만
			//#####################
				try {
	
					CASH_RECEIPT_DIVI_GB	=	paramMap.get("CASH_RECEIPT_DIVI_GB");		//	현금영수증구분
					custcd					=	paramMap.get("custcd");
					
//					================================================================================================
//					L.Point 로직 시작	: L.Point관련 데이터를 merchantData에 담아 inicis에 던져서 그대로 받고 pasing하여 사용한다.					
//					================================================================================================
					if("002".equals(CASH_RECEIPT_DIVI_GB)){
						RECEIPT_DIVI_GB			=	"002";						//	현금영수증구분
						CORP_NO					= 	paramMap.get("CORP_NO");	//	현금영수증발급번호 '사업자_번호';	
					}else{
						RECEIPT_DIVI_GB			=	"001";						//	현금영수증구분
						ISSUE_HTEL				= 	paramMap.get("CORP_NO");	//	현금영수증발급번호 '발급_휴대전화';
					}

					//결제 테이블입력용 변수처리////////////////////////////////////////////////////
					FIT_RSV_NO 	= 	paramMap.get("FIT_RSV_NO");					//'자유여행_예약_번호';
					rescd		=	FIT_RSV_NO;
					//////////////////////////////////////////////////////////////////////
					
					// 계좌이체
					System.out.println("payMethod: " +  paramMap.get("P_M_DIV_CD") + ":");
					if ("DC".equals(paramMap.get("P_M_DIV_CD"))) { // 가상계좌
						
						///////////////////////////////////////////////////////////////////////////////////////////////
						//	계좌이체
						///////////////////////////////////////////////////////////////////////////////////////////////
						SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmss");
						Date date = Calendar.getInstance().getTime();
						String toDay = dayTime.format(date);

						//결제 테이블입력용 변수처리////////////////////////////////////////////////////
						// 가상계좌
						CASH_AMT				= paramMap.get("TOTALAMT");			//	현금결제금액
						BANK_CD_GB 				= paramMap.get("BANK_CD_GB");   	//	'은행_코드_GB';
						ACT_NO 					= paramMap.get("CARD_NO");    		//	'계좌_번호';
						ACT_PAYMTOR_NM 			= paramMap.get("ACT_PAYMTOR_NM");  	//	'계좌_입금자_명';
						PAYMT_SCH_DT 			= toDay   ;    						//	'입금_예정_일자';
						NOTE                  	= "LPAY";
						PAYMT_CONF_YN         	= "Y";								//	'입금_처리_여부';
						VIRTUAL_ACT_YN        	= "N";
						TID_NO					= paramMap.get("TID_NO");			//	결제TID
						//////////////////////////////////////////////////////////////////////
						
						htlActPaymtVO.setFIT_RSV_NO(FIT_RSV_NO);           
						htlActPaymtVO.setCASH_AMT(CASH_AMT);             
						htlActPaymtVO.setBANK_CD_GB(BANK_CD_GB);           
						htlActPaymtVO.setACT_NO(ACT_NO);               
						htlActPaymtVO.setACT_PAYMTOR_NM(ACT_PAYMTOR_NM);       
						htlActPaymtVO.setPAYMT_SCH_DT(PAYMT_SCH_DT);         
						htlActPaymtVO.setNOTE(NOTE);                 
						htlActPaymtVO.setCASH_RECEIPT_DIVI_GB(CASH_RECEIPT_DIVI_GB); 
						htlActPaymtVO.setPAYMT_CONF_YN(PAYMT_CONF_YN);        
						htlActPaymtVO.setVIRTUAL_ACT_YN(VIRTUAL_ACT_YN);       
						htlActPaymtVO.setTID_NO(TID_NO);               
						htlActPaymtVO.setREGTOR_ID(custcd);            
						htlActPaymtVO.setMODTOR_ID(custcd);            
						//////////////////////////////////////////////////////////////////////
						
						freeLpointDao.insertHtlActPaymt(htlActPaymtVO);						
						//////////////////////////////////////////////////////////////////////
					} else { // 카드, 복합결제 중 카드 금액

						///////////////////////////////////////////////////////////////////////////////////////////////
						//				카드 결제						
						///////////////////////////////////////////////////////////////////////////////////////////////
						//결제 테이블입력용 변수처리////////////////////////////////////////////////////
						//신용카드결제
						PAX_NO               	= ""; 
						CARD_PAYMT_AMT       	= paramMap.get("TOTALAMT");    			//'결제_금액'(상품가격); 
						CARD_KI_GB 				= paramMap.get("CARD_KI_GB");			//'카드_종류_GB'(카드발급사);
						CARD_NO 				= paramMap.get("CARD_NO");    			//'카드_번호';
						CARD_EXPIR_DATE_MN 		= "";    								//'카드_유효기간_월'===========알수없음;
						CARD_EXPIR_DATE_YEAR 	= "";    								//'카드_유효기간_년도'===========알수없음;
						CARD_INSTALLMN_MN 		= paramMap.get("CARD_INSTALLMN_MN");	//'카드_할부_개월';
						CARD_OWNER_GB        	= "";     								//'카드_소유_GB'===========알수없음;
						CARD_RELAT_GB 		 	= "";    								//'카드_관계_GB'===========알수없음;
						CARD_OWNER_NM 			= "";    								//'카드_소유자_명'===========알수없음;
						CARD_CVS_NO 			= "";    								//'카드_CVS_번호'===========알수없음;
						CARD_APPROVE_NO 		= paramMap.get("CARD_APPROVE_NO");   	//'카드_승인_번호'(이니시스 승인/거래번호);
						APPROVE_CONF_YN      	= "Y";    								//'입금_처리_여부';
						FRONT_PASS           	= ""; 									//'앞_비밀번호';
						//////////////////////////////////////////////////////////////////////

						htlCardPaymtVO.setFIT_RSV_NO(FIT_RSV_NO);            
						htlCardPaymtVO.setPAX_NO(PAX_NO);                
						htlCardPaymtVO.setCARD_PAYMT_AMT(CARD_PAYMT_AMT);        
						htlCardPaymtVO.setCARD_KI_GB(CARD_KI_GB);            
						htlCardPaymtVO.setCARD_NO(CARD_NO);               
						htlCardPaymtVO.setCARD_EXPIR_DATE_MN(CARD_EXPIR_DATE_MN);    
						htlCardPaymtVO.setCARD_EXPIR_DATE_YEAR(CARD_EXPIR_DATE_YEAR);  
						htlCardPaymtVO.setCARD_INSTALLMN_MN(CARD_INSTALLMN_MN);     
						htlCardPaymtVO.setCARD_OWNER_GB(CARD_OWNER_GB);         
						htlCardPaymtVO.setCARD_RELAT_GB(CARD_RELAT_GB);         
						htlCardPaymtVO.setCARD_OWNER_NM(CARD_OWNER_NM);         
						htlCardPaymtVO.setCARD_CVS_NO(CARD_CVS_NO);           
						htlCardPaymtVO.setCARD_APPROVE_NO(CARD_APPROVE_NO);       
						htlCardPaymtVO.setAPPROVE_CONF_YN(APPROVE_CONF_YN);       
						htlCardPaymtVO.setFRONT_PASS(FRONT_PASS);            
						htlCardPaymtVO.setREGTOR_ID(custcd);             
						htlCardPaymtVO.setMODTOR_ID(custcd);             
						
						freeLpointDao.insertHtlCardPaymt(htlCardPaymtVO);						
						//////////////////////////////////////////////////////////////////////
				    }

		            ///////////////////////////////////////////////////////////////////////////////////////////////
					//	상품권 관련 입력
					///////////////////////////////////////////////////////////////////////////////////////////////
					if(giftCard	!=null && !"".equals(giftCard)){
						//결제 테이블입력용 변수처리////////////////////////////////////////////////////
						//상품권
						GIFT_DIVI_GB = "JG";   								//'상품권_구분_GB';
						GIFT_NO = giftCard;    								//'상품권_번호';
						GIFT_AMT = giftCardAmt;    							//'상품권_금액';
						GIFT_RECP_YN = "N";    								//'상품권_수령_여부';
						FIT_RSV_NO	=	rescd;
						System.out.println("FIT_RSV_NO:" + FIT_RSV_NO);
						htlGiftPaymtVO.setGIFT_DIVI_GB(GIFT_DIVI_GB);
						htlGiftPaymtVO.setGIFT_NO(GIFT_NO);
						htlGiftPaymtVO.setGIFT_AMT(GIFT_AMT);
						htlGiftPaymtVO.setGIFT_RECP_YN(GIFT_RECP_YN);
						htlGiftPaymtVO.setREGTOR_ID(custcd);            
						htlGiftPaymtVO.setMODTOR_ID(custcd);    
						htlGiftPaymtVO.setFIT_RSV_NO(FIT_RSV_NO);
						//////////////////////////////////////////////////////////////////////
						freeLpointDao.insertHtlGiftPaymt(htlGiftPaymtVO);		
						//////////////////////////////////////////////////////////////////////
					}
					///////////////////////////////////////////////////////////////////////////////////////////////

					///////////////////////////////////////////////////////////////////////////////////////////////
					//	L.Point 로직 시작	: L.Point관련 데이터를 merchantData에 담아 inicis에 던져서 그대로 받고 pasing하여 사용한다.					
					///////////////////////////////////////////////////////////////////////////////////////////////
					if(lottePoint != null && !"".equals(lottePoint) && Integer.parseInt(lottePoint) > 0){
						// L Point 연동처리(사용)
						LPointVO lpointVo	=	getLPointUse (rescd, cardNo, wpw, startDay, lottePoint, pointFg, custcd);
						
						if(!"00".equals(lpointVo.getCode())){
							throw new Exception("L.Point error : resultCode[" + lpointVo.getCode() + "]");
						}

						//결제 테이블입력용 변수처리////////////////////////////////////////////////////
						ETC_USE_YN     = "Y";
						ETC_PAYMT_AMT  = lottePoint;
						PAYMT_CONF_YN  = "Y";
						NOTE           = "LPOINT";
						
						htlEtcPaymtVO.setFIT_RSV_NO(FIT_RSV_NO);     
						htlEtcPaymtVO.setETC_USE_YN(ETC_USE_YN);     
						htlEtcPaymtVO.setETC_PAYMT_AMT(ETC_PAYMT_AMT);  
						htlEtcPaymtVO.setPAYMT_CONF_YN(PAYMT_CONF_YN);  
						htlEtcPaymtVO.setNOTE(NOTE);           
						htlEtcPaymtVO.setREGTOR_ID(custcd);      
						htlEtcPaymtVO.setMODTOR_ID(custcd);      
						
						//////////////////////////////////////////////////////////////////////
						freeLpointDao.insertHtlEtcPaymt(htlEtcPaymtVO);		
						//////////////////////////////////////////////////////////////////////
					}
					///////////////////////////////////////////////////////////////////////////////////////////////
					///////////////////////////////////////////////////////////////////////////////////////////////
					
					///////////////////////////////////////////////////////////////////////////////////////////////
					//	현금영수증 관련 입력
					///////////////////////////////////////////////////////////////////////////////////////////////
					///////////////////////////////////////////////////////////////////////////////////////////////

					faFitRsvMstVO.setFIT_RSV_NO(FIT_RSV_NO);
					if( ACT_NO != null && !"".equals(ACT_NO) ){	//	가상계좌번호가 있으면 WA
						faFitRsvMstVO.setHTL_RSVSTATE_GB("OK");
						faFitRsvMstVO.setHTL_PAYMTSTATE_GB("OK");	//	없으면 OK
					}else{
						faFitRsvMstVO.setHTL_RSVSTATE_GB("OK");
						faFitRsvMstVO.setHTL_PAYMTSTATE_GB("OK");
					}
					
					faFitRsvMstVO.setMODTOR_ID(custcd);
					
					freeLpointDao.updateRsvMst(faFitRsvMstVO);

//					airReceiptReqVO.setAIR_RSV_SEQNO(FIT_RSV_NO);			// '호텔_예약_일련번호';
//					airReceiptReqVO.setRECEIPT_DIVI_GB(RECEIPT_DIVI_GB);    // '영수증_구분_GB';
//					airReceiptReqVO.setISSUE_HTEL(ISSUE_HTEL);    			// '발급_휴대전화';
//					airReceiptReqVO.setCORP_NO(CORP_NO);    				// '사업자_번호';		
//
//					freeLpointDao.insertHtlReceiptReq(airReceiptReqVO);
					///////////////////////////////////////////////////////////////////////////////////////////////
//					================================================================================================

					
				} catch (Exception ex) {
	
					//####################################
					// 실패시 처리(***가맹점 개발수정***)
					//####################################
	
					//---- db 저장 실패시 등 예외처리----//
					System.out.println("결제 실패: " +  ex);
	
					//#####################
					// L.pay 취소
					//#####################
					
				}
	
		} catch (Exception e) {

			System.out.println("Exception: " + e);
			
		}
		paymentVo.setResCd(rescd);
		
		return paymentVo;
	}
	
	/**
	 * 결제 요청
	 * 
	 * @return 결제 요청 기본 정보
	 * @throws Exception 결제 요청 시 발생하는 예외
	 */
	@Override
	public PaymentVO requestPayments(String price) throws Exception {
		
		System.out.println("##### 결제 요청 기본 정보 설정 #####");		
		PaymentVO paymentVo = new PaymentVO();
		
		try {
					
			/*
		    	//*** 위변조 방지체크를 signature 생성  ***
		
		        oid, price, timestamp 3개의 키와 값을
		
		        key=value 형식으로 하여 '&'로 연결한 하여 SHA-256 Hash로 생성 된값
		
		        ex) oid=INIpayTest_1432813606995&price=819000&timestamp=2012-02-01 09:19:04.004
		            
		        // key기준 알파벳 정렬
		
		        // timestamp는 반드시 signature생성에 사용한 timestamp 값을 timestamp input에 그대로 사용하여야함
			 */
	
		    //############################################
		    // 1.전문 필드 값 설정(***가맹점 개발수정***)
		    //############################################
			
			paymentVo.setVersion(propertiesService.getString("payment.version")); // 버전
			paymentVo.setmId(propertiesService.getString("payment.Card.mId")); // 상점 아이디
			paymentVo.setSignKey(propertiesService.getString("payment.card_signKey")); // 사인키
			paymentVo.setCharset(propertiesService.getString("payment.charset")); // 결과 인코딩

		    // 여기에 설정된 값은 Form 필드에 동일한 값으로 설정
			paymentVo.setCurrency("WON");
		    paymentVo.setPrice(price); // 상품가격(특수기호 제외, 가맹점에서 직접 설정)	    
		    paymentVo.setQuotaBase("2:3:4:5"); // 가맹점에서 사용할 할부 개월수 설정 생략시 일시불만
		    paymentVo.setTimeStamp(SignatureUtil.getTimestamp()); // util에 의해서 자동생성
		    paymentVo.setoId(paymentVo.getmId() + "_" + SignatureUtil.getTimestamp()); // 가맹점 주문번호(가맹점에서 직접 설정)
		    System.out.println("oid:" + paymentVo.getoId());
		
		    //###############################################
		    // 2. 가맹점 확인을 위한 signKey를 해시값으로 변경 (SHA-256방식 사용)
		    //###############################################
		    String siteDomain = "https://m.lottejtb.com/free/account"; //가맹점 도메인 입력
		    paymentVo.setSiteDomain(siteDomain);
		    paymentVo.setOfferPeriod("20151001-20151231"); // 제공기간
		    paymentVo.setAcceptMethod("CARDPOINT:HPP(1):no_receipt:va_receipt:vbanknoreg(0):below1000"); // acceptmethod

		    paymentVo.setReturnUrl(siteDomain + "/paymentReturns.do");
		    paymentVo.setCloseUrl(siteDomain + "/paymentCancel.do");
		    
		    System.out.println("##### 결제 요청 기본 정보:" + paymentVo.toString());
		} catch (Exception e) {
			System.out.println("PaymentServiceImpl.requestPayment error :" + e);

		}
		
		return paymentVo;
	}
	
	/**
	 * 결제 인증수신/승인API 처리
	 * 
     * @param paramMap 결제승인 정보
     * @return 결제 인증 및 승인 결과
	 * @throws Exception 결제 인증 및 승인 시 발생하는 예외
	 */
	@Override
	public PaymentVO authAndApprPayments(Map<String, String> paramMap) throws Exception {

		PaymentVO paymentVo = new PaymentVO();
		HtlCardPaymtVO htlCardPaymtVO = new HtlCardPaymtVO();
		String fitRsvNo = "";
		String hotelpassData = "";
		
		//취소용 TID
		String cancelTid	=	"";
		try {

			System.out.println("paramMap FREE:" +  paramMap.toString());

			//#####################
			// 인증이 성공일 경우만
			//#####################
			if ("00".equals(paramMap.get("P_STATUS"))) {
	
				System.out.println("#### 인증성공/승인요청 ####");
				
				String[] splitParam =	URLDecoder.decode(String.valueOf(paramMap.get("P_NOTI")), "UTF-8").split("\t"); 
				
				fitRsvNo		=	splitParam[0]; 		//	호텔패스 예약번호
				hotelpassData	=	splitParam[1]; 		//	호텔패스 데이터				
				
				System.out.println(">>>================================================");
				System.out.println("fitRsvNo:" + fitRsvNo);
				System.out.println("hotelpassData:" + hotelpassData);
				System.out.println(">>>>================================================");
				
				//############################################
				// 1. 전문 필드 값 설정(***가맹점 개발수정***)
				//############################################
	
				String pTID		= paramMap.get("P_TID");
				String authUrl	= paramMap.get("P_REQ_URL");
				String mId 		= "";
				mId	=	propertiesService.getString("payment.Card.mId");				
		      
				//#####################
				// 3. API 요청 전문 생성
				//#####################
						
				Map<String, String> authMap = new HashMap<String, String>();
	
				authMap.put("P_MID"			,mId);	// 필수
				authMap.put("P_TID"			,pTID);	// 필수

	
				System.out.println("## 승인요청 API 요청 ##");
	
				HttpUtil httpUtil = new HttpUtil();
				
				try {
	
					//#####################
					// 4. API 통신 시작
					//#####################
	
					String authResultString = "";
					
					authResultString = httpUtil.processHTTP(authMap, authUrl);
					
					//############################################################
					// 5. API 통신결과 처리(***가맹점 개발수정***)
					//############################################################
					System.out.println("## 승인 API 결과 ##");
					
					String test = authResultString.replace(",", "&").replace(":", "=").replace("\"", "").replace(" ","").replace("\n", "").replace("}", "").replace("{", "");

	
					Map<String, String> resultMap = new HashMap<String, String>();
					
					resultMap = ParseUtil.parseStringToMap(test); //문자열을 MAP형식으로 파싱
	
					if ("00".equals(resultMap.get("P_STATUS")) ) {	
						/*****************************************************************************
						 * 여기에 가맹점 내부 DB에 결제 결과를 반영하는 관련 프로그램 코드를 구현한다.  
					   
						 [중요!] 승인내용에 이상이 없음을 확인한 뒤 가맹점 DB에 해당건이 정상처리 되었음을 반영함
								  처리중 에러 발생시 망취소를 한다.
						 ******************************************************************************/
						
						resultMap.put("P_RMESG1", resultMap.get("P_RMESG1"));
						
						// 결과정보
						System.out.println("결과 코드1: " +  resultMap.get("P_STATUS"));
						System.out.println("결과 내용1: " +  resultMap.get("P_RMESG1"));
						
						paymentVo.setIsSuccDeal(Boolean.TRUE); 					// 거래 성공 여부
						paymentVo.setResultCode(resultMap.get("P_STATUS")); 	// 결과 코드
						paymentVo.setResultMsg(resultMap.get("P_RMESG1")); 		// 결과 메시지
						paymentVo.setPrice(resultMap.get("P_AMT")); 			// 거래금액
						paymentVo.setIniCardCode(resultMap.get("P_FN_CD1")); 	// 카드코드
						paymentVo.settId(resultMap.get("P_TID")); 				// 거래번호
						
						// 카드, 복합결제 중 카드 금액
						resultMap.put("P_FN_NM", resultMap.get("P_FN_NM"));
						System.out.println("결제 카드: " +  resultMap.get("P_FN_NM"));
						
						System.out.println("발급사코드: " +  resultMap.get("P_CARD_ISSUER_CODE"));
						System.out.println("가맹점번호: " +  resultMap.get("P_CARD_MEMBER_NUM"));
						System.out.println("매입사 코드: " +  resultMap.get("P_CARD_PURCHASE_CODE"));
						System.out.println("부분취소 가능여부: " +  resultMap.get("P_CARD_PRTC_CODE"));
						System.out.println("무이자 할부여부: " +  resultMap.get("P_CARD_INTEREST"));
						System.out.println("체크카드 여부: " +  resultMap.get("P_CARD_CHECKFLAG"));
						System.out.println("메시지2(할부개월수): " +  resultMap.get("P_RMESG2"));
						System.out.println("카드코드: " +  resultMap.get("P_FN_CD1"));
						System.out.println("승인번호: " +  resultMap.get("P_AUTH_NO"));
						System.out.println("VP 카드코드: " +  resultMap.get("P_ISP_CARDCODE"));
						System.out.println("결제카드한글명: " +  resultMap.get("P_FN_NM"));
						System.out.println("이벤트코드: " +  resultMap.get("P_EVENT_CODE"));
						System.out.println("카드번호1: " +  resultMap.get("P_VACT_NUM"));
						System.out.println("카드번호2: " +  resultMap.get("P_CARD_NUM"));
						System.out.println("고객명: " +  resultMap.get("P_UNAME"));
						
						htlCardPaymtVO.setFIT_RSV_NO(fitRsvNo);									// 호텔패스 예약번호
						htlCardPaymtVO.setCARD_PAYMT_AMT(resultMap.get("P_AMT"));				// 카드거래 금액
						htlCardPaymtVO.setCARD_KI_GB(resultMap.get("P_FN_CD1"));				// 카드종류
						htlCardPaymtVO.setCARD_NO(resultMap.get("P_CARD_NUM"));					// 카드번호
						htlCardPaymtVO.setCARD_INSTALLMN_MN(resultMap.get("P_RMESG2"));			// 할부개월 수
						htlCardPaymtVO.setCARD_OWNER_NM(resultMap.get("P_UNAME"));				// 결제자 이름
						htlCardPaymtVO.setCARD_APPROVE_NO(resultMap.get("P_AUTH_NO"));			// 결제승인 번호
						htlCardPaymtVO.setTID_NO(resultMap.get("P_TID"));						// 거래번호
						htlCardPaymtVO.setOID_NO(resultMap.get("P_OID")); 						// 결제oId
						
						freeLpointDao.insertPopCardPaymt(htlCardPaymtVO);
						System.out.println("resultMap :" +  resultMap.toString());
						
					} else {

						resultMap.put("P_RMESG1", resultMap.get("P_RMESG1"));

						paymentVo.setIsSuccDeal(Boolean.FALSE); // 거래 성공 여부
						paymentVo.setResultCode(resultMap.get("P_STATUS")); // 결과 코드
						paymentVo.setResultMsg(resultMap.get("P_RMESG1")); // 결과 메시지
						throw new Exception("거래실패");
					}
						
					// 공통 부분만
					System.out.println("거래 번호: " +  resultMap.get("P_TID"));
					System.out.println("결제방법(지불수단): " +  resultMap.get("P_TYPE"));
					System.out.println("결제완료금액: " +  resultMap.get("P_AMT"));
					System.out.println("주문 번호: " +  resultMap.get("P_OID"));
					System.out.println("승인날짜: " +  resultMap.get("P_AUTH_DT"));	//	YYYYmmddHHmmss
					
					cancelTid	=	resultMap.get("P_TID");
					
					// 수신결과를 파싱후 resultCode가 "0000"이면 승인성공 이외 실패
					// 가맹점에서 스스로 파싱후 내부 DB 처리 후 화면에 결과 표시
					
				} catch (Exception ex) {
	
					//####################################
					// 실패시 처리(***가맹점 개발수정***)
					//####################################
	
					//---- db 저장 실패시 등 예외처리----//
					System.out.println("결제 실패: " +  ex);
	
//					//#####################
//					// 모바일은 취소가 없으므로 웹의 취소 로직을 따른다.
//					//#####################
					System.out.println("## 취소 API 결과 ##");
					
					Map<String, String> cancelMap = new HashMap<String, String>();
					
					cancelMap.put("cancelreason", "");
					cancelMap.put("mid", mId);
					cancelMap.put("tid", cancelTid);
					cancelMap.put("msg", "System Error");
					
					cancelPayment(cancelMap);
					// 취소 결과 확인
					System.out.println("취소 결과 확인: " +  paymentVo.getResultCode().replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
					
				}
	
			} else {
	
				//#############
				// 인증 실패시
				//#############
				
				System.out.println("#### 인증실패 FREE####");
				paramMap.put("P_RMESG1", paramMap.get("P_RMESG1"));

				System.out.println("paramMap FREE:" +  paramMap.toString());
				System.out.println("결과 내용FREE1: " +  paramMap.get("P_RMESG1"));
				
	
			}
		
		} catch (Exception e) {

			System.out.println("Exception: " + e);
			
		}
		
		paymentVo.setResCd(fitRsvNo);
		paymentVo.setHotelpassData(hotelpassData);
		paymentVo.setVacctVo(null);
		return paymentVo;
	}
	
}
