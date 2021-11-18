package com.lottejtb.main.service;

import com.lottejtb.comm.service.CommDefaultVO;

public class MainVO extends CommDefaultVO {
    
    private int rn;       //번호
    private String userid;   //아이디 
    private String typeCd;   //구분코드
    private String empNo;    //사번
    private String admnm;    //관리자명
    private String ssn;      //주민번호
    private String stat;     //상태
    
    private String deviceId;
    private String custCd;
    private String deviceModel;
    private String osVersion;
    private String osType;
    private String deviceToken;
    
    public int getRn() {
        return rn;
    }
    public void setRn(int rn) {
        this.rn = rn;
    }
    
    public String getUserid() {
        return userid;
    }
    public void setUserid(String userid) {
        this.userid = userid;
    }
    public String getTypeCd() {
        return typeCd;
    }
    public void setTypeCd(String typeCd) {
        this.typeCd = typeCd;
    }
    public String getEmpNo() {
        return empNo;
    }
    public void setEmpNo(String empNo) {
        this.empNo = empNo;
    }
    public String getAdmnm() {
        return admnm;
    }
    public void setAdmnm(String admnm) {
        this.admnm = admnm;
    }
    public String getSsn() {
        return ssn;
    }
    public void setSsn(String ssn) {
        this.ssn = ssn;
    }
    public String getStat() {
        return stat;
    }
    public void setStat(String stat) {
        this.stat = stat;
    }
	public String getDeviceId() {
		return deviceId;
	}
	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}
	public String getCustCd() {
		return custCd;
	}
	public void setCustCd(String custCd) {
		this.custCd = custCd;
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
	public String getOsType() {
		return osType;
	}
	public void setOsType(String osType) {
		this.osType = osType;
	}
	public String getDeviceToken() {
		return deviceToken;
	}
	public void setDeviceToken(String deviceToken) {
		this.deviceToken = deviceToken;
	}   
}