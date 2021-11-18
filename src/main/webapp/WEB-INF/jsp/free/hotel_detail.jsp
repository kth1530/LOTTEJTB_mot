

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>

<head>
<script src="/resources/common/js/fit/air_search.js"></script>
<script src="/resources/common/js/fit/hotel_search.js"></script>
<script src="/resources/common/js/fit/paging.js"></script>
<script src="/resources/common/js/fit/common.js"></script>	
<script src="<c:url value='/resources/common/js/fit/promotion.js' />"></script>
<script type="text/javascript" src="https://maps.google.com/maps/api/js?key=AIzaSyDb3QbLpTEk_Pa-32zEyUABiheOLebzQyQ"></script>
<%
	String selAir = (String) request.getAttribute("selAir");
	String selHotel = (String) request.getAttribute("selHotel");
	String selRentcar = (String) request.getAttribute("selRentcar");		
%>
<script type="text/javascript">
	var cmtGooglemapPopJs = cmtGooglemapPopJs || new Object();
	
	var lat = '';
	var longi = '';
	var h_krName = '';
	var h_enName = '';
	var hotelId = '';
	var hotelIdTemp = '';  //호텔 패스용 id
	var suplrCd = '';
	var suplrCdTemp = '';
	var countryCd = '';
	var cityCd ='';
	var exchangeRate = '';
	var locShortDesc='';
	var googlemap_pop;
	var tmp_id;
	var latlng = '';
	var map;
	
	//구글맵 팝업
	var markerGroup = [];	//마커그룹
	var markerChecker = [];
	var addinfowindow;
	var g_radius = 50000;
	
	var pageSize = 10;
	var hotelDetailCnt = 0; //상세요금조회 list갯수
	var chCnt = 0;  //checkbox 카운터
	
	var fitMix = 'XXX';
	var hashData;
		
	// 초기화
	var fn_init = function() {
	
		if(nullToBlank(sessionStorage.hotelSelList) != '' || sessionStorage.hotelSelList != '[]') {
			var detailData = JSON.parse(sessionStorage.hotelSelList);
			
			lat = detailData.lat;
			longi = detailData.lon;
			h_krName = detailData.h_krName;
			h_enName = detailData.h_enName;
			hotelId = detailData.hotelId;
			suplrCd = detailData.suplrCd;
			countryCd = detailData.countryCd;
			cityCd = detailData.cityCd;
			exchangeRate = detailData.exchangeRate;
			locShortDesc = detailData.locShortDesc;
				
		}
		$('#htl_krname').text(h_krName);
		$('#htl_enname').text(h_enName);
		
		if (suplrCd == 'EAN'){
			fn_getHtlInfo(hotelId,suplrCd);
		} else {
			hotelIdTemp = hotelId;
			suplrCdTemp = suplrCd;
			fn_hpIdToEanIdChk(hotelIdTemp);
		}
	};
	
	//더보기
	//$('#morebtn').on('click', function() {
	function fn_morebtn() {	
		
		var s_cnt = $('#dtPaysearch').find('ul[id="list"]').size() + 1;
		var e_cnt = (s_cnt + Number(pageSize))-1;	
		//console.log("<<<s_cnt1=" + s_cnt + "e_cnt=" + e_cnt);
		
		if(s_cnt > hotelDetailCnt) {
			alert("더이상 등록된 상세요금정보가 없습니다.");
			return false;
		}
	}
	//});
	
	//선택담기
	$('#basketCnt').on('click', function() {
		/*
		console.log("<<basketCnt~");
		fn_chkselCount();
		if(chCnt==0) {
			alert("장바구니에 담을 상품을 체크해주세요.");
			return false;
		}
		*/
		
	});

	$('#selectPut').on('click', function() {
		//console.log("<<selectPut~");
		fn_chkselCount();
		if(chCnt==0) {
			alert("장바구니에 담을 상품을 체크해주세요.");
			return false;
		}	
	});
	
	
	var initMap = function() {
	
		googlemap_pop = $('div[ft-att="googlemap_pop"]');
		googlemap_pop.find('li[id="map_guide"]').on('click','a', cmtGooglemapPopJs.showAtt);
		
		var zoomLevel = 17;  //확대
		var markerMaxWidth = 300; //마커를 클릭했을때 나타나는 말풍선의 최대크기
		
		if(lat == null || longi == null) {
			alert("위치정보가 없습니다.");
			return;
		}

		latlng = lat + ',' + longi;
		
		var myLatlng = new google.maps.LatLng(lat, longi);
		
		//console.log("lat=" + lat + "longi=" + longi + "hname=" + hname);
		
		var mapOptions = {
			center : myLatlng,
			zoom : zoomLevel,
			mapTypeId:google.maps.MapTypeId.ROADMAP
		
		};
		
		map = new google.maps.Map(document.getElementById('map_view'), mapOptions);
		
		var marker = new google.maps.Marker({
		 	 position: myLatlng,
		 	 map : map,
		 	 title: h_krName,
		 	 draggable:true
		});
		marker.setMap(map);
		
		var infowindow = new google.maps.InfoWindow({
			content:h_krName,
			maxWidth:markerMaxWidth
		}); 
		
	 	google.maps.event.addListener(marker, 'click', function() {
			infowindow.open(map,marker);
			
		}); 
	 	
	 	//하단 장바구니 안보이게 처리
	 	$('#hotel_detail_nodata_div').hide();
	    $('#bottom_basket_rect').hide();
	    
	    if(nullToBlank(htlDetailInfo) != "") {
			var hotelContent = htlDetailInfo.areaInfo;
			var trafficeInfo = htlDetailInfo.trafficInfo;
			if(nullToBlank(hotelContent) !='') {
				hotelContent = hotelContent.replaceAll("&lt;" , "<");
				hotelContent = hotelContent.replaceAll("&gt;" , ">");
			}
			
			if(nullToBlank(trafficeInfo) != '') {
				var trafficArr = trafficeInfo.split("<br>");
				var vHtml= '';
				if(nullToBlank(trafficArr) != '') {
					for(var i=0; i < trafficArr.length; i++) {
						
						if(trafficArr[i] == " " || trafficArr[i] == "") continue;	
						
						if(trafficArr[i].indexOf('*') > -1) {
								vHtml += "<li>" + trafficArr[i] + "</li>";
						} else {
								vHtml += "<li>*" + trafficArr[i] + "</li>";
						}
						
					}
					$('#trafficeInfo').html(vHtml);
				} else
					$('#trafficeInfo').html("<li> 교통 정보가 없습니다.</li>");
				
			} else {
				$('#trafficeInfo').html("<li> 교통 정보가 없습니다.</li>");
			}
			
			if(nullToBlank(trafficeInfo) != '') {
				if(hotelContent.indexOf('*') > -1)
					$('#locationInfo').html("<li>" + hotelContent +"</li>");
				else
					$('#locationInfo').html("<li>*" + hotelContent +"</li>");
			} else {
				$('#locationInfo').html("<li> 주변 관광정보가 없습니다.</li>");
			}
		}
	};
	
	
	cmtGooglemapPopJs = {
			init : function(){
			},
			
			showAtt : function(){	// 주변정보 마킹
				
				if($(this).hasClass('current')){
					// 이미 노출되어 있는 경우 마커삭제
					cmtGooglemapPopJs.removeAtt(this);
				} else {
					var selClass = $(this).attr('class');
					
				 	var arr = selClass.split("ui-link");
				 	selClass = trim(arr[0]);
					
					$(this).addClass('current');
					$(this).addClass('on');

					if(markerChecker.indexOf(selClass) == -1){
						markerChecker.push(selClass);
						markerGroup.push([]);
					}
					
					var markerNo = markerChecker.indexOf(selClass);
					
					if(selClass == 'hotel'){
						var mkGrp = markerGroup[markerNo];
						//var hotelData = g_hotel_map_data;
									
						if(nullToBlank(sessionStorage.hotelInfoMapData) != '' && sessionStorage.hotelInfoMapData != '[]') {
							var hotelData = JSON.parse(sessionStorage.hotelInfoMapData);
						
							for(var h_idx=0; h_idx< hotelData.length; h_idx++){
								if(latlng != hotelData[h_idx].lat + ',' + hotelData[h_idx].lon){
									
									 var addmarker = new google.maps.Marker({
										position	: new google.maps.LatLng(hotelData[h_idx].lat, hotelData[h_idx].lon),
										map         : map,
										draggable	: false,
										title		: hotelData[h_idx].hotelNmKr,
										icon		: "/resources/common/images/icons-png/flag_hotel.png"
									});
									 
									 mkGrp.push(addmarker);
									
									google.maps.event.addListener(addmarker, 'click', function() {
										var tmpwindow = addinfowindow; 
										addinfowindow = new google.maps.InfoWindow({
											content: hotelData[h_idx].hotelNmKr,
											maxWidth: 300
										});	
										addinfowindow.open(map,addmarker);
										tmpwindow.setMap(null);
									});
									
								}
								
							}
							
						}
					} else {
						//test
						var latlngarr = latlng.split(',');
						
						var l_searchTy = '';
						
						if(selClass == 'place'){
							//정의 필요  - 미완료
						}else if(selClass == 'shopping'){
							l_searchTy = 'shopping_mall|department_store';
						}else if(selClass == 'trafic'){
							l_searchTy = 'subway_station|train_station|bus_station';
						}else if(selClass == 'exhibition'){
							l_searchTy = 'museum|art_gallery';
						}
						
						if($('#radious').length > 0){
							g_radius = $('#radious').val();
						}
						
						var reqData = {
							latitude	: latlngarr[0],
							longitude	: latlngarr[1],
							types		: l_searchTy,
							radius		: 1000
						};
						
						cmtGooglemapPopJs.markerNo = markerNo;
						cmtGooglemapPopJs.selClass = selClass;
						
						gfn_callAjax ('/fit/htl/radarsearchAjax.do', reqData, 'cmtGooglemapPopJs.drawAtt', true);
					}
				}
			}, 
			markerNo : 0,
			selClass: '',
			drawAtt : function(_data){
				//console.log(_data);
				
				var radarList = _data.radarList.results;
				
				var mkGrp = markerGroup[cmtGooglemapPopJs.markerNo];
				
				for(var r_idx=0; r_idx<radarList.length; r_idx++){
					var addmarker = new google.maps.Marker({
						"map"		: map,
						"draggable"	: true,
						"place"		: {
										placeId: radarList[r_idx].place_id,
								        location: radarList[r_idx].geometry.location
									},
						//"title"		: "test",
						"icon"		: "/resources/common/images/icons-png/flag_" + cmtGooglemapPopJs.selClass + ".png"
					});

					mkGrp.push(addmarker);
					//addmarker.setMap(map);
										
					google.maps.event.addListener(addmarker, 'click', function() {
						//radarDetailsearchAjax.do
						var reqData = {
							"placeid" : this.place.placeId
						};
						
						cmtGooglemapPopJs.clMarker = this;
						
						gfn_callAjax ('/fit/htl/radarDetailsearchAjax.do', reqData, 'cmtGooglemapPopJs.detailInfo', true);
					});
				}
			},
			clMarker : Object,
			detailInfo : function(_data){
				var tmpwindow = addinfowindow;
				var content = '<a class="infoWindow">' + _data.radarData.result.name + '</a>';
				addinfowindow = new google.maps.InfoWindow({
					content: content,
					maxWidth: 300
				});	
				addinfowindow.open(map,cmtGooglemapPopJs.clMarker);
				
				$('.infoWindow').on('click', function() {
					window.open(_data.radarData.result.url, '_blank'); ;
				});
				
				tmpwindow.setMap(null);
				//console.log(_data);
			},
			removeAtt : function(_obj){
				$(_obj).removeClass('current');
				$(_obj).removeClass('on');
				
				var selClass = $(_obj).attr('class');
				var arr = selClass.split("ui-link");
			 	selClass = trim(arr[0]);
				
				var markerNo = markerChecker.indexOf(selClass);
				var mkGrp = markerGroup[markerNo];
				
				if(nullToBlank(mkGrp) != '' && mkGrp.length > 0) {
					for(var r_idx=0; r_idx<mkGrp.length; r_idx++){
						mkGrp[r_idx].setMap(null);
					}
				}
			}
			
			
	}; 
	
	
	function trim(stringToTrim) {
	    return stringToTrim.replace(/^\s+|\s+$/g,"");
	}
	
	
	//객실 룸리스트 입력
	var fn_getRoomList = function() {
		
		//console.log(">>>>fn_getRoomList<<<<");
	
		if(nullToBlank(sessionStorage.hotelViewData) != '' || (sessionStorage.hotelViewData) != '[]')
		{				
			var roomGroup = [];
			var viewData = JSON.parse(sessionStorage.hotelViewData);
			
			for(var i=0; i < viewData.roomCont.length; i++) {
				var roomInfo = {
					'roomType' : viewData.roomCont[i].roomTy,   //객실타입
					'numOfAdt' : viewData.roomCont[i].numOfAdt, //성인수
					'numOfChd' : viewData.roomCont[i].numOfChd,  //아동수
					'ageOfChd' : viewData.roomCont[i].ageOfChd   //아동나이
				};
				roomGroup.push(roomInfo);
			}		
			
			fitMix =   ($("#selAir").val() == 'Y' ? 'A' : 'X')
						 + ($("#selHotel").val() == 'Y' ? 'H' : 'X')
						 + ($("#selRentcar").val() == 'Y' ? 'C' : 'X');
			
					
			var setData = {
				'fitMix'  : fitMix,
				'hotelId' : hotelId, //호텔 ID
				'suplrCd' : suplrCd, //공급사코드
				'checkInDt' : viewData.checkInDate, //체크인 날짜
				'checkOutDt' : viewData.checkOutDate, //체크아웃날짜
				'rateCode'  : "",                     //요금코드   20150516 20150516추가
				'roomTypeCode' : "", 				 //룸타입코드 soldout때문에 20150516추가
				'isDomestic' : viewData.isDomestic,
				'roomCnt' 	 : viewData.roomCnt, 
				'roomGroup' :  roomGroup
				//'promInfo' : promotion
				
			};
			gfn_callAjax('/fit/htl/roomListAjax.do', setData, 'fn_drawDetailPaySearch', false);
		}
	}
	
	var eanSelIdxTemp = 0;
	//호텔 선택시 매진 객실이 있는지 체크
	var fn_SoldOutRoomChk = function(selIdx) {
		
		//console.log(">>>>fn_SoldOutRoom = " + selIdx);
		
		if(nullToBlank(sessionStorage.hotelViewData) != '' || (sessionStorage.hotelViewData) != '[]')
		{				
			var roomGroup = [];
			var viewData = JSON.parse(sessionStorage.hotelViewData);
			
			
			//호텔 단품인 경우 처리 멀티 예약 불가 팝업--start
		 	if(nullToBlank(sessionStorage.hotelBasketData) != '' && sessionStorage.hotelBasketData != '[]') {
				g_hotel_basket_data = JSON.parse(sessionStorage.hotelBasketData);
				
				if(nullToBlank(g_hotel_basket_data) != '' 
					&& (viewData.fitMix == 'XHX') && (g_hotel_basket_data.length > 0)) {
					/* alert("호텔 단품인경우는 멀티로 예약 불가합니다.");
					$("#selectPut").click();
					return false; */
					sessionStorage.hotelSelData = JSON.stringify([]);
					sessionStorage.hotelBasketData = JSON.stringify([]);
					g_hotel_basket_data = [];
					
				} 
			} 
			//호텔 단품인 경우 처리 멀티 예약 불가 팝업--end
			for(var i=0; i < viewData.roomCont.length; i++) {
				var roomInfo = {
					'roomType' : viewData.roomCont[i].roomTy,   //객실타입
					'numOfAdt' : viewData.roomCont[i].numOfAdt, //성인수
					'numOfChd' : viewData.roomCont[i].numOfChd,  //아동수
					'ageOfChd' : viewData.roomCont[i].ageOfChd   //아동나이
				};
				roomGroup.push(roomInfo);
			}		
			
			fitMix =   ($("#selAir").val() == 'Y' ? 'A' : 'X')
						 + ($("#selHotel").val() == 'Y' ? 'H' : 'X')
						 + ($("#selRentcar").val() == 'Y' ? 'C' : 'X');
			
			/* 
			if(nullToBlank(sessionStorage.hotelSelList) != '' || sessionStorage.hotelSelList != '[]') {
				var detailData = JSON.parse(sessionStorage.hotelSelList);
				
				
				var promotion = {
						'promId' : 	detailData.promInfo[0].promId,
						'concMix' : detailData.promInfo[0].concMix,
						'carrierCd' : detailData.promInfo[0].carrierCd,
						'cabin' : detailData.promInfo[0].cabin,
						'adtTyGb' : detailData.promInfo[0].adtTyGb,
						'adtDiviGb': detailData.promInfo[0].adtDiviGb, 
						'gdsTyGb' : detailData.promInfo[0].gdsTyGb,
						'suplrId' : detailData.promInfo[0].suplrId,
						'htlNationCd' : detailData.promInfo[0].htlNationCd,
						'htlCtCd'  :detailData.promInfo[0].htlCtCd,
						'htlCd' : detailData.promInfo[0].htlCd,
						'tyGb' : detailData.promInfo[0].tyGb,
						'diviGb'  :detailData.promInfo[0].diviGb,
						'amt' : detailData.promInfo[0].amt,
						'amount' : detailData.promInfo[0].amount,
						'promRate' : detailData.promInfo[0].promRate,
						'fitRsvNo' : detailData.promInfo[0].fitRsvNo,
						'userId' : detailData.promInfo[0].userId,
						'aplPromTotal' : detailData.promInfo[0].aplPromTotal,
						'promTotal' : detailData.promInfo[0].promTotal,
						'promTxt' : detailData.promInfo[0].promTxt,
						'checkinDt' : detailData.promInfo[0].checkinDt,
						'coalCardGb' : detailData.promInfo[0].coalCardGb,
						'coalCardNm' : detailData.promInfo[0].coalCardNm
					}; 
			}
 */			
			//호텔 선택시 매진 객실이 있는지 체크
			var roomData = g_hotel_room_data.roomInfos[selIdx];
			var rateCode = "";
			var roomTypeCd = "";
			if(nullToBlank(roomData) != '') {
				rateCode = roomData.rateCode;
				roomTypeCd = roomData.roomTypeCd;
			}
			
			var setData = {
				'fitMix'  : fitMix,
				'hotelId' : roomData.hotelId, //호텔 ID
				'suplrCd' : roomData.suplrCd, //공급사코드
				'checkInDt' : viewData.checkInDate, //체크인 날짜
				'checkOutDt' : viewData.checkOutDate, //체크아웃날짜
				'rateCode'  : rateCode,                     //요금코드   20150516 20150516추가
				'roomTypeCode' : roomTypeCd, 				 //룸타입코드 soldout때문에 20150516추가
				'roomGroup' :  roomGroup
				//'promInfo' : promotion
				
			};
			eanSelIdxTemp = selIdx;
			
			gfn_callAjax('/fit/htl/roomListAjax.do', setData, 'fn_drawSoldOut', false);
			//console.log(setData);
		}
	}
	
	var selTemp = 0;
	//상세페이지 취소규정 api 연동
	var fn_CancelPolicyChk = function(selIdx) {
		
		console.log(">>>>fn_CancelPolicy<<<< = " + selIdx);
		
		if(nullToBlank(sessionStorage.hotelViewData) != '' || (sessionStorage.hotelViewData) != '[]')
		{		
			var viewData = JSON.parse(sessionStorage.hotelViewData);
			
			//호텔 단품인 경우 처리 멀티 예약 불가 팝업--start
			if(nullToBlank(sessionStorage.hotelBasketData) != '' && sessionStorage.hotelBasketData != '[]') {
				g_hotel_basket_data = JSON.parse(sessionStorage.hotelBasketData);
				
				if(nullToBlank(g_hotel_basket_data) != '' 
					&& (viewData.fitMix == 'XHX') && (g_hotel_basket_data.length > 0)) {
					/* alert("호텔 단품인경우는 멀티로 예약 불가합니다.");
					$("#selectPut").click();
					return false; */
					sessionStorage.hotelSelData = JSON.stringify([]);
					sessionStorage.hotelBasketData = JSON.stringify([]);
					g_hotel_basket_data = [];
					
				} 
			}
						
			fitMix =   ($("#selAir").val() == 'Y' ? 'A' : 'X')
						 + ($("#selHotel").val() == 'Y' ? 'H' : 'X')
						 + ($("#selRentcar").val() == 'Y' ? 'C' : 'X');
			
			var suplrCd = g_hotel_room_data.roomInfos[selIdx].suplrCd;
			var hotelId = g_hotel_room_data.roomInfos[selIdx].hotelId;
			var rateKey = g_hotel_room_data.roomInfos[selIdx].rateInfos[0].rateKey;
			var roomId = g_hotel_room_data.roomInfos[selIdx].roomTypeCd;
			var roomTy = viewData.roomCont[0].roomTy;
			var numOfChd = viewData.roomCont[0].numOfChd;
			var ageOfChd = viewData.roomCont[0].ageOfChd;
			var checkInDt = viewData.checkInDate;
			var checkOutDt = viewData.checkOutDate;
			
			var setData = {
				'fitMix' : fitMix,
				'suplrCd' : suplrCd,
				'rateKey' : rateKey,
				'checkInDt' : checkInDt ,
				'checkOutDt' : checkOutDt,
				'hotelId' : hotelId,
				'roomId'  : roomId,
				'numOfChd' : parseInt(numOfChd),
				'ageOfChd' : ageOfChd,
				'roomTy' : roomTy
			};
			console.log("======fn_CancelPolicy start=====");
			console.log(setData);
			console.log("======fn_CancelPolicy end ======");
			
			selTemp = selIdx;
			
			gfn_callAjax('/fit/htl/cancelPolicy.do', setData, 'fn_drawCancelPolicyChk', false);
		}
		
	}
	
	var fn_drawCancelPolicyChk = function(data) {
		//engine에서 전달되는 값을 그대로 출력		
/* 		var cancelData = data.hotelCancelPolicy;
		var cancelDt = "16:00";
	
		g_hotel_room_data.roomInfos[selTemp].rateInfos[0].cancelJtbDl = cancelData.cancelDl +  " " + cancelDt;
		g_hotel_room_data.roomInfos[selTemp].rateInfos[0].cancellationPolicy = cancelData.cancelDesc; */
		
		//2017.06.18 취소규정 로직 적용 홈페이지 참조
		
		var cancelDl = data.hotelCancelPolicy.cancelDl;
		var jtbCancelDl = data.hotelCancelPolicy.cancelJtbDl;
		
	 	/* var jtbCancelDl = cancelDl;
		
		var i_now = new Date();
		
		var i_yyyy	= i_now.getFullYear();
		var i_mm	= i_now.getMonth()+1;
		i_mm = i_mm < 10 ? '0'+(i_mm+'') : i_mm; 
		var i_dd	= i_now.getDate();
		i_dd = i_dd < 10 ? '0'+(i_dd+'') : i_dd;
		var i_hh24	= i_now.getHours();
		i_hh24 = i_hh24 < 10 ? '0'+(i_hh24+'') : i_hh24;
		var i_mi	= i_now.getMinutes();
		i_mi = i_mi < 10 ? '0'+(i_mi+'') : i_mi;
		
		var i_nowDt = i_yyyy + '' + i_mm + i_dd;
		var i_nowHm = i_hh24 + '' + i_mi;
		var calcResult = calcInterval2(i_nowDt, i_nowHm, jtbCancelDl, '1600').split(',');
		
		for(var ci=0; ci<calcResult.length; ci++){
			if(calcResult[ci] != 0 ){
				if(calcResult[ci] < 0){
					jtbCancelDl = '환불불가';
					break;
				}
			}
		}
		
		if(jtbCancelDl != '환불불가'){
			jtbCancelDl = jtbCancelDl + ' 16:00';
		}
		 */
		g_hotel_room_data.roomInfos[selTemp].rateInfos[0].cancelJtbDl = jtbCancelDl;
		g_hotel_room_data.roomInfos[selTemp].rateInfos[0].cancelDL = cancelDl;
		g_hotel_room_data.roomInfos[selTemp].rateInfos[0].cancelTL = '16:00';
		
		var cancelDesc = data.hotelCancelPolicy.cancelDesc;
		if(cancelDesc == ''){
			cancelDesc = cancelDl;
		}
		
		g_hotel_room_data.roomInfos[selTemp].rateInfos[0].cancellationPolicy = cancelDesc; 
		
				
		fn_selHotelCnt(selTemp);
	}
	
	
	//룸이미지 draw
	var fn_roomImageDraw = function() {	
	
		 if(htlDetailInfo.propertyImages != null) {
	 	 	var propertyImagesSize = htlDetailInfo.propertyImages.length;
		
			var roomImage = ''; 
		 	for(var k=0; k < propertyImagesSize; k++) {
		 		
		 		roomImage = roomImage + "<div class='swiper-slide' style='background-image:url(" + htlDetailInfo.propertyImages[k].url + ")'>"
		 		//roomImage = roomImage + " 		<img src='" + htlDetailInfo.propertyImages[k].url + "' alt='' />"
		 		roomImage = roomImage + "</div>" 
		 		
		 		$('#htlRoomImg').html(roomImage);
		 		
		 	}
		 	//롤링스크립트
		 	fn_roomImagejs();
		 }
		 
		//호텔 룸리스트
		 fn_getRoomList(); 
	}
	
	var fn_drawSoldOut = function(_data) {
		//룸리스트
		var li_data = _data.roomAvail;
		var soldOutMsg = _data.message;
		
		//console.log(li_data);
				
		if(soldOutMsg.indexOf("다른 호텔을 선택해 주십시오") > -1) {
			setAlert("예약 가능한 객실이 없습니다. 다른 객실을 선택해 주십시요.");
		    return false;
		} else {
			soldOutMsg = '';
		}
		
					
		if(nullToBlank(li_data) != '') {
			fn_eanSelHotelCnt(li_data);
		}
	}
		
	
	//상세요금조회 리스트 화면
	var fn_drawDetailPaySearch = function(_data) {
		
		//룸리스트
		var li_data = _data.roomAvail;
		var soldOutMsg = _data.message;
		var roomCnt = '';
		var day = '';
		var countryCode = '';
		var cityCode = ''
		
		if(nullToBlank(sessionStorage.hotelViewData) != '' && sessionStorage.hotelViewData != '[]') {
			var data = JSON.parse(sessionStorage.hotelViewData);
			roomCnt = data.roomCnt;
			countryCode = data.countryCode;
			cityCode = data.cityCode;
			var dayArr = data.day.split("박");
			if(nullToBlank(dayArr) !='' && dayArr.length > 0 )
				day = dayArr[0];
		}
		
			
		if(nullToBlank(li_data) != '' && li_data.roomInfos.length > 0) {
			//for(var i = 0; i < li_data.length; i++) {
				
				$('#dtPaysearch').show();
				$('#hotel_detail_nodata_div').hide();
				
				var roomData = li_data;
				g_hotel_room_data = li_data;
				
				var total = 0;
				
				for(var j=0; j < li_data.roomInfos.length; j++) {
					//취소 정책 문구
					var cancelPolicy ='';
					var roomTypeCd = roomData.roomInfos[j].roomTypeCd;
					
					var roomTypeDesc = roomData.roomInfos[j].roomTypeDesc;
					
					if(nullToBlank(roomTypeDesc) == '') roomTypeDesc ='';
					
					var cancelJtbDl = roomData.roomInfos[j].rateInfos[0].cancelJtbDl;  //취소마감일
					var totalRateT = 0;
					
										
					//promotion---start--------------------------------------------------------------
					var promotionArr = applyHtlProm(roomData.roomInfos[j].suplrCd,
													countryCode,
													cityCode,
													roomData.roomInfos[j].hotelId);
					
					var promTotal = 0;
					var promTxt = '';
					var promId = '';
					var coalCarGb= '';
				 	var promotionData = {};
				 	
					
					if(promotionArr != null && promotionArr.length > 0) {
						
						for(var i=0; i < promotionArr.length; i++) {
							 var promData = promotionArr[i];
							 var diviGb = promData.diviGb;
							 var tyGb= promData.tyGb;
							 var amt = parseInt(promData.amt);
							 total = Math.ceil(parseFloat(roomData.roomInfos[j].rateInfos[0].jtbTotal));
							 var calcPromTotal = 0;
							 if(diviGb =='A') {
									if(tyGb == 'U'){ 
										calcPromTotal = total + amt;
	        						} else if(tyGb =='D') {
	        							calcPromTotal = total - amt;
        								promTxt = comma(amt) + "원 할인";
        							}
									promTotal = calcPromTotal;
									//promTxt = promData.promNm;
									promId = promData.promId;
									coalCarGb = promData.htlCoalCardGb;
								 
							  } else if(diviGb == 'R') {
								   
							   	   if(tyGb =='U'){
									   calcPromTotal = total + Math.floor( total * promData.amt / 100);
       							   }  else if(tyGb == 'D') {
       								   calcPromTotal = total - Math.floor( total * promData.amt / 100);
//        								   promTxt = "프로모션:(" + promData.amt + "% 할인)"//;promData.promNm;	
       								   promTxt = promData.promNm + "(" + promData.amt + "% 할인)";//;promData.promNm;	
           						   }
							       promTotal = calcPromTotal;
								   promId = promData.promId;
								   coalCardGb = promData.htlCoalCardGb;
							
							  }
										
						}
														
					}
					
					promotionData.promId = promId;
				 	promotionData.aplPromTotal = promTotal;
				 	promotionData.coalCardGb = coalCarGb;
				 	promotionData.promTxt = promTxt;
				
					
					roomData.roomInfos[j].rateInfos[0].promInfo = promotionData;
					g_hotel_room_data.roomInfos[j].rateInfos[0].promInfo = promotionData;
					//promotion--end---------------------------------------------------------------------------
					
									
				/* 	if(roomData.roomInfos[j].suplrCd == 'WHC') { //호텔패스인 경우만 호텔패스 환율적용해야 한다.
						exchangeRate = roomData.roomInfos[j].rateInfos[0].whcExchangeRate; //호텔패스용인 경우 환률정보있음.
						whcExchangeRate = exchangeRate;
					} else {
						exchangeRate = g_hotel_room_data.exchangeRate;
						whcExchangeRate = roomData.roomInfos[j].rateInfos[0].whcExchangeRate;
					} */
					
			
					var promInfoData = roomData.roomInfos[j].rateInfos[0].promInfo;
					
					if(promInfoData != null && (nullToBlank(promInfoData.aplPromTotal) != '') && roomData.roomInfos[j].custChk != '그룹직원') {
						if(promInfoData.aplPromTotal > 0) {	
							//프로모션 적용가
							totalRateT = Math.ceil(parseFloat(promInfoData.aplPromTotal));
							promTxt = promInfoData.promTxt;
						} else
							totalRateT = Math.ceil(parseFloat(roomData.roomInfos[j].rateInfos[0].jtbTotal));
					} else {
						if(roomData.roomInfos[j].rateInfos[0].jtbTotal != '')
							totalRateT = Math.ceil(parseFloat(roomData.roomInfos[j].rateInfos[0].jtbTotal));
					}
						
				
					//조식 포함 여부
					var roomIsBreakfast = roomData.roomInfos[j].isBreakFast;
					var jtbCancelDt = '';
					var jtbCancelTm = '16:00';
					if(roomIsBreakfast == 'Y')
						roomIsBreakfast = '조식 포함';
					else
						roomIsBreakfast = '조식 불포함';
					
				   	if(cancelJtbDl == '환불불가')  {  
						jtbCancelDt = '환불불가';
					}
					else {
						jtbCancelDt = cancelJtbDl ;//+ " " + roomData.roomInfos[j].rateInfos[0].cancelTL;
					}  
				   	
					vHtml = '';	
					var dataUrl = '';					
					/* if(roomData.roomInfos[j].rateInfos[0].cancellationPolicy != "" && roomData.roomInfos[j].suplrCd != 'WHC')  
						 dataUrl = "/pop/pop_cancel1.do?cancelPolicy=" + jtbCancelDt + "&selIdx=" + j;
					else  //그외 경우는 취소정책 api를 호출한다
						 dataUrl = "/pop/pop_cancel1.do?cancelPolicy=" + "" + "&selIdx=" + j; */
						 
					
					if(roomData.roomInfos[j].suplrCd == 'WHC' || roomData.roomInfos[j].suplrCd == 'GTA')  
						dataUrl = "/pop/pop_cancel1.do?cancelPolicy=" + "" + "&selIdx=" + j;
					else 
						dataUrl = "/pop/pop_cancel1.do?cancelPolicy=" + jtbCancelDt + "&selIdx=" + j;	 	 
						 
						 
					if(roomData.roomInfos[j].suplrCd == 'DOTW'){
						vHtml = vHtml +	"<ul id='list' style='display:none;'>									   		"
					} else {
						vHtml = vHtml +	"<ul id='list'>									   		"	
					}
					vHtml = vHtml + "	<li><span class='red_gbox'>즉시 확정</span> "
					/* if(roomData.roomInfos[j].suplrCd == 'EAN' && jtbCancelDt =='환불불가') {
						vHtml = vHtml + "	<span style='font-weight: 600; color: #488BF8;'>("+jtbCancelDt+")</span>   			"
					}
					 */
									 
					vHtml = vHtml + "   </li>  												"	
					vHtml = vHtml + "   <li>  												"
					vHtml = vHtml + "       <p class='ht_show hr_radiobox'>						"
					/* var suplrCdT = 'E';
					if(roomData.roomInfos[j].suplrCd == 'EAN') suplrCdT = "(E)";
					else if(roomData.roomInfos[j].suplrCd == 'WHC') suplrCdT = "(H)";
					else if(roomData.roomInfos[j].suplrCd == 'GTA') suplrCdT = "(G)";
					else if(roomData.roomInfos[j].suplrCd == 'HNJ') suplrCdT = "(N)";
					else if(roomData.roomInfos[j].suplrCd == 'DOTW') suplrCdT = "(D)";
					else if(roomData.roomInfos[j].suplrCd == 'JTB') suplrCdT = "(J)"; */
					if(roomData.roomInfos[j].suplrCd == 'EAN')
						vHtml = vHtml + "			<span class='radioboxs' onclick='fn_SoldOutRoomChk(" + j + ")'><input type='radio' name='radio' id='chk_cusm"+ j +"' class='hotel_radio_btn' data-index='"+ j +"' data-role='none' /></span> <label for='chk_cusm"+ j +"'><em>"  + roomTypeDesc + "</em></label>"
					else if (roomData.roomInfos[j].suplrCd == 'WHC' || roomData.roomInfos[j].suplrCd == 'GTA') {
						vHtml = vHtml + "			<span class='radioboxs' onclick='fn_CancelPolicyChk(" + j + ")'><input type='radio' name='radio' id='chk_cusm"+ j +"' class='hotel_radio_btn' data-index='"+ j +"' data-role='none' /></span> <label for='chk_cusm"+ j +"'><em>" + roomTypeDesc + "</em></label>"
					} else {
						vHtml = vHtml + "			<span class='radioboxs' onclick='fn_selHotelCnt(" + j + ")'><input type='radio' name='radio' id='chk_cusm"+ j +"' class='hotel_radio_btn' data-index='"+ j +"' data-role='none' /></span> <label for='chk_cusm"+ j +"'><em>" + roomTypeDesc + "</em></label>"
					}
					vHtml = vHtml + "		</p>																															     "
					vHtml = vHtml + "       <div class='ht_dt_btn' id='ht_dt_btn'>"	
					vHtml = vHtml + "         <button type='button'  id='cancelPolicy" + j +"' data-role='none' class='layerOpener' data-url='"+ dataUrl + "'  data-index='"+ j +"' style='cursor='hand';' data-ok='yes'>취소규정</button>"
					vHtml = vHtml + "		</div>																																 "
					vHtml = vHtml + "   </li>																																	 "
					vHtml = vHtml + "	<li></li>																			 "
					vHtml = vHtml + "	<li><span>" + roomIsBreakfast + "</span>																												 "
					vHtml = vHtml + "		<p style='position:absolute;right:10px;top:2px;'>		 "
					//[JEH] 프로모션 적용 전 금액 보여주도록 수정 - 20190227
					if(nullToBlank(promTxt) != '' && roomData.roomInfos[j].custChk != '그룹직원') {
						vHtml = vHtml + "			<strike></strike><span style='font-size:14px; color:#333;text-decoration-line: line-through;'>" + comma(total) +"원</span>&nbsp;&nbsp;→&nbsp;<em>" + comma(totalRateT) +"</em>원				 "
					}else if (roomData.roomInfos[j].custChk == '그룹직원'){
						// 임직원 마크업 추가 2019.04.16 bum
						vHtml = vHtml + "			<strike></strike><span style='font-size:14px; color:#333;text-decoration-line: line-through;'>" + comma(Math.ceil(parseFloat(roomData.roomInfos[j].rateInfos[0].bfTotal))) +"원</span>&nbsp;&nbsp;→&nbsp;<em>" + comma(totalRateT) +"</em>원				 "
					} else {
						vHtml = vHtml + "			<strike></strike><em>" + comma(totalRateT) +"</em>원			 "
					}
					vHtml = vHtml + "		</p>"	
					vHtml = vHtml + "	</li>"	
					//[JEH] 프로모션 내용 표기 수정 - 20190227
					if(nullToBlank(promTxt) != '' && roomData.roomInfos[j].custChk != '그룹직원') {
						vHtml = vHtml + "				<li  style='font-size:.8em;padding: 5px 0 5px 0;height: 20px;float: right;width: 100%;line-height: 20px;'>"// + promData.promNm
						vHtml = vHtml + "					<p style='top:2px;float: right;margin-right: 10px;'>";
						vHtml = vHtml + "						<em style='color:#ff0000;font-weight:bold;font-size:1.2em;margin-bottom:-2px;display:inline-block;'>"+ promTxt +"</em>";
						vHtml = vHtml + "					</p>";
						vHtml = vHtml + "				</li>";
					} else if( roomData.roomInfos[j].custChk == '그룹직원'){
						vHtml = vHtml + "				<li  style='font-size:.8em;padding: 5px 0 5px 0;height: 20px;float: right;width: 100%;line-height: 20px;'>"
						vHtml = vHtml + "					<p style='top:2px;float: right;margin-right: 10px;'>";
						vHtml = vHtml + "						<em style='color:#ff0000;font-weight:bold;font-size:1.2em;margin-bottom:-2px;display:inline-block;'>롯데임직원 할인가 "+ comma(Math.ceil(roomData.roomInfos[j].rateInfos[0].bfTotal) - Math.ceil(roomData.roomInfos[j].rateInfos[0].jtbTotal)) +"원</em>";
						vHtml = vHtml + "					</p>";
						vHtml = vHtml + "				</li>";
					}
					
					vHtml = vHtml + "</ul>																																		 "
					$('#dtPaysearch').append(vHtml);
				}	
				
			//}
			
			var vBotHtml = '';
			vBotHtml = vBotHtml + "<div class='btn_one air_tbtn'>"
			vBotHtml = vBotHtml + "<button class='white2 moreico' data-role='none' id='morebtn' onclick='fn_morebtn();'>더보기</button>"
			vBotHtml = vBotHtml + "</div> "
			
			$('#dtPaysearch').append(vBotHtml);
		} else {
			if(li_data == undefined) {
				$('#hotel_detail_nodata_div').hide();	
			} else {
				$('#dtPaysearch').hide();
				$('#hotel_detail_nodata_div').show();
			}
		}
		
	}
	
	//hotelId 맵핑 변경
	var fn_hpIdToEanIdChk = function(hotelId){
		var formData = new FormData();
		formData.append("hotelId", hotelId);
		formData.append("suplrCd", suplrCd);
						
		cfn_ajax({
			url: "<c:url value='/fit/htl/htl_mappingAjax.do' />",
			type: "POST",
			data: formData,
			async: true,
			cache: false,
			dataType: "json",
			noloading:"no",
			success: function(data) {
				//console.log(data.htlId);
				var htlId;
				var sprCd;
			 	if(nullToBlank(data.htlId) != '') {
			 		htlId = data.htlId;   //ean꺼 id로 맴핑한 후 hotelinfo정보 가져온다.
					sprCd = 'EAN';
				} else {
					htlId = hotelIdTemp;  //ID
					sprCd = suplrCdTemp; 
				}
			 	fn_getHtlInfo(htlId, sprCd);
			},
			error:function(err){
			},
			complete:function(){
			
			}
		});
	}

    //호텔 info
	var fn_getHtlInfo = function(htlId, sprCd) {

    	//console.log(">>>>>>>>>>>fn_getHtlInfo<<<<<<<<");
    	
    	fitMix =  ($("#selAir").val() == 'Y' ? 'A' : 'X')
					 + ($("#selHotel").val() == 'Y' ? 'H' : 'X')
		 			 + ($("#selRentcar").val() == 'Y' ? 'C' : 'X');
    	
    	var setData = {
    		'fitMix' : fitMix,  
    		'suplrCd' : sprCd, //공급사코드
    		'hotelId' : htlId, //호텔 코드
    	}
			
		gfn_callAjax('/fit/htl/viewInfo.do', setData, 'fn_hotelDetail', false);	
	}
    
	
    //호텔 info
	var htlDetailInfo = [];
	var fn_hotelDetail = function(_data) {

    	htlDetailInfo = _data.hotelInfo;
    	
    	fn_roomImageDraw();
    }
    
    //호텔 상세보기 선택  //ean 용
	var fn_eanSelHotelCnt = function(li_data) {
		
		//console.log("<<<<fn_selHotelCnt~~~>>>>>=" + selroom);
		
		var setRoomTypeData = [];
		var setHotelName = [];
		var setHotelEName = [];
		
		var setRoomCont = [];
		
		//갤실 정보 조합
		var viewData = JSON.parse(sessionStorage.hotelViewData);
		//성인수
		var numberOfAdults;
		//아동수
		var numberOfChildren;
		
		//성인수
		var adultNumber = 0;
		//아동수 
		var childNumber = 0;
		
	    for(var i=0;  i < viewData.roomCont.length; i++) {
			adultNumber += parseInt(viewData.roomCont[i].numOfAdt);
			childNumber += parseInt(viewData.roomCont[i].numOfChd);	
	 
	    	var viewRoomCont = {
	    		 'numOfAdt'	: viewData.roomCont[i].numOfAdt,
	    		 'numOfChd' : viewData.roomCont[i].numOfChd,
	    		 'ageOfChd' : viewData.roomCont[i].ageOfChd,
	    		 'roomTy'   : viewData.roomCont[i].roomTy
	    	}
	    	setRoomCont.push(viewRoomCont);
	    }
		
		
		//var htlInfo = "객실" + viewData.roomCnt + " / 성인" + adultNumber + "명, 아동"  +  childNumber + "명";
		
		//투숙기간 조합
		var checkinDate = viewData.checkInDate.split("-");
		checkinDate = checkinDate[0] + "." + checkinDate[1] + "." + checkinDate[2];
		var checkoutDate = viewData.checkOutDate.split("-");
		checkoutDate = checkoutDate[0] + "." + checkoutDate[1] + "." + checkoutDate[2];
		
		
		//숙박 사람수
		var setHtlStay = {
			'roomcnt' : viewData.roomCnt,  //객실수
			"roomCont" : setRoomCont,     //검색된 roomCont정보
			'adultnumber' : adultNumber,  //어른수
			'childnumber' : childNumber   //아동수
		}
		
		
		var setHtlInfo = {
			'stayinfo' : setHtlStay,		//객실정보
			'checkinDate' : checkinDate,    //체크인
			'checkoutDate' : checkoutDate,  //체크아웃
			'checkinDay' : fn_getDay(viewData.checkInDate), //체크인 요일
			'checkoutDay' : fn_getDay(viewData.checkOutDate), //체크아웃요일
			'day'		: viewData.day  //박수
		}		 
			
		if(sessionStorage.hotelBasketData == undefined || sessionStorage.hotelBasketData == null || sessionStorage.hotelBasketData == '[]' || sessionStorage.hotelBasketData == '{}' ) {}
		else 
			g_hotel_basket_data = JSON.parse(sessionStorage.hotelBasketData);
		
		
	/* 	if(nullToBlank(g_hotel_basket_data) != '' 
			&& (viewData.fitMix == 'XHX') && (g_hotel_basket_data.length > 0)) {
			alert("호텔 단품인경우는 멀티로 예약 불가합니다.");
		} else { */ 
			
			var selIndex;
			//선택된 넘
			$(".hotel_radio_btn").each(function(){
				if($(this).is(":checked")){
					selIndex = $(this).data("index");
				}
			})
			
			//프로모션 적용가 대입
			li_data.roomInfos[0].rateInfos[0].promInfo = g_hotel_room_data.roomInfos[eanSelIdxTemp].rateInfos[0].promInfo;
			
			//호텔 룸 데이터 
			setRoomTypeData[0] = li_data.roomInfos[0];  //soldout 데이터가 이상하다.
			//setRoomTypeData[0] = g_hotel_room_data.roomInfos[selIndex];
			
			setRoomTypeData[0]['checkInInst'] = g_hotel_room_data.checkInInst; 
			setRoomTypeData[0]['specCheckInInst'] = g_hotel_room_data.specCheckInInst;
			
			//===================================================================================//
			
			setHotelName.push(h_krName);
			setHotelEName.push(h_enName);
			
			//환율
			var exchangeRate = li_data.exchangeRate;
		 	var whcExchangeRate = setRoomTypeData[0].rateInfos[0].whcExchangeRate;
					
			hashData = {
				'htlName' : setHotelName,  //호텔이름
				'htleName' : setHotelEName, //영문호텔이름
				'htlInfo' : setHtlInfo,    //객실정보
				'setRoomData' : setRoomTypeData, //룸데이터
				'countryCd' :  countryCd, //국가코드
				'cityCd' : cityCd, //도시코드
				'hotelId' : setRoomTypeData[0].hotelId, //호텔 코드
				'suplrCd' : setRoomTypeData[0].suplrCd, //공급사코드
				'exchangeRate' : exchangeRate, //exchangeRate
				'whcExchangeRate' : whcExchangeRate
			};
			
			//g_hotel_basket_data.push(hashData);
			
			//g_hotel_basket_data.sort();
			//장바구니 데이터
			//sessionStorage.hotelBasketData = JSON.stringify(g_hotel_basket_data);
	//	} 
		
	}
    
    
	//호텔 상세보기 선택  //ean용 제외한 공급사용
	var fn_selHotelCnt = function(selIdx) {
		
		//console.log("<<<<fn_selHotelCnt~~~>>>>>=" + selroom);
		
		//var setHotel = [];
		var setRoomTypeData = [];
		var setHotelName = [];
		var setHotelEName = [];
		
		var setRoomCont = [];
		
		//갤실 정보 조합
		var viewData = JSON.parse(sessionStorage.hotelViewData);
		//성인수
		var numberOfAdults;
		//아동수
		var numberOfChildren;
		
		//성인수
		var adultNumber = 0;
		//아동수 
		var childNumber = 0;
		
	    for(var i=0;  i < viewData.roomCont.length; i++) {
			adultNumber += parseInt(viewData.roomCont[i].numOfAdt);
			childNumber += parseInt(viewData.roomCont[i].numOfChd);	
	 
	    	var viewRoomCont = {
	    		 'numOfAdt'	: viewData.roomCont[i].numOfAdt,
	    		 'numOfChd' : viewData.roomCont[i].numOfChd,
	    		 'ageOfChd' : viewData.roomCont[i].ageOfChd,
	    		 'roomTy'   : viewData.roomCont[i].roomTy
	    	}
	    	setRoomCont.push(viewRoomCont);
	    }
		
		//투숙기간 조합
		var checkinDate = viewData.checkInDate.split("-");
		checkinDate = checkinDate[0] + "." + checkinDate[1] + "." + checkinDate[2];
		var checkoutDate = viewData.checkOutDate.split("-");
		checkoutDate = checkoutDate[0] + "." + checkoutDate[1] + "." + checkoutDate[2];
		
		
		//숙박 사람수
		var setHtlStay = {
			'roomcnt' : viewData.roomCnt,  //객실수
			"roomCont" : setRoomCont,     //검색된 roomCont정보
			'adultnumber' : adultNumber,  //어른수
			'childnumber' : childNumber   //아동수
		}
		
		
		var setHtlInfo = {
			'stayinfo' : setHtlStay,		//객실정보
			'checkinDate' : checkinDate,    //체크인
			'checkoutDate' : checkoutDate,  //체크아웃
			'checkinDay' : fn_getDay(viewData.checkInDate), //체크인 요일
			'checkoutDay' : fn_getDay(viewData.checkOutDate), //체크아웃요일
			'day'		: viewData.day  //박수
		}		 
			
		if(sessionStorage.hotelBasketData == undefined || sessionStorage.hotelBasketData == null || sessionStorage.hotelBasketData == '[]' || sessionStorage.hotelBasketData == '{}' ) {}
		else 
			g_hotel_basket_data = JSON.parse(sessionStorage.hotelBasketData);
		
		//호텔 룸 데이터 
		setRoomTypeData[0] = g_hotel_room_data.roomInfos[selIdx];
		
		setRoomTypeData[0]['checkInInst'] = g_hotel_room_data.checkInInst; 
		setRoomTypeData[0]['specCheckInInst'] = g_hotel_room_data.specCheckInInst;
		
		//===================================================================================//
		
		setHotelName.push(h_krName);
		setHotelEName.push(h_enName);
		
		
		setRoomTypeData[0]
		/*if(roomData.roomInfos[j].suplrCd == 'WHC') { //호텔패스인 경우만 호텔패스 환율적용해야 한다.
			exchangeRate = roomData.roomInfos[j].rateInfos[0].whcExchangeRate; //호텔패스용인 경우 환률정보있음.
			whcExchangeRate = exchangeRate;
		} else {
			exchangeRate = g_hotel_room_data.exchangeRate;
			whcExchangeRate = roomData.roomInfos[j].rateInfos[0].whcExchangeRate;
		} */
		
		//환율
		var exchangeRate; 
	 	var whcExchangeRate;
		
	 	if(setRoomTypeData[0].suplrCd == "WHC") {
	 		exchangeRate =  setRoomTypeData[0].rateInfos[0].whcExchangeRate;
	 		whcExchangeRate = exchangeRate;
	 	} else {
	 		exchangeRate =  g_hotel_room_data.exchangeRate;
	 		whcExchangeRate = setRoomTypeData[0].rateInfos[0].whcExchangeRate;
	 		
	 	}
	 
	    hashData = {
			'htlName' : setHotelName,  //호텔이름
			'htleName' : setHotelEName, //영문호텔이름
			'htlInfo' : setHtlInfo,    //객실정보
			'setRoomData' : setRoomTypeData, //룸데이터
			'countryCd' :  countryCd, //국가코드
			'cityCd' : cityCd, //도시코드
			'hotelId' : setRoomTypeData[0].hotelId, //호텔 코드
			'suplrCd' : setRoomTypeData[0].suplrCd, //공급사코드
			'exchangeRate' : exchangeRate, //exchangeRate
			'whcExchangeRate' : whcExchangeRate
		};
		
		//g_hotel_basket_data.push(hashData);
		
		//g_hotel_basket_data.sort();
		//장바구니 데이터
		//sessionStorage.hotelBasketData = JSON.stringify(g_hotel_basket_data);
		
	}
    
    
	//호텔정보  탭 화면
	function fn_drawHotelInfo() {
	 	
		if(nullToBlank(htlDetailInfo) != '') {
	 	    var valNm = [];
	 	   	var filterData = [];  // 정렬데이터
	 		var buInfo ='';
	 	   	
	 	   	var addr = htlDetailInfo.addr1 + htlDetailInfo.addr2 + htlDetailInfo.addr3 + htlDetailInfo.addr4; 
	 	   	var phone = htlDetailInfo.tel;  //nomapping
		 	var fax = htlDetailInfo.fax;    //nomapping
		 	var homePage = htlDetailInfo.web;  //nomapping
		 	var dataSize = htlDetailInfo.roomInfos.length;
	 		//console.log("dataSize=" + dataSize);
	 		
	 		if(phone == '') phone = '-';
	 		if(fax == '') fax = '-';
	 		if(homePage == '') homePage = '-';
	 		
	 		//객실내 편의시설
	 		if(dataSize > 0) {
		 	 	
		 		for(var i=0; i < dataSize; i++) {
			 		var roomAmenitiesSize = htlDetailInfo.roomInfos[i].roomAmenities.length;
			 		//console.log("roomAmenitiesSize=" + roomAmenitiesSize);
			 		var convienceInfo ='';
		 			
			 		for(var k=0; k < roomAmenitiesSize; k++) {
			 			 valNm.push(htlDetailInfo.roomInfos[i].roomAmenities[k].amenityNm);
			 		}
			 		
		 		}
		 		//sorting
				valNm.sort();
				//중복 문자열 제거
				for(var k= 0; k < valNm.length; k++) {
					$.each(valNm, function(k, el){
						if($.inArray(el, filterData) === -1) filterData.push(el);
					});
				}
		 		
				for(var m=0; m < filterData.length; m++) {
					//객실편의시설
	 		 		convienceInfo += "<li>" + filterData[m] + "</li>";
				}
	 		}
	 		
	 		//호텔 부대시설
	 		var propertyAmenitiesSize = htlDetailInfo.propertyAmenities.length;
	 		if(htlDetailInfo.propertyAmenities != null) {
		 		for(var j=0; j < propertyAmenitiesSize; j++) {
	 				//부대시설
	 				buInfo += "<li>" + htlDetailInfo.propertyAmenities[j].amenityNm + "</li>";
	 			}
	 		}
	 		
	 		//호텔소개
			var hotelcontent = htlDetailInfo.propertyDesc;
	 		if(hotelcontent == null) hotelcontent = '';
	 		else {
				hotelcontent = hotelcontent.replaceAll("&lt;" , "<");
				hotelcontent = hotelcontent.replaceAll("&gt;" , ">");
	 		}
			
			//총 객실수
			var totalRoomCnt = htlDetailInfo.numOfRooms;
			if(totalRoomCnt != '') {
				totalRoomCnt = totalRoomCnt + "실";
			} else totalRoomCnt = '-';
			
			
			var policy = '';
		    if(g_hotel_room_data.suplrCd = 'EAN') {
		    	policy = g_hotel_room_data.checkInInst + "<br>" + g_hotel_room_data.specCheckInInst;
		    } else { 
		    	policy = htlDetailInfo.propertyPolicy;
		    }
		    
		    if(nullToBlank(convienceInfo) == '') convienceInfo = "";
		    
			vHtml = '';
			
			vHtml += "		<table class='ft_table1'>"
			vHtml += "  		<colgroup>				"
			vHtml += "				<col style='width: 25%' />"
			vHtml += "           	<col style='width: 75%' />"
			vHtml += "           </colgroup>"
			vHtml += "           <tr>"
			vHtml += "              <th>호텔 주소</th>"
			vHtml += "				<td id='htl_addr'>" + addr +"</td>"
			vHtml += "           </tr>"
			vHtml += "			 <tr>"
			vHtml += "               <th>연락처</th>"
			vHtml += "               <td id='htl_phone'>" + phone + "</td>"
			vHtml += " 			 </tr>"
			vHtml += "           <tr>"
			vHtml += "                <th>Fax</th>"
			vHtml += "                <td id='htl_fax'>" + fax + "</td>"
			vHtml += "           </tr>"
			vHtml += "           <tr>"
			vHtml += "                 <th>총 객실 수</th>"
			vHtml += "			 <td id='htl_rootCnt'>" + totalRoomCnt + "</td>"
			vHtml += "           </tr>"
			vHtml += "           <tr>"
			vHtml += "                 <th>홈페이지</th>"
			vHtml += "				   <td id='htl_homepage'>" + homePage + "</td>"
			vHtml += "            </tr>"
			vHtml += "        </table>"
			vHtml += "        <dl class='ft_acdon ft_acdon1 mt7'>"
			vHtml += "           <dt>호텔 소개</dt>"
			vHtml += "           <dd id='htl_info'>" + hotelcontent + "</dd>"
			vHtml += "           <dt>호텔 정책</dt>"
			vHtml += "           <dd id='htl_policy'>"+ policy +"</dd>"
			if(buInfo != '') {
				vHtml += "           <dt>부대시설</dt>"
				vHtml += "           <dd>"
				vHtml += "              <ul class='dotlist1 float2' id='instalation'>" + buInfo + "</ul>"
				vHtml += "            </dd>"
			}
			if(convienceInfo !='') {
				vHtml += "            <dt>객실편의시설</dt>"				
				vHtml += "            <dd>"
				vHtml += "                <ul class='dotlist1 float2' id='convenient'>" + convienceInfo + "</ul>"
				vHtml += "             </dd>"
			}
			vHtml += "          </dl>" 
			
			$('#hotelfInfo').html(vHtml); 
	 	}
		acdon();
		
		//하단 장바구니 안보이게 처리
		$('#hotel_detail_nodata_div').hide();
	    $('#bottom_basket_rect').hide();
		 
	}
	

	//check된 항목 카운터
	var fn_chkselCount = function() {
		var listsize =  $('#dtPaysearch').find('ul[id="list"]').size();
		
		//check갯수
		for(var chIdx=0; chIdx < listsize; chIdx) {
		
			if($('input:checkbox[id="chk_cusm"]').is(":checked") == true) {
				chCnt++;
			}
			
		}
		//console.log("<<<chCnt=" + chCnt);
	};
	
	
	//특정 날짜 요일 구하기
	function fn_getDay(day) {
		var week = ['일', '월', '화', '수', '목', '금', '토'];
	
		var dayOfWeek = week[new Date(day).getDay()];
		//console.log("week=" + dayOfWeek);
		
		return dayOfWeek;
	} 
	
	// 버튼 초기화
	var fn_initButton = function() {
		//임시
		//sessionStorage.hotelSelData = JSON.stringify([]);
		//sessionStorage.hotelBasketData = JSON.stringify([]);
	};
	
	//하단 장바구니 담기화면 보이기
	var fn_bottomView = function() {
		fn_drawDetailPaySearch(g_hotel_room_data);	
		$('#bottom_basket_rect').show();
	}

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();
		
		$("#selectPut").click(function() {
			var hotelSelYn = false;
			var dataIndex;
			
			$(".hotel_radio_btn").each(function(){
				if($(this).is(":checked")){
					dataIndex = $(this).data("index");
					hotelSelYn = true;
					return false;
				}
			})
			
			if(!hotelSelYn){
				setAlert("호텔을 선택해 주세요.");
				return false;
			} 
			
			//항공 조합인 경우 유효성 체크  20170531
			if(nullToBlank(sessionStorage.hotelViewData) != '') {
				var hotelData = JSON.parse(sessionStorage.hotelViewData);
				var checkInDate = hotelData.checkInDate;
				var checkOutDate = hotelData.checkOutDate;
				
				var interval = calcInterval2(checkInDate, '0000', checkOutDate, '0000').split(',');
				
				if(interval[0] < -1) {
					alert("체크인, 체크아웃 날짜를 확인하여 주세요.");
					return false;
				}
				
				/* var result = false;
				if(nullToBlank(sessionStorage.airSelData) != '') {
					var selData = JSON.parse(sessionStorage.airSelData);
					if(selData[0].hasOwnProperty('gdsCd')) {  //항공 선택이 되어 있을꼉우
							
							 if(nullToBlank(selData) != '' && selData[0].segmentGroup.length > 0) {
									for(var i=0; i < selData[0].segmentGroup.length; i++) {
										 var group = selData[0].segmentGroup[i];
										 //출발여정
										 if(group.availNo == "1" && group.segNo == "1") {
											 var air_sdate = group.arrDt;
											 var s_interval = calcInterval2(air_sdate, '0000', checkInDate, '0000').split(',');
												if(s_interval[0] < 0) {
													alert('체크인 날짜가 항공 도착일보다 앞설 수 없습니다.');
													result = true;
													break;
												}
										  }
										 
										  if(selData[0].availTy == 'RT') {
												//var air_edate = selData[0].segmentGroup[1].depDt;
												if(group.availNo == "2" && group.segNo == "1") {
													var air_edate = group.depDt;
													var e_interval =  calcInterval2(checkOutDate, '0000', air_edate, '0000').split(',');
													
													if(s_interval[0] < 0) {
														alert('체크아웃 날짜가 항공 귀국일보다 늦습니다.');
														result = true;
														break;
													}
												}
										 }
									}
									
									if(result) return false;
							} 
					 }
				}  */
				
								
				//다른 호텔 예약 정보와 날짜 안 겹치게하기 위한 유효성 체크
				if(nullToBlank(sessionStorage.hotelBasketData) != '') {
					var hotelBasketData = JSON.parse(sessionStorage.hotelBasketData);
					if(nullToBlank(hotelBasketData) != '' && hotelBasketData.length > 0) {
							for(var i=0; i < hotelBasketData.length; i++) {
								var basketArr = hotelBasketData[i].htlInfo;
								var s_checkInDate = basketArr.checkinDate;
								var e_checkOutDate = basketArr.checkoutDate;
								
								var s_interval = calcInterval2(s_checkInDate, '0000', checkOutDate, '0000').split(',');
								var e_interval = calcInterval2(e_checkOutDate, '0000', checkInDate, '0000').split(',');
								
								if((s_interval[0] < 1) || (e_interval[0] > -1)) {
									console.log("validate");
								} else {
									  if(fitMix != 'XHX') { //단독 상품이 아닌경우
										alert('선택하는 호텔 날짜가 겹쳤습니다.다른 날짜로 검색해 주시기 바랍니다.');
										return false; 
									}  
								}
								
							}
							
					}
				}
	
				//체크
				if(hotelSelYn) {
					//session에 담자.	
					g_hotel_basket_data.push(hashData);
		
					g_hotel_basket_data.sort();
					sessionStorage.hotelBasketData = JSON.stringify(g_hotel_basket_data);
				}
				
			}
			
			/* else {
				var suplrCd = g_hotel_room_data.suplrCd;
				if(suplrCd == 'EAN') {
					//soleout check
					fn_SoldOutRoomChk(dataIndex);
				} else if(suplrCd == 'WHC') {
					fn_CancelPolicy(dataIndex);
					
				} else {
					fn_selHotelCnt(dataIndex);
				}
  				
			} */
		});

		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});

	// });

