package test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

public class ApiEanAuth{
    
    public static String service = "http://api.ean.com/ean-services/rs/hotel/";
    public static String version = "v3/";
    public static String method = "list";
    public static String hotelId = "201252";
    //public static String otherElementsStr = "&cid=500316&minorRev=30&customerUserAgent=Mozilla/5.0+(Windows+NT+6.1;+Win64;+x64)+AppleWebKit/537.36+(KHTML,+like+Gecko)+Chrome/53.0.2785.116+Safari/537.36&customerIpAddress=10.26.133.7&locale=en_US&currencyCode=USD";
    public static String otherElementsStr = "&cid=500316&minorRev=30&customerUserAgent=Mozilla/5.0+(Windows+NT+6.1;+Win64;+x64)+AppleWebKit/537.36+(KHTML,+like+Gecko)+Chrome/53.0.2785.116+Safari/537.36&customerIpAddress=10.26.133.7&locale=ko_KR&currencyCode=KRW";
    public static String apikey = "42054h3uto03kvli4lpk1ls71f";
    public static String secret = "2h4u5g99if8n7";
    
    public static void main(String[] args) throws NoSuchAlgorithmException {
        
        MessageDigest md = MessageDigest.getInstance("MD5");
        long timeInSeconds = (System.currentTimeMillis() / 1000);
        String input = apikey + secret + timeInSeconds;
        md.update(input.getBytes());
        String sig = String.format("%032x", new BigInteger(1, md.digest()));
        
        String url = service + version + method+ "?apikey=" + apikey + "&sig=" + sig + otherElementsStr + "hotelIdList=" + hotelId;
        System.out.println("URL = " + url);
        DefaultHttpClient httpclient = new DefaultHttpClient();
        
        // Create an HTTP GET request
        HttpGet httpget = new HttpGet(url);
        
     // Execute the request
        httpget.getRequestLine();
        HttpResponse response = null;
        try {
         response = httpclient.execute(httpget);
        } catch (IOException e) {
         //e.printStackTrace();
        	System.err.println("Http Client Error!");
         return;
        } 
        
        HttpEntity entity = response.getEntity();
        // Print the response
        System.out.println(response.getStatusLine());
        
        if (entity != null) {
            try {
                InputStream inputStream = entity.getContent();
                // Process the response
                BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
                String line;
                while ((line = bufferedReader.readLine()) != null) {
                    System.out.println(line);
                }
                bufferedReader.close();
            } catch (Exception e) {
                //e.printStackTrace();
            	System.err.println("BufferReader Error!");
            }
        }
        httpclient.getConnectionManager().shutdown();
        
    }
    
}