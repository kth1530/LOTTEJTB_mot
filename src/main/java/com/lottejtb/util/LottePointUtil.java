package com.lottejtb.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.Socket;
import java.net.UnknownHostException;

import com.lottejtb.util.LottePointConstants;
import com.lottejtb.util.DateUtil;

public class LottePointUtil {
	private LottePointUtil(){
	}
	
	/**
	 *  회원인증전문2000 SEND 전문 생성
	 * @param tradeNo : 추적번호
	 * @return
	 */
	public static byte[] makeFixedText2000(String tradeNo, String juminNo, String cardNo){
		byte[] length = null;
		byte[] header = null;
		byte[] body =  null;
		byte[] tail = null;
		byte[] fixedText2000 = null;
		// 전문길이
		//length = getLength((byte)0x00, (byte)0xe2); //구전문 226자리
		length = getLength((byte)0x01, (byte)0x0c); //신전문 268자리
		
		// 추적번호 생성(22 byte)
		String uniqueCode = getUniqueCode2000(tradeNo);
		
		// 헤더 생성
		//parameter : 전문번호, 추적번호, 전문 바디 길이
		//header = getHeader(LottePointConstants.HEADER_FIXED_TEXT_S_NO_2000 , uniqueCode, "0195");
		header = getHeader(LottePointConstants.HEADER_FIXED_TEXT_S_NO_2000 , uniqueCode, "0195");
		// 바디생성
		body =  makeBody2000(juminNo, cardNo);
		
		// 테일생성
		tail = getTailer();
		
		// 회원인증전문 2000 = 길이 2  + 헤더 73   + 바디   153    +    테일   3    = 9
		fixedText2000 = new byte[273]; //신전문
		
		// 전문복사(길이) : [원본배열], [원본배열시작위치],[복사할배열], [복사할 배열의 시작위치], [복사할 개수]
		System.arraycopy(length, 0, fixedText2000, 0, 2);
		// 전문복사(헤더)
		System.arraycopy(header, 0, fixedText2000, 2, 73);
		// 전문복사(바디)
		//System.arraycopy(body, 0, fixedText2000, 75, 153); //구전문
		System.arraycopy(body, 0, fixedText2000, 75, 195); //신전문
		// 전문복사(테일)
		//System.arraycopy(tail, 0, fixedText2000, 228, 3); //구전문
		System.arraycopy(tail, 0, fixedText2000, 270, 3); //신전문
		
		return fixedText2000;
	}
	
	/**
	 *  회원인증전문7000 SEND 전문 생성
	 * @param tradeNo : 추적번호
	 * @return
	 */
	public static byte[] makeFixedText7000(String tradeNo, String juminNo){
		byte[] length = null;
		byte[] header = null;
		byte[] body =  null;
		byte[] tail = null;
		byte[] fixedText2000 = null;
		// 전문길이
		length = getLength((byte)0x01, (byte)0x33);
		
		// 추적번호 생성(22 byte)
		String uniqueCode = getUniqueCode2000(tradeNo);
		
		// 헤더 생성
		header = getHeader(LottePointConstants.HEADER_FIXED_TEXT_S_NO_7000 ,
												   uniqueCode,
												   LottePointConstants.HEADER_FIXED_TEXT_BODY_LENGTH_7000);
		// 바디생성
		body =  makeBody7000(juminNo);
		
		// 테일생성
		tail = getTailer();
		
		// 회원인증전문 2000 = 길이 2  + 헤더 73   + 바디   153    +    테일   3    = 231
		// 회원인증전문 7000 = 길이 2  + 헤더 73   + 바디   234    +    테일   3    = 312
		//fixedText2000 = new byte[231];
		fixedText2000 = new byte[312];
		
		// 전문복사(길이) : [원본배열], [원본배열시작위치],[복사할배열], [복사할 배열의 시작위치], [복사할 개수]
		System.arraycopy(length, 0, fixedText2000, 0, 2);
		// 전문복사(헤더)
		System.arraycopy(header, 0, fixedText2000, 2, 73);
		// 전문복사(바디)
		//System.arraycopy(body, 0, fixedText2000, 75, 153);
		System.arraycopy(body, 0, fixedText2000, 75, 234);
		// 전문복사(테일)
		//System.arraycopy(tail, 0, fixedText2000, 228, 3);
		System.arraycopy(tail, 0, fixedText2000, 309, 3);
		
		return fixedText2000;
	}
	
	/**
	 *  회원인증전문2000 SEND 전문 생성
	 * @param tradeNo : 추적번호
	 * @return
	 */
	public static byte[] makeFixedText2000_card(String tradeNo, String juminNo){
		byte[] length = null;
		byte[] header = null;
		byte[] body =  null;
		byte[] tail = null;
		byte[] fixedText2000 = null;
		// 전문길이
		length = getLength((byte)0x00, (byte)0xe2);
		
		// 추적번호 생성(22 byte)
		String uniqueCode = getUniqueCode2000(tradeNo);
		
		// 헤더 생성
		header = getHeader(LottePointConstants.HEADER_FIXED_TEXT_S_NO_2000 ,
												   uniqueCode,
												   LottePointConstants.HEADER_FIXED_TEXT_BODY_LENGTH_2000);
		// 바디생성
		body =  makeBody2000_card(juminNo);
		
		// 테일생성
		tail = getTailer();
		
		// 회원인증전문 2000 = 길이 2  + 헤더 73   + 바디   153    +    테일   3    = 231
		fixedText2000 = new byte[231];
		
		// 전문복사(길이) : [원본배열], [원본배열시작위치],[복사할배열], [복사할 배열의 시작위치], [복사할 개수]
		System.arraycopy(length, 0, fixedText2000, 0, 2);
		// 전문복사(헤더)
		System.arraycopy(header, 0, fixedText2000, 2, 73);
		// 전문복사(바디)
		System.arraycopy(body, 0, fixedText2000, 75, 153);
		// 전문복사(테일)
		System.arraycopy(tail, 0, fixedText2000, 228, 3);

		return fixedText2000;
	}
	/**
	 * 회원인증전문 바디 생성
	 * @param juminNo
	 * @return
	 */
	public static byte[] makeBody2000(String juminNo, String cardNo){
		byte[] body = null;
		StringBuilder sBody = new StringBuilder();
		
		//구전문 샘플
		//sBody.append("31                                     80022614766121                     921427897000011                                                                ");
		
		//신전문 샘플
		//sBody.append("1118710490247032771                                         9055867857111122221                                                                                                                    ");
		
//		sBody.append(LottePointConstants.BODY_REQUEST_TYPE_POS);
//		sBody.append(LottePointConstants.BODY_CARD_NO);
//		sBody.append(juminNo);
//		sBody.append(LottePointConstants.BODY_CUST_TYPE_1);
//		sBody.append(LottePointConstants.BODY_PASSWORD);
//		sBody.append(LottePointConstants.BODY_TRADE_FG);
//		sBody.append(LottePointConstants.BODY_TRADE_REASON);
//		sBody.append(LottePointConstants.BODY_FC_NO);
//		sBody.append(LottePointConstants.BODY_POS_NO);
//		sBody.append(LottePointConstants.BODY_INT_FLAG_1);//회원정보 요
//		sBody.append(LottePointConstants.BODY_FILLER);
		
		sBody.append("3"); //WCC
		sBody.append("3"); //승인요청방식
		
		//고객식별구분코드
		if(!"".equals(juminNo) && null != juminNo) {
			sBody.append("2"); //고객번호 구분
			sBody.append("                                     "); //카드번호
			sBody.append(juminNo); //고객번호
			sBody.append("          "); //고객번호 공백
		} else{
			sBody.append("1"); //카드번호 구분
			sBody.append(leftAlignKorChar(37,cardNo,' '));//카드번
			sBody.append("                    "); //고객번호
		}
		
		
		sBody.append("9214278970"); //제휴가맹점번호
		sBody.append("0001"); //점포번호
		sBody.append("0001"); //POS번호
		sBody.append("0"); //회원정보요청
		sBody.append("                "); //비밀번호
		sBody.append("                                                                                                    "); //FILLER
		
		body = sBody.toString().getBytes();
		
		return body;
	}
	
