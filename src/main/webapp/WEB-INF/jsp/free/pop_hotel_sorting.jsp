<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 설명 : 정렬방식
%>
<script src="/resources/common/js/fit/hotel_search.js"></script>
<script src="/resources/common/js/fit/paging.js"></script>
<script src="/resources/common/js/fit/common.js"></script>	
<script type="text/javascript">
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){
	

	// 초기화
	var fn_init = function() {
		var hotelsort = $("#hotel_sort").data("hotelsort");
		console.log("hotelsort >>> " + hotelsort);

		$(".radiobox").removeClass('on');
		$("#hotel_sort").removeAttr("checked");
		$("#hotel_sort"+ hotelsort).parent().addClass('on');
		$("#hotel_sort"+ hotelsort).prop("checked", true);

	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};

	function fn_hotelSortPop(hotelsort) {
		console.log("hotelsort >>><<<< " + hotelsort);
	
		$(".radiobox").removeClass('on');
		$(".hotel_sort").removeAttr("checked");
		$("#hotel_sort"+ hotelsort).parent().parent().addClass('on');
		$("#hotel_sort"+ hotelsort).prop("checked", true);

		setTimeout(function(){
			jQuery("html, body").css({"overflow":"auto"});
			jQuery(".layerPopup").hide();
			
			if(hotelsort == 'R') {
				$('#hotel_sort').text("추천순");
				$('#hotel_sort').data('hotelsort', 'R');
			} else if(hotelsort == 'P') {
				$('#hotel_sort').text("가격순");
				$('#hotel_sort').data('hotelsort', 'P');
			} else if(hotelsort == 'G') {
				$('#hotel_sort').text("등급순");
				$('#hotel_sort').data('hotelsort', 'G');
			} else {
				$('#hotel_sort').text("평점순");
				$('#hotel_sort').data('hotelsort', 'A');
			}
			sortHotelList();
			//closePopup();
		}, 10);	
	}

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

<div class="layerPopup">
	<div class="layerPop">
		<!-- 내용시작 -->
		<div class="popCon">
			<div class="popHead">
				<div class="popTpart">
					<strong class="popTitle">추천순</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain">
				<ul class="selectpop_radio">
					<li><a href='#' onclick='fn_hotelSortPop("R");'><span class="radiobox on"><input type="radio" name="hotel_sort" id="hotel_sortR" checked="checked" value='R'></span><label for="selectview01">추천순</label></a></li>
					<li><a href='#' onclick='fn_hotelSortPop("P");'><span class="radiobox"><input type="radio" name="hotel_sort" id="hotel_sortP" value='P'></span><label for="selectview02">가격순</label></a></li>
					<li><a href='#' onclick='fn_hotelSortPop("G");'><span class="radiobox"><input type="radio" name="hotel_sort" id="hotel_sortG" value='G'></span><label for="selectview03">등급 순</label></a></li>
					<li><a href='#' onclick='fn_hotelSortPop("A");'><span class="radiobox"><input type="radio" name="hotel_sort" id="hotel_sortA" value='A'></span><label for="selectview04">평점순</label></a></li>
				</ul>
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