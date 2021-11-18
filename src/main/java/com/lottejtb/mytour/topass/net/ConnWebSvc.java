package com.lottejtb.mytour.topass.net;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.nio.channels.Channel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.logging.log4j.core.jackson.XmlConstants;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;


public class ConnWebSvc {
	
	private static Log logger = LogFactory.getLog(ConnWebSvc.class);
	
	// WebService를 통해 호텔 예약 신청을 하며 결과를 돌려 받는다.
	public static final int hotelRsvNRsltGet(String svcUrl, String paramName, String paramValue) {
		URLConnection urlConnection = null;
		HttpURLConnection httpConnection = null;
		URL url = null;
		OutputStream outputStream = null;
		OutputStreamWriter writer = null;
		StringBuffer buf = new StringBuffer();
		 
		try {
			String encodeParam = "";
				
			if (null != paramValue) { 
				encodeParam = URLEncoder.encode(paramValue, "UTF-8");
			}
			
			String svcFullURL = svcUrl;
			url = new URL(svcFullURL);
			
			urlConnection = url.openConnection();
			urlConnection.setDoOutput(true); //post방식:true
			urlConnection.setDoInput(true); //데이터가 첨부되는 경우
			urlConnection.setRequestProperty("Accept","*/*");
			urlConnection.setRequestProperty("Accept-Charset","euc-kr");
			urlConnection.setRequestProperty("User-Agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; i-NavFourF; .NET CLR 1.1.4322)");

			outputStream = urlConnection.getOutputStream();
			writer = new OutputStreamWriter(outputStream);
			
			String param = paramName + "=" + paramValue; 
			
			writer.write(param);
			writer.flush();
			
			httpConnection = (HttpURLConnection) urlConnection;
			int responseCode = httpConnection.getResponseCode(); // 결과코드
			System.out.println("[HP]1 : " + responseCode);
			return responseCode;
		} catch(Exception e) {
			//e.printStackTrace();
			System.err.println("Output Stream Error!");
		} finally {
			try {
				writer.close();
				outputStream.close();
			} catch (IOException e) {
				System.err.println("Stream Close Error!");
				//e.printStackTrace();
			}
		}
		
		return 0;
		
	}
	
	/**
	 * 파라메터가 없는 웹 서비스를 호출할 경우
	**/
	public static final Document getInfoNoneParamFromWebSvc(String svcUrl) {
		URLConnection urlConnection = null;
		HttpURLConnection httpConnection = null;
		URL url = null;
		BufferedReader br = null;
		StringBuffer buf = new StringBuffer();
		OutputStream outputStream = null;
		OutputStreamWriter writer = null;
		
		try {
			
			String svcFullURL = svcUrl;
			url = new URL(svcFullURL);
			
			urlConnection = url.openConnection();
			urlConnection.setDoOutput(true); //post방식:true
			urlConnection.setDoInput(true); //데이터가 첨부되는 경우
			urlConnection.setRequestProperty("Accept","*/*");
			urlConnection.setRequestProperty("Accept-Charset","euc-kr");
			urlConnection.setRequestProperty("User-Agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; i-NavFourF; .NET CLR 1.1.4322)");
			
			outputStream = urlConnection.getOutputStream();
			writer = new OutputStreamWriter(outputStream);
			
			writer.flush();
			
			
			httpConnection = (HttpURLConnection) urlConnection;
			int responseCode = httpConnection.getResponseCode(); // 결과코드
			System.out.println("[HP]2 : " + responseCode);
			
			// 서버로부터 응답을 정상적으로 받을시에만 처리
			if(responseCode == HttpURLConnection.HTTP_OK) {
				br = new BufferedReader(new InputStreamReader(httpConnection.getInputStream(), "UTF-8"));
				String temp = "";
				
				while ((temp = br.readLine()) != null) {
					if (temp.trim().length() > 0) {
						buf.append(temp);
					}
				}
			} else {
				System.out.println("Bad Request!!");
			}
			
			String result = buf.toString();
			
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document doc = db.newDocument();
			
			doc = db.parse(new InputSource(new StringReader(result)));
			
			return doc;
		} catch(Exception e) {
			//e.printStackTrace();
			System.err.println("Document Error!");
		} finally {
			try {
				writer.close();
				outputStream.close();
				br.close();
			} catch (IOException e) {
				//e.printStackTrace();
				System.err.println("Stream Close Error!");
			}
		}
		
		return null;
	}
	