	/**
	 * 회원인증전문 바디 생성(7000)
	 * @param juminNo
	 * @return
	 */
	public static byte[] makeBody7000(String juminNo){
		byte[] body = null;
		StringBuilder sBody = new StringBuilder();
		sBody.append(LottePointConstants.BODY_APPROVAL_CARD_NO);
		sBody.append(juminNo);
		sBody.append(LottePointConstants.BODY_FC_NO);
		sBody.append(LottePointConstants.BODY_FILLER_NEW);
		body = sBody.toString().getBytes();
		
		return body;
	}
	
	/**
	 * 회원인증전문 바디 생성
	 * @param juminNo
	 * @return
	 */
	public static byte[] makeBody2000_card(String juminNo){
		byte[] body = null;
		StringBuilder sBody = new StringBuilder();
		sBody.append(LottePointConstants.BODY_WCC_FG_KEYIN);
		sBody.append(LottePointConstants.BODY_REQUEST_TYPE_POS);
		sBody.append(juminNo); sBody.append("                     "); //카드번호
		sBody.append("             "); //주민번호
		sBody.append(LottePointConstants.BODY_CUST_TYPE_1);
		sBody.append(LottePointConstants.BODY_PASSWORD);
		sBody.append(LottePointConstants.BODY_TRADE_FG);
		sBody.append(LottePointConstants.BODY_TRADE_REASON);
		sBody.append(LottePointConstants.BODY_FC_NO);
		sBody.append(LottePointConstants.BODY_POS_NO);
		sBody.append(LottePointConstants.BODY_INT_FLAG_1);//회원정보 요
		sBody.append(LottePointConstants.BODY_FILLER);
		body = sBody.toString().getBytes();
		
		return body;
	}
	/**
	 * 롯데포인트 적립,적립취소 전문생성
	 * @param tradeNo	: 추적번호
	 * @param juminNo : 주민번호
	 * @param saveFg	: 적립구분 1: 정상, 2:취소
	 * @param apprNo : 제휴사승인번호
	 * @param totSaleAmt	: 총매출금액
	 * @param totCrepoint :  총생성포인트
	 * @param orgApprNo : 원거래승인번호
	 * @param orgTradeDay	:  원거래일자
	 * @return
	 */
	public static byte[] makeFixedText1110_1120(String tradeNo, String cardNo,String saveFg, String apprNo, String totSaleAmt, String totCreLtPoint, String orgApprNo, String orgTradeDay){
		byte[] length = null;
		byte[] header = null;
		byte[] body =  null;
		byte[] tail = null;
		byte[] fixedText1110_1120 = null;
		// 전문길이
		//length = getLength((byte)0x02, (byte)0xdc);//헤더 + 바디 => 73 + 659 => 732(10) =>2dc(16)
		length = getLength((byte)0x02, (byte)0xd0);
		// 추적번호 생성(22 byte)
		String uniqueCode = null;
		if(LottePointConstants.BODY_SAVE_TYPE_1.equals(saveFg)){
			uniqueCode = getUniqueCode1110(tradeNo);
		}else{
			uniqueCode = getUniqueCode1120(tradeNo);
		}
		
		// 헤더 생성-작업중 
		if(LottePointConstants.BODY_SAVE_TYPE_1.equals(saveFg)){
			header = getHeader(LottePointConstants.HEADER_FIXED_TEXT_S_NO_1110, uniqueCode, "0659");
											
		}else if(LottePointConstants.BODY_SAVE_TYPE_2.equals(saveFg)){
			header = getHeader(LottePointConstants.HEADER_FIXED_TEXT_S_NO_1120,	uniqueCode, "0659");
		}
		
		// 바디생성
		body =  makeBody1110_1120(cardNo,saveFg, apprNo, totSaleAmt, totCreLtPoint, orgApprNo, orgTradeDay);
		
		// 테일생성
		tail = getTailer();
		
		// 1111_1121 = 길이 2 + 헤더 73   + 바디   659    +    테일   3 = 737
		fixedText1110_1120 = new byte[725];
		
		
		// 전문복사(길이) : [원본배열], [원본배열시작위치],[복사할배열], [복사할 배열의 시작위치], [복사할 개수]
		System.arraycopy(length, 0, fixedText1110_1120, 0, 2);
		// 전문복사(헤더)
		//System.arraycopy(header, 0, fixedText1110_1120, 2, 73);
		// 전문복사(바디)
		System.arraycopy(body, 0, fixedText1110_1120, 2, 720);
		// 전문복사(테일)
		System.arraycopy(tail, 0, fixedText1110_1120, 722, 3);
		
		return fixedText1110_1120;
	}
	
	/**
	 * 롯데포인트 적립,적립취소 전문생성
	 * 2013.06.12 새로 작성
	 * @param tradeNo	: 추적번호
	 * @param juminNo : 주민번호
	 * @param saveFg	: 적립구분 1: 정상, 2:취소
	 * @param apprNo : 제휴사승인번호
	 * @param totSaleAmt	: 총매출금액
	 * @param totCrepoint :  총생성포인트
	 * @param orgApprNo : 원거래승인번호
	 * @param orgTradeDay	:  원거래일자
	 * @return
	 */
	public static byte[] makeFixedText1170_1180(String tradeNo, String cardNo,String saveFg, String apprNo, String totSaleAmt, String totCreLtPoint, String orgApprNo, String orgTradeDay){
		byte[] length = null;
		byte[] header = null;
		byte[] body =  null;
		byte[] tail = null;
		byte[] fixedText1170_1180 = null;
		
		// 전문길이
		length = getLength((byte)0x02, (byte)0xdc);//헤더 + 바디 => 73 + 659 => 732(10) =>2dc(16)
		length = getLength((byte)0x02, (byte)0x4b);//헤더 + 바디 => 73 + 514 => 587(10) =>24b(16)
		
		// 추적번호 생성(22 byte)
		String uniqueCode = null;
		if(LottePointConstants.BODY_SAVE_TYPE_1.equals(saveFg)){
			uniqueCode = getUniqueCode1170(tradeNo);
		}else{
			uniqueCode = getUniqueCode1180(tradeNo);
		}
		
		// 헤더 생성 
		if(LottePointConstants.BODY_SAVE_TYPE_1.equals(saveFg)){
			header = getHeader(LottePointConstants.HEADER_FIXED_TEXT_S_NO_1170, uniqueCode,
					LottePointConstants.HEADER_FIXED_TEXT_BODY_LENGTH_1170);
											
		}else if(LottePointConstants.BODY_SAVE_TYPE_2.equals(saveFg)){
			header = getHeader(LottePointConstants.HEADER_FIXED_TEXT_S_NO_1180,	uniqueCode, 
					LottePointConstants.HEADER_FIXED_TEXT_BODY_LENGTH_1170);
		}
		
		// 바디생성
		body =  makeBody1170_1180(cardNo,saveFg, apprNo, totSaleAmt, totCreLtPoint, orgApprNo, orgTradeDay);
		// 테일생성
		tail = getTailer();
		
		// 1170_1180 = 길이 2 + 헤더 73 + 바디  514 + 테일 3 = 737
		fixedText1170_1180 = new byte[592];
		
		
		// 전문복사(길이) : [원본배열], [원본배열시작위치],[복사할배열], [복사할 배열의 시작위치], [복사할 개수]
		System.arraycopy(length, 0, fixedText1170_1180, 0, 2);
		// 전문복사(헤더)
		System.arraycopy(header, 0, fixedText1170_1180, 2, 73);
		// 전문복사(바디)
		System.arraycopy(body, 0, fixedText1170_1180, 75, 514);
		// 전문복사(테일)
		System.arraycopy(tail, 0, fixedText1170_1180, 589, 3);

		return fixedText1170_1180;
	}

