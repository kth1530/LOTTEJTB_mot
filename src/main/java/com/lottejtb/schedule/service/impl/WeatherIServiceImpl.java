package com.lottejtb.schedule.service.impl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.lottejtb.schedule.service.WeatherIService;
import com.lottejtb.schedule.service.WeatherIVO;


/**
* 클래스명    :  예약 관련 서비스  구현  클래스 
* @ClassDesc  : 예약 관련 서비스  구현  클래스 
* @FileName   : ReserveServiceImpl.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.28 /  / 최초작성
*/

@Service("weatherIService")
public class WeatherIServiceImpl implements WeatherIService {

	private Logger logger = Logger.getLogger(this.getClass());
	
    @Resource(name="WeatherIDAO")
    private WeatherIDAO WeatherIDAO;
    
//	/** <!--  --> **/
//	public void deleteFileToDB(WeatherIVO param) throws Exception {
//		WeatherIDAO.deleteFileToDB(param);
//	}

	/** <!--  --> **/
	public void saveWorldFileToDB(WeatherIVO param) throws Exception {
		WeatherIDAO.saveWorldFileToDB(param);
	}
	
	/** <!--  --> **/
	public void saveLandFileToDB(WeatherIVO param) throws Exception {
		WeatherIDAO.saveLandFileToDB(param);
	}
	
}
