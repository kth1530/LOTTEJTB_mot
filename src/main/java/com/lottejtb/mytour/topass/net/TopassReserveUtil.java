package com.lottejtb.mytour.topass.net;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.event.ActionEvent;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.lottejtb.comm.util.CommInfo;

public class TopassReserveUtil {
	private static Log log = LogFactory.getLog(TopassReserveUtil.class);
	private ArrayList<Map> reserveAirList = new ArrayList<Map>();
	private ArrayList<Map> reserveAirCancelList = new ArrayList<Map>();
	private ArrayList<Map> testb = new ArrayList<Map>();


	// /////////////////////
	private ArrayList<Map> chan = new ArrayList<Map>();

	private String a;
	private String b;
	private String resCd;
	private Map selectedRow;
	private Map payment;
	private String inputReceiptFg;
	private String inputHp1;
	private String inputHp2;
	private String receiptNo;
	private String inputReceiptCd;
	private String username = "";
	private String RES_CD = "";
	private String CUST_CD = "";
	private String EVENT_NM = "";
	// double point;
	private double price;
	private double inputAmount = 0;
	// LoginBean loginBean;
	HttpServletResponse response;

	// reserveGoods 관련
	private String RES_DAY = "";
	private String ETC_RES_CD = "";
	private String GOODS_TYPE_CD = "";
	private String RES_CHK_CD = "";
	private String COMP_CD = "";
	private String START_DAY = "";
	private String START_TIME = "";
	private String END_TIME = "";
	private String END_TIME_FR = "";
	private String START_TIME_TO = "";
	private String OKWT = "";
	private String CHA_ID = "";
	private String CHA_NM = "";

	private String CHA_DEPT_CD = "";
	private String EVENT_CD = "";
	private String START_PYUN = "";
	private String CANC_CD = "";
	private String START_DAY_TO = "";
	private String START_WDAY = "";
	private String END_DAY_FR = "";
	private String END_PYUN = "";
	private String END_WDAY = "";
	private String DISP_NM = "";
	private String STATUS_NM = "";
	private String STATUS_CD = "";
	private String CITY_CD = "";
	private String ETC_GOODS_ID = "";
	private String GOODS_CD = "";
	private String OP_CD = "";
	private String HT_CITY_CD = "";
	private String SITE_NM = "";
	private int RES_CNT = 0;
	private int CANC_CNT = 0;
	private int EVENT_AMT = 0;
	private int ADD_AMT = 0;
	private int DC_AMT = 0;
	private int TOT_SALE_AMT = 0;
	private int TOT_IN_AMT = 0;
	private int MISU_AMT = 0;
	private int EV_DAY_CNT = 0;
	private int FEE = 0;
	private int EV_NIGHT_CNT = 0;
	private int ADULT_COUNT = 0;
	private int CHILD_COUNT = 0;
	private int INFANT_COUNT = 0;
	private int SALE_AMT = 0;
	private int SITE_COMM = 0;
	private String START_DAY01 = "";
	private String START_DAY02 = "";
	private String START_DAY03 = "";
	private String END_DAY01 = "";
	private String END_DAY02 = "";
	private String END_DAY03 = "";
	private String START_TIME01 = "";
	private String START_TIME02 = "";
	private String END_TIME01 = "";
	private String END_TIME02 = "";
	private String END_TIME_FR01 = "";
	private String END_TIME_FR02 = "";
	private String START_TIME_TO01 = "";
	private String START_TIME_TO02 = "";
	private String HANDPHONE = "";
	private String REMARK = "";
	private String END_DAY = "";
	private String ssNo = "";
	private String currGoodsCd = "";
	private String currCompCd = "";

	private String plus3Date = "";
	private String plus6Date = "";


	private int night = 0;

	private static final String PFM_GET_HP_RSV_INFO = "T2-PW/PWrvMngSO/getHpReserveInfo";

	// Map m = new HashMap<String, Object>();

	// 예약 상테 Update를 위한 Eai의 url
	private static final String EAI_RV_STAT_UPD_URL = "http://10.141.1.28:9080/http/hp05";
	
	// 예약 상태 명 
    public static HashMap<String, String> statusDescMap = new HashMap<String, String>() {
		private static final long serialVersionUID = 1L;
		{
	        put( "", "" );			// 
	        put( "RW", "예약대기" );	// 예약대기
	        put( "RC", "예약완료" );	// 예약완료
	        put( "RN", "예약불가" );	// 예약불가
	        put( "CC", "취소완료" );	// 취소완료
		}
	};
	
    public static HashMap<String, String> goodsTypeNmMap = new HashMap<String, String>() {
		private static final long serialVersionUID = 1L;
		{
	        put( "", "" );			// 
	        put( "T", "여행" );	// 여행
	        put( "D", "국내" );	// 국내
	        put( "O", "해외" );	// 해외
	        put( "A", "항공" );	// 항공
		}
	};	
	
