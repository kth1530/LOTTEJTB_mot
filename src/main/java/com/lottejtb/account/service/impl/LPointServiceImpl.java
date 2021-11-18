package com.lottejtb.account.service.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.inicis.inipay.INIpay;
import com.inicis.std.util.HttpUtil;
import com.inicis.std.util.ParseUtil;
import com.inicis.std.util.SignatureUtil;
import com.lottejtb.account.service.CardAppliedInfo;
import com.lottejtb.account.service.CoSettDetVO;
import com.lottejtb.account.service.CoSettFeeVO;
import com.lottejtb.account.service.LPointService;
import com.lottejtb.account.service.LPointVO;
import com.lottejtb.account.service.NoInterestInfo;
import com.lottejtb.account.service.PaymentVO;
import com.lottejtb.account.service.PointHistoryVO;
import com.lottejtb.account.service.PointMstVO;
import com.lottejtb.account.service.RvPaymentVO;
import com.lottejtb.account.service.VAcctDepoNotiVO;
import com.lottejtb.account.service.paramVO;
import com.lottejtb.comm.util.DateUtil;
import com.lottejtb.comm.util.StringUtil;
import com.lottejtb.util.LottePointTcpClient;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("LPointService")
public class LPointServiceImpl extends EgovAbstractServiceImpl implements LPointService {
	@Resource(name="LPointDAO")
	private LPointDAO lpointDao;

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
    	
		//String tempNo = "";
    	StringBuilder tempNoSb = new StringBuilder();
		for(int i=0; i < (10 - (cno.trim()).length());i++){
			//tempNo += "0";
			tempNoSb.append(0);
		}
		cno = tempNoSb + (cno.trim());
		
		result = lpointDao.selectLottePointSeq();

		if(result.get("TRADE_NO").toString().equals("00000")){
			lpointDao.insertLottePointSeq();
		}
		
		lpointDao.updateLottePointSeq();
		
		tradeNo = lpointDao.selectLottePointSeq().get("TRADE_NO").toString();
		
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
     	
		//String tempNo = "";
		StringBuilder tempNoSb = new StringBuilder();
		
		for(int i=0; i < (10 - (cno.trim()).length());i++){
			//tempNo += "0";
			tempNoSb.append("0");
		}
		cno = tempNoSb.toString() + (cno.trim());
		
		result = lpointDao.selectLottePointSeq();

		if(result.get("TRADE_NO").toString().equals("00000")){
			lpointDao.insertLottePointSeq();
		}
		
		lpointDao.updateLottePointSeq();
		
		tradeNo = lpointDao.selectLottePointSeq().get("TRADE_NO").toString();
		
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
				resultVo.setMessage1(strBody7611.substring(29, 78));			//	리턴메시지
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
		
		result = lpointDao.selectLottePointSeq();

		if(result.get("TRADE_NO").toString().equals("00000")){
			lpointDao.insertLottePointSeq();
		}
		
		lpointDao.updateLottePointSeq();
		
		tradeNo = lpointDao.selectLottePointSeq().get("TRADE_NO").toString();

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
				
				lpointDao.insertLottePointMst(pointMstVO);
				
				// 포인트히스토리 셋팅
				pointHistoryVO.setPOINT_TID(pointTid);
				pointHistoryVO.setPOINT_FG("U");
				pointHistoryVO.setPOINT_FG(pointFg);
				pointHistoryVO.setCARD_NO(cardNo);
				pointHistoryVO.setPOINT_AMT(lottePoint);
				pointHistoryVO.setAPPRNO(apprNo);
				pointHistoryVO.setORG_APPRNO(apprNo);

				lpointDao.insertLottePointHis(pointHistoryVO);
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
		
		result = lpointDao.selectLottePointSeq();

		if(result.get("TRADE_NO").toString().equals("00000")){
			lpointDao.insertLottePointSeq();
		}
		
		lpointDao.updateLottePointSeq();
		
		tradeNo = lpointDao.selectLottePointSeq().get("TRADE_NO").toString();

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

				lpointDao.insertLottePointMst(pointMstVO);
				
				// 포인트히스토리 셋팅
				pointHistoryVO.setPOINT_TID(pointTid);
				pointHistoryVO.setPOINT_FG(pointFg);
				pointHistoryVO.setCARD_NO(cardNo);
				pointHistoryVO.setPOINT_AMT(lottePoint);
				pointHistoryVO.setSALE_AMT(saleAmt);
				pointHistoryVO.setAPPRNO(apprNo);
				pointHistoryVO.setORG_APPRNO(apprNo);

				lpointDao.insertLottePointHis(pointHistoryVO);
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
			//paymentVo.setSignKey(propertiesService.getString("payment.signKey")); // 사인키
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
		    String mKey = SignatureUtil.hash(paymentVo.getSignKey(), "SHA-256");		
			paymentVo.setmKey(mKey);
	
		    //###############################################
		    // 2.signature 생성
		    //###############################################
		    Map<String, String> signParam = new HashMap<String, String>();
		
		    signParam.put("oid", paymentVo.getoId());			  // 필수
		    signParam.put("price", paymentVo.getPrice());   	  // 필수
		    signParam.put("timestamp", paymentVo.getTimeStamp()); // 필수
		
		    // signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로 나열해 hash)	    
			String signature = SignatureUtil.makeSignature(signParam);
			paymentVo.setSignature(signature);
	
		    /* 기타 */
		    ///String siteDomain = "http://127.0.0.1:8080/INIpayStdSample"; //가맹점 도메인 입력
		    
