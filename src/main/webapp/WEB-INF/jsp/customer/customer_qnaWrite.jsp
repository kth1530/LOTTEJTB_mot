<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
					<style type="text/css">
					table{border-collapse:collapse; border-spacing:0px; empty-cells:show; table-layout:fixed;width:100%}
					.bg2 {border-top:1px #aaa;border-bottom:1px solid #aaa;font-size:12px;color:#666;text-align:left;margin:0 -10px 0 -10px}
					.bg2 tbody th {background:#f6f6f8;border-right:1px solid #ddd;padding:10px 15px;border-top:1px solid #ddd;color:#444}
					.bg2 tbody th.left_line {border-left:1px solid #ddd}
					.bg2 tbody td {padding:10px 15px;line-height:140%;border-top:1px solid #ddd}
					.bg2 tbody td label {height:0;line-height:0;margin:0;padding:0;visibility:hidden;width:0;float:left}
					.bg2 select {border: 1px solid #ddd;height: 30px;vertical-align: middle;width: 148px;}				
					.bg2 tbody px {vertical-align:middle !important;}
					</style>
<script type="text/javascript">
	var custCd = "${custCd}";
	var knm = "${knm}";
	var age = "${age}";
	var sex = "${sex}";
	
	// 초기화
	var fn_init = function() {		
		fn_codeSetting();
	};
			
	// 버튼 초기화
	var fn_initButton = function() {
	};
	
	var fn_codeSetting = function(){
		cfn_ajax({
			type: "POST",
			async: false,
			url: "<c:url value='/customer/selectQnaCode.do' />",
			dataType: "json",
			cache: false,
			noloading:"no",
			success: function(res) {
				conetCode = res.conetCode;
				mailCode = res.mailCode;
				hpCode = res.hpCode;
				
				for(var i = 0; i < conetCode.length; i++){
					$("#consultTypeCd").append("<option value='"+ conetCode[i].cd +"'>"+ conetCode[i].cdNm +"</option>");
				}
				
				for(var i = 0; i < mailCode.length; i++){
					$("#email2").append("<option value='"+ mailCode[i].cd +"'>"+ mailCode[i].cdNm +"</option>");
				}
				
				for(var i = 0; i < hpCode.length; i++){
					if(i == 0){
						$("#handphone1").append("<option value='"+ hpCode[i].cd +"' selected>"+ hpCode[i].cdNm +"</option>");
					}else{
						$("#handphone1").append("<option value='"+ hpCode[i].cd +"'>"+ hpCode[i].cdNm +"</option>");
					}
				}
			},
			error:function(err){
				console.log(err);
			},
			complete:function(){
				$("#handphone1").selectmenu("refresh", true);
			}
		});
	}
	
	// [COMMON] 공통사항 
	// 공지사항 목록 보기 
	function fn_goNoticeList() {
		document.location.href = "/customer/noticeList.do";
	}
	
	// 자주찾는 질문 목록 보기 
	function fn_goFaqList() {
		document.location.href = "/customer/faq.do";
	}

	//묻고 답하기 목록 보기 
	function fn_goQnaList() {
		document.location.href = "/customer/qnaList.do";
	}

	// 이벤트쿠폰
	function fn_goCouponList() {
		document.location.href = "/customer/coupon.do";
	}
	
	function fn_saveConsult(){
		var email = "";
		var emailYn;
		var smsYn;
		var check = $("#consultTypeCd").val();
		var pnr   = $("#pnrNum").val();
		if(check=='03'){
			if(pnr==''){
			alert("항공문의 시 항공예약번호를 입력부탁드립니다.");
			return false;
			}
		}
				
		if(nullToBlank($("#consultTitle").val()) == ""){
			alert("문의종류를 입력하세요.");
			return false;
		}
		
		if(nullToBlank($("#consultTypeCd").val()) == "" || $("#consultTypeCd").val() == "-- 선택하기 --"){
			alert("상담구분을 선택하세요.");
			return false;
		}
		
		if(nullToBlank($("#remark").val()) == ""){
			alert("내용을 입력하세요.");
			return false;
		}
		
		if(nullToBlank($("#emailYn:checked").val()) != ""){
			
			var check = document.getElementById("perYnY").checked;
			if(check==false){
				alert("이메일수신 또는 sms수신 시 개인정보 이용에 동의 부탁드립니다.");
				return false;	
			}
					
			if(nullToBlank($("#email1").val()) == ""){
				alert("이메일을 입력하세요.");
				return false;
			}
			if(nullToBlank($("#email2").val()) == "" || $("#email2").val() == "-- 선택하기 --"){
				alert("이메일을 입력하세요.");
				return false;
			}
			
			var remail2 = $("#email2 option:selected").text();
			//email = $("#email1").val() + "@" + $("#email2").val();
			email = $("#email1").val() + "@" + remail2;
			emailYn = 'Y';
		}else{
			emailYn = 'N'
		}
		
		if(nullToBlank($("#smsYn:checked").val()) != ""){
			var check = document.getElementById("perYnY").checked;
			if(check==false){
				alert("이메일수신 또는 sms수신 시 개인정보 이용에 동의 부탁드립니다.");
				return false;	
			}
						
			if(nullToBlank($("#handphone1").val()) == "" || $("#handphone1").val() == "없음"){
				alert("핸드폰 번호를 입력하세요.");	
				return false;
			}
			if(nullToBlank($("#handphone2").val()) == ""){
				alert("핸드폰 번호를 입력하세요.");	
				return false;
			}
			if(nullToBlank($("#handphone3").val()) == ""){
				alert("핸드폰 번호를 입력하세요.");
				return false;
			}
			
			smsYn = 'Y'
		}else{
			smsYn = 'N'
		}
				
		var formData = new FormData();
		formData.append('consultTitle', $("#consultTitle").val());
		formData.append('consultTypeCd', $("#consultTypeCd").val());
		formData.append('remark', $("#remark").val());
		formData.append('emailYn', emailYn);
		formData.append('email', email);
		formData.append('smsYn', smsYn);
		if(smsYn == 'Y'){
			formData.append('handphone1', $("#handphone1").val());
			formData.append('handphone2', $("#handphone2").val());
			formData.append('handphone3', $("#handphone3").val());
		}else{
			formData.append('handphone1', "");
			formData.append('handphone2', "");
			formData.append('handphone3', "");
		}
		formData.append('titleYn', $('input[name="titleYn"]:checked').val());
		formData.append('insId', $("#insId").val());
		formData.append('channelCd', $("#channelCd").val());
		formData.append('incFg', $("#incFg").val());
		formData.append('consultMstCd', $("#consultMstCd").val());
		formData.append('procCd', $("#procCd").val());
		formData.append('insDeptCd', $("#insDeptCd").val());
		formData.append('resCd', $("#pnrNum").val());
		
		formData.append('custCd', custCd);
		formData.append('resNm', knm);
		formData.append('age', age);
		formData.append('sex', sex);
		
		cfn_ajax({
			type: "POST",
			async: false,
			url: "<c:url value='/customer/insertConsultQna.do' />",
			data: formData,
			dataType: "json",
			cache: false,
			noloading:"no",
			success: function(res) {
				pageBack();
			},
			error:function(err){
				console.log(err);
			},
			complete:function(){
			}
		});
	}
	
	function fn_moveList(){
		pageBack();
	}
	
	function noMulticheckA(){
		var check = document.getElementById("perYnY").checked;
		if(check==true){
			$('input:checkbox[id="perYnN"]').attr("checked",false);
		}else{
			$('input:checkbox[id="perYnY"]').attr("checked",false);
		}
	}
	function noMulticheckB(){
		var check = document.getElementById("perYnN").checked;
		if(check==true){
			$('input:checkbox[id="perYnY"]').attr("checked",false);
		}else{
			$('input:checkbox[id="perYnN"]').attr("checked",false);
		}
	}	


	$(document).ready(function(){
		fn_init();
		fn_initButton();
	});
	
</script>
</head>
<body>
<!--content-->    
	<div role="main" class="ui-content contentWrap">
		<div data-role="navbar" data-iconpos="right" class="nav">
			<ul>
				<!-- <li><a href="#navPop" data-rel="popup" data-icon="carat-d" class="ui-nodisc-icon ui-alt-icon">고객센터</a></li> -->
				<li><a href="#" class="layerOpener ui-btn-active ui-nodisc-icon ui-alt-icon" data-icon="carat-d" data-url="/customerPop.do" data-width="300" data-height="400" data-ok="yes" data-ctn="full">고객센터</a></li>
			</ul>
		</div>
		<div class="customer qna">
			<div data-role="navbar" class="tabsnav mgT10">
				<ul>
					<li><a href="javascript:fn_goNoticeList();" data-theme="a" data-ajax="false">공지사항</a></li>
					<li><a href="javascript:fn_goFaqList();" data-theme="a" data-ajax="false" class="letterS">자주찾는질문</a></li>
					<li><a href="javascript:fn_goQnaList();" data-theme="a" data-ajax="false" class="ui-btn-active">묻고답하기</a></li>
					<li><a href="javascript:fn_goCouponList()" data-theme="a" data-ajax="false">상품권/쿠폰</a></li>
				</ul>
			</div>
			<div class="tabContent">
				<ul data-role="listView" class="write">
					<li>
						<dl>
							<dt>문의종류</dt>
							<dd><input type="text" name="consultTitle" id="consultTitle"></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>상담구분</dt>
							<dd>
								<select name="consultTypeCd" id="consultTypeCd">
									<option> -- 선택하기 -- </option>
								</select>
							</dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>항공예약번호</dt>
							<dd>
							<input type="text" name="pnrNum" id="pnrNum" maxlength="15" 
							placeholder="8자리 숫자 또는 6자리 영문/숫자를 입력하세요. "></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>내용</dt>
							<dd><textarea name="remark" id="remark"></textarea></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>공개여부</dt>
							<dd>
								<input type="radio" name="titleYn" id="titleY" value="Y" checked>
								<label for="titleY"><span class="radioTxt">공개</span></label> 
								<input type="radio" name="titleYn" id="titleN" value="N">
								<label for="titleN"><span class="radioTxt">비공개</span></label>
							</dd>
						</dl>
					</li>
					<li class="bg">
						<span class="tit">
							<input type="checkbox" name="emailYn" id="emailYn" value="Y">
							<label for="emailYn"><span class="letterS">이메일수신</span></label>
						</span> 
						<span class="input">
							<input type="email" name="email1" value="" id="email1">
							<span class="divide">@</span>
							<select name="email2" class="input" id="email2">
								<option> -- 선택하기 -- </option>
							</select>
						</span>
					</li>
					<li class="bg">
						<span class="tit">
							<input type="checkbox" name="smsYn" id="smsYn" value="Y">
							<label for="smsYn"><span>SMS 수신</span></label>
						</span> 
						<select name="handphone1" class="input" id="handphone1">
						</select> 
						<input type="number" name="handphone2" id="handphone2" value="">
						<span class="hyphen"></span>
						<input type="number" name="handphone3" id="handphone3" value="">
					</li>
					<li class="bg2" style="background:#f6f6f8">
					<span style="font-size:13px;line-height:20px;"><b>1.개인정보 수집 및 이용</b><br/>
					1)당사는 여행상품의 예약 및 여행관련 서비스 제공 등의 업무처리를 위하여 아래와 같이 고객으로 부터 최소한의 정보를 수집하며,제공한 모든 개인정보는 별도의 동의가 없는 한 여행목적 이외의 다른 목적으로 사용하지<br/> 않습니다.
					</span><br/>
					</li>
					
					<li class="bg2" style="background:#d2d2d5;" >
						<table>
							<caption>
							선택, 여행기간, 상품가격으로 나타낸 표
							</caption>
							<colgroup>
								<col width="35%"/>
								<col width="35%"/>
								<col width="25%"/>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row" style="text-align: center;" class="px">수집하는 항목</th>
									<th scope="row" style="text-align: center;" class="px">이용목적</th>
									<th scope="row" style="text-align: center;" class="px">보유 및 이용기간</th>
								</tr>
								<tr style="background:#ffffff">
									<td style="border-right:1px solid #ddd;">
										<p style="text-align: center;">성명,연락처,주소,이메일주소</p>
									</td>
									<td style="border-right:1px solid #ddd;">
											<p>소비자의 불만 및 문의 사항 답변</p>
									</td>
									<td style="text-align: center;vertical-align:middle;">
									    <p>3년</p>
									</td>
								</tr>									
							</tbody>
						</table>
					</li>					
					
					<li class="bg2" style="background:#f6f6f8">
					<span style="font-size:13px;line-height:20px;">
					*단,상법 등 법령의 규정의 의하여 거래 관련 권리의무관계의 확인 등을 이유로 일정기간 보유해야 할 필요가 있을 경우에는 관련법령이 정한 기간 동안 보관 할 수 있습니다.
					</span><br/>
					</li>	
					
					<li class="bg2" style="background:#f6f6f8">
					<span style="font-size:13px;line-height:20px;"><b>2. 동의 거부권 및 불이익</b><br/>
					개인정보 수집,이용에 대한 동의를 거부할 권리가 있으나, 동의를 거부할 경우 문의하신 내용에 답변 및 서비스 이용에 제한이 있음을 알려드립니다.
					</span><br/>
					</li>	
					
					<li class="bg2" style="background:#f6f6f8">
						<span style="font-size:13px;line-height:20px;"><b>*개인정보 이용에 동의합니다.본 정보는 서비스 제공을 위한 상담에만 이용됩니다.</b><br/></span>
						<span class="tit">
							<input type="radio" name="perYn" id="perYnY" value="1" onclick="javascript:noMulticheckA(this);">
							<label for="perYnY"><span class="letterS">동의함</span></label>
							<input type="radio" name="perYn" id="perYnN" value="2" onclick="javascript:noMulticheckB(this);">
							<label for="perYnN"><span class="letterS">동의안함</span></label>					
						</span> 					
					</li>															
					


				</ul>
				
				<input type="hidden" name="insId" 			id="insId" 			value="MOBILEUSER" />
				<input type="hidden" name="channelCd" 		id="channelCd" 		value="AA" />
				<input type="hidden" name="incFg" 			id="incFg" 			value="C" />
				<input type="hidden" name="consultMstCd" 	id="consultMstCd" 	value="01" />
				<input type="hidden" name="procCd" 			id="procCd" 		value="AA" />
				<input type="hidden" name="insDeptCd" 		id="insDeptCd" 		value="541000" />
				
				<input type="hidden" name="custCd" 			id="custCd" 		value="123123" />
				<input type="hidden" name="resNm" 			id="resNm" 			value="홍길동" />
				<input type="hidden" name="age" 			id="age" 			value="28" />
				<input type="hidden" name="sex" 			id="sex" 			value="M" />
			</div>

			<div class="more btnBG2">
				<a href="#" onclick="fn_saveConsult()">상담신청</a>
			</div>
			<div class="more">
				<a href="#" onclick="fn_moveList()"><i class="fa fa-bars"></i>목록으로</a>
			</div>
			<div class="clauseTel mgT10">
				<h1>부서별 전화문의</h1>
				<p>
					<i>상담시간 </i><span style="margin-top:10px">평일: 08:00~17:00</span>
				</p>
			</div>
			<div class="clauseTelBox2" >
				<ul>
					<li><p>국내/해외여행문의</p><span>1577-6511</span></li>
					<li><p>항공권상담</p><span>1899-9633</span></li>
					<li><p>기업체여행</p><span>02-6313-8248</span></li>
					<li><p>국내/해외호텔문의</p><span>02-6313-8000</span></li>
				</ul>
			</div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//contentWrap End-->
</body>