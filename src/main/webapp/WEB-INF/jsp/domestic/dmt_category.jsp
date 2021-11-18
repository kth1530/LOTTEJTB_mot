<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<%
  	String ctg = request.getParameter("ctg");	
	System.out.println("ctg=" + ctg);
%>
</head>
<body>
<div class="bodyWrap domestic">
<script>
	function fn_alert(){
	  alert("서비스 준비중 입니다.");
	}


</script>
	<!-- /header -->
	<!-- <script src="/resources/common/top.js"></script> -->
	<!-- /header -->
	<!--content-->
	<div role="main" class="ui-content contentWrap categoryBox">
		<div class="nav mg0 navstitle">국내여행</div>
		<div class="category">
			<div class="tabContent category ctgMenu" id="tab1">
				<%
					if(ctg.equals("5807")) {
				%>
				<div data-role="collapsible" data-iconpos="right" data-collapsed="false">
				<%
					} else {
				%>
				<div data-role="collapsible" data-iconpos="right">
				<%
					}
				%>
					<h1 class="ui-nodisc-icon ui-alt-icon">제주도</h1>
					<ul>
						<li><a href="#" data-theme="a" data-ajax="false" class="ui-btn-active" onclick="moveMenu('/goods/list.do?ctg=6118&orderby=01',1)">버스패키지</a></li>
						<!-- 1차에서 제외 제주닷컴 -->
						<li><a href="#" data-theme="a" data-ajax="false" onclick="moveMenu('/goods/list.do?ctg=6301&orderby=01',1)">지방출발</a></li>
					</ul>
				</div>
				<%
					if(ctg.equals("5808")) {
				%>
				<div data-role="collapsible" data-iconpos="right" data-collapsed="false">
				<%
					} else {
				%>
				<div data-role="collapsible" data-iconpos="right">
				<%
					}
				%>
					<h1 class="ui-nodisc-icon ui-alt-icon">내륙/섬</h1>
					<ul>
						<li><a href="#" data-theme="a" data-ajax="false" onclick="moveMenu('/goods/list.do?ctg=6287&orderby=01',1)">버스여행 기획상품</a></li>
						<li><a href="#" data-theme="a" data-ajax="false" onclick="moveMenu('/goods/list.do?ctg=6130&orderby=01',1)">섬여행</a></li>
					</ul>
				</div>
				<%
					if(ctg.equals("5809")) {
				%>
				<div data-role="collapsible" data-iconpos="right" data-collapsed="false">
				<%
					} else {
				%>
				<div data-role="collapsible" data-iconpos="right">
				<%
					}
				%>
				
					<h1 class="ui-nodisc-icon ui-alt-icon">항공</h1>
				</div>
				<%
					if(ctg.equals("5810")) {
				%>
				<div data-role="collapsible" data-iconpos="right" data-collapsed="false">
				<%
					} else {
				%>
				<div data-role="collapsible" data-iconpos="right">
				<%
					}
				%>
					<h1 class="ui-nodisc-icon ui-alt-icon">국내숙박</h1>
					<ul>
						<!--<li><a href="" data-theme="a" data-ajax="false" onclick="moveMenu('/domestic/dmt_detail_domestic.do?url=http://dht.lottejtb.com/alliance/mobile/main.php?AID=LTJTB&ctgname=국내숙소', 1)">국내숙소</a></li>-->
						<li><a href="" data-theme="a" data-ajax="false" onclick="javascrpit:fn_alert();">국내숙소</a></li>
						<!--  <li><a href="#" data-theme="a" data-ajax="false">롯데호텔 &amp; 부여리조트</a></li>-->
					</ul>
				</div>
				<%
					if(ctg.equals("5811")) {
				%>
				<div data-role="collapsible" data-iconpos="right" >
				<%
					} else {
				%>
				<div data-role="collapsible" data-iconpos="right">
				<%
					}
				%>
					<h1 class="ui-nodisc-icon ui-alt-icon" onclick="moveMenu('/goods/list.do?ctg=5811&orderby=01',1)">아! 대한민국</h1>
				</div>
			</div>
			<!--bottom-->
			<script src="/resources/common/bottom.js"></script>
			<!--bottom-->
		</div><!--category End-->
	</div><!--//contentWrap End-->
</div><!-- /page -->
</html>