			String siteDomain = "https://m.lottejtb.com/account"; //가맹점 도메인 입력
		    //String siteDomain = "http://mdev.lottejtb.com/account"; //가맹점 도메인 입력
		    
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
	 * 결제 인증수신/승인API 처리
	 * 
     * @param paramMap 결제승인 정보
     * @return 결제 인증 및 승인 결과
	 * @throws Exception 결제 인증 및 승인 시 발생하는 예외
	 */
	@Override
	public PaymentVO authAndApprPayment(Map<String, String> paramMap) throws Exception {

		PaymentVO paymentVo = new PaymentVO();
		String rescd		=	"";			//	예약번호
		String cardNo		=	""; 		//	LPoint카드번호
		String wpw			=	""; 		//	LPoint패스워드
		String lottePoint	=	""; 		//	사용포인트
		String pointFg		=	"U";		//	
		String giftCard		=	"";			//	상품권번호
		String giftCardAmt	=	"";			//	상품권금액
		String startDay		=	"";			//	여행시작일자
		String buyerName	=	"";			//	구매자명
		String custcd		=	"";			//	로그인id
		String ioCd			=	"";			//	입금환불코드		--	입금환불코드 초기값 가져오는 곳은?
		String cashPayAmt	=	"";
		String cashType		=	"";			//	현금영수증타입(0:소득공제(소비자용), 1:지출증빙(사업자용))	
		String cashReceipts	=	"";			//	현금영수증인증번호(핸드폰번호, 사업자등록번호)	
		
		String goodsPrice	=	"";			//	상품가격
		String buyerTel		=	""; 		//	구매자 전화번호
		String buyerEmail	=	""; 		//	구매자 이메일
		String goodName		=	""; 		//	상품명
		String vcdbank		=	""; 		//	입금은행코드
		
		String ACT_NO 		= 	"";			//'계좌_번호';
		String accNoOwner	=	"";			//	예금주명
		String bankName		=	"";			//	은행명
		
		//한글변환용
		String originalStr	=	"";
		//취소용TID
		String cancelTid	=	"";
		//	제주닷컴 연동금액
		String jejuAmt		=	"0";
		//	결제구분
		String paymentGb	=	"";
		try {

			//#####################
			// 인증이 성공일 경우만
			//#####################
			if ("00".equals(paramMap.get("P_STATUS"))) {
	
				System.out.println("#### 인증성공/승인요청 ####");
				
//				================================================================================================
//				L.Point 로직 시작	: L.Point관련 데이터를 merchantData에 담아 inicis에 던져서 그대로 받고 pasing하여 사용한다.					
//				================================================================================================
				String[] splitParam =	URLDecoder.decode(String.valueOf(paramMap.get("P_NOTI")), "UTF-8").split("\t"); 
				System.out.println("merchantData :" +  URLDecoder.decode(String.valueOf(paramMap.get("P_NOTI")), "UTF-8") + ":");
				System.out.println("merchantData.length :" +  splitParam.length);
				
				goodsPrice		=	splitParam[0]; 		//	상품가격
				startDay		=	splitParam[1]; 		//	여행시작일자
				cardNo			=	splitParam[2]; 		//	LPoint카드번호
				wpw				=	splitParam[3]; 		//	LPoint패스워드
				lottePoint		=	splitParam[4]; 		//	사용포인트
				cashPayAmt		=	splitParam[5];		//	현금결제금액	(복합결제의경우)
				cashType		=	splitParam[6];		//	현금영수증타입(0:소득공제(소비자용), 1:지출증빙(사업자용))
				cashReceipts	=	splitParam[7];		//	현금영수증인증번호(핸드폰번호, 사업자등록번호)	
				giftCard		=	splitParam[8]; 		//	상품권번호	 
				giftCardAmt		=	splitParam[9]; 		//	상품권금액	 
				buyerTel		=	splitParam[10]; 	//	구매자 전화번호
				buyerEmail		=	splitParam[11]; 	//	구매자 이메일
				goodName		=	splitParam[12]; 	//	상품명
				vcdbank			=	splitParam[13]; 	//	입금은행코드
				rescd			=	splitParam[14]; 	//	예약번호
				paymentGb		=	splitParam[15]; 	//	결제구분
				
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
				System.out.println("paymentGb:"  + paymentGb + ":");

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
	
					System.out.println("resultMap: " + resultMap);
	
					originalStr	=	resultMap.get("P_RMESG1");
					resultMap.put("P_RMESG1", new String(originalStr.getBytes("iso-8859-1"), "euc-kr"));
					
					if ("00".equals(resultMap.get("P_STATUS")) ) {
					   /*****************************************************************************
				       * 여기에 가맹점 내부 DB에 결제 결과를 반영하는 관련 프로그램 코드를 구현한다.  
					   
						 [중요!] 승인내용에 이상이 없음을 확인한 뒤 가맹점 DB에 해당건이 정상처리 되었음을 반영함
								  처리중 에러 발생시 망취소를 한다.
				       ******************************************************************************/
	
						System.out.println("거래 성공 여부: 성공");
	
						// 결과정보
						System.out.println("결과 코드: " +  resultMap.get("P_STATUS"));
						System.out.println("결과 내용: " +  resultMap.get("P_RMESG1"));
						
						paymentVo.setIsSuccDeal(Boolean.TRUE); // 거래 성공 여부
						paymentVo.setResultCode(resultMap.get("P_STATUS")); // 결과 코드
						paymentVo.setResultMsg(resultMap.get("P_RMESG1")); // 결과 메시지
	
					} else {
	
						System.out.println("거래 성공 여부: 실패");
						System.out.println("결과 코드: " +  resultMap.get("P_STATUS"));
						
						paymentVo.setIsSuccDeal(Boolean.FALSE); // 거래 성공 여부
						paymentVo.setResultCode(resultMap.get("P_STATUS")); // 결과 코드
						paymentVo.setResultMsg(resultMap.get("P_RMESG1")); // 결과 메시지
						
						
						/* 결제 실패===================================================*/
						Map<String, String> cancelMap = new HashMap<String, String>();
						
						cancelMap.put("cancelreason", "");
						cancelMap.put("mid", mId);
						cancelMap.put("tid", cancelTid);
						cancelMap.put("msg", "System Error");
						
						cancelPayment(cancelMap);
						
						// 취소 결과 확인
						System.out.println("거래 실패: " +  paymentVo.getResultCode().replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
						paymentVo.setResCd("");
						return paymentVo;
					}
						
					// 공통 부분만
					System.out.println("거래 번호: " +  resultMap.get("P_TID"));
					System.out.println("결제방법(지불수단): " +  resultMap.get("P_TYPE"));
					System.out.println("결제완료금액: " +  resultMap.get("P_AMT"));
					System.out.println("주문 번호: " +  resultMap.get("P_OID"));
					System.out.println("승인날짜: " +  resultMap.get("P_AUTH_DT"));	//	YYYYmmddHHmmss
					
					cancelTid	=	resultMap.get("P_TID");

					System.out.println("resultMap.get(P_AMT):"  + resultMap.get("P_AMT") + ":");
					jejuAmt	=	Integer.toString(Integer.parseInt(resultMap.get("P_AMT")) + Integer.parseInt(cashPayAmt));
					
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

		            	ACT_NO		=	resultMap.get("P_VACT_NUM");
		        		accNoOwner	=	resultMap.get("P_VACT_NAME");	
		        		bankName	=	getBankName(resultMap.get("P_VACT_BANK_CODE"));

		        		///////////////////////////////////////////////////////////////////////////////////////////////
						//	가상계좌
						///////////////////////////////////////////////////////////////////////////////////////////////
						//	가상계좌 디폴트값 setting
		            	RvPaymentVO rvPaymentVO = new RvPaymentVO();

						rvPaymentVO.setRES_CD(rescd); 									//	예약번호
						rvPaymentVO.setIO_DAY(DateUtil.getToday());						//	입금일자
						rvPaymentVO.setIO_FG("I");										//	입금
		            	rvPaymentVO.setSTATUS_CD("WT");									//	입금대기
		            	rvPaymentVO.setIO_FG_CD("E");									//	가상계좌
		            	rvPaymentVO.setIO_DETAIL_CD(resultMap.get("P_VACT_BANK_CODE"));	//	입금 은행코드
		            	rvPaymentVO.setIO_AMT("0");										//	입금액											
		            	rvPaymentVO.setPRE_AMT(resultMap.get("P_AMT"));					//	입금대기금액
		            	rvPaymentVO.setINPAY_ID(custcd);	     						//	입금사원
		            	rvPaymentVO.setIO_DESC(resultMap.get("P_OID")); 				//	주문번호
		            	rvPaymentVO.setACCOUNT_NO(resultMap.get("P_VACT_NUM"));			//	계좌번호
		            	rvPaymentVO.setNOINTEREST_CD("N");         	 					//	무이자구분
		            	rvPaymentVO.setPRE_DAY(resultMap.get("P_VACT_DATE")); 			//	처리예정일 ??
		            	
		            	rvPaymentVO.setTID(resultMap.get("P_TID"));        	 			//	승인TID
		            	rvPaymentVO.setAGREE_DT(resultMap.get("P_AUTH_DT")); 			//	승인일자
		            	rvPaymentVO.setCASH_RECEIPT_FG(cashType);
		            	if("1".equals(cashType)){		//	지출증빙용
		            		rvPaymentVO.setCASH_RECEIPT_CD("BU");	//	사업자등록번호 
		            	}else{
		            		rvPaymentVO.setCASH_RECEIPT_CD("HP");	//	핸드폰번호
		            	}
		            	rvPaymentVO.setCASH_RECEIPT_INFO(cashReceipts);
		            	
						List<RvPaymentVO> rtnVo	=	lpointDao.selectIOcd(rvPaymentVO);
						
						//	입금번호가 있으면
						if(rtnVo != null && rtnVo.size() > 0){
		            		String num = rtnVo.get(0).getIO_CD().substring(7);
		            		int number = 0;
		            		number = Integer.parseInt(num);
		            		number++;
		            		ioCd = DateUtil.getToday().substring(2) +"-"+filledString(number);   
						//	입금번호가없으면
						}else{
							ioCd	=	DateUtil.getToday().substring(2) + "-"+"001";
						}
						
						rvPaymentVO.setIO_CD(ioCd);
						
						rvPaymentVO.setINS_ID(custcd);
						rvPaymentVO.setUPD_ID(custcd);
						
	                	lpointDao.insertPayment(rvPaymentVO);
						///////////////////////////////////////////////////////////////////////////////////////////////

					} else { // 카드, 복합결제 중 카드 금액
						
						originalStr	=	resultMap.get("P_FN_NM");
						resultMap.put("P_FN_NM", new String(originalStr.getBytes("iso-8859-1"), "euc-kr"));

						
						
						System.out.println("===================================================");
						System.out.println(">>>>>>>> 카드결제<<<<<<<<<<= " +  resultMap.toString());
						System.out.println("===================================================");
						
//						
//						System.out.println("발급사코드: " +  resultMap.get("P_CARD_ISSUER_CODE"));
//						System.out.println("가맹점번호: " +  resultMap.get("P_CARD_MEMBER_NUM"));
//						System.out.println("매입사 코드: " +  resultMap.get("P_CARD_PURCHASE_CODE"));
//						System.out.println("부분취소 가능여부: " +  resultMap.get("P_CARD_PRTC_CODE"));
//						System.out.println("무이자 할부여부: " +  resultMap.get("P_CARD_INTEREST"));
//						System.out.println("체크카드 여부: " +  resultMap.get("P_CARD_CHECKFLAG"));
//						System.out.println("메시지2(할부개월수): " +  resultMap.get("P_RMESG2"));
//						System.out.println("카드코드: " +  resultMap.get("P_FN_CD1"));
//						System.out.println("승인번호: " +  resultMap.get("P_AUTH_NO"));
//						System.out.println("VP 카드코드: " +  resultMap.get("P_ISP_CARDCODE"));
//						System.out.println("결제카드한글명: " +  resultMap.get("P_FN_NM"));
//						System.out.println("이벤트코드: " +  resultMap.get("P_EVENT_CODE"));
						
						///////////////////////////////////////////////////////////////////////////////////////////////
						//				카드 결제						
						///////////////////////////////////////////////////////////////////////////////////////////////
						paramVO paramvo	=	new paramVO();
						// 결제수단 정보 조회
						paramvo.setSETT_CD("H");
						paramvo.setSETT_DET_CD(resultMap.get("P_CARD_PURCHASE_CODE"));	//	입금세부구분(은행코드, 카드사코드)
						paramvo.setCONF_DAY(DateUtil.getToday());
						paramvo.setUSE_YN("Y");
						
						List<CoSettFeeVO> coSettFeeList =	lpointDao.selectSettFee(paramvo);
						List<CoSettDetVO> coSettDetList	=	lpointDao.selectSettDet(paramvo);

						//	카드 디폴트값 setting
		            	RvPaymentVO rvPaymentVO = new RvPaymentVO();
		            	
		            	rvPaymentVO.setRES_CD(rescd);	//	예약번호
		            	
		            	rvPaymentVO.setIO_FG("I");											//입금
		            	rvPaymentVO.setIO_FG_CD("H");										//카드
		            	rvPaymentVO.setIO_DETAIL_CD(resultMap.get("P_CARD_PURCHASE_CODE"));	//입금세부구분코드
		            	rvPaymentVO.setSTATUS_CD("OK");										//입금완료
		            	rvPaymentVO.setIO_AMT(resultMap.get("P_AMT"));						//입금액
						try {
							//	수수료 및 무이자 설정
							if(coSettFeeList.size() < 1){
								throw new Exception("수수료 설정 실패");
							}
							CoSettFeeVO feeInfo = coSettFeeList.get(0);
							NoInterestInfo info = new NoInterestInfo(feeInfo.getFEE_RATE().toString());
			            	for(CoSettDetVO dto: coSettDetList){
			            		CardAppliedInfo a = new CardAppliedInfo(Integer.parseInt(dto.getNOINT_MONTH_CNT()), dto.getLIMIT_AMT().toString(), dto.getCOMM_RATE().toString(), dto.getCOMM_YN());
			            		info.append(dto.getNOINT_MONTH_CNT(), a);
			            	}
			            	
			            	
			            	int cardQuota = Integer.parseInt(resultMap.get("P_RMESG2"));
			            	
			            	CardAppliedInfo cardInfo = null;
			            	if(cardQuota < 1){
			            		cardInfo = info.get("1");
			            	}
			            	else{ 
			            		cardInfo = info.get(Integer.toString(cardQuota)); 
			            	}    
							
			            	
			            	BigDecimal totalPrice = new BigDecimal(resultMap.get("P_AMT"));
			            	BigDecimal noInterestRate	=	new BigDecimal(cardInfo.getNoInterestRate());
			            	
			            	BigDecimal compAmt	=	noInterestRate.multiply(totalPrice).divideToIntegralValue(new BigDecimal(100));
			            	rvPaymentVO.setCOMP_AMT(compAmt.toString());            	
			            	rvPaymentVO.setCOM_AMT(compAmt.toString());            	          	
							
							//수수료율이 없으면 RFND_AMT, RFND_RATE -> 0 있으면  롯데임직원체크 및 값 계산처리
				            if ( feeInfo == null ) {
				            	rvPaymentVO.setRFND_AMT("0");//기본수수료(우선)
				            	rvPaymentVO.setRFND_RATE("0");//기본수수료(우선)
			                }else {
		                    	if("lottejtbe1".equals(mId) || "lottejtbe2".equals(mId) || "lottejtbe3".equals(mId)){
		                    		feeInfo.setFEE_RATE("1");
		                    	}
		                    	
		                    	BigDecimal feeRate	=	new BigDecimal(feeInfo.getFEE_RATE());
		                    	BigDecimal rfndAmt	=	feeRate.multiply(totalPrice).divideToIntegralValue(new BigDecimal(100));
		                    	
	                    		rvPaymentVO.setRFND_AMT(rfndAmt.toString());//기본수수료(우선)
		                    	rvPaymentVO.setRFND_RATE(feeInfo.getFEE_RATE());//기본수수료(우선)
		                    }
							
							//	비쥬얼모드
			            	int amt = totalPrice.intValue();
			            	int limitAmt = Integer.parseInt(cardInfo.getLimitAmt());
	
			            	//이자여부에 따른 체크
				            if ( limitAmt > amt||!cardInfo.isNoInterestWithTerm() ) {
				            	System.out.println("유이자세팅");
				            	rvPaymentVO.setCOMP_AMT("0");            	
				            	rvPaymentVO.setNOINT_RATE("0");
				            	rvPaymentVO.setNOINTEREST_CD("N");
				            }else{
				            	System.out.println("무이자세팅");
				            	rvPaymentVO.setNOINTEREST_CD("Y");
			                	//자사부담일경우
			                    if ( "Y".equals(cardInfo.getComYN()) ) {
			                    	BigDecimal dec = new BigDecimal(cardInfo.getNoInterestRate());
			                    	rvPaymentVO.setCOMP_AMT(dec.multiply(new BigDecimal(amt)).divideToIntegralValue(new BigDecimal(100)).toString());  
			                    	rvPaymentVO.setCOMP_RATE(dec.toString());          	
			                    	rvPaymentVO.setNOINT_RATE("0");
			                    	rvPaymentVO.setNOINT_AMT("0");
			                    }else{
			                    	BigDecimal dec = new BigDecimal(cardInfo.getNoInterestRate());
			                    	rvPaymentVO.setCOMP_AMT("0");
			                    	rvPaymentVO.setCOMP_RATE("0");
			                    	rvPaymentVO.setNOINT_AMT(dec.multiply(new BigDecimal(amt)).divideToIntegralValue(new BigDecimal(100)).toString()) ;           	
			                    	rvPaymentVO.setNOINT_RATE(dec.toString());
			                    }
			            	}
						} catch (Exception ex) {
		            		//ex.printStackTrace();
		            		
		            		rvPaymentVO.setCOMP_AMT("0");      //자사수수료율
		            		rvPaymentVO.setCOM_AMT("0");       //AGENT카드수수료액
		            		rvPaymentVO.setRFND_AMT("0");      //카드(환불)수수료액
		            		rvPaymentVO.setNOINT_AMT("0");     //무이자수수료액
		            		rvPaymentVO.setNOINTEREST_CD("");  //무이자구분
		            		rvPaymentVO.setRFND_RATE("0");     //카드(환불)수수료율
		            		rvPaymentVO.setNOINT_RATE("0");    //무이자수수료율
		            		rvPaymentVO.setCOMP_RATE("0");     //자사수수료액							
						}
						//	입력정리
			            rvPaymentVO.setCOM_AMT("0");
			            rvPaymentVO.setCOM_RATE("0");
						
						//	입금환불등록  =======================================================
			            // INPUT값=======================================================
			            rvPaymentVO.setINPAY_ID("MOBILEUSER");     							//		입금사원
			            rvPaymentVO.setAGREE_NO(resultMap.get("P_AUTH_NO"));				//		승인번호
			            rvPaymentVO.setPRE_DAY(resultMap.get("P_VACT_DATE")); 				//		처리예정일						
			            rvPaymentVO.setCARD_NO(resultMap.get("P_VACT_NUM"));    			//		카드번호															
			            rvPaymentVO.setIO_DESC(resultMap.get("P_OID"));    					//		입금비고										
						String QUOTA_YN = "";
						if (resultMap.get("P_RMESG2").equals("00")) {
							QUOTA_YN = "N";
						} else {
							QUOTA_YN = "Y";
						}
						rvPaymentVO.setQUOTA_YN(QUOTA_YN);									//		할부여부				
						rvPaymentVO.setQUOTA_TERM(resultMap.get("P_RMESG2"));				//		할부기간
						rvPaymentVO.setINS_ID("MOBILEUSER");     								//		등록자												
						rvPaymentVO.setUPD_ID("MOBILEUSER");     								//		수정자				
						rvPaymentVO.setAGREE_DT(resultMap.get("P_AUTH_DT"));    	 		//		승인일시
						rvPaymentVO.setTID(resultMap.get("P_TID")); 						//  	TID
						rvPaymentVO.setMID(mId);											//		MID	
						// ===============================================================
						
						//	입금번호가 없으면 체번 후 +1
						List<RvPaymentVO> rtnVo	=	lpointDao.selectIOcd(rvPaymentVO);
						
						//	입금번호가 있으면
						if(rtnVo != null && rtnVo.size() > 0){
		            		String num = rtnVo.get(0).getIO_CD().substring(7);
		            		int number = 0;
		            		number = Integer.parseInt(num);
		            		number++;
		            		ioCd = DateUtil.getToday().substring(2) +"-"+filledString(number);   
						//	입금번호가없으면
						}else{
							ioCd	=	DateUtil.getToday().substring(2) + "-"+"001";
						}
						
						rvPaymentVO.setIO_DAY(DateUtil.getToday());
						rvPaymentVO.setIO_CD(ioCd);
						
						rvPaymentVO.setINS_ID(custcd);
						rvPaymentVO.setUPD_ID(custcd);
						
                   		System.out.println("=rvpayemt입력");
	                	lpointDao.insertPayment(rvPaymentVO);
                   		System.out.println("=rvpayemt끝");

						//입금환불등록  end =====================================================
	                   		
						///////////////////////////////////////////////////////////////////////////////////////////////
						//	카드일 경우 제주닷컴 연동이 필요함
						///////////////////////////////////////////////////////////////////////////////////////////////
						String prefixResCd = rescd.substring(0, 1);

						long paidAmt = Long.parseLong("0"); 	// 결제한 금액
						long totAmt = Long.parseLong(jejuAmt); 	// 총 결제할 금액
						long ioAmt = Long.parseLong(jejuAmt); 	// 이번결제로 임금할 금액
						
//						DB에서 외부예약코드를 가져와야 함
						String etc_res_cd = ""; // 외부예약코드
						
						// 호텔 예약일  경우를 판별
						if ("H".equals(prefixResCd)) {
						}else if (etc_res_cd.length() >0 && etc_res_cd != null && ( "K".equals(prefixResCd) || "O".equals(prefixResCd) || "R".equals(prefixResCd))) {
							BufferedReader br = null;
							
							try {
								String type = "2";//전체결제
								if(totAmt != ioAmt){
									type = "1";//부분결제
								}
								
								// 외부예약코드 획득
								etc_res_cd	=	lpointDao.selectEtcRscCd(rvPaymentVO); 
								
								if(etc_res_cd != null && !"".equals(etc_res_cd) ){
								 	//제주닷컴 URL
								 	String jejuReturnUrl = "http://dht3.lottejtb.com/reserve/agent/JTB/rv_reserveResult.php?agt=JTB&rvno="+etc_res_cd+"&amount="+ioAmt+"&type="+type;
								 	
								 	URLConnection urlConnection = null;
									HttpURLConnection httpConnection = null;
									URL url = null;
									
									StringBuffer buf = new StringBuffer();  
									
									// URL setting
									String svcFullURL= jejuReturnUrl;
									
									// Web Service Call
									url = new URL(svcFullURL);
									urlConnection = url.openConnection();
									urlConnection.setReadTimeout(3000); // read Tiem out 3초
									httpConnection = (HttpURLConnection) urlConnection;
									int responseCode = httpConnection.getResponseCode(); // 결과코드
									
									if(responseCode == 200){
										br = new BufferedReader(new InputStreamReader(httpConnection.getInputStream(), "euc-kr"));
										String temp = "";
										
										while ((temp = br.readLine()) != null) {
											if (temp.trim().length() > 0) {
												buf.append(temp);
											}
										}
									}
										
								 	System.out.println("[YHY]jejuReturnUrl" + jejuReturnUrl);
								}
							} catch (Exception e) {
								//e.printStackTrace();
								System.err.print("결제 오류!");
							} finally{
								if(br != null){
									br.close();
								}
							}
						}
						///////////////////////////////////////////////////////////////////////////////////////////////

						///////////////////////////////////////////////////////////////////////////////////////////////
				    }

					///////////////////////////////////////////////////////////////////////////////////////////////
					//	복합결제 시 현금결제금액 관련 처리
					///////////////////////////////////////////////////////////////////////////////////////////////
		            if (cashPayAmt != null && !"".equals(cashPayAmt) && Integer.parseInt(cashPayAmt) > 0) {
						
						System.out.println("check==================================================== 1");
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
	            		
		            	ACT_NO		=	vAcctInfo.getNo_vacct();
		        		accNoOwner	=	vAcctInfo.getNm_input();	
						bankName		= getBankName(vAcctInfo.getCd_bank());			//	은행명

		        		//	가상계좌 디폴트값 setting
		            	RvPaymentVO rvPaymentVO = new RvPaymentVO();

						rvPaymentVO.setRES_CD(rescd); 									//	예약번호
						rvPaymentVO.setIO_DAY(DateUtil.getToday());						//	입금일자
						rvPaymentVO.setIO_FG("I");										//	입금
		            	rvPaymentVO.setSTATUS_CD("WT");									//	입금대기
		            	rvPaymentVO.setIO_FG_CD("E");									//	가상계좌
		            	rvPaymentVO.setIO_DETAIL_CD(vAcctInfo.getCd_bank());			//	입금 은행코드
		            	rvPaymentVO.setIO_AMT("0");										//	입금액											
		            	rvPaymentVO.setPRE_AMT(cashPayAmt);								//	입금대기금액
		            	rvPaymentVO.setINPAY_ID(custcd);	     						//	입금사원
		            	rvPaymentVO.setIO_DESC(resultMap.get("P_OID")); 				//	주문번호
		            	rvPaymentVO.setACCOUNT_NO(vAcctInfo.getNo_vacct());				//	계좌번호
		            	rvPaymentVO.setNM(buyerName);									//	입금자명
		            	rvPaymentVO.setNOINTEREST_CD("N");         	 					//	무이자구분
		            	rvPaymentVO.setPRE_DAY(vAcctInfo.getDtinput()); 				//	처리예정일 
		            	
		            	rvPaymentVO.setTID(vAcctInfo.getNo_tid());         	 			//	승인TID
		            	rvPaymentVO.setAGREE_DT(vAcctInfo.getPgAuthDate() + vAcctInfo.getPgAuthTime()); 	//	승인일자
		            	rvPaymentVO.setCASH_RECEIPT_FG(cashType);
		            	
		            	if("1".equals(cashType)){					//	지출증빙용
		            		rvPaymentVO.setCASH_RECEIPT_CD("BU");	//	사업자등록번호 
		            	}else{
		            		rvPaymentVO.setCASH_RECEIPT_CD("HP");	//	핸드폰번호
		            	}
		            	rvPaymentVO.setCASH_RECEIPT_INFO(cashReceipts);
		            	
						List<RvPaymentVO> rtnVo	=	lpointDao.selectIOcd(rvPaymentVO);
						
						//	입금번호가 있으면
						if(rtnVo != null && rtnVo.size() > 0){
		            		String num = rtnVo.get(0).getIO_CD().substring(7);
		            		int number = 0;
		            		number = Integer.parseInt(num);
		            		number++;
		            		ioCd = DateUtil.getToday().substring(2) +"-"+filledString(number);   
						//	입금번호가없으면
						}else{
							ioCd	=	DateUtil.getToday().substring(2) + "-"+"001";
						}
						
						rvPaymentVO.setIO_CD(ioCd);
						
						rvPaymentVO.setINS_ID(custcd);
						rvPaymentVO.setUPD_ID(custcd);
						rvPaymentVO.setMID(mId);											//		MID	
						
	                	lpointDao.insertPayment(rvPaymentVO);
						
					}
					///////////////////////////////////////////////////////////////////////////////////////////////

					///////////////////////////////////////////////////////////////////////////////////////////////
					//	상품권 관련 입력
		            // [JEH] giftCard undefined 부분 추가 20171106
					///////////////////////////////////////////////////////////////////////////////////////////////
					if(giftCard	!=null && !"".equals(giftCard) && !"undefined".equals(giftCard)){
						System.out.println("[JEH]======================= 상품권 in ====");
						//	기존에 사용된 상품권인지 여부 체크
						//	상품권 setting
		            	RvPaymentVO rvPaymentVO = new RvPaymentVO();

						rvPaymentVO.setRES_CD(rescd); 									//	예약번호
						rvPaymentVO.setIO_DAY(DateUtil.getToday());						//	입금일자
						rvPaymentVO.setIO_FG("I");										//	입금
		            	rvPaymentVO.setSTATUS_CD("WT");									//	입금대기
		            	rvPaymentVO.setIO_FG_CD("D");									//	상품권
		            	rvPaymentVO.setIO_DETAIL_CD("01");								//	자사상품권(01)
		            	rvPaymentVO.setIO_AMT("0");										//	입금액								
		            	rvPaymentVO.setPRE_AMT(giftCardAmt);							//	입금대기금액
		            	rvPaymentVO.setINPAY_ID(custcd);	     						//	입금사원
		            	rvPaymentVO.setNOINTEREST_CD("N");         	 					//	무이자구분
		            	rvPaymentVO.setCOUPON_NO(giftCard);					 			//	쿠폰번호
		            	rvPaymentVO.setPRE_DAY("");							 			//	처리예정일 ??
		            	
		            	rvPaymentVO.setCASH_RECEIPT_FG(cashType);
		            	if("1".equals(cashType)){					//	지출증빙용
		            		rvPaymentVO.setCASH_RECEIPT_CD("BU");	//	사업자등록번호
		            	}else{
		            		rvPaymentVO.setCASH_RECEIPT_CD("HP");	//	핸드폰번호
		            	}
		            	rvPaymentVO.setCASH_RECEIPT_INFO(cashReceipts);
		            	
						List<RvPaymentVO> rtnVo	=	lpointDao.selectIOcd(rvPaymentVO);
						
						//	입금번호가 있으면
						if(rtnVo != null && rtnVo.size() > 0){
//	                   		System.out.println("================ssh====== rtnVo.size>0");
		            		String num = rtnVo.get(0).getIO_CD().substring(7);
		            		int number = 0;
		            		number = Integer.parseInt(num);
		            		number++;
		            		ioCd = DateUtil.getToday().substring(2) +"-"+filledString(number);   
						//	입금번호가없으면
						}else{
//	                   		System.out.println("================ssh====== rtnVo.size=0");
							ioCd	=	DateUtil.getToday().substring(2) + "-"+"001";
						}
						
						rvPaymentVO.setIO_CD(ioCd);
						
						rvPaymentVO.setINS_ID(custcd);
						rvPaymentVO.setUPD_ID(custcd);
						
	                	lpointDao.insertPayment(rvPaymentVO);
						
					}
					///////////////////////////////////////////////////////////////////////////////////////////////

					///////////////////////////////////////////////////////////////////////////////////////////////
					//	L.Point 로직 시작	: L.Point관련 데이터를 merchantData에 담아 inicis에 던져서 그대로 받고 pasing하여 사용한다.					
					///////////////////////////////////////////////////////////////////////////////////////////////
					if(lottePoint != null && !"".equals(lottePoint) && Integer.parseInt(lottePoint) > 0){
						System.out.println("[JEH]======================= L.Point in ====");
						
						RvPaymentVO lpointPaymentVo = new RvPaymentVO();
						
			            // INPUT값=======================================================
						lpointPaymentVo.setRES_CD(rescd);								//	1. 예약번호	
						lpointPaymentVo.setINPAY_ID("MOBILEUSER"); 						//	2.입금사원
						lpointPaymentVo.setIO_DETAIL_CD("01"); 							//	3.입금세부구분코드				
						lpointPaymentVo.setIO_AMT(lottePoint);							//	4.입금환불액	
						lpointPaymentVo.setNM(buyerName);								// 	5.사용자 이름
//						lpointPaymentVo.setinp("INPAY_ID", "MOBILEUSER");					// 	6.등록사원
						lpointPaymentVo.setCASH_RECEIPT_FG("0"); 						//	7.현금영수증구분	(소득공제용, 지출증빙용)			
						lpointPaymentVo.setCASH_RECEIPT_CD("JM"); 						//	8.현금영수증 유형 (핸드폰, 주민번호, 사업자번호)		
//						String personalNo	=	"";
//						lpointPaymentVo.setCASH_RECEIPT_INFO(personalNo); 				//	9.등록번호 ( 주민번호 )	//	session Cookie에서 가져옴 확인필요
										
						lpointPaymentVo.setINS_ID("MOBILEUSER"); 							//	10.등록자												
						
						lpointPaymentVo.setPRE_DAY(startDay);							// 	11. 출발일
						lpointPaymentVo.setCARD_NO(cardNo);								// 	12. 카드번호
						String pavv = "";
						lpointPaymentVo.setTID(pavv);		// 13. PAVV
			            // ==============================================================
						
						//입력초기화
//		            	String flag = "3";
//		            	String point_fg = "U";//사용
		            	lpointPaymentVo.setIO_FG("I");//입금
		            	lpointPaymentVo.setIO_FG_CD("I");//포인트 입금
		            	lpointPaymentVo.setSTATUS_CD("OK");
//		            	lpointPaymentVo.setFLAG(flag);

						// L Point 연동처리(사용)
						LPointVO lpointVo	=	getLPointUse (rescd, cardNo, wpw, startDay, lottePoint, pointFg, custcd);
						
						if(!"00".equals(lpointVo.getCode())){
							throw new Exception("L.Point error : resultCode[" + lpointVo.getCode() + "]");
						}

						lpointPaymentVo.setAGREE_NO(lpointVo.getApprNo());//승인번호세팅
						lpointPaymentVo.setTID(lpointVo.getPOINT_TID());//승인TID세팅
						lpointPaymentVo.setAGREE_DT(DateUtil.getToday());//승인일시세팅            	
						lpointPaymentVo.setPRE_DAY("");
						
						lpointPaymentVo.setUPD_ID("MOBILEUSER");     								//		수정자				
						
						//	입금환불번호가 있으면 일자와 저장자set 후 insert
//						if(!"".equals(ioCd)	&& ioCd != null){
//							lpointPaymentVo.setIO_DAY(DateUtil.getToday()); 
//							lpointPaymentVo.setIO_CD(ioCd);
//							
//		                	lpointDao.insertPayment(lpointPaymentVo);
//						}else{
							//	입금번호가 없으면 체번 후 +1
							List<RvPaymentVO> rtnVo	=	lpointDao.selectIOcd(lpointPaymentVo);
							
							//	입금번호가 있으면
							if(rtnVo.size() > 0){
			            		String num = rtnVo.get(0).getIO_CD().substring(7);
			            		int number = 0;
			            		number = Integer.parseInt(num);
			            		number++;
			            		ioCd = DateUtil.getToday().substring(2) +"-"+filledString(number);   
							//	입금번호가없으면
							}else{
								ioCd	=	DateUtil.getToday().substring(2) + "-"+"001";
							}
							
							lpointPaymentVo.setIO_DAY(DateUtil.getToday());
							lpointPaymentVo.setIO_CD(ioCd);
							
							lpointPaymentVo.setINS_ID(custcd);
							lpointPaymentVo.setUPD_ID(custcd);
							
	                   		System.out.println("=lpoint rvpayemt입력");
		                	lpointDao.insertPayment(lpointPaymentVo);
	                   		System.out.println("=lpoint rvpayemt입력");
//						}
					}
					///////////////////////////////////////////////////////////////////////////////////////////////
					
//					///////////////////////////////////////////////////////////////////////////////////////////////
//					//	현금영수증 관련 입력
//					///////////////////////////////////////////////////////////////////////////////////////////////
//					int cashReceiptsAmt = 0;	//	현금영수증 발행금액
//					
//					if("VBANK".equals(resultMap.get("payMethod"))){				//	가상계좌 결제금액
////						cashReceiptsAmt	=	Integer.parseInt(resultMap.get("TotPrice"));
//					}else if("DirectBank".equals(resultMap.get("payMethod"))){	//	실시간계좌이체 결제금액
////						cashReceiptsAmt	=	Integer.parseInt(resultMap.get("TotPrice"));
//					}else if(Integer.parseInt(cashPayAmt) > 0){					//	복합결제 현금결제금액
//						cashReceiptsAmt	=	Integer.parseInt(cashPayAmt);
//					}
//					
////					System.out.println("goodsPrice:" + goodsPrice);
////					System.out.println("lottePoint:" + lottePoint);
////					System.out.println("amt:" + resultMap.get("TotPrice"));
////					System.out.println("cashReceiptsAmt:" + cashReceiptsAmt);
//					
//					// 현금영수증(가상계좌, 실시간계좌이체, 복합결제일 경우에만 발행)
//					if ( cashReceiptsAmt > 0 && !rescd.startsWith("A") ) {
//						RvPaymentVO paramvo	=	new RvPaymentVO();
//						CashVO cashVO	=	new CashVO();
//						
//		            	cashVO.setRES_CD(rescd);
//		            	paramvo.setRES_CD(rescd);
//		            	
//						String caSeq	=	lpointDao.selectCashNo();
//						if(caSeq == null || "".equals(caSeq)){
//							caSeq	=	DateUtil.getToday() + "0001";
//						}else{
//							caSeq = Long.toString(Long.parseLong(caSeq)+1);
//						}
//						
//		            	cashVO.setCA_SEQ(caSeq);
//
//						//	발행일자
//						SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmss");
//						Date date = Calendar.getInstance().getTime();
//						String str = dayTime.format(date);
//						String TRDDATE	=	str.substring(2);
////						System.out.println("==================================TRDDATE:" + TRDDATE);
//						cashVO.setTRDDATE(TRDDATE);
//
////		            	사업자번호 setting
//						String busiNo	=	lpointDao.selectBusiNo(paramvo);
//		            	if(busiNo == null || "".equals(busiNo) ){
//							busiNo	=	"2018602089";
//						}
//		            	cashVO.setCOMPANYNO(busiNo);
//
//		            	cashVO.setJUMCODE("0000000000");		// 가맹점점포코드
//
//		            	if("".equals(cashType) || cashType == null){
//		            		cashType	=	"0";
//		            	}
//		            	cashVO.setUSETYPE(cashType);
//		            	
//		            	cashVO.setTRGU("1");
//		            	
//		            	if("".equals(cashReceipts) || cashReceipts == null){
//		            		cashReceipts	=	"0100001234";
//		            	}
//		            	for(int i=0;i<20 - cashReceipts.length();i++){
//		            		cashReceipts	=	cashReceipts + " ";
//		            	}
//		            	cashVO.setPERSONAUTHCODE(cashReceipts);
//		            	
//		            	cashVO.setMANUAL("1");
//		            	if(cashReceipts.length() >= 4){
//			            	if("1544".equals(cashReceipts.substring(0,4)))
//			            		cashVO.setMANUAL("0");	// 수기입력여부(현금영수증카드번호)
//		            	}
//		            	
////		            	//무조건 소득공제로 세팅 : 확인필요
////		            	cashVO.setUSETYPE("0");
//
//		            	int total = cashReceiptsAmt;
//		            	int supplyAmt = total; //(int)Math.floor(total/1.1);
//		            	int vat = total - supplyAmt;
//		            	cashVO.setSUPPLYAMT(Integer.toString(supplyAmt));
//		            	cashVO.setVAT(Integer.toString(vat));
//		            	cashVO.setCOVERCHARGE("0");   	      	
//		            	cashVO.setTOTAMT(Integer.toString(cashReceiptsAmt));
//		            	cashVO.setSUCCESSFLAG("R");
//		            	cashVO.setCANCELSUCCESSFLAG("R");
//		            	
//		            	cashVO.setIO_CD(ioCd);
//		            	cashVO.setCAN_SAYU(" ");
//		            	
//		            	lpointDao.insertCash(cashVO);
//		            	
//					}
//					///////////////////////////////////////////////////////////////////////////////////////////////
//					================================================================================================

					
				} catch (Exception ex) {
	
					//####################################
					// 실패시 처리(***가맹점 개발수정***)
					//####################################
	
					//---- db 저장 실패시 등 예외처리----//
					System.out.println("결제 실패: " +  ex);
	
					//#####################
					// 망취소 API
					//#####################
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
				originalStr	=	paramMap.get("P_RMESG1");
				paramMap.put("P_RMESG1", new String(originalStr.getBytes("iso-8859-1"), "euc-kr"));
				System.out.println("paramMap: " +  paramMap.toString());

			}
		
		} catch (Exception e) {

			System.out.println("Exception: " + e);
			
		}
		
		VAcctDepoNotiVO vacctVo = new VAcctDepoNotiVO();
		
		if(ACT_NO != null && !"".equals(ACT_NO)){
			vacctVo.setNo_vacct(ACT_NO);			// 가상계좌번호		
			vacctVo.setNm_input(accNoOwner);		// 예금주명
			vacctVo.setNm_inputbank(bankName);			// 상점주문번호

			paymentVo.setVacctVo(vacctVo);
		}else{
			paymentVo.setVacctVo(null);
		}
		
		paymentVo.setResCd(rescd);
		return paymentVo;
	}

