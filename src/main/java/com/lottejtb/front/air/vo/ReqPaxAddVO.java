package com.lottejtb.front.air.vo;

import java.util.ArrayList;

public class ReqPaxAddVO {
	
	private int 	rsvSeqno;			//항공 예약번호
	
	ArrayList<paxMileage>	mileageInfo	= new ArrayList<ReqPaxAddVO.paxMileage>();
	ArrayList<paxPassPort>	passportInfo= new ArrayList<ReqPaxAddVO.paxPassPort>();
	ArrayList<paxStay>		stayInfo	= new ArrayList<ReqPaxAddVO.paxStay>();
	ArrayList<paxContact>	contactInfo	= new ArrayList<ReqPaxAddVO.paxContact>();
	
	public static class paxMileage {
		private float 	paxNo;				//탑승자번호
		private String 	paxTy;				//탑승자유형
		private String 	mileageNo;			//마일리지 번호
		private String 	carrierCd;			//적립 항공사 코드
		private String 	sendYn;				//전송여부
		
		public float getPaxNo() {
			return paxNo;
		}
		public void setPaxNo(float paxNo) {
			this.paxNo = paxNo;
		}
		public String getPaxTy() {
			return paxTy;
		}
		public void setPaxTy(String paxTy) {
			this.paxTy = paxTy;
		}
		public String getMileageNo() {
			return mileageNo;
		}
		public void setMileageNo(String mileageNo) {
			this.mileageNo = mileageNo;
		}
		public String getCarrierCd() {
			return carrierCd;
		}
		public void setCarrierCd(String carrierCd) {
			this.carrierCd = carrierCd;
		}
		public String getSendYn() {
			return sendYn;
		}
		public void setSendYn(String sendYn) {
			this.sendYn = sendYn;
		}
	}
	
	public static class paxPassPort {
		private float 	paxNo;				//탑승자번호
		private String 	paxTy;				//탑승자유형
		private String 	passportNo;			//여권번호
		private String 	expiredt;			//여권만료일자
		private String 	ntCd;				//국적
		private String 	publishNtcd;		//발행국
		
		public float getPaxNo() {
			return paxNo;
		}
		public void setPaxNo(float paxNo) {
			this.paxNo = paxNo;
		}
		public String getPaxTy() {
			return paxTy;
		}
		public void setPaxTy(String paxTy) {
			this.paxTy = paxTy;
		}
		public String getPassportNo() {
			return passportNo;
		}
		public void setPassportNo(String passportNo) {
			this.passportNo = passportNo;
		}
		public String getExpiredt() {
			return expiredt;
		}
		public void setExpiredt(String expiredt) {
			this.expiredt = expiredt;
		}
		public String getNtCd() {
			return ntCd;
		}
		public void setNtCd(String ntCd) {
			this.ntCd = ntCd;
		}
		public String getPublishNtcd() {
			return publishNtcd;
		}
		public void setPublishNtcd(String publishNtcd) {
			this.publishNtcd = publishNtcd;
		}
	}
	
	public static class paxStay {
		private float 	paxNo;			//탑승자번호
		private String 	paxTy;			//탑승자유형
		private String 	ctCd;			//도시코드
		private String 	localContact;	//현지연락처
		private String 	paxContact;		//탑승객 연락처
		
		private String 	addressTy;			
		private String 	ntCd;
		private String 	ctCdNm;
		private String 	stateCd;
		private String 	postCd;
		private String 	address;
		private String 	undecidedYn;
		
		public float getPaxNo() {
			return paxNo;
		}
		public void setPaxNo(float paxNo) {
			this.paxNo = paxNo;
		}
		public String getPaxTy() {
			return paxTy;
		}
		public void setPaxTy(String paxTy) {
			this.paxTy = paxTy;
		}
		public String getCtCd() {
			return ctCd;
		}
		public void setCtCd(String ctCd) {
			this.ctCd = ctCd;
		}
		public String getLocalContact() {
			return localContact;
		}
		public void setLocalContact(String localContact) {
			this.localContact = localContact;
		}
		public String getPaxContact() {
			return paxContact;
		}
		public void setPaxContact(String paxContact) {
			this.paxContact = paxContact;
		}
		public String getAddressTy() {
			return addressTy;
		}
		public void setAddressTy(String addressTy) {
			this.addressTy = addressTy;
		}
		public String getNtCd() {
			return ntCd;
		}
		public void setNtCd(String ntCd) {
			this.ntCd = ntCd;
		}
		public String getCtCdNm() {
			return ctCdNm;
		}
		public void setCtCdNm(String ctCdNm) {
			this.ctCdNm = ctCdNm;
		}
		public String getStateCd() {
			return stateCd;
		}
		public void setStateCd(String stateCd) {
			this.stateCd = stateCd;
		}
		public String getPostCd() {
			return postCd;
		}
		public void setPostCd(String postCd) {
			this.postCd = postCd;
		}
		public String getAddress() {
			return address;
		}
		public void setAddress(String address) {
			this.address = address;
		}
		public String getUndecidedYn() {
			return undecidedYn;
		}
		public void setUndecidedYn(String undecidedYn) {
			this.undecidedYn = undecidedYn;
		}
	}
	
	public static class paxContact {
		private float 	paxNo;			//탑승자번호
		private String 	paxTy;			//탑승자유형
		private String 	ctCd;			//도시코드
		private String 	localContact;	//현지연락처
		private String 	paxContact;		//탑승객 연락처
		
		public float getPaxNo() {
			return paxNo;
		}
		public void setPaxNo(float paxNo) {
			this.paxNo = paxNo;
		}
		public String getPaxTy() {
			return paxTy;
		}
		public void setPaxTy(String paxTy) {
			this.paxTy = paxTy;
		}
		public String getCtCd() {
			return ctCd;
		}
		public void setCtCd(String ctCd) {
			this.ctCd = ctCd;
		}
		public String getLocalContact() {
			return localContact;
		}
		public void setLocalContact(String localContact) {
			this.localContact = localContact;
		}
		public String getPaxContact() {
			return paxContact;
		}
		public void setPaxContact(String paxContact) {
			this.paxContact = paxContact;
		}
	}

	public ArrayList<paxMileage> getMileageInfo() {
		return mileageInfo;
	}

	public void setMileageInfo(ArrayList<paxMileage> mileageInfo) {
		this.mileageInfo = mileageInfo;
	}

	public int getRsvSeqno() {
		return rsvSeqno;
	}

	public void setRsvSeqno(int rsvSeqno) {
		this.rsvSeqno = rsvSeqno;
	}

	public ArrayList<paxPassPort> getPassportInfo() {
		return passportInfo;
	}

	public void setPassportInfo(ArrayList<paxPassPort> passportInfo) {
		this.passportInfo = passportInfo;
	}

	public ArrayList<paxStay> getStayInfo() {
		return stayInfo;
	}

	public void setStayInfo(ArrayList<paxStay> stayInfo) {
		this.stayInfo = stayInfo;
	}

	public ArrayList<paxContact> getContactInfo() {
		return contactInfo;
	}

	public void setContactInfo(ArrayList<paxContact> contactInfo) {
		this.contactInfo = contactInfo;
	}
}
