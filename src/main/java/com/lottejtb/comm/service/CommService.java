package com.lottejtb.comm.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;


public interface CommService {

	/**
	 * 게시물 목록정보
	 * @param sqlId
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	public List selectList(String sqlId, Map searchMap) throws Exception;
	
	/**
	 * 게시물의 전체목록 갯수
	 * @param searchMap
	 * @return
	 * @throws Exception
	 */
	public int selectListTotCnt(String sqlId, Map searchMap) throws Exception;
	
	/**
	 * 코드 및 단순조회
	 * @param sqlId
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map select(String sqlId, Map map) throws Exception;
}
