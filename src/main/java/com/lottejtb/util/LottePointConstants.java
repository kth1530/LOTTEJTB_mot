package com.lottejtb.util;

public class LottePointConstants {
	// 테스트 서버
	public static final String TEST_SERVER_IP = "210.93.184.12";
	public static final int TEST_SERVER_PORT = 29292;
	
	// 테스트 서버(정통망법 개정, 운영서버 테스트용 포트)
	public static final String TEST_SERVER_IP_NEW = "10.141.1.14";
	//public static final int TEST_SERVER_PORT_NEW = 30881; //구전문
	public static final int TEST_SERVER_PORT_NEW = 33881; //신전문
	
	// 운영서버 
	public static final String REAL_SERVER_IP = "10.141.1.14";
	public static final int REAL_SERVER_PORT = 33881;
	
	// 소켓 타임아웃 에러 시간 설정 
	public static final int SOCKET_TIME_OUT = 3; 
	
	/******************************************************
	 * HEADER 상수 정의
	 ******************************************************/
	//헤더 타입
	public static final String HEADER_TYPE = "A";
	
	//전문번호
	public static final String HEADER_FIXED_TEXT_S_NO_2000 = "2000"; //회원인증
	public static final String HEADER_FIXED_TEXT_S_NO_1110 = "1110"; //포인트적립
	public static final String HEADER_FIXED_TEXT_S_NO_1120 = "1120"; //포인트적립취소
	public static final String HEADER_FIXED_TEXT_S_NO_1170 = "1170"; //포인트적립_NEW
	public static final String HEADER_FIXED_TEXT_S_NO_1180 = "1180"; //포인트적립취소_NEW
	public static final String HEADER_FIXED_TEXT_S_NO_1210 = "1210"; //포인트사용
	public static final String HEADER_FIXED_TEXT_S_NO_1220 = "1220"; //포인트사용 취소
	public static final String HEADER_FIXED_TEXT_S_NO_7000 = "7000"; //회원인증(정통망법 개정)
	public static final String HEADER_FIXED_TEXT_S_NO_7210 = "7210"; //포인트사용(정통망법 개정)
	public static final String HEADER_FIXED_TEXT_S_NO_7220 = "7220"; //포인트사용 취소(정통망법 개정)
	
	public static final String HEADER_FIXED_TEXT_R_NO_2001 = "2001"; //회원인증
	public static final String HEADER_FIXED_TEXT_R_NO_1111 = "1111"; //포인트적립
	public static final String HEADER_FIXED_TEXT_R_NO_1121 = "1121"; //포인트적립취소
	public static final String HEADER_FIXED_TEXT_R_NO_1171 = "1171"; //포인트적립_NEW
	public static final String HEADER_FIXED_TEXT_R_NO_1181 = "1181"; //포인트적립취소_NEW
	public static final String HEADER_FIXED_TEXT_R_NO_1211 = "1211"; //포인트사용
	public static final String HEADER_FIXED_TEXT_R_NO_1221 = "1221"; //포인트사용 취소
	
	public static final String HEADER_FIXED_TEXT_BODY_LENGTH_2000 = "0153"; //회원인증
	public static final String HEADER_FIXED_TEXT_BODY_LENGTH_1110 = "0659"; //포인트적립 
	public static final String HEADER_FIXED_TEXT_BODY_LENGTH_1120 = "1102"; //포인트적립취소
	public static final String HEADER_FIXED_TEXT_BODY_LENGTH_1170 = "0514"; //포인트적립_NEW 
	public static final String HEADER_FIXED_TEXT_BODY_LENGTH_1180 = "1090"; //포인트적립취소_NEW
	public static final String HEADER_FIXED_TEXT_BODY_LENGTH_1210 = "0275"; //포인트사용
	public static final String HEADER_FIXED_TEXT_BODY_LENGTH_1220 = "0275"; //포인트사용 취소
	public static final String HEADER_FIXED_TEXT_BODY_LENGTH_7000 = "0234"; //회원인증(정통망법 개정)
	public static final String HEADER_FIXED_TEXT_BODY_LENGTH_7210 = "0386"; //포인트사용(정통망법 개정)
	public static final String HEADER_FIXED_TEXT_BODY_LENGTH_7220 = "0386"; //포인트사용(정통망법 개정)
	
