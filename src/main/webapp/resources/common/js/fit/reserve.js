	// -----------------------------------------------------------------------------
	// 예약 화면 관련 스크립트 정리 
	// -----------------------------------------------------------------------------
	// 예약 2단계로 이동 
	function fn_goReserveStep2() {
		var selAir =  $("#selAir").val();
		var selHotel = $("#selHotel").val();
		var selRentcar = $("#selRentcar").val();
		
		document.location.href='/free_reserve/reserve_agree_step2.do?selAir='+selAir+"&selHotel="+selHotel + "&selRentcar="+selRentcar;
	}

	//예약 3단계로 이동 
	function fn_goReserveStep3() {
		var selAir =  $("#selAir").val();
		var selHotel = $("#selHotel").val();
		var selRentcar = $("#selRentcar").val();

		document.location.href='/free_reserve/reserve_dp_step3.do?selAir='+selAir+"&selHotel="+selHotel + "&selRentcar="+selRentcar;
	}

	//예약 4단계로 이동 
	function fn_goReserveStep4() {
		var selAir =  $("#selAir").val();
		var selHotel = $("#selHotel").val();
		var selRentcar = $("#selRentcar").val();

		
		document.location.href='/free_reserve/reserve_travelers_step4.do?selAir='+selAir+"&selHotel="+selHotel + "&selRentcar="+selRentcar;
	}
	//예약 5단계로 이동 
	function fn_goReserveStep5(jSessionID, airReserveData, fitRsvNo) {
		var airReserveInfo;
        var hotelReserveInfo;
        var reqReserveInfo;
        var airYN = 'N';
        var hotelYN = 'N';
        var rentcarYN = 'N';
        
        if(nullToBlank(airReserveData) != ""){
        	airReserveInfo = airReserveData.bodyDTO;
        }
        
        if(nullToBlank(sessionStorage.airSelData) != "" && sessionStorage.airSelData != "[]"){
        	airYN = 'Y';
        }
        
        if(nullToBlank(sessionStorage.hotelBasketData) != "" && sessionStorage.hotelBasketData != "[]"){
        	hotelYN = 'Y';
        }

		if(nullToBlank(sessionStorage.rentcarSelData) != "" && sessionStorage.rentcarSelData != "[]"){
			rentcarYN = 'Y';
		}
        
		rsvMstUserInfo.selectT(function(tx, results){
			console.log("results.rows.length=" + results.rows.length);
        	if(results.rows.length > 0){
	        	var userBirthDay = results.rows.item(0).resBirthday.substring(0, 4) + "-" + results.rows.item(0).resBirthday.substring(4, 6) + "-" + results.rows.item(0).resBirthday.substring(6, 8)
	        	var telNo = convertTel(results.rows.item(0).resPhoneNum);
	        	
	        	
	        	//호텔 예약 정보 파싱 
	        	if(nullToBlank(sessionStorage.hotelBasketData) != '' && sessionStorage.hotelBasketData != "[]") {
	        		var totalPrice = 0;
	        		var basketData = JSON.parse(sessionStorage.hotelBasketData);
	        		var hotelList = JSON.parse(sessionStorage.hotelSelList);
	        		var ijw = sessionStorage.ijw;
					var ijwk = sessionStorage.ijwk;
					var custchk = sessionStorage.custChk;
					var countrychk = JSON.parse(sessionStorage.hotelViewData);
					
	        		//var viewData = JSON.parse(sessionStorage.hotelViewData);
	        		if(nullToBlank(sessionStorage.mstAmtList) != '' && sessionStorage.mstAmtList != '[]') {
	        			var mstAmtList = JSON.parse(sessionStorage.mstAmtList)  //예약 금액 session
	        			//totalPrice = parseInt(mstAmtList.htlAmtTot); //세금및 tax포함된 금액
	        		}
	        			
	        		var hoteRsvData = [];
	        		
	        		hotelReserveInfo = {
			        		'operAgeGb' 	: userBirthDay,
			        		'operSurNm' 	: results.rows.item(0).resLastNm,
			        		'operGivenNm' 	: results.rows.item(0).resFirstNm,
			        		'telAreaNo' 	: "+82",
			        		'telNo' 		: telNo,
			        		'emailAddr' 	: results.rows.item(0).resEmail,
			        		'userId' 		: results.rows.item(0).resUserId
			        	};
			        	
	        		var userName;
	         		var eFstName;
	         		var eSndName;
	         		var birthday;
	         		var phone;
	         		var sex;
	         		var inwonCntTemp = 0;
	         		var inputInfoCnt = 0;
	         		
	         			         			
	         		for(var i=0; i < basketData.length; i++) {
	         			
	         			var cancelPolicy = '';
	         			
	         			var cancelDL = basketData[i].setRoomData[0].rateInfos[0].cancelDL; //공급사 cancelDL
	         			var cancelTL = " 16:00";
	         			
	         			//var cancelJtbDl = basketData[i].setRoomData[0].rateInfos[0].cancelJtbDl;
	         			//var jtbCancelDt = basketData[i].setRoomData[0].rateInfos[0].jtbCancelDt;
					   	//var jtbCancelTm = basketData[i].setRoomData[0].rateInfos[0].jtbCancelTm;
	         			
	         			if(cancelDL == '환불불가')  cancelPolicy = '환불불가';
						else {
							
//							//호텔 패스인 경우는 cancelDl값이 계산된 값으로 전달되어 하루를 더해서 임시적으로 처리
//							//추후에는 엔진쪽에서 공통적으로 처리해야  합니다.
//							//익스피디어의 경우와 호텔 패스가 다르다.
//							if(basketData[i].setRoomData[0].suplrCd = 'WHC') { //호텔패스인 경우 예외처리
//								cancelDL = dateAdd(cancelDL,1);
//							}
							
							cancelPolicy = cancelDL + cancelTL; //jtbCancelDt + " " + jtbCancelTm;
						}
						
	         			//연락처및 신용카드정보
	         			var creditInfo = {
	         					'email' 			: results.rows.item(0).resEmail,  		//고객이메일주소
	         					'firstName' 		: results.rows.item(0).resFirstNm, 		//카드 보유자의 이름
	         					'lastName' 			: results.rows.item(0).resLastNm, 		//카드 보유자의 성
	         					'homePhone' 		: telNo, 		//대표예약자 집 전화번호
	         					'workPhone' 		: telNo, 		//대표예약자 직장 전화번호
	         					'cardType' 			: 'CA',  		//신용카드 유형
	         					'cardNum' 			: '5401999999999999',   	//신용카드 번호
	         					'cardExpMonth' 		: '12', 	//신용카드 만료 월
	         					'cardExpYear' 		: '2020',      //신용카드 만료 년
	         					'cardIdentifier' 	: '123'	
	         			};
	         			
	         			//주소정보
	         			var addrInfo = {
	         					'addr1' 			: 'seoul, Repulic of Korea', 	 //고객 상세주소1
	         					'addr2'				: '', 			 //고객 상세주소2
	         					'addr3' 			: '',			//고객 상세주소3
	         					'city'  			: 'Seoul',		//도시
	         					'stateProvinceCd' 	: '', //시/도
	         					'countryCd' 		: 'KR',     //국가코드
	         					'postalCd' 			: '65807'    //고객 청구지 우편번호
	         			};
	         			
	         			
	         			
	         			//객실 갯수
	         			var roomGrpsData = JSON.parse(sessionStorage.roomGrps);
	         			
	         			//객실 갯수
         				 var aa = roomGrpsData[i];
         				 var roomGrps = [];
         				 for(var m=0; m < aa.length; m++) {
         					 
         					 var bb = aa[m].guestInfos;
         					 
         					 var guestArr = [];
         					 
         					 for(var n=0; n < bb.length; n++) {
         						 //숙박자정보
         						 var guestInfosData = {
		         						 'childAges' : bb[n].childAges,
		         						 'firstName' : bb[n].firstName,
		         						 'lastName' : bb[n].lastName,
		         						 'guestNmKr' : bb[n].guestNmKr,
		         						 'birthDay' : bb[n].birthDay,
		         						 'gender' : bb[n].gender,
		         						 'tel' :  bb[n].tel,
		         						 'adtFlag' : bb[n].adtFlag
		         						 
         						  }
         						  guestArr.push(guestInfosData);
         						 
         					 } //bb
         					 //성인,아동,나이
         					 var roomGrpsData = {
		         					'numOfAdt' :  aa[m].numOfAdt,  	//성인수  /
		         					'numOfChd'  : aa[m].numOfChd,  	//아동수 /
		         					'bedTypeId' : aa[m].bedTypeId,   //베드타입ID
		         					'numOfBeds' : aa[m].numOfBeds,        									//베드타입 옵션
		         					'smokingPref' : aa[m].smokingPref, 			//흡연/비흡연
		         					'roomTy'    : aa[m].roomTy,
		         					'guestInfos' :  guestArr                    ////투숙객정보  
		         					
		         			 };
         					 
         					if(basketData[i].setRoomData[0].suplrCd == 'GTA'){
         						roomGrpsData.roomId = basketData[i].setRoomData[0].roomTypeCd;
         					} else if(basketData[i].setRoomData[0].suplrCd == 'DOTW'){
         						roomGrpsData.roomId = basketData[i].setRoomData[0].rateInfos[0].rateType;
         					}
         					
         					roomGrps.push(roomGrpsData);
         				 }// aa
         			       			
		         		//console.log("###roomGrps=####"  + roomGrps);
	         			
	         			var checkindata = basketData[i].htlInfo.checkinDate;
	         			checkindata = checkindata.split('.');
	         			checkindata = checkindata[0] + "-" + checkindata[1] + "-" + checkindata[2];
	         			
	         			var checkoutdata = basketData[i].htlInfo.checkoutDate;
	         			checkoutdata = checkoutdata.split('.');
	         			checkoutdata = checkoutdata[0] + "-" + checkoutdata[1] + "-" + checkoutdata[2];
	         	        
	         			var fitMix =  (airYN == 'Y' ? 'A' : 'X')
						 			+ (hotelYN == 'Y' ? 'H' : 'X')
						 			+ (rentcarYN == 'Y' ? 'C' : 'X');
	         			
	         			//조식 여부
	         			var isBreak = basketData[i].setRoomData[0].isBreakFast;
	         			
	         			if(isBreak == null || isBreak == "") isBreak = 'N';
	         			//else isBreak = 'Y';  //huang 2018.03.05 말도 않되는 부분 주석함.
	         			
	         			var exchangeRate = basketData[i].exchangeRate;
	         			var whcExchangeRate = basketData[i].whcExchangeRate;
	         			var salesTax = basketData[i].setRoomData[0].rateInfos[0].salesTax;
	         			
	         			console.log("currencyCode==" + basketData[i].setRoomData[0].rateInfos[0].currencyCode);
	         			
	         			//프로모션적용가
	         			var promInfoData = basketData[i].setRoomData[0].rateInfos[0].promInfo;
						
					
						var total = 0;
						if(promInfoData != null && nullToBlank(promInfoData.aplPromTotal) != '' && custchk != "그룹직원") {
							//프로모션 적용가
							if(promInfoData.aplPromTotal > 0) {
								total = Math.ceil(parseFloat(promInfoData.aplPromTotal));
							} else {
								total = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].jtbTotal));		
							}
						} else if(custchk == "그룹직원") {
							total = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].bfTotal));
						} else {
							total = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].jtbTotal));	
						}
							
						
						console.log(total);
						var promAmt = 0;
						if(custchk == "그룹직원"){
							if(basketData[i].countryCd == 'KR' || countrychk.countryCode == 'KR'){
								promAmt = Math.floor(Math.ceil(basketData[i].setRoomData[0].rateInfos[0].bfTotal) * (ijwk * 0.01));
							} else {
								promAmt = Math.floor(Math.ceil(basketData[i].setRoomData[0].rateInfos[0].bfTotal) * (ijw * 0.01));
							}
						} else if(promInfoData.aplPromTotal > 0 && custchk != "그룹직원") {
							promAmt = Math.ceil(parseFloat(basketData[i].setRoomData[0].rateInfos[0].jtbTotal)) - Math.ceil(parseFloat(promInfoData.aplPromTotal));
						}
	         			//호텔 예약 정보 	         			
		         		var hotelSetData = {
		         				'fitMix' : fitMix,
		         				'hotelId' : basketData[i].hotelId,   		//호텔ID
		         				'hotelNmKr' : basketData[i].htlName[0],
		         				'hotelNmEn'	: basketData[i].htleName[0],
		         				'checkInDt' : checkindata,					//체크인날짜
		         				'checkOutDt' : checkoutdata,				//체크아웃날짜
		         				'cancelDl' : cancelPolicy,  										//취소규정   //공급사에서 받는 취소규정날짜를 그대로 보내라
		         				'suplrCd' : basketData[i].setRoomData[0].suplrCd,  								//공급사코드
		         				'rateKey' : basketData[i].setRoomData[0].rateInfos[0].rateKey,		//예약키
		         				'roomTypeCd' : basketData[i].setRoomData[0].roomTypeCd,				//룸타입코드
		         				'isBreakFast' : isBreak,          //조식여부
		         				'salesTax' : salesTax,          
		         				'rateCode' : basketData[i].setRoomData[0].rateCode,					//통화코드 
		         				'affiCfmAtionId' : '',  											//중복 예약방지 ID
		         				'affiCustId' : 'test',  											// 고객 ID
		         				'chargeableRate' : basketData[i].setRoomData[0].rateInfos[0].totalRate, //청구총금액  //totalPrice 
		         				'saleJtbAmt' : total,      //
		         				'specialInfo' :	$('#requestinfo').text(),								//고객요구사항
		         				'fitRsvCd' : '',   										//자유여행 예약번호
		         				'roomGrps' : roomGrps,												//룸정보
		         				'creditInfo' : creditInfo,     										//연락처 및 신용카드정보
		         				'addrInfo' : addrInfo, 												//주소정보 
		         				'currencyCd' : basketData[i].setRoomData[0].rateInfos[0].currencyCode,//"USD",		//EAN(통화기준)
		         				'exchangeRate': exchangeRate,										//환율
		         				'whcExchangeRate' : whcExchangeRate,								
		         				'pkgSavingsAmount' : basketData[i].setRoomData[0].rateInfos[0].pkgSavingsAmount,   //패키지 할인금액
		         				'cancelDlJtb':  basketData[i].setRoomData[0].rateInfos[0].cancelJtbDl,
		         				'checkInInst': basketData[i].setRoomData[0].checkInInst,
		         				'specCheckInInst': basketData[i].setRoomData[0].specCheckInInst,
		         				'cancellationPolicy' : basketData[i].setRoomData[0].rateInfos[0].cancellationPolicy,
		         				'markAmt' : basketData[i].setRoomData[0].rateInfos[0].markAmt,
		         				'promAmt' : promAmt																	//프로모션 적용금액
		         		};
		         		
		         		//console.log(">>>>>>>>총합계 금액<<<<<<<<<<=" + totalPrice * (parseInt(basketData[i].htlInfo.stayinfo.roomcnt)));
		         		
		         		console.log(hotelSetData);
		         		hoteRsvData.push(hotelSetData);
		         	}	
	         		
	         		hotelReserveInfo.basketData = hoteRsvData;
	         		//console.log(hotelReserveInfo.basketData);
	        	}
	        	
	        	
	        	
	        	if(nullToBlank(sessionStorage.rentcarSelData) != "" && sessionStorage.rentcarSelData != "[]"){
		        	var carInfo = JSON.parse(sessionStorage.rentcarSelData);
		        	var carReserveInfo = [];
		        	
		        	for(var i = 0; i < carInfo.length; i++){
		        		var pickupDt = carInfo[i].searchTakeDate.substring(0, 4) + "-" + carInfo[i].searchTakeDate.substring(4, 6) + "-" + carInfo[i].searchTakeDate.substring(6, 8);
		        		var pickupHm = carInfo[i].searchTakeTime.substring(0, 2) + ":" + carInfo[i].searchTakeTime.substring(2, 4);
		        		var rtDt = carInfo[i].searchReturnDate.substring(0, 4) + "-" + carInfo[i].searchReturnDate.substring(4, 6) + "-" + carInfo[i].searchReturnDate.substring(6, 8);
		        		var rtHm = carInfo[i].searchReturnTime.substring(0, 2) + ":" + carInfo[i].searchReturnTime.substring(2, 4);
		        		
		        		var tempCarInfo = {
		        			'supplier'		: carInfo[i].vendorCode,
		        			'carCode'		: carInfo[i].code,
		        			'paymentGb'		: 'POS',
		        			'nationCd'		: carInfo[i].nationCode,
		        			'rateCode'		: carInfo[i].rateCode,
		        			'pcNo'			: '',
		        			'pickupLoc'		: carInfo[i].pickupLoc,
		        			'pickupDt'		: pickupDt,
		        			'pickupHm'		: pickupHm,
		        			'rtLoc'			: carInfo[i].returnLoc,
		        			'rtDt'			: rtDt,
		        			'rtHm'			: rtHm,
		        			'equipTyCd1'	: '',
		        			'equipTyCd2'	: '',
		        			'equipTyCd3'	: '',
		        			'equipTyCd4'	: '',
		        			'equipTyCd1Qty'	: '',
		        			'equipTyCd2Qty'	: '',
		        			'equipTyCd3Qty'	: '',
		        			'equipTyCd4Qty'	: '',
		        			'operAgeGb'		: carInfo[i].operAgeGb,
		        			'operNmKr'		: carInfo[i].operNmKr,
		        			'operSurNm'		: carInfo[i].operSurNm,
		        			'operGivenNm'	: carInfo[i].operGivenNm,
		        			'telAreaNo'		: carInfo[i].telAreaNo,
		        			'telNo'			: carInfo[i].telNo,
		        			'emailAddr'		: carInfo[i].emailAddr,
		        			'memo'			: carInfo[i].memo,
		        			'userId'		: carInfo[i].userId
		        		}
		        		
		        		carReserveInfo.push(tempCarInfo);
		        	} 
	        	}
	        	
	        	reqReserveInfo = {
    	        	'concMix'		: results.rows.item(0).concMix,
    	        	'userId'		: results.rows.item(0).resUserId,
    	        	'userNm'		: results.rows.item(0).resKorNm,
    	        	'userEmail'		: results.rows.item(0).resEmail,
    	        	'userTel'		: telNo,
    	        	'saleAmtTot'	: results.rows.item(0).saleAmtTot,
    	        	'saleAmtAir'	: results.rows.item(0).saleAmtAir,
    	        	'saleAmtHtl'	: results.rows.item(0).saleAmtHtl,
    	        	'saleAmtRnt'	: results.rows.item(0).saleAmtRnt,
    	        	'airDiscntAmt'	: results.rows.item(0).airDiscntAmt,
    	        	'htlDiscntAmt'	: results.rows.item(0).htlDiscntAmt,
    	        	'rntDiscntAmt'	: results.rows.item(0).rntDiscntAmt
	        	}
	        	
	        	if(nullToBlank(fitRsvNo) != ""){
	        		reqReserveInfo.fitRsvNo = fitRsvNo;
	        	}
	        	
	        	var promotionInfo = JSON.parse(sessionStorage.promotionInfo);
	        	
	        	promReserve = {
	        		'promId'		: promotionInfo.promId,
	        		'promAmount'	: promotionInfo.promAmount,
	        		'promRate'		: promotionInfo.promRate,
	        	}
	        	
	            //마켓팅 활용동의    	
	        	reqReserveInfo.mkt_agree_yn = sessionStorage.mkt_agree_yn;
	        	
	        	var reserveInfoData = {
                	'airReserve' 		: airReserveInfo,
                	'hotelReserve' 		: hotelReserveInfo,
                	'rentcarReserve' 	: carReserveInfo,
                	'reqReserve'		: reqReserveInfo,
                	'airYN'				: airYN,
                	'hotelYN'			: hotelYN,
                	'rentcarYN'			: rentcarYN,
                	'promReserve'		: promReserve,
                }
	        	
	        	console.log(reserveInfoData);
	        	gfn_callAjaxs ('/fit/rsv/procRsvAjax.do', reserveInfoData, 'successReserve');
        	}
        }, jSessionID)
        
        // gfn_callAjax ('/fit/rsv/procRsvAjax.do', airReserveData.bodyDTO, 'successReserve');

        // gfn_callAjax ('/fit/rsv/procRsvAjax.do', JSON.parse(airReserveData).bodyDTO, 'successReserve');
        // gfn_callAjax ('/fit/rsv/procRsvAjax.do', JSON.parse(airReserveData), 'successReserve');

	}

    function successReserve(_data) {
    	var selAir = 'N';
    	var selHotel = 'N';
    	var selRentcar = 'N';
		
		if(nullToBlank(sessionStorage.airSelData) != "" && sessionStorage.airSelData != "[]"){
			selAir = 'Y';
        }
        
        if(nullToBlank(sessionStorage.hotelBasketData) != "" && sessionStorage.hotelBasketData != "[]"){
        	selHotel = 'Y';
        }

		if(nullToBlank(sessionStorage.rentcarSelData) != "" && sessionStorage.rentcarSelData != "[]"){
			selRentcar = 'Y';
		}

        var data = _data.result;
        console.log("예약화면상태=" + _data.result.code);
        
        if(_data.result.code == 1) {
        	
        	//fn_rsvHotelInfo();
        	
 	        // 예약 정보 관련 DB 를 날립니다.
	        fn_db_clearT();
	        fn_sesstionClear();
                
	       
	        setTimeout(function(){
	        	if(selHotel == "Y"){
	        		$("#fitRsvNoTxt").show();
	        		$("#fitRsvNoTxt").html("예약번호 : "+ _data.fitRsvNo);
	        		$("#sendEmailPop").data("url", "/pop/pop_email.do?rsvSeqno="+ _data.fitRsvNo);
	        		$("#successReserve").show();
	        		$("#failReserve").hide();
	        		
	        	}else{
	        		document.location.replace('/free_reserve/reserve_append_step5.do?selAir='+selAir+"&selHotel="+selHotel + "&selRentcar="+selRentcar + "&rsvSeqno="+_data.fitRsvNo);
	        	}
	        }, 100);
        } else {
            setAlert("예약이 되지 않았습니다.");
    		
            if(selHotel == "Y"){
            	$("#successReserve").hide();
        		$("#failReserve").show();
            }
        }
    }
    
    /*예약 호텔 정보*/
  /*  var fn_rsvHotelInfo = function() {
    	
    	 //호텔예약성공 데이터 
        var htlData = data.hotelResult;
        if(nullToBlank(htlData) != '') {
        	for(var i=0; i < htlData.length; i++) {
        		var rsvHotelInfo = [];
	        	var rsvHotelData = {
	        			'suplrCd' : rsvHotelInfo.suplrCd,
	        			'itineraryId' : rsvHotelInfo.itineraryId,
	        			'confirmNum' : confirmNum
	        	}
	        	rsvHotelInfo.push(rsvHotelData);
        	}
        	sessionStorage.rsvHotelData = JSON.stringify(rsvHotelInfo);
        }
    }*/


    /* 레이어 팝업 */
    var opener; 
    function layerOpen2(url,op,w,h,ok,ps,pa){
        $.ajax({
            type    : 'GET',
            url     : url,
            data    : pa,
            success    : function(html){
                //op.after(html);
                //opener = op;
                jQuery("body").append(html);
                var obj = jQuery(".layerPop"),                
                    wt = w,
                    ht = h;
                obj.parent().show();
                jQuery("html, body").css({"overflow":"hidden"});
                //jQuery("body").bind('touchmove', function(e){e.preventDefault()}); 아이폰 터치
                //if(ps) obj.find(".cntain").addClass("cntain3");
                if(wt){
                    if(ok){
                        obj.find(".popTpart").width(wt);
                        obj.find(".cntain").addClass("cntain2");
                        obj.find(".popCon").height(ht-51).css({"overflow":"scroll","min-height":"auto","overflow-x":"hidden"})
                        obj.width(wt).height(ht).css({"margin-top": (obj.height()/2)*-1+"px","margin-left": (obj.width()/2)*-1+"px"});
                        //if(ps) obj.find(".cntain").addClass("cntain4");
                        obj.find(".cntain").addClass("tc");
                        obj.find(".alert_text").height(ht-105);
                    }else{
                        obj.find(".popFoot").hide();
                        obj.find(".cntain").addClass("cntain2");
                        obj.find(".popTpart").width(wt);
                        obj.width(wt).height(ht).css({"margin-top": (obj.height()/2)*-1+"px","margin-left": (obj.width()/2)*-1+"px"});
                        obj.find(".alert_text").height();
                    };
                }else{
                    if(ok){
                        obj.find(".popFoot").addClass("posfd");
                        obj.css({"width":"100%","left":"0","top":"0","margin":"0","height":"100%","position":"relative"});
                        if(ps) obj.find(".cntain").addClass("cntain4");
                    }else{
                        obj.find(".popFoot").hide();
                        obj.find(".cntain").addClass("cntain2");
                        obj.css({"width":"100%","left":"0","top":"0","margin":"0","height":"100%","position":"relative"});
                    };
                };
                
            }
        });
    };

    // 항공 예약 취소 
    function cancelAirReserve(airRsvSeqno) {

        var airReserveInfo;
        airReserveInfo = {
           'rsvSeqno' : airRsvSeqno
        };
        
        gfn_callAjax ('/fit/rsv/procRsvAirCancelAjax.do', airReserveInfo, 'successAirRsvCancel');
    }

    function successAirRsvCancel(_data) {
        var data = _data.result;
        
        if(_data.result.code == 1) {
            console.log("airRsvSeqno : " + airRsvSeqno + " is Canceled");
        } else {
            console.log("airRsvSeqno : " + airRsvSeqno + " is not Canceled");
        }
    }
    
    
   //날짜 하루 더하기 
