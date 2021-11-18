<%@page import="com.lottejtb.comm.util.CommInfo"%>
<%@page import="java.util.List"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>

<script src="/resources/common/js/fit/air_search.js"></script>
<script src="/resources/common/js/fit/hotel_search.js"></script>
<script src="/resources/common/js/fit/rentcar_search.js"></script>
<script src="/resources/common/js/fit/common.js"></script>

	<script type="text/javascript" src="//static.criteo.net/js/ld/ld.js" async="true"></script>
	<script type="text/javascript">
	console.log("===============");
	console.log(mstCustCd);
	window.criteo_q = window.criteo_q || [];
	window.criteo_q.push(
	        { event: "setAccount", account: 7995 },
	        { event: "setCustomerId", id:  mstCustCd },
	        { event: "setSiteType", type: "m" },
	        { event: "viewHome" }
	);
	</script>
<style>
	.endReserve{
		position:absolute;
		top:0px;
		color:#FFF;
		text-align:center;
		width:100%;
		background:rgba(255, 0, 0, 0.7);
		font-weight:bold;
		line-height:1.5;
	}
</style>
<script type="text/javascript">
	var pageSize = "${pageSize}";		
	var startRow = 0;
	var endRow = 0;
	
	
	
	var bestGrpCd = "1113_BEST";
	//var bannerGrpCd = "1111_MBLPO,1119_EVENT,1118_PLAN,1114_FREE"
	var bannerGrpCd = "1111_MBLPO,1119_EVENT,1118_PLAN,1212_RANK"
	
	var mainBannerGrpCd = "1111_MBLPO"
	var eventGrpCd = "1119_EVENT";
	var planGrpCd = "1118_PLAN";
	var freeGrpCd = "1114_FREE";
	var rankGrpCd = "1212_RANK";
	
	var adPopGrpCd = "11122_MPOP";
	var timeGoodsGrpCd = "11126_MTP";
	
	var randomTab;
	
	// 초기화
	var fn_init = function() {
		//fn_bestHolidays();
		fn_realRank();
		fn_timeGoods();
		fn_hotGoods();
		fn_codeDetail(bannerGrpCd);
	};
			
	// 버튼 초기화
	var fn_initButton = function(){
	};
	
	var fn_slideSetting = function() {
		/*****메인 상단 롤링이미지*****/
		var gallery = new Swiper('.imgGallery', {
			pagination: '.swiper-pagination',
			spaceBetween: 0,
			loop:true,
			autoplay: 2500,
			nextButton: '.swiper-button-next',
	        prevButton: '.swiper-button-prev'
		});	
		/*****/
		/*****메인 기획전 이벤트 롤링*****/
		var eventBtn = new Swiper('.imgEvent', {
			pagination: '.swiper-pagination2',
			spaceBetween: 10,
			slidesPerView:3,
			paginationClickable: true,
			centeredSlides: true,
			speed:100,
			loop:true,
			loopedSlides: 3
		});
		
		$(".tabsnav li:nth-child(2) a").on("click",function(){
			var planBtn = new Swiper('.imgPlan', {
				pagination: '.swiper-pagination3',
				spaceBetween: 10,
				slidesPerView:3,
				paginationClickable: true,
				centeredSlides: true,
				speed:100,
				loop:true,
				loopedSlides: 3
			});		
		});
		
		tm_swiper = new Swiper('.m_tm_listing', {
			loop:true,
			loopedSlides: 3,
			height:66,
			autoplay: 2500,
			direction: 'vertical'
		});
		
		/*****/
		/*****메인 베스트 홀리데이*****/
		/*
		var bestThumbs = new Swiper('.main-thumbs', {
			spaceBetween: 0,
			slidesPerView:4,
			touchRatio: 0.2,
			speed:100,
			loop:true,
			loopedSlides: 7,      
			paginationClickable: true,
			slideToClickedSlide: true
		});

		var bestContent = new Swiper('.main-content', {
			spaceBetween: 0,
			paginationClickable: true,
			speed:100,
			loop:true,
			loopedSlides: 7,			
			slideToClickedSlide: true
		});
		bestContent.params.control = bestThumbs;
		bestThumbs.params.control = bestContent;
		*/
		/*****/
		/*****메인 자유 홀리데이*****/
		/*
		var btn = new Swiper('.imgFree', {
			pagination: '.swiper-pagination4',
			spaceBetween: 20,
			paginationClickable: true,
			slidesPerView:2,			
			loop:true,
			speed:100,
			loopedSlides: 2
		});
		*/
		/*****/
		
		/* Main Tab */
		/*
		$(".besth").off("tap");
		$(".besth").on("tap",function(){
			var mindex2 = $(this).find(".swiper-slide-active").attr("data-bh");
			var code = $(this).find('.swiper-slide-active').data('cd');

			jQuery(".besthlist ul .swiper-slide").hide();
			jQuery(".besthlist ul:nth-child("+mindex2+")").show();
			
			setTimeout(function(){
				fn_bestSubTab(code);
			}, 10);
		});
		
		$(".bestb").off("tap");
		$(".bestb").on("tap",function(){
			var mindex1 = $(this).find(".swiper-slide-active").attr("data-bh");
			var code = $(this).find('.swiper-slide-active').data('cd');
			
			jQuery(".besthlist ul .swiper-slide").hide();
			jQuery(".besthlist ul:nth-child("+mindex1+")").show();
			
			setTimeout(function(){
				fn_bestSubTab(code);
			}, 10);
		});
		*/
	}
	
	var fn_realRank = function(){
		var formData = new FormData();
		formData.append('division', '11128_RANK');
		formData.append('tabCode', '11128_11');
		
		cfn_ajax({
			url: "<c:url value='/realRanking.do' />",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:"no",
			success: function(res) {
				var list = res.list;
				var vHTML = "";
				
				for(var i = 0; i < list.length; i++){
					if(i % 2 == 0){
						vHTML += '<div class="swiper-slide">';
						vHTML += '	<a href="#" class="nowtime'+ (i + 1) +'" onclick="fn_rankLink(\'5738\',\''+ list[i].goodsCd +'\')">'+ list[i].goodsNm +'</a>';
						
						if(i == (list.length - 1)){
							vHTML += '</div>';
						}
					}else{
						vHTML += '	<a href="#" class="nowtime'+ (i + 1) +'" onclick="fn_rankLink(\'5738\',\''+ list[i].goodsCd +'\')">'+ list[i].goodsNm +'</a>';
						vHTML += '</div>';	
					}
				}
				
				$("#realRanking").html(vHTML);
			},
			error:function(err){
			},
			complete:function(){
			}
		});
	}
	
	var fn_timeGoods = function(){
		var endDateArr = [];
		var tm_gallery;
		var tm_swiper;
		var formData = new FormData();
		formData.append('division', timeGoodsGrpCd);
		
		cfn_ajax({
			url: "<c:url value='/selectTimeGoods.do' />",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:"no",
			success: function(res) {
				var list = res.list;
				var vHTML = "";
				var endDateObject;
				
				if(list.length == 0){
					$("#timeSpecialPrice").hide();
					return false;
				}
				
				for(var i = 0; i < list.length; i++){
					vHTML += '<div class="swiper-slide" id="timeSpecialSub'+ (i+1) +'">';
					vHTML += '	<span onclick="fn_timeGoodsLink(\'0\', \''+ list[i].eventCd1 +'\', \''+ list[i].division +'\', \''+ list[i].tabCode +'\', \''+ list[i].keySeq +'\')" class="m_img" style="background:url('+ list[i].gdImg1 +') center center no-repeat">';
					
					if(list[i].nowDate > list[i].startDate) { 
						vHTML += '		<p class="endReserve">예약마감</p>';
					} else if (parseInt(list[i].rvCnt) >= parseInt(list[i].evInwon)) {
						vHTML += '		<p class="endReserve">예약마감</p>';
					} else if (list[i].evInwon == 0) {
						vHTML += '		<p class="endReserve">예약마감</p>';
					} else if (list[i].procCd != null && list[i].procCd == "RE") {
						vHTML += '		<p class="endReserve">예약마감</p>';						
					}

					vHTML += '		<span>'+ list[i].areaNm +'</span>';
					vHTML += '	</span>';
					vHTML += '	<div class="m_tm_ctnbox" id="mainTime'+ (i + 1) +'">';
					vHTML += '		<table>';
					vHTML += '			<tr>';
					vHTML += '				<td><p>0</p><p>0</p></td>';
					vHTML += '				<td><p>0</p><p>0</p></td>';
					vHTML += '				<td><p>0</p><p>0</p></td>';
					vHTML += '				<td><p>0</p><p>1</p></td>';
					vHTML += '			</tr>';
					vHTML += '			<tr>';
					vHTML += '				<td><span>DAYS</span></td>';
					vHTML += '				<td><span>HRS</span></td>';
					vHTML += '				<td><span>MNS</span></td>';
					vHTML += '				<td><span>SECS</span></td>';
					vHTML += '			</tr>';
					vHTML += '		</table>';
					vHTML += '		<p class="m_tm_ctntitle" onclick="fn_timeGoodsLink(\'0\', \''+ list[i].eventCd1 +'\', \''+ list[i].division +'\', \''+ list[i].tabCode +'\', \''+ list[i].keySeq +'\')">'+ list[i].gdNm1 +'</p>';
					vHTML += '		<p class="m_tm_price" onclick="fn_timeGoodsLink(\'0\', \''+ list[i].eventCd1 +'\', \''+ list[i].division +'\', \''+ list[i].tabCode +'\', \''+ list[i].keySeq +'\')"><span>'+ comma(list[i].gdPrice1) +'</span><em>원</em></p>';
					vHTML += '	</div>';
					vHTML += '</div>';
					
					endDateObject = {
						'day'  : list[i].endDt1,
						'time' : list[i].endTm1
					}
					
					endDateArr.push(endDateObject);
				}
				
				$("#timeSlider").html(vHTML);
				
				tm_gallery = new Swiper('.m_tm_slider', {
					pagination: '.swiper-pagination',
					spaceBetween: 0,
					loop:true,
					autoplay: 25000000
				});
			},
			error:function(err){
			},
			complete:function(){
				<%
				Date systemDatetime = new Date();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
				String serverTime = dateFormat.format(systemDatetime);
				%>
				
				var serverTime = '<%=serverTime%>';
				
				for(var i = 0; i < endDateArr.length; i++){
					getTime(serverTime, endDateArr[i].day +" "+ endDateArr[i].time , (i + 1), tm_gallery);
				}
			}
		});		
	}
	
	var hotGoodsList;
	var hotGoodsCnt;
	var fn_moreGoods = function(){
		var row = $("#hotGoodsItem").children().length;
		startRow = row + 1;
		endRow = pageSize;
		endRow = startRow + parseInt(pageSize);
		
		var hotGoodsLen = hotGoodsCnt;
		if(parseInt(endRow) <= hotGoodsCnt){
			hotGoodsLen = parseInt(endRow);
			$("#hotMoreBtn").show();
		}else{
			
			$("#hotMoreBtn").hide();
		}
		
		var vHTML = "";
		for(var i = row; i < hotGoodsLen; i++){
			vHTML += '<li>';
			if(nullToBlank(hotGoodsList[i].ctgGoods1) == ""){
				vHTML += '	<a href="#" data-role="none" onclick="fn_bestHoilydaysLink(\'0\', \''+ hotGoodsList[i].goodsCd1 +'\', \''+ hotGoodsList[i].division +'\', \''+ hotGoodsList[i].tabCode +'\', \''+ hotGoodsList[i].keySeq +'\')">';
			}else{
				vHTML += '	<a href="#" data-role="none" onclick="fn_bestHoilydaysLink(\''+ hotGoodsList[i].ctgGoods1 +'\', \''+ hotGoodsList[i].goodsCd1 +'\', \''+ hotGoodsList[i].division +'\', \''+ hotGoodsList[i].tabCode +'\', \''+ hotGoodsList[i].keySeq +'\')">';
			}
			
			
			if(nullToBlank(hotGoodsList[i].gdImg1) != ""){
				vHTML += '		<p class="m_img2" style="background:url('+ hotGoodsList[i].gdImg1 +') center center no-repeat">';
			}else{
				vHTML += '		<p class="m_img2" style="background:url('+ hotGoodsList[i].pathServer1 +') center center no-repeat">';
			}
			
			if(nullToBlank(hotGoodsList[i].premiumYn1) == 'Y'){
				vHTML += '			<img src="/resources/images/bg/top_premium.png" class="premium">';
			}else if(nullToBlank(hotGoodsList[i].saveYn1) == 'Y'){
				vHTML += '			<img src="/resources/images/bg/top_save.png" class="sale">';
			}else if(nullToBlank(hotGoodsList[i].classicYn1) == 'Y'){
				vHTML += '			<img src="/resources/images/bg/top_classic.png" class="classic">';
			}
			
			if(nullToBlank(hotGoodsList[i].shortGoodsNm1) != ""){
				vHTML += '			<span><em>'+ nullToBlank(hotGoodsList[i].shortGoodsNm1) +'</em></span>';
			}
			
			vHTML += '		</p>';
			vHTML += '		<dl>';
			vHTML += '			<dt>'+ hotGoodsList[i].cdNm +'</dt>';
			vHTML += '			<dd>';
			vHTML += '				<p class="m_tm_ctntitle">'+ nullToBlank(hotGoodsList[i].gdNm1) +'</p>';
			vHTML += '				<p class="m_tm_price"><span>'+ comma(hotGoodsList[i].gdPrice1) +'</span><em>원 ~</em></p>';
			vHTML += '			</dd>';
			vHTML += '		</dl>';
			vHTML += '	</a>';
			vHTML += '</li>';
		}
		
		$("#hotGoodsItem").append(vHTML);
	}
	
	var fn_hotGoods = function(){
		startRow = 1;
		endRow = pageSize;
		
		var formData = new FormData();
		formData.append('startRow', startRow);
		formData.append('endRow', endRow);
		
		cfn_ajax({
			url: "<c:url value='/selectHotGoods.do' />",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading: "no",
			success: function(res) {
				hotGoodsList = res.list;
				hotGoodsCnt = hotGoodsList.length;
				var vHTML = "";

				var hotGoodsLen = hotGoodsCnt;
				if(parseInt(pageSize) <= hotGoodsCnt){
					hotGoodsLen = pageSize;
					$("#hotMoreBtn").show();
				}else{
					
					$("#hotMoreBtn").hide();
				}

				for(var i = 0; i < hotGoodsLen; i++){
					vHTML += '<li>';
					if(nullToBlank(hotGoodsList[i].ctgGoods1) == ""){
						vHTML += '	<a href="#" data-role="none" onclick="fn_bestHoilydaysLink(\'0\', \''+ hotGoodsList[i].goodsCd1 +'\', \''+ hotGoodsList[i].division +'\', \''+ hotGoodsList[i].tabCode +'\', \''+ hotGoodsList[i].keySeq +'\')">';
					}else{
						vHTML += '	<a href="#" data-role="none" onclick="fn_bestHoilydaysLink(\''+ hotGoodsList[i].ctgGoods1 +'\', \''+ hotGoodsList[i].goodsCd1 +'\', \''+ hotGoodsList[i].division +'\', \''+ hotGoodsList[i].tabCode +'\', \''+ hotGoodsList[i].keySeq +'\')">';
					}
					
					if(nullToBlank(hotGoodsList[i].gdImg1) != ""){
						vHTML += '		<p class="m_img2" style="background:url('+ hotGoodsList[i].gdImg1 +') center center no-repeat">';
					}else{
						vHTML += '		<p class="m_img2" style="background:url('+ hotGoodsList[i].pathServer1 +') center center no-repeat">';
					}
					
					if(nullToBlank(hotGoodsList[i].premiumYn1) == 'Y'){
						vHTML += '			<img src="/resources/images/bg/top_premium.png" class="premium">';
					}else if(nullToBlank(hotGoodsList[i].saveYn1) == 'Y'){
						vHTML += '			<img src="/resources/images/bg/top_save.png" class="sale">';
					}else if(nullToBlank(hotGoodsList[i].classicYn1) == 'Y'){
						vHTML += '			<img src="/resources/images/bg/top_classic.png" class="classic">';
					}
					
					if(nullToBlank(hotGoodsList[i].shortGoodsNm1) != ""){
						vHTML += '			<span><em>'+ nullToBlank(hotGoodsList[i].shortGoodsNm1) +'</em></span>';
					}
					
					vHTML += '		</p>';
					vHTML += '		<dl>';
					vHTML += '			<dt>'+ hotGoodsList[i].cdNm +'</dt>';
					vHTML += '			<dd>';
					vHTML += '				<p class="m_tm_ctntitle">'+ nullToBlank(hotGoodsList[i].gdNm1) +'</p>';
					vHTML += '				<p class="m_tm_price"><span>'+ comma(hotGoodsList[i].gdPrice1) +'</span><em>원 ~</em></p>';
					vHTML += '			</dd>';
					vHTML += '		</dl>';
					vHTML += '	</a>';
					vHTML += '</li>';
				}
				
				$("#hotGoodsItem").append(vHTML);
			},
			error:function(err){
			},
			complete:function(){
			}
		});
	}
	
	var fn_bestHolidays = function(){
		var firstCode = "";
		var firstIndex;
		
		var formData = new FormData();
		formData.append('grpCd', bestGrpCd);
		
		cfn_ajax({
			url: "<c:url value='/codeDetailList.do' />",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:"no",
			success: function(res) {
				var list = res.list;
				
				var vHTML = "";
				var vSubHTML = "";
				randomTab = Math.floor(Math.random() * (list.length))
				
				var x;
				var j = 0;
				
				for(var i = randomTab; i < (list.length + randomTab); i++){
					x = i;
					
					if(x >= list.length){
						x = x - list.length;
					}
					
					if(i == randomTab){
						vHTML += '<div data-bh="'+ (x + 1) +'" data-cd="'+ list[x].cd +'" class="swiper-slide swiper-slide-active">'+ list[x].cdNm +'</div>';
						firstCode = list[x].cd;
					}else{
						vHTML += '<div data-bh="'+ (x + 1) +'" data-cd="'+ list[x].cd +'" class="swiper-slide">'+ list[x].cdNm +'</div>';
					}
					
					vSubHTML += '<div class="swiper-slide" class="bestTabList" data-bh="'+ (x + 1) +'" data-cd="'+ list[x].cd +'">';
					vSubHTML += '	<ul data-role="listView" class="list tab_'+ list[x].cd +'">';
					vSubHTML += '		<img src="/resources/images/bg/sloader.gif" style="margin:39% 0 0 46%"/>';
					vSubHTML += '	</ul>';
					vSubHTML += '</div>';
				}
				
				$("#bestHolidayTitle").html(vHTML);
				$("#bestHolidayDtl").append(vSubHTML);
			},
			error:function(err){
			},
			complete:function(){
				fn_errorImage();
				fn_bestSubTab(firstCode, true);
			}
		});
	}
	
	var fn_bestSubTab = function(code, firstYn){
		if(nullToBlank($(".tab_"+ code).data('disp_yn')) != "Y"){
			var formData = new FormData();
			formData.append('grpCd', bestGrpCd);
			formData.append('tabCode', code);
			
			cfn_ajax({
				url: "<c:url value='/bestDetailList.do' />",
				type: "POST",
				data: formData,
				async: false,
				cache: false,
				dataType: "json",
				noloading:"no",
				success: function(res) {
					var list = res.list;
					var vHTML = "";
					
					for(var i = 0; i < list.length; i++){
						vHTML += '<li>';
						if(nullToBlank(list[i].ctgGoods1) == ""){
							vHTML += '	<a href="#" onclick="fn_bestHoilydaysLink(\'0\', \''+ list[i].goodsCd1 +'\', \''+ list[i].division +'\', \''+ list[i].tabCode +'\', \''+ list[i].keySeq +'\')">';
						}else{
							vHTML += '	<a href="#" onclick="fn_bestHoilydaysLink(\''+ list[i].ctgGoods1 +'\', \''+ list[i].goodsCd1 +'\', \''+ list[i].division +'\', \''+ list[i].tabCode +'\', \''+ list[i].keySeq +'\')">';
						}
						if(nullToBlank(list[i].gdImg1) != ""){
							vHTML += '		<div class="img bestClass" style="background:url('+ list[i].gdImg1 +')">';
						}else{
							vHTML += '		<div class="img bestClass" style="background:url('+ list[i].pathServer1 +')">';
						}
						if(nullToBlank(list[i].premiumYn1) == 'Y'){
							vHTML += '			<img src="/resources/images/bg/top_premium.png" class="premium">';
						}else if(nullToBlank(list[i].saveYn1) == 'Y'){
							vHTML += '			<img src="/resources/images/bg/top_save.png" class="sale">';
						}else if(nullToBlank(list[i].classicYn1) == 'Y'){
							vHTML += '			<img src="/resources/images/bg/top_classic.png" class="classic">';
						}
						
						if(nullToBlank(list[i].shortGoodsNm1) != ""){
							vHTML += '			<p><span>'+ list[i].shortGoodsNm1 +'</span></p>';
						}
						vHTML += '		</div>';
						vHTML += '		<h3>'+ list[i].description1 +'</h3>';
						vHTML += '		<span class="money"><i>'+ comma(list[i].gdPrice1) +'</i>원~</span>';
						vHTML += '	</a>';
						vHTML += '</li>';
					}
					
					$(".tab_"+ code).data('disp_yn', 'Y');
					$(".tab_"+ code).html(vHTML);
					//$("#tab_"+ code).show();
				},
				error:function(err){
				},
				complete:function(){
					fn_errorImage();
				}
			});
		}else{
		}
	}
	
	var fn_errorImage = function(){
		$(".bestClass").each(function(){
			if(this.style.backgroundImage == 'url("null")'){
				this.style.backgroundImage = 'url("resources/images/bg/noimg.gif")';
			}
		})
	}
	
	var fn_bestHolidayDetail = function(dataList){
		var vHTML = "";
		
		vHTML += '<div class="swiper-slide">';
		vHTML += '	<ul data-role="listView" class="list">'
		
		for(var x = 0; x < dataList.length; x++){
			vHTML += '<li>';
			if(nullToBlank(dataList[x].ctgGoods1) == ""){
				vHTML += '	<a href="#" onclick="fn_bestHoilydaysLink(\'0\', \''+ dataList[x].goodsCd1 +'\', \''+ dataList[i].division +'\', \''+ dataList[i].tabCode +'\', \''+ dataList[i].keySeq +'\')">';
			}else{
				vHTML += '	<a href="#" onclick="fn_bestHoilydaysLink(\''+ dataList[x].ctgGoods1 +'\', \''+ dataList[x].goodsCd1 +'\', \''+ dataList[i].division +'\', \''+ dataList[i].tabCode +'\', \''+ dataList[i].keySeq +'\')">';
			}
			if(nullToBlank(list[i].gdImg1) != ""){
				vHTML += '		<div class="img bestClass" style="background:url('+ list[i].gdImg1 +')">';
			}else{
				vHTML += '		<div class="img bestClass" style="background:url('+ list[i].pathServer1 +')">';
			}
			if(nullToBlank(dataList[x].premiumYn1) == 'Y'){
				vHTML += '			<img src="/resources/images/bg/top_premium.png" class="premium">';
			}else if(nullToBlank(dataList[x].saveYn1) == 'Y'){
				vHTML += '			<img src="/resources/images/bg/top_save.png" class="sale">';
			}else if(nullToBlank(dataList[x].classicYn1) == 'Y'){
				vHTML += '			<img src="/resources/images/bg/top_classic.png" class="classic">';
			}
			if(nullToBlank(dataList[x].shortGoodsNm1) != ""){
				vHTML += '			<p><span>'+ dataList[x].shortGoodsNm1 +'</span></p>';
			}
			vHTML += '		</div>';
			vHTML += '		<h3>'+ dataList[x].description1 +'</h3>';
			vHTML += '		<span class="money"><i>'+ comma(dataList[x].gdPrice1) +'</i>원~</span>';
			vHTML += '	</a>';
			vHTML += '</li>';
		}
		
		vHTML += '	</ul>';
		vHTML += '</div>';
		
		$("#bestHolidayDtl").append(vHTML);
	}
	
	var fn_codeDetail = function(grdCode, code){
		var list;
		
		var formData = new FormData();
		formData.append('division', grdCode);
		if(nullToBlank(code) != ""){
			formData.append('tabCode', code);
		}
		
		cfn_ajax({
			url: "<c:url value='/bannerList.do' />",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:"no",
			success: function(res) {
				list = res;
			},
			error:function(err){
			},
			complete:function(){
				fn_bannerList(list);
			}
		});
	}
	
	var fn_bannerList = function(list){
		try{
			var mainBannerList = list[mainBannerGrpCd];
		}catch(e){
			var mainBannerList = "";
		}
		
		try{
			var eventList = list[eventGrpCd];	
		}catch(e){
			var eventList = "";
		}
		
		try{
			var planList = list[planGrpCd];
		}catch(e){
			var planList = "";
		}
		
		try{
			var freeList = list[freeGrpCd];				
		}catch(e){
			var freeList = "";
		}
		
		/*
		try{
			var rankList = list[rankGrpCd];
		}catch(e){
			var rankList = "";
		}
		*/
		
		var mainBannerHTML = "";
		var eventHTML = "";
		var planHTML = "";
		var freeHTML = "";
		var rankHTML = "";
		
		if(nullToBlank(mainBannerList) != ""){
			for(var i = 0; i < mainBannerList.length; i++){
				mainBannerHTML += '<div class="swiper-slide" onclick="fn_moveMbl(\''+ mainBannerList[i].linkUrl1 +'\', \''+ mainBannerList[i].division +'\', \''+ mainBannerList[i].tabCode +'\', \''+ mainBannerList[i].keySeq +'\')">';
				mainBannerHTML += '	<img src="'+ mainBannerList[i].pathServer1 +'" onerror="javascript:noimg_setting(this, 3);" >';
				/*
				mainBannerHTML += '	<div class="price">';
				mainBannerHTML += '		<span>'+ mainBannerList[i].gdPrice1 +'</span><em>원~</em>';
				mainBannerHTML += '	</div>';
				*/
				mainBannerHTML += '</div>';
			}
		}
		
		if(nullToBlank(eventList) != ""){
	 		for(var i = 0; i < eventList.length; i++){
				eventHTML += '<div class="swiper-slide">';
				eventHTML += '	<a href="#" onclick="fn_moveEvent(\''+ eventList[i].linkUrl1 +'\', \''+ eventList[i].division +'\', \''+ eventList[i].tabCode +'\', \''+ eventList[i].keySeq +'\')">';
				eventHTML += '		<img src="'+ eventList[i].pathServer1 +'">';
				eventHTML += '	</a>';
				eventHTML += '</div>';
			}
		}
		
		if(nullToBlank(planList) != ""){
			for(var i = 0; i < planList.length; i++){
				planHTML += '<div class="swiper-slide">';
				planHTML += '	<a href="#" onclick="fn_movePlan(\''+ planList[i].linkUrl1 +'\')">';
				planHTML += '		<img src="'+ planList[i].bgPathServer1 +'">';
				planHTML += '	</a>';
				planHTML += '</div>';
			}
		}
		
		/*
		if(nullToBlank(freeList) != ""){
			for(var i = 0; i < freeList.length; i++){
				freeHTML += '<div class="swiper-slide">';
				if(nullToBlank(freeList[i].linkUrl2) != ""){
					freeHTML += '	<img src="'+ freeList[i].pathServer1 +'" onerror="javascript:noimg_setting(this, 3);" onclick="fn_moveFree(\''+ freeList[i].linkUrl2.trim() +'\')">';
				}else{
					freeHTML += '	<img src="'+ freeList[i].pathServer1 +'" onerror="javascript:noimg_setting(this, 3);")">';
				}
				freeHTML += '</div>';
			}
		}
		*/
		/*
		if(nullToBlank(rankList) != ""){
			for(var i = 0; i < rankList.length; i++){
				if(i % 2 == 0){
					rankHTML += '<div class="swiper-slide">';
					rankHTML += '	<a href="#" class="nowtime'+ (i + 1) +'" onclick="fn_rankLink(\'0\',\''+ rankList[i].goodsCd1 +'\')">'+ rankList[i].gdNm1 +'</a>';
					
					if(i == (rankList.length - 1)){
						rankHTML += '</div>';
					}
				}else{
					rankHTML += '	<a href="#" class="nowtime'+ (i + 1) +'" onclick="fn_rankLink(\'0\',\''+ rankList[i].goodsCd1 +'\')">'+ rankList[i].gdNm1 +'</a>';
					rankHTML += '</div>';	
				}
			}
		}
		*/	
		$("#mainBannerSlider").html(mainBannerHTML);
		$("#eventSlider").html(eventHTML);
		$("#planSlider").html(planHTML);
		//$("#freeSlider").html(freeHTML);
		//$("#realRanking").html(rankHTML);
		
		setTimeout(function(){
			fn_slideSetting();
			
			if(accessType == "app"){
				var adAgree = window.localStorage.getItem("adAgreement");
				
				if(nullToBlank(adAgree) == ""){
					setTimeout(function(){
						setConfirm(
							"롯데제이티비에서 해당 기기로 영리목적 광고성 정보를 전송하려고 합니다.\n 해당 설정은 롯데제이티비 APP > 좌측메뉴 하단 > 설정에서 변경 가능합니다.", 
							function(){
								agreePopup('Y');
							},
							function(){
								agreePopup('N');
							},
							"광고성정보 수신동의",
							"동의함",
							"동의안함"
						);
					}, 500);
				};
			};
		}, 200);
	};
	
	var fn_rankLink = function(ctg, goodCd){
		location.href = "/goods/master.do?ctg="+ ctg +"&goodsCd="+ goodCd;
	}
	
	var fn_bestHoilydaysLink = function(ctg, goodCd, division, tabCode, keySeq){
		var formData = new FormData();
		formData.append('division', division);
		formData.append('tabCode', tabCode);
		formData.append('keySeq', keySeq);
		
		cfn_ajax({
			url: "<c:url value='/updateHitCount.do' />",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:"no",
			success: function(res) {

			},
			error:function(err){
			},
			complete:function(){
				location.href = "/goods/master.do?ctg="+ ctg +"&goodsCd="+ goodCd;
			}
		});
	}
	
	var fn_timeGoodsLink = function(ctg, goodCd, division, tabCode, keySeq){
		var formData = new FormData();
		formData.append('division', division);
		formData.append('tabCode', tabCode);
		formData.append('keySeq', keySeq);
		
		cfn_ajax({
			url: "<c:url value='/updateHitCount.do' />",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:"no",
			success: function(res) {

			},
			error:function(err){
			},
			complete:function(){
				location.href = "/goods/detail_goods.do?ctg="+ ctg +"&eventCd="+ goodCd;
			}
		});
	}
	
	var fn_moveEvent = function(linkUrl, division, tabCode, keySeq){
		//location.href = "/event/event_list.do?eventSeq="+ goodsCd1;
		
		var formData = new FormData();
		formData.append('division', division);
		formData.append('tabCode', tabCode);
		formData.append('keySeq', keySeq);
		
		cfn_ajax({
			url: "<c:url value='/updateHitCount.do' />",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:"no",
			success: function(res) {

			},
			error:function(err){
			},
			complete:function(){
				//[JEH] 링크 이동시 https 일경우 화면멈춤 현상으로 인해 받은링크 그대로 넘기도록 수정 - 20190624
				location.href = linkUrl;
// 				location.href = linkUrl.replace("http://m.lottejtb.com", "");
			}
		});
	}
	
	var fn_movePlan = function(linkUrl){
		/*
		var planSeq = linkUrl.split('?')[1].split('=')[1]
		
		location.href = "/planning/planning_detail.do?plan_seq="+ planSeq;
		*/

		//[JEH] 링크 이동시 https 일경우 화면멈춤 현상으로 인해 받은링크 그대로 넘기도록 수정 - 20190624
		location.href = linkUrl;
// 		location.href = linkUrl.replace("http://m.lottejtb.com", "");
	}
	
	var fn_moveFree = function(linkUrl){
		//[JEH] 링크 이동시 https 일경우 화면멈춤 현상으로 인해 받은링크 그대로 넘기도록 수정 - 20190624
		window.location.href = linkUrl;
// 		window.location.href = linkUrl.replace("http://m.lottejtb.com", "");
		/*
		if(linkUrl.indexOf('http://') == 0 || linkUrl.indexOf('https://') == 0){
			window.location.href = linkUrl;
		}else{
			try{
				var planSeq = linkUrl.split('?')[1].split('=')[1];
				
				location.href = "/planning/planning_detail.do?plan_seq="+ planSeq;
			}catch(e){}
		}
		*/
	}
	
	var fn_moveMbl = function(linkUrl, division, tabCode, keySeq){
		var formData = new FormData();
		formData.append('division', division);
		formData.append('tabCode', tabCode);
		formData.append('keySeq', keySeq);
		
		cfn_ajax({
			url: "<c:url value='/updateHitCount.do' />",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:"no",
			success: function(res) {

			},
			error:function(err){
			},
			complete:function(){
				//[JEH] 링크 이동시 https 일경우 화면멈춤 현상으로 인해 받은링크 그대로 넘기도록 수정 - 20190624
				location.href = linkUrl;
// 				location.href = linkUrl.replace("http://m.lottejtb.com", "");
			}
		});
		
		
	}
	
	var mainAdPop = function(){
		jQuery("body").bind('touchmove', function(e){e.preventDefault()}); //터치방지
		var winh = jQuery(window).height();
		var poph = jQuery(".main_pop").height();
		var wpcenter = winh/2 - poph/2;
		jQuery(".mian_popbox").css({"padding-top":wpcenter+"px"});
		
		jQuery(".main_pop .mpop_close").off("click");
		jQuery(".main_pop .mpop_close").on("click", function(){
			if(jQuery(".main_pop #mpop_chk").is(":checked")){
				var adDate = new Date();
				adDate = adDate.format("yyyy.MM.dd");
				
				window.localStorage.setItem('mainAdPop', adDate);
			}else{
				window.localStorage.removeItem('mainAdPop');
			}
				
			jQuery(".mian_popbox").hide();
			jQuery("body").unbind('touchmove'); //터치방지해지
		});
		return false;
	};
	
	//검색하기
	function fn_goSelPage() {
		var frm_action = '';
		var selAir = 'N';
		var selHotel = 'N';
		var selRentcar = 'N';
		
		//var useAir =  $("input:checkbox[id='aircheck']").is(":checked");
		//var useHotel = $("input:checkbox[id='hotelcheck']").is(":checked");
		//var useRentcar = $("input:checkbox[id='carcheck']").is(":checked");
		
		var freeIndex = $("#mainFreeTab").find('.active').index();
		
		switch(freeIndex){
		case 0:
			$('#selAir').val('Y');
			if(fn_set_air_search_value()){	//validation 유효성 체크
				selAir = 'Y';
				//frm_action = '/free/search_result_air.do';
				if($("div[ft-att=RTGroup]").find("#srch_dep_naCd").val() == "KR" && $("div[ft-att=RTGroup]").find("#srch_arr_naCd").val() == "KR"){
					frm_action = 'https://m.air.lottejtb.com/air/b2c/AIR/MBL/AIRMBLSCH0100100090.k1';
				}else{
					frm_action = 'https://m.air.lottejtb.com/air/b2c/AIR/MBL/AIRMBLSCH0100100010.k1';	
				}
			} else {
				return;
			}
			break;
		case 1:
			$('#selHotel').val('Y');
			if(fn_set_hotel_search_value()){	//validation 유효성 체크
				if(frm_action == '') {
					selHotel = 'Y';
					frm_action = '/free/search_result_hotel.do';	
				}	
			} else {
				return;
			}
			break;
		case 2:
			$('#selRentcar').val('Y');
			if(fn_set_rentcar_search_value()){
				if(frm_action == '') {
					selRentcar = 'Y';

					frm_action = '/free/search_result_rentcar_office.do';	
				}
			}else{
				return;
			}
			break;
		default :
			break;
		}

		if(frm_action == '') {
			setAlert('검색할 항목을 선택해 주세요.');
			return;
		} else {
			if(selAir == 'Y'){
				if($("div[ft-att=RTGroup]").find("#srch_dep_naCd").val() == "KR" && $("div[ft-att=RTGroup]").find("#srch_arr_naCd").val() == "KR"){
					//document.location.href = frm_action + '?initform=RT&domintgubun=D&depctycd='+ $("div[ft-att=RTGroup]").find("#srch_dep_ct").text() +'&depctycd='+ $("div[ft-att=RTGroup]").find("#srch_arr_ct").text() +'&arrctycd='+ $("div[ft-att=RTGroup]").find("#srch_arr_ct").text() +'&arrctycd='+ $("div[ft-att=RTGroup]").find("#srch_dep_ct").text() +'&depctynm='+ $("div[ft-att=RTGroup]").find("#srch_dep_ct_dis").text() +'&depctynm='+ $("div[ft-att=RTGroup]").find("#srch_arr_ct_dis").text() +'&arrctynm='+ $("div[ft-att=RTGroup]").find("#srch_arr_ct_dis").text() +'&arrctynm='+ $("div[ft-att=RTGroup]").find("#srch_dep_ct_dis").text() +'&depdt='+ $("div[ft-att=RTGroup]").find("#dep_dt").text().replace(/\./g, '-') +'&depdt='+ $("div[ft-att=RTGroup]").find("#arr_dt").text().replace(/\./g, '-') +'&opencase=N&openday=&tasktype=B2C&adtcount='+ $("div[ft-att=RTGroup]").find("#adtCnt").text() +'&chdcount='+ $("div[ft-att=RTGroup]").find("#chdCnt").text() +'&infcount='+ $("div[ft-att=RTGroup]").find("#infCnt").text() +'&cabinclass='+ $("div[ft-att=RTGroup]").find("#cabinClas :selected").val() +'&preferaircd=&maxprice=&availcount=250&deptmam=&deptmpm=&nonstop=&KSESID=air:b2c:SELK138AX:SELK138AX:00:00'
					moveLink(frm_action + '?initform=RT&domintgubun=D&depctycd='+ $("div[ft-att=RTGroup]").find("#srch_dep_ct").text() +'&depctycd='+ $("div[ft-att=RTGroup]").find("#srch_arr_ct").text() +'&arrctycd='+ $("div[ft-att=RTGroup]").find("#srch_arr_ct").text() +'&arrctycd='+ $("div[ft-att=RTGroup]").find("#srch_dep_ct").text() +'&depctynm='+ $("div[ft-att=RTGroup]").find("#srch_dep_ct_dis").text() +'&depctynm='+ $("div[ft-att=RTGroup]").find("#srch_arr_ct_dis").text() +'&arrctynm='+ $("div[ft-att=RTGroup]").find("#srch_arr_ct_dis").text() +'&arrctynm='+ $("div[ft-att=RTGroup]").find("#srch_dep_ct_dis").text() +'&depdt='+ $("div[ft-att=RTGroup]").find("#dep_dt").text().replace(/\./g, '-') +'&depdt='+ $("div[ft-att=RTGroup]").find("#arr_dt").text().replace(/\./g, '-') +'&opencase=N&openday=&tasktype=B2C&adtcount='+ $("div[ft-att=RTGroup]").find("#adtCnt").text() +'&chdcount='+ $("div[ft-att=RTGroup]").find("#chdCnt").text() +'&infcount='+ $("div[ft-att=RTGroup]").find("#infCnt").text() +'&cabinclass='+ $("div[ft-att=RTGroup]").find("#cabinClas :selected").val() +'&preferaircd=&maxprice=&availcount=250&deptmam=&deptmpm=&nonstop=&KSESID=air:b2c:SELK138AX:SELK138AX:00:00', '_system');
				}else{
					//document.location.href = frm_action + '?initform=RT&domintgubun=I&depctycd='+ $("div[ft-att=RTGroup]").find("#srch_dep_ct").text() +'&depctycd='+ $("div[ft-att=RTGroup]").find("#srch_arr_ct").text() +'&depctycd=&depctycd=&arrctycd='+ $("div[ft-att=RTGroup]").find("#srch_arr_ct").text() +'&arrctycd='+ $("div[ft-att=RTGroup]").find("#srch_dep_ct").text() +'&arrctycd=&arrctycd=&depdt='+ $("div[ft-att=RTGroup]").find("#dep_dt").text().replace(/\./g, '-') +'&depdt='+ $("div[ft-att=RTGroup]").find("#arr_dt").text().replace(/\./g, '-') +'&depdt=&depdt=&adtcount='+ $("div[ft-att=RTGroup]").find("#adtCnt").text() +'&chdcount='+ $("div[ft-att=RTGroup]").find("#chdCnt").text() +'&infcount='+ $("div[ft-att=RTGroup]").find("#infCnt").text() +'&cabinclass='+ $("div[ft-att=RTGroup]").find("#cabinClas :selected").val() +'&preferaircd=&availcount=250&opencase=N&opencase=N&opencase=N&openday=&openday=&openday=&depdomintgbn=D&tasktype=B2C&secrchType=FARE&maxprice=&KSESID=air:b2c:SELK138AX:SELK138AX:00:00';
					moveLink(frm_action + '?initform=RT&domintgubun=I&depctycd='+ $("div[ft-att=RTGroup]").find("#srch_dep_ct").text() +'&depctycd='+ $("div[ft-att=RTGroup]").find("#srch_arr_ct").text() +'&depctycd=&depctycd=&arrctycd='+ $("div[ft-att=RTGroup]").find("#srch_arr_ct").text() +'&arrctycd='+ $("div[ft-att=RTGroup]").find("#srch_dep_ct").text() +'&arrctycd=&arrctycd=&depdt='+ $("div[ft-att=RTGroup]").find("#dep_dt").text().replace(/\./g, '-') +'&depdt='+ $("div[ft-att=RTGroup]").find("#arr_dt").text().replace(/\./g, '-') +'&depdt=&depdt=&adtcount='+ $("div[ft-att=RTGroup]").find("#adtCnt").text() +'&chdcount='+ $("div[ft-att=RTGroup]").find("#chdCnt").text() +'&infcount='+ $("div[ft-att=RTGroup]").find("#infCnt").text() +'&cabinclass='+ $("div[ft-att=RTGroup]").find("#cabinClas :selected").val() +'&preferaircd=&availcount=250&opencase=N&opencase=N&opencase=N&openday=&openday=&openday=&depdomintgbn=D&tasktype=B2C&secrchType=FARE&maxprice=&KSESID=air:b2c:SELK138AX:SELK138AX:00:00', '_system');
				}
			}else{
				document.location.href = frm_action + '?selAir='+selAir+"&selHotel="+selHotel + "&selRentcar="+selRentcar;
			}

		}
		
	}
	
	var fn_adPopMove = function(division, tabCode, keySeq, url){
		var formData = new FormData();
		
		formData.append('division', division);
		formData.append('tabCode', tabCode);
		formData.append('keySeq', keySeq);
		
		 cfn_ajax({
			url: "<c:url value='/updateHitCount.do' />",
			type: "POST",
			data: formData,
			async: false,
			cache: false,
			dataType: "json",
			noloading:"no",
			success: function(res) {

			},
			error:function(err){
			},
			complete:function(){
				location.href = url;
			}
		}); 
	}
	
	/* var fn_service = function() {
		alert("서비스 점검 중입니다.");
		return;
	} */
	
	$(document).ready(function(){
		fn_init();
		fn_initButton();
		
		var autoLogin = window.localStorage.getItem("autoLogin");
		if(nullToBlank(mstCustCd) == "" && (autoLogin == 'N' || nullToBlank(autoLogin) == "")){
			var thisLink = "http://m.lottejtb.com/jsp/sso/loginSuccess.do";
			//document.write('<' + 'script src="http://member.lpoint.com/door/sso/MLOTTEJTB/checkLogin.jsp?returnurl='+ thisLink +'"' + ' language="JavaScript" type="text/javascript"><' + '/script>');
		}
		
		sessionStorage.domesticYn = "";
		
		var popShowDate = window.localStorage.getItem('mainAdPop');
		var nowDate = new Date();
		nowDate = nowDate.format('yyyy.MM.dd');
		
		if(popShowDate != nowDate){
			var formData = new FormData();
			formData.append('division', adPopGrpCd);
			
			var popYn = false;
			
			cfn_ajax({
				url: "<c:url value='/selectAdPop.do' />",
				type: "POST",
				data: formData,
				async: false,
				cache: false,
				dataType: "json",
				noloading:"no",
				success: function(res) {
					var result = res.result;
					
					if(nullToBlank(result) != ""){
						popYn = true;
						
						$("#adPopImg").attr("src", result.pathServer1);
						//$("#adPopImg").attr("onclick", "fn_adPopMove('"+ result.linkUrl1 +"')");
						$("#adPopImg").attr("onclick", 'fn_adPopMove(\''+ result.division +'\', \''+ result.tabCode +'\', \''+ result.keySeq +'\',\''+ result.linkUrl1 +'\')');
						
						
					}
				},
				error:function(err){
				},
				complete:function(){
					if(popYn){
						$("#mainAdPop").show();
						setTimeout(function(){
							mainAdPop();
						}, 1000);
					}
				}
			});			
		}
	});
	
	function fn_goBnrLink(){
		var sdate= new Date('2020/1/1');
		var edate= new Date('2020/1/31');
		
		if(Date.now() >= sdate && Date.now() <= edate){
			movePage('/event/event_detail.do?eventSeq=427');
		}else{
			movePage('/event/event_list.do');
		}
	}
	
