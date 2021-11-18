<%@page import="com.lottejtb.sso.service.CookieInfoVO"%>
<%@page import="org.codehaus.jackson.map.deser.std.FromStringDeserializer.URLDeserializer"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.sun.star.util.URL"%>
<%@page import="com.lottejtb.sso.service.LoginVO"%>
<%@page import="com.lottejtb.comm.util.*"%>
<%@page import="com.lotte.member.bean.ctm.secure.*" %>
<%@page import="java.net.URLEncoder"%>
<%@page import="sun.misc.BASE64Decoder" %>
<%@page import="java.util.Properties" %>
<%@page import="java.io.FileInputStream" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Locale" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.nio.charset.Charset" %>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<title></title>

<script language="javascript">
	function setCookieTop( cookieName, cookieValue, expireDate )
	{
		var today = new Date();
		today.setDate( today.getDate() + parseInt( expireDate ) );
		document.cookie = cookieName + "=" + escape( cookieValue ) + "; path=/; ";
		document.cookie = cookieName + "=" + escape( cookieValue ) + "; path=/; domain=.lottejtb.com;";
	}
	
	function getCookieTop(uName) {
		var flag = document.cookie.indexOf(uName+'=');
		if (flag != -1) {
			flag += uName.length + 1
			end = document.cookie.indexOf(';', flag)
		if (end == -1) end = document.cookie.length
			return unescape(document.cookie.substring(flag, end))
		}else {
			return '';
		}
	}

	//고객번호 ~~~~~~~~~~~
	var ocno = getCookieTop("onl_cno");
	setCookieTop("cust_id", ocno, "");
	
	//로그인ID
	var id = getCookieTop("onl_id");
	setCookieTop("login_id", id, "");
	
	//고객명
	var name = getCookieTop("cst_nm");
	setCookieTop("username", name, "");
	
	//고객구분
	var ctype = getCookieTop("onl_cst_dc");
	setCookieTop("cust_type", ctype, "");
	
	//이메일
	var email = getCookieTop("elc_add");
	setCookieTop("email", email, "");
	
	//멤버스번호
	var mbr_cust_no = getCookieTop("cno");
	setCookieTop("mbr_cust_no", mbr_cust_no, "");
	
	var mbl_no = getCookieTop("mbl_no");
	setCookieTop("mbl_no", mbl_no, "");

	//멤버스번호
	var inf_clng_yn = getCookieTop("inf_clng_yn");

	if(inf_clng_yn == "x6qDBrN3DkQEArZh1dZlDA%3D%3D"){
		setCookieTop("desc_inf_clng_yn", "Y", "");
	} else {
		setCookieTop("desc_inf_clng_yn", "N", "");
	}

	function eraseCookie(key)
	{
		var cookieDate = new Date(2000,11,19,30,30);
		document.cookie = key + "= ; expires="+cookieDate.toGMTString()+"; path=/";
	}
</script>

</head>
<body>
<P>
	
<%