	public static final Document getCityInfoFromWebSvc(String svcUrl, String reqParam) {
		URLConnection urlConnection = null;
		HttpURLConnection httpConnection = null;
		URL url = null;
		BufferedReader br = null;
		StringBuffer buf = new StringBuffer();
		OutputStream outputStream = null;
		OutputStreamWriter writer = null;
		
		try {
			String encodeParam = "";
				
			if (null != reqParam) {
				encodeParam = URLEncoder.encode(reqParam, "UTF-8");
			}
			
			String svcFullURL = svcUrl;
			url = new URL(svcFullURL);
			
			urlConnection = url.openConnection();
			urlConnection.setDoOutput(true); //post방식:true
			urlConnection.setDoInput(true); //데이터가 첨부되는 경우
		    //헤더 셋팅- 웹서버마다 헤더정보가 부족하면 405에러를 반환하기도 한다.
			urlConnection.setRequestProperty("Accept","*/*");
			urlConnection.setRequestProperty("Accept-Charset","euc-kr");
			urlConnection.setRequestProperty("User-Agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; i-NavFourF; .NET CLR 1.1.4322)");

			outputStream = urlConnection.getOutputStream();
			writer = new OutputStreamWriter(outputStream);
			String param = "city_name=" + reqParam; 
			
			writer.write(param);
			writer.flush();
			
			httpConnection = (HttpURLConnection) urlConnection;
			int responseCode = httpConnection.getResponseCode(); // 결과코드
			System.out.println("[HP] 3 : " + responseCode);
			
			// 서버로부터 응답을 정상적으로 받을시에만 처리
			if(responseCode == HttpURLConnection.HTTP_OK) {
				br = new BufferedReader(new InputStreamReader(httpConnection.getInputStream(), "UTF-8"));
				String temp = "";
				
				while ((temp = br.readLine()) != null) {
					if (temp.trim().length() > 0) {
						buf.append(temp);
					}
				}
			} else {
				System.out.println("Bad Request!!");
			}
			
			String result = buf.toString();
			
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document doc = db.newDocument();
			
			doc = db.parse(new InputSource(new StringReader(result)));
			
			return doc;
		} catch(Exception e) {
			//e.printStackTrace();
			System.err.println("Request & Buffer Error!");
		} finally {
			try {
				writer.close();
				outputStream.close();
				br.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
				System.err.println("Stream close Error!");
			}
		}
		
		return null;
		
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
			int xmlEndIndex = result.indexOf("</string>");
			
//			System.out.println(result);
		
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("String Replcae Error!");
		} finally {
			try {
				br.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
				System.err.println("Stream Close Error!");
			}
		}
		
