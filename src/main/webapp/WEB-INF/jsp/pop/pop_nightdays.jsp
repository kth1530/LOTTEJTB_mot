<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
	
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<%
	// 파일명 : pop_nightdays.jsp
	// 설명 : 숙박일수 (새창)
	
	Date systemDate = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
	String serverDay = sdf.format(systemDate);
%>

<script type='text/javascript'>
	// require(['jquery','jquery.blockUI','jquery.mobile'], function($){
	// require(['jquery','jquery.blockUI'], function($){
	

	// 초기화
	var fn_init = function() {
		var nightDays = $('#srch_night_days').text();
		var day = nightDays.substring(0, nightDays.lastIndexOf('박'));
		
		var html = "";
		
		for(var i = 1; i < 31; i++) {
			if(i == day) {
				html = html + "<li><a href='#' onClick='fn_selectNightDay("+i+")'><span id='nightdays"+i+"' class='radiobox on'><input type='radio' name='nightdays' id='nightdays_"+i+"' value='1' checked='checked'></span><label for='nightdays"+i+"'>"+i+"박</label></a></li>";
			} else {
				html = html + "<li><a href='#' onClick='fn_selectNightDay("+i+")'><span id='nightdays"+i+"' class='radiobox'><input type='radio' name='nightdays' id='nightdays_"+i+"' value='1'></span><label for='nightdays"+i+"'>"+i+"박</label></a></li>";
			}
		}
		
		$("#night_days").html(html);
	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};

	function fn_selectNightDay(days) {
		
		$('.radiobox').removeClass('on');
		$('.nightdays').removeAttr('checked');
		$('#nightdays_'+ days).parent().addClass('on');
		$('#nightdays_'+ days).prop('checked', true);

		setTimeout(function(){
			jQuery('html, body').css({'overflow':'auto'});
			if(jQuery('.layerPopup').size()){
				jQuery('.layerPopup').remove();                 
			};
			
			var startDate = $("div[ft-att=HTGroup]").find("#dep_dt").html().split(".");
			
			if(nullToBlank(startDate) == ""){
				var serverDate = '<%=serverDay%>';
				startYear = serverDate.substring(0, 4);
				startMonth = serverDate.substring(4, 6);
				startDay = serverDate.substring(6, 8);
			}else{
				startYear = startDate[0];
				startMonth = startDate[1];
				startDay = startDate[2];
			}
			
			var selectDate = new Date(startYear, parseInt(startMonth - 1), parseInt(startDay) + parseInt(days));
			
			if(selectDate.getMonth() < 10){
				if(selectDate.getDate() < 10){
					$("div[ft-att=HTGroup]").find("#arr_dt").html(selectDate.getFullYear() + ".0" + parseInt(selectDate.getMonth() + 1) + ".0" + selectDate.getDate());
					$("div[ft-att=HTGroup]").find("#arr_dt").removeClass('noSelect');
				}else{
					$("div[ft-att=HTGroup]").find("#arr_dt").html(selectDate.getFullYear() + "." + parseInt(selectDate.getMonth() + 1) + "." + selectDate.getDate());
					$("div[ft-att=HTGroup]").find("#arr_dt").removeClass('noSelect');	
				}
			}else{
				if(selectDate.getDate() < 10){
					$("div[ft-att=HTGroup]").find("#arr_dt").html(selectDate.getFullYear() + "." + parseInt(selectDate.getMonth() + 1) + ".0" + selectDate.getDate());
					$("div[ft-att=HTGroup]").find("#arr_dt").removeClass('noSelect');
				}else{
					$("div[ft-att=HTGroup]").find("#arr_dt").html(selectDate.getFullYear() + "." + parseInt(selectDate.getMonth() + 1) + "." + selectDate.getDate());
					$("div[ft-att=HTGroup]").find("#arr_dt").removeClass('noSelect');	
				}
			}
			
			$('#srch_night_days').html(days+'박');
		}, 30);	
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

		/*document.addEventListener('deviceready', function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});
	
	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
	}

</script>


<div class='layerPopup'>
	<div class='layerPop'>
		<!-- 내용시작 -->
		<div class='popCon'>
			<div class='popHead'>
				<div class='popTpart'>
					<strong class='popTitle'>숙박일수</strong>
					<button type='button' class='layerClose'>
						<img src='/resources/images/btn/btn_exit.png' alt='레이어 닫기'>
					</button>
				</div>
			</div>
			<div class='cntain'>
				<ul class='selectpop_radio' id="night_days">
				</ul>
			</div>
		</div>
		<!-- 내용끝 -->
		<div class='popFoot'>
			<div class='layerBtns'>
				<button type='button' class='layerClose1' onclick="closePopup();">확인</button>
			</div>
		</div>
	</div>
</div>