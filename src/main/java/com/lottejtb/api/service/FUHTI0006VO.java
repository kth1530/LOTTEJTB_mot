package com.lottejtb.api.service;

/*
 * 호텔 취소정책(WHC)
 */

public class FUHTI0006VO {
	
	private String code;       //1:성공 그외 오류
	private String message;    //결과 메시지
	private Data data = new FUHTI0006VO.Data();
	
	private static class Data {
		private String cancelDl; 	//추소마감일자
		private String cancelJtbDl;
		private String refundAllowYn;   //
		private String currency;	//통화코드
		private String amount; 		//취소위약금
		private String cancelDesc;  //취소정책
		public String getCancelDl() {
			return cancelDl;
		}
		public void setCancelDl(String cancelDl) {
			this.cancelDl = cancelDl;
		}
		public String getCancelJtbDl() {
			return cancelJtbDl;
		}
		public void setCancelJtbDl(String cancelJtbDl) {
			this.cancelJtbDl = cancelJtbDl;
		}
		public String getRefundAllowYn() {
			return refundAllowYn;
		}
		public void setRefundAllowYn(String refundAllowYn) {
			this.refundAllowYn = refundAllowYn;
		}
		public String getCurrency() {
			return currency;
		}
		public void setCurrency(String currency) {
			this.currency = currency;
		}
		public String getAmount() {
			return amount;
		}
		public void setAmount(String amount) {
			this.amount = amount;
		}
		public String getCancelDesc() {
			return cancelDesc;
		}
		public void setCancelDesc(String cancelDesc) {
			this.cancelDesc = cancelDesc;
		}
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Data getData() {
		return data;
	}

	public void setData(Data data) {
		this.data = data;
	}
	
	
	
	
}
