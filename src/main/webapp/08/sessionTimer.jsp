<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>08/sessionTimer.jsp</title>
<jsp:include page="/includee/preScript.jsp"></jsp:include>
</head>
<body>
<h4>타이머1 : <span data-timeout="<%=session.getMaxInactiveInterval() %>" 
				data-msg-flag="true" data-request-url="<%=request.getContextPath() %>/08/sessionDesc.jsp"></span></h4>
<h4>타이머2 : <span data-timeout="150"></span></h4>
</body>
</html>