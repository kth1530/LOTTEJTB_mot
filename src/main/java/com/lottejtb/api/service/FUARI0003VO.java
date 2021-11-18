package com.lottejtb.api.service;

import java.util.ArrayList;
import java.util.Map;

public class FUARI0003VO {
	private HeaderVO headDto = new HeaderVO();
	private RsvPersonVO rsvPersonDto = new RsvPersonVO();
	private ArrayList<Map<Object, String>> itinData = new ArrayList<Map<Object,String>>();
	private ArrayList<AvailVO> availDto = new ArrayList<AvailVO>();
	private ArrayList<PaxVO> paxDto = new ArrayList<PaxVO>();
	private ArrayList<FareVO> fareDto = new ArrayList<FareVO>();
	
	private int errCd;
	private String errTy;
	private String errMsg;
	private String sysErrCd;
	private String programId;
	private ArrayList<Map<Object, String>> data = new ArrayList<Map<Object,String>>();
	
	public RsvPersonVO getRsvPersonDto() {
		return rsvPersonDto;
	}
	public void setRsvPersonDto(RsvPersonVO rsvPersonDto) {
		this.rsvPersonDto = rsvPersonDto;
	}
	public ArrayList<Map<Object, String>> getItinData() {
		return itinData;
	}
	public void setItinData(ArrayList<Map<Object, String>> itinData) {
		this.itinData = itinData;
	}
	public ArrayList<AvailVO> getAvailDto() {
		return availDto;
	}
	public void setAvailDto(ArrayList<AvailVO> availDto) {
		this.availDto = availDto;
	}
	public ArrayList<PaxVO> getPaxDto() {
		return paxDto;
	}
	public void setPaxDto(ArrayList<PaxVO> paxDto) {
		this.paxDto = paxDto;
	}
	public ArrayList<FareVO> getFareDto() {
		return fareDto;
	}
	public void setFareDto(ArrayList<FareVO> fareDto) {
		this.fareDto = fareDto;
	}
	public HeaderVO getHeadDto() {
		return headDto;
	}
	public void setHeadDto(HeaderVO headDto) {
		this.headDto = headDto;
	}
	public int getErrCd() {
		return errCd;
	}
	public void setErrCd(int errCd) {
		this.errCd = errCd;
	}
	public String getErrTy() {
		return errTy;
	}
	public void setErrTy(String errTy) {
		this.errTy = errTy;
	}
	public String getErrMsg() {
		return errMsg;
	}
	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}
	public String getSysErrCd() {
		return sysErrCd;
	}
	public void setSysErrCd(String sysErrCd) {
		this.sysErrCd = sysErrCd;
	}
	public String getProgramId() {
		return programId;
	}
	public void setProgramId(String programId) {
		this.programId = programId;
	}
	public ArrayList<Map<Object, String>> getData() {
		return data;
	}
	public void setData(ArrayList<Map<Object, String>> data) {
		this.data = data;
	}	
}
