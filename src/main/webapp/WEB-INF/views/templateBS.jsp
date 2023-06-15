<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
// 	request.getRequestDispatcher("").include(reqeust, response);
	String preScript = (String) request.getAttribute("preScript");
	pageContext.include(preScript);
%>
</head>
<body>
<header>
	<jsp:include page='<%=(String) request.getAttribute("headerMenu") %>' />
</header>
<main>
	<%
		String contentPage = (String) request.getAttribute("contentPage");
		pageContext.include(contentPage);
	%>
</main>
<footer>
	<jsp:include page='<%=(String) request.getAttribute("footer") %>' />
</footer>
<jsp:include page='<%=(String) request.getAttribute("postScript") %>' />
</body>
</html>