	public static byte[] makeBody1110_1120(String cardNo,String saveFg, String apprNo, String totSaleAmt, String totCreLtPoint, String orgApprNo, String orgTradeDay){
		byte[] body = null;
		StringBuilder sBody = new StringBuilder();
		body = sBody.toString().getBytes();
		return body;
	}
	
	/**
	 * 롯데포인트 적립,적립취소 body 생성
	 * 2013.06.12 새로 작성
	 * @param cardNo : 카드번호
	 * @param saveFg	: 적립구분 1: 정상, 2:취소
	 * @param apprNo : 제휴사승인번호
	 * @param totSaleAmt	: 총매출금액
	 * @param totCreLtPoint :  총생성포인트
	 * @param orgApprNo : 원거래승인번호
	 * @param orgTradeDay	:  원거래일자
	 * @return
	 */
	public static byte[] makeBody1170_1180(String cardNo,String saveFg, String apprNo, String totSaleAmt, String totCreLtPoint, String orgApprNo, String orgTradeDay){
		byte[] body = null;
		StringBuilder sBody = new StringBuilder();
		
		sBody.append(LottePointConstants.BODY_WCC_FG_KEYIN);//1.WCC 1자리
		sBody.append(LottePointConstants.BODY_REQUEST_TYPE_POS);//2.승인요청방식 1자리
		sBody.append(LottePointConstants.BODY_CUST_TYPE_1);//3.고객식별코드(신규) 1자리
		sBody.append(leftAlignKorChar(37,cardNo,' ')); //4.카드번호16자리 + 공백21자리 = 총37자
		sBody.append(leftAlignKorChar(20,null,' '));//5.고객식별값 공백 20자리
		sBody.append("9214278970");//6.제휴가맹점번호, 10자리
		sBody.append("0001");//7.점포번호 4자리
		sBody.append("0001");//8.포스번호 4자리
		sBody.append(apprNo); //9.제휴사승인번호 19자리
		sBody.append(DateUtil.toDateString()); //10.거래일자 8자리
		sBody.append(DateUtil.toTimeString()); //11.거래시간 6자리
		sBody.append(LottePointConstants.BODY_TRADE_FG_10); //12.거래구분 2자리
		sBody.append(LottePointConstants.BODY_TRADE_REASON_100); //13.거래사유 3자리
		sBody.append(saveFg); //14.적립구분 1자리
		sBody.append(LottePointConstants.BODY_INT_FLAG_0); //15.거래요청방식 1자리
		sBody.append(LottePointConstants.BODY_INT_FLAG_0); //16.회원정보요청 1자리
		sBody.append(leftAlignKorChar(16,null,' '));//17.비밀번호 16자리
		sBody.append(LottePointConstants.BODY_INT_FLAG_2);//18.포인트적립구분코드 1자리
		sBody.append(rightAlignChar(12,totSaleAmt,'0')); //19.총매출금액 12자리
		sBody.append(rightAlignChar(12,totSaleAmt,'0')); //20.포인트대상금액 12자리
		
		sBody.append(rightAlignChar(12,null,'0'));//21.현금매출금액 12자리
		sBody.append(rightAlignChar(12,totSaleAmt,'0')); //22.신용카드 매출금액 12자리
		sBody.append(rightAlignChar(12,null,'0'));//23.상품권 매출금액 12자리
		sBody.append(rightAlignChar(12,null,'0'));//24.포인트 매출금액 12자리
		sBody.append(rightAlignChar(12,null,'0'));//25.기타 매출금액 12자리
		sBody.append(rightAlignChar(9,totCreLtPoint,'0'));//26.총생성포인트 9자리
		
		sBody.append(rightAlignChar(9,null,'0'));//27.금회생성포인트(현금) 9자리
		sBody.append(rightAlignChar(9,totCreLtPoint,'0'));//28.금회생성포인트(카드) 9자리
		sBody.append(rightAlignChar(9,null,'0'));//29.금회생성포인트(상품권) 9자리
		sBody.append(rightAlignChar(9,null,'0'));//30.금회생성포인트(포인트) 9자리
		sBody.append(rightAlignChar(9,null,'0'));//31.금회생성포인트(기타) 9자리
		
		sBody.append(LottePointConstants.BODY_INT_FLAG_0);//32.첫거래포인트발생여부 1자리
		sBody.append(rightAlignChar(9,null,'0'));//33.첫거래포인트
		sBody.append(LottePointConstants.BODY_INT_FLAG_0);//34.생일포인트발생여부
		sBody.append(rightAlignChar(9,null,'0'));//35.생일포인트
		sBody.append(LottePointConstants.BODY_INT_FLAG_0);//36.결혼기념일포인트발생여부
		sBody.append(rightAlignChar(9,null,'0'));//37.결혼기념일포인트
		sBody.append(leftAlignKorChar(4,null,' '));//38.쿠폰번호 4자리
		sBody.append(LottePointConstants.BODY_INT_FLAG_9);//39.현금영수증자동발행신청 1자리
		sBody.append(LottePointConstants.BODY_INT_FLAG_1);//40.반품구분 1자리
		if(LottePointConstants.BODY_SAVE_TYPE_1.equals(saveFg)){//적립
			sBody.append(LottePointConstants.BODY_INT_FLAG_0);//41.원거래정보 유무 1자리
			sBody.append(leftAlignKorChar(28,null,' '));
		}else if(LottePointConstants.BODY_SAVE_TYPE_2.equals(saveFg)){//취소
			sBody.append(LottePointConstants.BODY_INT_FLAG_1);//41.원거래정보 유무 1자리
			sBody.append(LottePointConstants.BODY_INT_FLAG_2);//42.원거래정보 구분 1자리
			sBody.append(orgApprNo);//43.원거래승인번호 19자리
			sBody.append(orgTradeDay);//44.원거래일자 8자리
		}
		sBody.append(leftAlignKorChar(40,null,' '));//45.거래요청정보 40자
		sBody.append(leftAlignKorChar(100,null,' '));//46.FILLER
		sBody.append(LottePointConstants.BODY_INT_FLAG_0);//47.포인트유형정보 1자리	
		sBody.append(LottePointConstants.BODY_INT_FLAG_0);//50.이벤트정보 1자리
		sBody.append(LottePointConstants.BODY_INT_FLAG_1);//56.결제카드개수 1자리
		sBody.append(leftAlignKorChar(20,cardNo,' '));//57.결제카드번호 20자리
		sBody.append(rightAlignChar(12,totSaleAmt,'0'));//58.결제카드별매출금액 12자리
		
		body = sBody.toString().getBytes();
		
		return body;
	}
	
