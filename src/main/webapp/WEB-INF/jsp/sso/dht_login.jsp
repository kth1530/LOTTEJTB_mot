<%@page import="javax.swing.text.Document"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.lotte.member.bean.ctm.secure.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="sun.misc.BASE64Encoder"%>
<%@ page import="sun.misc.BASE64Decoder"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>

<%

	// ȣ�� �����̿� ��Ű	
	String chk_enjoy = "";

	// strFilePath �� ���ϰ���̹Ƿ� Ǯ�н��� ����� �� 
	String confPath = request.getRealPath("/WEB-INF/lottesso.conf"); 
	String strSID = "LOTTEJTB"; 
	SeedUtil sUtil = new SeedUtil(confPath, strSID);
	// -- ��� ���ϴ� �� ����
		
	String encStr = ""; // ��ȣȭ�� ��Ű��
	String decStr = ""; // ��ȣȭ�� ���ڿ�
	
	Cookie[] cookies = request.getCookies();
	FileInputStream fInput = null;
		
	try {
		if (cookies != null && cookies.length > 0) {
			
			//String KEY_PATH = "/tmax/prowave/t2/T2WebApp/jsp/sso/lottesso.conf";
			BASE64Decoder decoder = new BASE64Decoder();
		
			Properties ps = new Properties();
			fInput = new FileInputStream(confPath);
			ps.load(fInput);
			String STR_KEY = ps.getProperty("LOTTEJTB");	
			byte[] BYTE_KEY = decoder.decodeBuffer(STR_KEY);			
		
			for (int i = 0; i < cookies.length; i++) {
			
				encStr = cookies[i].getValue(); // request���� ����
				byte bEncBuff[] = decoder.decodeBuffer(encStr);
				Seedx seed = new Seedx(BYTE_KEY);
				byte bDecBuff[] = seed.decrypt(bEncBuff);
				decStr = new String(bDecBuff, "EUC-KR"); // �Ե����Ŀ��� EUC-KR�� �����߱� ������ EUC-KR�� ��ȯ�ؾ���	
	
				BASE64Encoder encoder = new BASE64Encoder();	
				String str = decStr.trim();	
				
				str = URLEncoder.encode(str,"euc-kr");
				str = encoder.encode(str.getBytes());

				// ȣ�� �����̿� ��Ű ó��
				if ("cust_id".equals(cookies[i].getName())) {
					Cookie dht_cust_id = new Cookie("dht_cust_id", str);
					dht_cust_id.setDomain(".lottejtb.com");
					dht_cust_id.setPath("/");
					response.addCookie(dht_cust_id);
					chk_enjoy = "true";	
				} else if ("username".equals(cookies[i].getName())) {
					Cookie dht_user_name = new Cookie("dht_user_name", str);
					dht_user_name.setDomain(".lottejtb.com");
					dht_user_name.setPath("/");
					response.addCookie(dht_user_name);
				} else if ("email".equals(cookies[i].getName())) {
					Cookie dht_email = new Cookie("dht_email", str);
					dht_email.setDomain(".lottejtb.com");
					dht_email.setPath("/");
					response.addCookie(dht_email);
				} else if ("mall_cd".equals(cookies[i].getName())) {
					Cookie dht_mall_cd = new Cookie("dht_mall_cd", str);
					dht_mall_cd.setDomain(".lottejtb.com");
					dht_mall_cd.setPath("/");
					response.addCookie(dht_mall_cd);
				}			

			}////for�� ��			
			
		}////if�� ��
	} catch (Exception e) {
		//e.printStackTrace();
		System.err.println("Cookie Process Error!");
	} finally {
		try {
			if (null != fInput) {
				fInput.close();
			}
		} catch (Exception e) {
			//e.printStackTrace();
			System.err.println("File Stream Close Error!");
		}
	}	

	String returnurl = request.getParameter("returnurl");
		
	if (returnurl == null || "".equals(returnurl)) {
		returnurl = "http://m.lottejtb.com";
	}
	try {
		// ��Ű Ȯ��
		if ("true".equals(chk_enjoy)) {
		    String[] url1 = returnurl.split("url=");
		    if(url1 != null)
			    returnurl = URLEncoder.encode(url1[1], "UTF-8");
		    
		    String ctgname= URLEncoder.encode("��������", "UTF-8");
		    RequestDispatcher dispatcher = request.getSession().getServletContext().getRequestDispatcher("/domestic/dmt_detail_domestic.do?url=" + returnurl + "&ctgname=" + ctgname);
			dispatcher.forward(request,response);
			//response.sendRedirect("/domestic/dmt_detail_domestic.do?url=" + returnurl + "&ctgname=" + ctgname);
			return;
		
		} else {
			returnurl = URLEncoder.encode(returnurl);
			//response.sendRedirect("https://security.lottejtb.com/jsp/sso/dht_login.xhtml?returnurl=" + returnurl);
			RequestDispatcher dispatcher = request.getSession().getServletContext().getRequestDispatcher("http://m.lottejtb.com");
			dispatcher.forward(request,response);
			//response.sendRedirect("http://m.lottejtb.com");
			return;
		}
	}catch(Exception e) {
	 	System.out.println(e.getMessage());
	}
%>