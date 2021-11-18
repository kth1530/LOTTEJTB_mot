<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 체크사항 -->
<div class="tabctn_com sd_info_box sd_info_box3">
	<p class="sd_inbox3_abtn">
		<button class="sd_all_btn" data-role="none">모두펼침</button>
	</p>
	<dl class="sd_tahaco sd_detail_info">
<%	
	////////////////////////////////////////////////////////////////////// 체크사항 ////////////////////////////////////////////////////////////////////// 		
%>
<%	
	if(rnGDCommSchdList.size() > 0) {
		for(int i = 0; i < rnGDCommSchdList.size(); i++) {
			RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDCommSchdList.get(i);

			String tag = "";
			
			if(eventCommSchd.getSchd_det_cd().equals("2005")) { // 기타사항
				tag = "기타사항";
%>
		<dt>
			<span><%=tag%></span>
		</dt>
		<dd><%=eventCommSchd.getSchd_det_cntn()%></dd>
<%
			}
		}
	}
%>

<% 
	if(rnGDCommSchdList.size() > 0) {
		for(int i = 0; i < rnGDCommSchdList.size(); i++) {
			RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDCommSchdList.get(i);

			String tag = "";
			
			if(eventCommSchd.getSchd_det_cd().equals("3014")) { // 여권/비자 
				tag = "여권/비자";
%>
		<dt>
			<span><%=tag%></span>
		</dt>
		<dd><%=eventCommSchd.getSchd_det_cntn()%></dd>
<%
			}
		}
	}
%>
<% 
	if(rnGDCommSchdList.size() > 0) {
		for(int i = 0; i < rnGDCommSchdList.size(); i++) {
			RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDCommSchdList.get(i);

			String tag = "";
			
			if(eventCommSchd.getSchd_det_cd().equals("3011")) { // 입금계좌번호 
				tag = "입금계좌번호";
%>
		<dt>
			<span><%=tag%></span>
		</dt>
		<dd><%=eventCommSchd.getSchd_det_cntn()%></dd>
<%
			}
		}
	}
%>

<% 
	if(rnGDCommSchdList.size() > 0) {
		for(int i = 0; i < rnGDCommSchdList.size(); i++) {
			RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDCommSchdList.get(i);

			String tag = "";
			
			if(eventCommSchd.getSchd_det_cd().equals("3007")) { // 필수사항
				tag = "필수사항";
%>
		<dt>
			<span><%=tag%></span>
		</dt>
		<dd><%=eventCommSchd.getSchd_det_cntn()%></dd>
<%
			}
		}
	}
%>
<% 
	if(rnGDCommSchdList.size() > 0) {
		for(int i = 0; i < rnGDCommSchdList.size(); i++) {
			RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDCommSchdList.get(i);

			String tag = "";
			
			if(eventCommSchd.getSchd_det_cd().equals("3008")) { // 예약시 유의사항
				tag = "예약시 유의사항";
%>
		<dt>
			<span><%=tag%></span>
		</dt>
		<dd><%=eventCommSchd.getSchd_det_cntn()%>
	
		<!--[JEH] 패키지 상품에 대해서만 내용 추가 - 20190605 -->
		<% 
	if("P".equals(goodsCd.substring(2,3))) {
		
%>
		<br>
		<br>◎ 본 상품은 단체 관광을 위한 목적으로 기획된 패키지 상품으로 일정 중 개별적인 활동(친지방문, 당사와 계약되지 않은 업체조인 등)이 불가합니다.
만약 패키지 기본일정 불참 시에는 일정상 포함된 식사, 특전, 공항 서비스, 공항세 등이 제공되지 않으며, 행사 일정 외 개별 일정으로 인해 발생하는 비용 및 사고에 대한 책임은
개인 부담이므로 이점 양해 바랍니다. 개별적인 일정을 원하실 경우 자유여행상품으로 예약 부탁 드립니다.
		<%} %>
		</dd>
<%
			}
		}
	}
%>

