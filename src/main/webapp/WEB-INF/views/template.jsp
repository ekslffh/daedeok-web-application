<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
// 	request.getRequestDispatcher("").include(reqeust, response);
	pageContext.include("/includee/preScript.jsp");
%>
</head>
<body>
<%
	String contentPage = (String) request.getAttribute("contentPage");
	pageContext.include(contentPage);
%>
</body>
</html>