/*   function dateAdd(sDate, nDays) {
        var yy = parseInt(sDate.substr(0, 4), 10);
        var mm = parseInt(sDate.substr(5, 2), 10);
        var dd = parseInt(sDate.substr(8), 10);
     
        d = new Date(yy, mm - 1, dd + nDays);
     
        yy = d.getFullYear();
        mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
        dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
     
        return '' + yy + '-' +  mm  + '-' + dd;
    }
*/
    // 나이계산 스크립트 
    function calcAge(birth) {                 
        var date = new Date();
        var year = date.getFullYear();
        var month = (date.getMonth() + 1);
        var day = date.getDate();       
        if (month < 10) month = '0' + month;
        if (day < 10) day = '0' + day;
        var monthDay = month + day;
        
        // birth = birth.replace('-', '').replace('-', '');
        var birthdayy = birth.substr(0, 4);
        var birthdaymd = birth.substr(4, 8);
        
        // console.log("birthdayy : " + birthdayy + ", birthdaymd : " + birthdaymd);

        var age = monthDay < birthdaymd ? year - birthdayy - 1 : year - birthdayy;
        return age;
    } 

    // 나이계산 스크립트 
    function fn_getPaxTy(birth) {                 
        var paxTy = '';

        var age = calcAge(birth);
        
        if(age < 2){			// 유아
        	paxTy = 'INF';
        }else if(age < 12){		// 아이
        	paxTy = 'CHD';
        }else{ 					// 성인
        	paxTy = 'ADT';
        }

        return paxTy;
    } 

    // 전화번호 체크 스크립트 
    function checkTel(hp) {
        var tel = $(hp).val();
        // console.log(tel);

        if(tel == '') return;

        // 기존 번호에서 - 를 삭제합니다.
        var trans_num = tel.replace(/-/gi, "");

        // 입력값이 있을때만 실행합니다.
        if(trans_num != null && trans_num != '')
        {
            // 총 핸드폰 자리수는 11글자이거나, 10자여야 합니다.
            if(trans_num.length==11 || trans_num.length==10) 
            {   
                // 유효성 체크
                var regExp_ctn = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
                if(regExp_ctn.test(trans_num))
                {
                    // 유효성 체크에 성공하면 하이픈을 넣고 값을 바꿔줍니다.
                    trans_num = trans_num.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3");                  
                    $(hp).val(trans_num);
                }
                else
                {
                    alert("전화번호를 잘못 입력하셨습니다. 예) 010-1234-5678 ");
                    // $(hp).val("");
                    $(hp).focus();
                }
            }
            /** 
            else 
            {
                alert("전화번호를 잘못 입력하셨습니다. 예) 010-1234-5678 ");
                // $(hp).val("");
                $(hp).focus();
            }
            **/
        }
    }

    // 전화번호 체크 스크립트 
    function convertTel(hp) {

        // 입력값이 있을때만 실행합니다.
        if(hp != null && hp != '')
        {
            // 총 핸드폰 자리수는 11글자이거나, 10자여야 합니다.
            if(hp.length==11) 
            {   
                hp = hp.substring(0, 3) + "-" + hp.substring(3, hp.length - 4) + "-" +hp.substring(hp.length-4, hp.length);                
            } else if(hp.length==10) {
                 hp = hp.substring(0, 3) + "-" + hp.substring(3, hp.length-4) + "-" +hp.substring(hp.length-4, hp.length);                
            }
        }
        console.log("hp : " + hp);
        return hp;
    }

	// 예약 정보 관련 DB 를 날립니다.
	function fn_db_clearT() {
		rsvAirBodyDtoT.clearT();
		rsvAirSegmentGroupT.clearT();
		rsvAirPaxGroupT.clearT();
		rsvAirFareDataBeanT.clearT();
		
		rsvMstUserInfo.createT();
	}
	
	function fn_sesstionClear() {
		sessionStorage.clear();
	}



	// =============================================================================================
	// 기존 예약 관련 자바스크립트 함수 
	// =============================================================================================
	function limitText(field, maxChar){
		var ref = $(field);
		var val = ref.val();
		if ( val.length >= maxChar ){
			ref.val(function() {
				console.log(val.substr(0, maxChar))
				return val.substr(0, maxChar);       
			});
		}
	}


	// 천단위 콤마 2014.12.24. 이재형. 추가.
	function cf_comma(n) {
	var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
	  n += '';                          // 숫자를 문자열로 변환
	  while (reg.test(n))
		n = n.replace(reg, '$1' + ',' + '$2');
		 return n;
	}

	// 날짜에 . 붙인다
	function cf_setDateComm(strDate){
		return strDate.substring(0,4)+"."+strDate.substring(4,6)+"."+strDate.substring(6);
	}

	function limitText(field, maxChar){
		var ref = $(field);
		var val = ref.val();
		if ( val.length >= maxChar ){
			ref.val(function() {
				console.log(val.substr(0, maxChar))
				return val.substr(0, maxChar);       
			});
		}
	}

    //기존 함수 [AS-IS] LotteJTB js/common.js 내용. 시작. ================================================================
    //*----- 문자열 관련 함수 -----*//
    /**
     *이름 : ncCom_Today()
    *설명 : 현재날짜를 린턴한다
    *인자 : 날짜형태 '/','-'
    *리턴 : 날짜형태
    */
    function ncCom_Today(argFlag){
        if(typeof(argFlag) == "undefined") argFlag = ".";
        argFlag = argFlag.toUpperCase()
        //---- 호스트 날짜로 변경
        var day =""
        var today= gv.sdate; // 스크립트로 생성
        var y = (today.length>=4)? today.substr(0,4):"    ";
        var m =(today.length>=6)? today.substr(4,2):"  ";
        var d = (today.length>=8)? today.substr(6,2):"  ";
        switch (argFlag) {
            case "Y" : day = y;  break;
            case "M" : day = m;  break;
            case "D" : day = d;  break;
            case "YM" : day=y + "." + m ; break;
            default  : day = y + argFlag + m + argFlag + d;
        }
        return day;
    }
    /**
     *이름 : ncCom_Empty()
    *설명 : 공백여부체크한다
    *인자 : 체크할 문자
    *리턴 : true ,false
    */
    function ncCom_Empty(argStr){
        if (!argStr) return true;
        if (argStr.length == 0) return true;
        for (var i = 0; i<argStr.length; i++) {
            if ( (" " == argStr.charAt(i)) || ("　" == argStr.charAt(i)) )  {	}
            else return false;
        }
        return true;
    }
    /**
     *이름 : ncCom_DelBlank()
    *설명 : 공백을 제거한다
    *인자 : 제거할문자
    *리턴 : 문자열
    */
    function ncCom_DelBlank(argStr){
        var len = argStr.length;
        var retStr = "";
        argStr += "";
        for(var i=0; i<len; i++) {
            if((argStr.charAt(i)!=" ") && (argStr.charAt(i)!="　"))
                retStr += argStr.charAt(i);
        }
        return retStr;
    }
    /**
     *이름 : ncCom_SubstrHan()
    *설명 : 한글문자열길이만큼 가져옴
    *인자 : argStr : 문자열
    *		  argPos : 시작위치
    *          argLen : 종료위치
    *리턴 : 문자열
    *ex) ncCom_SubstrHan('가나다라마바사',2,3) = '다라마'
    */
    function ncCom_SubstrHan(argStr, argPos, argLen){
        var p1 = sub_HanLen(argStr, argPos);
        var p2 = sub_HanLen(argStr, (argPos + argLen));
        return (argStr.substr(p1, p2-p1));
    }
    /**
     *이름 : ncCom_Replace()
    *설명 : 한글문자열길이만큼 가져옴
    *인자 : originalString : 문자열
    *		  findText : 찾을 문자열
    *          replaceText : 바꿔야할 문자열
    *리턴 : 문자열
    *ex) ncCom_Replace('테스트다','스','타') = ' 테타트다'
    */
    function ncCom_Replace(originalString, findText, replaceText){
        originalString = ncCom_Trim(originalString)
        var pos = 0
        var preStr = ""
        var postStr = ""
        pos = originalString.indexOf(findText)
        while (pos != -1) {
            preString = originalString.substr(0,pos)
            postString = originalString.substring(pos+findText.length)
            originalString = preString + replaceText + postString
            pos = originalString.indexOf(findText)
        }
        return originalString
    }
    /**
     *이름 : ncCom_Trim()
    *설명 : 문자열 공백제거
    *인자 : 문자열
    *리턴 : 문자열
    *ex) ncCom_Trim(' 테스트다 ') = '테스트다'
    */
    function ncCom_Trim(argStr){
        if(argStr == null)
            return "";
        argStr = argStr.toString();
        var pos1, pos2
        for(pos1=0; (argStr.charAt(pos1) == ' ' || argStr.charAt(pos1) == '　') && pos1 < argStr.length ; pos1++) ;
            for(pos2=argStr.length-1; (argStr.charAt(pos2) == ' ' || argStr.charAt(pos2) == '　') && pos2 >= 0 ; pos2--) ;
                if(pos1 > pos2) return ""
        return argStr.substr(0,pos2+1).substring(pos1)
    }
        //*----- 입력 필드 관련 함수 -----*//
    /**
     *이름 : ncCom_ErrField()
    *설명 :  입력필드 입력여부확인
    *인자 :
                argObj : 입력필드명
                argTitle : 공백일경우 메세지
    *리턴 : true, false
    *ex) ncCom_ErrField(입력필드명)
    */
    function ncCom_ErrField(argObj, argTitle){
        if (argTitle==null) argTitle = argObj.title
        ncCom_ColorField(argObj);
        return false
    }
        //*----- 날짜 관련 함수 -----*//
    /**
     *이름 : ncCom_CheckDate()
    *설명 :  From ~ To 체크  , 시작날짜가 종료날짜보다 크면 false 를 리턴
    *인자 :
                argFrom : 시작날짜
                argTitle : 종료날짜
                argSign : 날짜 형태 ('-','.'...)
    *리턴 : true, false
    *ex) ncCom_CheckDate('2002-02-01','2003-03-01','-')
    */
    function ncCom_CheckDate(argFrom,argTo,argSign){
        var intFrom = parseInt(ncCom_Replace(argFrom,argSign,""));
        var intTo = parseInt(ncCom_Replace(argTo,argSign,""));
        if((intFrom-intTo)>0) {
            return(false);
        }
        return(true);
    }
    /**
     *이름 : ncCom_DiffDate()
    *설명 : 날짜 차이를 일로계산 한다
    *인자 :
                fromDate : 시작날짜
                toDate : 종료날짜

    *리턴 : 날짜차이일
    *ex) ncCom_DiffDate('2002-02-01','2003-03-01')
    */
    function ncCom_DiffDate(fromDate, toDate) {
        var MinMilli = 1000 * 60;
        var HrMilli = MinMilli * 60;
        var DyMilli = HrMilli * 24;
        var d1 = new Date(ncCom_Replace(fromDate, "-", "/"));
        var d2 = new Date(ncCom_Replace(toDate, "-", "/"));
        var d3 = d2-d1;
        var str = d3 /DyMilli ;
        return str;
    }
    /**
     *이름 : ncCom_DiffMonthDate()
    *설명 : 월 차이를  계산 한다
    *인자 :
                fromDate : 시작날짜
                toDate : 종료날짜
    *리턴 : 날짜개월수
    *ex) ncCom_DiffMonthDate('2002-02-01','2003-03-01')
    */
    function ncCom_DiffMonthDate(fromDate, toDate) {
        var fromYear =  "";
        var toYear = "";
        var fromMonth = "";
        var toMonth = "";
        fromYear = parseInt( fromDate.substring(0,4) ) ;
        toYear = parseInt(toDate.substring(0,4) ) ;
        fromMonth =  fromDate.substring(5,7);
        toMonth  = toDate.substring(5,7);
        if (fromMonth.length == 2) {
            if(fromMonth.substring(0,1) == '0')  fromMonth = parseInt(fromMonth.substring(1,2));
            else fromMonth = parseInt(fromMonth);
        }else {
            fromMonth = parseInt(fromMonth);
        }
        if (toMonth.length == 2) {
            if(toMonth.substring(0,1) == '0')  toMonth = parseInt(toMonth.substring(1,2));
            else toMonth = parseInt(toMonth);
        }else {
            toMonth = parseInt(toMonth);
        }
        return ( (toYear - fromYear) * 12 ) + (  toMonth - fromMonth) ;
    }

    function ncCom_ColorField(argField) {
        if (argField.tagName == "SELECT" ) {
            argField.style.backgroundColor = '#EEFFB6'
            argField.focus()
            return;
        }
        argField.style.backgroundColor = '#EEFFB6'
        argField.select()
        argField.focus()
    }
    //*----- 날짜 계산 관련 함수 -----*//
    /**
     *이름 : ncCom_CalcDate2()
    *설명 :  기준일자에서 특정 기간을 ±(하루,한달,일년
    *인자 :
                argDate : 기준날짜
                toDate : 특정기간
    *리턴 : 날짜차이일
    *ex) ncCom_CalcDate2('20030203','-d')  = 20030202
    */
    function ncCom_CalcDate2(argDate, argFlag){
        var year	= argDate.substr(0,4);
        var month	= argDate.substr(4,2);
        var day		= argDate.substr(6,2);
        switch(argFlag) {
        case "-d" :
            day = parseInt(day,10)-1
            if ( day == 0 ){
                month --;
                if ( month == 0 ){
                    year --;
                    month = 12;
                }
                day = ncCom_MaxDay(year, month);
            }
            break;
        case "+d" :
            day = parseInt(day,10)+1
            if ( day > ncCom_MaxDay(year, month) ) {
                month ++;
                if ( month == 13 ){
                    year ++;
                    month=1;
                }
                day = 1;
            }
            break;
        case "-m" :
            month = parseInt(month,10)-1
            if ( month == 0 ){
                year --;
                month = 12;
            }
            break;
        case "+m" :
            month = parseInt(month,10)+1
            if ( month == 13 ){
                year ++;
                month=1;
            }
            break;
        case "-y" :
            year = parseInt(year)-1
            month = parseInt(month,10)
            break;
        case "+y" :
            year = parseInt(year)+1
            month = parseInt(month,10)
            break;
        }
        if ( (argFlag.substr(1,1) == 'm' ) || (argFlag.substr(1,1) == 'y' )) {
            tempmaxday = ncCom_MaxDay(year, month)
            if ( day > tempmaxday ) day = tempmaxday;
        }
        month = parseInt(month,10)
        if ( month < 10 ) month="0"+month;
        day = parseInt(day,10)
        if ( day < 10) day = "0" + day;
        return( year+""+month+""+day+"" );
    }
    function ncCom_MaxDay(argYear, argMonth){
        var cDate = new Array(29, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
        var lastday = cDate[ argMonth-0 ]
        if( argMonth == 2 && ((argYear%4==0 && argYear%100!=0) || (argYear%400==0)) )
        lastday = cDate[0];
        return lastday;
    }
    //특정날짜의 요일 가져오기
    function getWeek( value ) {
        var currentDate = new Date();
        var year = parseInt( value.substring(0,4),  10);
        var mon  = parseInt( value.substring(4,6),  10);
        var day  = parseInt( value.substring(6,8), 10);
        var cdate = new Date(year, mon-1, day);
        var weekNumber = cdate.getDay();
        var weekName = "";
            switch (weekNumber)
            {
                case 0 : weekName = "일"; break;
                case 1 : weekName = "월"; break;
                case 2 : weekName = "화"; break;
                case 3 : weekName = "수"; break;
                case 4 : weekName = "목"; break;
                case 5 : weekName = "금"; break;
                case 6 : weekName = "토"; break;
                default : weekName = "일"; break;
            }
        return weekName;
    }
    /**
     * Copyright (c) 2006 by [] All rights reserved.
     * 공통 스크립트
     * @version 1.1, 2006-11-22
     */
    if (document.getElementById && !document.all) {
        var isNS = true;
        var isIE = false;
    } else {
        var isIE = true;
        var isNS = false;
    }
    /**
     * StingBuffer 함수생성 - 자바의 StringBuffer 와 같다
     * IE 에서는 문자열간 + 성능이 낮기 때문에
     * 많은 양의 문자열 연산은 StringBuffer 함수 사용권장
     *
     * append() : 순서대로 문자열을 추가한다.
     * toString() : 문자열로 반환한다.
     *
     * ex) var sb = new StringBuffer();
     *         sb.append('test');
     *         alert(sb.toString());
     */
    var StringBuffer = function(){
        this.buffer = new Array();
    }
    StringBuffer.prototype.append = function( strValue ){
        this.buffer.push( strValue ); //IE5.5 NS4
    }
    StringBuffer.prototype.toString = function(){
        return this.buffer.join(""); //IE4 NS3
    }
    String.prototype.trim = function() {
        return this.replace(/(^\s*)|(\s*$)/gi, "");
    }
    String.prototype.replaceAll = function(str1, str2) {
        var temp_str = this.trim();
        temp_str = temp_str.replace(eval("/" + str1 + "/gi"), str2);
        return temp_str;
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // 입력값 체크
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    /**
     * 입력값이 NULL인지 체크
     */
    function f_IsNull(obj) {
        if (obj.value == null || obj.value == "") {
            return true;
        }
        return false;
    }
    /**
     * 입력값에 스페이스 이외의 의미있는 값이 있는지 체크
     */
    function f_IsEmpty(obj) {
        if (obj.value == null || obj.value.replace(/ /gi,"") == "") {
            return true;
        }
        return false;
    }
    /**
     * NULL일 경우 임의의 Object 리턴 vary
     */
    function nvl(obj, ch) {
        var _ch = '';
        if (typeof ch != 'undefined')
            _ch = ch;
        if (typeof obj == 'undefined' || obj == null || obj == '')
            return _ch;
        else
            return obj;
    }
    /**
     * 입력값에 특정 문자(chars)가 있는지 체크
     * 특정 문자를 허용하지 않으려 할 때 사용
     *
     * ex) if (containsChars(form.name,"!,*&^%$#@~;")) {
     *         alert("이름 필드에는 특수 문자를 사용할 수 없습니다.");
     *     }
     */
    function f_ContainsChars(obj,chars) {
        for (var inx = 0; inx < obj.value.length; inx++) {
        if (chars.indexOf(obj.value.charAt(inx)) != -1)
            return true;
        }
        return false;
    }
    /**
     * 입력값이 특정 문자(chars)만으로 되어있는지 체크
     * 특정 문자만 허용하려 할 때 사용
     * ex) if (!f_ContainsCharsOnly(form.blood,"ABO")) {
     *         alert("혈액형 필드에는 A,B,O 문자만 사용할 수 있습니다.");
     *     }
     */
    function f_ContainsCharsOnly(obj,chars) {
        for (var inx = 0; inx < obj.value.length; inx++) {
        if (chars.indexOf(obj.value.charAt(inx)) == -1)
            return false;
        }
        return true;
    }
    function f_IsAlphabet(obj) {
        var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        return f_ContainsCharsOnly(obj,chars);
    }
    /**
     * 입력값이 알파벳 대문자인지 체크
     */
    function f_IsUpperCase(obj) {
        var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        return f_ContainsCharsOnly(obj,chars);
    }
    /**
     * 입력값이 알파벳 소문자인지 체크
     */
    function f_IsLowerCase(obj) {
        var chars = "abcdefghijklmnopqrstuvwxyz";
        return f_ContainsCharsOnly(obj,chars);
    }
    /**
     * 입력값에 숫자만 있는지 체크
     */
    function f_IsNumber(obj) {
        var chars = "0123456789";
        return f_ContainsCharsOnly(obj,chars);
    }
    /**
     * 입력값이 알파벳,숫자로 되어있는지 체크
     */
    function f_IsAlphaNum(obj) {
        var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        return f_ContainsCharsOnly(obj,chars);
    }
    /**
     * 입력값이 숫자,대시(-)로 되어있는지 체크
     */
    function f_IsNumDash(obj) {
        var chars = "-0123456789";
        return f_ContainsCharsOnly(obj,chars);
    }
    /**
     * 입력값이 숫자,콤마(,)로 되어있는지 체크
     */
    function f_IsNumComma(obj) {
        var chars = ",0123456789";
        return f_ContainsCharsOnly(obj,chars);
    }
    /**
     * 입력값이 숫자,콤마(,)로 되어있는지 체크
     */
    function f_IsNumDot(obj) {
        var chars = ".0123456789";
        return f_ContainsCharsOnly(obj,chars);
    }
    /**
     * 입력값에서 콤마를 없앤다.
     */
    function f_RemoveComma(obj) {
        return obj.value.replace(/,/gi,"");
    }
    /**
     * 입력값이 사용자가 정의한 포맷 형식인지 체크
     * 자세한 format 형식은 자바스크립트의 'regular expression'을 참조
     */
    function f_IsValidFormat(obj,format) {
        if (obj.value.search(format) != -1) {
            return true; //올바른 포맷 형식
        }
        return false;
    }


    /**
     * 입력값이 사용자가 정의한 포맷 형식인지 체크
     * 자세한 format 형식은 자바스크립트의 'regular expression'을 참조
     */
    function f_IsValidFormatCheck(obj,format) {
        if (obj.search(format) != -1) {
            return true; //올바른 포맷 형식
        }
        return false;
    }

    /**
     * 입력값이 이메일 형식인지 체크
     */
    function f_IsValidEmail2(obj) {
        var format = /^((\w|[\-\.])+)\.([A-Za-z]+)$/;
        return f_IsValidFormat(obj,format);
    }

    /**
     * 입력값이 이메일 형식인지 체크
     */
    function f_IsValidEmail(obj) {
        var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
        return f_IsValidFormat(obj,format);
    }

    /**
     * 입력값이 이메일 형식인지 체크
     */
    function f_IsValidEmailCheck(val) {
        var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
        return f_IsValidFormatCheck(val,format);
    }

    /**
     * 입력값이 전화번호 형식(숫자-숫자-숫자)인지 체크
     */
    function f_IsValidPhone(obj) {
        var format = /^(\d+)-(\d+)-(\d+)$/;
        return f_IsValidFormat(obj,format);
    }

 	
    /**
     * 선택된 라디오버튼이 있는지 체크
     */
    function f_HasCheckedRadio(obj) {
        if (obj.length > 1) {
            for (var inx = 0; inx < obj.length; inx++) {
                if (obj[inx].checked) return true;
            }
        } else {
            if (obj.checked) return true;
        }
        return false;
    }
    /**
     * 선택된 체크박스가 있는지 체크
     */
    function f_HasCheckedBox(obj) {
        return f_HasCheckedRadio(obj);
    }
    /**
     * 문자열내의 왼쪽, 오른쪽의 공백을 제거.
     */
    function f_Trim(str) {
        str = f_LTrim( str );
        str = f_RTrim( str );
        return str;
    }
    /**
     * 문자열내의 왼쪽 공백을 제거.
     */
    function f_LTrim( str ) {
        var iLen = str.length;
        var idx = 0;
        for(idx=0 ; idx<iLen; idx++ ) {
            if( str.charAt(idx)!=' ' ) break
        }
        return str.substring( idx,iLen );
    }
    /**
     * 문자열내의 오른쪽 공백을 제거.
     */
    function f_RTrim( str ) {
        var iLen = str.length;
        var idx = 0;
        for(idx=iLen-1 ; idx>=0; idx-- ) {
            if( str.charAt(idx)!=' ' ) break;
        }
        return str.substring( 0,idx+1 );
    }
    /**
     * 구분자를 기준으로 각 값들을 분리하여 배열로 Return
     */
    function f_GetTokenComma(val,patt ) {
        var i = 0, iFst=0;
        var sCheckValue=val;
        var arrRst = new Array();
        while ((iFst = sCheckValue.indexOf(patt)) >= 0) {
            if(iFst!=0) arrRst[i++] = sCheckValue.substring(0,iFst);
            else if(iFst == 0) arrRst[i++] = "";
            sCheckValue = sCheckValue.substring(iFst+1, sCheckValue.length);
        }
        arrRst[i] = sCheckValue;
        return arrRst;
    }
    /**
     * 우편번호에서 '-'을 제거하는 함수
     */
    function f_GetRawZip(samt) {
        if(samt==null || samt=="") return "";
        return samt.replace( /-/g,"");
    }
    /**
     * 우편번호를 '-'을 붙인 형식으로 변환
     */
    function f_ConvertZip(sval) {
        sval = getRawZip(sval);
        if(sval.length!=6) return "";
        return sval.substring(0,3) + "-" + sval.substring(3,6);
    }
    /**
     * dot 위치 찾기
     */
    function f_Dotindex(obj) {
        for (var inx = 0; inx < obj.length; inx++) {
        if (obj.value.charAt(inx) == ".")
            return inx;
            break;
        }
    }
    /**
     * 특정 문자포함 했는지
     */
    function f_IscontainsChars(obj,chars) {
        for (var inx = 0; inx < obj.length; inx++) {
        if (chars.indexOf(obj.value.charAt(inx)) == -1)
            return false;
        }
        return true;
    }
    /**
     * value(숫자)를 format 형식으로 변환 (예: 1234.23)
     * 사용형식 : convertDataFormat(value, "####.##")
     */
    function f_ConvertDataFormat(value, format) {
        var temp0 = "";
        var temp1 = "";
        var temp2 = "";
        var tempArrVal  = new Array();
        var formatArrVal = new Array();
        tempArrVal =  getTokenComma(escape(value), '.');
        if(tempArrVal[0].substring(0,1)=="-")
        temp0 = "-";
        formatArrVal =  getTokenComma(format, '.');
        tempArrVal[0] = getRawDate(tempArrVal[0]);
        if(formatArrVal[0].length > tempArrVal[0].length) {
            if(temp0 =="-")
                temp1 = temp0 + tempArrVal[0];
                else
                temp1 =  tempArrVal[0];
        } else {
            if(temp0 =="-")
                temp1 = temp0 + tempArrVal[0].substring(tempArrVal[0].length - formatArrVal[0].length, tempArrVal[0].length);
            else
            stemp1 =  tempArrVal[0].substring(tempArrVal[0].length - formatArrVal[0].length, tempArrVal[0].length);
        }
        if(tempArrVal[1] == null) {
            if(formatArrVal[1] == null) {
            } else {
                for(ii = 0; ii < formatArrVal[1].length; ii++) {
                    temp2 += "0";
                }
                temp2 = "." + temp2;
            }
        } else {
            if(formatArrVal[1].length > tempArrVal[1].length) {
                temp2 += "." + tempArrVal[1];
                for(ii = 0; ii < formatArrVal[1].length - tempArrVal[1].length; ii++) {
                    temp2 += "0";
                }
            } else {
                temp2 = "." + tempArrVal[1].substring(0, formatArrVal[1].length);
            }
        }
        return temp1 + temp2;
    }

    /**
     * 주민등록번호를 체크한 후 '-'을 붙인 형식으로 변환
     */
    function f_PersonalIDCheck(sID) {
        sID = getRawDate(sID);
        if(sID.length!=13) return "";
        return sID.substring(0,6)+"-"+sID.substring(6,13);
    }
    /**
     * 숫자를 금액형식(3,000,000) 으로 변환한다.
     */
    function f_ConvertMoney(obj) {
        var sVal = obj.value;
        var sPatt = /\,/g;              // Pattern 정의
        sVal = sVal.replace(sPatt,"");  // comma를 blank로 변경
        if (isNaN(sVal)) {
            alert("숫자만 입력하셔야 합니다.");
            return;
        }
        var sRst="";  // 결과값
        var iOrd=sVal.length;  // 길이
        if((sVal.substring(0,1)) == "-") {
            sVal = sVal.substring(1,iOrd);
            iOrd -= 1; sRst = "-";
        }
        for(var i = 0; i < sVal.length; i++) {
            sRst += sVal.substring(i,i+1);
            if(iOrd != 1 && (iOrd-1) % 3 == 0) sRst += ",";
            iOrd -= 1;
        }
        return sRst;
    }
    /**
     * 한글 길이를 체크하여 리턴한다.
     */
    function f_HanLengthCheck(data) {
        var totlen = 0;
        var datalen = data.length;
        for(var i = 0;i < datalen; i ++)
        {
            var tmp = data.substring(i,i+1);
            if( escape(tmp).length > 4 ) totlen = totlen + 2;
            else totlen = totlen + 1;
        }
            return totlen;
    }
    /**
     * 입력값의 바이트 길이를 리턴
     */
    function f_GetByteLength(obj) {
        var byteLength = 0;
        for (var inx = 0; inx < obj.value.length; inx++) {
            var oneChar = escape(obj.value.charAt(inx));
            if ( oneChar.length == 1 ) {
                byteLength ++;
            } else if (oneChar.indexOf("%u") != -1) {
                byteLength += 2;
            } else if (oneChar.indexOf("%") != -1) {
                byteLength += oneChar.length/3;
            }
        }
        return byteLength;
    }
    /**
     * 입력객체와 입력MAX값을 받아 입력값을 조절한다.
     * maxbyte이내 입력을 못 받도록 조절
     * 사용 방법 : onKeyUp="javascript:f_Cal_byte(this, 10);"
     */
    function f_Cal_byte(aquery, maxbyte) {
        var tmpStr;
        var temp=0;
        var onechar;
        var tcount;
        tcount = 0;
        var obj = document.getElementById(aquery);
        tmpStr = new String(obj.value);
        temp = tmpStr.length;
        for (k=0;k<temp;k++) {
            onechar = tmpStr.charAt(k);
            if (escape(onechar).length > 4) {
                tcount += 3;    //UTF-8
                //tcount += 2;
            } else if (onechar!='\r') {
                tcount++;
            }
        }
        if (tcount > maxbyte) {
            reserve = tcount-maxbyte;
            alert("입력가능한 크기는 영문"+maxbyte+"자 한글 "+maxbyte/2+"자 이내입니다.");
            f_CutText(obj,maxbyte);
            return;
        }
    }
    /**
     * 문자열 자름
     */
    function f_CutText(aquery,maxbyte) {
        f_Nets_check(aquery, maxbyte);
    }
    /**
     * 문자열 자름
     */
    function f_Nets_check(aquery,max) {
        var tmpStr;
        var temp=0;
        var onechar;
        var tcount;
        tcount = 0;
        tmpStr = new String(aquery.value);
        temp = tmpStr.length;
        for (k=0;k<temp;k++) {
            onechar = tmpStr.charAt(k);
            if(escape(onechar).length > 4) {
                tcount += 3;
            } else if(onechar!='\r') {
                tcount++;
            }
            if(tcount>max) {
                tmpStr = tmpStr.substring(0,k);
                break;
            }
        }
        if (max == max) {
            aquery.value = tmpStr;
            f_Cal_byte(tmpStr);
        }
        return tmpStr;
    }
    /**
     * NULL 여부 리턴
     */
    function f_IsNullVal(pm_val){
        if (pm_val == null || pm_val == undefined || pm_val.toString().replace(/ /g,"") == ""){
            return true;
        }
        return false;
    }
    /**
     * 숫자만 입력하게 하는 함수
     * ex) : onkeypress="f_Onlynum()" style="ime-mode:disabled"
     */
    function f_Onlynum() {
        e = window.event;
        //숫자열 0 ~ 9 : 48 ~ 57, 키패드 0 ~ 9 : 96 ~ 105 ,8 : backspace, 46 : delete -->키코드값을 구분합니다. 저것들이 숫자랍니다.
        if(e.keyCode >= 48 && e.keyCode <= 57 || e.keyCode >= 96 && e.keyCode <= 105 || e.keyCode == 8 || e.keyCode == 9 || e.keyCode == 46)
        {
            return; //-->입력시킨다.
        }
        else //숫자가 아니면 넣을수 없다.
            e.returnValue=false;
    }
    /**
     * 숫자만 입력하게 하는 함수
     * ex) : onkeypress="f_OnlyAlph()" style="ime-mode:disabled"
     */
    function f_OnlyAlph() {
        e = window.event;
        //알파벳:65~90 ,8 : backspace, 46 : delete -->키코드값을 구분합니다. 저것들이 숫자랍니다.
        if(e.keyCode >= 65 && e.keyCode <= 90  || e.keyCode == 8 || e.keyCode == 9 || e.keyCode == 46 )
        {
            return; //-->입력시킨다.
        }
        else //숫자가 아니면 넣을수 없다.
            e.returnValue=false;
    }
    /**
     *  해당 폼에 모든 체크박스를 선택한다.
     */
    function f_CheckAll(aObj) {
        var elem = isIE ? aObj.all.tags('INPUT') : aObj.getElementsByTagName("INPUT");
        for (var i = 0; i < aObj.length; i++) {
            if (elem[i].type != "checkbox") continue;
            elem[i].checked = true;
        }
    }
    /**
     *  해당 폼에 모든 체크박스의 선택을 취소한다.
     */
    function f_UncheckAll(aObj) {
        var elem = isIE ? aObj.all.tags('INPUT') : aObj.getElementsByTagName("INPUT");
        for (var i = 0; i < elem.length; i++) {
            if (elem[i].type != "checkbox") continue;
            elem[i].checked = false;
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    //날짜, 시간 관련 함수
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    /**
    * 오늘날짜 가져오기
    */
    function f_Today() {
        var date = new Date();
        var year = date.getYear();
        var month = date.getMonth() + 1;
        var day = date.getDate();
        if (("" + month).length==1){month = "0"+month;}
        if (("" + day).length==1){day = "0"+day;}
        var today = year+""+month+""+day;
        return today;
    }
    /**
     * 년월 6자리 날짜 valid Check
     * valid이면 YYYY-MM의 형식으로 리턴
     * invalid이면 ""로 리턴
    */
    function f_IsYYYYMM(sDate) {
        sDate = getRawDate(sDate);
        var sYear = "", sMonth = "";
        var iYear = 0, iMonth = 0;
        if(sDate.length != 6) {
            return "";
        } else {
            sYear = sDate.substring(0,4);
            sMonth = sDate.substring(4,6);
        }
        if(isNaN(sYear) || isNaN(sMonth)) return "";
        iYear = parseInt(sYear,'10');
        iMonth = parseInt(sMonth,'10');
        if (iYear < 0001) iYear = 0;
        if (iMonth < 01 || iMonth > 12)  iMonth = 0;
        if(iYear == 0 || iMonth == 0 ) return "";
        return sYear+"-"+sMonth;
    }
    /**
     * 년월일 8자리 날짜 valid Check
     * valid이면 YYYY-MM-DD의 형식으로 리턴
     * invalid이면 ""로 리턴
     */
    function f_IsYYYYMMDD(sDate) {
        sDate = getRawDate(sDate);
        var sYear = "", sMonth = "", sDay = "";
        var iYear = 0, iMonth = 0, iDay = 0;
        if(sDate.length != 8) {
            return "";
        } else {
            sYear = sDate.substring(0,4);
            sMonth = sDate.substring(4,6);
            sDay = sDate.substring(6,8);
        }
        if(isNaN(sYear) || isNaN(sMonth) || isNaN(sDay)) return "";
        iYear = parseInt(sYear,'10');
        iMonth = parseInt(sMonth,'10');
        iDay = parseInt(sDay,'10');
        if (iYear < 1) iYear = 0;
        if (iMonth < 1 || iMonth > 12)  iMonth = 0;
        if (iDay < 1) iDay = 0;
        if ( iMonth == 1 || iMonth == 3 || iMonth == 5 || iMonth == 7 || iMonth == 8 ||
            iMonth == 10 || iMonth == 12)  {
            if (iDay > 31) iDay = 0;
        } else if (iMonth == 4 || iMonth == 6 ||  iMonth == 9 || iMonth == 11) {
            if (iDay > 30) iDay = 0;
        } else if (iMonth == 2 )  {
            if (iYear % 4 != 0 || (iYear % 100 == 0 && iYear % 400 != 0)) {
                if (iDay > 28) iDay = 0;
            } else if (iDay > 29) iDay = 0;
        }
        if(iYear == 0 || iMonth == 0 || iDay == 0) return "";
        return sYear+"-"+sMonth+"-"+sDay;
    }
    /**
     * 년월일 8자리 날짜 년월일로 변경
     */
    function f_YYYYMMDDKo(sDate) {
        sYear = sDate.substring(0,4);
        sMonth = sDate.substring(4,6);
        sDay = sDate.substring(6,8);
        return sYear + "년 " + sMonth + "월 " + sDay + "일";
    }
    /**
     * YYYYMMDD를 YYYY-MM-DD로 변경
     */
    function f_YYYYMMDDFull(sDate) {
        var sYear = sDate.substring(0,4);
        var sMonth = sDate.substring(4,6);
        var sDay = sDate.substring(6,8);
        return sYear + "-" + sMonth + "-" + sDay;
    }
    /**
     * 6자리 YYMMDD 날짜를 8자리 YYYYMMDD 날짜로 변환
     * sDate = '01-11-11' 이런 형태도 가능
     */
    function f_ToYYYYMMDD(sDate) {
        sDate = getRawDate(sDate);
        if(sDate.length!=6) return "";
        return "20"+sDate;
    }
    /**
     * 8자리 YYYYMMDD 날짜를 6자리 YYMMDD의 RAW 날짜로 변환
     * sDate = '2001-11-11' 이런 형태도 가능
     */
    function f_ToYYMMDD(sDate) {
        sDate = getRawDate(sDate);
        if(sDate.length!=8) return "";
        return sDate.substring(2,8);
    }
    /**
     * 6자리 YYYYMM 및 8자리 YYYYMMDD 날짜를 6자리 YYYYMM의 RAW 날짜로 변환
     * sDate = '2001-11-11' or '2001-11' 이런 형태도 가능
     */
    function f_ToYYYYMM(sDate) {
        sDate = getRawDate(sDate);
        if(sDate.length!=8 && sDate.length!=6) return "";
        if(sDate.length==8) sDate = sDate.substring(0,6);
        return sDate;
    }
    /**
     * 4자리 시간 valid Check
     * valid이면 HH:MM의 형식으로 리턴
     * invalid이면 ""로 리턴
    */
    function f_IsHHMM(sTime) {
        sTime = getRawTime(sTime);
        var sHour = "", sMinute = "";
        var iHour = 0, iMinute = 0;
        if(sTime.length != 4) {
            return "";
        } else {
            sHour = sTime.substring(0,2);
            sMinute = sTime.substring(2,4);
        }
        if(isNaN(sHour) || isNaN(sMinute)) return "";
        iHour = parseInt(sHour,'10');
        iMinute = parseInt(sMinute,'10');
        if(iHour<00 || iHour>=24) iHour = -1;
        if(iMinute<00 || iMinute>=60) iMinute = -1;
        if(iHour==-1 || iMinute==-1 ) return "";
        return sHour+":"+sMinute;
    }
    /**
     * 6자리 시간 valid Check
     * valid이면 HH:MM:SS의 형식으로 리턴
     * invalid이면 ""로 리턴
    */
    function f_IsHHMMSS(sTime) {
        sTime = getRawTime(sTime);
        var sHour = "", sMinute = "", sSec = "";
        var iHour = 0, iMinute = 0, iSec = 0;
        if(sTime.length != 6) {
            return "";
        } else {
            sHour = sTime.substring(0,2);
            sMinute = sTime.substring(2,4);
            sSec = sTime.substring(4,6);
        }
        if(isNaN(sHour) || isNaN(sMinute) || isNaN(sSec)) return "";
        iHour = parseInt(sHour,'10');
        iMinute = parseInt(sMinute,'10');
        iSec = parseInt(sSec,'10');
        if(iHour<00 || iHour>=24) iHour = -1;
        if(iMinute<00 || iMinute>=60) iMinute = -1;
        if(iSec<00 || iSec>=60) iSec = -1;
        if(iHour==-1 || iMinute==-1 || iSec==-1) return "";
        return sHour+":"+sMinute+":"+sSec;
    }
    /**
     * 날짜입력값에서 구분자인 '/', '.', '-',':' 등을 제거하여 리턴
     */
    function f_GetRawTime(sTime) {
        return getRawDate(sTime);
    }
    /**
     * 날짜입력값에서 구분자인 '/', '.', '-',':' 등을 제거하여 리턴
     */
    function f_GetRawDate(sDate) {
        if(sDate==null || sDate == "") return "";
        sDate = sDate.replace(/\//g,"");
        sDate = sDate.replace(/-/g,"");
        sDate = sDate.replace(/\./g,"");
        sDate = sDate.replace(/\:/g,"");
        return sDate;
    }
    /**
     * 날짜를 체크하고 YYYY.MM.DD로 convert
     */
    function f_ConvertDate(obj) {
        var retDate = obj.value;
        if( retDate==null || retDate=="" ) return;
        if( (retDate=isYYYYMMDD(retDate))=="" ) return;
        else return obj.value = retDate;
    }
    /**
     * 유효한(존재하는) 월(月)인지 체크
     */
    function f_IsValidMonth(mm){
        var intMonth = parseInt(mm, 10);
        return (intMonth >= 1 && intMonth <= 12);
    }
    /**
     * 유효한(존재하는) 일(日)인지 체크
     */
    function f_IsValidDay(yyyy, mm, dd){
        var intMonth = parseInt(mm, 10) - 1;
        var intDay = parseInt(dd, 10);
        var arrLastDay = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
        if ((yyyy % 4 == 0 && yyyy % 100 != 0) || yyyy % 400 == 0) arrLastDay[1] = 29;
        return (intDay >= 1 && intDay <= arrLastDay[intMonth]);
    }
    /**
     * 유효한(존재하는) 시(時)인지 체크
     */
    function f_IsValidHour(hh){
        var intHour = parseInt(hh, 10);
        return (intHour >= 1 && intHour <= 24);
    }
    /**
     * 유효한(존재하는) 분(分)인지 체크
     */
    function f_IsValidMin(mi){
        var intMin = parseInt(mi, 10);
        return (intMin >= 1 && intMin <= 60);
    }
    /**
     * 입력된 날짜값에서 '-', '/', '.', ':', ' '(공백)을 없앤다.
     */
    function f_RemoveDateTimeFormat(pm_val){
        return pm_val.toString().replace(/-/g, "").replace(/\//g, "").replace(/\./g, "").replace(/:/g, "").replace(/ /g, "");
    }
    /**
     * 유효하는(존재하는) 날짜 인지 체크
     * 사용형식 : f_IsValidDate(20061127)
     */
    function f_IsValidDate(pm_date){
        if (f_IsNullVal(pm_date)) return true;
        if(!f_ContainsCharsOnly(pm_date,'1234567890')) return false;
        var strDate = f_RemoveDateTimeFormat(pm_date);
        var year  = "";
        var month = "";
        var day   = "";
        var hour  = "";
        var min   = "";
        if (strDate.length == 6){
            year  = strDate.substr(0,4);
            month = strDate.substr(4,2);
            if (parseInt(year, 10) >= 1900
                && f_IsValidMonthh(month)) return true;
        }else if (strDate.length == 8){
            year  = strDate.substr(0,4);
            month = strDate.substr(4,2);
            day   = strDate.substr(6,2);
            if (parseInt(year, 10) >= 1900
                && f_IsValidMonth(month)
                && f_IsValidDay(year,month,day)) return true;
        } else if (strDate.length == 12) {
            year  = strDate.substr(0,4);
            month = strDate.substr(4,2);
            day   = strDate.substr(6,2);
            hour  = strDate.substr(8,2);
            min   = strDate.substr(10,2);
            if (parseInt(year, 10) >= 1900
                && f_IsValidMonth(month)
                && f_IsValidDay(year, month, day)
                && f_IsValidHour(hour) && f_IsValidMin(min)) return true;
        }
        return false;
    }
    /**
     * 유효하는(존재하는) 날짜 인지 체크
     *
     * 사용형식 : f_CheckDate('20061113','YMD'), f_CheckDate('20061113','YM')
     */
    function f_CheckDate(obj,flag){
        var now = new Date;
        var compLen = 0;

        if(flag == "YMD"){
            compLen = 8;
        }else if(flag == "YM"){
            compLen = 6;
        }

        if(!f_IsNull(obj.value) && obj.value.length < compLen){
            alert("입력날짜가 유효하지 않습니다.");
            obj.select();
            obj.focus();
            return;
        }

        if(!f_IsValidDate(f_RemoveDateTimeFormat(obj.value))){
            alert("입력날짜가 유효하지 않습니다.");
            obj.select();
            obj.focus();
            return;
        }
    }
    /**
    * Cookie설정하기
    */
    function setCookie(name, value, expire) {
        document.cookie = name + "=" + escape(value) + ((expire) ? "; expires=" + expire.toGMTString() : "");
    }
    /**
    * Cookie decode 구하기
    */
    function getCookie_decode(name){
        // 쿠키에서 한글깨지는 현상때문에 escape를 처리를 하지 않고 가져온다.
        alert("kjfskddfjdk");
        var Found = false;
        var start, end;
        var i =0;
        while(i<=document.cookie.length) {
            start = i;
            end = start + name.length;
            if(document.cookie.substring(start, end) == name) {
                Found = true;
                break;
            }
            i++;
        }
        if(Found == true) {
            start = end + 1;
            end = document.cookie.indexOf(";", start);
            if(end < start)
                end = document.cookie.length;
            return decodeURIComponet(document.cookie.substring(start,end));
        }
        return '';
    }
    /**
    * Cookie 구하기
    */
    function getCookie(uName) {

        var flag = document.cookie.indexOf(uName+'=');
        if (flag != -1) {
            flag += uName.length + 1
            end = document.cookie.indexOf(';', flag)

            if (end == -1) end = document.cookie.length
            return unescape(document.cookie.substring(flag, end))
        }else {
            return '';
        }
    }
    /**
    * Cookie 삭제
    */
    function deleteCookie( cookieName ){
        var expireDate = new Date();
        expireDate.setDate( todate());
        document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() + "; path=/";
    }

    /**
    * set 쿠키
    */
    function setCookieComm( cookieName, cookieValue, expireDate )
    {
    document.cookie = cookieName + "=" + escape( cookieValue ) + "; path=/; ";
    }
 

    function toWon(data_value) {
    
        var txtNumber = '' + data_value;    // 입력된 값을 문자열 변수에 저장합니다.
    
        if (isNaN(txtNumber) || txtNumber == "") {    // 숫자 형태의 값이 정상적으로 입력되었는지 확인합니다.
            alert("숫자만 입력 하세요");
            return;
        }
        else {
            var rxSplit = new RegExp('([0-9])([0-9][0-9][0-9][,.])');    // 정규식 형태 생성
            var arrNumber = txtNumber.split('.');    // 입력받은 숫자를 . 기준으로 나눔. (정수부와 소수부분으로 분리)
            arrNumber[0] += '.'; // 정수부 끝에 소수점 추가
    
            do {
                arrNumber[0] = arrNumber[0].replace(rxSplit, '$1,$2'); // 정수부에서 rxSplit 패턴과 일치하는 부분을 찾아 replace 처리
            } while (rxSplit.test(arrNumber[0])); // 정규식 패턴 rxSplit 가 정수부 내에 있는지 확인하고 있다면 true 반환. 루프 반복.
    
            if (arrNumber.length > 1) { // txtNumber를 마침표(.)로 분리한 부분이 2개 이상이라면 (즉 소수점 부분도 있다면)
                return arrNumber.join(''); // 배열을 그대로 합칩. (join 함수에 인자가 있으면 인자를 구분값으로 두고 합침)
            }
            else { // txtNumber 길이가 1이라면 정수부만 있다는 의미.
                return arrNumber[0].split('.')[0]; // 위에서 정수부 끝에 붙여준 마침표(.)를 그대로 제거함.
            }
        }
    }
    
    function fn_saveAirReserveForPay(jSessionID, fitRsvNo) {
		var gdsCd = '';
		var availTy = '';
		var carrierCd = '';
		var routeTy = '';
		var currency = 0;
		var totSaleCharge = 0;
		var totTaxCharge = 0;
		var fmsKey;
		var ruleKey;
		var pmoId;

		var airReserveData = {
			// bodyDTO
	
		};

		airReserveData.bodyDTO = {};

		// 세그먼트 그룹
		airReserveData.bodyDTO.segmentGroup = [];
		
		// 탑승자 그룹 
		airReserveData.bodyDTO.paxGroup  = [];		
		var dp_traveler = function(tx, results) {
				var tempArray = '';
				for(var i = 0; i < results.rows.length; i++){

					rsvUserId = results.rows.item(i).rsvUserId;
					rsvUserNm = results.rows.item(i).rsvUserNm;
					rsvEnSurNm = results.rows.item(i).rsvEnSurNm;
					rsvEnFirstNm = results.rows.item(i).rsvEnFirstNm;
					rsvHtel = convertTel(results.rows.item(i).rsvHtel);
					rsvEmail = results.rows.item(i).rsvEmail;
					rsvRemark = results.rows.item(i).rsvRemark;
					gdsCd = results.rows.item(i).gdsCd;
					availTy = results.rows.item(i).availTy;
					routeTy = results.rows.item(i).routeTy;
					currency = results.rows.item(i).currency;
					totSaleCharge = results.rows.item(i).totSaleCharge;
					totTaxCharge = results.rows.item(i).totTaxCharge;
					fmsKey = results.rows.item(i).fmsKey;
					ruleKey = results.rows.item(i).ruleKey;
					pmoId = results.rows.item(i).pmoId;

					tempArray = {
						"rsvUserId"		: rsvUserId,
						"rsvUserNm"		: rsvUserNm,
						"rsvHtel"		: rsvHtel,
						"rsvEmail"		: rsvEmail,
						"gdsCd"			: gdsCd,
						"availTy"		: availTy,
						"routeTy"		: routeTy,
						"currency"		: currency,
						"totSaleCharge"	: totSaleCharge,
						"totTaxCharge"	: totTaxCharge,
						"fmsKey"		: fmsKey,
						"ruleKey"		: ruleKey,
						"pmoId"			: pmoId
					};		
					// console.log(tempArray);
           		}
				
				airReserveData.bodyDTO = tempArray;

				
				var availNo = 0;
				var segNo = 0;
				var carrierCd = '';
				var opCarrierCd = '';
				var fltNo = '';
				var fltEquip = '';
				var depDt = '';
				var depTm = '';
				var depCd = '';
				var arrDt = '';
				var arrTm = '';
				var arrCd = '';
				var eTketYn = '';
				var depTerminal = '';
				var arrTerminal = '';
				var codeShare = '';
				var codeShareNm = '';
				var cabinClas = '';
				var duartionTm = '';

				var segmentGroup = function(tx, results) {
						var tempArray = [];
						for(var i = 0; i < results.rows.length; i++){
							

							availNo = results.rows.item(i).availNo;
							segNo = results.rows.item(i).segNo;
							carrierCd = results.rows.item(i).carrierCd;
							opCarrierCd = results.rows.item(i).opCarrierCd;
							fltNo = results.rows.item(i).fltNo;
							fltEquip = results.rows.item(i).fltEquip;
							depDt = results.rows.item(i).depDt;
							depTm = results.rows.item(i).depTm;
							depCd = results.rows.item(i).depCd;
							arrDt = results.rows.item(i).arrDt;
							arrTm = results.rows.item(i).arrTm;
							arrCd = results.rows.item(i).arrCd;
							eTketYn = results.rows.item(i).eTketYn;
							depTerminal = results.rows.item(i).depTerminal;
							arrTerminal = results.rows.item(i).arrTerminal;
							codeShare = results.rows.item(i).codeShare;
							codeShareNm = results.rows.item(i).codeShareNm;
							cabinClas = results.rows.item(i).cabinClas;
							durationTm = results.rows.item(i).durationTm;
							bookingClas = results.rows.item(i).bookingClas;
							
							// 항공 관련 정보 
							// fn_selAirport(arrCd);

							tempArray.push({
								"availNo"	: availNo,
								"segNo"		: segNo,
								"carrierCd"	: carrierCd,
								"opCarrierCd": opCarrierCd,
								"fltNo"		: fltNo,
								"fltEquip"	: fltEquip,
								"depDt"		: depDt,
								"depTm"		: depTm,
								"depCd"		: depCd,
								"arrDt"		: arrDt,
								"arrTm"		: arrTm,
								"arrCd"		: arrCd,
								"eTketYn"	: eTketYn,
								"bookingClas" :bookingClas,
								"depTerminal" : depTerminal,
								"arrTerminal" : arrTerminal,
								"codeShare"	  : codeShare,
								"codeShareNm" : codeShareNm,
								"cabinClas" : cabinClas,
								"durationTm" : durationTm
							});		

						}
						airReserveData.bodyDTO.segmentGroup = tempArray;

						var paxNo = 0;
						var paxTy = '';
						var krPaxNm = '';
						var enSurNm = '';
						var enFirstNm = '';
						var dateOfBirth = '';
						var paxTel = '';
						var paxEmail = '';
						var gender = '';
						var passportYn = '';
						var fareCharge = 0;
						var taxCharge = 0;
						var cabinClas = '';
						var bookingClas = '';
						var vCarrierCd = '';
						var discntCharge = 0;
						var fuelSurcharge = 0;
						var qCharge = 0;
						var upCharge = 0;
						var pmoDiscntCharge = 0;
						var pmoUpCharge = 0;
						
						var paxGroup = function(tx, results) {
								var tempArray = [];
								for(var i = 0; i < results.rows.length; i++){
									
									paxNo = results.rows.item(i).paxNo;
									paxTy = results.rows.item(i).paxTy;
									krPaxNm = results.rows.item(i).krPaxNm;
									enSurNm = results.rows.item(i).enSurNm;
									enFirstNm = results.rows.item(i).enFirstNm;
									dateOfBirth = results.rows.item(i).dateOfBirth;
									paxTel = convertTel(results.rows.item(i).paxTel);
									paxEmail = results.rows.item(i).paxEmail;
									gender = results.rows.item(i).gender;
									passportYn = results.rows.item(i).passportYn;
									fareCharge = results.rows.item(i).fareCharge;
									taxCharge = results.rows.item(i).taxCharge;
									cabinClas = results.rows.item(i).cabinClas;
									bookingClas = results.rows.item(i).bookingClas;
									vCarrierCd = results.rows.item(i).vCarrierCd;
									discntCharge = results.rows.item(i).discntCharge;
									fuelSurcharge = results.rows.item(i).fuelSurcharge;
									qCharge = results.rows.item(i).qCharge;
									upCharge = results.rows.item(i).upCharge;
									pmoDiscntCharge = results.rows.item(i).pmoDiscntCharge;
									pmoUpCharge = results.rows.item(i).pmoUpCharge;
									if(nullToBlank(vCarrierCd) == '') vCarrierCd = '';
									
									tempArray.push({
										"paxNo"				: paxNo,
										"paxTy"				: paxTy,
										"krPaxNm"			: krPaxNm,
										"enSurNm"			: enSurNm,
										"enFirstNm"	 		: enFirstNm,
										"dateOfBirth"		: dateOfBirth,
										"paxTel"			: paxTel,
										"paxEmail"			: paxEmail,
										"gender"			: gender,
										"passportYn"		: passportYn,
										"fareCharge"		: fareCharge,
										"taxCharge"			: taxCharge,
										"cabinClas"			: cabinClas,
										"bookingClas" 		: bookingClas,
										"vCarrierCd" 		: vCarrierCd,
										"discntCharge" 		: discntCharge,
										"fuelSurcharge"		: fuelSurcharge,
										"qCharge"			: qCharge,
										"upCharge"			: upCharge,
										"pmoDiscntCharge"	: pmoDiscntCharge,
										"pmoUpCharge"		: pmoUpCharge
									});	

									airReserveData.bodyDTO.paxGroup = tempArray;		
								}
										

								var segNo = 0;
								var fareBasis = '';
								var fareTy = '';
								var rbd = '';
								var breakPoint = '';
								
								
								if(nullToBlank(airReserveData.bodyDTO.paxGroup) != '') {
								
									// 요금료 
									for(var j = 0; j < airReserveData.bodyDTO.paxGroup.length; j++) {
										airReserveData.bodyDTO.paxGroup[j].fareDataBean  = [];
									}
									
									var fareData = function(tx, results) {
											for(var j = 0; j < airReserveData.bodyDTO.paxGroup.length; j++) {
												var tempArray = [];
												for(var i = 0; i < results.rows.length; i++){
													
													availNo = results.rows.item(i).availNo;
													segNo = results.rows.item(i).segNo;
													fareBasis = results.rows.item(i).fareBasis;
													fareTy = results.rows.item(i).fareTy;
													paxTy = results.rows.item(i).paxTy;
													cabinClas = results.rows.item(i).cabinClas;
													rbd = results.rows.item(i).rbd;
													breakPoint = results.rows.item(i).breakPoint;
	
													tempArray.push({
														"availNo"		: availNo,
														"segNo"			: segNo,
														"fareBasis"		: fareBasis,
														"fareTy"		: fareTy,
														"paxTy"	 		: paxTy,
														"cabinClas"		: cabinClas,
														"rbd"			: rbd,
														"breakPoint"	: breakPoint
													});
												}
												airReserveData.bodyDTO.paxGroup[j].fareDataBean  = tempArray;
											}
											fn_goReserveStep5(jSessionID, airReserveData, fitRsvNo);
									};
								}
								var fare = rsvAirFareDataBeanT.selectT(fareData, jSessionID);
						};
						var pax = rsvAirPaxGroupT.selectT(paxGroup, jSessionID);
				};
				var segment = rsvAirSegmentGroupT.selectT(segmentGroup, jSessionID);
		};
		var traveler_info = rsvAirBodyDtoT.selectT(dp_traveler, jSessionID);
	}

   //기존 함수 js/common.js 내용. 끝. ================================================================