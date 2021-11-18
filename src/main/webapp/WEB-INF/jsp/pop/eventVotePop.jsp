<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">
	var valueList = "";
	
	$(document).ready(function(){
		showLoading();
		var nowFormatDay = new Date();
		nowFormatDay = nowFormatDay.format("yyyy-MM-dd");
		
		if(nullToBlank(custCd) == ""){
			hideLoading();
			alert("로그인이 필요합니다.");
			$("html, body").css({"overflow":"auto"});
			if($(".layerPopup").size()){
				$(".layerPopup").remove();                 
			};
			
			location.href = "/sso/loginChk.do";
			return false;
		}
		

		if ($('input:radio[id="chkYNY6"]').is(":checked") == false) {
			$("#messageArea").html("개인정보 수집 및 이용안내에 동의하셔야만 합니다.");
			hideLoading();
			$("chkYN6").focus();
			return false;
		}	
		
		
		//if(!$("#chkVote").is(":checked")){
		//	hideLoading();
		//	$("#messageArea").html("정보제공에 동의하여 주시기 바랍니다.");
		//	return false;
		//}
		
		if(eventLimitDay < nowFormatDay){
			hideLoading();
			$("#messageArea").html("이벤트 응모 기간이 지났습니다.");
			return false;
		}
		
		if(nullToBlank(checkedValue) == ""){
			checkedValue = $('input:radio[name="radio"]:checked').val();
		}
		
		var formData = new FormData();
		formData.append('eventSeq', eventSeq);
		formData.append('custCd', custCd);
		formData.append('custNm', knm);
		formData.append('loginId', id);
		formData.append('email', email);
		formData.append('custId', mbrCustno);
		formData.append('eventTitle', eventTitle);
		formData.append('winYn', 'N');
		formData.append('eventInput1', 'Y');
		formData.append('eventCnts', checkedValue);
		
		cfn_ajax({
			type : "POST",
			async : false,
			url: "<c:url value='/event/insertEventVote.do' />",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "no",
			timeOut : 60 * 5 * 1000,
			success: function(res) {
				if(res.resultCode == "ok"){
					$("#messageArea").html("정상적으로 응모되었습니다.");
				}else if(res.resultCode == "duplication"){
					$("#messageArea").html("이미 참여 하셨습니다.");
				}
				
				//$("#chkQuiz").prop('checked', false).checkboxradio("refresh");
				
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
						<strong class="popTitle">투표응모하기</strong>
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