	//전문구분
	public static final String HEADER_FIXED_TEXT_FG="ON";//온라인
	//응답코드
	public static final String HEADER_RETURN_CD="  ";//2byte 공백
	//기간코드
	public static final String HEADER_COMP_CD = "3900";
	//시스템 사용
	public static final String HEADER_SYSTEM_AREA="                    "; // 20byte 공백
	
	
	/******************************************************
	 * BODY 상수 정의
	 ******************************************************/
	//WCC 값 정의
	public static final String BODY_WCC_FG_MSR = "1";
	public static final String BODY_WCC_FG_IC= "2";
	public static final String BODY_WCC_FG_KEYIN = "3";
	
	// 승인요청방식 정의
	public static final String BODY_REQUEST_TYPE_POS = "1";//POS
	public static final String BODY_REQUEST_TYPE_DM = "2";//단말
	
	// 카드번호
	public static final String BODY_CARD_NO = "                                     ";// 37 byte 공백
		
	// 고객구분
	public static final String BODY_CUST_TYPE_1 = "1";//개인
	public static final String BODY_CUST_TYPE_2 = "2";// 개인책임식 법인
	
	// 비밀번호
	public static final String BODY_PASSWORD = "                ";//16byte 공백
	
	// 거래구분
	public static final String BODY_TRADE_FG = "  "; // 2byte 공백
	public static final String BODY_TRADE_FG_10 = "10";//적립
	public static final String BODY_TRADE_FG_20 = "20";//사용
	
	// 거래사유
	public static final String BODY_TRADE_REASON = "   "; // 3byte 공백
	public static final String BODY_TRADE_REASON_100 = "100";//거래구분10=>대금결재
	public static final String BODY_TRADE_REASON_200 = "200";//거래구분20=>대금결재
	
	// 제휴가맹점 번호
	public static final String BODY_FC_NO = "9214278970";
	public static final String BODY_FC_NO_NEW = "J390000001";
	
	// POS 번호
	public static final String BODY_POS_NO = "0001";
	
	//회원정보요청
//	public static final String BODY_MEMBER_REQ_YES = "1";
//	public static final String BODY_MEMBER_REQ_NO = "2";
	
	//FILLER	
	public static final String BODY_FILLER = "                                                                "; //64 byte 공백
	public static final String BODY_FILLER_NEW_100 ="                                                                                                    "; //100 byte공백
	public static final String BODY_FILLER_NEW = "                                                                                                                                                                                                        "; //200 byte 공백
	
	//결재카드번호
	public static final String BODY_APPROVAL_CARD_NO = "                ";//16byte 공백
	
	//포인트적립구분코드
//	public static final String BODY_PT_SAVE_FG_1 = "1";//매출금액
//	public static final String BODY_PT_SAVE_FG_2 = "2";//포인트
	
	//적립구분
	public static final String BODY_SAVE_TYPE_1 = "1";//정상
	public static final String BODY_SAVE_TYPE_2 = "2";//취소
	
	//사용구분
	public static final String BODY_USE_TYPE_1 = "1";//정상
	public static final String BODY_USE_TYPE_2 = "2";//취소
	// 숫자 12byte
	public static final String BODY_NUM_12 = "000000000000";
	public static final String BODY_NUM_9 = "000000000";
	
	public static final String BODY_INT_FLAG_0 = "0";
	public static final String BODY_INT_FLAG_1 = "1";
	public static final String BODY_INT_FLAG_2 = "2";
	public static final String BODY_INT_FLAG_3 = "3";
	public static final String BODY_INT_FLAG_9 = "9";
	
	/******************************************************
	 * TAIL 상수 정의
	 ******************************************************/
	public static final byte TAILER_END_FLAG_1 = (byte)0xff ;
	public static final byte TAILER_END_FLAG_2 = (byte)0x0d ;
	public static final byte TAILER_END_FLAG_3 = (byte)0x0a ;
	
}
