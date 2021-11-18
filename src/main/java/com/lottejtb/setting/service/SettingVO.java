package com.lottejtb.setting.service;

import com.lottejtb.comm.service.CommDefaultVO;

public class SettingVO{
	private String osType;			// OS 타입
	private int versionNo;			// 앱버전
	private String version;			// 앱버전명
	private String keyHashCode;		// 키 해쉬값
	
	private String deviceId;		// 디바이스 아이디
	private String marketingYn;		// 마케팅 수신여부
	private String deviceModel;
	private String osVersion;
	private String deviceToken;
	
	public String getOsType() {
		return osType;
	}
	public void setOsType(String osType) {
		this.osType = osType;
	}
	public int getVersionNo() {
		return versionNo;
	}
	public void setVersionNo(int versionNo) {
		this.versionNo = versionNo;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getKeyHashCode() {
		return keyHashCode;
	}
	public void setKeyHashCode(String keyHashCode) {
		this.keyHashCode = keyHashCode;
	}
	public String getDeviceId() {
		return deviceId;
	}
	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}
	public String getMarketingYn() {
		return marketingYn;
	}
	public void setMarketingYn(String marketingYn) {
		this.marketingYn = marketingYn;
	}
	public String getDeviceModel() {
		return deviceModel;
	}
	public void setDeviceModel(String deviceModel) {
		this.deviceModel = deviceModel;
	}
	public String getOsVersion() {
		return osVersion;
	}
	public void setOsVersion(String osVersion) {
		this.osVersion = osVersion;
	}
	public String getDeviceToken() {
		return deviceToken;
	}
	public void setDeviceToken(String deviceToken) {
		this.deviceToken = deviceToken;
	}
}	
