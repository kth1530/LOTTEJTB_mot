package com.lottejtb.comm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lottejtb.comm.service.CommCdVO;
import com.lottejtb.framework.common.CommAbstractFreeDAO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("CommCdDAO")
public class CommCdDAO extends CommAbstractFreeDAO {
	
	public List<CommCdVO> selectCdList(CommCdVO cdVO) {
		return (List<CommCdVO>) list("CommCdDAO.selectCdList", cdVO);
	}
}