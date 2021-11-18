package com.lottejtb.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.net.SocketException;

public class LottePointTcpClient {
	private LottePointTcpClient(){
	}
	
	public static byte[] sendFixedText2000(String tradeNo, String juminNo, String cardNo){
		DataOutputStream outs=null;
		DataInputStream ins = null;
	    Socket sc           = null;
	    byte[] fixedText2000 = null;
	    byte[] fixedText2001 = null;
		
		try{
			// SEND 전문 생성
			fixedText2000 = LottePointUtil.makeFixedText2000(tradeNo,juminNo, cardNo);
			
			//소켓연결
			sc = LottePointUtil.getSocketConnect();
			sc.setSoTimeout(LottePointConstants.SOCKET_TIME_OUT * 5000);
			
			outs 	=	new DataOutputStream(new BufferedOutputStream(sc.getOutputStream()));
	    	ins 	= 	new DataInputStream(new BufferedInputStream(sc.getInputStream()));
			
	    	
	    	// REQUEST 데이터
	    	outs.write( fixedText2000, 0, fixedText2000.length );
			outs.flush();
			
			// RESPONSE 데이터
			// 회원인증전문 2001 = 길이 2 + 헤더 73   + 바디   955    +    테일   3 = 1033
			fixedText2001 = getStream(ins,1033);
			
			// close
			outs.close();
			ins.close();
		}catch (SocketException e) {
			//e.printStackTrace();
			System.err.println("Socket Error!");
		}catch(IOException e){
			//e.printStackTrace();
			System.err.println("IO Error!");
		}catch(Exception e){
			//e.printStackTrace();
			System.err.println("Stream Error!");
		}finally{
			if ( outs != null )   try{outs.close();}catch(Exception e){ System.err.println("Stream Close Error!"); }
		    if ( ins != null )    try{ins.close();}catch(Exception e){ System.err.println("Stream Close Error!"); }
		    if ( sc != null )     try{sc.close();}catch(Exception e){ System.err.println("Stream Close Error!"); }
		}
		
		return fixedText2001;
	}
	
	/**
	 * 회원인증전문7000 전송
	 * @return 회원인증전문 7001
	 */
	public static byte[] sendFixedText7000(String tradeNo, String juminNo){
		DataOutputStream outs=null;
		DataInputStream ins = null;
	    Socket sc           = null;
	    byte[] fixedText2000 = null;
	    byte[] fixedText2001 = null;
		
		try{
			// SEND 전문 생성
			fixedText2000 = LottePointUtil.makeFixedText7000(tradeNo,juminNo);
			
			//소켓연결
			sc = LottePointUtil.getSocketConnectNew();
			sc.setSoTimeout(LottePointConstants.SOCKET_TIME_OUT * 5000);
			
			outs 	=	new DataOutputStream(new BufferedOutputStream(sc.getOutputStream()));
	    	ins 	= 	new DataInputStream(new BufferedInputStream(sc.getInputStream()));
			
	    	
	    	// REQUEST 데이터
	    	outs.write( fixedText2000, 0, fixedText2000.length );
			outs.flush();
			
			// RESPONSE 데이터
			// 회원인증전문 2001 = 길이 2 + 헤더 73   + 바디   879    +    테일   3 = 957
			// 회원인증전문 7001 = 길이 2 + 헤더 73   + 바디   417    +    테일   3 = 495
			//fixedText2001 = getStream(ins,957);;
			fixedText2001 = getStream(ins,495);;
			
			// close
			outs.close();
			ins.close();
		}catch (SocketException e) {
			//e.printStackTrace();
			System.err.println("Socket Error!");
		}
		catch(IOException e){
			//e.printStackTrace();
			System.err.println("IO Error!");
		}catch(Exception e){
			//e.printStackTrace();
			System.err.println("Stream Error!");
		}finally{
			if ( outs != null )   try{outs.close();}catch(Exception e){ 
				//e.printStackTrace(); 
				System.err.println("Stream Close Error!");}
		    if ( ins != null )    try{ins.close();}catch(Exception e){ 
		    	//e.printStackTrace(); 
		    	System.err.println("Stream Close Error!");}
		    if ( sc != null )     try{sc.close();}catch(Exception e){ 
		    	//e.printStackTrace(); 
		    	System.err.println("Stream Close Error!");}
		}
		
		return fixedText2001;
	}
	