<!--[JEH] 해외여행자보험 추가 - 20190923 -->
		<dt>
			<span>해외여행자보험</span>
		</dt>
		<dd>롯데제이티비의 해외여행보험은 롯데손해보험입니다. 해외여행자보험의 안내 내용은 롯데손해보험의 약관 규정에 근거합니다.<br/>2009년 7월 금융위원회의 실손의료보험에 본인부담금제도가 도입되어 2010년 5월 1일 이후 출발부터 적용 됩니다.
			<div class="sd_info4_area" style="padding: 10px 0;">
				<table summary="플랜명, 플랜변경전, 플랜 변경후 순으로 나타낸 표입니다." class="ft_table2">
					<caption>선택관광명, 1인요금, 소요시간, 내용, 대체일정순으로 나타낸 표</caption>
					<colgroup>
						<col width="40%"/>
						<col width="20%"/>
						<col width="20%"/>
						<col width="20%"/>
					</colgroup>
					<thead>
						<tr class="table_top">
							<th scope="col">플랜적용나이</th>
							<th scope="col">(만)0-14세</th>
							<th scope="col">(만)15-69세</th>
							<th scope="col">(만)70-79세</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>해외여행중상해사망후유장해</td>
							<td class="tc">-</td>
							<td class="tc">1억원</td>
							<td class="tc">1억원</td>
						</tr>
						<tr>
							<td>해외여행중상해후유장해</td>
							<td class="tc">1억원</td>
							<td class="tc">-</td>
							<td class="tc">-</td>
						</tr>
						 <tr>
							<td>상병/질병의료실비(해외)</td>
							<td class="tc">1,000만원</td>
							<td class="tc">1,000만원</td>
							<td class="tc">1,000만원</td>
						</tr>
						<tr>
							<td>상병/질병의료실비(국내)</td>
							<td class="tc" colspan="3">입원1,000만원 / 외래20만원 / 처방조제10만원</td>
						</tr>
						<tr>
							<td>해외여행중질병사망및질병80%이상고도후유장해</td>
							<td class="tc">-</td>
							<td class="tc">1천5백만원</td>
							<td class="tc">-</td>
						</tr>
						<tr>
							<td>해외여행중배상책임</td>
							<td class="tc">1,000만원</td>
							<td class="tc">1,000만원</td>
							<td class="tc">1,000만원</td>
						</tr>
						<tr>
							<td>해외여행중특별비용</td>
							<td class="tc">500만원</td>
							<td class="tc">500만원</td>
							<td class="tc">500만원</td>
						</tr>
						<tr>
							<td>해외여행중휴대품손해</td>
							<td class="tc">총50만원<br/>(점별 20만원 한도)</td>
							<td class="tc">총50만원<br/>(점별 20만원 한도)</td>
							<td class="tc">총50만원<br/>(점별 20만원 한도)</td>
						</tr>
						<tr>
							<td>해외여행중항공기납치일당(1-20일)</td>
							<td class="tc">7만원 / 1일</td>
							<td class="tc">7만원 / 1일</td>
							<td class="tc">7만원 / 1일</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div class="btn_one sd_btn_trvsite mt10" style="text-align: right;">
					<button class="purple2 layerOpener" data-url="/pop/insurance_policy_pop.do" data-ok="yes" data-role='none' style="width: 195px;font-size: 1em;height: 30px;cursor:pointer;">
						<span>해외여행보험 약관 전체보기</span>
					</button>
			</div>
			
			<ul class="dotlist2 mt10 mb10">
				<li style="font-weight: bold;color: red;">임산부 및 노약자, 미성년자의 경우, 해외여행자보험 보장에 일부 제외될 수 있으니 반드시 별도의 약관을 확인하시기 바랍니다.</li>
				<li>의료비 청구인 경우 상기 금융위원회의 개선안에 근거하여 [본인 부담금]을 제외한 치료실비만 보장 됩니다.</li>
				<li>보험금의 청구 기간은 여행종료일로부터 3년 내로 접수하여야 합니다.</li>
				<li>15세 미만자, 심실상실자 또는 심신 박약자의 사망을 보험사고로 한 계약은 무효로 합니다. (상법 732조)</li>
				<li>본 롯데손해보험 플랜은 2016년 7월 11일 가입분부터 적용됩니다.</li>
				<li>연합 및 일부 상품의 경우 여행자 보험의 보험사 및 보상한도가 다를 수 있사오니 예약 시 확인하시기 바랍니다.</li>
				<li>해외 여행 중 상해, 질병 의료비 청구시에는 해외의료기관의 서류가 첨부되어야 합니다.</li>
			</ul>
			
			<span style="color:#cd1d1f">롯데손해보험 해외여행보험 가입자를 위한 24시간 우리말 안내 서비스</span><br/>
			<span style="font-weight: bold;">긴급도움전화:822-3449-3515</span>
				
			<ul class="dotlist2 mt10 mb10">
				<li>해외 여행 중 긴급 상황 시 의료지원, 여행안내, 사고처리안내 서비스를 제공받을 수 있습니다.</li>
				<li>해외현지 콜렉트콜(수신자부담) 서비스번호로 전화를 걸어, 교환원에게 수신자부담으로 전화연결을 요청하시면 무료로 이용할 수 있습니다.</li>
			</ul>
			
		</dd>

	</dl>
</div>
<style>
.pdfobject-container { height: 30rem; border: 1rem solid rgba(0,0,0,.1); }
</style>

<!-- 체크사항 -->