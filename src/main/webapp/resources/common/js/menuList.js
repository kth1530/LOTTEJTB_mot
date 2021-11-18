
var ctgCodes = "5739,5740,5741,5742,5745,5746,5747,6592,6615";
var menuLink = {
		5741 : "#",					// 패키지
		6592 : "#",					// 핏팩
		6615 : "#",					// 비즈니스석
		5743 : "#",					// 자유
		5744 : "#",					// 항공
		5745 : "#",  				// 호텔 
		5742 : "#",					// 테마
		5746 : "#",					// 허니문
		5747 : "#",					// 골프
		5748 : "#",					// 샤롯데로얄
		5807 : "/domestic/dmt_category_domestic.do?ctg=5807",			// 제주도
		5808 : "/domestic/dmt_category_domestic.do?ctg=5808",			// 내륙/섬
		5809 : "/domestic/dmt_category_domestic.do?ctg=5809",			// 항공
		5810 : "/domestic/dmt_category_domestic.do?ctg=5810",			// 숙박
		5811 : "/domestic/dmt_category_domestic.do?ctg=5811",			// 아!대한민국
		5749 : "/goods/categoryOther.do?ctg=5741&subCtg=5749",							// 유럽/아프리카/인도
		5750 : "/goods/categoryOther.do?ctg=5741&subCtg=5750",							// 동남아
		5751 : "/goods/categoryOther.do?ctg=5741&subCtg=5751",							// 중국
		5752 : "/goods/categoryOther.do?ctg=5741&subCtg=5752",							// 홍콩/대만
		5753 : "/goods/categoryOther.do?ctg=5741&subCtg=5753",							// 일본
		5754 : "/goods/categoryOther.do?ctg=5741&subCtg=5754",							// 괌/사이판/팔라우
		5755 : "/goods/categoryOther.do?ctg=5741&subCtg=5755",							// 호주/뉴질랜드/피지
		5756 : "/goods/categoryOther.do?ctg=5741&subCtg=5756",							// 미주/하와이/중남미
		5759 : "/goods/categoryOther.do?ctg=5741&subCtg=5759",							// 지방출발
		5923 : "/goods/categoryOther.do?ctg=5741&subCtg=5923",							// 부산출발
		5924 : "/goods/categoryOther.do?ctg=5741&subCtg=5924",							// 광주(무안) 출발
		5925 : "/goods/categoryOther.do?ctg=5741&subCtg=5925",							// 대전(청주) 출발
		5926 : "/goods/categoryOther.do?ctg=5741&subCtg=5926",							// 대구출발
		6414 : "/goods/categoryOther.do?ctg=5741&subCtg=6414",										//모바일 전용특가
		5762 : "/goods/list.do?ctg=5762&orderby=01",					// 레이디스 홀리데이
		5763 : "/goods/list.do?ctg=5763&orderby=01",					// 키즈 홀리데이
		5765 : "/goods/list.do?ctg=5765&orderby=01",					// 스페셜여행
		/********************************* 핏팩 ********************************/
		6594 : "/goods/categoryOther.do?ctg=6592&subCtg=6594", 			// 일본
		6600 : "/goods/categoryOther.do?ctg=6592&subCtg=6600", 			// 동남아
		6601 : "/goods/categoryOther.do?ctg=6592&subCtg=6601", 			// 미주
		6602 : "/goods/categoryOther.do?ctg=6592&subCtg=6602", 			// 중국
		6603 : "/goods/categoryOther.do?ctg=6592&subCtg=6603", 			// 유럽
		6621 : "/goods/categoryOther.do?ctg=6592&subCtg=6621", 			// 대양주
		6625 : "/goods/categoryOther.do?ctg=6592&subCtg=6625", 			// 지방출발
		/********************************* 핏팩 ********************************/
		/********************************* 비즈니스 ********************************/
		6616 : "/goods/categoryOther.do?ctg=6615&subCtg=6616", 			// 유럽
		6617 : "/goods/categoryOther.do?ctg=6615&subCtg=6617", 			// 중국
		6624 : "/goods/categoryOther.do?ctg=6615&subCtg=6624", 			// 동남아
		6634 : "/goods/categoryOther.do?ctg=6615&subCtg=6634", 			// 대양주
		/********************************* 비즈니스 ********************************/
		/********************************** 자유여행 *********************************/
		5774 : "/free/main.do",											// 자유여행 만들기
		5775 : "/goods/categoryOther.do?ctg=5743&subCtg=5775",			// 교통패스
		5776 : "/goods/categoryOther.do?ctg=5743&subCtg=5776",			// 현지투어/입장권
		6323 : "/goods/categoryOther.do?ctg=5743&subCtg=6323",			// 에어텔
		/********************************** 자유여행 *********************************/
		/*********************************** 항공 **********************************/
		//6049 : "http://m.air.lottejtb.com/air/b2c/AIR/MBL/AIRMBLTRP0100100010.k1?KSESID=air:b2c:SELK138AX:SELK138AX::09",	// 해외 항공
		//6050 : "http://m.air.lottejtb.com/air/b2c/AIR/MBL/AIRMBLTRP0100100010.k1?domintgubun=D&KSESID=air:b2c:SELK138AX:SELK138AX::09",	// 국내 항공
		6049 : "/goods/categoryOther.do?ctg=5744",	// 해외 항공
		6050 : "/goods/categoryOther.do?ctg=5744",	// 국내 항공
		/*********************************** 항공 **********************************/
		/*********************************** 호텔 **********************************/
		//6339 : '/domestic/dmt_detail_domestic.do?url=http://m.cp.hotelpass.net/search.asp?cp_agent=jtbmo&ctgname=호텔',
		6338 : '/domestic/dmt_detail_domestic.do?url=http://dht.lottejtb.com/alliance/mobile/main.php?AID=LTJTB&ctgname=국내호텔',
		6339 : "6339", //20200110 해외호텔
		//6339 : "/free/main.do?tabType=hotel&domesticYn=N",			// 해외 호텔
		//6338 : "/free/main.do?tabType=hotel&domesticYn=Y",			// 국내 호텔
		6340 :  '/fit/htl/lottehotel.do',//"/goods/categoryOther.do?ctg=5745&subCtg=6340",			// 롯데호텔 & 부여리조트
		6445 :  "/goods/categoryOther.do?ctg=5745&subCtg=6445",
		/*********************************** 호텔 **********************************/
		/*********************************** 국내 **********************************/
		5807 : "/goods/categoryOther.do?ctg=5740&subCtg=5807",			// 제주도
		5808 : "/goods/categoryOther.do?ctg=5740&subCtg=5808",			// 내륙/섬
		5811 : "/goods/list.do?ctg=5811&orderby=01",					// 아!대한민국
		/*********************************** 국내 **********************************/
		/********************************** 허니문 **********************************/
		5789 : "/goods/categoryOther.do?ctg=5746&subCtg=5789",			// 동남아
		5790 : "/goods/categoryOther.do?ctg=5746&subCtg=5790",			// 남태평양
		5791 : "/goods/categoryOther.do?ctg=5746&subCtg=5791",			// 유럽
		5792 : "/goods/categoryOther.do?ctg=5746&subCtg=5792",			// 미주(하와이)
		5793 : "/goods/categoryOther.do?ctg=5746&subCtg=5793",			// 칸쿤/로스카보스
		5794 : "/goods/categoryOther.do?ctg=5746&subCtg=5794",			// 몰디브
		6334 : "/goods/categoryOther.do?ctg=5746&subCtg=6334", 			// 모리셔스 
		5795 : "/goods/categoryOther.do?ctg=5746&subCtg=5795",			// 부산출발
		/********************************** 허니문 **********************************/
		/********************************** 크루즈 **********************************/
		5766 : "/goods/list.do?ctg=5766&orderby=01",					// 크루즈
		5990 : "/goods/list.do?ctg=5990&orderby=01",					// 유럽
		5991 : "/goods/list.do?ctg=5991&orderby=01",					// 미주/중남미
		5992 : "/goods/list.do?ctg=5992&orderby=01",					// 아시아/한중일
		6306 : "/goods/list.do?ctg=6306&orderby=01",					// 특별기획 크루즈
		6296 : "/cruise/cruise_view.do",			// 적립식 크루즈
		/********************************** 크루즈 **********************************/
		6297 : "/goods/list.do?ctg=6297&orderby=01",					// 현지투어/서비스
		/*********************************** 골프 **********************************/
		5799 : "/goods/categoryOther.do?ctg=5747&subCtg=5799",			// 동남아
		5800 : "/goods/categoryOther.do?ctg=5747&subCtg=5800",			// 중국
		5801 : "/goods/categoryOther.do?ctg=5747&subCtg=5801",			// 일본
		5802 : "/goods/list.do?ctg=5802&orderby=01",					// 괌/사이판
		6548 : "/goods/list.do?ctg=6548&orderby=01",					// 국내
		6547 : "/goods/list.do?ctg=6547&orderby=01",					// 프리미엄
		6455 : "/goods/list.do?ctg=6455&orderby=01",					// 지방출발
		6643 : "/goods/list.do?ctg=6643&orderby=01",					// 제주
		/*********************************** 골프 **********************************/
		/********************************* 샤롯데로얄 ********************************/
		6269 : "/goods/categoryOther.do?ctg=5748&subCtg=6269", 			// ROYAL PACKAGE
		6278 : "/goods/categoryOther.do?ctg=5748&subCtg=6278", 			// ROYAL STAY
		/********************************* 샤롯데로얄 ********************************/
		/********************************* 차량서비스 ********************************/
		6649 : "/goods/categoryOther.do?ctg=9999&subCtg=6278", 			// 차량서비스
		/********************************* 차량서비스 ********************************/
};

