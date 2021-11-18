<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">

		// 초기화
		var fn_init = function() {			
			if(location.hash == "#tab2"){
				$("#nav_tab2").click();
			}else if(location.hash == "#tab1"){
				$("#nav_tab1").click();
			}
		};
		
		/* *************************************************************************** */
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
		
		function fn_couponPop(val){
			var txt1 = $("#giveDate"+val).text();
			var txt2 = $("#giveStore"+val).text();
			
			document.location.href = "/customer/couponPop.do#"+ encodeURI(txt1) +"#"+ encodeURI(txt2)+"#"+val;
			//document.location.href = "/customer/couponPop.do";
		}
		
		function fn_tabClick(type){
			if(type == 1){
				window.location.replace(location.pathname + "#tab1");
				
				setTimeout(function(){
					$("#nav_tab1").addClass('ui-btn-active');
				}, 50);
			}else if(type == 2){
				window.location.replace(location.pathname + "#tab2");
				
				setTimeout(function(){
					$("#nav_tab2").addClass('ui-btn-active');
				}, 50);
			}
		}
		
				
		// 버튼 초기화
		var fn_initButton = function() {
		};
		
		$(document).ready(function(){
		
			fn_init();
			fn_initButton();
			
			/*document.addEventListener("deviceready", function(){
				fn_init();
			}, false);*/
		});
		
		function fn_move(url){
			moveLink(url, '_system');
		}
	
