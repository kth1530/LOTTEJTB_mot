package com.lottejtb.push.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.annotation.Resource;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Repository;

import com.google.android.gcm.server.Message;
import com.google.android.gcm.server.MulticastResult;
import com.google.android.gcm.server.Result;
import com.google.android.gcm.server.Sender;
import com.lottejtb.push.service.impl.PushDAO;

import javapns.Push;
import javapns.communication.exceptions.CommunicationException;
import javapns.communication.exceptions.KeystoreException;
import javapns.devices.exceptions.InvalidDeviceTokenFormatException;
import javapns.notification.PayloadPerDevice;
import javapns.notification.PushNotificationPayload;
import javapns.notification.PushedNotification;
import javapns.notification.ResponsePacket;
import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;
import net.sf.json.JSONObject;


@PropertySource("classpath:/spring/config/config.properties")
@Repository
public class PushService  {

	private static final String TYPE_ANDROID = "AND";
	private static final String	TYPE_IOS 	 = "IOS";
	
	private Integer rsvCnt[];
	
	private HashMap<String, Integer> hm = new HashMap<String, Integer>();
	
	private List<PushInfoVO> list = null;
	
	private int queryCnt = 1; 
	
	private int totCnt = 0;
	
	private int andSucc = 0;
	private int andFail = 0;
	private int andErr = 0;
	private int andNotReg = 0;
	
	private int iosSucc = 0;
	private int iosFail = 0;
	private int iosErr1 = 0;
	private int iosErr2 = 0;
	private int iosErr3 = 0;
	private int iosErr4 = 0;
	private int iosErr5 = 0;
	
	private int tokNull = 0;
	private int tokNotNull = 0;
	
	@Resource(name = "ehcache")
    Ehcache ehcache;
	
	@Autowired
	Environment env;
		
	@Resource(name="PushDAO")
	private  PushDAO pushDAO;