	/**
	 * 롯데포인트 사용,사용취소 생성
	 * @param juminNo : 주민번호
	 * @param useFg	: 적립구분 1: 정상, 2:취소
	 * @param apprNo : 제휴사승인번호
	 * @param lottePoint :  사용포인트
	 * @param orgApprNo : 원거래승인번호
	 * @param orgTradeDay	:  원거래일자
	 * @return body
	 */
	public static byte[] makeFixedText1210_1220_old(String tradeNo, String juminNo,String useFg, String apprNo ,String lottePoint, String orgApprNo, String orgTradeDay){
		byte[] length = null;
		byte[] header = null;
		byte[] body =  null;
		byte[] tail = null;
		byte[] fixedText1210_1220 = null;
		// 전문길이
		//length = getLength((byte)0x02, (byte)0x6d);
		length = getLength((byte)0x02, (byte)0x09);//헤더 + 바디 = 73 + 521 = 594 =>209(16)
		
		// 추적번호 생성(22 byte)
		String uniqueCode = null;
		if(LottePointConstants.BODY_USE_TYPE_1.equals(useFg)){
			uniqueCode = getUniqueCode1210(tradeNo);
		}else if(LottePointConstants.BODY_USE_TYPE_2.equals(useFg)){
			uniqueCode = getUniqueCode1220(tradeNo);
		}
		
		// 헤더 생성-작업중 
		if(LottePointConstants.BODY_USE_TYPE_1.equals(useFg)){//사용
			header = getHeader(LottePointConstants.HEADER_FIXED_TEXT_S_NO_1210 ,
											uniqueCode,
											LottePointConstants.HEADER_FIXED_TEXT_BODY_LENGTH_1210);
		}else if(LottePointConstants.BODY_USE_TYPE_2.equals(useFg)){
			header = getHeader(LottePointConstants.HEADER_FIXED_TEXT_S_NO_1220 ,
					uniqueCode,
					LottePointConstants.HEADER_FIXED_TEXT_BODY_LENGTH_1220);
		}
		
		// 바디생성
		body =  makeBody1210_1220(juminNo,useFg, apprNo, lottePoint, orgApprNo, orgTradeDay);
		
		// 테일생성
		tail = getTailer();
		
		// 회원인증전문 2000 = 길이 2  + 헤더 73   + 바디   275    +    테일   3    = 353
		fixedText1210_1220 = new byte[353];
		
		// 전문복사(길이) : [원본배열], [원본배열시작위치],[복사할배열], [복사할 배열의 시작위치], [복사할 개수]
		System.arraycopy(length, 0, fixedText1210_1220, 0, 2);
		// 전문복사(헤더)
		System.arraycopy(header, 0, fixedText1210_1220, 2, 73);
		// 전문복사(바디)
		System.arraycopy(body, 0, fixedText1210_1220, 75, 275);
		// 전문복사(테일)
		System.arraycopy(tail, 0, fixedText1210_1220, 350, 3);
		
		return fixedText1210_1220;
	}
	
	
	/**
	 * 롯데포인트 사용(TOS용) 1210
	 * @param juminNo : 주민번호
	 * @param useFg	: 적립구분 1: 정상, 2:취소
	 * @param apprNo : 제휴사승인번호
	 * @param lottePoint :  사용포인트
	 * @param orgApprNo : 원거래승인번호
	 * @param orgTradeDay	:  원거래일자
	 * @return body
	 */
	public static byte[] makeFixedText1210_1220(String saveFg, String tradeNo, String cardNo, String apprNo ,String lottePoint, String orgApprNo, String orgTradeDay){
		byte[] length = null;
		byte[] header = null;
		byte[] body =  null;
		byte[] tail = null;
		byte[] fixedText1210_1220 = null;
		// 전문길이
		//length = getLength((byte)0x02, (byte)0x6d);
		length = getLength((byte)0x02, (byte)0x09);//헤더 + 바디 => 73 + 448 => 521(10) =>209(16)
		
		String uniqueCode =  null;
		
		//추적번호, 해더 생성
		if(LottePointConstants.BODY_INT_FLAG_1.equals(saveFg)){//포인트 사용, 1210전문
			uniqueCode = getUniqueCode1210(tradeNo);
			header = getHeader(LottePointConstants.HEADER_FIXED_TEXT_S_NO_1210 , uniqueCode, "0448");
			
		}else if(LottePointConstants.BODY_INT_FLAG_2.equals(saveFg)){//포인트 사용취소, 1220전문
			uniqueCode = getUniqueCode1220(tradeNo);
			header = getHeader(LottePointConstants.HEADER_FIXED_TEXT_S_NO_1220 , uniqueCode, "0448");
			
		}
		
		// 바디생성
		body =  makeBody1210_1220(saveFg, cardNo, apprNo, lottePoint, orgApprNo, orgTradeDay);
		
		// 테일생성
		tail = getTailer();
		
		// 회원인증전문 2000 = 길이 2  + 헤더 73   + 바디   448    +    테일   3    = 526
		fixedText1210_1220 = new byte[526];
		
		// 전문복사(길이) : [원본배열], [원본배열시작위치],[복사할배열], [복사할 배열의 시작위치], [복사할 개수]
		System.arraycopy(length, 0, fixedText1210_1220, 0, 2);
		// 전문복사(헤더)
		System.arraycopy(header, 0, fixedText1210_1220, 2, 73);
		// 전문복사(바디)
		System.arraycopy(body, 0, fixedText1210_1220, 75, 448);
		// 전문복사(테일)
		System.arraycopy(tail, 0, fixedText1210_1220, 523, 3);
		
		return fixedText1210_1220;
	}
	
	
	/**
	 * 롯데포인트 사용,사용취소 생성(정통망법 개정 변경)
	 * @param pavv : pavv
	 * @param cardNo : 카드번호
	 * @param useFg	: 적립구분 1: 정상, 2:취소
	 * @param apprNo : 제휴사승인번호
	 * @param lottePoint :  사용포인트
	 * @param orgApprNo : 원거래승인번호
	 * @param orgTradeDay	:  원거래일자
	 * @return body
	 */
	public static byte[] makeFixedText7210_7220(String tradeNo, String wpw, String cardNo,String saveFg, String apprNo ,String lottePoint, String orgApprNo, String orgTradeDay){
		byte[] length = null;
		byte[] header = null;
		byte[] body =  null;
		byte[] tail = null;
		byte[] fixedText7210_7220 = null;
		// 전문길이, 459(10) -> 1CB(16)
		length = getLength((byte)0x01, (byte)0xcb);
		
	//	System.out.println("####################################################makeFixedText7210_7220--start");
	//	
	//	System.out.println("[makeFixedText7210_7220]tradeNo=" + tradeNo);
	//	System.out.println("[makeFixedText7210_7220]wpw=" + wpw);
	//	System.out.println("[makeFixedText7210_7220]cardNo=" + cardNo);
	//	System.out.println("[makeFixedText7210_7220]saveFg=" + saveFg);
	//	System.out.println("[makeFixedText7210_7220]apprNo=" + apprNo);
	//	System.out.println("[makeFixedText7210_7220]lottePoint=" + lottePoint);
	//	System.out.println("[makeFixedText7210_7220]orgApprNo=" + orgApprNo);
	//	System.out.println("[makeFixedText7210_7220]orgTradeDay=" + orgTradeDay);
		
	//	System.out.println("################################################makeFixedText7210_7220-end");
		
		// 추적번호 생성(22 byte)
		String uniqueCode = "";//getUniqueCode1210(tradeNo);
		
		/* 7210, 7720 분기*/
		if(LottePointConstants.BODY_USE_TYPE_1.equals(saveFg)){
			uniqueCode = getUniqueCode1210(tradeNo);
		}else if(LottePointConstants.BODY_USE_TYPE_2.equals(saveFg)){
			uniqueCode = getUniqueCode1220(tradeNo);
		}
		
		// 헤더 생성
		//header = getHeader(LottePointConstants.HEADER_FIXED_TEXT_S_NO_7210 ,uniqueCode, "0386");
		
		/* 7210, 7720 분기*/
		if(LottePointConstants.BODY_USE_TYPE_1.equals(saveFg)){
			header = getHeader(LottePointConstants.HEADER_FIXED_TEXT_S_NO_7210 ,
											uniqueCode,
											LottePointConstants.HEADER_FIXED_TEXT_BODY_LENGTH_7210);
		}else if(LottePointConstants.BODY_USE_TYPE_2.equals(saveFg)){
			header = getHeader(LottePointConstants.HEADER_FIXED_TEXT_S_NO_7220 ,
					uniqueCode,
					LottePointConstants.HEADER_FIXED_TEXT_BODY_LENGTH_7220);
		}
		
		// 바디생성
		body =  makeBody7210_7220(wpw, cardNo, saveFg, apprNo, lottePoint, orgApprNo, orgTradeDay);
		
		// 테일생성
		tail = getTailer();
		
		// 사용전문 7210 = 길이 2  + 헤더 73   + 바디   386    +    테일   3    = 464
		fixedText7210_7220 = new byte[464];
		
		// 전문복사(길이) : [원본배열], [원본배열시작위치],[복사할배열], [복사할 배열의 시작위치], [복사할 개수]
		System.arraycopy(length, 0, fixedText7210_7220, 0, 2); 
		// 전문복사(헤더)
		System.arraycopy(header, 0, fixedText7210_7220, 2, 73);
		// 전문복사(바디)
		System.arraycopy(body, 0, fixedText7210_7220, 75, 386);
		// 전문복사(테일)
		System.arraycopy(tail, 0, fixedText7210_7220, 461, 3);
		
		return fixedText7210_7220;
	}
	
	
	/**
	 * 롯데포인트 온라인 비밀번호 조회
	 * @param tradeNo : tradeNo
	 * @param cardNo	: 카드번호
	 * @param custCd : 고객번호
	 * @param password :  비밀번호
	 * @return body
	 */
	public static byte[] makeFixedText7610(String tradeNo, String cardNo, String custCd ,String password){
		byte[] length = null;
		byte[] header = null;
		byte[] body =  null;
		byte[] tail = null;
		byte[] fixedText7610 = null;
		// 전문길이
		//length = getLength((byte)0x02, (byte)0x6d);
		length = getLength((byte)0x00, (byte)0xb5);//헤더 + 바디 => 73 + 108 => 181(10) =>b5(16)
		
		String uniqueCode =  getUniqueCode1210(tradeNo);
		
		//추적번호, 해더 생성
		header = getHeader("7610", uniqueCode, "0108");
		
		// 바디생성
		body =  makeBody7610(cardNo, custCd, password);
		
		// 테일생성
		tail = getTailer();
		
		// 회원인증전문 2000 = 길이 2  + 헤더 73   + 바디   448    +    테일   3    = 526
		fixedText7610 = new byte[186];
		
		// 전문복사(길이) : [원본배열], [원본배열시작위치],[복사할배열], [복사할 배열의 시작위치], [복사할 개수]
		System.arraycopy(length, 0, fixedText7610, 0, 2);
		// 전문복사(헤더)
		System.arraycopy(header, 0, fixedText7610, 2, 73);
		// 전문복사(바디)
		System.arraycopy(body, 0, fixedText7610, 75, 108);
		// 전문복사(테일)
		System.arraycopy(tail, 0, fixedText7610, 183, 3);
		
		return fixedText7610;
	}
	
	
	/**
	 * 롯데포인트 사용,사용취소 생성
	 * @param juminNo : 주민번호
	 * @param useFg	: 적립구분 1: 정상, 2:취소
	 * @param apprNo : 제휴사승인번호
	 * @param lottePoint :  사용포인트
	 * @param orgApprNo : 원거래승인번호
	 * @param orgTradeDay	:  원거래일자
	 * @return body
	 */
	public static byte[] makeBody1210_1220_old(String juminNo,String useFg, String apprNo, String lottePoint, String orgApprNo, String orgTradeDay){
		byte[] body = null;
		StringBuilder sBody = new StringBuilder();
		sBody.append(LottePointConstants.BODY_WCC_FG_KEYIN);
		sBody.append(LottePointConstants.BODY_REQUEST_TYPE_POS);
		sBody.append(LottePointConstants.BODY_CARD_NO);
		//sBody.append(juminNo);
		sBody.append(LottePointConstants.BODY_CUST_TYPE_1);
		sBody.append(LottePointConstants.BODY_PASSWORD);
		sBody.append(LottePointConstants.BODY_FC_NO);
		//sBody.append(LottePointConstants.BODY_POS_NO);
		sBody.append(LottePointConstants.HEADER_COMP_CD);
		sBody.append(apprNo);
		sBody.append(DateUtil.toDateString());
		sBody.append(DateUtil.toTimeString());
		sBody.append(LottePointConstants.BODY_TRADE_FG_20);
		sBody.append(LottePointConstants.BODY_TRADE_REASON_200);
		if(LottePointConstants.BODY_USE_TYPE_1.equals(useFg)){
			sBody.append(LottePointConstants.BODY_INT_FLAG_1);
		}else if(LottePointConstants.BODY_USE_TYPE_2.equals(useFg)){
			sBody.append(LottePointConstants.BODY_INT_FLAG_2);
		}
		sBody.append(LottePointConstants.BODY_INT_FLAG_1);
		sBody.append(rightAlignChar(13,lottePoint,'0'));//롯데포인트
		sBody.append(rightAlignChar(9,null,'0'));
		sBody.append(LottePointConstants.BODY_INT_FLAG_0);
		sBody.append(rightAlignChar(9,null,'0'));
		sBody.append(LottePointConstants.BODY_INT_FLAG_0);
		sBody.append(rightAlignChar(9,null,'0'));
		sBody.append(LottePointConstants.BODY_INT_FLAG_0);
		sBody.append(rightAlignChar(9,null,'0'));
		sBody.append(leftAlignKorChar(4,null,' '));
		sBody.append(LottePointConstants.BODY_INT_FLAG_9);
		sBody.append(LottePointConstants.BODY_INT_FLAG_1);
		sBody.append(LottePointConstants.BODY_INT_FLAG_0);//반품구분
		if(LottePointConstants.BODY_USE_TYPE_1.equals(useFg)){//사용
			sBody.append(LottePointConstants.BODY_INT_FLAG_0);//원거래정보 없음
			sBody.append(leftAlignKorChar(28,null,' '));
		}else if(LottePointConstants.BODY_USE_TYPE_2.equals(useFg)){//사용취소
			sBody.append(LottePointConstants.BODY_INT_FLAG_1);//원거래정보 있음
			sBody.append(LottePointConstants.BODY_INT_FLAG_2);//원거래정보구분
			sBody.append(orgApprNo);
			sBody.append(orgTradeDay);
		}
		sBody.append(LottePointConstants.BODY_FILLER);
		body = sBody.toString().getBytes();

		return body;
	}
	
