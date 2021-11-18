package com.lottejtb.account.service;

/**
 * 결제 VO
 */
public class PaymentVO {
	
	public PaymentVO() {}
	
	/**
	 * 예약번호
	 */	
	private String resCd;

	/**
	 * 버전
	 */	
	private String version;
	
	/**
	 * 상점아이디
	 */
	private String mId;
	
	/**
	 * 가맹점에 제공된 웹 표준 사인키(가맹점 수정후 고정)
	 */
	private String signKey;
	
	/**
	 * 상품명
	 */
	private String goodName;
	
	/**
	 * 주문번호
	 */
	private String oId;
	
	/**
	 * 결제금액
	 */
	private String price;
	
	/**
	 * 통화구분
	 */
	private String currency;
	
	/**
	 * 구매자명
	 */
	private String buyerName;
	
	/**
	 * 구매자 이메일
	 */
	private String buyerEmail;
	
	/**
	 * 구매자 Mobile 번호
	 */
	private String buyerTel;
	
	/**
	 * 타임스탬프
	 */
	private String timeStamp;
	
	/**
	 * signature
	 */
	private String signature;
	
	/**
	 * 리턴Url(인증결과수신Url)
	 */
	private String returnUrl;
	
	/**
	 * signkey에 대한 hash값
	 */
	private String mKey;

	/**
	 * 요청결제수단
	 */
	private String goPayMethod;
	
	/**
	 * 제공기간
	 */
	private String offerPeriod;
	
	/**
	 * 결제수단별 추가 옵션값
	 */
	private String acceptMethod;
	
	/**
	 * 초기 표시 언어
	 */
	private String languageView;
	
	/**
	 * 결과 인코딩
	 */
	private String charset;
	
	/**
	 * 결제창 표시방법
	 */
	private String payViewType;
	
	/**
	 * 결제창닫기처리Url
	 */
	private String closeUrl;
	
	/**
	 * 할부 개월
	 */
	private String quotaBase;
	
	/**
	 * 중복 카드 코드
	 */
	private String iniOnlyCardCode;
	
	/**
	 * 카드 코드
	 */
	private String iniCardCode;
	
	/**
	 * 할부 선택
	 */
	private String ansimQuota;
	
	/**
	 * 가상계좌
	 */
	private String vbankRegNo;
	
	/**
	 * 가맹점 관리데이터
	 */
	private String merchantData;
	
	/**
	 * 거래번호
	 */
	private String tId;
	
	/**
	 * 취소사유
	 */
	private String msg;
	
	/**
	 * 사이트 도메인
	 */
	private String siteDomain;

	/**
	 * payViewType='popup'시 팝업을 띄울수 있도록 처리해주는 URL(가맹점에 맞게 설정)
	 */
	private String popupUrl;
	
	/**
	 * 거래 성공 여부
	 */
	private Boolean isSuccDeal;

	/**
	 * 결과 코드
	 */
	private String resultCode;
	
	/**
	 * 결과 메시지
	 */
	private String resultMsg;
	
	// 가상계좌 관련정보
	private VAcctDepoNotiVO vacctVo;

	/**
	 * @return the version
	 */
	public String getVersion() {
		return version;
	}

	/**
	 * 취소날짜
	 */
	private String cancelDate;
	
	/**
	 * 취소시각
	 */
	private String cancelTime;
	
	/**
	 * 현금영수증 취소 승인번호(현금영수증 발급 취소시에만 리턴됨)
	 */
	private String cshrCancelNum;
	
	/**
	 * 결과 메시지
	 */
	private String hotelpassData;
	
	/**
	 * @return the mId
	 */
	public String getResCd() {
		return resCd;
	}

	/**
	 * @param mId the mId to set
	 */
	public void setResCd(String resCd) {
		this.resCd = resCd;
	}

	/**
	 * @return the mId
	 */
	public String getmId() {
		return mId;
	}

	/**
	 * @param mId the mId to set
	 */
	public void setmId(String mId) {
		this.mId = mId;
	}

	/**
	 * @return the signKey
	 */
	public String getSignKey() {
		return signKey;
	}

	/**
	 * @param signKey the signKey to set
	 */
	public void setSignKey(String signKey) {
		this.signKey = signKey;
	}

	/**
	 * @return the goodName
	 */
	public String getGoodName() {
		return goodName;
	}

	/**
	 * @param goodName the goodName to set
	 */
	public void setGoodName(String goodName) {
		this.goodName = goodName;
	}

	/**
	 * @return the oId
	 */
	public String getoId() {
		return oId;
	}

	/**
	 * @param oId the oId to set
	 */
	public void setoId(String oId) {
		this.oId = oId;
	}

	/**
	 * @return the price
	 */
	public String getPrice() {
		return price;
	}

	/**
	 * @param price the price to set
	 */
	public void setPrice(String price) {
		this.price = price;
	}

	/**
	 * @return the currency
	 */
	public String getCurrency() {
		return currency;
	}

	/**
	 * @param currency the currency to set
	 */
	public void setCurrency(String currency) {
		this.currency = currency;
	}

