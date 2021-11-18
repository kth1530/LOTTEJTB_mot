package com.lottejtb.schedule.service.impl;

import org.springframework.stereotype.Repository;

import com.lottejtb.framework.common.CommAbstractDAO;
import com.lottejtb.schedule.service.WeatherIVO;

@Repository("WeatherIDAO")
public class WeatherIDAO extends CommAbstractDAO {

//	/** <!--   --> **/
//	public void deleteFileToDB(WeatherIVO param) throws Exception {
//		delete("GoodsDAO.deleteFileToDB", param);
//	}

	/** <!--   --> **/
	public void saveWorldFileToDB(WeatherIVO param) throws Exception {
		update("GoodsDAO.saveWorldFileToDB", param);
	}

	/** <!--   --> **/
	public void saveLandFileToDB(WeatherIVO param) throws Exception {
		update("GoodsDAO.saveLandFileToDB", param);
	}

}
