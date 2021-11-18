<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.net.*"%>
<%@ page import="com.lottejtb.util.*"%>
<%@ page import="com.lottejtb.goods.rn.service.*"%>
<%@ page import="com.lottejtb.comm.util.*"%>	
<%
	// 파일명 : /goods/11st_detail4.jsp
	// 설명 : 11번가 제공용 불포함사항

	String ctg = (String) request.getAttribute("ctg");
	String goodsCd = (String) request.getAttribute("goodsCd");
	String eventCd = (String) request.getAttribute("eventCd");

	List rnGDCommSchdList = (List) request.getAttribute("rnGDCommSchdList");
%>
<script type="text/javascript">
    (function() {
        function resizeParentIframe() {
            if (top === self) {
                return;
            }
            var parentUrl = document.referrer,
                 docHeight = document.body.clientHeight;
            parent.postMessage({
	height: docHeight, 
	targetEl: eFrm
            }, parentUrl);
        }

        window.addEventListener('load', function() {
            resizeParentIframe();

            window.addEventListener('resize', function() {
                setTimeout(function() {
                    resizeParentIframe();
                }, 300);
            }, false);
        }, false);
    }());
</script>
<%	
	if(rnGDCommSchdList != null) {
		for(int i = 0; i < rnGDCommSchdList.size(); i++) {
			RNGDSchdVO eventCommSchd = (RNGDSchdVO) rnGDCommSchdList.get(i);

			String tag = "";
			
			if(eventCommSchd.getSchd_det_cd().equals("3003")) { // 불포함 사항
				tag = "불포함 사항";
%>
		<%=eventCommSchd.getSchd_det_cntn()%>
<%
			}
		}
	}
%>