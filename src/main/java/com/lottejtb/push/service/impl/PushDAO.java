package com.lottejtb.push.service.impl;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.lottejtb.framework.common.CommAbstractDAO;
import com.lottejtb.push.service.PushInfoVO;
import com.lottejtb.push.service.SendPushLog;
import com.lottejtb.push.service.SendPushVO;
import com.lottejtb.reserve.service.ReserveRosterVO;

@Repository("PushDAO")
public class PushDAO extends CommAbstractDAO {
	
	public List<PushInfoVO> getPushInfo(PushInfoVO vo) throws SQLException {
		return (List<PushInfoVO>)list("PushDAO.getPushInfo", vo);
	}
	
	
	/* 푸시 정보 */
	public List<SendPushVO> sendPushInfo(SendPushVO vo) throws SQLException {
		return (List<SendPushVO>) list("PushDAO.sendPushInfo", vo);
	}
	
	/* 푸시 로그*/
	public List sendPushLog(SendPushLog vo) throws SQLException {
		return (List<SendPushLog>) list("PushDAO.sendPushLog", vo);
	}
	
	/*푸시 성공여부 */
	public void sendPushYn(SendPushVO vo) throws SQLException {
		update("PushDAO.sendPushYn", vo);
	}
	
	/*푸시 성공여부 */
	public void delPushToken(PushInfoVO vo) throws SQLException {
		update("PushDAO.delPushToken", vo);
	}

	/** 푸시 통계 insert **/
	public void insertPushCnt(PushInfoVO param) throws Exception {
		insert("PushDAO.insertPushCnt", param);
	}	
	
}