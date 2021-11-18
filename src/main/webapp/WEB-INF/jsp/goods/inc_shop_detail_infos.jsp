<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 상세정보 -->
<div class="tabctn_com sd_info_box sd_info_box1 ps_view">
	<p>
		<button class="sd_all_btn" data-role="none">모두펼침</button>
	</p>
	<dl class="sd_tahaco sd_detail_info">
<%	
	////////////////////////////////////////////////////////////////////// 상품 상세 ////////////////////////////////////////////////////////////////////// 		
	if(rnGDCommSchdList.size() > 0) {
		for(int i = 0; i < rnGDCommSchdList.size(); i++) {
			RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDCommSchdList.get(i);

			String tag = "";
			
			if(eventCommSchd.getSchd_det_cd().equals("3004")) { // 상품특전 
				tag = "상품특전";
%>
		<dt>
			<span><%=tag%></span>
		</dt>
		<dd><%=eventCommSchd.getSchd_det_cntn()%></dd>
<%
					break;
			}
		}
	}
%>
<%	
	if(rnGDCommSchdList.size() > 0) {
		for(int i = 0; i < rnGDCommSchdList.size(); i++) {
			RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDCommSchdList.get(i);

			String tag = "";

			if(eventCommSchd.getSchd_det_cd().equals("3002")) { // 포함사항
				tag = "포함 사항";
%>
		<dt>
			<span><%=tag%></span>
		</dt>
		<dd><%=eventCommSchd.getSchd_det_cntn()%></dd>
<%
					break;
			}
		}
	}
%>
<%	
	if(rnGDCommSchdList.size() > 0) {
		for(int i = 0; i < rnGDCommSchdList.size(); i++) {
			RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDCommSchdList.get(i);

			String tag = "";
			
			// [AS-IS] RN_ET_SCHD_COMM 테이블 내 COMM_CD
			// ADV : 상품 특전 
			if(eventCommSchd.getSchd_det_cd().equals("3003")) { // 불포함 사항
				tag = "불포함 사항";
%>
		<dt>
			<span><%=tag%></span>
		</dt>
		<dd><%=eventCommSchd.getSchd_det_cntn()%></dd>
<%
					break;
			}
		}
	}
%>
<%	
	if(rnGDCommSchdList != null) {
		for(int i = 0; i < rnGDCommSchdList.size(); i++) {
			RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDCommSchdList.get(i);

			String tag = "";
			
			
			if(eventCommSchd.getSchd_det_cd().equals("3015")) { // 기타요금안내
				tag = "기타요금안내";
%>
		<dt>
			<span><%=tag%></span>
		</dt>
		<dd><%=eventCommSchd.getSchd_det_cntn()%></dd>
<%
				break;
			}
		}
	}
%>
	</dl>
</div>
<!-- 상세정보 -->