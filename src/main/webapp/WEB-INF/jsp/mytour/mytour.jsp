<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<head>
<script type="text/javascript">
	var pageSize = "${pageSize}";
	var freePageSize = "${freePageSize}";
	var airPageSize = "${freePageSize}";

	var custCd = "${custCd}";
	var userName = "${userName}";
	var gradeNm = "${gradeNm}";
	var cno = "${cno}";
	var mblNo = "${mblNo}";
	var mbrCustno = "${mbrCustno}";
	
	
	var usePoint = "${usePoint}";
	var remainPointType = "${remainPointType}";
	var remainPoint = "${remainPoint}";
	
	var exchangeObj = {};
	
	//table
	var reservationCnt = 0;
	var cancelCnt = 0;
	var freeReserveCnt = 0;
	var freeCancelCnt = 0;
	var topassListAirCnt = 0;
	var topassListAirCancelCnt = 0;

	//tab2
	var choiceCnt = 0;
	var recentViewCnt = 0;
	
	//tab3
	var eventCnt = 0;
	var consultCnt = 0;
	
	var listHistory;
	
	var listMst;
	var listAir;
	var listHtl;
	var listRnt;
	
	var listCancelMst;
	var listCancelAir;
	var listCancelHtl;
	var listCancelRnt;
	
	var listCancel;
	var listFree;
	var listFreeCancel;
	var topassListAir;
	var topassListAirCancel;

	var newResList = [];
	var subRadioYn = false;
	
	var dateVal = "";
	
	
	function getCookieTop(uName) {
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
	
	var acesTkn = getCookieTop("acesTkn");
	
	// 초기화
	var fn_init = function() {
		if(nullToBlank(usePoint) != ""){
			$("#usePoint").html(comma(usePoint) + "원");
		}else{
			$("#usePoint").html("0원");
		}
		
		if(nullToBlank(remainPoint) != ""){
			if(remainPointType != "+"){
				$("#remainPoint").html(remainPointType + comma(remainPoint) + "원");
			}else{
				$("#remainPoint").html(comma(remainPoint) + "원");
			}
		}else{
			$("#remainPoint").html("0원");
		}
			
		if(location.hash == "#tab4"){
			$("#tab4_nav").click();
		}else if(location.hash == "#tab3"){
			$("#tab3_nav").click();
		}else if(location.hash == "#tab2"){
			$("#tab2_nav").click();
		}else if(location.hash == "#tab1"){
			$("#tab1_nav").click();
		}else{
			fn_tabClick(1);
		}
		
		$("#userName").text(userName);
		if(nullToBlank(gradeNm) == ""){
			$("#gradeNm").text("일반등급");
		}else{
			$("#gradeNm").text(gradeNm);
		}
	};

	// 버튼 초기화
	var fn_initButton = function() {
		setTimeout(function(){
			$("#selectAll").prop("checked", true).checkboxradio("refresh");	
		}, 300);
		
		$("#selectAll").click(function(){
			subRadioYn = false;
			
			if(!$(this).is(":checked")){
				$("#selectAll").prop("checked", true).checkboxradio("refresh");
			}else{
				$(".subGoods").prop("checked", false).checkboxradio("refresh");
			}
			
			if(nullToBlank(listHistory) != ""){
				reservationCnt = listHistory.length;
				reservationLen = reservationCnt; 
				
				if(reservationCnt > pageSize){
					reservationLen = pageSize;	
				}
				
				var reserHTML = "";
			
				for(var i = 0; i < reservationLen; i++){
					reserHTML += '<li>';
					reserHTML += '	<div data-role="collapsible" data-iconpos="right" data-theme="e">';
					reserHTML += '		<h3 class="ui-alt-icon">'+ listHistory[i].eventNm +'</h3>';
					reserHTML += '		<table>';
					reserHTML += '			<colgroup>';
					reserHTML += '				<col width="30%">';
					reserHTML += '				<col width="70%">';
					reserHTML += '			</colgroup>';
					reserHTML += '			<tbody>';
					reserHTML += '				<tr>';
					reserHTML += '					<th scope="row">예약일</th>';
					reserHTML += '					<td>'+ listHistory[i].resDay +'</td>';
					reserHTML += '				</tr>';
					reserHTML += '				<tr>';
					reserHTML += '					<th scope="row">출발일</th>';
					reserHTML += '					<td>'+ listHistory[i].startDay +'</td>';
					reserHTML += '				</tr>';
					reserHTML += '				<tr>';
					reserHTML += '					<th scope="row">총금액</th>';
					reserHTML += '					<td><b class="purple">'+ comma(listHistory[i].totSaleAmt)+'원</b></td>';
					reserHTML += '				</tr>';
					reserHTML += '				<tr>';
					reserHTML += '					<th scope="row">예약상태</th>';
					reserHTML += '					<td>'+ listHistory[i].statusNm +'</td>';
					/*
					if(listHistory[i].statusRgCd == "RC"){
						reserHTML += '					<td>예약완료</td>';
					}else if(listHistory[i].statusRgCd == "RW"){
						reserHTML += '					<td>예약대기</td>';
					}else if(listHistory[i].statusRgCd == "RN"){
						reserHTML += '					<td>예약불가</td>';
					}else if(listHistory[i].statusRgCd == "CC"){
						reserHTML += '					<td>취소완료</td>';
					}else{
						reserHTML += '					<td></td>';
					}
					*/
					reserHTML += '				</tr>';
					reserHTML += '				<tr>';
					reserHTML += '					<th scope="row">예약번호</th>';
					reserHTML += '					<td>'+ listHistory[i].resCd +'</td>';
					reserHTML += '				</tr>';
					if(listHistory[i].statusCd == "10" || listHistory[i].statusCd == "11" || listHistory[i].statusCd == "H3"){
						reserHTML += '				<tr>';
						reserHTML += '					<th scope="row">결제상태</th>';
						reserHTML += '					<td><a href="#" class="purple2 myt_paybtn" onclick="fn_movePay(\''+ listHistory[i].resCd +'\')">상세/결제</a></td>';
						reserHTML += '				</tr>';
					}
					reserHTML += '			</tbody>';
					reserHTML += '		</table>';
					reserHTML += '	</div>';
					reserHTML += '</li>';
				}
				
				$("#reservationHistory").html(reserHTML);
				$("#reservationHistory").trigger('create');
			};
		});
		
		$(".subGoods").click(function(){
			var subCheckYn = true;
			var checkList = "";
			var str = "AVHBN"
			var travelYn = false;
			var allYn = false;
			newResList = [];
			
			subRadioYn = true;
			
			if($(this).is(":checked")){
				$("#selectAll").prop("checked", false).checkboxradio("refresh");
			}else{
				$(".subGoods").each(function(){
					if($(this).is(":checked")){
						subCheckYn = false;
					}
				});
				
				if(subCheckYn){
					$("#selectAll").prop("checked", true).checkboxradio("refresh");
					allYn = true;
				}
			}
			
			$(".subGoods").each(function(){
				if($(this).is(":checked")){
					checkList += $(this).data("val");
					str = str.replace($(this).data("val"), "")
					
					if($(this).data("val") == ""){
						travelYn = true;
					}
				}
			});
			
			/*
			if(nullToBlank(checkList) != ""){
				checkList = checkList.substring(1, checkList.length);
			}
			*/
			
			if(allYn){
				str = "";
				subRadioYn = false;
				travelYn = true;
			}
			
			if(nullToBlank(listHistory) != ""){
				for(var i = 0; i < listHistory.length; i++){
					if(travelYn){
						if("str".indexOf(listHistory[i].goodsTypeCd) == -1){
							newResList.push(listHistory[i]);
						}
					}else{
						if(checkList.indexOf(listHistory[i].goodsTypeCd) != -1){
							newResList.push(listHistory[i]);
						}
					}
				}
				
				reservationCnt = newResList.length;
				reservationLen = reservationCnt; 
				
				if(reservationCnt > pageSize){
					reservationLen = pageSize;	
				}
				
				var reserHTML = "";
				for(var i = 0; i < reservationLen; i++){
					reserHTML += '<li>';
					reserHTML += '	<div data-role="collapsible" data-iconpos="right" data-theme="e">';
					reserHTML += '		<h3 class="ui-alt-icon">'+ newResList[i].eventNm +'</h3>';
					reserHTML += '		<table>';
					reserHTML += '			<colgroup>';
					reserHTML += '				<col width="30%">';
					reserHTML += '				<col width="70%">';
					reserHTML += '			</colgroup>';
					reserHTML += '			<tbody>';
					reserHTML += '				<tr>';
					reserHTML += '					<th scope="row">예약일</th>';
					reserHTML += '					<td>'+ newResList[i].resDay +'</td>';
					reserHTML += '				</tr>';
					reserHTML += '				<tr>';
					reserHTML += '					<th scope="row">출발일</th>';
					reserHTML += '					<td>'+ newResList[i].startDay +'</td>';
					reserHTML += '				</tr>';
					reserHTML += '				<tr>';
					reserHTML += '					<th scope="row">총금액</th>';
					reserHTML += '					<td><b class="purple">'+ comma(newResList[i].totSaleAmt)+'원</b></td>';
					reserHTML += '				</tr>';
					reserHTML += '				<tr>';
					reserHTML += '					<th scope="row">예약상태</th>';
					reserHTML += '					<td>'+ newResList[i].statusNm +'</td>';
					/*
					if(newResList[i].statusRgCd == "RC"){
						reserHTML += '					<td>예약완료</td>';
					}else if(newResList[i].statusRgCd == "RW"){
						reserHTML += '					<td>예약대기</td>';
					}else if(newResList[i].statusRgCd == "RN"){
						reserHTML += '					<td>예약불가</td>';
					}else if(newResList[i].statusRgCd == "CC"){
						reserHTML += '					<td>취소완료</td>';
					}else{
						reserHTML += '					<td></td>';
					}
					*/
					reserHTML += '				</tr>';
					reserHTML += '				<tr>';
					reserHTML += '					<th scope="row">예약번호</th>';
					reserHTML += '					<td>'+ newResList[i].resCd +'</td>';
					reserHTML += '				</tr>';
					if(newResList[i].statusCd == "10" || newResList[i].statusCd == "11" || newResList[i].statusCd == "H3"){
						reserHTML += '				<tr>';
						reserHTML += '					<th scope="row">결제상태</th>';
						reserHTML += '					<td><a href="#" class="purple2 myt_paybtn" onclick="fn_movePay(\''+ newResList[i].resCd +'\')">상세/결제</a></td>';
						reserHTML += '				</tr>';
					}
					reserHTML += '			</tbody>';
					reserHTML += '		</table>';
					reserHTML += '	</div>';
					reserHTML += '</li>';
				}
				
				$("#reservationHistory").html(reserHTML);
				$("#reservationHistory").trigger('create');
			};
		});
	};
	
	var fn_movePay = function(resNo){
		var payUrl = "/account/pay.do"
		
		if(mbrCustno == "8495032" || mbrCustno == "9248052" || mbrCustno == "17016309" || mbrCustno == "15191947" || mbrCustno == "9460549" || 
				mbrCustno == "4170575" || mbrCustno == "6910395" || mbrCustno == "5808191" || mbrCustno == "25104615" || mbrCustno == "10316644" ||
				mbrCustno == "13413580" || mbrCustno == "44672107"){
			payUrl = "/account/pay.do"
		}
		
		location.href = payUrl + "?resCd="+ resNo
	}
	
	var fn_lpointDtl = function(){
		if(devType == 0){
			//moveLink('http://www.lottemembers.com/GoPtSubMainAct.tran', '_blank')
			moveLink('https://m.lpoint.com/app/mypage/LWMA100100.do', '_blank');
		}else{
			//moveLink('http://www.lottemembers.com/GoPtSubMainAct.tran', '_blank')
			moveLink('https://m.lpoint.com/app/mypage/LWMA100100.do', '_blank');
		}
	}
	
	var fn_Htlpss = function(number){ 
		 
		var resNum = number.split('-'); 
				
		moveLink('https://mhotel2.lottejtb.com:44011/mypage/reservation_info.asp?bkno='+resNum[0]+'&bkseq='+resNum[1]+'&onl_cno='+onl_cno );
	}
	
	//회원정보수정
	var fn_editUserInfo = function(){
		//if(devType == 0){
		//	moveLink('https://testmember.lpoint.com/door/user/mobile/change_user_info.jsp?sid=MLOTTEJTB', '_blank')
		//}else{
			//moveLink('https://member.lpoint.com/door/user/mobile/change_user_info.jsp?sid=LOTTEJTB', '_blank');
		//}
			moveLink('https://security.lottejtb.com/jsp/sso/myinfo_change_mobile.jsp?acesTkn='+acesTkn, '_blank');
	}
	
	//비밀번호변경
	var fn_editPassword = function(){
		//if(devType == 0){
		//	moveLink('https://testmember.lpoint.com/door/user/mobile/change_user_info.jsp?sid=MLOTTEJTB', '_blank')
		//}else{
			//moveLink('https://member.lpoint.com/door/user/mobile/change_user_info.jsp?sid=LOTTEJTB', '_blank');
			
			moveLink('https://security.lottejtb.com/jsp/sso/myinfo_pwd_change_mobile.jsp?acesTkn='+acesTkn, '_blank');
		//}
	}
	
	//회원탈퇴
	var fn_delUserInfo = function() {
		//if(devType == 0){
		//	moveLink('https://testmember.lpoint.com/door/user/mobile/withdrawl.jsp?sid=MLOTTEJTB', '_blank');
		//}else{
			//moveLink('https://member.lpoint.com/door/user/mobile/withdrawl.jsp?sid=LOTTEJTB', '_blank');
			moveLink('https://security.lottejtb.com/jsp/sso/myinfo_getOut_mobile.jsp?acesTkn='+acesTkn, '_blank');
		//}
	}

	//예약 상세보기로 이동 
	var fn_rsvDetailMove = function(fitRsvNo) {
		document.location.href = "/free/account/free_info_detail.do?seqNo=" + fitRsvNo;
	}
	
	//제주닷컴 항공확인으로 이동
	var fn_jejuAirUserInfo = function(){
		moveLink('http://m.dht3.lottejtb.com/reserve/bas_rsv_list.html?agt=JTB', '_blank');
	}
	
	var fn_tabClick = function(type, reloadYn){
		switch(type){
		case 1 :
			window.location.replace(location.pathname + "#tab1");
			jQuery('body,html').animate({scrollTop: 0}, 0);
			setTimeout(function(){
				$("#tab1_nav").addClass("ui-btn-active");
			}, 100);
			if($("#reservationHistory").children().length < 1 && $("#cancelHistory").children().length < 1){
				if(nullToBlank(custCd) == ""){
					return false;
				}
				var reservFormData = new FormData();
				reservFormData.append('custCd', custCd);
				
				var loadingFlag = false;
				showLoading();
				setTimeout(function(){
					loadingFlag = true;
				}, 3000);
				cfn_ajax({
					type: "POST",
					async: false,
					url: "<c:url value='/mytour/myReservationList.do' />",
					data: reservFormData,
					dataType: "json",
					cache: false,
					noloading:"no",
					success: function(res) {
						list = res.list;
						listHistory = res.listHistory;
						listCancel = res.listCancel;
						
						reservationCnt = listHistory.length;
						cancelCnt = listCancel.length;
						reservationLen = reservationCnt;
						cancelLen = cancelCnt;
						
						//예약내역 더보기 버튼 활성화
						if(reservationCnt < pageSize) {
						   	$("#morebtn1").hide();
						} else {
						   $("#morebtn1").show();	
						}
	
						//취소내역 더보기버튼 활성화
						if(cancelCnt < pageSize) {
							$('#morebtn2').hide();
						} else {
							$('#morebtn2').show();
						}
						
						if(reservationCnt > pageSize){
							reservationLen = pageSize;	
						}
						
						if(cancelCnt > pageSize){
							cancelLen = pageSize;	
						}
						
						var reserHTML = "";
						for(var i = 0; i < reservationLen; i++){
							reserHTML += '<li>';
							reserHTML += '	<div data-role="collapsible" data-iconpos="right" data-theme="e">';
							reserHTML += '		<h3 class="ui-alt-icon">'+ listHistory[i].eventNm +'</h3>';
							reserHTML += '		<table>';
							reserHTML += '			<colgroup>';
							reserHTML += '				<col width="30%">';
							reserHTML += '				<col width="70%">';
							reserHTML += '			</colgroup>';
							reserHTML += '			<tbody>';
							reserHTML += '				<tr>';
							reserHTML += '					<th scope="row">예약일</th>';
							reserHTML += '					<td>'+ listHistory[i].resDay +'</td>';
							reserHTML += '				</tr>';
							reserHTML += '				<tr>';
							reserHTML += '					<th scope="row">출발일</th>';
							reserHTML += '					<td>'+ listHistory[i].startDay +'</td>';
							reserHTML += '				</tr>';
							reserHTML += '				<tr>';
							reserHTML += '					<th scope="row">총금액</th>';
							reserHTML += '					<td><b class="purple">'+ comma(listHistory[i].totSaleAmt)+'원</b></td>';
							reserHTML += '				</tr>';
							reserHTML += '				<tr>';
							reserHTML += '					<th scope="row">예약상태</th>';
							reserHTML += '					<td>'+ listHistory[i].statusNm +'</td>';
							/*
							if(listHistory[i].statusRgCd == "RC"){
								reserHTML += '					<td>예약완료</td>';
							}else if(listHistory[i].statusRgCd == "RW"){
								reserHTML += '					<td>예약대기</td>';
							}else if(listHistory[i].statusRgCd == "RN"){
								reserHTML += '					<td>예약불가</td>';
							}else if(listHistory[i].statusRgCd == "CC"){
								reserHTML += '					<td>취소완료</td>';
							}else{
								reserHTML += '					<td></td>';
							}
							*/
							reserHTML += '				</tr>';
							reserHTML += '				<tr>';
							reserHTML += '					<th scope="row">예약번호</th>';
							reserHTML += '					<td>'+ listHistory[i].resCd +'</td>';
							reserHTML += '				</tr>';
							if(listHistory[i].statusCd == "10" || listHistory[i].statusCd == "11" || listHistory[i].statusCd == "H3"){
								reserHTML += '				<tr>';
								reserHTML += '					<th scope="row">결제상태</th>';
								reserHTML += '					<td><a href="#" class="purple2 myt_paybtn" onclick="fn_movePay(\''+ listHistory[i].resCd +'\')">상세/결제</a></td>';
								reserHTML += '				</tr>';
							}
							if(listHistory[i].custCd == "0002750088" || listHistory[i].custCd == "0000888789" || listHistory[i].custCd == "0002017184" || listHistory[i].custCd == "0002060625" || listHistory[i].custCd == "0002259426" || listHistory[i].custCd == "0002254354"){
								if(listHistory[i].goodsTypeCd == "H"){
									reserHTML += '				<tr>';
									reserHTML += '					<th scope="row">예약상세정보</th>';
									reserHTML += '					<td><a href="#" class="purple2 myt_paybtn" onclick="fn_Htlpss(\''+ listHistory[i].etcResCd +'\')">상세내역</a></td>';
									reserHTML += '				</tr>';
								}
							}
							reserHTML += '			</tbody>';
							reserHTML += '		</table>';
							reserHTML += '	</div>';
							reserHTML += '</li>';
						}
						
						var cancelHTML = "";
						for(var j = 0; j < cancelLen; j++){
							cancelHTML += '<li>';
							cancelHTML += '	<div data-role="collapsible" data-iconpos="right" data-theme="e">';
							cancelHTML += '		<h3 class="ui-alt-icon">'+ listCancel[j].eventNm +'</h3>';
							cancelHTML += '		<table>';
							cancelHTML += '			<colgroup>';
							cancelHTML += '				<col width="30%">';
							cancelHTML += '				<col width="70%">';
							cancelHTML += '			</colgroup>';
							cancelHTML += '			<tbody>';
							cancelHTML += '				<tr>';
							cancelHTML += '					<th scope="row">예약일</th>';
							cancelHTML += '					<td>'+ listCancel[j].resDay +'</td>';
							cancelHTML += '				</tr>';
							cancelHTML += '				<tr>';
							cancelHTML += '					<th scope="row">출발일</th>';
							cancelHTML += '					<td>'+ listCancel[j].startDay +'</td>';
							cancelHTML += '				</tr>';
							cancelHTML += '				<tr>';
							cancelHTML += '					<th scope="row">총금액</th>';
							cancelHTML += '					<td><b class="purple">'+ comma(listCancel[j].totSaleAmt)+'원</b></td>';
							cancelHTML += '				</tr>';
							cancelHTML += '				<tr>';
							cancelHTML += '					<th scope="row">예약상태</th>';
							cancelHTML += '					<td>'+ listCancel[j].statusNm +'</td>';
							/*
							if(listCancel[j].statusRgCd == "RC"){
								cancelHTML += '					<td>예약완료</td>';
							}else if(listCancel[j].statusRgCd == "RW"){
								cancelHTML += '					<td>예약대기</td>';
							}else if(listCancel[j].statusRgCd == "RN"){
								cancelHTML += '					<td>예약불가</td>';
							}else if(listCancel[j].statusRgCd == "CC"){
								cancelHTML += '					<td>취소완료</td>';
							}
							*/
							cancelHTML += '				</tr>';
							cancelHTML += '				<tr>';
							cancelHTML += '					<th scope="row">예약번호</th>';
							cancelHTML += '					<td>'+ listCancel[j].resCd +'</td>';
							cancelHTML += '				</tr>';
							cancelHTML += '			</tbody>';
							cancelHTML += '		</table>';
							cancelHTML += '	</div>';
							cancelHTML += '</li>';
						}
						
						$("#reservationHistory").html(reserHTML);
						$("#cancelHistory").html(cancelHTML);
					},
					error:function(err){
						console.log(err);
					},
					complete:function(){
						$("#reservationHistory").trigger('create');
						$("#cancelHistory").trigger('create');
						
						if(loadingFlag){
							hideLoading();
						}else{
							setTimeout(function(){
								hideLoading();
							}, 500);
						}
					}
				});
				
				var freeReservFormData = new FormData();
				freeReservFormData.append('custCd', custCd);
				
				cfn_ajax({
					type: "POST",
					async: false,
					url: "/mytour/freeReserve.do",
					data: freeReservFormData,
					dataType: "json",
					cache: false,
					noloading:"no",
					success: function(res) {
						listFree = res.list;
						listFreeCancel = res.cancelList;
						
						freeReserveCnt = listFree.mst.length;
						freeCancelCnt = listFreeCancel.mst.length;
						freeReserveLen = freeReserveCnt;
						freeCancelLen = freeCancelCnt;
						
						listMst = listFree.mst;
						listAir = listFree.air;
						listHtl = listFree.htl;
						listRnt = listFree.rnt;
						
						console.log("<<<<="  +listHtl);
						
						listCancelMst = listFreeCancel.mst;
						listCancelAir = listFreeCancel.air;
						listCancelHtl = listFreeCancel.htl;
						listCancelRnt = listFreeCancel.rnt;
												
						if(freeReserveCnt < freePageSize) {
						   	$("#morebtn5").hide();
						} else {
						   $("#morebtn5").show();	
						}
	
						//취소내역 더보기버튼 활성화
						if(freeCancelCnt < freePageSize) {
							$('#morebtn6').hide();
						} else {
							$('#morebtn6').show();
						}
						
						if(freeReserveCnt > freePageSize){
							freeReserveLen = freePageSize;	
						}
						
						if(freeCancelCnt > freePageSize){
							freeCancelLen = freePageSize;	
						}
						
						var freeMstHTML = "";
						
						for(var m = 0; m < freeReserveLen; m++){
							freeMstHTML += '<li>';
							if(m == 0){
								freeMstHTML += '	<div class="free_myt_part on" id="div_'+ listMst[m].fitRsvNo +'" data-collapsed="false">';
							}else{
								freeMstHTML += '	<div class="free_myt_part" id="div_'+ listMst[m].fitRsvNo +'" data-collapsed="false">';	
							}
							freeMstHTML += '		<h3 class="free_myt_title1 ellipsis">예약코드 : '+ listMst[m].fitRsvNo +' / 예약일 : '+ listMst[m].rsvDt +'</h3>';
							freeMstHTML += '		<div class="fr_myt_gbox1">';
							//freeMstHTML += '			<span class="app_end_box">예약완료</span>';
							freeMstHTML += '			<button type="button" data-role="none" onclick="fn_rsvDetailMove(\'' + listMst[m].fitRsvNo + '\')">상세보기</button>';
							freeMstHTML += '		</div>';
							freeMstHTML += '		<dl class="fr_myt_gbox2">';
							freeMstHTML += '			<div class="cls_air">';
							freeMstHTML += '			</div>';
							freeMstHTML += '			<div class="cls_htl">';
							freeMstHTML += '			</div>';
							freeMstHTML += '			<div class="cls_rnt">';
							freeMstHTML += '			</div>';
							freeMstHTML += '		</dl>';
							freeMstHTML += '		<ul class="fr_myt_gbox3">';
							
							var rsvTotAmt = parseInt(listMst[m].saleAmtTot);
							if(nullToBlank(listMst[m].airDiscntAmt) != "" && listMst[m].airDiscntAmt != '0'){
								freeMstHTML += '			<li>항공 프로모션 <span>-'+ comma(listMst[m].airDiscntAmt) +'원</span></li>';
								rsvTotAmt = rsvTotAmt - parseInt(listMst[m].airDiscntAmt);
							}
							
							if(nullToBlank(listMst[m].htlDiscntAmt) != "" && listMst[m].htlDiscntAmt != '0' && listCancelMst[m].ijwdiscntamt < 1){
								freeMstHTML += '			<li>호텔 프로모션 <span>-'+ comma(listMst[m].htlDiscntAmt) +'원</span></li>';
								rsvTotAmt = rsvTotAmt - parseInt(listMst[m].htlDiscntAmt);
							}
							
							if(nullToBlank(listMst[m].rntDiscntAmt) != "" && listMst[m].rntDiscntAmt != '0'){
								freeMstHTML += '			<li>렌터카 프로모션 <span>-'+ comma(listMst[m].rntDiscntAmt) +'원</span></li>';
								rsvTotAmt = rsvTotAmt - parseInt(listMst[m].rntDiscntAmt);
							}
							
							//if(nullToBlank(listMst[m].promAmount) != "" && listMst[m].promAmount != '0' && listCancelMst[m].ijwdiscntamt < 1){
							//	freeMstHTML += '			<li>'+ listMst[m].promNm +'<span>-'+ comma(listMst[m].promAmount) +'원</span></li>';
							//	rsvTotAmt = rsvTotAmt - parseInt(listMst[m].promAmount);
							//}
							
							//if(nullToBlank(listMst[m].promRate) != "" && listMst[m].promRate != '0' && listCancelMst[m].ijwdiscntamt < 1){
							//	var mstPromAmt = rsvTotAmt * parseFloat(listMst[m].promRate * 0.01);
							//	freeMstHTML += '			<li>'+ listMst[m].promNm +'<span>-'+ comma(Math.floor(mstPromAmt)) +'원</span></li>';
							//	rsvTotAmt = rsvTotAmt - Math.floor(mstPromAmt);
							//}
							
							freeMstHTML += '			<li class="tl frmyt_allprice">총 결제예정금액 <span>'+ comma(rsvTotAmt) +'원</span></li>';
							// freeMstHTML += '			<li id="'+ listMst[m].fitRsvNo +'_vou" style="display:none;">';
							// freeMstHTML += '				<button type="button" data-role="none" id="'+ listMst[m].fitRsvNo +'_vou_air" style="display:none;">항공 E-Ticket</button>';
							// freeMstHTML += '				<button type="button" data-role="none" id="'+ listMst[m].fitRsvNo +'_vou_htl" style="display:none;">호텔 바우처</button>';
							// freeMstHTML += '				<button type="button" data-role="none" id="'+ listMst[m].fitRsvNo +'_vou_rnt" style="display:none;">렌터카 바우처</button>';
							// freeMstHTML += '			</li>';
							freeMstHTML += '		</ul>';
							freeMstHTML += '	</div>';
							freeMstHTML += '</li>';
						}
						
						$('#freeReserve').html(freeMstHTML);
						
						var freeCancelMstHTML = "";
						
						for(var cm = 0; cm < freeCancelLen; cm++){
							freeCancelMstHTML += '<li>';
							if(cm == 0){
								freeCancelMstHTML += '	<div class="free_myt_part on" id="div_'+ listCancelMst[cm].fitRsvNo +'" data-collapsed="false">';
							}else{
								freeCancelMstHTML += '	<div class="free_myt_part" id="div_'+ listCancelMst[cm].fitRsvNo +'" data-collapsed="false">';
							}
							freeCancelMstHTML += '		<h3 class="free_myt_title1 ellipsis">예약코드 : '+ listCancelMst[cm].fitRsvNo +' / 예약일 : '+ listCancelMst[cm].rsvDt +'</h3>';
							freeCancelMstHTML += '		<div class="fr_myt_gbox1">';
							freeCancelMstHTML += '			<span class="app_cancel_box">예약취소</span>';
							freeCancelMstHTML += '			<button type="button" data-role="none" onclick="fn_rsvDetailMove(\'' + listCancelMst[cm].fitRsvNo+ '\')">상세보기</button>';
							freeCancelMstHTML += '		</div>';
							freeCancelMstHTML += '		<dl class="fr_myt_gbox2">';
							freeCancelMstHTML += '			<div class="cls_air">';
							freeCancelMstHTML += '			</div>';
							freeCancelMstHTML += '			<div class="cls_htl">';
							freeCancelMstHTML += '			</div>';
							freeCancelMstHTML += '			<div class="cls_rnt">';
							freeCancelMstHTML += '			</div>';
							freeCancelMstHTML += '		</dl>';
							freeCancelMstHTML += '		<ul class="fr_myt_gbox3">';
							
							var rsvTotAmt = parseInt(listCancelMst[cm].saleAmtTot);
							if(nullToBlank(listCancelMst[cm].airDiscntAmt) != "" && listCancelMst[cm].airDiscntAmt != '0'){
								freeCancelMstHTML += '			<li>항공 프로모션 <span>-'+ comma(listCancelMst[cm].airDiscntAmt) +'원</span></li>';
								rsvTotAmt = rsvTotAmt - parseInt(listCancelMst[cm].airDiscntAmt);
							}
							
							if(nullToBlank(listCancelMst[cm].htlDiscntAmt) != "" && listCancelMst[cm].htlDiscntAmt != '0' && listCancelMst[cm].ijwdiscntamt < 1){
								freeCancelMstHTML += '			<li>호텔 프로모션 <span>-'+ comma(listCancelMst[cm].htlDiscntAmt) +'원</span></li>';
								rsvTotAmt = rsvTotAmt - parseInt(listCancelMst[cm].htlDiscntAmt);
							}							
							
							if(nullToBlank(listCancelMst[cm].rntDiscntAmt) != "" && listCancelMst[cm].rntDiscntAmt != '0'){
								freeCancelMstHTML += '			<li>렌터카 프로모션 <span>-'+ comma(listCancelMst[cm].rntDiscntAmt) +'원</span></li>';
								rsvTotAmt = rsvTotAmt - parseInt(listCancelMst[cm].rntDiscntAmt);
							}
							
							//if(nullToBlank(listCancelMst[cm].promAmount) != "" && listCancelMst[cm].promAmount != '0'&& listCancelMst[cm].ijwdiscntamt < 1){
							//	freeCancelMstHTML += '			<li>'+ listCancelMst[cm].promNm +'<span>-'+ comma(listCancelMst[cm].promAmount) +'원</span></li>';
							//	rsvTotAmt = rsvTotAmt - parseInt(listCancelMst[cm].promAmount);
							//}
							
							//if(nullToBlank(listCancelMst[cm].promRate) != "" && listCancelMst[cm].promRate != '0' && listCancelMst[cm].ijwdiscntamt < 1){
							//	var mstPromAmt = rsvTotAmt * parseFloat(listCancelMst[cm].promRate * 0.01);
							//	freeCancelMstHTML += '			<li>'+ listCancelMst[cm].promNm +'<span>-'+ comma(Math.floor(mstPromAmt)) +'원</span></li>';
							//	rsvTotAmt = rsvTotAmt - Math.floor(mstPromAmt);
							//}
							
							freeCancelMstHTML += '			<li class="tl frmyt_allprice">총 결제예정금액 <span>'+ comma(rsvTotAmt) +'원</span></li>';
							freeCancelMstHTML += '		</ul>';
							freeCancelMstHTML += '	</div>';
							freeCancelMstHTML += '</li>';
						}
						
						$('#freeCancelReserve').html(freeCancelMstHTML);
						
						setTimeout(function(){
							for(var a = 0; a < listAir.length; a++){
								var freeAirHTML = "";
								var inwan = "";
								
								if(listAir[a].itinShapeGb == "RT"){
									freeAirHTML += '		<dt class="ft_myy_ico1">'+ listAir[a].depNm +' - '+ listAir[a].firstArrNm +' - '+ listAir[a].lastArrNm +'</dt>';
								}else if(listAir[a].itinShapeGb == "OW"){
									freeAirHTML += '		<dt class="ft_myy_ico1">'+ listAir[a].depNm +' - '+ listAir[a].firstArrNm +'</dt>';
								}
								freeAirHTML += '		<dd>';
								freeAirHTML += '			<span class="fr_myt_gbtn1">'+ listAir[a].fareStateNm +'</span>';
								freeAirHTML += '			<span class="fr_myt_gbtn2">'+ listAir[a].rsvStateNm +'</span>';
								if(listAir[a].itinShapeGb == "RT"){
									freeAirHTML += '			<p>출발 : '+ listAir[a].depDt +' / 귀국 : '+ listAir[a].lastArrDt +'</p>';
								}else if(listAir[a].itinShapeGb == "OW"){
									freeAirHTML += '			<p>출발 : '+ listAir[a].depDt +'</p>';
								}
								
								if(listAir[a].adt != '0'){
									inwan += '성인'+ listAir[a].adt +'명 ';
								}
								if(listAir[a].chd != '0'){
									inwan += '소아'+ listAir[a].chd +'명 ';
								}
								if(listAir[a].inf != '0'){
									inwan += '유아'+ listAir[a].inf +'명 ';
								}
								
								freeAirHTML += '				<p>'+ inwan +'</p>';
								freeAirHTML += '			<div class="ft_myt_btp">';
								
								var totSaleAmt = listAir[a].totSaleAmt;
								var totTasfAmt = listAir[a].totTasfAmt;
								var totSaleAmtT = 0;
								var totTasfAmtT = 0;
								
								if(nullToBlank(totSaleAmt) != '') totSaleAmtT = parseInt(totSaleAmt);
								if(nullToBlank(totTasfAmt) != '') totTasfAmtT = parseInt(totTasfAmt);
								
								if(listAir[a].rsvStateGb == "TK"){
									freeAirHTML += '				<button type="button" data-role="none" onClick="\setAlert("서비스준비중입니다.\")">항공 E-Ticket</button>';
								}
								//freeAirHTML += '				<div>'+ comma(totSaleAmtT + totTasfAmtT) +'원</div>';
								freeAirHTML += '				<div>'+ comma(listAir[a].saleAmtAir) +'원</div>';
								freeAirHTML += '			</div>';
								freeAirHTML += '		</dd>';
								
								$("#div_"+ listAir[a].fitRsvNo).find(".cls_air").append(freeAirHTML);
								
								if(listAir[a].rsvStateGb == "TK" || listAir[a].rsvStateGb == "TW"){
									$("#"+ listAir[a].fitRsvNo +"_vou").show();
									$("#"+ listAir[a].fitRsvNo +"_vou_air").show();
								}
							}
							
							for(var h = 0; h < listHtl.length; h++){
								var freeHtlHTML = "";
								var inwan = "";
								
								freeHtlHTML += '<dt class="ft_myy_ico2">'+ listHtl[h].htlNm +'</dt>';
								freeHtlHTML += '<dd>';
								freeHtlHTML += '	<span class="fr_myt_gbtn1">'+ listHtl[h].htlRsvstateNm +'</span>';
								if(nullToBlank(listHtl[h].htlPaymtstateNm) != ""){
									freeHtlHTML += '	<span class="fr_myt_gbtn2">'+ listHtl[h].htlPaymtstateNm +'</span>';
								}
								freeHtlHTML += '	<p>체크인 : '+ listHtl[h].checkinDt +' / 체크아웃 : '+ listHtl[h].checkoutDt +'</p>'
								if(listHtl[h].adtQty != '0'){
									inwan += '성인 '+ listHtl[h].adtQty +'명 ';
								}
								if(listHtl[h].childQty != '0'){
									inwan += '소아 '+ listHtl[h].childQty +'명 ';
								}
								freeHtlHTML += '	<p>객실 '+ listHtl[h].roomCnt +'개 '+ inwan +'</p>';
								freeHtlHTML += '	<div class="ft_myt_btp">';
								if(listHtl[h].htlRsvstateGb == "OK" && listHtl[h].htlPaymtstateGb == "OK"){
									freeHtlHTML += '		<button type="button" data-role="none" onClick="fn_goHtlVou(' +listHtl[h].htlRsvSeqno+ ')">호텔 바우처</button>';
								}
								
								var saleJtbAmt = listHtl[h].saleJtbAmt;
								if(saleJtbAmt == null) saleJtbAmt = '0'; 
								
								if(listHtl[h].saleCurrency == "KRW"){
									freeHtlHTML += '	<div>'+ comma(Math.ceil(parseFloat(saleJtbAmt))) +'원</div>';
								}else{
									freeHtlHTML += '	<div>'+ comma(Math.ceil(parseFloat(saleJtbAmt))) +'원</div>';	
								}
								//freeHtlHTML += '		<div>'+ comma(listHtl[h].saleAmt) +'원</div>';
								freeHtlHTML += '	</div>';
								freeHtlHTML += '</dd>';
								
								$("#div_"+ listHtl[h].fitRsvNo).find(".cls_htl").append(freeHtlHTML);
								
								if(listHtl[h].htlPaymtstateGb == "OK"){
									$("#"+ listHtl[h].fitRsvNo +"_vou").show();
									$("#"+ listHtl[h].fitRsvNo +"_vou_htl").show();
								}
							}
							
							for(var r = 0; r < listRnt.length; r++){
								var freeRntHTML = "";
								var korAmt = (exchangeObj[listRnt[r].currencyCd] * parseFloat(listRnt[r].saleAmt)).toFixed();
								
								freeRntHTML += '<dt class="ft_myy_ico3">'+ listRnt[r].carModelNm +'</dt>';
								freeRntHTML += '<dd>';
								freeRntHTML += '	<p>인수 : '+ listRnt[r].pickupDt +' / 반납 : '+ listRnt[r].rtDt +'</p>';
								freeRntHTML += '	<span class="fr_myt_gbtn1">'+ listRnt[r].rntStateNm +'</span>';
								freeRntHTML += '	<div class="ft_myt_btp">';	
								freeRntHTML += '		<button type="button" data-role="none" onClick="fn_goRntVou(' +listRnt[r].rntRsvSeqno+ ')">렌트카 바우처</button>';
								freeRntHTML += '		<div><span class="black_text1">'+ comma(korAmt) +'원 / </span>'+ comma(listRnt[r].saleAmt) + " " + listRnt[r].currencyCd +'</div>';
								freeRntHTML += '	</div>';
								freeRntHTML += '</dd>';
								
								$("#div_"+ listRnt[r].fitRsvNo).find(".cls_rnt").append(freeRntHTML);
								
								if(listRnt[r].rntStateGb == "OK"){
									$("#"+ listRnt[r].fitRsvNo +"_vou").show();
									$("#"+ listRnt[r].fitRsvNo +"_vou_rnt").show();
								}
							}
							
							for(var m = 0; m < freeReserveLen; m++){
								for(var a = 0; a < listAir.length; a++){
									if(listMst[m].fitRsvNo == listAir[a].fitRsvNo){
										listAir.splice(a, 1);
										
										a--;
									}
								}
								
								for(var h = 0; h < listHtl.length; h++){
									if(listMst[m].fitRsvNo == listHtl[h].fitRsvNo){
										listHtl.splice(h, 1);
										
										h--;
									}
								}
								
								for(var r = 0; r < listRnt.length; r++){
									if(listMst[m].fitRsvNo == listRnt[r].fitRsvNo){
										listRnt.splice(r, 1);
										
										r--;
									}
								}
							}
							
							for(var ca = 0; ca < listCancelAir.length; ca++){
								var freeCancelAirHTML = "";
								var inwan = "";
								
								if(listCancelAir[ca].itinShapeGb == "RT"){
									freeCancelAirHTML += '		<dt class="ft_myy_ico1">'+ listCancelAir[ca].depNm +' - '+ listCancelAir[ca].firstArrNm +' - '+ listCancelAir[ca].lastArrNm +'</dt>';
								}else if(listCancelAir[ca].itinShapeGb == "OW"){
									freeCancelAirHTML += '		<dt class="ft_myy_ico1">'+ listCancelAir[ca].depNm +' - '+ listCancelAir[ca].firstArrNm +'</dt>';
								}
								freeCancelAirHTML += '		<dd>';
								freeCancelAirHTML += '			<span class="fr_myt_gbtn1">'+ listCancelAir[ca].fareStateNm +'</span>';
								freeCancelAirHTML += '			<span class="fr_myt_gbtn2">'+ listCancelAir[ca].rsvStateNm +'</span>';
								if(listCancelAir[ca].itinShapeGb == "RT"){
									freeCancelAirHTML += '			<p>출발 : '+ listCancelAir[ca].depDt +' / 귀국 : '+ listCancelAir[ca].lastArrDt +'</p>';
								}else if(listCancelAir[ca].itinShapeGb == "OW"){
									freeCancelAirHTML += '			<p>출발 : '+ listCancelAir[ca].depDt +'</p>';
								}
								
								if(listCancelAir[ca].adt != '0'){
									inwan += '성인'+ listCancelAir[ca].adt +'명 ';
								}
								if(listCancelAir[ca].chd != '0'){
									inwan += '소아'+ listCancelAir[ca].chd +'명 ';
								}
								if(listCancelAir[ca].inf != '0'){
									inwan += '유아'+ listCancelAir[ca].inf +'명 ';
								}
								
								freeCancelAirHTML += '				<p>'+ inwan +'</p>';
								freeCancelAirHTML += '			<div class="ft_myt_btp">';
								//freeCancelAirHTML += '				<div>'+ comma(parseInt(listCancelAir[ca].totSaleAmt) + parseInt(listCancelAir[ca].totTasfAmt)) +'원</div>';
								freeCancelAirHTML += '				<div>'+ comma(listCancelAir[ca].saleAmtAir) +'원</div>';
								freeCancelAirHTML += '			</div>';
								freeCancelAirHTML += '		</dd>';
								
								$("#div_"+ listCancelAir[ca].fitRsvNo).find(".cls_air").append(freeCancelAirHTML);
							}
							
							for(var ch = 0; ch < listCancelHtl.length; ch++){
								var freeCancelHtlHTML = "";
								var inwan = "";
								
								freeCancelHtlHTML += '<dt class="ft_myy_ico2">'+ listCancelHtl[ch].htlNm +'</dt>';
								freeCancelHtlHTML += '<dd>';
								freeCancelHtlHTML += '	<span class="fr_myt_gbtn1">'+ listCancelHtl[ch].htlRsvstateNm +'</span>';
								if(nullToBlank(listCancelHtl[ch].htlPaymtstateNm) != ""){
									freeCancelHtlHTML += '	<span class="fr_myt_gbtn2">'+ listCancelHtl[ch].htlPaymtstateNm +'</span>';	
								}
								freeCancelHtlHTML += '	<p>체크인 : '+ listCancelHtl[ch].checkinDt +' / 체크아웃 : '+ listCancelHtl[ch].checkoutDt +'</p>'
								if(listCancelHtl[ch].adtQty != '0'){
									inwan += '성인 '+ listCancelHtl[ch].adtQty +'명 ';
								}
								if(listCancelHtl[ch].childQty != '0'){
									inwan += '소아 '+ listCancelHtl[ch].childQty +'명 ';
								}
								freeCancelHtlHTML += '	<p>객실 '+ listCancelHtl[ch].roomCnt +'개 '+ inwan +'</p>';
								freeCancelHtlHTML += '	<div class="ft_myt_btp">';
								
								var saleJtbAmt = listCancelHtl[ch].saleJtbAmt;
								if(saleJtbAmt == null) saleJtbAmt = '0'; 
								
								if(listCancelHtl[ch].saleCurrency == "KRW"){
									freeCancelHtlHTML += '		<div>'+ comma(Math.ceil(parseFloat(saleJtbAmt))) +'원</div>';
								}else{
									freeCancelHtlHTML += '		<div>'+ comma(Math.ceil(parseFloat(saleJtbAmt))) +'원</div>';	
								}
								freeCancelHtlHTML += '	</div>';
								freeCancelHtlHTML += '</dd>';
								
								$("#div_"+ listCancelHtl[ch].fitRsvNo).find(".cls_htl").append(freeCancelHtlHTML);
							}
							
							for(var cr = 0; cr < listCancelRnt.length; cr++){
								var freeCancelRntHTML = "";
								var korAmt = (exchangeObj[listCancelRnt[cr].currencyCd] * parseFloat(listCancelRnt[cr].saleAmt)).toFixed();
								
								freeCancelRntHTML += '<dt class="ft_myy_ico3">'+ listCancelRnt[cr].carModelNm +'</dt>';
								freeCancelRntHTML += '<dd>';
								freeCancelRntHTML += '	<p>인수 : '+ listCancelRnt[cr].pickupDt +' / 반납 : '+ listCancelRnt[cr].rtDt +'</p>';
								freeCancelRntHTML += '	<span class="fr_myt_gbtn1">'+ listCancelRnt[cr].rntStateNm +'</span>';
								freeCancelRntHTML += '	<div class="ft_myt_btp">';
								freeCancelRntHTML += '		<button type="button" data-role="none" onClick="fn_goRntVou(' +listCancelRnt[cr].rntRsvSeqno+ ')">렌트카 바우처</button>';
								freeCancelRntHTML += '		<div><span class="black_text1">'+ comma(korAmt) +'원 / </span>'+ comma(listCancelRnt[cr].saleAmt) + " " + listCancelRnt[cr].currencyCd +'</div>';
								freeCancelRntHTML += '	</div>';
								freeCancelRntHTML += '</dd>';
								
								$("#div_"+ listCancelRnt[cr].fitRsvNo).find(".cls_rnt").append(freeCancelRntHTML);
							}
							
							for(var cm = 0; cm < freeCancelLen; cm++){
								for(var ca = 0; ca < listCancelAir.length; ca++){
									if(listCancelMst[cm].fitRsvNo == listCancelAir[ca].fitRsvNo){
										listCancelAir.splice(ca, 1);
										
										ca--;
									}
								}
								
								for(var ch = 0; ch < listCancelHtl.length; ch++){
									if(listCancelMst[cm].fitRsvNo == listCancelHtl[ch].fitRsvNo){
										listCancelHtl.splice(ch, 1);
										
										ch--;
									}
								}
								
								for(var cr = 0; cr < listCancelRnt.length; cr++){
									if(listCancelMst[cm].fitRsvNo == listCancelRnt[cr].fitRsvNo){
										listCancelRnt.splice(cr, 1);
										
										cr--;
									}
								}
							}
						}, 100);
					},
					error: function(err) {
						
					},
					complete: function(){
						$("#freeReserve").trigger('create');
						$("#freeCancelReserve").trigger('create');
						
						$(".free_myt_part .free_myt_title1").off();
						$(".free_myt_part .free_myt_title1").on("click", function(){
							$(this).parent().toggleClass("on");
						});
					}
				});
			}

			// -------------------------------------------------- 토파스 항공 예약 -----------------------------------------------------
			var airReservFormData = new FormData();
			
			cfn_ajax({
				type: "POST",
				async: false,
				url: "/mytour/getTopassRsvListAjax.do",
				data: airReservFormData,
				dataType: "json",
				cache: false,
				noloading:"no",
				success: function(res) {
					topassListAir = res.reserveAirList;
					topassListAirCancel = res.reserveAirCancelList;
					
					topassListAirCnt = topassListAir.length;
					topassListAirCancelCnt = topassListAirCancel.length;
					topassListAirLen = topassListAirCnt;
					topassListAirCancelLen = topassListAirCancelCnt;
					
																	
					if(topassListAirCnt < airPageSize) {
						$("#morebtn5").hide();
					} else {
					   $("#morebtn5").show();	
					}

					//취소내역 더보기버튼 활성화
					if(topassListAirCancelCnt < airPageSize) {
						$('#morebtn6').hide();
					} else {
						$('#morebtn6').show();
					}
					
					if(topassListAirCnt > airPageSize){
						topassListAirLen = airPageSize;	
					}
					
					if(topassListAirCancelCnt > airPageSize){
						topassListAirCancelLen = airPageSize;	
					}
					
					var airMstHTML = "";
					
					for(var m = 0; m < topassListAirLen; m++){
						airMstHTML += '<li>';
						if(m == 0){
							airMstHTML += '	<div class="free_myt_part on" id="div_'+ topassListAir[m].PNR_SEQ_NO +'" data-collapsed="false">';
						}else{
							airMstHTML += '	<div class="free_myt_part" id="div_'+ topassListAir[m].PNR_SEQ_NO +'" data-collapsed="false">';	
						}
						airMstHTML += '		<h3 class="free_myt_title1 ellipsis">예약코드 : '+ topassListAir[m].RM_PNR_NO +' / 예약일 : '+ topassListAir[m].FORMAT_RESV_DATE +'</h3>';
						airMstHTML += '		<div class="fr_myt_gbox1">';
						airMstHTML += '			<span class="app_end_box">'+replaceTopassStatus(topassListAir[m].RM_LAST_STATUS)+'</span>';
						airMstHTML += '			<button type="button" data-role="none" onclick="fn_rsvAirDetailMove(\'' + topassListAir[m].PNR_SEQ_NO + '\')">상세보기</button>';
						airMstHTML += '		</div>';
						airMstHTML += '		<dl class="fr_myt_gbox2">';
						airMstHTML += '			<div class="cls_air">';
						airMstHTML += '				<dt class="ft_myy_ico1">'+ topassListAir[m].TOTAL_ITIN +'</dt>';
						airMstHTML += '			</div>';
						airMstHTML += '		</dl>';
						airMstHTML += '		<ul class="fr_myt_gbox3">';
						airMstHTML += '			<li class="tl frmyt_allprice">총 결제예정금액 <span>'+ topassListAir[m].FORMAT_TOTAL_FARE +'원</span></li>';
						airMstHTML += '		</ul>';
						airMstHTML += '	</div>';
						airMstHTML += '</li>';
					}
					
					$('#topassAirReserve').html(airMstHTML);
					console.log("topassListAir.length >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + topassListAir.length);

					var airCancelMstHTML = "";
					
					console.log("topassListAirCancel.length >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + topassListAirCancel.length);

					for(var cm = 0; cm < topassListAirCancelLen; cm++){
						airCancelMstHTML += '<li>';
						if(cm == 0){
							airCancelMstHTML += '	<div class="free_myt_part on" id="div_'+ topassListAirCancel[cm].PNR_SEQ_NO +'" data-collapsed="false">';
						}else{
							airCancelMstHTML += '	<div class="free_myt_part" id="div_'+ topassListAirCancel[cm].PNR_SEQ_NO +'" data-collapsed="false">';	
						}
						airCancelMstHTML += '		<h3 class="free_myt_title1 ellipsis">예약코드 : '+ topassListAirCancel[cm].PNR_SEQ_NO +' / 예약일 : '+ topassListAirCancel[cm].FORMAT_RESV_DATE +'</h3>';
						airCancelMstHTML += '		<div class="fr_myt_gbox1">';
						airCancelMstHTML += '			<span class="app_end_box">'+replaceTopassStatus(topassListAirCancel[cm].RM_LAST_STATUS)+'</span>';
						airCancelMstHTML += '			<button type="button" data-role="none" onclick="fn_rsvAirDetailMove(\'' + topassListAirCancel[cm].PNR_SEQ_NO + '\')">상세보기</button>';
						airCancelMstHTML += '		</div>';
						airCancelMstHTML += '		<dl class="fr_myt_gbox2">';
						airCancelMstHTML += '			<div class="cls_air">';
						airCancelMstHTML += '				<dt class="ft_myy_ico1">'+ topassListAirCancel[cm].TOTAL_ITIN +'</dt>';
						airCancelMstHTML += '			</div>';
						airCancelMstHTML += '		</dl>';
						airCancelMstHTML += '		<ul class="fr_myt_gbox3">';
						airCancelMstHTML += '			<li class="tl frmyt_allprice">총 결제예정금액 <span>'+ topassListAirCancel[cm].FORMAT_TOTAL_FARE +'원</span></li>';
						airCancelMstHTML += '		</ul>';
						airCancelMstHTML += '	</div>';
						airCancelMstHTML += '</li>';
					}
					
					$('#topassAirCancelReserve').html(airCancelMstHTML);
					
				},
				error: function(err) {
					
				},
				complete: function(){
					$("#topassAirReserve").trigger('create');
					$("#topassAirCancelReserve").trigger('create');
					
					$(".free_myt_part .free_myt_title1").off();
					$(".free_myt_part .free_myt_title1").on("click", function(){
						$(this).parent().toggleClass("on");
					});
				}
			}); 

			break;
		case 2 :
			window.location.replace(location.pathname + "#tab2");
			jQuery('body,html').animate({scrollTop: 0}, 0);
			setTimeout(function(){
				$("#tab2_nav").addClass("ui-btn-active");
			}, 100);
			var startRow = 1;
			var endRow = Number(pageSize);
			
			if($("#choiceGoods").children().length < 1 || reloadYn){
				var choiceFormData = new FormData();
				choiceFormData.append('custCd', custCd);
				choiceFormData.append('wishCd', '01');
				choiceFormData.append('startRow', startRow);
				choiceFormData.append('endRow', endRow);
				
				var loadingFlag = false;
				showLoading();
				setTimeout(function(){
					loadingFlag = true;
				}, 3000);
				
				cfn_ajax({
					type: "POST",
					async: false,
					url: "<c:url value='/mytour/choiceGoodsCount.do' />",
					data: choiceFormData,
					dataType: "json",
					cache: false,
					noloading:"no",
					success: function(res) {
						choiceCnt = res.totalCount;
					},
					error:function(err){
						console.log(err);
					},
					complete:function(){
					}
				});
				
				cfn_ajax({
					type: "POST",
					async: false,
					url: "<c:url value='/mytour/choiceGoodsList.do' />",
					data: choiceFormData,
					dataType: "json",
					cache: false,
					noloading:"no",
					success: function(res) {
						list = res.list;
						var vHTML = "";
						
						//더보기 버튼 노출
						if(list < pageSize) {
							$('#morebtn').hide();
						} else {
							$('#morebtn').show();
						}
						
						for(var i = 0; i < list.length; i++){
							//var imagePath = "http://www.lottejtb.com/upload/common/goods/" + list[i].goodsCd.substring(0, 2) + "/" + list[i].goodsCd + "/" + list[i].saveFileNm;
							var imagePath = "/m_file/upload/common/goods/" + list[i].goodsCd.substring(0, 2) + "/" + list[i].goodsCd + "/" + list[i].saveFileNm;
							
							vHTML += '<li>';
							vHTML += '	<a href="#">';
							vHTML += '		<div class="check_jjip check_jjip_1">';
							vHTML += '			<input type="checkbox" class="choiceDel" id="choiceDel_'+ list[i].wishSeq +'" value="'+ list[i].wishSeq +'" />';
							vHTML += '			<label for="choiceDel_'+ list[i].wishSeq +'"></label>';
							vHTML += '		</div>';
							vHTML += '		<span class="img" onclick="fn_quickDetail(\''+ list[i].eventCd +'\', \''+ list[i].ctgSeq +'\')"><img src="'+ imagePath +'" alt="" /></span><h3 onclick="fn_quickDetail(\''+ list[i].eventCd +'\', \''+ list[i].ctgSeq +'\')">'+ list[i].eventNm +'</h3>';
							vHTML += '		<span class="holedate">여행기간 :'+ list[i].evNightCnt +'박 '+ list[i].evDayCnt +'일</span>';
							if(list[i].trffKnm.indexOf("아시아나항공") != -1){
								vHTML += '		<span class="startday">이용항공 : <img src="/resources/images/ico/air_OZ.png" class="img">'+ list[i].trffKnm +'</span>';
							}else if(list[i].trffKnm.indexOf("진에어") != -1){
								vHTML += '		<span class="startday">이용항공 : <img src="/resources/images/ico/air_LJ.png" class="img mgL5">'+ list[i].trffKnm +'</span>';
							}else if(list[i].trffKnm.indexOf("대한항공") != -1){
								vHTML += '		<span class="startday">이용항공 : <img src="/resources/images/ico/air_KE.png" class="img mgL5">'+ list[i].trffKnm +'</span>';
							}else if(list[i].trffKnm.indexOf("티웨이") != -1){
								vHTML += '		<span class="startday">이용항공 : <img src="/resources/images/ico/air_TW.png" class="img mgL5">'+ list[i].trffKnm +'</span>';	
							}else{
								vHTML += '		<span class="startday">이용항공 : '+ list[i].trffKnm +'</span>';
							}
							vHTML += '		<span class="money"><i>'+ comma(list[i].adultPrice) +'</i>원~</span>';
							vHTML += '	</a>';
							vHTML += '</li>';
						}
						
						$("#choiceGoods").html(vHTML);
					},
					error:function(err){
						console.log(err);
					},
					complete:function(){
						$(".check_jjip_1").trigger('create');
						
						if(loadingFlag){
							hideLoading();
						}else{
							setTimeout(function(){
								hideLoading();
							}, 500);
						}
					}
				});
			}
			
			if($("#recentViewGoods").children().length < 1){
				var cookieNum = getCookie('TODAY_EVENTS');
				if(nullToBlank(cookieNum) != ""){
					var quicklist = cookieNum.split("▥").reverse();
					var vHTML = "";
					
					for(var i = 0 ; i < quicklist.length; i++){
						var row = quicklist[i].split("▤");
						
						if(row.length > 0){
							vHTML += '<li>';
							vHTML += '	<a href="#" onclick="fn_quickDetail(\''+ row[0] +'\',\''+ row[1] +'\')">';
							vHTML += '		<span class="img" style="background:url('+ row[2] +')"></span>';
							vHTML += '		<h3>'+ row[3] +'</h3>';
							vHTML += '		<span class="holedate">여행기간 :'+ row[5] +'박'+ row[4] +'일</span>';
							if(row[7].indexOf("아시아나") != -1){
								vHTML += '		<span class="startday">이용항공 : <img src="/resources/images/ico/air_OZ.png" class="img">'+ row[7] +'</span>';
							}else if(row[7].indexOf("진에어") != -1){
								vHTML += '		<span class="startday">이용항공 : <img src="/resources/images/ico/air_LJ.png" class="img mgL5">'+ row[7] +'</span>';
							}else if(row[7].indexOf("대한항공") != -1){
								vHTML += '		<span class="startday">이용항공 : <img src="/resources/images/ico/air_KE.png" class="img mgL5">'+ row[7] +'</span>';
							}else if(row[7].indexOf("티웨이") != -1){
								vHTML += '		<span class="startday">이용항공 : <img src="/resources/images/ico/air_TW.png" class="img mgL5">'+ row[7] +'</span>';
							}else{
								vHTML += '		<span class="startday">이용항공 : '+ row[7] +'</span>';
							}
							vHTML += '		<span class="money"><i>'+ comma(row[6]) +'</i>원~</span>';
							vHTML += '	</a>';
							vHTML += '</li>';
						}
						
						$("#recentViewGoods").html(vHTML);
					}
				}
			}
			break;
		case 3 :
			window.location.replace(location.pathname + "#tab3");
			jQuery('body,html').animate({scrollTop: 0}, 0);
			setTimeout(function(){
				$("#tab3_nav").addClass("ui-btn-active");
			}, 100);
			var startRow = 1;
			var endRow = Number(pageSize);
			
			if($("#eventHistory").children().length < 1){
				var date = new Date();
				date = date.format("yyyyMMdd");
				var eventFormData = new FormData();
				eventFormData.append('custCd', custCd);
				eventFormData.append('startRow', startRow);
				eventFormData.append('endRow', endRow);
				
				var loadingFlag = false;
				showLoading();
				setTimeout(function(){
					loadingFlag = true;
				}, 3000);
				
				cfn_ajax({
					type: "POST",
					async: false,
					url: "<c:url value='/mytour/myEventCount.do' />",
					data: eventFormData,
					dataType: "json",
					cache: false,
					noloading:"no",
					success: function(res) {
						eventCnt = res.totalCount;
						
						/* if(eventCnt== 0 || eventCnt < 2) {
							$('#morebtn3').hide();
						} else {
							$('#morebtn3').show();
						} */
						
					},
					error:function(err){
						console.log(err);
					},
					complete:function(){
					}
				});
				
				cfn_ajax({
					type: "POST",
					async: false,
					url: "<c:url value='/mytour/myEventList.do' />",
					data: eventFormData,
					dataType: "json",
					cache: false,
					noloading:"no",
					success: function(res) {
						var list = res.list;
						var vHTML = "";
						
						if(list.length < pageSize){
							$("#morebtn3").hide();
						}else{
							$("#morebtn3").show();
						}
						
						for(var i = 0; i < list.length; i++){
							if(nullToBlank(list[i].eventDesc) != ""){
								vHTML += '<li><a href="#" onclick="fn_eventMove(\''+ list[i].eventSeq +'\', \''+ list[i].eventNm +'\', \''+ list[i].eventFrDay +'\', \''+ list[i].eventToDay +'\', 2)"><h3><span class="purple">당첨자발표</span>'+ list[i].eventNm +'</h3><em>'+ list[i].eventFrDay +'~'+ list[i].eventToDay +'</em></a></li>';
							}else if(date >= list[i].eventFrDay && date <= list[i].eventToDay){
								vHTML += '<li><a href="#" onclick="fn_eventMove(\''+ list[i].eventSeq +'\', \''+ list[i].eventNm +'\', \''+ list[i].eventFrDay +'\', \''+ list[i].eventToDay +'\', 0)"><h3><span class="orange">진행중인 이벤트</span>'+ list[i].eventNm +'</h3><em>'+ list[i].eventFrDay +'~'+ list[i].eventToDay +'</em></a></li>';
							}else{
								vHTML += '<li><a href="#" onclick="fn_eventEnd()"><h3><span class="gray">종료된 이벤트</span>'+ list[i].eventNm +'</h3><em>'+ list[i].eventFrDay +'~'+ list[i].eventToDay +'</em></a></li>';
							}
						}
						
						$("#eventHistory").html(vHTML);
					},
					error:function(err){
						console.log(err);
					},
					complete:function(){
						if(loadingFlag){
							hideLoading();
						}else{
							setTimeout(function(){
								hideLoading();
							}, 500);
						}
					}
				});
			}
			
			if($("#consultList").children().length < 1){
				var consultFormData = new FormData();
				consultFormData.append('custCd', custCd);
				consultFormData.append('startRow', startRow);
				consultFormData.append('endRow', endRow);
				
				cfn_ajax({
					type: "POST",
					async: false,
					url: "<c:url value='/customer/qnaListCountAjax.do' />",
					data: consultFormData,
					dataType: "json",
					cache: false,
					noloading:"no",
					success: function(res) {
						consultCnt = res.totalCount;
						/* if(consultCnt== 0 || consultCnt < 2) {
							$('#morebtn4').hide();
						} else {
							$('#morebtn4').show();
						} */
					},
					error:function(err){
						console.log(err);
					},
					complete:function(){
					}
				});
				
				cfn_ajax({
					type: "POST",
					async: false,
					url: "<c:url value='/customer/qnaListAjax.do' />",
					data: consultFormData,
					dataType: "json",
					cache: false,
					noloading:"no",
					success: function(res) {						
						var list = res.list
						var vHTML = "";
						
						if(list.length < pageSize){
							$("#morebtn4").hide();
						}else{
							$("#morebtn4").show();
						}
						
						for(var i = 0; i < list.length; i++){
							if(Number(list[i]["ansCnt"]) > 0){
								vHTML += '<li><a href="#" onclick="fn_consultMove(\''+ list[i]['consultCd'] +'\')"><h3>'+ list[i]["consultTitle"] +'</h3><em>'+ list[i]["insDt"] +'</em><span class="fin">답변완료</span></a></li>';
							}else{
								vHTML += '<li><a href="#" onclick="fn_consultMove(\''+ list[i]['consultCd'] +'\')"><h3>'+ list[i]["consultTitle"] +'</h3><em>'+ list[i]["insDt"] +'</em><span class="wait">답변대기</span></a></li>';
							}
						}
						
						$("#consultList").html(vHTML);
					},
					error:function(err){
						console.log(err);
					},
					complete:function(){
					}
				});
			}
			break;
		default :
			break;
		}
	}

	// 토파스 항공 예약 단계 표시 
	function replaceTopassStatus(statusCd) {
		//     a. RMQQ : 예약대기
        //     b. RMPQ  : 예약확정
        //     c. RMTQ : 발권완료
        //     d. RMTK : 발권진행
        //     e. RMXX : 취소
		var strStatus = "";
		switch (statusCd)
		{
			case "RMQQ" :
				strStatus = "예약대기";
				break;
			case "RMPQ" :
				strStatus = "예약확정";
				break;
			case "RMTQ" :
				strStatus = "발권대상";
				break;
			case "RMTK" :
				strStatus = "발권완료";
				break;
			case "RMTX" :
				strStatus = "발권완료";
				break;
			case "RMXX" :
				strStatus = "예약취소";
				break;
		}

		return strStatus;
	}

	var fn_moreData = function(type){
		switch(type){
		case 101 :
			var listHistoryTemp = [];
			var curRow = $("#reservationHistory").children().length;
			startRow = curRow + 1;
			endRow = curRow + Number(pageSize);
			
			if(subRadioYn){
				listHistoryTemp = newResList; 
			}else{
				listHistoryTemp = listHistory;
			}
			
			reservationCnt = listHistoryTemp.length;
			
			if(startRow > reservationCnt) {
				alert("더이상 등록된 내역이 없습니다");
				return;
			}
			
			if(reservationCnt > endRow){
				reservationLen = endRow;
			}else{
				reservationLen = reservationCnt; 
			}
			
			var reserHTML = "";
			for(var i = curRow; i < reservationLen; i++){
				reserHTML += '<li>';
				reserHTML += '	<div data-role="collapsible" data-iconpos="right" data-theme="e">';
				reserHTML += '		<h3 class="ui-alt-icon">'+ listHistoryTemp[i].eventNm +'</h3>';
				reserHTML += '		<table>';
				reserHTML += '			<colgroup>';
				reserHTML += '				<col width="30%">';
				reserHTML += '				<col width="70%">';
				reserHTML += '			</colgroup>';
				reserHTML += '			<tbody>';
				reserHTML += '				<tr>';
				reserHTML += '					<th scope="row">예약일</th>';
				reserHTML += '					<td>'+ listHistoryTemp[i].resDay +'</td>';
				reserHTML += '				</tr>';
				reserHTML += '				<tr>';
				reserHTML += '					<th scope="row">출발일</th>';
				reserHTML += '					<td>'+ listHistoryTemp[i].startDay +'</td>';
				reserHTML += '				</tr>';
				reserHTML += '				<tr>';
				reserHTML += '					<th scope="row">총금액</th>';
				reserHTML += '					<td><b class="purple">'+ comma(listHistoryTemp[i].totSaleAmt)+'원</b></td>';
				reserHTML += '				</tr>';
				reserHTML += '				<tr>';
				reserHTML += '					<th scope="row">예약상태</th>';
				reserHTML += '					<td>'+ listHistoryTemp[i].statusNm +'</td>';
				/*
				if(listHistoryTemp[i].statusRgCd == "RC"){
					reserHTML += '					<td>예약완료</td>';
				}else if(listHistoryTemp[i].statusRgCd == "RW"){
					reserHTML += '					<td>예약대기</td>';
				}else if(listHistoryTemp[i].statusRgCd == "RN"){
					reserHTML += '					<td>예약불가</td>';
				}else if(listHistoryTemp[i].statusRgCd == "CC"){
					reserHTML += '					<td>취소완료</td>';
				}else{
					reserHTML += '					<td></td>';
				}
				*/
				reserHTML += '				</tr>';
				reserHTML += '				<tr>';
				reserHTML += '					<th scope="row">예약번호</th>';
				reserHTML += '					<td>'+ listHistoryTemp[i].resCd +'</td>';
				reserHTML += '				</tr>';
				if(listHistoryTemp[i].statusCd == "10" || listHistoryTemp[i].statusCd == "11" || listHistoryTemp[i].statusCd == "H3"){
					reserHTML += '				<tr>';
					reserHTML += '					<th scope="row">결제상태</th>';
					reserHTML += '					<td><a href="#" class="purple2 myt_paybtn" onclick="fn_movePay(\''+ listHistoryTemp[i].resCd +'\')">상세/결제</a></td>';
					reserHTML += '				</tr>';
				} 
				reserHTML += '			</tbody>';
				reserHTML += '		</table>';
				reserHTML += '	</div>';
				reserHTML += '</li>';
			}
			
			$("#reservationHistory").append(reserHTML);
			$("#reservationHistory").trigger('create');
			break;
		case 102 :
			var curRow = $("#cancelHistory").children().length;
			startRow = curRow + 1;
			endRow = curRow + Number(pageSize);
			
			if(startRow > cancelCnt) {
				alert("더이상 등록된 내역이 없습니다");
				return;
			}
			
			if(cancelCnt > endRow){
				cancelLen = endRow;	
			}else{
				cancelLen = cancelCnt;
			}
			
			var cancelHTML = "";
			for(var j = curRow; j < cancelLen; j++){
				cancelHTML += '<li>';
				cancelHTML += '	<div data-role="collapsible" data-iconpos="right" data-collapsed="false" data-theme="e">';
				cancelHTML += '		<h3 class="ui-alt-icon">'+ listCancel[j].eventNm +'</h3>';
				cancelHTML += '		<table>';
				cancelHTML += '			<colgroup>';
				cancelHTML += '				<col width="30%">';
				cancelHTML += '				<col width="70%">';
				cancelHTML += '			</colgroup>';
				cancelHTML += '			<tbody>';
				cancelHTML += '				<tr>';
				cancelHTML += '					<th scope="row">예약일</th>';
				cancelHTML += '					<td>'+ listCancel[j].resDay +'</td>';
				cancelHTML += '				</tr>';
				cancelHTML += '				<tr>';
				cancelHTML += '					<th scope="row">출발일</th>';
				cancelHTML += '					<td>'+ listCancel[j].startDay +'</td>';
				cancelHTML += '				</tr>';
				cancelHTML += '				<tr>';
				cancelHTML += '					<th scope="row">총금액</th>';
				cancelHTML += '					<td><b class="purple">'+ comma(listCancel[j].totSaleAmt)+'원</b></td>';
				cancelHTML += '				</tr>';
				cancelHTML += '				<tr>';
				cancelHTML += '					<th scope="row">예약상태</th>';
				cancelHTML += '					<td>'+ listCancel[j].statusNm +'</td>';
				/*
				if(listCancel[j].statusRgCd == "RC"){
					cancelHTML += '					<td>예약완료</td>';
				}else if(listCancel[j].statusRgCd == "RW"){
					cancelHTML += '					<td>예약대기</td>';
				}else if(listCancel[j].statusRgCd == "RN"){
					cancelHTML += '					<td>예약불가</td>';
				}else if(listCancel[j].statusRgCd == "CC"){
					cancelHTML += '					<td>취소완료</td>';
				}
				*/
				cancelHTML += '				</tr>';
				cancelHTML += '				<tr>';
				cancelHTML += '					<th scope="row">예약번호</th>';
				cancelHTML += '					<td>'+ listCancel[i].resCd +'</td>';
				cancelHTML += '				</tr>';
				/*
				cancelHTML += '				<tr>';
				cancelHTML += '					<th scope="row">결제상태</th>';
				cancelHTML += '					<td><a href="#">상세보기</a></td>';
				cancelHTML += '				</tr>';
				*/ss
				cancelHTML += '			</tbody>';
				cancelHTML += '		</table>';
				cancelHTML += '	</div>';
				cancelHTML += '</li>';
			}
			
			$("#cancelHistory").append(cancelHTML);
			$("#cancelHistory").trigger('create');
			break;
		case 103 :
			var curRow = $("#freeReserve").children().length;
			startRow = curRow + 1;
			endRow = curRow + Number(freePageSize);
			
			if(startRow > freeReserveCnt) {
				alert("더이상 등록된 내역이 없습니다");
				return;
			}
			
			if(freeReserveCnt > endRow){
				freeReserveLen = endRow;
				$("#morebtn5").show();
			}else{
				freeReserveLen = freeReserveCnt;
				$("#morebtn5").hide();
			}
			
			var freeMstHTML = "";
			
			for(var m = curRow; m < freeReserveLen; m++){
				freeMstHTML += '<li>';
				freeMstHTML += '	<div class="free_myt_part on" id="div_'+ listMst[m].fitRsvNo +'" data-collapsed="false">';
				freeMstHTML += '		<h3 class="free_myt_title1 ellipsis">예약코드 : '+ listMst[m].fitRsvNo +' / 예약일 : '+ listMst[m].rsvDt +'</h3>';
				freeMstHTML += '		<div class="fr_myt_gbox1">';
				//freeMstHTML += '			<span class="app_end_box">예약완료</span>';
				freeMstHTML += '			<button type="button" data-role="none" onclick="fn_rsvDetailMove(\'' + listMst[m].fitRsvNo + '\')">상세보기</button>';
				freeMstHTML += '		</div>';
				freeMstHTML += '		<dl class="fr_myt_gbox2">';
				freeMstHTML += '			<div class="cls_air">';
				freeMstHTML += '			</div>';
				freeMstHTML += '			<div class="cls_htl">';
				freeMstHTML += '			</div>';
				freeMstHTML += '			<div class="cls_rnt">';
				freeMstHTML += '			</div>';
				freeMstHTML += '		</dl>';
				freeMstHTML += '		<ul class="fr_myt_gbox3">';
				
				var rsvTotAmt = parseInt(listMst[m].saleAmtTot);
				if(nullToBlank(listMst[m].airDiscntAmt) != "" && listMst[m].airDiscntAmt != '0'){
					freeMstHTML += '			<li>항공 프로모션 <span>-'+ comma(listMst[m].airDiscntAmt) +'원</span></li>';
					rsvTotAmt = rsvTotAmt - parseInt(listMst[m].airDiscntAmt);
				}
				
				if(nullToBlank(listMst[m].htlDiscntAmt) != "" && listMst[m].htlDiscntAmt != '0'){
					freeMstHTML += '			<li>호텔 프로모션 <span>-'+ comma(listMst[m].htlDiscntAmt) +'원</span></li>';
					rsvTotAmt = rsvTotAmt - parseInt(listMst[m].htlDiscntAmt);
				}
				
				if(nullToBlank(listMst[m].rntDiscntAmt) != "" && listMst[m].rntDiscntAmt != '0'){
					freeMstHTML += '			<li>렌터카 프로모션 <span>-'+ comma(listMst[m].rntDiscntAmt) +'원</span></li>';
					rsvTotAmt = rsvTotAmt - parseInt(listMst[m].rntDiscntAmt);
				}
				
				//if(nullToBlank(listMst[m].promAmount) != "" && listMst[m].promAmount != '0'){
				//	freeMstHTML += '			<li>'+ listMst[m].promNm +'<span>-'+ comma(listMst[m].promAmount) +'원</span></li>';
				//	rsvTotAmt = rsvTotAmt - parseInt(listMst[m].promAmount);
				//}
				
				//if(nullToBlank(listMst[m].promRate) != "" && listMst[m].promRate != '0'){
				//	var mstPromAmt = rsvTotAmt * parseFloat(listMst[m].promRate);
				//	freeMstHTML += '			<li>'+ listMst[m].promNm +'<span>-'+ comma(Math.floor(mstPromAmt)) +'원</span></li>';
				//	rsvTotAmt = rsvTotAmt - Math.floor(mstPromAmt); 
				//}
				
				freeMstHTML += '			<li class="tl frmyt_allprice">총 결제예정금액 <span>'+ comma(rsvTotAmt) +'원</span></li>';
//				freeMstHTML += '			<li id="'+ listMst[m].fitRsvNo +'_vou" style="display:none;">';
//				freeMstHTML += '				<button type="button" data-role="none" id="'+ listMst[m].fitRsvNo +'_vou_air" style="display:none;">항공 E-Ticket</button>';
//				freeMstHTML += '				<button type="button" data-role="none" id="'+ listMst[m].fitRsvNo +'_vou_htl" style="display:none;">호텔 바우처</button>';
//				freeMstHTML += '				<button type="button" data-role="none" id="'+ listMst[m].fitRsvNo +'_vou_rnt" style="display:none;">렌터카 바우처</button>';
//				freeMstHTML += '			</li>';
				freeMstHTML += '		</ul>';
				freeMstHTML += '	</div>';
				freeMstHTML += '</li>';
			}
			
			$('#freeReserve').append(freeMstHTML);
			
			setTimeout(function(){
				for(var a = 0; a < listAir.length; a++){
					var freeAirHTML = "";
					var inwan = "";
					
					if(listAir[a].itinShapeGb == "RT"){
						freeAirHTML += '		<dt class="ft_myy_ico1">'+ listAir[a].depNm +' - '+ listAir[a].firstArrNm +' - '+ listAir[a].lastArrNm +'</dt>';
					}else if(listAir[a].itinShapeGb == "OW"){
						freeAirHTML += '		<dt class="ft_myy_ico1">'+ listAir[a].depNm +' - '+ listAir[a].firstArrNm +'</dt>';
					}
					freeAirHTML += '		<dd>';
					freeAirHTML += '			<span class="fr_myt_gbtn1">'+ listAir[a].fareStateNm +'</span>';
					freeAirHTML += '			<span class="fr_myt_gbtn2">'+ listAir[a].rsvStateNm +'</span>';
					if(listAir[a].itinShapeGb == "RT"){
						freeAirHTML += '			<p>출발 : '+ listAir[a].depDt +' / 귀국 : '+ listAir[a].lastArrDt +'</p>';
					}else if(listAir[a].itinShapeGb == "OW"){
						freeAirHTML += '			<p>출발 : '+ listAir[a].depDt +'</p>';
					}
					
					if(listAir[a].adt != '0'){
						inwan += '성인'+ listAir[a].adt +'명 ';
					}
					if(listAir[a].chd != '0'){
						inwan += '소아'+ listAir[a].chd +'명 ';
					}
					if(listAir[a].inf != '0'){
						inwan += '유아'+ listAir[a].inf +'명 ';
					}
					
					freeAirHTML += '				<p>'+ inwan +'</p>';
					freeAirHTML += '			<div class="ft_myt_btp">';
					if(listAir[a].rsvStateGb == "TK"){
						freeAirHTML += '				<button type="button" data-role="none" onClick="\setAlert("서비스준비중입니다.\")>항공 E-Ticket</button>';
					}
					//freeAirHTML += '				<div>'+ comma(parseInt(listAir[a].totSaleAmt) + parseInt(listAir[a].totTasfAmt)) +'원</div>';
					freeAirHTML += '				<div>'+ comma(listAir[a].saleAmtAir) +'원</div>';
					freeAirHTML += '			</div>';
					freeAirHTML += '		</dd>';
					
					$("#div_"+ listAir[a].fitRsvNo).find(".cls_air").append(freeAirHTML);
					
					if(listAir[a].rsvStateGb == "TK" || listAir[a].rsvStateGb == "TW"){
						$("#"+ listAir[a].fitRsvNo +"_vou").show();
						$("#"+ listAir[a].fitRsvNo +"_vou_air").show();
					}
				}
				
				for(var h = 0; h < listHtl.length; h++){
					var freeHtlHTML = "";
					var inwan = "";
					
					freeHtlHTML += '<dt class="ft_myy_ico2">'+ listHtl[h].htlNm +'</dt>';
					freeHtlHTML += '<dd>';
					freeHtlHTML += '	<span class="fr_myt_gbtn1">'+ listHtl[h].htlRsvstateNm +'</span>';
					if(nullToBlank(listHtl[h].htlPaymtstateNm) != ""){
						freeHtlHTML += '	<span class="fr_myt_gbtn2">'+ listHtl[h].htlPaymtstateNm +'</span>';
					}
					freeHtlHTML += '	<p>체크인 : '+ listHtl[h].checkinDt +' / 체크아웃 : '+ listHtl[h].checkoutDt +'</p>'
					if(listHtl[h].adtQty != '0'){
						inwan += '성인 '+ listHtl[h].adtQty +'명 ';
					}
					if(listHtl[h].childQty != '0'){
						inwan += '소아 '+ listHtl[h].childQty +'명 ';
					}
					freeHtlHTML += '	<p>객실 '+ listHtl[h].roomCnt +'개 '+ inwan +'</p>';
					freeHtlHTML += '  <div class="ft_myt_btp">';
					if(listHtl[h].htlRsvstateGb == "OK" && listHtl[h].htlPaymtstateGb == "OK"){
						freeHtlHTML += '	<button type="button" data-role="none" onClick="fn_goHtlVou(' +listHtl[h].htlRsvSeqno+ ')">호텔 바우처</button>';
					}
					if(listHtl[h].saleCurrency == "KRW"){
						freeHtlHTML += '	<div>'+ comma(listHtl[h].saleAmt) +'원</div>';
					}else{
						freeHtlHTML += '	<div>'+ comma(Math.ceil(parseFloat(listHtl[h].saleAmt))) +'원</div>';	
					}
					//freeHtlHTML += '	<div>'+ comma(listHtl[h].saleAmt) +'원</div>';
					freeHtlHTML += '  </div>';
					freeHtlHTML += '</dd>';
					
					$("#div_"+ listHtl[h].fitRsvNo).find(".cls_htl").append(freeHtlHTML);
					
					if(listHtl[h].htlPaymtstateGb == "OK"){
						$("#"+ listHtl[h].fitRsvNo +"_vou").show();
						$("#"+ listHtl[h].fitRsvNo +"_vou_htl").show();
					}
				}
				
				for(var r = 0; r < listRnt.length; r++){
					var freeRntHTML = "";
					var korAmt = (exchangeObj[listRnt[r].currencyCd] * parseFloat(listRnt[r].saleAmt)).toFixed();
					
					freeRntHTML += '<dt class="ft_myy_ico3">'+ listRnt[r].carModelNm +'</dt>';
					freeRntHTML += '<dd>';
					freeRntHTML += '	<p>인수 : '+ listRnt[r].pickupDt +' / 반납 : '+ listRnt[r].rtDt +'</p>';
					freeRntHTML += '	<span class="fr_myt_gbtn1">'+ listRnt[r].rntStateNm +'</span>';
					freeRntHTML += '  	<div class="ft_myt_btp">';
					freeRntHTML += '		<button type="button" data-role="none" onClick="fn_goRntVou(' +listRnt[r].rntRsvSeqno+ ')">렌트카 바우처</button>';
					freeRntHTML += '		<div><span class="black_text1">'+ comma(korAmt) +'원 / </span>'+ comma(listRnt[r].saleAmt) + " " + listRnt[r].currencyCd +'</div>';
					freeRntHTML += '	</div>';
					freeRntHTML += '</dd>';
					
					$("#div_"+ listRnt[r].fitRsvNo).find(".cls_rnt").append(freeRntHTML);
					
					if(listRnt[r].rntStateGb == "OK"){
						$("#"+ listRnt[r].fitRsvNo +"_vou").show();
						$("#"+ listRnt[r].fitRsvNo +"_vou_rnt").show();
					}
				}
				
				for(var m = curRow; m < freeReserveLen; m++){
					for(var a = 0; a < listAir.length; a++){
						if(listMst[m].fitRsvNo == listAir[a].fitRsvNo){
							listAir.splice(a, 1);	
							
							a--;
						}
					}
					
					for(var h = 0; h < listHtl.length; h++){
						if(listMst[m].fitRsvNo == listHtl[h].fitRsvNo){
							listHtl.splice(h, 1);	
							
							h--;
						}
					}
					
					for(var r = 0; r < listRnt.length; r++){
						if(listMst[m].fitRsvNo == listRnt[r].fitRsvNo){
							listRnt.splice(r, 1);	
							
							r--;
						}
					}
				}
			}, 100);

			$("#freeReserve").trigger('create');
			
			$(".free_myt_part .free_myt_title1").off();
			$(".free_myt_part .free_myt_title1").on("click", function(){
				$(this).parent().toggleClass("on");
			});
			break;
		case 104 :
			var curRow = $("#freeCancelReserve").children().length;
			startRow = curRow + 1;
			endRow = curRow + Number(freePageSize);
			
			if(startRow > freeCancelCnt) {
				alert("더이상 등록된 내역이 없습니다");
				return;
			}
			
			if(freeCancelCnt > endRow){
				freeCancelLen = endRow;
				$("#morebtn6").show();
			}else{
				freeCancelLen = freeCancelCnt;
				$("#morebtn6").hide();
			}
			
			var freeCancelMstHTML = "";
			
			for(var cm = curRow; cm < freeCancelLen; cm++){
				freeCancelMstHTML += '<li>';
				freeCancelMstHTML += '	<div class="free_myt_part on" id="div_'+ listCancelMst[cm].fitRsvNo +'" data-collapsed="false">';
				freeCancelMstHTML += '		<h3 class="free_myt_title1 ellipsis">예약코드 : '+ listCancelMst[cm].fitRsvNo +' / 예약일 : '+ listCancelMst[cm].rsvDt +'</h3>';
				freeCancelMstHTML += '		<div class="fr_myt_gbox1">';
				freeCancelMstHTML += '			<span class="app_cancel_box">예약취소</span>';
				freeCancelMstHTML += '			<button type="button" data-role="none" onclick="fn_rsvDetailMove(\'' + listCancelMst[cm].fitRsvNo + '\')">상세보기</button>';
				freeCancelMstHTML += '		</div>';
				freeCancelMstHTML += '		<dl class="fr_myt_gbox2">';
				freeCancelMstHTML += '			<div class="cls_air">';
				freeCancelMstHTML += '			</div>';
				freeCancelMstHTML += '			<div class="cls_htl">';
				freeCancelMstHTML += '			</div>';
				freeCancelMstHTML += '			<div class="cls_rnt">';
				freeCancelMstHTML += '			</div>';
				freeCancelMstHTML += '		</dl>';
				freeCancelMstHTML += '		<ul class="fr_myt_gbox3">';
				
				var rsvTotAmt = parseInt(listCancelMst[cm].saleAmtTot);
				if(nullToBlank(listCancelMst[cm].airDiscntAmt) != "" && listCancelMst[cm].airDiscntAmt != '0'){
					freeCancelMstHTML += '			<li>항공 프로모션 <span>-'+ comma(listCancelMst[cm].airDiscntAmt) +'원</span></li>';
					rsvTotAmt = rsvTotAmt - parseInt(listCancelMst[cm].airDiscntAmt);
				}
				
				if(nullToBlank(listCancelMst[cm].htlDiscntAmt) != "" && listCancelMst[cm].htlDiscntAmt != '0'){
					freeCancelMstHTML += '			<li>호텔 프로모션 <span>-'+ comma(listCancelMst[cm].htlDiscntAmt) +'원</span></li>';
					rsvTotAmt = rsvTotAmt - parseInt(listCancelMst[cm].htlDiscntAmt);
				}
				
				if(nullToBlank(listCancelMst[cm].rntDiscntAmt) != "" && listCancelMst[cm].rntDiscntAmt != '0'){
					freeCancelMstHTML += '			<li>렌터카 프로모션 <span>-'+ comma(listCancelMst[cm].rntDiscntAmt) +'원</span></li>';
					rsvTotAmt = rsvTotAmt - parseInt(listCancelMst[cm].rntDiscntAmt);
				}
				
				//if(nullToBlank(listCancelMst[cm].promAmount) != "" && listCancelMst[cm].promAmount != '0'){
				//	freeCancelMstHTML += '			<li>'+ listCancelMst[cm].promNm +'<span>-'+ comma(listCancelMst[cm].promAmount) +'원</span></li>';
				//	rsvTotAmt = rsvTotAmt - parseInt(listCancelMst[cm].promAmount);
				//}
				
				//if(nullToBlank(listCancelMst[cm].promRate) != "" && listCancelMst[cm].promRate != '0'){
				//	var mstPromAmt = rsvTotAmt * parseFloat(listCancelMst[cm].promRate);
				//	freeCancelMstHTML += '			<li>'+ listCancelMst[cm].promNm +'<span>-'+ comma(Math.floor(mstPromAmt)) +'원</span></li>';
				//	rsvTotAmt = rsvTotAmt - Math.floor(mstPromAmt); 
				//}
				
				freeCancelMstHTML += '			<li class="tl frmyt_allprice">총 결제예정금액 <span>'+ comma(rsvTotAmt) +'원</span></li>';
				freeCancelMstHTML += '		</ul>';
				freeCancelMstHTML += '	</div>';
				freeCancelMstHTML += '</li>';
			}
			
			$('#freeCancelReserve').append(freeCancelMstHTML);
			
			setTimeout(function(){
				for(var ca = 0; ca < listCancelAir.length; ca++){
					var freeCancelAirHTML = "";
					var inwan = "";
					
					if(listCancelAir[ca].itinShapeGb == "RT"){
						freeCancelAirHTML += '		<dt class="ft_myy_ico1">'+ listCancelAir[ca].depNm +' - '+ listCancelAir[ca].firstArrNm +' - '+ listCancelAir[ca].lastArrNm +'</dt>';
					}else if(listCancelAir[ca].itinShapeGb == "OW"){
						freeCancelAirHTML += '		<dt class="ft_myy_ico1">'+ listCancelAir[ca].depNm +' - '+ listCancelAir[ca].firstArrNm +'</dt>';
					}
					freeCancelAirHTML += '		<dd>';
					freeCancelAirHTML += '			<span class="fr_myt_gbtn1">'+ listCancelAir[ca].fareStateNm +'</span>';
					freeCancelAirHTML += '			<span class="fr_myt_gbtn2">'+ listCancelAir[ca].rsvStateNm +'</span>';
					if(listCancelAir[ca].itinShapeGb == "RT"){
						freeCancelAirHTML += '			<p>출발 : '+ listCancelAir[ca].depDt +' / 귀국 : '+ listCancelAir[ca].lastArrDt +'</p>';
					}else if(listCancelAir[ca].itinShapeGb == "OW"){
						freeCancelAirHTML += '			<p>출발 : '+ listCancelAir[ca].depDt +'</p>';
					}
					
					if(listCancelAir[ca].adt != '0'){
						inwan += '성인'+ listCancelAir[ca].adt +'명 ';
					}
					if(listCancelAir[ca].chd != '0'){
						inwan += '소아'+ listCancelAir[ca].chd +'명 ';
					}
					if(listCancelAir[ca].inf != '0'){
						inwan += '유아'+ listCancelAir[ca].inf +'명 ';
					}
					
					freeCancelAirHTML += '				<p>'+ inwan +'</p>';
					freeCancelAirHTML += '			<div class="ft_myt_btp">';
					//freeCancelAirHTML += '				<div>'+ comma(parseInt(listCancelAir[ca].totSaleAmt) + parseInt(listCancelAir[ca].totTasfAmt)) +'원</div>';
					freeCancelAirHTML += '				<div>'+ comma(listCancelAir[ca].saleAmtAir) +'원</div>';
					freeCancelAirHTML += '			</div>';
					freeCancelAirHTML += '		</dd>';
					
					$("#div_"+ listCancelAir[ca].fitRsvNo).find(".cls_air").append(freeCancelAirHTML);
				}
				
				for(var ch = 0; ch < listCancelHtl.length; ch++){
					var freeCancelHtlHTML = "";
					var inwan = "";
					
					freeCancelHtlHTML += '<dt class="ft_myy_ico2">'+ listCancelHtl[ch].htlNm +'</dt>';
					freeCancelHtlHTML += '<dd>';
					freeCancelHtlHTML += '	<span class="fr_myt_gbtn1">'+ listCancelHtl[ch].htlRsvstateNm +'</span>';
					if(nullToBlank(listCancelHtl[ch].htlPaymtstateNm) != ""){
						freeCancelHtlHTML += '	<span class="fr_myt_gbtn2">'+ listCancelHtl[ch].htlPaymtstateNm +'</span>';	
					}
					freeCancelHtlHTML += '	<p>체크인 : '+ listCancelHtl[ch].checkinDt +' / 체크아웃 : '+ listCancelHtl[ch].checkoutDt +'</p>'
					if(listCancelHtl[ch].adtQty != '0'){
						inwan += '성인 '+ listCancelHtl[ch].adtQty +'명 ';
					}
					if(listCancelHtl[ch].childQty != '0'){
						inwan += '소아 '+ listCancelHtl[ch].childQty +'명 ';
					}
					freeCancelHtlHTML += '	<p>객실 '+ listCancelHtl[ch].roomCnt +'개 '+ inwan +'</p>';
					freeCancelHtlHTML += '  <div class="ft_myt_btp">';
					if(listCancelHtl[ch].saleCurrency == "KRW"){
						freeCancelHtlHTML += '	<div>'+ comma(listCancelHtl[ch].saleAmt) +'원</div>';
					}else{
						freeCancelHtlHTML += '	<div>'+ comma((parseFloat(listCancelHtl[ch].saleAmt) * parseFloat(listCancelHtl[ch].exchangeRate)).toFixed()) +'원</div>';	
					}
					//freeCancelHtlHTML += '		<div>'+ comma(listCancelHtl[ch].saleAmt) +'원</div>';
					freeCancelHtlHTML += '	</div>';
					freeCancelHtlHTML += '</dd>';
					
					$("#div_"+ listCancelHtl[ch].fitRsvNo).find(".cls_htl").append(freeCancelHtlHTML);
				}
				
				for(var cr = 0; cr < listCancelRnt.length; cr++){
					var freeCancelRntHTML = "";
					var korAmt = (exchangeObj[listCancelRnt[cr].currencyCd] * parseFloat(listCancelRnt[cr].saleAmt)).toFixed();
					
					freeCancelRntHTML += '<dt class="ft_myy_ico3">'+ listCancelRnt[cr].carModelNm +'</dt>';
					freeCancelRntHTML += '<dd>';
					freeCancelRntHTML += '	<p>인수 : '+ listCancelRnt[cr].pickupDt +' / 반납 : '+ listCancelRnt[cr].rtDt +'</p>';
					freeCancelRntHTML += '	<span class="fr_myt_gbtn1">'+ listCancelRnt[cr].rntStateNm +'</span>';
					freeCancelHtlHTML += '  <div class="ft_myt_btp">';
					freeCancelRntHTML += '		<button type="button" data-role="none" onClick="fn_goRntVou(' +listCancelRnt[cr].rntRsvSeqno+ ')">렌트카 바우처</button>';
					freeCancelRntHTML += '		<div><span class="black_text1">'+ comma(korAmt) +'원 / </span>'+ comma(listCancelRnt[cr].saleAmt) + " " + listCancelRnt[cr].currencyCd +'</div>';
					freeCancelRntHTML += '	</div>';
					freeCancelRntHTML += '</dd>';
					
					$("#div_"+ listCancelRnt[cr].fitRsvNo).find(".cls_rnt").append(freeCancelRntHTML);
				}
				
				for(var cm = 0; cm < freeCancelLen; cm++){
					for(var ca = 0; ca < listCancelAir.length; ca++){
						if(listCancelMst[cm].fitRsvNo == listCancelAir[ca].fitRsvNo){
							listCancelAir.splice(ca, 1);
							
							ca--;
						}
					}
					
					for(var ch = 0; ch < listCancelHtl.length; ch++){
						if(listCancelMst[cm].fitRsvNo == listCancelHtl[ch].fitRsvNo){
							listCancelHtl.splice(ch, 1);
							
							ch--;
						}
					}
					
					for(var cr = 0; cr < listCancelRnt.length; cr++){
						if(listCancelMst[cm].fitRsvNo == listCancelRnt[cr].fitRsvNo){
							listCancelRnt.splice(cr, 1);
							
							cr--;
						}
					}
				}
			}, 100);
			
			$("#freeCancelReserve").trigger('create');
			
			$(".free_myt_part .free_myt_title1").off();
			$(".free_myt_part .free_myt_title1").on("click", function(){
				$(this).parent().toggleClass("on");
			});
			break;
		case 105 :
			var curRow = $("#topassAirReserve").children().length;
			startRow = curRow + 1;
			endRow = curRow + Number(airPageSize);
			
			if(startRow > topassListAirCnt) {
				alert("더이상 등록된 내역이 없습니다");
				return;
			}
			
			if(topassListAirCnt > endRow){
				topassListAirLen = endRow;
				$("#morebtn7").show();
			}else{
				topassListAirLen = topassListAirCnt;
				$("#morebtn7").hide();
			}
			
			var airMstHTML = "";
			
			for(var m = curRow; m < topassListAir.length; m++){
				airMstHTML += '<li>';
				if(m == 0){
					airMstHTML += '	<div class="free_myt_part on" id="div_'+ topassListAir[m].PNR_SEQ_NO +'" data-collapsed="false">';
				}else{
					airMstHTML += '	<div class="free_myt_part" id="div_'+ topassListAir[m].PNR_SEQ_NO +'" data-collapsed="false">';	
				}
				airMstHTML += '		<h3 class="free_myt_title1 ellipsis">예약코드 : '+ topassListAir[m].PNR_SEQ_NO +' / 예약일 : '+ topassListAir[m].FORMAT_RESV_DATE +'</h3>';
				airMstHTML += '		<div class="fr_myt_gbox1">';
				airMstHTML += '			<span class="app_end_box">'+replaceTopassStatus(topassListAir[m].RM_LAST_STATUS)+'</span>';
				airMstHTML += '			<button type="button" data-role="none" onclick="fn_rsvAirDetailMove(\'' + topassListAir[m].PNR_SEQ_NO + '\')">상세보기</button>';
				airMstHTML += '		</div>';
				airMstHTML += '		<dl class="fr_myt_gbox2">';
				airMstHTML += '			<div class="cls_air">';
				airMstHTML += '				<dt class="ft_myy_ico1">'+ topassListAir[m].TOTAL_ITIN +'</dt>';
				airMstHTML += '				<dd>';
				airMstHTML += '					<span class="fr_myt_gbtn2">'+ replaceTopassStatus(topassListAir[m].RM_LAST_STATUS) +'</span>';
				airMstHTML += '				</dd>';
				airMstHTML += '			</div>';
				airMstHTML += '		</dl>';
				airMstHTML += '		<ul class="fr_myt_gbox3">';
				airMstHTML += '			<li class="tl frmyt_allprice">총 결제예정금액 <span>'+ topassListAir[m].FORMAT_TOTAL_FARE +'원</span></li>';
				airMstHTML += '		</ul>';
				airMstHTML += '	</div>';
				airMstHTML += '</li>';
			}
			
			$('#topassAirReserve').append(airMstHTML);

			$("#topassAirReserve").trigger('create');
			
			$(".free_myt_part .free_myt_title1").off();
			$(".free_myt_part .free_myt_title1").on("click", function(){
				$(this).parent().toggleClass("on");
			});
			break;

		case 106 :
			var curRow = $("#topassAirCancelReserve").children().length;
			startRow = curRow + 1;
			endRow = curRow + Number(airPageSize);
			
			if(startRow > topassListAirCancelCnt) {
				alert("더이상 등록된 내역이 없습니다");
				return;
			}
			
			if(topassListAirCancelCnt > endRow){
				topassListAirCancelLen = endRow;
				$("#morebtn8").show();
			}else{
				topassListAirCancelLen = topassListAirCancelCnt;
				$("#morebtn8").hide();
			}
			
			var airCancelMstHTML = "";
			
			for(var cm = startRow; cm < topassListAirCancelLen; cm++){
				airCancelMstHTML += '<li>';
				if(cm == 0){
					airCancelMstHTML += '	<div class="free_myt_part on" id="div_'+ topassListAirCancel[cm].PNR_SEQ_NO +'" data-collapsed="false">';
				}else{
					airCancelMstHTML += '	<div class="free_myt_part" id="div_'+ topassListAirCancel[cm].PNR_SEQ_NO +'" data-collapsed="false">';	
				}
				airCancelMstHTML += '		<h3 class="free_myt_title1 ellipsis">예약코드 : '+ topassListAirCancel[cm].PNR_SEQ_NO +' / 예약일 : '+ topassListAirCancel[cm].FORMAT_RESV_DATE +'</h3>';
				airCancelMstHTML += '		<div class="fr_myt_gbox1">';
				airCancelMstHTML += '			<span class="app_end_box">'+replaceTopassStatus(topassListAirCancel[cm].RM_LAST_STATUS)+'</span>';
				airCancelMstHTML += '			<button type="button" data-role="none" onclick="fn_rsvAirDetailMove(\'' + topassListAirCancel[cm].PNR_SEQ_NO + '\')">상세보기</button>';
				airCancelMstHTML += '		</div>';
				airCancelMstHTML += '		<dl class="fr_myt_gbox2">';
				airCancelMstHTML += '			<div class="cls_air">';
				airCancelMstHTML += '				<dt class="ft_myy_ico1">'+ topassListAirCancel[cm].TOTAL_ITIN +'</dt>';
				airCancelMstHTML += '				<dd>';
				airCancelMstHTML += '					<span class="fr_myt_gbtn2">'+ replaceTopassStatus(topassListAirCancel[cm].RM_LAST_STATUS) +'</span>';
				airCancelMstHTML += '				</dd>';
				airCancelMstHTML += '			</div>';
				airCancelMstHTML += '		</dl>';
				airCancelMstHTML += '		<ul class="fr_myt_gbox3">';
				airCancelMstHTML += '			<li class="tl frmyt_allprice">총 결제예정금액 <span>'+ topassListAirCancel[cm].FORMAT_TOTAL_FARE +'원</span></li>';
				airCancelMstHTML += '		</ul>';
				airCancelMstHTML += '	</div>';
				airCancelMstHTML += '</li>';
			}
			
			$('#topassAirCancelReserve').append(airCancelMstHTML);
			

			
			$("#topassAirCancelReserve").trigger('create');
			
			$(".free_myt_part .free_myt_title1").off();
			$(".free_myt_part .free_myt_title1").on("click", function(){
				$(this).parent().toggleClass("on");
			});
			break;
		case 201 :
			var curRow = $("#choiceGoods").children().length;
			startRow = curRow + 1;
			endRow = curRow + Number(pageSize);
			
			var choiceFormData = new FormData();
			choiceFormData.append('custCd', custCd);
			choiceFormData.append('wishCd', '01');
			choiceFormData.append('startRow', startRow);
			choiceFormData.append('endRow', endRow);
			
			if(startRow > choiceCnt) {
				alert("더이상 등록된 내역이 없습니다");
				return;
			}
			
			cfn_ajax({
				type: "POST",
				async: false,
				url: "<c:url value='/mytour/choiceGoodsList.do' />",
				data: choiceFormData,
				dataType: "json",
				cache: false,
				noloading:"no",
				success: function(res) {
					list = res.list;
					var vHTML = "";
					
					for(var i = 0; i < list.length; i++){
						//var imagePath = "http://www.lottejtb.com/upload/common/goods/" + list[i].goodsCd.substring(0, 2) + "/" + list[i].goodsCd + "/" + list[i].saveFileNm;
						var imagePath = "/m_file/upload/common/goods/" + list[i].goodsCd.substring(0, 2) + "/" + list[i].goodsCd + "/" + list[i].saveFileNm;
						
						vHTML += '<li>';
						vHTML += '	<a href="#">';
						vHTML += '		<div class="check_jjip check_jjip_'+startRow+'">';
						vHTML += '			<input type="checkbox" class="choiceDel" id="choiceDel_'+ list[i].wishSeq +'" value="'+ list[i].wishSeq +'" />';
						vHTML += '			<label for="choiceDel_'+ list[i].wishSeq +'"></label>';
						vHTML += '		</div>';
						vHTML += '		<span class="img" onclick="fn_quickDetail(\''+ list[i].eventCd +'\', \''+ list[i].ctgSeq +'\')"><img src="'+ imagePath +'" alt="" /></span><h3 onclick="fn_quickDetail(\''+ list[i].eventCd +'\', \''+ list[i].ctgSeq +'\')">'+ list[i].eventNm +'</h3>';
						vHTML += '		<span class="holedate">여행기간 :'+ list[i].evNightCnt +'박 '+ list[i].evDayCnt +'일</span>';
						if(list[i].trffKnm.indexOf("아시아나") != -1){
							vHTML += '		<span class="startday">이용항공 : <img src="/resources/images/ico/air_OZ.png" class="img">'+ list[i].trffKnm +'</span>';
						}else if(list[i].trffKnm.indexOf("진에어") != -1){
							vHTML += '		<span class="startday">이용항공 : <img src="/resources/images/ico/air_LJ.png" class="img mgL5">'+ list[i].trffKnm +'</span>';
						}else if(list[i].trffKnm.indexOf("대한항공") != -1){
							vHTML += '		<span class="startday">이용항공 : <img src="/resources/images/ico/air_KE.png" class="img mgL5">'+ list[i].trffKnm +'</span>';
						}else if(list[i].trffKnm.indexOf("티웨이") != -1){
							vHTML += '		<span class="startday">이용항공 : <img src="/resources/images/ico/air_TW.png" class="img mgL5">'+ list[i].trffKnm +'</span>';
						}else{
							vHTML += '		<span class="startday">이용항공 : '+ list[i].trffKnm +'</span>';
						}
						vHTML += '		<span class="money"><i>'+ comma(list[i].adultPrice) +'</i>원~</span>';
						vHTML += '	</a>';
						vHTML += '</li>';
					}
					
					$("#choiceGoods").append(vHTML);
				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
					$(".check_jjip").trigger('create');
				}
			});
			
			break;
		case 202 :
			break;
		case 301 :
			var curRow = $("#eventHistory").children().length;
			var date = new Date();
			date = date.format("yyyyMMdd");
			
			startRow = curRow + 1;
			endRow = curRow + Number(pageSize);
			
			var eventFormData = new FormData();
			eventFormData.append('custCd', custCd);
			eventFormData.append('startRow', startRow);
			eventFormData.append('endRow', endRow);
			
			if(startRow > eventCnt) {
				alert("더이상 등록된 내역이 없습니다");
				return;
			}
			
			cfn_ajax({
				type: "POST",
				async: false,
				url: "<c:url value='/mytour/myEventList.do' />",
				data: eventFormData,
				dataType: "json",
				cache: false,
				noloading:"no",
				success: function(res) {
					var list = res.list;
					var vHTML = "";
					
					for(var i = 0; i < list.length; i++){
						if(nullToBlank(list[i].eventDesc) != ""){
							vHTML += '<li><a href="#" onclick="fn_eventMove(\''+ list[i].eventSeq +'\', \''+ list[i].eventNm +'\', \''+ list[i].eventFrDay +'\', \''+ list[i].eventToDay +'\', 2)"><h3><span class="purple">당첨자발표</span>'+ list[i].eventNm +'</h3><em>'+ list[i].eventFrDay +'~'+ list[i].eventToDay +'</em></a></li>';
						}else if(date >= list[i].eventFrDay && date <= list[i].eventToDay){
							vHTML += '<li><a href="#" onclick="fn_eventMove(\''+ list[i].eventSeq +'\', \''+ list[i].eventNm +'\', \''+ list[i].eventFrDay +'\', \''+ list[i].eventToDay +'\', 0)"><h3><span class="orange">진행중인 이벤트</span>'+ list[i].eventNm +'</h3><em>'+ list[i].eventFrDay +'~'+ list[i].eventToDay +'</em></a></li>';
						}else{
							vHTML += '<li><a href="#" onclick="fn_eventEnd()"><h3><span class="gray">종료된 이벤트</span>'+ list[i].eventNm +'</h3><em>'+ list[i].eventFrDay +'~'+ list[i].eventToDay +'</em></a></li>';
						}
					}
					
					$("#eventHistory").append(vHTML);
				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
				}
			});
			break;
		case 302 :
			var curRow = $("#consultList").children().length;
			
			startRow = curRow + 1;
			endRow = curRow + Number(pageSize);
			
			var consultFormData = new FormData();
			consultFormData.append('custCd', custCd);
			consultFormData.append('startRow', startRow);
			consultFormData.append('endRow', endRow);
			
			if(startRow > consultCnt) {
				alert("더이상 등록된 내역이 없습니다");
				return;
			}
			
			cfn_ajax({
				type: "POST",
				async: false,
				url: "<c:url value='/customer/qnaListAjax.do' />",
				data: consultFormData,
				dataType: "json",
				cache: false,
				noloading:"no",
				success: function(res) {						
					var list = res.list
					var vHTML = "";
					
					for(var i = 0; i < list.length; i++){
						if(Number(list[i]["ansCnt"]) > 0){
							vHTML += '<li><a href="#" onclick="fn_consultMove(\''+ list[i]['consultCd'] +'\')"><h3>'+ list[i]["consultTitle"] +'</h3><em>'+ list[i]["insDt"] +'</em><span class="fin">답변완료</span></a></li>';
						}else{
							vHTML += '<li><a href="#" onclick="fn_consultMove(\''+ list[i]['consultCd'] +'\')"><h3>'+ list[i]["consultTitle"] +'</h3><em>'+ list[i]["insDt"] +'</em><span class="wait">답변대기</span></a></li>';
						}
					}
					
					$("#consultList").append(vHTML);
				},
				error:function(err){
					console.log(err);
				},
				complete:function(){
				
				}
			});
			
			break;
		default :
			break;
		}
	}
	
	var fn_eventMove = function(seq, name, from, to, tabNo){
		window.location.href = "/event/event_detail.do?eventSeq="+ seq +"&eventNm="+ name +"&eventS="+ from +"&eventE="+ to +"&tabNo="+ tabNo +"&backYn=Y";
	}
	
	var fn_eventEnd = function(){
		alert("종료된 이벤트 입니다.");
		return false;
	}
	
	var fn_consultMove = function(seq){
		window.location.href = "/customer/qnaList.do?consultCd="+ seq;
	};
	
	var fn_quickDetail = function(eventCd, ctg){
		window.location.href = "/goods/detail_goods.do?ctg="+ ctg +"&eventCd="+ eventCd;
	}
	
	var fn_popClick = function(val, text){
		$('#dateText').text(text);
		dateVal = val;
		var resDate = null;
		
		if(nullToBlank(custCd) == ""){
			return false;
		}
		
		var date = new Date();
		
		switch(dateVal){
		case 01:
		case '01':
			date.setMonth(date.getMonth() -1);
			break;
		case 02:
		case '02':
			date.setMonth(date.getMonth() -3);
			break;
		case 03:
		case '03':
			date.setYear(date.getFullYear() -1);
			break;
		case '03':
			date.setYear(date.getFullYear() -100);
			break;
		}
		
		date = date.format("yyyyMMdd");
		resDate = date;
		
		var reservFormData = new FormData();
		reservFormData.append('custCd', custCd);
		reservFormData.append('resDate', resDate);
		
		cfn_ajax({
			type: "POST",
			async: false,
			url: "<c:url value='/mytour/myReservationDateList.do' />",
			data: reservFormData,
			dataType: "json",
			cache: false,
			noloading:"no",
			success: function(res) {
				listHistory = res.listHistory;
				
				reservationCnt = listHistory.length;
				reservationLen = reservationCnt; 
				
				if(reservationCnt > pageSize){
					reservationLen = pageSize;	
				}
				
				var reserHTML = "";
				for(var i = 0; i < reservationLen; i++){
					reserHTML += '<li>';
					reserHTML += '	<div data-role="collapsible" data-theme="e" data-collapsed="false">';
					reserHTML += '		<h3 class="ui-alt-icon">'+ listHistory[i].eventNm +'</h3>';
					reserHTML += '		<table>';
					reserHTML += '			<colgroup>';
					reserHTML += '				<col width="30%">';
					reserHTML += '				<col width="70%">';
					reserHTML += '			</colgroup>';
					reserHTML += '			<tbody>';
					reserHTML += '				<tr>';
					reserHTML += '					<th scope="row">예약일</th>';
					reserHTML += '					<td>'+ listHistory[i].resDay +'</td>';
					reserHTML += '				</tr>';
					reserHTML += '				<tr>';
					reserHTML += '					<th scope="row">출발일</th>';
					reserHTML += '					<td>'+ listHistory[i].startDay +'</td>';
					reserHTML += '				</tr>';
					reserHTML += '				<tr>';
					reserHTML += '					<th scope="row">총금액</th>';
					reserHTML += '					<td><b class="purple">'+ comma(listHistory[i].totSaleAmt)+'원</b></td>';
					reserHTML += '				</tr>';
					reserHTML += '				<tr>';
					reserHTML += '					<th scope="row">예약상태</th>';
					reserHTML += '					<td>'+ listHistory[i].statusNm +'</td>';
					/*
					if(listHistory[i].statusRgCd == "RC"){
						reserHTML += '					<td>예약완료</td>';
					}else if(listHistory[i].statusRgCd == "RW"){
						reserHTML += '					<td>예약대기</td>';
					}else if(listHistory[i].statusRgCd == "RN"){
						reserHTML += '					<td>예약불가</td>';
					}else if(listHistory[i].statusRgCd == "CC"){
						reserHTML += '					<td>취소완료</td>';
					}else{
						reserHTML += '					<td></td>';
					}
					*/
					reserHTML += '				</tr>';
					reserHTML += '				<tr>';
					reserHTML += '					<th scope="row">예약번호</th>';
					reserHTML += '					<td>'+ listHistory[i].resCd +'</td>';
					reserHTML += '				</tr>';
					if(listHistory[i].statusCd == "10" || listHistory[i].statusCd == "11" || listHistory[i].statusCd == "H3"){
						reserHTML += '				<tr>';
						reserHTML += '					<th scope="row">결제상태</th>';
						reserHTML += '					<td><a href="#" class="purple2 myt_paybtn" onclick="fn_movePay(\''+ listHistory[i].resCd +'\')">상세/결제</a></td>';
						reserHTML += '				</tr>';
					}
					/*
					reserHTML += '				<tr>';
					reserHTML += '					<th scope="row">결제상태</th>';
					reserHTML += '					<td><a href="#">상세보기</a></td>';
					reserHTML += '				</tr>';
					*/
					reserHTML += '			</tbody>';
					reserHTML += '		</table>';
					reserHTML += '	</div>';
					reserHTML += '</li>';
				}
				
				$("#reservationHistory").html(reserHTML);
			},
			error:function(err){
				console.log(err);
			},
			complete:function(){
				$("#reservationHistory").trigger('create');
			}
		});
	}
	
	function layerOpenMytour(url,op,w,h,ok,ps,pa){
	    $.ajax({
	        type    : 'GET',
	        url     : url,
			data    : pa,
	        success    : function(html){
	            op.after(html);
	            opener = op;
	            var obj = jQuery(".layerPop"),                
	                  wt = w,
	                  ht = h;
	            obj.parent().show();
				jQuery("html, body").css({"overflow":"hidden"});
				if(wt){
					if(ok){
						obj.find(".popTpart").width(wt);
						obj.find(".cntain").addClass("cntain2");
						obj.find(".popCon").height(ht-51).css({"overflow":"scroll","min-height":"auto","overflow-x":"hidden"})
						obj.width(wt).height(ht).css({"margin-top": (obj.height()/2)*-1+"px","margin-left": (obj.width()/2)*-1+"px"});
					}else{
						obj.find(".popFoot").hide();
						obj.find(".cntain").addClass("cntain2");
						obj.find(".popTpart").width(wt);
						obj.width(wt).height(ht).css({"margin-top": (obj.height()/2)*-1+"px","margin-left": (obj.width()/2)*-1+"px"});
					};
				}else{
					if(ok){
						obj.find(".popFoot").addClass("posfd");
						obj.css({"width":"100%","left":"0","top":"0","margin":"0","height":"100%","position":"relative"});
					}else{
						obj.find(".popFoot").hide();
						obj.find(".cntain").addClass("cntain2");
						obj.css({"width":"100%","left":"0","top":"0","margin":"0","height":"100%","position":"relative"});
					};
				};
				if(ps) obj.find(".cntain").addClass("cntain3");
				ratings();
	        }
	    });
	};
	
	/* var fn_question = function(){
		location.href = '/mytour/pop_qna_list.do';
	} */
	
	// 호텔 바우쳐 링크 
	function fn_goHtlVou(rsvNo) {
		moveLink('http://fit.lottejtb.com/fit/htl/htlVoucherPop.do?rsvNo=' + rsvNo, '_system');
	}

	// 렌트카 바우쳐 링크 
	function fn_goRntVou(rsvNo) {
		moveLink('http://fit.lottejtb.com/fit/rnt/rntVoucherPop.do?rsvNo=' + rsvNo, '_system');
	}
	
	// 토파스 항공 예약 상세 
	function fn_rsvAirDetailMove(pnrseqno) {
		moveLink('https://m.air.lottejtb.com/air/b2cmpg/AIR/MBL/AIRMBLMYP0100100020.k1?KSESID=air:b2c:SELK138AX:SELK138AX::00&pnrseqno=' + pnrseqno, '_self');
	}

	$(document).ready(function() {
		cfn_ajax({
			type: "POST",
			async: false,
			url: "<c:url value='/totalExchangeInfo.do' />",
			dataType: "json",
			cache: false,
			noloading:"no",
			success: function(res) {
				var list = res.list;
				
				for(var i = 0; i < list.length; i++){
					if(list[i].currCd == "JPY"){
						exchangeObj[list[i].currCd] = parseFloat(list[i].basRate) / 100;
					}else{
						exchangeObj[list[i].currCd] = list[i].basRate;
					}
				}
			},
			error: function(err){
			}
		});
		
		fn_init();
		fn_initButton();
	});
</script>
</head>
<body>
	<!--content-->
	<div role="main" class="ui-content contentWrap">
		<div class="nav navstitle">MY TOUR</div>
		<div data-role="tabs" class="mytour mgT10">
			<div class="tltBox">
				<p>고객등급</p>
				<span><span id="userName"></span> 고객님의 등급은 <span id="gradeNm"></span>입니다.</span>
			</div>
			<div class="cntBox mycntbox">
				<dl class="one">
					<dt>L.POINT 안내</dt>
					<dd>
						<a href="#" onclick="fn_lpointDtl()">L.POINT 상세조회</a>
					</dd>
				</dl>
				<dl>
					<dt>사용가능한 포인트</dt>
					<dd id="usePoint">0원</dd>
				</dl>
				<dl>
					<dt>잔여 포인트</dt>
					<dd id="remainPoint">0원</dd>
				</dl>
			</div>
			<div data-role="navbar" class="tabsnav">
				<ul>
					<li><a href="#tab1" id="tab1_nav" data-theme="a" data-ajax="false" onclick="fn_tabClick(1)" class="ui-btn-active">예약내역</a></li>
					<li><a href="#tab2" id="tab2_nav" data-theme="a" data-ajax="false" onclick="fn_tabClick(2)">찜 내역</a></li>
					<li><a href="#tab3" id="tab3_nav" data-theme="a" data-ajax="false" onclick="fn_tabClick(3)">참여내역</a></li>
					<li><a href="#tab4" id="tab4_nav" data-theme="a" data-ajax="false">정보관리</a></li>
				</ul>
			</div>
			<!--L.POINT 회원 로그인 Tab-->
			<div id="tab1" class="tabContent mytrctn">
				<div class="contentBox">
					<!--tab1 Start-->
					<div data-role="collapsible" data-iconpos="right" data-collapsed="false">
						<h1 class="ui-nodisc-icon ui-alt-icon">예약내역</h1>
						<div class="listContent" style="width: 100%">
							<!--
							<div class="cntP">
								<form>
									<label for="checkbox-0"><input type="checkbox" name="checkbox-0" id="selectAll">전체</label> 
									<label for="checkbox-1"><input type="checkbox" name="checkbox-1" id="selectGoods" class="subGoods" data-val="">여행상품</label>
									<label for="checkbox-2"><input type="checkbox" name="checkbox-2" id="selectForeign" class="subGoods" data-val="H">해외호텔</label> 
									<label for="checkbox-3"><input type="checkbox" name="checkbox-3" id="selectDomestic" class="subGoods" data-val="BN">국내숙박</label>
								</form>
							</div>
							 -->
							<a href="#" class="btnbox layerOpener" id="datePop" data-url="/mytourDatePop.do" data-width="300" data-height="400"><span id="dateText">기간조회</span></a>
							<!-- <a href="#" class="btnbox"><i class="fa fa-exchange fa-rotate-90"></i>최근 1개월</a>  -->

							<ul data-role="listView" class="pd10 listView" id="reservationHistory">
								
							</ul>
						</div>
						<div class="more mgT10" id="morebtn1">
							<a href="#" onclick="fn_moreData(101)"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
						</div>
						<div class="contentBox pd1EM bdBox bgf6f6f8 lglist1">
							<ul>
								<li>롯데제이티비내 예약내역으로, 고객님의 여행상품 예약내역은 최대 1년간 조회됩니다.(문의사항 02-6313-8000)</li>
								<li>호텔예약건에 대한 마이투어 내 예약확인은 시간이 다소 소요될 수 있으며, 약 10분 내로 확인 가능함을 안내 드립니다.</li>
							</ul>
						</div>
					</div>
					<div data-role="collapsible" data-iconpos="right" class="mgT10">
						<h1 class="ui-nodisc-icon ui-alt-icon">취소내역</h1>
						<div class="listContent" style="width: 100%">
							<ul data-role="listView" class="listView" id="cancelHistory">
							</ul>
						</div>
						<div class="more mgT10" id="morebtn2">
							<a href="#" onclick="fn_moreData(102)"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
						</div>
					</div>
					<div data-role="collapsible" data-iconpos="right" class="mgT10" data-collapsed="false">
						<h1 class="ui-nodisc-icon ui-alt-icon">자유여행 예약내역</h1>
						<div class="listContent" style="width:100%">
							<ul data-role="listView" id="freeReserve" class="free_myt_box">
							</ul>
						</div>
						<div class="more mgT10" id="morebtn5">
							<a href="#" onclick="fn_moreData(103)"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
						</div>
					</div>
					<div data-role="collapsible" data-iconpos="right" class="mgT10">
						<h1 class="ui-nodisc-icon ui-alt-icon">자유여행 취소내역</h1>
						<div class="listContent" style="width:100%">
							<ul data-role="listView" class="free_myt_box" id="freeCancelReserve">
							</ul>
						</div>
						<div class="more mgT10" id="morebtn6">
							<a href="#" onclick="fn_moreData(104)"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
						</div>
					</div>
					<div class="contentBox pd1EM bdBox lglist1">
						<ul>
							<li>자유여행 관련 상담내용은 문의하기를 통해 남겨주시면 최대한 빠른 시간에 답변 드리겠습니다.</li>
						</ul>
					</div>
					<!-- <div class="btn_one qna_tbtn"><button class="purple2" data-role="none" onclick="fn_question();">문의하기</button></div> -->
					<div data-role="collapsible" data-iconpos="right" class="mgT10" data-collapsed="false">
						<h1 class="ui-nodisc-icon ui-alt-icon">항공 예약내역</h1>
						<div class="listContent" style="width:100%">
							<ul data-role="listView" id="topassAirReserve" class="free_myt_box">
							</ul>
						</div>
						<div class="more mgT10" id="morebtn7">
							<a href="#" onclick="fn_moreData(105)"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
						</div>
					</div>
					<div data-role="collapsible" data-iconpos="right" class="mgT10">
						<h1 class="ui-nodisc-icon ui-alt-icon">항공 취소내역</h1>
						<div class="listContent" style="width:100%">
							<ul data-role="listView" class="free_myt_box" id="topassAirCancelReserve">
							</ul>
						</div>
						<div class="more mgT10" id="morebtn8">
							<a href="#" onclick="fn_moreData(106)"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
						</div>
					</div>
					<div data-role="collapsible" data-iconpos="right" class="mgT10">
						<h1 class="ui-nodisc-icon ui-alt-icon">제주 실시간 항공권 내역</h1>
						<div class="listContent" style="width:100%">
							<ul data-role="listView" class="free_myt_box" id="">
							</ul>
						</div>
					    <div class="listContent" style="width:100%">
						<a href="#" class="btnbox layerOpener" id="datePop" onclick="fn_jejuAirUserInfo()" data-width="300" data-height="400"><span id="dateText">제주 항공권 내역 확인하기</span></a>
						</div>
						<div class="contentBox pd1EM bdBox lglist1">
						<ul>
							<li>제주 실시간 항공권의 예약 확인 및 취소에 관한 내용 확인이 가능합니다.(문의사항 02-6313-8422)</li>
						</ul>
						</div>
					</div>
				</div>
				<!--#tab1 End-->
			</div>
			<!--//L.POINT 회원 로그인 Tab-->
			<!--비회원 예약확인 Tab-->
			<div id="tab2" class="tabContent">
				<div class="contentBox">
					<!--tab2 Start-->
					<div data-role="collapsible" data-iconpos="right" data-collapsed="false">
						<h1 class="ui-nodisc-icon ui-alt-icon">찜내역</h1>
						<ul class="selectDel">
							<li><a href="#" class="layerOpener" data-url="/mytourChoicePop.do" data-width="300" data-height="210" data-ok="yes">선택삭제</a></li>
							<li><a href="#" class="layerOpener" data-url="/mytourAllChoicePop.do" data-width="300" data-height="210" data-ok="yes">전체삭제</a></li>
						</ul>
						<div class="listContent" style="width: 100%">
							<ul data-role="listView" class="img" id="choiceGoods">
							</ul>
						</div>
						<div class="more mgT10" id="morebtn">
							<a href="#" onclick="fn_moreData(201)"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
						</div>
					</div>
					<div data-role="collapsible" data-iconpos="right" class="mgT10">
						<h1 class="ui-nodisc-icon ui-alt-icon">최근본상품</h1>
						<div class="listContent" style="width: 100%">
							<ul data-role="listView" class="img" id="recentViewGoods">
							</ul>
						</div>
						<!-- 
						<div class="more mgT10">
							<a href="#" onclick="fn_moreData(202)"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
						</div>
						 -->
					</div>
				</div>
				<!--#tab2 End-->
			</div>
			<!--//비회원 예약확인 Tab-->
			<!--참여내역 Tab-->
			<div id="tab3" class="tabContent">
				<div class="contentBox bdBox">
					<!--tab3 Start-->
					<div data-role="collapsible" data-iconpos="right" data-collapsed="false">
						<h1 class="ui-nodisc-icon ui-alt-icon">이벤트내역</h1>
						<div class="listContent" style="width: 100%">
							<ul data-role="listView" class="list" id="eventHistory">
							</ul>
						</div>
						<div class="more mgT10" id="morebtn3">
							<a href="#" onclick="fn_moreData(301)"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
						</div>
					</div>
					<div data-role="collapsible" data-iconpos="right">
						<h1 class="ui-nodisc-icon ui-alt-icon">상담문의</h1>
						<div class="listContent" style="width: 100%">
							<ul data-role="listView" class="list" id="consultList">
							</ul>
						</div>
						<div class="more mgT10" id="morebtn4">
							<a href="#" onclick="fn_moreData(302)"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
						</div>
					</div>
				</div>
				<!--#tab3 End-->
			</div>
			<!--//참여내역 Tab-->
			<!--정보관리 Tab-->
			<div id="tab4" class="tabContent">
				<div class="contentBox pd1EM bdBox">
					<!--tab4 Start-->
					<ul class="bg_icon_01 bdBox">
						<li class="bg_01"><a href="#" onclick="fn_editUserInfo()">회원정보변경</a></li>
						<li class="bg_02"><a href="#" onclick="fn_editPassword()">비밀번호변경</a></li>
					</ul>
					<div class="more" onclick="fn_delUserInfo()">회원탈퇴</div>
				</div>
				<!--#tab4 End-->
			</div>
			<!--//정보관리 Tab-->
		</div>
		<!--tabs End-->

		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//contentWrap End-->
	<div data-role="popup" id="navPop" class="ui-content" data-overlay-theme="b" data-position-to="window">
		<fieldset data-role="controlgroup">
			<legend>서비스선택</legend><input type="radio" name="radio-choice-1" id="radio-choice-1" value="choice-1" checked="checked"> 
			<label for="radio-choice-1">로그인</label><input type="radio" name="radio-choice-1" id="radio-choice-2" value="choice-2">
			<label for="radio-choice-2">비회원 예약확인</label><input type="radio" name="radio-choice-1" id="radio-choice-3" value="choice-3">
			<label for="radio-choice-3">로그아웃</label><input type="radio" name="radio-choice-1" id="radio-choice-4" value="choice-4">
			<label for="radio-choice-4">설정</label>
		</fieldset>
		<div data-role="footer">
			<a href="#" data-rel="back" class="ui-btn align-c">Close</a>
		</div>
	</div>
	<div data-role="popup" id="popupLogin" data-overlay-theme="b" data-position-to="window">
		<form>
			<div style="padding: 10px 20px;">
				<h3>Please sign in</h3>
				<label for="un" class="ui-hidden-accessible">Username:</label> <input type="text" name="user" id="un" value="" placeholder="username" data-theme="a"> 
				<label for="pw" class="ui-hidden-accessible">Password:</label> <input type="password" name="pass" id="pw" value="" placeholder="password" data-theme="a">
				<button type="submit" class="ui-btn ui-corner-all ui-shadow ui-btn-b ui-btn-icon-left ui-icon-check">Sign in</button>
			</div>
		</form>
	</div>
</body>