	boolean isInit = false;
	
		
	public void sendPushMessage() throws Exception {
		long insTime = 0;  //등록시간
		long rsvTime = 0;  //예약시간
		long diffTime = 0; //시간차
			
//		long curTime = 0;//현재시간
		

		//[JEH] 현재시간 - 20180201 ====================================================
		GregorianCalendar gc = new GregorianCalendar();
        long milis = gc.getTimeInMillis();// 밀리초로 바꿔준다
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // 기본 데이타베이스 저장 타입
        Date d = gc.getTime(); // Date -> util 패키지
        String curTime = sf.format(d);
		//=======================================================================


		String startDt = "";
		String insDt = "";
			
		PushInfoVO pushinfo = new PushInfoVO();
		
		//푸시 기기정보
		//캐싱적용===============================================================
		Ehcache cache = ehcache.getCacheManager().getCache("chcache-properties");
		
		Element listCache;

		listCache = cache.get("pushinfo");
		
		//query 조회 주기
		int cycle = queryCnt % 60;  //60분에 한번씩 조회로 셋팅
		//System.out.println("cycle=" + cycle);
		
		if(listCache == null || (list != null && cycle == 0)) {	
			list = pushDAO.getPushInfo(pushinfo);
			if(list != null) {
				cache.put(new Element("pushinfo", list));
			}
			queryCnt = 1;
			//System.out.println("NO CACHE#################");
		} else {
			list = (List<PushInfoVO>)listCache.getObjectValue();
			//System.out.println("CACHE####################");
			queryCnt++;
		}
		//System.out.println("listCache=" + listCache);
		
		//=======================================================================
		
		SendPushVO sPInfo = new SendPushVO();
		//푸시 메시지 발송 정보
		List<SendPushVO> info = pushDAO.sendPushInfo(sPInfo);
		
		
		//초기화
		if(!isInit) 	
			init();
		
		
		try {
					
			for(int j=0; j < info.size(); j++) {
				if(info != null) {
									
					if(info.get(j).getPushYn().equals("N")) {  //미발송된 푸시
						
						startDt = info.get(j).getStartDt(); //발송날짜
						insDt = info.get(j).getInsDt();  //서버날짜
								
						//시간차
						if(startDt != null && insDt != null) {
							diffTime = rsvTimeToMinute(startDt.substring(0, 19), curTime.substring(0, 19));
//							diffTime = rsvTimeToMinute(startDt.substring(0, 19), insDt.substring(0, 19));
							System.out.println(">>>>>>>>>diffTime<<<<<<<<<<=" + diffTime);
						}
						
						if(diffTime == 0){
							System.out.println(">>>>>>>>>>>>푸쉬발송<<<<<<<");
//							List<String> iosTokenList = new ArrayList<String>();
							for(int i=0; i < list.size(); i++){
								if(list.get(i).getDevice_token() != null) {
									//안드로이드 발송
								    if(list.get(i).getOs_type().equals(TYPE_ANDROID)) { 					   
								    	sendMessageGCM(list.get(i).getDevice_token(), 
								    				   info.get(j).getNoSeq(),
								    				   info.get(j).getTitle(),
								    				   info.get(j).getMessage(),
								    				   info.get(j).getTagetUrl());
								    	
								    }
								    
								    
							    	//아이폰 발송
								    if(list.get(i).getOs_type().equals(TYPE_IOS)) {
								    	sendMessageAPNS(list.get(i).getDevice_token(),
								    			 		info.get(j).getNoSeq(),
								    			 		info.get(j).getTitle(),
								    			 		info.get(j).getMessage(),
								    			 		info.get(j).getTagetUrl());
//								    	iosTokenList.add(list.get(i).getDevice_token());
								    }
								    
								    tokNotNull ++;
								}else{
									tokNull ++;
								}
								totCnt ++;
							}
							
//							sendMessageFCM(info.get(j),iosTokenList);

							System.out.println("==========>>push cnt log start<<============");
							System.out.println("totCnt : " + totCnt);
							System.out.println("tokNull : " + tokNull);
							System.out.println("tokNotNull : " + tokNotNull);
							System.out.println("andSucc : " + andSucc);
							System.out.println("andFail : " + andFail);
							System.out.println("andErr : " + andErr);
							System.out.println("andNotReg : " + andNotReg);
							System.out.println("iosSucc : " + iosSucc);
							System.out.println("iosFail : " + iosFail);
							System.out.println("iosErr1 : " + iosErr1);
							System.out.println("iosErr2 : " + iosErr2);
							System.out.println("iosErr3 : " + iosErr3);
							System.out.println("iosErr4 : " + iosErr4);
							System.out.println("iosErr5 : " + iosErr5);
							System.out.println("==========>>push cnt log end<<============");
							
							PushInfoVO pVo = new PushInfoVO();
							pVo.setTotal(totCnt);
							pVo.setTok_null(tokNull);
							pVo.setTok_not_null(tokNotNull);
							pVo.setAnd_succ(andSucc);
							pVo.setAnd_fail(andFail);
							pVo.setAnd_err(andErr);
							pVo.setAnd_not_reg(andNotReg);
							pVo.setIos_succ(iosSucc);
							pVo.setIos_fail(iosFail);
							pVo.setIos_err1(iosErr1);
							pVo.setIos_err2(iosErr2);
							pVo.setIos_err3(iosErr3);
							pVo.setIos_err4(iosErr4);
							pVo.setIos_err5(iosErr5);							
							
							pushDAO.insertPushCnt(pVo);

						}
						
				}
			 }	
				
		   }
			init();
		} catch(Exception e) {
			System.out.println("==========>>push catch!!!<<============");
			System.out.println("err=" + e.getMessage());
			init();
		}
		

	}
	
	private void init() {

		//변수초기화
		totCnt = 0;							
		andSucc = 0;
		andFail = 0;
		andErr = 0;							
		andNotReg = 0;							
		iosSucc = 0;
		iosFail = 0;
		iosErr1 = 0;
		iosErr2 = 0;
		iosErr3 = 0;
		iosErr4 = 0;
		iosErr5 = 0;
		tokNull = 0;
		tokNotNull = 0;
		
		if(list != null) {
			rsvCnt = new Integer [list.size()];
			System.out.println("rsvCnt.length=" + rsvCnt.length);
			
			for(int i= 0; i < rsvCnt.length; i++) {
				rsvCnt[i] = 1;
			}
		}
		isInit = true;
	}
		
