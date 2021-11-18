<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">
	var tab = "${tab}";

	// 초기화
	var fn_init = function() {		
		if(nullToBlank(tab) != ""){
			switch(tab){
			case 1:
			case '1':
				$("#tabMenu1").click();
				break;
			case 2:
			case '2':
				$("#tabMenu2").click();
				break;
			case 3:
			case '3':
				$("#tabMenu3").click();
				break;
			default :
				break;
			}
		}
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
				<!-- <li><a href="#corperatePop" data-rel="popup" data-icon="carat-d" class="ui-nodisc-icon ui-alt-icon">회사소개</a></li>  -->
				<li><a href="#" class="layerOpener ui-btn-active ui-nodisc-icon ui-alt-icon" data-icon="carat-d" data-url="/corperatePop.do" data-width="300" data-height="400" data-ok="yes" data-ctn="full">회사소개</a></li>
			</ul>
		</div>
		<div data-role="tabs" id="wrap" class="event">
			<div data-role="navbar" class="tabsnav mgT10">
				<ul>
					<li><a href="#tab1" id="tabMenu1" data-theme="a" data-ajax="false" class="ui-btn-active">회사소개</a></li>
					<li><a href="#tab2" id="tabMenu2" data-theme="a" data-ajax="false">조직도</a></li>
					<li><a href="#tab3" id="tabMenu3" data-theme="a" data-ajax="false">찾아오시는길</a></li>
				</ul>
			</div>
			<div id="tab1" class="corperate" style="min-height: 58.5em;">
				<!--회사소개-->
				<p class="img_01">
					<img src="/resources/images/img/logo_01.png" style="width: 10em;">
				</p>
				<p class="txt_01">
					대한민국 최고의 유통그룹 롯데의 풍부한 관광 인프라와<br /> 
					세계적 여행기업인 JTB의 글로벌 네트워크를 활용하여 꿈과<br /> 
					희망을 제공하는 여행 관광 전문회사 입니다.
				</p>
				<div class="collapsContent">
					<table>
						<caption>회사명, 홈페이지, 설립일, 대표이사, 소재지, 자본금, 전화/팩스, 전자우편, 매장수, 임직원수 순으로 나타낸 표</caption>
						<colgroup>
							<col width="35%">
							<col width="65%">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">회사명</th>
								<td>롯데제이티비 주식회사</td>
							</tr>
							<tr>
								<th scope="row">홈페이지</th>
								<td>www.lottejtb.com</td>
							</tr>
							<tr>
								<th scope="row">설립일</th>
								<td>2007년 5월 25일</td>
							</tr>
							<tr>
								<th scope="row">영업개시일</th>
								<td>2007년 7월 1일</td>
							</tr>
							<tr>
								<th scope="row">대표이사</th>
								<td>박재영</td>
							</tr>
							<tr>
								<th scope="row">소재지</th>
								<td>본사 : 서울특별시 종로구 율곡로 88 삼환빌딩 3층 롯데제이티비(주)  우)03131
									<br/>부산지사 : 부산광역시 중구 중앙대로 117 독일빌딩 3층  우)48924
<!-- 									<br/>대구지사 : 대구광역시 중구 동덕로 115 진석타워 1612호  우)41940 -->
									<br/>광주지사 : 광주광역시 서구 상무연하로 112 제갈량빌딩 B동 307호  우)61947
									<br/>대전지사 : 대전광역시 서구 둔산중로 66 메트로팰리스 302호  우)35240
