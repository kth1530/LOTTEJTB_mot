package com.lottejtb.front.service;

import org.apache.commons.lang.builder.ToStringBuilder;

public class ReqRentcarVO {
	/* 공통 대륙 , 국가 , 도시코드 */
    private String contCode;      //대륙코드
    private String countryCode;   //공통 국가코드 ( 검색시 사용 )
    private String country;
    private String cityCode;      //공통 도시코드 
    
    /* 검색 Pramameter 정보 */
    private String sdate;             //체크인 날짜와 시간
    private String pickupDate;
    private String stime;                   //체크인 시간
    private String pickupTime;
    private String edate;            //체크아웃 날짜와 시간
    private String returnDate;
    private String etime;            //체크아웃 날짜와 시간
    private String returnTime;
    
    private long duration;                      //사용기간 
    
    private String syyyy;
    private String smm;
    private String sdd;
    private String eyyyy;
    private String emm;
    private String edd;
   
    private int uniqueNum = 0;
    private String venderId;    // 영업소 벤더 아이디 
    private String oagCode;     // 영업소 고유 코드
    private String pickupOagCode;
    private String returnOagCode;
    private String saleNm;      // 영업소 명 ( description_location_name 으로 함 )
    private String zipCode;     // 영업소 우편번호
    private String addr;        // 영업소 주소 
    private String tel;       // 영업소 전화번호
    private String fax;       // 영업소 fax
    private String hgoMsg;     //호텔 투숙객 전용 영업소 메시지
    private String pflMsg;     //개인 전용기 탑승 고객용 영업소 메시지
    private String wnaMsg;		//항공편 도착 고객 전용 영업소 메시지
    
    private String openMon;    // 월요일 오픈 시간
    private String closeMon;   // 월요일 close 시간
    private String openTue;    // 화요일 오픈 시간
    private String closeTue;   // 화요일 close 시간
    private String openWed;    // 수요일 오픈 시간
    private String closeWed;   // 수요일 close 시간
    private String openThu;    // 목요일 오픈 시간
    private String closeThu;   // 목요일 close 시간
    private String openFri;    // 금요일 오픈 시간
    private String closeFri;   // 수요일 close 시간
    private String openSat;    // 토요일 오픈 시간
    private String closeSat;   // 토요일 close 시간
    private String openSun;    // 일요일 오픈 시간
    private String closeSun;   // 일요일 close 시간
    
    private String lat;    //위도
    private String longi;  //경도
    