</script>
</head>
<body>
<!--content-->

	<form name="f_frm" id="f_frm" method="post">
		<input type="hidden" name="selAir" id="selAir" value="" />
		<input type="hidden" name="selHotel" id="selHotel" value="" />
		<input type="hidden" name="selRentcar" id="selRentcar" value="" />
	</form>
	
	<div role="main" class="ui-content contentWrap main">
		<div class="mainWrap maintop">
			<div class="swiper-container imgGallery"> 
				<div class="swiper-wrapper" id="mainBannerSlider">
				</div>
				<div class="swiper-pagination"></div>
			</div>
			<!-- 바로가기 -->
			<ul class="main_blink">
				<li onclick="moveMenu('/goods/categoryOther.do?ctg=5741', 0)" class="pack"><a href="#"><span>패키지</span></a></li>
				<li onclick="moveMenu('/goods/categoryOther.do?ctg=6592', 0)" class="fitpack"><a href="#"><span>핏팩</span></a></li>
				<li onclick="moveMenu('/goods/categoryOther.do?ctg=5744', 0)" class="air"><a href="#"><span>항공</span></a></li>
				<li onclick="moveMenu('/goods/categoryOther.do?ctg=5745', 0)" class="hotel"><a href="#"><span>호텔</span></a></li>
				<li onclick="moveMenu('/goods/categoryOther.do?ctg=5759', 0)" class="prov"><a href="#"><span>지방출발</span></a></li>
				<!-- <li onclick="moveMenu('/domestic/dmt_detail_domestic.do?url=http://m.cp.hotelpass.net/search.asp?cp_agent=jtbmo&ctgname=호텔', 0)"><a href="#"><span>호텔</span></a></li> -->
				<li onclick="moveMenu('/goods/categoryOther.do?ctg=5746', 0)" class="honey"><a href="#"><span>허니문</span></a></li>
				<li onclick="moveMenu('/goods/categoryOther.do?ctg=5747', 0)" class="golf"><a href="#"><span>골프</span></a></li>
				<li onclick="moveMenu('/goods/categoryOther.do?ctg=6615', 0)" class="biz"><a href="#"><span>비즈니스석</span></a></li>
