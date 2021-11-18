//구글맵 팝업
var markerGroup = [];	//마커그룹
var markerChecker = [];
var addinfowindow;
var g_radius = 50000;

var cmtGooglemapPopJs = cmtGooglemapPopJs || new Object();
var map;
var latlng = '';
cmtGooglemapPopJs = {
	init : function(){
		var latitude = $(this).attr('latitude');
		var longitude = $(this).attr('longitude');
		var hotelNm = $(this).attr('hotel-name'); //임시
		
		var ggmap_pop;
		var tmp_id;
		//popup 존재 시 삭제
		if($('div[ft-att="googlemap_pop"]').length < 1) {
			//기본 popup골격 생성
			tmp_id = uijs.init();
			
			var base_pop = $('div[pop-id="' + tmp_id + '"]');

			//pop속성 추가
			base_pop.addClass('googlemap')
					.attr('ft-att', 'googlemap_pop');
			
			ggmap_pop = $('div[ft-att="googlemap_pop"]'); 
		} else {
			ggmap_pop = $('div[ft-att="googlemap_pop"]');
			tmp_id = ggmap_pop.attr('pop-id');
		}
		
		//제목
		var close_btn = $('<a href="javascript:void(0);" att-id="' + tmp_id + '" class="btn floatR">닫기</a>')
				.on('click', uijs.hide);
		ggmap_pop.find('.pop_head').html('지도보기')
									.append(close_btn);
	
		//내용
		var cont_html = '<div style="width: 600px; height: 400px;" id="map_view"></div>	'
					+	'<div class="map_guide">                                       	'
					+	'	<span class="hotel">호텔</span>                            	'
					+	'	<span class="place">명소</span>                            	'
					+	'	<span class="shopping">쇼핑</span>                         	'
					+	'	<span class="trafic">교통</span>                           	'
					+	'	<span class="exhibition">전시장</span>                    	'
					+	'</div>';
		ggmap_pop.find('.pop_cont')
						.addClass('map')
						.html(cont_html);
	
		//주변 정보 클릭 이벤트
		ggmap_pop.find('.map_guide').on('click', 'span', cmtGooglemapPopJs.showAtt);
		
		//구글맵 호출
		var zoomLevel		= 14;						// 지도의 확대 레벨 : 숫자가 클수록 확대정도가 큼
		var markerMaxWidth	= 300;						// 마커를 클릭했을때 나타나는 말풍선의 최대 크기
	
		latlng = latitude + ',' + longitude;
		
		var myLatlng = new google.maps.LatLng(latitude, longitude);
		var mapOptions = {
			zoom: zoomLevel,
			center: myLatlng,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		};
		
		map = new google.maps.Map(document.getElementById('map_view'), mapOptions);
	
		var marker = new google.maps.Marker({
			position: myLatlng,
			map: map,
			title: hotelNm
			//icon : 'http://localhost/common/images/new/flag_shopping.png'	
		});
		
		//common/images/new/flag_trafic.png
	
		var infowindow = new google.maps.InfoWindow({
			content: hotelNm,
			maxWidth: markerMaxWidth
		});
	
		google.maps.event.addListener(marker, 'click', function() {
			infowindow.open(map, marker);
		});
		
		//마커 그룹 초기화
		markerGroup = [];
		markerChecker = [];
		
		//팝업 위치지정
		uijs.setPosition(ggmap_pop);
		
		//표시
		uijs.show(tmp_id, true);
	},
	
	showAtt : function(){	// 주변정보 마킹
		if($(this).hasClass('current')){
			// 이미 노출되어 있는 경우 마커삭제
			cmtGooglemapPopJs.removeAtt(this);
		} else {
			var selClass = $(this).attr('class');
			$(this).addClass('current');

			if(markerChecker.indexOf(selClass) < 0){
				markerChecker.push(selClass);
				markerGroup.push([]);
			}
			
			var markerNo = markerChecker.indexOf(selClass);
			
			if(selClass == 'hotel'){
				var mkGrp = markerGroup[markerNo];
				var hotelData = g_hotel_fix_data;
				for(var h_idx=0; h_idx<hotelData.length; h_idx++){
					if(latlng != hotelData[h_idx].lat + ',' + hotelData[h_idx].longi){
						var addmarker = new google.maps.Marker({
							"position"	: new google.maps.LatLng(hotelData[h_idx].lat, hotelData[h_idx].longi),
							"map"		: map,
							"draggable"	: false,
							"title"		: hotelData[h_idx].hotelNm_kr,
							"icon"		: "http://localhost/common/images/new/flag_hotel.png"
						});
						
						mkGrp.push(addmarker);
						
						google.maps.event.addListener(addmarker, 'click', function() {
							var tmpwindow = addinfowindow; 
							addinfowindow = new google.maps.InfoWindow({
								content: hotelData[h_idx].hotelNm_kr,
								maxWidth: 300
							});	
							addinfowindow.open(map,addmarker);
							tmpwindow.setMap(null);
						});
					}
				}
			} else {
				//test
				var latlngarr = latlng.split(',');
				
				if($('#radious').length > 0){
					g_radius = $('#radious').val();
				}
				
				var reqData = {
					latitude	: latlngarr[0],
					longitude	: latlngarr[1],
					types		: selClass,
					radius		: g_radius
				};
				
				cmtGooglemapPopJs.markerNo = markerNo;
				
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
				"draggable"	: false,
				"place"		: {
								placeId: radarList[r_idx].place_id,
						        location: radarList[r_idx].geometry.location
							},
				//"title"		: "test",
				"icon"		: "http://localhost/common/images/new/flag_shopping.png"
			});

			mkGrp.push(addmarker);
			
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
		console.log(_data);
	},
	removeAtt : function(_obj){
		$(_obj).removeClass('current');
		
		var selClass = $(_obj).attr('class');
		var markerNo = markerChecker.indexOf(selClass);
		var mkGrp = markerGroup[markerNo];
		
		for(var r_idx=0; r_idx<mkGrp.length; r_idx++){
			mkGrp[r_idx].setMap(null);
		}
	}
};