</script>
</head>
<body>
<!--content-->    
	<div role="main" class="ui-content contentWrap">
		<div data-role="navbar" data-iconpos="right" class="nav">
			<ul>
				<!-- <li><a href="#navPop"  data-rel="popup" data-icon="carat-d" class="ui-nodisc-icon ui-alt-icon">고객센터</a></li> -->
				<li><a href="#" class="layerOpener ui-btn-active ui-nodisc-icon ui-alt-icon" data-icon="carat-d" data-url="/customerPop.do" data-width="300" data-height="400" data-ok="yes" data-ctn="full">고객센터</a></li>
			</ul>  
		</div>
	   <div class="customer coupon">
		 <div data-role="navbar" class="tabsnav mgT10">
			<ul>				
			  <li><a href="javascript:fn_goNoticeList();" data-theme="a" data-ajax="false">공지사항</a></li>
			  <li><a href="javascript:fn_goFaqList();" data-theme="a" data-ajax="false" class="letterS">자주찾는질문</a></li>
			  <li><a href="javascript:fn_goQnaList();" data-theme="a" data-ajax="false">묻고답하기</a></li>
			  <li><a href="javascript:fn_goCouponList()" data-theme="a" data-ajax="false" class="ui-btn-active">상품권/쿠폰</a></li>
			</ul>
		 </div>
		 <div data-role="tabs">
			 <div data-role="navbar" class="tabsnav nav2 mgT10">
				<ul>
				  <li><a href="#tab1" data-theme="a" data-ajax="false" id="nav_tab1" onclick="fn_tabClick(1)" class="ui-btn-active"><span class="evt"></span>여행상품권 안내</a></li>
				  <li><a href="#tab2" data-theme="a" data-ajax="false" id="nav_tab2" onclick="fn_tabClick(2)"><span class="evt"></span>제휴 우대쿠폰</a></li>
				</ul>
			 </div>
			 <div id="tab1" class="tabContent">
			 	<div class="contentBox bg">
				  	<p class="img"><img src="/resources/images/img/img_banner.png" alt=""/></p>
				  	<p class="img pd"><img src="/resources/images/img/img_coupon.png" alt=""/></p>
				  	<p class="txt_box align-c pd">여행상품권은 <span class="point">10만원,30만원,50만원,100만원권</span> 총 4종으로 준비되어 있습니다.</p>
				  </div>
				  <div class="contentBox bgf">
				 	<ul><li>이용상품: 해외여행,국내여행 및 항공권 등에 적용(일부 상품 제한 가능)</li><li>본 여행상품권은 롯데제이티비에서 사용하실 수 있으며, 발행번호가 없는 상품권은 인정되지 않습니다.</li><li>본 여행권은 현금으로 교환되지 않습니다. 또한 여행 상품권 한도액보다 적게 사용하신 경우라도 차액은 현금으로 환불되지 않고, 차액만큼 여행상품권으로 재발급되오니 이점 유의해 주시기 바랍니다.</li><li>상품권 한도금액보다 비싼 여행상품 예약시 추가 금액은 국내 모든 신용카드 및 온라인 입금을 통한 결제가 가능합니다.</li><li>본 여행권은 도난, 분실, 멸실등에 대하여 당사는 책임을 지지 않으며, 훼손되어 식별이 불가능한 경우에는 사용할 수 없습니다.</li><li>본 여행권은 별도의 지급보증 없이 롯데제이티비㈜의 신용으로 발행되었습니다.</li><li>상품권 구매문의: 롯데제이티비 고객센터: 02)6313-8000</li></ul>
				 </div>	
			  </div>
			 <div id="tab2" class="tabContent">
				<ul data-role="listView">
					<!-- 
					<li><div data-role="collapsible" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-collapsed="false">
						<h1 class="ui-nodisc-icon ui-alt-icon span"><span class="tlt">면세점</span></h1>			
						 <p>
							 <a href="#">
								 <dl>
									 <dt>
										 <a href="javascript:fn_couponPop(1);" data-ajax="false" data-overlay-theme="a">
										 	<img src="http://www.lottejtb.com/images/img2015/style/coupon_img05.gif" alt="롯데제이티비 구매고객 대상 선불카드 1만원권" />
										 </a>
									 </dt>	
									 <dd id="giveDate1">- 증정기간 : <span>2019년 6월 1일 ~ 12월 31일 까지</span></dd>
									 <dd id="giveStore1">- 대 상 점 : <span>롯데면세점 국내 오프라인 전점</span></dd>
								 </dl>
							 </a>
						 </p>	
					</li>
					 --> 
					<!-- [JEH] 제휴 할인 쿠폰 추가 - 20190925 -->					
					<li><div data-role="collapsible" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-collapsed="false">
						<h1 class="ui-nodisc-icon ui-alt-icon span"><span class="tlt">제휴 할인 쿠폰</span></h1>			
						 <p>
							 <a href="#">
								 <dl>
									 <dt>
										 <a href="javascript:fn_move('https://ap.wifidosirak.com/?lottejtb1')" data-ajax="false" data-overlay-theme="a">
										 	<img src="http://www.lottejtb.com/images/img2015/style/coupon_img06.gif" alt="와이파이도시락 10%할인" />
										 </a>
									 </dt>	
									 <dd>
									 	- 와이파이 관련 문의 : 
									 	<span>고객센터 1566-9070</span>
									 </dd>
									 <dd>
									 	카카오톡 @와이파이도시락<br/>@와이파이도시락장애상담
									 </dd>
								 </dl>
							 </a>
						 </p>		

						 <p class="mgT10">
							 <a href="#">
								 <dl>
									 <dt>
										 <!-- <a href="javascript:moveMenu('/goods/visa.do', 0)" data-ajax="false" data-overlay-theme="a"> -->
										 <a href="javascript:fn_move(' https://magent.myvisa.co.kr/index.asp?cp_userid=AF16BF26&cp_sitecd=1626')" data-ajax="false" data-overlay-theme="a">
										 	<img src="http://www.lottejtb.com/images/img2015/style/coupon_img11.gif" alt="전세계 비자 신청하기" />
										 </a>
									 </dt>	
									 <dd>
									 	- 이용문의 : 
									 	<span>고객센터 1588-0392</span>
									 </dd>
									 <dd>
									 	- 유의사항 : 
									 	<span>각 비자 종류 및 제출 서류 등은 지역별로 상이하오니 신청 과정에서 확인하시기 바랍니다.</span>
									 </dd>
								 </dl>
							 </a>
						 </p>	
						 
						 <p class="mgT10">
							 <a href="#">
								 <dl>
									 <dt>
										<a href="javascript:fn_move('https://tagogayo.co.kr/?ali=jtb')" data-ajax="false" data-overlay-theme="a">
										 	<img src="http://www.lottejtb.com/images/img2015/style/coupon_img13.gif" alt="타고가요" />
										 </a>
									 </dt>	
									 <dd>
									 	- 이용문의 : 
									 	<span>고객센터 1600-5540 / 평일 10시~18시</span>
									 </dd>
									 <dd>
									 	- 서비스 이용 : 
									 	<span>연중무휴 24시간</span>
									 </dd>
								 </dl>
							 </a>
						 </p>	
						 
						 <p class="mgT10">
							 <a href="#">
								 <dl>
									 <dt>
										<a href="javascript:fn_move('https://ltjtb.toursafe.co.kr/main/main.php')" data-ajax="false" data-overlay-theme="a">
										 	<img src="http://www.lottejtb.com/images/img2015/style/coupon_img15.gif" alt="여행자보험" />
										 </a>
									 </dt>	
									 <dd>
									 	- 이용문의 : 
									 	<span>투어세이프 고객센터 18:00~9010</span>
									 </dd>
									 <dd>
									 	- 유의사항 : 
									 	<span>해외 여행자 보험 상품은 출국직전까지 가입 가능합니다.</span>
									 </dd>
								 </dl>
							 </a>
						 </p>							 						 


						 <p class="mgT10">
							 <a href="#">
								 <dl>
									 <dt>
										<a href="javascript:fn_move('https://lottejtb.movv.co/meta/airport')" data-ajax="false" data-overlay-theme="a">
										 	<img src="http://www.lottejtb.com/images/img2015/style/coupon_img14.gif" alt="무브movv" />
										 </a>
									 </dt>	
									 <dd>
									 	- 이용문의 : 
									 	<span>고객센터 1877-2025</span>
									 </dd>
									 <dd>
									 	- 카카오톡 : 
									 	<span> @movv</span>
									 </dd>
								 </dl>
							 </a>
						 </p>	

						 
						 <p class="mgT10">
							 <a href="#">
								 <dl>
									 <dt>
										 <a href="javascript:fn_move('http://store.maaltalk.com/?id=lottejtb')" data-ajax="false" data-overlay-theme="a">
										 	<img src="http://www.lottejtb.com/images/img2015/style/coupon_img09.gif" alt="말톡 해외유심 서비스" />
										 </a>
									 </dt>	
									 <dd>
									 	- 이용 관련 문의 : 
									 	<span>고객센터 070-7918-3000</span>
									 </dd>
									 <dd>
									 	카카오톡 @말톡
									 </dd>
								 </dl>
							 </a>
						 </p>	
						 
						 
					</li>
					
