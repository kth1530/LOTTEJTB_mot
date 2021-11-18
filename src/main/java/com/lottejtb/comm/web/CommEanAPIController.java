package com.lottejtb.comm.web;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.security.MessageDigest;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lottejtb.comm.service.CommEanAPIVO;
import com.lottejtb.framework.common.CommProperty;

@Controller
public class CommEanAPIController{
    
    //private final Logger logger = Logger.getLogger(this.getClass());
    private final Logger logger = Logger.getLogger(CommEanAPIController.class);
    private final String USER_AGENT = "Mozilla/5.0";

    @RequestMapping(value = "/ean/APInfoAjax.do")
    @ResponseBody
    public String eanAPInfo(@ModelAttribute("CommEanAPIVO") CommEanAPIVO vo,HttpServletRequest request, Model model) throws Exception{

        //SIG KEY 생성
        String APIURL  = CommProperty.getProperty("eanAPIListURL");
               APIURL += "/"+CommProperty.getProperty("eanVersion");
               APIURL += "/"+CommProperty.getProperty("eanMethod");
        String cid    = CommProperty.getProperty("eanCID");
        String apiKey = CommProperty.getProperty("eanAPIKey");
        String secret = CommProperty.getProperty("eanSecret");
        String urlParameters = null;
        String ClintIP =  null;// "10.26.131.178"; //request.getRemoteAddr();
        String resultList = null;
        
        HttpURLConnection con = null;
        DataOutputStream wr = null;
        BufferedReader in = null;
        
        try {
            
            InetAddress LOCALHOST = InetAddress.getLocalHost();
            String HOST_ADDR = LOCALHOST.getHostAddress();
            if ("localhost".equals(HOST_ADDR) || HOST_ADDR.indexOf("127.0") > -1 || HOST_ADDR.indexOf("10.141") > -1 || HOST_ADDR.indexOf("192.168") > -1) {
                ClintIP = "10.26.131.178";
            }else{
                ClintIP = request.getRemoteAddr();
            }
            
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
            
            //******** 검색 변수 세팅 **********//
            // -> jsp 에서 오류 체크를 하여 아래와 같이 세팅 될 수 있도록 필수값 들을 받아 처리하도록 한다.
            // Vo.setArrivalDate(arrivalDate);
            
            /** API 검색 **/
            URL obj = new URL(APIURL);
            con = (HttpURLConnection) obj.openConnection();
            //add reuqest header
            con.setRequestMethod("POST");
            con.setRequestProperty("User-Agent", USER_AGENT);
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
            wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(urlParameters);
            wr.flush();
            
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
            
            model.addAttribute("resultList", resultList );
            
        } catch (Exception e) {
            //e.printStackTrace();
        	System.err.print("Interface Error!");
        } finally {
        	if(wr != null){
        		wr.close();
        	}
        	
        	if(in != null){
        		in.close();
        	}
        	
        	if(con != null){
        		con.disconnect();
        	}
        }
        
        return resultList;
    }
    
}