	/**
	 * 롯데포인트 사용(TOS용) 1210전문
	 * @param juminNo : 주민번호
	 * @param useFg	: 적립구분 1: 정상, 2:취소
	 * @param apprNo : 제휴사승인번호
	 * @param lottePoint :  사용포인트
	 * @param orgApprNo : 원거래승인번호
	 * @param orgTradeDay	:  원거래일자
	 * @return body
	 */
	public static byte[] makeBody1210_1220(String saveFg, String cardNo, String apprNo, String lottePoint, String orgApprNo, String orgTradeDay){
		byte[] body = null;
		StringBuilder sBody = new StringBuilder();
		sBody.append(LottePointConstants.BODY_WCC_FG_KEYIN);//wcc, 1자리
		sBody.append(LottePointConstants.BODY_REQUEST_TYPE_POS);//온라인, 1자리
		sBody.append(LottePointConstants.BODY_CUST_TYPE_1);//카드번호, 1자리
		//사용구분, 1자리
		if(LottePointConstants.BODY_INT_FLAG_1.equals(saveFg)){//사용
			sBody.append(leftAlignKorChar(37, cardNo, ' '));//카드번호16자리 + 공백 21자리 = 총 37자리
		}else if(LottePointConstants.BODY_INT_FLAG_2.equals(saveFg)){//취소
			sBody.append("                                     ");//카드번호16자리 + 공백 21자리 = 총 37자리
		}
		
		sBody.append("                    ");//filler, 20자리
		sBody.append("9214278970");//가맹점번호, 10자리
		sBody.append("0001");//점포번호, 4자리
		sBody.append("0001");//포스번호, 4자리
		sBody.append(apprNo); //제휴사승인번호, 19자리
		sBody.append(DateUtil.toDateString()); //거래일자, 8자리
		sBody.append(DateUtil.toTimeString()); //거래시간, 6자리
		sBody.append(LottePointConstants.BODY_TRADE_FG_20); //거래구분, 2자리
		sBody.append(LottePointConstants.BODY_TRADE_REASON_200); //거래사유, 3자리
		//사용구분, 1자리
		if(LottePointConstants.BODY_INT_FLAG_1.equals(saveFg)){//사용
			sBody.append(LottePointConstants.BODY_INT_FLAG_1);
		}else if(LottePointConstants.BODY_INT_FLAG_2.equals(saveFg)){//취소
			sBody.append(LottePointConstants.BODY_INT_FLAG_2);
		}
		
		sBody.append(LottePointConstants.BODY_INT_FLAG_0); //거래요청방식, 1자리
		sBody.append(LottePointConstants.BODY_INT_FLAG_0); //회원정보요청, 1자리
		sBody.append("                "); //비밀번호, 16자리
		sBody.append(LottePointConstants.BODY_INT_FLAG_1); //포인트차감사용플래그, 1자리
		sBody.append(rightAlignChar(13,lottePoint,'0'));//금회사용포인트, 13자리
		sBody.append(rightAlignChar(9,null,'0'));//봉투구매포인트, 9자리
		sBody.append(LottePointConstants.BODY_INT_FLAG_0);//첫거래포인트발생여부, 1자리
		sBody.append(rightAlignChar(9,null,'0'));//첫거래포인트, 9자리
		sBody.append(LottePointConstants.BODY_INT_FLAG_0);//생일포인트발생여부, 1자리
		sBody.append(rightAlignChar(9,null,'0'));//생일포인트, 9자리
		sBody.append(LottePointConstants.BODY_INT_FLAG_0);//결혼기념일포인트발생여부, 1자리
		sBody.append(rightAlignChar(9,null,'0'));//결혼기념일포인트, 9자리
		sBody.append("    "); //쿠폰번호, 4자리
		sBody.append(LottePointConstants.BODY_INT_FLAG_9); //현금영수증자동발행신청, 1자리
		sBody.append(LottePointConstants.BODY_INT_FLAG_0);//반품구분, 1자리
		
		if(LottePointConstants.BODY_INT_FLAG_1.equals(saveFg)){//사용
			sBody.append(LottePointConstants.BODY_INT_FLAG_0);//원거래정보 없음
			sBody.append("                            ");//1+19+8
		}else if(LottePointConstants.BODY_INT_FLAG_2.equals(saveFg)){//사용취소
			sBody.append(LottePointConstants.BODY_INT_FLAG_1);//원거래정보 있음
			sBody.append(LottePointConstants.BODY_INT_FLAG_2);//원거래정보구분, 1자리
			sBody.append(orgApprNo);//원거래승인번호, 19자리
			sBody.append(orgTradeDay);//원거래일자, 8자리
		}
		
		sBody.append("            ");//매출금액, 12자리
		sBody.append("            ");//포인트대상금액, 12자리
		sBody.append("                                                                                                                                                                                                         ");//filler, 201자리
		
		//sBody.append("1118710400056994052                                         L270000000A100B100100000             2013051414270020200101                1500          0        00        0         0             90                                                                                                                                                                                                                                                              ");
		body = sBody.toString().getBytes();
		
		return body;
	}
	
