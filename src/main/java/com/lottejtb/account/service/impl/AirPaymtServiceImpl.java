package com.lottejtb.account.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.lottejtb.account.service.AirActPaymtVO;
import com.lottejtb.account.service.AirCardPaymtVO;
import com.lottejtb.account.service.AirEtcPaymtVO;
import com.lottejtb.account.service.AirGiftPaymtVO;
import com.lottejtb.account.service.AirPaymentVO;
import com.lottejtb.account.service.AirPaymtService;
import com.lottejtb.account.service.AirReceiptReqVO;
import com.lottejtb.account.service.AirRefundMgtVO;
import com.lottejtb.account.service.AirRsvPaymtVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("AirPaymtService")
public class AirPaymtServiceImpl extends EgovAbstractServiceImpl implements AirPaymtService {

	private static final Logger logger = Logger.getLogger(AirPaymtServiceImpl.class);
	
	@Resource(name="AirPaymtDAO")
	private AirPaymtDAO airPaymtDAO;

	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
	@Override
	public void saveAirActPaymt(AirActPaymtVO vo) throws Exception {
		// TODO Auto-generated method stub
		airPaymtDAO.saveAirActPaymt(vo);
	}

	@Override
	public void saveAirCardPaymt(AirCardPaymtVO vo) throws Exception {
		// TODO Auto-generated method stub
		airPaymtDAO.saveAirCardPaymt(vo);
	}

	@Override
	public void saveAirEtcPaymt(AirEtcPaymtVO vo) throws Exception {
		// TODO Auto-generated method stub
		airPaymtDAO.saveAirEtcPaymt(vo);
	}

	@Override
	public void saveAirGiftPaymt(AirGiftPaymtVO vo) throws Exception {
		// TODO Auto-generated method stub
		airPaymtDAO.saveAirGiftPaymt(vo);
	}

	@Override
	public void saveAirRsvPaymt(AirRsvPaymtVO vo) throws Exception {
		// TODO Auto-generated method stub
		airPaymtDAO.saveAirRsvPaymt(vo);
	}

	@Override
	public void saveAirReceiptReq(AirReceiptReqVO vo) throws Exception {
		// TODO Auto-generated method stub
		airPaymtDAO.saveAirReceiptReq(vo);
	}

	@Override
	public void saveAirRefundMgt(AirRefundMgtVO vo) throws Exception {
		// TODO Auto-generated method stub
		airPaymtDAO.saveAirRefundMgt(vo);
	}

	@Override
	public void saveUpdateCancelYnAirFitRsvMst(AirRefundMgtVO vo) throws Exception {
		// TODO Auto-generated method stub
		airPaymtDAO.saveUpdateCancelYnAirFitRsvMst(vo);
	}

	@Override
	public void updateAirRsvMst(int airRsvSeqno) throws Exception {
		// TODO Auto-generated method stub
		airPaymtDAO.updateAirRsvMst(airRsvSeqno);
	}

	@Override
	public List<AirPaymentVO> selectAirPayment(String fitRsvNo)
			throws Exception {
		// TODO Auto-generated method stub
		return (List<AirPaymentVO>) airPaymtDAO.selectAirPayment(fitRsvNo);
	}
	
}