		return null;
		
		
	}
	

	public static Document createUserInfo(String svcUrl, ArrayList<Map> params) {
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
			
			// Web Service Call
			url = new URL(svcFullURL);
			
			urlConnection = url.openConnection();
			
			urlConnection.setReadTimeout(0); // read Tiem out 3초
			httpConnection = (HttpURLConnection) urlConnection;
			int responseCode = httpConnection.getResponseCode(); // 결과코드
			System.out.println(responseCode);
			
			// 서버로부터 응답을 정상적으로 받을시에만 처리
			if(responseCode == HttpURLConnection.HTTP_OK) {
				br = new BufferedReader(new InputStreamReader(httpConnection.getInputStream(), "UTF-8"));
//				br = new BufferedReader(new InputStreamReader(httpConnection.getInputStream(), "UTF-8"));
				String temp = "";
				
				while ((temp = br.readLine()) != null) {
					if (temp.trim().length() > 0) {
						buf.append(temp);
					}
				}
				
			} else {
				System.out.println("Bad Request!!");
				
			}
			
			Document doc = null;
			
			return doc;
		
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Buffered Reader Error!");
			
		} finally {
			try {
				br.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
				System.err.println("Stream Close Error!");
			}
		}
		
		return null;
		
		
	}
	
	/**
	 * Topas의 항공관련 Web service를 호출한다.
	 * 응답 대기방지를 위해 응답을 주지 않을 경우 종료
	 * @param svcUrl
	 * @param params
	 * @return  
	 */
	public static Document getSpclPriceForMainPage(String svcUrl, ArrayList<Map> params) {
		
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
			
			
			// Web Service Call
			url = new URL(svcFullURL);
			
			urlConnection = url.openConnection();
			urlConnection.setConnectTimeout(3000); // connection Time out 3초
			urlConnection.setReadTimeout(3000); // read Tiem out 3초
			httpConnection = (HttpURLConnection) urlConnection;
			int responseCode = httpConnection.getResponseCode(); // 결과코드
			System.out.println("[HP] 9 : " + responseCode);
			
			// 서버로부터 응답을 정상적으로 받을시에만 처리
			if(responseCode == HttpURLConnection.HTTP_OK) {
				br = new BufferedReader(new InputStreamReader(httpConnection.getInputStream(), "UTF-8"));
				String temp = "";
				
				while ((temp = br.readLine()) != null) {
					if (temp.trim().length() > 0) {
						buf.append(temp);
					}
				}
				
			} else {
				System.out.println("Bad Request!!");
			}
			
			// Dom Object 변환을 위해 tag 원형으로 변환
			String result = buf.toString();
			result = result.replaceAll("&lt;", "<");
			result = result.replaceAll("&gt;", ">");
			
			// String 안에 포함된 실제 Root Element의 시작 위치
			int xmlStartIndex = result.indexOf("<?xml", 1);
			// String 안에 포함된 실제 Root Element의 종료 위치
			int xmlEndIndex = result.indexOf("</string>");
			
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document doc = db.newDocument();
			 
			doc = db.parse(new InputSource(new StringReader(result)));
			
			return doc;
		
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Connection OR Document Error!");
		} finally {
			try {
				br.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
				System.err.println("Stream Close Error!");
			}
		}
		
		return null;
		
	}
	
	/**
	 * 추천호텔 및 Best호텔 조회를 위한 Parameter를 구성한다.
	 * @param prtCnt 한번에 출력하고자 하는 호텔의 개수
	 * @param srchCode 조회하고자 하는 검색 Keyword (국가코드 + 도시코드)
	 * @return
	 */
	public static String makeParamForSrchHotelPerCity(String srchCode, int prtCnt) {
		StringBuffer sb = new StringBuffer();
		sb.append("<?xml version='1.0' encoding='UTF-8'?><RecommandHotelRequest xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' ");
		sb.append("xsi:noNamespaceSchemaLocation='http://xml.hotelpass.com/HTPWS_V01/SCHEMA/Request/RecommHotel_Request.xsd'>");		
		sb.append("<UserInfo><CompanyCode>2-04726</CompanyCode><UserID>xmlint-htpws</UserID><UserPWD>xmlint-pw057</UserPWD></UserInfo>");		
		sb.append("<RequestInfo RowNumber='");
		sb.append(prtCnt);
		sb.append("'><CityCode>");
		sb.append(srchCode);
		sb.append("</CityCode></RequestInfo></RecommandHotelRequest>");		
		return sb.toString();
	}
	

	
	/**
	 * 파라메터를 받아 웹서비스를 호출하여 결과를 return
	 */
	public static Document getInfoWithParamFromWebSvc(String svcUrl, ArrayList<Map> params) {
		
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
			
			System.out.println(paramStr);
			System.out.println("[HP]11 : " + svcFullURL);
			 
			// Web Service Call
			url = new URL(svcFullURL);
			
			urlConnection = url.openConnection();
			httpConnection = (HttpURLConnection) urlConnection;
			int responseCode = httpConnection.getResponseCode(); // 결과코드
			System.out.println(responseCode);
			
			// 서버로부터 응답을 정상적으로 받을시에만 처리
			if(responseCode == HttpURLConnection.HTTP_OK) {
				br = new BufferedReader(new InputStreamReader(httpConnection.getInputStream(), "UTF-8"));
//				br = new BufferedReader(new InputStreamReader(httpConnection.getInputStream(), "UTF-8"));
				String temp = "";
				
				while ((temp = br.readLine()) != null) {
					if (temp.trim().length() > 0) {
						buf.append(temp);
					}
				}
				
			} else {
				logger.debug("Bad Request!!");
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
			
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document doc = db.newDocument();
			
			logger.debug("변환전: " + result);
			System.out.println(result);
			 
			doc = db.parse(new InputSource(new StringReader(result.substring(xmlStartIndex, xmlEndIndex))));
			
			
			
			return doc;
		
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Buffered Reader Error!");
		} finally {
			try {
				br.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
				System.err.println("Stream Close Error!");
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
			System.err.println("Database PrepareStatement Error!");
		} finally {
	        if( pstmt != null ) try { pstmt.close(); pstmt = null; }  catch(Exception e) {}
	        if( conn != null ) try { conn.close(); conn = null; } catch(Exception e) {}
	        if( resultSet != null ) try { resultSet.close(); resultSet = null; } catch(Exception e) {}
	    }
		
		return etcResCd;
		
	}



	
}