    /* xml return value */
    /* 해당 영업소 렌트카 검색 리스트 Loop 변수 */
    private String referId;  //이것은 어떤 비율이 선택되었는지를 식별하는 데 사용되는 비율 식별 코드입니다. 이 코드는 예약 요청 (VehResRQ)에서 Hertz로 다시 에코됩니다.
    private String referType;  //참조 번호가 선택한 요율을 식별하는 데 사용됨을 나타냅니다 보통 16
    private String sucess;  //성공 실패 여부
    private String msg;  //실패시 메세지 
    private String warning;  // 자문 텍스트 메세지
    private String pickupDateTime;
    private String returnDateTime;
    private String pickupExtLoc;
    private String returnExtLoc;
    private String pickupLoc;
    private String returnLoc;
    private String vendorCode;
    private String IsAlternateInd;  // 차량이 UPSELL 여부
    private String passengerCnt;  // 차량 인원 수용 수
    private String baggageCnt;    // 차량 수화물 수용 수
    private String airCondition;    // 에어컨 유무
    private String transType;    //기어 종류 ( Automatic, Manual )
    private String fuelType;    //연료 타입 ( Unspecified,Diesel,Hybrid,Electric,LPG Compresssed Gas,Hydrogen,MultiFuel,Petrol,Ethanol)
    private String driveType;    //4륜구동여부 ( AWD,4WD,Unspecified )
    private String code;        //요청한 차량 유형 
    private String codeContext;    //사용된 코드 유형, 코드가 있는 경우 필수 
    private String carCate;    // 1 = car,2 = van,,3 = suv,,4 = convertible,7= limousine,8 = station wagon,9 = pickup
                               // 10 = motorhome,11 = all-terrain,12 = recreational,13 = sport,14 = special,
                               // 15 = pickup extended cab,16 = regular cab pickup,17 = special offer,18 = coupe
                               // 19 = monospace,20 = 2 wheel vehicle,21 = roadster,22 = crossover,23 = commercial van/truck
    private String carSize;    //1 = mini,2 = subcompact,3 = economy,4 = compact,5 = midsize,6 = intermediate
                               // 7 = standard,8 = fullsize,9 = luxury,10 = premium,23 = special,32= special,33= minielite
                               // 34= economy elite,35= compact elite,36= intermediate elite,37= standard elite,38= fullsize elite
                               // 39= premium elite,40= luxury elite,41= oversize
    private String carNm;      //차량 명
    private String carImg;      //차량이미지 ( https://images.hertz.com/vehicles/220x128/ 가 붙어야 함. )
    /* 요금 관련 */
    private String unlimited;   //무제한 또는 제한된 마일 / km를 나타냅니다
    private String quantity;   //요금에 포함 된 km / km 수를 나타냅니다. 참고 :이 속성은 Unlimited = "true"이면 표시되지 않습니다.
    private String distUnitNm;   //Indicates miles or kilometers.
    private String distQuantiy;
    private String periodUnitNm;   //총 마일이 적용되는 시간 단위를 나타냅니다. ( RentalPeriod : 임대기간 )
    private String chargePurpose;  //청구목적   1 = Vehicle rental ( 차량 대여 ), 2 = Drop  8 = Additional distance 23 = Pay on Arrival Amount
    private String taxInclusive;  //요금에 세금포함 여부 
    private String guaranteedInd;  // 요금에 보증 포함 여부
    private String amount;  // 세부 청구 금액의 기본 금액 chargePurpose가 "1"인 경우,이 금액은 판촉이나 할인이 적용된 이후의 기본 요금이됩니다.
    private String currency;  // 통화코드
    private String unitCharge;  // 일별, 주별, 시간별 가격
    private String hourUnitCharge;
    private String dayUnitCharge;
    private String weekUnitCharge;
    private String monthUnitCharge;
    private String unitNm;  //Day 등 unitCharge의 단위를 표시 ( Day,Hour,Km,Mile,Month,RentalPeriod,Week)
    private String hourUnitNm;
    private String dayUnitNm;
    private String weekUnitNm;
    private String monthUnitNm;
    private String rateQuan;  //기본 요율 계산에 사용 된 요일, 주, 시간 등을 식별합니다.
    private String arriveByFlight;  //이 대여에 항공권이 필요한지 여부를 나타냅니다.
    private String rateCate;  //반환되는 비율 유형을 식별합니다. 값이 3 인 경우 요금은 비 선불 요금입니다. RateCategory 속성이 없으면 선불 비율이 지정됩니다.
    private String rateQual;  //허츠 요금 코드 
    private String rateTotaAmt;  //필수 항목을 추가하기 전에 기본 총계를 표시합니다. 
    private String estimatedTotalAmt;  //모든 필수 세금 및 / 또는 수수료를 포함한 총 금액을 표시합니다.
    /* 특수 장비 ( 4 = ski rack   , 7 = infant child seat , 8 = child toddler seat ,9 = booster seat ,11 = hand controls right
            -- 12 = hand controls left,13 = neverlost system,14= snow tires,18 = spinner knob,27 = satellite radio,29 = seat belt extender
            -- 41 =  Multi Media System ) */
    private String equip;
    private String equipType1;       //특수장비 타입 
    private String equipTypeCnt1;    //특수장비 타입1에 대한 선택할 수 있는 수량
    private String equipTypeAmt1; //각 특수 장비 코드의 총 가격.
    private String includedInRate1; //특별 장비 요금이 'rateTotaAmt'에 포함되는지 여부를 나타냅니다. true / false
    private String equipType2;       //특수장비 타입 
    private String equipTypeCnt2;    //특수장비 타입1에 대한 선택할 수 있는 수량
    private String equipTypeAmt2; //각 특수 장비 코드의 총 가격.
    private String includedInRate2; //특별 장비 요금이 'rateTotaAmt'에 포함되는지 여부를 나타냅니다. true / false
    private String equipType3;       //특수장비 타입 
    private String equipTypeCnt3;    //특수장비 타입1에 대한 선택할 수 있는 수량
    private String equipTypeAmt3; //각 특수 장비 코드의 총 가격.
    private String includedInRate3; //특별 장비 요금이 'rateTotaAmt'에 포함되는지 여부를 나타냅니다. true / false
    private String equipType4;       //특수장비 타입 
    private String equipTypeCnt4;    //특수장비 타입1에 대한 선택할 수 있는 수량
    private String equipTypeAmt4; //각 특수 장비 코드의 총 가격.
    private String includedInRate4; //특별 장비 요금이 'rateTotaAmt'에 포함되는지 여부를 나타냅니다. true / false
    /* 할증료 부분 */
    private String feePurpose1;  //금액이 할증료 또는 수수료임을 나타냅니다. ( 5 = Surcharge ( 부가요금), 6 = Fee ( 보수 )
    private String feeDesc1;     //할증료 또는 수수료의 기본 금액 설명
    private String feeIncRate1;  //수수료 또는 할증료가 rateTotaAmt (기본 총액)에 포함되는지 여부를 나타냅니다 true/false
    private String freeAmt1;  //할증료 또는 수수료의 기본 금액을 나타냅니다.
    private String feePurpose2;  //금액이 할증료 또는 수수료임을 나타냅니다. ( 5 = Surcharge ( 부가요금), 6 = Fee ( 보수 )
    private String feeDesc2;     //할증료 또는 수수료의 기본 금액 설명
    private String feeIncRate2;  //수수료 또는 할증료가 rateTotaAmt (기본 총액)에 포함되는지 여부를 나타냅니다 true/false
    private String freeAmt2;  //할증료 또는 수수료의 기본 금액을 나타냅니다.
    private String feePurpose3;  //금액이 할증료 또는 수수료임을 나타냅니다. ( 5 = Surcharge ( 부가요금), 6 = Fee ( 보수 )
    private String feeDesc3;     //할증료 또는 수수료의 기본 금액 설명
    private String feeIncRate3;  //수수료 또는 할증료가 rateTotaAmt (기본 총액)에 포함되는지 여부를 나타냅니다 true/false
    private String freeAmt3;  //할증료 또는 수수료의 기본 금액을 나타냅니다.
    private String feePurpose4;  //금액이 할증료 또는 수수료임을 나타냅니다. ( 5 = Surcharge ( 부가요금), 6 = Fee ( 보수 )
    private String feeDesc4;     //할증료 또는 수수료의 기본 금액 설명
    private String feeIncRate4;  //수수료 또는 할증료가 rateTotaAmt (기본 총액)에 포함되는지 여부를 나타냅니다 true/false
    private String freeAmt4;  //할증료 또는 수수료의 기본 금액을 나타냅니다.
    private String feePurpose5;  //금액이 할증료 또는 수수료임을 나타냅니다. ( 5 = Surcharge ( 부가요금), 6 = Fee ( 보수 )
    private String feeDesc5;     //할증료 또는 수수료의 기본 금액 설명
    private String feeIncRate5;  //수수료 또는 할증료가 rateTotaAmt (기본 총액)에 포함되는지 여부를 나타냅니다 true/false
    private String freeAmt5;  //할증료 또는 수수료의 기본 금액을 나타냅니다.
    /* 보험 가입 관련 .*/
    private String coverType1;  
    /*7 = Collision Damage Waiver ( 충돌 손상 면제 )
    -- 24 = Loss damage waiver ( 손실 손해 배상 )
    -- 27 = Liability insurance supplement ( 책임보험 보충 교재 )
    -- 32 = Personal Accident Insurance ( 개인 상해 보험 )
    -- 36 = Personal Effects Coverage ( 개인 효과 범위 )
    -- 38 = Personal property insurance ( 개인 재산 보험 )
    -- 40 = Super collision damage waiver ( 수퍼 충돌 피해 배상 )
    -- 48 = Theft protection ( 도난방지 )
    -- 56 = Max Cover ( 최대 커버 )
    -- 57=AER (Accident Excess Reduction) plus ( 사고 초과 절감 플러스 )
    -- 58=AER (Accident Excess Reduction) ( 사고 초과 절감 )
    -- 59=Super Cover ( 수퍼 커버 )
    */
    private String coverTypeIncRate1;   //적용범위가 rateTotaAmt (기본 총액)에 포함되는지 여부
    private String coverTypeAmt1;       //적용범위가 rateTotaAmt (기본 총액)에 포함되는지 여부
    private String coverType2;  
    private String coverTypeIncRate2;
    private String coverTypeAmt2;
    private String coverType3;  
    private String coverTypeIncRate3;
    private String coverTypeAmt3;
    
