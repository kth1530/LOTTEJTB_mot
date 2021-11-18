<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	departDay2 = rnEtMst.getStart_day().substring(0, 4) + "년  " + rnEtMst.getStart_day().substring(4, 6) + "월 " + rnEtMst.getStart_day().substring(6, 8) + "일 (" + rnEtMst.getStart_wday() + ") ";
	if (rnEtMst.getStart_time() != null && !rnEtMst.getStart_time().equals("")) {
		departDay2 = departDay2 + rnEtMst.getStart_time().substring(0, 2) + ":" + rnEtMst.getStart_time().substring(2, 4) + "";
	}

	arrDay2 = rnEtMst.getEnd_day().substring(0, 4) + "년 " + rnEtMst.getEnd_day().substring(4, 6) + "월 " + rnEtMst.getEnd_day().substring(6, 8) + "일  ("  + rnEtMst.getEnd_wday() +") ";
	if (rnEtMst.getEnd_time() != null && !rnEtMst.getEnd_time().equals("")) {
		arrDay2 = arrDay2 + rnEtMst.getEnd_time().substring(0, 2) + ":" + rnEtMst.getEnd_time().substring(2, 4)+"";
	}
%>	
<!-- 중요정보 일괄표시 -->
<div class="tabctn_com sd_info_box sd_info_box4">
	<div class="sd_info4_area">
		<table class="ft_table2">
			<colgroup>
				<col width="29%">
				<col width="21%">
				<col width="25%">
				<col width="25%">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">상품</th>
					<td colspan="3"><%=rnEtMst.getDisp_nm()%></td>
				</tr>
				<tr>
					<th scope="row">여행기간</th>
					<td colspan="3">출발 : <%=departDay2%> ~<br>도착 : <%=arrDay2%></td>
				</tr>
				<tr>
					<th scope="row">상품종류</th>
					<td colspan="3"><%=(rnEtMst.getGoods_join_cd() != null && rnEtMst.getGoods_join_cd().equals("2"))?"연합상품":"단독상품"%></td>
				</tr>
				<tr>
					<th>영업보증보험</th>
					<td><%=(rnEtMst.getBiz_insu_yn() != null && rnEtMst.getBiz_insu_yn().equals("Y"))?"가입":"미가입"%></td>
					<th class="left_bor">기획여행<br>보증보험</th>