//	private final Charset UTF8_CHARSET = Charset.forName("UTF-8");

	String t_personal_no="";
	String t_login_id ="";
	String t_age="";
	String t_sex="";
	String t_year="";
	String t_cust_id="";
	String t_username="";
	String t_email = "";
	String pop_login_yn = "";
	String t_mbr_custno ="";
	String t_mbl_no = "";
	String t_inf_clng_yn ="";
	int n_age=0;
	String t_marry_fg = "";
	String t_cno = "";
	String t_cust_type = "";
	
	String d_cust_id = "";
	String d_login_id = "";
	String d_username = "";
	String d_email = "";
	String d_personal_no = "";
	String d_inf_clng_yn = "";
	String d_cust_type = "";
	String d_marry_fg = "";
	String d_mbr_custno = "";
	String d_mbl_no = "";
	String d_cno = "";


	// strFilePath 는 파일경로이므로 풀패스를 적어야 함 
	String confPath = request.getRealPath("/WEB-INF/lottesso.conf"); 
	//String strFilePath = "/home/MOBILE_WEB/public_html/LotteJTBmo/WEB-INF/jsp/sso/lottesso.conf";
	String strSID = "LOTTEJTB";
	SeedUtil sUtil = new SeedUtil(confPath, strSID);
	
	String encStr = "";  // 암호화된 쿠키값
	String decStr = "";  // 복호화된 문자열
	

  /*
	    cust_id	       	회원번호	숫자	　	　											Seed 암호화
		login_id	   	로그인아이디	문자(최대 40 BYTE)	　	　								Seed 암호화
		username		성명/법인명	문자(최대 50 BYTE)	　	　								Seed 암호화
		personal_no		주민등록/사업자/여권 번호	문자(최대 14 BYTE)							Seed 암호화
		cust_type		회원구분      REGULAR, ASSOCIATE, CORP, CHILD, FOREIGN, nullable		Seed 암호화
		marry_fg		결혼여부	　	Y, N, nullable	　										Seed 암호화
		nation_fg		외국인여부	I, D, nullable	I: 외국, D: 국내							Seed 암호화
		postcode		우편번호		문자(최대 10 BYTE)	　	　								Seed 암호화
		cust_key		위변조방지키															Seed 암호화
		agree_fg		약관동의여부	Y, N, nullable	jtb 약관 동의 여부							Seed 암호화
		email			이메일		문자(최대 50 BYTE)	　	　								Seed 암호화
 */
	
	Cookie[] cookies = request.getCookies();
	FileInputStream fInput = null;
	
	try {
		if ( cookies != null && cookies.length > 0 ) {
		
		    BASE64Decoder decoder = new BASE64Decoder();
		    
		    Properties ps = new Properties();
            fInput = new FileInputStream(confPath);
            ps.load(fInput);
            
            String STR_KEY = ps.getProperty("LOTTEJTB"); 
            		
            byte[] BYTE_KEY = decoder.decodeBuffer(STR_KEY);	
                      
			for(int i=0; i<cookies.length; i++) {
				
				encStr = cookies[i].getValue();  // request에서 읽음
			    byte bEncBuff[] = decoder.decodeBuffer(encStr);
			    Seedx seed = new Seedx(BYTE_KEY);
			    byte bDecBuff[] = seed.decrypt(bEncBuff);
			    decStr = new String(bDecBuff, "EUC-KR"); // 롯데닷컴에서 EUC-KR을 전송했기 때문에 EUC-KR로 변환해야함
				
			    System.out.println(cookies[i].getName());
			    //System.out.println("######desStr=" + decStr + "CookieName=" + cookies[i].getName());
			    
			 	if ( "onl_cno".equals(cookies[i].getName()) ) {
					t_cust_id = decStr;
					d_cust_id = encStr;
				} else if ( "onl_id".equals(cookies[i].getName()) ) {
					t_login_id = decStr;
					d_login_id = encStr;
				} else if ( "cst_nm".equals(cookies[i].getName()) ) {
					t_username = decStr;
					d_username = encStr;
				} else if ( "elc_add".equals(cookies[i].getName()) ) {
				    t_email = decStr;
				    d_email = encStr;
				}
			 	
				if ( "cust_id".equals(cookies[i].getName()) ) {
					t_cust_id = decStr;
					d_cust_id = encStr;
				} else if ( "login_id".equals(cookies[i].getName()) ) {
					t_login_id = decStr;
					d_login_id = encStr;
				} else if ( "personal_no".equals(cookies[i].getName()) ) {
					t_personal_no = decStr;
					d_personal_no = encStr;
				} else if ( "inf_clng_yn".equals(cookies[i].getName()) ) {
					t_inf_clng_yn = decStr;
					d_inf_clng_yn = encStr;
				} else if ( "cust_type".equals(cookies[i].getName()) ) {
					t_cust_type = decStr;
					d_cust_type = encStr;
				} else if ( "marry_fg".equals(cookies[i].getName()) ) {
					t_marry_fg = decStr;
					d_marry_fg = encStr;
				} else if ( "nation_fg".equals(cookies[i].getName()) ) {
				} else if ( "postcode".equals(cookies[i].getName()) ) {
				} else if ( "cust_key".equals(cookies[i].getName()) ) {
				} else if ( "agree_fg".equals(cookies[i].getName()) ) {
				}  else if ( "email".equals(cookies[i].getName()) ) {
				 	t_email = decStr;
				 	d_email = encStr;
				} else if ( "username".equals(cookies[i].getName()) ) {
					t_username = decStr;
					d_username = encStr;
				} else if ( "pop_login_yn".equals(cookies[i].getName()) ) {
					pop_login_yn = cookies[i].getValue();
				} else if ( "mbr_cust_no".equals(cookies[i].getName()) ){
					t_mbr_custno = decStr;
					d_mbr_custno = encStr;
				} else if ( "mbl_no".equals(cookies[i].getName()) ){
					t_mbl_no = decStr;
					d_mbl_no = encStr;
				} else if("cno".equals(cookies[i].getName())){
					t_cno = decStr;
					d_cno = encStr;
				}				
			}

		//에이스카운터 나이, 성별, 로긴아이디 세팅 ============================start
		Calendar cal= Calendar.getInstance();
		SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd", Locale.KOREA); 
		String todayDt = simple.format(cal.getTime());	//8자리 아라비아숫자 반환
		
			// Cookie에 주민번호가 전달 된 경우에만 처리
			if (null != t_personal_no && !"".equals(t_personal_no)) {
			
				t_age = t_personal_no.substring(0,2);		//주민번호 앞 두자리
				t_sex = t_personal_no.substring(6,7);		//남성,여성 구분
				t_year = todayDt.substring(2,4);				//현재년도 두자리
				if( "1".equals(t_sex) || "3".equals(t_sex) || "5".equals(t_sex) || "7".equals(t_sex) ){
					t_sex = "man";
				}else if( "2".equals(t_sex) || "4".equals(t_sex) || "6".equals(t_sex) || "8".equals(t_sex) ){
					t_sex = "woman";
				}else{
					t_sex = "";
				}
	
				n_age = Integer.parseInt(t_year) - Integer.parseInt(t_age) +1 ;
				if( n_age < 0  ){
					n_age += 100;
				}
			
			} else {
				t_personal_no = "";
			}
						
			// end ============================ 에이스카운터 나이, 성별, 로긴아이디 세팅
			
		}
		
	   /*  PreparedStatement pstmt = null;
	    Connection conn = null;
	    ResultSet resultSet = null;
	    String custCd = null;
	    StringBuilder query = new StringBuilder();
		StringBuilder insertQuery = new StringBuilder();
		StringBuilder loginQuery = new StringBuilder();
	    
	    try {
		    Context context = new InitialContext();
            //DataSource ds = (DataSource) context.lookup("java:T2_OPR");
            DataSource ds = (DataSource) context.lookup("java:T4_DEV");
                      
            conn = ds.getConnection();
		    
		    query.append("\n SELECT CUST_CD  ");
		    query.append("\n    FROM CU_MST ");
		    query.append("\n  WHERE LOTTE_ID ='" + t_cust_id.trim()  +"'");
		    
		    pstmt = conn.prepareStatement(query.toString());
		    resultSet =  pstmt.executeQuery();
		    
		    
		   	while (resultSet.next()) {
		   		custCd = resultSet.getString("CUST_CD");
			}
			
			
			if (null == custCd) {
			 
			
			    insertQuery.append("\n INSERT INTO CU_MST (CUST_CD, JMNO, KNM, ID, EMAIL, DEL_YN, LOTTE_ID, INS_DT, INS_ID)  ");
			    insertQuery.append("\n    VALUES((SELECT LPAD(TO_CHAR(max(TO_NUMBER(CUST_CD))+1),10,'0') FROM CU_MST),?,?,?,?,?,?, sysdate, 'MOBILEUSER') ");
			
		
			    pstmt = conn.prepareStatement(insertQuery.toString());
			    pstmt.setString(1, t_personal_no.trim());
			    pstmt.setString(2, t_username.trim());
			    pstmt.setString(3, t_login_id.trim());
			    pstmt.setString(4, t_email.trim());
			    pstmt.setString(5,"N");
			    pstmt.setString(6, t_cust_id.trim());
		
				pstmt.executeUpdate();
				
			} else { //2015.6.15 L.POINT 2차오픈 대응 (EMAIL체계 전환)
						
				insertQuery.append("\n UPDATE CU_MST SET ID=?, EMAIL=?, UPD_DT=sysdate,UPD_ID='MOBILEUSER' WHERE LOTTE_ID=? ");
			
			    pstmt = conn.prepareStatement(insertQuery.toString());
			    
			    pstmt.setString(1, t_login_id.trim());
			    pstmt.setString(2, t_email.trim());			    
			    pstmt.setString(3, t_cust_id.trim());
		
				pstmt.executeUpdate();
						
			}

				loginQuery.append("\n INSERT INTO LOTTE_LOGINLOG (LOTTE_ID, LOGINTIME, REMARK)  ");
			    loginQuery.append("\n    VALUES(?, sysdate,?) ");
			
		
			    pstmt = conn.prepareStatement(loginQuery.toString());

			    pstmt.setString(1, t_cust_id.trim());

				
				pstmt.setString(2, t_inf_clng_yn.trim());
			
		
				pstmt.executeUpdate();
					
				System.out.println("IEMASTER SUCCEED.." + t_cust_id.trim());
			
		} catch (Exception e) {
			System.out.println("IEMASTER FAILED.." +"Lotte ID is: " + t_cust_id.trim());
			e.printStackTrace();
		
		} finally {
	            if( pstmt != null ) try { pstmt.close(); pstmt = null; }  catch(Exception e) {}
	            if( conn != null ) try { conn.close(); conn = null; } catch(Exception e) {}
	            if( resultSet != null ) try { resultSet.close(); resultSet = null; } catch(Exception e) {}
	    }  */
		
		
	}
	catch ( Exception e ) {
		System.out.println("IEMASTER FAILED.." +"Lotte ID is: " + t_cust_id.trim());
		//e.printStackTrace();
		
	} finally {
		try {
			fInput.close();
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("Stream Close Error!");
		}
	}