	/**
	 * 롯데포인트 사용,사용취소 생성(정통망법 개정)
	 * @param pavv : pavv
	 * @param cardNo : 카드번호
	 * @param useFg	: 적립구분 1: 정상, 2:취소
	 * @param apprNo : 제휴사승인번호
	 * @param lottePoint :  사용포인트
	 * @param orgApprNo : 원거래승인번호
	 * @param orgTradeDay	:  원거래일자
	 * @return body
	 */
	public static byte[] makeBody7210_7220(String wpw, String cardNo, String saveFg, String apprNo, String lottePoint, String orgApprNo, String orgTradeDay){
		byte[] body = null;
		StringBuilder sBody = new StringBuilder();
		sBody.append(LottePointConstants.BODY_WCC_FG_KEYIN); //WCC, 1자리
		sBody.append(LottePointConstants.BODY_INT_FLAG_3); //승인요청방식, 1자리
		sBody.append(leftAlignKorChar(16, cardNo, ' ')); //카드번호, 16자리 
		
		if(LottePointConstants.BODY_USE_TYPE_1.equals(saveFg)){
			//비밀번호 암호화, MD5
			EncryptMD5 encModule = new EncryptMD5();
			String encTxt = encModule.encrypt(wpw);
			sBody.append(leftAlignKorChar(40,encTxt,' ')); //비밀번호, 40자리
			
			sBody.append(" ");//filler, 1자리
			sBody.append("L190000001"); //제휴가맹점번호, 10자리
			sBody.append(LottePointConstants.HEADER_COMP_CD); //점포번호, 4자리
			sBody.append(apprNo); //제휴사승인번호, 19자리
			sBody.append(DateUtil.toDateString()); //거래일자, 8자리
			sBody.append(DateUtil.toTimeString()); //거래시간, 6자리
			sBody.append(LottePointConstants.BODY_TRADE_FG_20); //거래구분, 2자리
			sBody.append(LottePointConstants.BODY_TRADE_REASON_200); //거래사유, 3자리
			sBody.append(LottePointConstants.BODY_INT_FLAG_1); //사용구분, 1자리
			sBody.append(LottePointConstants.BODY_INT_FLAG_1); //포인트차감사용플래그, 1자리
			sBody.append(rightAlignChar(13,lottePoint,'0'));//금회사용포인트
			sBody.append(LottePointConstants.BODY_INT_FLAG_0); //첫거래포인트발생여부
			sBody.append(rightAlignChar(9,null,'0')); //첫거래포인트
			sBody.append(LottePointConstants.BODY_INT_FLAG_0); //생일포인트발생여부
			sBody.append(rightAlignChar(9,null,'0')); //생일포인트
			sBody.append(LottePointConstants.BODY_INT_FLAG_0); //결혼기념일포인트발생여부
			sBody.append(rightAlignChar(9,null,'0')); //결혼기념일포인트
			sBody.append(LottePointConstants.BODY_INT_FLAG_9); //현금영수증자동발행신청
			sBody.append(LottePointConstants.BODY_INT_FLAG_0);//원거래정보 없음, 1자리
			sBody.append(" ");//원거래정보구분, 1자리 
			sBody.append("                   ");//원거래승인번호, 19자리
			sBody.append("        ");//원거래승인번호, 8자리
			sBody.append(LottePointConstants.BODY_FILLER_NEW);
			body = sBody.toString().getBytes();
		} else if(LottePointConstants.BODY_USE_TYPE_2.equals(saveFg)){  //취소
			//비밀번호 암호화, MD5
			/*EncryptMD5 encModule = new EncryptMD5();
			String encTxt = encModule.encrypt(wpw);
			sBody.append(leftAlignKorChar(40,encTxt,' ')); //비밀번호, 40자리
			*/
			sBody.append(leftAlignKorChar(40,LottePointConstants.BODY_PASSWORD,' ')); 
			
			sBody.append(" ");//filler, 1자리
			sBody.append("L190000001"); //제휴가맹점번호, 10자리
			sBody.append(LottePointConstants.HEADER_COMP_CD); //점포번호, 4자리 

			sBody.append(apprNo); //제휴사승인번호, 19자리	
			sBody.append(DateUtil.toDateString()); //거래일자, 8자리
			sBody.append(DateUtil.toTimeString()); //거래시간, 6자리	
			sBody.append(LottePointConstants.BODY_TRADE_FG_20); //거래구분, 2자리	
			sBody.append(LottePointConstants.BODY_TRADE_REASON_200); //거래사유, 3자리	
			sBody.append(LottePointConstants.BODY_INT_FLAG_2); //사용구분, 1자리
			sBody.append(LottePointConstants.BODY_INT_FLAG_1); //포인트차감사용플래그, 1자리
			sBody.append(rightAlignChar(13,lottePoint,'0'));//사용포인트
			sBody.append(LottePointConstants.BODY_INT_FLAG_0); //첫거래포인트발생여부
			sBody.append(rightAlignChar(9,null,'0')); //첫거래포인트
			sBody.append(LottePointConstants.BODY_INT_FLAG_0); //생일포인트발생여부
			sBody.append(rightAlignChar(9,null,'0')); //생일포인트
			sBody.append(LottePointConstants.BODY_INT_FLAG_0); //결혼기념일포인트발생여부
			sBody.append(rightAlignChar(9,null,'0')); //결혼기념일포인트
			sBody.append(LottePointConstants.BODY_INT_FLAG_9); //현금영수증자동발행신청	
			sBody.append(LottePointConstants.BODY_INT_FLAG_1);//원거래정보 있음, 1자리
			sBody.append(LottePointConstants.BODY_INT_FLAG_2);//원거래정보구분, 1자리 
			sBody.append(rightAlignChar(19,orgApprNo,'0'));//원거래승인번호, 19자리
			sBody.append(rightAlignChar(8,orgTradeDay,'0'));//원거래승인번호, 8자리
			sBody.append(LottePointConstants.BODY_FILLER_NEW);
			body = sBody.toString().getBytes();
		}

		return body;
	}