<!-- 					[JEH]전부 가입으로 표시 되도록 수정 - 20180807 -->
					<td><%=(rnEtMst.getPkg_insu_yn() != null && rnEtMst.getPkg_insu_yn().equals("Y"))?"가입":"가입"%></td>
				</tr>
			</tbody>
		</table>
	</div>
	<p class="sd_inbox4_abtn">
		<button class="sd_all_btn" data-role="none">모두펼침</button>
	</p>
	<!-- DAY 일정 -->
	<dl class="sd_tahaco sd_trv_price">
		<dt>
			<span>여행경비 총액</span>
		</dt>
		<dd class="pd0">
			<p class="sd_trv4_title">상품가격</p>
			<dl>
				<dt>
					성인 <em>(만 12세 이상)</em>
				</dt>
				<dd>
					<table class="ft_table2 ft_thtd_tc">
						<colgroup>
							<col width="33%">
							<col width="33%">
							<col width="33%">
						</colgroup>
						<tbody>
							<tr>
								<th>기본상품가격</th>
								<th>유류할증료</th>
								<th>제세공과금</th>
							</tr>
							<tr>
								<td><%=CommUtil.decimalFormat(rnEtMst.getAdult_price())%>원</td>
								<td><%=CommUtil.decimalFormat(rnEtMst.getEtc_price1())%>원</td>
								<td>0원</td>
							</tr>
							<tr>
								<td scope="row" colspan="2" class="ftl ft_bdr0">소계</td>
								<td class="ftr f_purple"><%=CommUtil.decimalFormat(rnEtMst.getAdult_price()+rnEtMst.getEtc_price1()) %>원</td>
							</tr>
						</tbody>
					</table>
				</dd>
			</dl>
			<dl>
				<dt>
					아동 <em>(만 12세 미만)</em>
				</dt>
				<dd>
					<table class="ft_table2 ft_thtd_tc">
						<colgroup>
							<col width="33%">
							<col width="33%">
							<col width="33%">
						</colgroup>
						<tbody>
							<tr>
								<th>기본상품가격</th>
								<th>유류할증료</th>
								<th>제세공과금</th>
							</tr>
							<tr>
								<td><%=CommUtil.decimalFormat(rnEtMst.getChild_price())%>원</td>
								<td><%=CommUtil.decimalFormat(rnEtMst.getEtc_price2())%>원</td>
								<td>0원</td>
							</tr>
							<tr>
								<td scope="row" colspan="2" class="ftl ft_bdr0">소계</td>
								<td class="ftr f_purple"><%=CommUtil.decimalFormat(rnEtMst.getChild_price()+rnEtMst.getEtc_price2()) %>원</td>
							</tr>
						</tbody>
					</table>
				</dd>
			</dl>
			<dl>
				<dt>
					유아 <em>(만 2세 미만)</em>
				</dt>
				<dd>
					<table class="ft_table2 ft_thtd_tc">
						<colgroup>
							<col width="33%">
							<col width="33%">
							<col width="33%">
						</colgroup>
						<tbody>
							<tr>
								<th>기본상품가격</th>
								<th>유류할증료</th>
								<th>제세공과금</th>
							</tr>
							<tr>
								<td><%=CommUtil.decimalFormat(rnEtMst.getBaby_price())%>원</td>
								<td><%=CommUtil.decimalFormat(rnEtMst.getEtc_price3())%>원</td>
								<td>0원</td>
							</tr>
							<tr>
								<td scope="row" colspan="2" class="ftl ft_bdr0">소계</td>
								<td class="ftr f_purple"><%=CommUtil.decimalFormat(rnEtMst.getBaby_price()+rnEtMst.getEtc_price3()) %>원</td>
							</tr>
						</tbody>
					</table>
				</dd>
			</dl>
			<p class="sd_trv4_title">현지 필수 경비</p>
			<dl>
				<dt>가이드 기사 경비</dt>
				<dd>
					<table class="ft_table2 ft_tb_tr">
						<colgroup>
							<col width="25%">
							<col width="auto">
						</colgroup>
						<tbody>
							<tr>
								<th>성인</th>
								<td><%=(rnEtMst.getEtc_price_title1() != null)?rnEtMst.getEtc_price_title1():""%></td>
							</tr>
							<tr>
								<th>아동</th>
								<td><%=(rnEtMst.getEtc_price_title2() != null)?rnEtMst.getEtc_price_title2():""%></td>
							</tr>
							<tr>
								<th>유아</th>
								<td><%=(rnEtMst.getEtc_price_title3() != null)?rnEtMst.getEtc_price_title3():""%></td>
							</tr>
						</tbody>
					</table>
					<p class="sd_guide_ico1">유류할증료는 유가와 환율에 따라 변동될 수 있습니다.</p>
				</dd>
			</dl>

			<!-- 다시 아코디언 변경 -->

		</dd>
		<dt>
			<span>최소출발인원 및 수수료 정보</span>
		</dt>
		<dd>
			<table class="ft_table2 ft_tb_tr">
				<colgroup>
					<col width="25%">
					<col width="auto">
				</colgroup>
				<tbody>
					<tr>
						<th>최소출발인원기준</th>
						<td><%=rnEtMst.getMin_inwon()%>명</td>
					</tr>
					<tr>
						<th>취소수수료 부과 기준</th>
						<%
								// 표준 약관 / 국내약관 / 특별 약관 적용 부분 
								if(rnEtMst.getOpt_desc() == null || rnEtMst.getOpt_desc().equals("") || rnEtMst.getOpt_desc().equals("B")) {
						%>	
									<td>표준약관 적용</td>
						<%
								} else if(rnEtMst.getOpt_desc().equals("S")) {
						%>
									<td>특별약관 적용</td>
						<%
								} else if(rnEtMst.getOpt_desc().equals("D")) {
						%>
									<td>국내약관 적용</td>
						<%		
								}
						%>
					</tr>
				</tbody>
			</table>
			<ul class="dotlist2 mt10 mb10">
				<li>최소출발인원 미충족시 여행약관에 따라 여행출발 7일전까지 여행사는 여행계약을 일방적으로 해제하고 여행자에게
					통보할 수 있습니다.</li>
				<li>취소수수료는 계약금 입금일 부터 적용됩니다. 취소 수수료 부과 세부 기준을 반드시 확인하세요.</li>
				<li>특별약관 적용의 경우, 표준약관보다 높은 취소수수료가 부과될 수 있습니다.</li>
			</ul>
		</dd>
		
		<!--[JEH] 여행 대금 결제 안내 추가 - 20190930 -->
		<dt>
			<span>여행 대금 결제 안내</span>
		</dt>
		<dd>
			<ul class="dotlist2 mt10 mb10">
				<li>결제는 카드 또는 현금, 상품권, 포인트 등의 결제가 가능합니다.</br>
				-카드 결제 시, 예약자 본인카드 혹은 여행자 본인카드 이용</br>
				-현금 결제 시, 롯데제이티비 법인명의 지정계좌 혹은 가상계좌 이용</br>
				-상품권 결제는 담당자가 원본 수령 및 확인 후 결제 가능</br>
				*단, 일부 상품에 한하여 결제수단이 제한될 수 있습니다.
				</li>
			</ul>
		</dd>
		
		<!--[JEH] 패키지 상품에 대해서만 내용 추가 - 20190605 -->
		<% 
	if("P".equals(goodsCd.substring(2,3))) {
		
%>
		<dt>
			<span>여행일정 변경에 대한 사전 동의 안내</span>
		</dt>
		<dd>
			<ul class="dotlist2 mt10 mb10">
				<li>본 여행일정은 계약체결 시 일정과 달리 예상치 못한 사정 등이 발생하는 경우 여행자의 사전 동의를 통해 변경 될 수 있습니다.</li>
			</ul>
		</dd>
		<%} %>
		<dt>
			<span>주요확정/미정정보</span>
		</dt>
		<dd>
			<table class="ft_table2 ">
				<colgroup>
					<col width="25%">
					<col width="25%">
					<col width="25%">
					<col width="25%">
				</colgroup>
				<tbody>
					<tr>
						<th>출발</th>
						<td><%=(rnEtMst.getConf_yn() != null && rnEtMst.getConf_yn().equals("Y"))?"확정":"미정"%></td>
						<th>여행일정</th>
						<td><%=(rnEtMst.getConf_land() != null && rnEtMst.getConf_land().equals("Y"))?"확정":"미정"%></td>
					</tr>
					<tr>
						<th>상품가격</th>
						<td>확정</td>
						<th>항공</th>
						<td><%=(rnEtMst.getConf_air() != null && rnEtMst.getConf_air().equals("Y"))?"확정":"미정"%></td>
					</tr>
					<tr>
						<th>숙박</th>
						<td><%=(rnEtMst.getConf_hotel() != null && rnEtMst.getConf_hotel().equals("Y"))?"확정":"미정"%></td>
						<th>가이드</th>
						<td><%=(rnEtMst.getGuide_yn() == null || rnEtMst.getGuide_yn().equals("Y"))?"있음":"없음"%></td>
					</tr>
					<tr>
						<th>인솔자</th>
						<td><%=(rnEtMst.getTc_cnt() > 0)?"동반":"미동반"%></td>
						<th>&nbsp</th>
						<td>&nbsp</td>
					</tr>
				</tbody>
			</table>
		</dd>
