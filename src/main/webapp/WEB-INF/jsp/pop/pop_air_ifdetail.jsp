<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 파일명 : pop_air_ifdetail.jsp
	// 설명 : 항공권 상세조건
%>
<script type="text/javascript">
	var air_fil_via_type;
	var air_fil_class_type;
	var air_fil_air_line;
	var air_fil_dep_tm;

	// 초기화
	var fn_init = function() {

		if(sessionStorage.airSearchVal != undefined && JSON.parse(sessionStorage.airSearchVal).bodyDto != undefined) {
			fn_air_list_pop(JSON.parse(sessionStorage.airSearchVal).bodyDto);
		}
	
		air_fil_via_type = $("#air_fil_via_type").val();
		air_fil_class_type = $("#air_fil_class_type").val();
		air_fil_air_line = $("#air_fil_air_line").val();
		air_fil_dep_tm = $("#air_fil_dep_tm").val();

		console.log("fn_init() >> air_fil_via_type : " + air_fil_via_type);
		console.log("fn_init() >> air_fil_class_type : " + air_fil_class_type);
		console.log("fn_init() >> air_fil_air_line : " + air_fil_air_line);
		console.log("fn_init() >> air_fil_dep_tm : " + air_fil_dep_tm);

		if(air_fil_via_type != 'ALL') {
			$('input:checkbox[ar_att="filter_chk"][name="fil_via_type"][value="ALL"]').prop('checked', false);
			$('input:checkbox[ar_att="filter_chk"][name="fil_via_type"][value="ALL"]').attr('checked', false);
			
			var fil_via_type = air_fil_via_type.split(',');
			for(var i = 0; i < fil_via_type.length; i++) {
				$("input:checkbox[ar_att='filter_chk'][name='fil_via_type'][value='"+fil_via_type[i]+"']").prop('checked', true);
				$("input:checkbox[ar_att='filter_chk'][name='fil_via_type'][value='"+fil_via_type[i]+"']").attr('checked', true);
			}
		}

		if(air_fil_class_type != 'ALL') {
			$('input:checkbox[ar_att="filter_chk"][name="fil_class_type"][value="ALL"]').prop('checked', false);
			$('input:checkbox[ar_att="filter_chk"][name="fil_class_type"][value="ALL"]').prop('checked', false);

			var fil_class_type = air_fil_class_type.split(',');
			for(var i = 0; i < fil_class_type.length; i++) {
				$("input:checkbox[ar_att='filter_chk'][name='fil_class_type'][value='"+fil_class_type[i]+"']").prop('checked', true);
				$("input:checkbox[ar_att='filter_chk'][name='fil_class_type'][value='"+fil_class_type[i]+"']").attr('checked', true);
			}
		}

		if(air_fil_air_line != 'ALL') {
			$('input:checkbox[ar_att="filter_chk"][name="fil_air_line"][value="ALL"]').prop('checked', false);
			$('input:checkbox[ar_att="filter_chk"][name="fil_air_line"][value="ALL"]').attr('checked', false);

			var fil_air_line = air_fil_air_line.split(',');
			for(var i = 0; i < fil_air_line.length; i++) {
				$("input:checkbox[ar_att='filter_chk'][name='fil_air_line'][value='"+fil_air_line[i]+"']").prop('checked', true);
				$("input:checkbox[ar_att='filter_chk'][name='fil_air_line'][value='"+fil_air_line[i]+"']").attr('checked', true);
			}
		}

		if(air_fil_dep_tm != 'ALL') {
			$('input:checkbox[ar_att="filter_chk"][name="fil_dep_tm"][value="ALL"]').prop('checked', false);
			$('input:checkbox[ar_att="filter_chk"][name="fil_dep_tm"][value="ALL"]').attr('checked', false);
			
			var fil_dep_tm = air_fil_dep_tm.split(',');
			for(var i = 0; i < fil_dep_tm.length; i++) {			
				$("input:checkbox[ar_att='filter_chk'][name='fil_dep_tm'][value='"+fil_dep_tm[i]+"']").prop('checked', true);
				$("input:checkbox[ar_att='filter_chk'][name='fil_dep_tm'][value='"+fil_dep_tm[i]+"']").attr('checked', true);
			}

		}

	};


	function fn_act_filter_init() {
		// 초기화 로직 
		$('input:checkbox[ar_att="filter_chk"]').each(function() {
			if ($(this).is(":checked")) {
				$(this).prop('checked', false);
				$(this).attr('checked', false);
				
			}
		});

		$('input:checkbox[ar_att="filter_chk"][name="fil_via_type"][value="ALL"]').prop('checked', true);
		$('input:checkbox[ar_att="filter_chk"][name="fil_class_type"][value="ALL"]').prop('checked', true);
		$('input:checkbox[ar_att="filter_chk"][name="fil_air_line"][value="ALL"]').prop('checked', true);
		$('input:checkbox[ar_att="filter_chk"][name="fil_dep_tm"][value="ALL"]').prop('checked', true);



		// sortAirList();
		// closePopup();
	}

	function fn_act_filter_setting() {
		// air_fil_via_type = $("input:checkbox[ar_att='filter_chk'][name='fil_via_type']:checked").val();
		air_fil_via_type = $("input:checkbox[ar_att='filter_chk'][name='fil_via_type']:checked").map(function(){
   			 return this.value;
		}).get().join(",");

		// air_fil_class_type = $("input:checkbox[ar_att='filter_chk'][name='fil_class_type']:checked").val();
		air_fil_class_type = $("input:checkbox[ar_att='filter_chk'][name='fil_class_type']:checked").map(function(){
   			 return this.value;
		}).get().join(",");

		// air_fil_air_line = $("input:checkbox[ar_att='filter_chk'][name='fil_air_line']:checked").val();
		air_fil_air_line = $("input:checkbox[ar_att='filter_chk'][name='fil_air_line']:checked").map(function(){
   			 return this.value;
		}).get().join(",");

		// air_fil_dep_tm = $("input:checkbox[ar_att='filter_chk'][name='fil_dep_tm']:checked").val();
		air_fil_dep_tm = $("input:checkbox[ar_att='filter_chk'][name='fil_dep_tm']:checked").map(function(){
   			 return this.value;
		}).get().join(",");

		console.log("fn_act_filter_setting() >> air_fil_via_type : " + air_fil_via_type);
		console.log("fn_act_filter_setting() >> air_fil_class_type : " + air_fil_class_type);
		console.log("fn_act_filter_setting() >> air_fil_air_line : " + air_fil_air_line);
		console.log("fn_act_filter_setting() >> air_fil_dep_tm : " + air_fil_dep_tm);

		$("#air_fil_via_type").val(air_fil_via_type);
		$("#air_fil_class_type").val(air_fil_class_type);
		$("#air_fil_air_line").val(air_fil_air_line);
		$("#air_fil_dep_tm").val(air_fil_dep_tm);
		
	}

	function fn_act_filter() {
		fn_act_filter_setting();
		$("#air_result_list_div").html('');
		$('[ft-att="fare_div"]').html('');
		
		filterAirList();
		closePopup();
		
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
					<strong class="popTitle">상세조건</strong>
					<button type="button" class="layerClose">
						<img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기">
					</button>
				</div>
			</div>
			<div class="cntain cldarpart">
				<dl class="pop_chk_list">
					<dt>경유</dt>
					<dd>
						<p class="chkbox">
							<span><input id="fil_via_type01" ar_att="filter_chk" name="fil_via_type" value="ALL" checked="checked" type="checkbox" data-role="none" /></span>
							<label for="check01">전체</label>
						</p>
					</dd>					
					<dd>
						<p class="chkbox">
							<span><input id="fil_via_type02" ar_att="filter_chk" title="직항" name="fil_via_type" value="N" type="checkbox"  data-role="none" /></span>
							<label for="check01" via_type="direct"></label>
						</p>
					</dd>
					<dd>
						<p class="chkbox">
							<span><input id="fil_via_type03" type="checkbox" title="1번 경유" ar_att="filter_chk" name="fil_via_type" value="Y1"/></span>
							<label for="check01" via_type="via1"></label>
						</p>
					</dd>
					<dd>
						<p class="chkbox">
							<span><input id="fil_via_type04" type="checkbox" title="2번 경유" ar_att="filter_chk" name="fil_via_type" value="Y2" /></span>
							<label for="check01" via_type="via2"></label>
						</p>
					</dd>
				</dl>
				<dl class="pop_chk_list" ft-att="fil_cabinClas_div">
					<dt>좌석등급</dt>
					<dd>
						<p class="chkbox">
							<span><input id="fil_class_type01" type="checkbox" ar_att="filter_chk" name="fil_class_type" value="ALL" checked="checked" /></span>
							<label for="check01">전체</label>
						</p>
					</dd>
				</dl>
				<dl class="pop_chk_list" ft-att="fil_airline_div">
					<dt>항공사</dt>
					<dd>
						<p class="chkbox">
							<span><input id="filter_chk01" type="checkbox" title="전체"  ar_att="filter_chk" name="fil_air_line" value="ALL" checked="checked" /></span>
							<label for="check01">전체</label>
						</p>
					</dd>					
				</dl>
				<dl class="pop_chk_list pop_chk_list2">
					<dt>출발시간</dt>
					<dd>
						<p class="chkbox">
							<span><input id="fil_dep_tm01" title = '전체' type="checkbox" ar_att="filter_chk" name="fil_dep_tm" value="ALL" checked="checked"/></span> 
							<label for="check01">전체</label>
						</p>
					</dd>					
					<dd>
						<p class="chkbox">
							<span><input id="fil_dep_tm02" title = '오전' type="checkbox" ar_att="filter_chk" name="fil_dep_tm" value="0312"/></span> 
							<label for="check01">오전(am 03:00~am 11:59)</label>
						</p>
					</dd>
					<dd>
						<p class="chkbox">
							<span><input id="chk_if14" title = '오후'  type="checkbox" ar_att="filter_chk" name="fil_dep_tm" value="1217"/></span> 
							<label for="check01">오후(pm 12:00~pm 05:59)</label>
						</p>
					</dd>
					<dd>
						<p class="chkbox">
							<span><input id="chk_if15" title = '저녁' type="checkbox" ar_att="filter_chk" name="fil_dep_tm" value="1703" /></span> 
							<label for="check01">저녁(pm 05:00~am 02:59)</label>
						</p>
					</dd>
				</dl>
				<!-- dl class="pop_chk_list">
					<dt>요금구분</dt>
					<dd>
						<p class="chkbox">
							<span><input id="chk_if16" type="checkbox"
								data-role="none" /></span> <label for="chk_if16">성인</label>
						</p>
					</dd>
					<dd>
						<p class="chkbox">
							<span><input id="chk_if17" type="checkbox"
								data-role="none" /></span> <label for="chk_if17">학생</label>
						</p>
					</dd>
					<dd>
						<p class="chkbox">
							<span><input id="chk_if18" type="checkbox"
								data-role="none" /></span> <label for="chk_if18">장애인</label>
						</p>
					</dd>
				</dl -->
			</div>
		</div>
		<!-- 내용끝 -->
		<div class="popFoot pf2">
			<div class="layerBtns">
				<button type="button" class="layerClose1" onClick="fn_act_filter_init()">초기화</button>
			</div>
			<div class="layerBtns">
				<button type="button" class="layerClose2" onClick="fn_act_filter()">적용</button>
			</div>
		</div>
	</div>
</div>