	/**
	 * 롯데포인트 사용(TOS용) 1210전문
	 * @param juminNo : 주민번호
	 * @param useFg	: 적립구분 1: 정상, 2:취소
	 * @param apprNo : 제휴사승인번호
	 * @param lottePoint :  사용포인트
	 * @param orgApprNo : 원거래승인번호
	 * @param orgTradeDay	:  원거래일자
	 * @return body
	 */
	public static byte[] makeBody7610(String cardNo, String custNo, String password){
		byte[] body = null;
		StringBuilder sBody = new StringBuilder();
		
		sBody.append(leftAlignKorChar(16,cardNo,' '));//카드번호, 16자리
		sBody.append("1");//고객구분코드, 1자리
		sBody.append(leftAlignKorChar(11,custNo,' '));//고객번호, 11자리
		
		EncryptMD5 encModule = new EncryptMD5();
		String encTxt = encModule.encrypt(password);
		sBody.append(leftAlignKorChar(40,encTxt,' ')); //비밀번호, 40자리
		
		sBody.append("                                        ");//filler, 40자리
		
		body = sBody.toString().getBytes();

		return body;
	}
	
	
	/**
	 * 전문의 tail 생성
	 * @param length1
	 * @param length2
	 * @return
	 */
	public static byte[] getLength(byte length1,byte length2){
		byte[]  length = new byte[2];
		length[0] = length1; //구전문
		length[1] = length2; //구전문
		//length[0] = ' '; //신전문
		//length[1] = ' '; //신전문
		
		return length;
	}
	
	/**
	 * 전문의 헤더를 생성
	 * @param fiexedTextNo : 전문번호
	 * @param uniqueCode : 추적코드
	 * @param length : 데이터부 전문길이
	 * @return : byte[] header
	 */
	public static byte[] getHeader(String fiexedTextNo,String uniqueCode,String length){
		byte[] header = null;
		StringBuilder head = new StringBuilder();
		//head.append("A2000390020130531112412130531003900000100099 ON  0153                    "); //구전문 샘플
		//head.append("Z2000C900201304141500001                     ON  0195                    "); //신전문 샘플
		
		head.append("Z");
		head.append(fiexedTextNo);
		head.append("C900");//기관코드 변경
		head.append(DateUtil.toDateString());
		head.append(DateUtil.toTimeString());
		head.append(uniqueCode);
		head.append(LottePointConstants.HEADER_FIXED_TEXT_FG);
		head.append(LottePointConstants.HEADER_RETURN_CD);
		head.append(length);
		head.append(LottePointConstants.HEADER_SYSTEM_AREA);
		
		//head.append("Z"); //헤더타입
		//head.append("2000"); //전문번호
		//head.append("C900"); //기관번호
		//head.append(DateUtil.toDateString()); //전송일자
		//head.append(DateUtil.toTimeString()); //전송시간
		//head.append(uniqueCode); //추적번호
		//head.append("ON"); //전문구분
		//head.append("  "); //응답코드
		//head.append("0195"); //데이터크기
		//head.append("                    "); //시스템사용

		
		
		header = head.toString().getBytes();
		return header;
	}
	
	/**
	 * 전문의 테일을 생성
	 * @return : byte[] tailer
	 */
	public static byte[] getTailer(){
		byte[] tailer = new byte[3];
		tailer[0] = LottePointConstants.TAILER_END_FLAG_1;
		tailer[1] = LottePointConstants.TAILER_END_FLAG_2;
		tailer[2] = LottePointConstants.TAILER_END_FLAG_3;
		return tailer;
	}
	
	/**
	 * 소켓을 연결한다.
	 * @return
	 * 운영서버 배포시 REAL_SERVER로 변경후 배포, 배포가 완료되면 TEST_SERVER로 변경 후 commit
	 * 이유 : 개발서버를 REAL_SERVER  설정 해 놓았을 경우 전문은 전송되고, 포인트 데이터는 개발DB에 등록되기 때문이다.
	 */
	public static Socket getSocketConnect(){
		Socket socket = null;
		try {
			//socket = new Socket(LottePointConstants.REAL_SERVER_IP, LottePointConstants.REAL_SERVER_PORT);
			socket = new Socket(LottePointConstants.TEST_SERVER_IP_NEW, LottePointConstants.TEST_SERVER_PORT_NEW);
		} catch (UnknownHostException e) {
			//e.printStackTrace();
			System.err.println("UnknowHost Error!");
		} catch (IOException e) {
			//e.printStackTrace();
			System.err.println("IO Error!");
		} 
		return socket;
		
	} 
	
