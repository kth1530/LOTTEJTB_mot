<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.lottejtb.comm.util.*"%>

<script type="text/javascript">
window.onload =function () {

 parent.returnlpayAprvIf('<%=URLDecoder.decode(CommUtil.filterXSS(request.getParameter("data")))%>');     

}
</script>