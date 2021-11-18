package com.lottejtb.front.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.lottejtb.framework.common.CommAbstractFreeDAO;
import com.lottejtb.front.rentcar.service.RsvRentcarVO;
import com.lottejtb.front.service.RentalcarVO;

@Repository("RentalcarDAO")
public class RentalcarDAO extends CommAbstractFreeDAO {

	public ArrayList<RentalcarVO> selectListRentalcar (RentalcarVO rntVo) {
		return null;
	}

	public ArrayList<RentalcarVO> selectRentalcarInfo (RentalcarVO rntVo) {
		return null;
	}
	
	public List selectListPlace (HashMap<String, Object> parameter) {
		return list("CommCdCityDAO.selectRentCityList", parameter);
	}
	
	public List selectRentOffice(HashMap<String, Object> parameter) {
		return list("RentalCarDAO.selectRentOffice", parameter);
	}
	
	public List selectRentcarRsvList(RsvRentcarVO resVO){
		return list("RentalCarDAO.selectRentcarRsvList", resVO);
	}
}