	/**
	 * 회원인증전문2000 전송
	 * @return 회원인증전문 2001
	 */
	public static byte[] sendFixedText2000_card(String tradeNo, String juminNo){
		DataOutputStream outs=null;
		DataInputStream ins = null;
	    Socket sc           = null;
	    byte[] fixedText2000 = null;
	    byte[] fixedText2001 = null;
		
		try{
			// SEND 전문 생성
			fixedText2000 = LottePointUtil.makeFixedText2000_card(tradeNo,juminNo);
			
			//소켓연결
			sc = LottePointUtil.getSocketConnect();
			sc.setSoTimeout(LottePointConstants.SOCKET_TIME_OUT * 5000);
			
			outs 	=	new DataOutputStream(new BufferedOutputStream(sc.getOutputStream()));
	    	ins 	= 	new DataInputStream(new BufferedInputStream(sc.getInputStream()));
			
	    	
	    	// REQUEST 데이터
	    	outs.write( fixedText2000, 0, fixedText2000.length );
			outs.flush();
			
			// RESPONSE 데이터
			// 회원인증전문 2001 = 길이 2 + 헤더 73   + 바디   879    +    테일   3 = 957
			fixedText2001 = getStream(ins,957);;
			
			// close
			outs.close();
			ins.close();
		}catch (SocketException e) {
			//e.printStackTrace();
			System.err.println("Socket Error!");
		}
		catch(IOException e){
			//e.printStackTrace();
			System.err.println("IO Error!");
		}catch(Exception e){
			//e.printStackTrace();
			System.err.println("Stream Error!");
		}finally{
			if ( outs != null )   try{outs.close();}catch(Exception e){ 
				//e.printStackTrace(); 
				System.err.println("Stream Close Error!");}
		    if ( ins != null )    try{ins.close();}catch(Exception e){ 
		    	//e.printStackTrace(); 
		    	System.err.println("Stream Close Error!");}
		    if ( sc != null )     try{sc.close();}catch(Exception e){ 
		    	//e.printStackTrace(); 
		    	System.err.println("Stream Close Error!");}
		}
		
		return fixedText2001;
	}
	/**
	 * 롯데포인트 적립취소 전문 1110,1120 , 적립구분으로 구분처리한다.
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
	public static byte[] sendFixedText1110_1120(String tradeNo, String cardNo,String saveFg, String apprNo, String totSaleAmt, String totCrepoint, String orgApprNo, String orgTradeDay){
		
		DataOutputStream outs=null;
		DataInputStream ins = null;
	    Socket sc           = null;
	    byte[] fixedText1110_1120 = null;
	    byte[] fixedText1111_1121 = null;
	    
	    try{
	    	//SEND 전문 생성
			fixedText1110_1120 = LottePointUtil.makeFixedText1110_1120(tradeNo, cardNo, saveFg, apprNo, totSaleAmt, totCrepoint, orgApprNo, orgTradeDay);
			
			//소켓연결
			sc = LottePointUtil.getSocketConnect();
			sc.setSoTimeout(LottePointConstants.SOCKET_TIME_OUT * 5000);
			
			outs 	=	new DataOutputStream(new BufferedOutputStream(sc.getOutputStream()));
	    	ins 	= 	new DataInputStream(new BufferedInputStream(sc.getInputStream()));
	    	
	    	// REQUEST 데이터   	
	    	outs.write( fixedText1110_1120, 0, fixedText1110_1120.length );
			outs.flush();
			
			// RESPONSE 데이터
			// 적립적립취소전문 1111_1121 = 길이 2 + 헤더 73   + 바디   1102    +    테일   3 = 1180
			fixedText1111_1121 = getStream(ins,1180);
			
			// close
			outs.close();
			ins.close();
	    }catch (SocketException e) {
			//e.printStackTrace();
			System.err.println("Socket Error!");
		}
		catch(IOException e){
			//e.printStackTrace();
			System.err.println("IO Error!");
		}catch(Exception e){
			//e.printStackTrace();
			System.err.println("Stream Error!");
		}finally{
			if ( outs != null )   try{outs.close();}catch(Exception e){ 
				//e.printStackTrace(); 
				System.err.println("Stream Close Error!");}
		    if ( ins != null )    try{ins.close();}catch(Exception e){ 
		    	//e.printStackTrace(); 
		    	System.err.println("Stream Close Error!");}
		    if ( sc != null )     try{sc.close();}catch(Exception e){ 
		    	//e.printStackTrace(); 
		    	System.err.println("Stream Close Error!");}
		}
		return fixedText1111_1121;
	}
	
	/**
	 * 롯데포인트 적립취소 전문 1170,1180 , 적립구분으로 구분처리한다.
	 * 2013.06.13 새로 작성
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
	public static byte[] sendFixedText1170_1180(String tradeNo, String cardNo,String saveFg, String apprNo, String totSaleAmt, String totCrepoint, String orgApprNo, String orgTradeDay){
		
		DataOutputStream outs=null;
		DataInputStream ins = null;
	    Socket sc           = null;
	    
	    byte[] fixedText1170_1180 = null;
	    byte[] fixedText1171_1181 = null;
	    
	    try{
	    	//SEND 전문 생성
			fixedText1170_1180 = LottePointUtil.makeFixedText1170_1180(tradeNo, cardNo, saveFg, apprNo, totSaleAmt, totCrepoint, orgApprNo, orgTradeDay);
			//소켓연결
			sc = LottePointUtil.getSocketConnect();
			sc.setSoTimeout(LottePointConstants.SOCKET_TIME_OUT * 5000);
			
			outs 	=	new DataOutputStream(new BufferedOutputStream(sc.getOutputStream()));
	    	ins 	= 	new DataInputStream(new BufferedInputStream(sc.getInputStream()));
	    	
	    	// REQUEST 데이터
	    	outs.write( fixedText1170_1180, 0, fixedText1170_1180.length );
			outs.flush();
			
			// RESPONSE 데이터
			// 적립응전문 1171_1181 = 길이 2 + 헤더 73 + 바디   1090 + 테일   3 = 1168
			fixedText1171_1181 = getStream(ins,1168);
			
			// close
			outs.close();
			ins.close();
	    }catch (SocketException e) {
			//e.printStackTrace();
			System.err.println("Socket Error!");
		}
		catch(IOException e){
			//e.printStackTrace();
			System.err.println("IO Error!");
		}catch(Exception e){
			//e.printStackTrace();
			System.err.println("Stream Error!");
		}finally{
			if ( outs != null )   try{outs.close();}catch(Exception e){ 
				//e.printStackTrace(); 
				System.err.println("Stream Close Error!");}
		    if ( ins != null )    try{ins.close();}catch(Exception e){ 
		    	//e.printStackTrace(); 
		    	System.err.println("Stream Close Error!");}
		    if ( sc != null )     try{sc.close();}catch(Exception e){ 
		    	//e.printStackTrace(); 
		    	System.err.println("Stream Close Error!");}
		}
		
		return fixedText1171_1181;
	}
	
	/**
	 * 롯데포인트 사용, 사용취소
	 * @param tradeNo
	 * @param juminNo
	 * @param saveFg
	 * @param apprNo
	 * @param lottePoint
	 * @param orgApprNo
	 * @param orgTradeDay
	 * @return
	 */
	public static byte[] sendFixedText1210_1220_old(String tradeNo, String juminNo,String saveFg, String apprNo, String lottePoint, String orgApprNo, String orgTradeDay){
		DataOutputStream outs=null;
		DataInputStream ins = null;
	    Socket sc           = null;
	    byte[] fixedText1210_1220 = null;
	    byte[] fixedText1211_1221 = null;
	    try{
	    	//SEND 전문 생성
	    	fixedText1210_1220 = LottePointUtil.makeFixedText1210_1220(tradeNo, juminNo, saveFg, apprNo,  lottePoint, orgApprNo, orgTradeDay);
	    	String strfixedText1210_1220 = new String(fixedText1210_1220,"EUC_KR");
	    	//소켓연결
			sc = LottePointUtil.getSocketConnect();
			sc.setSoTimeout(LottePointConstants.SOCKET_TIME_OUT * 5000);
			
			outs 	=	new DataOutputStream(new BufferedOutputStream(sc.getOutputStream()));
	    	ins 	= 	new DataInputStream(new BufferedInputStream(sc.getInputStream()));
			
	    	
	    	// REQUEST 데이터
	    	outs.write( fixedText1210_1220, 0, fixedText1210_1220.length );
			outs.flush();
			
			// RESPONSE 데이터
			// 사용사용취소전문 1211_1121 = 길이 2 + 헤더 73   + 바디   1003    +    테일   3 = 1081
			fixedText1211_1221 = getStream(ins,1081);
			
			// close
			outs.close();
			ins.close();
	    }catch (SocketException e) {
			//e.printStackTrace();
			System.err.println("Socket Error!");
		}
		catch(IOException e){
			//e.printStackTrace();
			System.err.println("IO Error!");
		}catch(Exception e){
			//e.printStackTrace();
			System.err.println("Stream Error!");
		}finally{
			if ( outs != null )   try{outs.close();}catch(Exception e){ 
				//e.printStackTrace(); 
				System.err.println("Stream Close Error!");}
		    if ( ins != null )    try{ins.close();}catch(Exception e){ 
		    	//e.printStackTrace(); 
		    	System.err.println("Stream Close Error!");}
		    if ( sc != null )     try{sc.close();}catch(Exception e){ 
		    	//e.printStackTrace(); 
		    	System.err.println("Stream Close Error!");}
		}
	    return fixedText1211_1221;
	}
	
