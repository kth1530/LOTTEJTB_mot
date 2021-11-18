<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_air_sorting.jsp
	// 설명 : 정렬방식
%>
<script type="text/javascript">
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){
	

	// 초기화
	var fn_init = function() {
		var airsort = $("#air_sort").data("airsort");
		console.log("airsort >>> " + airsort);

		$(".radiobox").removeClass('on');
		$("#air_sort").removeAttr("checked");
		$("#air_sort"+ airsort).parent().addClass('on');
		$("#air_sort"+ airsort).prop("checked", true);

	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};

	function fn_airSortPop(airsort) {
		$(".radiobox").removeClass('on');
		$(".air_sort").removeAttr("checked");
		$("#air_sort"+ airsort).parent().parent().addClass('on');
		$("#air_sort"+ airsort).prop("checked", true);

		setTimeout(function(){
			jQuery("html, body").css({"overflow":"auto"});
			jQuery(".layerPopup").hide();
			
			if(airsort == 'C') {
				$("#air_sort").html("직항+최저 요금 순");
				$('#air_sort').data('airsort', 'C');

			} else {
				$("#air_sort").html("최저 요금 순");
				$('#air_sort').data('airsort', 'B');
			}

			$("#air_result_list_div").html('');
			$('[ft-att="fare_div"]').html('');

			sortAirList();
			closePopup();
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
					<strong class="popTitle">정렬방식</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain">
				<ul class="selectpop_radio">
					<li><a href='javascript:fn_airSortPop("C")'><span class="radiobox on"><input type="radio" name="air_sort" id="air_sortC" checked="checked" value='C' onclick="fn_airSortPop('C')"></span><label for="air_sortC">직항+최저 요금 순</label></a></li>
					<li><a href='javascript:fn_airSortPop("B")'><span class="radiobox"><input type="radio" name="air_sort" id="air_sortB" value='B' onclick="fn_airSortPop('B')"></span><label for="air_sortB">최저 요금 순</label></a></li>
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