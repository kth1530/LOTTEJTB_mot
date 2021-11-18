package com.lottejtb.schedule.service;

/**
* 클래스명    :  예약 관련 서비스를 정의한 인터페이스  
* @ClassDesc  : 예약 관련 서비스를 정의한 인터페이스  
* @FileName   : ReserveService.java
* @TableName  :
* @SpecDesc   : N/A
* @Author     : 
* @history 수정일자 / 수정자 / 수정내용
* 2016.11.25 /  / 최초작성
*/

public interface WeatherIService {

//	/** <!--  --> **/
//	public void deleteFileToDB(WeatherIVO param) throws Exception;

	/** <!--  --> **/
	public void saveWorldFileToDB(WeatherIVO param) throws Exception;
	
	/** <!--  --> **/
	public void saveLandFileToDB(WeatherIVO param) throws Exception;
	
}
