<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=80e921dafcf8d896c3b4e9cb6d0088e7&libraries=services"></script>

<script type="text/javascript">
	var listSize = "${listSize}";		
	var pageSize = "${pageSize}";
	var searchTxt = "${searchTxt}";
	var allCnt;
	var roadCnt;
	var lotteCnt;
	var searchTxt = "";
	var map;

	// 초기화
	var fn_init = function() {
		fn_shopList();
	};
			
	// 버튼 초기화
	var fn_initButton = function() {
	};
	
	var fn_shopList = function(){
		var schTxt = "";
		var startRow = 1;
		var endRow = Number(pageSize);
		
		schTxt = nullToBlank($("#searchTxt").val());
		searchTxt = nullToBlank($("#searchTxt").val());			
	
		var formData = new FormData();
		formData.append('schTxt', schTxt);
		formData.append('startRow', startRow);
		formData.append('endRow', endRow);
		
		cfn_ajax({
			url: "<c:url value='/shop/shopListSearch.do' />",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:"no",
			success: function(res) {
				list = res.list;
				list_road = res.list_road;
				list_lotte = res.list_lotte;
				counts = res.counts;
				
				fn_htmlOutput(list, "#allShopList", "N");
				fn_htmlOutput(list_road, "#roadShopList", "N");
				fn_htmlOutput(list_lotte, "#lotteShopList", "N");
				
				$("#allCnt").text(counts[0].cnt);
				$("#roadShopCnt").text(counts[1].cnt);
				$("#lotteShopCnt").text(counts[2].cnt);
				
				allCnt = counts[0].cnt;
				roadCnt = counts[1].cnt;
				lotteCnt = counts[2].cnt;
			},
			error:function(err){
				console.log(err);
			},
			complete:function(){
			}
		});
	}
	
	var fn_moreShopList = function(){
		var type = $(".pd10").find(".ui-btn-active").data("index");
		var curRow = 0;
		var thisSize = 0;
		var requestURL = "";
		var target = "";
		
		switch(type){
		case 1:
		case '1':
			curRow = Number($("#allShopList").find("li").size());
			thisSize = allCnt;
			requestURL = "<c:url value='/shop/shopAllListSearch.do' />";
			target = "#allShopList";
			break;
		case 2:
		case '2':
			curRow = Number($("#roadShopList").find("li").size());
			thisSize = roadCnt;
			requestURL = "<c:url value='/shop/shopRoadListSearch.do' />";
			target = "#roadShopList";
			break;
		case 3:
		case '3':
			curRow = Number($("#lotteShopList").find("li").size());
			thisSize = lotteCnt;
			requestURL = "<c:url value='/shop/shopLotteListSearch.do' />";
			target = "#lotteShopList";
			break;
		default:
			return false;
		}
		
		var startRow = curRow + 1;
		var endRow = curRow + Number(pageSize);
		
		if(startRow > thisSize) {
			alert("더이상 등록된 매장이 없습니다");
			return false;
		}
		
		var formData = new FormData();
		formData.append('schTxt', searchTxt);
		formData.append('startRow', startRow);
		formData.append('endRow', endRow);
		
		cfn_ajax({
			url: requestURL,
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:"no",
			success: function(res) {
				list = res.list;
				
				fn_htmlOutput(list, target, "Y");
			},
			error:function(err){
				console.log(err);
			},
			complete:function(){
			}
		});
	}
	
	var fn_htmlOutput = function(list, target, appendYN){
		var vHTML = "";
		
		for(var i = 0; i < list.length; i++){
			vHTML += "<li>";
			vHTML += "	<table>";
			vHTML += "		<colgroup>";
			vHTML += "			<col width='20%'>";
			vHTML += "			<col width='30%'>";
			vHTML += "			<col width='20%'>";
			vHTML += "			<col width='30%'>";
			vHTML += "		</colgroup>";
			vHTML += "		<tbody>";
			vHTML += "			<tr>";
			vHTML += "				<th>지점명</th>";
			vHTML += "				<td colspan='3'>"+ nullToBlank(list[i].siteNm) +"</td>";
			vHTML += "			</tr>";
			vHTML += "			<tr>";
			vHTML += "				<th>TEL</th>";
			vHTML += "				<td>"+ nullToBlank(list[i].siteTel1) +"-"+ nullToBlank(list[i].siteTel2) +"-"+ nullToBlank(list[i].siteTel3) +"</td>";
			vHTML += "				<th>FAX</th>";
			vHTML += "				<td>"+ nullToBlank(list[i].siteFax) +"</td>";
			vHTML += "			</tr>";
			vHTML += "			<tr>";
			vHTML += "				<th>주소</th>";
			//vHTML += "					<td colspan='3'>"+ list[i].siteAddr1 +" "+ list[i].siteAddr2 +"<a href='#'><img src='/resources/images/btn/btn_map.png'/></a></td>";
			vHTML += "					<td colspan='3'>"+ nullToBlank(list[i].siteAddr1) +" "+ nullToBlank(list[i].siteAddr2) +"</td>";
			vHTML += "				</tr>";
			vHTML += "			<tr>";
			vHTML += "				<th>약도</th>";
			vHTML += "				<td><a href='#' class='btnMap' onclick='openMap(\""+ list[i].siteAddr1 +"\", \""+ list[i].siteNm +"\")'>지도보기</a></td>";
			vHTML += "				<th>담당자</th>";
			vHTML += "				<td>"+ nullToBlank(list[i].chaNm) +"</td>";
			vHTML += "			</tr>";
			vHTML += "		</tbody>";
			vHTML += "	</table>";
			vHTML += "</li>";
		}
		
		if(appendYN == 'Y'){
			$(target).append(vHTML);
		}else{
			$(target).html(vHTML);
		}
	}
	
	var lat;
	var lng;
	
	var openMap = function(addr, name){

		$("#popupGeo-popup").show();		
		
		var addr = addr;
		var name = name;
		
		var arrAddr = addr.split(",");
		var mapContainer = document.getElementById('showMap'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(126.9353937, 37.6025309), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  


		// 지도를 생성합니다    	
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 지도에 확대 축소 컨트롤을 생성한다
		var zoomControl = new kakao.maps.ZoomControl();

		// 지도의 우측에 확대 축소 컨트롤을 추가한다
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(arrAddr[0] , function(result, status) {
		
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        //var infowindow = new kakao.maps.InfoWindow({
		        //    content: '<div class="marker" style="width:150px;text-align:center;padding:6px 0;">' + name + '</div>'
		        //});
		        //infowindow.open(map, marker);
		
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);

				$("#googleMapPop").click();
				
		    } 
		});    
	 		
		
	}

	$(document).ready(function() {
		fn_init();
		fn_initButton();
		
	});

	$(document).off("click", "#popBack");
	$(document).on("click", "#popBack", function(){
/*
		$("#popupGeo").remove();
		
		var vHtml = "";
		vHtml += '<div id="popupGeo" data-role="popup" data-overlay-theme="a" class="ui-content" data-dismissible="false">';
		vHtml += '	<div style="width:100%;height:50px;">';
		vHtml += '		<div style="width:100%;height:50px;background-color:#705399;z-index:999">';
		vHtml += '			<strong style="display:block;padding:0;color:#fff;text-align:left;text-indent:15px;font-size:15px;line-height:3.3">지도보기</strong>';
		vHtml += '			<div data-rel="back" id="popBack" style="position: absolute;right: 15px;top: 15px;background: transparent;border: 0;width: 20px;height: 20px;padding: 0;line-height: 0;margin: 0;"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></div>';
		vHtml += '		</div>';
		vHtml += '	</div>';
		vHtml += '	<div id="showMap" style="height:40vh;"></div>';
		vHtml += '</div>';

		$("#popupGeo-popup").append(vHtml);
		$("#popupGeo-popup").hide();
		$("#popupGeo-screen").hide();
		*/
		
		location.reload();
	});
