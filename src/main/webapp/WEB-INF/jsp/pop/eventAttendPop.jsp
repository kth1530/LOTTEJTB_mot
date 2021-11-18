<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<head>

<%
	Date systemDate = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
	String nowday = sdf.format(systemDate);
%>
<script type="text/javascript">
	var valueList = "";
	var retCode = "";
	var dayTemp = "";
	var atChkCnt = '${atChkCnt}';
	//var attendChkCnt = '${attendChkCnt}';
	console.log(lastDay);
	$(document).ready(function(){
				
		showLoading();
		var nowFormatDay = new Date();
		nowFormatDay = nowFormatDay.format("yyyy-MM-dd");
		
		if(nullToBlank(custCd) == ""){
			hideLoading();
			alert("로그인이 필요합니다.");
			$("html, body").css({"overflow":"auto"});
			if($(".layerPopup").size()) {
				$(".layerPopup").remove();                 
			};
			
			location.href = "/sso/loginChk.do";
			return false;
		}
		
		if ($('input:radio[id="chkYNY2"]').is(":checked") == false) {
			$("#messageArea").html("개인정보 수집 및 이용안내에 동의하셔야만 합니다.");
			hideLoading();
			$("chkYN2").focus();
			return false;
		}			
		
		//if(!$("#chkAttend").is(":checked")){
			//hideLoading();
			//$("#messageArea").html("정보제공에 동의하여 주시기 바랍니다.");
			//return false;
		//}
		
		if(eventLimitDay < nowFormatDay){
			hideLoading();
			$("#messageArea").html("이벤트 응모 기간이 지났습니다.");
			return false;
		}
		
		//출석체크 횟수 체크
		if(nullToBlank(atChkCnt) != '') {
			console.log("<<atChkCnt=" + atChkCnt + "lastDay=" + lastDay);
			if(atChkCnt >= 10 && atChkCnt < 15) {
				//console.log("<<eventAttendPop attendChkCnt=" + attendChkCnt);
				if(attendChkCnt < 10) {
					hideLoading();
					$("#messageArea").html("응모대상이 아닙니다.");
					return false;
				}
				$("#ten_attend").text("응모하셨습니다").css({"color":"white","font-size":".8em"});
				$("#ten_attend").addClass("event_off");
			}
			
			if(atChkCnt >= 15 && atChkCnt < lastDay) {
				if(attendChkCnt < 15) {
					hideLoading();
					$("#messageArea").html("응모대상이 아닙니다.");
					return false;
				}
				$("#fifteen_attend").text("응모하셨습니다").css({"color":"white","font-size":".8em"});
				$("#fifteen_attend").addClass("event_off");
			}
			
			if(atChkCnt >= 100) {
				if(attendChkCnt < lastDay) {
					hideLoading();
					$("#messageArea").html("응모대상이 아닙니다.");
					return false;
				}
				$("#hundread_attend").text("응모하셨습니다").css({"color":"white","font-size":".8em"});
				$("#hundread_attend").addClass("event_off");
				
			} 
		}
		
		//console.log(">>>>>>출석체크횟수" + atChkCnt);
		
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
		formData.append('roundApplyCnt', applyCount);
	 	if(atChkCnt >= 10 && atChkCnt < 15) //10회이상 출석
			formData.append('event_chgubun', "01");
		else if(atChkCnt >= 15 && atChkCnt < lastDay)//15회이상 출석
			formData.append('event_chgubun', "02");
		else if(atChkCnt >= 100) //100% 출석
			formData.append('event_chgubun', "03"); 
	 	
	 	console.log("applyCount=" + applyCount);
	 		 		 	
		cfn_ajax({
			type : "POST",
			async : false,
			url: "<c:url value='/event/insertEventAttend.do' />",
			data: formData,
			dataType: "json",
			cache : false,
			noloading : "no",
			timeOut : 60 * 5 * 1000,
			success: function(res) {
				retCode = res.resultCode;
				if(retCode == "ok"){
					//$("#messageArea").html("정상적으로 참여되었습니다.");
					$("#messageArea").html("출석체크 완료!\n 내일도 잊지마세요.");
				}else if(retCode == "duplication") {
					$("#messageArea").html("오늘은 이미 참여 하셨습니다.");
				}
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
	
	function closePopup() {
		if(retCode == 'ok') {
			fn_attendChkDay(<%=nowday%>);
		}
		
		jQuery('html, body').css({'overflow':'auto'});
		if(jQuery('.layerPopup').size()){
			jQuery('.layerPopup').remove();                 
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
						<strong class="popTitle">출석체크</strong>
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
				<div class="layerBtns"><button type="button" class="layerClose1 layerClose" onclick="closePopup();">확인</button></div>
			</div>
	    </div>
	</div>
</body>