	private int reserveGoodsCount = 0;	// 예약
	private int cancelGoodsCount = 0;	// 취소
	private int reserveAirGoodsCount = 0;	// 예약
	private int cancelAirGoodsCount = 0;	// 취소
	private String GOODS_TYPE = "";		// 검색 조건

	private int memberCount = 0;
	private int paymentCount = 0;



	public int getNight() {
		return night;
	}

	public void setNight(int night) {
		this.night = night;
	}


	/**
	 * 주민번호
	 * 
	 * @return
	 */
	public String getSsNo() {
		return ssNo;
	}

	public void setSsNo(String ssNo) {
		this.ssNo = ssNo;
	}

	/**
	 * 진행상태 블릿이미지 패스설정 (여행상품) stat = STATUS_CD
	 */
	private String setBulletImg(String stat, String cancCd) {
		String ImgPath = "";
		try {
			if ("01".equals(stat) || "H1".equals(stat) || "H0".equals(stat)) {
				ImgPath = "/images/common/bullet/icon_mytour_1.gif"; // 예약대기
			} else if ("99".equals(stat) || "HH".equals(stat)) {
				ImgPath = "/images/common/bullet/icon_mytour_4.gif"; // 취소완료
			} else if ("10".equals(stat) || "H2".equals(stat) || "H3".equals(stat) || 
					   "H4".equals(stat) || "H5".equals(stat) || "HI".equals(stat)) {
				ImgPath = "/images/common/bullet/icon_mytour_10.gif"; // 예약완료
			} else if ("HN".equals(stat)) {
				ImgPath = "/images/common/bullet/icon_mytour_11.gif"; // 예약불가
			}
			// 위에서 STATUS_CD로 상태를 결정한다 하더라도 CANC_CD의 유무로 다시한번 확인한다.
			// CANC_CD가 존재할 경우 무조건 취소완료 상태라고 할 수 있다.
			if (null != cancCd && !"".equals(cancCd)) {
				ImgPath = "/images/common/bullet/icon_mytour_4.gif"; // 취소완료
			}
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return ImgPath;
	}

	
	/**
	 * 진행상태 블릿이미지 패스설정 (여행상품) stat = STATUS_CD
	 */
	private String getStatusCd(String stat, String cancCd) {
		String statusDesc = "";
		try {
			if ("01".equals(stat) || "H1".equals(stat) || "H0".equals(stat)) {
				statusDesc = "RW";			// 예약대기 : reservation waiting -- "/images/common/bullet/icon_mytour_1.gif"; // 예약대기
			} else if ("99".equals(stat) || "HH".equals(stat)) {
				statusDesc = "CC";			// 취소완료 : cancel complete -- "/images/common/bullet/icon_mytour_4.gif"; // 취소완료
			} else if ("10".equals(stat) || "H2".equals(stat) || "H3".equals(stat) || 
					   "H4".equals(stat) || "H5".equals(stat) || "HI".equals(stat)) {
				statusDesc = "RC";			// 예약완료 : reservation complete 	--"/images/common/bullet/icon_mytour_10.gif"; // 예약완료
			} else if ("HN".equals(stat)) {
				statusDesc = "RN";			// 예약불가 : reservation wrong -- "/images/common/bullet/icon_mytour_11.gif"; // 예약불가
			}
			// 위에서 STATUS_CD로 상태를 결정한다 하더라도 CANC_CD의 유무로 다시한번 확인한다.
			// CANC_CD가 존재할 경우 무조건 취소완료 상태라고 할 수 있다.
			if (null != cancCd && !"".equals(cancCd)) {
				statusDesc = "CC";		// 취소완료 :  cancel complete  -- "/images/common/bullet/icon_mytour_4.gif"; // 취소완료
			}
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return statusDesc;
	}

	private String getStatusCd__(String stat, String cancCd) {
		String statusDesc = "";
		
		try {
			if ("01".equals(stat) || "H1".equals(stat) || "H0".equals(stat)) {
				statusDesc = "RW";			// 예약대기 : reservation waiting
			} else if ("99".equals(stat) || "HH".equals(stat)) {
				statusDesc = "CC";			// 취소완료 : cancel complete 
			} else if ("10".equals(stat) || "H2".equals(stat) || "H3".equals(stat) || 
					   "H4".equals(stat) || "H5".equals(stat) || "HI".equals(stat)) {
				statusDesc = "RC";			// 예약완료 : reservation complete 
			} else if ("HN".equals(stat)) {
				statusDesc = "RN";			// 예약불가 : reservation wrong
			}
			// 위에서 STATUS_CD로 상태를 결정한다 하더라도 CANC_CD의 유무로 다시한번 확인한다.
			// CANC_CD가 존재할 경우 무조건 취소완료 상태라고 할 수 있다.
			if (null != cancCd && !"".equals(cancCd)) {
				statusDesc = "CC";		// 취소완료 :  cancel complete 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return statusDesc;
	}
	
	/**
	 * 결제버튼 이미지 SHOW 설정 * stat = STATUS_CD
	 */
	private boolean setApplyImg(String stat) {
		boolean showYn = false;
		try {
			if ("10".equals(stat) || "11".equals(stat) ||
				"H0".equals(stat) || "H1".equals(stat) || "H2".equals(stat) || "H3".equals(stat) || "H4".equals(stat)) {
				showYn = true; // 예약대기,예약완료
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return showYn;
	}

	/**
	 * 항공예약 정보를 Web service로 받아온다. 필요로 하는 Parameter는 암호화 되어있는 cust_id,
	 * username이다.http://air.lottejtb.com/air/agent/b2c/AIR/AAA/AIRAAAMYL010000001001.k1xml
	 */
	public void setAirReservInfo(HttpServletRequest request) {
		
		
		ArrayList<Map> params = new ArrayList<Map>();
		Map<String, Object> custIdMap = new HashMap<String, Object>();
		Map<String, Object> userNameMap = new HashMap<String, Object>();
		Map<String, Object> userFlagMap = new HashMap<String, Object>();

		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> setAirReservInfo >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		try {
			HttpSession session = request.getSession(true);
			HashMap<String, Object> sessionParam = (HashMap<String, Object>)session.getAttribute(CommInfo.SESSION_ATTR_NAME);
			
			String custCd = null;
			String knm = null;
			String age = null;
			String sex = null;
			String id = null;
			String email = null;
			String custGradeCd = null;
			String birthday = null;
			
			if(sessionParam != null){
				if(sessionParam.get("cust_cd") != null)
					custCd = sessionParam.get("cust_cd").toString();
				if(sessionParam.get("knm") != null)
					knm = sessionParam.get("knm").toString();
				if(sessionParam.get("email") != null)
					email = sessionParam.get("email").toString();
			}
			
			
			// 암호화된 값을 그대로 전송하기 위해 쿠키에서 직접 읽음
			// custIdMap.put("userId", URLEncoder.encode(custCd, "UTF-8")); // custid
			
			//cookie에서 cust id값을 로드
			javax.servlet.http.Cookie[] cookie =  request.getCookies();
			String custid = "";
			
			if(cookie != null && cookie.length > 0) {
				for(int i = 0; i < cookie.length; i++) {
					String cookieData = cookie[i].getValue();
					
					System.out.println("#######"  + cookie[i].getName() + "=" + cookie[i].getValue());
					if(cookie[i].getName().equals("cust_id")) {
						custid = cookieData;
					}
				}
			}
			System.out.println("======= START userId=" +  custid);
			custIdMap.put("userId", URLEncoder.encode(custid, "UTF-8")); // custid
			//custIdMap.put("userId", "P8FZH/emiJ+GSzNuZcnHhQ%3D%3D"); // custid
			userNameMap.put("userName", URLEncoder.encode(knm, "UTF-8"));
			userFlagMap.put("userFlag", "MB");
			
			//custIdMap.put("userId", "sbsgvVY2emoa8SwHV0QrSQ%3D%3D");
			//System.out.println("======= END userId=" +  URLEncoder.encode(custid, "UTF-8"));
			
			params.add(custIdMap);
			params.add(userNameMap);
			params.add(userFlagMap);
			
			// 개인 항공 예약정보를 반환하는 Topas의 Web service를 호출한다.
			Document document = ConnWebSvc.getSpclPriceForMainPage(
//					"http://air.lottejtb.com/air/agent/b2c/AIR/AAA/AIRAAAMYL010000001001.k1xmll", params);
			"http://10.141.1.55:12110/air/agent/b2c/AIR/AAA/AIRAAAMYL010000001001.k1xml", params);
			Element root = document.getDocumentElement();

			Map<String, Object> inMap;
			reserveAirList = new ArrayList<Map>();

			// return 받은 xml data를 parsing
			System.out.println("000-000000000000"+root.getElementsByTagName("data").getLength());
			for (int i = 0; i < root.getElementsByTagName("data").getLength(); i++) {
				inMap = new HashMap<String, Object>();

				inMap.put("PNR_SEQ_NO", root.getElementsByTagName("PNR_SEQ_NO")
						.item(i).getTextContent()); // 번호
				inMap.put("FORMAT_RESV_DATE", root.getElementsByTagName(
						"FORMAT_RESV_DATE").item(i).getTextContent()); // 예약일
				inMap.put("FORMAT_DEP_DATE", root.getElementsByTagName(
						"FORMAT_DEP_DATE").item(i).getTextContent()); // 출발일
				inMap.put("TOTAL_ITIN", root.getElementsByTagName("TOTAL_ITIN")
						.item(i).getTextContent()); // 상품명
				inMap.put("FORMAT_TOTAL_FARE", root.getElementsByTagName(
						"FORMAT_TOTAL_FARE").item(i).getTextContent()); // 총 결제금액
				inMap.put("AIR_RINK_URL", root.getElementsByTagName("PNR_SEQ_NO").item(i).getTextContent()); // 

				inMap.put("pnrSeqNo", root.getElementsByTagName("PNR_SEQ_NO")
						.item(i).getTextContent()); // 지역코드

				inMap.put("RM_PNR_NO", root.getElementsByTagName("RM_PNR_NO")
						.item(i).getTextContent()); // 예약번호
				
				
				String status = root.getElementsByTagName("RM_LAST_STATUS")
						.item(i).getTextContent();
				String imgUrl = "";

				// 상태에 따른 이미지 종류 setting
				/*if ("RMQQ".equals(status)) { // 예약대기
					imgUrl = "/images/common/bullet/icon_mytour_1.gif";
				} else if ("RMPQ".equals(status)) { // 예약확정
					imgUrl = "/images/common/bullet/icon_mytour_9.gif";
				} else if ("RMTQ".equals(status)) { // 발권완료
					imgUrl = "/images/common/bullet/icon_mytour_8.gif";
				} else if ("RMTK".equals(status)) { // 발권진행
					imgUrl = "/images/common/bullet/icon_mytour_3.gif";
				} else if ("RMXX".equals(status)) { // 예약취소
					imgUrl = "/images/common/bullet/icon_mytour_4.gif";

				}*/

				inMap.put("RM_LAST_STATUS", status); // 예약상태

				if (! "RMXX".equals(status)) {
					reserveAirList.add(inMap);
				}else{
					reserveAirCancelList.add(inMap);
				}
				
			}
			System.out.println("2oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			System.out.println("errorerrorerrorerrorerrorerrorerrorerrorerrorerrorerrorerrorerrorerrorerrorerror");
		}

		setReserveAirGoodsCount( reserveAirList.size() );	// 예약
		setCancelAirGoodsCount( reserveAirCancelList.size() ); 		// 취소
	}


	/**
	 * 항공예약 정보를 Web service로 받아온다. 필요로 하는 Parameter는 암호화 되어있는 r_name, r_email 
	 * rsvno 이다. http://air.lottejtb.com/air/agent/b2c/AIR/AAA/AIRAAAMYL010000001003.k1xml
	 */
	public void setAirReservInfoNonMember(String r_name, String r_phoneno, String rsvno) {
		
		
		ArrayList<Map> params = new ArrayList<Map>();
		Map<String, Object> siteCodeMap = new HashMap<String, Object>();
		Map<String, Object> sitememMap = new HashMap<String, Object>();
		Map<String, Object> useridMap = new HashMap<String, Object>();
		Map<String, Object> userNameMap = new HashMap<String, Object>();
		Map<String, Object> emailMap = new HashMap<String, Object>();
		Map<String, Object> r_phonenoMap = new HashMap<String, Object>();
		Map<String, Object> rsvnoMap = new HashMap<String, Object>();
		Map<String, Object> ksesidMap = new HashMap<String, Object>();
		
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> setAirReservInfoNonMember >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		System.out.println("r_phoneno---------------->"+r_phoneno);
		try {

			
			// 암호화된 값을 그대로 전송하기 위해 쿠키에서 직접 읽음
			siteCodeMap.put("r_sitecode", "SELK138AX"); // custid
			useridMap.put("r_userid", "lotteguest");
			sitememMap.put("r_sitemem", "N");
			
			userNameMap.put("r_name", URLEncoder.encode(r_name, "UTF-8"));
			//r_phonenoMap.put("r_phoneno", URLEncoder.encode(r_phoneno, "UTF-8"));
			r_phonenoMap.put("r_phoneno",r_phoneno);
			rsvnoMap.put("rsvno", rsvno);
			ksesidMap.put("KSESID", "air:b2c:SELK138AX:SELK138AX::00");
			
			
			params.add(siteCodeMap);
			params.add(useridMap);
			params.add(sitememMap);
			params.add(userNameMap);
			params.add(r_phonenoMap);
			params.add(rsvnoMap);
			params.add(ksesidMap);
			
			// 개인 항공 예약정보를 반환하는 Topas의 Web service를 호출한다.
			Document document = ConnWebSvc.getSpclPriceForMainPage(
					"http://air.lottejtb.com/air/agent/b2c/AIR/AAA/AIRAAAMYL010000001001.k1xml", params);
//			"http://air.lottejtb.com/air/agent/b2c/AIR/AAA/AIRAAAMYL010000001003.k1xml", params);
//			"http://10.141.1.55:12110/air/agent/b2c/AIR/AAA/AIRAAAMYL010000001003.k1xml", params);
			Element root = document.getDocumentElement();

			Map<String, Object> inMap;
			reserveAirList = new ArrayList<Map>();

			// return 받은 xml data를 parsing
			System.out.println("000-000000000000"+root.getElementsByTagName("data").getLength());
			for (int i = 0; i < root.getElementsByTagName("data").getLength(); i++) {
				inMap = new HashMap<String, Object>();

				inMap.put("PNR_SEQ_NO", root.getElementsByTagName("PNR_SEQ_NO")
						.item(i).getTextContent()); // 번호
				inMap.put("FORMAT_RESV_DATE", root.getElementsByTagName(
						"FORMAT_RESV_DATE").item(i).getTextContent()); // 예약일
				inMap.put("FORMAT_DEP_DATE", root.getElementsByTagName(
						"FORMAT_DEP_DATE").item(i).getTextContent()); // 출발일
				inMap.put("TOTAL_ITIN", root.getElementsByTagName("TOTAL_ITIN")
						.item(i).getTextContent()); // 상품명
				inMap.put("FORMAT_TOTAL_FARE", root.getElementsByTagName(
						"FORMAT_TOTAL_FARE").item(i).getTextContent()); // 총 결제금액
				inMap.put("AIR_RINK_URL", root.getElementsByTagName("PNR_SEQ_NO").item(i).getTextContent()); // 

				inMap.put("pnrSeqNo", root.getElementsByTagName("PNR_SEQ_NO")
						.item(i).getTextContent()); // 지역코드

				inMap.put("RM_PNR_NO", root.getElementsByTagName("RM_PNR_NO")
						.item(i).getTextContent()); // 예약번호
				
				
				String status = root.getElementsByTagName("RM_LAST_STATUS")
						.item(i).getTextContent();
				String imgUrl = "";

				// 상태에 따른 이미지 종류 setting
				/*if ("RMQQ".equals(status)) { // 예약대기
					imgUrl = "/images/common/bullet/icon_mytour_1.gif";
				} else if ("RMPQ".equals(status)) { // 예약확정
					imgUrl = "/images/common/bullet/icon_mytour_9.gif";
				} else if ("RMTQ".equals(status)) { // 발권완료
					imgUrl = "/images/common/bullet/icon_mytour_8.gif";
				} else if ("RMTK".equals(status)) { // 발권진행
					imgUrl = "/images/common/bullet/icon_mytour_3.gif";
				} else if ("RMXX".equals(status)) { // 예약취소
					imgUrl = "/images/common/bullet/icon_mytour_4.gif";

				}*/

				inMap.put("RM_LAST_STATUS", status); // 예약상태

				if (! "RMXX".equals(status)) {
					reserveAirList.add(inMap);
				}else{
					reserveAirCancelList.add(inMap);
				}
				
			}
			System.out.println("2oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("errorerrorerrorerrorerrorerrorerrorerrorerrorerrorerrorerrorerrorerrorerrorerror");
		}

		setReserveAirGoodsCount( reserveAirList.size() );	// 예약
		setCancelAirGoodsCount( reserveAirCancelList.size() ); 		// 취소
	}


	
	/**
	 * 오늘 날짜 받아오기 , 아라비아숫자 8자리
	 */
	private String getTodayDate() {
		String todayDt = "";
		try {
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
			todayDt = simple.format(cal.getTime());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return todayDt;
	}

	
	/**
	 * 오늘 날짜에 임의값 더하기 , 아라비아숫자 8자리
	 */
	private String getPlusDate(int plusDay) {
		String todayDt = "";
		try {
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd",Locale.KOREA);
			cal.add(Calendar.DATE, plusDay);
			todayDt = simple.format(cal.getTime());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return todayDt;
	}


	// //////////////////////////////////////////////////////////////////////////////////////////////////////
	// //////////////////////////////////////////////////////////////////////////////////////////////////////
	public String getPlus3Date() {
		plus3Date = getPlusDate(3);
		return plus3Date;
	}

	public void setPlus3Date(String plus3Date) {
		this.plus3Date = plus3Date;
	}

	public String getPlus6Date() {
		plus6Date = getPlusDate(6);
		return plus6Date;
	}

	public void setPlus6Date(String plus6Date) {
		this.plus6Date = plus6Date;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getEVENT_NM() {
		return EVENT_NM;
	}

	public void setEVENT_NM(String EVENT_NM) {
		EVENT_NM = EVENT_NM;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public ArrayList<Map> getReserveAirList() {
		return reserveAirList;
	}

	public void setReserveAirList(ArrayList<Map> reserveAirList) {
		this.reserveAirList = reserveAirList;
	}
	
	public ArrayList<Map> getReserveAirCancelList() {
		return reserveAirCancelList;
	}

	public void setReserveAirCancelList(ArrayList<Map> reserveAirList) {
		this.reserveAirCancelList = reserveAirCancelList;
	}


	public String getRES_CD() {
		return RES_CD;
	}

	public void setRES_CD(String res_cd) {
		RES_CD = res_cd;
	}

	public double getinputAmount() {
		return inputAmount;
	}

	public void setinputAmount(double inputAmount) {
		this.inputAmount = inputAmount;
	}


	public void setTestb(ArrayList<Map> testb) {
		this.testb = testb;
	}

	public String getA() {
		return a;
	}

	public void setA(String a) {
		this.a = a;
	}

	public String getB() {
		return b;
	}

	public void setB(String b) {
		this.b = b;
	}

	public String getResCd() {
		return resCd;
	}

	public void setResCd(String resCd) {
		this.resCd = resCd;
	}

	public void updatePayment(ActionEvent e) {
		String resCD = (String) payment.get("RES_CD");
	}

	public Map getSelectedRow() {
		return selectedRow;
	}

	public void setSelectedRow(Map selectedRow) {
		this.selectedRow = selectedRow;
	}

	public String getInputReceiptFg() {
		return inputReceiptFg;
	}

	public void setInputReceiptFg(String inputReceiptFg) {
		this.inputReceiptFg = inputReceiptFg;
	}

	public String getInputHp1() {
		return inputHp1;
	}

	public void setInputHp1(String inputHp1) {
		this.inputHp1 = inputHp1;
	}

	public String getInputHp2() {
		return inputHp2;
	}

	public void setInputHp2(String inputHp2) {
		this.inputHp2 = inputHp2;
	}

	public String getReceiptNo() {
		return receiptNo;
	}

	public void setReceiptNo(String receiptNo) {
		this.receiptNo = receiptNo;
	}

	public String getInputReceiptCd() {
		return inputReceiptCd;
	}

	public void setInputReceiptCd(String inputReceiptCd) {
		this.inputReceiptCd = inputReceiptCd;
	}

	public Map getPayment() {
		return payment;
	}

	public void setPayment(Map payment) {
		this.payment = payment;
	}


	public String getCUST_CD() {
		return CUST_CD;
	}

	public void setCUST_CD(String cust_cd) {
		CUST_CD = cust_cd;
	}

	public String getRES_DAY() {
		return RES_DAY;
	}

	public void setRES_DAY(String res_day) {
		RES_DAY = res_day;
	}

	public String getETC_RES_CD() {
		return ETC_RES_CD;
	}

	public void setETC_RES_CD(String etc_res_cd) {
		ETC_RES_CD = etc_res_cd;
	}

	public String getGOODS_TYPE_CD() {
		return GOODS_TYPE_CD;
	}

	public void setGOODS_TYPE_CD(String goods_type_cd) {
		GOODS_TYPE_CD = goods_type_cd;
	}

	public String getRES_CHK_CD() {
		return RES_CHK_CD;
	}

	public void setRES_CHK_CD(String res_chk_cd) {
		RES_CHK_CD = res_chk_cd;
	}

	public String getCOMP_CD() {
		return COMP_CD;
	}

	public void setCOMP_CD(String comp_cd) {
		COMP_CD = comp_cd;
	}

	public String getSTART_DAY() {
		return START_DAY;
	}

	public void setSTART_DAY(String start_day) {
		START_DAY = start_day;
	}

	public String getSTART_TIME() {
		return START_TIME;
	}

	public void setSTART_TIME(String start_time) {
		START_TIME = start_time;
	}

	public String getEND_TIME() {
		return END_TIME;
	}

	public void setEND_TIME(String end_time) {
		END_TIME = end_time;
	}

	public String getEND_TIME_FR() {
		return END_TIME_FR;
	}

	public void setEND_TIME_FR(String end_time_fr) {
		END_TIME_FR = end_time_fr;
	}

	public String getSTART_TIME_TO() {
		return START_TIME_TO;
	}

	public void setSTART_TIME_TO(String start_time_to) {
		START_TIME_TO = start_time_to;
	}

	public String getOKWT() {
		return OKWT;
	}

	public void setOKWT(String okwt) {
		OKWT = okwt;
	}

	public String getCHA_ID() {
		return CHA_ID;
	}

	public void setCHA_ID(String cha_id) {
		CHA_ID = cha_id;
	}

	public String getCHA_DEPT_CD() {
		return CHA_DEPT_CD;
	}

	public void setCHA_DEPT_CD(String cha_dept_cd) {
		CHA_DEPT_CD = cha_dept_cd;
	}

	public String getEVENT_CD() {
		return EVENT_CD;
	}

	public void setEVENT_CD(String event_cd) {
		EVENT_CD = event_cd;
	}

	public String getSTART_PYUN() {
		return START_PYUN;
	}

	public void setSTART_PYUN(String start_pyun) {
		START_PYUN = start_pyun;
	}

	public String getCANC_CD() {
		return CANC_CD;
	}

	public void setCANC_CD(String canc_cd) {
		CANC_CD = canc_cd;
	}

	public String getSTART_DAY_TO() {
		return START_DAY_TO;
	}

	public void setSTART_DAY_TO(String start_day_to) {
		START_DAY_TO = start_day_to;
	}

	public String getSTART_WDAY() {
		return START_WDAY;
	}

	public void setSTART_WDAY(String start_wday) {
		START_WDAY = start_wday;
	}

	public String getEND_DAY_FR() {
		return END_DAY_FR;
	}

	public void setEND_DAY_FR(String end_day_fr) {
		END_DAY_FR = end_day_fr;
	}

	public String getEND_PYUN() {
		return END_PYUN;
	}

	public void setEND_PYUN(String end_pyun) {
		END_PYUN = end_pyun;
	}

	public String getEND_WDAY() {
		return END_WDAY;
	}

	public void setEND_WDAY(String end_wday) {
		END_WDAY = end_wday;
	}

	public String getDISP_NM() {
		return DISP_NM;
	}

	public void setDISP_NM(String disp_nm) {
		DISP_NM = disp_nm;
	}

	public String getSTATUS_NM() {
		return STATUS_NM;
	}

	public void setSTATUS_NM(String status_nm) {
		STATUS_NM = status_nm;
	}

	public String getSTATUS_CD() {
		return STATUS_CD;
	}

	public void setSTATUS_CD(String status_cd) {
		STATUS_CD = status_cd;
	}

	public String getCITY_CD() {
		return CITY_CD;
	}

	public void setCITY_CD(String city_cd) {
		CITY_CD = city_cd;
	}

	public String getETC_GOODS_ID() {
		return ETC_GOODS_ID;
	}

	public void setETC_GOODS_ID(String etc_goods_id) {
		ETC_GOODS_ID = etc_goods_id;
	}

	public String getGOODS_CD() {
		return GOODS_CD;
	}

	public void setGOODS_CD(String goods_cd) {
		GOODS_CD = goods_cd;
	}

	public String getOP_CD() {
		return OP_CD;
	}

	public void setOP_CD(String op_cd) {
		OP_CD = op_cd;
	}

	public String getHT_CITY_CD() {
		return HT_CITY_CD;
	}

	public void setHT_CITY_CD(String ht_city_cd) {
		HT_CITY_CD = ht_city_cd;
	}

	public String getSITE_NM() {
		return SITE_NM;
	}

	public void setSITE_NM(String site_nm) {
		SITE_NM = site_nm;
	}

	public int getRES_CNT() {
		return RES_CNT;
	}

	public void setRES_CNT(int res_cnt) {
		RES_CNT = res_cnt;
	}

	public int getCANC_CNT() {
		return CANC_CNT;
	}

	public void setCANC_CNT(int canc_cnt) {
		CANC_CNT = canc_cnt;
	}

	public int getEVENT_AMT() {
		return EVENT_AMT;
	}

	public void setEVENT_AMT(int event_amt) {
		EVENT_AMT = event_amt;
	}

	public int getADD_AMT() {
		return ADD_AMT;
	}

	public void setADD_AMT(int add_amt) {
		ADD_AMT = add_amt;
	}

	public int getTOT_SALE_AMT() {
		return TOT_SALE_AMT;
	}

	public void setTOT_SALE_AMT(int tot_sale_amt) {
		TOT_SALE_AMT = tot_sale_amt;
	}

	public int getTOT_IN_AMT() {
		return TOT_IN_AMT;
	}

	public void setTOT_IN_AMT(int tot_in_amt) {
		TOT_IN_AMT = tot_in_amt;
	}

	public int getMISU_AMT() {
		return MISU_AMT;
	}

	public void setMISU_AMT(int misu_amt) {
		MISU_AMT = misu_amt;
	}

	public int getEV_DAY_CNT() {
		return EV_DAY_CNT;
	}

	public void setEV_DAY_CNT(int ev_day_cnt) {
		EV_DAY_CNT = ev_day_cnt;
	}

	public int getFEE() {
		return FEE;
	}

	public void setFEE(int fee) {
		FEE = fee;
	}

	public int getEV_NIGHT_CNT() {
		return EV_NIGHT_CNT;
	}

	public void setEV_NIGHT_CNT(int ev_night_cnt) {
		EV_NIGHT_CNT = ev_night_cnt;
	}

	public int getADULT_COUNT() {
		return ADULT_COUNT;
	}

	public void setADULT_COUNT(int adult_count) {
		ADULT_COUNT = adult_count;
	}

	public int getCHILD_COUNT() {
		return CHILD_COUNT;
	}

	public void setCHILD_COUNT(int child_count) {
		CHILD_COUNT = child_count;
	}

	public int getINFANT_COUNT() {
		return INFANT_COUNT;
	}

	public void setINFANT_COUNT(int infant_count) {
		INFANT_COUNT = infant_count;
	}

	public int getSALE_AMT() {
		return SALE_AMT;
	}

	public void setSALE_AMT(int sale_amt) {
		SALE_AMT = sale_amt;
	}

	public String getSTART_DAY01() {
		return START_DAY01;
	}

	public void setSTART_DAY01(String start_day01) {
		START_DAY01 = start_day01;
	}

	public String getSTART_DAY02() {
		return START_DAY02;
	}

	public void setSTART_DAY02(String start_day02) {
		START_DAY02 = start_day02;
	}

	public String getSTART_DAY03() {
		return START_DAY03;
	}

	public void setSTART_DAY03(String start_day03) {
		START_DAY03 = start_day03;
	}

	public String getEND_DAY01() {
		return END_DAY01;
	}

	public void setEND_DAY01(String end_day01) {
		END_DAY01 = end_day01;
	}

	public String getEND_DAY02() {
		return END_DAY02;
	}

	public void setEND_DAY02(String end_day02) {
		END_DAY02 = end_day02;
	}

	public String getEND_DAY03() {
		return END_DAY03;
	}

	public void setEND_DAY03(String end_day03) {
		END_DAY03 = end_day03;
	}

	public String getSTART_TIME01() {
		return START_TIME01;
	}

	public void setSTART_TIME01(String start_time01) {
		START_TIME01 = start_time01;
	}

	public String getSTART_TIME02() {
		return START_TIME02;
	}

	public void setSTART_TIME02(String start_time02) {
		START_TIME02 = start_time02;
	}

	public String getEND_TIME01() {
		return END_TIME01;
	}

	public void setEND_TIME01(String end_time01) {
		END_TIME01 = end_time01;
	}

	public String getEND_TIME02() {
		return END_TIME02;
	}

	public void setEND_TIME02(String end_time02) {
		END_TIME02 = end_time02;
	}

	public String getEND_TIME_FR01() {
		return END_TIME_FR01;
	}

	public void setEND_TIME_FR01(String end_time_fr01) {
		END_TIME_FR01 = end_time_fr01;
	}

	public String getEND_TIME_FR02() {
		return END_TIME_FR02;
	}

	public void setEND_TIME_FR02(String end_time_fr02) {
		END_TIME_FR02 = end_time_fr02;
	}

	public String getSTART_TIME_TO01() {
		return START_TIME_TO01;
	}

	public void setSTART_TIME_TO01(String start_time_to01) {
		START_TIME_TO01 = start_time_to01;
	}

	public String getSTART_TIME_TO02() {
		return START_TIME_TO02;
	}

	public void setSTART_TIME_TO02(String start_time_to02) {
		START_TIME_TO02 = start_time_to02;
	}

	public String getCHA_NM() {
		return CHA_NM;
	}

	public void setCHA_NM(String cha_nm) {
		CHA_NM = cha_nm;
	}

	public String getHANDPHONE() {
		return HANDPHONE;
	}

	public void setHANDPHONE(String handphone) {
		HANDPHONE = handphone;
	}

	public String getREMARK() {
		return REMARK;
	}

	public void setREMARK(String remark) {
		REMARK = remark;
	}

	public int getSITE_COMM() {
		return SITE_COMM;
	}

	public void setSITE_COMM(int site_comm) {
		SITE_COMM = site_comm;
	}

	public Converter getTrimDateInfo() {
		return new Converter() {
			public Object getAsObject(FacesContext arg0, UIComponent arg1,
					String arg2) {
				// TODO Auto-generated method stub
				return null;
			}
			public String getAsString(FacesContext arg0, UIComponent arg1,
					Object arg2) {
				if (arg2 instanceof String) {
					String s = (String) arg2;
					if (s.length() >= 10) {
						s = s.substring(0, 10);
					}
					return s;
				}
				return null;
			}
		};
	}

	public Converter getDouble2Int() {
		return new Converter() {

			public Object getAsObject(FacesContext arg0, UIComponent arg1, String arg2) {
				// TODO Auto-generated method stub
				return null;
			}

			public String getAsString(FacesContext arg0, UIComponent arg1,
					Object arg2) {
				// if (arg2 instanceof String) {
				// String s = (String) arg2;
				// int dot = s.indexOf('.');
				// if (dot > 0) {
				// return s.substring(0, dot);
				// }
				// return s;
				// }
				return null;
			}
		};
	}

	public String getCurrGoodsCd() {
		return currGoodsCd;
	}

	public void setCurrGoodsCd(String currGoodsCd) {
		this.currGoodsCd = currGoodsCd;
	}

	public String getCurrCompCd() {
		return currCompCd;
	}

	public void setCurrCompCd(String currCompCd) {
		this.currCompCd = currCompCd;
	}

	public int getDC_AMT() {
		return DC_AMT;
	}

	public void setDC_AMT(int dc_amt) {
		DC_AMT = dc_amt;
	}

	// //////////////////////////////////////////////////////////////////////
	// 취소
	public int getCancelGoodsCount() {
		return this.cancelGoodsCount; 
	}
	public void setCancelGoodsCount( int cancelGoodsCount ) {
		this.cancelGoodsCount = cancelGoodsCount; 
	}
	// 예약
	public int getReserveGoodsCount() {
		return this.reserveGoodsCount;
	}
	public void setReserveGoodsCount( int reserveGoodsCount ) {
		this.reserveGoodsCount = reserveGoodsCount;	// 예약
	}
	
	public int getReserveAirGoodsCount() {
		return reserveAirGoodsCount;
	}

	public void setReserveAirGoodsCount(int reserveAirGoodsCount) {
		this.reserveAirGoodsCount = reserveAirGoodsCount;
	}

	public int getCancelAirGoodsCount() {
		return cancelAirGoodsCount;
	}

	public void setCancelAirGoodsCount(int cancelAirGoodsCount) {
		this.cancelAirGoodsCount = cancelAirGoodsCount;
	}


	//
	public String getGoodsType() {
		return this.GOODS_TYPE;
	}

	public void setGoodsType( String goodsType ) {
		this.GOODS_TYPE = goodsType;
	}
	
	public void setPaymentCount( int paymentCount ) {
		this.paymentCount = paymentCount;	// 예약
	}
	

}