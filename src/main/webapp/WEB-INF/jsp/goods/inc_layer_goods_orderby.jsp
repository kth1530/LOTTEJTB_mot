<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 파일명 : inc_layer_goods_orderby.jsp
// 설명 : 상품 정렬방식에 대한 레이어 팝업 
%>

<div class='layerPopup2'>
    <div class='layerPop2' id="goodsOrderByPop"> 
        <div class='popCon'>
			<div class='popHead'>
				<div class='popTpart'>
					<strong class='popTitle'>정렬선택</strong>
					<button type='button' class='etclayerClose'><img src='/resources/images/btn/btn_exit.png' alt='레이어 닫기'></button>
				</div>
			</div>
			<div class='cntain'>
				<ul class='selectpop_radio'>
					<li><a href="#" onclick="fn_selectOrderBy('01')"><span id="01" class='radiobox on'><input type='radio' name="orderby" id="orderby" value="01" checked='checked'></span><label for='radio0'>추천상품순</label></a></li>
					<li><a href="#" onclick="fn_selectOrderBy('02')"><span id="02" class='radiobox'><input type='radio' name="orderby" id="orderby" value="02"></span><label for='radio1'>가격낮은순</label></a></li>
					<li><a href="#" onclick="fn_selectOrderBy('03')"><span id="03" class='radiobox'><input type='radio' name="orderby" id="orderby" value="03"></span><label for='radio2'>가격높은순</label></a></li>
				</ul>
			</div>
		</div>
    </div>
</div>

<script>
<!--
	//<!-- 상품 정렬방식에 따른  리스트 조회 -->
	function fn_selectOrderBy(val) {
		orderby = val;
		var tag = "";
		
		switch(val) {
			case "01" :
				tag = "추천상품순";
				$("#01").addClass("on");

				$("#02").removeClass("on");
				$("#03").removeClass("on");
				$('input:radio[name=orderby]:input[value="01"]').attr("checked", true).checkboxradio("refresh");
				$('input:radio[name=orderby]:input[value="02"]').attr("checked", false).checkboxradio("refresh");
				$('input:radio[name=orderby]:input[value="03"]').attr("checked", false).checkboxradio("refresh");
				$('input:radio[name=orderby]:input[value="01"]').prop("checked", true).checkboxradio("refresh");
				break;

			case "02" :
				tag = "가격낮은순";
				$("#01").removeClass("on");
				$("#02").addClass("on");
				$("#03").removeClass("on");		
				$('input:radio[name=orderby]:input[value="02"]').attr("checked", true).checkboxradio("refresh");	
				$('input:radio[name=orderby]:input[value="01"]').attr("checked", false).checkboxradio("refresh");
				$('input:radio[name=orderby]:input[value="03"]').attr("checked", false).checkboxradio("refresh");
				$('input:radio[name=orderby]:input[value="02"]').prop("checked", true).checkboxradio("refresh");					
				break;
			
			case "03" :
				tag = "높은가격순";
				$("#01").removeClass("on");
				$("#02").removeClass("on");
				$("#03").addClass("on");	
				$('input:radio[name=orderby]:input[value="03"]').attr("checked", true).checkboxradio("refresh");	
				$('input:radio[name=orderby]:input[value="01"]').attr("checked", false).checkboxradio("refresh");
				$('input:radio[name=orderby]:input[value="02"]').attr("checked", false).checkboxradio("refresh");
				$('input:radio[name=orderby]:input[value="03"]').prop("checked", true).checkboxradio("refresh");		
								
				break;
		}
		
		$("#sp_orderby").html(tag);	
		$("#goodsOrderByPop").trigger("create");

		setTimeout(function(){
			jQuery("html, body").css({"overflow":"auto"});
			jQuery(".layerPopup2").hide();		
			
			fn_search();
		}, 10);
	}
//-->
</script>