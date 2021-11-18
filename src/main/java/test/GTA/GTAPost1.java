package test.GTA;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class GTAPost1 {
  
    public static void main(String[] args) throws Exception {
       
        String xmlFile = "D:\\J2EE\\workspace\\LOTTEJTB\\LotteJTB\\src\\main\\java\\test\\GTA\\GTA.xml";
        
        StringBuffer fileData = new StringBuffer(1000);
        BufferedReader reader = new BufferedReader( new InputStreamReader(new FileInputStream(xmlFile),"utf-8"));
        
        char[] buf = new char[1024];
        int numRead = 0;
        while((numRead=reader.read(buf)) != -1){
            fileData.append(buf, 0, numRead);
        }
        reader.close();
        
        String xml_string_to_send = fileData.toString();
        String returnString = "";
        
        HttpURLConnection connection = null;
        OutputStream os =null;
        try {
            URL searchUrl = new URL("https://interface.demo.gta-travel.com/rbskrapi/RequestListenerServlet");
            connection = (HttpURLConnection)searchUrl.openConnection();
            connection.setDoOutput(true);
            connection.setRequestMethod("POST");

            connection.setRequestProperty( "Content-Type", "application/soap+xml" );
            connection.setRequestProperty( "Content-Length", Integer.toString(xml_string_to_send.length()) );
            os = connection.getOutputStream();
            os.write( xml_string_to_send.getBytes("utf-8") );
            os.flush();
            os.close();
            
                //결과값 수신
            int rc = connection.getResponseCode();
            if(rc==200){
                InputStreamReader in = new InputStreamReader(connection.getInputStream(),"utf-8");
                BufferedReader br = new BufferedReader(in);
                String strLine;
                while ((strLine = br.readLine()) != null){
                    returnString = returnString.concat(strLine);
                }
               //결과값출력
                System.out.println(returnString);
                return;
            }else{
                System.out.println("http response code error: "+rc+"\n");
                return;
            }
        } catch (Exception e) {
            System.out.println("search URL connect failed: " + e.getMessage());
            //e.printStackTrace();
        } finally {
            if(os!=null) os.close();
            connection.disconnect();
        }
        
        
    }

}