package com.lottejtb.setting.service;


public interface SettingService {
	
	/**
	 * 앱 버전/무결성 체크
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public SettingVO selectAppCheck(SettingVO vo) throws Exception;	
	
	/**
	 * 마케팅 수신여부 등록
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public void insertMarketingReceiveYn(SettingVO vo) throws Exception;
	
	/**
	 * 마케팅 수신여부 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public SettingVO selectMarketingReceiveYn(SettingVO vo) throws Exception;
	
	/**
	 * 마케팅 수신정보 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int selectMarketingReceiveCnt(SettingVO vo) throws Exception;
	
	/**
	 * 마케팅 수신여부 수정
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public void updateMarketingReceiveYn(SettingVO vo) throws Exception;
}