</script>
</head>
<body>
 
	<form name="f_frm" id="f_frm" method="post">
		<input type="hidden" name="selAir" id="selAir" value="${selAir}" />
		<input type="hidden" name="selHotel" id="selHotel" value="${selHotel}" />
		<input type="hidden" name="selRentcar" id="selRentcar" value="${selRentcar}" />
	</form>

	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="collapse freetop">
			<!-- 중복텝 -->
			<%
				// 항공 || 호텔 || 렌트카
				if(selAir.equals("Y") && selHotel.equals("Y") && selRentcar.equals("Y")) {
			%>
			<div class="free_box">
				<ul class="free_toprst frrst3">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="hotelcheck">호텔</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
				// 항공 || 호텔
				if(selAir.equals("Y") && selHotel.equals("Y") && !selRentcar.equals("Y")) {
			%> 
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="hotelcheck">호텔</label></li>
				</ul>
			</div>
			<%
				}
				// 항공 || 렌트카 
				if(selAir.equals("Y") && !selHotel.equals("Y") && selRentcar.equals("Y")) {
			%>
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
				// 호텔 || 렌트카 
				if(!selAir.equals("Y") && selHotel.equals("Y") && selRentcar.equals("Y")) {			
			%>
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" disabled="true" /><label for="hotelcheck">호텔</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
				// 항공
				if(selAir.equals("Y") && !selHotel.equals("Y") && !selRentcar.equals("Y")) {			
			%>			
			<div class="free_box">
				<ul class="free_toprst frrst1">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="aircheck">항공</label></li>
				</ul>
			</div>
			<%
				}
				// 호텔
				if(!selAir.equals("Y") && selHotel.equals("Y") && !selRentcar.equals("Y")) {			
			%>			
			<div class="free_box">
				<ul class="free_toprst frrst1">
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="hotelcheck">호텔</label></li>
				</ul>
			</div>
			<%
				}
				// 렌터카
				if(!selAir.equals("Y") && !selHotel.equals("Y") && selRentcar.equals("Y")) {			
			%>			
			<div class="free_box">
				<ul class="free_toprst frrst1">
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<%
				}
			%>
			<!-- 갯수별 
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" disabled="true" /><label for="hotelcheck">호텔</label></li>
				</ul>
			</div>
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="hotelcheck">호텔</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<div class="free_box">
				<ul class="free_toprst frrst1">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="aircheck">항공</label></li>
				</ul>
			</div>
			-->
			<!-- 간략안내 -->
			<div class="re_sch_detail">
				<div class="stable_guide3">
					<p class="st3_stext ellipsis" id="htl_krname"></p>
					<p class="st3_text ellipsis" id="htl_enname"></p>
				</div>
				<div class="swiper-container imgGallery re_ht_slider">
					<div class="swiper-wrapper" id="htlRoomImg" style="width: 100%; height: 350px;" >
						<!-- 
						<div class="swiper-slide">
							<img src="/resources/images/img/ht_sliderimg1.jpg" alt="" />
						</div>
						<div class="swiper-slide">
							<img src="/resources/images/img/ht_sliderimg1.jpg" alt="" />
						</div>
						<div class="swiper-slide">
							<img src="/resources/images/img/ht_sliderimg1.jpg" alt="" />
						</div>
						<div class="swiper-slide">
							<img src="/resources/images/img/ht_sliderimg1.jpg" alt="" />
						</div>
						<div class="swiper-slide">
							<img src="/resources/images/img/ht_sliderimg1.jpg" alt="" />
						</div>
						<div class="swiper-slide">
							<img src="/resources/images/img/ht_sliderimg1.jpg" alt="" />
						</div>
						<div class="swiper-slide">
							<img src="/resources/images/img/ht_sliderimg1.jpg" alt="" />
						</div>
						<div class="swiper-slide">
							<img src="/resources/images/img/ht_sliderimg1.jpg" alt="" />
						</div> -->
					</div>
					<div class="swiper-pagination"></div>
					<div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div>
				</div>
				<div class="re_ht_sns">
					<a class="facebook ui-link" href="https://www.facebook.com/"></a>
					<a class="yellowid ui-link" href="https://story.kakao.com/ch/kakaostory"></a>
					<a class="kakaotalk ui-link" href="http://www.kakao.com/talk/ko"></a>
					<a class="naverband ui-link" href="http://band.us/ko"></a>
					<a class="email ui-link" style='display:none'></a>
					<!-- <a class="email ui-link layerOpener white2" data-url='/fit/htl/htl_email.do?hotelCd='  data-ctn="full" data-role="none" style="cursor='hand';" data-ok='yes'></a> -->
				</div>
				<div class="whitebox2" id="checkContent">
					<ul>
					   <li>검색된 요금은 베드타입의 보장이 아닌 <span class="txt_red">&quot;해당 인원수가 투숙할 수 있는 모든 객실타입의 요금&quot;</span>입니다.</li>
					   <li>동일 객실타입에 요금이 다를 경우에는 <span class="txt_red">&quot;현지 공급사&quot;</span>에 따라 가격차이가 발생 하오니 같은 조건이면 <span class="txt_red">&quot;낮은 요금&quot;</span>을 선택하세요</li>
					   <li>어린이 동반투숙은 객실타입에 따라 제약이 있을 수 있으니 별도 문의 바랍니다.</li>
					</ul>
				</div>
				
				<!-- 결과텝 -->
				<ul class="tablist_com free_ht_dttab" data-ctn="ht_dt_box">
					<li class="active"><button type="button" data-role="none" onclick="fn_bottomView()">상세요금조회</button></li>
					<li><button type="button" data-role="none" onclick="fn_drawHotelInfo()">호텔정보</button></li>
					<li><button type="button" data-role="none" onclick="initMap()">위치정보</button></li>
															
				</ul>
				
				<!-- 상세요금  조회-->
				<div class="tabctn_com ht_dt_box ht_dt_box1 ps_view" id="dtPaysearch">

					<!-- <ul>
						<li><span class="red_gbox">예약가능</span></li>
						<li>
							<p class="chkbox ht_show">
								<span><input id="chk_cusm1" type="checkbox"
									data-role="none" /></span> <label for="chk_cusm1"><em>DELUXE</em>
									(Rever view)</label>
							</p>
							<div class="ht_dt_btn" id="ht_dt_btn">
								
							</div>
						</li>
						<li>44㎡ | 킹사이즈 침대 1개 또는 퀸 사이즈 침대 2개 (추가 침대 이용가능 : 유라용 침대)</li>
						<li><span>조식 불 포함</span>
							<p>
								<strike>9,30,000원</strike><em>9,30,000</em>원
							</p></li>
					</ul> -->


					<!-- 버튼 -->
					<!-- <div class="btn_one air_tbtn">
						<button class="white2 moreico" data-role="none" id="morebtn">더보기</button>
					</div> -->
				</div>
				<div id='hotel_detail_nodata_div' name="hotel_detail_nodata_div" style="display:none">
					<div class="fr_nodata">
						<p>
							예약 가능한 객실이<br>없습니다.
						</p>
					</div>		
				</div>	
				<div class="tabctn_com ht_dt_box ht_dt_box2" id="hotelfInfo">
									
					
				</div>
				<div class="tabctn_com ht_dt_box ht_dt_box3" ft-att="googlemap_pop">
					<dl class="ft_acdon2">
						<dt>교통 정보</dt>
						<dd>
							<ul id="trafficeInfo">
								<!-- <li>차오프라야 강변에 위치</li>
								<li>수완나품 국제공항에서 차량 이동 시 약 30분소요</li>
								<li>Saphan BTS역 인근에 위치</li> -->
							</ul>
						</dd>
					</dl>
					<ul class="fr_ht_maps" id="fr_ht_maps">
						<div id="map_view" style="height:300px">
						
						<!-- 지도 표시부  -->
						
						</div>
						<li id="map_guide">
							<a class="hotel">호텔</a> 
							<a class="place">명소</a> 
							<a class="shopping">쇼핑</a> 
							<a class="trafic">교통</a> 
							<a class="exhibition">전시장</a> 
						</li>
					</ul>
					<dl class="ft_acdon2">
						<dt>주변 관광 정보</dt>
						<dd>
							<ul id ="locationInfo">
								<!-- <li>차오프라야 강변에 위치</li>
								<li>수완나품 국제공항에서 차량 이동 시 약 30분소요</li>
								<li>Saphan BTS역 인근에 위치</li> -->
							</ul>
						</dd>
					</dl>
				</div>


			</div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//content-->
	</body>