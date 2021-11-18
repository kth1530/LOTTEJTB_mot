package com.lottejtb.comm.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("commDao")
@SuppressWarnings("unchecked")
public class CommDao extends EgovAbstractDAO {
	private final String SQL_KEY = "sqlKey";
	
	/**
	 * 등록한다.
	 * @param vo - 등록할 정보가 담긴 Map
	 * @return 등록 결과
	 * @exception Exception
	 */
	public String insert(Map vo) throws SQLException {
		return (String)insert((String)vo.get(SQL_KEY), vo);
	}
	/**
	 * 등록한다.
	 * @param vo - 등록할 정보가 담긴 Map
	 * @return 등록 결과
	 * @exception Exception
	 */
	public String insert(String SQL_KEY, Map vo) throws SQLException {
		return (String)super.insert(SQL_KEY, vo);
	}

	/**
	 * 수정한다.
	 * @param vo - 수정할 정보가 담긴 Map
	 * @return void형
	 * @exception Exception
	 */
	public void update(Map vo) throws SQLException {
		update((String)vo.get(SQL_KEY), vo);
	}
	
	/**
	 * 수정한다
	 * @param SQL_KEY
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public int update(String SQL_KEY, Map vo) {
		return super.update(SQL_KEY, vo);
	}
	
	/**
	 * 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 Map
	 * @return void형
	 * @exception Exception
	 */
	public int delete(Map vo) throws SQLException {
		return delete((String)vo.get(SQL_KEY), vo);
	}
	/**
	 * 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 Map
	 * @return void형
	 * @exception Exception
	 */
	public int delete(String SQL_KEY, Map vo) throws SQLException  {
		int result = super.delete(SQL_KEY, vo);
		return result;
	}

	/**
	 * 조회한다.
	 * @param vo - 조회할 정보가 담긴 Map
	 * @return 조회한 글
	 * @exception Exception
	 */
	public Map select(Map vo) throws SQLException {
		return (Map) select((String)vo.get(SQL_KEY), vo);
	}
	/**
	 * 조회한다.
	 * @param vo - 조회할 정보가 담긴 Map
	 * @return 조회한 글
	 * @exception Exception
	 */
	public Map select(String SQL_KEY, Map vo) throws SQLException {
		return (Map) selectByPk(SQL_KEY, vo);
	}
	
	/**
	 * 조회한다.
	 * @param vo - 조회할 정보가 담긴 String
	 * @return 조회한 글
	 * @exception Exception
	 */
	public String selectKeyString(String SQL_KEY, Map vo) throws SQLException {
		return (String) selectByPk(SQL_KEY, vo);
	}
	
	/**
	 * 조회한다.
	 * @param vo - 조회할 정보가 담긴 VO
	 * @return 조회한 글
	 * @exception Exception
	 */
	public Object selectVo(String SQL_KEY, Map vo) throws SQLException {
		return (Object)selectByPk(SQL_KEY, vo);
	}
	
	public Object select(String SQL_KEY, String str) throws SQLException {
		return (Object) selectByPk(SQL_KEY, str);
	}
	
	/**
	 * 목록을 조회한다.
	 * @param SQL_KEY
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	public List selectList(String SQL_KEY, Map searchMap) throws SQLException {
		return list(SQL_KEY, searchMap);
	}


	/**
	 * 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectListTotCnt(Map searchMap) throws SQLException {
		String sqlKey = (String)searchMap.get(SQL_KEY);
		return (Integer)getSqlMapClientTemplate().queryForObject(sqlKey, searchMap);
	}
	/**
	 * 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectListTotCnt(String SQL_KEY, Map searchMap) throws SQLException {
		return (Integer)getSqlMapClientTemplate().queryForObject(SQL_KEY, searchMap);
	}
	
	
	/**
	 * 각종 ID를 생성한다.
	 * @param tableName
	 * @return
	 * @throws Exception
	 */
	public String nextId(String tableName) throws SQLException {
		return nextId(tableName, false);
	}
	
	/**
	 * 각종 ID를 생성한다.
	 * @param tableName
	 * @param date : true일 경우 TO_CHAR(SYSDATE, 'YYYYMMDD') || '_' 가 추가된다.
	 * @return
	 * @throws Exception
	 */
	public String nextId(String tableName, boolean date) throws SQLException {
		Map vo = new HashMap();
		vo.put("TABLE_NAME", tableName);
		vo.put("DATE", date?"1":"0");
		return nextId(vo);
	}
	
	public String nextId(Map vo) throws SQLException {
		String result = (String) selectByPk("commonId_select", vo);
		if(result==null) {
			insert("commonId_insert", vo);
		}
		else {
			update("commonId_update", vo);
		}
		return (String) selectByPk("commonId_select", vo);
	}
}

