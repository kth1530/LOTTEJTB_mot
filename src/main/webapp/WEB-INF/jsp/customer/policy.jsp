<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<style>
.table_box table td{height: 33px;text-align: center;font-size: 13px;vertical-align: middle;}
</style>
<script type="text/javascript">

	// 초기화
	var fn_init = function() {
	};
			
	// 버튼 초기화
	var fn_initButton = function() {
	};
	
	$(document).ready(function(){
		fn_init();
		fn_initButton();
		$("#policyList").trigger("change");
	});
	
	$(document).off("change", "#policyList");
	$(document).on("change", "#policyList", function(){
		var version = $(this).val();
		
		setContents(version,function(data){

			$("#policyBody").html("");
			$("#policyBody").html(data);
		    $('body,html').animate({
		        scrollTop: 0
		     }, 250);
		},
		function(err){
			alert("페이지를 불러오는 중 오류가 발생하였습니다. 다시 시도해 주세요.");
			//location.href = "/customer/policy.do";
			return;
		});
		
	});

	function setContents(version,succCallback,errorCallback){
	    var url = "/customer/selectPolicy.do";
	    $.ajax({
	        type : 'GET',
	        data : {version:version},
	        dataType : 'html',
	        url: url,
	        success : function(data) {
	        	var html = $(data).find(".policy_contents").html();
	            succCallback(html);
	        },
	        error:function(data){
	            errorCallback(data);
	        }
	    });
	};
	
</script>
</head>
<body>
<!--content-->    
	<div role="main" class="ui-content contentWrap">
		<div class="nav navstitle">개인정보 보호 약관</div>

		<div data-role="tabs" class="policy">
			<!--해외여행이용약관 Tab-->
			<div class="faq_box mgT10">
				<div class="faq_box_txt st2">
					<span class="box">롯데제이티비는 아래와 같이 개인정보 보호를 매우 중요하게 생각하고 있습니다.</span>
					<p class="faq_box_p">따라서 롯데제이티비는 고객님의 소중한 개인정보 보호를 위해 아래와 같은 사항을 원칙으로 준수하고 있습니다. 하기의 원칙들은 롯데제이티비의 정책 변화에 따라 수시로 변경될 수 있으므로, 정기적으로 방문하시어 확인해 주시길 바랍니다.</p>
				</div>
			</div>
			<div id="policyBody">
				
			</div>
			
			<!-- [JEH]개인정보 처리방침 이력 추가 20180711 -->
			<div>
				<select id="policyList" name="policyList">
					<option value="20210729">개인정보 처리방침 (2021.07.29)</option>
					<option value="20210708">개인정보 처리방침 (2021.07.08)</option>
					<option value="20191008">개인정보 처리방침 (2019.10.08)</option>
					<option value="20190529">개인정보 처리방침 (2019.05.29)</option>
					<option value="20180626">개인정보 처리방침 (2018.06.26)</option>
					<option value="20171019">개인정보 처리방침 (2017.10.19)</option>
					<option value="20170517">개인정보 처리방침 (2017.05.17)</option>
					<option value="20161019">개인정보 처리방침 (2016.10.19)</option>
					<option value="20160330">개인정보 처리방침 (2016.03.30)</option>
					<option value="20070701">개인정보 처리방침 (2007.07.01)</option>
				</select>
			</div>
			<!-- //clauseList -->
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
	</div><!--//contentWrap End-->
</body>