	/*
	 * svrTime : 서버시간
	 * rsvtime : 예약시간
	 */
	private long rsvTimeToMinute(String rsvTime, String svrTime) {
		long s = 0;//서버시간
		long r = 0; //예약시간
		long diff = 0;
		long toMinute = 0;
		Date svr = new Date();
		Date rsv = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		try {
			svr = formatter.parse(svrTime);
			rsv = formatter.parse(rsvTime);
			
			s = svr.getTime();
			r = rsv.getTime();
			
			diff = r - s;
			
			if(diff > 0) {
				//분으로 환산
				toMinute = diff / (60*1000);
			}
			//System.out.println(">>>>>>>>>>>>diffTime=" + toMinute);
		} catch (ParseException e) {
			//e.printStackTrace();
			System.err.println(" Date Process Error!");
		}
		return toMinute;
		
	}
	
	//GCM SEND
	public void sendMessageGCM(String tokenId, String seq, String title, String msg, String url) {
		try {
			String API_KEY = "";
			API_KEY = env.getProperty("push.gcm.apikey");
			//System.out.println("API_KEY=" + API_KEY);
			
			Sender sender = new Sender(API_KEY);
			String regid = tokenId;
			
//			if(!tokenId.equals("APA91bHQlwNfpk-8sXJItdlZUPZJk5AuyF6gL-WJMfys4C7ycq2rKkgHA0n8QiOybUYzNJMmZVFeSLJ6ddPOseu4nQQoJvx44KHQ1j9XfNPFIKZhK8y0nLRhAM54cZT_olE4LKRp5LZn")) 
//				return;
//			
//			regid = "APA91bFCIS1MYGmB0IciM6ndOZvGdKVrBF6FLe4e8WQ0GZnskt_gvKAaU7wfllr3xdQRZQ_Vd_Q4dETdOaugTUpPCO1xfbPVhz4aWv5Gq-siPe4tz6F5vSb2qRnbQa5BG5TIv3qYGgZ0";
			
			
			MulticastResult multiResult;
			
			// 메세지의 고유 ID(?)정도로 생각하면 됩니다. 메세지의 중복수신을 막기 위해 랜덤값을 지정합니다
			String COLLAPSE_KEY  = String.valueOf(Math.random() % 100 + 1);
			boolean DELAY_WHILE_IDLE = false;		// 기기가 활성화 상태일 때 보여줄 것인지.
			int TIME_TO_LIVE = 3;					// 기기가 비활성화 상태일 때 GCM Storage에 보관되는 시간
			int RETRY = 3;							// 메세지 전송 실패시 재시도할 횟수
			
			int i;
			List<String> registrationIds = new ArrayList<String>();
			List<Result> result = new ArrayList<Result>();
			int resultSize = 0;
			String errorCodeName = "";

			String message = "";
			if(msg != null){
				message = msg.replaceAll("<p>", "");
				message = message.replaceAll("</p>", "");
				message = message.replaceAll("&nbsp;", " ");
			}			
			
			Message gcmMessage = new Message.Builder().collapseKey(COLLAPSE_KEY)
	                    .delayWhileIdle(DELAY_WHILE_IDLE).timeToLive(TIME_TO_LIVE)
	                    .addData("ticker", "push Message")
	                    .addData("title", title)
	                    .addData("message", message)
	                    .addData("notid", seq)
	                    .addData("tagetUrl",url).build();
		
			registrationIds.add(regid);
			
			multiResult = sender.send(gcmMessage, registrationIds, RETRY);
			result = multiResult.getResults();
			resultSize = result.size();
			errorCodeName = "";
	
			//System.out.println("result=" + result.toString());
			//System.out.println("[regid=]" + regid + ",  [gcmMessage=]" + gcmMessage);
			
			//성공이면
			//System.out.println("multiResult.getSuccess=" + multiResult.getSuccess());
			if(multiResult.getSuccess() == 1) {
				System.out.println(">>push success(AND)<<");
				//로직 추가
				SendPushVO push = new SendPushVO();
				push.setNoSeq(seq);
				push.setPushYn("Y");
				
				//업데이트
				pushDAO.sendPushYn(push);
				
				andSucc ++;
				//로그에도 쌓자
			} else { //실패
				System.out.println(">>push fail(AND)<<");
				System.out.println("#multiResult.getSuccess#=" + multiResult.getSuccess());
				System.out.println("#result#=" + result.toString());
				
				//결과값이 NotRegistered 이면 DB에서 토큰 삭제(x로 상태값 update)
				if(result.toString().indexOf("NotRegistered") != -1){
					try{
						PushInfoVO pushinfo = new PushInfoVO();
						pushinfo.setMarketing_yn("X");
						pushinfo.setDevice_token(regid);
						
						pushDAO.delPushToken(pushinfo);
					}catch(Exception e){
						System.err.println(">>Token Status Update Error!!(AND)<<");
						System.out.println("#error#=" + e);
					}					
					andNotReg ++;
				}
				andFail ++;
			}
//		    System.out.println("getCanonicalIds : " + multiResult.getCanonicalIds()
//		                    + "\n" + "getSuccess : " + multiResult.getSuccess() + "\n"
//		                    + "getTotal : " + multiResult.getTotal() + "\n"
//		                    + "getMulticastId : " + multiResult.getMulticastId());
		} catch(Exception e) {
			//e.printStackTrace();
			System.err.println(">>Push Error!(AND)<<");
			System.out.println("#error#=" + e);
			andErr ++;
		}
		
	}
	
		
	//APNS SEND
	public void sendMessageAPNS(String tokenId, String seq, String title, String msg, String url) {
		
		try {
			
			//if(!tokenId.equals("93c59b337d9d2d6509bb7c997f9b364178547fb8686fd95edf127f51c1f9d120")) 
			//return;
			
			String regid = tokenId;
			
			PushNotificationPayload payload = PushNotificationPayload.complex();
			
			String message = title;// + "|" + msg;
			
			payload.addAlert(message);
			payload.addSound("default");
			payload.addBadge(0);
			payload.addCustomDictionary("tagetUrl", url);
//			
//			payload.addAlert("아이폰 푸시 테스트입니다.");
//			payload.addSound("default");
//			payload.addBadge(0);
//			payload.addCustomDictionary("tagetUrl", "/free/main.do?tabType=hotel&domesticYn=Y");
//			

			List<PayloadPerDevice> payloadDevicePairs = new Vector<PayloadPerDevice>();
			
			
			//System.out.println("payload=" + payload.toString());
			payloadDevicePairs.add(new PayloadPerDevice(payload, regid));
			  
			// * Push.payloads(keystore, password, production, payloadDevicePairs)
			// * keystore : keystore.p12
			// * password : keysotre.p12 password
			// * production : ture(production), false(developer)
			// * payloadDevicePairs : payloadPerDevice(message, deviceToken)
			  
			System.out.println("[key=]" + env.getProperty("push.apns.key"));
			System.out.println("[pwd=]" + env.getProperty("push.apns.pwd"));
			System.out.println("===========================Push.payloads start ==============");
			
			System.out.println("regid=" + regid);
			
			List<PushedNotification> NOTIFICATIONS = Push.payloads(env.getProperty("push.apns.key"), env.getProperty("push.apns.pwd"), true, payloadDevicePairs);
			
			System.out.println("NOTIFICATIONS=" + NOTIFICATIONS.toString());
			
			System.out.println("===========================Push.payloads end=================");
					
			for(PushedNotification NOTIFICATION : NOTIFICATIONS) {
				if(NOTIFICATION.isSuccessful()){
					System.out.println(">>push Success(APP)<<");
					System.out.println("PUSH NOTIFICATION SENT SUCCESSFULLY TO : "+ NOTIFICATION.getDevice().getToken());
//					//로직 추가
					SendPushVO push = new SendPushVO();
					push.setNoSeq(seq);
					push.setPushYn("Y");
//					
//					//업데이트
					try {
						pushDAO.sendPushYn(push);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						System.out.println(">>push send Error(APP)<<");
						System.out.println(e.getMessage());
					}    
					iosSucc ++;
				}else{
					System.out.println(">>push Error(APP)<<");
					String INVALIDTOKEN = NOTIFICATION.getDevice().getToken();
					Exception THEPROBLEM = NOTIFICATION.getException();
					//THEPROBLEM.printStackTrace();

					System.out.println("#iosFail#=" + THEPROBLEM);
					iosFail ++;
					
					ResponsePacket THEERRORRESPONSE = NOTIFICATION.getResponse();
					if(THEERRORRESPONSE != null){
						System.out.println(THEERRORRESPONSE.getMessage());
					}
				}
			}
			
		} catch (CommunicationException e) {
			//e.printStackTrace();
			System.out.println("#1#=" + e.getMessage());
			iosErr1 ++;
		} catch (KeystoreException e) {
			//e.printStackTrace();
			System.out.println("#2#=" + e.getMessage());
			iosErr2 ++;
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			System.out.println("#3#=" + e.getMessage());
			iosErr3 ++;
		} catch (InvalidDeviceTokenFormatException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			System.out.println("#4#=" + e.getMessage());
			iosErr4 ++;
		} catch(Exception e) { 
			System.out.println("#5#=" + e.getMessage());
			iosErr5 ++;
		}
		
	}
	
