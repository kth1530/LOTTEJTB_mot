/*/
 * WebService에 UrlConnection으로 접근하여 결과를 Document Object로 반환한다.
 */
package com.lottejtb.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ConnWebSvc {
	
	private static Log logger = LogFactory.getLog(ConnWebSvc.class);
	
	private ConnWebSvc(){
	}
	
	/**
	 * JTB의 예약코드를 이용하여 타사 예약코드를 조회한다.
	 * @param resCd : JTB 예약코드
	 * @return etcResCd : 타사 예약코드
	 */
	public static String getEtcResCd(String resCd) {
		
		String etcResCd = null;
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet resultSet = null;
		String custCd = null;
		StringBuilder query = new StringBuilder();
		StringBuilder insertQuery = new StringBuilder();
		
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource) context.lookup("java:T2_OPR");
			
			conn = ds.getConnection();

			query = new StringBuilder();
			query.append("\n SELECT ETC_RES_CD  ");
			query.append("\n    FROM RV_MST ");
			query.append("\n  WHERE RES_CD = ?");
	
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, resCd);
	
			resultSet = pstmt.executeQuery();
	
			while (resultSet.next()) {
				etcResCd = resultSet.getString("ETC_RES_CD");
			}
			
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("SQL Prepare Statement Error!");
		} finally {
	        if( pstmt != null ) try { pstmt.close(); pstmt = null; }  catch(Exception e) { 
	        	//e.printStackTrace();
	        	System.err.println("SQL Prepare Statement Clsoe Error!");
	        }
	        if( conn != null ) try { conn.close(); conn = null; } catch(Exception e) { 
	        	//e.printStackTrace();
	        	System.err.println("SQL Connection Clsoe Error!");
	        }
	        if( resultSet != null ) try { resultSet.close(); resultSet = null; } catch(Exception e) { 
	        	//e.printStackTrace();
	        	System.err.println("SQL Result Set Clsoe Error!");
	        }
	    }
		
		return etcResCd;
		
	}

	/**
	 * 결제 완료 여부를 알리는 EAI를 호출하기 위한 Parameter를 구성한다.
	 * @param companyCode 회사코드
	 * @param resCd 호텔패스의 예약코드
	 * @return
	 */
	public static String getParamForNfyPaySuccess(String companyCode, String resCd) {
		StringBuilder sb = new StringBuilder();
		
		sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>");
		sb.append("<PaymentRequest xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" ");
		sb.append("xsi:noNamespaceSchemaLocation=\"http://xml.hotelpass.com/HTPWS_Inter/SCHEMA/Response/PaymentSet_Request.xsd\">");
		sb.append("<UserInfo>");
		sb.append("<CompanyCode>");
		sb.append(companyCode);
		sb.append("</CompanyCode>");
		sb.append("<UserID>xmlint-htpws</UserID>");
		sb.append("<UserPWD>xmlint-pw057</UserPWD>");
		sb.append("</UserInfo>");
		sb.append("<RequestInfo><BKNo>");
		sb.append(resCd);
		sb.append("</BKNo>");
		sb.append("<PaymentOK>Y</PaymentOK>");
		sb.append("</RequestInfo>");
		sb.append("</PaymentRequest>");
		
		return sb.toString();
		
	}

	/**
	 * 기존 webSvc와 동일하며 timeout을 설정한다.
	 * @param svcUrl
	 * @param params
	 * @param encodeSet
	 * @param timeout
	 * @return
	 */
	public static String getStrWithParamFromWebSvc(String svcUrl, ArrayList<Map> params, String encodeSet, int timeout) {
		String paramStr;
		
		if (null != params) { // 정보를 전달 받았을 경우만 파라메터 구성
			paramStr =createParam(params); // 구성된 파라메터 정보 
		} else {
			paramStr = "";
		}
		
		URLConnection urlConnection = null;
		HttpURLConnection httpConnection = null;
		URL url = null;
		BufferedReader br = null;
		StringBuffer buf = new StringBuffer();  
		
		try {
		
			// Parameter UTF-8 Encoding
			String encodeParam = URLEncoder.encode(paramStr, "UTF-8");
			String svcFullURL;
			
			if (null == params) {
				svcFullURL = svcUrl;
			} else {
				svcFullURL = svcUrl + "?" + paramStr;
			}
			
			System.out.println("[HP] 7 :" + svcFullURL);
			
			// Web Service Call
			url = new URL(svcFullURL);
			
			urlConnection = url.openConnection();
			urlConnection.setConnectTimeout(timeout); // connection time 3초
			urlConnection.setReadTimeout(timeout); // read Tiem out 3초
			httpConnection = (HttpURLConnection) urlConnection;
			int responseCode = httpConnection.getResponseCode(); // 결과코드
			System.out.println(responseCode);
			System.out.println("[HP]3");
			
			// 서버로부터 응답을 정상적으로 받을시에만 처리
			if(responseCode == HttpURLConnection.HTTP_OK) {
				br = new BufferedReader(new InputStreamReader(httpConnection.getInputStream(), encodeSet));
				String temp = "";
				
				while ((temp = br.readLine()) != null) {
					if (temp.trim().length() > 0) {
						buf.append(temp);
					}
				}
				
			} else {
				System.out.println("Bad Request!!");
				return null;
			}
			
			// Dom Object 변환을 위해 tag 원형으로 변환
			String result = buf.toString();
			result = result.replaceAll("&lt;", "<");
			result = result.replaceAll("&gt;", ">");
			
			// String 안에 포함된 실제 Root Element의 시작 위치
			int xmlStartIndex = result.indexOf("<?xml", 1);
			// String 안에 포함된 실제 Root Element의 종료 위치
			int xmlEndIndex = result.indexOf("</string>");
			
//			System.out.println(result);
		
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("httpConnect OR BufferReader Error!");
		} finally {
			try {
				br.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
				System.err.println("Buffer Reader Error!");
			}
		}
		
		return null;
		
		
	}
	
	/**
	 * 전달받은 arraylist를 parsing하여 query String을 생성한다.
	 * @param params
	 * @return
	 */
	public static String createParam(ArrayList<Map> params) {
		/*
		 * 파라메터 정보를 구성
		 */
		Map inMap = null;
		Iterator<String> it = null;
		Set<String> set = null;
		String key;
		String value;
		
		String makeParamStr;
		
		StringBuffer sb = new StringBuffer();
		
		for (int i = 0; i < params.size(); i++) {
			inMap = params.get(i);
			set = inMap.keySet();
			it = set.iterator();
			
			while(it.hasNext()) {
				key = it.next(); // map의 key값
				value = (String) inMap.get(key); // key에 해당하는 value를 get
				
				sb.append(key);
				sb.append("=");
				sb.append(value);
				sb.append("&");
			}
			
		}
		
		makeParamStr = sb.toString();
		
		// 생성된 결과가 존재할 경우만 처리
		if (makeParamStr.length() != 0 && makeParamStr != null) {
			// 마지막 &를 제거
			makeParamStr = makeParamStr.substring(0, makeParamStr.length() - 1); 
		}
		
//		System.out.println(makeParamStr);
		return makeParamStr;
	}

	
}
