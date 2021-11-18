<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<%
	String selAir = (String) request.getAttribute("selAir");
	String selHotel = (String) request.getAttribute("selHotel");
	String selRentcar = (String) request.getAttribute("selRentcar");
	
	Date systemDate = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
	String serverDay = sdf.format(systemDate);
%>
<head>
<script src="/resources/common/js/fit/air_search.js"></script>
<script src="/resources/common/js/fit/paging.js"></script>
<script src="/resources/common/js/fit/common.js"></script>
<script src="/resources/common/js/fit/reserve.js"></script>
<script src="/resources/common/js/database.js"></script>
<script type="text/javascript">
	var jSessionID = '<%=request.getSession().getId()%>';
	var selAir = '${selAir}';
	var selHotel = '${selHotel}';
	var selRentcar = '${selRentcar}';
	var custCd = '${cust_cd}';
	
	var serverDate = '<%=serverDay%>';
	serverYear = parseInt(serverDate.substring(0, 4));
	serverMonth = parseInt(serverDate.substring(4, 6));
	serverDay = parseInt(serverDate.substring(6, 8));

	// 초기화
	var fn_init = function() {
		var selRentcar = '${selRentcar}';
		if(nullToBlank(sessionStorage.airSelData) != "" && sessionStorage.airSelData != '[]'){
			selAir = 'Y';
			$("#selAir").val('Y');
			$('#travelers_air_info_div').show();
		} else {
			selAir = 'N';
			$("#selAir").val('N');
			$('#travelers_air_info_div').hide();
		}

		if(nullToBlank(sessionStorage.hotelBasketData) != "" && sessionStorage.hotelBasketData != '[]'){
			selHotel = 'Y'
			$("#selHotel").val('Y');
			$('#travelers_hotels_info_div').show();
		} else {
			selHotel = 'N';
			$("#selHotel").val('N');
			$('#travelers_hotels_info_div').hide();
		}
		
		if(nullToBlank(sessionStorage.rentcarSelData) != "" && sessionStorage.rentcarSelData != '[]'){
			selRentcar = 'Y';
			$("#selRentcar").val('Y');
			$("#travelers_renatalcar_info_div").show();
		}else{
			selRentcar = 'N';
			$("#selRentcar").val('N');			
			$("#travelers_renatalcar_info_div").hide();
		}
	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};
	// 나이계산 스크립트 
    function calcAgeHtl(birth) {                 
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
    function fn_getPaxTyHtl(birth) {                 
        var paxTy = '';

        var age = calcAgeHtl(birth);
        
        if(age < 2){			// 유아
        	paxTy = 'INF';
        }else if(age < 12){		// 아이
        	paxTy = 'CHD';
        }else{ 					// 성인
        	paxTy = 'ADT';
        }

        return paxTy;
    } 
	var fn_saveReserve = function(){
		var checkParamYn = true;
		var reserveConfirmYn = false;
		var rsvTxt = "";
		
		if(selHotel == 'Y') {
			rsvTxt = "호텔 예약을 위해 호텔 선 결제가 필요합니다.\n선택하신 객실의  취소 규정이 적용됩니다.\n예약 확정 후 변경 및 취소를 하시더라도\n결제요금 전액이 취소 수수료로 부가 됩니다.\n패키지 할인은 호텔 결제 시 적용 됩니다.\n\n호텔 결제 페이지로 이동합니다.";
		} else {
			rsvTxt = "예약하시겠습니까?";
		}
					
		setConfirm(rsvTxt, 
			function(){
				reserveConfirmYn = true;
				
				if(nullToBlank(sessionStorage.airSelData) != "" && sessionStorage.airSelData != '[]'){
					fn_getParam();
					if(!fn_airCheckParam()) {
						checkParamYn = false;
						return false;
					}
				}
				
				if(nullToBlank(sessionStorage.hotelBasketData) != "" && sessionStorage.hotelBasketData != '[]'){
					if(!fn_checkHtlInfo()){
						checkParamYn = false;
						return false;
					}else{
						//객실수  정보
						basketData = JSON.parse(sessionStorage.hotelBasketData);
						
						var userName;
		         		var eFstName;
		         		var eSndName;
		         		var birthday;
		         		var phone;
		         		var sex;
		         		var adtFlag;
		         		var adtChk;
						//var roomGrps = [];
						var inwonCntTemp = 0;
		         		var inputInfoCnt = 0;
		         		var roomData = [];
		         		
						for(var i = 0; i < basketData.length; i++){  //호텔별
							var roomCnt = parseInt(basketData[i].htlInfo.stayinfo.roomcnt);
							var roomGrps = [];
							
							for(var k=0; k < roomCnt; k++) {  ///객실갯수
								var guestInfos = [];						
								var inwonCnt = parseInt(basketData[i].htlInfo.stayinfo.roomCont[k].numOfAdt) + parseInt(basketData[i].htlInfo.stayinfo.roomCont[k].numOfChd);  //객실별 인원수
								
								//투숙객 정보
								for(var j=0; j < inwonCnt; j++) {
									if(i > 0 ) {
										inputInfoCnt = inwonCntTemp + (j+1);
									} else {
										if(k > 0)
											inputInfoCnt = inwonCntTemp + (j+1);
										else
											inputInfoCnt = inwonCntTemp + j;
									}
					
									
									if(inputInfoCnt > 8) {
										setAlert("9객실 이상 정보를 입력 할 수 없습니다.")
										return;
									}	
												         				
			         				userName = "#userName" + inputInfoCnt;
			            			eFstName = "#eFstName" + inputInfoCnt;
			            			eSndName = '#eSndName' + inputInfoCnt;
			            			birthday = '#birthday' + inputInfoCnt;
			            			phone 	 = '#phone'	   + inputInfoCnt;
			            			sex 	 = 'radio' + inputInfoCnt + "_sex";
			            			adtChk  = fn_getPaxTyHtl($(birthday).val());
			            			if(adtChk == "ADT"){
			            				adtFlag = 'Y';
			            			} else {
			            				adtFlag = 'N';
			            			}
				         			//투숙객정보
				         			var guestInfoData = {
				         					'childAges' : '', 					//아동투숙객나이
				         					'firstName' :  $(eSndName).val(), 	//투숙객이름
				         					'lastName' : $(eFstName).val(), 	//투숙객 성
				         					'guestNmKr' : $(userName).val(), 	//투숙객이름
				         					'birthDay' : $(birthday).val(),  	//투숙객 생년월일
				         					'gender' : $('input:radio[name=' + sex + ']:checked').val(),      //성별
				         					'tel' : $(phone).val(),       		//번호
				         					'adtFlag' : adtFlag               		//성인여부
				         					
				         			};	
				         			guestInfos.push(guestInfoData);	
			         			}
								inwonCntTemp = inputInfoCnt;  //마지막 넘버
									
								var bedType = '';
								if(basketData[i].setRoomData[0].bedTypes.length > 0) 
									bedType = basketData[i].setRoomData[0].bedTypes[0].bedTypeId;
								
								//룸정보
			         			var roomGrpsData = {
			         					'numOfAdt' :  basketData[i].htlInfo.stayinfo.roomCont[k].numOfAdt,  	//성인수  /
			         					'numOfChd'  : basketData[i].htlInfo.stayinfo.roomCont[k].numOfChd,  	//아동수 /
			         					'bedTypeId' : bedType,   //베드타입ID
			         					'numOfBeds' : '',        											//베드타입 옵션
			         					'smokingPref' : basketData[i].setRoomData[0].smokingPref, 			//흡연/비흡연
			         					'roomTy' : basketData[i].htlInfo.stayinfo.roomCont[k].roomTy,       //룸타입
			         					'guestInfos' : guestInfos         									//투숙객정보
			         			};
								
								roomGrps.push(roomGrpsData);
							}
							roomData.push(roomGrps);  
						}
						sessionStorage.roomGrps = JSON.stringify(roomData);
					}
				}
				
				
				if(nullToBlank(sessionStorage.rentcarSelData) != "" && sessionStorage.rentcarSelData != '[]'){
					if(!fn_rentCheckParam()){
						checkParamYn = false;
						return false;
					}else{
						var rentcarSelData = JSON.parse(sessionStorage.rentcarSelData);
						
						for(var i = 0; i < rentcarSelData.length; i++){
							rentcarSelData[i].operNmKr = $("#operNmKr"+i).val();
							rentcarSelData[i].operSurNm = $("#operSurNm"+i).val();
							rentcarSelData[i].operGivenNm = $("#operGivenNm"+i).val();
							rentcarSelData[i].telAreaNo = '+82';
							rentcarSelData[i].telNo = convertTel($("#telNo"+i).val());
							rentcarSelData[i].emailAddr = $("#emailAddr"+i).val();
							rentcarSelData[i].operAgeGb = $("#birthday"+i).val();
							rentcarSelData[i].memo = $("#rentMemo").val();
							rentcarSelData[i].userId = custCd;
						}
						
						sessionStorage.rentcarSelData = JSON.stringify(rentcarSelData);
					}
				}	
				
				if(reserveConfirmYn){
					if(checkParamYn){
						if(nullToBlank(sessionStorage.airSelData) != "" && sessionStorage.airSelData != '[]'){
							// ---------------------------------------------------------------------------------------------------------------------------------------------
							// 항공예약 > 항공 예약 처리 API > paxGroup 정보 
							// ---------------------------------------------------------------------------------------------------------------------------------------------
							fn_syncAirPaxGroupDB();
						}else {
							if(nullToBlank(sessionStorage.hotelBasketData) != "" && sessionStorage.hotelBasketData != '[]'){
								location.href = "/free/account/pay_free.do";
							}else{
								fn_goReserveStep5(jSessionID);	
							}
							
						}
					}
				}
			}, function(){
				reserveConfirmYn = false;
			}, "예약", "예", "아니오"
		);
	}
	
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
        
        return hp;
    }
	
	function limitText(field, maxChar){
		var ref = $(field),
			val = ref.val();
		if ( val.length >= maxChar ){
			ref.val(function() {
				return val.substr(0, maxChar);       
			});
		}
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
		
	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();

		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});
