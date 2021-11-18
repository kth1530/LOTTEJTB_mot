
var cmtGooglemapJs = cmtGooglemapJs || new Object();

var g_map = [];
var g_latlng = [];
var g_markerGroup = [];	//마커그룹
var g_markerChecker = [];
var g_addinfowindow = [];
var g_radius = 50000;
var mapOptions={};
cmtGooglemapJs = {
	init : function(p_obj){
		var rewind = false; 
			
		if($(p_obj).attr('ft-att') == undefined){
			p_obj = this;
		} else {
			rewind =true;
		}
		
		var map_open = $(p_obj).attr('map-open'); //임시
		
		if(map_open == 'Y'){
			return;
		} else {
			var l_ftIdx = $(p_obj).parents('[ft-att="hotelList"]').attr('ft-idx')-0;
			
			var latitude = $(p_obj).attr('latitude');
			var longitude = $(p_obj).attr('longitude');
			var hotelNm = $(p_obj).attr('hotel-name'); //임시
					
			var map_div = $(p_obj).parents('.layout.detail').find('#tabs3');	// 부모영역
			
			//주변 정보 클릭 이벤트
			map_div.find('.map_guide').on('click', 'span', cmtGooglemapJs.showAtt);
			
			//구글맵 호출
			var zoomLevel		= 14;						// 지도의 확대 레벨 : 숫자가 클수록 확대정도가 큼
			var markerMaxWidth	= 300;						// 마커를 클릭했을때 나타나는 말풍선의 최대 크기
		
			g_latlng[l_ftIdx] = latitude + ',' + longitude;
			
			var myLatlng = new google.maps.LatLng(latitude, longitude);
			mapOptions = {
				zoom: zoomLevel,
				center: myLatlng,
				mapTypeId: google.maps.MapTypeId.ROADMAP
			};

			// 탭 먼저 오픈
			map_div.css('display', 'block');
			
			g_map[l_ftIdx] = new google.maps.Map(document.getElementById('map_view_' + l_ftIdx), mapOptions);
		
			var marker = new google.maps.Marker({
				position: myLatlng,
				map: g_map[l_ftIdx],
				title: hotelNm
				//icon : 'http://localhost/common/images/new/flag_shopping.png'	
			});
			
			//common/images/new/flag_trafic.png
		
			var infowindow = new google.maps.InfoWindow({
				content: hotelNm,
				maxWidth: markerMaxWidth
			});
		
			google.maps.event.addListener(marker, 'click', function() {
				var e_ftIdx = $(p_obj).parents('[ft-att="hotelList"]').attr('ft-idx')-0;
				infowindow.open(g_map[e_ftIdx], marker);
			});
			
			//마커 그룹 초기화
			g_markerGroup[l_ftIdx] = [];
			g_markerChecker[l_ftIdx] = [];
			
			if(!rewind && g_map[l_ftIdx].mapDataProviders == undefined){
				cmtGooglemapJs.init(p_obj);
			} else {
				$(p_obj).attr('map-open', 'Y');	//맵 로딩 여부
			}
		}
	},
		
	showAtt : function(){	// 주변정보 마킹
		if($(this).hasClass('current')){
			// 이미 노출되어 있는 경우 마커삭제
			cmtGooglemapJs.removeAtt(this);
		} else {
			var selClass = $(this).attr('class');
			$(this).addClass('current');

			var e_ftIdx = $(this).parents('[ft-att="hotelList"]').attr('ft-idx')-0;

			if(g_markerChecker[e_ftIdx].indexOf(selClass) < 0){
				g_markerChecker[e_ftIdx].push(selClass);
				g_markerGroup[e_ftIdx].push([]);
			}
			
			var markerNo = g_markerChecker[e_ftIdx].indexOf(selClass);
			
			if(selClass == 'hotel'){
				var mkGrp = g_markerGroup[e_ftIdx][markerNo];
				var hotelData = g_hotel_fix_data;
				for(var h_idx=0; h_idx<hotelData.length; h_idx++){
					if(g_latlng[e_ftIdx] != hotelData[h_idx].lat + ',' + hotelData[h_idx].longi){
						var addmarker = new google.maps.Marker({
							"position"	: new google.maps.LatLng(hotelData[h_idx].lat, hotelData[h_idx].longi),
							"map"		: g_map[e_ftIdx],
							"draggable"	: false,
							"title"		: hotelData[h_idx].hotelNm_kr,
							"icon"		: "http://localhost/common/images/new/flag_hotel.png"
						});
						
						mkGrp.push(addmarker);
						
						google.maps.event.addListener(addmarker, 'click', function() {
							var tmpwindow = g_addinfowindow[e_ftIdx]; 
							g_addinfowindow[e_ftIdx] = new google.maps.InfoWindow({
								content: hotelData[h_idx].hotelNm_kr,
								maxWidth: 300
							});	
							g_addinfowindow[e_ftIdx].open(map,addmarker);
							tmpwindow.setMap(null);
						});
					}
				}
			} else {
				//test
				var latlngarr = g_latlng[e_ftIdx].split(',');
				
				if($('#radious').length > 0){
					g_radius = $('#radious').val();
				}
				
				var reqData = {
					latitude	: latlngarr[0],
					longitude	: latlngarr[1],
					types		: selClass,
					radius		: g_radius
				};
				
				cmtGooglemapJs.markerNo = markerNo;
				cmtGooglemapJs.ftIdx = e_ftIdx;
				
				gfn_callAjax ('/fit/htl/radarsearchAjax.do', reqData, 'cmtGooglemapJs.drawAtt', true);
			}
		}
	},
	markerNo : 0,
	ftIdx : 0,
	drawAtt : function(_data){
		console.log(_data);
		
		var radarList = _data.radarList.results;
		var e_ftIdx = cmtGooglemapJs.ftIdx;
		var mkGrp = g_markerGroup[e_ftIdx][cmtGooglemapJs.markerNo];
		
		for(var r_idx=0; r_idx<radarList.length; r_idx++){
			var addmarker = new google.maps.Marker({
				"map"		: g_map[e_ftIdx],
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
				
				cmtGooglemapJs.clMarker = this;
				
				gfn_callAjax ('/fit/htl/radarDetailsearchAjax.do', reqData, 'cmtGooglemapJs.detailInfo', true);
			});
		}
	},
	clMarker : Object,
	detailInfo : function(_data){
		var e_ftIdx = cmtGooglemapJs.ftIdx;
		var tmpwindow = g_addinfowindow[e_ftIdx];
		var content = '<a class="infoWindow">' + _data.radarData.result.name + '</a>';
		g_addinfowindow[e_ftIdx] = new google.maps.InfoWindow({
			content: content,
			maxWidth: 300
		});	
		g_addinfowindow[e_ftIdx].open(g_map[e_ftIdx],cmtGooglemapJs.clMarker);
		
		$('.infoWindow').on('click', function() {
			window.open(_data.radarData.result.url, '_blank'); ;
		});
		
		tmpwindow.setMap(null);
		console.log(_data);
	},
	removeAtt : function(_obj){
		$(_obj).removeClass('current');
		var selClass = $(_obj).attr('class');
		
		var e_ftIdx = $(_obj).parents('[ft-att="hotelList"]').attr('ft-idx')-0;
		
		var markerNo = g_markerChecker[e_ftIdx].indexOf(selClass);
		var mkGrp = g_markerGroup[e_ftIdx][markerNo];
		
		for(var r_idx=0; r_idx<mkGrp.length; r_idx++){
			mkGrp[r_idx].setMap(null);
		}
	}
};
