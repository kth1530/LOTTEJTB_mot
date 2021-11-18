<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>

<%
	String tabsNo = "03";

	String custCd = (String) request.getAttribute("cust_cd");

%>
<script type="text/javascript">	
	var flag = false;
	var list = null;
	var listSize = '${listSize}';	
	var totalSize = 0;
	var pageSize = "${pageSize}";
	var orderby = '${orderby}';
	var searchKeyword = '${searchKeyword}';
	var curRow = 0;
	var goodsTypeCd;
	
	// 초기화
	var fn_init = function() {
		document.all.searchKeyword.value = searchKeyword;
		fn_SiteGoodsByAreaList("new", '');
		
	};
	
	var fn_search = function(){
		fn_SiteGoodsByAreaList("new", '');
		
	};
	
	var fn_initSwipper = function() {
		/*
		var categoryThumbs = new Swiper('.category-thumbs', {
			spaceBetween: 0,
			slidesPerView:5,
			touchRatio: 0.2,
			loop:true,
			loopedSlides: 7,
			paginationClickable: true,
			slideToClickedSlide: true
		});
		*/
	}
	// 버튼 초기화
	var fn_initButton = function() {
		
		//console.log("================ 목록 수 체크 ===================");
		//console.log("totalSize : ", totalSize);
		//console.log("list.size : ", list.length);
		//console.log("================ 목록 수 체크 ===================");
	
	
		// 상품 목록 더보기 
		if(curRow < totalSize) {
				document.all.btn_more.style.display="";
		}	else {
				document.all.btn_more.style.display="none";
		}			
	};
			
	
	/* *************************************************************************** */	
	// [Ajax] 데이터 통신 부분 
	
	// 상품 리스트 조회 
	var fn_SiteGoodsByAreaList = function (type, ctg, gdType) {
		// var ctg = document.frmGoodsCtg2.ctg2.value;
		//alert(ctg);
		goodsTypeCd = gdType
		
		orderby =  $(':radio[name="orderby"]:checked').val();
	
		
		if(orderby == "01") {
			//console.log(">>>>>>>>>>>>>>>>>> 추천상품순 정렬");
		}
	
		if(orderby == "02") {
			//console.log(">>>>>>>>>>>>>>>>>> 가격낮은순 정렬");
		}
	
		if(orderby == "03") {
			//console.log(">>>>>>>>>>>>>>>>>> 가격높은순 정렬");
	
		}
	
	
		// 페이지 계산
		if(type == "new"){
			$('#imgGoodsList').empty();
			$('#goodsList').empty();
			
			startRow = 1;
			endRow = pageSize;	
							
		}else{
		
			startRow = curRow + 1;
			endRow = curRow + Number(pageSize);
		}
		
		if(type != "new"){
			if(startRow > totalSize) {
				alert("검색된 상품 리스트가 없습니다.");
				return;
			}
		}
		
		//console.log("curRow  >>> " + curRow);
		//console.log("startRow  >>> " + startRow);
		//console.log("endRow  >>> " + endRow);
		
		searchKeyword = document.all.searchKeyword.value;
		document.all.searchCtg.value = ctg;
	          
		var formData = new FormData();
		formData.append('searchKeyword', searchKeyword);
		formData.append('startRow', startRow);
		formData.append('endRow', endRow);
	   	formData.append('orderby', orderby);
		formData.append('ctg', ctg);
		
		if(nullToBlank(goodsTypeCd) != ""){
			formData.append('goods_type_cd', goodsTypeCd);
		}
		
		cfn_ajax({
			url: "<c:url value='/search/srchGoodsListAjax.do' />",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:"no",
			timeOut: (5*60*1000),
			success: function(res) {
				list = res.list;
				curRow = list.length;
	
				if(list != null) {
					// 이미지 형태 상품 리스트 
					// 이미지 배열 
					var html = "";
	
					for(var i=0; i < list.length; i++) {
						html = html + "	<li>";
						html = html + "		<a href='#' onclick=\"goMaster(\'"+ list[i]["ctg_seq"] + "','"+list[i]["goods_cd"]+"'\)\" style='cursor=hand;'>";
						if(list[i]["save_file_nm"] != null) {
							//html = html + "			<span class='img' style='background-image:url("+"http://www.lottejtb.com" + "/upload/common/goods/" + list[i]["goods_cd"].substring(0,2) + "/"  + list[i]["goods_cd"] + "/" + fn_chgImage(list[i]["save_file_nm"], 'L') +")'></span>";
							html = html + "			<span class='img' style='background-image:url("+"/m_file" + "/upload/common/goods/" + list[i]["goods_cd"].substring(0,2) + "/"  + list[i]["goods_cd"] + "/" + fn_chgImage(list[i]["save_file_nm"], 'L') +")'></span>";
						} else {
							html = html + "			<span class='img' style='background-image:url(/resources/images/bg/noimg.gif)'></span>";
						}
						html = html + "			<h3>" + list[i]["goods_nm"] + "</h3>";
						html = html + "			<span class='holedate'>여행기간 : "+list[i]["goods_night_cnt"]+"박"+list[i]["goods_day_cnt"]+"일</span>";
						// html = html + "			<span class='holedate'>여행기간 : "+list[i]["goods_nights"]+"</span>";
						html = html + "			<span class='startday'>출발요일 : "+list[i]["et_days"]+"</span>";
						html = html + "			<span class='money'><i>"+list[i]["str_adult_price"]+"</i>원~</span>";
						html = html + "		</a>"
						html = html + " </li>";
					}
					
					// //console.log(html);
					// 리스트 형태 상품 리스트 
					$("#imgGoodsList").append(html);
					// 이미지 형태 상품 리스트 
					$("#goodsList").append(html);
				}
	
			},
			error:function(err){
				//console.log(err);
			},
			complete:function(){
				fn_initSwipper();
				$(".img").trigger('create');
				$(".list").trigger('create');
				fn_SiteGoodsSrchsByAreaListCount();
				fn_initButton();
				selectedTab(ctg);
			}
		});
		exeCriteoScript();
	};		
	
	function selectedTab(ctg) {
		var tag = "#"+ctg;
		setTimeout(function(){
			$(tag).addClass("ui-btn-active");
		}, 150);
	}
	
	// 상품  리스트 (카운트)
	var fn_SiteGoodsSrchsByAreaListCount = function(){
		var ctg = document.all.searchCtg.value;
		
		var formData = new FormData();
		formData.append('searchKeyword', searchKeyword);
		formData.append('ctg', ctg);
		
		if(nullToBlank(goodsTypeCd) != ""){
			formData.append('goods_type_cd', goodsTypeCd);
		}
		
		cfn_ajax({
			url: "<c:url value='/search/srchGoodsListCountAjax.do'  />",
			type: "POST",
			data: formData,
			async: false,
			dataType: "json",
			cache: false,
			noloading:"no",
			timeOut: (5*60*1000),
			success: function(res) {
				
				totalSize = res.totalSize;
				
				fn_initButton();
				
				var html = totalSize + "개";
				
				// 총 상품 갯수 표시 
				$("#sp_tagListSize").html(html);
			},
			error:function(err){
				//console.log(err);
			},
			complete:function(){
				$(".img").trigger('create');
			}
		});
	};
	
	// 마스터 페이지로 이동 
	function goMaster(ctg, goodsCd) {
		document.location.href="/goods/master.do?ctg="+ctg+"&goodsCd="+goodsCd;
	}
	
	// (더보기) 상품 리스트 조회 
	var fn_MoreSiteGoodsByAreaList = function() {
	
	
		// 페이지 계산					
		startRow = curRow + 1;
		endRow = curRow + Number(pageSize);
		
		//console.log("curRow  >>> " + curRow);
		//console.log("startRow  >>> " + startRow);
		//console.log("endRow  >>> " + endRow);
		
		searchKeyword = document.all.searchKeyword.value;
		ctg = document.all.searchCtg.value;
	
		orderby =  $(':radio[name="orderby"]:checked').val();
	
		
		if(orderby == "01") {
			//console.log(">>>>>>>>>>>>>>>>>> 추천상품순 정렬");
		}
	
		if(orderby == "02") {
			//console.log(">>>>>>>>>>>>>>>>>> 가격낮은순 정렬");
		}
	
		if(orderby == "03") {
			//console.log(">>>>>>>>>>>>>>>>>> 가격높은순 정렬");
		}
	
	
		var formData = new FormData();
		formData.append('searchKeyword', searchKeyword);
		formData.append('startRow', startRow);
		formData.append('endRow', endRow);
		formData.append('orderby', orderby);
		formData.append('ctg', ctg);
	          
		if(nullToBlank(goodsTypeCd) != ""){
			formData.append('goods_type_cd', goodsTypeCd);
		}
	          
		cfn_ajax({
			type: "POST",
			async: false,
			url: "<c:url value='/search/moreGoodsListAjax.do' />",
			data: formData,
			dataType: "json",
			cache: false,
			noloading:"no",
			timeOut: (5*60*1000),
			success: function(res) {
				list = res.list;
				curRow = curRow + list.length;
	
				var html = "";
				if(list != null) {
					var i;
					for (i = 0; i < list.length; i++) {
						// 이미지 배열 
						html = html + "	<li>";
						html = html + "		<a href='#' onclick=\"goMaster(\'"+ list[i]["ctg_seq"] + "','"+list[i]["goods_cd"]+"'\)\" style='cursor=hand;'>";
						if(list[i]["save_file_nm"] != null) {
							//html = html + "			<span class='img' style='background-image:url("+"http://www.lottejtb.com" + "/upload/common/goods/" + list[i]["goods_cd"].substring(0,2) + "/"  + list[i]["goods_cd"] + "/" + fn_chgImage(list[i]["save_file_nm"], 'L') +")'></span>";
							html = html + "			<span class='img' style='background-image:url("+"/m_file" + "/upload/common/goods/" + list[i]["goods_cd"].substring(0,2) + "/"  + list[i]["goods_cd"] + "/" + fn_chgImage(list[i]["save_file_nm"], 'L') +")'></span>";
						} else {
							html = html + "			<span class='img' style='background-image:url(/resources/images/bg/noimg.gif)'></span>";
						}
						html = html + "			<h3>" + list[i]["goods_nm"] + "</h3>";
						html = html + "			<span class='holedate'>여행기간 : "+list[i]["goods_night_cnt"]+"박"+list[i]["goods_day_cnt"]+"일</span>";
						html = html + "			<span class='startday'>출발요일 : "+list[i]["et_days"]+"</span>";
						html = html + "			<span class='money'><i>"+list[i]["str_adult_price"]+"</i>원~</span>";
						html = html + "		</a>"
						html = html + " </li>";
	
						// //console.log(html);
					}
						
					// 리스트 형태 상품 리스트 
					$("#imgGoodsList").append(html);
					// 이미지 형태 상품 리스트 
					$("#goodsList").append(html);
				}
			},
			error:function(err){
				//console.log(err);
			},
			complete:function(){
				fn_initSwipper();
				$(".img").trigger('create');
				$(".list").trigger('create');
				fn_initButton();
				selectedTab(ctg);
			}
		});
	};		
	// [COMMON] 공통사항 
	$(document).ready(function(){
		//$("body").find("div[data-role=page]").addClass("goods");

		master_init();
		
		fn_init();
		fn_initButton();
	
		// 상품 전시 페이지 CSS 스타일을 맞춰줌 
		$(".bodyWrap").addClass("goods");
	});
		
	// });	
	function toggle_list(id) {
		var e = document.getElementById(id);
			if(e.style.display == 'block') {
				e.style.display = 'none';
				$("#tab1").css("display","block");
				$("#toggleTab").css("background-position", "-15px -11px");
			} else {
				e.style.display = 'block';
				$("#tab1").css("display","none");
				$("#toggleTab").css("background-position", "-15px -56px");
		};
	}	
