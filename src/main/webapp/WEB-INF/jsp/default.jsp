<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	
	// 설명 : 항공권 상세보기
%>
<!--  <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3.exp&region=KR&key=AIzaSyD7Ofh1fQwL-osDzzlbdvRjvlG2Y8-nEyU&callback=initMap"></script>-->
<script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDb3QbLpTEk_Pa-32zEyUABiheOLebzQyQ&callback=initMap" async defer></script>
<!-- <script type="text/javascript" src="/resources/common/js/google/maps-ui.js"></script>
<script type="text/javascript" src="/resources/common/js/google/maps-ground-ui.js"></script>	
<script type="text/javascript" src="/resources/common/js/fit/ui.js"></script>	 -->

<script type="text/javascript">
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){

	var cmtGooglemapPopJs = cmtGooglemapPopJs || new Object();
	var lat = '${lat}';
	var longi = '${longi}';
	var hname = '${hname}';
	var g_radius = 50000;
	
	var googlemap_pop;
	var tmp_id;
	var latlng = '';
	var map;
		
		
	
	// 초기화
	var fn_init = function() {
	
	};
	
	
	
	var initMap = function() {
		cmtGooglemapPopJs.init();
	}
	
	
	var markerChecker = [];
	var markerGroup = [];
	var addinfowindow;
	cmtGooglemapPopJs = {
			init : function(){
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
				
				console.log("lat=" + lat + "longi=" + longi + "hname=" + hname);
				
				var mapOptions = {
					center : myLatlng,
					zoom : zoomLevel,
					mapTypeId:google.maps.MapTypeId.ROADMAP
				
				};
				
				map = new google.maps.Map(document.getElementById('map_view'), mapOptions);
				
				var marker = new google.maps.Marker({
				 	 position: myLatlng,
				 	 map : map,
				 	 title: hname,
				 	 draggable:true
				});
				marker.setMap(map);
				
				addinfowindow = new google.maps.InfoWindow({
					content:hname,
					maxWidth:markerMaxWidth
				}); 
				
			 	google.maps.event.addListener(marker, 'click', function() {
			 		addinfowindow.open(map,marker);
					
				}); 
			 	
			 	
			},
			
			showAtt : function(){	// 주변정보 마킹
				
				if($(this).hasClass('current')){
					// 이미 노출되어 있는 경우 마커삭제
					cmtGooglemapPopJs.removeAtt(this);
				} else {
					var selClass = $(this).attr('class');
					$(this).addClass('current');
					$(this).addClass('on');
				
					if(markerChecker.indexOf(selClass) < 0){
						markerChecker.push(selClass);
						markerGroup.push([]);
					}
					
					var markerNo = markerChecker.indexOf(selClass);
					
					if(selClass == 'hotel'){
						console.log(">>>>>>>>>>>>>hotel<<<<<<<<<<");	
					
						var mkGrp = markerGroup[markerNo];
						var hotelData = g_hotel_all_data;
						for(var h_idx=0; h_idx<hotelData.length; h_idx++){
							if(latlng != hotelData[h_idx].lat + ',' + hotelData[h_idx].lon){
								var addmarker = new google.maps.Marker({
									"map"		: map,
									"draggable"	: false,
									"h_idx"		: h_idx,
									"title"		: hotelData[h_idx].hotelNmKr,
									"position"	: new google.maps.LatLng(hotelData[h_idx].lat, hotelData[h_idx].lon),
									"icon"		: "/resources/common/images/icons-png/flag_hotel.png"
								});
								
								
								
								/* "place"		: {
									placeId: radarList[r_idx].place_id,
							        location: radarList[r_idx].geometry.location
								}, */
								
								google.maps.event.addListener(addmarker, 'click', function() {
									var h_idx =  this.h_idx;
										
									var tmpwindow = addinfowindow;
									var content = '<a class="infoWindow">' + hotelData[h_idx].hotelNmKr + '</a>';
									var addinfowindow = new google.maps.InfoWindow({
										content: content,
										maxWidth: 300
									});	
									addinfowindow.open(map,cmtGooglemapPopJs.clMarker);
									
									$('.infoWindow').on('click', function() {
										window.open(_data.radarData.result.url, '_blank');
									});
									tmpwindow.setMap(null);
								});
								mkGrp.push(addmarker);
								
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
			drawAtt : function(_data){
				console.log(_data);
				
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
						"icon"		: "http://m.lottejtb.com/resources/common/images/icons-png/flag_" + cmtGooglemapPopJs.selClass + ".png"
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
					window.open(_data.radarData.result.url, '_blank'); 
				});
				
				tmpwindow.setMap(null);
				console.log(_data);
			},
			removeAtt : function(_obj){
				$(_obj).removeClass('current');
				$(_obj).removeClass('on');
				
				var selClass = $(_obj).attr('class');
				var markerNo = markerChecker.indexOf(selClass);
				var mkGrp = markerGroup[markerNo];
				if(nullToBlank(mkGrp) != '' && mkGrp.length > 0) {
					for(var r_idx=0; r_idx<mkGrp.length; r_idx++){
						mkGrp[r_idx].setMap(null);
					}
					
				}
			}
	};
	

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};
	
	
	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
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
<body>
<div class="layerPopup">
	<div class="layerPop bgwhite">
		<!-- 내용시작 -->
		<div class="popCon" ft-att="googlemap_pop">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">위치보기</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain pop_mapbox">
				<!-- <dl class="ft_acdon2">
					<dt>교통 정보</dt>
					<dd>
						<ul class="dotlist2">
							<li>차오프라야 강변에 위치</li>
							<li>수완나품 국제공항에서 차량 이동 시 약 30분소요</li>
							<li>Saphan BTS역 인근에 위치</li>
						</ul>
					</dd>
				</dl> -->
				<ul class="fr_ht_maps" id="fr_ht_maps">
					<div id="map_view" style="height:300px;">
					    <!--  <img src="/resources/images/img/maps.gif" alt="" /> -->
					</div>
					<li id="map_guide">
					   <a class="hotel">호텔</a> 
					   <a class="place ">명소</a> 
					   <a class="shopping">쇼핑</a> 
					   <a class="trafic">교통</a>
					   <a class="exhibition">전시장</a>
					</li>
				</ul>
				<!-- <dl class="ft_acdon2 mt7">
					<dt>주변 관광 정보</dt>
					<dd>
						<ul class="dotlist2">
							<li>차오프라야 강변에 위치</li>
							<li>수완나품 국제공항에서 차량 이동 시 약 30분소요</li>
							<li>Saphan BTS역 인근에 위치</li>
						</ul>
					</dd>
				</dl> -->
			</div>
		</div>
		<!-- 내용끝 -->
		<div class="popFoot">
			<div class="layerBtns">
				<button type="button" class="layerClose1" onclick="closePopup()">확인</button>
			</div>
		</div>
	</div>
</div>
</body>