	/**
	 * 롯데포인트 사용(TOS용) 1210전문
	 * @param tradeNo
	 * @param juminNo
	 * @param saveFg
	 * @param apprNo
	 * @param lottePoint
	 * @param orgApprNo
	 * @param orgTradeDay
	 * @return
	 */
	public static byte[] sendFixedText1210_1220(String saveFg, String tradeNo, String cardNo, String apprNo, String lottePoint, String orgApprNo, String orgTradeDay){
		DataOutputStream outs=null;
		DataInputStream ins = null;
	    Socket sc           = null;
	    byte[] fixedText1210_1220 = null;
	    byte[] fixedText1211_1221 = null;
	    try{
	    	//SEND 전문 생성
	    	fixedText1210_1220 = LottePointUtil.makeFixedText1210_1220(saveFg, tradeNo, cardNo, apprNo,  lottePoint, orgApprNo, orgTradeDay);
	    	String strfixedText1210_1220 = new String(fixedText1210_1220,"EUC_KR");
	    	
	    	//소켓연결
			sc = LottePointUtil.getSocketConnect();
			sc.setSoTimeout(LottePointConstants.SOCKET_TIME_OUT * 5000);
			
			outs 	=	new DataOutputStream(new BufferedOutputStream(sc.getOutputStream()));
	    	ins 	= 	new DataInputStream(new BufferedInputStream(sc.getInputStream()));
			
	    	
	    	// REQUEST 데이터
	    	outs.write( fixedText1210_1220, 0, fixedText1210_1220.length );
			outs.flush();
			
			// RESPONSE 데이터
			// 사용사용취소전문 1211_1121 = 길이 2 + 헤더 73   + 바디   1165    +    테일   3 = 1238
			fixedText1211_1221 = getStream(ins,1243);
			
			// close
			outs.close();
			ins.close();
	    }catch (SocketException e) {
			//e.printStackTrace();
			System.err.println("Socket Error!");
		}
		catch(IOException e){
			//e.printStackTrace();
			System.err.println("IO Error!");
		}catch(Exception e){
			//e.printStackTrace();
			System.err.println("Stream Error!");
		}finally{
			if ( outs != null )   try{outs.close();}catch(Exception e){ 
				//e.printStackTrace(); 
				System.err.println("Stream Close Error!");}
		    if ( ins != null )    try{ins.close();}catch(Exception e){ 
		    	//e.printStackTrace(); 
		    	System.err.println("Stream Close Error!");}
		    if ( sc != null )     try{sc.close();}catch(Exception e){ 
		    	//e.printStackTrace(); 
		    	System.err.println("Stream Close Error!");}
		}
	    return fixedText1211_1221;
	}


	
	/**
	 * 롯데포인트 사용, 사용취소(정통망법개정 신규전문 7210)
	 * @param tradeNo
	 * @param pavv(추가된 부분)
	 * @param cardNo(기존 주민번호 대신 카드번호로 변경됨)
	 * @param saveFg
	 * @param apprNo
	 * @param lottePoint
	 * @param orgApprNo
	 * @param orgTradeDay
	 * @return
	 */
	public static byte[] sendFixedText7210_7220(String tradeNo, String wpw, String cardNo,String saveFg, String apprNo, String lottePoint, String orgApprNo, String orgTradeDay){
		DataOutputStream outs=null; 
		DataInputStream ins = null;
	    Socket sc           = null;
	    byte[] fixedText7210_7220 = null;
	    byte[] fixedText7211_7221 = null;
	    try{
	    	//SEND 전문 생성
	    	fixedText7210_7220 = LottePointUtil.makeFixedText7210_7220(tradeNo, wpw, cardNo, saveFg, apprNo,  lottePoint, orgApprNo, orgTradeDay);
	    	
	    	String strfixedText7210_7220 = new String(fixedText7210_7220,"EUC_KR");
	    	
	    	//소켓연결
			sc = LottePointUtil.getSocketConnect();
			sc.setSoTimeout(LottePointConstants.SOCKET_TIME_OUT * 5000);
			
			outs 	=	new DataOutputStream(new BufferedOutputStream(sc.getOutputStream()));
	    	ins 	= 	new DataInputStream(new BufferedInputStream(sc.getInputStream()));
			
	    	
	    	// REQUEST 데이터
	    	outs.write( fixedText7210_7220, 0, fixedText7210_7220.length );
			outs.flush();
			
			// RESPONSE 데이터
			// 사용사용취소전문 7211_7221 = 길이 2 + 헤더 73   + 바디   591    +    테일   3 = 669
			fixedText7211_7221 = getStream(ins,669);
			
			// close
			outs.close();
			ins.close();
	    }catch (SocketException e) {
			//e.printStackTrace();
			System.err.println("Socket Error!");
		}
		catch(IOException e){
			//e.printStackTrace();
			System.err.println("IO Error!");
		}catch(Exception e){
			//e.printStackTrace();
			System.err.println("Stream Error!");
		}finally{
			if ( outs != null )   try{outs.close();}catch(Exception e){ 
				//e.printStackTrace(); 
				System.err.println("Stream Close Error!");}
		    if ( ins != null )    try{ins.close();}catch(Exception e){ 
		    	//e.printStackTrace(); 
		    	System.err.println("Stream Close Error!");}
		    if ( sc != null )     try{sc.close();}catch(Exception e){ 
		    	//e.printStackTrace(); 
		    	System.err.println("Stream Close Error!");}
		}
	    return fixedText7211_7221;
	}
	
	
	/**
	 * 롯데포인트 온라인 비밀번호 조회
	 * @param tradeNo
	 * @param juminNo
	 * @param custCd
	 * @param password
	 * @return
	 */
	public static byte[] sendFixedText7610(String tradeNo, String cardNo, String custCd, String password){
		DataOutputStream outs=null;
		DataInputStream ins = null;
	    Socket sc           = null;
	    byte[] fixedText7610 = null;
	    byte[] fixedText7611 = null;
	    try{
	    	//SEND 전문 생성
	    	fixedText7610 = LottePointUtil.makeFixedText7610(tradeNo, cardNo, custCd,  password);
	    	String strfixedText7610 = new String(fixedText7610,"EUC_KR");
	    	
	    	//소켓연결
			sc = LottePointUtil.getSocketConnect();
			sc.setSoTimeout(LottePointConstants.SOCKET_TIME_OUT * 5000);
			
			outs 	=	new DataOutputStream(new BufferedOutputStream(sc.getOutputStream()));
	    	ins 	= 	new DataInputStream(new BufferedInputStream(sc.getInputStream()));
			
	    	
	    	// REQUEST 데이터
	    	outs.write( fixedText7610, 0, fixedText7610.length );
			outs.flush();
			
			// RESPONSE 데이터
			// 온라인비밀번호 체크  7610 = 길이 2 + 헤더 73   + 바디   166    +    테일   3 = 244
			fixedText7611 = getStream(ins,244);
			
			// close
			outs.close();
			ins.close();
	    }catch (SocketException e) {
			//e.printStackTrace();
			System.err.println("Socket Error!");
		}
		catch(IOException e){
			//e.printStackTrace();
			System.err.println("IO Error!");
		}catch(Exception e){
			//e.printStackTrace();
			System.err.println("Stream Error!");
		}finally{
			if ( outs != null )   try{outs.close();}catch(Exception e){ 
				//e.printStackTrace(); 
				System.err.println("Stream Close Error!");}
		    if ( ins != null )    try{ins.close();}catch(Exception e){ 
		    	//e.printStackTrace(); 
		    	System.err.println("Stream Close Error!");}
		    if ( sc != null )     try{sc.close();}catch(Exception e){ 
		    	//e.printStackTrace(); 
		    	System.err.println("Stream Close Error!");}
		}
	    return fixedText7611;
	}

	
	
	/**
	 * 요청에 대한 응답데이터를 읽는다.(Stream)
	 * @param din
	 * @param iLen
	 * @return
	 * @throws IOException 
	 */
	public static byte[] getStream(DataInputStream din, int iLen) throws IOException {
		byte[] buf = new byte[iLen];
		int readCnt;
		int read_offset;
        try {
            readCnt = 1;
            read_offset = 0;
      
            while(readCnt>0) {
            	
            	readCnt = din.read(buf, read_offset, iLen-read_offset);
                read_offset+= readCnt;
            }   
            
        } catch (IOException e){
            throw e;
        }

		return buf;
	}
}