</script>
</head>
<!--content-->
<div role="main" class="ui-content contentWrap searchBox searchResultDiv" id="top">
	<div  class="list">
		<div class="search">
				<fieldset>
					<legend>검색</legend>
					<label for="input_search">검색어 입력</label>
					<input type="text" title="검색어를 입력하세요." class="input_m"  placeholder="검색어를 입력하세요." id="searchKeyword"  name="searchKeyword" value="" onkeypress="if( event.keyCode==13 ){fn_SiteGoodsByAreaList('new', '');}">
					<input type="hidden" id="searchCtg" name="searchCtg" value="">
					<input type="image" class="btn_search" src="/resources/images/btn/btn_search.gif" alt="검색" title="검색" onclick="fn_SiteGoodsByAreaList('new', '')">
				</fieldset>
		</div>
		<div data-role="navbar" class="srhnav">
			<ul class="selec">
				<li><a href="javascript:void(0);" data-rel="popup"  class="ui-btn-active ui-nodisc-icon ui-alt-icon" style="cursor: default;">총 상품 <span id="sp_tagListSize" name="sp_tagListSize">000개</span></a></li>
				<li><a href="javascript:popGoodsOrderBy()" class="ui-btn-active ui-nodisc-icon ui-alt-icon searchSort" ><span id="sp_orderby" name="sp_orderby">추천상품순</span></a></li>
				<li><a href='javascript:void(0);' class="chgview" id="toggleTab" onclick="toggle_list('tab2');"></a></li>
			</ul>
		</div>
		<div class="tabContent list selWrap">
			<div data-role="navbar" class="tabsnav mgT10">	
				<ul class="pd10">
					<li><a href="javascript:fn_SiteGoodsByAreaList('new', 0);" id="0" class="ui-btn-active">전체</a></li>
					<li><a href="javascript:fn_SiteGoodsByAreaList('new', 5741, 'C,G,L,P,S,T');" id="5741">패키지</a></li>
					<li><a href="javascript:fn_SiteGoodsByAreaList('new', 5807, 'D,J,K');" id="5807">국내</a></li>
					<li><a href="javascript:fn_SiteGoodsByAreaList('new', 5746, 'M');" id="5746">허니문</a></li>
					<li><a href="javascript:fn_SiteGoodsByAreaList('new', 5747, 'E');" id="5747">골프</a></li>				
				</ul>
			</div>
		</div>

		<!-- 리스트 형태 -->
		<div class="tabContent list selWrap" id="tab1">	
			<ul data-role="listView" class="img" id="imgGoodsList"></ul>
		</div>
		<!-- 이미지 배열 형태 -->
		<div class="tabContent list selWrap" id="tab2" style="display: none">
			<ul data-role="listView" class="list" id="goodsList"></ul>
		</div>
		<div class="last">상기 모든 상품 가격은 항공운임(항공권)이 포함된 금액이며,<br/>유류할증료는 유가와 환율에 따라 변동될 수 있습니다.</div>
		<div class="more" id="btn_more"><a href="javascript:fn_MoreSiteGoodsByAreaList()"><i class="fa fa-angle-down fa-2x"></i>더보기</a></div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div><!--tabs End-->
<!-- 정렬 방식  -->       
</div><!--//contentWrap End-->
<!-- 		criteo script -->
		<script type="text/javascript" src="//static.criteo.net/js/ld/ld.js" async="true"></script>
		<script type="text/javascript">
			exeCriteoScript();
			function exeCriteoScript(){
				window.criteo_q = window.criteo_q || [];
				window.criteo_q.push(
				        { event: "setAccount", account: 7995 },
				        { event: "setCustomerId", id: '<%=custCd%>'},
				        { event: "setSiteType", type: "m" },
				        { event: "viewList", item: [], keywords:$('#searchKeyword').val()}
				);
			}
		</script>
<!--//content-->