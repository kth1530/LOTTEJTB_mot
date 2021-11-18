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
				<!-- <li><a href="#corperatePop" data-rel="popup" data-icon="carat-d" class="ui-nodisc-icon ui-alt-icon">L.point 회사소개</a></li> -->
				<li><a href="#" class="layerOpener ui-btn-active ui-nodisc-icon ui-alt-icon" data-icon="carat-d" data-url="/customerPop.do" data-width="300" data-height="400" data-ok="yes" data-ctn="full">L.POINT 안내</a></li>
			</ul>
		</div>
		<div data-role="tabs" id="wrap" class="event">
			<div id="tab1" class="corperate_info pdb8">
				<!--법인상용 내용-->
				<p class="img_01">
					<img src="/resources/images/img/logo_01.png" style="width: 10em;">
				</p>
				<p class="txt_01">
					<span>롯데제이티비㈜</span>는 L.POINT 회원제를 채택하고 있습니다.
				</p>
				<div class="infobg">
					<ul>
						<li class="title">L.POINT 회원 안내
							<p class="lpTitleimg">
								<img src="/resources/images/bg/bg_lpoint.png">
							</p>
						</li>
						<li class="txt1">L.POINT 회원제란 하나의 ID로 여러 롯데 회사들의 웹사이트 상에서 모든 거래 및 서비스 이용을 편리하고 안전하게 사용할 수 있는 온라인 회원제 서비스입니다.</li>
					</ul>
				</div>
				<ul class="infobg2">
					<li>하나의 ID로 롯데와의 모든 온라인 거래 가능</li>
					<li>한번의 로그인으로 롯데의모든 웹서비스 이용 가능</li>
					<li>롯데 L.POINT 회원제 서비스가 제공되는 사이트에서는 한번의 회원가입으로 로그인, 로그아웃, 정보변경, 회원탈퇴를 모두 한번만 하시면 됩니다.</li>
					<li>일관된 회원관리 시스템을 통한개인정보의 보안 안정성 보장</li>
					<li>롯데 L.POINT 회원제 서비스는 롯데멤버스에서 운영, 관리하며, L.POINT 회원으로 가입하신 분들의 회원정보는L.POINT 회원제 서비스 시스템에서 안전하게 관리됩니다.</li>
				</ul>
				<ul class="infobg3">
					<h3 class="title">L.POINT 적립 및 사용 안내</h3>
					<span style="font-weight: bold;">· 적립안내</span>
					<ul class="ml10 mb10">
						<li>롯데제이티비 L.POINT 기본 적립율은 각 상품별로 <span style="color: #bb0016;">0~0.3%</span> 차등 지급 됩니다. (일부 상품 제외)</li>
						<li>L.POINT 적립은 결제자 본인에 한하여 지급 됩니다.</li>
						<li>포인트 적립은 패키지 여행 상품에 대하여 가능합니다. (호텔, 항공 등 일부 개별 상품 제외)</li>
					</ul>
					
					<span style="font-weight: bold;">· 사용안내</span>
					<ul class="ml10">
						<li>총 상품가의 <span style="color: #bb0016;">최대 10%까지</span> L.POINT를 사용하여 포인트 결제가 가능합니다.</li>
						<li>포인트 결제 후, 차액에 대해서는 카드/계좌입금/상품권 등을 이용한 복합 결제가 가능합니다.</li>
						<li>포인트 사용은 패키지 여행 상품에 대하여 가능합니다. (호텔, 항공 등 일부 개별 상품 제외)</li>
					</ul>
				</ul>
			</div>
			<!--//법인상용 내용-->
			<div class="lpLogo">
				<p class="logoTitle">L.POINT 회원사이트</p>
				<ul>
					<li>
						<p>
							<img src="/resources/images/btn/lpoint_logo1.png" alt="롯데제이티비" />
						</p>
					</li>
					<li>
						<p>
							<img src="/resources/images/btn/lpoint_logo2.gif" alt="롯데마트" />
						</p>
					</li>
					<li>
						<p>
							<img src="/resources/images/btn/lpoint_logo3.gif" alt="롯데백화점" />
						</p>
					</li>
					<li>
						<p>
							<img src="/resources/images/btn/lpoint_logo4.gif" alt="롯데닷컴" />
						</p>
					</li>
					<li>
						<p>
							<img src="/resources/images/btn/lpoint_logo5.gif" alt="롯데슈퍼" />
						</p>
					</li>
					<li>
						<p>
							<img src="/resources/images/btn/lpoint_logo6.gif" alt="롯데카드" />
						</p>
					</li>
					<li>
						<p>
							<img src="/resources/images/btn/lpoint_logo7.gif" alt="롯데시네마" />
						</p>
					</li>
					<li>
						<p>
							<img src="/resources/images/btn/lpoint_logo8.gif" alt="롯데리아" />
						</p>
					</li>
					<li>
						<p>
							<img src="/resources/images/btn/lpoint_logo9.gif" alt="LOTTE HOTELS & RESORTS" />
						</p>
					</li>
					<li>
						<p>
							<img src="/resources/images/btn/lpoint_logo10.gif" alt="롯데월드" />
						</p>
					</li>
					<li>
						<p>
							<img src="/resources/images/btn/lpoint_logo17.gif" alt="롯데면세점"/>
						</p>
					</li>
					<li>
						<p>
							<img src="/resources/images/btn/lpoint_logo12.gif" alt="NATUUR" />
						</p>
					</li>
					<li>
						<p>
							<img src="/resources/images/btn/lpoint_logo18.gif" alt="롯데홈쇼핑" />
						</p>
					</li>
					<li>
						<p>
							<img src="/resources/images/btn/lpoint_logo19.gif" alt="하이마트" />
						</p>
					</li>
					<li>
						<p>
							<img src="/resources/images/btn/lpoint_logo15.gif" alt="세븐일레븐" />
						</p>
					</li>
					<li>
						<p>
							<img src="/resources/images/btn/lpoint_logo20.gif" alt="롭스" />
						</p>
					</li>
				</ul>
			</div>
			<div class="lpoint_noti">
				<div>
					<p style="font-weight:bold;">※ 유의사항</p>
					<ul class="ml10">
						<li>적립하신 L.POINT의 유효기간은 적립일로부터 5년입니다.</li>
						<li>최소 1점의 L.POINT부터 사용이 가능합니다.</li>
						<li>L.POINT 카드 등록방법 및 타 제휴사에서 적립/사용한 내역은 L.POINT 사이트에서 확인하실 수 있습니다.</li>
						<li>L.POINT는 L.POINT 통합회원으로 가입 시 사용 가능합니다.</li>
						<li>본인 명의의 카드로만 조회 및 사용이 가능합니다.</li>
					</ul>
				</div>
			</div>
			
		</div>

		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//contentWrap End-->
</body>