<!-- 									<br/>전주지사 : 전라북도 전주시 덕진구 기린대로 568 3층  우)54897 -->
									<!-- <br/>제주지사 : 제주특별자치도 제주시 노연로25 투어타운 503호  우)63081 -->
								</td>
							</tr>
							<tr>
								<th scope="row">자본금</th>
								<td>440억원</td>
							</tr>
							<tr>
								<th scope="row">전화/팩스</th>
								<td>본사 : TEL 02)6313-8000, FAX)02-6234-1511
									<br/>부산지사 : TEL 1577-2511
								</td>
							</tr>
							<tr>
								<th scope="row">전자우편</th>
								<td>webmaster@lottejtb.com</td>
							</tr>
							<tr>
								<th scope="row">매장수</th>
								<td>직영점 및 지사 9개소, 대리점 155개소, 일본 4개소 (2019년 5월 기준)</td>
							</tr>
							<tr>
								<th scope="row">임직원수</th>
								<td>250명 (2019년 5월 기준)</td>
							</tr>
						</tbody>
					</table>
				</div>
				<p class="txt_02">
					<span>믿음,창의, 즐거움을 담아</span><br /> 행복한 추억을 만들어 드립니다.
				</p>
				<p class="txt_01">
					롯데그룹의 온오프라인 유통망을 통해 <br /> 
					사랑(LOVE), 자유(LIBERTY), 풍요로운 삶(LIFE)을 영위할 수 있는<br /> 
					고품격 여행서비스를 제공할 것을 약속드립니다. <br /> 
					지금부터 믿을 수 있는 여행사 롯데제이티비의<br /> 
					신개념 여행서비스를 느껴보십시오.
				</p>
				<div class="collapsContent">
					<ul class="bg_icon_01">
						<li class="bg_01">믿음<br />Trust </li>
						<li class="bg_02">창의<br />Originality </li>
						<li class="bg_03">즐거움<br />Pleasure </li>
						<li class="bg_04">추억<br />Memory </li>
					</ul>
				</div>
			</div>
			<!--//회사소개-->
			<div id="tab2" class="corperate tab2_bg" style="min-height: 37.5em;">
				<!--조직도-->
				<ul class="tab_bg1">
					<li class="t_bg1">대표이사</li>
					<ul class="tab_bg1_new">
						<img src="/resources/images/bg/bg_orga1.gif" />
						<li class="t_bg1_new">신사업</li>
						<img src="/resources/images/bg/bg_orga1.gif" style="left: 40%;" />
						<li class="t_bg1_new" style="float: left;">내부통제실</li>
					</ul>
				</ul>
				<ul class="tab_bg2">
					<li class="tab_bg2_tile">경영지원부문</li>
					<li>기획</li>
					<li>인사총무</li>
					<li>재무</li>
					<li>영업전략</li>
				</ul>
				<ul class="tab_bg2">
					<li class="tab_bg2_tile">인바운드부문</li>
					<li>일본<br />인바운드</li>
					<li>HTL & DPS</li>
					<li>글로벌<br />비즈니스</li>
				</ul>
				<ul class="tab_bg2">
					<li class="tab_bg2_tile">아웃바운드부문</li>
					<li>상품기획1</li>
					<li>상품기획2</li>
					<li>크루즈센터</li>
					<li>매장&법인영업</li>
					<li>MICE</li>
					<li>항공전략</li>
				</ul>
			</div>
			<!--//조직도-->
			<div id="tab3">
				<!--찾아오시는길-->
				<div class="corperate">
					<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3162.0778835884207!2d126.98672391599337!3d37.57678367979598!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca2db78561659%3A0x474ed5dc09ffe443!2z7IK87ZmY67mM65Sp!5e0!3m2!1sko!2skr!4v1498037548890" width="100%" height="200" frameborder="0" style="border:0" allowfullscreen></iframe>
					<ul class="map">
			        	<li><img src="/resources/images/ico/icon_corperate_01.gif"></li>
			        	<li>주소: </li>
			        	<li> 서울특별시 종로구 율곡로 88 삼환빌딩 3층 우)03131</li>
			     	</ul>
			       	<ul class="map">
			        	<li><img src="/resources/images/ico/icon_corperate_02.gif"></li>
			        	<li>연락처: </li>
			        	<li> 02-6313-8000</li>
					</ul>
				</div>
				<div class="corperate">
					<div class="collapsContent map">
						<table>
							<caption>지하철로 오실때, 버스로 오실때, 자가용으로 오실때 순으로 나타낸 표</caption>
							<colgroup>
								<col width="40%">
								<col width="60%">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">지하철로 오실때</th>
									<td>3호선 안국역 4번 출구 이용 가든타워빌딩 방향 도보 5분</td>
								</tr>
								<tr>
									<th scope="row">버스로 오실때</th>
									<td>
										창덕궁. 서울돈화문국악당역(01-199)<br />
										[간선] 109, 151, 162, 171, 172, 272, 601<br /> 
									</td>
								</tr>
								<!-- <tr>
									<th scope="row">자가용으로 오실때</th>
									<td>
										[정릉 방면에서 오실 때]<br /> 
										홍은램프출구 → 홍은사거리방면 → 홍은사거리에서 녹번역(불광, 연신내) 방면으로 우회전 → 녹번역 지나 50M 정도 직진하면 우측에 위치<br /> 
										[성산 방면에서 오실 때]<br /> 
										홍제램프출구 → 홍은사거리방면 → 홍은사거리에서 녹번역 (불광, 연신내) 방면으로 좌회전 → 녹번역 지나 50M 정도 직진하면 우측에 위치
									</td>
								</tr> -->
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!--찾아오시는길-->
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//contentWrap End-->
</body>