%>

<script type="text/javascript">
var _id = '<%=CommUtil.filterXSS(t_login_id.trim())%>';   				//로그인 사용자 아이디
var _gd = '<%=CommUtil.filterXSS(t_sex)%>';    	 						//성별
var _ag = '<%=CommUtil.filterXSS(String.valueOf(n_age))%>';    	 						//나이
var _inf = '<%=CommUtil.filterXSS(t_inf_clng_yn)%>';    	 			//나이

//var m_ag	= '<%=n_age%>' ;         				// 로그인사용자 나이
//var m_id	= '<%=t_login_id.trim()%>';    			// 로그인사용자 아이디
//var m_mr	= '<%=t_marry_fg%>';        			// 로그인사용자 결혼여부 ('single' , 'married' )
//var m_gd	= '<%=t_sex%>';         				// 로그인사용자 성별 ('man' , 'woman')
//var m_jid	= '<%=t_login_id.trim()%>' ;			// 가입시입력한 ID
</script>


<script type="text/javascript">
setCookieTop("desc_inf_clng_yn1",_inf , "");

$(document).ready(function() {
<%
	if(t_cust_id.trim() == null || t_cust_id.trim() == "") {
%> 
	setAlert("정상적인 로그인 정보를 얻어올 수 없습니다.\n 브라우저 설정의 쿠키허용을 확인해 주시기 바랍니다.");
     if(devType == 0)
     	document.location.href = "http://mdev.lottejtb.com";
     else
    	document.location.href = "http://m.lottejtb.com";
<%
	} else {
%>
	 fn_loginData();  //로그인 로직
<%
	}
%>	 
});

