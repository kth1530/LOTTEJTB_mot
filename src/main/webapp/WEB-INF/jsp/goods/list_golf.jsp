<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<%
// 	String grade = (String) request.getAttribute("grade");

String grade = "";
if(request.getAttribute("grade") != null){
	grade = (String) request.getAttribute("grade");
}
//grade = "그룹직원";
%>
<head>
	
<script type="text/javascript" src="//static.criteo.net/js/ld/ld.js" async="true"></script>
<script type="text/javascript">	

        // require(["jquery","jquery.blockUI","jquery.mobile"], function($){
        // require(["jquery","jquery.blockUI"], function($){

		var flag = false;
		var list;
		var listSize = '${listSize}';	
		var totalSize = 0;
		var pageSize = "${pageSize}";
		var ctg = '${ctg}';	
		var orderby = '${orderby}'
		var curRow = 0;
		var grade = "<%=grade%>";
		
	    var goodsCdArr = [];

		// 초기화
		var fn_init = function() {
			// 상품 카테고리 정보 
			fn_goodsCtg2();
			fn_SiteGoodsByAreaList("new");
			fn_SiteGoodsSrchsByAreaListCount();
		};
		
		var fn_search = function(){
			
			fn_SiteGoodsByAreaList("new");
			fn_SiteGoodsSrchsByAreaListCount();			
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
			//console.log("curRow : ", curRow);
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
		
		// 마스터 페이지로 이동 
		function goMaster(goodsCd) {
			document.location.href="/goods/master.do?ctg="+ctg+"&goodsCd="+goodsCd;
		}

		// 지역별 상품 카테고리 리스트 조회 
		var fn_SiteGoodsByAreaList = function (type) {
			// var ctg = document.frmGoodsCtg2.ctg2.value;
			//alert(ctg);
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
				// $(".goodsList").empty();
				
				startRow = 1;
				endRow = pageSize;	
								
			}else{
				startRow = curRow + 1;
				endRow = curRow + Number(pageSize);
			
			}
			
			if(type != "new"){
				if(startRow > totalSize) {
					alert("더이상 등록된 상품이 없습니다");
					return;
				}
			}
			
			//console.log("curRow  >>> " + curRow);
			//console.log("startRow  >>> " + startRow);
			//console.log("endRow  >>> " + endRow);

			var formData = new FormData();
			formData.append('ctg', ctg);
			formData.append('orderby', orderby);
			formData.append('startRow', startRow);
			formData.append('endRow', endRow);

			cfn_ajax({
				url: "<c:url value='/goods/srchSiteGoodsSrchsByAreaListAjax.do' />",
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
							html = html + "		<a href='#' onclick=\"goMaster(\'"+list[i]["goods_cd"]+"'\)\" style='cursor=hand;'>";
							if(list[i]["save_file_nm"] != null) {
								//html = html + "			<span class='img' style='background:url(http://www.lottejtb.com" + "/upload/common/goods/" + list[i]["goods_cd"].substring(0,2) + "/"  + list[i]["goods_cd"] + "/" + fn_chgImage(list[i]["save_file_nm"], 'L') + ")'>";
								html = html + "			<span class='img' style='background:url(/m_file" + "/upload/common/goods/" + list[i]["goods_cd"].substring(0,2) + "/"  + list[i]["goods_cd"] + "/" + fn_chgImage(list[i]["save_file_nm"], 'L') + ")'>";
								if(list[i]["premium_yn"] == 'Y') {
									html = html + "<img src='/resources/images/bg/top_premium.png' alt='' class='sale' />";
								} else if(list[i]["classic_yn"] == 'Y') {
									html = html + "<img src='/resources/images/bg/top_classic.png' alt='' class='sale' />";
								} else if(list[i]["save_yn"] == 'Y') {
									html = html + "<img src='/resources/images/bg/top_save.png' alt='' class='sale' />";
								} 
								html = html + "</span>";
							} else {
								html = html + "			<span class='img' style='background:url(/resources/images/bg/noimg.gif)'>";
								if(list[i]["premium_yn"] == 'Y') {
									html = html + "<img src='/resources/images/bg/top_premium.png' alt='' class='sale' />";
								} else if(list[i]["classic_yn"] == 'Y') {
									html = html + "<img src='/resources/images/bg/top_classic.png' alt='' class='sale' />";
								} else if(list[i]["save_yn"] == 'Y') {
									html = html + "<img src='/resources/images/bg/top_save.png' alt='' class='sale' />";
								} 
								html = html + "</span>";
							}

							html = html + "			<h3>" + list[i]["goods_nm"] + "</h3>";
							
							/*** 임직원 할인가 표시 ***/
							if(grade == "그룹직원" && parseInt(list[i]["emp_rate"]) > 0){	
								//[JEH] 임직원 할인가 계산 - 20190603
								var str_adult_price = list[i]["adult_price2"];
								var emp_rate = parseInt(list[i]["emp_rate"]);
								var emp_amt = (parseInt(str_adult_price) * ((100 - emp_rate) * 0.01)) + parseInt(list[i]["etc_price1"]);

								html = html + "			<span class='holedate' style='top:50px;'>여행기간 : "+list[i]["goods_nights"] + "</span>";
								html = html + "			<span class='startday' style='top:68px;'>출발요일 : "+ list[i]["et_days"].replace(/\|/g, ',') +"</span>";
								html = html + "			<span class='money line-through' style='top:90px;'><i class='line-through' style='font-size: 13px;'>"+list[i]["str_adult_price"]+"</i>원~</span>";
								html = html + "<span class='money' style='color:#cd1d1f;top:105px;'><i style='color:#cd1d1f'>"+addComma(Math.round(emp_amt))+"</i>원~</span>";
							}else{
								html = html + "			<span class='holedate'>여행기간 : "+list[i]["goods_nights"] + "</span>";
								html = html + "			<span class='startday'>출발요일 : "+ list[i]["et_days"].replace(/\|/g, ',') +"</span>";
								html = html + "			<span class='money'><i>"+list[i]["str_adult_price"]+"</i>원~</span>";
							}
							html = html + "		</a>"
							
							//[JEH] 일정표 영상으로 보기 버튼 추가 - 20190410
							if(list[i]["goods_cd"] == 'JBW3001'){
								html = html + "		<a href='javascript:go_youtube();' style='float: right;text-align: right;width: 110px;height: 25px; margin-top: 90px;margin-right: 10px;'><span class='youtube'><img src='/resources/images/ico/icon_TV.png' style='vertical-align: sub;' /> 일정표 영상보기</span></a>";
							}
							
							html = html + " </li>";
							
							goodsCdArr.push(list[i]["goods_cd"]);
							
						}

						//criteo script
						var arrSlice = goodsCdArr.slice(0, 3);
						window.criteo_q = window.criteo_q || [];
						window.criteo_q.push(
								{ event: "setAccount", account: 7995 },
								{ event: "setSiteType", type: "m" },
								{ event: "viewList", item:arrSlice}
						);
						// //console.log(html);
						// 리스트 형태 상품 리스트 
						$("#imgGoodsList").html(html);
						// 이미지 형태 상품 리스트 
						$("#goodsList").html(html);
						

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

				}
			});
		};		
		
		// 지역별 상품 카테고리 리스트 (카운트)
		var fn_SiteGoodsSrchsByAreaListCount = function(type){
			
			// var ctg = document.frmGoodsCtg.ctg.value;
			// alert(ctg);
			var formData = new FormData();
			formData.append('ctg', ctg);

			cfn_ajax({
				url: "<c:url value='/goods/srchSiteGoodsSrchsByAreaListCountAjax.do'  />",
				type: "POST",
				data: formData,
				async: false,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					
					totalSize = res.totalSize;
					
					var html = totalSize + "개";
					
					// //console.log(html);
					
					// 총 상품 갯수 표시 
					$("#sp_tagListSize").html(html);
				},
				error:function(err){
					//console.log(err);
				},
				complete:function(){
					$(".img").trigger('create');
					$(".list").trigger('create');
					fn_initButton();
				}
			});
		};
		
		// (더보기) 지역별 상품 카테고리 리스트 조회 
		var fn_MoreSiteGoodsByAreaList = function () {
			// 페이지 계산
		
			startRow = curRow + 1;
			endRow = curRow + Number(pageSize);
			
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

			//console.log("curRow  >>> " + curRow);
			//console.log("startRow  >>> " + startRow);
			//console.log("endRow  >>> " + endRow);
			

			var formData = new FormData();
			formData.append('ctg', ctg);
			formData.append('orderby', orderby);
			formData.append('startRow', startRow);
			formData.append('endRow', endRow);
			
			cfn_ajax({
				type: "POST",
				async: false,
				url: "<c:url value='/goods/moreSrchSiteGoodsSrchsByAreaListAjax.do'  />",
				data: formData,
				dataType: "json",
				cache: false,
				noloading:"no",
				timeOut: (5*60*1000),
				success: function(res) {
					list2 = res.list;
					curRow = curRow + list2.length;

					var html = "";
					var i;
					if(list2 != null) {

						for (i = 0; i < list2.length; i++) {

							
								// 이미지 배열 
								html = html + "	<li>";
								html = html + "		<a href='#' onclick=\"goMaster(\'"+list2[i]["goods_cd"]+"'\)\" style='cursor=hand;'>";
								if(list2[i]["save_file_nm"] != null) {
									//html = html + "	<span class='img' style='background:url(http://www.lottejtb.com" + "/upload/common/goods/" + list2[i]["goods_cd"].substring(0,2) + "/"  + list2[i]["goods_cd"] + "/" + fn_chgImage(list2[i]["save_file_nm"], 'L') + ")'>";
									html = html + "	<span class='img' style='background:url(/m_file" + "/upload/common/goods/" + list2[i]["goods_cd"].substring(0,2) + "/"  + list2[i]["goods_cd"] + "/" + fn_chgImage(list2[i]["save_file_nm"], 'L') + ")'>";
									if(list2[i]["premium_yn"] == 'Y') {
										html = html + "<img src='/resources/images/bg/top_premium.png' alt='' class='sale' />";
									} else if(list2[i]["classic_yn"] == 'Y') {
										html = html + "<img src='/resources/images/bg/top_classic.png' alt='' class='sale' />";
									} else if(list2[i]["save_yn"] == 'Y') {
										html = html + "<img src='/resources/images/bg/top_save.png' alt='' class='sale' />";
									} 
									html = html + "</span>";
								} else {
									html = html + "	<span class='img' style='background:url(/resources/images/bg/noimg.gif)'>";
									if(list2[i]["premium_yn"] == 'Y') {
										html = html + "<img src='/resources/images/bg/top_premium.png' alt='' class='sale' />";
									} else if(list2[i]["classic_yn"] == 'Y') {
										html = html + "<img src='/resources/images/bg/top_classic.png' alt='' class='sale' />";
									} else if(list2[i]["save_yn"] == 'Y') {
										html = html + "<img src='/resources/images/bg/top_save.png' alt='' class='sale' />";
									} 
									html = html + "</span>";
								}

								html = html + "			<h3>" + list2[i]["goods_nm"] + "</h3>";

								/*** 임직원 할인가 표시 ***/
								if(grade == "그룹직원" && parseInt(list2[i]["emp_rate"]) > 0){	
									//[JEH] 임직원 할인가 계산 - 20190603
									var str_adult_price = list2[i]["str_adult_price"].replaceAll(",", "");
									var emp_rate = parseInt(list2[i]["emp_rate"]);
									var emp_amt = parseInt(str_adult_price) * ((100 - emp_rate) * 0.01);

									html = html + "			<span class='holedate' style='top:50px;'>여행기간 : "+list2[i]["goods_nights"] + "</span>";
									html = html + "			<span class='startday' style='top:68px;'>출발요일 : "+ list2[i]["et_days"].replace(/\|/g, ',') +"</span>";
									html = html + "			<span class='money line-through' style='top:90px;'><i class='line-through'>"+list2[i]["str_adult_price"]+"</i>원~</span>";
									html = html + "<span class='money' style='color:#cd1d1f;top:105px;'><i style='color:#cd1d1f'>"+addComma(emp_amt)+"</i>원~</span>";
								}else{
									html = html + "			<span class='holedate'>여행기간 : "+list2[i]["goods_nights"] + "</span>";
									html = html + "			<span class='startday'>출발요일 : "+ list2[i]["et_days"].replace(/\|/g, ',') +"</span>";
									html = html + "			<span class='money'><i>"+list2[i]["str_adult_price"]+"</i>원~</span>";
								}
								html = html + "		</a>"

								//[JEH] 일정표 영상으로 보기 버튼 추가 - 20190410
								if(list2[i]["goods_cd"] == 'JBW3001'){
									html = html + "		<a href='javascript:go_youtube();' style='float: right;text-align: right;width: 110px;height: 25px; margin-top: 90px;margin-right: 10px;'><span class='youtube'><img src='/resources/images/ico/icon_TV.png' style='vertical-align: sub;'/> 일정표 영상보기</span></a>";
								}
								
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
					fn_initButton();
				}
			});
		};

		function isDuplicated(goods_cd) {
			var i = 0;

			for(i = 0; i < list.length; i++) {

				//console.log("list["+i+" ][goods_cd] : " + list[i]["goods_cd"] + " >>>>>>>>>>>>>>>>>>>> goods_cd " + goods_cd );
				
				var goodsCd = list[i]["goods_cd"];
				if(goodsCd == goods_cd) {

					return true;
				}
			}

			return false;
		}		

		// [COMMON] 공통사항 
		$(document).ready(function(){
			// master_init();
			
			fn_init();
			fn_initButton();
			
			if(ctg == '5811'){
				$("#ctg_depth2_ul").hide();
				$("#ctg_depth3_ul").hide();
			}

			// 상품 전시 페이지 CSS 스타일을 맞춰줌 
			$(".bodyWrap").addClass("goods");
			
			/*document.addEventListener("deviceready", function(){
				fn_init();
				fn_initButton();	
				master_init();
				
			}, false);*/
		});
			
		// });	
		function toggle_visibility(id) {
			var e = document.getElementById(id);
			if(e.style.display == 'block') {
				e.style.display = 'none';
				$("#tab1").css("display","block");
				$(".chgview").css("background-position","-15px -10px");
					
			} else {
				e.style.display = 'block';
				$("#tab1").css("display","none");
				$(".chgview").css("background-position","-15px -53px");
			};
		}  
		
		function go_youtube(){
			window.open("https://youtu.be/8CoCwCjj0p0", "_blank");
		}

		function ifr_resize(iframe) {
			var innerBody = iframe.contentWindow.document.body;
			var innerHeight = innerBody.scrollHeight + (innerBody.offsetHeight - innerBody.clientHeight);
			document.getElementById("if_dtour").height = innerHeight;
		}
		

</script>
</head>

	<!--content-->
	<div role="main" class="ui-content contentWrap" id="top">
		<div style="height:39px"></div>
		<div  class="list prolist" id="content">
			<div data-role="navbar" data-iconpos="right" data-iconpos="right" class="nav">
				<ul id="ctg_depth2_ul">
					<li><a href="#popupGoodsCtg"  data-rel="popup" data-icon="carat-d" onClick="popGoodsCategory1()" class="ui-btn-active ui-nodisc-icon ui-alt-icon"><span id="ctg_depth2" name="ctg_depth2" align="center">선택</span></a></li>
				</ul>  
			</div>
			<!-- 상품 정렬 정보 -->
			<div data-role="navbar" data-iconpos="right" class="tabsnav scTab" style="z-index:20;width:100%">
				<ul id="ctg_depth3_ul">
					<li><a href="#popupGoodsCtg2"  data-rel="popup" data-icon="carat-d" onClick="popGoodsCategory2()" class="ui-btn-active ui-nodisc-icon ui-alt-icon btnBG2"><span id="ctg_depth3" name="ctg_depth3" align="center">선택</span></a></li>
				</ul>
			</div>
			
			<!-- 리스트 형태 -->
			<div class="tabContent list selWrap" id="tab1">
				<iframe  id="if_dtour" name="if_dtour" frameborder="0" marginheight="0" marginwidth="0"  src="https://www.daeonetour.com/openservice/domestic.php?mdId=50" width="100%" height="100%">
				</iframe>
			</div>
			<!-- 이미지 배열 형태 -->
			<div class="tabContent list selWrap" id="tab2" style="display: none">
				<ul data-role="listView" class="list" id="goodsList"></ul>
			</div>
			<div class=""></div>
			<div class="more" id="btn_more" name="btn_more"><a href="javascript:fn_MoreSiteGoodsByAreaList()"><i class="fa fa-angle-down fa-2x"></i>더보기</a></div>
			<!--bottom-->
			<script src="/resources/common/bottom.js"></script>
			<!--bottom-->
		</div><!--tabs End-->
	<!-- 상품 카테고리 DEPTH2 레이어 영역 -->
	<%@ include file="/WEB-INF/jsp/goods/inc_layer_goods_ctg.jsp"%>

	<!-- 정렬 방식  -->
	<%@ include file="/WEB-INF/jsp/goods/inc_layer_goods_orderby.jsp"%>	 
	
	</div><!--//contentWrap End-->
