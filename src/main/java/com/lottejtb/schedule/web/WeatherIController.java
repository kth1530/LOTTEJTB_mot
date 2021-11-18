package com.lottejtb.schedule.web;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.HashMap;

import javax.annotation.Resource;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.log4j.Logger;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;

import com.lottejtb.schedule.service.WeatherIService;
import com.lottejtb.schedule.service.WeatherIVO;

@Controller
public class WeatherIController {

	private final Logger logger = Logger.getLogger(this.getClass());
	public String fileName = "";
	
//	웨더아이 개발서버정보	/////////////////////////////////////////
	public String server = "211.55.33.234";			
	public int port = 21;
	public String user = "lottejtb";
	public String pass = "lottejtb!#";
	
/////////////////////////////////////////////////////////////
	public String remotePath	=	"/";
	HashMap<String, String> msgMap = new HashMap<String, String>();
	
	@Resource(name = "weatherIService")
	private WeatherIService weatherIService;

	//분, 시 , 일 
	@Scheduled( cron="0 30 05 * * ?" )
	public void WeatherIInterface() throws Exception{
		System.out.println("=================WeatherIInterface start===========================");
		
//		msgMap.put("0", "/resources/images/ico/0.swf");
//		msgMap.put("1", "/resources/images/ico/1.swf");
//		msgMap.put("2", "/resources/images/ico/2.swf");
//		msgMap.put("3", "/resources/images/ico/3.swf");
//		msgMap.put("4", "/resources/images/ico/4.swf");
//		msgMap.put("5", "/resources/images/ico/5.swf");
//		msgMap.put("6", "/resources/images/ico/6.swf");
//		msgMap.put("7", "/resources/images/ico/7.swf");
//		msgMap.put("8", "/resources/images/ico/8.swf");
//		msgMap.put("9", "/resources/images/ico/9.swf");
//		msgMap.put("10", "/resources/images/ico/10.swf");
//		msgMap.put("11", "/resources/images/ico/11.swf");
//		msgMap.put("12", "/resources/images/ico/12.swf");
//		msgMap.put("13", "/resources/images/ico/13.swf");
//		msgMap.put("14", "/resources/images/ico/14.swf");
//		msgMap.put("15", "/resources/images/ico/15.swf");
//		msgMap.put("16", "/resources/images/ico/16.swf");
//		msgMap.put("17", "/resources/images/ico/17.swf");
//		msgMap.put("18", "/resources/images/ico/18.swf");
//		msgMap.put("19", "/resources/images/ico/19.swf");
//		msgMap.put("20", "/resources/images/ico/20.swf");
		
		/** 테스트용 **/
		fileName = "wx_world.dat";
		worldFileToDB(server, port, user, pass, fileName, remotePath);

		fileName = "wx_land.dat";
		landFileToDB(server, port, user, pass, fileName, remotePath);
		System.out.println("=================WeatherIInterface END===========================");
	}
	