//cookie값 저장데이터
var fn_loginData = function() {

	//[JEH] login log - 20180308
	fnLoginLog('<%=CommUtil.filterXSS(t_cust_id.trim())%>');	
	
	if(window.localStorage.getItem('autoLogin') == 'Y'){
		var lotteJtbCookies = {
			'cst_nm'				: '<%=CommUtil.filterXSS(d_username)%>',
			'prv_ag_dt'				: getCookieTop("prv_ag_dt"),
			'prv_ag_dc'				: getCookieTop("prv_ag_dc"),
			'bf_onl_id'				: getCookieTop("bf_onl_id"),
			'bf_onl_id_ch_dtti'		: getCookieTop("bf_onl_id_ch_dtti"),
			'cco_optin_ml'			: getCookieTop("cco_optin_ml"),
			'cco_optin_ml_dtti'		: getCookieTop("cco_optin_ml_dtti"),
			'cco_optin_sms'			: getCookieTop("cco_optin_sms"),
			'cco_optin_sms_dtti'	: getCookieTop("cco_optin_sms_dtti"),
			'inf_clng_yn'			: getCookieTop("inf_clng_yn"),
			'personal_no'			: '<%=CommUtil.filterXSS(d_personal_no)%>',
			'cno'					: '<%=CommUtil.filterXSS(d_cno)%>',
			'onl_id'				: '<%=CommUtil.filterXSS(d_login_id)%>',
			'onl_cst_dc'			: getCookieTop("onl_cst_dc"),
			'elc_add'				: '<%=CommUtil.filterXSS(d_email)%>',
			'mbl_no'				: '<%=CommUtil.filterXSS(d_mbl_no)%>',
			'onl_cno'				: getCookieTop("onl_cno")
		}
		
		var mLotteJtbCookies = {
			'desc_inf_clng_yn'		: getCookieTop("desc_inf_clng_yn"),
			'login_id'				: '<%=CommUtil.filterXSS(d_login_id)%>',
			'mbl_no'				: '<%=CommUtil.filterXSS(d_mbl_no)%>',
			'cust_id'				: '<%=CommUtil.filterXSS(d_cust_id)%>',
			'mbr_cust_no'			: '<%=CommUtil.filterXSS(d_mbr_custno)%>',
			'cust_type'				: '<%=CommUtil.filterXSS(d_cust_type)%>',
			'desc_inf_clng_yn1'		: getCookieTop("desc_inf_clng_yn1"),
			'email'					: '<%=CommUtil.filterXSS(d_email)%>',
			'username'				: '<%=CommUtil.filterXSS(d_username)%>'
		}
		
		window.localStorage.setItem("lmInfo", JSON.stringify(lotteJtbCookies));
		window.localStorage.setItem("ljInfo", JSON.stringify(mLotteJtbCookies));
	}
	
	var deviceUUID = "";
	
	if(nullToBlank(deviceInfo) != ""){
		deviceUUID = deviceInfo.uuid;
	}
	
	var formData = new FormData();
	formData.append('cust_id','<%=CommUtil.filterXSS(t_cust_id.trim())%>');
	formData.append('knm','<%=CommUtil.filterXSS(t_username.trim())%>');
	formData.append('id','<%=CommUtil.filterXSS(t_login_id.trim())%>');
	formData.append('email','<%=CommUtil.filterXSS(t_email.trim())%>');
	formData.append('sex','<%=CommUtil.filterXSS(t_sex.trim())%>');
	formData.append('mblNo', '<%=CommUtil.filterXSS(t_mbl_no.trim())%>');
	formData.append('mbrCustno', '<%=CommUtil.filterXSS(t_mbr_custno.trim())%>');
	formData.append('custGradeCd', '<%=CommUtil.filterXSS(t_cust_type.trim())%>');
	formData.append('cno', '<%=CommUtil.filterXSS(t_cno.trim())%>');
	formData.append('deviceId', deviceUUID);
	
	cfn_ajax({
		type : "POST",
		async : false,
		url: "/cookie/cookieSaveDataAjax.do",
		data: formData,
		dataType: "json",
		cache : false,
		noloading : "yes",
		timeOut : 5 * 60 * 1000,
		success: function(data) {
			var list = data.cookieData;
			
			console.log("cust_cd=" + list[0]["cust_id"]);
			console.log("knm=" + list[0]["knm"]);
			console.log("id=" + list[0]["id"]);
			console.log("email=" + list[0]["email"]);
			
			<%
			//String returnurl = (String)request.getAttribute("returnurl");
			String returnurl = request.getParameter("returnurl");
			if(returnurl != null)
				returnurl = URLDecoder.decode(returnurl, "UTF-8");

			//System.out.println("returnurl3333333333333333333333333333=" + returnurl);
			
			// 리턴 페이지가 없을때
			if ( returnurl == null || returnurl.equals("") || returnurl.indexOf("/jsp/sso/loginSuccess.do") > -1 || returnurl.indexOf("/sso/loginChk.do") > -1 || returnurl.indexOf("/sso/loginProcess.do") > -1) { 
			%>
				if(devType == 0)	
					document.location.href = 'http://mdev.lottejtb.com/';
				else
					document.location.href = 'http://m.lottejtb.com/';
			<%
			} else if ( returnurl.indexOf("dht.lottejtb.com") > -1 ) {
				// 호텔엔조이(국내숙박) 관련
				//returnurl = URLEncoder.encode(returnurl);
				//System.out.println("returnurl44444444444444444444444444444444444444=" + returnurl);
			%>
				document.location.href = 'http://m.lottejtb.com/jsp/sso/dht_login.do?returnurl=<%=returnurl%>';
			
				//document.location.href = 'http://m.lottejtb.com/domestic/dmt_detail_domestic.do?url=http://dht.lottejtb.com/alliance/mobile/main.php?AID=LTJTB&ctgname=국내숙소';
				//alert("서비스 준비중 입니다");
			<%	
			}else if ( returnurl.indexOf("m.air.lottejtb.com") > -1 || returnurl.indexOf("local.lottejtb.com") > -1 || returnurl.indexOf("renewal.lottejtb.com") > -1 || returnurl.indexOf("dev1.lottejtb.com") > -1) {
				returnurl = URLDecoder.decode(returnurl);
			%>
				document.location.href = decodeURIComponent('<%=returnurl%>');
				
			<%	
			}
			// 일반 로그인
			else  {
			%>

			console.log("returnUrl :" + '<%=returnurl%>');
				// 팝업 로그인
				if ( opener != null ) {

					//현재 주소에서 returnurl 파라미터만 읽음
					var return_url = document.location.href.split("=");
					var pop_login = "N";
					
					//네이버 통해서 들어온 경우(opener != null) 이기 때문에 분기 필요
					//==================================================
					for (var i=0; i<return_url.length; i++) {
						//마이투어 로그인 할 경우(바닥로그인)
						
						if (return_url[i].indexOf("security.lottejtb.com")>=0) {
							pop_login = "N"
							
						}
					}		
					//==================================================
					pop_login = '<%=CommUtil.filterXSS(pop_login_yn)%>';


					//팝업 로그인
					if(pop_login == "Y"){

						
						//쿠키삭제
						eraseCookie("pop_login_yn");
						
						if(opener != null)
							opener.location.reload();
						if(self != null)
							self.close();	
					//바닥 로그인
					}else{
						
						document.location.href = '<%=CommUtil.filterXSS(returnurl)%>';
						
					}
				}
				// 바닥 로그인
				else	{
					//document.location.href = '<%=CommUtil.filterXSS(returnurl)%>';
					var rrrr = "<%=CommUtil.filterXSS(returnurl)%>";
					var rrrr1 = rrrr.replace("&amp;","&");
					var rrrr2 = rrrr1.replace("&amp%3b","&");
					//alert(rrrr2);
					document.location.href = rrrr2;
					
				}
			<%
			}
			%>
			
		},
		error : function(err) {
			
			alert(err);
		
		},
		complete : function(e) {
			console.log(e);
			
		}
		
	});

	//[JEH] login log - 20180308
	function fnLoginLog(cust_id){

		console.log("+++++++++++ login Success 111 ++++++++++++++");
		
		var formData = new FormData();
		formData.append('cust_id',getCookieTop("onl_cno"));

		cfn_ajax({
			type : "POST",
			async : false,
			url: "/sso/loginLogInsertAjax.do",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "yes",
			success: function(data) {
				console.log('succ');					
			},
			error : function(err) {
				console.log('err : ' + err);			
			}
		});
	}
	
};

</script>


</body>
</html>