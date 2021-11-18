package com.lottejtb.push.service;

/*
 *  푸시 전송 parameter
 */
public class SendPushVO {
	private String noSeq;	
	private String title;		/*title*/
	private String message;		/*전송 메시지*/
	private String tagetUrl;   	/*링크 연결 */
	private String startDt;		/*예약일시 컬럼*/
	private String insDt;
	private String insId;
	private String updDt;
	private String updId;
	private String pushYn;  //푸시 여부
	
	public String getNoSeq() {
		return noSeq;
	}
	public void setNoSeq(String noSeq) {
		this.noSeq = noSeq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getTagetUrl() {
		return tagetUrl;
	}
	public void setTagetUrl(String tagetUrl) {
		this.tagetUrl = tagetUrl;
	}
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getInsDt() {
		return insDt;
	}
	public void setInsDt(String insDt) {
		this.insDt = insDt;
	}
	public String getInsId() {
		return insId;
	}
	public void setInsId(String insId) {
		this.insId = insId;
	}
	public String getUpdDt() {
		return updDt;
	}
	public void setUpdDt(String updDt) {
		this.updDt = updDt;
	}
	public String getUpdId() {
		return updId;
	}
	public void setUpdId(String updId) {
		this.updId = updId;
	}
	public String getPushYn() {
		return pushYn;
	}
	public void setPushYn(String pushYn) {
		this.pushYn = pushYn;
	}
}
