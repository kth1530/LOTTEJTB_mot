package com.lottejtb.front.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.lottejtb.api.service.FURTI0001ResultVO;
import com.lottejtb.front.rentcar.service.RsvRentcarVO;

public interface RentalcarService {
	ArrayList<RentalcarVO> selectListRentalcar (RentalcarVO rntVo) throws Exception;
	ArrayList<RentalcarVO> selectRentalcarInfo (RentalcarVO rntVo) throws Exception;
	List selectListPlace (HashMap<String, Object> parameter) throws Exception;
	List selectRentOffice(HashMap<String, Object> parameter) throws Exception;
	FURTI0001ResultVO selectRentCarList(ReqRentcarVO rntVo) throws Exception;
	List reserveRentalCar(ReqMstReserveVO reqVO, String fitRsvNo) throws Exception;
	List selectRentcarRsvList(RsvRentcarVO resVO) throws Exception;
	HashMap<String, Object> reserveCancelRentalCar(FreeCancelReserveVO vo) throws Exception;
}
