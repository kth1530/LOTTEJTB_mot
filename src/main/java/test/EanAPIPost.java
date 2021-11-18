package test;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;

//import javax.net.ssl.HttpsURLConnection;
import java.net.HttpURLConnection;
import java.security.MessageDigest;

import javax.annotation.Resource;

import com.lottejtb.framework.common.CommProperty;

import egovframework.rte.fdl.property.EgovPropertyService;

public class EanAPIPost {
  
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    private final String USER_AGENT = "Mozilla/5.0";

    public static void main(String[] args) throws Exception {

        EanAPIPost http = new EanAPIPost();

        System.out.println("Testing 1 - Send Http GET request");
        http.sendGet();

        System.out.println("\nTesting 2 - Send Http POST request");
        http.sendPost();

    }

 // HTTP GET request
    private void sendGet() throws Exception {
        
        try {
            String url = "http://www.google.com/search?q=mkyong";

            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();

            // optional default is GET
            con.setRequestMethod("GET");

            //add request header
            con.setRequestProperty("User-Agent", USER_AGENT);

            int responseCode = con.getResponseCode();
            System.out.println("\nSending 'GET' request to URL : " + url);
            System.out.println("Response Code : " + responseCode);

            BufferedReader in = new BufferedReader(
                    new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            //print result
            System.out.println(response.toString());
        } catch (Exception e) {
           //e.printStackTrace();
        	System.err.println("String Buffer Error!");
        }
        

    }

    // HTTP POST request
    private void sendPost() throws Exception {
        
        try {
            String url = "http://api.ean.com/ean-services/rs/hotel/v3/list";
            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();

            //add reuqest header
            con.setRequestMethod("POST");
            con.setRequestProperty("User-Agent", USER_AGENT);
            con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
            
            //SIG KEY 생성
            //String urlParameters = "cid=500317&sig=912d850183eacfd6cc9bec1b2835f72b&minorRev=30&apiKey=42054h3uto03kvli4lpk1ls71f&locale=ko_KR&currencyCode=KRW&customerIpAddress=10.26.131.178&customerUserAgent=Mozilla/5.0+(Windows+NT+6.1;+Win64;+x64)+AppleWebKit/537.36+(KHTML,+like+Gecko)+Chrome/53.0.2785.116+Safari/537.36&customerSessionId=&xml=%3CHotelListRequest%3E%3CarrivalDate%3E10/17/2016%3C/arrivalDate%3E%3CdepartureDate%3E10/19/2016%3C/departureDate%3E%3CRoomGroup%3E%3CRoom%3E%3CnumberOfAdults%3E2%3C/numberOfAdults%3E%3CnumberOfChildren%3E1%3C/numberOfChildren%3E%3CchildAges%3E5%3C/childAges%3E%3C/Room%3E%3C/RoomGroup%3E%3Ccity%3EBoston%3C/city%3E%3CstateProvinceCode%3EMA%3C/stateProvinceCode%3E%3CcountryCode%3EUS%3C/countryCode%3E%3C/HotelListRequest%3E";
            String urlParameters = "cid=500317&sig=680de4fa788e673ab4d3dabacae39a86&minorRev=30&apiKey=42054h3uto03kvli4lpk1ls71f&locale=ko_KR&currencyCode=KRW&customerIpAddress=10.26.131.178&customerUserAgent=Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36&customerSessionId=&xml=<HotelListRequest><departureDate>10/17/2016</departureDate><departureDate>10/19/2016</departureDate><RoomGroup><numberOfAdults>2</numberOfAdults><numberOfChildren>3</numberOfChildren><childAges>5,6,7</childAges></RoomGroup><city>Boston</city><stateProvinceCode>MA</stateProvinceCode><countryCode>US</countryCode></HotelListRequest>";

            // Send post request
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(urlParameters);
            wr.flush();
            wr.close();

            int responseCode = con.getResponseCode();
            System.out.println("\nSending 'POST' request to URL : " + url);
            System.out.println("Post parameters : " + urlParameters);
            System.out.println("Response Code : " + responseCode);

            BufferedReader in = new BufferedReader(
                    new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            //print result
            System.out.println(response.toString());
        } catch (Exception e) {
           //e.printStackTrace();
        	System.err.println("Data Output Stream Error!");
        }
        

    }

}