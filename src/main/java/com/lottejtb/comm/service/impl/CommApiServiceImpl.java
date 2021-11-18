package com.lottejtb.comm.service.impl;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.lottejtb.comm.service.CommApiService;
import com.lottejtb.comm.service.CommEanAPIVO;
import com.lottejtb.comm.service.CommExchangeVO;
import com.lottejtb.framework.common.CommProperty;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("CommApiService")
public class CommApiServiceImpl extends EgovAbstractServiceImpl implements CommApiService{
    
    private static final Logger logger = Logger.getLogger(CommApiServiceImpl.class);
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @Resource(name = "CommApiDAO")
    private CommApiDAO commApiDao;

    @Override
    public String eanApiHotelList(CommEanAPIVO vo,HttpServletRequest request) throws Exception {
        
        String APIURL  = CommProperty.getProperty("eanAPIListURL");
               APIURL += "/"+CommProperty.getProperty("eanVersion");
               APIURL += "/"+CommProperty.getProperty("eanMethod");
        String cid    = CommProperty.getProperty("eanCID");
        String apiKey = CommProperty.getProperty("eanAPIKey");
        String secret = CommProperty.getProperty("eanSecret");
        String urlParameters = null;
        String remoteAddr = request.getRemoteAddr();
        String ClintIP =  ( ("localhost".equals(remoteAddr) || remoteAddr.indexOf("127.0") > -1 || remoteAddr.indexOf("10.") > -1 || remoteAddr.indexOf("192.168") > -1) )? "192.168.0.1" : "10.26.131.178" ;
        
        String resultList = null;
        HttpURLConnection con = null;
        BufferedReader in = null;
        
        try {
            
            //SIG KEY 생성
            MessageDigest md = MessageDigest.getInstance("MD5");
            long timeInSeconds = (System.currentTimeMillis() / 1000);
            String input = apiKey + secret + timeInSeconds;
            md.update(input.getBytes());
            String sig = String.format("%032x", new BigInteger(1, md.digest()));
            
            //******** 기본 변수값 세팅 *********//
            vo.setCid(cid);
            vo.setApiKey(apiKey);
            vo.setSig(sig);
            if( vo.getLocale() == null ) vo.setLocale("ko_KR");
            if( vo.getCurrencyCode() == null ) vo.setCurrencyCode("KRW"); 
            
            /** API 검색 **/
            URL obj = new URL(APIURL);
            con = (HttpURLConnection) obj.openConnection();
            //add reuqest header
            con.setRequestMethod("POST");
            con.setRequestProperty("User-Agent", "Mozilla/5.0");
            con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
            
            /* Parameters Setting */
            urlParameters  = "apiExperience=PARTNER_WEBSITE&cid="+vo.getCid();
            urlParameters += "&sig="+vo.getSig();
            urlParameters += "&minorRev="+vo.getMinorRev();
            urlParameters += "&apiKey="+apiKey;
            urlParameters += "&locale="+vo.getLocale();
            urlParameters += "&currencyCode="+vo.getCurrencyCode();
            urlParameters += "&customerIpAddress="+ClintIP;
            urlParameters += "&customerUserAgent="+request.getHeader("user-agent").replaceAll(" ", "+");
            urlParameters += "&customerSessionId="+request.getSession().getId();
            urlParameters += "&xml=";
            urlParameters += "<HotelListRequest>";
            if( vo.getArrivalDate()   !=null )   urlParameters += "<arrivalDate>"+vo.getArrivalDate()+"</arrivalDate>";
            if( vo.getDepartureDate() !=null )   urlParameters += "<departureDate>10/19/2016</departureDate>";
            if( Integer.parseInt(vo.getNumberOfAdults()) > 0){
                urlParameters += "<RoomGroup>";
                urlParameters += "<Room>";
                urlParameters += "<numberOfAdults>"+vo.getNumberOfAdults()+"</numberOfAdults>";
                if( Integer.parseInt(vo.getNumberOfChildren()) > 0){
                    urlParameters += "<numberOfChildren>3</numberOfChildren>";
                    urlParameters += "<childAges>5,6,7</childAges>";
                }
                urlParameters += "</Room>";
                urlParameters += "</RoomGroup>";
            }
            if( vo.getCity() !=null ) urlParameters += "<city>"+vo.getCity()+"</city>";
            if( vo.getStateProvinceCode() !=null ) urlParameters += "<stateProvinceCode>"+vo.getStateProvinceCode()+"</stateProvinceCode>";
            if( vo.getCountryCode()       !=null ) urlParameters += "<countryCode>"+vo.getCountryCode()+"</countryCode>";
            if( vo.getNumberOfResults() > 0 ) urlParameters +="<numberOfResults>"+vo.getNumberOfResults()+"</numberOfResults>";
            urlParameters += "</HotelListRequest>";
            urlParameters += "&_type=xml";
            
            // Send post request
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(urlParameters);
            wr.flush();
            wr.close();
            
            int responseCode = con.getResponseCode();
            System.out.println("\nSending 'POST' request to URL : " + APIURL);
            System.out.println("Post parameters : " + urlParameters);
            System.out.println("Response Code : " + responseCode);
            
            in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();
            
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            
            resultList = response.toString(); //response.toString().replaceAll("\"", "");
            
            /*
            String resultList = response.toString().replaceAll("\"", ""); //  response.toString().replaceAll("\\", "" );
            resultList = resultList.replaceAll("\\\\", "");
            */
            System.out.println("//====================================");
            System.out.println(resultList);
            System.out.println("//====================================");
            
        } catch (Exception e) {
            //e.printStackTrace();
        	System.err.print("인터페이스 오류!");
        } finally {
        	if(in != null){
        		in.close();
        	}
        	
        	if(con != null){
        		con.disconnect();
        	}
        }
        
        return resultList;
    }
    
    @Override
    public CommExchangeVO exchangeInfo(CommExchangeVO vo) throws Exception{
    	return commApiDao.exchangeInfo(vo); 
    }
    
    @Override
    public List totalExchangeInfo() throws Exception{
    	return commApiDao.totalExchangeInfo(); 
    }
}