	/**
	 * @return the buyerName
	 */
	public String getBuyerName() {
		return buyerName;
	}

	/**
	 * @param buyerName the buyerName to set
	 */
	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
	}

	/**
	 * @return the buyerEmail
	 */
	public String getBuyerEmail() {
		return buyerEmail;
	}

	/**
	 * @param buyerEmail the buyerEmail to set
	 */
	public void setBuyerEmail(String buyerEmail) {
		this.buyerEmail = buyerEmail;
	}

	/**
	 * @return the buyerTel
	 */
	public String getBuyerTel() {
		return buyerTel;
	}

	/**
	 * @param buyerTel the buyerTel to set
	 */
	public void setBuyerTel(String buyerTel) {
		this.buyerTel = buyerTel;
	}

	/**
	 * @return the timeStamp
	 */
	public String getTimeStamp() {
		return timeStamp;
	}

	/**
	 * @param timeStamp the timeStamp to set
	 */
	public void setTimeStamp(String timeStamp) {
		this.timeStamp = timeStamp;
	}

	/**
	 * @return the signature
	 */
	public String getSignature() {
		return signature;
	}

	/**
	 * @param signature the signature to set
	 */
	public void setSignature(String signature) {
		this.signature = signature;
	}

	/**
	 * @return the returnUrl
	 */
	public String getReturnUrl() {
		return returnUrl;
	}

	/**
	 * @param returnUrl the returnUrl to set
	 */
	public void setReturnUrl(String returnUrl) {
		this.returnUrl = returnUrl;
	}

	/**
	 * @return the mKey
	 */
	public String getmKey() {
		return mKey;
	}

	/**
	 * @param mKey the mKey to set
	 */
	public void setmKey(String mKey) {
		this.mKey = mKey;
	}

	/**
	 * @return the goPayMethod
	 */
	public String getGoPayMethod() {
		return goPayMethod;
	}

	/**
	 * @param goPayMethod the goPayMethod to set
	 */
	public void setGoPayMethod(String goPayMethod) {
		this.goPayMethod = goPayMethod;
	}

	/**
	 * @return the offerPeriod
	 */
	public String getOfferPeriod() {
		return offerPeriod;
	}

	/**
	 * @param offerPeriod the offerPeriod to set
	 */
	public void setOfferPeriod(String offerPeriod) {
		this.offerPeriod = offerPeriod;
	}

	/**
	 * @return the acceptMethod
	 */
	public String getAcceptMethod() {
		return acceptMethod;
	}

	/**
	 * @param acceptMethod the acceptMethod to set
	 */
	public void setAcceptMethod(String acceptMethod) {
		this.acceptMethod = acceptMethod;
	}

	/**
	 * @return the languageView
	 */
	public String getLanguageView() {
		return languageView;
	}

	/**
	 * @param languageView the languageView to set
	 */
	public void setLanguageView(String languageView) {
		this.languageView = languageView;
	}

	/**
	 * @return the charset
	 */
	public String getCharset() {
		return charset;
	}

	/**
	 * @param charset the charset to set
	 */
	public void setCharset(String charset) {
		this.charset = charset;
	}

	/**
	 * @return the payViewType
	 */
	public String getPayViewType() {
		return payViewType;
	}

	/**
	 * @param payViewType the payViewType to set
	 */
	public void setPayViewType(String payViewType) {
		this.payViewType = payViewType;
	}

	/**
	 * @return the closeUrl
	 */
	public String getCloseUrl() {
		return closeUrl;
	}

	/**
	 * @param closeUrl the closeUrl to set
	 */
	public void setCloseUrl(String closeUrl) {
		this.closeUrl = closeUrl;
	}

	/**
	 * @return the quotaBase
	 */
	public String getQuotaBase() {
		return quotaBase;
	}

	/**
	 * @param quotaBase the quotaBase to set
	 */
	public void setQuotaBase(String quotaBase) {
		this.quotaBase = quotaBase;
	}

	/**
	 * @return the iniOnlyCardCode
	 */
	public String getIniOnlyCardCode() {
		return iniOnlyCardCode;
	}

	/**
	 * @param iniOnlyCardCode the iniOnlyCardCode to set
	 */
	public void setIniOnlyCardCode(String iniOnlyCardCode) {
		this.iniOnlyCardCode = iniOnlyCardCode;
	}

	/**
	 * @return the iniCardCode
	 */
	public String getIniCardCode() {
		return iniCardCode;
	}

	/**
	 * @param iniCardCode the iniCardCode to set
	 */
	public void setIniCardCode(String iniCardCode) {
		this.iniCardCode = iniCardCode;
	}

	/**
	 * @return the ansimQuota
	 */
	public String getAnsimQuota() {
		return ansimQuota;
	}

	/**
	 * @param ansimQuota the ansimQuota to set
	 */
	public void setAnsimQuota(String ansimQuota) {
		this.ansimQuota = ansimQuota;
	}

	/**
	 * @return the vbankRegNo
	 */
	public String getVbankRegNo() {
		return vbankRegNo;
	}

	/**
	 * @param vbankRegNo the vbankRegNo to set
	 */
	public void setVbankRegNo(String vbankRegNo) {
		this.vbankRegNo = vbankRegNo;
	}

	/**
	 * @return the merchantData
	 */
	public String getMerchantData() {
		return merchantData;
	}

	/**
	 * @param merchantData the merchantData to set
	 */
	public void setMerchantData(String merchantData) {
		this.merchantData = merchantData;
	}

	/**
	 * @return the tId
	 */
	public String gettId() {
		return tId;
	}

	/**
	 * @param tId the tId to set
	 */
	public void settId(String tId) {
		this.tId = tId;
	}

	/**
	 * @return the msg
	 */
	public String getMsg() {
		return msg;
	}

	/**
	 * @param msg the msg to set
	 */
	public void setMsg(String msg) {
		this.msg = msg;
	}

	/**
	 * @return the siteDomain
	 */
	public String getSiteDomain() {
		return siteDomain;
	}

	/**
	 * @param siteDomain the siteDomain to set
	 */
	public void setSiteDomain(String siteDomain) {
		this.siteDomain = siteDomain;
	}

	/**
	 * @return the popupUrl
	 */
	public String getPopupUrl() {
		return popupUrl;
	}

	/**
	 * @param popupUrl the popupUrl to set
	 */
	public void setPopupUrl(String popupUrl) {
		this.popupUrl = popupUrl;
	}

	/**
	 * @return the isSuccDeal
	 */
	public Boolean getIsSuccDeal() {
		return isSuccDeal;
	}

	/**
	 * @param isSuccDeal the isSuccDeal to set
	 */
	public void setIsSuccDeal(Boolean isSuccDeal) {
		this.isSuccDeal = isSuccDeal;
	}

	/**
	 * @return the resultCode
	 */
	public String getResultCode() {
		return resultCode;
	}

	/**
	 * @param resultCode the resultCode to set
	 */
	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}

	/**
	 * @return the resultMsg
	 */
	public String getResultMsg() {
		return resultMsg;
	}

	/**
	 * @param resultMsg the resultMsg to set
	 */
	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}

	/**
	 * @return the cancelDate
	 */
	public String getCancelDate() {
		return cancelDate;
	}

	/**
	 * @param cancelDate the cancelDate to set
	 */
	public void setCancelDate(String cancelDate) {
		this.cancelDate = cancelDate;
	}

	/**
	 * @return the cancelTime
	 */
	public String getCancelTime() {
		return cancelTime;
	}

	/**
	 * @param cancelTime the cancelTime to set
	 */
	public void setCancelTime(String cancelTime) {
		this.cancelTime = cancelTime;
	}

	/**
	 * @return the cshrCancelNum
	 */
	public String getCshrCancelNum() {
		return cshrCancelNum;
	}

	/**
	 * @param cshrCancelNum the cshrCancelNum to set
	 */
	public void setCshrCancelNum(String cshrCancelNum) {
		this.cshrCancelNum = cshrCancelNum;
	}

	/**
	 * @param version the version to set
	 */
	public void setVersion(String version) {
		this.version = version;
	}

	public VAcctDepoNotiVO getVacctVo() {
		return vacctVo;
	}

	public void setVacctVo(VAcctDepoNotiVO vacctVo) {
		this.vacctVo = vacctVo;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("PaymentVO [version=").append(version).append(", mId=").append(mId).append(", signKey=")
				.append(signKey).append(", goodName=").append(goodName).append(", oId=").append(oId).append(", price=")
				.append(price).append(", currency=").append(currency).append(", buyerName=").append(buyerName)
				.append(", buyerEmail=").append(buyerEmail).append(", buyerTel=").append(buyerTel)
				.append(", timeStamp=").append(timeStamp).append(", signature=").append(signature)
				.append(", returnUrl=").append(returnUrl).append(", mKey=").append(mKey).append(", goPayMethod=")
				.append(goPayMethod).append(", offerPeriod=").append(offerPeriod).append(", acceptMethod=")
				.append(acceptMethod).append(", languageView=").append(languageView).append(", charset=")
				.append(charset).append(", payViewType=").append(payViewType).append(", closeUrl=").append(closeUrl)
				.append(", quotaBase=").append(quotaBase).append(", iniOnlyCardCode=").append(iniOnlyCardCode)
				.append(", iniCardCode=").append(iniCardCode).append(", ansimQuota=").append(ansimQuota)
				.append(", vbankRegNo=").append(vbankRegNo).append(", merchantData=").append(merchantData)
				.append(", tId=").append(tId).append(", msg=").append(msg).append(", siteDomain=").append(siteDomain)
				.append(", popupUrl=").append(popupUrl).append(", isSuccDeal=").append(isSuccDeal)
				.append(", resultCode=").append(resultCode).append(", resultMsg=").append(resultMsg)
				.append(", cancelDate=").append(cancelDate).append(", cancelTime=").append(cancelTime)
				.append(", cshrCancelNum=").append(cshrCancelNum).append("]");
		return builder.toString();
	}

	public String getHotelpassData() {
		return hotelpassData;
	}

	public void setHotelpassData(String hotelpassData) {
		this.hotelpassData = hotelpassData;
	}

}