<!-- 					환율우대쿠폰 주석처리-->
					<li><div data-role="collapsible" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-collapsed="false">
						<h1 class="ui-nodisc-icon ui-alt-icon"><span class="tlt">환율 우대 쿠폰</span></h1>
						<p>
							<a href="#">
								<dl>
									<dt>
										 <a href="javascript:fn_couponPop(2);" data-ajax="false" data-overlay-theme="a">
											<img src="http://www.lottejtb.com/images/img2015/style/coupon_img04.gif" alt="우리은행 환율우대" />
										</a>
									</dt>	
									<dd id="giveDate2">- 대상점 : 우리은행 전 영업점 (공항 영업점 제외)</dd>
									<dd id="giveStore2">- 유효기간 :2021년 12월 31일 까지 / 환율우대사유코드(no.59)</dd>
								</dl>
							</a>
						</p>	
						<!--
						<p class="mgT10">
							<a href="#">
								<dl>
									<dt>
										 <a href="javascript:fn_move('https://hanpass.com/exchange?partnerCode=lottejtb')" data-ajax="false" data-overlay-theme="a">
											<img src="http://www.lottejtb.com/images/img2015/style/coupon_img08.gif" alt="롯데제이티비 고객 대상 찾아가는 한패스 최대 90% 환율우대" />
										</a>
									</dt>	
									<dd>
										- 이용 관련 문의 : 고객센터 1522-0767
									</dd>
									<dd>
										- 유의사항 : 온라인으로 환전신청 후 공항에서 신청외화를 배달받는 서비스로, 수령일 기준 30일 전부터 출국 당일 1시간 전까지 신청 가능합니다.
									</dd>
								</dl>
							</a>
						</p>	
						-->
						</div>
					</li>
			   	</ul>
		    </div>			
			 <div class="clauseTel mgT10">
				<h1>부서별 전화문의</h1>
				<p><i>상담시간 </i><span style="margin-top:10px">평일: 08:00~17:00</span></p>
			 </div>
			<div class="clauseTelBox2" >
				<ul>
					<li><p>국내/해외여행문의</p><span>1577-6511</span></li>
					<li><p>항공권상담</p><span>1899-9633</span></li>
					<li><p>기업체여행</p><span>02-6313-8248</span></li>
					<li><p>국내/해외호텔문의</p><span>02-6313-8000</span></li>
				</ul>
			</div>
			<!--bottom-->
			<script src="/resources/common/bottom.js"></script>
			<!--bottom-->
		  </div><!--tabs End-->
	  </div><!--//contentWrap End-->
	<!--//content-->
</body>