</script>
</head>
<body>
<!--content-->    
	<div role="main" class="ui-content contentWrap">
		<div data-role="navbar" data-iconpos="right" class="nav">
			<ul>
				<!-- <li><a href="#corperatePop" data-rel="popup" data-icon="carat-d" class="ui-nodisc-icon ui-alt-icon">매장안내</a></li> -->
				<li><a href="#" class="layerOpener ui-btn-active ui-nodisc-icon ui-alt-icon" data-icon="carat-d" data-url="/corperatePop.do" data-width="300" data-height="400" data-ok="yes" data-ctn="full">매장안내</a></li>
			</ul>
		</div>
		<div class="shop">
			<div class="search">
				<fieldset>
					<legend>검색</legend>
					<label for="searchTxt">검색어 입력</label> <input type="text" title="검색어를 입력하세요." class="input_m" placeholder="검색어를 입력하세요." id="searchTxt">
					<input type="image" class="btn_search" src="/resources/images/btn/btn_search.gif" alt="검색" title="검색" onclick="fn_shopList()">
				</fieldset>
			</div>
			<!-- 
			<div data-role="navbar" data-iconpos="right" class="tabsnav scTab" style="z-index: 10; width: 100%">
				<ul class="selec">
					<li><a href="#" data-rel="popup" class="ui-btn-active ui-nodisc-icon ui-alt-icon" style="cursor: default;">총 상품 0000개</a></li>
					<li><a href="#selPop" data-rel="popup" class="ui-btn-active ui-nodisc-icon ui-alt-icon">추천상품순</a></li>
				</ul>
			</div>
			 -->
			<div data-role="tabs">
				<div data-role="navbar" class="tabsnav mgT10">
					<ul class="pd10">
						<li><a href="#tab1" data-index="1" data-transition="fade" data-theme="a" data-ajax="false" class="ui-btn-active">전체</a></li>
						<li><a href="#tab3" data-index="3" data-transition="fade" data-theme="a" data-ajax="false">롯데매장</a></li>
						<li><a href="#tab2" data-index="2" data-transition="fade" data-theme="a" data-ajax="false">로드샵</a></li>
					</ul>
				</div>

				<div id="tab1" class="tabContent">
					<!--tab1-->
					<div class="listContent mgT10">
						<div class="reslt_txt">
							<span class="point">전체</span>지역으로 <span class="point" id="allCnt"></span>개의 매장이 검색되었습니다.
						</div>
						<ul data-role="listView" class="storeinfo" id="allShopList">
						
						</ul>
					</div>
					<!--tab1-->
				</div>
				<div id="tab2" class="tabContent">
					<!--tab2-->
					<div class="listContent mgT10">
						<div class="reslt_txt">
							<span class="point">로드샵</span>지역으로 <span class="point" id="roadShopCnt"></span>개의 매장이 검색되었습니다.
						</div>
						<ul data-role="listView" class="storeinfo" id="roadShopList">
						</ul>
					</div>
					<!--tab2-->
				</div>
				<div id="tab3" class="tabContent">
					<!--tab3-->
					<div class="listContent mgT10">
						<div class="reslt_txt">
							<span class="point">롯데매장</span>지역으로 <span class="point" id="lotteShopCnt"></span>개의 매장이 검색되었습니다.
						</div>
						<ul data-role="listView" class="storeinfo" id="lotteShopList">
						</ul>
					</div>
					<!--tab3-->
				</div>
			</div>
			<!--//tabs End-->
		</div>
		<div class="more">
			<a href="#" onclick="fn_moreShopList()"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
		</div>
		
		<a href="#popupGeo" id="googleMapPop" data-rel="popup" data-position-to="window" class="ui-btn ui-corner-all ui-shadow ui-btn-inline" style="display:none;"></a>
		
		<div id="popupGeo" data-role="popup" data-overlay-theme="a" class="ui-content" data-dismissible="false">
			<div style="width:100%;height:50px;">
				<div style="width:100%;height:50px;background-color:#705399;z-index:999">
					<strong style="display:block;padding:0;color:#fff;text-align:left;text-indent:15px;font-size:15px;line-height:3.3">지도보기</strong>
					<div data-rel="back" id="popBack" style="position: absolute;right: 15px;top: 15px;background: transparent;border: 0;width: 20px;height: 20px;padding: 0;line-height: 0;margin: 0;"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></div>
				</div>
			</div>
			<div id="showMap" style="height:40vh;"></div>
		</div>

		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div><!--//contentWrap End-->
</body>