	public void sendMessageFCM(SendPushVO vo,List<String> iosTokenList) {

		
		try{
			String fcmFailReson = "";
			int fcmSucc = 0;
			int fcmFail = 0;
	        final String apiKey = "AAAA9foLkj0:APA91bGumk4GdTjW2nis06vfgrj5QM7UgFGBNueHq3Sw0stpLcPFgHiS-8dGDczD97FysX4kVkZz4LwRalLW36h5KOopNid0gwecigRcdq84cfR63QLihzf0vXzTxPksJ-FiqR2V-qdR";
	        URL url = new URL("https://fcm.googleapis.com/fcm/send");
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setDoOutput(true);
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Content-Type", "application/json");
	        conn.setRequestProperty("Authorization", "key=" + apiKey);
	
	        conn.setDoOutput(true);
	        // marketY 마케팅 동의
	        // marketN 마케팅 불동의
	        // ALL 전체 사용자
	        //" \"to\":\"/topics/marketY\"
	        Map<String,Object> rootMap = new HashMap<String,Object>();
	        Map<String,String> notiMap = new HashMap<String,String>();
	        Map<String,String> extraDataMap = new HashMap<String,String>();
	        
	        if(vo.getMessage() == null){
	        	notiMap.put("title", "알림");
	        	notiMap.put("body", vo.getTitle());
	        }else{
	        	notiMap.put("title", vo.getTitle());
	        	notiMap.put("body", vo.getMessage());
	        }
	        
	        notiMap.put("badge", "1");
	        rootMap.put("notification", notiMap);
	        rootMap.put("sound", "default");
	        extraDataMap.put("targetUrl", vo.getTagetUrl());
	        rootMap.put("data", extraDataMap);
	        rootMap.put("priority", "high");
	        
	        
	        
	        //한번에 1000개씩
	        int tokenCnt = iosTokenList.size() / 1000;

	      	if(iosTokenList.size() % 1000 > 0) {
	      		tokenCnt += 1;
	      	}
	      	
	      	System.out.println(iosTokenList.size()+",page: "+tokenCnt);
	        for(int i = 0; i < tokenCnt; i++) {

				if(tokenCnt - i > 1) {
					rootMap.put("registration_ids", iosTokenList.subList((i * 1000), (i + 1) * 1000));
				} else {
					rootMap.put("registration_ids", iosTokenList.subList((i * 1000), iosTokenList.size()));
				}
				System.out.println("###################");
				JSONObject jsonObj = getJsonStringFromMap(rootMap);
				System.out.println("json:"+jsonObj.toString());
				
				
		        OutputStream os = conn.getOutputStream();
		        
		        // 서버에서 날려서 한글 깨지는 사람은 아래처럼  UTF-8로 인코딩해서 날려주자
		        os.write(jsonObj.toString().getBytes("UTF-8"));
		        os.flush();
		        os.close();
		
		        int responseCode = conn.getResponseCode();
		        System.out.println("\nSending 'POST' request to URL : " + url);
		        System.out.println("Post parameters : " + jsonObj.toString());
		        System.out.println("Response Code : " + responseCode);
		        
		        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		        String inputLine;
		        StringBuffer response = new StringBuffer();
		        
		        while ((inputLine = in.readLine()) != null) {
		            response.append(inputLine);
		        }
		        in.close();
		        
		        if(responseCode == 200){
			        
					 // print result
			        System.out.println("==========START LOG FCM 푸쉬 발송 ===========");
		        	System.out.println(response.toString());
		        	System.out.println("==========END LOG FCM 푸쉬 발송 ===========");
		        	JSONObject jsonObject = JSONObject.fromObject(response.toString());

		            Map<String,Object> map = getMapFromJsonObject(jsonObject);
		            fcmSucc += (int)map.get("success");
		            fcmFail += (int)map.get("failure");
		            
		            List<Map<String,Object>> resultList = (List<Map<String,Object>>)map.get("results");
		            for(int j=0;j<resultList.size();j++){
		            	if(resultList.get(j).containsKey("error")){
		            		if(fcmFailReson.indexOf((String)resultList.get(j).get("error"))==-1){
		            			fcmFailReson+=(String)resultList.get(j).get("error")+",";
		            		}
		            	}
		            }
		            //  System.out.println(map.get("results").toString());
		            
		        	
		        }else{
		        	 System.out.println("==========START LOG FCM 푸쉬 발송 에러===========");
		        	 System.out.println(response.toString());
		        	 System.out.println("==========END LOG FCM 푸쉬 발송 에러===========");
		        }
				

	        }
	        
	        //로직 추가
			SendPushVO push = new SendPushVO();
			push.setNoSeq(vo.getNoSeq());
			push.setPushYn("Y");
			//업데이트
			pushDAO.sendPushYn(push);
			
	        System.out.println("==========START LOG FCM 푸쉬 발송 ===========");
        	System.out.println("==========SEQ:"+vo.getNoSeq()+"===========");
        	System.out.println("==========CONTENTS:"+vo.getTitle()+"===========");
        	System.out.println("==========성공:"+fcmSucc+"===========");
        	System.out.println("==========실패:"+fcmFail+"===========");
        	System.out.println("==========실패 원인:"+fcmFailReson+"===========");
        	System.out.println("==========END LOG FCM 푸쉬 발송 ===========");
        	
	        
		}catch(Exception e){
			 System.out.println("==========START LOG FCM 푸쉬 발송 Exception===========");
			 e.printStackTrace();
			 System.out.println("==========END LOG FCM 푸쉬 발송 Exception ===========");
		}    
		
	}
	
	//map -> jsonobject
	 public static JSONObject getJsonStringFromMap( Map<String, Object> map )
	    {
	        JSONObject jsonObject = new JSONObject();
	        for( Map.Entry<String, Object> entry : map.entrySet() ) {
	            String key = entry.getKey();
	            Object value = entry.getValue();
	            jsonObject.put(key, value);
	        }
	        
	        return jsonObject;
	    }
	 
	 //jsonobject -> map
	 public static Map<String, Object> getMapFromJsonObject( JSONObject jsonObj )
    {
        Map<String, Object> map = null;
        
        try {
            
            map = new ObjectMapper().readValue(jsonObj.toString(), Map.class) ;
            
        } catch (JsonParseException e) {
            e.printStackTrace();
        } catch (JsonMappingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
 
        return map;
    }

}
