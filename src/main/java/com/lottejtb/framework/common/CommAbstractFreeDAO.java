package com.lottejtb.framework.common;

import javax.annotation.Resource;

import com.ibatis.sqlmap.client.SqlMapClient;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

public class CommAbstractFreeDAO extends EgovAbstractDAO{
	
	@Resource(name="sqlMapClient_free")
	public void setSuperSqlMapClient(SqlMapClient sqlMapClient_free){
		super.setSuperSqlMapClient(sqlMapClient_free);
	}
}