    private String locDetailNm; //임대 시설, 주소, 전화 번호, 운영 시간에 관한 정보.Comments : 이것은 "견적"수정시에만 사용됩니다.
    private String locaddr; //임대 주소 
    private String postalCode; //임대 주소 우편번호
    private String phoneNumber; //영업소 전화번호
    private String parkLoc; //렌터카 주차장의 위치를 식별합니다 ( 1 - Terminal,2 - Shuttle on airport,3 - Shuttle off airport )
    private String CounterLoc; //렌터카 카운터의 위치를 식별합니다 ( 1 - Terminal,2 - Shuttle on airport,3 - Shuttle off airport )
    
    private String OperTimeText; //영업소 근무시간 
    private String OperTimeMon;        //영업소 월요일 오픈 여부 
    private String OperTimeMonStime;   //영업소 월요일 오픈 시간 
    private String OperTimeMonEtime;   //영업소 월요일 닫는 시간 
    private String OperTimeTue;        //영업소 화요일 오픈 여부 
    private String OperTimeTueStime;   //영업소 화요일 오픈 시간 
    private String OperTimeTueEtime;   //영업소 화요일 닫는 시간 
    private String OperTimeWed;        //영업소 수요일 오픈 여부 
    private String OperTimeWedStime;   //영업소 수요일 오픈 시간 
    private String OperTimeWedEtime;   //영업소 수요일 닫는 시간 
    private String OperTimeThu;        //영업소 목요일 오픈 여부 
    private String OperTimeThuStime;   //영업소 목요일 오픈 시간 
    private String OperTimeThuEtime;   //영업소 목요일 닫는 시간 
    private String OperTimeFri;        //영업소 금요일 오픈 여부 
    private String OperTimeFriStime;   //영업소 금요일 오픈 시간 
    private String OperTimeFriEtime;   //영업소 금요일 닫는 시간 
    private String OperTimeSat;        //영업소 토요일 오픈 여부 
    private String OperTimeSatStime;   //영업소 토요일 오픈 시간 
    private String OperTimeSatEtime;   //영업소 토요일 닫는 시간 
    private String OperTimeSun;        //영업소 일요일 오픈 여부 
    private String OperTimeSunStime;   //영업소 일요일 오픈 시간 
    private String OperTimeSunEtime;   //영업소 일요일 닫는 시간 
    
    private String regId;  //검색자 아이디 
    private String promotionCode;  //프로모션 코드
    
