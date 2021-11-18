<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.net.*"%>
<%@ page import="com.lottejtb.util.*"%>
<%@ page import="com.lottejtb.goods.rn.service.*"%>
<%@ page import="com.lottejtb.comm.util.*"%>	
<%
	// 파일명 : /goods/11st_policy.jsp
	// 설명 : 11번가 제공용 약관 페이지 

	String ctg = (String) request.getAttribute("ctg");
	String goodsCd = (String) request.getAttribute("goodsCd");
	String eventCd = (String) request.getAttribute("eventCd");

	RNETMstVO rnEtMst = (RNETMstVO) request.getAttribute("rnEtMst");
	
%>

<%
		// 표준 약관 / 국내약관 / 특별 약관 적용 부분 
		if(rnEtMst.getOpt_desc() == null || rnEtMst.getOpt_desc().equals("") || rnEtMst.getOpt_desc().equals("B")) {
%>	
						<h5 class="info_title">해외여행 이용약관(공정거래위원회 고시)</h5>
							<ul class="info_list01 mt20">
								<li>제 15조(여행출발 전 계약해제)
									<li class="mt20">여행사 또는 여행자는 여행출발전 이 여행계약을 해제할 수 있습니다.</li>
									<li>이 경우 발생하는 손해액은 ‘소비자피해보상규정’(공정거래위원회 고시)에 따라 배상합니다.</li>
									<ul class="info_list02 mt20">
										<li>1. 여행자의 여행계약 해제 요청이 있는 경우(여행자의 취소 요청시)
											<ul class="info_list03">
												<li>- 여행 개시 30일전까지(~30) 통보시: 계약금 환급</li>
												<li>- 여행 개시 20일전까지(29~20) 통보시: 여행요금의 10% 배상</li>
												<li>- 여행 개시 10일전까지(19~10) 통보시: 여행요금의 15% 배상</li>
												<li>- 여행 개시 8일전까지(9~8) 통보시: 여행요금의 20% 배상</li>
												<li>- 여행 개시 1일전까지(7~1)통보시: 여행요금의 30% 배상</li>
												<li>- 여행 당일 통보시 - 여행요금의 50% 배상</li>
											</ul>
										</li>
										<li class="mt20">2. 여행사의 귀책사유로 취소 통보하는 경우
											<ul class="info_list03">
												<li>- 여행 개시 30일전까지(~30) 통보시: 계약금 환급</li>
												<li>- 여행 개시 20일전까지(29~20) 통보시: 여행요금의 10% 배상</li>
												<li>- 여행 개시 10일전까지(19~10) 통보시: 여행요금의 15% 배상</li>
												<li>- 여행 개시 8일전까지(9~8) 통보시: 여행요금의 20% 배상</li>
												<li>- 여행 개시 1일전까지(7~1)통보시: 여행요금의 30% 배상</li>
												<li>- 여행 당일 통보시 - 여행요금의 50% 배상</li>
											</ul>
										</li>
									</ul>
									<li class="mt20">단, 최저행사인원이 충족되지 않아 불가피하게 기획여행을 실시할 수 없는 경우에는 표준약관 제 9조(최저행사인원 미 충족시 계약해제) 조항에 의거하여 당사가 여행자에게 배상한다.</li>
									
								</li>
								<li class="mt20">제 9조(최저행사인원 미 충족시 계약해제)
									<ul class="info_list02 mt20">
										<li>1. 여행사는 최저행사인원이 충족되지 아니하여 여행계약을 해제하는 경우 여행출발 7일전까지 여행자에게 통지하여야 합니다.</li>
										<li class="mt20">2. 여행사가 여행참가자 수 미달로 전항의 기일내 통지를 하지 아니하고 계약을 해제하는 경우 이미 지급받은 계약금 환급 외에 다음 각 목의 1의 금액을 여행자에게 배상하여야 합니다.
											<ul class="info_list03">
												<li>- 여행출발 1일전까지 통지시 : 여행요금의 30%</li>
												<li>- 여행출발 당일 통지시 : 여행요금의 50%</li>
											</ul>
										</li>
									</ul>									
								</li>
								<li class="mt20">※주의사항
									<ul class="info_list02">
										<li>- 전세기 및 일부 상품은 공정위에서 지정한 여행업 표준약관 제 5조(특약), 제 20조(기타사항)에 의거하여 별도의 보상규정이 적용되오니 상품 구매 시 유의하시기 바랍니다.</li>
										<li>- 약관의 전체 내용은 롯데제이티비 홈페이지에서 확인 가능합니다.(<a href="http://www.lottejtb.com/xhtml/lottejtb/lottejtb_over_provision.html" target="_blank">http://www.lottejtb.com/xhtml/lottejtb/lottejtb_over_provision.html)</a>
										</li>
									</ul>									
								</li>
							</ul>			
<%
		} else if(rnEtMst.getOpt_desc().equals("S")) {
%>
			<%=rnEtMst.getPro_desc()%>
			<%=rnEtMst.getPro_desc2()%>
<%
	    } else if(rnEtMst.getOpt_desc().equals("D")) {
%>
						<h3>표준약관 규정안내</h3>
						<h3>[취소료 규정]</h3>
						<h5 class="info_title">여행 취소시 국내여행표준약관 제 13조 소비자분쟁해결규정에 따라 아래의 비율로 취소료가 부과됩니다.<br />(단, 당사의 귀책사유로 여행출발 취소 경우에도 동일한 규정이 적용됩니다.)</h5>
						
						<ul class="info_list">
							<li>- 여행개시 5일전까지 통보시 : 계약금 환급</li>
							<li>- 여행개시 2일전까지 통보시: 상품가격의 10% 배상</li>
							<li>- 여행개시 1일전까지 통보시: 상품가격의 20% 배상</li>
							<li>- 여행당일 통보시: 상품가격의 30% 배상</li>
						</ul>
<%		
		}
%>

