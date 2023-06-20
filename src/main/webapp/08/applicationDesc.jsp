<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>08/applicationDesc.jsp</title>
</head>
<body>
<h4> ServletContext(application), <%=application.hashCode() %> </h4>
<pre>
	: 서블릿 컨테이너와 현재 컨텍스트(어플리케이션) 에 대한 정보를 가진 객체.
	
	1. flow control : request dispatch(forward + include)
	<%
// 		RequestDispatcher rd = application.getRequestDispatcher("/");
// 		rd.forward(request, response);
// 		response.sendRedirect(request.getContextPath() + "/");
	%>
	2. context parameter 확보 : <%=application.getInitParameter("mediaFolder") %>
	3. 서블릿 컨테이너 정보 확보 : <%=application.getServerInfo() %>
		<%=application.getMajorVersion() %>.<%=application.getMinorVersion() %>
	4. MIME type 확보 : <%=application.getMimeType("sample.jpg") %>
	<%=application.getMimeType("sample.hwp") %>
	<%--
		if (application.getMajorVersion() >= 3) {
			request.getPart("");
		}
	--%>
	5(*****). 웹 리소스 확보
	<%
		String logicalUrl = "/resources/images/cat1.jpg";
// 		String realPath = application.getRealPath(logicalUrl);
// 		File srcFile = new File(realPath);
		
		String destUrl = "/08/cat1.jpg";
		String destPath = application.getRealPath(destUrl);
		File destFile = new File(destPath);
		
		try (
// 			FileInputStream fis = new FileInputStream(srcFile);
			InputStream fis = application.getResourceAsStream(logicalUrl);
			FileOutputStream fos = new FileOutputStream(destFile);
		) {
			byte[] buffer = new byte[1024];
			int cnt = -1;
			while ((cnt = fis.read(buffer)) != -1) { // EOF 문자 : -1, null
				fos.write(buffer, 0, cnt);
			}
		} 
	%>
	logical : <%=logicalUrl %>
<%-- 	realPath : <%=realPath %> --%>
</pre>
<img src="<%=request.getContextPath() + destUrl %>" />
</body>
</html>