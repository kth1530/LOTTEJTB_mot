<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%> 
<head>
<script type="text/javascript">
<%
 
	String url = (String)request.getAttribute("url");
	String ctgname = (String)request.getAttribute("ctgname");
	if(url != null)	
		url = URLDecoder.decode(url, "UTF-8");
%>
	$(document).ready(function() {
		var urlPath = location.search;
		var ctgname = '<%=ctgname%>';
		
		if(urlPath.indexOf('http://m.cp.hotelpass.net') != -1) {
			$("#headTitle").html('해외호텔');
			$("#bottomText").html('본 서비스는 제휴를 통해 운영되며,<br>상품 및 서비스는 호텔패스글로벌(주)의 책임하에 운영되고 있습니다.');
		}else if(urlPath.indexOf('http://www.hotelnjoy.com') != -1 || urlPath.indexOf('http://dht.lottejtb.com') != -1){
		//else if(ctgname == "국내숙소"){
			$("#headTitle").html('국내호텔');
			$("#bottomText").html('본 서비스는 제휴를 통해 운영되며,<br>상품 및 서비스는 호텔엔조이의 책임하에 운영되고 있습니다.');
			
			onLoadResize();
		} else if(ctgname == "버스여행") {
			$("#headTitle").html('버스여행');
		}
	});
	
	function onLoadResize() {
		var params = window.location.search.substring(1).split("&");
		var height;
		for (var i=0, len=params.length; i<len; ++i) {
			var parts = params[i].split("=");
			switch (parts[0])
			{
			case "height":
				height = parseInt(parts[1]);
				break;
			}
		}

		if (typeof(height) == "number") {
	        window.top.hnj_resizeFrame(height);
		}
	}
	
	function hnj_resizeFrame(height){
		var iframe = document.getElementById("NjoyBody");
		iframe.height = height;
	}
</script>
</head>
<body>
<div class="bodyWrap domestic">
	<!-- /header -->
 	<!-- <script src="/resources/common/top.js"></script> -->  
	<!-- /header -->
	<!--content-->
	<div role="main" class="ui-content contentWrap categoryBox">
		<div class="nav mg0 depth1 navstitle">
			<ul id="headTitle">
			</ul> 
		</div>
		<div data-role="navbar" data-iconpos="right" class="tabsnav scTab" style="z-index:10;width:100%">
		 	<%  
		 	 if(ctgname.equals("국내호텔")) {
		 	%>
		 	 <ul class="scrpos1">
			   <li><a href="#"  data-rel="popup" class="ui-nodisc-icon ui-alt-icon" style="background:#7b4eb9;color:#fff"><%=ctgname%></a></li>
			</ul>
			<%
		 	 }	
			%> 
		</div>
		<div  class="iframebox">
			<iframe id="NjoyBody" name="NjoyBody" src='<%=url%>'  frameborder="0" scrolling="yes" style="height:60vh;"></iframe>
			<!--<iframe id="inner" name="inner" src='<%=url%>' frameborder="0" width="100%" height="100%" seamless="seamless" style="position: absolute; top: 0px; left: 0px; height: 100%; width: 1px; min-width: 100%; *width: 100%;overflow:auto;-webkit-overflow-scrolling: touch;" ></iframe>-->
			<div class="frametext" id="bottomText"></div>	
			
		</div>
		<!--category End-->
		<!--bottom-->
		<script src="/resources/common/bottom.js"></script>
		<!--bottom-->
	</div><!--//contentWrap End-->
	
</div><!-- /page -->
</body>