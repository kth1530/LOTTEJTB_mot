<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>

<%
	// 파일명 : pop_pay_guide.jsp
	// 설명 : 요금규정
%>

<script type='text/javascript'>
	// require(['jquery','jquery.blockUI','jquery.mobile'], function($){
	// require(['jquery','jquery.blockUI'], function($){

	function closePopup() {
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
		};              
		// opener.focus();		
	}

	//규정보기 ajax 호출
	function fn_fareCerti(_obj) {	
		
		
		var cdata = fn_setAvailData_pop(_obj);
		
		console.log(cdata);
		
		gfn_callAjax ('/fit/air/viewFareCerti.do', cdata, 'fn_showCertiPop', false);

	}


	// 팝업 > 요금규정, 상세보기 팝업 호출시 넘겨줄 데이터 세팅
	function fn_setAvailData_pop(_obj) {
		
		// var ar_cnt = $(_obj).parents('[ft-att="fare_list"]').attr('ar-cnt');
		var ar_cnt = _obj;
		var avail_info = air_fix_data[ar_cnt];
		console.log(">>>>>>>>>>>>>>>>>>>>>> fn_setAvailData_pop(_obj) >>>>>>>>>>>>>>>>>>>>>>");
		console.log(avail_info);

		var pax_info = JSON.parse(sessionStorage.airSearchVal).bodyDto;	
		
		cdata= {
			"gdsCd"		: avail_info.gdsCd,		
			"availTy"	: pax_info.availTy,	
			"adtCnt"	: pax_info.adtCnt,		
			"chdCnt"	: pax_info.chdCnt,		
			"infCnt"	: pax_info.infCnt,
			"fmsKey"   : avail_info.fmsKey
		};
		
		cdata.segmentGroup = [];
		
		for(var seg_idx=0; seg_idx<avail_info.segmentGroup.length; seg_idx++) {
			var availData = avail_info.segmentGroup[seg_idx];
			cdata.segmentGroup[seg_idx] = {
				"availNo"	: availData.availNo,
				"segNo"		: availData.segNo,
				"depCd"		: availData.depCd,
				"fltEquip"	: availData.fltEquip,
				"arrCd"		: availData.arrCd,
				"arrTm"		: availData.arrTm,
				"arrDt"		: availData.arrDt,
				"fltNo"		: availData.fltNo,
				"bookingClas": availData.bookingClas,
				"depDt"		: availData.depDt,
				"carrierCd"	: availData.carrierCd,
				"depTm"		: availData.depTm
			};		
		}
		
		cdata.paxGroup = avail_info.paxDataBean;	
		
		return cdata;
	}

	//규정보기 팝업
	function fn_showCertiPop (_data) {

		var certi_pop = $('div[ft-att="air_certi_pop"]'); 
		
		var pax_info = JSON.parse(sessionStorage.airSearchVal).bodyDto;
		
		console.log(_data);

		
		var certi_div = certi_pop.find('dl[ft-att="certi_table_list"]');
		var certi_data = _data.fareCerti.data;
		var caption = certi_pop.find('#notibox');
		
		// 규정이 2개 이상 존재하면 안내문구 노출
		// if(certi_data.length > 1){
		// 	caption.show();
		// } else {
		//	caption.hide();
		// }
		/**	
		var certiSel = certi_pop.find('.noti').find('select#certiSelect');
		if(certi_data.length > 1) {
			certiSel.show();
		}
		**/
		// 규정 수만큼  for
		for(var c_idx=0; c_idx<certi_data.length; c_idx++) {
			var tmp_table = "							<dt>요금규정" +  (c_idx+1) + "</dt>";
			tmp_table = tmp_table + "					<dd>";
			tmp_table = tmp_table + "						<table class='pop_table2 pop_table2_left' ft-att='certi_list_div'>";
			tmp_table = tmp_table + "						</table>";
			tmp_table = tmp_table + "					</dd>";		

			certi_div.append(tmp_table);
			
			var certi_list_div = certi_div.find('table[ft-att="certi_list_div"]').eq(c_idx);
			var certi_html = "";
			certi_html = certi_html + "							<colgroup>";
			certi_html = certi_html + "								<col style='width: 25%' />";
			certi_html = certi_html + "								<col style='width: auto' />";
			certi_html = certi_html + "							</colgroup>";
			certi_list_div.append(certi_html);

			var fare_rule_info = certi_data[c_idx].fareRuleInfoDataBean;
			
			for(var f_idx=0; f_idx<fare_rule_info.length; f_idx++) {
				var certi_html = $('<tr></tr>');
				certi_html.append('<th scope="row">' + fare_rule_info[f_idx].itemNm + '</th>');
				certi_html.append('<td class="last"></td>');
				
				//규정 내용 입력	내용 속성 미적용 - 미완료
				var cont_val = '';
				if(fare_rule_info[f_idx].itemAttr == 'C'){
					cont_val = fare_rule_info[f_idx].itemTxt;
				} else if (fare_rule_info[f_idx].itemAttr == 'B') {
					cont_val = fare_rule_info[f_idx].itemTxt;
					console.log('볼드맨');
				} else if (fare_rule_info[f_idx].itemAttr == 'D') {
					cont_val = fare_rule_info[f_idx].itemTxt;
					console.log('볼드맨');
				}		
				certi_html.find('td.last').html(cont_val);		
				
				//리스트에 추가
				certi_list_div.append(certi_html);	
			}
		}
		
		$('table.certi_table').eq(c_idx).show();	//첫번째 요금 규정 노출
		acdon();

	}

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		var ar_cnt = '${ar_cnt}';

		fn_fareCerti(ar_cnt);
		/*document.addEventListener('deviceready', function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});
</script>
<div class='layerPopup' ft-att="air_certi_pop">
	<div class='layerPop bgwhite'>
		<!-- 내용시작 -->
		<div class='popCon'>
			<div class='popHead'>
				<div class='popTpart'>
					<strong class='popTitle'>요금규정</strong>
					<button type='button' class='layerClose'>
						<img src='/resources/images/btn/btn_exit.png' alt='레이어 닫기'>
					</button>
				</div>
			</div>
			<div class='cntain'>
				<div class='pay_text' id='notibox' name='notibox'>
					전체 여정에 <span>상이한 운임과 규정</span>이 적용되었습니다. <br> 각 운임 규정 중 가장
					제한적인 규정이 적용됩니다. 상세 운임규정은 여행사 <span>예약 담당자를 통해서 재확인</span> 하시기 바랍니다.
					<br> 예) 다음 규정의 경우 더 제한적인 규정인 ‘10만원 징수 후 환불’이 적용됩니다. <br>
					첫 번째 환불 규정 : 5만원 징수 후 가능<br> 두 번째 환불 규정 : 10만원 징수 후 가능
				</div>
				<dl class='ft_acdon ft_acdon1 pop_acdon1' ft-att='certi_table_list'>
				</dl>
			</div>
		</div>
		<!-- 내용끝 -->
		<div class='popFoot'>
			<div class='layerBtns'>
				<button type='button' class='layerClose1' onClick='closePopup()'>확인</button>
			</div>
		</div>
	</div>
</div>
