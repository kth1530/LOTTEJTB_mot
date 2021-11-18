<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">

	// 초기화
	var fn_init = function() {
		setTimeout(function(){
			cordova.getAppVersion.getVersionNumber(function (version) {
			    $("#appVersion").html("버전: "+ version);
			});
		}, 500);
		
		if(ios){
			$("#onlyIOS").show();
		}else{
			$("#onlyIOS").hide();
		}
	};
			
	// 버튼 초기화
	var fn_initButton = function() {
		var adAgree = window.localStorage.getItem("adAgreement");
				
		if(adAgree == "true"){
			//$("#flip-7").val('on').flipswitch('refresh');
		}
		
		try{
			setTimeout(function(){
				if(nullToBlank(device.uuid) != ""){
					var formData = new FormData();
					formData.append('deviceId', device.uuid);
					
					cfn_ajax({
						url: "/setting/selectMarketingReceiveYn.do",
						type: "POST",
						data: formData,
						async: false,
						cache: false,
						dataType: "json",
						noloading:"no",
						success: function(res) {
							var result = res.list;
							
							if(result.marketingYn == "Y"){
								$("#flip-7").val('on').flipswitch('refresh');
							}else{
								$("#flip-7").val('off').flipswitch('refresh');
							}
						},
						error:function(err){
						},
						complete:function(){
							$("#flip-7").change(function(){
								if($(this).val() == "on"){
									agreePopup('Y');
								}else{
									agreePopup('N');
								}
							});
						}
					});
				}else{
					$("#flip-7").change(function(){
						if($(this).val() == "on"){
							agreePopup('Y');
						}else{
							agreePopup('N');
						}
					});
				}
			}, 500);
		}catch(e){
			$("#flip-7").change(function(){
				if($(this).val() == "on"){
					agreePopup('Y');
				}else{
					agreePopup('N');
				}
			});
		}
	};
	
	$(document).ready(function(){
		fn_init();
		fn_initButton();
	});
	
</script>
</head>
<body>
<!--content-->    
	<div role="main" class="ui-content contentWrap">
		<div class="navstitle">설정</div>
		<!-- 
	 	<div data-role="navbar" data-iconpos="right" class="nav">
			<ul><li><a href="#">설정</a></li></ul>
	  	</div>
	  	-->
	   	<div class="setting mgT10">
			<div class="collapsDiv">
				<div class="collapsHeading">
					<span class="title">마케팅(광고성) 앱 알람받기</span>
					<div class="ui-field-contain switchbtn">
						<select name="flip-7" id="flip-7" data-role="flipswitch" data-mini="true">
							<option value="off">OFF</option>
							<option value="on">ON</option>
						</select>
					</div>
					
					<br/><em>다양한 이벤트 소식 혜택 정보를 알림으로 받으세요</em>
				</div>
		     	<div class="collapsContent settext">					     		
		     		<i id="onlyIOS" style="display:none;">※ 알림이 오지 않을경우, 아이폰>설정>알림에서 롯데 JTB의 알림설정을 확인해주세요.</i>
					<b>푸시 알림을 위한 개인정보 수집 및 이용동의(선택)</b>
					<i>이용목적: 알림서비스</i>
					<i>항목:디바이스 식별자</i>
					<i>보유 및 이용기간:회원탈퇴시까지</i>
					<span id="appVersion"></span>
				</div>
		    </div> 	
		</div>
			
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div><!--//contentWrap End-->
</body>