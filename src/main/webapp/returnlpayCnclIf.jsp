<%@page import="com.lottejtb.comm.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<script type="text/javascript">
window.onload =function () {

 parent.returnlpayCnclIf('<%=CommUtil.filterXSS(request.getParameter("data"))%>');     

}
</script>
<%=CommUtil.filterXSS(request.getParameter("data"))%>
