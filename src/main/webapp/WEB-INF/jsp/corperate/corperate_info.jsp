<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
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
	});
	
</script>
</head>
<body>
<!--content-->    
	<div role="main" class="ui-content contentWrap">
		<div data-role="navbar" data-iconpos="right" class="nav">
			<ul>
				<!-- <li><a href="#corperatePop" data-rel="popup" data-icon="carat-d" class="ui-nodisc-icon ui-alt-icon">법인상용</a></li> -->
				<li><a href="#" class="layerOpener ui-btn-active ui-nodisc-icon ui-alt-icon" data-icon="carat-d" data-url="/corperatePop.do" data-width="300" data-height="400" data-ok="yes" data-ctn="full">법인상용</a></li>
			</ul>
		</div>
		<div data-role="tabs" id="wrap" class="event lawlotte">
			<div id="tab1" class="corperate_info">
				<!--법인상용 내용-->
				<p class="img_01">
					<img src="/resources/images/img/logo_01.png" style="width: 10em;">
				</p>
				<p class="txt_01">
					<span>법인영업팀</span>은 롯데그룹의 유통 인프라 &amp; JTB의 글로벌 네트워크를 <br />
					활용한 차별화된 서비스로 신속, 정확한 업무 처리를 통하여 <br /> 기업 및 법인 고객을 만족시킬 수 있는<br />
					믿음직한 파트너가 되도록 노력하겠습니다.
				</p>
				<div class="infobg">	
					<ul>
						<li class="title">단체여행 상담신청
							<p>
								<img src="/resources/images/ico/icon_corperate_info_01.png" style="width: 4em;">
							</p>
						</li>
						<li class="txt1">해외, 국내(제주) 기업체 연수/ 국내 전시회, 학회, 학교 수학여행/일반 해외 단체행사를 담당하여 고객님께 편안한 여행을 제공합니다.</li>
						<li class="txt2">문의전화 <span>02-6313-8252</span></li>
					</ul>
				</div>

				<ul class="info_1">
					<li class="title">국내골프연수</li>
					<li class="txt1">국내버스 수배<br /> 국내골프, 세미나 행사<br /> 여행상품권 판매 </li>
					<li class="txt2">이재웅 대리<br /> TEL : 02-6313-8255<br /> E-mail : jwlee1@lottejtb.com </li>
					<!-- <li class="txt2">이수정 담당<br /> TEL : 02-6313-8257<br /> E-mail : sjlee2@lottejtb.com </li> -->
				</ul>
				<ul class="info_1">
					<li class="title">기업, 공무원 연수</li>
					<li class="txt1">기업의 임직원 해외연수<br /> 경품행사용 프로모션등 단체<br /> 행사 기획 및 운영</li>
					<li class="txt2">양창수 매니저<br /> TEL : 02-6313-8251<br /> E-mail : csyang@lottejtb.com</li>
					<li class="txt2">이재웅 담당<br /> TEL : 02-6313-8255<br /> E-mail : jwlee1@lottejtb.com</li>
				</ul>
				<ul class="info_1">
					<li class="title">학교법인 연수</li>
					<li class="txt1">초중고 수학여행 및 체험여행<br /> 대학원 졸업여행 및 해외연수<br />교직원 해외연수</li>
					<li class="txt2">김창헌 매니저<br /> TEL : 02-6313-8261<br />E-mail : chkim@lottejtb.com</li>
					<li class="txt2">강성태 대리<br /> TEL : 02-6313-8262<br />E-mail : stkang@lottejtb.com</li>
				</ul>
				<ul class="info_1">
					<li class="title">해외전시회 및 세미나</li>
					<li class="txt1">기업임직원 해외연수 및 세미나<br /> 해외전시회 참관 및 부스 참가단<br />해외 세미나 참석 및 개최</li>
					<li class="txt2">인명기 매니저<br /> TEL : 02-6313-8253<br />E-mail : mgin@lottejtb.com</li>
					<li class="txt2">권효준 대리<br /> TEL : 02-6313-8254<br />E-mail : hjkwon1@lottejtb.com</li>
				</ul>
			</div><!--//법인상용 내용-->
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//contentWrap End-->
</body>