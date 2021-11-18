<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">
	var applySeq = "${applySeq}";
	
	$(document).ready(function(){

	});
	
	var fn_commentDel = function(){
		var formData = new FormData();
		formData.append('eventSeq', eventSeq);
		formData.append('applySeq', applySeq);
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "<c:url value='/event/deleteComment.do' />",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "no",
			timeOut : 60 * 5 * 1000,
			success: function(data) {
				$("#confirmBtn").hide();
				$("#completeBtn").show();
				$("#messageText").html("삭제되었습니다.");
				
				fn_selectComment();
			},
			error : function(err){
				
			},
			done : function(e) {
			}
		});
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
						<strong class="popTitle">댓글 삭제</strong>
						<button type="button" class="layerClose"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></button>
					</div>
				</div>
				<div class="cntain" id="noneSelectGoods">
					<div class="alertmsg">
						<p id="messageText">댓글을 삭제하시겠습니까?</p>
					</div>
				</div>				
			</div>
			
			<div class="popFoot pf2" id="confirmBtn">
				<div class="layerBtns"><button type="button" class="layerClose1" onclick="fn_commentDel()">확인</button></div>
				<div class="layerBtns"><button type="button" class="layerClose2 layerClose">취소</button></div>
			</div>
			
			<div class="popFoot" id="completeBtn" style="display:none;">
				<div class="layerBtns"><button type="button" class="layerClose1 layerClose">확인</button></div>
			</div>
	    </div>
	</div>
</body>