	/**
	 * 소켓을 연결한다.(정통망법 개정, 승인중계서버에 에이전트 재설치하였기 때문에 동일서버에 포트번호만 바꾸어서 테스트 가능)
	 * @return
	 * 운영서버 배포시 REAL_SERVER로 변경후 배포, 배포가 완료되면 TEST_SERVER로 변경 후 commit
	 * 이유 : 개발서버를 REAL_SERVER  설정 해 놓았을 경우 전문은 전송되고, 포인트 데이터는 개발DB에 등록되기 때문이다.
	 */
	public static Socket getSocketConnectNew(){
		Socket socket = null;
		try {
			//socket = new Socket(LottePointConstants.REAL_SERVER_IP, LottePointConstants.REAL_SERVER_PORT);
			socket = new Socket(LottePointConstants.TEST_SERVER_IP_NEW, LottePointConstants.TEST_SERVER_PORT_NEW);
		} catch (UnknownHostException e) {
			//e.printStackTrace();
			System.err.println("UnknowHost Error!");
		} catch (IOException e) {
			//e.printStackTrace();
			System.err.println("IO Error!");
		} 
		return socket;
		
	} 
	 
	/**
	 * 추적코드 생성 
	 * @param tradeNo
	 * @return
	 * 변경 : yymmdd + "00" + 3900" + "0001" + tradeNo + " "
	 */
	public static String getUniqueCode2000(String tradeNo){
		String uniqueCode = null;
		String toDay = DateUtil.toDateString();
//		tradeNo = toDay.substring(2)+"00"+tradeNo;
//		uniqueCode = LottePointConstants.HEADER_FIXED_TEXT_S_NO_2000 + LottePointConstants.HEADER_COMP_CD + tradeNo+" ";
		uniqueCode = toDay.substring(2) +"00"+ LottePointConstants.HEADER_COMP_CD  + "0001" + tradeNo +" ";
		return uniqueCode;
	}
	
	public static String getUniqueCode1110(String tradeNo){
		String uniqueCode = null;
		String toDay = DateUtil.toDateString();
//		tradeNo = toDay.substring(2)+"00"+tradeNo;
//		uniqueCode = LottePointConstants.HEADER_FIXED_TEXT_S_NO_1110 + LottePointConstants.HEADER_COMP_CD + tradeNo+" ";
		uniqueCode = toDay.substring(2) +"00"+ LottePointConstants.HEADER_COMP_CD  + "0001" + tradeNo +" ";
		return uniqueCode;
	}
	
	public static String getUniqueCode1120(String tradeNo){
		String uniqueCode = null;
		String toDay = DateUtil.toDateString();
//		tradeNo = toDay.substring(2)+"00"+tradeNo;
//		uniqueCode = LottePointConstants.HEADER_FIXED_TEXT_S_NO_1120+ LottePointConstants.HEADER_COMP_CD + tradeNo+" ";
		uniqueCode = toDay.substring(2) +"00"+ LottePointConstants.HEADER_COMP_CD  + "0001" + tradeNo +" ";
		return uniqueCode;
	}

	public static String getUniqueCode1170(String tradeNo){
		String uniqueCode = null;
		String toDay = DateUtil.toDateString();
//		tradeNo = toDay.substring(2)+"00"+tradeNo;
//		uniqueCode = LottePointConstants.HEADER_FIXED_TEXT_S_NO_1110 + LottePointConstants.HEADER_COMP_CD + tradeNo+" ";
		uniqueCode = toDay.substring(2) +"00"+ LottePointConstants.HEADER_COMP_CD  + "0001" + tradeNo +" ";
		return uniqueCode;
	}
	
	public static String getUniqueCode1180(String tradeNo){
		String uniqueCode = null;
		String toDay = DateUtil.toDateString();
//		tradeNo = toDay.substring(2)+"00"+tradeNo;
//		uniqueCode = LottePointConstants.HEADER_FIXED_TEXT_S_NO_1120+ LottePointConstants.HEADER_COMP_CD + tradeNo+" ";
		uniqueCode = toDay.substring(2) +"00"+ LottePointConstants.HEADER_COMP_CD  + "0001" + tradeNo +" ";
		return uniqueCode;
	}
	
	public static String getUniqueCode1210(String tradeNo){
		String uniqueCode = null;
		String toDay = DateUtil.toDateString();
//		tradeNo = toDay.substring(2)+"00"+tradeNo;
//		uniqueCode = LottePointConstants.HEADER_FIXED_TEXT_S_NO_1210 + LottePointConstants.HEADER_COMP_CD + tradeNo+" ";
		uniqueCode = toDay.substring(2) +"00"+ LottePointConstants.HEADER_COMP_CD  + "0001" + tradeNo +" ";
		return uniqueCode;
	}
	
	public static String getUniqueCode1220(String tradeNo){
		String uniqueCode = null;
		String toDay = DateUtil.toDateString();
//		tradeNo = toDay.substring(2)+"00"+tradeNo;
//		uniqueCode = LottePointConstants.HEADER_FIXED_TEXT_S_NO_1220 + LottePointConstants.HEADER_COMP_CD + tradeNo+" ";
		uniqueCode = toDay.substring(2) +"00"+ LottePointConstants.HEADER_COMP_CD  + "0001" + tradeNo +" ";
		return uniqueCode;
	}
	
	/**
	 * 파일 항목 write 시 Format에 지정한 자리수보다 데이터가 작을경우 남는 데이터를 오른쪽에 정렬하고,
	 * 왼쪽 공간을 지정 문자로 채운다. 파일 항목에 대한 Format이 숫자형일 경우에 사용한다.
	 * 
	 * @param length 항목 길이
	 * @param data 데이터
	 * @param padding 채움문자
	 */
	private static String rightAlignChar(int length, String data, char padding)
	{
        StringBuffer sb = new StringBuffer();
        // 데이터가 null일 경우 전체를 채움문자로 채운다.
        if (data == null) {
        	for (int i=0; i < length; i++)
        		sb.append(padding);
        }
        else {
        	int dataLen = data.length();
        	// 왼쪽 공간을 채움문자로 채운다.
        	for (int i=0; i < length - dataLen; i++)
        		sb.append(padding);

        	sb.append(data);
        }       
        return sb.toString();
    }
	
	/**
	 * 파일 항목 write 시 Format에 지정한 자리수보다 데이터가 작을경우 남는 데이터를 왼쪽에 정렬하고,
	 * 오른쪽 공간을 지정 문자로 채운다. 파일 항목에 대한 Format이 문자열(2바이트 문자열 포함)일 경우에 사용한다.
	 * 
	 * @param length 항목 길이
	 * @param data 데이터
	 * @param padding 채움문자
	 */
	private static String leftAlignKorChar(int length, String data, char padding)
	{
		StringBuffer sb = new StringBuffer();
		// 데이터가 null일 경우 전체를 채움문자로 채운다.
		if (data == null) {
        	for (int i=0; i < length; i++)
        		sb.append(padding);
        }
        else {
        	char c;
        	// 데이터의 총 바이트 수를 구한다.
        	int totBytes = data.getBytes().length;
        	for (int i=0, j = 0; i < length; i++) {
        		if (j >= totBytes)
        			break;

        		c = data.charAt(i);
        		// 2 바이트 문자 체크
        		if (c > 255)
        			j += 2;
        		else
        			j++;
	        
        		// 2 바이트 문자가 중간에 걸려서 깨지는 것을 방지하기 위해 마지막 한글은 제외 시킨다.
        		if (j > length) {
        			sb.append(padding);
        			break;
        		}
        		sb.append(c);
        	}
        	// 오른쪽 공간을 채움문자로 채운다.
        	for (int i=0; i < length - totBytes; i++)
        		sb.append(padding);
        }
        return sb.toString();
    }

}
