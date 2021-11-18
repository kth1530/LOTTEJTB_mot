<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<head>
<script type="text/javascript">
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){

	// 초기화
	var fn_init = function() {
	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();
		$(".bodyWrap").addClass("foot2pd");
		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});
</script>
</head>
<body>


	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="collapse freetop">
			<!-- 중복텝 -->
			<div class="free_box">
				<ul class="free_toprst frrst3">
					<li class="aircheck"><input id="aircheck" data-role="none"
						type="checkbox" checked="checked" disabled="true" /><label
						for="aircheck">항공</label></li>
					<li class="hotelcheck"><input id="hotelcheck" data-role="none"
						type="checkbox" checked="checked" disabled="true" /><label
						for="hotelcheck">호텔</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none"
						type="checkbox" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
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
			<div class="stable_guide2">
				<p class="st2_stext1 ellipsis">서울(인천/김포)</p>
				<p class="st2_text1">ICN</p>
				<p class="st2_gbox"></p>
				<p class="st2_text2">BKK</p>
				<p class="st2_stext2 ellipsis">방콕</p>
			</div>
			<div class="txbox1">
				2016.12.02 ~ 2016.12.05
				<p>왕복, 프리미엄, 일반석, 성인 1, 이동2</p>
			</div>
			<!-- 검색버튼 -->
			<button type="button" data-role="none" class="re_search">재검색</button>
			<!-- 정렬박스 -->
			<ul class="fr_sortbox">
				<li>총 상품 0000개</li>
				<li><button type="button" data-role="none">직항+최저 요금 순</button></li>
				<li><button type="button" data-role="none"></button></li>
			</ul>
			<!-- 빈데이터 -->
			<div class="fr_nodata">
				<p>
					검색하신 조건으로<br>검색된 항공이 없습니다.
				</p>
			</div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//content-->