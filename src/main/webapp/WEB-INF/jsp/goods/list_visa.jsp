<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/commTagLib.jsp"%>
<%
// 	String grade = (String) request.getAttribute("grade");

String grade = "";
if(request.getAttribute("grade") != null){
	grade = (String) request.getAttribute("grade");
}
//grade = "그룹직원";
%>
<head>
	
<script type="text/javascript" src="//static.criteo.net/js/ld/ld.js" async="true"></script>
<script type="text/javascript">	

		function ifr_resize(iframe) {
			var innerBody = iframe.contentWindow.document.body;
			var innerHeight = innerBody.scrollHeight + (innerBody.offsetHeight - innerBody.clientHeight);
			document.getElementById("ifr_child").height = innerHeight;
		}
		

</script>
</head>

	<!--content-->
	<div role="main" class="ui-content contentWrap" id="top">
		<div style="height:39px"></div>
		<div  class="list prolist" id="content">
			
			<!-- 리스트 형태 -->
			<div class="tabContent list selWrap" id="tab1">
				<iframe  id="ifr_child" name="ifr_child" frameborder="0" marginheight="0" marginwidth="0"  src="https://magent.myvisa.co.kr/index.asp?cp_userid=AF16BF26&cp_sitecd=1626" style="display: block;width: 100vw;height: 100vh;">
				</iframe>
			</div>
			
			<!--bottom-->
			<script src="/resources/common/bottom.js"></script>
			<!--bottom-->
		</div><!--tabs End-->
	
	</div><!--//contentWrap End-->
