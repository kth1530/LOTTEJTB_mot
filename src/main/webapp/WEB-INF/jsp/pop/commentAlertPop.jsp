<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">
	var valueList = "";
	
	$(document).ready(function(){
		var nowFormatDay = new Date();
		nowFormatDay = nowFormatDay.format("yyyy-MM-dd");
		
		if(nullToBlank(custCd) == ""){
			hideLoading();
			$("html, body").css({"overflow":"auto"});
			if($(".layerPopup").size()){
				$(".layerPopup").remove();                 
			};
			
			location.href = "/sso/loginChk.do";
			return false;
		}
		

		if ($('input:radio[id="chkYNY1"]').is(":checked") == false) {
			$("#messageArea").html("개인정보 수집 및 이용안내에 동의하셔야만 합니다.");
			hideLoading();
			$("chkYN1").focus();
			return false;
		}	
		
		
		if(!$("#chkAll").is(":checked")){
			hideLoading();
			$("#messageArea").html("정보제공에 동의하여 주시기 바랍니다.");
			return false;
		}
		
		if(nullToBlank($("#cmtContent").val()) == ""){
			hideLoading();
			$("#messageArea").html("댓글을 입력하세요.");
			return false;
		}else if($("#cmtContent").val().length > 200){
			hideLoading();
			$("#messageArea").html("댓글은 200자까지만 가능합니다.");
			return false;
		}
		
		if(eventLimitDay < nowFormatDay){
			hideLoading();
			$("#messageArea").html("이벤트 응모 기간이 지났습니다.");
			return false;
		}
		
		var formData = new FormData();
		formData.append('eventSeq', eventSeq);
		formData.append('custCd', custCd);
		formData.append('custNm', knm);
		formData.append('loginId', id);
		formData.append('email', email);
		formData.append('custId', mbrCustno);
		formData.append('eventTitle', eventTitle);
		formData.append('eventCnts', $("#cmtContent").val());
		formData.append('winYn', 'N');
		formData.append('eventInput1', 'Y');
		formData.append('roundApplyCnt', applyCount);
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "<c:url value='/event/insertComment.do' />",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "no",
			timeOut : 60 * 5 * 1000,
			success: function(res) {
				if(res.resultCode == "ok"){
					$("#messageArea").html("등록되었습니다.");
				}else if(res.resultCode == "duplication"){
					$("#messageArea").html("이미 응모 하셨습니다.");
				}
				
				$("#cmtContent").val('');
				$("#chkYN").prop('checked', false).checkboxradio("refresh");
				
				fn_selectComment();
				
				hideLoading();
			},
			error : function(err) {
				$("#messageArea").html("등록에 실패했습니다.");
				hideLoading();
			},
			done : function(e) {
			}
		});
	});
</script>
</head>
<body>
	<div class="layerPopup">
	    <div class="layerPop"">
			<!-- 내용시작 -->
	        <div class="popCon">
				<div class="popHead">
					<div class="popTpart">
						<strong class="popTitle">댓글 등록</strong>
						<button type="button" class="layerClose"><img src="/resources/images/btn/btn_exit.png" alt="레이어 닫기"></button>
					</div>
				</div>
				<div class="cntain" id="noneSelectGoods">
					<div class="alertmsg">
						<p id="messageArea">등록중.....</p>
					</div>
				</div>				
			</div>
			<!-- 내용끝 -->
			<div class="popFoot" id="noSelectBtn">
				<div class="layerBtns"><button type="button" class="layerClose1 layerClose">확인</button></div>
			</div>
	    </div>
	</div>
</body>