$(document).ready(function(){
});

var fn_menuClick = function(ctgCodes){
	var formData = new FormData();
	formData.append('ctgCode', ctgCodes);
	
	cfn_ajax({
		url: "/menuList.do",
		type: "POST",
		data: formData,
		async: false,
		cache: false,
		dataType: "json",
		noloading:true,
		success: function(res) {
			var ctgCode = ctgCodes.split(",");
			
			for(var i = 0; i < ctgCode.length; i++){
				try{
					vHTML = "";
					
					for(var j = 0; j < res[ctgCode[i]].length; j++) {
						
						if(res[ctgCode[i]][j]['ctgSeq'] != 5767 || res[ctgCode[i]][j]['ctgSeq'] != '5767'){
							//if(res[ctgCode[i]][j]['ctgSeq'] == 5774){
							//	vHTML += "<li><a href='#' onclick='setAlert(\"서비스 점검중입니다.\"); return false;'>"+ res[ctgCode[i]][j]['ctgNm'] +"</a></li>";
								/*
								if(res[ctgCode[i]][j]['ctgSeq'] == 6338)
									document.location.href='/domestic/dmt_detail_domestic.do?url=http://dht.lottejtb.com/alliance/mobile/main.php?AID=LTJTB&ctgname=국내숙소';
								else if(res[ctgCode[i]][j]['ctgSeq'] == 6339)
									document.location.href='/domestic/dmt_detail_domestic.do?url=http://m.cp.hotelpass.net/search.asp?cp_agent=jtbmo&ctgname=호텔';
								else
								*/
									
							//}else{
								//차량서비스용 _target window.open
								if(res[ctgCode[i]][j]['ctgSeq'] == 6649){
									vHTML += "<li><a href='https://lottejtb.movv.co/' target='_blank'>"+ res[ctgCode[i]][j]['ctgNm'] +"</a></li>";
								}else{									
									vHTML += "<li><a href='#' onclick='moveMenu(\""+ menuLink[res[ctgCode[i]][j]['ctgSeq']] +"\", 2)'>"+ res[ctgCode[i]][j]['ctgNm'] +"</a></li>";
								}
							//}
						}
					}
					
					$("#ctg_lnb_"+ctgCode[i]).html(vHTML);
				}catch(e){
					
				}
			}
			
		},
		error:function(err){
			console.log(err);
		},
		complete:function(){
		}
	});
};

var moveMenu = function(val, type){

	
	if(val=='6339'){
		
		document.location.href = 'https://mhotel2.lottejtb.com:44011/search.asp?hoteltype=0';
		//moveLink('https://mhotel2.lottejtb.com:44011/search.asp?hoteltype=0',  '_system');
		//moveLink('https://mhotel2.lottejtb.com:44011/search.asp?hoteltype=0',  '_blank');
		//window.open('https://mhotel2.lottejtb.com:44011/search.asp?hoteltype=0', "_blank");
		return;
	}
	
	
	/*
	if(type == 1){
		document.location.href = val;
	}else if(type == 2){
		
	}
	*/
	//국내---->숙박인경우 일단 막자.
	if(nullToBlank(val) == "" || val.indexOf("ctg=5810") > -1 || val.indexOf("free") > -1){
		setAlert("서비스 준비중 입니다.");
	}else if(val.indexOf("m.lottejtb.com") > -1){
		document.location.href = val;
	}else{
		document.location.href = "http://m.lottejtb.com"+val;
	}
	
}
