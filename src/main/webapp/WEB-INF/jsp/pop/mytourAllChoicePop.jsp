<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">
	$(document).ready(function(){
		if($("#choiceGoods").children().length > 0){
			$("#messageText").text("전체 찜!여행상품을 삭제하시겠습니까?");
			$("#selectBtn").show();
			$("#noSelectBtn").hide();
			$("#completeDelBtn").hide();
		}else{
			$("#messageText").text("삭제할 찜!여행상품이 없습니다.");
			$("#noSelectBtn").show();
			$("#selectBtn").hide();
			$("#completeDelBtn").hide();
		}
	});
	
	var fn_allChoiceDel = function(){
		var formData = new FormData();
		formData.append('custCd', custCd);
		
		cfn_ajax({
			type: "POST",
			async: false,
			url: "<c:url value='/mytour/delectAllChoiceGoods.do' />",
			data: formData,
			dataType: "json",
			cache: false,
			noloading:"no",
			success: function(res) {
				
				$("#messageText").html('전체 찜!여행상품이 삭제되었습니다.');
				
				$("#noSelectBtn").hide();
				$("#selectBtn").hide();
				$("#completeDelBtn").show();
			},
			error:function(err){
				console.log(err);
			},
			complete:function(){
			}
		});
	}
	
	var fn_completeAllDel = function(){
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
						<p id="messageText"></p>
					</div>
				</div>				
			</div>
			
			<div class="popFoot pf2" id="selectBtn">
				<div class="layerBtns"><button type="button" class="layerClose1" onclick="fn_allChoiceDel()">확인</button></div>
				<div class="layerBtns"><button type="button" class="layerClose2 layerClose">취소</button></div>
			</div>
			
			<div class="popFoot" id="noSelectBtn">
				<div class="layerBtns"><button type="button" class="layerClose1 layerClose">확인</button></div>
			</div>
			
			<div class="popFoot" id="completeDelBtn">
				<div class="layerBtns"><button type="button" class="layerClose1" onclick="fn_completeAllDel()">확인</button></div>
			</div>
	    </div>
	</div>
</body>