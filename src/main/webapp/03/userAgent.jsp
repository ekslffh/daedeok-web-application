<%@page import="kr.or.ddit.enumpkg.BrowserType"%>
<%@page import="java.text.MessageFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>03/userAgent.jsp</title>
</head>
<body>
<h4><%=request.getHeader("user-agent") %></h4>
<%
	String userAgent = request.getHeader("user-agent");
	BrowserType browser = BrowserType.findBrowserType(userAgent);
	String message = MessageFormat.format("당신의 브라우저는 {0}입니다.", browser.getBrowserName());
%>
<script type="text/javascript">
	alert('<%=message %>'');
</script>
</body>
</html>