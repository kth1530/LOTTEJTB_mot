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
	<div role="main" class="ui-content contentWrap">
		<div data-role="navbar" data-iconpos="right" class="nav">
			<ul>
				<li><a href="#navPop" data-rel="popup" data-icon="carat-d"
					class="ui-nodisc-icon ui-alt-icon">MY TOUR</a></li>
			</ul>
		</div>
		<div data-role="tabs" class="mytour mgT10">
			<div class="tltBox">
				<p>고객등급</p>
				<span>홍길동 고객님의 등급은 일반고객입니다.</span>
			</div>
			<div class="cntBox mycntbox">
				<dl class="one">
					<dt>L.POINT 안내</dt>
					<dd>
						<a href="#">L.POINT 상세조회</a>
					</dd>
				</dl>
				<dl>
					<dt>사용가능한 포인트</dt>
					<dd>
						<span>9,000</span>원
					</dd>
				</dl>
				<dl>
					<dt>잔여 포인트</dt>
					<dd>
						<span>9,000</span>원
					</dd>
				</dl>
			</div>
			<div data-role="navbar" class="tabsnav">
				<ul>
					<li><a href="#tab1" data-theme="a" data-ajax="false"
						class="ui-btn-active">예약내역</a></li>
					<li><a href="#tab2" data-theme="a" data-ajax="false">찜 내역</a></li>
					<li><a href="#tab3" data-theme="a" data-ajax="false">참여내역</a></li>
					<li><a href="#tab4" data-theme="a" data-ajax="false">정보관리</a></li>
				</ul>
			</div>
			<!--L.POINT 회원 로그인 Tab-->
			<div id="tab1" class="tabContent mytrctn">
				<div class="contentBox">
					<!--tab1 Start-->
					<div data-role="collapsible" data-iconpos="right">
						<h1 class="ui-nodisc-icon ui-alt-icon">예약내역</h1>
						<div class="listContent" style="width: 100%">
							<div class="cntP">
								<form>
									<label for="checkbox-0"><input type="checkbox"
										name="checkbox-0 ">전체</label> <label for="checkbox-1"><input
										type="checkbox" name="checkbox-1 ">여행상품</label> <label
										for="checkbox-2"><input type="checkbox"
										name="checkbox-2 ">해외호텔</label> <label for="checkbox-3"><input
										type="checkbox" name="checkbox-3 ">국내숙박</label>
								</form>
							</div>
							<a href="#" class="btnbox layerOpener"
								data-url="../pop/pop_daysch.html" data-width="300"
								data-height="400"><i
								class="fa fa-exchange fa-rotate-90 mtm8"></i>기간조회</a>
							<ul data-role="listView" class="pd10">
								<li>
									<div data-role="collapsible" data-iconpos="right"
										data-theme="e" data-collapsed="false">
										<h3 class="ui-alt-icon">프랑스일주 9일</h3>
										<table>
											<colgroup>
												<col width="30%">
												<col width="70%">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row">예약일</th>
													<td>2016년 89월 23일</td>
												</tr>
												<tr>
													<th scope="row">출발일</th>
													<td>2016년 89월 23일</td>
												</tr>
												<tr>
													<th scope="row">총금액</th>
													<td><b class="purple">5,600,000원</b></td>
												</tr>
												<tr>
													<th scope="row">예약상태</th>
													<td>예약완료</td>
												</tr>
												<tr>
													<th scope="row">결제상태</th>
													<td><a href="#">상세보기</a></td>
												</tr>
											</tbody>
										</table>
									</div>
								</li>
								<li>
									<div data-role="collapsible" data-iconpos="right"
										data-theme="e">
										<h3 class="ui-alt-icon">프랑스일주 9일</h3>
										<table>
											<colgroup>
												<col width="30%">
												<col width="70%">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row">예약일</th>
													<td>2016년 89월 23일</td>
												</tr>
												<tr>
													<th scope="row">출발일</th>
													<td>2016년 89월 23일</td>
												</tr>
												<tr>
													<th scope="row">총금액</th>
													<td><b class="purple">5,600,000원</b></td>
												</tr>
												<tr>
													<th scope="row">예약상태</th>
													<td>예약완료</td>
												</tr>
												<tr>
													<th scope="row">결제상태</th>
													<td><a href="#">상세보기</a></td>
												</tr>
											</tbody>
										</table>
									</div>
								</li>
								<li>
									<div data-role="collapsible" data-iconpos="right"
										data-theme="e">
										<h3 class="ui-alt-icon">프랑스일주 9일</h3>
										<table>
											<colgroup>
												<col width="30%">
												<col width="70%">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row">예약일</th>
													<td>2016년 89월 23일</td>
												</tr>
												<tr>
													<th scope="row">출발일</th>
													<td>2016년 89월 23일</td>
												</tr>
												<tr>
													<th scope="row">총금액</th>
													<td><b class="purple">5,600,000원</b></td>
												</tr>
												<tr>
													<th scope="row">예약상태</th>
													<td>예약완료</td>
												</tr>
												<tr>
													<th scope="row">결제상태</th>
													<td><a href="#">상세보기</a></td>
												</tr>
											</tbody>
										</table>
									</div>
								</li>
							</ul>
						</div>
						<div class="more mgT10">
							<a href="#"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
						</div>
					</div>
					<div data-role="collapsible" data-iconpos="right" class="mgT10">
						<h1 class="ui-nodisc-icon ui-alt-icon">취소내역</h1>
						<div class="listContent" style="width: 100%">
							<ul data-role="listView">
								<li>
									<div data-role="collapsible" data-iconpos="right"
										data-theme="e" data-collapsed="false">
										<h3 class="ui-alt-icon">프랑스일주 9일</h3>
										<table>
											<colgroup>
												<col width="30%">
												<col width="70%">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row">예약일</th>
													<td>2016년 89월 23일</td>
												</tr>
												<tr>
													<th scope="row">출발일</th>
													<td>2016년 89월 23일</td>
												</tr>
												<tr>
													<th scope="row">총금액</th>
													<td><b class="purple">5,600,000원</b></td>
												</tr>
												<tr>
													<th scope="row">예약상태</th>
													<td>예약완료</td>
												</tr>
												<tr>
													<th scope="row">결제상태</th>
													<td><a href="#">상세보기</a></td>
												</tr>
											</tbody>
										</table>
									</div>
								</li>
								<li>
									<div data-role="collapsible" data-iconpos="right"
										data-theme="e">
										<h3 class="ui-alt-icon">프랑스일주 9일</h3>
										<table>
											<colgroup>
												<col width="30%">
												<col width="70%">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row">예약일</th>
													<td>2016년 89월 23일</td>
												</tr>
												<tr>
													<th scope="row">출발일</th>
													<td>2016년 89월 23일</td>
												</tr>
												<tr>
													<th scope="row">총금액</th>
													<td><b class="purple">5,600,000원</b></td>
												</tr>
												<tr>
													<th scope="row">예약상태</th>
													<td>예약완료</td>
												</tr>
												<tr>
													<th scope="row">결제상태</th>
													<td><a href="#">상세보기</a></td>
												</tr>
											</tbody>
										</table>
									</div>
								</li>
								<li>
									<div data-role="collapsible" data-iconpos="right"
										data-theme="e">
										<h3 class="ui-alt-icon">프랑스일주 9일</h3>
										<table>
											<colgroup>
												<col width="30%">
												<col width="70%">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row">예약일</th>
													<td>2016년 89월 23일</td>
												</tr>
												<tr>
													<th scope="row">출발일</th>
													<td>2016년 89월 23일</td>
												</tr>
												<tr>
													<th scope="row">총금액</th>
													<td><b class="purple">5,600,000원</b></td>
												</tr>
												<tr>
													<th scope="row">예약상태</th>
													<td>예약완료</td>
												</tr>
												<tr>
													<th scope="row">결제상태</th>
													<td><a href="#">상세보기</a></td>
												</tr>
											</tbody>
										</table>
									</div>
								</li>
							</ul>
						</div>
						<div class="more mgT10">
							<a href="#"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
						</div>
					</div>
					<!-- 모바일 2차 자유여행 -->

					<div data-role="collapsible" data-iconpos="right" class="mgT10"
						data-collapsed="false">
						<h1 class="ui-nodisc-icon ui-alt-icon">자유여행 예약내역</h1>
						<div class="listContent" style="width: 100%">
							<ul data-role="listView">
								<li>
									<div class="free_myt_part">
										<h3 class="free_myt_title1 ellipsis">예약코드 : DY123456789 /
											예약일 : 2016.1212</h3>
										<div class="fr_myt_gbox1">
											<span class="app_end_box">예약완료</span> <span
												class="pay_end_box">결제완료</span> <span class="pay_no_box">미결제</span>
											<button type="button" data-role="none">상세보기</button>
										</div>
										<dl class="fr_myt_gbox2">
											<dt class="ft_myy_ico1">서울(인천) - 괌 - 서울(인천)</dt>
											<dd>
												<span>확정</span>
												<p>출발 : yyyy.mm.dd / 귀국 : 2017.03.10</p>
												<p>성인 1명, 소아1명</p>
												<div>1,222,000원</div>
											</dd>
											<dt class="ft_myy_ico2">Gracery Hotel Shinjuku</dt>
											<dd>
												<span>확정</span>
												<p>체크인 : yyyy.mm.dd / 체크아웃 : 2017.03.10</p>
												<p>객실 2개, 성인 3명, 소아1명</p>
												<div>1,222,000원</div>
											</dd>
											<dt class="ft_myy_ico3">A CHEVROLET SPARK OR SIMILAR</dt>
											<dd>
												<p>체크인 : yyyy.mm.dd / 체크아웃 : 2017.03.10</p>
												<span>확정</span>
												<div>1,222,000원</div>
											</dd>
										</dl>
										<ul class="fr_myt_gbox3">
											<li>프로모션 할인명1 <span>-0원</span></li>
											<li>프로모션 할인명1 <span>-0원</span></li>
											<li class="frmyt_allprice">총 결제예정금액 <span>9,999,000원</span></li>
											<li><button type="button" data-role="none">항공
													E-Ticket</button>
												<button type="button" data-role="none">호텔 바우처</button>
												<button type="button" data-role="none">렌터카 바우처</button></li>
										</ul>
									</div>
								</li>
							</ul>
							<div class="more mgT10">
								<a href="#"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
							</div>
						</div>
					</div>

					<div data-role="collapsible" data-iconpos="right" class="mgT10"
						data-collapsed="false">
						<h1 class="ui-nodisc-icon ui-alt-icon">자유여행 취소내역</h1>
						<div class="listContent" style="width: 100%">
							<ul data-role="listView">
								<li>
									<div class="free_myt_part">
										<h3 class="free_myt_title1 ellipsis">예약코드 : DY123456789 /
											예약일 : 2016.1212</h3>
										<div class="fr_myt_gbox1">
											<span class="app_cancel_box">예약취소</span> <span
												class="pay_cancel_box">결제취소</span> <span class="pay_re_box">재결제</span>
											<button type="button" data-role="none">상세보기</button>
										</div>
										<dl class="fr_myt_gbox2">
											<dt class="ft_myy_ico1">서울(인천) - 괌 - 서울(인천)</dt>
											<dd>
												<span>확정</span>
												<p>출발 : yyyy.mm.dd / 귀국 : 2017.03.10</p>
												<p>성인 1명, 소아1명</p>
												<div>1,222,000원</div>
											</dd>
											<dt class="ft_myy_ico2">Gracery Hotel Shinjuku</dt>
											<dd>
												<span>확정</span>
												<p>체크인 : yyyy.mm.dd / 체크아웃 : 2017.03.10</p>
												<p>객실 2개, 성인 3명, 소아1명</p>
												<div>1,222,000원</div>
											</dd>
											<dt class="ft_myy_ico3">A CHEVROLET SPARK OR SIMILAR</dt>
											<dd>
												<p>체크인 : yyyy.mm.dd / 체크아웃 : 2017.03.10</p>
												<span>확정</span>
												<div>1,222,000원</div>
											</dd>
										</dl>
										<ul class="fr_myt_gbox3">
											<li>프로모션 할인명1 <span>-0원</span></li>
											<li>프로모션 할인명1 <span>-0원</span></li>
											<li class="frmyt_allprice">총 결제예정금액 <span>9,999,000원</span></li>
											<li><button type="button" data-role="none">항공
													E-Ticket</button>
												<button type="button" data-role="none">호텔 바우처</button></li>
										</ul>
									</div>
								</li>
							</ul>
							<div class="more mgT10">
								<a href="#"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
							</div>
						</div>
					</div>


				</div>
				<!--#tab1 End-->
			</div>
			<!--//L.POINT 회원 로그인 Tab-->
			<!--비회원 예약확인 Tab-->
			<div id="tab2" class="tabContent">
				<div class="contentBox">
					<!--tab2 Start-->
					<div data-role="collapsible" data-iconpos="right"
						data-collapsed="false">
						<h1 class="ui-nodisc-icon ui-alt-icon">찜내역</h1>
						<ul class="selectDel">
							<li><a href="#" data-rel="none">선택삭제</a></li>
							<li><a href="#" data-rel="none">전체삭제</a></li>
						</ul>

						<div class="listContent" style="width: 100%">
							<ul data-role="listView" class="img">
								<li><a href="#">
										<div class="check_jjip">
											<input type="checkbox" id="agreement01"> <label
												for="agreement01"></label>
										</div> <span class="img"
										style="background: url(/resources/images/images/img/item1.jpg)"></span>
										<h3>3大 크루즈 베르겐+탈린+러시아탈린+러시아탈린+러시아</h3> <span class="holedate">여행기간
											:10박 12일</span> <span class="startday">이용항공 : <img
											src="/resources/images/images/ico/air_KE.png" class="img mgL5"></span> <span
										class="money"><i>3,099,000</i>원~</span>
								</a></li>
								<li><a href="#">
										<div class="check_jjip">
											<input type="checkbox" id="agreement02"> <label
												for="agreement02"></label>
										</div> <span class="img"
										style="background: url(/resources/images/images/img/item2.jpg)"></span>
										<h3>3大 크루즈 베르겐+탈린+러시아</h3>
										<span class="holedate">여행기간 :10박 12일</span> <span
										class="startday">이용항공 : <img
											src="/resources/images/images/ico/air_KE.png" class="img mgL5"></span> <span
										class="money"><i>3,099,000</i>원~</span>
								</a></li>
								<li><a href="#">
										<div class="check_jjip">
											<input type="checkbox" id="agreement03"> <label
												for="agreement03"></label>
										</div> <span class="img"
										style="background: url(/resources/images/images/img/item3.jpg)"></span>
									<h3>3大 크루즈 베르겐+탈린+러시아</h3>
										<span class="holedate">여행기간 :10박 12일</span><span
										class="startday">이용항공 : <img
											src="/resources/images/images/ico/air_KE.png" class="img mgL5"></span><span
										class="money"><i>3,099,000</i>원~</span>
								</a></li>
							</ul>
						</div>
						<div class="more mgT10">
							<a href="#"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
						</div>
					</div>
					<div data-role="collapsible" data-iconpos="right">
						<h1 class="ui-nodisc-icon ui-alt-icon">최근본상품</h1>
						<div class="listContent" style="width: 100%">
							<ul data-role="listView" class="img">
								<li><a href="#"> <span class="img"
										style="background: url(/resources/images/images/img/item1.jpg)"></span>
										<h3>3大 크루즈 베르겐+탈린+러시아</h3> <span class="holedate">여행기간
											:10박 12일</span> <span class="startday">이용항공 : <img
											src="/resources/images/images/ico/air_KE.png" class="img mgL5"></span> <span
										class="money"><i>3,099,000</i>원~</span>
								</a></li>
								<li><a href="#"> <span class="img"
										style="background: url(/resources/images/images/img/item2.jpg)"></span>
										<h3>3大 크루즈 베르겐+탈린+러시아</h3>
										<span class="holedate">여행기간 :10박 12일</span> <span
										class="startday">이용항공 : <img
											src="/resources/images/images/ico/air_KE.png" class="img mgL5"></span> <span
										class="money"><i>3,099,000</i>원~</span>
								</a></li>
								<li><a href="#"><span class="img"
										style="background: url(/resources/images/images/img/item3.jpg)"></span>
									<h3>3大 크루즈 베르겐+탈린+러시아</h3>
										<span class="holedate">여행기간 :10박 12일</span><span
										class="startday">이용항공 : <img
											src="/resources/images/images/ico/air_KE.png" class="img mgL5"></span><span
										class="money"><i>3,099,000</i>원~</span></a></li>
							</ul>
						</div>
						<div class="more mgT10">
							<a href="#"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
						</div>
					</div>
				</div>
				<!--#tab2 End-->
			</div>
			<!--//비회원 예약확인 Tab-->
			<!--참여내역 Tab-->
			<div id="tab3" class="tabContent">
				<div class="contentBox bdBox">
					<!--tab3 Start-->
					<div data-role="collapsible" data-iconpos="right"
						data-collapsed="false">
						<h1 class="ui-nodisc-icon ui-alt-icon">이벤트내역</h1>
						<div class="listContent" style="width: 100%">
							<ul data-role="listView" class="list">
								<li><a href="#"><h3>
											<span class="gray">당첨자발표</span>7월 여행후기 당첨자 발표
										</h3>
										<em>2016-08-02~2016-08-15</em></a></li>
								<li><a href="#"><h3>
											<span class="gray">당첨자발표</span>7월 여행후기 당첨자 발표
										</h3>
										<em>2016-08-02~2016-08-15</em></a></li>
								<li><a href="#"><h3>
											<span class="gray">당첨자발표</span>7월 여행후기 당첨자 발표
										</h3>
										<em>2016-08-02~2016-08-15</em></a></li>
							</ul>
						</div>
						<div class="more mgT10">
							<a href="#"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
						</div>
					</div>
					<div data-role="collapsible" data-iconpos="right">
						<h1 class="ui-nodisc-icon ui-alt-icon">상담문의</h1>
						<div class="listContent" style="width: 100%">
							<ul data-role="listView" class="list">
								<li><a href="#"><h3>7월 여행후기 당첨자 발표</h3>
										<em>2016-08-02~2016-08-15</em><span class="fin">상담진행</span></a></li>
								<li><a href="#"><h3>7월 여행후기 당첨자 발표</h3>
										<em>2016-08-02~2016-08-15</em><span class="wait">상담완료</span></a></li>
								<li><a href="#"><h3>7월 여행후기 당첨자 발표</h3>
										<em>2016-08-02~2016-08-15</em><span class="wait">상담완료</span></a></li>
							</ul>
						</div>
						<div class="more mgT10">
							<a href="#"><i class="fa fa-angle-down fa-2x"></i>더보기</a>
						</div>
					</div>
				</div>
				<!--#tab3 End-->
			</div>
			<!--//참여내역 Tab-->
			<!--정보관리 Tab-->
			<div id="tab4" class="tabContent">
				<div class="contentBox pd1EM bdBox">
					<!--tab4 Start-->
					<ul class="bg_icon_01 bdBox">
						<li class="bg_01"><a href="#">회원정보변경</a></li>
						<li class="bg_02"><a href="#">비밀번호변경</a></li>
					</ul>
					<div class="more">회원탈퇴</div>
				</div>
				<!--#tab4 End-->
			</div>
			<!--//정보관리 Tab-->
			<!--bottom-->
			<script src="/resources/common/bottom.js"></script>
			<!--bottom-->
		</div>
		<!--tabs End-->
	</div>
	<!--//contentWrap End-->
	<!--//content-->