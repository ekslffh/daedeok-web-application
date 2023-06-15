<%@ page language="java"
    pageEncoding="UTF-8"%>
<%--
	// 1. A 를 대상으로 발생한 요청 접수
	String path = "/07/dest.jsp";
	RequestDispatcher rd = request.getRequestDispatcher(path);
	// 2-1. 1번의 요청을 가지고 분기. - request dispatch, forward
	request.setAttribute("requestAttr", "요청 속성");
	rd.forward(request, response);
	// 2-2. 1번의 요청을 가지고 분기. - request dispatch, include
// 	rd.include(request, response);
	//3. B로부터 복귀
	//4. A+B 의 응답 전송
--%>
<%
	// 1. A 를 대상으로 발생한 요청 접수
	// 2. body 가 없는 response 전송(302, location)
	request.setAttribute("requestAttr", "요청 속성");
	session.setAttribute("sessionAttr", "세션 속성");
	String location = request.getContextPath() + "/07/dest.jsp?param=" + request.getParameter("param");
	response.sendRedirect(location);
%>
<h4>이 문장이 보이는지 확인</h4>