	public void worldFileToDB(String server, int port, String user, String pass, String downloadFileName, String remotePath) throws Exception{
        
        FTPClient ftpClient = new FTPClient();
        
        BufferedReader in = null;
        InputStream inputStream = null;
        
        try {
 
            ftpClient.connect(server, port);
            ftpClient.login(user, pass);
            ftpClient.enterLocalPassiveMode();
            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
 
            String remoteFile1 =  remotePath + downloadFileName;
            inputStream = ftpClient.retrieveFileStream(remoteFile1);
	        in = new BufferedReader(new InputStreamReader(inputStream, "euc-kr"));
	        String s;

	        while ((s = in.readLine()) != null) {
	        	System.out.println(s);
	        	String[] tabString = s.split("\t");
	        	WeatherIVO weatherIVO = new WeatherIVO();
	          
//	        	일자 도시코드 도시명 국가코드 날씨코드 날씨명 최고기온 최저기온 날씨이미지
	        	if(tabString.length > 7){
					weatherIVO.setCountry_map_cd(tabString[3]);
					weatherIVO.setCity_map_cd(tabString[1]);
					weatherIVO.setWeat_dt(tabString[0].replace("-", ""));
					weatherIVO.setCity_nm(tabString[2]);
					weatherIVO.setWeat_cd(tabString[4]);
					weatherIVO.setWeat_nm(tabString[5]);
					weatherIVO.setMax_temper(tabString[6]);
					weatherIVO.setMin_temper(tabString[7]);
//					String imgKey = msgMap.get(tabString[4]);
//					weatherIVO.setWeather_img(imgKey);
					weatherIVO.setIns_id("SYSTEM");
					
					weatherIService.saveWorldFileToDB(weatherIVO);
	        	}
	        }
	        System.out.println("=====================worldFileToDB end=============================");
	        in.close();
           
	        inputStream.close();
            
        } catch (IOException ex) {
        	logger.error("Error: " + ex.getMessage());
            //ex.printStackTrace();
        } finally {
        	if(in != null){
        		in.close();
        	}
            if(inputStream != null){
            	inputStream.close();
            }
	        
            try {
                if (ftpClient.isConnected()) {
                    ftpClient.logout();
                    ftpClient.disconnect();
                }
            } catch (IOException ex) {
               // ex.printStackTrace();
            	System.err.println("IO Error!");
            }
        }
	}	

	public void landFileToDB(String server, int port, String user, String pass, String downloadFileName, String remotePath) throws Exception{
        
        FTPClient ftpClient = new FTPClient();
        BufferedReader in = null;
        InputStream inputStream = null;
        try {
 
            ftpClient.connect(server, port);
            ftpClient.login(user, pass);
            ftpClient.enterLocalPassiveMode();
            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
 
            String remoteFile1 =  remotePath + downloadFileName;
            inputStream = ftpClient.retrieveFileStream(remoteFile1);
	        in = new BufferedReader(new InputStreamReader(inputStream, "euc-kr"));
	        String s;

	        while ((s = in.readLine()) != null) {
	        	System.out.println(s);
	        	String[] paramString = new String[10];
	        	String[] tabString = s.split("\t");
	        	
        		WeatherIVO weatherIVO = new WeatherIVO();
        		
//        		일자 도시코드 날씨코드 날씨명 최고기온 최저기온 오전강수확률 오후강수확율 풍향 풍속 날씨이미지
        		for(int i=0;i<10;i++){
        			if(i<tabString.length){
        				paramString[i] = tabString[i]; 
        			}
        		}
        		
				weatherIVO.setCountry_map_cd("KR");
				weatherIVO.setCity_map_cd(paramString[1]);
				weatherIVO.setWeat_dt(paramString[0].replace("-", ""));
				weatherIVO.setCity_nm("");
				weatherIVO.setWeat_cd(paramString[2]);
				weatherIVO.setWeat_nm(paramString[3]);
				weatherIVO.setMax_temper(paramString[4]);
				weatherIVO.setMin_temper(paramString[5]);
				weatherIVO.setAm_rainfall(paramString[6]);
				weatherIVO.setPm_rainfall(paramString[7]);
				weatherIVO.setWind_direction(paramString[8]);
				weatherIVO.setWind_speed(paramString[9]);
//					String imgKey = msgMap.get(tabString[2]);
//					weatherIVO.setWeather_img(imgKey);
				weatherIVO.setIns_id("SYSTEM");
					
					weatherIService.saveLandFileToDB(weatherIVO);
	        }
	        System.out.println("=====================landFileToDB end=============================");
           
	        inputStream.close();
            
        } catch (IOException ex) {
        	logger.error("Error: " + ex.getMessage());
            //ex.printStackTrace();
        } finally {
        	if(in != null){
        		in.close();
        	}
        	
        	if(inputStream != null){
        		inputStream.close();
        	}
        	
            try {
                if (ftpClient.isConnected()) {
                    ftpClient.logout();
                    ftpClient.disconnect();
                }
            } catch (IOException ex) {
                //ex.printStackTrace();
            	System.err.println("Client disconnect Error!");
            }
        }
	}	
}
