<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">
	var valueList = "";
	
	$(document).ready(function(){
		$(".choiceDel").each(function(){
			
			if($(this).is(':checked')){
				valueList += "," + $(this).val();	
			}
		});
		
		if(nullToBlank(valueList) == ""){
			$("#messageArea").html('선택된 상품이 없습니다.');
			
			$("#noSelectBtn").show();
			$("#selectBtn").hide();
			$("#completeDelete").hide();
		}else{
			$("#messageArea").html('선택한 상품을 삭제하시겠습니까?');
			
			$("#noSelectBtn").hide();
			$("#selectBtn").show();
			$("#completeDelete").hide();
		}
	});
	
	var fn_delChoiceGoods = function(){
		var formData = new FormData();
		formData.append('wishSeqs', valueList);
		
		cfn_ajax({
			type: "POST",
			async: false,
			url: "<c:url value='/mytour/delectSelChoiceGoods.do' />",
			data: formData,
			dataType: "json",
			cache: false,
			noloading:"no",
			success: function(res) {
				
				$("#messageArea").html('찜!여행상품이 삭제되었습니다.');
				
				$("#noSelectBtn").hide();
				$("#selectBtn").hide();
				$("#completeDelete").show();
			},
			error:function(err){
				console.log(err);
			},
			complete:function(){
			}
		});
	}
	
	var fn_completeDel = function(){
		fn_tabClick(2, true);
		
		$("html, body").css({"overflow":"auto"});
		if($(".layerPopup").size()){
			$(".layerPopup").remove();                 
		};
	}
</script>
</head>
<body>
	<div class="layerPopup">
	    <div class="layerPop"">
			<!-- 내용시작 -->
	        <div class="popCon">
				<div class="popHead">
					<div class="popTpart">
						<strong class="popTitle">찜내역 삭제</strong>
						<button type="button" class="layerClose"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></button>
					</div>
				</div>
				<div class="cntain" id="noneSelectGoods">
					<div class="alertmsg">
						<p id="messageArea">선택된 삼품이 없습니다.</p>
					</div>
				</div>				
			</div>
			<!-- 내용끝 -->
			<div class="popFoot" id="noSelectBtn">
				<div class="layerBtns"><button type="button" class="layerClose1 layerClose">확인</button></div>
			</div>
			
			<div class="popFoot pf2" id="selectBtn" style="display:none;">
				<div class="layerBtns"><button type="button" class="layerClose1" onclick="fn_delChoiceGoods()">확인</button></div>
				<div class="layerBtns"><button type="button" class="layerClose2 layerClose">취소</button></div>
			</div>
			
			<div class="popFoot" id="completeDelete">
				<div class="layerBtns"><button type="button" class="layerClose1" onclick="fn_completeDel()">확인</button></div>
			</div>
	    </div>
	</div>
</body>