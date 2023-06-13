<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action='<%=request.getContextPath() %>/image.do'>

		<select name='image' onchange='this.form.submit()'>
		<%
			String folderPath = application.getInitParameter("mediaFolder");
			File folder = new File(folderPath);
			
			String[] imageFiles = folder.list((d, n) -> {
				String mime = application.getMimeType(n);
				return mime != null && mime.startsWith("image/");
			});
			
			for (String tmp : imageFiles) {
		%>
				<option><%=tmp %></option>
		<%
			}
		%>
		</select>
		<button type='submit'>전송</button>
	</form>
</body>
</html>