<%	
	String shopCnt = "";
	int shopCnt2 = 0;

	if(rnGDCommSchdList.size() > 0) {
		for(int i = 0; i < rnGDCommSchdList.size(); i++) {
			RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDCommSchdList.get(i);

			
			//if(eventCommSchd.getSchd_det_cd() != null && eventCommSchd.getSchd_det_cd().equals("3010") && eventCommSchd.getSeq == 0) { // 쇼핑정보
			if(eventCommSchd.getSchd_det_cd() != null && eventCommSchd.getSchd_det_cd().equals("3010") && eventCommSchd.getSeq() == 0) { // 쇼핑정보
				//shopCnt++;
				shopCnt = eventCommSchd.getSchd_det_cd_val();
			}
			
			if(eventCommSchd.getSchd_det_cd().equals("3010") && eventCommSchd.getSeq() != 0){
				shopCnt2 = shopCnt2+1;
			}
			
		}

		if("".equals(shopCnt)){
			shopCnt = Integer.toString(shopCnt2);
		}
	}

%>		
		<dt>
			<span>쇼핑정보</span>
		</dt>
		<dd>
			<table class="ft_table2 ft_tb_tr">
				<colgroup>
					<col width="35%">
					<col width="auto">
				</colgroup>
				<tbody>
				<tr>
					<th scope="row">쇼핑횟수</th>
					<td><%=shopCnt%>회</td>
				</tr>
				</tbody>
			</table>
			<ul class="dotlist2 mt10">
				<li>쇼핑 품목,장소,소요시간,환불여부 등 세부항목은 상세페이지에서 반드시 확인하세요.</li>
			</ul>
		</dd>	

		<dt>
			<span>여행지 안전정보</span>
		</dt>
		<dd>
			
		<!--[JEH] 괌, 사이판은 API연동 제외 - 20190918 -->
		<% 
			if(("PGP".equals(goodsCd.substring(0,3))) || ("PSP".equals(goodsCd.substring(0,3)))) {
		%>
			<table class="ft_table2">
				<colgroup>
					<col width="35%">
					<col width="auto">
				</colgroup>
				<tbody>

					<%	
						if(rnGDCommSchdList.size() > 0) {
							for(int i = 0; i < rnGDCommSchdList.size(); i++) {
								RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDCommSchdList.get(i);
					
								
								if(eventCommSchd.getSchd_det_cd() != null && eventCommSchd.getSchd_det_cd().equals("3005")) { // 안전정보
					%>				
										<tr>
					<%
									if(eventCommSchd.getSchd_det_cd_val() != null && eventCommSchd.getSchd_det_cd_val().equals("1")) {
					%>
											<th>1단계 여행 유의</th>
					<%
									} else if(eventCommSchd.getSchd_det_cd_val() != null && eventCommSchd.getSchd_det_cd_val().equals("2")) {
					%>
											<th>2단계 여행 자제</th>
					<%
									} else if(eventCommSchd.getSchd_det_cd_val() != null && eventCommSchd.getSchd_det_cd_val().equals("3")) {
					%>
											<th>3단계 철수 권고</th>
					<%
									} else if(eventCommSchd.getSchd_det_cd_val() != null && eventCommSchd.getSchd_det_cd_val().equals("4")) {
					%>
											<th>4단계 여행 금지</th>
					<%
									}
					%>
					<%
									if(eventCommSchd.getSchd_det_cd_val() != null) {
					%>
											<td><%=(eventCommSchd.getSchd_det_cntn() != null)?eventCommSchd.getSchd_det_cntn():""%></td>
										</tr>
					<%
									}
									break;
								}
							}
						}
					%>
									</tbody>
								</table>
								
		<% 
			}else{
		%>
		<c:set var="safety" value="${fn:split(arrCountryNm, ',')}" />
			<c:set var="safetyTrim" value="${fn:split(arrCountryNmTrim, ',')}" />
			<c:forEach var="list" items="${safety}" varStatus="status">
			
			<c:set var="trimText" value="${safetyTrim[status.index]}" />				
			<c:set var="loop_flag" value="false" />
				<ul class="dotlist2 mt10">
					<li style="font-weight: bold;">${list}</li>
				
					<c:forEach var="i" items="${srchSafetyInfo}" varStatus="status">
						<c:if test="${i.error != null}">
							<c:set var="loop_flag" value="true" />
							안전정보를 불러오는 중 오류가 발생했습니다.
						</c:if>
						<c:if test="${not loop_flag}">
							
							<c:if test="${i.countryNameTrim == trimText}">
								<c:set var="loop_flag" value="true" />
								<table class="ft_table2  mt10">
									<colgroup>
										<col width="20%">
										<col width="auto">
									</colgroup>
									<tbody>
										<tr>
											<th class="safety_blue" style="text-align: center;">남색경보</th>
											<td>												
												<c:choose>
													<c:when test="${i.attention != null || i.attentionPartial != null}">
														${i.attention}${i.attentionPartial} - ${i.attentionNote}
													</c:when>
													<c:otherwise>
														해당없음
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
										<tr>
											<th class="safety_yellow" style="text-align: center;">황색경보</th>
											<td>
												<c:choose>
													<c:when test="${i.control != null || i.controlPartial != null}">
														${i.control}${i.controlPartial} - ${i.controlNote}
													</c:when>
													<c:otherwise>
														해당없음
													</c:otherwise>
												</c:choose>	
											</td>
										</tr>
										<tr>
											<th class="safety_red" style="text-align: center;">적색경보</th>
											<td>
												<c:choose>
													<c:when test="${i.limita != null || i.limitaPartial != null}">
														${i.limita}${i.limitaPartial} - ${i.limitaNote}
													</c:when>
													<c:otherwise>
														해당없음
													</c:otherwise>
												</c:choose>	
											</td>
										</tr>
					
									</tbody>
								</table>
							</c:if>
						</c:if>
					</c:forEach>
					
					<c:if test="${not loop_flag}">
						<c:if test="${apiResult == 'Y'}">
							<p class="mt10 ml10"><span class="point_b">경보없음</span> - 여행 경보가 없는 안전한 여행지역입니다.</p>
						</c:if>
						<c:if test="${apiResult != 'Y'}">
							안전정보를 불러오는 중 오류가 발생했습니다.
						</c:if>
					</c:if>
				</ul>
			</c:forEach>
				
		<% 
			}
		%>
			
			
			<div class="btn_one sd_btn_trvsite mt10">
				<a href='http://www.0404.go.kr/m/dev/main.do' target='_blank'><button class="purple2" data-role="none">해외안전여행 사이트</button></a>
			</div>
		</dd>
		
		
		<dt>
			<span>롯데제이티비 행복안전지침</span>
		</dt>
		<dd>

   <div style="width: 990px; top:50px; line-height: 0;">
        <img src="http://www.lottejtb.com/images/img2015/common/covid_safety_01.jpg" width="100%" alt="롯데제이티비 행복안전지침 코로나19 대응편"/>
        <img src="http://www.lottejtb.com/images/img2015/common/covid_safety_02.jpg" width="100%" alt="여행객이 언제 어디서든 지켜야 할 필수 안전지침"/>
        <p style="display:none;">
            백신 맞고 떠나는 여행객이 언제 어디서든 지켜야할 필수 안전지침
            -상시 마스크 필수착용
            -자주 손 씻기,손 소독제 사용
            -다른 사람과 거리두기
            우리의 안전하고 즐거운 여행을 위해 방역활동에 적극적으로 협조해 주세요.
        </p>
        <img src="http://www.lottejtb.com/images/img2015/common/covid_safety_03.jpg" width="100%" alt="여행객이 장소/상황별 지켜야 할 필수 안전지침, 여행 출발 전"/>
        <p style="display:none;">
            백신 맞고 떠나는 여행객이 장소/상황별 지켜야할 필수 안전지침
            여행 출발 전
            -접종 대상자라면 사전에 백신 접종을 해주세요.
            -코로나19 증상 유무를 꼭 파악해 주세요.
            -여행 떠나는 국가별 지침에 따라 백신 접종 관련 서류를 미리 준비해 주세요.
        </p>
        <img src="http://www.lottejtb.com/images/img2015/common/covid_safety_04.jpg" width="100%" alt="교통수단 이용 시(항공/차량)"/>
        <p style="display:none;">
            교통수단 이용 시
            [항공] -체크인 카운터를 이용하기 보다 웹/모바일을 통한 사전 체크인을 활용해 주세요.
            -앞, 뒤 사람과의 간격을 두고 대기 및 이동해 주세요.
            -비행 중 이동을 자제해 주세요.
            [차량] -차량에 착석 시, 좌석 간 거리를 두고 착석해 주세요.
            -방역 된 차량 탑승 후에도, 손 소독제 혹은 손 소독 티슈를 이용해 주세요.
            -전 좌석 안전벨트를 착용하고, 차량이 완전히 정차된 이후 하차해 주세요.
        </p>
        <img src="http://www.lottejtb.com/images/img2015/common/covid_safety_05.jpg" width="100%" alt="숙박시설 이용 시"/>
        <p style="display:none;">
            숙박시설 이용 시
            -체크인/아웃 시, 부대시설 이용 시에는 앞, 뒤사람과의 간격을 유지해 주세요.
            -사전에 호텔의 소독 및 방역 여부를 꼭 확인해 주세요.
            -주기적으로 객실을 환기해 주세요.
            -가급적 공용으로 비치된 어메니티 보다 개인 세면도구, 일회용 어메니티를 사용해 주세요.
            -여권 및 귀중품은 객실 내 금고 혹은 프론트 데스크에 보관해 주세요.(귀중품 분실에 대한 책임은 본인에게 있으므로 분실하지 않도록 잘 관리해 주십시오.
        </p>
        <img src="http://www.lottejtb.com/images/img2015/common/covid_safety_06.jpg" width="100%" alt="식사시설 이용 시"/>
        <p style="display:none;">
            식사시설 이용 시
            -일행과 음식을 나누어 먹지 않고, 개별적으로 식사해 주세요.
            -가급적 식사 시에는 대화를 삼가해 주세요.
            -식사 시간을 제외하고 식사 전과 식사후에는 마스크를 반드시 착용해 주세요.
            -다른 사람과의 자리 간격을 두고 착석해 주세요.
            -식사 시 분실에 대비하여 가방 및 소지품은 의자에 걸지 않고, 무릎 위 혹은 시야에 보이는 곳에 두는 편이 안전합니다.
        </p>
        <img src="http://www.lottejtb.com/images/img2015/common/covid_safety_07.jpg" width="100%" alt="관광지 방문 시"/>
        <p style="display:none;">
            관광지 방문 시
            -입장 시 발열 체크 및 QR코드, 출입 명부 작성 등 방문 기록 인증에 협조해 주세요.
            -환기가 어려운 실내 관광지 및 이용 시설은 가급적 지양해 주세요.
            -관람 및 이동 시 다른 사람과의 간격을 유지해 주세요.
            -다른 사람의 손길이 닿을 수 있는 공용시설 이용 시 한 번 더 손 소독을 해주세요.
            -비상 연락망을 항상 숙지하여, 비상 시 인솔자 및 가이드에게 연락할 수 있도록 합니다.
            -단체 이동 시 대열에서 벗어나지 않도록 유의해야 합니다.
        </p>
        <img src="http://www.lottejtb.com/images/img2015/common/covid_safety_08.jpg" width="100%" alt="자유시간 시"/>
        <p style="display:none;">
            자유 시간 시
            -정해진 일정 외 개별적인 활동으로 발생한 모든 사고는 본인에게 책임이 있으므로 항상 주의해야 합니다.(인솔자 및 가이드의 즉각적인 조치가 이루어질 수 없습니다.)
            -가급적 개별적으로 행동하지 않고, 정확한 이동경로 파악을 위해 가이드에게 사전에 내용을 공유해 주세요.
            -물놀이 시, 반드시 마스크를 착용하고 준비운동을 해야 하며 음주 및 식사 직후에는 물에 들어가지 않도록 합니다.
        </p>
        <div style="width: 100%;">
            <div style="width: 50%; float: left;">
					<img src="http://www.lottejtb.com/images/img2015/common/covid_safety_09_01.jpg" style="cursor:pointer;" onclick="window.open('https://www.0404.go.kr/m/dev/newest_list.do');" width="100%" alt="외교부 해외안전여행 최신 안전소식 바로가기"/>
			</div>
            <div style="width: 50%; float: right;">
					<img src="http://www.lottejtb.com/images/img2015/common/covid_safety_09_02.jpg" style="cursor:pointer;" onclick="window.open('https://m.lottejtb.com/customer/noticeList.do');" width="100%" alt="롯데제이티비 상품 속 국가별 입국 지침 안내 바로가기"/>
			</div> 
        </div>
        <img src="http://www.lottejtb.com/images/img2015/common/covid_safety_10.jpg" width="100%" alt="유의사항"/>
        <p style="display:none;">
            위의 주의사항을 지키지 않아 발생한 안전사고에 대한 책임은 본인에게 있음을 알려드립니다.
            코로나19 감염 대비를 위해 고객 여러분의 적극적인 협조 부탁 드립니다.
            롯데제이티비 고객센터 02-6313-8000
        </p>
    	</div>
    
		</dd>		
		
		

		<dt>
			<span>해외여행자등록제 동행</span>
		</dt>
		<dd>			
			<ul class="dotlist2 mt10 mb10">
				<li>
				해외여행자 인터넷 등록제 '동행' 에 가입시, <br />
				이메일을 통해 국가별 안전정보와 수시로 업데이트되는 안전공지를 받아볼 수 있습니다.  <br />
				또한, 해외에서 사건사고 발생시, '동행'에 남겨진 연락처로 정부가 신속하게 연락을 취할 수 있습니다. <br /><br />

				●'동행' 이용방법 <br />
				-해외여행자가 해외안전여행홈페이지에 신상정보·국내비상연락처·현지연락처·일정 등을 등록 <br />
				-등록된 여행자에게 방문지의 안전정보를 메일로 발송하는 맞춤형 해외여행안전정보제공 <br />
				-등록된 여행자가 사건·사고에 처했을 때 비상연락처·소재지 등 파악을 용이하게 하여 보다 효율적 영사 조력 제공 가능 <br /> <br />

				●인터넷 등록시 제공받을 수 있는 세 가지 이점<br />
				1.인터넷등록과 동시에 목적지의 안전정보를 이메일을 통해 받아볼 수 있습니다.<br />
				이와 함께 수시로 업데이트되는 목적지의 치안상황이나 자연재해 가능성 등의 안전공지 역시 이메일을 통해 확인할 수 있습니다.<br />
				2.해외에서 대규모 재난· 재해가 발생하여 우리 여행객의 안전을 확인해야하는 경우,<br />
				미리 등록한 여행정보와 현지 연락처를 바탕으로 소재파악을 할 수 있습니다.<br />
				3.해외 여행 중 불의의 사고를 당하여 가족에게 사고사실을 알려야 하는 경우,<br />
				재외공관(대사관)에서 미리 등록한 비상연락처를 바탕으로 신속하게 연락을 취할 수 있습니다.<br /><br />

				●'동행' 회원가입<br />
				www.0404.go.kr접속 -> 동행서비스 -> 동행가입<br />
				</li>			
			</ul>
		</dd>

<%	
	String ginno = "";
	if(rnGDCommSchdList.size() > 0) {
		for(int i = 0; i < rnGDCommSchdList.size(); i++) {
			RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDCommSchdList.get(i);
			if(eventCommSchd.getSchd_det_cd() != null && eventCommSchd.getSchd_det_cd().equals("3016") && eventCommSchd.getSeq() == 0) { // 긴급번호
				ginno = eventCommSchd.getSchd_det_cntn();
			}
		}
	}
%>	


		<dt>
			<span>긴급연락처</span>
		</dt>
		
		<!--[JEH] 괌, 사이판은 API연동 제외 - 20190918 -->
		<% 
			if(("PGP".equals(goodsCd.substring(0,3))) || ("PSP".equals(goodsCd.substring(0,3)))) {
		%>
		
		<dd>			
			<ul class="dotlist2 mt10 mb10">
				<li>
					<%=ginno%>				
				</li>
			</ul>
		</dd>
		
		<% 
			}else{
		%>
			
		 <dd id="cont_head">
		 	<c:set var="safety" value="${fn:split(arrCountryNm, ',')}" />
			<c:set var="safetyTrim" value="${fn:split(arrCountryNmTrim, ',')}" />
			<c:forEach var="list" items="${safety}" varStatus="status">
			<c:set var="trimText" value="${safetyTrim[status.index]}" />
			<c:set var="loop_flag" value="false" />
				<ul class="dotlist2 mt10 mb10">
					<li style="font-weight: bold;">${list}</li>
					<c:forEach var="i" items="${srchContactInfo}" varStatus="status">
							<c:if test="${i.error != null}">
								<c:set var="loop_flag" value="true" />
								<p>현지연락처를 불러오는 중 오류가 발생했습니다.</p>
							</c:if>
							<c:if test="${not loop_flag}">
								<c:if test="${i.countryNameTrim == trimText}">
								<c:set var="loop_flag" value="true" />
									<div class="table07 mt10" id="cont_body">				
										${i.contact}						
									</div>
								</c:if>
							</c:if>
					</c:forEach>
					
					<c:if test="${not loop_flag}">						
						<c:if test="${apiContResult != 'Y'}">
							<p>현지연락처를 불러오는 중 오류가 발생했습니다.</p>
						</c:if>
					</c:if>
				</ul>
					
			</c:forEach>
		 </dd>
			
		<% 
			}
		%>
		
		
		
</div>
<!-- 중요정보 일괄표시 -->