	/**
	 * 결제 취소
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
			System.out.println("취소결과명:" + inipay.GetResult("ResultMsg"));
			
		} catch (Exception e) {
			
			System.out.println("cancelPayment Exception: " + e);
			
		}
		
		return paymentVo;
	}

    private String filledString(int number) {
        int numOfPosition = ((int)Math.floor(Math.log10((double)number))+1);
        int numOfZero = 3-numOfPosition;
        
        //String result = Integer.toString(number);
        StringBuilder resultSb = new StringBuilder();
        
        resultSb.append(Integer.toString(number));
        
        for(int i=0; i<numOfZero;i++){
        	//result = "0"+result;
        	resultSb.insert(0, "0");
        }       
        return resultSb.toString();
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
System.out.println("inipayHome:" + inipayHome);
			// 입금예정일(현재 일 기준 7일)
			String dpstDueDate = DateUtil.addDay(DateUtil.getToday(), 7);
			
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
			System.err.print("가상계좌 오류!");
		}
		
		return vAcctDepoNotiVO;
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

		String rescd		=	"";			//	예약번호
		String cardNo		=	""; 		//	LPoint카드번호
		String wpw			=	""; 		//	LPoint패스워드
		String lottePoint	=	""; 		//	사용포인트
		String pointFg		=	"U";		//	
		String giftCard		=	"";			//	상품권번호
		String giftCardAmt	=	"";			//	상품권금액
		String startDay		=	"";			//	여행시작일자
		String buyerName	=	"";			//	구매자명
		String custcd		=	"";			//	로그인id
		String ioCd			=	"";			//	입금환불코드		--	입금환불코드 초기값 가져오는 곳은?
		String cashPayAmt	=	"";
		String cashType		=	"";			//	현금영수증타입(0:소득공제(소비자용), 1:지출증빙(사업자용))	
		String cashReceipts	=	"";			//	현금영수증인증번호(핸드폰번호, 사업자등록번호)	
		
		String goodsPrice	=	"";			//	상품가격
		String buyerTel		=	""; 		//	구매자 전화번호
		String buyerEmail	=	""; 		//	구매자 이메일
		String goodName		=	""; 		//	상품명
		String vcdbank		=	""; 		//	입금은행코드
		
		// 제주닷컴 연동시 
		String jejuAmt 		= 	"";
		try {

			custcd			=	paramMap.get("custcd");
			buyerName		=	paramMap.get("buyerName");
			
			rescd			=	paramMap.get("rescd"); 	//	예약번호
			
			SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmss");
			Date date = Calendar.getInstance().getTime();
			String toDay = dayTime.format(date);

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
			giftCard		=	splitParam[8]; 		//	상품권번호	 
			giftCardAmt		=	splitParam[9]; 		//	상품권금액	 
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

			// 내부DB 저장 로직 추가
			if ("DC".equals(paramMap.get("P_M_DIV_CD"))) { // 가상계좌
        		///////////////////////////////////////////////////////////////////////////////////////////////
				//	가상계좌
				///////////////////////////////////////////////////////////////////////////////////////////////
				//	가상계좌 디폴트값 setting
            	RvPaymentVO rvPaymentVO = new RvPaymentVO();

				rvPaymentVO.setRES_CD(rescd); 									//	예약번호
				rvPaymentVO.setIO_DAY(DateUtil.getToday());						//	입금일자
				rvPaymentVO.setIO_FG("I");										//	입금
            	rvPaymentVO.setSTATUS_CD("OK");									//	입금대기
            	rvPaymentVO.setIO_FG_CD("L");									//	L.PAY
            	rvPaymentVO.setIO_DETAIL_CD(paramMap.get("BANK_CD_GB"));		//	입금 은행코드
            	rvPaymentVO.setIO_AMT(paramMap.get("TOTALAMT"));				//	입금액											
            	rvPaymentVO.setPRE_AMT("0");									//	입금대기금액
            	rvPaymentVO.setINPAY_ID(custcd);	     						//	입금사원
            	rvPaymentVO.setIO_DESC(paramMap.get("TID_NO")); 				//	주문번호
            	rvPaymentVO.setACCOUNT_NO(paramMap.get("CARD_NO"));				//	계좌번호
            	rvPaymentVO.setNM(paramMap.get("ACT_PAYMTOR_NM"));				//	입금자명
            	rvPaymentVO.setNOINTEREST_CD("N");         	 					//	무이자구분
            	rvPaymentVO.setPRE_DAY(DateUtil.getToday()); 					//	처리예정일
            	
            	rvPaymentVO.setTID(paramMap.get("TID_NO"));         	 		//	승인TID
            	rvPaymentVO.setAGREE_DT(DateUtil.getToday()); 					//	승인일자
            	rvPaymentVO.setCASH_RECEIPT_FG(cashType);
            	if("1".equals(cashType)){		//	지출증빙용
            		rvPaymentVO.setCASH_RECEIPT_CD("BU");	//	사업자등록번호 
            	}else{
            		rvPaymentVO.setCASH_RECEIPT_CD("HP");	//	핸드폰번호
            	}
            	rvPaymentVO.setCASH_RECEIPT_INFO(cashReceipts);
            	
				List<RvPaymentVO> rtnVo	=	lpointDao.selectIOcd(rvPaymentVO);
				
				//	입금번호가 있으면
				if(rtnVo != null && rtnVo.size() > 0){
            		String num = rtnVo.get(0).getIO_CD().substring(7);
            		int number = 0;
            		number = Integer.parseInt(num);
            		number++;
            		ioCd = DateUtil.getToday().substring(2) +"-"+filledString(number);   
				//	입금번호가없으면
				}else{
					ioCd	=	DateUtil.getToday().substring(2) + "-"+"001";
				}
				
				rvPaymentVO.setIO_CD(ioCd);
				
				rvPaymentVO.setINS_ID(custcd);
				rvPaymentVO.setUPD_ID(custcd);
				
            	lpointDao.insertPayment(rvPaymentVO);
				///////////////////////////////////////////////////////////////////////////////////////////////
            	
				///////////////////////////////////////////////////////////////////////////////////////////////
				//	카드일 경우 제주닷컴 연동이 필요함
				///////////////////////////////////////////////////////////////////////////////////////////////
				String prefixResCd = rescd.substring(0, 1);

				long paidAmt = Long.parseLong("0"); 	// 결제한 금액
				long totAmt = Long.parseLong(goodsPrice); 	// 총 결제할 금액
				long ioAmt = Long.parseLong(paramMap.get("TOTALAMT")); 	// 이번결제로 임금할 금액
				
//				DB에서 외부예약코드를 가져와야 함
				String etc_res_cd = ""; // 외부예약코드
				
				// 호텔 예약일  경우를 판별
				if ("H".equals(prefixResCd)) {
				}else if (etc_res_cd.length() >0 && etc_res_cd != null && ( "K".equals(prefixResCd) || "O".equals(prefixResCd) || "R".equals(prefixResCd))) {
					BufferedReader br = null;
					
					try {
						String type = "2";//전체결제
						if(totAmt != ioAmt){
							type = "1";//부분결제
						}
						
						// 외부예약코드 획득
						etc_res_cd	=	lpointDao.selectEtcRscCd(rvPaymentVO); 
						
						if(etc_res_cd != null && !"".equals(etc_res_cd) ){
						 	//제주닷컴 URL
						 	String jejuReturnUrl = "http://dht3.lottejtb.com/reserve/agent/JTB/rv_reserveResult.php?agt=JTB&rvno="+etc_res_cd+"&amount="+ioAmt+"&type="+type;
						 	
						 	URLConnection urlConnection = null;
							HttpURLConnection httpConnection = null;
							URL url = null;
							
							StringBuffer buf = new StringBuffer();  
							
							// URL setting
							String svcFullURL= jejuReturnUrl;
							
							// Web Service Call
							url = new URL(svcFullURL);
							urlConnection = url.openConnection();
							urlConnection.setReadTimeout(3000); // read Tiem out 3초
							httpConnection = (HttpURLConnection) urlConnection;
							int responseCode = httpConnection.getResponseCode(); // 결과코드
							
							if(responseCode == 200){
								br = new BufferedReader(new InputStreamReader(httpConnection.getInputStream(), "euc-kr"));
								String temp = "";
								
								while ((temp = br.readLine()) != null) {
									if (temp.trim().length() > 0) {
										buf.append(temp);
									}
								}
							}
								
						 	System.out.println("[YHY]jejuReturnUrl" + jejuReturnUrl);
						}
					} catch (Exception e) {
						//e.printStackTrace();
						System.err.print("결제 오류!");
					} finally{
						if(br != null){
							br.close();
						}
					}
				}
				///////////////////////////////////////////////////////////////////////////////////////////////

				///////////////////////////////////////////////////////////////////////////////////////////////
				

			} else { // 카드, 복합결제 중 카드 금액
				///////////////////////////////////////////////////////////////////////////////////////////////
				//				카드 결제						
				///////////////////////////////////////////////////////////////////////////////////////////////
				paramVO paramvo	=	new paramVO();
				// 결제수단 정보 조회
				paramvo.setSETT_CD("H");
				paramvo.setSETT_DET_CD(paramMap.get("CARD_KI_GB"));	//	입금세부구분(은행코드, 카드사코드)
				paramvo.setCONF_DAY(DateUtil.getToday());
				paramvo.setUSE_YN("Y");
				
				List<CoSettFeeVO> coSettFeeList =	lpointDao.selectSettFee(paramvo);
				List<CoSettDetVO> coSettDetList	=	lpointDao.selectSettDet(paramvo);

				//	수수료 및 무이자 설정
				if(coSettFeeList.size() < 1){
					throw new Exception("수수료 설정 실패");
				}
				CoSettFeeVO feeInfo = coSettFeeList.get(0);
				NoInterestInfo info = new NoInterestInfo(feeInfo.getFEE_RATE().toString());
            	for(CoSettDetVO dto: coSettDetList){
            		CardAppliedInfo a = new CardAppliedInfo(Integer.parseInt(dto.getNOINT_MONTH_CNT()), dto.getLIMIT_AMT().toString(), dto.getCOMM_RATE().toString(), dto.getCOMM_YN());
            		info.append(dto.getNOINT_MONTH_CNT(), a);
            	}
            	
            	
            	int cardQuota = Integer.parseInt(paramMap.get("CARD_INSTALLMN_MN"));
            	
            	CardAppliedInfo cardInfo = null;
            	if(cardQuota < 1){
            		cardInfo = info.get("1");
            	}
            	else{ 
            		cardInfo = info.get(Integer.toString(cardQuota)); 
            	}    
				
				//	카드 디폴트값 setting
            	RvPaymentVO rvPaymentVO = new RvPaymentVO();
            	
            	rvPaymentVO.setRES_CD(rescd);	//	예약번호
            	
            	rvPaymentVO.setIO_FG("I");										//입금
            	rvPaymentVO.setIO_FG_CD("L");									//L.PAY
            	rvPaymentVO.setIO_DETAIL_CD(paramMap.get("CARD_KI_GB"));		//입금세부구분코드
            	rvPaymentVO.setSTATUS_CD("OK");									//입금완료
            	rvPaymentVO.setIO_AMT(paramMap.get("TOTALAMT"));				//입금액
            	
            	BigDecimal totalPrice 		= new BigDecimal(paramMap.get("TOTALAMT"));
            	BigDecimal noInterestRate	=	new BigDecimal(cardInfo.getNoInterestRate());
            	
            	BigDecimal compAmt	=	noInterestRate.multiply(totalPrice).divideToIntegralValue(new BigDecimal(100));
            	rvPaymentVO.setCOMP_AMT(compAmt.toString());            	
            	rvPaymentVO.setCOM_AMT(compAmt.toString());            	          	
				
				//수수료율이 없으면 RFND_AMT, RFND_RATE -> 0 있으면  롯데임직원체크 및 값 계산처리
	            if ( feeInfo == null ) {
	            	rvPaymentVO.setRFND_AMT("0");//기본수수료(우선)
	            	rvPaymentVO.setRFND_RATE("0");//기본수수료(우선)
                }else {
                	BigDecimal feeRate	=	new BigDecimal(feeInfo.getFEE_RATE());
                	BigDecimal rfndAmt	=	feeRate.multiply(totalPrice).divideToIntegralValue(new BigDecimal(100));
                	
            		rvPaymentVO.setRFND_AMT(rfndAmt.toString());//기본수수료(우선)
                	rvPaymentVO.setRFND_RATE(feeInfo.getFEE_RATE());//기본수수료(우선)
                }
				
				//	비쥬얼모드
            	int amt = totalPrice.intValue();
            	int limitAmt = Integer.parseInt(cardInfo.getLimitAmt());

            	//이자여부에 따른 체크
	            if ( limitAmt > amt||!cardInfo.isNoInterestWithTerm() ) {
	            	rvPaymentVO.setCOMP_AMT("0");            	
	            	rvPaymentVO.setNOINT_RATE("0");
	            	rvPaymentVO.setNOINTEREST_CD("N");
	            }else{
	            	rvPaymentVO.setNOINTEREST_CD("Y");
                	//자사부담일경우
                    if ( "Y".equals(cardInfo.getComYN()) ) {
                    	BigDecimal dec = new BigDecimal(cardInfo.getNoInterestRate());
                    	rvPaymentVO.setCOMP_AMT(dec.multiply(new BigDecimal(amt)).divideToIntegralValue(new BigDecimal(100)).toString());  
                    	rvPaymentVO.setCOMP_RATE(dec.toString());          	
                    	rvPaymentVO.setNOINT_RATE("0");
                    	rvPaymentVO.setNOINT_AMT("0");
                    }else{
                    	BigDecimal dec = new BigDecimal(cardInfo.getNoInterestRate());
                    	rvPaymentVO.setCOMP_AMT("0");
                    	rvPaymentVO.setCOMP_RATE("0");
                    	rvPaymentVO.setNOINT_AMT(dec.multiply(new BigDecimal(amt)).divideToIntegralValue(new BigDecimal(100)).toString()) ;           	
                    	rvPaymentVO.setNOINT_RATE(dec.toString());
                    }
            	}
	            	
				//	입력정리
	            rvPaymentVO.setCOM_AMT("0");
	            rvPaymentVO.setCOM_RATE("0");
				
				//	입금환불등록  =======================================================
	            // INPUT값=======================================================
	            rvPaymentVO.setINPAY_ID("MOBILEUSER");     							//		입금사원
	            rvPaymentVO.setAGREE_NO(paramMap.get("TID_NO"));					//		승인번호
	            rvPaymentVO.setPRE_DAY(DateUtil.getToday()); 						//		처리예정일						
	            rvPaymentVO.setCARD_NO(paramMap.get("CARD_NO"));    				//		계좌번호(은행계좌번호)															
	            rvPaymentVO.setIO_DESC(paramMap.get("TID_NO"));    					//		입금비고										
				String QUOTA_YN = "";
				if (paramMap.get("CARD_INSTALLMN_MN").equals("00")) {
					QUOTA_YN = "N";
				} else {
					QUOTA_YN = "Y";
				}
				rvPaymentVO.setQUOTA_YN(QUOTA_YN);									//		할부여부				
				rvPaymentVO.setQUOTA_TERM(paramMap.get("CARD_INSTALLMN_MN"));		//		할부기간
				rvPaymentVO.setINS_ID("MOBILEUSER");     								//		등록자												
				rvPaymentVO.setUPD_ID("MOBILEUSER");     								//		수정자				
				rvPaymentVO.setAGREE_DT(DateUtil.getToday());						//		승인일시
				rvPaymentVO.setTID(paramMap.get("TID_NO")); 						//  	TID
				rvPaymentVO.setMID("");		//		MID	
				// ===============================================================
				
				//	입금번호가 없으면 체번 후 +1
				List<RvPaymentVO> rtnVo	=	lpointDao.selectIOcd(rvPaymentVO);
					
				//	입금번호가 있으면
				if(rtnVo != null && rtnVo.size() > 0){
            		String num = rtnVo.get(0).getIO_CD().substring(7);
            		int number = 0;
            		number = Integer.parseInt(num);
            		number++;
            		ioCd = DateUtil.getToday().substring(2) +"-"+filledString(number);   
				//	입금번호가없으면
				}else{
					ioCd	=	DateUtil.getToday().substring(2) + "-"+"001";
				}
				
				rvPaymentVO.setIO_DAY(DateUtil.getToday());
				rvPaymentVO.setIO_CD(ioCd);
				
				rvPaymentVO.setINS_ID(custcd);
				rvPaymentVO.setUPD_ID(custcd);
				
            	lpointDao.insertPayment(rvPaymentVO);

				//입금환불등록  end =====================================================
				///////////////////////////////////////////////////////////////////////////////////////////////
            	
				///////////////////////////////////////////////////////////////////////////////////////////////
				//	카드일 경우 제주닷컴 연동이 필요함
				///////////////////////////////////////////////////////////////////////////////////////////////
				String prefixResCd = rescd.substring(0, 1);

				long paidAmt = Long.parseLong("0"); 	// 결제한 금액
				long totAmt = Long.parseLong(goodsPrice); 	// 총 결제할 금액
				long ioAmt = Long.parseLong(paramMap.get("TOTALAMT")); 	// 이번결제로 임금할 금액
				
//				DB에서 외부예약코드를 가져와야 함
				String etc_res_cd = ""; // 외부예약코드
				
				// 호텔 예약일  경우를 판별
				if ("H".equals(prefixResCd)) {
				}else if (etc_res_cd.length() >0 && etc_res_cd != null && ( "K".equals(prefixResCd) || "O".equals(prefixResCd) || "R".equals(prefixResCd))) {
					BufferedReader br = null;
					
					try {
						String type = "2";//전체결제
						if(totAmt != ioAmt){
							type = "1";//부분결제
						}
						
						// 외부예약코드 획득
						etc_res_cd	=	lpointDao.selectEtcRscCd(rvPaymentVO); 
						
						if(etc_res_cd != null && !"".equals(etc_res_cd) ){
						 	//제주닷컴 URL
						 	String jejuReturnUrl = "http://dht3.lottejtb.com/reserve/agent/JTB/rv_reserveResult.php?agt=JTB&rvno="+etc_res_cd+"&amount="+ioAmt+"&type="+type;
						 	
						 	URLConnection urlConnection = null;
							HttpURLConnection httpConnection = null;
							URL url = null;
							
							StringBuffer buf = new StringBuffer();  
							
							// URL setting
							String svcFullURL= jejuReturnUrl;
							
							// Web Service Call
							url = new URL(svcFullURL);
							urlConnection = url.openConnection();
							urlConnection.setReadTimeout(3000); // read Tiem out 3초
							httpConnection = (HttpURLConnection) urlConnection;
							int responseCode = httpConnection.getResponseCode(); // 결과코드
							
							if(responseCode == 200){
								br = new BufferedReader(new InputStreamReader(httpConnection.getInputStream(), "euc-kr"));
								String temp = "";
								
								while ((temp = br.readLine()) != null) {
									if (temp.trim().length() > 0) {
										buf.append(temp);
									}
								}
							}
								
						 	System.out.println("[YHY]jejuReturnUrl" + jejuReturnUrl);
						}
					} catch (Exception e) {
						//e.printStackTrace();
						System.err.print("결제 오류!");
					} finally{
						if(br != null){
							br.close();
						}
					}
				}
				///////////////////////////////////////////////////////////////////////////////////////////////

				///////////////////////////////////////////////////////////////////////////////////////////////            	
		    }

			///////////////////////////////////////////////////////////////////////////////////////////////
			//	상품권 관련 입력
			///////////////////////////////////////////////////////////////////////////////////////////////
			if(giftCard	!=null && !"".equals(giftCard) && !"undefined".equals(giftCard)){
				//	상품권 setting
            	RvPaymentVO rvPaymentVO = new RvPaymentVO();

				rvPaymentVO.setRES_CD(rescd); 									//	예약번호
				rvPaymentVO.setIO_DAY(DateUtil.getToday());						//	입금일자
				rvPaymentVO.setIO_FG("I");										//	입금
            	rvPaymentVO.setSTATUS_CD("WT");									//	입금대기
            	rvPaymentVO.setIO_FG_CD("D");									//	상품권
            	rvPaymentVO.setIO_DETAIL_CD("01");								//	자사상품권(01)
            	rvPaymentVO.setIO_AMT("0");										//	입금액								
            	rvPaymentVO.setPRE_AMT(giftCardAmt);							//	입금대기금액
            	rvPaymentVO.setINPAY_ID(custcd);	     						//	입금사원
            	rvPaymentVO.setNOINTEREST_CD("N");         	 					//	무이자구분
            	rvPaymentVO.setCOUPON_NO(giftCard);					 			//	쿠폰번호
            	rvPaymentVO.setPRE_DAY("");							 			//	처리예정일 ??
            	
            	rvPaymentVO.setCASH_RECEIPT_FG(cashType);
            	if("1".equals(cashType)){		//	지출증빙용
            		rvPaymentVO.setCASH_RECEIPT_CD("BU");	//	사업자등록번호
            	}else{
            		rvPaymentVO.setCASH_RECEIPT_CD("HP");	//	핸드폰번호
            	}
            	rvPaymentVO.setCASH_RECEIPT_INFO(cashReceipts);
            	
				List<RvPaymentVO> rtnVo	=	lpointDao.selectIOcd(rvPaymentVO);
				
				//	입금번호가 있으면
				if(rtnVo != null && rtnVo.size() > 0){
            		String num = rtnVo.get(0).getIO_CD().substring(7);
            		int number = 0;
            		number = Integer.parseInt(num);
            		number++;
            		ioCd = DateUtil.getToday().substring(2) +"-"+filledString(number);   
				//	입금번호가없으면
				}else{
					ioCd	=	DateUtil.getToday().substring(2) + "-"+"001";
				}
				
				rvPaymentVO.setIO_CD(ioCd);
				
				rvPaymentVO.setINS_ID(custcd);
				rvPaymentVO.setUPD_ID(custcd);
				
            	lpointDao.insertPayment(rvPaymentVO);
				
			}
			///////////////////////////////////////////////////////////////////////////////////////////////

			///////////////////////////////////////////////////////////////////////////////////////////////
			//	L.Point 로직 시작	: L.Point관련 데이터를 merchantData에 담아 inicis에 던져서 그대로 받고 pasing하여 사용한다.					
			///////////////////////////////////////////////////////////////////////////////////////////////
			if(lottePoint != null && !"".equals(lottePoint) && Integer.parseInt(lottePoint) > 0){
				
				RvPaymentVO lpointPaymentVo = new RvPaymentVO();
				
	            // INPUT값=======================================================
				lpointPaymentVo.setRES_CD(rescd);								//	1. 예약번호	
				lpointPaymentVo.setINPAY_ID("MOBILEUSER"); 						//	2.입금사원
				lpointPaymentVo.setIO_DETAIL_CD("01"); 							//	3.입금세부구분코드				
				lpointPaymentVo.setIO_AMT(lottePoint);							//	4.입금환불액	
				lpointPaymentVo.setNM(buyerName);								// 	5.사용자 이름
				lpointPaymentVo.setCASH_RECEIPT_FG("0"); 						//	7.현금영수증구분	(소득공제용, 지출증빙용)			
				lpointPaymentVo.setCASH_RECEIPT_CD("JM"); 						//	8.현금영수증 유형 (핸드폰, 주민번호, 사업자번호)		
								
				lpointPaymentVo.setINS_ID("MOBILEUSER"); 							//	10.등록자												
				
				lpointPaymentVo.setPRE_DAY(startDay);							// 	11. 출발일
				lpointPaymentVo.setCARD_NO(cardNo);								// 	12. 카드번호
				String pavv = "";
				lpointPaymentVo.setTID(pavv);		// 13. PAVV
	            // ==============================================================
				
				//입력초기화
            	lpointPaymentVo.setIO_FG("I");//입금
            	lpointPaymentVo.setIO_FG_CD("I");//포인트 입금
            	lpointPaymentVo.setSTATUS_CD("OK");

				// L Point 연동처리(사용)
				LPointVO lpointVo	=	getLPointUse (rescd, cardNo, wpw, startDay, lottePoint, pointFg, custcd);
				
				if(!"00".equals(lpointVo.getCode())){
					throw new Exception("L.Point error : resultCode[" + lpointVo.getCode() + "]");
				}

				lpointPaymentVo.setAGREE_NO(lpointVo.getApprNo());//승인번호세팅
				lpointPaymentVo.setTID(lpointVo.getPOINT_TID());//승인TID세팅
				lpointPaymentVo.setAGREE_DT(DateUtil.getToday());//승인일시세팅            	
				lpointPaymentVo.setPRE_DAY("");
				
				lpointPaymentVo.setUPD_ID("MOBILEUSER");     								//		수정자				
				
				//	입금번호가 없으면 체번 후 +1
				List<RvPaymentVO> rtnVo	=	lpointDao.selectIOcd(lpointPaymentVo);
				
				//	입금번호가 있으면
				if(rtnVo.size() > 0){
            		String num = rtnVo.get(0).getIO_CD().substring(7);
            		int number = 0;
            		number = Integer.parseInt(num);
            		number++;
            		ioCd = DateUtil.getToday().substring(2) +"-"+filledString(number);   
				//	입금번호가없으면
				}else{
					ioCd	=	DateUtil.getToday().substring(2) + "-"+"001";
				}
				
				lpointPaymentVo.setIO_DAY(DateUtil.getToday());
				lpointPaymentVo.setIO_CD(ioCd);
				
				lpointPaymentVo.setINS_ID(custcd);
				lpointPaymentVo.setUPD_ID(custcd);
				
            	lpointDao.insertPayment(lpointPaymentVo);
			}
			///////////////////////////////////////////////////////////////////////////////////////////////
			
		} catch (Exception ex) {

			//####################################
			// 실패시 처리(***가맹점 개발수정***)
			//####################################

			//---- db 저장 실패시 등 예외처리----//
			System.out.println("결제 실패: " +  ex);

			
		}
	
		paymentVo.setResCd(rescd);
		return paymentVo;
	}

	@Override
	public List<RvPaymentVO> selectDeposithistory(RvPaymentVO vo)  throws Exception {
		 
		return (List<RvPaymentVO>) lpointDao.selectDeposithistory(vo); 
	}

}