	public String getContCode() {
		return contCode;
	}
	public void setContCode(String contCode) {
		this.contCode = contCode;
	}
	public String getCountryCode() {
		return countryCode;
	}
	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}
	public String getCityCode() {
		return cityCode;
	}
	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getStime() {
		return stime;
	}
	public void setStime(String stime) {
		this.stime = stime;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
	public String getEtime() {
		return etime;
	}
	public void setEtime(String etime) {
		this.etime = etime;
	}
	public long getDuration() {
		return duration;
	}
	public void setDuration(long duration) {
		this.duration = duration;
	}
	public String getSyyyy() {
		return syyyy;
	}
	public void setSyyyy(String syyyy) {
		this.syyyy = syyyy;
	}
	public String getSmm() {
		return smm;
	}
	public void setSmm(String smm) {
		this.smm = smm;
	}
	public String getSdd() {
		return sdd;
	}
	public void setSdd(String sdd) {
		this.sdd = sdd;
	}
	public String getEyyyy() {
		return eyyyy;
	}
	public void setEyyyy(String eyyyy) {
		this.eyyyy = eyyyy;
	}
	public String getEmm() {
		return emm;
	}
	public void setEmm(String emm) {
		this.emm = emm;
	}
	public String getEdd() {
		return edd;
	}
	public void setEdd(String edd) {
		this.edd = edd;
	}
	public int getUniqueNum() {
		return uniqueNum;
	}
	public void setUniqueNum(int uniqueNum) {
		this.uniqueNum = uniqueNum;
	}
	public String getVenderId() {
		return venderId;
	}
	public void setVenderId(String venderId) {
		this.venderId = venderId;
	}
	public String getOagCode() {
		return oagCode;
	}
	public void setOagCode(String oagCode) {
		this.oagCode = oagCode;
	}
	public String getSaleNm() {
		return saleNm;
	}
	public void setSaleNm(String saleNm) {
		this.saleNm = saleNm;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getFax() {
		return fax;
	}
	public String getHgoMsg() {
		return hgoMsg;
	}
	public void setHgoMsg(String hgoMsg) {
		this.hgoMsg = hgoMsg;
	}
	public String getPflMsg() {
		return pflMsg;
	}
	public void setPflMsg(String pflMsg) {
		this.pflMsg = pflMsg;
	}
	public String getWnaMsg() {
		return wnaMsg;
	}
	public void setWnaMsg(String wnaMsg) {
		this.wnaMsg = wnaMsg;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getOpenMon() {
		return openMon;
	}
	public void setOpenMon(String openMon) {
		this.openMon = openMon;
	}
	public String getCloseMon() {
		return closeMon;
	}
	public void setCloseMon(String closeMon) {
		this.closeMon = closeMon;
	}
	public String getOpenTue() {
		return openTue;
	}
	public void setOpenTue(String openTue) {
		this.openTue = openTue;
	}
	public String getCloseTue() {
		return closeTue;
	}
	public void setCloseTue(String closeTue) {
		this.closeTue = closeTue;
	}
	public String getOpenWed() {
		return openWed;
	}
	public void setOpenWed(String openWed) {
		this.openWed = openWed;
	}
	public String getCloseWed() {
		return closeWed;
	}
	public void setCloseWed(String closeWed) {
		this.closeWed = closeWed;
	}
	public String getOpenThu() {
		return openThu;
	}
	public void setOpenThu(String openThu) {
		this.openThu = openThu;
	}
	public String getCloseThu() {
		return closeThu;
	}
	public void setCloseThu(String closeThu) {
		this.closeThu = closeThu;
	}
	public String getOpenFri() {
		return openFri;
	}
	public void setOpenFri(String openFri) {
		this.openFri = openFri;
	}
	public String getCloseFri() {
		return closeFri;
	}
	public void setCloseFri(String closeFri) {
		this.closeFri = closeFri;
	}
	public String getOpenSat() {
		return openSat;
	}
	public void setOpenSat(String openSat) {
		this.openSat = openSat;
	}
	public String getCloseSat() {
		return closeSat;
	}
	public void setCloseSat(String closeSat) {
		this.closeSat = closeSat;
	}
	public String getOpenSun() {
		return openSun;
	}
	public void setOpenSun(String openSun) {
		this.openSun = openSun;
	}
	public String getCloseSun() {
		return closeSun;
	}
	public void setCloseSun(String closeSun) {
		this.closeSun = closeSun;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLongi() {
		return longi;
	}
	public void setLongi(String longi) {
		this.longi = longi;
	}
	public String getReferId() {
		return referId;
	}
	public void setReferId(String referId) {
		this.referId = referId;
	}
	public String getReferType() {
		return referType;
	}
	public void setReferType(String referType) {
		this.referType = referType;
	}
	public String getSucess() {
		return sucess;
	}
	public void setSucess(String sucess) {
		this.sucess = sucess;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getWarning() {
		return warning;
	}
	public void setWarning(String warning) {
		this.warning = warning;
	}
	public String getPickupDateTime() {
		return pickupDateTime;
	}
	public void setPickupDateTime(String pickupDateTime) {
		this.pickupDateTime = pickupDateTime;
	}
	public String getReturnDateTime() {
		return returnDateTime;
	}
	public void setReturnDateTime(String returnDateTime) {
		this.returnDateTime = returnDateTime;
	}
	public String getPickupExtLoc() {
		return pickupExtLoc;
	}
	public void setPickupExtLoc(String pickupExtLoc) {
		this.pickupExtLoc = pickupExtLoc;
	}
	public String getReturnExtLoc() {
		return returnExtLoc;
	}
	public void setReturnExtLoc(String returnExtLoc) {
		this.returnExtLoc = returnExtLoc;
	}
	public String getPickupLoc() {
		return pickupLoc;
	}
	public void setPickupLoc(String pickupLoc) {
		this.pickupLoc = pickupLoc;
	}
	public String getReturnLoc() {
		return returnLoc;
	}
	public void setReturnLoc(String returnLoc) {
		this.returnLoc = returnLoc;
	}
	public String getVendorCode() {
		return vendorCode;
	}
	public void setVendorCode(String vendorCode) {
		this.vendorCode = vendorCode;
	}
	public String getIsAlternateInd() {
		return IsAlternateInd;
	}
	public void setIsAlternateInd(String isAlternateInd) {
		IsAlternateInd = isAlternateInd;
	}
	public String getPassengerCnt() {
		return passengerCnt;
	}
	public void setPassengerCnt(String passengerCnt) {
		this.passengerCnt = passengerCnt;
	}
	public String getBaggageCnt() {
		return baggageCnt;
	}
	public void setBaggageCnt(String baggageCnt) {
		this.baggageCnt = baggageCnt;
	}
	public String getAirCondition() {
		return airCondition;
	}
	public void setAirCondition(String airCondition) {
		this.airCondition = airCondition;
	}
	public String getTransType() {
		return transType;
	}
	public void setTransType(String transType) {
		this.transType = transType;
	}
	public String getFuelType() {
		return fuelType;
	}
	public void setFuelType(String fuelType) {
		this.fuelType = fuelType;
	}
	public String getDriveType() {
		return driveType;
	}
	public void setDriveType(String driveType) {
		this.driveType = driveType;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCodeContext() {
		return codeContext;
	}
	public void setCodeContext(String codeContext) {
		this.codeContext = codeContext;
	}
	public String getCarCate() {
		return carCate;
	}
	public void setCarCate(String carCate) {
		this.carCate = carCate;
	}
	public String getCarSize() {
		return carSize;
	}
	public void setCarSize(String carSize) {
		this.carSize = carSize;
	}
	public String getCarNm() {
		return carNm;
	}
	public void setCarNm(String carNm) {
		this.carNm = carNm;
	}
	public String getCarImg() {
		return carImg;
	}
	public void setCarImg(String carImg) {
		this.carImg = carImg;
	}
	public String getUnlimited() {
		return unlimited;
	}
	public void setUnlimited(String unlimited) {
		this.unlimited = unlimited;
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public String getDistUnitNm() {
		return distUnitNm;
	}
	public void setDistUnitNm(String distUnitNm) {
		this.distUnitNm = distUnitNm;
	}
	public String getPeriodUnitNm() {
		return periodUnitNm;
	}
	public void setPeriodUnitNm(String periodUnitNm) {
		this.periodUnitNm = periodUnitNm;
	}
	public String getChargePurpose() {
		return chargePurpose;
	}
	public void setChargePurpose(String chargePurpose) {
		this.chargePurpose = chargePurpose;
	}
	public String getTaxInclusive() {
		return taxInclusive;
	}
	public void setTaxInclusive(String taxInclusive) {
		this.taxInclusive = taxInclusive;
	}
	public String getGuaranteedInd() {
		return guaranteedInd;
	}
	public void setGuaranteedInd(String guaranteedInd) {
		this.guaranteedInd = guaranteedInd;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public String getUnitCharge() {
		return unitCharge;
	}
	public void setUnitCharge(String unitCharge) {
		this.unitCharge = unitCharge;
	}
	public String getUnitNm() {
		return unitNm;
	}
	public void setUnitNm(String unitNm) {
		this.unitNm = unitNm;
	}
	public String getHourUnitCharge() {
		return hourUnitCharge;
	}
	public void setHourUnitCharge(String hourUnitCharge) {
		this.hourUnitCharge = hourUnitCharge;
	}
	public String getDayUnitCharge() {
		return dayUnitCharge;
	}
	public void setDayUnitCharge(String dayUnitCharge) {
		this.dayUnitCharge = dayUnitCharge;
	}
	public String getWeekUnitCharge() {
		return weekUnitCharge;
	}
	public void setWeekUnitCharge(String weekUnitCharge) {
		this.weekUnitCharge = weekUnitCharge;
	}
	public String getMonthUnitCharge() {
		return monthUnitCharge;
	}
	public void setMonthUnitCharge(String monthUnitCharge) {
		this.monthUnitCharge = monthUnitCharge;
	}
	public String getHourUnitNm() {
		return hourUnitNm;
	}
	public void setHourUnitNm(String hourUnitNm) {
		this.hourUnitNm = hourUnitNm;
	}
	public String getDayUnitNm() {
		return dayUnitNm;
	}
	public void setDayUnitNm(String dayUnitNm) {
		this.dayUnitNm = dayUnitNm;
	}
	public String getWeekUnitNm() {
		return weekUnitNm;
	}
	public void setWeekUnitNm(String weekUnitNm) {
		this.weekUnitNm = weekUnitNm;
	}
	public String getMonthUnitNm() {
		return monthUnitNm;
	}
	public void setMonthUnitNm(String monthUnitNm) {
		this.monthUnitNm = monthUnitNm;
	}
	public String getRateQuan() {
		return rateQuan;
	}
	public void setRateQuan(String rateQuan) {
		this.rateQuan = rateQuan;
	}
	public String getArriveByFlight() {
		return arriveByFlight;
	}
	public void setArriveByFlight(String arriveByFlight) {
		this.arriveByFlight = arriveByFlight;
	}
	public String getRateCate() {
		return rateCate;
	}
	public void setRateCate(String rateCate) {
		this.rateCate = rateCate;
	}
	public String getRateQual() {
		return rateQual;
	}
	public void setRateQual(String rateQual) {
		this.rateQual = rateQual;
	}
	public String getRateTotaAmt() {
		return rateTotaAmt;
	}
	public void setRateTotaAmt(String rateTotaAmt) {
		this.rateTotaAmt = rateTotaAmt;
	}
	public String getEstimatedTotalAmt() {
		return estimatedTotalAmt;
	}
	public void setEstimatedTotalAmt(String estimatedTotalAmt) {
		this.estimatedTotalAmt = estimatedTotalAmt;
	}
	public String getEquip() {
		return equip;
	}
	public void setEquip(String equip) {
		this.equip = equip;
	}
	public String getEquipType1() {
		return equipType1;
	}
	public void setEquipType1(String equipType1) {
		this.equipType1 = equipType1;
	}
	public String getEquipTypeCnt1() {
		return equipTypeCnt1;
	}
	public void setEquipTypeCnt1(String equipTypeCnt1) {
		this.equipTypeCnt1 = equipTypeCnt1;
	}
	public String getEquipTypeAmt1() {
		return equipTypeAmt1;
	}
	public void setEquipTypeAmt1(String equipTypeAmt1) {
		this.equipTypeAmt1 = equipTypeAmt1;
	}
	public String getIncludedInRate1() {
		return includedInRate1;
	}
	public void setIncludedInRate1(String includedInRate1) {
		this.includedInRate1 = includedInRate1;
	}
	public String getEquipType2() {
		return equipType2;
	}
	public void setEquipType2(String equipType2) {
		this.equipType2 = equipType2;
	}
	public String getEquipTypeCnt2() {
		return equipTypeCnt2;
	}
	public void setEquipTypeCnt2(String equipTypeCnt2) {
		this.equipTypeCnt2 = equipTypeCnt2;
	}
	public String getEquipTypeAmt2() {
		return equipTypeAmt2;
	}
	public void setEquipTypeAmt2(String equipTypeAmt2) {
		this.equipTypeAmt2 = equipTypeAmt2;
	}
	public String getIncludedInRate2() {
		return includedInRate2;
	}
	public void setIncludedInRate2(String includedInRate2) {
		this.includedInRate2 = includedInRate2;
	}
	public String getEquipType3() {
		return equipType3;
	}
	public void setEquipType3(String equipType3) {
		this.equipType3 = equipType3;
	}
	public String getEquipTypeCnt3() {
		return equipTypeCnt3;
	}
	public void setEquipTypeCnt3(String equipTypeCnt3) {
		this.equipTypeCnt3 = equipTypeCnt3;
	}
	public String getEquipTypeAmt3() {
		return equipTypeAmt3;
	}
	public void setEquipTypeAmt3(String equipTypeAmt3) {
		this.equipTypeAmt3 = equipTypeAmt3;
	}
	public String getIncludedInRate3() {
		return includedInRate3;
	}
	public void setIncludedInRate3(String includedInRate3) {
		this.includedInRate3 = includedInRate3;
	}
	public String getEquipType4() {
		return equipType4;
	}
	public void setEquipType4(String equipType4) {
		this.equipType4 = equipType4;
	}
	public String getEquipTypeCnt4() {
		return equipTypeCnt4;
	}
	public void setEquipTypeCnt4(String equipTypeCnt4) {
		this.equipTypeCnt4 = equipTypeCnt4;
	}
	public String getEquipTypeAmt4() {
		return equipTypeAmt4;
	}
	public void setEquipTypeAmt4(String equipTypeAmt4) {
		this.equipTypeAmt4 = equipTypeAmt4;
	}
	public String getIncludedInRate4() {
		return includedInRate4;
	}
	public void setIncludedInRate4(String includedInRate4) {
		this.includedInRate4 = includedInRate4;
	}
	public String getFeePurpose1() {
		return feePurpose1;
	}
	public void setFeePurpose1(String feePurpose1) {
		this.feePurpose1 = feePurpose1;
	}
	public String getFeeDesc1() {
		return feeDesc1;
	}
	public void setFeeDesc1(String feeDesc1) {
		this.feeDesc1 = feeDesc1;
	}
	public String getFeeIncRate1() {
		return feeIncRate1;
	}
	public void setFeeIncRate1(String feeIncRate1) {
		this.feeIncRate1 = feeIncRate1;
	}
	public String getFreeAmt1() {
		return freeAmt1;
	}
	public void setFreeAmt1(String freeAmt1) {
		this.freeAmt1 = freeAmt1;
	}
	public String getFeePurpose2() {
		return feePurpose2;
	}
	public void setFeePurpose2(String feePurpose2) {
		this.feePurpose2 = feePurpose2;
	}
	public String getFeeDesc2() {
		return feeDesc2;
	}
	public void setFeeDesc2(String feeDesc2) {
		this.feeDesc2 = feeDesc2;
	}
	public String getFeeIncRate2() {
		return feeIncRate2;
	}
	public void setFeeIncRate2(String feeIncRate2) {
		this.feeIncRate2 = feeIncRate2;
	}
	public String getFreeAmt2() {
		return freeAmt2;
	}
	public void setFreeAmt2(String freeAmt2) {
		this.freeAmt2 = freeAmt2;
	}
	public String getFeePurpose3() {
		return feePurpose3;
	}
	public void setFeePurpose3(String feePurpose3) {
		this.feePurpose3 = feePurpose3;
	}
	public String getFeeDesc3() {
		return feeDesc3;
	}
	public void setFeeDesc3(String feeDesc3) {
		this.feeDesc3 = feeDesc3;
	}
	public String getFeeIncRate3() {
		return feeIncRate3;
	}
	public void setFeeIncRate3(String feeIncRate3) {
		this.feeIncRate3 = feeIncRate3;
	}
	public String getFreeAmt3() {
		return freeAmt3;
	}
	public void setFreeAmt3(String freeAmt3) {
		this.freeAmt3 = freeAmt3;
	}
	public String getFeePurpose4() {
		return feePurpose4;
	}
	public void setFeePurpose4(String feePurpose4) {
		this.feePurpose4 = feePurpose4;
	}
	public String getFeeDesc4() {
		return feeDesc4;
	}
	public void setFeeDesc4(String feeDesc4) {
		this.feeDesc4 = feeDesc4;
	}
	public String getFeeIncRate4() {
		return feeIncRate4;
	}
	public void setFeeIncRate4(String feeIncRate4) {
		this.feeIncRate4 = feeIncRate4;
	}
	public String getFreeAmt4() {
		return freeAmt4;
	}
	public void setFreeAmt4(String freeAmt4) {
		this.freeAmt4 = freeAmt4;
	}
	public String getFeePurpose5() {
		return feePurpose5;
	}
	public void setFeePurpose5(String feePurpose5) {
		this.feePurpose5 = feePurpose5;
	}
	public String getFeeDesc5() {
		return feeDesc5;
	}
	public void setFeeDesc5(String feeDesc5) {
		this.feeDesc5 = feeDesc5;
	}
	public String getFeeIncRate5() {
		return feeIncRate5;
	}
	public void setFeeIncRate5(String feeIncRate5) {
		this.feeIncRate5 = feeIncRate5;
	}
	public String getFreeAmt5() {
		return freeAmt5;
	}
	public void setFreeAmt5(String freeAmt5) {
		this.freeAmt5 = freeAmt5;
	}
	public String getCoverType1() {
		return coverType1;
	}
	public void setCoverType1(String coverType1) {
		this.coverType1 = coverType1;
	}
	public String getCoverTypeIncRate1() {
		return coverTypeIncRate1;
	}
	public void setCoverTypeIncRate1(String coverTypeIncRate1) {
		this.coverTypeIncRate1 = coverTypeIncRate1;
	}
	public String getCoverTypeAmt1() {
		return coverTypeAmt1;
	}
	public void setCoverTypeAmt1(String coverTypeAmt1) {
		this.coverTypeAmt1 = coverTypeAmt1;
	}
	public String getCoverType2() {
		return coverType2;
	}
	public void setCoverType2(String coverType2) {
		this.coverType2 = coverType2;
	}
	public String getCoverTypeIncRate2() {
		return coverTypeIncRate2;
	}
	public void setCoverTypeIncRate2(String coverTypeIncRate2) {
		this.coverTypeIncRate2 = coverTypeIncRate2;
	}
	public String getCoverTypeAmt2() {
		return coverTypeAmt2;
	}
	public void setCoverTypeAmt2(String coverTypeAmt2) {
		this.coverTypeAmt2 = coverTypeAmt2;
	}
	public String getCoverType3() {
		return coverType3;
	}
	public void setCoverType3(String coverType3) {
		this.coverType3 = coverType3;
	}
	public String getCoverTypeIncRate3() {
		return coverTypeIncRate3;
	}
	public void setCoverTypeIncRate3(String coverTypeIncRate3) {
		this.coverTypeIncRate3 = coverTypeIncRate3;
	}
	public String getCoverTypeAmt3() {
		return coverTypeAmt3;
	}
	public void setCoverTypeAmt3(String coverTypeAmt3) {
		this.coverTypeAmt3 = coverTypeAmt3;
	}
	public String getLocDetailNm() {
		return locDetailNm;
	}
	public void setLocDetailNm(String locDetailNm) {
		this.locDetailNm = locDetailNm;
	}
	public String getLocaddr() {
		return locaddr;
	}
	public void setLocaddr(String locaddr) {
		this.locaddr = locaddr;
	}
	public String getPostalCode() {
		return postalCode;
	}
	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getParkLoc() {
		return parkLoc;
	}
	public void setParkLoc(String parkLoc) {
		this.parkLoc = parkLoc;
	}
	public String getCounterLoc() {
		return CounterLoc;
	}
	public void setCounterLoc(String counterLoc) {
		CounterLoc = counterLoc;
	}
	public String getOperTimeText() {
		return OperTimeText;
	}
	public void setOperTimeText(String operTimeText) {
		OperTimeText = operTimeText;
	}
	public String getOperTimeMon() {
		return OperTimeMon;
	}
	public void setOperTimeMon(String operTimeMon) {
		OperTimeMon = operTimeMon;
	}
	public String getOperTimeMonStime() {
		return OperTimeMonStime;
	}
	public void setOperTimeMonStime(String operTimeMonStime) {
		OperTimeMonStime = operTimeMonStime;
	}
	public String getOperTimeMonEtime() {
		return OperTimeMonEtime;
	}
	public void setOperTimeMonEtime(String operTimeMonEtime) {
		OperTimeMonEtime = operTimeMonEtime;
	}
	public String getOperTimeTue() {
		return OperTimeTue;
	}
	public void setOperTimeTue(String operTimeTue) {
		OperTimeTue = operTimeTue;
	}
	public String getOperTimeTueStime() {
		return OperTimeTueStime;
	}
	public void setOperTimeTueStime(String operTimeTueStime) {
		OperTimeTueStime = operTimeTueStime;
	}
	public String getOperTimeTueEtime() {
		return OperTimeTueEtime;
	}
	public void setOperTimeTueEtime(String operTimeTueEtime) {
		OperTimeTueEtime = operTimeTueEtime;
	}
	public String getOperTimeWed() {
		return OperTimeWed;
	}
	public void setOperTimeWed(String operTimeWed) {
		OperTimeWed = operTimeWed;
	}
	public String getOperTimeWedStime() {
		return OperTimeWedStime;
	}
	public void setOperTimeWedStime(String operTimeWedStime) {
		OperTimeWedStime = operTimeWedStime;
	}
	public String getOperTimeWedEtime() {
		return OperTimeWedEtime;
	}
	public void setOperTimeWedEtime(String operTimeWedEtime) {
		OperTimeWedEtime = operTimeWedEtime;
	}
	public String getOperTimeThu() {
		return OperTimeThu;
	}
	public void setOperTimeThu(String operTimeThu) {
		OperTimeThu = operTimeThu;
	}
	public String getOperTimeThuStime() {
		return OperTimeThuStime;
	}
	public void setOperTimeThuStime(String operTimeThuStime) {
		OperTimeThuStime = operTimeThuStime;
	}
	public String getOperTimeThuEtime() {
		return OperTimeThuEtime;
	}
	public void setOperTimeThuEtime(String operTimeThuEtime) {
		OperTimeThuEtime = operTimeThuEtime;
	}
	public String getOperTimeFri() {
		return OperTimeFri;
	}
	public void setOperTimeFri(String operTimeFri) {
		OperTimeFri = operTimeFri;
	}
	public String getOperTimeFriStime() {
		return OperTimeFriStime;
	}
	public void setOperTimeFriStime(String operTimeFriStime) {
		OperTimeFriStime = operTimeFriStime;
	}
	public String getOperTimeFriEtime() {
		return OperTimeFriEtime;
	}
	public void setOperTimeFriEtime(String operTimeFriEtime) {
		OperTimeFriEtime = operTimeFriEtime;
	}
	public String getOperTimeSat() {
		return OperTimeSat;
	}
	public void setOperTimeSat(String operTimeSat) {
		OperTimeSat = operTimeSat;
	}
	public String getOperTimeSatStime() {
		return OperTimeSatStime;
	}
	public void setOperTimeSatStime(String operTimeSatStime) {
		OperTimeSatStime = operTimeSatStime;
	}
	public String getOperTimeSatEtime() {
		return OperTimeSatEtime;
	}
	public void setOperTimeSatEtime(String operTimeSatEtime) {
		OperTimeSatEtime = operTimeSatEtime;
	}
	public String getOperTimeSun() {
		return OperTimeSun;
	}
	public void setOperTimeSun(String operTimeSun) {
		OperTimeSun = operTimeSun;
	}
	public String getOperTimeSunStime() {
		return OperTimeSunStime;
	}
	public void setOperTimeSunStime(String operTimeSunStime) {
		OperTimeSunStime = operTimeSunStime;
	}
	public String getOperTimeSunEtime() {
		return OperTimeSunEtime;
	}
	public void setOperTimeSunEtime(String operTimeSunEtime) {
		OperTimeSunEtime = operTimeSunEtime;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getPromotionCode() {
		return promotionCode;
	}
	public void setPromotionCode(String promotionCode) {
		this.promotionCode = promotionCode;
	}
	public String getDistQuantiy() {
		return distQuantiy;
	}
	public void setDistQuantiy(String distQuantiy) {
		this.distQuantiy = distQuantiy;
	}
	
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getPickupDate() {
		return pickupDate;
	}
	public void setPickupDate(String pickupDate) {
		this.pickupDate = pickupDate;
	}
	public String getPickupTime() {
		return pickupTime;
	}
	public void setPickupTime(String pickupTime) {
		this.pickupTime = pickupTime;
	}
	public String getReturnDate() {
		return returnDate;
	}
	public void setReturnDate(String returnDate) {
		this.returnDate = returnDate;
	}
	public String getReturnTime() {
		return returnTime;
	}
	public void setReturnTime(String returnTime) {
		this.returnTime = returnTime;
	}
	public String getPickupOagCode() {
		return pickupOagCode;
	}
	public void setPickupOagCode(String pickupOagCode) {
		this.pickupOagCode = pickupOagCode;
	}
	public String getReturnOagCode() {
		return returnOagCode;
	}
	public void setReturnOagCode(String returnOagCode) {
		this.returnOagCode = returnOagCode;
	}
	
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
