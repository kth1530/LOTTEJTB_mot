<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<head>
<script type="text/javascript">
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
</script>
</head>
<body>

	<!--content-->
	<div role="main" class="ui-content contentWrap freesearch">
		<div class="navstitle freeback">
			예약정보<a href="javascript:history.back(-1);">뒤로</a>
		</div>
		<div class="free_reserve collapse fr_rdetail">
			<p class="obj_title2 mt7">
				<span class="ico_info">예약상품정보</span>
			</p>
			<table class="ft_table2 ft_wht">
				<colgroup>
					<col style="width: 30%" />
					<col style="width: 70%" />
				</colgroup>
				<tr>
					<th>인원</th>
					<td>성인 1명, 아동 0명, 유아 0명</td>
				</tr>
				<tr class="tb_purple">
					<th>항공 총 운임</th>
					<td colspan="3">754,100원</td>
				</tr>
			</table>
			<p class="pop_avtitle mt7">항공</p>
			<!-- 간략안내 -->
			<div class="stable_guide2">
				<p class="st2_stext1 ellipsis">서울(인천/김포)</p>
				<p class="st2_text1">ICN</p>
				<p class="st2_gbox"></p>
				<p class="st2_text2">BKK</p>
				<p class="st2_stext2 ellipsis">방콕</p>
			</div>
			<!-- 항공정보 -->
			<ul class="fr_porlist">
				<li><span>출발</span><span><img
						src="/resources/images/ico/air_KE.png" alt="">대한항공 - 편명
						172(일반석), 직항</span>
					<p class="rbtn">확정</p></li>
				<li>
					<ul>
						<li>ICN</li>
						<li>19:55</li>
						<li></li>
						<li>BKK</li>
						<li>19:55</li>
						<li><span>+1D</span></li>
						<li>직항,5시간20분</li>
					</ul>
					<ul>
						<li>ICN</li>
						<li>19:55</li>
						<li></li>
						<li>BKK</li>
						<li>19:55</li>
						<li><span>+1D</span></li>
						<li>경우1,5시간20분</li>
					</ul>
				</li>
			</ul>
			<ul class="fr_porlist">
				<li><span>출발</span><span><img
						src="/resources/images/ico/air_KE.png" alt="">대한항공 - 편명
						172(일반석), 경유1회</span>
					<p class="rbtn">확정</p></li>
				<li>
					<ul>
						<li>ICN</li>
						<li>19:55</li>
						<li></li>
						<li>BKK</li>
						<li>19:55</li>
						<li><span>+1D</span></li>
						<li>직항,5시간20분</li>
					</ul>
					<ul>
						<li>ICN</li>
						<li>19:55</li>
						<li></li>
						<li>BKK</li>
						<li>19:55</li>
						<li><span>+1D</span></li>
						<li>경우1,5시간20분</li>
					</ul>
				</li>
			</ul>
			<table class="ft_table2 ft_tb_tr">
				<colgroup>
					<col style="width: 30%" />
					<col style="width: 70%" />
				</colgroup>
				<tr>
					<th>인원</th>
					<td>성인 1명, 아동 0명, 유아 0명</td>
				</tr>
				<tr class="tb_purple">
					<th>항공 총 운임</th>
					<td colspan="3">754,100원</td>
				</tr>
			</table>
			<p class="txbox4">(유류할증료, 제세공과금 포함)</p>
			<ul class="txbox2">
				<li>유류할증료/제세공과금은 항공사 사정 및 환율변동에 의해 매일 변경되어 발권 시 금액이 변경될 수 있습니다.</li>
			</ul>
			<!-- 호텔 -->
			<p class="pop_htvtitle mt7">호텔</p>
			<dl class="pop_info_list">
				<dt>호텔1</dt>
				<dd>
					<table class="ft_table2 ft_tb_tl">
						<thead>
							<tr>
								<th colspan="2">방콕 샹그릴라 호텔</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>투숙기간</th>
								<td>2016.11.07(월) ~ 2016.11.09(수) 2박</td>
							</tr>
							<tr>
								<th>객실</th>
								<td>
									<p class="purple2">바로확정</p>
									<p>Deluxe Room 조식포함</p>
									<p>객실 2 / 성인 3명, 아동 2명, 유아 0명</p>
								</td>
							</tr>
							<tr>
								<th>합계</th>
								<td class="f_purple">2016.11.01 16:00까지 무료</td>
							</tr>
							<tr>
								<th>총 운임</th>
								<td class="tr"><span class="f_purple">764,400</span> 원</td>
							</tr>
						</tbody>
					</table>
				</dd>
			</dl>
			<dl class="pop_info_list">
				<dt>호텔2</dt>
				<dd>
					<table class="ft_table2 ft_tb_tl">
						<thead>
							<tr>
								<th colspan="2">방콕 샹그릴라 호텔</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>투숙기간</th>
								<td>2016.11.07(월) ~ 2016.11.09(수) 2박</td>
							</tr>
							<tr>
								<th>객실</th>
								<td>
									<p class="purple2">바로확정</p>
									<p>Deluxe Room 조식포함</p>
									<p>객실 2 / 성인 3명, 아동 2명, 유아 0명</p>
								</td>
							</tr>
							<tr>
								<th>합계</th>
								<td class="f_purple">2016.11.01 16:00까지 무료</td>
							</tr>
							<tr>
								<th>총 운임</th>
								<td class="tr"><span class="f_purple">764,400</span> 원</td>
							</tr>
						</tbody>
					</table>
				</dd>
			</dl>
			<p class="txbox4">(TAX, 봉사료 포함)</p>
			<ul class="txbox2">
				<li>예약 후 호텔변경, 박수변경, 일정변경 불가하며 변경을 원하실 경우 취소 후 재 예약 하셔야 합니다. .</li>
			</ul>
			<!-- 렌터카 -->
			<p class="pop_lcvtitle mt7">렌터카</p>
			<dl class="pop_info_list">
				<dt>렌터카1</dt>
				<dd>
					<ul class="lc_acodion_info">
						<li class="on"><div>
								<span>A chevrolet spark</span><span>or similar</span>
							</div>
							<p>소형차(Economy)</p></li>
						<li>
							<ul>
								<li>승객수 : 4명</li>
								<li>수화물 개수 : 2개</li>
								<li>에어컨 : 있음</li>
								<li>변속기 : 자동</li>
								<li>연료 : 휘발유</li>
								<li>연비 : 15km/리터</li>
								<li>에어백 : 듀얼</li>
								<li>주행거리제한 : 무제한</li>
							</ul>
						</li>
					</ul>
					<table class="ft_table2 ft_tb_tl">
						<tr>
							<th>차량 인수일</th>
							<td>2016.11.07(월) 13:00</td>
						</tr>
						<tr>
							<th>차량 반납일</th>
							<td>2016.11.10(목) 13:00</td>
						</tr>
						<tr>
							<th>인수 장소</th>
							<td>방콕 공항</td>
						</tr>
						<tr>
							<th>반납 장소</th>
							<td>방콕 샹그릴라 호텔</td>
						</tr>
						<tr>
							<th>추가 선택 사항</th>
							<td>
								<ul class="dotlist2">
									<li>승객수 : 4명</li>
									<li>수화물 개수 : 2개</li>
									<li>에어컨 : 있음</li>
									<li>변속기 : 자동</li>
									<li>연료 : 휘발유</li>
									<li>연비 : 15km/리터</li>
									<li>에어백 : 듀얼</li>
									<li>주행거리제한 : 무제한</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th>렌터카 총 운임</th>
							<td class="tr"><span class="f_purple">764,400</span> 원</td>
						</tr>
					</table>
				</dd>
			</dl>
			<dl class="pop_info_list">
				<dt>렌터카2</dt>
				<dd>
					<ul class="lc_acodion_info">
						<li><div>
								<span>A chevrolet spark</span><span>or similar</span>
							</div>
							<p>소형차(Economy)</p></li>
						<li>
							<ul>
								<li>승객수 : 4명</li>
								<li>수화물 개수 : 2개</li>
								<li>에어컨 : 있음</li>
								<li>변속기 : 자동</li>
								<li>연료 : 휘발유</li>
								<li>연비 : 15km/리터</li>
								<li>에어백 : 듀얼</li>
								<li>주행거리제한 : 무제한</li>
							</ul>
						</li>
					</ul>
					<table class="ft_table2 ft_tb_tl">
						<tr>
							<th>차량 인수일</th>
							<td>2016.11.07(월) 13:00</td>
						</tr>
						<tr>
							<th>차량 반납일</th>
							<td>2016.11.10(목) 13:00</td>
						</tr>
						<tr>
							<th>인수 장소</th>
							<td>방콕 공항</td>
						</tr>
						<tr>
							<th>반납 장소</th>
							<td>방콕 샹그릴라 호텔</td>
						</tr>
						<tr>
							<th>추가 선택 사항</th>
							<td>
								<ul class="dotlist2">
									<li>승객수 : 4명</li>
									<li>수화물 개수 : 2개</li>
									<li>에어컨 : 있음</li>
									<li>변속기 : 자동</li>
									<li>연료 : 휘발유</li>
									<li>연비 : 15km/리터</li>
									<li>에어백 : 듀얼</li>
									<li>주행거리제한 : 무제한</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th>렌터카 총 운임</th>
							<td class="tr"><span class="f_purple">764,400</span> 원</td>
						</tr>
					</table>
				</dd>
			</dl>
			<p class="txbox4">(TAX 포함)</p>
			<ul class="txbox2">
				<li>렌터카 금액은 금일 환율 기준이며, 환율변동에 의해 매일 변경될 수 있습니다.</li>
			</ul>
			<!-- 결제 -->
			<dl class="pop_chk_list pop_chk_list2 mt7">
				<dt class="pop_avtitle2">결제금액할인</dt>
				<dd class="pop_paytext1">
					<p>
						항공 <span>0000원</span>
					</p>
					<p>
						호텔 <span>0000원</span>
					</p>
					<p>
						렌터카(후불) <span>0000원</span>
					</p>
					<p class="ppred">
						프로모션 <span>0000원</span>
					</p>
				</dd>
			</dl>
			<p class="pop_avtitle3">
				총 결제예정금액 <span>00000원</span>
			</p>
			<p class="pop_bt_text1">항공: 유류할증료&제세공과금 포함 / 호텔: TAX, 봉사료 포함 렌터카
				: 추가사항 포함</p>
			<!-- 예약자 정보 -->
			<p class="obj_title2 mt7">
				<span class="ico_mem">예약자 정보</span>
			</p>
			<table class="ft_table2 ft_wht">
				<colgroup>
					<col style="width: 28%">
					<col style="width: 72%">
				</colgroup>
				<tbody>
					<tr>
						<th>예약자 이름</th>
						<td>홍길동 / HONG GILDONG</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>1980년 1월 1일</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>lotte@lottejtb.com</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>010-1234-5678</td>
					</tr>
				</tbody>
			</table>
			<p class="obj_title2">
				<span class="ico_mem">여행자 정보</span>
			</p>
			<table class="ft_table2 ft_tb_wht ft_th_tl">
				<colgroup>
					<col style="width: 28%">
					<col style="width: 72%">
				</colgroup>
				<thead>
					<th colspan="2">여행자 정보1</th>
				</thead>
				<tbody>
					<tr>
						<th>예약자 이름</th>
						<td>홍길동 / HONG GILDONG</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>1980년 1월 1일</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>lotte@lottejtb.com</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>010-1234-5678</td>
					</tr>
					<tr>
						<th>여권유무</th>
						<td>있음</td>
					</tr>
					<tr>
						<th>성별</th>
						<td>남자</td>
					</tr>
				</tbody>
			</table>
			<table class="ft_table2 ft_tb_wht ft_th_tl">
				<colgroup>
					<col style="width: 28%">
					<col style="width: 72%">
				</colgroup>
				<thead>
					<th colspan="2">여행자 정보2</th>
				</thead>
				<tbody>
					<tr>
						<th>예약자 이름</th>
						<td>홍길동 / HONG GILDONG</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>1980년 1월 1일</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>lotte@lottejtb.com</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>010-1234-5678</td>
					</tr>
					<tr>
						<th>여권유무</th>
						<td>있음</td>
					</tr>
					<tr>
						<th>성별</th>
						<td>남자</td>
					</tr>
				</tbody>
			</table>
			<!-- 결제정보 -->
			<p class="obj_title2">
				<span class="ico_paym">결제 정보</span>
			</p>
			<!-- 신용카드 결제후 -->
			<table class="ft_table2 ft_th_tl">
				<colgroup>
					<col style="width: 28%">
					<col style="width: 72%">
				</colgroup>
				<tbody>
					<tr>
						<th>결제 수단</th>
						<td>신용카드 / 롯데카드</td>
					</tr>
					<tr>
						<th>결제 금액</th>
						<td>4,568,000원</td>
					</tr>
					<tr>
						<th>결제 일시</th>
						<td>yyyy.mm.dd h:i:s</td>
					</tr>
				</tbody>
			</table>
			<!-- 가상계좌 -->
			<table class="ft_table2 ft_th_tl">
				<colgroup>
					<col style="width: 28%">
					<col style="width: 72%">
				</colgroup>
				<tbody>
					<tr>
						<th>결제 수단</th>
						<td>가상계좌 / 롯데은행 123-456-789-0123</td>
					</tr>
					<tr>
						<th>결제 금액</th>
						<td>4,568,000원</td>
					</tr>
					<tr>
						<th>결제 일시</th>
						<td>입금완료 / yyyy.mm.dd h:i:s</td>
					</tr>
				</tbody>
			</table>
			<!-- 복합결제 -->
			<table class="ft_table2 ft_th_tl">
				<colgroup>
					<col style="width: 28%">
					<col style="width: 72%">
				</colgroup>
				<tbody>
					<tr>
						<th>결제 수단</th>
						<td>복합결제 / 카드+무통장입금</td>
					</tr>
					<tr>
						<th>결제 금액</th>
						<td class="pay_cancel">
							<p>신용카드 : 롯데카드 3,000,000원</p>
							<p>무통장입금 : 1,568,000원</p>

							<p class="f_purple">총 결제금액 : 4,568,000원</p>
						</td>
					</tr>
					<tr>
						<th>결제 일시</th>
						<td>입금완료 / yyyy.mm.dd h:i:s</td>
					</tr>
				</tbody>
			</table>
			<!-- 버튼 -->
			<div class="btn_one air_tbtn addbtn2">
				<button class="white2" data-role="none">결제취소 요청</button>
			</div>
			<div class="btn_one air_tbtn">
				<button class="purple2" data-role="none">메일보내기</button>
			</div>
		</div>
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div>
	<!--//content-->