</script>
</head>
<body>

	<form name="f_frm" id="f_frm" method="post">
		<input type="hidden" name="selAir" id="selAir"/> 
		<input type="hidden" name="selHotel" id="selHotel" /> 
		<input type="hidden" name="selRentcar" id="selRentcar" />
	</form>

	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="navstitle freeback">
			여행자 정보<a href="javascript:history.back(-1);">뒤로</a>
		</div>
		<div class="free_reserve collapse fr_step4">
			<div class="ft_whbox mt7">
				<ul class="dotlist3">
					<li>여행자의 한글이름/생년월일/휴대폰번호/이메일을 정확히 입력해 주세요.(예약 완료 후 잘못된 정보는 수정이
						불가하며, 출국하실 수 없습니다.)</li>
					<li>영문 이름이 여권에 기재된 것과 상이한 경우 항공기 탑승이 거부될 수 있습니다.</li>
					<li>외국인의 경우 고객센터 (17577-6511)를 통한 전화예약 만 가능합니다.</li>
					<li>항공권은 이메일을 통해 전자항공권(e-Ticket)으로 발송되어 별도로 항공권을 배송하지 않습니다.</li>
				</ul>
			</div>
			
			<!-- 항공 여행자 -->
			<div id="travelers_air_info_div" name="travelers_air_info_div">
				<%@include file="/WEB-INF/jsp/free_reserve/inc_reserve_step4_travels_air_info.jsp"%>
			</div>
			
			<!-- 호텔 여행자 -->
			<div id="travelers_hotels_info_div" name="travelers_hotels_info_div">
				<%@include file="/WEB-INF/jsp/free_reserve/inc_reserve_step4_travels_hotels_info.jsp"%>
			</div>
			
			<!-- 렌터카 여행자 -->
			<div id="travelers_renatalcar_info_div" name="travelers_renatalcar_info_div">
				<%@include file="/WEB-INF/jsp/free_reserve/inc_reserve_step4_travels_rentalcar_info.jsp"%>
			</div>
			
			<!-- 버튼 -->
			<div class="btn_one air_tbtn">
				<button class="purple2" data-role="none" onClick="fn_saveReserve()">예약하기</button>
			</div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>