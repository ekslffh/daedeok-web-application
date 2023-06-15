<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h4>이동 이후 최종 응답 전송</h4>
<h4>현재 요청의 method : <%=request.getMethod() %></h4>
<h4>전달된 파라미터 : <%=request.getParameter("param") %></h4>
<h4>전달된 요청 속성(request attribute) : <%=request.getAttribute("requestAttr") %></h4>
<h4>전달된 세션 속성(session attribute) : <%=session.getAttribute("sessionAttr") %></h4>
</body>
</html>