package com.lottejtb.front.rentcar.service;

import java.util.ArrayList;
import java.util.List;

public interface RentalcarService {
	List<?> selectListRentPlace(String sVal) throws Exception;
	ArrayList<RentalcarVO> selectListRentalcar (RentalcarVO rntVo) throws Exception;
	ArrayList<RentalcarVO> selectRentalcarInfo (RentalcarVO rntVo) throws Exception;
	ArrayList<RentalcarVO> selectListPlace (RentalcarVO rntVo) throws Exception;
}