<!-- 				<li onclick="moveMenu('/goods/categoryOther.do?ctg=5766', 0)" class="cruise"><a href="#"><span>크루즈</span></a></li> -->
<!-- 				<li onclick="moveMenu('/planning/planning_detail.do?plan_seq=2389', 0)"><a href="#"><span>8모바일특가</span></a></li> -->
			</ul>
			<!-- 메인베너 -->
			<div class="m_banner1" style="display:none;" >
				<img src="/resources/images/img/main_banner3.jpg" onclick="fn_goBnrLink();"/>
			</div>
			
			<!-- 검색 --> 
<!-- 			<div class="chkpart airpart freesearch"> -->
<!-- 				항공텝  -->
<!-- 				<ul class="mtablist_com free_airtab" id="mainFreeTab" data-ctn="airbox"> -->
<!-- 					<li><button type="button" data-role="none"><span>항공권</span></button></li> -->
<!-- 					<li><button type="button" data-role="none"><span>호텔</span></button></li> -->
<!-- 					<li><button type="button" data-role="none"><span>렌터카</span></button></li> -->
<!-- 					li><button type="button" data-role="none" onclick="fn_moveFreePage(); return false;">L.Free</button></li -->
<!-- 				</ul> -->
<!-- 				항공권 -->
<!-- 				<div class="mtabctn_com airbox airpart airbox1" style="display:none;"> -->
<%-- 					<%@include file="/WEB-INF/jsp/free/main_air_search.jsp" %> --%>
<!-- 				</div> -->
<!-- 				호텔파트 -->
<!-- 				<div class="mtabctn_com airbox hotelpart airbox2"> -->
<%-- 					<%@include file="/WEB-INF/jsp/free/main_hotel_search.jsp" %> --%>
<!-- 				</div> -->
<!-- 				렌터카파트 -->
<!-- 				<div class="mtabctn_com airbox carpart airbox3">	 -->
<%-- 					<%@include file="/WEB-INF/jsp/free/main_rentcar_search.jsp" %> --%>
<!-- 				</div> -->
<!-- 			</div> -->
			  
			<!-- 메인베너 -->
			<!--  div class="m_banner1" onclick="fn_moveFreePage();"><img src="/resources/images/img/main_banner1.jpg" /></div-->
			
			<div class="m_timebox mt7" id="timeSpecialPrice">
				<p class="m_tm_title1"><span>타임특가</span></p>
				<div class="swiper-container m_tm_slider">
					<div class="swiper-wrapper" id="timeSlider">
					</div>
					<div class="swiper-pagination swiper-pagination5"></div>
				</div>
			</div>
			
			<!-- 실시간 -->
			<div class="m_banner1"></div>
			<div class="m_timebox mt7" style="display:none;">
				<p class="m_tm_title2"><span>실시간 <em>RANK</em></span></p>
				<div class="swiper-container m_tm_listing">
					<div class="swiper-wrapper" id="realRanking">
					</div>
				</div>
			</div>
			
			<div class="mt7 m_planeven_box">
				<p class="m_tm_title1"><span>이벤트</span></p>
				<div class="swiper-container imgEvent"> 
					<div class="swiper-wrapper" id="eventSlider">
					</div>
					<div class="swiper-pagination swiper-pagination2"></div>
				</div>
			</div>
			<!-- HOT 여행가기 -->
			<div class="m_trvbox mt7">
				<p class="m_tm_title1"><span><em>BEST</em> 추천상품</span></p>
				<ul class="m_trvlist" id="hotGoodsItem">
				</ul>
			</div>
			<div class="btn_one trvbox_tbtn" id="hotMoreBtn"><button class="white2 moreico" data-role="none" onclick="fn_moreGoods(); return false;">더보기</button></div>
	
		</div>
		<!--//swiper container-->
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//contentWrap End-->
	<!-- 메인 팝업 -->
	<div class="mian_popbox" id="mainAdPop" style="display:none;">
		<div class="main_pop" >
			<div class="mpop_img"><img id="adPopImg" src="" alt="" /></div>
			<div class="mpop_btn">
				<p class="chkbox">
					<span><input id="mpop_chk" type="checkbox" data-role="none" /></span>
					<label for="mpop_chk">오늘 하루 창 열지 않기</label>
				</p>
				<button type="button" class="mpop_close" data-role="none">닫기</button>
			</div>
		</div>
	</div>
</body>