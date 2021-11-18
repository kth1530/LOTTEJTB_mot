<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>

<head>
<script type="text/javascript">
<!--
	// require(["jquery","jquery.blockUI","jquery.mobile"], function($){
	// require(["jquery","jquery.blockUI"], function($){

	// 초기화
	var fn_init = function() {
	};

	var fn_search = function() {

	};

	// 버튼 초기화
	var fn_initButton = function() {

	};

	/* *************************************************************************** */
	// [Ajax] 데이터 통신 부분 
	// [COMMON] 공통사항 
	$(document).ready(function() {
		fn_init();
		fn_initButton();

		/*document.addEventListener("deviceready", function(){
			fn_init();
			fn_initButton();	
			
		}, false);*/
	});

	// });
//-->
</script>
</head>
<body>

	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="collapse freetop">
			<!-- 중복텝 -->
			<div class="free_box">
				<ul class="free_toprst frrst3">
					<li class="aircheck"><input id="aircheck" data-role="none"
						type="checkbox" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="hotelcheck"><input id="hotelcheck" data-role="none"
						type="checkbox" disabled="true" /><label for="hotelcheck">호텔</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none"
						type="checkbox" checked="checked" disabled="true" /><label
						for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<!-- 갯수별 
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" disabled="true" /><label for="hotelcheck">호텔</label></li>
				</ul>
			</div>
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="aircheck">항공</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<div class="free_box">
				<ul class="free_toprst frrst2">
					<li class="hotelcheck"><input id="hotelcheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="hotelcheck">호텔</label></li>
					<li class="carcheck"><input id="carcheck" data-role="none" type="checkbox" disabled="true" /><label for="carcheck">렌터카</label></li>
				</ul>
			</div>
			<div class="free_box">
				<ul class="free_toprst frrst1">
					<li class="aircheck"><input id="aircheck" data-role="none" type="checkbox" checked="checked" disabled="true" /><label for="aircheck">항공</label></li>
				</ul>
			</div>
			-->
			<!-- 간략안내 -->
			<div class="re_sch_lentcar">
				<div class="stable_guide3">
					<p class="st3_stext ellipsis">Los Angeles Airport (LAX)</p>
				</div>
				<div class="txbox1">2016.12.02 ~ 2016.12.05</div>
				<!-- 검색버튼 -->
				<button type="button" data-role="none" class="re_search">재검색</button>
				<!-- 정렬박스 -->
				<ul class="fr_sortbox">
					<li>총 상품 0000개</li>
					<li><button type="button" data-role="none">차량 종류순</button></li>
					<li><button type="button" data-role="none"></button></li>
				</ul>
				<p class="txbox3">영업소 조회 결과 for Hong Kong, HK(2 locations)</p>
				<dl class="fr_lc_wstore">
					<dt>
						<em>1</em><span>MTR Hong Kong Station</span><a href="#"></a>
					</dt>
					<dd>
						<div>
							<p class="chkbox lc_show">
								<span><input id="chk_cusm1" type="checkbox"
									data-role="none" /></span>
							</p>
						</div>
						<label for="chk_cusm1"> Shop hok11,Level L1,<br> Hong
							Kong, Hong Kong<br> 전화번호 : 852-2525-1313<br> 영업시간 :
							Mon-Fri 0930-1800 Sat-Sun 0930-1730<br> 영업소 종류 : 독립 라이센스 영업소
						</label>
					</dd>
					<dt>
						<em>2</em><span>MTR Hong Kong Station</span><a href="#"></a>
					</dt>
					<dd>
						<div>
							<p class="chkbox lc_show">
								<span><input id="chk_cusm2" type="checkbox"
									data-role="none" /></span>
							</p>
						</div>
						<label for="chk_cusm2"> Shop hok11,Level L1,<br> Hong
							Kong, Hong Kong<br> 전화번호 : 852-2525-1313<br> 영업시간 :
							Mon-Fri 0930-1800 Sat-Sun 0930-1730<br> 영업소 종류 : 독립 라이센스 영업소
						</label>
					</dd>
				</dl>
				<!-- 버튼 -->
				<div class="btn_one air_tbtn">
					<button class="white2 moreico" data-role="none">더보기</button>
				</div>




				<!-- *********************** 재검색 레이어 ******************* -->
				<div class="re_schview">
					<!-- 렌터카파트 -->
					<div class="chkpart carpart">
						<div class="car_box">
							<div class="fs_search car_search">
								<p class="schtitle">인수장소</p>
								<div class="csbox">
									<form name="" method="#">
										<fieldset>
											<legend>검색폼</legend>
											<input type="text" data-role="none"
												placeholder="도시, 호텔, 인근도시, 공항 등" />
											<button type="button" data-role="none">검색</button>
										</fieldset>
									</form>
								</div>
							</div>
							<div class="fs_search car_search">
								<div class="schtitle">
									반납위치
									<p>
									<p class="chkbox">
										<label for="chk_cusm3">인수장소와 동일</label> <span><input
											id="chk_cusm3" type="checkbox" data-role="none" /></span>
									</p>
									</p>
								</div>
								<div class="csbox">
									<form name="" method="#">
										<fieldset>
											<legend>검색폼</legend>
											<input type="text" data-role="none"
												placeholder="도시, 호텔, 인근도시, 공항 등" />
											<button type="button" data-role="none">검색</button>
										</fieldset>
									</form>
								</div>
							</div>
							<!-- 날짜와 시간 -->
							<ul class="tra_day tra_day2 cardaytime">
								<li><button type="button" data-role="none">
										<em>차량 인수일</em><span>2016.12.08</span>
									</button></li>
								<li>
									<div class="seatbtn carselbox carselbox">
										<em>인수시간</em> <select name="test" data-role="none">
											<option value="01:00">01:00</option>
											<option value="02:00">02:00</option>
											<option value="03:00">03:00</option>
											<option value="01:00">01:00</option>
										</select>
									</div>
								</li>
							</ul>
							<ul class="tra_day tra_day2 cardaytime">
								<li><button type="button" data-role="none">
										<em>차량 반납일</em><span>2016.12.08</span>
									</button></li>
								<li>
									<div class="seatbtn carselbox carselbox">
										<em>반납시간</em> <select name="test" data-role="none">
											<option value="01:00">01:00</option>
											<option value="02:00">02:00</option>
											<option value="03:00">03:00</option>
											<option value="01:00">01:00</option>
										</select>
									</div>
								</li>
							</ul>
							<!-- 기본버튼 -->
							<div class="seatbtn selectbox carageobx">
								<button type="button" data-role="none">설명</button>
								<select name="test" data-role="none" class="centerSelect">
									<option value="">운전자 나이 (인수일 기준)</option>
									<option value="18">18</option>
									<option value="19">19</option>
									<option value="20">20</option>
								</select>
							</div>
							<!-- 버튼 -->
							<div class="btn_one air_tbtn">
								<button class="purple2" data-role="none">렌터카 검색하기</button>
							</div>
						</div>
					</div>

					<!-- 버튼
					<div class="btn_one air_tbtn ttsch"><button class="purple2" data-role="none">검색하기</button></div>
					 -->
					<!-- 닫기튼 -->
					<button type="button" data-role="none" class="re_search_close">닫기</button>
				</div>
			</div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//content-->